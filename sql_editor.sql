--Tạo function để nhận lệnh ping
--Do supabase sẽ tự động cho database ngủ dông sau 7 ngày và xóa database sau 90 ngày nên lệnh ping này sẽ tư động ping vào trang web để duy trì database
create or replace function ping()
returns void
language sql
as $$
  select;
$$;
-- Viết lệnh thêm các bảng vào SQL Editor của Supabase

--DROP BẢNG từng tạo trước đó
drop table if exists order_items;
drop table if exists orders;
drop table if exists product_categories;
drop table if exists categories;
drop table if exists products;
drop table if exists tbl_order_items;
drop table if exists tbl_orders;
drop table if exists tbl_products;
drop table if exists tbl_categories;
drop table if exists tbl_users;

--TẠO BẢNG 
--Categories
create table tbl_categories (
  categoryid serial primary key,
  categoryname varchar(100) not null
);
--Add data
insert into tbl_categories (categoryname) values
('Clothing'),
('Electronics'),
('Furniture'),
('Book'),
('Tools'),
('Shoes,Boots,Sneakers');

create table tbl_products (
  productid serial primary key,
  productcode varchar(20) not null,
  productname varchar(200) not null,
  categoryid int not null references tbl_categories(categoryid) on delete cascade,
  price int not null,
  quantity int not null,
  discount int not null,
  description varchar(250) not null,
  image varchar(200) not null default 'product_default.jpg',
  view int not null default 0,
  purchasedate timestamp default current_timestamp,
  purchasecount int not null default 0,
  favoritecount int not null default 0,
  status boolean not null default true，-- 1 = còn hàng, 0 = hết hàng
  userid uuid references auth.users(id)
);

create table tbl_users (
  id uuid primary key references auth.users(id),
  email text,
  phonenumber text; 
  address text;
  role text check (role in ('admin', 'manager', 'user')) default 'user',
  full_name text default 'No name',
  is_blocked boolean default false
);
/*insert into users (id, email, role, full_name)
values
  ('50286233-5912-419c-8fd5-2bb8cea9fc54', 'huykyunh.k@gmail.com', 'admin','Huy Huỳnh Quốc'),
  ('badd3994-cfa7-4717-896a-46a738d9eba5', 'hkhuang07@gmail.com', 'manager','HK Huang'),
  ('e669794d-2d58-4d9b-86a0-5a4856203623', 'linsirui07@gmail.com', 'user','Lâm Tư Thụy');
*/

create table tbl_orders (
  orderid serial primary key,
  orderdate timestamp default current_timestamp,
  userid uuid references auth.users(id) on delete set null on update cascade,
  address text,
  status varchar(50) default 'Pending',
  totalamount numeric(12, 2)
);

create table tbl_order_items (
  orderitemid serial primary key,
  orderid int references tbl_orders(orderid) on delete cascade,
  productid int references tbl_products(productid) on delete set null on update cascade,
  productname varchar(255),
  price numeric(12, 2),
  quantity int
);

CREATE TABLE tbl_cart (
  id SERIAL PRIMARY KEY,
  userid UUID NOT NULL,
  productid INTEGER REFERENCES tbl_products(productid),
  quantity INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT now()
);



INSERT INTO tbl_products 
(productcode, productname, categoryid, price, quantity, discount, description, image, view, favoritecount, status)
VALUES
-- Clothing (1)
('CLO001', 'Men T-Shirt', 1, 100000, 50, 0, 'Cotton T-shirt, size L', 'https://via.placeholder.com/80', 10, 2, true),
('CLO002', 'Women Blouse', 1, 120000, 30, 5, 'Elegant chiffon blouse', 'https://via.placeholder.com/80', 15, 4, true),
('CLO003', 'Unisex Hoodie', 1, 250000, 20, 10, 'Cozy fleece hoodie', 'https://via.placeholder.com/80', 20, 5, true),
('CLO004', 'Denim Jacket', 1, 400000, 10, 15, 'Classic blue denim', 'https://via.placeholder.com/80', 12, 1, true),
('CLO005', 'Shorts', 1, 90000, 60, 0, 'Breathable sports shorts', 'https://via.placeholder.com/80', 18, 3, true),
('CLO006', 'Long Skirt', 1, 200000, 15, 5, 'Pleated long skirt', 'https://via.placeholder.com/80', 25, 6, true),

-- Electronics (2)
('ELE001', 'Wireless Mouse', 2, 150000, 40, 5, 'High-precision wireless mouse', 'https://via.placeholder.com/80', 22, 4, true),
('ELE002', 'Bluetooth Speaker', 2, 350000, 20, 10, 'Portable speaker with bass', 'https://via.placeholder.com/80', 30, 6, true),
('ELE003', 'Mechanical Keyboard', 2, 500000, 15, 0, 'RGB backlit keyboard', 'https://via.placeholder.com/80', 28, 5, true),
('ELE004', 'USB Charger', 2, 90000, 60, 0, 'Fast charging USB-C', 'https://via.placeholder.com/80', 17, 2, true),
('ELE005', 'Tablet 8 inch', 2, 3000000, 8, 15, 'Android tablet', 'https://via.placeholder.com/80', 9, 1, true),
('ELE006', 'Smartwatch', 2, 1200000, 12, 5, 'Fitness tracker features', 'https://via.placeholder.com/80', 21, 3, true),

-- Furniture (3)
('FUR001', 'Wooden Chair', 3, 400000, 10, 0, 'Solid wood dining chair', 'https://via.placeholder.com/80', 12, 2, true),
('FUR002', 'Office Desk', 3, 1200000, 5, 10, '120x60cm working desk', 'https://via.placeholder.com/80', 20, 3, true),
('FUR003', 'Bookshelf', 3, 850000, 6, 5, '5-tier wooden bookshelf', 'https://via.placeholder.com/80', 14, 2, true),
('FUR004', 'Bedside Table', 3, 350000, 8, 0, '2-drawer nightstand', 'https://via.placeholder.com/80', 19, 3, true),
('FUR005', 'Dining Table Set', 3, 3200000, 3, 20, '4 chairs + table', 'https://via.placeholder.com/80', 8, 1, true),
('FUR006', 'Sofa 3-seat', 3, 5800000, 2, 10, 'Comfortable fabric sofa', 'https://via.placeholder.com/80', 6, 1, true),

-- Book (4)
('BOO001', 'The Alchemist', 4, 95000, 50, 0, 'Novel by Paulo Coelho', 'https://via.placeholder.com/80', 33, 6, true),
('BOO002', 'Clean Code', 4, 220000, 20, 0, 'Programming best practices', 'https://via.placeholder.com/80', 19, 4, true),
('BOO003', 'Atomic Habits', 4, 110000, 30, 5, 'Self-improvement book', 'https://via.placeholder.com/80', 22, 5, true),
('BOO004', 'Dune', 4, 130000, 25, 10, 'Science fiction novel', 'https://via.placeholder.com/80', 16, 2, true),
('BOO005', 'Educated', 4, 115000, 15, 0, 'Memoir by Tara Westover', 'https://via.placeholder.com/80', 27, 3, true),
('BOO006', 'Python Crash Course', 4, 250000, 12, 5, 'Learn Python fast', 'https://via.placeholder.com/80', 11, 1, true),

-- Tools (5)
('TOO001', 'Cordless Drill', 5, 850000, 10, 5, 'Rechargeable power drill', 'https://via.placeholder.com/80', 23, 4, true),
('TOO002', 'Hammer 500g', 5, 75000, 30, 0, 'Steel head, wooden handle', 'https://via.placeholder.com/80', 15, 2, true),
('TOO003', 'Screwdriver Set', 5, 120000, 20, 10, '10-piece precision set', 'https://via.placeholder.com/80', 14, 3, true),
('TOO004', 'Wrench Set', 5, 250000, 12, 5, '8 sizes included', 'https://via.placeholder.com/80', 18, 2, true),
('TOO005', 'Electric Sander', 5, 600000, 6, 15, 'Smooth sanding tool', 'https://via.placeholder.com/80', 10, 1, true),
('TOO006', 'Measuring Tape 5m', 5, 50000, 40, 0, 'Lockable with belt clip', 'https://via.placeholder.com/80', 21, 5, true),

-- Shoes,Boots,Sneakers (6)
('SHO001', 'Running Shoes', 6, 450000, 20, 0, 'Lightweight and comfy', 'https://via.placeholder.com/80', 24, 5, true),
('SHO002', 'Leather Boots', 6, 900000, 10, 10, 'Brown high-ankle boots', 'https://via.placeholder.com/80', 16, 3, true),
('SHO003', 'High Heels', 6, 500000, 8, 0, 'Elegant black heels', 'https://via.placeholder.com/80', 13, 2, true),
('SHO004', 'Casual Sneakers', 6, 300000, 25, 5, 'Unisex canvas shoes', 'https://via.placeholder.com/80', 29, 4, true),
('SHO005', 'Slippers', 6, 120000, 30, 0, 'Foam soft sole', 'https://via.placeholder.com/80', 18, 3, true),
('SHO006', 'Basketball Shoes', 6, 850000, 12, 15, 'High grip outsole', 'https://via.placeholder.com/80', 12, 2, true);

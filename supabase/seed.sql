-- eCommerce Clothing Store Seed Data
-- Sample users, categories, products, and reviews

-- Sample Users
INSERT INTO auth.users (
  instance_id,
  id,
  aud,
  role,
  email,
  encrypted_password,
  email_confirmed_at,
  created_at,
  updated_at,
  confirmation_token,
  email_change,
  email_change_token_new,
  recovery_token
) VALUES 
(
  '00000000-0000-0000-0000-000000000000',
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
  'authenticated',
  'authenticated',
  'john@example.com',
  crypt('password123', gen_salt('bf')),
  NOW(),
  NOW(),
  NOW(),
  '',
  '',
  '',
  ''
),
(
  '00000000-0000-0000-0000-000000000000',
  'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
  'authenticated',
  'authenticated',
  'sarah@example.com',
  crypt('password123', gen_salt('bf')),
  NOW(),
  NOW(),
  NOW(),
  '',
  '',
  '',
  ''
)
ON CONFLICT (id) DO NOTHING;

-- Sample Profiles
INSERT INTO public.profiles (id, email, full_name, phone) VALUES
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', 'john@example.com', 'John Anderson', '+1-555-0101'),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', 'sarah@example.com', 'Sarah Mitchell', '+1-555-0102')
ON CONFLICT (id) DO NOTHING;

-- Sample Categories
INSERT INTO public.categories (id, name, slug, description, is_active, display_order) VALUES
('cccccccc-cccc-cccc-cccc-cccccccccccc', 'Men''s Clothing', 'mens-clothing', 'Stylish clothing for men', true, 1),
('dddddddd-dddd-dddd-dddd-dddddddddddd', 'Women''s Clothing', 'womens-clothing', 'Fashionable clothing for women', true, 2),
('eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee', 'Accessories', 'accessories', 'Complete your look with our accessories', true, 3),
('ffffffff-ffff-ffff-ffff-ffffffffffff', 'Outerwear', 'outerwear', 'Jackets, coats, and more', true, 4)
ON CONFLICT (id) DO NOTHING;

-- Sample Products
INSERT INTO public.products (
  id,
  name,
  slug,
  description,
  category_id,
  price,
  compare_at_price,
  sku,
  quantity_in_stock,
  available_sizes,
  available_colors,
  material,
  care_instructions,
  is_active,
  is_featured
) VALUES
(
  '11111111-1111-1111-1111-111111111111',
  'Classic Cotton T-Shirt',
  'classic-cotton-tshirt',
  'Comfortable everyday t-shirt made from 100% organic cotton. Perfect fit and breathable fabric.',
  'cccccccc-cccc-cccc-cccc-cccccccccccc',
  29.99,
  39.99,
  'TSHIRT-001',
  150,
  ARRAY['S', 'M', 'L', 'XL', 'XXL'],
  ARRAY['Black', 'White', 'Navy', 'Gray'],
  '100% Organic Cotton',
  'Machine wash cold, tumble dry low',
  true,
  true
),
(
  '22222222-2222-2222-2222-222222222222',
  'Slim Fit Jeans',
  'slim-fit-jeans',
  'Modern slim fit jeans with stretch denim for comfort. Classic 5-pocket styling.',
  'cccccccc-cccc-cccc-cccc-cccccccccccc',
  79.99,
  99.99,
  'JEANS-001',
  80,
  ARRAY['28', '30', '32', '34', '36'],
  ARRAY['Dark Blue', 'Light Blue', 'Black'],
  '98% Cotton, 2% Elastane',
  'Machine wash cold, hang dry',
  true,
  true
),
(
  '33333333-3333-3333-3333-333333333333',
  'Floral Summer Dress',
  'floral-summer-dress',
  'Light and breezy summer dress with beautiful floral print. Perfect for warm days.',
  'dddddddd-dddd-dddd-dddd-dddddddddddd',
  89.99,
  119.99,
  'DRESS-001',
  60,
  ARRAY['XS', 'S', 'M', 'L', 'XL'],
  ARRAY['Blue Floral', 'Pink Floral', 'Yellow Floral'],
  '100% Rayon',
  'Hand wash cold, lay flat to dry',
  true,
  true
),
(
  '44444444-4444-4444-4444-444444444444',
  'Knit Cardigan Sweater',
  'knit-cardigan-sweater',
  'Cozy cardigan sweater with button closure. Layer over any outfit for warmth.',
  'dddddddd-dddd-dddd-dddd-dddddddddddd',
  69.99,
  89.99,
  'CARD-001',
  45,
  ARRAY['S', 'M', 'L', 'XL'],
  ARRAY['Cream', 'Gray', 'Camel', 'Black'],
  '70% Acrylic, 30% Wool',
  'Hand wash cold, reshape and lay flat to dry',
  true,
  false
),
(
  '55555555-5555-5555-5555-555555555555',
  'Leather Crossbody Bag',
  'leather-crossbody-bag',
  'Genuine leather crossbody bag with adjustable strap. Multiple compartments for organization.',
  'eeeeeeee-eeee-eeee-eeee-eeeeeeeeeeee',
  129.99,
  159.99,
  'BAG-001',
  30,
  ARRAY['One Size'],
  ARRAY['Black', 'Brown', 'Tan'],
  '100% Genuine Leather',
  'Wipe clean with damp cloth',
  true,
  true
),
(
  '66666666-6666-6666-6666-666666666666',
  'Wool Blend Coat',
  'wool-blend-coat',
  'Elegant wool blend coat with tailored fit. Perfect for cold weather.',
  'ffffffff-ffff-ffff-ffff-ffffffffffff',
  199.99,
  249.99,
  'COAT-001',
  25,
  ARRAY['S', 'M', 'L', 'XL'],
  ARRAY['Charcoal', 'Navy', 'Camel'],
  '80% Wool, 20% Polyester',
  'Dry clean only',
  true,
  true
)
ON CONFLICT (id) DO NOTHING;

-- Sample Product Images
INSERT INTO public.product_images (product_id, image_url, alt_text, display_order, is_primary) VALUES
('11111111-1111-1111-1111-111111111111', 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab', 'Classic Cotton T-Shirt Front View', 0, true),
('11111111-1111-1111-1111-111111111111', 'https://images.unsplash.com/photo-1583743814966-8936f5b7be1a', 'Classic Cotton T-Shirt Detail', 1, false),
('22222222-2222-2222-2222-222222222222', 'https://images.unsplash.com/photo-1542272604-787c3835535d', 'Slim Fit Jeans Front View', 0, true),
('22222222-2222-2222-2222-222222222222', 'https://images.unsplash.com/photo-1604176354204-9268737828e4', 'Slim Fit Jeans Detail', 1, false),
('33333333-3333-3333-3333-333333333333', 'https://images.unsplash.com/photo-1572804013309-59a88b7e92f1', 'Floral Summer Dress Front View', 0, true),
('33333333-3333-3333-3333-333333333333', 'https://images.unsplash.com/photo-1595777457583-95e059d581b8', 'Floral Summer Dress Back View', 1, false),
('44444444-4444-4444-4444-444444444444', 'https://images.unsplash.com/photo-1434389677669-e08b4cac3105', 'Knit Cardigan Sweater Front View', 0, true),
('55555555-5555-5555-5555-555555555555', 'https://images.unsplash.com/photo-1590874103328-eac38a683ce7', 'Leather Crossbody Bag', 0, true),
('66666666-6666-6666-6666-666666666666', 'https://images.unsplash.com/photo-1539533018447-63fcce2678e3', 'Wool Blend Coat Front View', 0, true)
ON CONFLICT (id) DO NOTHING;

-- Sample Cart Items
INSERT INTO public.cart_items (user_id, product_id, quantity, size, color) VALUES
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '11111111-1111-1111-1111-111111111111', 2, 'L', 'Black'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '22222222-2222-2222-2222-222222222222', 1, '32', 'Dark Blue')
ON CONFLICT (user_id, product_id, size, color) DO NOTHING;

-- Sample Wishlist Items
INSERT INTO public.wishlists (user_id, product_id) VALUES
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '33333333-3333-3333-3333-333333333333'),
('aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa', '55555555-5555-5555-5555-555555555555'),
('bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb', '66666666-6666-6666-6666-666666666666')
ON CONFLICT (user_id, product_id) DO NOTHING;

-- Sample Orders
INSERT INTO public.orders (
  id,
  user_id,
  order_number,
  status,
  subtotal,
  tax,
  shipping_cost,
  total_amount,
  shipping_address,
  items
) VALUES
(
  '77777777-7777-7777-7777-777777777777',
  'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
  'ORD-20240115-0001',
  'delivered',
  89.99,
  7.20,
  10.00,
  107.19,
  '{"name": "Sarah Mitchell", "street": "123 Main St", "city": "New York", "state": "NY", "zip": "10001", "country": "USA"}',
  '[{"product_id": "33333333-3333-3333-3333-333333333333", "name": "Floral Summer Dress", "quantity": 1, "price": 89.99, "size": "M", "color": "Blue Floral"}]'
),
(
  '88888888-8888-8888-8888-888888888888',
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
  'ORD-20240116-0002',
  'processing',
  109.98,
  8.80,
  10.00,
  128.78,
  '{"name": "John Anderson", "street": "456 Oak Ave", "city": "Los Angeles", "state": "CA", "zip": "90001", "country": "USA"}',
  '[{"product_id": "11111111-1111-1111-1111-111111111111", "name": "Classic Cotton T-Shirt", "quantity": 2, "price": 29.99, "size": "L", "color": "Black"}, {"product_id": "55555555-5555-5555-5555-555555555555", "name": "Leather Crossbody Bag", "quantity": 1, "price": 129.99, "color": "Black"}]'
)
ON CONFLICT (id) DO NOTHING;

-- Sample Reviews
INSERT INTO public.reviews (
  product_id,
  user_id,
  rating,
  title,
  comment,
  is_verified_purchase,
  is_approved
) VALUES
(
  '33333333-3333-3333-3333-333333333333',
  'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
  5,
  'Love this dress!',
  'The fabric is so comfortable and the print is even more beautiful in person. Fits perfectly!',
  true,
  true
),
(
  '11111111-1111-1111-1111-111111111111',
  'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
  4,
  'Great quality t-shirt',
  'Very soft cotton and fits well. Would buy again in different colors.',
  false,
  true
),
(
  '22222222-2222-2222-2222-222222222222',
  'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
  5,
  'Perfect fit',
  'These jeans are exactly what I was looking for. The stretch makes them super comfortable.',
  false,
  true
),
(
  '55555555-5555-5555-5555-555555555555',
  'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
  5,
  'Beautiful bag',
  'The leather quality is excellent and it''s the perfect size for everyday use.',
  false,
  true
)
ON CONFLICT (product_id, user_id) DO NOTHING;
import React, { useEffect, useState } from 'react';
import { useAuth } from '@/contexts/AuthContext';
import { supabase } from '@/integrations/supabase/client';
import { Database } from '@/integrations/supabase/types';
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Separator } from '@/components/ui/separator';
import { toast } from 'sonner';
import { SEO } from "@/components/SEO";
import { Package, ShoppingCart, Heart, User, Calendar1 as Calendar, DollarSign, TrendingUp } from







'lucide-react';

type Order = Database['public']['Tables']['orders']['Row'];
type CartItem = Database['public']['Tables']['cart_items']['Row'];
type WishlistItem = Database['public']['Tables']['wishlists']['Row'];

const Dashboard = () => {
  const { user, profile } = useAuth();
  const [orders, setOrders] = useState<Order[]>([]);
  const [cartCount, setCartCount] = useState(0);
  const [wishlistCount, setWishlistCount] = useState(0);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (user) {
      fetchDashboardData();
    }
  }, [user]);

  const fetchDashboardData = async () => {
    if (!user) return;

    try {
      setLoading(true);

      // Fetch recent orders
      const { data: ordersData, error: ordersError } = await supabase.
      from('orders').
      select('*').
      eq('user_id', user.id).
      order('created_at', { ascending: false }).
      limit(5);

      if (ordersError) throw ordersError;

      // Fetch cart count
      const { count: cartCountData, error: cartError } = await supabase.
      from('cart_items').
      select('*', { count: 'exact', head: true }).
      eq('user_id', user.id);

      if (cartError) throw cartError;

      // Fetch wishlist count
      const { count: wishlistCountData, error: wishlistError } = await supabase.
      from('wishlists').
      select('*', { count: 'exact', head: true }).
      eq('user_id', user.id);

      if (wishlistError) throw wishlistError;

      setOrders(ordersData || []);
      setCartCount(cartCountData || 0);
      setWishlistCount(wishlistCountData || 0);
    } catch (error) {
      console.error('Error fetching dashboard data:', error);
      toast.error('Failed to load dashboard data');
    } finally {
      setLoading(false);
    }
  };

  const getStatusColor = (status: string) => {
    switch (status) {
      case 'pending':
        return 'bg-yellow-100 text-yellow-800';
      case 'processing':
        return 'bg-blue-100 text-blue-800';
      case 'shipped':
        return 'bg-purple-100 text-purple-800';
      case 'delivered':
        return 'bg-green-100 text-green-800';
      case 'cancelled':
        return 'bg-red-100 text-red-800';
      default:
        return 'bg-gray-100 text-gray-800';
    }
  };

  const totalSpent = orders.reduce((sum, order) => sum + order.total_amount, 0);

  if (loading) {
    return (
      <div className="container mx-auto px-4 py-8">
        <SEO
          title="Dashboard"
          description="Your personal dashboard - track orders, manage settings, and view analytics."
          keywords="dashboard, user dashboard, account overview, my orders"
          url="https://yourwebsite.com/dashboard"
        />

        <div className="animate-pulse space-y-6">
          <div className="h-8 bg-muted rounded w-1/4"></div>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
            {Array.from({ length: 4 }).map((_, i) => (
              <Card key={i}>
                <CardContent className="p-6">
                  <div className="h-16 bg-muted rounded"></div>
                </CardContent>
              </Card>
            ))}
          </div>
        </div>
      </div>
    );

  }

  return (
    <div className="container mx-auto px-4 py-8">
      <SEO
        title="Dashboard"
        description="Your personal dashboard - track orders, manage settings, and view analytics."
        keywords="dashboard, user dashboard, account overview, my orders"
        url="https://yourwebsite.com/dashboard"
      />

      {/* Header */}
      <div className="mb-8">
        <h1 className="font-heading text-3xl font-bold mb-2">
          Welcome back, {profile?.full_name || "User"}!
        </h1>
        <p className="text-muted-foreground">
          Here's an overview of your StyleHub account
        </p>
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <Card>
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-muted-foreground">
                  Total Orders
                </p>
                <p className="text-2xl font-bold">{orders.length}</p>
              </div>
              <Package className="h-8 w-8 text-primary" />
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-muted-foreground">
                  Cart Items
                </p>
                <p className="text-2xl font-bold">{cartCount}</p>
              </div>
              <ShoppingCart className="h-8 w-8 text-primary" />
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-muted-foreground">
                  Wishlist
                </p>
                <p className="text-2xl font-bold">{wishlistCount}</p>
              </div>
              <Heart className="h-8 w-8 text-primary" />
            </div>
          </CardContent>
        </Card>

        <Card>
          <CardContent className="p-6">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm font-medium text-muted-foreground">
                  Total Spent
                </p>
                <p className="text-2xl font-bold">${totalSpent.toFixed(2)}</p>
              </div>
              <DollarSign className="h-8 w-8 text-primary" />
            </div>
          </CardContent>
        </Card>
      </div>

      <div className="grid grid-cols-1 lg:grid-cols-2 gap-8">
        {/* Recent Orders */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center">
              <Package className="mr-2 h-5 w-5" />
              Recent Orders
            </CardTitle>
          </CardHeader>
          <CardContent>
            {orders.length === 0 ? (
              <div className="text-center py-8">
                <Package className="h-12 w-12 text-muted-foreground mx-auto mb-4" />
                <p className="text-muted-foreground">No orders yet</p>
                <Button
                  className="mt-4"
                  onClick={() => (window.location.href = "/shop")}
                >
                  Start Shopping
                </Button>
              </div>
            ) : (
              <div className="space-y-4">
                {orders.map((order) => (
                  <div
                    key={order.id}
                    className="flex items-center justify-between p-4 border rounded-lg"
                  >
                    <div>
                      <p className="font-semibold">#{order.order_number}</p>
                      <p className="text-sm text-muted-foreground">
                        {new Date(order.created_at).toLocaleDateString()}
                      </p>
                    </div>
                    <div className="text-right">
                      <p className="font-semibold">
                        ${order.total_amount.toFixed(2)}
                      </p>
                      <Badge className={getStatusColor(order.status)}>
                        {order.status.charAt(0).toUpperCase() +
                          order.status.slice(1)}
                      </Badge>
                    </div>
                  </div>
                ))}
                {orders.length >= 5 && (
                  <Button variant="outline" className="w-full">
                    View All Orders
                  </Button>
                )}
              </div>
            )}
          </CardContent>
        </Card>

        {/* Account Info */}
        <Card>
          <CardHeader>
            <CardTitle className="flex items-center">
              <User className="mr-2 h-5 w-5" />
              Account Information
            </CardTitle>
          </CardHeader>
          <CardContent className="space-y-4">
            <div>
              <label className="text-sm font-medium text-muted-foreground">
                Full Name
              </label>
              <p className="font-semibold">
                {profile?.full_name || "Not provided"}
              </p>
            </div>

            <Separator />

            <div>
              <label className="text-sm font-medium text-muted-foreground">
                Email
              </label>
              <p className="font-semibold">{profile?.email || user?.email}</p>
            </div>

            <Separator />

            <div>
              <label className="text-sm font-medium text-muted-foreground">
                Phone
              </label>
              <p className="font-semibold">
                {profile?.phone || "Not provided"}
              </p>
            </div>

            <Separator />

            <div>
              <label className="text-sm font-medium text-muted-foreground">
                Member Since
              </label>
              <p className="font-semibold">
                {new Date(
                  profile?.created_at || user?.created_at || "",
                ).toLocaleDateString()}
              </p>
            </div>

            <Button
              variant="outline"
              className="w-full"
              onClick={() => (window.location.href = "/profile")}
            >
              Edit Profile
            </Button>
          </CardContent>
        </Card>
      </div>

      {/* Quick Actions */}
      <Card className="mt-8">
        <CardHeader>
          <CardTitle>Quick Actions</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <Button
              variant="outline"
              className="h-16 flex flex-col items-center justify-center"
              onClick={() => (window.location.href = "/shop")}
            >
              <ShoppingCart className="h-6 w-6 mb-2" />
              Continue Shopping
            </Button>

            <Button
              variant="outline"
              className="h-16 flex flex-col items-center justify-center"
              onClick={() => (window.location.href = "/wishlist")}
            >
              <Heart className="h-6 w-6 mb-2" />
              View Wishlist
            </Button>

            <Button
              variant="outline"
              className="h-16 flex flex-col items-center justify-center"
              onClick={() => (window.location.href = "/cart")}
            >
              <Package className="h-6 w-6 mb-2" />
              View Cart
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );

};

export default Dashboard;
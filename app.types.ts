import { Database } from './db.types'

export type Song = Database['public']['Tables']['songs']['Row']

export type Product = Database['public']['Tables']['products']['Row']

export type Price = Database['public']['Tables']['prices']['Row']

export type Customer = Database['public']['Tables']['customers']['Row']

export type UserDetails = Database['public']['Tables']['users']['Row']

export type ProductWithPrice = {
  prices?: Price[]
} & Product

export type Subscription = Database['public']['Tables']['subscriptions']['Row']

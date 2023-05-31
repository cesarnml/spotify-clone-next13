'use client'

import { Database } from '@/db.types'
import { createClientComponentClient } from '@supabase/auth-helpers-nextjs'
import { SessionContextProvider } from '@supabase/auth-helpers-react'
import { ReactNode, useState } from 'react'

type Props = {
  children: ReactNode
}

export const SupabaseProvider = ({ children }: Props) => {
  const [supabaseClient] = useState(() => createClientComponentClient<Database>())
  return <SessionContextProvider supabaseClient={supabaseClient}>{children}</SessionContextProvider>
}

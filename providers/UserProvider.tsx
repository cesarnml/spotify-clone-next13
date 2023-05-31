'use client'

import { UserContextProvider } from '@/hooks/useUser'
import { ReactNode } from 'react'

type Props = {
  children: ReactNode
}

export const UserProvider = ({ children }: Props) => {
  return <UserContextProvider>{children}</UserContextProvider>
}

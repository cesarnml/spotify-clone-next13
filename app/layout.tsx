import { Sidebar } from '@/components/Sidebar'
import { Figtree } from 'next/font/google'
import { SupabaseProvider } from '@/providers/SupabaseProvider'
import { UserContextProvider } from '@/hooks/useUser'
import { ModalProvider } from '@/providers/ModalProvider'
import { ToasterProvider } from '@/providers/ToasterProvider'
import getSongsByUserId from '@/actions/getSongsByUserId'
import './globals.css'

const font = Figtree({ subsets: ['latin'] })

export const metadata = {
  title: 'Spotify Clone',
  description: 'Listen to music!',
}

export const revalidate = 0

export default async function RootLayout({ children }: { children: React.ReactNode }) {
  const userSongs = await getSongsByUserId()

  return (
    <html lang="en">
      <body className={font.className}>
        <ToasterProvider />
        <SupabaseProvider>
          <UserContextProvider>
            <ModalProvider />
            <Sidebar songs={userSongs}>{children}</Sidebar>
          </UserContextProvider>
        </SupabaseProvider>
      </body>
    </html>
  )
}

import { Sidebar } from '@/components/Sidebar'
import { Figtree } from 'next/font/google'
import { SupabaseProvider } from '@/providers/SupabaseProvider'
import { UserContextProvider } from '@/hooks/useUser'
import { ModalProvider } from '@/providers/ModalProvider'
import './globals.css'
import { ToasterProvider } from '@/providers/ToasterProvider'

const font = Figtree({ subsets: ['latin'] })

export const metadata = {
  title: 'Spotify Clone',
  description: 'Listen to music!',
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang='en'>
      <body className={font.className}>
        <ToasterProvider />
        <SupabaseProvider>
          <UserContextProvider>
            <ModalProvider />
            <Sidebar>{children}</Sidebar>
          </UserContextProvider>
        </SupabaseProvider>
      </body>
    </html>
  )
}

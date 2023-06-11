import { Song } from '@/app.types'
import { Database } from '@/db.types'
import { createServerComponentClient } from '@supabase/auth-helpers-nextjs'
import { cookies } from 'next/headers'

export const getLikedSongs = async (): Promise<Song[]> => {
  const supabase = createServerComponentClient<Database>({
    cookies: cookies,
  })

  const {
    data: { session },
  } = await supabase.auth.getSession()

  const { data } = await supabase
    .from('liked_songs')
    .select('*, songs(*)')
    .eq('user_id', session?.user?.id)
    .order('created_at', { ascending: false })

  if (!data) return []

  return data.map((item) => ({
    ...item.songs,
  })) as Song[]
}

import { Song } from '@/app.types'
import { Database } from '@/db.types'
import { useSupabaseClient } from '@supabase/auth-helpers-react'

export const useLoadImage = (song: Song) => {
  const supabaseClient = useSupabaseClient<Database>()

  if (!song) {
    return null
  }

  const { data: imageData } = supabaseClient.storage
    .from('images')
    .getPublicUrl(song.image_path || '')

  return imageData.publicUrl
}

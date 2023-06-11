'use client'

import { Song } from '@/app.types'
import { LikeButton } from '@/components/LikeButton'
import MediaItem from '@/components/MediaItem'
import useOnPlay from '@/hooks/useOnPlay'

type Props = {
  songs: Song[]
}

const SearchContent = ({ songs }: Props) => {
  const onPlay = useOnPlay(songs)

  if (!songs.length) {
    return (
      <div
        className="
          flex 
          flex-col 
          gap-y-2 
          w-full 
          px-6 
          text-neutral-400
        "
      >
        No songs found.
      </div>
    )
  }

  return (
    <div className="flex flex-col gap-y-2 w-full px-6">
      {songs.map((song: Song) => (
        <div key={song.id} className="flex items-center gap-x-4 w-full">
          <div className="flex-1">
            <MediaItem onClick={onPlay} data={song} />
          </div>
          <LikeButton songId={song.id} />
        </div>
      ))}
    </div>
  )
}

export default SearchContent

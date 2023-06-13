'use client'

import { TbPlaylist } from 'react-icons/tb'
import { AiOutlinePlus } from 'react-icons/ai'
import { useAuthModal } from '@/hooks/useAuthModal'
import { useUser } from '@/hooks/useUser'
import { useUploadModal } from '@/hooks/useUploadModal'
import { Song } from '@/app.types'
import useOnPlay from '@/hooks/useOnPlay'
import MediaItem from './MediaItem'

type Props = {
  songs: Song[]
}

export const Library = ({ songs }: Props) => {
  const { user } = useUser()
  const uploadModal = useUploadModal()
  const authModal = useAuthModal()

  const onPlay = useOnPlay(songs)

  const onClick = () => {
    if (!user) {
      return authModal.onOpen()
    }
    return uploadModal.onOpen()

    // TODO: Check for subscription
  }

  return (
    <div className="flex flex-col">
      <div className="flex items-center justify-between px-5 pt-4">
        <div className="inline-flex items-center gap-x-2">
          <TbPlaylist className="text-neutral-400" size={26} />
          <p className="text-neutral-400 font-medium text-base">Your Library</p>
        </div>
        <AiOutlinePlus
          onClick={onClick}
          size={20}
          className="text-neutral-400 cursor-pointer hover:text-white transition"
        />
      </div>
      <div className="flex flex-col gap-y-2 mt-4 px-3">
        {songs.map((item) => (
          <MediaItem onClick={(id) => onPlay(id)} key={item.id} data={item} />
        ))}
      </div>
    </div>
  )
}

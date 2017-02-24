From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 24 Feb 2017 12:39:57 -0800
Subject: NVMe IO error due to abort..
Message-ID: <CA+55aFy+b3W+F7jv9HSqs1UTrkUCKdGjTLUrdmiggG9Y6BApMQ@mail.gmail.com>

Ok, so my nice XPS13 just failed to boot into the most recent git
kernel, and I initially thought that it was the usernamespace changes
that made systemd unhappy.

But after looking some more, it was actually that /home didn't mount
cleanly, and systemd was just being a complete ass about not making
that clear.

Why didn't /home mount cleanly? Odd. Journaling filesystems and all that jazz..

But it wasn't some unclean shutdown, it turned out to be an IO error
on shutdown:

  Feb 24 11:57:13 xps13.linux-foundation.org kernel: nvme nvme0: I/O 1
QID 2 timeout, aborting
  Feb 24 11:57:13 xps13.linux-foundation.org kernel: nvme nvme0: Abort
status: 0x0
  Feb 24 11:57:43 xps13.linux-foundation.org kernel: nvme nvme0: I/O 1
QID 2 timeout, reset controller
  Feb 24 11:57:43 xps13.linux-foundation.org kernel: nvme nvme0:
completing aborted command with status: fffffffc
  Feb 24 11:57:43 xps13.linux-foundation.org kernel:
blk_update_request: I/O error, dev nvme0n1, sector 953640304
  Feb 24 11:57:43 xps13.linux-foundation.org kernel: Aborting journal
on device dm-3-8.
  Feb 24 11:57:43 xps13.linux-foundation.org kernel: EXT4-fs error
(device dm-3): ext4_journal_check_start:60: Detected aborted journal
  Feb 24 11:57:43 xps13.linux-foundation.org kernel: EXT4-fs (dm-3):
Remounting filesystem read-only
  Feb 24 11:57:43 xps13.linux-foundation.org kernel: EXT4-fs error
(device dm-3): ext4_journal_check_start:60: Detected aborted journal

The XPS13 has a Toshiba nvme controller:

  NVME Identify Controller:
  vid     : 0x1179
  ssvid   : 0x1179
  sn      :         86CS102VT3MT
  mn      : THNSN51T02DU7 NVMe TOSHIBA 1024GB

and doing a "nvme smart-log" doesn't show any errors. What can I do to
help debug this? It's only happened once, but it's obviously a scary
situation.

I doubt the SSD is going bad, unless the smart data is entirely
useless. So I'm more thinking this might be a driver issue - I may
have made a mistake in enabling mq-deadline for both single and
multi-queue?

Are there known issues? Is there some logging/reporting outside of the
smart data I can do (there's a "nvme get-log" command, but I'm not
finding any information about how that would work).

I got it all working after a fsck, but having an unreliable disk in my
laptop is not a good feeling.

Help me, Obi-NVMe Kenobi, you're my only hope.

              Linus

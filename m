From: axboe@fb.com (Jens Axboe)
Date: Fri, 24 Feb 2017 14:01:36 -0700
Subject: NVMe IO error due to abort..
In-Reply-To: <CA+55aFy+b3W+F7jv9HSqs1UTrkUCKdGjTLUrdmiggG9Y6BApMQ@mail.gmail.com>
References: <CA+55aFy+b3W+F7jv9HSqs1UTrkUCKdGjTLUrdmiggG9Y6BApMQ@mail.gmail.com>
Message-ID: <23c9ee0b-c793-9c15-074c-94c2c67e1ddc@fb.com>

On 02/24/2017 01:39 PM, Linus Torvalds wrote:
> Ok, so my nice XPS13 just failed to boot into the most recent git
> kernel, and I initially thought that it was the usernamespace changes
> that made systemd unhappy.
> 
> But after looking some more, it was actually that /home didn't mount
> cleanly, and systemd was just being a complete ass about not making
> that clear.
> 
> Why didn't /home mount cleanly? Odd. Journaling filesystems and all that jazz..
> 
> But it wasn't some unclean shutdown, it turned out to be an IO error
> on shutdown:
> 
>   Feb 24 11:57:13 xps13.linux-foundation.org kernel: nvme nvme0: I/O 1
> QID 2 timeout, aborting
>   Feb 24 11:57:13 xps13.linux-foundation.org kernel: nvme nvme0: Abort
> status: 0x0
>   Feb 24 11:57:43 xps13.linux-foundation.org kernel: nvme nvme0: I/O 1
> QID 2 timeout, reset controller
>   Feb 24 11:57:43 xps13.linux-foundation.org kernel: nvme nvme0:
> completing aborted command with status: fffffffc
>   Feb 24 11:57:43 xps13.linux-foundation.org kernel:
> blk_update_request: I/O error, dev nvme0n1, sector 953640304
>   Feb 24 11:57:43 xps13.linux-foundation.org kernel: Aborting journal
> on device dm-3-8.
>   Feb 24 11:57:43 xps13.linux-foundation.org kernel: EXT4-fs error
> (device dm-3): ext4_journal_check_start:60: Detected aborted journal
>   Feb 24 11:57:43 xps13.linux-foundation.org kernel: EXT4-fs (dm-3):
> Remounting filesystem read-only
>   Feb 24 11:57:43 xps13.linux-foundation.org kernel: EXT4-fs error
> (device dm-3): ext4_journal_check_start:60: Detected aborted journal
> 
> The XPS13 has a Toshiba nvme controller:
> 
>   NVME Identify Controller:
>   vid     : 0x1179
>   ssvid   : 0x1179
>   sn      :         86CS102VT3MT
>   mn      : THNSN51T02DU7 NVMe TOSHIBA 1024GB
> 
> and doing a "nvme smart-log" doesn't show any errors. What can I do to
> help debug this? It's only happened once, but it's obviously a scary
> situation.
> 
> I doubt the SSD is going bad, unless the smart data is entirely
> useless. So I'm more thinking this might be a driver issue - I may
> have made a mistake in enabling mq-deadline for both single and
> multi-queue?
> 
> Are there known issues? Is there some logging/reporting outside of the
> smart data I can do (there's a "nvme get-log" command, but I'm not
> finding any information about how that would work).
> 
> I got it all working after a fsck, but having an unreliable disk in my
> laptop is not a good feeling.
> 
> Help me, Obi-NVMe Kenobi, you're my only hope.

Very strange... The current series has seen literally weeks of
continuous testing on NVMe, both on my test box (with 4 different
drives) and I run it on my X1 laptop with nvme-as-root constantly too.
I'm running -git as if this morning on it now, with for-linus pulled in.

You should be fine with mq-deadline running the drive, even if it is
multiqueue. That's what I run on my laptop as well for test purposes,
and the majority of the runtime testing has been that configuration as
well, regardless of number of queues.

Is it reproducible? If so, you could try with mq-deadline. In testing,
the only oddness I've seen has been when we inadvertently issue a
request on the wrong hardware queue. And if that is the case, then
moving away from mq-deadline could change that behavior for you.

As to your flush theory, at least my laptop drive claims write back
caching and should see full flushes as well. I've seen nothing like this
on it, it's been rock solid. It would be useful if we dumped more about
the request on abort, though...

-- 
Jens Axboe

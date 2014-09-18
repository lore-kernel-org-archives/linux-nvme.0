From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 Sep 2014 15:50:04 -0600 (MDT)
Subject: Dataset management command
In-Reply-To: <CALhzMBQkahA7WxKSdeX1EyM5g-0HvtbicMyJfA0pyhnhZHWmtg@mail.gmail.com>
References: <CALhzMBQkahA7WxKSdeX1EyM5g-0HvtbicMyJfA0pyhnhZHWmtg@mail.gmail.com>
Message-ID: <alpine.LRH.2.03.1409181542510.4696@AMR>

On Thu, 18 Sep 2014, Ash B wrote:
> I see Dataset management command in the spec; however, only deallocate has
> been implemented and that to via discard flag in bio which is only for one
> range. I'd like to understand how the community plans to implement other
> DSM commands? Is it going to be via IOCTL or do we plan to add new flags in
> bio?

There currently is no such request a block driver can receive that
would map to any of the other attributes supported by the NVMe Dataset
Management command. If someone can come up with additional flags and a
good in-kernel use of them, then I don't see why it wouldn't be applied,
but no one has proposed any such thing AFAIK.

If you just want to pass it from userspace through with an IOCTL, this
patch will let you do that:

http://lists.infradead.org/pipermail/linux-nvme/2014-September/001154.html

If you want to deallocate multiple ranges in a single command you can
send a SCSI Unmap command via SG_IO ioctl, like sg_unmap from sg3-utils.

From: guenther@tum.de (Stephan =?utf-8?Q?G=C3=BCnther?=)
Date: Wed, 11 Nov 2015 23:09:57 +0100
Subject: nvme: controller resets
In-Reply-To: <CAKajsGNGvWw1+B7X8HxdvP0MyvAawb_PStu_adOC8wogOF-Fbg@mail.gmail.com>
References: <33aa688b8da3f41960d36e66aa1703d8@localhost>
 <20151110155110.GA31697@localhost.localdomain>
 <CAKajsGOdxWzK8TfpaLYpf25h=ZRfQbxRW47Q4aAHhCOunLK+FQ@mail.gmail.com>
 <CAKajsGNGvWw1+B7X8HxdvP0MyvAawb_PStu_adOC8wogOF-Fbg@mail.gmail.com>
Message-ID: <e3daa6a6ab157228a1f5606a776b01ea@localhost>

On 2015/November/12 03:26, Vedant Lath wrote:
> On Wed, Nov 11, 2015@3:58 AM, Vedant Lath <vedant@lath.in> wrote:
> > On Tue, Nov 10, 2015@9:21 PM, Keith Busch <keith.busch@intel.com> wrote:
> >> Not sure really. Normally I file a f/w bug for this kind of thing. :)
> >>
> >> But I'll throw out some potential ideas. Try trottling driver capabilities
> >> and see if anything improves: reduce queue count to 1 and depth to 2
> >> (requires code change).
> >>
> >> If you're able to recreate with reduced settings, then your controller's
> >> failure can be caused by a single command, and it's hopefully just a
> >> matter of finding that command.
> >>
> >> If the problem is not reproducible with reduced settings, then perhaps
> >> it's related to concurrent queue usage or high depth, and you can play
> >> with either to see if you discover anything interesting.
> >>
> >> Of course, I could be way off...
> >
> > Is there any way to monitor all the commands going through the wire?
> > Wouldn't that help? That would at least tell us which NVMe command
> > results in a reset, and the flow of the commands leading up to the
> > reset can give us more context into the error.
> 
> Reducing I/O queue depth to 2 fixes the crash. Increasing I/O queue
> depth to 3 again results in a crash.

The device fails to initialize with those settings for me. However, 
think I found the problem:

@@ -2273,7 +2276,7 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
        if (dev->stripe_size)
                blk_queue_chunk_sectors(ns->queue, dev->stripe_size >> 9);
        if (dev->vwc & NVME_CTRL_VWC_PRESENT)
-               blk_queue_flush(ns->queue, REQ_FLUSH | REQ_FUA);
+               blk_queue_flush(ns->queue, REQ_FUA);
        blk_queue_virt_boundary(ns->queue, dev->page_size - 1);

        disk->major = nvme_major

With these changes I was able to create a btrfs, copy several GiB of 
data, umount, remount, scrub, and balance.

The probem is *not* the flush itself (issueing the ioctl does not 
provoke the error. It is either a combination of flush with other 
commands or some flags issued together with a flush.

From: vedant@lath.in (Vedant Lath)
Date: Thu, 12 Nov 2015 19:32:18 +0530
Subject: nvme: controller resets
In-Reply-To: <e3daa6a6ab157228a1f5606a776b01ea@localhost>
References: <33aa688b8da3f41960d36e66aa1703d8@localhost>
 <20151110155110.GA31697@localhost.localdomain>
 <CAKajsGOdxWzK8TfpaLYpf25h=ZRfQbxRW47Q4aAHhCOunLK+FQ@mail.gmail.com>
 <CAKajsGNGvWw1+B7X8HxdvP0MyvAawb_PStu_adOC8wogOF-Fbg@mail.gmail.com>
 <e3daa6a6ab157228a1f5606a776b01ea@localhost>
Message-ID: <CAKajsGNwGSUJ+kfJVyreDbAhpWCX4Cs_7zKwx2H_q+X5pSS5ZQ@mail.gmail.com>

On Thu, Nov 12, 2015@3:39 AM, Stephan G?nther <guenther@tum.de> wrote:
> On 2015/November/12 03:26, Vedant Lath wrote:
>> Reducing I/O queue depth to 2 fixes the crash. Increasing I/O queue
>> depth to 3 again results in a crash.
>
> The device fails to initialize with those settings for me. However,
> think I found the problem:
>
> @@ -2273,7 +2276,7 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
>         if (dev->stripe_size)
>                 blk_queue_chunk_sectors(ns->queue, dev->stripe_size >> 9);
>         if (dev->vwc & NVME_CTRL_VWC_PRESENT)
> -               blk_queue_flush(ns->queue, REQ_FLUSH | REQ_FUA);
> +               blk_queue_flush(ns->queue, REQ_FUA);
>         blk_queue_virt_boundary(ns->queue, dev->page_size - 1);
>
>         disk->major = nvme_major
>
> With these changes I was able to create a btrfs, copy several GiB of
> data, umount, remount, scrub, and balance.
>
> The probem is *not* the flush itself (issueing the ioctl does not
> provoke the error. It is either a combination of flush with other
> commands or some flags issued together with a flush.

If we don't do FLUSH then we risk data corruption on power loss. Even
though get-feature says volatile write-cache is disabled, I observed
data corruption with this patch on doing a power-failure test (using
diskchecker.pl [1][2]). I tested with I/O queue depth of 2 and 1024;
in both cases, in the subsequent boot, I was not able to mount the
btrfs filesystem on the SSD. With FLUSH and an I/O queue depth of 2, I
got only 1 error with diskchecker.pl; I guess that was the last write
before power loss.

I also observed a latency of 8-25 ms when doing FLUSH which indicates
that FLUSH is not a no-op even when VWC is reported as disabled.

I wonder how the OS X driver handles it.

1: https://gist.github.com/bradfitz/3172656
2: http://brad.livejournal.com/2116715.html

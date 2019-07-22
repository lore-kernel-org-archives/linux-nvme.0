From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 22 Jul 2019 11:18:34 -0700
Subject: [PATCH] nvme-pci: fix probe and remove race
In-Reply-To: <CAOSXXT7z4+pScQ+Kf0VauTCvPdRDEXX=H7jQN-Dkk=M2hkTFsA@mail.gmail.com>
References: <20190719194256.23618-1-sagi@grimberg.me>
 <CAOSXXT7z4+pScQ+Kf0VauTCvPdRDEXX=H7jQN-Dkk=M2hkTFsA@mail.gmail.com>
Message-ID: <5426a9fd-ef5b-0ee5-8f65-1f49d5fb2290@grimberg.me>



On 7/20/19 7:46 PM, Keith Busch wrote:
> On Fri, Jul 19, 2019 at 1:43 PM Sagi Grimberg <sagi at grimberg.me 
> <mailto:sagi@grimberg.me>> wrote:
>  > It is possible that nvme_remove() being ran concurrently with
>  > nvme_reset_work(), with following sequence:
>  >
>  > nvme_probe()
>  > ? nvme_init_ctrl()
>  > ? ? //set to NEW
>  > ? nvme_async_probe()
>  > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? nvme_remove()
>  > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? //can not 
> change to
>  > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? //DELETING 
> from NEW
>  > ? ? nvme_reset_ctrl_sync()
>  > ? ? ? ? nvme_reset_ctrl()
>  > ? ? ? ? ? //change from NEW
>  > ? ? ? ? ? //to RESETTING
>  > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?flush reset_work()
>  > ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?//not yet queued
>  > ? ? ? ? ? queue reset_work
>  > ? ? ? ? ? ? nvme_reset_work()
>  > ? ? ? ? ? ? ? .... ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ....
>  >
>  > With the above running concurrently, then it is possible to cause some
>  > strange issues, like kernel crash with illegal memory accessing
>  > or something like:
>  > kernel: pci 0000:00:1f.0: can't enable device: BAR 0
>  > ?[mem 0xc0000000-0xc0003fff] not claimed
>  >
>  > Fix this by waiting for the async probe to complete before allowing
>  > remove to make forward progress.
> 
> Hi Sagi,
> 
> The only problem is the async probe may be stuck if its device was hot 
> removed, and needs nvme_remove to make it unstuck immediately. Otherwise 
> it waits for timeout work to fix it up, which can be a very long time.

Given that this is an error case, I don't think that the timeout is a
big issue.

> We only really need to wait for the state to not be new? And if so, is 
> the attached ok?

I don't have a firm reproducer, I was hoping that Li would have since
he reported the problem.

This would work because nvme_dev_disable is serialized with the
shutdown_lock...

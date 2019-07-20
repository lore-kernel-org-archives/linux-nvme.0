From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 20 Jul 2019 16:52:24 +0900
Subject: [PATCH] nvme-pci: fix probe and remove race
In-Reply-To: <20190719194256.23618-1-sagi@grimberg.me>
References: <20190719194256.23618-1-sagi@grimberg.me>
Message-ID: <20190720075224.GA22395@minwoo-desktop>

On 19-07-19 12:42:56, Sagi Grimberg wrote:
> It is possible that nvme_remove() being ran concurrently with
> nvme_reset_work(), with following sequence:
> 
> nvme_probe()
>   nvme_init_ctrl()
>     //set to NEW
>   nvme_async_probe()
>                                                       nvme_remove()
>                                                         //can not change to
>                                                         //DELETING from NEW
>     nvme_reset_ctrl_sync()
>         nvme_reset_ctrl()
>           //change from NEW
>           //to RESETTING
>                                                        flush reset_work()
>                                                        //not yet queued
>           queue reset_work
>             nvme_reset_work()
>               ....                                     ....
> 
> With the above running concurrently, then it is possible to cause some
> strange issues, like kernel crash with illegal memory accessing
> or something like:
> kernel: pci 0000:00:1f.0: can't enable device: BAR 0
>  [mem 0xc0000000-0xc0003fff] not claimed
> 
> Fix this by waiting for the async probe to complete before allowing
> remove to make forward progress.
> 
> Reported-by: Li Zhong <lizhongfs at gmail.com>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

This looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>

Thanks, Sagi.

From: keith.busch@intel.com (Keith Busch)
Date: Wed, 9 Sep 2015 13:39:32 +0000 (UTC)
Subject: [PATCH] NVMe: Force cancel commands on hot-removal
In-Reply-To: <CAPYzm7RB-LqEW1f0e-_Sh_ui3vS6q3sEOQ7sk5xfsOEG9SOVmg@mail.gmail.com>
References: <1441743187-12277-1-git-send-email-keith.busch@intel.com>
 <CAPYzm7Sm4K-VVWxGLAD2sjJ_e=FL3aQor8npN4sVcJ6irBtzJg@mail.gmail.com>
 <CAPYzm7RB-LqEW1f0e-_Sh_ui3vS6q3sEOQ7sk5xfsOEG9SOVmg@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1509091339130.23840@localhost.lm.intel.com>

On Wed, 9 Sep 2015, Mohana Goli wrote:
> Keith,
>
> Don't we need to take a queue spin lock  while processing the IOs on
> each request queue like the way we are doing in nvme_clear_queue ?
>
>
> >>>blk_mq_all_tag_busy_iter(hctx->tags,
>                                              nvme_cancel_queue_ios,
>                                               hctx->driver_data);

You're right, thanks for the catch.

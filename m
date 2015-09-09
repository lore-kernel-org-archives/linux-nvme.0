From: keith.busch@intel.com (Keith Busch)
Date: Wed, 9 Sep 2015 16:09:04 +0000 (UTC)
Subject: [PATCH] NVMe: Force cancel commands on hot-removal
In-Reply-To: <CAPYzm7Sspbga3DkAyKC_gq1Y_2Em9GEE8mdn5x_0Z=-vXyZQVg@mail.gmail.com>
References: <1441743187-12277-1-git-send-email-keith.busch@intel.com>
 <CAPYzm7Sm4K-VVWxGLAD2sjJ_e=FL3aQor8npN4sVcJ6irBtzJg@mail.gmail.com>
 <CAPYzm7RB-LqEW1f0e-_Sh_ui3vS6q3sEOQ7sk5xfsOEG9SOVmg@mail.gmail.com>
 <alpine.LNX.2.00.1509091339130.23840@localhost.lm.intel.com>
 <CAPYzm7Sspbga3DkAyKC_gq1Y_2Em9GEE8mdn5x_0Z=-vXyZQVg@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1509091607090.23840@localhost.lm.intel.com>

On Wed, 9 Sep 2015, Mohana Goli wrote:
> But issue is not seen if i use the my fix ,doing nvme_dev_shutdown
> first and nvme_dev_remove in nvme_remove function.And calling
> blk_cleanup_queue(ns->queue) before calling del_gendisk in
> nvme_ns_remove function.

The problem with your way is an orderly removal won't be able to sync
dirty data, which is something you _really_ want to happen if it at
all possible.

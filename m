From: mohana.goli@seagate.com (Mohana Goli)
Date: Thu, 10 Sep 2015 08:36:50 +0530
Subject: [PATCH] NVMe: Force cancel commands on hot-removal
In-Reply-To: <alpine.LNX.2.00.1509091607090.23840@localhost.lm.intel.com>
References: <1441743187-12277-1-git-send-email-keith.busch@intel.com>
 <CAPYzm7Sm4K-VVWxGLAD2sjJ_e=FL3aQor8npN4sVcJ6irBtzJg@mail.gmail.com>
 <CAPYzm7RB-LqEW1f0e-_Sh_ui3vS6q3sEOQ7sk5xfsOEG9SOVmg@mail.gmail.com>
 <alpine.LNX.2.00.1509091339130.23840@localhost.lm.intel.com>
 <CAPYzm7Sspbga3DkAyKC_gq1Y_2Em9GEE8mdn5x_0Z=-vXyZQVg@mail.gmail.com>
 <alpine.LNX.2.00.1509091607090.23840@localhost.lm.intel.com>
Message-ID: <CAPYzm7R5xL4eUnZns5YMe8UucZYVhruhfmU7qeonTphAzp5LpQ@mail.gmail.com>

On Wed, Sep 9, 2015@9:39 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Wed, 9 Sep 2015, Mohana Goli wrote:
>>
>> But issue is not seen if i use the my fix ,doing nvme_dev_shutdown
>> first and nvme_dev_remove in nvme_remove function.And calling
>> blk_cleanup_queue(ns->queue) before calling del_gendisk in
>> nvme_ns_remove function.
>
>
> The problem with your way is an orderly removal won't be able to sync
> dirty data, which is something you _really_ want to happen if it at
> all possible.

I think in case of orderly removal user will ensure flushing the dirty
data and unmounting the filesystem before physically remove the
drive.However there is a problem unloading the driver where we need to
sync the dirty data first.
For this i read csts register in nvme_remove,if that reads as
"0xffffffff" (device is no longer present), then i go my way,
otherwise your way.

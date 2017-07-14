From: cknvme@gmail.com (royy walls)
Date: Fri, 14 Jul 2017 15:09:12 -0700
Subject: [PATCH] nvme : add Scatter-Gather List (SGL) support in NVMe
 driver.
In-Reply-To: <20170714210623.GB24365@localhost.localdomain>
References: <1499968479-5286-1-git-send-email-chaitanya.kulkarni@hgst.com>
 <1499968479-5286-2-git-send-email-chaitanya.kulkarni@hgst.com>
 <20170714210623.GB24365@localhost.localdomain>
Message-ID: <CAGrovxV-cP4WfMV=2wAKuQ8Aif70s1Zc-uztD5OMS=fk7=_4CQ@mail.gmail.com>

Thanks for the feedback Keith, I'll look into this.

I posted the new version today, please let me know if you have any
other comments on the new code.

Regards,
-Chaitanya

On Fri, Jul 14, 2017@2:06 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Thu, Jul 13, 2017@10:54:39AM -0700, Chaitanya Kulkarni wrote:
>> This adds SGL support for NVMe PCIe driver which is
>> reimplementation of the initial version provided by
>> Rajiv Shanmugam Madeswaran(smrajiv15 at gmail.com):-
>> "block: nvme-core: Scatter gather list support in the
>> NVMe Block Driver".
>>
>> In order to enable SGL mode for the driver, the user can set the
>> sgl_threshold module parameter. This parameter can be used
>> in the two modes:-
>>
>> 1. Allow all IOs to use SGL mode. (set sgl_threshold to 1).
>> 2. Set up the IO size threshold to determine whether to use
>>     SGLs or PRPs for each IO. (set sgl_threshold to 4096 to
>>     use SGL only for IOs which are >= 4096 in the size).
>
> For this to really make a difference, you should clear
> blk_queue_virt_boundary for SGL capable devices.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

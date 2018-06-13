From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 13 Jun 2018 11:23:15 +0300
Subject: [PATCH 08/12] nvmet: mask pending AERs
In-Reply-To: <20180613074225.GA22725@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
 <20180530164600.26856-9-hch@lst.de>
 <b0427eb1-5bba-4c2b-c7fd-8df3b6dad2cf@mellanox.com>
 <20180613074225.GA22725@lst.de>
Message-ID: <c989fd6b-eda4-75ec-a670-4b78b0b68f98@mellanox.com>



On 6/13/2018 10:42 AM, Christoph Hellwig wrote:
> On Tue, Jun 12, 2018@06:41:53PM +0300, Israel Rukshin wrote:
>> There is a backwards compatibility issue with this patch.
>> I tested the latest nvme target with an older initiator that doesn't use
>> the changed namespaces list log to clear ns data changed AENs.
>> The target doesn't send the second NS_CHANGED event because the
>> NVME_AEN_CFG_NS_ATTR bit is not clear.
>> I have a simple fix that clear the bit also at
>> nvmet_execute_identify_ctrl().
>>
>> What do you think? is there a better way to solve it?
> 
> No.  Clearing it in nvmet_execute_identify_ctrl is bogus.  The problem
> is that the old target did not comply with the spec.
> 
> Note that the old host code would have had the same problem with other
> non-Linux targets.  So the only fix is to backport the host fix to
> older kernels.

Bummer.
This is not an easy task, I guess, for distros or other SW packeges out 
there...
Currently all of them can't work with upstream target :(

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flists.infradead.org%2Fmailman%2Flistinfo%2Flinux-nvme&data=02%7C01%7Cmaxg%40mellanox.com%7C87641b7377204e36819d08d5d1001a4f%7Ca652971c7d2e4d9ba6a4d149256f461b%7C0%7C1%7C636644720741147578&sdata=Su8lJHUseHLMB3jwnX9wMe3nhD%2B9E6%2BcyYI71Hri8xs%3D&reserved=0
> 

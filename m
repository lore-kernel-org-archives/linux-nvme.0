From: guanjunxiong@huawei.com (guanjunxiong)
Date: Thu, 30 Mar 2017 19:32:50 +0800
Subject: [PATCH] nvme: make nvme error status codes converted to errno
 detailed
In-Reply-To: <20170330081107.GA2991@infradead.org>
References: <1490782103-14668-1-git-send-email-guanjunxiong@huawei.com>
 <20170330081107.GA2991@infradead.org>
Message-ID: <e81a210c-a911-b275-eb53-51ee9f3f7c5e@huawei.com>



On 2017/3/30 16:11, Christoph Hellwig wrote:
> On Wed, Mar 29, 2017@06:08:23PM +0800, Guan Junxiong wrote:
>> From: Junxiong Guan <guanjunxiong at huawei.com>
>>
>> For more detailed information about nvme error status when ending
>> blk_mq request,some of nvme error status codes can be categorized into
>> different errnos explicitly. For example, NVME_SC_ACCESS_DENIED and
>> NVME_SC_CONNECT_CTRL_BUSY can be converted to EACCESS and EBUSY repec-
>> tively.This patch makes conversion from those nvme error status to errno
>> detailed.
> 
> NAK.  Most of these codes arw not defined for the block layer and don't
> make any sense.  Also I have a major rework in this area pending that
> would conflict with this patch.
> 
> .
> 
Hi,Christoph
   Current block layer ends the requests with errors and logs different errno in a
human readable string. So I think the detailed conversion above make sense.Also ,
as Sagi said, It'll be useful if we can log the specific error (as a human readable
string).
   Anyway, since this patch would conflict with your rework in this area,
I decide to suspend this patch.
   BTW, what's the plan of your rework in this area?

From: axboe@fb.com (Jens Axboe)
Date: Tue, 12 Jan 2016 13:33:56 -0700
Subject: [PATCHv3 4/5] NVMe: IO queue deletion re-write
In-Reply-To: <20160106154414.GD15113@localhost.localdomain>
References: <1451923859-14187-1-git-send-email-keith.busch@intel.com>
 <1451923859-14187-5-git-send-email-keith.busch@intel.com>
 <20160106130419.GA23245@infradead.org>
 <20160106154414.GD15113@localhost.localdomain>
Message-ID: <56956334.90908@fb.com>

On 01/06/2016 08:44 AM, Keith Busch wrote:
> On Wed, Jan 06, 2016@05:04:19AM -0800, Christoph Hellwig wrote:
>> This is my counter-suggestion to the requeue abuse:
>>
>> simply do two passes of your algorithm, one for the SQs, one for the
>> CQs.  Patch relative to the whole series below:
>
> Yes, thanks, this looks great!
>
> Just a nitpick, I think it'd look better semantically to have
> nvme_disable_io_queues handle switching the opcodes instead of having
> to call it twice, but this is fine as-is.
>
> Acked-by: Keith Busch <keith.busch at intel.com>

Keith, are you going to re-post 4-5/5?

-- 
Jens Axboe

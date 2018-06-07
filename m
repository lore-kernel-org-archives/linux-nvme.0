From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 7 Jun 2018 10:21:42 -0600
Subject: [PATCH 3/3] nvme: bio remapping tracepoint
In-Reply-To: <20180607114251.GA11119@lst.de>
References: <20180607083847.51019-1-hare@suse.de>
 <20180607083847.51019-4-hare@suse.de> <20180607112759.GC10939@lst.de>
 <20180607133332.798a8bbc@pentland.suse.de> <20180607114251.GA11119@lst.de>
Message-ID: <ef70773f-491c-274f-7273-f4f0d8b29470@kernel.dk>

On 6/7/18 5:42 AM, Christoph Hellwig wrote:
> On Thu, Jun 07, 2018@01:33:32PM +0200, Hannes Reinecke wrote:
>> That would run afoul with device-mapper usage:
>>
>> 	case DM_MAPIO_REMAPPED:
>> 		/* the bio has been remapped so dispatch it */
>> 		trace_block_bio_remap(clone->bi_disk->queue, clone,
>> 				      bio_dev(io->orig_bio), sector);
>> 		if (md->type == DM_TYPE_NVME_BIO_BASED)
>> 			ret = direct_make_request(clone);
>> 		else
>> 			ret = generic_make_request(clone);
>> 		break;
>>
>> and we can't move the call into generic_make_request().
>> So I fear it need to stay there.
> 
> Or you could move it from dm to where it belongs..

I was going to suggest that too, but there's really nothing
in direct_make_request() that implies that it's necessarily
a remap of an existing bio. The two current callers implies
that, but that's really not a given.

So maybe it'd be better to let it live in the caller.

-- 
Jens Axboe

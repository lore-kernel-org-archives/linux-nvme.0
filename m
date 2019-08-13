From: hare@suse.de (Hannes Reinecke)
Date: Tue, 13 Aug 2019 19:03:35 +0200
Subject: [PATCHv3] nvme: Return BLK_STS_TARGET if the DNR bit is set
In-Reply-To: <20190813170144.GA10269@lst.de>
References: <20190812075147.79598-1-hare@suse.de>
 <20190813170144.GA10269@lst.de>
Message-ID: <955adc31-6d46-3187-54ac-8d342c117bf8@suse.de>

On 8/13/19 7:01 PM, Christoph Hellwig wrote:
> On Mon, Aug 12, 2019@09:51:47AM +0200, Hannes Reinecke wrote:
>> If the DNR bit is set we should not retry the command, even if
>> the standard status evaluation indicates so.
> 
> What problem is this even trying to solve?  Nothing in the
> documentation of BLK_STS_TARGET says it should be retried any more
> or less than other error code.
> 
> If you really care about a retryable vs not retryable distinction
> at the block layer we need to propagate the equivalent of the DNR
> bit.
> 
That was my worry, too.
But I wasn't sure if that was the direction we should be going.
Personally, I'd be more than happy to add a flag for non-retryable errors.

Let's see how it would look like ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)

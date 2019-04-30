From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 Apr 2019 18:53:24 +0200
Subject: [PATCHv2] nvme-multipath: split bios with the ns_head bio_set
 before submitting
In-Reply-To: <20190430163350.GA25542@localhost.localdomain>
References: <20190430162745.39204-1-hare@suse.de>
 <20190430163350.GA25542@localhost.localdomain>
Message-ID: <a500ac28-135f-229f-32fd-c39eed90d5e8@suse.de>

On 4/30/19 6:33 PM, Keith Busch wrote:
> On Tue, Apr 30, 2019@06:27:45PM +0200, Hannes Reinecke wrote:
>> +	/*
>> +	 * The namespace might be going away and the bio might
>> +	 * be moved to a different queue via blk_steal_bios(),
>> +	 * so we need to use the bio_split pool from the original
>> +	 * queue to allocate the bvecs from.
>> +	 */
>> +	blk_queue_split(q, *bio);
>                             ^^^^
> 
> Shouldn't that be '&bio'?
> 
Lemme check ...

/me cross-checks the build logs

and indeed, you are correct.

Will be resending.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke            Teamlead Storage & Networking
hare at suse.de                              +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)

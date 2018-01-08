From: hare@suse.de (Hannes Reinecke)
Date: Mon, 8 Jan 2018 07:52:46 +0100
Subject: [for-4.16 PATCH v2 0/5] block, nvme, dm: allow DM multipath to
 use NVMe's error handler
In-Reply-To: <20180102232943.GC26533@localhost.localdomain>
References: <20171227032257.8182-1-snitzer@redhat.com>
 <20180102232943.GC26533@localhost.localdomain>
Message-ID: <31d7df8b-1197-c7aa-3c05-d8e7b5a63854@suse.de>

On 01/03/2018 12:29 AM, Keith Busch wrote:
> Instead of hiding NVMe path related errors, the NVMe driver needs to
> code an appropriate generic block status from an NVMe status.
> 
> We already do this translation whether or not CONFIG_NVME_MULTIPATHING is
> set, so I think it's silly NVMe native multipathing has a second status
> decoder. This just doubles the work if we need to handle any new NVMe
> status codes in the future.
> 
> I have a counter-proposal below that unifies NVMe-to-block status
> translations, and combines common code for determining if an error is a
> path failure. This should work for both NVMe and DM, and DM won't need
> NVMe specifics.
> 
> I can split this into a series if there's indication this is ok and
> satisfies the need.
> 
I'm all for it. Go.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)

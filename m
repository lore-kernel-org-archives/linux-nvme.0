From: jg@lightnvm.io (=?utf-8?Q?Javier_Gonz=C3=A1lez?=)
Date: Fri, 3 Nov 2017 14:00:08 +0100
Subject: [PATCH 1/3] nvme: do not check for ns on rw path
In-Reply-To: <20171103125339.GA25186@lst.de>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
 <1509703370-20379-2-git-send-email-javier@cnexlabs.com>
 <20171103125339.GA25186@lst.de>
Message-ID: <AE86953D-041E-4FFA-8DE8-E8FC95F95087@lightnvm.io>

> On 3 Nov 2017,@13.53, Christoph Hellwig <hch@lst.de> wrote:
> 
>> -	if (ns && ns->ms &&
>> +	if (ns->ms &&
>> 	    (!ns->pi_type || ns->ms != sizeof(struct t10_pi_tuple)) &&
>> 	    !blk_integrity_rq(req) && !blk_rq_is_passthrough(req))
>> 		return BLK_STS_NOTSUPP;
> 
> blk_rq_is_passthrough also can't be true here.
> 
> How about:
> 
> 	if (ns->ms && !blk_integrity_rq(req) &&
> 	    (!ns->pi_type || ns->ms != sizeof(struct t10_pi_tuple)))
> 		return BLK_STS_NOTSUPP;
> 

Sure.

> Although I have to admit I don't really understand what this check
> is even trying to do.  It basically checks for a namespace that has
> a format with metadata that is not T10 protection information and
> then rejects all I/O to it.  Why are we even creating a block device
> node for such a thing?

Looking at the history (i) the check has changed location and (ii) some
checks have been added through time. So it looks like leftovers from
here and there.

If we end up not needing these checks at all here, you can just fix it
all in the same commit. Just wanted to get rid of sparse/smatch
complains...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: Message signed with OpenPGP
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20171103/bc8c9674/attachment.sig>

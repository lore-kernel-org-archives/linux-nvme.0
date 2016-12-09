From: hare@suse.de (Hannes Reinecke)
Date: Fri, 9 Dec 2016 07:43:59 +0100
Subject: [LSF/MM TOPIC ATTEND] multipath for NVMe over Fabrics
In-Reply-To: <20161209011656.GA320@redhat.com>
References: <20161209011656.GA320@redhat.com>
Message-ID: <cacc9915-97c0-d5ef-1b9f-cb05f20619b4@suse.de>

On 12/09/2016 02:16 AM, Mike Snitzer wrote:
> I'd like to discuss $subject.  I haven't heard of much progress on this
> (but I'm also not tracking NVMe development at the moment).
>
> Last I heard about getting DM multipath to work with NVMe over Fabrics
> was this: https://patchwork.kernel.org/patch/9208997/
>
> I've reintroduced bio-based support for the DM multipath target.
> Between now and LSF I hope to come to terms with what the various work
> items are for making DM multipath work for NVMeoF.  I welcome any
> ideas/thoughts others might have.
>
Funny that you mention it.

I've got fed up with the mess that is multipath-tools, and decided to 
rework the entire thing. Including the kernel side.
I hope to have something ready soon, will be sending out an RFC once 
it's presentable.

So yes, I'd _definitely_ be interested in that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)

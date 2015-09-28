From: hare@suse.de (Hannes Reinecke)
Date: Mon, 28 Sep 2015 07:58:48 +0200
Subject: [RFC PATCH 0/2] virtio nvme
In-Reply-To: <1443330116.15432.57.camel@haakon3.risingtidesystems.com>
References: <1441864112-12765-1-git-send-email-mlin@kernel.org>	
 <CAJSP0QUmtgoh23G3u64xRnBbJkAoO19AEi=vkyPPyg9n9jqC2Q@mail.gmail.com>	
 <1441906098.18716.21.camel@ssi>	
 <1442470241.23132.77.camel@haakon3.risingtidesystems.com>	
 <1442532687.4750.6.camel@ssi>	
 <1442537752.11959.35.camel@haakon3.risingtidesystems.com>	
 <1442599957.11660.8.camel@ssi>	
 <1442610544.10492.33.camel@haakon3.risingtidesystems.com>	
 <1443049097.28503.13.camel@ssi>
 <1443330116.15432.57.camel@haakon3.risingtidesystems.com>
Message-ID: <5608D718.7050708@suse.de>

On 09/27/2015 07:01 AM, Nicholas A. Bellinger wrote:
> On Wed, 2015-09-23@15:58 -0700, Ming Lin wrote:
>> On Fri, 2015-09-18@14:09 -0700, Nicholas A. Bellinger wrote:
>>> On Fri, 2015-09-18@11:12 -0700, Ming Lin wrote:
>>>> On Thu, 2015-09-17@17:55 -0700, Nicholas A. Bellinger wrote:
> 
> <SNIP>
> 

<Even more SNIP>

> 
> Btw, after chatting with Dr. Hannes this week at SDC here are his
> original rts-megasas -v6 patches from Feb 2013.
> 
> Note they are standalone patches that require a sufficiently old enough
> LIO + QEMU to actually build + function.
> 
> https://github.com/Datera/rts-megasas/blob/master/rts_megasas-qemu-v6.patch
> https://github.com/Datera/rts-megasas/blob/master/rts_megasas-fabric-v6.patch
> 
> For groking purposes, they demonstrate the principle design for a host
> kernel level driver, along with the megasas firmware interface (MFI)
> specific emulation magic that makes up the bulk of the code.
> 
And indeed, Nic persuaded me to have them updated to qemu latest.
Which I'll be doing shortly. Stay tuned.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)

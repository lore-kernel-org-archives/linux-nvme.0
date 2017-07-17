From: hare@suse.de (Hannes Reinecke)
Date: Mon, 17 Jul 2017 08:12:01 +0200
Subject: [PATCH 3/3] nvme: wwid_show: copy hex string verbatim
In-Reply-To: <20170715084603.GC23189@lst.de>
References: <20170713222533.30794-1-mwilck@suse.com>
 <20170713222533.30794-4-mwilck@suse.com> <20170714075451.GD17877@lst.de>
 <1500026296.4808.8.camel@suse.com> <20170714123025.GC26187@lst.de>
 <1500061257.4808.23.camel@suse.com> <20170715084603.GC23189@lst.de>
Message-ID: <d7ad30f7-3697-c0a1-ead1-ada372b1464e@suse.de>

On 07/15/2017 10:46 AM, Christoph Hellwig wrote:
> On Fri, Jul 14, 2017@09:40:57PM +0200, Martin Wilck wrote:
>>> True.  Although that only really is a fix for buggy controllers,
>>> and should not affect the PCIe controllers (for which a compliance
>>> test for this exists, unfortunately that doesn't work for fabrics).
>>
>> Is that a NAK, or not?
> 
> That's an ACK for the null vs whitespace changes.  The NAK
> for this patch still stands.
> 
>> "We will"? People are (trying to) use NVMe with multipath today, and
>> they use dm-multipath and multipathd for that. Maybe that'll change
>> some day, but not too soon, I believe.
> 
> Who are these people and why aren't they on the nvme list?  The
> dm-mpath approach is fundamentally wrong for NVMe, and especially
> NVMeOF - e.g. for NVMeOF we have the mandatory keep alive, so doing
> any wonky path checking from userspace is just going to create
> problems.
> 
Hi Christoph; we are on the list :-)

One could argue that _all_ current path checkers in dm-mpath are
'wrong', so it feels a bit of a silly argument.
And it was never meant to be the 'real' solution; but it seems to work
and has the immediate benefit that we're having a solution _now_.
(And as our next release is shipping withing weeks that makes a _really_
compelling argument)
And I'm happy to enter any path checker discussion;
seeing that we've had issues with KATO even now (cf the thread 'I/O
errors due to keepalive timeouts with NVMf RDMA) I somewhat fail to see
the inherent benefits compared to the 'standard' path checkers ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)

From: hare@suse.de (Hannes Reinecke)
Date: Mon, 25 Sep 2017 07:59:05 +0200
Subject: [PATCH] nvme: make controller 'state' sysfs attribute pollable
In-Reply-To: <83264609-d5f9-8990-d79e-0b6eed1b2471@grimberg.me>
References: <20170920104032.14014-1-jthumshirn@suse.de>
 <20170920145931.GA5208@lst.de>
 <20170921051915.cfj2j5vu4bjqn5za@linux-x5ow.site>
 <83264609-d5f9-8990-d79e-0b6eed1b2471@grimberg.me>
Message-ID: <31e90477-59fc-8f70-d482-50c25393f58f@suse.de>

On 09/25/2017 07:37 AM, Sagi Grimberg wrote:
> 
>> So why exposing it then in the first time? I know you don't want
>> dm-mpath in
>> NVMe (neither do I) but we have to have something until your patchset
>> and ANA
>> is merged. And with this patch it's trivial to build a path checker
>> that just
>> looks at the state attribute in sysfs.
> 
> Can't we just not use path-checkers for nvme (we already have one in
> nvme)?

Really? For NVMe?
How would you do that, then?

Anyway: the entire point is that you don't _need_ a path checker for NVMe.
The primary reason for path checkers is to check with the transport
layer if the remote endpoint is reachable.
(I know, that's not quite what they're doing now, but that's beside the
point).
For NVMf we do have KATO, so the NVMe subsystem knows exactly if the
connection is live or not. So it should be perfectly sufficient to check
the connection state instead of running a path checker of sorts.
But for doing so we need something in sysfs which we could check.

Mind you, I wouldn't be adverse to have some common sysfs attribute,
with some common values (eg path up, path down, path blocked), and have
NVMf translating the internal state into that.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)

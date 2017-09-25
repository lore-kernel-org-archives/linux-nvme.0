From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 25 Sep 2017 10:09:20 +0300
Subject: [PATCH] nvme: make controller 'state' sysfs attribute pollable
In-Reply-To: <31e90477-59fc-8f70-d482-50c25393f58f@suse.de>
References: <20170920104032.14014-1-jthumshirn@suse.de>
 <20170920145931.GA5208@lst.de>
 <20170921051915.cfj2j5vu4bjqn5za@linux-x5ow.site>
 <83264609-d5f9-8990-d79e-0b6eed1b2471@grimberg.me>
 <31e90477-59fc-8f70-d482-50c25393f58f@suse.de>
Message-ID: <6d9304e2-f943-f063-1298-c6a2d582f78f@grimberg.me>



On 25/09/17 08:59, Hannes Reinecke wrote:
> On 09/25/2017 07:37 AM, Sagi Grimberg wrote:
>>
>>> So why exposing it then in the first time? I know you don't want
>>> dm-mpath in
>>> NVMe (neither do I) but we have to have something until your patchset
>>> and ANA
>>> is merged. And with this patch it's trivial to build a path checker
>>> that just
>>> looks at the state attribute in sysfs.
>>
>> Can't we just not use path-checkers for nvme (we already have one in
>> nvme)?
> 
> Really? For NVMe?
> How would you do that, then?

Quick and dirty is to have a path-checker that returns path-up always,
when the path go down, nvme will detect it and fast-fail the io.

> Anyway: the entire point is that you don't _need_ a path checker for NVMe.
> The primary reason for path checkers is to check with the transport
> layer if the remote endpoint is reachable.
> (I know, that's not quite what they're doing now, but that's beside the
> point).
> For NVMf we do have KATO, so the NVMe subsystem knows exactly if the
> connection is live or not. So it should be perfectly sufficient to check
> the connection state instead of running a path checker of sorts.
> But for doing so we need something in sysfs which we could check.
> 
> Mind you, I wouldn't be adverse to have some common sysfs attribute,
> with some common values (eg path up, path down, path blocked), and have
> NVMf translating the internal state into that.

We could have such an interface I assume. But it would suck to maintain
yet another state (we are already having enough trouble to have a
coherent controller state machine).

From: james.smart@broadcom.com (James Smart)
Date: Tue, 20 Nov 2018 11:27:04 -0800
Subject: [PATCHv3 0/3] nvme: NUMA locality for fabrics
In-Reply-To: <20181120154747.GE26707@localhost.localdomain>
References: <20181102095641.28504-1-hare@suse.de>
 <20181116081241.GA14072@lst.de>
 <c6b0e0f8-f22c-65b6-3657-1f078b0803e2@suse.de>
 <20181116082359.GB14269@lst.de>
 <58a66fee-0185-6ab4-3fe1-797d15d9badb@grimberg.me>
 <cc741191-12f3-91b0-df93-b6239f482aeb@suse.de> <20181120094140.GA7742@lst.de>
 <20181120154747.GE26707@localhost.localdomain>
Message-ID: <fd5ca98e-d0ed-5551-39d1-487bc6a7760f@broadcom.com>



On 11/20/2018 7:47 AM, Keith Busch wrote:
> On Tue, Nov 20, 2018@01:41:40AM -0800, Christoph Hellwig wrote:
>> On Tue, Nov 20, 2018@07:12:47AM +0100, Hannes Reinecke wrote:
>>> Fully agreed here.
>>> It all comes down to the link latency.
>>> If the link latency is the main bottleneck multipathing will benefit from
>>> round-robin (or any I/O scheduler, for that matter).
>> It still makes a lot more sense to try to have queues with an affinity
>> to a given path rather than doing round robin IFF you care about latency.
>>
>> If you latency sucks anyway round robing makes sense.  But why do you
>> use nvme on such a horrible interconnect anyway?
>>
>>> And this it not just relevant for 'legacy' hardware; I've seen a
>>> performance benefit on a 32G FC setup, which is pretty much state of the
>>> art currently.
>> Well, FC is legacy no matter which link speed.

Christoph,

your statement on affinity seems to have some very specific implied 
boundaries which I would like to understand.?? There's obviously some 
design principals and queue expectations that don't match the fabric 
implementations that are being put together, and they are not specific 
to FC. Do you mind enumerating some of your thoughts ?

 From statements such as "spend all our time optimizing every last cycle 
and cache line"? you are most concerned about the absolute lowest 
latency for a single io as seen on a single cpu. As such, that drives 
for a highly constrained fabric and environment and ignores a lot of 
things "sharing" aspects. Yes, it can be supported, but there are much 
more general cases out there as well.

- What are the latencies that are meaningful ?? is it solely single 
digit us ? 10-30us ?? 1ms ?? 50ms ?? 100ms ???? How do things change if 
the latency change ?

- At what point does it become more important to get commands to the 
subsystem (via a different queue or queues on different controllers) so 
they can be being worked on in parallel vs the latency of a single io 
??? How is this need communicated to the nvme layer so we can make the 
right choices ??? Queue counts, queue size, and MAXCMD limits (thanks 
Keith), may cause throttles that increase this need.?? To that end - 
what are your expectations for queue size or MAXCMD limits vs the 
latencies vs load from a single cpu?? or a set of cpus ?

- Must every cpu get a queue ??? what if the controller won't support a 
queue per cpu ?? how do things change if only 1 in 16 or less of the 
cpu's get queues ?? Today, if less than cpu count queues aren't 
supported - aren't queues for the different controllers likely mapping 
to the same cpus ? I don't think there's awareness of what queues on 
other controllers are present so that there could be redundant paths 
mapped to cpus that aren't bound already. And if such logic were added, 
how does that affect the multipathing choices ?

- What if application load is driven only by specific cpu's - if a "cpu 
was given" to the specific task (constrained app, VMs, or containers. 
how would we know that?) how does that map if multiple cpus are sharing 
a queue ? will multipathing and load choices be made system-wide, 
specific to a cpu set, or a single cpu ?

- What if a cpu is finally out of cycles due to load, how can we find 
out if the io must be limited to a cpu or whether affinity can be 
subverted so that use of other idle cpus can share in the processing 
load for the queue(s) for that cpu ?

If we're completely focused on cpu affinity with a queue, what happens 
when not all queues are equal. There is lots of talk of specific queues 
providing specific functionality that other queues wouldn't support. 
What if queues 1-M do writes with dedup, queues N-P do writes with 
compression, and Q-Z do accelerated writes to a local cache.? How do you 
see the current linux implementation migrating to something like that ?

-- james

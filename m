From: hch@lst.de (Christoph Hellwig)
Date: Wed, 21 Nov 2018 09:36:20 +0100
Subject: [PATCHv3 0/3] nvme: NUMA locality for fabrics
In-Reply-To: <fd5ca98e-d0ed-5551-39d1-487bc6a7760f@broadcom.com>
References: <20181102095641.28504-1-hare@suse.de>
 <20181116081241.GA14072@lst.de>
 <c6b0e0f8-f22c-65b6-3657-1f078b0803e2@suse.de>
 <20181116082359.GB14269@lst.de>
 <58a66fee-0185-6ab4-3fe1-797d15d9badb@grimberg.me>
 <cc741191-12f3-91b0-df93-b6239f482aeb@suse.de> <20181120094140.GA7742@lst.de>
 <20181120154747.GE26707@localhost.localdomain>
 <fd5ca98e-d0ed-5551-39d1-487bc6a7760f@broadcom.com>
Message-ID: <20181121083620.GA29382@lst.de>

On Tue, Nov 20, 2018@11:27:04AM -0800, James Smart wrote:
> - What are the latencies that are meaningful ?? is it solely single digit 
> us ? 10-30us ?? 1ms ?? 50ms ?? 100ms ???? How do things change if the 
> latency change ?

Well, we did spend a lot of effort on making sure sub-10us latencies
work.  For real life setups with multiple cpus in use the 100us order
of magniture is probably more interesting.

> - At what point does it become more important to get commands to the 
> subsystem (via a different queue or queues on different controllers) so 
> they can be being worked on in parallel vs the latency of a single io ??? 
> How is this need communicated to the nvme layer so we can make the right 
> choices ??? Queue counts, queue size, and MAXCMD limits (thanks Keith), 
> may cause throttles that increase this need.?? To that end - what are 
> your expectations for queue size or MAXCMD limits vs the latencies vs load 
> from a single cpu?? or a set of cpus ?

If you fully load the queue you are of course going to see massive
additional latency.  That's why you'll see typical NVMe PCIe device
(or RDMA setups) massively overprovisioned in number of queues and/or
queue depth.

> - Must every cpu get a queue ??? what if the controller won't support a 
> queue per cpu ?? how do things change if only 1 in 16 or less of the cpu's 
> get queues ?? Today, if less than cpu count queues aren't supported - 
> aren't queues for the different controllers likely mapping to the same cpus 
> ? I don't think there's awareness of what queues on other controllers are 
> present so that there could be redundant paths mapped to cpus that aren't 
> bound already. And if such logic were added, how does that affect the 
> multipathing choices ?

Less than cpu count queues are perfectly supported, we'll just start
sharing queues.  In general as long as you share queues between cores
on the same socket things still work reasonably fine.  Once you start
sharing a queue between sockets you are going to be in a world of pain.

> - What if application load is driven only by specific cpu's - if a "cpu was 
> given" to the specific task (constrained app, VMs, or containers. how would 
> we know that?) how does that map if multiple cpus are sharing a queue ? 
> will multipathing and load choices be made system-wide, specific to a cpu 
> set, or a single cpu ?

Right now we do multipathing devisions per node (aka per socket for
todays typical systems).

> - What if a cpu is finally out of cycles due to load, how can we find out 
> if the io must be limited to a cpu or whether affinity can be subverted so 
> that use of other idle cpus can share in the processing load for the 
> queue(s) for that cpu ?

For the traditional interrupt driven model we really need to process
the interrupts on the submitting cpu to throttle.  For an interesting
model to move the I/O completion load to another thread and thus potential
cpu look at the aio poll patches Jens just posted.

> If we're completely focused on cpu affinity with a queue, what happens when 
> not all queues are equal. There is lots of talk of specific queues 
> providing specific functionality that other queues wouldn't support. What 
> if queues 1-M do writes with dedup, queues N-P do writes with compression, 
> and Q-Z do accelerated writes to a local cache.? How do you see the 
> current linux implementation migrating to something like that ?

Very unlikely.  We have support for a few queu types now in the for-4.21
block tree (default, reads, polling), but the above just sounds way too
magic.

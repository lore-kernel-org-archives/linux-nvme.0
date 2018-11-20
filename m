From: keith.busch@intel.com (Keith Busch)
Date: Tue, 20 Nov 2018 08:47:48 -0700
Subject: [PATCHv3 0/3] nvme: NUMA locality for fabrics
In-Reply-To: <20181120094140.GA7742@lst.de>
References: <20181102095641.28504-1-hare@suse.de>
 <20181116081241.GA14072@lst.de>
 <c6b0e0f8-f22c-65b6-3657-1f078b0803e2@suse.de>
 <20181116082359.GB14269@lst.de>
 <58a66fee-0185-6ab4-3fe1-797d15d9badb@grimberg.me>
 <cc741191-12f3-91b0-df93-b6239f482aeb@suse.de>
 <20181120094140.GA7742@lst.de>
Message-ID: <20181120154747.GE26707@localhost.localdomain>

On Tue, Nov 20, 2018@01:41:40AM -0800, Christoph Hellwig wrote:
> On Tue, Nov 20, 2018@07:12:47AM +0100, Hannes Reinecke wrote:
> > Fully agreed here.
> > It all comes down to the link latency.
> > If the link latency is the main bottleneck multipathing will benefit from 
> > round-robin (or any I/O scheduler, for that matter).
> 
> It still makes a lot more sense to try to have queues with an affinity
> to a given path rather than doing round robin IFF you care about latency.
> 
> If you latency sucks anyway round robing makes sense.  But why do you
> use nvme on such a horrible interconnect anyway?
> 
> > And this it not just relevant for 'legacy' hardware; I've seen a 
> > performance benefit on a 32G FC setup, which is pretty much state of the 
> > art currently.
> 
> Well, FC is legacy no matter which link speed.

Fabrics has a required Identify Controller field called "MAXCMD" which
is a per-queue limiter. A sufficiently shallow value with a high queue
depth workload could justify round-robin'ing your queues.

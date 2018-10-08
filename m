From: hare@suse.de (Hannes Reinecke)
Date: Mon, 8 Oct 2018 12:19:27 +0200
Subject: [PATCH 2/2] nvme-multipath: manual NUMA configuration
In-Reply-To: <20181008100507.GB6686@lst.de>
References: <20181005092915.126636-1-hare@suse.de>
 <20181005092915.126636-3-hare@suse.de> <20181008100507.GB6686@lst.de>
Message-ID: <137f9b89-a481-41bb-280b-baaf41e5c84d@suse.de>

On 10/8/18 12:05 PM, Christoph Hellwig wrote:
> On Fri, Oct 05, 2018@11:29:15AM +0200, Hannes Reinecke wrote:
>> Not every NUMA configuration allows for an automatic setup via
>> the distance between nodes, or even the admin might have some
>> specific ideas on how things should be setup.
>> This patch adds a new sysfs attribute 'node_map' to allow to
>> specify the NUMA mapping for each controller.
> 
> This is a rather vagaue rational for a lot of anoying boilerplate
> code.  I'd like to see better arguments for even looking into adding
> magic knobs.
> 
Two reasons:
- With setting the correct affinity I'm getting a 25% performance boost
   (mainly as we can now utilize both paths properly)
- I haven't found a way of how we can distribute the NUMA nodes optimal, 
given the various possible HW combinations.

It's pretty trivial if you have only two NUMA nodes and two PCI 
devices/functions to distribute, but it becomes less clear for eg 4 NUMA 
nodes or two PCI functions on the same device (a dual-port FC HBA, say).

I have a system with this NUMA distance table:

10 21 21 21
21 10 21 21
21 21 10 21
21 21 21 10

and two (FC) HBAs on node 0 and 3.
So your algorithm gives me this distribution:

hba0: node 0 1 2
hba1: node 3

which clearly is suboptimal. We surely can require to have a PCI layout 
where the first HBA has to be on node 0, and the second on node 2, but 
this really is a bit daft and is just trying to paper over the fact that 
our algorithm sucks.
And given that we can place the two HBAs on virtually any node I found 
it too time-consuming trying to come up with an algorithm trying to fit 
all needs.
And that is the simple case; if one has a dual-ported HBA the NUMA 
locality for both paths will be identical, but we _still_ will be 
getting a performance boost by just being able to utilize both paths.

Additionally, with this patch we do provide static load-balancing 
without the need to add yet another framework.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)

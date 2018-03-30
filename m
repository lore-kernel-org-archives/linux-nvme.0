From: baegjae@gmail.com (Baegjae Sung)
Date: Fri, 30 Mar 2018 13:57:25 +0900
Subject: [PATCH] nvme-multipath: implement active-active round-robin path
 selector
In-Reply-To: <20180328194741.GJ13039@localhost.localdomain>
References: <20180327043851.6640-1-baegjae@gmail.com>
 <20180328080646.GB20373@lst.de>
 <20180328194741.GJ13039@localhost.localdomain>
Message-ID: <CAB2tqtvZ6zQ60jca7W4uKka2LfavsW=oKhTx9Gv0sXR7-SBUVg@mail.gmail.com>

2018-03-29 4:47 GMT+09:00 Keith Busch <keith.busch at intel.com>:
> On Wed, Mar 28, 2018@10:06:46AM +0200, Christoph Hellwig wrote:
>> For PCIe devices the right policy is not a round robin but to use
>> the pcie device closer to the node.  I did a prototype for that
>> long ago and the concept can work.  Can you look into that and
>> also make that policy used automatically for PCIe devices?
>
> Yeah, that is especially true if you've multiple storage accessing
> threads scheduled on different nodes. On the other hand, round-robin
> may still benefit if both paths are connected to different root ports
> on the same node (who would do that?!).
>
> But I wasn't aware people use dual-ported PCIe NVMe connected to a
> single host (single path from two hosts seems more common). If that's a
> thing, we should get some numa awareness. I couldn't find your prototype,
> though. I had one stashed locally from a while back and hope it resembles
> what you had in mind:

Our prototype uses dual-ported PCIe NVMe connected to a single host. The
host's HBA is connected to two switches, and the two switches are connected
to a dual-port NVMe SSD. In this environment, active-active round-robin path
selection is good to utilize the full performance of a dual-port NVMe SSD.
You can also fail over a single switch failure. You can see the prototype
in link below.
https://youtu.be/u_ou-AQsvOs?t=307 (presentation in OCP Summit 2018)

I agree that active-standby closer path selection is the right policy
if multiple
nodes attempt to access the storage system through multiple paths.
However, I believe that NVMe multipath needs to provide multiple policy for
path selection. Some people may want to use multiple paths simultaneously
(active-active) if they use a small number of nodes and want to utilize full
capability. If the capability of paths is same, the round-robin can be
the right
policy. If the capability of paths is different, a more adoptive
method would be
needed (e.g., checking path condition to balance IO).

We are moving to the NVMe fabrics for our next prototype. So, I think we will
have a chance to discuss about this policy issue in more detail. I will continue
to follow this issue.

> ---
> struct nvme_ns *nvme_find_path_numa(struct nvme_ns_head *head)
> {
>         int distance, current = INT_MAX, node = cpu_to_node(smp_processor_id());
>         struct nvme_ns *ns, *path = NULL;
>
>         list_for_each_entry_rcu(ns, &head->list, siblings) {
>                 if (ns->ctrl->state != NVME_CTRL_LIVE)
>                         continue;
>                 if (ns->disk->node_id == node)
>                         return ns;
>
>                 distance = node_distance(node, ns->disk->node_id);
>                 if (distance < current) {
>                         current = distance;
>                         path = ns;
>                 }
>         }
>         return path;
> }
> --

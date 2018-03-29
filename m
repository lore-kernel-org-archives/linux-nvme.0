From: hch@lst.de (Christoph Hellwig)
Date: Thu, 29 Mar 2018 10:56:21 +0200
Subject: [PATCH] nvme-multipath: implement active-active round-robin
 path selector
In-Reply-To: <20180328194741.GJ13039@localhost.localdomain>
References: <20180327043851.6640-1-baegjae@gmail.com>
 <20180328080646.GB20373@lst.de>
 <20180328194741.GJ13039@localhost.localdomain>
Message-ID: <20180329085621.GB22215@lst.de>

On Wed, Mar 28, 2018@01:47:41PM -0600, Keith Busch wrote:
> single host (single path from two hosts seems more common). If that's a
> thing, we should get some numa awareness. I couldn't find your prototype,
> though. I had one stashed locally from a while back and hope it resembles
> what you had in mind:

Mine was way older before the current data structures.  Back then I
used ->map_queues hacks that I'm glad I never posted :)

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

This is roughly what I'd do now.  The other important change would
be to have a per-node cache of the current path so that we don't do
it in the hot path.

From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 14 Nov 2017 16:21:28 +0000
Subject: [PATCH v3 0/9] Introduce per-device completion queue pools
In-Reply-To: <6af627c8-2814-d562-21a2-f10788e44458@grimberg.me>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <1510245771.2608.6.camel@wdc.com>
 <d5820b65-b428-7cd1-f7f1-7d8d89d21cf5@grimberg.me>
 <1510248716.2608.17.camel@wdc.com>
 <6af627c8-2814-d562-21a2-f10788e44458@grimberg.me>
Message-ID: <1510676487.2280.4.camel@wdc.com>

On Mon, 2017-11-13@22:31 +0200, Sagi Grimberg wrote:
> On Thu, 2017-11-09@17:31 +0000, Bart Van Assche wrote:
> > In case multiple ULPs share an RDMA port then which CQ is chosen for the ULP
> > will depend on the order in which the ULP drivers are loaded. This may lead to
> > hard to debug performance issues, e.g. due to different lock contention
> > behavior. That's another reason why per-ULP CQ pools look more interesting to
> > me than one CQ pool per HCA.
> 
> The ULP is free to pass in an affinity hint to enforce locality to a
> specific cpu core. Would that solve this issue?

Only for mlx5 adapters because only the mlx5 driver implements
.get_vector_affinity(). For other adapters the following code is used to chose a
vector:

    vector = affinity_hint % dev->num_comp_vectors;

That means whether or not a single CQ will be used by different CPUs depends on
how the ULP associates 'affinity_hint' with CPUs.

Bart.

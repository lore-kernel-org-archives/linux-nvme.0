From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 20 Nov 2017 14:26:51 +0200
Subject: [PATCH v3 0/9] Introduce per-device completion queue pools
In-Reply-To: <1510676487.2280.4.camel@wdc.com>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <1510245771.2608.6.camel@wdc.com>
 <d5820b65-b428-7cd1-f7f1-7d8d89d21cf5@grimberg.me>
 <1510248716.2608.17.camel@wdc.com>
 <6af627c8-2814-d562-21a2-f10788e44458@grimberg.me>
 <1510676487.2280.4.camel@wdc.com>
Message-ID: <da18d9bc-4db4-8bc1-dd61-05cb14dcd53c@grimberg.me>


>> The ULP is free to pass in an affinity hint to enforce locality to a
>> specific cpu core. Would that solve this issue?
> 
> Only for mlx5 adapters because only the mlx5 driver implements
> .get_vector_affinity(). For other adapters the following code is used to chose a
> vector:

Looks like even that will get reverted for 4.15 :)
Due to the change in user experience for managed irq vectors.

> 
>      vector = affinity_hint % dev->num_comp_vectors;
> 
> That means whether or not a single CQ will be used by different CPUs depends on
> how the ULP associates 'affinity_hint' with CPUs.

My intension was to pass it down to ib_alloc_cq and then convert
ib_cq_poll_work to run queue_work_on(cq->cpu, ib_comp_wq, &cq->work)

Note that you point out something that is more relevant to server/target
side ULPs (hence the assumption of workqueue mode).

So up until now I count Bart and Max on per-ULP pools, on the other
hand theres Christoph and I for per-device pools. Can we get a tie
breaker?

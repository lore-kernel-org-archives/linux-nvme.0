From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 9 Nov 2017 19:22:58 +0200
Subject: [PATCH v3 0/9] Introduce per-device completion queue pools
In-Reply-To: <1510245771.2608.6.camel@wdc.com>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <1510245771.2608.6.camel@wdc.com>
Message-ID: <d5820b65-b428-7cd1-f7f1-7d8d89d21cf5@grimberg.me>


>> This is the third re-incarnation of the CQ pool patches proposed
>> by Christoph and I.
> 
> Hello Sagi,

Hi Bart,

> This work looks interesting to me and I think it is a good idea to introduce
> a CQ pool implementation in the RDMA core. However, I have a concern about
> the approach. This patch series associates a single CQ pool with each RDMA
> device. Wouldn't it be better to let CQ pool users chose the CQ pool size and
> to let these users manage the CQ pool lifetime instead of binding the
> lifetime of a CQ pool to that of an RDMA device?

I think that the first approach I started from was introducing a CQ pool
entity and ULPs will manage it. Christoph really took the idea to this
level and suggested we move all the cq assignments "smarts" to the rdma
core...

> RDMA drivers are loaded
> during system startup. I think allocation of memory for CQ pools should be
> deferred until the ULP protocol driver(s) are loaded to avoid allocating
> memory for CQs while these are not in use.

I completely agree with you. The pool implementation is a lazy
allocation. Every create_qp with a IB_QP_CREATE_ASSIGN_CQS flag will
search a cq based on least-used selection or specific cq if
IB_QP_CREATE_AFFINITY_HINT is also passed.

If no candidate cq is found, the pool expands with more CQs (allocated
in per-cpu chunks). When the device is removed, the pool is freed (at
that point all the ULPs freed their queue-pairs in DEVICE_REMOVAL event
handlers).

However there is a catch because the CQ size is arbitrarily chosen at
the moment, and given that different ULPs will use different cq sizes
might generate unused few cq entries with this approach. That is indeed
a down-side compared to explicit cq pools owned by the ULP itself.

> Additionally, on many setups each
> RDMA port only runs a single ULP. I think that's another argument to let the
> ULP allocate CQ pool(s) instead of having one such pool per HCA.

I think that most modern HCAs are exposing device-per-port and will
probably continue to do so, But yes, mlx4 is dual-ported HCA.

But I'm afraid don't understand how the fact that ULPs will run on
different ports matter? how would the fact that we had two different
pools on different ports make a difference?

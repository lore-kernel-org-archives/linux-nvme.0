From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Nov 2017 22:31:26 +0200
Subject: [PATCH v3 0/9] Introduce per-device completion queue pools
In-Reply-To: <1510248716.2608.17.camel@wdc.com>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <1510245771.2608.6.camel@wdc.com>
 <d5820b65-b428-7cd1-f7f1-7d8d89d21cf5@grimberg.me>
 <1510248716.2608.17.camel@wdc.com>
Message-ID: <6af627c8-2814-d562-21a2-f10788e44458@grimberg.me>


>> But I'm afraid don't understand how the fact that ULPs will run on
>> different ports matter? how would the fact that we had two different
>> pools on different ports make a difference?
> 
> If each RDMA port is only used by a single ULP then the ULP driver can provide
> a better value for the CQ size than IB_CQE_BATCH. If CQ pools would be created
> by ULPs then it would be easy for ULPs to pass their choice of CQ size to the
> RDMA core.

But if that is not the case, maybe we may have less completion
aggragation per interrupt.

> In case multiple ULPs share an RDMA port then which CQ is chosen for the ULP
> will depend on the order in which the ULP drivers are loaded. This may lead to
> hard to debug performance issues, e.g. due to different lock contention
> behavior. That's another reason why per-ULP CQ pools look more interesting to
> me than one CQ pool per HCA.

The ULP is free to pass in an affinity hint to enforce locality to a
specific cpu core. Would that solve this issue?

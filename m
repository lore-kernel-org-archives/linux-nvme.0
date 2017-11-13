From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Nov 2017 22:28:32 +0200
Subject: [PATCH v3 1/9] RDMA/core: Add implicit per-device completion
 queue pools
In-Reply-To: <1510248814.2608.19.camel@wdc.com>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <20171108095742.25365-2-sagi@grimberg.me>
 <fe2c23b7-2923-2693-28c3-6a6f399bda26@mellanox.com>
 <23b598f2-6982-0d15-69e4-c526c627ec33@grimberg.me>
 <1510248814.2608.19.camel@wdc.com>
Message-ID: <1ac39e4b-81c8-1571-0fdf-8e9a38f1a5de@grimberg.me>

> Hello Sagi,
> 
> How about the following:
> 
> 	min(dev->attrs.max_cqe, max(nr_cqes, IB_CQE_BATCH))

That would work too, thanks Bart!

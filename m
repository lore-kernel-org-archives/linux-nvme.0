From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 3 May 2017 19:49:36 +0300
Subject: [PATCH v4, under testing] nvme-rdma: support devices with queue
 size < 32
In-Reply-To: <1493829456.3901.13.camel@sandisk.com>
References: <79901165.5342369.1493805915415.JavaMail.zimbra@kalray.eu>
 <823aa3f0-685f-4569-11d6-238cc4f0b126@grimberg.me>
 <780938034.8003164.1493824767084.JavaMail.zimbra@kalray.eu>
 <20170503155316.GA14334@obsidianresearch.com>
 <1493827096.3901.4.camel@sandisk.com>
 <77ada146-67eb-9dce-d252-6ac630c9a1e8@grimberg.me>
 <20170503162708.GO22833@mtr-leonro.local>
 <1493829456.3901.13.camel@sandisk.com>
Message-ID: <e07dfc4b-27a7-291c-7e22-d05b7d7c87b7@grimberg.me>


> Hello Marta, Sagi and Leon,
>
> How about changing nvme_rdma_init_sig_count() such that it always returns
> a power of two? The "+ 1" in the code below makes sure that the argument of
> ilog2() is larger than zero even if queue_size == 1. I'm not sure whether
> the time needed to compute ilog2() would make it necessary to cache the
> nvme_rdma_init_sig_count() return value.

ilog2 is pretty fast.

> static inline int nvme_rdma_init_sig_count(int queue_size)
> {
>         /* Return the largest power of two that is not above half of (queue size + 1) */
>         return 1 << ilog2((queue_size + 1) / 2);
> }

That'd work too I think...

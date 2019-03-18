From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 18 Mar 2019 14:34:00 -0700
Subject: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
In-Reply-To: <89a41878-c88b-c0a2-64ef-4409b907ece6@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
 <1551888921.9796.2.camel@acm.org>
 <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
 <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
 <50b3659d-fd88-85b0-755e-49565fbe98c2@mellanox.com>
 <89a41878-c88b-c0a2-64ef-4409b907ece6@mellanox.com>
Message-ID: <4c7b78ff-e906-8e67-c3ad-495b858ce82c@grimberg.me>


> As we discussed, let's check with RDMA maintainers if it's better to 
> extend alloc_cq API or create alloc_cq_dim API function.
> 
> Sagi/Christoph,
> 
> how about adding a module param per ULP ? as we use register_always 
> today, create a use_dimm module param for iSER/NVMe-RDMA ?

I would say that its better (and simpler) to do a global sysctl knob for
it. No need for a per-ULP param for a starting point.

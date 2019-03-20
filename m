From: leon@kernel.org (Leon Romanovsky)
Date: Wed, 20 Mar 2019 13:10:58 +0200
Subject: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
In-Reply-To: <226b674a-8ccb-864a-6153-be38ebcc3133@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
 <1551888921.9796.2.camel@acm.org>
 <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
 <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
 <50b3659d-fd88-85b0-755e-49565fbe98c2@mellanox.com>
 <89a41878-c88b-c0a2-64ef-4409b907ece6@mellanox.com>
 <4c7b78ff-e906-8e67-c3ad-495b858ce82c@grimberg.me>
 <226b674a-8ccb-864a-6153-be38ebcc3133@mellanox.com>
Message-ID: <20190320111058.GU4823@mtr-leonro.mtl.com>

On Wed, Mar 20, 2019@11:17:36AM +0200, Max Gurtovoy wrote:
>
> On 3/18/2019 11:34 PM, Sagi Grimberg wrote:
> >
> > > As we discussed, let's check with RDMA maintainers if it's better to
> > > extend alloc_cq API or create alloc_cq_dim API function.
> > >
> > > Sagi/Christoph,
> > >
> > > how about adding a module param per ULP ? as we use register_always
> > > today, create a use_dimm module param for iSER/NVMe-RDMA ?
> >
> > I would say that its better (and simpler) to do a global sysctl knob for
> > it. No need for a per-ULP param for a starting point.
>
> for sure it's simpler, but in this case all should agree that in case we run
> more than 1 ULP in a server, all of them will have the same configuration
> (no QoS).
>
> are you suggesting something like:
>
> /proc/sys/rdma/mlx5_0/dim
>
> Jason/Leon/Doug,
>
> thoughts about the best way to configure this feature from your perspective
> ?

It doesn't sound reasonable that we have per-ULP feature (DIM is
per-ULP) to be configured globally. Especially given the fact that
users can find themselves running different workloads with different
requirements on the same system.

Currently each ULP has some sort of tool to configure itself and I think
that once ULP is converted to use DIM, it should have on/off knob in the
tool used by their users.

Thanks

>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20190320/34b86ac6/attachment.sig>

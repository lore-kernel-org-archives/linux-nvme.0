From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Mar 2019 11:34:27 -0700
Subject: [RFC/PATCH net-next 0/9] net/dim: Support for multiple
 implementations
In-Reply-To: <20190320111058.GU4823@mtr-leonro.mtl.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
 <1551888921.9796.2.camel@acm.org>
 <392082ba-9aeb-6c5e-53a0-7bb53ce101fa@grimberg.me>
 <010bc92c-55c1-c5bd-82a5-975aa7f7c735@mellanox.com>
 <50b3659d-fd88-85b0-755e-49565fbe98c2@mellanox.com>
 <89a41878-c88b-c0a2-64ef-4409b907ece6@mellanox.com>
 <4c7b78ff-e906-8e67-c3ad-495b858ce82c@grimberg.me>
 <226b674a-8ccb-864a-6153-be38ebcc3133@mellanox.com>
 <20190320111058.GU4823@mtr-leonro.mtl.com>
Message-ID: <6599b66b-04d8-13e0-905a-9ab3862b30f5@grimberg.me>


> It doesn't sound reasonable that we have per-ULP feature (DIM is
> per-ULP) to be configured globally. Especially given the fact that
> users can find themselves running different workloads with different
> requirements on the same system.
> 
> Currently each ULP has some sort of tool to configure itself and I think
> that once ULP is converted to use DIM, it should have on/off knob in the
> tool used by their users.

Its not any different than socket options that can have a global sysctl
knob that can be overridden by individual socket consumers.

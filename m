From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 20 Nov 2017 14:20:15 +0200
Subject: [PATCH v3 0/9] Introduce per-device completion queue pools
In-Reply-To: <1abee653-425d-940a-a51c-7fcd43af7203@mellanox.com>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <1510245771.2608.6.camel@wdc.com>
 <d5820b65-b428-7cd1-f7f1-7d8d89d21cf5@grimberg.me>
 <1510248716.2608.17.camel@wdc.com>
 <1abee653-425d-940a-a51c-7fcd43af7203@mellanox.com>
Message-ID: <1402de75-6a20-a092-07a8-509192eb88a7@grimberg.me>


> I also prefer more the CQ pools per ULP approach (like we did with the 
> MR pools per QP) in the first stage.

Fair enough.

> For example, we saw a big 
> improvement in NVMEoF performance when we did CQ moderation (currently 
> local implementation in our labs). If we'll moderate shared CQ (iser + 
> nvmf CQ) we can ruin other ULP performance. ISER/SRP/NVMEoF/NFS has 
> different needs and different architectures, so even adaptive moderation 
> will not supply the best performance in that case.

Here I disagree. Using hard-coded or pre-configured adaptive moderation
is something we should move away from. I have a generic adaptive
moderation implementation for rdma and nvme in the works, and once that
does its job correctly, it should benefit everyone equally. Moreover,
IMO it even *supports* the notion of sharing CQs across ULPs because the
more consumers we have on a CQ, the better the adaptive moderation
works.

In fact, if it works well I will vote to turn it on by default and not
even allow ULPs to control it but only the user (via sysctl or
something) because if you think about it, ULPs can't really choose
better then the core.

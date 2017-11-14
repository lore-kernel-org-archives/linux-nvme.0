From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 14 Nov 2017 12:06:16 +0200
Subject: [PATCH v3 0/9] Introduce per-device completion queue pools
In-Reply-To: <1510248716.2608.17.camel@wdc.com>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <1510245771.2608.6.camel@wdc.com>
 <d5820b65-b428-7cd1-f7f1-7d8d89d21cf5@grimberg.me>
 <1510248716.2608.17.camel@wdc.com>
Message-ID: <1abee653-425d-940a-a51c-7fcd43af7203@mellanox.com>



On 11/9/2017 7:31 PM, Bart Van Assche wrote:
> On Thu, 2017-11-09@19:22 +0200, Sagi Grimberg wrote:
>> But I'm afraid don't understand how the fact that ULPs will run on
>> different ports matter? how would the fact that we had two different
>> pools on different ports make a difference?
> 
> If each RDMA port is only used by a single ULP then the ULP driver can provide
> a better value for the CQ size than IB_CQE_BATCH. If CQ pools would be created
> by ULPs then it would be easy for ULPs to pass their choice of CQ size to the
> RDMA core.

I also prefer more the CQ pools per ULP approach (like we did with the 
MR pools per QP) in the first stage. For example, we saw a big 
improvement in NVMEoF performance when we did CQ moderation (currently 
local implementation in our labs). If we'll moderate shared CQ (iser + 
nvmf CQ) we can ruin other ULP performance. ISER/SRP/NVMEoF/NFS has 
different needs and different architectures, so even adaptive moderation 
will not supply the best performance in that case.

We can (I meant I can :)) also implement SRQ pool per ULP (and then push 
my NVMEoF target SRQ per completion vector feature that saves resource 
allocation and still gives us very good numbers - almost same as using a 
non shared RQ).

> 
> In case multiple ULPs share an RDMA port then which CQ is chosen for the ULP
> will depend on the order in which the ULP drivers are loaded. This may lead to
> hard to debug performance issues, e.g. due to different lock contention
> behavior. That's another reason why per-ULP CQ pools look more interesting to
> me than one CQ pool per HCA.

debug is also a good point..

> 
> Bart.

-Max.

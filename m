From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 20 Nov 2017 14:31:53 +0200
Subject: [PATCH v3 1/9] RDMA/core: Add implicit per-device completion
 queue pools
In-Reply-To: <1510676885.2280.9.camel@wdc.com>
References: <20171108095742.25365-1-sagi@grimberg.me>
 <20171108095742.25365-2-sagi@grimberg.me> <1510676885.2280.9.camel@wdc.com>
Message-ID: <4fc5c223-358b-303b-26d6-abbc1620a74e@grimberg.me>


>> +struct ib_cq *ib_find_get_cq(struct ib_device *dev, unsigned int nr_cqe,
>> +               enum ib_poll_context poll_ctx, int affinity_hint)
>> +{
>> +       struct ib_cq *cq, *found;
>> +       unsigned long flags;
>> +       int vector, ret;
>> +
>> +       if (poll_ctx >= ARRAY_SIZE(dev->cq_pools))
>> +               return ERR_PTR(-EINVAL);
>> +
>> +       if (!ib_find_vector_affinity(dev, affinity_hint, &vector)) {
>> +               /*
>> +                * Couldn't find matching vector affinity so project
>> +                * the affinty to the device completion vector range
>> +                */
>> +               vector = affinity_hint % dev->num_comp_vectors;
>> +       }
> 
> So depending on whether or not the HCA driver implements .get_vector_affinity()
> either pci_irq_get_affinity() is used or "vector = affinity_hint %
> dev->num_comp_vectors"? Sorry but I think that kind of differences makes it
> unnecessarily hard for ULP maintainers to provide predictable performance and
> consistent behavior across HCAs.

Well, as a ULP maintainer I think that in the lack of
.get_vector_affinity() I would do that same thing as this code. srp
itself is doing the same thing in srp_create_target()

From: hch@lst.de (Christoph Hellwig)
Date: Mon, 1 Oct 2018 01:01:44 +0200
Subject: [PATCH] nvme: take node locality into account when selecting a
 path
In-Reply-To: <8b06c066-3a9a-84e6-2439-159d12ed64a2@grimberg.me>
References: <20180927230557.29444-1-hch@lst.de>
 <8b06c066-3a9a-84e6-2439-159d12ed64a2@grimberg.me>
Message-ID: <20180930230144.GB20144@lst.de>

On Fri, Sep 28, 2018@03:31:09PM -0700, Sagi Grimberg wrote:
>
>> +static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
>> +{
>> +	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
>> +	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
>>     	list_for_each_entry_rcu(ns, &head->list, siblings) {
>>   		if (ns->ctrl->state != NVME_CTRL_LIVE ||
>>   		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
>>   			continue;
>> +
>> +		distance = node_distance(node, dev_to_node(ns->ctrl->dev));
>
> Can we make this useful also for fabrics who have device affinity
> knowledge? ctrl->dev is useless for fabrics...
>
> Perhaps make it a ctrl->ops->devnode() or something?

I'd prefer a pointer of field (we could copy the node over) over
an indirect call.  But I'll happily leave that to the person that
actually implements the functionality to fabrics.

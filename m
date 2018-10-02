From: hare@suse.de (Hannes Reinecke)
Date: Tue, 2 Oct 2018 19:30:02 +0200
Subject: [PATCH] nvme: take node locality into account when selecting a
 path
In-Reply-To: <0a7f50ea-9da7-e9f1-8341-675db3bab396@grimberg.me>
References: <20180927230557.29444-1-hch@lst.de>
 <8b06c066-3a9a-84e6-2439-159d12ed64a2@grimberg.me>
 <20180930230144.GB20144@lst.de>
 <0a7f50ea-9da7-e9f1-8341-675db3bab396@grimberg.me>
Message-ID: <4d6336da-9441-fd97-b716-ec219489175a@suse.de>

On 10/1/18 9:45 PM, Sagi Grimberg wrote:
> 
>>>> +static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, 
>>>> int node)
>>>> +{
>>>> +??? int found_distance = INT_MAX, fallback_distance = INT_MAX, 
>>>> distance;
>>>> +??? struct nvme_ns *found = NULL, *fallback = NULL, *ns;
>>>> ???????? list_for_each_entry_rcu(ns, &head->list, siblings) {
>>>> ?????????? if (ns->ctrl->state != NVME_CTRL_LIVE ||
>>>> ?????????????? test_bit(NVME_NS_ANA_PENDING, &ns->flags))
>>>> ?????????????? continue;
>>>> +
>>>> +??????? distance = node_distance(node, dev_to_node(ns->ctrl->dev));
>>>
>>> Can we make this useful also for fabrics who have device affinity
>>> knowledge? ctrl->dev is useless for fabrics...
>>>
>>> Perhaps make it a ctrl->ops->devnode() or something?
>>
>> I'd prefer a pointer of field (we could copy the node over) over
>> an indirect call.? But I'll happily leave that to the person that
>> actually implements the functionality to fabrics.
> 
> Fair enough... I can follow up on that.
> 
Something like this?

Cheers,

Hannes


-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-nvme-use-NUMA-locality-information-for-fabrics.patch
Type: text/x-patch
Size: 4330 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20181002/2ea1784e/attachment-0001.bin>

From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 24 Dec 2017 10:50:24 +0200
Subject: [PATCH V2 6/6] nvme-pci: remove .init_request callback
In-Reply-To: <20171222013445.GA4545@ming.t460p>
References: <20171214023103.18272-1-ming.lei@redhat.com>
 <20171214023103.18272-7-ming.lei@redhat.com>
 <0fcf3176-7864-8631-e293-2bfa7aacea38@grimberg.me>
 <20171222013445.GA4545@ming.t460p>
Message-ID: <6420530f-1403-b0f4-0c95-d16fa396e095@grimberg.me>


> Please prepare a formal one(at least tested in normal case), either I
> or Zhang Yi may test/verify it.

OK.

>> @@ -1387,10 +1385,7 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev,
>> struct nvme_queue *nvmeq,
>>   static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
>>                                                          int depth, int node)
>>   {
>> -       struct nvme_queue *nvmeq = kzalloc_node(sizeof(*nvmeq), GFP_KERNEL,
>> -                                                       node);
>> -       if (!nvmeq)
>> -               return NULL;
>> +       struct nvme_queue *nvmeq = &dev->queues[qid];
> 
> Maybe you need to zero *nvmeq again since it is done in current code.

Relying on this is not a good idea, so I think we better off without
it because I want to know about it and fix it.

>> @@ -2470,8 +2465,9 @@ static int nvme_probe(struct pci_dev *pdev, const
>> struct pci_device_id *id)
>>          dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
>>          if (!dev)
>>                  return -ENOMEM;
>> -       dev->queues = kzalloc_node((num_possible_cpus() + 1) * sizeof(void
>> *),
>> -                                                       GFP_KERNEL, node);
>> +
>> +       alloc_size = (num_possible_cpus() + 1) * sizeof(struct nvme_queue
>> *);
> 
> The element size should be 'sizeof(struct nvme_queue)'.

Right.

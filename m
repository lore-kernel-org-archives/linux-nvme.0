From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 21 Jun 2018 09:51:49 +0300
Subject: [PATCH V4] nvmet: add buffered I/O support for file backed ns
In-Reply-To: <BN6PR04MB120385B3746564FD32964F7086770@BN6PR04MB1203.namprd04.prod.outlook.com>
References: <20180620040141.9553-1-chaitanya.kulkarni@wdc.com>
 <7ff64816-a285-cd4f-281f-8f3e6fbeb5ce@grimberg.me>
 <BN6PR04MB120385B3746564FD32964F7086770@BN6PR04MB1203.namprd04.prod.outlook.com>
Message-ID: <f895c58d-f5d3-cfd7-123d-cbddb96154ff@grimberg.me>


> [CK] I'm okay to change that if you prefer this style, can you please explain
>          is there anything wrong with the current code?

Its not wrong, its just a styling suggestion.

>> @@ -27,11 +32,14 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
>>     
>>  ?? int nvmet_file_ns_enable(struct nvmet_ns *ns)
>>  ?? {
>> -???? int ret;
>> +???? int flags = O_RDWR | O_LARGEFILE;
>>  ??????? struct kstat stat;
>> +???? int ret;
>> +
>> +???? if (!ns->buffered_io)
>> +???????????? flags |= O_DIRECT;
>>     
>> -???? ns->file = filp_open(ns->device_path,
>> -???????????????????? O_RDWR | O_LARGEFILE | O_DIRECT, 0);
>> +???? ns->file = filp_open(ns->device_path, flags, 0);
>>  ??????? if (IS_ERR(ns->file)) {
>>  ??????????????? pr_err("failed to open file %s: (%ld)\n",
>>  ??????????????????????????????? ns->device_path, PTR_ERR(ns->file));
>> @@ -62,6 +70,15 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
>>  ??????????????? goto err;
>>  ??????? }
>>     
>> +???? if (ns->buffered_io) {
>> +???????????? ns->file_wq = alloc_workqueue("nvmet-file",
>> +???????????????????????????? WQ_UNBOUND_MAX_ACTIVE | WQ_MEM_RECLAIM, 0);
> 
> I seriously don't think that a wq per ns is a good idea.. What was the
> consideration for this?
> 
> [CK] Since I/O submission is done per ns basis it is important to encapsulate workqueue and
>          make the property of the ns. In this way, I/Os from different namespaces will not interfere
>          with each other.
> 
>         Can you please explain the benefits of using the following model:-
> 
>         1. 1: N (1 workqueue : N Namespace).
>         2. M: N (M  workqueues : N Namespace).

wqs still share the same kworkers and workqueue access is rcu protected
so I'm not at all sure why this should make a difference.
Have you benchmarked per-ns workqueue vs. a shared one? I'd be
interested in knowing if it makes a difference. It would surprise
me if it did...

> [CK] Now that code is in, I'll send the configfs buffered_io parameter style change and removing
>          the flush wq as a separate patch.

We have time to fix it in-place, its not sent to Jens yet..

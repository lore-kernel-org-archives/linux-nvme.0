From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 1 Aug 2016 14:30:37 +0300
Subject: [PATCH v3] nvmet-rdma: Correctly handle RDMA device hot removal
In-Reply-To: <20160801111530.GB16474@lst.de>
References: <1469967347-20466-1-git-send-email-sagi@grimberg.me>
 <20160801111530.GB16474@lst.de>
Message-ID: <307087d1-88af-5244-38e8-5b9786285488@grimberg.me>


> This looks reasonable to me, but a little question below:
>
>> @@ -1442,7 +1491,8 @@ static void nvmet_rdma_remove_port(struct nvmet_port *port)
>>  {
>>  	struct rdma_cm_id *cm_id = port->priv;
>>
>> -	rdma_destroy_id(cm_id);
>> +	if (cm_id)
>> +		rdma_destroy_id(cm_id);
>>  }
>
> How is ->remove_port synchronized vs the RDMA/CM even handler?

Easy, it isn't :)

So we have three choices here:
1. Add a lock in nvmet_port that only rdma will use for now (don't like
it)
or
2. Add nvmet_rdma_port as nvmet_port->priv with a lock (don't like it)
or
3. take the global nvmet_config_sem (hate it)

Any preferences?

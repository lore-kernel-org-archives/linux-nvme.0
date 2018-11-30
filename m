From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 29 Nov 2018 17:22:43 -0800
Subject: [PATCH v4 11/13] nvmet-tcp: add NVMe over TCP target driver
In-Reply-To: <4ad0ce00-46a6-9aff-44ba-6c4374a9386e@mellanox.com>
References: <20181127231615.9446-1-sagi@grimberg.me>
 <20181127231615.9446-12-sagi@grimberg.me>
 <4ad0ce00-46a6-9aff-44ba-6c4374a9386e@mellanox.com>
Message-ID: <9068fee7-e299-afe1-3d29-22c2448379c7@grimberg.me>


>> +static inline void nvmet_tcp_put_cmd(struct nvmet_tcp_cmd *cmd)
>> +{
>> +??? if (unlikely(cmd == &cmd->queue->connect))
>> +??????? return;
> 
> if you don't return connect cmd to the list please don't add it to it in 
> the first place (during alloc_cmd). and if you use it once, we might 
> think of a cleaner/readable way to do it.
> 
> why there is a difference between regular cmd and connect_cmd ? can't 
> you increase the nr_cmds by 1 and not distinguish between the two types ?

We don't have the queue size before we connect, hence we allocate a
single command for nvmf connect and when we process it we allocate the
rest.

Its done this way such that the command processing code does not
differentiate this case with a dedicated condition, hence I prefer to
keep it in the command list for the first pass such that we don't have
this check in the normal command processing code.

The reason it doesn't go back to the list is because it does not
belong to the cmds array which we rely on to lookup our command context
based on the ttag.

>> +static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
>> +??????? struct socket *newsock)
>> +{
>> +??? struct nvmet_tcp_queue *queue;
>> +??? int ret;
>> +
>> +??? queue = kzalloc(sizeof(*queue), GFP_KERNEL);
>> +??? if (!queue)
>> +??????? return -ENOMEM;
>> +
>> +??? INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
>> +??? INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
>> +??? queue->sock = newsock;
>> +??? queue->port = port;
>> +??? queue->nr_cmds = 0;
>> +??? spin_lock_init(&queue->state_lock);
>> +??? queue->state = NVMET_TCP_Q_CONNECTING;
>> +??? INIT_LIST_HEAD(&queue->free_list);
>> +??? init_llist_head(&queue->resp_list);
>> +??? INIT_LIST_HEAD(&queue->resp_send_list);
>> +
>> +??? queue->idx = ida_simple_get(&nvmet_tcp_queue_ida, 0, 0, GFP_KERNEL);
>> +??? if (queue->idx < 0) {
>> +??????? ret = queue->idx;
>> +??????? goto out_free_queue;
>> +??? }
>> +
>> +??? ret = nvmet_tcp_alloc_cmd(queue, &queue->connect);
>> +??? if (ret)
>> +??????? goto out_ida_remove;
>> +
>> +??? ret = nvmet_sq_init(&queue->nvme_sq);
>> +??? if (ret)
>> +??????? goto out_ida_remove;
> 
> please add a goto free_connect_cmd:
> 
> nvmet_tcp_free_cmd(&queue->connect);
> 
> to avoid memory leak in error flow.

Will do, thanks.

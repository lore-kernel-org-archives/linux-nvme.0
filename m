From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 4 Apr 2018 16:06:22 +0300
Subject: [PATCH rfc 1/3] nvmet-rdma: automatic listening port re-activation
In-Reply-To: <2b3f168a-cf0c-f62d-ea37-42465c81c34d@mellanox.com>
References: <20180322190303.10951-1-sagi@grimberg.me>
 <20180322190303.10951-2-sagi@grimberg.me>
 <2b3f168a-cf0c-f62d-ea37-42465c81c34d@mellanox.com>
Message-ID: <6976a748-4c05-640c-ec9c-51882259a7b6@grimberg.me>


>> @@ -1413,23 +1356,22 @@ static int nvmet_rdma_add_port(struct 
>> nvmet_port *port)
>> ????????? goto out_destroy_id;
>> ????? }
>> -??? ret = rdma_bind_addr(cm_id, (struct sockaddr *)&addr);
>> +??? ret = rdma_bind_addr(cm_id, addr);
>> ????? if (ret) {
>> -??????? pr_err("binding CM ID to %pISpcs failed (%d)\n",
>> -??????????? (struct sockaddr *)&addr, ret);
>> +??????? pr_err("binding CM ID to %pISpcs failed (%d)\n", addr, ret);
>> ????????? goto out_destroy_id;
>> ????? }
>> ????? ret = rdma_listen(cm_id, 128);
>> ????? if (ret) {
>> -??????? pr_err("listening to %pISpcs failed (%d)\n",
>> -??????????? (struct sockaddr *)&addr, ret);
>> +??????? pr_err("listening to %pISpcs failed (%d)\n", addr, ret);
>> ????????? goto out_destroy_id;
>> ????? }
>> -??? pr_info("enabling port %d (%pISpcs)\n",
>> -??????? le16_to_cpu(port->disc_addr.portid), (struct sockaddr *)&addr);
>> -??? port->priv = cm_id;
>> +??? port->cm_id = cm_id;
>> +??? if (cm_id->device)
> 
> can device be NULL here ?

Yes, for unbound listeners.

>> +??? ret = nvmet_rdma_enable_port(port);
>> +??? if (ret)
>> +??????? schedule_delayed_work(&port->enable_work, HZ);
> 
> I think it's beter to schedule it after 5 seconds since we use the 
> system_wq and since it's a recovery process.

OK...

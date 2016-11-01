From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 1 Nov 2016 16:37:01 +0200
Subject: [PATCH] nvmet: Fix possible infinite loop triggered on hot
 namespace removal
In-Reply-To: <20161101134352.GA5096@infradead.org>
References: <1477819337-31190-1-git-send-email-sagi@grimberg.me>
 <20161101134352.GA5096@infradead.org>
Message-ID: <c94dab5e-cf77-b376-e1e0-3950be525e96@grimberg.me>


>>  void nvmet_ns_disable(struct nvmet_ns *ns)
>> @@ -324,13 +324,10 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
>>  	struct nvmet_subsys *subsys = ns->subsys;
>>  	struct nvmet_ctrl *ctrl;
>>
>> -	mutex_lock(&subsys->lock);
>> -	if (list_empty(&ns->dev_link)) {
>> -		mutex_unlock(&subsys->lock);
>> +	if (!test_and_clear_bit(NVMET_NS_ENABLED, &ns->flags))
>>  		return;
>> -	}
>> -	list_del_init(&ns->dev_link);
>> -	mutex_unlock(&subsys->lock);
>> +
>> +	list_del_rcu(&ns->dev_link);
>
> We'll still need the lock here, don't we?

we do... And we also need to protect with the subsys lock on
nvmet_ns_disable as a whole against concurrent enable/disable (unless
we want to add a new lock to nvmet_ns)

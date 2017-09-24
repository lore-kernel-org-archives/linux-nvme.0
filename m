From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 24 Sep 2017 16:03:55 +0300
Subject: [PATCH rfc] nvme-fabrics: request transport module
In-Reply-To: <20170924125507.GA11632@infradead.org>
References: <1506257125-15257-1-git-send-email-sagi@grimberg.me>
 <20170924125507.GA11632@infradead.org>
Message-ID: <74246ccf-53e3-7956-3117-16e44f2f8793@grimberg.me>


>> +
>> +	if (!strcmp(opts->transport, "rdma"))
>> +		mod_name = "nvme-rdma";
>> +	else if (!strcmp(opts->transport, "fc"))
>> +		mod_name = "nvme-fc";
>> +	else if (!strcmp(opts->transport, "loop"))
>> +		mod_name = "nvme-loop";
>> +	else
>> +		return -EINVAL;
>> +
>> +	ret = request_module(mod_name) < 0;
> 
> You can replace this whole function with:
> 
> 	request_module("nvme-%d", opts->transport);

Hahaha, how could I miss that?!

> Also if I remember correctly request_module returns an error if the
> driver is built-in, thus most callers either don't check the return
> value or just print a warning (I personally hate the warning, so I think
> we should just do the simple request_module call).

So skip the return value altogether? I don't mind that...

From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Nov 2018 13:26:12 -0800
Subject: [PATCH 10/11] nvmet-tcp: add NVMe over TCP target driver
In-Reply-To: <20181117.121510.1754018619653365187.davem@davemloft.net>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
 <20181115171626.9306-11-sagi@lightbitslabs.com>
 <20181117.121510.1754018619653365187.davem@davemloft.net>
Message-ID: <21b60ffc-d9eb-2f2e-fa1a-891f7f8d5239@grimberg.me>


>> +static unsigned nvmet_tcp_recv_budget = 8;
>> +module_param_named(recv_budget, nvmet_tcp_recv_budget, int, S_IRUGO | S_IWUSR);
>> +MODULE_PARM_DESC(recv_budget, "recvs budget");
>> +
>> +static unsigned nvmet_tcp_send_budget = 8;
>> +module_param_named(send_budget, nvmet_tcp_send_budget, int, S_IRUGO | S_IWUSR);
>> +MODULE_PARM_DESC(send_budget, "sends budget");
>> +
>> +static unsigned nvmet_tcp_io_work_budget = 64;
>> +module_param_named(io_work_budget, nvmet_tcp_io_work_budget, int, S_IRUGO | S_IWUSR);
>> +MODULE_PARM_DESC(io_work_budget, "io work budget");
> 
> I strongly suggest moving away from module parameters for this stuff.
> 
> Create a genetlink socket family and allow run time configuration of these knobs
> by the user.

Thanks for the feedback Dave.

Given that these are non-trivial knobs to configure at runtime, I think
that I'll degenerate them to sane defaults for the initial submission
and figure out what interface makes sense afterwards.

Now that I have your attention ;)
I would love you to look at skb_copy_and_hash_datagram_iter as these
changes will require an ack from you.

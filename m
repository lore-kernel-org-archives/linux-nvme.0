From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Nov 2018 13:37:03 -0800
Subject: [PATCH 10/11] nvmet-tcp: add NVMe over TCP target driver
In-Reply-To: <59335e55-7e19-3201-2f8b-beb681aba810@mellanox.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
 <20181115171626.9306-11-sagi@lightbitslabs.com>
 <20181117.121510.1754018619653365187.davem@davemloft.net>
 <59335e55-7e19-3201-2f8b-beb681aba810@mellanox.com>
Message-ID: <97c63ee4-62b5-b083-6b2e-28acf062b0ed@grimberg.me>


>>> +static unsigned nvmet_tcp_recv_budget = 8;
>>> +module_param_named(recv_budget, nvmet_tcp_recv_budget, int, S_IRUGO 
>>> | S_IWUSR);
>>> +MODULE_PARM_DESC(recv_budget, "recvs budget");
>>> +
>>> +static unsigned nvmet_tcp_send_budget = 8;
>>> +module_param_named(send_budget, nvmet_tcp_send_budget, int, S_IRUGO 
>>> | S_IWUSR);
>>> +MODULE_PARM_DESC(send_budget, "sends budget");
>>> +
>>> +static unsigned nvmet_tcp_io_work_budget = 64;
>>> +module_param_named(io_work_budget, nvmet_tcp_io_work_budget, int, 
>>> S_IRUGO | S_IWUSR);
>>> +MODULE_PARM_DESC(io_work_budget, "io work budget");
>> I strongly suggest moving away from module parameters for this stuff.
> 
> agree here.
> 
> also, Sagi, can you explain about the performance trade-offs seen during 
> your development for these values ?
> 
> are they HCA/NIC dependent ?
> 
> should send/recv ratio be 1:1 ?
> 
> should total/send/recv ratio be 8:1:1 ?

These are not really HW dependent at all, its more about the tradeoff
between aggregation vs. fairness multiplexing. The budgets are designed
to control how much a specific workload (e.g. nvme queue) can hog the
cpu/wire when nvmet is servicing a large number of hosts.

There no constraints about the ratios of the budgets. Its advised though
that the io_work_budget would be able to catch at least a few
sends/recvs for reasonable aggregation.

I commented to Dave that I prefer not to expose them at this point given
that they are not trivial and would require an additional interface to
the driver (and its corresponding tool chain).

From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 18 Nov 2018 00:48:57 +0200
Subject: [PATCH 10/11] nvmet-tcp: add NVMe over TCP target driver
In-Reply-To: <20181117.121510.1754018619653365187.davem@davemloft.net>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
 <20181115171626.9306-11-sagi@lightbitslabs.com>
 <20181117.121510.1754018619653365187.davem@davemloft.net>
Message-ID: <59335e55-7e19-3201-2f8b-beb681aba810@mellanox.com>


On 11/17/2018 10:15 PM, David Miller wrote:
> From: Sagi Grimberg <sagi at lightbitslabs.com>
> Date: Thu, 15 Nov 2018 09:16:22 -0800
>
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
> I strongly suggest moving away from module parameters for this stuff.

agree here.

also, Sagi, can you explain about the performance trade-offs seen during 
your development for these values ?

are they HCA/NIC dependent ?

should send/recv ratio be 1:1 ?

should total/send/recv ratio be 8:1:1 ?


>
> Create a genetlink socket family and allow run time configuration of these knobs
> by the user.
>
> Thanks.

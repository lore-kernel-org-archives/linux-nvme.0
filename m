From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 24 Jun 2018 19:16:32 +0300
Subject: [PATCH 1/1] nvme-fabrics: use default value for nr_io_queues
 setting
In-Reply-To: <d719bba4-f8a3-11ee-2f60-96fe60f5beba@mellanox.com>
References: <1529855352-29356-1-git-send-email-maxg@mellanox.com>
 <cd5e47cd-1f87-026e-42e7-7849f09b0e43@grimberg.me>
 <d719bba4-f8a3-11ee-2f60-96fe60f5beba@mellanox.com>
Message-ID: <1dc78764-cb3e-01c5-4c0e-e94c963d01b1@grimberg.me>


>>> We set default value for nr_io_queues to be num_online_cpus(). No need
>>> to call num_online_cpus() again since we can use the default value we
>>> set earlier.
>>
>> We should not override user arguments. plus num_online_cpus can change
>> from X to 1 and back to X...
> 
> but we set "opts->nr_io_queues = num_online_cpus();" in the beginning of 
> nvmf_parse_options function.

I misread this and thought that this was in the rdma transport, sorry.

I assume that still theoretically it can change during parse_options.
What is this needed again? Wouldn't it be better to remove it (or bound
it with num_possible_cpus) and have the transport clamp down to
num_online_cpus?

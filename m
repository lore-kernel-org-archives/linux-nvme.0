From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 24 Jun 2018 19:06:09 +0300
Subject: [PATCH 1/1] nvme-fabrics: use default value for nr_io_queues
 setting
In-Reply-To: <cd5e47cd-1f87-026e-42e7-7849f09b0e43@grimberg.me>
References: <1529855352-29356-1-git-send-email-maxg@mellanox.com>
 <cd5e47cd-1f87-026e-42e7-7849f09b0e43@grimberg.me>
Message-ID: <d719bba4-f8a3-11ee-2f60-96fe60f5beba@mellanox.com>



On 6/24/2018 7:01 PM, Sagi Grimberg wrote:
> 
>> We set default value for nr_io_queues to be num_online_cpus(). No need
>> to call num_online_cpus() again since we can use the default value we
>> set earlier.
> 
> We should not override user arguments. plus num_online_cpus can change
> from X to 1 and back to X...

but we set "opts->nr_io_queues = num_online_cpus();" in the beginning of 
nvmf_parse_options function.

I just don't want to call num_online_cpus() twice in the same function..

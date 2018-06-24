From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 24 Jun 2018 20:00:50 +0300
Subject: [PATCH 1/1] nvme-fabrics: use default value for nr_io_queues
 setting
In-Reply-To: <fb53218b-f792-5eb3-1243-29ad54480985@mellanox.com>
References: <1529855352-29356-1-git-send-email-maxg@mellanox.com>
 <cd5e47cd-1f87-026e-42e7-7849f09b0e43@grimberg.me>
 <d719bba4-f8a3-11ee-2f60-96fe60f5beba@mellanox.com>
 <1dc78764-cb3e-01c5-4c0e-e94c963d01b1@grimberg.me>
 <fb53218b-f792-5eb3-1243-29ad54480985@mellanox.com>
Message-ID: <6c2d398a-b88c-f030-202b-ccadb1e57d81@grimberg.me>


>>>>> We set default value for nr_io_queues to be num_online_cpus(). No need
>>>>> to call num_online_cpus() again since we can use the default value we
>>>>> set earlier.
>>>>
>>>> We should not override user arguments. plus num_online_cpus can change
>>>> from X to 1 and back to X...
>>>
>>> but we set "opts->nr_io_queues = num_online_cpus();" in the beginning 
>>> of nvmf_parse_options function.
>>
>> I misread this and thought that this was in the rdma transport, sorry.
>>
>> I assume that still theoretically it can change during parse_options.
>> What is this needed again? Wouldn't it be better to remove it (or bound
>> it with num_possible_cpus) and have the transport clamp down to
>> num_online_cpus?
>>
>>
> 
> The transport clamp it. I just noticed we set it twice by calling 
> num_online_cpus() in case we connect with --nr-io-queues options instead 
> of using the cached value.
> If you're ok with this we can leave it "as is".

I think it would be good to have default of num_online_cpus and bound
the user with num_possible_cpus instead (if the user asked for more than
online). The transport will clamp it down regardless, but if/when more
cpus come in, transport can re-adjust in the next reset.

thoughts?

From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 8 Jun 2017 13:16:25 +0300
Subject: [PATCH v3 for-4.13 2/6] mlx5: move affinity hints assignments to
 generic code
In-Reply-To: <CALzJLG_h8ig97uzz9S_4n-DhcFFi1e+WcUwLejM4cHUFd1MozA@mail.gmail.com>
References: <1496644560-28923-1-git-send-email-sagi@grimberg.me>
 <1496644560-28923-3-git-send-email-sagi@grimberg.me>
 <CALzJLG-SQj2OsOOjhHsMaD8gKC0JKD068L=ZjYRPBG=iwf9r8Q@mail.gmail.com>
 <20170607083156.GB24876@lst.de>
 <9332ed02-9711-0196-14d9-e9641c4dc932@grimberg.me>
 <CALzJLG_h8ig97uzz9S_4n-DhcFFi1e+WcUwLejM4cHUFd1MozA@mail.gmail.com>
Message-ID: <aff81384-517a-94e4-c743-8b89fd8cda1b@grimberg.me>


>>> is there any reason you want to start assining vectors on the local
>>> node?  This is doable, but would complicate the code quite a bit
>>> so it needs a good argument.
>>
>>
>> My interpretation is that mlx5 tried to do this for the (rather esoteric
>> in my mind) case where the platform does not have enough vectors for the
>> driver to allocate percpu. In this case, the next best thing is to stay
>> as close to the device affinity as possible.
>>
> 
> No, we did it for the reason that mlx5e netdevice assumes that
> IRQ[0]..IRQ[#num_numa/#cpu_per_numa]
> are always bound to the numa close to the device. and the mlx5e driver
> choose those IRQs to spread
> the RSS hash only into them and never uses other IRQs/Cores

OK, that explains a lot of weirdness I've seen with mlx5e.

Can you explain why you're using only a single numa node for your RSS
table? What does it buy you? You open RX rings for _all_ cpus but
only spread on part of them? I must be missing something here...

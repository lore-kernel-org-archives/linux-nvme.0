From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 16 Jun 2016 23:07:10 +0300
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <01b501d1c809$92cb1a60$b8614f20$@opengridcomputing.com>
References: <00d801d1c7de$e17fc7d0$a47f5770$@opengridcomputing.com>
 <20160616145724.GA32635@infradead.org>
 <017001d1c7e7$95057270$bf105750$@opengridcomputing.com>
 <5763044A.9090206@grimberg.me>
 <01b501d1c809$92cb1a60$b8614f20$@opengridcomputing.com>
Message-ID: <576306EE.4020306@grimberg.me>


>>
>> Umm, I think this might be happening because we get to delete_ctrl when
>> one of our queues has a NULL ctrl. This means that either:
>> 1. we never got a chance to initialize it, or
>> 2. we already freed it.
>>
>> (1) doesn't seem possible as we have a very short window (that we're
>> better off eliminating) between when we start the keep-alive timer (in
>> alloc_ctrl) and the time we assign the sq->ctrl (install_queue).
>>
>> (2) doesn't seem likely either to me at least as from what I followed,
>> delete_ctrl should be mutual exclusive with other deletions, moreover,
>> I didn't see an indication in the logs that any other deletions are
>> happening.
>>
>> Steve, is this something that started happening recently? does the
>> 4.6-rc3 tag suffer from the same phenomenon?
>
> I'll try and reproduce this on the older code, but the keep-alive timer fired
> for some other reason,

My assumption was that it fired because it didn't get a keep-alive from
the host which is exactly what it's supposed to do?

> so I'm not sure the target side keep-alive has been
> tested until now.

I tested it, and IIRC the original patch had Ming's tested-by tag.

> But it is easy to test over iWARP, just do this while a heavy
> fio is running:
>
> ifconfig ethX down; sleep 15; ifconfig ethX <ipaddr>/<mask> up

So this is related to I/O load then? Does it happen when
you just do it without any I/O? (or small load)?

From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 10 Jul 2017 11:46:47 +0300
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <2b758039-5957-96b5-bf30-5cbb5515fe9c@suse.de>
References: <20170707094838.GD16648@linux-x5ow.site>
 <a34f03ac-4306-ba87-e6f4-fc29bfd80828@grimberg.me>
 <2b758039-5957-96b5-bf30-5cbb5515fe9c@suse.de>
Message-ID: <6eff23f4-1bb7-3c64-6916-987f4b38ae78@mellanox.com>



On 7/10/2017 10:17 AM, Hannes Reinecke wrote:
> On 07/10/2017 09:06 AM, Sagi Grimberg wrote:
>> Hey Johannes,
>>
>>> I'm seeing this on stock v4.12 as well as on our backports.
>>>
>>> My current hypothesis is that I saturate the RDMA link so the
>>> keepalives have
>>> no chance to get to the target.
>>
>> Your observation seems correct to me, because we have no
>> way to guarantee that a keep-alive capsule will be prioritized higher
>> than normal I/O in the fabric layer (as you said, the link might be
>> saturated).
>>
>>> Is there a way to priorize the admin queue somehow?
>>
>> Not really (at least for rdma). We made kato configurable,
>> perhaps we should give a higher default to not see it even
>> in extreme workloads?
>>
>> Couple of questions:
>> - Are you using RoCE (v2 or v1)? or Infiniband?
>> - Does it happen with mlx5 as well?
>> - Are host/target connected via switch/router? if so is flow-control
>>   on? and what are the host/target port speeds?
>> - Can you try and turn debug logging to know what delays (keep-alive
>>   from host to target or the keep-alive response)?
>> - What kato is required to not stumble on this?
>>

Sagi,
see some answers from Johannes to my questions earlier.


> Well, this sounds identically to the path_checker problem we're having
> in multipathing (and hch complained about several times).
> There's a rather easy solution to it: don't send keepalives if I/O is
> running, but rather tack it on the most current I/O packet.
> In the end, you only want to know if the link is alive; you don't have
> to transfer any data as such.
> So if you just add a flag (maybe on the RDMA layer) to the next command
> to be sent you could easily simulate keepalive without having to send
> additional commands.

Hannes,
This is a good solution and actually the way we work in iSCSI/iSER with 
nopin/nopout.
Don't you think it should be a ctrl attribute ?

>
> (Will probably break all sorts of layering, but if you push it down far
> enough maybe no-one will notice.)
> (And if hch complains ... well .. he invented the thing, didn't he?)
>
> Cheers,
>
> Hannes
>

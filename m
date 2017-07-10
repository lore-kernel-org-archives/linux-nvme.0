From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 15:04:52 +0300
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <20170710115003.GH5105@linux-x5ow.site>
References: <20170707094838.GD16648@linux-x5ow.site>
 <a34f03ac-4306-ba87-e6f4-fc29bfd80828@grimberg.me>
 <2b758039-5957-96b5-bf30-5cbb5515fe9c@suse.de>
 <6eff23f4-1bb7-3c64-6916-987f4b38ae78@mellanox.com>
 <20170710091054.GD5105@linux-x5ow.site>
 <a940a9ea-c090-6620-a080-eb7cf6140ad3@grimberg.me>
 <20170710102049.GF5105@linux-x5ow.site>
 <77c7d11c-bd67-8663-cc10-da3af8bfcd22@grimberg.me>
 <20170710113353.GG5105@linux-x5ow.site>
 <ebc9dccc-ce68-f5f3-3e24-372b2cd7f44b@grimberg.me>
 <20170710115003.GH5105@linux-x5ow.site>
Message-ID: <4df0a8a8-168f-06c4-6112-dfd2893d6e06@grimberg.me>


>>> [353698.784927] nvme nvme0: creating 44 I/O queues.
>>> [353699.572467] nvme nvme0: new ctrl: NQN
>>> "nqn.2014-08.org.nvmexpress:NVMf:uuid:c36f2c23-354d-416c-95de-f2b8ec353a82",
>>> addr 1.1.1.2:4420
>>> [353960.804750] nvme nvme0: SEND for CQE 0xffff88011c0cca58 failed with status
>>> transport retry counter exceeded (12)
>>
>> Exhausted retries, wow... That is really strange...
>>
>> Host sent the keep-alive and it never made it to the host, the HCA
>> retried for 7+ times and gave up.
>>
>> Are you running with a switch? which one? is the switch experience
>> higher ingress?
> 
> This (unfortunately) was the OmniPath setup as I only was a guest on the IB
> installation and the other team needed it back. Anyways I did see this on IB
> as well (regardless of SLE12-SP3 and v4.12 final). The switch is an Intel Edge
> 100 OmniPath switch.

Note that your keep-alive does not fail after 120 seconds, it is failed
by the HCA after 7 HCA retries (which is roughly around 35 seconds).

And if your keep-alive did not make it in 35 seconds, then its an
indication that something is wrong... which is exactly what keep-alives
are designed to do... So I'm not at all sure that we need to compensate
for this in the driver at all, something is clearly wrong in your
fabric.

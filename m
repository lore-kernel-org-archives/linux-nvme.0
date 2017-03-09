From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 9 Mar 2017 12:04:21 +0100
Subject: Need some pointers to debug a KASAN splat in NVMe over Fabrics
 with rdma-rxe
In-Reply-To: <CAG9sBKNXwHFkmQYsOPPu40822h6Z7J3+63CaZ844juZp5hfHfg@mail.gmail.com>
References: <5b16edcf-c39a-bc4b-0e32-8ccfb5d75efb@suse.de>
 <CAG9sBKPwEryc7U+hV=XJvRrFFhNvoktDOtwwS6piUw=cQ=bZhA@mail.gmail.com>
 <38a12b22-7bad-c069-4c96-39fc93d20d79@suse.de>
 <CAG9sBKNXwHFkmQYsOPPu40822h6Z7J3+63CaZ844juZp5hfHfg@mail.gmail.com>
Message-ID: <2f03bad8-02a2-067a-2d3c-20cd3c974519@suse.de>

On 03/09/2017 11:59 AM, Moni Shoua wrote:
>>> 2. You can take a look at librxe implementation of init_send_wqe() (it
>>> looks slightly different from kernel's implementation) and see what
>>> happens if you change implementation accordingly.
>>
>> OK I'll have a look and hopefully come back with a (RFC) patch (fingers
>> crossed).
> 
> Thanks. Waiting to see what you found and in the meantime I'll try to
> reproduce in my setup

>From what I can see librxe will have the same problem. The affected
code's more or less a copy of the kernel version.

I'm currently skimming through mlx5/qp.c trying to understand the known
good code path.

Byte,
	Johannes


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850

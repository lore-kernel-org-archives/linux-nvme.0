From: sagi@lightbits.io (Sagi Grimberg)
Date: Thu, 9 Jun 2016 15:30:05 +0300
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <1218382158.32228335.1465474321289.JavaMail.zimbra@kalray.eu>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <575936F0.9000600@lightbits.io>
 <574056153.32082017.1465466832847.JavaMail.zimbra@kalray.eu>
 <57594E81.9060302@lightbits.io>
 <1218382158.32228335.1465474321289.JavaMail.zimbra@kalray.eu>
Message-ID: <5759614D.5080703@lightbits.io>


>> Which device are you using? Are you running on a low memory machine?
>> Perhaps the rdma rw code needs to check max_mr capability?
>>
>
> It's a rather big machine with 8 cores/16GB of memory, never had memory
> limitation problems on this one. The card is a Chelsio T5. One of the
> targets of this configuration is to check if it works with this card.

So it must come from the Chelsio device then...

Can you provide the max_mr output of the device (you can use
ibv_devinfo -v from libibverbs/ibverbs-utils).

What happens if you use smaller queues, say 64/32 (can be added as a
queue_size parameter working directly from sysfs, nvme-cli does not
support this yet).

Steve, did you see this before? I'm wandering if we need some sort
of logic handling with resource limitation in iWARP (global mrs pool...)

From: mrybczyn@kalray.eu (Marta Rybczynska)
Date: Thu, 30 Mar 2017 16:23:28 +0200 (CEST)
Subject: [PATCH RFC] nvme-rdma: support devices with queue size < 32
In-Reply-To: <2ba93b5b-ad36-5533-36e2-9db2e3198c19@grimberg.me>
References: <1315914765.312051621.1490259849534.JavaMail.zimbra@kalray.eu>
 <20170329132918.GA32072@obsidianresearch.com>
 <406682b9-d7ca-4718-5830-7940d2822bc0@grimberg.me>
 <20170329162751.GA7113@obsidianresearch.com>
 <80770042-743e-a271-c636-f72099f9ac56@grimberg.me>
 <9eb08168-18a6-a176-01df-b68b6a225963@redhat.com>
 <3505b835-d0ba-70cb-dfe8-1265fc2bbb83@redhat.com>
 <2ba93b5b-ad36-5533-36e2-9db2e3198c19@grimberg.me>
Message-ID: <1121115847.336382032.1490883808617.JavaMail.zimbra@kalray.eu>

>>> You say above "we post *up to* 2 work requests", unless you wish to
>>> change that to "we always post at least 2 work requests per queue
>>> entry", Jason is right, your frequency of signaling needs to be X/2
>>> regardless of your CQ size, you need the signaling to control the queue
>>> depth tracking.
>>
>> If you would like to spread things out farther between signaling, then
>> you can modify your send routine to only increment the send counter for
>> actual send requests, ignoring registration WQEs and invalidate WQES,
>> and then signal every X/2 sends.
> 
> Yea, you're right, and not only I got it wrong, I even contradicted my
> own suggestion that was exactly what you and Jason suggested (where is
> the nearest rat-hole...)
> 
> So I suggested to signal every X/2 and Marta reported SQ overflows for
> high queue-dpeth. Marta, at what queue-depth have you seen this?

The remote side had queue depth of 16 or 32 and that's the WQ on the
initiator side that overflows (mlx5_wq_overflow). We're testing with
signalling X/2 and it seems to work.

Marta

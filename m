From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 5 Jun 2017 20:23:02 +0300
Subject: NVMeoF: multipath stuck after bringing one ethernet port down
In-Reply-To: <20170605150755.GA29050@lst.de>
References: <CAK0KL7DPLw+0AB8cGop7jowfE1HV9wyXBmJhE90trpor-PcSYw@mail.gmail.com>
 <ebb7ffb8-4dec-5540-5cef-ffd36bef3e25@grimberg.me>
 <fa6277fa-948f-103e-1322-f8b2362467c3@gmail.com>
 <656fd267-1e01-b561-fc74-e36c1892d1f9@gmail.com>
 <5b5b0a61-41cc-8018-19db-f683a604d7e4@grimberg.me>
 <48b14a96-e419-f6d1-090e-cbe774139e11@mellanox.com>
 <459af627-3918-768e-c35f-3f99768b82cb@grimberg.me>
 <20170605084037.GB22677@lst.de>
 <d249a6d7-ae57-f9a1-e423-659cfa47c764@grimberg.me>
 <20170605150755.GA29050@lst.de>
Message-ID: <53cbf112-9271-f2b1-ab22-f5948e6dbba6@grimberg.me>


>>> So this looks somewhat bogus to me, while the rest looks ok.
>>
>> The point here is that RECONNECTING is a ctrl state that has a
>> potential to linger for a long time (unlike RESETTING or DELETING),
>> so we don't want to trigger requeue right away.
>>
>> I'm open to other ideas. I just want to prevent triggering a redundant
>> loop of queue_rq -> fail with BUSY -> queue_rq -> fail with BUSY ...
>>
>> Thoughts?
> 
> Let's get this patch in, then sort out a common stratefy for the
> dev_loss_tmo for all drivers, as FC is already doing some work in
> that area.

It's not dev_loss_tmo (timeout to give up on reconnect attempts),
but yea, I agree. I'll send a patch.

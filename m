From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 6 Nov 2016 19:19:58 +0200
Subject: [PATCH] nvmet-rdma: add queue to queue list only if connection
 established
In-Reply-To: <20161106164354.GH15675@lst.de>
References: <1478425690-32460-1-git-send-email-sagi@grimberg.me>
 <20161106164354.GH15675@lst.de>
Message-ID: <35adcd52-5c04-8c01-0f2e-cc700f6c3432@grimberg.me>


>> In case we accepted a queue connection and it failed, we might not
>> remove the queue from the list. Instead of dealing with it, simply
>> add the insert the queue only if we successfully established.
>
> But that means we'd potentionally leak it when unloading the module,
> if that happens at just the wrong time, don't we?

Yea... didn't think of that. I started with removing from the list on
connect failure too but thought this would be better...

I'll reverse the strategy again...

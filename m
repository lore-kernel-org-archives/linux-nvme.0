From: sagi@lightbits.io (Sagi Grimberg)
Date: Wed, 22 Jun 2016 19:31:59 +0300
Subject: [PATCH 0/2] Get rid of transport layer retry count config
 parameter
In-Reply-To: <20160622161559.GA18361@infradead.org>
References: <1466597161-5242-1-git-send-email-sagi@grimberg.me>
 <20160622161559.GA18361@infradead.org>
Message-ID: <576ABD7F.1030204@grimberg.me>


>> This parameter was added in order to support a proper timeout for
>> error recovery before the spec defined a periodic keep-alive.
>>
>> Now that we have periodic keep-alive, we don't need a user configurable
>> transport layer retry count, the keep-alive timeout is sufficient,
>> transports can retry for as long as they see fit.
>
> Isn't there some IB protocol level rationale for a low retry count
> in various fabric setups?

None that I know of... The QP retry count determines the time it would
take to fail a send/read/write.. The retry_count value is multiplied
with the packet timeout (which is a result of an IB specific
computation - managed by the CM).

It's useful when one needs to limit the time until a send fails in order
to kick error recovery (useful for srp which doesn't implement periodic
keep-alive), but since nvme does, I don't see the reason why RDMA or any
other transport should expose this configuration as the keep-alive
timeout exists for that.

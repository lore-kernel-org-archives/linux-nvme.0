From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 23 Jun 2016 10:09:36 +0300
Subject: [PATCH 0/2] Get rid of transport layer retry count config
 parameter
In-Reply-To: <20160622203110.GA20838@obsidianresearch.com>
References: <1466597161-5242-1-git-send-email-sagi@grimberg.me>
 <20160622161559.GA18361@infradead.org>
 <20160622203110.GA20838@obsidianresearch.com>
Message-ID: <576B8B30.8080402@grimberg.me>


>>> This parameter was added in order to support a proper timeout for
>>> error recovery before the spec defined a periodic keep-alive.
>>>
>>> Now that we have periodic keep-alive, we don't need a user configurable
>>> transport layer retry count, the keep-alive timeout is sufficient,
>>> transports can retry for as long as they see fit.
>>
>> Isn't there some IB protocol level rationale for a low retry count
>> in various fabric setups?
>
> IIRC the retry count is part of what drives the APM switch over, so
> APM configuration should use a lower value.

Completely agree Jason. Lowering the retry_count is very useful
for APM (Automatic Path Migration).

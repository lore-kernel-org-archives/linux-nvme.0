From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 20 Mar 2019 11:38:30 -0700
Subject: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
In-Reply-To: <20190319152533.GD24176@localhost.localdomain>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
 <1552930085.152266.36.camel@acm.org>
 <3cd58454-eda3-de9a-0eed-b6a7edbce28f@oracle.com>
 <1553008222.152266.43.camel@acm.org>
 <20190319152533.GD24176@localhost.localdomain>
Message-ID: <5879cad9-9d47-4690-0f85-00835346029b@grimberg.me>


>> Hi Jianchao,
>>
>> I think that's an additional reason to rewrite NVMe error handling ...
> 
> Nonesense. Block timeout handling runs in a work queue precicesly so
> handlers can actually do useful work in line with the notification.

I have to agree with Keith on this one, there is absolutely no reason to
force this constraint on the error handler. If we want to teardown stuff
to guarantee that we can free the request safely we may very well need
to block on queue flushing.

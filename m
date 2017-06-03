From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 3 Jun 2017 10:31:34 +0300
Subject: [PATCH] nvme: fix multiple ctrl removal scheduling
In-Reply-To: <20170602172838.GB22858@dhcp-216.srv.tuxera.com>
References: <20170601140629.15313-1-hch@lst.de>
 <20170601140629.15313-2-hch@lst.de>
 <3db3cb8f-0851-f114-2fc6-4710d5aab2db@grimberg.me>
 <20170601154107.GA8118@lst.de>
 <024d059e-cd79-78cb-f367-0630d8387ce2@grimberg.me>
 <20170602172838.GB22858@dhcp-216.srv.tuxera.com>
Message-ID: <823787c5-6bec-9d8f-c63d-76c876177b31@grimberg.me>


> cancel_work_sync seems to be a good idea

In fact, I think we should have it independently of
the state discussion, it healthy to make sure nothing runs
concurrently with remove.

> but I would still consider
> new state to be a better alternative as it seems to make overal design
> simpler.

I'm still not convinced on why adding a new state is making things
simpler.

> 
> Anyway, once we can decide which way to go, I would be happy to give
> this a test spin.

Keith, Christoph? can you please explain again why adding a new
state is better?

> You just forgot to remove the now reduntant WARN_ON
> in untested one but of course this was just untested and for
> demonstration only.

Obviously.

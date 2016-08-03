From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 3 Aug 2016 12:48:07 +0300
Subject: [PATCH] nvmet-rdma: Don't use the inline buffer in order to avoid
 allocation for small reads
In-Reply-To: <20160802161526.GA14964@obsidianresearch.com>
References: <1470040599-7294-1-git-send-email-sagi@grimberg.me>
 <20160802125042.GB13235@lst.de>
 <157675f0-0576-1cc9-1f99-c0944185e3c5@grimberg.me>
 <20160802161526.GA14964@obsidianresearch.com>
Message-ID: <c19f2c29-34e9-5cba-2fba-9c72ce15c14e@grimberg.me>


>> that is currently being sent (its a rare race condition, but
>> theoretically possible). The reason is that we repost the inline data
>> buffer for receive before we post the send request. We used to have
>
> ?? The same buffer is posted at the same time for send and recv? That
> is never OK, SRQ or not.

I agree.

But I agree its a shame to lose this. Maybe if we over-allocate cmds
and restore the receive repost to be after the send completion? I'm not
too fond of that either (it's not just commands but also inline
pages...)

From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 26 Jun 2016 18:48:26 +0300
Subject: [PATCH 0/2] Get rid of transport layer retry count config
 parameter
In-Reply-To: <20160624071336.GE4252@infradead.org>
References: <1466597161-5242-1-git-send-email-sagi@grimberg.me>
 <20160622161559.GA18361@infradead.org>
 <20160622203110.GA20838@obsidianresearch.com> <576B8B30.8080402@grimberg.me>
 <20160624071336.GE4252@infradead.org>
Message-ID: <576FF94A.3040705@grimberg.me>


>> Completely agree Jason. Lowering the retry_count is very useful
>> for APM (Automatic Path Migration).
>
> Does this mean you're retracting the patches?

I'm not, were not using APM anywhere in nvme-rdma. multipathing
is done at a higher level than the transport.

Do you see a reason to keep this? I'm not too enthusiast with leaving
configs that aren't absolutely needed. As mentioned this config was
added to add a fast-fail functionality before we defined the periodic 
keep-alive...

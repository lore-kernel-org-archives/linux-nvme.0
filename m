From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 17 Jul 2016 14:52:45 +0300
Subject: [PATCH 0/2] Get rid of transport layer retry count config
 parameter
In-Reply-To: <20160624071336.GE4252@infradead.org>
References: <1466597161-5242-1-git-send-email-sagi@grimberg.me>
 <20160622161559.GA18361@infradead.org>
 <20160622203110.GA20838@obsidianresearch.com> <576B8B30.8080402@grimberg.me>
 <20160624071336.GE4252@infradead.org>
Message-ID: <578B718D.2090909@grimberg.me>


>> Completely agree Jason. Lowering the retry_count is very useful
>> for APM (Automatic Path Migration).
>
> Does this mean you're retracting the patches?

No, we never use APM in nvme-rdma, so I don't see a good reason
why we should keep it around....

Can I get a review on this btw?

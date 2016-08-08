From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 8 Aug 2016 06:24:12 -0700
Subject: [RFC 2/2] nvmet-rdma: Matching rdma WC to rdma queue according
 to WC QP
In-Reply-To: <fc554a3e-1177-31ae-38ba-ba8de9fb5c88@grimberg.me>
References: <1470654019-717-1-git-send-email-roysh@mellanox.com>
 <1470654019-717-2-git-send-email-roysh@mellanox.com>
 <fc554a3e-1177-31ae-38ba-ba8de9fb5c88@grimberg.me>
Message-ID: <20160808132412.GA20901@infradead.org>

On Mon, Aug 08, 2016@02:35:19PM +0300, Sagi Grimberg wrote:
> Christoph and I had some discussions over that in the past. We came to
> the conclusion that a RDMA core API for per-cpu CQ pools might be
> beneficial for other target mode drivers (isert, srpt).
> 
> I even had an RFC in the works, but it kinda got left behind... It'd be
> great if you can take it from there...

I've picked it up again and how to be able to post something in a week
or two.

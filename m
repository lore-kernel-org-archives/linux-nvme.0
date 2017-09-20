From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 20 Sep 2017 07:57:01 -0700
Subject: [REPOST][PATCH v3] nvmet: implement valid sqhd values in
 completions
In-Reply-To: <1d417d0e-3ae8-7928-d3ab-ebd70657f8e5@grimberg.me>
References: <20170918160829.895-1-jsmart2021@gmail.com>
 <1d417d0e-3ae8-7928-d3ab-ebd70657f8e5@grimberg.me>
Message-ID: <20170920145701.GA7561@infradead.org>

On Wed, Sep 20, 2017@02:14:02PM +0300, Sagi Grimberg wrote:
> > -	if (likely(req->sq)) /* may happen during early failure */
> > -		req->rsp->sq_id = cpu_to_le16(req->sq->qid);
> 
> It wasn't documented why it is safe to remove the condition statement.

I'll add something to the commit log based on the discussion on the
list on the previous iteration.

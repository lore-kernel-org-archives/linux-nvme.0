From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 22 Mar 2019 11:55:13 -0700
Subject: [RFC] optimize nvme single segment I/O
In-Reply-To: <20190321231037.25104-1-hch@lst.de>
References: <20190321231037.25104-1-hch@lst.de>
Message-ID: <c7c95931-2e6c-60c6-b9ab-606a7a166410@grimberg.me>


> Hi all,
> 
> with all the discussion on small I/O performance lately I thought
> it was time off to dust my old idea to optimize this path a bit
> by avoiding to build a scatterlist.  I've only done very basic
> testing because I've been a bit busy, but I thought it might be
> worthwhile to get it out for feedback.

This looks good Christoph! for the series,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

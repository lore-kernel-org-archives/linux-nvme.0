From: hch@lst.de (Christoph Hellwig)
Date: Fri, 15 Mar 2019 10:20:20 +0100
Subject: [PATCH 0/8]: blk-mq: use static_rqs to iterate busy tags
In-Reply-To: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20190315092020.GA2405@lst.de>

On Fri, Mar 15, 2019@04:57:36PM +0800, Jianchao Wang wrote:
> Hi Jens
> 
> As we know, there is a risk of accesing stale requests when iterate
> in-flight requests with tags->rqs[] and this has been talked in following
> thread,
> [1] https://marc.info/?l=linux-scsi&m=154511693912752&w=2
> [2] https://marc.info/?l=linux-block&m=154526189023236&w=2

I'd rather take one step back and figure out why we are iterating
the busy requests.  There really shouldn't be any reason why a driver
is even doings that (vs some error handling helpers in the core
block code that can properly synchronize).

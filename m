From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 18 Apr 2017 10:33:46 -0400
Subject: kill req->errors
In-Reply-To: <20170407071124.GA26481@lst.de>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406200024.GC6140@localhost.localdomain>
 <20170407071124.GA26481@lst.de>
Message-ID: <20170418143346.GA10356@char.us.oracle.com>

On Fri, Apr 07, 2017@09:11:24AM +0200, Christoph Hellwig wrote:
> On Thu, Apr 06, 2017@04:00:24PM -0400, Konrad Rzeszutek Wilk wrote:
> > You wouldn't have a git tree to easily test it? Thanks.
> 
> git://git.infradead.org/users/hch/block.git request-errors
> 
> Gitweb:
> 
> http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/request-errors

I tested it with Xen and it all worked out. Albeit in hindsight I didn't check
the ones that matter - that is the error paths (duh!).

So let me do that now.

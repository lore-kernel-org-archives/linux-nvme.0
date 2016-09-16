From: hch@infradead.org ('Christoph Hellwig')
Date: Fri, 16 Sep 2016 07:26:49 -0700
Subject: crash when connecting to targets using nr_io_queues < num cpus
In-Reply-To: <005101d21024$1f8913f0$5e9b3bd0$@opengridcomputing.com>
References: <011401d203c4$0cdd78c0$26986a40$@opengridcomputing.com>
 <6082d700-a45c-b00a-3f09-ba6196cc3e5e@grimberg.me>
 <00ae01d2045a$a8516500$f8f42f00$@opengridcomputing.com>
 <01b401d20483$2da4fd20$88eef760$@opengridcomputing.com>
 <e31f7c2f-7b15-95f9-f882-4406c94eaedc@grimberg.me>
 <018701d20dca$22a02080$67e06180$@opengridcomputing.com>
 <20160913175223.GB13741@localhost.localdomain>
 <005101d21024$1f8913f0$5e9b3bd0$@opengridcomputing.com>
Message-ID: <20160916142649.GA18798@infradead.org>

On Fri, Sep 16, 2016@09:10:48AM -0500, Steve Wise wrote:
> Is this the series?
> 
> https://lwn.net/Articles/700625/

I don't see how that would change any kinds of mapping for fabrics.

> If not, is there something I can try out?

Let me dig through the thread and see what I can do.

From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 22 Sep 2016 17:03:31 -0500
Subject: crash when connecting to targets using nr_io_queues < num cpus
In-Reply-To: <20160922214800.GA16008@infradead.org>
References: <6082d700-a45c-b00a-3f09-ba6196cc3e5e@grimberg.me>
 <00ae01d2045a$a8516500$f8f42f00$@opengridcomputing.com>
 <01b401d20483$2da4fd20$88eef760$@opengridcomputing.com>
 <e31f7c2f-7b15-95f9-f882-4406c94eaedc@grimberg.me>
 <018701d20dca$22a02080$67e06180$@opengridcomputing.com>
 <20160913175223.GB13741@localhost.localdomain>
 <005101d21024$1f8913f0$5e9b3bd0$@opengridcomputing.com>
 <20160916142649.GA18798@infradead.org> <20160922210255.GA11015@infradead.org>
 <023c01d21519$b3cda450$1b68ecf0$@opengridcomputing.com>
 <20160922214800.GA16008@infradead.org>
Message-ID: <024101d2151d$27f813d0$77e83b70$@opengridcomputing.com>

> 
> On Thu, Sep 22, 2016@04:38:48PM -0500, Steve Wise wrote:
> > > Steve,
> > >
> > > can you test if the patch below properly fails the connect and avoids
> > > the crash?
> > >
> >
> > Is this the expected error?
> 
> Yes.
> 

Ok then.  Tested-by: Steve Wise <swise at opengridcomputing.com>

I haven't tried ignoring this error when connecting yet...

Stevo

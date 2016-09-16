From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 16 Sep 2016 09:10:48 -0500
Subject: crash when connecting to targets using nr_io_queues < num cpus
In-Reply-To: <20160913175223.GB13741@localhost.localdomain>
References: <011401d203c4$0cdd78c0$26986a40$@opengridcomputing.com>
 <6082d700-a45c-b00a-3f09-ba6196cc3e5e@grimberg.me>
 <00ae01d2045a$a8516500$f8f42f00$@opengridcomputing.com>
 <01b401d20483$2da4fd20$88eef760$@opengridcomputing.com>
 <e31f7c2f-7b15-95f9-f882-4406c94eaedc@grimberg.me>
 <018701d20dca$22a02080$67e06180$@opengridcomputing.com>
 <20160913175223.GB13741@localhost.localdomain>
Message-ID: <005101d21024$1f8913f0$5e9b3bd0$@opengridcomputing.com>

> > > >>
> > > >> http://lists.infradead.org/pipermail/linux-nvme/2016-June/004884.html
> > > >
> > > > This is indeed the same problem.  I don't have the knoggin to propose a
fix.
> > > > Sagi/Christoph, do you have any ideas on this?  I'm willing to take and
idea
> > > > forward and test it out of you all have any clever ideas.  We should at
> > least
> > > > prevent setting nr_io_queues to a value that will crash immediately when
> > nvmf is
> > > > used...
> > >
> > > I think that Ming and Keith had a few suggestions.
> > >
> > > ++ Keith.
> > >
> >
> > Ming has been silent. :(  Keith, any thoughts on this?
> 
> Sorry, I've also been side tracked. :(
> 
> Offline, I've been reviewing and testing new mappings from Christoph
> and Thomas that should get all the queues assigned. It wasn't developed
> specically for this issue, but it should fix this anyway. I think the
> new mapping is really close to being ready for public consideration,
> but I'll wait for Christoph on that.
> 

Hey Christoph,

Is this the series?

https://lwn.net/Articles/700625/

If not, is there something I can try out?

Steve.

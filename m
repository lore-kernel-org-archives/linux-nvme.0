From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 29 Aug 2016 09:43:47 -0500
Subject: [PATCH] nvme-cli/fabrics: Add nr_io_queues parameter to connect
 command
In-Reply-To: <20160829080219.GA11787@infradead.org>
References: <20160826160112.495DFE08C5@smtp.ogc.us>
 <1472443902.2832.8.camel@linux.intel.com>
 <20160829080219.GA11787@infradead.org>
Message-ID: <008601d20203$bfe885d0$3fb99170$@opengridcomputing.com>

> On Sun, Aug 28, 2016@09:11:42PM -0700, J Freyensee wrote:
> > On Fri, 2016-08-26@08:56 -0700, Steve Wise wrote:
> > > Added 'nr_io_queues' to 'connect' command so users can specify the
> > > number
> > > of io queues to allocate.
> > >
> > > usage example:
> > >
> > > nvme connect -t rdma -Q 8 -s 4420 -a 10.0.1.14 -n test-nvme
> >
> > I was just wondering if there could be another lower-case letter flag
> > option we could use other than capital Q. ??Just looking at the example
> > above, it looks a tad out-of-place.
> 
> -q would be nice. For that'd we need to rename the hostnqn one, but as
> stated before I think -q is really misnamed for that anyway..

-h for hostnqn? 

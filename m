From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 29 Aug 2016 10:09:54 -0500
Subject: [PATCH] nvme-cli/fabrics: Add nr_io_queues parameter to connect
 command
In-Reply-To: <00c301d20206$beb09ab0$3c11d010$@opengridcomputing.com>
References: <20160826160112.495DFE08C5@smtp.ogc.us>
 <1472443902.2832.8.camel@linux.intel.com>
 <20160829080219.GA11787@infradead.org>
 <008601d20203$bfe885d0$3fb99170$@opengridcomputing.com>
 <00c301d20206$beb09ab0$3c11d010$@opengridcomputing.com>
Message-ID: <00c501d20207$65b43060$311c9120$@opengridcomputing.com>

> > > > > usage example:
> > > > >
> > > > > nvme connect -t rdma -Q 8 -s 4420 -a 10.0.1.14 -n test-nvme
> > > >
> > > > I was just wondering if there could be another lower-case letter flag
> > > > option we could use other than capital Q. ??Just looking at the example
> > > > above, it looks a tad out-of-place.
> > >
> > > -q would be nice. For that'd we need to rename the hostnqn one, but as
> > > stated before I think -q is really misnamed for that anyway..
> >
> > -h for hostnqn?
> 
> Oops... -h is 'help' :)

Could use -i for nr-io-queues...

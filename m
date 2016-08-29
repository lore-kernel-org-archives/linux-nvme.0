From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 29 Aug 2016 08:14:31 -0700
Subject: [PATCH] nvme-cli/fabrics: Add nr_io_queues parameter to connect
 command
In-Reply-To: <00c301d20206$beb09ab0$3c11d010$@opengridcomputing.com>
References: <20160826160112.495DFE08C5@smtp.ogc.us>
 <1472443902.2832.8.camel@linux.intel.com>
 <20160829080219.GA11787@infradead.org>
 <008601d20203$bfe885d0$3fb99170$@opengridcomputing.com>
 <00c301d20206$beb09ab0$3c11d010$@opengridcomputing.com>
Message-ID: <1472483671.2816.19.camel@linux.intel.com>

On Mon, 2016-08-29@10:05 -0500, Steve Wise wrote:
> > 
> > > 
> > > On Sun, Aug 28, 2016@09:11:42PM -0700, J Freyensee wrote:
> > > > 
> > > > On Fri, 2016-08-26@08:56 -0700, Steve Wise wrote:
> > > > > 
> > > > > Added 'nr_io_queues' to 'connect' command so users can
> > > > > specify the
> > > > > number
> > > > > of io queues to allocate.
> > > > > 
> > > > > usage example:
> > > > > 
> > > > > nvme connect -t rdma -Q 8 -s 4420 -a 10.0.1.14 -n test-nvme
> > > > 
> > > > I was just wondering if there could be another lower-case
> > > > letter flag
> > > > option we could use other than capital Q. ??Just looking at the
> > > > example
> > > > above, it looks a tad out-of-place.
> > > 
> > > -q would be nice. For that'd we need to rename the hostnqn one,
> > > but as
> > > stated before I think -q is really misnamed for that anyway..
> > 
> > -h for hostnqn?
> 
> Oops... -h is 'help' :)

Yep, all the good single letter flags are being taken ;-P.

-i seems fine to me. ?I kind of like -q for hostnqn since hostnqn does
have a 'q' in it so there is somewhat of a mind-remembrance game there
:-).

> 
> 
> 

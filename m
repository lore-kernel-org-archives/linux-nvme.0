From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Sun, 28 Aug 2016 21:11:42 -0700
Subject: [PATCH] nvme-cli/fabrics: Add nr_io_queues parameter to connect
 command
In-Reply-To: <20160826160112.495DFE08C5@smtp.ogc.us>
References: <20160826160112.495DFE08C5@smtp.ogc.us>
Message-ID: <1472443902.2832.8.camel@linux.intel.com>

On Fri, 2016-08-26@08:56 -0700, Steve Wise wrote:
> Added 'nr_io_queues' to 'connect' command so users can specify the
> number
> of io queues to allocate.
> 
> usage example:
> 
> nvme connect -t rdma -Q 8 -s 4420 -a 10.0.1.14 -n test-nvme

I was just wondering if there could be another lower-case letter flag
option we could use other than capital Q. ?Just looking at the example
above, it looks a tad out-of-place.

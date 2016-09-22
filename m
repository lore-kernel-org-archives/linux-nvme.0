From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Sep 2016 12:46:20 -0400
Subject: [PATCH 1/2] nvme-cli/fabrics: Add keep-alive-tmo param to
 connect cmd
In-Reply-To: <1474408553.8869.23.camel@linux.intel.com>
References: <20160920150437.CA26EE0BC1@smtp.ogc.us>
 <1474408553.8869.23.camel@linux.intel.com>
Message-ID: <20160922164620.GB14301@keith>

On Tue, Sep 20, 2016@02:55:53PM -0700, J Freyensee wrote:
> On Tue, 2016-09-20@08:01 -0700, Steve Wise wrote:
> > Added 'keep-alive-tmo' to 'connect' command so users can specify the
> > keep alive timeout period.
> > 
> > usage examples:
> > 
> > nvme connect --keep-alive-tmo=30 --transport=rdma --traddr=10.0.1.14
> > --nqn=test-nvme
> > nvme connect -k 30 -t rdma -a 10.0.1.14 -n test-nvme
> > 
> > Signed-off-by: Steve Wise <swise at opengridcomputing.com>
> >?
> 
> Looks good to me,
> Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>

Thanks, I've applied both patches in this series. I had to slightly
modify the patches to apply on the master branch due to some code
formatting changes.

Now that I look at it, I actually think the code format was nicer before
the cleanups, but that's okay. :)

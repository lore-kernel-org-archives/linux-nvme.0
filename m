From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 20 Sep 2016 14:55:53 -0700
Subject: [PATCH 1/2] nvme-cli/fabrics: Add keep-alive-tmo param to
 connect cmd
In-Reply-To: <20160920150437.CA26EE0BC1@smtp.ogc.us>
References: <20160920150437.CA26EE0BC1@smtp.ogc.us>
Message-ID: <1474408553.8869.23.camel@linux.intel.com>

On Tue, 2016-09-20@08:01 -0700, Steve Wise wrote:
> Added 'keep-alive-tmo' to 'connect' command so users can specify the
> keep alive timeout period.
> 
> usage examples:
> 
> nvme connect --keep-alive-tmo=30 --transport=rdma --traddr=10.0.1.14
> --nqn=test-nvme
> nvme connect -k 30 -t rdma -a 10.0.1.14 -n test-nvme
> 
> Signed-off-by: Steve Wise <swise at opengridcomputing.com>
>?

Looks good to me,
Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>

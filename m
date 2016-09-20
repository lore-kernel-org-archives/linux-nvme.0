From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 20 Sep 2016 14:57:32 -0700
Subject: [PATCH 2/2] nvme-cli/fabrics: Add reconnect-delay param to
 connect cmd
In-Reply-To: <20160920150439.D8168E0BC1@smtp.ogc.us>
References: <20160920150439.D8168E0BC1@smtp.ogc.us>
Message-ID: <1474408652.8869.25.camel@linux.intel.com>

On Tue, 2016-09-20@08:02 -0700, Steve Wise wrote:
> Added 'reconnect-delay' to 'connect' command so users can specify the
> delay time, in seconds, before reconnecting due to a keep alive
> timeout.
> 
> usage examples:
> 
> nvme connect --reconnect-delay=30 --transport=rdma --traddr=10.0.1.14 
> --nqn=test-nvme
> nvme connect -r 30 -t rdma -a 10.0.1.14 -n test-nvme
> 
> 
> Signed-off-by: Steve Wise <swise at opengridcomputing.com>

Also looks good,

Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>

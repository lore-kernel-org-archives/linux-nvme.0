From: ming.lei@redhat.com (Ming Lei)
Date: Fri, 24 May 2019 16:23:38 +0800
Subject: [PATCH 5.0 66/95] nvme: cancel request synchronously
In-Reply-To: <09c806a8-7be8-3552-265b-d651aaf848e8@grimberg.me>
References: <20190509181309.180685671@linuxfoundation.org>
 <20190509181314.082604502@linuxfoundation.org>
 <d0cd612d-1bce-50ca-1186-de67054b33c1@mellanox.com>
 <20190521094535.GA28632@ming.t460p>
 <7a4863ba-ece9-e3fa-8396-21736d54e1fe@mellanox.com>
 <20190521104121.GA31530@ming.t460p>
 <23729cbc-3a3f-fe16-be14-71053253c53b@mellanox.com>
 <20190521124908.GA655@ming.t460p>
 <09c806a8-7be8-3552-265b-d651aaf848e8@grimberg.me>
Message-ID: <20190524082336.GA1058@ming.t460p>

On Fri, May 24, 2019@01:15:42AM -0700, Sagi Grimberg wrote:
> 
> > > is there an API in the block layer to guaranty that ?
> > 
> > So far there isn't yet.
> > 
> > And it can be built easily against blk_mq_tagset_busy_iter(), then called
> > in delay-spin style for checking if there is any request marked as
> > MQ_RQ_COMPLETE.
> 
> This will probably make blk_mq_complete_request_sync() redundant
> wouldn't it?

Suppose there is new API to drain completed request: blk_mq_wait_completing_rq(),
which has to be called before canceling request.

And it can be used to wait the canceled request too, or keep 
blk_mq_complete_request_sync() for avoiding the wait.

Either way should be fine, IMO.

Thanks,
Ming

From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 24 Jul 2019 09:43:11 +0800
Subject: [PATCH 4/5] nvme: wait until all completed request's complete fn
 is called
In-Reply-To: <95f000ba-d3c8-f215-5e32-4b6e44954fb1@grimberg.me>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-5-ming.lei@redhat.com>
 <95f000ba-d3c8-f215-5e32-4b6e44954fb1@grimberg.me>
Message-ID: <20190724014310.GC22421@ming.t460p>

On Tue, Jul 23, 2019@01:29:54PM -0700, Sagi Grimberg wrote:
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> 
> What about fc? I know that they are not canceling a request, but
> they still complete it, shouldn't it also wait before removing?

fc doesn't use blk-mq request abort mechanism, so its own approach
may sync with abort well.

However, for normal completion, I think the wait is still needed,
will do it in V2.

Thanks,
Ming

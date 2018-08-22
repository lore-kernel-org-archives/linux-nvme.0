From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 22 Aug 2018 06:00:57 -0700
Subject: [PATCH] Remove extra goto label from nvmet_ns_enable
In-Reply-To: <20180809133344.GA11707@machine1>
References: <20180809133344.GA11707@machine1>
Message-ID: <20180822130057.GA508@infradead.org>

On Thu, Aug 09, 2018@07:03:44PM +0530, Milan P. Gandhi wrote:
> Currently nvmet_ns_enable has two labels viz. out_unlock and
> out_dev_put, and the reverse call from out_dev_put to out_unlock
> is little bit confusing. We could simplify it by calling
> nvmet_ns_dev_disable before. This would eliminate need for
> 2nd label out_dev_put.
> 
> Also, this function already initializes ret variable to 0,
> so there is no need to initialize it to 0 before out_unlock,
> so removing it.
> 
> Signed-off-by: Milan P. Gandhi <mgandhi at redhat.com>

The code before this patch actually is simpler and cleaner..

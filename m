From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 22 Aug 2018 06:01:12 -0700
Subject: [PATCH] Simplify nvmet_init to remove extra out label
In-Reply-To: <20180809133606.GA11730@machine1>
References: <20180809133606.GA11730@machine1>
Message-ID: <20180822130112.GB508@infradead.org>

On Thu, Aug 09, 2018@07:06:06PM +0530, Milan P. Gandhi wrote:
> The 2nd out label at end could easily be removed by returning
> an error upon receiving a non-zero error return code from
> nvmet_init_discovery. This would avoid need for 2nd out
> label.
> 
> Signed-off-by: Milan P. Gandhi <mgandhi at redhat.com>

And what does this buy us?

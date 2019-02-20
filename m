From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 20 Feb 2019 11:13:18 +0800
Subject: Regression: NVMe: kernel BUG at lib/sg_pool.c:103!
In-Reply-To: <20190220031122.GA17298@ming.t460p>
References: <20190220031122.GA17298@ming.t460p>
Message-ID: <20190220031317.GB17298@ming.t460p>

On Wed, Feb 20, 2019@11:11:22AM +0800, Ming Lei wrote:
> Hi,
> 
> The kernel oops[1] is observed when the following commit is applied.
> And the panic disappears after it is reverted.

Forget to mention, it is triggered by running 'nvmeof-mp/002' of blktests.

Thanks,
Ming

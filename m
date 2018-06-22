From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 21 Jun 2018 23:03:01 -0700
Subject: [PATCH] nvmet: use shared workqueue for file-ns
In-Reply-To: <20180621214736.6238-1-chaitanya.kulkarni@wdc.com>
References: <20180621214736.6238-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180622060301.GA24685@infradead.org>

On Thu, Jun 21, 2018@05:47:36PM -0400, Chaitanya Kulkarni wrote:
> This patch removes the per-ns workqueue and adds per-subsys workqueue
> which is shared by all the namespaces belongs to the same subsystem to
> offload the I/O submission for buffered I/Os for the file-backed namespace.

I think we can just have an entirely global workqueue instead of the
per-subsystem one.  We can then also use it directly instead of needing
the pointer in struct nvmet_ns.

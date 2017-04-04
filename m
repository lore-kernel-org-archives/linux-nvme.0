From: hch@lst.de (Christoph Hellwig)
Date: Tue, 4 Apr 2017 08:34:44 +0200
Subject: [PATCH rfc 6/6] nvme-rdma: use intelligent affinity based
 queue mappings
In-Reply-To: <1491140492-25703-7-git-send-email-sagi@grimberg.me>
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
 <1491140492-25703-7-git-send-email-sagi@grimberg.me>
Message-ID: <20170404063444.GF8978@lst.de>

On Sun, Apr 02, 2017@04:41:32PM +0300, Sagi Grimberg wrote:
> Use the geneic block layer affinity mapping helper. Also,

          generic

>  	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
> +	nr_io_queues = min_t(unsigned int, nr_io_queues,
> +				ibdev->num_comp_vectors);
> +

Add a comment here?

Otherwise looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>

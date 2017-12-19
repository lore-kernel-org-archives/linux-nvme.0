From: keith.busch@intel.com (Keith Busch)
Date: Tue, 19 Dec 2017 13:45:30 -0700
Subject: [PATCH] nvme-pci: move use_sgl initialization to nvme_init_iod()
In-Reply-To: <1513525642-23481-1-git-send-email-minwoo.im.dev@gmail.com>
References: <1513525642-23481-1-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <20171219204530.GB23384@localhost.localdomain>

On Mon, Dec 18, 2017@12:47:22AM +0900, Minwoo Im wrote:
> A flag "use_sgl" of "struct nvme_iod" has been used in nvme_init_iod()
> without being set to any value. It seems like "use_sgl" has been set
> in either nvme_pci_setup_prps() or nvme_pci_setup_sgls() which occur
> later than nvme_init_iod().
> 
> Make "iod->use_sgl" being set in a proper place, nvme_init_iod().
> Also move nvme_pci_use_sgls() up above nvme_init_iod() to make it
> possible to be called by nvme_init_iod().
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>

Nice catch. We're potentially corrupting memory without this fix since
the allocation size depends on whether or not SGLs are used, so we may
be under allocating what's actually used today!

> @@ -455,14 +472,17 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
>  	unsigned int size = blk_rq_payload_bytes(rq);
>  
>  	if (nseg > NVME_INT_PAGES || size > NVME_INT_BYTES(dev)) {
> +		bool use_sgl = nvme_pci_use_sgls(dev, rq);

No need for the temporary vairable here, just set iod->use_sgl directly.

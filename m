From: hch@lst.de (Christoph Hellwig)
Date: Tue, 27 Mar 2018 16:20:01 +0200
Subject: [PATCH 3/3] nvme-pci: Separate IO and admin queue IRQ vectors
In-Reply-To: <20180323221923.24545-3-keith.busch@intel.com>
References: <20180323221923.24545-1-keith.busch@intel.com>
 <20180323221923.24545-3-keith.busch@intel.com>
Message-ID: <20180327142001.GC4724@lst.de>

> +static inline unsigned int nvme_ioq_vector(struct nvme_dev *dev,
> +		unsigned int qid)

No need for the inline here I think.

> +{
> +	/*
> +	 * A queue's vector matches the queue identifier unless the controller
> +	 * has only one vector available.
> +	 */
> +	return (dev->num_vecs == 1) ? 0 : qid;

and no need for the braces here.

> +	struct irq_affinity affd = {.pre_vectors = 1};

	struct irq_affinity affd = {
		.pre_vectors	= 1
	};

to make it a little more readable.

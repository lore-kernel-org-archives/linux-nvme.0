From: hch@lst.de (Christoph Hellwig)
Date: Wed, 17 Oct 2018 09:09:26 +0200
Subject: [PATCH 2/2] nvme-fabrics: move controller options matching to
 fabrics
In-Reply-To: <20181004174358.15267-2-sagi@grimberg.me>
References: <20181004174358.15267-1-sagi@grimberg.me>
 <20181004174358.15267-2-sagi@grimberg.me>
Message-ID: <20181017070926.GB23187@lst.de>

> +bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
> +	struct nvmf_ctrl_options *opts)

This needs a two-tab indent.

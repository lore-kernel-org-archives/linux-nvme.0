From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 May 2018 09:25:44 +0200
Subject: [PATCH 10/17] nvme: export nvme_ns_has_pi function
In-Reply-To: <1527436222-15494-11-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
 <1527436222-15494-11-git-send-email-maxg@mellanox.com>
Message-ID: <20180528072544.GI5618@lst.de>

> -static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
> +bool nvme_ns_has_pi(struct nvme_ns *ns)
>  {
>  	return ns->pi_type && ns->ms == sizeof(struct t10_pi_tuple);
>  }
> +EXPORT_SYMBOL_GPL(nvme_ns_has_pi);

Just make this an inline in nvme.h

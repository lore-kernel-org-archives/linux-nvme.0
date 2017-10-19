From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 19 Oct 2017 14:06:07 +0300
Subject: [PATCH 15/17] nvme: track shared namespaces
In-Reply-To: <20171018165258.23212-16-hch@lst.de>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-16-hch@lst.de>
Message-ID: <3c68d0c8-a063-44f9-a76b-0970c9e4ad5d@grimberg.me>

Christoph,

>   static void nvme_free_ns(struct kref *kref)
>   {
>   	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
>   
> +	if (ns->head)
> +		nvme_put_ns_head(ns->head);
> +

When can we not have a ns-head set?

AFAICT, if nvme_alloc_ns succeeded, we have it set don't we?

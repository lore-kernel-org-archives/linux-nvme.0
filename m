From: hch@lst.de (Christoph Hellwig)
Date: Tue, 19 Jun 2018 07:39:02 +0200
Subject: [PATH V3] nvmet: allow file backed ns to use cache
In-Reply-To: <20180614005424.5023-1-chaitanya.kulkarni@wdc.com>
References: <20180614005424.5023-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180619053902.GA23184@lst.de>

> +static inline struct file *nvmet_file_get_handle(struct nvmet_req *req)
> +{
> +	if (atomic_read(&req->ns->buffered_io) == 1)
> +		return req->ns->file_cache;
> +
> +	return req->ns->file;

I much prefer your previous variant that disabled and re-enabled
the namespace on a switch.

In fact I don't even think we need to allow a runtime switch, I'd
be perfectly fine with switching betwen buffered and direct mode
on a manually disabled namespace only.

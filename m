From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 Oct 2017 02:01:22 -0700
Subject: [PATCH v2] nvme/target: Change max_nsid in subsystem due to
 ns_disable if needed
In-Reply-To: <1508323567-8536-1-git-send-email-sagi@grimberg.me>
References: <1508323567-8536-1-git-send-email-sagi@grimberg.me>
Message-ID: <20171019090122.GB4974@infradead.org>

> +	if (list_empty(&subsys->namespaces)) {
> +		subsys->max_nsid = 0;
> +	} else {
> +		struct nvmet_ns *ns =
> +			list_last_entry(&subsys->namespaces, struct nvmet_ns, dev_link);
> +
> +		subsys->max_nsid = ns->nsid;
> +	}

The line is still too long, but I'll fix it up.

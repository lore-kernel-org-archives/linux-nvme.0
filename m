From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 28 Jun 2016 01:32:12 -0700
Subject: [PATCH 2/3] nvme: Kill detached namespaces prior to removal
In-Reply-To: <1466702946-13065-3-git-send-email-keith.busch@intel.com>
References: <1466702946-13065-1-git-send-email-keith.busch@intel.com>
 <1466702946-13065-3-git-send-email-keith.busch@intel.com>
Message-ID: <20160628083212.GB32618@infradead.org>

> +static void nvme_remove_dead_ns(struct nvme_ns *ns)
> +{
> +	nvme_ns_kill(ns);
> +	nvme_ns_remove(ns);
> +}

I would prefer not to add this helper, it just makes the code harder
to read.

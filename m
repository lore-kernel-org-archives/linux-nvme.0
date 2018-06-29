From: hch@lst.de (Christoph Hellwig)
Date: Fri, 29 Jun 2018 10:00:08 +0200
Subject: [PATCHv2 4/4] nvme: add disk name to tracepoints
In-Reply-To: <20180628214956.13877-5-keith.busch@intel.com>
References: <20180628214956.13877-1-keith.busch@intel.com>
 <20180628214956.13877-5-keith.busch@intel.com>
Message-ID: <20180629080008.GB13413@lst.de>

> +const char *nvme_trace_disk_name(struct trace_seq *p, char *name)
> +{
> +	const char *ret = trace_seq_buffer_ptr(p);
> +
> +	if (name[0] != 0)
> +		trace_seq_printf(p, "disk=%-.*s, ", DISK_NAME_LEN, name);

	if (*name)
		trace_seq_printf(p, "disk=%-.*s, ", DISK_NAME_LEN, name);

?

> +		    req->rq_disk ?
> +			memcpy(__entry->disk, req->rq_disk->disk_name, DISK_NAME_LEN) :
> +			memset(__entry->disk, 0, DISK_NAME_LEN);

Make this a helper please.

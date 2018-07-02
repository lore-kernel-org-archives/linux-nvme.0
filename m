From: hch@lst.de (Christoph Hellwig)
Date: Mon, 2 Jul 2018 15:12:05 +0200
Subject: [PATCHv4 4/4] nvme: add disk name to trace events
In-Reply-To: <20180629225003.16567-5-keith.busch@intel.com>
References: <20180629225003.16567-1-keith.busch@intel.com>
 <20180629225003.16567-5-keith.busch@intel.com>
Message-ID: <20180702131205.GC4624@lst.de>

> +#define __assign_disk_name(name, disk)					\
> +	do {								\
> +		if (disk)						\
> +			memcpy(name, disk->disk_name, DISK_NAME_LEN);	\
> +		else							\
> +			memset(name, 0, DISK_NAME_LEN);			\
> +	} while (0)

This one at least doesn't rely on assigning to arguments, but an
inline function would still be much nicer.

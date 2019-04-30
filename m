From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 30 Apr 2019 08:33:49 -0700
Subject: [PATCH V2 3/3] nvme-multipath: improve logging
In-Reply-To: <20190429032442.5923-4-chaitanya.kulkarni@wdc.com>
References: <20190429032442.5923-1-chaitanya.kulkarni@wdc.com>
 <20190429032442.5923-4-chaitanya.kulkarni@wdc.com>
Message-ID: <20190430153349.GC26879@infradead.org>

> +		dev_info(ns->ctrl->device,
> +				"nvme-mp: status 0x%04x, resetting controller\n",
> +				status);

This message still looks a little gibberish to me.

Why not:

	"resetting path due to unhandled error (0x%04x")"

> -	dev_info(ctrl->device, "ANA group %d: %s.\n",
> +	dev_dbg(ctrl->device, "ANA group %d: %s.\n",
>  			le32_to_cpu(desc->grpid),
>  			nvme_ana_state_names[desc->state]);

I've applied this hunk to nvme-5.2, thanks.

From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Jun 2019 08:51:53 +0200
Subject: [RFC PATCH V6 3/3] nvmet: introduce target-side trace
In-Reply-To: <20190606063229.17258-4-minwoo.im.dev@gmail.com>
References: <20190606063229.17258-1-minwoo.im.dev@gmail.com>
 <20190606063229.17258-4-minwoo.im.dev@gmail.com>
Message-ID: <20190606065153.GH27033@lst.de>

> +#define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
> +#define show_admin_opcode_name(val)					\

All these bits can probably just move to nvme.h, next to the actual
definitions.

> +		__assign_disk_name(__entry->disk, req->ns ?
> +					req->ns->bdev->bd_disk : NULL);

Tis looks it will crash badly when using the file backend.  I think we
need to put a neutral identifier in, e.g. the uuid or something.

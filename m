From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 6 Jun 2019 17:45:40 +0900
Subject: [RFC PATCH V6 3/3] nvmet: introduce target-side trace
In-Reply-To: <20190606065153.GH27033@lst.de>
References: <20190606063229.17258-1-minwoo.im.dev@gmail.com>
 <20190606063229.17258-4-minwoo.im.dev@gmail.com>
 <20190606065153.GH27033@lst.de>
Message-ID: <20190606084540.GB18020@minwooim-desktop>

On 19-06-06 08:51:53, Christoph Hellwig wrote:
> > +#define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
> > +#define show_admin_opcode_name(val)					\
> 
> All these bits can probably just move to nvme.h, next to the actual
> definitions.

If it's located in <linux/nvme.h> that would be great for the host-side
trace code.

> > +		__assign_disk_name(__entry->disk, req->ns ?
> > +					req->ns->bdev->bd_disk : NULL);
> 
> Tis looks it will crash badly when using the file backend.  I think we
> need to put a neutral identifier in, e.g. the uuid or something.

Sorry I didn't think about the file-backed request at all.  Thanks for
pointing it out.

Will also prepare V7 series with this updates.

Thanks,

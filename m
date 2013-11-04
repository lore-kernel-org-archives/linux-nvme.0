From: David.Darrington@hgst.com (David.Darrington@hgst.com)
Date: Mon, 4 Nov 2013 13:55:08 -0600
Subject: [PATCH] NVMe: Add a buffer length parameter to struct
 nvme_user_io. Check
 buffer length in nvme_submit_io to avoid buffer overflow.
In-Reply-To: <20131104182618.GD6900@linux.intel.com>
Message-ID: <OF4B121443.E4A9D612-ON88257C19.00699378-86257C19.006D6B40@hgst.com>

So we have these choices:

1. leave the code as is, with a known buffer overflow problem.
2. create a _V2 version of the ioctl (in which case the v1 version still 
has the issue)
3. Fix the problem in some other way.

Perhaps 1) is not as bad as it sounds. Even if we fix the problem, a pgm 
could pass in the wrong length and get the same result. 

The SG_IO ioctl does include a length, so at least the fix is consistent.




Matthew Wilcox <willy at linux.intel.com> 
Sent by: "Linux-nvme" <linux-nvme-bounces at lists.infradead.org>
11/04/2013 12:26 PM

To
David Darrington <david.darrington at hgst.com>
cc
linux-nvme at lists.infradead.org
Subject
Re: [PATCH] NVMe: Add a buffer length parameter to struct nvme_user_io. 
Check buffer length in nvme_submit_io to avoid buffer overflow.






On Mon, Nov 04, 2013@11:02:36AM -0600, David Darrington wrote:
> @@ -441,7 +441,9 @@ struct nvme_user_io {
>                __u16           nblocks;
>                __u16           rsvd;
>                __u64           metadata;
> -              __u64           addr;
> +              __u32           rsvd1;
> +              __u32           dxfer_len;              /* length of data 
xfer buffer */
> +              __u64           dxferp; /* pointer to data xfer buffer */
>                __u64           slba;
>                __u32           dsmgmt;
>                __u32           reftag;

You can't just change the size of nvme_user_io; that breaks the ABI.
We'd need a _V2 version of the ioctl or something if we actually need
to change it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://merlin.infradead.org/mailman/listinfo/linux-nvme

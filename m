From: keith.busch@intel.com (Keith Busch)
Date: Mon, 2 Apr 2018 07:47:40 -0600
Subject: [PATCH] nvmet: fix nvmet_execute_write_zeroes function
In-Reply-To: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>
References: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>
Message-ID: <20180402134740.GB28945@localhost.localdomain>

On Fri, Mar 30, 2018@06:18:50PM -0300, Rodrigo R. Galvao wrote:
>  	sector = le64_to_cpu(write_zeroes->slba) <<
>  		(req->ns->blksize_shift - 9);
>  	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length)) <<
> -		(req->ns->blksize_shift - 9)) + 1;
> +		(req->ns->blksize_shift - 9));

I see what's wrong here. The +1 needs to be on the native format prior
to converting to 512b, so the fix needs to be:

---
 	sector = le64_to_cpu(write_zeroes->slba) <<
 		(req->ns->blksize_shift - 9);
-	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length)) <<
-		(req->ns->blksize_shift - 9)) + 1;
+	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length + 1)) <<
+		(req->ns->blksize_shift - 9));
 
 	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
 				GFP_KERNEL, &bio, 0))
--

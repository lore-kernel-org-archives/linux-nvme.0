From: keith.busch@intel.com (Busch, Keith)
Date: Fri, 16 Oct 2015 20:04:19 +0000
Subject: [PATCH 12/18] nvme: use the block layer for userspace
 passthrough metadata
In-Reply-To: <1444975128-8768-13-git-send-email-hch@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-13-git-send-email-hch@lst.de>
Message-ID: <20151016200418.GA27553@localhost.localdomain>

On Fri, Oct 16, 2015@07:58:42AM +0200, Christoph Hellwig wrote:
> Use the integrity API to pass through metadata from userspace.  For PI
> enabled devices this means that we now validate the reftag, which seems
> like an unintentional ommission in the old code.

More trouble. The below works for IO but not admin. There is no
"namespace" associated with the queue's queuedata, so there's no way to
send passthrough commands to the admin queue with metadata. I don't think
anyone cares as there is no admin command that carries such a payload.

Since the admin queuedata is NULL, we can just check for NULL before
proceeding with metadata setup, but need to be aware of this if the
admin queue ever does define queuedata.

My fault for not regression testing before posting the previous fix. The
diff to correct this new issue is at the end of this email.

> @@ -101,19 +105,77 @@ int nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
>  		if (ret)
>  			goto out;
>  		bio = req->bio;
> +		bio->bi_bdev = bdget_disk(ns->disk, 0);
> +		if (!bio->bi_bdev) {
> +			ret = -ENODEV;
> +			goto out_unmap;
> +		}
> +
> +		if (meta_buffer) {
> +			struct bio_integrity_payload *bip;
> +
> +			meta = kmalloc(meta_len, GFP_KERNEL);
> +			if (!meta) {
> +				ret = -ENOMEM;
> +				goto out_unmap;
> +			}
> +
> +			if (write) {
> +				if (copy_from_user(meta, meta_buffer,
> +						meta_len)) {
> +					ret = -EFAULT;
> +					goto out_free_meta;
> +				}
> +			}
> +
> +			bip = bio_integrity_alloc(bio, GFP_KERNEL, 1);
> +			if (!bip) {
> +				ret = -ENOMEM;
> +				goto out_free_meta;
> +			}
> +
> +			bip->bip_iter.bi_size = meta_len;
> +			bip->bip_iter.bi_sector = meta_seed;
> +
> +			ret = bio_integrity_add_page(bio, virt_to_page(meta),
> +					meta_len, offset_in_page(meta));
> +			if (ret != meta_len) {
> +				ret = -ENOMEM;
> +				goto out_free_meta;
> +			}
> +		}
>  	}
>  
> -	blk_execute_rq(req->q, NULL, req, 0);
> -	if (bio)
> -		blk_rq_unmap_user(bio);
> +	blk_execute_rq(req->q, ns->disk, req, 0);
> +	ret = req->errors;
>  	if (result)
>  		*result = (u32)(uintptr_t)req->special;
> -	ret = req->errors;
> +	if (meta && !ret && !write) {
> +		if (copy_to_user(meta_buffer, meta, meta_len))
> +			ret = -EFAULT;
> +	}
> +
> + out_free_meta:
> +	kfree(meta);
> + out_unmap:
> +	if (bio) {
> +		if (bio->bi_bdev)
> +			bdput(bio->bi_bdev);
> +		blk_rq_unmap_user(bio);
> +	}
>   out:
>  	blk_mq_free_request(req);
>  	return ret;
>  }

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b8c72d2..c8f9a71 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -156,6 +156,10 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 		if (ret)
 			goto out;
 		bio = req->bio;
+
+		if (!ns)
+			goto submit;
+
 		bio->bi_bdev = bdget_disk(ns->disk, 0);
 		if (!bio->bi_bdev) {
 			ret = -ENODEV;
@@ -196,8 +200,8 @@ int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 			}
 		}
 	}
-
-	blk_execute_rq(req->q, ns->disk, req, 0);
+ submit:
+	blk_execute_rq(req->q, ns ? ns->disk : NULL, req, 0);
 	ret = req->errors;
 	if (result)
 		*result = (u32)(uintptr_t)req->special;
--

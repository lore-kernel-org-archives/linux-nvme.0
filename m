From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 2 Apr 2013 10:41:45 -0400
Subject: [kbuild] [nvme:master 5/5] drivers/block/nvme-scsi.c:387:51:
 sparse: typename in expression
In-Reply-To: <20130331011908.GB9311@localhost>
References: <5156e534.3x/Y2ALpR1rSweS7%fengguang.wu@intel.com>
 <20130331011908.GB9311@localhost>
Message-ID: <20130402144145.GL4671@linux.intel.com>

On Sun, Mar 31, 2013@09:19:08AM +0800, Fengguang Wu wrote:
> 
> Hi Vishal,
> 
> FYI, there are new sparse warnings show up in
> 
> tree:   git://git.infradead.org/users/willy/linux-nvme master
> head:   5d0f6131a79adfa1fb51309c5f81a2a4ef879dd4
> commit: 5d0f6131a79adfa1fb51309c5f81a2a4ef879dd4 [5/5] NVMe: Add nvme-scsi.c

Thanks, Fengguang!  Vishal, looks like this patch should fix the warnings.
Any comments before I commit it?

---

diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
index 483af35..7065c25 100644
--- a/drivers/block/nvme-scsi.c
+++ b/drivers/block/nvme-scsi.c
@@ -380,11 +380,11 @@ static int nvme_trans_copy_to_user(struct sg_io_hdr *hdr, void *from,
 	size_t xfer_len;
 
 	if (hdr->iovec_count > 0) {
-		struct sg_iovec *sgl = hdr->dxferp;
+		struct sg_iovec __user *sgl = hdr->dxferp;
 
 		for (i = 0; i < hdr->iovec_count; i++) {
 			xfer_len = min(remaining, sgl[i].iov_len);
-			not_copied = copy_to_user(__user sgl[i].iov_base, index,
+			not_copied = copy_to_user(sgl[i].iov_base, index,
 								xfer_len);
 			if (not_copied) {
 				res = -EFAULT;
@@ -397,7 +397,7 @@ static int nvme_trans_copy_to_user(struct sg_io_hdr *hdr, void *from,
 		}
 		return res;
 	}
-	not_copied = copy_to_user(__user hdr->dxferp, from, n);
+	not_copied = copy_to_user(hdr->dxferp, from, n);
 	if (not_copied)
 		res = -EFAULT;
 	return res;
@@ -416,12 +416,12 @@ static int nvme_trans_copy_from_user(struct sg_io_hdr *hdr, void *to,
 	size_t xfer_len;
 
 	if (hdr->iovec_count > 0) {
-		struct sg_iovec *sgl = hdr->dxferp;
+		struct sg_iovec __user *sgl = hdr->dxferp;
 
 		for (i = 0; i < hdr->iovec_count; i++) {
 			xfer_len = min(remaining, sgl[i].iov_len);
-			not_copied = copy_from_user(index,
-					__user sgl[i].iov_base, xfer_len);
+			not_copied = copy_from_user(index, sgl[i].iov_base,
+								xfer_len);
 			if (not_copied) {
 				res = -EFAULT;
 				break;
@@ -434,7 +434,7 @@ static int nvme_trans_copy_from_user(struct sg_io_hdr *hdr, void *to,
 		return res;
 	}
 
-	not_copied = copy_from_user(to, __user hdr->dxferp, n);
+	not_copied = copy_from_user(to, hdr->dxferp, n);
 	if (not_copied)
 		res = -EFAULT;
 	return res;
@@ -469,7 +469,7 @@ static int nvme_trans_completion(struct sg_io_hdr *hdr, u8 status, u8 sense_key,
 
 		xfer_len = min_t(u8, hdr->mx_sb_len, DESC_FMT_SENSE_DATA_SIZE);
 		hdr->sb_len_wr = xfer_len;
-		if (copy_to_user(__user hdr->sbp, resp, xfer_len) > 0)
+		if (copy_to_user(hdr->sbp, resp, xfer_len) > 0)
 			res = -EFAULT;
 	}
 
@@ -2929,7 +2929,7 @@ int nvme_sg_io(struct nvme_ns *ns, struct sg_io_hdr __user *u_hdr)
 		return retcode;
 	if (retcode > 0)
 		retcode = SNTI_TRANSLATION_SUCCESS;
-	if (copy_to_user(__user u_hdr, &hdr, sizeof(sg_io_hdr_t)) > 0)
+	if (copy_to_user(u_hdr, &hdr, sizeof(sg_io_hdr_t)) > 0)
 		return -EFAULT;
 
 	return retcode;

---

> >> drivers/block/nvme-scsi.c:387:51: sparse: typename in expression
>    drivers/block/nvme-scsi.c:387:58: sparse: Expected ) in function call
>    drivers/block/nvme-scsi.c:387:58: sparse: got sgl
> >> drivers/block/nvme-scsi.c:400:35: sparse: typename in expression
>    drivers/block/nvme-scsi.c:400:42: sparse: Expected ) in function call
>    drivers/block/nvme-scsi.c:400:42: sparse: got hdr
> >> drivers/block/nvme-scsi.c:424:41: sparse: typename in expression
>    drivers/block/nvme-scsi.c:424:48: sparse: Expected ) in function call
>    drivers/block/nvme-scsi.c:424:48: sparse: got sgl
> >> drivers/block/nvme-scsi.c:437:41: sparse: typename in expression
>    drivers/block/nvme-scsi.c:437:48: sparse: Expected ) in function call
>    drivers/block/nvme-scsi.c:437:48: sparse: got hdr
> >> drivers/block/nvme-scsi.c:472:34: sparse: typename in expression
>    drivers/block/nvme-scsi.c:472:41: sparse: Expected ) in function call
>    drivers/block/nvme-scsi.c:472:41: sparse: got hdr
> >> drivers/block/nvme-scsi.c:2932:26: sparse: typename in expression
>    drivers/block/nvme-scsi.c:2932:33: sparse: Expected ) in function call
>    drivers/block/nvme-scsi.c:2932:33: sparse: got u_hdr
>    drivers/block/nvme-scsi.c:387:51: sparse: undefined identifier '__attribute__'
>    drivers/block/nvme-scsi.c:400:35: sparse: undefined identifier '__attribute__'
>    drivers/block/nvme-scsi.c:424:41: sparse: undefined identifier '__attribute__'
>    drivers/block/nvme-scsi.c:437:41: sparse: undefined identifier '__attribute__'
>    drivers/block/nvme-scsi.c:472:34: sparse: undefined identifier '__attribute__'
>    include/uapi/linux/swab.h:71:16: sparse: undefined identifier '__builtin_bswap64'
>    include/uapi/linux/swab.h:60:16: sparse: undefined identifier '__builtin_bswap32'
>    include/uapi/linux/swab.h:60:33: sparse: not a function <noident>
>    include/uapi/linux/swab.h:71:33: sparse: not a function <noident>
>    include/uapi/linux/swab.h:60:33: sparse: not a function <noident>
>    include/uapi/linux/swab.h:60:33: sparse: not a function <noident>
>    include/uapi/linux/swab.h:60:33: sparse: not a function <noident>
>    include/uapi/linux/swab.h:71:33: sparse: not a function <noident>
>    include/uapi/linux/swab.h:60:33: sparse: not a function <noident>
>    include/uapi/linux/swab.h:71:33: sparse: not a function <noident>
>    include/uapi/linux/swab.h:60:33: sparse: not a function <noident>
>    drivers/block/nvme-scsi.c:2932:26: sparse: undefined identifier '__attribute__'
> 
> 
> ---
> 0-DAY kernel build testing backend              Open Source Technology Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
> _______________________________________________
> kbuild mailing list
> kbuild at lists.01.org
> https://lists.01.org/mailman/listinfo/kbuild

From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 31 Dec 2013 08:35:40 -0500
Subject: [PATCH RFC 2/5] NVMe: Basic NVMe device hotplug support
In-Reply-To: <1388399240-13828-3-git-send-email-santoshsy@gmail.com>
References: <1388399240-13828-1-git-send-email-santoshsy@gmail.com>
 <1388399240-13828-3-git-send-email-santoshsy@gmail.com>
Message-ID: <20131231133540.GL4945@linux.intel.com>

On Mon, Dec 30, 2013@03:57:17PM +0530, Santosh Y wrote:
> +		if ((status & 0xff) == NVME_SC_INVALID_NS) {
> +			bio_endio(bio, -ENODEV);
> +		} else if ((status & 0xff) == NVME_SC_NS_NOT_READY) {
> +			bio->bi_rw |= REQ_FAILFAST_DRIVER;
> +			nvme_requeue_bio(dev, bio);
> +		} else

BTW, ANDing with 0xff is wrong.  The NVME_SC_NS_NOT_READY test would also
catch NVME_SC_GUARD_CHECK (value 0x282).  We should include:

	NVME_SC_MASK			= 0xbff

as part of the enum, or perhaps have a macro:

#define nvme_status_code(status)	((status) & 0xbff)


BTW, I'm going to update the status codes with the ones found in spec 1.1a:


diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index f009c15..ca4a9fa 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -412,9 +412,15 @@ enum {
 	NVME_SC_FUSED_MISSING		= 0xa,
 	NVME_SC_INVALID_NS		= 0xb,
 	NVME_SC_CMD_SEQ_ERROR		= 0xc,
+	NVME_SC_SGL_LAST_SEG		= 0xd,
+	NVME_SC_SGL_COUNT		= 0xe,
+	NVME_SC_SGL_DATA_LEN		= 0xf,
+	NVME_SC_SGL_METADATA_LEN	= 0x10,
+	NVME_SC_SGL_TYPE		= 0x11,
 	NVME_SC_LBA_RANGE		= 0x80,
 	NVME_SC_CAP_EXCEEDED		= 0x81,
 	NVME_SC_NS_NOT_READY		= 0x82,
+	NVME_SC_RESERVATION_CONFLICT	= 0x83,
 	NVME_SC_CQ_INVALID		= 0x100,
 	NVME_SC_QID_INVALID		= 0x101,
 	NVME_SC_QUEUE_SIZE		= 0x102,
@@ -426,7 +432,15 @@ enum {
 	NVME_SC_INVALID_VECTOR		= 0x108,
 	NVME_SC_INVALID_LOG_PAGE	= 0x109,
 	NVME_SC_INVALID_FORMAT		= 0x10a,
+	NVME_SC_CONVENTIONAL_RESET	= 0x10b,
+	NVME_SC_INVALID_QUEUE		= 0x10c,
+	NVME_SC_FEAT_NOT_SAVABLE	= 0x10d,
+	NVME_SC_FEAT_NOT_CHANGABLE	= 0x10e,
+	NVME_SC_FEAT_NOT_NS		= 0x10f,
+	NVME_SC_SUBSYSTEM_RESET		= 0x110,
 	NVME_SC_BAD_ATTRIBUTES		= 0x180,
+	NVME_SC_INVALID_PI		= 0x181,
+	NVME_SC_RANGE_RO		= 0x182,
 	NVME_SC_WRITE_FAULT		= 0x280,
 	NVME_SC_READ_ERROR		= 0x281,
 	NVME_SC_GUARD_CHECK		= 0x282,

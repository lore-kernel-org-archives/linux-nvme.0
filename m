Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED9BCCA462
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2026 14:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AbBEogAxyh7+JN+OT4vw992dVZCSlpxBHlQNCIp2JxQ=; b=kcHQBNViSRJnrziF6uXGTvktV0
	Zp0ywyb2zzX5gnux2jZy+DKHbdif4Zze2lt+3Qo/xfuk+dfVSlcam7WoXJLgMT374Whx/F7XadFf7
	uEPn+i6aRD9ILS0fnJixyOevf+0/1Y8rHajbjlv++X043cjMC6N8MKB9W7SnP8SH0+IYsEe/IGFJU
	rMt6ENPNmyLTSpPyVr/t/JvR1cDrop6bAsviNoqnKMFks2VNjcX4+ryAm7xFCI+/uLI/eeDcB44ZD
	Kff6ZtG9RZNarsIgGpzJXVR7K5GLdH136nXfiBnDAmfA8tnTZBgcw0g55TaAO1QrF3YdE5UgRB9Ob
	a1n0BNdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHift-000000036e7-0L8B;
	Fri, 16 Oct 2026 14:12:45 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHifq-000000036dZ-1dZE
	for linux-nvme@lists.infradead.org;
	Fri, 16 Oct 2026 14:12:43 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-48bbb06e746so1595238f8f.3
        for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2026 07:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792159960; x=1792764760; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AbBEogAxyh7+JN+OT4vw992dVZCSlpxBHlQNCIp2JxQ=;
        b=IBtFR219W6eJMW7LSbpHr5kz+Dp9JcIzknimmYwH0JZrl8vH5csXwgP8ZBMD9aqONq
         HNBo5b46i9FDDkANxcXI6bKWgp5J8l0wVLdleeYCOJgYBO7TkTp/VSiBDrJhuvTz90Y5
         48slFSKziTgcG5KZ+xjSZCxYyxqpHPchwLJ/Fvk9QFAuzJzw5Cl3OIoXizt86qy/Gevd
         fvgIZpfGZJY85YNKs5cfbVqH0BO8Ss0uoNu73nESPA+yDySQ5zp0s2A2eunSxp78/2F+
         RqGQzOwCey/e68KQadvZksBgfMwDb2t8Z7EzlGCNZ7o99732OljcF4iWrVE/O2YayLcE
         LYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792159960; x=1792764760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AbBEogAxyh7+JN+OT4vw992dVZCSlpxBHlQNCIp2JxQ=;
        b=zw+DYuzKaz2ZVEu5Ifs4hv9DM6x/jw9ipqZl4f1qxnO8iPwt47w6YnfQ9C3qpoBCor
         hCbeUxcQ0qsvIXSyAXZOpie/1nuhK+FpEU8FbaQVYu/ymLpEcjC/mUieO9a32MNBbP2Q
         jYCQIpcdkarFCGOsHkVgSPKUhx1MFzmoaF8hM/JBZE/Sp/tf02CtF512ZK6pAld5zU/O
         A9tAfWEdcl7lwCSL/jA5rSjrwqIuTU1ZOq+Rw/F9wysY9sVJ+eg+eDMNSWlrKW0vOpPm
         5blr6N1AL7ythkxW+co/mYxCxmhAmg3MGUKfOeeO4VoDcPwZC5wicx6Cyehf2q2RbFGc
         OEZQ==
X-Gm-Message-State: AFq9FYJkZOL7Dw67oCSTeKmtmddXq/54fM1vMNiRrSd1b/zaWDNZ59E/
	XLXcbm57kiIow6+HzkD+94MCJk0CvubxcYRJA2IscHYHDXxjdVR949LLmHjDXhfpsgCZ2A==
X-Gm-Gg: AYBFou0chVkr+HWq5HG/83eELAfClew7h/B6mtNZYLu2FCXLltmFsrR5LD2ZZJzzsAe
	A6OrPTUhAR1uDPuiUiG+Ptv0eauJKzvDsLn+mPvkWec6Lm4rhSYb6hkl4RmmHd8eXVBuL0hpHL8
	SVu1G/QfyOIWgu28AhiTGmyTdO6d64PaECdE8RyPh1r8MqLu3RxOhU8422xyHUOqu5PoUoUaOyf
	g8+DbIcuHCOInlTC2f0qimxNvuiCnpSn/Se0RhhUHHATdeMpRydygJ8G9k0+8JX+qlV7LloOWIE
	i7Y7n1pEQqmTGtkOnV3b2X5h52XwcSqmP9vZVkJX8Y4FJ5DrL1434ql15yI39zkwoScY5Fmy/TX
	+n45B7mGuY4ffaBhSZbcg86nL7JQjeA7FofG1N337LABh+6jP+/lpN5f5OzGmyhdHR7LW5gWmGS
	1ETb+YpLCfBezs2NK1eb2mutG6PjRmwXSa/S2ErVIgmyiwXbIldEBdFudpb1ljTClELLoj/Nx4o
	bapW11zYuafUyDMPzbwzsUfwG+odsE0pAEwUG7rd2Vp433J9XlXj09M
X-Received: by 2002:a05:600d:82c8:b0:4a1:cedc:ab51 with SMTP id 5b1f17b1804b1-4a1cedcac09mr44301305e9.35.1792159959775;
        Fri, 16 Oct 2026 07:12:39 -0700 (PDT)
Received: from B87454BG30364.tailfa1f09.ts.net (284035233.box.freepro.com. [82.96.134.200])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48dfdeb18f8sm4771136f8f.20.2026.10.16.07.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:12:39 -0700 (PDT)
From: Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-kernel@vger.kernel.org,
	Erwan Velu <e.velu@criteo.com>
Subject: [PATCH] nvme: honor the volatile write cache enable state
Date: Fri, 16 Oct 2026 16:12:08 +0200
Message-ID: <20261016141208.2641974-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261016_071242_477536_C6CFB504 
X-CRM114-Status: GOOD (  22.62  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

A controller with a volatile write cache present (NVME_CTRL_VWC_PRESENT)
but disabled (Volatile Write Cache Enable cleared) is exposed in
write-back mode, as the driver never reads the Volatile Write Cache
feature. The block layer then issues flushes and FUA writes for
nothing, hurting performance.

On a Kioxia CD6-V (KCD6XVUL3T20, HPE firmware GPK8), compliant with
NVMe 1.4.0 and reporting VWC 0x5 with WCE cleared, 4k random writes with
an fsync after each write (fio, 30s) give, before (write back) and after
(write through) this patch:

  job                   | cache   |   IOPS | fsync avg | flushes |  gain
  ----------------------+---------+--------+-----------+---------+------
  psync buffered, QD1   | back    |   3885 |   247.6us |  116552 |
                        | through |  48325 |    15.7us |       0 | x12.4
  ----------------------+---------+--------+-----------+---------+------
  io_uring direct, QD1  | back    |   3886 |   238.2us |  116593 |
                        | through |  41924 |     5.7us |       0 | x10.8
  ----------------------+---------+--------+-----------+---------+------
  io_uring direct, QD32 | back    |   5088 |  6173.5us |  117793 |
                        | through | 140196 |   107.0us |       0 | x27.6

From NVMe 1.4c (sections 5.21.1.6 and 6.8) up to the NVMe Base
Specification 2.4 (sections 5.2.30.1.4 and 7.2), a Flush command has no
effect if the volatile write cache is not enabled. The NVMe Base
Specification 2.3 and 2.4 (sections 5.2.26.1.4 and 5.2.30.1.4) also
state that user data written to a namespace shall be persistent if the
volatile write cache is disabled.

Make the driver honor the Volatile Write Cache Enable bit:

- Read the feature in nvme_query_vwc_status() when the controller is
  identified. The cache is assumed to be enabled unless the controller
  explicitly reports it disabled, so a failure keeps the current
  behavior.

- Add the nvme_ctrl_vwc_enabled() helper so that the volatile write
  cache state is evaluated in a single place, combining both bits,
  instead of testing NVME_CTRL_VWC_PRESENT on its own as is done today.

  The chosen logic is the following:

    NVME_CTRL_VWC_PRESENT | NVME_FEAT_VWC_ENABLE | Write cache
    ----------------------+----------------------+--------------
              0           |     absent/0/1       | write-through
              1           |        absent        | write-back
              1           |          0           | write-through
              1           |          1           | write-back

  This is safe by default: a present volatile write cache is considered
  enabled, and the namespaces are exposed in write-back mode, until the
  controller reports the WCE bit cleared.

- Refresh the state and rescan the namespaces in nvme_passthru_end()
  after a successful Set Features for this feature, so that a change
  made from userspace (e.g. "nvme set-feature -f 6 --value 1 /dev/nvme0")
  is applied to the namespaces:

  - if the volatile write cache is now enabled, wait for the rescan to
    complete, so that the namespaces are back in write-back mode and
    flushes and FUA writes are issued again before the command returns;
  - if the volatile write cache is now disabled, do not wait, as
    flushes sent in the meantime have no effect.

The performance issue is not specific to the drive tested here: any
controller that reports a volatile write cache with WCE cleared is
affected, whatever its vendor or product.

Assisted-by: Claude Opus 5.5
Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/nvme/host/core.c | 41 +++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h | 10 ++++++++++
 include/linux/nvme.h     |  1 +
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 531f9bb14bab..5b03bf06b57c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1278,6 +1278,30 @@ u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_passthru_start, "NVME_TARGET_PASSTHRU");
 
+static void nvme_query_vwc_status(struct nvme_ctrl *ctrl)
+{
+	u32 result;
+	int ret;
+
+	/* Assume the volatile write cache is enabled until proven otherwise */
+	ctrl->vwc_status |= NVME_FEAT_VWC_ENABLE;
+
+	if (!(ctrl->vwc & NVME_CTRL_VWC_PRESENT))
+		return;
+
+	ret = nvme_get_features(ctrl, NVME_FEAT_VOLATILE_WC, 0, NULL, 0,
+			&result);
+	if (ret) {
+		dev_warn(ctrl->device,
+			"failed to get volatile write cache status (%d)\n",
+			ret);
+		return;
+	}
+
+	if (!(result & NVME_FEAT_VWC_ENABLE))
+		ctrl->vwc_status &= ~NVME_FEAT_VWC_ENABLE;
+}
+
 u32 nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status)
 {
@@ -1313,6 +1337,20 @@ u32 nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 			if (!status)
 				nvme_update_keep_alive(ctrl, cmd);
 			break;
+		case NVME_FEAT_VOLATILE_WC:
+			/*
+			 * Refresh the volatile write cache state and revalidate
+			 * the namespaces so that flushes and FUA writes are
+			 * issued if the cache was enabled. In that case, wait
+			 * for the revalidation to complete before returning.
+			 */
+			if (!status) {
+				nvme_query_vwc_status(ctrl);
+				nvme_queue_scan(ctrl);
+				if (nvme_ctrl_vwc_enabled(ctrl))
+					flush_work(&ctrl->scan_work);
+			}
+			break;
 		default:
 			break;
 		}
@@ -2478,7 +2516,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 				 "not enabling zoned mode");
 	}
 
-	if ((ns->ctrl->vwc & NVME_CTRL_VWC_PRESENT) && !info->no_vwc)
+	if (nvme_ctrl_vwc_enabled(ns->ctrl) && !info->no_vwc)
 		lim.features |= BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA;
 	else
 		lim.features &= ~(BLK_FEAT_WRITE_CACHE | BLK_FEAT_FUA);
@@ -3679,6 +3717,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
+	nvme_query_vwc_status(ctrl);
 	if (id->mdts)
 		max_hw_sectors = nvme_mps_to_sectors(ctrl, id->mdts);
 	else
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a8ef62b8e34b..b993ebd457c5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -399,6 +399,7 @@ struct nvme_ctrl {
 	u32 max_namespaces;
 	atomic_t abort_limit;
 	u8 vwc;
+	u32 vwc_status;
 	u32 vs;
 	u32 sgls;
 	u16 kas;
@@ -1274,6 +1275,15 @@ static inline void nvme_start_request(struct request *rq)
 	blk_mq_start_request(rq);
 }
 
+/*
+ * The volatile write cache status depends on both its presence and its state.
+ */
+static inline bool nvme_ctrl_vwc_enabled(struct nvme_ctrl *ctrl)
+{
+	return (ctrl->vwc & NVME_CTRL_VWC_PRESENT) &&
+		(ctrl->vwc_status & NVME_FEAT_VWC_ENABLE);
+}
+
 static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
 {
 	return ctrl->sgls & (NVME_CTRL_SGLS_BYTE_ALIGNED |
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 91ce434a7e8d..c7a1fd29bda7 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1402,6 +1402,7 @@ enum {
 	NVME_FEAT_WRITE_PROTECT	= 0x84,
 	NVME_FEAT_VENDOR_START	= 0xC0,
 	NVME_FEAT_VENDOR_END	= 0xFF,
+	NVME_FEAT_VWC_ENABLE	= 1 << 0,
 	NVME_LOG_SUPPORTED	= 0x00,
 	NVME_LOG_ERROR		= 0x01,
 	NVME_LOG_SMART		= 0x02,

base-commit: 2e8e30b3cf9f165e1a1d079331543cb7f2ad0e0c
-- 
2.53.0



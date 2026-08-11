Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB631C5B56A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 19:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xsGRF6OAYtOe4wGNm3PkEdXjvkEOAuUjKX79hFhAsys=; b=EKCSze32LpvVvzEaQK2IoIVr2m
	UdIbSeBxDkPrIPRDFDhLX/coI+7KsoDshMvmW97gGBmBPAxvV6vdycZGbM+y58IXwrThqnUvZmUBP
	xBZ4HHqTpetRPJ1Vgjp8Oc9p0VpALwfIump9c/tsNehgMi2OZmQhytulxWEHz8AsmjUXNnrq5JA7g
	cvs+G1EEJSkWUdQ04zCb1x/vRs2kstWc+QE0WTQsgasKQf+Vs9aZHPvEImhvZJ1QyRvSbCu9V6m1P
	726VrIHn9DM8f6orSGi05ceUOc/H302TchzXeKGIKeSSMnTbdHSixja8aOivou32aGipf2i1/a8na
	6lOaF+4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wts2G-0000000EpNP-19Mq;
	Tue, 11 Aug 2026 19:21:16 +0000
Received: from mail-yw1-x1136.google.com ([2607:f8b0:4864:20::1136])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wts2E-0000000EpMk-1rBr
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 19:21:15 +0000
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-80bb41f7f3cso1694697b3.2
        for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2026 12:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786476073; x=1787080873; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xsGRF6OAYtOe4wGNm3PkEdXjvkEOAuUjKX79hFhAsys=;
        b=PBc0RIAFBT6aTNkumh4LonxeU8Mirt4Luh7qe0YGbYhmKAuNdVIzmBCCc/pHjUCRFk
         3NBTNCTTUvn+sagaIYgw/K/SgzuwFPKLf7Ytt4wvw5MRzR6FXM3yWd4xK19/eocMaK5k
         +4gnwdOKsE7TiDIw/uPCsS78ZbKIvvS/Ng4d+meVDh7xRA+o6fO+Ux7RKm6y1ocgWCJN
         dRCPa5zsk5tTGuPG9w/QXoLRwFahKciTNbXiDDxU2Gs0mjlBqVpwbsY3z4Bx4MEc8W50
         xTBiSYMPFyBk4mSOCkUnUXKS4CmTA7Z8ah+1KpU9DpF0gluXg5xNwKyC4ePBpkaRAsS5
         GH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786476073; x=1787080873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xsGRF6OAYtOe4wGNm3PkEdXjvkEOAuUjKX79hFhAsys=;
        b=WqcjCaAUbVjruPql+gupF2drYiF7Axo2rT4UzLg271uAzeYI6+0o7wwGvb6sgVK8FI
         s1YlSJVYIIs+881O+Oi/+lF7stIJ5JgOigjc91Gqewu1HdnPNlUq/19+5xTdF3bGH9wY
         RapQWMD2Aa9Cj71zl67hXtfnLURI3okQP7j65PAonESipID35w69CTBTlCrPBap3a8Hz
         94W5CnCExaMb1HFlhuqrmfhOs4zlwvtYlvOi6Kund+E9qKRZOQQeHdhdqrYEUEpMGM47
         Q/WAZVCKY7fI8kjqRxq/9qxsscpU9S390VwoUIlCu8GxalQAG7WkPUYLKAqdwY2Jvq9r
         /+hw==
X-Forwarded-Encrypted: i=1; AHgh+RpN5fqWG5wPLy7zW7mEl7mnaAX4/FG/X7AjTf5PBuX8v62sc44t6dPhzzQreAaxM6Ez6lvcZMdBAmK0@lists.infradead.org
X-Gm-Message-State: AOJu0Yy7WNfO8Oe1qnfphd/oY5FCtmM3A+dDvm+qtjqCxEGPyMmgw9Nl
	q3LkR72k+V7BcKzYM8GVo+xmnqa0l+6Jdbu96blMOUo9ZKMmCbRrOIEVhAIRyckI
X-Gm-Gg: AR+sD12yJIkx7QECWU7sE5pO/Il+6/+4y05Fakv2merta5uGmJnxgNuk/oHsDL4r5NM
	rxusuvpYu84Wr1fs6Urv/0YcLLrG/x7Xdv7nnf7/u1PNsfI9uEAhYBtoe1O1ycUn4RUqC2tVccC
	+Hj4KFy9Q3K3/oYARxDdZebtCb58mW/igBsF1F/yb1tcD4/d6FFCpgg8PoVDzqWFkq1RKfBWQOj
	bHYGDI6oFwRFP9IfoEv0lh6SBkYOywO/5H92j82Lw8jt9seBQ/FhDUTZI5/dMy/hn9GyQIoDGJi
	0Wq79GVTPBjH4F9Mqjxogzvh+zeROenX1KZ1MMrsaQ1uGzS5xlPNwgqKTFGNOJwn8hmHl401cTE
	A6h2oAgMXD9AUmTPPAhRu8NiWN5gsfjEBcmXWisNRq39bGigAszr4kC1ncvJLJYxDyblK+tuqfM
	/rIK8411N7g26xHg83kgPAuaTUDCoLXGzWvNqnB8IudNwZEkzK1kGfuymM9h5hNXhpuCx2wbOT9
	LWlLn0=
X-Received: by 2002:a05:690c:b88:b0:826:5659:28aa with SMTP id 00721157ae682-82f2ef152e0mr41609287b3.32.1786476073030;
        Tue, 11 Aug 2026 12:21:13 -0700 (PDT)
Received: from syssplab.cs.fiu.edu (nat1.cs.fiu.edu. [131.94.134.89])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-830a41425d1sm2748287b3.11.2026.08.11.12.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 12:21:12 -0700 (PDT)
From: Chao Shi <coshi036@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Weidong Zhu <weizhu@fiu.edu>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] nvme: refuse an unsolicited format change on a namespace that is in use
Date: Tue, 11 Aug 2026 15:21:11 -0400
Message-ID: <20260811192111.2058140-1-coshi036@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_122114_499744_D6FD12AF 
X-CRM114-Status: GOOD (  26.06  )
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

A namespace can report a new LBA format or metadata size on revalidation.
The host still holds cached data, queued bios and integrity buffers built
for the old geometry.  Adopting the new one reinterprets all of it.

Freezing the queue does not help.  The request is already complete when
the integrity verify is handed to kintegrityd, so the freeze drains while
that work is still pending.  The verify then walks a buffer sized for the
old metadata_size using the new step size.  That is the reported KASAN
slab-out-of-bounds read in t10_pi_verify().

Christoph suggested failing such a revalidation rather than handling the
fallout.  Do that.  Compare the new LBA data size and metadata size
against the live ones, before the queue is frozen.  If they differ while
the disk is open, return INVALID_NS/DNR.  nvme_validate_ns() turns that
into nvme_ns_remove(), as it already does for changed identifiers.

Host-initiated format and namespace management are exempt.  They arrive
through nvme_passthru_end(), where the host asked for the change.
NVME_CTRL_SELF_RESCAN marks that window.

Link: https://lore.kernel.org/linux-block/ah03bXpgFLQjOUt8@infradead.org/
Link: https://lore.kernel.org/linux-block/20260531-blk-integrity-fix-v1-1-cc7084f42cf1@outlook.com/
Found by FuzzNvme.

Signed-off-by: Chao Shi <coshi036@gmail.com>
---
RFC: the refusal path is untested and the scoping is the part I am least
sure of.

* Build-tested only.  W=1 clean, with and without CONFIG_NVME_MULTIPATH.
  syzkaller could not extract a reproducer, so the new path has not run.

* Is the exemption right?  It keeps "nvme format" working on a namespace
  that merely has a udev probe open.  But it also lets through the one
  case where a change is expected.

* NVME_CTRL_SELF_RESCAN is best effort.  An AER-driven rescan inside the
  nvme_passthru_end() window looks solicited.

* Only lba_shift and ms are compared.  A PI type change with the same
  metadata size is not caught.

* Replaces an earlier attempt from my group that Christoph NAK'd.  We are
  dropping it rather than respinning it.

 drivers/nvme/host/core.c | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 41 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..ebac5a3d1a07 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1285,8 +1285,15 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		}
 	}
 	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
+		/*
+		 * The host asked for this change, so let the rescan adopt the
+		 * new namespace geometry even if the disk is open.  Only an
+		 * unsolicited change is refused, see nvme_update_ns_info_block().
+		 */
+		set_bit(NVME_CTRL_SELF_RESCAN, &ctrl->flags);
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
+		clear_bit(NVME_CTRL_SELF_RESCAN, &ctrl->flags);
 	}
 	if (ns)
 		return;
@@ -2384,6 +2391,17 @@ static bool nvme_invalid_lba_sz(u64 nsze, signed int shift, sector_t *capacity)
 	return check_shl_overflow(nsze, shift, capacity);
 }
 
+/*
+ * Openers of a multipath namespace go to the head disk; the per-path disk is
+ * hidden and never has any.
+ */
+static unsigned int nvme_ns_openers(struct nvme_ns *ns)
+{
+	if (nvme_ns_head_multipath(ns->head))
+		return disk_openers(ns->head->disk);
+	return disk_openers(ns->disk);
+}
+
 static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		struct nvme_ns_info *info)
 {
@@ -2436,6 +2454,28 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		goto out;
 	}
 
+	/*
+	 * Changing the LBA format or the metadata size reinterprets everything
+	 * the host has already cached, queued or handed to the integrity code
+	 * for this namespace, and freezing the queue does not cover any of it:
+	 * page cache contents, bios batched on a plug and the deferred
+	 * integrity verify work all outlive the freeze.  If such a change
+	 * arrives unsolicited while the namespace is in use, refuse it and let
+	 * the caller take the namespace offline rather than adopt a geometry
+	 * that describes something else than what the host is holding.
+	 */
+	if (nvme_ns_openers(ns) &&
+	    !test_bit(NVME_CTRL_SELF_RESCAN, &ns->ctrl->flags) &&
+	    (ns->head->lba_shift != id->lbaf[lbaf].ds ||
+	     ns->head->ms != le16_to_cpu(id->lbaf[lbaf].ms))) {
+		dev_err(ns->ctrl->device,
+			"unsolicited format change on in-use nsid %u (lba_shift %u -> %u, ms %u -> %u)\n",
+			info->nsid, ns->head->lba_shift, id->lbaf[lbaf].ds,
+			ns->head->ms, le16_to_cpu(id->lbaf[lbaf].ms));
+		ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
+		goto out;
+	}
+
 	lim = queue_limits_start_update(ns->disk->queue);
 
 	memflags = blk_mq_freeze_queue(ns->disk->queue);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 824651cc898d..93c15d5580e3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -329,6 +329,7 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_SKIP_ID_CNS_CS	= 4,
 	NVME_CTRL_DIRTY_CAPABILITY	= 5,
 	NVME_CTRL_FROZEN		= 6,
+	NVME_CTRL_SELF_RESCAN		= 7,
 };
 
 struct nvme_ctrl {

base-commit: f5bbbfec59b4e2fb7520a91de3df8a6174325d6a
-- 
2.43.0



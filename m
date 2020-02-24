Return-Path: <SRS0=1xwY=4M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEC8C38BE0
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:50:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9579D20836
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 18:50:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rAQxi6UN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYtiL4xr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9579D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=fDRPt00VAKjhSu4RD/5U0DLSgqiri9q5ZZKtbJC3Rsw=; b=rAQxi6UNLb/SnFDfUyYvCYljQf
	l+VpfGOvHifHilQvjxV9AaGIj0oDqPkoPBLIH0PlYxi0lCJr76gddT8uxzYDU0wPA1P71lSbhD+HK
	KvrxTo6emMRUdTJbycmeVzi0lZKf/TaAxUsRwkD4kSVZNnrgKh7EqPllQHdqv97ldEE2gHwcPcqMs
	SQ774V8F0VVdNRCsNOBd8Wo+XDiHDQLp9GvpgcdemaojRNIprv74Ii7ID4MfF05edt6xUX1o+WGc/
	zrCghUw8cTgHjOMx1I4jeHrWRySiERtkfBzEJXGcvZ929stPHOsf3cUh4dRPfb6hhkfHlbztHN529
	YtXZqHHw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6Inl-0007xy-W9; Mon, 24 Feb 2020 18:49:58 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6InB-0007Gi-KH
 for linux-nvme@lists.infradead.org; Mon, 24 Feb 2020 18:49:23 +0000
Received: by mail-wm1-x343.google.com with SMTP id z12so367350wmi.4
 for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2020 10:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=nvZV3LeNxekrWpaRWhJ9IY7XHJKxY4BwiI3vBsfP91c=;
 b=cYtiL4xrFo59+CT4tkCcTlxRrIj4Xbm39Ankxtqo2OEq8iveNWw8XrNDNf+/gU9SZy
 vkjYjMtt3OzZUMlmBPWUfR9RW6Jej+gQPVVP/RNOO4Gclvy63jMnkQS80HeQzZPl5znH
 h6TJmZsTAlXPOEBOpzeYjQbKTQwcwZAEd0tpx7+gFGdK7ndW1b/W1XJTrYk56aD9HiMr
 3qQuLWLWHFqp3NC4A5fq1cz75Hoqh9rpy/Nc90IHB5QwXO9Y4/NNN/QRu3sKWS++lawC
 8apMcSXxUCKT2JJHn0D2p0Z0LCTBF01BAAfyPdACEma4dwAhm2UdyADyuxsn9OXkLVE1
 BI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=nvZV3LeNxekrWpaRWhJ9IY7XHJKxY4BwiI3vBsfP91c=;
 b=MzDwjmJpHtO3LMFYbKMocDOxhNTU6TtAuedN2oUbAX6IQY/n1zyAyeeEyYRKPl8KZv
 DJ1EyPOdO7O3gDAv6kmNC/+y0X+STPfPEwiJQ1m/rXNC0QvN8E3bx6Pfs94SUrzUoKP8
 UnO3vssZn6OBD/OitD5F51R2FPkuLRjiBtaVIjbj5OYvlLLPnB2RoPCMXD+wIlGN3V9h
 /4RoO8HLPgMpPVHTAS/gqp7/E4zm0g1irrNg63cXC7Vhoe38wwt6jt0dF7C7Ndtx7xX6
 onpve2RPdDr5MJXbREwG1H/qtpUAa/M1LXOwC7PceWCgOCrihZ1kZUBAsxx0UdMfouXY
 YYyg==
X-Gm-Message-State: APjAAAWvzrfGPIvIXjeD0pk0dXZRYxsTyUBzZ/XXYG13DUM6aqX+5H/j
 6axVo7WbmV+6AqmEoG0I4SI0OE/1
X-Google-Smtp-Source: APXvYqwTb88zjUK1Tip3lcAGR2RFq6LjKvjmZltYWrceMvO7khxXdM9CkpKKvkIoWFBQOcCebo4z1g==
X-Received: by 2002:a7b:c958:: with SMTP id i24mr409621wml.180.1582570153301; 
 Mon, 24 Feb 2020 10:49:13 -0800 (PST)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id l8sm460047wmj.2.2020.02.24.10.49.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Feb 2020 10:49:12 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [RFC 3/6] nvme: Introduce max_meta_segments ctrl and ops attribute
Date: Mon, 24 Feb 2020 10:48:56 -0800
Message-Id: <20200224184859.20995-4-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200224184859.20995-1-jsmart2021@gmail.com>
References: <20200224184859.20995-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200224_104921_682551_0B0C30A4 
X-CRM114-Status: GOOD (  17.71  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Max Gurtovoy <maxg@mellanox.com>, James Smart <jsmart2021@gmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Israel Rukshin <israelr@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch was originally posted by Max Gurtovoy <maxg@mellanox.com>

This patch doesn't change any logic, and is needed as a preparation
for adding PI support for fabrics drivers.

This patch parameterizes the number of sgl segments supported for
a separate metadata buffer.

The parameter is added to the nvme_ctrl_ops struct and the nvme_ctrl_ops
struct. nvme_init_ctrl() was modified to initialize the controller
value from the ops value. It was done in this manner such that if the
transport supports a singular/unchanged value, it can be set in the ops
struct and no other code is necessary. However, if the transport must
set the value on a per-controller basis, likely due to differents in the
host transport hardware, it can directly modify the field in the ctrl
struct.

CC: Max Gurtovoy <maxg@mellanox.com>
CC: Israel Rukshin <israelr@mellanox.com>
CC: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
Modifications to Max's patch:
 Rename max_integrity_segments to max_meta_segments.
 Add parameter to ops struct and initialize ctrl field in nvme_init_ctrl.
---
 drivers/nvme/host/core.c | 12 ++++++++----
 drivers/nvme/host/nvme.h |  3 +++
 drivers/nvme/host/pci.c  |  3 +++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4f08c637ec2e..8421eafa81c6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1624,7 +1624,8 @@ static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
+static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
+				u32 max_meta_segments)
 {
 	struct blk_integrity integrity;
 
@@ -1647,10 +1648,11 @@ static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
 	}
 	integrity.tuple_size = ms;
 	blk_integrity_register(disk, &integrity);
-	blk_queue_max_integrity_segments(disk->queue, 1);
+	blk_queue_max_integrity_segments(disk->queue, max_meta_segments);
 }
 #else
-static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
+static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
+				u32 max_meta_segments)
 {
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
@@ -1805,7 +1807,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
 	if (ns->ms && !ns->ext &&
 	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
-		nvme_init_integrity(disk, ns->ms, ns->pi_type);
+		nvme_init_integrity(disk, ns->ms, ns->pi_type,
+				    ns->ctrl->max_meta_segments);
 	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
 	    ns->lba_shift > PAGE_SHIFT)
 		capacity = 0;
@@ -4058,6 +4061,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	init_rwsem(&ctrl->namespaces_rwsem);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
+	ctrl->max_meta_segments = ops->max_meta_segments;
 	ctrl->quirks = quirks;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0725cc7c7a7a..4c6b6fc18560 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -262,6 +262,8 @@ struct nvme_ctrl {
 	struct work_struct fw_act_work;
 	unsigned long events;
 
+	u32 max_meta_segments;
+
 #ifdef CONFIG_NVME_MULTIPATH
 	/* asymmetric namespace access: */
 	u8 anacap;
@@ -414,6 +416,7 @@ struct nvme_ctrl_ops {
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
+	u32 max_meta_segments;
 };
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index da392b50f73e..7cbd2fbda743 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2690,6 +2690,9 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.free_ctrl		= nvme_pci_free_ctrl,
 	.submit_async_event	= nvme_pci_submit_async_event,
 	.get_address		= nvme_pci_get_address,
+	/* PCI supports metadata via single segment separate buffer only */
+	.max_meta_segments	= 1,
+
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

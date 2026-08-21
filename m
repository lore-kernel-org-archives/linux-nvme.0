Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC9A9C5DF94
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2026 23:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hHO0W5bDt+7+202ttHm6gRSpxKsUzZVlbi6wQIkVmNQ=; b=RLmFzyfV+Vej1C+JhPtx3YK2jW
	gr3zy0pjum9Rah1qaBBw89tJ0H6UDh/I2a79d2JuMUzcuVL8JT6xw65ra+w3BZ8O+tvj3Tw+tPJIf
	QJqEOoyJFUjZK3rER6jui4zhzE4XbAGBo94UxIp0oEbnCkcBKv1Ad6jAH8XkFQm6D989MosYygtqz
	anBbFI+6LIZcxDCdim8meu25K1kU2/2rDtPSSkYgI656F/EhyDOJsAE4+GQK1E5MFw2DMdRkoHbid
	HOEGirNUj9iCixLRbUJ9aphQOP+SnWmM1mwRNJQQWzBPqiJbWwRXfihqjjQXC+Up4tn0a30VZFvS2
	4uB6Fl1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxYGq-0000000E7l8-1ehl;
	Fri, 21 Aug 2026 23:03:32 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxYGn-0000000E7kf-0YqG
	for linux-nvme@lists.infradead.org;
	Fri, 21 Aug 2026 23:03:31 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2ced3386430so14612815ad.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Aug 2026 16:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1787353408; x=1787958208; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hHO0W5bDt+7+202ttHm6gRSpxKsUzZVlbi6wQIkVmNQ=;
        b=HdO0X7gchmRV6h3ROfDr0jn+bLoWREdJLBTbYdse7rKRmYK6a4ONdEqYdImpFmPTop
         heKGll/V+ys3aMctPzyxUDu9pKpaQZ0A17uqwtvH7FMxZWl20T0az/gnU5AI7SxE0cDl
         0IfsxvBJ1fHVkHZXrHZz78BXvL6n2b7gyBOgoE6PMcRRfO87AWA1OUDmI952Tc522e0V
         gVkQfzxnFGSOtCLzBF50NE9t0D3MXHiqEasJ2q/X7gdcxelrN6bpWG1epelHdGx8mEjW
         9+xFkhgsScMz0Yjx11hN6U4s9uIstXp5zLS84q9kg8Noq8K2/sXs+k4omQJ95u4Lfgt7
         J6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787353408; x=1787958208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hHO0W5bDt+7+202ttHm6gRSpxKsUzZVlbi6wQIkVmNQ=;
        b=J+iKVvXQzFXjxxTEAuS/B0g6H7pvrhBUDC28p/xgDMwVJXFgThpr/BDn9Qbmf0n0Sk
         KXkXRh/SifCVEF9sqNzUO0sgennYzeE8it7t4SQ59/AF+ajRdvUs8/4hq5bpzx/46b66
         k9aIiKZv8aJXs1fyAVCjyLGGjuIQ8nAlNqBvwA0z1PmE03zhtBgiQk6NLwVGwpFXrugy
         ThDfZ4Gh/hHyWkzTZT5D2bZ0JSP4XLKM4p5FrkArctzRLDyeugU7DCz9TRxTKEUDzBtG
         acX0uAiAj82HpSqL0RwHYnKXmYUn9K3uMBIQpnHDWewGPvec71m+auCpZyZXCGa7XOTg
         xMPg==
X-Gm-Message-State: AFuF++kJ9G5UqxPzQWJw1eH+vQdby8Y+SE8L+RR/1d7g432O26cwctEu
	/lhPcl5XSrwT/h9XXkerEj5fwSi5f7kYxJXQzk20Da3DSVckrgbuOn8RY2P8PL7p1Us=
X-Gm-Gg: AR+sD11ujKL+lF8wYA4kERWXjaULZcrEkH2DJZT5kua4b91uXUR/j8YHkAZ4Usgnel8
	VKmyZe6RuJsqFLc3DaxQIc2WpPe+ZRxYXrMSRHwR8sIy7Ms62fJ4u1FzW5e6BPoXuuN7bCzEPrJ
	NWHdtKm8IviFeAzdpqb8t7W0onDvc/Jm3a2F/VLMTnJh6W6O4jCXsPIvUC3l0WTgaWv8IzRd4dd
	8wXPZu6Yc5NS4vwNsLmdyG086cr8fcg2o9QGVSgT9me/m6rBW6nioTgkE3CHrAVZ5upNvYTNiUd
	tN4aHPKu2cXRpWahbLxV2O9hReHpBJYpi7AEkUgBU5rxYCTLqtPYVoUdPvPO7B0u1mrMHZ18dif
	YYY24LOSpJNs4+FMLFHopOvLy0aIi2O2PBIQzsSXlQLNELVOroaaSGDNcOnLfx1nfVYpyNLWnAI
	LUM5+YTcB3/HbROhmdXWo05HlJRF7w+j7eSyQNZKMXdc1hK+b5dlcxo3/z/9K8JZei6vMRSiLvQ
	64tf2XFTIq9
X-Received: by 2002:a17:90b:4b8c:b0:38e:bbf1:de34 with SMTP id 98e67ed59e1d1-395c35eb2c7mr17091343a91.7.1787353407932;
        Fri, 21 Aug 2026 16:03:27 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-327f909c6c9sm122799eec.6.2026.08.21.16.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 16:03:27 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH 1/2] nvme: print namespace IDs as unsigned 32bit value
Date: Fri, 21 Aug 2026 16:03:09 -0700
Message-ID: <20260821230310.3937527-1-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_160330_154547_C8955CFF 
X-CRM114-Status: GOOD (  17.58  )
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

NSIDs are 32-bit unsigned values, but a number of log messages print
them with %d. An NSID larger than 0x7fffffff is rendered as a negative
number, which is confusing in the kernel log and makes the message hard
to correlate with the namespace it talks about. Sparse NSID spaces
where high NSIDs are common are the most likely to hit this.

The nsid sysfs attribute has the same problem, and there it is worse
because userspace parses the value.

For example:
$ grep . /sys/class/block/nvme0*/nsid
/sys/class/block/nvme0c0n1/nsid:10
/sys/class/block/nvme0c0n2/nsid:-16
/sys/class/block/nvme0c0n3/nsid:11
/sys/class/block/nvme0c0n4/nsid:-2000000016
/sys/class/block/nvme0n1/nsid:10
/sys/class/block/nvme0n2/nsid:-16
/sys/class/block/nvme0n3/nsid:11
/sys/class/block/nvme0n4/nsid:-2000000016
$

Print all of them with %u. Several messages in these files, including
two in zns.c right next to the ones being changed, already use %u, so
this only makes the rest consistent with them. No functional change
other than how the NSID is formatted.

Fixes: 2b9b6e86bca7 ("NVMe: Export namespace attributes to sysfs")
Fixes: 1d5df6af8c74 ("nvme: don't blindly overwrite identifiers on disk revalidate")
Fixes: ed754e5deeb1 ("nvme: track shared namespaces")
Fixes: 9ad1927a3bc2 ("nvme: always search for namespace head")
Fixes: 71010c309454 ("nvme: implement multiple I/O Command Set support")
Fixes: 2f4c9ba23b88 ("nvme: export zoned namespaces without Zone Append support read-only")
Fixes: 0ec84df4953b ("nvme-core: check ctrl css before setting up zns")
Fixes: 2079f41ec6ff ("nvme: check that EUI/GUID/UUID are globally unique")
Fixes: ce8d78616a6b ("nvme: warn about shared namespaces without CONFIG_NVME_MULTIPATH")
Fixes: ac522fc6c316 ("nvme: don't reject probe due to duplicate IDs for single-ported PCIe devices")
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/core.c  | 18 +++++++++---------
 drivers/nvme/host/sysfs.c |  2 +-
 drivers/nvme/host/zns.c   |  4 ++--
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cc014cdc72ff..6ac173ba65d7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1610,7 +1610,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
 	}
 
 	if (nvme_multi_css(ctrl) && !csi_seen) {
-		dev_warn(ctrl->device, "Command set not reported for nsid:%d\n",
+		dev_warn(ctrl->device, "Command set not reported for nsid:%u\n",
 			 info->nsid);
 		status = -EINVAL;
 	}
@@ -4126,13 +4126,13 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 		    ((ns->ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) &&
 		     info->is_shared)) {
 			dev_err(ctrl->device,
-				"ignoring nsid %d because of duplicate IDs\n",
+				"ignoring nsid %u because of duplicate IDs\n",
 				info->nsid);
 			return ret;
 		}
 
 		dev_err(ctrl->device,
-			"clearing duplicate IDs for nsid %d\n", info->nsid);
+			"clearing duplicate IDs for nsid %u\n", info->nsid);
 		dev_err(ctrl->device,
 			"use of /dev/disk/by-id/ may cause data corruption\n");
 		memset(&info->ids.nguid, 0, sizeof(info->ids.nguid));
@@ -4147,7 +4147,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, &info->ids);
 		if (ret) {
 			dev_err(ctrl->device,
-				"duplicate IDs in subsystem for nsid %d\n",
+				"duplicate IDs in subsystem for nsid %u\n",
 				info->nsid);
 			goto out_unlock;
 		}
@@ -4161,20 +4161,20 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 		if ((!info->is_shared || !head->shared) &&
 		    !list_empty(&head->list)) {
 			dev_err(ctrl->device,
-				"Duplicate unshared namespace %d\n",
+				"Duplicate unshared namespace %u\n",
 				info->nsid);
 			goto out_put_ns_head;
 		}
 		if (!nvme_ns_ids_equal(&head->ids, &info->ids)) {
 			dev_err(ctrl->device,
-				"IDs don't match for shared namespace %d\n",
+				"IDs don't match for shared namespace %u\n",
 					info->nsid);
 			goto out_put_ns_head;
 		}
 
 		if (!multipath) {
 			dev_warn(ctrl->device,
-				"Found shared namespace %d, but multipathing not supported.\n",
+				"Found shared namespace %u, but multipathing not supported.\n",
 				info->nsid);
 			dev_warn_once(ctrl->device,
 				"Shared namespace support requires core_nvme.multipath=Y.\n");
@@ -4420,7 +4420,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 
 	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
 		dev_err(ns->ctrl->device,
-			"identifiers changed for nsid %d\n", ns->head->ns_id);
+			"identifiers changed for nsid %u\n", ns->head->ns_id);
 		goto out;
 	}
 
@@ -4447,7 +4447,7 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	if (info.ids.csi != NVME_CSI_NVM && !nvme_multi_css(ctrl)) {
 		dev_warn(ctrl->device,
-			"command set not reported for nsid: %d\n", nsid);
+			"command set not reported for nsid: %u\n", nsid);
 		return;
 	}
 
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index abf8edaae371..02a2490a9ed7 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -166,7 +166,7 @@ static DEVICE_ATTR_RO(eui);
 static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
-	return sysfs_emit(buf, "%d\n", dev_to_ns_head(dev)->ns_id);
+	return sysfs_emit(buf, "%u\n", dev_to_ns_head(dev)->ns_id);
 }
 static DEVICE_ATTR_RO(nsid);
 
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 2a152e87bd76..e31ec6f4f94f 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -48,12 +48,12 @@ int nvme_query_zone_info(struct nvme_ns *ns, unsigned lbaf,
 			NVME_CMD_EFFECTS_CSUPP)) {
 		if (test_and_clear_bit(NVME_NS_FORCE_RO, &ns->flags))
 			dev_warn(ns->ctrl->device,
-				 "Zone Append supported for zoned namespace:%d. Remove read-only mode\n",
+				 "Zone Append supported for zoned namespace:%u. Remove read-only mode\n",
 				 ns->head->ns_id);
 	} else {
 		set_bit(NVME_NS_FORCE_RO, &ns->flags);
 		dev_warn(ns->ctrl->device,
-			 "Zone Append not supported for zoned namespace:%d. Forcing to read-only mode\n",
+			 "Zone Append not supported for zoned namespace:%u. Forcing to read-only mode\n",
 			 ns->head->ns_id);
 	}
 
-- 
2.54.0



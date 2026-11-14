Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180B60A5BE9
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=WVCGDVKn;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=E6NMOyv1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=2iAtZsFyt4C2826PuxwpFZtp0CfSh5l8d/TwOV9OV+8=; b=WVCGDVKnumPKkQ
	F5CfXXYMD+1E1GGNv0xNZvxezBVFUZ9ej7HoBM/Fpjmo9qtzbV65SaEkcymwLItgujrykRNovV5b/
	pjR/nAd4kwIz+g6gREQiVUFtG7GMF4iJKexxNflhWwYbjQuYYT2Rjhj9DcnH+XiWwKbT2Kg8qZvTy
	mub44o7CGSZ7JWOYtY5bc4DpPO1i//ifjCS9AekJOGraKqtRjgus9Tg658coY9Aaf/BZiU81RYAOl
	0FAWl35E2b9DCmhGoLFtARKdz18Fy7CWDt9E5o7JfRcoIMtEicOSj23UeW4dI3cI5QmrArpSovCLY
	hewNMy7wqVWQCQisQrWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45Z-0000000F9xP-2dZO;
	Sat, 14 Nov 2026 03:06:01 +0000
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45U-0000000F9ne-0iRM
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:05:57 +0000
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-14394530ec6so2106703c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 19:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794625555; x=1795230355; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2iAtZsFyt4C2826PuxwpFZtp0CfSh5l8d/TwOV9OV+8=;
        b=E6NMOyv1QTZVFuFYyb0DEKNg7Abyr2Lz1Ambwu5YOQJK7yydAiDXpmuRm4wcLhrdGk
         w/Vl+l7pIv8Y+CJgbxd3wi8B1xnVerf4FFjlN83YF1qCc8Yxuf4WnmdMyMMPVX7eY5D0
         pDeZWTvInYV3KtYSRDTilBmc4Wo6K5V1iwwy/UAeaL1WDOM9GwhpiMwo9YIIX0OUSPwv
         WXVYIkMGuhP7uIRyahxo9Eo2vGpzdI85rFyklua7dbzh6YZh+L83E3Qpc0A0lyDkaUcd
         LDEPnppOXWF77K6dr1rJsYcgrio2nT+dtffMGcMFw3jRN3s5J0TBYEMRAsYv4FReIdUG
         C/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625555; x=1795230355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2iAtZsFyt4C2826PuxwpFZtp0CfSh5l8d/TwOV9OV+8=;
        b=yxl6EdSkwLfG+GDntpGGwV2n/d35ouU3QIGB57p3mwWO02OxNFKYACdHsYEOAF1Kmb
         hygWMLIV9FKPIshiwr9KvjoveV8XMn3ocAawY7Mcw+H9a3tZdzBF5zzAvjW0/Ba+feFf
         lBddyalOEtuNbvkaYD/ZlDXavQLDq73z8aKTgZL3L1Tk/BX0R4CiU7zRLSfzkrWoC1uO
         6wsnm7tvUWcnOPpsGoQ4FAR+HfxWMuhEcpTYGylxE5lruDofK8mP4j79NZY2RuNOLq9U
         7/9k0KXG4yyzOQ5O6X0NptO2GvBM9G9C+GHHBYa8yO2crKA5Dq/gPStKjWp6qnLVeWi0
         N67w==
X-Forwarded-Encrypted: i=1; AL+hErGbbIxo5jc5riugWINSpQTRZtiliEYDj+kmaG7+hZzSL1Coo7jf7zBnKE3UlhY11SlgErEFUb8LqCqF@lists.infradead.org
X-Gm-Message-State: APuU4Z9X8n55v/G8/e/nnK/w7V37AhG4tXQ7IptmuxVblkgANs77PuhV
	e/ttK2pT0IoWMlhEX2Ntz2yaAJZcewaSToydN4LbPXGxYs7D8HFDeRDgpz3YAD1ro6I=
X-Gm-Gg: AYBFou3J4ZfdzJNpbuBVZjboN6+O8uQqZdmsQJfaFCNXm5BYL4GQRZSP0sLo/sKPqMV
	TcGAwe/CBuNDEsEuUPKDVcLdvFo3WLrDP6fHMniol+FTc2cjQbXGf5ojqKODEwWVYa8pULwAMyB
	qRW13OZuC6r4xBi/SNGZ8yGG1LWVYepKMrTG/30LDKTtiYd9Te/sVYjaCJ7xtwLgigbAwd3kSkJ
	pJCb7uhLK7qS3Sb5EmzVGM6gJnfSzYUZCAaVPvdKAaFdF2LtAdzbzjHo3RGMN1X81BEbC+ZAJUp
	3wPcxbOJcosvc/lQo3LBdA/4GxIxZQ/ncqGEB20wtgRCbRvleU7a2YEvg1cfbWx7B4sSK1VSYeT
	lyYNN9XM2xoGart3/703OidSrg1bMvNqn4mcpuThz/URoib3jWnLKGZNabpoPuk5ZCBFHfR1MKg
	FoSOTqJ9cIQbTmPmtQL5ekgpMP+qrT/DRNLYPnoqBQovX6X6AUHfwTr59aytigtOlWBE4V9bO9o
	Sc3iUSB+fDC4+BXi9uSic+lu2/iWFYTc32vIhJpEFV21rxQXMdY4tUeGMeX44SjIQWkHFiPPnYS
	+N8YpRBpBtkSq2gQ2V0EZUjYs0459CMT381H7aGZVgSrRWcFV7IdtWdUI+jNSDMHiHFOp2v31Q=
	=
X-Received: by 2002:a05:7022:f904:b0:143:2719:f800 with SMTP id a92af1059eb24-1b50313d950mr4026638c88.40.1794625554937;
        Fri, 13 Nov 2026 19:05:54 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50316e008sm10829382c88.6.2026.11.13.19.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:05:54 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v7 06/17] nvme: Rapid Path Failure Recovery read controller identify fields
Date: Fri, 13 Nov 2026 19:04:20 -0800
Message-ID: <20261114030454.2836543-7-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114030454.2836543-1-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_190556_303275_7CC0CD8A 
X-CRM114-Status: GOOD (  16.05  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

TP8028 Rapid Path Failure Recovery added new fields to controller
identify response. Read CIU (Controller Instance Uniquifier),
CIRN (Controller Instance Random Number), and CCRL (Cross-Controller
Reset Limit) from controller identify response. Expose CIU and CIRN
as sysfs attributes.

Together with CNTLID, CIU and CIRN identify the current instance of the
controller. A controller that is reset gets new values. Exporting them
lets a user tell controller instances apart, correlate an entry in the
CCR log page (which reports ICID and CIU) with a specific controller,
and issue a CCR command by hand when debugging. The values are cached
from the last Identify, so they are also available when the controller
can no longer process admin commands.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 Documentation/ABI/stable/sysfs-nvme | 11 +++++++++++
 drivers/nvme/host/core.c            |  4 ++++
 drivers/nvme/host/nvme.h            |  3 +++
 drivers/nvme/host/sysfs.c           | 23 +++++++++++++++++++++++
 4 files changed, 41 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index 9291595f8102..e3395e5730bb 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -9,6 +9,17 @@ Description:
 		of the NVMe controller, as reported in the Identify
 		Controller data structure.
 
+What:		/sys/class/nvme/nvmeX/cirn
+What:		/sys/class/nvme/nvmeX/ciu
+Date:		October 2026
+KernelVersion:	7.5
+Contact:	Mohamed Khalfella <mkhalfella@purestorage.com>
+Description:
+		Shows CIRN (Controller Instance Random Number) and CIU
+		(Controller Instance Uniquifier) of the current instance
+		of the NVMe controller as reported by Identify Controller
+		data structure.
+
 What:		/sys/class/nvme/nvmeX/cntlid
 Date:		February 2016
 KernelVersion:	4.6
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 03671bba1754..38b27d8db011 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3693,6 +3693,10 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->crdt[1] = le16_to_cpu(id->crdt2);
 	ctrl->crdt[2] = le16_to_cpu(id->crdt3);
 
+	ctrl->ciu = id->ciu;
+	ctrl->cirn = le64_to_cpu(id->cirn);
+	ctrl->ccrl = id->ccrl;
+
 	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->oncs = le16_to_cpu(id->oncs);
 	ctrl->mtfa = le16_to_cpu(id->mtfa);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 82cdc7d32b22..0c87072c5265 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -401,11 +401,14 @@ struct nvme_ctrl {
 	u16 crdt[3];
 	u16 oncs;
 	u8 dmrl;
+	u8 ciu;
 	u32 dmrsl;
+	u64 cirn;
 	u16 oacs;
 	u16 sqsize;
 	u32 max_namespaces;
 	atomic_t abort_limit;
+	u8 ccrl;
 	u8 vwc;
 	u32 vs;
 	u32 sgls;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 10018c6356b6..5b549a0513c6 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -491,6 +491,27 @@ nvme_show_int_function(queue_count);
 nvme_show_int_function(sqsize);
 nvme_show_int_function(kato);
 
+static ssize_t nvme_sysfs_ciu_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%02x\n", ctrl->ciu);
+}
+static DEVICE_ATTR(ciu, S_IRUSR, nvme_sysfs_ciu_show, NULL);
+
+static ssize_t nvme_sysfs_cirn_show(struct device *dev,
+					  struct device_attribute *attr,
+					  char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%016llx\n", ctrl->cirn);
+}
+static DEVICE_ATTR(cirn, S_IRUSR, nvme_sysfs_cirn_show, NULL);
+
+
 static ssize_t nvme_sysfs_delete(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
@@ -943,6 +964,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_numa_node.attr,
 	&dev_attr_queue_count.attr,
 	&dev_attr_sqsize.attr,
+	&dev_attr_ciu.attr,
+	&dev_attr_cirn.attr,
 	&dev_attr_hostnqn.attr,
 	&dev_attr_hostid.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
-- 
2.56.0



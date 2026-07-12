Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B558AC43458
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jt+jFO6RlYQHUjzVHCgosSICrSZ2jTFk9UEpM3tYb70=; b=MhLacv8pbcT9wh37rQVd+StGId
	AhE/WFdBY0ZUGrJpH4cC3SAMGBRdb4EIa7Xx4NEDUqM/ChdpYbsGBgbrOAU99zoA2m0CfEIpdfo/z
	dloWshHVXDNmbgoJa/PIHbxDG/IFWqepCJszbth5yRBIlQyaUGJTAZaYnTZwU6eYxfqNr0JYP2f+f
	Q8cWGvAZt8s5BpofL/nNfisKa4jIQsDP+JD9H35YUkmh+IEcR0eLv+3tSIQi0Kn5ta73JdnM8AJdP
	gYQFornh+GdMlzljAgt5Vz4l/3vgrXCqC46dMMqeolvn29UNCJqdwcc+OLbrmswExHj8jUcsCFB07
	+OQyYJwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijso-000000071Rt-1Lfq;
	Sun, 12 Jul 2026 02:25:30 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsm-000000071PY-0B5W
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:29 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so97378a91.0
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823127; x=1784427927; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jt+jFO6RlYQHUjzVHCgosSICrSZ2jTFk9UEpM3tYb70=;
        b=B6NKAhcH7UluBGDAO5bhvlbVuzVGXAYls9O1tIKzDukQcZgtaC9kccehYRsD6f88SW
         1mXVgbof2vHm3nDSODEf5GG20F1USoV12nbNqIsuY9NzXwzCYA1dWK9yBNT6vBAvqCIh
         /YRY141PvgxcakbH/Q4BlULQ7ZKrkGy4X/q+0xk8J9B7hdZdKWBq3I9WnJXlMaGhbXQH
         lBocjc9495d5/VMbJD9o/p/GytDNtnbhCRHjXnTxqray97Y4dhmRHFnTdL/xiUTUrBtt
         ZAn6DMLYWkgJVLh9Pb6hxaTQJINjYAEeG/pxHsT+nX7ekVOBXZsfDXup7lepUHOMx4gZ
         ROAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823127; x=1784427927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jt+jFO6RlYQHUjzVHCgosSICrSZ2jTFk9UEpM3tYb70=;
        b=HWN8YjvI1YP90XN4wsUmHpVK+lJv6bCkSJDY4CzWZDtZv4fcw4snDU8VJYqA9aEszf
         Nyu78uxFWSMcx3M22JSUk70kNpyfOqph/8azD1aZcVv9ntoXuxbN87RdCRtmabA65hF5
         m4sBHedVeXzTkgFfCBZqnYj3do4djfowriPqL0fexObaKfddk0eJqh3l5tgRmGdjOWQE
         zgb/KsP0oW6pDPPAVXDT1kMmeCg9Mus4+NOGedxLrMKwC2lC04fd1RRVwVv7/K4heEgH
         uhemOS28vMKiNb2QxAd26jiPbSYvg/nQXV0cUsz0Qpqozlfm3dKJkpb1vccYkfXIpe1r
         4lrA==
X-Forwarded-Encrypted: i=1; AHgh+RqOS8gJz0YDw3RqWaeo2cbvOpfmje7nSADLgJIlXH7i9EJhjX0ieluqWgpaCnkTZ7zrKKzqVPOBrmRo@lists.infradead.org
X-Gm-Message-State: AOJu0YzQ/jNVZ8s8fQxmrBPd7fIP5E9B9t8RxZfvQn/EUAZgN0cnTXh1
	mXS45N3Z7++wtxPScER5zIrSaRuxN7HI03k3N/bhetNgGZzJhovz6IFjh8q5XGYiBQg=
X-Gm-Gg: AfdE7clrGlxElsFzhw+zriKQ1jpry4MuIC0epO1z7LBg8cqr0MhAMcYrYJ9A2f4ulxq
	CRmsIF28EaAA2fG3F3wXSIdjAPypvTrKtTT6A+7GXd5mHQ4vyM4jpI1c4WGsIZazPmQvsLR08Ma
	U0UaIWGqg5+cRESm0gSloBbWfCRLU/MinIgYgp3Q/5OvAULjruHL2p68WkVwjEztbZpVa8CPK1N
	GdOSZQKauA/5MTsrbz5VzRjR0QWEdyxoXQH2m1XbZUAJDdKk/Xd1YQHTw2bnjkk646O5jQA0Y0f
	ZNASg10Ajq/uPWujzt4b3N7kW5aj0MrWExSuYHAzm/GT31X8UhTqHqfwnxzNEK+NHrD+sPmMsYh
	70iwWE1Rn9rtnuMxa0rCiDTF2tpCNSATj3hJv6nI7cgvapMJOsoGSAwaXkrCNCy9/iFOGShwhb0
	cz+cLi
X-Received: by 2002:a17:90b:3502:b0:387:e0db:bc32 with SMTP id 98e67ed59e1d1-38dc7bbdb04mr4091119a91.40.1783823126896;
        Sat, 11 Jul 2026 19:25:26 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:26 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v5 06/16] nvme: Rapid Path Failure Recovery read controller identify fields
Date: Sat, 11 Jul 2026 19:23:27 -0700
Message-ID: <20260712022437.3743117-7-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712022437.3743117-1-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192528_089563_7AD20F5F 
X-CRM114-Status: GOOD (  12.93  )
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

TP8028 Rapid Path Failure added new fields to controller identify
response. Read CIU (Controller Instance Uniquifier), CIRN (Controller
Instance Random Number), and CCRL (Cross-Controller Reset Limit) from
controller identify response. Expose CIU and CIRN as sysfs attributes
so the values can be used directly by user if needed.

Also add the nvme_fence_timeout_ms() helper that derives a fencing
timeout from the controller keep-alive timeout (kato).

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c  |  4 ++++
 drivers/nvme/host/nvme.h  | 10 ++++++++++
 drivers/nvme/host/sysfs.c | 23 +++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index db0c8ad4628a..203ecafc1aec 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3643,6 +3643,10 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
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
index a679a4c61462..9b071076c9f4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -384,11 +384,14 @@ struct nvme_ctrl {
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
@@ -1313,4 +1316,11 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 	return (ctrl->ctrl_config & NVME_CC_CSS_MASK) == NVME_CC_CSS_CSI;
 }
 
+static inline unsigned long nvme_fence_timeout_ms(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+		return 3 * ctrl->kato * 1000;
+	return 2 * ctrl->kato * 1000;
+}
+
 #endif /* _NVME_H */
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index abf8edaae371..dd48c0989301 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -487,6 +487,27 @@ nvme_show_int_function(queue_count);
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
@@ -941,6 +962,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_numa_node.attr,
 	&dev_attr_queue_count.attr,
 	&dev_attr_sqsize.attr,
+	&dev_attr_ciu.attr,
+	&dev_attr_cirn.attr,
 	&dev_attr_hostnqn.attr,
 	&dev_attr_hostid.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
-- 
2.54.0



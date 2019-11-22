Return-Path: <SRS0=ia7R=ZO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CCEC432C0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 07:42:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 064AD20708
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 07:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pMDWDfKV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="THpaf1NY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 064AD20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UjXWTgsn0lST5nwq3ntO+ubSHoKO4PxX+Iv0MAYmMcY=; b=pMDWDfKVa3/o1W
	egCiJqjse9dVwPMJ3LcpQB5gIvbizC2xC11mP0sBDWd/2PahOZHs2DSlsw5lGDN9fU9Hy6U+mRarh
	VWU5r3Q2TiTVgyyuJoK+FGG5uwTtt0lBkBV83wysLJI/kIOwoLibQCvsTfLqcdCHvXkWC8rUDDmLC
	rIFZakdzUxgNuzYq6NVTV+R3BH+iP16U9JylG1JPXT4PhCKLikX7bNv/0H0BX97mjWOz5PHLmgWwk
	pCQBEKFvREilrm7Cze7+uCGOluz4YXfSZhh0GFip5xkPmPjLsW0C2NClee+FH3Ti5QorqFNYWyL1n
	2+LzxG+tC0SroCRqQnKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iY3Zw-0003Te-MI; Fri, 22 Nov 2019 07:42:08 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iY3Zn-0003MX-Ir
 for linux-nvme@lists.infradead.org; Fri, 22 Nov 2019 07:42:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1574408519; x=1605944519;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qRZ1RrwIMWVN3lJQWCDnF+sWOU1Ch+juJPk30Flh5To=;
 b=THpaf1NYth6JqAHDlgYgVreLEL7+MawBGQdLG8cxWXXOWmvHKIh+99AS
 bAv4QiOt2rSRMtCU3WRxuhzo69Of5iEXM5xThR9gMqPtaCby9Y/FgdWf6
 +G5lV6ax7oW9Xf6lC6NSuYTjBs9oXVQbz5VxMW70qaH6E+AKuo0k5nH8U
 aDD2EQET5SpGAn7283RsQunWCVephDYEw0s0wmQz+EzmrTQ8XK3IDq1Fh
 HzzlnRjE9oDrA6wAVm3pMdq3UhCUAZ2T056dEkdIIojpLhEyVr1JKNhes
 /dhEH73bw4xbS6GJM8Hp7yNj9abVjaHJ8v02GpoGuGA9V/SjYqgb9UXAz A==;
IronPort-SDR: zbjYr6+EEvYgwnw1jOMHzGzeA3uMzbiMvYZSdX7+2jWzZsAC6jR6KPPNJ1ecnaTjmxHk00pbvw
 v0nARdry8FrlgZo/zq1OxvvXq/8//1aoyCONVJz0ZhUg+dqmwnoUFfoJnpTtA4gJFRtOOYen80
 KDFqmymkxGtcwf+TzmIk5RwYGBspXOFO0hA70u1I8y6T9/8CufKaNgvZVLf6JMeZjw6Dxap7jj
 vnp80cuzfo6aZ6kehDQHHqM86r+k8XGotjxGAKILysXnljvQJ7MmIu+CN/rTZ0wjMnuCtbCKOU
 uzI=
X-IronPort-AV: E=Sophos;i="5.69,229,1571673600"; d="scan'208";a="231139191"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2019 15:41:58 +0800
IronPort-SDR: 5nVOTwCFbviLRIXKHQDofsFTqyWY7id9nCKLYsspNLexOfliCMBu0ZDht+UzvZLW8pnEA7VZji
 9cuSupUVhQGUch35hl61ZGBXIU74NNiOCGT5xDfEODR6MhEsCCsPGfOQDSaYd/bsE3yeWCFZRh
 t+xk8MhcTcmk1XBlBYJa56mcgMO3yLVKtqRwEsRJ8Of4rWE14/hptffi5yxgGtTmGXitdm0TIi
 BVJFbBvCLBLNrWiSMuPJGoaVhIOjNCOm2gd8p1vmqbN1HVd0HEHL6EEttwXFVR+yrWKMvRLmob
 3vjBUqf/rCq64RwubBMeXBSs
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2019 23:36:44 -0800
IronPort-SDR: zIGVNIyNSdrGYc1SBDl8+rWzW1EgrIoj3ZesMkSgX3FLRnhJuvcwmb4UcBwx177yX8r2jil6/5
 OqOQ5x2f7qlizlTxFEwco8HkGoe/Tj5sG3cywe+NuQ6xnkyvrrHf/tF6YkkBh3LCgxNDlUWZdT
 WKdQbu/oH3BiQ6VkHbDqPpu+S2WJcZrijuLqAgb8LcFOjm9S+jsFQ13E4N26epHEsn8Bg5+1QS
 oyE1NHHq+K3oAflyxVy7ZMzFXqIlP+BH8LsFR+5jAbknId5lS9VCBS6G7BiXcFX4EVWF0Uhcw6
 iqM=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip01.wdc.com with ESMTP; 21 Nov 2019 23:41:58 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/2] nvmet: make ctrl-id configurable
Date: Thu, 21 Nov 2019 23:41:53 -0800
Message-Id: <20191122074154.12159-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20191122074154.12159-1-chaitanya.kulkarni@wdc.com>
References: <20191122074154.12159-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191121_234159_625655_1D7AE947 
X-CRM114-Status: GOOD (  15.60  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch adds a new target subsys attribute which allows user to
optionally specify target controller IDs which then used in the
nvmet_execute_identify_ctrl() to fill up the nvme_id_ctrl structure.

For example, when using a cluster setup with two nodes, with a dual
ported NVMe drive and exporting the drive from both the nodes,
The connection to the host fails due to the same controller ID and
results in the following error message:-

"nvme nvmeX: Duplicate cntlid XXX with nvmeX, rejecting"

With this patch now user can partition the controller IDs for each
subsystem by setting up the cntlid_min and cntlid_max. These values
will be used at the time of the controller ID creation. By partitioning
the ctrl-ids for each subsystem results in the unique ctrl-id space
which avoids the collision.

When new attribute is not specified target will fall back to original
cntlid calculation method.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
Changes from V1:-
1. Add cntlid max and min configfs attributes.
2. Use simple if .. else statements instead of ternary operators.
---
 drivers/nvme/target/configfs.c | 65 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  8 +++--
 drivers/nvme/target/nvmet.h    |  2 ++
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..5316cdb1b271 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -862,10 +862,75 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
 
+static bool nvmet_subsys_cntlid_store(struct nvmet_subsys *s, const char *page,
+				      bool min)
+{
+	bool ret = true;
+	u16 cid;
+
+	down_write(&nvmet_config_sem);
+	if (sscanf(page, "%hu\n", &cid) != 1) {
+		ret = false;
+		goto out;
+	}
+
+	if (min)
+		s->cntlid_min = cid;
+	else
+		s->cntlid_max = cid;
+out:
+	up_write(&nvmet_config_sem);
+
+	return ret;
+}
+
+static ssize_t nvmet_subsys_cntlid_show(struct nvmet_subsys *s, char *page,
+					bool min)
+{
+	if (min)
+		return snprintf(page, PAGE_SIZE, "%u\n", s->cntlid_min);
+
+	return snprintf(page, PAGE_SIZE, "%u\n",  s->cntlid_max);
+}
+
+static ssize_t nvmet_subsys_attr_cntlid_min_show(struct config_item *item,
+						 char *page)
+{
+	return nvmet_subsys_cntlid_show(to_subsys(item), page, true);
+}
+
+static ssize_t nvmet_subsys_attr_cntlid_min_store(struct config_item *item,
+						  const char *page, size_t cnt)
+{
+	if (!nvmet_subsys_cntlid_store(to_subsys(item), page, true))
+		return -EINVAL;
+
+	return cnt;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_cntlid_min);
+
+static ssize_t nvmet_subsys_attr_cntlid_max_show(struct config_item *item,
+						 char *page)
+{
+	return nvmet_subsys_cntlid_show(to_subsys(item), page, false);
+}
+
+static ssize_t nvmet_subsys_attr_cntlid_max_store(struct config_item *item,
+						  const char *page, size_t cnt)
+{
+	if (!nvmet_subsys_cntlid_store(to_subsys(item), page, false))
+		return -EINVAL;
+
+	return cnt;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_cntlid_max);
+
 static struct configfs_attribute *nvmet_subsys_attrs[] = {
 	&nvmet_subsys_attr_attr_allow_any_host,
 	&nvmet_subsys_attr_attr_version,
 	&nvmet_subsys_attr_attr_serial,
+	&nvmet_subsys_attr_attr_cntlid_min,
+	&nvmet_subsys_attr_attr_cntlid_max,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 28438b833c1b..990ad4c7bdfd 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1267,8 +1267,11 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!ctrl->sqs)
 		goto out_free_cqs;
 
+	if (subsys->cntlid_min > subsys->cntlid_max)
+		goto out_free_cqs;
+
 	ret = ida_simple_get(&cntlid_ida,
-			     NVME_CNTLID_MIN, NVME_CNTLID_MAX,
+			     subsys->cntlid_min, subsys->cntlid_max,
 			     GFP_KERNEL);
 	if (ret < 0) {
 		status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
@@ -1416,7 +1419,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		kfree(subsys);
 		return ERR_PTR(-ENOMEM);
 	}
-
+	subsys->cntlid_min = NVME_CNTLID_MIN;
+	subsys->cntlid_max = NVME_CNTLID_MAX;
 	kref_init(&subsys->ref);
 
 	mutex_init(&subsys->lock);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e837c9..6492d12e626a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -211,6 +211,8 @@ struct nvmet_subsys {
 	struct list_head	namespaces;
 	unsigned int		nr_namespaces;
 	unsigned int		max_nsid;
+	u16			cntlid_min;
+	u16			cntlid_max;
 
 	struct list_head	ctrls;
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

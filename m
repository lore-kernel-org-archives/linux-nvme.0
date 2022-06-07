Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86C6C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 13:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version:In-Reply-To:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JlAFfhfnb/xaRQkis+PXZRptMz2DObW2ekQ4F6DG5T8=; b=L0OIkVKgZhSftMXBHg+HhWpQqv
	QqjuII8Q3XDOAeuzoHCt6sAiEZGZqNrcIetx63lHJBYBFuIdOMRwOUl5XpAT2GmoXAnSnEU2QS+yn
	cyLzMj+aWUH4fenjl2WzLy36xRXVqExgACGrqezV+Szfni+bI+QEMa4LWxCTLA2jki7pN1jfUpK7u
	IcB6hgDcG6yS7lE01cJZqAdx81/aVuts5F8oA1xjIVdzz93zbzoh69TUApWTH+Z7lSm4Xgos3roCd
	jXUjw+HFwcAxNJTJseSceVZFn3G6sPKcB/GqSxnDdSICZcRc/Ped+d089F2KvXUUnbIRzS67lwlPP
	FNytVa1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyZUY-007pAp-TB; Tue, 07 Jun 2022 13:43:30 +0000
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyZUR-007p8e-GS
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 13:43:25 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220607134311euoutp01db3284bbfb2f2326bf1d29a748d682d7~2Wnmsdm0l0625406254euoutp01f
	for <linux-nvme@lists.infradead.org>; Tue,  7 Jun 2022 13:43:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220607134311euoutp01db3284bbfb2f2326bf1d29a748d682d7~2Wnmsdm0l0625406254euoutp01f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1654609391;
	bh=JlAFfhfnb/xaRQkis+PXZRptMz2DObW2ekQ4F6DG5T8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=BRGzW4g/4R/iIG7bxAmHR03dE5ypwnBjdXBi3vTwX+yzLVg2LxPDHgH227oxlMJMN
	 cZPskaF4PU13zeMQ2EhZRuqhz2JmizkpdicsdqdAaDqpA4693gP6LlDxBq5rsXfYoD
	 6ii4Q3b+R0yNDly7lPMLIiiYi9bDOvKHyF7XrxtU=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20220607134311eucas1p24e3e919e50396c465049908daf06428f~2WnmZzu9H2455824558eucas1p2j;
	Tue,  7 Jun 2022 13:43:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id ED.AF.10067.FE55F926; Tue,  7
	Jun 2022 14:43:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20220607134311eucas1p1182fc0038fe6137fc0cef23403343f7b~2WnmJFJEp1686916869eucas1p16;
	Tue,  7 Jun 2022 13:43:11 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20220607134311eusmtrp1baaf7b44ecf6959d7caa3c404bb4c3f5~2WnmIg93d0033700337eusmtrp1j;
	Tue,  7 Jun 2022 13:43:11 +0000 (GMT)
X-AuditID: cbfec7f4-dd7ff70000002753-2b-629f55efdecb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id B5.9A.09095.EE55F926; Tue,  7
	Jun 2022 14:43:10 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20220607134310eusmtip25692dcb137e4720e8bb1c14872099fa8~2Wnl6K3dQ0951709517eusmtip2Y;
	Tue,  7 Jun 2022 13:43:10 +0000 (GMT)
Received: from localhost (106.110.32.33) by CAMSVWEXC01.scsc.local
	(2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Tue, 7 Jun 2022 14:43:10 +0100
From: Joel Granados <j.granados@samsung.com>
To: <hch@lst.de>, <kbusch@kernel.org>
CC: <joshi.k@samsung.com>, <linux-nvme@lists.infradead.org>,
	<gost.dev@samsung.com>, <k.jensen@samsung.com>
Subject: [PATCH v2 1/2] nvme-multipath: refactor nvme_mpath_add_disk
Date: Tue, 7 Jun 2022 15:40:54 +0200
Message-ID: <20220607134055.1742162-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607134055.1742162-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.33]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRmVeSWpSXmKPExsWy7djPc7rvQ+cnGbQfELdYufook8WkQ9cY
	LeYve8ruwOyxaVUnm8fmJfUeu282sAUwR3HZpKTmZJalFunbJXBl3H33malgo0TF4pb9bA2M
	z0W6GDk5JARMJNYuWckOYgsJrGCUePijpIuRC8j+wiix6eNhFgjnM6PE7bfPWWE6lp69wQyR
	WM4o8WPBMza4qo1zHkC1bGKUOHl1NxtIC5uAjsT5N3eAWjg4RARUJfa12IKYzAK5Eifm+YBU
	CAu4SHQ9fAp2BouAikTDrW1gnbwCthLtPzuYIBbLS7Rdn84IYnMK2El0XnnDCFEjKHFy5hMW
	EJsZqKZ562xmCFtC4uCLF8wQvYoSW+Z8h3qgVuLBmx6wByQEDnBIvNxyB2qBi8SN3a+hbGGJ
	V8e3sEPYMhKnJ/ewQNjZEjun7IIaWiAx6+RUNpBfJASsJfrO5ECEHSVubf/CDBHmk7jxVhDi
	HD6JSdumQ4V5JTrahCYwqsxC8sAsJA/MQvLAAkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ
	+bmbGIHJ4vS/4192MC5/9VHvECMTB+MhRgkOZiURXv/Jc5OEeFMSK6tSi/Lji0pzUosPMUpz
	sCiJ8yZnbkgUEkhPLEnNTk0tSC2CyTJxcEo1MBl/+tTz4n2L27bmhDSNbVtz6tsu85Wozeqo
	kl3h+W93tKTUsWuLwlIELuvIfKmfXqjUqNrUy9Rf5h/lKGXacWa7+g/vtWI5Yhv9snp4Np0o
	PPWX1UNK9Mqbe3YdfVkdy35zSL7oTZr17tGF75vzTuzbuN+0pcd+2Ztp4RncV/ZY6xjNlFj9
	tbM3YO8Wky3ZxzNZmdi8TrJFCLsyrdj39XHIZpvp85t3lHUoTza4t8Qv8vHpmKq/z9ZEBryu
	elHByvBx0/Z30YoFD9ROPnlzOuircKHdMcZFP8S3zWYsWXOv5vaGKbnhrvHl04r/J/+JaDq0
	prrjwz75uHkFJvPWdG9ddkz/W16kmLe+v+G730osxRmJhlrMRcWJALVlvp+FAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDIsWRmVeSWpSXmKPExsVy+t/xe7rvQucnGTRPt7ZYufook8WkQ9cY
	LeYve8ruwOyxaVUnm8fmJfUeu282sAUwR+nZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
	m8daGZkq6dvZpKTmZJalFunbJehl3H33malgo0TF4pb9bA2Mz0W6GDk5JARMJJaevcHcxcjF
	ISSwlFGif+U9ZoiEjMSnKx/ZIWxhiT/Xutggij4ySty61MkIkhAS2MQoMWVREojNJqAjcf7N
	HaBmDg4RAVWJfS22ICazQK7EiXk+IBXCAi4SXQ+fgo1kEVCRaLi1jQ3E5hWwlWj/2cEEsUpe
	ou36dLDpnAJ2Ep1X3kBtspU4MXkFO0S9oMTJmU9YQGxmoPrmrbOZIWwJiYMvXkCdryixZc53
	Vgi7VmLT6/VMExhFZiFpn4WkfRaS9gWMzKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECo2nb
	sZ+bdzDOe/VR7xAjEwfjIUYJDmYlEV7/yXOThHhTEiurUovy44tKc1KLDzGaAv05kVlKNDkf
	GM95JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MCSVq6V8fKLav
	f3qzyPlh+5Vna/c8Szq0cr1R7vRFC9Skwi5zFcyMj3k59Tq39HYTTUYbdoOpd0W23Jh+7F/7
	F6kkBtPcrSEaO7b97HRetPnqqb83Ao+/+PDuzqI1zVfnRfLfKHQ5urcmIjpGcu+s4w+nqdW4
	+jQaeJwtPa1w8MIaJ+9DbRwC26S2yzYxxum/kRZcWj7NsrrqpYIr/4THZ+NyPSOv3U4+fe2E
	vVfqCcO71ze8nHc3LGbP5Htl+i/0DL/t51F6eOKxi2Hbu5KZ/+bP+1vD5PfamjExeeJbU93m
	hLp3OY/YK3wmtnWmTvtfxvLqmxZ/2MrZ7H9YuMzdZtiJT/gtfVKkIteiIn/9diWW4oxEQy3m
	ouJEAEtjxAIvAwAA
X-CMS-MailID: 20220607134311eucas1p1182fc0038fe6137fc0cef23403343f7b
X-Msg-Generator: CA
X-RootMTR: 20220607134311eucas1p1182fc0038fe6137fc0cef23403343f7b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220607134311eucas1p1182fc0038fe6137fc0cef23403343f7b
References: <20220607134055.1742162-1-j.granados@samsung.com>
	<CGME20220607134311eucas1p1182fc0038fe6137fc0cef23403343f7b@eucas1p1.samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_064324_008659_DE2E0CB4 
X-CRM114-Status: GOOD (  15.42  )
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

Pass anagrpid as second argument. This is prep patch that allows reusing
this function for supporting unknown command sets.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/core.c      | 2 +-
 drivers/nvme/host/multipath.c | 7 ++++---
 drivers/nvme/host/nvme.h      | 5 ++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 24165daee3c8..06b9718b0540 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4027,7 +4027,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
 
-	nvme_mpath_add_disk(ns, id);
+	nvme_mpath_add_disk(ns, id->anagrpid);
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
 	kfree(id);
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d3e2440d8abb..6ae7c042b1dc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2017-2018 Christoph Hellwig.
  */
 
+#include "linux/types.h"
 #include <linux/backing-dev.h>
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
@@ -800,16 +801,16 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 	return -ENXIO; /* just break out of the loop */
 }
 
-void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
+void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 {
 	if (nvme_ctrl_use_ana(ns->ctrl)) {
 		struct nvme_ana_group_desc desc = {
-			.grpid = id->anagrpid,
+			.grpid = anagrpid,
 			.state = 0,
 		};
 
 		mutex_lock(&ns->ctrl->ana_lock);
-		ns->ana_grpid = le32_to_cpu(id->anagrpid);
+		ns->ana_grpid = le32_to_cpu(anagrpid);
 		nvme_parse_ana_log(ns->ctrl, &desc, nvme_lookup_ana_group_desc);
 		mutex_unlock(&ns->ctrl->ana_lock);
 		if (desc.state) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9b72b6ecf33c..14b097dfa7fa 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -808,7 +808,7 @@ void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys);
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
-void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
+void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
 void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl);
@@ -850,8 +850,7 @@ static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
 {
 	return 0;
 }
-static inline void nvme_mpath_add_disk(struct nvme_ns *ns,
-		struct nvme_id_ns *id)
+static inline void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 {
 }
 static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
-- 
2.30.2



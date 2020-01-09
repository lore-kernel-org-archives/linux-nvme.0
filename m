Return-Path: <SRS0=Ii44=26=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F47C32771
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 05:03:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15019206ED
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2020 05:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LkQ3mhP9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hYYStyJC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15019206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xBLNJLIjRWpvJ1/NExZ/woMFfo9VfCL/awof7eUoGxI=; b=LkQ3mhP9LKMGuo
	mo4VSb2iXGH+km260efVvObIS9a8GccFlIFRcdkJg+IM5MJz5CLNeffyGWh86RbheNwxdgsCu0nZR
	Zj2BP2s6+cLVvs/LozAcGdEFOHPv48jOTFCnbxA/adVn277l7GYVvuh5EaIaoXbazS9fM7D6ceD2s
	bDpyfBcyQRGiut5PHtvycOSehUjSF/EM4hjT8TVMHIy1paJJmuxcWQ6nvYHzCIdkFgYmtbw2zh/Ts
	TwePHTDUZY+Lcas1x0XwN8jVbkIokNBOAOjBeF24/kVKt1eU79ldAB/IRKreDkL73ZnOgo9MRQ6BW
	Hyg/oV2W3RFvVxj4dUXg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ipPyB-0003OM-Nl; Thu, 09 Jan 2020 05:02:55 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ipPy4-0003K7-9s
 for linux-nvme@lists.infradead.org; Thu, 09 Jan 2020 05:02:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1578546167; x=1610082167;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=EmAOoMMpyiMA4wA1AKaTR3eqkweHnZjLyncTJbcowGc=;
 b=hYYStyJCWo3ecMgJ4abhhmfx89xX4H/Kj1bN6hmIZjnN76E9HiS5VeUE
 abUIRpR/tvzGpZT0cSaMMVTH+DP0QnW7fq6gzXpLi8iOEUzDSbLfWbLja
 DK8QXqEFgvmo5tZSm0o0Hhguc79Hr1eRq/bxqxazIZxwA6y/87HTvgDd8
 oZ3Vh2P0imcsAnqEM1TAzUTHcI20qNA30RZPvG71QIMCzKBJ4MP5YOTem
 Kmj0m4TInY/2ZwUQzoSCCH7N6jeTmH4mUoAlCuTMg+7/ojaMhMIgnbayD
 G9jh9WPclD3vIa04XNIcC1GLPcN0QjfQsy6P+zYEHIO/jTW4S2KPX54Tv g==;
IronPort-SDR: BBKxuTMHmP/vgy36ptMIGJyb5ZS4SAs+LAn53wEY5Z22e94omhrk+o/gc+tfE2u4ikv6hQVFIF
 9zAzA2nQejjFxEhtb0OpEe404b+a428PazDHWoy8Ihg9Qj4YGSDSMbMRcOFI/Kg6Kv5ZQwOW/S
 X0EPYogehR3lFn4xcyqvVC+wQAGSYBc6lVntRtrUO+WOtIpjOENCB5GJtitgDsKWchMRCK753z
 L1KiJm/SjuDLrNfCdj/DyPmf/PiMq2aWOUg47u89xCKarlErr6zEUieplWVeE9xcnFNQ4UCbr0
 WLk=
X-IronPort-AV: E=Sophos;i="5.69,412,1571673600"; d="scan'208";a="127021379"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2020 13:02:46 +0800
IronPort-SDR: cXA3J2nz9ZUuB+QCpzFE3anXBK1neB2k0TTzuE+7kwBF/WutWjJkyaG2LdE5JLgr1gqr5Z/033
 RdUjzsOX9Nwq879uHXIJyaR7OSZYoeeTpL+6906LQW89CtfuEmAiU/U2XM400zRNWGjGzgzR8w
 lNpxnVCgXQgfrbnhrvvwvnCY8u1lPZ5h6taQVAwvYghi4dG8LIT2x+iLUbi33SoGK9TSyvI5M7
 NqoptMNOP55hvxj3lS9eK/hzFBZ0TxdPq63nRj+6PK4hLnH6BqH0VwsLmkq24HQ5VKhtAjNXjn
 lCl8UA/yPgog+WBERT3fMFpD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jan 2020 20:56:33 -0800
IronPort-SDR: T7sEZtzqC19rL9w4wmvKwdJTp79gP33oWFNOSXmDMpfvFUTCJOTjKLAMtpsYNEIre2tbxGu6/1
 XsMHNhOMmVzT1RHlMaReUJcwSUY0wYsSAseMS+bNQuXE5HlPkJIdMBuQ5zQZHk/jP6Q9vKi3sY
 l0pz0BoBUR/9UhvMIdxUy9JmXwy50/D/hwS+pq8gg+i47OXc2MQ6YdAoo0OqZJ1etIUOpiMYJa
 tHcqnCNCq+OWys8HH9wqT8k8P0/1LwptVEBBliUcLBkM4QaDtpDiySmHk30IXf+zi1+SKuQQLi
 /wg=
WDCIronportException: Internal
Received: from iouring.labspan.wdc.com (HELO iouring.sc.wdc.com)
 ([10.6.138.107])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Jan 2020 21:02:47 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V4 1/4] nvmet: make ctrl-id configurable
Date: Wed,  8 Jan 2020 21:02:41 -0800
Message-Id: <20200109050244.5493-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200109050244.5493-1-chaitanya.kulkarni@wdc.com>
References: <20200109050244.5493-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200108_210248_428144_46100DC2 
X-CRM114-Status: GOOD (  15.83  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
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
Changes from V3:-

1. Remove error message in nvmet_subsys_attr_attr_cntlid_[min|max]().
2. Remove the return variable and simplify tail of the functions.

Changes from V2:-

1. Reduce the size of the lock for sscanf for cntlid_min and cntlid_max.
2. Remove the common show and store function for cntlid.
3. Move cntlid_min and cntlid_max check into the store function. 
4. Update the patch description.
5. Move check for valid cntlid_[min|max] parameter into configfs
   respective store function.

Changes from V1:-

1. Add cntlid max and min configfs attributes.
2. Use simple if .. else statements instead of ternary operators.
---
 drivers/nvme/target/configfs.c | 62 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c     |  8 +++--
 drivers/nvme/target/nvmet.h    |  2 ++
 3 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 98613a45bd3b..c62f8b8b3d53 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -862,10 +862,72 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
 
+static ssize_t nvmet_subsys_attr_cntlid_min_show(struct config_item *item,
+						 char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->cntlid_min);
+}
+
+static ssize_t nvmet_subsys_attr_cntlid_min_store(struct config_item *item,
+						  const char *page, size_t cnt)
+{
+	u16 cntlid_min;
+
+	if (sscanf(page, "%hu\n", &cntlid_min) != 1)
+		return -EINVAL;
+
+	if (cntlid_min == 0)
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	if (cntlid_min >= to_subsys(item)->cntlid_max)
+		goto out_unlock;
+	to_subsys(item)->cntlid_min = cntlid_min;
+	up_write(&nvmet_config_sem);
+	return cnt;
+
+out_unlock:
+	up_write(&nvmet_config_sem);
+	return -EINVAL;
+}
+CONFIGFS_ATTR(nvmet_subsys_, attr_cntlid_min);
+
+static ssize_t nvmet_subsys_attr_cntlid_max_show(struct config_item *item,
+						 char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->cntlid_max);
+}
+
+static ssize_t nvmet_subsys_attr_cntlid_max_store(struct config_item *item,
+						  const char *page, size_t cnt)
+{
+	u16 cntlid_max;
+
+	if (sscanf(page, "%hu\n", &cntlid_max) != 1)
+		return -EINVAL;
+
+	if (cntlid_max == 0)
+		return -EINVAL;
+
+	down_write(&nvmet_config_sem);
+	if (cntlid_max <= to_subsys(item)->cntlid_min)
+		goto out_unlock;
+	to_subsys(item)->cntlid_max = cntlid_max;
+	up_write(&nvmet_config_sem);
+	return cnt;
+
+out_unlock:
+	up_write(&nvmet_config_sem);
+	return -EINVAL;
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
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

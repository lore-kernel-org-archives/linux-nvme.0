Return-Path: <SRS0=MLi/=DB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83830C4346E
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 23:51:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5AF0221E2
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2020 23:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F71K5UeG";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QcPrPvgk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AF0221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RkmvxFRrrXH/tksVRvfY2KhpzNtVQAmP3T+i2qhCWes=; b=F71K5UeG/o8A6kwc2J6fUHaDB
	cX8I6AFbTNF8xOntTFzXUAM8LqlRbfMuVIE3mMRoPFWaoQrlka1+ITSwEGE4p6flJQR4FgGztqf2L
	UUtesQyclJ/3GUBzqxLqK/H54nfK/X3S8bD20IeGvnKzpiHDacFylw02jdOVjdwioU5CjykgNzMMk
	bDAzsN2shFdr14zl2RV9iqN9Yd3of8VPPp7yCLBhr++2kJnPdHTBVy8h5NeFdxxlR9h4+0oCtNGxB
	fmvggAlkCX8Z08CW9xMBwgEly1oVD4HfzQ3aI6C4wfjBOOUH/ISmansXQPrHv1odW4jvzeXfCqNaC
	t1jdY1chg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLb1h-0005MB-03; Thu, 24 Sep 2020 23:51:49 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLb1e-0005Le-Ps
 for linux-nvme@lists.infradead.org; Thu, 24 Sep 2020 23:51:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1600991506; x=1632527506;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VDibeE1WGTpvawfFwA/xOTsiWJ4mdWYDPmLY8lneArA=;
 b=QcPrPvgkKrip7ufEM/GAzXImogS5HQn16KHB/tlq9z9UzDMAGhWNkSbh
 ge/q2dZ4xcud9vqoWyHcayUm3Jenx1GUDL6Zj+qQgrJNTMdAxV2c0d3Cd
 J07T+k7Vu2wOcWA/G2hA2Ql+zO//tY2szf+A+ubrrAYWrhnSQ+JxCi7zW
 4rPmqUVBG5O1BUln6ZANM7efj+WqAx4+SbWczg199cuFiFWxjMjNnLVPp
 KsEf2QNB24+KddV676yDkpBVZDMr2bIg3CaSa85CYcyGEA4mtWC+RmLYK
 4NsL2+pZV5/de/sdkeAHdxi3PRcs2ayiSnGqZdRRz52stIEK98GbmW0VW w==;
IronPort-SDR: qcF8WmjbiPzsCkt5mQ/CFz7yeiY7E8JhzK3FXAIE/USH3zPUhQSceOC4sOujU7pun6Qb01IIxq
 0s0tB9Xvgj9jMbN4TYRKgpF/G2/GWmtXn1tWlsZMbj1sTocIf2JRG2aHCIaKNcAftMb6XMCSvw
 +NLWI4B3kvfGzudMkhWnmvXiLohfOmHbh3TtmJo+FSBIG4arwMx/WRpWQJzpyJjsokf83FQDp+
 upVhEj5kWBx6RryVZz7BvR5Mde8jDsJKCleDcnqgDbEmdVhnLwjnvcYEwP4mVrCMQbvgoVdYVh
 Rf4=
X-IronPort-AV: E=Sophos;i="5.77,299,1596470400"; d="scan'208";a="152592586"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Sep 2020 07:51:45 +0800
IronPort-SDR: /oxbTdFvWRXA62GQPnS+xNN8VklXgGjcfMQTDroQ2jmY9KQj9eVAoqIZ+2VzzuJQTxegtyNtWl
 tdp0Ip5Q3ksg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Sep 2020 16:38:44 -0700
IronPort-SDR: YD1vWm3gn2HvldbE0duUg3xuHroFA7i1XH70SWnxtmDFI3qjZrLeBvmqrLvX5yO0ZAVI5ygM9j
 y/OkX3rPU8BA==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 24 Sep 2020 16:51:45 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-loop: use xarray for loop port tracking
Date: Thu, 24 Sep 2020 16:51:30 -0700
Message-Id: <20200924235130.50565-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200924235130.50565-1-chaitanya.kulkarni@wdc.com>
References: <20200924235130.50565-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200924_195146_978190_A44E7EAF 
X-CRM114-Status: GOOD (  16.55  )
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

For nvme-loop ports are tracked with nvme_loop_ports_list. This requires
an extra locking just for list operations.

The Xarray data structure provides a clear API which handles locking
implicitly so we can get rid of the locking and the list loop(s) if any.

Replace nvme loop ports list and its lock nvme_loop_ports_mutex with
nvme_loop_ports XArray.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/loop.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 1d8e5c4fd293..81c40011255f 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -54,9 +54,7 @@ struct nvme_loop_queue {
 	unsigned long		flags;
 };
 
-static LIST_HEAD(nvme_loop_ports);
-static DEFINE_MUTEX(nvme_loop_ports_mutex);
-
+static DEFINE_XARRAY(nvme_loop_ports);
 static DEFINE_XARRAY(nvme_loop_ctrls);
 
 static void nvme_loop_queue_response(struct nvmet_req *nvme_req);
@@ -539,19 +537,18 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 
 static struct nvmet_port *nvme_loop_find_port(struct nvme_ctrl *ctrl)
 {
-	struct nvmet_port *p, *found = NULL;
+	struct nvmet_port *p;
+	unsigned long idx;
 
-	mutex_lock(&nvme_loop_ports_mutex);
-	list_for_each_entry(p, &nvme_loop_ports, entry) {
+	rcu_read_lock();
+	xa_for_each(&nvme_loop_ports, idx, p) {
 		/* if no transport address is specified use the first port */
-		if ((ctrl->opts->mask & NVMF_OPT_TRADDR) &&
-		    strcmp(ctrl->opts->traddr, p->disc_addr.traddr))
-			continue;
-		found = p;
-		break;
+		if (!((ctrl->opts->mask & NVMF_OPT_TRADDR) &&
+		    strcmp(ctrl->opts->traddr, p->disc_addr.traddr)))
+			break;
 	}
-	mutex_unlock(&nvme_loop_ports_mutex);
-	return found;
+	rcu_read_unlock();
+	return p;
 }
 
 static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
@@ -639,18 +636,14 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 
 static int nvme_loop_add_port(struct nvmet_port *port)
 {
-	mutex_lock(&nvme_loop_ports_mutex);
-	list_add_tail(&port->entry, &nvme_loop_ports);
-	mutex_unlock(&nvme_loop_ports_mutex);
-	return 0;
+	return xa_insert(&nvme_loop_ports, port->disc_addr.portid,
+			 port, GFP_KERNEL);
 }
 
 static void nvme_loop_remove_port(struct nvmet_port *port)
 {
-	mutex_lock(&nvme_loop_ports_mutex);
-	list_del_init(&port->entry);
-	mutex_unlock(&nvme_loop_ports_mutex);
 
+	xa_erase(&nvme_loop_ports, port->disc_addr.portid);
 	/*
 	 * Ensure any ctrls that are in the process of being
 	 * deleted are in fact deleted before we return
@@ -688,6 +681,7 @@ static int __init nvme_loop_init_module(void)
 	if (ret)
 		nvmet_unregister_transport(&nvme_loop_ops);
 
+	xa_init(&nvme_loop_ports);
 	xa_init(&nvme_loop_ctrls);
 
 	return ret;
@@ -705,6 +699,7 @@ static void __exit nvme_loop_cleanup_module(void)
 		nvme_delete_ctrl(&ctrl->ctrl);
 
 	xa_destroy(&nvme_loop_ctrls);
+	xa_destroy(&nvme_loop_ports);
 
 	flush_workqueue(nvme_delete_wq);
 }
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

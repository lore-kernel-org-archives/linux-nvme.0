Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 297DFC2D0A8
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 04:56:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83B2F20791
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 04:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pWqx85t+";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eVvow3Wc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83B2F20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GHWQfS+EsOvKDiGRhoGjFwJ5lDUgbJSLOeERMns/DF0=; b=pWqx85t+NkrKBWZmNqmErU3Pj
	Fd0TbAszBUKxCtqESILfGFvbgc7DgXdYrDPiUVPTEiBp3Nx666U41pcQna/Z4NbJWjUFJ9xizkvaW
	wmBU4AcXsKzxQQVjpcH1cvzt5VVtnt7iDllT1D/+NpbPWDVqbhrVzc1Pn7LJBhOsaDedus5WwqvKY
	Jn4uVE3E6Y3dZFQg1ziicrp5Hdoli7WFaE61fx2SWP67rtpFdumpS4cWqegqTQwx7My4SgfuviDkR
	7BsTB2xHyB4XI4VPf/2uwWw8a8iZnT79W334p3gHmKDryaPFJy0iWz4MNEnjh56GmYQbO167u1hb9
	dk+KIFvJA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNUA6-0005tR-BM; Wed, 30 Sep 2020 04:56:18 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNUA4-0005sc-1S
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 04:56:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1601441776; x=1632977776;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HfwpVfLOar7dagwjQX/JGSoquG218RiIM9P1uFmXMKk=;
 b=eVvow3WchUGjcSGmuFn+lAoWIs5vyuvsGTFK8tZ4WXC/uZFR6OZZZ/fv
 nZXxiiVgV5p033qupBcqEOSXTsFQND2sPwOezsS9YMlle2xy82MgpEyjr
 lcWmruePAwsY+HPHnPNGXA0EDU5Pi4K7M3ESWuaH6jZxOS25qB3luAAiw
 wnjtK/Z4cNlIxIHtX4US2HG/gUtDo4zsfhbJyXctfslK/MY+9CX4WZbhr
 van2AnokbjPtRXB898NQjjbiH9WoNxQUMnHeZKWkC4U2g/FzuuHtJWOi4
 J8cVfjH+l/nvFaBCiWievcWN5e1vMvzaEEqhLZ/xw08NWOqqL6Z3cxSgP w==;
IronPort-SDR: mLKQHze9ReIC9l4nmRyaFO0uCyUl+wuEu0Eqcn8irrlgEeDYHYzhLdsd8IqlJkqXJ9KfWwZGbW
 ehhxQqcinKcSpaOuSr8joEdvmyyW7AWljs1SIZQV40KXEbQ5zHNJjNC54Xe6IcjxOIWWZRaEN+
 PJfMg0reZKS40hoNIB4Ybrx8+M+4soWwP80b8cTkeSBaUxOYH/q6JwEfgnmP3SK+jLHNFcHERx
 325JayVX2F4SUhUO217hrprJUt4IEFPOXoPzTZOMsZWh7NkUVCN3rSSu60BiKMYXIfVWAbFEhR
 BQ4=
X-IronPort-AV: E=Sophos;i="5.77,321,1596470400"; d="scan'208";a="149843232"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2020 12:56:15 +0800
IronPort-SDR: grINF8V7ghnvgxVgYp4oURoEAVKLd7h2fR2Pm4bgaerjU/qyxscIPoAfY7KUznrHUiLyKdOB2Q
 jIanmPhb+c1w==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2020 21:43:08 -0700
IronPort-SDR: gW/nhgntjQmXowpALtw7fUtPQ2UZ1U2gyZI2KOFqrucGuz0/5wKe77tD7BjwS+q82rYPX8gQTH
 mN5Y3D63tfvw==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 29 Sep 2020 21:56:15 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 2/2] nvme-loop: use xarray for loop port tracking
Date: Tue, 29 Sep 2020 21:55:57 -0700
Message-Id: <20200930045557.53669-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20200930045557.53669-1-chaitanya.kulkarni@wdc.com>
References: <20200930045557.53669-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_005616_216661_F68F3A77 
X-CRM114-Status: GOOD (  16.32  )
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
 drivers/nvme/target/loop.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 2f2e16fb9f29..873afe0654e9 100644
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
@@ -540,9 +538,10 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 static struct nvmet_port *nvme_loop_find_port(struct nvme_ctrl *ctrl)
 {
 	struct nvmet_port *p, *found = NULL;
+	unsigned long idx;
 
-	mutex_lock(&nvme_loop_ports_mutex);
-	list_for_each_entry(p, &nvme_loop_ports, entry) {
+	rcu_read_lock();
+	xa_for_each(&nvme_loop_ports, idx, p) {
 		/* if no transport address is specified use the first port */
 		if ((ctrl->opts->mask & NVMF_OPT_TRADDR) &&
 		    strcmp(ctrl->opts->traddr, p->disc_addr.traddr))
@@ -550,7 +549,7 @@ static struct nvmet_port *nvme_loop_find_port(struct nvme_ctrl *ctrl)
 		found = p;
 		break;
 	}
-	mutex_unlock(&nvme_loop_ports_mutex);
+	rcu_read_unlock();
 	return found;
 }
 
@@ -639,17 +638,13 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 
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
@@ -689,6 +684,7 @@ static int __init nvme_loop_init_module(void)
 		nvmet_unregister_transport(&nvme_loop_ops);
 
 	xa_init(&nvme_loop_ctrls);
+	xa_init(&nvme_loop_ports);
 
 	return ret;
 }
@@ -704,6 +700,7 @@ static void __exit nvme_loop_cleanup_module(void)
 	xa_for_each(&nvme_loop_ctrls, idx, ctrl)
 		nvme_delete_ctrl(&ctrl->ctrl);
 
+	xa_destroy(&nvme_loop_ports);
 	xa_destroy(&nvme_loop_ctrls);
 
 	flush_workqueue(nvme_delete_wq);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=ZUg+=YX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09D6CA9EC7
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 22:27:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BE0F2067D
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2019 22:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tki9pFL3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BE0F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MWkwsAQAsJFUUIHEFMNhrUPQxxfP2e06uCicJIxUPRg=; b=Tki9pFL3E/lyY6
	ejXfN3IGhJJxYOgOXRYWtBY+ltNmQ6I0e8KZYxnVO0bQmcnvLvvKzf3naKrlRPs3lxnU6DfLCaV0d
	vRXTIG+LWQocUuKWFdV8cmr3UA36iqxHOTY1R5NXdcGDXisAevSTATtWiN+0yDGlbg9dyW7X6M8CY
	tgWB8LyXtaor5Gn01OKqtaKHECXumF8y9dNq10nFYIaOWs4icFlvX5BLMmf/mCvSPjyepplVHpFNT
	bLT6SMeDk7USlIhk8Oo+HHxUEQTBT7GgTQBRrwXk6otTiPJoP+jwUStPEpqng0j8TRTTnboBPOiN5
	xxvQBGe2znCebmkGliSw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iPwQx-0002iR-Rp; Wed, 30 Oct 2019 22:27:20 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iPwQq-0002aY-Oe
 for linux-nvme@lists.infradead.org; Wed, 30 Oct 2019 22:27:14 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Oct 2019 15:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,248,1569308400"; d="scan'208";a="401664054"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
 by fmsmga006.fm.intel.com with ESMTP; 30 Oct 2019 15:27:12 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 30 Oct 2019 15:27:11 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.167]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.128]) with mapi id 14.03.0439.000;
 Wed, 30 Oct 2019 15:27:11 -0700
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH] 2/2] nvmet-tcp: set SO_PRIORITY for accepted sockets
Thread-Topic: [PATCH] 2/2] nvmet-tcp: set SO_PRIORITY for accepted sockets
Thread-Index: AdWPcIWvzHpFj0a7RH6PLL2mIs1EQA==
Date: Wed, 30 Oct 2019 22:27:11 +0000
Message-ID: <B33B37937B7F3D4CB878107E305D4916D4AFCC@ORSMSX104.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNzliYmFiNzQtMDk3MS00NDcwLWE5MjQtZTA1OGViN2Y4NDdiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYnVFQTNxT0syME9xOXhURWt0RFdtcHlIbnBYXC91M2M0U3hkajR1Kzhrb0RnUUI3ajFkaWNSbThuN0N6XC83NVFqIn0=
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191030_152712_833873_A3CA9A4D 
X-CRM114-Status: GOOD (  12.70  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Enable ability to associate all sockets related to NVMf TCP
traffic to a priority group that will perform optimized
network processing for this traffic class. Maintain initial
default behavior of using priority of zero.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 drivers/nvme/target/tcp.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4f79b77..4879194 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -20,6 +20,16 @@
 
 #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
 
+/* Define the socket priority to use for connections were it is desirable
+ * that the NIC consider performing optimized packet processing or filtering.
+ * A non-zero value being sufficient to indicate general consideration of any
+ * possible optimization.  Making it a module param allows for alternative
+ * values that may be unique for some NIC implementations.
+ */
+static int so_priority;
+module_param(so_priority, int, 0644);
+MODULE_PARM_DESC(so_priority, "nvmet tcp socket optimize priority");
+
 #define NVMET_TCP_RECV_BUDGET		8
 #define NVMET_TCP_SEND_BUDGET		8
 
@@ -1451,6 +1461,13 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	if (ret)
 		return ret;
 
+	ret = kernel_setsockopt(sock, SOL_SOCKET, SO_PRIORITY,
+			(char *)&so_priority, sizeof(so_priority));
+	if (ret) {
+		pr_err("failed to set SO_PRIORITY sock opt %d\n", ret);
+		return ret;
+	}
+
 	/* Set socket type of service */
 	if (inet->rcv_tos > 0) {
 		int tos = inet->rcv_tos;
@@ -1640,6 +1657,13 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		goto err_sock;
 	}
 
+	ret = kernel_setsockopt(port->sock, SOL_SOCKET, SO_PRIORITY,
+			(char *)&so_priority, sizeof(so_priority));
+	if (ret) {
+		pr_err("failed to set SO_PRIORITY sock opt %d\n", ret);
+		goto err_sock;
+	}
+
 	ret = kernel_bind(port->sock, (struct sockaddr *)&port->addr,
 			sizeof(port->addr));
 	if (ret) {


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=cpn7=XT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DB4C432C1
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 16:06:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56AD20673
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2019 16:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hw4SdRSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56AD20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cFBQ9U/gESIpbVP1Qxt15KVQAyTruURcz1O9HmeG6Zs=; b=Hw4SdRSEvK7iAM
	h8XUI8uwQTbJfFf+kr5oBQq8kEA5C74gh/eLVVpNO+qF9hrdMd4w42JlyJWOCs90Hft3KGn9L9aZQ
	Qbj5H0Uy2BD2T9R3CSf9OZJgRnJCC2pQNMCqlRDTfWfw1ptjhNUPBEc9KKjgqBO0wmq+R2J0x/SPn
	YVOCFvDI+L3FOmEFnYEGmx1ltNrrd0pyWGb41eLCXkbpUq81cQfXWeeum5CDZ+dC/hTYnbh6B8d9r
	jf+5jdNE1DHq4pg+vPrHMwtzUL4DaJ6vLdOMISgbANtRvPLHjaFpdta4A6TeuN3hkSBuSmfdpt24C
	UfEcVjXyPcxCDDoW/KNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iCnKu-0007ai-Rc; Tue, 24 Sep 2019 16:06:44 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iCnKa-00077H-EP
 for linux-nvme@lists.infradead.org; Tue, 24 Sep 2019 16:06:27 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Sep 2019 09:06:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,544,1559545200"; d="scan'208";a="179527643"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
 by orsmga007.jf.intel.com with ESMTP; 24 Sep 2019 09:06:22 -0700
Received: from orsmsx125.amr.corp.intel.com (10.22.240.125) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 24 Sep 2019 09:06:22 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.204]) by
 ORSMSX125.amr.corp.intel.com ([169.254.3.216]) with mapi id 14.03.0439.000;
 Tue, 24 Sep 2019 09:06:21 -0700
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH rfc 2/2] nvmet-tcp: set SO_PRIORITY for network sockets
Thread-Topic: [PATCH rfc 2/2] nvmet-tcp: set SO_PRIORITY for network sockets
Thread-Index: AdVy7olN4qiL2uIRQnu3j96e/6QAkQ==
Date: Tue, 24 Sep 2019 16:06:21 +0000
Message-ID: <B33B37937B7F3D4CB878107E305D4916D36846@ORSMSX104.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjQwY2I4NTUtYzc2Mi00OTEyLWIyNzktNjdhNzg1YTI2YTZmIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicURoWkFwVWZqTmNkNm5HajBlXC9pUm54Znh4bXQ2bUhYYzVQMldZK1MwRDJJaVBNd0FcL3BXbjJwc21WdGQ2OWkzIn0=
x-originating-ip: [10.22.254.139]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190924_090624_545034_49CEE9A9 
X-CRM114-Status: GOOD (  12.90  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>
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
 drivers/nvme/target/tcp.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a232ef5..10c8722 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -19,6 +19,16 @@
 
 #define NVMET_TCP_DEF_INLINE_DATA_SIZE	(4 * PAGE_SIZE)
 
+/* Define the socket priority to use for connections were it is desirable
+ * that the NIC consider performing optimized packet processing or filtering.
+ * A non-zero value being sufficient to indicate general consideration of any
+ * possible optimization.  Making it a module param allows for alternative
+ * values that may be unique for some NIC implementations.
+ */
+static int nvmet_tcp_so_priority;
+module_param(nvmet_tcp_so_priority, int, 0644);
+MODULE_PARM_DESC(nvmet_tcp_so_priority, "nvmet tcp socket optimize priority");
+
 #define NVMET_TCP_RECV_BUDGET		8
 #define NVMET_TCP_SEND_BUDGET		8
 #define NVMET_TCP_IO_WORK_BUDGET	64
@@ -1461,6 +1471,12 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	if (ret)
 		return ret;
 
+	ret = kernel_setsockopt(sock, SOL_SOCKET, SO_PRIORITY,
+			(char *)&nvmet_tcp_so_priority,
+			sizeof(nvmet_tcp_so_priority));
+	if (ret)
+		return ret;
+
 	/* Set socket type of service */
 	if (inet->rcv_tos > 0) {
 		int tos = inet->rcv_tos;
@@ -1650,6 +1666,15 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		goto err_sock;
 	}
 
+	ret = kernel_setsockopt(port->sock, SOL_SOCKET, SO_PRIORITY,
+			(char *)&nvmet_tcp_so_priority,
+			sizeof(nvmet_tcp_so_priority));
+	if (ret) {
+		pr_err("failed to set listen socket SO_PRIORITY, ret %d\n",
+			ret);
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

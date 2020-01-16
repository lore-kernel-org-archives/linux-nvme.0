Return-Path: <SRS0=1/6V=3F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B69C33CB3
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 00:46:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71B4222C3
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 00:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pSGVeHvw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="jqXGJptx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71B4222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=RWAVoQ82m8tTIJvf9RlUNFepiRvcJ8dmXzJemivinXs=; b=pSGVeHvw6mlelT
	seMs0/uHFeomI2hHk0nglB4bLW1OlGe7FHFuuKt25NT+j2X8xq3cNPNeGLzojAOTj3woh3swhihQS
	wv4dFGiKAjCiIbITaIi2HnYg4OsiMdE2Bp24Ou7y7qkmX0DA/NrZRtU6Jqo7o17fpEHxlPm9eLKwX
	kxm+REkM5ZwPYQuVqLHh0ZYVjnoYC3MCObJAsP7ckyGmrNpU+iABh200xM4qU1p6c+UklQHHTzJBC
	hOxj1kkp7keCodoOOKDuo1MdU5oYXf00eYzbOoDEwqmsbFFc6Whd1QBtimpkRc2riHkRzOsxI1mW2
	gWKaGNoAs+ggyW1BX6vg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1irtIk-0006HP-55; Thu, 16 Jan 2020 00:46:22 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1irtIg-0006CN-MO
 for linux-nvme@lists.infradead.org; Thu, 16 Jan 2020 00:46:20 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Jan 2020 16:46:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; d="scan'208";a="398090364"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
 by orsmga005.jf.intel.com with ESMTP; 15 Jan 2020 16:46:18 -0800
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 16:46:18 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX161.amr.corp.intel.com (10.22.240.84) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 16:46:18 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 16:46:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrOIOehbCXHqmQZpUAoJ6QcztllefhGrq6mpPw2J0SJ6QXdz5l2ScJ7ciIMl7p+GDyfL12CY00ckwrrIm1AS8E8dqKRtYC70O/kUndUHWyj9TFwbKTJZVTj59yn+4DR0C6k+p0Bhq9oWz135o4X9chLbIokuB4hdy6YK9lmJWhMuAMtjDZHAESp9b028rM+L7t5RMVdPEZUrBlGTzoShFULDaWcc6vff5QdneAvpmHQhthJInL5lzQeyYdfDoEaYKb+YBsqhYWojzUj4Yj5Ft1ORBnl6Xzl+hTe7ZwLca7EzzV8a3WafePyOnuDRP+tnVaWP0q071PEqI5Gop8Rmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjiKhaEMWO7QoiDSppuYjuqjGdrFVyTPjzNRHCBdKec=;
 b=jFotzovusd1VJePx5d1JvA6fYraZiIF6DalWo01jf/RYBvfnyscoZIKk7OuqhEYjrBgQBl7ixQQozkQx6hLSvHABUCA9QixlWlHtKa8x/VGQuyHz2BvwDXKTPMJw0M+lA/22Tf1ckUP9kv8wFJ8FPcitl+hSKSJ0vFC0JIdjgOq63WVsYiHC7Ck3q2SvMR8EvCupOpvN4nAQ1YNQCJKIk7ozpiO+BCmS0tU0chrehJ2W4Z7O1ylpPQX8oY2mub/jEEhdYqY6JD5mN/6dPph1PCoRjJh0VDbFUDW3e2KYXs3HVF3yoH2DW5ZXPVsjT/o42gK9IPe4pWODuH33zvYXMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjiKhaEMWO7QoiDSppuYjuqjGdrFVyTPjzNRHCBdKec=;
 b=jqXGJptxxnaHJwCqdjkJ9MRTL/Jccnww4Hu76G5r9leVaQgFxiDEF1t/MtBdTZmnE90LhhvhMvONox+dqf7P6FGPFMormJkkpoGIpQC2aI8FwtxfwRUvQCoUR2RjEGV1K1Vq0B5SYFXiL1r8EF3Ru1d/3GZPgqbzQTXZ+7fUCww=
Received: from BYAPR11MB2712.namprd11.prod.outlook.com (52.135.223.141) by
 BYASPR01MB0042.namprd11.prod.outlook.com (52.135.239.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Thu, 16 Jan 2020 00:46:16 +0000
Received: from BYAPR11MB2712.namprd11.prod.outlook.com
 ([fe80::13e:c076:124d:1db9]) by BYAPR11MB2712.namprd11.prod.outlook.com
 ([fe80::13e:c076:124d:1db9%2]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 00:46:16 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH 2/2] nvmet-tcp: set SO_PRIORITY for accepted sockets
Thread-Topic: [PATCH 2/2] nvmet-tcp: set SO_PRIORITY for accepted sockets
Thread-Index: AdXMA+rjTQj5kEkqRym/m8LGFYKKFw==
Date: Thu, 16 Jan 2020 00:46:16 +0000
Message-ID: <BYAPR11MB27127709A9C1D080D7810C5CE5360@BYAPR11MB2712.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [192.55.52.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 920d4081-b969-4628-d161-08d79a1d7ea0
x-ms-traffictypediagnostic: BYASPR01MB0042:
x-microsoft-antispam-prvs: <BYASPR01MB00420157BF35A48A3E7461C2E5360@BYASPR01MB0042.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(376002)(346002)(366004)(39860400002)(199004)(189003)(66556008)(8676002)(81166006)(71200400001)(81156014)(66446008)(8936002)(66476007)(76116006)(5660300002)(86362001)(2906002)(186003)(66946007)(64756008)(33656002)(9686003)(55016002)(6506007)(52536014)(478600001)(6916009)(26005)(316002)(7696005)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYASPR01MB0042;
 H:BYAPR11MB2712.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CS3SGw7qLO81z1+52xFNdLw14GadivbcWddyLC2mcTdhKeSHl2fSeVBNRVlLV4AZ4KI1be3jCuyVV//TUMn5RaVfEaNHgaZ91LSUwGdWfMbcYlDsaf/2+ZsZMQfm9BgG/eDt/9O+olwyp5kAnZiRWuyFRhrfq20gXl+1tLhpEKKg0gwD5r21j1ldw9ZekDf4FfDO1e/QWgbgHriyr/uNGNabAfKY2qs0J5mk/dcNdCDDQY5oWcU9/oe9Xgb1P/W5j6nEMcDS5NFjq5I5VItfat5vDDOKn/X0q6YDNX6SzQeEnjuvJtUJDPd+Z8PB+SreuVvOHopQjdGNMhA+A552Q2JWqBCfIu4Ejsvsn+vSCPd725NVNYoLaoSJm7uNgVg3yoDG0X0eqU9oVfgYxZh1WN96ugEJTRHIN2EZke/3XWaEtuSrLTrd+gC6uAfy2DXc
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 920d4081-b969-4628-d161-08d79a1d7ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 00:46:16.3343 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yQCNV2PvJe4qn+41zYpHJG3sLrDonu4FZBPM7VblHfELmLVl6ZCp/K3qFnEovTQjPpPIe7KySi24nLxJvyNGvVqZIGrwa3DpUD4ZsIBwEfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYASPR01MB0042
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200115_164618_757738_0275E7BA 
X-CRM114-Status: GOOD (  14.20  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvmet-tcp: set SO_PRIORITY for accepted sockets

Enable ability to associate all sockets related to NVMf TCP
traffic to a priority group that will perform optimized
network processing for this traffic class. Maintain initial
default behavior of using priority of zero.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 drivers/nvme/target/tcp.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index af674fc0bb1e..cbff1038bdb3 100644
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
+static int so_priority;
+module_param(so_priority, int, 0644);
+MODULE_PARM_DESC(so_priority, "nvmet tcp socket optimize priority");
+
 #define NVMET_TCP_RECV_BUDGET		8
 #define NVMET_TCP_SEND_BUDGET		8
 #define NVMET_TCP_IO_WORK_BUDGET	64
@@ -1433,6 +1443,13 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	if (ret)
 		return ret;
 
+	if (so_priority > 0) {
+		ret = kernel_setsockopt(sock, SOL_SOCKET, SO_PRIORITY,
+				(char *)&so_priority, sizeof(so_priority));
+		if (ret)
+			return ret;
+	}
+
 	/* Set socket type of service */
 	if (inet->rcv_tos > 0) {
 		int tos = inet->rcv_tos;
@@ -1622,6 +1639,15 @@ static int nvmet_tcp_add_port(struct nvmet_port *nport)
 		goto err_sock;
 	}
 
+	if (so_priority > 0) {
+		ret = kernel_setsockopt(port->sock, SOL_SOCKET, SO_PRIORITY,
+				(char *)&so_priority, sizeof(so_priority));
+		if (ret) {
+			pr_err("failed to set SO_PRIORITY sock opt %d\n", ret);
+			goto err_sock;
+		}
+	}
+
 	ret = kernel_bind(port->sock, (struct sockaddr *)&port->addr,
 			sizeof(port->addr));
 	if (ret) {

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

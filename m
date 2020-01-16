Return-Path: <SRS0=1/6V=3F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE95C32771
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 00:46:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBED5222C3
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2020 00:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kOJEsAfQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="YCAELWX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBED5222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=81LI2S8FDHKOYqOtUbu1vFLzlCLgscPN5ACEwuyCJ6c=; b=kOJEsAfQc8fLnn
	87HBRRicousnaFScjFvvAD0UUlG47QZPnvxhB/Brrt1PkYSrvxPqlgoWzlsyDSJZ4laLA/v+f8YJp
	zdj0IjcbT85gj8pBj6VRmMpL69UKbl5N7JK7KBvdVjwQX/hkrTNST5b+d7/421/HjYs8EFPpOTIe0
	G6sD/BT1ve0iWPHu8c1BPY7ynVvMYsWvvpFSIp+JGC4f2w7RHDwWWHtLIg/p7xjjd8EyY84SX4fVl
	AkrGGDMrqXWC5t+Q9XjrlrLML1p4aFTMscMUoqA61dtY0W3q6gQBYALq2EkeP16c2Qgb9IW6BRufa
	vb3kwbcQbZu9hKLxU8GQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1irtIf-0006Ch-VV; Thu, 16 Jan 2020 00:46:17 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1irtId-0006CN-Ry
 for linux-nvme@lists.infradead.org; Thu, 16 Jan 2020 00:46:17 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 15 Jan 2020 16:46:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; d="scan'208";a="398090353"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
 by orsmga005.jf.intel.com with ESMTP; 15 Jan 2020 16:46:14 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 16:46:14 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Jan 2020 16:46:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7FzVeonJ/rw+M4uRgOnRXeG/KUfU/pN62+KdYpujZ2JAF1HlD0wBmqVHMc6scoX1cCoh8mIrhIRauievd+FvvIbXT8ed6lHovnDabZ3PFCph1sONZNNPkKSEB5iXy99t5gEipgQNJ+/HC7piBFrHM5mSN+6WLdKwOxi1Vnm1cluQCOdLhDkyDlHKK8/uNa2rhg8VyJLH4OL7n2JbDoECV0qX39Y49x/IrEqow2gEve7DvVj7rAXtEz8nJliGe8SuQ3ZJDy8CRNaKptIL75MwYNarZUtyZ3Kzyc3o93sPIhpBo9vdne2t+Q0AbfDWUIlhLvjaQr0+IjIzJPqiIlcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIw6iN/3HUxJAAGPcr9kZADrUEJMQcifst0N91NtaM8=;
 b=SW73+PUQ83SAK/BnfhQmoomxqevkLDc5xv6t8J6+/tCvjqBI6XCgK6j+O/DfHaXqadSwj3TBHwDTuoVwMhrR2YhAxMdTukn7NC6VUWRe6nmr8JESxt/9d9lkkcTCOols6lfgi5za9RrPxBHwWeSKVSXlefue+wAE5egE5ZsURzX7azN5btIOR1UbEmyiISEllTaXRBds6aH3rQ9BLRUNL7wJENs6SlrKqSmR4ZeWR9QMZ2bRstJ1qBOzrp/dERRPzuHgqmlYmfj7gLgrusUJDpiwtU2adg6m7Zsmb9OvRMjVs4s/xW1wwEOf1tqH85tOOQ0wZKoggj9YJazpakwEBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIw6iN/3HUxJAAGPcr9kZADrUEJMQcifst0N91NtaM8=;
 b=YCAELWX0lNowPuBVRkaLqYm/vIJw8mYNHqqlEZh+3UpzURDKZ69UAJ1mgDhN8ugkDqgaosUbh+ZdKIwfcFXfp67AvZqAyrmvDRGrlgBZSGwfj30i0VI9UI1eUPsjv6Itz4ThBSEtnq5VA0/2ZT4WAG99+tDY6y3fAnBhc7TSbfQ=
Received: from BYAPR11MB2712.namprd11.prod.outlook.com (52.135.223.141) by
 BYASPR01MB0042.namprd11.prod.outlook.com (52.135.239.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Thu, 16 Jan 2020 00:46:12 +0000
Received: from BYAPR11MB2712.namprd11.prod.outlook.com
 ([fe80::13e:c076:124d:1db9]) by BYAPR11MB2712.namprd11.prod.outlook.com
 ([fe80::13e:c076:124d:1db9%2]) with mapi id 15.20.2644.015; Thu, 16 Jan 2020
 00:46:12 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH 1/2] nvme-tcp: Set SO_PRIORITY for all host sockets
Thread-Topic: [PATCH 1/2] nvme-tcp: Set SO_PRIORITY for all host sockets
Thread-Index: AdXMBDkCDni9KZdMS6O2d5CVE1ly6A==
Date: Thu, 16 Jan 2020 00:46:12 +0000
Message-ID: <BYAPR11MB2712EF82675196E33E29A422E5360@BYAPR11MB2712.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: be708ac5-7ff6-439a-75c0-08d79a1d7c5f
x-ms-traffictypediagnostic: BYASPR01MB0042:
x-microsoft-antispam-prvs: <BYASPR01MB0042F0EA173A194158408434E5360@BYASPR01MB0042.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(376002)(346002)(366004)(39860400002)(199004)(189003)(66556008)(8676002)(81166006)(71200400001)(81156014)(66446008)(8936002)(66476007)(76116006)(5660300002)(86362001)(2906002)(186003)(66946007)(64756008)(33656002)(9686003)(55016002)(6506007)(52536014)(478600001)(6916009)(26005)(316002)(7696005)(4326008);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYASPR01MB0042;
 H:BYAPR11MB2712.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2G+SE9Oh/U7B+btla1bl2V8tG3L3boa6wfAaZfR1VhYVQO5pi2ltg7dC4PuKwAKdOeYgy/p0Vx7gDQJrg3DjbDSKUDME+0Ax473iL6qSq+qJl6z446LI3phOrKX4BphTybtRx683cVgSfCeFwnQMRqoyeFchPwbCKstcu38ove1DbXuupv4kbomypuINhWe7crC+TfBNeKKxqPyPYV5QFP4jqzV8pq9vQpQJokXbivz7IGeiaKNNxauVq/VwRGpIYIXbr/q46VHxuLhuuGVopOuMx24rMpHpcyYBy9Em2i8Cu0Q1zAgEOFGRvht0og0WBlrdsr9l1niQ/d5xmrFYDtZVacnpJXSAepJ1cnMR0ZyXa5HhhXZW9l+J20yAv3ITXctPsIcqjdmcgoGpnwMCBVF3blAGtW2TJM+O5D4vFcTqF/gcCSmKTHe7sdWcOCH+
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: be708ac5-7ff6-439a-75c0-08d79a1d7c5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 00:46:12.6145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K83oSk5zc31JTIpnHfuLyvJF1V5qsDdxNcLgZVH2YasVaUD964oZ+Ef++xVzPxYn2ksdHijD+n/4pcZpYvAFMBYI059Qya5AnXfxuxoLzSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYASPR01MB0042
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200115_164615_924061_663C0597 
X-CRM114-Status: GOOD (  14.09  )
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

nvme-tcp: Set SO_PRIORITY for all host sockets.

Enable ability to associate all sockets related to NVMf TCP
traffic to a priority group that will perform optimized
network processing for this traffic class. Maintain initial
default behavior of using priority of zero.

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 drivers/nvme/host/tcp.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6d43b23a..2af7e8c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -20,6 +20,16 @@
 
 struct nvme_tcp_queue;
 
+/* Define the socket priority to use for connections were it is desirable
+ * that the NIC consider performing optimized packet processing or filtering.
+ * A non-zero value being sufficient to indicate general consideration of any
+ * possible optimization.  Making it a module param allows for alternative
+ * values that may be unique for some NIC implementations.
+ */
+static int so_priority;
+module_param(so_priority, int, 0644);
+MODULE_PARM_DESC(so_priority, "nvme tcp socket optimize priority");
+
 enum nvme_tcp_send_state {
 	NVME_TCP_SEND_CMD_PDU = 0,
 	NVME_TCP_SEND_H2C_PDU,
@@ -1304,6 +1314,17 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 		goto err_sock;
 	}
 
+	if (so_priority > 0) {
+		ret = kernel_setsockopt(queue->sock, SOL_SOCKET, SO_PRIORITY,
+				(char *)&so_priority, sizeof(so_priority));
+		if (ret) {
+			dev_err(ctrl->ctrl.device,
+				"failed to set SO_PRIORITY sock opt, ret %d\n",
+				ret);
+			goto err_sock;
+		}
+	}
+
 	/* Set socket type of service */
 	if (nctrl->opts->tos >= 0) {
 		opt = nctrl->opts->tos;

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

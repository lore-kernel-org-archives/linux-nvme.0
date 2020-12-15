Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE693C2BB48
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 01:11:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F01620857
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 01:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F01620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IIEYQhMhsvulzPo/8GbDzkIipl8p6Sj/SnO/qD7GYFw=; b=IeTCvhm8VYy6LuSlyCPJKH64L/
	oC56ntHb7yREyUGMDubR5/eLKK6SlIKOMmEspvDfHFynKc7Kq4Pki6T5YR2GFiMrUrBG/eU3IW+yR
	gsmeYzDsQjqDETnfbNyjUgNPyfTEMn4la7t5fomqb0gayXmNQbaVuEYlLUacfyA2Fs9fE93y8i6aV
	ezJTfBg66IlXMxhtzC+kzxaEPFm0x+nmNgGD/RLqpLOUN7sRB3UxoqwHv8vhhx6UCtuJAVv2HuEzB
	pMPousKzyoj7gq1fVHT99kitpCFkqO9Qk7QW0/oHEYkMtIchTZhq1tuSUcHpJSROTl4wEx5GgZvQd
	xxyPPbmQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koys5-0003zq-Te; Tue, 15 Dec 2020 01:11:21 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koys2-0003z9-Mu
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 01:11:20 +0000
IronPort-SDR: unPBF8xf1l35V5Vg8Whvmon7dV427Zgj2QtcbDXGPiUOJ6q9FjazbCV0Ig5gNq7g5uDJlqfZN1
 pYYfxhfawImQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="174951825"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; d="scan'208";a="174951825"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2020 17:11:17 -0800
IronPort-SDR: dzvcZZK/q3a0XZzmxOWgJXtn3aqzngIxBhMcpEW5OK7itufl3EaTKKS/g0rYCzuM2RFvtXbOjl
 ysKXRKDxb78A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; d="scan'208";a="555229086"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmsmga006.fm.intel.com with ESMTP; 14 Dec 2020 17:11:17 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Dec 2020 17:11:16 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Dec 2020 17:11:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 14 Dec 2020 17:11:16 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.58) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 14 Dec 2020 17:11:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3NaEz5UO2BFnOQB6n8Oq36Om8bwI5z3U0WMMRs4SdIG0DH4JIwb77TN8T2O96hqC7vYaV7998qMNz6MpPlbL30MAkNeHmNVdy3I3R9AGg559tvbmD1DJAR9jFL83bvolihd6KaOub5EOC6h6GgXPtll6n+toxiFQySNlDXAik5ZsILL5KNTq7U5ngojSbMLtXchE+HmAnsvYwnOiA4QzmKaLlTqZUt38eDcoOEbye+xsrfdKnDogerIaZeo5AIL+kKji/vqizIatyfhFsokF7d/ykJHdpFNVj77KW2xDL5owqs3lN/cIUAnQpC8PRDL4y/3Jd47mb8HqxrKZa/BRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82OxbVze12YAau2OefSjIEwoIunT8jJtZNvZY8Ncq50=;
 b=grLUxfGCMShx47HPSXyJT+ugR0LjhcrKLXM5Jh212+wfVLIy6lZ25J/30twbgo9KrtyS8AdAchB7AEeC+m8EEt1xDvpLTcoRxmLqZDYotIOC5qJx0OHK8QD1SDM5DvzhmRiulwUdqndIdgY3EPD1mdrg54th5Vq2wNbWC/NTKJYKYvW/lgoFsncxMbmXuGYvuS6K8OL5oIHpLSMgTeGOqPoriWtbSt+18Bdfs93flS2bNoWcxsdxZAy4qpXX/gTaqma9YJit8OEZhR5tqHk9L5ygUveAm8aKPXln/rRCdiiBUdmwytrJJNq8H00KNfkg+aUa+vHXDtgIvXhzxk0BHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=82OxbVze12YAau2OefSjIEwoIunT8jJtZNvZY8Ncq50=;
 b=htt/h7xa0dkkXujSp6JYTwtCC54pKaCwk+HM0vfYYmCnj10Z6QnuwkthLS7SsXsxITZsOCQbgnb+m9cwCjKN/vT2OYU3wbCUX1Wu/wrWRbnVCvIzWbTIq3TvjyG3iPrllqccTfBNSZKSEK+j7k1PdNR60To3EZyK93nM+s+GPqs=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by BYAPR11MB3013.namprd11.prod.outlook.com (2603:10b6:a03:8b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Tue, 15 Dec
 2020 01:11:14 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::b47b:94af:71b8:63c9]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::b47b:94af:71b8:63c9%5]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 01:11:14 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [RFC PATCH 1/2] nvmet-tcp: enable io_work() idle period tracking
Thread-Topic: [RFC PATCH 1/2] nvmet-tcp: enable io_work() idle period tracking
Thread-Index: AdbSe5oDrW4PTNPrSpu0QGgpmHDJkQ==
Date: Tue, 15 Dec 2020 01:11:14 +0000
Message-ID: <BYAPR11MB286903EFBD2022405C860F15E5C60@BYAPR11MB2869.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=intel.com;
x-originating-ip: [71.238.29.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab00fbd4-7e93-4b18-53f7-08d8a09651a9
x-ms-traffictypediagnostic: BYAPR11MB3013:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB301325A8CE2727D9442AC4F3E5C60@BYAPR11MB3013.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /kpErOYrw5zx8b0b9TaKexy5zehd14AKGVfcfxl9e9np/5+SG/ZMO2OlK+jG1/JBYeQz7aGapTuhWr7A5ZYUDV132bENAUKOmrlgGCbtit14oxt/NpvXjF4NRdlWYGPBylXDnjX7bZJvYxQX5bjuiuHFjPaegGPLfBYIDV1+siVbYWbJpfa+cVj9NIgZP4eAQfYo97mvdgyNObL7FK0YcUZeSszE3mtyesXLiGZUopE/0h7cnCBvgALjUmm8y6cbTvllw7VIoIvk3fTldE1Ckgauw0Pu4+Kokb7MJQbxwFXBgkMZykgyzAzDEkVVRAWRrGw7p9xxhFqymiWWd9Vb4A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(83380400001)(186003)(2906002)(6506007)(76116006)(55016002)(33656002)(107886003)(66946007)(64756008)(66476007)(52536014)(7696005)(54906003)(66446008)(5660300002)(26005)(71200400001)(4326008)(508600001)(66556008)(86362001)(8936002)(8676002)(6916009)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?I2Pz7iMYGiMcO/l1qs9Uns7m2uGUW6M7tAhpRUdyYQTRyt9TdHEx0WHAauDH?=
 =?us-ascii?Q?DryvmxkRMK05O04ewunktpSOPTH4o+bsRrZqYBPdfzCBAzHsVHJ1xXdyu7u/?=
 =?us-ascii?Q?8GZFkxElYE65mxjuMCLz47qxTy7PbkkJpuSalugg1hhfuhGIhnqkvq6x3ZUM?=
 =?us-ascii?Q?y/8hS+QkVEuK+xbQ6UYRwaH+coKu06l4hd5TEFVg/cvqeF4lHdRxIiOfMb32?=
 =?us-ascii?Q?opYc0pm6tiu0oKmKK7EWCXWLFVav7ydJ3pb7qmhkjMYxPLF07WKinzIe57Fg?=
 =?us-ascii?Q?swSBS2Wkib5gZQOkRmgISHKNrvR98L44sAfUvvXSAU+XIrQd97svgPoxeLAs?=
 =?us-ascii?Q?oFIwumzozrSd2w7tZVyGg/q8fCeC5qB21swEkAGugcSCAax50Wio6+5R0XjQ?=
 =?us-ascii?Q?DlA46MdwFSvu1DU7/HmuEx7XbFq/INnhvw8+Gc56DdkDlj+f+KA2sirdtoYt?=
 =?us-ascii?Q?7dKGE2hDTihCGrWVBu5xa997GjgzZ9McKSKvv4l3LFs8JM6XA0O/JwwknccG?=
 =?us-ascii?Q?NsSVkro/m0/nJIhFEsdmUxwBBIV5cf7y1/u4W8hXxuWcTT4Nvx6I+c/O/AQP?=
 =?us-ascii?Q?0wF4+bM1OeYL0rlO3y3QjzfpHMRSA5NpDeXoL0mi8Eo8ygrJIY3zW/Tu9N7l?=
 =?us-ascii?Q?tKvSix7one42SgN3jt8p0325b7sdXaBhy2Op7wluAULsX+pB9xxuFFmnS0O+?=
 =?us-ascii?Q?MbK1uZSrlP/wFKzHijhm4hA445uAmv2Di7fe6htmPdkAWWo2GYq/pUzZ+fpm?=
 =?us-ascii?Q?QXds3YHlD+hQ+TVym2PcLe9lWbs+gsOUTkoHIMKbdLyI3d8NERePmexke9VC?=
 =?us-ascii?Q?a/lHQclmVDyWPFVE6XYtW8dB8NVD9yGOoH8kS+Ca0teuIPbYoo1bA4sDMMzN?=
 =?us-ascii?Q?Ss5XJofMciIVAoEyDdkl5AsmMK7QUkDD3hRvS0AaPzU5eDn4S4/8fKyUEwOA?=
 =?us-ascii?Q?eoi3DwQBGo2j685xlDE6zurpo8ZA5CkXBq+ZpWN6K8M=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab00fbd4-7e93-4b18-53f7-08d8a09651a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 01:11:14.6876 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XXRJG9Mz9tDeMisGxz4It4YExISpUJAelCBj/HS51PQ3pKZtF7794g0CKxdVOdGhrHilUtz7qS2k9O5pAiSY8NtL3d3WKqCXWo3qSCYGz5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3013
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201214_201119_415273_C4122E75 
X-CRM114-Status: GOOD (  21.78  )
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
Cc: "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvmet-tcp: enable io_work() idle period tracking

Add 'idle poll period' option to io_work() to support
network devices that perform better in a more polled model.
In this new option a queue is assigned a period of time to
sample for activity before determining it is 'idle'.  Until
the queue is idle the work item is requeued.

Commands other than received asynchronous command requests
are tracked as valid pending activity that counts towards
the queue being not 'idle'.

The pre-existing legacy behavior is preserved when no module option
for idle poll period is specified.

Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 drivers/nvme/target/tcp.c |   91 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc1f0f647189..739d67985d93 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -29,6 +29,16 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvmet tcp socket optimize priority");
 
+/*
+ * Define a time period (in msecs) that io_work() shall poll an activated
+ * queue before determining it to be idle.  This optional module behavior
+ * can enhance results for NIC solutions that support socket optimized
+ * packet processing.
+ */
+static int idle_poll_period;
+module_param(idle_poll_period, int, 0644);
+MODULE_PARM_DESC(idle_poll_period, "nvmet tcp io_work poll till idle time period");
+
 #define NVMET_TCP_RECV_BUDGET		8
 #define NVMET_TCP_SEND_BUDGET		8
 #define NVMET_TCP_IO_WORK_BUDGET	64
@@ -96,10 +106,13 @@ struct nvmet_tcp_queue {
 	struct work_struct	io_work;
 	struct nvmet_cq		nvme_cq;
 	struct nvmet_sq		nvme_sq;
+	unsigned long           idle_poll_period;
 
 	/* send state */
 	struct nvmet_tcp_cmd	*cmds;
 	unsigned int		nr_cmds;
+	unsigned int		pend_cmds;
+	unsigned int		pend_async_cmds;
 	struct list_head	free_list;
 	struct llist_head	resp_list;
 	struct list_head	resp_send_list;
@@ -206,11 +219,13 @@ nvmet_tcp_get_cmd(struct nvmet_tcp_queue *queue)
 	cmd->pdu_recv = 0;
 	cmd->iov = NULL;
 	cmd->flags = 0;
+	queue->pend_cmds++;
 	return cmd;
 }
 
 static inline void nvmet_tcp_put_cmd(struct nvmet_tcp_cmd *cmd)
 {
+	cmd->queue->pend_cmds--;
 	if (unlikely(cmd == &cmd->queue->connect))
 		return;
 
@@ -726,6 +741,10 @@ static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
 {
 	int i, ret = 0;
 
+	/* expect nothing to send if nothing pending */
+	if (!queue->pend_cmds)
+		goto done;
+
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_send_one(queue, i == budget - 1);
 		if (unlikely(ret < 0)) {
@@ -932,6 +951,9 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 		return -ENOMEM;
 	}
 
+	if (queue->idx == 0 && nvme_cmd->common.opcode == nvme_admin_async_event)
+		queue->pend_async_cmds++;
+
 	req = &queue->cmd->req;
 	memcpy(req->cmd, nvme_cmd, sizeof(*nvme_cmd));
 
@@ -1198,12 +1220,50 @@ static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
 	spin_unlock(&queue->state_lock);
 }
 
+static inline bool nvmet_tcp_cmds_pending(struct nvmet_tcp_queue *queue)
+{
+	if (queue->pend_cmds > queue->pend_async_cmds)
+		return true;
+	return false;
+}
+
+/*
+ * This worker function will process all send and recv
+ * packet activity for a queue. It will loop on the queue for up
+ * to a given time, or until there is no activity for a single
+ * iteration.
+ *
+ * Two exit modes are possible.
+ *
+ * The default 'one shot' mode where the worker will re-queue
+ * itself only if any send or recv activity was recorded.
+ *
+ * A special 'extended deadline' mode where in addition to re-queueing
+ * itself because of activity it also determines it has not reached an
+ * assigned 'idle' period of time. The worker consumes from the assigned
+ * time period, across many potential invocations, until it is expired.
+ * A queue with activity always being awarded a fresh time
+ * period for processing.
+ */
 static void nvmet_tcp_io_work(struct work_struct *w)
 {
 	struct nvmet_tcp_queue *queue =
 		container_of(w, struct nvmet_tcp_queue, io_work);
-	bool pending;
+	bool pending, idle_poll_mode = false;
 	int ret, ops = 0;
+	long period_remaining;
+	unsigned long idle_deadline, bp_usec;
+
+	/* Setup use of optional tracking for idle time period */
+	if (idle_poll_period > 0) {
+		bp_usec = idle_poll_period;
+		idle_poll_mode = true;
+
+		/* Assign the queues idle period if no time remaining */
+		if (!queue->idle_poll_period)
+			queue->idle_poll_period = usecs_to_jiffies(bp_usec);
+		idle_deadline = jiffies + queue->idle_poll_period;
+	}
 
 	do {
 		pending = false;
@@ -1220,10 +1280,37 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 		else if (ret < 0)
 			return;
 
+	/*
+	 * When no activity across a loop iteration we assume this queue
+	 * has reached an idle point, so we exit to allow fairness to other waiting
+	 * queues on this cpu.
+	 */
 	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
 
+	/* If special deadline mode active, determine if queue has reached its
+	 * idle process deadline limit.  Remaining deadline is calculated. Any ops
+	 * activity awards the queue a new deadline period.
+	 */
+	if (idle_poll_mode) {
+		/*
+		 * Clear to award active non-idle queue new period, or
+		 * reset for future queue activity after exit when idle reached.
+		 */
+		queue->idle_poll_period = 0;
+		if (ops > 0 || nvmet_tcp_cmds_pending(queue)) {
+			pending = true;
+		} else if (!time_after(jiffies, idle_deadline)) {
+			period_remaining = (long)(idle_deadline - jiffies);
+			if (period_remaining > 0) {
+				pending = true;
+				queue->idle_poll_period = period_remaining;
+			}
+		}
+	}
+
 	/*
-	 * We exahusted our budget, requeue our selves
+	 * We requeue ourself when pending indicates there was activity
+	 * recorded, or queue has not reached optional idle time period.
 	 */
 	if (pending)
 		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

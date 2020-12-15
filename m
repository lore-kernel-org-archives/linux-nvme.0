Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057DBC4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 01:11:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C94F20857
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 01:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C94F20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fi4nYNZ5v9qKvJAc9ceqSXmkEp7xfAwV40M8s7G2gMM=; b=0XFCQpL1W9y7U7LJMRW8Eo2zqF
	MHODi3bshJBudLIwbC+s0PzuHZk4SQUD4th0vDgDFYl6ppcrkyx0caA8+FqZGUcMsqCjWRDLEMsiT
	ZzEwZYYtV/gOLvllBiGsLOH/MAyBKAqm4GqJBjnjfx+HRM9WSSgSTplU2FCTlLhZpQS4KX9//EeOK
	/034Z7DlVddV9/hfD4idMWRoKnBsZ194/jIlJWxCPWbJLWJc+wK4dMixVofIXQA/87HGmdVvbwDLS
	AC2cyUAgg7v5ZXUX3LfefF3RTIJCDsIoYBep/LDwJoJo2MTK1HxLJrIMp0tWUz9AlQwjDYkmfdUkT
	+uz1pNMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koys9-000419-S5; Tue, 15 Dec 2020 01:11:25 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koys7-000401-BN
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 01:11:24 +0000
IronPort-SDR: 8Mu50q/jpfEZVq/H4OeIOScz95TjF3+0kwHdHAUHGk7a/plPRPAp4BePCbnqdDwX0G5wXXBZug
 /DcjAKng1beA==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="171298455"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; d="scan'208";a="171298455"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2020 17:11:21 -0800
IronPort-SDR: taUHyPml01Edcw7XBGHR+NkCt/nm0699Wpuegj/uxd5ab/WoW8lowc77Y7DrxX2D5CjvWdJu75
 guzJ4zTGw87Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; d="scan'208";a="336407623"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga003.jf.intel.com with ESMTP; 14 Dec 2020 17:11:20 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Dec 2020 17:11:18 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 14 Dec 2020 17:11:17 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 14 Dec 2020 17:11:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W54Bazr+DhFQKMuR4X81s5KEQBgHRKFzcKqHcHhmh3lst3D7cBAm5GkPF5g61umXCXW6DcBizi+6B18Vepo5rZQUt7ST0q9Z3ptgu+Wyb6nit9llcHwW6MaEau73zXbYnAO5mnxgpeAWHZD8K6sWlQiS5z5lXkwS7tMqbvPDlMaqTi6Ornvdwu+oXN2hzkUGXM1kyqbpDpvux78K4MBqu/WT4wCRSFqgYT8eNpJOopPLt2wmaZxsTlEa3UC2CE4JzCoTQdgFpx0rDG9XIohcPJC2JDY0Jr8hDQJ8UQR3gfqjGn7gz0R0fTBa46jP9u7dz55De63sfbj92FjOz1zKoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bB9hdUEo5Rliu8QOZDOa/kMf/IzuAkrVVnmKvypyuY=;
 b=CU2vWXUYIiOOoQejySMZfLXbXjHxIeMcxgeeOF6rTKGiGkAtNhQ8rZ+kw9PoxKbRTKNoG1xcPgnjJ/bE3+O8XNrT6HaEZhxl6w2wNt9itupIkMXQiL3kPP3gFqvHpoxZeFsNOHsttFVEJ5QsAp2tlE1rRzK1tT8RQZknreGs7NBwyJnbr7iLgcD/xISb9Jiq8/f8SngGxWBN85+CZ1y08+XSi5vaX90ofNgkpbF0bRrla0wVIYuvrBQYpJmoz5ghBgvQss6BhxsqzWDHQgnmyzyFntpAvoGjk+8qktUMrbdtiu0kckHTjb4fbXxAYloVM1x2mOVy+UBNs3wD6rl5fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bB9hdUEo5Rliu8QOZDOa/kMf/IzuAkrVVnmKvypyuY=;
 b=V7RQabPNg4P1TO6wTaCX9L6VujaZbdiiahiNBwnAcMOzMk8uaZMLq4NOzn52Dgy1YGSq2JqEAWjUfHEbiJJMGxh4KDJmNnF5var8Y/YUFW5Vm0KSB/5e4gLmVaS49dHwAG1NBVFe7mT02SDIia6j8RWVf1hflSAaECdej43Pb3U=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by BYAPR11MB3013.namprd11.prod.outlook.com (2603:10b6:a03:8b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.13; Tue, 15 Dec
 2020 01:11:17 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::b47b:94af:71b8:63c9]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::b47b:94af:71b8:63c9%5]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 01:11:16 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [RFC PATCH 2/2] nvmet_tcp: enable polling nvme for completions
Thread-Topic: [RFC PATCH 2/2] nvmet_tcp: enable polling nvme for completions
Thread-Index: AdbSfAmysZJa9Ql5T9GTUfIp4UX4Aw==
Date: Tue, 15 Dec 2020 01:11:16 +0000
Message-ID: <BYAPR11MB28696A3E9DB98DE8AC271EFDE5C60@BYAPR11MB2869.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 5e5c2149-6272-4d67-86af-08d8a09652ef
x-ms-traffictypediagnostic: BYAPR11MB3013:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB301382703FED3E6ABA104049E5C60@BYAPR11MB3013.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DFG6C6QPPOWRgTq7hCZOAHCU4PPS2cDf4pVh641ffBCmGNoJGLLKkvvsuC8qAx4YhVpau1tgVbn9l/NCggNMiAjuwQo1fKQ9QzBl+FwrJr4Y5FBWMkf3oHq16lzCW6FomakMGsB0/RXoxRmOEvxwv0xNv/H0Ca2iDMxInUxEbHAtQejIWytnVZ/8oT8+d81hnL6HZVUEd/9zKzEu9vvHYSnkoSOFZl/2RAXxv62dKulhk7487kCxCI8Ut3xSNyn5b+rpFOSDUUai2zNLWZKY5Wu86Gj3Nm6RPy/O/u2y/Cwp0sl7+PRqTLdcSa9UBj2IGhZ3/eyy8oHjDyvV6/cBEQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(376002)(136003)(83380400001)(186003)(2906002)(6506007)(76116006)(55016002)(33656002)(107886003)(66946007)(64756008)(66476007)(52536014)(7696005)(54906003)(66446008)(5660300002)(26005)(71200400001)(4326008)(508600001)(66556008)(86362001)(8936002)(8676002)(6916009)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cPtNDD1bA3lmEd3sQS+YhbBW0gD8OzEOZ1gWpPkcT/Z+cqS4zmoM2UBKFgWX?=
 =?us-ascii?Q?iWvc2+w/33jBOm8OOEjiw0LFzmRnEk0b4dqHGqNu9Mbg6+KBOvI7Crjb69CP?=
 =?us-ascii?Q?w6cNF5VJuiT+S06DVgibcU8f2NNxMwgZRiRf78AimbIUyZqyUbfoAAVwbnUQ?=
 =?us-ascii?Q?t1bhAdioOGgS5EMNpYNZUQfaQPo0lgz2BhzNze+WwNa1FIkkSJ7gSH2d/7LA?=
 =?us-ascii?Q?xgBonit+clhJUvs7NwGcnDm7i5MCETZZOA/PHpI7fOl+pC/ve5MbGRl7FOFT?=
 =?us-ascii?Q?qpFy9/QmpKyHFBwpBJy2huYJDyQ84eQFUAOXibc3PucSeSyW1uGD6c9cGv09?=
 =?us-ascii?Q?jt5NM88JnoCrN9pLiDcCTJLUX/xMJYRPHDaT3srFvTYwkJsDpfMd3eLzLilw?=
 =?us-ascii?Q?c5zk6L+lwuhSbfw2/wP666oSvjNXTi66/9YEASESNym6ckelpqdFdosND9qK?=
 =?us-ascii?Q?iWT1vphsj7d0UinVWLxCMnps7ffQjn3fqu8CKXmQ8Grx9F7kw3l4GCq0Ry/z?=
 =?us-ascii?Q?hUeyr4YTMyM+riQpPBvbNv3J/T1x4jUSyhmBVFaeTtaqOPrYffY37hNZ41I4?=
 =?us-ascii?Q?bcklUK49LuAxfoldEMTwgmTZ5FUC7Ga1yjYiuJIsi6bPv20XIJooh0mrkOaK?=
 =?us-ascii?Q?f+Pa017Hm0s8vKkxFCw2NbxUMG+1Jt2z5fVTti6ffZmMttv+Pj2vUnuG2uZG?=
 =?us-ascii?Q?9Zp3FGNuS3oTT0ugmGA5JrxiEd78Z6/3UJDfRAbgfrkf9io81axS5Cgr7FZs?=
 =?us-ascii?Q?YdtpvAQVYLpPNHBn6c1IJNqnfoh3UA9NRR5dX8I6I+B+QcMRj9FgPTsrfA5Y?=
 =?us-ascii?Q?/0Rokt1inZx5OAiPrFfBxFt3ERjiP5M9VXehA8SqX1l1l7eVS/4ZrchDUtno?=
 =?us-ascii?Q?fi9wTQWwmjdE5jswElxJVh5URs8yNPxx24kuGnoX+OKdEt6r+w9Ic/N0eqUt?=
 =?us-ascii?Q?qQKYz2ns2c2Q+xTzdtLzZp6prOELkDpbUf+jZgsj85M=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e5c2149-6272-4d67-86af-08d8a09652ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 01:11:16.8603 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SB94s04H0ms8Q1/mqpAQbEKqUrJA/QveH4XvAfINHCc7diaS+GzUu56QkTpWfMMNWgzBhur7IpxjeyxOH50Q2usWhGLdVtO1h3yUJUqj+OY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3013
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201214_201123_675407_75D840EE 
X-CRM114-Status: GOOD (  22.87  )
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

nvmet_tcp: enable polling nvme for completions

NVMe device queue interrupt activity can conflict with CPUs
processing NVMe/TCP network queues.  This patch adds the ability
to poll an NVMe device for completions, when NVMe device poll
queues are configured.

A new non-blocking blk_poll_once() function is introduced to
provide a one shot option to poll an individual NVMe device
queue.

Per-queue tracking of outstanding requests to specific NVMe
devices established to facilitate directed use of the new
blk_poll_once() function.

These changes are viable after adding the previous patch
that added the idle_poll_period option to io_work(). If this
option is not enabled then use of NVMe device polling is
bypassed.

Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
 block/blk-mq.c                    |   22 +++++++++
 drivers/nvme/target/io-cmd-bdev.c |    6 ++
 drivers/nvme/target/nvmet.h       |    4 ++
 drivers/nvme/target/tcp.c         |   90 ++++++++++++++++++++++++++++++++++++-
 include/linux/blkdev.h            |    1 
 5 files changed, 120 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 55bcee5dc032..ceacf327f65e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3832,6 +3832,28 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
 	return blk_mq_poll_hybrid_sleep(q, rq);
 }
 
+int blk_poll_once(struct request_queue *q)
+{
+	struct blk_mq_hw_ctx *hctx;
+	int ret;
+
+	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
+		return 0;
+
+	hctx = blk_mq_map_queue_type(q, HCTX_TYPE_POLL, smp_processor_id());
+	if (!hctx) {
+		pr_err("%s: hctx not resolved\n", __func__);
+		return 0;
+	}
+
+	hctx->poll_invoked++;
+	ret = q->mq_ops->poll(hctx);
+	if (ret > 0)
+		hctx->poll_success++;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blk_poll_once);
+
 /**
  * blk_poll - poll for IO completions
  * @q:  the queue
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 125dde3f410e..1d9ee8546ae1 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -269,6 +269,12 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_private = req;
 	bio->bi_end_io = nvmet_bio_done;
+	/* Set hipri flag to trigger use of poll queues */
+	if ((req->op & REQ_HIPRI) &&
+	    test_bit(QUEUE_FLAG_POLL, &bio->bi_disk->queue->queue_flags)) {
+		op |= REQ_HIPRI;
+		req->queue = bio->bi_disk->queue;
+	}
 	bio->bi_opf = op;
 
 	blk_start_plug(&plug);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 559a15ccc322..65900df2b45d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -341,6 +341,10 @@ struct nvmet_req {
 	size_t			transfer_len;
 	size_t			metadata_len;
 
+	/* details to support polling */
+	struct request_queue	*queue;
+	int			op;
+
 	struct nvmet_port	*port;
 
 	void (*execute)(struct nvmet_req *req);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 739d67985d93..43a0cc630bc7 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -62,6 +62,12 @@ enum {
 	NVMET_TCP_F_INIT_FAILED = (1 << 0),
 };
 
+struct nvmet_tcp_devq {
+	u32				pend_cnt;
+	struct request_queue		*queue;
+	struct list_head		entry;
+};
+
 struct nvmet_tcp_cmd {
 	struct nvmet_tcp_queue		*queue;
 	struct nvmet_req		req;
@@ -82,6 +88,7 @@ struct nvmet_tcp_cmd {
 	struct kvec			*iov;
 	u32				flags;
 
+	struct nvmet_tcp_devq		*devq;
 	struct list_head		entry;
 	struct llist_node		lentry;
 
@@ -142,6 +149,9 @@ struct nvmet_tcp_queue {
 	int			idx;
 	struct list_head	queue_list;
 
+	/* ref to group subsys devq entry */
+	struct list_head	devq_list;
+
 	struct nvmet_tcp_cmd	connect;
 
 	struct page_frag_cache	pf_cache;
@@ -237,6 +247,42 @@ static inline int queue_cpu(struct nvmet_tcp_queue *queue)
 	return queue->sock->sk->sk_incoming_cpu;
 }
 
+static int nvmet_tcp_track_queue(struct nvmet_tcp_queue *queue)
+{
+	struct nvmet_tcp_devq *devq;
+	struct nvmet_req *req = &queue->cmd->req;
+
+	/* track only requests issued as poll requests */
+	if (req->queue == NULL)
+		return 0;
+
+	list_for_each_entry(devq, &queue->devq_list, entry) {
+		if (devq->queue == req->queue)
+			goto update;
+	}
+
+	devq = kzalloc(sizeof(*devq), GFP_KERNEL);
+	if (!devq)
+		return -ENOMEM;
+	list_add_tail(&devq->entry, &queue->devq_list);
+	devq->queue = req->queue;
+update:
+	devq->pend_cnt++;
+	queue->cmd->devq = devq;
+	return 0;
+}
+
+static void nvmet_tcp_free_dev_tracking(struct nvmet_tcp_queue *queue)
+{
+	struct nvmet_tcp_devq *devq;
+
+	while ((devq = list_first_entry_or_null(
+			&queue->devq_list, struct nvmet_tcp_devq, entry))) {
+		list_del_init(&devq->entry);
+		kfree(devq);
+	}
+}
+
 static inline u8 nvmet_tcp_hdgst_len(struct nvmet_tcp_queue *queue)
 {
 	return queue->hdr_digest ? NVME_TCP_DIGEST_LENGTH : 0;
@@ -479,6 +525,25 @@ static void nvmet_setup_response_pdu(struct nvmet_tcp_cmd *cmd)
 	}
 }
 
+static inline void nvmet_tcp_poll_init(struct nvmet_req *req)
+{
+	req->queue = NULL;
+	if (idle_poll_period)
+		req->op |= REQ_HIPRI;
+	else
+		req->op = 0;
+}
+
+static inline void nvmet_tcp_poll_devq_list(struct nvmet_tcp_queue *queue)
+{
+	struct nvmet_tcp_devq *devq;
+
+	list_for_each_entry(devq, &queue->devq_list, entry) {
+		if (devq->pend_cnt > 0)
+			blk_poll_once(devq->queue);
+	}
+}
+
 static void nvmet_tcp_process_resp_list(struct nvmet_tcp_queue *queue)
 {
 	struct llist_node *node;
@@ -486,6 +551,9 @@ static void nvmet_tcp_process_resp_list(struct nvmet_tcp_queue *queue)
 
 	for (node = llist_del_all(&queue->resp_list); node; node = node->next) {
 		cmd = llist_entry(node, struct nvmet_tcp_cmd, lentry);
+		/* remove cmd from device queue pending poll count */
+		if ((cmd->req.op & REQ_HIPRI) && (cmd->req.queue != NULL))
+			cmd->devq->pend_cnt--;
 		list_add(&cmd->entry, &queue->resp_send_list);
 		queue->send_list_len++;
 	}
@@ -524,7 +592,8 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	struct nvmet_tcp_queue	*queue = cmd->queue;
 
 	llist_add(&cmd->lentry, &queue->resp_list);
-	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
+	if (req->queue == NULL)
+		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
 }
 
 static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
@@ -745,6 +814,9 @@ static int nvmet_tcp_try_send(struct nvmet_tcp_queue *queue,
 	if (!queue->pend_cmds)
 		goto done;
 
+	/* poll device queues for pending completions */
+	nvmet_tcp_poll_devq_list(queue);
+
 	for (i = 0; i < budget; i++) {
 		ret = nvmet_tcp_try_send_one(queue, i == budget - 1);
 		if (unlikely(ret < 0)) {
@@ -990,7 +1062,9 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 		goto out;
 	}
 
+	nvmet_tcp_poll_init(req);
 	queue->cmd->req.execute(&queue->cmd->req);
+	ret = nvmet_tcp_track_queue(queue);
 out:
 	nvmet_prepare_receive_pdu(queue);
 	return ret;
@@ -1110,7 +1184,11 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 			nvmet_tcp_prep_recv_ddgst(cmd);
 			return 0;
 		}
+		nvmet_tcp_poll_init(&cmd->req);
 		cmd->req.execute(&cmd->req);
+		ret = nvmet_tcp_track_queue(queue);
+		if (ret < 0)
+			return ret;
 	}
 
 	nvmet_prepare_receive_pdu(queue);
@@ -1149,8 +1227,13 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 	}
 
 	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-	    cmd->rbytes_done == cmd->req.transfer_len)
+	    cmd->rbytes_done == cmd->req.transfer_len) {
+		nvmet_tcp_poll_init(&cmd->req);
 		cmd->req.execute(&cmd->req);
+		ret = nvmet_tcp_track_queue(queue);
+		if (ret < 0)
+			goto out;
+	}
 	ret = 0;
 out:
 	nvmet_prepare_receive_pdu(queue);
@@ -1459,6 +1542,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	cancel_work_sync(&queue->io_work);
 	sock_release(queue->sock);
 	nvmet_tcp_free_cmds(queue);
+	nvmet_tcp_free_dev_tracking(queue);
 	if (queue->hdr_digest || queue->data_digest)
 		nvmet_tcp_free_crypto(queue);
 	ida_simple_remove(&nvmet_tcp_queue_ida, queue->idx);
@@ -1581,9 +1665,9 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
 	queue->sock = newsock;
 	queue->port = port;
-	queue->nr_cmds = 0;
 	spin_lock_init(&queue->state_lock);
 	queue->state = NVMET_TCP_Q_CONNECTING;
+	INIT_LIST_HEAD(&queue->devq_list);
 	INIT_LIST_HEAD(&queue->free_list);
 	init_llist_head(&queue->resp_list);
 	INIT_LIST_HEAD(&queue->resp_send_list);
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 639cae2c158b..6a3e62e46c3a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -952,6 +952,7 @@ int blk_status_to_errno(blk_status_t status);
 blk_status_t errno_to_blk_status(int errno);
 
 int blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin);
+int blk_poll_once(struct request_queue *q);
 
 static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
 {

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

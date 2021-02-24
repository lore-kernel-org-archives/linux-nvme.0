Return-Path: <SRS0=qQKB=H2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC37C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 18:01:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4407864ECB
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Feb 2021 18:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4407864ECB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xA5QUiYq+ggWrC9JVWHIFjz5E9TkKiv8g5Rwpk79CDw=; b=wufh1yNAC6P7fDfcDoEMi2f+B2
	hNfuxHhSuamy4klImvoB1+Qy/Ed7MRU38l43YDf9Xq2MQxb9WHzwHQKjPenxeYx3Tr8gQ8WZP7VKa
	t11B6oj/g0iB+RNow2fLU50OXEKiDTeK/sfsekynktPmSZTy/3e5C6rYxKjr6eG3QF3hLHyvbKvnh
	hLFVRq/U/cPWSavxfCAg12rKQeCq7F5wZ6/Bri+XuvARMfHYLm9z8Ml2n5Evi58H7NnCR8afG9wjG
	8MTDUp/choe3M9v2weWF/Bh61gInXRxQdOb57/cnG85VtXs0I2Ctxlp8j8L7J5jvoznuYt37Iq0No
	/ZaOZjRQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEySy-0002zh-Nz; Wed, 24 Feb 2021 18:00:52 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEySw-0002zJ-2d
 for linux-nvme@lists.infradead.org; Wed, 24 Feb 2021 18:00:51 +0000
IronPort-SDR: C0kxf2/5Mh8tg6S9YQG4IgS/Z2IvEk0/Gr740pMCVMD3wLmpvDpu9IOgm+zFV9pz5QJRmsK+un
 kKcOn73RYAlQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9905"; a="204731184"
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; d="scan'208";a="204731184"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2021 10:00:46 -0800
IronPort-SDR: c6vuyh3oaPVDmNN9pJgwz3nAYHlFRN1dje+WNeyNxyh70NnfLPNe9xykpco1TG1SE1xnZ/vryn
 voqY3U/wwIyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,203,1610438400"; d="scan'208";a="391685757"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by fmsmga008.fm.intel.com with ESMTP; 24 Feb 2021 10:00:46 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 24 Feb 2021 10:00:45 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 24 Feb 2021 10:00:45 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 24 Feb 2021 10:00:45 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.59) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 24 Feb 2021 10:00:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H9JvGUwOQ4oB3mZ8m57hSn9GZlV8S1SETf4m48kz8qsUDYqTSbAvBMU7Pr6v58mBMZfBCso1j1WxqmgWvJTaNQxlGO7qQgrCAILDCcnSOOm/NU3Fs0BXTA80Xhs7jsKR5Nu5gGU+L6YvqO1UXMmhlLpNjhwlmh88Gj9ixdXUGaV1UFpzrTYiHrNfNNtw/xxylTK6z41A4lOVoMGB4WAqG5epgW054XpYGo4DBmlMhl70WdcGQe139WKyzzkHSKMMA2MsM1xtcuL8YoY63qBv/S0uHp9qEzKb/NbUnd9oZvJ/2OL6VKzPa7ALQQmDiZRKnyOiQ0+BNY/AAu3OCWtuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQECzeRRP8Teyzry9EYrwoUqRayWyfKwW9JG0Hlj3tE=;
 b=OpN7R7laC52zBAuwZgHXl1MvzgLcLvotlFqcXfGSCTjH/DRFuMalsGRrkDLF4recKG8v1X9E+3hn4ePjGIPKCtWJWWAvADL4A8/t1R0nyHMfC3o89kr00vK8MMPYJi7lPrQy0PttkMsF4CNdGO/8Kd8ZOGXt8C2ItRZEWzNmBtBAlSDuP9bfZtiGA+MXsM3JHa2Rrln3lXCiW2LHyom5mpAUjv2gAoidNw/WGXbIOxTHsolE4AF2gSOVqtjlN64PL+TNMzdwOJjygFZI7GwgCf7IyOOuVSP49hoWZQ7UVDGHF+rfpc8Vs2Ds30E7QR3F7B7zCbvcEaVRnOdtNTQSCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQECzeRRP8Teyzry9EYrwoUqRayWyfKwW9JG0Hlj3tE=;
 b=DKL8/7B0dJhLaARd48zvd0JKmx7eMuC66B2Qf2zDm/u8+wVuj2iICDfGCvOKEYwERxQoR3A6faFTuiRfwZFhtf0vJNs40xCvagwyNeRmDE7FJcJ4E/inyA+5xZVX9tvmGK8uWSz6ErtXk5ojFeY96OlUbyBLAhhlBxeGTO9bOvU=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by BYAPR11MB3749.namprd11.prod.outlook.com (2603:10b6:a03:b0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Wed, 24 Feb
 2021 18:00:41 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::ec7d:c69c:7718:9e82]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::ec7d:c69c:7718:9e82%7]) with mapi id 15.20.3890.019; Wed, 24 Feb 2021
 18:00:41 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH V2] nvmet-tcp: enable optional queue idle period tracking
Thread-Topic: [PATCH V2] nvmet-tcp: enable optional queue idle period tracking
Thread-Index: AdcK1lKmriyCxaJpRmyydZrI1NAlbw==
Date: Wed, 24 Feb 2021 18:00:41 +0000
Message-ID: <BYAPR11MB2869965F8A766860ADE9753EE59F9@BYAPR11MB2869.namprd11.prod.outlook.com>
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
x-originating-ip: [67.171.162.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c7fcf5b9-4478-457c-c3cd-08d8d8ee195e
x-ms-traffictypediagnostic: BYAPR11MB3749:
x-microsoft-antispam-prvs: <BYAPR11MB3749C458B939788712131EB8E59F9@BYAPR11MB3749.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F19UEqkBcSiyv1sH+utwY6YSz6TnV6fkrxhBBNC2BvZAIrsimbUfE4oZa4A7Lhe7Xt5hL4mMR/WS+SVNCJwHNt0qnhyY065EcFUgSFZvOBjvMF/ozuOTr2P844u/Ob2e+EmRdRLvt56rdxIoMd+FAHEDzD++Yun5zAkK0ku7XaWEWuM+1xX/AYL6199rLMwcn2f4rMfFIIeAXi/7T53U/6+coNcwp1Gfq1QHEVH6GqmTe2vHg18UAPOyx6GIvKunVD+dpeqA3qqyEnH2xQO3q7rbOjNLSxTMAIypstA8mGY07VkbJz+fzssFlTn76nzXWkLhSD96IuBbgE085+alLNrtN7i+Zvu9xrBc5LRkrfwt4PzcAQJUqXt4eMQhKizY2Oe6xSSZBzqoihl5wq1ce8sU+k8+sewrb8zi+XfDYmDkZSOPhDYmU743WlKRyzpyJ6JzY5ettDbI5OGldP5vK7RlRSRXyp/hM8iVNTNkrxGpOU0IRPKFgf6QNUd74PNkWSuMwMlMKXYML6dpUgDaag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(346002)(366004)(39860400002)(376002)(396003)(9686003)(2906002)(5660300002)(7696005)(71200400001)(52536014)(8676002)(66946007)(186003)(86362001)(64756008)(76116006)(8936002)(66476007)(55016002)(26005)(66556008)(66446008)(83380400001)(478600001)(316002)(33656002)(6916009)(4326008)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ktkdmhZYd5nUPHjiUqTsHK+cmiVnKDB+IprrHZ/ZpVs5kzctk7QqW+/MPmpa?=
 =?us-ascii?Q?WQfSd6pg8vkmrHjZ6Z/DYXVvtto0wnIN9rJj1Dl7HX6knDxoraNWgi2w8mon?=
 =?us-ascii?Q?mPSOR/ZvTQgn0L+S7uuyIMqQBu1XUXLsxyZDg3F+oZTFylOcywKgw/f54oIH?=
 =?us-ascii?Q?bJa393hbVlhadw5rfFEdhOsHO3gYqZGHBRpLr9k976c+IZrcoaWv9xUWFLAl?=
 =?us-ascii?Q?cGg+bF4YT0F0pqGl2LEmOR0nXk8moxVVZp0ZmNtUjIU85C9c16lvYU5s0pth?=
 =?us-ascii?Q?/7qJkYjvKQQ+htliKz+Iapxf3LfM5PDO/6YDE+6+YMH3j5HEQ5UcTiPr3wwk?=
 =?us-ascii?Q?HZvInHfC62Nb+Fb1lLq2JGGCaIjXsLpwv4I/tmNb7iv2mKp1pTcgjUPadn4L?=
 =?us-ascii?Q?tz9Tv2sL0zHYVGDlgiTMKrswPAnPiZ2LvkDOgztL8tOi7OYuPSTHHStq47Ku?=
 =?us-ascii?Q?Yhjz7RBHasJBdlRUaS+1WtXMpJ6Yq98MiE89kjV7mQor75bUx32ptBFygbh3?=
 =?us-ascii?Q?bpOljq0GSZanfJAFF5g4euveb+t/EZYsoc9DAhggtJ12ZWo7pc/aGcH5Wzbl?=
 =?us-ascii?Q?f4/XTpgO20JGEmfAH7GSH1971J4I5ZvSDVuE6FUxrXRIl5uFbuiwlzAMokes?=
 =?us-ascii?Q?ESnjywMJFW6bWAnZuHzQpeZ+reCrGR0cLGpfrJAI1lrMHRWundERv6pC1JQS?=
 =?us-ascii?Q?zVD9CPUuMx4x/w3QtxnXYvReXyfJRW1CDlTnuCsHHeB3C+9kugXRMD38Jgqb?=
 =?us-ascii?Q?3FVSZ817tfz+8UoDYbeyful5kOU0zI9jHTEHcO0Npwdzk7Lu/CwumNmU6UCP?=
 =?us-ascii?Q?tAATAmqIF+EmiMOa/JJwJNeeRjl3tNLn60DszCCkPJVm1cBo9iOiVAbbI4Gj?=
 =?us-ascii?Q?T8cbOtxquTKk49gg9lzoTzeZ8/Ih4y//P+r17ztQqjA4iSnKxGp26TEGJ9yq?=
 =?us-ascii?Q?5Q7Es+JZDuhwQ+GpuXrcvt3cdQtA0QWyIdKTA0ytD+4LMaF1iu+Q2kKx1tJh?=
 =?us-ascii?Q?mUJhg4UX8332o27o5hGgb0F1AT2guZ7puIOBu82Gdi17MosAwT8lOHVVE7V5?=
 =?us-ascii?Q?x0+8Z3PX7QgRk7ubbCY7JjrNrol0Xc4xwuoCiR315acHR38KZClWEtTWSmgK?=
 =?us-ascii?Q?Or45xO1+nedtpDF3slJefDNc+anaidNX+5z7+2hYu9/9TuSNzBu4X8q5+49y?=
 =?us-ascii?Q?Y0QSRUC4vOXjqnBRugkQG1E1NsCUJwKPS8nzrYiAbn4lgao0tqv1W7Qvvi1W?=
 =?us-ascii?Q?GdADFtsyXbjKiWwurqNQ3tn18jgPKqxZpl2+58P51BpD+y5RPpvXdYuhr78O?=
 =?us-ascii?Q?DriO9Rp/kN3T8sdhzw2X1IeN?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fcf5b9-4478-457c-c3cd-08d8d8ee195e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 18:00:41.0593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iLpREC4xjiwKdYI9On63s+0SYU6q1AQ3Ji7JNraZHdSyDdxbjywyblPe4oDWW7u7kzH+XkSHs8zqT5LAIXbj+ptz7qdioArX2P/pozUcZIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3749
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_130050_446269_D1B524C0 
X-CRM114-Status: GOOD (  23.61  )
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

Add 'queue idle period' option used by io_work() to support
network devices enabled with advanced interrupt moderation
supporting a relaxed interrupt model. It was discovered that
such a NIC used on the target was unable to support initiator
connection establishment, caused by the existing io_work()
flow that immediately exits and does not re-queue itself at
the first loop with no activity.

With this new option a queue is assigned a period of time
that no activity must occur in order to become 'idle'.  Until
the queue is idle the work item is requeued.

The new module option is defined as changeable making it
flexible for testing purposes.

The pre-existing legacy behavior is preserved when no module option
for queue idle period is specified.

Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
V2 of this patch removes the accounting of time deducted from the
idle deadline time period only during io_work activity.  The result
is a more simple solution, only requiring the selection of a
sufficient optional time period that will catch any non-idle activity
to keep a queue active.

Testing was performed with a NIC using standard HW interrupt mode, with
and without the new module option enabled.  No measurable performance
drop was seen when the patch wsa applied and the new option specified
or not.  A side effect of a standard NIC using the new option
will reduce the context switch rate.  We measured a drop from roughly
90K to less than 300 (for 32 active connections).

For a NIC using a passive advanced interrupt moderation policy, it was
then successfully able to achieve and maintain active connections with
the target.
---
 drivers/nvme/target/tcp.c |   55 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc1f0f647189..96b6c28e327b 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -29,6 +29,16 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvmet tcp socket optimize priority");
 
+/* Define a time period (in usecs) that io_work() shall sample an activated
+ * queue before determining it to be idle.  This optional module behavior
+ * can enable NIC solutions that support socket optimized packet processing
+ * using advanced interrupt moderation techniques.
+ */
+static int queue_idle_period_usecs;
+module_param(queue_idle_period_usecs, int, 0644);
+MODULE_PARM_DESC(queue_idle_period_usecs,
+		"nvmet tcp io_work queue idle time period in usecs");
+
 #define NVMET_TCP_RECV_BUDGET		8
 #define NVMET_TCP_SEND_BUDGET		8
 #define NVMET_TCP_IO_WORK_BUDGET	64
@@ -96,6 +106,7 @@ struct nvmet_tcp_queue {
 	struct work_struct	io_work;
 	struct nvmet_cq		nvme_cq;
 	struct nvmet_sq		nvme_sq;
+	unsigned long           idle_poll_deadline;
 
 	/* send state */
 	struct nvmet_tcp_cmd	*cmds;
@@ -1198,6 +1209,25 @@ static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
 	spin_unlock(&queue->state_lock);
 }
 
+/*
+ * This worker function will process all send and recv packet
+ * activity for a queue. It will loop on the queue for up to a
+ * given maximum operation budget, or until there is no activity
+ * during a single loop iteration.
+ *
+ * Two exit modes are possible.
+ *
+ * The default 'pending' mode where the worker will re-queue
+ * itself, after exiting the work loop, only if any send or recv
+ * activity was recorded during the last pass within the loop.
+ *
+ * A optional 'idle period' mode where in addition to re-queueing
+ * itself because of activity it also tracks if a queue has not reached an
+ * assigned 'idle' deadline time period. The worker consumes from the assigned
+ * time period, across many potential invocations with no activity, until it
+ * has expired. Any activity during an invocation will trigger a fresh
+ * idle period deadline.
+ */
 static void nvmet_tcp_io_work(struct work_struct *w)
 {
 	struct nvmet_tcp_queue *queue =
@@ -1205,6 +1235,11 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 	bool pending;
 	int ret, ops = 0;
 
+	if (queue_idle_period_usecs && queue->idle_poll_deadline == 0)
+		/* Assign the queue idle period deadline if not already set */
+		queue->idle_poll_deadline =
+			jiffies + usecs_to_jiffies(queue_idle_period_usecs);
+
 	do {
 		pending = false;
 
@@ -1222,8 +1257,24 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 
 	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
 
-	/*
-	 * We exahusted our budget, requeue our selves
+	/* If optional deadline mode active, determine if queue has reached its
+	 * idle process deadline limit.  Any ops activity awards the queue a new
+	 * deadline period.
+	 */
+	if (queue_idle_period_usecs) {
+		/* Clear to award active non-idle queue new period, or
+		 * reset for future queue activity after exit when idle reached.
+		 */
+		if (!time_after(jiffies, queue->idle_poll_deadline)) {
+			pending = true;
+			if (ops > 0)
+				queue->idle_poll_deadline = 0;
+		} else
+			queue->idle_poll_deadline = 0;
+	}
+
+	/* We requeue ourself when pending indicates there was activity
+	 * recorded, or queue has not reached optional idle time period.
 	 */
 	if (pending)
 		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

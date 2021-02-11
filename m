Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE8AC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 23:43:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B62A664E35
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 23:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B62A664E35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Nco+s/TEh9QtVZbeSRSfOC7cGvkkgcheLlBcNk0W9Og=; b=oPw7/HdQRYyxNtR4MiPWneAuX3
	RodDVL2h+TOLdsCdR2e0Y/V89EP/3/O6Tz/TbFvZy+lE1w2UqBgA+smJbsHJI02fWLaRJoY7VWxpP
	hsBu7IuXohaPcV39ElGscBDv3nQIhzhNztV79530Hv83UFFWkWtdv4udGzyZSHCCEEFjW81ug8EzP
	2ebwOuh4NJhtXgQxvSRhLV3+ek4JnuV9C4QHNPjrkvEg3X14jQW/UhkWXbXS8JJoOs3gXlp7Trw0F
	1o1L2gredzzQKF+o+5hg20pGQVnqygyVe3Gg4cOYQY2SVX+Kjjny3mNkdjlrCkZmnyfAN4L0mvsE1
	ewwJGPLA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lALc2-0003uP-FQ; Thu, 11 Feb 2021 23:43:06 +0000
Received: from mga12.intel.com ([192.55.52.136])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lALbx-0003tz-Uk
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 23:43:03 +0000
IronPort-SDR: brc1ri05LMOhBpxhvHcfaR6fHKiC7dFJTXVLtN9wPl+pmIy3LNJHrkn79iq6y7fd9Ytp4JU9Wy
 unzxN06rO5OA==
X-IronPort-AV: E=McAfee;i="6000,8403,9892"; a="161480361"
X-IronPort-AV: E=Sophos;i="5.81,172,1610438400"; d="scan'208";a="161480361"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2021 15:42:57 -0800
IronPort-SDR: 948sGu2EyRLR2kmvBI69TwhLxIu+xekPGlqPU0Hn3LTYHMKxaM4iRvFe2MQE8vafwKHfRopFFa
 z4aZYHLDXC5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,172,1610438400"; d="scan'208";a="415626543"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
 by fmsmga004.fm.intel.com with ESMTP; 11 Feb 2021 15:42:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 11 Feb 2021 15:42:57 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Thu, 11 Feb 2021 15:42:57 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Thu, 11 Feb 2021 15:42:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBj2MPl7rCdmBbpGVsRZhpo/zK66bCJ2aS48IEaQ+h3O4oQbYyo1jaZ8mvtdUuPo2X/zC8t4tLfVlMH31aR/4TUlGjGiJ4F0T2QCYPX9E3OVLGCo4YLfyQuAiq3YSBXlQrf+Uo0csLQX8on+CPP+si0PnSIsJ1XiIXTiLD+9lXxGzGCAQ4cSLwkXg33xtRt/5Z5dYo1P91zgqGAnvWlTFusq2iPi3cNbsgmuVzi5xG+3TF66yhjFohLerQRlCKYIaG8VE1BAVLcybCfon8l8UAbOug8A/YpKNAs5fdJt52TU0NPqkTSS0u5K0iKa9XdzV1wM45XgpmbT3d1A7HcKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJqnY1c4jc6MoSTz3KLHXSxbKke59KdNQI7FWWyoqHs=;
 b=gtHwgfg0HAoSW+cXeFVKDP+/+kbAU8WRhGnJc1rxdhVQPMnedTZXowRTrAnqNabY4l73rfkNCM4KywaXMqmQB35j+Iz1UlvqwTajtK5zqTm9kcctpKh3nHGuv0mLfg/iRXte7VL+ktYZDQUNjRIeqdY7zR5Yn4Tfp8uLKET2pNNtXkGSqtlAqq0sq84g+qX8Loo4y7x4RIARkAxropY8I7GArsVA+gdZi8SAjDjCBEuUZfc33q7jmAFNCMDCZdDRNs7TiN9vH9kqpgfNC4CN6UIWj8tYAGIGB8QJJsTZFhGadTBgnGthSpG+3cWLoHaCBButLBTA6rG5qMl9gcIUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJqnY1c4jc6MoSTz3KLHXSxbKke59KdNQI7FWWyoqHs=;
 b=LB6SN4ZqhsFtSri8pqPM9iJCyShama6BOTpUAt5Bespi6IfMS99WoMNsFPN1pr93lL9ftrFbpdkZmZWKZSY3WxkI6tGsCFe9bCh50l3C2/aL4v94cxVJUY9T5VvuO5CT8VUMj0/ENBYauHmHCopvrBX1lQYMArJILEId1j1z6mk=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by BYAPR11MB3208.namprd11.prod.outlook.com (2603:10b6:a03:7d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 11 Feb
 2021 23:42:56 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::b47b:94af:71b8:63c9]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::b47b:94af:71b8:63c9%5]) with mapi id 15.20.3825.030; Thu, 11 Feb 2021
 23:42:56 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvmet-tcp: enable optional queue idle period tracking
Thread-Topic: [PATCH] nvmet-tcp: enable optional queue idle period tracking
Thread-Index: AdcAzwvEySZF244WSSimWeKKHvq25Q==
Date: Thu, 11 Feb 2021 23:42:55 +0000
Message-ID: <BYAPR11MB286909CAA3A8721B46A02AFFE58C9@BYAPR11MB2869.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: f794fa80-e4d6-44a1-5262-08d8cee6c1c0
x-ms-traffictypediagnostic: BYAPR11MB3208:
x-microsoft-antispam-prvs: <BYAPR11MB32087AA59CBE5524C7FAE1B8E58C9@BYAPR11MB3208.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wgJ3X5yP/zxd9UhTgIk4/7kr9KuH8VpvBP7QW2GLiYOTNxw7UMch/+OdoN3XRb0icwrC1Z4igROJOPuEwy9Vea2wgBRalQenKuq4t0JGAckVB4MuVQuwEzZB04gR3Zl5eRZrM6ojwoxcvNaZDOL0EZwtn87UKPDrlUZxycUeaufp6JqWzR9zJ9Xa/TgS3ZVQZ5zuHh2+qiISMQsBzp00sbsyMX49tKz9ss+n8z7uCkiKv8uRkm30fQcWXQcIqom2c0Inpr4REQea/PRmuf4n6j29sUA6Nvf+HKbyWqCXOEgSk/RJkqAoV0i4wqIfrE+Mxm00UIl5xb8DoywV1XYq/CTrGfrRptHcdcpz7o4e32q6B3BxmxaBp4a/Z8hMlz/1GprkXtmV3wKjU0idK+04JjCCRQkACz1fTwaWzfb4HvcT0Wg6uDEDPc9g7L4lOn7NTA1+QmBbcQXWUyHcejUugKIibcXwFxhwSK/9hjzEaJgcTDQlTdA4PFn5KVKYKObamgZJ4hhl4xq/97qSN6dbzg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(39860400002)(346002)(136003)(396003)(366004)(64756008)(66446008)(76116006)(66556008)(66476007)(66946007)(71200400001)(86362001)(4326008)(478600001)(26005)(5660300002)(9686003)(2906002)(6506007)(33656002)(55016002)(316002)(186003)(83380400001)(6916009)(52536014)(7696005)(8676002)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bVLMMgSDEClfLV/GhDH9Q9ULQZ0jZeHyLlBOiIu9zq6MpNT0wrJhl6ew/P9j?=
 =?us-ascii?Q?f1au4xqR8lmbndXq/igauMwbTH5KERcPNTreSwps+KybjOlc7JnLf4f8REnG?=
 =?us-ascii?Q?T3143IR+XMgT8gSWVo/+BuMoAjx5xcbcBAmWWxlOeUpYBTqPavbJhMdQHQRd?=
 =?us-ascii?Q?zLOhoEpd2DUvFKXtPY70Eg9/kuS1eC1Uq4U/oy24qDSdiaoOq7vq9IkkhuZZ?=
 =?us-ascii?Q?gr7ZUb56o/xPASyqlF6x4kE42+JshEhupx3i6BSFG1SnHyWjodTQeZCzTDgO?=
 =?us-ascii?Q?bByjX5i+n+0XRl6CgnUKMXm0u0IlSuY4JuP66wh9iOTBdBe1/vm4DVHfo6B8?=
 =?us-ascii?Q?hVgeiZlVi+9qLVLCuFCpIVZODUjzssIaSJpzJy4bCaaFtZ1a6EXHeTCsnZta?=
 =?us-ascii?Q?4cq3IpJ2otT/eFvE9y3T0SLhDC9NDwzcJFn+hmDeGw3NW09uNAXBZj0RDLI6?=
 =?us-ascii?Q?B5SsYD0wUAVId4b7MZ/RgtRmnxTf9qttlLtixhgLayK+SL3hHpL1gNy/oZpn?=
 =?us-ascii?Q?YGPKl9n2W/aW0/K4TZUZhA2yhAE5xGIY0h9m7XaLTrFiVYafyTRxXoVUmpJy?=
 =?us-ascii?Q?8NLZVE9KsUfp8u/xm3+NXn7WW0ycoqttBdStY7G8YI+81KCUkuPGeBVg47Kv?=
 =?us-ascii?Q?KsW1zIRRtYzsuTdmJGA9sddhpNsp/Xd+U8JLuQXuqq0u4+eAisL5FYGAVWbs?=
 =?us-ascii?Q?zHtKtvutSVPs+qCmcw9YmZhgMdGSDPQ1H0r5689LldX4zyDWN7/N8TMx/euo?=
 =?us-ascii?Q?YMetlTeRTz5JjQn9PhOhUA4Qu+J+5t/YDYkBemUaIWBvgwt9V7Wa9wNa6hyy?=
 =?us-ascii?Q?Mf5DLL2KaYYzmqL8ULYrGnfWimFbKW746sTnbREk91ws+bKgHW0I1g+5dzCv?=
 =?us-ascii?Q?dL/lFeC5drn/HZ7kESPoE4d7zAD9ZDdArHxHZzB2P8DbJHgVADCQoUnSOkU3?=
 =?us-ascii?Q?7Z8qqUOG8yZky2Z8M+y/aan5qaYt8qtwJDxhtXXFgfw5xfYO0bfib2v0FvJP?=
 =?us-ascii?Q?ey9suTm8a09uzNCFyrICBNfVRYxLAP4royoIbfJ2RUxdbegm7TRo3x6F9wg3?=
 =?us-ascii?Q?8xO2wZfJqyddR7iGh3fwNH2ki+g0OZ6oOSkSe8aqeGD/JfPky8qFmuHOZbq/?=
 =?us-ascii?Q?IyKlyCEWl7PfjzG3TKOje5pui7JGVrKWL1j4Z82QuDZdyBW0Lkvj9q9SJnTl?=
 =?us-ascii?Q?6FAwb9IJpHjEQ0vZ/jtY2EJKCXckULdO4gZe3qTzR6vm7vLfkza4Xfq3b5aP?=
 =?us-ascii?Q?Q1AY1pui+dSOI3HYbwdEUdkxqqgR2xgz+k9of+ya7rmK9cyLe+3Ih309ZQ1X?=
 =?us-ascii?Q?mh6ES13ghAqLUqP46cctt4Ek?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f794fa80-e4d6-44a1-5262-08d8cee6c1c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 23:42:55.9962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1zInbaLhHmShRhGtNvDjV+Ng2DZCilNr30FHps04wTyuczBuCpX0cLUto624kNmvbehudLhw2TYnz7UJsAQVkJJM37We2vo0PHexrl1+fI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3208
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_184302_608926_EDBBCA3F 
X-CRM114-Status: GOOD (  23.41  )
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

nvmet-tcp: enable optional queue idle period tracking

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
Testing was performed with a NIC using standard HW interrupt mode, with
and without the new module option enabled.  No measurable performance
drop was seen when the patch was applied and the new option specified
or not.  A side effect of a standard NIC using the new option
will reduce the context switch rate.  We measured a drop from roughly
90K to less than 300 (for 32 active connections).

For a NIC using a passive advanced interrupt moderation policy, it was
then successfully able to achieve and maintain active connections with
the target.
---
 drivers/nvme/target/tcp.c |   65 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc1f0f647189..f5e6e2806841 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -29,6 +29,16 @@ static int so_priority;
 module_param(so_priority, int, 0644);
 MODULE_PARM_DESC(so_priority, "nvmet tcp socket optimize priority");
 
+/*
+ * Define a time period (in msecs) that io_work() shall sample an activated
+ * queue before determining it to be idle.  This optional module behavior
+ * can enable NIC solutions that support socket optimized packet processing
+ * using advanced interrupt moderation techniques.
+ */
+static int queue_idle_period;
+module_param(queue_idle_period, int, 0644);
+MODULE_PARM_DESC(queue_idle_period, "nvmet tcp io_work queue idle time period");
+
 #define NVMET_TCP_RECV_BUDGET		8
 #define NVMET_TCP_SEND_BUDGET		8
 #define NVMET_TCP_IO_WORK_BUDGET	64
@@ -96,6 +106,7 @@ struct nvmet_tcp_queue {
 	struct work_struct	io_work;
 	struct nvmet_cq		nvme_cq;
 	struct nvmet_sq		nvme_sq;
+	unsigned long           idle_period;
 
 	/* send state */
 	struct nvmet_tcp_cmd	*cmds;
@@ -1198,12 +1209,42 @@ static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
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
+ * assigned 'idle' period of time. The worker consumes from the assigned
+ * time period, across many potential invocations, until it is expired.
+ * A queue with activity always being awarded a fresh time
+ * period for processing.
+ */
 static void nvmet_tcp_io_work(struct work_struct *w)
 {
 	struct nvmet_tcp_queue *queue =
 		container_of(w, struct nvmet_tcp_queue, io_work);
 	bool pending;
 	int ret, ops = 0;
+	long period_remaining;
+	unsigned long idle_deadline;
+
+	/* Setup use of optional tracking for idle time period */
+	if (queue_idle_period) {
+		/* Assign the queue an idle period if not already set */
+		if (!queue->idle_period)
+			queue->idle_period =
+					usecs_to_jiffies(queue_idle_period);
+		idle_deadline = jiffies + queue->idle_period;
+	}
 
 	do {
 		pending = false;
@@ -1222,8 +1263,30 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 
 	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
 
+	/* If optional deadline mode active, determine if queue has reached its
+	 * idle process deadline limit.  Remaining deadline is calculated. Any ops
+	 * activity awards the queue a new deadline period.
+	 */
+	if (queue_idle_period) {
+		/*
+		 * Clear to award active non-idle queue new period, or
+		 * reset for future queue activity after exit when idle reached.
+		 */
+		queue->idle_period = 0;
+		if (ops > 0) {
+			pending = true;
+		} else if (!time_after(jiffies, idle_deadline)) {
+			period_remaining = (long)(idle_deadline - jiffies);
+			if (period_remaining > 0) {
+				pending = true;
+				queue->idle_period = period_remaining;
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

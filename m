Return-Path: <SRS0=XXBd=IW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D634C433C1
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Mar 2021 17:48:20 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC9E961A1D
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Mar 2021 17:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9E961A1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=H65NYxLvT20hIPoD2Tb2BHrBCH0G+do+6afXtnLKQik=; b=JP6ULYmqzBPgvdxZTqMkhztWE/
	rtnLhTZeR+AK8YtUe7hmVhQbN0Jgz6ijyRM2hH6ejcHvvk97AwuYWjQYGe5n4/1Bn4Op/FPSpeGbq
	p1qx5pLlJqBtyq61PjnMs1DSR9bZP/G4RQk9VuL9J0lPFmRf54kisHJoBRcinHeFD/qY/218XiAp4
	BQa5Ffpti4DNiV4pw6T/UgU7XlooW92j0czieLtvISVy7GIL2e/BnmAllnlrDDGH4R9lskIKw5spa
	q0EEFX2IflEpK0f5Wl6oSoEJ/zMhMZHkGvxQKBQWmpQj6QsIQevxwXsQ6/yAX+gvVBeI/DEuOMQ4L
	/qe3uEig==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lP7bs-00HaSS-Gy; Wed, 24 Mar 2021 17:48:00 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lP7bm-00HaRE-Pj
 for linux-nvme@lists.infradead.org; Wed, 24 Mar 2021 17:47:57 +0000
IronPort-SDR: ZkCPbHFqyO9O430HPxdMoNlJbidE4lk85+moZ5wcj2MouHgETnu/mcXU08rb8Teo5TOSfUvPCL
 xQd4cpLnR/NA==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="190177382"
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; d="scan'208";a="190177382"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Mar 2021 10:47:52 -0700
IronPort-SDR: y+0fxYKBGDgSkKCUL1TYy1J4L5we/j0ee0+fcXkbirocmeIR1FmUiquBCWZRHPp28aeeKwK8sX
 J2wlOVVWeDkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,275,1610438400"; d="scan'208";a="415591340"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga008.jf.intel.com with ESMTP; 24 Mar 2021 10:47:52 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 24 Mar 2021 10:47:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 24 Mar 2021 10:47:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 24 Mar 2021 10:47:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baFCnuXGmH5+vkQMAq2YQqIapGeIfFMh24q+PLnMUXHeNSWhz2vgWLxgMLIIGq22l7k+x4jabp3UuD1IGOhz7iv7/u/uxVaWj9Gc8YZkiYSRyLFBKlkk++E4n4aXvlxAcS2V1qL2ouZxVWFrZR0Dit/H5WAwHNujtDq3NLBKAUSlDuCssYl2KNNgzWwjl2UMdDzj2cMWT+vS2Gt8Tpq0bC7sFuQkKkK69QiIHUt5HxlEZG5PtDIYaUz4v2dKtYWtWsUoW2MiZJ3Uso2RcAtRDYVgcXLzqAxBMxMotmI8/5OI+cmrMxutV3PcWUDHv/0fW2HECatiEVbGuc+rFZeayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cg+lwv81mEQzArfsKu3Fvzcfyuw5sva57O6X7l1h/VE=;
 b=WpzBk9kmDIeFXTaxOa8bKyH/NG310mV+FWrEmtZ48yrEr016b3Al9J+4X5r9AXMmOghGxIFQ0Gd51hovDKFld68NTuUqiBERcb+Yp5KSUoCwjg9f1/Y51ZPwUOuQTM1hiQ4cXakIz6miZavZv7eyQ+MgytbXdf/wjaqH7DwVi4TKZ2VBzZtZuVUkwiuM8/0vbybMYVTfoFN737OZlIHLb52ja+xH39vm+j0mzkb/ADlSU/aoFR5pinljWFQfOGDqCqRcWJthXlaeQNha890MD8ZP2pn1Z7bIN7sreLTHDKlk+6WtcB/AL9tto+ArVdzg91eRQzn30sWiwa7jJ6Xhtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cg+lwv81mEQzArfsKu3Fvzcfyuw5sva57O6X7l1h/VE=;
 b=nvmkoqGtVMIk8G+jFG+NhZ8/gKeJEtQ4XddFVNpvMT8qs57KX2rF3VuzgCnPW7i52ve4QPOJL3z2cyu+6+P4EtKCdBtVow/dG7k0iKuDN9f0SAWNvAqvmYYXSqVBoy6bWzyKSVX2RcTQ+Bp97zmXvURQ5/fnBw+BfkAdGg/602Q=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by SJ0PR11MB4861.namprd11.prod.outlook.com (2603:10b6:a03:2ac::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Wed, 24 Mar
 2021 17:47:50 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::9446:b8f4:d289:b20e]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::9446:b8f4:d289:b20e%6]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 17:47:50 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH V4] nvmet-tcp: enable optional queue idle period tracking
Thread-Topic: [PATCH V4] nvmet-tcp: enable optional queue idle period tracking
Thread-Index: Adcg1TmFWjeJRQgETzu27iRdPzrB4A==
Date: Wed, 24 Mar 2021 17:47:50 +0000
Message-ID: <BYAPR11MB2869734125E692608AE1A4A5E5639@BYAPR11MB2869.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 43ec715b-d619-4ba6-edde-08d8eeecf1a3
x-ms-traffictypediagnostic: SJ0PR11MB4861:
x-microsoft-antispam-prvs: <SJ0PR11MB4861B36C57E67D7B036C5BC1E5639@SJ0PR11MB4861.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y7MPDIsNaIfNwNhpcKzXCT17IdO11XTw4goeK0rz2ygv3eq3riFL/z3ALej3kBRo0pyofk+7P8oZupPnGeB5B1sVi1f32QClShYutrMTYBJkt74N2cdY+Dar9of+Cai37oHy8thx7Xz3HaDU3a/eM/np0LAj0wJdOODz14RInqEFQnIT0815gwTGsqMb6sSe7CHmtRumd94HS/iBtDUZqhGReil82O0TqAgc6NKyUdrIC2Ca+tfmLhGL221f+hd8wUtt95wH6/f6HNXnbeR+PSy2O/2Ozxa2a4gZzpBx/OCxxKxR05z87pgZq6jVyivr2HboD8ZgW+oPw3PRxBmGoUqTSAnJw8KfjYpv3KpnuTmCvkbqwULFbchDzOb4IbbOHP0mrq5M0fZZ2X9DimjPuZzRXpd+1fwhpwuGtmuq8hJ6A6IeCurph1t6OzmFQ205JFca21matUeWjl/arrOpvUN/OYz7SjjzGCr7gK7JASnFVjZFWUSGWZn1Dc9YOrFEjJqX490RsBKU9wHivoRdm8H6HcOltln1SClyF0x9OuKhWxVbdHCX1BWmjIhsn5rWgdpsGgkCcY3GYWkKIaBCG/T1Rm4/gf10Q5YBObIQU5JUQn5vJnbvzu8SGj1qltI++A0sI5iCX0IN4+6R3e+xCRWjCVrj2vXIITcVEjpBMXw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(136003)(346002)(376002)(396003)(366004)(8676002)(26005)(33656002)(478600001)(83380400001)(8936002)(6506007)(186003)(52536014)(4326008)(71200400001)(66446008)(64756008)(66556008)(66476007)(66946007)(2906002)(6916009)(7696005)(38100700001)(76116006)(9686003)(5660300002)(86362001)(55016002)(316002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UaDYdWtnLgfJXNWxQ49CNR25xmiqVv/ZoM68Lm8LRiSBtENgGQR+90zL4UNA?=
 =?us-ascii?Q?QW1mSYa2ndyUB9n9qzEeL0UjZ01xizT0qdCzKhOOgS5Wi1a40UZB3OlQDwi+?=
 =?us-ascii?Q?uDxzox8LQFxkGTthPDTshabMQjjth7X+yy6Sio/8NtXH/hfayA6aOrj0Frr6?=
 =?us-ascii?Q?+LH7q3TmS/z8CsIu9u6XfLDqfvJmR6dIOj2IM/oVUndFHqQgVz4w1BBDRUIa?=
 =?us-ascii?Q?BvNjuGGfE+aemsWHCB9pYxfsIsonouGKxSvlKqMdPYfJ4E78oHAdjLwgNQ1x?=
 =?us-ascii?Q?V79I5SdEXEa6Z26fI8iHRuwSpqI3ZRYMdszyms2ZSgOW4mybnLzUW0f8IZ1m?=
 =?us-ascii?Q?Lbj6yF7bS32xoV4AIyUCG4xn1IFCsU5yoP19dctfA7eMtbeR70wcGJaMqaKt?=
 =?us-ascii?Q?79a9VLDlHCM5wozEdTiw3YO9Epuv8Op3VFWe32diuDl50QNpmEM9oO+VbX3M?=
 =?us-ascii?Q?2rUDq0fPmLEqDYIVP6dEo9sTVL4ZRSClss/CjyjtL1XaU5J8bcKx3gL5hlqV?=
 =?us-ascii?Q?bRusSyhSSvVhlm69WoSOa5qnHd15XOljPI9/9hhQtPLPwQscgRpC3v1F4KZa?=
 =?us-ascii?Q?Qd4nBT+n8Q5aeQazEZEaM+ETQtZgSSi9AfkUwkbO28irqrVW5jhrZ+hVlkcd?=
 =?us-ascii?Q?qQqUB59PDB9CngMNg2RKkQc4PTevk1jfGD4gaXCn1tW/wimuJqFlm/G/fIvP?=
 =?us-ascii?Q?OKU2X1q5JNauxNp+onZz4uU3JtAk9f8t35s1GhlIlQJVTNbTQNH6kCgM4aeK?=
 =?us-ascii?Q?sblDNP/HVjfS/7RozWhKgkVBkn8IUMRR/td10RQkE9w8Gq+O5pXW80BmXeaw?=
 =?us-ascii?Q?zTAJ5eO0yrrbmltXso8TFxsobuRqLLW1P07Cfd4luGI/BPFRK489bkBX24E3?=
 =?us-ascii?Q?WBXKjhH0P03qXvkIZpZ0DIOS8mtrMiOcsMQAzX72ARbRRfSKRgTdbeq3dHJZ?=
 =?us-ascii?Q?zzKgjDnnIM+KORQj9vJ00fu1JS30TSArkqKq3yc9JXqvFhEY3V3zPq0Xj6Ic?=
 =?us-ascii?Q?p0fXfh1msHX4I0WpD+oTN8NKFUpi94OAGZvILKF8AwfgEynYggOAvx1VqjjA?=
 =?us-ascii?Q?EGmJQUlZzycGXvN7/DCrGKXujv6vv7V3yMz1qYVe45WfoyNNzzkUrJuCJUz+?=
 =?us-ascii?Q?a04xJySIT/J4whBAQGMAEX2XL0dLrr3BLzV+nDXJUZExOHZ43wu83QCU8u68?=
 =?us-ascii?Q?kGfqHtIDRm8efTjMmJpNDqE04I5x36EA1O2InBmdx//Q0v83/XKAjxTZTJX/?=
 =?us-ascii?Q?LZ3U+HrMNNHc1yeiSdEBDsC+QO0bHWK++XtIPgtknqrBcGrPiM4CQY1JooX6?=
 =?us-ascii?Q?6dUs4IXBw95Mu7pXqqZ7gsDU?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ec715b-d619-4ba6-edde-08d8eeecf1a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 17:47:50.5700 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pu0+bqwjKgMucdn8N1UhU1SVANb2gsTzSrY4pCe7+hfcJaG7TZYD0Sev4nlqMZDryVXZCaF42oMx1uMLiCXAO/BJ4LwdpvLLWSDVlNuavG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4861
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210324_174755_341258_142F70E9 
X-CRM114-Status: GOOD (  24.68  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
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

nvmet-tcp: enable optional queue idle period tracking

Add 'idle_poll_period_usecs' option used by io_work() to support
network devices enabled with advanced interrupt moderation
supporting a relaxed interrupt model. It was discovered that
such a NIC used on the target was unable to support initiator
connection establishment, caused by the existing io_work()
flow that immediately exits after a loop with no activity and
does not re-queue itself.

With this new option a queue is assigned a period of time
that no activity must occur in order to become 'idle'.  Until
the queue is idle the work item is requeued.

The new module option is defined as changeable making it
flexible for testing purposes.

The pre-existing legacy behavior is preserved when no module option
for idle_poll_period_usecs is specified.

Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
---
Changes from V3:
 - remove unnecessary added io_work() function variable 'requeue'.
 - instead of checking and clearing poll limits inside new function
   nvmet_tcp_check_queue_deadline, just make call to arm the poll
   limits before call to queue io_work during queue creation. The
   poll limits must be armed before any invocation of io_work() that
   is not as a result of an activity posting or interrupt, else the
   worker will prematurely exit.
---
Changes from V2:
 - pull the tracking code out of io_work() and into two support
   functions.
 - simplify io_work with single test made after process loop to
   determine if optional idle tracking is active or not.
 - the base logic of idle tracking used a condition to re-queue
   worker remains the same.
---
Changes from V1:
 - remove the accounting of time only spent within io_work() that
   was deducted from the assigned idle deadline time period.  This
   simplification improvement just requires the selection of a
   sufficient optional time period that will catch any non-idle
   activity to keep a queue active.
 - testing was performed with a NIC using standard HW interrupt mode, with
   and without the new module option enabled.  No measurable performance
   drop was seen when the patch wsa applied and the new option specified
   or not.  A side effect of a standard NIC using the new option
   will reduce the context switch rate.  We measured a drop from roughly
   90K to less than 300 (for 32 active connections).
 - For a NIC using a passive advanced interrupt moderation policy, it was
   then successfully able to achieve and maintain active connections with
   the target.
---
 drivers/nvme/target/tcp.c |   39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc1f0f647189..c44b34f0d46c 100644
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
+static int idle_poll_period_usecs;
+module_param(idle_poll_period_usecs, int, 0644);
+MODULE_PARM_DESC(idle_poll_period_usecs,
+		"nvmet tcp io_work poll till idle time period in usecs");
+
 #define NVMET_TCP_RECV_BUDGET		8
 #define NVMET_TCP_SEND_BUDGET		8
 #define NVMET_TCP_IO_WORK_BUDGET	64
@@ -119,6 +129,9 @@ struct nvmet_tcp_queue {
 	struct ahash_request	*snd_hash;
 	struct ahash_request	*rcv_hash;
 
+	unsigned long		poll_start;
+	unsigned long		poll_end;
+
 	spinlock_t		state_lock;
 	enum nvmet_tcp_queue_state state;
 
@@ -1198,6 +1211,25 @@ static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
 	spin_unlock(&queue->state_lock);
 }
 
+static inline void nvmet_tcp_arm_queue_deadline(struct nvmet_tcp_queue *queue)
+{
+	queue->poll_start = jiffies;
+	queue->poll_end = queue->poll_start +
+			usecs_to_jiffies(idle_poll_period_usecs);
+}
+
+static bool nvmet_tcp_check_queue_deadline(struct nvmet_tcp_queue *queue,
+		int ops)
+{
+	if (!idle_poll_period_usecs)
+		return false;
+
+	if (ops)
+		nvmet_tcp_arm_queue_deadline(queue);
+
+	return time_in_range(jiffies, queue->poll_start, queue->poll_end);
+}
+
 static void nvmet_tcp_io_work(struct work_struct *w)
 {
 	struct nvmet_tcp_queue *queue =
@@ -1223,9 +1255,10 @@ static void nvmet_tcp_io_work(struct work_struct *w)
 	} while (pending && ops < NVMET_TCP_IO_WORK_BUDGET);
 
 	/*
-	 * We exahusted our budget, requeue our selves
+	 * Requeue the worker if idle deadline period is in progress or any
+	 * ops activity was recorded during the do-while loop above.
 	 */
-	if (pending)
+	if (nvmet_tcp_check_queue_deadline(queue, ops) || pending)
 		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
 }
 
@@ -1525,6 +1558,8 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	if (ret)
 		goto out_destroy_sq;
 
+	if (idle_poll_period_usecs)
+		nvmet_tcp_arm_queue_deadline(queue);
 	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
 
 	return 0;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

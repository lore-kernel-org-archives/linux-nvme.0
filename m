Return-Path: <SRS0=yFSL=I5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5B2C433ED
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 21:39:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C91A60FE8
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Mar 2021 21:39:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C91A60FE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ACcSUC8Gbuw9LALyCi6oHjZM5yXQ3oUX8tN0/dakIqc=; b=AGg0KDT8y65bfMMZysTvhg+XCB
	+/gvyhdiF9fg9S7gJhbL4hUCRhZe56ULPAJrIWvOWLr6wYpM9svLOfK3PQHrOhp6UJGaQAD/eQMTk
	/Jp0LL/l+ZDM0EizkOMpU5sa90YG1QJN/M46Swj9KHe5QHl5izt3AEm/CS08cFJgBatmw9XBmsRcw
	OanxCJG44sqsAQv8vwXNyXcrRVdqWvsoDL+wR6YnuW+gXCt+uUPzjxk5983TSLH2OP2mhZWB7BvPb
	dlbbPurgnBILlG1vUKIZOq+4SpyIFr++uW7vHJ/xkEQmFye9V2Fr23YkBQjCadRT621zjWIF7xPlc
	4X32kzLA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRiY8-007ioz-7q; Wed, 31 Mar 2021 21:38:52 +0000
Received: from mga05.intel.com ([192.55.52.43])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRiXz-007ilG-VU
 for linux-nvme@lists.infradead.org; Wed, 31 Mar 2021 21:38:49 +0000
IronPort-SDR: g5XuW44Vi30WuwxZfc/mzWMrtg676KZuyM6dD58Tv4tDRANPLbAQPCqj+f5lC4iuWhF6VfmlNi
 gwTrPYEnmIdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="277278064"
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; d="scan'208";a="277278064"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2021 14:38:33 -0700
IronPort-SDR: gB1ZxFoxtMghA/nlNaW0LmumNgrYA8t/pN7lGq3yvC/I0pVKcFz4qyFk77CU//qMxTZKS89UdO
 PXV+grc8jWNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,295,1610438400"; d="scan'208";a="445823290"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by FMSMGA003.fm.intel.com with ESMTP; 31 Mar 2021 14:38:32 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 31 Mar 2021 14:38:32 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 31 Mar 2021 14:38:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 31 Mar 2021 14:38:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAvu0MmUbajBztUFO4fB6ryDxLTG7NJezFuFTdbK0bxu/BTRN8+/ZM1hZZVIkdT8odQjo6mnh3s4lqkn4sSiWnZICWQbmpkWN6TAe2l8ouFikAIrm3rs0YW4qNnht9oPhcKz9Ix13NbSJJ3hMMY9djq0UwEKTDG+erThoiGCIZb/1XYVipUy3wcSooBntgkLR1VUfGMqo2gKsMkQRT4utHQXkik3Fwu6sC7bCyQR9FPx95nmLw9oEhwb1MIrvGxkjp0R7aZ3NXANWrOI4JUKCUQfeDrQAg2JSR7a4jf1hdEFz1ruSDtl9vIA5f2VWKHVJg28CU+/VYXsjIeTkqxzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT3ucqLPP851NtUtJDQbZTNH8XQogEuX+ypviuuNZmo=;
 b=hB1MhgRb3iD1FA0xMxcH9GiaMaXiWiY2ER3H0eVDgKBc+9+nUG17tGo9a1/rHddunAWc+J92MgKP5UVBesIciEkZX2oe0lG2cnQcsFNEROMmCD2v0mWeVV0F/AKIVh6Y/fGSBspiDMDMWD7+lPH9VaPasTCNpVe0+wdRd6MXIycdFzany2FmDvh/xtLpfGLNB8P2a1Amx7EwsZ4z4RS9HwbZ/OCgfdm++eFkEZtqlonKf6WuTPqeaEXZAUz8dXaYcA4tIpbhszgQMPlcWr+P8ROhp7ad/CUSIS0L21SS2x8fN7UZyInQyDLSeK5B0dVJATTglLaFb78wKB8cDMbMSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT3ucqLPP851NtUtJDQbZTNH8XQogEuX+ypviuuNZmo=;
 b=oTM41HRgzIDjbr6u80ge8qQs2blzc6dCf58ojAU9oUQK6okxcCM5QkDfUBDF324Qqg20MUqa3KbV297WWE8mL8Z5hjJatfNbYFA1Ee5c5JYhdqN1dcpXOIqFbkGpknlZD0b5I+yERWmTGckBj0QtIEhiVC40clirtWc98GAWaY8=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by SJ0PR11MB5120.namprd11.prod.outlook.com (2603:10b6:a03:2d1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 31 Mar
 2021 21:38:30 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::9446:b8f4:d289:b20e]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::9446:b8f4:d289:b20e%6]) with mapi id 15.20.3977.033; Wed, 31 Mar 2021
 21:38:30 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH V5] nvmet-tcp: enable optional queue idle period tracking 
Thread-Topic: [PATCH V5] nvmet-tcp: enable optional queue idle period tracking
Thread-Index: AdcmdZ7ku+WT+NJoT9+9OG+AtEtgGg==
Date: Wed, 31 Mar 2021 21:38:30 +0000
Message-ID: <BYAPR11MB28695D512EFF1D501BF407F2E57C9@BYAPR11MB2869.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 103d5526-9eeb-44cb-58e7-08d8f48d53e9
x-ms-traffictypediagnostic: SJ0PR11MB5120:
x-microsoft-antispam-prvs: <SJ0PR11MB5120D76E2B9805D0704A99FEE57C9@SJ0PR11MB5120.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BEXymdklPISSthT82bChA2T6Go78jprTKuli+fu1Jw35UGuga1U82TquaV6l4jELwmluUWMPXgVZ0bvi2eexfYAMPhSmE/LhjpGKsT8U0FRgSIOCHsSkzBhFxsxIFPHx2slmf83UvnfJwJxHLog1Q2hoiVQPhhhhcExzoZCXvAqWLl9rTgQI0SAFThjgzsr7tk5XqOwk+iCyoBOeUeqQVx2Ck6RTBq6Nad2gA4xXauildixMGoobHG7wnJ5mOCToZxrlxR0pYH8AV9ydSNVXj6nHgGk80VdUA9MZ6xCYLGs769B8LzGbfuoRb4pd+Ftajk7kAZHslWGiRJxpTl02A4vI677eF8rkafbHf6D+uYYNnNgA7Uxo4z8bXExjbBOWCKoQ53VroJ87U4zSnhP/V0jbdDkvVpzmpo8zfoPwdw9M+2raiNKiXWT47X/rdf6ycqr8JWS/yq3MXU/UJEq3QiFjLPkkVx/I/VbWkMR9n0LQyrdqIiCFei7uEKCSfvsRS94Gdo2e+tV1ZPJfaI8bamo1hSkMVKtQvyTFRmJs/LSNuYTAntkbZ8g11HBZNIeFnrAeajat2rohYw31aoadGx+5OzutCTJB/lnJajkx3Bot2Rk25OiI4seOb/2iUDzFyL4nr0tRUfn195FL6oTVfgopyecI3ZMtSVkWFPr1zlY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(39860400002)(376002)(136003)(366004)(396003)(346002)(6506007)(64756008)(66946007)(76116006)(66446008)(2906002)(66556008)(66476007)(71200400001)(26005)(4743002)(186003)(38100700001)(4326008)(8676002)(316002)(478600001)(5660300002)(6916009)(7696005)(8936002)(83380400001)(86362001)(55016002)(52536014)(9686003)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Z3os6QdCzr8dl9WuzdCkZPbJRe6qe4hGvih+bRraoiimsAjZZ2ViX/RXX3Md?=
 =?us-ascii?Q?n1eOOhDZDgbgSBnbxjmJh2qlXaP5HtMSJ7XomiZxdIuJuTCerDwrfob2oksp?=
 =?us-ascii?Q?BSMKBoO6Io80Qe/PANz7DAQ87y06S6hY4wF2viTU0epy7oq9viMriEo4xtDL?=
 =?us-ascii?Q?WJJVkdPNxT3wlS+mu4pUZdPClUuEGkgnU6MknM7TG8SL1u7iPT39YX8bA7DY?=
 =?us-ascii?Q?+e5z/t+59hhojytt8Z0lddTl9ag9pgAXceeqlLQdKbJSxmUS6vRNS7MT7KaL?=
 =?us-ascii?Q?kIIxlRUlLqC/g1CFvg3Ly1arbKhzyuMb/m4JZB25oTtebWb4acxvUJ3oLpLq?=
 =?us-ascii?Q?Z0uy3/vcfXxMJkIM0dlaHpeBH0SBMxiZlkf/h531lACfG+0WVALLrJIus8jn?=
 =?us-ascii?Q?xSJ5e/cOwB0vStbCqY2e58icrz2ezk9kYNEMp59fO6P99zMxtCCNhH+jdl6i?=
 =?us-ascii?Q?BDkoopuYiIvPfRXngkhATkr0DsOdotKlGkqjAidimDiU3tQpa0Xg2uVplZsN?=
 =?us-ascii?Q?ko+ADlgn4luEijOoW7E0EzRlPc4wMvttan45mLFwMjTiEH4BWHQSpNY/Qcy2?=
 =?us-ascii?Q?2D7+bmphiWlxq5jMUeupkD/nZuXpFkCrvAFiGyyDfwrholPs+ffMJHhov5HM?=
 =?us-ascii?Q?FXHpZpsfN5sgXXXXJlxlUFI5qr6p5FJSUxy1OrLI62ZPt8duaA5cfTDgO1gW?=
 =?us-ascii?Q?VkIEZEk5BUqt8vHGTOhmgdfkkd3KKp2TwDJfd0vodkOX/YkPLdnGQm8ax67j?=
 =?us-ascii?Q?7gyA0ciZCdhw6q+hqFOgZrFvPTh8zyFq2l6CVHbw/wfbaCZXQP53dvdsgADk?=
 =?us-ascii?Q?PpTCSyrLNNBmQsXW/XBGXfiIfyUpkVTHhDwKg9oy+3igtCNLZPr8YSbVv5eE?=
 =?us-ascii?Q?iSrez9g2hLoC2pEMZgKYCzb/p9+R/XfRka4zY5dRsG8Abb3IFwW1YbwnxOQz?=
 =?us-ascii?Q?RrQ+K8X/0RNkPDrysJ8YRGF9KtQT7ZhNvSDvD5BH4Jr6XwwVaSOPjOYQ536m?=
 =?us-ascii?Q?J/l3ITFcTQo7gckchtGsqZm9OvB5zQz/mBuBIELKoInmwRvhZ1/pvjw68YyZ?=
 =?us-ascii?Q?aH0Al+//aUfoQqck0jlMV4P3ekYWN4qFDj1rMBHxuu0A9UJHZT3K9rrd3lu3?=
 =?us-ascii?Q?7GI7GCk8CzRixRZLueTov6G5Kea4qHMOBpcRLpZo4oXiEQLRrT1TUdmfltA3?=
 =?us-ascii?Q?uKfNwtEWPkCwdj1xByl3sCaUlV76GALHOnMvoLcDJ2EDJr9FzXTR0OlWcgA4?=
 =?us-ascii?Q?Tbn4bnKVn92Ob3W8zokS/ubfEXUQulCMWFevdm8iSMCHSJM/eSbRo99vhCPq?=
 =?us-ascii?Q?dLKP/lDr0NXRymhAc+BHlf3L?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 103d5526-9eeb-44cb-58e7-08d8f48d53e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 21:38:30.6943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qRXGzEejxKYpPXPHc3dkdHzUT3IA7M42W3xpEoBK3yEkvxpMdzdo5UKateFeuyjKtekPx2pgk+gx+aX/YTfN6LBMGXC2bp8FaoYZ1dDzTm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5120
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210331_223845_130745_C1C23C90 
X-CRM114-Status: GOOD (  24.12  )
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
Changes from V4:
 - simplified to use time_after and single poll_end time value
   instead of time_in_range and maintaining the pair of time values.
 - merge with latest branch 5.13
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
 drivers/nvme/target/tcp.c |   36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8b0485ada315..bba5b86ba5a9 100644
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
@@ -119,6 +129,8 @@ struct nvmet_tcp_queue {
 	struct ahash_request	*snd_hash;
 	struct ahash_request	*rcv_hash;
 
+	unsigned long           poll_end;
+
 	spinlock_t		state_lock;
 	enum nvmet_tcp_queue_state state;
 
@@ -1216,6 +1228,23 @@ static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
 	spin_unlock(&queue->state_lock);
 }
 
+static inline void nvmet_tcp_arm_queue_deadline(struct nvmet_tcp_queue *queue)
+{
+	queue->poll_end = jiffies + usecs_to_jiffies(idle_poll_period_usecs);
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
+	return !time_after(jiffies, queue->poll_end);
+}
+
 static void nvmet_tcp_io_work(struct work_struct *w)
 {
 	struct nvmet_tcp_queue *queue =
@@ -1241,9 +1270,10 @@ static void nvmet_tcp_io_work(struct work_struct *w)
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
 
@@ -1501,6 +1531,8 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 		sock->sk->sk_state_change = nvmet_tcp_state_change;
 		queue->write_space = sock->sk->sk_write_space;
 		sock->sk->sk_write_space = nvmet_tcp_write_space;
+		if (idle_poll_period_usecs)
+			nvmet_tcp_arm_queue_deadline(queue);
 		queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &queue->io_work);
 	}
 	write_unlock_bh(&sock->sk->sk_callback_lock);

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

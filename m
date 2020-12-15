Return-Path: <SRS0=/AMA=FT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E396C4361B
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 18:31:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4079227C3
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Dec 2020 18:31:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4079227C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GvY1a4+725SRavd21G6BvFquiyNOE3CBsOpWgyGXt9E=; b=FUvU0RrBKM5oqpsi2Sm0hj8zs
	aWpUaZAyZYNr8pXv9tyVC3CXxBKrQFfzMhgzZmbb/hkQsUmv25iTmaS7Sk6T5fGnvalX5DxEAoJR+
	FJSbCYb1gLAggaBVWzDZgam75joJ/hGazVSyBCLSB7O0OojncPxBJqxSRmQ1haBJsdNGE75M3sOhx
	EFGBhsePriZkdouXPzGK/2c+L6f/TInykvviw/LcqMoGIpiYFospHgaFQO3BvqYFG6SJEheH7vMDs
	ZyXWtF3g60lM3vrFZeQXIYjv+VRkM+qEm2Va0A19R8xjgNzJPOpj7eyaapGYR8Rt3gNxSjlf8GhKn
	bVOIG+R8g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpF6B-0005nn-Ra; Tue, 15 Dec 2020 18:30:59 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpF68-0005nK-BJ
 for linux-nvme@lists.infradead.org; Tue, 15 Dec 2020 18:30:57 +0000
IronPort-SDR: tMcZ7pATSZnQmfrCnp8GR+yNtMMpjQ/dVYU5d3ntKubQXtcshZ3vmY9Mlootn2iuvXXHy5mPRJ
 zJKd2kXZqwrw==
X-IronPort-AV: E=McAfee;i="6000,8403,9836"; a="236510593"
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; d="scan'208";a="236510593"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Dec 2020 10:30:52 -0800
IronPort-SDR: p+9jviGPs/sActTfUKCjSnYOwNGJ2ZBxk2qWIDJebKDM0JUj/iG93UHp9i7ejkOAHQurQ0pfNg
 PIbkalUhc9Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,422,1599548400"; d="scan'208";a="451307152"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
 by fmsmga001.fm.intel.com with ESMTP; 15 Dec 2020 10:30:51 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 15 Dec 2020 10:30:51 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 15 Dec 2020 10:30:51 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 15 Dec 2020 10:30:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYYIlz5XfcZM9caP6c65tkrlCR2aps1sDen1xRACC3JPj7mjzu03Ll5wBJH36vlgK0lErKIphQHIscbLyugtGKObfLtQTN7QW/rR+VWtqo4TK7SPgcLIRmKyeYYQVnwFmk/vV6QY0hDDUPexjEb6Z+cZRDFOcteTmA8nrTlaMaaqgF5pcfqv8SNMnH1eT4IVQDvxpzGDFcDwhsiszgnwYhnfxAtzR166Vphtr0ZnY980gBWjgnUd5VSNZ4OxXRoUt9YAW7bldSBxaCQeUyROMTn4LrDTvNbakJ7iy36mMV7txx5mzRYqZrpydJ2lEuwn45xX4lU8yMBCDjgrWa5/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6mzkr0psGHkNxu3DNQMvbydKZjxhcA4W6BRmKbYgD8=;
 b=TFuxulfrQ+FO3XYKAROwdeXf5V0V70yXR863BtzQ9y60nyABGipxnB7rnUlLJKGbKX49H80UEZK3g7k4CcgQDzz4pECv5YjQzPKlUBszFQcw1jRZ9NgcBSgBwJRsuqQjtQ7LcrdDC/1nX+lUzmDPduAmNVH0NU6Yd+Mhc+hpFXGWm5N18bEIpmRZmqQW7S3ACCxNpUMVS9ymFalnAmySB8bQI9wjBNolyinsTiap3cfyXp8WHPZSFcWYQh3FiSh0aObS8RORTdHT3v+Tl0P5tA4lK6CIM1THtX4sGNmSQR1uiThELmEtjyHtoViBg6irEmy+uDZxFxbvXM5y64328g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6mzkr0psGHkNxu3DNQMvbydKZjxhcA4W6BRmKbYgD8=;
 b=AZgrUliI8w1juYnvNO4F/VWE4RD076/do6ulGKAocGU862XVXGbIZ34/1I3pnlpoc3HidcoMWToRwlW9FklmFSRquunPQoPKkHpj+AeTKs6giQUCyI1e1m+iHtUVtq5eRC4ExAGCSCoS5+qMGvgeyYzaw0ktl5U0GO4EY5HjUCc=
Received: from BYAPR11MB2869.namprd11.prod.outlook.com (2603:10b6:a02:c0::15)
 by BYAPR11MB2647.namprd11.prod.outlook.com (2603:10b6:a02:be::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.26; Tue, 15 Dec
 2020 18:30:49 +0000
Received: from BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::b47b:94af:71b8:63c9]) by BYAPR11MB2869.namprd11.prod.outlook.com
 ([fe80::b47b:94af:71b8:63c9%5]) with mapi id 15.20.3654.025; Tue, 15 Dec 2020
 18:30:49 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, Potnuri Bharat Teja <bharat@chelsio.com>
Subject: RE: Request timeout seen with NVMEoF TCP
Thread-Topic: Request timeout seen with NVMEoF TCP
Thread-Index: AQHWzlAXYH2cnFU/502idFqudV31nKnvDmuAgAGCpICAAE5YgIAAodiAgAVlnwCAAIa/AIABArfg
Date: Tue, 15 Dec 2020 18:30:49 +0000
Message-ID: <BYAPR11MB2869100E0BA40ACB0CDDEFB0E5C60@BYAPR11MB2869.namprd11.prod.outlook.com>
References: <X9EHFnhujZo175Kw@chelsio.com>
 <0fc0166c-a65f-125f-4305-d0cb761336ac@grimberg.me>
 <X9JVp9mjtC1p0iLS@chelsio.com>
 <3e7aa593-16b0-3bbd-f918-caffa6f5b20b@grimberg.me>
 <X9MfI872AfM+WMV/@chelsio.com>
 <dbb14893-da35-2f7e-0583-c33ce9f41243@grimberg.me>
 <a204cb8e-6f3b-b5dc-9972-54651c9c75cc@grimberg.me>
In-Reply-To: <a204cb8e-6f3b-b5dc-9972-54651c9c75cc@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=intel.com;
x-originating-ip: [71.238.29.134]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f637881e-b39f-4603-fff3-08d8a1278c16
x-ms-traffictypediagnostic: BYAPR11MB2647:
x-microsoft-antispam-prvs: <BYAPR11MB264717CCC2A3E7EC11B52A8DE5C60@BYAPR11MB2647.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wq56csGwvg9c5R5uk3BqAWFDEREzA5O76/xth4BHZGFyA48OULRZ6Ypbhvi6JeGeKY7O1h87cADEPJM9p+O3jGC/1u2rcdaSEAWWWTJcwnOBvRmSuCItid60Hqb2l7YxPAQdf+QBCVdKbrXN2Ne3c94RQmJgHeuST3DUVLQ/mAGbnA0tbfAH4j9Jz2vzYWZHMlsVVox0N2E466Uc0oDk7t1E4M5qLttoO7eSRDveR6CjnGY4A0rmw9HSf94aWy3Ykl37lVCNUkiUg/p6RnxHqJSqvHKbXYCTm5HZNCvtBPWOuB9BETz/ToFkgZkYWlG/VpbnNJpojXCspc+dz8YFCw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR11MB2869.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(76116006)(498600001)(33656002)(66946007)(64756008)(66556008)(52536014)(66446008)(26005)(83380400001)(9686003)(4326008)(66476007)(8936002)(5660300002)(54906003)(110136005)(55016002)(7696005)(71200400001)(6506007)(186003)(8676002)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?co4k3G8Lwv/pl6sjYuF5aYoc/TVk8pqDjh6PZqdQYGJSJQt2hTQ1OeddTDr4?=
 =?us-ascii?Q?qkhf+kRVyxijXY5gnAq9ory9Rr7U3BKYOfu/2VO+XnNhBN0hvpNsbkYiUV/M?=
 =?us-ascii?Q?NjWgqsuFnCK4fYQCFX+lhQwA0P0OqnlbmxINvcafyUywhFGn0ojGE6HADGT3?=
 =?us-ascii?Q?9tcNLsiJGKkvubkKlSsRS7On6I2Vuh2BfOfSie2HG7gSTdYIa81RcOVKR+H1?=
 =?us-ascii?Q?OE4i4gmTbe7+I9/nz2tyDFjadyj4yqQoVZcsiv1BAHBMNUTpGqwnQbCCNPXY?=
 =?us-ascii?Q?o5mf3cKFESjaaG3xHU1F04T47obyTnL+s3H1z4ecby3PHxi1a3qG6BF5T6h7?=
 =?us-ascii?Q?vQaWFlERRvAA4jvAEhVE9d/SmcKNd9ymp7n6Vs6llsYq5QThp/RcZ2IpPhq6?=
 =?us-ascii?Q?wqZxDMTtkNmCdKSJrm8WpZFqanEGRBbLx1l6eGHDT3rIHEDpZMdL8YaIZbpE?=
 =?us-ascii?Q?Gg1tfr4BdmnBvv/1Zzl3Cs9uNuQH+8+Mdq80D9AOJrhJxrM7ebIyPUcgNHf6?=
 =?us-ascii?Q?pjDsH9NfwXMwOjDx6kN+dGz449V17BqLTMm6dcYOIiymcXx5UGBIm1FLMau1?=
 =?us-ascii?Q?TEd+ls+Bclj8aI6n3QJlwlPpGh/+6NH5Vb6CgYeVwP38vK+PLdleZfslFTfg?=
 =?us-ascii?Q?WccoyP4kaJiTTPJP1JTPOOZ+ApWbCOdTfurhJTANoHNw8XPDObD3L/TN05l9?=
 =?us-ascii?Q?O5FcQHKQ+Z01EDr2lUveEPo6ETZx6J1X5Pl8CidGgmvTOK1FOqcjIXP2GuV/?=
 =?us-ascii?Q?WIvGGUor49OxkyK5LRLrm3s4WQD31bOP4PBY1kO8/0fGQrEWiKXNZfmd28IZ?=
 =?us-ascii?Q?AdC2eEVuUiOiVy0iJNxgNxgj4HQ2m8rdUbtVogAqX8n0I1pEVDxu4REIW4Kg?=
 =?us-ascii?Q?ZSMBtD0SsS0jPLnZDz0qxSKyiuAF/g/sb2Q7zVIewHZxKSAnO2Z+uBLktiqv?=
 =?us-ascii?Q?2tln5AzYrBxiTy8dCozmqm67qmfxdouZRGevgGBPYts=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f637881e-b39f-4603-fff3-08d8a1278c16
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2020 18:30:49.7600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oueqhk5KF7SwrEjQW7YT1KiYal8infdW8/v1rIHU6MAAm4hNvk/zUKel2a4DIbUgWGWdKnziicW78a7lj8Iqa1OaXiVsc969/S0tL87qvIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2647
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201215_133056_850909_275F003C 
X-CRM114-Status: GOOD (  12.84  )
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
Cc: Samuel Jones <sjones@kalrayinc.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> I think we still have a race here with the following:
> 1. queue_rq sends h2cdata PDU (no data)
> 2. host receives r2t - prepares data PDU to send and schedules io_work 3. queue_rq sends another h2cdata PDU - ends up sending (2) because it was queued before it 4. io_work starts, loops but never able to acquire > the send_mutex - eventually just ends (dosn't requeue) 5. (3) completes, now nothing will send (2)

> We can either schedule the io_work from the direct send path, but that is less efficient than just trying to drain the send queue in the direct send path and if not all was sent, the write_space callback will trigger it.

Wouldn't the addition of the change to io_work() itself result in step (4) above never occurring?  Pending always being set if mutex can not be acquired, and if io_work() then exceeds time period it always re-queues itself.  So io_work() should always end up draining any send list eventually.  Unless io_work() exits early for some reason via the try_recv (ret < 0) return point without requeuing.

Or, can there be a case where there are sends through queue_rq where 'last' is false (and inline send conditions fail), but there is no subsequent send with 'last' true to schedule io_work()?  Might try changing queue_request() to always queue io_work() if inline send fails (not looking at last.  And add the second part of your patch for io_work() to set pending to true.  Also trap if ret<0 case above ever happens (or do break instead of return).  Re-run and see if failure still occurs.  Just a thought.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

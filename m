Return-Path: <SRS0=q7uG=KO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E03BC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 04:46:35 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9A961019
	for <linux-nvme@archiver.kernel.org>; Wed, 19 May 2021 04:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9A961019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:Message-ID:Date:
	Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+2aU3sP1bTkUa/tqBzQeUFOUydRmXdKv1cWPf4NOk/k=; b=Bx02byq28ivkzbMvms5hiVRuB
	/VnzxwSeuQX0kNSjo6ABNQPTcWGF26YXXwi11e2tjWZrvBKfnXg6gapbYmzSG0bMV023414DD+CTZ
	0bccM6lftK6ySGp7hkvnoY22HCDgt8NQY0PXkmqZ/NUelTviZYC5L12sTfgGtOyop7sPTB+55lo0j
	8OZraV3AU7dxBqTA409FaRGdqf0PsJlN0Wry2eBnydeIncsdiSFD/tPEOPuSd8PU2wQIk5PDp+a5e
	YNrtL2FbXiOeYo8UnSYe+VJbAARg06ils3DZGYz32MJkToZx3YsgNLddwNAZx10lLihDCoDZpFCmp
	jp5Kn+IjA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljE5y-002luJ-GB; Wed, 19 May 2021 04:46:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljE5u-002ltq-6f
 for linux-nvme@desiato.infradead.org; Wed, 19 May 2021 04:46:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
 :Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description;
 bh=h46ujjbY6YejRYLW3PeYupvXuRYA3EvMlgJDbfy7KaA=; b=Mx7seGr/7Uv8W0H82xcvpKTSY7
 T/iIQGqqg27UoDtMZgYfhc8MJmSCy2x/Wu91T/QRB1fsZoXhohaqsUqAZSBh+Jn9MyhxCAZyAqhZk
 CRzV6Yle/Xs4d9FtqOb9/GbwC7in4061gbvGRcnb9bfh2aW2tR0BYAjeI/LZcUIVA8V6arnZQ9lcd
 bg1lENv9zuVVN3v2MWomIfbjagiqo0Zr5wsHg0bQ5tR/P5MDeS0haQshYwOwkgFxCh6eEHa5xHSAV
 s9aSUZz2durZryT7W3bfgZ22wFW8V555j5V0+n+H8SGPIPsPSzUKv/cX1LuOIQq9pDAzUbBt3/8k2
 9MAgDcHw==;
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljE5q-00F7vp-Pi
 for linux-nvme@lists.infradead.org; Wed, 19 May 2021 04:46:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621399560; x=1652935560;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=h46ujjbY6YejRYLW3PeYupvXuRYA3EvMlgJDbfy7KaA=;
 b=IBL/EBYTVHg8yZsuiASIyj3FwEW3JL+GZcQHR20Yc/4bexfTlHFI7vDd
 xBi8xGDm+hjzFZgJ7tWIdTb5RoR6W/VVdO22a4wRMq5ubfYXqSEHAB/P2
 sZSIxfnQD2x7FnjO4Usbrwa4EVcNWHc5YfMC8STDL2D4CqKKcF7pMnYEL
 7s/REyEA4dcvwKK6n8FM0pui6EFEhpE21yzTXUdpe6hWFO4rnLLl2MXPV
 +6uegEaaEi0K19GzkQ52juFdwvigPoIl0oREJyXc7XzlQkluYmXYAW8Fb
 pStv1No90ZfALjIs2nBRhdpMe1H/KCjpSubDvnF6Sw0JCHw7ammnN2qOq g==;
IronPort-SDR: daAd3XEDelHUbDZlJiHSuUYBtHrg5+loRlums9F2mx4bBnpz8ism3Skff4JctNYtp/mGPIJQVS
 f/5m3G0WG9dklvOHlIxd18GROtr7Izqvy4SObPDI/Y2DKlASFSdu5+f+AYvzxjLH7CMul4dD1T
 6ffkcE5CCxvffdK/Kg7uFNKOL+NxbEMD+d1xsjDzuVO15hGjjcaiMBJUSQQY9lTGGWa1RW+pWG
 cMmf1ZB+6fJ6T1dSyDMGSfV4xN0/PEEqHNSBKaKuIda2CZGD2e2NhIMmOduAu3TYitMZgTkjH0
 Cq4=
X-IronPort-AV: E=Sophos;i="5.82,311,1613404800"; d="scan'208";a="168658434"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
 by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 12:45:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqbaWRALU1bCTDvp5QHzr1IoJkUAl2N3I7sm92/cxAiWfUCBTX2JHmhYmYEnwNMr8cdrLaUC1t+tdTI15St7+zGIm7M5ZiJhMoaww1eUQ3DVrEqDiEEZGuvhWN8JlHU5zDUbfiwxBT+B81TGl39Tf7PzXB0E9RIghQ9xZkwYYmMZp00IuI6IlbcIXVrWdGWgcvbHntubJrpATiZT1V068Y+Q3pRq2gCrnuhCcamMvZNR607YV5gtPxzcCpZw2MEPBi32wIexJwPyLiHUk19F+JLG7lLIFdJjcVn/xCAKfem54tjEGVrnCep080lTYoZI2ZkQTV/MowA8giZCkGQYjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h46ujjbY6YejRYLW3PeYupvXuRYA3EvMlgJDbfy7KaA=;
 b=BOJKc4UHUmofnWeihMDcr3d9nf2XaAqirP0YjPxqhS+q1BV9bcJyh5JKfDNkdpb4SFa4LfeiD9IS0th8E1XTP6NjsylbkcQPcYL6DiB2D+dE/MLGNRZbT66rMoFeV5OFICPCmYVNPtsaBOpHfnZO4jJ94XmJSYnfyH3xkNAuhEacsQoyjq9LuPNNoAlwiJxAqhGd0DEjrchY7BSTMK5gr33an8XaRV6b7bJhg0ndv0KOuaP8LC21kWfA6mPGuk+/s7q3RGaeNx9rulzzte9OfAMdqmgYxlm98HvBCP0vCFjxtVvbuiAUABeZO4seaIUIJicpdyTRO3iUR6oTZBaV3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h46ujjbY6YejRYLW3PeYupvXuRYA3EvMlgJDbfy7KaA=;
 b=nJXzPsTGg9ykVXkRnnTJwaOKCzkoLso+xwwR4TLSeBYLqvSs9fDbyzfdg+kDKnIVt8vqP6a1Y7WR53xN2XfZbpbSgfLh+RUL5cEM5WvuO+bRLa4H++piY3rD7O/Isbd2dOKCIjLMBCCqov7UtVSf6lPawAssg0xO9FZ6FthR+6U=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5253.namprd04.prod.outlook.com (2603:10b6:a03:cd::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Wed, 19 May
 2021 04:45:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 04:45:57 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Wu Bo <wubo40@huawei.com>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "amit.engel@dell.com"
 <amit.engel@dell.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linfeilong@huawei.com"
 <linfeilong@huawei.com>
Subject: Re: [PATCH 1/2] nvmet: Fix memory leak in nvmet_alloc_ctrl()
Thread-Topic: [PATCH 1/2] nvmet: Fix memory leak in nvmet_alloc_ctrl()
Thread-Index: AQHXTGhkdZ2w3QoTd06CAbpkG6pMrarqOuY6
Date: Wed, 19 May 2021 04:45:57 +0000
Message-ID: <3313123B-37B5-4611-9738-D9CB32CA5657@wdc.com>
References: <1621400470-593256-1-git-send-email-wubo40@huawei.com>,
 <1621400470-593256-2-git-send-email-wubo40@huawei.com>
In-Reply-To: <1621400470-593256-2-git-send-email-wubo40@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [70.175.137.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c1fd219-e058-4567-1991-08d91a80fe4f
x-ms-traffictypediagnostic: BYAPR04MB5253:
x-microsoft-antispam-prvs: <BYAPR04MB52537B16048E510BEAAB171A862B9@BYAPR04MB5253.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:390;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3AITc/0LztrI496sj/QCfKOD7XlHjzAQYVWTFaqbkDiIqZqY1ZBZTdJbNoJgWqq8J5Iea9gaarnZ8QDMQrSLDXKTFKKgJweBN1+wIGX5+fSD78mFe5cVmCHJVf5b8UQ292bCHWKL1DKyiNN3YvpBf14QN1fZ1aijPHdJ/oPr/NLVVDvmGNpMcI2itDvURKl+6yjHAU+4mUgkGqJzryGdWCu6fR2VJqsAmVF985xI55+eqA6MO3HSUFC8WPZiWibTKHaZAZswo1q8RYzPKlbj0VPuy8vK5sod7i6/Ber7+pB8sZ3Pz+fyy/HmULYDBeiHCLnCamaB9XD5Lvqf+vxgdZJpIoPXpUTfTrogyIs9RPBHyKeUn4Oas2lpy5pcw+GvkyB79WMZ7Y0PpCk99DN1chRz+gCwHK/4Gefc+VAt59xXkgdNYm8B3qfO3rNKXlf7vO6F3x0VT60aRUnDuowGkgY3Cf0WVjnkdOq5JkoSedTBdTJ1LARsE2wD4oZcoDhLzhKqKqAi6eGAeJbtsu5Sh1KItVOUtF0uqhvCI8EzPJJ9ZUxoyZPqaVd4A4w1lZDvNeiiMZwwF7tOUEUasksnbSsBLIs0dj1c++4CbfjAq+BADfH0sGHAwRsXoyXZGWGpXAPA/9PocE6gNBEfQp69nIMF7XJsEfyULRFOpP1nk/A=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(66556008)(66946007)(6916009)(66476007)(66446008)(64756008)(6512007)(38100700002)(76116006)(6486002)(2906002)(83380400001)(2616005)(8936002)(122000001)(26005)(186003)(71200400001)(558084003)(86362001)(478600001)(8676002)(4326008)(36756003)(316002)(54906003)(6506007)(5660300002)(53546011)(33656002)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tUij4779j/odmbR2DBMqH3WKtlUUvlj3586jH1QjaQv9RJwpHIhn2FkEgjBZ?=
 =?us-ascii?Q?nX/z7ZTpTNo3qcArSRPABLVc93xbJAy+LMhc4aPPAB6Fvaf5RUC3E5MttNmQ?=
 =?us-ascii?Q?Wfoa7B5kjDGv1OuPqJD3VN/DNzAIc0qdcKkRS0WGHnMcLasGSGscNVWGrO/d?=
 =?us-ascii?Q?Y8W+0BFRlwtWY/halqiaf9uG2WA/b7AoHJgZQYNPlh+cSedF8/LNUqL4dNHa?=
 =?us-ascii?Q?7vrigEp3/NOkLsZAawVKn2iNMGTrFyaUWN3z4JsJAW2qHzb6s3GkSnOmbEes?=
 =?us-ascii?Q?iX13qv2g5o5DrsrlhQss2RBtnWBMQXNHEdgHuHNxjPl7YWbDPU7QRfuFJdWW?=
 =?us-ascii?Q?AcU65IX7rmvKiRtzhozpBbQGGjw8VIMAQsNvrrUdStrAkg9d+cuec+23xEQg?=
 =?us-ascii?Q?8fsX14OVpyU8JiRRHMrKaRoJ0p/4+6N7X/Xwnn9w5ZNQABpdSq94VZCkzik1?=
 =?us-ascii?Q?OH5T8Dpay5f7ElkmUrhz2aZGeRRXm/826ir8HCoGml37Tp54QXAyOWSFHQYb?=
 =?us-ascii?Q?Qj/sgBJY/FdRUwA/c4En5HxevqjN/eNT7iuVIrFaf9KSdXxsFPGmtJDHfvXJ?=
 =?us-ascii?Q?ImNj+47ogCwjQQYzhjMwfrSLBu3SgPCCeZkd7Z59ADWoLGi6mWzWb2/FT0k0?=
 =?us-ascii?Q?PNrP9Rny2oZorIGoPonY5NbZ0DvZPuy/SAhSZIsQVlfKrGovfnMwf1W0tiI2?=
 =?us-ascii?Q?EY4rLi3awhq2ORRewYnI1OWltTGsgNp1WTvHlrlgXBDNOfixGCa1OXz3gHtH?=
 =?us-ascii?Q?5gEbqjhYCkE9xcxaDN1aB6Gjzyt5cRaCkG9MbmIA3LQK0TvaNLVvQdHOMpCO?=
 =?us-ascii?Q?e3vn6PvgfoQIa4/l+mqwDwEFlV3GWViwikBykG1VOD9xlnIHBnaqTRyaoV93?=
 =?us-ascii?Q?GtjwnvcMXABkhT0ie6bMIHu52Jl09ksiAvIywzYrXDOHmJYbpxWwJyfKv2Po?=
 =?us-ascii?Q?Yyp5ZOorikBHseM/YPN8kop/rKvdKwOahsTtsDzXc+DVGgY/ta8FlxFa+YRW?=
 =?us-ascii?Q?P8UKK9TPwZ2NCE2ln99w4mcP+30ck6YhJFtgFY5kZaWRqtpXPKS6iaHeIzLd?=
 =?us-ascii?Q?Ud0JJBUcvNgLz5FeKPkJ7Gs+fb4HZ1AgnPtuqAeWE08dxXySfBHpluN8fa76?=
 =?us-ascii?Q?1rALIAFQXmMHZ4suKxKe/UXTUgXtpNDN5lazSsr4Xbiy5Uh7iULjhW72Q5sJ?=
 =?us-ascii?Q?Ris6uibbBjhZ3hH/XGwdMNoAH+rud2Upd2C/SqYLCwzC5w+6fCj7jq9eaPJe?=
 =?us-ascii?Q?9ezBS+9JnfgfAAQQEX6qA/bTA+YgjBGHTbsk9bWo6EnTI/uIAcALnZsp1ne2?=
 =?us-ascii?Q?EIjzTAHu+Et6uxX33Etxt083?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1fd219-e058-4567-1991-08d91a80fe4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 04:45:57.2429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FE3oQeq7sH/zj1vq2jXiZBd+zVcy0clk24S1Ie14SQd+ljSLs96glYiMSSSbZwxWKqSiD2VUDAnpqMxEnskoJ4H2iL6P1YMvMGcuBhu4xK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5253
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210518_214602_958095_BFF72F57 
X-CRM114-Status: GOOD (  11.39  )
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



Sent from my iPhone

> On May 18, 2021, at 9:35 PM, Wu Bo <wubo40@huawei.com> wrote:
> 
> Fixes: 6d65aeab7bf6e ("nvmet: remove unused ctrl->cqs")

You have extra digit for commit hash here which I have fixed in my review. Also version number is missing from the subject line. 





_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

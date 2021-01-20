Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A449EC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 05:09:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F322311C
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 05:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F322311C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=W4sm1wN6EKYTA2MbHPbOTl8/QeecVap1GO3vVS4dFNw=; b=CD06vtKy545a6bd7gkYmTVIOP
	9YyXG9y0mWERMrIhQTcRCajxDvViq7JhVJY/R6cOdvvg0RbP/MxLQnYXx576Rx06tsqpU1/+BorSL
	nZbCOvfOfa6AJ9dEMZhzDJeeGPoKY0KKTGVSjWttikrrqH53zd6Di0YHDdkdg87OcCgski6H8Ar8z
	Zxo6KGoDdFGuQqcOI3jnWewb5T7o05OQzGl7mC26fpk2HN5PrC6wFtWWySOLQqMbXLCCV2/NSb38S
	d9KwtAGNj18KaC/+paTt8VV0Lg4r5gRTU2Mj81rMF0eRO0LIHCg/ZcBhsVviStgJTA8Ay+olZNPAG
	S1Mgkgkyw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l25kZ-0003S6-MZ; Wed, 20 Jan 2021 05:09:47 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l25kW-0003Rk-VT
 for linux-nvme@lists.infradead.org; Wed, 20 Jan 2021 05:09:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611120392; x=1642656392;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=i/9Ojy63ibXp3+OwgXe1cfrQpSgc7wYKo+yXrPqNa98=;
 b=XjgfkHDxG0BkVwbSL/kpqVXWd3n9SJfBeDKkSBvgCyxlv+7iOZz+aEqe
 mK8u6HN2rAenEJ4tZA8WfGGZF0Az04aihSZ/1ocOdCpTdNFZ/dKmE2Hm4
 +aKaUCxXXB1lmv4Trzkm89xFSo0yzKX8Gk6rnz5TvUVmGWusr2qis9lit
 UvjhU1QkOiQqpdcgTN5JZf67WcxxK2aCEUy5z1WicMZlQUdgulKfKUnLF
 IOEJz4FI5KEDR7vBGbCrw3h8QPuLc88ZZhE/FhvAunXOmp0diHbPnYm/w
 FoVLGmIvWjIq1ib8G03wk8XDXBIfvvjij/gz9OmI8Cu8N4pXtA7Dr/6wg Q==;
IronPort-SDR: vrwyF1OqT/RYJBfZSDtsHNK466KL8uSbs/Hcwl41rvFkXXfe5Fsbf3Es4QWtFwhVE+pmVGmsHd
 /Zt/7KhrEDSxZ8ujydkMpsnTj4Tg7wZGu/I34sG5u3W/YoAjmwS6meHpGq5iDSGVldRxFJn9gD
 iwCHCyKvxm3U+5g209CHGUWddxXuVI6EbPGkZ+a4Kh1TF6oNBg5h++tor1l4YxX/0FNQgz2zFj
 4tE6xwg6wnbEZKL+M/nDbOac+jRmGFTWxtZcL0m6anpX5C5lKRzpKYYeA9xPc4UguSGtDhPZLJ
 pF8=
X-IronPort-AV: E=Sophos;i="5.79,360,1602518400"; d="scan'208";a="261835908"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
 by ob1.hgst.iphmx.com with ESMTP; 20 Jan 2021 13:26:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIfBSixWmrc8w6wtAes2JfLy4lQy5Kjd+U21jh9JErvgsgAQvXwVoufPV0OzK9i3jITaV7oCEFgRiEdPkfYlnvEbwWmKfjeRhi8zhW6I5tCdK59rX+zJAuNx8oC+h31YeWcUSBgVUSw3IQFYwDCHT0EcHwpacVqEx2f7oyqwDWXxzfytYgXZmPxEdf+Rv1/2xDU6+yzU80yv2jFU4qss8obZHe/3pNfe7SLsYb2xCJ8TV6oApNgFeDY+SlSxnnzkO5lBXAGFK+H843tDnhGz0RbVXd/z+y0bFBRhSkDULGCHUeMUq3m/wJWoMbz5qO9cCZOkfZ4HGMPEdY7z/ocAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fdRrtskm8p/ro5ExYQn8fQtQSzFcEiZGqCnYP/N+qg=;
 b=MO+GIpNunGo0CQS6OqBjqcCMv7xpP85xOLqAoBOImAYoWJ0TiJM+TIjSMXmHahqBJdLfnUMeIRbRsMfmBliJBw481TYuXvrTADLPyrXUshR8Rb2QB56x54P5Om0kCrRCUC6QNE3A8Wd3blpEfYXRTehgGNrgBaELHRomNWD9H2NTygc30SNNjTJb/690La2NJ32aRWSzdJ7U9zFvLzjE+He9/DbF4z2LpxFs5BAeYmR7FcI0dPkOAk5r6vBNgDNjmdvjZw4oUGhoLUL57zn4ccR5TAkGUEYxO00taQIDkyO2W7S16rLhx3qg0PoCNWr0FYP3gZ47pDScDYImjlKkeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fdRrtskm8p/ro5ExYQn8fQtQSzFcEiZGqCnYP/N+qg=;
 b=rYWhzDes4kif/Hn+QxJhzalLMRfvZFZ/Ebn4IMZ8fRo5VexjM38sj8OpRY8aE11SrP8LAP/qL7xRrA6ujmaE8qmH2Fd/a5NdYPkWFwUO0TeivD9vMKZhmGkBrIXbNS+ydPU1aO1XLXXNmCoGc/ceLg9dndLc0yioLPBK0d6uVto=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (52.135.233.89) by
 BY5PR04MB6849.namprd04.prod.outlook.com (10.186.134.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.11; Wed, 20 Jan 2021 05:09:39 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Wed, 20 Jan 2021
 05:09:39 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "oren@nvidia.com" <oren@nvidia.com>, 
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "kbusch@kernel.org"
 <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 1/1] nvme: update enumerations for status codes
Thread-Topic: [PATCH 1/1] nvme: update enumerations for status codes
Thread-Index: AQHW4pl/PNJXQVRLPUucy0ABCmCD4w==
Date: Wed, 20 Jan 2021 05:09:39 +0000
Message-ID: <BYAPR04MB4965E1DC0180C2E5789E505186A20@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210104125947.160984-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd190daf-6b78-4160-2f88-08d8bd0196b5
x-ms-traffictypediagnostic: BY5PR04MB6849:
x-microsoft-antispam-prvs: <BY5PR04MB684962DEAAB07AE2C61EBAF286A20@BY5PR04MB6849.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xgjEVaULs9zCg4wvKqlXQzw7E4zBPF0am2tngJhBDVAm50/BYG5vLiIvj/6SOTARxahEZea1ofEXFUfEt0pnVMmlpWQp9xo0jk1ZI/AVNESnic/9iscCTZJqivk9MYuQY9VaD2s+zl6456sqZjsWXLZ9ufKffSNSz2Ahng14ZADa0KKBHw3TTUH4xymGQplFGDnPEoX91QZlLkv1lUT3ykwcleQxB9N8Q6FC78R8zHOytgWsQJjYmizdZLgOT53OvQ41hnAJYz0p8h7REi/D0aQ4NpmyqLZNmIFH72D8bMneROXoPnxAWrr3kVVcQFdUeiR8y+IaKacRQ5SwuWW0/IBtfM3dPFxHr2itasIwUTFNMNflS8yBKgiiAOKeCpcMYzKrb1y1AhYOY4c8OYuEAeNABxV1KEtYGIT4iUde102iHussAw1efU/DHQW/XwB8RAPpsEWxhEI0vETF0r32LSHdYBQEI+ZVDcoS46hqUZr5ctKO/o0seEia/FUX5csXQZs1x48v+6TYAYNu06Zv6w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(396003)(136003)(346002)(376002)(8676002)(54906003)(2906002)(33656002)(9686003)(83380400001)(55016002)(66556008)(316002)(4326008)(86362001)(64756008)(66946007)(4744005)(8936002)(66476007)(7696005)(110136005)(76116006)(15650500001)(52536014)(66446008)(478600001)(5660300002)(71200400001)(6506007)(186003)(53546011)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?VVhPyYsKeqyVcQ0aOTc+rqFrISs1Y7tJD/LIm87A8e2F4XsIRdYc+C1fLeTi?=
 =?us-ascii?Q?AWU/aiXtJVgeVlbf2szTT/MH/u6Y5XDH+CwPLYT7aWJTaYNvIBhjYDQcyhzm?=
 =?us-ascii?Q?Kjm+Lks+aUKA49VF1ayHQqqdi3SykjfPGXz5mte3jDpZwY+4fFNd/HPNSIb4?=
 =?us-ascii?Q?Om02l6OY9YRWrY+SqnuM9rTTmkBMap7hp7Vw/jXU9XQyFiFpFyKexSK0/gKU?=
 =?us-ascii?Q?4rPVueLUUJLmJuD0FYaHHwZA/T+hRAEWpIIp7AkLyv7sJwbyEtWtDjP56c/T?=
 =?us-ascii?Q?/FwBmJPq78NFCX1RIodTiUgHNc3UIpWQ38/aAOo1PWDsFUjAx2MrN9TCdjMR?=
 =?us-ascii?Q?aUTt8VEcGwVXk5IRpQRl5mT1XAjiUiA98ZrOQoW6Y8NOHUoadAYXXaqqhnXc?=
 =?us-ascii?Q?0tjVN+LHO59S8KDRNJ8riUVd1dEpj73TDCLrT6FMyCsZMWCVnEI3HA86Szd2?=
 =?us-ascii?Q?MpTcWXOiWnyOtDD8cMpg4nL9iml/lWM103dlgTyhrfdBigQ2TinFACQKIh0d?=
 =?us-ascii?Q?gm8PSwHwzgmSbecrChAASQAa7M4GxB0tTIidEguT9kqsro+PKG9U+LgT1+YT?=
 =?us-ascii?Q?jTpUhXMgS/yPh/JbLabd6YsqK36j5PVWTCBVW6eyw/2m0y1CuPrl1S/byCY0?=
 =?us-ascii?Q?nX2GPc/Ax0hSwQhXGrmu/G9aZdiusae4+2ahCl9SLjWiIQNDlaFf5Es0YoZv?=
 =?us-ascii?Q?E+cR2VZMXPERAIcdCwk25ggpMPl3XxAw5rDHwDYdkrspWJwCVi3TOxZtb3KP?=
 =?us-ascii?Q?AfnD+jvafmSz5Ljl2BjbkR1advNLOvbbRkWOTQruCpSkyCoZ2zm0RzhNGEKE?=
 =?us-ascii?Q?L2D30P1bXWRpU0vRVH9P0SRAkCu7oqAXKUJksWNy5VI7Bnlu9Cg7XBXBaE8E?=
 =?us-ascii?Q?EJdq5kB10JgOBiq+tctObz66SGG0wb/H0VHKCDcWMfWt//msO6AygTHGdRoB?=
 =?us-ascii?Q?zbIQuav2GeTavTu4Ucip4O0RXBV2I7/bw9Cl6qeg1qZzSSrSWT7x2GHTXfyV?=
 =?us-ascii?Q?bY56?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd190daf-6b78-4160-2f88-08d8bd0196b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2021 05:09:39.3010 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oZjnF+qqu9xRp0+vMzMM/Bw5PvSuFS4xVVFt3pEPThzAS3bDMYy+mCTbDu+6Iv8ElSfkqLwkvZR0IpHCj1TwtRVXZ9x17W9y7GAIo9Y5+4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6849
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210120_000945_313125_C30F0EA3 
X-CRM114-Status: GOOD (  14.61  )
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
Cc: "israelr@nvidia.com" <israelr@nvidia.com>,
 "nitzanc@nvidia.com" <nitzanc@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Max,
On 1/4/21 04:59, Max Gurtovoy wrote:
> All the updates are mentioned in the ratified NVMe 1.4 spec.
>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
I'm not against keeping the header file up to date with the spec,
but should we add the error status into the kernel code even if
we are not using it in the host/target driver ?

Here we add 24 lines which we have not used at all.
>  include/linux/nvme.h | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>
Regarding the nvme-cli this is much needed a sync since it does
decode all the errors if I'm not wrong.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

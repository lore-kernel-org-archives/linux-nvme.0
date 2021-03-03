Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13D0C433DB
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:51:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AED565033
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 01:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AED565033
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=kVhklRcRpddRwx+Z8JWPNpt8DBt+ESBkY/lMjBA2OqQ=; b=EP3fUQOORIPJ7FABhBsIRR2Yh
	/56YQNv6CmPcKT0U6N1XBc5zJ/Qaj8VEQIzX0wJ8hZ6GIV8xC1EsUCmnp2jnymvDIvwxUjXgk4YN8
	xi338oxOuxjaI82bnGKFVj6olBITUC36BxODpsjrPWrclvZ4D04XlNwwkNuJ+k7iVJtlqt9hEeMS1
	SAP/6sLMVjBnpeTfY9kzYLtGDmvAwKeEseUJNPYdFO/a59FG0rOAWj7U+ygtiRexBARKJpUFpuwvj
	ldWrhVYVys11K/GTJhGiepuB9uq+ppjV/Mz1Fx74RSuryy33MLkCHRAArsdJPLrga4Mdl7UEtRaDp
	sdvRQq0fg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHd9T-007Ocp-By; Thu, 04 Mar 2021 01:51:43 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHZSI-006fAP-J8
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 21:54:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:In-Reply-To;
 bh=fQDYqQHl7uLPABSzraBkt8orJKbRZN/CF+2Unw7QIMU=; b=a0ctF1b1VP86uYV+9bRaatHfZr
 5zM6rEirXN6IVyhEJe1zLOsHn5xKNK61/ZuAMTxGizr1pHoBuawIscYApn+9Od0gGrCVI2784s1qd
 D9pNXc+eQe2O/sa8XHTAOGGWMbHOXfWSzSDhh/3yx5rzEXhBLMwsOeE7dMFue/19TZjOCHHYVugwW
 /qog2AzA4ASgju1sDtYzEk+4XDSV20YIjsxyNtO/ObTngE2Q9VQuVz4HCQTIaEsTLM8BEUVPvwAWP
 EmCHpIGLG5vA1w4wJggYPhBNt/kxU/JDV9IYmA+MR2jx1X4TrSQGgPjJlLVGuBxD7fj24WzTkEdvs
 6X8ovNhA==;
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHZSG-004LLz-Kz
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 21:54:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614808492; x=1646344492;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=fQDYqQHl7uLPABSzraBkt8orJKbRZN/CF+2Unw7QIMU=;
 b=KweEu6TNEsuYjKkH2ZjesyurhJYvnlZBbUjUjtjh2FoQg25yFnCip470
 vdsydIW3wjUC1VjSik9LuuBktXLAU46YWX5rqqYRDI3SmWYWVN7pl4viT
 Lf22MNeO4YMyhNIQ+bxiVn5kgkCuOHqq2RTYzVB0ju10QDszGAI42oacI
 MWOXwaxDAqUB8zlV8kj641C8QRKQkXVovOdrPzy5pkUfClUVK/k4N/T0g
 A8cj8IZnO2rezGyJOvXQJCGu+q+oSZiGm/wM1m2EACYCjTKLOUl1qprDJ
 2bo0a3InEEg2gpAFzXFhPTihxcrhoiEaaSwZQh+2kx1mo31YsbEUc5LcD g==;
IronPort-SDR: ZwfUp4BXqMW1OT8djpzD0AQmxhiFldxddpA2NNPURPEH6jU/1NyOpLaZXB9kQUWwlWqegj62Mz
 /RZhcMb8zORoTV3berquohPp0q/3W7tyOyB/ORY4YyAGDc0gcaDUKp5EMtcxMht3/Vt+R9UNE7
 OnpBjIeEclSOmTBchJ575mOYM1jCU0I9ToQ9k2FWzPItUdas+8w3XQhJKUffwI1XAXRFWOVxGx
 ALHh0aqzvMOq5LnmPG8N7u11Kuu+hNJi0wjeL84/66yCaQo93IB59kLVd6qyqJ5Gd5lmdX7OXo
 oN8=
X-IronPort-AV: E=Sophos;i="5.81,220,1610380800"; d="scan'208";a="161277652"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
 by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2021 05:53:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P6q4SOu5rgMLZ22cR6hfyNeY8bjfnpTs9zMPsiXI54484evDu/PQNXz8UwrW//cOJdM4diib7PyZGJW70rqHqeAtcgWz4cXS3DEKZZR1It+i9kvANLNsA0T8i3kH8hZaJ9k31y7Pfl5WvRP+GheFlgR/MkiNHcJU1XEKOgeoNP8PAVlLN3HaQ+2nVPUdfUYEq16ATPh6cwLWqgqoNLWCUi3rO7Kvuq/Q2f6AGkBzE7FU/Aj8r45yKZYgwAPAhqn7SMt2f7GJDL6IETKMy5FU/0tSMqQOK/EQAoVrNXBzlui3YCi17IFwzxmQrCq/MYPxKAhxLRmeu0ovk7+miVfM6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQDYqQHl7uLPABSzraBkt8orJKbRZN/CF+2Unw7QIMU=;
 b=MmEw0JzzBFCoaV66qfzOENU7aX9HDttBrN0nAnSRCjzwsoVICo3keIWsAQT/k2krNsdx4BU1/TnbqAPS33r/MfC2wtKVsIpgXN+3xuPwqW57T+KrANF+SrzMGoN3Qxe9vW00FuuYXme+hIstaT7pei2ciDBZbcgJtLVriLDJJQ8nt16YrRebnnauRMz8S1zi3DtbOhQ5M4BLnXQ1CSLkRcYwui/CzanDBzU1Nx9p89HSuf9hIkxhEiokkcxjD1u0ykIK+az8aP9bO8UHI6yLOwaJJRPLw/GN2ObrQnvaZMtInIjgtoTvb95OeMceQ9L7QmIpsGEqssFN0qD+plJTHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQDYqQHl7uLPABSzraBkt8orJKbRZN/CF+2Unw7QIMU=;
 b=l5hYUx0Dm9nw5UROicm7WlQS6U2bn3/VSK3xz0zXHs+q6xyPy2IQ0d4qzaOMOfgasgwliC2Ks/nEOirUEjc/YhjUZM6e1HaULqSA5tKweFXdckkXBKNJiO0FJgzQrQnRvtASmycYZbE/K2cqRzKvoUloQz4pFrysRMFpZ8XfEY0=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7693.namprd04.prod.outlook.com (2603:10b6:a03:32b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 21:53:47 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3890.029; Wed, 3 Mar 2021
 21:53:46 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/3] nvme: merge nvme_keep_alive into nvme_keep_alive_work
Thread-Topic: [PATCH 2/3] nvme: merge nvme_keep_alive into nvme_keep_alive_work
Thread-Index: AQHXEGGQm8TfA0lBxk2A4ZMRRw7cpw==
Date: Wed, 3 Mar 2021 21:53:46 +0000
Message-ID: <BYAPR04MB496538093C434E97780E312886989@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210303125304.1200789-1-hch@lst.de>
 <20210303125304.1200789-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0b7a852b-e653-4192-2943-08d8de8ed268
x-ms-traffictypediagnostic: SJ0PR04MB7693:
x-microsoft-antispam-prvs: <SJ0PR04MB7693648D00B5020B79916A2986989@SJ0PR04MB7693.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jNmGTJTGKOWJ5hwaRBs8QoR2omWFg2IjpqtKCBgdK72hjEbBSYaeGfxiyv8w3EEhfBd166oeAqUZ5qVzV8uJ3JyEoJbkwqlEgPbEtgJzLUlhgsqS1toimPJqhAZO1y2CT0FYAkEV1wY3L4k2rlZB2xueLoV0QLpGNw01WSE+u52hQHacATadkDQeCJSguUB9CWV9QLcnqEEOkPKUmagcxv/ZWJaVawfHwXQkFxBSwclBQy85HFMwb5QJBTcld/3C2ZHVpNPOdvbvFSRVgPAANY23sOlLraLTjJG8ZHXL/Bc9zpehPJrouUINWW68hziYTVx/uzEbGEQrRiZvAcl65VHDw5Xu2IaYHPiH5E6QtjgdY5TK30/YuOncpQb6KpHwV/vsym7T/299egOI75p7TrlUdoY9YINgN64cScJ0073uC1RRfDL9DC0gip1azFlGP40Sb4t2EJFRlUeMwVBHQ1ed/t7b1B28pKSxCscepaISmhz5TSIIIyViMSCNZPGraZskyuMcPRaOhStQdwyITQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(478600001)(186003)(5660300002)(7696005)(2906002)(8936002)(66446008)(64756008)(33656002)(52536014)(54906003)(66476007)(110136005)(66556008)(71200400001)(53546011)(316002)(55016002)(9686003)(6506007)(91956017)(66946007)(4326008)(26005)(76116006)(558084003)(86362001)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ePwX6zIPS5zzUUGaoncykzEeULKG9J0qe4gdGEryJUKKQmkOOQH1kT5BOpiM?=
 =?us-ascii?Q?tGxeCbyrMmq+IuENSMwO+Ys1JWXVUq356yQAyqcAGufeL3nRL67LmQHhHW8v?=
 =?us-ascii?Q?QAD2pxXj3liwSCVGtTswQRL3Ck1cPOcCq8ZGvZlGTqq+sxy4cU5m/0kjV4I9?=
 =?us-ascii?Q?rAFCVqK/SHSm549FzKlBbov+7wZuGm8lLwzXYIfpmVvUmI+crBqbzZSZyqor?=
 =?us-ascii?Q?xRUN0OA8r5RsPiYSrWNcPNqhrRvzLlzSEW8kxsaxKO5xMjQVDjHo300gupfp?=
 =?us-ascii?Q?m0Zje0PRK3D6ynl0D4BUlE7Dn8+DWj3mLFi1bNxwVE+w3Ipai3yhNxNKo5dT?=
 =?us-ascii?Q?HJuN/k8XawwWGFxAOWYRjLFWvDbK3ve/jbGKvO8V1TmETq4Lz7qnN+1xpDvA?=
 =?us-ascii?Q?99cJCV+c1OufLeZsZDNPTT8W4NPTQVu8UTFgS28IuhHSTuJ2UnsBPvYs3zsE?=
 =?us-ascii?Q?6uOHqmr0l8ZCq0/lWBx0k6f22d52aVJy39GoW5LocDCc7l0TYWLhZeV2XEFD?=
 =?us-ascii?Q?Jw9iGy1YNyfggHuVG6QMQJ3dY5mt4EsHFhsB7cQ8c/T0tc+4Sg6muvfoam29?=
 =?us-ascii?Q?9Phw183bt06vlwdULeCKccUPmUkQP8OmgLe3ssXKnIagYQS9/TBuf2hdSM/1?=
 =?us-ascii?Q?Pt+bqj3T7wWm54Yaf4Ax/lGnGhuVQ+HpJ9v7JJExEbTU1VF+DneJUYMWg4pM?=
 =?us-ascii?Q?k1IqusG6QTzfllGFDtWXHBvkKEuLJosGp0L1GZMCYyo6x8AzQJ0BVLMS/kSj?=
 =?us-ascii?Q?vDOpKKXGSjH9hvzS4DzKm2tQ+iRD0gRgY9z0l7tZgkDz9KiikX2VDTOTfTYG?=
 =?us-ascii?Q?NKM9glXWnbxojhXoi6gyJjOQWYAzDlxZNo8eL2gZdcMoBG6KnSDAih34Mikn?=
 =?us-ascii?Q?N2/rB+7/8cIp+hNosygnKXRLZF6tOZxg5ajWV9VQ7fsrf29TH7z3waPbMMn7?=
 =?us-ascii?Q?PJ09mFT/tnbrkJC2nnrBeupNhwgV6vROV7Nqv/A5689xI9fn10jihLCTD37n?=
 =?us-ascii?Q?149q9UIiY429Q7iGo4TfNwv0Nv8L55MBHZLsPxRv2NKL8lyq2ANlGFq39hHj?=
 =?us-ascii?Q?7nhHdO+uBFMf3ARAmZC+wAEpuv5Ycc5UGNNKilP9/xN8N74ojc0OsAdI4nJ7?=
 =?us-ascii?Q?MLdp28WmcvjJj9VfzJl+NiavpRa++Cg7PCJi8MH+Qm5k8BBiMHMK384OXCnF?=
 =?us-ascii?Q?eSqGFhY611HTDzeyeq1o74qWMRzn8PvqQ3Rk0KLUyAJQb3nibe1/NeaVgM+p?=
 =?us-ascii?Q?bxMhI22ypgBL/ImBP5xcxnJPaDFmGfSEDiglzz5S/gSNiUj5PbL1nalBJ7iY?=
 =?us-ascii?Q?h0FE1lIAdm5WKtjc1ZLnHg+z2+lS+n4GnHkGaZIO8Dw+5w=3D=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7a852b-e653-4192-2943-08d8de8ed268
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 21:53:46.8269 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +DxgEK6j9VbEctwEEAtwbTaN3XkBquIKtgP/Booxzs5B2S7dL7GPNlXqa4ZjLskTfORKyof22TBuBViI2m/uoCbV9AgHOku4Vx2WtuX0rbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7693
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210303_215453_663668_A1B6BF46 
X-CRM114-Status: UNSURE (   9.57  )
X-CRM114-Notice: Please train this message.
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

On 3/3/21 11:15, Christoph Hellwig wrote:
> Merge nvme_keep_alive into its only caller to prepare for additional
> changes to this code.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

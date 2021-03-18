Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6640C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 01:06:47 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BCD64F10
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 01:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BCD64F10
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	 bh=ioJ34vtX4vMDiPS6kP5AYokXuiHvwP0MQ45y0es3UkM=; b=OWxt+BDSFR6mkPyrK4YJUwggM
	RPlmnz7o9Yu88nPELHxLzRylfASa/ZwBQmwZIYDDHb++Q1fwEsXkLvD7oIFX42ayxfff66xwGFfVE
	rhXIHTiQMiHRdL9066QdHlO0yWLZG3Btm8lDVqPHUcAGo8tmdl9zoVqi/VIGsTC+gxTtW4g4feGw8
	FzbK303hO70OjARm+34yCHM4Wxw2oPUdjHcJ0HIrgRjCK+uyb3AaPDbeW+jBJOFrOFy9pAjEUvcH2
	XTdRPM1+MWK2GJcJDNLS1m/uM4zqsmQlMaA5XaUd8KIjDlU3MDcwrA0rTwmJQTta+bHYsryezetgr
	iiPzoFsVQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMh7R-004Djx-8B; Thu, 18 Mar 2021 01:06:33 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMh7I-004Dj6-Jr
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 01:06:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1616029584; x=1647565584;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=I/nbhajK8+pBS/nuLpvJIMBFKc88GYiT99/Ku4U6IDE=;
 b=Ys8fyhCATlo7DqArqQ7gKnWdPEOY1ugrYpLK87XfB34dRSTFplEaOWC8
 ewkST1SaLNsY3nJilKwhSdcb9wiyC5HL8lQUgfES6b5CmAymnHep/m/qx
 xDLfgIoWlQX30UKcqsW0cukKGgJxXW+JEIWttdMrfIeSRCOHeE7qeEr02
 x2oWiM8Dt/Gj0dptHOD3115j5FDN1//L7tYJK7y9QpO9b8i7J/J4JQQlA
 /Chzut1JBNLZ1Otk5KXfy/iHL2K0GzbhHoPTNfk/0SzgJ29Cr4jZI6K/X
 duTW/buSWLiavFQhO2pbiLfp1JNyueSPNpJdMVABLq49BmYF8MzPzM2zl w==;
IronPort-SDR: 7WIydkGPiLaMdRes1s8Aku0TPUiIrdfxh1DVos6k90LRTnA2Kf4a9r4roAK5ByHg4pPvq0LkC1
 j5fJI8JLeovlA/gR9I1rbAgc1Z2FpEkNK3tAYt2ecuLfWR0iSbUBSPUcae2hfG4Qkb9KiNcF6E
 uPcr9Xz3FifVV4l7gnzQu2oqE1bN+cxvAw1ihXJ74VppKnMp2U0Wadvm4fquylAsJ6Sqm+JAN9
 /Zi9uaGkx4SwnafyVkHv3gt8e4T2RBOixbd7KWy4mro99eEGzt81GrAmZ3Ezrk/oGLwXejyaQA
 6aU=
X-IronPort-AV: E=Sophos;i="5.81,257,1610380800"; d="scan'208";a="162416631"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO
 NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
 by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2021 09:06:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n49VYzK70wxL0jHU/bUZym60OHyHoULSO0t+Lv+AjVgtCugvIx+LMmTxFOg92MLG2731jRI4eVjG/nrXS3YOv+v2bcohcSwgt1W4WxjZyZM8O12BTnDkQRrelGs/QmEoGEsBQmJgaEfvH5/egOfsWeDYbiLuGgNKFv+8BYrUHyLbYlvahcmyfUSERTkSo3xshLePcJ8K7tJoqS7PnsTVxT2GN35H4RzNp0gfrX8tP9Dba7C2rIVK4gxj0vYHcDBM6sI1LE9ZmrZIoiw24uJJhIB6qBMiDwETs2KF1esleMLhA0iVySMX1vGvjP6hh+1Xw0wVOfokQuvB+DEo6ZCqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NetoL0JQaQxluWXF8SUVg7ViGx8j3zKstSUueHTI/0=;
 b=DKAf4Z3GYmK5SbRAirwa61MxaQGoZ0j29wTZBRMAGFtkMvymWPCEX9lAQOIRgGI3zq7OBWNCTHUBRE3cmWqy+PKOtn3754zCm2xmmNO7WpvGCJh4C9ak4iTc5djWgXX4hLy17IVZWpAcQmmEFxJa8SRjkvkN195NEP53WnfBkxCjY5OXYkyzsipEH0P00EOaNi1FZTA0pv9Ff9NOHdD0skLxGNYRJKdh6mh4xHTTeH1T8VURfwLSxexntbA+A4wQTxfHdgejdX3ePyH5BVMw8KHH6qL0AR1ZOXF8/dk3411O00Nu4uOAaYEtiAK0ruHoRrWokgBh6ux7ZO55Y9gRMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NetoL0JQaQxluWXF8SUVg7ViGx8j3zKstSUueHTI/0=;
 b=HeezOAis9qQddT3XB+FhIfF+HhbBAkRqva8KXsYdz4413bTQvJ+8c3oALFN720Fd6nmdVYoWXoUbJljqvQ7lN3qkM0LcG+wmLBtcCu8mAPtYXIgQW11OQZAkuvnlPXBDCPzVblfeKHxN1w+yz2CyvUtTWnxCNQ8PjyyvDLQTdkg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7423.namprd04.prod.outlook.com (2603:10b6:a03:29c::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 01:06:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3933.032; Thu, 18 Mar 2021
 01:06:20 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Alan Adamson <alan.adamson@oracle.com>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH 0/1] nvme: Export CSTS register via sysfs
Thread-Topic: [PATCH 0/1] nvme: Export CSTS register via sysfs
Thread-Index: AQHXG3E1EBkiIIuwPkudn1RskRqzKg==
Date: Thu, 18 Mar 2021 01:06:19 +0000
Message-ID: <BYAPR04MB4965B0A515184892C73FB32586699@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210317204615.13971-1-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4125dafc-6d33-4007-b260-08d8e9aa0a5f
x-ms-traffictypediagnostic: SJ0PR04MB7423:
x-microsoft-antispam-prvs: <SJ0PR04MB7423C4FA8EA56E3A2DEFCF1586699@SJ0PR04MB7423.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VNLppQlXCj/YAODiir1buplgWOPxVLOlNVGHUiweDZZXKkM+J2LiEZidBjcZJyi+GHOeabTTDxEoDGsqVyFXDInFjq8E5vG3fQYiqXMgkd2MNGT456wGjEz0dEuxv5TiNi4qwwJgu9cMritwDxHHDjM21ULZ5W7LkyhRFbbO2dLy1Ykq/+McZQxE8zVtrPjnzDwLA9qv+1OORbdLbhCBs/NuickhEB5wB+y/JExZ2yfbQQsWYdKCodxS0G5/HkMYYj0SZhma17913XccIgUxkrGUwacAnKNeV6VqhEc33PFK9OZD9zIEhYoHvDfQ8NDxh4VdKzYaHqb7A2Eie9DgVghcik8GT7Jys4bjmKXNGR+F64ZYyVU4wgejoAMKbghF3Hw2C9WI8sW8fkagjaq2msXz3Y4OlYJOHr61GhlbnYoYzYRwi0qpMkg1nt3mYtA3CC32WGee6ZYuRQZ7EZln1MhcblY24PgCALMEuGX4NhkcVMhCOXYoC8jOPxl+gBk4RaXalFsj8aaXMXly++DCG+J7hHwebBePejyUrMp9Z2YxyEj2difAKdBpJefbVhWBdiK3fkUm5W/ncjtGbkhH5rSttDp4KuLPeQ0+uXOcycIqbBWXxnq0PcEB84E6S7+R
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(7696005)(5660300002)(86362001)(478600001)(8936002)(71200400001)(52536014)(8676002)(38100700001)(316002)(2906002)(55016002)(53546011)(66556008)(26005)(66946007)(83380400001)(110136005)(33656002)(76116006)(9686003)(6506007)(91956017)(186003)(4326008)(66446008)(64756008)(66476007)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?D+zkaOScGuWdjBHo9/oEIrkO4CfpE4HEdiplH+jQS9Na8OChTBFibrucO9IC?=
 =?us-ascii?Q?2z6cYXZFhLF8nD6/iwmpraYabiO5SFLHp8dSflwtCa1aRhLAO28m96MpR2sg?=
 =?us-ascii?Q?ZmZCl8XVYjE/7Ima9GmAng9qB35LfHJZ8FnbpHyDgXxfzyiRZn/fTOqbEMqu?=
 =?us-ascii?Q?0OgE9ocsPu2n6Bn6XE6zBBnaSfwY4E0wI1r27591FYuhD7D/8sFC2aa9XBCb?=
 =?us-ascii?Q?KOKSDmlT2M2GbCv5RlUPu3Ti0Ga0+8XED34qNFXD/XZsIkPDqH0DvhkSbC9A?=
 =?us-ascii?Q?jyBsAXJWYfC/EGLLudteaW2E5MzhXCGEjnyxDVgNn9j48FXIQTuHd7rMj0xU?=
 =?us-ascii?Q?mTTr37AwflNaIUWaRXNSciX8vrVx0DHaK3nto+UHOY+8NKZ7nP4ggickqbvr?=
 =?us-ascii?Q?QpAmzDlCZklv6hsVSd3+F/UBV02wk48iEMJ6swX2Sy2jhHiLSgK85IvqYCqw?=
 =?us-ascii?Q?+tw80EgoCV5DxSGvCR49CBYZHwB0Uw43maBaqvDWfZydXSno5eyB/BRATxtc?=
 =?us-ascii?Q?Xeuvoma/gr8Wwc7oWW9uvIU2yOnqIt9QQQ6ozQc4GD9qcstDVgh2Snb/YzxX?=
 =?us-ascii?Q?cUO3pAM5rEratNRsd5+rva+Js6VnCJntCLllr93Y/t/X+AEZ7qvVdTcHB2DT?=
 =?us-ascii?Q?TPV5PYktKp3/WMlkiopB/PbjbchqG1I12Aavz7o+eFSuSbCuvJFiiEXR9h3/?=
 =?us-ascii?Q?nNakMkxobnUDu1GNj633T86e38dmuRQJmnTJMAO0dAI4MnAn4Oe7Wr80X4Hr?=
 =?us-ascii?Q?sAT3rnzPWJVUElPqDqcGmFriJT/6EzHmyESXK/Td8dTxwjZSbBfnPyrHhKsX?=
 =?us-ascii?Q?JXYUq4TexBo2PJiMXkPIobjZvV9ojsI4FYeyQDFhPgL8ssJXuDPxZp6fmZsq?=
 =?us-ascii?Q?UHID8ukfqU0l+QZDongQR57s6asg6yqvU5ei7apUAWgJUH+1FGLIr2pI3pRd?=
 =?us-ascii?Q?RWgVe84SPZIFBeRMl3AZn79DlxxRqzEiCk7FOyTqCVhoHGzCx5XP/jVEzuCw?=
 =?us-ascii?Q?B/uZqvzwVe9g4tinvIMElBSc3o40B2YnOuEBanmbDUko6Hyn0VdcKA1tAe/U?=
 =?us-ascii?Q?mi+zT76XNjQgcMuPPQ6yFRe99jarsCOwmJHJ3gJGHp5wDym5gHgml2SipsiB?=
 =?us-ascii?Q?XwmEDh4fGFojmLwneRWas7IWoquQVnX8RgG1Ip+2UNyqIO9k6IGNoCiHiEpj?=
 =?us-ascii?Q?YXcqv2NRAx5YjCyOjKQ+mxO1tqskW6lZPgukJkUc1wWkXxOEUar0fYox7HTs?=
 =?us-ascii?Q?7r+vo6ezNcdTC3pE15bZQQ31VPSkj6jiDWzWgmqcesTc0pDiVBThYfdYv7cb?=
 =?us-ascii?Q?D7wApnkm7jC1WitgRlckoo90?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4125dafc-6d33-4007-b260-08d8e9aa0a5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2021 01:06:19.8914 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bwGKp5Wqr/bM2BaTG8MbUcpMipq0YwLh9cI16jkSgBigPrnlimkVauhu+opTVgp//PJa6FpUBaSJHB8G3URjYTeXGjJW+ldFuxoHy2mFu4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7423
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_010629_144646_CD636103 
X-CRM114-Status: GOOD (  12.77  )
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

On 3/17/21 14:05, Alan Adamson wrote:
> This patch exports the NVMe Controller CSTS register via sysfs.  This
> feature can be used by userland executables that accessed CSTS and
> possibly other registers by mapping them into user space.  Since this ability
> may not always available, exporting certain registers via sysfs provides
> a safe/read-only way to access registers from outside the kernel.
>
> Testing:
>
> # Controller in the RDY state
> # cat /sys/devices/pci0000:00/0000:00:04.0/nvme/nvme0/csts
> 1
>
> # Controller in the FAILED state
> # cat /sys/devices/pci0000:00/0000:00:04.0/nvme/nvme0/csts
> 2
>
> # A virtualized csts register can be accessed for fabric devices 
> # cat /sys/devices/virtual/nvme-fabrics/ctl/nvme1/csts
> 1
>
> Alan Adamson (1):
>   Export CSTS register via sysfs
>
>  drivers/nvme/host/core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>

This patch looks good the usecase mentioned, but I'd really like to
see blktests for this since we are exporting it to userspace.



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

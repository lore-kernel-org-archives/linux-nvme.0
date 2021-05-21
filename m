Return-Path: <SRS0=oXoK=KQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF74C04FF3
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:37:05 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7029A6128A
	for <linux-nvme@archiver.kernel.org>; Fri, 21 May 2021 22:37:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7029A6128A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Owner;
	bh=jb2UBcFIScE+yb18htQZsEXCmvevvKc3MMBr60G5PV8=; b=Hxil9WeAaRhkyodPODiVfzrZzU
	5zfdFPGLJTcpno3mv+mSOgVP0x97nN8IorcBp5C/W/cmZWQe3VOxTb85/nPI+131/+3R3I8df5Rzf
	sOATX1IkosHbnbREllm2ZqvJ3rt30YMHjLV3g5v7C3QmzPOvnuK6cS6SO+YHbEqWa0R9WVs1cWGEE
	bfSSgRuXnFojsAshbLU7FVBJQQjAKCE5D3I+SpZmAj9ODA7PliUvaLkhIgAoe5n6a//aVvGinuor1
	OY0hL0fboxhGF38KIk6QuBFEfEQTePspnw8WnpUo4l9urXrcZDVGwehOj9mL8As83g+WvMQIkhPHN
	z9VvJarA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lkDl5-001GGb-Gx; Fri, 21 May 2021 22:36:43 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lkDkz-001GFs-Id
 for linux-nvme@desiato.infradead.org; Fri, 21 May 2021 22:36:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=MIME-Version:
 Content-Transfer-Encoding:Content-Type:References:Message-ID:Date:Subject:To:
 From:Sender:Reply-To:Cc:Content-ID:Content-Description:In-Reply-To;
 bh=xaCsDmY9E98Cb/gcOar86j09Zp+RV7NaW3D5dGMQqHw=; b=hSMlHjkH3MoeEirykuqxBlBUiD
 dOYlMsfdzXKGcWNb7ag2ZzHenx/KjXSqZJsyU7pnXOc0eyklninONrBZI3su4u2BXxuCYsDxzxhj5
 PbRSrQMkYGURs12Qo8ADN9Td2ulsMsLQODSPJkQFGfKLsdDg0Nik7S0k/WQzcU5Ow3ztuyMPhNb6K
 WzzSSQSGu+HQV3Zq4dSRBAis1Cnk9kWsKR+ruyZ7rDahuEbyIx5Nqe27kl6DMR5xBIkhJ1sVyuK2v
 g2TVRhTByFX9WHq+0mqGn78kf459Yepf9q9CARktML747yyMy7JYNUw4iE2pvyuKdU/+zzK00n8zd
 F3gDNaDQ==;
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lkDkw-00HTYq-Vn
 for linux-nvme@lists.infradead.org; Fri, 21 May 2021 22:36:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1621636612; x=1653172612;
 h=from:to:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=xaCsDmY9E98Cb/gcOar86j09Zp+RV7NaW3D5dGMQqHw=;
 b=Crhly5+tSBVLqntDz72cw/M8c1vQBW9z+KLmwupJqT6b8fT+6Aa0rg+C
 KLeeaQhDYXbi9rP+UuPLeoEmPAvv4/OinT/BtpwXBvFqDuiYEzVeXCNz2
 FdMHWYTeOdMVBUMdrbfnvMo31mXIYWa0dkmU80+j+fK9ug0ItMWu+2u4z
 WojjcEST//gLF+UbTzAohuzs45GV3RXiEp11zTenjKo1S0IXgSQfNZzaJ
 ON6+Iu0jZET3OoWHGh3iR1sTSCahh948iu0G6hSYe5mKCJSRje7bGZahV
 CoVmyjDwS2PqEKBV2jrUL4a/MYwD/sXj6NtbQze3OvQtCvqO5XApAwca1 A==;
IronPort-SDR: uioqMNwtP7QcZV2GQSWWEkHMPGk+Krzn8xpMHmZtJUeeL1Vo6I3j2lZ4zGcjawMZhBYUvAemE7
 ZJuxCXuAq5gy47pRRBRnnuqDGFmDv3QhOBhZUervNVHvDgLAEwMCGnNU1zv9yAEoFrXt15Our+
 v8hQBZJbCymvoFqRXDkI4TJDJGNxGFtKOHDLgBt4CnW7nH+KKwAyMK6jMRCGxx3t1VhR7sf7cV
 /xv1/tlZq8wPQ94z+9h2LMMUiMmUNy9tiA4x51153qVKnpqRJEeWdSkvBgK7KIH/9009QssnrO
 nBA=
X-IronPort-AV: E=Sophos;i="5.82,319,1613404800"; d="scan'208";a="272971587"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO
 NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
 by ob1.hgst.iphmx.com with ESMTP; 22 May 2021 06:36:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eT/yYDRnqLlrALzBD73nnqQz26Qww39m82WQANe3wK95Vzrp/2Mm9+042dXYfvzb6X+xEid+l08rkr+ZkNztbl1mCuQbLgMFJrrA2WVwAEb10DX74iKglnNZBvPzlf2d3/vGXYeGrRvqrBO4Yrr9QubzmAYz+fy6OG5Il/pJpnpr6SWv30EYY9WXgHfjh6gLwD0taYVnq/haCr7A4ZyawCbk1dPHdmrVwPFhMp7TBH4XkrKRn8Ol5CHbGP+gm1HuKSR2vJTaWGIMAnLOuYUAfKtfXyhf5/gjClQZMVrewmh4VxbLrrAnPyue8dE4xzVPEoC72k1IIEXwpvJCX9k+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaCsDmY9E98Cb/gcOar86j09Zp+RV7NaW3D5dGMQqHw=;
 b=YYgfZiaxD/te6pxGRNDf026jSsS1BaYRZ1depk1M0WzGCJEDJXducyh575i7laJsiuybrFWSU0URziDCx9ftqti87bDdDzRuHKf1n2We2yvfK0WEaVWwZ3Bh8b47vc8cc70u3gkunZsdik8oMmHPHh1D9fFGwWycA6/iiSPrglQde0wzE1WV3Tq7TYDlZXKdRy85mjXW4lipOgT9l1vtTIMkrZEC5bdqUZn7q4gY+hBzT5S9/i6RQQL05WQJ8o2ZG0tVLXQ/tYfvOu1yQyC6D+BXNwMB5MkoE9AIF+oxhD4CKY7iWwABwTgobPachY7rav77ZbfJV2qKeazmoLVDGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaCsDmY9E98Cb/gcOar86j09Zp+RV7NaW3D5dGMQqHw=;
 b=LfoyY67dzm+Tom0W9Bw15165Rvs6dhM8oXsZ1PZDIr8ufrfCqUkbG7TBFXjYihycO6spKtAbXHEDwNyzHFUoyGkzLtVRbFCHXggNY8WlUAnXpDj1L/wG3lZj0mAdKbV+szaEE6JxehJRUmLuOlwPPV4yOjoq5X/iT13jzSh2oIQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6022.namprd04.prod.outlook.com (2603:10b6:a03:ef::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 22:36:30 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 22:36:30 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>, Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-tcp: remove incorrect Kconfig dep in BLK_DEV_NVME
Thread-Topic: [PATCH] nvme-tcp: remove incorrect Kconfig dep in BLK_DEV_NVME
Thread-Index: AQHXToyWIvjErae0L0q2Vnx/cG7+xA==
Date: Fri, 21 May 2021 22:36:29 +0000
Message-ID: <BYAPR04MB496514EDE7C8ED893C41FD9186299@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210521215115.1901970-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b2555e8-d36a-4b99-1fda-08d91ca8e0bc
x-ms-traffictypediagnostic: BYAPR04MB6022:
x-microsoft-antispam-prvs: <BYAPR04MB6022DB05DF650EA0B2AA2F3386299@BYAPR04MB6022.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:418;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PSrhfcjV4LKgSV0gLiwCovXCpZR2SI0FMverhLSLxhPx7d0toGkrmel11Ma/D5Pmitn+8IfY9rsC8m0mVoQODSq4qWEy7gKDv0EtahYl0UUnYgbHZscCNbb1v22KZwMMtsuXK5EBsRSCwuD+jZZknBqnyMA7HWlQdghSo386NAiIgmLalJCTH6TtgQdTdgsGD6VtDV5FSh5jqEliBJWPUJz32AuIqLeH3Dw3DQ8zPUyrVT8ZvK/TczmyOOz6dxWvaufpl9Wft84lCQ4Z1YKmGBCk6uUnXQpuMSUG+bJ+Tpjg5frAZ8jBYqhTBkVbOScVMEL3pjQjJi1wyCc5/2ptzJi2ri+T89sltBU3HTYajEN702P3cavOznI8UkEk11ETKHHy+19ZEQWtB3M9NrZcqr57soAox4tRsKC/Ua5cpJzS9GrWSyHprNkNow8YaPZKRwvFjCj9qdQx4lHP4LMWaTfjJv6stfwZ9NcUjyFFf4BV8E3ZZKv+FuvcbAWKVo9eGfkMDuw6oEIX6QaKAfBAZpipBkIqJYnqAxtkNbK7R13yHzGF0gN7LeYfR1xDEO/XqEifXFueew3JPvnVQDGIAutQkqvt8kaGnF8LGVmKtMw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR04MB4965.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(86362001)(71200400001)(38100700002)(122000001)(110136005)(186003)(8936002)(7696005)(53546011)(66556008)(64756008)(316002)(26005)(8676002)(6506007)(2906002)(478600001)(52536014)(558084003)(76116006)(55016002)(9686003)(66446008)(66946007)(66476007)(5660300002)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0h6PphzMip81pBWglkiJxzo5/bPHjdIt2Q7GRxWKvgUDH7DKrUPndH2XwXoj?=
 =?us-ascii?Q?AJ0fvVTJWJxfrwbtgfy2zUnun/8oDF30LkmsrNvfpSNL3tgkI+xI46Kik0c9?=
 =?us-ascii?Q?crDQyjaxeeIuwQ9g6deue00UI2BM4DoZTS1ZN0OnJ5XNqXoiPU0MtPz26vZX?=
 =?us-ascii?Q?Iy3zggc1sqY9rhnoJBWp9cPMkbk8zVwoJD3rLgNmhwDnOMngpkQX7AVvwlbS?=
 =?us-ascii?Q?hd9S7XIPe98HgOI6mGO6o9JYjxK6qnJhBsdOI9+oco64jL3JPBBvNmOYtthU?=
 =?us-ascii?Q?3uFEW0bo/ZipTla87vjeXjmfxpresD6ECaXAIUuV2lgJ35an6B+BjJjPLSQ2?=
 =?us-ascii?Q?qJv/fkYwfzeBcBMJeIPJcY4mmG9M++Q7uHBUxJG0E43oL65wfgcxQrZVBBqx?=
 =?us-ascii?Q?cnI5ZGMRUDUuQh5MWdPn1405DjE5jO7Q8/bZPrmlBBBEtOKKx/GRouiPOtb3?=
 =?us-ascii?Q?u3P4ZpQDfVfZzvLY6dBrAjLo227D8YWsXk911mbr1aS6U76NXwG4oR1MDaoK?=
 =?us-ascii?Q?kULaAVYkAWq2Q2fdvsu1C92/Q6xc3iDGTt+UGh8D++jhwZWUL2FziGY53ZwQ?=
 =?us-ascii?Q?YhJwIDWazcg3jyyJkzsupfJ6SFj+WUhRDXzMWuYbJmrbz3GddxH1Un409YGU?=
 =?us-ascii?Q?vwd1iNcEIT+RDOGMp29UYv4V4SvcrtJyRAPfEAKdrJxNRdkFBFdJCNopTXR5?=
 =?us-ascii?Q?xMd1rVaT02+swbA2vIUJeBRcjCwcFkq9Sn+BzdJvvLp6i0xF1a0WVVS3g4gp?=
 =?us-ascii?Q?uYpkMryOIQ/aeLCxseXnvMKeJBH0ZrJDA1faQ4GSpNPtuyxp1o99T5G4La/Y?=
 =?us-ascii?Q?9DlyjVoWCOah3GE8MngLbL+2IcyCCsklJFAfdM7+XTkon4gaDWUbnhgrpbvK?=
 =?us-ascii?Q?jAQXv09/CDkSLLV6LNz/2xt/KN3lN7JWhi7GshV26PVcBzX6DXijrP6NFjKS?=
 =?us-ascii?Q?RrJ4bRPym4pcpRrWq3q338n5SxhR2T/Lq3VF9HcG4Tbycjdq7ED7BPaGG5NV?=
 =?us-ascii?Q?4K4AD+Im4UvAY/yja50uej7kWjt9WEDyewVKk+JG4CR7omvbX3hn2AMJp5MR?=
 =?us-ascii?Q?z7i1CJYv2bf//0YoTOAAzbxzbFK5qG0MHh8DKKog9DGtPhTxjhaxOXaOiK7w?=
 =?us-ascii?Q?zn58b1m4CGZB7v0er2MRuADsU+uYGcQC6uwvuFAmM/NFU9+ffRRVBHPCGKME?=
 =?us-ascii?Q?DqbTwoS1hhTqu8Ln0szwLTSrx60nKhT3Buh6CTs9ChvyLIJOqyPNix/tFjhG?=
 =?us-ascii?Q?rfHol6KjnQeSi2iNIyBf5fR4d8lnK+uAtlPo0ijQelnntW/4m7wg4IyyAuS8?=
 =?us-ascii?Q?S6wXEPUKHZiv5pVe+sS0PJFs?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b2555e8-d36a-4b99-1fda-08d91ca8e0bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 22:36:29.9245 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ya+e+C9osuyHklELXZOuSEVTZ1n6qMtd7hhir16AT7My/ynXp0pZoIEh0hB031fySozgXz8Fcr7KuOO/HyyoBhDL+SuquEk5XSqH2SPFRNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6022
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210521_153635_205788_1538E8E6 
X-CRM114-Status: UNSURE (   9.90  )
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

On 5/21/21 14:59, Sagi Grimberg wrote:
> We need to select NVME_CORE.
>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=ddWr=K3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD90C47080
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 17:43:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CDB610C9
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 17:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CDB610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=phXK4bnLEakLkU73p9kvAscZ7l/t00Z6jYxsY2qohZ0=; b=3t1kYJRnFJePOD
	j5h/8bFRVeyTNRuaf2ed/BbwL0r1S1BI/KVLs+a0RAS78iQQ8TEr1ZsiMpUWlAdPsOe+XEgyAsT7F
	aZ/5kbN783LpP8vwnl3jQWpMKaMl3qVEyCWNGd1Qqe0q2QJuvx5fVRQxx0sZt++K1vbNR0tdvJcHM
	hg3UKG1kSWs/M7dVq1minfthyiDYSShRQPO/sjwBO8YEN2cFe7jYAN0+uhxGk+90zAmInHVN8WLr9
	TL3zQlHUdokby32bhHaQ7w9KFJ7DvRPcWZchmK98gsJYkRfZBEEIcSGdMZ74IFyrRlspfMg4YjJtO
	0ybOGyaPStJzVgxtQV3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lo8QI-0007xl-2m; Tue, 01 Jun 2021 17:43:26 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lo8QF-0007wH-Ln
 for linux-nvme@lists.infradead.org; Tue, 01 Jun 2021 17:43:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1622569403; x=1654105403;
 h=from:to:cc:subject:date:message-id:references:
 content-transfer-encoding:mime-version;
 bh=6MyTntGwlb9XENRjUbykSOV9u61CFZrNYalvj2t7Qk0=;
 b=gl4iBHK+yDmzdpzXdRJZ8zLYFHwsBYrDHOe0kV9PKhRkuD385SVLvMzC
 eYnHj7GQ8GcsoKphjylJJKWGMJ7eIOb5TbJWAIxpXVllwX5J4aSMWhIVg
 zqE65rgc5DaeO28i8bay8p92SORcdz7sVvOL2u97mggay+ZBk/sU9IlJU
 4BTiqgu0pZLjGNwIHMnAPW2VXBgksDp5ykHBHJx3ifglKdE34hgky0wbR
 T5ygOMBDSpEOyshNZkGMr+vmPRyQdASftagZtOD+opQ0KKIKYcDW2GEg/
 gkLLo7Tm2C0lVxExE+D2SSWRRDJuAD5cfu1AYNOSqCfi1KjeSC6BNSfoo Q==;
IronPort-SDR: 79WPhB40PYd1WoHHUCjAAeoCLA0ZdCpKqdZlsvQfYTUE/Q3VTVnbDTxS24DGq0G0vTIj5whCEM
 bGnEXs7kAWoSaE3aCsTVpycWk/P1XyCDRXHHOFCfMSiqLZYtDB8nNcMSTw43MYZifzX29y62TO
 DN/nmDaqrFTN83SEdxheftZkIlg3wAhWQrEOu6pcHE9zeUS9M2Jorb06rWcjahN0VmyUiXOAou
 JtlpuA6wmpr30kKhpyU5PQhzO3CszPMz3hZrxVxsFFBXGGzmajOkkY0qIFI5Hb3dCkKvoOJnyJ
 vio=
X-IronPort-AV: E=Sophos;i="5.83,240,1616428800"; d="scan'208";a="170305009"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO
 NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
 by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2021 01:43:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQRbAL+GYbON2wBXcFw+9FjLtwbNubEM8cEZynRIFH5M8BviEXKJJ4ef5GwqacSG6LfUwHiy1aahPdrJI7m6VnyKzf05An8NOUhsxBBliBxhW+ox07SvjHk6xHQSVHpeBo7fbKQ2h1azYhvVUP7V4I0crAxInpOw8oxNlOB0wzBDhd+hr03AKVZNvarlPEudSE0QCfC3Ob5grZzC1dwIFGsphB6dO9g6vVrpODlMNI2dEi6sNVFZ5gJHl6b47bxvzGiat8P0XvYzEuxxfmNlYt4HZM6qKDRLprbcMDEKLkyTQaKjDPho2lSeNUMVgoWCs0m5zPX2QMOQmWgHWzAGdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MyTntGwlb9XENRjUbykSOV9u61CFZrNYalvj2t7Qk0=;
 b=WVn4BGAeZ6stmNEPAps81jkKHgh2KHn4xRWzkIY1RHjyBSsPlBjJFP+zTgZy+UUaTA5g73FVG4aQA1+A5N6aVxTM0+Hz3hAusddWVHr3Sg6ZwJpdE8feOgazw1vxuij/xRjNzx/fR4XcAA9mRBiSg/fPwbuPEsYT0fmTxwWU4ha4kOT9lrm0MeDEptwuHHQpLYG+DILeYZCJAJR17dMWPoTGTAHa+9qoMJyukX1bZKp8qoVVBnaMK/ufcXo5hyLUiFYLLVxckoa/PBSJZ5vk2PjA70B+W7kXUmXcCl0hwk7L03wu49/sVXr/Iw46SVYaV++kPOrSIcAJ5TITe0/q0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MyTntGwlb9XENRjUbykSOV9u61CFZrNYalvj2t7Qk0=;
 b=XUeEaA1i/UuQJflLBuBZRyn3DJkuPEkSSq5mmGKd+hcNNHpsMgVmC1PutIQ3K24vVOB/vaFfC/q0/6k4klfmAJevLGH8TnQKTXOu2iJJFJ3wnBz0t37cLgC9/I5ClHt9mfniUSW4N2mvRQT0DjNtI8JGoLs1WKl0Ec6X1WsnFQA=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB6012.namprd04.prod.outlook.com (2603:10b6:5:130::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.27; Tue, 1 Jun 2021 17:43:18 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::8dc6:ecf:9d83:615f]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::8dc6:ecf:9d83:615f%7]) with mapi id 15.20.4173.030; Tue, 1 Jun 2021
 17:43:18 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
CC: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <Keith.Busch@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/4] nvme/loop: check for NVME_LOOP_Q_LIVE in
 nvme_loop_destroy_admin_queue()
Thread-Topic: [PATCH 3/4] nvme/loop: check for NVME_LOOP_Q_LIVE in
 nvme_loop_destroy_admin_queue()
Thread-Index: AQHXUlI4d08P2fEWak61ALq6SbK5Fg==
Date: Tue, 1 Jun 2021 17:43:18 +0000
Message-ID: <DM6PR04MB4972D4B3421E2C87D15E4297863E9@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <20210526152318.107202-1-hare@suse.de>
 <20210526152318.107202-4-hare@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 737c530e-92ed-4af2-9331-08d92524be22
x-ms-traffictypediagnostic: DM6PR04MB6012:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB60120E3F5E54D6A5AD0D551D863E9@DM6PR04MB6012.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s8ZZRMIIgsTwLFKyGKcHgtHEiUJGEV39FM/i8xMBg97RZ9ugZAA4gWHoCtPUr1n9S7FPspTmw87Y9HxVexh8Pa55H8uv87dIULKJBraLEvaMAhGwtxPF1PGKVfTtCXZdLBIvr5pHmDL92aUF4OXYgeV0GefBfAOWke0Btv+AZ2ZckSldwwYUmNW1v9hERVN0B9otD8huRtRKsJRCtrvJmAOOD5bDY7vp9ZJ+zqzIenuN9jAq7JLKC+7AzKD73WsfJD4tQdkLLrCCWia5Q1YFhMtFuiVeqmjkTCDQTJEKeT18TT1/rVgxN13u9Cbu/QjJlFEpVoyFy6qgJnGRE7ghUwkH+BXrW0TAupMChnKIcUcoGEX701PaLolcTR2deUekF+dWK0bo4VUxwfsQvBx7XWiHfp/0quXjfLcemest1MfJ4HK+b3+yEkWIEpxDt498QPG+NNrqBDvw09edwDF18sbC+NUmf8u3xsSTvyUj+r0Lt4i332k5FKdU7ft80BHCHiacU1SkYGVYMFdibtsr8AXhUnDAlice3LQhbFKXMaYxO4BfehmLy0VeHcElV1zCygdvfYUK/uhSQ0anRrM2afiuSYK2t43o8GzdbECpNcI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB4972.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(5660300002)(53546011)(2906002)(6506007)(76116006)(4744005)(9686003)(66446008)(66946007)(122000001)(55016002)(4326008)(186003)(7696005)(86362001)(52536014)(8936002)(8676002)(71200400001)(66476007)(54906003)(498600001)(33656002)(110136005)(66556008)(38100700002)(83380400001)(91956017)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?w5yn8CRRaw7UniZGtGOIHy655qW7gwT8htcktmRXOiL8PkiM0UhtCBDak/1F?=
 =?us-ascii?Q?z19rcVoWevCffBPZalXDrfCq2EvQ+rpKc4+LivuPEoRYmVVjjdrqeyMuV5oN?=
 =?us-ascii?Q?YndnR8e2wXUKUGqvJujyD/XYZ1L3+Ikacr0p8SmdV8+6jSTeBMjPdpPLv6r2?=
 =?us-ascii?Q?zC3sRl1WXdpPeaYMk2JVz7mYLrbiCwf2Qw62zAqP3ALQulfQKGgbXpibuGwB?=
 =?us-ascii?Q?ZoYSYEBdPt3Nbcea88ae8X4JXEmTRh901gq1FWwHJeu/h1mZsRETCDaRgs3v?=
 =?us-ascii?Q?nuhS202zn0+NBi1iQvakMEXCDuE+8LLLpDKqCsedBKXSeW8sTzLfb6rbqbat?=
 =?us-ascii?Q?F4Thk3+3oqOW2juieK2h+Q+hRhfwhFDr7yTuGmzLstajTiK7rbJtI7zSciiM?=
 =?us-ascii?Q?SQgs3T7I5TIeFbrCUISUOo+u22mCpvrlktLcU/wgQcLjJiayVhQdzeStsG8P?=
 =?us-ascii?Q?cLGq30rzKiNPhn72QOrUKvXVfjtmF6cRRBQX1DShC8H5bpeFzOzarGu66Yuy?=
 =?us-ascii?Q?hgpXKog3/7TkwS0orz/pkMiCx8AQeWwvgGQRFkQ8cgfdSxaIfHdXHLwvysX1?=
 =?us-ascii?Q?wEDooDtul7hw1kxnpeNINR2GFexUwf6wNbJi7vxrFd50ivZMSaiTg/PLxSiJ?=
 =?us-ascii?Q?+KGkTAafizUBRwGfuQKHDqQbEDKv1qXztUXYm/mNIMOKF7LTrj1lUKsioGub?=
 =?us-ascii?Q?TAMyI1lfP1UgcyAcLgS//3vli2TnxmqpHhIN1wmDGJ+zPXYshcrre1HRZ21J?=
 =?us-ascii?Q?QFMoam0/iOVdtHNUqXLAT8xwW1tc7tX6QouxYm7HNXeVS9DmUPh1IBG9/VqQ?=
 =?us-ascii?Q?X2IMoRzeLNs9yIQCJqTUi+qMT2TgsXX6PsO8XsgtENpCQAZIGEr/iLKKxsh3?=
 =?us-ascii?Q?oqwEOxy1qnHprKuDN4rOeZlsycyKFiVQ0KfvG0SPqeIJiokgfnhXuLqTn2dl?=
 =?us-ascii?Q?5yalJ4sK6DpbiFq7Fhn2zeam7kzUAMKoYh+x7aIsZkGwkTzakTodD7fqZVDU?=
 =?us-ascii?Q?/VUEjHpaV3mRgmgUjo3Gfkr8kK15VEXoJVBIQytccsIh3W2cSq5a9FzBbyGZ?=
 =?us-ascii?Q?VCU6IcFtoxMxrA00hnZegQT43qVkrIP/tILzlkyC43iKUxIEZjBD4nrq1tOn?=
 =?us-ascii?Q?enoPx0Txm3VWq0QXAcO/vNE5o6WI1YkKkT4/3XlLs1NuCRRorbXXOcwMYp7M?=
 =?us-ascii?Q?wBumjrtSLpsVYsg4ZeD+Y9iTR/2oO+h2Kpdy7IYU0iGvbuo5G+KzVmn6NGEU?=
 =?us-ascii?Q?2Yk/Ol98QzvjFuUf+rWEtLn9c+Jq2aG5gnT2j/KYgl028cFpHnm5L8fY2Jsq?=
 =?us-ascii?Q?jMhjl8up3mdT30/RFEHS8U8K?=
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737c530e-92ed-4af2-9331-08d92524be22
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2021 17:43:18.8013 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zyen/R03CQ1mWFHoDA5LJ0aDCXXCwkB16gMDV8b7HPp/eI97sqURUsO5DGyP4OCO+KNb5A3qP66tZPWh95dSDK8h2XA8FUwvfqrStgWZRP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210601_104323_765577_B75522A9 
X-CRM114-Status: GOOD (  11.71  )
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

On 5/26/21 10:11, Hannes Reinecke wrote:
> We need to check the NVME_LOOP_Q_LIVE flag in
> nvme_loop_destroy_admin_queue() to protect against duplicate
> invocations eg during concurrent reset and remove calls.
>
> Signed-off-by: Hannes Reinecke <hare@suse.de>

It will be great if we can document here what is the concurrent
reset scenario is make understanding of the patch much easy.

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

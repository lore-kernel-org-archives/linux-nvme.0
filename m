Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F6FCCA0EE4
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 12:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:To:
	From:Reply-To:Cc:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ar6ZC8m4jXc8fthneS4Eqotf0XsmIv73kmWIrQxBO4w=; b=zkz95GU88h4u7BTvmZcpDZ/ei3
	bOuZ8KX3k3AAA2D2ps325bS8n7M8y0LksX8RH+QznJAEIsm5Zl5OyeM5J+dEftmw20NCSziistZxd
	rCxwXbvVv/hvDKEM3mDymtYdCEEkzVuySQd8qYcfIfjASXntJdaz/OJdL7Vdm7SyG1f6T//1cXUFm
	S68VJ/FSMjWxpa5FDO+lSpaAVxTvG28AF+oGeUvE9J6aiqOLX7xVdOjSWC4P9YHS5x3k9YPkLW80o
	QbAmAJIiwM1gJoEFofxW2y4wPSTNB8Iyciy1VqK5/7JBNbiE3hVaoknKyJO9E3SwRRud9zUNauGxp
	dPbDLcjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umArs-0000000DfZ7-1Bxa;
	Wed, 13 Aug 2025 12:46:12 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1um942-0000000DQrH-2PQQ
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 10:50:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1755082238; x=1786618238;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=JcXH9foPLypEmsjMCGZnRrSMlljOymt8DEVhCzhra5g=;
  b=qjXpHGAPd9WVSxGtcXRbKeJlLj73dS2n3aCn1nXBTorXEhaj3suarfL4
   poB9kD8QXjaD7WbV8F4m/zmHeoKZonGZoOsw/sa4YqSmiKCOHHUmgaIbV
   7cFE0jN5wWFPUYwCadv9G7+JSYfJq2fDwh7P8nFJkOjT9EXBYcb7I6cwZ
   1u74GO78iIr+lCYlhYxvP24QL/VIruI/a6Im6FkixFch9XYXgp12uRsxp
   V1Xxi3L2NTlZXn1dTdb1rIqOowZKnxJICbXB/TXF5zzO5SpGwnqqaHjn2
   Mylt33Er/tznfPXA1hCf5CgQSxdEAmxGS/XyPfEWic9+NNwBYswNDePap
   g==;
X-CSE-ConnectionGUID: DIXwahxBR3maKRtDNAN7EQ==
X-CSE-MsgGUID: nfs7hD4nRCiFANhTp0r6QQ==
X-IronPort-AV: E=Sophos;i="6.17,285,1747670400"; 
   d="scan'208";a="109204910"
Received: from mail-dm6nam12on2075.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.75])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2025 18:50:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDwBQdPq7y883X2l6WwoPqlrnP+O5KwxwP9ZUT/D9gWNYw3CMlk58/sBdmfcmJV2CikZczUj/o15qsXAPKkJhLE/YajPkq910D3qTkGBJ1uIaM/Bi+doHBUIcQCgJcKue0vaJoDTA5RAj98k/DgT/1BWGebYbg2tN/7HS3836W4zRuFHkTf0GAOeYoA7xn7eMDRVQcCIu/15JIlOZWeY/z/KD7Jc/gZEwQRBA1mbwIqhANIDFWeNHKfejxomTbztZ2dmo/VlJoSrsug5IDppVdlY+9+esBQnaxa6k/zszqM41+f2Xdtg9IRwtcKApBxjqptlOpV1kkzet43w482hGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ar6ZC8m4jXc8fthneS4Eqotf0XsmIv73kmWIrQxBO4w=;
 b=SIATl3gtEzijZCuWHY8pORFd9YwXwaovfRIYsxalqdCrhxyCeTeUqj646la0vejFpjyJd+j63p6gd5PRUsuz6D/4C8maUvmzgG3gjsdWFFy/bugmSzVMzzTo7PisuUIbMHaGj5BZsAX/c1diPWETkhHEdMdXmChvib9mfrJSZhTYATTuz/iBKEmnNsLyevOAM/q/f5xdoe7EhZil35MjLD3CsJckQuAsTq5sJhye1FuX0205cmzmxIBykBzk1KGzowhCdoZfDIsVW6v+JxZ2iSQeFW3D0TkgJGDvqcPu3geREod/jiSZHvoG/V1L0TPdv1H0LM1XOggMjY4dIeiWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar6ZC8m4jXc8fthneS4Eqotf0XsmIv73kmWIrQxBO4w=;
 b=j03fOgqL/ACl7seU30VUYwMm0vqb0eZco3lVbPsgJtDSqfwkr8nal5mwDnS+nqcLBSvSdFEEwSPSyq/iHInIeuVXfEikJn4qfQ8LQEqnpx3xxTOKExSh15YC1eWtKRRNS8eTPb8g4Rmprv4O6CIoj/Eynf9zge2Uou+L7gH3U9E=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM6PR04MB6811.namprd04.prod.outlook.com (2603:10b6:5:248::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.16; Wed, 13 Aug
 2025 10:50:34 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.9009.018; Wed, 13 Aug 2025
 10:50:34 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"nbd@other.debian.org" <nbd@other.debian.org>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>
Subject: blktests failures with v6.17-rc1 kernel
Thread-Topic: blktests failures with v6.17-rc1 kernel
Thread-Index: AQHcDEAYP1DNINhgd0uqNNYw6OHN7Q==
Date: Wed, 13 Aug 2025 10:50:34 +0000
Message-ID: <suhzith2uj75uiprq4m3cglvr7qwm3d7gi4tmjeohlxl6fcmv3@zu6zym6nmvun>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM6PR04MB6811:EE_
x-ms-office365-filtering-correlation-id: 633a49da-4b7a-41f3-ac17-08ddda573b16
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?8RF0EQayp688eM/Uu25BDev27p3L0Pp1yshUeSMYAwUSIAWkRDRwhlgWFtAk?=
 =?us-ascii?Q?7LT9tLahJaYWIi+sEpNlAUkoIVBWLUhGMF/BoiKX+IPLdlRfb3v3DzjWc2aJ?=
 =?us-ascii?Q?Nv9vUJcjKKjjIikQbIlsm9dxtwit6d9vTUE8Sg6NiZJkDgddQB4ACl4gedM7?=
 =?us-ascii?Q?NRxUIXaFkYBbE4qSWm9hKz6jI8HbImPBRIcLYR4HitaWt0haFeSyicoMdDyd?=
 =?us-ascii?Q?p94BOZwsswdFwXpJh6vc4M14RQ8QIuy4Fgy8f5CiPThmyTK9ZizuBhE7is3j?=
 =?us-ascii?Q?LDlVZvgTf3P4l8aAMWZUbN62QIgqn6MJtNGq+uwRn9n+zfxUGvNl2BEoQ+UC?=
 =?us-ascii?Q?1gXfgL7QFwRcp7Z+9Yc4IrJyzryJ6wP2vbOoyl6brK2kFDebFXgA7MTNQvsL?=
 =?us-ascii?Q?pXR/bQGaHhrd5/eVPQcL+jQ5bSHGOF7yqgTGSCShnGZSiVpPBuQTU+XS9BDE?=
 =?us-ascii?Q?XvtQO4bnbiLiPkfiEmCt/ss4GcfMbMXt2gZvuXYIoPvXU0mVJ2ONA+b6+Yl4?=
 =?us-ascii?Q?djfMIPC7U14GpACmGKtyNe8t2wnbbWOdSDb9eZyNdgigHwcvrB1YDAM64SXU?=
 =?us-ascii?Q?RxaqgtihXHwO++w+PVWnONFrilARPp5WTz3pZwntIhD2hnxzxuTLlufKNbEZ?=
 =?us-ascii?Q?5Boqmq7tQYGCpzhrYpZhNGTW86+5Iqhx3mXgrxOzwkXg1zbAV0cLl4Kg9Qrp?=
 =?us-ascii?Q?9kQcITiLjNxlGOnmR/nuArFHguV6oWCEIqtpn7P2sZiyMh2jY1e9fl51dBum?=
 =?us-ascii?Q?1AeII32JHtmkARmTypH6BaU4ZRGEprTv5T+aYHOVBHubg0C2szblm3xADTe3?=
 =?us-ascii?Q?thUXWvk0N61YLaEa1fkjdmroOP5PFr5Fm3D0uOIuN/AAHkDW3DJUukclVMju?=
 =?us-ascii?Q?NXnqsw2t+G/ozu2FISPTKgjbJWJQS5pu/B+spGUcFD6gKTz4PYsCG+ivbxoU?=
 =?us-ascii?Q?Qg6gv5hpgOYTb7QQDJlcGC+vzAKVI3oBoniTV5T3KDdNniX2WFnN3xAfo+ai?=
 =?us-ascii?Q?5/sMfK0Z7cGPW1WjfWWeSxptpXlXJ+2Y152fbcdRM7H0e13q+/2UU9wYM8Qr?=
 =?us-ascii?Q?l9MBIcL3PxTgNRBtaCb7yGvCE6wZ654DSLwrlJzKykiG5eomhmsWVL0T2aAu?=
 =?us-ascii?Q?wVMRglvFCSn1AcqK27qamfpKw3UjwONFKD1wvjsCTvCn7CDJYF1IzuQz4ZkR?=
 =?us-ascii?Q?k4Kd3UyZrtbcY4p0E43jwWai0yOYdXRVpS4VXSgnSCN029O6nKzJLkNxTESN?=
 =?us-ascii?Q?jj4YGO/viWKfxOYpNN7bVfU7k5QUOSc5utygS9RUh4HF+UoTNE/n98T7WPN0?=
 =?us-ascii?Q?0bM4JitCl30r3dh04ck9UaMPkD4NsPROeOj3BytEoDR1kXF/MXHVJkbaYDtl?=
 =?us-ascii?Q?gSk0TjNRnZOW6rSsodF8uDqOQv3ksCWscB8eE57tI3bMGwOyCn1iasM/CTbm?=
 =?us-ascii?Q?7FnVrC8Har4y/xG46j00AnjnqS1v/0vnbahgFCJsi5l5HaFmEKstCPmj0QTo?=
 =?us-ascii?Q?DA7cQFPL0aTt6PA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Gdu+1PJ6FYO1U3ff/tocKcdrVDltnQZ/Sc2tFmtJnMefORLNg1NGNuMpT5uA?=
 =?us-ascii?Q?cQstvGy++SD5BMeHQ5Yr+8T+gv72aIarFuX3/O2GAPzC8osTmpsvv/9hBZmp?=
 =?us-ascii?Q?C2IbevYEDJrybE5HVjam5iBIau2VS2vAC9FQAtrBiwxfL+K27Zd409nt6WpG?=
 =?us-ascii?Q?gnA24pckkoFAeMtpHCNQv7iq1TOsIXbWc5D/mcyAdRjn0/4jaynAlYvl6K6M?=
 =?us-ascii?Q?JuE3tR33efLwTe3+i3Kt5GKGyP7fG3yzuyLAJT+4Yp9PmP2Hcgv1KAZ1eyX4?=
 =?us-ascii?Q?U92Heil+6iBI3krK6fe4VYzetcWpC2kiHwP7myitedvQJBDUj9NtOkU0Kcc0?=
 =?us-ascii?Q?15C3KBDIFZDtGjXel+KRXxmy82TDjTD1fF9HqwKN7WtRtPRLoWjY30OZIxQ1?=
 =?us-ascii?Q?Jfo6IdNHZBRI3XIw3H6hytGO0+wL0RVBI1QdthzDUpLj7ltH5DxiQ9Vj4hgY?=
 =?us-ascii?Q?1CbTmbh7tzjUbmA/Tjxf4FNq6xZzkMbnGQSwrUgqPLlScmzp35bp/DMnIU9l?=
 =?us-ascii?Q?CAsWgpDlmwVh2Zn5OI549fvYRJ1pYnpoGtYR7qL+nkR+8mC2+y27T7J+S6z4?=
 =?us-ascii?Q?scZlJ9R5RJxT0GK2BY/fZt9RlMb/h0RpRYACBniHtL1h7SZrWsFM5S7ZPvG4?=
 =?us-ascii?Q?ZdDV+ueeGlemYZbZlRALrg2+bhEROltPgk4JGOtNaJZstC/6ZF3YVmUHDyqY?=
 =?us-ascii?Q?aaxTg7JraEK7ldMm7i0IMvPxlAeTVN2UWEGjxqhCGjt/DSomOmxaf1R89+Yg?=
 =?us-ascii?Q?vYP3uSvn/QUxxtT83pHHVEOoyVvBmgd5xN5mQWEmLDbUhZb49eIeVhrWLzjP?=
 =?us-ascii?Q?iMP/kgk/rGNGU58qrPIRbcqJQ8Or94RagF/ln2sqRPFljLwHgUlJT465bnbb?=
 =?us-ascii?Q?xJi+SNb2AkEcwsBzmeeI2P3OD1MMP/jbycAS8NZDC+/7FEnGQWdxEjtUCBik?=
 =?us-ascii?Q?ucdOgE4+GgfUKKH5gsC9jRJE/kogTk+JkW32wHMZsvNIcmcr1HGcjeoSro0Q?=
 =?us-ascii?Q?Qj1BcPYdkMAbetKSLqJmD3LcPQGfUmez//qrb/pi1dJgounlDEUxppcPy1E6?=
 =?us-ascii?Q?Hmu78bJcmd5BNGeJgbbsBOwpWwz8GexPND7dUpGkWATLX8u4JTEwcoltDhqt?=
 =?us-ascii?Q?MeM9Hb2Ubh1fjbw0Aie6PftJFuzsp5MinEmZ2YUhVmX8UPrZj9EPPtNzC6kG?=
 =?us-ascii?Q?DyTLJyRb8XV2sLwN9h7P1ynyaBoH+2bx0nI6LvZV9XIob2fx0hn1eCLJCf8q?=
 =?us-ascii?Q?rT7V0jpSqrKZS2hVDSSbZipCEQtLyqBhHdajkekoEhtMhhuItYVElL7E9IMW?=
 =?us-ascii?Q?YYAm/MZWWR184my6Axpvhe4KSVwfm2LDw/0P4zCWNEj+8v4IbKQRyPGDGrI/?=
 =?us-ascii?Q?pHTX0UVgJxeQIc0pE5frOPCtYH5B6Fb+qmP1KJQnOTpwMwBC6hbr0m9Q2MJ0?=
 =?us-ascii?Q?BiaDj05SRTuuJewm1fjix1hPf4ANz7ofNb4YhAvzhzTQW2ADmzSMlJw3QoZ1?=
 =?us-ascii?Q?4Q97RdfACRPvVCh1Hmmc5/AVaQMSY9DZrKgpm08G1Zyl7IkqGXcb1cZBmRsF?=
 =?us-ascii?Q?qWmBXFbNF5g7SlDnNrL3L9bp1uJnwnEjgSf3+h2tqs3xniMvB1h08fE0IBrx?=
 =?us-ascii?Q?EWbELwBgEEFt0tewArrBRaU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8CC2DF9F6081F24DAA4F61DEF1A483B4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QsgI9PbQvcAVK7yJNg7qxCCEejujArg/xwfHgcRvLVi/Nm0fX/cjME+9/WRc8SaktQ8uboxbojUEJudwx/AsfmdvA5wuNJQ2bo7UmheQR1nPJfeM6ravTVupOfr5z/LWgTogCy2l6QBRKL46i6mTyiqqSfnyHe/3efrw9zFqNeyWa3yMg6GGlrRKwsC4/hUbpUYOKzfyjVEFRddqN2K99IryIfhiqzStxrotyZ6edDcfcpW4iC94g+KcCIg1VkSHsEdWwB+m8mPJ/m9UFrt8vWxYty1RZeVNl4FJoXaB/4/QQh+2SEVXgRL+0SUjkdrfqwWkKWuIiovVJkJLU2goiYYjI0W4s9Ajgk/ySSNSuHJ73LA4fBCDn28JsFpu3zjZ8VCmHxIWP5UnFNLqAiQX2PyUAnx3vsfYz/imy9ASUxDM7+o7xLBRI0JEs3M3JnGdBX3CH6AUTe2TnqIMLEWI3jRVuywzQ+8TNk3EvJfTaNcLBg0aa10JMVktPRJAKcF6fm0Gx83V3o2a8Gz7Tbcca8ai2BlhvvZe2DEWwh0rsiYiIZP5+5n0N+2Mpifvze8CyqFQP0Zm467NWEnG9jv5jP83ptLT2Z3BtLWjyUxwHRP71ILxBvGdhEjPEkUeKld3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 633a49da-4b7a-41f3-ac17-08ddda573b16
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 10:50:34.4508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hoWqiGDrlggT0k1vI+z4dUyMgQB3MbuvRrndisVSKIZIVevGCcP+ascZzjbfH/fsfb3M2f+N8xo/ZTb8fyFY2XAjvrsxjXZXX7uIl1FfRuM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6811
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_035038_709878_0AA72B2E 
X-CRM114-Status: GOOD (  10.82  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

I ran the latest blktests (git hash: a08678c0cf2d) with the v6.17-rc1 kerne=
l. I
observed 6 failures listed below. Comparing with the previous report with t=
he
v6.16 kernel [1], 2 failures are new.

[1] https://lore.kernel.org/linux-block/g4svtamuk3jhhhzb52reoj3nj2agi4ws7fw=
yc45vca5uykjkb4@glfr4emapv7n/

List of failures
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
#1: block/005
#2: nvme/041 (fc transport)
#3: nvme/050 (new)
#4: nvme/061 (fc transport)
#5: nvme/063 (tcp transport)
#6: scsi/006 (IDE/PATA device)(new)


Failure description
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

#1: block/005

    When the test case is run for a NVME device as TEST_DEV, the kernel rep=
orts
    a lockdep WARN related to the three locks q->q_usage_counter, fs_reclai=
m and
    cpu_hotplug_lock. Refer to the report for the v6.16-rc1 kernel [2]. Nil=
ay
    posted the fix patch candiate [3].

    [2] https://lore.kernel.org/linux-block/4fdm37so3o4xricdgfosgmohn63aa7w=
j3ua4e5vpihoamwg3ui@fq42f5q5t5ic/
    [3] https://lore.kernel.org/linux-block/20250805171749.3448694-1-nilay@=
linux.ibm.com/

#2: nvme/041 (fc transport)

    The test case nvme/041 fails for fc transport. Refer to the report for =
the
    v6.12 kernel [4].

    [4] https://lore.kernel.org/linux-nvme/6crydkodszx5vq4ieox3jjpwkxtu7mhb=
ohypy24awlo5w7f4k6@to3dcng24rd4/

#3: nvme/050 (new)

    The test case fails with the message below:

    nvme/050 =3D> nvme0n1 (test nvme-pci timeout with fio jobs)    [failed]
        runtime  90.974s  ...  90.912s
        --- tests/nvme/050.out      2024-09-20 11:20:26.422380826 +0900
        +++ /home/shin/Blktests/blktests/results/nvme0n1/nvme/050.out.bad  =
 2025-08-13 11:12:54.655610693 +0900
        @@ -1,2 +1,3 @@
         Running nvme/050
         Test complete
        +Failed to restore /dev/nvme0n1

    This needs further debug.

#4: nvme/061 (fc transport)

    The test case nvme/061 sometimes fails for fc transport due to a WARN a=
nd
    refcount message "refcount_t: underflow; use-after-free." Refer to the
    report for the v6.15 kernel [5].

    [5] https://lore.kernel.org/linux-block/2xsfqvnntjx5iiir7wghhebmnugmpfl=
uv6ef22mghojgk6gilr@mvjscqxroqqk/

#5: nvme/063 (tcp transport)

    The test case nvme/063 fails for tcp transport due to the lockdep WARN
    related to the three locks q->q_usage_counter, q->elevator_lock and
    set->srcu. Refer to the report for the v6.16-rc1 kernel [2].

#6: scsi/006 (IDE/PATA device)(new)

    When the test case scsi/006 is run for QEMU IDE/PATA devices, it disabl=
es
    the devices and causes I/O errors. On the worst case, it makes the test
    system hang. Damien posted the fix candidate patch [6].

    [6] https://lore.kernel.org/linux-ide/20250813092707.447479-1-dlemoal@k=
ernel.org/T/#u=


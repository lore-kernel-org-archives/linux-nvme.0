Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A405CA0FF2
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Aug 2025 06:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=evF4ujc/Ny1Ywai6d2Y0RxBIEiwp83kkICyzp76uxt0=; b=fCchOWtHAh60eAaTYKc05/JJf5
	warGehRtsgpRyF79JwEtPYYBGG5oOG87Wpr6vDeH4kEHogMxmWsGYRpE7lQ4esAcyy5iPSrjuwlLp
	SjEut4FKmvNQPshoKbfWdljGBe8EJ95iofZby5T8Hos01cCsDKJIscONyi2kULDrxWEVbwzHesIih
	HGAtmfDnFM97G6vfcqrv3Jq59lWzwhmxPMLmR57AdVyaa6LDRWfew952hdYysk20QuQpBniAqP0/E
	C1ZY7ghTxT40/V+JqRCChDN+m39I7fJj8D/OeGHSuE/cW1EfC9yMvCszuqg0tDFCfw4VweVLdxrvb
	IQ/htCJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urVnG-00000000P0K-2oMA;
	Thu, 28 Aug 2025 06:07:30 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urVnD-00000000Oze-3rEO
	for linux-nvme@lists.infradead.org;
	Thu, 28 Aug 2025 06:07:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756361247; x=1787897247;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=evF4ujc/Ny1Ywai6d2Y0RxBIEiwp83kkICyzp76uxt0=;
  b=iVREm6kgx0J7dgYb7AFE30Yml/rqzO7zYInbvgEjRZeSI0UPQXgJodDR
   2ijZ5jeGW0HyZJdarOdY7cNEyqcE72yGBowpCfbJdA6dQVwuNekOOzPGW
   Icb6+GAU/FDzptlg6XAldvOoN/VX6Ee19DtclkEHCv//ljzcJPRvW6/1w
   HXL7JCwV+cj3qpEldAisEFEcnYegQ5VS3G0uPVrCtRKpaQq+39LxpC/uu
   gY/Re+GfPPKQcHoy8+Vlcir7pbZc9CzrTCkRVWSMhvl/8Bg0WVrSy00AR
   7MceIOZkzmd9rfYz/M1NULjMexK/XPoYfo/MkU6roMBRYCat7UV1p1d7p
   Q==;
X-CSE-ConnectionGUID: tBeOaTmGSO+A8ztaFzfRBA==
X-CSE-MsgGUID: cBp/I3ufRXG+azqpafmwwA==
X-IronPort-AV: E=Sophos;i="6.18,217,1751212800"; 
   d="scan'208";a="108774561"
Received: from mail-co1nam11on2072.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.72])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2025 14:07:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AV5jrrNECp9/4MiDzV/yr0ef91kmyA39S5whxfyUnw1u/UOUFzzkyC3+dTZAA0kJcUhjAjW50Jtrjp66KBzTS0+wMnCx/TdtgFtkWVYQzLiFSKr8vk4RJTqWeWfQV3MwHFrz3WJf2aZOEqhy8VLxo0xcW++TgsuNQFOveRONUIvH8Zd67i7SQBmJnCB30dqMVvNo22ZEAdKB0ED+I87P/yLiZot3lkvz1KpzyMSl+3poe4IFTyUm9bxMYwG3lTROtXulPugaudVob05+rbMFx1D58Bp1rzerZ0QUHI0h4/HbSMPz2JId81wj4sdT5WACw8cPu9s/2zUApO1mUcvKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evF4ujc/Ny1Ywai6d2Y0RxBIEiwp83kkICyzp76uxt0=;
 b=TPqHvSa3PlUdLBU6VLclQLtEAe5X9ET7FnKvTBWAVtI7kR+Fjg5Kpvfc70fjuAuf1zhYjwEbeCcvMAlD2PC3jvc1tU+fTANQi+lQPWMv0ZVVajt/MO+9kHLT+RAGi2XZambHtpmw6b52ChEmREy6Os/CxEKzFCpGz84yDxSngjNPXLvmcJGUspEdI0saxM3iv6xNo20RCGyO4WjvQrrj7Zkpe6xgzxH3n84y6TKRoWNRz6ECeQL1dKqWusJQbnNsUGIxmxUHse/tMPT+XcQiOc/yV0RkgaJ8ndqqzsQQ6vu2Cx9QS0YqLSEjhi+Irwr/CMmr1P+5KrZiESTbK/TvKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evF4ujc/Ny1Ywai6d2Y0RxBIEiwp83kkICyzp76uxt0=;
 b=PNE2tN3eleQBXvC2DsIDb0spny4HsewJI4AO2WVCLXzBGnygtk/Wrc/5xjpKIg44XOkETd2Vm7BBj04itYKjV8EAGx2fbPI11G8/04nxRbVitmPpTu4fz+46JxenFUAReN1d0riL5J11+QStxXXKPC6R0hHFQuqY7tuJWbX45LA=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM6PR04MB6697.namprd04.prod.outlook.com (2603:10b6:5:240::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Thu, 28 Aug
 2025 06:07:25 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.9052.019; Thu, 28 Aug 2025
 06:07:24 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "dwagner@suse.de"
	<dwagner@suse.de>
Subject: Re: [PATCH blktests 2/2] nvme/{003,041,044,052,057,058,060,062}:
 update arg for _nvme_connect_subsys
Thread-Topic: [PATCH blktests 2/2] nvme/{003,041,044,052,057,058,060,062}:
 update arg for _nvme_connect_subsys
Thread-Index: AQHcE3sknCCVggSOMEafs9T3e5MhwbR3nROA
Date: Thu, 28 Aug 2025 06:07:24 +0000
Message-ID: <xzg46ktkarycxmt6i6mftgoiru6x423734atobtnjvhnnjjece@b3jyoudka4s2>
References: <20250822151159.3248900-1-yi.zhang@redhat.com>
In-Reply-To: <20250822151159.3248900-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM6PR04MB6697:EE_
x-ms-office365-filtering-correlation-id: fd1d6c04-6e7e-4e69-0c9c-08dde5f92891
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?L2kpbGFoblqJdlkcA5aj2/L2cekmQZh1NA6dDqVqOda4jtSwaM1tai9n26NX?=
 =?us-ascii?Q?e0siK5spad7AeSdGtAgOpK68unT7gUgXBPCSTclAmuzczX7BFeiXTgBtY6jl?=
 =?us-ascii?Q?C9FkmDFSCvQA7oFdiphWfuXj5bqZNI0U/sa0qf5/mPZhcokcsfT0yHx+pAkl?=
 =?us-ascii?Q?hYvYBIqHWZeS8/vfgWZ/F89fQa6NwhUvqCULJvgjNG4O3+rzCBCBvXNkYm7G?=
 =?us-ascii?Q?s2Sc7BRhQU3ZUoQVgNHBTGAjA2rpHzjm1ARrvUAFDnM6a7CaK+QESb2nJD7B?=
 =?us-ascii?Q?F52Z132p72kBqVaQTnNbPQXT+C6qpv8PztsguCoR5sFtMoKkKD7+j0E5GFDR?=
 =?us-ascii?Q?LCVla4mpszpxqqJle2pwUwZ4vMwN0OLFGLXLiFXOuNZG0DA9vStOpwYu+N07?=
 =?us-ascii?Q?L+EeUqwGLhqyVn+GusoqzTKwFDXoZiFLQ3wJ8hmOWjnQSYaUwcENdiuOb7Cd?=
 =?us-ascii?Q?rKFywtaSDrCvELmYirNp5jid1H1e7NLTtMBE7NyoMt3Tp/SlUM/Eds+EfgEl?=
 =?us-ascii?Q?7iiiFSwWQsKcUbx0kgPtLwpQaqA3+PQXo998B0rFXaNdjEUDqIqTh5PgQfek?=
 =?us-ascii?Q?TeUYnexf24Om2vMYnCN7zor1ZS6W0oxa+25V0DYQn2ywC3Bk0twdrR52MXy3?=
 =?us-ascii?Q?kAAYKthngWOhvMLDdPZCub5OJ8gIgu56P5TCVmHyQAdM7sRNarXsk2Cq+Kie?=
 =?us-ascii?Q?5mPhyMh2HB07ahNPvBuiXALXxRgO3zrTHhm6ZxLSwBruS/TXzYMPt8PS3G6i?=
 =?us-ascii?Q?+T5CCsYsRZdil/nOZRdQ6/eeSmA7hyFKGmmjRrqZ5Vl8WlM05oBrq5s1OuA3?=
 =?us-ascii?Q?WVm7vjlLOvqnTRQb2q3AO23pf/s+rFzKJY0puW5exMnJYfBFcGlvyKV2Q8uj?=
 =?us-ascii?Q?/1/bylkH+mscXIW5aaUEbx11qHUpWS9HG2HqhFI0nuTkxzZZ4iP0SGDVRFch?=
 =?us-ascii?Q?j4e02567a0ZHdTb/8ie28GR2uPifGYgN1uHHAnBLRVsSbi8tItR6TvSj3w3U?=
 =?us-ascii?Q?7ZpcOGIDH88pl80OHXwYzt5+fkemebWAyt034yopgcz+6EloQWw1ku3z2l27?=
 =?us-ascii?Q?CCrAAhOCo0MIsZizd0v8nctIwneCz80zo61bZ/564rruNvHER9yGJ6qEPI9C?=
 =?us-ascii?Q?AKuH4yEHPeIpCc46LNqmAFRuoGv6xfNbI+XrNJng5ogrvl4WR0ZCgh2j+EJp?=
 =?us-ascii?Q?iblWIoWSxbx9n0M04uqcfn0cnLyg3v/3xtMx3N1BBb0eZCiZtUNYUTWKzpjV?=
 =?us-ascii?Q?FoML4eDjDVML2TTIWrUAtlv420pie35hwZ/LR0VuLGzZ1rk4uyLBbUlvJNGS?=
 =?us-ascii?Q?sNuQAH8oc7H1Mg2Om1QpuEITIWsdkBWRr6LtULECrVC+LsQKs9/Vop5x+mpT?=
 =?us-ascii?Q?SjNCjV4cYsSOk7AopAepzdUPgyx/QSnkSu/49yJ3apAq+Bm1oR1tpB0MkvsS?=
 =?us-ascii?Q?Dvzmc/6AIuLS8BirAfPOUMqMcg5UX9JBONZf3+Q/pBXTJNpOTglAcA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Sc7CRVJVMZ2NZpfvGFJvWgoi7mpIXzZe+FC5j07zNw73vjDY6635f6xxXxqj?=
 =?us-ascii?Q?ZUTJ/jqW2lVpLnjaz1/9CBCBwd62i3/ae2Vp+6+M8+uPf/UEPcrlFNDRBlB9?=
 =?us-ascii?Q?8u4k3TAjrdNm+vUXxca6aYeOnqWYbFJua2dJteUIi8WVLO9kvQ4AHb8rvkGy?=
 =?us-ascii?Q?VLPiIp/39rOVPPksmc72Uro9dnQ7cycwVD1wlPu7ucORXQnwdoLXbojCtOu4?=
 =?us-ascii?Q?bWotfHBcdOgf5y32OnZUUH7A88Jp+R/rsoTZJCxlqJzCIJkqVPLot2Wz3n8C?=
 =?us-ascii?Q?h5Q/eHdzgxh1oxgyb+IGf/HAZk0f576OjdJmAZ+DoSvib8nzJUe4IKRJs8at?=
 =?us-ascii?Q?5SI7M0+jc2RAbEg9XQ+z3dY2WUmxFZq110E/Oy9o00MXJVEaznQEe2tC0bsr?=
 =?us-ascii?Q?Y+d7t66BzSa5Pua9ICj6IfGL5qedhKGGvgtnlOhEw8oQRJE9eknbx77DzTYt?=
 =?us-ascii?Q?MhnKAp4etTtk8+jScPEZ6RkrrKpE8cYX3L/hX0IOkQh7PfYUFNsuwpWWYrBb?=
 =?us-ascii?Q?fwu412d0JI3GoSB2ARzs21CL5uQRcYGKJePfbQGsb/WvrkazpuAdUDF70+17?=
 =?us-ascii?Q?elcOHUVY4juI6bIwHHKQ7YKbL2U7Jfmx8KK4eqht3iRteGLVNiDMWbn4HXta?=
 =?us-ascii?Q?wLz417dgzn5OXBK8Pwgn00Nc0f0lFFmtVvH7IV24bt8lVangJF2f27pxyTqM?=
 =?us-ascii?Q?7jbuz28TE5EuSOmwv8f9KajAN3R6u/H/L87gbJzbx+ixNKTwzltn7Y1PKpAO?=
 =?us-ascii?Q?EGoV1DUk0sQwSgDLZ8YEMciFBA898o7LAJVH+Tu3+Fj0YypTko/Do8KuwwtF?=
 =?us-ascii?Q?C6BFTJu7GfRyCi++dBhoVEE+qcfOIZq3RNsEoLZjwqLt7wAQuCgiPjPzjFsa?=
 =?us-ascii?Q?sfkCj7/GK6Vrt0IxZPqCjnFKR/Vdg/8ftNYOoDXBxvgw+lGxbabDiIQCUNYG?=
 =?us-ascii?Q?ERGJh592EV8GjDpDOeKKi/GdtnUWWRay8yRcySGUWe989vGJzP50UIr2qkD4?=
 =?us-ascii?Q?aBjQQlwU14ZBr3MXyU1xgfq9V26oSYq7zVAi2bp8P2wh6B8kSAnUPaodt5NY?=
 =?us-ascii?Q?5yunky6wSd/a4MZGMR97HU7GNHv2Dwo9V2JJthClJD7TPe97ojc57wlp/lzS?=
 =?us-ascii?Q?hm9/ctUFbVVG8p+2K/joQFlPXFU4nssqj90XyO0s5jBabjIrpUbuxlcdxJiu?=
 =?us-ascii?Q?j0CRbRDmiM87BItLKiOrIS/scVSx5035UsxXOsFltM19AiKJxhrdjCZJ4kR1?=
 =?us-ascii?Q?fO4iXn9YbtL2bHOYQEC8YSY9Q7XmC6JZowpyDMIXEiBzosif3KdmzT4H+mX3?=
 =?us-ascii?Q?MaoiSr02fPuBMmWF8A4YsAO8ptfEiqHW3EH+8hb/T5urEl7DU+tiFqo+UR09?=
 =?us-ascii?Q?mvq0+NyuABa1i1b8wrSiRSdI0y1AKDbP3s3iQKLJGq4MMQFHXDBwuekqDsSc?=
 =?us-ascii?Q?Je/VovNvVz0zkVylBShF8Bw61tBNp/dY1Y5GXekbdPEWTeb0xk9nnQz8wd4D?=
 =?us-ascii?Q?bKr6a2uPlZKPf/o5Bw4z845sswtYGphFYKwa+gLFOeTpVNHw7NCcAxnly43o?=
 =?us-ascii?Q?mpuf3bEUgAzCP5TVT49y/dVtH+L7+xbYLDe7QLfMFqhxmydr3bHaaYhwN3Yz?=
 =?us-ascii?Q?mQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <355A062BA329B443AC43651D3FCD3172@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LCAO4NRxN/pfA1UPo2rb+AjubR1obK6mOrKx3Qx+fVi3UzgdmRG2yMs7M7RH0pkoPsEox7/IHFPGRGQ5z1B4i3H4VPsq7RseLulsR3AV3YnsNBGgejapOVEb8QPsNMhxrHsPYRaChX20g4KEY7S6hjZXM8ATl1Vn264w8TqKI+eB6JlZ3ST/ME5rU61fL0pO+0sd0IA7IBG8r/HmLIRXyGdnYxUGcw76h9gj/PqSdKlE+00OVj0JW9yJnWk/i6kI6NuyIJfgM7oyHjM9PT6EhbuCntbAtHyi4yRwqphVq/f4ozt8XnVTb/G31DZA1TBNqDz55M4qSlC8sC5PoIXeOZ1Fyqd9YJPjd/6mmy5wox8mfgq8QHNabxSn52iNTMqflWgtYTizJOKl5KqyT27U9KFsMbsma9BDI9YAhbcm+DbW3rpNUxgzBOvPhMW1whqUoYfrdQvD6lnxalZcE+NTf+Mq6kDVqWa+Kv9K9Z06nqo6a/FThV8TDMPQhPwXv1HdlfaYnQwE7Mw2HL9gSIxa1Wou2yHiBbsNlNjoPxf/OBFDIq/7UFQploke/do4RCuE7oNd4tpZt6AOa+sphUcL58XFubYxApp0EDz3mmnkiGAzlEHQfQZ4t48eVAgJAICj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd1d6c04-6e7e-4e69-0c9c-08dde5f92891
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 06:07:24.6531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 43nATolzp50C2ornrl0dnvmzHZsXVbDTaUC5S+eNGwhPzcrYTeznKGrWWObjX8DB1JoUD4MLO5AaLYVTkanAQMRQjNVozedHP2PYS6un/y0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6697
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_230728_019511_3C0A8C8B 
X-CRM114-Status: GOOD (  13.31  )
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

On Aug 22, 2025 / 11:11, Yi Zhang wrote:
> The previous patch changed the default behavior of _nvme_connect_subsys
> to wait for the namespace ready, but we have some cases that don't need
> to wait for the controller or namespace ready, so add
> --no-wait-ns/--no-wait for these cases
>=20
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>

I also applied this patch. Thanks!=


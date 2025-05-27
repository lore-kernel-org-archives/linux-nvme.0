Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBD6C54ED1
	for <linux-nvme@archiver.kernel.org>; Tue, 27 May 2025 10:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XGXnEUBc/BdmL1SOm960TdSnexN2nVZA56OX3J/AZX0=; b=E17BPbsUpCB8RQZd1KfdO4VY2v
	o36RQkKgzXojVa13FaEjfX6Cf+Wfps7Tec5OhjKckRvypZhdTQLMhf4G6oq4NGjtkk7K6LNG5UnGI
	rRY0a2S7iSJ340LnlGwwJAkZx9SEAZtJ9Z+S2qYelhvKIBriaDDa0Y5mmW1iCLLxCr8AyRtARv9vW
	xP8BEy3rRfeyoAL4yz+glqvgFfn4fbR8bxEoMMhkwR5LiHHEORYxXU1T4sJzKVkoZyT5WOuBIJYmE
	2GyeEWBJ9ptjBvt4Llx3rDs13ZGErUhcM70TN8bJETIhZ0GUtntADakLWjAAmKsgp3TaSO9+WRvQd
	TjGND+kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJrag-0000000ATNI-3TLL;
	Tue, 27 May 2025 10:31:26 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJrad-0000000ATLx-49gF
	for linux-nvme@lists.infradead.org;
	Tue, 27 May 2025 10:31:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748341884; x=1779877884;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=bdG4xzggOwn3Oaj8eLgHrhDD8bWjtTDYgeMK0QFGJtc=;
  b=i3en/yV56m/U9FMMnhSJR+J/ftqZMDwZn68RdeUVvVGSEK1gnInsIm4/
   eGeQAgwxwEkFGPHbEk3LN0OH/npth0t3lvbDhAQqB2obgJfPdFmpzD4Lt
   oMO03PpuY6/fbS5RvWy/2RTZpmXKyMK1Ik9Cf8BbEIlHpWAid0eJjLOdd
   3pqqGVcWkVMrCiL43ZQ+Fc8DmMKPrwrGgosrsDtcWqg4iea24WQNSMMXW
   rQKESURpSPN9TI0umn5fFkbEs6afG3U0i2+D4xjUOc3Ju+vRYbxGfbXcs
   ILf4dQihQwpqCYuG5TNAQkyamyvuFEvpKrGCRDKEEDrrTUgNyjcq13a9x
   Q==;
X-CSE-ConnectionGUID: Lkec0YTQT6OOCNroAbzJPg==
X-CSE-MsgGUID: Var8AUklTx+TYpUFa75iwQ==
X-IronPort-AV: E=Sophos;i="6.15,318,1739808000"; 
   d="scan'208";a="85158748"
Received: from mail-centralusazon11011007.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.7])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2025 18:31:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g14Gf6xy94oMZgF1rk3RzB+Gd/KqSDrBm+D5EgRJK3uLb/AYQCswA6ISJ5Xn6fTuFI138Xh5TSfWKd1b3dAArLXDDFnmi6qu4wYtyKrLbbWafvExIH69pjJfAUmOqLbbUNYXoqd2aP48lcTB6YIEul1cu2un5toZXI/07/2sUOGJn7VpqZMQl1qPnNVh3+GY43s1ATmsOqIEgtQYeXtwmwlioyRStQ2R9dO4CBXcbwIeU8wXIUyd31tGyJm+d3j0/0qAYV3ZO07FoGDM/y32oTmMTGmag1bfHx55iIelhaZFnqnjENGAM4gKD7dUh6PzqBPicIm2zz9ztDlxXAKJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGXnEUBc/BdmL1SOm960TdSnexN2nVZA56OX3J/AZX0=;
 b=efJ/Hp2/5dsZUgdLFEsCmW8xqyDG1+g0VPYrbhROEWKWMt83P4i0q2EdOR5sZ2k2T6sVoDvc1v4b6mYjJCq23lxcVex5nY4oJ89AhM7c0NcHHbnIbT6BGvQoJdcQlrv3NoJPYn2sVZ1GV1J9346nVSbjeRooV1AnoY3jHchx55gS2vcWCgZkuTWKjBOMCHfh6Kks6beSUghAee4sg6vwYgcnnyGr0IV5UdN7KX3WRDcnhy+1ZVmLSQVr4nL8p3EpLblKU3GHSD6WsbXsFGhgVNT1rEBazcbYsv/VXGG/2JM5IJrIcYR3GphdVpCFbnqtJrsSIENCgP6ezx/ZYTD5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGXnEUBc/BdmL1SOm960TdSnexN2nVZA56OX3J/AZX0=;
 b=LNzSZLtESNpUrlm4nG7x/ny7qYS6/3FhuGcmhl/7BMPKX7ltNrka8Fm6mSmGz3pnK9+6v8c+tpbUvRVOfZVMvk+vYLGLQ0z3kig4BUZJKiJ8SEuck1zRlCgoMd0aM6oz2BSyjCRPR9soz4KJadzEtBA5ZgPF5TtDFCuF5S3mTis=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH0PR04MB7702.namprd04.prod.outlook.com (2603:10b6:510:5d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Tue, 27 May
 2025 10:31:18 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8769.025; Tue, 27 May 2025
 10:31:18 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <wagi@kernel.org>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [bug report][libnvme/nvme-cli] "nvme smart-log" fails with liburing
Thread-Topic: [bug report][libnvme/nvme-cli] "nvme smart-log" fails with
 liburing
Thread-Index: AQHbzvJ7XCt3/JgkVEOctKJWzp0ZOw==
Date: Tue, 27 May 2025 10:31:18 +0000
Message-ID: <a25kumc6oyvzmr42jgowkf4yztmmiypxrvnygetwv6qvc2ol6b@tzhqqggcme3q>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH0PR04MB7702:EE_
x-ms-office365-filtering-correlation-id: 15ecfbab-3b9e-477a-6e8a-08dd9d099df7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?mlNzrMeU2G3xGmDrkAD56VmrKvfw3QYovK0Hxf2/39uI3euVv4B24suzqgc5?=
 =?us-ascii?Q?CklnOoBnd+JKmN3p9fpaoq2QF5XH4Ap9STYJSZYE16U6NfOM7La48INMD1IU?=
 =?us-ascii?Q?2A5E/DZSfAjoIrVS7nLBJAbJ6MUZZEj8z5YsFuqBlk+S8javaSlRdvcrDxI1?=
 =?us-ascii?Q?FjFmkf/oj6Yuqc14adFln1r2DO1/nNXZR75RxLKB9A3A/r/1H1sSGMYZmESm?=
 =?us-ascii?Q?bM2Zc8BetNWekBBeLZ2bHS081LZhb1oRdNomI0KDCTymOkpv328DAj6OAyz/?=
 =?us-ascii?Q?XUTUyCuZm3gsJbEAMd9sXd0MSxaU94/DD62VdHgSaMh+9y1CyZshXeehtlgy?=
 =?us-ascii?Q?p1msGd9Vn1TqO07FPs41ONGM2LY43VfRoxVgdRdrmHXjZoZkARmHSod8TVOo?=
 =?us-ascii?Q?F9xuaz+Pr23QOS38lxuDYcorspqU4AEYS1nkiy28OF7x6bAx+qvcrVObTG2z?=
 =?us-ascii?Q?fGPnypyP0k9xzCFW+WAp5xNBiwXcJPFwAwxm4v2S88h01h0d8oQijJ7c1J+y?=
 =?us-ascii?Q?yquOfyW/yNBF5KJLDiDUqbhECEavTX5oux8x0CQe3vTiVTsNDA+cII3MgTgY?=
 =?us-ascii?Q?iF77Mdk5BOD3iFJBngunPxaDrOIZu+WbHcD55xu4+sipcNFbeoYaPU+sZobn?=
 =?us-ascii?Q?dvCJyDl5nQbRclJguAUK4nUiKA+tH97TqzFvCz+r2WOXdCgiAGoEZhmMl/6F?=
 =?us-ascii?Q?i9CpHOgOeiisRKLJUtvl4RATvXU72wjoHFDV7j3c3SuJSubgTPSeaBho7hnW?=
 =?us-ascii?Q?baYIlo5ECu/QDBn4eWnqlqdti+LeHGBrrwwA8YgQ6Fs7YAmaWplRlQCWJou5?=
 =?us-ascii?Q?wb/Ivccm/6jM386NBiqC3WDcRRTttw94tIBLw5jcmBWkg445/2NYPYzhHbqi?=
 =?us-ascii?Q?wgbBWRBhAhBlnuooS4vXnoxRd8WDX0jjDFE30mhfkuE2KLbDd758TVYTRwVf?=
 =?us-ascii?Q?92aBHUL4GDfDKnMyzVc1XKZRJ9obXP5iIyOcmt4wv08wbGLyJND9n0rOnuwu?=
 =?us-ascii?Q?NOn5c7XFP7AJj6S4Mw9VrAmxj6+RUwpb3jU3k6X+DL7+aAOr6MokVXH9TncC?=
 =?us-ascii?Q?spC5lviLgVq8BDDvkilDgPZIw6ySdFgyJl5B82Li6o2QF7wN1cEnYzOZZFWv?=
 =?us-ascii?Q?JQ7jxs5pNSq0B988L9gNc0//q7hP+nuR7hJHbErULFySEsr5+3w2m2qsprSS?=
 =?us-ascii?Q?PXJUbkZUcPuFcSpJh26rN0wCweg4WEfUL8EFVCaB51coyw/7V2sO9npO45iv?=
 =?us-ascii?Q?sc9ryo0cXmsn+Fm9glc28J1f8+pc9WhHdLKNiHTR7T7FOkElO4dmODjnCSG1?=
 =?us-ascii?Q?z2ZYHRabnViTLVy6g1iGBMdJlrDrs5DTYaqXWq+NXEHN5N13dj4/5uOAv5vs?=
 =?us-ascii?Q?+ERCCq12T0c89wk5qbHu3Wb9I4mLZVfguRZjNXVZ+dvUHwHLltFeUpF+ZPi/?=
 =?us-ascii?Q?BQfY8J/SYr1iiHUt6q2ONK9xD8lpIbCY3eugey55ifo8ytciG6w9/lQ4m+jP?=
 =?us-ascii?Q?wqM6PenBqNbJ748=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uxS2Rt6Epb9U4Llk7Ad6Q3GZXaKZgr0i0IAdDfzixNG8Wr5n/+VZq7I8/Ksy?=
 =?us-ascii?Q?wxkM5rGku0IFlVBx8PeQB8gs1j8tIw1oM74Z6OSv/HB68yCvn65c7DuVQqai?=
 =?us-ascii?Q?jh6tbWWwlVDvDisQ+/76OMUBhaDKhlgVchkBkwqIHkdnXff/qg/O2j5Cy+rG?=
 =?us-ascii?Q?5PnssChKHWMQz5NqkB10AYBvDRv0jX9zjdijexJK51Q8mk4czhACAc96OeC9?=
 =?us-ascii?Q?sgYKiDU8Rfc95pAf9SsjSFECf1wfuyLLvmEgl9x1PcnEW47zxhS3TXFwFySi?=
 =?us-ascii?Q?JGjCoNdtMrAflgQSmZ9PGRMU8RCFTaa7Ef9fU6ap8c57kgtjRysWsT1l0F9q?=
 =?us-ascii?Q?jVrmxJdNIBQhZwDTjHskNlNpsnYipKSe1C11kvXNASKszKm07SXdvuQ0ovon?=
 =?us-ascii?Q?5z+LArdBmbDsimLtbHBEIzvABz0MHhkiF9xY5rVjVHU80nebrDSS3cS4MNHn?=
 =?us-ascii?Q?JfAMM4msHv69TSkan0ZP5G7WDF+C9nDuVuoFvTDvjS4bFyYU7AV0Wnccx1kD?=
 =?us-ascii?Q?tS0KHvZaYuuIaU8ALJfT0mow2inZf4+qtEXR8CrPxcYzY/szt9s/z27jsxRG?=
 =?us-ascii?Q?hJTHO1VlBEWU60KTwYcr++WapUU4o2boaJ9hmw4QPxe7vW3k0aFpR08OLLae?=
 =?us-ascii?Q?LEijkRHQrRGMAKja7COgymJONIn6aVXAvfz1rCBVtZUro81BvKCVju9ZzIRs?=
 =?us-ascii?Q?BF4n2NPHFnj/Y5hgrEGCHaNyt7KMlRQJT2+qdnVxxMR136Us6dgYTNPG01mp?=
 =?us-ascii?Q?EhDVX+G5ArZHtmO4wPymWJWTZU9ul42Bw8mi5FdupbZRh1WJXK51DZ6rbcv4?=
 =?us-ascii?Q?HBkTPMC5Mbr+WF3kZyKuDG9qYYHsoWuYKrtxE4six6hDbS/wmN9FywcbdWPj?=
 =?us-ascii?Q?6AGtGx/49g3yd4yVzV32E3ZVl8EqsklPtnOi2WNmtGnBuYra5nQOzeyL77dG?=
 =?us-ascii?Q?6fbV4HUoOJY7Q01VFkrpnj3m47bOujSTOvmYaObzkMksJ+hD6JhyAWThIftL?=
 =?us-ascii?Q?1pRIIWzVkwyFityoQOxfkPDv1pLNL1EAqm6YMxlsxMtAtUlKyYx6vL4BR6pS?=
 =?us-ascii?Q?Z5QF3QvqW1jbR+BLBmnNxuNto+TjYOL8AvVUYaB1Yb4q4jozY8hbjGt5kKca?=
 =?us-ascii?Q?Kwx5oZXVNkUCaYv1mEmBTvyud/+3u72M/kZl+0+85P5ZiBzRV+4R/GxLdWOb?=
 =?us-ascii?Q?moHmlSIDowF2Vgm3t+E/01DorsrYcS8xhOm+SqIBVxOld2xX1gO5f+KXCnXL?=
 =?us-ascii?Q?J5zsvYu5XlxWjRLblrRvXHTJP55egJ0vo6s1BAJaoMSq3QOuRcOXbT+LRaBI?=
 =?us-ascii?Q?8iwo14WKVNVshAhHAV+ZB2iEi06VQtzQJjEFlpM+Vl2vKqG7uyDqkZOARM3O?=
 =?us-ascii?Q?G4AfcegfSbwzFAZfqBKJvBGsnMoDF+q1fXr56x/FQMfaCb52jmVS5pKt7YmY?=
 =?us-ascii?Q?HeSH6Cu37BLT/PG1uxOl1H0kxUcAkeERI08s9ww827d/014A9H7NxbmjhfeX?=
 =?us-ascii?Q?O3Xu4Jf3HG+AQ1JOgNu3PpfoH/YGboqJE/WzzCZW7XOH99oCwGWVoj0e7u6k?=
 =?us-ascii?Q?OlqeL4K9YOHo9JX/i3pMjkG8h04YwiIynLcV/HJTMoC5S6WF3j6Vh1HqA9fV?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2A7CBE1A5D8C224090CBA68636CEDBE3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yolQ96KiVcirxd80AyGHKzzQnRniMyfrCpEwBJUj8kmvC3Upwm79XzKxqk1/Y2bhY8Bp6oSHzZpMjsGTypyfVyUXfAnzW6HNBlwh1cZx0WvCNRBhiwn+luD03beJEojh7TZi3TzqrNllqa1RmWBgLTc5TQElSY2pIW2HfXzIcp1ONDW1JTw4N4lOwwYmINvTC1naCbAol2i8ryaTsPH5olZO8TMs2MSz9DNTjp2liXLWYQlBHUT57rP/xZVxUIqQ5mSdD1WOGN1FGrcGx6d8i28Kv8ZDoqY5VFAJ0zJ8l0VoejWGWj8pE0ru8sNuy/oqTplLQUC85daUy8EZN5cUFMDBRR9OZfITKoMJXZbXgxFTas03Jpt0kpj7Z9uSJ3sVIot/MwzOGw9z/q8DIJ1rtQwYbFdSRkIbgMavxOGbiHijl7TI1QyLmZXIzSMDKByzJLgve0eyzsNfP0xZc/wCqOuzmvKJfm4JPMR8qTR8EKwRnNWumrcP2H/V4RV08iNI/zn09QjtKZM/Spgv5GI9g4ZpLrxdd3uZwqjfsORVLy/hFdx5uROVkpeP2Y8ojvwpTL6PjF/1tXkGGm+70LB3KyvJDSxtgBZzvCGrlDYF0PGnLnQs1z+U8SK8nJzZd5xY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ecfbab-3b9e-477a-6e8a-08dd9d099df7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2025 10:31:18.6895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ljfCz+WESFonHDd9mTJ/H0k0HNNWxj8yHne8lBOFbwY1fdHItq1okFk4PFgwAzMECNyfSt67pOKcPhzzyMzUytTFtt1kIA719m/jUdYTDec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7702
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250527_033124_105583_57ADA902 
X-CRM114-Status: GOOD (  15.21  )
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

Hi Daniel, I think I found a problem in libnvme as below. Is this a known i=
ssue?

When I ran blktests on Fedora 42, I noticed that the test case nvme/023 fai=
led
with the message "ERROR: smart-log bdev-ns failed". This failure can be
recreated by the single command "# nvme smart-log /dev/nvme0n1". I investig=
ated
conditions to recreate the failure and found these:

- The command fails with the namespace devices, while the command succeeds =
with
  the controller devices, e.g.,
    # nvme smart-log /dev/nvme0
    # nvme smart-log /dev/nvme0 --namespace-id=3D1

- I checked the man page of nvme smart-logs:

   "The <device> parameter is mandatory and may be either the NVMe characte=
r
    device (ex: /dev/nvme0), or a namespace block device (ex: /dev/nvme0n1)=
."

  Then, it looks that the nvme-cli does not do what it advertises.

- I bisected libnvme and found the trigger of the failure is the commit bel=
ow
  in libnvme v1.13:

   8ddf4c73d379 ("ioctl: return status code when using liburing")

- When libnvme is built with liburing, the failure happens. When libnvme
  is built without liburing, the failure does not happen.

I took a look in the kernel code. The io_uring_setup ioctl for namespace
devices falls into blkdev_uring_cmd() in block layer. It does not reach to
nvme driver and just fails. So I guess the kernel does not support nvme
admin commands for namespace devices through io_uring. Assuming this guess =
is
correct, I think libnvme should use regular ioctl instead for io_uring for
namespace devices. What do you think?=


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174FAC2D0CD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 11:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CcHf3xUW0Y35DMuD3M21FP6hAx7ctL3irHsztjjwd5w=; b=3hEI/KWal7T5kTwOkIt8ovh09a
	q8svT6ZHTxBfVh85hrDYFyjkvJQHEIVyEryeoK1HH5r1ThxfbQUbeX8t9IurqUlVLoExdYBp/TJZQ
	mQTO+A+xaMf7AmkzXEq34Bf1lETjaztaByTqBI1amH7FJp0UhgstO4mhSNhZ1V0LATwvHlXN0VkrD
	bVinaPlTGS6orIFRwgzD5Wf0pe2w+2JawIR4fS0YVf+Wl19+At0XFazQ3R3DOttdtwcvDCzhTYzoL
	VcxTibgyns1k25dKIypRD1gm7lc4GU/tDeVcxNQ2heSxD64iWLulofOmbVQ1TnrYbFgjltE1I3VS3
	6j4Qg/0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGyM4-00000008wq9-2MGR;
	Mon, 19 May 2025 11:08:24 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGyM2-00000008wpn-37Bz
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 11:08:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747652902; x=1779188902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=co0iF4DJZE5+tEQfEEZ4fpcKrbPUPCjpQr/Y5Nt+xxM=;
  b=b0ELpLHp6f/EK11pu21dcbILUVws0zj/33v6LAYbZgh8LgKrl3822kF0
   G2XlVZj1XxourJiqUd6jezdPNPAqZx2hF9dl8rw7yBNPsUoQ+QQ5Ae1x/
   wo39j8klPOEsSq/dbdoNtx+EKnM2tfaTPTo4CqxP6xjZxnWmtmFZ6sbeF
   W7dacMkpAYnDjZ0MDw2QdFpicZHbhOzNQcrmpnZO2L745wNoKzmI4e4b0
   lLgEDm7543J3dC6DUlIQn2G0qjI2N7z2RSxud13LBfMk29JtNYSTn3xIa
   3nMY5+h2CiWx0X/MWYGU8BCTaI+O5LVQLcD33UFmrp438J9gOUK7XUiCh
   Q==;
X-CSE-ConnectionGUID: YtmlQaKqTqaCE0vmdi/ifQ==
X-CSE-MsgGUID: CU7PbTLkTPW4mmvPnOxlmA==
X-IronPort-AV: E=Sophos;i="6.15,300,1739808000"; 
   d="scan'208";a="81970743"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2025 19:08:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uzb9QJ3mCb/NblfxuGtu/jpvX44XToqyTJDIC045agtPoTMJt7eCkgjkwgEDFiCSg+4bwH45JH0iulCCkTdxnyoN+mq/vrIMBlpQKIBTPW6ADMszxLC2TyeM0VG9AdIbwXOrlr+w8qtURT6mJx6/1BYUBm3w6/4VbwZo4UURdMAm6afXR3GwO0S5euyukTUISqgcE7A/ZZ8kengDaRPgbf9lCdiRIquaHhw4OMK5efzZvp3Jrb5o2NCfVXypfYd7X3NTZgbx49gZIYFGv1vJIXv1jhQ06ErbbhH7iDU2rQt+5Rt0lvgAuIfeqegra++5SY66blh/GUe13tRfa8gpzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CcHf3xUW0Y35DMuD3M21FP6hAx7ctL3irHsztjjwd5w=;
 b=BilBle27KRGXaAPgqC+4vFUySy8Bju9y4XHKciq5WAvbSH6vhftEA8q88YofeLo+OrF4nCXPRunqVM2DxhncjJ0qa1+K7QEmOBZ2I+RAVDPghffGIfQzPScwlklcubMT4t5nn5xCpxqaAr4qtQV0vQdkxOEe7EZecqoCWOJGSWuEoTMtCsJocODQQE/Lo6eCeBA11AtHewdDAph4Dq2WIrPdj/WTQ+kO2Utx0NLahksY/TQJQvhchwC+H2MsfJKH7M82TugJJbdcupZSgzbc/iFcAmfreFfImi3mFZ+0j843xMKuUf58/50o/SqoZgGG8DJ6Jq5Jw2Hk3r77FAc+xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CcHf3xUW0Y35DMuD3M21FP6hAx7ctL3irHsztjjwd5w=;
 b=OIuXxu8hWyPdMFi5t64dA7reHb1uLCNZ6QqnvD9MBN5Pj/sO9OqwDlpoV4lqSyLeb91i+Apy0abAF/x3E8Pw4OJQjJFRi3C2gleMeSC9hmYnsSSNtJloNM3WREbMtDLM25xGOiIzgOaI7oy5BQJ9Kozg+iqlVYBsToR3eBG5bWc=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SJ0PR04MB7405.namprd04.prod.outlook.com (2603:10b6:a03:295::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Mon, 19 May
 2025 11:08:19 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 11:08:19 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: hch <hch@lst.de>
CC: Daniel Wagner <wagi@kernel.org>, Hannes Reinecke <hare@suse.de>, Chaitanya
 Kulkarni <kch@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: nvme-cli & json vs blktests
Thread-Topic: nvme-cli & json vs blktests
Thread-Index: AQHbyIHD9TGRSn8AD0aBdhZ+nmep3rPZy6IA
Date: Mon, 19 May 2025 11:08:19 +0000
Message-ID: <4ptzggwumu6zi7edl6kte4sjc6zcrf5l5x42uf7qu6v5mwfr6d@ftkhawzx6qz3>
References: <20250519054905.GA6156@lst.de>
In-Reply-To: <20250519054905.GA6156@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SJ0PR04MB7405:EE_
x-ms-office365-filtering-correlation-id: c7cb411d-616d-48c9-5438-08dd96c57684
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?elwo8zGdMdGyCY+rRzSyAhhgWg96TZrPLsvdi1o6l5+DxQwRmyA9RtgUOFnb?=
 =?us-ascii?Q?i4oqP+U8d5QZoCwFAaY6Rrjkw72EFZ54FMPhLtafF8QqWInSnn6ZCOwVeAdD?=
 =?us-ascii?Q?J/vZYi2pu+KrpkROz5bYEXEAc/6XpbKZxteEbdeNUN4PSXYJAeuQxzOSEXq7?=
 =?us-ascii?Q?YwFdG58lTcDu1Z8w9gXEaKs/3gTME+cX7Y4NkNLWuDrYBznfhFv2dQ2fBvO9?=
 =?us-ascii?Q?pRVF8soLgSQS093PNelpU0/+SuOz7apNMU7w1Gvy5ocks5wyQ+hjitDzSuM+?=
 =?us-ascii?Q?hMaoGybn6pIrlN5+X4BdfztIR+4vSHTPbG6tL86GNsyrVn0C5f6K2aTJaRPC?=
 =?us-ascii?Q?YCnlZeUpnDqY2QJs2ZsSHJjPp3qnTvdMAvc5UWyALf7ohgv7wp9CEfWWjORl?=
 =?us-ascii?Q?V1GtHweZsDCvDonFCcb/7UGIHXqXkl/CC/wqJNAjDm4eyhsOwFckdriOkgmu?=
 =?us-ascii?Q?WTiiDTyOWT3Z8PVYm6B3dSEiK7U33OtsXSDxZJkvk8gTTV+HH0XJ4Y4Gsrns?=
 =?us-ascii?Q?4uQcRiRwvgz5iG64WWTpHs52NeUgurziLPiGdM9XOVCeDb6p4NOpfpiKCyvN?=
 =?us-ascii?Q?uzJJ+DWfxkMR2Z6dDS+PugIGmf8bwHMz4VYGS8wasSnFywDJi9WwSoBfAOJy?=
 =?us-ascii?Q?Fe1VAVlLuBQDJ4lMC3fR5KsNINEqURMjBqyKqptjdXVDGtRGK+G8pA0y5MVY?=
 =?us-ascii?Q?tXktDN9eOZooPTdxzqO25lqP1G2wbsyU1s3H4ehxo8ZQRVvzi2t6nY+PeiBL?=
 =?us-ascii?Q?xGZRID6pamg3J5+StTZ7/+hjHxVkhON+CJ/spoLZLwJjhgGwHJfV1UVdRJDO?=
 =?us-ascii?Q?92TPCp7nx3cuVYZGD/qnd58GtMNdIqAahKIxqxHj41QAwNKIusdjzq34uPFI?=
 =?us-ascii?Q?a6tl4RV4pz3YiUf7IObuVbDamUYumvHogr0BmZZwhr8QyzVN8/fR8D7cQALb?=
 =?us-ascii?Q?tLvsxtPTf17APm7HbMaV4ggdDY7XOdP8cJhaRwrkMyWrtdId/zKu+StuAeLD?=
 =?us-ascii?Q?2vuom3z4OjeToGPAgusEeExQy6hwF6AEGsGkjwyn1mxBHMP/BhscqVwfqTMn?=
 =?us-ascii?Q?qw9xqcdugmg2/HJkHCA5rM/SXfeXq2jyG7JHx9h2VESd3N2p33oD4L0QdelB?=
 =?us-ascii?Q?XUOTLjQhUKA9cPqJ5F17IAov/HhihTC/93tm8nG4awKTEKcotlOXEPH+0ORU?=
 =?us-ascii?Q?t8dXnb784Hhl6blo51Yy2RSaX3sqixotvegZPoVkNuo47VYvVFhqNjCuJ8Zl?=
 =?us-ascii?Q?UbVbf+TlfvZMr2apTYyJu3wSmLOZ2UgpPQkQXyukhkuNuD5McoU8/hImnH9K?=
 =?us-ascii?Q?9fSypnekH1ibyYH+KysP/0JX1jNYn5YLcXbiJ2ctwuZhq6Jz17uPeIQ7btsa?=
 =?us-ascii?Q?FkO4B3x6XVsU9UxEtFHtjx+XslHaxd9cDbGv1l0qkJHiU2qy0X5nWrh6a9x+?=
 =?us-ascii?Q?/XKljR9WqTyUxOhHEGhk5fs+RZ69a4MSwefp7EDU3SmQCgoOclYGaVifjSZO?=
 =?us-ascii?Q?i2j1BzaD56lNv38=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H6WSBx1OOWNAkN7ldflQg5xCxx6HKIiaObjtqko8nAUqbmCJSon6ZoP9zXZN?=
 =?us-ascii?Q?552cN2C7HyuaXEtzr9XIducy0uHk5DnLGUCKtBuvv7W6FMkhOitIon9zeNDP?=
 =?us-ascii?Q?5dFKn/JJNn/tvBfkIkpN1pWy4za+GXQGGHFJAv0aplrXfUjq/sunQIFv6cna?=
 =?us-ascii?Q?fZ5ZIlKSnCYEeCMxOhM+ciDuKgXjm++D5pwNmEXWMUzJSBCHQ1mMsfAtBCPv?=
 =?us-ascii?Q?Bk+Ip53U3s6+jADfYo9ADdhQPcLxIoMhkO/Stp9CoIfWm1Bv8sh8Cr7a6HXq?=
 =?us-ascii?Q?yXIx+W19o0v5Rc2AgTwkNeEA7+Skk3qGQcavQRXgRv4Xr/NI+LKCyTcaw88W?=
 =?us-ascii?Q?/gqhpSXRfhoZktrkLVB1985WfhDXFc7TLPWOvfkka6AyR/g3wu/poWuTQ0xb?=
 =?us-ascii?Q?gKL5EtRJnbywgfO44Q8RZo6etmZJZvcALNWXJhF6kkq/llNc17kKmAdwLkft?=
 =?us-ascii?Q?TI8wS+jUz6tnRPB52BGtsxY/thYxgC4erdbMbazVRJf61+WgCg+1qf+Q8v+j?=
 =?us-ascii?Q?UqkFzL/uewpanigmLdn5bbUawgrcPID+LHaU7MhqLyRUM4Eyn029pg5UwDGt?=
 =?us-ascii?Q?qJKLl38yDjyaz13uxeTLDfaC2ccvaeEP9REgPDUiq3eyz6a1dZiPg9ov6Gbb?=
 =?us-ascii?Q?fwXYcXbGQIi1UAO9l8mRvMXEXMW8eKl8PMfPhgBFTubSyWNcWla72MX9qyqe?=
 =?us-ascii?Q?aYMzMXiy1oaX2xjdQKvdnJL8LgIWPXdMFwXWxhg5JXkwRIkgOiYeQfmZS7iM?=
 =?us-ascii?Q?Upt3GMCSYbrUhBomb0F/thknQ4OhbNoAgqm79CPyp11yuZ2svLPsQpe3hbZ2?=
 =?us-ascii?Q?otVt44P0GwEfeBlA0V4H757VkbdJqM82HuP3uxvjBPSwP9BeGIyj8IADrfPk?=
 =?us-ascii?Q?EmJd+TUrLI7N5632Q+04V6gQ/zayjBfzqzxfE+ONMb3qj+Bvy+ECyRqN1+7r?=
 =?us-ascii?Q?bK1aZ3FuOAue0VEVqmbtvzqKf4hCfKrx6xM4qBbGgYJon5+jRmiWsVGhEY6e?=
 =?us-ascii?Q?1Dc4oZ6KajZOG6132GiGPljycYpMPN/mQTn2L/0lfs0HugdZ0nVlgAynPqS8?=
 =?us-ascii?Q?xBHiay0rf6n7+pHbBV2S8DFsetoiW3S+eSR1WJ9Gl++5FhCPl7lolfyyYMdb?=
 =?us-ascii?Q?8bxWsQCa6Oa7GRHMxfPtAK3Z8Y8B9bk6uhpU30lYI6Lre+Q87szXheS+HjXP?=
 =?us-ascii?Q?31TEmRn9PFUYXxPxR/TXRukURIhxZpDIHDZBwRS/I3xNMnT+D1uPpAOt1oSV?=
 =?us-ascii?Q?3niQxbcEn8eSDmpXO7P4Nhjuny4CnV5MJfw49PPdaNbKsddEPPhBwSWY+csI?=
 =?us-ascii?Q?fZzYEANMCUWAjQU+X+IoLLd5q0oYsuxRfBSKB9uuJ95l7Hh/+sAMAq+mULKV?=
 =?us-ascii?Q?hAC0LlwnfneWkfgexoN7JxWO38V/WWU3FRa41kdJbDhLO1vgECJAgAU38fim?=
 =?us-ascii?Q?DSeDwYCg6KL56OUQIRf/gCemeBQdVOxDQiZPaTVWe2kgOjw8gF8CR+yAdkIv?=
 =?us-ascii?Q?x+plmZY/GKBUZzTdZRZZzjySWXZc9lffvb7F4LdHZaHIDwt79mmxKZMzPBhv?=
 =?us-ascii?Q?B7C0lkMPW7/sa1nrjOu4VfFu4WN5rrCqII1TZ4THWOaEpmSwqYi9X+4rXntS?=
 =?us-ascii?Q?5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B0C5149008AA944FAACFAFF9EBEFA918@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6VVRLtBpHpYAYSXpG0ZwCy60wNL2YGEQhJACsic177QeXkv/D3SMmuadCC5guuYkAuP9vUvdEfp8Jvgn10yb7e8SXlzJ7FST2f2w/5ySvxX08WE4C6ld51IeIO63cRVFC3xSJJDEO/6m0Mw6KNZKTSnLqll3l0jjTroYb8GyO8zADIXY+xMuuTduM511XOSSAPSQuJfNy7dEHyjBPhNiBtBVfYXX9DnE+UHmmjwszDM+SlhQpu4yz/sQnv1aWkV+5xIOMcFJkRTK/loYpoa6wMbGs2SiuzGuTvCp3ki2vF3/h4Sf8HlYa561XfY6Nm4sAujF4RakM5CqNUOhJs1irMtvvtMKH8R0tAkfPvq5pwy5POaK6bnApDGEq5iFcTmk+ITg3yUi+wGBJzaqt+9pwUx0LC0+3aqaAWIEDGYu8UDTRBt+385p7ctHmy2Nf55QQZ6G89bG9n/I4UxZzNEk3mQTdGv2QdUerKwwTMSJbHG7ZfpOdv/1HWjpTgRfGmheN0W+rs7jaiP95kfIXT1qiYFT8zz+5DmmKc9Y5ks4zElEYFY3h4ejW/F8J9XGCtLk0w9ySkpWhr5Sb41Xk02WW45TAQvtKXars7i6PxAc69LZxRcacEu0eH+yhip06UxT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cb411d-616d-48c9-5438-08dd96c57684
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 11:08:19.7170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rwJiEiYVwXAxyWOKdC8ZUxj6WxfqyXISSBAA05hJS0C8Y3tr84q5j4+Iv7Jw4QvIN7oABfqEOvJP2i8aKox42m6dnAnV5PU9UAm0kIhUZI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7405
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_040822_812701_841A7236 
X-CRM114-Status: GOOD (  18.44  )
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

On May 19, 2025 / 07:49, Christoph Hellwig wrote:
> Hi all,
>=20
> I recently did a long overdue update of blktests on my main test
> machine, and a large part of the nvme tests started failing.  I
> eventually bisected this down to:
>=20
> commit 444f0df9f0c537335f59c1721240212852656e5b
> Author: Hannes Reinecke <hare@suse.de>
> Date:   Wed Oct 30 15:51:45 2024 +0900
>=20
>     nvme: check for controller device in _nvme_connect_subsys()
>=20
>=20
> which adds a requirements for json output from nvme connect, and
> just silently fails if not present.

I uninstalled json-c-devel package from my Fedora system, and built nvme-cl=
i.
Then confirmed the slient fail. That is a painful pit-fall.

...

>=20
> Can we get proper feature check for json support in blktests and maybe
> make the nvme-cli build a little less arcane?

As to blktests, I quickly created a patch below, and confirmed it informs t=
hat
nvme-cli is missing json output support. Will do some more testing and post=
 as
a formal patch.

diff --git a/tests/nvme/rc b/tests/nvme/rc
index d86dc13..f5880ed 100644
--- a/tests/nvme/rc
+++ b/tests/nvme/rc
@@ -55,7 +55,7 @@ _set_nvmet_blkdev_type() {
 }
=20
 _nvme_requires() {
-	_have_program nvme
+	_have_nvme_cli_with_json_support
 	_require_nvme_test_img_size 4m
 	case ${nvme_trtype} in
 	loop)
@@ -626,6 +626,14 @@ _have_systemd_tlshd_service() {
 	fi
 }
=20
+_have_nvme_cli_with_json_support() {
+	_have_program nvme || return $?
+
+	if ! nvme list --output-format=3Djson &> /dev/null; then
+		SKIP_REASONS+=3D("nvme-cli does not support json output format")
+	fi
+}
+
 _have_libnvme_ver() {
 	local ver
=20


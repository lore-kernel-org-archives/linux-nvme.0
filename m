Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4547C27C4F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Jun 2024 05:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GPcPEHV6LmpdvaiXKmPJ6JnlXmhRGNx7jtQEvNjVeJQ=; b=JBByXdPGsX1kk8Kpd0h7U21APi
	mKS6fDuiDjRJLyWftQ/su0SSgPuK3hzFfxZnw69a7bdHmSVjKl6/BDdB9wPgi16I3ZbD9fG9IOwBz
	/xsRpWt5pzAy3NsI658WTVjqKz+oQYwcgcXgTz08X1FDfMZrfmsWFvGLaSXh7rFdXU/l2ytq4kHAB
	pMq/vZhMeFpEtE+R2e3JXXW/CLsCUg3B5vpvd2N5JBoX3G8BRzJmOfrC+2Tobz+XBujrazrPGwe8M
	bj3NvarbDubkL5LVCQzi+h6HyPiz1gwhJoxtlKkPjm06TO3nnTMpn7eqGkMiSIBco7Wia9ej7YD/M
	mKPjMvXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJRPW-0000000DepI-3aB4;
	Tue, 18 Jun 2024 05:29:38 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJRO1-0000000Deo7-1uGr
	for linux-nvme@lists.infradead.org;
	Tue, 18 Jun 2024 05:28:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718688485; x=1750224485;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GPcPEHV6LmpdvaiXKmPJ6JnlXmhRGNx7jtQEvNjVeJQ=;
  b=etaJ/DoD/aepPoWXL7W99FcyhqyQRHXs45yiYqKWErfhErmVV4c+exIF
   Lm1vrvlw4etaBu7Ly1gbt4cLlt+CYc+g4IA24Qo0NnY/G/xUyIZKbLuBe
   7zP8nYKsJvYxU/mhzOAIPrANsIgBPpO0NNlrMGDciTjldepvEZ8GfAumA
   +QVeuC4iRBZyCmf3h9WM1pTnGJjYz+CBR3htxRcFQIUHAWLXaYX3TL7xJ
   d4HpZVKo8l42mNWVxCg3u9xMaIddfzZAy2iYsZPumq0WGI2521zWWMOkZ
   zirAoGTwt97eUYCjTZHtgFwLwS46tUal6kZLDZGecL5kgEkXunqGQ2pkT
   g==;
X-CSE-ConnectionGUID: oyIsytS9RqiZ+PLy9xFsyQ==
X-CSE-MsgGUID: Wnq/fuxvSEu0cGLBxhbogg==
X-IronPort-AV: E=Sophos;i="6.08,246,1712592000"; 
   d="scan'208";a="19341550"
Received: from mail-sn1nam02lp2041.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.41])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2024 13:27:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5hnXGqM+25ZUwM2+a/9yBkGwpuKrr/NMLwPQcLrFPuUcsKSNut3aA9WMm6GdG9VvH1FkFZiqH0NtmWro0Y6U3Le3FEY7R4ZVxxp7Q8GONy8dlIdWvcv7wnEXYwsQm/tbluFdntrZGSVQZQ3jvZYCcJoraHcDtL+sQFMGEdlPrNDKUiTM6MIkPEbv8ilmG/jc/djgGHdCJLox19kbf777sRmRfNf+wwHvmdm+Z0KxBLRDkmwPiVOLmMYwBuz0yY+tP2p5UPYLtGXuKGq1uuIKBtV8ezwOgVjEmEN4mltJvSOnrGyOXhJnMvJteTmD64wnm7/uiHIbJKVTrYM59SQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPcPEHV6LmpdvaiXKmPJ6JnlXmhRGNx7jtQEvNjVeJQ=;
 b=MgWW3Hm4+pjQpLxagxcxGYpRg49X/KCtm2q5VuQbYT6c/MWfFSlYqDjUXh6DTIme+/hFaI83HO2LqEP4IHIST1f9lgJ5zlzMJlpkdhGQUMa2MgTR30vlqG2R3yDvddWybHl8FpoRw8Amx0hGQ/4w9jOCdodQbLWQgJQkp2UtjdY6Oj1tYQBEkvLS/zZovSfoYs13OOnnnxTKyIdV2Gu4Ar61d4fzVWPJVVEXPOztVtBX5l1cQ2J6l53D/hHcSPdlFnQNhO6Bhx7mFYCvtMcquKDRGsMp2WF77npj2om0twV9Cw/WMISDjdTD1U0+90LwW5wNGva6VkX7XOoNyIrWcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPcPEHV6LmpdvaiXKmPJ6JnlXmhRGNx7jtQEvNjVeJQ=;
 b=g1qFQYVY365vbfT6GIknTQHb0q3siPxBuEl4142YCKb+EMmOOsC21r6oeIug7fowj3HtHTOqqI5jxXcGn9XFMvzoUXY09zAFkN++Kt4UO+VDYXpiI/8iR+yRxS/lrdCo+qsi3KU/SnJV1Ic1i2Gc8Xjhoi+GpsYSWNdiftBzoSM=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DS0PR04MB8743.namprd04.prod.outlook.com (2603:10b6:8:12b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Tue, 18 Jun 2024 05:27:57 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 05:27:57 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, hch <hch@lst.de>, Keith Busch
	<kbusch@kernel.org>, Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v2] nvme: add regression test for concurrently
 enable/disable nvmet ns
Thread-Topic: [PATCH v2] nvme: add regression test for concurrently
 enable/disable nvmet ns
Thread-Index: AQHarCc9uai2SA7o60mCJCmLc1g8wbGkO/6AgAADToCAKOjxAA==
Date: Tue, 18 Jun 2024 05:27:57 +0000
Message-ID: <me5kxbn7ezlvbjbphbso2i4qex4ssqwznynk5xvylptik4qsqk@o7opsflrqlfv>
References: <20240522090540.467551-1-sagi@grimberg.me>
 <f80d3e1e-4f3a-4c1d-8fe4-709c7e9fa468@nvidia.com>
 <bteq6m5ut5wnluupn27flvcskz3ckfpphgicvo5ugpo7ftney6@q4q4lsupplnu>
In-Reply-To: <bteq6m5ut5wnluupn27flvcskz3ckfpphgicvo5ugpo7ftney6@q4q4lsupplnu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|DS0PR04MB8743:EE_
x-ms-office365-filtering-correlation-id: 16c11387-c649-4246-0403-08dc8f57699b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|1800799021|376011|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?Yh0Tx+zdvSh4/mepwQ6bYovkUBmDDQSMefoZVP8/CDz+X0Ebu/vBSNKwNAgL?=
 =?us-ascii?Q?zgg3soj3m0yV5MKBO3b0haZPwOaEO9rL+gUiOTZZ1u26cTDs3La0Zt4P43rq?=
 =?us-ascii?Q?QHHl4OHxekk4WCT7kgnYXNXPd9t5NiXBt6TBXDSZFVWZJCZJU+PYoLUyM2Hy?=
 =?us-ascii?Q?TDNWUUf3/kXXLp0IEZRElnwdULf5XwxROFT4LNT1RqFG3iLF+Z9MSGgfqz2b?=
 =?us-ascii?Q?UZY3PVSEFXBvJbQC4roN7MVBEycz8nk/jwY8ux9Jaq8UnG3rvqJZ5R7aqjVP?=
 =?us-ascii?Q?SAjukNBKJgXMvS1ehY/BwmYJYAAGGnOi/J3AhfsOB2NyYtAt7NDShJouMNNm?=
 =?us-ascii?Q?KYHfdrYJek5N5PTWskBSrf6++0ZE3xknzOrg5yrJq3HFeaNHpRhVOoxZSOUQ?=
 =?us-ascii?Q?IWcIqHMkIBEvzn6CsUcj2IFFBYuwNd7pnxZF6rGfdYyHFnAWDOp0Af2y/aOW?=
 =?us-ascii?Q?a48Nv0FFUPqYRqy/pNuZQIuTBvmJO6gaEmQY77sqxkwtYQroxFz/2GhOnqqb?=
 =?us-ascii?Q?PLxY11ZZBmLhStsfF44U0tCc2S+C/K6Ae76qpTVlk+xgRwCmGlDM5tGy9P0k?=
 =?us-ascii?Q?8WgWO3fuc2DJ4vlXnPNiTZ36JRMeZbpWJUa8C88APJORy+O51XOE6PT5HUx1?=
 =?us-ascii?Q?Fv1TnDunkp8Hauiqmaha0W53OzNoFfEraVm4AEixliP9RpZQXpkhzR1oCSCe?=
 =?us-ascii?Q?GHfVaTfT9KIsBru+ug4evSt8DHBtzx9ajJnMVyRD18e0k0TwAFDrZBszJh4P?=
 =?us-ascii?Q?mmPssZiG/KoIeexPKPkODhuyI6e1kNj56G/c4UkOcyBVrqOVfJOCgTP/D015?=
 =?us-ascii?Q?TWqjhJt8kAawZL4brZcnkn7lddZ72/N9qa58JSrcy7xMjjhrwml6gebLOLkj?=
 =?us-ascii?Q?Khi37hqDpapwlRIDxilfC/Im7D/h9lbqzZG6Wx/7digqjkjMUxj8vd6TbeHG?=
 =?us-ascii?Q?dw93EwG4mJr6PvaLy+pYjTD0d70K9jenN9BoxC4Gqs92CtJ4vDHX7jx+C3le?=
 =?us-ascii?Q?wxVnHbXo0d+g6iplvI7Pi/fTtSCg9BUIJOLS414BSVfxHcJcoHOJGEKvMOd3?=
 =?us-ascii?Q?Qv2By/Wk+2BBNBKxNtDnPnHAsw1EJ1Ax7zWDXFsLknBw6P4N6WB3rd/WWIpz?=
 =?us-ascii?Q?7IqyFVs6Gjo/7H6fLwntb6szAgznPF5EHynJwiUOPMAElrHkQqj1eaudY710?=
 =?us-ascii?Q?OjXvYy+vkJUIS8QqnGOXfyuXfoPort4vShEZjh8aCw7cn5VT3StyZDNjkrg0?=
 =?us-ascii?Q?qJI7QulQkdK0KSZeFlPHUAgKJDsIfkZdx66penTBcpPthKWBZEO0Cv9goaQP?=
 =?us-ascii?Q?cg+DEkm/aVD5dulvuNmJN9IV?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gECAyjVcTYNP75hztTOLO9VABz3lGBnNHt+uuQUVcKSWtklbExcLVyhb+f3y?=
 =?us-ascii?Q?akd/JGxGZIJeoe5UkzYWQLwt5R++USH4mv8nApNsu9ltw/6d1BvkRt+8T78v?=
 =?us-ascii?Q?MY1GW4Ny4RpzwnaqTnpkL9XP3TokBDeRaZ+ZkQRdhllwA0wkoCUSnuEoJIGX?=
 =?us-ascii?Q?FltL+cOzAXXU5oGjuga4YQBIuIT7rRYY09p+gURjfs2IpBnpKQ9r1MwpRpB5?=
 =?us-ascii?Q?jUUktIyT2iO7JnNWGTsKGl2tCcguhGqbm7XH/+x7aX/koC8kzGrzEPi8301s?=
 =?us-ascii?Q?0nATRxksQZ5Z5GRlDDH7dCcjCEetZh8BLOCVtWYu7FgeKkOGw4NLOCZZ7cPG?=
 =?us-ascii?Q?bOekXARQzm6UYcikJk1QRBiyAPa6yfmFI3Eo81fz+fJjD3a0UigqWN+hxkx4?=
 =?us-ascii?Q?D2h0p+00pWEwMnmkPodl4AjApNPQv0g9ZmYu0Ev/P88WYcqiYpLfaeKpZBP8?=
 =?us-ascii?Q?vb3YKurXGA9ndQXXIwPsD1sUVr/GyZ/pgo8SNCergUiHpnYNaIIyNwhu59Zk?=
 =?us-ascii?Q?YM+u8pvhai/S+XLuhFL1j/PuxUERihSWrLQdFy0eIHb/jtUwpkrcfpqw6X4k?=
 =?us-ascii?Q?QXp2evnk8DO0eg6PAkJAGy0fBLFRGYCm66qmOacsnejLSyP+s+KEisMl1cKU?=
 =?us-ascii?Q?3Co1ugyqSzvaFgXb/d2BgWIhthVtn7KbbaweaHMZ9mRjv8/GKeNDuwhTdk9U?=
 =?us-ascii?Q?8kBNmxBKUrV4MxtwlMl2/3AL38RvDepuDqFRDU/dJLeryGEaEvHdNQ9MXMko?=
 =?us-ascii?Q?PVGDMQeDsnryolCA9eECGJxtt5eTIYUEIvmKYi1Ng7/n6AfgrpjioWcH6Sb7?=
 =?us-ascii?Q?14+8jgSVkfTJnl0sqcpXhtjcCFfrloG6y8+ih6rTbdBHcNkedFBQtrZwVJJY?=
 =?us-ascii?Q?VMcol+SrQjyCTCskcx9kw/9tLucSn0sKJb22YnEjEPBL1rc4V8dkdnQ/nfRL?=
 =?us-ascii?Q?CyHBXn5qqj/zLV5S6KQDtWNwf3MsEp7xOSXkfjsZFHC1NXt68sECps5rjxuD?=
 =?us-ascii?Q?NR1xGLSG/qLBHj/f5rZ1RfY0HeGVsMVo/pTrhQ2jt6B3u9PJQFovA+0QwRI/?=
 =?us-ascii?Q?MkYGY/JvGViDBufeGKBN/EYuxVyTMNfkrR4Ja6Nn0Jq9PUxj1gS93p4UT3Yi?=
 =?us-ascii?Q?E3nwNi510rfDPYqP+AtcHsXJ5MXuUacE4ycjlHhZRJJ/BSgi8ggFInDd5AOP?=
 =?us-ascii?Q?m0NSQUWk/6R5jIwGDWFBaO3SHINVywQ49zw02PVou1VQ3qD3YuE7WLc9l0Kp?=
 =?us-ascii?Q?hV4EaibGF7LDf39yZXuRLt+ZsoHqfZblvSwwoUJ4VXyrCn2azbS0MLMTxX92?=
 =?us-ascii?Q?vLjrbgq9rMeRK+YokmTrylWCli2EvxeJCkQJ/bcZ7H2hdYnxtC8rfW/bFJ/7?=
 =?us-ascii?Q?RbrCqCDTNfWX5lld+oeRa5UVceoVzShZgvg0QQGpBg7x4qarU+a92kqJeJoc?=
 =?us-ascii?Q?Mz3WGUcKqNrdCo5NbIr6TCrkHIczqeHvUnQ1oPceRylGHewQMF9G0dTAw7xa?=
 =?us-ascii?Q?1/W40d4rjh8T31DQRpjO4qWsz8b41GIASaM4I5qtbFXjXyS5kkZ1GiAkQDZz?=
 =?us-ascii?Q?XHLrJu6fz5Ij+yLZzkg7n4woBuHzgGokkSgSLR3xCMfpNb+OT3ohHrMcMhKz?=
 =?us-ascii?Q?3YoyNyWC2LHoAkI0JiYq8X0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <686DEC4B242C1044BAA6A86B91617927@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eWQLdwze/qixxSbs2Mosnz3NasdDu3Bcj0EIqMirovNTEv7r/ECCn2tV4QnVUaXrZhiFoByTpIP2Frh03g8D5VNoYu9z5mkMerotEvtxjGhMOO26zAXioBcIEKQPdKAJYzkKib6utJVy2OdObroPdhNQAAobZ/Y24oDjYzL74F09oJvz5uQJj2QRi5wHYyQs+gRg+bREmH32GnFh4OGYyNNQMIPBIgCfj0oqNEbj25yJHBkejbEQoXc8I4vnhjNv663Gw73w/DKPnxbXPnaof+bew/Aj3so/kHxksuQSLDRLsq4g4Il98XPci136rbCw10ut49ZdODwDFSf1QUBRDYfVQoSm8fQddcWMoNcMhwASmiz29SmH7OMFRYKLDCnEWSaucW/PT/+qz4qgL4iZb+Iry5WdIKPWLG6WwQdboBrNmm8xz4hWFzcKBdZHivWx0I7XiPwzmjYgsXyLHoTYk2+DNR/f/y5GekaHIJK0yRhXJsw+plIPtmUE84aKMjuo8G36tGdusVMJXa+44ybVmV4alaekRQ5nCRjj8wNZiA+TdxpHaQG3MBUz40soU7tjOrCcZwUzHW/UQEVGw0nSlhcF6wDku7zkMBIqse3FTRHqwPM/56/imyIXbyHM7boE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c11387-c649-4246-0403-08dc8f57699b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 05:27:57.5964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rVBgM0wnt4JNUWSarflBdJWjsw12DeHkzjqNlrMuuBe0Ospn46IiGFGJs4LU0e40Di7da1tVCOfbD772MD3WI8I9ccGjRDcZceV+nHlRW0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8743
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240617_222805_602701_058ED290 
X-CRM114-Status: GOOD (  15.90  )
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

On May 23, 2024 / 04:43, Shinichiro Kawasaki wrote:
> On May 23, 2024 / 04:31, Chaitanya Kulkarni wrote:
> > On 5/22/24 02:05, Sagi Grimberg wrote:
> > > Reproduce a hang in nvmet when concurrently disabling/enabling
> > > an nvmet namespace.
> > >
> > > Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> > > ---
> > >
> >=20
> > Looks good.
> >=20
> > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>=20
> Looks good to me, too. The added test case triggers the process hang with=
out the
> kernel side fix [1]. I will wait for the fix to land on the stable branch=
es
> before applying this patch. Thanks.
>=20
> [1] https://lore.kernel.org/linux-nvme/Zk4cWHmFnzLxXETd@kbusch-mbp.dhcp.t=
hefacebook.com/T/#m0f5950f8933a66ecaec8f13f62f00ce5184234a1

Now the fix is in the stable kernel v6.9.4. I've applied this patch. Thanks=
!=


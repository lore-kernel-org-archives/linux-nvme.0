Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A13D13570
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 06:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yaK0eUoHzdiQ0DkSSuNuuLYtQ6JWEjTkLuwjaD0YNAA=; b=QZotKarr0XlQiaZs3aBj1JcIRD
	4MDAtL78r4bFMYX5kqoGNSkMStjCU1cCkGy8R5MunoDjCjO2jE2k6590JuIoaxBO8LFJOXzG0LIYU
	fPH5bVh2BeG2DkHM3zcxN6hGW4TctwMj64FNROw1aBUvrgVST1k9y6v0AqP82sZnrKvJnx4pM0J6q
	mXh5w2K/ASJ04LGUlYIN6M5a/ZSn5Sk2ahb/p4mqODXCeSSfjxYX7Iy1IYg81VUqOJ/AZO3D8tAWb
	tyg/8xjwxzJYhNCN7kxlCEZ8OjZabtH1OyuJAe5yqGco8cgnjcmgHREGfa3LU+vGlH+RkeUCLJ+DF
	gEUZH/Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5JQ7-00000009kpA-2lgp;
	Mon, 28 Oct 2024 06:40:07 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5JQ4-00000009koh-2Kms
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 06:40:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730097604; x=1761633604;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u1Fq998Tl/wXErNIYkyr9NpWe6o0UpEq/LXblnPbOlQ=;
  b=Vi2Bqca+CoKGipA2KJfkFHs7IsBJczqq1EStuIidn28uoWogXXhoO9Q7
   SskQ6O3xQidOsLbmiffbjPmW3+WF5coFDjWIA+o7VZrLBrvQow/alGii1
   fs0k2gD6+n5qzEcz5jaF84hq2Wslyrs42WS5CGJT2Ht4rsShckVuM6nim
   lczkWIAK8bzemkRoUqXwAKeCeppi2Wwdl0UpOfWKF+e84BLseiSO6Ir91
   yFTh+w9br7fDP8DPPtNx3vktn6mgijQPJG2g1SZKkdQwUBrg6XwViOcc+
   GrHeTEItQ5wu6zjj7U0KuAzRbTp5w26tnlyRrVqkk4ij23SM2bcLFwgXJ
   w==;
X-CSE-ConnectionGUID: KXuntoC3R1uOT0GR8GsjeQ==
X-CSE-MsgGUID: tQqj27HMRs6Lwu7GGC9Fhg==
X-IronPort-AV: E=Sophos;i="6.11,238,1725292800"; 
   d="scan'208";a="30503497"
Received: from mail-mw2nam10lp2042.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.42])
  by ob1.hgst.iphmx.com with ESMTP; 28 Oct 2024 14:40:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sr/5OID06g/+/F40/GKROumQsau4YHbF0lJKLHV/QxVW3iQsxJdDcDf7DS35e+thyA9M007bPiIbbqdnGfi0RGdBg26AMSzsxvdjAo9/yJFGWmjttpnpsW6pgOE+9jhtFhj5LBE3hKXNBeVSR4dIqH8m9IMaDsO9oVndpSvvfjatXwZcb8EdgbhE4A1axaV3jEwrMHcHcMT+cq1zgPb8HQrE8MI6cs6BpdCskVGkKBpuIaQfeaMWZgQCeMhpVs5rf5usHUNR5Ujgwjbj99qsekGgqaRlfbR9OmqKe8pNgA8N8LrQztXBtVg1/KtAphcAHaHmF3NROD+ePow/PtCJQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaK0eUoHzdiQ0DkSSuNuuLYtQ6JWEjTkLuwjaD0YNAA=;
 b=d+1xF5h1g1T6WFhz8qSuCCXBeud4vvHv2B2F3DJZjdVelfQlEnBDUhgk2ZPP/1CkTmiPHpT7ZNP0gHLVrAeOq5oE7O959V0GF7HIGx1O1vfSI1x0SV2phOqHd3u4IAsQWyCwydbxUPDuXyw9hKBWoi4VjUJU2aZwTzGOjdgnz7CJHagH7bhAqH2ljU5ElXpNwk6QkdcqBxxdXZI9Jt+jV7LqIO223j/iDW8ZbFus4/lE2b9AG6UCYpcEA/kKZ3TWa2NLfGXzTPFh0abXWJCJL5QhrzkYawAV10wfPehW9dyDZ0VanlyG3gr6afevqWKCxvYisp6aNJ7slV9ckLCDWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaK0eUoHzdiQ0DkSSuNuuLYtQ6JWEjTkLuwjaD0YNAA=;
 b=Az1DeIIkUu2jT5ynBdzPj/kqMLmCP5oxe94jmBprKwwJSNnTc+Ybr0HYeNEiyRmT3LYb1Ahmhd2CzlH03KJuME6tQzYGJelaLs9TySDgBKNBz4nGUxnmFls0jy5wep2AQF6kdqU4v2y/ZHsjSSGPmF7r1wr7goB05kIitcusZNA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH3PR04MB9037.namprd04.prod.outlook.com (2603:10b6:610:179::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.21; Mon, 28 Oct 2024 06:40:00 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8093.024; Mon, 28 Oct 2024
 06:40:00 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 09/15] nvme: check for controller device in
 _nvme_connect_subsys()
Thread-Topic: [PATCH blktests 09/15] nvme: check for controller device in
 _nvme_connect_subsys()
Thread-Index: AQHbJbAlNYu+GIMsmEalR7XRLM3DVbKXjFCAgAQwuoA=
Date: Mon, 28 Oct 2024 06:39:59 +0000
Message-ID: <6tkr2mnx6o3lbqj7jpcb7livwbx7c6g3hzg77cbskczj3ihozs@44ilfnnrmnmn>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-10-shinichiro.kawasaki@wdc.com>
 <82cad6a8-c249-445e-9836-f9c234add172@flourine.local>
In-Reply-To: <82cad6a8-c249-445e-9836-f9c234add172@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH3PR04MB9037:EE_
x-ms-office365-filtering-correlation-id: 225063fb-72d0-4ec2-890d-08dcf71b5872
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?+cESRQZuuee5BAenRdy965yyao7dLmIPCOChfSEZyNM5qI8pAQKuxYmGI/fr?=
 =?us-ascii?Q?dUDf87WPLinwAF+UFjMaAXCRa+UclbvHuLyfoPUcQszHEToAeA7LYi492Gjx?=
 =?us-ascii?Q?guxVJ9Y/I3l+V/gb9SwOvtiUhzI1/8xE8cfcAtOncJfxjF/rHbsLzS6i0MJ/?=
 =?us-ascii?Q?kdBfR9Owa+bhMZu9LP2gc8z4p33wqNvUYjk3QMulO/JyxvsZDdX8d+UnaOl4?=
 =?us-ascii?Q?lyYYr8SFmd1Ytle4sOTMYdaKHPttUu/4AKQnzEa8Gll+MAszw7RtbnXsMHeV?=
 =?us-ascii?Q?Slx8I8owQqjWVzc00we+eo1ZFblLhmnyoYGlTeNSKz7bkmtAaY9Ztjtez1R6?=
 =?us-ascii?Q?1BuTumvY71t+nR0PORpQGnYkSNwLksc4cxCWzvMGCAypci767XY91J7cw5aL?=
 =?us-ascii?Q?CE7aWXkpuwAxonj+1U8ThBDBuDaGjVIa/WWqS56yfw9k8Ty/cCvDNl+JVrdi?=
 =?us-ascii?Q?IPL6L1oqLbIzwWyfw4hVSPb0I1XX1JetnUy4R+R/vHfccLrZzx74DGONbSid?=
 =?us-ascii?Q?8S0MRzP3CC9k7zv58ns6JVPYWfCECNcVq5WOacymoP9TsSG4iuSX5pPzFqJP?=
 =?us-ascii?Q?8bicreDRF9NAOs13sznpYw7roZgsK+251a88N4TnrLMO//oxVnzugZR6YPuS?=
 =?us-ascii?Q?NEjczfsvPh/qN3WltRNmMC+91hiSqttOLeCdVad+q0i7aSA73er/wHAr6qKr?=
 =?us-ascii?Q?kgiXtv2KGb8OdIvRuZ2NVOF6c+KKHZhBDmkMI30laGB4ebL15eiHowHD//BN?=
 =?us-ascii?Q?SHBE5yYX7MEGgWdsPoMjE4OQNs0lIMCGJucDS1P92Q3m3WpxWONSAc8mwACR?=
 =?us-ascii?Q?RAiV7RfXmnKNZnk+33x4G7O1HfstJTwF/HwBsbmnh06FaSa03LZgndR3CoNs?=
 =?us-ascii?Q?8fL9cl8N7IinSATNjAIR/xiNfLRkjAgPI3M8mp1UsvQhcogF9JJ3/i4ItnSs?=
 =?us-ascii?Q?ugA52+X/PTvcBp8UCOTzUslVQk9r2ozJRnQmd8fJHiCqVPvIaJFqewits+Ge?=
 =?us-ascii?Q?qounAudQSHrsnQAvbOnp8EddY7Co1cYP0ZNvahFPoZLfNpyKowjatuBWNTD7?=
 =?us-ascii?Q?rsgjo2zJ5nsDUXdIkM0dX+5XZOoWXw8t6fKcGn1Tk0jSjTxXHFN+iC2jHrzD?=
 =?us-ascii?Q?vaRgsW9hXx0aAceDj6V2UiI9V/RAZ7GZm4POcM/J2HsYxcm6FRKonUAUQZzj?=
 =?us-ascii?Q?8UsD4eduwTcdYc6sGtl+2ihbOf5z1MsAHvcxp6X4DfaxYVaBGpeaRg5glY0o?=
 =?us-ascii?Q?1SuPP+HHM1V4uvD7OrqrJGLg3+qUmujYFDC4EaVQF8e565epEMv1vKvD+No/?=
 =?us-ascii?Q?GGZKImYVdomw8EKV/rpLypE5xe093k6ZwirPiJbx0oCf2qbt/3nJn0ITVwL9?=
 =?us-ascii?Q?Zf42XLQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vna4IOS+bojAJRuySGfjR0jrrVTTUTVKS+BPtGBonOg0ZJrjVIdWS9xPPeFg?=
 =?us-ascii?Q?Jc4+8NbDyICA2O2K8b2XqqAGsg33oMxGBY4GBi8Bs7coM6LwZyDyOnkfmpfh?=
 =?us-ascii?Q?0a5CyggBaF3HgX+5WqjlACLEee6l+q566TZEYRHWQ/L2QlWsNrYOUsirn7RY?=
 =?us-ascii?Q?OG7ZaAjHoGzkqRGGd3CGpHTBPGZ/f1O3TvGEAPrhJdnK0SXWv15tJnwvRixd?=
 =?us-ascii?Q?TjcsLlI+fG52YyzWZ2AE+7KIrqkJeB+HlJhAdRq+jalm6v3H9U6xQ3KeFU3k?=
 =?us-ascii?Q?iwvUKkMxWLV6ajJfr8G+pW1a9NW0phmbOktUzar3OvTIKunbOZRgKtkeWrnq?=
 =?us-ascii?Q?EIHKGSzJEN+OxKkjRJJjeKvR0NTkVhJBmD5xAiYNCbnAliCgtYSpnPXtwwqq?=
 =?us-ascii?Q?RMrJ79uhl2Ay7eVxOTerkz9RE01VSf2BcqIbct0spXH4xtvuaRJcFH6hwH3y?=
 =?us-ascii?Q?RBFhxtne7BL+I4t3u06ws2Y3VvRRpnJYFGxL0GJl/lyicZoDb7VkCIU/DIdF?=
 =?us-ascii?Q?TtIcPt7vDPm0rWvLEgefxC0SWMOar9wBygCr1h3WPnfstZEX5pZVxIiI+9ux?=
 =?us-ascii?Q?kmUCMb6SixNP0ReHfGea2hhALKVIP4lclwrS5G7CWFkiPKo91CzbdRj5rVtL?=
 =?us-ascii?Q?r3vjeWnOdl9Alvh5HoK6uXSmigf5OdjvqmBzmw7ZYitN0afu+xe1qoY3elgd?=
 =?us-ascii?Q?/3a84CFNsxVwoL4CcinUs97xppZGv5zXLVfEHkkKvFpTvKkbx86o/Ssq8U2F?=
 =?us-ascii?Q?nwYwoD5V2nqnoqpi5JqiWqQzLTYCxCv4L+IxFY1e/8p82ueacivTbvBnADoO?=
 =?us-ascii?Q?lR9kwgJ+mrTQbEPXRPUCgMhxUSN6NyBxiNMq9AjUn7l0fDdcS+OXTXUp/j1K?=
 =?us-ascii?Q?ODuss5vU9n7wWP2MtHoS6JfMHqMUmQiLpjjFcFY73MI3fca++B320zeWeCmK?=
 =?us-ascii?Q?D6MQOsgtGe1oCqcrDL6YlSWXOHkQ05zG/pDEjUAyQDFWxYgL9CibXDvdEtip?=
 =?us-ascii?Q?Ux8K+T+1CHQF+Q94vxJI2mahOM+buYK9lQCPeSNwg3LY8tCkNffuTIjSe49H?=
 =?us-ascii?Q?VchKH1HIRPR+a08m9x7/gUuLYpC9xoHXMfcK9AVVACELJ51LnWQ/2ZKND/Iq?=
 =?us-ascii?Q?oNjNgSJ9NRGqbB+c3FW9sZNyl9I66QI412oBpAzrSNBVljqoBHE5os6FNui0?=
 =?us-ascii?Q?FOIA79Nq4/LGdRKDsDyP5usCBcFhLDrXr0j0OuBYSMTObsTS2omQx5OEsuvf?=
 =?us-ascii?Q?ZzgjGLsFAE3HFNfAb8ff3ENECxpgB9kqzDGUaWYrdO1FScEqeFvbqMFcAAwn?=
 =?us-ascii?Q?QCFuwPCWWkyQCJ4vdSLf7mBVmqY/1SPtB5sSJlIPg6ak7pK8HK7aHVy7BTyV?=
 =?us-ascii?Q?woM+savtrOSrT1lMjoIZmN0mdjdX++W49ufkGxb/cGFllALqt7DwFpETBNwH?=
 =?us-ascii?Q?HhsPvpYocDz7eu6B3OKQ6Jhf8VTDfIcsBgo/+4XWDiLBZbKfkje43tIDRN9Z?=
 =?us-ascii?Q?ZSo//twx07CCr6tsfe8ot36VVj5zI4sAYV/3fgqrRugPJ9AVV1+OrJ+ZvQmY?=
 =?us-ascii?Q?+ynGkjwLIGsLzhJLSA6y0YIADPM0OrURE4ndVx0ghzNcYGK2y9foK8tjlArD?=
 =?us-ascii?Q?H5LOBBmnoh2inNfGSAAtTbc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17DD634FDD397E47AF1713E348994E9D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gabsdpxckbSC8Tuf7X+WPVFd6dGud2UonN79wFfXuyjGhapcJmAzAXReg6hBWqk0BXwP7FGsQ/6xyFDcTNSqm1lORXHmWTLhoiHRcZPBOuZxIfTMoAVb8AS1BO8t2PH+lYNJION12P8WqNeel2r9DREKAfNPdJgI8D6iN0792PDXnrKkP/P9+fOyM6CneQ2Gc8eZ/k4Wym7TIGy9vHun1CiZqWwQ7uJx34X4u3D7KHIDy26VinobOwo5+D1W8s2kMtBbkUdrl6RV/TZnpzzthm4bLoHfAVYXGZ0+IowyQi+pve53e3Qt8bdaO4nMN8V/LIizF8nbwzT0IzYdvqlbeeuA8ay/cQigZUEHVtwFbhc1fW0mbq95CMhSiwaE1qEmpDbBJQarp+LcUJ6H248ZiXEvNhl4pINtoODDbCYPsVrUJSXxyXuQ9nFZ0U8mkI/4h4RvYuQZutyB58vLQzv/g0fT6fwPKQXW76HZTudIxi4U1GoAqat8VhAv7C2LSpj98YAp7qDd//WexM8GbUDYtyiovmOJvic95edeZ6g5kg9KMMESpvrdQHTu829hL1Gi44CpTMvg+kFSHRewED0uK+tRqMlTYUR58wybKR/I6+uDuaM9ZIfMcFsBlOaQrz3X
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 225063fb-72d0-4ec2-890d-08dcf71b5872
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2024 06:39:59.9623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0nWSUobqZH7DaRpSRomfsd8Hxr/DCM/4Y0qSacPj+JKX1z71Rnc1MPzuUbswGUec2F53RVzlc3mVGM1rBkL5G7B0+esfM4NmbxesQq1I9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR04MB9037
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241027_234004_690685_5E20A685 
X-CRM114-Status: GOOD (  16.47  )
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

On Oct 25, 2024 / 16:40, Daniel Wagner wrote:
> On Thu, Oct 24, 2024 at 10:00:19AM GMT, Shin'ichiro Kawasaki wrote:
[...]
> > @@ -408,21 +411,17 @@ _nvme_disconnect_subsys() {
> >  }
> > =20
> > =20
> > -_nvme_ns_ready() {
> > -	local subsysnqn=3D"${1}"
> > -	local ns_path ns_id dev
> > -	local cfs_path=3D"${NVMET_CFS}/subsystems/$subsysnqn"
> > +_nvme_ctrl_ready() {
> > +	local ctrldev=3D"${1}"
> > +	local subsysnqn=3D"${2:-$def_subsysnqn}"
> > +	local ctrlpath=3D"/sys/class/nvme/${ctrldev}"
> > =20
> > -	dev=3D$(_find_nvme_dev "$subsysnqn")
> > -	for ns_path in "${cfs_path}/namespaces/"*; do
> > -		ns_id=3D${ns_path##*/}
> > -		if [[ ! -b /dev/${dev}n${ns_id} ||
> > -			   ! -e /sys/block/${dev}n${ns_id}/uuid ||
> > -			   ! -e /sys/block/${dev}n${ns_id}/wwid ]]; then
> > -			return 1
>=20
> IIRC, the uuid/wwid test were originally from nvme/004 and copied to the
> other test. When we refactored we moved the uuid/wwid here. I suggest we
> add this part back to nvme/004 so that we don't loose this test case.

I checked the history the uuid/wwid test here, and it does not look origina=
ted
from nvme/004:

 8251c724 ... Ofar moved it from tests/nvme/rc to common/nvme
 8fc8eb14 ... Shin'ichiro turned the test into _nvme_ns_ready()
 c766fccf ... Bart introduced the test

I guess the uuid/wwid test Daniel mentions is in the _check_uuid() helper
function, and it has different story.=


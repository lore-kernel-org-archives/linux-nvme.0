Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3450ED5B164
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 08:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UASzX24EUKPEmrMW+0chjKSL3HjhU+OMcarLI7BCDKA=; b=AMFJ5F61O3A39NDb9Ru8jt8t3s
	8RUTES4vjdDzYv4IAh3Fz9fBHJs2NX0cYOafpFzKaNLL+LP2PNK7gmpb7eAei/eIMQ0ATYb44suSU
	jsQN9PKnAMYhQkwxbfJUZtXKMlo/ySVSi3Lr53lT60YdMc3GHDF8hU8lj6oyoRAD5g4oMdjJ7iqHh
	I+J0Fzsc8OC6EEYeRzx8uBEWZEn6HXIBzfBHTwVGhlLknQE/pLLyu8DCT8PhtFYxpZs8lGKdRZraS
	3CPGShJvBsh7nQ1j9cjG6AZCbWjBO1WriiCH/+81wzLHdOaRPhi2NfS2CEtNCgLMoI40AMRNy0wVl
	EQ4VwIiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5hYv-0000000DgEE-04kf;
	Tue, 29 Oct 2024 08:26:49 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5hVG-0000000DfCb-3Y1t
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 08:23:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730190182; x=1761726182;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PP2mOkVD2n0Uax2KJ7h0aYHSB7eMXF9IiOgjF+pbjZI=;
  b=BbVl+wNDwMSvxYueGxN8Lxr0TbcpFKVksnF1V/p3TqJpM7hhj/pXo+5M
   Tc0tsRAw56MdF0ocYFQB8781ieacMFrNVsH1gl1nNkEIdSt7QW9ljTVxM
   oz7VDLMY8fn1ydhXYorzW75jLDjlhtGxCmvrREDcMcCliubOLtaFcxx2O
   ilK9Ilz/NgEUuegLnb3LL6/ehCMFIqX3QuVmWB5wEOvLiLKvd+2V1jUBM
   CTl/4GpPXN1aeZFH5p5mX7nqLnlxQjxi2JfPMhZQ4TbgzxE0hd3RYb0kj
   nlPS/lUodR36VjJgAIcMxA3RN2NoROpHoIcSJ73e/3CxRF9y8/5fMnqRS
   w==;
X-CSE-ConnectionGUID: LGcAFBe6QhmtvFVOZTAgRA==
X-CSE-MsgGUID: jorBx8T4T9SenkrNiMArVA==
X-IronPort-AV: E=Sophos;i="6.11,241,1725292800"; 
   d="scan'208";a="30229657"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2024 16:22:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bR1fBNY/kIBd9DdvC7bSXMCOB7zp8bz/YLSVh6r0kF9u8B19OLdFjbvyNE6v61l/uAbGjXChvGNmcanEqR1U/rYM2XUy4EOtI+xvXevDXjh7LJxs/TIUojK6QKgQAwbVCmf09XQslAqPj7XJxtkc1w9HCCh4QHL1Lz2WI2lTKSyPdkGvOMO5D7gAkaDQxpZqZH7BWUF+t4u8gOXMpfX7Ix86Qt0qaEkvq9LMPJy/cDfv6mtDmRZzj/kliAePdFdEbVPLTmAfoztBHYLdpeEaV6i+t0cgj2WE/2l+i4dht0wwQOrXXuqer33+g09EyxOyCJFbjJmJml0BmZM0zaxa/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UASzX24EUKPEmrMW+0chjKSL3HjhU+OMcarLI7BCDKA=;
 b=ari/LSgaAZzM9Vow7DHqDAvRA8sFcFrqlQh2cAVSKwjGwR933xSgPDEVMhL4rzxLhDyt0bdpAtRoDEZMEUk9d/l9YjNHJH5gZKmLLmZ2vRWTT+IXDIFdhC6iXxyTO0Uu48twqt4h/lmua7kWAniL6jIes/WoNXhTb9m3R/um7ihU6PCIgT8xmXpmB8sfFK8pdVnSY6gVgCv4mzg7+n3b0Jm8eNMtJPNFSI3cV46Q5H90hM+F54PlftDswMO63e2VXs/e3/j9gtv65q8T//bEQGPxREN0JKIyyTwAazm1SzxwxLWeqB+TNVbOe4xShWdCRvZcAhHG28G6iTKY3V8A8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UASzX24EUKPEmrMW+0chjKSL3HjhU+OMcarLI7BCDKA=;
 b=u36dZFlVPUtfiKO6JqQoWLDOrfEL0kT9MamUEQ/rfuL10vTNntP5ua0F1mBfhsPNxq84Dtu45gIj1WU6jFh0MOlXRQ9/O37lGZf0Xr4jP5WFt/OPlx0jTdL98Nsh0tdzAqZVRAkmn2v1bv7P/zXn0/8h8+iEvEnjjp544CNv8s4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA2PR04MB7532.namprd04.prod.outlook.com (2603:10b6:806:144::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.27; Tue, 29 Oct
 2024 08:22:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8114.015; Tue, 29 Oct 2024
 08:22:58 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Daniel Wagner <dwagner@suse.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 13/15] nvme: delete all namespaces in
 _remove_nvmet_subsystem()
Thread-Topic: [PATCH blktests 13/15] nvme: delete all namespaces in
 _remove_nvmet_subsystem()
Thread-Index: AQHbJbAn1b3FHw/0CkKwDZuDgVsGErKXnzIAgAXM8oA=
Date: Tue, 29 Oct 2024 08:22:58 +0000
Message-ID: <6vuo4swzmwsviov5yia3rgjz33fkgno5kpvnl2mmtislqdkti4@l2zor2k4o3bx>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-14-shinichiro.kawasaki@wdc.com>
 <f93f04a8-ae68-458d-a1bb-900d984a9208@flourine.local>
In-Reply-To: <f93f04a8-ae68-458d-a1bb-900d984a9208@flourine.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA2PR04MB7532:EE_
x-ms-office365-filtering-correlation-id: 1cccc868-be7d-48b9-c22f-08dcf7f2e557
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?68cID23gpVz/YOxbyT+rkt0vkPvyU8ymtcJ2K2BrZoPyUzgc9RGek0nKgp1+?=
 =?us-ascii?Q?MH8K3DrsUQpeKJYpy8UNevOih3HHqsiRGYR3lrCli1ix67OoqvYWX/7rhSrF?=
 =?us-ascii?Q?sAnGrLDxCfH9IVSde8IiNxwAcz4PFZJqyiBztlz5StVlY0lMXi2Nys1flMhJ?=
 =?us-ascii?Q?GRqb7QIYa1oeiWIEfdn04LQmmHqATwQDciiOlgNuo0r7h0UjE1gljCMMJQ+z?=
 =?us-ascii?Q?y8Kq4UC6/+21NBaq9TSpLE0ldRqgjjEoYJ0FqKvPHIXF3Mfg8/u/065aD5SN?=
 =?us-ascii?Q?jMKi61O/T72WZ2t0d7kwC0u7y7gRtcOSVVw4C/ctsCccHZNac1xRxvdHsWkJ?=
 =?us-ascii?Q?xAO5pLBko5VcCmJO83W5rgQzNmm1B9uMzi5Hw5375dnF82GQcAZDkUVT35wH?=
 =?us-ascii?Q?uaqmaVGYf3QifMQYUwpEFjB/4NTowsdjCEK8aAtOL0owRfbM+cl7sGf9rKOv?=
 =?us-ascii?Q?sLrxobFUNCXTSmUhhOZTixTD9KuVj00uu7p8cgrRp6Cduc5gJTr+u2LqF2kh?=
 =?us-ascii?Q?z1gUbeMlbYD7/lRg6c6CPqjm5/txKm0lCE90ChOf+06AeSntPEcGsmB1Is0e?=
 =?us-ascii?Q?AgyzSSpHMawxyxQzI0cOePiCONG4Kwbnag2op4QHUBtXITl5HIiWSeUpyuJv?=
 =?us-ascii?Q?g8JWa7Xv/Q7LjAMWMpdwcHYKnGhXJYfJb1fetlwfZ9NtvJtPvXTZyxlmAJyc?=
 =?us-ascii?Q?u5A0y/3ZNoL/MXfEocPrg8V8g+espPBMM+u2bHfII4BfVo6mHTf7K5gq1Or+?=
 =?us-ascii?Q?/1ApF/pz0paXtSKVV8FltyiWb7LQzDs5E+ShG858+Rv8fGXIFbq603rZ4Tuf?=
 =?us-ascii?Q?vZFhG7Z91LSE9bsjWDSwaqjngEq1ZRXrpsW+6mX+Q7WqBiy7nS7qP4Yji9W/?=
 =?us-ascii?Q?XhgeZqcwsEj7mIw/HFX2M59Cy+Qc45a6JSJwZKDxmV+rsZNNbJnRymlhhpcH?=
 =?us-ascii?Q?aQtM1hwTdFVKGqMd0IPf36VqLdDMVRjiJ9DHPpDcvjOSGpO/4loOSTRolc7D?=
 =?us-ascii?Q?N5aDl9hoTjcnd7cZyGCkO4q7Lus6dqFTDINqy4ej2k/b/NkFlN1TzDbJMo+S?=
 =?us-ascii?Q?b06PTc3HWhZ295K/SWvQFio/NvKeYD15mUMFyo7Ll6y9wwiWG5sl/cWBFLVi?=
 =?us-ascii?Q?785966vvrmMxzVHcl6ucjFVGe5FhseAUFdYTVUG0YG41oMeFYDsTUzHrXy5h?=
 =?us-ascii?Q?n6GEc1UTRD8VnaKVgEwIDCU8B0bV+Iuxmq2yHzw/Ptlg+RcMgqcYZFVXCBo0?=
 =?us-ascii?Q?OmeEWev6blhmQi3lZj9Rw1M2ttjSB6nCn0m1Ypece6BBy35Tdq9xTOE8mZ2b?=
 =?us-ascii?Q?kWX2y3iF4ZUydHHeNMWmyP7b/4K6IduiPlmzGnOGY+pvvYvB90VPQSzDGfwD?=
 =?us-ascii?Q?g2yMHTw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E2+3QtCctr6GCPqt8pdjq06THH9OkmSlhduDUig5hN5I/mPW352x8NN55VQe?=
 =?us-ascii?Q?4oMwSZoxAR6COMqQUNVaafcggWHwsiM7B+51B3hDTKBri7yx5dISvolQCy5q?=
 =?us-ascii?Q?42JsIG3yP300zwTVFMs/3I/XBF4eGTCbrrg0xoH4r1G7vQcurDlqZtK9sU+m?=
 =?us-ascii?Q?ESFcCFrQYaMoXG71jk/3OET6ke+O+Amw5s7uinpXiLTjGFGmmWU6v0Cl6Hmz?=
 =?us-ascii?Q?P5ZeWx7RXD3ejGryTvlPV8Idl2zcxRo/3E3lxCTY35u7q7nuVlvIVUuwUIce?=
 =?us-ascii?Q?7KJ/Z0FQDtfb0sAuG9dtwjUQtKwJ6cF8dboY1mFZAku06Y56LjXJBGsXvG6N?=
 =?us-ascii?Q?vLir2CgZaSRG4u0Dsa2COjh3nXQ2dwDcY07pNkTRAQFkb2QOVRORdE21eVl3?=
 =?us-ascii?Q?cSAt9o3xTIyMb9OByKa8WH58GuIXcWB2U6FrBZuziEFqjqZEdbWvmmmj7Rp7?=
 =?us-ascii?Q?7FyJc9ZsQqgcfBqLf9XZ3nmAYMRq0pHrdSOT+zIaRkgH9OeOoVYPaak0L7cX?=
 =?us-ascii?Q?W/TcnFjJwWpygauG3vRcRgnr+iMzrLUGhu3sLK/YsiOibv5YGubDPIsblroG?=
 =?us-ascii?Q?BB5WWM5DcZPyNiNFaQW/XdeTppHMNZPIqcjnfhCMk+hU6EPu489EYALhIkbz?=
 =?us-ascii?Q?p8a36dyDSFVtTIWgkYtmCZME/xQmZqbwkd3T4Sqho4jr9AJN1SLfmuvVtv0x?=
 =?us-ascii?Q?qoO7wLhVonX8w1+mbkBns97mM4lZX1wjBVsd719p45h9NVZn4nOuXEEm37DM?=
 =?us-ascii?Q?LHDhnLb8XrDyQHETj1s8HlB9ILJ7JeOgON4qrqSJFFf24TginLAX3oqo2rQ1?=
 =?us-ascii?Q?mgAUlMCptZZ9+gBV3f4SYqisEWZIHApmepvmqfyy6O8hUcwCW4T+H7aW5G0P?=
 =?us-ascii?Q?4e6jaykzTy4GYIDpLcgKR8EIPVpv4FAfXLuXeKmQrXbteH939LPDCO3k7R8s?=
 =?us-ascii?Q?E5LZXPRbarMGbH1N2/zceY2P8VFKxvxeQ+vLiysZ+hUQr+jafZk3NLT9TaKW?=
 =?us-ascii?Q?Dvyt4OqksfZ70MYQ9mh2jvsmWuKRDjBwTS5FQ9WS2t2VINOWEz62muNmnsKN?=
 =?us-ascii?Q?ggCG1bRDd9TSrcbbIpclHiCxR86cJWCugPoge1XX8UREHKSuTIJ1JNE0liKp?=
 =?us-ascii?Q?hQgkIf0GyxgoEHeUKPw699YUtRc79x+180wkxypuUFVDHL839qeCfqcqHnwi?=
 =?us-ascii?Q?SS80Y8DVK6kPlmoq+YbATncSXXO6LPs8w+ldrtsjPlMvOtunjh7stuHpUd/k?=
 =?us-ascii?Q?0luTc6r/CYVGwpyJIcOZy2TQihAzDztvVi4xAjvEzNpmkH8VjMK6RKjc0Z8L?=
 =?us-ascii?Q?EGs0tebPfUb4D8bd33PDP29FbuSm53XYVU5DeNVVR4jVfwys943Dcb2a+w/9?=
 =?us-ascii?Q?zUVgfobSeNaqjCIqA3l8i0pq84+YsyIHt9wANIVYoLdAQNO91EGGizaA/3MT?=
 =?us-ascii?Q?Alq1Ugp7hEP+FZpKIrkx451CvY8D0HGFU99uiKl4mtVj9tAv1mlbdEtGU6Wk?=
 =?us-ascii?Q?yA0BWHF+Od/Q7ocgX2mAJlSgfh9uFdHfn4LtYlnGqk0dCtHCgdT3gGnnfK2p?=
 =?us-ascii?Q?9fjs+5UjndtrvCYNCW5kEMdmJJxMDxQ5KfpFTPpPwNAHeliZacIw53hAPVDT?=
 =?us-ascii?Q?L1PnyZSgLxZcfFYzT+LNNTQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <17E59282BE57D442A576AA96029FBFF5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BrQrIrplcfpYAfjI/88Z5revIIbTKjmsOgeMeCpqxn0XlhiNZ3u23Itce7JYBqQgZgD/Egnqk0p6hPJ4OvxvdQVfBQ6l7n1Wuz6mC+csZsWbiNw56zm307P03zpwWDYirdGDqRL7YqFgURTSkoNixPuYwpWRyGPUeuawW5Fi3/Jp6faCZQ+lifBv7p8Tqor1SD0oV+BouD1S9f6tb192enIEVXURttRFUJRzstx3oxnM/ahe8G4If0rqm1o7bsM6nlYX1QZ2lG8iEfaHaYFgVJFJ8U8GaNOcWsFLpItIAsSAyxyHzMvqa3XzZa9E63ciHHwPtXEgCqo0etrTq7Fich9S9wJj1Gl+k+qMeMwwEMBxTdFNudyROta0X6Panhr6nrvNia0+To5xtCp3CbU7xpdRjGxTITXU5bI2J6hQjnEkCWIqg36KS3Gr36q6NT+O+F2rM50SMxyDa8vr4Yj5bRDpZ0ufLgp4cpRNi2b99nsAhNsaMiKwEkU5+sXV9Ey885uqae7bLBkPhmhJDMMrQwVoolwKYT7OyQyY6WD2gsyNriolqlur4D0ds1PtRX/2kCipIJJj3M8UlLfL8l27u9R0oomxfrEzT6ayS/aCmo0fQZZKcAmn5RbzLnGhQfoD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cccc868-be7d-48b9-c22f-08dcf7f2e557
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2024 08:22:58.1583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VsLYzX5nDKf0O4YSfD1wfq09c/UPXhE2rcqE2tZ9qxIPIhm10/2RiK5jVGYHo9UYCDc5GZr3RcODYZMP2cBvGs6HCLmTJTCav1+J7GVx02E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7532
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_012302_953432_6885EE35 
X-CRM114-Status: GOOD (  17.17  )
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

On Oct 25, 2024 / 17:48, Daniel Wagner wrote:
> On Thu, Oct 24, 2024 at 10:00:23AM GMT, Shin'ichiro Kawasaki wrote:
> > -	for ((i =3D iterations; i > 1; i--)); do
> > -		_remove_nvmet_ns "${def_subsysnqn}" "$i"
> > -	done
> > -
>=20
> Hmm, I read the two test nvme/016 and nvme/017 doing explicit allocation
> and deallocation of namespaces. What is missing to check if any
> namespace is left after the explicit _remove_nvmet_ns run. I think this
> should be added and instead removing the loop.

My understanding is the this change will be required when two new test case=
s
get added with multiple ports set up. I will drop this patch from this seri=
es,
and will include to the last series which will add the test cases. I hope i=
t
will allow easier review and discussion.=


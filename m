Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE01E7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 08:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vNJ+0gI5Ut+iy6Rn3DXGLSY0s4koOhLjnha+WFUzI3M=; b=PMVKGkUKduW8ZEz6cSuv/m+er7
	kHZ4O9YGECc7lRRBkIHhbpAxE8fWZ195ezxvKqwBN1BFz3QPxtVyqi0vQllrwaGHNd/zV4tRoUER4
	9LhNYA3bBrFeU6kQ0xaxFj/ZcSVeEx9mc13TcVVLpc9On+8TD4PQMoQVH9lVSYLbrgvPV0hFuOxEG
	w9vB3kBoXSwW9VJGQjQ5BlCooCOwxD5SCOhINy83oWAe8bx2lyfu6ClZjZaJzgbGRfYOZGHNyc/yT
	+BaPDROgj6rETupEKfy89SZcWP8Rqc67/T67x4Rk7Uaxsd/nnl/WMIJfcZvwScXC0KhOFemA7SjrJ
	z/HIVLsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLIBr-0000000EEqK-1vT9;
	Wed, 11 Dec 2024 08:35:27 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLIBa-0000000EEp0-2wa0
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 08:35:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733906110; x=1765442110;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JBfDHr/aINrQJTp+o16R9RvTbbwul6g3EYZxYauabC0=;
  b=iSuBciOZ9LW6KV3d09Yw3S09XWS+sXeopU6kJ49YSVok8uTSaZY3M22X
   +KphgX/7YR3+vW+P8mZNpHc7NKsz8C4WeTHAhw4QpzOLh6ombCGcopnEz
   /BtXAywPE9HC+h941BS0cW52KjBRaOlEwgSWBA3oyJSC6zpPcCYaH2HBA
   QV6mT9LFfLCcDWvawmAsuVjYplUOU4hLsyHUCL+LkfOwxyUSsOpvwkr0o
   8zPhie296HglDyldPUlUmV58tw6n4dm9r07XgCupElZhJMy34Sqxm7pAo
   /cM9BL27odWwfQLlIdhPANGG8a7I5MKmoMvVhkySqvfuU71W83J2Iy7Q6
   g==;
X-CSE-ConnectionGUID: mtnEUhd5Qj6z3PozeQwB3w==
X-CSE-MsgGUID: qxlAXBqRR2WultPbH+LCBQ==
X-IronPort-AV: E=Sophos;i="6.12,225,1728921600"; 
   d="scan'208";a="34691335"
Received: from mail-northcentralusazlp17010000.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.0])
  by ob1.hgst.iphmx.com with ESMTP; 11 Dec 2024 16:35:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A3v7aDK9FwxuINm2usf13ncvVbkevAxaNJz4svriy5IJgRg/3VdAsnQyF9rJd1Be8LEH12Qb4AQd4vzgjCafSviIxJQJySuUEtFevt3ZJLWg67p92qG4oPBen6c0jYwlp1odsvWkX3HC1SkMXY8TnfTN5ufSjEwn70eBbkaAEXDMTbSoUqOl6O5G9Ss9BYMQBQZ2Xf0rJ9+j60BJp0TcueE/88BqrNmqW6oxqeIQte8SAJMd838xxeXXGsRPy88dRA2xL0D5UcPUZe99LHrtMYDY1n1T2AYYfzdLv95UzeihTcyyKtp3UGWseyfFJ8C4oCz8rHOPhOd3CsI/lE34Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNJ+0gI5Ut+iy6Rn3DXGLSY0s4koOhLjnha+WFUzI3M=;
 b=qcZWA+g6cD9H2rUucwfOitIoliW/fWgmWVctRR4kTou8MfdY7Hzmis6dFUYu4Y4STVoWfpZ8NhiWpEIbvjpnVrRwYrQLHPWuaRA4N5fedf+7Hy0v8OMSY2pJ4gWAZwJhAqJHcL9vgilebHos8shEPDP2ObXlB3ogG3it/dBpdF1xBLRbopv723ztKE7pHQPruyWnmDoWcxwe0p5V4VdkmiFnT7GIXklREyzZ8xOVHeWNKrMp7TMpOHveTKSVSpJ8QdlffU1mSI57489qZIDYjlmTNe/uXGgX78prffKiFWaUyjS2WMuYFfYFPwe03UQZA7yTFGphZuR7vM2KLt/Tdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNJ+0gI5Ut+iy6Rn3DXGLSY0s4koOhLjnha+WFUzI3M=;
 b=ZJMIdKLwD2vxwsBVRtQ0NFCunNUw7qMHU4uMurDrwykxObAK3hKyjWlQ6e00DEa+pD8wS21H2MyMa8XgdIm6KhWrSoiNSTbQ2N4pMGKumwZoVo2yrQAKdOEM3iU6SxlP1PppTNwgKnPHjunVRLHA1NkMRjdsaVXDcAZknp6z5X4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH4PR04MB9081.namprd04.prod.outlook.com (2603:10b6:610:22c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.22; Wed, 11 Dec
 2024 08:35:06 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 08:35:06 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 0/7] nvme: add test cases for ANA support
Thread-Topic: [PATCH blktests 0/7] nvme: add test cases for ANA support
Thread-Index: AQHbQmJJ8UFFBKqgc0SPuuujc4oUTrLgymOA
Date: Wed, 11 Dec 2024 08:35:06 +0000
Message-ID: <nmvxcnkntu62jmelkyjhnqs3swhbqf4hcavmdd4nr4ruglrsf2@nk4r2xbrwxba>
References: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20241129132617.400429-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH4PR04MB9081:EE_
x-ms-office365-filtering-correlation-id: 8b33681d-395c-435a-8561-08dd19beb701
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?vFTBf4jUl3kTLpWL+1uYv1YbpJoWpuDSQn2u/0ltgM83dQvr+y/i5YR7nL9e?=
 =?us-ascii?Q?nlY8CU8zM3Sx8v+StTR2N82fAFs3WUB99CYvn46tBEGoG5ZUO10vOVjRI6DN?=
 =?us-ascii?Q?aUqjvYYKKfu19KBWJTn2IftQzNZP9r644z3KhGp4Jiw1sR2mU70yUWLpCD2k?=
 =?us-ascii?Q?Napol2N/1y+SLnmWOwGcL1kr4LZ9qqyZCfHmKv5XkWFVRkQ56Uk8teqpBOKc?=
 =?us-ascii?Q?VGU2AgkE69KGVIO+PD+Zy6Ofm1gtbjeKys9FTMHrayLSkOUPOmCRz3nYRWSt?=
 =?us-ascii?Q?jbk+PlQiBJ+wfD3dlL02lLK7WpedYCUgWWAlYn7uXTtb2gLufzXo++F64RvJ?=
 =?us-ascii?Q?+u0Gj0e9zcQzFWqtSKuO9g2/o2FXF50aEKHEK7bTEj7uhfVN8Y1PXz/UyRd/?=
 =?us-ascii?Q?s8wjjkqogtBBjLI+tmc3Wev8kb5AyU8FWpJsfJsfQbpRJR0PEacd4NHsUU4Q?=
 =?us-ascii?Q?CC262hPfQiZgVOtUdFq4rZUTNKBIrItoP4nPdWGXMoJrKTN+3OdcguiJhz+a?=
 =?us-ascii?Q?ZGVNYOvOtMpQ9I75gy3k0Brhpy5upW9wFG3MU1yxD9oEaZlpGDYKzPUvStHE?=
 =?us-ascii?Q?/G6QlgUz5+d5F7xTBcDukzwI49jSO8QqHCRj9B/V02l6WCSNXjriQmRtNZOI?=
 =?us-ascii?Q?GQUYie3n/lKGichtHgmHghv5TqIYTgb0PimOaQ1xzOqoeoSJwqGherGxLKe5?=
 =?us-ascii?Q?4djekf7n8d5sP/M+V7gQ2uljnz5bSC/LOR1VGBVgs97hbGbCxkut2MmmBRb7?=
 =?us-ascii?Q?orzBaEFcDCjmDH6889JfJk+yL2REXDAzYJIzH2Y84q+AkxjFuYJge9kWJkRE?=
 =?us-ascii?Q?a0+xoRdly7DUJutu3nIxbvRrxh41P/aPHqYFM9gpmEkZxdx6KnGw8XA9tI0c?=
 =?us-ascii?Q?qoh5i7ZsnvUygzTBAL1D26Gj5yPfB1DJIMTSU5ESju3xBrItLwqQLlEGNTTJ?=
 =?us-ascii?Q?LVEcaHmUl/tTlocY8b/aYHoY/NrO1N5TwbiZDGhuBR3/pwRpCe5ODhmxHiII?=
 =?us-ascii?Q?GwVGGKay04MknV/0M9ny7c2VszcGJJtXDWDn3N+Tj9rlj0CWBeUmiQk82Pqv?=
 =?us-ascii?Q?/0Hfg+ZjzVHjgDIqLmiPA66f/TtX0upUHHAOtGaUOd+K8r4DRspbji3ZuJK1?=
 =?us-ascii?Q?Z6/zZh5fO9KZGZC0NlopcsY6IT8PFpupDUkCuIkMJOr0bZkovQwAIWaRNfC7?=
 =?us-ascii?Q?3IdYNkE3u3Q3wLKMjQ589KNB2j1Cw8Khlh+K/co+IXgC4BKOLRK5i8hVV8Rb?=
 =?us-ascii?Q?98mv3Bv8En5KlZTCGsWuBsuhcBbA2y0RGpiOVDWnrziHlP4Mog0VPcKFmqUa?=
 =?us-ascii?Q?NokgSfMHRNmMFSdZQGZQSOMPzGXLVzbK0s6hLPKkVGvYCA7KOcn6fD/U3RhH?=
 =?us-ascii?Q?z6UtJcBL1QTW/km4wsw9pGGv3pns4xIdXijjOxiky6RxpA6MPaDU6HsvylEQ?=
 =?us-ascii?Q?9uCv3iXtOvw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KYD6t5F4V4fH1UY5faHNeO6WIes9wiwPffKqHAWX7FQoqyo+NwV0EjBChJLX?=
 =?us-ascii?Q?yO8RGUkPTj2k13iwBn7EqMgPUWBEH/clR712C56BJItqwRID69r58cZHNkTm?=
 =?us-ascii?Q?D2vCeyp+tsGu0yQqt95MOVEh16cDLFwV4mLAeJYAVx1Erevea7G11ftthwJW?=
 =?us-ascii?Q?9r7eWza8HRo8DBH2OM6fpnpH/s5tG/DnbKaHCCVOy//gfegbrnScTs2o0ZnK?=
 =?us-ascii?Q?kqCfM/C7JlXzVJG5g+VgNvep0TAIixSQ5r4R2miw2LeEcTQ6aV1t4ENFJOkp?=
 =?us-ascii?Q?S3dWW5mF8OYDIWjd4NrmOjnY9sK1qsuIIvlm8xtzXPrPjKkVS82wS+5ymV21?=
 =?us-ascii?Q?IZsy5uWKNJSuW7Ie2HhhhZf0ROpFzgndk+xzxQHAqEPaXih6RAn77re+Q3uf?=
 =?us-ascii?Q?Izp/4lWe5pXzO2Ut9W2Ec5jpDTUDyopFTR/x3PJZCgRYxhIQxhDn2H310suj?=
 =?us-ascii?Q?Npw9WzxncRzimLHIH4HOeg7ma8HGqHeKY+xCm7zz6SMT+pBXPtrWO1bSKdPt?=
 =?us-ascii?Q?gDCBtWzvTWa5mGPAeSbwm0fUnALoGsHmZx7vgQSEs1RjLs7ChZ2pyxsQtAoF?=
 =?us-ascii?Q?KpvAfbOj1aIldliNi1sFrRESN+G3bleHF/2JdP9Ayg+a67+L87J+ggclCIF/?=
 =?us-ascii?Q?CAP1VXoW1fzpl8BoBJiGOXNzy2Zc2Z1t2m4Fi1P1iqrpx3EAlRc8XO5mPd5F?=
 =?us-ascii?Q?t6Bn3Qp/pa8F69CQ3xo9zt3aMlwErjZLcmKfsZZy35S+P7tvxXpjFOlWwWEc?=
 =?us-ascii?Q?wcZy8j2bF31bir2b+oUZXARHG0sv67oQ2FOnBo7B7iB25jgP+MLWYI5H8+Eh?=
 =?us-ascii?Q?IAdZsugmdiAbSVd+RmN+5B/YxgHbE1K0VMhdALwpI4Hk5mF/oddOolwkPg43?=
 =?us-ascii?Q?U1LM07nt0FkXCWg9L96zXyVxAqVhVuk9qf2r1Jj+xbRtGBIUhFGlczJo1sqK?=
 =?us-ascii?Q?Pg9ybHTfqkx3/0PB97i/mqwOe3yrSnzFDZuIzq0WmZZCmlnH8n+1fWFQx0hz?=
 =?us-ascii?Q?AfI8xZwyfyUTtZnWrLQoCFU0OEi5q20utyvg+OSUaTcTx/0N0xLw0vcVgwY5?=
 =?us-ascii?Q?MQwdZO8n9wIEIQhfpaZdFgvFoubYp73Xiyeg+U2WeGbTeGxwnWMrUIaDl/bG?=
 =?us-ascii?Q?aDDYRaIK7aWN5GSVoYfg3I3Ke6yENPo0bWhmAvt5H8fGj8YR8IWowweUVY2L?=
 =?us-ascii?Q?3MWM+36OecRfd3xel4KClwBz4rf/xHE/o4oU7Pt7pHlZDT3bNv+3h2MdvwzB?=
 =?us-ascii?Q?2CX2A91wVMmRH0e3PoSjm85uB8Klj+DOJ+toLEJuIj3Q7HKhlrBrI0qsSq89?=
 =?us-ascii?Q?r8nMHciKUVu53Dzryoucagcnm46NiGP8DVD1aDg2iOKwiND0aAMeZgSFaHxF?=
 =?us-ascii?Q?d4v5SqS+ksnhrjTKyn+FANmh3HCM+t5H0ooRCSWKppMVb9glpDsS5Ub6d3BI?=
 =?us-ascii?Q?aw68z0QBDh4oiszhyfZmfr8ZXQpAZLxckGkDT/Vks8bTmK2zX/wEG4sAVarY?=
 =?us-ascii?Q?UPAWAPX7rZ5d0w/NFBE6L6ui0t+nm5kTmKhww0GyGnewESF9Edhx22swk4BR?=
 =?us-ascii?Q?bM7RU5xoGwDgd83IFeTV9OSt3/wElVPJfaBFZf0xeJhjOP5kvTq53IDHUOVq?=
 =?us-ascii?Q?jOCXLIm63/tEtZ628lNxRWM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <75E5AF46EA133B46B1C59969CD4559DF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VZKnyy+Re6rQiFMlzJ0+bheQKQn5RBfNYqHS6mPaPsZduxIYl64mnWyVKums7Oxlxg+s6eIZhIgjSyZsAqhSoiEwEM5zL2UyK6Lw6EAH8zNNW+HkHK9gFYnfDnTIeRFChfnOUEwU0r+aneMzkjY/z59eB68BRH5wO6dwr9CnMDi5pXdUnkQMYrBY6x9JafJ5BDqReY9fJiQRTUoCJWFFwkucJdWhg1924k+/5JoxK5CxcArr0ewbLuuQFXuZ4PDMOpZW/PMHbZW1T9yiRCtSPoJW2MoZ+iI8iFYh7GcwzVKvE3bPnzJUr5y1bpbzL29el2mCA7A0jD000qwHpBrAXFWGB/Ohy6R1WneZP4lqr2mQq4QOnlikhiKcYhSYffUkQoGbm1MTgojlzNYdA7+62jkpsm0MLMp+GOGEcJPjuFWd5Ad5+SpH56/BQHdyRi8EVnH9/hMV6dgrAJZXrPKTxcbapP/u/Z3NvoqMPmWsATvJv5Rl69qRmOYnoREQ0AO7qwy88pUNBpeMMX3a6LXw7MnPuweHTlQMsZLKSYcn5G+1NqXPHUm/girRuuYnicVJoxRvmWyCwuylJWLz+ot2qAqoUhiZi0Lm4L7gvhExs5szRkncLZQ6j47Mh0MankM/
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b33681d-395c-435a-8561-08dd19beb701
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2024 08:35:06.1257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+p0D+lTPBULhkv2HniwlBDTam25IePbzCCLgICUx8XDOhd49B0BGjkBY32urQ34wmxkcBM8624UdPu6Gj77AUmVixfTjpxcwZpFeVvz8Qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_003510_759884_A328C413 
X-CRM114-Status: GOOD (  16.71  )
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

On Nov 29, 2024 / 22:26, Shin'ichiro Kawasaki wrote:
> Hannes reworked the nvme test group scripts to support ANA, or Asymmetric
> Namespace Access. This work is tracked with GitHub PR 146 [1]. The amount=
 of
> change is large, then I split them into a few series for easier review. T=
his is
> the last series, which follows the second series [2] and a follow-up fix =
[3].
>=20
> The first 6 patches in this series prepare for the new test case addition=
. The
> 7th patch add the test case for basic ANA support. The last patch add the=
 other
> test case for rapid namespace remapping.
>=20
>   [1] https://github.com/osandov/blktests/pull/146
>   [2] https://lore.kernel.org/linux-nvme/20241107111354.80606-1-shinichir=
o.kawasaki@wdc.com/
>   [3] https://lore.kernel.org/linux-nvme/20241120102051.247995-1-shinichi=
ro.kawasaki@wdc.com/
>=20
> Hannes Reinecke (7):
>   nvme/031: open-code helper functions
>   nvme: add _setup_nvmet_port_ana()
>   nvme: add _setup_nvmet_ns_ana()
>   nvme/rc: add argument '--ports' to _nvmet_target_setup()
>   nvme: delete all ana_groups when removing a port
>   test/nvme: add test for basic ANA support
>   test/nvme: add test for rapid namespace remapping

FYI, I applied the series, except the first patch. Of note is that the two =
new
test cases are renumbered to nvme/057 and 058. As for the first patch, I
remembered that it needs more work per discussion in the previous series [X=
]. I
included it again in this series by mistake.

Hannes, thank you for this contribution :)

[X] https://lore.kernel.org/linux-nvme/07ba0b79-1438-4068-a901-18d5713d52f2=
@suse.de/


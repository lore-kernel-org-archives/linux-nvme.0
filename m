Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6155E7716E
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 01:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xAPX5AdSNbVeyJ1vmir6RZeOVwWeFDSMPSujxMhK2gM=; b=zizLxBLGiqZS7z3xEJLcePYX6x
	uJYbw0xCvFjo1iKG5m0FnAk5/Kp+vSUbrq/50HOXlKZl/6222GuSWmoAz/iiuK05efnZHUFSoOMbA
	91ZpOzqa/hV2IzeB6eigNEB9VzrENAEU9UNadN0sfoHz/o1yBZ+/kmN7/02sDxEneFT1wuVBLtjgy
	kIFPbs6Yi2Wmpdjf10osxb6ScTEGYb59JzdgoJr8v+Uh2vkjb2/GUK08h7ZnumSPpLtHO53gM5RjE
	ePNY1Ut+8ior8rL73sTdXMZ/kAt5SzQriAjPWLZbytJTig20hnqpzZ/pe832fA+mGzVu3ST7rpaJq
	Fm8gdTqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJMqZ-00000000AYP-0AJi;
	Fri, 06 Dec 2024 01:09:31 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJMqW-00000000AXt-1Qbd
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 01:09:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1733447368; x=1764983368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xAPX5AdSNbVeyJ1vmir6RZeOVwWeFDSMPSujxMhK2gM=;
  b=rNpypUSXN98RfbV+X5oaWmeGNcysy50uHkFIgb0Cxobvdfnp18VgBfhb
   fkTDRFDqBb0FNQLQEYAn/vl4sjZripnC9b024EUPttwcy3OTj3VuMrsWU
   Tc3DeX3f3ElqW7u1lx+GnNSEh5wWIVGSG0uI36Iwm0eecl3hqtZhNnFrQ
   gzevMgj6VX1MBwqjoQEChIrC8HmSydmAjp2qqz1/GkSztruBRh3v1uCJW
   L65A4hXbtiyk8Vcpb53Yh7voQBgu15yveyun72+Z+vTeSGqfpcLPv6KTV
   gldz+eXc1GjzKcUlFVv01KsNrBF9SYYL6YiWNRMCLuFDjR9ugAN4A1BRP
   g==;
X-CSE-ConnectionGUID: HYEOUeWaS8y7gbMLLtPLKA==
X-CSE-MsgGUID: krcRrIFgQkemc6ngwrNgvQ==
X-IronPort-AV: E=Sophos;i="6.12,212,1728921600"; 
   d="scan'208";a="34227101"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 06 Dec 2024 09:09:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VzJrnVH35CY3YbABa8kvMlvmkoJ7XPujVrPUa6kH9GPs/5Rg1AkgMOLdeuSrTqaWx8MglbHPC99VFXLNhUl3dMkhUTApLz6XACbXq2jA3Tm1nv32kkWLq3RiOXL4Sj6lmXBwG6al2y22U8guC3+03x8/gviT/TSBSwQp1B7qKEQu4dfi3Oadqwk12wsExCvKeeye5ojuBTqb0fJI26kqjmtbrre89Sb7lWQB6hUMGwmw4xfjAuEpNk20BkT4regX3At/rf2PJ9lckHk50x+nkI/YmupFJcZgLCx8tvwEIT4sBdc7Az18ISb0eaRnuKB6rKZeLftRmZMslnlLM9ndhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xAPX5AdSNbVeyJ1vmir6RZeOVwWeFDSMPSujxMhK2gM=;
 b=JKRM1IrtDf1M/AyuX4TjS8SsiyLp8V5AIwmuauJ8V96kx1qh67vCaav1DeQi2O7Wub3mammNvwNZFkPP1sxJja1ZXrBaqTH3t6YBHrVS3GyNcARz1nGeYBH8uC7aQE3KGl4Lq7QHzzdmjWQlptavuluFW1nfMgE8pJTuqvX9zngjPLhn9a0wHT9THm0tMJUgpUj/FnNF6ALNrwG9jILbNydG7jATFIOaXZAqYZBf2Z6r24amng0QRIrI6ADXBFlowYhzhPDCU4QUGuZpyy6ljGUyE/Rsfzg9hNgYi/U1WQkgQwaoMvflLagqp+3hMLAn5WCNPl3hSj8EAYMfY/kXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xAPX5AdSNbVeyJ1vmir6RZeOVwWeFDSMPSujxMhK2gM=;
 b=nEafumB0PQGQb0tZyDb0ONBXahEePjvx8ZiKdLV2Lt6cOX4xEXZwao8frqYTxqs7FmKeLxhCGfK+BK4/atVh/fp8FTAWBtF/TMo4qp/SUHCG3RdSrHenccJfRP2WbXI/4A9BY/EEu5UoDQIYuNkPkGMhNxBYRh8kS2kBsiQieLQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA6PR04MB9374.namprd04.prod.outlook.com (2603:10b6:806:435::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Fri, 6 Dec 2024 01:09:17 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8207.017; Fri, 6 Dec 2024
 01:09:17 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, hch
	<hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"chaitanyak@nvidia.com" <chaitanyak@nvidia.com>, "gjoyce@linux.ibm.com"
	<gjoyce@linux.ibm.com>, "jirong.feng@easystack.cn" <jirong.feng@easystack.cn>
Subject: Re: [PATCH blktests 0/2] add nvme test for creating sleep while
 atomic kernel BUG
Thread-Topic: [PATCH blktests 0/2] add nvme test for creating sleep while
 atomic kernel BUG
Thread-Index: AQHbQji2nd2WUOE9rEKflXfeOZlVkLLPiuaAgAR70wCAAC7bAIAACwIAgAQx6AA=
Date: Fri, 6 Dec 2024 01:09:17 +0000
Message-ID: <phqzwah7w2sry46ugcgl6ix2bge5j564lvfbmzwautqgv2zzbu@d4e5mwddafkq>
References: <20241129080231.2994578-1-nilay@linux.ibm.com>
 <kuvftnq5cjwtzh557umohu7afvndg3tl4lx6qfjjuwd675phk3@y5iaypkzdsz6>
 <9d6b3b9c-c9df-4fcd-bf2e-6a5635171bcd@linux.ibm.com>
 <htfujjbga5xvlmlkv46lncbutqr5b63kvylveewoiqmsern4qz@m7ulmfr3tjp3>
 <95a64c51-2a3a-41e3-9c9d-454ec2c04e9d@linux.ibm.com>
In-Reply-To: <95a64c51-2a3a-41e3-9c9d-454ec2c04e9d@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA6PR04MB9374:EE_
x-ms-office365-filtering-correlation-id: c9dbe3b8-8710-4a92-dee3-08dd15929b90
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?URT36KNg3HNYsPN0VEdvCzPMgHIPucoqB5zBQ59IfSqalmNFpBKUB3yRNACy?=
 =?us-ascii?Q?G9ulm4nEPbEsf4zktL+I4CJdFtkV3yihFSIxHkKR5ag6t9fMEKfZcNphD30d?=
 =?us-ascii?Q?OEp93A/IG4MBMagqxO5nt4Ly9IQ/VjoC4Rrwg0iqqMF20eg1vcNpYOSxwzo1?=
 =?us-ascii?Q?oe4f8uYaLmwCtth6+QiaLvHsABJKC98IQDvy7y7g3sH9LPQLqPsRTpond4iC?=
 =?us-ascii?Q?v2Zhlb/xcvy2ImKxXUxjZ3N+7Kpie0O/mCJl2KQaMyh5Dxn5Txwqakpnjs2T?=
 =?us-ascii?Q?QRvVqzyXs5TdpQhegYFLfDFJX75eDW6eV/EmJFmsncxuKzMMMLJM69p9EGrx?=
 =?us-ascii?Q?hWr3IQ0dGDSQkK37FAawItA33o7vLu93Tp+ZStWfuLRazkenuKmOPjaF7cKQ?=
 =?us-ascii?Q?KaNu5qlJti7cLGPZONHs1xL0hJUpPIDchFUOWaAjPHBMu/mvQDYXVk0YypLw?=
 =?us-ascii?Q?tA5xIhCTn1IxA1Y6wCjxXzHAxGOGpcKXX7lOeP4GhpJ2wmRkfFYPi4rYjHyy?=
 =?us-ascii?Q?2A42AWBwi5tyvqaWkSXBO5unRe6acRDyi1nSQB9XiC1EG0xEoBN94Tm4jyA6?=
 =?us-ascii?Q?MShaVYo/BPVM2zswdjidSHDC0Qvh+io2AND/BgdRO6xzWZKmB+4TliQWMTyG?=
 =?us-ascii?Q?UAqkB3702KY24IETDtTS7xngm9A4XcxtO8X8jIS7ywJ4FaHNmPjJKicFt8Y9?=
 =?us-ascii?Q?CVo6y6BLlaE0piiV6mW6ZFsKzxNti55+vStHXPb5RcR0Sq4CHvuU2y6p8MbI?=
 =?us-ascii?Q?WVtL6+rj5B2C460dqZTe/YUaT2DHyT2DhUoLD6P2aS4CfDc3KruZE1zbtkF6?=
 =?us-ascii?Q?/ZxlW9Ko4w4s6D17efjjXXsCMoAUzYa2u17w5H4Fa6U7EgmGW4t5KcGkNSk1?=
 =?us-ascii?Q?iSEEylZyE3c5DswxKxDujgOgHNw9mPbOXmxrenPzsEubgkxabtH/83fcAcGM?=
 =?us-ascii?Q?P/9KtkK3iZ9AhA8PGCDl3FTBWABopZq2JRSGPLdnFVw2rZYEDvn+G9wv0EhR?=
 =?us-ascii?Q?4TJPdu7EVZjU9BqwO/t7SXXRgJd1UuGeBK56THV0fkOlnu2ArF3BnmNUsHKD?=
 =?us-ascii?Q?cMkA73LFwWXCMTuCTj7Sd4o9jvkHCZUbyjMATnArddN6oo/y/snHtaX1wyYo?=
 =?us-ascii?Q?zptTGGn3btcU//XeMkveouK0pBUiIfB3tfcH/Z4tvmGB8scU/94GDdd6IZ8N?=
 =?us-ascii?Q?JRLkDyv66P/r4TCnW9ZUiuNDQRv17ima/zdym9Dcn3XwyY4oMYdE+jaW8ZDL?=
 =?us-ascii?Q?+6QposLczFrZsfUCYDOxg168pRyQpxm6Vp1jvh2KDLcvgSGkmKDCLeey+dOd?=
 =?us-ascii?Q?9MB8vq93WVJ8ZLHEF9gyALfHOG4+jgtSrk7gy1jof6nRHhQLfkJH177TcKaA?=
 =?us-ascii?Q?x1hojWHqb77crqhHzcDIr0KSVXcHGCSoBtUhDiRl5xA0p298pf06T3fwTYYD?=
 =?us-ascii?Q?PZOFW6Rdjx0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Z5BaF3+WkB6BYONzHDXUcd4g2myGK/U/Reu3yuV9blbMd70t+Ac0MKlg/P3?=
 =?us-ascii?Q?73fXYc49o07R2y2Y/66nUyEfn+qjq0adV7abwmvUzzg0Ab+0L4Tp50+F/boc?=
 =?us-ascii?Q?vSLEpjoTYk50HIR9xQI2TWiRz90e4Idi6Fm9j6YPOyLrSC594oS3gSMn52WZ?=
 =?us-ascii?Q?ghI4/+TRc6G1ksXEWW0X4nTC3JUGGMkFvvO/LQZUaPVLBTBsR78rhc7mKx71?=
 =?us-ascii?Q?kkmsjHRhDks4uacVoae65JrxjkYKvOo3PmRTiKJrqg94wFVVfvOxhSTMBvIS?=
 =?us-ascii?Q?wDcAWjR7vFe7rFnPwPKPIKoZ5clV4BjHSCbQLMUF7b/R21QmMhK/bWyQwNcU?=
 =?us-ascii?Q?a7289th9Felwl+vzW93SuwbE2ppWkvMDKs7prY8yX45tINgbY5+M41vKLGlF?=
 =?us-ascii?Q?A9pC7r0VZRQIiMB1XM7TzZSnml1DFYlgQX/eoQUo9uebayTLGyau8U9LvfTv?=
 =?us-ascii?Q?q2HXFVB4blWu5umrRGF8zr6fVSqe1UOWJ8RZhuYMh8cws4Ys+vhPs2So4Lgn?=
 =?us-ascii?Q?BjOYkmBMf0JXHQFKM2kh+8LP50jUSzoOpE7nzcpwiF8AvR10R/PZrZKZ5HUZ?=
 =?us-ascii?Q?v3IXBCwcx/EZdOf6HmEWl9R/azBQtNa6hEndTgN/H4yn9mu8vm/pUoR14gMj?=
 =?us-ascii?Q?U6OcLu/kKIbMhXmHxf+FreOLEITrE3jLfuhtZNXfJMxNHpQz2h1Sn1q1SpFa?=
 =?us-ascii?Q?2j/+Mw3LfeEhGvyz+Rm7j3Y3QWQG/kQWlLx97OwAPs1pkXhxU3EMAIWuLu1R?=
 =?us-ascii?Q?jUN18eN7QAP95HSbgpFOGjT9KyonMxb8SBw3OUARBSjBnKWOzPAStZO2XBT3?=
 =?us-ascii?Q?ZnmukEiFvmL0nsx8RxiE7VVc+MLYu9DDFugDxJv556YyadwqvTqnRMBui0mK?=
 =?us-ascii?Q?JdtMJK9RSp4uhwh8pYSoyhEfQhrixWj2z4EVtcATAmZqfKUMa6vULigJs4kU?=
 =?us-ascii?Q?7NEFbOux1II7gJJL6PXXGADSmCrJisUJOTa1kalErS5WPI3Ws6/xhRl66Spw?=
 =?us-ascii?Q?1eGIX5QiY6PAbPdtwZpULy+iwH/+/5FKYP27TdzjXU4ZEv/TiPwL6JjRkQWN?=
 =?us-ascii?Q?iJjELU537CtSJ5WAIXFCzVZkEuzLbeTBI+gI7+fXaYIRyvt3pS+n8fyDJ6i/?=
 =?us-ascii?Q?7Vx/k72MtSCJc19mXwHmPYBsz8QImPon7osedzKAxffODvKcGwwzWXbcA+bh?=
 =?us-ascii?Q?TfFBMLez1VQG8psM4r95DlBl2VszoT69f0R+OXQIwcAPaa3IqXyfJedI7+RA?=
 =?us-ascii?Q?8dQdQK1jPXqq6ewgCwvCJPowovGoNeRXS+xxQRseqBc42k5Lrd4Yfz+RtSAi?=
 =?us-ascii?Q?/Dy12GF37HlIVbAtAjUhj6krXU661D4smWZsC3752G3Vc2hNGuF4yVOk4GNJ?=
 =?us-ascii?Q?nM7dl9YKLb5mh53cskXENOqmBeLVkOopsYCAfSFra0o8E7w/eo1Zbo/OjzPC?=
 =?us-ascii?Q?yOSr53V16e8JWyCsoOH2q6AXUOmBtqVaE9x47TONpJefPXBi28B6sMklXotZ?=
 =?us-ascii?Q?BRZuqPbtMe9/I2dpg3F17h1bM1g9ukEu6HPrwHREbGsrIQG+I9op+zc0kuYF?=
 =?us-ascii?Q?aOI+E/qRwOCZNGkl1JCs1Zxu3M0hwCzdRZgOCuph49bzWmL7QsAYP1gcUxjQ?=
 =?us-ascii?Q?X6oTtQd2EbnABM9fGt9oXW0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F78595EAB0E8BC42819F3BDFDF2C81D2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wXLTg6P8uZfqoQqWiF1PUQDO85T5F8ARheTXtXwCqPj23qfYwH21HqIsvr/p9AE2SqxzgfdzrXvrDs5OcYz3lxxEtKdityea/1gLeHhm1cJ3dvwpryJ09NSHvXC0KYuoM6bpJUTc+DT8LKq20i8TVz0256RM/qstsWnoTp3z3mgypTRuAzz5cZdM3uk/liHV32f4gF3keXrH7AOKlSWD/SD8Bam63vsp7QApaRqw2CXDqG/owFd0pIO74GhwwM9I9hIuk2Clu318I23dfQ4bFwzcDZNHT4owrMlcNivVhx5+bFkqvuZBIk4OSDxsPar0APaNblAzKKVVjJ6eCoEvMk3lMtxROt8Qf34+3aXbvYzmXFaKhKBeY/X9IyTSKIVZEo7ujdMw03ew6oeAyphv95fTKwJS3/lKWvuk9FLrSYYeM1ir52+h4j5kIQCgltCVUYz4lGZKkQWqxl1kQoobZt3mhbL5a2tUljx5cC3j/AxCW2Dw1EpvQviJ5ZDyvCuax7WeP2wSN8TH32PUMu7mZjCiJ1vZyt+D7kAqFqnUVuTRMhidyPGWcdsUV0lRDra7cyC3siLWXJOdg085IxVJAhUgy9oHXcFG+qG+nCd+NhxRvHPuLFAVJ4d/tK9MsL1a
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9dbe3b8-8710-4a92-dee3-08dd15929b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 01:09:17.5647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lpMbvle+kkYC4nv0icVQOtAChbCoN8T3Ize7CIrEx0RDp5PmYECwS9m9R++jR2LpUfrSbZQQEjAyVml6wo5McDKWvi+3US3f2viNT1CmIvM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9374
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_170928_412681_065AFC3D 
X-CRM114-Status: GOOD (  30.34  )
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

On Dec 03, 2024 / 14:35, Nilay Shroff wrote:
>=20
>=20
> On 12/3/24 13:56, Shinichiro Kawasaki wrote:
> > CC: Jirong,
> >=20
> > On Dec 03, 2024 / 11:08, Nilay Shroff wrote:
> >>
> >>
> >> On 11/30/24 14:40, Shinichiro Kawasaki wrote:
> >>> On Nov 29, 2024 / 13:31, Nilay Shroff wrote:
> >>>> Hi,
> >>>>
> >>>> There're two patches in this series. The first patch is a preparatio=
n patch=20
> >>>> for reusing a common function nvmf_wait_for_ns from multiple nvme te=
st scripts.=20
> >>>> The second patch adds a new nvme regression[1] test for commit 50536=
3957fad=20
> >>>> ("nvmet: fix nvme status code when namespace is disabled").
> >>>
> >>> Hi Nilay, thank your very much for the fix actions. Much appreciated.
> >>>
> >>> I tried these blktests patches with the kernel just before the commit
> >>> 505363957fad, at the git hash 6825bdde4434. I expected the new test c=
ase fails,
> >>> but it passes. I increased the number of iterations from 10 to 100, b=
ut it still
> >>> passes. Do you observe the test case failure on your test systems?
> >> If you ran blktests at git hash 6825bdde4434 then that doesn't include=
 ns changes=20
> >> which uses mutex_lock. So it's expected that the test wouldn't fail. D=
id you try
> >> running test using latest upstream kernel or checking out tree at comm=
it=20
> >> 505363957fad ("nvmet: fix nvme status code when namespace is disabled"=
)?
> >=20
> > Yes, I see the test case creates "BUG: sleeping function called from in=
valid
> > context". Now I see that you added this new test case nvme/055 to recre=
ate the
> > BUG. However, I observed the BUG at the first place with nvme/052, whic=
h can be
> > used to confirm the BUG fixed. So it does not look so meaningful to add=
 the new
> > test case.
> >=20
> > I think my report "blktests failures with v6.12 kernel [X]" confused yo=
u. I
> > wrote "It is desired to have a better fix and the test case to confirm =
it.", but
> > I should have wrote "It is desired to have a better fix and the test ca=
se to
> > confirm that the fix does not break the intent of the trigger commit
> > 505363957fad." Please find the discussion about how to test the fix pat=
ch [Y].
> > The question was: how to "confirm that the commit 505363957fad achieves=
 its
> > purpose" ?.
> >=20
> > [X] https://lore.kernel.org/linux-block/6crydkodszx5vq4ieox3jjpwkxtu7mh=
bohypy24awlo5w7f4k6@to3dcng24rd4/
> > [Y] https://lore.kernel.org/linux-nvme/20241023052042.GB1341@lst.de/
> >=20
> Yeah I read that explanation and I also saw in another discussion[Z] you =
mentioned,=20
> it's udev daemon manifesting this kernel BUG. So my initial thought was t=
hat relying
> on udev to recreate a bug may not be good idea because udev rules could c=
hange without=20
> out control and those rules could be different from one distro to another=
..=20
>=20
> Hence I thought about writing a test case so that we could reliably recre=
ate this BUG
> without any external dependency...
>=20
> [Z] https://lore.kernel.org/linux-nvme/tqcy3sveity7p56v7ywp7ssyviwcb3w462=
3cnxj3knoobfcanq@yxgt2mjkbkam/

Now I see your motivation to add this test case. I suggest to add this
background to the test case block comment, something like,

 ... The regression was found with nvme/052, which depends on udev rules.
 This test case catches the failure regardless of udev rule settings.=


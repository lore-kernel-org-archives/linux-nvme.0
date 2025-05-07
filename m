Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEE9C3ABC0
	for <linux-nvme@archiver.kernel.org>; Wed,  7 May 2025 22:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qrOm8sHwUBPgiFD63VKmRMDIIYZx4XQhF9fBGKsjTR0=; b=gVWZRWat85dXPyxIq5erJf/fOS
	ds4T0tw+pAd3USfEfTK9U01ILOOysmuloUQ/2MvzF31ORtKUak1mZSAkNc+ztUd5vpD6cFDnqyog2
	zUfENX+JML7UBBjFAU0RJLVNQB8Y7/3pbZPF9APSn1sP4yF+eqyMYxooQE1u/veFPEmsgXfkIOSy/
	XUu2eIh3m31L26j7XAY9ib0R1YHdyRuuTYkTd0akeTXRk41GTwjLOHEtRWCqnChP8b0m1uvUYRlj/
	Zrv8q/bDbfTcz1Q5Ka/M392ngtQU7XITN0x0V1WeAKKcyOmmkHpm59U9jhvhfY8paCAg6ntcRqYIJ
	tLYf64Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCnDf-0000000GsWM-09Rj;
	Wed, 07 May 2025 22:26:27 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uCnDc-0000000GsVh-33zF
	for linux-nvme@lists.infradead.org;
	Wed, 07 May 2025 22:26:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1746656784; x=1778192784;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sREA+8WGuch8xrRIkL9RSTpOAcgB2Hq7xXkf/NIhzI4=;
  b=gGkrmaknq0PeI1S9OyuhLkL79Xas5dmsj2OMo9lJZcQA/Lf0N5Tguzeh
   4BvVwW/qCQbwXJXjtxHCDPr2sUKtWPUkpkRg+v/O2gvCK0dTYen+OAmM0
   5UmHZuFwS3xubrpKOgIg7XwIT2GV7y1k5m0LtHw2qC6qPBXKAXTXZ7psS
   TfrhwN5zL/dM+Wm0rCl9WvvWYVPy89qx94PfwhQl7YKiXDDbk8IXv3Nq8
   xauHwwbCaguSL6DUQyjUDSUKxBpA+UpbbqfsmNTAINU7KIArXoSBx8DjO
   h2XKnqmbN9a0QmXiP3ymO3AHSY/aAarax3c7x0ICAGTuMBGTbf/rjmlt9
   Q==;
X-CSE-ConnectionGUID: P4KZXMMcRgiksBe+Ecf71g==
X-CSE-MsgGUID: 7DTY0Xj6RQ6QmF/NyMqc6A==
X-IronPort-AV: E=Sophos;i="6.15,270,1739808000"; 
   d="scan'208";a="81500879"
Received: from mail-centralusazlp17010000.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.0])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2025 06:26:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaO1bQ6iY6Cq7PXTWVkOy52pMXP+a9LzRhL4/iJ8dGhe20o5emi9ZkfLdlzdVrR4XxovJ8UaTCdIsbryGlNRQJKVUg2q+1Xv2MzRwJHkXoTcGEAONmSMsxvIG2bdfqipLxmMOvNZ3CaXAfN+SUNgtH3X/lrzYTphUFT+EFi/FO/jeFqXyVdOaKgvLZGTPHSmsYweqsMQ31hWHeUWVPXoWp+jBaLVi+jf2ns50u686f5CLLedmLsCPXOw9j4ADTQe+wBr6Ook721PpcoQcvNfYWc8RajrhDk0czF29NQEc4Xk9BD4LkoAemRJ9jPFVgGtFYcXdDT7wUWR/CPnFBVVBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrOm8sHwUBPgiFD63VKmRMDIIYZx4XQhF9fBGKsjTR0=;
 b=PN2wKl4YZMiAr7UCwXEdmyIakM500K81mIEQGJPBKAJ7IxaGFRRnGQk6p+1A++KCZf9MCOMQHjal+uUo70PpGGEvoB035yKfDeAOP7nWixdxUfK/uDzOnMrrKXtX9Dh3tdaamD4FzjQSjyKM3pFw8zEQJBSHFBF45vpOpvv9EYV3rz1vylGj1fB4+joquqlTIKoVrJsw8D6LntZlLAlS1lVSiX/lRiozQ98AV48EvocETdskYCpbpGmHRqDNUQiFwpdWxSRu0l3qtLTMH8mt0O4fVaXi1n0z8DC1ouJ4ZWmtrgofj5pRldjhVFrnuvKX1hbwbXAGsQ8kSCBEb5csjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrOm8sHwUBPgiFD63VKmRMDIIYZx4XQhF9fBGKsjTR0=;
 b=nLHyavuaFT6EGRPG9J5c/Fy964Zg3bx5vq9REJPpkOoQ46Jetp2schV1zUXEPMz3uDnO+7uqYldLU19D61veDgrT+qaeWMb7Bw6RblmHnjHST1N8Ow4DIf55YiAiHo6TxEMbvnVXCY3WobGEbwr8AlAw0XprZ/eo7BLpikBY1Js=
Received: from BY5PR04MB6849.namprd04.prod.outlook.com (2603:10b6:a03:228::17)
 by PH7PR04MB8556.namprd04.prod.outlook.com (2603:10b6:510:2b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Wed, 7 May
 2025 22:26:19 +0000
Received: from BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320]) by BY5PR04MB6849.namprd04.prod.outlook.com
 ([fe80::b2a6:2bbf:ed0a:7320%4]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 22:26:19 +0000
From: Kamaljit Singh <Kamaljit.Singh1@wdc.com>
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>, Hannes
 Reinecke <hare@kernel.org>, hch <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Chris Leech <cleech@redhat.com>
Subject: Re: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Topic: [PATCH 3/3] nvme-tcp: fix I/O stalls on congested sockets
Thread-Index: AQHbpGZdo3Xoo5WOcUmvA6U4U0rVxbOkYTuAgADyiwCAAK1uAIAA7l0AgAvfEACAAkIngIAAA8GAgAAZ552AAkkWAIAOmdwmgAAIp4CAAc92qg==
Date: Wed, 7 May 2025 22:26:19 +0000
Message-ID: <BY5PR04MB6849463BE09E64B198950B74BC88A@BY5PR04MB6849.namprd04.prod.outlook.com>
References: <20250403065522.90807-1-hare@kernel.org>
 <20250403065522.90807-4-hare@kernel.org>
 <1edc23f5-eb48-4006-a2f4-d303b05bd3e0@suse.de>
 <e7371b8a-e0b3-4387-a941-292e1f46b2aa@grimberg.me>
 <5446ef17-d922-4467-9a3c-5001713cc260@suse.de>
 <dac1d594-cf64-41ce-8a23-4b246db75b83@grimberg.me>
 <eda7a691-037b-442d-bd36-a31f93e95cb1@suse.de>
 <976af4b7-578b-4e47-a2ff-7c74af0b9afa@grimberg.me>
 <30b16579-1a28-4d01-9afd-8ff3996db42d@grimberg.me>
 <BY5PR04MB68490F6DD7F1FDBE6999B54BBC842@BY5PR04MB6849.namprd04.prod.outlook.com>
 <6202ffd4-4a32-4f85-ab87-ac5a087c2f1a@grimberg.me>
 <BY5PR04MB6849D4BF87755B82A073BBDABC89A@BY5PR04MB6849.namprd04.prod.outlook.com>
 <4cff2b68-32e8-4593-8a91-345171ae147f@suse.de>
In-Reply-To: <4cff2b68-32e8-4593-8a91-345171ae147f@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR04MB6849:EE_|PH7PR04MB8556:EE_
x-ms-office365-filtering-correlation-id: 7e7cada1-aa50-4252-8f5b-08dd8db630a4
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?q+RKc9jyRJZx0uD+3eMG1Hfa0m3b6fD/4WTNGVm7nJaCOCninicvj3jUdO?=
 =?iso-8859-1?Q?5RvAMYUrnf4hoMIjGblufxlaWcTTnPpZI3R8Y69HiRZBtUCib5/qz1pM0c?=
 =?iso-8859-1?Q?yUvPBzeP6M55mCsBxn36ZxfiHCBeYvDMc5u9KVVjAHcthET5Edrf8mOAJ3?=
 =?iso-8859-1?Q?phhcVaXEePmFSGLUfio6+FiOMPAgnpsUE3P0+Kzk95ShlCnyjFTRY4moJy?=
 =?iso-8859-1?Q?VH58MK+GPDts57sLcNZA14hlTKDWgRcCc6OK7Joou5CYPXuLpYmOKgWYoe?=
 =?iso-8859-1?Q?Kk4iEJRsYC99eN3U5gZyvzyW+N1WthBMZZmKMN9x+kNXHLxWwDQX/lBP1C?=
 =?iso-8859-1?Q?hCGqRauCG3sx90yDJeHFJgf7Hdl8vctraMsLSqUVWf44uXFmP5OouCnke7?=
 =?iso-8859-1?Q?6fvnmjN4V4emRyDq2IBjhcPleozlnvwkOVLzv131mgqgEogKRjsC7UpONx?=
 =?iso-8859-1?Q?k4EokSHKG8TOLw3Uc7i3qbdNgHxrNmBKGQFtsejAcN2zm2yEGQRLnjj5jy?=
 =?iso-8859-1?Q?z88aX7OsPzXrLm8rSz7hMZQL7c2YE255hEjuXTNrwPz0oeqrS3/zocKu0n?=
 =?iso-8859-1?Q?VCfWkV4k86nyjEAgtVLutKtaHuDgWg4hPfPDEeYBNapYWwok5e3Vk7QC44?=
 =?iso-8859-1?Q?obRwZcnruIxjbI0ijnUFgiWriWOJh6xEveteEfUIsec2QdXWu9VMVl5lf3?=
 =?iso-8859-1?Q?pQKbzZLVu4lRnDBJhj3IFpBXnP6HrUZsjDUhAyme9E1lovIRMq7FjirkhI?=
 =?iso-8859-1?Q?82r4nD3YWMwvz9EITZS+ANl2AwuLHU38z3pEOs4cglooJTtW6XHO8RdMjU?=
 =?iso-8859-1?Q?r7RxfVkJIjIAgArPJlWXc8NRy9uB0eSZsin3Zp2s0UK93Ayg+Az1aE301l?=
 =?iso-8859-1?Q?J84uv9AgKYMgqS4q+u0GREEeIgWp6Sa28YiKxbqA/e3BTzr5PTvbNspK2H?=
 =?iso-8859-1?Q?pQ0gKBrmcvud60vSRXIQ6yqe8ZNXaXdwNBe9oYUOfKryCUC+WJb0BjvqMb?=
 =?iso-8859-1?Q?2cJ1bLD9NmI4XHBdZxEZdiErkn2iZNZUW34rGqT7B/BFA6X8pEm+4BuooP?=
 =?iso-8859-1?Q?U7X8SYC+O4URgWixG7R60sgGMzdHUcXb+x3kwYyPp+8sr0ar+Y7H4gP9O6?=
 =?iso-8859-1?Q?75oelCOo0Zbt5b3t/8gcwW0q8DkdVFEiVq4IlesSolvxX6ma3/URS4dR1r?=
 =?iso-8859-1?Q?sIGA/nyFaN3KEGwzYqcahUcXCm9/xcdr258JJofkCBB/mHXYO9UlXRnCs5?=
 =?iso-8859-1?Q?uCLF9rL5veCcbrS5gy6dQLEn92UxZY0ZU3d0qtqLdPoDKbCT9W4UZqPASi?=
 =?iso-8859-1?Q?fnq4STdxNKefXyPRLO80ehMumMyRJMhttdG0dmnhQPjS4pkDs3F1D1NL3W?=
 =?iso-8859-1?Q?48n6m6Js3oBxqf/VKFRKa+dxZoady64Ew+FRhE2eOsdEHTkx6f/2u5M5Cx?=
 =?iso-8859-1?Q?81djyG21WcnjTZ59LGitEZMnHgTrZP9rLD80gHAh5r/GCw8mByyJa3hA8d?=
 =?iso-8859-1?Q?piGGEBgGUo9AW992llxZgf2ZhpBZSj3Pr2kUyvlAo/Ur8OyW1OL48Bome/?=
 =?iso-8859-1?Q?ssmbxfg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6849.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HL+nKwFBxWgG9KxYCxjQAbJbySmcP4noM9sgWdLlsCllknC0TYLh9w16Dq?=
 =?iso-8859-1?Q?Nle3sHhgNoR/xw99mf4m09U45nXZmsFvnQ2awfOvO35BPTPX4d2hzDVjIv?=
 =?iso-8859-1?Q?yamfMwHzL9Bwg14n9aRlobEGcKJcUlaz8o6w79obz5d5SWlCWGTYJ8P2qp?=
 =?iso-8859-1?Q?ibhJU9+MEjkSguXjEpUZ+BDwxZL0haLQzIcUEMnb37lhFm+5OcpDwtpWwI?=
 =?iso-8859-1?Q?MWEFRgK0ICN3sUImWbz7132D6FKOrbG/87VX97uYxny2Y/mXFLwgHLGkvm?=
 =?iso-8859-1?Q?himQkE+ct7SKhUAZlbV1qEF+tmdNV9GJIsklFVlxNU5ANQnFAZ0duS0GvJ?=
 =?iso-8859-1?Q?AvfHQi0+ZVcmDrgtXh99yHYXOK4fOUEXmN8+hv8vpyDVkP0w4MD8/bdMTg?=
 =?iso-8859-1?Q?deuMxca5go1W6w56qvp8hpPkE621/tCaE7nXY4dyR6UZenLzazRZiS4Emm?=
 =?iso-8859-1?Q?tbuTqEvpyyivYSx2NZs0zuFGRmBwbSsGwr3iZZjZE+gV6O6c0u3Zo6jjbm?=
 =?iso-8859-1?Q?LNheruHpV+CLcAj1RQqJO+E2T8lgLEqsXI8RaX7rF/tjl4Tn+srvXYLv46?=
 =?iso-8859-1?Q?XOJJ2JVDTsAAbex8B4nfVqC7YzCvyur9U2QzTrAouLweKTJl+SMyClB57K?=
 =?iso-8859-1?Q?rtgt/KLmqkqZ9CqABvX7cVCajdsQKqZuReRDM7KHgJgqVlTXCEwM2nVh1E?=
 =?iso-8859-1?Q?rziBnxOPJd3MR45YFYC2Ab/2dNeyk53xMdCc1A19eucRlWort3WAXfTCgF?=
 =?iso-8859-1?Q?2XnKoype4z7W2SAPq3HLiqC4NsAteRXwt2VJc7UFU0YBPbASNEvRKS/9Vi?=
 =?iso-8859-1?Q?PHOq0BtBmIl6sgzHVDc2kxNjRLZk2jEpCWQ+OUXM57UTOSFjDyU7+6DFJl?=
 =?iso-8859-1?Q?7fncEaOwPsNetnllT/9rf5RcLrNDm7T4xI9VshRyZ9UQIOqpsnup2E6Yrx?=
 =?iso-8859-1?Q?v8e+jyfG38H/cRpwOpN2ZeetbM5Rq4084l876XQnhYWMtCM514L/HyLIq3?=
 =?iso-8859-1?Q?n1mUHQeMyqdy7phUwet1e8F0HG941yTK9LZ1TZ8Zli1Id9xSstdbkE/IcE?=
 =?iso-8859-1?Q?OQsZaIdJVpz4OPc5yIHzv20BnW74/lNhKEHfrLZRTPw/MyoJ4Q2hXWI/d9?=
 =?iso-8859-1?Q?SPBh/warHBfB0T/yOFsKOZNimLBRbV9R4MvVCaUcsXNgMtIiXV4zomm+Fd?=
 =?iso-8859-1?Q?buTrZxZpsEnxtTtdJvU8EV9bD5OeyaU3Nt9fpAIZA/50VNOP+k0V5LQiUa?=
 =?iso-8859-1?Q?ekiox3k8kHxqra4mdXpd8dsGq1DZX0wqlVXNh6T0Wn1KDYsZ0dz1Uj4nJ7?=
 =?iso-8859-1?Q?84YEtKNfI/8X2eTNFXgkuPCgaI5LyEKeDz8EdvPG/xuPiB3XP2vx8D0AGf?=
 =?iso-8859-1?Q?5lPKuAC96A8ryzRxp5KTwezx95FCY6vlcpd6z1TyZDt2eIUChUJ6ojn8Fb?=
 =?iso-8859-1?Q?bAGIUbTbIy0s8Z1X33HZCPc8+gwlBG72AwFveu1vNiTn/Gz834Iy5FL7Wm?=
 =?iso-8859-1?Q?Vsx4+wK8x8zEpiGCKxAPo3mP9QW+BLVjd6bBoYbvz9BY6YOkvVxu8+/A9h?=
 =?iso-8859-1?Q?magP55QO9XR1t27up/PJltTkDs0mT2Pd9FGzay61SYoxx/PXSsFY5q7vcs?=
 =?iso-8859-1?Q?RGhccT3CaOL3Kr/w++853tMr0hygw46I8B?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +HZf0O11e6XzdI824iveMv0AHNbqFtBSP0Ws2Dkkzjub5LVRCnhVoRSluANMXf5xlUhmtOpX83SD8b1t5FtUDNV4aIXZ6gb5y4LeJq/Hk6zYOHJCOASepMeMH7OkzQRuLFRGqAGVoCrMt7MtN0wRU03eQih40A3WGjH3PVZ8ELzlG9/aIawqujxNDcJU0PpTZJvAhNXucpTeF+G2c+kqwFRkke6GFFsAf5TgMyaLEe4qQEm687Boug8JCWhZIXukEizCiov8RxqVjtjyVu7cqsQy11ck2S5xx54XExavv4osbQqtfkAs2DjVDXkOLdMt0XIer+K0sXfc02fFpq+A5TFtG94q8Z5uSk+wiKuQIeHz7Q9TD7XXL7+CBosmRwNLnwi9wTbAA47IWR8GiYLcy0ogib1zhVf5orisqm5ZDzPyd4gfr96AkmQ04vPOL6hL3YiiQ9VkBkvafM88YeBBCw884Cag83O4heJjwSTuXZGKACMvOvYd+irxNPhZzNbncTlnLbnvF3rJhPfB1D+uCmy2sv5avk5PHQVZA78/P6pqWK1bEX9PogYA/1hl0+jbpHtu/5yrpro1dRO3LmmSqAV/GEKxPthTSkKMQf5tg/chexP8dTdZvhUIPZDWi1LD
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR04MB6849.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e7cada1-aa50-4252-8f5b-08dd8db630a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2025 22:26:19.5845
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X5LXiXyonc6ZW28SJQiam8yI/E+hbvXRiSGAcv9+QInxdOS9LZSe05LWcLXhtaiZhoUMDcyyoLsad9ipTO3TYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8556
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250507_152624_865042_465FE9C5 
X-CRM114-Status: UNSURE (   9.78  )
X-CRM114-Notice: Please train this message.
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

Hi Hannes,=0A=
=0A=
On 5/6/25 11:05, Hannes Reinecke wrote:=0A=
=0A=
>Can you please retest with the patchset '[PATCHv5 0/2] nvme-tcp: fixup=0A=
>I/O stall on congested sockets' _only_ ?=0A=
>(on top of nvme-6.16 latest, of course).=0A=
>I think I _should_ have included all the suggestions floating here,=0A=
>but we need to have confirmation.=0A=
=0A=
I've built the kernel against the latest of nvme-6.16 branch along with=0A=
these patches. Its with test now. Will let you know when we get some=0A=
results back.=0A=
=0A=
0. [PATCHv5 0/2] nvme-tcp: fixup I/O stall on congested sockets - Apr 29, 0=
1:18=0A=
    Hannes Reinecke (2):=0A=
      nvme-tcp: sanitize request list handling=0A=
      nvme-tcp: fix I/O stalls on congested sockets=0A=
=0A=
1. [PATCH 1/2] nvme-tcp: sanitize request list handling - Apr 29, 02:31=0A=
2. [PATCH 2/2] nvme-tcp: fix I/O stalls on congested sockets - Apr 29, 01:1=
8=0A=
=0A=
Meanwhile, quick question, is there a known issue in cloning from this=0A=
repo? I'm seeing super slow response, which eventually timesout. Had to=0A=
try multiple times over several hours.=0A=
=0A=
$ git clone git://git.infradead.org/nvme.git =A0linux-nvme-6.16=0A=
=A0 =A0 Cloning into 'linux-nvme-6.16'...=0A=
=A0 =A0 remote: Enumerating objects: 10795230, done.=0A=
=A0 =A0 remote: Counting objects: 100% (333577/333577), done.=0A=
=A0 =A0 remote: Compressing objects: 100% (99866/99866), done.=0A=
=A0 =A0 fatal: read error: Operation timed out 76.01 KiB | 1024 bytes/s=0A=
=A0 =A0 fatal: early EOF=0A=
=A0 =A0 fatal: fetch-pack: invalid index-pack output=0A=
=0A=
=0A=
Even a git pull --rebase into an older clone was failing to refresh=0A=
remotes & show the nvme-6.16 branch.=0A=
=0A=
Thanks,=0A=
Kamaljit Singh=


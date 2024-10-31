Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A28BE68958
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 07:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wz8Bho+ah5I7dqGEG7G/zjbsV5lu2VG3/XUzFPGzvbI=; b=KQeJwL4psbmPn/uqDWwaEjhpFq
	YC8C2Gv3xwxWIWYMvLxkocZHGQpuNMkHej6kWGwLE3set6CEuyAleox1P2wSOUpUDZ5+5kD2hP/BD
	K6qNcvWnLkxi/3QjZrhfncoK4qGxweUhGP7704w5Icl2AG3118RcyR8UCkmxwhrdZH5KERkdqmesv
	E7EimR+b+0Helbi1M+RRJaiez/qaffzRrC0cPnDarvXPdRSQqw4rklNnQDKcgfZwMg0VtuYBJTM9J
	zo7+4J/oQxqU9fI6kaWNHNLXjZd+u/OqcFG3DBLjKQ3DB8vBlQd1DSj5ON5+DtlDCyZ5tsOsByekV
	7DN+z+WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Q0Q-00000002rVl-2Xrt;
	Thu, 31 Oct 2024 07:54:10 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Q0N-00000002rV3-18nY
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 07:54:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730361246; x=1761897246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OFmbPgfChL59ehsz45DUKR1sDMv674IQfAuNYzPUK+4=;
  b=ReBls0r5eFFqEnh3tIdYn+Z6H7Hq6tgWpyuBids16KbB2nUJuo0bD8dx
   wjwDEk65pcMr1Zjl2aL/If448928f077N/73tPP7QR/BEVzf6ksfekdAa
   J3RbetsFoU1sLmY744aZG85sK/rmEkcvp0LNGBOdShd5ZQF7KkGHyY6sc
   K3K4ZsopZlvZW7gDXPFpFZMyDbGObxTTOxdXJ3KgjkxIrP9oOUQ6hx/Th
   MTvHbiUnkHuCk/fWWbiiGwu/Y2oIaw+ybxbxkGDn8okfei6h/trVVQ3VT
   IXUrFrGm60SLuxymp6wP559ilhU8bhqC2VxeELgJgVYEoleZfX0V0FBOh
   g==;
X-CSE-ConnectionGUID: spccUDVvSK+hq/52xZwK0Q==
X-CSE-MsgGUID: 0bwcRRz9QiWq0LgvlHCpuw==
X-IronPort-AV: E=Sophos;i="6.11,247,1725292800"; 
   d="scan'208";a="31308377"
Received: from mail-eastusazlp17011001.outbound.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.4.1])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2024 15:54:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKHye4Ifp90W0pzFhDH9D/inHuqSdoySXkwHXTZLA5IBbpMFDqGOBciMOQdbkI8xON8gGWvf+fY5GQibuz/hYd5XmeuV7IxGJnnbRlEWpfoNldPVtxHnRtPCLnoEek4VbXR2HnOcwAX1waKUJKh7KC9B0IE7Zhojeg899vTop7GRJLGcp+dYFN5glLH7fompTqYT1SLHwE3Vm8D+3iL7Pw9g8A2kLRqHVqMCZKaYbqbVm+BxyRzz6SHY4uDcE7EJ9NJCciVByj1aKDlia6KOoK418eStO58Y4Mfe5w3qPGDOKVqvXsq+JJvs7Ft8NLoyFtlQUphl/ONIp1SmHKbZbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wz8Bho+ah5I7dqGEG7G/zjbsV5lu2VG3/XUzFPGzvbI=;
 b=iLdYZO4+CZxDI2kt8vo3vr9QEFeMoZBX1i8uDKlaSv2UH0+8pQBaFlhxa3TLZN8FIil7uircX1SWOsDCDUCcQVOFAgm0tNjvhSBTBGRPbz91PO3BqyjAATsEvvGNgKtiLsXPIPsgM4j7A5L5Rjzrv4kDjJBy3cC72Du7KbZ6dbJQ6v6LNUwdWUm+WA3YGzdFobtVN82IeAnHo8E4sGXfu1ZyNM3/avVNj7u38hNT+9k9ioyITY2JsjWeAJ1PUG2TziAAXAMfz1NdffHFplDlMQkhZbp3KTUa62LHimnBZyhz9JOacaw5wu/uz5g74lqz8l+2MjylRX9IXolc2T7cnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wz8Bho+ah5I7dqGEG7G/zjbsV5lu2VG3/XUzFPGzvbI=;
 b=Ga87HakMpT/qrdqRjqpFidDwBTK8OBitkr9myXBRLcpZ7Jxgjb0zA9lvN/0s4VaLZIiQH0EDoBTpIbpS//TlOs8AKqCMUJ3Ls4wUiqCDg80zngWh1QwJQbjPKRFCdL0Qc0B9Pvu6iaMb94plprpwibF1lm83W9Ka/tpiiEa7lZw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6521.namprd04.prod.outlook.com (2603:10b6:610:68::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.23; Thu, 31 Oct 2024 07:54:01 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 07:54:01 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Guixin Liu <kanie@linux.alibaba.com>
CC: "dwagner@suse.de" <dwagner@suse.de>, "chaitanyak@nvidia.com"
	<chaitanyak@nvidia.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests v2] nvme/{common/nvme, 051, 052}: introduce
 def_nsid
Thread-Topic: [PATCH blktests v2] nvme/{common/nvme, 051, 052}: introduce
 def_nsid
Thread-Index: AQHbKz2RTu/03PfNgkyjgL6OMPb1BrKgfZwA
Date: Thu, 31 Oct 2024 07:54:01 +0000
Message-ID: <mb3o3dkfgvq7etpplvq6cvcbbkhmvvnmge4omxu7nqzihgzwdt@rbytctuhijw3>
References: <20241031023521.36012-1-kanie@linux.alibaba.com>
In-Reply-To: <20241031023521.36012-1-kanie@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH2PR04MB6521:EE_
x-ms-office365-filtering-correlation-id: dc6881c3-c8df-4c6b-a6ac-08dcf9812f01
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?hrNkVS1WlvbP6MzA77NxYUHbfGBs37EPxwdQF71wJoJ51OTC9zGjRCqPvC2x?=
 =?us-ascii?Q?RyLVxnaJwAreaExhJsPF/1GJ29nex82YgsougzjFTSBjxY/revXJItlJF7T3?=
 =?us-ascii?Q?CcIRqEsldovYPdd+eL0zQsiq3lp/Vpsmi38L9MWqtuvTIwjUXNY/1IY2GeU6?=
 =?us-ascii?Q?/dfWjpYrSv89IU9FSIaR2lBEkGk6KA6Cq41CcdXyi41J77L6209mJRBytZLx?=
 =?us-ascii?Q?gTJUtoF10w3Sc4Ftge77qt1RtMbxv7NxBRWi31JodcA08Gr3SLe8F6VIAHcQ?=
 =?us-ascii?Q?3alkMunYIwPCMOkRRUnbt5hvrZKNl5K/rpGCIgKbWa7HqlInWK5g4xe/vDEL?=
 =?us-ascii?Q?tB4c6ROEhIb1/bLtGx64qbvu3VZQxfDzlN2EqjKKJukuT4AZgrOmvEwNsuCf?=
 =?us-ascii?Q?VuaM+ajpDnGIQII0pStCw21a10FHpaN6v3Ap37RmtDlvJzknaD4V5VKlng8g?=
 =?us-ascii?Q?Gakht9URdbrlR8mlP0NpFp84Mu6Zf8dHbCCA/r2eA5sjyhB3B1S7DU8oXvVH?=
 =?us-ascii?Q?bwUABHzACbrgOIOpbWwPTz37KCo1Vd0cUTosfnmX01FbF/zfj2VXi5kL7G8Z?=
 =?us-ascii?Q?YiL3EXCW7Vmzw9jMJtdpsCyYltBW4fA8+jUm45OLDfmOzHhmzaEekBEelSy2?=
 =?us-ascii?Q?ZtlrktLuRkgECL6JfO4HhXj0j+K5L5rVyyz89LywkQN6y7RvBwp/rtHhzDXM?=
 =?us-ascii?Q?YZn7SaksAAr+KeQvSq0gbUKLQUftJj6/C3nqXHLEj32LpyXfN1XZUKeuIt6T?=
 =?us-ascii?Q?tRpEJyT/8gllKHn/a6X/3cZSulY8wGjX+ysML8T0Y08+eOa5l2rWbO+VE5T8?=
 =?us-ascii?Q?chAas/ju/mVkdG3gmhoWdO9tCZVzkiPNRVrSnN8VbpG6GjU2opIv67BHbOJn?=
 =?us-ascii?Q?K8jOPx/6A4xQA8Td0f72AirgQWYzHZNFCeaUYGlQJwmsH56UfXO+td6DoK7F?=
 =?us-ascii?Q?x4l12f0tPFWv4Ya7aKasFlgjipHwRPG0MatZ1iGIBjolMN/1Evshi9s4p9Ty?=
 =?us-ascii?Q?kHpol0Ft7oKDYuCs9D8EoxJwP10Nz7jPSfzmmoecJUsJBBEo0o2U3vmCXJ5f?=
 =?us-ascii?Q?iPnidTTZTGPFXg3t5L6M2On5vU5MvubWdpD5JGy4Po5xX8icwfs1VpqpkK80?=
 =?us-ascii?Q?ps5tRf3Iz37yXckWfUcAdwKl0FITpgK4+biJfd+HIK6Dx2uVOX10T3mf3p2J?=
 =?us-ascii?Q?d90J6Rx1veFBj2V4AGNuA+eKvFqmM/5/7TrRPIr5fUhax0AihFY9AEnG57uy?=
 =?us-ascii?Q?SYpQBzxZi0OuEAGrwS4B6GNWVyMbgrkkepHCjKwnJlOh3eZ77x7BrCnMfOTc?=
 =?us-ascii?Q?TAZJY2rJCCQ4hWMH8Jc21cGpNmwsWlwDF/LNsu2sb2jPyWgTWj5ap63q/mrC?=
 =?us-ascii?Q?mqWl7uDOdR9nY/vQyyH++Hl0l8m1?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FlCFNHUrCzvIj4hgXnptmKofYpSsJVIGhBfrrLqsABRuSiApdzazRY8cvsIJ?=
 =?us-ascii?Q?wppqZQeltVbtBkZ3Hi47s2Qq2270qJXPYn/gnrU4lk2NGjM/ekeUqA6QUP0f?=
 =?us-ascii?Q?EriberyLR/26UMVkHrX0fj3nhQ3U6yvqAACIdM0/c/CiJtbI7KHGpwj23YTR?=
 =?us-ascii?Q?Ajdeu5q9CiFX+S8rDZqr2maGw/txNR8iBOXjOxlXKBp8srDjjMme+cat5O4h?=
 =?us-ascii?Q?EDZ61IkxD0Kz8V9A3kav9ODq6N4DDBDBCy7+LVLr7GjcU6LHA07Q1JGTSKYi?=
 =?us-ascii?Q?616fYFVBYTQCFOB0XXwNOQUH9RDI1gqw6BoWpK4ArtazMu7qRHGTfIPG6q84?=
 =?us-ascii?Q?vDwboSzI40hhfn2+IIBQaSCpK0zg0MtF6MoNPCzgKxDmUpEOZESdlmTAjbgo?=
 =?us-ascii?Q?q7DT1amMLJSXvWTRGcCbLIPAdNORL4cJiomd7/MSF9cWeR+aNDP1BX47sL2j?=
 =?us-ascii?Q?u99uFMgbvrH5sam4qUf2Hn1YYzoPtvPNiw6atE5q2uvKfmrt44bQfreuXTfu?=
 =?us-ascii?Q?3eGhtJm2r9v4BYNtkf0I7SFmqyQk06oriN8NMo9/rWFmXMKfOAZBaEzTcHsZ?=
 =?us-ascii?Q?GrlleSiKmSx0YzC6CoCKvUbfdsQCtIVd4a1o9i6NYDFFzO8baEePNSWdQy7l?=
 =?us-ascii?Q?wN5hFSB0k2TfyqO34+qTEnCiB0umEQ64j8y+zKolRg2wVCO286cCyKdolE9x?=
 =?us-ascii?Q?dsGDb+nOhEDN1MNF9o60boJgLTeRmYO1mDIiCsWqTZqUlV9lbMZx3T3OOH4o?=
 =?us-ascii?Q?KRFQDy7XfEgkVOe85jGLbFoQCkpFnUk9IkWftVeuWcDf9Gv2u6kChgVPyd9i?=
 =?us-ascii?Q?8wQt5c9ObrAuxt37z+VAvxwiZPOpe8hJeyf2lmR4OBuVxxpnFaQNLi1Zq7O6?=
 =?us-ascii?Q?y8pASWYVBDGf8LRv2/4QOGnhCZIkIajmkqDsX0Zu7vcLHfbJk1QIoji17Tuh?=
 =?us-ascii?Q?nc8M7jerBJueZfAi/DWIBIejRop81vGZt3ojFBnSQMZvyKhiCy9KDu0FWU1H?=
 =?us-ascii?Q?HxOLLdEKu1nbZoiWDLY0O2CTHguoSJSEh/DOPXcpDib+3gAgLMVs4KLjUIu+?=
 =?us-ascii?Q?WRGVrN4T5B5eGwVixNJnll2HwJgdgSEsClCUpXyP2jNQ5aLWCI8pNtjwgCvQ?=
 =?us-ascii?Q?dCsVl3xHswZ3AllLgCpg7XC1kZgpilAA/8FRfmqTF8ASZ5hbv4Ttb/dMk9RZ?=
 =?us-ascii?Q?HkCnEx2u1b+jDxDupTJIg3EjD0dbNIPPQiQKMx+L2WrDW8fMrL40dhRZX0qb?=
 =?us-ascii?Q?u+ZU6CUa6GQrlLrXIRlDV24JoyaDpkUjH+xpWrD+qzkXHT3kcUs4BoAkIIQ7?=
 =?us-ascii?Q?kPmcraf4gtsz3acBWyRXdfDjG4foT7ev5rU81jL1viAm54k2CUhVeLEiHaWp?=
 =?us-ascii?Q?5qJNBFARiQ/KaV+LOV3EoG2ojzZNCMmmCyyllbCfD/WdXqcLGhxp/p33zvK5?=
 =?us-ascii?Q?6d52+wOJApNzbDdb78o3CN3Cn9Kc5cX+WCwiSHmqhGbdcTvyB7BAmFUfNBwQ?=
 =?us-ascii?Q?RX5sjLhe795O5j7D/hnv9Dbj27KefnGcSYK/Axm2Ax+2jsDFc9rZ0bM23tYE?=
 =?us-ascii?Q?azHJZs4hu5QgNo5i7CratDxo0altwLvUnd2xx/KetfX74Lc1ujmWBqFWLYBN?=
 =?us-ascii?Q?7+1tGR+AuVHmjf1t+B3vcjM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2CCE3CA953800B4F86834E05832E99E4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7Coec7jvPUbsv6Lw7ytSN5mzwbcRcSXR3r7UVAtFURhdwP87AwjyByx0O3hNywJAphWKd3BG6MsS+hlyBjmWW7VWiBOElpU2XcPSG8dd9pgGmtBjWVNnBiLL5U52FVbQ4MyJXN0PQ7qiYx6KmzPxmZNNFs5T1qPd8zuk9MZ8N42EeNyJiiML+1tUbu3vMOm9EAjXLsRLzDSxSM3rOyIJ6KtVKgYI9EGB22ikO2Ye0nQWEyqIz0BwVqGzBXmpE4URPYqZZkEg+OYOVzm8IZvIiLxh5/fL/eQd+thrq8kBgS3wBSvw9/gAudD2gUW97QqTNwmyhDlgCrrzKI7/WEqcxASlv/g3UDPABGJa7+BnZwdQub+C0V2BdPROkV3OHc5I6tTtZKU7g8XA21UOMDWcGKzYBj2qoyM4X8thIgvAK2KCHlLM0RvrBqDJWLVmJfuLoC9nqnQdMZujVz/b080w5tXKRpqtXGm9502lSjs1TSegZkuCummqop1cLsV9h8U96egiMRBm1teyXvD5BObT3tr2TD6Bl3c/oZR5iG+I3xzXnfiZwJFuLb4veh3s2KTSS0nU3wRTToZ79Rui3Mm8o4i/S4M0AnE0miyMZuCDKvnVzZfxo7mso/RAaAlKgcqL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc6881c3-c8df-4c6b-a6ac-08dcf9812f01
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2024 07:54:01.4405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4G/eELEublcTSEVK1tghluDyugnZSk27zR5vtLPUfVUnDa0f7jp1V0YXrtYzOrP9shKnJjVVQuj3s1VYe9RW9TqbXwTcwKtq6DeSP7G9tmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6521
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_005407_361047_68A48175 
X-CRM114-Status: GOOD (  20.65  )
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

On Oct 31, 2024 / 10:35, Guixin Liu wrote:
> Use def_nsid instead of hard code, the default of def_nsid is 1.
>=20
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
> Changes from v1 to v2:
> - change the hard code in _remove_nvmet_subsystem() to fix
> the nvme/004 fail if change def_nsid to 2.

Thanks for the update. I think you overlooked my other comments for v1, whi=
ch
were at the end of my e-mail [1].

[1] https://lore.kernel.org/linux-nvme/33susvhlxjt2uf3gqldcb2n43pgrvt5m2wj6=
b27nbgeoxamfkn@az45ko2fsydt/

Here I quote my comments:

---------------------------------------------------------------------------=
---
After this change, when def_nsid is larger than iteration=3D20, nvme/052 wi=
ll do
nothing. I think the change should be like this:

    for ((i =3D 2; i <=3D iterations; i++)); do {
        nsid=3D$((def_nsid + i - 1))
	truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).${nsid}"
        uuid=3D$(_create_nvmet_ns --blkdev "$(_nvme_def_file_path).${nsid}"=
 \
                                   --nsid "${nsid}")
        ....

Also, same change will be required in nvme/016 and nvme/017. They also use =
the
--nsid option.

$ git grep -e "--nsid"
common/nvme:                    --nsid)
tests/nvme/016:         _create_nvmet_ns --nsid "${i}" \
tests/nvme/017:         _create_nvmet_ns --nsid "${i}" \
tests/nvme/052:                                 --nsid "${i}")
---------------------------------------------------------------------------=
---

And I have one more comment below.

[...]

> diff --git a/tests/nvme/052 b/tests/nvme/052
> index 1dcda23..781a9f0 100755
> --- a/tests/nvme/052
> +++ b/tests/nvme/052
> @@ -57,10 +57,10 @@ test() {
> =20
>  	_nvme_connect_subsys
> =20
> -	# start iteration from ns-id 2 because ns-id 1 is created
> -	# by default when nvme target is setup. Also ns-id 1 is
> +	# start iteration from def_nsid+1 because def_nsid is created
> +	# by default when nvme target is setup. Also def_nsid is
>  	# deleted when nvme target is cleaned up.
> -	for ((i =3D 2; i <=3D iterations; i++)); do {
> +	for ((i =3D $((${def_nsid})) + 1; i <=3D iterations; i++)); do {
>  		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
>  		uuid=3D"$(uuidgen -r)"

The change above causes the shellcheck error below. Do you see the error in=
 your
environment?

---------------------------------------------------------------------------=
---
$ make check
shellcheck -x -e SC2119 -f gcc check common/* \
        tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
tests/nvme/052:63:15: note: $/${} is unnecessary on arithmetic variables. [=
SC2004]
make: *** [Makefile:21: check] Error 1
---------------------------------------------------------------------------=
---=


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA67AC55162
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2026 04:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k32ehJMKWCPXlSmnZEYwcTchSvl5CYCzT3/uk6COQ54=; b=FJzUH2UhociFjVIxWgnCm3Q3bf
	0pev6CnD9b4Ol3cDitiSu2oRH220KyVgDFx7ARFUUZ4J52Ru+eVxNq2tmp77niEGK78XEA2fGYCJQ
	RMKdNCkCX5162We8rZXenBMwKmP8Bq8c7uGQg1IsRRPPgXGis9K0K4SU93Kp1MmxMqpSdvrRNxwkU
	TI7LKYn2xdaoT/r1Y4MbEUbnK06oN/KTaLMxANvvc4cA2EGNeD4INxoAEW6LqOLJ1tJS1ct9Mopf0
	/23eAmoas+U2T1UOti/Geq4Tk2HODjXEjkua3GJWbsd6xoRdzF9tv6b5/4WTspCN7Ssk4VslHUc6/
	K9IR4EOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqk4q-0000000GIF2-2D6d;
	Mon, 03 Aug 2026 04:15:00 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqk4n-0000000GIEM-2SqF
	for linux-nvme@lists.infradead.org;
	Mon, 03 Aug 2026 04:14:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1785730497; x=1817266497;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AtN10Hiy6f7mc8SatJIKd7KXYANCOeKwH2wUPQRHnLw=;
  b=U/dp+RASYRRZCanw+M363az+gfk5o02I+rSA/dtCS+3Ffqnhj/BnQbzP
   2WJRxvFu4E77dGQ66DzMALNVftAY89Jh1XbpCDHivTeezaPEc33ZJ+O+L
   kMC9/UADslp4k2bYjW3RAvINS8vjQpgXmnk9BDrdwfaxo5yVhvOh4ZvrD
   RLSkmK3swWhde2usIeXXn6QijefcvEIed4lDp61xZMSRIKRyw/rPf3gpS
   Lt7wxpofgNTOuCI51M0QgCW6tBnyV7O2Yh5r+AFLM7zzlD4UdE5Y6Tjwn
   enUBUqFwNZuU8pxlPWL5TuX8v2sfz8UZKPsXfwx7Pl46HXvMUyVURb0Jl
   g==;
X-CSE-ConnectionGUID: CErc5bKSSMK9a6ZweC2byw==
X-CSE-MsgGUID: R/AvT+aPRk2U9LhLDwMhFw==
X-IronPort-AV: E=Sophos;i="6.25,201,1779120000"; 
   d="scan'208";a="148137191"
Received: from mail-northcentralusazon11010061.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.61])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Aug 2026 12:14:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rxik3+gDh5CfmqsZJUj1W8onhI7cN4lD8t/dd3oZzQZBYqtLYFissTcvYOO4bFKlS+0Xa1Mv8kdisAyS/KpP6Pz8m4AkPgTb5vCNMO/+lfr6Z1rzYiGm/kBtj9BKnqpXnGN+bbpefqunjzgpbVThnHSjhljJoAwVRURMM5bKFGUDEh0XcoWHWl+hje+F8j77Z7ZEoz5Wp6Lp5nE3YXnlwqpLH2WdfRW27dvOlwKU6eL/L+IeFZa+p/ahL7D6dxWyU8FnD1/98VcAPrkpSiS5UapWDzpdiUJ5XRLwGHfEvkYSBLPbGiU21VbXnN9dHalOt3OmWR3yarJ1Tfj9doMlKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k32ehJMKWCPXlSmnZEYwcTchSvl5CYCzT3/uk6COQ54=;
 b=sRj8h7oSXQsfjoO9NeP5j1jxQujO/A/GoIw41Cfw2G1nmOkDPqeznjpNEsJlGapwcdggeS+D2FrD/oBLFGv9IW4MU/qGINnI4vePE5en+0qoHsivQkzdXuNWQbVOr3DvOYtRp3AkubvTQf3YGv3i8BYkZWSBWlw37S0DTL4NrXi3gruf/27n6giVNs0Fwg2qHAySUgDLFmbNq6C7d1I6kf1RxVNueFszUVI7wBnbzZkjBWcYwWt+vzFlXjq+OR+YG948p2iVCDs1XTau5YfaMy3wPiny0TMTXb6VNNYB9gdPgXDiscYvzR10fw8sQKv9Atz/ksIlD2bmgyyimTts6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k32ehJMKWCPXlSmnZEYwcTchSvl5CYCzT3/uk6COQ54=;
 b=OeTLFmN1XeFA9cKkE1VhQBRX+6gjp0ipw6rOw+VNrwqVYVcAUcbI8ubk3ORNn/C3djUa6r1vLAhbTCb/62R3XuOGb5qYJEVK3OaiunyS9MV7USYPQ2Yzk3RSLJhJ9Cn/2Owvh+J2I/Tknx1yFbENx9Ly+I/ZC9gnmyjBQGkoXg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14) by SJ0PR04MB7725.namprd04.prod.outlook.com
 (2603:10b6:a03:32e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 04:14:52 +0000
Received: from SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85]) by SA1PR04MB10065.namprd04.prod.outlook.com
 ([fe80::9b98:bf8a:b0b1:ef85%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 04:14:51 +0000
Date: Mon, 3 Aug 2026 13:14:44 +0900
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests] nvme/070: add a test for Identify CNS 07h NULL
 pointer dereference
Message-ID: <anAUf3S78MSSr-LJ@shinmob>
References: <20260731032601.1100664-1-kanie@linux.alibaba.com>
 <6f4a1b76-50f4-45f8-9a56-e6f66637d7e7@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f4a1b76-50f4-45f8-9a56-e6f66637d7e7@linux.ibm.com>
X-ClientProxiedBy: TYCPR01CA0191.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::16) To SA1PR04MB10065.namprd04.prod.outlook.com
 (2603:10b6:806:4dd::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR04MB10065:EE_|SJ0PR04MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: b9425ff7-5e9f-463a-f956-08def115c3d9
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|19092799006|7416014|376014|1800799024|23010399003|366016|11063799006|56012099006|4143699003|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: spBNX85acft90upGiir+59ZfOA2/UGKxFKqV0Ocam0iCCvZy6bFiZaoeVG04NfQnQCHEMSnn16RH/jJi5v4z8Af4yTXWZheTE1HzKd0gU0iaSz8l+e2G9vDQgJ4cMFb3ii+YXl4qw3eCMExHhqbG+QFPWiI+etm9fAbs5xkLUlJNPVBBpY/cevl9uRaRxsrrD1HQjSGxLbqVzzE6HFuhvK3/p8hCM+jHdkx43LNFYRM+eTGIV3IhLwHTpNAfbEmk0VGQbLmA4zavcXbngQsy0h2RC7AC3+2eEQkHzrtY6L+AE5ca8P7pPtTkrdj0OVK6nnd9izGxeFQ/k8ddbAmO2M83AMqk5B7BwNXYu7HvKoxI1YEOdddmeWB/FQO3bJFlm6EY5dsn9ZryXcInXmi5b5g0rxZlBdHPIiTS6KdX4rTbw7mIyiyqQbGGq0ErID3ZhKOvgFnwcfQ2QRW8pH9cWyujKK7NzGDOiuxc3Ar35ndmV6ftYsI3MnxQrLt3vtSjtODvMplJVl5WcJuys6VZuhW0JpK3SOot2tQ7Gg/RqV1Z2M48jra41lYpWPJA/o0a/AwDY5X1GE8S1KUpE/JN8jQscbcYi0bo/7GwoTw3ZqezCuXgVjqfFVTq2646+d0ELkvqmGaRNvs+HqAVuNKFdeXCvocS3JZu6IKmgTR3NfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR04MB10065.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(4143699003)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yMaiXwpi6qFXq7CvcRnUaKOyfilE6I4xsMhOUrOUjmIam+aav+NBbYp2MDEV?=
 =?us-ascii?Q?+tEc50/MauTUYcGWup44nD40DTFWB+v9xF9n7toaDzQWj2eZyctXaq85bKQn?=
 =?us-ascii?Q?YFaYXskXlxMRPPIPof0Q7ALOoqpWsJW/uveha7gyzAqIqWyy37SN7V4eVilt?=
 =?us-ascii?Q?jj5jMUSIsRxNVQ5I5+/Mnw9G5TAYb5V4RP3bVbAY0DljFSrCTU4OS4h7ho+Q?=
 =?us-ascii?Q?x0VXNAbhDpTLWEmKczy9MTefvQtMZ35gQmguXZBDZNwqLlCtTtY77hfLIiSf?=
 =?us-ascii?Q?ByqXUeTkTtUi8JYzXcFmqf9xRf4+JyslO8MKnJ8vqxxXmRgc6TCjFwLbno4Q?=
 =?us-ascii?Q?LwKWIPVQdNhYM5qsVIpSBg1C8Vh1W+KQzuimiw6vuGpTGIjaZwqe0mg4iS48?=
 =?us-ascii?Q?gXqrnX/TNKPp/Jwj7QRajCQgYOappgtK2ik9R4OnfY2jdVqSuKSa77jqQfEE?=
 =?us-ascii?Q?Npc9xSlBoMNLdSXvkLf1Qzb1h2gWqNlfWqhz00HFrUdJyBep1Tmr0YIH6RLu?=
 =?us-ascii?Q?DGEfwEQ74Q3SCTllx8JKblZcsI9DxjCjipYDElF+ylhRuoFopTZ7bKCWTOdB?=
 =?us-ascii?Q?pZfW9oDbUJg3VRxrtgJ+7mTgrAJtxUBOYWlreFtTHX5Mvok9guAxPnddjF5B?=
 =?us-ascii?Q?Y9+5mEwcJkhaWbsEaufN70WJOfgmmq8aBZCL+fY9wByT3SSpFV5nHqmRA+Yh?=
 =?us-ascii?Q?xCVYkbqnek+V4cst62jNy3OjufewuBcTknja7pV3kXZQhR6KvUrjMQsMLuRn?=
 =?us-ascii?Q?idmdHBpvLJP9PF7kpuiyQwdm0kDcYewBIf+J5xCfFHDCnJnAPjKRssL2fG2/?=
 =?us-ascii?Q?9/ZnfCX08sgPjKO+xIDhO52Tq6i1pGKjKmehYUBYuNDnDcDtH6WmEPMX0XbG?=
 =?us-ascii?Q?RZf0yN+aclWIBiryyU/RZ0dvwXyus+Gfx3UT8mntIY8R7StDuW5c3eMR0TjL?=
 =?us-ascii?Q?x7mHq2SQcbzAqZ4fzQOlxAR5eR/TRe9CnYjLwYxdrGBbjQA84YblAAOMVfbC?=
 =?us-ascii?Q?KyCoBQufX+Yjv49fboWRS2WGLwD5EVl78qf0oBb6BzjVTvLvD/uz7aAbFWg8?=
 =?us-ascii?Q?c4mB/uMDlCJFsEcPBse/JKSpHyPzdNP4BPhLTnn2jd8pevt8UkMpci5XwIUL?=
 =?us-ascii?Q?9ubTkvAH/bC7kpncaUplQSc02wPTzEwUSMEOGhC8wFR6tvkp0uAS0puQVibT?=
 =?us-ascii?Q?deLGD7w+a/2Xm9UZ3708KryRMcEFo200cYiDKv7yn0dBMFvUBSL2hNmHHu5W?=
 =?us-ascii?Q?xN786N/xuGWYHtft+fkMNRcOgxDhuh8EV2F3+VdMHwVFcEiz+5luq0wN5LnX?=
 =?us-ascii?Q?8GNDH2ik9JE0TRyaobDC4UQm9TjEtUmte72brBoJKCbkrC+ppv8XSU7Vqrfq?=
 =?us-ascii?Q?zc6pTkJMPjFZ6DBsa2R8OPHx2+ld/+EHTaU/HL/1RDm8GZ5qeZibLd+f4hN7?=
 =?us-ascii?Q?VZVykyhm4GPSOcypho7N2yKxkLFJzyKrZV2ifCHlSBj8viKazWit1HClkB3u?=
 =?us-ascii?Q?XVsXwU2sqaqX8EDSpt2oYZjan7otvVzHDfatoemMM5/msfk5Iu9KdvO/SoeH?=
 =?us-ascii?Q?vb7gwJ5PC2SHIpsCsKaaX5nFJqaiusvfdEBIGFcTbe5JL0gqbyIbQiR+BNWQ?=
 =?us-ascii?Q?sOVoJqIKVIkIwIP74oPFBu7cSbk2udrY+RdJ1u2a1rhqvP1SIHxHGGftqN8A?=
 =?us-ascii?Q?UVs+57s/VQrBNmbWSUlKK1AO/35plVUbzpdiZwoIDTtyuSvHGNrvb0b20LHs?=
 =?us-ascii?Q?T9Sr7SlABOqhfQqk9l9OBqrn+CYzkaM=3D?=
X-Exchange-RoutingPolicyChecked: D1OhQaKSkEh2eTbfpT8lXwChuBCHKfMo6gq/ArtlsNAhUOFzRonUAYjeMSPaUrt0hPjDj8gA937vR+kNscJ1+Vna7IO8Z6xb/GGHCWBfH8wr1GIbRXngrzqINXzqMLLYJ3YWGPU7E3XZoJ8WTVHcrO1WE4CEgCngHdrPhpuvPEzNQ6+viNkKPK362UOuWj5HUwRy7TUDGOZTU7fOcXd0A3OYWA+LsS8kDm6MahBaazVdmeKkkI75Oxza/wYIsCtxpMEyKbiHO0kb/QD5KiuLwvJ50KIvjSZCJQ6X7A5eTXqnyg3NXvRMt5DxxuxaH/PPoHkIbKJceHMmWG36w1nuJQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: R5e4kdmvYwXt+nPSdeo9O4OkLjzuTbXNe7XLq4xsyQmwlth+Ar2xtlG/nADDEYLgy6cUioyCfpkBBZX6J0PE/5fUWyjrLwswCuEzfepHA40TU1w5f5Sy/UDBC9UKd3tE/C4qq5cP48IytJ1chRoHM95kdMCGoJ9U7JkteENvfyL80n1uPKCTz8NWVrm5CglTMg+ZoyugY5fLNyh3/OXmpTVaHXc0PMq/JRoLHzGBFKFCOoaOmlX2F+J9ilfB9APlVofX+YMCjY52L0aze0Ia7vajmT8MhU1JttISE4H+COWL06qzfx48ad4JLroqihZa/PD/3TVcS80xe9b3wrj/A+Hf5VwJHMjfmOKFY8rWsXVHIwM4gPEjl7+hVQ6zuDiEdxM0l4hQadZt4Q3Dg2b3of63ETF+LEDSjNi4hsb1FJyV375uojCrKyLdYhLC830gMIGVI7N5GObec32JYG86YaUu5B+VBUk4xGE9h3lMhBSGAbVC1NNWtFaQKpBe8hoNJ3jpaAO8K8dJ/7pNxLzoKIKGeV6oPngSD/gWu4iilioaY6Kbbztrr146rG+9pbIM7GDFIWv+0kyZiV/5NYp3hFiCpI2gs5UDnXDw0x46FtuX7h0RZqVXVXJeDmUlIiAx
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9425ff7-5e9f-463a-f956-08def115c3d9
X-MS-Exchange-CrossTenant-AuthSource: SA1PR04MB10065.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 04:14:51.6295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQl67R5Yce4uEdOH+eJdHlbjsMO0kIMnivg2kIUSJT6qRluY1RdaJhDbkm1JY+tk7DFu0FV5VHUN6NRqvjCx5oH0+Kmm95kYv79OZgQ+zUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7725
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260802_211457_688263_E2034B97 
X-CRM114-Status: GOOD (  17.33  )
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

On Aug 01, 2026 / 19:31, Nilay Shroff wrote:
> On 7/31/26 8:56 AM, Guixin Liu wrote:
> > +test() {
> > +	echo "Running ${TEST_NAME}"
> > +
> > +	_setup_nvmet
> > +
> > +	_nvmet_target_setup
> > +
> > +	_nvme_connect_subsys
> > +
> > +	local nvmedev
> > +	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
> > +
> > +	# CNS 07h == Active Namespace ID list for the specified I/O Command Set.
> > +	# CDW10 bits[7:0] hold the CNS; CDW11 bits[31:24] hold the CSI (0 == NVM).
> > +	# Request from NSID 0 so the enabled namespace (NSID 1) is listed, which
> > +	# is exactly the condition that used to dereference the NULL req->ns.
> > +	if ! nvme admin-passthru "/dev/${nvmedev}" --opcode=0x06 \
> > +		--namespace-id=0 --cdw10=0x07 --cdw11=0 --data-len=4096 -r \
> > +		>> "${FULL}" 2>&1; then
> > +		echo "Error: Identify CNS 07h failed"
> > +	fi
> 
> The nvme admin-passthru ... works but why instead not use the existing
> "nvme list-ns /dev/<nvmedev> --csi=0 ?

The patch looks good to me. I also confirmed that the test case recreates the
NULL pointer dereference that the kernel patch "nvmet: fix NULL pointer
dereference in nvmet_execute_identify_nslist()" fixes. Good.

I also confirmed that "nvme list-ns /dev/<nvmedev> --csi=0" can recreate the
NULL pointer dereference. I'm okay either way admin-passthru or list-ns. I
would like to know Guixin's view about it.


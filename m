Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 627D3C19F2E
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Feb 2025 09:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aRxvs9cHHFmg6xPJmaxhOuivdPjEdJ3eVK4EP+IOCAU=; b=umUzKegy50xrYk/tFIsZcAJNZ5
	XNo7aGWa6ZT0+hU2i0141kLMZp8+BEnfxcspV+iChwHgLlYLyDq9t5UQXxxhOI71gM9cJW3BQdW5y
	UvX7SE3QEmg5uXUl1hb3MUcfKZYt0PoOrhHz+s6/nWZlhCdGO61qMf/1kEyRunBpKqvUMVf/m8G/0
	tUeu6ZHV3D7lFGpkkKbPkasRdBgdSXAh7+j3gT6HStKcezzG3bmKpmbD/D4WHie/qPv0KewDXtTf2
	+LrQj68VIF/ZcQcJLj/aI21GWSZEzlcPu0Sh6iMCm44BbDw5vqhxOxD2xOnMaXGh+cfriX0Z4pMcN
	VnhzVyXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnZtl-00000006oSZ-2eP0;
	Thu, 27 Feb 2025 09:09:41 +0000
Received: from mail-am6eur05on20727.outbound.protection.outlook.com ([2a01:111:f403:2612::727] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnZti-00000006oRk-44KX
	for linux-nvme@lists.infradead.org;
	Thu, 27 Feb 2025 09:09:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g/dpzvcO6fzaoos/31ZRd3RwtfahBLygny5oP/Hh/Ov39g5IpThCGiMYUX4V+hCv6kXR4dhHjCUsGf03TVWOtQ+4OcX7r9fTyofyM4x0b3giblQCjSUawDZRyojTkHpRW+m+bnOdckcpgkpenYK7OyI1n5spS5L0Wir/J72/dv9brO4DqK1tSo1EdJXUgDsdtJDJbl9xu9sRUtvrmUM8jLCra6hBR1GNa64jVaxdAJJkk1HGJcFWi83OIiLQ9dJ0EEqL4XLZ1YRXWtN1Fo26mT6LlaMViLUuY+XpZ8YwibZpgUbVGZdDm+szzLOLmb2bTItdBD9J33QLLGfOIRtsTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRxvs9cHHFmg6xPJmaxhOuivdPjEdJ3eVK4EP+IOCAU=;
 b=ea0HOJu4QyeGtzGa0A/mAm332ZPXsKjiJGbVKlFxAmEzy5yhhrjW1ImuvnaPgFQxRfwFkAm1ugR1sRJBMVppHIT7QTR1mZHL/CvY7eRBRm0NIpYM8O/QDLEDKSGI17ny48DOLsFqYfrx9f05EgW7IM4u0kccXFWYH7arbfqPEs3CuLwtpn2kp68MvfroDXKR8DYx2WmGPQAmHzD4OSGnEh4ubaz1OQ8GArTPDcDW/130nEbPbwU29uI3rGVbKBirKk2ecPuVYPPK4NKbsVhCmFQmepMQwSQTbM+2LmbPq0q3YNNfSLqTSsN662luZw0HOXDSKhMFoNAvQNQeJMGqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRxvs9cHHFmg6xPJmaxhOuivdPjEdJ3eVK4EP+IOCAU=;
 b=TJHVy4qyGg+BHU+JnDzbl/wBfqdFa62rOV919/7UJ9+7bDiH27zedEsnU0KX87sPk7h73AzxM0JAdny3frF4AL3NFjWxIrfjiLWZ02wBP+REMMEeeQMQNLRMrBO05BYpfq47347/QAYwbf25SfEjvLUNpuKQr0OicqMlWSZi74hBD8mog4+K6+EGfIjxmHV0XYFjFiXSW+H+6MMx3SW2+0eVUlxIxazuUK6HQUg1701mtjk0Wj6tZJsLY6HP2OhGlGlHGIjMx4K1Nl974gqMWXDBf9p6IyrwbwmjnoAkhIntI236X4N2SUWR0azkTDYVDTyuH0nLDg7g29XtQG8Ejw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by GVXPR04MB10634.eurprd04.prod.outlook.com (2603:10a6:150:219::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 09:09:29 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%4]) with mapi id 15.20.8445.017; Thu, 27 Feb 2025
 09:09:28 +0000
Message-ID: <a47d5d1b-3c52-49be-b084-3726f8028037@volumez.com>
Date: Thu, 27 Feb 2025 11:09:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvmet-tcp: Fix a possible sporadic response drops in
 weakly ordered arch
To: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
References: <20250226072812.46089-1-meir.elisha@volumez.com>
Content-Language: en-US
From: Meir Elisha <meir.elisha@volumez.com>
In-Reply-To: <20250226072812.46089-1-meir.elisha@volumez.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::9)
 To VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|GVXPR04MB10634:EE_
X-MS-Office365-Filtering-Correlation-Id: dfdce734-24de-449d-bb1f-08dd570e7053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cnN4ZVhFalVWT1EvWjJHWXZGaVN1cng1TnErTG1JVU9ScDFLWE1WdE1RVmkx?=
 =?utf-8?B?Z3M4eENYVG5DWjU1ZmVVS3o1Z3U2blhiWHRHcUkwbFV6N21vVU9mQUJlU1h3?=
 =?utf-8?B?RXZ4bTRFUDVVS0JWaFZrdmdHNTZSRzRzaTdveXEvTlVzTGszREJCdmczTjZh?=
 =?utf-8?B?aXRwMStwVVhSY1g0ei9KdkFGZkVqNDhHZ3cxZ0xJNDdOd01Nc29MRVZGY0N6?=
 =?utf-8?B?a3d3aTdON1FMc0ZWMjhYQ2FYaVBEMHpwVGdCU2hFV0FuU0lIbHN3TlViMDY0?=
 =?utf-8?B?a1lscDltNmJ0TS9YMmJnRTJXME41Rko4SEd0cUxJWVQvaDBKaUtzbjZQWE5j?=
 =?utf-8?B?eXdkTVhYd3liVWtZdmZNcGVxcGt3VUJ6M3V0MGNOK2pHUkI1dE93RVJYS2E1?=
 =?utf-8?B?QzJhOG5ZMDZKNll6UE03amxpV0Y2WVQ4V1J3K0NDMFlWWlZBdjVvWUV3a3BV?=
 =?utf-8?B?WmkwdVR4QnpzVFAxZytWa3dwZWh6MGxPRVBWdEY2OUJRMGdGVk1zZTRuanJw?=
 =?utf-8?B?dE9ucHdINnFxU0ZOdGpMZmRDU2RuRlR0QmNlREs4S2x4cEkvZGJCR2xwMlAy?=
 =?utf-8?B?Y0hNdDJGU3YxZmFQMGlsMDRZZWg2VlNramk3N2crYmVjR2FSL1NrWGV1QStu?=
 =?utf-8?B?Mnc3ckI0dDdYU2pXaExPdHREcWxpbGI3WWVoSHpJMjNNc1dVd3RCL05kTDds?=
 =?utf-8?B?eG01NC9xa05OWUVzZVdkdUNhaUdFSnd2bHVtaWlWUGpVR2hLRjlXbTI3Tk5o?=
 =?utf-8?B?NWhXci9vRGg0NWhkMUFqOXFsNHZGQmFjRlE0MDh2Q2JXOFJyM2NLTmdBZ0gx?=
 =?utf-8?B?SDJTVU9PRFBra0xQd3RsSnE2dU9DR1NUckpqMklsUytVYlZwWWJPdElXejBX?=
 =?utf-8?B?UTVwVDlwNmtISDRCSWd5Y29uVlNpdzV2WUdOaXpnMEY4TEJHTnpsN0EyVkFv?=
 =?utf-8?B?NkJtWVJzWlVRTWd1a2tRaU9qRU9ucTNVMktHbmpPMU53VE56RDk2RklJcmhQ?=
 =?utf-8?B?NVhSZ0djYWRXUzh0ckhkQnArbVBabFVxckdtQmQ4V21kRTg4QWN0bHJOMlhp?=
 =?utf-8?B?NktSZk0ycjlKeFNqOWt5ZWJ6aU1NWlV3MXVnTWJRbVdpRE1BNWljY29zVDRG?=
 =?utf-8?B?a1dkMFZRNFh2SnNkR3AvcE5pT3J4bGpPeFpWeThGRFE0RUczenNJQ0xZcjhQ?=
 =?utf-8?B?bFhLNCsvRXNUcHhtTUw1b1VNaDNweHNTbndVUWxhbnB5YWFnaEdZeDVidXV1?=
 =?utf-8?B?emE3R0RkeUVLOHFuWW5TSStTN0FFRmM0cnRqLzd5NmFKSjQraEtSek9JY241?=
 =?utf-8?B?Vy94WDF2NkpoZjhOcmdzUVhHV2xIZk5GR3laTmZKQmN4ckNLTCszU202L1NV?=
 =?utf-8?B?TFl3VG5EUDJUL0ZyWk1haDI4WHZJWGgvZGZrNGxSTnN2bmpPcVB2Skd3MTFN?=
 =?utf-8?B?Qk1qWmYrVlBNdW9iR0ZFei82MVdWMVVPNzRjSldkRWZFbWpSblgrT2xJRjlu?=
 =?utf-8?B?elc0aWxjcDB5dm85bVNPTndNTTJXQllrV3hMWEEwbHNQQ2k5V0ZpVEZEbEtZ?=
 =?utf-8?B?QTR0VmNzcEVyRHZTUVgvRkVRdk5OUkhCQWdRZnhDSUlib0Vsdm5uTEdIdE8y?=
 =?utf-8?B?Y2FKY0pyN3VSaU5WQVM0ZXc0TTVjY1YrWW9kNFRIZ3EzZWhJZ1RZbnVMUHdu?=
 =?utf-8?B?MFhsZEgzRE1IaFJBcGJiZWxHQ0o0Qk80bjN3cU9hdVVpWXh3QnZUM1ZDaEJZ?=
 =?utf-8?B?TExCMjFlRTlRRXBqZ2JjYnpyN1N4NEp2Qmx4Kzh2bjQvekcyUVRmKzdPZzVo?=
 =?utf-8?B?eDZnUHBNeWMyMWlremMrdDJFcVdOMHRIWFNlRkhpYmFTZVY3VmlOV0RDc0xF?=
 =?utf-8?Q?957pMsz3a4Lnx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWFEQkpTaUpVY1hUV1JtRUNzaFJVTVNzL1kyVm5xTXpNS2tRbmhOVmFOQUps?=
 =?utf-8?B?RmZ5VVRWUlk3SVhsTE1DREJDSHNmSTNGV1FKajZNZHFYSWZSTXJOM3BGcnht?=
 =?utf-8?B?N01JdHdOSlluZWorQkd0SnZhQitjS0lZbVF3Q3Q0WmdvV1cxZTdUQnZWYXYz?=
 =?utf-8?B?WmNhRUo1WGRQL2k1aERqbVhHMllia202d2FWVUpNc0F1WjV3VzlZN0RNQTJn?=
 =?utf-8?B?cmFuS1JvNVFuRUdBcHFFaDhRLzh5b0U2WWQ4dFQzbE1UNHNEWWdwcU9KVHp4?=
 =?utf-8?B?K2VDZHZadEtTTkdVK1I5MkNTOVlIRS9naXBxS3pPQ01UbHJMbk1qYnVPTmdV?=
 =?utf-8?B?MlFLZTc0UFo1N3IzdlE0V3JocUVDZm5VMWN0NnNDSXByS3ZiZWxWVVZSd1dJ?=
 =?utf-8?B?eEwzcTRtUkNQMHFqZ0FXS2pCT3lBeTdSSEs2YWFzWEtmU2NCOC9WN1ZlSm1Y?=
 =?utf-8?B?ZWVxWGdSRVEzOTJtSnlGV2hMTFhHanhoWDVhRmRhNmtOWE5mKzkyUXhtbGhG?=
 =?utf-8?B?ZDd5aXNDRzVNczBPUWNvVEk5c3lGU1ZxNVpIYXhjK0ZqcktQOXlLd25XS09m?=
 =?utf-8?B?T2o0U0s0cmVJS2MyazdMRGMxclA5UktaemhvMmNTU1FBQVc2L2VBR0FRTjRp?=
 =?utf-8?B?RFRzcUNzcEFwWUNHanBOUDJLZnE0OHFkcjZHanlrNVNyQ0x3bXo1emszR2Vz?=
 =?utf-8?B?T3laMkRpb0lOaVlrYTJ2WHFzMEJONC9VTkZtcG9McmkyVkRsdnlKZ0pjdFpm?=
 =?utf-8?B?dVBoT3FjZWJFMmJKbVAvZmpLYWMzS2hmY3BrZ0YvMnlYRFBZRWpyR0tRWkFG?=
 =?utf-8?B?WlB4eURpbnpIdlRHak53SlhodjdzS2E4ZERJVmVmVVB2UnN4RVRzcGYzVGNE?=
 =?utf-8?B?b1ZmMkErV292TGFNRUVTTW5VRXlCUm5PSFlkTnJ5amdQRHpUSkNpbkZ0dENx?=
 =?utf-8?B?aWRBY0oxbDRoaktxYUcxRnRick5FUDJKRHdaTGhzRURiUTNiZFBjeDBNdkUr?=
 =?utf-8?B?N2ZoYit3SUdnNmpQdWttMlhQZjMvaXRNcmdDc2lwck5ybkxGVTNQaEY5dXN5?=
 =?utf-8?B?MVN2MER5YWhTSTRLdVdhT1VBRHBHVnE1Z3Nma1JIRGZieW5rTnd2dFBERlBU?=
 =?utf-8?B?WnlGSTE3SFBJVDM3NkJZd2hjQ25HeENtVnRqbjZ1dEJMMFdoZmRKa3FOZHdC?=
 =?utf-8?B?TEh1US9qNVhzQnZ4c3ZTKzU1ald6NWFlblZWejhtM2FWb2lQRndjb2pwRkpB?=
 =?utf-8?B?UmZKMGl6b043TTRBemlSQk9ZeUIySGZBakhFM1dNZDBCM0xoMmQwVTNSb0Rx?=
 =?utf-8?B?RW9Ka0piMk4rbVZMQ1orUFc4dE52Q3RheFJVVDlValgxL2k1VGxlV0g2YXI2?=
 =?utf-8?B?MXFXK2pnU1NVQUZPMW01ekpkZGpYb0YyTHNUcUZIWXE5LzJQbjVuOEFRUndh?=
 =?utf-8?B?QzBuRjhpK1BRd1g5WG5aK2dEOFJaMDlqcFdKWHJ3eURqWGh1dlVrelkrT0tK?=
 =?utf-8?B?V3pSNDdGY05kUWdLVnNrV1lRUGswdTZ0YWpSWUNJU3dTcTNvU3FkODg4azFD?=
 =?utf-8?B?ZkxjVi9KRlJvcHlvQSsyelZSK1RTR3BmanBDV2p5RHhhOE5GSEN0K216OFNJ?=
 =?utf-8?B?SDUzaklxYlI4Y3k4WXFQcjhINEhmcTM3YUFiNzBrQzA3Z3ZDcHo3bzQwN1Jx?=
 =?utf-8?B?VVViNUVpb3RrYlN0OHMyRGFpSXNHTVFlS2cvVFRkQTJ3QUNDQ3hxRXQ1RmRV?=
 =?utf-8?B?R2R1dWtmZUdCSUtJc2V5aHBybnNpQzFRV1F1emZxMXQyOGpZdVJ3ZnB2UDZQ?=
 =?utf-8?B?QzVFd1FKSlhJR0VYb0JiUlhGbzdsZkpZaTc3VGRaTTJtcUtEaWlnRDFXTzh4?=
 =?utf-8?B?U1JaUzNYZGxjWW5ES3B4aW9Tb2I2UjN5c3JoR0tzajdPbERlUDJKNnBpcUlK?=
 =?utf-8?B?L0E5L1owbWluQlU2NUxlZE5CdmNOdzNOZUg2Q3BiTWVYYVpIczYwaHFaRXZi?=
 =?utf-8?B?STEwd3p0aTlJUnVPK2FQdHlIbGtkUERONE9OSEdQbWdjOXZucGhZRkprQjhG?=
 =?utf-8?B?aU1wWjdITlZsZC84aW5HckF2TXpFT0FXYTdqUUx5SHk0QnRNTS9lMTA4aXVp?=
 =?utf-8?Q?fnQBEfKbyC4rdVHxnUKqIqoFq?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfdce734-24de-449d-bb1f-08dd570e7053
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 09:09:28.4095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N1yf1c0/kBoG8Q6Ilix1YkWbphQUvvf+ymlxbbT/W0kQIncG9CuXnSx+ID81/2nkTHA36jzT4Zgg9tFmeGZS/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10634
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250227_010939_027125_CC280694 
X-CRM114-Status: GOOD (  27.11  )
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

Just making sure it wasn't forgotten since there was a lot of traffic. Thanks for your time!

On 26/02/2025 9:28, Meir Elisha wrote:
> The order in which queue->cmd and rcv_state are updated is crucial.
> If these assignments are reordered by the compiler, the worker might not
> get queued in nvmet_tcp_queue_response(), hanging the IO. to enforce the
> the correct reordering, set rcv_state using smp_store_release().
> 
> Fixes: bdaf13279192 ("nvmet-tcp: fix a segmentation fault during io parsing error")
> 
> Signed-off-by: Meir Elisha <meir.elisha@volumez.com>
> ---
> Changes from v2:
> 	- Cosmetic changes to queue_state declaration
> 
> Changes from v1:
> 	- Fix barrier semantics
> 	- Use rcv_state instead of state variable
> 
> This ordering is critical on weakly ordered architectures (such as ARM)
> so that any observer which sees the new rcv_state is guaranteed to also
> see the updated cmd. Without this guarantee (i.e if the two stores were
> reordered), a parallel context might see the new state while queue->cmd
> still holds a stale value. This could cause the inline-data check to
> return early and ultimately hang the IO.
> Additionally, I reviewed the assembly code for ARM and confirmed that
> the instructions were reordered(unlike x86), reinforcing the need for
> this change.
> 
> This scenario was encountered during fio testing, which involved
> running 2 min of 4K random writes using an ARM-based machine as the
> target. We observed hanging I/O typically after 10-20 iterations.
> 
> fio config used:
> [global]
> ioengine=libaio
> max_latency=45s
> end_fsync=1
> create_serialize=0
> size=3200m
> directory=/mnt/volumez/vol0
> ramp_time=30
> lat_percentiles=1
> direct=1
> filename_format=fiodata.$jobnum
> verify_dump=1
> numjobs=16
> fallocate=native
> stonewall=1
> group_reporting=1
> file_service_type=random
> iodepth=16
> runtime=5m
> time_based=1
> [random_0_100_4k]
> bs=4k
> rw=randwrite
> 
>  drivers/nvme/target/tcp.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 7c51c2a8c109..4f9cac8a5abe 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -571,10 +571,16 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
>  	struct nvmet_tcp_cmd *cmd =
>  		container_of(req, struct nvmet_tcp_cmd, req);
>  	struct nvmet_tcp_queue	*queue = cmd->queue;
> +	enum nvmet_tcp_recv_state queue_state;
> +	struct nvmet_tcp_cmd *queue_cmd;
>  	struct nvme_sgl_desc *sgl;
>  	u32 len;
>  
> -	if (unlikely(cmd == queue->cmd)) {
> +	/* Pairs with store_release in nvmet_prepare_receive_pdu() */
> +	queue_state = smp_load_acquire(&queue->rcv_state);
> +	queue_cmd = READ_ONCE(queue->cmd);
> +
> +	if (unlikely(cmd == queue_cmd)) {
>  		sgl = &cmd->req.cmd->common.dptr.sgl;
>  		len = le32_to_cpu(sgl->length);
>  
> @@ -583,7 +589,7 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
>  		 * Avoid using helpers, this might happen before
>  		 * nvmet_req_init is completed.
>  		 */
> -		if (queue->rcv_state == NVMET_TCP_RECV_PDU &&
> +		if (queue_state == NVMET_TCP_RECV_PDU &&
>  		    len && len <= cmd->req.port->inline_data_size &&
>  		    nvme_is_write(cmd->req.cmd))
>  			return;
> @@ -847,8 +853,9 @@ static void nvmet_prepare_receive_pdu(struct nvmet_tcp_queue *queue)
>  {
>  	queue->offset = 0;
>  	queue->left = sizeof(struct nvme_tcp_hdr);
> -	queue->cmd = NULL;
> -	queue->rcv_state = NVMET_TCP_RECV_PDU;
> +	WRITE_ONCE(queue->cmd, NULL);
> +	/* Ensure rcv_state is visible only after queue->cmd is set */
> +	smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_PDU);
>  }
>  
>  static void nvmet_tcp_free_crypto(struct nvmet_tcp_queue *queue)


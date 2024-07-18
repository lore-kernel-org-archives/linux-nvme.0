Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFA3C3DA60
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 08:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nUtT/CRbGgc/9dv4AwNzRyDzgjKMQcIYF2DdZIlUDrc=; b=WaWlNrxt2rc+z4tZJS6+bE5W9u
	moS+auHDMKrQWgWd3MY+ptpVCXcBCUlzJgbrDafTy9TF4WZQwiayi7IShfX8hN4/0u2y0NVItcamF
	OYsccqlJrxztJXFCPS+5N0GTWvzGpEBXaIwL/rlPPwKDC4bESl7eJLNjrTIpivt+inakWxnttLlI/
	bRVoBQeQuTtLxbppVQjqDnNHuobXA3RQNe5QMhFZWgo07cHu9ANBLTDZpbMAbrTdEphMT2eYNnbdk
	j+CLG/IxPXPvcVM9h3Pqr3fbj4GoUEXhoLclbIXRNoCMfrVysx1BlzgcC3ynjhmnNy9PkJK7Ta3TB
	ZOSoRGCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUMTu-0000000GNnv-3wER;
	Thu, 18 Jul 2024 08:27:18 +0000
Received: from mail-northeuropeazlp170130004.outbound.protection.outlook.com ([2a01:111:f403:c200::4] helo=DUZPR83CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUMTp-0000000GNmZ-1kGg
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 08:27:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gNjYX/XTUCzLAzmDovxyQauU3bwfKtSDcR9grEsCzZucZ5skoPyF+Yc5qgstxleyihgbfvJMGiCkvp03gEUhlyiWA0xxh5BzeCJFNKY0Q5vET/Eu4T3MlhgaqDOBTZfN7PGY/CfEk7A5CHkpsfg/mxtMh8mEwc8x+Zy/dY0qrUZh62fHsvcVD5quoXnsUbucnZuxBWxPk/Fc5LpuOXT47OL/AXWFR+DVPvfVt2w5W0O/H1VIu7+4zDVCKO2m7/cCGKvERkBEedgcsgmQ3WPSH9nFy0Agd8nIOm+yHjdttFcSCp9UA6id6+ew385dpuVAz6ZY1Ui05bfukabJU1zL6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUtT/CRbGgc/9dv4AwNzRyDzgjKMQcIYF2DdZIlUDrc=;
 b=kxasD+lotYnYLY8+rOoxsdlkB0julStu0s27Vln4vupoRGGobK3YbICHrnN1iwKfo0MipkeBnJGgPTTyu59YPNuTn6WY0tcmtgdn8GB5/Zc64EtHauWIk55/fDygQZ86xWYrcwYPdmM0iE45bV/SAa1qWWKc6Bjm2aBAImlaK5i9AUVb2eilqUc8iTa/naMQOf1AMIfD28+cY/OD6ecRd63VRiFTcKXonSVqfi/2+dqkkfwMlgbCX8QYxDaGMIa5zEH0MD++AcK0BHclCgOLLO8Oxu0lxuFEuKM1OPN23loiwJLPAulAmpYsX5onuqtDC3WfnbrjfdtJolIaMGa+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUtT/CRbGgc/9dv4AwNzRyDzgjKMQcIYF2DdZIlUDrc=;
 b=eyX4ABmQMbLe+4/JtnSdivoCPdbLo7oAi9pxWBAsssXWCrSrzPvO4EjeAGkiuFURf61FYwL7g4FW5hL0Dcc2yxh69z7bhrOIwJmSq7SfCCq1abWNY3qt8wqS3BekHlcjEJL2HuSe0Ytf55BiMj1T2XX8kgJC15Nu7UMaT0srvXVWfv6o0tECCJGQjK9KGmN30kkmR+Y6kgHcUKU9kce5wQsFRsW8T6Gkt0YlhSPNF9+qLJxA29wmQjc0N0ar7sv1VaWS7TQKt1bu/n7ceIzGn4Bt7K5vL+f7GJP0uvShPaz6Bk+UgH2AnLiuBprQ7RHNwOeH3zSmOo254O2Mo4zybg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20)
 by GVXPR04MB10302.eurprd04.prod.outlook.com (2603:10a6:150:1e7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 18 Jul
 2024 08:26:58 +0000
Received: from AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7]) by AS8PR04MB8344.eurprd04.prod.outlook.com
 ([fe80::d3e7:36d9:18b3:3bc7%5]) with mapi id 15.20.7784.016; Thu, 18 Jul 2024
 08:26:57 +0000
Message-ID: <f6255383-88df-4aff-97fb-2504108e300a@volumez.com>
Date: Thu, 18 Jul 2024 11:26:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v3 2/2] md: add regression test for
 "md/md-bitmap: fix writing non bitmap pages"
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "dwagner@suse.de" <dwagner@suse.de>,
 "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>
References: <20240716115026.1783969-1-ofir.gal@volumez.com>
 <20240716115026.1783969-3-ofir.gal@volumez.com>
 <iviiquxyax5ofjcnd7g45wwgbjy7ikikfz5oqdnuz4kf444gno@xpaa42btwok2>
Content-Language: en-US
From: Ofir Gal <ofir.gal@volumez.com>
In-Reply-To: <iviiquxyax5ofjcnd7g45wwgbjy7ikikfz5oqdnuz4kf444gno@xpaa42btwok2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::19) To AS8PR04MB8344.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b3::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8344:EE_|GVXPR04MB10302:EE_
X-MS-Office365-Filtering-Correlation-Id: 254d57fb-ea1f-439c-97a5-08dca703637e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUhUY2lTMGN4dXBjbmNPYkpEdU0xZnBkbkVuKzR0ZVlncXNhRFo2UG43ZnVm?=
 =?utf-8?B?NC95S0tVd1UvUHJ0OTJnRWFOTmlrcXI1Z3RyeTByZ1dyWnJpZlREVFdVYnhs?=
 =?utf-8?B?cHpsVUdFbENKdjUyUnNPL01Dc1VuNjVjNzRKbTkzNXN6N0c4RDVVTkp6ZG9v?=
 =?utf-8?B?R2pDU3R3REVZY1ltYjMrN2g2a0xvQW4yaFFEYnZnbGZhcVU1WVQvKzZPdWRW?=
 =?utf-8?B?YlExVHBhU1BFNitRdHRSRTRqZmRxTUt3clo1b05NUzFsMWU5RG5rai9IWkJF?=
 =?utf-8?B?dVBMTDRENnZQWEhhK2hQV2pKdXNhYndCdHJRMGxRRkhyaEMwNFI5VnB5RDdT?=
 =?utf-8?B?bE9iSzFMYkwvdzV5TlRoa281bXdCZXJhdTZvV0JKRVg1bnZaeE5iN2ZPblY2?=
 =?utf-8?B?NVYvL3RjYmlDRkl4ZFZtK05TaXUyQ0FPS1o2aUlsVG5IN24vaFVDbjEza09S?=
 =?utf-8?B?QkJCU1NmSGxSR3lCQTBaaWVyK3F6WUVCL0lIRThQZkxOdDdpQ0x0L2RKQWsv?=
 =?utf-8?B?bFNvNk1lUXdqZ25SVVFacHVEVjZyVi9Uc0J0YVVGanZTV0s5VlhhWmVaR0s5?=
 =?utf-8?B?TkdWaTBhSGs2cFJWT0NROS9CdGROZGdYbm4reDRxZlJ0S0t5bHR3bHBINmw3?=
 =?utf-8?B?MjF2QitXOU5UOW43UVBwdEtCbXhGUFRsdHA0S3Z0K0RtZDhMWHNZUDNDb2oy?=
 =?utf-8?B?dlArWnF2Zjl2bFVoWi9ITktoYkc2dHQxWVlzclR1WUFKSmhCNHcxWHVWcENI?=
 =?utf-8?B?V1F2U3l6WHBKd0Eyc09rSzdPQUZLVG94L09GcDVZRWZSSUwreHA3aVhuNjNF?=
 =?utf-8?B?UEhEVWp3WUhBQkw4eFZpYTdqVjRNbDVUTDcvSFVuZDFNNTlkdHpsUkc4cWN4?=
 =?utf-8?B?dlVRU1BEYjB6VGNhV1Z2MU8xaHpvWC9vdnRtYk90bk84VlRHOWxmVEl1aksw?=
 =?utf-8?B?bEpCNDhnTXlrTktLbnQ5SjI3SHQzWnBqVkRpTUl6UDVxcWZ1T01Tb0d0MFJ2?=
 =?utf-8?B?U2F3aXpNc1J0blArNkdXTEN6VGNVYzVwQU5zL0VoeitLOFNUVW1WWjJVUU5w?=
 =?utf-8?B?QjJmOUpnRDRLY21mT0k0MUxzQkZUcU1XZUxIb3lodDVld1V2Q3VOdmFVQ0Ns?=
 =?utf-8?B?NzNJNEhHcjFLQkFVb1lzYkcwT3lUb2NPN0NzTElJa1ppbGlBY2xVbSt4TFJj?=
 =?utf-8?B?akcyTVdLSFR1cFIxU29kdUs0bTc1ODZFNitPZlpQWHZyWlprdEc5RnVvNlBp?=
 =?utf-8?B?M0VPb2ZyanFkK0NzWlp1Q2JPcStaUzFCT3lYaHNWeUxHYmZmRlU5SlRQZlo3?=
 =?utf-8?B?d1NZNVMyMFRRVDJJSmViaGczNHRrT0oyUXQxdzlZODhPZ2h4S0FOYnhUeGwv?=
 =?utf-8?B?OTAzQmZLdG5RdHRaUHBvYktpWEVvdXVVNFdKZ3hhSEZaT2x3a3Z5RkpsOEc0?=
 =?utf-8?B?SHNETkVhSXpTemtndzd5cDRqN1YydzNmMzZLeWNjUVJQRWRZS1ZEOXpRSFB5?=
 =?utf-8?B?UTFhMmZLNUM1c09wcldXN0ZMODM3cnN2bWFuYnFYazVHazVzUllBR1NCSTNU?=
 =?utf-8?B?Tk01UFlUSXJydTI4RkV0cG04MWdUR0ZodHJYclRYZExqaVUwN0Vza2FFcE5k?=
 =?utf-8?B?dGJBcTZ1M0FpVHFQVklsSTUwMG5zbFhsbmduNXRtMEoxb2NXUTQ0U0ltNkp0?=
 =?utf-8?B?NUsyZDJYUHZWeHAwQ3lsak0rWERuQXNaREVocVpyU3RVeWs5Z0dEK0Z0dHp1?=
 =?utf-8?B?QnlPQWpVSkROTVF4VklvdHZKajg4NzJvZEJXUVRmSmFXQVdJcVRFQW9JLzgx?=
 =?utf-8?B?RTdiL1RKcENVQW85ZEYxdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aUFwUXgyQUFmL1BYMXJkMVREWmdIU2xUdC8xMHJZdlhlSjhSeHpobER5eFlE?=
 =?utf-8?B?TGhUQ3Q2aktZcWtHeTFSeHRFYXhMem9MTEhUQ3RpVk4zK1RuZUNsOStvRWUr?=
 =?utf-8?B?aHVEa2NjZ0JSZ1VnWkxEZmoyNFkrWTZjL3dja2o0ZFFhL2UxL1orZFNrMUNP?=
 =?utf-8?B?UjJEb0RVbjE3djhjVURDNkgxTjlEcUt1bDNpc3JYMDVoK0hFWlMxZ3M3aitR?=
 =?utf-8?B?U3lZQXJNTE1ORFFBcTRtSjZQZ2RjU2FwOGNSUGFNcnVHRmZPRUNiWTh4amM3?=
 =?utf-8?B?ZnVYZVJ3Y0ZzeXpTZk9rZUhQTkJ3M2ppZWRVQWR5WWc5aEhtNllXUlJpZThJ?=
 =?utf-8?B?KzJ1dDgzejFLZnIzNGJMWDhzeDhwQXJNVHlTMFJxNGFLdDJZOHdybTc0Mkcr?=
 =?utf-8?B?NjJVbXlUNFNLc2hxNTRkVmtuWElZbGRGeTRlQ0xWaXRDWU44NldlcnQvcDkw?=
 =?utf-8?B?QXRyVFBVRnYyZ0hSaTl0WVRzcVZKSmNwaU44NnpEckZoMUg1Z0thSklMcTAv?=
 =?utf-8?B?cVhXNU4zdlBwamVoUDJGWlQvVXJ0YXIxTUNYL0JkM1lEL3NJcWhRWjAyeGdl?=
 =?utf-8?B?YnRkZnlubTJEZHEwSnRIRU1xYWVIM2d2Q0FJVGRRRXZwWVIwNVZQa25PZHF4?=
 =?utf-8?B?N1RDVlA5RW4ycnpqUHBqdExSOS9BQXBXb2cvTDZzOVJQTWx0L1Vnc2VQZVBs?=
 =?utf-8?B?YmhHcldkYzZSRUNBMEY0L3pId0xQejlsd0hsUXhjUjc4ZWRIVWpWZHZ1eGp5?=
 =?utf-8?B?ZWhPTFlud0ZVTkJWNisyVHBpakRVdFZlTTBidTlTY09GTFFKdU5iK0xheVZ4?=
 =?utf-8?B?NEllSlkvNjJkK05xTlhQODBCd1F2K2FUem4vQjU2NVRraW4zTjdqMUZWMjk0?=
 =?utf-8?B?S0FrTFQ3S3J3bFZvNHNITHltSnlJdHErN21JOHN3QWxwb0VMQUhROFYxUHZR?=
 =?utf-8?B?M1F0ZEpoZ0RKK010d2x4QW13eEtnNVdpdml6NC91WWZBbUo3Ui8xY29GRmdM?=
 =?utf-8?B?TW5zd0UrUUlvUUhQTVYxZnU5YWJvdUZaVlhxMzlxeGlvWWh5T3d1MGVPTXVW?=
 =?utf-8?B?UVRVMGhZUm5JTWlWSTVERVRCVExCQVVFekV1TWdvMElYRWJ4ejF1RWgzL0hI?=
 =?utf-8?B?ODdGME52TVRaeWRUbFNjVDI3KzhhUHQ2N0p1VVkxTlVlL0ViYm45dHhvTU5Y?=
 =?utf-8?B?TWRTNVFUM0R1ektOaVBEeXAyWnFKZlgyMytBWE9DTFVLQnNqQVM2aTZiMzRS?=
 =?utf-8?B?UWRnSEJMVkdGY1RlYUZVK2t4bFdOcGJXZHhnOUVlSTNnZlphMVM5MVdYS1p4?=
 =?utf-8?B?R2g0TUdITDIvMDR2dXpIK01tVUtjem5RV3FmOWxvS0NtWmgzU0lsV0ZDengx?=
 =?utf-8?B?OUVZSlRIdy85bk9Fd3Vka3BKcWlGVjZveXptNFEyQWxFVWw1VDZiVmR3SE9s?=
 =?utf-8?B?Y3JDclhvTHRjditYcGhZN3VGN0RVQWVFeW8xV1A4ZGRvd2FWdk01MXc1QjhB?=
 =?utf-8?B?bHkrTlZhRWpLRlNnRjVpVkpxeXZmYmlhRXpMQVFNa2hSMklxTzhoNjRqMXo4?=
 =?utf-8?B?dHVNK01iYW91c3k3MFlnUllBOTJQVGQvcW1YaVZRT2NBL3NGR09WbkswSUF3?=
 =?utf-8?B?OE55TitQN2NOVVRQQ0JQN0UzUlAxUjYxalc4NGNXOHlyYmlEbjNna2JhalRE?=
 =?utf-8?B?VnZ2S3IreWRGOUcvdFIvNHhaVWRnUkRpQ1M0dXBzQjNrVkRtSE8xUGhra1Zw?=
 =?utf-8?B?bmoxTTc5TjJ3ajZOODFKdk9IUWV1Y2xodU9qK3JUaHhSVXFFejBoY0hEV2w5?=
 =?utf-8?B?ajNzN1hQT3RDc3h5dE80WDZ3MFhJVUxxVSs1MWNYOEtZdENON2IxTThLdWwz?=
 =?utf-8?B?UTc4amliUWF2a0lOa3JzZm1McGlEeFhmY2dyNDJXcldGSVd2bXJqbWpZaHd5?=
 =?utf-8?B?S0ZtaU5MQkxTUVRvTjJwaUw2U05CQVJ3M01iZ3E2b0lpaFpiT3RUUmk1N1Mv?=
 =?utf-8?B?cDB3VXFyRG1kV1NKbDFmMGdHeFdZV0RnUUN2K3MvQnFVUlRVNnE1KzNsMitj?=
 =?utf-8?B?TnRyNzBnWWw0ZXQ4dlVKMEZiSklscXRWNFFZNUEyenc4bzFMS0hxS245RFUy?=
 =?utf-8?Q?K79jUDsfyFBUauM2vjwGR32R3?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 254d57fb-ea1f-439c-97a5-08dca703637e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 08:26:57.8677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCZ/CA/Y+pFwqsBhN4D9/hCPxUCH6v0+zghWu/Z2cVCcy5U6PzHy1UVmLAO5ojhhrPtmNL09ob3tUEXHUgpyYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10302
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_012713_483907_150AB5ED 
X-CRM114-Status: GOOD (  22.34  )
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

On 7/17/24 10:41, Shinichiro Kawasaki wrote:
> Hi Ofir, thank you for this v3 series. The two patches look good to me, except
> one unclear point below.
>
> On Jul 16, 2024 / 14:50, Ofir Gal wrote:
> [...]
>> diff --git a/tests/md/001 b/tests/md/001
>> new file mode 100755
>> index 0000000..e9578e8
>> --- /dev/null
>> +++ b/tests/md/001
>> @@ -0,0 +1,85 @@
>> +#!/bin/bash
>> +# SPDX-License-Identifier: GPL-3.0+
>> +# Copyright (C) 2024 Ofir Gal
>> +#
>> +# The bug is "visible" only when the underlying device of the raid is a network
>> +# block device that utilize MSG_SPLICE_PAGES. nvme-tcp is used as the network device.
>> +#
>> +# Regression test for patch "md/md-bitmap: fix writing non bitmap pages" and
>> +# for patch "nvme-tcp: use sendpages_ok() instead of sendpage_ok()"
>
> The cover letter of the series says that the new test case is the regression
> test for the patch "md/md-bitmap: fix writing non bitmap pages". On the other
> hand, the comment above says that this test case is for the two patches. Which
> is correct? (Or which is more accurate?)
>
> When I ran this test case, it failed on the kernel v6.10, which is expected.
> Then I applied the 1st patch "md/md-bitmap: fix writing non bitmap pages" only
> to the v6.10 kernel, and the test case passed. It passed without the 2nd patch
> "nvme-tcp: use sendpages_ok() instead of sendpage_ok()". So, I'm not sure if
> this test case is the regression test for the 2nd patch.
Sorry for the confusion, either one of the patches solves the issue.

The "md/md-bitmap: fix writing non bitmap pages" patch fix the root
cause issue. md-bitmap sent contiguous pages that it didn't allocate,
that happened to be a page list that consists of non-slub and slub
pages.

The nvme-tcp assumed there won't be a mixed IO of slub and
non-slub in order to turn on MSG_SPLICE_PAGES, "nvme-tcp: use
sendpages_ok() instead of sendpage_ok()" patch address this assumption
by checking each page instead of the first page.

I think it's more accurate to say this regression test for the 1st
patch, we can probably make a separate regression test for the 2nd
patch.

I can change the comment to prevent confusion.


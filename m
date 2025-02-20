Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AFFC021B2
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Feb 2025 18:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eOVD/Qh3uF9uZjmaOj7sBVFORmFWWT+3YMkHxiTuk80=; b=vfcWNgxLH3nLHwC8ECyhQ56uvI
	sX8+gfpe5DM25ZjeKFa8rHhH9kuAkTkmOMqMS858KgBZX9EoQhQJeG4RvduA55YskOcNp9Cb16Jmd
	TUExnigJaCp/xUFR7lSn2LsGTSK6KJijfqufINaN24kMUNle7kUsJxQnmJj1nnUYVn4D4PL+uHnFG
	8fSwsEHeyAgImC50CbN9fGNnafntWR/Id/0Tnlc2TfaTxH/6YV8WCczDu30u01UTsB15kdS2XUG3Q
	ywsJ2q9eTP7oUT9FZYLSEFJjFtMOOlr8+j4kSBeb+tqTuxeorqNIMnrzz3qe2Ew7siX2jmX1ij3mR
	tJ24DSVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tlBM2-00000002O8Y-2fcA;
	Thu, 20 Feb 2025 18:32:58 +0000
Received: from mail-dbaeur03on20731.outbound.protection.outlook.com ([2a01:111:f403:260d::731] helo=EUR03-DBA-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tlBIT-00000002N8k-2O7g
	for linux-nvme@lists.infradead.org;
	Thu, 20 Feb 2025 18:29:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aCk+L2K2ku48JlhCji1PgvZrV5qBJNs3rc7uyXlaVghbeXu+8GCfe013WIHnWgOa433deM3X3VWOsWKBfLwrGSFR6yvNl1pnwCA9KzlKz9VkTfY/52Bk720j2xAmJwmpvuPNre0eQyhwCtg6L0CBuTKEMt3mmV8gpNVtKQjUw8pShO86T5KBPWOvl+btjnuASDxALyz8FQ2wn0ID1K9z0Os36IbLHSGCQctogKM+K9QGM/n6/LC6TpV74O5HnsnA8/hTssYUTGNUWFSFZ2h8cgrx6VPV82gucYuF6WHkAzJejWl/ba/WDGCEc6mS6C0YuV6V+63uYzaCGkz+2ubwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOVD/Qh3uF9uZjmaOj7sBVFORmFWWT+3YMkHxiTuk80=;
 b=br8MHHOp7Xp6WjCdhw+fbA2FdskkVoSty63zVrS66UNAfppy6BqOkFJxMjdCt2CShxVUY60dnL3EjtJ13Zlbhhgua8OPtUmXpVjhMfi7tWMxmOGzLySwjUg4GU2dJVzNEs1lMOD+RHn0aDoSsXCLl9J1C/oGmwWBPK7A3u1WG752spRavqeThuk8Vs9iJjMxfhTDhXbSM32yjfOUpGzalxN4DXJ3XzCM7vCu6zTOrnn+TYwrTUD3P3Y05HgQw3H7Qxyry5QUr9He8P7aUDD5A0SRAk6+IWrtTTf5MixNfH6J3YD3G/GY7qoXAdEKEwZ2VKBcO4iDZy6vNgp4oCx9Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=volumez.com; dmarc=pass action=none header.from=volumez.com;
 dkim=pass header.d=volumez.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=storingio.onmicrosoft.com; s=selector1-storingio-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOVD/Qh3uF9uZjmaOj7sBVFORmFWWT+3YMkHxiTuk80=;
 b=MOpm/NM9nabb0nCBcdSskz2DL2/yfMfvduH9LelJ8sjSONgp0QUBzSuCOpDdnJJsu0JX4KR3mBvZCYGCkbEZH0lK0r/W6h7e4HBh/f7ElxG769IKYqd4j21Zg35r6tGROXapixqToAgelpSMoHJknugJHJc9pFx7TGw+HFzH3jnHyOGv27z8siw9JB50SxK9xyF6s+vMZFQk4usCXxPQJrEhbRsnigvL3gmnO60OmaFTUP1xeIfW64tKyJfKsmqxqdhAj/Pao3u3e27I0f5d0x/nHxZ9gHjKVM9o4sjNVJ4DkuQqkpvo8j2F/dPtTY0W3ajtk23WSI68cY7M3yXzog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=volumez.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by GV1PR04MB10106.eurprd04.prod.outlook.com (2603:10a6:150:17d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 18:29:02 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%4]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 18:29:01 +0000
Message-ID: <25589eeb-8faa-46c2-83b9-de0ff2bd4350@volumez.com>
Date: Thu, 20 Feb 2025 20:28:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-tcp: Fix a possible sporadic response drops in
 weakly ordered arch
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20250220115409.3271289-1-meir.elisha@volumez.com>
 <CADUfDZr70ANBX1N0b34=fyHa=fgBzN=kF8hT4hvtzZ5Dv8fH7w@mail.gmail.com>
Content-Language: en-US
From: Meir Elisha <meir.elisha@volumez.com>
In-Reply-To: <CADUfDZr70ANBX1N0b34=fyHa=fgBzN=kF8hT4hvtzZ5Dv8fH7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0026.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::13) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|GV1PR04MB10106:EE_
X-MS-Office365-Filtering-Correlation-Id: 55e32197-c71e-4cfc-5bb7-08dd51dc729c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M05BS3IvOXN3clBuZkhrZDlkRTdvMnhkSTRxR0Q5UWFBQU1IR3AwdDVTVFd4?=
 =?utf-8?B?K2YraFJTbkNNWFRBSUZFWmhLMEJGa0xpaDcwUU1aMjA1Y0hTcVFFZG92ODZC?=
 =?utf-8?B?RGlwYm1pRHROZ3V4TlRKTzhQL2gzbU1nc253T21QVXdnRlNlUzRXNExlODBU?=
 =?utf-8?B?WEhTakxQem5KcHJBTjg1V3h6TTdDdHlyNVhXQU9JNFZWeVJoUjV5ZE9JeWtr?=
 =?utf-8?B?VVo2UDhYck1KWHMwNFhwa0hpQ1l1amFaVUExV3o1dC9zaEVzTjA4alJlZ0Vu?=
 =?utf-8?B?YlloQmZoWmE4eXdKQnZQeDJsWUJFenkxckpKRnBDckc5eTdRSTRDNHVOWG1X?=
 =?utf-8?B?WlhSUHBQN0hBSTRadVREb0lqY0s2ZFRuUHFINVMwWnJRSmJNSjJreVFQdThN?=
 =?utf-8?B?MGprZnl2ZkloaWk3TlZLV1RVdktaMnArNmxtREJrUjlncFFrNFAzdzc2eXhv?=
 =?utf-8?B?ZWIwODZQY09SYmRhVUlkZVdRVXBNb3MwQ3dDOGJpNjZkaWtlTG4rd2FGYnkw?=
 =?utf-8?B?NmtPZkhnbEdEWHRGakNpL1lWZlZLSURld1JYVnpOT2x3WUp3WDl0ZjRjVzlO?=
 =?utf-8?B?QTErbDBNc0ttV2hpYU1LeGlheUFRODdWNTJIUmxPRmV6V2hMczNRUVFpZnpJ?=
 =?utf-8?B?MEpXRmxSc0x1MG92Y2o1YjE5Z1ZKT0pkNE03Q1JaaTkyb09YQkpYWVlBSnE0?=
 =?utf-8?B?YUE0VGZrVDE5Q05qTCtRTjhFUjJWaXJwaUZrOUhFNFhKY0NSaEhvaU0rY1Nq?=
 =?utf-8?B?NkRnaUl3bmdkUzdNdVpZcW00N2VsZnd2ZmtJQ1Y4RUR5YmNUQThVUzFXNDNj?=
 =?utf-8?B?OThWTUVQeURwSG5ITlNLVGJZTTk1Y01zZHYrRTVZV0taSW10TEdjdHB0L2tn?=
 =?utf-8?B?NGQvY2tVRGtpQUhhT0R6bGhQTG9tRkpDeS9ZMGFndEZOMytjdC81dEtzMXo0?=
 =?utf-8?B?a3BiMUZvZFZCeWlzcU1MaCs4bnRyNHBIdkNCL3V1RHhtOWQrRlZ4OU8xMWZH?=
 =?utf-8?B?Z1hnMHpFMWFGd0JvaFJEWUtweVo4cUdoclVLWUd2WWQ4NHRNVE00ckRYMVY2?=
 =?utf-8?B?QWtadVovdlNvVjRRNnUzZ09sRm9yeUJNOSsxSVhuc3JlbXFEU2dxSFp0aGxQ?=
 =?utf-8?B?ZVlCK0xqZThnK1N0RjU4a1p1ZEg4RXViRFovdis2ZGtObS9tRTI2NG9DWEQ1?=
 =?utf-8?B?azJJT3VDbzNQRnFKU3gxcnkvTjFEbkdNMVVyelNlbEt3R2ROSC9kS0VLN0c0?=
 =?utf-8?B?dTFmcWF6cUNTOUN6N3FUcFpIaWp4SHBWZkJtbHpjT2xUZ0cvckE3YnNwNWUz?=
 =?utf-8?B?ZmpncGtZUktYMTZzNFN1aXJSOVBOd0gzdy9pVmhhTGVERlBmbDBlcXhyUVkx?=
 =?utf-8?B?NzUva25YTVoxVWIzR0RJMm9iQjlIUXRKMDhFWmNOM0JjVU9vckIyWjdQNlda?=
 =?utf-8?B?dFVVSitEVkJ0Yy9ydWZqY2VBYk1OKzE4N0FBV0M0ZHp0TkxFNVBqck1TWGtL?=
 =?utf-8?B?K2N4OXpWWUs5dVAyaHJXQkJmdk9SakZHQWU5RG9WK0I0ZVJ1eEprZXVjaE9v?=
 =?utf-8?B?ZTdObkplMzM3djUyQ0c0T282ZnpZQ0c0ZjJTaVJtcTNQMWZNbGJURVdvSGpK?=
 =?utf-8?B?U0RJSGtkcUU1R0J5ODgwa0J0ODVmaFA5RjFKOFhrUktDYWx5SHFzTEw5TWEx?=
 =?utf-8?B?N2YxQ0gyampuVEk5ZmFnSFgycFBzdllxK0F2cW5YOW81VHFvTG5VZW4yMHlO?=
 =?utf-8?B?U3JIVlBmbFFOVVgzbnhRV1pVdUN1Ti82RDVlRzRGMFRnN2VJZzRuRkMyQ0Ur?=
 =?utf-8?B?TUNDblhNUFZ0RURxRGwvUVNoY1BCamZVYm1vMzVIeXFMeFVtTGI4QWwxMzg0?=
 =?utf-8?Q?uvCVYY8JXbFYW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHhLZ3VFS0lTdXFQZGxndFduUXU0OHlqb0dWWVF0WE5pUHozUkpnWTd0MjFv?=
 =?utf-8?B?WHJ3U25keUc3VGo1blByckJQdis1dDlSS3VWSGR1RDkxczIxNmk2VzhjdmhP?=
 =?utf-8?B?OThsczFGOFJsQk92amM2dmZFcVBjQ3dSUXZhdHFBRjNZb0VOUm1BQThBdUls?=
 =?utf-8?B?K3p5U2x4bG5VSnViZFRmMlhLaStJbDh0L2lpTnFuTkcyeWV6WXBPWDRwa0Iz?=
 =?utf-8?B?MEo2US95bXdwaytFazBXcXArVHdNTjVhajcvSXRkUGlwTW4yYVVYakJmSTAr?=
 =?utf-8?B?OHM1S1U0UjVGdkZaeFg1c29YbXlHbkNTcjYvLzZyWno4VE1PZ2tVZ1gxZGpl?=
 =?utf-8?B?NThZYXE0UWtUZzlQdHdmZmZ6ck5iSDE1SjVqSkJsY3hQK0g0SWt1TGI1bzNz?=
 =?utf-8?B?WUVBVlNjRlNKZDJuV2lkSjJFVTA4WENFQm14QWM0Rll2aWNGbUh2UDBYejRL?=
 =?utf-8?B?ck1CUzd3cFZXbmJMTzgxTmRneENLTTQxZzhIR3Nsa3dkaHl1K0V2OVN1UWdW?=
 =?utf-8?B?K3Y1YTNQeFNTNlpvNktSMXMzdDV6Witwa3VPYjA4eDUrMkFndmFYTGtWbFFK?=
 =?utf-8?B?a1ptSzRNVGVIVjlFaHV0Y29ZZDhDR3plMEtJaVBMZnh2RG5FQ1Y4b1hXa2Fn?=
 =?utf-8?B?Zk1TTHBlbjRNMHVYdkpBVnNCVHA4WUE0bDBJb0o4VFBTMWN4VlBxa2NRZEhU?=
 =?utf-8?B?MmZIQXBlUWkvaEtINWpqNkE1QlJDdXJXaTBXUVEvaXVxUmtWQzNVZ3l5QWNz?=
 =?utf-8?B?dU03R1psVlAvVDNCZ0s5a2p3VGo4WHcxZlFpUmFrQzBnY3E5a2JYUHVOZ2Qz?=
 =?utf-8?B?eGNZOGVjNmNIR1dVaGFma3V4WXpWZVB6K2tCd1g2WGVMczVMdTVrRWlLUWxR?=
 =?utf-8?B?MkZzdVBwNDVhWmQ4MDA0Vk9YOTJYNXBiY3lFem5NRkRhSTV5a01vWHN4V3I0?=
 =?utf-8?B?dmRZTGNKUUhGMGFwVG1nOGtaNkw3MFloRDdaSE9maDZuc2pxWERNQXJIdHMz?=
 =?utf-8?B?am1qMm9NeVBKeGF1eGVoOGVoQ0pNS3VrYXpHVWdoZmJXS1ZHa2w1STRCVzAz?=
 =?utf-8?B?amgwYzdkRDZxV1lEcjAyRUprRFVCbHhreTZ1VjZ0UUdSVUFPVXVSSlRSQ2lB?=
 =?utf-8?B?VXVCdnJQSm9pQzEwOWVYb09IbWRWOHM4cDRrSVV3TzJrRWNOb2dweUNvdmlu?=
 =?utf-8?B?U0dxL2xRUDFCTFhSaDJscU8xVGRwL1pUMWpreHJ2MkE4ajJNbDg0RkgzdWU4?=
 =?utf-8?B?NGRNLzJxK0QyR3lqVHhaS0kybXArd0k4V1NTYUVnUERsOVF6Z2JhcWswVjZ2?=
 =?utf-8?B?RnJJVnU3Q0F5cFJZUDZlMC9KR2lyMXJvZEk0L3FMNm9xYzdMcGVXV0Q2bWtK?=
 =?utf-8?B?bkdOQTZZMHFhUERQM1k3bDkwMkFOYUxjaEphOU1xdEErcDVka0x4Q1pDeWtF?=
 =?utf-8?B?clZ0NkFRYlBKWlVWQk93RVgvc0w0YzVZYkIxWmNJeW95bTJNYzBwam1XK0Yw?=
 =?utf-8?B?RjRTZUY5L0FpL0xOVVJkNmRUUTFZengyK3lheTNCczQ2NkxET3FqaFBVeXFG?=
 =?utf-8?B?VFRHMW5hSUd6bExhWStqbmloOWxsMGIvK2p6YmxiK1h0T2x0RkVvdk9OOHRP?=
 =?utf-8?B?ZXZETStHTldXMnNOVFVXVnoxYXd2NXlqY3E4UXNEaVV6UEZMWHl4ekxpTnNY?=
 =?utf-8?B?TUFONVZBa2VPNldqRXpTYmxrekJpaFNkMUJna1pVbURHMWdsWGZqY0Zvd1RO?=
 =?utf-8?B?S0diRnk5Q3d5RnJteUJJZDJOWUtnVm9NSTIrWGJCL0xNQlBoeVM0ei9sMTRm?=
 =?utf-8?B?VTMrQ3U0aEVRdXZwSlZ6ak9jK1pMek1hQnh5Tjg2aXpWMklyNUc1M3EyM29L?=
 =?utf-8?B?dlJoQVJDZzJuemJsbjl3R2w1NHNORG9RcU01M25YQ0dJWUphalFpcGJteWtz?=
 =?utf-8?B?QkFvcHdudHF4SjlFZHdRV2NBQXJyOVhsSkE4WlRLN0JxSk1Bci9tRUkrWFJo?=
 =?utf-8?B?aFRNN1d1MjgvMGZUdEwyS2tCSnFQRVE2T1phVmJiTVVhakdJOVliMGVnTG9P?=
 =?utf-8?B?RStpaWY2SHF3d1FhbzArVU1pb1Y0NmRBbWY1SityRm5XSHJBTXBFYkUzTlBK?=
 =?utf-8?Q?6j46fv38RL2WGRRk66XauibuI?=
X-OriginatorOrg: volumez.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e32197-c71e-4cfc-5bb7-08dd51dc729c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 18:29:01.5818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b1841924-914b-4377-bb23-9f1fac784a1d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMQyLc8zIbDWjbQYyHfGIZj8UHLTc+FxzYkW03pEPOup+D4OfMV/WI1uM0aavkVivf/JNUxyDBRPqo7d7IPYfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250220_102917_776813_2E130773 
X-CRM114-Status: GOOD (  31.96  )
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

Hi Caleb

Thanks for the review. I'll resend patch after testing.

On 20/02/2025 19:17, Caleb Sander Mateos wrote:
> On Thu, Feb 20, 2025 at 3:56 AM Meir Elisha <meir.elisha@volumez.com> wrote:
>>
>> The order in which queue->cmd and rcv_state are updated is crucial.
>> If these assignments are reordered by the compiler, the worker might not
>> get queued in nvmet_tcp_queue_response(), hanging the IO. to enforce the
>> the correct reordering, set rcv_state using smp_store_release().
>>
>> Fixes: bdaf13279192 ("nvmet-tcp: fix a segmentation fault during io parsing error")
>> Signed-off-by: Meir Elisha <meir.elisha@volumez.com>
>> ---
>>  drivers/nvme/target/tcp.c | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
>> index 7c51c2a8c109..4021468c8857 100644
>> --- a/drivers/nvme/target/tcp.c
>> +++ b/drivers/nvme/target/tcp.c
>> @@ -571,10 +571,16 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
>>         struct nvmet_tcp_cmd *cmd =
>>                 container_of(req, struct nvmet_tcp_cmd, req);
>>         struct nvmet_tcp_queue  *queue = cmd->queue;
>> +       enum nvmet_tcp_recv_state queue_state = READ_ONCE(queue->state);
> 
> Why did this change from queue->rcv_state to queue->state? Doesn't
> look like enum nvmet_tcp_recv_state is the correct type for
> queue->state either.
it was by mistake. should be queue->rcv_state.
> 
>> +       /*
>> +        * Use an acquire load to ensure that any updates to queue->state are visible
>> +        * before loading queue->cmd.
>> +        */
>> +       struct nvmet_tcp_cmd *queue_cmd = smp_load_acquire(&queue->cmd);
> 
> Acquire ordering prevents memory operations that come *after* from
> being reordered *before*. It does not prevent earlier operations (such
> as the load of queue->state) from being reordered after the acquire
> load. Additionally, an acquire must pair with a release store *on the
> same value* to have any effect. But the release store is to
> queue->rcv_state, not queue->cmd.
> 
> Correct uses of release-acquire ordering generally look something like this:
> Thread 1:
> Non-atomic store to A
> Release-ordering store to B
> 
> Thread 2:
> Acquire-ordering load from B
> Non-atomic load from A
> 
> This ensures that if thread 2 observes the new value thread 1 stored
> in B, it will also observe the new value in A.

Thanks for noticed that.
> 
>>         struct nvme_sgl_desc *sgl;
>>         u32 len;
>>
>> -       if (unlikely(cmd == queue->cmd)) {
>> +       if (unlikely(cmd == queue_cmd)) {
>>                 sgl = &cmd->req.cmd->common.dptr.sgl;
>>                 len = le32_to_cpu(sgl->length);
>>
>> @@ -583,7 +589,7 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
>>                  * Avoid using helpers, this might happen before
>>                  * nvmet_req_init is completed.
>>                  */
>> -               if (queue->rcv_state == NVMET_TCP_RECV_PDU &&
>> +               if (queue_state == NVMET_TCP_RECV_PDU &&
>>                     len && len <= cmd->req.port->inline_data_size &&
>>                     nvme_is_write(cmd->req.cmd))
>>                         return;
>> @@ -847,8 +853,9 @@ static void nvmet_prepare_receive_pdu(struct nvmet_tcp_queue *queue)
>>  {
>>         queue->offset = 0;
>>         queue->left = sizeof(struct nvme_tcp_hdr);
>> -       queue->cmd = NULL;
>> -       queue->rcv_state = NVMET_TCP_RECV_PDU;
>> +       WRITE_ONCE(queue->cmd, NULL);
>> +       /* Ensure rcv_state is visible only after queue->cmd is set */
>> +       smp_store_release(&queue->rcv_state, NVMET_TCP_RECV_PDU);
> 
> Is this also needed in the other places updating queue->rcv_state and
> queue->cmd, e.g. nvmet_tcp_handle_h2c_data_pdu()?
nvmet_tcp_handle_h2c_data_pdu() doesn't set rcv_state to NVMET_TCP_RECV_PDU.
the other context wont exit early in nvmet_tcp_queue_response() so I don't
think we need it.
> 
> Best,
> Caleb
> 
>>  }
>>
>>  static void nvmet_tcp_free_crypto(struct nvmet_tcp_queue *queue)
>> --
>> 2.34.1
>>
>> This ordering is critical on weakly ordered architectures (such as ARM)
>> so that any observer which sees the new rcv_state is guaranteed to also
>> see the updated cmd. Without this guarantee (i.e if the two stores were
>> reordered), a parallel context might see the new state while queue->cmd
>> still holds a stale value. This could cause the inline-data check to
>> return early and ultimately hang the IO.
>> Additionally, I reviewed the assembly code for ARM and confirmed that
>> the instructions were reordered(unlike x86), reinforcing the need for
>> this change.
>>
>> This scenario was encountered during fio testing, which involved
>> running 2 min of 4K random writes using an ARM-based machine as the
>> target. We observed hanging I/O typically after 10-20 iterations.
>>
>> fio config used:
>> [global]
>> ioengine=libaio
>> max_latency=45s
>> end_fsync=1
>> create_serialize=0
>> size=3200m
>> directory=/mnt/volumez/vol0
>> ramp_time=30
>> lat_percentiles=1
>> direct=1
>> filename_format=fiodata.$jobnum
>> verify_dump=1
>> numjobs=16
>> fallocate=native
>> stonewall=1
>> group_reporting=1
>> file_service_type=random
>> iodepth=16
>> runtime=5m
>> time_based=1
>> [random_0_100_4k]
>> bs=4k
>> rw=randwrite
>>


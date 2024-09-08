Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327CAE6FE49
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Sep 2024 13:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:Cc:From:References:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w5jT/sv4oCu6Tu9PZUs6fF45SuLN89ROKDq/JhVJlgM=; b=fSSlZ8TRqFfC3JDGUyC18p5qeb
	hiji/lhvuHBapcgC/3T6vLl/QWD/xjyqFYlBgkcPt8lmUfMha38pkzr4sZUX9FtJF7XWzX11yUqoB
	U1tIMQTt1AGC9pZ35Sjd3+qARohuabNKDCnMou1aYhboJV/TN96CTeQIvmYC+Bws8976GrHuokoup
	iWehFARpxnkIlIEqI3gXQ9ew5wL81By6mfMGgvqcN1g25mCy02oFSeALj2dgtt9zJWQnhOw3laqT8
	Ai6QxI/j3TcQ6uGujtc9nYWtMWlEeSFofvD4E/t12BJPRhBXqdyYGWJCTl8Cn+XrRwC6Z3gVMtE2T
	7Ie4vEsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snI5y-0000000GrZd-3B1W;
	Sun, 08 Sep 2024 13:36:50 +0000
Received: from mail-am6eur05on2062b.outbound.protection.outlook.com ([2a01:111:f403:2612::62b] helo=EUR05-AM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snI5u-0000000GrYu-45YG
	for linux-nvme@lists.infradead.org;
	Sun, 08 Sep 2024 13:36:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWPF+w1MsbbPGVnNm3m9tLbpBAPb9S9ZpFQvjN58HyH3lKBWCgt0H2zJOu4zareC3smcHVFyze91pkZyG+U/Lu6NNxVwVEpLyHvGQjfFuRt99TGLTZkvD9lc8x6C5x9xAE1W+uJCB/1JkuqRP1D7moUr/dpCGy0QlHAP7voHPzP5IdhTePg/iluml5mhYHcGV4LNROgwBzsWMLIB3no/ptlCilyR4RuOi/04B501SDgYMbs1U0x+ejKsraZoR0jBPGIQz+IfwFQ1SCsT7sUsI+lBOgoWznRwUYfzkVD5DXiFdzxwC3cxMy0WaJuDLhe5b6y4JypeujzAhW8h35Q3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5jT/sv4oCu6Tu9PZUs6fF45SuLN89ROKDq/JhVJlgM=;
 b=iI5DyAfqbXqTgifVzQy/sd2kBJ3vryjMdhOwDf2jn3e0bJxk+MnQWjp6wAbsgzxd89XBdtwig7SqBmA4sdqpdwI32gHipLpCWLAZCfLk/7+fyBYasfeEPUXpbMbM4lW5at7eIzwp7Rlju+znkoMixdtovr9LPUNXbD1iS1dUjCo3dTLmxRL1FUa8xuyTsuA6SWBuWUMndZsfFIoC3bsWlgXIFRNLAWWJcLrRBXYHrBA7jGNQYUXTW+DrAhXFPTq4/zTXgzjLvWr0ITDlcE4fiUy659YrM8h854wIveXrm/j0vMxsNxbTpcmHLtlR9UydqR2/x+2X9+SXTvSIxvWxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5jT/sv4oCu6Tu9PZUs6fF45SuLN89ROKDq/JhVJlgM=;
 b=wmGnlHh2+auGZTeyQDO3c/uOauUhVC301TZ5i4prd1dqQ7ibmgwyi3yZEYscOQwsO0/QLK0T1E4EqBBPMsL+oRsyIuB7bX9yGT3hBaljIYpsC+hms3nAagIWpU2hq95kFBqRA9k42Z13reE2XVYe4/wK8dL2n+YWC9ZFqhEM72GvUzF9b84Iy10BkjxOUdIfugh8U8UGgB1NLnpS/PJdpJIQ1Fzn3wn2496e4mzxlPzMO3i7kxKc152YwGheOK4C40DhPjzEIqYym0C+AafzK1lPNv9SNNw9td1FZC9rPdCWFKWy+qOVI/4s8ycJ8Lv19xjQ7RfI8YRGgMzKYowo+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7508.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:427::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Sun, 8 Sep
 2024 13:36:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.022; Sun, 8 Sep 2024
 13:36:36 +0000
Message-ID: <83f39f2d-7237-4880-83e3-1c3afc62087d@siemens.com>
Date: Sun, 8 Sep 2024 15:36:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/4] driver core: shut down devices asynchronously
To: Stuart Hayes <stuart.w.hayes@gmail.com>, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Martin Belanger <Martin.Belanger@dell.com>,
 Oliver O'Halloran <oohall@gmail.com>, Daniel Wagner <dwagner@suse.de>,
 Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>,
 David Jeffery <djeffery@redhat.com>, Jeremy Allison <jallison@ciq.com>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
 <20240822202805.6379-4-stuart.w.hayes@gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Cc: Nathan Chancellor <nathan@kernel.org>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240822202805.6379-4-stuart.w.hayes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0038.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7508:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a902e51-6b07-4e0a-9b91-08dcd00b42a4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S1FqRUVwYXFIWVZEUFBjTXhlL0ZOQUZ2cjV3bjNsUHRjNHJ6WUhhYnhxTmEx?=
 =?utf-8?B?TWN5aTF4N0UxbGFTWmNWSmVMeDNSNHhYR0s1cjdjc2lPM2VXeVgzNHpCSVZT?=
 =?utf-8?B?RlR6MlRUalpBT1k3VktnZFVqczQ3WVFUdWZRUDlLVURSa25jbXgvZzlIcXdp?=
 =?utf-8?B?RnU0WWJjOHRIZVlBeVlZVUM0ZWNuMnlNYmgwakl0ZnZITHlYWEdmRGMwVEY4?=
 =?utf-8?B?M1RvKy9mU0E2V0FWaFVqZ21YYjBrK0llc2hYWDlpNW1rSjgrL082elphM0tw?=
 =?utf-8?B?clphQXVXMU9SaVIyUUlVY2dXSWt1M0d4a1ZHNlpqcTUyZ1NZNitTOVBXdVVw?=
 =?utf-8?B?Z0N6aFB3TllDUTRqbzhNUVVVV041NS9iZkhpNlJYVFg2UzJNejJwUWNSeFUw?=
 =?utf-8?B?aEhtakI5ejcwVEpHSTdyL3lRais1ODlBY1VTYzZGenB4MldrY0E0NkRYMlMr?=
 =?utf-8?B?SUQzbkVvRHFsZFBBRGFHR2svY2ZvRFR6SmYrVzA3eGpwYzZNWW5ZNWZ2MkVK?=
 =?utf-8?B?cVFnNEVDMkJ3Z0lOb2ZqWWExMWN5YUJ4bnZ0d2tzUmI1K3c5RUZqOWZld2t6?=
 =?utf-8?B?SllMUVBCempBMU5IODF2aHhxRDFsbjRrVUxmOFk1RC94U3FIVFQwQXZVMW5R?=
 =?utf-8?B?bTlHQVdXeXV3aEJBKzJqOXM1RHk0T1pxZlBTWFVDV1B3VkF4Nkh1T3J3N1FX?=
 =?utf-8?B?TVBBUllvczlrVmVpTjI2UW5odmwyeUVZVzVENSs5LzhScW9sZWRLRlNINnVr?=
 =?utf-8?B?TURSZVpCZEpMVWlHQlhydEdQdUVzL3RlMVNqYWw4anJPTXRQblRxVm1UV0xN?=
 =?utf-8?B?OFpJb0k3OXl0cmJ3WU5ZWE8rc1lWdi9tdnAyV2ltSWwwektjVHNVVWFFSnlh?=
 =?utf-8?B?QUhna0JLeDJzaVd1dUtPYTlIQVhwTXRROTB5SGVxNzdTdVBsOSszU1kyQmZE?=
 =?utf-8?B?TUhhQ0RyZHNVaE1iZVFHOWF5dnFkWXpMR1lYbkZxY0FySVZhVkd6ck1iLytG?=
 =?utf-8?B?VWJVMzNqNU9SSkg4SnUwaW5QNEt4RlNmNC83UkZBNVM5SlFmTjhtYUNUeUZz?=
 =?utf-8?B?Y0QyVGNGMTZtUER1aGtyem1IdTdZQ1hNTFZGR1RrNFZRck8zVmU1VEJBcmNv?=
 =?utf-8?B?Ny9BYk1mQUl0OEgrVC9BSGhXY2MxZGhJcDFhZkM0S1dDUGVuYmp4aCtGS2lj?=
 =?utf-8?B?eEVpWDRVNmpKdG96NlFWNm92V1JXSVFNM0t5TEU1RzBaS0Z5d25xeWpsS1BG?=
 =?utf-8?B?SnpFb05PMitGNm5IR0NuM2U3ZjFHcThwYTZZbWhlOU9BK0dLQ1VmNG5PdU1J?=
 =?utf-8?B?cm1iWG5WM2toSEZBR0xKTmUycEdrbU83THJlWUc4UlloeEtmTG45MW9pbmky?=
 =?utf-8?B?NnU1My9BWXpHNEVudzVBMGlUUC9maDJ0a0xqdFhjSy9yZGRmY2NNS3QyKzB5?=
 =?utf-8?B?aXYwdEREKzZCUU5aWnZRNSswUGhPTUpxTHV6SFdYdFdkSlNsNCtQeDBDSlJG?=
 =?utf-8?B?alhUTG0yeWZIN2xEd0FmRm5HVlhmUS9MTDZESndrNlFRbkt6Tnl5WUlMWVFy?=
 =?utf-8?B?RjhIdytFR3FoZ1lwZ2VjU1pqLzcwSlE5eFVTSXZqN0NEaEJ1b3UwWlpaMFdY?=
 =?utf-8?B?QTJJQUY3L2kzN2s5S0paWVY2WENaUnJYclQ4UzAycldkRHdDd0tTTmg1ODBq?=
 =?utf-8?B?MGZjL1hXZmtRWmZpeS9KaldYZDdqeUsvbVY3eWFVZWhqNkpWVmNpbmh5bmNX?=
 =?utf-8?B?ZHJ1L2pDbmFMam1USVo1Z00yU1RiM1g1RXhQWkFvY3pPKy9kNUYrNHVkS09E?=
 =?utf-8?B?Nk0rNEFYaGdzS1ZvZzk5dTF2VTJVTHVZOVlRVkxNZ0plYkRpaEhhaGFKUVg3?=
 =?utf-8?Q?qyEN9LniR+1lN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHpQY1NwWGl5RnI3YmVBYU5TWU5PRnZnT1FwUHBmZk0zVFBjMk9TMjFiN1Js?=
 =?utf-8?B?c0hENmExVGMyRk15WnZwcC8rMEl5YUN1TnR6RjB1SzdkSGt6MXNsbVY4Q2JY?=
 =?utf-8?B?Tm84NTJweG9VY2JIQm9rZHhSY0VUM1pQTWMvTkhjYVNmZk9ZVGdTbEgzMDdx?=
 =?utf-8?B?TFdlTkJZREowMDZlT25VRmRrRUplZ3BPZVJwN3JhUFRkWFNseno2MnRnUXF0?=
 =?utf-8?B?SjlJa3V2R05lTEFKTGdpbGk5VWk4WnJtNjhXeDk5SDFtcldWQURpMkJoT2Rh?=
 =?utf-8?B?N3ZmSFlPcmgzZGNvNlJ6aDZXTGN0S1hPblE3RUVhRWJQeUZXNXk3WkxaRlJn?=
 =?utf-8?B?d2FodDZneS9QeHRyZHI3MzhQa2d6Nmllcm5oMXJYY3A0bm0rV3VaWHBDTGRt?=
 =?utf-8?B?S2NkRmZSYkhKY2dqN1h5bEVRRGdrTVkyVW9kUEl1YmxxU3lrcEUxUEVqVDVU?=
 =?utf-8?B?aG1lQ2VYU2JBQkRxdC92cEVkUlQ1T3JlSE5lQmlETGp0K3pOMUFnNytpcEl4?=
 =?utf-8?B?OGRqSGJrWGNYSmk0T0UrMkRJZjFtaFRQeXpwOHNNWEsxbTJLWGNGMGc5dHFx?=
 =?utf-8?B?WDJ4WXUwUEV1OW1yL0pYb1ZDRDRoVm1KNnBNN0tDZ25abVZ3RVRXUlpWZFMx?=
 =?utf-8?B?U2FrVWhwSnhEaVFUN0hkRkhpbURxb2MrM1BxczNIQ3NocjhQdUJVRXhNR1VG?=
 =?utf-8?B?dStsSUlIbjhqaVlheDlUL0JFOXAvVHUrNTY0bEtWZWRlM24vM096VXlnM0RJ?=
 =?utf-8?B?eEJ2RHNtNnR2Y05jUVc2Q2x0TjJnN2xVVVNSYS9SU2dlUG94THcvRmU2ZWZG?=
 =?utf-8?B?S1FnYUtLalJqa2J6WStYZmVuT3RyZDU2bzlkWHltRzV1TzFHZkJ3VTdrdE9E?=
 =?utf-8?B?UzEwZXhSSXdTSmN3ZU1yWm90USttREwrUm1wMGkwbktPMTdiZyt1SXBIOWtu?=
 =?utf-8?B?WjB1UE80eVFiK1JGYzgwS1dQLytsd2pQY2IxZjVVRzJPaHNJMGg1TllJM0sr?=
 =?utf-8?B?NlpVOCtLa3dPdkd0ZVZqVTJwWGl6OXNIemo2bGg5bHE4cXV3TDBMNGN1N3gx?=
 =?utf-8?B?cmJsdmMxd3IxZDc4QTZWdHBqMDlXTGZ0Y2ZEZU1NYUt4QWQ1c1hDSlpiS0tl?=
 =?utf-8?B?VTlaaEw2WHJNK1M3bjZBNTl1L3BQaHFFY2p4TUROVThkTlp5WG5aSHdpbTlq?=
 =?utf-8?B?K1FINzI2UGVTSVk5UnFOTVErSkU0ckpqNVY5c0VoL1hyeHVEWlE5eitnZGNQ?=
 =?utf-8?B?UWVRY3NoNlNSUGpoc1dQeGo1eHhmSUFqcGd2TGZTV3hYVzRIVkIvemN3Qmk4?=
 =?utf-8?B?NVplb3ZQTWxXUm1QdjlwMThJQkZiZFV1OHl6cGs3QndCa1hZOFA3aXN4TDJy?=
 =?utf-8?B?R1FTcXV1V2VacDN2YmEyUGhHQlJxdnZwZjgvL3JvUkx0ZWZpN2ZQMkFLQWZU?=
 =?utf-8?B?MnBGTFVTK3lpNmgwZjdBZ1dKRzdaOFo3dUh4SlJhOXFOQndUcHZuTVFLL0pu?=
 =?utf-8?B?Wkt6VUtPKzRwdDl5Und5TldlTDFIVDRWUFF2V0hmdUg4LzNjL1ZZUHU1eWR6?=
 =?utf-8?B?emZzM1N3cFhzdldBbzFEcHYyUGllMWN1UlpTaVN5QWZkWUM2cnorMENjaUxQ?=
 =?utf-8?B?SXhkaldOZUZmQ1ZPdVJ3b2FCL1RMQ1dNNUJza1JYdGl6cll3N3hUQlJDajNO?=
 =?utf-8?B?MlNaOER2UU9EY3ZLaWo4anB6ZTZNclRKbmh2R1pua3lCSGp5NHowbjRWYkJJ?=
 =?utf-8?B?UlJRTEdmeDM2d0h2eUl4ZmpjVEtGQysybS9yT1NVWS9OMURuY2xSU3pzTGpt?=
 =?utf-8?B?K2ZmWlZyUzlrTWVQYTFFR1htYUNJSi9YaDhEZjBCdTM2U2tDeURzMjNLQWU0?=
 =?utf-8?B?TVZtcDk1MnpYK0FDbDF4OVZQTUdEVVNSbFNraXNQdzlVVXpkbkF6dVl1UStj?=
 =?utf-8?B?aVhqYkw5eEVuMW9zQkt1R1RSOTNVVnhqMk02U3NNOUYvY0ZKZmlLd3pPbkNk?=
 =?utf-8?B?ZU9FbStOQTFoejVMSHM2VkdnejZSWVNFOE9xNm9peTd4dEVaUTY2Y3BXT3FF?=
 =?utf-8?B?QVVLWTVpcEE0K2IxSW5FYzFLK1ZMZGFuWlhiNG1xMENwMlJnSXRqWXFRUnF5?=
 =?utf-8?Q?cObi87psdEsU0IvAo+7H+fAzW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a902e51-6b07-4e0a-9b91-08dcd00b42a4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2024 13:36:36.2447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7LzLPXwg1XmK7CGMCD9X3ZUkiSlOhuLZExia5RscaHxRSQ0n67gJ4mF0zXGyMJgcXd1i1HFj6hCviyM9/o2Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7508
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240908_063647_372910_D75CCF32 
X-CRM114-Status: GOOD (  23.36  )
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

On 22.08.24 22:28, Stuart Hayes wrote:
> Add code to allow asynchronous shutdown of devices, ensuring that each
> device is shut down before its parents & suppliers.
> 
> Only devices with drivers that have async_shutdown_enable enabled will be
> shut down asynchronously.
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch.
> 
> Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
> Signed-off-by: David Jeffery <djeffery@redhat.com>
> ---
>  drivers/base/base.h           |  4 +++
>  drivers/base/core.c           | 54 ++++++++++++++++++++++++++++++++++-
>  include/linux/device/driver.h |  2 ++
>  3 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/base.h b/drivers/base/base.h
> index 0b53593372d7..aa5a2bd3f2b8 100644
> --- a/drivers/base/base.h
> +++ b/drivers/base/base.h
> @@ -10,6 +10,7 @@
>   * shared outside of the drivers/base/ directory.
>   *
>   */
> +#include <linux/async.h>
>  #include <linux/notifier.h>
>  
>  /**
> @@ -97,6 +98,8 @@ struct driver_private {
>   *	the device; typically because it depends on another driver getting
>   *	probed first.
>   * @async_driver - pointer to device driver awaiting probe via async_probe
> + * @shutdown_after - used during device shutdown to ensure correct shutdown
> + *	ordering.
>   * @device - pointer back to the struct device that this structure is
>   * associated with.
>   * @dead - This device is currently either in the process of or has been
> @@ -114,6 +117,7 @@ struct device_private {
>  	struct list_head deferred_probe;
>  	const struct device_driver *async_driver;
>  	char *deferred_probe_reason;
> +	async_cookie_t shutdown_after;
>  	struct device *device;
>  	u8 dead:1;
>  };
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 7e50daa65ca0..dd3652ea56fe 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/acpi.h>
> +#include <linux/async.h>
>  #include <linux/cpufreq.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> @@ -3531,6 +3532,7 @@ static int device_private_init(struct device *dev)
>  	klist_init(&dev->p->klist_children, klist_children_get,
>  		   klist_children_put);
>  	INIT_LIST_HEAD(&dev->p->deferred_probe);
> +	dev->p->shutdown_after = 0;
>  	return 0;
>  }
>  
> @@ -4781,6 +4783,8 @@ int device_change_owner(struct device *dev, kuid_t kuid, kgid_t kgid)
>  }
>  EXPORT_SYMBOL_GPL(device_change_owner);
>  
> +static ASYNC_DOMAIN(sd_domain);
> +
>  static void shutdown_one_device(struct device *dev)
>  {
>  	/* hold lock to avoid race with probe/release */
> @@ -4816,12 +4820,34 @@ static void shutdown_one_device(struct device *dev)
>  		put_device(dev->parent);
>  }
>  
> +/**
> + * shutdown_one_device_async
> + * @data: the pointer to the struct device to be shutdown
> + * @cookie: not used
> + *
> + * Shuts down one device, after waiting for shutdown_after to complete.
> + * shutdown_after should be set to the cookie of the last child or consumer
> + * of this device to be shutdown (if any), or to the cookie of the previous
> + * device to be shut down for devices that don't enable asynchronous shutdown.
> + */
> +static void shutdown_one_device_async(void *data, async_cookie_t cookie)
> +{
> +	struct device *dev = data;
> +
> +	async_synchronize_cookie_domain(dev->p->shutdown_after + 1, &sd_domain);
> +
> +	shutdown_one_device(dev);
> +}
> +
>  /**
>   * device_shutdown - call ->shutdown() on each device to shutdown.
>   */
>  void device_shutdown(void)
>  {
>  	struct device *dev, *parent;
> +	async_cookie_t cookie = 0;
> +	struct device_link *link;
> +	int idx;
>  
>  	wait_for_device_probe();
>  	device_block_probing();
> @@ -4852,11 +4878,37 @@ void device_shutdown(void)
>  		list_del_init(&dev->kobj.entry);
>  		spin_unlock(&devices_kset->list_lock);
>  
> -		shutdown_one_device(dev);
> +
> +		/*
> +		 * Set cookie for devices that will be shut down synchronously
> +		 */
> +		if (!dev->driver || !dev->driver->async_shutdown_enable)
> +			dev->p->shutdown_after = cookie;
> +
> +		get_device(dev);
> +		get_device(parent);
> +
> +		cookie = async_schedule_domain(shutdown_one_device_async,
> +					       dev, &sd_domain);
> +		/*
> +		 * Ensure parent & suppliers wait for this device to shut down
> +		 */
> +		if (parent) {
> +			parent->p->shutdown_after = cookie;
> +			put_device(parent);
> +		}
> +
> +		idx = device_links_read_lock();
> +		list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
> +				device_links_read_lock_held())
> +			link->supplier->p->shutdown_after = cookie;

This will not fly if a supplier registered after its consumer. As we are
walking the list backward, the supplier will now wait for something that
is coming later during shutdown if the affected devices are still doing
this synchronously (as almost all at this stage). This creates a
circular dependency.

Seems to explain the reboot hang that I'm seeing on an embedded target
with a mailbox dev waiting for a remoteproc dev while the mailbox being
after the remoteproc in the list (thus first on shutting down).

This resolves the issue for me so far, but I don't think we are done yet:

list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
		device_links_read_lock_held()) {
	if (link->supplier->driver &&
	    link->supplier->driver->async_shutdown_enable)
		link->supplier->p->shutdown_after = cookie;
}

I wonder if overwriting the supplier's shutdown_after unconditionally is
a good idea. A supplier may have multiple consumers - will we overwrite
in the right order then? And why do we now need this ordering when we
were so far shutting down suppliers while consumers were still up?

Same overwrite question applies to setting shutdown_after in parents.
Don't we rather need a list for shutdown_after, at least once everything
is async?

This needs to be thought through once more, I guess.

Jan

> +		device_links_read_unlock(idx);
> +		put_device(dev);
>  
>  		spin_lock(&devices_kset->list_lock);
>  	}
>  	spin_unlock(&devices_kset->list_lock);
> +	async_synchronize_full_domain(&sd_domain);
>  }
>  
>  /*
> diff --git a/include/linux/device/driver.h b/include/linux/device/driver.h
> index 1fc8b68786de..2b6127faaa25 100644
> --- a/include/linux/device/driver.h
> +++ b/include/linux/device/driver.h
> @@ -56,6 +56,7 @@ enum probe_type {
>   * @mod_name:	Used for built-in modules.
>   * @suppress_bind_attrs: Disables bind/unbind via sysfs.
>   * @probe_type:	Type of the probe (synchronous or asynchronous) to use.
> + * @async_shutdown_enable: Enables devices to be shutdown asynchronously.
>   * @of_match_table: The open firmware table.
>   * @acpi_match_table: The ACPI match table.
>   * @probe:	Called to query the existence of a specific device,
> @@ -102,6 +103,7 @@ struct device_driver {
>  
>  	bool suppress_bind_attrs;	/* disables bind/unbind via sysfs */
>  	enum probe_type probe_type;
> +	bool async_shutdown_enable;
>  
>  	const struct of_device_id	*of_match_table;
>  	const struct acpi_device_id	*acpi_match_table;

-- 
Siemens AG, Technology
Linux Expert Center



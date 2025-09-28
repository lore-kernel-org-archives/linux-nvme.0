Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 883C8CAC5B5
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Sep 2025 13:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4XYcsgJ9SHZpeJJN7CLfQfvZmrUOOGpsZisLkC62Vwg=; b=fwNnmDVswwKTRYGtJ1cprqw538
	zs96OxHNDaBt1NawWIDfl2MlaN7/V0fEk73rIlIKIteFD5/ldpdNj8APlPIpKpa1A5x2cV6gQeGAt
	kosdZ59iDccgVwgMJWd1JZ9ed/24mCGQcYe7J3GlwkRYZ5933/efUMsIZZXJHKbrzHkzKcSxBZChh
	8btvHYgP3y/wR8BDTYyul92GT3gpplH4tfUPAwCeisX1zgbM16/FXCQ7Zv57g97qj+kne5u7oz/Ol
	X1jWjsokt2vLRWqN23TBM5yqmS3nN4m5I868KB3H2TymcAoCjD0eKOnr5YVDMzTN/Qh90vY82EaA6
	oDg8cgNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2rV8-0000000Fl4O-3Ih8;
	Sun, 28 Sep 2025 13:31:42 +0000
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2rV6-0000000Fl44-0JAR
	for linux-nvme@lists.infradead.org;
	Sun, 28 Sep 2025 13:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5mHIp5hlLud0Tqlc/3ri9k3ZGuDRzNgrhlUpMqccAhgic7RddKW0y2x34D3vjXVz4wOSx9FwhU9jkQzx83GZwMLf8oCB+f391q57A0+MCe7vM87AFlWoq70ykdllsL3UDfx1LPUoJI6nXRU1Yr9mFfFLhMA48IBAtMairxgIdgPML9ti71s+cqjsKyi2OOJjHoBiSIPyqBFiqo5K+3GxNYDqKIVefDpDTWiybRbFR+JbPVwvEYGy13RLDCO2eMawwEGQXMmmE5AARM4DOL/6P3hvgfIO7DVAXmLN+XP3FVnRI/jeaRxMVjj8SYbJKdNMtRPwfToc8N9w7GOJmRDoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XYcsgJ9SHZpeJJN7CLfQfvZmrUOOGpsZisLkC62Vwg=;
 b=vXm+AmbDviKDKVcJodDV9LmrhicDnraWKREdJtKoblvKvkpY3gyyS1v33MdKwlYRaaUIr0hJ8vhmbnF25hBEVoysK5ETmlgmdl+63ZLCVa3/+nY/vrHWWnKpIodBkvEgiNwwylFQ+cEuzNcXzViO/Zw1RwVUeh5CLHdgoDDt/i6P3HZFrjRQ+hVnAg5WdCcyRvSw7NwBww041ITImAIYxQ5otbLKGajho1jyE8TBjryw2t3QnsN9wIQdFAZeWhbteqzL13FvF/Q80jOo5tU0xJJ1Ltm8p5ishVji6RELdrHIPguVUpaq9zwoYH0ZqvP6DywX4XfByeft7Yhw+EW3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XYcsgJ9SHZpeJJN7CLfQfvZmrUOOGpsZisLkC62Vwg=;
 b=c4T33uZ4o4PP1Mcb1qUcwrauegdEhsdfLIlyYrPaBua9+se9Ld9DrjAroeNnN7Prwru/wJLy7DZR0uuqeCXfOFE35aHfxVuIf31kc8mNMMYx3hpMn9GCw0l1fTAp6Aga2fLwcYYedBzkUGlopb+Ss0zhK6TgqJKHZnM0JurTFjez2r4A7BWwwYRSgCFyvaOOIXPSuA3k1upt+W60Fnyv0mYwVzEycyMZcxRTqqHcVBmBpMSivrcfYkbzJbofXKh+kferOW884YLZ6V06CvVmIz0FZ9lG+qgcGLkhrh1fZNMWQ3AoRIJ2nf+4oKczmBBpHMTslXkCphLWeGgN5W+6fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Sun, 28 Sep
 2025 13:31:24 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9160.014; Sun, 28 Sep 2025
 13:31:23 +0000
Message-ID: <8d3b9748-4de3-439e-8954-ec114ee962f3@nvidia.com>
Date: Sun, 28 Sep 2025 16:31:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] nvmet: fix configfs attr update handling for
 discovered subsystems
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 kch@nvidia.com, dwagner@suse.de, israelr@nvidia.com
References: <20250924202604.7201-1-mgurtovoy@nvidia.com>
 <aNRtJZL7uxRaHifz@kbusch-mbp>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <aNRtJZL7uxRaHifz@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a8f3fa1-b9f3-4bc5-df1a-08ddfe93515f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWZvTzlOQ1k1Vy9Od25BNmdiMjJzOVhkQitaejNqWW1uVHcvVjNBN2JOWUow?=
 =?utf-8?B?U3dFUnVjbGFvcjZyaTF4emZDUVVEcEhvMWNFd3pCeG5RS29RS001Y2g3Slp2?=
 =?utf-8?B?dW1sQmtCbWpvekZEajlwU1BKaXFtelNNYnNxRjFTemZGdGRyN01vSW9XRHZy?=
 =?utf-8?B?TGM3YkpsWDFUbXdFeWtOUG1LSGM3T2lNRTluNUZGNDNVU1ZpdFVYdmNneitE?=
 =?utf-8?B?dXNiZEdJZXBzN1FseXBoSmVZZzlzSUZvRnpUcFJZZ1ZySEFKNGY0Qm1jVEFC?=
 =?utf-8?B?OVhmZnF2a2IzS1RYMjNCcUJyMTFIRTlqcEhpQXRZYUdoUnRUUEQrMG81SFVw?=
 =?utf-8?B?U0cxV3NSN2VnNjhWQU5KUStudHh4TUN0SllUajU0Y1FxOS9kUVdIZXMrTUYx?=
 =?utf-8?B?N0lxdSsvU2h0SjU3UmFQN1JOMnVnMmJNblVlS0hEYjJLeC93WlNvRWpMZ0Fi?=
 =?utf-8?B?QU93NDZOeENNOVI3Yi9VVm5ISEJjbjFEWjErQWJrQm12RDd1aVAvQ2tWalZP?=
 =?utf-8?B?blMwa1pob3ZCQ29YSjhQMmR0Mmdub0x6c0Q3cDM1N0lKNWlmOUQ4clQrOUY4?=
 =?utf-8?B?WWt3eEJqQytzT3RFTHdZbEdMRTR1RUg4QVdwZ2o3RmlUbXhQdi9DTm82Qk1H?=
 =?utf-8?B?ZW80S1N0Ykw4RmNrL2RBYTBJZXJaa05memxMQUhRMjk1Q0xOZXRXRHJlOTZV?=
 =?utf-8?B?OEF2RzZSRkZ6TUFlaFRHbVNnUXc3b29NcGZEbkpXK3d2REw3cUN6TEQ5NG9h?=
 =?utf-8?B?NlNOQjZRZFJ5Y2YxQURhVTFFblpXZ3k2WEhCQTd0b01ZeDJ0YUlBSTc5NkVP?=
 =?utf-8?B?MHV6YUpLbGFidXBnNC9INHUvakdhUVVXalliS1l4b2puanRjaFNsVmo5a2h2?=
 =?utf-8?B?YjVOMGZJVlRLT2w5cU42ekxpOWFMQXBrSzVYU2JQWnNCS1RkV1JpRWJaelZQ?=
 =?utf-8?B?S0s4S282M0xpVUFzQnlkRVhuaXVRRjA3UzRRVUhmVXBFTE9KZkVPR1RqWmlr?=
 =?utf-8?B?S2daLzF5KzdYWDF3SmdERFpGU3kxNjk1Nnk1VjZvR25SaVM4Q0FrcjZzMDU0?=
 =?utf-8?B?cUx5aXh3dlFRV1o4eks1SkxnRUlqWkRXQndPcldoL2Zpa0tZaXlmN1dnYzli?=
 =?utf-8?B?R2FwbVBpRVBTYlEzNll6WHNYSWNnQVFQSnZNV1puZjdMb3RBK21vUWhPMmFV?=
 =?utf-8?B?bEpOUEIxZGxjTVVjOGxzTTMySEgvTG9veUdjWlNaT29kcVkveXpiZ01aQVBz?=
 =?utf-8?B?N1lZcHloZUZCbHNSV2JUcDBXMFQrWG1CdE9BSlhlY3paMk5EMWdGZkQrcFVm?=
 =?utf-8?B?cHZNMWxrK3hHNkFnWlFLeVZaNTdnbUpLNUJoWUtJeTNCdk1Vbjl6a0ZtSWxO?=
 =?utf-8?B?T1RyblM4aG93Nm1Ua1NCRHlZdWhRVWJEdWJLZWdNd2s0anpmRHlycitOZndt?=
 =?utf-8?B?N3RsQXUyQm96UDhkcmgyNUVHbGlKUFE4YUdEL3dCL1BrZUFDTEJIaDljL0Fn?=
 =?utf-8?B?NUgvUkxCMzI1RXpHSEs5ZVdZd2p3bnNmQ1dXMUlzMUtjQTJvUDQxdTdRNWFY?=
 =?utf-8?B?NDkzdU1kRjNTK3E0UHltcUFYSGtHNXMwSVM5V3V2UjVjM3NadUJSczNyWWRI?=
 =?utf-8?B?TXZoWVZPUjZKRmZCWmxJdVlEdmE3Wlhmb0p5OW50QXJleDRiM0EwTGlDdis0?=
 =?utf-8?B?ajRzYyt0M2VjaEs3eUR0OU1Yb2ErQisrOCtyRW02Z1U2eGtXTmNQblhSYTFm?=
 =?utf-8?B?MWJnYWp2NnRTeENmcklQWG5GaUF2cHMvNm9YTUlmQmxNKzBZMzl3dDE0MlF4?=
 =?utf-8?B?NzlpS2VtdGFxN1NrZXZmNVFDQzVVdGIwNDJxVGFKUk8rNWlNOU5xMmJrVkFZ?=
 =?utf-8?B?MElXdnlXZTV2emk0K1h3WldZTnJJLzNJZGRrWWNZblRGcmh2aC9lbWJjNHR1?=
 =?utf-8?Q?UNSFF1nf+YXFUN3HYz7nG/Myk8Bsf96/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG9KamlYTHlPVFlUbkhWcHBITEEwY3NlV044YS9MNTRaT1E2eU0zSzhlcGs4?=
 =?utf-8?B?WVRPNy9YSmZ2ZTlqMW8wU2VIWTJHaEJGRnRNK2EzVWFtMVAwMzQxVHZJc0NL?=
 =?utf-8?B?eUlMV2ZTSXc0QXB4K0Vxb3djNVBiNHZHYUNOU0J6ZXZ6d1l2NWV3WlhGMnd5?=
 =?utf-8?B?d2RzVUFnK2Z6eGtScmg2ZEh1NXRaNHA3ZWZjREFlUmFXOTNrWVhYZlNwN3h6?=
 =?utf-8?B?VkF3SHIyR0ZLYTVUT3Exd3VNQUN4ZzhoZTNzMnZrUC9LbVpiTXRaLzMrUmNh?=
 =?utf-8?B?NHgwdCs3RFhyYi93UnluYUhlUEx3bXZLVHh5dGV2d1piUTNxc3F1MzVDUkJu?=
 =?utf-8?B?Q0hXV1JKd1YvVC9LTHZZV2FrVlUwYkVQOUNveWo3NER1T0RPMTFyWm1GMEVl?=
 =?utf-8?B?UkJwRktVZjBFbEt2Nnc4c0FFTkNOUXNCeStobzBvRXlHK0xhMVZET0RCeitj?=
 =?utf-8?B?eTE3bGdYdENBRXJIdFRiRCtSV1g5NGRRNFc2dXdLVEtJZUpnOGszVTRoY0tN?=
 =?utf-8?B?cVcvRy9ydG85emVtUjgxVjdzZDFqQ2g4VTI3TEdHaEVPZm93VTBNc291d0NF?=
 =?utf-8?B?VmgvVjVMQ29kblUvK2ZlL25tSStKSVU1YjhNclRNdVRDQ0NvR3dVWDZIKy9z?=
 =?utf-8?B?eXpnK1pma3R5NHhRbkQxVmdrNTJTUnVPVGR3dFFDWXNELzhxcVdGTUhPZmYy?=
 =?utf-8?B?T1VJWm1JUWRsV2NoaFdiNHZTZTdlTnArVm51MnpyUVFzeWo4M3hJNkFzNVQ5?=
 =?utf-8?B?Y1NTUk1UeXBOZEplaUxuNlBETk9KS2tCYlFaSnNiTk5QeU8ybzdta1Bxb3ZW?=
 =?utf-8?B?aFVSRmxjV1BRV2NyWi9zakp2UE5DdTFVRHpCMzE5N3VBMUd2TEFBSGIvUkxG?=
 =?utf-8?B?SjEvQlc2MkY0d2tFdVZFdC9xM2hMOU5ub3BsUzZxam4wamEvT2JHNnJRWnpw?=
 =?utf-8?B?RDZYYkNjUjU0SFZXSHduYWtwYUcvS3pJb0xoaU0wSkErZ09Sb1dRZTgwbDYr?=
 =?utf-8?B?ZFA3RFUrenZZU1lVZkVnZG5qZVBURzlrd0VUNTlSOTNJRXhwOE5iRi9MMmZx?=
 =?utf-8?B?RW5UYlhCUmZ6ZTIwN0ZTUXQwM0hZUXYyaFBXRjJUM1hNL3ZKRkJnVnBKQ2ZC?=
 =?utf-8?B?b0tGRndoUXFIckdyQkhrT2MrMk5MU1Qxdzc3a1pUdDNRaS94RXdpb3BlaSt4?=
 =?utf-8?B?MzFUbDd3ZXJpWHRsUG9zUGxtY2V4cXFTd2VDS3NRQURZdms2NVJmS1NwMy91?=
 =?utf-8?B?QnZuMGhieTkvcHJSK1VWTm9xaGJjNVpvVjliOGRBaHlrMU9Dcm50N3ZGbVQy?=
 =?utf-8?B?T3N6Q3lnYm5ibzFPbUxJL0E4TW5LVkVnTmNOb3l4eVNXMlBUczJWRTEvdUgv?=
 =?utf-8?B?R2FBSW9EQ1JLUjJvSWNuazdFM1RHMVFBL1lKWFRINm9KdUk0azg2OEtpUllt?=
 =?utf-8?B?eTkyeDVKajJidE9ZT0xWRDYxTDVKZGYzK0RzK0NXY0NuL3NYVDY0aU5DMEU1?=
 =?utf-8?B?bTJEQ0Y5dDBDZ3JaS1JFZ1Y2bWVEV3puKzlpdEg1Z0FTaEkrTzJtTTQ0eUZq?=
 =?utf-8?B?aGphakJ3eGpaV0g1TC9Cd3M3VGt1YmpnU1E3VkdNajRkbU1sRFpkbVJZL0x3?=
 =?utf-8?B?czNrbFZBeEFmVlRyRW1NZ1pWNlYxS3d4V0Vka1hkd2tIL1dLWks4bm96NFZn?=
 =?utf-8?B?TUFnaGZDL3RLSnNmM2RBMWdTR1RnZEFEa1ZrNW1pbGw1eUs1MC9oMUJYR2ts?=
 =?utf-8?B?L2MvR3FETFVONE1PcTFmL203cVJESUUyL1J1aXFHRTBxcVJlTXgzSGNZQkpV?=
 =?utf-8?B?Y25xT2JjR1o1ZTN4ckpGdWgrTENGNEl2VFFyOGxOakFoYWMxYU9oRlIzd3A3?=
 =?utf-8?B?YjRRczlLNC8waTJ2TUVwRmZDMTlOZWRVSTJCWklyY3VJZ3lpWVBJaDlRcGg5?=
 =?utf-8?B?Q25PcnJyQzZGQzdKb2xYM0Vhcyt1ZUZqWWllTzVnWG95SEJBQ2xDUTYwb2s4?=
 =?utf-8?B?VExXdEVFZDcxNkc1Z0J1MXFXNjNGdFhtS2JIMTg5cDNHTGlNOHViQlZtRFlV?=
 =?utf-8?B?QWpmS2xMUm5yZzZJdUJQSk1WZ0Rqb2xCUEYzUDNYbGcxRmVic2gyWU5hYTQ2?=
 =?utf-8?Q?W7wzNH5Kw78tadFFmDaKUyLxX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8f3fa1-b9f3-4bc5-df1a-08ddfe93515f
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 13:31:23.8039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGL+/eaczZ5lPwJTH3AdpeDT3sp/TBRszvh1WwZeYHhZBnYptwPa7RHG9zTulmWeXLoG/Qxn230A7M9y7DM1WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250928_063140_120276_0182658C 
X-CRM114-Status: UNSURE (   7.92  )
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


On 25/09/2025 1:13, Keith Busch wrote:
> On Wed, Sep 24, 2025 at 11:26:00PM +0300, Max Gurtovoy wrote:
>> 1. Forbid changes to controller ID min/max attributes values on already
>>     discovered subsystems.
>> 2. Switch cntlid ida allocation from global to per-subsystem scope,
>>     matching the granularity of controller ID ranges.
>> 3. Forbid changes to vendor ID and subsystem vendor ID attributes values
>>     on already discovered subsystems.
>> 4. Forbid changes to max_qid attribute values on already discovered
>>     subsystems.
> Is there a reason these should be changeable after they're initialized
> even prior to being discovered?

It allows admins to modify some properties after initialization.

We might want to finish subsystem initialization changes once it is 
linked to a port for the first time (instead of the time it creates the 
first controller).




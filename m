Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CD3C54798
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Feb 2024 10:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=79o0n6ebw/SuQzen/nUdHSpN21/3nZm/cshpYJElqTE=; b=xPRSyfSVlJjdbyfDhBObepOjmH
	8Dm1pXfeVVyOXgyzxTV4/wgwBoi5mjKbQRZql0+6fdPhNLzDK7enEaattNXPGx0i4C859m+cJJ8oj
	lqBCoeOABB0HzuHwkO+Jn6nHeCcCvHrTNWb/2Yg+VgQCqeOFwS7RW9AqOxRoV0QS9qGHBiuVhYyeI
	gTciA8adSoEc7D3/Ti1i6ltOjCEN7S/w+7ubYmhq3PM309cVeH8KDHug07qU/smTfMgM76fPkCzrt
	sPdvsNXRsyJXJFtamUjDi1619DacesCmjgB8oLRe7/mi3km05K/6tYP4sY3qubpTNrloflSLGyXhN
	YDBSwYRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfdw8-0000000DDe1-3xta;
	Thu, 29 Feb 2024 10:46:48 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2414::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfdw5-0000000DDc2-2IBc
	for linux-nvme@lists.infradead.org;
	Thu, 29 Feb 2024 10:46:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecsPHR03ijiktYEo7csc81E+lhw68EQzvC6CBDtH2uUCq/IY5FfXsDzd3eqBBnvRojOekcJD+ZwF/Ph/1inqBEv41yldN26fimnzmoyttC4OHNv9ym43yETglJ7Y0oWNY8mkmYIqD3WJYV2Pci0o1LB8UtnziXkgia2FCWptaZu1+dvufa1p+oiW1mSmzFPq2yluNpk6G0uSw9wkXkhU+tZrZZFoWz0pPd/I1kINXWsdkKne7f2HmrZvVodLZzc3uEXP1TXzmgtFegzcQv0ZvaKCcjv5ltmXqXioY25cB1odUByHZWlKj7q1WMq93ar6OPm2/jrLI5bUbgYaqnmZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79o0n6ebw/SuQzen/nUdHSpN21/3nZm/cshpYJElqTE=;
 b=EuXwAQWYXqS/wnpOX6l+Qnk8iUQRcRKceO8f1QicZeX7qIs7G0VzaeNDnx6Mxld7gnLpdZVYhHycGySMgsvUWByFWaclUjN6cbGPdFV2Ay6ygoA5W4jCiR9AhekMm5gJUqNIdGwrPIUbS3bxt9ANj2u5VrsXajoWAmcNT40Cqb6RNCiMWso75ePjGIxvKpamFCEN/bI3mrVzQeQbZ1rSv6M1oRPgblq4VKSVXeaau1aHY6SaMRrvRGWPG0hLGuwuQygeXj4hBE2lsgOJ9cRp/5Ialoyi4dFDsZFOD9sCCxjRRI0W173wyq49vJ4JXLomQwcc7kCU8AwqqYdA/xPGOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79o0n6ebw/SuQzen/nUdHSpN21/3nZm/cshpYJElqTE=;
 b=NimPqId7t+/tuWECbDmvV9mE4u0+mnqFjlLkGMkQUFD3ZT+L9gSPH/yFZ29e2oRVv+88eeqnN0S2EE8ZfrStx8ODPaPJA14YP0hQBFepLM2WjoyD74/4WoIJuIL/c9drNPG1Mp9J4gRmAhqUdwvplBEAOO4M0OuWKe7O/1BufYYvF4btJD9Ulj/+Iov7A+6aFjyDa+u8pvs5BXftSRkUoQ1fruYKBtc0wjrqy5cKHU9Slp2lVsrufmXHhprTIJsxaBOHUBLrd2ue5gVgf4hSOGEbMhza7poeuN7gZsYKRc7PvC5uUYRF6H6OF92liOoYQBce6KVcDvWxYXl6aC4KzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS0PR12MB6485.namprd12.prod.outlook.com (2603:10b6:8:c6::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Thu, 29 Feb 2024 10:46:38 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1%3]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 10:46:38 +0000
Message-ID: <ccd5efc1-c06a-4971-8efa-e7d59b859966@nvidia.com>
Date: Thu, 29 Feb 2024 12:46:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/21] nvme: set max_hw_sectors unconditionally
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Hector Martin <marcan@marcan.st>,
 Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20240228181215.873854-1-hch@lst.de>
 <20240228181215.873854-4-hch@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20240228181215.873854-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::13) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS0PR12MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 77e92ad6-f9e2-4b6f-53e0-08dc3913b4be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j6M2FuOYaOBW22fGQvgeF5pgOF7N55T9abICXTcaxSa4zka1Mm98glSZD3bDX7bHeKYgEQN4ZaBpnk5z1q6n3+HiHsGIGpMi3MM/uQJuQa5Tx01mZTz80oFGvJ930Fi44WPI3ZxkwpdNkTPpGh8IFOZx/5Bc8HE33a4s+/XpxSHJ+ceM+R89X/HHOQnEUi2L7nuQjahcglGN1eUDDQpo75C0UfGji2qLtdicqz52W3BRl80LFPAQzwHmI+3sI8yA1dVo6jYUjVQbstN5uA3OjmG3nmE0HzwhOnzK9MKHu4EQwNrnPK3qZb6vb47BcYnzmgs/zDwOb4RNLyVqzecPgBgmH0P5Sry05vT0MLqTLjfK6ci/N770Lkpn0WycJrIg5fYqRrK1U7WjAfN4gPsYdSQNNf/gJGOqpFCrNbfrAS+iiBF6aYTBe62+o3ia9Xi3i1DorRXXXReub+cna2rodP7IqSLjdcBjd0cUa6xSjuce7Lkz2foT2jb41qwAEN4TEAk4GCkvMNElZ6yYeK1JEhYXyHfTZOTDPPQrIskAcvfgSNcyUjglK+QT4NFZrZ9kQT29UZXSnUQrWUw07bhOQzjZ0J2ZAsBV2awA6zpvGYylagtZOV1tUna96t7Zr8u619FZz30t6G29xIVHgnbi/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzVQbXkwMjYyVGxWbmlkUkhZSnFKejB2T1V4UE5FSjhxWDhvTGp3ZGF1Rndp?=
 =?utf-8?B?YkQ4elcxMlNSQUVvMUdFYmprOFhuT05reVF5V0JpanAxWjlFZDZ0V2pyUTVJ?=
 =?utf-8?B?Zk9vdGRDRExlQ3RSOEpWL3pNckE3WGxULzFFTlZ1VllXMEhBSFdnZEt4YTRs?=
 =?utf-8?B?VmZScTdiYXRGanR2ZHhDSUhvbWFuRXVYdkx1cEFUblh0bGdjMGQvNE8rdjNv?=
 =?utf-8?B?V013ck91U1pueUZ0VmhYemxwSTZvY25oQnZPeVF6QWd6SDZRS0p0OXNLUUJi?=
 =?utf-8?B?MW9ZVXdNTWtDZkZ1OVZuQmFHWEVDQ2toMG9mQmxyR1NwUG81Tkg2dUhhcDlH?=
 =?utf-8?B?UDZreTZ6T1hkRkhMbXlEK1d6dS9JeGFDUHNLMFI3S1NXcTAyV1hBQi95cXdz?=
 =?utf-8?B?TkJIdy9tdC9EUUZSTnoxNEIxNisyUFZMNC9GdnI0eVRqandBNlllcC9lL0ZC?=
 =?utf-8?B?cjVOTGpnL0xpcFdsWSs0YWFQaUZncnRYWEVoUHkyWmZ3alBwOEthdGYwZ0hO?=
 =?utf-8?B?SXc2dmZ5dThpRmpGUmlsd25JYkM4Wi9ubHF1U3d6QnFNM2Q2OEJNbklIczA5?=
 =?utf-8?B?ekZXTGxWY204aHIxbHBJallFRXRVT3UwRlh1VDd0YUVCdXJWbkZwckk3eFM4?=
 =?utf-8?B?ZjdDUkhGZnVZN040TDNpMFJuaklZdkZBa29STlVmVUVxRmUrN1pVanFUMThq?=
 =?utf-8?B?YWhyeGpPVGRRdFU3SVJCRDBNc25KT2k1NHhleXpadlZ4aWl4Q3IzSzVKZ1R2?=
 =?utf-8?B?VndqVWc5TTlGV1llbFlPejFna3RMc3orSE5oSXpIQlZPWklxenlseVJIR0Zp?=
 =?utf-8?B?NnBBZkI1cEFKZ2JPSGxiTHBGYWdWZFdxY0g2WTdUL013bU9QYlRjR2FkNlg0?=
 =?utf-8?B?UWFhUDJtMFEwT2x4bG96ZzB1RjJnZDJPd25kRXM5SkRkSmpIWjdQK3dLL3VU?=
 =?utf-8?B?NGNKRi9XQjgrUDQ4YkZPLysxSVVVNFRtWWFlekRPMXhrWUJFVjB5amk2ajJK?=
 =?utf-8?B?WVhpbDNtN2t4NWV4eVJ2SXc0V3NEc2VTYTJoUWx6U0NhdnBHN2I1Mk5qNnZU?=
 =?utf-8?B?UGFlSmg5bWVFYTFOS1F0S0hLbktqa3JNWUJSUjRLenVBdlRhTFNzMTlYbm5V?=
 =?utf-8?B?RUdXVHc2Q1pGZ2pFWXVsbWxXV05BeUg3WlhKTW0xLzF5cXArSGJYc2VsSWQx?=
 =?utf-8?B?NEY0bm5UYnltVHdMcThGN1NyaDZaYVNNWTVsNEJLMm5rVkY0eFNYa2ZuVnFF?=
 =?utf-8?B?OHFndlNVM3ptYTZEcnJXOVhFUlJyNUcrbDZzQmZiaE1xLy9xQWZXYlRoWHBh?=
 =?utf-8?B?MHdxNUdUQTUra1NWZXlmRWVRb2pEaXk5NzZTZXNPL0ZzSWFhaXhidUlibzZy?=
 =?utf-8?B?WElRZnZpL0RueGRnc3l2YmpjelY5dlZiV1R0K0Zuc2xVRkd5ZE5OeVF6UXpq?=
 =?utf-8?B?R0k1UEU2Wk50bTBWS0JXWFhJN2hIb3Nya1pQajJFV0FkbEhDYkFPVXAxbm5w?=
 =?utf-8?B?U1Z6TmkyRzY2V0N0akdzS0I5U0VERWR6OGoza1lRTUFPRHA3eStkcmRQdXNq?=
 =?utf-8?B?MVM3UW8yelFyOS8xazZxRkFxZHdYWXFCNmZzNDRNRVZsUjdFQ0I2UHRTR2ZZ?=
 =?utf-8?B?S1FVMDV4OTJUVllpU1RYLy9DTmlPZ1Vnc3VDaFd1WEFieHBCVW1la3IvSTV1?=
 =?utf-8?B?RkEvWDIvR2hoZTlqYWhNTGlCb1IwR0xPMHBYdGg0V2MvNERQYVZuZWRUWnJV?=
 =?utf-8?B?eGhBdEtnY1loblVIRFNuNE9BWmVjN1BKTHRvZTFGTHlVRkZFWmUyU2FmZUtw?=
 =?utf-8?B?dEF1cWE0NElmM2srdWxQdmNqUkpVVXE3U0RWMk1NWDFsajZ6RHRVYitMK2VJ?=
 =?utf-8?B?V2hVM0VDWmtsbUtKb1lIOG9pSlVJbk0wNDNkR2JZTlUzQjVGY0xxbVgvMWpw?=
 =?utf-8?B?dFJFemh4WW83ajkzTnpmdU1ORURVQUN0dUZ1bHhkeUE0RFU2dmM3dlJGSy9z?=
 =?utf-8?B?N1FBcTkvVERTbTVMQS9jNnJYNDJRVENrY0xJYTcwVzNRbWFCeUxNZExtY1hK?=
 =?utf-8?B?TjJkdVdlay9RM3ltREdwK0FONjBsRU9zaU4wOFhxM3pQRDFWOG1wRUNnRWhh?=
 =?utf-8?B?blFTaDkxbkJxUHlGb2p2dCtkMGR6THdKOTJwSVlvcWQ5cmZ0VGoveldsWWl2?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e92ad6-f9e2-4b6f-53e0-08dc3913b4be
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 10:46:38.1532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YumvZ4NzvVqJHEARG+caCiciP6dEAlrw+EmG23EcRER2R2C2u9NVqGVqWcsieIYMcVih4ithFMJfCiniOY3wCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6485
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240229_024645_642783_D8796020 
X-CRM114-Status: GOOD (  17.80  )
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



On 28/02/2024 20:11, Christoph Hellwig wrote:
> All transports set a max_hw_sectors value in the nvme_ctrl, so make
> the code using it unconditional and clean it up using a little helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index eed3e22e24d913..74cd384ca5fc73 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1944,19 +1944,19 @@ static int nvme_configure_metadata(struct nvme_ctrl *ctrl,
>   	return 0;
>   }
>   
> +static u32 nvme_max_drv_segments(struct nvme_ctrl *ctrl)
> +{
> +	return ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> SECTOR_SHIFT) + 1;
> +}
> +
>   static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
>   		struct request_queue *q)
>   {
>   	bool vwc = ctrl->vwc & NVME_CTRL_VWC_PRESENT;
>   
> -	if (ctrl->max_hw_sectors) {
> -		u32 max_segments =
> -			(ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> 9)) + 1;
> -
> -		max_segments = min_not_zero(max_segments, ctrl->max_segments);
> -		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
> -		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
> -	}
> +	blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
> +	blk_queue_max_segments(q, min_t(u32, USHRT_MAX,
> +		min_not_zero(nvme_max_drv_segments(ctrl), ctrl->max_segments)));
>   	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
>   	blk_queue_dma_alignment(q, 3);
>   	blk_queue_write_cache(q, vwc, vwc);

Looks good,
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>



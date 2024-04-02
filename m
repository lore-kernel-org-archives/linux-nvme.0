Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7586CD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 15:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UuBm1IWoktZbtlEdaAvpir/+15AMn9cEtPWuh0dWgJk=; b=dgoABYwNEvMQi18hv55lv516Gk
	09Z8B9QUqopkQAHkSD9TNf2nluR9Y3Qtf6/QUym5mjmGPlFnW7osk432c8LbrhydMm9p+e95epXdj
	DfbBD9hODyOGG/PDLzzFkr+M8nNHAjISCMHqjPrLyQ1GyLNAjm3zcuthUgdD8MoLpdYY1ZxRJg2Xh
	QGfiKOLaSTgppCGP1c2kHTkVl1JIPdc7xcM864c4VU4BDZ4uhtUugt/TDYokiCS47G+8rTaf8s4r0
	MZKqv5TNCwA/Z1qnvD2UgU+zIJdmlkibLO6BlixVRW0bUSHB3mrnCVhcdpzzEnsiy6bUbSrHxQwAO
	HhRRAjQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrgME-0000000Brqv-1DgS;
	Tue, 02 Apr 2024 15:47:30 +0000
Received: from mail-dm6nam12on20700.outbound.protection.outlook.com ([2a01:111:f403:2417::700] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrgMC-0000000Brpd-0cEg
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 15:47:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckcQPfVepaEJPvGn2LnvdrcOF2hkqxzV6GBxg48gFd58K7Rxl8KxYGEOA7Wevs/jxeaBeBj8ws2kyUstXd2ILKnPSsOdZdA3DC8p8U4BNLufyr8S65H9PMujo9l89oH5oulj5ysiM1Tecik+Mai+VVT+bRyFoYmGYC/bI5TchucZEh/VwyLIBQukTxMEsCkmh5FA2xBq/LxIlodBGJ0UROSAtH2yO+Tb3xjTiy8/QQVfD++HK28M8toxPJJ7Hi8hCgZlpnu/ucAvlriWHhqk5/aGBw2JpfegWA4liiLeUWlAvaG2lh6vtFZ7ffKTtQxVwPC5rCOvVovE2JiyB7BtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuBm1IWoktZbtlEdaAvpir/+15AMn9cEtPWuh0dWgJk=;
 b=K0/uZUSkAsZhFvQtivW4m9GF4fLeu6CfCkn4V10hw7LSYjv20z/KV04y4la2Upb2wTybef1SNt4qFh/QxKP7IPerUmBRNmzyOk6W7RtqwOj5oSRObrdDB4BzBC0Zld9yASAAczIVCkYWAtXyhQtTxdURXGpY8Vu4zcIBiZOjGVmxd7XUvCISSQwVjl1X4LkfGsewSZsfQFjYXvW28oRE2aKgr6J6SjknqVmPs3tbKo2mOpaSRxJemOt14HCyogyRBncpNLRg+iV4yHHkBS/f/HiPrpiNfePt8ARN3x5yhEh7CUvaYsytxNqlaONNRjvWFmRXJhqmWZP5y4497MT7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuBm1IWoktZbtlEdaAvpir/+15AMn9cEtPWuh0dWgJk=;
 b=Iis47RpmB+t+ewVmYLaC3BJb/OeCGxWrtMxhuBmQv2AYKTq3JaLWQ5da1PaPItWoRnToo2krlMlbu/mTRlHXMTLGynjZXorbskGf+3amYTa6ane+hQFmYPKzRoD5yAsmHRaOlgFxNkmv0Y5nNonhJIb7KQceeMVgUyQieyuT6iBGKQ6Gpk3JCPuK3pSyl693OXD2AYBZOvme0g984EQg3vxpGqzJtrHoAzga1qg1NHp21QZHUVWD8Oaj1zcZkZUNcUwJjYBtQx0d9P5cD7ZkEXnEiZ3+ii0Kw48e00RsS3kVca7jQOeG+LJcVySHTBPX8WPLW5vgCx9MJpoJjzMl2w==
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 15:47:17 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 15:47:16 +0000
Message-ID: <8f0b2d97-3497-4057-8035-c9466bc62d10@nvidia.com>
Date: Tue, 2 Apr 2024 18:47:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fabrics: Fix fast_io_fail_tmo option
To: Israel Rukshin <israelr@nvidia.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
 <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <1712060292-11054-1-git-send-email-israelr@nvidia.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <1712060292-11054-1-git-send-email-israelr@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0104.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::19) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH7PR12MB5617:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HXQ2+PKtCR3bJbiaEaMTCcrX7ef/vldsmuLoLJJcr8PYzQhRIfFGSuGzgqHliwSuQg9293SLNhOEC5ktKwgwUmruUzO48IBpkBT65Qjk8psEAXLAwy4PYK/FEq9Y6iq53klM/g9Nzf+9+T20gPgFP5iEAd5YRQ70D6mh0kixKbpeTEAMgVMirjWRibEC2c/zHsbRxqOEsXecxbip2ycg/D8rf+kxGwqoWu5WcwjFH6UWb6oeU4REdEX++DAPiY/SpGU2Nnhy+8qGplTIELoeVLnTIrnWrrXq1dJ92LRm/K8pwwluYOqPMu2hUKoTnVhfNZyW/COWARg1DhbiPWqCARBkLYViGIbvOuhiHJOObypEMBrZffc6dLnZise7VBqsogM2LJkW4vLL4ihuvI4EP3Q+apbkhegwuwuRNkw4VhZ1utcTcnpeiieyjxxWnoh4ihKwdeRI3cEX1fi8Uh/0cD/pr+trz+GsS+7U5m5lPL9rwRqZn5dMtiqMaoUIay0ytcd4OxZa6YTEDnFmxSZWGkF6WozSoG9Qp1/GkImfGD1gsjmlEOGcheiqPp3gAIVkXDR1df9R+YQEwfjlmKivgeWWBKZq/i/yTuUpCR5l1FHBKT3Ps/DksM4TjdDsJfbfhBkT8Oh5JnZ3DhaKelb+3pHiM6JdXaqv6FdphKsViTw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXBRdU1UWWUzb2wrSzFmZmd6NVJ6YzNUOFlJcTlWSlNkdTlpRWVXd1R2QU9R?=
 =?utf-8?B?MVk1TnNhQm9uR3M5Ny9wR3V1ZGlRS0tVTzIvRnh4b2hBZXJoWU9kZFFia01p?=
 =?utf-8?B?dGJ0WFNsZE9QeS85K2ZPc1IyOFFma2U1Q3hYR3YwVlUzUWNtcUs5cEY0cTBp?=
 =?utf-8?B?U0xZRGc3OGdHcWhhZS8rYThESzFnTlhPYTdBRHN6aSs0cEFoKzUyZWF5VFR0?=
 =?utf-8?B?Vng1Ykh2WHVyNHdVcFRVMVRQbVZpRmxmVnlJanZTVlBrNVNzbUhDdUhRYVZO?=
 =?utf-8?B?VWQ0WDRwVFg0NjByYTJpS1h4dDMreGNaNFdaTHB1OGk0d20vaHJNa1NZQldB?=
 =?utf-8?B?dnplQ0VuNitaUVkxdExRa2lqdmlXTFk5cFNKZ2NNSW16MzY3bFZjQUEvbEpS?=
 =?utf-8?B?TUV1ZDVmL01SWS9rRlhMSVU2KytYcjc1aFlCOXlQeXE2UUw1UXgyQlljaE5L?=
 =?utf-8?B?aWpvVWFGTFZXdnZER0dIWHJETzlQQ0tieGcwSkZGQmsxZU9qdFFUQ09WRjJX?=
 =?utf-8?B?cytrdlhMK2tnb3JLVWxKZ0tzRFVpNzRuRm94M3pTVDZQMko0Y0dRWTZxa2ZJ?=
 =?utf-8?B?bzVDVjUxdnc1Ump2OElzbHNacGJTNndqNE82SGZ3SGlCNDZOWHFlT1pJRVNY?=
 =?utf-8?B?YVpYVnFEcUlSdjQxWlVSSUJMZVlhMzQ2VU81VkxVM2NyaVcva0phc2pvQ0lS?=
 =?utf-8?B?TVozS2NLdUFKTU5lL2Z2SEJkYlRROERGVzdYYjg0cjNLNE5VRUUyay81c0dk?=
 =?utf-8?B?SXZidURzc05sUmlRRzQ0QVhNUExscUFRbFROckp1Tk1tYUZnb1IzZy9EZ0tv?=
 =?utf-8?B?NEd3anlJUm5QaTZPUGEzSzNYamRzNkVFeEM2Mm1tU25zU3lDa2tSL2FPSCt5?=
 =?utf-8?B?Y3FLSENIZE1ITHdISGpRTk56TkZ0RHNxa2VyY1N6S1BMelpFZmxDZm5rbVdy?=
 =?utf-8?B?bVE0Q3VNNmg5VEE5TWpTWU80aWh1M3UvQW5NNDJ5MzFSNlZzd2ZRSXNDK1h1?=
 =?utf-8?B?WFFRNm9McUIyTEdDSTBXY241UDZZWFgvNEhYWjlXRU9sekJXOTBTMy9rRVY0?=
 =?utf-8?B?UUdWUm5LaTlaRzNYcE9EeVhYY2FremZRVXBFdlduQ0NQeUs3bWdueWQ1K2M4?=
 =?utf-8?B?M2l6YzFJS3g1Ymk5S0grT1llM0JJL2ZRd1puOTVrOGJYWUF1RnViSytwYlBW?=
 =?utf-8?B?cjlwM29FVURJUjQ2bGpJMk5kY2ZEYmEvNmkyZVlIbElrYUtab3hBVUswaVVh?=
 =?utf-8?B?MnNhZmZVVEhuY2lXNzQ4WHBScjYxUDFCNWw4WmJSa2F0LzVjVm1MejhJY0xB?=
 =?utf-8?B?ZVBFZjc2Ym5qcThFRW00Vkcxb1cvUFNiSWJVVHVXMldGK2trZE5uOEVCODZn?=
 =?utf-8?B?ZGxpWlpaa0pvZ3dNS1VDWHZRT3orYTBVMG9XbWhUZWhJb3NnV3h1ZEc0bkkv?=
 =?utf-8?B?aU5raUtsWXdwbnBBekxZclFoSitvTkE1RGMrUVJPL0FJeVRVL280Vy9INXFB?=
 =?utf-8?B?SGt3UUYzbU5pM1NiZzRXUGtnNGhoQTBBSG5KNyt4c3FiRXBkc1RVZCsxRDRH?=
 =?utf-8?B?S1FGN25pSEdLbmMrWFZhcmhEa25uZTZQMEMxVVNjYjg4aUJXRUs3OHExdXpz?=
 =?utf-8?B?UUVCNHcrTXpJaklHcW9RV2h0R216T1hxMCsvbUpyYlV4SG0wajhHVWp3Rm9W?=
 =?utf-8?B?QUFldVUwT0xlZEp2aFRkNlh1ellmcGtHNzVRb3ZpWW5IZ1VtR0hIeS9YK3BW?=
 =?utf-8?B?ck5PaWl3dkhDTVFSSmcyRU1QdU83L2wxOHJNZTB4VzBjZGkzYk1XVkw0bXd1?=
 =?utf-8?B?UkVON0Q3dXBwZnNaT2ZrVHhLZmtnbEhsTnN3TDczaHloNzE4cXQ4K29TYVdZ?=
 =?utf-8?B?UGtETHpVWThYcnpna2VsTlZQdVBqQi9jMzF1NERXdnJpL3NSYjJlZ09vSWp3?=
 =?utf-8?B?YWpwVkh0VVlEWEVsQW9jc2d0dzZlMnc2ZSsrUXZVYlVqMDJyOHVpcHVCNmd0?=
 =?utf-8?B?R3lScjRXT0diQ1JMeXgwVXIwb24wM2pRODZUdTVHaGhQOFBxNDFrY01pRmZn?=
 =?utf-8?B?NHg4MjJTSjEwbEwvcldDV1ZGV2RoWUs1TTY4cnVpUE05TmxvY0FpT3QzbUUw?=
 =?utf-8?Q?bLH5eTbZASoKOc5mK22tLhaKk?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385feacb-aa49-4e76-4f5d-08dc532c2c4d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 15:47:16.8953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5MdFF+f09dn7v9qcv5HpwnqlrSt9TETG4Xp7YiuMKklnwBMX3FGnbmHKoIEMs7IaLysrtccYhcV8e1sJkF3ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_084728_229160_7F50DB1E 
X-CRM114-Status: GOOD (  14.96  )
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



On 02/04/2024 15:18, Israel Rukshin wrote:
> The option was partially removed by a refactoring commit.
> Return it back, because it is still supported by the kernel
> driver.
> 
> Fixes: 18de3a6d61a7 ("Convert to libnvme")
> Signed-off-by: Israel Rukshin <israelr@nvidia.com>
> ---
>   fabrics.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/fabrics.c b/fabrics.c
> index 6b25f74e..14682907 100644
> --- a/fabrics.c
> +++ b/fabrics.c
> @@ -78,6 +78,7 @@ static const char *nvmf_queue_size	= "number of io queue elements to use (defaul
>   static const char *nvmf_keep_alive_tmo	= "keep alive timeout period in seconds";
>   static const char *nvmf_reconnect_delay	= "reconnect timeout period in seconds";
>   static const char *nvmf_ctrl_loss_tmo	= "controller loss timeout period in seconds";
> +static const char *nvmf_fast_io_fail_tmo = "fast I/O fail timeout (default off)";
>   static const char *nvmf_tos		= "type of service";
>   static const char *nvmf_keyring		= "Keyring for TLS key lookup";
>   static const char *nvmf_tls_key		= "TLS key to use";
> @@ -108,6 +109,7 @@ static const char *nvmf_context		= "execution context identification string";
>   		OPT_INT("keep-alive-tmo",     'k', &c.keep_alive_tmo,     nvmf_keep_alive_tmo),  \
>   		OPT_INT("reconnect-delay",    'c', &c.reconnect_delay,    nvmf_reconnect_delay), \
>   		OPT_INT("ctrl-loss-tmo",      'l', &c.ctrl_loss_tmo,      nvmf_ctrl_loss_tmo),   \
> +		OPT_INT("fast_io_fail_tmo",   'F', &c.fast_io_fail_tmo,   nvmf_fast_io_fail_tmo),\
>   		OPT_INT("tos",                'T', &c.tos,                nvmf_tos),             \
>   		OPT_INT("keyring",              0, &c.keyring,            nvmf_keyring),         \
>   		OPT_INT("tls_key",              0, &c.tls_key,            nvmf_tls_key),         \

In the previous version I've noticed that the short symbol was 'f':
"
- 
OPT_INT("fast_io_fail_tmo",'f',&fabrics_cfg.fast_io_fail_tmo, "fast I/O 
fail timeout (default off)"),
"

Any reason to make it 'F' now ?


Otherwise looks good,
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>


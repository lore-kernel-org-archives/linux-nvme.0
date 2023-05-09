Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8835C77B75
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 10:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tZvXLNudMFjIYpAxAfKFzoB8uTigcLdXXDqZm1Mo3Cg=; b=aNgftTIFQKDna9lXccYEd/eLOn
	3i5K0FVmlrjZDfzlwHIVcHyD8e1d/S3euh51pWLZuHA2ENg0ZlOdhJj10VoO1ZWrGx2rs+UIjPU+Z
	2JO62DthmxTFQNtT4lRXaRVpOjaPqf0a7iBE+VwxuL2Pt6pVvvDw8l+kjwfevDdJ4hLnG5uDxedIO
	LQV6XYOr5RcOX+MbsA3AEkirEKOXqniMw3JWbmKkt72vx1KQfsWgiAIQDUYs/RGZtbkTEY9NOd5F8
	AsSKdEF4tZnATb3BACJWeBH5SyQFXu9A5im1BvD0A8jZJmwwjYHy4BTpdpXgfAkQfuOlX4Tp2Y7PF
	tj3Lvt0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwK8y-002oZ2-1t;
	Tue, 09 May 2023 10:00:28 +0000
Received: from mail-bn8nam04on20602.outbound.protection.outlook.com ([2a01:111:f400:7e8d::602] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwK8u-002oXG-1o
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 10:00:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsmK5lXsR/6uE6nWf5K6U6lWskOAnKB13t6EmlHWAQPn1K3LLWUF2Yo5mF7m+lAAsxLyJ7bx3XoQISgtGJbgmfsCB4u6CtFvLNkDVLSRnKpBQA7r5zyMzE7liYaaIKKTZTtDDeYKexpUnMUHA3jsLtJLh1op29JA/GswZklixgDlSYc4H2ou/tu9wo9cTGo+kUNx+m6HKoHQc5QIV2kvo48ucLo4Q35zJ6o2KBQWto1HxLWs+G1jQ9FcVxhhw01FYwfxIVoNN/Iw6fbs1lAC0uCWDU77IY/C58YlhaCV38C0Deyc4L27zUflYMtxhU0PnUQiFBH5+q8aNzDsZRKoIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tZvXLNudMFjIYpAxAfKFzoB8uTigcLdXXDqZm1Mo3Cg=;
 b=gmI69PzW5ip95jtxxDb7lvNXIGp4aTbcIN+5OKZvf9EEwm+tNZ6xdpi9lmgEiwBaxxk/yxy6ykBN3/DjVVf9O8aHuipDa8koaoN+t01gjxyVBBfroXeas/eMIoXl0CMVU64A11pGtwcDM3ajLgw419D46ULWJFbLr2hjDpOyLhzp219dvtLRtpoXElbn+tBA9y5qoT/3rkpwCzso8Ol9gumfqV7iy7ZEeWa2np98RVAJ5H69csAmgMobQbi5mvga5PmmJXHd0QKNkvbkfkjmMLFV33jEf+r8pi0M9bfcv+XEtb2O3GSTHpa3WnM/mGDXxu2p5jHjgpna9z721rYc3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZvXLNudMFjIYpAxAfKFzoB8uTigcLdXXDqZm1Mo3Cg=;
 b=ntaeKMo3dl88MXHykeUt8ufkyRl4zOenIhZXJ+mzii1x9k/duXqw5IND146akBctGQiaKQcKb5UEAHXyo5/IJFOhEZHsCYnQdf3ExF6CA1a/pRcKszX10MeivWVw45qtZcA0liJXhNyrDseCTk1xoa5tqKOB2/iJr24zEJmK5F+zSMhhtoEUoYFITKw9wOBe3RszBo0dx5fghZltMweAgEFnlxYQ5uKICiV4JqY5rpc/YITKiTz7MTwKRSgkNgQwbudyoVNcejQBG7uz426X22tCGGasn9JFrdfAcpGTXMPbft5M5TLLIFEhkpAKgvPIgvtkutoXCCPEdDl9YHJpdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SN7PR12MB7023.namprd12.prod.outlook.com (2603:10b6:806:260::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 10:00:18 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 10:00:18 +0000
Message-ID: <3acac781-58d2-e0de-6072-b6b9d67550a0@nvidia.com>
Date: Tue, 9 May 2023 13:00:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 13/17] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230419065714.52076-1-hare@suse.de>
 <20230419065714.52076-14-hare@suse.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230419065714.52076-14-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::8) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SN7PR12MB7023:EE_
X-MS-Office365-Filtering-Correlation-Id: fa80a036-98f7-43f1-f116-08db50743194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	EUWqWt5Y3ZpmCav/bJS1xJxrUlTQ3OQC83Ka+GbHvYt0DimZhhe2niwAQBWV60g3219W6+yMIivQ0yuMuPbF2V4nqdMZhlFoCrtYLJh/xgjXjZF5AqMo+S1QvmIgu8uDSoYNgggAEPt8SRu827nvPFa2ngheABlNy0F04GMm8G+i/Y9FpxRC97y0GN2368PAOeJ3xSJHpfaJkl5VDn4ifoba6UEuPPFp2q8uU0ovlgB5oklmLJeMUMij6Ts3sorgfFskuGOv0cX4Gn7QneQeNvk064uCoA0NignV7key365S7XPk7Lacfcv3rngmDUpnbRb6WJT5i+p1XGU3lTomJG1qyoe7UugCxPnHnBEuCKZW19tjD+gt3SQdbchKRquzZfwQ4u0cJLuM5zZI6/FYyFqMJASTUyxhKX3mkd81dU+ws1tbE42RsZamUdDT/Ryy3hhu9eINHpQIiD4QfcKuhvZmPOw4nVihspvYcs+LloJ588/oTWbYjjWCDCI2/9bIi2CsVZz8RN7ydE531pO4JnZ6NXXLo/a6BVdloYd8NlZalozRt50tXy719nGf8bhnp/4A3Mbt0ZnKiEANs99uoOvpk4c8IVA93nNR1MtNmLPoL0qBUZvqjlMWOHfaCrRP94EFwrCScv5KntaM91D0+A==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(186003)(83380400001)(2616005)(2906002)(38100700002)(36756003)(86362001)(31696002)(8936002)(6486002)(6666004)(316002)(8676002)(41300700001)(31686004)(5660300002)(478600001)(110136005)(54906003)(66946007)(66556008)(4326008)(66476007)(53546011)(26005)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?Smo3ajhlY0tlM2FneDdvbVYvM09uWkVmWWFHR3VMWkYvQlZKZS9icFh5MFZ0?=
 =?utf-8?B?blBHMnlHNlp1YXlBYmt0bGozbVNkODdCbVNaME56ekVUc1JUaThtS1pMNWs3?=
 =?utf-8?B?YkRPMWlvUXU1L0FoVHRuSlpxMDVxdnQ5N0hOTXdsZFZzS1lxdGtYR1BHUGpY?=
 =?utf-8?B?RjdiYkNyQjVtdnZrK0VKbDFSMXJBQ0IvWTRMSG54NmdiTk53b3VKY3V2MWNY?=
 =?utf-8?B?UDh0RUFLZTZraVVhVHU3NmVidGlPdEhXdGNDc2pTdlFleWJVNklJWmZCdGQr?=
 =?utf-8?B?Z3ZLY2UrYkZ6dHVWOCsxWWZiMXZ2OEVBV3lKZTloT280MVF0OFZEN1gxRHpv?=
 =?utf-8?B?d0hSajNiYnM4RmJQbERUQzNqRTcrNTZyZ09sa2VDSmduM2JIS3hRQ2x3Z2I0?=
 =?utf-8?B?MGZwTjdpOGRCUnp0VnlrczFRR3lKNFEwNHgvM3VyZStsU2NPdG54UENZcmEy?=
 =?utf-8?B?eG5Ha2E3T2J2RFJ2VTFKL1ZDNC9LRmxGNGJqZ2Z0aVBMNVBkcGxGNjBldTYx?=
 =?utf-8?B?V2t0VHpvSU1KdkVGa2c5UHFpYU5YYmhZS281M2ZIY1NIUlNmUG5nRUhhWnB3?=
 =?utf-8?B?NkxjZGRPNGxhd29wUklyaHVSSFZKaEJTbkgvUzBTZXRaMk03TzZYV0RmK21l?=
 =?utf-8?B?VTVJZ1VaaDlHZFdYZ3dMYWsrOFRpRjlGVXdRVFQ4QTVXcGlLUGx3emRRT0xT?=
 =?utf-8?B?QklwRzBucHRjdGxYK0NOblA3OTQ1MllKZTlmRnVWc3dPb0RwV3Rrbkg5TUdq?=
 =?utf-8?B?SHlhZEpmeEtkMkJOempLMUtkWmxGUGtHYTVYdlI0Q3Q4Y2d3M3phYkJaR0FG?=
 =?utf-8?B?TjFVUytDYWtYOEtPNVpUK1habDZ3UHFyK29hVHVjZHd0dXlYTTY4TElicVBX?=
 =?utf-8?B?MGtHNE9DcVJlc3lDSmNmVFExUXVSdHZXUmcwMStHckpwa1hXcmt0YUN1VHl1?=
 =?utf-8?B?bk5rNk96WTZDbm5PbUo2cXRCdkdBdHBaYnJVL0gyWjljUGwzV0RPZ00wcC9R?=
 =?utf-8?B?TWFUMCtoRTNJcnRCNkJXd1dqVzdEU3BKdGtFc2IxZkVBd3phZXlkMjVzRWdp?=
 =?utf-8?B?NVpNQ25FUUtVbnFIenpDSDFXUDJKN1YzdmNhU09QNEJ1QUhTNjQvYUN2dFBr?=
 =?utf-8?B?cHBrSUtOR1crYWx2dFhaenhmQ2FWUit0c1IrV3VqalRUZGhjNG50Vmo1dnZa?=
 =?utf-8?B?dVdyNlBlTFkrWHlmVjJUemhVb040SGx5TDYzUExLbzh3S0QzUVB1Rmd5dkg4?=
 =?utf-8?B?ZlRqdVd0b0VkVGhkWHBWZTE5UEM2ZUdsbVVnOVR2R0xmMlpDVDd3bmgzK1BC?=
 =?utf-8?B?U2dmN3FlL0xUclpIR0paOC9FdkdlTGxYSkFERTZYeGcrT2E3NUpWa0J2eXM1?=
 =?utf-8?B?dnBFMDN2N0w5NU5ZR09XRHFGYkdab2IxMXpubzluMlJPTHU0UG54SUhCMDIz?=
 =?utf-8?B?SXZDMnVrcFU1MWV2TndVN0xLZy9kNGVZR3pwVWJnSXhJR2tmN2V5bFM2RkdP?=
 =?utf-8?B?QjRHMitLRzlzSVZPM3VTZGpxaHRLZXJ0YmV4SzY4NEYrR0htZGVjaTREbFl6?=
 =?utf-8?B?eTBKUjEvVXJKRm4wYzl1bDh2eXJRbER4dU5nZzJ6bjR0UHU4U24xNTV0R0lI?=
 =?utf-8?B?QzVOSitidnVRM3JGWUY4SkNVZ1RRTVNyQ2hQa1Z4R3Z5bVNDOEllV0E4Szhz?=
 =?utf-8?B?dURCTHU3Q2xxbEd0dFNCUnVXcGpJN0dIWkdSamNHc05DZ1QvU3NsalYyd0pP?=
 =?utf-8?B?M1U2OTNkbDI5bU1ObllSb2dHMUpFUTEvZXU1dnp5OUlKUWpPaEtRYUxwM0FZ?=
 =?utf-8?B?L0lDRHo0d3g4Qk9BL3plM0ZFKzNJa0FMdnJTQ3FGd3JOTlJLbUg3bWU1TVFJ?=
 =?utf-8?B?bHNmTkEzNlYzVDk2dzlQVU5oYURvNFhVU1ZwZXdwMHVuVjdZZ1lYRmV2elo0?=
 =?utf-8?B?R0pFUnlXNXFtT3pWZzk2eW5rQklKaEVjMnhtejR1eTZ6SHUvdHlLWEY3U3Nm?=
 =?utf-8?B?M2RDRk83Z0RpR2ViMUN1YjB5TEhGZ0V6MlBxZE9zNmsxS1h0TTRabGtjajJq?=
 =?utf-8?B?VlNJUGJhVzVwRy9YTlFNcU51MkRNSnRRQ2JIajdRQW5OSXdxKy9hbktmVzhS?=
 =?utf-8?Q?et59H0qPdGd1lH4kUJsbNZHEM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa80a036-98f7-43f1-f116-08db50743194
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 10:00:18.3563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1ZmH8oZ5CEvwWN/tPVqp2s0OsfJt1j3O/JxvUyugovk7AnsrKUr04MOUI8NjVG+FUBWElcX5zRe27RT4ZIn/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_030024_601262_DC855819 
X-CRM114-Status: GOOD (  24.58  )
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



On 19/04/2023 9:57, Hannes Reinecke wrote:
> Parse the fabrics options 'keyring' and 'tls_key' and store the
> referenced keys in the options structure.

Please add an example of how the nvme-cli will issue a connect command 
with these new args.

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   drivers/nvme/host/fabrics.c | 69 ++++++++++++++++++++++++++++++++++++-
>   drivers/nvme/host/fabrics.h |  6 ++++
>   drivers/nvme/host/tcp.c     | 11 ++++--
>   3 files changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 2aa8fb991455..8fb80ccc38e1 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -605,6 +605,10 @@ static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
>   	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
>   	{ NVMF_OPT_TOS,			"tos=%d"		},
> +#ifdef CONFIG_NVME_TCP_TLS
> +	{ NVMF_OPT_KEYRING,		"keyring=%d"		},
> +	{ NVMF_OPT_TLS_KEY,		"tls_key=%d"		},
> +#endif

redundant ifdef here.

>   	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
>   	{ NVMF_OPT_DISCOVERY,		"discovery"		},
>   	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
> @@ -622,8 +626,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	char *options, *o, *p;
>   	int token, ret = 0;
>   	size_t nqnlen  = 0;
> -	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO;
> +	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
>   	uuid_t hostid;
> +	struct key *key = NULL;
>   
>   	/* Set defaults */
>   	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
> @@ -891,6 +896,66 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			}
>   			opts->tos = token;
>   			break;
> +		case NVMF_OPT_KEYRING:
> +			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
> +				pr_err("TLS is not supported\n");
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (match_int(args, &key_id)) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (key_id < 0) {
> +				pr_err("Invalid keyring id %d\n", key_id);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (!key_id) {
> +				pr_debug("Using default keyring\n");
> +				key_put(opts->keyring);
> +				opts->keyring = NULL;
> +				break;
> +			}
> +			key = key_lookup(key_id);
> +			if (!key) {
> +				pr_err("Keyring id %08x not found\n", key_id);
> +				ret = -ENOKEY;
> +				goto out;
> +			}
> +			key_put(opts->keyring);
> +			opts->keyring = key;
> +			break;
> +		case NVMF_OPT_TLS_KEY:
> +			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
> +				pr_err("TLS is not supported\n");
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (match_int(args, &key_id)) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (key_id < 0) {
> +				pr_err("Invalid key id %d\n", key_id);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (!key_id) {
> +				pr_debug("Using 'best' PSK\n");
> +				key_put(opts->tls_key);
> +				opts->tls_key = NULL;
> +				break;
> +			}
> +			key = key_lookup(key_id);
> +			if (!key) {
> +				pr_err("Key id %08x not found\n", key_id);
> +				ret = -ENOKEY;
> +				goto out;
> +			}
> +			key_put(opts->tls_key);
> +			opts->tls_key = key;
> +			break;
>   		case NVMF_OPT_DISCOVERY:
>   			opts->discovery_nqn = true;
>   			break;
> @@ -1055,6 +1120,8 @@ static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
>   void nvmf_free_options(struct nvmf_ctrl_options *opts)
>   {
>   	nvmf_host_put(opts->host);
> +	key_put(opts->keyring);
> +	key_put(opts->tls_key);
>   	kfree(opts->transport);
>   	kfree(opts->traddr);
>   	kfree(opts->trsvcid);
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index 5db36e250e7a..2ff7b7168a40 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -71,6 +71,8 @@ enum {
>   	NVMF_OPT_DHCHAP_SECRET	= 1 << 23,
>   	NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
>   	NVMF_OPT_TLS		= 1 << 25,
> +	NVMF_OPT_KEYRING	= 1 << 26,
> +	NVMF_OPT_TLS_KEY	= 1 << 27,
>   };
>   
>   /**
> @@ -103,6 +105,8 @@ enum {
>    * @dhchap_secret: DH-HMAC-CHAP secret
>    * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for bi-directional
>    *              authentication
> + * @keyring:    Keyring to use for key lookups

is it only for TLS ? if it does please reflect in the comment and in the 
name of the member.

> + * @tls_key:    TLS key for encrypted connections (TCP)
>    * @tls:        Start TLS encrypted connections (TCP)
>    * @disable_sqflow: disable controller sq flow control
>    * @hdr_digest: generate/verify header digest (TCP)
> @@ -130,6 +134,8 @@ struct nvmf_ctrl_options {
>   	int			max_reconnects;
>   	char			*dhchap_secret;
>   	char			*dhchap_ctrl_secret;
> +	struct key		*keyring;
> +	struct key		*tls_key;
>   	bool			tls;
>   	bool			disable_sqflow;
>   	bool			hdr_digest;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index a3ac512fd1cc..84bf6c80cc7c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1582,6 +1582,8 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
>   
>   	dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
>   		qid, pskid);
> +	if (nctrl->opts->keyring)
> +		keyring = key_serial(nctrl->opts->keyring);
>   	args.ta_sock = queue->sock;
>   	args.ta_done = nvme_tcp_tls_done;
>   	args.ta_data = queue;
> @@ -1890,9 +1892,12 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
>   	key_serial_t psk_id = 0;
>   
>   	if (ctrl->opts->tls) {
> -		psk_id = nvme_tls_psk_default(NULL,
> -					      ctrl->opts->host->nqn,
> -					      ctrl->opts->subsysnqn);
> +		if (ctrl->opts->tls_key)
> +			psk_id = key_serial(ctrl->opts->tls_key);
> +		else
> +			psk_id = nvme_tls_psk_default(ctrl->opts->keyring,
> +						      ctrl->opts->host->nqn,
> +						      ctrl->opts->subsysnqn);

I don't understand why this patch can't be squashed to patch 11/17 ?
If possible please do before next version submission.

>   		if (!psk_id) {
>   			dev_err(ctrl->device, "no valid PSK found\n");
>   			ret = -ENOKEY;


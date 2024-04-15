Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FEDC4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Apr 2024 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iFpbl9TotiY00j/GS/Ackt+bwbP1omU/ol4TlA8WUaQ=; b=l1N88rItAI1o5bcz6C+M21lMbM
	G21lNLUsXA7jxZVw3O8dfvXgEOqE5l8jrCLt5pyks9e+loBFGPFJnbbaWvEUfzKhDvQR10MzgjF29
	Q6ZSIItW1830t7VXAubAdQ9Zg5C7DOAs4p9yptENbIpAZ2vUtvg85DHU6vOG1qh9NutB4LT4DFGvZ
	hXbcUPOjpyESAjLR+Sl8gHowYRaxi3TMVceA6hZqUs3ni26KyKPhj55Pb5zkfucRoYRxgW/Qhglod
	+n1ATPCsk1XIsowxInw6n+cbrM1Akv5yBGlqe3u2SnBzs3F86qQfXgToj1MM1AC0Io117WOjYS00i
	T12kvcrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwNK3-00000008got-1zxb;
	Mon, 15 Apr 2024 14:28:39 +0000
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:200a::600] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwNK1-00000008gn9-1dhy
	for linux-nvme@lists.infradead.org;
	Mon, 15 Apr 2024 14:28:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XumjXcMIVxLGSrR4WFkyksvXKwAgo+1UYmh5i1z49M4G4cZ2qiyXQdtSjdFSNgFYzBKcZXB/hFyp6WztkJHKMv6WdekDQ2jk0RGbCY6w3MmKG/rkbCRgM5aZxSxt+h0HYEliQonnaATIA3Dt6iObSSwx9nVl4cOKTy9rIdNj17PyJc+eQujdhqZ60gPVG9Kq1FZNxRMTpk+90rkF4E971YzqsgVwodqvaixVJwXmprqKg00oBXVAAbWJVPwLEV0qiiJFbgPuaTfN2BEiyc0bPV2WbVjus2AjwcqgscdA+lrBInEZmO6rShA/E2Fb87IOTU73dQD+uDwXwzJ0luam/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFpbl9TotiY00j/GS/Ackt+bwbP1omU/ol4TlA8WUaQ=;
 b=HEDT2vSsTTQKpD9MMvrIsUnueEP6S18jw4YjOlu1BRuwpGMh5ZG6gCNuP8CGHS0qq3OvLPu294SMuOt5ycL7CRnEqpOMkyWIF8oMgu4q0OlRNgz73CztyAIu7MEmPlgxF359AE7FUctyfzPa4L9oNJ9wsorxx6bU9kmsXc97wKLkJUwiVjJVPTPfKY7tJXwvBXptOZ1Q/ST6MQrXV3jIUi6ScSve9HjTD81TthWIcRqo+ZPlR8r8qBr5IZD6U81JQviQnqVsLTZSTyj1OGureo/ZF7Xc6g9U0mFSPlanx8t+ouFUCeA9JyQX+VnP8Zll1UljFq3WutAWyMCqIV+aFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFpbl9TotiY00j/GS/Ackt+bwbP1omU/ol4TlA8WUaQ=;
 b=nFoSYpKVLE+lnW1rPuJNSc4rVBwoPyDDQOMNXHwLexiSSspH7z6YHu4nVDEDtBSGegQQFnu7FeIzCTyvYafs88y1i3p7m2bljW9EgqBHA+NswZEIU1gk+fosDpA6nJXrTdxkFDKjVd0gq41250A1L/kAhlGf4fTvl24aKd8Trr3M8gfuULKPhWik9NQbueGs0CGqPgBT6D+9PloqaYJBkTNW5EtwUipfNbxiPk2kQIz9cnmgaJOVDHv0hGOyGED0/+56bDMFsdCy6kszQ/nCIl1xqlHo8X6DefTpnTwwoUoYufYc/42JSx4u1RSUg+auEf0Z3tlnPyqFlwu7T4XeYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SN7PR12MB6792.namprd12.prod.outlook.com (2603:10b6:806:267::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Mon, 15 Apr
 2024 14:28:25 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1%3]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 14:28:25 +0000
Message-ID: <a486bad2-917d-402b-8c37-70422dbcfeb4@nvidia.com>
Date: Mon, 15 Apr 2024 17:28:12 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v24 03/20] iov_iter: skip copy if src == dst for direct
 data placement
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, viro@zeniv.linux.org.uk
References: <20240404123717.11857-1-aaptel@nvidia.com>
 <20240404123717.11857-4-aaptel@nvidia.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20240404123717.11857-4-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::16) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SN7PR12MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 24afb780-68aa-4c66-da2c-08dc5d584f4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yZSoUdCYoql1zl9PmoXuR73kmerSTyCebpz2K5VPInLlZkEaG/XuhRwL5rEaMRnZcsnW29zKOjaFhSSDpVN0uEzKgHap+eOOoT89dKpzEecwIq1FPmj1XxFJ1srgsFEkaLR0O87qSVxKxkL3fhTR1NG9f3IA55/Z7UZrtJcNvl1BoMzDy5szwiiHIKJ/Mufc36gAbqLOkTDseJoyBKG61q0dNnWRtFWYjjkXh8f0Mw3awM1aRhs0EqZOZL6A+VT7ahOTyuvSSU9UDN5er0+L3O8AxIDDZmi50133+XyOafP0lxdNf51Savj9ho6xWaHQGBrOC/07Jp08Wwf0Xcy8Onr/a/+jv9hbEg3JrJWvkPbNpzeM51DD/GMg4CE2hg4pIeu3R7Jcf2ydJ6LjcamYMxaF48wPMZHqkVXRaWwIfrjFxQ2Am6BV6Ntbb0MPM/kcYlSyAwKw2Yo1sJj0UtFDiHKqbO7jAhzmxYrHCxXJCakel0yseuYuhntVB0x1asL/KjyexJN39Lp+P4z4pCJMbAXrE+h/lCdDdn+YV/RtOB3qm9Mw6dnxNStdUD7ivGK+s/VKjYgh8qynjBxey9z96mMgtLQSpMoopd9SxbuSwiYAwqwfNRbWJScVrsS5KN0IKfJ7LCabbJkrePSiJI+o4iA8+bsRoDEAnpgY0IoswF7oUyFfJll/LqDdfDh+DUZrQpgCw28O+eVC7yFA5TisUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTZuZmdMNTErVVpaSnFlYWxPSmJieWhUME0rYnZjMXFXeThqWmNVTjdVZktG?=
 =?utf-8?B?T0dxUU5pRFJDYXhWUnJOUGdrekUwdWxCbFFUVFM4KzN1YjZ4UmZYeUNNLzRq?=
 =?utf-8?B?bUkrWVlnUlorOXRUSGdOcmdzUHNqVGF2ME11S1BjQUc1NXh0aktpejB2VUZV?=
 =?utf-8?B?T0Z2MnZGa2FsNFhxTE5mVmVYV3ZvdGFrZHRyRkptekNuMC82WGRWL3VVNXBa?=
 =?utf-8?B?b2VDZmVXcnQzVU9BUDZZdlQrdERRRklCd0lLN2RkTjAzczNQVWhFbi9wSUE3?=
 =?utf-8?B?Vm9HSXVIQk5sbUxuSVg4OGc0NnJCTUJUYzg2d1JiSEVhd3hHWXo0VmRvL3M3?=
 =?utf-8?B?UVlsU3VObUI5alFjaExhRmRZenlQYlQ2cjZWOGJvaEJLQ1BhWlBLNVdIbXJE?=
 =?utf-8?B?QUxjZ09GMnRZRVJhVzcwWnlYVUJzdVgxZDNmLy9ENXd0OTJnQnlCMUFMYnYy?=
 =?utf-8?B?NnE3Mk5ucVdRcmt2VFZKa2FKMEEwbllpZGo0elFmSXZvVHRxWWUvM0p4S3Av?=
 =?utf-8?B?bUJlZzVTb0ZFOVM4ZmFQVlN6cjFycllaM25PSC9qQXFSdUFSZ1lVdTlJOElG?=
 =?utf-8?B?K2ZQTG4ySTdBWnYyajlOc2tYblB1WXJ6emIrQUkwbXBaeDBrN1MwV3JwZnlC?=
 =?utf-8?B?b3VEWENveWpYaTZ5UVlKQkxITkFwWTlsUjFIR2lXQlQxbGpHc1pjSzRzTXJo?=
 =?utf-8?B?OXNJeG5taU54RTVtVDh0dVBuaGRJd2p2SDdPOHNSM1hNcXE4QXZNUzEzL0xK?=
 =?utf-8?B?YWNMNzBITWI0bVpheVhSY1dGaE5KaVZ2SXd5YTF1THh6N0FzcnpHUWEydlJ3?=
 =?utf-8?B?YzF0aFZaNW82S09BY0xrb0VpaTlxNlRKckEwMTFFa0FrWFJGb2RUR0piUFpZ?=
 =?utf-8?B?cnp5U05vR0lhN2FQQ3FTS2xDdXlZN0NOOXVSTkk0dzB4QmptVXZJVmlPc3l4?=
 =?utf-8?B?akgwWitZZGpFTFI5MkQxbHdzVGRaZjEreEZMVGIraHBLNElldUxwa0RMb1FV?=
 =?utf-8?B?ejhLT1QydTE1aVIxd0txWDE5c3ArdmhWcm8yQWFkNkxxNy9CMHAwM052OXl2?=
 =?utf-8?B?NGhuSks0dmxjRWVxalBxb01pUEpiV3lIZ1JPSHUvUzVrbW5LRmsyZldkZFhR?=
 =?utf-8?B?Qk5yS05iOE5UWHhvYU5pTU5nUHBhaVp1bHo5cEk5TDYveEs2eHlMejlETXFD?=
 =?utf-8?B?VUwxY3lNaTBKYkFXMjFySlRYdzNaakx6MDNUQUQwZ2U5d0dxQ1duUXRKSkc5?=
 =?utf-8?B?V3VIamhJOUlvdkhGOTVMLzZuWEg1RUVmeVZSbS9nRDJraUtGL0xMak9WMFBP?=
 =?utf-8?B?Y1dBK0NZODFNUk1yNklxVVluZVVOMGZxMW5sSG5lb1lKUDBFdHdIaWc1WGVF?=
 =?utf-8?B?bmRxQXRMQnJzK1lhdWQ1NjJZRmhkVGVtV2l6V1czZEY4M05lRkFhSEhRVC95?=
 =?utf-8?B?YUVPTjl0di9WeW9xS1BlTGFLTHJoQUNsVThTa0FSZkRKREYzU0xTcEZLSDdz?=
 =?utf-8?B?aFVWdVlCTGRzbXNyTisyR1lnaXdXeXdEbjR4bk4xT000M3NIVk01amJtNjV1?=
 =?utf-8?B?R2NmaFFVdmtHWWJNN0k0ZFJqZmx3SlFDM1QxeitjTHZNVTMvSWdVL1UyL2xq?=
 =?utf-8?B?QW5BV1FaQytrMkdCY0Npa3E1RitYU2QrOEhHVGROc290QXhDMGdqZXNrRGNu?=
 =?utf-8?B?N2hQRkJic21pRDhWNE82UXUvQ2pSY2hjRmZ2WUQwdUJxUHhMVFlGWERuZlVo?=
 =?utf-8?B?MTBwSmpoNUdUY1M4cWFUMXlMb2lGRzFCM1RjRXJBK1BZYSs5cGpLS2tnVU1F?=
 =?utf-8?B?a2dHUWFTZDVWUnBrK0lEK1JpNy96MzZxcVNzQXZkRnBEdFdiUVNhYnVSd1JU?=
 =?utf-8?B?K04rOU1lVlBqbkVnMW0zUmFJUjRjUWFNT1A5T2t1N0tsTE51RFNsaFpDT2Z2?=
 =?utf-8?B?QzVva0ZwZTUyZXBMTUsxYkpJN3dja3M1UDJZcXFYNFdWM3psd3RZQlpnL2sv?=
 =?utf-8?B?STFaODVRZlBVT2pEbTh6UklERi9HTS9NS0liK3c5ZmJ6NEhxUUtGRG8yZEN5?=
 =?utf-8?B?UnA5VUQ2ai92M3d4c2ZMZzZrUnByUDdtOWJKYVRlTEUrb2l2bTVDaExkMlBk?=
 =?utf-8?Q?38gbswlHaACzThUASUzdzAUhJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24afb780-68aa-4c66-da2c-08dc5d584f4c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 14:28:25.1659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4/BhUP+TsctHbsh9Z2psAHJbjYtOxu2tcP+0ccDJGJDRLa+n8YfWx/F3H80CZ9HYyqev/EZmXVz8q7vZ15DQrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6792
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_072837_506134_AFA74F36 
X-CRM114-Status: GOOD (  16.30  )
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



On 04/04/2024 15:37, Aurelien Aptel wrote:
> From: Ben Ben-Ishay <benishay@nvidia.com>
> 
> When using direct data placement (DDP) the NIC could write the payload
> directly into the destination buffer and constructs SKBs such that
> they point to this data. To skip copies when SKB data already resides
> in the destination buffer we check if (src == dst), and skip the copy
> when it's true.
> 
> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
> Signed-off-by: Shai Malin <smalin@nvidia.com>
> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   lib/iov_iter.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 4a6a9f419bd7..a85125485174 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -62,7 +62,14 @@ static __always_inline
>   size_t memcpy_to_iter(void *iter_to, size_t progress,
>   		      size_t len, void *from, void *priv2)
>   {
> -	memcpy(iter_to, from + progress, len);
> +	/*
> +	 * When using direct data placement (DDP) the hardware writes
> +	 * data directly to the destination buffer, and constructs
> +	 * IOVs such that they point to this data.
> +	 * Thus, when the src == dst we skip the memcpy.
> +	 */
> +	if (iter_to != from + progress)
> +		memcpy(iter_to, from + progress, len);
>   	return 0;
>   }
>   

Looks good,
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>


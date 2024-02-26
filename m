Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5319FC48BF6
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Feb 2024 15:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sTdEn8j+11yA/hF9AdTeRPIjNi2PCrjylshlrKNBa9Y=; b=lTann/TgkfslY2U6I8Y0X0ynyG
	Idbf+FQdqLhhC9fSA/6sXCna0imwntjdfwnmQOKULMC31HE3dHocihgcxsUl9o36c/i4TM1imemqU
	W8exaMKCK87H57irZfdBnXEMjhLAs21inp8zl+rQ6KJGROToRYF4SrJ90z8WfWBH6WEuj4I1EPodz
	8oFh9iEyfNUwfDPXfinr3dZfpbxBRR+a7M7mQFZ0Weeqy1vIqFDXdGd/6ylYG4OJ+gDpGMdKDBCWR
	HeDt7TpY6zPEOtr5hspT8L4YJnFNSl1wGvlgd+H+dtd5xKoo7DVv2FhGU//a9b5IzTPek+49Zc9Qp
	fCCrHRew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1redCN-00000001V12-42J9;
	Mon, 26 Feb 2024 15:47:23 +0000
Received: from mail-dm6nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2417::601] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1redCM-00000001V05-0w6y
	for linux-nvme@lists.infradead.org;
	Mon, 26 Feb 2024 15:47:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhhQJjgXSr/IrYRoScpI3QPi9XsNzRSzidiEmBnIAN15gne7ejKnavp/3ANIAqKb95SwMabtI58qEwuUJlurPUkhmkpFKIXkFNhLmNSruyYJlOFtqrpOQdaCRchYsKzuzcbz2hm1dYUUZPJ/Zu2+Jc/s5RQ1wqQYVuXOhcOVctsa5O2oTjGQL/kq0M4RCmoD/v1TWPR9tLlkLVTjy3Xa8LemzzlA84ykwD82REIqf/BMULNL2efwkDn1KsCUFP1KckKMQP26Ie4OUJ1IxXuzbkZVMenu7QAlkAt/d+fx6SrQbmfYB6pApqdjV0Sd+VpekoKycMMkpeN4L3ENl5dOPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTdEn8j+11yA/hF9AdTeRPIjNi2PCrjylshlrKNBa9Y=;
 b=PIXulGiWlOhwy10OPlqHfK6HHxAKUBTWD/DcINjSsb94qp8OkTD93ddle9zMXOcX5m+A/wAt+xUflEnbMmGUkOxjXiR8xouMGoN/CXBGign1qhjyWvVtJNj8qJGZdWP5HYRtXfbJji4xdFJipDnunvfdWXbSnU2ucTqt64DSrD+8KKgI2/O5iwm7/AwnAlrYfziScaTe5kCdnKq8pw+8GfFaUOqllJWhcSBsQ/Twp+sUvHPw1zFFCdAY+JSoYcqyg3zc9ZXXzb+8bR9kXeCl1jGXwSUhzKxJxGTKq65uYK0z7lvPfoD6P2WBups6Yyc5BVgFZ4sulyJ04qX19L3fvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTdEn8j+11yA/hF9AdTeRPIjNi2PCrjylshlrKNBa9Y=;
 b=Am+sDzdcLS5nKPJiIk0s6lFoAkRElEmp0HQ/0gGp+uD+V90gd2VF0RUEBLd3h8xlelCc87Xv2hk/yp8WTLwvkFYEKBYIeEgq1BAVIIaG9P66P40lEP2IYI7p4SP9fG/AutgJuWlRfWZQXIk401JqBxADhT8mybQwdS0FLpdCi54zboLPFfMsCYUJRYq2RG6CMSaPxni1HhpY5h+jvJl93O76f1AhAWG3L2NF2s16Ce1u9M5oI7ToLJvfmY8C3oZD2QEpMUwNn+a33rOneg3sGfCZVQjjkg4ZTijRwktl505gHQTEmwnFapcYk762b6scyN2Wli8kaBEd7r2h707org==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB6638.namprd12.prod.outlook.com (2603:10b6:8:b5::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.33; Mon, 26 Feb 2024 15:47:06 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::50af:9438:576b:51a1%3]) with mapi id 15.20.7316.035; Mon, 26 Feb 2024
 15:47:06 +0000
Message-ID: <a94ee121-bafa-41be-a648-ea0a1e97520c@nvidia.com>
Date: Mon, 26 Feb 2024 17:46:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] Introduce new max-queue-size configuration
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, kch@nvidia.com
Cc: oren@nvidia.com, israelr@nvidia.com
References: <20240123144032.27801-1-mgurtovoy@nvidia.com>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20240123144032.27801-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0184.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::10) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM4PR12MB6638:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b5e7747-b488-49e1-242a-08dc36e22f6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yh//wfZVhsecq2vKmbE+umqV0pxPAVo71Y5r0i0FW6PFChE5GTH2OObzLqxNk4Ot82cK5MqRFHBK44nR0nHMeZeTc57/LnV4Czklx95N7diEN8CaVeqmRDiVVVuPPU9isVCwWI75qZ13GhD4NT0I3t4L10SM+0vQJukWHU3pYSJ1DMEOT6OZBa8IGLlLzW27b3hMiR2+2JJNTxHXQvEKU9DviT8nCRRMUUFzX4VimfPdH1pUfjwKiYHjErpftJg8Ys1q7dlgqimiORdeci52o6GHPOyx63i7Og9GUP4Nzlznpg6ak7ifDE9EQSDZh49CCN8sAml5YWtmaH6ApH9k2rNGg3HS13xI6nE/qG3mPbdbduB1lwlt26OQbizoaGtXBllot03Gnk6wjAtnhd61dESBRFmKQjzYtllUkeWhPAOq40oGcFLHDhpghuhiB036Ppi9LnCBBPnUTT5vUBVVbOzz12xIu6DmtZsbgsUYqXdlUoacFm3Q1Fg4nuXLUrOaz8hhsIOdaOIV954UlwfLFJoPpkac5zZt742lDMLUNbauslcwIltwhfyeYNPTyHIpNvf/x+7bLgKP1ulH9HRUCH/wuCyj5FF27vGNfB4NTR8Llzqoy0+0FJa+R3lW1rMPxBpVyTvXCe3gmql+496Ceg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkxJWTRMNGdCTFpRNHFFUzdpeXh6b1RpNzdNWDJuN0VHbHQxbkUvT2x6RTJs?=
 =?utf-8?B?eU5SVkRPbUxpejRvK1FJRGtoTzVsYVBRWmZ6Nk5HYkZoV1FqU0pwU3prYmpD?=
 =?utf-8?B?ZWlPRVRwSVlwNnBjQzQ4eUdSMHlLOG90c1RUZ0NMeFBEa2xpaUR4M3FQZUUw?=
 =?utf-8?B?Wjc2NjRMenFHeTcwdnc4TENXQ0ZzNTNJOEFFQmhFV095NXBoeXJJN0FaNXdD?=
 =?utf-8?B?TXNUeGtsTWhmYjQrRU5rUkpVelpuRWVQSkJTVzl2djdyVVZiR3BIaEMxMmtt?=
 =?utf-8?B?WUtBYTZQZlZFU2NTZFFuNzJIVmoybFNYUnQyRHJ3V3NNMEpMRWU2b2JMbXEw?=
 =?utf-8?B?cVp1ak9QV0lQRzI1TjMwdE1IY1FCNHBQQVlpR3lOa3Y3eXpKeXdQL0UzdVYv?=
 =?utf-8?B?eFYwZGxxSWtEd3A5dzgwS0lKNDdhWWkvSFpDRVNSSFNrNld0b2hJMUpKSHJE?=
 =?utf-8?B?b0xFeEZSNWhlNjZpZ2NSeWdwMVZoY2NiS3kyZEVvYkJDMDlsOU0valVBSUZq?=
 =?utf-8?B?MitNOEpiNW91UEFyM3N5VVJRNnJGTFdSZTNLNWdzY21CZW8wcUNCUnoyVmh0?=
 =?utf-8?B?MEg2QVlJVis3STFrVEdpRTM5c2o4YXVGOVZ3K2ZCb3ZxSXJ0ekVVRWFTckpC?=
 =?utf-8?B?U1VFN3FZajVadFowZDluSUwvNVc0aFJNUUkwdktiY3F4QUVKbXhIRjVtU29y?=
 =?utf-8?B?MTFhNldFM2FiSytyOEtVSG91ZEd6ODUrVmYzRWtadzYrUFVKVTNyby9xMDVV?=
 =?utf-8?B?SjVkeVU3TUVWbEk1V25EbGM0N2ZEWEdxMUdNNnN2Rkw5aWc5NVFkNUZxdm5u?=
 =?utf-8?B?SmJQdGRUOHUxQ3p4U0NhSmo1TFpIbWl3N3dXVno5bHNaaUMzVkZFYWRBL1Fw?=
 =?utf-8?B?bDlXQWxKK1pQNGhnTEFKdGZyTlBKYWpuTUFnNVVETzVseGFFODhmN0JtajhW?=
 =?utf-8?B?OGhEcVRTaytYaFROckZHSkh5c1pMNzlQN3hkY3BUR3kxUXhpeFJYZkJyNXNP?=
 =?utf-8?B?cEtHY1Q3UENjWExPVXlvWE5QVG1CVVd3d2Q4QUpsQTY2L0FtYkZOY3NPK0xa?=
 =?utf-8?B?NHNnSkFNVFRLV0I0RnBXaDFrcExOeUxsNGFtTlNuandWbXFKelVpemQ5dVVs?=
 =?utf-8?B?cGRFc3NSN2V6M2hDbklpU3FLdXdZcGl4bUxVbWdlU1p0UjR1TW5wYnNwZlcv?=
 =?utf-8?B?aFpQS2FKWmJQTDMxRGdrUEZIOUNyelVYOTJWZ3doMm4xL296eDJiQXRFaFVT?=
 =?utf-8?B?K1FLajFRUDA2ZGE0bks2RVZxd0JQdkVRYlByemRMUm5rSmRsQWhKclZ5OXdE?=
 =?utf-8?B?VEVBNlEwdlRVOVBUZEp5RzQ4RUF0MG55dGw2NzU4Q3k4ZGlia2YxSTJJdVhV?=
 =?utf-8?B?QjB5a0pUajRoVmsrc3VkaHRNaVh4aHNRaStoVHRBbFlITlpDdkIwcXdKaXFP?=
 =?utf-8?B?eUdkUldyUXl1Um9hNE1wZkdrbTR5MVhHWUFUUnUxNS9sc3hRRll4dGYyOHBC?=
 =?utf-8?B?a3E1Zjh2Wk1wVUIvcTRZSm1LWlBKNGxLcU5MVmlRdldnMVRRRnVDYmpIK0Nz?=
 =?utf-8?B?NysxK3F3MHBlbHFMUkVnRXNHUzVwMFkwTWUrNlh0ODZEYnZyVTMwK1J0ZUJi?=
 =?utf-8?B?K25FNTI5YklqenZOalVhaVpCNjFNMWMzdEJWNTU3VHZPVjhyM09FZVhqaUNq?=
 =?utf-8?B?SXZTZmwvLy9sUWxaQ2kvVXpNRmprVUhzbjVoQS84N3N1MVNqRWhRU0pqTUdv?=
 =?utf-8?B?eCt5NFJxM09rOWdsOWViVGdsaW40V2l5Z2tVSVdNL1pwejlDTjExR1dpcnp5?=
 =?utf-8?B?NURtLzFMVURFVnRqYXhqRkFpeEN5RFZZaXE5a0oxejJxTFJDRUQzaE9tR2hT?=
 =?utf-8?B?T1NTV1VtUlF3K1NYcGZhSE52S29rVG5NNTJuTEVFQXFXUi8vWUExUmlBdEJ3?=
 =?utf-8?B?d0VqR0I2UndCczVJWHhpMHUrRTY1c3ZiTWM5NWdmbVVoU3pEOFYvUnQ0eFRX?=
 =?utf-8?B?dnNZVVc3NGgzdHFsR2xURGdDdzRxL1JSV3EwZFNiclgwMnI0RXRKZ09Ha0E4?=
 =?utf-8?B?c2tJQ3d6MXNaY3VXZmhTejRnUjZMbVBVbVRzRzJobWhLRmtiQXMzaDN0cjVI?=
 =?utf-8?Q?7GjBLRVDuadiO6Vd9G49enprt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5e7747-b488-49e1-242a-08dc36e22f6f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 15:47:06.8760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ROeNDQb4buDSFNK51Oee2jkebBUIBCYMItnpOvSyfrfObIGT40RLU8v0zSS77XMvHp1DSFfnuxihrYSeTTxVQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6638
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240226_074722_303781_B2E34B30 
X-CRM114-Status: GOOD (  17.26  )
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

Hi Keith,
This series was fully reviewed by Sagi and Christoph for 6.8 but we 
probably somehow missed taking it.

can you please take it for the next 6.9 merge window and/or merge it to 
nvme-6.9 ?

On 23/01/2024 16:40, Max Gurtovoy wrote:
> Hi Christoph/Sagi/Keith,
> This patch series is mainly for adding an interface for a user to
> configure the maximal queue size for fabrics via port configfs. Using
> this interface a user will be able to better control the system and HW
> resources.
> 
> Also, I've increased the maximal queue depth for RDMA controllers to be
> 256 after request from Guixin Liu. This new value will be valid only for
> controllers that don't support PI.
> 
> While developing this feature I've made some minor cleanups as well.
> 
> Changes from v2:
>   - collected Reviewed-by signatures (Sagi and Christoph)
>   - added local variable to simplify code in patch 6/8 (Christoph)
> 
> Changes from v1:
>   - collected Reviewed-by signatures (Sagi and Guixin Liu)
>   - removed the patches that unify fabric host and target max/min/default
>     queue size definitions (Sagi)
>   - align MQES and SQ size according to the NVMe Spec (patch 2/8)
> 
> Max Gurtovoy (8):
>    nvme-rdma: move NVME_RDMA_IP_PORT from common file
>    nvmet: compare mqes and sqsize only for IO SQ
>    nvmet: set maxcmd to be per controller
>    nvmet: set ctrl pi_support cap before initializing cap reg
>    nvme-rdma: introduce NVME_RDMA_MAX_METADATA_QUEUE_SIZE definition
>    nvme-rdma: clamp queue size according to ctrl cap
>    nvmet: introduce new max queue size configuration entry
>    nvmet-rdma: set max_queue_size for RDMA transport
> 
>   drivers/nvme/host/rdma.c          | 14 ++++++++++----
>   drivers/nvme/target/admin-cmd.c   |  2 +-
>   drivers/nvme/target/configfs.c    | 28 ++++++++++++++++++++++++++++
>   drivers/nvme/target/core.c        | 18 ++++++++++++++++--
>   drivers/nvme/target/discovery.c   |  2 +-
>   drivers/nvme/target/fabrics-cmd.c |  5 ++---
>   drivers/nvme/target/nvmet.h       |  6 ++++--
>   drivers/nvme/target/passthru.c    |  2 +-
>   drivers/nvme/target/rdma.c        | 10 ++++++++++
>   include/linux/nvme-rdma.h         |  6 +++++-
>   include/linux/nvme.h              |  2 --
>   11 files changed, 78 insertions(+), 17 deletions(-)
> 


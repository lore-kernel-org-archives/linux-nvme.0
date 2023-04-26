Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A8AC77B60
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Apr 2023 23:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:Cc:From:References:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oznsK65k9F08OHn1YH/MlTVd52jo4gB3IT4sEo9cGek=; b=z1UuUrVkmwtcjWPBgYEBX0ugfZ
	0CSfSD59o2y3Mqp6zDdVvvRRZH2yHc5JSrtR22uemptDSWFqIQi6bFW5dEaegrWEuDJvRZdXIgq1J
	VI2Axythof1oUPIORDCceEHgnX7WrPOlC2MI/Zc++dNG4DaosDpYjGA/LTwHWdNoalkIPeqOsaf3i
	niChkBFtZ1xlc8YXLnlGmQnxwWseom02u95ZVF2uK1dqglrqg0gFFDEB79PkuE+qFW8GmRB5plkue
	aZlXmevK6c114iy0mZf/WvkKLlg1wpN8l3ObdM6vqT3yUv/AYuKbYcncMIofCE3559h4hW/5NrliB
	KlO2VUUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1proCp-0050Ep-1X;
	Wed, 26 Apr 2023 23:05:47 +0000
Received: from mail-bn1nam02on20604.outbound.protection.outlook.com ([2a01:111:f400:7eb2::604] helo=NAM02-BN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1proCl-0050Dq-02
	for linux-nvme@lists.infradead.org;
	Wed, 26 Apr 2023 23:05:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WklM1ZrWS/3DO5iI+1C/Ifub6XbBLae4Z4LJrPnyGBmoO9hbPHlTJN1XJKtcbL9wOMavWeYm3l/HXN8zDa/A0luYyaUqPqQLOGVEqJ+p+20yC/Cr92/qUjrFLlUor5MdXKFF/k3O2RPlZHb1Xu48yXZgZSP9OQKcZAlb+cVeZndHj+73Y3olgg1pNs+Ur4O3uf9ZwfUJxY8GFNCgr2UOWP0cGqZNst/mB5GroUnrdvdyQFR/e5nh6Y8VnhJS1W1T4nHvEUNUjXDEAEOrUZ/ZAvZvSZz+im3bafBdQN2dL6y/6dOpRUXgBjH8/Rt5MaCmxGd3USVGpUyCMxVqLiQyaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oznsK65k9F08OHn1YH/MlTVd52jo4gB3IT4sEo9cGek=;
 b=BTPGT2+5J3/ey3EeoqW4P8WHSEYU8xQ5L7a4PtSfBZn5xOInyiAlJzIBUtZX42q2JGL6Vc/SjC3L1lZxKEEyFr2Egpc6Djh63NTLiK/iW/n4QTjNDyhvJI/y1DqKHJN79gKkmtEnzQgQxkDhW1lFVfg57bA8t5+zrLrhiTzNZlEMWxLWMV21B3beS0mjNW7WSWIt3wW58gPbBmoX5luqf9/9zjrFMJHGXi2Hgxa3zcIB/rIf5DEC3r90HnZpYeBMFqU9Fr+8X/hwP0qYwg6BTqF4u2Pxxph7S8OcHPZswp7f58mDK4jPipqEfknH45UbtDPqks381OUyYc3cUPJRyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oznsK65k9F08OHn1YH/MlTVd52jo4gB3IT4sEo9cGek=;
 b=ltjRyY4u3ZmhhOn4IwjfdElRuO1nnoHHC+GBqSWf+L7cJFAn8XGZEaBdULEd/+Ltl5zwwml0HeOx4OwRIKtDsEiWSJX/bduybr7yIbVLBbJZj9dVScfbUZcj772yqStXvcDELusf5L7tEWVADNwSwO6WX1q81RFTQPD/uKLtz5/SnZUCOQmX0UTjT/AzpsWCprEGxRI3ZUj3Gap0jNzosi4hNCvdPvHm+mG94/aefLpRKZFL3B+qLHIDsTn6unJ5tm+9fvgFYdzoqvR02aTUOXfcdjymsGad4227ACVPJqwCazfZE1PXzK4JQteOg5D38wtuNROwwpDVQmgL1cvcYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH0PR12MB5106.namprd12.prod.outlook.com (2603:10b6:610:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 23:05:36 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6340.021; Wed, 26 Apr 2023
 23:05:36 +0000
Message-ID: <dfc32a79-5789-eff9-335f-10373eb05e8c@nvidia.com>
Date: Thu, 27 Apr 2023 02:05:29 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCHv2] nvme-fabrics: add queue setup helpers
Content-Language: en-US
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, kbusch@meta.com
References: <20230426150441.595318-1-kbusch@meta.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: kch@nvidia.com, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20230426150441.595318-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::12) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CH0PR12MB5106:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d5416c-3a40-452a-6cf1-08db46aabe6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	35MTZtoxg1Pqhg0Ou53cD2tef9liiQ7XXxuZkMh01uwZZuuNkJcsnAqKLPAXMAL+wdKTOpYcMlb2E2GkNrtyYJbOc9oIEc57dVDpd/foE6I90RVkLfX3ANm7hhVXSGYxRMzFM54mE/ZrALbS1yOZDM9Hcy2+FKjqb3kAaLgyHfmrWcT3HH7zmipRyrbZreQzfTR5PzLhYrEl1SaoKaQOVseyYcKnG5ZhveIA6k5JHt6ClWQpD6XcU2odWq/l1fFLYVt09t36b43tmreysBmTdzOKgoBZMPo3EYT4XqpcnJvZdOmo4uLj5embvDgLlSJuNwOu3N3DjXtgNedemNKXKqGB+0LtBT3ZilCWG+YSDvSI/wDnZ6H95sEwfPp3LWQ8axRWzSAiRRsumF0by1LLAKhzQImpjF36BIkSrXsigMUITC8JE0ZMWaAvhjMHHu13cdrd4+09IpgYdkRF+IXxdKSw1r9QKkvpJ2r1At48mcTYO67DfV93CexNoDa3lvenndCtqKB6GnSR/MPTPJSmxwH30BJ6CQKt7Pex9x/H5RnRZaFmuwQzsRw+CO3GExf+6SlqRK5bKFx4ditvE7WiIzvOm2CB5ZRyOYXfGCcjIDD54c1ymLUM57FgcKD8VSttlcpF6BfNaAAgFjXlHOSG2Q==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(366004)(346002)(451199021)(4326008)(86362001)(66946007)(66556008)(66476007)(5660300002)(41300700001)(31696002)(316002)(8676002)(8936002)(2906002)(38100700002)(30864003)(186003)(478600001)(6666004)(53546011)(6506007)(6512007)(26005)(83380400001)(6486002)(36756003)(110136005)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?WnhhK29NVEQ5d2tLVW5Nc1RoOXJhQ25zekdQcUZybCswYmVMQjBYc2lId1ZD?=
 =?utf-8?B?b1phT3BDalo1SERhUkUrUzdZRWliS0JuUEd6Zzh3QzRuQ0xjWEViRlFKTXl4?=
 =?utf-8?B?S3R4UXZuRUNwUkQzR3lDUGtaTk5DeUsxbHZ6UGo3V0t6V0JGbEsxa083L2Rm?=
 =?utf-8?B?UHF3S1ZTRE5iTUVuR1JGM0tXaFU4R1Y5VitocjlCTEhrSHF4cGEyTXFFWlo2?=
 =?utf-8?B?cDJ1WHdERWJBbWIyaWlvbytqYnRzUFBBVmRQb2J6b2VDK2RTdmZEMVhaS3B1?=
 =?utf-8?B?MnFpdXY2VjB2QXl2c0JrSVdkRTcxSXp2a3dUS056eEpwNldCcjNIWUVJRHU3?=
 =?utf-8?B?elhmRTFLdGZGZ2ZRY3lESFUzeDlmRVAybW5XZTF6RTY3NjRRQ0YwZ1gySVlM?=
 =?utf-8?B?Z2F6eHN4cE9vMU5WT1ZObzBHaUhzWEdDM1E4aGU4OFJaaVJTQXJkT1VuK2Ns?=
 =?utf-8?B?aXZvSU85ZElvbHJxck9GWklKaWovRk42NEh1cE9NRmZDa1RIczdyTXN4dE1i?=
 =?utf-8?B?V3dSSGxCSFNaQlZOaTl2d3dBNmJBZ3dZRFpmb2NjVmF0NkhVRStGNFRvVUZL?=
 =?utf-8?B?WnZjQVN1dXJ5WGFOK3M2SDlBYS9uRWlDMGEzdVBJdHo1ejVsbm5yVE5qQ05K?=
 =?utf-8?B?T0padnozWndKYXhvR1JJR0pkamtONGREbEQzZ3VESFNLSWFjTHA5Kzh2SjhH?=
 =?utf-8?B?eTZaNjVzWXVRaTROOE9rZGpCcTUwbStwTlRpOGNsWHhuaUNxQS9JSEV3dFl1?=
 =?utf-8?B?VWpIR2VQYU05RUdjNFpYUHpyV0htK1JrS0R0M2VIRlNCTTBMczBlS21Fb3Bi?=
 =?utf-8?B?V2RjOCtCRW13VUhaVFBZdC9EcjN0bVo4bG5hNDIvR1dOZndDN2trZ0FWQ3Zn?=
 =?utf-8?B?Wk5Cblg4am9HNGlsL2ZTS2tGdWppc0EzaG9YNDNrbTQ3VmZKYUtCVmp3U3ZI?=
 =?utf-8?B?eTNxQktRRHBKNUJQQU5Hd3BKR2xObW1USEdLR09oYUtyT056QXpnQ0hwWWFE?=
 =?utf-8?B?ME5KUURBTW1LOTZTVEEwclF3eCtVWCtHNWtuazRWcEpmWElucjhQQm94TEtv?=
 =?utf-8?B?SGdMMW9CQmQ4TlNmaEZZUUgvcGhpTmVCQUdwb1NCQnNST05UTWhOcTRpRnVF?=
 =?utf-8?B?dmI4QkRYZ2wyQlE0OHpaNnVDSm50a2U2ME5hKzl1SGxUNUhpUkdWMXpFK0N2?=
 =?utf-8?B?RWQzODNDdkVDTUZ3RGxpY2dHczUyN0h1Y1gwL1Jxemt6eEtyL0pNSWhsU0ZC?=
 =?utf-8?B?MW55SzQ5N2hjZk81S3gyUVh4bnRQUk1nTCs0em5reUp6eHBwN2FtQ0RxMWNh?=
 =?utf-8?B?TDk0emR4Z1czSnFCQk1YVUUwUG9vU251YjFVYWphdEhXTVlITWtCNnlwYS9q?=
 =?utf-8?B?M0phTWtxUWFoTHNjaXZ1ZElQVWlPTkFlREFEOHd4NEpNRXRQaG5lTGF5QUM2?=
 =?utf-8?B?Zzc2RUY4SjdNQklxNW1peFlKUEZXZFBZQmExLzUvQTJhWVhPS1Nnbkl3SElE?=
 =?utf-8?B?TzZjdTFqVnptMGZ2Z1MzR253UFkycEt2ZWV0bVBLc0wzUnVzeWl4RHhGcUFz?=
 =?utf-8?B?V0lHaEtZSlkvMkZhYTg3emlSd0FhSWZLUkZESlR0WHJyZnBkcmV4UkJuRXZH?=
 =?utf-8?B?S0NvRlN1ZCtHSThlLzN5ZHY3ek9ZUy9RRi80dXN5ZVUzbWpHSy9Od0RsNE5T?=
 =?utf-8?B?Skd3NXI3aFQxa0hQNng3ckVHWVhUZHpuYk1oV0hwNVgrWE1rT2FCa3E2SDFS?=
 =?utf-8?B?TTRyays0OUowWDh5cWEwc1RHeC9vL1Z5R1Y5eTcxN0xSZG1yL2F3alNKdkNT?=
 =?utf-8?B?NmFVdkJqRkV3bDEreGNiY21PN3FOUTd2QzFPWjVSWFF3cE4rR05CRWJ1dU16?=
 =?utf-8?B?aldZYmF1Wkwyd2EzK1JSdjh5MFN0amhCYW9nTnFkdzVSNWF5ZlJCcDBzQ3Na?=
 =?utf-8?B?TFhpRlhNbzFKRzNsVWRkb0t4MnBNd0haS0tBdUZmczY0UCtYbXNkb1YrU2or?=
 =?utf-8?B?UzRQMEZNWUNhSlZBSTM1MElUejIwQW0wMU9RcDFWNTdIUk56L1VpQlJ2Q1I1?=
 =?utf-8?B?QmIwMlFPb3V5Wno3M3hTZkMvR2pKcVI1b3lUUU52Q3dObllkdks4eGF3aktB?=
 =?utf-8?Q?ADzuyrwFkCVOyMtkCo/IN+EDh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d5416c-3a40-452a-6cf1-08db46aabe6c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 23:05:35.8804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V8ulkelTcHUlAeTtqGTZEurheeDHWWfGU34ystNwrHjgcdx7jABEeTEUZJSaqfhaeWt+LIfvpex71+ACxmyFuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5106
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_160543_187698_6D2D11D4 
X-CRM114-Status: GOOD (  22.42  )
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



On 26/04/2023 18:04, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> tcp and rdma transports have lots of duplicate code setting up the
> different queue mappings. Add common helpers.
> 
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2:
> 
>    Merged up to latest that doesn't have the RDMA specifics
> 
>    Simplified io queue count function (Christoph)
> 
>    Use 'nvmf_' prefix for function names.
> 
>   drivers/nvme/host/fabrics.c | 76 ++++++++++++++++++++++++++++++
>   drivers/nvme/host/fabrics.h | 11 +++++
>   drivers/nvme/host/rdma.c    | 79 ++-----------------------------
>   drivers/nvme/host/tcp.c     | 92 ++-----------------------------------
>   4 files changed, 96 insertions(+), 162 deletions(-)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index bbaa04a0c502b..3ff5030562088 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -957,6 +957,82 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	return ret;
>   }
>   
> +void nvmf_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues,
> +			u32 io_queues[HCTX_MAX_TYPES])
> +{
> +	if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
> +		/*
> +		 * separate read/write queues
> +		 * hand out dedicated default queues only after we have
> +		 * sufficient read queues.
> +		 */
> +		io_queues[HCTX_TYPE_READ] = opts->nr_io_queues;
> +		nr_io_queues -= io_queues[HCTX_TYPE_READ];
> +		io_queues[HCTX_TYPE_DEFAULT] =
> +			min(opts->nr_write_queues, nr_io_queues);
> +		nr_io_queues -= io_queues[HCTX_TYPE_DEFAULT];
> +	} else {
> +		/*
> +		 * shared read/write queues
> +		 * either no write queues were requested, or we don't have
> +		 * sufficient queue count to have dedicated default queues.
> +		 */
> +		io_queues[HCTX_TYPE_DEFAULT] =
> +			min(opts->nr_io_queues, nr_io_queues);
> +		nr_io_queues -= io_queues[HCTX_TYPE_DEFAULT];
> +	}
> +
> +	if (opts->nr_poll_queues && nr_io_queues) {
> +		/* map dedicated poll queues only if we have queues left */
> +		io_queues[HCTX_TYPE_POLL] =
> +			min(opts->nr_poll_queues, nr_io_queues);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(nvmf_set_io_queues);
> +
> +void nvmf_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
> +		     u32 io_queues[HCTX_MAX_TYPES])
> +{
> +	struct nvmf_ctrl_options *opts = ctrl->opts;
> +
> +	if (opts->nr_write_queues && io_queues[HCTX_TYPE_READ]) {
> +		/* separate read/write queues */
> +		set->map[HCTX_TYPE_DEFAULT].nr_queues =
> +			io_queues[HCTX_TYPE_DEFAULT];
> +		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
> +		set->map[HCTX_TYPE_READ].nr_queues =
> +			io_queues[HCTX_TYPE_READ];
> +		set->map[HCTX_TYPE_READ].queue_offset =
> +			io_queues[HCTX_TYPE_DEFAULT];
> +	} else {
> +		/* shared read/write queues */
> +		set->map[HCTX_TYPE_DEFAULT].nr_queues =
> +			io_queues[HCTX_TYPE_DEFAULT];
> +		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
> +		set->map[HCTX_TYPE_READ].nr_queues =
> +			io_queues[HCTX_TYPE_DEFAULT];
> +		set->map[HCTX_TYPE_READ].queue_offset = 0;
> +	}
> +
> +	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
> +	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
> +	if (opts->nr_poll_queues && io_queues[HCTX_TYPE_POLL]) {
> +		/* map dedicated poll queues only if we have queues left */
> +		set->map[HCTX_TYPE_POLL].nr_queues = io_queues[HCTX_TYPE_POLL];
> +		set->map[HCTX_TYPE_POLL].queue_offset =
> +			io_queues[HCTX_TYPE_DEFAULT] +
> +			io_queues[HCTX_TYPE_READ];
> +		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
> +	}
> +
> +	dev_info(ctrl->device,
> +		"mapped %d/%d/%d default/read/poll queues.\n",
> +		io_queues[HCTX_TYPE_DEFAULT],
> +		io_queues[HCTX_TYPE_READ],
> +		io_queues[HCTX_TYPE_POLL]);
> +}
> +EXPORT_SYMBOL_GPL(nvmf_map_queues);
> +
>   static int nvmf_check_required_opts(struct nvmf_ctrl_options *opts,
>   		unsigned int required_opts)
>   {
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index dcac3df8a5f76..e438d67a319b5 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -203,6 +203,13 @@ static inline void nvmf_complete_timed_out_request(struct request *rq)
>   	}
>   }
>   
> +static inline unsigned int nvmf_nr_io_queues(struct nvmf_ctrl_options *opts)
> +{
> +	return min(opts->nr_io_queues, num_online_cpus()) +
> +		min(opts->nr_write_queues, num_online_cpus()) +
> +		min(opts->nr_poll_queues, num_online_cpus());
> +}
> +
>   int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val);
>   int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val);
>   int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val);
> @@ -215,5 +222,9 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size);
>   bool nvmf_should_reconnect(struct nvme_ctrl *ctrl);
>   bool nvmf_ip_options_match(struct nvme_ctrl *ctrl,
>   		struct nvmf_ctrl_options *opts);
> +void nvmf_set_io_queues(struct nvmf_ctrl_options *opts, u32 nr_io_queues,
> +			u32 io_queues[HCTX_MAX_TYPES]);
> +void nvmf_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
> +		     u32 io_queues[HCTX_MAX_TYPES]);
>   
>   #endif /* _NVME_FABRICS_H */
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 0eb79696fb736..168fdf5e11113 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -713,18 +713,10 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl,
>   static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
>   {
>   	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
> -	struct ib_device *ibdev = ctrl->device->dev;
> -	unsigned int nr_io_queues, nr_default_queues;
> -	unsigned int nr_read_queues, nr_poll_queues;
> +	unsigned int nr_io_queues;
>   	int i, ret;
>   
> -	nr_read_queues = min_t(unsigned int, ibdev->num_comp_vectors,
> -				min(opts->nr_io_queues, num_online_cpus()));

what about the logic of ibdev->num_comp_vectors in the common code ?

> -	nr_default_queues =  min_t(unsigned int, ibdev->num_comp_vectors,
> -				min(opts->nr_write_queues, num_online_cpus()));

same comment here too.

> -	nr_poll_queues = min(opts->nr_poll_queues, num_online_cpus());
> -	nr_io_queues = nr_read_queues + nr_default_queues + nr_poll_queues;
> -
> +	nr_io_queues = nvmf_nr_io_queues(opts);
>   	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
>   	if (ret)
>   		return ret;
> @@ -739,34 +731,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
>   	dev_info(ctrl->ctrl.device,
>   		"creating %d I/O queues.\n", nr_io_queues);
>   
> -	if (opts->nr_write_queues && nr_read_queues < nr_io_queues) {
> -		/*
> -		 * separate read/write queues
> -		 * hand out dedicated default queues only after we have
> -		 * sufficient read queues.
> -		 */
> -		ctrl->io_queues[HCTX_TYPE_READ] = nr_read_queues;
> -		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_READ];
> -		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
> -			min(nr_default_queues, nr_io_queues);
> -		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -	} else {
> -		/*
> -		 * shared read/write queues
> -		 * either no write queues were requested, or we don't have
> -		 * sufficient queue count to have dedicated default queues.
> -		 */
> -		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
> -			min(nr_read_queues, nr_io_queues);
> -		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_DEFAULT];

I wonder if this is the right time to move io_queues[HCTX_MAX_TYPES] 
from the rdma/pci/tcp controllers to common nvme_ctrl structure and save 
more code.
I know that fc and loop ctrl don't use it so we can allocate it dynamically.
WDYT ?

> -	}
> -
> -	if (opts->nr_poll_queues && nr_io_queues) {
> -		/* map dedicated poll queues only if we have queues left */
> -		ctrl->io_queues[HCTX_TYPE_POLL] =
> -			min(nr_poll_queues, nr_io_queues);
> -	}
> -
> +	nvmf_set_io_queues(opts, nr_io_queues, ctrl->io_queues);
>   	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
>   		ret = nvme_rdma_alloc_queue(ctrl, i,
>   				ctrl->ctrl.sqsize + 1);
> @@ -2138,44 +2103,8 @@ static void nvme_rdma_complete_rq(struct request *rq)
>   static void nvme_rdma_map_queues(struct blk_mq_tag_set *set)
>   {
>   	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(set->driver_data);
> -	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
>   
> -	if (opts->nr_write_queues && ctrl->io_queues[HCTX_TYPE_READ]) {
> -		/* separate read/write queues */
> -		set->map[HCTX_TYPE_DEFAULT].nr_queues =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
> -		set->map[HCTX_TYPE_READ].nr_queues =
> -			ctrl->io_queues[HCTX_TYPE_READ];
> -		set->map[HCTX_TYPE_READ].queue_offset =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -	} else {
> -		/* shared read/write queues */
> -		set->map[HCTX_TYPE_DEFAULT].nr_queues =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
> -		set->map[HCTX_TYPE_READ].nr_queues =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -		set->map[HCTX_TYPE_READ].queue_offset = 0;
> -	}
> -	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
> -	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
> -
> -	if (opts->nr_poll_queues && ctrl->io_queues[HCTX_TYPE_POLL]) {
> -		/* map dedicated poll queues only if we have queues left */
> -		set->map[HCTX_TYPE_POLL].nr_queues =
> -				ctrl->io_queues[HCTX_TYPE_POLL];
> -		set->map[HCTX_TYPE_POLL].queue_offset =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT] +
> -			ctrl->io_queues[HCTX_TYPE_READ];
> -		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
> -	}
> -
> -	dev_info(ctrl->ctrl.device,
> -		"mapped %d/%d/%d default/read/poll queues.\n",
> -		ctrl->io_queues[HCTX_TYPE_DEFAULT],
> -		ctrl->io_queues[HCTX_TYPE_READ],
> -		ctrl->io_queues[HCTX_TYPE_POLL]);
> +	nvmf_map_queues(set, &ctrl->ctrl, ctrl->io_queues);
>   }
>   
>   static const struct blk_mq_ops nvme_rdma_mq_ops = {
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index bf0230442d570..260b3554d821d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1802,58 +1802,12 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   	return ret;
>   }
>   
> -static unsigned int nvme_tcp_nr_io_queues(struct nvme_ctrl *ctrl)
> -{
> -	unsigned int nr_io_queues;
> -
> -	nr_io_queues = min(ctrl->opts->nr_io_queues, num_online_cpus());
> -	nr_io_queues += min(ctrl->opts->nr_write_queues, num_online_cpus());
> -	nr_io_queues += min(ctrl->opts->nr_poll_queues, num_online_cpus());
> -
> -	return nr_io_queues;
> -}
> -
> -static void nvme_tcp_set_io_queues(struct nvme_ctrl *nctrl,
> -		unsigned int nr_io_queues)
> -{
> -	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> -	struct nvmf_ctrl_options *opts = nctrl->opts;
> -
> -	if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
> -		/*
> -		 * separate read/write queues
> -		 * hand out dedicated default queues only after we have
> -		 * sufficient read queues.
> -		 */
> -		ctrl->io_queues[HCTX_TYPE_READ] = opts->nr_io_queues;
> -		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_READ];
> -		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
> -			min(opts->nr_write_queues, nr_io_queues);
> -		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -	} else {
> -		/*
> -		 * shared read/write queues
> -		 * either no write queues were requested, or we don't have
> -		 * sufficient queue count to have dedicated default queues.
> -		 */
> -		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
> -			min(opts->nr_io_queues, nr_io_queues);
> -		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -	}
> -
> -	if (opts->nr_poll_queues && nr_io_queues) {
> -		/* map dedicated poll queues only if we have queues left */
> -		ctrl->io_queues[HCTX_TYPE_POLL] =
> -			min(opts->nr_poll_queues, nr_io_queues);
> -	}
> -}
> -
>   static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   {
>   	unsigned int nr_io_queues;
>   	int ret;
>   
> -	nr_io_queues = nvme_tcp_nr_io_queues(ctrl);
> +	nr_io_queues = nvmf_nr_io_queues(ctrl->opts);
>   	ret = nvme_set_queue_count(ctrl, &nr_io_queues);
>   	if (ret)
>   		return ret;
> @@ -1868,8 +1822,8 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   	dev_info(ctrl->device,
>   		"creating %d I/O queues.\n", nr_io_queues);
>   
> -	nvme_tcp_set_io_queues(ctrl, nr_io_queues);
> -
> +	nvmf_set_io_queues(ctrl->opts, nr_io_queues,
> +			   to_tcp_ctrl(ctrl)->io_queues);
>   	return __nvme_tcp_alloc_io_queues(ctrl);
>   }
>   
> @@ -2449,44 +2403,8 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
>   static void nvme_tcp_map_queues(struct blk_mq_tag_set *set)
>   {
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(set->driver_data);
> -	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
> -
> -	if (opts->nr_write_queues && ctrl->io_queues[HCTX_TYPE_READ]) {
> -		/* separate read/write queues */
> -		set->map[HCTX_TYPE_DEFAULT].nr_queues =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
> -		set->map[HCTX_TYPE_READ].nr_queues =
> -			ctrl->io_queues[HCTX_TYPE_READ];
> -		set->map[HCTX_TYPE_READ].queue_offset =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -	} else {
> -		/* shared read/write queues */
> -		set->map[HCTX_TYPE_DEFAULT].nr_queues =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
> -		set->map[HCTX_TYPE_READ].nr_queues =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT];
> -		set->map[HCTX_TYPE_READ].queue_offset = 0;
> -	}
> -	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
> -	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
> -
> -	if (opts->nr_poll_queues && ctrl->io_queues[HCTX_TYPE_POLL]) {
> -		/* map dedicated poll queues only if we have queues left */
> -		set->map[HCTX_TYPE_POLL].nr_queues =
> -				ctrl->io_queues[HCTX_TYPE_POLL];
> -		set->map[HCTX_TYPE_POLL].queue_offset =
> -			ctrl->io_queues[HCTX_TYPE_DEFAULT] +
> -			ctrl->io_queues[HCTX_TYPE_READ];
> -		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
> -	}
> -
> -	dev_info(ctrl->ctrl.device,
> -		"mapped %d/%d/%d default/read/poll queues.\n",
> -		ctrl->io_queues[HCTX_TYPE_DEFAULT],
> -		ctrl->io_queues[HCTX_TYPE_READ],
> -		ctrl->io_queues[HCTX_TYPE_POLL]);
> +
> +	nvmf_map_queues(set, &ctrl->ctrl, ctrl->io_queues);
>   }
>   
>   static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)


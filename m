Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C2AC46CD3
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Dec 2023 23:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ueLqYsnPvp3WwP5gZ8F2AHn+NAY6A2N4UF75xHt0hM=; b=bSSPvbTXR90pup6QmBcHwX3Pe3
	9nWpOAJ/hJhJp9XuhcLs9iaVZZFlqw+VQsAXaFpTsyDLf8snxFmvyj81UgjAlQPe8bzYcG1XeyCtu
	+rxn9snYlgkwH2d0X9PH6stLL+iWufpX0pR1fzw6DgMIg/HX2dAjk4IwwgG7Bp6RSGhPNIRpmXJK2
	0sftK4zcQHcbY3ZbPz7SN3+/uaf/wZsxEcqthXF7GKlZNMPZ20+zhrN9pRXzIvkiaDT9gnA8W/l3y
	N+l4DlEpCGPHhj2GGN/TlLSwJbmaFbZS7r9+CRfd8EFO5FHPktCggs9Y0H8IMO35/BA12+RmXY8Oo
	B/kmB2Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIGgz-00Demb-2b;
	Tue, 26 Dec 2023 23:18:33 +0000
Received: from mail-dm6nam11on2060e.outbound.protection.outlook.com ([2a01:111:f400:7eaa::60e] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIGgu-00DemA-1x
	for linux-nvme@lists.infradead.org;
	Tue, 26 Dec 2023 23:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7cHIJRk13dVB0AolehZnHbu5eYGTovVqjq1kCHoueG59iZ+f7LFpFzwfb241/qu7G5MgeolcFRy15Rbf9nuFhalco5ZN8YSVk0sYof1wmqXyGvxA45JXx7APdKCNgVd79gN9gUWcEOkNnbLl+TsGRfkt8NPh/uDZ7IFW4ikdMI8p+sDg4nLtYAgHQpZRpvUmnvwi23HHlhjGk1/Ca4wRLNhrSHHE2AhpWkXiXzBOQn/kbEoy8IJpzNooCBRiaTbdiUZ4SlBnH+5T5K2n1hv7UsyLHtQ/DN8B8PW0ZzbtTxnaaysxxx9Y9ovE+GDNSxyMWs+nmPi2BlpPTC0wJa6+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ueLqYsnPvp3WwP5gZ8F2AHn+NAY6A2N4UF75xHt0hM=;
 b=UrMZ9siHmXuomSlph8GqzmrHdEg47ujts4p88LerQ+m53wtMkyzHZnJ1GOr853P8l01rV+POBBwDYV+8+QeLlZOTUsIETOxZ9aqNYCg7ml9eCUCI8bAxkWbYOCYIy6Hap7QRWjDVM7r0J9ait0fA0h1P+69QRvXqbqCel3hqAN6za9hWKruFk0DPR8le3MiPXEAd8oc7nwflacaZJdNnJY8PgTbF4cpvdaSf1IqiBuu3rniEtGmP2UO/oMfEjDh75uRTW2nhOoYD7yfnuHN1aOMcqOKYoFExLMc2MmmVGvkQpWYCen63ibmVDvcNpS61BX/EnbQ3vdtJupPHAETZbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ueLqYsnPvp3WwP5gZ8F2AHn+NAY6A2N4UF75xHt0hM=;
 b=dQtNqz4g2m7XX26AWYnk/UOYYZgbblWQEFRymw+Tv6WvHAcB0dS+qN9AwMQMTn9tte0RYoclil8aKhtFuRXE5nzdFk3iKmdEfv8ENKJeW05KmNlTUg9NsLDg30UqQiP2DOM82YseCrxrjG4O4T8KiL6GKXfLQvIVN70spkhO/RhHpzk63sRSttTfNwD3ZJYkjVxQo3cmxxNScgF80xtfSPFZPCzfVK203/HRVzlolp8iW44R0+rp2d0SZrtPb+iCaoCbxZjoxlJfkXMX/m3v9Bg9XKxFaRK9u7l3lOJatmD2T/RH4WtjCziZNttUpaWOti6gYbS3cGaHS0wf0qU8VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Tue, 26 Dec
 2023 23:18:19 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 23:18:19 +0000
Message-ID: <63948c97-d7e3-418f-b498-ddba3eb5fee4@nvidia.com>
Date: Wed, 27 Dec 2023 01:18:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] nvme: also skip discard granularity updates in
 nvme_config_discard
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
References: <20231226085844.203878-1-hch@lst.de>
 <20231226085844.203878-3-hch@lst.de>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20231226085844.203878-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::13) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 3527211c-515a-46a7-74e9-08dc0668f213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nu9Tp65YN8dCit3JDVUo+8LLuqEP/dClLT/5ExypzaEDgGyyldOqU5s9QDgBe7vPTvQhMtAwdSP7l2/EU1PKUFRMF3ZJ9rx8MushtdIyZyd6cz7h0OiOv5OpNJ6jBWaOrHMMWAamXcjdp3AQOFyMh6FJFECMY5mDdMQRwjrmGtWcyySo6XLfKwieFU2l4wnuRNGsOT8Z4HXtK4W0zQuJo6lUHfvZ9PH3rItIpuzSnSj+wwm+skgBDWv7l6mjVKUg+NLJzlN2ajdOEAYd1te/152N2L+Rk9uT0SqluajNw2xiGiwtKraz7lcrhAD1JO+KEN4AMSrIvqM/aHoaS4B3tkXUWGWLBdX0vHqQeU0Nfrcgk2cDyEp7QF0b8SXRoINydqOdLMPhORd01MOrpnzSeKUj94fh0v2smd4SoHem8h/3ArdN/H5u15Y9b6XcfOtHdClJgEGMhlz+nIZYpOMfTrB1cZS7kRN+j1lMeGGdaYoCj2MWBY+Pze0/S080vzOPqS/Q/MdyNL8W5IWgAT/65ZR+tuv44We/z6nadsHYZkYcHQPUy/JpCSAhIA4lh7lBRULwbIAO0g/wFiPnRF6kIPfLn/h0CyWXybzi7ZDq5sYzcVZZ/BFb2hwLNxcjg2ILdCLV0G3NBN6I+2PNTq/+Eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(41300700001)(36756003)(66899024)(2906002)(5660300002)(53546011)(110136005)(6506007)(31686004)(83380400001)(6512007)(6486002)(6666004)(478600001)(26005)(4326008)(8676002)(8936002)(86362001)(38100700002)(66946007)(66556008)(316002)(31696002)(2616005)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q08zMGtPSjNxRXBJc0UyYk1xSHg1Q3FwSkVyTVRmbVN4TVQ3bWF1eWdkQkdK?=
 =?utf-8?B?RFpXVG5TbElmNmJ4VTlzeiswdXB2dmYydVFoQkI5cmVXZGwrQkVaUm9XN2Rk?=
 =?utf-8?B?ZDZqRHFtblM0a0RwRnE1MWl4MlUxNzFyWkY1UExLWjF0bHA0V2NnekhQVHJj?=
 =?utf-8?B?UDdTQjVZZkJaekdvdnN2SHlxWHlCQlJsYkZiMDR4OUliZkxab0pwVmVXNGcy?=
 =?utf-8?B?aHhLMjF2TlA5UG0rNytwZXlZNk83K3RuL0xDL1RZeXVMSDh5MmdsU05EU0FT?=
 =?utf-8?B?c2FhQStpTVpxYjRQN0pKWmJQOG1TZ3NIeXJPb1ZVeFlxTjAwRUFvSXVOaDV1?=
 =?utf-8?B?SlhiYm42dDMvM2VzMFYrZUcwV053SkxqaFlKS1N4b0NESkI0d0twQVdOSXQ4?=
 =?utf-8?B?QVNUT2xDQkhMME9lQzJVSGhWK2JhbkdvVmd1U2NZQk9tOWU1aDBhKzhidzJx?=
 =?utf-8?B?bUp4cWt3MmtORVlNU0p3N2RYMTNmYUlkMytJVFIzTElVTVNUbHFOMGFsclh4?=
 =?utf-8?B?U0xZdlJGdEFkUnEwWnpBZXA2T1BUdzllVndwQU5RdXVLa2lSOUlhRUo1WTcr?=
 =?utf-8?B?M1NlUkg3c2MyZjZuNE0rRWNyYU1zM0FYOGFXbzR1djZCYWNDUVdLWERtVW8x?=
 =?utf-8?B?SzErR0dtREVJdXhpS3BMd2NRUUFUWjg3T2srUG9XYmRKU1VrUE9kYjh3U29T?=
 =?utf-8?B?N3NtekFpaFBlajlUWFN6clN5TitCcnZ6Q3lWMytZMmliQTRHNjNHRHBqNlU2?=
 =?utf-8?B?blY0Yk54OUE5dzlmdmkxdlJaSHcvQm9zVGlGelpVZndHLzBxUUdpdW1VeVoy?=
 =?utf-8?B?ZzNsanFCZlo2eUlsdndDK1h4eWJkSE8rcXh5L1FnQ0lkOEZzOS85WlpXUU5y?=
 =?utf-8?B?T2JNWGNKL1dST1RZTG0wdmpzNjZqMlBLZHA1WHpyU3FlMllTREZpOEpRS3RV?=
 =?utf-8?B?azNNSDRWdVhVZ1VOcDE2dDJ1YjF3SEREUmlpOUJKeDBVUzVuQkFjTUo0ZEpy?=
 =?utf-8?B?M3JMZUYyV3FCS3ZLYnVGbUpoRDdpakNUMFRoQXhQV291bS9mK2RjUTMxcmJV?=
 =?utf-8?B?Y3IydGdOSk1qMDBUNWtTc1QyRUNNTGc2KzBtUFE5MlkybjVyZXJPOWpJSUwr?=
 =?utf-8?B?a0kzc0laOUs0UlZTelFlR2VCaTVka0k3bk9iV25NWm03bjk5RUIzS3VsNUpa?=
 =?utf-8?B?V2xqVFJ6bk8wYnVMcXRveVN4S093RjVLZ0JpeTI5N1RySXEwWk0wdGdId082?=
 =?utf-8?B?V2syajlYQS9zTkd0b3U3dTU2WmgxRzZxZmNva2FCVnRkWnViTThkci9hUUxI?=
 =?utf-8?B?MERqVmFMQ3d6dEg2Uk9CckFha0RrOUR5WHpBZU5reXNMck5OaUQ0YmtTaGVT?=
 =?utf-8?B?TGpQN3BaYXZ1NEdxd3BZV3kzMmc0KzNSUk1YbDY5TGR2THVGL1JvdEw2OGYr?=
 =?utf-8?B?VExRcXgzR1kwK2ZYc2loYkV1NTJjcW80R2hqTUxkNEQ3Y0ZwTkwzSit5RTRG?=
 =?utf-8?B?bkR2QW9iQ1k2UDg1ZU9FVldtZk5WK0djVEw1Z2RETk9ZemtoK3RxTVNYSjln?=
 =?utf-8?B?OXVJbWppcEFTMW00NDBzOEZudU5RazJOVExocXlTWG13aHc3dTI5c0lqODlo?=
 =?utf-8?B?b2FpMHhVZGV4QTcxRjNlYWxhQzhWUmxJNzByUVBhTGsvd3RqY2czSGFpYjFV?=
 =?utf-8?B?ZllsUWJ0V2g0cTJzMzFpWDZwV25HWm9IamlpRWh4ZkhoK1JadTZxQWN1MURy?=
 =?utf-8?B?YTVhZ2Nua05MaWhKK2dGNTV3Q1RTcXNCS2pSNHlSU3JnQ2dsNnJ5eWVBM2JU?=
 =?utf-8?B?bTRGWFhXcUtEd2NPd1dVZG15c3F6bzJQU1JpcGQrM2VtbFNlQmJzcGt6U1Zj?=
 =?utf-8?B?dWNsV2o1QWt5K09rbnBWMkczZU1BMFhIbjl2T1p2ZUlHY1JwTEZtYkVKTytZ?=
 =?utf-8?B?OVNJQkw1VGRvdnNObnVSY0g2cGpNWGNpVXY4Y0RsSFRYS3RpUFpQdE9pMGF0?=
 =?utf-8?B?ajdPSEVGWkxvdEY4dFFydVdlRkVkRFRkNzZlTXQvS1pTWTUrWGNzeGhuS1JZ?=
 =?utf-8?B?RGFmVzFxcHhWQ3FxRi9xVVpmdlFCNWhBZUgvc2J6cWFEVFphWWdWR2I5MllZ?=
 =?utf-8?Q?t5qTJm9cOXnlgjCEdVQq9qpFA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3527211c-515a-46a7-74e9-08dc0668f213
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2023 23:18:19.0011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxEnK1X7++QkNK59wMyDFIDA4hVKHifJwFGtUZSnkGrBkdlEQv+D0of95iTL50uXRP+jujIj33gMSdEenkTpuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231226_151828_719166_0B4BDD40 
X-CRM114-Status: GOOD (  19.21  )
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



On 26/12/2023 10:58, Christoph Hellwig wrote:
> Don't just skip the discard sectors and segments but also the granularity
> if a value was already set before.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 56107cfc97b7bc..6c52b0ab382c85 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1727,7 +1727,6 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
>   		struct nvme_ns_head *head)
>   {
>   	struct request_queue *queue = disk->queue;
> -	u32 size = queue_logical_block_size(queue);
>   
>   	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(head, UINT_MAX))
>   		ctrl->max_discard_sectors =
> @@ -1741,8 +1740,6 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
>   	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
>   			NVME_DSM_MAX_RANGES);
>   
> -	queue->limits.discard_granularity = size;
> -
>   	/*
>   	 * If discard is already enabled, don't reset queue limits.
>   	 *
> @@ -1755,6 +1752,7 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
>   
>   	blk_queue_max_discard_sectors(queue, ctrl->max_discard_sectors);
>   	blk_queue_max_discard_segments(queue, ctrl->max_discard_segments);
> +	queue->limits.discard_granularity = queue_logical_block_size(queue);
>   
>   	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
>   		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);

maybe worth to add a small helper like we have for other discard limits:

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 0046b447268f..b7eee29ca8ec 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -369,6 +369,17 @@ void blk_queue_zone_write_granularity(struct 
request_queue *q,
  }
  EXPORT_SYMBOL_GPL(blk_queue_zone_write_granularity);

+/**
+ * blk_queue_discard_granularity - set discard granularity for the queue
+ * @q:  the request queue for the device
+ * @size:  the discard granularity size, in bytes
+ */
+void blk_queue_discard_granularity(struct request_queue *q, unsigned 
int size)
+{
+       q->limits.discard_granularity = size;
+}
+EXPORT_SYMBOL_GPL(blk_queue_discard_granularity);
+
  /**
   * blk_queue_alignment_offset - set physical block alignment offset
   * @q: the request queue for the device


otherwise looks good,
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>


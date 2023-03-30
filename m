Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF827C761A6
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Mar 2023 09:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N+KnsvG2ZnzSY7QH3OBHZhiU9x7IVkh5zDrM6knNE1Q=; b=2MU6aAwVUNj1UeWvPvXU6JYsZK
	V2BE0SRiBxIid8g9KJ4RX99Uoe+nrhJ4z4RdxDliaf6yHrJicKad33sqNVSgPztmfUTQ5JEKT5Tjd
	5Yam3JHFioZO4SC1aXIwDOvnQRlHVPnY+Vfu8cIRWLKkRSD6U6j4YdhYYV+0F1/6j80crjd63xNRL
	JYd6i/yGJIlYY1Q4aWsKvffuRv+DuhP6Elk2OMmUhqfJTtZnJ88v8udjH1mlmnC9VaT4DA/1GmzRz
	gTBjjrFzukD1Pm0/vz1REs7RW/Ov86oCaVmpmJ0uGauk4jPaagW2mqIY+JVNuiMN5QCbhvVLMwJDU
	qeSwb/pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phoc6-003HgN-2B;
	Thu, 30 Mar 2023 09:30:34 +0000
Received: from mail-mw2nam10on2061e.outbound.protection.outlook.com ([2a01:111:f400:7e89::61e] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phoc4-003Hf3-0p
	for linux-nvme@lists.infradead.org;
	Thu, 30 Mar 2023 09:30:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdJIa0un7k1taW/CKPG86rXBhu6LMv8oH7DEZ5yoF3li8YNTtpRvZaoLG4Rhhr/wFy/cqW83mRBsfqQQQc47+4Bk0QgDCs18e//xjvoJ+Gf0A+D0t7aPlZWV9bJbJTmpAqRCaJBcBTbHvS268AV5jrg8PPKYLD46VKmhblj2wjVX+ysQcFoTORtDDYUKbEM6LJLGtQyzSBU44SHSlLEnAC47U27i/xnl2kQsKXIJTgbKdlcgHruIdH3kgCM2jQH16hD3h3ynA3K+Sifyw2b6KHcevLzq+I6zb7tKmqAx/unSqBF/4AXBSabRWykfug6Tl7DUJ0/JQcHGP7RfbPG55A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+KnsvG2ZnzSY7QH3OBHZhiU9x7IVkh5zDrM6knNE1Q=;
 b=dEQVGdZNCzIyx2jeaxq2/mPWJSXBpkgBDenKCZFTexChehcMdUSnkgjxMWl94xPme3mA9y0OIh1wMW7CMsDsjOgg0XHuzsZsyzd7Of+SfLtf5CpE/MprxnHqEQDloA9SSUG9GVI+styoSOcs3Oe3FvhhvGbuYc+kcRWpe9rsJ5vST5Dp+xqPqxm3Hjmpyvk58x5eZrHDAIhJjD88gRby5csCJ9T6HWAWXxpSTrGEumAm/6ctxGOLxIE0tXVQGip36f9UzttQhQptOHyGgKa3Uh+Ptpt7eWPwGFrp/ErGMYxh7e4GjnZVF46OYLqAj99HfNNza/tAjABmz8Xq3XtYUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+KnsvG2ZnzSY7QH3OBHZhiU9x7IVkh5zDrM6knNE1Q=;
 b=H/K4134iuFXkJ6yNv1Peq0YJdslV6TU/Rp2PYByvh1wUjwJ19tqRa3tvN7hnjJFLq9fH7QdrfxA7e3v3heLXzHejyeOFH4EC0SKkVVI5Q/YJ/GtCDNe9RPR/Pih5gFyrrc54+Mzzs3cPBxotscoBm3qy02pGbeQA4XEewBQkyaOla6y0OZvJBmrZI8XUC1XQq0Wjp2A6jQYmq+jRCFCyp51SsC/5RZBgQbLyK2bIFOs4Jq8l3weF4eaiEfDpRVUQGujz/8v15LwprAx3ojXpRvL+grOYFCJX2pB63QIrrIJwalcFsUt/qd2kcBPna9CFOb6TlfGmljlaSwqr6lsGxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SN7PR12MB7251.namprd12.prod.outlook.com (2603:10b6:806:2ab::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 09:30:25 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fd7:f3a:3231:c8a6]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::5fd7:f3a:3231:c8a6%3]) with mapi id 15.20.6222.035; Thu, 30 Mar 2023
 09:30:25 +0000
Message-ID: <0d52d8ac-a64d-402b-ffab-fe278f11a280@nvidia.com>
Date: Thu, 30 Mar 2023 12:30:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/1] nvme-rdma: fix typo in comment
Content-Language: en-US
To: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de
Cc: oren@nvidia.com, israelr@nvidia.com, kbusch@kernel.org
References: <20220525145940.575-1-mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220525145940.575-1-mgurtovoy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0521.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::22) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SN7PR12MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: b9b3294e-478a-4abf-37cf-08db3101643d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	M9IArOGDhN9sERjZywZd20T3jX824Ssd9Mt5ZWxJNLq/pN7oMsEVunirz613Ill39+H8fNlMPaY+NNUFGw+HzkD3jq5KuOYC7apfUW9WiAFGMtN+TgrB7smjBTR+sya2THnuVLIjQFO88AS77JaMkX2bjEIpXhQ2IhdpQOKCS/8P7mYxFmRlimo4Te2dP5w9ysFul44eo+6bfoi4HEa4lENTi4iUrUVl/hT781WWPaHyusDe9Mz58ayZHW5+Ogx6mSXSa3zreN3WRP0JO9sNSrxbFAODzW5l8RpFBgQEWlti4kw+p2E7obnNjpPI14JqToRe1tWKpJlvNpaR/9KVQl0eAZKI6gBQSt5cgrwtMLCFNbYzqjzZR2benCKyWBh0mLFD7HSOHeRqRwO4NY0psdKOF7x3rDgRHwziRu2VNjP1HkJG04+4Pq+HO7BHuvI9fJKaUs2PobgcPQRjIAaezgu6tT/ZwXhc9CodW42GotKvzormk+HQrO3XUfK/rFW/zvAhpD0OcIUPXVehP7ulQmaGfshYbgkUtlG55MSHuNzEOhnupl/IJiOheXJNy6jTB0ndBkznpiubbfqbRudq7rtRONFIOBOCpUhhzYXkBzvtIt5mtH76/xG1vjtoQoErP+IRfThfXadaHpmyVBT7ew==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199021)(31686004)(6486002)(66946007)(478600001)(316002)(66476007)(41300700001)(8936002)(4744005)(5660300002)(38100700002)(6666004)(2616005)(83380400001)(2906002)(86362001)(66556008)(8676002)(31696002)(4326008)(36756003)(53546011)(6512007)(6506007)(26005)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?N01mdmpwWWJFcEtWMm9jMmFZTTRhM2M0RXhOYTlUSFphVjR6MXBtSXM3NTFl?=
 =?utf-8?B?WmJEa2FTY29mRHNCcDR0dnpKRVdEcWREL0YvSVhQbDUrYWh0N3V4bHdkNFRt?=
 =?utf-8?B?T29aSXdhOGcwN1NaMlhCeFFzY1JRaExISnRjRlZLT0MzUXpJZkRNVzVlZ1ZC?=
 =?utf-8?B?M1FzREV2THF6bGNRSVJHZXNxNGF1Q0krTFcrOExaem5PYkxuQm9YUDgzeWo5?=
 =?utf-8?B?RDdxcis4WTBiNmR0TkN2bGVIWk16Q3d3bVl2SnlpcGtDT2h2TG5zQnhkcDV6?=
 =?utf-8?B?NFlqSzBrWnhMV0RzMXFaanEyMmh6aFk4bEd1QjQ1RlBFaHd0Z1pTYXhaQTEx?=
 =?utf-8?B?UVlwWFlCYU95L2EvSE9xSUZMSUpka1g1SjBlaU9EQjRGZTcvdldpRUhOMXdY?=
 =?utf-8?B?TWRleEVpTmQ5M1BkUnZIRjN6Q1FkdDMvWGxYRnNSdm5TQ0QwZEMxWkx0Tmh2?=
 =?utf-8?B?THAxYkg1azl6WmNLNVAxT1VrNm9tRU15aGNwVmhOTEcycFUxcXhZWjFEdWov?=
 =?utf-8?B?T1ZBWTBFdE5CaG1LSHluZDNWVXJkaTFPWDV0V1FrY29McThvWTBRQ1ZQMXBG?=
 =?utf-8?B?bTBrZWIrbThrQUdmMnRRRmxlRGRzOS9qMjlXWTE5Q2IrUlBhYzEyNDY5NkRt?=
 =?utf-8?B?UGZwWHN0ZEcwb0tPUkFiN1ZrUmlOU3ppWGZxTVBoRjJBVGZEcldpU2pjTC91?=
 =?utf-8?B?OW9GSllMblV3SWhNMkJ6UURkS0hsczlrQkZhVmM4ZktKb0ZEcm5xRjZ0Tnp2?=
 =?utf-8?B?MC8vRk83WjhoRzVVMlA1bms2OGlRbGVuSmo1MWVRNDlxMlpFeWovSFZacGhP?=
 =?utf-8?B?S1dMaEdJczNMU0xVTXZUb2laTUNkU0lidjloQkNkdkhSbWNIdForc05rVlBE?=
 =?utf-8?B?VG5EbU5ySCtaVGtZT3JiRzlUSlk2cG10Nk9oK1lzOVQxdTN2dkF5SVU1SzNs?=
 =?utf-8?B?dmZ1M05QcTVHSklQVWJFemtqbG1VeDlUTi9ZQzllK1dpYUFOY2FwSDFFREZE?=
 =?utf-8?B?czNJaml6bnkxT0dIUTRnUEVwRlVlckR6VWo5MG9wRnh1UkdaeTZ6NUprRDdP?=
 =?utf-8?B?RkFVWkp0QnJKRXZrVzFTc0RaWmNELzZYbk9rWkJyZWwrTlUvM2J5T1I2ZkUv?=
 =?utf-8?B?M2UrcjJGMVV6ak8reEFYVXFSUXJTbld2OGdONEhHQklsaTQxSkRyOWdWaVcr?=
 =?utf-8?B?ZzZJK1c2ZUhVTUsrWUFtY3k4c2UxRVhRdDZERVRoMGI1dWt6K0ovc0tIN3dC?=
 =?utf-8?B?b3VCTlRhanVxellOV1kvbXNYTW5wNlpsYUVVVmJKVWphcWRjdXdRcXUrK1lJ?=
 =?utf-8?B?OGNpcU5ma2hhejlpTmRzUmVERk0zVWRIVUNuY0NZOUZrWGdRU2JVUjgxb1Yz?=
 =?utf-8?B?NlllRmtPNlhmYVoyN1YyS3JqV2c1WCtCT1NEOEdveHY0USsyZXZKUTd5NWhi?=
 =?utf-8?B?R2Z4YjFybEswaEpPRXF5VEU5UW9YblpiZVZlQVk3clNUcjRsMHVNTnZ6WVdS?=
 =?utf-8?B?SEk3bTcvNHA3TVRBQUpDYkg5T3JOMVplSkR4eXVYdDdLbTZ1M2V3R0hLZ3JR?=
 =?utf-8?B?dnZ6TWl4Rk5JR3JTT3RoeWZ1dEdqMjVON1JHTmw4L2xxY2V1YmZtN0VnSG1Q?=
 =?utf-8?B?NEdvdFpZaU14a2FNVjRzMkg3clV2WVFiaXpodjk3dlhEZEl2NDNzb25LeGNF?=
 =?utf-8?B?T1FqNXoyNUhjbVY1UVpHaGduT0RFY01QVkNDYVVHZ0p3dnZpdjZKYWdVMS9w?=
 =?utf-8?B?eEV5Y2hBZUlTOEtFWkdYT1R1S1ZIMEc1S0FRT2NjYmdHY2JhOHc5d0gyQXJo?=
 =?utf-8?B?UTFJU3V5U0lBSUtCOEtJSnVhNFBwYWY0RUVvSjFYM0JlZW94RjdXMm4ybTZv?=
 =?utf-8?B?OHFkWWNSZ3I4L3Fub3hyWTQ5bnpLdmpZSzdYT1I5WW1zTFMvbmlQaDhsUTBw?=
 =?utf-8?B?aTBGMGE1NkRxNm1UZFdWUlpRbXI0Q1U2V2g1bjE2SllRQ3dlYUgzT0ZlSEdP?=
 =?utf-8?B?QWNoWFRBTFBNYXlaZk91aU5BZzZFNVBXd1VJME85SHcrdHltckhwUmdvQk0x?=
 =?utf-8?B?SUl1OS9RNzFHSmlFazg4aDlMeE5FTmZPTXBKREh0ZGw0aUVOSUE3MTNmZEhx?=
 =?utf-8?Q?s3mUEmJOM9DRiIj4vrVFh8YGD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9b3294e-478a-4abf-37cf-08db3101643d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 09:30:25.2716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: esJzywfrsAf19uDwReWI/wXNLiwPd5nn5lU6IEJGLErAlzev5eXy1ENbHQH6TICJdFZItmJBt/BlYIl++NYr2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7251
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230330_023032_524106_F905780E 
X-CRM114-Status: GOOD (  15.46  )
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

Hi Christoph/Sagi,
I've noticed that the bellow patch wasn't merged.
Can we take it for next cycle please ?

On 25/05/2022 17:59, Max Gurtovoy wrote:
> There is no ib_stop_cq API and the need for the +1 is for ib_drain_qp.
> 
> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>   drivers/nvme/host/rdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index d9f19d901313..12c7ea61ed0c 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -509,7 +509,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
>   	}
>   	ibdev = queue->device->dev;
>   
> -	/* +1 for ib_stop_cq */
> +	/* +1 for ib_drain_qp */
>   	queue->cq_size = cq_factor * queue->queue_size + 1;
>   
>   	ret = nvme_rdma_create_cq(ibdev, queue);


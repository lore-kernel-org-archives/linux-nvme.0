Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A834C47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 09:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hl31gREUol1TzUlNjVbzlA0B0Vq2ZwGmfn5fO9fKVOA=; b=tSRiz5nJG6yZuL+NMHzh0Fg8h0
	rnzxZgBt/tBxoWQPxeDm2Bk1AZj6D5ntBdU7r0LTTEt1E6j0fOjev1PzAYNOSRvKD2lSTyAjBWfeM
	WHj8HNkEMIf6Od8KmFuG2zSW+YDOpqBwmgSJue+22PJnQAXftCuKE3ikPoHDcwQ70Vr3zd7OObhBh
	xd6uD6i3XYsqY2yh04KVLly/kQraCBdXArUyv1mqrWhozGh0IQlTE1zCrgZFBqLCc2rJVwqNZWOOO
	xBYYsQIo+mWaM8Kc9OTMfTczHV0CS2wIWjGd0T4KZ1lyV/9iljbiAV+Cvrqy6b4O5hqj+1gd99ZXa
	jbf++wpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSD9Y-00FlJY-1t;
	Tue, 23 Jan 2024 09:33:08 +0000
Received: from mail-sn1nam02on20616.outbound.protection.outlook.com ([2a01:111:f400:7ea9::616] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSD9V-00FlIw-20
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 09:33:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VftK/BcG66qJtL+ZrM44CW04H8mAPp3UMziULTxY8oiK2sYQhH0h+aNqkdlDcT0JA2URAlJDb5ZV7qWvmbL6PILTfepuaHkiqe5HOX5W552BYxbtQNZ/fINb4cnpAbOawwnrUodGuhOVx96cB/O/rrpyqu8EdtZtiT4VALCzQNgUwyvo5Kz/cR3NsBrqkzQsOEt6IngkXpmiccG4h3ubDNUIBmpPxO22sNQK461J4P/vkRHJ4M9uIpGcfZRVgux/8uWZ7N0mQxuYlSU8Y+ydYA3YA90HlDYv91Ky/vHfar1cZuzQ7V+fbt+6JKwyDdt7j+dtb8FLCGBKveabmD8GGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hl31gREUol1TzUlNjVbzlA0B0Vq2ZwGmfn5fO9fKVOA=;
 b=SXlr4sczuQeSvVcuDhFvkhjnNp45uzL5oAwNTFR3F+4VSrWWFdXDsoPsM3oNDxOHL9S4VL38bI34XuH7oFTZtneh59fKbsYiIFU+Pk38ZlxCvoVBpTLqnQuX3WwRvLGkKk88+jaq/L3OuduguZeQ+UJf2Uoxv40uxj4Wvj4qRD22Q8sdoCOBwsfFLZjiIeZpfGLptpsHgJRBF8BfqKroz/ovNfTnKKVG7JlF/Rw0ZICl3BCA8fzIwnFlHwZM/dTpXMED/g2q4m5rQcbbfCVaD1E0fIs4K22gIA784qv5rnBTugxoQsalcSdaFdIZbc5rXf1c9pwc31Agy2DhDXC7hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hl31gREUol1TzUlNjVbzlA0B0Vq2ZwGmfn5fO9fKVOA=;
 b=kLIInmKHIiF221MnJ457mj+mE3TGNlGwYtcx7yjEAq9aM2ChZLGC1tvwVq6AC/AcMtQ6di1WtbC5wQ5l70X8h+02ZV+QqTnsuMBgLH2ksYhqDWOCRKiAuLfb/p5N3kyQjGYcjp8LVQEHCtOPvgmqQUESv7MsVsQ+rRHaczToGU0tPP2tu7T5OnSN2Jw+9MZbfLNbh1YUvGWM3Q+AsUie1EefasKYA/VrGipVIOEOJpv9/AC8t8UP+tgn2Lb6jEMb8Xq9ARNvuJEzBbAV9MTExPuOZ3QDRoeAxZTykqUHS7H6GUUfEYGyB1bcnCbi1fTm6faVDvj0KM6fWYIEylrD2A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SA1PR12MB8858.namprd12.prod.outlook.com (2603:10b6:806:385::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Tue, 23 Jan
 2024 09:32:55 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3%2]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 09:32:55 +0000
Message-ID: <85ff8156-819b-4ae3-ab4f-f2376f23ccb7@nvidia.com>
Date: Tue, 23 Jan 2024 11:32:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] nvme-rdma: clamp queue size according to ctrl cap
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 israelr@nvidia.com, kch@nvidia.com, oren@nvidia.com
References: <20240104092549.25721-1-mgurtovoy@nvidia.com>
 <20240104092549.25721-7-mgurtovoy@nvidia.com> <20240123085447.GF30155@lst.de>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20240123085447.GF30155@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0042.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::14) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: f8af3f21-e58a-4bef-bbc0-08dc1bf64775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AyCEpbxYmlcACHxLG3HJrE+6fpXezlxcZfdLvx0H2VVz2aU1gtuAY85W/ZCcvVcNSqutr8uaFLVLoCZBFPt+9S/EaLE0Mm91wSSSGdZKL1Z3jdCFsMYnpMi56FYjO0Lmrqv1d26cH9wYZC0JNhjJBpFSyYTp7fI7mYC0zquH4N8eUi7dmgro8+KY07F+ESEYFpO4Bn38ftaIT3MCV0dFvXcy4GkND95LZV5oEIuXp+6zn/D5EQxem2lNZZ7imBA2c9nJtWY8tYeem+jfdasK/NE4+hjBkO+48s3vtyXedlXpqsTLqnuTFhvQJu3MeLOG4JPnAQ/4YGuyogbNcrofz/XBuM9tcgDgSWXGQ4o5aX+Tkjj0WSX/AWtz1MfFB7ALovloRv5EqiXfkebdcO9bknBoyjks9gO4Sx/G6cR//6ba3NRt+ORYxMMr9j/yUUSl0/SQDiQmlSHp2wECOPojfzh/GROl/AIsmY7AWTVFz/s/oB54fKeo5PHJe5JpmlWKNlpqI3JluLj/89cSHm64ffWXYU5AitdzfaZ6M3KPwLwFIMAmRXU9lHrvNrIkSWlgKBo9qGDNTkSQ40mTi/mO0JRrV6C/GyGJZrQ1/SSgcgrm4ruweEGSptm1h7v2OjYUosy8jyhywxyDZjHco7wlew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(36756003)(31686004)(86362001)(31696002)(83380400001)(107886003)(26005)(2616005)(316002)(8936002)(66946007)(8676002)(6486002)(478600001)(6506007)(53546011)(66476007)(66556008)(6916009)(6512007)(6666004)(2906002)(41300700001)(4326008)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REVkODc2c3FTMGptU3J2emNHRlljdUExOGlsUGxTb29YSE1hZ3dUSlRRWFlO?=
 =?utf-8?B?VlFXSzdpRlV6S0pCdXZaN2tYaTJXMVZnM215emdkeUNaVnlFbE5RV2NGS2tO?=
 =?utf-8?B?NU5KZVdhQlZVSEVTWFpKcWFPMzlDRzM2MktlOU9WTFJKa2RSWE8rZnZHNzNv?=
 =?utf-8?B?QlpBY0pXek1UZXpTN3E3b2hnYzZDWjdBbFlxaEl0eDQ5MS9SRU14a1YvNXhF?=
 =?utf-8?B?a25adVhXNU1VbGIreENYdUpScG1FV1NrdW5WN0ZXZlZsM1NtTm80UW1rUnhz?=
 =?utf-8?B?S0txMFdETDBOS2NIbXordWhhTGRLVDVFdVVRZzluOEw4ZytoVjB0SnExUmR1?=
 =?utf-8?B?SWJOR1laTWhtejB5M2krKzRCK3IyV25lYzBjTUdGcTFrZW8yL0NDK3F6cytN?=
 =?utf-8?B?dW16RTkwTHdjeUd3S1FlNXQwM0c0VnlmTElDYllFMFF1QnZHS2V1cmdrY1RQ?=
 =?utf-8?B?NG5RSDRsSFhvbHRnZWFIcTAxZTAzNUVXVzYxY1gvMW9hVkR1c245UXo3Rmxm?=
 =?utf-8?B?ejI0am1HY3kyZlNQRytFMGZ3QlQzZDdRMXB2RVlIZEhzcStYM0g5YVZmVEtH?=
 =?utf-8?B?bUtDeXdYZDh2RHozd3dKelpNcytaV2VJbC9tTFpCRUFLS05wVldBemlyQlIx?=
 =?utf-8?B?cHQwUVZhUVh2dmxyNHZCL2N4MzA0MUo5ZEdueHNXaEZwQnJxYzcyZUlINTJK?=
 =?utf-8?B?VWVhYjJ1Y2lZN0RwaXl1aGEzSVYyaEIyMzd1Yno4clF6amxwaTVTME1wSSt1?=
 =?utf-8?B?MVZjWnp1Wk1xUkZUb1U5UzhNZ2NJdnI0Y0cwZDczUFJCVTQ5OUlQWDJyVUhm?=
 =?utf-8?B?YlNISHBaZUp1dUdQOTB3QnNURWhCRFovdStPeVdDTm9QOWk3VS9QdGtLallj?=
 =?utf-8?B?U3NvVU05dndEWEw3R3hNUm5RZTlyUDNsUFVMNGRpYi9WT0Z3WmpmSnUwNUV5?=
 =?utf-8?B?aUVVZTlkUDVzNU5xbWZiTXZaQTJ4cDJnWGpCVGI4K0NUV25tdk5CTXhySFBz?=
 =?utf-8?B?RXUxOG9MSFhZQVp0K2FSN1RIcHJVWkF5Qkg4TjJDOTNKN25uTVcrdEhlc2d1?=
 =?utf-8?B?N0NzWnJYQnVVOVdORWpad0phdGtQd2d0OHVlcTltb2t4bGdiMWdrVE5VMDI2?=
 =?utf-8?B?SHlINnBCaWp1NHkzWkVlbktHejJSdWY0SUNMd0hBNlJEcVlmV2xyRVhtTE5h?=
 =?utf-8?B?YlNsekpZV0s3TVNWZE9VRjVQeVFOMTlDSk1hVDBCdFc1WWZUWFJHeXZHSlVX?=
 =?utf-8?B?NjFBZlJIc0lvTm02UExPWTdJaUVGNCthd2tjOUxxQ2NveDhiek8vM3AwWHpF?=
 =?utf-8?B?QmNDbjZaOUVpeTNpMmpNbHZXK0dPcmRiUWhZUlFDYnVjSHlQVVliMXc5WlhX?=
 =?utf-8?B?Ull6dm9LR20zQmxqRjdudTVLZ2hnQ0V1bjBsSEVuQVFva3c3cmdFMC8rWlFH?=
 =?utf-8?B?Ukx3WXVIakRCWWQwWkluZDVIWUhiNEJZSG9XRWs5eDZZMVhsUnd3c3lQdVJF?=
 =?utf-8?B?RzdmMFFnQ2F1SXFYMm5jb05Dam5PSi9tNmF2dENOMFQ5eTdxUXNEenRYSFNT?=
 =?utf-8?B?NmxVMVA2L1N4eFFDYTNHeitJcGE1bzZZNUwvdXVwOWpvZHRDbitvVmJ1RGFl?=
 =?utf-8?B?MjNoWmdpSEdhbVdCVVVzSDlFQjE4V0FHQmw1cmVhbHpzc3Z0RDZFV3l3YkJL?=
 =?utf-8?B?bGlJYlB2TE1kWktWcjZja3RDY2VQbnpqL1lncWtDOTdXenVjbXFiOFdmelpT?=
 =?utf-8?B?RjhqaUdZbzg1Z0VxOHFXYUNqdjY1UkMydHVoNnJQVTdST0JTMm9lRzhyWG1B?=
 =?utf-8?B?dTV2VDlHNll1SDBXaEk1MUVjNXBaUFp0RGt5UE51RnJ3Z0tJTjdLdHYxUkNJ?=
 =?utf-8?B?a3lWZ1pqVTNQWjhlSmJpZ1pLaXdjRDV5UGZ3dVpKUlFQbnFTR2xabERTOXZt?=
 =?utf-8?B?K3RtbHl5R242V0tacTd4RCs2azJoZzNYWC93eXI2Qnd2L3oySWZGcndMSDdE?=
 =?utf-8?B?WllUd3IzN2w4YTNmKzBUbHIvT2Rtb1BoWFU2SC9qNitOdWRMVFlzZTBJZWtF?=
 =?utf-8?B?elo2ZHgyWi85c3gyUVNISjdGQXhTMTVCMGlEalN3clpXR3FNbnlsVlhrTWNP?=
 =?utf-8?B?TXJqOEw3eUUrNXBPaEhUSndlNEttZ1ZIdmdxeUVYM2pWTWV5WGV0S3FvdVkx?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8af3f21-e58a-4bef-bbc0-08dc1bf64775
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 09:32:55.6887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3H/BVPrH8AdZQoQzFxAi1RTNkCFUDwzuC6Uup1qYfSy+/OGGEmawfCu0FZJ2WFBPQSJYPC7N0ATnaViZ4qEOZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_013305_661351_86C0B622 
X-CRM114-Status: GOOD (  17.18  )
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



On 23/01/2024 10:54, Christoph Hellwig wrote:
> On Thu, Jan 04, 2024 at 11:25:47AM +0200, Max Gurtovoy wrote:
>> If a controller is configured with metadata support, clamp the maximal
>> queue size to be 128 since there are more resources that are needed
>> for metadata operations. Otherwise, clamp it to 256.
>>
>> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/nvme/host/rdma.c | 19 ++++++++++++++-----
>>   1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index bc90ec3c51b0..d81a7148fbc5 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -1029,11 +1029,20 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
>>   			ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
>>   	}
>>   
>> +	if (ctrl->ctrl.max_integrity_segments) {
>> +		if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_METADATA_QUEUE_SIZE) {
>> +			dev_warn(ctrl->ctrl.device,
>> +				"ctrl sqsize %u > max queue size %u, clamping down\n",
>> +				ctrl->ctrl.sqsize + 1, NVME_RDMA_MAX_METADATA_QUEUE_SIZE);
>> +			ctrl->ctrl.sqsize = NVME_RDMA_MAX_METADATA_QUEUE_SIZE - 1;
>> +		}
>> +	} else {
>> +		if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
>> +			dev_warn(ctrl->ctrl.device,
>> +				"ctrl sqsize %u > max queue size %u, clamping down\n",
>> +				ctrl->ctrl.sqsize + 1, NVME_RDMA_MAX_QUEUE_SIZE);
>> +			ctrl->ctrl.sqsize = NVME_RDMA_MAX_QUEUE_SIZE - 1;
>> +		}
> 
> Can you just add a local max_queue_size variable instead of
> duplicating all this?
> 

Sure.
something like:


         if (ctrl->ctrl.max_integrity_segments)
                 max_queue_size = NVME_RDMA_MAX_METADATA_QUEUE_SIZE;
         else
                 max_queue_size = NVME_RDMA_MAX_QUEUE_SIZE;

         if (ctrl->ctrl.sqsize + 1 > max_queue_size) {
                 dev_warn(ctrl->ctrl.device,
                         "ctrl sqsize %u > max queue size %u, clamping 
down\n",
                         ctrl->ctrl.sqsize + 1, max_queue_size);
                 ctrl->ctrl.sqsize = max_queue_size - 1;




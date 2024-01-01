Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23769C47073
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 10:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wubqZW9SQ2dJrVnvpjy09FSks4efMG6Gw6WQYplNOkg=; b=0t9NBBAl/7Hp84XA+Dr0+g8x6b
	MoBvz71n08EZtczSjY3CWcvFS4QD0BZrmhl8ThDO/Ua07CwvAbcGsImCIgs/jlHAGfYrm+LtvwnGX
	QMoHi1fF+BjqMCmq2HnhkNfQx4S1VzH/DjYw7psST5DOodH+8STAwrDBulhMu7jHPXcdKycG44jKP
	oRI55rRVmxkTYKqelDdTOBYkthfeGMflBkWJeT84aBF7O+HJOFBt4dYoYjUBs9nNf6pg9vsCjOoXY
	22Oiet2OIIBVR5Cfin7ug76uXLzAQBqa5nloLAeDt6F9irUgVBS131AyInaFWQItS2UeWRCE0PgkP
	08DpgB4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKFzG-005uqm-1l;
	Mon, 01 Jan 2024 10:57:38 +0000
Received: from mail-mw2nam12on20613.outbound.protection.outlook.com ([2a01:111:f400:fe5a::613] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKFzD-005uqP-2Z
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 10:57:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Un018jLxQoynMu5Lwmd3H456g/83I/JzMc8iF+synKuIYtCLTZT8FS4chPPB9SFYrfOR8v25lJADSu1fw/oIMbFH2pwivp6j/W0YrKrOMa6WDFC42Ko9HFyeZXeS8uR+w72Wy6sRh2w+bzgLL3JgJOnwhp1qO1E7d2WM3JMJAx+kXQuGRqZCaApR4IIOItGGhwLjQDUpl5qvxGrJbndM0tjfkRFlB1QGrYz+jEOx5GRl5v9+xty3UpsmiNHuX2TAubf15jIhcsf24/K/GvSd2e8cTsTRpnVpuAIjDaKVO9+GZiRm+4ivnbZEEYqnvpjF02pOtKkC1L31ZF51vm/+yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wubqZW9SQ2dJrVnvpjy09FSks4efMG6Gw6WQYplNOkg=;
 b=CEXGVRkcrfKYlU1Vt17CyUxh9MBYcN2U6WCY8M37x/hDMGalPzhE0H6C/Q4OqgImlWrM7erWqYOXAto5cC3yJ4EIHCybisuy+CGsRc5j9FUlYot/IN8+L/ZRiTZ8dbpFyImStAlLG9MCDW48J8rHwPh0V6DW3YPUJz6HgF3l9b2V+f3KG3pGRY5NGBRC48Cy0vJWxpITeuJARELA1xtxZI131dQNphzk/HuGJEMNiiHFtg4YRuzibc5royj2HB3mYpurnLMneu1pKcUzJfURUARBJ6v+HDUwOGr9yJczsXqlO9qAxJQDSBj8Vt3drZsjo0FFIa/XIpCiBWqPhhq3Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wubqZW9SQ2dJrVnvpjy09FSks4efMG6Gw6WQYplNOkg=;
 b=bjm4IQ7GIuacbHSznt3UQCt5b6pbzlARijZSCArQu7vkIjb0Agl297pv4wHMiukkK3+LC1NGyDGFk+wN6qcsZQJVYHAMcc8KT2rWvO14OEon1EpUt0X06o76VZfrEKBaseEo4SpjGrKuLhGrX6f/PPDu4owC+LWhYDLmYSHyacm9Wh46EvhmVAEcGOquqRW919s1U1taXqhimzzisdN1+hG6MIjKB3+W+d24zE4tAzCsCAE7ABvdneWtAO2KBiRs2kxc2lCcmAS1i4l8ZoO0FI9tnFND3zpq4TmeYS2/YAAuDhk+J7+V7vjCJHKmthVJU9d49C3mKXYZbmw0YMWBlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.24; Mon, 1 Jan
 2024 10:57:21 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7135.023; Mon, 1 Jan 2024
 10:57:20 +0000
Message-ID: <b1363b4b-ce14-4797-9080-40e9d37a6b97@nvidia.com>
Date: Mon, 1 Jan 2024 12:57:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] nvme-rdma: introduce
 NVME_RDMA_MAX_METADATA_QUEUE_SIZE definition
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-8-mgurtovoy@nvidia.com>
 <d55384fd-42aa-4aeb-8a7c-f36c6a9dc6a4@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <d55384fd-42aa-4aeb-8a7c-f36c6a9dc6a4@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0086.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::19) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: cb61194a-5526-4bde-3e96-08dc0ab86d75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 14UnuXOxrJ4dAPACUGd06fQCcOokAE0iLapW2KKK6AfrJ7UGGyrVh3lMRIOHNwHNu3Q02qK+StoMDAFLKOtTXVuPBjoUKF8B+QVQxnvZP2IbL3ViZx8/YjLFEPjyefTmD40vhXVNc7atNjfdOb/u9MqJ64qpNoH8m8xKTZkKSbVxeVpvufCwP6ki4y5PXrfdXg6e66IpDR4egcauubLCfwWEhZKmO7ckkfQFpzs30aVB61bE2wkgbJFr72O8XlJvir9e39rZ0OWWHFFX9arEp8kFArEG9wbyju0roRZj792LDlUEW0cFJdUjAZPoc3dGSiUDkb+GybRsA3/XdhLzJ7jbxV33umkYHuUUgTRNQ2gcICNP/EUHsKIU93iFF3nAyVfgKRtx9EntMNUGZpkVpSADp8trpCBl9LFSmcq82XVEtmrdZYwGmhGiiLPHD5uct43mT35c2hLqo5XqYgP8rYezPrLAg4TCgojmc+3ji4jb77moaIMob+ziTjgFDYh56+69UNf38oWHl/Bq7oHKG+6n+ScZvD62bpHwvM6iIGv/c7DEnphHhtrPWRX2ZY1ATTOGWSiIT5HTKgo7yBNrf+sluIm6kV2Hn0xx+0s88nnXHrMdpbROcEnZO0/KGeQFmimgcOD8p60HrgNTwhN45g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(478600001)(6512007)(38100700002)(6666004)(5660300002)(2906002)(83380400001)(6486002)(6506007)(41300700001)(53546011)(2616005)(26005)(107886003)(316002)(4326008)(86362001)(66476007)(36756003)(31696002)(66556008)(66946007)(8936002)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmxXVlJNZ2NJV0U0czJ1TnFLS0FFbnhDbkVPaE9QcU1nZG1qS3p3OFR2aXV6?=
 =?utf-8?B?OTI4Q3IvSHdKTEZhZ0dSQmcxa01ETHdjckMxcUF3R1p5YWZDNjNjd2NZbUc4?=
 =?utf-8?B?anBVVitxSmJKNmNZNlhaRitpRHpDVEpiclFnTE1IVmRGb3dVQkg4Um52dGVM?=
 =?utf-8?B?RnJUZzNEdHdJVGpTWnh4TmdvTTNwNEx0YVZHemN3bUZYYTg4UjV4WkI1ZXZT?=
 =?utf-8?B?RXMyRHZ0K0daQkNJNTdES1o3Yisxb0FBeCt3Q3lHRXpsSHR0V1pNYkg2RnRS?=
 =?utf-8?B?RXZHYTRkM04rTDBvcUp6U3RYTXQ5YXhxTUNyUFdFbWN1YVhkWWN2OVZJRGZr?=
 =?utf-8?B?OS9wUDBONnd2MXJrRXA4TWJTTkZ1T0lHNUpxTmFzS0NKZWNVd1YvRzU3Z3Yx?=
 =?utf-8?B?UVhVY3JXaW8xQ3ZuV1RoaGxMVEJPSy95N2l1RDVUM0JvL2ZwR1RnMytHNzRx?=
 =?utf-8?B?ckRub0NOZ0hxa1ZLc2lkV2dxeFlzM3BaZGlKdTR0bFlHa1Q1cWFzR3JHbUd0?=
 =?utf-8?B?dDZQU2Rzd3NvUFVxY2hhOGxDNlExdk5Zb0srSTg5VFBWRkdpQzZLazFwU0xU?=
 =?utf-8?B?SmJ3QVhHV3ZzR2hCOWJ4ZDRPdzdMWjNBdTN4MWs2dVRRMis1OVowSU9tOWhU?=
 =?utf-8?B?OVl0OHRycjRKaFE4Z1UvVzREaXZrdVBlalRTRzlRL3NSeWJxREhIdUthRC9G?=
 =?utf-8?B?Rk1WeENTUW44UlhCSGhSa2FVYURSejZHcU96U2hXQytCaTMzcXVvY2E1ZURr?=
 =?utf-8?B?b09nejE4cEhpeTBCUnNNTTZoUjNxRC9rMW5nSzBBL1FEVUppM3BhNnJoYlB2?=
 =?utf-8?B?K08zdm9EWVB0Vmx2Q1hlcnNuREx1SWZpWjF2M1drUXFGWGZLWFhkb3ltOEha?=
 =?utf-8?B?SXdpR0JBcHROekNZKzZQUmFKVEVYNUhmdHZiUmJscTZwUHNoWldweFcvaElS?=
 =?utf-8?B?RkM0eksrK00zb2hRbm5Uc0ZGTzBEU2NMWDBCUjR6YnZvWG04eTdiQWxDWnNE?=
 =?utf-8?B?T092QVphNE9yYm9ORklqZlgzUnNTL1JJeXU4NVNpZk5zQ3pMSzNUMnVNZmdi?=
 =?utf-8?B?QmdzVml3UjZxUi9uckJoYnJaNnkzbEdJblpwcy9Rb0tNTWMybVdmZ1htcG5U?=
 =?utf-8?B?K2xYY29FTDZ5aEVjZzFNd1lXTmNqV1VGT0xXVmtQVTE2WFQ1OWFjeDhsSFB2?=
 =?utf-8?B?SjN4OXJkU05ReXRZSHI1YzdGMTVTTnhpUXlrUW16QThqcHhvcTdqb0UzalI4?=
 =?utf-8?B?c3hsaHVGR2pHRDFGREpoeDFEZUtvWmhFRFZHcjI4cTFzYmM0Q1pCVGFudG9Q?=
 =?utf-8?B?THpTcTIyQmJ1cmdLcjN3WWRlb3RPNTZZQ3dVNERJY1FqQjNISFFlZWxncjd3?=
 =?utf-8?B?dFN0ZXA2eGxYTXF5SUdyK0lad1NFL01pOXhRWURvc0Mvb3BrOXNYOTNtR1pn?=
 =?utf-8?B?OXVMa2tvL1ZHaEdRL3RFMlphYkJMRmVXdnZiaFc1clE3S2U1UGRyeFBlaUpX?=
 =?utf-8?B?em1qMWdGakc0aDU5ZStaOUg4dHh4R3BQRGlabHNGMGJIQm1nZUs3bVZzUUs1?=
 =?utf-8?B?ektZVXpWS1g3SGhVVjQ5NEZRL1ZRVWVrdmUwc0l5czlKYUUwcEMvSWhJbFdK?=
 =?utf-8?B?eURRbEVPUDd6cnVRMUpBeURMUzAwY01WNGRvZ0I3MzYwaG43L1E5VTYwZzFZ?=
 =?utf-8?B?TVQ0ZW1JMUtoTFVnOHJhQ2VLbUcrc3N5eGpKS0FNNmJQSFkrM1p2eW1vbFhC?=
 =?utf-8?B?MmRCYjhOTDFhSzBMZVY2VEJpMzBDV2FNTjVIMXcvRmdsUFhpdU1iYk53bXVO?=
 =?utf-8?B?dTlxUEdwQktJRGdKdm4zQ2VYTmhnTm1YeWJiMDBGS2dmZGIzWHRueGd0cEJT?=
 =?utf-8?B?cEV6U0xZVmFydXY0eDB0QlUvYWpCSS8zTlBkTUg1UDc2Mkw3ZXVVc1pLcnNs?=
 =?utf-8?B?bVRMYjRqdnI3ZlR4eHRoOW5mNEtpRndpdXZXdlNhUnBtK2I3SEVJazkzQmlC?=
 =?utf-8?B?elZtTjBQbWVWcjBVMjhkN01zMFRwRzNpc1FDODd1QmdtVFVoY3BJRUpnREQ4?=
 =?utf-8?B?V0hKdVdGSWUrZ1VVLzhjQ040TVFHanA3VHZqRXFnZWJEd0hMTDd0eVRMSUxR?=
 =?utf-8?Q?Cd6eDXkyFuoqYueYfs5VIVWUh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb61194a-5526-4bde-3e96-08dc0ab86d75
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2024 10:57:20.8577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9RQk63gtIpuSSz2WT59eWJuz01mR1geSIPWXSmZ2zVRSS0LSfn/LYbNDH8NyuxxgzGFF26OrmLIvWnhX4z5VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_025735_898210_8C2E037A 
X-CRM114-Status: GOOD (  15.89  )
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



On 01/01/2024 11:34, Sagi Grimberg wrote:
> Another completely arbitrary limit...
> Can this come somehow from the rdma core?
> 
> If not, its not making things any worse. So its fine by me.
> Please comment that this limit is based on testing the devices
> that support PI.
> 

We are not changing the logic for PI controllers at all in this commit.

I can say something like:

"... We'll keep the maximal queue size for metadata controllers to be 
128 since there are more resources that are needed for metadata 
operations and 128 is the optimal size found for metadata controllers 
based on testing.

> On 12/31/23 02:52, Max Gurtovoy wrote:
>> This definition will be used by controllers that are configured with
>> metadata support. For now, both regular and metadata controllers have
>> the same maximal queue size but later commit will increase the maximal
>> queue size for regular RDMA controllers to 256.
>> We'll keep the maximal queue size for metadata controller to be 128
>> since there are more resources that are needed for metadata operations.
>>
>> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/nvme/target/rdma.c | 2 ++
>>   include/linux/nvme-rdma.h  | 3 ++-
>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index 4597bca43a6d..f298295c0b0f 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -2002,6 +2002,8 @@ static u8 nvmet_rdma_get_mdts(const struct 
>> nvmet_ctrl *ctrl)
>>   static u16 nvmet_rdma_get_max_queue_size(const struct nvmet_ctrl *ctrl)
>>   {
>> +    if (ctrl->pi_support)
>> +        return NVME_RDMA_MAX_METADATA_QUEUE_SIZE;
>>       return NVME_RDMA_MAX_QUEUE_SIZE;
>>   }
>> diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
>> index 146dd2223a5f..d0b9941911a1 100644
>> --- a/include/linux/nvme-rdma.h
>> +++ b/include/linux/nvme-rdma.h
>> @@ -8,7 +8,8 @@
>>   #define NVME_RDMA_IP_PORT        4420
>> -#define NVME_RDMA_MAX_QUEUE_SIZE    128
>> +#define NVME_RDMA_MAX_QUEUE_SIZE 128
>> +#define NVME_RDMA_MAX_METADATA_QUEUE_SIZE 128
>>   enum nvme_rdma_cm_fmt {
>>       NVME_RDMA_CM_FMT_1_0 = 0x0,


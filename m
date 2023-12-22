Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34944C46CD2
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Dec 2023 01:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:Cc:From:References:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M0rO2AQ3CfmeTUZ8C2p8heY7uLvVF3isNvPX5EYJyNw=; b=mGKdIUJV8vtNvcSs4drzYWuov4
	gXB3lb1M/ay1whvkbOuHow4sv+sSPYjY0jfbjxU8/A8eo4Smqg1eadtRNzML5Tvr1aPZ9AuP9G7wa
	7rOIM8XmW7tl+zYhIhkQSEHlAacGPfDYZ2dEMBW4202xQNPkRDZqJBz3ynpELbFe5+syqBkPI4xIa
	ImgPix/hzFzyX2Kh3ux4hR2wUGcZtQiKf3dPhZ/o9wqIe3ClpJ7/aIMfxEgwQTVtjcNdrNtSpPSUe
	WY2sdaxXaINLKbBy6OC0SqIEkKHH/IiOcS3HYrN4H8JNg37zyiAEFS/CGMYn5TiEdEKlHRs3X9M+x
	94NZHzGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGU9i-004aOT-1A;
	Fri, 22 Dec 2023 01:16:50 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f400:7eae::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGU9f-004aO8-1J
	for linux-nvme@lists.infradead.org;
	Fri, 22 Dec 2023 01:16:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYAzhkvXXPu888kq5rCc+8VrJbK9zYLZGQZgPrI/eKISo9xjK5PIqm2tYzFKv0jf2o0PMxaJ2Z1+qpkWSOSdaI9bwHyqrLho8MkgqpWwNrcgMLqIuqv89vzF/ZUcNQ4cz6HGd/KGkMrPII50QwhYFrok9bvIQljrIfYq7sxd1cZzJS8DwMEaI2g8fftOSi83aNreG/13DTnlIJuPA694oAaB0wmdyagpD/vnrIJHJHQhfif7KfuEzeG6IGtKf+SGUJuJiwTOLDd8o8SS5rd62Tngp8pVa2wIfbgu6GBhKvdcpdtbxdho06hYu7QVepOq5JDOytgDDm5+BV5pCkjLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M0rO2AQ3CfmeTUZ8C2p8heY7uLvVF3isNvPX5EYJyNw=;
 b=I+gjNysoekp7RutqxaaE6pkvzHltz/8uomubgFnfzZPk5WI2PDjAe2lHJV1pwjXKpoKY6Lld/EOsKyPzW4nbV1cXFi6WhnTVCpjjAnxaH0WPdMoWb4ck3qA0gdPA+7gE+8B/lh2nXf0rXG9bI6YUgWCCqiAbz7SCfL3KaT1KhTUF5StVbGZWgNjR2Qgwd2IYPJzQu6Kyy2RMiRho5Lr1FRZQCDFXpsJgjnmQNC322WIaxPPF0JGZHRsZdOslkpPsc8LHvJs/yLOZUVy7ualSwhwhiQfSWrFjUgW+1tbWJuhXNqxmdBxHYWeRbHZSA+yBb64Fy1oPOKEge7zPO5PArw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M0rO2AQ3CfmeTUZ8C2p8heY7uLvVF3isNvPX5EYJyNw=;
 b=YDWoPXPfxW6MIoUIMyXSeAW0tR1VvPw7i1jyhG4rZXnORKxYTfaDR7hplmakMzthFNCxS4CrrntWJ6pLzi8fjQnqiBUuCCPCLmVwTNtMWNwdidWwtNY3KL8r6/waslWkWOs5jh4k5OaATFBml0MZvIKCghsBUTrCrLF7Bb4Fnfv1DxTuxyGTBS3/434Seqegcr03KgyWKWT6L8qygPHJ6K3ijQuNnUR9KMMOUHvdBczLNQUcnL+slnPRaJ8VBeV3bfVSvK4r+IbVipcEa/P/tZ9R0tfu/YJMA+AaXr/aYOb5Y8AE78pgPFFsH76xoQZS5oGtOQedDoBjKGAXZAOBcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by PH0PR12MB7791.namprd12.prod.outlook.com (2603:10b6:510:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Fri, 22 Dec
 2023 01:16:34 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7113.019; Fri, 22 Dec 2023
 01:16:34 +0000
Message-ID: <8cfe55f2-4f2e-46f9-bbc8-5ab80d06f3d5@nvidia.com>
Date: Fri, 22 Dec 2023 03:16:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: don't set a virt_boundary unless needed
Content-Language: en-US
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 marcan@marcan.st, sven@svenpeter.dev, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, James Smart <james.smart@broadcom.com>
References: <20231221084853.1175482-1-hch@lst.de>
 <155ec506-ede8-42c7-95f7-e8be32800a8d@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: alyssa@rosenzweig.io, asahi@lists.linux.dev,
 Chaitanya Kulkarni <kch@nvidia.com>
In-Reply-To: <155ec506-ede8-42c7-95f7-e8be32800a8d@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0204.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|PH0PR12MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: ad452b7f-778c-40bb-6eed-08dc028ba315
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x0doQ5Rl97ed3NDMs3iRfy5I20OwJHmzd5i6knIfodlIyFiqSJxaiD/7UB5IsDySreFEtBnuX0lwikv3gy4S7JHlD+ve6LeLSiMP+4WcPeSu9TEwxs5SNajy6hdXD8vKul6ZM+VL2NZI1drQzrY69Fu0BBkVE1P2Iu+O50vukn8g/OP8mMQgzHyru6k4WRLV7W0wZu70gWfWSqkIs6z7elNssNE+Vof+3oA0oxMa1P0RaC5MUpKTxNoVWrXkXbWNSu+0+HcWNWmMBXIdMc5Mf80/Lj8nn/qVGGPMnD0TVEYPzPMAxR6qPCfIlbD/SuXXZisgedRHV9uE6W0yIoOL8HA40kI91dgyv/oQkvbNKPW3E6VYxaqRbLsZwidlIaBkgHk9esPZHZDcSPL/1hHkuIbU/JYrFCabmPeu5q8bOA3384znetQLBtq7g83BimmS8Ugl221nr4nP43OVxG6Lx/gxn1bcoXyXXe/yf1aWDHnRW+HmgStvEleCPudgu54iKzsXjGa2vqFJglHYKaDIx+U8DfHPKDjBFqfL5DDiy49DAh+qfG4O+OsGXL7kxfszRHZ7Bnf26Kc+AWSgUbF50Q9CXgVtx/G1yDzFgEFLA7SBjkMVjJaQC0C77iWGY5b5O/ER5HLd98SDwb3jLkgjeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(478600001)(6486002)(4326008)(38100700002)(5660300002)(110136005)(316002)(66476007)(66946007)(66556008)(8676002)(8936002)(26005)(83380400001)(2616005)(107886003)(31686004)(6666004)(53546011)(6506007)(6512007)(36756003)(31696002)(41300700001)(86362001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVUzUjB1MTVtcHBrcnlhS2kzUVBtNENnanZCMlVhb2QyakRLZGlrbXFXRmE4?=
 =?utf-8?B?eGZiU29xRlFjR0I0TjExRHB3SWFPSEEyczZhQ3FlRWlxdHYzaVI0cFVLUlZK?=
 =?utf-8?B?N2FxMS9EM3JzZ3lvejAyQnArdHNCcG1xcUU4RGxYcXl1bGVKZE1DQ0dvbFFz?=
 =?utf-8?B?MXN5ZytReGJua3p3a2JWQUVLVHgxODhKVW04Qmg0a1poRCtLN05LbG9pa2Np?=
 =?utf-8?B?WWVhcUdwZEp3dzk2d2lzZldnM2hQYVM1QmMwRy9TU2hUcjZzUW04Y3VLL2lX?=
 =?utf-8?B?eFE1a1k1ZFNKN2RybE11eld3WXdKSFJzTUUzWVJUOTNXNG4rU0FyeGozVGZR?=
 =?utf-8?B?TFRFbHFsSm5YWTBOc1pQTVp4WFVDeWE4d0cyTDAzdXJTMzYvRlA0TE5WZnZ6?=
 =?utf-8?B?NEJteHVocFJORFpRVXpTblQzK3A1RElyMW51WFZrWFF6K2tWTGlLcm5LaTJE?=
 =?utf-8?B?MU9hTEYzT3lhMU9Ra3MrSHhYZTVwSHhEam5qUFVibFdJU3g4akhvTlBCdEpx?=
 =?utf-8?B?MHlTd0MzMkJKZE02Si91eVRERkJNV0k5UWJ5RU0yY0RoVUFtUkRiZXVHeHph?=
 =?utf-8?B?eGtjOHl5K1huU3JRZk5HcXhab2JicVFFNE1DOFlVU2JPY0QxckowZWY0TzBD?=
 =?utf-8?B?WnVwUmh6Z2hJSi9wSEdYaDAvb2lLdnJraEF1b2JVR1RnM2tDdmFGR0p2Tm90?=
 =?utf-8?B?MXlSNGQ4OVNRb3RCcW9TbW80STU1NWMrNWJSQi9TUGJvWlY0R2J2ZjlldkJt?=
 =?utf-8?B?VzZjSGNMM2xHcFNMQnprSHVtaDQ4OUN1VGNzQ0JxVjZLK1ErRm4xVHJKMS9J?=
 =?utf-8?B?M0gyNW1WZDhWSGo4THhzaXF5WmM5cEs2NExXS29VM0RhS1g5dEd2S3lGNDAv?=
 =?utf-8?B?dUpxRzd5NmpJSW41bG0wM3FhNXRSSThJRTJ6N3A2bEdUZXJqQTVNQlgxbkpO?=
 =?utf-8?B?OUI4WW9ySTk1amU2dlduQ0VuRUl5L0FrK2UrUHJnUEVXMXphNnJFR1JXbDBh?=
 =?utf-8?B?UExydTBxcGRpTmhMS3ZDdVlnVzJqTHkwSFFWQXZJcGZsQStyQk9ZLzZ2azA1?=
 =?utf-8?B?a2NhbTBSTVpOVGE0TXBXOFBSSmdabDlHWHh4a2R6SCsxaWZrbmNZSDBXQkVy?=
 =?utf-8?B?L29OUC9UYmtzZ2RiUDdsNS81c2Yrb2xNczAxZkhLMjVDUjZSMU5HeFJiZHFC?=
 =?utf-8?B?SUtMNGJmdGZKbFFIQVdzUnk2NWtrbXgzcVNJeW1weHhrMkF3VVpKYjVvTlRi?=
 =?utf-8?B?UXpQRVg3M0lnMkFnSWtJYlpwSzVDQVpLbXplb0gzK3Q3S0Ywa2I1bXVXcExk?=
 =?utf-8?B?MWtCblpmN3g1WEtFOWhiVmVQS1hYNERwVWRDd2hWeE0rOXN1SlRtNWo4QVRD?=
 =?utf-8?B?dTNhUVRvZ3FMM2FkUnEwQW5nTnRJQmxRYWJjZk9nTGxLKzR2SUdTSmJFQkYy?=
 =?utf-8?B?UEU5WEVhQ3VLRU9ZME5jNzNDdVM3VGVzcU0ya3hieFNCTUJoZ2pmTDJqVHQ4?=
 =?utf-8?B?ZzZJY21oSmNkbWp5U0x1N1lhdGxjdTc5akw2UEEwSnNVM3dRQ2pVbDBCMm55?=
 =?utf-8?B?M1RKSlVtcERpS2hIWDBiWWd5NnFqdTZoK281d3RFd0hCQjRmMmZibmkrZEtw?=
 =?utf-8?B?ZlU0azRIUkFBV2hTb2lGaTZOSmNRUU5QMi9CaXBMcE44MjN4c05YZHdGRkh6?=
 =?utf-8?B?b1FRNFEycmVpUG9mSG8wRU5qY3FZaUgzb2dmdFVTbTlvVVNOenlnR3l6QzYr?=
 =?utf-8?B?SzJyMjZBSzlsNE9FbWhoQXNTbEV3UjFVR2FRV2E5VHBsNm9XcnNPVFcvVjF3?=
 =?utf-8?B?bU5KdlJVdC9MR1RCZC9jNlE3N0VWVTJ2cHNuL3BicTFBb3o2V2luTEttaVdI?=
 =?utf-8?B?UzhDZkEyeWdBYWM0d1RDbE9IdFpMOFlBNGkzajVZcE8yU2VIVjJFcWlZZmhH?=
 =?utf-8?B?S01ncWZLK09YU2NwNjVDWVYvc29GSURidjM1Q3RvQ2pxTlFmTThaUHNWNG0x?=
 =?utf-8?B?Y3JVMlFUMkFZZUNPRDF2WS9XR1hHcmRnRkJhZEZ3MUJuRGpUdjI1MWpaVzk2?=
 =?utf-8?B?K2IvNytGcTcrdW9NcW1weEJoYnlLOFJwTjg4eFBDNFlVTGJIMnA3dm9LSGFT?=
 =?utf-8?Q?EZqziSL3PUiBDwdquvBUS8hxf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad452b7f-778c-40bb-6eed-08dc028ba315
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 01:16:34.2169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JF5ietoMDfWCq7zH02RXt5HX2w+kdwzRPRtBXR7TLxWO2QZlGtWjo1gAr3I3rI4j0mxd7X9D5J9mOA4S5svr9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7791
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_171647_525879_A33E6DFE 
X-CRM114-Status: GOOD (  34.10  )
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



On 21/12/2023 11:30, Sagi Grimberg wrote:
> 
>> NVMe PRPs are a pain and force the expensive virt_boundary checking on
>> block layer, prevent secure passthrough and require scatter/gather I/O
>> to be split into multiple commands which is problematic for the upcoming
>> atomic write support.
> 
> But is the threshold still correct? meaning for I/Os small enough the
> device will have lower performance? I'm not advocating that we keep it,
> but we should at least mention the tradeoff in the change log.
> 
>> Fix the NVMe core to require an opt-in from the drivers for it.
>>
>> For nvme-apple it is always required as the driver only supports PRPs.
>>
>> For nvme-pci when SGLs are supported we'll always use them for data I/O
>> that would require a virt_boundary.
>>
>> For nvme-rdma the virt boundary is always required, as RMDA MRs are just
>> as dumb as NVMe PRPs.
> 
> That is actually device dependent. The driver can ask for a pool of
> mrs with type IB_MR_TYPE_SG_GAPS if the device supports IBK_SG_GAPS_REG.
> 
> See from ib_srp.c:
> -- 
>         if (device->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
>                  mr_type = IB_MR_TYPE_SG_GAPS;
>          else
>                  mr_type = IB_MR_TYPE_MEM_REG;

For now, I prefer not using the IB_MR_TYPE_SG_GAPS MR in NVMe/RDMA since 
in the case of virtual contiguous data buffers it is better to use 
IB_MR_TYPE_MEM_REG. It gives much better performance. This is the reason 
I didn't add IB_MR_TYPE_SG_GAPS MR support for NVMe/RDMA.

I actually had a plan to re-write the IB_MR_TYPE_SG_GAPS MR logic (or 
create a new MR type) that will internally open 2 MRs so if the IO is 
contiguous it will use the MTT/MEM_REG and if it isn't it will use the 
KLM/SG_GAPS.
This is how we implemented the SIG_MR but still didn't make it for the 
IB_MR_TYPE_SG_GAPS MR.

Actually, I think we should have the same logic in the NVMe PCI driver:
if the IOs can be delivered as PRPs then the driver will prepare SQE 
with PRP. Otherwise, driver will prepare SGL.
I think that doing the check in the driver for each IO is not so bad and 
devices will get benefit from it. Usually HW devices like to work with 
contiguous buffers. If the buffers can't be mapped with PRPs, then the 
HW will work a bit harder and use SGLs (it is better than doing a bounce 
buffer in the block layer).

I actually did a POC internally for NVMe/RDMA and created sg_gaps ib_mr 
and mem_reg ib_mr and checked the buffers mapping for each IO and got a 
big benefit if the buffers were discontig (used the sg_gaps mr). Also 
the contig buffers performance didn't degraded because of the check of 
the buffers mapping.

I created a fio flags that in purpose sends discontig IOs for my testing.

WDYT ?


> -- 
> 
>>
>> For nvme-tcp and nvme-fc I set the flags for now because I don't
>> understand the drivers fully, but I suspect the flags could be lifted.
> 
> tcp can absolutely omit virt boundaries.
> 
>> For nvme-loop the flag is never set as it doesn't have any requirements
>> on the I/O format.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>> ---
>>   drivers/nvme/host/apple.c |  6 +++++
>>   drivers/nvme/host/core.c  | 11 ++++++++-
>>   drivers/nvme/host/fc.c    |  3 +++
>>   drivers/nvme/host/nvme.h  |  4 +++
>>   drivers/nvme/host/pci.c   | 52 ++++++++++++++++++++++-----------------
>>   drivers/nvme/host/rdma.c  |  6 +++++
>>   drivers/nvme/host/tcp.c   |  3 +++
>>   7 files changed, 61 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
>> index 596bb11eeba5a9..a1afb54e3b4da8 100644
>> --- a/drivers/nvme/host/apple.c
>> +++ b/drivers/nvme/host/apple.c
>> @@ -1116,6 +1116,12 @@ static void apple_nvme_reset_work(struct 
>> work_struct *work)
>>           goto out;
>>       }
>> +    /*
>> +     * nvme-apple always uses PRPs and thus needs to set a virt 
>> boundary.
>> +     */
>> +    set_bit(NVME_CTRL_VIRT_BOUNDARY_IO, &anv->ctrl.flags);
>> +    set_bit(NVME_CTRL_VIRT_BOUNDARY_ADMIN, &anv->ctrl.flags);
>> +
> 
> Why two flags? Why can't the core just always set the blk virt boundary
> on the admin request queue?

I also think that a single flag is good enough.
> 
>>       ret = nvme_init_ctrl_finish(&anv->ctrl, false);
>>       if (ret)
>>           goto out
> 


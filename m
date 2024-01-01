Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED68C47073
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 10:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S68ZfKlyg7o9e7zDgoyzRD8OVveXBSMFQJZxVQ68mDU=; b=QE9XJSBwR085bDkMCqXfH6PrxF
	W81GlHCF8PZdmg8AWPB6VwSyXO7jPpPuvxlcR8xxS6CKOTw6K3RMTLM1RhKkn+YQvMR2V/plqn+Kg
	PfpfmFnSKae8LPf7nH5wlANof+MK99qYUaD0qi96WLLjl9/btr1X/JLPCj8fEPI7o8A3PI132wskp
	kwKccQgqwLR0T305QXXx/5pSyyUqm9844+5RTeAuFphIluq6TUMqvLzIjEhtdBAqT7+sNQ4jwn3q5
	pbY+2EBw6NxayhgKwsL/2BE/r65xZX2L5nx8U172JcMIZhaHGjLrNDM1xc3E/AYovWYbqjWgou6MM
	hWxvj9ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKFFW-005snU-16;
	Mon, 01 Jan 2024 10:10:22 +0000
Received: from mail-dm6nam12on20609.outbound.protection.outlook.com ([2a01:111:f400:fe59::609] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKFFT-005smQ-0P
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 10:10:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxC+rmwqSFi798o8ysW9DZAL5M1rVvDW4DCJaANoR70vCqExU4s+GsFb++25hTDJ6YO1MWScMoW6Cw2algpbYnXqtELyBaLrJJBA1FFrWDBozD2EqNZs9yHobzlts9RRhHh0ZegYj+NeG2yZD0x21ukoB303rMfDJsDLI33GgO1LkJ8qbxx8baU60baZoopvBBQds7p30IbU42DX89yxKTqrESJL50oUk+o9PACIn6MKs2ImjpL3YjLaZrmmHopTGdneteOpymY0VjT9QbOSRzIsYUI4R6LdV4XV6ejWKjU1gfEkQg3bj7WYDoiR+VMFnC8mwefxfnJ3On7utHndqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S68ZfKlyg7o9e7zDgoyzRD8OVveXBSMFQJZxVQ68mDU=;
 b=XIHP+C5F1nYk0PvdZ6hWtiyzD85yBcvqNANyqAb3pKlByPeMJ/UI9p4uB6E2VFUAYemIj9uBYPHy3hMV0ukdF6nJi/lHChJUzJ2dp1amAmQLbkIjgwb7Mtn60eaArIyih2djlqD74jrN7rsrb/3naHkajRlw/fezB/NdG064WhcTUI4c26b95yKSKxRiYP+eQKKvB28d5s1u4zgSra2a+hm7QBB3/dbo2MQC7yLvlsIlGMXknk1tZrJ5N/Hg5qZXwsFSwpAbUP5q2c+04+U/LEH7zr24YXMqIhgSTjNMEw5uJz1A4R+Z5+CBEfeKT96Heo5xekKJXtnGtv11b3ElSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S68ZfKlyg7o9e7zDgoyzRD8OVveXBSMFQJZxVQ68mDU=;
 b=SUhS0+hp00rI2nFh9APWlUVIZAn0vBzRvwXj94H5NZR7bTSVZCpDn5qLKFBjYopa7dJNspq1cGMWXNmkUVkxaYoRMUfC2gTwg0Xb7rBPUu6+DOxfIZh3x7MJyb571urH/wOZy9p+KCviyRt2sTaNkVc0SLJqqreHshIia4Bh+lzRwW9imkh/NvInOQdG5BgNSnXY1qrRpZgXYBIYjdpJRg3nR5wkNNia2fdDFfOSBUe5Umw+PC1N5ccVBGj3SPb+mJp0EqDWd6sKGMfmecFJyuaKxqIgvvwsYyTC+lSnoh924nmscQ6DudzXqw9Zhz16LsEm8fxF7Bfzr+C0evFIqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Mon, 1 Jan
 2024 10:10:09 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7135.023; Mon, 1 Jan 2024
 10:10:09 +0000
Message-ID: <bf5b30c3-9ec9-457b-93cf-143c9965e1e1@nvidia.com>
Date: Mon, 1 Jan 2024 12:10:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] nvmet: remove NVMET_QUEUE_SIZE definition
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-5-mgurtovoy@nvidia.com>
 <c1f4a478-384a-4715-a7d4-0ac2c822e26c@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <c1f4a478-384a-4715-a7d4-0ac2c822e26c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0334.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::15) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 2782c5e2-cb71-4382-7656-08dc0ab1d599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UpCxcGF2g1pNX+fGC6fABa0GgECHIp8OrISy0TqqH4Ruv7aqJJp+pcyxWLBYJ31Q5VdoyYqvy79hPE/TfzzfZ8f5Cw1Z2UNtqNL9wPpbmuY2pub4avAhut3VbMt2QKcPyshvnKZwRH4xqspiTCM1zK7HThYDYSjLtXRm5VBB8GXnj/8UzBydC6lPYIQ7qlv58yO/VXMK+kgiCL+dUVrMKMbsNWR0Q2GvkKHSgplTIGLmMQwypEkpY9N3J90CbFSKPNXW+OKcjN+qTjGTUd7rvSB0E1r4UM8i66m4UkMNCWLXi+8mKAu/+GdH+3NLYBZBGrU9XlBw06pWeLmlDquaLYubQQQBMU2yanIyUsSJkZPkiK648xMisotOsjKZHUacuQjyMhS4/7qecgR2N1BJtxeLKJcuePopZgwfP2k0aPNSmwxssJk40qVTI3YiqINwOd3JooPjtusoTxM5+2ps9VRZlepZNRfWC5MA/mJJFWa3sBlpiD0ZrYfQODOeQymnabUBu0jQW5xrn6KLW2jRT/1C0sI2IOHRFgXjFKhSzPaJtJdxTOl/VP6zR3QjcM6mAHg5VTX2DGwFlndCfEdT7BhyufpnaC6NLxFmPZv/+ePOLR/vcsrL1ugXU/vRgSkZJIHtoQv6OTIrooJy2aNgdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(478600001)(6512007)(6666004)(4744005)(38100700002)(5660300002)(2906002)(6486002)(6506007)(41300700001)(53546011)(2616005)(26005)(107886003)(316002)(4326008)(86362001)(66476007)(36756003)(31696002)(66556008)(66946007)(8936002)(8676002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTVmTkNxVm5NNjd4TndSTVNKQmYvUUozNUhGWHNuVERoelhZRFVhb29mY3hl?=
 =?utf-8?B?T1JWWmtaL2ZCMUN6bHYwYmxrdnc1cGgvRnJNMERLRTU2Qi9teVc4SXprcTBa?=
 =?utf-8?B?ZVVpZzVhWjFZQVVtZGNYNUZOUmVHSDhiajlqSTdQbjJXYlQ3VGIrTHJBZVVZ?=
 =?utf-8?B?K0o4YW5qSmEyU2xHQlFiUnRZd3czcFR2RkkwUmdnQm1MYUdiWGxEVVRGeFow?=
 =?utf-8?B?RDJpQktOb3RNTmNmUTZJeWwzdGwyMGNCc1J1dVZHTEpWaXNBNnBhcld4ZDl2?=
 =?utf-8?B?MmlQeGdLUzlqdDI1cjhYeWNmb0JiNWFJTEljTitVSFh4TjlFRjJmdlB3eEEx?=
 =?utf-8?B?UisxeXRsblRnL3N5ODVIMzRlTDlFakNuek1FL3Ard2dxOFZnMnROVE11OVZp?=
 =?utf-8?B?SWhNV2VjV0pJT0pQYUVIWXZybGRnWmR6KzJNWWFpUXFVa09lMHNwV1dxNlJO?=
 =?utf-8?B?Q1dNRmZXZ2l0eWQ1RWl3bTVYYkw2cjJzUiszbG1yMjJpSlRQYzhFMGtYQmU3?=
 =?utf-8?B?WFBvVjJxS2pPcEsyM2VJaVh6OTU5d2xFbFhTbm9xZ0N1SDFGSm9WbENkZ0lR?=
 =?utf-8?B?dFB4TVZKeHdBV0lkT0lYUzQ5aldTWkROL3Jub3RNczQySFA1dElhenlJUkdP?=
 =?utf-8?B?SDBjcEdvM3RQRzJ5YlNTc0lCL0Roc014WTRDQmt4L3N4Y1lzR3IzNkN4bmp2?=
 =?utf-8?B?bEsza1lDL2RVbi84Lzd4N2dnVUZhaTR4aHZibDlzeGN5dnA4dXlJbldSMVRJ?=
 =?utf-8?B?WGREOEozYVA4cFpUckFsNjMwaGtJYVQxV3I2TW9ZOEwwU1hubmdDcWlJRmVV?=
 =?utf-8?B?SDZFaitKOFFMRzF4ZHhrN2tLSUtiZHA5c0p2ZUl0a1g4bHc2RGlCYW1OVCtC?=
 =?utf-8?B?TkRnRndRYmR2eTFQaEh3RksycGt2cUJoVHhVMzljYlJyeWR3TWtRbmk2TVUr?=
 =?utf-8?B?MTNCelV2SG9pWlJqMlVlUlRiNE93YzJwY3F2SjR4Z082aFpFT2t6VTlWQVFj?=
 =?utf-8?B?Wll4VjJSbmE4UklLR3N6ejdYZmFKRTJMYTMvSlBVeTRNeDlncnlGV3pLT2Vt?=
 =?utf-8?B?NnRJYzV6YmlNSkR3SEI4RGZ3bUFZcmRUcHJlSkk5KzNoRWNPRVJrY29RenlK?=
 =?utf-8?B?RjhFb2dYNGNxZlQyK0tPcWNqcWtpYk1rbHl0WnV6Vkg3SVhvMkQ4NUJxSjhi?=
 =?utf-8?B?MHJhMmVNSFU0ejJ4dldDSTJGbS9TdmhuUWwvUlhEaGZMNjFvQW94N1dBcm95?=
 =?utf-8?B?OURoeDJDejU1b29nZzEveEVmOVpJS2pCRUVVdUdvZzQ5SFZEMm5uREdmSmE4?=
 =?utf-8?B?ckp1dStQTEZHcjlDVzZSOHMxM0ZTMW9kVFo1TUNIYVRDTGJCSEx5a1U4SU9V?=
 =?utf-8?B?dUFKLzM2emQ2OThOcXorMzFFaVh4NU5lalNVN0JGcDZqOGZ0aWxKTWx0SFVv?=
 =?utf-8?B?WnlMNkw1TnhuNVBMMXl3Tko3aE5Qa2x4K2R3WmIyN0xLQmpnOFc3NnFQdnJD?=
 =?utf-8?B?Y3RIbHdQRGc5ZmlvVmNKbUhJR0lCM0pJbDNsQmJzeU02L3BUSWVUWkIrNUJy?=
 =?utf-8?B?aGs4dEwwRkFoQzB1ZG9HeW5wS2M5cXJyWFY2S0E1OEhvQ2xQV3hJSUhBbVdk?=
 =?utf-8?B?eFphWEJFSXZ0d1g1cUUzYm8zUzJJMEJHMDZIZWMxa1lQUk10RWZMTk5FNmpi?=
 =?utf-8?B?T1pYOGI3VTlsZWNEaDFSTk9Bc1c0NmNISEoyOHltZnJWWHZvUnJTcHdPb1BF?=
 =?utf-8?B?eU9UMktMRFdRSjlySmt6RUpwZlArUlNIdGMwWFBMRmt3dCtRK25ZNU8xelhn?=
 =?utf-8?B?dkJPc2cxYWh2bk5UUndIeXlLWlRUMkQwVTVuRFBrMW8wQnR1VWdoVzNENkgr?=
 =?utf-8?B?WXN4a3lrSk9OeUduNmtwNjBQNVBDczdhWllhbnNlc1hqMGNRcWZBMmlVbHJJ?=
 =?utf-8?B?N3VvY0F5eEJacFpGNm4rTnRoRmJYa016cGw1V0RhWWhzbHNDZklnUTJLM3Y0?=
 =?utf-8?B?MDVtU0NDMERDNU4zenBNNENYYlhFQVVhRWNQNmVtZlZ6SWtHUk1jZktaOTRj?=
 =?utf-8?B?cnhkTk1hNGRLZFp3Qk5reWNkdWtJUkM3TzZScGdtOGVaWldyQzFoZDV0V1ZF?=
 =?utf-8?Q?YnUIzXCVZlQzNA+cv4khgI2t7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2782c5e2-cb71-4382-7656-08dc0ab1d599
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2024 10:10:09.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D3bSso0jOaUsimbqM507JlYv+A3c6scQ+kn1U9mjlkz3QfGHAI1rKhzVn7zh3+1PB2FeAQVBsc7Abxb32laLoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_021019_177559_204EFFCE 
X-CRM114-Status: UNSURE (   7.70  )
X-CRM114-Notice: Please train this message.
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



On 01/01/2024 11:28, Sagi Grimberg wrote:
> 
>> Use the common NVMF_MAX_QUEUE_SIZE definition instead.
> 
> Why?

In the next commits we introduce new interface to configure 
max_queue_size of a port. We need MIN/MAX/DEFAULT definitions for this 
configuration.
I choose using existing definitions exist today in the hosts drivers.
If needed, I can duplicate those to the target but I think there is no 
good reason to separate these definitions.


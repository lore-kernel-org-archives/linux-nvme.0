Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A4EC46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 13:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cxA10X+oKb7D8AowD8Mhq62cSGZDKmD/YC4JA7ZN3X4=; b=Zw5aim3Y9un7HiPnkOtz2iwV6g
	O946967YKP6uYQ7aKBnMSFzi9sdwmgj6obIkXPjfNm0rdlq/1yiwflCPuNwrMqaNnQL3KG/CnGcnN
	C7Z7bKxM5PYf3Nn/ZVx0FdifMho4KC4sHVy0ohzyrqA0tcypFOgrHeOFGPvD0kasJF4jHRNUvGeQz
	Unnu5utxao+i0N5psTB2qnVVj4VxgmXpLZ3BGhumKXc7azScwqz5De1CKOfkgiz5h4asx6QOOX+pU
	yP70pnkk9Tyh9H/7TGdlA2CZ/y6Ocobo2IrFiX1W5Nsp7EGSzbLaxQtVE9lIvGdCfzsbcFFaIg/hZ
	9up3wlrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rScwB-003OoF-0s;
	Wed, 24 Jan 2024 13:05:03 +0000
Received: from mail-mw2nam10on20600.outbound.protection.outlook.com ([2a01:111:f403:2412::600] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rScw8-003On7-1K
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 13:05:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcZgkZKrZmlSFYurxfLmw02R5mq/XeWloNQZQTHOyn5ZY3loa79aEAUTnVqHzD9VSg9EF2aJ6I62sa/zGpOPRMY2QWXhQBcSVRELuOjCt1hf/NwsY5A1+flSgIuYz7cJ++BgKFINw0iqAatLUhLYHOGvPEUqJHxU3Sx9wEqzFwnoWo8wdZD6I6xrKHGV8NCY6L4d4sUlvyUkI0ETJLmfbeptIxLp3h1B9jEYjTqi34U1j6TEh3B3z5AClK9LiaD82mcle8FACVi1sTpCN+ZzDxGcnjjylhOv7eE7QTjjLj3eE4ZQeG9MXi4uR5xPsbIn3aZIZXfJmPPV8REFLUjtQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxA10X+oKb7D8AowD8Mhq62cSGZDKmD/YC4JA7ZN3X4=;
 b=hmvZN8y7Aizl9oQEbP5lkZ+dYL4Of/juntNnrxDCNqMmWQfhme7ZJnKXIABzvbNlxemrVsqNZOqfo1e4M4K5rdoe/B2Jze16Czk9nBRFmgfAN+HltGAiw/Qc+O7LKQPIxPDs2TIC8EJNpfVwdwJ356IjIFGUG12cgwXToUB6lWePLywDOZcm8c1Blu3xu9PobKf02zynepml6mACcl8UL1I/GofEiY3woDRq6Wj3n4ersQPEV38WhK5+4kSq3dygjAfkL+W3jVklGRaylPkoDLmG1J/ZJ46mSyeOeKER/Klc/Kj55bli5BU35pG7msf6S+/bSZc/oMC1hQqF/I6TMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cxA10X+oKb7D8AowD8Mhq62cSGZDKmD/YC4JA7ZN3X4=;
 b=OTOuYJjHT7iQo5BEhLm6pHnjG0Y9GRFO6C/iAJyLT5VgDLoH4MhjtNNrN/QWqGE81Uxym7GS7+/9719b8K7tc8B5Y6RBdb158em15jFKc9l8PEaomIshrJSxvt7/NqAOuIKl2os2t0iGxrReJ8gh8oDZYKDgYDLWXAv+LtLoYaqHi3N1EbP86HCmAAvFq6oW1p7AcI21y1d64VQMR7AP6L7tsjRfgSv8tukVmnMcGOde0PClcHINDkDHIZHhoo1KwBa4DgEqryCVsEWKk1hxDS4ho/w58xZKWIpEjeakAVrSldSErs2PHJRtm5M0Nw/+Cf0ASMr6z8qRUYKP9yJ70Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SJ2PR12MB8943.namprd12.prod.outlook.com (2603:10b6:a03:547::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 13:04:56 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3%2]) with mapi id 15.20.7228.023; Wed, 24 Jan 2024
 13:04:55 +0000
Message-ID: <60f3e0d6-1fce-4f88-84f1-154a5cde4f7f@nvidia.com>
Date: Wed, 24 Jan 2024 15:04:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: oren@nvidia.com, israelr@nvidia.com, dwagner@suse.de, oevron@nvidia.com
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-6-mgurtovoy@nvidia.com>
 <d964c7a4-9754-4f31-977e-68d5c08c6e6f@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <d964c7a4-9754-4f31-977e-68d5c08c6e6f@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0598.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::22) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SJ2PR12MB8943:EE_
X-MS-Office365-Filtering-Correlation-Id: d29ae404-9224-439b-e5f2-08dc1cdd0fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O9s29uh/5JZ5Ef1ZvDbyAcZ7uGbAzIQ2VjfRbuhUB8i3kVTWtNntVe4LwQftZumfxlVsoKI/j+B6mAfjXLZocl5C5gv2UezTEihcB8ARjTva/DY9NxmlHuMtt+GKm3t7S1dXzU82Ab9nL5VV1/tgCxeYgoN+WDzJLUwq+FP779JWWgR3EaYzeHACrxiPYXHUcGciFRIHMoyPyYVSY/XSAhPFEwEvjhheOguo3aAEK6tW+Nyi0/28as4z39G8YOj45CEiXTyHvFWBYgibSSJKGzHHrtnZBThBHRbZYKs8mscnTOJAVACYhAQ6R8ETagEPNo1L3/Wq5Hbvik+k68VNv4EdKeMi98TyCS8wJu1wkyttex5f4GcdQ8l3B42gZ+jxPvNJ49r0UxNaKhajnluMU/3XmnncamHxMof/1UMOPHCnhJEvsgRFTFIQ6ePyeHMU0esRuaBEzNevRhtD4Ul/Khdr4jklcXao8AaAQwJ2021yCSN7WlReQ1SgHAI21WtUrqx96NPnJgaw0+jS2g9tD7FB/yk890RVIogr4D3KIfifYLZDRHCuQ4lH3tk+PzQTbs1/APUChzpGPeBej4p5cMAM1e36nmZgyBpCUmww8JNZh2jioiFfYph/OW1BAgvZHFu7PLeYgVeR/ywXKz3/sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6512007)(66476007)(66556008)(31686004)(66946007)(316002)(107886003)(2616005)(5660300002)(26005)(53546011)(478600001)(6506007)(6486002)(6666004)(83380400001)(36756003)(2906002)(4744005)(41300700001)(31696002)(86362001)(38100700002)(8936002)(8676002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WG5TMU9tVUY4L25xaTl0VTdGOXVNMU9oSDFIanp1ckNTRE8rWng1aEdTQWQ1?=
 =?utf-8?B?eVFHaGJkSUJsTGlhcUVIR1RVcW5zc3c4WjVGc1dKZDdFM3hUSFpBbTBvNjJY?=
 =?utf-8?B?YjJ0SXkwYVhqYnBqWHpSL05qKzFhS0VCRGJZLy9wMUhrWStjZFZlRW9LT2V5?=
 =?utf-8?B?Y3pvUDQrWVA3REUxZ1hHaGlhYk5FeWFHK0NJREM2NlY2MnZwajZPKzNnSEw2?=
 =?utf-8?B?SC9XZS9RQUQrMWtWa3RsbTRwbjZudUhTSFZzZjFXZVBSd2pSMzQzWnY3Yzcz?=
 =?utf-8?B?WTRtTS9NWHd5aHZCQTEvREtXbW9xL3FQckJhcG1NUkZHVkpBY01tYlg5bTg5?=
 =?utf-8?B?c1NYT1ZIQW1FbDRkRVlNcVJwdEhkSzFrbVVnYitCV3pNN21nNHgrcjNsWHpL?=
 =?utf-8?B?cWN1eFQvS3NWalBjZFFBemV1TTFUQVlhWU1FVWtRMlFDaFVtYVkrc09lZG1T?=
 =?utf-8?B?SE9PRUJxNnA2ZVgrRmRGaEFGenk2YUJGdE5qY0dydTZrV0kvQVZtRkY4TFpy?=
 =?utf-8?B?TmRNNEVaSml2d3ZWanA5b21jMmFUdWV6L2dDdGVJYzFPaHNwRHczeVFDKy9r?=
 =?utf-8?B?NldtbTFTeHpSaGg0d2pZWFFzNVJqai9CaUNsR2pMd3NQQ2lRTUlyRGR4M21J?=
 =?utf-8?B?eHQ1SmdDUUdhOHJ2MTJrZTJrWE52blF5SzVWQkp1YWhERjV5VzhFYnRpajFB?=
 =?utf-8?B?bVliM1BYd1U5VkdMMllCelFFcU5WcVZaOXdaLy8yK1VZSC9zOXhpTlUzazc2?=
 =?utf-8?B?enR5OWRZNmtwUjZEUWorRmJmTmRMdVF6M0docDhvM25ManZLeGE5QTZrMG9q?=
 =?utf-8?B?RGkydjRiV0pHUEZwT3NKRUcxTVk0a0tpeXRTRFdDRmIyZDlDUk13Q0FITC9r?=
 =?utf-8?B?bUd3SVMrdDc5cFJ6TjJMTEZ6Y2NxY21hRmFTb0ptWEZ4YllaL05NUzB3d2M4?=
 =?utf-8?B?YVBvMnNnZFplZnFkUm4xUGVOc1ZxbTYvZlI1aXA4ZUUrSHFSMzJCd3FETmZh?=
 =?utf-8?B?WUlqbG9qdDB4MDl5NG9rTmtBR1ljVHRydjFiVVNuYWJ0bHQyMUVvUk1JQ1JE?=
 =?utf-8?B?U3BWSjhRNGh3S1ByYTgzM05kZzFPTGtsRlFXcXpVQUxPSXNLRE5UbFVmSEFT?=
 =?utf-8?B?WjZINFhReTlucVFFdVMrTlRITk5HNDJGRnZXdXg5K3FEOGp3UXpsalZac2t5?=
 =?utf-8?B?OTNPdUlPdlpqSWFDVi93NmlwbTVJcU40cGNTSEI3RVRCRnNKeHBXTlpUenVu?=
 =?utf-8?B?Q1NEbXV6Z2tSeHJ5U1BLbDlTLy84cW1LZkluWk1vZVZ6TDBES2pOZzRJaU5w?=
 =?utf-8?B?RzA5Q050Wk5naW1NN3MzeTlNT0xsamdIeEFIcUNnMVJwdnZlSVhpLzdPTmlo?=
 =?utf-8?B?RldydVBycnN4M1paeDEzWlVVUVJQditDVklOZXNHbHRiUzVsYWQ4SjByYjdH?=
 =?utf-8?B?R3VSMzhieFB0S3BETzlvUGY5a3VHcjFBQ0hIYUFaaXZGaUs4MVJIdjM0TWhX?=
 =?utf-8?B?NUh5d3NFVG16amJaZHdNNmFDOTFvemVTNDFwTGorcXJ2Mmo4WDlhQzNiOHZN?=
 =?utf-8?B?NEswM056Ykk0Mk1xazFLdnIwakY2L09aQmVoQXB4WFh2VjRlTk5uY25jZkpi?=
 =?utf-8?B?WkU0VXhERkJXZkFXU2NKVVhPc1FPb1JsY01WdWFUM1QzNFE4aFJ0RXNGWnE3?=
 =?utf-8?B?WjJPdUZnSzBnS1ovVkg4S1dsN25zK2tHY1RpNGxncStFOTFYWkR4VXJvZWtV?=
 =?utf-8?B?VENJU3hOai95ajdRQXJjMzUxRXYraE56c0JOYnZ4TkwzQjNZZ1Y5SkFJYU1P?=
 =?utf-8?B?WUszWFZHcHpLbXJwTDhpZFAyejdGbmZDQTlST3hEZEZNWVdTeEJJdFZLVDFu?=
 =?utf-8?B?L2FieFNOSTRLSVA0bFozTEdFb01ReWxRajFnVVBJdEdaZ1NEZXNxREt5ajNL?=
 =?utf-8?B?MTVmOHcyZGluMi9DOU9kU0hLdWtEZkEzTWVmZGdKb1FNc0xjbXBmQTVLOUxx?=
 =?utf-8?B?OHdiM2JXeG9FWWFGNyt1TnRWRDdDQmZ4elo5Q25VZk5QSmNhNndBeXFWL2VF?=
 =?utf-8?B?cFliTWZsOXhGOWY3Y3Y4VkxFK2dST3hXWkZoY1VxdmZnZDBmZS9VM3J1eWZI?=
 =?utf-8?B?UjB2dHI3cVF0Tzc5RHBjNGx2NVRaUUN3K1h5OTFQT3R2SjVqYVFCT1hPNzlu?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d29ae404-9224-439b-e5f2-08dc1cdd0fba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 13:04:55.9460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmOX3DpmK7Q68LUmr375QJ1hicIjC6XKC0XXxVCAx1Vvx2n+3LPeI0BcQnu7DFLfoEV0OfXQjLokCf5aenl5xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8943
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_050500_448680_FE7D15AD 
X-CRM114-Status: UNSURE (   8.10  )
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



On 24/01/2024 14:58, Sagi Grimberg wrote:
> 
>> @@ -4537,9 +4536,10 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
>>           nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
>>       if (ctrl->queue_count > 1) {
>> -        nvme_queue_scan(ctrl);
>> +        nvme_queue_scan_sync(ctrl);
>>           nvme_unquiesce_io_queues(ctrl);
>>           nvme_mpath_update(ctrl);
>> +        nvme_kick_requeue_lists(ctrl);
>>       }
> 
> I really don't think its a good idea to block ctrl start
> like that.

like how ? scan_sync ?


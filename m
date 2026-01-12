Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D168D25030
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Jan 2026 04:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=93tCeg/Ewctt1BhGUf79NrQA/3m9cXqA57a8/yjdzCs=; b=yXzET/3Yo3ewHJ2aUfrrmZGiHD
	MVdoHNSt6f5vg2PkC4meHfFIAFCdU6Dof3JSEjrJMxqB0D/pMRZtrP+qVJ6/86g4KtoTLbKnDT1ga
	xXX+umQx/w6/3mZXP23u+gontiYWDgDLk3bQVLzUPHTRxD15+/MavZTIz25Vo/HM2QQIdBkfGXhK1
	zRS2hw9MY/KGLYj8iyYMqNFgxby7kT4TQJQbcgDG39hoxRtfjvpd2mh6yuGeAsRBgXm0xb7j/+mih
	GdZmszseeoyIRs10UQ6TbtMwXF8wNTp24Apqaf5pFkfvCKOcyuZe85fIWZfOADaQUHWF1dQu7R4CR
	aueijw+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vf9jP-00000004kyK-0jpU;
	Mon, 12 Jan 2026 04:40:43 +0000
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vf9jJ-00000004kxr-1xun
	for linux-nvme@lists.infradead.org;
	Mon, 12 Jan 2026 04:40:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSUHAtLEt9vSpfQ2WDrHD/jeFFHTl696tNuvfc8SYJHHKlOjIey1AN/UmslDUpLBfkagEVubeZqUmS46WITrV5I02gIAp6wv8h1agAxxhDpH+Cx69N8sb83YUg3JuVD7SZ8ZxU2lhbD8yWc9J5QY469CwmVwO3lpw+JDNg56Muf6KbpkOKj3owG5BhMvKZGpgCFx2dcbKnx6sP0pbhGfgmZAJbPkLa0CIOVV8u7GIcrxPDz0f/JUnj0+YbF3wjhwbbBREXHF8RsPznYuBCV+0+kLUh26O38UxW3jktcZXqZTGPAkZ7MR1pt/+3+jwKPPFOd0grYdDAgldzQLpkZzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93tCeg/Ewctt1BhGUf79NrQA/3m9cXqA57a8/yjdzCs=;
 b=FnWm0EvR4YThQ36d0MTC8wgNVcT+D72sFjwSeHKhglwxOP81PBbOd6Lrp52CQ0LkazwqAwAPQVOqFnU5gdi3N9J8/1jeO6/xkkamtWdXokjU+SPiMbFph2w2wmheewYrdt5KoJ5EHHOPkT3L0YnUS0bD0MB7W5a150GjtMg2Ei9N83g1YLXdx3mIavxdYtrxUrcL5/xCbl+VzrgY08wcnsu8YpkF/PqSdzDcHBz6NptPk/g0Y7OzljcwW3qbydGhM1P6+9RluKsfPSmWLPJrI7gNqmA4ooUtKlquEJfE3rol5gZyblt+uGnHa9+NC4Ndh0Nd1vOp3QK8Q8ZTevxqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93tCeg/Ewctt1BhGUf79NrQA/3m9cXqA57a8/yjdzCs=;
 b=HdEnI+ZZ66SQmJ/bEnOyNxquqii+nVmQe+DedW/6mnA9oMD3T3rOq1hxwJ/2L3DKRG50m/sTO6XqLxO/iXD0qNW3AoyOjiHNntG7j+xalRVa4YlK1y2d7DJbjRjYbFnMTDUNV8pcJkOxY9K/bb/mrii+pCByiZH2L2wY9noJiGDzhIFlmE3RaNiwLg3te2NWnJA/WugFLptyK3PCOJm/SvE7NKq/iLSOx9a4YA11B6cjYyPX3Dqf9+Uj5rwiMtgiYN3qBXHhjF479sejsNlIZucOH0zuot4I7fW6Y+BHDqcEU5g4fVpljGBGdHZBjPXijTcKqAgt+N4iu6jMa7pIjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 04:40:32 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::2920:e6d9:4461:e2b4%5]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 04:40:32 +0000
Message-ID: <d7050bd5-b958-4975-87e2-5f47d5eba782@nvidia.com>
Date: Mon, 12 Jan 2026 15:40:25 +1100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/P2PDMA: Reset page reference count when page mapping
 fails
To: Alistair Popple <apopple@nvidia.com>, helgaas@kernel.org
Cc: houtao@huaweicloud.com, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 linux-nvme@lists.infradead.org, bhelgaas@google.com, logang@deltatee.com,
 leonro@nvidia.com, gregkh@linuxfoundation.org, tj@kernel.org,
 rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org,
 david@kernel.org, lorenzo.stoakes@oracle.com, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, houtao1@huawei.com
References: <20260112005440.998543-1-apopple@nvidia.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20260112005440.998543-1-apopple@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY1P220CA0012.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::8) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 9875dcdf-e761-483f-e751-08de5194b852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGgwMVJXNUVCSXRzcUM5eThmRnNmMXdaR3F2VU1JZHhzZnFNTXB5Z3dwTFE1?=
 =?utf-8?B?MlBhN3FQTDROOUhjRFA5MlRhMVhMdVc3Q1QzWFFjdGFwZ0oyYTk2SXpFVVda?=
 =?utf-8?B?ZG9meEZXWGVWVU9vK09NbWI5aVRpVkVrRHE2N0ZJMnVGZkxxbDlCRlJVa29H?=
 =?utf-8?B?bWJUTnIvN2lzQ2dkRWJqVUNESFhtcVpPaDhVeFpKZjlSblc2SDlONE9tZGN6?=
 =?utf-8?B?NzVjcUpIVUNGby9kYUpMc1hDL1A3WjN0dGNVdVYzRTNhM1crcUlGUU45UDlq?=
 =?utf-8?B?TDVCeU12NGl1S3IwQ2t6SFVNeTdRNlRua1ZGV0hsUDRRRmhkVWRVNU1QYkZB?=
 =?utf-8?B?Nk9nTFNyR3lOVUt3ZW1lREVac2ZEQmlXei96OUZWREpza01uL0creGRCbXNO?=
 =?utf-8?B?NTMyNVhEbW9rK3lWYkZKRG9wdTdIc2U4cDRYT3NJQ2pOUmcrclZOTEJSVTMr?=
 =?utf-8?B?UXAzRVk1VXBoSkh3VUxUcC9wcStOYk9xcGRCZWJGbkc3S3NWSlFHU2lOclVU?=
 =?utf-8?B?ZzdwSFVZdGtXaWxmQ3gzU0VrVmk5Ym5QQWFrMTEyU0RCRVRlMVhnaTNkckxT?=
 =?utf-8?B?a0RvVE1YOTNtU1NFUUpHaTErNTJtOWNnMWpVdXU5cldmU1JkenNaaHd4a01i?=
 =?utf-8?B?a0YrUnMxTlMvQURLa0VKNmZpNDZuVldBSllucy84c1RqVjFqL01Mb1RlRGpJ?=
 =?utf-8?B?MHFNWnFxWWFTcWVTMEc1N2lyL0ZpMjNkQXFPNXFPS2JXZ0tROSthZnJxVjN4?=
 =?utf-8?B?TkVxTjVXVVZHYWRJaEJlbXk5bmNhTUwycmpmaHhsa1l1eFFicHgyWHRtQ2lP?=
 =?utf-8?B?SXJWd2NCRkRCRlFVb2lyWm9jYUtDQVgrQmQ5em9RbkRZWnRjOC9sUWpPbHQ5?=
 =?utf-8?B?d2F0V3V5VmsyY1VjVDJVdWVtb1BYVkQxbjZjZVJZQ0RJVFpxL1VLTy9EZDRM?=
 =?utf-8?B?S29QT2RGUWFyQ3NlY3o1TU0wNnEva0ZSaS9GcnFnc085YzliaUpxS3ltR2hS?=
 =?utf-8?B?QXptOXFhS093MmVScGlpZkQydmZXd2ZUblRpZ3lKU3VCZkRROUVtbWxZNnc4?=
 =?utf-8?B?ei9pN2JEUCttQkh0Q3J6WjRZaHdLWG1ySzd1RnJYSXV6cG4zTGFQd2JRVXZF?=
 =?utf-8?B?VkpwK3F4UTZaR0doUzZIRGVTL2tudElYRXg3Ky9oc0xWbEpwaTd3U25NQzZa?=
 =?utf-8?B?WFNJTS9pZnZJZVE2SFY2V0hBUkhSaUt5aUU3R2swOU5EY3MrYVUrMGtkWFZO?=
 =?utf-8?B?SlhoZjAwTXNTMGRQNDJTOVkzVnNqcUtFWUhNNUNqNTY4b3JoS0JqbUJCZC9m?=
 =?utf-8?B?T0Zyd2FRVm54N3RWRjdmNmNObnIxZzdWOXFFbSsvWldQeTgrVURuV0JCdnJR?=
 =?utf-8?B?Q0JkRTZRbDBjcTkyWHpTSW91TnpFSUZrYStSRGp2a1RMTy9KU2djLzY3K1py?=
 =?utf-8?B?SGh1d3JqTGF1eGx1N1NlK3hoSzI2Q0RFdHNNNDVtYjJkSXlqTU5yam1kOWVr?=
 =?utf-8?B?cVo2RndjUmM1cVBMck83WDFESktlZFhXcVBHTU9YQ2FEWUhtSVBJRFZ6NlBv?=
 =?utf-8?B?Z3h1TnBBUVFGbElpRDAreWZYMDZyZkNOMUpOV1BMZDEwWjhVcWJidFJnSUV2?=
 =?utf-8?B?OWVJOXhCaW5FVHdCV3BzZE9ZWTJhU0hseHdUeEhRdG10MEl2aXV3MUYxWWdB?=
 =?utf-8?B?WnZ2Tkh6V0N4cXdQMDJiNzZVNkdBRS9PTDdmWlVYTFNjVThLa2l3eWpsNmx5?=
 =?utf-8?B?MC9MNVNaR2RCS0tpamRnNUhSdERNNTJhU1FMb210K1UxRlBLTnZyOWw0am9u?=
 =?utf-8?B?bVBuWURSOHFUaG8yc0RhUEhlanc4TnFYaUhEV0hxVlUrYlZGbmlmakZsTU4z?=
 =?utf-8?B?NjR5Qzg0Ti9pVnc5d3AycE9sSnZoSVY3cjZpM1d2K3dpTU1hbEV4QVBwd2NR?=
 =?utf-8?Q?/7dp5iRWGtOiMxOa2zWZanyyyQ/dOx54?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mmt4MHJVOG82a3l1ZURTTURabEU2eExySWsyQ0dTSlQwK3pPV0t3RmZKMXc3?=
 =?utf-8?B?TEpuOEFlV3owVnUwOFNQaDJxR0YwbmNUd25OaVNkK0orUTVIQzhGUUxqLzRH?=
 =?utf-8?B?eUNlc25nNG9WVUJlcDVTWmFNeHc2SGJqekhYZ2hBNXY2UmFLRHQweEE2bzhR?=
 =?utf-8?B?NWhLR2dyRkF6TFpKMVJvZllnU0R2QkhwTGh2U0VKeFhmeEpITXM3T1lKTmNo?=
 =?utf-8?B?Vkt3NEhTQUQyWDAwanczM1RaQXR2a2dicUlpT2phQ3dFbFB1dzBuanNJSFpm?=
 =?utf-8?B?R2ozb3htUkRPVnlCTFdOQWdmMklOV0NDamhNVVdqUTkxcjh5QTVWbEpEb3ZM?=
 =?utf-8?B?cnVNa0U0eDFEdmVsUFA0bDZJUlpLejNMNCt3K3ZCVlNRNUMrc09RYVRPSWpv?=
 =?utf-8?B?ZGt6OXVxNWN4S3htVEl2MFpvN2ZNUUFRTzBFMFpTVkxZcG9jRUdSREJDTEN0?=
 =?utf-8?B?RjBRNmNWV1VYS0o4QnRBcDUyZHZGTTFZb2p4cDBTRmZQUlc3YVFqRmRsY29t?=
 =?utf-8?B?cWpKNlR0aUJuR2Vtd1V0OVZ4Q1RaQlNKaytBYURwTFVyRXZNU2ladXpjVkYr?=
 =?utf-8?B?TTIzNlA0MmU5aFc0WXYyUjNIMmhqRnUxYkdpM25JYzNsOXVWK0dScG9qeHp1?=
 =?utf-8?B?WXVOaldVWUNYV1Z0WWkwTFRoVmk5M3RRVVNXTk0vOCtEZEdwRmtDMDlyUU5t?=
 =?utf-8?B?SE9YaUY5K3JpT2hqQ1RCV0pzWjdSUGlRSU8zY1FaNzltRklzRTV1SUZQdzJm?=
 =?utf-8?B?dGpTb2M4TkVNWDBsSHRTTzNSdFRsbnVYNTdrd05zeGhYNmhJRlc2NmNCSFd6?=
 =?utf-8?B?MFRSME56NUorL0g5VFJmOVdWeGhxT3BSQ2FKOGRTb3FmRG1Ra25vWjBCdFlM?=
 =?utf-8?B?bCtpTGlpRDFsTXErWnpUeExvb1Q1ekk0eUVSbHZBcThGd2c2VFFZM1l5SXky?=
 =?utf-8?B?ODgzM21lV0UyV0dpeHRmYmJtRUtNRHFFTGNpY2J6NllNWVlYZU9tVml4dGVH?=
 =?utf-8?B?eVArenQwaFZnNDIrZlhmcjlnUWpqTEZ2ci8xcnliZ1dKdmtSa1llZjZHNXE5?=
 =?utf-8?B?OENTaFNpMHVrYTI4TnJyYi8rRUMvcWVVL2FvNmlPMFlMRHYvQWQwQXFPZXdu?=
 =?utf-8?B?cER3OVNrREl2SU9qcll4NENTYStJNHNNQzJFUWt2Rjl6L1UveTNHNUVKRFRp?=
 =?utf-8?B?OTNWbUF6RmZCSEw2TUZaczZjZ2srNG5DVHBvYlRoL3IxMWtwN3p2WWRKc0Vy?=
 =?utf-8?B?cVlEUWNFd1UrRExZaWVZZWFLZTRhV0VXR1kyY2JOWkN6aDhmN0QwQlNKVFd6?=
 =?utf-8?B?MTVoWEVQRnYrSVhxY2lpaFJlQ1hnQzkvWjBrZzQyclZmcnhtekhHTUxqb1NM?=
 =?utf-8?B?QU5yTGpIeHlOWmVESDNNWkEwMCtaR1lXSDR1VHRqdG9yWUx1OVR6b1VpWW5U?=
 =?utf-8?B?OU9iTUswcGUvOTVxaGF6cDJYMFFqL2p1M2tqekVmOEhSWkxnWGZ5Wm4rekNz?=
 =?utf-8?B?cGpyVVhCbUh2TVZnYlUzNmpPUFloL2VyTFhtZ1FiZkcyd3poTXBzVHZJa3dH?=
 =?utf-8?B?U2puYnA0TjJUMTdldUN0YXhOTVcxOVNrNlJXalNiaXhMUE0wa3pVM3cybXVt?=
 =?utf-8?B?TFc2ZTlDcmdSaEpPTlIrZVBELy9HZ08wRG5Ua2ZsVkVzczVteWdrbzEvT2dn?=
 =?utf-8?B?RURkSWNkZHV0YzZLbzh1bW5Nb2tRWWVNbU9JcmxiNmxYNUIyRytXNGFTV2RK?=
 =?utf-8?B?dnJRWUJOU1o4MFF4K2pwRzNpYkg3TndpaTdYWWJQV01lYy9yOFhIK3pITVM2?=
 =?utf-8?B?S3FLYmFOT1p5VmtDVUJySUFtUkhLUzlFQkVzOTV5cERiN2FydFZlSUFXQWk2?=
 =?utf-8?B?SzBIc29qTW1OZnBHaVpCSGMwc2Nsbjh3dkFoOVp2bzdKUlUwOGVhdDFOQ3ov?=
 =?utf-8?B?Y21HOU1ORFU2ckZTUmVwNzhHQktnUm9ST2dBeGZLbFN1bDRxOFN4TFRDNkdx?=
 =?utf-8?B?RnFZNFpKRkNSaVZzc3RRNDg2QmhpVzVjenlDOERJam84bk1XNFM3MVJPT3pj?=
 =?utf-8?B?YkxEcndIQzl2MGFBUlZlc1ZvaWR5S0taUEJWTlBzWHNrOEZ1OGZmN0hzUUY4?=
 =?utf-8?B?UHM1SEdZaDE1NzltMk1EZjd2eThld2RXS2Zremx4dnAxSEZ0YndEcE16bC9x?=
 =?utf-8?B?cEtHcWhyMkh1aUk2UUlUT2MwdTZTQkI5SENoOGo4TmZmK3ZzRGFRN0FoNjNo?=
 =?utf-8?B?M3BudUx5c09neXB2VDZKRXVocUxhblVRdGh1UVZjLzlqY040MHdwUGRFNnQx?=
 =?utf-8?B?NEppdElLNitiOWYyTXlvRFBqcTRlVVJXRjVLclVrbkxQYkRVTWd0QWtodWlL?=
 =?utf-8?Q?d8dderN2NVK7nwaE7gN2UU0tRLBaJdV+6svHD5G4TgAP0?=
X-MS-Exchange-AntiSpam-MessageData-1: MelIpAdJ4iFGQQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9875dcdf-e761-483f-e751-08de5194b852
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 04:40:32.3863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQnzV0+wSdbSuseA7bBvNKWVKbmGNnL2jvlfjEcdUY3i9D7JXvWmmQYyac0e88aWWxWioYrP5dmxLEvM1owN2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260111_204037_518196_CE086DDA 
X-CRM114-Status: GOOD (  22.44  )
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

On 1/12/26 10:54, Alistair Popple wrote:
> When mapping a p2pdma page the page reference count is initialised to
> 1 prior to calling vm_insert_page(). This is to avoid vm_insert_page()
> warning if the page refcount is zero. Prior to setting the page count
> there is a check to ensure the page is currently free (ie. has a zero
> reference count).
> 
> However vm_insert_page() can fail. In this case the pages are freed
> back to the genalloc pool, but that does not reset the page refcount.
> So a future allocation of the same page will see the elevated page
> refcount from the previous set_page_count() call triggering the
> VM_WARN_ON_ONCE_PAGE checking that the page is free.
> 
> Fix this by resetting the page refcount back to zero using
> set_page_count(). Note that put_page() is not used because that
> would result in freeing the page twice due to implicitly calling
> p2pdma_folio_free().
> 
> Fixes: b7e282378773 ("mm/mm_init: move p2pdma page refcount initialisation to p2pdma")
> Signed-off-by: Alistair Popple <apopple@nvidia.com>
> 
> ---
> 
> This was found by inspection. I don't currently have a good setup that
> exercises the p2pmem_alloc_mmap() path so this has only been compile
> tested - additional testing would be appreciated.
> ---
>  drivers/pci/p2pdma.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index dd64ec830fdd..3b29246b9e86 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -152,6 +152,12 @@ static int p2pmem_alloc_mmap(struct file *filp, struct kobject *kobj,
>  		ret = vm_insert_page(vma, vaddr, page);
>  		if (ret) {
>  			gen_pool_free(p2pdma->pool, (uintptr_t)kaddr, len);
> +
> +			/*
> +			 * Reset the page count. We don't use put_page() because
> +			 * we don't want to trigger the p2pdma_folio_free() path.
> +			 */
> +			set_page_count(page, 0);
>  			percpu_ref_put(ref);
>  			return ret;
>  		}

The change looks good!

Acked-by: Balbir Singh <balbirs@nvidia.com>


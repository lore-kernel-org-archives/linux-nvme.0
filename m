Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460F5C77B61
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8spNdJqUdZU7fPCO4nFAeBDgNOTdmOxN6lFP0JRLvgI=; b=fIV7QXlmBJsHafol8+NKcbImQG
	z404FFukOwYX37Vi2E6kC1tMOQcox0aA7kN7ookUuWOUI6RcZooSAANpEVqWpKCTj7BFYPHW4HN3k
	hdMCyO5sXCxlYy2e9RO4ow0xsdd5/I6b9cnidoFahJ9GqbRMsUElSAoFihbLzV9W4rhTBn4PkuJDL
	dyIvb1/hl8lVSVttpBeppuAS9eAAETAysPqUODyh5UVFM5YPjmjH/n26w6oHLIMf121O2QWoBAggw
	SPr+L3/Mj2wX+JDor8cta8SCoAGYn+cPRfePQRsRB+t5V7nrZv8bE1YN96iN25kLjsmAVncGGiDL9
	T0t58F3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqwUI-00GSNd-0k;
	Mon, 24 Apr 2023 13:44:14 +0000
Received: from mail-sn1nam02on20606.outbound.protection.outlook.com ([2a01:111:f400:7ea9::606] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqwUF-00GSMy-33
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 13:44:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRrW5KVpXvVan8lEnr4YFq4o2RYER95NlHZH2sbdhvD/ANAJrWYzVUAMoWYNdcYl8mNHB1/F/1wzoUvYi0nUP/sI9EZ4skw0/LylBVZbEgFnJMpGKJuIrEDCij1z1IZ9WfyHTALmJ2MidWgvrpkdJQ+VWgM2NTEsT5dcjjGgtHHWmv2hgSgVUxg7KdAeX5KTEhKlnDH0v8tcQRLFPnXMa97VLvwFd+/bFwsnAvprQrtcsW1KoNlDoW2VEb4semvr8bt9b0XW4au8y5sMrKw3T3/tOU3gpGoaIyItD2jsoIkugCIJXYW6Tms8uK8+ETV5T1NfCXWatKbDHcmN5nTIRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8spNdJqUdZU7fPCO4nFAeBDgNOTdmOxN6lFP0JRLvgI=;
 b=fiIWk1WyndMGpJF1kMhVF9igiUPT2SMDoFQfjIkh+AMnwqhSN8nQ+jZ5pzPpJlwf8VepYWGlDudyygF1hQLICohcxs1sIDe7I8JOTE1TImyh690s4UqLW5DX1Q2tFscOqABkOvn/xJV8UA1/eeK0HfP1kveIz8uf5ytgVggWRGWeqXG9RK1mZzxAGw2aRN3Hk/L9OvZfvTEZ7WPwhcfCwfNJ0q0xK0Jiq7XQSECmH63U2bW6lJNRptxXbAZ2Ysqd4LVe6TSFJJJTrzPGrNg2SIk9gKHIvPXGM8lcc7kBxEmtGtHHUV1vA1sQx8PDdXj7dX5AZRW8t4TA6W7YxMcr4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8spNdJqUdZU7fPCO4nFAeBDgNOTdmOxN6lFP0JRLvgI=;
 b=HBRo1KugwCzDVpOrq+YULCo8fq+yAcxf9cNPCFV6JW6FuTpg7i7JEQ0otfqTREnhvSCOyt7BbaAS9XOzW/bFE1CBqgglhmvjUzgWWXNQ/yjssfl/rphOJaswKQK9npCohXQbGLhTs3EtTrRF4HUJ1GK8YR3xmTlNjhCo+jb4inXfIosT8k8XdChMdkKyAD6U5Veb3DBv4AFTG+DLMwWy2/Tg91LPxpdLICgKoNP0eIXfJNYLSUG5mInbJqxBnSsFGB5KosgZp9kSdvSLiGIKmv40yFGO8dtACiqkbbS1tqahpQI7N8069Tdb+pBUMcLAT2lc9ObgLJI0UZl/09GssQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CH0PR12MB5332.namprd12.prod.outlook.com (2603:10b6:610:d7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 13:44:06 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%3]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 13:44:06 +0000
Message-ID: <b7800cad-841b-00a0-b51a-1f04502e8b99@nvidia.com>
Date: Mon, 24 Apr 2023 16:43:58 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH 1/1] nvme: add a dedicated .c file for sysfs interface
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, hch@lst.de, kbusch@kernel.org,
 linux-nvme@lists.infradead.org
Cc: axboe@kernel.dk, oren@nvidia.com, israelr@nvidia.com
References: <20230424130316.25805-1-mgurtovoy@nvidia.com>
 <ff1eb7b3-890a-7f12-94ad-6951bb1533ab@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <ff1eb7b3-890a-7f12-94ad-6951bb1533ab@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CH0PR12MB5332:EE_
X-MS-Office365-Filtering-Correlation-Id: a714ae98-0c67-4a6f-3455-08db44c9f8e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	QpfWXJpcEmomHpKY7CoVRhqH4HFAJYPCa0C528JiJC6Hlrp3f1QjoXPSS5eDDR1BGrqhQTcbd4KU6Fpph2z3ro2eBR1WHpORapyMl2N7rLMN4X69Z7/7Rgfk9nVWcFD12pZSUk6Qz/P3EQ+tLiJDNo3z0n8XoC9bDk15NLRvGadQ10h8Rqf55rHUblYhmf6LgAu/JCCmvhHf/T1A75a+7qZsivUMMrJX7qS9/z+9+PrnUT6+Iaydnwtu7Nl3yZd/BF4B4fJNeIAepX9ECIxPeC2ekCfAPkWrfCvukdC2VtbNCtcuGhFUWrYC79bqKydy5kGsfH6coSuj2iRY0QqsSuOqBcIgOOxywuT0L4O0NgdGjlLQWRDiF2dyd+Ipdnd1+odGma8cBsg74zGg8n1n1JH+aLaZJAcg/Qn9af6Hoz9RzSFJbS0qb8gwLDq3tinpP/aXDfeQXxf2AafEY4X2+V/JlYs3cFtghVZOyrkVq2jKsBX+B0wHtM2ChBjHqbWYCqsHWAqmceXluz6G45cwtMekETtTm9dXxZxb7ysAG2E+Beg21KuCQNmncGlsnKEmuTgfT1oCVFBfe57kYvB4gvmroHKBBREk5P6Vy5q2KT5278796dMzN2xEK0VqyxVdIsZE7t8juXHGscWPGUva5jAl1OMFF0NwcekP0YRY22MEayzMaVb6fb+eP1274oLP
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(107886003)(53546011)(6506007)(6512007)(2616005)(36756003)(186003)(38100700002)(66946007)(31696002)(478600001)(86362001)(66556008)(66476007)(31686004)(8936002)(8676002)(5660300002)(6486002)(41300700001)(2906002)(4326008)(6666004)(316002)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?RzIvNzBwUGdBWkV1Rmc3OXhGMnpZZHVVRXIwUUxpRDd0YU5MSHVvdHpJV0pi?=
 =?utf-8?B?RnZUb1dhdm9uZS9aK3J4N2hYNzBnUCthL3AxcUxLREZlNm9EVnJkUTljY2tr?=
 =?utf-8?B?UDNoWnAybWRkMm9BK1JOSnJCdlVvYVU1eGJTQk1hdVlPeTR5VUlJWU5RNi9I?=
 =?utf-8?B?VU5vSWhFd1IwRStvZkFSek1majhpN1JxVnJvMmNjckRHck9SM04vdVp5bWdN?=
 =?utf-8?B?cGNFQk51R0tXTWljQ2doTldjZUdyencwV1FIL1N3OTF2bWttU21FZ1doWjFB?=
 =?utf-8?B?YlgwcVJoMW85OW9mM1V1Q1gwbFhXV2JOQmtzMEtrVllwbGt3ZDhQR0w1eVdT?=
 =?utf-8?B?Y2FUbkNUQTNmQlNsZW40c3RDOHdDVjM3VVcvQTFBYTNocHJSSjk1aDVOZ3BT?=
 =?utf-8?B?M2VIaHp1aDBwTWZYMWVtSVRJREhQWkNEckVBdXBzQkF3S1BWYkdvV0cxVFNr?=
 =?utf-8?B?ZE5jMUl1K1VPUWpiQ2J2cXBKSUhYbkd1TGNYQmtyVXFWYnRwVFd4WnNjMEFO?=
 =?utf-8?B?aElCVUs3eVVOUTNxMWV0STFyMnJhQ1hENUU4MzJOWWZuYmxQanZEc05aSFl3?=
 =?utf-8?B?ZkQ2QXpxWUJxMzZ3d05Ncm12ckpnalBicjBaS0VJMTVicU9tVGhmZUxsSmda?=
 =?utf-8?B?YzNWeHQ1eERWRWFyLzI3dEVkZ3Z3Yk5SYzlFRVJON2E0d0p5dWc2dGRmSUJW?=
 =?utf-8?B?bExaVnVwOWIwMWZDZUk0WDgvTk94RW9DL1BoS3pYM1ZZNVY3QTlxajRKazUr?=
 =?utf-8?B?UG9TQXY2UFVqUGpXNUpsUmhDRFhPeXorVithRjlYaVczNkdIeDNTNTgzVkd2?=
 =?utf-8?B?NkhpRXJiV1EvVTZ5SkE3Z3g2dVJDSGlxSUdsTk1jWHMxb3lEaTlrRXdUemlv?=
 =?utf-8?B?ZENOMFpXS01wRDNnWjZieDJkWC9nNTlWK2E3cEZ4Q0h2bTVvNXdqLzBRVFhH?=
 =?utf-8?B?V0JMTnNJUDRyYWxtRkZzR3hON3RSeWVIYTBIS28zNGRoV0lxV1FqczZtM0Zi?=
 =?utf-8?B?bm5PVzJwTStabThPTFQ2QUhsOEtoQytTV082NVB2em93ajdQUTdkSDA3WHRH?=
 =?utf-8?B?bXNNMmVIbmpEelV4SGZYaXk5YlorMG44SkMwUFJmbUlWV2tQazBkV3dlb2E0?=
 =?utf-8?B?L2tPa01lQ29tUENUV2FQTUhidlhZSnNEK055ZVZkUURMR0JLRDNRRmlvKzRE?=
 =?utf-8?B?RGRIeUFwOTdyUEFJUTN3MERocmRwR0dwWVYvNkNyRndWTk51UzJFcW9IRDVx?=
 =?utf-8?B?VnBlMkY1LzZoOGtQaEtIVzhOMVZNLzJtWi9RSkZoRDNPNXdUelZUZDJZYVAv?=
 =?utf-8?B?WTFRbUZsZnJySkFJc2hYcDNZVEVMSGxCc2JpdE1BZ0M3RmVXOWZWRWp0VW9Y?=
 =?utf-8?B?MUZhSGdSSlNMZUtMSitibUovTjREZ0I1RDFhWG1sSy9YbE8zWnhISVRFM29a?=
 =?utf-8?B?YjdvT3VrSndWajNJa3R6blJ5ajNEZGM5ZVBYV2tKbERMdGV5OHgrdENwTU9i?=
 =?utf-8?B?ZEZmY1VYQ0ltS0FLcnNFT2I1Z1lRbmtZUE0zck1wUkExaitvTVZiTit2SFpn?=
 =?utf-8?B?bjNyam1KWFBFc3g5OHpyN29PeVE2TjdLeWFaY2tkQlZJMzBKYTI5SE41bXF0?=
 =?utf-8?B?a0IvNHpQaUovd1Rqb2RhK2dZVENxbXFIN3BqTWswNDVKL2JYNWxsaGV4c2tn?=
 =?utf-8?B?TmwzNno5NmhLRlovQkNGUlFqYUZycjYwT1RXei82ZkpVUmRXaEFzZkZkUGpH?=
 =?utf-8?B?dkZ0SFFxU3dKLy9rOHlrdnZwRnBLL1RWbnNGb0NqUEtrUVIxaVk2ZURZK0JB?=
 =?utf-8?B?Q2NoQ1kvSmtObzBFQlluWTJBMlN4K1B3ZllheFlFR0VUOEErWmczZVdqYmFK?=
 =?utf-8?B?NGxWN1o2d1ozOWNCL3gvNlQvZ3NIQnNSTmFkT2swVmZSaU8vL0hJUVE1QmRL?=
 =?utf-8?B?MjR1dU92ZTFjeWpLT2tBMkR4ekNjZGh5ZFFJTXpvcGZYOVArcUh5UnVHQ3po?=
 =?utf-8?B?VWF2My8yYjJXVWZOSXpKYU5FelEvSnpVRm9PbXBSeHRHT2Z0bldhQmN6Rlp0?=
 =?utf-8?B?UFhuR1BzY0YvbjFCR25WNGs2RXdWRmtRQ0pvM2diNTYzazdZMit3U1h5dUND?=
 =?utf-8?B?V3lKbXVYWTQ4TVJTVVBVcS9HQjJ1cC8yMkczNWlEVWkreDNUMWk4K3RZTjF4?=
 =?utf-8?B?eFJvYkZhemlnUXdzYlZpVzhOSDc2U2YrY2JsdFN6aVVJQ0NWbzRuaFQ0YURi?=
 =?utf-8?B?L1d1a21qN0E5Vjg3M0s5YjZ2T3lBPT0=?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a714ae98-0c67-4a6f-3455-08db44c9f8e3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 13:44:06.0521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FIAVC0kqWhrMHdYhW7BDen4rh/BnOJpjNpKh/xrlDfbmyv1glVt7iDFnmTMlIpQQjqms0lIitJU9N4+OLsOVyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5332
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_064411_985962_CB3F8C8B 
X-CRM114-Status: GOOD (  11.35  )
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



On 24/04/2023 16:38, Sagi Grimberg wrote:
> 
>> The core.c file became long and hard to maintain. Create a dedicated
>> file to centralize the sysfs functionality. This is a common practice to
>> separate sysfs/configfs related logic from the main driver logic .c file.
>> For example, in the nvmet module the configfs interface has its own
>> dedicated file.
> 
> Don't mind having it..
> 
> [...]
> 
>> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
>> new file mode 100644
>> index 000000000000..8d2aabe2d290
>> --- /dev/null
>> +++ b/drivers/nvme/host/sysfs.c
>> @@ -0,0 +1,657 @@
>> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> 
> Linux-OpenIB ?
> 
copy/paste bug.

should be only // SPDX-License-Identifier: GPL-2.0

>> +/*
>> + * Sysfs interface for the NVMe core driver.
>> + *
>> + * Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. All rights 
>> reserved.
> 
> Not an expert in this matter, but does copy-pasting full hunk of code
> from one file to a new one qualify for copyrights claims?

I'm not an expert as well. I'll remove it. Don't really care )


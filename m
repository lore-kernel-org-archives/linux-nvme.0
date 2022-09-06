Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B263ECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 11:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XGl3j7qVowKEDf3e3zM/gNHfL5OpgM6SYwH2jcn0V/0=; b=0Udf10435jTOAHm08pK8pkrcsP
	GgiqYLYnGnFGgYYKzTEHcyeMtV8zF69vhvNJv57dcx+2Y9lPwDaaXhTCy0n9fIu4k0szw91u8kuDV
	Ced+zE54fJsbkBWSibgmmlcSJOMCwhVBR6zbk8CNqBF14yigRP86znv/b0nU8HJ615+OCV5Q1H4EN
	1Q/ZVAwpNCAeAUL97CxxoMRanKUiYjV65iuTHekhbZSSuzhhDoBE1U42zQMy5LTE4+QS5ps3Pj8lY
	VSSMUBhQbqRx8ppzL3t6+mU2jLaxCamDxPlaUC5UbvqfriTg5r+b1eM3/NPybktyeTs3i3N3qghD2
	SAHuAMpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVWXf-00Cncf-7f; Tue, 06 Sep 2022 11:14:55 +0000
Received: from mail-co1nam11on2050.outbound.protection.outlook.com ([40.107.220.50] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVVSx-00CE7U-Dr
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 10:06:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELxYC/S0EniqKWydPv6akEZXT/f8p6PKzYEFxAHRFKQAXxN4cbXxNtX1BovaSy0CSC9cl5BOZZRiJdf/ETvo+4awYU3ycX9+jFDNlzEJKr6eQ6/CpP8Mw6b4uGOZbHtqWjQPfCW4WRmjuwZF/lnxdFtzFTMMHB4xgTQ0V5z7A4GkBidPu3OxOwC2lcjW0GTM77CitSgU2NRk8+TAj3zK98t95bMtxeGL0yzh8GhbkkuYycgHEvCf1YG6vV9iMfwhRfvZR3ZIFkTfsz+hTOdBj3kljEKO9uFp3qmdSTqqcMXAXtbD+4fyUvblMbJlTtkhDZKBYllG9h1vFZT4cQxhYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XGl3j7qVowKEDf3e3zM/gNHfL5OpgM6SYwH2jcn0V/0=;
 b=ca3z9ObSG41bUJ7H9WYlSVDtTw6OhPreea6bi0bZvaAwEUGIwvS3de72vhavf2uUVD+DzkFgbPF+30cp+agUwCCsHpSwTqwk/I9HZS+VDRT94qjMCDpfdxDHcM0IRHjNTWmZOX2zZ2UV6ci7QIqvXaXa+vcVp1VNXvqc9l0w3i8JSWQmyiYNKRP1v3F1VrO8qXwFbGsngeBpqMMKAU7/Ih4z6ch6lHkz/fsmXTX+qwpxkYCSIJPPXBWJ6+757K5YQOe93Gwn6KeTyf8lyvfDtvx0TPn+M450DurMum8Hd6/OZ5z0FuczeusQdxrVJCp04ZpA1cmcnZm3BT5CC6IA6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGl3j7qVowKEDf3e3zM/gNHfL5OpgM6SYwH2jcn0V/0=;
 b=FJV1sgSyz/XYosD5fDg3Q8xbYscFO7By36lkfMmRL+/c42IS6tGUAwnO4rVMjxhgCXlujinXt1Oj0twE6d1s3w2rHej0irM4f2B7LvGAZldsqVQZ2eM/RszA0Vz86DJ5QI1Bx1FMHbyeKnUgF1HrNk+Tx5sDJGiEnYETqH0P+NT1BLSdEsIYIT7PyJh2ifwXSSA1qsVF3PKkfPAugIpbJtN8eFcTQR46LnbVQnjaEZu+FF7WbTI6fdsjsWJACRsO+7jUJ8h5FyGKAHqhMx+BZmEyXEhxyLalyfh7gj6NAAtyVtAewBziRjD6FLd8Dlnlm1lTvL4o45H14lFc2mXEIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM6PR12MB4529.namprd12.prod.outlook.com (2603:10b6:5:2ab::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 10:05:53 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::ec56:2877:8bd7:afcd]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::ec56:2877:8bd7:afcd%5]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 10:05:53 +0000
Message-ID: <a01c2236-f5e9-d01d-74cf-13a056e7db89@nvidia.com>
Date: Tue, 6 Sep 2022 13:05:47 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] nvme: add DIX support for nvme-rdma
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: Chao Leng <lengchao@huawei.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
References: <20220829081256.24570-1-lengchao@huawei.com>
 <673f2871-3c0d-3910-c9b7-7cb4913c7cd5@nvidia.com>
 <59dc78d8-c91d-6a7a-339e-b191cb77fd31@huawei.com>
 <ddc4d332-2a86-af1b-6627-547673c44721@nvidia.com>
 <yq18rn6qxgl.fsf@ca-mkp.ca.oracle.com>
 <289da5df-e988-f0a9-95cd-2c437327a043@huawei.com>
 <20220905063759.GB2092@lst.de>
 <79f9829f-3337-6582-7ea7-6de5c8afc69b@huawei.com>
 <20220906065903.GA2345@lst.de>
 <42216010-70a0-e0ef-2b4f-b25072792f36@nvidia.com>
 <20220906093527.GA14205@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220906093527.GA14205@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0198.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0129d3f-ed4a-4ada-c2d2-08da8fef6204
X-MS-TrafficTypeDiagnostic: DM6PR12MB4529:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ljs7gsgEtLOsdj8GLgt4tALOkgWjQpQMZBaU3wzxPoNPLApRKagZah27FHNqRvah0jf63PDCxzEa/BJB1Dvh2M7nVV6NJ1+d0MsnmJ42MryUPEvnu1tPx2ubqr+37tFoYNS8HkEiAAGC6ENFkI4mJTHGQKdGJhjJ1N1tDvnGJJb/JBAV6U3SftAGIwc0dxBWXtDLnxQE2i+ovfP5lC2P5msOeLQ+2A91dKYezmz6mBZr7zIA22eqC646Yu5/bvXjDyvpC1PwgavCZUEtNcxu1EjVutJ8rZe1uLsh2byMUDVhhUtdSHc369OtV7a+VlWOxnyLJjrPsPyNib9BFJrcce72aYqqVaBbXbys6e7Pk6di1GI5d2p3XAtzVSFJKxW/SQzJGd82qWooA+XoS5pU//uCwy2mpedccACWVKn6ciVQbk7OF7bCXLvUY+uU7hnIOyNnvzohbc1Bp1Wm44VOwOSop0rJNCgLrhxuXh9EbdZHDpWekhYVDbVDf+zRzMpcy8qz66nw78whTh8Mf6lGaTV4/5TDa207g1a3G+h1E4UdmTViPukuJpVnMS/e265t3xnX1B04x2DH35loua9rTTnowUlU9y9DAcq2qi0x9ebacNyiA6Z0309N8I1w8Np7IVsOjcJRHlsms0a2SeOaiyulIO0MNFNU3t92HxVrNirrhUtylI+Z/cFZmBTCI4qvTA9dmA/CMygR1IF7FEWXc3Nll/qc4J6hdt1t23adiOsJmksG6Em3/MD6vXkwuzDw1dZHid67d7PpmrTrRFyb5OMVzPejlX+eSuqRTpnHjk4=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(6512007)(36756003)(41300700001)(8936002)(26005)(2906002)(6486002)(478600001)(4744005)(6666004)(38100700002)(66556008)(66946007)(66476007)(86362001)(8676002)(4326008)(53546011)(5660300002)(6506007)(31696002)(186003)(54906003)(6916009)(31686004)(316002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?Mk14K1kzb3hMNUdMREl1Qlh1VGZobHppWEJaVTZlU2laWCsyZUdIQlRPQ1c0?=
 =?utf-8?B?aVpkakk5Y3VadTM0V3FOZ0F4MUxmU2ZIWExJM2FVd3FSUE9sMzhtOXhsMWll?=
 =?utf-8?B?MXFEemllR0xCd04zQUttVEprckZNcTZaYkVVUUV6cHYxWWFmOWdQZG45bGVk?=
 =?utf-8?B?bDhkYVBEQkI0RmhNc2ZIeHVKbk82dDl0OWVwdXdUaDgzYXBXamh1WUMyYnhJ?=
 =?utf-8?B?UEk3YU4zaFFja2F1c2JYUDZvaThVM2FEa3NIaWd4dHgxSFlPVFNZN0JJcHNG?=
 =?utf-8?B?MkZNdDBqZ3NlQkpSMGpOeUFQdXR4VU9IamY2TEhmZDIzTU03QUFhYm1SSjZr?=
 =?utf-8?B?V2lXTi9RTUVkVENtMWpUdmo0eVFSako5VVNNVEtlTmZ5bjBwSVZ0anBSTlVM?=
 =?utf-8?B?ci8rOHdQUFlZMmhOVzBlYzlHcVNWWTdoaEF1V0h3R3k5Sk1ucGF1UTRlZ0Jk?=
 =?utf-8?B?OEs5S1FPYTBIRms0UHlDRXJDV0J5dG5sM3VPQzljWWpQSXJnZGJUVzNUaWpB?=
 =?utf-8?B?QWtoZXNpUWFhenFYY3JLZHBCUS90MllkN0l3clZpa0RTd1ppQTNZS0UvVVYy?=
 =?utf-8?B?Rk9PRGFKZTMzU3pPelVEUEdmWVFWWjJyQUZRSmpzNjE1UXNDbTBabGhVVEJ2?=
 =?utf-8?B?Q3BvR1RjT09QNm5GWHdvUnVqdk43Tnc4aFY5S2NXMzVLL3Vha3JEOGJEdEZU?=
 =?utf-8?B?T0daQTdFNWtIaHNlUXUzWGVNdFdPNGp2ZEN3Z2FVN2JZRkJnUFV5ZHZsc0x6?=
 =?utf-8?B?K1hnaDNTTGE5dFJhSWZOLzI1RGxQS29mZGJmWHY5eGlTZWJSSTBab3FwM09m?=
 =?utf-8?B?RjgwY2V6S1NTdlptN2V1ZW9vTnJEeU9EZGhyRVVGLzhrVko4ZGs5S3ROd2pJ?=
 =?utf-8?B?TzViaXdsY1Z0ays5ZkxBb1NHa2JlYU9nZUlmSEpPeTFCUVhQNjhRV0J3aHha?=
 =?utf-8?B?N0YvZnNiU204ZEdQNDJyc1NET2RIN0F1S1Y5SXh3eEloSjVNMWZxUnBqcTA4?=
 =?utf-8?B?REc4S0FmTUw0UmlwOG9aZXMwQUJWRVJkWmFpYm04V1BzLytBQlVndkRoY1pZ?=
 =?utf-8?B?Zld4NFlSZ1RSL21wbUlIMTJRak5sSE01MUhCWmJid2I3a0NWbG1uTEhUMldo?=
 =?utf-8?B?UFpwSUR2TVE0eUZnQmxwZzh1aTZaRTEvUjFUWXRKbzk3a3dkWEQ5RGV0ZG1u?=
 =?utf-8?B?T2hmRHNXMlRjSnpsOXFud0kvWWtOTHUxZ0E0UFFCMzAxeXpVSFVEQXkzUTZT?=
 =?utf-8?B?RlFvRFQ0REhEaHJ3NXY2WjZTVmpKUG96M2l1VUpYQmhBVnljTE51YW96UDFv?=
 =?utf-8?B?UnZaSzJjOGNjRXVXdHIvNXhaL1RhQVYzQitOYnRBbWFCdFlpdXBpOS9zNSsx?=
 =?utf-8?B?cVpWeW5JemV1OUVLT2c2cFgvNTZ4NlZUWi9iVElreUx4M2taUng0b3libFZG?=
 =?utf-8?B?Mnovd1JlejlEbkFuR0phOHFEWjhLWkttWnVDSVU2UUtwZWFuQit6WW01U3Vw?=
 =?utf-8?B?Z0t4ZklGa1FXNUhicmlTVWFidU9YRVdpSmNyL0NNTjJKcEdJT1ZyTS9sdkQ2?=
 =?utf-8?B?bVowL252ZC82L1pZUUtVL0daWUR6RkVjdnpaL0w2Yk5GUVVDTm1hblMzc2Ey?=
 =?utf-8?B?WFZ2ZGtyRzE3L1kzRWx6a2xxWjFZVFFtMnJ1Y21YTVRhNGVLY3BYSjFCdjRT?=
 =?utf-8?B?L3dROXhxR1l3MkxRQytlYllVdVRmQ3lIZ1VYRGNGaEZGMTBiV2VIRDRCSXA4?=
 =?utf-8?B?RlIvSHhLT3dQWnYrSVZaUHkwS1c2RlRNNXRUQ3lmMDhuRWl6TllWcERzVEFk?=
 =?utf-8?B?ZE1OTUs2N3M4b0RneDE5ZlNxZ2ZqK0ZVdXJOaG82ckh3VkJpd2lNNTFUL1Ju?=
 =?utf-8?B?R2FQRklaVk9SdDZacUJDQVR1M1llcWtTT0t5SWZZZ0R4UXY4aEpENEUxOTQv?=
 =?utf-8?B?WEZpTWwvS01lWjdLVFJVcTNHWDJrelNVM2x2WDlONzVmNG9jQm03d2pFVlJQ?=
 =?utf-8?B?UDAvMmE5aGlzaEVDY20xTVEvdjFsMVpCOU15RkkrRlBsRkcxR2haZjdWa3Bk?=
 =?utf-8?B?SHRQMkRNeVZMSG5kWFA0WE5rMko0eG0ySGNxcmVkTEpaOWJqd2lJUGZ4dmxB?=
 =?utf-8?B?YnJIdnF0c2RaWU5YNTlqUlBpUnBLd0JrN2dMVFpCUzhJdk92TEFqcTk1VEpF?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0129d3f-ed4a-4ada-c2d2-08da8fef6204
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 10:05:53.2825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtDlDEjS3RzxnyrwguBMrnklZO8Sey/EAh4I7p7y12OuGtQr3hm1u+sBLKeyg9S1vD0gDeScJmB+ybI5Uh9kFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4529
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220906_030559_775384_985874E1 
X-CRM114-Status: GOOD (  11.44  )
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


On 9/6/2022 12:35 PM, Christoph Hellwig wrote:
> On Tue, Sep 06, 2022 at 12:34:13PM +0300, Max Gurtovoy wrote:
>> Maybe we can extend the spec and say that for Fabrics only we can use
>> IP_CSUM as protection for "host_buf-------->host HBA".
>>
>> On the wire we'll use extended LBA with CRC as defined today.
> Please read up on the concept of end to end data protection again.

The current spec doesn't allow the IP_CSUM .

This is clear in:

"In addition to a CRC-16, DIX also specifies an optional IP checksum 
that is not supported by the NVM Express interface."

I'm saying that we can extend it to support it.

For now, it only shows the following path

HOST ---> [CTLR ---> NVM]

but it can be extended to something like

HOST ---> HOST_HBA ---> TARGET_HBA ---> NVM



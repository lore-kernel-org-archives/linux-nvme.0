Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E035C3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a3H2Xw5V5+qAJZi4tuOB1+uUPiiWV/IxecWAK8TYTSQ=; b=vI8AqJvaOZdDoQrOn0fYbUXU5J
	9iXT44+2MyDava/uTCDtHX/G+f1U1yo1cxgfNfr4WexiJLD9Dc6m1dhKhDKKoODzY1ro4aPqnGvtK
	cBYfiJCNgAqdilPYiso6h1R2cXLtAhtdN4nHcHOP69vFDExhcCocf7etBAurOEKpgvQMiNNho0BDs
	VIxErpVfoG4+89avebgxFCO83y0dfW06z8i9OH+wRR0E8t5xeXM4iYgj1l831RkNbkLr6ei+Vj/58
	92DCbPrA5K2nHeJrNSnyxx/0WWyyPz5+GY++QOEue6s+32jTG7GW1N4wi7Tk4o6FTViuEv57kgvPE
	nbrKCh8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHk76-00AqJH-1Y;
	Mon, 25 Dec 2023 12:31:20 +0000
Received: from mail-mw2nam12on20606.outbound.protection.outlook.com ([2a01:111:f400:fe5a::606] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHk73-00AqIs-2M
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 12:31:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gypvQ7axem9ipsnCseqjC91QBHUcMSvIJvamnt6DmpQGclpbdfbfMo5PINz1b7N/d0tSPy4TQTwQ/GqpaL9ZFXGsXKe+oNTKHZHWznTdiMaUZft3w1RnoMF3klwD4g8Ghog3Gj4H40sylG01aHqcf5JNjybVjuq/SmuNBd+zhsGbpoo2YSCTZx2yanTkaLxTPolv1W40oaHpVo50c4Dv/JwO+xaVuZTbJjJQe6Ch3+jhUSxnJGIgcJH6PgkmOIlbhVdOTqEA+hPZouxayF2AeQXV2MlK8lp1p8GQJtd22/lAWbqcDW4iyMVw0gI7BTywauYf+yTnYNkdyZh7rJCkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3H2Xw5V5+qAJZi4tuOB1+uUPiiWV/IxecWAK8TYTSQ=;
 b=fVZ4148GSb7ta9fgNKzGo7zXzD2CN/zSq7s/8dNrkQiM/qHsVR9b0RPw88VhGoxfnnpVGMna2lQ3zgpgHcSI3+aSRNx3p4cfD8ll49oVvNK6vG1yuuKXmpsijv8E1i21G5rytts9+punsZJ90mTXSj/oeZGuI5Ul8CHk1FLdE5lc/vCpKulrAHSU0etXD4wiudzIG/T5xu2NUbTygKUQiiqjbejd30MR/dtpXrb7hj2FCxMVZLPIdlcIbSL7/swTzerMA9fLrCnxMmiOf2oLbWH0KL28OTX08DcXPoldJRmz0hVd6bCBV6rejzh5h1fvNY0lB04B99scUkL/fKoaQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3H2Xw5V5+qAJZi4tuOB1+uUPiiWV/IxecWAK8TYTSQ=;
 b=mEJQiFSZIFIrbIsT0rWXscxcn9itbmLClgb6MFTAKeQt8uu0t35gBH3i/CnuSda8K19FJlogH70UFA24+uOMGDAip3EoRmQFCCMjo3L2hJhhduqI3oqJM8Ee385xGma3TFSymR8m5ut859BKL9QjNHW23JhLI8Ms8m95AAUJHoctR5SQc/2jUKamNg8bBoeVa2g+j0TmTm6pxRHJL591ouoOrNxJep+YhOTP3XwqZKKFWXU9MOB1jfL6CgpjJlFcMX8chLrrm65uo0M5x9mKe0BwMvn4C50/x9FegYO3GFBYrdjro6EREKmbpXek3shgviaWOkUZ6XWGnHcp22a+6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BN9PR12MB5082.namprd12.prod.outlook.com (2603:10b6:408:133::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Mon, 25 Dec
 2023 12:31:09 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7113.026; Mon, 25 Dec 2023
 12:31:08 +0000
Message-ID: <d7f05b69-6a77-4b87-b864-4d35481cdd9e@nvidia.com>
Date: Mon, 25 Dec 2023 14:31:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: don't set a virt_boundary unless needed
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, marcan@marcan.st, sven@svenpeter.dev,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 James Smart <james.smart@broadcom.com>
Cc: alyssa@rosenzweig.io, asahi@lists.linux.dev,
 Chaitanya Kulkarni <kch@nvidia.com>
References: <20231221084853.1175482-1-hch@lst.de>
 <155ec506-ede8-42c7-95f7-e8be32800a8d@grimberg.me>
 <8cfe55f2-4f2e-46f9-bbc8-5ab80d06f3d5@nvidia.com>
 <0f126715-9b51-4e14-8cef-c999f8760e4e@grimberg.me>
 <d5e688be-3419-4cf6-9bd9-bf2c1a6fb092@nvidia.com>
 <ef15a266-d1b6-406b-b956-91cab85e9a4c@grimberg.me>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <ef15a266-d1b6-406b-b956-91cab85e9a4c@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0035.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::11) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|BN9PR12MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 55ca0497-880f-497b-5884-08dc05455eda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1tgAX77FSIhHIjhpOZOISeg4qcJeSSpelOt0K2R1J5slkTMvaY71lPTHHUUxGRoNrUOl63dEsJ4qak2Z/b/CCcMWxiN5V+zEQH8FsIXcVmhGP02Am5sZFtdy6ZIxGHeL66K9kUZBtu1gfEHKvBXM755KYeO9e/6cotjZgFksuekIvy61kp1AnzdYvrXoaVccMsmH0wKQk/cVZUPHJyk4soDSxuxAw8gmACe56zv01u+jWx366d86PwDBZdJ0B2TojNragSg2ssWw8QglCo55DvHR+kZNpbBtKlrIAHX41g6cE8bepmkDkgGkmZzszjp2/ewQ9N1cCTmqBlLBCJ2O5gluH2OGolTrd3fDfPG//8Y+RSsQwObSYl4W8TCowXH0dhbs2DPDpyJwgepQqlA2iKdkGkszztClD0v6ueU8h3TrEDgc0EdTz9gs4SbyRGncAiS5ExmFJ6gCFDDmKShfIho3hM22a8y819lLiK523IfK5jUro4Yqlz3dGRbeu0OglD/K/1Ch0V0mDHbIPiyZnW2TXYPmhTDC7efCewPauQulre82T9ttKtve5yfHdMipTfhXX1nf2wi8byFGCtxx9omUagpTxDccFjDsCHQ+NbntShrMivX9qjfnH2IREF0S4ADanv1tAMeIvOMrVYVdGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(8676002)(8936002)(5660300002)(2906002)(4326008)(7416002)(478600001)(53546011)(66556008)(66946007)(6512007)(6506007)(6666004)(66476007)(110136005)(316002)(6486002)(41300700001)(38100700002)(31696002)(26005)(2616005)(36756003)(107886003)(86362001)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eU1OcDVrbDVHQ216Njh0dS9MMTluYjhlQ0RZakxOdDZZaFJIcG9RVVc3YUc3?=
 =?utf-8?B?SUhsd3lWZFFlNTZyVmlHL01zVkpHU0hUWmdxVVNzVlRnQzdTZTFWTjZNWXg0?=
 =?utf-8?B?NE56V0d4S2N1TGk3cE1sM1kxUGgzaUo4SjlJVjJnUjNacEYvTlJMRnNmL2w5?=
 =?utf-8?B?OWdyMDBLZmxzRWw4YTZ3dVB3Mm5mNDF1ZERzVzBtZm1yWFZpanAzVThtaTFt?=
 =?utf-8?B?QW81MUoyQjR5Wm5vbWN6YW9MeW5ZTk9XdG1rT1ZIVzdEWHNyWFhCT3BvYzNS?=
 =?utf-8?B?OEwyU3NQdHI4SG9HSkxLNmZ0OUJPaDA4WklLcURpa0IrNUF3dFc3Znk3RmJE?=
 =?utf-8?B?dVBXTFBhRWhhd21sK0xJUmJNVFdmUGsrS1VPMVVDYno4QUZqZVVham4yU2dt?=
 =?utf-8?B?Q1A4UXZQdDJWSXRESnVURzBQQmZLSndrRjNJMFVyRERMY1NXb1FEdHhzNDk3?=
 =?utf-8?B?Z2xyL2tjUHNIbW1BMXprNkhaNHg5Q1JqbDZBUnB3bklwT3BXZFdVV091REtH?=
 =?utf-8?B?d2g0Q2NvMVVrYmpZYjMvSjBDOHgvVkRXRENhZHRkeW1CQUN1eHNaVi9MZnc2?=
 =?utf-8?B?cGFmSkdjZGw3aWFRUVNyaGZlcmJHaVZxRFFiNFE2VkJrU3pKZ0pIbnBYekNE?=
 =?utf-8?B?NHdLTkNOZW5VWk5HOE1GQ25wMG82QUZzNnJ3d2hNcFNxdDkwbEszZEhYbFJn?=
 =?utf-8?B?K0ZnMjVNL1MxZ2N2SDJYUkQ4b0h2NzdMRkFiak5PeXVmTHlNNVg5eDdRUTV1?=
 =?utf-8?B?R2s2N1c1bSt2UDByY1pxWHF5ZzdzQVl3ZTQ3ODBOaWs2ZlNkdENMeGxQYzY0?=
 =?utf-8?B?R3FyQm4yS2JZWTQ2ZDNlblJDVGZNTlh3SjVFVXJIbDJLKzcrVjNZZUtNMEkr?=
 =?utf-8?B?dk9SbHpXdkpHVXRkMnJHa2lxRGdzRmN5YU5kanFiLzVNdjF0S0Zjc2dMRjQw?=
 =?utf-8?B?OWVrZzJVN25IQzQ0eHViak5uQzRRU0tPRUQwTWF6a0U1YmtHSUhOK2dqRS9j?=
 =?utf-8?B?d0lEcVcvVFRNM01ic000Znk3QkxTTEQ4K2QxQmVkZTZaclIrL3JCcnljYjJl?=
 =?utf-8?B?RjZrbytsMkZUcEZFYSt1enAvU004MlJRQnplNlg4N3d2QUNGN1RqNlJMT3dE?=
 =?utf-8?B?NmpMZWNoV2pEWTVnM3VLWTh4ZVR6L0kveFI2aVZhUlU1aEU2NGFYd3QxSnha?=
 =?utf-8?B?UERRdDllWTdrSzFuYlVvWC9ZZjJJQS8wcWFwSGdwWTlFNkpmWWhpYnJPWWVq?=
 =?utf-8?B?MWRhOTZnaFlaRkg1Mm13cjFVT0JyU3p4ZW04anpSalNzQnVzY3dZYVdDNzBi?=
 =?utf-8?B?cUpicXFNWkczR3pXM0ZqODBkMjJZVmRVK25aeWFENG1pZmtPMXh6ZDR0bUg2?=
 =?utf-8?B?djZxVk9QZitHY2EvY0ROdjRoWDZlZlFVbHBad203cXlzSVQ3SkNVRi82VmNy?=
 =?utf-8?B?eFhQYk1KT0dhUUtZZWcyV2FRbnZqdjhNSmZqN2NiOWY2RHZzSGxQckZCQy9V?=
 =?utf-8?B?U2lWY3R4ZzFXUjBxMFAzUlUwemtiM2I3dEZ6SGlwcjRPZFlEL2RmcWp0ZGdO?=
 =?utf-8?B?ZkJHZWpRTThBbGVxVm9OVGxEcm9ZdlhuVFJyNERpdUZpT2diL2RiK1NpeWM3?=
 =?utf-8?B?MEs4cXNZRG5VRW9IaUZseWFmOVovQ1VSMlRMUndQcjF1NlJOTEtxZFlGZHND?=
 =?utf-8?B?d3k5eXlIWkVjczdCYXdUQ2llckhNOGRHOUYvR3JvLzNRVXJSSHkva1BJWnBH?=
 =?utf-8?B?SEJTQjNEU2NLRVZSWlFQQ2lHUmI3RmNFZEdIMGxMdTZVUEttNGFQTXRkRnNK?=
 =?utf-8?B?WkV5Z1ZHejFvUVdzdEQzQWlaYitIMStWSmU2VUd4U0VuR0poYkpVaGl2aVVU?=
 =?utf-8?B?dFJNZGQvSDhSLzA4b0dZNU5hL3JTVFBpcEJVeWh4dUZoaWc4bS8vV24xZTZU?=
 =?utf-8?B?S2NoSmw0OGVjQTBMWTJ5SmFnQnRta21YVUttdUg3UHF5M1hmT0JzN2FTcHJq?=
 =?utf-8?B?NkcxMFk1OHZNRHZ2bzRFNkhwQTNDbnhxNXZ6YmJQRVovWXdLNTNMTTRmQlJj?=
 =?utf-8?B?OFJNUm92RkJndGdmUVJKblhqQWs0TDNEQ0lKdnhxVXVFaUt6NTlCKy9HQ2dj?=
 =?utf-8?Q?ZzXDIpcbM97QoKJTzd6/zk8FS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ca0497-880f-497b-5884-08dc05455eda
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2023 12:31:08.4134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qID8WKrFXReWPUm+vWg9k3KOk4irnM51S0H1WJxCEB1FRWkZveBTwgtCqwht21Xvd3Mv3Bkiuq0v7L6c9A7iIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5082
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_043117_832606_47229CF3 
X-CRM114-Status: GOOD (  34.25  )
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



On 25/12/2023 12:44, Sagi Grimberg wrote:
> 
> 
> On 12/25/23 12:36, Max Gurtovoy wrote:
>>
>>
>> On 25/12/2023 12:08, Sagi Grimberg wrote:
>>>
>>>
>>> On 12/22/23 03:16, Max Gurtovoy wrote:
>>>>
>>>>
>>>> On 21/12/2023 11:30, Sagi Grimberg wrote:
>>>>>
>>>>>> NVMe PRPs are a pain and force the expensive virt_boundary 
>>>>>> checking on
>>>>>> block layer, prevent secure passthrough and require scatter/gather 
>>>>>> I/O
>>>>>> to be split into multiple commands which is problematic for the 
>>>>>> upcoming
>>>>>> atomic write support.
>>>>>
>>>>> But is the threshold still correct? meaning for I/Os small enough the
>>>>> device will have lower performance? I'm not advocating that we keep 
>>>>> it,
>>>>> but we should at least mention the tradeoff in the change log.
>>>>>
>>>>>> Fix the NVMe core to require an opt-in from the drivers for it.
>>>>>>
>>>>>> For nvme-apple it is always required as the driver only supports 
>>>>>> PRPs.
>>>>>>
>>>>>> For nvme-pci when SGLs are supported we'll always use them for 
>>>>>> data I/O
>>>>>> that would require a virt_boundary.
>>>>>>
>>>>>> For nvme-rdma the virt boundary is always required, as RMDA MRs 
>>>>>> are just
>>>>>> as dumb as NVMe PRPs.
>>>>>
>>>>> That is actually device dependent. The driver can ask for a pool of
>>>>> mrs with type IB_MR_TYPE_SG_GAPS if the device supports 
>>>>> IBK_SG_GAPS_REG.
>>>>>
>>>>> See from ib_srp.c:
>>>>> -- 
>>>>>         if (device->attrs.kernel_cap_flags & IBK_SG_GAPS_REG)
>>>>>                  mr_type = IB_MR_TYPE_SG_GAPS;
>>>>>          else
>>>>>                  mr_type = IB_MR_TYPE_MEM_REG;
>>>>
>>>> For now, I prefer not using the IB_MR_TYPE_SG_GAPS MR in NVMe/RDMA 
>>>> since in the case of virtual contiguous data buffers it is better to 
>>>> use IB_MR_TYPE_MEM_REG. It gives much better performance. This is 
>>>> the reason I didn't add IB_MR_TYPE_SG_GAPS MR support for NVMe/RDMA.
>>>
>>> I see. I guess it is not *that* trivial then.
>>>
>>>> I actually had a plan to re-write the IB_MR_TYPE_SG_GAPS MR logic 
>>>> (or create a new MR type) that will internally open 2 MRs so if the 
>>>> IO is contiguous it will use the MTT/MEM_REG and if it isn't it will 
>>>> use the KLM/SG_GAPS.
>>>> This is how we implemented the SIG_MR but still didn't make it for 
>>>> the IB_MR_TYPE_SG_GAPS MR.
>>>
>>> Sounds like a reasonable option. But doesn't think mean that the
>>> driver will need to scan the page scatterlist to determine what internal
>>> mr to use? Even a fallback mechanism can be affected by a given
>>> workload. Plus there is the cost of doubling the number of preallocated
>>> mrs.
>>>
>>
>> Scanning the scatterlist is done anyway for mapping purposes so I 
>> don't think it will affect the performance.
>> The cost of doubling the number of MRs is the what we need to pay to 
>> get optimal performance for contig and discontig IOs, I guess..
>>
>>>> Actually, I think we should have the same logic in the NVMe PCI driver:
>>>> if the IOs can be delivered as PRPs then the driver will prepare SQE 
>>>> with PRP. Otherwise, driver will prepare SGL.
>>>> I think that doing the check in the driver for each IO is not so bad 
>>>> and devices will get benefit from it. Usually HW devices like to 
>>>> work with contiguous buffers. If the buffers can't be mapped with 
>>>> PRPs, then the HW will work a bit harder and use SGLs (it is better 
>>>> than doing a bounce buffer in the block layer).
>>>>
>>>> I actually did a POC internally for NVMe/RDMA and created sg_gaps 
>>>> ib_mr and mem_reg ib_mr and checked the buffers mapping for each IO 
>>>> and got a big benefit if the buffers were discontig (used the 
>>>> sg_gaps mr). Also the contig buffers performance didn't degraded 
>>>> because of the check of the buffers mapping.
>>>>
>>>> I created a fio flags that in purpose sends discontig IOs for my 
>>>> testing.
>>>>
>>>> WDYT ?
>>>
>>> Sounds possible. However for rdma we probably want this transparent to
>>> the ulp such that all consumers can have this benefit. Also perhaps add
>>> this logic in the rdma core so other drivers can use it as well
>>> (although I don't know if any other rdma driver supports sg gaps
>>> anyways).
>>>
>>> If this proves to be a good approach, pci can do something similar.
>>
>> For RDMA, I plan to do it in the device driver (mlx5) layer and not 
>> the ib_core layer. It is unique to our implementation.
> 
> Well, SG_GAPS is not intended to be a unique capability (although it is
> today in practice I guess).

The uniqueness I meant is to use 2 MRs/Mkeys to implement it. Maybe 
there are devices that can do it in a single MR/mkey.

> 
>>
>> For the NVMe PCI case, I suggested doing it unrelated to the NVMe/RDMA 
>> solution. The NVMe/PCI is actually the device driver of the PCI device 
>> and the scanning of the scatterlist should happen in the device driver.
>> I suggest to try this solution since we always debating about 
>> thresholds and when to use SGLs.
>> Now that Christoph opens the gate for the driver to work with 
>> discontig IOs I believe that for *any* discontig IO we should use SGLs 
>> and for *any* contig IO we should use PRPs.
> 
> Why *any* contig IO? There are certainly cases where sgls would perform
> better with sgls than prps I'd assume... For example if a large buffer
> is physically contiguous (say a huge page)?

Yup, PRP is limited to MPS..

There probably should be some capability added to NVMe Spec to help 
drivers to decide the optimal IO PSDT to use.

So I guess we can say for now:
if scatterlist is discontig or data_size > sgl_threshold - use sgls
else use PRPs


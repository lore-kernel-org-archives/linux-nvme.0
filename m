Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B554ECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 14:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cc/93CyTZiFGpt6/YbH+8zjjgAYshgYwWOlNwCQGqS0=; b=bYl5aw+n07sGcCwiIm46WHrS0h
	NlIyNvlPwKAy6opuArUuNHakTLqIn7ZBySpMjSQm5nalGr5TzpxYe1CeAcg2hlIroFoqzowSdEzcu
	M/7s6CE9ax+4SYQ41d3tkPREfRHMd7tLQbWFsSmS9EcHDN0M5YW/ep/7yZHR55mASS1wUvUZjWbKY
	PURQ0/dcEQYz9BM/uCydMYUUmHlA2L04ZY/ig+DBKKlDAW3tvPZdCXVc32OXPPZLowlrH4NLFIOmp
	WpTp/t/QUFro8Q71ibTqndHDOF2TlU1q8CmTGjLlso3XiTgtz5SnK5ikFbdzDUTpVdt8P61n88vuH
	5SKXJ4Wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSgC7-00BDUW-EX; Mon, 29 Aug 2022 14:56:55 +0000
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com ([40.107.223.66] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSgC3-00BDSY-Sc
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 14:56:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSSZFzyEYBihZpVttakDvzBfIpR4cPEztlitPnJOHJS/F0A4dZSpHVDW1+lnSpFBBR65OyXSbGKKMMppgomxCwHXm34qWExHGHl931WlsM423JrFNbSdMr7D4vQCrIwoYTSx+RQruqtFCyjrx3mvrmtfldUuV9bkka/Uaf+jrdDPDAVms7HGuyo2oCsD7BJR92GGkrLrE4yOpW0EsJwJKPMtvYQIAr+MtdN3yygSoPc9H6p5+pesfU7aL8npTm/ipfEMpxJw9W+8N7raaWz7ObwNb/62LsYo0Xn5tAEY8iAxeLS5HLLqw5mFHu43ZqUJ0KxiV4sMvAfy4MFVqvLGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cc/93CyTZiFGpt6/YbH+8zjjgAYshgYwWOlNwCQGqS0=;
 b=QzoRPuZXYfTcYZ5/oEos8CVzbRlAOZseJfGMXixvOr1XHJz7Xbl0zn2+u8s2Roiyjvfo1jyQDpmlm9+viNyF+NLw+zs8JaLK/own/SY9cKRv8kH208E+RQlhqfxDGP9+LFzFoHMMvFaoQlrzq0XnC8Mcq2oBIWKrBtfwScv3nIekHWXfyJvJFqa5HpjDbDyAEGcZxVSyj0T13/rBYnkZQEvrFcr9Ht2ATs6G9av007Aum7cO3jdxOiW80CpbQEGJfldUOAs9A1IS035+aQUocUhRuTUhtQg94nluQMjDgPziR3kQ7DdxFVPS3RBOZKViL/eeLrcd+vqNndOKX/K80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cc/93CyTZiFGpt6/YbH+8zjjgAYshgYwWOlNwCQGqS0=;
 b=UEKmP6tlE+YBax4e8fsa6vJX4x7vCSAF37Ytiuy3ZwTChn8MgOm7aKUrcPdmX8UrAy3mtOQQd4NU8jKSgWwbjALwMpmkXRN9Ty1Tw8tMM0LjkLnlK2h25NsWaK8xSlcgxjW0OmNnSyLZuroLc1esEAKgACG6aRrxFelhsXyvRi8w/+5oUxnmUVy0ZenKEuE2okxY8r8g7atX/8gEdbeGlCSXEUapAWuDVXphddi+uywLggHEhUpJ7MAvv+dq/RSdrXl2XD5fDnTH+ao/ANXlQu5PAdMdOs4xstI7Vh1KztIX2feMVKKPAaDOUIdbBKz0P821smU73SNcS6W0dyZdNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BN7PR12MB2836.namprd12.prod.outlook.com (2603:10b6:408:32::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 14:56:47 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::ec56:2877:8bd7:afcd]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::ec56:2877:8bd7:afcd%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 14:56:47 +0000
Message-ID: <ddc4d332-2a86-af1b-6627-547673c44721@nvidia.com>
Date: Mon, 29 Aug 2022 17:56:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] nvme: add DIX support for nvme-rdma
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, kbusch@kernel.org
References: <20220829081256.24570-1-lengchao@huawei.com>
 <673f2871-3c0d-3910-c9b7-7cb4913c7cd5@nvidia.com>
 <59dc78d8-c91d-6a7a-339e-b191cb77fd31@huawei.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <59dc78d8-c91d-6a7a-339e-b191cb77fd31@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0241.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a7::12) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dc57ef7-013b-410d-4330-08da89ceb1a0
X-MS-TrafficTypeDiagnostic: BN7PR12MB2836:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	FzLlcbAOzYy4X8BzlfIU4+8+/z1ZcYaMIymUMO3uwEYrwP1F04XvavaSFkonkIGMUOiN9EqRHc8ihJKYyCGUJT6HAPO0dimLS7bsbXI23LIvXookSqjdTNUp1s/9Hny/DSfcecM/pv9j9EZdH3a7oZnCRHSrzxsgdF7G2fik8ZnbqWIfWgqGs9v1LgOrv4OmMkyrBO+ACL1WirLcAar5elxFDI7zqxym7ZBx/PcUCKiDKZ3pbfIxcG6qB/AF1MSOcoTPe1hBHz4kWhq5nF8amGXCdC729GEFUjD0qP/K/zxceaxethxi2C7TytMnxYFQG0DjPsyehlT12vlEbVsxBfCzWJ3GaUV49SYaNlFCMWo/VWtWmdVPjx4VW+GSXb4euXSYBae4daoKmbo2a7GGSKW+3xTBDH4FhlUiTBE9bWpxiplAAMtpR1HLkYeTD4sO0d0wI8A6QNL0Uep1XkrIv3iiCL2Iej7A6rDliCBbxN+cVRS9SH2UIcWW37F2/NKa+nMV2TJTDD71ivHqbQKPBUHT7eJlu4Xy0vrlNC2Uu7FW7eF0yk1eMBRF06TpcfZ7tyzr3JL6uSP80RUhhBYNS1tdaanZB8tXC7S1KUHjbIGih5YPN66xsXjAxl8wsbiszQ24O5/dWXVOwUVaif3wEoacSn5nKF9/WAbCv0LC8B9WhZdgDtKkuu9kQ4AGB+fhyINTSkPYw6k8FNS1KTCCUxFbw0o+GHmSi1xr/BRczi+Q1VIBUbwnRfzTsVRO48D+Fcg/KRlAn8/SOoRtbbeXr3b5WGLNiEFHZospgln7AG0=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(396003)(39860400002)(376002)(8936002)(2616005)(2906002)(478600001)(66556008)(66476007)(5660300002)(83380400001)(53546011)(26005)(6512007)(41300700001)(4326008)(6486002)(66946007)(8676002)(186003)(316002)(31686004)(6506007)(6666004)(36756003)(86362001)(31696002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?NWZpMnQ3ck1OT2tadzRYWXpnc3hjZ3Rkbzc2c1FSUWZuTUFBSmZDdWVSaHM5?=
 =?utf-8?B?c2VVRklNSW1rSWNKT2J4aEpxdlJ6S3FqSUloK2YzNGFaS1B2a3E1NHlLQ1dU?=
 =?utf-8?B?UHA1cTI5Nko5T1pxNFpyKy8rT0MvWERCMW05MlExYW5mcTlYOVFIQkI5ZzZM?=
 =?utf-8?B?aHdTaUtDM3BaK1RzRFJUaDBVMy9pUzZ4ZjNwQ3lscUFtdHpuM0UvL0E5eGd0?=
 =?utf-8?B?MEhmMUZRRk44WHR3MGd3blFRa0hQVTh3SlVYT0R2N095bGpNcmx3QnlNVC9B?=
 =?utf-8?B?VkhiSThQa1BINHFJMEN5Qm02RTNiSGJYb1R6SW9zclhXa0dLbkdwWDNHZ085?=
 =?utf-8?B?S0VqUFZXTEszemtVdmRteHNQZEd0QWZjekMrWUdQamg2K1dYY2dLM1dqek1o?=
 =?utf-8?B?YW0ydGJ1aDVTYVMySTJ1eWFrMWI0RXZIU1prSlRMR3psSVhvNFdxTlB2a1Nu?=
 =?utf-8?B?UTFYNEN4SWNteEtTSmlpWHpoUmRWSnEvYktHeDNDWW9xOGd3RW0xRDNqdVUy?=
 =?utf-8?B?VEEva2gzTkFRZHlwdDllRWtyVUtERExIM3hxd2RHVHJjSmxSdFV4RHg4ZVFx?=
 =?utf-8?B?dkV0ZFQ5RjM4YVVjZHQ5cWF5QXdjeWZBYkhSQUZMbTVnd3hEbllIRWJoOWcw?=
 =?utf-8?B?YmJYWmxNYjJvZnRVNUZMaVZ1ekhkMWl6L3FmanI1dStVUSs0cEs0R01xZHZt?=
 =?utf-8?B?dy9FRmRhSE5Cb0F1TWQ5RmVqYjJRdWJVbHpld21XSDkyWFRpVU1oTzI5Wis5?=
 =?utf-8?B?Tk1lTjYyS1g4d0dQNUxFRXBRTjhRQ1MrdTJzdG14Qk11OTJjVjlSZi9UM2Fj?=
 =?utf-8?B?OHVxMnRRV1lqMFJKV0R6Mmg5UTdYdllTUzd2THkrRUJ2amZ2L2dpSjdlMy81?=
 =?utf-8?B?OWlCanRyaTlTYnhDNGpTcndGSXBVY1RJZEUzeDVuZ0VacG91UEtCWmJWNGEr?=
 =?utf-8?B?OXlxYk1hK0pHTDlTN1BLRnArYitwR0ZEd2htcnN2WFlQYzgwN3VCWmNmSCt4?=
 =?utf-8?B?dHRsTU5yaUt0ZjQyTXJXSGVtY2ovZ2JXT2dtVDg3RVdSVDlsR0xTQXV5V1g2?=
 =?utf-8?B?QVdHZlUwUmZKOG1IK2E4VVlrNHA0TENGTER6UVNxdS8rRm0rNk9nN0prRG1S?=
 =?utf-8?B?RHpzd3BFdzRYcDhucGZKOFNEanBxVm9Fak8xVzNjdUVOaG0ycmJ4aWhPSkZn?=
 =?utf-8?B?QW1tL09Sc0dlNUx0WllUNzd0QlVpRDg2dDJwZVViOUxHUkI4WFRjWGRoWEt5?=
 =?utf-8?B?SjBuV3hsbmNpMUE2YjdodFZBNWt3K0Fsa1M4aVhaeXJLU1NtbUh2bmlqeDVj?=
 =?utf-8?B?YTk0T0hoclZKWmlSMk44WFpnN3NDUFd0L2dEazB5alJYdkdIbWVVRGpNL0k5?=
 =?utf-8?B?dTR6U1ZJV0tFeFJIRHRyTEVyMktVU1JXZGw3UFpCQk1ZUlQ0WHdYZWRpV01i?=
 =?utf-8?B?dkZuRWZtT1F6Uk1UbUM2Vk50ZytjTWZ6Z2IrUy9QSkZDL0VNdHZJOGl5Wkk1?=
 =?utf-8?B?R3B6a2dSbGl1bVY3VmdicHg5cVVFalp4NWYrTlJCSXFYRXQ5aW12K1BlVzc1?=
 =?utf-8?B?WDNHZ2hBWDVXRnY3TEZ1MFVpSWpWWlhaYVpPcjd3L3NkYlo2U1NYVUFjWjZR?=
 =?utf-8?B?elg1Z1RvYkExa3VQbndtRVJ6d24yN2ZwcW1JZmZnS2NMN2lhNlRRQzNvVmxF?=
 =?utf-8?B?clowTWJNVzdPbEMyVENNNEpSV3VQYW8xSmJJL2RwYnY0Yy9qd29mbmRScUNW?=
 =?utf-8?B?UEJXNlk1T1RqUmlVaTdxWVhnbmtId2NQdnBQNkpuUGsvRHROZGpQMk1kL3Fz?=
 =?utf-8?B?RkFBakVaQmUrMW1KeEhoL2luM1VQcHMxMUkvSUtkR3dubW96Skw3c25teUUz?=
 =?utf-8?B?K2ljN1h4U2ovWmJYa1VkK3NUMWptYzY3aDJzQ2pLYjVoOHorclF0OWd6OE54?=
 =?utf-8?B?TWVjT21haGwyOFNpaXZWWlZ2ckFZMEpCTUIyQUJUcjBGWHdtNlZtVzRYL2hC?=
 =?utf-8?B?VWhuZlI4enczNkFTN3FkeVJjQlMrR2N3MHFMVXV5eHdJUUd3SWcreHlCcm9w?=
 =?utf-8?B?Rzl3MGpNbGFkeitCenVOeVgzaU9XU3dkclVBVU1ra1ZYSFcwZm5xYURZMjNK?=
 =?utf-8?B?MnBCdWZEWWxwbjhjQ0pHR1ZxUkl6a1pXNGVzald5cWduN1BaekFpZGpXblNi?=
 =?utf-8?B?a0E9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc57ef7-013b-410d-4330-08da89ceb1a0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:56:47.6744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: np+buAKzmOpwE9ScxOM9KnIHhmxnc9TaXcnbrJDzQkfgtt3wUW054pYZaXkCpn+oCV7J5+IkZSdSznEixHEFnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2836
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_075652_004153_FAD1A3F6 
X-CRM114-Status: GOOD (  20.54  )
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


On 8/29/2022 4:16 PM, Chao Leng wrote:
>
>
> On 2022/8/29 18:43, Max Gurtovoy wrote:
>> hi,
>>
>> On 8/29/2022 11:12 AM, Chao Leng wrote:
>>> Now some rdma HBA alread support DIX-DIF: host buffer to host HBA use
>>> DIX, host HBA to target use DIF.
>>> This patch add DIX support for nvme-rdma.
>>> Test results:
>>> The performance of different I/O sizes all be optimized.
>>> The CPU usage of 256k size I/Os can reduce more than 20%.
>>
>> You're adding a new PI guard type for 16bit mode only, aren't you ?
> No, Now DIX just be defined for 16bit mode.
>>
>> I don't think the subject and commit message is correct.
>>
>> Can you attach to commit message please the table of performance 
>> numbers before and after the patch ?ok, I will give you the detailed 
>> performance numbers later.
>>
>> You can mention that also in iser, if supported, the default is to 
>> use IP_CHECKSUM for DIX and not CRC.
> According to DIX define:DIX = IP_CHECKSUM.
> To reduce CPU utilization, the end-to-end DIF for SCSI protocols is 
> DIX-DIF when supported by hardware.

 From what I re-call DIX was protection between host_buff -> host_device 
and DIF was protection between host_device -> target_device.

If now its defined as DIX == IP_CHECKSUM and DIF == CRC please mention 
it somehow in the commit message.

Something like:

"

Some RDMA HBA already support both DIX (IP_CHECKSUM) and DIF (CRC) offloads.
Therefore, for host buffer to host HBA it's preferred using DIX to get 
better CPU utilization.
Add DIX for host buffer to host HBA integrity, if supported by 
underlying hardware.
Wire domain protocol for data integrity was not changed (will be using DIF).
Test results (add a table please):

"
>>
>>
>>>
>>> Signed-off-by: Chao Leng <lengchao@huawei.com>
>>> ---
>>>   drivers/nvme/host/core.c | 19 ++++++++++++++-----
>>>   drivers/nvme/host/nvme.h |  1 +
>>>   drivers/nvme/host/rdma.c | 24 ++++++++++++++++--------
>>>   3 files changed, 31 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 2429b11eb9a8..7055d3b7b582 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -1623,7 +1623,7 @@ int nvme_getgeo(struct block_device *bdev, 
>>> struct hd_geometry *geo)
>>>   #ifdef CONFIG_BLK_DEV_INTEGRITY
>>>   static void nvme_init_integrity(struct gendisk *disk, struct 
>>> nvme_ns *ns,
>>> -                u32 max_integrity_segments)
>>> +                u32 max_integrity_segments, bool dix_support)
>>>   {
>>>       struct blk_integrity integrity = { };
>>> @@ -1631,7 +1631,11 @@ static void nvme_init_integrity(struct 
>>> gendisk *disk, struct nvme_ns *ns,
>>>       case NVME_NS_DPS_PI_TYPE3:
>>>           switch (ns->guard_type) {
>>>           case NVME_NVM_NS_16B_GUARD:
>>> -            integrity.profile = &t10_pi_type3_crc;
>>> +            if (dix_support)
>>> +                integrity.profile = &t10_pi_type3_ip;
>>> +            else
>>> +                integrity.profile = &t10_pi_type3_crc;
>>> +
>>>               integrity.tag_size = sizeof(u16) + sizeof(u32);
>>>               integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
>>>               break;
>>> @@ -1649,7 +1653,11 @@ static void nvme_init_integrity(struct 
>>> gendisk *disk, struct nvme_ns *ns,
>>>       case NVME_NS_DPS_PI_TYPE2:
>>>           switch (ns->guard_type) {
>>>           case NVME_NVM_NS_16B_GUARD:
>>> -            integrity.profile = &t10_pi_type1_crc;
>>> +            if (dix_support)
>>> +                integrity.profile = &t10_pi_type1_ip;
>>> +            else
>>> +                integrity.profile = &t10_pi_type1_crc;
>>> +
>>>               integrity.tag_size = sizeof(u16);
>>>               integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
>>>               break;
>>> @@ -1674,7 +1682,7 @@ static void nvme_init_integrity(struct gendisk 
>>> *disk, struct nvme_ns *ns,
>>>   }
>>>   #else
>>>   static void nvme_init_integrity(struct gendisk *disk, struct 
>>> nvme_ns *ns,
>>> -                u32 max_integrity_segments)
>>> +                u32 max_integrity_segments, bool dix_support)
>>>   {
>>>   }
>>>   #endif /* CONFIG_BLK_DEV_INTEGRITY */
>>> @@ -1900,7 +1908,8 @@ static void nvme_update_disk_info(struct 
>>> gendisk *disk,
>>>           if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
>>>               (ns->features & NVME_NS_METADATA_SUPPORTED))
>>>               nvme_init_integrity(disk, ns,
>>> - ns->ctrl->max_integrity_segments);
>>> + ns->ctrl->max_integrity_segments,
>>> +                        ns->ctrl->dix_support);
>>>           else if (!nvme_ns_has_pi(ns))
>>>               capacity = 0;
>>>       }
>>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>>> index bdc0ff7ed9ab..92cf93cf120b 100644
>>> --- a/drivers/nvme/host/nvme.h
>>> +++ b/drivers/nvme/host/nvme.h
>>> @@ -276,6 +276,7 @@ struct nvme_ctrl {
>>>       u32 max_hw_sectors;
>>>       u32 max_segments;
>>>       u32 max_integrity_segments;
>>> +    bool dix_support;
>>>       u32 max_discard_sectors;
>>>       u32 max_discard_segments;
>>>       u32 max_zeroes_sectors;
>>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>>> index 3100643be299..0f63b626b3d4 100644
>>> --- a/drivers/nvme/host/rdma.c
>>> +++ b/drivers/nvme/host/rdma.c
>>> @@ -872,6 +872,9 @@ static int 
>>> nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
>>>           IBK_INTEGRITY_HANDOVER)
>>>           pi_capable = true;
>>> +    if (ctrl->device->dev->attrs.sig_guard_cap & IB_GUARD_T10DIF_CSUM)
>>> +        ctrl->ctrl.dix_support = true;
>>> +
>>>       ctrl->max_fr_pages = 
>>> nvme_rdma_get_max_fr_pages(ctrl->device->dev,
>>>                               pi_capable);
>>> @@ -1423,10 +1426,10 @@ static int nvme_rdma_map_sg_fr(struct 
>>> nvme_rdma_queue *queue,
>>>   static void nvme_rdma_set_sig_domain(struct blk_integrity *bi,
>>>           struct nvme_command *cmd, struct ib_sig_domain *domain,
>>> -        u16 control, u8 pi_type)
>>> +        u16 control, u8 pi_type, enum ib_t10_dif_bg_type dif_type)
>>>   {
>>>       domain->sig_type = IB_SIG_TYPE_T10_DIF;
>>> -    domain->sig.dif.bg_type = IB_T10DIF_CRC;
>>> +    domain->sig.dif.bg_type = dif_type;
>>>       domain->sig.dif.pi_interval = 1 << bi->interval_exp;
>>>       domain->sig.dif.ref_tag = le32_to_cpu(cmd->rw.reftag);
>>>       if (control & NVME_RW_PRINFO_PRCHK_REF)
>>> @@ -1441,7 +1444,7 @@ static void nvme_rdma_set_sig_domain(struct 
>>> blk_integrity *bi,
>>>   static void nvme_rdma_set_sig_attrs(struct blk_integrity *bi,
>>>           struct nvme_command *cmd, struct ib_sig_attrs *sig_attrs,
>>> -        u8 pi_type)
>>> +        u8 pi_type, bool dix_support)
>>>   {
>>>       u16 control = le16_to_cpu(cmd->rw.control);
>>> @@ -1450,16 +1453,20 @@ static void nvme_rdma_set_sig_attrs(struct 
>>> blk_integrity *bi,
>>>           /* for WRITE_INSERT/READ_STRIP no memory domain */
>>>           sig_attrs->mem.sig_type = IB_SIG_TYPE_NONE;
>>>           nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->wire, control,
>>> -                     pi_type);
>>> +                     pi_type, IB_T10DIF_CRC);
>>>           /* Clear the PRACT bit since HCA will generate/verify the 
>>> PI */
>>>           control &= ~NVME_RW_PRINFO_PRACT;
>>>           cmd->rw.control = cpu_to_le16(control);
>>>       } else {
>>>           /* for WRITE_PASS/READ_PASS both wire/memory domains exist */
>>>           nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->wire, control,
>>> -                     pi_type);
>>> -        nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->mem, control,
>>> -                     pi_type);
>>> +                     pi_type, IB_T10DIF_CRC);
>>> +        if (dix_support)
>>> +            nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->mem,
>>> +                    control, pi_type, IB_T10DIF_CSUM);
>>> +        else
>>> +            nvme_rdma_set_sig_domain(bi, cmd, &sig_attrs->mem,
>>> +                    control, pi_type, IB_T10DIF_CRC);
>>>       }
>>>   }
>>> @@ -1501,7 +1508,8 @@ static int nvme_rdma_map_sg_pi(struct 
>>> nvme_rdma_queue *queue,
>>>           goto mr_put;
>>> nvme_rdma_set_sig_attrs(blk_get_integrity(bio->bi_bdev->bd_disk), c,
>>> -                req->mr->sig_attrs, ns->pi_type);
>>> +                req->mr->sig_attrs, ns->pi_type,
>>> +                ns->ctrl->dix_support);
>>>       nvme_rdma_set_prot_checks(c, &req->mr->sig_attrs->check_mask);
>>>       ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
>> .


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F1EC678D5
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Mar 2023 03:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4hjFu4xp7MOPQEJczwWDhFom07bt70avJjY1+bipa48=; b=fOzcN+16Rx4YFk/h6bEterGiwo
	nCcM+xTPtCaFKZLC8WcZBIfBSRIcUZtqgrIQd9JjpbJmGhusnRqLOejJg3vvDjRePVA5s33VxlWt/
	33RISw5Bu7CqKwf9Pej0q8a2LiC9DAHtbgb+LKbn+FVfnnCYLhdmUOs7PvF3WjgqfBbBuadWzlCU4
	khVnezEtewqJNp6hmz81bCi4fXele+OsID3dEJ+4u6Dql9ns+KvF/MfvXsp8ykW63CgNfCV3dlGSY
	patEXGNWtyfEqOlk5L6FcuRT/lZMQ4mXy8WQOYHAcBt+owoyLktV38GS/EHlFitwYKUNf4ZKJPpJJ
	L2nUZiiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pa73l-007fBS-89; Thu, 09 Mar 2023 03:35:17 +0000
Received: from mail-mw2nam10on2062d.outbound.protection.outlook.com ([2a01:111:f400:7e89::62d] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pa73c-007f8J-Au
	for linux-nvme@lists.infradead.org; Thu, 09 Mar 2023 03:35:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNHi2ga0NhlKywX+CRsgKROTj04MVCMLtTOGji9EU4mB8GZ1OCCSlp0A5ObLzHhe5AlCamqi3Wf5mewO1HGlh5i0bTiPp6vN5hZEwa6Pnb88aefDiioiiUsR6QYlgdi/8ZFGn6ppFvYW5WSORAIf4EIq4IocFBLVlABYEsI+lGnbzasvo0wW29orHiKt7c1hLNPBmhfNbOOxoNwYKuMmtykAOVTd5lFT1wFxsOxX0N6fgkgab+Sc23Wce+2pHnbYFFg+Ltb7fDmCiH3mO3dMNSzRn17UGlNdHXLvEAzymUZk2jlhJ9I9Ya+EaDzOE8aZICb2WId7o0HhB41EK/wVBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hjFu4xp7MOPQEJczwWDhFom07bt70avJjY1+bipa48=;
 b=nn6c+DWbCjOpLERutnozRV4efk/nRcYm0yBI1yHALWK/rFpvHtp8F3ygg78MyeldjmR9d/kNh07UFSPQgjHI4FFffKDALnCavN5kts51IJsM9DmLFdb8t5VycihX/07YaBxzMtti+l4itqAmqZ9orerfMidXK5ljfmxabZnUt9l3d/kadZn+SOzAlPEKgfjuiMxu4ETwmLpu9HeUw0zKpK958hqSIKaUMuc5GvQhkGXfrKg8/LfMnAP17bckuZCMutEfC/3j7hU92i4lDi9/iXGig4rYvg/TLqCF2MG87cyPb2JK9SyLUA+M9bC2P8zBjQ39yH5soMZm4VEf+3DJ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4hjFu4xp7MOPQEJczwWDhFom07bt70avJjY1+bipa48=;
 b=Dra1N2KD+Q76VYDBx4/hefiZQBbN16U3P5diUwkzQVXPKo5OllD0/mBGzB+bXI/f+yRAgLeC+StJRM/h4DzMLTiV0HNugRoYK97OTEXrdmwNA0zkHjGOMI644mYudyKiNdf9EStjYIFar93j+n23SuA/kEl2cuwodu/ntx+7B7YuPluZgJhpjnrMy18sw/e/3CoFegIjyGZYJwsWbZmZ7rl5rJo47JktajU+NHmsrllyeShqsJhoW8pQ9noHElFzX9OStngWg+4O/rcfm/PU/7gXjQwukjS808vaISu8QkgPYz8m7A6xUNKrYofvl2yvKQ4eigIGnGYNQF6ziwpRww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3189.namprd12.prod.outlook.com (2603:10b6:a03:134::11)
 by IA0PR12MB8645.namprd12.prod.outlook.com (2603:10b6:208:48f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Thu, 9 Mar
 2023 03:35:02 +0000
Received: from BYAPR12MB3189.namprd12.prod.outlook.com
 ([fe80::c4b1:77a1:8e6b:841d]) by BYAPR12MB3189.namprd12.prod.outlook.com
 ([fe80::c4b1:77a1:8e6b:841d%5]) with mapi id 15.20.6156.029; Thu, 9 Mar 2023
 03:35:02 +0000
Message-ID: <bcbd48b5-1d6e-8fe3-d6a0-cb341e5c34e3@nvidia.com>
Date: Wed, 8 Mar 2023 19:34:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: nvme-pci: Disabling device after reset failure: -5 occurs while
 AER recovery
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 kbusch@kernel.org, bhelgaas@google.com
References: <de1b20e5-ded1-0aae-2221-f5d470d91015@nvidia.com>
 <93c02cfa-c379-49bb-9d32-af4cb7420f81@grimberg.me>
From: Tushar Dave <tdave@nvidia.com>
In-Reply-To: <93c02cfa-c379-49bb-9d32-af4cb7420f81@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW2PR2101CA0014.namprd21.prod.outlook.com
 (2603:10b6:302:1::27) To BYAPR12MB3189.namprd12.prod.outlook.com
 (2603:10b6:a03:134::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3189:EE_|IA0PR12MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e34f462-a452-48ce-211e-08db204f43d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	tz/9ZC/1zCq42MC4tvr6JtoVGDeobKZAExiM8C2F0pxvNe6umR/11ZDBH/18eD24tQCmGymFfStbM+eqEtte0+rUI0yrcpj0pKPjuuLYcc7WK+2Uvh1slltBiLnz7rvT/zSwf2PY6jtKR/AHQ8gEbmfvV4QdgC/xP8UsKwUAOQVc0fmXn30FbZMDFBaxAAsrgAUvxyb48t6Eicunx7OdNwbbO/cVRflzlQKUeHiQlEF5wBD2FW0NiRaRtYeT4O1j/9P9erClU1oG7hOvlLzVzBQ1iGMm8XHygxA+dS9X6IxRBh224QTKhKC8bEXvarpS8Mq0k94kaTyTbm1sN/8sJuq60WiWljIdXFre4JNBPPPgabiIFsLtmQfTuOh6QFaPfkF65yBXJZ7l+c49PVOtPVbwVdEJUn2l2L2PssbMq1HhBcZ8yazVyv5zIuQAZdJaaSpnZzxHhfAdcn3AhUd5hI0OVL5/oPVCe/gLn553MYitNsK41+YSXFRPxG28sTTf64lJdaREIK5t+vsnDU/XlgvudiWBsU86yBb9pFEmLgjp2xk8WFBYVr5NeQdlJTriM4/GzBzKM3kud9vknXGLUynJDCzqD4WFtQlxsDMKkSMTBVKVMqsFJQwJJDm8dgpW5RuhRfId7ZW/BYoV/XrRNhnic6NYGtPltNnPTBqYouNT+ICQg23Dwhd6lAJyEGhEymZx8Zrsvt1lFw82NfXDV+QaklELxhWveby/vmklewg=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(451199018)(6486002)(186003)(2906002)(38100700002)(66476007)(6666004)(66556008)(478600001)(26005)(5660300002)(41300700001)(30864003)(53546011)(8676002)(8936002)(66946007)(6506007)(2616005)(6512007)(316002)(36756003)(86362001)(83380400001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?c1lHaFRPOW5TelUvajNjczdaV2gvWW52OEtBd1NGZXVBNXdtdmVzeEIwK1hE?=
 =?utf-8?B?K0lLMHRvSDA3cWdVQytPbWNwYlg2ZGlCRHluRHZKRWxCdU5GSGJGSUg0dGlo?=
 =?utf-8?B?K0RrMTFaMUZidzFiSzZsTGRTR0EvQk9oVStML3VOc1JsZU5qMy9XemFpc0Zj?=
 =?utf-8?B?dDN4Zml3UDR6NlBBRyt3bkJzdmdMbFo3WTVNT0J0OGlaaGp3a054S2kzTDRi?=
 =?utf-8?B?TXNjSnZIbHlDWkQzRVR3NU85U05xUzlOSzgxeHhFS2VpZTdUekluVXlLSlJ4?=
 =?utf-8?B?dm5oQlJwRlUwdVlNdVo2REc4UVd2SkQ3YTE0ejQrUTBwRmovWUp4ekdGQXBW?=
 =?utf-8?B?ZzZ6WnBEVjF5VVhHNjdlWjFXU0ErUlJtNzl1TitvM1BzN1lNNTUwaEpEek9k?=
 =?utf-8?B?VFhTY0xlanl4TGQ2NnE1azhqTmFsSVdKVElPYURGb1dqQTBUSXFiWkFNd2Fx?=
 =?utf-8?B?eXd5VzkyNmV5ZkdmSUVzUkoxMmZxWlNJYnNRVzR0U0NpTmtIb3JORGRQbGtT?=
 =?utf-8?B?VEJGNjVwaDZESXBJdGQ1SjRCTTd0UUtQbDFYcmIvbENESFlKQ2FXWldDQzAv?=
 =?utf-8?B?Vnd6eEVLaHU1bHd3ODhiTEZ2bytmalgxZUVvc1NUVm4yVk43ZzROTllGcVdW?=
 =?utf-8?B?ek5aMmwxdExmWUN6U3ROa0Q2NzdNa0tzYWplZysrRTZtZFk0TzNSVzdBSVdU?=
 =?utf-8?B?aHVXVVdZaU1uc0ZTYUFYSDBvOVJ1T3lqMS9pdWVlMDRkckZvNHRWZHVEUnFQ?=
 =?utf-8?B?aUFxYlZwUGUwclJ4NUpIcng5REN3eS95UEtSVExPWDJTYnp4djJnTWlab01Z?=
 =?utf-8?B?UUVLUFYrcUxJemJibFVRWk1HbzkxdjUxWFJCR3NSUGZZQVZ0OVcrK3dVTjZs?=
 =?utf-8?B?UVVwTTVkOFVsQm03aFEwMk1LRDhWbzBaelVQYUQ5YW1qb0hyRGxEQkZoWWlS?=
 =?utf-8?B?YytFTm9ZbXFTbzRRWjdjYlZDdlJ1YXRyV2hiOVFFMEgwYWxWRG9ydVZIMjlD?=
 =?utf-8?B?VWFSSjdFTlhwcWRxanhDeUlvZGRqQTVSZU5BQUJ1MjVjREZSRWdpTXlJYnBH?=
 =?utf-8?B?NGZRVFFkOGJicXVtdDJ4bWJNZGRzT2hDaEZCVTFDUnU1RzQzZTZnVloyNlE5?=
 =?utf-8?B?VkF6Myt2eG9uVEpuNTBjVmdvaTBiNjZ1VUpvVjc3cTFwSVRiWnpZOVRlNnpX?=
 =?utf-8?B?a3pBZkk4SDBuenBod2pzRm5jR25vRlB0YmxoSzVFaWtLVjdLRk9lWmN1Q0VN?=
 =?utf-8?B?WTZhcWxleE1DV0lpaXNLa2lGdml4bHc5VjgreEo1ekVVZUUxNFJ3Wkx4WGY0?=
 =?utf-8?B?RWoyRTVxOWFZVmFZczFTQ1YrRG5LajBFRjAzTWpaVWNIT1lGR2J5dFlOSXRX?=
 =?utf-8?B?Qy9jRC9oUUxXYi9WbmdYZW5BckloSGJBakZXUnM5MFdpMWJ5TGx4b01vbThN?=
 =?utf-8?B?VmwzZGlsd3dnZG5JOGtrek94OUFUWkg3TDN6VmJ1Zlk0MWxQZ2NnSjlUQURv?=
 =?utf-8?B?elBrU1pQckZhd1FsQkFRUDAwam5XTkJFTmUxWW1mNE5zOEF4OFpvbUcrK25R?=
 =?utf-8?B?RWtRVHAzMW5DaEF1OEcwM2lPelN3QmhGY0gyM2RmWHAvanh3dXdhZXE0YzVu?=
 =?utf-8?B?YmZMOG83NlNKVjdFazZzNFVITjkwaFlvakpXWVUwTkkrNHgvVzd6aUlleGpS?=
 =?utf-8?B?K3Z3ZFIyTmJZOEdYTHRscjhITGkrRTJUbjJPU2YyOTNROTFSck1FeUN5Z3p1?=
 =?utf-8?B?OHBvY2F4akZ4ZkNKcjgrTXBVWWlkRy9QeDlyWnVoRlRFN09vaTY2YlUvSWtk?=
 =?utf-8?B?Y0tFcWVFc2Q2OWkzdmZRUCtIUFMwcitwTnprc3o1aVRBODNJRVJNSm9IQzF4?=
 =?utf-8?B?QTZVN042cDVuWW52OEdwdStIdDFnYmpqNkdjdTliU0JSWXFkRTZsT3J1eS83?=
 =?utf-8?B?YzN3OGVMRmJZRDRGdXJzaGprUFFYUDVWNFZuelkrcXlwNjJnRU1iNmlndXRG?=
 =?utf-8?B?bENEVDducXBobUZ1L25SUzZZNzV0Q1lsYm43U1Jtc0NmSUFEVDR6OUlnTHVq?=
 =?utf-8?B?bXRpbldaTTd6OVZvZitNOWVhV0pCWlJ6NEhwWGF5NVJNeVduYTZ4WjdSZmtH?=
 =?utf-8?Q?CVDf5IBwz4GZmdiU3YDgv/qMJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e34f462-a452-48ce-211e-08db204f43d8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2023 03:35:01.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5sl5cJZ0cQd/Bjchrp2Kl72wiiF0lAn2LetYIafqDDh4FKlAOF5pkwYzRpfDPwQ9gqyrcuvzzLABsfFac/d3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8645
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230308_193508_758321_C8042753 
X-CRM114-Status: GOOD (  16.44  )
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



On 3/7/23 03:59, Sagi Grimberg wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 3/2/23 02:09, Tushar Dave wrote:
>> Hi,
>>
>> We are observing NVMe device disabled due to reset failure after
>> injecting Malformed TLP. DPC/AER recovery succeed but NVMe fails.
>> I tried this on 2 different system and it is 100% reproducible with 6.2
>> kernel.
>>
>> On my system, Samsung NVMe SSD Controller PM173X is directly behind the
>> Broadcom PCIe Switch Downstream Port.
>> MalformedTLP is injected by changing MaxPayload Size(MPS) of PCIe switch
>> to 128B (keeping NVMe device MPS 512B).
>>
>> e.g.
>> # change MPS of PCIe switch (a9:10.0)
>> $ setpci -v -s a9:10.0 cap_exp+0x8.w
>> 0000:a9:10.0 (cap 10 @68) @70 = 0857
>> $ setpci -v -s a9:10.0 cap_exp+0x8.w=0x0817
>> 0000:a9:10.0 (cap 10 @68) @70 0817
>> $ lspci -s a9:10.0 -vvv | grep -w DevCtl -A 2
>>          DevCtl:    CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
>>              RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>>              MaxPayload 128 bytes, MaxReadReq 128 bytes
>>
>> # run some traffic on nvme (ab:00.0)
>> $ dd if=/dev/nvme0n1 of=/tmp/test bs=4K
>> dd: error reading '/dev/nvme0n1': Input/output error
>> 2+0 records in
>> 2+0 records out
>> 8192 bytes (8.2 kB, 8.0 KiB) copied, 0.0115304 s, 710 kB/s
>>
>> #kernel log:
>> [  163.034889] pcieport 0000:a5:01.0: EDR: EDR event received
>> [  163.041671] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
>> [  163.049071] pcieport 0000:a9:10.0: DPC: containment event,
>> status:0x2009 source:0x0000
>> [  163.058014] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error
>> detected
>> [  163.066081] pcieport 0000:a9:10.0: PCIe Bus Error:
>> severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
>> [  163.078151] pcieport 0000:a9:10.0:   device [1000:c030] error
>> status/mask=00040000/00180000
>> [  163.087613] pcieport 0000:a9:10.0:    [18] MalfTLP
>> (First)
>> [  163.095281] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080
>> ab0000ff 00000001 d1fd0000
>> [  163.104517] pcieport 0000:a9:10.0: AER: broadcast error_detected message
>> [  163.112095] nvme nvme0: frozen state error detected, reset controller
>> [  163.150716] nvme0c0n1: I/O Cmd(0x2) @ LBA 16, 32 blocks, I/O Error
>> (sct 0x3 / sc 0x71)
>> [  163.159802] I/O error, dev nvme0c0n1, sector 16 op 0x0:(READ) flags
>> 0x4080700 phys_seg 4 prio class 2
>> [  163.383661] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
>> [  163.390895] nvme nvme0: restart after slot reset
>> [  163.396230] nvme 0000:ab:00.0: restoring config space at offset 0x3c
>> (was 0x100, writing 0x1ff)
>> [  163.406079] nvme 0000:ab:00.0: restoring config space at offset 0x30
>> (was 0x0, writing 0xe0600000)
>> [  163.416212] nvme 0000:ab:00.0: restoring config space at offset 0x10
>> (was 0x4, writing 0xe0710004)
>> [  163.426326] nvme 0000:ab:00.0: restoring config space at offset 0xc
>> (was 0x0, writing 0x8)
>> [  163.435666] nvme 0000:ab:00.0: restoring config space at offset 0x4
>> (was 0x100000, writing 0x100546)
>> [  163.446026] pcieport 0000:a9:10.0: AER: broadcast resume message
>> [  163.468311] nvme 0000:ab:00.0: saving config space at offset 0x0
>> (reading 0xa824144d)
>> [  163.477209] nvme 0000:ab:00.0: saving config space at offset 0x4
>> (reading 0x100546)
>> [  163.485876] nvme 0000:ab:00.0: saving config space at offset 0x8
>> (reading 0x1080200)
>> [  163.495399] nvme 0000:ab:00.0: saving config space at offset 0xc
>> (reading 0x8)
>> [  163.504149] nvme 0000:ab:00.0: saving config space at offset 0x10
>> (reading 0xe0710004)
>> [  163.513596] nvme 0000:ab:00.0: saving config space at offset 0x14
>> (reading 0x0)
>> [  163.522310] nvme 0000:ab:00.0: saving config space at offset 0x18
>> (reading 0x0)
>> [  163.531013] nvme 0000:ab:00.0: saving config space at offset 0x1c
>> (reading 0x0)
>> [  163.539704] nvme 0000:ab:00.0: saving config space at offset 0x20
>> (reading 0x0)
>> [  163.548353] nvme 0000:ab:00.0: saving config space at offset 0x24
>> (reading 0x0)
>> [  163.556983] nvme 0000:ab:00.0: saving config space at offset 0x28
>> (reading 0x0)
>> [  163.565615] nvme 0000:ab:00.0: saving config space at offset 0x2c
>> (reading 0xa80a144d)
>> [  163.574899] nvme 0000:ab:00.0: saving config space at offset 0x30
>> (reading 0xe0600000)
>> [  163.584215] nvme 0000:ab:00.0: saving config space at offset 0x34
>> (reading 0x40)
>> [  163.592941] nvme 0000:ab:00.0: saving config space at offset 0x38
>> (reading 0x0)
>> [  163.601554] nvme 0000:ab:00.0: saving config space at offset 0x3c
>> (reading 0x1ff)
>> [  210.089132] block nvme0n1: no usable path - requeuing I/O
>> [  223.776595] nvme nvme0: I/O 18 QID 0 timeout, disable controller
>> [  223.825236] nvme nvme0: Identify Controller failed (-4)
>> [  223.832145] nvme nvme0: Disabling device after reset failure: -5
> 
> At this point the device is not going to recover.
Yes, I agree.

I looked little bit more and found that nvme reset failure and second DPC, both 
were due to nvme_slot_reset() restoring MPS as part of pci_restore_state().

AFAICT, after the first DPC event occurs, nvme device MPS gets changed to 
_default_ value 128B (this is likely due to DPC link retraining). However as 
part of software AER recovery, nvme_slot_reset() restores device state, and that 
brings the nvme device MPS back to 512B. (MPS of PCIe switch a9:10.0 still 
remains at 128B).

At this point when nvme_reset_ctrl->nvme_reset_work() tries to enable the 
device, malformedTLP again getting generated and that causes second DPC, makes 
NVMe controller reset to fail as well.

Here is the log where I am dumping DEVCTL register of NVMe device in 
nvme_slot_reset() _before_ and _after_ the function pci_restore_state().

e.g.
[ 1037.601409] pcieport 0000:a5:01.0: EDR: EDR event received
[ 1037.608140] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
[ 1037.615534] pcieport 0000:a9:10.0: DPC: containment event, status:0x2009 
source:0x0000
[ 1037.624477] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error detected
[ 1037.632549] pcieport 0000:a9:10.0: PCIe Bus Error: severity=Uncorrected 
(Fatal), type=Transaction Layer, (Receiver ID)
[ 1037.644654] pcieport 0000:a9:10.0:   device [1000:c030] error 
status/mask=00040000/00180000
[ 1037.654084] pcieport 0000:a9:10.0:    [18] MalfTLP                (First)
[ 1037.661755] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080 ab0000ff 
00000001 48046000
[ 1037.671001] pcieport 0000:a9:10.0: AER: broadcast error_detected message
[ 1037.678587] nvme nvme0: frozen state error detected, reset controller
[ 1037.719590] nvme0c0n1: I/O Cmd(0x2) @ LBA 16, 32 blocks, I/O Error (sct 0x3 / 
sc 0x71)
[ 1037.728673] I/O error, dev nvme0c0n1, sector 16 op 0x0:(READ) flags 0x4080700 
phys_seg 4 prio class 2
[ 1037.952257] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
[ 1037.959479] nvme nvme0: restart after slot reset
[ 1037.965882] nvme 0000:ab:00.0: nvme_slot_reset: before pci_restore_state 
DEVCTL: 0x2910 <<<<<<<<<<<<<
[ 1037.975846] nvme 0000:ab:00.0: restoring config space at offset 0x3c (was 
0x100, writing 0x1ff)
[ 1037.986313] nvme 0000:ab:00.0: restoring config space at offset 0x30 (was 
0x0, writing 0xe0600000)
[ 1037.996955] nvme 0000:ab:00.0: restoring config space at offset 0x10 (was 
0x4, writing 0xe0710004)
[ 1038.007523] nvme 0000:ab:00.0: restoring config space at offset 0xc (was 0x0, 
writing 0x8)
[ 1038.017312] nvme 0000:ab:00.0: restoring config space at offset 0x4 (was 
0x100000, writing 0x100546)
[ 1038.028111] nvme 0000:ab:00.0: nvme_slot_reset: after pci_restore_state, 
DEVCTL: 0x5957  <<<<<<<<<<<<<<
[ 1038.037582] pcieport 0000:a9:10.0: AER: broadcast resume message
[ 1038.076807] nvme 0000:ab:00.0: saving config space at offset 0x0 (reading 
0xa824144d)
  0x40)
...
..
.
[ 1038.202291] nvme 0000:ab:00.0: saving config space at offset 0x38 (reading 0x0)
[ 1038.210885] nvme 0000:ab:00.0: saving config space at offset 0x3c (reading 0x1ff)
[ 1055.325069] block nvme0n1: no usable path - requeuing I/O
[ 1100.113066] nvme nvme0: I/O 21 QID 0 timeout, disable controller
[ 1100.169808] nvme nvme0: Identify Controller failed (-4)
[ 1100.176623] nvme nvme0: Disabling device after reset failure: -5
...
..

followed by second DPC..


-Tushar

> 
> 
>> [  223.876833] Buffer I/O error on dev nvme0n1, logical block 2, async
>> page read
>> [  223.876939] pcieport 0000:a9:10.0: AER: device recovery successful
>> [  223.893404] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
>> [  223.901469] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80
>> [  223.938902] pcieport 0000:a5:01.0: EDR: EDR event received
>> [  223.946077] pcieport 0000:a5:01.0: EDR: Reported EDR dev: 0000:a9:10.0
>> [  223.953901] pcieport 0000:a9:10.0: DPC: containment event,
>> status:0x2009 source:0x0000
>> [  223.963243] pcieport 0000:a9:10.0: DPC: unmasked uncorrectable error
>> detected
>> [  223.971691] pcieport 0000:a9:10.0: PCIe Bus Error:
>> severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
>> [  223.984144] pcieport 0000:a9:10.0:   device [1000:c030] error
>> status/mask=00040000/00180000
>> [  223.993966] pcieport 0000:a9:10.0:    [18] MalfTLP
>> (First)
>> [  224.002023] pcieport 0000:a9:10.0: AER:   TLP Header: 60000080
>> ab0000ff 00000001 1e659000
>> [  224.011644] pcieport 0000:a9:10.0: AER: broadcast error_detected message
>> [  224.019604] nvme nvme0: frozen state error detected, reset controller
>> [  224.236597] pcieport 0000:a9:10.0: AER: broadcast slot_reset message
>> [  224.244676] nvme nvme0: restart after slot reset
>> [  224.250584] nvme 0000:ab:00.0: restoring config space at offset 0x3c
>> (was 0x100, writing 0x1ff)
>> [  224.260945] nvme 0000:ab:00.0: restoring config space at offset 0x30
>> (was 0x0, writing 0xe0600000)
>> [  224.271460] nvme 0000:ab:00.0: restoring config space at offset 0x10
>> (was 0x4, writing 0xe0710004)
>> [  224.282012] nvme 0000:ab:00.0: restoring config space at offset 0xc
>> (was 0x0, writing 0x8)
>> [  224.291713] nvme 0000:ab:00.0: restoring config space at offset 0x4
>> (was 0x100000, writing 0x100546)
>> [  224.302430] pcieport 0000:a9:10.0: AER: broadcast resume message
>> [  224.309618] pcieport 0000:a9:10.0: AER: device recovery successful
>> [  224.316968] pcieport 0000:a9:10.0: EDR: DPC port successfully recovered
>> [  224.324865] pcieport 0000:a5:01.0: EDR: Status for 0000:a9:10.0: 0x80
>>
>> After test, NVMe device still shows up in lspci and I can read pcie
>> config space but cannot read/write from/to the nvme controller.
>>
>> I am trying to narrow down but would appreciate help from linux-nvme.
> 
> The issue is that during the reset the controller failed to identify
> the controller, due to a second failure. The nvme controller does not
> know how to handle that.


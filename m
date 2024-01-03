Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28834C3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 22:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0zq3SJH8HRlYaAn5ai7z5P946MSdOB6SEdLd5gWF84c=; b=dtztTipb7twgDujwzCE3RarLdD
	dGo9ac1l6jwpdFnM1eq2DnsH3cOYLXfRf/58E7W3/o9wF8wsLYdxeD0SRZZxdzDXQQFuPFTNv/Z5a
	dJuzEe0WjsNGMrcrZJqcz1Dy5Gxc6fYvQpDu8//pE7zN9kmukvoNE7DzLwPsqc9XEoLN1FcaMPaD+
	LYZwm4Y2DLQ6Z0mqBJckKe22t0S8U0/5UxZnIix9yK0qfeVKtq3Fu6uN84qP/T7XHVSSy7KqiJdNO
	r5dzntiB5+mhg2AgqWhFfiX+e2XhVS1CjnLx848+sAsIxzPak0GYhVXj4GoOreRbMalz56162PNnF
	GD+2hpFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rL9wo-00CJVn-1y;
	Wed, 03 Jan 2024 22:42:50 +0000
Received: from mail-bn8nam12on20620.outbound.protection.outlook.com ([2a01:111:f400:fe5b::620] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rL9wl-00CJUB-22
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 22:42:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9zp5ZRrMqTugchk2iuPOCZDwQWG5p4LZskxHLqpCLxoUqq/SSDcwXUCnOBLI110Tgrelihr/0YHTk3lvpiveSUi2Js/UX5VTnM1fh4u4n4KIsxkBrFmfN8WEBGGNlDzMl6eicCOVVPGTIPUDI6FYNAOmANmeCGSOHFmcFRCjwlcd8zzUgz2XdN0mENUn7eudZSo/0wSdhOzysKWMMF7+fMHbtMycptnHrS1aAW206vujcYzMXKokd0a64tOJnSQoctMEzflzY16Klkfj1jKXv0X/XD2eZ4ZdTgW4eHDTmU6/ZULUQtmQO4VxnlcNTchdPNrLIshKsvG7xVqmWhQ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zq3SJH8HRlYaAn5ai7z5P946MSdOB6SEdLd5gWF84c=;
 b=AqPq/7yol9voV2TdI0dVN6g3RCS4M/xhgwDtWNsps1ssil0e2xs15IPQ1T4SY5fD3yHZ6kHhG8ESxxa44+z4gjxeF4UemxcQsjseezZli2hED4KF7HHjx+5gfS2ewXegjvoAERfegHDK9YND0vdjztc72gmnn7V14EGpeuDmv1Hw9Z7V3bikbJXdCwvGV330F2vVLajs2d87VBNULkZBd5224rTYNYfKz9rAT3X7IrwH+tKGqSk94bhVQmh95h4UN/aXEbwhECi56+7LF1de2WqzOnHse7N5oh9bzvGFotfgydhTBhu+XTHOQLhysookF7r2vnhU6VrA92TPfG9pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zq3SJH8HRlYaAn5ai7z5P946MSdOB6SEdLd5gWF84c=;
 b=Zon9YNu7stdrFiNLI8S2Aq0Rtp9G+yaRjja0x6sRwi6U0xlGKEF/c7ygFMVgBtRPmrobckTirvbxZCt2y2i58w7UrJsCy/7TjUFXxLzUm/G9Mpp1SGTDhajvJLolX+cx36SArfg+j6zlnQGLJtIXu716/inhXTw0BkBsSIp1vQ5Osjr/S178aGP7WkFcSB1HgvkAS1h1qVAn5CucxAhycn3RJi9Z+vcVdnf+lU72dDJYfLpiKqMY03QklAhvCgL9JcVM/Wq8y21PuXVbFCGWOqCzVOaYkGtGlUpXAahJjMJAog351onPuMrlWpyNgCeR5zdLPqIC/2DYVfw3zmRouw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SN7PR12MB6766.namprd12.prod.outlook.com (2603:10b6:806:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 22:42:36 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6f3c:cedb:bf1e:7504%4]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 22:42:36 +0000
Message-ID: <08b1645f-b4bf-4e76-8d7d-867e88f9a240@nvidia.com>
Date: Thu, 4 Jan 2024 00:42:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] nvmet-rdma: set max_queue_size for RDMA transport
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-11-mgurtovoy@nvidia.com>
 <1493ff9c-f9f5-4c54-96c5-92eddeb85516@grimberg.me>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <1493ff9c-f9f5-4c54-96c5-92eddeb85516@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0394.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::22) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SN7PR12MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 40bc9c64-92b1-4d7a-6131-08dc0cad482e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: asC5ITaKwGufUcD0obzwIZzeBxPMV/xwwBMRvBkN2jbruFS7/q11+MMSDva7wpyFiyt0wXWBGXAni/Vkwkkdw4DNKk7kAKiJ1zyHQkjl+J1KvbD3i4cc1Bsw7CMAOgsQi43c5OS+Shn6e859Sp+p2ty78JNCR/qHoJ6dpX/avlR+SrCW25Q0cB3X4cZPLH/MBiUmbe+nS5xy6fnq7hxKW7Ee/aph6u3dipteRmHw9bwInxKu8F8qGXgihqcc+3ADL9D1cm6hSzFe4e8DaEHCaRo3QI4gSxhZ6AIyPRlHQQxz10bRc9/QfQP9mwjplPLG8T9eaBnISyWASn5shCptKzAKDyR9u2apVjQ8R5p26I08mKCHSIyUnGplNynuuV+z6+KakdU5b2FNWa8LrGX+NpFRWDjRF4TkBQZR/TBaHTeQrgckrpV2UBPJVAkmnMyW922P+5h5oNOUmXR0T/EQWNIsF/1wJbcZ/u157VSr/NalAvR8SSNeuiB9QaMeLeGORepXNxYe2jYLbq/RkGXY0u93RwtqLv4EI2hRZw/tC/ve0t47YGJVd9e4hcFWIGMb5QMufqwWu/sRgf8ndz/ElI4JzdMFq2vdUXAS/DgjA/gTrwDph4nskk5znpZKYw1gcbfCt+EcCfjABm93DmOMpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(36756003)(31686004)(6486002)(53546011)(6506007)(66476007)(6666004)(6512007)(66946007)(86362001)(31696002)(66556008)(38100700002)(26005)(2616005)(2906002)(107886003)(83380400001)(4326008)(41300700001)(5660300002)(478600001)(8676002)(316002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UURWakNiTUY1alpwMXFEMFV2aHRBeUE2Vkt2THF3WFZnSGh2K0U1VlJxMVhr?=
 =?utf-8?B?TjVaZFljZnl2WTRYbDBPVi95MStDYVM0NWpNV2ErbUVrMTVjSE0zcU8rS1Zr?=
 =?utf-8?B?dGhJeS9INmVUNm9MOUlZU2NWcnppa29BaVJqd1dDUDVxVjFFV29NRHFYUkdT?=
 =?utf-8?B?TVNxVGM3Z0VUOXpiMVNiYjY5d3lYaWowVTVtRkhubnpRemV0eG1JV1crQSt2?=
 =?utf-8?B?NEFwYWhXR3NVbkhVcjNoamx3MmVEWGY5Ti9GbExzSHpaT0hiUnFpbWhOT1Br?=
 =?utf-8?B?RmQxckhmN1ZuL3ZqTFVveTdacDBtTmh2bk9NaFg5Tmk3RENNVlhKUXFCcmJl?=
 =?utf-8?B?NUNqN0Q4Q2RNRlJUUCtrbkdGc0VwekFvbGxkbS9lZTlRTU8xa21mNGNqcTVY?=
 =?utf-8?B?MVZHaXRVMG5FblRxZC9QaXdWbyt5NUppcnJ6dmRITXc1Wm9KTXEvekZUbkJD?=
 =?utf-8?B?aUZjdU41OUdoYU9NSzY2UURPTTV2RW1EUCsxQUw4NG50L0g2bjczT2gxZ09m?=
 =?utf-8?B?Z2prODJUYlVUbVE5SXVYSFZEV1Y2cjcvRXRFR3h3WVdXN1Z0STJhdjhLRStM?=
 =?utf-8?B?WGZyZGlxcXJOdGFHUTMxS0d3MVdxTmxHM2Q3Nk0xZyttMlVLWFg5alhZZ1hl?=
 =?utf-8?B?enAwYmg3QkFHWm82WTdGajA3NXZKZ2dORndOcXk1NVhvZmF5SkhMSjl4aUxE?=
 =?utf-8?B?aDBPSjM2SUtmeXRqbGZoWU5hY2N2UW5KekxpdnNJZFhBMW9oU2hGSVZSK3Ns?=
 =?utf-8?B?cmp3S3lrUTdiRHY0YXJudDlXSnpiQ1puZXZTU3lyNzZoczZ3MG8rWFpCdkV0?=
 =?utf-8?B?YStMVWtKRmdTdTlHZnllSm5WSHRwZS9SWUhvaHAyNWNtclNMNGs1S3ZPeGdK?=
 =?utf-8?B?eC9NWE41Ny8vNVRaVDBMbElVOEQwdjE3QTh0dGlybE9oVmhuamRhQmtDc2Ir?=
 =?utf-8?B?dXJKOUVkejYxSWZxSE5yajJnWkZoNFlhR05rY1FHZFgwVFNldnBGazg4d2V0?=
 =?utf-8?B?N243dnpDZEc2OVB5Z3U1SGdEWDBpS0ZWaGwyYlF1Ykwzai8yaW5QaTVDS0NJ?=
 =?utf-8?B?MlNta2t3MUlJWHlSRFNqamYvSEpTbEhSaExHeEpyTUJsL25wUWRtbngveTZj?=
 =?utf-8?B?RmQrSTNhY1RoR3I2SFNhVDRLbTJNdzR2aDVDeUF6UFJWYmxmWGhVM0RrMU9Z?=
 =?utf-8?B?UjdZZU9qUE9zSGFTM3lqeTBmM3MvNXQ2VHAyTkM0bWF3MG11MWFVWGU4Yklj?=
 =?utf-8?B?NC9QeFhmVmtNZlF4OVMxNzR6bUVPN2U5a2VsT2hpeWs2L2dhVm4vZ2xDckhV?=
 =?utf-8?B?R01yQ1ZNUVdGNjNxOHJOSUxrVnAyUVR3d2VFVmhGU2xWaVdMbnNacWFKVXNK?=
 =?utf-8?B?T3BsNHd4blJycTFZZjBkZnNMUG1RTGp2VXhVOS90QmJvd1NJNmZOd0d0ZEtk?=
 =?utf-8?B?clhoSERNblg4VzZrMHFDM1N2T3RSOE9EeUZqSWIyQys2THBhd3NBd21kOTlO?=
 =?utf-8?B?dlVwbGJZMmkxQTNUcDgrZzB3emFDN2ZnR1RjRjhZaENUN0ZUY3BKbXlaWmNa?=
 =?utf-8?B?Q3BYN1pOVlhnVE9jTG4zZUhDZVM5a0dMbGZIRVVkT1JDZ1l0RkoreVFhVnlT?=
 =?utf-8?B?djkrWUJLb281OGxzZENhNXF1WXAzaUlwNlVzNWQxOGZ5MnRQNTZ6TEFTR0gv?=
 =?utf-8?B?QmlTK3NudkVyRjNVUkJSTEpydy9Ua25qVmcvekMya0hLdi9NaEpHWmp6dGUz?=
 =?utf-8?B?cXRnOXlvakU2YlkwV0c0U0ZQVE1mVk9GenVnRGd2TzlNZjJGbXZjVlZFN0hP?=
 =?utf-8?B?WW1EUEd1UWdUUWF4Q3BmRWFnSzVOUDBIc2FIajdlUU1VWmFscUNZVlB3dHdz?=
 =?utf-8?B?SDVQdFFYQXlTenRTQ25jZ29sZDAyUHhIU2oycFVaT09zaHFVcEFldVBNRXhI?=
 =?utf-8?B?Szc5bXR0a3pES0pNblpHTWRMNkNtczBXU0xxNXoyODBOOHNPb0ttbldKSnBK?=
 =?utf-8?B?TFNDWlNsMmV0M0JhV2JhcXJtZTdWOVR4Q1VaYWd4SzVTZStRY0Y3LzJBKzVB?=
 =?utf-8?B?aG1qQ1JEOExZS25oTlpNZTdZRndISUtUU2MrVFVTVU1uQy9WdktqRlVTOXZz?=
 =?utf-8?Q?qS6/1TT0G8QKrt6sxw7rFaE0e?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bc9c64-92b1-4d7a-6131-08dc0cad482e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 22:42:36.2760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GVoxzmfulAFrib8rCcffNN4T6xCKzSvVTFWcDKwnTKKF8Nd8jk62TcYnGS76sw8yYXf0vksZAyC+bd0Sz6B7jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6766
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_144247_672141_A53D9EC5 
X-CRM114-Status: GOOD (  17.10  )
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



On 01/01/2024 11:39, Sagi Grimberg wrote:
> 
>> A new port configuration was added to set max_queue_size. Clamp user
>> configuration to RDMA transport limits.
>>
>> Increase the maximal queue size of RDMA controllers from 128 to 256
>> (the default size stays 128 same as before).
>>
>> Reviewed-by: Israel Rukshin <israelr@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>> ---
>>   drivers/nvme/target/rdma.c | 8 ++++++++
>>   include/linux/nvme-rdma.h  | 3 ++-
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
>> index f298295c0b0f..3a3686efe008 100644
>> --- a/drivers/nvme/target/rdma.c
>> +++ b/drivers/nvme/target/rdma.c
>> @@ -1943,6 +1943,14 @@ static int nvmet_rdma_add_port(struct 
>> nvmet_port *nport)
>>           nport->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
>>       }
>> +    if (nport->max_queue_size < 0) {
>> +        nport->max_queue_size = NVME_RDMA_DEFAULT_QUEUE_SIZE;
>> +    } else if (nport->max_queue_size > NVME_RDMA_MAX_QUEUE_SIZE) {
>> +        pr_warn("max_queue_size %u is too large, reducing to %u\n",
>> +            nport->max_queue_size, NVME_RDMA_MAX_QUEUE_SIZE);
>> +        nport->max_queue_size = NVME_RDMA_MAX_QUEUE_SIZE;
>> +    }
>> +
> 
> Not sure its a good idea to tie the host and nvmet default values
> together.

It is already tied for RDMA. I don't see a reason to change it.
I will keep the other default values for fabrics separate, as it is 
today, following your review in other commits.
We can discuss it in a dedicated series since it is not related to the 
feature we would like to introduce here.


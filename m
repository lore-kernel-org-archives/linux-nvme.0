Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E826C28D13
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Aug 2022 15:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JoAMUkvjlLmYKE82lQNpTP5Y3vbpPcnm2OGDJTFVNZc=; b=A2agQ3ktZNsNZT7ApWR5btpD6f
	yzomzbwhmpDCddbIEcS/lEur+yjGRxIObu5yu2RcYPvzLvJuPpdq9fN6bxJzfI0ayphHITmKiwBJ7
	Yrm2n7O0IdIjVxgTMpLM4/u+Z4XLYUbE0A7H8HkWQlRMqV1c7FNqfenX9Rp97enHm0OSovlE6Co5G
	bv3zBd3wBYsGEzO+OzdsTUdEGGb4wbCJ3YbimhUCXDEnsZcNR2qQ6hNF5myykh8VyCLGLfn96vZvV
	Mgqtl8VhGr2bgrquBG2xpylLFI3bkEbL3ivV/LNmtzN7kO2SG47fUUcZhLlIN4YnxUkKv30oEegq1
	k0Cka+OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ9O0-00CDen-OB; Mon, 22 Aug 2022 15:30:44 +0000
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com ([40.107.92.75] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oQ9Nx-00CDcA-FS
	for linux-nvme@lists.infradead.org; Mon, 22 Aug 2022 15:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqKzlBjwLaTIfvDhSNsVidTagQ9v1fArq1jGMwRcVAX3Cb6XdiKMUoKI2LD4elQhKPctJ08pSUeMRiAa2s41u+iBOzifU/OswurSUsIGH2onpR2h2T+Vp1Ck3bfD5PDHok8qZqBW2qfGSP63uIfzhC2q/hJ6Xad4RKwOnZdFzlMDZxh1L7taLnl8krijgHOMrjhI5noXmEFnmt9hncHDWJjJ1f0YsJt5Yn1qgcA7H4uTQsL9ls45KT4QmkcYefTlc70rlJB12fiuOnraRY0uOzc1RBuk9tIhwlrmu3O09ghEatAZbLs5P9s7MZ7gN+VapBJlRhuhulc+Qg5kAxNeKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JoAMUkvjlLmYKE82lQNpTP5Y3vbpPcnm2OGDJTFVNZc=;
 b=jy/lo7CJ4AyIpyeuZBIHwFrjkP6uNrppFRGysBqkI0xU5j7sene5sK0dUfukQstsYN77TGf9akV0E7OoUIOUo+q+VUritGlsUCBZDvVSienkyxHePhwmf8PNDrhSc6Y11AeJAQuhx8RuR4YKL4iaQWFJtc2x9eotTA61K0t0FCRkowp5YQEUf/TonswgdI0kmsgcfwf9rI59OAuq4rTNOe9xOB/AItkz0zAhUGhDGWcEjHTj7Jgn2lO//AKgh/2VPK6yXx3sQhKDM9KqnbPAeI01c+KL/if0jiNyJxr91zHbUU2Yf0855i01C9vDje1RDdjSk5HRNsCyKKFYmDTG9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JoAMUkvjlLmYKE82lQNpTP5Y3vbpPcnm2OGDJTFVNZc=;
 b=ceAi6WdXlilarzETnF3yq+7cja46ijNZv+e8zciFP8tB3QuJPrAKORhYF4HnOEIUNMnWWIzDccEEbswCgeMlYYXhy4OlSh6/bb2waIIV7aSccyX9kJznvKsSioKC9hOrmilnOheiqFfXBgWf5pbhdgS1fIjQfqV47MKYPiAH7+nI+C4bt/IUZk0NlBeInsaEHRF/ug9R8a+UeUzZQkcfxOnGRJUNZ18gszyiu4ehsj46hcUkC2BRri7IS9LkRji03nmB4sTLACg+qk+0oBCnl/tHV4qdKOKIPE9BywHqB1UvqCAGm1D6bXNlBBtu/Ayg5pfYsLlYFQxmvLOXHODr1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM4PR12MB5327.namprd12.prod.outlook.com (2603:10b6:5:39e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 15:30:36 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::8481:5712:c1a7:f84]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::8481:5712:c1a7:f84%7]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:30:36 +0000
Message-ID: <86e9fc3b-aded-220d-1ee0-4d5928097104@nvidia.com>
Date: Mon, 22 Aug 2022 18:30:27 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] nvme-rdma: set ack timeout of RoCE to 262ms
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
References: <20220819075825.21231-1-lengchao@huawei.com>
 <20220821062016.GA26553@lst.de>
 <83992e8f-b18a-ccd3-e0ee-a5802043f161@huawei.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <83992e8f-b18a-ccd3-e0ee-a5802043f161@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0463.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::18) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60d89d32-95aa-4cb0-abda-08da8453428e
X-MS-TrafficTypeDiagnostic: DM4PR12MB5327:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	b/72OsCZP6/qXi5a3g9phCD5vEmZRcYq5TKlE8ICu5P963e9/vaQeJ7obWkTxrbkQ371htWGbNtEnvL529MZZRsHuVAkfhdLf6HAlTO46dO1plIhQNwQqRvyeYnizTiji8JvxqCzYCJO1Z9J2VHuoyyPyF9Bmur69iIAv8rMeyTQRch45alrBdk9qhecHBioHnF84SAIfpGH35R9pSoz3tQK3A6kmYjxTrRLCt9/UnHqofJPZ/928RRC71TTKtVavP62eSEnTgIjx7pzsOLLklpBeQI9pvKKgG/tQouJ361WNRlwwFuwwmZFJP/6zMXW1KEzwPMssD5Qjec+nI81yHKjRPgvInoLmialyabSZ1q5QHOojY+3mdQ+14npJe9IX/JAWC3IKeEODbPL+iBE+oo9o8BnSyQwuMzgcS0QrYgehSDT5rF1gBC3O1Em7v+p70W95hD0X4K27Se4wTZIAJdSvj4WMGp1MOYBoKbG3Z9tathbPY+FiQc+SdnPvGpQ5d3dgV11d8nUHb4XhMVuAGdnk0wawPUI0RksZMkrCexUqmmOj07MMbBlVJMT3NeOk41Cf600PXQa6NF/fFLTOhb+wlMTT/2VKbrFcVG3RAwyj5mcq6a/wvgTAsVuIgqaXOuXTn5aW2xNLuOPQBL99IIjsBUbS8rvld+xfC6eKrkXgM/iKX7tJEpf4mnRlCbCC8QQRctE+wQanZvqkpwjbObDigOaxNPQWUCJMU2WbTHDqARxMrjXWvILVMg7g+fRtMioI7MfdKiKrwYKvvCJ0Av6kYyc1u4T57c/1vTuPx0=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(396003)(346002)(136003)(376002)(41300700001)(6506007)(478600001)(6486002)(6666004)(186003)(8936002)(6512007)(26005)(53546011)(2616005)(2906002)(5660300002)(316002)(110136005)(66946007)(31696002)(66556008)(4326008)(8676002)(66476007)(38100700002)(86362001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?WjVWZTYvWXFDOWF4ODBhTXVWQnRzdXdmcmJLU01Fdms5c3Q0QTk2bXFjSkFB?=
 =?utf-8?B?YzNzL1dQVDV2OVZub0gzRThhcFY0TXpqME95RzhQVVJYWXlnN1dkZFBuVmxR?=
 =?utf-8?B?NE5xQmVER3lTT1hCN1cwckgyRWZtZ0R1OEtZSVM1dUhOQUFzVU04Z0VoU0xz?=
 =?utf-8?B?czViYUhmRUNybkZybU5JclhEZnB4aEsxVTdTaFdJeE4rWHc5Rmt4WWFoSllr?=
 =?utf-8?B?NU5nK1g0VGl6bDg0TlVMZm5XSlBmazJLOWhJTW1xVTAzMUVVUEdQeE9RdlJK?=
 =?utf-8?B?RUNLSzFCMEM0ZzFqMlU4SnZ0NHhUczNhSnNkYVFPdFNOSTlhY1ZCdDV2aUMw?=
 =?utf-8?B?cjEwaFlwU3Jubjgvb01DV3lQcjh1UHNRR3JKOXVQUTNvNDdvWkxueThONTBy?=
 =?utf-8?B?T29ZRERpMmpLVlkvM3l1NUVid0NVMjUvTXJmWFlVazJwenE1eUYwdzRpKzls?=
 =?utf-8?B?ZlhYYVpWZ2E1SU1USGxhOUlsMjZyMEJDeXZ2a0szNU50YnNuVmtSaW9rdEFG?=
 =?utf-8?B?em0rUEExeXB2SEZMSFJ3RHhlN1VhQXI2VUlwRUlNaHZTd1ZqdG9JeWlXZVFt?=
 =?utf-8?B?VUZ4RXQ2Z3RWaFBack45elhXZW8xVHhoSlpQT0NtSDdDdjhncmhPWXE2Sm5Y?=
 =?utf-8?B?K0JrZjhwVDRUbE9VMHlwK3crTC9EQUdIa1VRNE5PN1Q0WGhzdzRsU2wrMUJo?=
 =?utf-8?B?eTNuVVlYalU1TmFGb3Fmb1Rkc3hyTEU2TmRnOFZtNGZobnVwTGFia3JHSW45?=
 =?utf-8?B?Ty9laGkwK0x2YXNCL2JKWVFZWG9SOGdKN21WQlprdzdYNnRYQ1lpMXlKU0lW?=
 =?utf-8?B?R1NZczQwelV3SzlKU2psNitseHJLOVVrRVErT0hGNHdod3FQcFpvcGw2TnN5?=
 =?utf-8?B?Wm4rNk9Bb2dNbUJhN0VtTXRYdmcyNHBxVklIajY3S1Y5cmFKSzVsZE94c2dw?=
 =?utf-8?B?bmNXWHNWZWp3YVVSMUsrRHNvWlFvWXk4bzE5ZS9SdTFXZEtuRzZlOUR1VUxU?=
 =?utf-8?B?OHlWcWlXNUdBejdGanpNSnNMb2hXMUVBLzMzdldYbEhwK2FObU9lME1PcWsy?=
 =?utf-8?B?aEtaMzczdWwrSDAydWZpejgrWXFHUlQrWHFCNGJxVWlIQTgzZnJCMDI4T2Nj?=
 =?utf-8?B?RmpOdGMxbHNmRlgyeWh0V0xlVVlpRURPWm9ZQ2NOZmEra2doVTB5T0FZMDFF?=
 =?utf-8?B?WWl6L2w1YklybzFYdG5qUzdjcjFrNlRVN0szK051eC9HRnF3STZ2UWRyeExE?=
 =?utf-8?B?bFhqYm5wbHVzcFNKa1NDQXhSNVdXcUMxZ2ZNWWN1UGFQUndmNFBPVXpsWktS?=
 =?utf-8?B?eExCRGpqa2VJY0FPRExXZ0hnYndoNTBQYlAwNUhVVnJNQXhySjJRZFNGY0pI?=
 =?utf-8?B?NnY4djhmdEN1VjBvTyszT3l4QjZZTTBiL29pTlZPeU1SUFI5NEdGU1c0REs2?=
 =?utf-8?B?dVFGNnNjakZCMkdEVUNZUVVVU2FVTytFN3FIcktkaWFtRGpIKzdVME0wQVg4?=
 =?utf-8?B?TjZWbnB1S2RPNzB5M1BiVXZOT0pCbVZSVERFa2gwS3dQSnBkd1Q1ZS9pVFB0?=
 =?utf-8?B?ZUFUQndONkRyL1JrWnFzaytSak05eXprWklTUGtCRUNMc2NWaEFLWEFFd0FO?=
 =?utf-8?B?czhuaUVLdnRKZEo1UGc1eDZhRklMb00zMDBRTDBVeTZrWkpRNi9oVkExQmkv?=
 =?utf-8?B?VDY1TVV6eDBDdlFWWDhYdTJXU1ZoTjdEKzdXU2w4cFdMTjlKSXdUT0J6UXdL?=
 =?utf-8?B?b1EwNENQN0JMOGY4N0ozdWtsWkZnT0JnclNzOHp3Nzg2SnFYQ21tWlFtMCt5?=
 =?utf-8?B?akJWcmthUWY0RFNySGZpWm8xNGxDT0tVYUpjeHZBb1cvb3dSYWw3bmhQOU51?=
 =?utf-8?B?ek9SeURyWWFsVldtbHorMmw4eS9GVjZIK2QvQXJVUzBVNVFFVnZWQmVidk5h?=
 =?utf-8?B?L01rZFhJTitsRnBOZWpicVBETUJVOGZGNUxlOEl4eHlhSWJxdjZGb2dLcXgx?=
 =?utf-8?B?Rk1kRWhQbEwxbENVQThBR1d2Y2hmWkJDNEYzeFZ1V0taVGhlN3M1THJrNlVy?=
 =?utf-8?B?KzF3eE5CTzNJWWpxTUNGbVprSGxjTUtMUnp4aStmVDNFQzRoSXZLTEJDeG9O?=
 =?utf-8?B?SUVLS0MrU2pWUFBuQ2g3dnFmeE5VS3B0OWlORjRWSkRwMVhHSS9FVE45U21k?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60d89d32-95aa-4cb0-abda-08da8453428e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 15:30:36.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z95g/b7ABgbIqrJGq1pQM/OB8/guNjp5A51kEAB8mCJVIw/CxFSkoJAbjUB4wlYVrBluRWZYmCTvfanJpMJgSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5327
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220822_083041_938160_0D29F0E8 
X-CRM114-Status: GOOD (  13.70  )
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


On 8/22/2022 12:50 PM, Chao Leng wrote:
>
>
> On 2022/8/21 14:20, Christoph Hellwig wrote:
>> On Fri, Aug 19, 2022 at 03:58:25PM +0800, Chao Leng wrote:
>>> Now the ack timeout of RoCE is 2 second(2^(18+1)*4us=2 second). In the
>>> case of low concurrency, if some packets lost due to network abnormal
>>> such as network rerouting, Optical fiber signal interference, etc,
>>> it will wait 2 second to try retransmitting the lost packets.
>>> As a result, the I/O latency is greater than 2 seconds.
>>> The I/O latency is so long for real-time transaction service. Indeed we
>>> do not have to wait so long time to make sure that packets are lost.
>>> Setting the ack timeout to 262ms(2^(15+1)*4us=262ms) is sufficient.
>>
>> I'll leave people more familar with RoCE to judge the merits of this
>> change, but I really want a comment explaining the choice in the
>> source code.
> Now the TCP retransmission timeout interval is 250ms, and this setting
> has been maintained for many years.
> The network quality of rdma is better than that of common Ethernet.
> That is the reason to set 262ms as the default ack timeout.
> Adding a module parameter may be a better option.

Are you solving a real issue you encountered ?

If so, which devices did you use ?

>>
>> .
>>
>


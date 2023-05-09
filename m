Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B26C77B7C
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 23:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m1ipHgMRwsq1HVduzbBOWDFMLOjSVjIFq2COXBIJQf0=; b=ULgMJITRjkXXNjAtcuFS2KlLrk
	fUr9p//SBW1xq3/+71cHLAm00xP1b39ojzn949QXbi2o+6M+PSLAZ7yqvDrFqQRF5bY/9UepPENAq
	rG4/s73DwHYqGFIhsOx9UTLYKQnZ7eM4V5kL6SeRdCZaQH1gb3Gi7CZoTHdxltrFg6qQqdu4q6uHg
	smcguD0s79T9NfMbnFjn59K6Lxyaz2SzoOlw7qx4unBSOldI0fv/VhZqDTcTa7KIkxsFaF5kPwSEE
	OEuXZLtBXYuJNLHtGrOlIkj5/lpsRDvn2yrG4M8XMTszwKPxE4XE0qigwBljd+8IdqdEnGmeHzusB
	qTdl6cTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwX43-004Y48-2l;
	Tue, 09 May 2023 23:48:15 +0000
Received: from mail-mw2nam12on20603.outbound.protection.outlook.com ([2a01:111:f400:fe5a::603] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwX41-004Y3G-0B
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 23:48:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOn8bKv0ISK3wA8kq0JF7qRiL37bp5bw+sRD28zx9VOZTXOkl4IsJ5oh6vCMJZJHlzmbS0AtEE7PyvS7g83f9pW+FwNRZHlPHy/yWX+l/A7ZG/Jt63mR6vJ9b5+YoEHmfNHuKdRnFaheK+53d2wZLn5wBkkWHg5ctU/5BAZJJ0lyNQYZi0gJgVbMUcrPkOXyegMRf80gAXkdBWydfzAH+kuLBIQKxApeohDOwsevqnt6FgdIW33PPCav0PEvH4/ocZrbpiQy5eln3YYqvkY5NuJDjbdFKqjcXPklLjx6tS+UbTWwBIX0PV9Jrbz3xy16wCcqBT/+37ljkynECOl6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1ipHgMRwsq1HVduzbBOWDFMLOjSVjIFq2COXBIJQf0=;
 b=JIMnFNtkK9ZQ4w6IuOxWnQcNzSUTP7FW4tTOqn8eBbmzrEgjTcyCLh1jIaPG6k76blKkSF2hDdcGaYF92aPC1vq0iR5IYsvxfv0d1b28p8ZIP6mAliKY6ovS6k1o4uQldOOi0+hnlZyXleGbKjW6wrwA7uZikDlA2PhdHwmhag84sf1omVRK5sqG6MzmbxLZ9CdXQzu4Pb4hFD38oLl58+of/XFgcInL5vDQHZdJTGzRiPhWJEaOxREknf7Up/p2XU/RRPU305wQyl+qT6iXeaXbghl44gea1mTErHYYFw13t7/Zk/5fO9khMFDjo4YGNZviUUyWXP/VGiO4XssRUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1ipHgMRwsq1HVduzbBOWDFMLOjSVjIFq2COXBIJQf0=;
 b=tDuiyNea3Ns/BOzHvC/flwd52W7SEzEloOghGjEVdsShecOVfXCa8XgleCgsDVeLaWYTl7KFKVzOTGiG6rz4HrvCq+SVRAgJ3YWajCN/Wo8uetHrhUDJk/59FrG6G+dozbuu2KB6HCl42QTM04RpzheJhUtzYI5iADYENq7wfYCfFZZ9nCbgRMrd1Az8sERtVadEeLHThTCx2kMQoB2YNV9narCAfiXislsgFDMq2EZXSWXbZafUIX2Fqa/WyfDMTbM62HTyQzqLSRWnNeFIAq0LHvq6ynxsa8npo60dx7zpA6rbMG/RCPKEjGLFA1HL9J2c1UNLgDPxm4JP+HPUFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 23:48:07 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 23:48:06 +0000
Message-ID: <6ecc1538-95d6-1d3e-97c9-ac3f31ba22a8@nvidia.com>
Date: Wed, 10 May 2023 02:47:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] nvmet-rdma: Suppress a class of lockdep complaints
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Max Gurtovoy <maxg@mellanox.com>,
 Hannes Reinecke <hare@suse.de>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20230509135615.2061227-1-bvanassche@acm.org>
 <d3c147a8-828e-bf8e-0141-f1d06d6266c3@nvidia.com>
 <89285655-5c65-12e0-d468-c9483079ac28@acm.org>
 <046765f0-01a9-eca7-7f36-a0b62c7beb93@nvidia.com>
 <b076b23c-8d85-8187-e6b0-32e9f5783985@acm.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <b076b23c-8d85-8187-e6b0-32e9f5783985@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0253.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::6) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: d5a68f33-93fe-40e5-10d2-08db50e7d650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	BQN4+Lf898XsjEGVfKjgc7iE9uZ7CGUJicrE/8AFXlGStjLxosUbPmLmOii89QY0tp/aD1FXiVaMhBn3zDp5oSvB/Wk73Xdwe85dFopNfuXT4tipTWpT3UxeZyjKQcgIt6teOSKOk8C4kGBacmuR6VtSABlnnrlZK7S0mIBIR0iaddoTt8lxTwW1K2Eky+wl40nXha1MsVGQpnAtR+Hbu+hM0dyQv9GbSdFqjK9rjHGwchxf1gG78dNM2Pwb4YnLc9BlJXFWbEqrLmfi3v5n3psH3wXT/zjuLXZn8o4ARuX2lR5IF+X6JZQVOmnC1ZsFH8imXIv8F5w65xEIbgKYvlyLStOAVvvF/b0MiZ76BDLfonUWzm4K/clAEPCIUFGBEX61ZZpIUntGCQVXLiEfLrmcbJrqoVo0jG4HR0Mv8fo8Hvc42GX3QiNFUmjlVk0sF/ml11x1ZHhsEl4A8aW0wIsKRrfZJWJ9BPnD5lxGZzVFJYTGdsxdGj+pYe0Km0TsMQDpBMqdotrY8Lf0t6L/FzW58HKy9twI1eYJJcutH1ZijVHU4+slevw6pYViQgCCsGptU/FPTTdKS//on6I+vt/DDuZNbQqjgVqfVugieZdV385eLUkI61JEQEeVKKCxV1RXe/d2E3TxWq8FVNnIWA==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(39860400002)(346002)(451199021)(31686004)(6666004)(478600001)(66556008)(4326008)(6486002)(110136005)(66946007)(66476007)(54906003)(316002)(86362001)(36756003)(31696002)(26005)(53546011)(6512007)(6506007)(2616005)(8676002)(8936002)(41300700001)(2906002)(5660300002)(38100700002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?ZWpvUkNXNHRmMU4yS3I4a0xYQ1FXdURHOVJ1MjIyN0Ryd1RmRk9lZzdUV3JL?=
 =?utf-8?B?c0VLMmYwcDJQaDBxM3BQaTdKNGs4R1A4SjZ4ZEtMZWZtYkpQR05qaHhHYVEv?=
 =?utf-8?B?eUhDTG9MQ3ZsRzN5bTRrbm4veHJBMEhUVmtleGUvYXEzMjE5VGdnV2s1eHVE?=
 =?utf-8?B?TWMxYzdOTnBiSlBOSFZYZjlXOUgwR0NiUVQxc3BOdjgrbDVSZEEvWEtYNWRY?=
 =?utf-8?B?ekVyVHc4Rzl2NUk3RGtuT1kyZXVUTGFnVytFSWtmWDFtMDBiUm5pR3pEQkRG?=
 =?utf-8?B?UWk0NWU5MXBkaytCM1NFUFl0NmtXTUFBbmxVRUp6ejZBd29aeGpZVzlzTjg2?=
 =?utf-8?B?UnlMMHBDSU9ScVoxVlEyQU1icW1RUzF4TkphYVNjR09BSjJTY1Z1VForQ0tY?=
 =?utf-8?B?MEZaZWdpOHNuQ0dXV1Vtb28rTkRldHRETFFJTXc1ekRkTG9TTU1ldTdkbUVz?=
 =?utf-8?B?NDdEaW1rN3pCU0pJd1IvajdyUjJEVGZqYmVPMXN4dXNsUkovcGpmLzd3ZnY4?=
 =?utf-8?B?Zmd4OU5wT2pqZEpuVzUrRjYrYjd0MTRZWXlUTzVEQ0JLSTBQQXY2YmxTbXow?=
 =?utf-8?B?S0FrSWlhb2dkZTR3cFJBRm9LeitSSjE2bXpTK0RLdWJsT2Zva2c2ZHg0OGN2?=
 =?utf-8?B?eTByVHlJVjI5V1pjN2l0b0s5b00zNmZxRWRzbGJWa2xta204ZlJhZ2Q3M3dV?=
 =?utf-8?B?ZStCTTBPQkVNQ1dHN1BwWFYxUkg3YWpUVy9MMG1ndzdYbXByVUFkWUtrcktJ?=
 =?utf-8?B?SnFwL2JIQWxhR3F2eHBVRWFISE56UkZWMEVXZUNFSlhxRE9TeW9ZaTdpc3Bw?=
 =?utf-8?B?dm9iVHZMbTFuL0dWY3VOei9IWC9qaFI2KzhVWmczbHdreXNqQlI4QTAxTk50?=
 =?utf-8?B?Q1RjZGdocGFwd2EvUVhYdjM4RXlVbjNBcHVLc1RpdEVBSGZobmRldDJscjlU?=
 =?utf-8?B?Vkc5akplZUxoYlBsNUxHRWVLeXFiL1dvZDUvMi9mY05IL2I4UTQ4N1lwSkpN?=
 =?utf-8?B?MzVTcWE4OTIvTnZ3d283QmZCRE45OGtwSXV6OVRRYlpJK2FKTmFLV2dyS000?=
 =?utf-8?B?VHU3MjM5Wno4TFB5andnQlBzTXRZY3dYaFoxM2NReG9MTElxMFNhQ24xNDhV?=
 =?utf-8?B?S05rQ0diWENQc3FESko4Yk9KQmFsU3lBam5lVVRXYWd3TEdzQk9qSHdwNmxR?=
 =?utf-8?B?c25waW9PY1ExeW5ENHI4ZlE4emsxQ0o5NXNOSW5SazdFSGcrN1lMdmZPak1Y?=
 =?utf-8?B?THQ2QUxEK1hMTkhpZnk3aC83NytubWZnY1A4MmUyZHJYL2F3L3M4dkJMTnlM?=
 =?utf-8?B?RFVaQ0cyVG4rM0VlSmxYVGVaR28xclVYR21NSmJiQWhGNVN4K1lpUXpDcEl4?=
 =?utf-8?B?RUJuYVZ0amNVRWdKMk9RZDN5dUtLUCtGa3JvOGV4dDV3cGYwL1dNQUQ5eFRn?=
 =?utf-8?B?ek9qSnpydXVHMGNYNC8wdFFoT2NtamY4cTJoc1BjUFRTYnhXNXZxakc0RmR4?=
 =?utf-8?B?OXJuS25rWXd1UGcybUdYeWxhemZVdUJkQU1rRDdOZ3F3ZVJMV1AyMjVqSWJ3?=
 =?utf-8?B?UXQrUlp0T0MwNnRJenJ2TGFYbjdGbFVBbGtPK25IVkpFRnN6QUJscUtkUU1P?=
 =?utf-8?B?T0NIY0pPa2xGNTg3RE56Yk9LanBmNmlKNUt6TG4rOG5TTmFEYVVxeTNMYlI4?=
 =?utf-8?B?ZDdLck5uazB2VmtGWmptaS9QQU8wZnNyV0R2RGxQYU1FKy9EVklmTjJxRXJV?=
 =?utf-8?B?Q25sWkhNSTNNYUJYcGkwcUpQSWxuaEtQRzZPMUlyQVRXV2NvcVkrUXNNN05D?=
 =?utf-8?B?bE1HWFlxRzBXenBDbUxXZlIrN3hDRHd1VTZUWFl4dVF5anUvcnFraTAyT0ZH?=
 =?utf-8?B?WVJpWmo4V1pCd1VwQnZtZnJjczhmVFRncmhLLy9ZWDJHdkUwdjQzQ1B3dko5?=
 =?utf-8?B?VnV6T3B0aG5yM2dOVmtCNWJ4UDk1T0UyejVFN0lSVGNTdTBzTTY1WEkxakh4?=
 =?utf-8?B?d3Vhc2xnRFZ4Z3U2M1grSXlpbWRHc2FMNXpjVmhhMitmQ0pqTmhGNHhlN09H?=
 =?utf-8?B?ZWhtTEVnem5WWEJwb2J0RWFHZmVnb2hieU9DV3hZSlg5LzdNVmlGOTNEVVU4?=
 =?utf-8?B?QUtLNFhPYjIvU29DQU5reVlFSWMwL21tMnc4TTNKM3dCTWlNZVZIUG8ybWVr?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5a68f33-93fe-40e5-10d2-08db50e7d650
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 23:48:06.8514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1gFnrowxXVudjqQ5+jwBaqnba77GLw3WN52nnmG0ybIer9grvTuSWiVwWvHp4CZVEHZpOoM8KrjRZTpp78dcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_164813_140729_EE64F917 
X-CRM114-Status: GOOD (  15.04  )
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



On 10/05/2023 2:42, Bart Van Assche wrote:
> On 5/9/23 16:24, Max Gurtovoy wrote:
>> But the concept of "dirtying" the base code only for the sake of the 
>> above reason sounds like a bad practice in general.
> 
> The use of the words "dirtying" and "bad practice" in the above sentence 
> seems completely inappropriate to me.

I'm sorry, this was not my intention. This was the reason I put dirtying 
under " ". To mention explicitly that it's not really dirtying.

> 
>> Maybe for that we can have some mechanism of side patches that one 
>> apply before running the blktests ?
>> This will leave the base code clean but will need to maintain these 
>> patches to be applied cleanly on the base code.
>> But I guess we can have some automation for that..
> 
> So you are proposing to maintain this patch as an out-of-tree patch? 
> That sounds like a bad idea to me. Anyone who modifies the NVMe code 
> wouldn't see the out-of-tree patch so the out-of-tree patch would get 
> broken quickly.

In tree patches that can be applied before building the environment for 
testing.
This way the base code stays clean and you also fix the blktests 
false-positive issues.

> 
> Bart.
> 


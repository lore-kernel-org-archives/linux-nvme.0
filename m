Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7933DC77B75
	for <linux-nvme@archiver.kernel.org>; Tue,  9 May 2023 22:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n85wpbLK3Rp4pinpAMScIi1oSvUjP1R6N4gvhb+M/aI=; b=YGCwLeEMCdeghrZRfqkSL7JEPO
	86P7eTbFLqZC2epUdbKFIixKLKvSxsirbVasPS3FVwvBy1UJH65MvJCwDpMC6rhkiyb7RPT3768gY
	h1BDGyJnxbV0sHf/aEt9cLJNutTBk0rY5hPtBcK3BcKw6gq9ALn8EZc1X6I4oMNKv6z8IJCzPAZ43
	9JIHLpF8u2D/ytE4qqtKnrL6rUMMoHUm/HZRWrIndjCMZKP9YohFj0dsf1IPSDIz3Go8XPOAcEZMY
	05pJ7WgvvmVfbrkd61FI8odN6jdXDC7Fmh2KPpSP6MqAJRSRihM16M/6Z9YkzDnXIn53KtlX6PDeY
	9WSekg9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWFM-004RaK-1L;
	Tue, 09 May 2023 22:55:52 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f400:7eae::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pwWFJ-004RYm-1c
	for linux-nvme@lists.infradead.org;
	Tue, 09 May 2023 22:55:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzuC2UvSfmmMXslU5rVBbqq4MKbM4MKQ4i/UHqFpHasZ2amQ8xs2R40RqPPc+Qzc/yYvhkKPEDTJC9JftjY8SLEYmvMf6rg/1YHRHFAgVeH67p0jYJEVOFIXh5+bxjkllKEfPa47b5NAxThK6VKmuaReajLB5xjOlNjAb005lc4qVDhig91Q1897SWtEOQ7q6qSPYUqaQlJ4AjerkZ7zA/hsZtrX366qq8lPyaepMZICnG6emtms9MzwTKKlrc1V5EIWGGJkXB6rVEOUYFYJRmkbkgcRois0djZ4FGRcFEfLPpuj7PS4TOWl3KUAr3ZY+JAAEt2WsuDYS4beWtzfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n85wpbLK3Rp4pinpAMScIi1oSvUjP1R6N4gvhb+M/aI=;
 b=k7WepuOvRw3FxMIlTMaz04YnSa+rR4JJNnJeyDjfbFb3VFSD3EWv4PhGAriLomTj3Jry9/nlKtXEM4OHKqcVDareJ6NYLsH/7T8nZ+MPNojRLWmNIxJar8PX54Q+G7WNmrOgxhDd6XOsFqDgKYDbT/Bv06qFnM6m9P+wsut517Nct0nIqouZ2bQNJW9LObIA3lgdm4ovpnSoIA/qnB6v69dcT4Hz8ZInpuBjpLhm6rHI+RecOc8yp2g01Ozb2CcgdercABylEnuZ2NEJaSDQKd1SMPbVMhNqJPCqJStb7qniuzrugj9neeSElzAX6q6PzDGRRv1rQDDRdSvjb8G3Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n85wpbLK3Rp4pinpAMScIi1oSvUjP1R6N4gvhb+M/aI=;
 b=Y1GwqZ0ExqGmFkZeRYoLm0+IkJoLQXZKxtK2lhWAeBq+11HUmPkXzslgiXzTxOzYZb9epR0OvrLz/QqmDwMaBEVRYHTiG42lwK1TH2nE71oCrxvraQVDHSf9HBFWHvNtC8pCBwWZ4oeQYm627u/Fy1v5byLSgwouTu97Fi/9Ex7WZBMFQi32Bpw54gQJC4DWv9mlar5IhsWQmEQ5lBA3+5V/x6E7Sdq/Gk8WGMIxeI5g3JFUPJPgUHGMrQIJEA8cDjKNL5Ey/nCpccP5HexdcSkJeUc2PD/omF0ZeFqp7xhbvSa2OwoQaw5c4cn0Vgk9/M3rjarPHmd2/Fy7fTEREQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:55:41 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 22:55:40 +0000
Message-ID: <d3c147a8-828e-bf8e-0141-f1d06d6266c3@nvidia.com>
Date: Wed, 10 May 2023 01:55:32 +0300
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
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230509135615.2061227-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0130.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::22) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a8d6dd-d4e2-477e-b949-08db50e0830c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	4UTajwUwQ1i8Z9Xe4Gj51ZD3hBvX6ke+s+XB3Bo+v/kTkmWc/iaXk1sP8xdLryTgQOUVG0X8C1SR/g5PnhE31pBSguCwLy7Qiz2edsiHVgUlUTto7G7cD/cjiNLubg5oo/rAGjSzLg/3UHlf4UgvK2Gk4wnRbNPHcIFlG/G6myvPkdGI6sxKZy4/wUPMkmGdNAgKrvBhHaoFrcrGz8OB8LOtmaWJ1t+ovP2jvNpe+/VLavFRakxLdSjXBLAKF7RWAkXvqkvb+7qPl3yT1Q3sLSBQaayJVp64tGjuBxGiyj23quW+tT+KltbG9ADX5oIYIx6AZ2MSo9JXWfbKlq5WJ1a0sNdnL59KukJXwO3HlBgjuiH6VewKBPzU7TVvCQ09XPjl7HHj9Y3yEuRGFOPyOTp2X5YpLXuxcoN4A796LhuSPt5gzcMVKA03zvysZTBfQuplExFZ6eYbt82rUzXXqz/XriNLCi1PSPwDfpa/nI2228/6XTzkCkJhbcobKU/g1QjiRq/9Hz5JL9Dn5RYVSVqTP6dqkVjhsoB6gnwj2wxYFWsvBLD/JGGHHSlsjZBk+fsZScgYR/aJ1JnDRYYPfTKJtDikCfmzgHguKSMqcTOfcQIVxhfo92awbOHGJZJ6wY93Djh7rAAUm5nWp/F6LQ==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(54906003)(110136005)(31686004)(86362001)(478600001)(66476007)(41300700001)(6666004)(66946007)(316002)(66556008)(83380400001)(5660300002)(36756003)(6486002)(4326008)(8936002)(8676002)(38100700002)(31696002)(53546011)(6506007)(6512007)(4744005)(26005)(186003)(2906002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?TUtyRFZxS0RpR2xuN2IxNUNmdWFpZzVSNWJTRno1SGUySUF3ZnFmNDgwTEho?=
 =?utf-8?B?MHZjbktzYktJQmRXOGpHSllMdStzdWpUNUNOMlE0dzFvc2gvU1NOZDZaakU1?=
 =?utf-8?B?cTk1R2Z1QTNjRXAzWDVoWXhJeDV2Q2QxUjJ4Q1JQanRoN3ZKZml6YXo3N0RR?=
 =?utf-8?B?Q25rbWx4Q2FkRHhtK3BlMk0xSW0yZ1lYOWhnVnFUUnp6NERVWjVjQ0xES0JN?=
 =?utf-8?B?eTF6bS9WSVFlaUpTcm5mSVBFZnlNUmJFN0c3cGZuM1IzVlo5MUtoamlhYWtm?=
 =?utf-8?B?YnVoeWZOeTR0V2JSQ0c4UHpYa3VSMDBPakNKUld4QTEyUDAwemNCQWVTaXUz?=
 =?utf-8?B?MGtPd08xSFVOakpEQ1ZjS1FJOUFERG4vbFJVUkFHUFJMTUU3dzJWeHorQmxQ?=
 =?utf-8?B?SUUrUUhSamltL29wcG9FUkp4VHZ0QjExTEJ1aVYrSmROVnBhYlVNRUI1STBl?=
 =?utf-8?B?NENkRkNhSWhUOTRicC93Y2UxeVJIa2h5TkorbDg4MW53MmRnNzY4MEJFcWlD?=
 =?utf-8?B?MGRKSlYvdk5aYXJxS2lMTWFOdjNCN2YzSFBzOFhxUTdvOXZrS09lRmQrWDh0?=
 =?utf-8?B?VTRrY3lyWU1WSkdvcW04dTlsSWszdWtNejBvN2xpdUlSOEI5R2lTK0NhNmFy?=
 =?utf-8?B?eTNZdmNqRE1ZN2VDQ0twMTdESWFzK0k0b00vTEVONjBURXpML2pxTk9qZmFD?=
 =?utf-8?B?dE5WbDBjS3NKZ1NwR2tRbWtpdG9sZGM3dnRwQnEvVCt2U2ZEVjJYakJ4Uzlw?=
 =?utf-8?B?bXYybWIwRklqRU55VUZRTDRNQ0ZRelNIbEZoaWVjamd0Nys1SGZ1SWJCNE9q?=
 =?utf-8?B?U1JHQ1lBNktYS2tpczJhNXRqekQzWnJEUVRYelRnT3pMNnV2TWtaNSt4UHhE?=
 =?utf-8?B?UjRFRVYrUXY4TDVlWnVYYUx6THpxKzFWNEF5Vy9sem42cUZjbDZPOU9lUjRk?=
 =?utf-8?B?anlGamdDdVAzTlFTY2toNVgrNmNEQmhwT25Dc1ZVRHQxcEtWbzJkVitPZ29o?=
 =?utf-8?B?ZUJlZ25uRGdsRzcyK2xJK2tQUmkvUW8raTVXNm9UTVl6L1gzVy8vUHl5ZXMx?=
 =?utf-8?B?RkdObHZuaFNYVzkrY3Nhcm52TWpPUGxHQWJ2bTNqdlBYQ2w2QjkzN0pHUlZw?=
 =?utf-8?B?QklnOXBPMjBvcUtnaE5Vak80bitGKzhMZDFCQitBTXNnNXNucWZESXF4YnZ0?=
 =?utf-8?B?NHRNbVNjMFQrNHRWMGwyTHZuWkxkV2Q1YlpnTFoyemIwR2dRcUJUU2FOMllL?=
 =?utf-8?B?Lzd2eGFYeVNuM2VwKzBIdkVKNlFYbkRZa21Wb2lMS0NoZllDamFnRCtKbXBn?=
 =?utf-8?B?L2NoMFFLLzN2cDRGMlYwTGx3bllhOEFtVVY5UzJjS25lYlZBSlhyMnFySktG?=
 =?utf-8?B?Q2VHamR5QWxjZ254MmVlQnFueUx3MUhYaU9rUFU2MUlFVmRZZWZETzVhek41?=
 =?utf-8?B?NUxlWURidU9UdFVjdFh6VENrd0RNay9WNjJPMi9GTnA2aGFsdjhvbVhMcENt?=
 =?utf-8?B?bUVqWmxNTzl4YUU2bTY4Sm9vVHBiU3ZrS1pMNmE5cXBjOUtzVEdQbUcyM05y?=
 =?utf-8?B?cHFBdmVtU2o3aUtFdDRoRXJHUmY0Z1BSL1kydDJnUGVmSGNoVXU1biswcC9S?=
 =?utf-8?B?N0xibWFxd2Q4MzhNOFVLSXNVWXArckJQTlhraWJ0ZzU3a0VjRk9EcTRpTmV6?=
 =?utf-8?B?TWlWZExYcFlMUDNUUE1NOXZUUTlucXdQSkVUYzZUQTNTWjlsZUl3bUJkVEt6?=
 =?utf-8?B?UVRPdEhHNngvcmNNUnJ1bXEzRi9NbXVkenB3Ym5mQnk0SWZZTXJyblBRdkZW?=
 =?utf-8?B?VDhPODB4Y2p6RzBKVE9XM3gvUkZYU0lzQlU2TzRSeDRTcDNHMXI1MHYrcDFZ?=
 =?utf-8?B?V21kYkxoVzdZenIwMStBOFJOZm5Vc1orTnBkbVBGbFVHbUN4VDhkVTdpMThX?=
 =?utf-8?B?dGMyREl2NllDbzY2OVd3QXFPZE1PK0JNMjZpMnNjY1FlR2pTaWlnVzExNWpN?=
 =?utf-8?B?NDd6bWk3TUxxM0dZM1JzYWhoMm55Y09SN2R3cXJpUG1MTGhJSVlMVFJuYlp1?=
 =?utf-8?B?QldCRGl0bVZLSGg5cGxjVkhERkRCbkpGa0pNSE02RUxsRG5HVkVTMlUydFVG?=
 =?utf-8?B?SGdCTjIxc2I5UEo5UHJyY2hBcTRiSlAzRkFTamNDY1JtQ2lwaXhPM1M3SnFo?=
 =?utf-8?B?cFE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a8d6dd-d4e2-477e-b949-08db50e0830c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:55:40.7170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xaMvGxVYuaRj5KE4GdjzFK9M8MN525MU3+Ig9SjgTDhLun6mw4rqRKAmjhReenEUU+io3XfJDCBGLdxRTA8iVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230509_155549_546007_5810B9CC 
X-CRM114-Status: UNSURE (   9.00  )
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



On 09/05/2023 16:56, Bart Van Assche wrote:
> Waiting in nvmet_rdma_queue_connect() for previous teardowns to complete
> (flush_workqueue(nvmet_wq)) confuses lockdep. Clear up this confusion by
> by using dynamic lockdep keys instead of static lockdep keys for
> queue->release_work.
> 

The concept of adding a code to a working driver only because of some 
confusion of some other SW competent is not clear to me.

Can we fix the lockdep not to get confused or ignore it if its not a 
real issue ?


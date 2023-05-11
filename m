Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51E4C7EE22
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 13:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5B5qDh7TKayKYgVdlHwewy+HqDA6GR2IhIc8jRUI93o=; b=hTB1JhIWo5qgfWR186rek7XuHJ
	G5czwk0htjucJoAEXrtVNefm0n7kgQdZLvF6mZgGV7lyjw0P/37JXJxfEY5DxtIEzAvvjw4hlTxS+
	zTLmj8gVHZO8ddsyOMLBeyNgMsYz6bZkHpj8zTE7UI31JsrwpclbWXxfn9lRWtrv8a1eb9PD5ef7x
	cBbg4+pppY4bCv3nHXw9KBkiYYxTx5iFWZID4H1Vm/T4kppgF3aLlymr26U8pK5hHp/i/6OKYUvu8
	guTbMxBAaw+8mmBj9N+CzAJXRWtdTTzaxCDnEhcY91geuWndvq8841DGiRS20eiVeBYQKvET5JCDS
	La06sGfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px6KZ-008rmD-17;
	Thu, 11 May 2023 13:27:39 +0000
Received: from mail-dm6nam10on20626.outbound.protection.outlook.com ([2a01:111:f400:7e88::626] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px6KW-008rle-3A
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 13:27:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5eA6oBn+pzZqAJvZqeTwRxDAb7tvNy+eNB1D5iDq0iIYZXth+StPc12eg1dUFumL/R9DAunuME3vrpstwhnRowPSakebALYusaoyMAKHkJkwsMwopQBKR6EXZL3pu8zbSAvK3phqM90pj26VrH2kOEIgztQro0mpIQQI84ASskczl0cMDt5Gl4qyFh3WOwE1eQvfGLEeRq1gtNaIdOz4lhZGzfu5zFq3NdQQTYygoNWRXzrxMqFfMpKf2iimXg+VVJOFjiSJYxi3dQxS+hGbmBux4dOb262sT+eVhBeenF4ymf4/E/SeVUy/u7vjPeAyMcaBcPGNJ+voJmPWKSy2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B5qDh7TKayKYgVdlHwewy+HqDA6GR2IhIc8jRUI93o=;
 b=ZIzEvmIhyemfmaER8t3+ye/n4MGo1WbkNVrcsYJnYT0VpP9+SPKbduF4RLZfjUp0CGHGBhhLWCZHZ0oWKZ7TJyDdm0455Bj3BjAJIxN8c5wni9uImACOsId2VTANv8eEFpyGtngZ9Fl5tYxXHEvBY8KPFYYgYew8/tIDlp6gzTowi3UqWXawSQRje6v+UEr6XahhoCjWL6VaG+TXTG9S3HTkp8JeHqFCJIR2KnBBIapyEs2PF6Utpfx+wZl4ECJ6R12kOK2V05rNHggMoHbOV8QtyYcEuHy7l3sqOj38GwEXkHHKiD9UPydE9Q5c4Z5zwrQLt/mdE/jW3GCJ/y0CqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B5qDh7TKayKYgVdlHwewy+HqDA6GR2IhIc8jRUI93o=;
 b=Rs7C8DKYxO1eEJ6EbZ2rDXtBkrlozQnkvNjOC5rrxxO229r9Vv0zt6P15zRBcanclmd3mFkatPy2LpzCVFQWsMFnbHdNbiRT2l7VrlTQQguokSLDTQ9jxoNNxAPr4C97n1g6341l7dR+HScDN+Q2/NbqfAncLTWtFuX99WNxhUEVfiV13cKKsFplpkJTKHOWS17xC45L+kSoM0jmhLL2sngJw0sTD7MbvzKHsmcdi6VdAz4xkb1AaSxuTFY1mQBMN0En+YL4vFSROAU/RzVa4IXdqSxPL0U4ZTCFcfLWV0MukvI8OHGwzxBn2XdUU9v8A4KblcM6i8hI4ring3AOhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.36; Thu, 11 May
 2023 13:27:02 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::61c3:1cd:90b6:c307%4]) with mapi id 15.20.6387.021; Thu, 11 May 2023
 13:27:02 +0000
Message-ID: <97e4f76b-0c11-1f68-c4e1-0984ed04ac8f@nvidia.com>
Date: Thu, 11 May 2023 16:26:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 3/3] nvme-fabrics: prevent overriding of existing host
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, kbusch@kernel.org, linux-nvme@lists.infradead.org,
 hare@suse.de, axboe@kernel.dk, oren@nvidia.com, ngottlieb@nvidia.com,
 israelr@nvidia.com
References: <20230510180231.18865-1-mgurtovoy@nvidia.com>
 <20230510180231.18865-4-mgurtovoy@nvidia.com> <20230511131625.GC29790@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20230511131625.GC29790@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0163.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::7) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a8c84a-8b5e-4784-4122-08db522367f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	6K3uWw/t7PDeQXPIs1lk2POOHmC7dI7+HElBOTjVvEv4JAhc+/P1A4mLdHz8ChOf0TUtbVHZlB21ef04deq1dHI1Gj9VWq6IAgGtVyTeGIfvuTrA9NBcFC1h7tZTaNgI7vnUCWrhicX0mh+PXumGgVNwE4Ku+r1EvXGpqO1FbFgAR9cooyWOV+FZ9nDIjbVBfEFthh9bt8APh93T0MA0bINAPSfcEofF/IA25tktaB6lR8BRChIi3LQN6uw0QtKPft4kxdPsa7V1ts/INyPwkIcVd38EqSki3GIfsNTGzOTqFLaoG8Tob4RHqVPxAXYp8Chf+oDy84wvMGTZSR4LuzbraJjLzy4hiNfrpv6BNdk1TJeztFJaituxfY5l6sY/ooQCF9/lHstn5r49m9TiiNG/81UqL4M8DDm+dIUhQ8H6+uJ/yWEc1A3EEVJuYmB+EvgaCNvnDWYzIBXC6rKemu5AYm1/nYAYo/xcJg9iTI9/9DoFSzJ5m4BNfoqkuHV01Ann7v56uInkB6BWR/M0mfTVTN3d2ob9wccAjDgdpmIqMHcbaKt2zVnqddcvkWJMZexu6a0D/poO4D9HXXnJ0zeIwN3JikwGPkLFw4NGCa6AU4AGaVlUELTKrQVIy2BbiprTzdx+bePfIsSW7aoSWg==
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(31696002)(86362001)(36756003)(316002)(66556008)(66476007)(6916009)(4326008)(66946007)(478600001)(6486002)(41300700001)(8936002)(8676002)(5660300002)(6666004)(2906002)(38100700002)(2616005)(186003)(26005)(107886003)(53546011)(6506007)(6512007)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?cmdTeXZpUGlVVlI1OVVvMlFrcW9nVU9xSitEMGc1WWhQUTgrMEVqeG5pRE85?=
 =?utf-8?B?VERHczZwd1R4QnVXOURiMEkzeHJtdzNoak1vSUFwbjBUY3lhdCtpcFUzQmZp?=
 =?utf-8?B?TzdLUXR5Sll5cnMxQUdBdVNza0wveUVVSGlMaVNaWFpiYmZsK2czUUVPeDN4?=
 =?utf-8?B?S2tvemNnNjRjRjByUEZic3o0ck1lZHVhNXFEb2RPU1d6MzhaNENJOGs5eG5X?=
 =?utf-8?B?L3FGMjE1b1MxY2w0Qkdhb2x1WDdNRzI2ZHdrc01zK0htS1hCcmhkNHRPZXhx?=
 =?utf-8?B?MnQ5WXo1MUpCa1F3SnBGUUQ2ditUOXhSSEZ2SG9ndmNSQUQ5VzVnb0RURjJD?=
 =?utf-8?B?bzhDWjNMbjlUUGJNNkpKR0lrcGxTLy9kT1dpd08yNEt6SU9ycTZIRUgrQ2FI?=
 =?utf-8?B?RDhaTzJNb01jdFpSSERJZWgwQ3M5dyt6NVlIajc3dFhsaDFnNjJ2S01aWFNL?=
 =?utf-8?B?ZUs5NXZDNGsrZ3BaR3RaQklFNVFQNVl0THpIK2RSdEpZdC9lZEc5TldZc1hT?=
 =?utf-8?B?ZlJ4aW1tM3Q1TStmdDBkZEJyZzJyRVFXTzh0SDBEK2ZmMVpuQldNUzk0RGl6?=
 =?utf-8?B?WmR0elcrSDZ4RUY5QXJ2enNGZ1l2T05qajl4Z0Vkd0RmUUdZcjdqbXhUSTBN?=
 =?utf-8?B?bXpRZUZobjluNHQ4bEp2OUtLa2FxOG1DYUdUZlhrZjlCVmI0SU9Xc0FpbXJZ?=
 =?utf-8?B?Zkk4UEpvbXlUOXFkTDZiY25hK2FCUHVFcWhuMUlZaFRzcXdXNmI0dGR4ZFZE?=
 =?utf-8?B?c0FseHhSY2VMd3cxNmRQNGF1RHd6Q2hjV2NKdVk0NnpCMmgrejZENVU2clhu?=
 =?utf-8?B?ajRTZUZ0UzdMWWxMUzN4ZXhsTXA4NlJBZUQ0WU05ZmYybzJMVTBkNHpXNkJi?=
 =?utf-8?B?aGRWR091emYwOHhEZzkraFd2bDRrUzBhajRJQ2ZKVUkwbXNtbWtxZmRtV2pm?=
 =?utf-8?B?N2JuS3h2QVdvYndRdXN4UUZ0T25aMUY3b0NWS2RPa3RMOGk5STdMR0xrWUJl?=
 =?utf-8?B?dWJLSTRyRnZWRGw2bmNPQlN6bzYvemZkYmtYa0J0bzdmMXBEelBpQU4vaVl0?=
 =?utf-8?B?Nm9PdG00emZrU2NNUU1hVk1hT0lHRDRqUnV4NGFjbWRBdnBjT2lsdkdyWlEz?=
 =?utf-8?B?UjZQcldrdjlBdmZtRU55OEd6TzVnWXlacGNDVmVvL0xVUEdOU2VIdElzMVdr?=
 =?utf-8?B?TW1wL1lnWFFFMXVDcW1YaFdtRndNMEZxeTZTM0g0N2txNzAvQTlxYVJwL3FX?=
 =?utf-8?B?OVZFejZHa09pVjZHdHl2NUd4QUxrYTJmV20rVkRydk55ZVVEbnRlbVAyYkt5?=
 =?utf-8?B?VG16NVhaN2h1R3JjNHZxcDcxZWgzeHMvRXhNbURVdGlvdFlhVDFLSjRBZU8r?=
 =?utf-8?B?RXlNVUZyNzduR2ZIcm9LbU9sdnlJSFprbi9yS0F6T0tLVjVyTFlHL0RwbE5i?=
 =?utf-8?B?QktwaUJySDBpQjZxK08ra0pHRi9RSzNrN3kvZzgvNzVVNWRWaGU4dE5pNG14?=
 =?utf-8?B?dGgwSnl4Y2FDa20xczdZVUVEWVF2ZUI5Z3lrRkpaR05Fcmw1NXRkTVdNSDBv?=
 =?utf-8?B?TUJrRmtsdTFGN3JodGt2N1dYcExxSzJMZzRGUDJZRExKNG5VUG80elk0bExW?=
 =?utf-8?B?akFML0tJTzQ1cFRVVTFyQXgxK2N3OEh5d21ZUXhSaGlzdW9WU2xIN3NIbU9v?=
 =?utf-8?B?MUxBZ3ViZ0ZsbUxJeHBONmFqeFV3N2Z2VFFtK2NGckI2N2dDUjZaM2c5YVY4?=
 =?utf-8?B?ZktYcHo1NklObkNyL0RxV2dMR2kwT0lzQkNzREtxVGJtMGJiZnRtWDNtcTJ0?=
 =?utf-8?B?Rm9mUTdWTVhRTnJQdWhKb0hydmpaZW1nQUo5Y2RDY1lBOSswVy9vRzZxSXpJ?=
 =?utf-8?B?RWt5OURuSEFsUGhsbmRLRnVpZVNrVDBHRndQTWZGSGhvbW8xS0M2d084bGVx?=
 =?utf-8?B?MXdVY0lPSHFNb3FHRFRjODlpU2tNcnpZc3pnOHlscWNMUTBIbGMyR1FpYkNU?=
 =?utf-8?B?YU9Tcko4eTgwQzFORWdqZFJVelB5WXV5S1lYZGFXTzEvV0l6S1ptb2JCQjBq?=
 =?utf-8?B?VGRaTEJReHZiZklkQWNzY3lIcEFndytvQnpOWGhBcHFKNmtqQ09yTXdoU2N5?=
 =?utf-8?Q?XURxioqMQeg/2W1ZIRp913QzK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a8c84a-8b5e-4784-4122-08db522367f7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 13:27:02.7211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxkZXDSExXjypByWKVpFt0av35E0nrG7V6xtd0eBRDicaOzSprowW7wWOvylxwZIuHd2f9scSUSmOWu/Z16EeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_062737_025222_285027F0 
X-CRM114-Status: GOOD (  11.91  )
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



On 11/05/2023 16:16, Christoph Hellwig wrote:
> On Wed, May 10, 2023 at 09:02:31PM +0300, Max Gurtovoy wrote:
>> When first connecting a target using the "default" host parameters,
>> setting the hostid from the command line during a subsequent connection
>> establishment would override the "default" hostid parameter. This would
>> cause an existing connection that is already using the host definitions
>> to lose its hostid.
> 
> We need to reject that second connect - hostids and hostnqns should
> have a 1:1 relationship.

I first though this way too but the specification allows an NQN to have 
logical partitions marked as hostIds:

NVMe over fabrics spec 1.1a section 3.3 (p 27):

"A host that uses a single Host NQN may employ multiple Host Identifiers 
to designate elements of the host that access an NVM subsystem 
independently of each other (e.g., physical or logical partitions of the 
host). Alternatively, a host may employ multiple Host NQN values to 
cause each element to be treated as a separate host by an NVM subsystem."

And actually this was probably the idea of the initial implementation in 
the driver.

I've just fixed the bug in the implementation.


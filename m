Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992D5C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 00:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RazIXcuw//iDMnH0b08gx4yYDfs1QcoV0dV6sx/XQ2Q=; b=KmW2A9cb8YIhIo8dPV0Nrr/LBx
	ZRw7+1IHgzs6RqsdirgaQJSk3Ky/BexlOH15lmXS6A6RwVSpG1h+LJkSSsy+HYuQp/2f8VCbxrWUq
	XDwlNRbgQrzLnPfprajN3TX8US5Z01HT1W0IvyZvbUAn3jnvDVuE5kNeNyFUUtY3OvpsozEaoNI6W
	NaUU8EuLXUfNzFO3GFLKIgRyN8f5MjGZc0NOY5dEhEQ6otM/pTjFmFYJdk5FNilGoTj7F+yGwtn+0
	LaZB4Z11HgK+mrnU+Jo8LT9mVTYC+Vs8o1pmdnXbolZHer/DDO94UI6wC4LFvm7HuLNoss8QI6uMH
	kEfAkT+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSRQs-000wMu-2O;
	Wed, 24 Jan 2024 00:47:58 +0000
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2418::601] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSRQp-000wMO-15
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 00:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIjotGqv59OG2wVPzvQ+BPiAdApK4FAd+ySbrv++ruVy1BDHoxlSgOvAJTXkrCTJKFhdCb9T5tfazOeXOF4Iram4pkxhMfcfHQGVYr/wby5UJsrhi4kQWnk0JJwUJXC1zJJit3kullT1jpQv4K8wD2+vRNOvnOvLXpaHblrIO+zd2dwfjxSiKj9KZMyEFQY98FWpxu8Vq71S8gvZbnjsrwVuDvu1nWqwm4Ktcyk5nlxq9n5/9eFzMta2y3XtA9GEOmBoUBNFPjoW/SL+W956w6xHeLXbSpR/0iIkbaJMVfeWNTdm1TyzyT9W/q2tJ1XYSO7kjfrFBj9HwkynOeCORA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RazIXcuw//iDMnH0b08gx4yYDfs1QcoV0dV6sx/XQ2Q=;
 b=BUwjNmMkaXHVVl8kPOrkX8Pgo0HHzOAxf0kCp/p/BN6IQhNrtD9smxWiXa63nvauaoYh8WJtbEA5/8W9rXAIYLDmrieKIh47jY4bLJX9Ykud90PgxBasQodqJ8vF0NXVZhxqG+EKSkluwP1sIrWXi1hFg37HvefBttJ7iSO2G3+tRBKlLrckfwiHIEB0GMioWsQNs+8Lsjx5ht1ekvTYxQ6FOCKvjHKUk2X4nKlsjf3GyCQ7eBS96KemC1S/uUDixoKPHTXnM+WAMu0mswytaWsrS7DoPu6G5R+SmkTQ8g1I9XU8HI+HpU90g6tKsWRunVQWXrkkLkzPgV6w3MpazQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RazIXcuw//iDMnH0b08gx4yYDfs1QcoV0dV6sx/XQ2Q=;
 b=C3S6AuO9xWVZG8Mdqba5fJANOtSrYMKI3omv6k+fQKKvT3DJ1D5khTt1kctxQl+cGXU0NMiWqiwSc73wj29GT4zAVLa0/J+JN3UlZKugQyZn20OaA9xu1WUYAVZ3i0MAYULtM9l/p2gf6p4JjNCcUaQP/jnqJ6t6IWiAkb9bXXFogGXwI0xUfwku6Htqiwyn8o/3hQm7sVWocpgQF+Zdu3hDWCxXbVF9IjWs2RRPjoBtG/NRHfQ0a7FuIDUtaf+kiZDpYbeDViwlY0+EzNwSjAjClxNfUP3BcpNXmFeMQUcy/8DunWiweSW3ODak3FGm6q8SVpzK3oN0aCcoYj+vhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Wed, 24 Jan
 2024 00:47:39 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3%2]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 00:47:38 +0000
Message-ID: <f168e3d8-ddec-46cd-a032-2ca771b6cd23@nvidia.com>
Date: Wed, 24 Jan 2024 02:47:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
 oren@nvidia.com, israelr@nvidia.com, dwagner@suse.de, oevron@nvidia.com
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-6-mgurtovoy@nvidia.com> <20240123090231.GD30773@lst.de>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20240123090231.GD30773@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0362.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::14) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 30410820-68e2-4059-dd15-08dc1c76103d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXyvSaBlEckil3rdQUv/9xeXmSrZFqxMF7j+hKugJSZP/Iw0Sw9G1z70ApuTnhwwHjxjSYaTm5nurgzdwiYOmsj6fSCnEeSV6RH0QZTyNA9z/W4COg23rlS+rOOYDNYljiEH/XMHNVChIv4VlnPk/GaKpmNszvMwo5bv3YRsvLWQ8eMC+BykVr/Q5MZ3istWfPX7kgmMez4jLXCRgLyFpe+OuT8Ob+5Dgnfe4IitsokLHuRXBz3XjT7jkjDsoK9XbhCSMuULBxt8JmsaKT/OgyjoMCZ1dOE1ekHEX6VqXJTcb6Y0Rnf4zh9mIf7+3uI+oCVseRFz3aWFpZ3swKbS5jZ7/U8o5gNk610kloeZjbNj3iQXodY9rilclCr3xbO6R/L0kxEwx8TsUlbqXdxyb9PNWsMsZVMcYsTcDJQElfagdFVtu9h+BCDFwTc6mt0OXxgOm7LujtTPn4mH4lKEC8QtRfH0R+m5IW9VnFI1+aF1eVX2B+QE9A4NI8NMKZF0YfYR+scN1sUwumqPXIEMOhBJZL0zIjSbCsCG6BnPvABvwt5CTQfSqQAkLneCe3hU4nLj0m0aO2f8a3omkCSQ8sn/EsjlVz+7WKpYhi9vcaO007VoAM/9lQ64gGehuDU/TSEkUet7fD79aZD8Q/Lpww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(26005)(6512007)(107886003)(53546011)(6506007)(83380400001)(38100700002)(31686004)(6666004)(2616005)(316002)(66556008)(66946007)(86362001)(6916009)(8676002)(31696002)(478600001)(6486002)(4326008)(8936002)(66476007)(36756003)(41300700001)(4744005)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXlTbEN3WWp1QU8wN0xpNnhLNlJWUWVMUXdERzlpa1VlekdvZmw1Q3lYSTkx?=
 =?utf-8?B?cU9TazZHaDlFYVJNRS9qaktQN0ZUcTZBem04d2FNR0ZleFJxUi9YWFdyRmNk?=
 =?utf-8?B?N2JXRUxTSmw5VWVDWkt5bGJtd3dIbit6QlB4ZjNtNmVRRkJ6WHFabjA2WWRm?=
 =?utf-8?B?Z1hJTENmSGl0SjFBc0w1Q2lHS0pETnp3TzBFUnVsZUllRTJhYXFHQzZ1blBa?=
 =?utf-8?B?Slhrc2orWFA0dVBxcUw5Qy9CaW9SU1BhS1ZoWFhkV2NtTTdMbHc0SDlocXJl?=
 =?utf-8?B?ZmpWdUZ6NjV1bDEvOURoSzkvTTUyZmpXbWtPL29oVkNBeVR3aVlYdExYc3lR?=
 =?utf-8?B?dkZ6TnRxeTR5a2R6cC90RWR1Ym0ySjhQV2E2UklOY29nUG1DZDRFdWFhNTZ2?=
 =?utf-8?B?QitUcnVGbjBIcGhnWEdMQ05QWkxRTENzNUdRaDdkSW1acWVqN25rQ0lXU0xK?=
 =?utf-8?B?M3owdWVJcDJFNUFMTXRoUHhmWCtEOEllakxheCtmd0h2S2sxSENzQSs3MUZ3?=
 =?utf-8?B?aTJxSkdFY0ZUdDJWeEF4UHRWMzRMS1RUTEhYdXRxcWp6NjlLSEd2dTBFelhW?=
 =?utf-8?B?NnRpS01nR3JLTythM3V4OExqSWdlT2tVcFp3MHhaMVZUdnl3eHBGVEVqZW1l?=
 =?utf-8?B?dFVUcWJ4VEprSE92WFU5eDNxZFEzS3AzUUw2TFRmbXI1VjhaYU54MjVQSW8y?=
 =?utf-8?B?ZkYrQTFWQ0pZNWlDaWdEMVRyTERiVmNTc1gyNGlDaWg2V3EwYnNIM21aS0xq?=
 =?utf-8?B?MDBvWVlSL1pqY1o1UzRUZmdzNEk1NUJ4WHNjck1YcG94Tkd0QngyWGxUYmlI?=
 =?utf-8?B?SFd0SmVKL3pNOEx4Z25haHpoOVZ1eXdkTFJ0U3VvN2xRTFNhOExBNy9yalRE?=
 =?utf-8?B?Nm9VYTBiRVJ6bUNaeUlVY2J6RmIwYUZLYTIwSXRaVmxyZUdLM0tNRmYxaHZV?=
 =?utf-8?B?cGpvSXU3MjVKMmxvVXhHcXB5dklEeW5QdERkYWZWQk9tOTNBWVIwUFZ4cW9s?=
 =?utf-8?B?TWx5dFhnR3pPNEtJVzVmU2Q3VVplUTRaTkxFU3JDL2t6NDYwLzVpTFlYTU9V?=
 =?utf-8?B?bVBHRDZjdE9UV2UvK2hVRjBtMkRUS3VOaDBOeXpVTXJ5MWVySGVoVHJiZDJu?=
 =?utf-8?B?K2xvcU82MzhQTFhMVHJ6WmFEMnliOTBWV1JneXJnWkErOXlqQUJiZER6MUlr?=
 =?utf-8?B?UmdVWlNaS2JpdVlLN0FoVSs2T2NQMVllV0FNTDJTbFovWFErSmM3bWQ4ZUQz?=
 =?utf-8?B?YUpGM0hrcUFEdHFpQTI1YWRCaHI2NTQ3b2p1eUdsUjlRVFYvRzg3VEZtYnpu?=
 =?utf-8?B?dVhndXNtcVg4YmtqQksrdWhYTnN3N1hFSjAvVS9vYzFPNGRVL1Q0aG0xWnY0?=
 =?utf-8?B?cG5IK1dmRVFyblh0VVdwcVA1alFDbU5CKzQ5VlViNHNNQ1V3a3NMcUFCaFJI?=
 =?utf-8?B?OUFIbWpnY0ltOHZPSlRHMFd0djhPc3JsY2RDQVJxbEsxeDZFemZDL1M2bkVL?=
 =?utf-8?B?OWFxcU1EaDZRaU9CcE1Zbi9CMkM0OWpSR2g1UXlIR2wwam1aN3RNWGxtWHg0?=
 =?utf-8?B?c2ZMdi9xQnhoMXFuUVZaYzVwRDc5a1pGTnpkK2ZRWC8zVXRYSEYybEdnRlZS?=
 =?utf-8?B?VzByVndKZnRhcjY4eVRHWlg5UUZHMzlsVEVieW9ZMzdKcWxYOE96dXQ1UDB2?=
 =?utf-8?B?SEVUYU5YOVQ3Z3ZnMDZpMDFndi9acnN5R2RXZmJKSWZaY051N1lhc0pIamMw?=
 =?utf-8?B?RFN2YlFwMmk2UmtUdkJRZFlZOTgyWE1SaEdRSFd4WE1rZFFhTlVLaUhWazFV?=
 =?utf-8?B?Q0VWZU5VSDlndG55dFpNeFl5TzFLUDRteENLY1BlSmE3OVlVc3RBdlRXSXA0?=
 =?utf-8?B?YUlia2MvL0R1VTE0REZzbnhsaGw2b0xod21RMTJUVXlYOWppNkVxTWlLMm1i?=
 =?utf-8?B?NGFOcCt5b3pRMU83emN2cEdGeVNKUWhjZ1NKcTVDeTErZTF2TmJ1MkQycFZO?=
 =?utf-8?B?WS8yRjZQbG1XaUs2MHMxY1JWZlcvQXB5VGFPS1BXaVlHOE9kNmllRGU0eDBx?=
 =?utf-8?B?Y3NmNWlFRGo5U0ZrQ3c3bHNJZlMvOHhLUk9qNVlWVVV5MmQwcStnalJ2UjZP?=
 =?utf-8?Q?+tu6zpYZ/r2PY86d5Uov1QBP2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30410820-68e2-4059-dd15-08dc1c76103d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 00:47:38.6401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: peEWqGG2K9Q3wre2rKdbW2dUVibn61BZlrBA75r1MCh9TCiVmozioy5NF2Zzl0zXbDbYCwuH5qxcxY6gJuthZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_164755_396844_E7677487 
X-CRM114-Status: GOOD (  10.96  )
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



On 23/01/2024 11:02, Christoph Hellwig wrote:
> On Mon, Jan 22, 2024 at 04:56:56PM +0200, Max Gurtovoy wrote:
>> From: Ori Evron <oevron@nvidia.com>
>>
>> The namespace identifiers may change during the re-connection flow.
> 
> How?
> 

for example if a the PI was supported on the port before re-connection 
and wasn't supported after the re-connection.
We must first identify the namespace format/identifiers before kicking 
the old requests (otherwise we will get IO errors).
We must make sure that the identifiers are equal to the ns_head 
identifiers (otherwise we will remove the path from mpath and allocate a 
new ns_head).

maybe it will be simpler to reproduce if the namespace uuid/nguid change 
after re-connection (I didn't test this scenario)


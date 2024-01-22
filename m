Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294C0C47DAF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JuwmT12pDcupusfl61rf5ORjC4V4e6dNFCNK+UQSb7k=; b=suZp2NjGP9VDXhEjtAf1fYroI2
	DtJeqG0tg9hkDsfkSo1BzUk+PfycCHLOOXMOqKxRaALAcQkD7jpdhWMu6TAiXtHxx5s7XIoVbbxKX
	runeeOl34pGDMJD/bUvGGI9KIC8/FJ36Cre/PrFuyD09LAGUjkzY4LglpeTfZbeqQV0YwAS7ma39e
	s+jwnc0U2I6CkK2MqH7FUWbwV+A6K0lFioFnohILOkLq8ilKlP/Y5DdN4EqW14Wqs3+EjgGCezqiu
	iYvaZhmxNDdr34h4/U5hqzLWQEGHx831ztfsIeuAFe1LQPNXJTy81U9WuXFW7xsQvHM0IZE9KKzWg
	QEptH8+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRw3F-00CfGZ-0Y;
	Mon, 22 Jan 2024 15:17:29 +0000
Received: from mail-co1nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2416::600] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRw3B-00CfDN-2K
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 15:17:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAr1EvDN76kymGFtRTpe00Y7VPgSZTrrxBqcf+8wTGffOF2mBH6YYZuXkP2yHmrEyEuhICMbl/mYOky5LrMQK3pHfvExw2byE5JKl46X4zz++DQf8m7lQl/eAfkLfYMq59QIJWt7PC09EMbafHtX0TKgI0Rb1FoDAvE3USbfOP5vxemX9npgoxnhErV/XtKgMeCpkok18c2ynFc6N/QQyqF/q9nqguyVerNEYJJ/6dPEmt9TAOr6eW20EpvrlZnSNb6/JRsVw2uUBe03w8qAtXbSDSdkGcAJjPOXtnXkpbQe8mwwxoRq0zUrH0cxz5gcecIpA1LEr31ehSE4xCXt6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JuwmT12pDcupusfl61rf5ORjC4V4e6dNFCNK+UQSb7k=;
 b=XSR9AMLBbXOIKiJoVG10+Q35XzofNRbzCCxD2i0m+F2rP516THWgE2/qzjCP2BnxWNDJNQPvcIILgsAwKzAKtN+4VyjKgEoCS3gSyKUOmKmKVWQP6a2TI4M9S0MpMnMlNOgNv1MHqaHIQH5Tl+T0/hvdFajan/vrSA1eTTmiS0oVNBHtp7lBtjb6oIoP2DUCkBFoXhpwUfAySSiBTO2f0LCYix3tnZCVM7ypP5nSeD7ympnUlhModAOXjAyDTCUHNNQGd1PW/25uQ9M49UAPDNfOiiB7QSRMXdjW6JSilbv9DQiQ/kNThkEYoe/PxTZGQCZjxaUNb+p41ic+vFpMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuwmT12pDcupusfl61rf5ORjC4V4e6dNFCNK+UQSb7k=;
 b=dhjbK3fTHyySW5A0WcSwsmBcnbdZgIqgR8a29lTlJonNO3o6lV/utF8u/H+OVEfx9YJncMsxZkzWJHPqqCW4g4IbDBpgwQ1IolKqiNjRc9ShfpN9XZMYfqUFp1lRWfUfwXYiPAQdJJbSWJLXCx6sZT/rkKRqnreDe1iRP/2LJbWAKiapiCw102ra6EHGScQjvOEpGAni5jMZzDcbxV0mXjUzW4kB333gLexuo7ARUk2TkOCB/9IFv5PzP56oI1iJZvuT6VaORPL0i7YJKQGtU4/wlcUavee2ZL1FjJayPiP+AtVNMIAtXwDRtgHqGV1X7EeoEi4jW3MhT2rpfQ3dMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by CY5PR12MB6526.namprd12.prod.outlook.com (2603:10b6:930:31::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 15:17:17 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::92cf:d8be:2c70:83b3%2]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 15:17:17 +0000
Message-ID: <a4a17b72-84a7-4ace-ad15-5c7b3a54929e@nvidia.com>
Date: Mon, 22 Jan 2024 17:17:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] nvme-fabrics: add option to disallow T10-PI offload
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, oren@nvidia.com, israelr@nvidia.com,
 oevron@nvidia.com
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
 <20240122145659.5574-8-mgurtovoy@nvidia.com>
 <6gx7xdmm54po74oihiazqsdk4sln4h7754f5qx5lc7rxdhy4of@wip6kfi7yktr>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <6gx7xdmm54po74oihiazqsdk4sln4h7754f5qx5lc7rxdhy4of@wip6kfi7yktr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0188.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::17) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|CY5PR12MB6526:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fb378c0-3ded-41ab-9139-08dc1b5d3844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRmR/nqrfm3nu6Qz1sDEjoJOKd3uYMOehe9rMy+KvWpoEAyceG3UC45PUfAk402oeoSOHPs4koe4N7XeB8mQhir0D4+70ancG7n7ilLCa9jH4So416MpQ7XBSkypgYWkH3ZCHxK1jTBz8y8OKjgtZFP9fDQp1eBYvROkTwzNmL+Vhpywo0BqNPH4M/wHvf/G1+uQ47WWjj1tDsgIKKnxxuEP8CUB58IIcWz2ixnHkyg2Iv5ULg/t+pgQdBxsnsR6rtuIFuLjtx/9UVUsde3JODF5eXJcz8TWkRlR4qV5VW/SVGjd34UlMsKD1kxx20QeG/BmTERk8FWCofN8NZVEwqTW8eNvDg7UxdJeExZZvbHYeftjMfmeX2jqJL/hqJm0TWf/486YKGTK3iicevDF3gYnF5BVZkGfLuj/mz3rSOn29Xy6cp9CeUKHBRw2yCefmjNPLJcNfFmfmEI3RssupvuGHdZq60AngLdEX+xsYf1WpYaViUNNatffSxlSLLby8yB5cd9U0xbbhO75q+Xw/uxQu54+urpY3kMKKXigRzPGHyYPM4cGqQITBWAPzZ6u3rJ5v3R4MtdV+/42a6vW65bqlqCvDckaBmnr3bSntNlxeu00OPeEVvzubE/s4QF3Bxqg4JmoBzmWDeiRSfBPRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(26005)(4744005)(2906002)(6506007)(53546011)(6666004)(6512007)(2616005)(107886003)(38100700002)(31686004)(66556008)(66946007)(86362001)(66476007)(36756003)(478600001)(6486002)(8936002)(8676002)(4326008)(31696002)(5660300002)(316002)(6916009)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUpGQUFwZWxlMnFvQ1g0d2c4bEk1V2plZ1ZNZGIzYVBrWjFmUFRlbHFaV2Jj?=
 =?utf-8?B?VXU3UU80TTVMdi80N2kyZnRoOWlXVkJwMEtYZll5angzamYzY2hQeWRqR3BD?=
 =?utf-8?B?Q0dUNlZtdnlzTU1JTGZhR3lXdmRFMzZQcTQ0VVBzN0RnSk5RUGQ0TjkwQnpn?=
 =?utf-8?B?ek1VdTgzK2RuRmN2UkVSSzdYUi9uQkhZZ2NhUnBxcldYSkhMdGsyOW10Z2Mx?=
 =?utf-8?B?U05HYk9KZ293NVVPcFhMbHVPV1VvaHdDbjVpZFROZUdUS1VLNVVURlhYemNF?=
 =?utf-8?B?VUJ1dUNYblh0bzZKSlpWUlozc2dPMnlGdUlJZXZaOWxvem5lU1E5OVJUU1lX?=
 =?utf-8?B?Rm82S05xRnNMVzY4ZkhkdDgxQXNObGxOeWFIS05US2s3eXpjcXdjMFJhY01V?=
 =?utf-8?B?RXRtTnpHZnhyN21oMDgyVWdZanpWQklTWkFyeURPVUJCSlN5emtQRk5Ucjcz?=
 =?utf-8?B?YjhMcEZ0Q3U2eWxtem1WRHR4ME9LV1JTejdUWnpIU1Vub3dlTDFnekJ2Sk1G?=
 =?utf-8?B?YlhCVGJJN280RktHbmM0YXNDQ3A4UjZKNFVzVkUwc1JoWFJxMjRyMXI2ZTM2?=
 =?utf-8?B?VjRsanNObkdET0tIeUszZWd1cDBsR3EvU2JkQlRFYUN4QXZzSFBRUmMrY0RT?=
 =?utf-8?B?N2V2QkVncXlpQm15dEV2akw3a2FuR3JmNVdEZmZrUGEyOHVZUTkwS2sxUDdq?=
 =?utf-8?B?bzdyVFZ6NytqZTZHRkJtY0tmYXA3YnRLOFkvOXBsdXpodDFiTisyUkdkZm0v?=
 =?utf-8?B?Ny8yUGo2aElmZXU4MTk3T0Z6VVdIcDcrcHJzTTFRV1Q2N3RJVStleXlZV1JQ?=
 =?utf-8?B?UnNTSXVUVkdqR0VQdHlELzRhR1FHd0pBdFkrVk5sQm1FcUxTVTNJZjhsa0Vo?=
 =?utf-8?B?ZXN3SU5xVEorOU9xV0xaOVdaeHpvY3pQSzdWNkNzSWJxN0svQVJvR2RqbDNq?=
 =?utf-8?B?SHNTSS94bXF2aTdOY2FFdTRmbVhYMktRNmhQZ2E0cDlUYlNDdlFMNWZBdVVD?=
 =?utf-8?B?Z0pQa3lNbHlvOW44bGVXRlYxQzA1cFZRUUp2SXdTZFVuWk5LSE40NVA3a04w?=
 =?utf-8?B?ZDRkME53TGcwTm1TSW1EVWZZclRnWUQxUjJYa29nUUxHV3JMVUhHUUQ0RUhw?=
 =?utf-8?B?WUxOUlBFNitOcDluSXFUTEtlTmdFczhVcmprYjIyL2xTVm8zMExFbnk2aHhk?=
 =?utf-8?B?R2thMVE1N1BzQ01HYUJRQ0N0NkdFNU9OWHNHeGFMZVJDblRvYmJvZkU5VGhu?=
 =?utf-8?B?V0tGbkZtb29tZVpacEQrckliY2ZLSkROQlhoaGIvY3hyR2gya3ovZHJOOVlE?=
 =?utf-8?B?QWZEUHFCcEZHNmZvYzJrUDdmLzF6QUJQU1RkVXpDRnNkY2lMcHFHQW1ST293?=
 =?utf-8?B?aEY4VEJrWHFqWUJ3Mk9ZaGJWMTFVLzlrMW90bW5TaEp2WmdjRUVieEFYd3dr?=
 =?utf-8?B?aUcvOTRWbUlrbFE2R1JlZFJBM21sNHdVZkZyT0djVm1FYjBmaFhUYzR3UStP?=
 =?utf-8?B?OEdJZUdOcEw1cm5TWk0raUpFbWw0SWVSR0VOcmN4L1pVWXhBYkR5dnBNNGxt?=
 =?utf-8?B?RDM3dHp6eW5abVdJcXExeHBJSlZlc2IrVlVHS2F6TTEwbTU0aTZadURwd1dx?=
 =?utf-8?B?SmNLMjdGWlhGRTNlYTB3T2xHd25tcFIzZU1PSDM4dGlqMldtTmlsaFdlZG9k?=
 =?utf-8?B?bDZIbFJNdk16emJudTZGT0gyb2tIMDNyVkVuM3VDeDBDWUFFdGdJZG5qVXRq?=
 =?utf-8?B?Y3cxWmFNUStFSCtZRTYvUlZCOTNIZHVMMGVEdlBIdjBUTVh4YU9yTnhyUjJU?=
 =?utf-8?B?cHBERmFiem1Bd21oQ1ZHaUpJUERxYXJ6WllIZmRuWkdTQW5PVG1SSjN6WTFB?=
 =?utf-8?B?cVZKaG9zc1YyUHBJMkdiSWxUa0hwTVh1NzQyUldMQ1BQdzc2dmJzak11Y0ZP?=
 =?utf-8?B?NjJPTlB2bHNMZXhTQi9xMmxKektKSWM5bUhPYnZ1Z1lrWW5jUlJFUGJTd1dL?=
 =?utf-8?B?UUp3U3hyd0NoWjQ0bkN0SEx0cG9SaitrMXRsRVU5WVNpT0ljOEFzR0o2bThs?=
 =?utf-8?B?M3h0MUVkeXZFcE5GY2J6QzZmNERzMjBRcWMvY1docy9JazYxQWl1Z01IMS8z?=
 =?utf-8?B?TGRBaUQ1Tzc4czd3b0greUJ5Z2l3QmNVOTFvdVVDUnFhdUVtSno5SG9sYUlv?=
 =?utf-8?B?OHc9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fb378c0-3ded-41ab-9139-08dc1b5d3844
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 15:17:17.2363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+Digj9fiUUXXYzGUYxu+HlpeldIxeymrRsZC/g34CylWBIlyVbawrlAsbP4C4J36lAyjObTN0t5oxLts8vuHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6526
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_071725_759647_41F1E7C4 
X-CRM114-Status: UNSURE (   9.29  )
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



On 22/01/2024 17:13, Daniel Wagner wrote:
> On Mon, Jan 22, 2024 at 04:56:58PM +0200, Max Gurtovoy wrote:
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -673,6 +673,9 @@ static const match_table_t opt_tokens = {
>>   #endif
>>   #ifdef CONFIG_NVME_TCP_TLS
>>   	{ NVMF_OPT_TLS,			"tls"			},
>> +#endif
>> +#ifdef CONFIG_BLK_DEV_INTEGRITY
>> +	{ NVMF_OPT_DISALLOW_PI,		"disallow_pi"		},
> 
> What about 'enable_pi' instead of the inverted boolean logic?

we can't change the default behavior (that is "enable" by default).


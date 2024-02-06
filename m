Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0527C4828D
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 00:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+xGEpR0IY/lDrX2UYsLIRMxwyEeTU0WdbL2MZFQa8Bg=; b=PwmFFicgLeiRjHik6aTQlUVAYI
	gb+8AnFucMX4v3MrHRJGvFR4Ci1yYtGw8PGnXula+uWeZwQXRN9gfcdqtmkhE4GuZgbnIJsozTWB4
	+SajB2qtAREKlT+QZPXdn965qKBwQVoULPh05SpuoDyJDvOkt18u9uyNdTl2QSRt28fnahTNDuhE6
	kmpAFxw9byB9pyKHLeHJJywpDchUoVGJ7edT8TQqmvrLLMYrn9e9rAVxn9HKgNxx/YOjeaiokdvIV
	vXL7bOtogN+8S+Nd0iH3Rf1oBJ9jsDt8qp0rlVB8qqvezAiPc/rmket2zjYOvtVVoxPDCA35u7UwU
	JUK3Fz2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX9T6-00000005eEk-0tVB;
	Tue, 06 Feb 2024 00:37:44 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX9T2-00000005eED-1Fce
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 00:37:41 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415LG4Vj020812;
	Tue, 6 Feb 2024 00:37:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+xGEpR0IY/lDrX2UYsLIRMxwyEeTU0WdbL2MZFQa8Bg=;
 b=an87+JsXX9gt6rGtVdV6qOJ1MHdP1TuH6HDOjaZ/+MrKAI+Ig6eyjU3gWj4Mz0PynwFF
 JAQ6f+i+yo5oemDB3qxNtF3kMuFl53v0BjySa/lg+yxxQ4Gs/vsNVgWU3VO7DtVxvNXL
 SUx7H4BxaA9nPDNF46u9qydsE5fKN4y4ApEcKawIqMjjhyOxAWpfZaz78NJWPYslBRpr
 YLlwA6gHYn+/s70mNJ9wx/xWKw7W0L9LsMXNd3NVOEd0e4K+NpTz4Wpp1wCI5WWFvM6w
 +wb9+LfrxN07jL4AhPRHauzPUzEz+hH1lL0gov6ngzX1M7xUxlxZ9+pkgoekgVH2oRsh dA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3w1dcbdbn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 00:37:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41604Q6m039528;
	Tue, 6 Feb 2024 00:37:33 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx6accb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Feb 2024 00:37:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bhr7S2wGonrES+gDQyRz+KeIAZmH99KPQ8QpzvxTtosSe8FqtntsqxK0V20GQ6d4wj+P7b+bKsVrdIKKtuC9a2qcI4eCypyrNKwfSo/s2Gdun+1cFUrPAUZ4aFAO/MTT/Ej2qwKDl6MD5+pKJRG6+AkrZFovx9HhMQVEiLTi48W7GfbDaFBO7Ksun6+uprMfsBSp19p/NJk4tTRALABvKbFTuBmRjmsCQNm1alPfAq8fZ6vfzq+lCj9iHgKl+AxQfL9FPVq+D5yes7QnJMs9Q2E8xBnqfv1x3otdyeq60dgdqR9MlBVn/y2dfQyD9BOK4vDSQJLLkHhSSaQhTmFD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xGEpR0IY/lDrX2UYsLIRMxwyEeTU0WdbL2MZFQa8Bg=;
 b=AbrmGc67ZjG3hG62HvhIdX2xWIjfmmX+dTVKgpyPY0fT1z/BL7Yc1aSE3PaEuxH6ZTOWNU1xAj8SOKNtcEehIGlu7UaIg9xY4LxWPh8+6r4Vdb6rA4lksnlbTcbnadBJDHySDtz4P21eWkVK+wfvdYb5JWRfVaJBzgsi2bYZewSBK7X6aJtBhRd4ygOK3bVJPuKvmv5nf+jKvIBYf9CaD6CTwmCSUFG7uZJO+mWbbZ1dyIiuArtpafR6PBz9G73AhIoOz0dwxwO+1cfoNZFt/l3XDyu6XWIHTX1iuiRbcDbc1FCkIqF3xghSfgEy5AzykYDcDbYKW5ywEnnlS9zchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+xGEpR0IY/lDrX2UYsLIRMxwyEeTU0WdbL2MZFQa8Bg=;
 b=f1u3J4hJC2gMAr+eNymTdNTr3HOrKMVJHAFZlCfmGbbp1vx1IZSqeNP1DdKWbMuKe3a+ZndukbdYYnKOma4ZZowkkdXFenAIEzRpYfnZi5L6OwwUwGjIIqaUfC6bESvlxzMDlyPwhbAU/HjjIbro2OFUtoXV858goa4EDwbSdnA=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by MW4PR10MB6582.namprd10.prod.outlook.com (2603:10b6:303:229::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 00:37:31 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::990:8aa3:7ad4:6dfe%7]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 00:37:31 +0000
Message-ID: <f4114934-b495-4718-b494-4b74ab1a00a0@oracle.com>
Date: Mon, 5 Feb 2024 16:37:28 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-core: fix comment to reflect right functions
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org
References: <20240206003021.6422-1-kch@nvidia.com>
From: alan.adamson@oracle.com
In-Reply-To: <20240206003021.6422-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:40::19) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|MW4PR10MB6582:EE_
X-MS-Office365-Filtering-Correlation-Id: 30acca5c-e5a5-420a-8b61-08dc26abcd88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bj+hccA69FKJrxGQI65f8MxPyXgjdMpu7bmuY3CdT/bComn1CqpmZgSSttpNaOS2/BT6VrD6lRv6iN/2/vKXNaw2amLNgTItnFTcOKk1qw/htlSY1uxCcu+PrFIbjsdJ0JjS/EnofTVJhSczkHguQ70FGDshk/K2fFkPbcYrOssRl5tGMhatEAGDSyxmzgEodQiWyrZYX8KMnNR5JIykYgEpuDMLUWdqy/RPSDxwnKjiYRZAhg60jGEBFxgOuYkAiwOzUgOvGt8YcnLKAZbTrllvXz9yJbSYhYO0XA5wPr8r2nXf9mkyr/EK6iaOpkt9+B9/Exs47yQXzkLTmmUG7kyFJ0GqrA2JahOIQVM7STj+/MNR3SghgE793WQSHi/TsPJrIezmi8u/0ZXw9eC+VfnFmBzOEbVcroadnsn3u9+XwkIEdommyBazpy6gTlOFoVUBhpKX9Bf8C8BJrt3s1wsPM0/v3yIV6onsg/JAiVAlfKR4tOmXerX8U1XMRD7v6lImf0fjVlUr8I8eb0U7D2e3i2r0B4FH2UcNHUt8XKyMx3XO6FdwHsGp5sNBDAJ77jhAIeGyoCUu/ZtkPxNMOwW7DIn869Va19n1DwJCcco=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(31696002)(86362001)(2616005)(41300700001)(26005)(6486002)(5660300002)(2906002)(478600001)(66946007)(6916009)(66476007)(66556008)(316002)(4326008)(8936002)(8676002)(36756003)(9686003)(6512007)(6506007)(53546011)(6666004)(38100700002)(31686004)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2ZlZDZrZHJ0ZFdLWEpmYmlDQjNIbnZWNE1iUzQ1ZElBRm43L1NMaDBBS2cx?=
 =?utf-8?B?dkI0YThsdGFoYWJOM0IvUGhUTmx1S2RTNWhiMlVDWWpvaTIyaDZ6WnpHNkxs?=
 =?utf-8?B?aDNpQ1JDSEpYM0dEVFkwL0JvTm9ZQ0NoZU5HR1hybmtuNkViekFGR3hVYm5Q?=
 =?utf-8?B?Z044L004Ris4OHg2VW45WlpHYzRldDIrakNOcXZsQ0tOZDhYMEpLMlMxSWZi?=
 =?utf-8?B?bk9pcHpRZTBQeWRJc2IzZUZLeVh2b1Q4NVdhalM1YTVQNnBoNm55T0hWazhD?=
 =?utf-8?B?T2p2U0VzckZ4QU44UHQwaUlJdXZWSVR6cllUbUJsMjdNY2wvQzc1ZjBxNWt3?=
 =?utf-8?B?MUx1a1dzR3QrZUFqZjdKblpyYkgrY1NuclNSdnNGalovQ29lcUVxYjcyeVlh?=
 =?utf-8?B?cGF1RGpWV0RrRWdXRFptaXl1eXZ4cS9kQlNnSTlybUkzYzVXZmFuaFB4L2Fh?=
 =?utf-8?B?L1JOWDFFeFV2T2FWQXViSlpweU5sNDE1aitaNENNUmRib0tubHNEajdrM0R5?=
 =?utf-8?B?Z1N0WDVkQU5tM3NpN1hrMUZNQlhPK2I1bzVUQk9OS3NZLzBPa2tTOEd1MVZj?=
 =?utf-8?B?bHgvNEdSd3psMEg2ZHRqRDNPaVVEY2dGcG12MHlURXVJN0k5VXZjZlZpNXdL?=
 =?utf-8?B?NG1UQWRjV1NaamZsK2dpNFkyOGhGK09HNFNLa3hZWjVOSkdadkhMeDNaTlJh?=
 =?utf-8?B?SXJqL2lhazJVT0hML3Jzdy9yZUI1OXA3VlVtVjVjUXdiaUNKUkJ6b28yanFo?=
 =?utf-8?B?dWY2ZjdBT1FBTjZGR2kxU0pFWUFMWXZoa2pUZ25CMWdId1JZUnlDY2p2Qk9I?=
 =?utf-8?B?TGxybG9ZTGxLVGJEVmRJZzJPaGo0eFNmY3psYjFnVlZxYTNNTko1bEU3NEVP?=
 =?utf-8?B?MXFwbWxYUDZkbnd2RjJXZ3VqaTlrMlVRWEZFT1RhL2loTjJ3WEtWY2MrUDRM?=
 =?utf-8?B?S2FoV0kxTHFRTGZyRlZNVnVjbFFBK3VEckNaOE5NM0RpOHdpT1p5Q2xmUnh3?=
 =?utf-8?B?RVdJVlFKcjlraThheCsxSkl0NzljTFNvVWdScW0rVWh4ZTd2TjBnWDcyQWxV?=
 =?utf-8?B?bzZ1b1ByOEExcGF5RnVSczlHZnkzMnhiZGcvbkN5TmJtUFYrempla3pvSXhs?=
 =?utf-8?B?ZjlrMHdrdUY3NFdUaVUzQlRTOG1BVTRmbUdwbThaRTRaS1JKUEUwZ2pVdWM5?=
 =?utf-8?B?SmRqd1J3cWQ0Slo5eCtlQldqY0dhaTlzb3Y1bDJXajl4SEVPa1pEbUphUlZl?=
 =?utf-8?B?K3VZbGFMMWVXZmtOOXlQY3FjQ2NrWEpjL1lNcjFsU2h1bEs4LzlvWEsxY1A1?=
 =?utf-8?B?cHVGNnZqN1FrTmNpVWlIcCtWSmRhc01WV25DUGczbVMwREkwbytuUVRvZFcy?=
 =?utf-8?B?eExxMzhsREpGdzJRTW1BUEhjL1A1eFo3SmptTXJ2UkhkaDVHcHNyMjBGK3px?=
 =?utf-8?B?dGM5RWNxZG93SUpObmEvbmdKYm9MUlFMZnlNV01GRjVIcW5qUGFHTEtuaGlF?=
 =?utf-8?B?RUNmUlJVT2pDOWZGSDFtTEZHMi95Y1Nha2hYOU4vRnkxN01vSUxiODk2N2ht?=
 =?utf-8?B?MjNhV1dwY1crWi82SkUxQkwxVEdBbUNqdWRybEhVZ2NLNkhqNEQzSHlZMWlu?=
 =?utf-8?B?L2U1K2FTTFJkK3VBR1NYdmhXYTJUZ1FhOG5xNkVnMmRteHB2OFNYOTY4bk95?=
 =?utf-8?B?R2thVVE5SVc1dlc4cVF2M04vdjdCNEJ5MW1reWdxWGlpYVZ6dDJaZkhvL0tY?=
 =?utf-8?B?RHlRd2w1RlVxWTFjMmJyOHdDbnFpV3AzaVRINUowNzFNQUYyRG0zNTFvTmUv?=
 =?utf-8?B?SmtPOWpHcXNrYnkzR3lUdDVEWElJUGdqeG42b0pVNkRwb2NWVS9xUThLUXRt?=
 =?utf-8?B?emZnMmxzUUhkWno2ejJvQWtRM2hrYlROR3A3dW5pK0FLbDZCUFRpR2E4UFJj?=
 =?utf-8?B?WWJzUWlFOWY4elJiTzY1RGhYQzRGamJQcUZQYUc3MFFOUFZ6REVlTnUzL1py?=
 =?utf-8?B?S0dGY0NkZDFNYTN0VjZXaERJSFZUNzhlYm8rMS9lMEdQKzZiUWZDM1RQckdP?=
 =?utf-8?B?R3hPUHczOFZBVjhlblhrdUtJWWR2Vkd1YlZZaDI2cUl5ZVpkcWZMczJ5Yk40?=
 =?utf-8?Q?dlht6BgKcZpGviu5X8a2vk/Y5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ercrDAvI2wpe3BQFg37Sg5c4fJ5R1y1nATtbtJaStKv+b//dxWEOaYmGRZgSy9pNHxD5Hn3vKUs4hiMyX+bf9hD5pZBasH7y96Nf6eUd79Wt8vVSpEJYWKPTsFWRCKHO3K6m7W0JBdO2/XGjAVDsJ0GzQkqHxW6GrMSVhQZ4s1p259m/gsxsKn7jEPOtdZgfmEnItIrkJNHbRN1VZUAESOCXJQ7B2kDuPXqJegdJ2qzKJ3CrJKHT/XT7TefsYMUYY6HvBKcCnjyjHrp7YhtKXjzl1nCy063LaJ6TFO7t/HN2Vi2DAt5TdL18+cNRyvGSXIp1PQnPVvfNaaBDGbdNexBZ7//LoH1O/FVa7fVDd3p7HEHB7p9eowK2S5r+AjhOxDtPRVaOYX6wt0HL64vdNNH/J6/UUtiFmHmLktv6JKhNFgjgwsAJncUz0ewuY3H0x2L0wpIgt7vAh3ZBxb8Oyx1tKjX++a5Jp6bkCx5HFUhGaUA3b0DpGZ5z6YOeyVe2ifDHYGw5FlBkAGfW55rD0krSpfefRbEpqUAWltpuk2BneML/qB+e2Kz/oh72ceXUsuunFGtAVBmbLvcAvqaHiU5XzgsYdScMlY8aGO8eE74=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30acca5c-e5a5-420a-8b61-08dc26abcd88
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 00:37:31.1212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wRPzor1GP7WcexADPATRGN7O87Md8yzXojwyLDZPfEA4FuLBJ+5FqSHIbXD2i0U/Ybr5KVi6h0oe9M5UYW0gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6582
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402060002
X-Proofpoint-GUID: IIdCTr7Znom_oy9G6vHFV1HryiYaDlAy
X-Proofpoint-ORIG-GUID: IIdCTr7Znom_oy9G6vHFV1HryiYaDlAy
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_163740_633811_91BF11A0 
X-CRM114-Status: GOOD (  20.40  )
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

Reviewed-by: Alan Adamson <alan.adamson@oracle.com>

On 2/5/24 4:30 PM, Chaitanya Kulkarni wrote:
> The functions and the attribute listed in the comment doesn't exists in
> the code, (ns->logging_enabled, nvme_passthru_err_log_enabled_store()
> and nvme_passthru_err_log_enabled_show())
>
> Update the comment with right function names and a comment
> ns->passthru_err_log_enabled, nvme_io_passthru_err_log_enabled_store()
> and nvme_io_passthru_err_log_enabled_show().
>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>   drivers/nvme/host/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 975245527c1f..7db700b2ed00 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3762,8 +3762,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   
>   	/*
>   	 * Set ns->disk->device->driver_data to ns so we can access
> -	 * ns->logging_enabled in nvme_passthru_err_log_enabled_store() and
> -	 * nvme_passthru_err_log_enabled_show().
> +	 * ns->passthru_err_log_enabled in
> +	 * nvme_io_passthru_err_log_enabled_[store | show]().
>   	 */
>   	dev_set_drvdata(disk_to_dev(ns->disk), ns);
>   


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B59C36005
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 10:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m+rRamjNYvzTCVf4bGueMOe+1SLaOtzJ9OIM/9+q6RQ=; b=YZeUXMazExl6oqYFtdaMZZt6Qo
	4/lQ6JVPj7b5A6AToguXYVsTGAsCLkkHct2RHAbV5EMB+wFzLXKGEl2r5F4TGARXaJi8Bo5gD3nka
	bnQ9Eny9AadpmfGWC1xKMaQbxvmrNdqgwbOeVBb9IMfI97bb0RnZjD6y12abhSRNqtI51wIA8Ay07
	TGBdyICAy11QVv5hS3fRbNFERGtSFC5SKTBw5u2mbp009i+F8ylWA227Z5XjeMPT8SqqeZqQRGseq
	WjukDqYcmYhtaJ1GlDJork1NKZBnYkXXJpFdqG2GTmLH47UG0CgtEZEE2V0NK2GHyZqL2xeiW505J
	kD74QN9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Lpw-00000005oIT-0Suc;
	Mon, 28 Apr 2025 10:35:44 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Lpt-00000005oHc-0GOa
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 10:35:42 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SAYC75021682;
	Mon, 28 Apr 2025 10:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=m+rRamjNYvzTCVf4bGueMOe+1SLaOtzJ9OIM/9+q6RQ=; b=
	mQoKhnFtJ0549ObR08RE+QBE/nwnAZtma4AUaXx1fMTCOFo+eJ/qdlwUg3vc/cB5
	r6FkheVfmHZ3NAKlR05hbrEkaPzWW1ljs77xzavTZ49E7+qCoA3py1aaa0ZzFbyF
	G6R7XZp/6Vn7Gy24t1xl6MePzQkqSDwM8DoNgaz32Ej0ZVtkYyFz89vHkVeFA0Lr
	bRMYdrWEBrIqa3t3pFBDxDViPhm1ME5rWqucB5/MO/PtdlLBwo2RViqCtI+pDb0y
	/29XEl4GpFJ+8WrsenoDbuvgUNg17zF0YNshbbgh2UHsfObE1td+8xkcgp2ARMUo
	WXU8Zpbg0DSHz3X189MxWA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46a817803h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 10:35:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53S9e1BZ006847;
	Mon, 28 Apr 2025 10:35:17 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazlp17012038.outbound.protection.outlook.com [40.93.6.38])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nx803f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 10:35:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X+sComg2YIxMnDVmENZ9K+MgvADQGUEUb87g3l3axKUL1SlTFU5p7EsHKMJWMKsusOe+otxDtopBj29rBitDkBv9e7YKtiyJFOefdDapFYdvEU3Nxd1T3Gi84AP0wDhLSYWCVdgxx0/zE0kDg5uBxH8Ab1UKnslwlW/TiyNXcX9zKpHF+MCJRHOMMZVhpwpm/X9uLAg35GEjy1yduGoGnFwIc+EDj3d4NeXKmxrA+PT5weXvd3S3pv1AIKOXiKg5fjz3ZDyxeJ+TLoS0LRIrU+rpGwXKk2l/kSMpgImg6lcIG6Jwqv/HZGztoe3JmTPuxpReF0kSC6RgCOLZwgj3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+rRamjNYvzTCVf4bGueMOe+1SLaOtzJ9OIM/9+q6RQ=;
 b=tBUBfrFlyj1Z7/huGStXMis03V+ffWUCpv4IelQWn9lb04HvF2SKAbvOwPB8fbHfOkH/I2X1ClXMnHZQQ2gxnpSHxXCwNnVlfvBgbO/1jwDdgBciMM8CmGZwHvxt1tsuzNMepximRCXZHtdcjhq7jgbOTBDjhoNpDo6o1s2ZG4CEn8NAyhh0rCwsIZ8VmP2xMEXDe9D95uvJJUVUHKWV1oYVFoP2MxLwt8U6e7hhw0IAk9j0H7FBe2v4O3TLYeGZT2Oq/lxuw12VgP5VbJp6ZxisyXiVrP5N61RcFbRsq5N2jKMs+fV9mi7fqBAplW8EJYg0RapFih1+wumKuFcq8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+rRamjNYvzTCVf4bGueMOe+1SLaOtzJ9OIM/9+q6RQ=;
 b=Kxz3JGj3zTRAbx8o5EBuMB+tTY/RT9L230frF7WtCfLRgL4XVKrwToiPR+MqqCO20DtsdzBziZI1TM67QfSf1WjdrLCvWRLuoeUyUFa/waL+af7bvgii92AIyiLKYFBIwH3pEGPl1lWojyrC/+WNLvcdg20/cEszHA30NOuR3q0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH3PPF1D715CB68.namprd10.prod.outlook.com (2603:10b6:518:1::78d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 10:35:15 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 10:35:15 +0000
Message-ID: <cb443e86-2639-4ed5-8d9c-00aa5e200f7e@oracle.com>
Date: Mon, 28 Apr 2025 11:35:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] dmapool: add NUMA affinity support
To: Caleb Sander Mateos <csander@purestorage.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20250426020636.34355-1-csander@purestorage.com>
 <20250426020636.34355-2-csander@purestorage.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250426020636.34355-2-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P195CA0026.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH3PPF1D715CB68:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b00f110-f344-42dd-a08a-08dd86405cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXpXNnUxcmxDNmRteW4wL3hkVVJBY3htTHZJOTlZNGNiVitQeklhMGlzR0d0?=
 =?utf-8?B?cWdQSVRCVXBDNC9FbnVSRXZXK04ycGVDeC8zUUN6UGR5aHY4TVhvbkd0TUZO?=
 =?utf-8?B?TmV0ZWR6MGpBUTJZdmFuc2dHakNMdklCRlZ0aGNMbTJRTUhRR2p2Q2Q0VXg5?=
 =?utf-8?B?OXBhbUlHZUZ2UjR6OTVqeWd0QW5xdjd0bHB1OWcvOXRXSjB4YVNkWitPQ3lh?=
 =?utf-8?B?U0JVMjMyNmFjUVBpWVk0eTA3akprbWtVSTBTZFdnaTBFSm4yenR4Mm1Ya3Jj?=
 =?utf-8?B?QVVpZmVjYUlIYURUZE5mUkI1cEswQXYvcm1FOUZ3NjlWNlZxdXZzbkYzdk1R?=
 =?utf-8?B?dDV5aVV0QmYwSXFQT1BrbE1rN0lMVmxJd01KUkFYdllzMkQxVk9wQmxwbmE4?=
 =?utf-8?B?OTBrcHE3UFVRM2tvV21hdlRzZXdVRWxDM2ZwYS9LNWprY1NQV2kzWnNSY0hq?=
 =?utf-8?B?aVRCaitGQ2YwR3oyWS9uN3JneGFnVUpYdnhrZVdmTlYvb0E5MEpTMGF3bFBW?=
 =?utf-8?B?aFlIVjV2SjRESngwMkJuRm8zRmFyY0pNbGhFWmt5enNWb0wvQ1VMNzE0V1dv?=
 =?utf-8?B?RzEzRy9KOXNOUnZBbzRITXdJM1lhazJPanNnU2RWT1l5N2NuZG0zL0tBRlFq?=
 =?utf-8?B?RHVOMzJHZG5DR2t0aDlxcHFaeUtGbExuQlhkZHgwOGNkZU1hVWZYMS92ZGox?=
 =?utf-8?B?eU9HMFVzeTk2aUlXVDFxc29ONnR6NVpiNFVhMjVLZmFpeWZqNmVDbUVlZ3FZ?=
 =?utf-8?B?aklzRWFrOEhMNW5zTmxXSmFFbTBTNlFWMlVtOVQxL0Z1UERFTzJMOFpnWFNa?=
 =?utf-8?B?Q0xQUkR0bmdGOUpCZDVuUnpTN0ROWXJGT2RCSWZTSUZEM1dBL2tyTzdDVGtM?=
 =?utf-8?B?STJxMFZScUtRa2RuT3l6UkpuMzErK3pldUJycXpOeTZHZ1dQUW1KUXJTRHJO?=
 =?utf-8?B?YnRsb0tKSmpIN05sTHduV2VnVTZQNGRXQnVBWXlENTgyQnpIaUVSbTF5c3dn?=
 =?utf-8?B?L3ZQTXIzSHI0NE9XT0xBbU0vcWxwUFRsY1hsTWNKWGQzcEYrTGZyb1ovQjZ0?=
 =?utf-8?B?azU3R2c0V2xaV3lKMDhuQkxCSXhPQU1DdHhFWGFDY08zT0FkRG8zR1pRVWVn?=
 =?utf-8?B?eHZrU0lJWFRNUDM1WU1JNUJ2REpjOXRXUVh1VExoSENGbXJ0a3psQ3ltekxP?=
 =?utf-8?B?Y3VvZTBOVEM3QkVSQkk5YUxOeGliMG1OSG40RnljR1JPVExPU0VjbkNkUE8y?=
 =?utf-8?B?Snd0dzU0aTRid0hIQnRvTTFjRURyY1FPSTZLKzhhOFB2cVdVWExWTkdGWVdk?=
 =?utf-8?B?VWlZSWFLMUJPR0RjT0hsSmFrWWt2YzcxeHI3TWtteVdSdElZeHJYTFB0ZWEr?=
 =?utf-8?B?Y3JRVjE4OWVIQ2ppRjRnUXljajRIM3VrU1R1ODRsRFFMTXJqRldETi9lUmNu?=
 =?utf-8?B?Sk9QWGlSTEdiR0EvUmdETExrK250QkxtOFNjdG1lUk13bFFmM1NzVnR4bk50?=
 =?utf-8?B?UGVkam00aEVhMkZGRzQrUXRNU0ttQzNwMmhsZUJheTJYM0VIblk3MEl1ZHJy?=
 =?utf-8?B?RW5zNXBoQW55b1dDWkYvR2xYdEx2a0VlM2tXeWM1eXcrVHZiSjJLd1Ftd0dH?=
 =?utf-8?B?N2grLzArNDNCMGpLczNTRTRUMnZ2V2hMZTN4eGFneHZuaHNCSUxOc1BaZFBr?=
 =?utf-8?B?a2FHNEV6d1d3K3dkUVY4TGkzTURqV25HYk8yN1hhRWxrMXdKSHdwclRkTUZX?=
 =?utf-8?B?L2R4MDZna1NOODBEL2ZFWitsaVRUci9qeWxwcVpRdEJEaVFNQnBIU1ZFd0cr?=
 =?utf-8?B?WnBLc01WaWZDNTdnZ2JESTB6M3Y1VXRqQjRtYXAzbHhvc1BKRHJscStoZjZk?=
 =?utf-8?B?TlFsRG5tZjJ6R2xTZFdYUE1PN0hFb1lwVVRKQ2RYVXd6SUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmh2bHBTOHJjZC9PRVdHaVhyYTcyM1BaUWwwTFRzaktGREVES1k3ZHR6Ym9q?=
 =?utf-8?B?L2N4TGJtTXNTVUJnaFJpMHJMOXFhOXZqa3NPZkhoZzJzSmRKTkd5MmhudEVx?=
 =?utf-8?B?L09zblNCWTNweGRzb0F4QVVpcEY5N3pEa1NzVldkaXdUbGdlNThnNTNVZTNo?=
 =?utf-8?B?ZU1MZExSbjNKdUwyb2FhR01vd25BdEVYODFscXRpWlZtNzcwdk92anlqRXJN?=
 =?utf-8?B?RmR1Q21kZ3VKbGYyTFV3d292Z3JpSnFtM3hoeElMTFVPbUJuS2M3V1VtQlZH?=
 =?utf-8?B?WmYvc3FTMkNjNXJaZWxFZmg2bm1Ba0huNkFzcUFQQlB6cEZLTmNwZGQ3MmlN?=
 =?utf-8?B?TG13bjhIa0ZjRE1NWnB1SzVQa2hESnBKYU5sL1ZJVlIwYUkrejRpYm80eHk1?=
 =?utf-8?B?aWRtcm9DR3BYZDFJRTJJM0NvdTQzMlNsOEZzNThVQVpQMHhTWnREa3IySk4r?=
 =?utf-8?B?TVROR3N0bENpcXlNVHI4MDZrbzl1Ky9BMTZOc3dnRlFuNDBlWlJ2ek9tWFYx?=
 =?utf-8?B?L0VnS05TOExRUzhKclk0WDBLZTRJd2xoTjNnZW55c0JaeG4rWVNVdk1GQXN5?=
 =?utf-8?B?aDNxTHY5bkViV0I2UzlxQXh0aGpabVFUd0lWVmM4bnNmZGdMaDZVRTI2RnQ0?=
 =?utf-8?B?TGxlM1N6VmRiRWs4ZHBXS0g5VWJqTUM2d0txaUhhSHJvMXkzdEtTR0dGckp4?=
 =?utf-8?B?YSs3Z1l2NlU2M3Y4d0ZLOXE0ZDJHdDhMMyttUndJbG5yVXh1U1RZc0l3bjJm?=
 =?utf-8?B?Q09kSFc2czRySzgwYXlQaXVLR0s1MGFYQ3IxTmF2aXFwOUUrTjBqMWcwRFdh?=
 =?utf-8?B?MGdQRGZYd3JmRU5qTGc2U2FPbHRSQjB1Q1ZXbHAvc2VQYW52N1RoSnhKODhp?=
 =?utf-8?B?V21qS0dsdEdIcFpGRTUySnNFVndPZ1BBbkFVZ3dnWkNuWHRmcG55aGtPZnI1?=
 =?utf-8?B?VFp0QnJWYnBoSTNhVUtoR2N0Zi8xa0JWRFo3YjEwVWtWT2JSNHJsWHBVVTNO?=
 =?utf-8?B?ODVVVFpKSFZrcHFLZXJaWG1rZERZUnp1aVBVeUxydThqVThuWmJDTXJxVTZB?=
 =?utf-8?B?YmhLL1RPeUVKVmZoWXhqZ1hYVHUwcGJwNVBIbEZhWUdodVVSbWt3K0dsS1FJ?=
 =?utf-8?B?a0cvZWRZMmZUU0NZRXFBTDRQT1E4eHozbU5VK3NQdElmdkF3elZ1MnU4c3lv?=
 =?utf-8?B?cHJTZzhhOTA2WldJSzNkd0x0eHFlb2FiWENxOHdlRHRYNVhXRDE0Nm9ZVHRO?=
 =?utf-8?B?VWt2emhQYjFtYVUyQzJTU2lZK0NDeWNDR2p4M2ZxdGYxV2ZIUXMzcDhVT0FQ?=
 =?utf-8?B?WmNsTXRnZDEvNnByU1ZWWmwvSFNDZTBNSVRkVFB5c29RNTdFNHdldFowL21L?=
 =?utf-8?B?WUM1eXhVQVVjdmJCZ3NoTVlWOXFoU3hZaVNZcGc5N3FZbG5wVks2aVRwMnJq?=
 =?utf-8?B?cFJUUVlBbzVKRFNyZmtRd0FjVWRiNGJtY3JmWm5sdExoODRlM2tZSjlmLzFz?=
 =?utf-8?B?d3dvY2FVSnBSRVRoc0lWejhtNTBITFh4RXFyVXdxbnBrR0hoNjBWRm50Q3RI?=
 =?utf-8?B?QTNCWlBlR1VGd1Q4NXJNalpVVkxURHdQZmFkSFlVcFhuU0VzZDcxNS84YlZi?=
 =?utf-8?B?ajU2TzhvT2crQmdpQkJLNXUwb29Ec2h4WUNyU3JyRnl1azNVcW5KdXZFaU9U?=
 =?utf-8?B?STVwZ0RzUHhlamtpMmZ1aXYxckx5VnRHNFZPb3VLTDRZdHUvc2Y3eE9UajVP?=
 =?utf-8?B?UDFaM1h4ZmRRZEtSRjloc3hjcEtwS3hFaUpSV29PN2I1MEJRc2E0Skl4bWh6?=
 =?utf-8?B?dW1Cb1VRZEx4SlA4enUrQlFPdXpGOXdlZFo3RFdpOFZzeFk5WFBSZWZVNkdt?=
 =?utf-8?B?MkhKdVpvOEtEcjJPZ1QrMlIzMlVHWmwvakZ4UkdXUWpFQ05ndzJ0bmlGVXBk?=
 =?utf-8?B?VWhhT0Q5amdSc0VpN1JPM0xUOXUzWm5WMGZqbDNKTWVObXBFQ3ZwZks3a2JK?=
 =?utf-8?B?OVdJNjNnajRxUHY1UWJGVzZmeTlTQXloc1MzV3QwMUx5TWFSSXlkVzJ1QjlN?=
 =?utf-8?B?YUY2TnU2L2tZenVTL0xyeDd1UWc3U3Y5WUR6cnpNbnVVc0pPLzEyWWRtN2M2?=
 =?utf-8?Q?SfUcwJSD4F0iZxu+taMDqS1Jy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /ktZnv/rRDhWW6Sp3QTybkzeoHVDWZSaEBVlCPUbQ2xdNEkX81KjPclEGJ9U91XS/7AMz2IF4tPZK+wPuEVuygRXKxxYsMfZINbYa1K2/Jh/yFY5c70TR4shAoG0VJiUmS4FAaUtAqxiw+Kuf8zgM5zXvs0ZQ/3G28QgIRh0S5l1wb3xxMO1qv0nZpMxfjtI6ZOoZtxhOABE+gjF7CIMpjkwDIDOAO4McTlw8AdDK7XzBjVL5RRpYCKNfnfMY1fLW/jL6jdqPhYjlWzjWNYqdUFHSES/fuhyRY+YOtCIVfjlp8Mlv6v+minIilBBPYhQLajDDwh3kP4Qw6IZpa9VE+71+EnFyxeoRq/JHq5taBu5uNrhOpr3eWTrIl+81n770yTj21h1zqcOyJ80v/F8xNxKw0mznyfTDDSxmp9H55QVu92Zqmw4t9RdoQp7DQE9ioJRgzkyKJBjbOkT6jS9cVSurluiG0HgMxBGlbM7kDYYASRotf9fqX6uaEzXpTnzdlCjZ/DrznNvmbzzUU4jmkpIXLIrixwt+HPpHqdc7QnkIf6Lc13+pVZ2UnzGd2u8WAFRM0bqtmhddmYWoxL4MRZrI8NBB/wXp08tXbZWuXo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b00f110-f344-42dd-a08a-08dd86405cef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 10:35:15.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5VB5ig0/DY/CQaWAOmHTOYykMX6ivzcn0sZji4KdVwlfVmjcZkTMcnsY+frvjpeay1tB/jsX+Lk/7Js02FvNxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF1D715CB68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_04,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504280087
X-Proofpoint-ORIG-GUID: CWDB9D39utWLUv6GsL3c1hvz5glR4T07
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA4NyBTYWx0ZWRfXyUORs8N5r9kG zQmsCiYJnIOi4D0cr4IPRpOjdmCsUmfb8ErvNLdCw0vK5Tp+wBiVZU8ejFAISwyits6Vz0TbMYJ jl6Xh8/mNvXPDm8tZT4xRin6RsQnG+K9/+gcrcr6fmQyO76KQpd1WUCDxIyva4EztSTKv08bUQ/
 oO3oBXooeqqV7YHbSngL54ossJoRNEIHUG2DyE3d/wZQDhnOvez2WrdLW6CTb5vuJrzeAsQYtwd EZs1sFbFQRy+jQ6bSxOXovWsZhjpmvEUMx1lpfwYOl2tPW/a3tzFRhlxEvA36V0qoulfdiJwKyv nYz5iMiNWLEsOblmfj5SDIJNUxs4YOyjcU2BT9q+yX1zWelRl5w0SjFyPOVP/NHv8M75o44mD4a ylZramAR
X-Proofpoint-GUID: CWDB9D39utWLUv6GsL3c1hvz5glR4T07
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_033541_100704_273D3FA9 
X-CRM114-Status: GOOD (  15.50  )
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

On 26/04/2025 03:06, Caleb Sander Mateos wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Introduce dma_pool_create_node(), like dma_pool_create() but taking an
> additional NUMA node argument. Allocate struct dma_pool on the desired
> node, and store the node on dma_pool for allocating struct dma_page.
> Make dma_pool_create() an alias for dma_pool_create_node() with node set
> to NUMA_NO_NODE.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> Reviewed-by: Jens Axboe <axboe@kernel.dk>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

FWIW,

Reviewed-by: John Garry <john.g.garry@oracle.com>

But a comment below.


>   
>   static struct dma_page *pool_alloc_page(struct dma_pool *pool, gfp_t mem_flags)
>   {
>   	struct dma_page *page;
>   
> -	page = kmalloc(sizeof(*page), mem_flags);
> +	page = kmalloc_node(sizeof(*page), mem_flags, pool->node);
>   	if (!page)
>   		return NULL;

For pool->node != NUMA_NO_NODE, pool->node == numa_node_id(), right? I
mean, aren't we on a CPU in pool->node here? And then - by default - we 
try to allocate from the closest node to current CPU anyway (when not 
specified), I think - that seems to have changed, when checking the 
allocator code.

>   
>   	page->vaddr = dma_alloc_coherent(pool->dev, pool->allocation,
>   					 &page->dma, mem_flags);



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C545DC55182
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Aug 2026 08:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:From:References:To:Subject:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E20SVKb9e0Nnjj+zrdC4G0nMPREl/b+UdRflo75QhCQ=; b=LdIx9qCjM03we4WBse7Gh623VF
	/d9iO0lOuVGPBcWjvfd9U0yTdajUtjEZnW88tPLa/nswJJzobDQ1UyxjzViUDrk5QnlqR03YpRDIs
	M+7ZptbvkkCuhtn0AW+jaEY8SIBRnwHXug6/N8haMQ2ycMEQaKoTto8A3i1SosSkfGohN9nGKiQN1
	DWAvnVY5cD5EgDAGlxtyV3X+xQ3sxM0JIYFOqltkk0fr7D9wHBQXp+zWGUYfGFqPMNf5kkyIeQBAN
	h5BhKSIfEyStkyud0Dko4c7N05UbmbtZvnCwg7JXzESNjyPNjKYsiEYw7lsSlLU4s61gj9IInMfnn
	OYwqpprQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrWfG-00000003UZd-1Up3;
	Wed, 05 Aug 2026 08:07:50 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrWfC-00000003UYb-1wSo
	for linux-nvme@lists.infradead.org;
	Wed, 05 Aug 2026 08:07:49 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674M0eJk2081211;
	Wed, 5 Aug 2026 08:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=E20SVKb9e0Nnjj+zrdC4G0nMPREl/b+UdRflo75QhCQ=; b=
	F34csdJv7P6599YoH+Y49Br3yWsvHojTEY/3pUeVdRi3qVCzFug7EknOGaZbdbO6
	8/7ObrG/JgGJ7s9z3BavWwgPHCT9gbFQc8YR9ks1CnOxrt3NA5nj7BVbhQzhnq94
	qnytle0RdEVgk7ZJFBycMXSXwALhFeZprxtalLLigcdLM3tQ/YXGnnEossuksMi1
	8ThhbMSU5HTKqeVTwzUmy6MPPRduwmp/IGhozjKgok00vYsjxpBCsH8YbXluP6YP
	5maymF+FqXSt+Gh2tFV0qN6dQGbfw7rCRYX5oJjPT+H+yxG2995NL84Qf5QIXESm
	6xaqsYv3V17eMrLtmbNkMg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs7k3f6pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Aug 2026 08:07:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 675802tt039286;
	Wed, 5 Aug 2026 08:07:43 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78d29uq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 05 Aug 2026 08:07:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AVjeX2EIQlOA0/xr5XBLxn2PuE2hBleJYttppdYMVUA4YoS4bxsly1XwUfzZDpkNrj92cQ+7xvkAWchVCr3zzwtoqInVJ1AcUpA/CVKPgmez7vQLgC65qtrkRaEvizK78kvTiJoRMVBwcL6hmmi9M4IAUv3jrte38eQEqPmql+5jmINhvrQGiyWzq4VnwWw1MbwjaPTejhdUc/NQo4fydRbZlynRhGhBMbJ4m2COoW4hMONP9S3thSNyu997IqsMtwo7IK5rM2vhwaZZbqVga2A5dUuBm78gUY2lGTBRHRNvv0GAtzoOxNh6b28n+KB1LD5EU9TwCd1N0TAzSjsBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+QrEUg9bNgzez23+zq2UbthPMXSrEz6gdt07U2jnTs=;
 b=QfGU3eq0TerkCwFoDmrug9ugzMSvHZ+zuQMcoa9rm4noLXmugMpVXe6f82wygHcxYTa/kRzWlPDj5DTysWZw87n/OKKYMVwpxhHTKvOcXbzUfaUqrylIkNrcXC244vcWMpIY16F/BowcMNnfvrPlk/7o1fTmfeKPzPA6mJHGg9aE2CmbcXgilUnMhlWCB48QP+KAU+c7BhQs+k20L4bGjyhrj1w7MctHfqEZgjAVHADiej56rNqK3Z7ZJkJC3oqCwWV8m7WbkDBaVodKtjao3BHKebiPRvaRju9sDCxomx8RtLCgBHybBkqGRuhRCl7RTVPoOzwqUoMxW12S8Dktwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+QrEUg9bNgzez23+zq2UbthPMXSrEz6gdt07U2jnTs=;
 b=bd4RRu5Sl3d/mDZofGtinhOZtpvr5lBhX71ryB0zPft1U5HPOfvHukP92H4TwLvxaB0NdO3wLXw7o494GzexWxQqHHfAcfgcn4K5qtv+bJAMJdczfuqHCqlPWTvyWLQmiZXA6ywB/AWBoqFwVnjeiu2LDw7XCkZ1oB8f9f+gPP4=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 08:07:39 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0270.016; Wed, 5 Aug 2026
 08:07:39 +0000
Message-ID: <a7b2a986-9769-4751-994e-eb3d80694b7b@oracle.com>
Date: Wed, 5 Aug 2026 09:07:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] nvme/068: check module reference count with
 patience
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-nvme@lists.infradead.org
References: <20260805051353.2037772-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260805051353.2037772-1-shinichiro.kawasaki@wdc.com>
X-ClientProxiedBy: LO4P265CA0134.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::6) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|MW6PR10MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 032b9ffa-d2f5-43dc-7fda-08def2c89dd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|56012099006|4133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: O4II9vVatUA5J3LglBL12E/orDshHdP3s1UowTYySJPW9wkdhrS9EbZZ2b/grwCvgMMEI5UpiUYATe93Cjb86CMup0IgNyCCOciARUlaDGmv7tqCd/qag10IMmziIiuvjVmTr4vH9vto/JwEpI6BJT7fwHGGaOfiT+hIMK9ncO2FyHdTfQVYWJJ0epzPx9MmlXHJTrDGpLJ1ubOjar0vw6b5LMb9TzCtxIJsyd0wZbQhipFcAXEo3rHqhetQGLOZcYGJaM9sczhYjWA4tva90izGhrp3C1EBZbnsCDDK8zuoCOcn5oEeX4Fbl9yAFjhW8BVU+ee2eR7ib0T+UVm2sVYQgERBVXvYBxsfCJE4OEYay8CrLv/PWtWy3BX1KrTLeBH0ynEoF5OvZsdTwaguquQtMjUhqvA+XF+2kxj1kWoT4ygevSczBj1JS92RbmYXAbc2kYpgiwv7a+Amb72saYYYnlYTJmsKJ7s3HFib7E9uE2b6NStoknXlF/V3C1iBi4YYZ2MkE0m4x1VJu8B71YEzefTrK9mXJB4xpvv/yK9WUzBGBJMwbkbOQyn4EwswIFKY0stuqJVhl39gyDVR9gnMqe3IPOoothIlmpg2gBoH1SC58VTjgsrLU7O/ugTTzZUT7pswBykq9/owrAPhwO/d/IGmSrNMhSYjk8ablv0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(4133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0hsYVNvWUV6eUpKNWJ2OEprc1dXV3NjNXJhUnNZdUhOWTRMdTV0akt1T3VT?=
 =?utf-8?B?b2M5dkJ1TlJhMHFuc3FEMG84RFVCTWZYNTh2Kys5b29CT05qOGI4SVU1Mmd3?=
 =?utf-8?B?ZUxZNy9lWUVqRjFvdHc3ZlhlTDNnYzJwdzJSM0RSWTliK3FUU2JqQ2g4VjJD?=
 =?utf-8?B?WlhYeFRhKzFrNmtwZzBMTFR0bnJYdHpnNzcraDVCTTFtZ0V1TFM3WDdTL1Y4?=
 =?utf-8?B?TTFpbkpMd0wvS2o3OXpVMTJvSURVdGhjbUJOaU5tY0xoc1l2L3NBcWlua1lh?=
 =?utf-8?B?WnNGR1FEaytQd1J2SytrWUlkaXYzNXJjazZSWW9kdndmblZxOERaQ2JXUGs2?=
 =?utf-8?B?dzR6NHp4VzJEVHBkcG55UlcrbkF2ZHRqVW9aNG80cnRMVnRKYUhPU2dWdHFG?=
 =?utf-8?B?Y2M0a0YzSUMyZGUxd3dNczNpU0k2TlA4b3VDVkxJYkZkcEZKd2hOZ1lUbzdM?=
 =?utf-8?B?ZUVnRjNZaHcvT0EvdTN3c0tLNXM4NVZZTENucDA0OUE0UG5YKzdoaE1adDFk?=
 =?utf-8?B?enVjbE9waVh6Q0FvVW5Pd0lhd2tNSXVDeGVDMHZCU2w1eUpFUTltR1lkV1F2?=
 =?utf-8?B?RU9nZWdPN3J5dU53MnBPaXFkZ1JKaDJ0eUNuRXBma2JCSG5mNVBWK1ZGVzdE?=
 =?utf-8?B?Q0Q1VjFrVFhWWFdWRVpJeDRqb3Y5ZTRDZGpVWjNCVXNYZ3NSUHpzd0N4N1BX?=
 =?utf-8?B?aGdHMjVYWEp4QjFhdXhHaUdmNzR6b05JSnBpWXRrN2xqdnN6S05xaGU0SjRD?=
 =?utf-8?B?VlpSS3Bybmp1ZmszbEpNNWs2ZnlSVHljV2tNVTFZbG9DbVFaNnhYRnB3UnZF?=
 =?utf-8?B?YXhHZ2RBeFpmeEpVdWlIZEtkWEp4cHl1NmMwTTJxeFRGVkk1RUZlZWdXUmZO?=
 =?utf-8?B?UlBrbmRqZjhvekhIQW9SbGN2dnNHRHNBaW5ldHNGWWVRV2J0K3V5VDBpWTZ1?=
 =?utf-8?B?eVFCelV2TDNEdFVMWUpVelVCWnZhYzVyeGdsYTVpZy9KUHNsbFkyRW91aDh4?=
 =?utf-8?B?K2hrNllnVHFPWDNRV0R0T3NUTGEzMWg4NTVlNmFzZEhXaHhnSlhDN2dpVkVL?=
 =?utf-8?B?S2JPQlJYc3hmQnlyVEVKWThCeVcrZG9KdGFRMWY5SnFEMkxtYlBCazlMLzlU?=
 =?utf-8?B?UDlFT2plS2VCSXJBQVdmSmJqd2Zmak10eW92V0J5OUMyblp6Snp1djZPSkZY?=
 =?utf-8?B?d21hTmhSMjBhdkI2RTJmZk4xOFZIdW9OVlhxSkF5MXB6TXk3cGdIOWNMR3RW?=
 =?utf-8?B?UGRiTDhZMVpFcXFjbU1OQStyRk5vSHNiWS94Nk9uQS9xYU8zYjh5QmFCdm81?=
 =?utf-8?B?NG9LUTNKYXVGajFhekdJWTNZY3RmUi9OVGdkOUVoNkVtT3dnaU5HOHpsVjZL?=
 =?utf-8?B?TkxZZEhYTnRhc0NycUVjN1hNdUtWUVVycE5JVkZ6K29PQm8wTmU4K3RDc0VP?=
 =?utf-8?B?cGNpOHc5ZDdxUjFtUXhyK2Y2eGl1aDYrY3hSUXZJSGtnbzY3WnFLcTBKYU1P?=
 =?utf-8?B?aXBHNlkvN0pFY0FmZCtvTDRHRWNUcjJhdWMyYjVsUGk1ejZTaDdPUjdtK3VV?=
 =?utf-8?B?UzJLWWhUMVBINllHbnlJZ0pLZHFIVmMvbUN4VlJ4T0pjaTNwd3JBWklQRlJR?=
 =?utf-8?B?Z2EyS0p3ZmEvMkpXRjNOQVo1OFpKUmxwdGpkOXdQT2ttSzl6UGN0dnpjaWw5?=
 =?utf-8?B?OTYvTkIycHFZSFpLUDJhM2pOOUR6MHhoZnRhNTJRZ203ZVllQnNyb0xtS1Zk?=
 =?utf-8?B?MFcwQldja3ZwMHZKZWdMVGlPRVFnTWVVeVpQN0RhNkxOT2crd0JzMXI2VWNM?=
 =?utf-8?B?eEdINVRMa2ZuUXA3YmFoY3BIbXhhc2ZUOHY5NVFrUE8vVkU0VERtNFNTUkVU?=
 =?utf-8?B?akhtSDNneE4rWmxZKy9kKzFYUTJtZnNiK2xBdGV1SHBhYkVOZCtjTm1rYVlY?=
 =?utf-8?B?ZDZRWTMwM0lkMG1MU3NhRDZOeTNkZ2NGM2VNWW1lSVp6b3ZZTWxDSGM0c0xW?=
 =?utf-8?B?T05BbkM4TkFtci93d1dUUU5HdFRrL2JJdmRHbDNuazdJTDBMMFNpV3k4VFJ5?=
 =?utf-8?B?d00xMlVzR000b3JpS2N4OEhWWlpIU2pSV3k0L1I3YkcxTnlQQUNFVnR3RzZF?=
 =?utf-8?B?N210TFQrd0dMTW5uWDNIajBQWDFVRFdpaWNtMVljMHlsUzRhNmRFbHUyZW9O?=
 =?utf-8?B?V2hDeVdHaTMyTDRMSmFDZHFUci9yQ092UG4zdmY2OGRQd05CaU1EaXBvcHVv?=
 =?utf-8?B?RDdjWHk0L2JmRnRMdEllNk9XNUxEclEzUmw5WGk0bGFJLzZ5M09iTFY1SFhq?=
 =?utf-8?B?UG1rdkJSaU4zQVpSNWVpV1kxbURlVHV2RTdTZTNkdlgvRlRrdlkwdz09?=
X-Exchange-RoutingPolicyChecked: WNk/fx6C+ge9PgPN8mTvDmSsJ8EqUly0ksvBcy8Osx2VBpxJ1udjFg2ooYp+UzSRgbdb+33oddfSHjb0OqD7gQMMKToLGmEKSA43dyek7sDX14eMw1eSX59XHnPQ7Jq7+pQVR/umNqRl7PdAKM+3JumrDQB4hoBL+9VIwY9bLhyrU/vvAGkc29K/2qCoaiNIxm+y9f43EWmSTqIDyTeQlKN3HsdsfjiZN45kqfGwWUR85Jnuhu0EOcsED8DUZh9wF3zm6JHOWx6uZqwqqvRt5GSlPwpk9H+QKm4xiH+JRDA9ZJbg1P6VpqrQaHlxyrwdskHMvO1UgkEb+DK790yHhA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FeMEmGuT8SmAHcH6cecYTu18Ui9En77PcJctH3bRK5zb6jnyR0XtbLRhbWh8mf1mhCoOAotU75Olb1JMRHPJXZ/hBq+vsYrDFc4N5WxQC0o4pSmAzmY4i4mrJC9+pcTiJerC5LJ5+IVRsgdGvoGM/iG5+J6DnSWQ5BdglsEbJIoNCHmPcckzdWklwnEXoixfzLNINlAyaievRSLekCG3xgHuOTVpOtSYFMeFcmjxfZklyMOB+LywkZyzG0oRzl1pMjjk9bhrek10qDCHgtt0xIsPVTOnNhxLQMebMzHQx+8f5/sfovPsg72yEOlTNpLN5YL35FtKGYD/l/OWlttVU0kDDjCTl+5WfY9dCtzcJsQPcclmfPcApbg4d7hEZ+EkP966eTCzi82I1D+7+1SAWDifbcM/RZE1QoilbL6iDmvYp2Ys3L292kEL2lFZRlWuMNsrKBR0BMwAR34peaCAIocIF5T6kYfbWJYPJN8mVVF4HbSnsk636h6bmz/64/r3446I2Jg12HmmOR6a82LEfcFYK8lJwD9OAu0k9lpNM505qrShkgqrRz9MmnEQMejQxewC+nRbZ+YY8YOusSnt1P1iAJoAc6pdVFSTPADHuW4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 032b9ffa-d2f5-43dc-7fda-08def2c89dd7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 08:07:39.3840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFvaWRgFQaD/Wp1kkjZ7LgnN2auXRoHwUBF6F7zgDoYsi9QVITW8Z51m7s/IiiM/0gSHhKWnjtZmJc0KyAiMNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7639
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608050062
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: hPFY-i7MsKU3iQHSlnjS-PQ443HHACZe
X-Proofpoint-ORIG-GUID: hPFY-i7MsKU3iQHSlnjS-PQ443HHACZe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA2MiBTYWx0ZWRfX8iUh7wnl2UV/
 bad0GyXvQ/rBuz1OmnDtItmInTejLFaVIKVuBd43xKz/uUT5DFfGDehjEQR4RQZ9T0Ah9jXloyk
 OJsKeqerfCv2PQIi2BtC4ejFcRX7dsPuDtIZqvckU9P9+Skq1/ob
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA2MiBTYWx0ZWRfX/ZXmjFCJj2+f
 a6Gt03e0UR4lo9YOPkfDRIcBpLGTCcg0jO3bw0QmCwazSjUA7GiJ28y9uyS3VZFpEvXD+lnEV/o
 ez+0XcFh+rjuIgmCb99lvcGNFwzfq46m+YhPtwsiX1IMYiI736gHbXkf1+b0WgZUqSuQuExqLnV
 zQF9YCfZX/yrnf9/qbKf81Sq/hvJhZyxQlCD7nziyqFoaT+2V6frbVrVXMRlRX0gYvfYQkvWNzc
 3xeHQubx6vu9AwO/luo9drWiawwvOdh4gZZENb6JH9d8PVsxwOMeKcGk4KVvgOeRajQ1owcEpUm
 AKcf2btW/AsZaq2KJiby3bg6j3x6PV4jFrzpcc8iNSwvQIR27qVy1vZzSFaiutJ3S54m6tKe2Of
 T81sl/Ux3RDA/NIsdcexf5hLgk3uHbbhBjqRF451sz7L3j+t0207ka262lFbr3IPpKNTsYIHDlE
 u0AbcX+4aueTywx3QqQ==
X-Authority-Analysis: v=2.4 cv=Iqcutr/g c=1 sm=1 tr=0 ts=6a72ef50 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=o5oIOnhZENCTenyL_yNV:22 a=RpNjiQI2AAAA:8
 a=JF9118EUAAAA:8 a=fixeXQh0kQ4YcDJKwVcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=WmVTiCyuxqgg3mnwYu6p:22 a=xVlTc564ipvMDusKsbsT:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_010747_082964_630B9281 
X-CRM114-Status: GOOD (  27.00  )
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

On 05/08/2026 06:13, Shin'ichiro Kawasaki wrote:
> The test case nvme/068 fails depending on the system it runs on with the =
failure
> message below: nvme/068 (tr=3Drdma) (NVMe multipath delayed removal test)=
 [failed]
> runtime ..=E2=80=8A. 11.=E2=80=8A357s --- tests/nvme/068.=E2=80=8Aout 202=
6-08-03 17:=E2=80=8A24:=E2=80=8A32.=E2=80=8A394566266 +0000
>=20
>=20
> The test case nvme/068 fails depending on the system it runs on with
> the failure message below:
>=20
>      nvme/068 (tr=3Drdma) (NVMe multipath delayed removal test)     [fail=
ed]
>          runtime    ...  11.357s
>          --- tests/nvme/068.out    2026-08-03 17:24:32.394566266 +0000
>          +++ /home/runner/blktests/results/nodev_tr_rdma/nvme/068.out.bad=
  2026-08-03 18:15:17.461243816 +0000
>          @@ -1,3 +1,4 @@
>           Running nvme/068
>           pwrite: Input/output error
>          +module refcount not as original
>           Test complete
>=20
> The test case checks the reference count of the nvme_core module. If the
> count is not the expected value, it fails with the error message.
> However, when the test system is slow, it takes some time until the
> reference count gets updated. When the check is too early, the count
> mismatch happens. To avoid the unexpected failure, repeat the reference
> count check.
>=20
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> I ran the test case nvme/068 with the patch using the kernel that does
> not include the commit below:
>=20
>     3f150f0f010f ("nvme-multipath: put module reference when delayed remo=
val work is canceled")
>=20
> And I observed the test case failed. When the kernel includes the commit,
> the test case passes. This indicates the patch does not break the
> reference count sanity check capability of the test case.
>=20
>    tests/nvme/068 | 16 ++++++++++++++--
>    1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/nvme/068 b/tests/nvme/068
> index 4aee95b..7e39e17 100755
> --- a/tests/nvme/068
> +++ b/tests/nvme/068
> @@ -27,6 +27,19 @@ _delayed_nvme_reconnect_ctrl() {
>    	_nvme_connect_subsys
>    }
>   =20
> +_check_nvme_core_ref_count() {
> +	local refcnt i
> +
> +	for ((i =3D 0; i < 10; i++)); do
> +		refcnt=3D$(_module_use_count nvme_core)
> +		if [ "$refcnt" !=3D "" ] && [ "$refcnt" -eq "$refcnt_orig" ]; then

As I remember, $refcnt =3D=3D "" happens when the driver is built-in. So=20
should we just always return 0 immediately when we find this?

> +			return

return 0?

> +		fi
> +		sleep 1
> +	done
> +	return 1
> +}
> +
>    test() {
>    	echo "Running ${TEST_NAME}"
>   =20
> @@ -98,8 +111,7 @@ test() {
>    	if ! _nvmf_wait_for_state "${def_subsysnqn}" "live" ; then
>    		echo "subsystem did not return"
>    	fi
> -	refcnt=3D$(_module_use_count nvme_core)
> -	if [ "$refcnt" !=3D "" ] && [ "$refcnt" -ne "$refcnt_orig" ]; then
> +	if ! _check_nvme_core_ref_count; then
>    		echo "module refcount not as original"
>    	fi
>   =20
> --=20
> 2.54.0
>=20



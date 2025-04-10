Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EA2C369AA
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=25ywQATzd+msBy/64v04vUaeBKGgEQg+iTjVFbPgKKo=; b=x1O4FhJea54VmEyrdtEJ1NC2HR
	aF87gmlir241OjO3qePSDi8wwR/iZA0urkyY/QVkzkr0wWQ74E9x5QGzAorSCjAvs10Fimcmu8l1O
	gnoJT5CiTctU/9T6WjKt/vmqd0wAxbN+zjpNKjsApVBgE9ZMER3mkCdST0BrqARlrRXG+/TIIT2S2
	F31wkHcSgqcMJwRIib0ky5nQ2pxzcPrIsNiahGZzC+dFdqbaB50Evm3XNRSsHBwdxhj4qReWizH1c
	0qlNT6hdNRMu6DZy7RTSarMybfFohLHr4EsipXEY9yzAE3DMfD/CycM7NDAvpLUtYtaopuQ4M7wjz
	Pl+IjHAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2ptJ-0000000ABtN-2iAz;
	Thu, 10 Apr 2025 11:16:17 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2nv8-00000009t3J-0ZO7;
	Thu, 10 Apr 2025 09:10:03 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A81vZd018658;
	Thu, 10 Apr 2025 09:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=25ywQATzd+msBy/64v04vUaeBKGgEQg+iTjVFbPgKKo=; b=
	f7ieotoodQmwnYsDvoki1bioIwe2EuMiI8pFwb/9qhDTrJyNfug4JORkRRNWn68m
	Eu0d4BhNVG21ZjXrTNw6fVV1jL4XFLSSWTgNebyk0l5IEOamSCPDF4o5nXsHJy3r
	4JBbmS0kmR4kw5IzE7aAJ9RKTOp3I/ZLi51rNDjDIgQFv4IvgpHF5Sh3dW36f9Ts
	NzsKGJlhkBX112p+lB6irjIrWISZcgGnenV3NGC+X10CZOlDRzwBBrwZabP6qbs1
	ZxyiqL9EAjHDFXxa8k2mNizRihwlx2geq2+SvKgdW9wa7dFHR9i45FGYsTml9Bpw
	TJ28YAfcI8UoXWsACktnOQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xa49g4ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 09:10:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53A7PRaV022270;
	Thu, 10 Apr 2025 09:09:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttycq8ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 09:09:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sx/zBW56X1bngf+0uBn1jDMsEzNMoYq4kbwImkhS+FMAdSzoDkSw9apTA/19XeZeMep5yprb3WVzpzMVCZ3cvzHTYLpujeNI9tCugyPOTCrER8IHiN/xNC8AXCAzr0zkeynZ4NIfPveDLQl7r3uXsOsOva/C31gcTNQbaW2ir99P7tWmdHIho3Ip2knayzEbYpMPWoCTn8K/A17ou6wJu+/k0o6TM9eXuOMEmOUQGwiYMhFNc6igYjzGtBePe0ZnTR53UHUwQgRKIPVYQMxWg6sHvjANLqfOErb3DSPnB8cBRufquFLSeqIiFLJEzFODQQOGTM1JjcxRwaNyctNfpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25ywQATzd+msBy/64v04vUaeBKGgEQg+iTjVFbPgKKo=;
 b=AQ4bv14nNPRmALOKBkXkT0Nfa0Usg1pwKx9HYZ/QFqmo9wVK/3KPCkkhTiQ5tU1C3IkVPNDC/tsQKBspYlm7SGsIvXet2yOYqw+leK8YZvkZlZmuA+yKECyG0S+duDeUGr1BIkQnoz6pYl6eHgrL1RXUTOEQocuiGN6cyy8pwQ7k2ahMDwDpTI9PQ3/Neo3pqPaxo6GBmzaxHvzyQBaCIAMBgMQaE6ej8X1AANsZJ84Z6Bo1elpHCuCHZwZj4RN2Z0/ZScSSKrMRRLWmJPr9oyKRkw3IUtJu1Hfm8qm6NqSdQa+BivkCwfGEYY2GAsMr8c0LJltddC2bACvt4vkbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25ywQATzd+msBy/64v04vUaeBKGgEQg+iTjVFbPgKKo=;
 b=WB0/71LLQgwUnquqyHIHLXWnRUTHZQO86ccMltHAH1FCD/L68zbDHVgNhtlcM6VIP8OFs3lDVAObrBrnq1YrE2m/0/fgoTP1OkPEpW1/YN4gumSeV6mwcY1KaV0IS7B+1TWE1YAa9anS5CIciZkgHViJ8a4xH8rQ09U6muM28+8=
Received: from DM6SPR01MB0118.namprd10.prod.outlook.com (2603:10b6:5:295::18)
 by SA1PR10MB7697.namprd10.prod.outlook.com (2603:10b6:806:38f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 09:09:57 +0000
Received: from DM6SPR01MB0118.namprd10.prod.outlook.com
 ([fe80::c04c:7e64:6721:98a2]) by DM6SPR01MB0118.namprd10.prod.outlook.com
 ([fe80::c04c:7e64:6721:98a2%4]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 09:09:57 +0000
Message-ID: <34d750b4-88b0-4e4d-8545-3550175529aa@oracle.com>
Date: Thu, 10 Apr 2025 10:09:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Issue with AWUPF when using multiple controllers in a subsystem
To: Christoph Hellwig <hch@infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <4a2e4561-9311-40c9-aa65-87e7a2e5b041@oracle.com>
 <90792c66-d0ca-401d-b171-57faea2c2cab@nvidia.com>
 <Z_Y3V6i7dG5Hr635@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z_Y3V6i7dG5Hr635@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::11) To DM6SPR01MB0118.namprd10.prod.outlook.com
 (2603:10b6:5:295::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6SPR01MB0118:EE_|SA1PR10MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 209e9ab9-2373-474e-4c9c-08dd780f76c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dGF2d3h1Yzg4MUZ3RGhCMVRsSnBodHczR3g4ZnpnOWFEa0dDeEszOWhEck96?=
 =?utf-8?B?SnVXbEhielZxY3g0MmFySTZlR2FRSENoMXErM290RS9ZMDkzckh3OEdnZitU?=
 =?utf-8?B?MUhUTk5vQUhQanZJYWx6WWJIa21Ha0JyVnhKWUNaK1JpTzF2OTVZcm45cGdC?=
 =?utf-8?B?MUZVRmFuSXJaTXYwcHVtZGFVTzhyL29sdXYyTEdrNGgxZ3RFYUlmWFUvRFIw?=
 =?utf-8?B?ZlNBcGVxc0tjTHltdEQzaWRiOGI0MVIyMzRNV3I5N2dJbUFYdjh4RDhvSU9o?=
 =?utf-8?B?ejBtNTFRR0IyQTF0VlY2aEZqcndLRFB0dHBWcVBWKzE4WGFzcHc5SmRTNEp2?=
 =?utf-8?B?NWtPUUNoNFBXeDh3YnY2b0Y1TjFkZHVqdlhRYlRkczQ0TnBieTZtbzZTTHhN?=
 =?utf-8?B?OXR2VGxOSXdnL2JxdC93ZVpxaU5pWEszRjNtMVFmRHZ2SGg0Y1A4c3g5bDNa?=
 =?utf-8?B?NEF1Qm44Y1JwWlJ6emFoK2NqZ3EzOXhKTlhmdWlMUGNMdXlvWFB4UEZheUdC?=
 =?utf-8?B?RXdPVXg0clZXVjNnWkVKMDVUbHNLeThweWJhUDR3Z0Fna014cGtWakhyUlRC?=
 =?utf-8?B?M1NLRDl2MStEdEFoNDNtdjZZeERrR3hJSnJ6ZlZ1NExsWjJ0ZVB5c1ZPdjQx?=
 =?utf-8?B?VlN1UWNESDBkVGwyRVY4aDJnNy9qWEdFcll1ZXRhVVpuZ0FodWFTQVJJSjBy?=
 =?utf-8?B?NXFBcjVseVVDWkk4aTBEYThzNThkT21EV1hJcHRPcERweVRWK1lOSXE3MEVR?=
 =?utf-8?B?RDhBRThhR1RrMytBZzBZRTVnZnZ1TmQ4UVNVSklXRmphdllMK3R4Q1c5eTBW?=
 =?utf-8?B?OEFDWE9sZTdGS3AyZEZienBrRElQR1AydWl2My93RVBzY0RzZUgvMjYzQWhw?=
 =?utf-8?B?S2VuN0lwZlNHNk9yaFhYZ2oyWmdHaW1xSE5uSXoxY1NrWS82SVlHeTVIU2tU?=
 =?utf-8?B?R09SRkxLcXhoREU5YmZUWUlSZWpmdDNXb29qNEJpaVRKZCtmMDl5TlJsMjQ5?=
 =?utf-8?B?S3BReW5wUW5nUEhaZmQ4Ny94MGdvMi9XOXZ1aUpBVWk4Y1FaRFRaYzA1RVdG?=
 =?utf-8?B?UE1IV2xJQ09pbERjZHdyVVNEbjlYRkVmZ0l2aHZsRDBlSmRUOE44WGxTeEw2?=
 =?utf-8?B?czZqMytQSEdZWUFaV0dULzdXUjlyU0pnWk5BRW02OXYxM2V3bXU0ODZLc0Rv?=
 =?utf-8?B?L2xiUHhOL1B2cCtlM0pSWVJtNzl4TDNaSkVUWkZKanR4cFpCWXlZS3h1MDJE?=
 =?utf-8?B?b2tFRzRaV01SYzJuVDhRRWxZbVlCalJEekVmWjRyOTgrSEVvakZHZVl4UUdS?=
 =?utf-8?B?UEtJa1oxeWVTYml1K2NveFlDeGsxKzhmMjBCdm5Sc1QrdVlZalEzWXozaEJs?=
 =?utf-8?B?ZGlZVDFTa0hnYUFBVVpXcmgyMXpWajE1cndVdWJWODBLRVBjeXFUcFRKcTJz?=
 =?utf-8?B?dmFFZ09ZUXNWRDc5eHZEZkpZVURPQitkNVI2cXdSUlBoa2pxcmt1TEppZ2lx?=
 =?utf-8?B?OFV3QytZNzJXYW1pU3JEbEZjOUVnRTlwZDdoeVdpSFVPU1ZKNno1SUt1eTVi?=
 =?utf-8?B?aWo5czl1SGRJU2loeGpkSFhjd0FrTnlMQXhwd3ArN004TTI4SFJ3Ky8wLzBE?=
 =?utf-8?B?SzNQUEg0YVVyeFoyVjg3WTY1a09nSGNoVWZ2U3pCNTZKRWx0TXJlaU1GMnVZ?=
 =?utf-8?B?eUdMZm1rVjNDZkNlWmNpa0FlU1B0ZWdFa2IyaGFMM0Nham1LYUlUczdCQXQv?=
 =?utf-8?B?VjJUVm9QazkrMjhHSHV1MXdPN2FYcXhkelpSUUhML2gxM1BqUGF2VkorQmVo?=
 =?utf-8?B?eHBDNUhZaTlvbHd1aG03dnloRmlZLzJzZlJ4cExzSmZrQktPUWkrOG5sazhh?=
 =?utf-8?Q?mimBgnbT4wyke?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6SPR01MB0118.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVl3ZjFkcitOUU1DcEd5WFBMbFBXL1A2blF6VDRtSXdvT3Fta3hpQmlYRDNW?=
 =?utf-8?B?TUY4M1FtZzBLK3dGSHpobTJBSm9TbWp0eEgwcGFKU09WU0RzRnI5NTJyY0Rp?=
 =?utf-8?B?N0JUYk11K29uK3RZV2NLZUlKRHlISGY0ZkdVUlUzenVtMmJ5OHFESUJMTGxu?=
 =?utf-8?B?VkF2ZXJNcndKbWZEUnRMcDdQalhYcDNrME9GMm1sOExLS010aHRTYlk1NW12?=
 =?utf-8?B?c29oK21WTUVnbTVoZVdEM2ZzNHlsYTNCMU5kck9uOGMvc1M1Y2ZLOU1pU1Zu?=
 =?utf-8?B?djhmenNmMHgxcGtNNXRWNUhjQWZWbmpQbW1uc1V6cURHbENCUTluWkVkVGhX?=
 =?utf-8?B?WFNPR2FKeHZkL0JRNTJSTDI5TVVIT3YxN3VLZS8rRmxSU1MrZkp5a0NyK3d5?=
 =?utf-8?B?cmw4RTZRYjNORURVbHpaUTdBaTFVaFV0YVY1WkJneHFMRjdWdm5WelVJemtq?=
 =?utf-8?B?a2lIREdqcmJWZzVMUmttRWtCQXc4MnZrclRZYi9zZDN0K1NVbEQ0S2IveVp5?=
 =?utf-8?B?NVlhOExjNkxhbXh5VVVIZnV4TThnZTVqenluVjlicVA4Mzc4OWtzRCtNNlRX?=
 =?utf-8?B?MUJsUzZlTEF5eFBGRFBQekFrRTN4eXRZemFPd3Y0cXlwNU5pRDJwQ3VhRG1V?=
 =?utf-8?B?eUF2MzNadGM3QW8xWmlQaDJPU21tYkV2R2lYRUllRHJ3MGYvallVWkdFWjZK?=
 =?utf-8?B?VHFNN1lNc3g3WUtWRUVJK0xTUi9jd2NrdklMUHpXaDRCZW01R2MvR3RzZFV5?=
 =?utf-8?B?RnlkQTJsUlFPQnpjOEIvM2NGTUU4amt1N0lXaVZBLzdiSGhTZGl4OTZDSjhU?=
 =?utf-8?B?QmVTS1JvNTkyc2pvR3lSS1hGRTFoSmlFZ0tPTmYwUkVWNzdDeVpiaGdsNUFv?=
 =?utf-8?B?b1ZvT3ZxaGdzYWdRRGRyM0xNb1I2c1pNcElxK1hnY3M4OEgwOVd5QjZGYUJo?=
 =?utf-8?B?eXdtMWI3Wk1OVnl4d1V0eERYUFlKZmlQdjZwaThhVCtUbTNWQzNhS0wrNWt4?=
 =?utf-8?B?WFFQSE1hKzZLUmJURUh5RHVRVE1LRnR3UEN6akZJcG1MQ0swQUUydmFYdWhX?=
 =?utf-8?B?NHd1WUxTRlZFY2NGSEtielhZajFnc3ZacDJvT0lYSnJ3NWlqWDFnQ0hDZWlN?=
 =?utf-8?B?bUVrL0tkcDdsYmgvNlF6UENrb1BIZSt4Mmw0aE5OY2lOaE5sMXZyL1BsN1FJ?=
 =?utf-8?B?eHBEOE40OWwzNzhwb3VNZ2N2ckxwT0lNR2JGWEFURWthN3VocEszMEtpT3Ny?=
 =?utf-8?B?TFZ1MURLTzh2dFMyVklpcDl0MWhkNlV6Y0dYRVJnSHVQR1JBaHVNTXk4Y2NS?=
 =?utf-8?B?K1lYam5MQks2cjZsdWlERmVGNmRraCtwemRJK2VPMEdRclc5MGxqMGxES1gv?=
 =?utf-8?B?dExycXZ6c1RPR2piaGwvRHFQVFF5WGVWcjBmRWFnOC84R2RQUXprQ3J1REtS?=
 =?utf-8?B?NzhiMnFMRmRFQy93UzZDWlEzNG9RQ2ZwUGVPUGhmak5Za1hMSzlWeFhDdlAy?=
 =?utf-8?B?SWJ0aU9vWlkrMGlyY2VlblkvSjRtdEErTUQybUkxK0o3aHJ4aFRtN0s0aWhG?=
 =?utf-8?B?L2NxUFRNWTVTQXgxMzhlVUFtVTREOVJVOVBYV0JuRFFkbUg5UHNBUS9mWFdl?=
 =?utf-8?B?cjNEUk9VOXp3c3BpQ3hnMjlST2QvYlJ4dlQreEpqMHRkakM4Ymk1cXdqUVUw?=
 =?utf-8?B?ZVRReTY4Vkg1OC9zSXlSL0xSb0YvTzNvYXhFOWh6YkFFQW4rMXRQdWp3Y1JK?=
 =?utf-8?B?aHZRd3daQkw4VkhrWmh4cUFRNW9rcFE2SG43YWFZZXFFeGZIditpRmR2S3U1?=
 =?utf-8?B?cVgvWFNxOFlKVUZhMTE5cHlkelppaXl3WHJVUWE2VG1wVUV5My9UTXZzdVhI?=
 =?utf-8?B?UVJvb2xTNTRwQnV0aktOS2hvN1M0V3JnU0x3WFRVSG44bE1sbzhwQnNnU0JH?=
 =?utf-8?B?SzlNaGJhYU5SY1ZaRkRCVlpaUnRmdDhETU5xallwUDA2aS8rTW5IOEJ4Ukpz?=
 =?utf-8?B?Y1ZjR3dIYjBNbEp0OGdKclptRm9kUXF2dmhvMFV2Nlg5a05GeVAwZCtSYUVW?=
 =?utf-8?B?dWxWWUNHdkg3Ym9GWTUzVjNNcnZTbjRtRTZvV1hOS3NnakpVN3lWME1WQitp?=
 =?utf-8?B?OExONEZIVExPY2U1TXQyTmdoTFRQb3J5Wk4ydUxUOTNYbjhqLzZ5TW1KdGZn?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AGGjlQxUhHNDOM0BMxI+Um8PWRmDtkXovLHHhljiLtrJriwjeW7n2EUjdMuQZa2T+u3+I7FbAmVWide+ihbLV46ub5sz+FN+XAPxiaUx55/8hAgemFAf9WdzbbbwgzJnw6wLmF65YlDiurv33At7iZF0Vd8G1bRx1qXj1WOJF6/gvWw8hqapVlnRI7UvIfgbjB40HJdEVSxQwIk/d+uRXABJHxnX5gCqu9eIJsZEp4wYIGje8TfvGjtA8KVrp3vOgaZQ4sDrY/QyozaLQv5oR3+5fH7hpexfBegMTHTlmsdQfUtwa/Ww+6u6m4jd6b385IYw23purhDkdjOAhcCccdoYJw0/HuXzpQjRWpK0aN+sG6V+Gz32VJFdQAAjffjkUqjjwFfRJkeN5pseD9OTI6e3+Ph6jP9zknaDxis0P7Pz5SVPXloC9k8n22C3wGcyr/0CcyRhO3kw/oM0nPfTRl/8/1/FYrdfpVuyuccmJplsUFgqgHVZBDjTtLn0/VQfp66qIo1dlRna5laVZpeRSPlz+MnsnN34ZczG0rXuoJPPP0w0HgROQjMl+Muz6zS/Mbrk9xd3b4FNEeXhacU8rhp+rDI7Zyf2Q1B7BsUOfM8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 209e9ab9-2373-474e-4c9c-08dd780f76c4
X-MS-Exchange-CrossTenant-AuthSource: DM6SPR01MB0118.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 09:09:57.1725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4BHdR62ol1OqvjPQO+BowLQbJz9LC3XJ3L+pLYMURVHye7IJeXepOXm40xwCkGq7hW1WShqip1b7pjzszRgSWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7697
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504100068
X-Proofpoint-GUID: me-yhoxHnDSCfxA3SiO8z_v7D6WgugOC
X-Proofpoint-ORIG-GUID: me-yhoxHnDSCfxA3SiO8z_v7D6WgugOC
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_021002_192130_06736E2B 
X-CRM114-Status: GOOD (  14.42  )
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

On 09/04/2025 10:01, Christoph Hellwig wrote:
> On Tue, Apr 08, 2025 at 09:08:18PM +0000, Chaitanya Kulkarni wrote:
>>>
>>> I think the awupf belongs in the nvme_ctrl structure.
>>
>> AWUPF is a part of Identify controller data structure so Ideally
>> it should be part of the controller attribute.
> 
> It is subsystem scoped really, and controllers should not differ
> in the values as that would break multipath setups.
> 
> Unfortunately nvme doesn't have an identify subsystem and generally
> is extremely sloppy about scopes.
> 
> 

This, combined with no dedicated NVMe command to issue a write 
atomically (which could error for out-of-limits size/crossing boundary), 
is pretty concerning.

As an aside, I found the scope of the boundary definition to be quite 
vague as well.


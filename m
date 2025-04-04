Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A02ADC36010
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Apr 2025 22:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Subject:From:To:Date:Message-ID:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NeIExYq9AG6/w2XTP2xS5KHmniYImfXXArtuac9FaDI=; b=PRgJK6MV6Fqovd
	ZPvyt1FKOh8G/qQZSNo19ei9gia2p/7OA2p3/DMH+jk4kRjJSWoWvNNm+3XQ5OaqdS0116Wex1byw
	HiPUbBZDW5ALwfI6og+bbVrLeI1oMT1sKzxPDYvj2JW45Ir8SvaiNmHVsBsPT2MXYMVr4Sr0F6aZh
	iOUoErFcskw0uPwUI9DVBs4vRdBViE99h3z71fPjD1EdW1P/bFSdmMQg1/L6OGXOQFvoBN+QHEkoE
	rycC+3jAQD0kiV5jeAwSQbwyzNkyW+30aigRczAa+XVqkguI0XIejmV/i9+vfvy/DuwzhIV+wdoxz
	UgaGgc4X5vzjRiJo+Tlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0pkb-0000000D0Vf-0YCK;
	Fri, 04 Apr 2025 22:43:01 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0pkX-0000000D0V8-3PUv
	for linux-nvme@lists.infradead.org;
	Fri, 04 Apr 2025 22:42:59 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 534L4Enf028474
	for <linux-nvme@lists.infradead.org>; Fri, 4 Apr 2025 22:42:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=NeIExYq9AG6/w2XT
	P2xS5KHmniYImfXXArtuac9FaDI=; b=c7z9ZqmIzNQl2NYf7TC/5wYLx9jn4DeY
	oF1BCXAZaDEQ38zkjRw/rmcMv7KX9rTSEqx408qtRWEHkEqpnSt3+/QccHPLzAf0
	iw6s/whJuD+o4xYJLckmcfXKMM9j5+jbK3x5chZcwTzLvfEfEQDWI3CMoc4XxOvR
	hWuKzCbT8ZTTjDvbis/0ZUyWW4vJAhcDT3IfU6q2IoepYZCPn2/5y7yYmUYSwbQZ
	9ou9vdKO3PqxQDqz8BdsknKMQXyLpbsAfji/4NyMojCVO5m4dpB8zZagyjtmlXM2
	tLeFML3YkxJ5A6V/fA0egiwN2ouo+PkYDcKvKuzWGC9bDuDCD7iTNA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p8wcrjsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Fri, 04 Apr 2025 22:42:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 534MFCVZ017252
	for <linux-nvme@lists.infradead.org>; Fri, 4 Apr 2025 22:42:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45t2ptwesb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Fri, 04 Apr 2025 22:42:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCo4TWMyUN+AArtrJUx+rpewhVyZxgOyS5JnEq0L51+IzHw7MVVAYJFrcx+SRJjuKCJu/uEHZwqFKlxhTv9Ec/YkCbkCdrhzJpysSSVtn9Cmqeuai1TwrMvZqnsGlfyQXauXWZEHPf+qO4P8rGuPgglcla+abGcs/C5bZyjbLQ6FNr+pm0qPIgeusik2Pf6LJx4C16g656q3SsrsY3fUgHkLZ2O0N3i26HRfbZymQmA6p1sfWTLDz3jM7oDa2zI49VHhW1q06Xn/ar1VoJM0RgsqUWSMT6AM5nNO6z553dMtb+Wuk6kMmADArv95iqVL/UiRKgUIM5FjIxe7BPcBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NeIExYq9AG6/w2XTP2xS5KHmniYImfXXArtuac9FaDI=;
 b=i9HfyDTbiWjNn3/FNeCaglnqY53AavdTxKmJ2nIn9JY/uANQRojFj6yyls60yVplkqhzbvH9W6uDBVzg/x4dhEt9wrkebHWc64lTW1a9RItvdXlqhSGUt25mn9EgyIlo3+A2dRTnb+KYkOD8vu9hdTg22ems88Z/QAIPzNv+4nPpadItVAfqCGH7ckTnQi540B+320ofxJmdwcVOXynX47t/lTGHiRRtRfeKYcI3q41JkAPVN0Unoc+1Mkcnx8K8fnt8JKR+xc6btF7dzniXod6Fotd10nGZWs3k7Cm245CAoQ0PPKKyC2mMJtjQDL7evVY9LZx+2v8G00PJpBNQfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NeIExYq9AG6/w2XTP2xS5KHmniYImfXXArtuac9FaDI=;
 b=WQCeviO5TkdTRB8bGXwzVs5xXHnFNKnu0jpykPDyIAG+J/0R9LI4ow4v89SpE925njwJwDvUl7nKhETDF6Hv0nmD0E8EEKqVR9P1utQModnC2dqY1eQB0yBenKXAV/oo9/ZNUvO7GlEEcdkWzjY08axKrqRgkK3714pyiRBzNdU=
Received: from SA1SPRMB0044.namprd10.prod.outlook.com (2603:10b6:806:33a::9)
 by SA2PR10MB4411.namprd10.prod.outlook.com (2603:10b6:806:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.43; Fri, 4 Apr
 2025 22:42:53 +0000
Received: from SA1SPRMB0044.namprd10.prod.outlook.com
 ([fe80::8263:a1ff:1b60:b0f7]) by SA1SPRMB0044.namprd10.prod.outlook.com
 ([fe80::8263:a1ff:1b60:b0f7%4]) with mapi id 15.20.8511.028; Fri, 4 Apr 2025
 22:42:53 +0000
Message-ID: <4a2e4561-9311-40c9-aa65-87e7a2e5b041@oracle.com>
Date: Fri, 4 Apr 2025 15:42:50 -0700
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: alan.adamson@oracle.com
Subject: Issue with AWUPF when using multiple controllers in a subsystem
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR0102CA0041.prod.exchangelabs.com
 (2603:10b6:208:25::18) To SA1SPRMB0044.namprd10.prod.outlook.com
 (2603:10b6:806:33a::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1SPRMB0044:EE_|SA2PR10MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: 533a4a94-1126-44b8-1d6f-08dd73ca08ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NUVzbHQxWFAxM2ZONVljTDBWQk9DV1cxbGdtL2paMXRyMzk3WlpQTUtGcHhu?=
 =?utf-8?B?TFZ5eVlhTllTWHYzM25Qa0w2SzJET2Y1eGh0QUpjcnNrR3hGcjQwY1M0UUE4?=
 =?utf-8?B?UGEzODlIM1RzWFJGdXRIbXQyc3FMb3lDbzJEKzE3Q0M4RzAzVyttcWdZNTRw?=
 =?utf-8?B?MmxmRmdHOXQzbWFMb3Q2OGtudUZzYWFiMGRNOWlON3p1ZzRQMGRzQTJDNE42?=
 =?utf-8?B?Q0JkQVhZT1oxaWk4eTJPT1NsbldnV1g5YWxnRk5WMWpJTk1ZS0twK1R1cHM5?=
 =?utf-8?B?dGFNRXdzWG9nSU1tWkhtUW9VWXJLQmpTNk5iVk91a0JnMmc1SDJqS0wzT05O?=
 =?utf-8?B?YWtpQ3BpRHF1cGF6dU9MRnhtc01YTFcrM3N6M2FFZXltMGgyUXJCYStoRlk1?=
 =?utf-8?B?WEtELzNjZGVhdlJPb3JYcXRYRnB1clZ4NGcvdmtuS1B3Qm5UQWN4VHI1N1px?=
 =?utf-8?B?RGpKY1hrM3IvY3Q2WkpucUtRMGN0TW5WT3pJMjZ2TDZ3V2t1dDd6cWRKaGFq?=
 =?utf-8?B?NjFrdnJkdmRUZUFjdC96Zm9BNGhTMDN1MGF1M0tuem9EMVh4bkF1SXR0MUVz?=
 =?utf-8?B?MlNMTE00bW40Unk3c1pjSmgzd3hoNnJhdHJVekgzdm5CQUNKNE1iOHorZFJx?=
 =?utf-8?B?ZmpwWXV3SGgzZlIrekRnbUhib2JXN3UyenhTR2RocUN6UVVjUFhIVUlpUFhx?=
 =?utf-8?B?M2x0ZnZnbWNZQkw0YWN5RWd2V2NGMjl4cUpGUEJJbU1JeUZ1Wlp4SnBXTXls?=
 =?utf-8?B?WmRyVng1VUJOZWNPa3B3MDJvM1F2MHFUMWlHWjlwZDRBc2pXQUd1NTcySWVx?=
 =?utf-8?B?Sk00bHlWcHpvZDZZVFBRRDdibjFpenFDMk5IR3BsTGpBQ2xtdWwrVHJUYXhl?=
 =?utf-8?B?M1JVN3JYeS9Gb3Y0dEpCakJNWldVN2pBUloxcFFuWWxWYitPTStrNnM2TnEz?=
 =?utf-8?B?QUs2UzFEbGNLMlM0U2JURkRrWDJKMkVSZHNYdUFSY0p2REF2czVhOENMQmti?=
 =?utf-8?B?TTVWZjAwSDEvT2VwQTROLzV1My8xek93OEJ4YUlwZHFDSEFJY21la2dCV1By?=
 =?utf-8?B?WllPRkh3RzVGNkxITmJvdHVVMU00UzdRdUtlRjgyWTlxdUN6NHd2WS9zQkli?=
 =?utf-8?B?QkJJOUE4cG9HVVFtZU1qMStkU1lhcE1aanc2cGRjbUJScWQzRCtNalhJTTd3?=
 =?utf-8?B?SVlSY1VsTmJETTl1NVdwcndWdmlyVDhUZ3d0MTN5VmtEQWt1TU9GRWtENmJx?=
 =?utf-8?B?L1ZGTXBEb1hwNzd3K1VaNVNKL1hzSW5UYUU4eDVyTzRQZnBUeSt1eE1vcG5w?=
 =?utf-8?B?b1UwVzFaZERmMnJPWFRVUDA5SFMxTzdwa2FYaGtIVWc1VFcweWFxdXZyRkpK?=
 =?utf-8?B?Wk9wNWlIb2RkU21qZmp2T2pPSnI0QTgyZW9rUE5hWVdHN3UxZVZ6c3ArZkJ3?=
 =?utf-8?B?MXVlWFRYNENDclJFYTQvOTk3NHhBbFhOVGxKdXRFbE1xd0Q1aEdjL1hJQW1S?=
 =?utf-8?B?SFVWNmtoZmtpdmhrd2lheVZQeVRUWEFyVlcvaFN0K3ZHWUVkYVc3VTlsYVBC?=
 =?utf-8?B?WXJ4cE1SRXZ4NGtsbmFHVkRMSnp6cUxPOHNuUHhqTit6dnRBaWg2ek1NYlo5?=
 =?utf-8?B?SlQya09ST0ZhS2E5ZThKUmJXNk51Zm5YeWRDWFVNN1ZsUXBsczlNNDZRRWNK?=
 =?utf-8?B?VGVvRlAwMTJwakRLL1hFWEtwU2F2US8xMFJQVzVRVTM4YTZBSUhvOEFkRktQ?=
 =?utf-8?B?TlB3dGsrTkRJYThXWUsrN0J5WnQ4UVRwZmd5OXVuZFF5WVVqcVNoczhaVjls?=
 =?utf-8?B?QXVMNGx5dGhZYXFhcWpzUXE3Y0Zib1VLYWE0SjNBeXltdWFNZzdRVFdBTWpj?=
 =?utf-8?Q?qmu1Wga68tQ9n?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1SPRMB0044.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDhvSG5PMUFyRHVqY1VpYUhZeGxtZmd3MUJxeDJlN29kTllYc3NTNDBKR3Nt?=
 =?utf-8?B?MlFYSlFxbThPMVNQNHJoejlvVUtNSHVZRkRGRlV1TnFyWVV0NWlTSkZEZ2FO?=
 =?utf-8?B?M0ZlUUlSUUFwSVp4VUJBdUlpeXNLR2NnK0hYY29ZNEFMTXhzY3owV2Y4MU1h?=
 =?utf-8?B?bjV0OEs1dWIwQm1mOTM5aldsZlUrWThzWTJiU1N5dXlJeFp3T0E5bGRkTlpz?=
 =?utf-8?B?YS9ralNMOHUzdFFTS3pQSXQyQTdTNWdsc2xmZktCZFlucTNTdWVVTVcrRDNt?=
 =?utf-8?B?eTRCQmJuMFVhQkxWWkwxaHhQY25KQ2pSRmRLOUkrMnRpSDJoU2tSejE2SnQr?=
 =?utf-8?B?K2haMW9EWWg3czk0bHQ5RGE3RldDajl5a0JWQkVFcEM5NmlMclV3bmo2K1hB?=
 =?utf-8?B?aE5UTmwyMnBZbEtpWll6YW0vQWNPdklOM1QzQmpUdDJSUU5WejRaclp2OUtN?=
 =?utf-8?B?Yy9hc2dlSUtZWVlDdEw2eTVPcDA0eDlvekkzS0pISDJ4MEViYUhvQ2wvQzdl?=
 =?utf-8?B?L0srQ3ZET2toQ1k1Y0VPMmg2VTA1RVhlZnFlem41ekFEZzV0UlJ5aXJ6QzN4?=
 =?utf-8?B?N3g0eFB0WHFrdlNCWW1qUVBaVURwdm14UTEwejVuQXRPQjdmazIraHozU1ZP?=
 =?utf-8?B?ekVXb3JpL2Qrd25jOFVyc01qY2ErTXV5bUF0RTBkcGNPSDRZcTZqSlR1RCtP?=
 =?utf-8?B?alJJL0puYys5QTE1Zy95Ujd0eUsydjJEMVY3RldhK3VBVnRsRXc5TjhIUDFH?=
 =?utf-8?B?TWVMK1pqMUZiZUVyL3FLR2t3T09tZWV2ajVJYXIzVVNQZkdtNW9mUHlEZnZm?=
 =?utf-8?B?TmtzY3AreWdDcWI1aUE5Wi9Md2l4TUF6ckxxa1VJTjdRZExHbEJRRUpQZVMz?=
 =?utf-8?B?bjFkd3RReEgxTmhFL3JDUEJTQkNFZ3B2VEpRNTZteFpoc3crZlhXa3JXVmlL?=
 =?utf-8?B?WVI4M0VhWVR0UDVTMDNLMjJwWEVTRzJlT0NpUDFYLzVhY3RxelN6d1l4bHJP?=
 =?utf-8?B?RVFmUDQrWHIwWTNOcUppVTZha0Z2QWdvVmw2OWF2TjkweUR3eGdnUkwwNDBH?=
 =?utf-8?B?YU9nd2xncUhCVTJrVEs3Tm1PeVk0V2FiRTNSeUE4WExvWENmVnQvTnJ1V1Vy?=
 =?utf-8?B?ZFljazVrbGRzYndRaVZjNVorMm5FaVVEZ0RYZzNIZ0dJRGlvR1Q5NjFTSEdZ?=
 =?utf-8?B?U0o5WUNsSDdYak9semo3Q2JZeW13VGZHZndxbnlvMncwMWU3NkZtWVl2WktX?=
 =?utf-8?B?QWoremFtUVU5S0YzS0FRMC9OVjBIdS9VcEtEVnBHNG5uK1pycm9Zc1k2TFVn?=
 =?utf-8?B?SFN0NlBQV09sV2NIdUw2c3NJalNrR2Vvc2xLZkppTWQrNmN4c3NEMmRzL3B0?=
 =?utf-8?B?VlB2am1jS2MrSUhLSGhlcGNSQllyc2dIdjhOVThaMFBxcFF4ZVNtTEd3NWtT?=
 =?utf-8?B?ZjRldEFob2g2TnF2S3VEWThMa3d1b3JRdmRJamp4YkpsLzdrNU5ZbWROK0JR?=
 =?utf-8?B?RzZMZ1VMd1NKVVp6SGJwZ2JnY3F6ckVaYVhFV21KOW5MczgyV2ppdHFMSEQ1?=
 =?utf-8?B?UTRydjdzM3Q4RzRSYXR0cHpNQzNlUEZWandjWEx5SHkwK0t5dVUyS3loTi9P?=
 =?utf-8?B?VERxckNJY3FkdXdkZVpKeS9rTldTeDlnUXNqOU5PNytzMmpRNTlsbW9lVlJP?=
 =?utf-8?B?a2FsdUxHMkZ3Z25SQk84cVBVcWtnMnFqT2tjSUI4S1d0cUtiTEM1NkV5bzgy?=
 =?utf-8?B?bzFEVkF0OXZCNldoTjJhRXRETVJyZk54d2xkbEljOUQxNGhlY3FFN0tHcTZW?=
 =?utf-8?B?TEhORjBkNHJIeHdqS3hxZHhZS3VCVkVkaVkzMzlaT0FyNG1GWXdwanphelVE?=
 =?utf-8?B?Z2Fvd0JrTG9NTXZtYlBPT2trc0tQQXBlYXlhUEFFTUZhSVhLNGtnWEFmd0Ry?=
 =?utf-8?B?bjVMaW9rZHJnQU93dEk4QWU4eW5pOXlzVHhQdU9OKzFZSzU5QkJoVXlKaVlv?=
 =?utf-8?B?UEZhSENKVEpTa0RrN3ZLcUpKVWpsVGRIN216ZTBZeXhtSjVKckpaNmZ4am9q?=
 =?utf-8?B?S29CQkxEcXBxSE83b0ZjZTRmT0MzK2JDREZ2Z0pUdDB1QkVtWjdsczM5K2lM?=
 =?utf-8?B?a0NwYXJlTXY0QzRQbmV2cmtaZjluTlFVR3JLVGYzMHc1WlR6ZWRodnZXemdE?=
 =?utf-8?B?SGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NPmTRv4PhS/0lN3MjZI37yKlZcY6SujJyB+fQmveK9NV9i/vtxRCLBAtG4/AG633aOVWKkIyVsAvErlZUhJbuvJ4KGjq3XHwCgaQN4I8M/pMnRQMZmX/hCAqL/NPQYN6OKmLXKKkdJyKVmibIFrM6LfUtMIRg6K6PAtRKDPeozvjtkNq1ml5kcOut4Pu95rQeTVseMie7a4xTnWzE/URzR7Fd7m0nnvUXPEWLPBY1sPeizhds9m7ju2xTNga6xN+fgjab0FJFae+GMj5jaymI+cJXk/eLrze9cr0XOoo+tWme9ZUf67SbN5IUmFCVOLGvBq9KvjjqP4fQKGmqCzdRNalZfUBbftOcoMCwqq0cyLI5NuYrh9PkXNHG+fhfGtXDRu57SclmWMRLupKhZVS78jmbu8xzSyJPGTbm0Et7sYhwvFi1bkMR/F4n2biB++DwS2NMs8E778SmO6JHLO7NtZQGlZFK5BteLo66dKTKoIzvCL5gc2Z5lQkaxzWZMVA9EHTexHtEPrXTivh/lXdYUIC4cGaL2hKFngNFlSJK0XiBEG10/KpglCKA0xGxCiwAPe+UOEbV5o7ldznW2zwwx8bosrsnE9roV0B5WAscZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533a4a94-1126-44b8-1d6f-08dd73ca08ff
X-MS-Exchange-CrossTenant-AuthSource: SA1SPRMB0044.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 22:42:53.0233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ucmZKpReMIBlTFUua8kJCx8aoavifMUKJwpWHfSPg1HCOXCHOFNR5mhecU1NasbTEURjc3qbci9pOdhLVsMdLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-04_10,2025-04-03_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504040156
X-Proofpoint-GUID: NUz1wtSaISkINObWQp6ZVm6qFkM4eI8G
X-Proofpoint-ORIG-GUID: NUz1wtSaISkINObWQp6ZVm6qFkM4eI8G
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250404_154257_978450_85403C12 
X-CRM114-Status: GOOD (  10.06  )
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

While testing atomic write parameters with multiple controllers within a 
subsystem, I found an issue:

QEMU-NVME Configuartion
=================
-device nvme-subsys,id=subsys0 \
-device 
nvme,serial=deadbeef,id=nvme0,subsys=subsys0,atomic.dn=off,atomic.awun=31,atomic.awupf=15 
\
-device 
nvme,serial=deadbeef,id=nvme1,subsys=subsys0,atomic.dn=off,atomic.awun=127,atomic.awupf=63 
\
-drive id=ns1,file=/dev/nullb3,if=none \
-drive id=ns2,file=/dev/nullb2,if=none \
-device nvme-ns,drive=ns1,bus=nvme0,nsid=1,shared=false \
-device nvme-ns,drive=ns2,bus=nvme1,nsid=2,shared=false \

[root@localhost ~]# nvme id-ctrl /dev/nvme1n2 | grep awupf
awupf     : 63
[root@localhost ~]# cat /sys/block/nvme1n2/queue/atomic_write_max_bytes
32768
[root@localhost ~]# nvme id-ctrl /dev/nvme1n1 | grep awupf
awupf     : 15
[root@localhost ~]# cat /sys/block/nvme1n1/queue/atomic_write_max_bytes
32768
[root@localhost ~]#

When dumping the awupf value with nvme-cli, the values match what was 
setup in qemu, but when each devices atomic queue limits was displayed, 
it didn't match its awupf. Currently the awupf is saved in the 
nvme_subsystem, but the awupf is specific to the controller, not the 
subsystem. Two controllers in a subsystem can have different atomic 
parameters.

The commit 81adb8633491 ("nvme: set physical block size and optimal I/O 
size") added subsys->awupf.

I think the awupf belongs in the nvme_ctrl structure.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a8259e3334ff..2483651817fb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2059,7 +2059,7 @@ static bool nvme_update_disk_info(struct nvme_ns 
*ns, struct nvme_id_ns *id,
                 if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf)
                         atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
                 else
-                       atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
+                       atomic_bs = (1 + ns->ctrl->awupf) * bs;

                 nvme_update_atomic_write_disk_info(ns, id, lim, bs, 
atomic_bs);
         }
@@ -3032,7 +3032,6 @@ static int nvme_init_subsystem(struct nvme_ctrl 
*ctrl, struct nvme_id_ctrl *id)
                 kfree(subsys);
                 return -EINVAL;
         }
-       subsys->awupf = le16_to_cpu(id->awupf);
         nvme_mpath_default_iopolicy(subsys);

         subsys->dev.class = &nvme_subsys_class;
@@ -3443,6 +3442,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
         else if (!ctrl->apst_enabled && prev_apst_enabled)
dev_pm_qos_hide_latency_tolerance(ctrl->device);

+       ctrl->awupf = le16_to_cpu(id->awupf);
  out_free:
         kfree(id);
         return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7be92d07430e..fddcd2de218c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -410,6 +410,7 @@ struct nvme_ctrl {

         enum nvme_ctrl_type cntrltype;
         enum nvme_dctype dctype;
+       u16 awupf;      /* 0's based awupf value. */
  };

  static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
@@ -442,7 +443,6 @@ struct nvme_subsystem {
         u8                      cmic;
         enum nvme_subsys_type   subtype;
         u16                     vendor_id;
-       u16                     awupf;  /* 0's based awupf value. */
         struct ida              ns_ida;
  #ifdef CONFIG_NVME_MULTIPATH
         enum nvme_iopolicy      iopolicy;


When I apply this fix, the problem is resolved.

[root@localhost ~]# nvme id-ctrl /dev/nvme1n2 | grep awupf
awupf     : 63
[root@localhost ~]# cat /sys/block/nvme1n2/queue/atomic_write_max_bytes
32768
[root@localhost ~]# nvme id-ctrl /dev/nvme1n1 | grep awupf
awupf     : 15
[root@localhost ~]#  cat /sys/block/nvme1n1/queue/atomic_write_max_bytes
8192
[root@localhost ~]#


Does this fix make sense?

Alan Adamson





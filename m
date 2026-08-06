Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BCAC55ABF
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 07:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:From:References:To:Subject:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WUGa1D4k31jZQAKlXYz3fAGNjiQGEu8re5Zp9iNZdS8=; b=tCVoST01dNb4aIdKvtq0K9YdxS
	R8UeJiMqcanu05fWiZaxi4a29SzyQSxh3iHCbDLcfK4BWqJBtEXCT/1Hmhtx98vxm0OK5X3WyjiQf
	8Dspg0kKaWwVLZjAUXXg7J64HMUaRkcySO+xJsPOBBMPz5wuolf+ak6koFmd7b3lR7pk92LyLaD4Q
	OzNuwYF/OYBxVxUN8Apuj8j/RnLHcJ7RMh6QhjVfAjANTot0EcrQ+ES7x4d+s7Gx87GwaEcADq64L
	8XQWpK0L1H5gmg7s1DeFF++aXxfA1lA3HFRayZpzd3LIuQkHM87m2tRZTVMrI5whKyqEEXYZ/ezhZ
	3DRhpT6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrsU0-000000058cN-2Kqr;
	Thu, 06 Aug 2026 07:25:40 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrsTx-000000058bx-1NrP
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 07:25:39 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67672Ap5795803;
	Thu, 6 Aug 2026 07:25:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WUGa1D4k31jZQAKlXYz3fAGNjiQGEu8re5Zp9iNZdS8=; b=
	n+pw4KXmBOX/ubumyT4n8w/5MN01GsaraBxM7qtET09/ZptPV6dngvfkmmjCdjUc
	0hy2TsgeP9vO4nRBKZMAIyZrh/a7a0GcH6oZuTCBVner/LmUHAS3iG9X0Ehp37oC
	hYGvNjHv8NWln6EcEggTNnkCwdQeZTMOsm5DGziSvQfnGJkI6UvxdTYjb1g4XnRh
	MhJnZWvvBaJGKg5gzktB11t3cePFsmbcGWKWl9bWstk0TQ0ayNvlMnxx9KMk8MNu
	210odh3SxYyaAVVk8bVHLtdUrRx4jzTHcd6avylgLs2J2wKWAGqSID+Xn3z7ncWL
	bC1fkp3wC7satQZAmmG82Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fs8p9c2me-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Aug 2026 07:25:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6767PWsG002044;
	Thu, 6 Aug 2026 07:25:35 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013055.outbound.protection.outlook.com [40.93.196.55])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fs78vdxht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 06 Aug 2026 07:25:33 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kTNPml7q82aKFzqqdb3t+fiTdNepWWntI6gShJkdQAA6grfe8spawuov7QgZvevrKR9XQx7CcfpvA8DpjJ6cjitIfTLt673HcgUxNExuIHtZ9zUyWnCXaXmaDG/SOtpmI5hhi1rD5PQMlPkW5/+mdARohcMxEGNGI5icgi7inrveoN5NhomtYnoxiLEzkSSdweRBTGkVuf56GiJ9B85hI51XtjhuyEjTf8s3aDccBNCzQBRGlAMQv8ApIhXt6JS7uEDZglYp8atqbztR57dTfjPezt6UD4W3jtdJfDXIjObElG19iIgEUii3VrtBOc68+0OqgO+DX0m1oDcTtsml7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sjlqi3MamcaGL5jE9kSmxo64EGq1Bt+rlT8eu5GhdhM=;
 b=TgWags+19KgCCFp8dzCTXbLwgmEEWzoSHJF6IOejlvHGjFshqOq+y18H5I1R/RUK4/EkH2ESHG34Z18UsWSoSNAokdyIBoOcBo6Tlf1qnOIx5ALP8pDT8tqPBxSIGyugmNGvKgxbiWT98heyNuMjbYq5LZeTiUb1xr9rtOSDMxc/ZT/HfSGDiASTDwYtF76neMT1aRiw40fCgj9esgUB0843fRHpld3xcAvsjf6pAztmTOpgko4HhbYwFanyYJc49pW2uzd9Cj7c4y7mvByrgrDKRtPJPoqXU7XdQmqnwevMev2p4gY5Zzs5tWjmoqBjx9obR3Lps3kHe1pjb5ByIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sjlqi3MamcaGL5jE9kSmxo64EGq1Bt+rlT8eu5GhdhM=;
 b=AlEsB8T94OSFhD+FkhJ8gsaWglwDbDDCpThX0zEE6flnt9RN6oitMDXq2dfQuLJdSQ9w5ZQvxbqOv95w9lFcppVN7eMJ72y7HdFQUnMowux9dXJZ22zXKQCG0Y2VbYq0Q7o01zXYNHQm6aIck4WwSJwd/TmyCrsvu01LrndXdaI=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 SA1PR10MB997763.namprd10.prod.outlook.com (2603:10b6:806:4bf::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Thu, 6 Aug
 2026 07:24:37 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 07:24:37 +0000
Message-ID: <57644cf9-ecce-4829-b7eb-82375960946e@oracle.com>
Date: Thu, 6 Aug 2026 08:24:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2] nvme/068: check module reference count with
 patience
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-nvme@lists.infradead.org
References: <20260806033146.2067433-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260806033146.2067433-1-shinichiro.kawasaki@wdc.com>
X-ClientProxiedBy: LO4P265CA0255.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::20) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|SA1PR10MB997763:EE_
X-MS-Office365-Filtering-Correlation-Id: e526f168-dd6c-4f2e-0b3c-08def38bc592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|3023799007|4133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 90l1kaOazzmBCZpJ3peSTtBOrUZlScqq7bqN091z6mzqG1KQ67Os2xjSc+kzGaYmTDMf9uksuQaeZ3Q7+kZhz/eKACSRjYNWk4Llqox8Tyq4CAqYcc4v6gMivAk9VgXiHwjWbT0SoBIJuqvZ3sacPIvGg4+p74yByXlJGiRrjBTq/Nud2aIZJyfjhUDldYt9OS+qLatrdHoR3rwN5ee9IsgBKYrhiV1idtuL3ToBoKAV0IXj7qmugdYhBD/bsnnCyC1TToNFzBoCCkNc5WPTmWLCpoxcS8ahtNnc9L9jeY+2/fYLV6ZMUbC0Y8DNWZ6Cvd7k2pHrRfJRydqGTWpl9+ns88EtihpzfSacKYkYnIzRcExHogGhDsrg1pqDmjzjFIgfco/Y29kxCmU19niKMFWCSXfs5fGYK7O5AF/zvA51klElYvoRsSnetpNnhgCuU9dBXObRHlBarKsrDJA/FA0pTwjuVtdYXYYzmO5yk1WwbuWqAYvwcGPWDJ3L14/i6hSDp33uAi/frYgLzmWg8NG0xh6qqoU54uH/P0GXm96GUOtoAVuUqq10iG0XSQnq6hx+6PKfi1/p6CAFDIK+WemBjDOwuzUzfb0lje4mb0/6P0h1pYJwH1Em03+deZfSsEzmbPJGZGeWOfnTAvmCeKPFyq9VumSd+AwjvcHdUBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(3023799007)(4133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1l6dkdkd2hwRm94czJpaTNHb1ZxMTR5NkRIZVloVmZ4Y1RCOUFkQnM1Szls?=
 =?utf-8?B?cEovMWo4RG9qQmdzUFJLcXVTNklKNUw4aXZuRWZVd1h0MzVVeVQ4UUpOVE5V?=
 =?utf-8?B?bEFLVGhxQkNTY21EYWFYZ1gxYm9RTHdGbU1zNUZEYy8ybGY3b0MwSGFNaXFG?=
 =?utf-8?B?eVgyUzFJTVAzdVlqYUYzc0d1cHBxVHVvS1o1anJRaUpFYjBQTVhqcy9SeDYr?=
 =?utf-8?B?Q1NIT0wydkd4UjdMVVE2Z1JVNzh0SGIyRlVYOTFWOXF5UjArMnIwVHlFbHJ4?=
 =?utf-8?B?dlBtNklhZ2tvT0lhaC9VanNYcU56TUpETmhXOEtpcDVVb2dsOTFTaEJKejJi?=
 =?utf-8?B?YXhBSXBTd1k1M2RpOXF6K2NPWGZkRk5zNzhSTTFRYktmUUJSanpXTUR1cXlt?=
 =?utf-8?B?U01HaEFXRXU5RzRTeWdwL05pZERuM2FGTXdjZjRHbFgva3F6VzdhRWxhTjZv?=
 =?utf-8?B?OEw5UU9LdUFyZ1E2S1R4U0FSSzI1c3BabjFlYkRmSWFabDNXaEJUVUlZQVVj?=
 =?utf-8?B?M00rWjdhTGxXL0ZodElIQnZseTVkbWNqVU5ta1lvY0k0REpHcjl5ZnZXbHRD?=
 =?utf-8?B?SWZHdUN6Y1lHL1oraHp0RzcreWdyR094NWgzb3pkY3Ird2xaQU1Rdmo3MjQ0?=
 =?utf-8?B?VWdlbHhOT280YU5RM3NUc2JXRVlpUXQ1S21jVCt4VnlFd2pNM0JDYU84RE1J?=
 =?utf-8?B?Qm1zWnYvbGNidzBrZDdFaUJ6QStHaFNPOUV4Sk96VTlSLzQ5dUNmRG85SUw4?=
 =?utf-8?B?aktPMC8xQzdtMmJCOW9ITU9JanJTT3ExVmtOdkRMcGdhTEZyNFNpS0RPMFdW?=
 =?utf-8?B?UXh2WHdJS0ZBRTR2Z2szY0E3Z1I2c1NVYzNIM1dLSnJGTld4U2dmbTMvVWFT?=
 =?utf-8?B?QVczRzZTK1N3d2lub2g3VzVNV3d1VlhYRUJPM2VDRnIxU2R5Z0YwUjl0dHRN?=
 =?utf-8?B?aVljYlpkUFFSZjZYeWZKRUxMdVBGaVpzK2pDZ0lad1cvT0FnVzg4Qjl4SVNs?=
 =?utf-8?B?aHZ1MTRaV29INmN4N1RJbzYxVU1idytpNWUrZkpoTUk2ZnlrNHAwcXlMS1Zs?=
 =?utf-8?B?QkN0SFloVUlZYTVNZ3VFclFEcXZWY2NVQk1IWUNLaHFzemVtcUlnUS80VFhw?=
 =?utf-8?B?bTViaHRpbC9JUGdvZ0JIMzBpTXZFN2hGbk5QRjJjVFpjNzVzTDducVJqQVdi?=
 =?utf-8?B?RUNleis5eW1yWEE1TjFjbzRtMDY2YzA4WnQvUE9HNVRnN0d5NTJtVXczc2Zh?=
 =?utf-8?B?T1hJdFQxMHY0aXBwSDRGL3JHMHZWRU9wNTNlZGlvRXZseS9Wam4vbHNpa0Zl?=
 =?utf-8?B?dDF4UUFIblo1UFBFc0FyVmxtNURwVERlSzZmaUJjTkVySjdEZ3c2eDV2aFFR?=
 =?utf-8?B?M3NzV2hNTmM1ZDNqcXJqUURvUVJLWHZqay9aMUhTb2dsRys3Q0VHcVE4Qlkx?=
 =?utf-8?B?ZHFiOHprRjdRMXpCYWhKSjNYTEYyNmZDNGJlOUR1a2hqU2dWRnh2QjFnZzA0?=
 =?utf-8?B?T09sdUd4NkVkVGFVUEJzcXo0TXQ5K2VUTU9Qd3BvZG9CeTZPZlpWdTNEczRN?=
 =?utf-8?B?UnNDbElWQ0ZDYTZwdzNycGoyYWFDNU4xUFAzQkI2L3hPU2huT2IxcWFUYVVS?=
 =?utf-8?B?M2FURGtBaUZqeVpoK0luOWZsRmxSOWFtZnA3aEpMMU9oQnJzS21zZ0cvS0xP?=
 =?utf-8?B?YkljT1JyaytGOTYwd1FCTm1hL0M1VXowdUVmcW1qaVppRHgzbzhUVEhaWjRm?=
 =?utf-8?B?QmljWTc0NHZkSWRCRnRld0dGOG5vdXlsRjFFbTBWL1JoSnVVM3R0c0NKRW0x?=
 =?utf-8?B?cDNKczBWaEVwOEk0cjFwN1h3Vzg3Nk5WeHJhaWl2MUJ6SWFqcGZhQnE0cmlV?=
 =?utf-8?B?WnpKdGVienlZc0g4Q3pFTnoxQXlJcjR4S2pIREo3WkRjQkJ6Q0paT3M3SlRq?=
 =?utf-8?B?aEVaRDRTcUljT0dHZE5lN00zM1Z2akswMk1melBRR0FjY0dsa2FnUk1sdjls?=
 =?utf-8?B?dEZCNnZWRllWK3lZL1J6Njk4ekZnTVJqcFloRjlVUHorTjEyYVE2aHhleXZa?=
 =?utf-8?B?NU9nTTRhaHdmajB3V1dwcGJYL1NMeEdSY0tNQVZvM2N6YjExVDBZMU5EVWwy?=
 =?utf-8?B?ckN4cklVQWFiNjVoS3JjWlJCQVArTjVQZTkwOGpEaE51eHZHUzRxOVdkMDJY?=
 =?utf-8?B?Y3FNQ2ozQnA5T3BCay93UDRucHRWUkZRNEpRWDRGMEVBS01LdW5yeitQR1pV?=
 =?utf-8?B?Q0VBd1FPTE1IN0dHVisvREZPaGRxR0NWajY4bS9EemNKQ3NqdGplQzFXcVFC?=
 =?utf-8?B?Tzh6aWVDU3hkVmZMRWh4NnlGMEovYzJJZGpPdFd5c2QrSmNZQVZlQT09?=
X-Exchange-RoutingPolicyChecked: NNnXA/tNTq6JNsNGaPAclr9dVJ7IxNxYMjX/PDdKQhmUbpVe87+QPuTXgUWPctWVMHPypNQBEXWazkUBTQeDx5fhhHNI2u7k1YRhHvFkHzyUT/vSZAKarEoCCR38r1sqN01XBGZ4cG6d93guj8S44KIZ3ptm8RUc8vr5rgdIpBhbnwFHd3noTcEi+HFxs5N4Cyr6N69AONXZN9n4SgMtvT+1FfgeAvnyDrYzpFtLXSevcMjLKWP94rAOW9uZj/xS09id6OzZ56RjPpl9vIa1xWR3XQgvilnkrnS3UDfTli2ri/K1HLRgiAth6kHUQWV8THbMC37lsUF6XmioQ7rfcg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +KPoXTh+NGpCecx2KcekT7HzOfxSCnq0UTyuD6sLsa5PQKNM39jJ8/hYaFW/bofhuYgpUphZzBwvEWBaIbL7mbJqjRuSnaKM7McgGA+QbuY4bWd/dJxEhhEguaR2tth6w5yokT/pszjgRDgvzp1SMgLF1GrH40OG/qedjzW+UiKOCRvN2M3PLl8xAHKRPQZjqVFdPhUS97rxOpArjo0nL6V3yh5v1kM1aAUZHBwnAiA57+3w5tBzhvmxnx4wGlKAHxTbXhKOni4vyWl6KCyzdXT0VbiTDcv+VRzMkEO86V0rG3py6OiIIIGAvYYNg70kDJn9Sz5rv7Bou0t0fRnaxYXTozBR+qzIdxdEUZe7QjumXclnfQKUIvOSNdP7tbDOYZ8aX7AXND1PiRLQcRiMbC4wubJXN9rs0PxhDEKD66pNecNa1OEc/95E6xSoHrgSvbLVxpWSkcQ4jqRREcy6nL9wrsuSZAQgfqFzorwFphjJEo3E1gwIPZ1ngIYL1qOvhSLppyggXP6v4Wo8DRcnptUnJmYphUWEKtG/aXeuR4joOWmkayrc1dRnT91r4zHVd1/WZt7xjfse7rRefPMIXv2gH9+TohFPrRT2C4fZrjM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e526f168-dd6c-4f2e-0b3c-08def38bc592
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 07:24:37.6269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zh3OsHHILlltDpDDokwKw11kWDr4LGuZkiLcLyhrFwKt8o4FFN7eYkDZes6/a21UU4gwsD8jKHLEA2D3Rjy49A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2608060056
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA1NiBTYWx0ZWRfXy4qBCEki1W8y
 eXea6kssE8suDiOU8b7rO1YdqYhooK2SifaMb18Q34FD5sJ5G3MToYKeOX/NC7VSlTvOorXj/3s
 Hz/WPdnALvSp1oIKqStbT7EMbryUlQHQ1bKOpLgwYo2JLcW9/oVZ
X-Authority-Analysis: v=2.4 cv=EPU2FVZC c=1 sm=1 tr=0 ts=6a7436f0 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=RpNjiQI2AAAA:8
 a=JF9118EUAAAA:8 a=yPCof4ZbAAAA:8 a=fixeXQh0kQ4YcDJKwVcA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13510
X-Proofpoint-GUID: 4E6DoJW_Bpr6ExDeEBVl5lGP-Ccfjl77
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA1NiBTYWx0ZWRfX2IeH0chzDBIV
 ngiTsrFRW1UaB0n7s5Q13NCtyB9+vwFJtCojJ9bdFfXqLre8zIYjiaoguz3UsZI9TNp9J2fi2EW
 7YIP2Jij420N1A9NDwvRXTGj7mnRdTvqPvzDzo3n3qJLBGMVEHjYyDRcUssIWCJf8R8WsBP49S2
 EhuVB6nyo8ePqVLf0dHCdziu/lmqCz2+YIYEtcBWq7nEjRzUKc2slIz2t+4swF3FLe4fyNE8GAI
 lnBbIgOgbOZSz+BbFVVC84RxXRn15L3o1KwQq4iiG3uIWx1/5biKsMhLDxDO2rqpD1jQnOa38LO
 5dMhGanGWlrqLGNavupZ0Cgexi5ohsTEWuO7bkOOnde2w8SmH/zkUkDjaHdAknKY+Nt2QN2q2hw
 w8dXxFqvPyHAOQen8AYv+BeHtrjt6Q4J4JmJug5PhCBG1mq8ADlZUresrFBQW33t6tua1P42xVr
 9i+g3Guw16IyoFuKHlZPSSaXsmK5hYIZURW5Z/vw=
X-Proofpoint-ORIG-GUID: 4E6DoJW_Bpr6ExDeEBVl5lGP-Ccfjl77
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260806_002537_586183_EEC90DE9 
X-CRM114-Status: GOOD (  26.14  )
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

On 06/08/2026 04:31, Shin'ichiro Kawasaki wrote:
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

Reviewed-by: John Garry <john.g.garry@oracle.com>

Just one comment/query below...

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
> Changes from v1:
> - Per review comments, handled empty "$refcnt" case and explicit 0 return
>=20
>    tests/nvme/068 | 16 ++++++++++++++--
>    1 file changed, 14 insertions(+), 2 deletions(-)
>=20
> diff --git a/tests/nvme/068 b/tests/nvme/068
> index 4aee95b..cab57cd 100755
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
> +		if [ "$refcnt" =3D=3D "" ] || [ "$refcnt" -eq "$refcnt_orig" ]; then

I thought that refcnt_orig was local to test(), so I am unsure how it is=20
accessible in this function...but it seems to work.

> +			return 0
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



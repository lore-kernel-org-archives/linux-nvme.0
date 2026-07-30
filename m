Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7132C55165
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 13:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QXVfEAjcH5HfXpVIqyTzGLAvCSLm//wF/Rd3zSN4QtU=; b=IZB1QA7Nb91jnuRIdXcruqxAL7
	yCviqVg9Cmdm9av9MGyvrThNAJJtHFQaTb3+6KYHicS/kyTWncxkWSeX0GEJLIxpnLaarG5FElDTE
	8og0nbaJrGJ94zNTkZ951vR7JMjzt9i3CFA7FkV/2cDtNuclGaUp5C3h0W39IDlx3fY8Fx3nURv+9
	mOrzFc87ghD6vvBTlHbC7DjdGl8waNjZXEMEJqltM6m4m6UbwcBq8lrS8evdqT2IMgu5IIgqzRoH6
	yofr/cNk4GUwL9SQQz8UwGz2/WgsPKNNbDmTKc4PN/Uk6duq3cx54brbAKSq83Q54ZGskWBQnD6Uo
	ZKsJSMuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpQSi-0000000AXVO-1A3g;
	Thu, 30 Jul 2026 13:06:12 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpQSf-0000000AXUW-231C
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 13:06:11 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U0SNaM4138676;
	Thu, 30 Jul 2026 13:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QXVfEAjcH5HfXpVIqyTzGLAvCSLm//wF/Rd3zSN4QtU=; b=
	DCPt039c9NY9QueP6L9aHna7TA3CrhtJc868K8dlSHPCh2OLnn7L74djyFB7f5fx
	3F6N+L6vA5aXxIEPIHAByEKUcP91Vko+m/GxavVP/dAfO/+FZKC9dWWpZNPwb5tO
	xWppU24+5GKAgyq4UU8YjaiY11Ak7sGHbEg0w83SBAQ5DiRTktS6D66JsHtjGUMf
	ZUvmcV4K2fznixHRs8r+PtKvTxGcNmmtT0gQFN4ZGJSZzTyHVMfCb/AaLuizU377
	APJPmRMxHAlDDgCtT82IMY8KVzWs8/KiVYb21d9lj5HtknyP+gH4PIULDcqpPlQ4
	cKNaKdwtxHFmTttfzM20qQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmqyq7kdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jul 2026 13:05:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66UD5X6H008692;
	Thu, 30 Jul 2026 13:05:51 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010042.outbound.protection.outlook.com [52.101.61.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fnh6f4rka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 Jul 2026 13:05:50 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZ9D+WtW0+RE3Rt1OkOTpj4bL1DIHSqdM6CaEe8kNXJqvAeqJ+LWjLFABeKWHU2hfnPL8xKTkMcvFOTvDvahW3XzLZmUbHwkcB6CVO9A4U2aH3MCH0BWwtpAPdNYq9YEKEWzIm5RrTqG0Rnwn1nGQO+VKcfS3Ow96ekrLIqaacNxqIs2FKNW8d7kG9jMWM0fLVTjc4sP4w2gpII2cRsP7X619KD1vYGpjox5F3QYO+u6erkYjhVpRAba9OPm/0WhaOdkWrt7nO0hMD6x/Lqf6EhQULDML5O31K6Hs7hEouUYXBD6w+tw8vXVxMPZ5bnRp7W7fs/6HVUyvcBdpkkWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXVfEAjcH5HfXpVIqyTzGLAvCSLm//wF/Rd3zSN4QtU=;
 b=h9/fAfdzF+hAstlA40k+nXNH4IGHWja/bCvtYhh9UdCULPMLLhWktbeaHw3myKUvHMpggY6ALqpYj5kdIjyrXnOJR5exZJC88lDhQXwjeYw0rKfgsqdJdJDDvX2cfPSwgHscyR2EnavlF/2L65st5mvDC5IQEmoQv2JrEYp12D9iV1GBBK07tuJqCtP8fPufcTeBEW5b9MeSYEo4V43dBBUY9yuTC2lpX6DkRgMn0hSLtLZdiEHtOWCpljVGBlMOB2W1MgbwtP9ZfX9nOTmCcqLVCwF0ExCc7LVl/SmefNjrq2DpuAjfyRiq/dYmuq1PE9JG7ZjMa0PPoFPO8m24XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXVfEAjcH5HfXpVIqyTzGLAvCSLm//wF/Rd3zSN4QtU=;
 b=gazGxVp7vR0xrpcM0+M9VaQpuOViWynhFm9fr1GFue8sxPMLhAeMY6P5s4TFpPYJnDyusKwKDapo6LHD4mF6gzoekUObmCNNiT8Hh6TPvpCCq3iC0dS3z0vbGF6vg/rjbvvOuF2HujohKZVWmMtPy/XHxQRVvYQABRi4Q51FkXA=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 CH4PR10MB8228.namprd10.prod.outlook.com (2603:10b6:610:1f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 13:04:43 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 13:04:43 +0000
Message-ID: <be5876ca-1b6e-4225-b529-6ca4752b7111@oracle.com>
Date: Thu, 30 Jul 2026 14:04:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme-multipath: don't retry adding head disk
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        linux-nvme@lists.infradead.org, John Garry <john.garry@linux.dev>
References: <20260729182235.366634-1-john.g.garry@oracle.com>
 <20260730114009.GA25956@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260730114009.GA25956@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0260.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::11) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|CH4PR10MB8228:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4723f6-63fc-461f-979d-08deee3b1f97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Nv3UxdGfkdT7xBX+/M1SrmZVxdZLLkS3J4RUvjiS26lhgq/CKeeSWud9ifZ1YAedcO8mj6fC8Vwj4MYT+p+Tj+zKJ4RPTg5V6AYAAIp3ix5L6f3jf6jE/FohOon5JlZw91nGwZ9m+XRLyFC8GfoA4O8ipVCVypfVWjs5dkP8vdiOOmxeVYM8Z3UN0d2QEcA4KyxrQ8iCmyRIwHqnEpW3/6kHYoHOOBby8P3xzNyHYvt6D1xgBmoT+//qej+q+JbjvMJQcYMw+r7wvxo9vvvr7hukvFJGISHUFzuxzyEe9BoBJQaheq9J1w1cdCGfePETZSrV7a3huQ85EhaxTRbHv7e17n0oxFFL2K1B1QOofSNO14FErjkM9zrxcyXUYNChD383jkDpvyhCgtZWbUEDJXR+NqqQDSeM0d0bz+DrAtTlrEnxzFxu2sDyU6Hs9y43FJJeCEYrg7a9Lnms0SGl4wcQePsz93019c4gSLltUpmB0GnJYVUA6d9iuoqJmU/Xkjhd855J/NB1ny8FTSrj7TOvtaHrkNAOuf0bZMNI0IOeW5wpy4fyKnqItV+JMMFxtl8+9C8T/4yArCaHJkNKSYM98EwsIR9ZfvyWqrS9zdzzkojg3DOGNoBYjpbtoVv0oRka021nx+L7Dmg0AnmrHHosGwrhLNVQIGEpILgFYXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3F3ZDIvb2VPdzlCNjNCZC8rSGhVWUVaMTgvRUp2OEYza3lYYkI1RDFuS2lQ?=
 =?utf-8?B?OWVySnNGanl5VzVIVlVxc3RCTGliNDd5THF3NzBmTUxScjlJaEN5K25EVG5E?=
 =?utf-8?B?M05XeTVTSU9JSVdlMlYxLytjM0hpSU9uK1ZSQkp2R1RXUVVRamYzZXpEWFVJ?=
 =?utf-8?B?NEZSTlJ4Y2NQSmNqekphWGg5bk40ai9FRmZuMW5JZ2REZUtSUUpQKzV3cTh2?=
 =?utf-8?B?dVM2azR6OHpBSnc1L2cxYWNyNzRSL0NpU2MwczZiNFNoMFFsUUdmd1BnMXRn?=
 =?utf-8?B?cVArV1JEeDdPNnVpVGcrZ00xWHVZTUpyR1FYM0NucERWRmRBREpnZlJ0U1JB?=
 =?utf-8?B?UmtFQ0tFaDR3S1oyY2R4TmpVTXhEaXU3UHBtYlN5SkNEcDFYWTF6RU9mQ3hT?=
 =?utf-8?B?LzRBNTZBeGhxZElnK0VGR0crNnV4VUZ4Uk15Tmd6MEhzbytsT3FXN2xKWkVH?=
 =?utf-8?B?Yk5IOEpyUm0vaEZMU05KVHdjdUNwVTJVL0IranJUMldFYktsQjNDZ1dRZDVX?=
 =?utf-8?B?Y1cvdVU3dFJyYnYwVTNNcER2eVYzZkEyZm92eEFiQWhSRjRuMWtsUzQ1azdp?=
 =?utf-8?B?KzZ1Y0tHd2xSRFkzMWJNSmNpYi9ZSWhJU21kY1l1eFNoM0xnTnlNdVQrYmh5?=
 =?utf-8?B?OHVDaVBqU1YyNndKM2c5RVkzbTlVeVUwYXRVZGdsVG9EditqQjhXeE9aVEdO?=
 =?utf-8?B?Z3g4ZDF0eVIzTlBoaFAxMkdZa0lnbVJ1WUhtUm9zZ3FJck0yRUIzaHM4WWxH?=
 =?utf-8?B?VEVISDB4YkdrM3g4OVo3WnJhc1FqekJWYzJQT3RpQWZFL3hRNU5OODRCVlVW?=
 =?utf-8?B?TFhHR3dBbGYvRW53QUdsRk8xWjJ5cUkrbXpybit6ckdudHQ3cld0MlFpd05n?=
 =?utf-8?B?ZHFLMmVIK3ZLd3lnL1NsVXAxRk5TZVAyWklBUFRIK0hORS9GQ2tvdFMzbmFa?=
 =?utf-8?B?VVcyU05yczlRbmU4cTQ1cC95eFVIMlF1S0xkYXpuaS82cU5Ma3VmSXEvWk1X?=
 =?utf-8?B?Nm5vWjluVjBXM0RUOGNtK3RleGxQMVB0VW5yc3ozT2pjSXFOdzVVbnY0VVRw?=
 =?utf-8?B?NldneEd4VW9sTlhNaWlwQm5Vb1RsWkgyeXVEakIrZmE0N3J6WTkxa2JEVEsy?=
 =?utf-8?B?RnRkcXZQUUNwcG5DN2UrdExaR2YyazUxNkFYT1Nla2lJUnVyN0h1UFFVaUFK?=
 =?utf-8?B?R0MyNmp0alBSM1ZEM0ZZR3FIZDBTVE5TWmhOV2NPdDZWZm0ycWN5cE1QMyta?=
 =?utf-8?B?VlNFK2NUUHhjU2lpN2FiUVVLdyt5dXZLc3B6a3lkVzV0NFBSYktMcnBCOWpJ?=
 =?utf-8?B?RzV0TnI2RUNvY0FJSzIrYmkyRFkyMG1LSUhvWWV1eXRDQkpZL09WMWNZcXdE?=
 =?utf-8?B?Y3RLRklTVVcra1NYYWdmeUFsK0ZJdlhaMitMSHpPRWplZWVWVjNXZUdQTnlq?=
 =?utf-8?B?QnlIbzIwNHRsVjRKQjFKL3o4aUNGY2hMNWlxd21GNWNkTVQxTmowVnJudGg0?=
 =?utf-8?B?VXRlTmFtZTcxY3IxL1NLclNTcUFtK0pLMmRlTFlQbmxxNHdpa1YvN1RFa0tm?=
 =?utf-8?B?eEo2UWtNTTdEMFV5VEpiZ3pBZlJRRWxZRk95WnVSMXV4cVZtaWVVa3J5eU9l?=
 =?utf-8?B?NERUNm9abWdpbWdtdzRUdUhwU3RwVnRKb0I0TXRPU1QwcndRZ0xUSWJUNENL?=
 =?utf-8?B?Z2RNci9KMFZ3bU1RMk9OcVVVMklBeGg4a3JNK1JjWVJ5MzVRc1hHZHgyeEZm?=
 =?utf-8?B?T1RvdU5NeXRvblZpSkJCSUhwVHRKWjNwTEZYT2w2WkwwUEVud3ZuTUZCMDFP?=
 =?utf-8?B?K1lyYWRWNzNabGUxNGVWVHVhaTVqZjlPZ3cveWYxNG1KR3hVMFF1WGdSY2U3?=
 =?utf-8?B?MzRJMzlXS2VGcDZwTjE4R3VOVGh0SFpsdy9BcE0xcGZhTTY0WFZWVC9pNHJZ?=
 =?utf-8?B?ZDI5SDY2ZDhUVS9aYzVFYkl0QU96VnFKRW1lV1ZyVlhvWm56bnFIN2c0blBx?=
 =?utf-8?B?SmFhQ1BtOVRHUlhRT1V5UlkrNXY4NEk1VENIVFRkQi9OVnpKc0lHdEgzVGdM?=
 =?utf-8?B?VUt5cys4Nm9XOFpHWkJDRU5hcENTcnI0N0VxSU5POXVWN0ZJdUkrL0lmQ3Y0?=
 =?utf-8?B?TUZpeHRJTzJzTUpZWERNa0x5dmc4ZUY5WHZVTlhnRG9FRFpuaFkyTzlRaTE1?=
 =?utf-8?B?NHYrRzk4Z2xKQm8xd2YwemozSjVmbnJIb1E5Wmk5b0RqSkhXbER0a1RuRnJK?=
 =?utf-8?B?TFozWjlzZXJQeWFBd2pzK0h0WmJLa0RZbWJ6NUdGN1RRNzBCeDZ6NUhQOWJx?=
 =?utf-8?B?T3dpT20yYThZcERyK2RnWnNIS25WRjJWWVVQc0FWQkFlQ0x3TE9LUT09?=
X-Exchange-RoutingPolicyChecked: akLYbkA/CNIUGnUnn82xqeUaWTIpGw1piBkfaJj/1kdpUrYalKlqdwgkmA7v1UDF3t8ML0k3mBW3WMslqUbO9rwAFpFqK8h1tEshQfsG9uSFRffVAXEOMSGL+2agdJ/rKA8toC6dSIkI7930QPi0ifn8xEOz/EMa5sdpDRhpt0llsFA8tOEvYVdct4rneHPbx8iJyspX6kzAWYOTmdBmnfvGlUcDIw0pjniSr8vR8b/jWcrELUbrFxdaTB+f6XtsSMNfRUL4KlHGYXD+W7WSMouxDzUsSiOoZIbPwm5eDss1Fs7oeMspfsb6NN+c9vMJMIWYksTX/xZtVjdlZxm/aA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zKJV62jyBY8506T7d756aJ5LBacOy/s8hflflQ6xr3xlRAjX7wa9G3HHq6WYEyYQzDuWgnheq3iM00olmg7qypeNrMqSamfoKPpIyA+3omPkK54W0FDAUB+7NjlYj0cvdyCioV4hulE2ZQnVYBv5kkeqHNTAjGdMzGs12WJQoklQUBGCTam1pqIjBX2o/hEU5V6UxaQH2/EsFsicWbhGe2C/MGHH6v9naPUY7go8JiDBSliQXMnJPubPQl3Bs7werze0TG9vhSMUigbZttT6tAivP+3qWSij7w3k+SUGjSgeg8bpcP17JHWwHwhfq2nXCYX6w23+UGT/vKT1OMOOp2o+5EFyqgQMaOEKxRbdsxfqy30u0gnaPxqQ3a0vgcRXt6IjtXuHvKddvg3G+ibL7a/O+lTS5q/b/3YQTlN2Q8HWiaUEB4lkdHyZnRthjZTdnXF7Dx3U2JJuwnMGwRn2umGNYZlyRc/2sSHZceSmBeMeOL5uQSA0NfHsPLQ1jUlj+eQ6gN7ay9Lc98KhtuH65blp2oK/yE3OwNBkbIdLIa8aPs1e2e2knABX6N/PzDZ+VidAtVmCt83RPepHuNCoBQZJo5Yqw4Mb8XUTvNAH0bQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4723f6-63fc-461f-979d-08deee3b1f97
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 13:04:43.5888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mddaaTSl6x1jq57TVSaRoXHmC9iKuTMAcZcgqPSbDS8PcnekhmHmIwPCTQpbhVsC4YaknaMR6b1ckR7vLffBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8228
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607300099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA5OSBTYWx0ZWRfX+FxryJI204id
 h4v677qMxnBj7tgkotim9KkKYqG4WonRcK9czcawvWyBgjKZndtfmmYY2hKQF46dUUY5QFfys1A
 /q8jwzfV0zEOStGogxQSOUf84Zyf1RJi/+ACbFVTpthc6T1VubAtsBVUiRLZseuPrnwVlrw5pv5
 ZYMciU/LfiRNd8iXdGcMbdqTYpfQGK2Gi0x+WCioyVVFY4SZUZj+zmRJsoidXfZqPzzu8YDenfQ
 dr4nMfxI1KL3LxOyJkWhLOeN9CrDmzulLOx6M6vA7EcGFMjX2tJie1crmlYLX86+Cch8yVE+tZ1
 LY1YG4Bo/MMRtWYpJJB3DMDEYZz2lhCIx55MVe70L2SO99Gz0xPtxRPObxGldGe/gQnxAIp0tSc
 YY1ffV2hdUeRO5c2xtiq9UA/+ZtwnvWwH7hkb703QC9c99pDkVLHXiYmg1DPik42EUtyqTH6pj3
 R8bOBAa8Mz3sYVQ99lOpC2hZRV/DRVTtdu0fUx6Q=
X-Proofpoint-GUID: hmdmCRBckVZpdc9vSNOZv7BUq2VC899U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA5OSBTYWx0ZWRfX+lJ1+zre4TbE
 H/3bpAk8NHzNCEQc4w39cgud9L0pixfhK7H/0UTpmv7nkopWyKCyDtkMB7uVvCIE8pSYe4+aVSA
 Jop7Kts0fJqjVMvdVosiPjL6zq7lM7zAM6ijNa0p2FHaGjFrAxiW
X-Authority-Analysis: v=2.4 cv=X/1i7mTe c=1 sm=1 tr=0 ts=6a6b4c30 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8
 a=cmKGhSr9MbhgzXbactMA:9 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22
 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13517
X-Proofpoint-ORIG-GUID: hmdmCRBckVZpdc9vSNOZv7BUq2VC899U
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_060609_685691_5FA5939F 
X-CRM114-Status: GOOD (  20.30  )
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

On 30/07/2026 12:40, Christoph Hellwig wrote:
> On Wed, Jul 29, 2026 at 06:22:35PM +0000, John Garry wrote:
>> From: John Garry <john.garry@linux.dev>
>> 
>> If an attempt to add the head disk in nvme_mpath_set_live() ->
>> device_add_disk() fails, then flag NVME_NSHEAD_DISK_LIVE is cleared and
>> we bail out.
>> 
>> However, we may later call nvme_mpath_set_live() -> device_add_disk() again
>> for another NS or from ANA updates for the same NS. This is broken, as we
>> should not retry adding the disk - it breaks the driver model.
>> 
>> Add a flag NVME_NSHEAD_DISK_BROKEN to stop this happening.
>> 
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>> I'm not happy with this solution, as we have a DOA disk and it would be
>> better to remove the NSes in this case. OTOH, this device_add_disk()
>> failure is very unlikely to happen, so we should not add a complex
>> solution to handle it.
> 
> Yeah.  Broken is a bit weird of a name for something that would
> either be a logic bug or a really messed up kernel, though.

NVME_NSHEAD_DISK_FAILED or NVME_NSHEAD_DISK_FAILED_ADD

> 
> I guess you arrive there by error injection?

I just bodged an error in device_add_disk(). btw, sashiko notified me 
about this issue elsewhere.


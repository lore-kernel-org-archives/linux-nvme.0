Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E577FC3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 09:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rzVo6uC8CJJoEUsNQ34akT/17VG65vW9d+UW6lFEKus=; b=k3JdVuRf+YryYHt+0XuQj2+j1g
	6yA/Vc8BTgKDjyI006S7Vw0U28WzzsvRF7/dkVHwtQlmGKqCFOfCfhe4s/BKXh2Dlrn6987gbrF9v
	Oi7QOy8fvLipgajcJ8IV6iTe6waQX26/aSWY12V0ITimN8Z9zg/P6v61hpQYWH2ep+Ami2jSneCwC
	jH4p8w3c6ZxZaEp386rEWjP5qfFfLjYeUl1cY8DCgQhdzwPD6w+CPsWvB5jazI2bVDaY1ig411BXS
	CNWnwTnpm02sUa5Rs+/qqw7NciJJqHneZyLLpyOa9vW3/sHjW3WYumCaXZfMuB8ooOgE3kpuBr45q
	SfF66IlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEmEq-0000000Bx87-095N;
	Tue, 13 May 2025 09:47:52 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEmCt-0000000BwnW-0W3y
	for linux-nvme@lists.infradead.org;
	Tue, 13 May 2025 09:45:52 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D1CFLP003203;
	Tue, 13 May 2025 09:45:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rzVo6uC8CJJoEUsNQ34akT/17VG65vW9d+UW6lFEKus=; b=
	eFaxdvXy34d67++tpa+Z60kO0NvEQZNGN8/wTbfn+g/cLOcYoFILMV01Z3E9HaQU
	cLJpplVUHAzJ7rX/R3QCu+JIJNAjIge4ZMvWSXPRF6Y+/tBh6OGLFXXSh5/xQTnF
	5X/5yR3PszbdW6GiYFbbqVGoX7865IRb08Nxa26HBSFzoiuIvtF79iypFcac/WoT
	VYeCW7NOc6WzCbBnasR2aOjIEYUv+AAIQEChP4iqpR1HW4J3DapbqUwu8cr7eVVG
	4DAvuM+eBAQa4qYVIpk7Jh2tlIK6x6jHKINe0sA3M5Serwhle6T1ebNOWBwJpfuW
	IJMpUte/TgLjtMiCdfjDkw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j059vebu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 09:45:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54D8Nuwf002569;
	Tue, 13 May 2025 09:45:38 GMT
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010006.outbound.protection.outlook.com [40.93.6.6])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46jwx4351j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 09:45:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCw6JfwY1fHW/GpNHhM+W8G3Smv1TF19Gd50nU8NmJkIjXsvuX+h2gAYIIkKXEHkSpwuk+vgr5DLv1P/2SXLM0kRJ5erI1rSx+lnWrNhsouswlU+slN2/2bzQA/Jjv5ChtJzk3s/kKzgqe1WWe6/kboqngFB7ZVUUO05iTREGjZ5kgHmX1M9O21XrS1VQmtD0+BXhEL4XTidlkNggQUsuRGlH9CqXAbI8APDgpvZjuEAw1IWihINRUO1wcwsI7r2tXNUTH7SUEm9XaaECfSNHz4Q4yBDmg2XTu5GZmCimPJxb2tB1qR0NGGwjlqZi3RwOjOpKmJe8CT4a2t4BXh5Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzVo6uC8CJJoEUsNQ34akT/17VG65vW9d+UW6lFEKus=;
 b=qJjp7rMoysy89HO91CIYU8Dl5tAkM8Yb77hlOPapJul/em1TnnyLvkXCt5/qWnPNOHE3HUJqOuKiTXiMzAkfZSeqgytVlcYmtcSwisezLPTosRjZ/jGE9t79r79D1xwO+iYvlktepUG+zyIptmVolH37J9IoM0eyO/UN/w8CP9e2ayigLhUevxpiRwvEfL18VqIzK22iuCHU/cGO786UcgojttwiM8Sp21ktDKqzgURqZF4it78vLPBnAeWnDfAonNhaYZj+xXVNxarL6hwS1pCa/g7ClzteXifJsOZBsyxrW0MAujLLZzlxPaLkVWpnKOFPa/aQRf/e7SQL3xOUKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzVo6uC8CJJoEUsNQ34akT/17VG65vW9d+UW6lFEKus=;
 b=L1VpA/4JQaP8CSw1EeoyTf6JDOYVb3vL0p9abNUEEv27uf/e9TMEREtdEiDOf7ydKBdzgIMdL2gmskbJ0Zv3I1Di2ZTs298Frv6bwO7833o1d2cVR+17e44MBhBGjhjTHITF3V+Hd+EXrtVpQrKgicxAwn9xziYabJhP8ZlhBnI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH4PR10MB8227.namprd10.prod.outlook.com (2603:10b6:610:1f6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Tue, 13 May
 2025 09:45:36 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%7]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 09:45:36 +0000
Message-ID: <9ae170fd-0f27-4da7-b475-61530b061c85@oracle.com>
Date: Tue, 13 May 2025 10:45:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] nvme: all namespaces in a subsystem must adhere to
 a common atomic write size
To: Alan Adamson <alan.adamson@oracle.com>, linux-nvme@lists.infradead.org
Cc: kch@nvidia.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
References: <20250508223802.277311-1-alan.adamson@oracle.com>
 <20250508223802.277311-3-alan.adamson@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250508223802.277311-3-alan.adamson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0316.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH4PR10MB8227:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa3546c-9249-4b48-f2a0-08dd9202e983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODFWU0dwTE51TTMxbldYS3lBZlJUaEtuNjk3TmN0b2FEakE5WVFjaUFoZ3lM?=
 =?utf-8?B?NmNmRUVhYmNQbVZjR2tPaFZ6UFliTkJ2cEcyK0dMZzQ0SFh1V2VXLzJVeHM2?=
 =?utf-8?B?R1gvcmFRYk9SL1BCdGoreU1nVHEwUUN5Rk05R3dWaGpob0s3bWVxdXdOeFpJ?=
 =?utf-8?B?dmQzQnVKSXhFRHEzcEhBei9wQnVxU2lyTS8xYWYyZDRMMFFnRU1FUHNMNFBX?=
 =?utf-8?B?V3gxYmZhWDNGbExaTVZSZ1lpN0xOdjF2N2g1TyszRXllZllNQXlHQ0U1NTRN?=
 =?utf-8?B?TDdqVjg1ZGt3MGs2ZGtnSGFpallyY2J5bHN0Y21hSnRweVkxV0ZydHQ2Yll2?=
 =?utf-8?B?ZllPNlBjbHQ5Nnl4dXV5cmRhdWNVemJPNWJrRW9wOTdPZDJIYU9CUjJ2a21P?=
 =?utf-8?B?S3I2SFlXeTRGN1ZheCtEL2UyU2Jmc0djZWwwYlZPbnBqR1BvOWswYkl5aWpM?=
 =?utf-8?B?c0VyK0hscGpjenpJcVpwT0RrUkRKak0ybVVkempjU2VCdEhIUzM0bHhRUUQ1?=
 =?utf-8?B?VGxVSHpsSnpleklyVmhQa0M3R05qNGRJZ1NiOVRwcVQ5OXJYZ1VoVVgwbFNU?=
 =?utf-8?B?SnNEY1RxWTRmN2JZSzdrcThLd1pPYmtUVVo5QjVoNXNtY2dGUU5SMkFiOG12?=
 =?utf-8?B?bEVMb2ZZeDg5UzJzZTNEYmp4TnNqS01sbmxJRVZVWExwS0ZOZjd6clZ0VkpV?=
 =?utf-8?B?UWpoVTlJbzI1cmRKdUFjcm9YTHBHcDZYemR0TXJ3L2dFN1MxaXJpeG1RV0N6?=
 =?utf-8?B?ak1IZEpZcVJudGRjT3dKamRSa2VhTEZwanVFUDU2aTlvYmhPa3h1WXA0djFF?=
 =?utf-8?B?VlN0aU0xUGtONXBDRWJNbjFiZTE5U1VpcWZlN2dpQzRhNjEzYWhNRkQvR2FR?=
 =?utf-8?B?QkdPaVhpR0l6S1pJVzB3TG8wMTJNTDV3d3R6Ukd3ek1GNXdxd1diVjFWb0lQ?=
 =?utf-8?B?bnFKOCtEYTRzVFdvWS9KYUZCK2dBWXJuUis2THgwWlJQNkIrVFpoY0JPTFlH?=
 =?utf-8?B?RHAzNFBtOG42bDlZRmtJaG1vUFIzNERLd0NuenlvSkFzZXBQcDUwTDEyb2Vw?=
 =?utf-8?B?R29BTXpTTW9PcmVadW0zdkoyN1gxdnhtajRvMzZJUStydkR5TWJOUnRQY1ZO?=
 =?utf-8?B?SndUaW9TbWdFbWxUdTdiUHBBR0gzNFJsMHZtV0JqTTkwOElKZXhPV1NlN2RY?=
 =?utf-8?B?UzYrVjdRSzVFMzZ5THF0UEJOUXJtMUZEcWtpSERGT3JoOFd0VE9nbzEvTEh3?=
 =?utf-8?B?S0FDRVczZFVTQTYxYXZBYjZYM2pzbHdhL01IUS9WcHhUdGtabk14M05EaWlT?=
 =?utf-8?B?SUlpVUNQR1dkYzArZXBDZ2UyV2hpa2NxRWVMNjdHa1lZU3BycXdGZzdHOHpH?=
 =?utf-8?B?VWRuc3VxaFN2L1l3M0s5MCtwSWw4SmJvMUpZRzMvQVF6UXdTeXVkUDBuUWhV?=
 =?utf-8?B?bnhYYWpoOUVuUEtBczVmWkNiSmlLYzk3WDU2OGZkN0RUUVVpNEhRM0NXOGlO?=
 =?utf-8?B?aWJQRWdmVWNyQ1pnc01iTEE2SXF1ZERmdVNmNENTSy9CVU1rRFFMWjhYV1Rq?=
 =?utf-8?B?eGpOczduS243SjNKN3pJQjFJYnNXZGcvVTZGQWtkd3F3M1EzWVMwWXJzOFl4?=
 =?utf-8?B?Tk9zR21vV2lqOFd6L0pnNmp6MlBMdEJWemROTnJEcyt4Rk9WZEhiM0Rscjky?=
 =?utf-8?B?Ull0aGo1T0FZWWhwQUhTS0VBK1gvWGw1QnlWa05BUzNvUjVJVzhVZUFBMkdS?=
 =?utf-8?B?QTRtRXp6MVFhMUZvRWQvQ1JSWThJbUlhelRtSTZiZ2dNSHQxajJlV0R1bEpJ?=
 =?utf-8?B?Q01MbzFRQXpRMWpUUlFqZVRvc2Y4bkdiQ2RpeG9NeGtvNTVSeDF4RWRuNGZt?=
 =?utf-8?B?OWxHVnpDODNaUFJhSEdqVDNlUHEwS29WTzZMUktuVkxkZllrZCsxc0R1ejk0?=
 =?utf-8?Q?nuhgF80w0IM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEV6K3llNS8rZks1UVZwSnBGeWZBYm8xRGlBUHBwVWc1TmxQYmlmU1RXUGhp?=
 =?utf-8?B?ck15T29wM3FyYUthNFpLUUtUQzRIK3FyaWp6VEJRNVJGTHZEMmkyVm8zR3dO?=
 =?utf-8?B?STEzQUtmK0tBN05VV05jQzlMUHpXTFhsbUduUWg1VmlDNDhyZFNXeEx0OGlm?=
 =?utf-8?B?TjBtekdDaTV0YnNiM1hoay9zbituZXQ1aE44bFp5eEtxa3ZSK1F1QkVpRjV6?=
 =?utf-8?B?K2lFOU9EdFhMM08zYzdpWkZjMnBGdkdLUVJKRUZaMU96MGd2dmVJVWdQbll0?=
 =?utf-8?B?VlJrL1ZOSmtQaVF5ZGhFZUJvRVYySFZnaWUyb0tQbGZ1QzZ6bUFWL1FRQ0sw?=
 =?utf-8?B?RGdxTzUwamgvWFF1bkxBYlAxMDFUa0Z3NkF4UFR6cTBEWHY2UFB6VnpCMzZD?=
 =?utf-8?B?bjU1TkRCTkJ6Z21ISHE1aVBaN2RVV3B0WXRDT0VrUU44VEtiUy9qZ3ZNRlBh?=
 =?utf-8?B?c2JHN2o5cHFXTHZUWmR2eCs5V0dyVWJhZDRmVWdBK3QvYW1BQjJUWFhpWWFU?=
 =?utf-8?B?Qkc2NnIrbU1kSVBOVldLZjcrNjQvcVFZQS9xSmp0TXU1cGlOaVJ2WUhUaDNj?=
 =?utf-8?B?eWdDbUQwSWpISldxSXZJN0plYWM3Z0I3Z1dZRmVpQmVoeDVUN1dXR05ENjlX?=
 =?utf-8?B?SkFJTERQOWM2cjliVFNsWnUydEVHYTFNSzJTS1U1N0Q5VWhOZXdORmtmYU9i?=
 =?utf-8?B?amJGZGpGUk5jdW1naEFvbU4yeVFLUG8xRXVVVTdHVXowZWZwSDRia215TmhJ?=
 =?utf-8?B?Mjd3VnZvajdYYWtKN1RBZ0tpOU9hWlpZZy9jZUNFZkNCMjZaeWluVllRWnFl?=
 =?utf-8?B?NWh1b0ZnaHEwVENOTE9aN1V1Z1ZVaytYck5LajZrekdWZWljd1o4SkVRVUdN?=
 =?utf-8?B?UXZHYXpTRlNTOEw2L0JEekFkMjlNZ0ljY0doc3B5RW5RZGdMWjJ6eGR1bjA5?=
 =?utf-8?B?SXlsMTFybFUxWTh5K0o2L0lZSFhyWDl1Tnh3TFkySDBZUExxTGRQRXlvY2RM?=
 =?utf-8?B?TVZhTVFXRzREdlBkV1dLQVlPWUhkMExDOUZrVVE4S0c3OHhkaTZ4aTJlMWZa?=
 =?utf-8?B?SGxKbXMxK1pSZjdBWlkvaFJUUVpTcjVZcFVjZjZDVDk5ckcvaWp5WFRoV1pT?=
 =?utf-8?B?ZDc4ejM5czBxTWFya21yTEhjVDB1ZzRpMzNEWnFEYUxlbldQWUJ5RVlXOWVT?=
 =?utf-8?B?S2R6L2xQRHZncTZ3MTZzSTM4UTBrTkp6Tmc2SEtPbUNDT3ZJMGRkR2JKZFJn?=
 =?utf-8?B?a3l1TmVscnF5dWFIbUhvWmdEOVpxa2t6dGZmbFYycXZCYUxvTkk3MFdkMUJP?=
 =?utf-8?B?SzdldjNyTWQvYnp3ejQwdzBhelVGK1hrTERkS0Foc2d4aTZjdVBjbnQvQkcr?=
 =?utf-8?B?VGNaQ3NQQURHZjIwdHlhMlJMeTZOR2d5S2VLYjNac3FkTDNYQmFITE94TGpl?=
 =?utf-8?B?enMvN1pBRUNiRTZaeWhUVW1XV2wvNTB3eG1KcjNSN2xjS2c5eHk1eDlhaEJj?=
 =?utf-8?B?YlRIVHh0ZUpRNGxzVkN0dkc2dm13Z0tzS1gyYUJmNzFvUno0a1pLTnRRMEtr?=
 =?utf-8?B?ZE9JVzJjZWt5MUdHTkpxT29CVklMZDVINTVOaEl4am55RUpZeUlNTTZydnRj?=
 =?utf-8?B?ZytFUmVyWTE1a0RSMTE1MVZHc3NlYURUakxVNm54RURkSTlDdnlLb2FvQmc2?=
 =?utf-8?B?WHFCUG1ZN25md0xEdFRmREMwOWlYT1RKb2JMSTBvWWdERUNyL29Zc3NNSWQ1?=
 =?utf-8?B?WDNPTy9JMit1cmNvS04wazJVemJ5b21pQjBZSkdPb000allYQllTeWpEV3k3?=
 =?utf-8?B?M3dON1h3M2JZRkxRY3BDZjFYV0NUd2lzZnQwbnJRaUpwL3JZU2pncW5sUDhW?=
 =?utf-8?B?eXZLWkt0MVJXSFordG5BT0ErMnJwTkoyREdKb2Y1Ty9GbWlHWUtkTlc3UHVR?=
 =?utf-8?B?MWdzaldQVUhxejZhL21Oc3VFSEh5anl0V2hBWm1uNHFUdHdtMVkyT0dwaEVW?=
 =?utf-8?B?UEVNQi9BbkVteWpGNlRvVkVibnEzeEduRjlyazdsL2RKK3NUYURVTm8yT1lH?=
 =?utf-8?B?KzZ3MlNNdjB4Y3ZRL0c0Yk8vY3VNZUUwMUtkazVKb1hkTkluU0JpbkZ2RFhH?=
 =?utf-8?B?YW1ETnZpL0Q5cFdzam0zbldmaXN3S3FBVk13TG5QUFVHYi8wM3A5VFJFbkJH?=
 =?utf-8?B?SVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NAnuvEdBZ1CaRyY25ZJQlmSCKr+0/iNKG+yq3I028QVPwdnDsaOJ5FXIx2Dc/ezo6hQ4AjHAYmF//jZeNe8uNcM6qLsqb1Vgx0VybYC00Gxudu0o1B6dOqrKn2Dmh9qbTgFGNv4pAAOdsmgDSqhvv175uu0qOJcPMDgS0cHIW3hcrFMEnvacsTJzVnNkyJvXTNQn2hDrCe/1pmv62cF6H/5+CkwdN1Yti1GIUn8b01FZobk99pZEvgtvveUIbbRbcbPtWODbwNj+tCtBw1W5Y01hn2Y5B9kxu4yuOV4gAd7D9CpE/L3Q1RvaWZYI5M39B8Os3uT4MwD+IxBkyAdjD+yRuysn+k5f1PR3aLWYBtpcHmSJXGPljVE9QGRrhitZrBqf2jQpIMC4gf8G2tGoVzFODUWaOnZ9/A8Wc/V9mO9SVtibVq4AVGkZ26L4qIJUVeqIs7HjUkiRCDOYd8r3DP8OfPxbBk5aEgMxK1ba8FM3yCTuB/m/Ey5aKCLJeVAyrihaLzDAuaEAH69W56HiwKNU/r/4PQvKjMR2SHEpyDLHgyuNRW5MMXczXgLOu9R6eQ4gCBE9CLT6WfxwPCcTtoM+ob7Wk7avT5Km66y3lBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa3546c-9249-4b48-f2a0-08dd9202e983
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 09:45:36.3344
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2EnU9N895Z0V0nnFgUbb1FC4HKuKbg4NFAki1JKK/INgEarRDTCnlOUUrCUfFoGZcHnsWSy154D5q0cD9myUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8227
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505130092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA5MiBTYWx0ZWRfX1gv5FB7S3lUN zEjnrteTpYjqyHwpfDgAR9YGscNQ+Qx37gg7mqMZwc+f7kH2JkRLJi/jO5aP0bdKhu/9imTYjgo HPCFkcXp+JKOWWcG055I9zeeiL8+QkvY6lNVYcQT9SyIg0NC6k5uzJQRr/ZtLvLKW3q9bRzQfkh
 wupaeJmk6My3GolbNKwa+rQnjJ7L7RUtEyN3VRPh5C/nka6DD3fuEhBx5yVOgpWg2knedoOZRXz LdSRwnd3foUbqRHqLlwU8uXJRk1zJ8efgzJ2gDKIx9ugviZKPCZMBfbNZOBgu82E/2n57lrf/F5 nVy8qB2Kw/QYcObAEtdOg0B0tMA49Jh3VD4A7x5pY831ODShYhy3qjPqo+cYlzwgvx7UnmxJFAW
 s8uuTy0ar2Xo6tqoU6elLW0huYV2E1QTmZZkm4xs5xfjXiguLeLb64YtPdjwB+W+Tqr4wpQl
X-Authority-Analysis: v=2.4 cv=RPmzH5i+ c=1 sm=1 tr=0 ts=682314c3 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=NmlyDIBZ9pTxGXiVVcMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: QxStTdTqrQ3YaJUte1QQV8r9no_D7DeE
X-Proofpoint-GUID: QxStTdTqrQ3YaJUte1QQV8r9no_D7DeE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250513_024551_198038_5D682B92 
X-CRM114-Status: GOOD (  23.38  )
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

On 08/05/2025 23:38, Alan Adamson wrote:

Sorry for slow response. Generally I think that this is ok, but some 
minor comments below. I might be off the mark with some of them.

> The first namespace configured in a subsystem sets the subsystem's
> atomic write size based on its AWUPF or NAWUPF. Subsequent namespaces
> must have an atomic write size (per their AWUPF or NAWUPF) less than or
> equal to the subsystem's atomic write size, or their probing will be
> rejected.
> 
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> ---
>   drivers/nvme/host/core.c | 29 ++++++++++++++++++++++++++---
>   drivers/nvme/host/nvme.h |  3 ++-
>   2 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index eb6ea8acb3cc..f34cf69fab8d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2059,7 +2059,20 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
>   		if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf)
>   			atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
>   		else
> -			atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
> +			atomic_bs = (1 + ns->ctrl->awupf) * bs;
> +
> +		/*
> +		 * Set subsystem atomic bs.
> +		 */
> +		if (ns->ctrl->subsys->atomic_bs) {
> +			if (atomic_bs > ns->ctrl->subsys->atomic_bs) {

I am not sure why use > and not !=

> +				pr_err_ratelimited(

could dev_err() be used?

"%s: Inconsistent Atomic Write Size,

we could mention that this is the powerfail atomic size, and not 
"normal". But I suppose that we don't use "normal" values anywhere, so 
it could be assumed.

> Namespace will not be added: Subsystem=%d bytes, Controller/Namespace=%d bytes\n",
> +					ns->disk ? ns->disk->disk_name : "?",
> +					ns->ctrl->subsys->atomic_bs,
> +					atomic_bs);
> +			}
> +		} else
> +			ns->ctrl->subsys->atomic_bs = atomic_bs;
>   
>   		nvme_update_atomic_write_disk_info(ns, id, lim, bs, atomic_bs);
>   	}
> @@ -2201,6 +2214,17 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>   	nvme_set_chunk_sectors(ns, id, &lim);
>   	if (!nvme_update_disk_info(ns, id, &lim))
>   		capacity = 0;
> +
> +	/*
> +	 * Validate the max atomic write size fits within the subsystem's
> +	 * atomic write capabilities.
> +	 */
> +	if (lim.atomic_write_hw_max > ns->ctrl->subsys->atomic_bs) {
 > +		blk_mq_unfreeze_queue(ns->disk->queue, memflags);> +		ret = -ENXIO;
> +		goto out;
> +	}
> +
>   	nvme_config_discard(ns, &lim);
>   	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
>   	    ns->head->ids.csi == NVME_CSI_ZNS)
> @@ -3031,7 +3055,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   		kfree(subsys);
>   		return -EINVAL;
>   	}
> -	subsys->awupf = le16_to_cpu(id->awupf);
>   	nvme_mpath_default_iopolicy(subsys);
>   
>   	subsys->dev.class = &nvme_subsys_class;
> @@ -3441,7 +3464,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>   		dev_pm_qos_expose_latency_tolerance(ctrl->device);
>   	else if (!ctrl->apst_enabled && prev_apst_enabled)
>   		dev_pm_qos_hide_latency_tolerance(ctrl->device);
> -
> +	ctrl->awupf = le16_to_cpu(id->awupf);
>   out_free:
>   	kfree(id);
>   	return ret;
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 51e078642127..ff1d94468613 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -410,6 +410,7 @@ struct nvme_ctrl {
>   
>   	enum nvme_ctrl_type cntrltype;
>   	enum nvme_dctype dctype;
> +	u16 awupf;

was it intentional to lose the " 0's based awupf value" comment?

>   };
>   
>   static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
> @@ -442,11 +443,11 @@ struct nvme_subsystem {
>   	u8			cmic;
>   	enum nvme_subsys_type	subtype;
>   	u16			vendor_id;
> -	u16			awupf;	/* 0's based awupf value. */
>   	struct ida		ns_ida;
>   #ifdef CONFIG_NVME_MULTIPATH
>   	enum nvme_iopolicy	iopolicy;
>   #endif
> +	u32			atomic_bs;
>   };
>   
>   /*



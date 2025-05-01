Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D51C3ABA3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 May 2025 06:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:From:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JKb4/w1Dlf6ZSbgCmish9xlWq29BICLZovNt9kESMqw=; b=Y6uZ4nEqS11MOlsTTKxc3hsCDg
	iQjkvmqqI+06nGpgShwDw+ybuB16sGGfc6P9GSGnd4jJJ9z9X/w4gBOi8gkn+yqLJDN6dvbDpCxdL
	0spdJjoXeWoh7ICdVxlBb+RmFWEFBcW+n6EFZf1jpizrRz2DVN0ebx9ZmDLs9zeWHtWWvSIkg8B3W
	D5dS6Wd0DYZyceUpyqC1cuq8jgCCgYpF/PNnHNtgZBCoY+udBPBrBQcUgSnuOBudpmZxTp2ODSrAQ
	66rvNYV6XMtnyTD9pDKe3IvqiPSidfGFy6KS7m8Mi//vSo0dZKYwaCJrz8S0mCeun+tGmwEDHPDsJ
	tEcz/0VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAN4e-0000000EonA-48Ms;
	Thu, 01 May 2025 06:07:08 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAN4c-0000000Eomc-2zHm
	for linux-nvme@lists.infradead.org;
	Thu, 01 May 2025 06:07:08 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UKwXHl002717;
	Thu, 1 May 2025 06:06:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=JKb4/w1Dlf6ZSbgCmish9xlWq29BICLZovNt9kESMqw=; b=
	ls4GUOJGal/otqHPPVU16+oX610dC9nZwJFYT7LJHsSoFiIGvbJuMv9xQdJx1nR4
	YkEE28pMsIeewi3WTgN1xWiQfdbrWAhHdF0h4sonuO/oZ1qB75SF6+vcf5ylZEDN
	rTsipdI99r4vbqlRDkNcDBJ5wxtKIuC+YpQtfmFXBaJUyDn+RmXJB5qJYzre49DI
	oW53RgrowSu4OVzbiwegsW7TLC5kaUuVeNpDwVY86YuRYm3ob30GcUL/GU4W/KFl
	92zzmswBvLAp/veal9C+IuRznem31KcYyFpuAQtr2GpvY7Zuf44Wi4YWdHJrrzbp
	1AbqT130lKTW1IZK+FD2ig==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6ukjj5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 06:06:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5414cwEj011323;
	Thu, 1 May 2025 06:06:57 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010022.outbound.protection.outlook.com [40.93.12.22])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxcrk1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 06:06:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MQwxMgHiBejW5LeovkQRtMFAsPo/fJLui9LupOjgGlaBJGbV+t6xpKAjgtDEWG/reWkZ6ICJfX26WWPzzcPwoxvrc9wOlEmgjjRPVXUi7C+GY8Id3ASbr1c5xO1fG7xrk4lwh/UhSmplMulXkBLc3CkeaJZymprzRkUedhc9z1FpDI+CaCzS0lXy+vDp1nKcaFfhc0aJeQIprPfIF4katx/sUv5i3SHjD0zaFQmXoKW0heJKNpwttlDECUAQKbyJOoIgMIWkfm4avM4FBPgsvtZgyGEBEDVHfkEEFNDJfWK4h4mZ7ofiFqmUUELntitSTPFvS66L+mvJQufG+QjH4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKb4/w1Dlf6ZSbgCmish9xlWq29BICLZovNt9kESMqw=;
 b=Rpdnxjl4yFWxKcFAI6pD2dGbb2LFMjT8A/UcTbgzgHG3QrfO78tQO4S0Ql/+s1K8c57HsSJdxtDoI96Q8gplxXKcK5Wz0VrpebiHFWwqo+JbDTV/WbYt5nwQ6c9GlZ1xPEekZgFrZlQzmuQ0hRFt6ybmQ736Kah84+zBJX95T/qZUR7ww+wI4gKpNVeW0le7OaPTZj6wkE0MCdcu06/dR5oytc2KqpaAUrG9zOt91yvDiQag2hY22uA+S8XqEQjMbsL1mgrq35KaR+V7D3I0Zb7phNDJoz7FhWqqWzhuLmaBOWJKUXuOrStHIoeDROgpMOSWK1gymo9b1YU7xVE0fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKb4/w1Dlf6ZSbgCmish9xlWq29BICLZovNt9kESMqw=;
 b=UH9UXoJ/9Xn4FFpGqpA3Eg3z4+kmLijZRqvQ/+OeuK7YGSin20o3mFG0t9w3QjuDFOovk4L4sUYUsAGZPzbojfcIp2Bzg5vZ01bAeQkLJhBienBi1ock4ARjhkum449NGNz1gEPHR1YHZA2FAeGnZtLVtnMwECkeeAlBQCMNMBM=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by DM4PR10MB5966.namprd10.prod.outlook.com (2603:10b6:8:b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 1 May
 2025 06:06:54 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8699.019; Thu, 1 May 2025
 06:06:54 +0000
Message-ID: <99476f1a-bef8-41b0-80fd-6cc602ba32d6@oracle.com>
Date: Thu, 1 May 2025 07:06:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: multipath: atomic queue limits need to be
 inherited
From: John Garry <john.g.garry@oracle.com>
To: Alan Adamson <alan.adamson@oracle.com>, linux-nvme@lists.infradead.org
Cc: kch@nvidia.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
References: <20250430171830.1494033-1-alan.adamson@oracle.com>
 <20250430171830.1494033-2-alan.adamson@oracle.com>
 <55366449-8011-42eb-8b20-fdff02c15eda@oracle.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <55366449-8011-42eb-8b20-fdff02c15eda@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0163.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::31) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|DM4PR10MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: f21bb545-5b32-4ff4-68f2-08dd88765f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0xDd3E1aXYySWRUSkdTeUdMOEVISy95TElUSk9RQVVBRDAyejM0Vit3aFcx?=
 =?utf-8?B?MWFFZUF4NjFQQkZ6NHU5d2N3dUYwZFIzT01OTTBXQjhFeG4rS0hTWmJyMFlm?=
 =?utf-8?B?S1A3VVB5dzNKazU0YVF1dk1jV29oc0hYU3BFSksvNEtHNE82SkRPWXNXTWJw?=
 =?utf-8?B?ei9KZTJiaFB0R2FsdlViUFh6d0hlRUFvQTRlZWV4dDVnL0wzOG11VGdQMlpL?=
 =?utf-8?B?WVhRbjJPNXIxUmJKZXVmMEpCWUxuZDFBZElGL3E3a3FhaW9WL1ZjVk4vdjNN?=
 =?utf-8?B?M3NIV3liNGlSOGFQSnhOVGcyc0NrTzhrTVBRL1puQXRzakhXWExmQ29Sc0tR?=
 =?utf-8?B?UGUrV2owR3pjczRhOFA0aE1LZmhCbHhBUGN3a3BSekY2MVpod3I0a3R1ZDhD?=
 =?utf-8?B?NlE3N0NtYnA4c0htbzVhU3FWcTM0Tk1JSUUwTEZlcC9OUGhXVXFqaE5RczNs?=
 =?utf-8?B?OUlib21rOUZCZU1mSFE5bDlObnBFc3h2ZUU0ODhlaU5MV1NlT0JJYVIzK0Vv?=
 =?utf-8?B?ME91bTBIWGNESFhwdThWb2pRU1BJOHlsZUZxczROZXBXSWx3eXRxbm53Q3U4?=
 =?utf-8?B?bndKMGlydlJEb0ZjaWNWU0M0YkxXM0RDdmRFQnhHN3h0Q1VKL2ZvTnNoMVE2?=
 =?utf-8?B?Lyt0Wm1pVnU5eCtoMnpaYko0NXN2eWRLL2xZWlNHZnR0bnRrTXlaYlg1b0VJ?=
 =?utf-8?B?VytnM1RTMnU4eHJzdFc4T0pnUEduY1ljZis3UXdEQUNsSnd2QTNrRzZmcmty?=
 =?utf-8?B?aE04QUR4aGVrMW1pZXgvbFBhSnNnanY5SkN2WUtISmxpL0hOZFZvbjczdDIx?=
 =?utf-8?B?S0RQSVpiNjFZckE5Ynh0ZVRDczJXVHMxdkNHMkxVZGNrVlpBM05UbXVTMDJw?=
 =?utf-8?B?VkdNSzhkTmRvdjY4a05Renpha0hHY0RPeS8rZW9kTHc4L21SUnl3RHlwbEV0?=
 =?utf-8?B?ZGNqVkJWRmFnMVhCcDI5c2FnbEZIY0lDWUU5NjJhcm0yUEJwMXJJN3FiSFc4?=
 =?utf-8?B?N09Pa0ttR1JORlhUdzRjaEFnRjJaRG9HTXMwVWlScGtyQ095bnJDQzlnRUlq?=
 =?utf-8?B?Tm54SHJHcnFXREFUdzdKSTNYZUxZOUFCNDRIMGMya2xTSWlrTTR6cm9tSk03?=
 =?utf-8?B?bS9qRkdqN3VYWmQ1ejU2aTROVmE4RlFGRDAwNmo4RjZza3NlMVZLUHEvMjBE?=
 =?utf-8?B?VXQ0SDJlNEQvZDQ4VFhKRFFOOTdmbjlQekNvR09sUFdvT0V4TURmZ2RoUEtr?=
 =?utf-8?B?YUdDcEtmN2dJU05MVnpxNTgraWp5cCtyWWhWUmV0d05QdzZDN1RFR2V0L2dW?=
 =?utf-8?B?d0FVRFhmMVZTeFMvOFJMWnh6d1JWNzdKc0VMc3pRNlRVcTNEbUF5QTdOK093?=
 =?utf-8?B?dVhZcnN4OWVOMmJSQzlDZlQ1Ujc0RmplcHpTUmVFa3k5YnhpM2dEdGxHdGhz?=
 =?utf-8?B?R0FsbFQ3M0xSUS95VnRRbDdwN2VKNy9oUXlnTGh2aG5MRnJpTHI4c3BDZnph?=
 =?utf-8?B?WVVZc1FPTnlTVGhFV1dFc3pxWU90aURhMm5rRkRUTURmWjd0WmtMa0FBNlhN?=
 =?utf-8?B?cFQ3NHcyck51MkIwcm1sZ0l2YzZ6TkFRditiOTZHa3U0YzJyYjdOL1hqVVRR?=
 =?utf-8?B?Ni9FNjNSaWo2SmZlQVRGTm5ST0RiVjBvelBwS012RXcxR2JwNEw4RjhqVlZ2?=
 =?utf-8?B?blVsdEhUUXBpL3dYeld1VGJIYncvNjJxNVpPTnpNeHk3WkpsWXIxZ1V5WUds?=
 =?utf-8?B?czRJbFZiOGpTelQ4YTZNaEsrb0JiZ0x5c3l0bWU4UkJhdXpzOW9aVTFuS0lj?=
 =?utf-8?B?ekRDNFN3L1VSdGdCQmVBMENzS1IyYy9vOG5BV2JXYlpDZTYyOUVrMWhqdmZz?=
 =?utf-8?B?cy9VeDJSZXNpUVp0bk92M0VWd2toNTBKZ3hhV3JuaG1Db2c9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGFvWDk4R1RaWlpYUi9GWXNENXFRbFl2dUFPUVlhSFg1S2hMNXRqcTg5L0JI?=
 =?utf-8?B?L3FjQlJpaVl3MzdYK3JvYjFVMy8xdVViNlduYzREUWpRQ0Z3QzZXRFpHZzhH?=
 =?utf-8?B?M2U5TGVaNitMWnZQaitNSTQ3UlUwNXJOYjl6dkpXUVdKcS9uYmRObVpFN2t4?=
 =?utf-8?B?UytOYzFVWlF0NjlQUFlRMUVVekVwM0ZXTEZoWVJXNENYd0N1UENNbi9KcGpP?=
 =?utf-8?B?NkpsRlRqTlhvc2pBSjZJSlFiK3hzZEszZzBlQ29saVBET3ZIbk1iVU5sZ3BP?=
 =?utf-8?B?OGxzQWJDN24yUkNMQmFiSEUrN1RDbURUN1FEMExnNFNxZW5VK1FET3Z1bGt6?=
 =?utf-8?B?SlhnaktnS000TFh2VE9iTU9mYTFkQjJXdGZqcDFLVjRlem1pUk5mZ1dYZ3B4?=
 =?utf-8?B?VGlVNXJmbUFWY1FpWHdxQ2xxMGFVSlBZU3doY2FzbGJ1eFZEc28vSFdBNWtz?=
 =?utf-8?B?LzVYTVlXZzUxdFJtUUhqSXBXemdGZklKenBSL2kzVTdjWHlHZmRzWnJzTVlm?=
 =?utf-8?B?SzJkbzlPaDF6VVlCMzV6VFh6bGR1N1crSDJ6bTNWbGQ3MmFGeFVIUFlraEpa?=
 =?utf-8?B?d3N2UEVZU011TUNMRlV6UU9ScHdHZzBZNmNJU0p6SFlnSW52NWZ4azBNL3dW?=
 =?utf-8?B?dWVKL3Q1NzlVaU5xa2lkL05HaC9Qd0NtTUpVNENxNytZK1g4VXBOeC9hZndD?=
 =?utf-8?B?Q1RnTUFBRHV3cnQ2L0g3UEJMT0duM1FOdXRidmpXbTE0Q215UzRWM0krYU52?=
 =?utf-8?B?RjFOU3JiQXBmU2k3MENXekJ0YW9sajlDbHM1bDZYelMzOTVaMDE3TnUzM3Er?=
 =?utf-8?B?VjA1V2RleWtmVDBDRlNvUG1LTGZCVUVBR0pmaGRCRUZBOGowU0ptaWh0bHRG?=
 =?utf-8?B?RFJHdXhGRjRWL2trTHRPMzhMNTUvMlF2MUFrVURRYUVtUHRQaXZHVVN3c0Za?=
 =?utf-8?B?b2ZLSDVZZ1laNTF1QUs4QWRKTnRWaFI5eW94WnRjQys5UVlZYVFwczVpdjJq?=
 =?utf-8?B?S0tuV2UrdWdXcEpaUHhNOE1zR2l4WkFvbDdjVE5GU29DLy9DOGJtVGlrbFcy?=
 =?utf-8?B?a1dVVGUxTHFXVUozODA2Zm1ianFoamFmQytzTElaYUdoVlFvN09OTW5SQVo4?=
 =?utf-8?B?cnBMWGhhS1laM3hYK1pHWXVEK1R1cWVRdGcvQ0ovb1AvWlN2Yk93ZFZrRHE0?=
 =?utf-8?B?NlNVRi9sY2NCNXdmMUJ3ZjZBRk02MTRpalgvME1RQktJZjBoeGdCMTZhcE1Z?=
 =?utf-8?B?RUk1OGFrRjQvT2hjQ1NkOTlmeTliNkNxM2xQZ2JGYnRNSDlieW5hd05BclRM?=
 =?utf-8?B?OS9JbUN2NXlqSEJDd2l4ajROTWxVV3ZwNDdwbmMrbmV4dWlZVDFocVlNcW1S?=
 =?utf-8?B?Tmgrd2ZhY0p5Z0dXdW9XMjdjQVVtcDhZUE5EbXl2eVFuUzVmT0cyRzZpdzFo?=
 =?utf-8?B?QlFvWTN2RElmNHgzR2ZtWUFHbktYRGlMNHhQVnFaSFVrRDR1cnJPVG5za2sx?=
 =?utf-8?B?ZlhNT1RCTkNzZlNvbE5OUS9EV2dSTXF5eU5GaWtUSEFLYm9LMDludXl0ekZ6?=
 =?utf-8?B?TVh1Nno3bTMwUS95V0txT1k0TC82enBGa0tMUnZQNkhhRVM4Z20zdWJFRXd2?=
 =?utf-8?B?OHlNTXpTWG42cERMTEZramlqNGswempKdzd6cStOM0dHaHZqUXRFeHZMZzRj?=
 =?utf-8?B?TUlDd1NVZUhvQys2OTE2bVVSOHZ4bmE2ZTk1bjBmYURpM3ZzRUlGdmNORGtV?=
 =?utf-8?B?SHRGUXFyTHgyK0ZkbGpuajFCOTdLcHJmQ1hVbUVadTRDSmxmUUszejBuenlm?=
 =?utf-8?B?UGtPcXFxelVjdnhJSDV2UmdYY3BKc2ZTUFQwVDU1UzhiYUE5b2dINmlETmFJ?=
 =?utf-8?B?b3VwelVrVnlma2JyakJaQlZiUFhhVjVGTllWQmcyWllObk5veEJYNzBVLzJ5?=
 =?utf-8?B?dHBrMSs0YnZ5SzcxWmtrdDFmZzBVcG8wVythNHVCaWRJaDAzb2NpVlBhc29l?=
 =?utf-8?B?ZW8vUFFRRG43WmdvaTFhenJrNGdRWXFRWlBPcFJxSXRlTFJBNEhYcVNCdGNQ?=
 =?utf-8?B?VzdPbFJjTjlkUm1RV3ZFK3F1OHMvU2MvMFUxUk1KY1NCWWpuU2x0QWk1OVFD?=
 =?utf-8?B?QUVvR1VKYzgrSWFVcUplelVKckhDOXhwTGVzbnprYlBrd0U4VThGUE00dVJr?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3KVzLaknrRVQgl5vEMk4bufVZrsoCMOFi+D1kpc/lTIuHDQoGx/yFzfr4D4jOtdd558LfeUVRyPGhk1PH+zYh6p9Gom82ajtMxoyNBkTwNHGP7Fx3deySEccH6ZT92wus+7sQBg0zIgg2XyLcIrjrQbEonXE+IGHVAFJS58sL4hA5/jA7UuNzIecxcgcGujPU5fvF4m27HkDp72PIhVtvjcBLSu21j6pJIuQhS9i6Lzt8RXJpKhcKpEnlQmKIcsg7YcWu2lon+dwL0xx6O3BF1QXriEwECTNMPFvtDDln1PUGu5uqRwDZZL8QefOO3UPFFTZrYArkKOMLef/kiRuXTzsqUbvTDujrYkyIsYuOFLGy/7zrWc9gUquCyRS8eSnA0kAK8PmeMzG+Tpme3oCRd/ep/1VQgZ+XxYrSiDMaYhDmLFf3n8FqAcVNu6TqRfGyrheDTvYTfyK488+wzeuLMjH6Mq6PscZwdISVTKJubE6p/b8zi/KBWF/st9Xc5TCpnuMaemDkkS/nnHCo5ZoWUxEN5HN+djF99QuIu7mxFx0/gXHisZLh70Tf2yMZUZbw7hbJu5hyeFuli0T8Wdm+SfWlOtb9eFkA2Ya57etxVU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21bb545-5b32-4ff4-68f2-08dd88765f25
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 06:06:54.2512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mLtd0a1Q0C0xVSwgM28+Zvuu7Rs8E/BoOAXk1Ji4FjpDv4T80aHdstgaEBCmV4FafDivP9dR5Du3WzHW9wyLkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010044
X-Authority-Analysis: v=2.4 cv=MIZgmNZl c=1 sm=1 tr=0 ts=68130f82 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=uen1oHpksaofgR2VFYAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ae5YLGi9VBZwk5RTU0yH8tOYq6JeQIEd
X-Proofpoint-ORIG-GUID: ae5YLGi9VBZwk5RTU0yH8tOYq6JeQIEd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA0NCBTYWx0ZWRfX/oJOlMXvnpk3 pw5eOP9ab50HnOsBxEU+ivkmKzz+PNfiO11mD3zIQ6UWUXqIu7Jr9AuPZJTmue7EQbZLkA1RvAP B5CoMvdeVhFaCsMvb2iRt/q2cmAjM0mVssgX/OgqKV/Q9+EQD0lOh4UuxC/KE6i8Zqk6vev6dAa
 I1S1fJWLA/uRv+FYaIfHki8H/PGAJj9YTgJD/dP9XkBE98Ap/L9aWqv3/LJFsqZ2nZVR0wWaao4 spgtMPrgdn73fXZxR5a6Mfae1F5aVN9cwRYesfT10qO8iwmLfBBgZ85KWPJiTzD3KJgOP5qU2HH nQhh4HJa3P/9DU6IC+eGErAScpKjfObUY4qxai1yWgaLQHYGE0l3KHfNgltj+tdXk/RPTG+7rkE
 4H5tmjGnUygwUxse72HUfXIzm18PaEcyNn5CJKyXfgzxvUq0MR4HL9Jxip1xYisa9r0aUhZK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_230706_887285_D59527E2 
X-CRM114-Status: GOOD (  15.54  )
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

On 01/05/2025 06:47, John Garry wrote:
> When a controller is attached that has the CMIC.MCTRS bit set, it indicates
> the subsystem supports multiple controllers and it is possible a namespace
> can be shared between those multiple controllers in a multipathed
> configuration.
> 
> When a namespace of a CMIC.MCTRS enabled subsystem is allocated, a
> multipath node is created.  The queue limits for this node are inherited
> from the namespace being allocated. When inheriting queue limits, the
> features being inherited need to be specified. The atomic write feature
> (BLK_FEAT_ATOMIC_WRITES) was not specified so the atomic queue limits
> were not inherited by the multipath disk node which resulted in the sysfs
> atomic write attributes being zeroed. The fix is to include
> BLK_FEAT_ATOMIC_WRITES in the list of features to be inherited.

BTW, I think that it is worth repeating that latest QEMU has CMIC 
enabled for MP, so we can't use atomic writes without this change. But I 
doubt whether QEMU should enable this always.


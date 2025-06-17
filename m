Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86890C71157
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jun 2025 07:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zVKu5MfKBxYWKh07JTdEPUvTaEaMsMMb2+7hIA+TgU4=; b=EWXfUwUF7UgugwwLkTbLTAWTdD
	L7oQJARoXCWaNly7T50btaaz1b8+qsbiZscHuk/vLC7Y7lwOr1mP63gkIpf1FngCYkLtgNW/2oTCm
	y3UnTwynqlBSUo7Qs3sp/JaF/+7QiIODEZLu3vWGGqFgsEuUf/osO/rqin/obfuWHf3cbq8s4v3MV
	psilb90SOm3C+HGHrpSo8qTZe1L3LzgOQIG0SwHJ982Ss6xlZxcys9TyN62d0PsEeLESPHLGF8LKt
	TNAgJjkL9SXTHfis9FWrhZiTCvpibUGkwUSqtV47ZSt+au62BRNT25/xG+4f+cnkIEgVyoU7UECHB
	Dobo2Z9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRQsG-00000006Tey-3z9t;
	Tue, 17 Jun 2025 07:36:52 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRQsE-00000006TeL-1vCP
	for linux-nvme@lists.infradead.org;
	Tue, 17 Jun 2025 07:36:51 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55H7BYNM006130;
	Tue, 17 Jun 2025 07:36:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zVKu5MfKBxYWKh07JTdEPUvTaEaMsMMb2+7hIA+TgU4=; b=
	Mm5sqsRmRUDvq3ftDHQGkjvLlj5C9DEg0KSr4rnkXuC+aFNMkUtaDKYw1f5SMEPl
	O8g7X5bun7TGM1vjMDIjh972CCh1IuogNYepdTXysb6hLv7d4LJLJHR3lzyoyliV
	RRr5P2vhyP9YJnnGeZaNsZdYyHQ736nAHnWpgcD1fCY3oDZq8/MLWURl7otCBv0b
	RrRW7QvrOYG0k6qjircowcRxrFzmn196U3ioNdSpte1OO8dHYgOViRX+8kcp8gqn
	UqTEQVJ5Wh8AHBfj1cLAs5MHfB0Y+uaqRRwgcu+XUm0VB0veTeqbQsycMBJTGFLm
	Et66ioeRVgBjKH7C/2dKFw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47b23xr6vk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 07:36:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55H7JehG025968;
	Tue, 17 Jun 2025 07:36:42 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010002.outbound.protection.outlook.com [52.101.193.2])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhf5cby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 07:36:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CDhW7TTVG2RaTZPxPqMxXH1HNawVlnzmUVuywm6a6okr0M/JFTJX9y3FKv2UktXt0NkRBdNvYADvG8SfWjgrkNzy79P0daGkK33PNmpiiySWWpNKIp5oBMbT6QL5hlT7XkXlfhcTkcVALbfYurcp5CTUMJJ0BB8ZKrOTp/tGzvbNt449sGnAfNa3iJAhmjFSiQ50ZyONWVInO67cSrASi5J2da1gpW9DnVUCw1w5FF3N4YmuWRsHfUW0B/EUcpbAsmB5pjpUKvGt2jJWI0OnREC++sYnwGJYKYWoWq/yoKe2As9JcqaWYuLfxJBF/tt2ybT8eI0FfSikIMTWvucFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVKu5MfKBxYWKh07JTdEPUvTaEaMsMMb2+7hIA+TgU4=;
 b=JiGbnobWEuN2vrkIFkmwBgjfqEbekuA+pe+tKcmc9zqnrUeGnDbu6AQxI3dLpkCOcpPqu11CQ57q0GvJRVmh9zApj44rHXJ8o6goVKdnAOgYBVyNtjauWnTY8xJMWG2qRe9o6y1wA7a0193QC42SqebWM0c8eVyn6mYWjHNW0xI2s63WXjkVpLFFjjAo6D2sxj3bSl0qXm44w5QtPbLiDtSqqWfoN4dsFIyy3wB+PyQYJxqbvzEitEP/j4koixUaII0lyPhx3HidtQ5StdWWdI7tekIJwDRZ1Ua1gG5G9Dpbvd1Qi5FiCYGlPm02mh3JWDovqNoRbvqhrCrAeA9mTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVKu5MfKBxYWKh07JTdEPUvTaEaMsMMb2+7hIA+TgU4=;
 b=PiSgmYzLk5vJFI3axO4XF2FuOGawwRQUFMh/duLyTR1Jg+bjhwd7SiG/99mwiguqgfHAb+GNfqBhLmlY06NQbR3jq6oKffWb9gw4XWHzVrvrM7vo5fSSFedTNT2qgcyf9Q2EuXkQjCgHSjxUUE7E4wpa3VBgr1jcmeOjZ/Ukm2E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB7411.namprd10.prod.outlook.com (2603:10b6:610:187::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Tue, 17 Jun
 2025 07:36:40 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 07:36:40 +0000
Message-ID: <5474d444-cf33-463a-b5fa-fc9310f2e325@oracle.com>
Date: Tue, 17 Jun 2025 08:36:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme: fix atomic write boundary validation
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        Alan Adamson <alan.adamson@oracle.com>
References: <20250611055432.2401372-1-hch@lst.de>
 <20250611055432.2401372-3-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250611055432.2401372-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0008.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: 084c1fc6-e819-4545-4544-08ddad71b2bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkkvT01mOC8xSm1VbWZjOXE0QTBkYXFhSXJXNFpGYytuN1FKaGpwRWhUWDFV?=
 =?utf-8?B?YWd6OXZtZ0pHaVAxZU5ZY1RxQ2pQdG5RN3BDU1VsZG5oSWhDUkMrK1F5S3dt?=
 =?utf-8?B?WUNmMW9BbzhldTV6dmh0RjN6ajRiYUpHRmlKN0JleE5LM09yYVNxeUE2Z0R4?=
 =?utf-8?B?dzVLUElVb0JiU09yR1ZGT2RsUktYMC84alpCTUVjalp2a2RWbVZWd3Q3blR1?=
 =?utf-8?B?d2dUYW9Ncm1FZWhZclNOQUxDYlVOZGpBTXlpejcrWk5nRUlLLzV5TkpOTjZ3?=
 =?utf-8?B?YTZwTDNoQW01SktISWtMSVRIQjJwd25ZTXpVUkcyWXZqTlMzZklTWFhITVJZ?=
 =?utf-8?B?eEZ1RFhOcWI2Q3liOTBaSTU5U2ZFSGVLekNBTXE1aW5IOHNBUTBsUG5maG1H?=
 =?utf-8?B?cnJhU3V2N2ZMcittM05YRkhuN1B4dGVYdVZBZ0JHVi83WTQxbVhKSjJzSzd3?=
 =?utf-8?B?ZGo4L1AvZm02UzhqYzJPbHpGdkdIcE8yYjBFQVoxTlYwdzY2Y21KOHArNEox?=
 =?utf-8?B?Zit4cDlKU1R5enVZK1ptSWwvRW1zeklTRHpHRHJRVG8xUVVmZUltNGZJeFhP?=
 =?utf-8?B?TCtVTmxiNG95UnI2cnJjQWdUUnlUZm1xdVlBY0h2N3BVTWVpTG1CV2R2TkNq?=
 =?utf-8?B?ZFViTWFCYlYvdFFjejd1NXpzbldOSk0zVHJjdkZac1VxT2RpSGFvdXBhV3RU?=
 =?utf-8?B?WnBOTm5uVWhoNHpWcXhIeHJhbGVYL1ErQVVqTHh3T2R4SHkvS2l4cDBrWTJu?=
 =?utf-8?B?ZkNjYXhUUWUzTHlkajlVSktwRWIyV25GaHpRRVlqelRkb0h5TFRSLzNwL2Uz?=
 =?utf-8?B?WE5Xb1QreUF2alNPcWdGQy95cThjUEtLYmRHMGR2ZkRRR3BFc0UwSjRTWHFn?=
 =?utf-8?B?cTZNT05rVkphMHgvK29IeFNCOGhmbC9jQkhFZlJydXhXSjBHV1drM2ZCZWZh?=
 =?utf-8?B?MDlhVmpaaXo2N3ZrZnpGb0xrNkNtd2pHcXJCdDltZ09yLzJ3SkpGbXFGeWY5?=
 =?utf-8?B?Y0lrekFnYlExWmEzaWVzYzVwaFRqb2RSOUFsay81RC8wU3dpVHVHVWhtM0ZE?=
 =?utf-8?B?V0QzR1Q4ZXNFY29tQW5KbHJ6d1dsY2JjR0lrd3YxK2F3eCs1aG1WdUgzZkdK?=
 =?utf-8?B?b1FtUVJYcjFic0grRTUxMUovRTkvNUgwdXpuVWhXSjlBZ0tnVzB5SDVFZ05M?=
 =?utf-8?B?Z3E4YnZ2SVExMDFLNE9SVGVkd3kvNnFSV2FhWjFwVHJFQVFZZzFNZUhDbW9L?=
 =?utf-8?B?ZVhxRWtBalVCdHB5MlpZdzUrNXplcmN3ZkZnRW1HeEJtOGJnNm1jLzduamJU?=
 =?utf-8?B?VXh1V3I4c0ZwY2R0S1VsM1JOVmxYUnZ2aUJyOUpCUXFEb1VadlRMTDMrV0Y5?=
 =?utf-8?B?ODhaNkJ4RDNNSkpja1BmTTlhOE9Zekllb3FGTnlkS0E0UXNhbWJDV3pJSm5o?=
 =?utf-8?B?QUFob0xzU3RTWWFPTmZ2Y3RRYnNuWE11dkp5elN0aVExUmtXZGR5RGU3a1hs?=
 =?utf-8?B?MFFQL1crOVZqc2ZNamgra3J6OGdyQW15TEVxU2crdXMyQ0ZodythTHIxYVlW?=
 =?utf-8?B?dVU5NWN3YS9pdHplL1JMZUhTdzE0MDFqUFRacjBHUTI4TnhaaGpSS0VaN0Fs?=
 =?utf-8?B?M3JUbklBS3AvN1RoUTBMZjdxRFBJQWRQY0twZStuYmxieUZJWWFOY0w3LzJN?=
 =?utf-8?B?T0tGSE45aXA4L0pBK0wrSURmT1BYbzNHTHNhV3ZrZWRKRDhyU2haTXllWEIz?=
 =?utf-8?B?U0dON3lxM0tkeWc5aFJCK3RTSm9LTE1uUEhJb2UxdjBXYjNIYk4wdS9jMHNX?=
 =?utf-8?B?K0lRTkRqMW14d1BEUndIV2NPM0VKK2NjcEp0U3FDZGRLeUtkdW14Sys0d3I4?=
 =?utf-8?B?WmRqTGxIVEUzVDFsQVMxRUVndzJ0bWttbFhGVDRqa01hQ2Jta21rM2UzelFw?=
 =?utf-8?Q?7VxmzBclqMU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2VKR2x2bFR0bkxQTlBSeUpjNmVva1hjemNiUjdWZHV2UGdrQk9lN29udEZG?=
 =?utf-8?B?d3RFRDd1TlBYWVVubk84SGRsRjZIMHVuYzVHakE2VXk2WUJZNjVINldQZENt?=
 =?utf-8?B?SjZvc0RxVEVmTThuTXpvMXpEc2MrUGc0MWdpcDYzSWJFRk1qU3dKakJ6aW42?=
 =?utf-8?B?N201SFE0L01vTlFsblk3NGJWQnQ4d3hPekpIN201dWVZMVR1VkRYU0JUdU5S?=
 =?utf-8?B?RjM3elhERjRyVEFPSHZrTXl3MFFkbjUwYysrZzJvMnZ2SC9ocWJRSERGYUxh?=
 =?utf-8?B?Mk1HQVdoM0poSDdwZG00NUFTRUgydVlmd3ZPM29qY0VSbzltcWN4VVJBQVV5?=
 =?utf-8?B?SnBaR0tXeCtiNWczd0g0NFNWUk5vaHhNUEZYQ0laS282cDUzcGh5UVB2cVdy?=
 =?utf-8?B?NzdBd0ZnUGlpNWRyanFsOW9CNXRTdi9GUnMxajIyTVFjK1BxT3lBbW1hcUNH?=
 =?utf-8?B?NFlLNVhFdmJiWWlkRzhXWVVxTGxaZE5KKzZBajRVYlRjOFpKcy82K3ZXR0RZ?=
 =?utf-8?B?WGJSV2dIcW1CWTh3S3VuazRFYVdmdlZQVUpVN0VBQjRKNGoyWjJxRC9QRmhr?=
 =?utf-8?B?TmRIWk11UG9sbGRaamJ1R1V0ZU9ncFh6YklSR1lpSlhteEdydVZyNE12anJV?=
 =?utf-8?B?V2MzajBUUHpiWnlMWnRpUXkvZmZ3aEpPL0ZFUzJzVDhKdHZXUU1oakdvUndu?=
 =?utf-8?B?YzZkSnhhYVVwblhYMkZ3L3dxeUdOeXRFRWZSMElpZUhKcXZib29lQVRrSTBj?=
 =?utf-8?B?bTNtdUV1TmJPZGZiK1kwNmJHaThhNk1sUklrN0dLNklHazFwbGxpVTY3cmNn?=
 =?utf-8?B?Z3V1S091bkxtYTIrN055UFZ2QzcwU0VVVEI1TE5yY096bzJ5U1lpdWtEbGNV?=
 =?utf-8?B?SDhpRTNPVkVyTDBCT3EyMmttbXh0Q01GZDlUd0U0VTh1bmVCbjM5T09kUW02?=
 =?utf-8?B?R29ibkZVNUdsN0l1THJJQlNJc053L1NrVm1rdDVXeENLVTgwbDVvSGhuTDdj?=
 =?utf-8?B?TFEvNUYyRGt5azdWcTlCQzZuL3hwcXdkRmRQa0xEY0tpeUIzT2pqWnpxWTBy?=
 =?utf-8?B?U3QyTVFlcVBNV2NUNmNCU0E4UVNqTnIvd1RyM0dDUHg5STl6K2VTRWZWUzd4?=
 =?utf-8?B?OFdhZkZIdkQ5Z3R3alV0dThJNUpaVlhvbW5UWXlGNEhNY2dTVmJnRVNOdjMy?=
 =?utf-8?B?RjFmYnV3VjdMZzhlWGttSnY4RjB4UU9QVHdTeUVXekMzWkprUmJpVmVBZXZa?=
 =?utf-8?B?Mjk3MTI4WllVNDdlMGplN2Mwb2VldG5GS0xrUjI5QUJacDh3cE1qdXc0a3A2?=
 =?utf-8?B?eHBMOG8yL2xqQ1JJRVlmTjlZRUJvaTZxYmZhYTNOcTcwYWlRaEtFL0VxVy9m?=
 =?utf-8?B?MVRJYnp2bU1UTUc4N3NobEl5bVNTRGVocXhUNVRaR21aRW1POTVTWFViVkk1?=
 =?utf-8?B?V3ZrUkQ5UE9JeEpTSjRuSkhtK0J4N1Roc1FMR2F3c1Y5R2d5SnJnNEFRMjN5?=
 =?utf-8?B?bVNxaGU2aVFiNDJIbURJUUZrQ05QSVRrZ1RNajVxMHJDWGdsUnNWeDVibXB3?=
 =?utf-8?B?ZGFKYTlCcHJIUWdaMHk2YzJsQVdMSXhEWHI4em1WZHYvVGx4cDJ6ZlFkcnBI?=
 =?utf-8?B?UEk4bWRvSHdOZEZ4VDVpOVJ6R2d6TVFRMlA4RnJ2WGwvbTRSVlRhbStwUFlo?=
 =?utf-8?B?dnBrN0lZWm9rUjNlOGNLYWFnTkM4WW9FRmx1Qm1pVFg3MElKbk1ldTAxbXQ1?=
 =?utf-8?B?eXdXZGRaYkswVzYvVUs5UjJZRUcyTlJZOWQ3ZTVrNy9LeWNEWkRHcUQ0TWFV?=
 =?utf-8?B?MzE3cjZLZzgxNVZIRzBrT0FjS0ZLNXFVbnRudkFQUTJ1Y005Sm1qcXBldXZ6?=
 =?utf-8?B?dis1YmVpSS9IOGtoYzJoMzBLbDdRd0tLNlFQTTRMT2RNNS9WblZxays5SVRW?=
 =?utf-8?B?VjdRdzVKZ0Jzam5PRCt5VnY3MFEvZXFwbmxSY1RoQW80Y0o1emJLblBTYWNj?=
 =?utf-8?B?VU1ibS9UQ3Z4dmQ5dENhTHc1MjlKUnozMU1aRVhLQnlnbWFXWlZ5QytZMERS?=
 =?utf-8?B?bExRYVNkVms4QnB3UDZrWmpoTzZQNVpjSVdNOWFINGFrTGdlaUFlT2JDRHl6?=
 =?utf-8?Q?qB2sRIYNJzbxgxmrcpnTL/c2P?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S9PbyzUbscFA1/ZDBTiTPzwFgvaOzX8yZYk7UswEx8lKxKJPDmOAqD5j5B0bKhjzThJTo/xtVSnICQQjEQjRDSfx0J/0pzCbrln+O3A2m+0x0rp4Eg0H8HOQhuoGmJ/YQgRTaBrtGuPbUt1NafLt8vphP2nNu0D+JDEiWXa1mi72mNZ5QY+Mwk1CHNzpUV3l5KXSJAO08C23ojetFy3rrYxbsrGZ72pgdqKQUJMxROmJfppngRDG5iabsSGxmw0cabJp2bAk8EVGIaQIvuJ/8Qvo+Sjw193U14nnghZCfGSkZCt8X8Zc1KgZ7Nl9GsrigViIU3NxoFPr4JNOUdMrl74WcbZPUTZDcNM2pelOaMj7b1gEGmYDqY4RV2gSxbjLfoi76FFaUinFotbNSvPvGFIqLdhK7t3BvtedLiL61nNNtd2b3dAA/PnvgMrl2G4IvoiZY4Gf1uABhNTMWZ1c1ne3SWpEmI0hO7NI3yj1pwPTZNa5R0FkrqEZ5WFJctfTkI3SBpsbtXC9qqOER4+XrNc+w15D3bF1XLj9TfIjFiuSj47+U9m7BQDiGIbzYMNWhBRDag7YeniCTJFOSmHSq0i4F3pYSjp1NhOplcV0mnw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084c1fc6-e819-4545-4544-08ddad71b2bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 07:36:40.0531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M880uqiVLOgK6RuBN2Nc8oxBZO93/aWBaiXYjpB9iUHmjav2HtEzR9u7ZYDQ1nPxaoOZBBDXY+TfYzwiRF1l+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7411
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506170060
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA1OSBTYWx0ZWRfX+ibo6WOn9Uvn FzvjzimZvXaN5qQririeH7YXsyy6h6fQ98Sx/Ezy2JW+04r0GvexIE4JIMYX879pURE6Tp/AG6w V6t62VNTE4kfBxmJ94q5/NCOSueXLWYoFtd8/qrv8NoRf9oIgTW2pRmQ5oOi47ML/RdczzNWmS/
 /IGp9OPrR1HcTVR98Xqnb554H6qQCzT9mQq5FdBUuXZlQMBdEkZJrkGF9HPAW+uUShJcV5EMdj/ cMCwFU54roqT/nzrD4PtDY2RVQg5LqaAlMiTQe12S/4GqZhyIopNk0tPCVCN4JVh8fNAXZAqN0L cGGqPjbnxz+Xl6SrT2IhtWDqSKDym7fCibiLmBe0/M9YminUeiLeRZA99nB+m1Vp0Br4jctI79/
 UPgEC7xQfoshfJspNrmetP4oC5TwTHFIYTxeQ5FEwepOKdtsdmrpX17iarRZ/8VbkJScmW7G
X-Authority-Analysis: v=2.4 cv=DM2P4zNb c=1 sm=1 tr=0 ts=68511b0b b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=CuImFZMTlsvlkkwTOogA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:13207
X-Proofpoint-GUID: QRJODhYe7-tZTkUcboAATododbkoxkUX
X-Proofpoint-ORIG-GUID: QRJODhYe7-tZTkUcboAATododbkoxkUX
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250617_003650_519318_A73B8B48 
X-CRM114-Status: GOOD (  14.39  )
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

On 11/06/2025 06:54, Christoph Hellwig wrote:



> Don't mix the namespace and controller values, and validate the
> per-controller limit when probing the controller.  This avoid spurious
> failures for controllers with namespaces that have different namespaces
> with different logical block sizes, or report the per-namespace values
> only for some namespaces.
> 
> It also fixes a missing queue_limits_cancel_update in an error path by
> removing that error path.
> 
> Fixes: 8695f060a029 ("nvme: all namespaces in a subsystem must adhere to a common atomic write size")
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Is boundary the right word in the subject?

Anyway, FWIW:

Reviewed-by: John Garry <john.g.garry@oracle.com>


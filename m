Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F310BCA0EEB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Aug 2025 12:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lvVuppjFwVNl7tdbymeJlIyaDc8Br0vTb2zcRd2/O7Q=; b=I/UkSAVjDaoUdioqMjQ8PGDZCi
	4VpP4X41iztnep2MGS4s62c5Ex6LifWpRTuZSaV93VzxMoF2FZD4UXP0KNE2aGOp0fV6TwtL0dFzX
	bjITUjQeKsZ0peqMpHJrEC4UZTDmO/YPiSxciNTO10oGDe9YepHjEGycCztRV4oxb9ESoJwUwOWgE
	ajXTWN9fGNw/9crT0Lx2l+1UXl7uJautqhRH7Uc5IObs+Bv2tmLS8fT8NGNT4QX0hHABw5+YCNX9r
	O+rdhmtQwDMkc34qD6WllwKi5MJXfBbNTaGC18k6S/IAv+PNO0cZh8/XlG8byMtdvwZdTCsz6IYIQ
	wvPEy++w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up4ht-0000000Gwuf-2Trd;
	Thu, 21 Aug 2025 12:47:53 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1up2cE-0000000GdCv-0cJM
	for linux-nvme@lists.infradead.org;
	Thu, 21 Aug 2025 10:33:55 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LAVhb6023462;
	Thu, 21 Aug 2025 10:33:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lvVuppjFwVNl7tdbymeJlIyaDc8Br0vTb2zcRd2/O7Q=; b=
	OngPq1E2m5GHysjUwNI2OaIYMk8nx7LDqId0P5PO0gXkliKv2/KYPgrgIZ3ju4kd
	+EV3FKy4XC213rrTlbv14i6ejEr63vNqJDL2/YGlT4qBFmkZgOG1VaA2a2sWeYPI
	0Z0hevn52YToK6mt36baox4imzRAkW9NKPyyXXMC7laMQosY6VGAyqCD8Aehk9zM
	vo2eJeBB3jRZI3TpSiwr2YTbiqqYfgpm7JnEvJUOb6XJOpt+MvZYMeJ50K5H6wtZ
	A0I3e7QhNr+90BPNZxAzqny45XCzRQ82nijr/LOjJpdOn20H6dJ9iQ/fE9EQVdd6
	BTxtb9FLRRiwvMhyQlNDtw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tqu8tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 10:33:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9cPa7039458;
	Thu, 21 Aug 2025 10:33:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3rwunq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 10:33:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DFasW+tgfcD4l4FFiptK/0T33KruxxOPSI7m7Xmqc0dQGIRSzr9yLbCDNbIYwW9zhMtA4bZJLyk9wTOPi1riuOpxsF6PByD5AydHj1yu14Qjd2K53OmRQy7aUoxJ3tzrCazWcTTOu1r76Eo/gwJdk3fiQ3m64DCQ+YEaCsf9f8eFtDcTBL7/+AxZVizIrF3mN+yvYGbF1t0pYVIciaP7SjhvBV9JDanN2n5loc8jw5pUuGLCaQ4QxJlyujpqhdoAUUgm7NXNKgkmFSKPB1ZjeUPU19DjT6g+ttWk0L4a3z/S7u5Bc+r+9dWlzlQ6O3FuBj3wCUwR62EwHhemCs1kmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvVuppjFwVNl7tdbymeJlIyaDc8Br0vTb2zcRd2/O7Q=;
 b=k3q4Ws7vAadCudgqUXXzU5xPXRkcT+f9ZelFtAPBdDhaoj4crZFs5ktnuiNlpVVSPtMEKQbjkzQfiGndlNjcu3s00vKWZb14rrNQq9gAUGqirtKOuqJ/5tRtAoJ6UpaSqdAAu4F1cfl6TL3uDk1aJ9xk/xPm1L25yTkyoIPHzHWMBV0WhPKUTQTmFzoQLkHTF92UPKUrbkS3vmBQ2b7vjfLiMYoVn5/CNGDCUKHZ62XPyr4nTbP7/W8RhZ8sSu6Zxv/EqCR75AAk/ap/QS9+QWnTP+ExaihOuBTm+mGI65j8GI8iawn95EW7jTo9ZMR5pEr1Otjy62afiNm9V/517Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvVuppjFwVNl7tdbymeJlIyaDc8Br0vTb2zcRd2/O7Q=;
 b=t9sOtzYx1VxfhB8utZXOnR16yBhZE90ah1fSg/C/ScLA+PvOVKlY7EbjWAy4KwppTj4piPdrE0PLhkZ6sNTRkDLoYaEpJV/BeK6U3HiXpidev/HiufOzKk7ilzwCYvgPQott5iGIZxnoFGDpsSr4J6SSz/65Y5PQys6dQ5LuRkw=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by IA1PR10MB6027.namprd10.prod.outlook.com (2603:10b6:208:389::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Thu, 21 Aug
 2025 10:33:28 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 10:33:28 +0000
Message-ID: <14bfcc0e-ec43-4876-9b45-1f2824e1b059@oracle.com>
Date: Thu, 21 Aug 2025 11:33:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] nvme: add an opt-in to use AWUPF
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, nilay@linux.ibm.com, martin.petersen@oracle.com,
        djwong@kernel.org, mcgrof@infradead.org
References: <20250820150220.1923826-1-john.g.garry@oracle.com>
 <20250821083537.GB29224@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250821083537.GB29224@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0482.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::7) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|IA1PR10MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: c6dc4ed1-3763-444d-659e-08dde09e2aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NHViQWFua2NwdE1MUXMvUmVYNXlKRUZNbm8xMmhFNGZaUktGS2xhM1dIU2VK?=
 =?utf-8?B?ZWt0Q2RScUV1YndlM3h1M2tSWnJud0FtSVVBbGlBVkd1UzZHbkVXNW9sMzF6?=
 =?utf-8?B?elZXbkJWWDR6ejFKRzIyRVFMNUtScGpWanF4SEEycXhyNTFLKytzcUVhY0Fm?=
 =?utf-8?B?YjcwMEYxMGFSWTUvNUd5bGJGTHpVMy9hdE1RVzhEeWhZTklHT2Z1alZjdmhx?=
 =?utf-8?B?cGIyYURoQVNBQVgrbzNHc1drYllEMWZ2ZlJsMjRHREkyekMzVmdOK0txVi9t?=
 =?utf-8?B?YTFiMDN6bVZXZ29MSEd5OURXa05VQ1dBbnRab3hpRTI1SlFhci9zWGcxV0Zi?=
 =?utf-8?B?a1FUV3BJU0RySGNtSXR6OUdOQWQxWkJWSWd5K3JGdTh0UzFkUjVNbU55YWh5?=
 =?utf-8?B?bDNVRFNUSFY1V2Nvd2ZlM21zTkFIbXhYSTNQTVBPdWVSL1J0UFhPam13bzda?=
 =?utf-8?B?OGlZVVg3MkdhYTF1bU1sVHF0MHRVaEFJREVVVmJRQ0tIRGIxcWtsNjZjNXNC?=
 =?utf-8?B?TWkzUktJQ0VCOGZ3UlFpRTM5eGNscWE4alZHaFV2a21ORUN1M0p0OXNyUngw?=
 =?utf-8?B?ei9VMFZNRkNIK0JFQjk1bXhFQVBYbjNUbGx5dzVIRGtZR05YWDFrWmxWOU0x?=
 =?utf-8?B?VEQrVmptbnFWL2hyUk9URmcybWNDdUdRQWN1dk9PWjBWWXhkQzVaSzVJelE5?=
 =?utf-8?B?Sjc4dkxVMkVqYjhQRkdRR2hQMUxKb3F0RXJITVlGVHZyNWFkWnB2eXZHQlNI?=
 =?utf-8?B?Z1JYK0dCS3IvOE5lTXpqaTZGNmxYQ3BOTm5BSXlNYjEzeThwTlFCbnZIQnkx?=
 =?utf-8?B?YXNvMDhOT1h2R1AveUxqbloydUpxbGFmWERsTVR1c3R3RGxzNG1PeTRlL3h1?=
 =?utf-8?B?VVM4SlNBTnArN1hJV2ZiN0pvTlNRclNMVVVBd3NSVjBEVTlCOEt2SFdIV0JP?=
 =?utf-8?B?U0hLY2x4V1o3TFdWdVpMSnRmMGhtUFBmM2krbDNQMGsycDF3TExmM3YwMmRm?=
 =?utf-8?B?aTVZVVhPSWgzbkZjRjI0QnNCNWhJQmlkaVQwaE5VYXBxQTRqakpKWmNhNlZv?=
 =?utf-8?B?Nk9sRVFNSTFBQUdLZ0tNSHI2bDlxSHJORjd0T3BQZ3RtYUhHWHJMYk52cFda?=
 =?utf-8?B?U1IxKzMwYk96RkQzZ3k4ZVRsczM1TFd0ZFh0MGxkNTVUNytnRXNyeEZhQWhs?=
 =?utf-8?B?Nmlja2xtM01MdHlvMDhzSjVBOGJwZ2dmWVRyYm9DbTlCQjR5WUpQVEhHbnRq?=
 =?utf-8?B?NnY1WmVPOXVnaXRLcnVjQ0VmZDhsOW9pbWQxVkVwSU5IM3VmR0tmWmFST1hL?=
 =?utf-8?B?UjYwYnNLVnBhWk91UDcwQjZIWkx1bjQ2NGNLQVlMZTdIUEZUZzU4clNzai9H?=
 =?utf-8?B?K2Rtd3JJNlJxQlA3enRUeFFSTVk0KzMrbW15RXRXSXZVY0VzQ25tQVRLQW9V?=
 =?utf-8?B?ang0QlpyRUpTUHM4bkVZSzRQNnQ4M0dwRmpvWXh6dVQzd1RKcS83QjRtV2pB?=
 =?utf-8?B?cW4rT3lyRzhIU21SMjIrZVVPZzdsSURHOHo0a1NvdXdpQlFGc1JKZVdlMDVk?=
 =?utf-8?B?NnI5VWljMUtSbTlrQXU3MEJiOU9XcFRnNEFJQWRwdGFNN2RaRHIvZWhRZ0w5?=
 =?utf-8?B?ZmtCNDc2eFR2M2R3aUdqZlJJdlZ0eWtjVFhVcnZWWkg0elBJTDZ2NCtKL2Zh?=
 =?utf-8?B?dHk4ajNycndCZ2JJYllpbms2SzA2bnpBNDRTS1dCRHRvckovalV1OVUxMVlw?=
 =?utf-8?B?Nk5WWVVPcEhPU3h2Wm5IQzZ4UnBlOHVKYzhtQTAwK3lyV1dEaTlTOURYdzBJ?=
 =?utf-8?B?Z0U2dU8rVndkVlNwWmhZZHo3SE92QVZTTDU1aHBjODNKek5icUZXYnVuZ2JX?=
 =?utf-8?B?aHVBZ0FJd2c1NFN1RHR2UXFBTVBYekJLYmpHWWJESk9FbVE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZvRnJxNGRESC9NRjF2SWoyRU1rcE5tcHAvd1UvdFlkRGJSRWhBWHpOSnZL?=
 =?utf-8?B?TFpUNEc1ekl1RlVhRU9vRGVRZkp3NWkrKzZRSVViNWVzRzA2TFlzaVNVc01V?=
 =?utf-8?B?ampRdTkxZWErbXNTenJhdm9tc1ZTc2EyZkdoZWlJMFQ5TzFhSU1hUGR4Q1J0?=
 =?utf-8?B?V3R0QUV0cTZGQjlJeXZkeFpsazZ3U1VTT1hqcFJTaktIZmhWbWVXY0VmRFFm?=
 =?utf-8?B?ZWswMW9sSW9CQVZqdE42YjBoR2lhS1V3WEIxTXJsSW1oUENVeXY4YzQ2T2xE?=
 =?utf-8?B?YkNMOUN3NnFTdjlEcjgxUXF2VXlvMTlzT1JVUTVyZjJmQUtCeXk4WDhaK0lo?=
 =?utf-8?B?Mnc0OWtlV0tBOGdDT2NvNVZEQU9INGZzdnlETEJFeTdtNlU1dGgxRnJQUGpH?=
 =?utf-8?B?aDVPOCtzTmhZWWs4V1l6YUsvOTZzaGQ5U3M5RHRCcXp1UWtkMUtFYTBPUnN4?=
 =?utf-8?B?YlI3UnhFK2JtOVE3WERqUTc1V09qMmM0ZDI1TUlNR3BMNW9JNkx5WVVRd2ox?=
 =?utf-8?B?NHhIb2tXOHI1QUpiSEZCdWUyR2N0WUNMTFRCQ0xDUWYvTDM1ODFJWCtRY3JV?=
 =?utf-8?B?eE56NUt5bzl1eTY2ZkJYWnRWbC9TWkpvQTgwb1Axck5WeHh0RisvWHhqcit3?=
 =?utf-8?B?NEFvenNWYWZJckpndDhMVzI5bEs0dm1GV2dsY0tPb0NlU0VXN0NTRWNVYkVW?=
 =?utf-8?B?NVRCWnVlc3dURktBckxLQk4rVFluUlZmZW8wWXFsUHAvT2UyTkhPL2pDK2gr?=
 =?utf-8?B?RktIbk9idXpKTkdCKzVXbGhmdHU2Vy9zVklPS29COC9VL1RvU3hkYXFZN0dz?=
 =?utf-8?B?OWNvbkNUSm4zVm9YOUcyZHl5ajhYQ2JWZ0ZYaTdHL3d2bG5meFNUcVpETXJ2?=
 =?utf-8?B?ZzlpMC9qdTM4ancxdU8vL1JXQllYRktuUG9aeU5obUgwV3lKcUdxVVlmTitQ?=
 =?utf-8?B?b2d6Z0YzMC85QTd3WUt4cmdkQ091azVyRnRQa0xUSnhjR2VvTW9aUmJpOWJY?=
 =?utf-8?B?OFBlK2Y2M0s0RmtqNDNzUmVOYmppcGMwS1JEdWpLbE1nRWJwcCt0b3JvRVJ2?=
 =?utf-8?B?Z25HUjN2b09QbDk3UTRBaVh3NXZNQ3lEOXZpblFqc3Z5Z1Y2dXU5Ym1nbWty?=
 =?utf-8?B?ZUY1TDBqM1AwK1o3cnYvNlc4d1F4cC9EUGcxWHQ1MXRLTlJEeEVCek85dW52?=
 =?utf-8?B?Nmh5QUNBa016VzVNRmxOWUtXOGNqYWRnUkJHbTdLYmkyMmdoVVFEK0NqRzJu?=
 =?utf-8?B?aU5DRFQzWXlGaTN0c0F4c1lTRXpEOHRxbE1EMjA2T2V6eUs1UlJNSGtTcVRM?=
 =?utf-8?B?d1ROZFEwQVVuMTM5TEhUbmJvdkp6L2kyYklValdMMnFlK25JaHA3SU11Tk5T?=
 =?utf-8?B?MHdJUGhZSFFjUDUzaHJiZEN6UkxGVUU1MUFKT3RZVDkvcS9Pb0ZmN1F5QUNi?=
 =?utf-8?B?cXVJYU52YXhjNjhOVytNRkpmb2NHa0RyY3dhRXl3STV1dGNQcDFUQ0NnODJG?=
 =?utf-8?B?dmZOeUF2TlBjWVRvZnFETzRYYVlzZk9EdWZXMlg2R0VlYWdZN0xEb0pBV3RT?=
 =?utf-8?B?TjZXUmtDbnY1MS9HbjIrV0EyZzYwTU9nZ1doa0J2dTVoOC9iVFZuTGpDUEJl?=
 =?utf-8?B?L05sZU8xR2hhRTdEcTB1bE9haEN0YzBMWVpFVzNNTlFpR01qV1pPZ1FzcFNR?=
 =?utf-8?B?QUhlMVBMNU5QOEg2S2dDcUs1MlpZOTZzRDRQZndyQytBUW1ZODRWQWxWNUdm?=
 =?utf-8?B?SEpxNGovczRTVUxCWGRrcU5WRDczemVMTCtQeUpoQ0VBekJ1MDh0QWx2OXJJ?=
 =?utf-8?B?WkVVaXpDVVgrNkRYVzd1cmhNMzU0dnRJbkcvUm8vblhNTHN4cnBNNDdDWnFE?=
 =?utf-8?B?dkc0c3hxN0d0Vm5KTmw0M2UyWU8reDBLNjVKd3hCUEpwV1pTVW9abW9DQjNG?=
 =?utf-8?B?cmFKUjQybEpsNmNkMGZIOU41eGkyYXJPb2RNQjhiRW82bCs4bDRKREI0NzRW?=
 =?utf-8?B?NVhoMVRHQU9YUDVCRzA3MWlYVytFQW5OYTFtMUNpR2tLTDdNdGlyTkNuSGR1?=
 =?utf-8?B?bnl6dFpwK3ZOOTNwaFVRZ09yLzBNVWpmU2FjR1lIUU5XTkVpZ3QyWmVENzFB?=
 =?utf-8?B?VlcrWk9PRk1PZmZHaGlrUzBaYU1oWWZmMGRZbk0wWmNDWTJhOG9SMk9uYkJD?=
 =?utf-8?B?U0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2ZQHMFfzTFwyfJTx4zIOgsu+zluqT1oIepxxpePfBAkZ5FcKXdVi1KUBFyfI5Y1ufl5TWs3xvEf+dFgY1EUllpSARnenBZq5oA6embXLz7Zp06Vb8JpM8G3hAw/tNNOm+8gq8JXgTV7rzf09DYMGSq54oeBf3fMHczFjzZ+3pAoNW5W8XMaUfJJlDEKiRmIe6UoUikIctILFhyAHR5ukS5E26+fmvbsRVEwSd/tdTnHvkcHrTVP8DVEFIxZvfIMBBbRRVASQ20U0F/N9Gr6i3Fq/m3r+4VXZKPbGZXrmmpq1EYsrSiZ1bJZvwCLytti1nGKTua1mwa7jnwxYYpIbjXgC7fCTUgPNo4axBPaGlrmz5t0zqyNVV4whBlmn9mD/yQzTeSuW1+ArsNJyb5GbjoXakBo95PqV8udtxb1UkQJQ6uG9HqcO2EwL2S9psK5XMx4BiH+v9G6gwI8FHglGzCx9sY0oIycjMltUDztGyf12Oj4NgaMBnFbLN3wDFgELRlL5sDbZ27S6ja4hCL2vj1mqJ9flzDM0Ht1BoBx27Smv/nRWypSRdk9JAY57O5p3JTu2igUS5vVCT0BpprtzDYpAgHAtPxSqSOAKDFk0w08=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6dc4ed1-3763-444d-659e-08dde09e2aaa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 10:33:28.5708
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZ8sBu1VuKzD4Ing/Q4G+G5V3ERWL0vWkOnz5h5aA/B2Zo84yD2jCPxi9nPLX/+Zjweu+N96rEB9/31lm2YUMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6027
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX90ZKpnLkdb3H
 tuyT5W6IFxr9tcoDxxoIUd4O56UC/qpl2iyu5WSZ72QzUFZJS99PXuubqtjVzRChubI3EwFQeIj
 nO6pDfB6Mskq6e9BHcwpxqzA83wLsoY3XqnTEz3HkvOoXEBxYp4m2JsRDKnxglcINnmC5LI9yeF
 BLYuWvVFpTzQOMz+hCzuhouV/CBx7AKki70Z/Qxbpdm9CkS7R+dCMNtLIzVOvzimnmkQWQV9o8S
 0j/oafId9TkSTZgfQvacnogJaRTwNLt9n+UwI1ZLzyX1J/tARnbmVUS1Fnq2D9S3otxZZLK0XP5
 07DIGjUONcuf1AZV3EAyvQG91VANfj2J034mjUB192i69FA2cS1k5rJrc95UVFUveobc9RJT3Qn
 QgfQtN2VM3JWannK2jlf7Spxqm6m9A==
X-Proofpoint-ORIG-GUID: xhCzIkInhhksRKwm92uCEO4n2zWU-6Qj
X-Proofpoint-GUID: xhCzIkInhhksRKwm92uCEO4n2zWU-6Qj
X-Authority-Analysis: v=2.4 cv=K/p73yWI c=1 sm=1 tr=0 ts=68a6f607 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=w-irUMOFRY7OUAibaxEA:9
 a=QEXdDO2ut3YA:10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250821_033354_295692_994A3D82 
X-CRM114-Status: GOOD (  13.68  )
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

On 21/08/2025 09:35, Christoph Hellwig wrote:
>> +	list_for_each_entry(tmp, &subsys->ctrls, subsys_entry)
>> +		nvme_queue_scan(tmp);
> queueing a full rescan here seems expensive.  What about just keeping
> the awupf value in our internal data structures and always use it
> for the physical block size calculation,

is that even ok? physical block size implies atomicity also.

> but only apply it to the
> atomic limits based on a flag?

We have flag BLK_FEAT_ATOMIC_WRITES, which could be used, but in 
blk_validate_atomic_write_limits() we zero the hw limits if that flag is 
unset. So we need to fill in the hw limits like in this patch.


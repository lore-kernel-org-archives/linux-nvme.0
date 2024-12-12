Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BF5E7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 11:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DglSlxxvsKB6PtAjB3tF8HxgZtyQ9N/k9pEWL+Gep3o=; b=pRti+cMJHdt22RB5ByJN71A80w
	n//r0UlsIs3bhRzLmYDG5Hr6g7jSbL5VV3EIfagOwngfxAHNQdqeCo+SuZ/sUcKSU7K7k8G25zftz
	uK0F4JxXJ+xK9F1VfIYuVLj3VwWXQfj3fCpt8otn65/S915SnPiGSjTu/cO8MMI3Y9pYzSuV6m6dj
	7DfdA9so4ubkQLpxcorsCPgXKLSiEZrF7G8SAvC8GHrpavntF1mYDhKz+Jm5xT/ewI7IbXh8KGQEN
	OPI04angbxhHNc/S8ZyM2o9/KnpWR1hNW3DYi/yCDmuN1pm3KGQdpq9ugwH6sdzlenT2nJKWMPIwE
	enklTCdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLhLg-00000000B2T-2dEE;
	Thu, 12 Dec 2024 11:27:16 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLhKE-00000000Aos-2F7Y
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 11:25:48 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC1ubZi014804;
	Thu, 12 Dec 2024 11:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=DglSlxxvsKB6PtAjB3tF8HxgZtyQ9N/k9pEWL+Gep3o=; b=
	meQXxFJiQSTnvz66F2Ud5SMyhnKLjVMjZTr/KMtPM6QKsvcHgeASMtRhXjMdq0x9
	PnVsb2AOq6SbqlQV58BPIes243IjPtQkfZPlE86EIstobo3dt3GErUY0EwQXrxXb
	q/1C7VSgqrtwO+hZ+Y+0OvjjXOKSGsRQrct3sXR9qZUbSfOBqB+qlKHRX4lAR5RS
	VreB5tIPiZIS5m3bUpDIV0eJdIpvKmd7B0Ey7zHvppKydMjYHUTPrLUmK1Mx6FGh
	mZWEmvnAIdTV6IolGNYdGhacWHXQL2j3lLjMPUTpoXXjy9Fg4VIIfxZvL2Msazdz
	x4ikqEYe4Jor/c8hDFKZcQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ddr68ysf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 11:25:35 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCAvEPH009463;
	Thu, 12 Dec 2024 11:25:34 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctb0pk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Dec 2024 11:25:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7kDevWOKEuHh8Iz5ONoTeb5I9RoCx22UfFRmCVJcnjJfvqZlJBhi+kHtgDFk9a1tBlR6kVXjZAXadz7jLNthyeM4H4URL4JIGCinAUSiMTKIqL5frLa8BOpWzSWMzzrPHDMnqlxueMbm5giJrXdf3f0MoRrlQoFPcwjYWEjQK69QbCAyXVmYbq01nO4JAunCQRQUdQSRed0YL+vgVKn2ldTO5YuNMmb51j09tLv/X73+0cIdX0y8LpfwoqgX4QU9oUJQswP62fQUx61J38ZJM4VcasPyHYz0o26MebByqqIieqJIa9C3mHd1hpAA9Tne+nzNXT/zowA4UzjxUN/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DglSlxxvsKB6PtAjB3tF8HxgZtyQ9N/k9pEWL+Gep3o=;
 b=pqL4JF3VxKfZFu4UFpRSu49YNE/oXrhvvUe7jhfBxfxjPWOkAzGgHokmi3UR8X6G2Mo/K1U9lUEm2Pfb/827cbi0VKR43105q/hzV1wQpqTnHzUUFl0AfPyBG55+II4QKfgqruWtH357l3PkRqtxVLRin+uEs+09M1QguZ529UmPgKv6/sjtMxIslccr0I3665Tl0CJVAs4BZw2e3wqJHgobME9amFGVxD5Fn+tGi3eJT6MStKB8PREp1DcK6fM2UG0kSbfFCETNLK1sh6XUkLmmDKh7DW3pMUfATr1fgs/Csz4hppBck+ElpuoFYmVCpg5ezyY+TSzeRIGf1FWIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DglSlxxvsKB6PtAjB3tF8HxgZtyQ9N/k9pEWL+Gep3o=;
 b=zH13hcRSePQPwEj4Zhc4Ix6ZEanSDS7r3Xo9QViaGR9PbBqumt/Nr2ZZCx4voIf0t+Q+TdrfamojOlmM4+/qAPvTiqf9nHQ7UsJKxBoqNgwXUqxh5xnpaU80brwBNBpJgWL+gvAFP6TS4qJaFu+Gmy309XJSXNA7d0gzTWCIYVg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5200.namprd10.prod.outlook.com (2603:10b6:5:3a6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.17; Thu, 12 Dec
 2024 11:25:31 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8251.015; Thu, 12 Dec 2024
 11:25:31 +0000
Message-ID: <280f8dec-f202-4004-86e8-d3165bf02047@oracle.com>
Date: Thu, 12 Dec 2024 11:25:29 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet: propagate npwg and awupf topology
To: Christoph Hellwig <hch@lst.de>, Luis Chamberlain <mcgrof@kernel.org>
Cc: sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org,
        gost.dev@samsung.com
References: <20241212033148.4008110-1-mcgrof@kernel.org>
 <20241212055250.GA4825@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20241212055250.GA4825@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0004.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: 06533e6c-e826-4b26-78c8-08dd1a9fb028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGFTMEJkUnNMV3RHMmJRdG42NVlwcDZUcDl2MDVaU0lpVWZYV3J2aHZSV1ZK?=
 =?utf-8?B?MGh2SFNyUUVBUTZ6azNhbngvZXlMbE9ibkFRSmhRQUNPLzh2NURxcEQxdGNm?=
 =?utf-8?B?RWUyL3NUeUpiVldCcW84OUl4c0t6NEE0WnZMRU9LUFJnZGw2dGRnRGkyMU1h?=
 =?utf-8?B?VlBQTm14TUZDK2VLS3ZiZjBXTXpkY2RpMlVlMURxY1ZVdUlQWDd0aFNXMVYx?=
 =?utf-8?B?aFpVbTBUWXJ0SXpxMnZJbnJRMlBFdFBodVFHcVJoNU1McktoUkpjbC9wVHdw?=
 =?utf-8?B?RU4wSzBTQzExaEMyZ0hCMFg1dXJDUXVKdjJBZEh4UW1xME4wRFJsM1BEVHN3?=
 =?utf-8?B?dUN4VlJaTmVoVUZtYjRCY3NyLzNDdWVNTFN1QWdZQmlWVEpCYStMeFJjSjQ3?=
 =?utf-8?B?UlpCeVpyRkwxQkFWS2tXc1ordldKdHYxSHp3dXpzSUlOOEtxUWMvMXVYQ2pT?=
 =?utf-8?B?aDNhMEdmSXlaWjIxTlpmaVZCN1IwUVJFU2RLTFpybzJ4bmpvRm1CMmRBK1dT?=
 =?utf-8?B?T3pwclRMUTdzU252V29NQmdwcXN4V0xFcVdQUnlCNWtGdFZyVFdxbHI5SzJJ?=
 =?utf-8?B?VitManFsMnN3cmloMVZ6cjQ2bUZ3aEh0OXhzNnd0KzR2VDh4MTU0YTZoZk4r?=
 =?utf-8?B?TUZ5bStRcUxXanNvaVpBdzR4dmJDci90cndCYittd2dWcGxqVG84VTd1RDZW?=
 =?utf-8?B?cGRnTS9EUzNMTkxxTUx4VVVXTEdsVm1XamNrdnB3VXp3OEsrUHVxTG00NTZ2?=
 =?utf-8?B?Vmw3dWxjZVY5L3NpTmo5QzFKT205ZnkyQS85TFUxSWlvcmVKLzBueXh3YVJX?=
 =?utf-8?B?V1Y0QTlnbSs1bEErM2pMbmZ6UThyd05mRFRWdlZXaWZkYWUwR1Y2Z2dEVWtP?=
 =?utf-8?B?c0s0MUZybkcyTmVYU1ErcDIzRVE5MGNValdBZ2xuYmFYSXhBVHZ2M1k5SmQx?=
 =?utf-8?B?eDVEeXlMcGJ0RTVuM3I4QkdoT0puUitDKzI1V2RYWnZ0eGV2dWJNSzBsVlcx?=
 =?utf-8?B?TDlrWldwTnJqa3Zod2pPQk91YzgzMlkxNUk4R3lUWEQ3V3pOelNQbk5aMmd6?=
 =?utf-8?B?aHFlWGViWnpxZzJnZ3BobFdyOURZQjlUM0c1Zmt4QUlVQlFRSmdRTXhPUFov?=
 =?utf-8?B?Y3RFNjQxSEdSNDBxMU5vYkpjNFlqV1NVVTFTblZxN1NESzdpN2FLZWo3L3lh?=
 =?utf-8?B?OWZzODkzSEJmYVJrcjM3OWlrUlY3eDJleVBYZThPN3hSNFBCQ0Mvcit1R0hi?=
 =?utf-8?B?LzJzVnRHUFRibDNIY2ljVG9VdUV6a3FKUlN6TzdpbHRZWW9MK05jSmtUOFhJ?=
 =?utf-8?B?YW1RTGVKSEhhWHpFZ0NMeWptK2F6OS9DVTNlYnh5dDMydXlsVWY0a0tuOGVU?=
 =?utf-8?B?M0tlS2sySkJrRTcrcHRadzZQQnd0VTNmb2RsNlUzNXhXMm1lVXRuektCRHdC?=
 =?utf-8?B?RTVNbFpMTkZSa09BQStzU3N2cDV6Z2ErTHBlTnVyMDdoK0J1dzRUSHZucFo3?=
 =?utf-8?B?UlpyelZ1U3ZnN0x5cXNtQmhjRGtHVFh3blNISjAwc1lnVzgvUk90TVh0MFpI?=
 =?utf-8?B?eFNkRVJyV3o1eEN0ay9KOWczcW9CU0ZGbmFYZDdDQ095K0RUWk9tbGxHTkhH?=
 =?utf-8?B?SGhZNWJLbHZZYnpDOTQvR2dvRlNzZHF0Zk1KOEVUcmJvSDU2QytBTUR3TExn?=
 =?utf-8?B?YjNWc1FBQzR1Z1BOTVNEVXFpU2dhejBaTXZYMjY0TW5NU252VzNhbXJEb1NB?=
 =?utf-8?B?L2pNV2UzM1pWZ0l2QkVxTE9iVkpaZUdKQXRBT3lVWGRRck5tZjNhbExRemdk?=
 =?utf-8?B?TWRwa1h2Z01iTWt5cmZtUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmN1RXphL2NielFJUHRWaW1NZi9yZVhTK0IxMWVEYU8xUG96cXlhanhrY2hi?=
 =?utf-8?B?L0NDcDgrNmU1VXByYTJ3WWo5KzBlNUJGL1F4amR3UFZwUzh5bkEvakhGUmhJ?=
 =?utf-8?B?TitZUnpid2FJUFJ1MGpsRHNEWnZoWHQ4Y1JnMGJEeU03am1HZWdhcjRCN3cz?=
 =?utf-8?B?aTh2SnFPNEZrNWNVMlNmTTM3c0sxazd1SUs0UVR4M2NZQUtzOThnYTMrT0cz?=
 =?utf-8?B?YzB6SlBVeGtpei9tdFVzbUxPUmNCV3dPZGJYNC9Oa21kRW1zVko2Q2dpSFBI?=
 =?utf-8?B?RGcyejJGcVBiVkRiTi9Xd0ZYUE9YcmwzL2hWb2l2QWN6a0hVUkdQZXlOWGVy?=
 =?utf-8?B?WHl0R3VtU1RiVXBDK1UzZDczTHhQS0U0M3c3RDJIWDgwVkNjcnpNQW5qeWlZ?=
 =?utf-8?B?Um5XVFlSb1NtWm0rQXRpZDI3bnNSczNEWTFHNUhQSVVmVUVGaXpJQTBlNXE3?=
 =?utf-8?B?WkhHTDRsUU0wclIvVHFNeC9tZWdsb29vZWU5UmFabWJPanh1SnR4MVBqUStt?=
 =?utf-8?B?cTRmcEdwVTlvMmNhOW83b0txRHpteEx2bTVhWWdoUjNWRkdmejVTcTNpQWlF?=
 =?utf-8?B?c2dWdXZ3dDk0ZXZUOE5VQWswK2IvcXc4OENjUVJtaG1XcXNBeHRZVndEMTBN?=
 =?utf-8?B?UW5mc0FpMFVhNmFIcmdibWVXNS9oVGhCZ2NyTUQrRzViS3FISEZRSjM2Zm41?=
 =?utf-8?B?UGIvTzE1Vnltd1pYang3MHpzQzBsamI1TVNQcGZIaWFISTRIVXlRS2V6S3Zr?=
 =?utf-8?B?L216UGpja0Iya0ZIcnlKZDJXRzZtY2JsT2wxcUJoNzFYZzZwaGZ0YkVnRnkz?=
 =?utf-8?B?ZTJpajVFajcwbFhIa1NXdDk3TVFCN3ZPTmxIcFduZEZ6QWFLQ0NLKzBoSEw1?=
 =?utf-8?B?WmZDR2ZXMkZESXpVOURzTWxkRjNIbWQ0aFZUSk5iU3lTbEJZeGxFTjg1N1pF?=
 =?utf-8?B?UGwvcDI1RzVpOFVOSmdrb2t5bzdTOGFoa2JMcTdreEprRkdKbDA4SzJDNUgx?=
 =?utf-8?B?bzZNRGFaaGx3VmNBRE1KQTlQNmZ3N29aMENQblZZZmRHVi9SSFQ1ZnU3NHlL?=
 =?utf-8?B?aU9VUEV4M2g5TXdFUkhkem5JdWVOU3VNU2pFR0VIS1g3RjZNOWd3SkJCRDk0?=
 =?utf-8?B?NFBUN3B0VjdLd2NPWC9sczZyTHkwTEdEVEFZT2RKaDB6OHl1c3NtSVRNL1or?=
 =?utf-8?B?dzZxZlhwUnd1ZENZQjBkK21uSXNHaXlrVUR5TkRtY2I2Mis4SE9JYTV6TEtq?=
 =?utf-8?B?OHordGlEZ3EyZUp6L2lHRTFvNEpWb1NETFZQOGpNbWtPcHJFN3JidWhENUdQ?=
 =?utf-8?B?ZGd6dmppSVZBbFVNMzNPWFJGblRxbHg5Wm5OSm1BSnlrZ0pxSmF3dGF1aXZh?=
 =?utf-8?B?VkhjWEdmOTFnVVl0TFhmU1V3dEZzcGpIWE1MaS8xb0NVZEszdVJBazlNTnds?=
 =?utf-8?B?ZTZ2cWxOY1pVYS9JTHVES1Y5SE05WWFVaUZMNEZZcVFDSVRqeGdDOWtQTFc0?=
 =?utf-8?B?WjQybDVqTnBzeFZhMmhxV0lJY3VzdC9vQUlmeGVWZFhIS2xOKzRYM1VLK25z?=
 =?utf-8?B?d0FZQ1RmNGVoMnV1ZFBCMFZXdjZ0TlZMTU1YY29uWmtWQ3U1Sk43YTRVMGRx?=
 =?utf-8?B?R21yOVJVcEhtOThQOEY3TG1oQWlKa0NKRkpOeUpieWFWN2dFOE8xbStjTDRP?=
 =?utf-8?B?eXRxejA5clI0MzFtRTdVQjZZV05GaGh3amJmeHcrV2FpNXdNMWNQNThSMUZl?=
 =?utf-8?B?K25MU2s0ZW02Ylp1Rmo0ZzRoQ0ozN3gwQjBIVWhpWmlpK0d6MndQQWJoR1lK?=
 =?utf-8?B?dDVOaDRjT2xpQUwxSWkwakxzUXF1ZjlwUVByT2VRbnBxZGMxOXovaFAxa0N1?=
 =?utf-8?B?cjJyZHV3Y0U1MTVIbWJmV1UvYkVsZllIeXd5RXFJeWtWTWYxUzA5OWVJNDRw?=
 =?utf-8?B?dnNSc1pmZGo4SHRWNkVEdEptcU9yVTdmV3Z6b1poV0FKaU5LZit3UXJmbGht?=
 =?utf-8?B?b3MvUmdjNUF6YVZtbjgvZkZJTlJkOUFqWXBIU0hjd0U1UUJ5NHVDTU52UHNZ?=
 =?utf-8?B?OWdXQWpoZnB0WEg4VVE2S3c2dXMwMjRsUE53cjlHWXBldEdqNjhkUVpRRGZ4?=
 =?utf-8?Q?2BDX6Gh4wA3NCes4wsr5NHhqD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NOyadd7Q4G64LktxppnrpBzRRPJbe5GRi6IheaCwTeC+nm4DLrlPyKF9LfiM3t16M41oaThT7I3B563vR5AFEKFvWslxGEuZQSzjVqSi/qKBtJ5ZK1zxp6NVOXI9W1t4MC6hi/A0LPloQE52YXKJq4VnlYmU5LSv6BidMcLfBbOzDGsbU4iVV0p09aLF1GqILa7W/c9rKshFA8Rg7MoTG0+ROL4Pwrgbao1SesfJ33/h1//OBxHwkEx2iCEjT80W4AMzQjbPgcZpg/k0hya/q9lxe/bsKSe4V4qAqFiGYcRMd0A6fwEwoXvfZrj3MiR5rp/mOBW5QVVRugLmeIKy9F1TpTRy057ijmpB8sj2nrwFpTpvs2p7ODlTxBdBW5ykrQ5hwHt0vKUi+IdaHvVYHnmCYJZr9JoxVm+FCuMtREZBkpZqcGeMVNAFC+gyqwjY6rWJxeCS2PpwJefqh0Wit//WOaCpaYy2rKhVjiNx+BJjZKvxRj8wNBcljxW7Qbg01PYgy8GEq33MfrXj2oZi4AKr3YpNm/OmosZK55FQ9MQpAcXjDu0ehcAskBtzu9RMkVyZZDfv8TPSty59Pg7fR6RnBek+gUgwP8oyCbZNjps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06533e6c-e826-4b26-78c8-08dd1a9fb028
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 11:25:31.6160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDxU5sztT37AC5YgrVOs02JvSo4oTE0DVDMdH1tTJK3I4MAAyfU4qlJN5TrlIxvHwYIKwUVxsOXZ8pwUUP0mSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-12_06,2024-12-12_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412120081
X-Proofpoint-GUID: xYf3exPiTsGdDuoRk3LX3n0ZZhXkT1SZ
X-Proofpoint-ORIG-GUID: xYf3exPiTsGdDuoRk3LX3n0ZZhXkT1SZ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_032546_684963_59F35ADB 
X-CRM114-Status: GOOD (  10.73  )
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

On 12/12/2024 05:52, Christoph Hellwig wrote:
> On Wed, Dec 11, 2024 at 07:31:47PM -0800, Luis Chamberlain wrote:
>> Ensure we propagate npwg and awupf to the target as well instead
>> of assuming its the same logical blocks per physical block.
>>
>> This ensures devices with large IUs and large atomics get their
>> information properly propagated on the target.
> 
> nvmet never sets REQ_ATOMIC and thus won't get atomic writes from
> say SCSI.  So supporting atomic writes is a little more work than
> just propagating the values.
> 

In case missed, Mike had patches for SCSI target code:
https://lore.kernel.org/linux-scsi/20241008020437.78788-1-michael.christie@oracle.com/

I still need to check them ...




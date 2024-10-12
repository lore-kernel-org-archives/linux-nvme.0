Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD53CF256E
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Oct 2024 17:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:References:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2OpCxr4ytiRRuSYLGO9rSyiQauBhtWo7/zeAQ28g6lo=; b=Z3rCvzuqeQmLaSr+EPgBnfayRh
	Dmeocer+mx/YNZbIqcG/YDsv9RCSOiCHzT8ydiKslzE3UvUswYzxOTA2Abiv35MHcNU5mUFbpBl1G
	a5aDRfHII9dwL5VYS2p83IAAuU140aPKrVzacdgQOqL0E5LhJSALDElJWRUpK4dW3NHi76D54AtkT
	rwBvwrzS5KgsFgrOQO55Wp0X8JIPBcvz+OQ9aZrklB+2Py07OkLD/x2+qlDR9JzS+2dkqZDrng82y
	FNqCkHC5a3dE31aNqc+KqC4Y6sWz/gI9RUGTy97ZB8AiZI+T0ghwPmVD48zn7JEOBtVtmdP+hGCHj
	UguW5t/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szfWy-00000001WPM-0NoD;
	Sat, 12 Oct 2024 17:03:52 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szfWu-00000001WOv-20uT
	for linux-nvme@lists.infradead.org;
	Sat, 12 Oct 2024 17:03:50 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49C4gNgO032449;
	Sat, 12 Oct 2024 17:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=2OpCxr4ytiRRuSYLGO9rSyiQauBhtWo7/zeAQ28g6lo=; b=
	kUIFTmjyhcUWulxt9Po/fXgXHPluCfmomIiNajUHusl67pos6pcbs8gX/jp84dQv
	uANNKa6uo3tRkouK8b372UIc6VsM/aFamI7nfGxXaMNlEsR70Iwgnxej4gE923KT
	MQj/v6pWlBXdh+Ej1ikxzXSmY44WJtzKtgDK4PsVw2i30g/vaVqbaeAjPyJHxlxQ
	NoMLdpjuqFGGdInphffQ83uhXA3jg9UDf42ED4tP3WxVSX2DBVI5PVKuvxl0jSAU
	5C5Stl/895gSZ2x1k0sMVVbxuwLwsuN50iWfVb+IVQeVAVpYgTfpy+h9obdMO8u3
	EcA6PmPjLIF8aSRTQkXRNw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fw28fvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Oct 2024 17:03:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49CC4NdS036092;
	Sat, 12 Oct 2024 17:03:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2048.outbound.protection.outlook.com [104.47.55.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjaven9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Oct 2024 17:03:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G77oaKHQH4MV9fDkD5HsHC+mnm2twFISYR1ULvhgUqSlH+Kh4zeBYks/hBeSU0pECL21UlQDkW6bbkc+AZBHndNfSVJvNxLZ1X/0bwHAzhKzvqiq8c7S9xNQgGqrLsQ6WjWHdQFoHoFbgL8qKrYNe6+LofquYYfZ29OOna5aTczQgFBMRaUBEdu9ibOh88AbUg5xhLOKrh90IZ1Hz2kymP8dkw/0YuONi/w3+sYTZPpEQCudQG5Vh52MYQCHZKRDB/yz1+pvylVs7GMGoWrIWFDjqWuLA2HJKXZmyRbfHccspZfC4omyyZxhM3CqZBGCo5xe4s77AhT6EqOPMBxwWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OpCxr4ytiRRuSYLGO9rSyiQauBhtWo7/zeAQ28g6lo=;
 b=cT87uoB8H9EPkWouzmqMxH/+kA3W78SAJGwBYtOeIEl4gPM+/vUAftEimnEKyL64BQv9rfyvwmstwWtQkBqAJZdK3ofjo/q2t20L5eDsKMEt++uHpQaAWzZrXEF3tXqeLYxMpRXZfll9nTd6QY9DFFsycMUC8Yb15/3DSLZDBSnq9nKt0ZOOQmQONCIhHNSz8GPWARF5bH6uHDvIXHokAk/l7HaNcp8Hxg2aZSSeqQ6EeMTFtYMNshrsR9fGMphpqy3w7BDuROHI+UKMr1l9mZ6DmZhuDCgOnh2ETm6O1rVFp8QPblk2NosTg9c7iIsbQBNLHEXYWjP/JwQNKnFIEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OpCxr4ytiRRuSYLGO9rSyiQauBhtWo7/zeAQ28g6lo=;
 b=x7vgEZeHl7AweY0HF4XFsZwD7ykPmLuDJCG70dLYJE1iTV3WrqzaOBlDV3gurj2DVjuTy2MnmuQ3cCdqVYu7+JMr2vfCZ1h203AYHAhcTw68qYEsYYCwLCO2ajgIeFBDTQC7GfdZjJxheTe6csPvtVZ8OLabAJbIIQQ7hdhb0ro=
Received: from SJ0PR10MB6430.namprd10.prod.outlook.com (2603:10b6:a03:486::20)
 by CO1PR10MB4611.namprd10.prod.outlook.com (2603:10b6:303:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Sat, 12 Oct
 2024 17:03:41 +0000
Received: from SJ0PR10MB6430.namprd10.prod.outlook.com
 ([fe80::e879:90c:8ea8:63a9]) by SJ0PR10MB6430.namprd10.prod.outlook.com
 ([fe80::e879:90c:8ea8:63a9%6]) with mapi id 15.20.8026.020; Sat, 12 Oct 2024
 17:03:40 +0000
Message-ID: <61fbb21b-c0cb-4267-9275-d4a94ff89179@oracle.com>
Date: Sat, 12 Oct 2024 10:03:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] NVMe hotplug bug in kernel 5.15 with
 CONFIG_INTEL_IOMMU disabled
To: Artur Piechocki <artur.piechocki@open-e.com>
References: <2ea8ff1a-dcd6-4829-a096-63fa30d92b04@open-e.com>
Content-Language: en-US
Cc: linux-nvme@lists.infradead.org
From: dongli.zhang@oracle.com
In-Reply-To: <2ea8ff1a-dcd6-4829-a096-63fa30d92b04@open-e.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:208:335::8) To SJ0PR10MB6430.namprd10.prod.outlook.com
 (2603:10b6:a03:486::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB6430:EE_|CO1PR10MB4611:EE_
X-MS-Office365-Filtering-Correlation-Id: 493f86b8-c9a6-4056-f49f-08dceadfd240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDZBMVh5cnVLYkxYZ3FWakc1bjM0VFkzeG81NE5TUmJCdFdhd2xyQWxxWDEx?=
 =?utf-8?B?YXVVNTdIMDZDckl6YktUVzlUNG15c2FhOFVRdWRmWWk2SGRCVFozMkV3bVg1?=
 =?utf-8?B?SXJ2QVFFeFk0SFJmVXRIaWJ0eEdtS2NmTnZnS042aFhXUUFXc0hRNUtoTHgy?=
 =?utf-8?B?SnVkZXBhM00vRThOUFp4RjNxNjk0MVMxcU9XRlNVMnA3Ri9EUk5FU1NsajM4?=
 =?utf-8?B?M2VQMndYQ21WN0NuSkFwaDk5VXRubkxqSjJwU1BXcGxRY1ZiVm5JalVCVzRo?=
 =?utf-8?B?QXJOalYxYjNYR2NrRCtYcjQrRGd3eW9JZUxhdGRBQnpPRWlIS3BxazVEbjlD?=
 =?utf-8?B?Zm1icGFFQ0dFSWZsckdRckFVcmpyUWs2NDhFRTZwQm1sOG5qUUdQVW4zVTZ4?=
 =?utf-8?B?cFUwNUV2TkEwWWNLRm1zbjcxT09pb09RU2tFM3duOThHVjhadyt4TUYvcjg2?=
 =?utf-8?B?Q0FERXF5WjlrVVc2eDBidmM2RTR2SUwvQ3FjR0RhSUR6akN2NHU2VVU3Tmw3?=
 =?utf-8?B?RVNZbFh4dVpwK1BzM0c2NWxWUHVETmUwMW92V29UbU44ZjhOSEcvZ3RlWUJu?=
 =?utf-8?B?ajBBY1k2cVl0Znp0ZnhIblF1SG1xQlBIMFBSeGNVWnRaOTVHbTMzVFBlZjdi?=
 =?utf-8?B?dG1UNmQ1RDNMR0FyOHVqZTUwNWZtZ0NIT3E0ckVDNkx4aE0zc2V3OWx3blM1?=
 =?utf-8?B?OHFZSkh4VFJOMnU4UlRtT2txbktGakRNeGlBUDNQc1dldWpjWVBBbTcwQ2tS?=
 =?utf-8?B?dU4ycytsb2ltQ0pVZGtJeTJKWXY1N1pOMUgyYVcxeVhmZG5IcC9meWxWS2dF?=
 =?utf-8?B?UjZXUDlBdXJXdzVFRDFid0RYWmNRdmo0N0dxMHVoZjE1RzdLY0c1aUNWZ0da?=
 =?utf-8?B?eE5yLzhuTHZMRXpqV0l1MFN4VS94RlJ4Rk5JS01ldlVtdnk2RUE3M3hJUjFH?=
 =?utf-8?B?YmpEclV4MEhud25leGZiYjIraWVCaGJNNTB2cVhURmRTS05aUStmQU10akM1?=
 =?utf-8?B?OEZraDlJSTZld1JwK21iWFUrK0x1WXpKK1gxNEY0MmQrUS91UkZLY3FtUmdk?=
 =?utf-8?B?cyt6S2Y3TXJBeGgwVmhBZzJKeldWWm1YZ3NiR0ZvQkFOdk1qeUlNMmc1ZVV5?=
 =?utf-8?B?cWpNdzQwYTlqMWxQSWRUYytsU1kxWWorbmhHVDNrbC82K09EY2oxYlU0Z3dh?=
 =?utf-8?B?SGthK0tnektYUDRpT3RKWnRnbExWbkZUZVBYeGMranZvRXRKN3pKZlJQME5K?=
 =?utf-8?B?bXRhZnpjVWZWMWw0TnduRE1PWmlZVFJiTURRSWpPY2R0L1pCb3JIa1BWYlYz?=
 =?utf-8?B?Zk4wSDJvb09rSHJSUTE2aHBDeExtNlNhWFJRU01iKzllcjYxYnZ5dS9UQ1Vk?=
 =?utf-8?B?S3ZsQTRVMHR6dU5udzlBWk5PRU9EcC93dnFqN3B2dHBnbUtpVGY0UlhSeEJI?=
 =?utf-8?B?UGRTNFF2YjZSVXJEQlFubEFqd2tHUXFtTU1GTFNCbGxVMSthRjM0RE04MXZj?=
 =?utf-8?B?ZHdhZk1za01IUWlSZ0RYWmJIYVl2Rk9LUG5jWHB0L01BNFVlVGkvU3NpazVU?=
 =?utf-8?B?WWVtWGdIWXJOcEgzUWZ0eHg3UEtSUm1ibzlIYVFaV3FuNkJHcXBNcEtUdWl4?=
 =?utf-8?B?eFhteGZjaXMzdUhta1cxN0UrTmFoUFA0RWlPUEV6MjhPZkJTUU01U1B4c0k4?=
 =?utf-8?B?UGhuR1FTSHlyN1BZVXNvOHBONXJJTVRIZlR2WU5nZXVCdE02MHRrcDlnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB6430.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REs5eUlOaG1uR2RjQXE5ZFpnWWFXN3Z3a05sL0xKNG54MnFUOFZ1Wk8rNXhk?=
 =?utf-8?B?dWM3SVkvR29BZHEvY2JySzZickpMVHhVVVJMVGY4alRHb05ySnRLWERPSkUr?=
 =?utf-8?B?UTNWUWJIbWJka1BpNE5HQkFQaFlNTnpiZFd1Rkppd0p5VkxtUFdMd2JscGlG?=
 =?utf-8?B?cENRMkNWN0R3aGZrM1d4TUUrdXZHNXFxMHl1d1JuSkYzNEFmZ25LSjhIMGpF?=
 =?utf-8?B?eFdDRjVvT0hrQ1JoWklvN29LYm5za2Z2QThCWWVFdzg4cUIyNFlrOXpvWDRT?=
 =?utf-8?B?M0x2VGo0dUU3MzRubWtQRDlQdEdqVjNDZWxVbitjSzVDbVE5Y2JPSmhmMFQ5?=
 =?utf-8?B?NS9lbTNDSXNaaXJXNWpvQkVIMk5yZkt1K2gvcUV6SU5BamNxbkloSVljeE1y?=
 =?utf-8?B?VTVpblhPOEV5a2thcTZyRkxuK2ovSGZtSTM1TW1DVFA3VENtaUNNMXRYWHNa?=
 =?utf-8?B?RUVrN2crLzl5bjM5WHMyK1d4MlIxazVmL3g1RXdrdm15alNMTjJkc2t6NXkx?=
 =?utf-8?B?MjI5dGdMN2cyVUkvVENEWmZ0MmJZendFRFBWREVlYlA4ektTQytsazFFZktH?=
 =?utf-8?B?b1RxQWR6MVF0emtSYTdHWFBHRnFiOEJVQjNTOVU1eHRGVTNpa2RTNTRKZkNM?=
 =?utf-8?B?QkYwSVRKY0JLSEJ6UjkzTzNKR3o1TG5DRm83ZWx3VjBqcFBVaVZEY1ZGWVRX?=
 =?utf-8?B?WkNrSEF3NUt0aXBDQStPbElDb256MjB3aVlIQ2ZhaTdhMFVqVk5zVEphMG5t?=
 =?utf-8?B?ZjdFRkR2SXRiemVFelN1QUdlSU5wZ212NHVVTzVlMkRVaFNJLzlzQ01QNnEx?=
 =?utf-8?B?WVZoZFNKTklSNkkzWmluVWhWNDFOMCtUVGVhMzVkaU5TZzE3T3ZLRTF6SGhP?=
 =?utf-8?B?YkhISm50eDIvV1Y4MXdaVTFlV1RQdVRJQjROZldXV2dyaVB1Ymw0RS9neGk2?=
 =?utf-8?B?cTFqM2tpeVVlQ0tUd0RGMXA3OG15bmNleWxEWUpxbXl6c1loTkhMaWt0WC9I?=
 =?utf-8?B?aVRJV2NOUTdqSi9KM2dNRU9BOGt4RFp4Q0Vpd3M0b1ZveStGYkZuRW9LcDd3?=
 =?utf-8?B?SGR6TGRtWG52VGpXZ3pIQ1gwcFVwSzRnbThacUlZRHdqalZCZ010WFUyMUd3?=
 =?utf-8?B?b3dDQzdRQStHQUpuWFMzTTliOVJQZTJMKzRVZW0walNDS00rUzdrVWxoTHEv?=
 =?utf-8?B?V21hZGI3WSttRUx1M01TelZHVmYxQSswbWc3WDVmYWs3QmZHbks5OFJjek5C?=
 =?utf-8?B?VFo2UURWWkdiWFcrQXpnb3RMQ3oxY3lIQjF2c0ZKTUF5YkkvQXFrbHV0dzZU?=
 =?utf-8?B?YTMrNWJyVnVSUVAzY1ZRakxMd3d1SUQ2L25WaUhyR1FXUlhiTml2bzVsSFRk?=
 =?utf-8?B?WE9KcEdIWGVPMTB5eWpaem5ja0s2U3ZTVmkxYW81OVlQRXlxVDlIeHhjMDBz?=
 =?utf-8?B?dVprQ21hV256aFRUVmRRMGlkRFVzN1JQOXdtOXFvMnNaOHoyd0VzZHltNlJ2?=
 =?utf-8?B?cy82dVc5aUhBdDEvbW1rUThmMW16dzNHNjZ4cnV1bDVPVzVoU0s4OUZZeiti?=
 =?utf-8?B?SGlVaHhJNjRDajFXSzNIMHN5RExWV1VhV2J1VytacW8zbXpkQlpxVzBIM1pt?=
 =?utf-8?B?ZUhrVWE5MllSMUNUeUo1S0x6NFFNdGRHTXdPbTdnV0UwbnpzaTBSWkVMaVFS?=
 =?utf-8?B?WjNta3JScDM3YTg3d240TzF3Z0FJTkxEclc3SC84WnNzLzZTT1Y4TzU2UkRT?=
 =?utf-8?B?Y3BuMnZUelFIdG1JNTJIcGpNcmpKZHErWXlPMWFBQncxeStEbnF6eFVSb0Iy?=
 =?utf-8?B?djQ1My96YVNlenB3TlhQRUpENkhjQVpzNkcxUlQ5akVhbFJRMUFmK21iL3JD?=
 =?utf-8?B?c2NQVFRkVGxXbUJPQlRCSDZuVXI2dk5PNEJ2bU50dEtmM2FBaVlQZmZwRmMw?=
 =?utf-8?B?NUJUSzV4K1AzbDhJZ2VnNWFob0U1OHp5S2hWcnR6WjROUkRoZUhRajdqRlZx?=
 =?utf-8?B?L01mbVpwclZvcFpQaEZYTVA0V2xQaFFyaDNDY2hLWGNYdEpGS3hrbit3V1ZZ?=
 =?utf-8?B?MitOS0RpTDh0UXJqSW8vZlgydkREbzhGa3poVS85R283amFnVXNMNHFDSnhz?=
 =?utf-8?Q?pSpX+u6gFzEvv06WN7nYIwByS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lfz14KSscPpO+n6Dm99NLSOCJ4hye4twXQnm9vUPeeWUw7UG4gvzwZbBuL6wv92E0FuGOUyxviFWpWLU5NqpYHn7Kp2G1sJN/8RgiveN/3andANgs5HdWN3gccP2uGZuZjylD/eyG7szkhfCeF+K263tYXPl2miA/6z489qx70JNCVUOM9kh6isq9sQkMq2es1BBK1CSqsr4d6QAjXZdjGtYvYQjdTrQbpR6CrvLYafdAyyX3cXj/TL/xSKBx234vMeGpqsTVJ+rLY90Aekn+Mm4ROyHeO5s3Yv2rdNGeWnq8CPBjHo6p+l4hxYaQz6+3kOM0PFOCdTKojDoOO4b9tQVUc9MoS4KnYQplhYoQmRY+Tgp8pGzjHXKM7wBgqtITUzZG0C8tSZBSYZah1G6aSRvSI6W13VURk/GuVSpnFD31t14RUHHFGhB9PRLrelsZqi0eRYZCa6enk0wBcKGXCejUVkARbbpyHq2BX51an7IXKMDBRv/qiRY12P8kBtrenXJbLgnRfbrLGhivtP/AvL6HXApDwV9zX3FGHwPU8B/HCD6SVdy6jwpN2/ymF+fRThRhd7EWQcKvXrFvrKoxd9m63+FDSR31rKY3vMHxpk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 493f86b8-c9a6-4056-f49f-08dceadfd240
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB6430.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2024 17:03:40.7666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jOq48YeTACV3S4su1+++8lw7v627pJBI5BEmwRbHEGMN0K1P0jgLKs5IVyOCZ7DoKNgEWa8LXmaas+JSo9VMSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-12_12,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 spamscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410120125
X-Proofpoint-GUID: dBh_gVsbFWkdOMWWJ1k8zqsjEr-GHse4
X-Proofpoint-ORIG-GUID: dBh_gVsbFWkdOMWWJ1k8zqsjEr-GHse4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241012_100348_660754_FE6BC226 
X-CRM114-Status: GOOD (  14.31  )
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

Hi Artur,

On 7/8/24 1:26 AM, Artur Piechocki wrote:
> Hi,
> 
> I am experiencing a repeatable (potential deadlock) issue when
> hotplugging NVMe devices on kernel 5.15. The problem occurs on a Ubuntu
> 22.04.4 server environment when Intel IOMMU support is disabled in the
> kernel configuration (CONFIG_INTEL_IOMMU is not set). This issue is also
> reproducible on the native kernel 5.15.161 without any Ubuntu patches.
> 
> System Information:
> 
>     Distribution: Ubuntu 22.04.4 server
>     Kernel Version: Ubuntu 5.15.152 (also repeated on native 5.15.161)
>     Hardware: NVME Micron SSDPE2KX020T8, Intel(R) Xeon(R) Gold 5222
> 
> Description of the Issue:
> When hotplugging an NVMe device, the system experiences a potential

Only for the sake of curiosity, may I have what does NVMe hotplug indicate?

According to the log, the server is a baremetal, not VM (QEMU/KVM).

Jul  5 09:49:11 tarox1 kernel: [    0.374071] Booting paravirtualized kernel on
bare hardware

Is there any method to hotplug NVMe to a running baremetal server?

Thank you very much!

Dongli Zhang


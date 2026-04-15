Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620D2F43834
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Apr 2026 15:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pDH6dfBrsMnuCQAWdfOKA3k8+Mts1J3VmEiLklH0rNE=; b=qBEzAHXWQPdsEfxYoDmcbFle1v
	14pE/eDVS80MkzxjNdqmFaz4U9iWxswf3a29vELBTrr5Zio5u90SKVubn3+GGzQmLHp2cmpSwUWVJ
	12vfsE61XkS6JwIDqlaxZ5tMWc8zPEywJsI7vJUfG3kZlC6EweLdMqAW3H1MFt34RSpdHSMczwtFj
	YLRvHPL4yEiep+hIKkKNTMXAzSADtcq7iV+PtKNH43s8zTysKH73HoeTii0VCdqlGGZ97TFMP12bk
	KKXq1spmzS9kavXQdaLEEpohc5Sx3cg2RZN84DEc5EZBmsh6bk28dvW+G5I5hg7kYWLadP6P2MjRh
	hFUTnNtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD1vr-00000001IOv-1wQq;
	Wed, 15 Apr 2026 15:13:35 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wD1vo-00000001IOO-1a7b
	for linux-nvme@lists.infradead.org;
	Wed, 15 Apr 2026 15:13:34 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63FCfTk14070003;
	Wed, 15 Apr 2026 15:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pDH6dfBrsMnuCQAWdfOKA3k8+Mts1J3VmEiLklH0rNE=; b=
	Q38cLkG9y3nJ9XgUaT2+77l/h40LDPnhTZUVm2FeR1HgoqEcJYEJLZQQ950qY9At
	apRP2mX+ZLR+QLAhTkvDeAYl16QOXOaiuWP0VhffeiDxcJq3CGRC4vFlP0BE5InL
	yREA/EB/1p9aGYttBLcPI12gjhfHNagx5jauV6gq2Cak3KyPlHDj/4AjXODNnotU
	RoHrVhtGnZhX63oAAerX/qlfzcxvW6Rpuq+RhDlDh76uCFvJWXyxH3icV5eCK0MF
	sAGSEA5Cmj9Tq2u/QeVU0GVyuwc280ijV9nRYF07dft/uuw/AT3tjDzNGVXlYLjS
	W+wN5mD2mv/c3n9lBb0+zw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85qddsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 15:13:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63FF9mTR015195;
	Wed, 15 Apr 2026 15:13:27 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dh9jqstq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 15:13:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xVKWZYpOi0+FDkGsStoeZxDDhd4T//EnpuiugI5CFfcWOtVtMjerLhN0hWYPloCz2xSle2M9n9FT7rTP+sSVGT1HdrVBLwVpQOZJnRqmiIZoA9ESswzNseNCKc8PXmF+pf3/iXydIo1+2PhRTj35U3Qo2i7FL2snY4R3iRcGQRE6NKGXwiDbWpCNyStWzbw7S6A6PchtJxJXTuz8kRkWpoyL6PWFupd65vr+hd8ITgRP2pGXiSeJngUgFyh+OAe+/6RKCZFKODXMziPYdeV7H6OhfHXfP8dQg52NJ3amEpDnqZQmkVqrCtULONrO921rIfTF0VHNLDk3oGMxX9know==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDH6dfBrsMnuCQAWdfOKA3k8+Mts1J3VmEiLklH0rNE=;
 b=LcK8Gkup0JtCpPGjT6SsW08kdzzJFUYSFVzcI/rnwvMq/re3MBHG0g9J7mJnM/BBUndViYdIQtiAc9/EwbbjNgD4aLGrdDwVb5Uo+ro0P6ugO4ZlG8zcnRCs3x8iwhfmekDlL8AQrILHeUzq+AhCn65H+Eg7aIehBi2m/yMs4tXT4rmPocjTsWwC+t/u7Yg4tODo4Nv5277mXUlMN4IVOOoZ9EWGTmc82cxvpvMCRNJd2YB5QksXTn/jiep6Ie4+CbOTE6MJ8wQIcEx+ERoU8anmHqGok4zyahGDYUjw/aceRjN0qy1hK7ccTPnU5ux8wzMFk72bnGOKWgmsKL0Zmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDH6dfBrsMnuCQAWdfOKA3k8+Mts1J3VmEiLklH0rNE=;
 b=CnChiaAyuFVNunN52IQACDBwuzs5oDmyFVzxDjR63vnUvPBHTyolJ5wzgl1ZnCm5+KJe+W+PWCBo6tie4iUDqCMYwZft9nP/FQo/EfU4AHvkSpqhkP1gj18KEXPGlfeD8pJdOq4slo7gEfa6hcOTmJMXyKw3X9hnZ/NdXK8rORI=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DM4PR10MB6087.namprd10.prod.outlook.com
 (2603:10b6:8:bf::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 15:13:22 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 15:13:21 +0000
Message-ID: <8bf1bc9a-a905-4582-b657-b5e21ad66c52@oracle.com>
Date: Wed, 15 Apr 2026 16:13:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-multipath: fix leak on try_module_get failure
To: Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de,
        nilay@linux.ibm.com
References: <20260225202109.447144-1-kbusch@meta.com>
 <8c068126-0b30-4d46-a07c-a4f975b7fa53@oracle.com>
 <ad-faFB43WBycLSk@kbusch-mbp>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ad-faFB43WBycLSk@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX0P273CA0044.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:58::17) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DM4PR10MB6087:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a9a6f5-be72-45bf-fdc6-08de9b018808
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: slR7N3vkVfY+/RpXKfZtS3mS8niKExasjL4QPPGAJuttSeYxAHN6xUwnZWo1xta05K6aRWchFhEo/7iYB4m4AJ6EaienQc/kQW6mE8Mu+6aARwFQibnMWSOWRQSqUHWh5WkGGp2m0uJLfDuA9bURSFdXymr3oGGo7DzxlkqmV11r7s8wzNOHC3hoYEgVZnLItBCgOeoMHPXXUTIvBO1eDc/X7lFYvT93V1Ngm280O2siYKyW0JBm4PME5Z9EtVuVbNFp13838e5bl9CMQGSsZ+v9Y/e+GsFU2OBZM0TO6ATF+ikavJ/tnfT36xJb7G6p+DOR6lTM80ZbJlvchWM0o33mLwqvxjBebm8qeVtl9D36muhM5m9snseQ0tYnhIt32NsQuzwjURBzxuQcWCqFX4Uo1VcuErkfUew65/cdz1pJOsGf6oaAmDHrXc2ZwBeopFr58X6TQaumK2qjL21f5m6lkHzsQxlcWHIzsFWBjTnBn37usY63qB2C3vCTApCWknXAVundi/Dpvdqy+lt1tTr2BnalfQk3u8h6H4G4yLRNcHACpRUPV5uR1M63QEZgKsiH4HvMvuFsGFX/uDWin5YOx+q4wpSTxC/DZpqTcS7l0JIpt91E3mf+TH9XU4kIRY7fqq1WFoirGaFxZkSdKFuDdKrK1Y65VY1EAbsDWFJedv4f3PHma7/eJHCrI4qePJ+e17vbHwcwS77P7zkMKZ/D9rFx2OOfS221OdymwwE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlZkY2hhOUhJalU5b3FPK1BJQVFEaGxUcTM3VEo0ZGxHQnJUaDMwajNpY3ph?=
 =?utf-8?B?VUdodGFMbENabWpuME05dWFPbVQyNlBNWkk3NnphRXpMak9IOW14NXBsU205?=
 =?utf-8?B?SHNJdG4ya2lKckFkUE1SNm1pYm5DZTMzb3FVWUw5YTE3bllYMlFrVU1GWmk1?=
 =?utf-8?B?OWYyNm4ycFNTbzBCQ094VjlsU2ZtYzJMc2diZUxKSWI3WUZYOE1GcW1IdU9m?=
 =?utf-8?B?Qm13cUZDQmRxbjA5cFNvTEdUSkduQVdkMkZ3Skx3ZFhOd3lKSVNjRVdaNWU4?=
 =?utf-8?B?aUlPMU1zYUZZUjZac2VzcGZTOWs0MGR0a1ROY1ZTQ1dLZlU5V3JUUGtEeVNy?=
 =?utf-8?B?YlFkaHkrQUJUemc3a2QwbmVSNW5uSGxoeVgzMDZnSWZhT0ZEVWZuQXorb2Fi?=
 =?utf-8?B?b21ZOEROOXB2U0ZaVUMyUkJ6Qll3Y1dqb2VOMDVsL0NwOUlISTRZMlVsVHNu?=
 =?utf-8?B?Rk5rS0FhbFRERVVLVktoUjA2MUVnekFlTGZrOG8yQ0hQcTBtZUFWamZPSSs3?=
 =?utf-8?B?MzR1V0V3MlhiWDVZVjlsR2RMV3VGdTZySG1DTUdPU3pFOHd6cXJRdDhhK01Z?=
 =?utf-8?B?NURXaVg2RWpwR2lEOGgwcDVKcmNkZjl1R1pjKzVIRzFqc28ySWtFb3VPYkha?=
 =?utf-8?B?UHZ4S2Y5aGovYitROVNneDc3QXl1OWNVM0tPbGNUamhiU05QSm95TzBNanVE?=
 =?utf-8?B?NWdxdHIzbXNWTXFzdDhCQzBRdGlkQzJxNkc5UlNXWGV0aXVKWEJIUjZMZE1U?=
 =?utf-8?B?T2FtQzFQMGs3VlkzWElXVi9PV3lmRWE4SlBIai91NzlXcWRvb1AyRStFZEZz?=
 =?utf-8?B?N0V0VW1tOVdTcXZ5blJXOWtQbmFkOVVHMlRCQVFaU3Bmb3J0dGhScmJiNEx3?=
 =?utf-8?B?YWoyZnBHckhPK3c1NTE5dVQyRlJJTDRCcTVMMSs0RXB4YTJjU2dYaytSU3Z1?=
 =?utf-8?B?b2c2U0w4NXpZNnJHWTJLa3FUemNQMktmM3pYTDNBMjdBaVBhdWU4elZpY0xQ?=
 =?utf-8?B?Wldjc1lYVEdENjNxQ1ZLa2pKZ2ZHeTgxMnV3dTJCYmMvODRyZGUweUhQTjR6?=
 =?utf-8?B?YXpmY3RSZVd5ZW5ISWVNcWh2UlNQS0Z1TU5IQjMxRnJnWkVEcnRpb2VjeUk5?=
 =?utf-8?B?dC9wa2NwV0dKQ3BqSlZ4UStRelNqU3QyWEcwWENFdWZtbUlzZzFnZWYwZ2Fk?=
 =?utf-8?B?V0h1c1dXRlhZNzhuSnpJSG91dGI2aS9oQ25UV0xEbno1empISFhKeEY3RkxU?=
 =?utf-8?B?VDFna1ZDSFBZTW9XUGU2ZktyZmRkM1haRFh3QjhRYmV5Q2VjOEd6STVGdUJp?=
 =?utf-8?B?N2kzS3lybUg2T2IvMENBbGJiMkpQU082ZkRkVTh6Y3RqeGxKNzJuUUFjbG5T?=
 =?utf-8?B?a2h2Ly9BVGtYMFlJanQ3L05nWU41ZXR6aXIrc09McHpNWlhmaEhHeDZUY2xX?=
 =?utf-8?B?ZCtjSUZibUJBQUFHOTVmZmVvMko1ZXE4eERsNEd2U1FPSi9HUGttcjQ4N1k0?=
 =?utf-8?B?Qlk0NkozYXovTWdLei9EbWlhVDdic3AraGpzdlgzOHMvT0hSZWJpdUZPa0dB?=
 =?utf-8?B?dU1SOTgrTGNKcVJyYnVVZndnVXEwVC96NGU1c3BGWXhrZVUrN09kM0RuSkJT?=
 =?utf-8?B?NTR6S2hXWnUySEpERFplUFl5dVczMXZrQVVBZUgzcGlIa3NZa0IzSkgzOE94?=
 =?utf-8?B?QjQ1aEdycThObjZ5UzNCbnZCeG9uTWhKNlRuMXYzamJyRmlKcmRQdUZaUE5Z?=
 =?utf-8?B?TCtwenRhRUhCdXZ1MjdnU3V4T2MzNlk3dE1aWU9ORmkyUndHS0phUVhGeWI3?=
 =?utf-8?B?UkpreFcrMWxzdW9KZ01xdUVzWlA3YmY3eDBhYVkwOEZRc3ZpdFBtT21odEcz?=
 =?utf-8?B?aWJRWDArTHdnUnRXWW5yR04vTkFoRFVhY1lnQVptYmM2RFoyaExPcWNFcXpm?=
 =?utf-8?B?Wkx2dllvaXBJVDlhcjIxTGtZSFhvMDJFSU4xV2dzc05EY3diQmpZMmtBNDIz?=
 =?utf-8?B?YURMU0RBRDA4SHZlY1A5VnErMldXRkI5KzQwaW9HNnFUK2wxYStwcS9ENU9o?=
 =?utf-8?B?cGJ3aEVKMUlYOENMcVNmSkE5b3NtVWVRVWV4VTRWY1FJbVNzTmxkTGhETFc2?=
 =?utf-8?B?VjE5TXFxa1lWdy9tdTZqd2ZXRU91V2NIMUZhR3RPaUx4Q1hIb1hYendlTlA1?=
 =?utf-8?B?ZG9RVk4wSlRBRVQ2NjJPTTVMbXo4NWE1V3pFYzRSY2praVVjTzRvRDV4blV6?=
 =?utf-8?B?Z2NsbFNNUzdyeVJlQXFlWjhFQUt5NVBrWGwwa1VHM3JPR3FBS3EzSjNHUnBQ?=
 =?utf-8?B?MStxdVZkWGY2NWJSblZEYk9VWndjcm5TT1RRSCt0L0Y0SlpNUGo3Zz09?=
X-Exchange-RoutingPolicyChecked: M+mXZKXze19ekSi0WUgfM4cYTson7wHp1M8SdeNEtgzwRRky+0I2cbSqWQbLB+ZuMaH/95xXTEbA0jrX/RtwmqveQC14GNC/ONt0hHXpXBuk670CvweKv8niucQPNqm1NOfjNV3mJfms5FjlDI+iG12CIUOM0fjOBj5xz8PSYpgGrbZ8YZmQ7tCz6eeWWYjPM5A6rTTmzbLhWk6LooE276KI0v7wx6FySoA6e0PpfkazHt5BEKMj0DBiF3TEKgCxmKCfFAlkEJhAkWwVlg2s/SyVWvL5mAvy4AJi7Wa22pIbDcec6eVt/mfFJ06VCb/CRPRYdKT1fS4lUiRO5hEm3g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gFwwsMaP0cyhv5QpvJaiB1Msl7D25cNGx4hVdXxkBY+Xp0VwgwX6eoaQnL1A2j2wkEOuGgNz2ba0UvBLQaKyn7sca3DUuhROy5LbhXTfDZxdD1wYK5aaSlbz52czutoqcOzBX8ELDZeb70lKk9sTUyCpZsYoN9ap2OdJazuOFuPHhlPFd4ITy9XGPyqJihMv8fNW4v9qnTB911ljNBwknM52AQkEOaRJnuylUDztGbdmfi2zzAAxfrybLuVc2NRuxSgh+1K7ts+q8I7a89n6RXiU+DcX5M41/6PpcyDyrg/g9Pf3AYHQW7wWT06iH5HMcYueAV5WCEqyf2/FHytnXJPuTFJi7tjNHkCP7y1z05YzUbdvjkjwL68G5NaLU7ptZva+L+Vu/5kSjwL7AienuI9UEVhDBEtqbeMglghV/lxPNAjrrfrRHv96VZR9ah9jx44pW0RAFVtvGrpduLygBBUDsjGaruNyk6qXQcxkYFqDschMQUfj2RKhZkN/GFMUjmXOzK9zwz9ifj8FeYNM2BZrUt3A/gINmOCam+ZHEzSA9f9o1ATvp4eYclcPwqkfX3JFOuSNjCG3lvZ9MpdPAy3LyWUtGYbJzyshNbpSzUI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a9a6f5-be72-45bf-fdc6-08de9b018808
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 15:13:21.6938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snkDV1/gk5rxwkhUcxjArmY4IujEfY5fTI4sZQx9W0GnZ9g85hPKCWWV8YviJtSeIx4W4bdGjoLJP4SyeU9QXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604070000 definitions=main-2604150141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE0MSBTYWx0ZWRfXyOX4KCrt2VYz
 MmjxuqV8/GoBkAQd3BOdX4rldrt1jhAmcPv5+p9xGnukPlh+EU3DPEghk+w3xbV9RDdtQimUlWK
 Oyo9j7P3eEINpkWVfl8SjxRDuxavte3AS8bjX7zSwoCpqb4c4DAYY//9RdT2sLZhYP8p6N+YXyx
 8kFqtLe6EgVoFWG+o9M/KVEye8cTFm6ME2H9c8RoCIrNCI6+WE1KIrHvS4AD8cw+xIuJRiWZ7pV
 YdR7+3k9GIGzK8cR6zHXZcgrpctPxeJpQWuRJru+RXyFou0E44QgIqo/giplZFdSb/R/RuK03Fj
 M78yL0TzHggRWGqql8BjPB2W5JNgr0Jc12eMNgenjimsDkPwu4sbqWpKYIHUTxk6epK0GSWa3hi
 FBxF8qPZyWoX5A+1UyItudPUVofyqIkfPVT+SjFfReV+fDkj8qfhFa1zKDLiNdFrMSmEUGzxor7
 /4edfqP55HI/rvyNlUA==
X-Proofpoint-GUID: UGzXeJJ2ykeTe4Q7jEpNfa3VbMw0CsFB
X-Authority-Analysis: v=2.4 cv=V49NF+ni c=1 sm=1 tr=0 ts=69dfab18 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=UyiHc9Ajgd6sQ-9-0RcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UGzXeJJ2ykeTe4Q7jEpNfa3VbMw0CsFB
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_081332_706213_4C7DFAF9 
X-CRM114-Status: GOOD (  10.85  )
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

On 15/04/2026 15:23, Keith Busch wrote:
>> @@ -4083,7 +4083,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns,
>> struct nvme_ns_info *info)
>>   	mutex_unlock(&ctrl->subsys->lock);
>>
>>   #ifdef CONFIG_NVME_MULTIPATH
>> -	cancel_delayed_work(&head->remove_work);
>> +	if (cancel_delayed_work_sync(&head->remove_work))
>> +		module_put(THIS_MODULE);
>>   #endif
> I don't think we need the _sync() variant here, but the check and
> module_put() look good.

Yeah, I don't think that the _sync is required either.

cheers


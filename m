Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33E8C83F07
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Jul 2025 12:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4IXvRQggST4mLrTZxfmafBomgJg7kNh+4j2njl40tok=; b=mNndMTLQGi35EFybYQ0QornNDH
	rKHdlhL1NjwUIPgbbBdJJ4CfT4VQ3wRqUaa4D05Ejkr3qqDMM8mgJ55uxwTZ7RyXZW83h5dxeXuN3
	RtbfCGFM2XP3BjCHBveI/+YwAt+v8EJN+BpSnz8Cdrj6kgiBP3jxRelEHRcpketdHLcbyCE0rKrHZ
	r0uiplLFSK8ZsrB6Ft6YaYH07G5cya0eA5aozq4nMWbDE2222IkbOEmJmVtT33GqpCZhHtcU4/XoU
	3vWv+7n1MAhEes4u3j/qI9j2IjbYo2rs/OEVP4SoGMsTDyWGieIfEocYyH5UahmDBNjKFU7R0h1BP
	OqttKB6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXJW1-0000000BPhG-2xw9;
	Thu, 03 Jul 2025 12:58:13 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uXIRQ-0000000BDIS-3OhF
	for linux-nvme@lists.infradead.org;
	Thu, 03 Jul 2025 11:49:26 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5639YxET001617;
	Thu, 3 Jul 2025 11:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=4IXvRQggST4mLrTZxfmafBomgJg7kNh+4j2njl40tok=; b=
	VmUzQsBrEXb35RNyOlEBZVEkuSvB0H++98AuJNu5ws0fviLsgpZeuzP7Uu24hEIr
	epkCRznURlybePwHP4OPkgxBhKYjKTqEG0vzGCjGKRsEoo8tNQi2TsBwXhR+dB5c
	QBsfFtwrkDhDBjGrlBU0iLPGb8Cp0CvGlOI+GCkJxWNcfBGGP+Iqv7Gd4GtpzHZO
	3shPgr1dMgOhaDbkaZEsasUqSPil1e1W9FLt3FsjNVA0hZzMQH3mwgSQcxSfoEU7
	8HeU+2BQXdZwr4cTs5g2KL4OMqHa40Eg7jkhMzj6qFZneJlbSpgeL7CkAear0uRu
	LoXg8sCNRd0suHpM2p9Lrw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j7af8u2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Jul 2025 11:48:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 563AEsFb019262;
	Thu, 3 Jul 2025 11:48:40 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47jy1ha5q7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Jul 2025 11:48:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGqCVIIuFQx5rMsxbKkSp4Ppc9ypvYLw7xQF+yf43xG3he//TzeLw5EVYUHXT3LAU6c+JYFdmmmZGudpxeSrZCpvBSIFY6MOB/zVroecZucXuBRJjUXVMjyxIt7CNtBT6112Q7Fg+cODTXngAPJzVKUo0t815LCaaKY9DLtdqDrcwaD8dBRx2MWh5Uiko/63qXvjB48DycoJvt94m3RsGctsPFtS4S0bxXhpqeqX65nb8719xc7z0byKN1pQjixJ1Yp8Uk4lBgZ0iGV2cLtKDlZVvuM6KdL2bA6o9yyB2yAfWL1Giwy2PiR+0U2MoxN7IpdoSfLDyi6pV1kQOJImFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IXvRQggST4mLrTZxfmafBomgJg7kNh+4j2njl40tok=;
 b=DinxKIF5Djv9SWTbCgR+r59kMFB5aodSnsQuX8Ypq3hgzUA+prEMdtle30M35g5+RqytKlMZ//Yr+K7+4XS4Z46iUQH79gnTFAMaPkMWgRYxOcNQ1hZtr9luUojKocpd6tx1duXp+fn8KuEkRqsX4mwbk3iq69RiJcDNxo0QVmf/p62LcGRfNBu9ZrfHTciI00O9c0AOePjJjnPj0yuG/rmMMf+x6wn/e2LsrT765FJ2m+2aIzy51UB4qPL3e8RJ/bNsOUjkxHwJqPJX5vT5SeX3cQP3gXSKIVgqyG7iUapEJmS0dww7K7KLAXBnGYvvVWxdntNvB9UOyhuYYiP++g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IXvRQggST4mLrTZxfmafBomgJg7kNh+4j2njl40tok=;
 b=gpNfiwRJEUECCcRK5e+cI504q0bIBX5e4+cqkH7Ahxm4f1tCPc9zvUhPSf968U12hsye1VNd6KRpXpKpmZgZNmIzHYiUAnoBcq7F5xn3Sa7ze0Mj8KOTnk8GO5n9D/7iuYdXsqKMq115ht/POsLJnYfLy9G1fMqOP88He5uFtQc=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by IA1PR10MB7417.namprd10.prod.outlook.com (2603:10b6:208:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Thu, 3 Jul
 2025 11:48:36 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8880.027; Thu, 3 Jul 2025
 11:48:36 +0000
Message-ID: <9d2ca862-d57d-4429-a31e-6f0f4c7c370d@oracle.com>
Date: Thu, 3 Jul 2025 12:48:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fix endianness of command word prints in
 nvme_log_err_passthru()
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, alan.adamson@oracle.com
References: <20250630162153.4040149-1-john.g.garry@oracle.com>
 <20250703114502.GC17686@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250703114502.GC17686@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0036.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::18) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|IA1PR10MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 712c395f-e397-4145-d4f5-08ddba278b79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajBDMzRrMXpXa1hEbXhKNHgxSHpmKzE1Ry92QkZFTTVMS21FTm9SdlNXTXBD?=
 =?utf-8?B?TDNmWk9RdHRRRXVvUGtXRk1ZR043dTBnWGRWYzBPWXpKbzFMcW1GUWJFN1Rw?=
 =?utf-8?B?YUV0aDdYVFVNMDZUYkVCMElIRElOUlJtdDhZK1lteThEVDNkZC83QjZmNVFE?=
 =?utf-8?B?bGZoNWI0b2VTSXA5UzhWbWFoZ0M3WGtCR1lSWEJPamNIM2tMb3Avb2NYNk1Q?=
 =?utf-8?B?V0d6VlQ4NENlUUw4THo0VHQ0c01IOER5a09rV1IzTGM2QysxMGpJUGN1OTZM?=
 =?utf-8?B?K0M0cko4YTR6NDdsSFdBdkhzenU2YVRieVByWGlWQXNlbFdoVEVEVFdtaERS?=
 =?utf-8?B?Vm9oT2tvZldqSDIyaVJ4WXJYU2lJdVVCcFo2cGp4cEEzYm94eG5FeW9CNyt2?=
 =?utf-8?B?eWRUY2ZHbHprVEZUT1B2Tjg0UzFHazBINmw3TmROMC8ydXQ0WTM3d3JGRmNa?=
 =?utf-8?B?V3MrQk1BdDA2MEl5S0NoaGlaWVBJM2gySjRjMCtMQmJ5ZlUwR2lhdVY4dnVk?=
 =?utf-8?B?R0JBT3lobkM4VE8zWm1SYlRqQ0NYRUtPYzFMNTVoRzk2ZU10NUVBdFZVRllJ?=
 =?utf-8?B?aGpEOGFXUFp1MVhrd0xFaFdiZlhGVy94YVh5L0Y4ZVpPVm9uUk9TRmxuTWdW?=
 =?utf-8?B?dlRkbDg4UXYwQ1dpclNqNXIzSXpwYlQybEo0VmZWOXBWYUdLZFFzTS9tUDdZ?=
 =?utf-8?B?OGhvZytBWThHZXkwWVAzYmQwaWFXL2Z3dWxPYm1WV01qNjFLcUpBelh2TC81?=
 =?utf-8?B?bDVQU2t6T3RTMFUvK0YvUmpmUWlYU0VNaDFvNG52Mkhmd1IwSGhGcTFpV3Zk?=
 =?utf-8?B?czhLK2VsQ2pRVFRkSUJ2TFJNZGY5MXBVL2hobXBCZDJXYUEvbko0Vjl4Rnpx?=
 =?utf-8?B?cHFNUmthdWYwM3owTCtvVG9XUEc2Q2g0NEFvSEFvZVd3bjNoZ3QvaFhKcWFr?=
 =?utf-8?B?OXd3cDNsWFNacjByWGRrS3ltekZoRkFDdlJyOVpJR09lYWRjUG1zT2ljcGVB?=
 =?utf-8?B?ejFObVV0OEZSZGlyZGlWVUZDSDJTMWVFNm9QeFkyWnRoRUE2N2JEdEwzczZE?=
 =?utf-8?B?bGRpQ081MDRhOGVoVEpJZ0NmbTZLOHA5N0VLYkpvV0FnbDg1aVRXcHZCcHln?=
 =?utf-8?B?UElnZzNIKzNFWXBNZ1JwMDMxQ2I3Sis0b0M2MDRFeDZzay8rWWRIVW5HUE8r?=
 =?utf-8?B?VmhzL2RUbG5rNlZVc0E2RjFLajE1d25QRFFYb3RBQkpkU0hsZWp6WWdIeGJQ?=
 =?utf-8?B?OXVBKzEydVJHWGRkbkFWUFBwOFNMdFpTelN0WkJDd0ZyT3dVUVYyT1R0RVVu?=
 =?utf-8?B?V2k0VWJpc2lua0RBY2VHZHNydHlidkc0UXZtblphS2pyVkpUb1FYV3FwdE9n?=
 =?utf-8?B?NExZTzlZR0Q1ZEtLMnlIVGdFOUc2WmU3bjZkdEU2ZFhVa1hLTVd6QUVHSHVk?=
 =?utf-8?B?VjFvSUJKU04vcWgzTnREWHRnQUltcXNsTkZWeFBnNHNFZ29tb0xIUGlOUkRI?=
 =?utf-8?B?aWFyR0JkTDF3WmdxaXVVbTFLanFvZ3hwN0pKU0Q3U2VJWW9RSXczVUFoRHF3?=
 =?utf-8?B?TGw0SGZwVVpSelJTWkJWL01QaVBkREM0eFFjUm91MzYwb2NvZTJVMGRlT1Qr?=
 =?utf-8?B?TENYdEFyRnFPdXdveHRtelMxbzcxUml0RUFaWVJnT3RmejJ6SEEvMUNDenFU?=
 =?utf-8?B?OVd4Q25nakVhTXJZeGZPYTlhaGhFdE9oWnpGcHlPTFY2Q25SVEZuSkM1ZUJq?=
 =?utf-8?B?YVFxb0J5b204VTlKWVhSSkpqaXhyV3pmaExDcERyL0gyZFJIOGVPQytOZlp2?=
 =?utf-8?B?dGhNaU40dks0bUxFM2ZJZDYvSC9wY2hzcGRNNkl2elh5MnYrOTVmV3RjYVpH?=
 =?utf-8?B?eG5ETDlvRDZ5RUpHc0JZdy9uU3Q1SGg0MktsZmlqVjN1Mmc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXpZOXVTUmpHU29QNkpNOStERzJzWGlCNGFUR1h1YjdmNDR4dkRiaURjbk5a?=
 =?utf-8?B?VmtmV2ZMVWw4MVJYWUlyS2VlOTRsWGNvaW9EWVlPWnM5TmM2MVc3a1g3S2sy?=
 =?utf-8?B?WEQxWjYySHJnRllkTDdCVHlyaFlLWllKQVNJcnQ2eVBlL2djK0E2V2MwWHND?=
 =?utf-8?B?d3lVMjNMK1EreE9JZkJPMDlhQWlIL0NKM2R5ek1PTFoxMURnMU1OdXo3OU83?=
 =?utf-8?B?a0dnNU90d3JmLzZmNnVVRVZpTk56ZzEyTUN5Q1E5Zkc0eEJGN2RrVGdHcDJY?=
 =?utf-8?B?eHE4RXFxbWxpbUxlTTAvbUlhMFplU2RBYnZNSXFFNXpxRnJzNFRwemg3RkFo?=
 =?utf-8?B?UTBDOUJXd1NrOHAxTFQ3OE8zN1Z6Z0JBbU4rZUx1MjhlUDB0MlQyMU13VVFq?=
 =?utf-8?B?clg0QjYydFRTd2lXZDIzM2tHQ0wxNThUQmYzTmJNN0FYVCtYWkF4RGZIbFli?=
 =?utf-8?B?bnlVREZZeTk2bWd3S0pORW51ZElpTzlqMHVMQk1OSWI4OFNQMHIydTBGR2pi?=
 =?utf-8?B?b0tzT3JBMTNFRFVZQzZqRUpybnNsSkpwdEdsZzJBeTZONzhxNkl5VWwrcW9E?=
 =?utf-8?B?NmNkZW9yY1JnTGU1RGZOVVdwUzdEZGJTRCtoQU9aWXFtYzhpNE9IRzgyNTBB?=
 =?utf-8?B?a3FFaEU0U1BobDB5bU0xQklXM091RkE4eGl6dW1GZ0ltOVg4QS9GRnIzanlI?=
 =?utf-8?B?ZXM5TDZtbHNVcnNGS01oMFlLcCtmREY3dHUxMFRUYlJlRUxhUXRzSU1NWEVa?=
 =?utf-8?B?akE4ZGh5UGhtOVJxS1ZVc0tIUG84dVRnODdtSFFaSzlKZWNreTB0c3BkZGpy?=
 =?utf-8?B?eGFsYzlMQkZPdUk0UXVtSVVvVXVKU013elNOWm5lN21ta1EyaTE2QllibHJp?=
 =?utf-8?B?MlQ1L0VpbVMyVWkvVSt3U21qN0hzeW5DcTV1SlhtcEZ6cU1lTzJKdVQ5K0pS?=
 =?utf-8?B?V25kU2s0a3U0WFV3MkZoWWc2b3ArS2J3UStva3NxUy9Pd3VEQzA3WHRGS2J0?=
 =?utf-8?B?NmQ1UXByYVJKUmdLL3ZoR2UyekJSdmw2UlI1d01zN2pra3YzblpmcVZFVm5j?=
 =?utf-8?B?ekRiNjU1cFRSWjN0RjVXVk9LaHh6dm9UelkzSTlYNjJoSTF5THVHckpMOUZF?=
 =?utf-8?B?NVBOcXVnbkxnemhVTjNOWWhYaHpZbXlUSnVlVDlsY3FMSldJbk4rYmVHb3lm?=
 =?utf-8?B?Uy9sMjFCc3cyaEYrRnAwRm5LdXdyOTFZWVN1N3hMVDNWWnFwY20rVUxTK05U?=
 =?utf-8?B?UE9XWUpYNERhbk12dlNjVjM1UWZkOXhyZWN0Q25UN2hXZjh4N2NpRW1kK2pP?=
 =?utf-8?B?VVBjRHJvb2ZZN2xwRG1VZ3cwM3l1bnl1MHh6Q0xtQkhmVURQeTI3ajQ1dW5E?=
 =?utf-8?B?ckJBcTNnaWJORWFHQUdQdC9HSFk1aHh5ZWtJU3lGWk1xaURzcGx2VDk0dEd3?=
 =?utf-8?B?TFl3T2NWc1pkYkEwcmt4c1QwTXg3cy9ETEdJRnZsdVN3RWlLNk12YmdTNXRz?=
 =?utf-8?B?Q2VTaFNrN3RYZlZmSmsxMGErVmVsR1hydGQ3YXpLL2h5MFI5VmhscENCN1FV?=
 =?utf-8?B?UFFCVnEyYmRaOTdUN0dNUFlxNkVZNTRVQkZPQ1dBcHppL2lWZ0RIUlJmeHN0?=
 =?utf-8?B?WFpKUnNUQzRNMVFqbEYxZzRIQjJ4cVhIZVdvQyt2dVNHV3ZPb3ovbko4dVkx?=
 =?utf-8?B?Z1FMMUZiUmovSHozVFRlazV6OW5lWmFQQmNwS0VsSXhuREd4YmZ3Sm9QSjdk?=
 =?utf-8?B?YXNObWNnbW4yRHF1cmxMbmo0WGNKLzR4VGRoRndack9Vc0d4SnoxZk5ncG9w?=
 =?utf-8?B?RTBMZnlnTDN3dlJIK2hQM2QvU2dna0wrcEtza1N4b2ZPNTFtVGpNcUYzOGw2?=
 =?utf-8?B?S01zN2cxSWpPK1J2NmdDZmRSbzR6UHZUTnpKSCs0aTQ5T1d5TEJTTUNMbm5a?=
 =?utf-8?B?MXpvOTEwanp6WWxRUmpQdlR3eEk3MHVFMWUzSUJvYXFvaUw3SWZpaHgzaXpk?=
 =?utf-8?B?L1JkTkwvY2pGQ3ZVQlQ2WVI0bmd5aVdsZzVETVlDaUFSRFZqVVlZVHN3N0R2?=
 =?utf-8?B?Q1Zldi9xb3BWVkJ2N3pCa1hYMUFYLzgxU1RQZjl6SnN2ZDJFZ2dOSjZ5M09k?=
 =?utf-8?B?TjNiNURxRXBXL0EzTWpiTWZvTXZXaUJHVkRieGhHdjMxaFlDelJmYkZMQnFT?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bSv9Wq+yMXamuResS/yaqu6gt6gU1HvhLUCHDA8D4c5ahMCozaEICqZQM6xFd41FInV0a36n40PeoAOGyW5RrlmE3XrQVv1zzGCa8oxAPYn9POuquNA6Bi3/H3ZdNGvkyg6KT4b/bN4Xmjn83y6P0Fy41a3n0bfQPiZwgu1X/FkrpyCNzCAwo5SL5mdRnNSkJzlvXUd8f/gkoPuhWis+BQ/v8+HtsHSJmgdBZiOZ+VidLmVvgoYY+iPoHPt199+F91S186vbSbXsJq9xbScmw/xSh43yVp8wyQ/F4jNFtJEuFhM+dUq5yop6/StnOeDy8ZCNbyy9AaM6o4MmM9uKjyCf6w1liZOCJ6gu9hauGZVvUxgEHRhFNUy9XQXTM38ZoSHHQSmGegFJojmqJ2rtDicF7oaLOHdtSTfdmYmdnkJmrogUxpOlHFPftx+JcnNBKs6rW1a2b7dd6jo3CKdRx8oKTVaeiAZpi0eoX8ligXplhoqvxeCYlEjA7rg1Hl/zX1MrtuvUWmBfpaKXgVbkPL3qF7pGoanWKKEnte3Dsc0mcOzq04CbDdSCJsc2oDxDEbOsFX+9U3R0HnluQG9pXY6sf35ZkjAnfFIrc3wWTMw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712c395f-e397-4145-d4f5-08ddba278b79
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 11:48:36.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBbmhgFBOTioGO5NJGmxBrqXy1EOa9hqsNefo/N4Hkhoc6or/GnlSMENiZj5MMxI1SPe5cd4kjOGpgV+j2Hg9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507030098
X-Proofpoint-ORIG-GUID: zAGUwzgyFwlKk6fVe372a_7JkoCl7xWc
X-Proofpoint-GUID: zAGUwzgyFwlKk6fVe372a_7JkoCl7xWc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDA5NyBTYWx0ZWRfX3IBcjvlsoxjG dZwWoZTR1sKFmZ9z72x0P+RE49JNELpHzDx1DyWEg2+88gXXWmgN40zlMwHIgbrjdbGMjHeocRE 79aeE9KZgV+FU+jLUVPuyHOvY8QJscnOBfy7/lFMYtizvD2WjsGZF8KHxakpZKjSAo0XDiBGdiI
 5pQLi/fqAPKqwKhsZeegpExHSGFBDxMz5ShEyIJLwlJyCeQTxqCEm9z8OGxhl5WDiidnL+jpduZ lqhlaO62+YvGANNW41QhNiOygMRpcdp9f/JY54mI8TSKoKbDlJGULoaErTTcdtDOtuNCG0DrBwo tSOgVTv7uLmKH5TOugmTITcxRmr5A3eEm00MnJtqFEI6ZQFbcaznIOnTJT4HjGHzUkxZE1jkrux
 gD30jCuF2u2MjU1Dvz9hY4ySG3A/0T5MWk8mnSqGCOrQs8+APKm4kkzl/PGUzuvxpag99r0i
X-Authority-Analysis: v=2.4 cv=b5Cy4sGx c=1 sm=1 tr=0 ts=68666e19 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=_z6vRzGqcVMz_73kQ1cA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12058
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250703_044924_854876_A93FBA83 
X-CRM114-Status: GOOD (  12.68  )
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

On 03/07/2025 12:45, Christoph Hellwig wrote:
> I tried to apply this to nvme-6.17, but it depend on the previous
> cdw numbering fix in 6.16.  I guess we'll want to pick this up after
> 6.17-rc1 unless there's a need to rush it into 6.16.
> 

I don't think it's realy necessary for 6.16 .  I just noticed this issue 
when reviewing that cdw numbering fix (so not affecting me).


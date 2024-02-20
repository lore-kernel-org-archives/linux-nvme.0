Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAB5C48BC4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Feb 2024 09:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6xbLIOf+iFYQjLuiytaMKWulerGgwh/uk5ukLUzM3TE=; b=s2znuxh7mW+6JveVRUGJk5Al5c
	xm7DVaPsDM+cvwsYAhA9B3i0TJI2GTPAz4D7+C+d+8dqahAr7E77WrBwqFdsGciwZkZ0IOqJoXTer
	FuzlIIa+InenBeCYHLguYE1oXWh5Uu+ipUHkBYihfJNxYrEH8tCGeguW25cCfLQ05kPir7mCFbPJj
	vwEwDJggG0ilDVkAE5IkdbU/21vUK3XHtfL6qC8HnAhgAc8UW+0VBwJKzp4dEpZu/0nEqenvcw+2K
	HyVDXW6KsKwUffG2nXddjA/3zMq34U/LIQfOeddW/CmVlPqRtAgv2sxUQ49N4J1VY+6tweBWR8/4U
	9vYiZ8cA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcMoC-0000000E6pl-3jy5;
	Tue, 20 Feb 2024 09:53:04 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcMoA-0000000E6oL-2u6h
	for linux-nvme@lists.infradead.org;
	Tue, 20 Feb 2024 09:53:04 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41K8wvR8031411;
	Tue, 20 Feb 2024 09:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=6xbLIOf+iFYQjLuiytaMKWulerGgwh/uk5ukLUzM3TE=;
 b=YLzjcrhHmWIUOemxzSLGMkhRu44o4ScIdRecfDOryKDICicjiF9ONlfrpwsHtmiH8EET
 et3182EL/uASGYEXrHoLWut7Mm9oCsHRXqL40hCMwKhQZOeVSlI2SrR8C5mRA46nihvQ
 KkTIDaP5kN8Ry5AP9s7+Lwg4KFck6Xv+V7Vglankw3kpwdRKJZ4WioYbz9XJfzUz6u98
 4a+NMaB0L5EYRC6++i+PUoRRFpQpofCJexrP77/9T2H0bPV4gLZH5QcqBMNfxfxdkuY+
 c0+/CCWMl1vsOGD9wDHym4ucgKkMgTQSAhYB6Y2JjnJdPPbxUoCPv3snvOsI9yfflEEU Bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wamdtx7nn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 09:52:48 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41K8COZp006673;
	Tue, 20 Feb 2024 09:52:47 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak8788ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Feb 2024 09:52:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRsx0XN9kIg9FLWb7MDlSGF8delteg0Bl3USInBF9sWgA3NEIiANLPkFHxZnv9ea5j/BjwBfvZy6lc0hHYcfCHZ9L555YSD8YUINIsR03QTGr+tleYCe3JAEHKK7iaWUwrDhfYoyV75YN5cQFWlS2WYiE9F8+3Xh2cSAtK3yeuP9A9KOMuTQeoxdShT9wgmszf+VshPZ3VDz30LJVwwYsfnCRfcmVVOHS8oAPQ6V0S6Nery6quzGSswBunFDXcYwJraPYIxZ09u2l7XROn1mHgDlm9Ct38IWDZtvKli7Nm4uZaWYMfM3dVO/EVbie7tbQcS7kovtHdbeN1TOoaySVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xbLIOf+iFYQjLuiytaMKWulerGgwh/uk5ukLUzM3TE=;
 b=HVfNJ3ajm163C5S9K3kkXclxIVHSrzD0dANmJX6K1UfFZwuajTBxbCEqeaRSc6ABPJgKs5rvqk9lfQWBDdsd1WPGjWtPN74jDDa6hPwGPkmN78W/ECarRf4YO5arMazmjgXyWWPG+7XVXjiAf2dt5aZDgoxf3Q01llajQtzi/pIToUsJy8k5aqNAd4M/rqIKZrjKFyvy3mh4Zhdki1VGOTzTwCudm6EgYyRvWAVHT31ZilNQmGHQtsHASOD5PtzeAqgS7uK3ohPPmjDb5etYlAexPgKmVQJjMDYYNX0FrFIZxQTt4Qob7BFm/qvbatclgsvuUjEeDP89tbp4WmWeHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xbLIOf+iFYQjLuiytaMKWulerGgwh/uk5ukLUzM3TE=;
 b=yrCY7EmfnWHWmei4DaXPqU4dhrMqRnmVLMAHCDr4/VSEC5LuADuH7atqcfNGHEoddA4AkhhY8stL4sa2wa9FAMvle++UHIGydbj1I2IDqJgyypg2Wh4WL2NkKC8L+w7+LgOX9szku/ot72FHB6MKLJyJuHeNVCZ+NBXV3BQNXXE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 09:52:45 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 09:52:45 +0000
Message-ID: <d6386903-5c9c-4d11-9d7f-05b0981bdfea@oracle.com>
Date: Tue, 20 Feb 2024 09:52:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] fs: Initial atomic write support
Content-Language: en-US
To: Dave Chinner <david@fromorbit.com>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        linux-scsi@vger.kernel.org, ojaswin@linux.ibm.com, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org,
        nilay@linux.ibm.com, ritesh.list@gmail.com,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>
References: <20240219130109.341523-1-john.g.garry@oracle.com>
 <20240219130109.341523-4-john.g.garry@oracle.com>
 <ZdPZvqLgwWSP1ppv@dread.disaster.area>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZdPZvqLgwWSP1ppv@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP123CA0012.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::24) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe495d0-8e00-4f1d-c6aa-08dc31f9b035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P+PcEb3JFNqLgAAFoQ+UoXW4pkfQHDjjz0/1SiSG6Mi/nNgLjlZGFWo562iZ7dQ9lsjF9gNWmq34ReG1vKhflzQhG/NVKzvYwfSjGBvKZcSw4KUXrC7OhjOSb0oBcHltbw+iIMkA9tX/y3lC/9OGI9SDSRpD/xR1NflHpZs29OLp0u+eU2A2xWdAFJUNlS/d8QiN/f8kKNmakwYLW15n//Byu0XhGf7RodVAxfaR6W8xHuCr0DmwKRyi/y25eu+u8XUHKi+iIa3ZAocvW28vf+vdQiOTz6l6smSixuTGWepvj9RowNrEPIrtnqSlIo5UuHrqqrReBEMBQmvfD3Dgl1loakMPQiDk93Q9m4Bx/tPIcU1ezyURJAtIerWVrSXHYDv90Onwomj7RPjrUwujZ+p6ZHGRzPxLJExMJSWs6oWRJjiE5HRRQvOddJagfNlXERYECpoFnM0WGLXPUG6Q1dn4M6zaKDmAMu/IpweMsLM5PE4tVJ52t6dHxWFUi/xMl3tE7+SGOcyf5VtN4Dh68KKfjolKhnVNNcPD1eDXyZc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3JLRlhhdTZSN0ptZFNSclJVZ0NyejRPNG0xbmNIWDVnd09wT0xHL1JreldH?=
 =?utf-8?B?a1RKUFBYekFEL3RDS3JZUm9rMHJUT0pKRHVsUVkzMGtRVkVGdSt5ZUpiaVhS?=
 =?utf-8?B?djNjemdIVjZtYmJPbldxUjF3REMyUnVaYXVjVlRyb1FjSUJncEdoTm43c2F6?=
 =?utf-8?B?Z0sydVNnUldhelF1dGxybmp1MURlRVZ5ODVQb29TMnh4Skk4QU9uZEhnMnFR?=
 =?utf-8?B?anRERlFiNWRlRDRBT2xGYnoydUxLdVVYdzNpaFNXMDRLaHBGSmJtdDBLejla?=
 =?utf-8?B?d25Ub1c5NWQxcHNZa3Z2Y2dBSkIxSnBsVlNXREJEaUpHRERNbU9MOXU4dnkr?=
 =?utf-8?B?VGU4S05pQzljaldPUUttbWpzSkZOVlRhMEpVSTJJM2ljQkdVemgxbnhtQk9T?=
 =?utf-8?B?WkdHaEhrQmo5NWU2N3UvMHJrcG5DWHZGSFhvc3lXcXpnQnJ2ZHloQ3Fta1pT?=
 =?utf-8?B?MVd6amE1dXBQUjVCRFdtYWdHMUlQKzV6K2tyNlFkTzQ2WVZ4MUpxT1FJS3d2?=
 =?utf-8?B?cFUxeU4zU29RbVV5MUgxQ3hHNVh4WGVaa3ZES2YvQWZwTkNxNEduYkMyQXlo?=
 =?utf-8?B?Q3dCZjJveHJjTjBwaEJtM2tKUk8vOW1ac2tScGk4elgzS2RWejZXRUN5SXBm?=
 =?utf-8?B?Wit0TXBvOEtwMFlKZnltZXRVSmNXK1VmOGVnMm9LcWQ2cjlQOUFZdGxSaDFL?=
 =?utf-8?B?bi85U1NweEw5c0cxdzRDekg4RTdWVUdHNllLcyt2RjIxVVIvNm1QUDFvUEhh?=
 =?utf-8?B?RlBwUWNhdDNqYXZYY3NRYkYxZHRGbm9NOHVQSHY4OW5tT051NFpDZWRySG1j?=
 =?utf-8?B?R0hZeFUzdXl2ajJYWW1xL3RFcktMQTRuQy9NZENjWTJPMitLZE1KT3dlYmtL?=
 =?utf-8?B?ZnZJclRWRGt3dGE5Z3hpeHAwU0M2OXh6b0NEUkpJYUdVU2lIaUd6T1RtZElD?=
 =?utf-8?B?T3krVmlvbmZKeUExT3VBV1owMVZES1lUWXlEa2t2NFM0aU93aDJlRnpadmYx?=
 =?utf-8?B?MitWQXNsek0zYXd5V0N3SnViSzNvYm4ycDRHTVdOTzhEY0NFeGc4d2h0NXYv?=
 =?utf-8?B?MWg3L3oxeHZoY0ZHUWh3c3UvWVVFZEtrNDlzSmhxZnlRYXlvd2k2elAxYjlN?=
 =?utf-8?B?YjhGQWNDa2tGMzhEVEtNNHBQM2RlMUE3eHlvZ0Q3eVZlUmJ0RERxQ1dZNmE4?=
 =?utf-8?B?SGZwN3Z5Q0pXdlBzWThXSCtlN0xSc3MySDc1bExQSlVjMlo1N0x2anNjaU80?=
 =?utf-8?B?VVBOWUw2eG1ta2cyanhjTlNCQ3pCd2xFR1FGdjdvY1prVElsZWR1c0JYeDBG?=
 =?utf-8?B?U3JhT1BWSmxhOUtYQlNBRXNoM0RIVGxBbkwzcC8yWUlnQ2FHbEpJT1Z4bisr?=
 =?utf-8?B?b1BkS25pTWtSU3JZbS9uZjB6WmdBTkZ5di9vTFNlaTdmbzlGZUJkL21nQlhU?=
 =?utf-8?B?aDA4MjNaaDVNSkIxbVFzRjV2K082M0xXTG9qdlgyU1I0S0M4UlppZ3FVYU45?=
 =?utf-8?B?eU9hdzdMVXV3c3VYQzRFTHg1Mm1XUXNYelo5UHJCdytZejBKblE5MXBBc3Jz?=
 =?utf-8?B?cm1UUURGTTkvTVc0alNUS3BWVzBudWtERmoyS0dKNHl4eXRuVWRodUl3dlNB?=
 =?utf-8?B?VnhKMmJqTHFhdGFIcHBHMUI5b0hzMFVIVFA2bUdEOGpFeEpFeStrWlZPMjFM?=
 =?utf-8?B?WDVwR1VXYVg3TU95ckZpZEpYWC9LYkdkMEFtWjVZcU9yOHdkMnpuK2RpL0Qw?=
 =?utf-8?B?S0ZOb21GK003RmlUVHNiWko2YUxjMXFhM3l1RDJ1UXB1bjBwRnVCZ090QVQx?=
 =?utf-8?B?WkVFN1ZxUXRaanlzYjZKWld3Sk4zYloyV1RBM0FrN2ZMd0lrVG5kd0xnZ2VI?=
 =?utf-8?B?V0dPZnlsdDZ3cTIzZjkzbHFFSnJKZUNBZjJGNE5qNTRsTXowS3J4ZTVZbFVM?=
 =?utf-8?B?dmR6RTJwOFhFWS9RMWdKejBXOHluSmdhdFBuK3pIQ09CSE4vQllPb3lMU0pm?=
 =?utf-8?B?L08xNDkxMmhpcUxIQTdtbzdmRTRyNHpkMTFnWUlKS2VUWnc1OG1uTDl3RFZ5?=
 =?utf-8?B?c2lXN3NGNm82eDZEempES0g5Vi9MK3ZrMmZWTHp1WHRyYS9XczVMRjYxYVBJ?=
 =?utf-8?B?MngzVldJN3dxZmg0T0dScWN3UmRsRnRMcFJ4aDNsWGhMWnlOVFJsa3podHpG?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xAmlg4n3Cp3GKC7M1exBAME1IXjkpZWo/+M5CrpgCcarONoBtsEI2kgAwViyia33mp+pUKkXvKSSxFUXkOKIvIUEg8iJoaWPxCX5fOjTU7BoacrIMXuhEdhA8k+Cukn50x5mNXBXp4LkIROYMiQc+XzMH2S8UBmY25be2imF1sKRZrU7M/SWpY1LC1e+WaHLCN620Wzt/JJ7A4bk/SOPhr/2vbl4lVerRsHrP7N64lensPdRyS51SoPoDB86PVk8jii6GztxI/bkhwMo6VUC1ZZAhggEm74aiYxVApmuoIwzj+LI2/fo563maxhA95U6eCPwFMAG0Jri4eIx2OPUdVVO/ayo/4RaLJZs4fy6g5NAGNf8NtfS6kuZRSs8b3EM/bDYTVgW+pgFmxI0Qez9FenMSWR5bkKZrLBvd8DBnwRLdmeQtqnLURtokiwGJh2yf+8C7VI+3TEc1nzaFiFKg1SnO10XaIxmJPDC8sllhGtlaGzOXS1M1DI6Mq6fbFADCiZkxmu+WX9UlJtf0f8xYcSVQ6lakuaOXfjilO5qXag96Ee8gubYRfrGpuIdSKPcHEz9Ct29dcEZssBtp2I0Bt6h1a2ipdiuWGkSQNcC9Qw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe495d0-8e00-4f1d-c6aa-08dc31f9b035
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:52:45.4607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f01YiXkkoHTNVZVZ+OlhjE7hQJwUsQqab3TfEN6yRwQ+4irYLG/26f7Tga8fjl/xo+fQ4p4gKBsVgcouJ1cNyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402200070
X-Proofpoint-GUID: Ob5PGtGLWuOs3FTXRFW4lO-MROxiJn2Q
X-Proofpoint-ORIG-GUID: Ob5PGtGLWuOs3FTXRFW4lO-MROxiJn2Q
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_015302_989805_F820F69F 
X-CRM114-Status: GOOD (  21.92  )
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

On 19/02/2024 22:44, Dave Chinner wrote:
> On Mon, Feb 19, 2024 at 01:01:01PM +0000, John Garry wrote:
>> @@ -3523,4 +3535,26 @@ extern int vfs_fadvise(struct file *file, loff_t offset, loff_t len,
>>   extern int generic_fadvise(struct file *file, loff_t offset, loff_t len,
>>   			   int advice);
>>   
>> +static inline bool atomic_write_valid(loff_t pos, struct iov_iter *iter,
>> +			   unsigned int unit_min, unsigned int unit_max)
>> +{
>> +	size_t len = iov_iter_count(iter);
>> +
>> +	if (!iter_is_ubuf(iter))
>> +		return false;
>> +
>> +	if (len == unit_min || len == unit_max) {
>> +		/* ok if exactly min or max */
>> +	} else if (len < unit_min || len > unit_max) {
>> +		return false;
>> +	} else if (!is_power_of_2(len)) {
>> +		return false;
>> +	}
> This doesn't need if else if else if and it doesn't need to check
> for exact unit min/max matches. 

This is fastpath code, and I thought it quicker to just check if min/max 
first. Based on recent discussions, for FS support I expect typically 
len == unit_max.

But I can change to your simpler checking and later change to the 
current method if those FS assumptions hold true.

> The exact matches require the
> length to be a power of 2, so the checks are simply:
> 
> 	if (len < unit_min || len > unit_max)
> 		return false;
> 	if (!is_power_of_2(len))
> 		return false;
> 
>> +	if (pos & (len - 1))
>> +		return false;
> This has typing issues - 64 bit value, 32 bit mask. probably should
> use:
> 
> 	if (!IS_ALIGNED(pos, len))
> 		return false;

ok, good idea.

Thanks,
John



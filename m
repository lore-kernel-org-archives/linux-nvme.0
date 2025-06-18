Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537AFC77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Jun 2025 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mItC/PN/Si1t/dFM4UKGSxExEYD4+yB7Tee8rREl4jY=; b=Dvd7mHYOA4NM8Sk78VA0WG/Cju
	8ywN+TRL5SKt2rkqDAV2dPX5cngYdE+q3pdb8sMP0nHo4DCH5bL6iOJNls98KjMRWZ0atYACTlU8V
	a0p6GsBuwsAaRq6Edb4YeSq6YNoFkYiRIL/LLfFnBBAgSu6/+FYelOUi2S8N8d+UKLT5jUmxKNnC6
	uKkqdUEj9QY+s0bhPZJ2F8/KM1pWRQP/T1ehLZdN3kOQeUMoUjRWwZeREHl1jRAEreUoAok5N7ebI
	lE1EN9tRnLRFN69ubxqMOXXvomeN5HsVdDFPLk3Ns98T0xUAfAquMFslWe/BRlw+EwsW9WqSx5+nf
	A6k9Shqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRwSM-0000000Apux-1hiZ;
	Wed, 18 Jun 2025 17:20:14 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRvKO-0000000Agyc-2ahb
	for linux-nvme@lists.infradead.org;
	Wed, 18 Jun 2025 16:07:58 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IFBfYt003625;
	Wed, 18 Jun 2025 16:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=mItC/PN/Si1t/dFM4UKGSxExEYD4+yB7Tee8rREl4jY=; b=
	MAU/h/KXGE0k1323RJ7J4V6rwHudZ3v2xwuwnrhtm4ns3HrvbprG4/chWMRWdGnz
	7A3YkxiYkRXYW37qTqRhlTv5VIYlbnE8enXfQNWGz7XhHqhxGRwSOWU4tCUbkEnf
	qsA0Xd/aHEVaKqvcrfSMkqu5RK9uq04qnKObJFgX7tQMmThWca6AXJ8XwD/xki+P
	U2OPIOkmnqLxKcwX4O0xexRUhj8M8aayZq9DcKpTge1PMa/PN/YRHSFifMUo5Bkf
	ryY2HtXopmkzepLlDlYyoCnCBRSSvTnydoE7fkHmaB3cZeRwGxsHIvROZbip0r1P
	nRTAb8c0Usc2BaXqfIjn1g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47900f0715-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 16:07:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55IFFw1B034480;
	Wed, 18 Jun 2025 16:07:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhakkyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 16:07:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tymbQQOxCTpTlNP1TA5N8hnXinyaY0Z3pWnwG4l/S4F7Q+VFYZfy2tNdXXvNteS6qTERPjbuQc9Z8kdhx/yaBhSReT6e0W1QAytYtKHmPc7TE9fafN4BTGPnFjOfoLUYFuDlX2cW57F32HSVuWtM3JFwJXw7xaCSrtVuFE/+y6S2+DxqbdX2Uy+aEeL2kintbTaueUKN1PXbNzpF+sS3cozB+NNWzyaPEl4sQ4uWBEFQWIhivWJ6dS9F07iFQB5FnDJ492vcVj5z246cYrE49WRblxKDWEC198gytv2R2NBoCC5GHqukUme/qXYQjAySDvdu/xU0VMsIE8pNGmTjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mItC/PN/Si1t/dFM4UKGSxExEYD4+yB7Tee8rREl4jY=;
 b=WyOv+Z8DLuBVab+JOylxO88MI4TGIdwD6Gx0E6AiqhbGZ8HeGirMg7jFuaB8jGq1pRmuqFv4As/i9Hj+a2uZfhUy0Ophido5JtaR0tiLNjbklro/vSdbsS+maI438JQehWXZhw5jV29rUoWCZ8MVibyF7V0bsV9S1FjvR5hf+d8F2HOjuElHJ8bk88lknwQ8ir6GZXALBIPv6C4HIEP+B67aSFMFfcCEkJRt9oendPLeu9sT6fu9E9pSGfK7TXINLFg6RmKly9RRC1mijrOqLlgO3hAFSP6xzbzWZJMysIP3j5bN6oRvW3lkY/7vecUVr7MytFeAUMlV/QHavFu5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mItC/PN/Si1t/dFM4UKGSxExEYD4+yB7Tee8rREl4jY=;
 b=vuO1ge8/sjxu82Yt/rR/SKgCqHIoYSKKIHajAhGSTQcBZgqs/13C85wDw7dOujBPstKA4EbYXzZ8ewQTJMqasJ369af3b59nvGgnpIYrPIdYbBhlrpHetDadMK8ksNSNhYNsgODG6nCC+n9o/KWHr94j5wAOB3pl4oBGOjSEOh4=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH0PR10MB5820.namprd10.prod.outlook.com (2603:10b6:510:146::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 16:07:43 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%5]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:07:43 +0000
Message-ID: <9d0692b3-4d49-443f-b6f6-b13ec9a44f3b@oracle.com>
Date: Wed, 18 Jun 2025 09:07:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: fix atomic limits check
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        John Garry <john.g.garry@oracle.com>
References: <20250611055432.2401372-1-hch@lst.de>
 <99248994-4d8d-4d84-9279-b657d6969aa0@oracle.com>
 <20250616053627.GF1148@lst.de>
 <790a0419-4087-4181-b290-15db01ac1d34@oracle.com>
 <20250618053213.GA28614@lst.de>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20250618053213.GA28614@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::33) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH0PR10MB5820:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bfc8dcf-36e2-4445-fcd7-08ddae8241fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QXZES3hub28xbTdKdUx4cURnQVdia0dsVmRyTXduQUhOOUMvVEgyTE1vZGNh?=
 =?utf-8?B?M1lZYnZyRjB5OCsvWHBzejI1Z1V5Ty96QjhDR2tweUZTNzZoQjRSMldPSk5Z?=
 =?utf-8?B?RXdSOUtZYWFuV1dEQVk0VUVUcEtrLzJmU2h6aGVpVGZHWklUdGxVeU4zbmM2?=
 =?utf-8?B?alE4TVVUcml5MDAwQUszc0Zzc3lNOURUWGlTMURDU3NEMHExanBnR08wR2tK?=
 =?utf-8?B?endYMzVUQ1dPQ2dBcGZZU1lqRkxEaE5CaWdKdTZEUUgxaHdEcW90U2M2RWxx?=
 =?utf-8?B?cUl1OE53NmJMNzlweThZcGtFbW9FT291L01vdXl3akFUaHVVaWZORFBJbGxv?=
 =?utf-8?B?S1BDeTZrc0xNWEY1bkR3c01CWEVibStYeVlzK3o1TFZWQUZ5SGlHRXlsblJu?=
 =?utf-8?B?ZFFDcVBxK2c3cmFQdkdKZGdGLzFYS2Q4SGZpaHZ1QWw0bm1kRy91ajZMQy9O?=
 =?utf-8?B?eGY0RkZIZEZRWFlWWUthN3l6enMvRGVGRmV4YUdSbmFiNEhLcW1vWTZ5a3Vu?=
 =?utf-8?B?RDFpN3I2MnFUTEgwdWh3ZGRrZUNPc0VpdWQvVjdQVE9IQlRkWEl0dWs5RzdH?=
 =?utf-8?B?aWRyZmpzYnkxdHJFVUdYZEFCL29KcjVZcFluazFWQzZkL3o5TzRDSTFFbUpv?=
 =?utf-8?B?TktMU3c3UlRoSkFaNWVSYm4zTDFPNHVPSmVyOHlMd01VNUFpeVVVYVBwSCt1?=
 =?utf-8?B?Nk1Ednk3NW1iS3BQaUd0SzV6WElVL3NLQWhKY2FQazU4OWFSV2NyNEM5Yks5?=
 =?utf-8?B?Zm43elc5V05yaVM0SG9kRmtoem82UmNrUzNTd3Rid0FOSHY4R29FS2dEaVdj?=
 =?utf-8?B?TndtNU1pcld1czg5dHR1VEdqUjgrRWlYRmZIc0tscnEwRysySG5zZUhGUTkv?=
 =?utf-8?B?MGVkVURGR1JFeUJyK2M3WjJuQkJpRkd0dFNCOFpYVmptVmhtTWI2WEYrU2Qx?=
 =?utf-8?B?M3RnSUlLdGZNWkNYaDdYL1VaWXlpdW5UZnN1QUh3T0ZLdHVWMFZtczA0eGRv?=
 =?utf-8?B?NjRtTEZlT2F4OUJEOGVlaGtGS3ZmYU5CRU5xUHB5TDFCVzNBRVRmQmRiNjJk?=
 =?utf-8?B?WklMU1VDOVpiS1BpbmZnd0k3UVY4c2hIN0NNRzVoeVZYK1J2dk1jeHcwZ05v?=
 =?utf-8?B?LzdPUnk5cHlTL1A3bVg3QTVMeEdxdm1vRDhPaUlNWnpoREJHZXdhVmxqZUZ2?=
 =?utf-8?B?OHNXeHNhanQ3eXRNd0RKSERFdEZCdDhVMkF5b1RxSXdtb0VZaS9zTU1HbDhS?=
 =?utf-8?B?UzF4NCtxaVRwQncxZFlNMnlETEU0NlY2V21iS2JzOHozeWZmbmh1QlN1V2tU?=
 =?utf-8?B?QTRTWGhRMmJoQlBVM1ZleHFyM1VDZ2lpem85Ry80VmxKZEdCS3YzVjBJSGUw?=
 =?utf-8?B?d1hZdVh4L3llcEtMZ1pUdk0ra0M0TGFXSi9ZUVhqSGx1OThudG04Q2dGekk2?=
 =?utf-8?B?TEt5OEliY2JhbHFBdldZM3hTa0c2YVAvRTkvZ3NBL0R4VTRXVDBjb0Z4bzQ4?=
 =?utf-8?B?M1FMME5lVndXYldOVklTWCtmSURoTnBDVGNBSE1EbThrV1Btako1ZHIxekpC?=
 =?utf-8?B?U3djTHY3ZFlTOUJ3QVBSbHVOY3RmeG0vZUwxMEU1emV6K0FzbGV2SUdRbzNN?=
 =?utf-8?B?MWZMVUJLZWhNS1gyWXE0cTVkN1RBZ0d4Y2Q3S0ZvSjRpZDFPR3FjN3RWRGNh?=
 =?utf-8?B?VmpzcDcreWFJMXZPOVkzcUVHdUZySmNkMURDQWQ4UHUwSnlwQzN1S3RjMGdv?=
 =?utf-8?B?ZndJMktESlMzZUpJVWpLVGFmZmJ1VXY0QThiSnFyc0pBdVBEVTFGL0hYclM1?=
 =?utf-8?B?VzNjVXBxSTZzMnBJdWJEN2UxaDllNERzcVlIZWwzckpnK2paSnBVWkFhTTV3?=
 =?utf-8?B?YkpKMlNydmhzRCt5RWJRanpoTDdJMWR4RVIxeWV2dnVGeEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3VRVU83MEhVazBtczY0eWl2V2ZDL2lwRG1rd2ZLMklxTG03Snh3NVV4QmhT?=
 =?utf-8?B?M0tYRzBLakVKRWs2R2dieVMyL3NLUk5qcGplM3pPb1JNM0ZGRFp4bDdwYkJ1?=
 =?utf-8?B?Uk0yeTF2eURsc2xiSk56QjhmZzJaalZVMTFYWkNyZlZJcDVidmxKRG82dlFw?=
 =?utf-8?B?M2pQRWp0QitCKzJuSGNLeFZFWTZORy9IRjViajFuQjRodzI4RFJPK0ozOFhO?=
 =?utf-8?B?Y29pTGFlejNmR1I1ZDRGUHlOcFdIM1lYS3RZbGRaWGRuc2FvKzNMY1NDenk5?=
 =?utf-8?B?bDVFbEZmcVRubUVESmtiSHA0WmVndDg0WGFZNml4SUp6N0taUC9lalQwUVMz?=
 =?utf-8?B?MSsvT01hZ0lWUDRDY3Q1TnU2ZGVLb2tQUU1MTjdvRFdrajZvVS9RVFFxYzcx?=
 =?utf-8?B?NytsNVhlaHQ3Sm84M1VGL0dadkI2Zk9IeTcrd0pQUHdpclgxbnplQll2WFI0?=
 =?utf-8?B?VzBkSVFaOEt2VlZoUWUxTXQ0SHdhQ2tHOVVXQWtxM2I1K1BmZ3l0RVc2aUUr?=
 =?utf-8?B?TVY2UU9xUkxEQjlEcVlPak5SWWc1b0I3a0VRcHhlMkZFT1gzc3pKa0h5Y2Jt?=
 =?utf-8?B?VjhmV3RHai9VRDVWOW5HTzAwUjRKRDdPcHUyQnNmcG15dThqSDJoQmRYcFkw?=
 =?utf-8?B?ZDhKNG4yZUNlSEdlSHVVdzJVek5JUzBVWTBhNk1TT1FnaWZ1Q0xhWWx4azVE?=
 =?utf-8?B?SDRrV2lKZXBlVlN1ZXdZZVVoZFphc1B0b0gwaXBORzJiV29sOXdIajhubzZs?=
 =?utf-8?B?cCttWmFndTdNTjJBWEtRS1Z3bWJRa2dvTnhlek1mK0pTWUowc3dncnowNUR2?=
 =?utf-8?B?d1ZsWitYOU5BWmFmaWFFdXpObXFWVzZwTkpNeFBEaGZTazdVQi9URld4L3hU?=
 =?utf-8?B?ajFkZkRJaThyUlpVZmtPaFNUMnlRUHBmb1lvNmljTk90by9EZFAxU3R5dTVX?=
 =?utf-8?B?NlI0dlM3NTVMa29SaDlFLzBiQmhRcTBVRGRXOVhUZERjKzB0ZW1kSTcwVnZp?=
 =?utf-8?B?U0JzaThVelg5R2lGTys5MGZtbWZjMi9qdVJmZGFKaHdjNmpNRVMwVlRXczVw?=
 =?utf-8?B?b21HaW5aZzM3OTFPWlkweTZ5TVJJVWRRM3FSN0FzQWZGRVVVbkR0dkxrUzdw?=
 =?utf-8?B?dTEvZWJUakliazBWUTFON0dxL3VlbmFRWmlQa05yTWljWFVtcVF1NlBmeWZi?=
 =?utf-8?B?cTFuUGFkazYzTi9yRE03RjRPRXBYQjQ0SHRQOUNpeXplQnlmSVdxRm1nR1Nx?=
 =?utf-8?B?NjI4a2x2NkZqd1BNVUZyaDhSNUlZYy9vL0k5MlVHaUQxOGd2YjBGK056WFY1?=
 =?utf-8?B?cU1DSUk1bUUrQXFpcE5xNnJrQ2thTzJpMkYxbzZHY2hVb1ZVQkh6dkVqeXl5?=
 =?utf-8?B?Qy8yRHA3UWZxQzJYa3ZKczZFUE5TNEJ5dzl5UzRTVERuQjZPZWExQ0JoQWQ0?=
 =?utf-8?B?LzlROXVXaUFla1dGZzR4ck85VGRFU1V5dVFXUTA5Q1NORldBMC9FcmZybU9I?=
 =?utf-8?B?elpad3A2NmZtMkQrbzhNd29xa0xuNUpyUFFPT3dMc3ptMkVYSkJFVnN4T2VE?=
 =?utf-8?B?bFh5WFFIemJoTWN2ZGJkcUZkNi83SjhKL2o4WUZmVVFyL1dpK29lNzFkVDI0?=
 =?utf-8?B?OUxKQU0rZTdkS3dicHZVbXZwdmtVUkRxUnUzbC9SSXpXQk8wRjVEdkNDYXpP?=
 =?utf-8?B?czh2R1VTdTc3dG52VlhoeGV5M0crNjNJaG1uQWo4WTB0U0ZVYTUzcUd0bTRM?=
 =?utf-8?B?NG5GSTV3djhvUWZ3bnpPc3JpYWtlZ2sxVk02NXV5MGVUSU9NcTdxdE5FMnZ2?=
 =?utf-8?B?UzV5UHVMdHBUZEExTzhoMjdaVFNqUlpHZUFtWERabGRpa0dOaVgyWnVwVTky?=
 =?utf-8?B?MXhFZmF3aUxhR2hYa2hsWVFtdS9EcEFaeUxsTmNTT3k1UWZCRytBbGhyd25E?=
 =?utf-8?B?YWR5V2doRTdhZ05tejl4MVpmRW9sTkwvUFA0dUYwQkh3Q3JsNEtIU1hqZUcw?=
 =?utf-8?B?ZXovejZNNmtkOWcrS3h1TXNFSDl6RE5uSDBQNmZyWFYyNjAvYi9tYVhHZTRB?=
 =?utf-8?B?NTlnOEwrejFnaXJwQ1lMRSt2Vy9yMDNad2lBUkU4VkFab3RGajhIWGdIUW9k?=
 =?utf-8?B?RXkwbGN1ZnJjQjc4N2RTMVBhcTVLQnB3VVc5YnNnbkJaTjlCdlFkdkRHdEd0?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +Q26Vzir4HBJbm9v+OFtiBoqHZN3Bp9/tc+w/FmxLB0jhfjSaUqOmzGUK100xFiRU5cIyMkAcIxvgfHLnzHz44qdIeZBYN3toAPWa5hiwYHAa3CnTf17wnQsCX7aV2dDe5wjbFkfJlhVY/RJHWSeewrV6fgWhQF6FhisvmdVRGw4yvZpu1utrKtcRn12R3gkUoN8gaTsc6wOGBAHbC6LCI/sB2R1LwFdwj1zYVwKM6eLzo2Y5LryUhogtCTDhjSO7nQ+KtlAh12tsv2BsnQmrRblrOczSZG27SMYAduY9g7V5kYO6p4x+Cwkb/whGSRx4ITKdpMRIlKWJRtZQPzX7/MakL2cctDk8+/yUJwjyJ7BIPBThjuI8h+5PiaAmsym74U9sQHIFSajRhpD8IO4EKDKC6jfg1Yd1ik3ls0EM1SkMDrfJDMnW1k8vkDENcGkrqGBIKtMurKMjqBnisHfgryUv4y9nF1+qqYo+eJE4RHNDcdNYcjf0MENRiZ9JcOCfsIQpjSSUQL3WowSDwqJ6voQLXQ+is0wQpaZsprVbXMiuJ8lYtD+1cPGVkSxT7LvVbFJozmsnn2IVYvZv5jwVW7+i3CqXfhb0oudmfygb5k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bfc8dcf-36e2-4445-fcd7-08ddae8241fd
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 16:07:43.4722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jH5eCfAzybApeX2YFyxLxVkATFDVF3jCyI0bWBhEqYYG7K/tOqMlcWzlSgz4mUO32ZLCRNsqzPi/WDToxxaPsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5820
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506180136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDEzNiBTYWx0ZWRfX3uBWOQTJ/Sas C/riK4156nH4+SgbrtdFyLmQ5WoYTgk0OCnV6vcL2uNp4cAO0LyvfxEdau+zgwuIzwd0KnpglwC ZIzqXQLHnWdbBM1jSZ0GJJO9KBE5+9LptG4cOM/ZI3fimNlz0DypbiUkZLv7RWVhbTLEk3UkhUQ
 VfkRSDNYijoMCx9F3K8mzbh0+IxCw/oKO0tJ8GJuLy4kG87uWuRYQEEHh2P+C6TGGxoRi/bR96A H8EBL9SZEt31r7ihCBiQSN0AWVTSKCAEhQCNoRNNtDOuhQskCwMtREbKn/bs2JfO8SDiLw/aJwc uzvsvK7LDU3c7/kSsLhhGxndMaCGW6TGVAmI5SVA0hsJY5hrVwE2LlYr5OJIZZ9rGs52MvUTH80
 kc9dV+opo9pg1/mymb6JkBwOvofmGwzlYl7mvwxHoH/45h60iCBGzBjGaFceNGgOTd844qh1
X-Proofpoint-ORIG-GUID: WjYOM9JJgpGoyHVq8_IyFVy0W4UUcBOn
X-Authority-Analysis: v=2.4 cv=X/5SKHTe c=1 sm=1 tr=0 ts=6852e452 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=T45wXxdC4BMsyAhoIxMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: WjYOM9JJgpGoyHVq8_IyFVy0W4UUcBOn
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250618_090756_671427_8A3D46C1 
X-CRM114-Status: GOOD (  15.96  )
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


On 6/17/25 10:32 PM, Christoph Hellwig wrote:
> On Tue, Jun 17, 2025 at 10:40:35AM -0700, alan.adamson@oracle.com wrote:
>> I changed the config a bit:
>>
>> CTRL 0 - AWUN=31 AWUPF=15
>> CTRL 1 - AWUN=31 AWUPF=31
>> CTRL 2 - AWUN=15 AWUPF=7
>> CTRL 3 - AWUN=15 AWUPF=15
>>      NS - NAWUN=31 NAWUPF=15
>>      NS - NAWUN=127 NAWUPF=63
> I'm a bit confused what this config means.  The NS lines here are
> multiple namespaces?

CTRL 0 - 2 - each has 1 namespace, none of which define namespace atomic 
parameters.

CTRL 3 - has 2 namespaces both define namespace atomic parameters.

>
>> [root@localhost ~]# sh testxx.sh nvme0n3
> But this is all about the controller 0 above, which now has multiple
> namespaces?
>
>> + cat /sys/block/nvme0n3/queue/atomic_write_max_bytes
>> 8192
>> [root@localhost ~]# dmesg | grep -i awupf
>> [root@localhost ~]#
>>
>> AWUPF of 7 isn't consistent with an atomic_write_max_bytes of 8192.
> It is consistent with an (N)AWUPF=15, and it is namespace number 3.  Are
> you testing controller 3 above or is the namespace shared between
> controller 0 and controller 3?

CTRL 2 (nvme0n3) has AWUPF=7 which means it supports a max atomic write 
size of 4096b, but /sys/block/nvme0n3/queue/atomic_write_max_bytes is 8192b.

Alan



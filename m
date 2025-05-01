Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AFC4C3ABA9
	for <linux-nvme@archiver.kernel.org>; Thu,  1 May 2025 05:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+ueK2dplQWGSjLV35W+ESB6SDuj3DXHsHWfGF7fxCiw=; b=dPpGEtO7BRKrUG/YV59Qxv7jxT
	5PwFRdtRvT0k0NZJU2gf57DPvCMJg1x7a3iSKMeEqWZ8Nm9tmArDFMxQcK6I83D8sGLBzm563NvQr
	sANTIi9OJZK/UpzMsLp0Z27oLvVgbAL5SqLpfMsoMzHkjOJyTjJKuIGkowr8PdH9Y+1PLN0JULRN3
	Zxq57VhEYJlC/rKt4hpO20q90SYdpkZMSzc6see7F+2c0iVbAcLJgsvaA0/memAeKM3rjevCJlSM8
	gH9sYGIhSN0jYKSe2VWMIse4cLAhS4Bb1wNRhxDGbrXBV+8GD03vGmfMSHZDhVeIkt9ZFZekfcB/h
	0xNf6r8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAMmh-0000000EnH1-43Xi;
	Thu, 01 May 2025 05:48:35 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uAMlR-0000000EnAZ-3QLp
	for linux-nvme@lists.infradead.org;
	Thu, 01 May 2025 05:47:19 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UKwLtv029953;
	Thu, 1 May 2025 05:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+ueK2dplQWGSjLV35W+ESB6SDuj3DXHsHWfGF7fxCiw=; b=
	MT8wiFFu0vgOQHLr1uTxtXemg0Qg5R/lVICQPr+AqNU0JShE5nt+Q/zZLtbJum7q
	8+rsJQKHTVm/Qrg2x0xCMfUuosD0N4t0abB6DQZ2qMbdFLFGmQwKjRQaCSd1kqLW
	udB5rPImYtvTgXD6BseA+n+aR0B2pJv3//mRCeiOY7xY8Okkps17MYvS3sjd5P5M
	rna+M5cnW3vz/dydkXq1YnxgFNEIoOVX8KVDthJTkFYJbbB7rsKn7c9Ie1vC+Oq1
	r0fetTKq9Md7WNGe8nNpYUxLuM5Nn8pQFNH0S7N4FTgrtnnL+7AyVH4uAbbc8GvJ
	UQBNiWXI1a3LCT1wHqWHoQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6usjjep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 05:47:07 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54135Mf8033554;
	Thu, 1 May 2025 05:47:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxc7nhv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 May 2025 05:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dHRAiecMBpkOhCJV63YRWx1EuV3vKAZnEdtUIy+AdOolCFB+imp+2tAB4qLkHXx1GdlPqHG9j9XxXnXZA8u3jrGROMtPWoImrBi1DVwvDJuGPnbpisP6UBx80rr4FuEBajVbaDeXn8tNj3D2vAHUTZ8e92F5rhKrwguH9K0kmAbnuF9AQLN7vzdqJDqd9EkVWc1FkRI10FTrzGjVi/YiLwQ+QCRzxR3O9+gIb3eg2Gvp6jFpOToDmP2xKdih7BeHUqly/4plH2eWt6jO6f/9h1mN3D2DAndcdJc2obfT/laEWkbuE47I6V7sWQfyxBjPzU3a+skng3qWBSCIwfu3/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ueK2dplQWGSjLV35W+ESB6SDuj3DXHsHWfGF7fxCiw=;
 b=A8K8SLjTfwMDkyWsLzMzYT5cL9Yb+99IgH9APFxVDS7TV/gCuCIdYyBnP3pNusXh6d+yYU375X4LmVaBQUJxWgvA65BCNphTfrfTNpsn4vj9RnqX17BNfTzFbSuW0W1QXaFBqib7yoZDXLZpCPqvr+Eh1PdCztH37mUckWV4EQE9pBbftg+JDodgXN3NOooIo2R8OAgKW7xGnzk8ptC9VElRUosREwDDPc4zLvkgY/yGUneiQjO6kaTx2HWIQVz/+Esc1/iLf6tp9fJ9O9MBQnSkc0qslgkSCghZJrwQbRiToEqQKOMFSwEU4N2EFkQQ6EsS/07nAiHuseR+fF/+yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ueK2dplQWGSjLV35W+ESB6SDuj3DXHsHWfGF7fxCiw=;
 b=xUIcjGSv6oGTSTpo1tgfoMJ8UJZPV1NzbskJXYCyOc+TiRmB7ZkCMqDA6yElsYAY5l3Mcta4es9zN+cNKN0SEJQAObKMGWhpcKYo2uuSvLBoQE2467ngE2pqWaUgnslcIwdD6gsu38pfqxFdoLx+opocgq4DAkoNjZyGp3JGLYg=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by SA1PR10MB6341.namprd10.prod.outlook.com (2603:10b6:806:254::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Thu, 1 May
 2025 05:47:04 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::fd5e:682a:f1ac:d0a2%6]) with mapi id 15.20.8699.019; Thu, 1 May 2025
 05:47:04 +0000
Message-ID: <55366449-8011-42eb-8b20-fdff02c15eda@oracle.com>
Date: Thu, 1 May 2025 06:47:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme: multipath: atomic queue limits need to be
 inherited
To: Alan Adamson <alan.adamson@oracle.com>, linux-nvme@lists.infradead.org
Cc: kch@nvidia.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
References: <20250430171830.1494033-1-alan.adamson@oracle.com>
 <20250430171830.1494033-2-alan.adamson@oracle.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250430171830.1494033-2-alan.adamson@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0047.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::16) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|SA1PR10MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 83a24818-270f-424e-66c4-08dd8873999e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b0libnpPOE9kTHVZV0xYekVZNnFOcFhQaUNtMTNURmU3WDloYzRYdlFLc0h6?=
 =?utf-8?B?THJheTJQZ3daWTBQWnhoZmtsMFlDVUlheStWbUpNeFpxd2ZwRTdXZVE4TEVY?=
 =?utf-8?B?amlFeUVRU0swalRBRERNdE4wMU55ZHBuRmlLMzlSb2Zlc2o3Znc4K3ZkQ0Yx?=
 =?utf-8?B?QmFjbzMvUjNIM3VaN0piazY5M2pkQVFhVUpyamFTV2VmVitzMlJERUZuMnBw?=
 =?utf-8?B?TTR4V1g4S0xxaitISmVwUUZiVmNGVkRIVE9pd0l0NUFGOVZlaUoxRW1JcDQz?=
 =?utf-8?B?QVo5NGRUU05zOCtncFlPeTY5SnNqWVpGQVRsWFRReXpmRUc2bm9ibEVkb1Ir?=
 =?utf-8?B?L2hPcU9nQlZLMDJVTVFab0JSVjFxWE0ra2NSOEJIa0s2cFJlMnpzZnluRWxn?=
 =?utf-8?B?VXlyZDlTMytoOE4rMU9SSlpDSnB0bjRqV21ZNFdSOUpzbTV2cWYxVHlUR1dp?=
 =?utf-8?B?T1lVZXY1VkJwcUtXQlNYMkJCYmQxQTB2T0hiYVhnNkg4MEtKeXFKWUJNejNH?=
 =?utf-8?B?bm9xU2RCR1pRL2FQQkEydjY5L0JGWTh3Mm11YjhrQUpZQXhDKysxRDRoU244?=
 =?utf-8?B?WXN5azM3VVVkdU04RStITU5pTFFXcWV3eG1JOGFZUHg4aHhOdlpPSFc0SEF5?=
 =?utf-8?B?dEFxWTU5T0xoc3hveUJYZEg5MHBwZzBEMXVydW82TUdMTWg4OHlLQkNsU1R1?=
 =?utf-8?B?a2U5bWx1akMzczhxUUtGdVlnTENacDN2NUs5VlVMQXZEYmZuall6SmIzTTE1?=
 =?utf-8?B?M3U0ZERTWmlwYUtiSGlDYTRURmtzSTBpcFp3Q0ZOWEZRbWRsZjdsU0t2NUZ4?=
 =?utf-8?B?cysvYmo0dTYwYnFVdUNadks5L2VEVEt3SXExWTRFNk9NRW9GMXZZSmpad1Z1?=
 =?utf-8?B?WE8yNXlFQTB3dHZyZWF5M0RGNVNyU3I1aDVEWVJRZ0kwV09rK21JUFRzMjB3?=
 =?utf-8?B?WGo5UDZlRU0yWndQWkZjbHZPUU9IS3ZCZEpZWnNsSjZZS1VzOWZnSm11ZXlv?=
 =?utf-8?B?MUpnTHBtZTcrbFNBT2xWZWtCQi9Ddks4MWhxRkN4QUlRcU5hVk9vaFZVSTVi?=
 =?utf-8?B?YUV3eHZaZTNlb1RmZC92eFRJVzU1WWtRUU1oWDUxYjYxUmQzNmk4WTNxblVw?=
 =?utf-8?B?SlZETWVzYk5icU0rSjFpVUNvVENKUi9obWkycTVUcGJXWlQwWlR1NERaTWk3?=
 =?utf-8?B?M3JrL1RKUm41d1lwNFlqNTAxSXdhVDRoZkV5WXUzRkRsWkt0NGVMUjFvRnJj?=
 =?utf-8?B?QjAzNUFxaEFITzBBazNFZWNMZElmdVRtdnk2TisxT3QrSHJNTDRJSTFwSUJL?=
 =?utf-8?B?TmhONzZ3bktLd09SUlpZaGc0bCtob3pUN0dzdndPYmxjWVVESzdVUk9CcjVo?=
 =?utf-8?B?OW1YdDYxNUFENVVWbDRHSC9zbkR5VDhQWlB2VGExbmJoUEN6cytzNzRMRHhT?=
 =?utf-8?B?RkU3a0Eyb1Rrc1ZXSDdxSDNtb1dTUnp4ZEVNZDlzZkVJNEthV29xUGpnQjZk?=
 =?utf-8?B?SEZCZEdnbHo5Ui9KeW5zUUpKeDArWEE2Zk5sQks1MTdXWHBJZ1FtQVM4Tmdz?=
 =?utf-8?B?Kzc0aElVNWlUSmE4TDZpR1ZNZ3NyMjNldFFhNVRmWFpFRFQzYnV6MUdTYkt0?=
 =?utf-8?B?TEc5WkhaYkpya0l3SGl4WkovZVJzY1FWU0VybjREb3ZIUTlJcFNuSXZjeG15?=
 =?utf-8?B?RUQycDhpZCt2RFdYNlBLM29GZXFqNW5mYzVpV2xSekE1clNqQTVlT3FSY1V2?=
 =?utf-8?B?bWxjOGhJOVpWL3Jjb1R2OEFTOVh3bnlOeklLWFR6anBZSWo3Ri9Kbm84Tkpy?=
 =?utf-8?B?SFNSUTdEUE9oeU8yWjVVNzFwSW4xeDM1MjVGdjFmVzIvOXdaMWdQQUo5WG56?=
 =?utf-8?B?OGp6djJldlBoYzZJVEVIbXZpU0RKSExRL0lnZTJuRVdZZHUvS3BGUzNOY0pJ?=
 =?utf-8?Q?19p5o3g+ORI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODl4WHhVNUl6TU0vTTM1RXpTaWhJSGJRYm5PcGZNU0ZCQXJtNXUyVHdnMG1G?=
 =?utf-8?B?L3gvVXZ0TUxEcU5US2ZRazFuSTdKWjgwK01NcmRYNWNSUldRWEU5UkRkSjEv?=
 =?utf-8?B?VlZmYm5MeFpaQlRJeEI5ajNBcXVwQ3FmUUptNUVJMDQwTGx4d1dPK25LM1NJ?=
 =?utf-8?B?TUlZcEtwcHY3Z1dCcGtCa0h3OXIzVnJqa1F5aHR4eGQzSWdEWXB1emJPeWp3?=
 =?utf-8?B?a0MxYWlSeENsSmpkVE8xNURaYVl3WnlVOEVaOStkdC84V0ZpalFkbXJ2T01H?=
 =?utf-8?B?WUJpRmgyRXE4c0ZZUkU3VEtBRU85b0QxdkNXT0QvSXpORFhJWUxwUlFzVkhJ?=
 =?utf-8?B?QVR3eDZjR3h3bnBoT2xJM1Q0cjhuL0x4N09PMUc0QnVkRG5JOFRVSVNnL1No?=
 =?utf-8?B?OWZ1T2VieklYQXJZMkJCRHM4eW5mZFVHSlR5ZTZwaHl5MFl6V2NzRzBtTWZt?=
 =?utf-8?B?MzM2a2pmZi84RFBuSWdWVmp2WVpYY203ZDRBZjdFbHpMMTcxTDc0emdXaWov?=
 =?utf-8?B?YUV3b2RHbDhKeEpSeURzUkI4cHVJZGdFSzlNY3M1OVM5WExlTWpNTGhGMitX?=
 =?utf-8?B?cXoxc2NiMWhNR2J0Qk1KMDU4UTJmMjFSTlg4dHFwVytVTERHcFI4OGE2RVNa?=
 =?utf-8?B?MGFwSFAxQWZYa0gzWlA0cTZENnljSE9rQ1I1bGFTWThhb3FZNS9tcjkvamcy?=
 =?utf-8?B?ZWVQUnI5T3lPaXJ3ZVRjcENrUmhsUmU2MzVheFRsaE1UK1BrYUd5SU9FV3lp?=
 =?utf-8?B?OHlSaVFGTE1LYWNtTmNCMWZ1M21ZeklNTUdxaFBEay95czJCZlc1ZmN2RVRD?=
 =?utf-8?B?ZnpUMkM1engwTkFudkl0dk8wRnBNd0ZuQ0lSRWlEU3lyb3JlR3luMVh0UFh5?=
 =?utf-8?B?WGIydEoxWWp5d0JxZ0tUa2dpZFhIbkd5RldiUHBiQWZZckhWMURSRFhqRkpY?=
 =?utf-8?B?Mld3V0szR1daWXBnWTRnQTQ4K3JEMEVYZ3ZKdkljenJzT2ZFUEtSVVp5K2Jr?=
 =?utf-8?B?STlBNVhIWTI2aUNUc1ZWZnBRZnR1eTZPTHBXQUNMSnhqRVVZQmFCWVlGSksw?=
 =?utf-8?B?dGtZRUJZWlB3Vnp6R3JMYWxGSG5IdTF1UXQ2L2dLSU42TGpjQkgySHZaNUZG?=
 =?utf-8?B?aUUveFUxZkEreVI4Z0VJOGpFWmRtTjdlekJlMG5BSXlOR2xGeGRFZWZxZkYz?=
 =?utf-8?B?Z2dpNmR0VmhQSzB6RnowM29wZVdoQVpQdHJJVXBSdHBQOHR3R2t3WUhxM29T?=
 =?utf-8?B?TlRhSGN4cU9XeUVkWXJpbnFwc1FaZGcvQ3ZsVDlHRnl1Vi9vbzNKRm16YlZm?=
 =?utf-8?B?UmxuNDdLOGVmSXlKMVl4elV0ZTZTbGpvMU1MM0l0VUU4bG5WVEJDdFpKQTFs?=
 =?utf-8?B?WTRrczhEMVdUNnNqaUJsNjN5SVFSeGNjek1WT2dwT3A0WU94aTJ1My8wUW1O?=
 =?utf-8?B?L3o1alJjMWlHY2MxV0xHSUZwVDRTOUkva0lYN1Fkb3BSNHhIOHRRRTQ4S1d1?=
 =?utf-8?B?Y2hsM0lTNm1JdG5zbG9SUVRMSjZmSmVxczRYUUYveXEyU1oyTFNEck1EYmtW?=
 =?utf-8?B?ZkZ1Mk1Nam5jYWgzTHI2K0R5UlhvMnY3a1E4WTFLRTkwcFhkMXR4NjZEb2xD?=
 =?utf-8?B?amFVenRoRGVsbitsYTBRRDg4U1lGVlhLdS9xSHJIVkhHN01kQ3JWa2FFVkkw?=
 =?utf-8?B?Y25Mdng2VmtDNFUrRkZUeTRvOVlEMGJycUZWRVNDVnJHajZoY1QzVnoyLytJ?=
 =?utf-8?B?T1p5NTIyTHd5TmxCbVpZam5rRHNITmdWdEM4SmlFWDVqUTRYRko5aUphbVNp?=
 =?utf-8?B?SFdMby8rU0cvcWZFdFJzeXN1ajlKR3RYbDU3MWQ2YnlyOFlPSVZ6ejJ6dmZj?=
 =?utf-8?B?QkVwempLY05EdlVXQXRXYnVQL3RmeFlMVjl6MnJSOTM4djhqLytFbnBnSXJK?=
 =?utf-8?B?L2FyZ2NnMmF5U2pzUWw3SmtZRzRNTGxJcURnOWs4VENhbjJVNmM1dVFDUHpX?=
 =?utf-8?B?dDhlWDJjcGFjNEZxZTFVZ04raW50WUl5RU05QmU5NWpZRjhUZHJPVHpibmJC?=
 =?utf-8?B?b1pHSDlMbEp6YmM4WVcvWW1zdkVZWHh3YWpBdW0wd2NncjhpeG1ESGJyUlh2?=
 =?utf-8?Q?5OIkuweHyl3y2yyCBQVhb0emX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5YSM8NTftIhsJD/XQE6hragsyvJ75tVEgddO36Zvbj0C7KWiH5WhgHyPOX4m5yUNcUBl7KqY4uhL/xXTOoG0V9AaVCXdFOCFs+J+EDt9aIQmJdHRkjegoXzGvtXLI+tvkNHCUIetr07rI6z9Nh/uyAlRBcYEbq1h34uRfwJs5/1Uklx8oXZFkbeHUXOFbKPBFffLBT0WiYf/RdveuU7JGas2CYw7gbf+sw4ztzHEtzHNdXnI7NhNH6rIs8K1oJfUNFKPhZnI5OPtJX4doRww1b0QOObxROdpBfJ7idtEgiinZDLaN5C8mgoQmxqVwLcQt1DQQH/klYrPdY4iWtT7fdDKkR6Uox9rxVN+iS8tpp3EmqKqQUhQEH6VZMkZOCbml3wrJOmfLSVDD+6byRyFtfDsczk8ZmfltopzMoL2uZ8da9Upd4gHshvRM/jDhiNUz/fJEZSRpDvrJM7E0VdF0Lzxpnzolvs/DV8KQa87ftPFWHvC0xpV5qUrFf2TM+p/96935GaII7286WSSKEazNn3MpD5Sq3J1deZwy7QXEBz/MFrO6krlu9A9gI7NGfGsdMrjXPBZ9J5S4WEv1zOIx2B2AJEGLth6f/5QTVJfMGA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83a24818-270f-424e-66c4-08dd8873999e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 05:47:03.9574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ce8SJpTnzcLKIi9QQHfRYyA45VfCMO/vbCoeXT7IYukjNRxUZ/lS1g+gT0sVn58INBM83waMUtMOiNtwA9TAUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505010041
X-Proofpoint-ORIG-GUID: 1bdy29YAmz4eQ-2mnf5u5ngHH1mi4d5R
X-Proofpoint-GUID: 1bdy29YAmz4eQ-2mnf5u5ngHH1mi4d5R
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=68130adb cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=uen1oHpksaofgR2VFYAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAxMDA0MiBTYWx0ZWRfX5c/ilFrXwUbX jLJKmamBT46n6h2Zw6yFViHMqBvLHPcL0hYxAcX6uDSiXIDXwOT6W2m7/u08WnztjkLpz2hySsi /viQhX1mku3F+DPjh4HP3R9+HPwZMSAs70BwOqaHOgA1KVsALOci7Ke5U8sp8Y74hSQWoIkbEiv
 b2gdUVzaWG9lLjsrfHffaGtrYrV0A8q++PsVObrID2tnYYFS1+qcrv/vDcdepL+9enDxGRaIC4v jCuzWjCgjqeE3soNzv2VzZp1tXZ1NGsZV4wHPgyLZ8Dc3pvs6bWbh7/UJ31Qqju1bsau76+jLRf pMFlegunH1pzfuvdLYwaKEw02PJOoQTpsMdxMYas3B4lRD/PTy6U+vPKMcoBCCF/LrxpiGqID6E
 /sYXc0KbYkgEcSKiBjkPKnYeAM0Aj4dabplTamkjqmnC1+zE4IFWttdstg4Va/almD6hi0QV
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250430_224717_877007_D486F7E9 
X-CRM114-Status: GOOD (  22.18  )
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

On 30/04/2025 18:18, Alan Adamson wrote:

Thanks for doing this.

> When a controller is attached that has the CMIC.MCTRS bit set, it indicates
> the subsystem supports multiple controllers and it is possible a namespace
> can be shared between those multiple controllers in a multipathed
> configuration.
> 
> When a namespace of a CMIC.MCTRS enabled subsystem is allocated, a
> multipath node is created.  The queue limits for this node are inherited
> from the namespace being allocated. When inheriting queue limits, the
> features being inherited need to be specified. The atomic write feature
> (BLK_FEAT_ATOMIC_WRITES) was not specified so the atomic queue limits
> were not inherited by the multipath disk node which resulted in the sysfs
> atomic write attributes being zeroed. The fix is to include
> BLK_FEAT_ATOMIC_WRITES in the list of features to be inherited.

nit: is this really being inherited? It seems to be just be explicitly 
enabled.

> 
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Please add the following instead Signed-off-by:
Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   drivers/nvme/host/multipath.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 250f3da67cc9..cf0ef4745564 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -638,7 +638,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   
>   	blk_set_stacking_limits(&lim);
>   	lim.dma_alignment = 3;
> -	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
> +	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT |
> +		BLK_FEAT_POLL | BLK_FEAT_ATOMIC_WRITES;
>   	if (head->ids.csi == NVME_CSI_ZNS)
>   		lim.features |= BLK_FEAT_ZONED;
>   



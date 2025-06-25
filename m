Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5ECC77B7C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 20:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xx/N+8uw4FAAoMdblgy3tElX67QyVp9T2kg+FxsrWqw=; b=lwaBfMGaQLqBHzV0v+1QV2aPpR
	sRLj0eqjifv4lFsj9eNzjgsuEV5tad1OLxm593g6CzIRWmt/tdmYD3lLvmqNlTNBEOte1MVR7J0fy
	S6NkiynUZIMi7cR5iPSr4mRf1VTeieG5XXpukh/Hd05sFMKqI3Yt4xhEtNtwHvDi1VAxgYA5F/Bi7
	GPIf0HCio1ImvyvC8nbA9pk2GXUjZKjNvYg1ooILvAzXtSeRSQQksG75jlE5D3ssjzL20KPmz38A4
	1Iimxqc79tl0CdgYqTAf8BRpi6Gcvslnal08TGoTWHAWGRAI/rGDXioT5ytoLHmo4lhp+Twb3R18y
	qGvWgDrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUWpq-00000009rI8-1Lk6;
	Wed, 25 Jun 2025 20:35:10 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUTYd-00000009Q9C-2ZcU
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 17:05:14 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PFtgRe024265;
	Wed, 25 Jun 2025 17:05:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xx/N+8uw4FAAoMdblgy3tElX67QyVp9T2kg+FxsrWqw=; b=
	IsJOnxfK1/J2tFo8ZXpRPj3Pr6DapId/TmFWh8kJilzDRV32fXYUXNgMV/D8tFCL
	0qqhK4lw4ZrQj/joq7Ww5QfT6U+esDFVJn9/pomSxjMscAwI09xe0fdJeKdciwLG
	cJI0BAoNz23k8sYn+Ed52p2PYHggS46hflTrxjNXbZPK5S4jO8b4gLp4hhBI6urB
	L+P+UTibxrSGvpCbZvvKRrQkdqaXmcazl0lKHSdOOVrWhhIsB0mvEKTyJjLDDi2I
	ZCUcrqdQJYpGdmSg7bGza3d/6OajFGuaC1Y8Dtas88M/AjenHEw2k5EbvaDpU0HB
	FNfBOEFVfNBRoAeFWjsFcg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt7ev8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 17:04:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55PG5v3V034324;
	Wed, 25 Jun 2025 17:04:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehksbvgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 17:04:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAkvlYWjp3/idRHvQRf20Dy22G8wRwBVipmndlNs6Isu9JOCjyAKqPfxnhfuSYdQ7YEEbKJb+zZYI7hwaNE5nghXc68lWDuqtEoMdFfZK+XGJPqH3C+xAdHKSGaTASDp8Dq8wmIQNra22oLR0zb5Qx/0qKD9FEAslKorR2lRDTxUnpkzeYRk5TjhWt0U4V4QRyuh4Q0nbQRSdwyi/D7oHVClKH6Bc/fl8xHPad9mrvyyA7aa2vN4iNPmcdxLpAsLrAcAMikMhvqaWXSGxGlRa34MmVxCwHa1e/2lD3RcY06TZcNiOnlwqyHxw+GaAv2PyL3oq1/e7C+nQyRXUoy0pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xx/N+8uw4FAAoMdblgy3tElX67QyVp9T2kg+FxsrWqw=;
 b=EmBpXouSFN85FvClDPKziUCqIgwIZNA4Hsvus+esGatR6OEBgVyi/X6VcjK8DBIOu/NbiZgR2jn5Hq5EZLCUH/euJokZQLAZWUi0k+OFYxGNkDLwuPkJ5P8XQpk3Q3iPvSXcdtxL0Bhp+dKgny13iyCzVonP27isSKjYjN7zIbXyVow/sVyYWbGEaHaFS79/e68qBtEQn5PjkTwTBIpg57XK3ZoLBlsHMAhXD8rPYEk1+9bMMtkt7N8p3mIgsOTJ0KEZYwWuvAAgF4beZ7lMbx3N269npM74DsCiQc3CCM87udzq+b1jYCqeaNWb5M5QbIMcrYdQpYdJVHttcgPuwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xx/N+8uw4FAAoMdblgy3tElX67QyVp9T2kg+FxsrWqw=;
 b=YJDbkqi3L0znVwbDhnP7J3M4Te20wCjYmrTUrwW/ulUk6HoARJC8In61Tj2MQq7AI0Gk7+Zvc8ZcFUcfj3jew7A447MtH1wxxj4jw7nU49yajQmfa2XJOxt/SRKrqI1F8PphAf/LnfXOB8Mc3ymqD8OY7vyZ7EkLXn+4ezVxsr4=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by DS0PR10MB7953.namprd10.prod.outlook.com (2603:10b6:8:1a1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.18; Wed, 25 Jun
 2025 17:04:56 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%5]) with mapi id 15.20.8857.025; Wed, 25 Jun 2025
 17:04:56 +0000
Message-ID: <69e9b54f-c3c7-45c3-b4aa-4dbb9df64976@oracle.com>
Date: Wed, 25 Jun 2025 10:04:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: fix atomic limits check v2
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        John Garry <john.g.garry@oracle.com>
References: <20250625064003.436582-1-hch@lst.de>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20250625064003.436582-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR17CA0051.namprd17.prod.outlook.com
 (2603:10b6:a03:167::28) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|DS0PR10MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae547b2-afaf-4049-52e2-08ddb40a694a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Rm1NMFBuSG4vWlozZFVITVhYOUc5K01Jdy9IdVF0b2JraHhOVk10WlRiMkZz?=
 =?utf-8?B?eHcyY2NQYk84ZFZtNFo1Z2ZPTjBQQzhBWi9GcElZY01yNllCZGoyUGUxUXpM?=
 =?utf-8?B?L0JaMUxXYlJSMUsvdGdnY3dTY1h0VmlhODNHcjgrQWZZdEplVTVmNkc5K0hI?=
 =?utf-8?B?eTVZYTBseVQ4S254eTlzQ3NMRnZEUmxOazhuUGkwZUFMbWNsOFEyREVxTlBV?=
 =?utf-8?B?bDFBNzkxNHg0S3lEdWJ6MTcrWFFYYjVzcW5aS1BkR3RMb0YwdVVLU0Y0UlQw?=
 =?utf-8?B?UGRsU25VYVUrdFNLSU1qMlJZMlMyMGozckhFd2JCMVNRVk9DaFpTdnJ5aTYr?=
 =?utf-8?B?S0VHTWNNc09qYXlOQzhJQ2JqNWJZcnA3SERQUXg4QWV4MEtVcFZUVU9JUm5j?=
 =?utf-8?B?MWhLM1NuRTJLT0g5MmptTjJEZ2Q2eGZLYVpFWXR4Qnp1OUo5SDlKZm1VYWI2?=
 =?utf-8?B?cTRuMmUzM0JRem8wZHdMcWtrYWd0WFM1M1lseStzcE9STElpUm1vWWJOQkV5?=
 =?utf-8?B?NUdFL09DYmYxYnR5c1gyM3YzT0xSekNiVmFDYjZLZzZrelh6RDd0K3VYRnh2?=
 =?utf-8?B?NjJXNUFndDRQeHc0OEowZzllemdRQnZDdTl0QUFCcURjb2dYVmdVS2tpN3Np?=
 =?utf-8?B?OXB2ZVF6U0g0a2lFVi9kbzltdEFsSC8zVE43YVVLWTM5WnBHcGVtZHlKdUZL?=
 =?utf-8?B?OFZCa3FuLzJsSDFwK254dHVCblJXUmhKUTN5Zml1aVVGZ2N0bnltQnd4bjBK?=
 =?utf-8?B?dmdHSXRhSVp0M3BnNExORDY3c3Z4UmJyR1FlcnNVS3BZSGZuMEY5Ui91UUJQ?=
 =?utf-8?B?OGhWMmdvTG42cmRobnhlL3lpVWRINWZMK3dUOWI2VTdhMWJ6djFiYzF3L2RM?=
 =?utf-8?B?VE5qaGl4M2pPbUtJM2tONFI4QXdkOFRML2FGMmVEZytLL1pyZE9qa2xnRTUx?=
 =?utf-8?B?NUw3K0ZHcFE4WndmSllCV1lYVGsvbHRjNG9iYmt1a2hpcDFhRGNNdDBxT0JC?=
 =?utf-8?B?SlZvaC93aG5zSEc5blhrejBnVEl3cjgzcFB0MWowcFJWVlRJdW1aK3h0MkpX?=
 =?utf-8?B?R0V5K25VRGpCRFVjd2tGQkF0OUNiNVpCSEY3aSt6a1U5R1d0NWtBV3Y2VHdi?=
 =?utf-8?B?dy91TlU0c1U4U3VGR0VodTg3clgrdDBKbzg1WUFCRHZoQ2VIcG5xUzlBdlJG?=
 =?utf-8?B?RmpzRnJ3aWlONlNjQ3BDS2lDK1JjdWVrWExKaFQzcWZYcmZ0MUdQR1pmcFNH?=
 =?utf-8?B?SXV1YmV6eEc0L3pONVVtYWkxQUtrL1l5Z3JoS0JqUEl3c3J3OHF5a29XRm9m?=
 =?utf-8?B?Zmg2WHJHVFUyNURvcDhMeE9XU0hpSnhYWk1sOTFRdTI0OWNIZXltb1NrNGxJ?=
 =?utf-8?B?VjVNNGtCbUptc1hCZlVxSXJYSTA3d2tqRm5VM0ZZaXFMa1JWM1NXdTh0TUY2?=
 =?utf-8?B?VUs5Qmd0T1ZtVGlidlMrNElWam9GQThScGovVFIrdnZFZ25jZGdMbHFNaFJW?=
 =?utf-8?B?SFBRNnZrK0lRSXlTN3dQVGg2d3ZvWisweFp5VTQ2ajY3TXlpaEptOVN6TzdZ?=
 =?utf-8?B?RVhSQWFYdnRZQ1NtR0grN1QvU0IvSWNMQkkzZWtOSWM3dXA1SWZYNlQ2WGZM?=
 =?utf-8?B?ODUyTkNXTDJ3aktDOVBodG5XeURWeUZMelJCaFY2VFlvV1hsM0psU3RJV2Q2?=
 =?utf-8?B?MnpEeWp4VXZja2RRSURzM1FQYTVWVnVrM3h0UFpRKzRSZENkT2k0Sm11Z1Vo?=
 =?utf-8?B?bnVkMmsvV2VwYUdYdXlheER5WUtsaUVIL2ZhMmIzQjR5T21oSk4zNFIwdjVR?=
 =?utf-8?B?Y09XQ2x6NXZaSDZDaDRuL0tFN3pPUFJWVFNxMjkrcHExU0hFSUp6d2pJZlZw?=
 =?utf-8?B?Sml3VUNrd1Z4SkF4eHU5WHB1NzZ2aXZKQlF2MmZXcnNpOExzZFB1Z0F5Y21z?=
 =?utf-8?Q?vizWM6g7gfQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b01QQTRHRGNhOFdVZkp0UW9yTWdKRENrOUc4aE50WGZCR3BYajRjK21ueEto?=
 =?utf-8?B?RUNFeFVSOXlaRVpCSEVYeXhVeVZVSGltdWdDaXp2bWFUVGwvckxpZ1NkU2ti?=
 =?utf-8?B?QUZQclFodkpUL1lNTy9ob3czdzJTL0YzMDVRMTU0Vlc5enhwSHRSM1VkZ1Bj?=
 =?utf-8?B?bjYyVjkzZjYza2g4TDJ5V1Y4UmZkVWVORFRvVlQxNmxuWk9qZlNhNlJ3Sm5s?=
 =?utf-8?B?UFhMYXlGZEV6ajdiMU50ZEtuNU12N3dQWnVGMGFFOFV6aTNNa0JjcmZNMGJp?=
 =?utf-8?B?RGQrYnRkaUZLemFIaHVSc05jeUhUclEvSWtwbmFpVFdpbWZzNFpPQUhUL1k2?=
 =?utf-8?B?enJnVnN3WGVMMzkzSm5FbmJmS0ErTDRYSGkzUXlMY3VqNmRuQU15cXFIRTVK?=
 =?utf-8?B?QWt3aEMyRTdMOHRSTHVQNHdlQjVVRHpYdEs5NE9iNmNyVnZTY1RLRnFkeGQ0?=
 =?utf-8?B?U2dDRXpmV0ZtbXdiZm1VS0NSc2x6eGlPQ0pkOUE2NThmUnJRNlptTjJCUDhY?=
 =?utf-8?B?WFBOV1R2U3pQKzluOTBleUJMYXhnZWQ3QXZLVm1qci9DYkFHU2loRXJ5OEJZ?=
 =?utf-8?B?MTFsUVNnSURJRVFJTXBPNXNrQmJ2K1NnSmlZelBhbHJmWXFlUkdCK21EUnpJ?=
 =?utf-8?B?cW5ET09ub2NMb0txZFpPWTFnQi9yRHhadWIyQTBscUFRQzdpWk5qaGJMZW0x?=
 =?utf-8?B?VER0VU9Jek9RMVRjWkR5cDJDV3h0MWpDMWJ5bzUvUXJHMldUZWlYUzZZR2VP?=
 =?utf-8?B?enFPdnZHbHFVT0xmMVowd3RVSUg1dlpuT2lyZitKSDhSTDZudWxaNHU3T3BS?=
 =?utf-8?B?bEhTNHZLQXBWMVdXZ2tmY3FUUmlsdlBSclJrYVJZeW5OVi9CTC93UFNLYi9K?=
 =?utf-8?B?VlgyajlyaERsNXJaaFpxREVPVmxNSFk3K0puZHYrc0pmby9RVGVnbFYyT3dm?=
 =?utf-8?B?ZzBSaGluZUR5MzhiK051czlyOFZWZldCUUlOWlo4NGh2dFRHQ29xNjVGSksy?=
 =?utf-8?B?ZG8xTHhSZkU4d3lFM2lqalNJbXNGOWZJRUMzMWNSYWRHRXJZUTZCVzJJTGxx?=
 =?utf-8?B?Y3VVQk1PdmJwR1MyRThDdWcxK3NUdHhTMTFDT0h1WHpRTmVZOHpVN1c4VmZh?=
 =?utf-8?B?NEJqdDRXTTNrbWtWcVFYa2pydnNwQnVzNk8yaHdiWXRvWmNvYmk5d0p2VXIz?=
 =?utf-8?B?eS9nWU1tOVdwTUNqVXZNVzVmVjZmMzljUUMxSW8xL2FudU1BcFVjRzFoZ2NM?=
 =?utf-8?B?cEJHY3I1NkFVbmk2dk54eXVYS3JPRHFJbERlZ3J6R0liNWJNMXBYaUFreVh0?=
 =?utf-8?B?SSsyWGlQTk9XaUZzejJYem0yenFDTXg5RGFOMkd1RzA3KzNWSGpzL2ljbWJL?=
 =?utf-8?B?OEVMejZYTlNJbVgwaUtnWkd2TGRwL2pqMUpiSXpNL2x5N0J5NU9hTWNMbS9B?=
 =?utf-8?B?OXQ4d2hyYVdFdFNHWFAwdWVJbkEzV3BRRjJrdW9jZUxlbmNPOW5jSytnT2V4?=
 =?utf-8?B?QUdqcXJQREg2S29STWNoYjE3UFI3NTBWWDRtbWd4Z0ZCMFU1OXhZYUk2KzRv?=
 =?utf-8?B?UllNeTEvR1h2N2hFVk1pY29uU2dDZFJDTHdxSm9qNWF2cFJyL1N1OWtxOEN3?=
 =?utf-8?B?YVNWWm9SUVo5ODhMN0dKVTMzSzNPQW40OXg2ak5tTkJpQnFnT0dXQzZTMmJB?=
 =?utf-8?B?cyt5eVM2Z2E5QnZLU3MwSDZJNUdaUWM5c3p2bmh3Q2hIWGF3b2MxSzZVNUR5?=
 =?utf-8?B?YkJFZVdIcnF2Z2lrOVltNEpGWnE2RTZLZ2NxY1FiWjU0b094cU9oM2hrOEhF?=
 =?utf-8?B?MFMzbGNuTE45TVNtSGNmOUI1bVlkdDNYNE0xT1NvM2pNRlREMmFsWXNGZXNs?=
 =?utf-8?B?WGxSc1RGdVV3WStPSVpHY2Nja0JrVEovZ3BmWVV2ZXlIUWU0dGozbUFnQVNH?=
 =?utf-8?B?eUpGVmY4NlF0NmJQdHdIR3FQZ09Nbk9CWXhVVnZRclNVNUxad0w4VThnbHJK?=
 =?utf-8?B?U1FuYy9GRUU4TVZjSDhybVRSdThKd1NkcmJjZjZnaUVQUmwxS2g1SEw1eWxr?=
 =?utf-8?B?SXpQSmFXRHg3TWFSZVBPTTlRMFpMbWhkYWpwU0xzMndVOGg4VFNBY1Brclhn?=
 =?utf-8?B?MStnMGtlUFpXdU1aMjZiRkVoWER2ejkranZOSHlWVUoxVnhtVVVpVkczcVNv?=
 =?utf-8?B?VHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j9LfG4uqKztwMMVo5CawSqwFzI9jfw2ZX9csJWr9jYf/jygMhe1704h8gcp90N6QfwgldbV4Pqy1iwYy4HA8KalpcfqCOA4ryMTINkPT8XIaR5/sEo19aN/GW7nAzA9VxzlQDz+9j03afAuBC21syc+UVim82b47cKKX8Kv1xK5e+1I1UBLcKKu1DgCtnwy2BaBZ0+hebAu8r/mC9nOtVU2bnsnHfw/luo8Klj/a4K+91gtD7087Ca8IV7heggdw3qOIZK1haUnvX9wv3e3lffWl5wOLUtcruHlb2/UHgJiujjyCclzYZgX14Cq47oRG6qIhl1rhgcPVthpmjVfXU6vS8GPfxRpj+aCCHF39Aakghay+PkZTiRfSs+UYRGKhLEy7OALYDQLw+QplB0oxafTQmwZWDQUO1GFbheO4vJQLtPzeSILhrzzbMwdJSSIJ6RQ6M5jayi8bd5yTtpzkAB0h8P1uVX1y4JFzgRYaL6gDCpZZjmMeCtXiZOKJQC6OcL6XRMDLBGWVVpsISOHYrKYJAUshiwxByrseV5q1LE1bXuomhYa2NIjfxHN6nxI6Ft2GBtSEbe9pkwRp/EAf8kHEmY6KOpqqbnFyBqpBMhk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae547b2-afaf-4049-52e2-08ddb40a694a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 17:04:56.7292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oppL7PWKYiz/jTi4N1O+ElDDsqp02WnKlrjGa0r8f/ihozMuZ1HF9qXGFlW27Er0ThQxylt/VA9nbTYe7xzCHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_05,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506250127
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDEyNyBTYWx0ZWRfX015Tt91Hy3qk oeAI7hwau80r6n95rIDJR+SmZa8daise9JikG4yYRhqrmV2H7CRlo1SN1TI5ah6TS2K00lhvMb9 sS5JrjohiKv4p7+2jtQSNQvMnvvTXu7DVDYEoTUN/VOOLgkAsQ2dytm/mixV2QBrQ0vaftBB4lF
 8tYiWpgKZ+nEygeJu7Y9DN9eqKisxRaz1fAnKkO940XhhS9Azyk+LJF7tkoyTGVxwQiAWTbWo/D SWx3xBtpOISfjwHcIyGahqJl6G5d6zSUhb5bZFImWOVIFU/5o5fSCpK7QHrFgfInEbr14kP+DXl QabQbnRfKgKoCfeFpwsUZwEORiecYO9dK6Gk2BFQ50j1TSeIPbqRYMJCquTIZlZgYvrD6KTJJ85
 tehcDUiYhPHHDePZlGxt/biiQIAd6jMOvUQBRqrqgoRZQpUWKQX/CvfGCHyR9UbSJFOSPGp0
X-Proofpoint-GUID: dYjVBQ7eUnyNXWdsDogBEHSjljsc2N5E
X-Authority-Analysis: v=2.4 cv=QNpoRhLL c=1 sm=1 tr=0 ts=685c2c3c b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=SjEPYBZ6UEADo4BsUpkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13216
X-Proofpoint-ORIG-GUID: dYjVBQ7eUnyNXWdsDogBEHSjljsc2N5E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_100512_817830_74CB8260 
X-CRM114-Status: GOOD (  23.62  )
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


On 6/24/25 11:39 PM, Christoph Hellwig wrote:
> Hi all,
>
> this series tries to fix the atomics limit check to limit it to
> the per-controller values and to the controller probing.
>
> I think this should solve the root cause of the report from Yi Zhang,
> but needs new verification.
>
> Changes since v1:
>   - initialize subsys->awupf in nvme_init_subsystem to make sure that only
>     happens once per controller
>
> Diffstat:
>   core.c |   83 +++++++++++++++++++++++++++++------------------------------------
>   nvme.h |    3 --
>   2 files changed, 39 insertions(+), 47 deletions(-)
CTRL 0 - AWUN=31 AWUPF=15    nvme0n1
CTRL 1 - AWUN=31 AWUPF=31
CTRL 2 - AWUN=15 AWUPF=7
CTRL 3 - AWUN=15 AWUPF=15
     NS - NAWUN=31 NAWUPF=15  nvme0n2
     NS - NAWUN=127 NAWUPF=63 nvme0n3

[root@localhost ~]# lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda           8:0    0   40G  0 disk
├─sda1        8:1    0    1G  0 part /boot
└─sda2        8:2    0   39G  0 part
   └─ol-root 252:0    0   39G  0 lvm  /
sr0          11:0    1 1024M  0 rom
nvme0n1     259:2    0  250G  0 disk
nvme0n2     259:3    0  250G  0 disk
nvme0n3     259:5    0  250G  0 disk
[root@localhost ~]# nvme id-ctrl /dev/nvme0n1 | grep awupf
awupf     : 15
[root@localhost ~]# cat /sys/block/nvme0n1/queue/atomic_write_max_bytes
8192
[root@localhost ~]# nvme id-ns /dev/nvme0n2 | grep nawupf
nawupf  : 15
[root@localhost ~]# cat /sys/block/nvme0n2/queue/atomic_write_max_bytes
8192
[root@localhost ~]# nvme id-ns /dev/nvme0n3 | grep nawupf
nawupf  : 63
[root@localhost ~]# cat /sys/block/nvme0n3/queue/atomic_write_max_bytes
32768
[root@localhost ~]# dmesg | grep nvme | grep AWUPF
[    2.761599] nvme nvme2: inconsistent AWUPF, controller not added (7/15).
[    2.765669] nvme nvme1: inconsistent AWUPF, controller not added (31/15).
[root@localhost ~]#

Why was CTRL1 (nvme1) not added? AWUPF of 31 works with a 
atomic_write_max_bytes of 8192.


Alan



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26533C71135
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jun 2025 09:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A7paNCja5X9lfsSwED9MymHNfUMhk/w9olShWYuv+aA=; b=I/yjg1/ZYM4gtC4SefJ7oa+tCO
	EmzOYCH1xv4rbe9vF+pGhwyyxtER7xIfXCmTOoRvdi0n/ftqoUSDuYqKH6IYoroyFgAIwRFPFiL2Q
	EMfD8M1uRRoIXSqRt01Mbg0/jmSKGlA6uJcmJzXu20JULsijYEiqIaicwpX0J+LOcliKUkVg0h9tu
	NVaW3IxDtpL07LfPQMg0D6s38STImt4XRYvse6OoiwZmiY2VQ5tEx8ntwhh6b3ds/tck+gkoI/t1K
	3G8wH3pw9OI46KS21qKAguNb2UR7iDULqROrqUMJzcQWFuxPr94+nrK3UIPIzt+sSlC4yccLIOjst
	Nf5vWhbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQ0Pu-0000000FsBq-2INU;
	Fri, 13 Jun 2025 09:09:42 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPzOJ-0000000Fiov-1qun
	for linux-nvme@bombadil.infradead.org;
	Fri, 13 Jun 2025 08:03:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=A7paNCja5X9lfsSwED9MymHNfUMhk/w9olShWYuv+aA=; b=kgOiD8CafqND0BI8wrVp+zwIbq
	DpP+iMnM/87rOkNANtvpdYNd8NqzuNIyv8hL3ESeEhEyh5wOJYuGei622OmTFkocFMf73OpLh1tbX
	l4RGR6yDKFdKpfzx5m3Ju5cvNfllXtdg8AhU1Tc+O8H94oN59eOGu4Yf5NhoC9Q0cw+bKRXWceVeT
	SwCVMozueT5LHXrWUYcZOkB2TcYCv+b+6TYRJGIKaDYd4bNTFgmSjF+jdpzNwtL78BUl1X5vzqgfu
	rKeLYurxPOF56DcSGHoW2lfug+tJBCxsHg92LjX1ntKv62cWz8EL0X1YIlMEoZkfxRz4v5QnQ35tb
	TB7Xw8cQ==;
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPzOF-00000002uvr-0qR2
	for linux-nvme@lists.infradead.org;
	Fri, 13 Jun 2025 08:03:59 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55D70lKY028254;
	Fri, 13 Jun 2025 08:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=A7paNCja5X9lfsSwED9MymHNfUMhk/w9olShWYuv+aA=; b=
	fmktjSQcuSRpUyAPcPrhiwLIZ84k2UjNnEAI5RJo64209eJcDlxJUWh1g6n5kTse
	KGTTQ7jeDb0ceejGqsXsmRyE7HCTf/2p2nROqN5LmaIbLtuX1L4jZHMFzCF4pygs
	NZsUZYN57x9DPV40nAJl4jTJ3M5yn1bicw+pdT1dz6fukn2sEoc1mFiXBBrphBzP
	cF8UNDNefjk4Jj/39Y98YKM9DckjhRnoHU2L1ye7lR582vdNtvn1k/LCLGnOFuw/
	R4F6rryHy1Qf0CnaQ4gkavJArlJVLzGgSdU4bKA26acLR1n9Kb8EHuXbxtvaYLGo
	M2D9rVfIHZIBEEqigZ52aA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dadb0fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 08:03:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55D6pN05016782;
	Fri, 13 Jun 2025 08:03:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 474bvcmn0b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 08:03:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CUUsTVPl/FEm6fNkmBX3Or7b7qlryWSUa+ut7H8l659H0IJxHC5E1mc9dKqNlbHGjd4Gc9MZ3iF6oJdUoskH2UcGUcTTXzyA1v2nZvGXlNxqrpZoTQnQM8jgCqNY31O+t7SdzVsbONOhWIigqojpCtPlnrfIu5oLHEBvFV0lCf93/ahJSY1Gm/K3JRkldmHC8WDCsLTgZTwlu3+SGyO4wiNxuXI18H0SA9gJMSnW8oU1AXCuOgRiw2Qak99oOpT+rIDYBsyP95IvsReUmBuj028FQNRJ8WqL0nYn50vnLDLvLqkfdSuhE3V/v/yh4GKJ4UzVOyNfrJhBEe3bOb4iug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7paNCja5X9lfsSwED9MymHNfUMhk/w9olShWYuv+aA=;
 b=sJLL5ImotuENNz/PWwPnfm6EU3SYfWYdbCvum3satvw1eduiyFasvXZW54OqNFg+R0FdYnw2hlnPhm2kG3VE+gPeTzugtK8Gsn0s4i7AGje4MkQfIhzAmscZDk7B8XgPy0mWLfMjOMB3//7ZywUhSYkLnz/jpWXcyVED8Nnl51QZCQ1kUwoxkJl+bev/OB0u5aG8rzv7DAh8WPUDPSG/hF8afWJ+GNTLC7z8P4qMRWwW4toJD99i8aVzazaw+AQnomuLEkky2w43UiK301bBQMV4ce/JDvmfT2zXh6tr23cvhC/itkGZU0MIgRI+HjWZbNdTeK8s8Sdqb5C9Gz3oeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A7paNCja5X9lfsSwED9MymHNfUMhk/w9olShWYuv+aA=;
 b=rksV4CB3ejdKeYgRC0/pJYDqed475Ayl6Qubdd+Bnei5iNZy7FDaJ/TGigC6Zdd90QnqAm2kftWY5GlXTywHHkfr/9VYDH3Q7JiU/q5DrpVkMJ1LRgbdEYuwcVkjS3fzJSHcsEML/dVQHCpyAvzNH2NUk8KVkAqpKOYLmezLZkE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7629.namprd10.prod.outlook.com (2603:10b6:610:167::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Fri, 13 Jun
 2025 08:03:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 08:03:13 +0000
Message-ID: <f88d67d4-8484-45ba-9705-95ced325c65a@oracle.com>
Date: Fri, 13 Jun 2025 09:03:07 +0100
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
X-ClientProxiedBy: LO4P123CA0047.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 029ac296-f4c5-4348-a959-08ddaa50be7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NStQVEYxV0JnY2h4VFh0Sk1ZZ1hXWTQ3R3l6MUppRVVwZnl6aXpWWkFEUWRh?=
 =?utf-8?B?bGlSSjJuak02UDN3Y1pTckVia1h0dW4zR0FZbVhnNVpDQmI0ME96MzhORTJU?=
 =?utf-8?B?REttVlZRM0hxN1lXckZQNThmRFZBeVBJTUkvZ0VzU0VGcUg0MnpPTjJEMWta?=
 =?utf-8?B?alNLRXJnb0NKdHJnN1N3QnNSc3U4Ry9QdUNRUmRJbFc3aTBXdkFJRW5JS3hV?=
 =?utf-8?B?bWR5YUtlanlKRlN2ZStGczVHVG9xaUl0RVBSK2Y4N0EvYzF0L2x0aTRDay9u?=
 =?utf-8?B?bnk1ajZzemZ6SWlOdkpTU29sdGFPRi9YWjBuVHhlVlUvUGxsWElkRWxtQkhP?=
 =?utf-8?B?MjMyaE0rSVpTaUd6elZvalp3MkJpWjQ0VkRoTkc1S0pDcDE1QTVDMURrcmtV?=
 =?utf-8?B?d000ZWk3VXFYcW1PS1pzYjhhNWN6STEwZWM5RjhaaFplTEtYb1FMeHFZSmFl?=
 =?utf-8?B?MEM1Y0JaZ05kVm9NKzI1SzRCL1pMWm5KRE41TDgwUDlnY2M5Qm5obDJya0U5?=
 =?utf-8?B?R3RybmQzb3JEWXpzaWVvbEk4WEI0S3g4OEE5OVV6UXVxOHUwR001b3hqd3Zq?=
 =?utf-8?B?dkdnc1AzSHZDanEwLzMyQkJ3YWFsbUZ4S2Vab0g1QkVXYUZYUzFSeHZJMHRZ?=
 =?utf-8?B?TmJJU1FleDBBWFNWbmlJc1dwUERhTCt5WHdVVysraFFtb2sveDBjbnFRRjdw?=
 =?utf-8?B?VjJkQ1M5dnBBUkhULzhiNTAzUlQ0dEFHT2hWelp0anVJc09vbFRiWUVXVEgy?=
 =?utf-8?B?MmFjMWprc0ltZllsMmptN1k2NjQ1WEZtL3ZaaHZTSmQrajBaMmE3eWNtQi9W?=
 =?utf-8?B?dm5BNHlJbldOQnFsa2RzMEZYT2MvL1d2R0dsSERCenJlYVZFN2F2TGtFRVJZ?=
 =?utf-8?B?dmF3UUFNd3F2YlkrczZmVGU2YzZQVGM0VjVkZVdodk1YbnFyeUhOMFovQUx4?=
 =?utf-8?B?ZlpTcUtzRE1weVNDSVI0VkpBM3lLMkwzeXBaRnVnT25IS0h5UVRWZHZmUFdl?=
 =?utf-8?B?WnNGQUw1c2d4M01OT1BKQVAyY0MrTnBwd0JZSTJMdURpOHRWZEpjTFJyOTMr?=
 =?utf-8?B?TUtUYVdFbjh3b1h2OUpVdnpZY2x2NTNSblkvanhLRnBNbjNBQWlNbTNKaCsx?=
 =?utf-8?B?dUxGcDhWK3pVYmZBYzViOHp3OWYwbWdpN3RtU0YvYm1FZ3pXeHQ2VXBZNFlu?=
 =?utf-8?B?bkZFL25mc29ldm4xVGM1bmlKRzNUVysyNXhZRXZlTUt5RWVpbXVmekRTOHZ3?=
 =?utf-8?B?aXdjVzVWZUJtWXdtV0t6ajY1YVhqVWtCUUFOWHlPR2NkaDAvMG53OFJxRkxy?=
 =?utf-8?B?NitXUlVSTnppL1pIM2Jha241RG91Y2pFVVFUMi84QkQvYmVXUW5KaUNrOS8w?=
 =?utf-8?B?NFdYTE9xZEZQSy9EVjAyYXJ1UWlIcm0zVXNzS3VxeVRseSsyMVo2T0Vtd291?=
 =?utf-8?B?UzhrdmwyekQ0dG9JWHM0S1hYN0RPVnJqdGpwdXdES2k5RXJ0YkVKTEx1V1JX?=
 =?utf-8?B?Y1FWK3dCS3pOeDRtdWJTTzNJdWtNZDdUSHFuUTkrbTZrVlZmRHhnUHVreURN?=
 =?utf-8?B?SlN4S2Z3OExkSythdlpEZzZQTHl5QlI4UGlLSUoxaFp3eUxEa3hsWkRnSS9p?=
 =?utf-8?B?dTdsakw4OFBaSXZPU3FMTWlGN1NySkJ2STdsU1NRNlc0Z3pvRzFNWUdYN0hw?=
 =?utf-8?B?RlBqWEJlSHBnTE5vSnRhWWcvMHFNVllVbzRYVXVjMTJWVWxlMWtMNVJ0Uzdj?=
 =?utf-8?B?S2UySDdYejRzcWpoa1gvdlZ6QUpxZ0V4dExVN3cyaXZZQVRybmk0WkZLcFFJ?=
 =?utf-8?B?YnQyMFBjdUpTaUNPUHNlMHVkUVRlN1dTZkF3Z2o5eDF3dEFOSVIwbk1sdmNF?=
 =?utf-8?B?SmIySVUyZkVvS3pQWkJhUVZtOGwvVGxyZEtraWdQams4NmhZMmt5UmszNHNy?=
 =?utf-8?Q?1ei20iivV9M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHBhMG1iSkZPS1RTeXFuU3BDVGNkeERnTUdmYnJjTnE3NDM5Q2RWcnNuekcy?=
 =?utf-8?B?ckVjeE5tWXAxZVc2OVdpYmZGS0U1SHE5UnVBWXNjbHF2L3hwZ1ppTUZNY08v?=
 =?utf-8?B?N3RXZHdVM3RWUDhKRTZ4akRnOHlmVmk4L0xudFdMY0Z1NUlUVTJWdjlEcldl?=
 =?utf-8?B?VzlOWWxvL3lpRmpKbDBIWTRxY0I5VGhCV3gxb0dyRnhtajlyNko3SXZYUVl6?=
 =?utf-8?B?N3NIbDBDY0V4OUpnWElUZFVVTnkveDZjRk9kNCtmOW9sSFRqRU9pUW55WElJ?=
 =?utf-8?B?c08xL2lVM2JBN045WlpUUVVXT0hSYlV0clI0WVRYV1NyejhHR0xiMHQ4S0RG?=
 =?utf-8?B?eEc2OUozdmI1bEVQTFFmZzYzRTVMc2JiMnVwbUdKU1BYSDlpMHNDTHI4bWFQ?=
 =?utf-8?B?cHlCWnNKYU9BOWRERHo5QkpUaU9RNHRZSUZhM2VkcEpLejJJUmhXRWUwWmlW?=
 =?utf-8?B?T3ViV1JnYm1WMEE3QkkvQy9CeW84eThZQ3I0REJUM3psRjZWRDZHYXJSMU5D?=
 =?utf-8?B?N0ZINjlZVEYwTU5QZ283Q2xtMmRrTUxDSzEySTdVMTZhYTQ4Y1lVM0tzUStY?=
 =?utf-8?B?T1R5NVB5dkRLZzZZOXVUazJHSkg2clZSTnM0UFdmT3lKaElKMFZ1YVhpSGxp?=
 =?utf-8?B?TzYyMHczellkVXBwRHFNVVFmOUtnYXlES2h6RmY1azE1SjJkZjl2d2dVbXcy?=
 =?utf-8?B?Ry9sd1B4T29ySEJJWFoyVEhEYitjWUwrZmFOdmpLbVlibVB3QXFXcUhieCtx?=
 =?utf-8?B?emlYenE4OFZnNjdGMi80L3g0UGhWY0phMXZvcTBQT3poZm5nQ3VVMVRONDhY?=
 =?utf-8?B?NUpGaDh1NktsUUZ3VVUzMEFRekQzYnJ6elJlNFl1Z2lmbk1SMDJmY1lwRHFR?=
 =?utf-8?B?eXdLWHkxVVJrV0xONGxNbXBJenBOYUkrZXJvdmVkenIraXQzbU9sVUFING5l?=
 =?utf-8?B?Q0k3ZXY5NXdHYXFpUThnMnBJeEFTa0ZLT2Y4djNMeUlxMHFzRDRndW1SNHZZ?=
 =?utf-8?B?VEpwNEFqYW83bEQ2cFJmNkNGOS9XckVac282UytLUnNUY2lkMVMvNC9KNHR0?=
 =?utf-8?B?alo5L2Y5bFdGWnBqblAzRllLS281RlZ2OEI1RDNIN0FLYUdDcVd6RGs5QjNr?=
 =?utf-8?B?RWM1UVB5UEdOL2FtaWhkQXVOaUxRV1J2bnRSYzNieW5MVTlmcXVGbkFWTXJX?=
 =?utf-8?B?RUlhTnZuVFYvSzJ2K0djamM3T1pZbys2MURkdkU2dHFRMzk4US9sOWNJcXp0?=
 =?utf-8?B?TStQczNWOW9OSThuc3JhcHg2MG9rcmNmT0dXUGVnNkl4TkhOUkJPYmNuYk51?=
 =?utf-8?B?YWc2UzVrbXhQUUpaZm5NZ1ZpTE5nSUdYYUNodHJzOWhyZ09iUTRJU1pnZVlT?=
 =?utf-8?B?TG5hQ2Y2UUVFbE03MDljbE9DSGlkOUJKWWRGQWJKYTNtM0xUcS9PeFhyUEZj?=
 =?utf-8?B?alQvWDBWV3JzM2dTUVVPQUFjaFdXYytxVm5qaUUzL0IwUUE4Y1Vkd04wYkI5?=
 =?utf-8?B?Z2xnYWg4U1Z6aVpHV2g0NCt6U0xCVE9wdnM4bDZ5VUkySFEvZXErbjhva2tM?=
 =?utf-8?B?SjBTdzE2eHdGU2hydVBlR0FpUUd3SGlQaHV4NGNDV1M2M3laQUJ4OHk5MjNa?=
 =?utf-8?B?aWcrR0xjNi8yWldMZG1KVGM2QXlBOEhyWnZ0bFlPVW1YcHZvZW05d1ZHejlj?=
 =?utf-8?B?c3FrcjczdVR4T2ZnS3Bqcm9GdlRCMDNBZTR6V1o0Vkl0a04rRnBmL2ttNHla?=
 =?utf-8?B?ZGFCMFlGdko5dXRXelJjaUxpS2RXUzJtR05yMHhPa3lUZ01UVURBUUQvMFZa?=
 =?utf-8?B?ZndMQ2VIK2k0dTdReXNNSDJOb0hqUDJhdGo1a29WWWhvT2NUY3VpY28wYmZm?=
 =?utf-8?B?ZWlhZlh3YURHQWNMZnMrYk1SUmxPNjRKUUVJWCt0S09pQml0NHhudDN6Tlo3?=
 =?utf-8?B?aVBKYzZsaDFiWGJwOTdPRWs5aE54SWRXeTZoSjdXRzNJMHNaRUhnUmVVeWRU?=
 =?utf-8?B?SXBoZ3pOa3hnMkZqR215VS9acmdCQjdOcXhmdXVQMW9GWTNCak11RFFzbU11?=
 =?utf-8?B?bEQ5dlRDcnhuZjUvVmJScmZyOEw3ZnlzakVKVzh3VUFMbGRnRFlDa09vSUNN?=
 =?utf-8?Q?Vf6XpYPbcq7GErcuPfgA2w3N1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UlnO9H+FVWoHO8zMDy1Tt4B2CGgMwUpKY3pC+pFguRL6JBT8N9kS1LxzH5nePw4NtIhGWB8aOfn+LgYiDNlLkiAbZKnLWx9Pil2fsXKkYh/7SQxzpLLRKlG3TvFvnmZyqWXBQKMcsYI01zAGhn6era0hC3yG/pWvTDgNwku38OMHVyTUxjKMVFzYeBW/DzY99QhjycFDBsyYCjKmv+v19z8enN22/hbc1WCGfKFWsetCURDR6F9UeoNtwZfZwedHMYIRCgwdznOdsFX4SBqPaGuS21E2G94M2bYW9hmma1zDTWAH9wel26MiDWIY06MluZI/8gvCfQKjLE36hNQnlOMYDXoWMmBRq15LNlgZJriAnnNDrlpy7iwfQ75KEWKdAzV2vlm3V/18eAGdzaRl4Hw8Jo5xk7gQcNhgeS22osckVSNP3wdPeiA3STNxR2FFgw96hhLXe9fvT3p5JU1fFlIDHLlhJIjVC8v1ZCThMeab/qCfBQJUM6XGVkemOhbl9uHUvB7HwxCZaU/s1RPNt0STJOJGw2NOmmio6jN1FxXv0pkHep6nImST+tUzQLABjTiohAwWGwWeLEDLx1D5pSxKX4t+gmG5dVQUxL2CeZg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 029ac296-f4c5-4348-a959-08ddaa50be7e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 08:03:12.9314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zb6U09MaISiZRgAo2LuVo5/6/jbPRFS0Ml3uckc3MOQww5TpoYbHS4oV7Nx8Bf1twAhjvNjxS9gziWCQOfmRCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_10,2025-06-12_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=881 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130059
X-Proofpoint-ORIG-GUID: 4LUzSq6CmMceqDCBiIHKI2gFeG0R9ztW
X-Authority-Analysis: v=2.4 cv=EJwG00ZC c=1 sm=1 tr=0 ts=684bdb51 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=CuImFZMTlsvlkkwTOogA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDA1OSBTYWx0ZWRfX3sFuF9szvRRH hxRbq4cbJrRj0StV2XoFZ+wo+nOyg8xpXxuqxPKmpxXfbPj3TBzDonJEzeXMOJ0TaYQbUS/M8gW wbVGK46vb8BheqQJvS51cE7oSZDKySRDTujW1M2PTGyvnzeyAaJrHyPcUt1fsQ2YzIPI1k5ClCE
 2WHlWj6VM6WqiCS/gez6enhaeHBSdGOfUr1z9zbkEDpXMM+sw/nvFxqiFAYS6W9q1lelE2NiAeV hKEXR0dG8zd3oeFZblna9gkm0v2cXrPezek5y2bpPOwqcP4vPU/aSW29r57NkRSEG3xiulWEiXN 0e/TfTqXqxbopAXavX1PfpyP6LwtaD/d9qfGKu2tGXJIGHgxZ8y0tXk24Umn6TmTVMu/DV5geBj
 fafU5N5K1WiFLBxETCiUPDl45jMbN/druY+0X4zObkg+IiUsSwZcyPL/rCAuORTlvKKtWusC
X-Proofpoint-GUID: 4LUzSq6CmMceqDCBiIHKI2gFeG0R9ztW
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_090355_653790_A0B133D9 
X-CRM114-Status: GOOD (  13.26  )
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

I suppose that many comments in 1/2 aren't relevant any more from this 
change.

For the immediate moment, I just want to test this a bit.


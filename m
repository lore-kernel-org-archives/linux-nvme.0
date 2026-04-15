Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B89F9D0FC
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Apr 2026 09:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bcQI+zmeRzHfQq/wYfIoP2OfZmcl8co5oFRe0mIQTEI=; b=dwixUYMLQHMHRq6BvNFw81L0cv
	uCRExAwHeB/jlQdtjBxISC4SZi4Vhi3Xdmd14U89n8iyw7w2K3Z/iBjLOvWzswpIR6IMFdrV8GbAm
	hQh/ItHNsGYYS6QwOaG346DJTFxwFHV74kzSry4w+tTG6fXusxzv1UAd6/PYfLEr+whFEExgxvdii
	lTqkli7f5h+d4xndBWeNnh1Ipu0MC2keS8kjAJXwap1egRbW8tja38LKTpiRtw5oKcc6amjuZso4I
	ghkg3GPXZk7ORDuB8Oxt4kdHQMn91civLtgCDtnBpJHdntZNhCxwwF8hKCKkBvZRBpPDvwTMweYbF
	mDqS1IRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCwVw-00000000u4t-11x9;
	Wed, 15 Apr 2026 09:26:28 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCwVu-00000000u2m-3CUI
	for linux-nvme@bombadil.infradead.org;
	Wed, 15 Apr 2026 09:26:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Content-Type:In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=bcQI+zmeRzHfQq/wYfIoP2OfZmcl8co5oFRe0mIQTEI=; b=opXG7tKV0x93+PtAhtGMPwpzH9
	WwcNRyAT+YCppE1r9L2gISZMGotaDICLt/6I8mzxZMoL1JMolmxr1YMeBr36OqnxgQJFzeAFF2WwS
	WFQZi5UoXnuNqsuhRF1bIqqKoJxC1szGTX59G3yz0myYxVjyGVoE/fWk3ncwwi4N3mZHOqWoR/G8E
	M7XYUDgHvnNEu+FYAGrvBbF0IDzXG0J028UYCc2sUBi+11tW2bPQz1o5tdgUJtjX7PpYgaSRlZsQz
	fuMwMgkhMx0zNEzOKnq4EovP8RCBZrnsqUBJWV2rJ77JfXeAoyc4MM5o5N7xr5yMk5n/lE+pf4SZg
	u7uVupbg==;
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCwVp-00000002Aex-3itQ
	for linux-nvme@lists.infradead.org;
	Wed, 15 Apr 2026 09:26:25 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F9BfSR888413;
	Wed, 15 Apr 2026 09:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bcQI+zmeRzHfQq/wYfIoP2OfZmcl8co5oFRe0mIQTEI=; b=
	OcSz/nLoUsnPAAFCIdj6HzuaKq1x8EFUaBiI6SHI1i2zn4HqZiSgYHSvm6nXlXxR
	/WokVPcNojEh/x8GrEisPmze63NjwbKATwe+gvHAItzvWrBKcvOR/iyJQxqGl18d
	G/JvpWz8bu+PhuGWN4csV/E2kt2ObNLvoym19sbcrI8XPsxMeYRxCRsliXybrlkr
	RnbnyFtAC+y9Z0MqPhbuC+T19c6H+pE9II+URwHDyVXGrdwz/TCaw8lWKMtyzr8r
	ZICwFvtK3ATz8leI6TWE/uQHlTO0OrynzI4NqStp0S1eN7Cr6AoZZ0Du+LyEkOqU
	Xejd/9hn6GXZgN0jo3eh0w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dh85jmrx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 09:26:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63F9OUMA040104;
	Wed, 15 Apr 2026 09:26:10 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012043.outbound.protection.outlook.com [40.107.200.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dh7nmwwsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 09:26:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yEgQsZH6ZpPdhzT05/r7YoaoU7pwzppmEE/vNI8JynE+4WOpeVJOEewIJoW7t9qijFOMQ9H6qaTQxKHKp+syBynkV4TtDPhAIfyVNshA+W1vmpANepDDTP5DcMgeVhaENLZmW+sH/RTNjwnORC4vLwxapHRAJSnZn2ZcpNYZwFPd5BVGPtkvVJV5+p5zf3kR1MOoJf9aKI2rWFuFgb2x8rnwjU3l6wcotQ4rQB26x0WjYLOny+zxgWbo7MjNTVdrC8l4WMx38sgmp8go9Q/ht5H8auEw4k7hQNtd3m1GTrZXstz9nm37kJ97m3R4/vf+v4zbT9L5j1jHluLMV5hYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcQI+zmeRzHfQq/wYfIoP2OfZmcl8co5oFRe0mIQTEI=;
 b=MOoNfizyyIi2WGODvNvVYydqo5wCKxt2e5KZzBB1P0E+7XwO5tdjgnG8SMyxaIqsLsPNwW5VxpYVphon2GPoZhNu17ZopmKLxF+P0Yhm8vRiljcHqcDo5+0Md4ph9hLN2VoR6sueNAnVp8c1eHG7NNAL1DEJbr2JEATqTykCGv2QYyGnVPhgK38j5byrYCaoGP7AzxpJMZjIF9lSt1MWIa9uLDXsHmkbXoP5d3a4/mFLRRaeh1TDg2g7IgpHOiIw2uYlnqnGv1SmFec50QXrx1g74tArB10JCQGqmtKHhI7Iy0zD6XHPA1dW1TKINZA44IYC/tDDgAe419yPBf7R7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcQI+zmeRzHfQq/wYfIoP2OfZmcl8co5oFRe0mIQTEI=;
 b=mMa2l2noBnua6n0S3NFuJsB1t4VQTCbnR5pRRJtP1MVUYpBa9xAl6xN7G+0v+MadxMdz1wui05li/2f/S6c98CcXtf76N1nmNJdZ0x3/JHlfSZBhO+8iTN97RTfX0Br3yb1nZan+GkxIEmx1f0jGzq9jGVxgFl9I8Lz4zNooxYY=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DS0PR10MB7152.namprd10.prod.outlook.com
 (2603:10b6:8:f1::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Wed, 15 Apr
 2026 09:26:07 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9769.046; Wed, 15 Apr 2026
 09:26:07 +0000
Message-ID: <8c068126-0b30-4d46-a07c-a4f975b7fa53@oracle.com>
Date: Wed, 15 Apr 2026 10:26:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] nvme-multipath: fix leak on try_module_get failure
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org, hch@lst.de,
        nilay@linux.ibm.com
Cc: Keith Busch <kbusch@kernel.org>
References: <20260225202109.447144-1-kbusch@meta.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260225202109.447144-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DX1P273CA0034.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:20::21) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: ee176712-fa88-4a3c-1dcd-08de9ad105ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: kq7/Ql8Qf6BQstbNGREO0b7QTnLte/BpztBo8l3iZiPEV5hAvBqDK0XmYa1cysbaNgP1kYP6pFdUSD6aRzvH1Ddk/0xaWdoKbU+vz0CExq4VQgFUjq5+HQIpEnEVu98p2ECSgHfyEgAku4ZrWvjfkUhVMYkY7DhzpPl0s3AWkXBROOCVLKFnShbMVzGOBJp72fow34GAQp6L9zOP70G2PNK8I8EJG4huUc6mHnZezD+K6V+M0pFD9nJbThn8K7FqafsxZ3dKQaLBvZUb3ukyzuUK4ABJ/tmVBpJIHQdhuE3mdqYLZTuAAKH5D7dGWXnEQwy2pzPo2NYharZ3VUC+dcgngVXE9gZJZCsBFRGAyHTzP+Fbqg0qNfhqgMghzJQfDoJph8xedxbMhn09eDBt6XqAMDl8xBgy9kiDdbmuvUbqxyhzTVmFplkIFpxY+AHp/BWSWNb01yr2+lG1tfGNh7YEwCUoEQoCVBaA58EpktKLeJ+ZsztJpWdrOXT/JSqLXWrCAlD9oHsFUbBinYQYg4f1R9VI5iY/7tgXArQzwKxuUdmomX6rPafoCXNRNBy245Q50xuK5CrcSZ8ihKHf517P1IPHSPj3r52JTfd1SV2g0mvpORIYUc+KJCF7JEbCc19JAfpN1EgcswkV8p82byCW64GP0IIHpsMeyFrD7bS7a7JzeQ+4KvigX3Nfh48vySyr93P9U0EC7fF45c5m2vjBRbHRQ2gpcdxm2NrdoDc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1YzVm1rdXQvMDI5My9vSWtEK0s0UEJ1YjhjNHJGVzBjZU1VNnFmSFNxNVg3?=
 =?utf-8?B?b0dIWTl6eG9OVmFmSWhyUjRMNGorazduTDFGY1M3SFB3K0UwWllrWkUxL1hW?=
 =?utf-8?B?UTdFZUFSSmlmL1A4WDJqRFkwdjFNWkFLV1pWajZRM3g4S0lMOUZiMWh3RHBj?=
 =?utf-8?B?U29sMHR5R0pqdko5akJQM0VrYlVFR3o5dittYlJjcWk3TVg5bkMvVlZMWVZE?=
 =?utf-8?B?S2d2ZkYzRXN4OVFNKzdqc1R5STJHU2xadG1yV1NJcU83Qy90VmN3TS94aHlE?=
 =?utf-8?B?ek5PenVKa1NBbWJjZ3VxS0syZ1QyTWJtdTRES1FGQWt0Y09lUzBsTXVKYzVU?=
 =?utf-8?B?ejZzS0VDNW1tODdjTGdURDFaU3N1c1Q0aHBTdmk4S1VLSUEyZ3F4cWYrQWRS?=
 =?utf-8?B?K2ZwNitoUUZSaFhjSVJLVFZDTE5qZGdXMWRvQjJLczhSVmtJanBjeEhVdzg0?=
 =?utf-8?B?d2R6c3pVNFkxNXlXZ1EzbzV6STFmRHV0MXNGR0EraWgzajdwZzFSdVZneU5v?=
 =?utf-8?B?VWtmbDdKdnJNRVhINFFMVkhzNStuWm9pdHpFOU5YeXRYc1oyWnpPclNpeDBw?=
 =?utf-8?B?UER5QlpIL1NOcWFFaWhhc0wxNWNNTFZKMmJFSzh0U1NSQ214Ui9NaFZ0V25o?=
 =?utf-8?B?QllpL3NjcUxrR3lCUGM2ay9HcDZnRmF3cUxhQTIwQU5wa0YxVFMwTG5pd0ZU?=
 =?utf-8?B?Z0tyYUFKL0pOYXNPVFFsZk0ySzRYRFFqN05JQm9sUkVzc1o3R2RhWVFFR3Rh?=
 =?utf-8?B?aHhUNndxMTZEdzA5a2p2amRkd1pBYU55YnlBdkFHek1OUnMrSmYxdFd0emJj?=
 =?utf-8?B?cm9hUGxvWG9vSFpKd0M1TE1pQVR6WEhmRHIwWEh4NnI4MWtSbTZxY2dxNWsv?=
 =?utf-8?B?TFpMUDNHNmNQcmt3Y3Yza0FJdWhvUUQrRDI3LzNGYS9oTC8xcU9DNThNZWYz?=
 =?utf-8?B?NHlEdG80R3hUS3BnaFJwcnJNc2ZMVDRoMG0vOGNtc09XRkhOZjFjbzdMRXpI?=
 =?utf-8?B?b0VMZVJLSXJaR3IzUXNaclQ2a2d1YnRSR3c4MDVIVHZ1SW1ZMHJ0VWZlcXFk?=
 =?utf-8?B?RnlFanhXQXVZTWNYTERWeXhyN0wrb2RPSkNTU01HenE4YlJSRUxmS0h0VW0v?=
 =?utf-8?B?YWlWcy9MZjk1QW14N0ZyeHlpM2dDWlpGcDBpa3RtcU5ZSllkYTJsdUxXMTUx?=
 =?utf-8?B?dVdIRUFhb1VVMnVKT0lpQ2lPOFNpdG5nZmtzaGI4U0JpUERickZuems2T0lC?=
 =?utf-8?B?NUlJZlkxek1kU2NvelNGMk13dmhDVlhEN3BNM2RVVnIxWm1IL2kvcUJ0UlNj?=
 =?utf-8?B?N0dVVW9oeGFaazNTZ2dhenFYdmM0RU5SSEF6cUl2MjVpSkRNTGU5WlNrWDRz?=
 =?utf-8?B?eFdWbnVKQ29tdFNTWnJJUW9TS3FpQmlHc2gvMDlzL21rNjZIRzU0VDRnc2JC?=
 =?utf-8?B?WVBDcXl6RXhFZFdYbnV4ckNXT0RhdGdCQkFSRHp2amRFV0pEQ0R5aFZOYVph?=
 =?utf-8?B?aVVBV1dYZWkxZDU3T1lUampJSi85Q0NCbnNCNk5Dc1JGNktMc0VzYTAzbGhR?=
 =?utf-8?B?ajFWVXZLVlY3SmtVMnM1dHlUMUEzMWl5S1VsY3c4dlpYRUh3Ri9DYzJoaTNT?=
 =?utf-8?B?S1hLUVJzekFDVVovWjFGUFhRR3RvVm1uYmtzeDVNeVVUTzk0cWxkUTZlV1Y4?=
 =?utf-8?B?dWU2MkNKT0N3NXY3bWN0Witaem90ajVra2RrZVZQSGw2c3FCcGVWeVZaVElK?=
 =?utf-8?B?YW5jc0ZhTzdBMFQraEJMNU1Yd0pjeFhNeUpBYlBHY2Njc0JZdHNzVGYza1pJ?=
 =?utf-8?B?aFFGSFV6cWQwcWwxdDlJYU5TNEtjMFBmQjZKTzFnOWJ6dG5LZXB6N1NJVUVG?=
 =?utf-8?B?bzFmRnlHenlaclF3Z0JPalhKK09Qc0FGa3I2NzdwZ2lnemxyQWVzcldPWkh0?=
 =?utf-8?B?dGNhQlVVeGFuN0xTMkp0T1JIdHZOZ3lIN0xjNUpCeVhZdm1OT1JLSTlsU3d0?=
 =?utf-8?B?aVREeHJUME1uZFRrcVU4V3d6NDJRenNLdndYVngwZXBHbWNFM3cxNmxTUzZF?=
 =?utf-8?B?ZVN6ZGZKOVF5eHc2YVpXWll0MWlYZ3JVMDB2NmRRakZWSEh5d1R4aWZXeEdM?=
 =?utf-8?B?OHAyTDBqZVBzSFVJTncrdCtzU2tOclFtQURnNEIvTzZITDZ0UDZydUY2STN4?=
 =?utf-8?B?SEZCSkFwVDRLNUlIaFc0VDFxd1Fhb0o1cU9pRmhZSGdyK1hEd2xwSEoyL05E?=
 =?utf-8?B?M01uYTNseWZYdFlkQTdSRlpmMTVhL3lSK3g4SnBMenFrWkE1SXVMV0JCbHow?=
 =?utf-8?B?OTh2STZNWjg2bGp3OG9IR0E1Q1RCUFRzaDJUWWNONWoyazNRNUF1QT09?=
X-Exchange-RoutingPolicyChecked: eYlIjCm+al7B3F9U6OLyRVKnQekgZ63nTaT8+L7QK5UKwSest/3b5g6/OvKQVjMuAxPJirC4iGekKjqpPil30s+fW3OnL0hKMBTlM0X7IZ9ipYmHN/1KVVun/LpoXeX737DKwfibr+UPEckbLdOOPJ5vYq2meJ1DvhD73HBe4zlHkGtGRS6DednXR0GHGRtrOYAe2iAmC1ng8KZ74t96yVXoSuxlT9NqhiK6QUeaDU/as9PKvCgfsZsu4SfwdiPZ6OldUIy+tgPTHE6fJ2Y8MtX2PAKDYYE8RzD0n4HvnavMceL1Darlsh5LilGYK2uKuB63KTRALmo67V6RM3et9w==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mJ5uHNZqCxBCsDYjbqIPy7ajlbXxriGHa1tHM71IgKRTImopROd5ta+kyJmsunOHnQw+8s1VA+2YumWU9HcZDGakIu3jAgTyEPRBG7oYMo3FYQdmaEilycmVgRaHODBWK1PoEqqc4rM1b3hCZcuFThPT62r3aRwoc8NmSX5OBW4lg41OxRpNEUQ8I5pd/vjR+nEk56MfGlbrOor4Zby8y/8EQtVtKTAJ2diw7JqGIXFl0LkRRzNPHjJlBLQDWN6NmioC7RGm4ToN4LjTRqZZt2S+rn8QauXPSCxSKxgZa4hWXMk7IkgCYzjWY7fZFGeU1mjYBIiF79EUBE6cypQQnc8TpgPlr7mOXqHE29CMyK7mQ3RgqgkdJnM1X18yqpnPmwzOQWzARepFTbAe5k2EUMrgrtK0YwtG+FUyD7oXhSkiMP/v25jR4a/3HCqJP+UE1QYPTyrG4k0KNetQVj2bLoxjrc2eHxbxFAGKJAFK4eIDWnpEAofZ+5CXocm4T0022KvqsbZ+biKc0QpvCAeVAUX5QYgknR66vE9U2MfIW0caPaIaUjffTV4+COmhh8BmXB9GfPy3IjCIWn2z/m5LK9gH7epNSMjRC77Svh6RuNo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee176712-fa88-4a3c-1dcd-08de9ad105ed
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 09:26:07.3132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fJDKlwuT3KRzYhoMcpEiWhuP5sh5bCZeJ792xuO4MdiXNvOyIaXrBDK0vSDwOFHSpa2J7Djurq0mIGKTnwDmiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604150085
X-Proofpoint-ORIG-GUID: 24qmHl4M0OUAuE2Il6QBfCq4bqzaEMeV
X-Proofpoint-GUID: 24qmHl4M0OUAuE2Il6QBfCq4bqzaEMeV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4NSBTYWx0ZWRfXwwA94LW7pwPw
 3LVAiglLgm51rYe8AkYpul7SLWQabeSnLUiCXQG42Vs5p9iZZxy4ccWjZ1trL1OFd0PSwDFkRji
 oCnwzL/1LKlgsKd6awomvb8F+P+/mi5yZMiZOjLNYxjxGwsaWU9PfRznbbPkuid4fOfoD0xphoz
 eTCjfnEXY4HHuqhSxcz07FMnYDVWd01T6D3NKC+DEWYeiKI4puphp3RGgp3Vqm63A8UByRQ21qZ
 iWV4/6c2h+ZAP1NixPgQFrLQ2A1pGnZAPoxMccwoQ0wciEZu6rwCnikQdy1FQgkthj/crn2E1N/
 ZwKa5/Z46d9doF/E34BPGDz5YxDIKdilCnnQAdNtxlygZ4t6nu1zfmyhOfpb7PVCQOGsruuoBoR
 XapPzaAyufBeHbuC63GdmFCwuaXKO/lx5EKssUsm3p2vOavU7Kx6yAOLNS+8D0NSDloWylTnuCm
 bPJkyI0jnc3QswOh6iKiukQPwSpQ91StEr2OIzXg=
X-Authority-Analysis: v=2.4 cv=Co+PtH4D c=1 sm=1 tr=0 ts=69df59b2 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=Io2QDyuNhFfytJlGflsA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12292
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_102622_457500_88E0556A 
X-CRM114-Status: GOOD (  24.62  )
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

On 25/02/2026 20:21, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We need to fall back to the synchronous removal if we can't get a
> reference on the module needed for the deferred removal.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   drivers/nvme/host/multipath.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index bfcc5904e6a26..fc6800a9f7f94 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -1310,13 +1310,11 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
>   	if (!list_empty(&head->list))
>   		goto out;
>   
> -	if (head->delayed_removal_secs) {
> -		/*
> -		 * Ensure that no one could remove this module while the head
> -		 * remove work is pending.
> -		 */
> -		if (!try_module_get(THIS_MODULE))
> -			goto out;
> +	/*
> +	 * Ensure that no one could remove this module while the head
> +	 * remove work is pending.
> +	 */
> +	if (head->delayed_removal_secs && try_module_get(THIS_MODULE)) {
>   		mod_delayed_work(nvme_wq, &head->remove_work,
>   				head->delayed_removal_secs * HZ);
>   	} else {


Are we also missing the module_put() for when we cancel the timer? 
AFAICS, we only put the module for after the disk is removed.

Maybe we need something like this:

Subject: [PATCH] nvme-multipath: put module reference when delayed 
removal timer is canceled

The delayed removal timer is canceled when a NS appears. However, we do 
not put the module reference grabbed in nvme_mpath_remove_disk(), so fix 
that.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1e33af94c24b..1b445830358e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4083,7 +4083,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, 
struct nvme_ns_info *info)
  	mutex_unlock(&ctrl->subsys->lock);

  #ifdef CONFIG_NVME_MULTIPATH
-	cancel_delayed_work(&head->remove_work);
+	if (cancel_delayed_work_sync(&head->remove_work))
+		module_put(THIS_MODULE);
  #endif
  	return 0;




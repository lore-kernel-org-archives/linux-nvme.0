Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0118FCD5BDE
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 07:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ka7dDORthkNOKSl1aIP5Rk14mK3Aj0vi6G3ZGgMDkg8=; b=yCwJ7SQr0Y1AdEzzYm9ZJaZOBP
	99G8T/+5OfcnVM8fwzxsq7Qs89lsgPP2UAFkal6D44ePvihy2XXVhY49PDLtB1WyINZRE6KXdr5Pv
	goku0qHxxJa/C6SeLzHTNFqvDnhte0ifG3/pyMIT0p9zX4T2/7roQLoPwfl77Fory24+478CHDb3R
	0vf6cKT5d4Cl2yzUw58q4zJ/WlYfWj5XkS1hEkB6b6ycTDCBpaf1Z+czgSjyPCBecfux3p0TtrHlg
	mi3Ssc3Y07N5K0DGqM+Gb5sq11rFtWsCYvodZuPOMfBfovMR5PhDId3UPd2g0i2hToQM+QcTZ/c9O
	NVOkwNnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS8jJ-00000003T3h-22lY;
	Wed, 27 May 2026 07:31:05 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wS8jG-00000003T3F-2rpl
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 07:31:04 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QN13gr3190506;
	Wed, 27 May 2026 07:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Ka7dDORthkNOKSl1aIP5Rk14mK3Aj0vi6G3ZGgMDkg8=; b=
	AbODEXTpxAeOTdMDHIwxh22fjuBEYmrDENhZKho423kdSwkK6zAkjoC/r+0ydN3j
	pKYCgNp6J+VSqcMMLqokSp2ejrLhc+Uox4JwtePSoK3e6IuDgwk7Ac2mxbla04Qq
	7sq30IrAtHdFKPVbnXvyXsbzx8yaYJSDl6TdDfR5vaDiF8AHF65sIiMs0LtQ/gL8
	yj+/AYBaFglBf/aR/wNDRx2AqdyeOwcVyOPJPPpYMQ2aq933ST1YfV0Gm7J5bELj
	PSCkO+iVY4cXcmmIMNDSRHlmg3kLyPcD6C11aWIiSr6gj49k8fiAyChKHNSyvYSr
	jriRxNcd3Ufvre1b2H6Phg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4eb47xn0yg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 07:30:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64R7ULAc040159;
	Wed, 27 May 2026 07:30:44 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011063.outbound.protection.outlook.com [40.93.194.63])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4edjsdftjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 May 2026 07:30:44 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYLqlduXBXXx12+fyC+dnKqAh1YZSieOdnhA6cF+6FHmLdOErTLtaFk8BZO+jRizwTgSGYe16GLz3wluhJtnbMvVu0PF3EWIJg52oodnyPzvIDqTlAcUb1naVhaQuF2fJHMVv3Idk23eqAc8xpp16szd7heJ/0zHq2alxFuAIaxL0aSHQkAQY383Gt6Vh5UVuxbNZaD2K+USwr1FoZdHythqofRuGhTt0XGAVSB6gW7hrMsNebtPGbBH9yIediVF8XDVq5xujXNTAxpu6GOiukhagEeCXFN3DjzqFLlmq9HHzSMQgY67c2TwT4TPIp/G8FHZK5W54qeICnRFNKaadQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ka7dDORthkNOKSl1aIP5Rk14mK3Aj0vi6G3ZGgMDkg8=;
 b=sLmW9LqyuRwXOS5GiVOdqYECDWrLrmzbEXOZFypTAyTHU6CMf84MjfZ7WqPPbtrxKebQcowQuJ5ybN6glQhIhNn5qWdlKi/kdKq03C+KX2BWdx2r6BsyujOAVBMR6CkrTUIpYl9YmsaAZqDdVI5dkcHjTeUc6gXKNfPMzmnyBYOanCuSQWIxvWA2EF651mJr+Nzt5tJYDjbJZFXT6ZCkAVTFJGKEOW4XId69E07Mz54sYn5s1LfjDfg6cIW+7Capa3U7mI6BRvoV1D2jshRInvVGVCzKZnjAiSI4d9bvehkaGWlgCGvcodvn9UJXxrBLVT/w9qnSUPwHJvNU0MM6Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ka7dDORthkNOKSl1aIP5Rk14mK3Aj0vi6G3ZGgMDkg8=;
 b=WbM/kUr/2bNyk0Bfim70yKy5CZwVf4rM136YVdqHqYVLbP0VFvPhYDm9dtk89jvgm8JMfb/pDEGlXQnznC8mQfZP69V1okFBIeeOkD85vWvihBjFsE/6FvDRhfmwE673S9rRQ/IQ+b6M4UzeYnqxNJOErbazBGHvymabFjmeI8I=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SA2PR10MB4681.namprd10.prod.outlook.com
 (2603:10b6:806:fb::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Wed, 27 May
 2026 07:30:40 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0071.010; Wed, 27 May 2026
 07:30:40 +0000
Message-ID: <888a7bd2-8d6b-4241-8710-894b6a4290b9@oracle.com>
Date: Wed, 27 May 2026 08:30:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix flex array size in struct
 nvme_ns_head
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, sagi@grimberg.me,
        gjoyce@linux.ibm.com, mkchauras@linux.ibm.com
References: <20260527062010.4036702-1-nilay@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260527062010.4036702-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0352.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::15) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SA2PR10MB4681:EE_
X-MS-Office365-Filtering-Correlation-Id: e13572e1-4e28-4b43-8f8a-08debbc1da78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: fF84YJ9vFKZR5QU5S0xt0h8Ty55Rfg6CaTeav+xWskWzZur1iIYegfHxm8g0FSqXMG6GAJstDfaH6NsiRyOUWygGxv6Auw+oqv3Zisx5GDgkCjnxzAaz1DjZxssBjy16cnmWlHB3CaiQHHplaKDgnJzLIyct0wZrDmQk4daaL7ztQMsVyUZRQQThTsY7UNcdgGD2wdXKKtI/OoTivSje5eWMRDpvFBs8QYS0YDDyMMgrdPT/szHlbQuf8vr6xJafqoyDuu+PLNwxVm92fSGBrqafYtuCC+ZqcZU7jfuKtR5jWrKzAsSi8fRPriw7fgFnmk9HPzJJwtxL4AQvC2NMHqbgR5IpvFPRmwPsDWDpsNzYxM36NstmEOskn93cSXN+j1JF2g8+F2fXGOkCk/8JPK/tLs9uGYpvKiyamMuwd6n/EoaTtM3Kiof84tLmDwxlsPoo0+/45oF8rja5X7jtWVtb3UMqO9Jzy92bAt8otG2PjpqdVDMm9l51rtPdx7feFRcdOfd+GMaxQJZg6ML2GR8NGYrpGyOXzm3+1gksMHmEJCRmoJtbou7WafCQnAlWepbf+ZWlB7EiAvPrZEFZIBKpSZBhgjz33y843cHkvhUzCGpM03+FjYg1Hod6O2nukdV0WSje+8rV3wE6SOK/Gk3G3ADVWMznHysdaF8yI3gHrpkvSeZ4nQbQlagAYOZD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTBIRWl0WDAwd1VmemVOcGJzdURzYkZ4RnE0UWpWQyt1dVAwU3g5T1dwaHNw?=
 =?utf-8?B?ZkpxK1RadjBMYUJ4ZTBDU0xNYk9FMHdlcEZoSUlqUUNSTzZnWEZoZTFDcU5w?=
 =?utf-8?B?MlY3NllQN3NEeW9LMVE1YTc2SjN5QkgrelBZSUVZM1lFeU1SOHcyd216dkVR?=
 =?utf-8?B?Q3ZUbWxlYmdsWHBaVDNiZXY2Q0lha0E3R1h5QWdXbm9UTnNzOEJrZW0rNzJx?=
 =?utf-8?B?UkRPMUJYRC8vRmFraGMrRE9tTXROblFHM3Y2Y2lWK29GUTNuRTFxeUJMUFlS?=
 =?utf-8?B?bkdmcmE5d2o2Z0ptUEcxYzNxaEl2ZjZkSEJzS0hvODJiOEFlTVpzSEpwN3k0?=
 =?utf-8?B?NmxGQm1YeTk2WW0rRHRpSGhpNHRpWlFTT1lNVHZ6b0tSbm50VTdBNTZySlVH?=
 =?utf-8?B?OUU2b3Z5dHhoNHhIV3pxQk9tL1BKR3RrTC9zUE8xamlsOUx4ZmFmd1BUNzVy?=
 =?utf-8?B?enFBclZvM3cvaHpnMVRCeWVpTzdjazZrQWx5eG1sTVNZUWhYUGljdTVvTEpN?=
 =?utf-8?B?eTdlK0E5ek5UcUdZa3MrRC9pY0V0Umtnbi9ISFdHclZPTzQzL200SCt4UWcy?=
 =?utf-8?B?WmdaNXFYbTZBQ291TlRRTndqbDJrR1BYWDBvem1oeTdSbWJvTWVqWk5SVkVN?=
 =?utf-8?B?QWwvK3BjZGVrcmVSWFJFandWUnNEOFdTWVBWamtUbjZnR010VjhseDM3UjMz?=
 =?utf-8?B?Tm9JV2hhenJUcTV3dmNybWFFcnJmN0EySURwOFRiMjJsYXJLM3NjemFXZlNE?=
 =?utf-8?B?MXdzNmVhNkVobmN5aUlIczhPN055aDNXREpEdmRyREgvUG1PRXRYaDl6cnA3?=
 =?utf-8?B?WG8rNTFwQnUyd21raWl0amtZS2NHMUNZOEI4eUdDNkxzbi8wOXV3bnA1N1I1?=
 =?utf-8?B?RjFOSFFTVUtQL1ZCQi91MmNOVTh6YUlLT1lyZkQ3OE9SWnp5d1FoazROa2RN?=
 =?utf-8?B?M3QyM0RXcDhKWFVwa01kOUsvTU91Z2lOclMrOW9NZ1NpczRTcE1BdnhBZVFk?=
 =?utf-8?B?WmJnNmN5VXMxU0o4SmdiM1hYRmdDVnMxL0Vpa1hkdVJuUWJ2SGNQc2JkUm03?=
 =?utf-8?B?OXlyc1F3cjR1blJDOEkyeHZwVGZ6b3pUVElnUjZ1VE0yaFZLUmtCZ2FUMUwr?=
 =?utf-8?B?RlovQmcrclI5b01kSWxlR0wrY2w3TEd6RGE5TFhFcWR6ajMrR0tmYUtDcVc3?=
 =?utf-8?B?NmkxVzlhekp5SjlPR3VFOE83dWpYZFJmaDVqY0tXQ25aNmpkWFd2K2RGa3ZN?=
 =?utf-8?B?YzhsVFYrU1NlTzMweTd1eTB4WTduT2NLRmRxdC9QdEgxdDlodFFOSEhtYzNm?=
 =?utf-8?B?eGhpaTczakJSZjRTK1RncUhBYkN3MXJjNTJHMndjYXNzSjdKcmF0NTdVY0Vl?=
 =?utf-8?B?MFdvNHJHbkpUTEZCc25OaGFYTE1aMENHYUVDQjFxSU1kZlJRUGNDZXhrSHNH?=
 =?utf-8?B?SkhkOVlZb0dwSnMrZ0QvWlNGNmd6UDVRdXJCZkc1TEluMys5dnBLS292N09O?=
 =?utf-8?B?VVZOOTM4YkVZdlQwNkk5MS92cGs2VG4xVFhtek5scVZZdVhLeUxMeG9TallT?=
 =?utf-8?B?YUY2dDc3enl1cHYwcW1NYnNIUmM4MDhxdHpOTGhQa1VCemY0Vm8wV0xKTjR3?=
 =?utf-8?B?Nkh2dm9aNk9FTkVpNlhrL1MxUC80NzFwSFY4ellZQThwZG5kdW5ycjFWcWNB?=
 =?utf-8?B?QU9qdWxkcHBoSWNUY2VuaXdCbnRRdjlTM0pEQ2Nvb1NTNUVncTZWVFBBTjl6?=
 =?utf-8?B?NGdIeUphNG9kY2grcHp2SmViU1A5Q1g1SjNHY3VValRBdlpwSGxCOHZPU0sz?=
 =?utf-8?B?aUlJV0ltamdyaHN4TzF1RVU5ejE2UDZhNGc2WHgraDJtNWtCMFJUY1RyZDdr?=
 =?utf-8?B?SGpvWW5mamxpaTdVM3hENmZsNk1IVUhtblIyVXRNcFUweTgxajFHK2M5Lzll?=
 =?utf-8?B?SUNKQVpySEFQdVZsWm8vV0ovbU9Nc3REUWYwMHUwQkk3a3M3UGtBcTI1RVZE?=
 =?utf-8?B?L2VrQ1duVHVhaUVmMTliWDB4R1lUTzJVNkxoU1pSYVF4SEp4ZUt1cDdaRkdD?=
 =?utf-8?B?NTFZUnlmL2V5L2E1bnNnVkFPUjJYcUJyUWdzZThxelRZQ0Fiekc0eHRsRFlW?=
 =?utf-8?B?eVRoVGU2WFlNZUU3REowT3dZRkltUmo3U0gxOVA2QXQwdlJBandvUzBKTjA2?=
 =?utf-8?B?eHNnT1QvSm9JU2dqWGtyVmdpMi91bXlpOVNsclpzcWZudlQ1TDZIVXdyWGQ4?=
 =?utf-8?B?UVRLRU53S3l0RWlWK1NqSTdGaURJQTNuZThIRzN4eXFRZW5qc1pUdlN0ZWRF?=
 =?utf-8?B?RUxHSEdSZjNhT2ZiNmFOSmwraFBQL1JFRE51SzhRN3ZJOFlTS0pnUT09?=
X-Exchange-RoutingPolicyChecked: FpI5KzDIphSD7mV9bFTIUnQrLCZbXFSL0v9oLdojyCz++HCspALu3OItRwEccUxvnmuMAkcILAqufyZsgHTkrMj3bcltE8Kg+E1SCkFVJlYZCP06KHpKuifV0cKNSp+clrHpMPEyvyHfUSn7Fzn7rc24EKnfCDpA95hWBP8DJGTTg1qkbuyzcUM/VRRzgpswXUjxn/3vohoiEkRYLcK/uDJ3BsiEmr6EjehDp8btObEy8a+kaJrekkop8hKFt1ahlbsCvmorC8IdE5/zCKbdLeshN41sBQirkubH9dPVARVD1juqUaRjX5p925BOTyWZG3BDDjDWINxeoAA0u6T2tA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xgK+urVmZ2S6xGPdILf3spUaCIOQuFwuTc9IL6prdPSUTPjTpgE2hsW0ZG2FU/v8ea/0fpAT7CN39iS6shvKA78HEYuRISoPaejmK4LOisjkENNz7MJboWOz6sZZyYSj1ZD7y12CjlMybgQIYPo7UZhtaDWeD3eYLr9fXQTe5l6b4l/hUUEQXFHdX96mf8v51eYHyW2ztZ59yHHmoLEEhTEZffu/aDHsILHdjVB+umeqnG3NNm+TmLEx43mjpVD4H/SDEXKCu7GToHwUFU+Bnlj/qhjnN7raSPWJWGrbOSngjVguk3Mnuqi33Ts377sawvQXKOXXvTghbb0EoKuEwG4D27ZRs9vt0jnVjIeNEzb6gcwHwvTsjuKhMWRhClZUvrJ2ZU+pn32M5zSDa3hgrtDGL2zYlix0WXKFkf4gBF4hYEzwVY+l8jEo2KUZKPy9KmMGRCtBl8jYJEPDXnr63Fo0ugRWPqJVdkmm3QEj0MzxaU/Aez9zPIpK2JulgdpQu/DlYzFZGuPDYwCdd8Nl18R6P19yY95JrPLx8tWxYAAm1LhBsF8r3nak/lVCRWilK6dpyFrC19SDSL0iNRS4wiIlMZTxqSlK7kbpQsuPU8g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e13572e1-4e28-4b43-8f8a-08debbc1da78
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 07:30:40.4375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aO4CyyqLifL1/8D0rbp5wnZkdH1sBJcODND6Lmq9iqV7MKv5eiuBxhA7U0pbFxuPIXt4IV15Qe2ywTpaukyz8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605130000 definitions=main-2605270071
X-Authority-Analysis: v=2.4 cv=MMNQXsZl c=1 sm=1 tr=0 ts=6a169da6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=x0eKOSpe3m1H3M0S9YoZ:22 a=VnNF1IyMAAAA:8
 a=yPCof4ZbAAAA:8 a=Vi9ffeDbZ69uNDMXyEEA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13706
X-Proofpoint-ORIG-GUID: 5JSSb10OAM-L_2IKhmAQo2PRpMvjs9eH
X-Proofpoint-GUID: 5JSSb10OAM-L_2IKhmAQo2PRpMvjs9eH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA3MSBTYWx0ZWRfX1WMxWsj4y81G
 SKpWP1TVO2DeaWUZc206Sf56bgj14tVTFxTryYZu4+Ic+kdR6SGbNtvIR+5LP+1szianlb3kL+E
 apj0SHui7QqtyYSMULJfusNMHlzt6zJMxMvi+u9p/2VFXTbJUcRtkRO/zGjCuVsKWo71kb8SHPw
 wu4uJvWJW9R9nJ3xjXmdB0XxuP5wkdbHXM4ZYhBIJEnMY1lNXT7CLFN33Jy213FIwwWLnWO0Ozw
 gf2+CNNUNvgDGrOIZ378I2AlGVI3h+sEwo88iJOTkjdtP8Ws2YQLR6Q921wuZvbUkUDN0YL5res
 hFBJgGgPKOmJg9fBpnW56cmscqILYJLIIXS96eUHwHcnWbl6G/iym3Z5LJGRvPiQ1CCo5xcLLsE
 aeYwMfy+z4ZDedFIUZDPGq53n96ZF58mUbgy81aDFhmKrrEwMBrNNWTBxRq0Xnf8MVjxnFgCllg
 5TZ67Vj5J3rf0gemZ/SlidLoCuTgN5qf/hWX9B9M=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_003102_935934_3EC5E0D8 
X-CRM114-Status: UNSURE (   9.48  )
X-CRM114-Notice: Please train this message.
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

> 
> Fix this by allocating the flexible array using nr_node_ids instead
> of num_possible_nodes(). Since nr_node_ids represents the maximum
> possible NUMA node IDs, indexing current_path[] using numa_node_id()
> becomes safe even on systems with sparse node IDs.
> 
> Fixes: f333444708f8 ("nvme: take node locality into account when selecting a path")
> Signed-off-by: Nilay Shroff<nilay@linux.ibm.com>


Reviewed-by: John Garry <john.g.garry@oracle.com>


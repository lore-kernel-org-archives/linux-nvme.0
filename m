Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0904CDB470
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2026 07:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OyaC/dvJhTJP2Kpch2ftEpJecD/G+esGwzqckYHMkI0=; b=0q9yeV59KDpjrTBsaZIlYkJ2LZ
	M6ncaozrjJ03MiJowshToaS2bcfjO35NLMuaOCNDyg0RDUS7SQjJZQxu6A9VI0D59Rfu2uVYztgyT
	2CMK+kJYgBR5BCrzEy4mJUDYbwnjsaDzTgXSWZLcD7DH7sJWJPxDM0RZSkcTvaDA5T3jbhyKwHox4
	R9tOf6s8/myFG7TBF5fyBdHpSLBfbzYbitLA0fqe5Eab6Ywm1Vhvcr6V35NraLeE5h+Drnjp9kteU
	PGAwjnuGjDLuADNziFmR6Oy/Pwx3eS5UvjZve/71YccNKpiTKTriH0Us04gnJFjk+t2c+ed5h0sEq
	k7k3idaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcIAe-00000007KSb-02jV;
	Wed, 24 Jun 2026 07:37:16 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcIAZ-00000007KQL-0LRb
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jun 2026 07:37:14 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O1wge6061117;
	Wed, 24 Jun 2026 07:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OyaC/dvJhTJP2Kpch2ftEpJecD/G+esGwzqckYHMkI0=; b=
	TEiVThF8ARUPjVbmB0SX8q+JUkXJSeArl+1++AIzTOziqlL7gCfmj1KAlk/DQvji
	MUzaz3qzk3HMOwbT4OawbdStBfbobGWQq3Z15i+7uBnJux/3rnL1fcF52gpYIM5v
	6CShOyQJBCr9umXJT4cLyLrc0HaQ8qFiXeT3teiANxbD2ZwAHp/EAq/uh6GhqneZ
	MtPBv/SPl2HXm43T0YmgQW246e3XUUgCGfaYIqmhKjlhzccnC5maFYn3HkHG7IdK
	+FRyB/9Kl7KQtVNirJMetBF8YW5xcCDRsD2c7q+qs+g+7r5IXQ0Gz4axBVVU48ro
	mBDxf63gpqeKPEAwHA+mSg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ewjfucy9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 07:36:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65O7XO8O010475;
	Wed, 24 Jun 2026 07:36:50 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ewhad2wqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 07:36:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNzy+KbTCUMfXjxyZ1nFwJd7XLY+FzijN+0oatuDuuhFOTyrcCXTsSneen9MaJQz3U6eycNUsUcLC+AU7VeCA+h7Wti6B0oizV4CASbTSBTGDc0IbSXXAUcnRIvXkHLSS91VKJZWgL4HtW7DWVOjt03H1i+YWYqgs4XffIYCFGig14ZFveRKRFn54kNL6BjQcHy4pnZxZn9wyH3nSiDY3GCvc7fmaxAJ38hyYMHoJTOgLy7p9BpjA8cq7VLWxzEUgp//0+EtZYfIU2wEuz5KhLrkl+UxaPIvu3cUDfzvmfaPyDRfmI97KfhMfEm5cex9N0s9C1qcgWCTO2VoPVodcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyaC/dvJhTJP2Kpch2ftEpJecD/G+esGwzqckYHMkI0=;
 b=i4sBJu+1s8cElVrmEBdmXADEnpNtr7ICkYOqRTrHkwJ41C4Vc4kLYTdwjpc3oEj65Q/gkHYoFENR7cW9CEUIdtDzum8NJkHQfEFxFGbUpnZogO3vVREQn4bN0Yb+sIOF03cTP4EAWsxCLdAe2GB7OrU4g0AQKqs5M/V1E6rhuZRCYxqi7QOJeWDW4rb5XVqXovjxsyfqhyqObhw6Z8FPF+88wkHiixT39uUhmsejV8ItC5nozK3rlLYdlwVkOgiRW2D20zSbiVoZvCmkHFw/IuAa1gYnKrX+c13HwvG6NFY0v3/ODc8MmDHBssTE6DHIVYMKb62qsskTX2y2y583Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyaC/dvJhTJP2Kpch2ftEpJecD/G+esGwzqckYHMkI0=;
 b=Z9VZZh+D11Bd7/fd/ixT6FlDaPIvMM2zARXM7hgsI33OCIpv5lcjtgQiLJn9lGfjCCARy4udwXpGMnHOXw1EUtNkAREGSRtYtTJWCpPUg6nX2ix2zZvI2Rw9a8c8XBeXcMpacPM1aLLmb9q2cnt//sctYaB41wqrFnnER9/MBwY=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CO1PR10MB4785.namprd10.prod.outlook.com
 (2603:10b6:303:95::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 07:36:47 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0159.012; Wed, 24 Jun 2026
 07:36:47 +0000
Message-ID: <01e1bdfa-2917-401e-9ffb-a2229798e542@oracle.com>
Date: Wed, 24 Jun 2026 08:36:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] nvme-multipath: expose path_state via sysfs
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Nilay Shroff <nilay@linux.ibm.com>,
        Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20260624054843.1132083-1-kanie@linux.alibaba.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260624054843.1132083-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::18) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CO1PR10MB4785:EE_
X-MS-Office365-Filtering-Correlation-Id: f283e0dc-039e-4f72-a8a6-08ded1c358ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|22082099003|56012099006|3023799007|18002099003|6133799003|5023799004;
X-Microsoft-Antispam-Message-Info: cHWZOsf5U4Q5nnWmc21RwFolvQ93ehZ2ULMtYOzr/DG84F8LwgNsdckiY7JngD2zqc+RDn4ojIqrpj5mGyV0sS6a55BxUQlhmonBYaKn7AIMwWi427EzF3GVZzVQYgpUCuUp6xpxhsAd40Kj/7XEdUgdWrgAS3yZfp7QvbxiTixdZdO/Fi9/eYClyjyBAYvlzRaIHxlgpdoGegaAlz+JxqYiJdaNsxP/nq4uZqQMeo3iSoicPI8vCYwgxYc6elWTU9wKh4NHas38orKCow7qZhuB4JLvBA2bNRoOPCV6YNd4ko/ZOpzZMwG6ELdtCCZD++Q9BADplRC6fWe1JO3JymwbyadaoUO9shmzjE9Sb8ywznGEzrM0hVOFkH61uS3H9vetwt6yk7UVMuur4jQnjqrjZdHafhp/M/7linCUlnucoFd46VXoH3Zso0dL9niFV5gPd6rnOV/ykR7hCn6GshcttgwTNLO3AohZV8fHN4ZwS8Va4HMo3Mo2CJ5HHtuk2O6ClUpA1vitV+1Siz1PsUxf2XR0Fhnao1n28Jv9R2g58d5WlQnkAO9i9H2AX9xcuDFYN8yVk2uzsmFC/6NMc37KxeTNeVQ2+w5TKLt0/JuPV+sTtxrAhgaQ/izBvno7lserzTblmcbxxV7AwXEAIf7JMVIclRJLvE/qs+YJo6Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(56012099006)(3023799007)(18002099003)(6133799003)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WjFRaGd3VmJKejIzWDYrRWt2RGpLMEZ3SG1EMXVYa0Y1dlFORk53R3V5NExo?=
 =?utf-8?B?SytIclo0bWk2QXZ4VjhMbkhEWTR4MUpjQ3BlTzVWemFEWlBuVUdJT3VpdUVo?=
 =?utf-8?B?WDR4RGxxNTVRa0NVK0lYN0w0QmFIRWx1ekErR0hLMC85WE44OHN1SkJ3aGdo?=
 =?utf-8?B?d255SFJmM1hDY3I0T3pzbC9ISTBWY3FRQnc1L1hraWMrZFZNc1dPTWRiUHM2?=
 =?utf-8?B?WGNiazl0TllEanFPd05iWlEremdReWdSNWRMVk9TTFhqbjRtY0twUnRnZ2oz?=
 =?utf-8?B?SEU2MytyU004ZVppUlc2bG5SNElZWnZPalI3OVMyenVTQzBFYURLamFlY2dQ?=
 =?utf-8?B?SFNFbXQ2cVpTMkpQVWthcWczNHVFS28zNzhoNjJQUTFBNno4UGZkZE9WRmdN?=
 =?utf-8?B?cE45M3J0Uk5TczBXVDNEWmpCU3Y5WGtFWlkvdzRYL2RkQmhxOHFPYStlQTF6?=
 =?utf-8?B?dUx2SWV5VGx6ZE9FayttaGdFVDU3ZklZMHpqOVEzOW9tS1lHT3JHaWZ3NTRK?=
 =?utf-8?B?eWsrbHA4VUh3UHR2dFhUbHFLczRRaFVsNTMxbktmbmVIaXo2TUN5azU4TWVQ?=
 =?utf-8?B?Vzg4NjR6K2ZrakoxeXhrZEZISTAvNWh5SnY3SlVFeXYvNVRxbU9teEUyVHha?=
 =?utf-8?B?MC92Y2pObEtmSFNtSks1WEZQdyswN3ROSDliTWVkcXo4S2pneHVPU3MzSDRt?=
 =?utf-8?B?OEdrN0RYUTBnYlZkWVBKN3FNYXpuWjlwcjJlNzNwL21STmZsNUM3VVMvR2xy?=
 =?utf-8?B?MDVUcnFYQVBTWmJLSHRQR1BxYUNhR2x5ZXRXT1J1ZU1nQmJnVjNWczArNFNJ?=
 =?utf-8?B?UmVXMlc5TkdpalAxMUY3a3JleXE3MlFFNG9zSGFQODVBSlVaQWlsYU1KdU80?=
 =?utf-8?B?UXJRb2gwNXpQTVRLOU4vRTBWL1JrOSt1SFFYMkRpWG41dklOS1FpSlUzN1hj?=
 =?utf-8?B?U1BmeUpjNmxLYnVyTXJxQmMwaWpDOFh1Y1VmODB6ajFwTy9Pb1ErZDF4NlFw?=
 =?utf-8?B?Rk5xSlBCTWNWUjdjRGNWWmlid3NmYmZ0VlhMNUFhOWdFbFVGYUYzN0MrQlhV?=
 =?utf-8?B?K1IwWmFjcFVkVjNTSmVPY0o5Y1lDais2MGpXWGNHVGZmWTU4WDZOSU5FQkNy?=
 =?utf-8?B?QjVRc0twRGNCc2tTbDZUZ3RRdkZwVmF1L1QwMWN0SnVoMExtWHdla2NTQnN1?=
 =?utf-8?B?NWZOelNwK2VYMWxOcWd4NWxjYWJDZ1VwUTl3OGtaR0p3Z3IrbVNTV2hjTFMr?=
 =?utf-8?B?QUFxRjNGK283LzhoYS9MdEdkK2lxc3RwWGI5N245RVMzNnNEeWl0dkFQNGtI?=
 =?utf-8?B?U0M2dXBTTkJncVVmWjBpV09aRWRDbDZ0K2gzL0FnMUg3WXoyZy9HdUEvLzNh?=
 =?utf-8?B?ekwzYXhuUFpuaWtxMkw5M1p4bjZsUndBd0FLUXdFeCswQjhrU0UyRjFkckE3?=
 =?utf-8?B?Q2RjcUdoOUxNeWE3Ylk3dXZQcGRJREJFajQvdDdHdWdjT1U0akN0NmJmWjNs?=
 =?utf-8?B?SW4vY05lQ2JQcUp4eiswWFl2dmhDUC9TTitOQWZXbEdyZm4xa3NxNE5mUWto?=
 =?utf-8?B?TFNzaWlCNXRwd05GMWVLUit3NVgvWWd1a0MvTjd2dGQ5WkNEZWh5b2RDNC83?=
 =?utf-8?B?TlEyKy9VQ25zeFFiQVZRL3J2enZzd2N3SWxxdU9oM0RMdXdKK3NvVHRBZmpJ?=
 =?utf-8?B?dDFCUUhsWmdtZFdPTC9kRFdablA2cUhCOENva2loZDFZMzlnZm1YNk5pZVlM?=
 =?utf-8?B?Z096dzJ0eGk4VU81VWIxNTZvU1piKy9jTkZRQ05VcmVNMTZ6SGQyN3JobUEy?=
 =?utf-8?B?Tkg1K1hjSzdGdUpkcFl6L2N1YmkwdHRmeEQ5cEhyQzJUV2daWUVWWmhjb1Nt?=
 =?utf-8?B?cHpid0c2RTFJK2F3T29JRVZWOU0wOW8wNFVibysrTytQbDliTXNXU3VnQXRL?=
 =?utf-8?B?bWdmNTNVM1BhaTI0ZGVWOTE3QlhVZkVYK0loWnBKNmJjdGtTcGNmbkNyTy96?=
 =?utf-8?B?L2hlMnBPQnFOeHA0aTVjL3ltVFViRW5lTHB5THF0RWYwWkhwUmI3WnphaDV0?=
 =?utf-8?B?anRkTUtxNWtJT3AwdmZ6VVpFNmhiK0NhaWF4ZGRMdXVOa2tPM2tLaVVoMFFG?=
 =?utf-8?B?ZGtyMTQ1UmJ2WnVvNVBnbm4zcnRtNkhiRW56TTlINnhOaEJUK1ppRnlZc0w4?=
 =?utf-8?B?K1h2b1doMFN3aktqbDJpMWFFNmRBMWdxNi9sNHRKbDdsOWZUaWNYeXMzZTRT?=
 =?utf-8?B?WjV6VTFEQ1ErbFc2bmRLQU1QWFJnSTFJejNvRU9CbFdLY2RaeVBodFlRUEhH?=
 =?utf-8?B?Mzh4cjZaTlpLVFAxeGhqWFc1S09zQk1aQVV3eXRkOW83eHcwNkVQdz09?=
X-Exchange-RoutingPolicyChecked: iDVbHWAWUT7nICOJyrQIibF3nQbvO81ovLvKoXIc6h8dzoWtyxN+fQAFo3e9w06EPKUV+xL4zoJIY4DukQnXGJuLI5/cGWl39X2IVzc1q6aHwnD63lFbie3moxeMHIfEV7NOmTwbYrK3XKvOu/U+ZxJjdUe+Ee1ZmkV0SMyE24Kdxd/7gxelGhUdUUKhN4q7t9KVrQaKv6M51kxTWVQZOA+E17WVElnLPQLXJKslJAQ9RYoelXt8kcq8V0slfCGCGzJyLrTx1NBm5knJuuH2REvSvXzQfbsg7M9zojcQyzCBICUPytmn17+HW54U3cpcjfoK//EMK0TDPzfZzSgw3g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xcukMNLCeIqQQoEmNG6aO573jg6HaBc5efq61o9lIIuALBWkXY/UN6GpsFd279XEmeAlusFI1Bnpaeg0Q+pRZRMZa4RAmncGzrhtAJsQ6fZlO/qfYbE7hf3vZmG/nCzhM9cPM3IHeWv/P83pIiP5GsNfHWn3Oe/vFYWZlOomzOf5wAjnTH0iCbHLwqf3RgcaluZeAn8VmiQOvrjrcN6BatNXoWcuQihRUC4Cfj0+NyhQSKKentszgZ7GGHUmpeGRxf1xfW+PBOCOZhPJbq++yxPFYfpPJoWPLTm/nNlMT4OSa4xMKDW7bbchtDpu9GcP60v2zx6nr03HIZDD/2x0U42eQPetny6uRtnuKeqoHDKCHALqXTDSH24GtUB138AYg3awEA0hav32hGFJzgxSfqZ7umtp2CyquQFW4uzxTHKDKdpDJwzoJTTTGzAG9X/z+oV36DGq0P1x9Zxhl1yHX6ic0INnIK0NNL8rFQSypOIMpUxo6LhbCKe3RUgz6y4QCx3e/KhDbYdE0jE7AjDRUvDchesjm9uqOGddLOPbgLrT2Q0ECOQSVfeZPyDtHsDlNGk98sDp7pYLSBiD2u/UuZvyAVpZUJ6AM1ZXHiDL+I4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f283e0dc-039e-4f72-a8a6-08ded1c358ef
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 07:36:47.6318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AGGYhMsuGzplSWVsbptPtOpwSZxuUbpO5nh49NTbEZMnbDZy2PvZNekaQD4MRAihXicHyp/vEKdXNeZ6GqNfHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606240061
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2MSBTYWx0ZWRfX1NnRr+MQ5nV1
 s5WpiY3Y/9gmM/zRrEO6Pk7ASlTZVT+dLVIVVeSKEtA2eep/dOnZYWVTvw6fuUGRKzSAOTBbOXA
 uWp7ciuKj5rgeZXVxWt4uCf83+XQDpaEctjBvhPeg9/FhrgRgKkH
X-Authority-Analysis: v=2.4 cv=FtI1OWrq c=1 sm=1 tr=0 ts=6a3b8913 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=SRrdq9N9AAAA:8
 a=N7MfbjGR5Y0c8pV4m5UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 78izc0cyQPozHQRISoafj9hWuOlWZhOM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2MSBTYWx0ZWRfX18jKdfBp5K6o
 MMBaYIEtulD0qlWM4C0HJTC5Y1i+d2ctkwY1V314SwwSs860qb16jXMLA/JdWDJ3HUkj8TBOGdi
 BRyYHS3Ne1YMkTECQ4Xt6Ih8tOO79U4zCrOjLiLh2NrH5vu19w075j4Csna3x1SrMduW4glqK0T
 jjXPmDBlVeuStIPZoLmWpjQFsE8VgOY2xq0+NcVlSamUJziNLEiT4Z8p7ewV3odk9XkvozotGDY
 FwIWRRvjo50Ub3y9r6CiFGwxU/zPpNd67KhdPpx5Q7lftmyJR8qFi8gW+hBkpXVdUJgLLVCufnF
 hOfUHq6D36M6N/FdmSAzwOm4OBi7/W9Kl3j/aRhpqb3IbPsILikkVZ1P4fBhWMZdKKEwF++6PWh
 SZxuw7oPWgoCqnE+bXwfeTiPKhXOXNFcNyNKSl60f59yNO+l46g8TDSAnH7DdDgbdDULEhAUFFl
 jTo/nJPXarIjirAz4lw==
X-Proofpoint-GUID: 78izc0cyQPozHQRISoafj9hWuOlWZhOM
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260624_003711_566179_645FCB30 
X-CRM114-Status: GOOD (  21.94  )
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

On 24/06/2026 06:48, Guixin Liu wrote:
> Add a read-only "path_state" sysfs attribute to each NVMe path namespace
> device (/sys/class/nvme/nvmeX/nvmeXcYnZ/path_state) that exposes the
> current path state, including whether the path is enabled or disabled
> with a specific reason.
> 
> Factor the path disable checks from nvme_path_is_disabled() into a new
> nvme_path_get_state() helper that returns an enum nvme_path_state. This
> keeps the path selection logic and sysfs reporting in sync, so any future
> updates to the path disable criteria are automatically reflected in the
> sysfs output.
> 
> Possible values:
>    - "enabled (optimized)"     : ANA state is optimized
>    - "enabled (non-optimized)" : ANA state is not optimized
>    - "disabled (ctrl_down)"    : controller is not live
>    - "disabled (ana_pending)"  : ANA state change pending
>    - "disabled (ns_not_ready)" : namespace is not ready
> 
> This gives userspace visibility into the multipath path selection state
> without requiring users to piece together controller state and namespace
> flags manually.
> 
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> v2->v3:
> - Factor path disable checks into nvme_path_get_state()
>    helper returning enum nvme_path_state, and rebuild
>    nvme_path_is_disabled() on top of it to keep path
>    selection logic and sysfs reporting in sync.
>    (Nilay Shroff)
> - Distinguish "enabled (optimized)" vs
>    "enabled (non-optimized)" based on ANA state.
>    (Keith Busch)
> 
> v1->v2:
> - Show specific disabled reason instead of just
>    "disabled": "disabled (ctrl_down)",
>    "disabled (ana_pending)",
>    "disabled (ns_not_ready)". (Nilay Shroff)
> ---
>   drivers/nvme/host/multipath.c | 47 ++++++++++++++++++++++++++++++-----
>   drivers/nvme/host/nvme.h      |  1 +
>   drivers/nvme/host/sysfs.c     |  4 ++-
>   3 files changed, 45 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index e033ede953cc..2da5e9da1866 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -288,7 +288,15 @@ void nvme_mpath_revalidate_paths(struct nvme_ns_head *head)
>   	kblockd_schedule_work(&head->requeue_work);
>   }
>   
> -static bool nvme_path_is_disabled(struct nvme_ns *ns)
> +enum nvme_path_state {
> +	NVME_PATH_ENABLED_OPTIMIZED,
> +	NVME_PATH_ENABLED_NONOPTIMIZED,
> +	NVME_PATH_DISABLED_CTRL_DOWN,
> +	NVME_PATH_DISABLED_ANA_PENDING,
> +	NVME_PATH_DISABLED_NS_NOT_READY,
> +};
> +
> +static enum nvme_path_state nvme_path_get_state(struct nvme_ns *ns)
>   {
>   	enum nvme_ctrl_state state = nvme_ctrl_state(ns->ctrl);
>   
> @@ -298,11 +306,20 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
>   	 * Otherwise it will fail immediately and return to the requeue list.
>   	 */
>   	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_DELETING)
> -		return true;
> -	if (test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
> -	    !test_bit(NVME_NS_READY, &ns->flags))
> -		return true;
> -	return false;
> +		return NVME_PATH_DISABLED_CTRL_DOWN;
> +	if (test_bit(NVME_NS_ANA_PENDING, &ns->flags))
> +		return NVME_PATH_DISABLED_ANA_PENDING;
> +	if (!test_bit(NVME_NS_READY, &ns->flags))
> +		return NVME_PATH_DISABLED_NS_NOT_READY;
> +	if (nvme_ctrl_use_ana(ns->ctrl) &&
> +	    ns->ana_state != NVME_ANA_OPTIMIZED)
> +		return NVME_PATH_ENABLED_NONOPTIMIZED;
> +	return NVME_PATH_ENABLED_OPTIMIZED;
> +}
> +
> +static bool nvme_path_is_disabled(struct nvme_ns *ns)
> +{
> +	return nvme_path_get_state(ns) > NVME_PATH_ENABLED_NONOPTIMIZED;

I don't think that this is a particularly robust programming style, 
since nothing in enum nvme_path_state explicitly states that a very 
specific ordering or grouping is required


>   }
>   
>   static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
> @@ -1101,6 +1118,24 @@ static ssize_t queue_depth_show(struct device *dev,
>   }
>   DEVICE_ATTR_RO(queue_depth);
>   
> +static const char * const nvme_path_state_names[] = {
> +	[NVME_PATH_ENABLED_OPTIMIZED]		= "enabled (optimized)",
> +	[NVME_PATH_ENABLED_NONOPTIMIZED]	= "enabled (non-optimized)",
> +	[NVME_PATH_DISABLED_CTRL_DOWN]		= "disabled (ctrl_down)",
> +	[NVME_PATH_DISABLED_ANA_PENDING]	= "disabled (ana_pending)",
> +	[NVME_PATH_DISABLED_NS_NOT_READY]	= "disabled (ns_not_ready)",

some strings are abbreviated and some aren't

> +};
> +
> +static ssize_t path_state_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
> +
> +	return sysfs_emit(buf, "%s\n",
> +			  nvme_path_state_names[nvme_path_get_state(ns)]);

you should really check that nvme_path_get_state(ns) does not exceed 
indexing into ARRAY_SIZE(nvme_path_state_names)

> +}
> +DEVICE_ATTR_RO(path_state);
> +
>   static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr,
>   		char *buf)
>   {
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index b367c67dcb37..da59364d4774 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -1072,6 +1072,7 @@ extern struct device_attribute dev_attr_ana_grpid;
>   extern struct device_attribute dev_attr_ana_state;
>   extern struct device_attribute dev_attr_queue_depth;
>   extern struct device_attribute dev_attr_numa_nodes;
> +extern struct device_attribute dev_attr_path_state;
>   extern struct device_attribute dev_attr_delayed_removal_secs;
>   extern struct device_attribute dev_attr_multipath_failover_count;
>   extern struct device_attribute dev_attr_io_requeue_no_usable_path_count;
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 933a5adfb7af..500d773300e7 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -261,6 +261,7 @@ static struct attribute *nvme_ns_attrs[] = {
>   	&dev_attr_ana_state.attr,
>   	&dev_attr_queue_depth.attr,
>   	&dev_attr_numa_nodes.attr,
> +	&dev_attr_path_state.attr,
>   	&dev_attr_delayed_removal_secs.attr,
>   #endif
>   	&dev_attr_io_passthru_err_log_enabled.attr,
> @@ -294,7 +295,8 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
>   		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
>   			return 0;
>   	}
> -	if (a == &dev_attr_queue_depth.attr || a == &dev_attr_numa_nodes.attr) {
> +	if (a == &dev_attr_queue_depth.attr || a == &dev_attr_numa_nodes.attr ||
> +	    a == &dev_attr_path_state.attr) {
>   		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
>   			return 0;
>   	}



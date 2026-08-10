Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 367BDC5AD4E
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 08:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wl3KEFhqk6fxco6m+UOtWtR0Vml+ZZsNGL4SBiiUH1E=; b=3/WgJOsX8db/I4qV3HPXRpCnQq
	yeR9cqT3c5MSv6Zzy+VdFT44tQjlS1yhxV/s9IrTiDhF62mCx9q2EUzPX74Q34h57ueo9ApNhHmMI
	vOc1PIX8s8ZZo03GBbNU04+WwVmcB4p3PEgbUnPWUtPg0Ta2hhBU4ZVgRXpfVLbhc8Rgk0BVCgr0D
	FQwJdUPUAVw5tUfOREu9lDdroNQ8jWtHclUWvMhkJd479uqmiFsV/Uj0KVkDiR+fcXGi3RpQNvZvq
	qU6NsFKVCkHGbyBbao5DbdQeEh9jJDt/+iKLzhGnT3UA9AjQiwcSQLmVO51Sijg1ymYMePj94vD5v
	jaoqwAMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtLpR-0000000BLiP-3fOt;
	Mon, 10 Aug 2026 08:57:53 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtLpO-0000000BLhp-2XOW
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 08:57:52 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679NRpva2694117;
	Mon, 10 Aug 2026 08:57:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=wl3KEFhqk6fxco6m+UOtWtR0Vml+ZZsNGL4SBiiUH1E=; b=
	OZVAxec3vH/vzQLvqc4k7T1aJTB4BooQ9jSiCQTSL0RBFWRyDpRUJU36VH9RzFxV
	uG1DkutNu1SF+8wZvZVSwRDneGlmq50B4ISQP+zr+9RCkg86SKIRXngoTPQxA+vh
	EPdfeyd3oSDhn4zfpiftWOIXH0La5jZVkLxmvZQHS+wonFG+f+V+kwIVU9v4yPTE
	54Ur2qjqpk1JkaS1TjLyDCCedQBCuMrIvDL9b3vuejX/wF9qrc68AuF6pQHDRtVY
	1dW/Lm+u/bql/6n+LqNrNOTiguH0dBPM7Nlhawmci4EMvIWaMKTKRYWFVGLh2hFA
	hswUY6FnYepsfX1zJWN5AQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvfxt6gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 08:57:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67A8tU1n005471;
	Mon, 10 Aug 2026 08:57:23 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwpy66j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Aug 2026 08:57:23 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmW6pOAl80Fo3Cv6I1g4j1EONL0ilZXW42m+nf+znliekM53tYwAZlbcFisKwrtF7F0HP/LPD4qxSEyY5xKTZmOla0g5tWdnK3uEHQkVvWBvhKV4cri0zI0jr06Nq5eo0AZUayNhSgg6/qtb8jHGjGg44xJI34FWFzFQy7ap0WuUOcnOaP/efOvbhdImCEdrQqBLV4X5ZazznuiAaaLSdkRQ1S0rlh7j7Joi+qQEYtnwwK57VQ93dbIiEXg2rothQ4ltPazvGWKn/VJ9nHYrhEM/XzsC8wxoxufWlCUc4YZeu2+17xl81om9rPG+QYc3grLiezXKoqpW7fgmK9s5Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wl3KEFhqk6fxco6m+UOtWtR0Vml+ZZsNGL4SBiiUH1E=;
 b=Idrlm1qnZPHWqrD6w14DMOTtQe0XaU3UFGepzSrkqcsW4SebSdKhano7numpkZ0tZcFCPl8vfkhm4xRDGX1NFYu9PyQJPoRNp7x1YvwsfCL0JBCCCIZ+7l5Gkr5qR7G3nRaVOoO3YSmFEVaJTMflELmX2R26XIth7I1BwLlKy8RSYoMWjIxo1qL2Vl26pFUb7qC/uXa5Ba5buWEih/3y9xiRFbWk5iNvuzvoPLNtpKXTrsU4uNRPd/aGfn99UQdqIj9SizrXl4NWZmLEcbiLSf2LLRHRBpYaQhmXCpWCg+Esg+eCTXNdQ6EJbsDJf6AZSvmaNGsLTPnQoxI393EOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl3KEFhqk6fxco6m+UOtWtR0Vml+ZZsNGL4SBiiUH1E=;
 b=v5oroFMOd013N0mIPyeMH7BnD/9vbb258MYGu2RI8f3htcatL2Gji/6v0LaPNnxZe+ZVUgtLKDOLKa+ah1Q8H0Y9tExFKrphAP4fGDGho3GeqRgNMFo2/zR8Q/syMDX/01SqJ2W1wEKiPYBLeXpC7WRQoyoKGglryBOOrzDAfbw=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 CO1PR10MB4641.namprd10.prod.outlook.com (2603:10b6:303:6d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Mon, 10 Aug 2026 08:57:20 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 08:57:20 +0000
Message-ID: <f6daf09b-338d-4518-9d1a-a172b3c2bef5@oracle.com>
Date: Mon, 10 Aug 2026 09:57:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/9] nvme-multipath: pass I/O type to nvme_find_path()
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
 <20260809100825.2014133-4-nilay@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260809100825.2014133-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0498.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::23) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|CO1PR10MB4641:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ff10f8-792f-4aea-e82f-08def6bd62b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|18002099003|22082099003|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 2YJX1k2ax4JCvYlc+JzX2ZRnPsPuRQnoTummhYYkuSgiJaE5Z+xIjXn14UXXjludvkgZ9+eb4g4NhA+uu2YLGskVgkJOpjFmpt5eynlPsYBTSbYePeS+xagElk0BqTU7uCA4+vLxSD9IZrCSJXMV+fx44GlJd5S69oVwGW0Vwx02EY1cJXzRURRUQQbnwybGYRgNG54D4GlmgkisnyhgBZVKPBS5rgmepxIm+PyYUTpUVqz4VKJVPNKdkqrQMjL1tvgPbncQs5os9HVgVzHP/fBtAuwr0cUZg+GpkTrl+g3GYY5mAhAp/iJs7izLM9ogYbD2L6NQwSCJ+aBijBiTM4j6YorAxgmMZX2tfMq2hA7tVJidFeGm0+2XETV5XbmXWDcep9lhXxQT1qOj+D6DAz0AoZroADJ84oq7t4wzp2/EUpemaEcA7Abxm4/Z3rYdHp1rurQ+yunCq1AFq4emPX2m1gk5TBjmOFGg9eGgagI7haCq1lHWrssl/Bafwi14KRvInFO/99ALdL4TeX7MVA/cBL8rHRcZY27SsJqcE7xdLpTy3qAA7LKR9CymZpSDXLqWVK0h1Qc8VQ6X4pTiXLCqQ/Tf1AmZzAsFeflJXO0lltMrAUxDkS9tV8c35j14W2CqRRuij7RN+v3fyPSykqZcGnywiFxa69d3dFneYhc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUJDUS8wcnQ4bm9Fbyt1VXVrTWVPQXhyaVFmQ0c3SEY0N3p5cithRHNlcDN0?=
 =?utf-8?B?dHV3TlN3bTRPYWRoQk1rdDV5ZTcrY2o4UCtoZFVFZEgxNER4MENkVXV5UmI1?=
 =?utf-8?B?ZVdlT2oyVWZROFd0R0pCZHcyWW5DUDJPaVVrVGZEblNYcExYd09yeVVBbVpo?=
 =?utf-8?B?ZHM2aHBENHpmSFpMRXRvT3JZSmxjVEVxc2d1Z3E2Mno3WGJ6QldHQW5sV296?=
 =?utf-8?B?bmtSeFZzY3ZZZzhZcUEzTWN2UG5jSGxPWHF0NCsydTRxZ1dGVTZTakFOaWhM?=
 =?utf-8?B?R0NPVzc0aTB6K0lLaW04TFJMNVNWYnFNL0JFMmtUamdjRXh1SmN3Q2xKakxs?=
 =?utf-8?B?MmNpS0ozRmxXRzlMY0htQlpMc2crTFVtb1NERnl3ZEIvQmtCaUpoOFp6Wm9a?=
 =?utf-8?B?bUhQeEhVYkNyWTNFWVlHM1RCaWtjYmFseUZKTW5wM1YzUjBSLy9XQUpqMGlW?=
 =?utf-8?B?OGVCK3FUbmJBZlZyS21nMW5TTjRzVFZXVzFZYlFiRVRtZDZ1cnRVaEUzWG5x?=
 =?utf-8?B?MTFMdXhYZnFONWFGRjAwVHRCdCtTVm1IUkZJK1ZLekc2b2ZOcHpxeWo0YnQr?=
 =?utf-8?B?ZmxjbU4rRVliV0o2K3VMeTZBWFNGSzFDMStRNTBobnVVNlVRTFpyUG9RTWRq?=
 =?utf-8?B?TXpkMW51WW9oNzE5S1pOemJ4WUZSbHdKY1ZROFZHKzhwL25XZlhtYTJkT0xu?=
 =?utf-8?B?ZWw0SHhnL0lwUC9nQlBXOE9OTnBmQ3ZMNXJsT0h4TUtoT3dGYmtaWWhCZnBi?=
 =?utf-8?B?VThaWE1QVDJTYXdrZ0pweUk2QW5IbkZRbUVpMEZKMGd3cG9XT2Vla1JPUmhP?=
 =?utf-8?B?TDA1ZnBScStqdDBYVlg4V0NMZ0dZK3Z1aHE5c00rUzdaeVcyc3N6dFVuakpJ?=
 =?utf-8?B?WmFUdElGZXpKQzVGOGhjOVYwNVRrNVBmLytPRXMzOTlxMllRMVZYQmpTUUpz?=
 =?utf-8?B?NnVxN0FRTWM1cys2M1d5Qzd5Q05GeGwvZDNDcnZOMzRaK2JpM3pUNmlsV3M2?=
 =?utf-8?B?NEdveVFFODNHUWxpZWptUVJxY1NQMEppRGp5L3Rlajg0aTM3SnJjemtqY01v?=
 =?utf-8?B?ZCsyb3ZNdS9WTGZ6allSWjlUcGdiUFBTNUtPdHRhMWd5Q2VzcUtEVkhMTGx0?=
 =?utf-8?B?SkJUVEtGNnVUb2Rsc1ZLRTBWTXk4c2VnTHRlUVRTaVFKbXVoRUNjYmNSSGJi?=
 =?utf-8?B?R1FYUTFwaHpROXJ5eW5VTHZJNGQ4SGQ0MDZUUzI0UTVnUDRvbnVaZlp3YVBK?=
 =?utf-8?B?VE5YVDlJY0xoUkRRak81YlRlYzN0SlRzcWYxNEhLdWx3Wjk3elpNRVU3dDBB?=
 =?utf-8?B?all2d1NaR3VkMDFqNkhRQkxMd3hwNHhzQjFZYjBFT2lMV1hnOEtvU1NvWHJX?=
 =?utf-8?B?dWIvVnZaZG55OGk0ZHhOcTBWVVZISnpqVUV3aHJCRTJxbWhJcUZrb1I4ZlVa?=
 =?utf-8?B?UGZMU0FqSkZLQmxmc0pjU3YzMnVaZWwwS0d2bUNqSlg4NmtKb0U0aVBrSEk1?=
 =?utf-8?B?cTdwVmNmNmVweWp6Q3pURHNBZTJLalhnSVB0K2FCQzNmTkh2UndtdmhVUEV4?=
 =?utf-8?B?VnJ4ZWtQTnVRVnl1TEVQaURCeVcxRDdjeC94TW1JY1IzREJxd1BOU1dMQUt6?=
 =?utf-8?B?cGNZRjRKam1TbTZuWXp3RkQxMkZsMVg1K0RETkNpbitWbjVEMEhLNkIvUlJt?=
 =?utf-8?B?SUM2VmlIYW53akhFcHd2RDROV3J3V2J1d3k5a1pIaFFSR0wvTmhFNDJRWW9N?=
 =?utf-8?B?UlVCOWNqam9qOW80L3cyYmtwNlUvVlMzREhEejlXOWRwOXRHdmR6dXkzMHBS?=
 =?utf-8?B?S2NBQ0p5a1BvczRIWGVvTWFmd3praE1DVzRDM2VqUFNXU1pUTzNDWFE4OXZi?=
 =?utf-8?B?TWhnNGlZdDV5YnY4VUFEelFYS0tZb0JoN1hBNld1SWtlMVducnlWUTVPU0pz?=
 =?utf-8?B?ejR1RXE1K1c0ZG8zdkFVZ2xvWUdIWDF3OFUrdXFjNURvb0VNdGJRTDBqblV5?=
 =?utf-8?B?dU1WcHVNbFhyT2RkZ0JreUl5Y2hXcWNlYk1iVDdoY3FHNm4yUnVVQjQvZHBZ?=
 =?utf-8?B?RUo5eTRvQWd4RUhMRlFTVVNnMzJSVW13SXNHQ1ZsNVh1KzRwWGRPLy85ZitQ?=
 =?utf-8?B?OUdVc2o5Szg2OWViR24yV0k1enI0QW1JMWM0Y3ZkeGpKMjVpZ0szZXZNWGc1?=
 =?utf-8?B?cjN0dkw2TGFia1VNbnYwbFkwU3d1eHVjNHFSbkpPRmhuLzJnYVhsM3d2cE9W?=
 =?utf-8?B?OGw5a3R6UHN3NDROTGJYeVVGc1JwZ1c2Q1Yrazc5Tk53SUJsa3VnVFgwcDRx?=
 =?utf-8?B?MDNqTTMwMTFocHEwSzg2SGVRVWxHQThhb3dEOUF5bVhHTjI3VnZzQT09?=
X-Exchange-RoutingPolicyChecked: G9rm+R/gJS03UvccAAQaABkqdPEopcCl38AB5ijtl88FbPZzG7wsGeaSk1b7/fa6Wkti2n+AHWMuxf8es2mokFa6+fyqFS+Evn1xqOUnV6xcRKI5eQCL3R4PDeb5FzUYYqeDJB97NIbmyaDaL3IlRzq9HMTAfl1gqg3qEXw/06UMrp2x0XvPknbccq508Mp+ir8qW2tTmAxc5ovXHbueZDSbUgm3hSiFQis0xQiu6OovGjssknMzqwTf5h2ioIiG5JCEDD+VHg3dvLh/g0Rt9yXlikhdc3jZ/vJ4bJ+VSU3ZyLFVy3Vu7KgheFY4SszhGRcMesVK8cR68Tvroh4s7Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6aQaMGjZgcbfCjldsR44QuaDXGFJQyf1owxI7r9u/e+ZWfwIe1Ly0T1XOVvle/XnSo2+xw94uzb3HUH65aEwXPmHIvxgHJHMCOfzu2f3MUclwOSTdn2yPlKDEWRUnNyvZEVMMK6S6+oqcSjgcUTyHcaZg9LQfxH/7WAPW85+M5B0c8m4duN5yDFCgytseCaz7gGGDsL80OXo5NVN/evALvy3+rrSPFXmW9bhCDECxyh8ObIbqGsZQHI3fC8qT3bA68WLz0zgMa+b53QHr3CLdU1SmIZht0mt5LcJ34DgQcj/K1RIe0Hwgg2KXTJ83ggw9BsgVXqQ8+aJdZ9yi373oJC7MiHnbf2WNasQVvss0bQoIhOgCLxdJcuFloq20oFc1zWPmqdk+MTVYzgdsQZ4rcwOQ575EpQYG2vY+Ahqh1zKOHH3D4o1WWnOgj99AmP0TXbxt78a+8jJb/XgHBd2A73IL1OpXXReyhP6N5YLV7qE5JhoSRQmXYI1E+u6z2Hea9mNi7ich0ztJN7985oMIjMbNTuFqSsOSQ+HL+Ck5mgq5WBqe0xm96jCSWPDby1rFvnCzmoQg9I09RHly8fc3LCWINSXRhO6bqpV5DCrkSU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ff10f8-792f-4aea-e82f-08def6bd62b2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 08:57:20.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HMjz26dA64sIxicfpPiIWUPr2x8eC20oFhek5kWY1TNNbHtXz7eFhzHpaYqSCe4pdNYtSQG+SRz6vVWAHAK/Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_01,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608100076
X-Proofpoint-GUID: Ak-lzLXqZPfBuT8IusOjYGYoJhrnTH3o
X-Authority-Analysis: v=2.4 cv=K/sS2SWI c=1 sm=1 tr=0 ts=6a799274 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=3I1J8UUJPc9JN9BFgKH3:22 a=9bJd7Qdvi4eE4p7yegIA:9
 a=QEXdDO2ut3YA:10 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf
 awl=host:13510
X-Proofpoint-ORIG-GUID: Ak-lzLXqZPfBuT8IusOjYGYoJhrnTH3o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA3NyBTYWx0ZWRfXxWeZ2jo9Tnqv
 ARwbA1sZ011etZCThS4uiFZBxLZVmRTbiWDQcoRx2neBNXPEB9VSoEtZhYXSW4ZNWCUnYvNKUC3
 AaHqn2K6WAdRTF85Tv3/FJBNqrfd84mmHqgNHo5EM3jASEysDMIZ2dXmKrqIHo5MCWFtk8oLhH5
 6/PiEJgTzQNDA6V5v+fcWWeSUcFykeiTG8rtGZXjYlZIRNSrht0S0L07sLepdH0ORZDXMhkvJkR
 rvmAed/Tcs/6JeBnQtGTVOUXWr+f1FcsfYMT5ACHQZyCMqWQLO0euhFwxzrtVxUsCsBR8QlBcSa
 p1ImECDpJUy8amNzUec+/BbLyOI4NLG5qazEmr5VrIp89y6bs9Vg180PkdCCCVeI0EeDGUlsvJE
 QBbuWAfnYbOOz8AMEQvrblgU46N+knu46XnAhF68UsPxfm+3RadJn5g6/OuWUx7IYw0cpS/Ah3u
 JoDtZwgfcj+XdHQpxMY31+74OSOLnI/UDLL5WYTo=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA3NyBTYWx0ZWRfX+SGUCTD2SOUu
 TqZuYUaY1CWcDBILZa2AOw07w6OTe3VX+OKSMtCu04a16Qmkkku9g2i3KU/7bILTQ87FVJfRGfC
 JbIztThqkTke3/+bFyu4TZi1chQaHyin2MSlk+JG3YkNyHjg3BaN
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_015751_412427_AAE6DFD0 
X-CRM114-Status: GOOD (  17.74  )
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

> @@ -741,6 +752,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
>    long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
>    		unsigned long arg)
>    {
> +	u8 opcode;

why declared at the top?

>    	bool open_for_write = file->f_mode & FMODE_WRITE;
>    	struct cdev *cdev = file_inode(file)->i_cdev;
>    	struct nvme_ns_head *head =
> @@ -748,9 +760,19 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
>    	void __user *argp = (void __user *)arg;
>    	struct nvme_ns *ns;
>    	int srcu_idx, ret = -EWOULDBLOCK;
> +	unsigned int op_type = NVME_STAT_OTHER;
> +
> +	if (cmd == NVME_IOCTL_SUBMIT_IO) {
> +		if (get_user(opcode, (u8 *)argp))
> +			return -EFAULT;
> +		if (opcode == nvme_cmd_write)
> +			op_type = NVME_STAT_WRITE;
> +		else if (opcode == nvme_cmd_read)
> +			op_type = NVME_STAT_READ;
> +	}
>    
>    	srcu_idx = srcu_read_lock(&head->srcu);
> -	ns = nvme_find_path(head);
> +	ns = nvme_find_path(head, op_type);
>    	if (!ns)
>    		goto out_unlock;
>    
> @@ -770,9 +792,19 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
>    	struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
>    	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
>    	int srcu_idx = srcu_read_lock(&head->srcu);
> -	struct nvme_ns *ns = nvme_find_path(head);
> +	struct nvme_ns *ns;
>    	int ret = -EINVAL;
> +	const struct nvme_uring_cmd *cmd = io_uring_sqe128_cmd(ioucmd->sqe,
> +						struct nvme_uring_cmd);
> +	unsigned int op_type = NVME_STAT_OTHER;
> +	__u8 opcode = READ_ONCE(cmd->opcode);
> +
> +	if (opcode == nvme_cmd_write)
> +		op_type = NVME_STAT_WRITE;
> +	else if (opcode == nvme_cmd_read)
> +		op_type = NVME_STAT_READ;

nit: I think that having a final else leg to set op_type is nicer than 
setting to NVME_STAT_OTHER at init time (and overwriting in some cases).

>    
> +	ns = nvme_find_path(head, op_type);
>    	if (ns)
>    		ret = nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
>    	srcu_read_unlock(&head->srcu, srcu_idx);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 9b9a657fa330..8c20ff516e61 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -460,7 +460,8 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
>    	return ns;
>    }
>    
> -inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
> +inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head,
> +		unsigned int op_type)
>    {
>    	switch (READ_ONCE(head->subsys->iopolicy)) {
>    	case NVME_IOPOLICY_QD:
> @@ -522,7 +523,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
>    		return;
>    
>    	srcu_idx = srcu_read_lock(&head->srcu);
> -	ns = nvme_find_path(head);
> +	ns = nvme_find_path(head, __nvme_data_dir(bio_op(bio)));

It's a but unfortunate that we have to find op_type even for when not 
using the latency iopolicy.

>    	if (likely(ns)) {
>    		bio_set_dev(bio, ns->disk->part0);
>    		/*
> @@ -572,7 +573,7 @@ static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
>    	int srcu_idx, ret = -EWOULDBLOCK;
>    
>    	srcu_idx = srcu_read_lock(&head->srcu);
> -	ns = nvme_find_path(head);
> +	ns = nvme_find_path(head, NVME_STAT_OTHER);
>    	if (ns)
>    		ret = nvme_ns_get_unique_id(ns, id, type);
>    	srcu_read_unlock(&head->srcu, srcu_idx);
> @@ -588,7 +589,7 @@ static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
>    	int srcu_idx, ret = -EWOULDBLOCK;
>    
>    	srcu_idx = srcu_read_lock(&head->srcu);
> -	ns = nvme_find_path(head);
> +	ns = nvme_find_path(head, NVME_STAT_OTHER);
>    	if (ns)
>    		ret = nvme_ns_report_zones(ns, sector, nr_zones, args);
>    	srcu_read_unlock(&head->srcu, srcu_idx);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 824651cc898d..8a9ec502912d 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -520,6 +520,13 @@ struct nvme_ns_ids {
>    	u8	csi;
>    };
>    
> +enum nvme_stat_group {
> +	NVME_STAT_READ,
> +	NVME_STAT_WRITE,
> +	NVME_STAT_OTHER,

Would NVME_STAT_OTHER ever be used in high frequency scenarios such that 
it is worth having its own type? If not, could NVME_STAT_READ be reused?

> +	NVME_NUM_STAT_GROUPS

Can these ever be used for non-mulitpath? I just wonder why multipath or 
similar is not in the name

> +};
> +
>    /*
>     * Anchor structure for namespaces.  There is one for each namespace in a
>     * NVMe subsystem that any of our controllers can see, and the namespace
> @@ -1032,7 +1039,39 @@ extern const struct attribute_group *nvme_dev_attr_groups[];
>    extern const struct block_device_operations nvme_bdev_ops;
>    
>    void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
> -struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
> +struct nvme_ns *nvme_find_path(struct nvme_ns_head *head, unsigned int op_type);
> +
> +static inline int __nvme_data_dir(const enum req_op op)
> +{

This returns an int (so not strongly typed), which is going to be 
NVME_STAT_READ, NVME_STAT_WRITE, or NVME_STAT_OTHER. From the function 
name, I am not sure if that it expected. Some might expect READ or WRITE 
returned. 'stat' should be in the name, or similar.

> +	if (op == REQ_OP_READ)
> +		return NVME_STAT_READ;
> +	else if (op == REQ_OP_WRITE)
> +		return NVME_STAT_WRITE;
> +	else
 > +		return NVME_STAT_OTHER;> +}
> +
> +static inline int __nvme_data_dir_passthru(enum nvme_opcode op)
> +{

As __nvme_data_dir

> +	if (op == nvme_cmd_read)
> +		return NVME_STAT_READ;
> +	else if (op == nvme_cmd_write)
> +		return NVME_STAT_WRITE;
> +	else
> +		return NVME_STAT_OTHER;
> +}
> +
> +static inline int nvme_data_dir(struct request *req)

As __nvme_data_dir

> +{
> +	if (blk_rq_is_passthrough(req)) {
> +		struct nvme_request *nr = nvme_req(req);
> +
> +		return __nvme_data_dir_passthru(nr->cmd->common.opcode);
> +	}
> +
> +	return __nvme_data_dir(req_op(req));
> +}
> +
>    #ifdef CONFIG_NVME_MULTIPATH


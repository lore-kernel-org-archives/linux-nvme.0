Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C339E69185
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2024 17:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7fTF6LaG+uKS61bbLDSujxjHgFIgdW1iu+bn7B1PwJk=; b=AIFRX1TFJ2CqkmHLDlBBogJZqe
	zJegT5QeZCyrsVVNgSFsiTT8Fq1o5qtnYZRbYm8BdSOZ5hyTRM72InI2QoKFLVNp1ysgHW/SQyU5p
	SBmo9Rp9IpV22KGiVWx1yWPMx7ctjFRGXuNIDWxCGMY0I9y7u1kCirYWTSJ9mSVqEX50MFQSekSx+
	qVRa27tqLUyj2cFefvUqyuJiz8ulCRrbtEl2U6wrBc7cCpFmMX///YTmPLwtUc0ZFJjeD2L5vAsFZ
	IkWyHAguWISYVeuzRslKHy1M25DE7f43cBdc2u72kgGAlimlHH0rgh6mX9v627BGaAc0O6++gpv3H
	3ImBZqHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tEXF0-00000002wco-2Dot;
	Fri, 22 Nov 2024 17:14:46 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tEXEH-00000002wWO-02b2
	for linux-nvme@lists.infradead.org;
	Fri, 22 Nov 2024 17:14:02 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMGBaIT031550;
	Fri, 22 Nov 2024 17:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=7fTF6LaG+uKS61bbLDSujxjHgFIgdW1iu+bn7B1PwJk=; b=
	C3hc13ltKDeAWGLKwsWvoKgyOqWU5VQcpxW73IRJWnTcYAdARfAgkCI9mf4XK8Od
	vx6GeE955Z6+D0FL35UXBuoioo4DY06R8L14U2LjwyLUOxraJxFjEVm1wwJdA7OZ
	pO37cHe0WPUysNjo0iiJIgersngmiTrJbrZsfauyi5f6C/MOJ+gPInMb/iwbXwij
	qU/A6CdI9FU66I1yZOeE/HBqlh5xlsi/FBDqcl5OA7Yc0eHriajUBttfh94sB5ln
	0ut101q0H/L9/UaF0HZ8A3h2K/3J+7V4p00r3/P7A5pEh0cjPePKW6i4z3RS1JU8
	+Ssy1g/0a7y02nMHyKQVyw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 430rs5g4fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 17:13:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMFfXqc037310;
	Fri, 22 Nov 2024 17:13:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42xhudkx3s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Nov 2024 17:13:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JXq7VMcLyiGQOk/CMHeRtheN2biI/FhyrwxJ4OX/WIKvp4crRT8cc4fuU8Vm/XhgQaPzzQah4guHdO6u0sk8U7A/X3XVRZ8fKzZrHdZTPE9ICQcbRxzvND4ZR/NDmoXjv6QmGR7rw1gqlbxQqVlC0rfIL/HTNlBOaIhNXrlvtSAGBaJuhyK0FNpJZmh7YgqrnaEcIYn8bYKTpDOKQJX4Kq69w9HHF+8gd9RjnGUusXhQpDsc9Cj5HaV6EriUAFDAtyfWvof3lCcxtQ8xLSzufAz3JkbaA5Jmx13muNndOb/zp4H7r/VMKcWMv7jC3ExRs8SalKM0LjWv9d1zFxSRLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fTF6LaG+uKS61bbLDSujxjHgFIgdW1iu+bn7B1PwJk=;
 b=nlJ/0ZLA4i1QLwfbO0BfJwE9bIqt28GcdRiS6ilw4RVWnr4PQKPb0upCLApEmoHhCTpKcYX7Ts0vjK8+MdNOZAnur9bhuo+gB3xaQFb4EV02KtQIsRl1PY4P7+opN2PdcpfChgRiEQuC4oH2vC47oWgON83959QmhZP1lZkIv81hWHjUB+6UwfgnxqkSbds8Vr5BBxxEm3+55M4BRpKANwuERShEUgJ46PouPUYGCjT7l6Y/96Es8B2275cIk1onJhhKSpr5o8XM+JudZ095Qb4qwqQ+X8ihz/xV26KNI/POdB5TCyL7wyAviCD5QcMYySrsVCVDzYttTmHAcZlCXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fTF6LaG+uKS61bbLDSujxjHgFIgdW1iu+bn7B1PwJk=;
 b=LLqr3E+FmRhyuIBoQ8uaHCb/ay4+CyEWI8tW1fx91DlePCanutTtA6LsD/sZWaEUdtGYXcmOf5i/zDghwk3jo2uh7GoECl7c3RcpKCXdUXmgGEcCk6oI14EKwhR93AKyh60j0iibEzbZudyIOucrlxyaNjvJB8Gj5sxJ5mAneIA=
Received: from IA0PR10MB7577.namprd10.prod.outlook.com (2603:10b6:208:483::18)
 by DS7PR10MB5928.namprd10.prod.outlook.com (2603:10b6:8:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.16; Fri, 22 Nov
 2024 17:13:44 +0000
Received: from IA0PR10MB7577.namprd10.prod.outlook.com
 ([fe80::7923:a24d:8b74:87f8]) by IA0PR10MB7577.namprd10.prod.outlook.com
 ([fe80::7923:a24d:8b74:87f8%3]) with mapi id 15.20.8158.023; Fri, 22 Nov 2024
 17:13:44 +0000
Message-ID: <03616086-eaa1-4c3d-a667-3d6452d9743a@oracle.com>
Date: Fri, 22 Nov 2024 17:13:40 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [bug-report] 5-9% FIO randomwrite ext4 perf
 regression on 6.12.y kernel
To: Jens Axboe <axboe@kernel.dk>, Phil Auld <pauld@redhat.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
References: <392209D9-5AC6-4FDE-8D84-FB8A82AD9AEF@oracle.com>
 <0cfbfcf6-08f5-4d1b-82c4-729db9198896@nvidia.com>
 <d6049cd0-5755-48ee-87af-eb928016f95b@kernel.dk>
 <20241121113058.GA394828@pauld.westford.csb>
 <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk>
Content-Language: en-US
From: Paul Webb <paul.x.webb@oracle.com>
In-Reply-To: <a01ead6b-bd1d-4cd3-ade6-59ad905273e7@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0551.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::19) To IA0PR10MB7577.namprd10.prod.outlook.com
 (2603:10b6:208:483::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7577:EE_|DS7PR10MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 78c5449e-3a87-4dde-1d0b-08dd0b1904a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWd4SHhuSXFWOHg1RVVReFhyWVBzS0J0YUMyMC9Ca29QVHZKWWlyT1huWmcr?=
 =?utf-8?B?TTVNM0RqOGpVemZNRXhvYXZIRWxESndRamgzUVExTHcrT3RmMkpRaHo2TWtE?=
 =?utf-8?B?dks0QWVjUEdsWUZVL0NjS0srY055dkpDTkprc0ZsbjZnT0d6dU1HQUR6RmtB?=
 =?utf-8?B?NWZQN3VnRHRNanZSdzZodlJZNGJ6Nm1rWHNleWd5b2dqN2JXbFFJWGFTdWto?=
 =?utf-8?B?MHFtS0pTQlhHWmxYbW1VRi9VTkoxSlFHbnFWcmlYZ1MwOVVWRlE5T2dVUGZr?=
 =?utf-8?B?Y1ByaXNJdkw1eU1vOGZRRS96SjdRU0xXbDNZbXY0NDlreHZjMnRyZmd4ck5k?=
 =?utf-8?B?VXNRdEtHNUxwbGJDMEs4RmIreDRkQU9sY2RHMGY0bzAyYVI2d3p1cXpGYlBq?=
 =?utf-8?B?R1Bsdlp0UWlwcXlTTVJGNWJRS09qVS96VTNqTjJGMW1FTVQ1YmhhYUNCTVQx?=
 =?utf-8?B?dXJoRk52L0ppY1g5cFhQazhHdWxJaDNxTG9qOFk1c3F0ZnlXL3BiR0VveVpx?=
 =?utf-8?B?ZVBnNTNJblJ1SFdnMVJudTYxSjNWK1htUTBraDJvV3R6ejhxQy9xZjl1TUxQ?=
 =?utf-8?B?YmZkZzJtdXdQRVFwTzFxbEV6S1N3WHZldHJiY1U4OU83RTdadWxkM1JSaytO?=
 =?utf-8?B?WGx0bnVxYjl6R2dXeHNFNnhNMmFWT0doQXJ1Q3ltcjFRTlpFRTdCYnp4T0o1?=
 =?utf-8?B?bnVZZndLd3ROdEdxMmVuZWJDU3Y3T3JMYWlCWXZLalltb2p5c2pBRXozMTV4?=
 =?utf-8?B?US9iL0Y3V0xXbU1JaXVkbGZmeHZmRHFXV01qc2ZSWjNVa2Y5RWx3S2hRZDAw?=
 =?utf-8?B?SjFFeVRDOW9QeExnblkzYW90QTZrV3EyWUcwcHpHMkg5Sldaa0NvWTAzc2Zl?=
 =?utf-8?B?Q3JKaDhHQzlnZ2tyTTg1bTlHZGpqYkU4SEFkRWtjczBFVlhrNElUbmhrSGl3?=
 =?utf-8?B?c0wvT0RkcWpwZWhua0xvK2Y3VlJEMHlnZm1FMG5iV29oSmszNU82S2EwVlNS?=
 =?utf-8?B?b1ZxMXJvNWMxWHY5V2ZFM2xabERwdVFxNUZISFhpblh2QTZndXhXY01WSXlF?=
 =?utf-8?B?ZTRMZGxkSGI5YzFUMEdPZkdlTEprQXNqN2tqYnpGc2hKVXVJQnNRdmVrb0xD?=
 =?utf-8?B?WUtBdDErV2U4L1ZIVDV6MmdyUERVczZVQ2xoN01XWHNtRUNRcnlXRFAvS1V3?=
 =?utf-8?B?TFRvRFNFME50Zm5BTS9UK1JmajdOUW8xUnU0RTFqbklkVXd5M1lVVGFVRVhM?=
 =?utf-8?B?ZWNTMExWUFRYZko5d0pTRDZ1WlVrQndrNjVEUFlwNkRieEgrR3ZtZ2FGdG9p?=
 =?utf-8?B?aCtrVDlHL1hHVURtb1F6TGZvN09XdGdrUlNwR3JmNFhvOUJSUWo1WlF2dVAw?=
 =?utf-8?B?Q085QStzanpMdUFoR3o5OHV1dmdxdFhCc0ErL3QzV0VjSml5bnZmZkVoYUUv?=
 =?utf-8?B?ajNhaFpSZ0J6dkxFem5nNkZqOVpYYmFqbWpZOHBaMmtDOGczSjZYeVMrRVMz?=
 =?utf-8?B?SFBuLzRNYm5GLzRtbkhlTXZlUnBpN1AyZFJud1UyNzRMTm94TnV0QnlvanJ5?=
 =?utf-8?B?bEJlTzhadzhjWm1Hcld0UWVXSUlWQXVLdDhnY2xsMDZzZ1UvcnIrbldRV3I4?=
 =?utf-8?B?NDlpa3Z5bWpYNzh4VG5hRDI0MkJOc09McndweTBTZDlpZU9UajdON1J1dlNT?=
 =?utf-8?Q?wYTZuMRavMWdEBwGj/He?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7577.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0ZaeXpDd1d4MWhXVVlVd2JIWGVGNnhVSVhlamVSNFZuKy9FSTNFTXcvQktB?=
 =?utf-8?B?S0w0OFlzZFVydDBUcVVMTXIzcFdGZW9PaFQwekRvSjh5a0NMNTJQZGNoUFQw?=
 =?utf-8?B?TlplNUxvWDhwdTVtSllXK3AwVkpENWNBQVlUTHVqeld4VXdpY0gwYWlMZkwv?=
 =?utf-8?B?aThBMFh1V3oxMWpQaVJJVXZoSXZSM3k4VXpWcTBjV0V0Q3hKNHpld3VQNC9j?=
 =?utf-8?B?QytYYkRMdDJCNTZNZHpHMVk3N1lReUxmS3o1d0ZxZFBEWTRRc2NuZHdkaFZo?=
 =?utf-8?B?Z2FzY0xiay83MzVqOExQOHlFUUJrTEV4dXJWbnZ3N1MzR2RSRmNTeDZ4RHZa?=
 =?utf-8?B?cHYveFFrNzJBQ2p4Y0JCTmZSekw5TEFEaFQ4Z1lSdGVhTVltRS9xQ3VOeXJB?=
 =?utf-8?B?ZVRZdDNZeitjRURmM2NkRGxoSEVmRHUyZXR3RzE5VEJUc2hHTmM3elFQRGpj?=
 =?utf-8?B?a3p5L2dLZldGY29QQXlnS0hSM0hPS0tPbnVrdmUwTEdibzlYRXJwTDE4L0I0?=
 =?utf-8?B?RE5MWkVjYmdJeU9ETVRkbFg3TDdHdzMzY0x3NlJDa1pnR2djSFB0bU1nd3gy?=
 =?utf-8?B?WHZvU3V4UG5HRERPa2VZTlYySGtjcmVoRUFzTEltSHBZMTVnUEZkSlBNakRz?=
 =?utf-8?B?Q0pQZmtnclgrQW1MT1FTUjBSc1NvUUhtZjMxUzl6b2hpdXVwTHZCYkI2ZGE3?=
 =?utf-8?B?blpIM24vTEJQOW5pQ1VUZkg5OVp2Nkl5dlE0NmhiOXlTN1liS3prUFpUSi9p?=
 =?utf-8?B?a1d0V1VLOWc4c3hhWHd5U1dOQmVKcHZ4QkF6OXpPeDBIRXFHNUhxT0FyMkov?=
 =?utf-8?B?RElpYXltd2tvTEV6akdGVVI2ZTJJNXJSVHZCUnhLZ1Y5NlFFSUplbjZwdnZY?=
 =?utf-8?B?RUcvT2NIc2ozclFncFRlNzg1L01LVFg0UENNYjg2dTg4YkV0ZlVXRWRiY2Q4?=
 =?utf-8?B?Q3d3eStWbmtFRTZWSTV3SnVwWE0xWmpycWs3TWI4OUhuY0FFUU9ZRFQ4ZEhM?=
 =?utf-8?B?ZGRENnY1T042TjM4dmpiNjliR1grclU4VkV1b0svMzI1Nk1STmxjQ1Z3cUVH?=
 =?utf-8?B?Y0VHRlgxVmYrN1RwWklzaG0zRUpsdHNUcWdweGljays3cUdMOG0zelhmMkZK?=
 =?utf-8?B?eHFDZzhtOC9wWTB1V1NQdWNyeGJhQmJhOWVUR2xtb2gzeHpUNnE4Q3BHV1k1?=
 =?utf-8?B?bC81aGo2SE0wUjVTTTJXZmlqbVZiZmk2UDVwTWJQVGtheEdMNHZxVXA2YmtW?=
 =?utf-8?B?ZVVOcW5vQ2JtWDRoWVMxVEkvQjB5WjhEa2dlbnRkRFU1MHk4azBRYnRHUVRi?=
 =?utf-8?B?b3RBeXlORlBtMGo4TjBLVDR2S245cHJRU1JZWnFoWnRxa3BQUmlhZG5Zb3Bt?=
 =?utf-8?B?S215Z2Z6Q0FURVAyMFpGMW82OXVodW4wckVMdzhUYkNJZ0RMM3hFUTQrZVVK?=
 =?utf-8?B?VUdxSmJCOXY0a2pOSjUvd1FlTHVCQ1RXbjJSZVRhUys1Qk1wUm9xM1pWOXBR?=
 =?utf-8?B?VW1oTkRQMDZpWEdITWxQdFNTVUdxRy93S3dSVTBRcDVJSzZtSnFWbUVVWkhr?=
 =?utf-8?B?cFVLWFNLdEJYQnBwdkxUcktvRzM3VHNzQTIvb2twZ2dXOXFJRXZhSTdtN1Vy?=
 =?utf-8?B?T3FHMzBRSDlWNEMxYm15Q0p1QWRpeGZaNVV6TE5yODRNUVI4MVVYMkcvcGlZ?=
 =?utf-8?B?eEptN29CMVBPK014LzJtZzEzNGtRVGdhaVdwbVJXKyt0WGFLSS9Ic2haM1JZ?=
 =?utf-8?B?NDZKZ0lkQzhmVkRuNGVqdEJrQkJhSUVvVWdRUDJvZUEya1MxSWZoT2Y2T0Y1?=
 =?utf-8?B?a3BrdTNCaE8vdEtPTVZMQ2hlMjlXQk1sWFVPbjdsazNPcDBsSXZ5b0RURzNS?=
 =?utf-8?B?bkh5TVZIWFJNcGI4SUptSmNqRHAvczdyV0trc0xqL0ZnNVIrYXVIaWc0bjJP?=
 =?utf-8?B?dGJTWkV4aFZMSk95cDR3MWFPcGtZMzhwT2pLNDZrYWhMbzZzdWNBMksxcDIy?=
 =?utf-8?B?V0k1c1NGZHg4eERCNUIwRHMvd0QwRlJRVHJObFlyYTk2d2dKM3N6dno4OHNF?=
 =?utf-8?B?MEtWLzhDeE1oaGJLcDROWTJzYlN6SkNjRFl3dTNvOTlqUlFrczVrZHlKOUNR?=
 =?utf-8?Q?yybv7z2fUWNz4qxOPOwyliY9s?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4yIKkGZEHmt8wJiIi/C80EP9YcGjCjdiKSJvxtxWSMhz9BcSIhrlmtftUM3ckbDZGgztOShXCesoI1yDmiiwsIunKmXgyMhJ2shvmjdFFk/R9yCiacu7unhj5sBxFqPA1Tc48SFnErOElndElcHnL2fZpcY1kUxSjzulVp4RPzBdHoJ/EBaltZ0OPr3EOfiFnX13skvKXOV7zgWtwfAv9CtvlGCnKJ6/83P+gXOK5oGP3lWWYpsxekTjZsTkyKroig800Z9TYAjzWfap6S+TLFg3aEVUOLitUFvTOgymfwjj3ROrMX+X1gbST+9dsDnvwMAAbo5L96DWoU7IraYa/yw9ra5aSmYshq62IPfThh3wq7hVyjAMdZFbbT0oxkbnbiPpGNRy1Tl4XFkBk6nzACxTlD1DU21ZGvUoBoH+iNrr2QImA3lqor3mNopaCel06BdPacDc4pRE7pVCaOsZ4ogzjPClA9EUCFq+VkFAQB0yDEG1h7LgugDfWCO5fb1FyyOjkJVNSVE+2SIBAwqIZ3IcfnnKff9kcB9UeXjTH7nkY/4gNaE/zhxRNW4xLsPqkfF0gtQUkNiPiJM9pGzkLLO/V2UXndEQhoyq9AaQ2O0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78c5449e-3a87-4dde-1d0b-08dd0b1904a9
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7577.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 17:13:44.0591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msR/mtqZ8p85OedvrI22sYOsXxw+dcIftkwR3s2huIR2qs+nKO61NQ5Sn1uF8AmXixiNnCDaOyjgI5EXtshyLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5928
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-22_09,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411220144
X-Proofpoint-GUID: sOMvn9DZqzQXj2cGWLd0knhstSKfFXuH
X-Proofpoint-ORIG-GUID: sOMvn9DZqzQXj2cGWLd0knhstSKfFXuH
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_091401_059198_355BC9CE 
X-CRM114-Status: GOOD (  24.04  )
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


On 21/11/2024 14:49, Jens Axboe wrote:
> On 11/21/24 4:30 AM, Phil Auld wrote:
>> Hi,
>>
>> On Wed, Nov 20, 2024 at 06:20:12PM -0700 Jens Axboe wrote:
>>> On 11/20/24 5:00 PM, Chaitanya Kulkarni wrote:
>>>> On 11/20/24 13:35, Saeed Mirzamohammadi wrote:
>>>>> Hi,
>>>>>
>>>>> I?m reporting a performance regression of up to 9-10% with FIO randomwrite benchmark on ext4 comparing 6.12.0-rc2 kernel and v5.15.161. Also, standard deviation after this change grows up to 5-6%.
>>>>>
>>>>> Bisect root cause commit
>>>>> ===================
>>>>> - commit 63dfa1004322 ("nvme: move NVME_QUIRK_DEALLOCATE_ZEROES out of nvme_config_discard?)
>>>>>
>>>>>
>>>>> Test details
>>>>> =========
>>>>> - readwrite=randwrite bs=4k size=1G ioengine=libaio iodepth=16 direct=1 time_based=1 ramp_time=180 runtime=1800 randrepeat=1 gtod_reduce=1
>>>>> - Test is on ext4 filesystem
>>>>> - System has 4 NVMe disks
>>>>>
>>>> Thanks a lot for the report, to narrow down this problem can you
>>>> please :-
>>>>
>>>> 1. Run the same test on the raw nvme device /dev/nvme0n1 that you
>>>>      have used for this benchmark ?
>>>> 2. Run the same test on the  XFS formatted nvme device instead of ext4 ?
>>>>
>>>> This way we will know if there is an issue only with the ext4 or
>>>> with other file systems are suffering from this problem too or
>>>> it is below the file system layer such as block layer and nvme pci driver ?
>>>>
>>>> It will also help if you can repeat these numbers for io_uring fio io_engine
>>>> to narrow down this problem to know if the issue is ioengine specific.
>>>>
>>>> Looking at the commit [1], it only sets the max value to write zeroes
>>>> sectors
>>>> if NVME_QUIRK_DEALLOCATE_ZEROES is set, else uses the controller max
>>>> write zeroes value.
>>> There's no way that commit is involved, the test as quoted doesn't even
>>> touch write zeroes. Hence if there really is a regression here, then
>>> it's either not easily bisectable, some error was injected while
>>> bisecting, or the test itself is bimodal.
>> I was just going to ask how confident we are in that bisect result.
>>
>> I suspect this is the same issue I've been fighting here:
>>
>> https://urldefense.com/v3/__https://lore.kernel.org/lkml/20241101124715.GA689589@pauld.westford.csb/__;!!ACWV5N9M2RV99hQ!PXJXp0zosonkV7jeW9yE0YL-uPElcYI-G-bvm69COWR1Tbl9w9puGc1tLR_ccsDoYPBb9Bs3waNVuuf9Lg$
>>
>> Saeed, can you try your randwrite test after
>>
>>    "echo NO_DELAY_DEQUEUE > /sys/kernel/debug/sched/features"
>>
>> please?
>>
>> We don't as yet have a general fix for it as it seems to be a bit of
>> a trade off.
> Interesting. Might explain some regressions I've seen too related to
> performance.
Apologies for those receiving this twice, but resending due to mail 
client not sending it as text content causing it to be rejected by the 
lists.
Also, a little more info to update.

Hi,

To answer the various questions/suggestions, I'll just group them here:

Phil:
can you try your randwrite test after
"echo NO_DELAY_DEQUEUE > /sys/kernel/debug/sched/features"

Performance regression still persists with this setting being used.


Christoph:
To check for weird lazy init code using write zeroes

Values in the 5.15 kernel baseline prior to the commit:
$ cat /sys/block/nvme*n1/queue/write_zeroes_max_bytes
0
0
0
0

Values in the 6.11 kernel that contains the commit:
$ cat /sys/block/nvme*n1/queue/write_zeroes_max_bytes
2199023255040
2199023255040
2199023255040
2199023255040


Chaitanya:

Run the same test on the  XFS formatted nvme device instead of ext4 ?
- XFS runs did not show the performance regression.

Run the same test on the raw nvme device /dev/nvme0n1 that you have used 
for this benchmark
- Will have to check if this was done, and if not, get that test run

repeat these numbers for io_uring fio io_engine
- Will look into getting those too


Another interesting datapoint is that while performing some runs I am 
seeing the following output on the console in the 6.11/6.12 kernels that 
contain the commit:

[  473.398188] operation not supported error, dev nvme2n1, sector 13952 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
[  473.534550] nvme0n1: Dataset Management(0x9) @ LBA 14000, 256 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR
[  473.660502] operation not supported error, dev nvme0n1, sector 14000 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
[  473.796859] nvme3n1: Dataset Management(0x9) @ LBA 13952, 256 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR
[  473.922810] operation not supported error, dev nvme3n1, sector 13952 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 0
[  474.059169] nvme1n1: Dataset Management(0x9) @ LBA 13952, 256 blocks, Invalid Command Opcode (sct 0x0 / sc 0x1) DNR


The errors start as soon as the mkfs command is initiated for ext4 and 
continue throughout the fio test run.
These are also seen when using mkfs command to create an xfs filesystem, 
however in this case, the error is only seen once at fs creation time.

Regards,
Paul.


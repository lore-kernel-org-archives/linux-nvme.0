Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA0BC369A6
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Apr 2025 11:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/TiubfoGd6FiJa4dlphsd7/zk2zxUCm3jGyIhclpF+E=; b=fVfEKc/T2T9u8nEVVcqVKy6w4d
	nFUDQbONZWIVamjCdCNKnlGiviecviSjBNKaUzDwIhOliWfHtAL4P6fB1HOE7DovoN7jHjAnIFX3y
	NpBsx1Q5srTlRiceBSMCeGkDQN3u5QdsAMWhaoRQdysOFuEQqLnqhSLCTNl23wwDVO1XFmt2k9Lch
	RWwdkO5x+RCi20j9DUg0tk6OF2ZJVNv12Y6wMDXKdFmusfVSUYmhcNvbUmYA8eKovLgkSOKW9Hi1u
	u0pfCsb69u7Az7+Y4LBXJ9YuBpumEghrSaCwPhX4BHQhDfnCsHEU5uj6zxESGRytJNIj2RImBHYdN
	A5MlTZYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2pvo-0000000AFqZ-1XiK;
	Thu, 10 Apr 2025 11:18:52 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u2osZ-0000000A3Jz-2kDD;
	Thu, 10 Apr 2025 10:11:29 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A9rP3R005645;
	Thu, 10 Apr 2025 10:11:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/TiubfoGd6FiJa4dlphsd7/zk2zxUCm3jGyIhclpF+E=; b=
	aJa4dLhgligusKkyqfr/37YCyz+4jXmeWmPUQAx/uvnZisXpK6O9eUz2IyXsfl0G
	h846HYc9OWFPYoKnISDVC+XWfzoQ0WnsOCD1OqKVkSwtNZc9QjTSE+AJM4TSosgt
	LMhKJqbExuH3vRuXhm80tViXF/WPTPcNym8d3o7BHDdEtUoSW0wHGqC+N/rWDe49
	WF7T5l924+MeT8FjZOy06ZjUjcgaC6b8HhaXrIiK4YdO4N1zzKgtTljHgzknitJE
	jLhGXU8QcLSN9EGjxQr+EybBuZO8k3iWywCDgKFvlr5N67livhaM/9TdGFbpsTtl
	G1UWkJ2C/qw4mxNAiSWVWA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xbqsg117-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 10:11:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53A9omEm016476;
	Thu, 10 Apr 2025 10:11:25 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011030.outbound.protection.outlook.com [40.93.14.30])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyc10nv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 10:11:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IIJR+6IrW9dbA67gRleAMZ/H59QjrODC9qmBPGMxDHxR3IySjvfoJHj2RwmlzCYg5R/cT08ScOLFVVMO1cm3GfJtX5gufmIl3rFoIoIgEIGCX9aMwVoWqS6CU7QRfQkLTKtxCwSVjRJ43LT/FCHtd09E7SExuMzyCbEkvbrJ76WT+syCkN9q/jIX8b/rUkULoDO2MgkWGdcF08ljzfRhmjbJxEnevPoOqxo95dYkmHk0Hm7cgxpFq6Voga6ywCQSncJxSwpH/b3u+s5GgznDi3MPAnJaMk9OdO7kzTFlFtIrwktQji/6wFyHRI831sZKMekmG8EFAFS00eNseWHYww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TiubfoGd6FiJa4dlphsd7/zk2zxUCm3jGyIhclpF+E=;
 b=HWXOttIa5LRh30CR1B0vuKL8MDL0YrjWETbcnnDCoIBMsYTqrl5fviCqKLJsdh5wIpUjE0RWgUpYBF7w2mASZ34HfDPY88uof3FlmR93/E3Xzf7ni6UXPea4Ut8xgP7loCaXSw75qnCxHPss5Ss4tkbqnOBzonxikmV0KGwYisCUwmut8Ri+2crQw4auAs187qS/lMNwK/8qnS7Tnr+OgMSiu0xGolSOXgqU8JU2j/n14X0n6E8KjsQ5lau9RD5mj0QJx+IFkujlVvRTSzCtjf8LUGDdyJ2rTvnjivwhzOHh2yTNUl7HmF9HRaJaa7kqS/vXDBmJoQIUnt2dCOkHOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TiubfoGd6FiJa4dlphsd7/zk2zxUCm3jGyIhclpF+E=;
 b=NCg86LdBhmWaoJmZyL7tncQYG9pDJfd7HSfTIa/TduD/Z8U7iCTjCee8uPEbKNH0lTf1JTXRqSgcbSorNvO84KfBKqaQQKTl8vqA2S+f2Ac+uMajB7+9UJWBOSiznvfLGzPf0O6Z2zooCXhZHw69p2ZwFgaiwuy1fR7mx73GuWI=
Received: from DM6SPR01MB0118.namprd10.prod.outlook.com (2603:10b6:5:295::18)
 by CY8PR10MB6490.namprd10.prod.outlook.com (2603:10b6:930:5e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.46; Thu, 10 Apr
 2025 10:11:23 +0000
Received: from DM6SPR01MB0118.namprd10.prod.outlook.com
 ([fe80::c04c:7e64:6721:98a2]) by DM6SPR01MB0118.namprd10.prod.outlook.com
 ([fe80::c04c:7e64:6721:98a2%4]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 10:11:23 +0000
Message-ID: <ca30c1ea-409e-4656-835f-31d29354c53a@oracle.com>
Date: Thu, 10 Apr 2025 11:11:20 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Issue with AWUPF when using multiple controllers in a subsystem
To: Christoph Hellwig <hch@infradead.org>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "alan.adamson@oracle.com" <alan.adamson@oracle.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <4a2e4561-9311-40c9-aa65-87e7a2e5b041@oracle.com>
 <90792c66-d0ca-401d-b171-57faea2c2cab@nvidia.com>
 <Z_Y3V6i7dG5Hr635@infradead.org>
 <34d750b4-88b0-4e4d-8545-3550175529aa@oracle.com>
 <Z_eNLCn_e1vFOu9m@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z_eNLCn_e1vFOu9m@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0032.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::18) To DM6SPR01MB0118.namprd10.prod.outlook.com
 (2603:10b6:5:295::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6SPR01MB0118:EE_|CY8PR10MB6490:EE_
X-MS-Office365-Filtering-Correlation-Id: cf3de42b-381f-41fe-f913-08dd78180bd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0taRG5FTjRYSjRtaGpOVXg0UGsxd0lrcEdyTHlnMWtBbDdFclhOQU1zc2tk?=
 =?utf-8?B?N1NxUTljbUVJeU16MWZ4NmZ3SFYzVCt5SG1uck8xVHF1MjBEaElGWGNlVXZQ?=
 =?utf-8?B?SEdhL05xaTdqYllUU1Z1cUttMEdYTGFtaXhFd3hmRlRRS2tHTU53anpDVVFx?=
 =?utf-8?B?NWRhSGtldEJWYzZCZWxSZ2J0VXRrQi9aU1lvNjNxa0JXMFJERDhJUkJOSUZl?=
 =?utf-8?B?cnBwSG0wSUt2Z0NkZzl3WFMwVXpGeGg4Q3pBSFhkS0ltYlBXNG9qMXYyeHRk?=
 =?utf-8?B?UzR5Ry9YdTNMbExtME91dFlEd2NaY0h3YlJPVEwzTDhIUEREaU5TbDN6K1VB?=
 =?utf-8?B?WDl5ZS9lTU95NmVGaGdMNFNvTkQ0VG1qRmg5QUlpR3hGNm0rQkZKa0Z5MmZY?=
 =?utf-8?B?elVzZTNJbmdTYjJOZ0x4SHp0U244WGlQcUxmMHkvNGJleTM1b0h5a3Jobkdp?=
 =?utf-8?B?Ty9PMW9WS0ZGaTdSTE5IL0U4eUUrREd0VHd4R21nZ0VGdnZrOEZUZmdleUk5?=
 =?utf-8?B?Z1BTS3pWdXRvdDE5MGkrdkcrNzVWWTlKTFVuNFY0cWgwMnhYaE9rUXR6Z3Mv?=
 =?utf-8?B?ZmdZZW5sZk5tRFNhMFJOT0lPZzVBRkltQ0Vyb1dMdkZIdVp3c0VFMUlQL0xW?=
 =?utf-8?B?dnhudXkyMmtSMm1XMGRoY3lQdGFiK2c4cWVOMWxxd3o5RUlya25OK3RHQ2ZZ?=
 =?utf-8?B?U0xJVTFwNm8rbkRGSU5oY3NKQ3RDQTNiTEF4M2l6UXpWUXN1SGJ1ODBNZFov?=
 =?utf-8?B?QWFEbEhjK3oxS3NyYmtaRjNTOWZKU2t2MEROSDFhbkI1UTVtYkRiT2hEcGVx?=
 =?utf-8?B?dE1qUFRXN3NRZDAxVThEeWs0dkpsRzVlRDJEU2ZNTHFyTWNPVGdKWSt5Tit4?=
 =?utf-8?B?YVo5VmJRMmhxMHdQMStPcjdhcW90b0dQaGtCOVM3aGZvanZTNFRMOE1ndldr?=
 =?utf-8?B?dURpd1FKNE91WWRIOVFnc0ZzR1F5c0F5RXdhWTZvWm0ydkZaN1Yxc2xEdVMw?=
 =?utf-8?B?YXp1eGZGTk5HSC9hNy95SVY5S0poSDFVWUhneklYeSs5ZFo4b3Z2NmxHTjJw?=
 =?utf-8?B?L2RVV1hGYmsyVUlidXErL3U4Y2xzTkViVkNURnhuM3F3UWdLelpPWU51QkdI?=
 =?utf-8?B?VGx5VWU3V0xKMTg4N2hYV3dvODlxelNpbE5xb1B1NG0vRjYzaDZnbGhiWVAr?=
 =?utf-8?B?N3JCbFRPOFpuUXBqYW5SSEtTT3hYQkxBM3J6alBSTUJxZFF3ZXlESzZoUzk2?=
 =?utf-8?B?ZFl0L1ZCQ0JIZlFVMmxOU0RBRzRBem9ia3hqZ0R0elpXY3NrN25Tc3Y2eXc2?=
 =?utf-8?B?SW11bUVzeFlETzZRNDJZSG1RQWpUTDZlNFNXd0d1WS9qaE12TnRjVzRObG1w?=
 =?utf-8?B?K1JjZzQ4NFc1WnRBSEl1RThCZzRCNFp0eSthTFdua1RBYU5KekVvOW5EQk5t?=
 =?utf-8?B?VCtyYUd1UTh4clhMZVgrcTFjLzhnK1B3T0lOQWNLVG9zMW9ZTldYYzg1WnZN?=
 =?utf-8?B?QmU3eS9EdjZNRmdSYzVRd2ZZc0xxcU9nL1dwZEFHaGkxdjZ2dDdwWFVFWG1O?=
 =?utf-8?B?anhQK3VVb0ZSeDkwR2JmQlNlY01MaGtCb0RYeGlEcWdBZGRBdTRpclp0MmRP?=
 =?utf-8?B?WTZTUzhNajZVMUxlM1lnUjNGVEh4UndEekZEWFE4bmJrdWM5ZFFxMmJkZlBK?=
 =?utf-8?B?ZHJEVXdNaGl5TDNVRnFieUluaWgya1Y0RFJwa2tsZGRpMitJN0pGYnd4ZDFm?=
 =?utf-8?B?SFc3aFpJMzVwaWdtSEthaWVGUEJBK1RkQjhUZ0lGZC9sN3RtOWZCSzN3a01B?=
 =?utf-8?B?VUYrSlFUTmpsQThtdXhkeWZWS3krSFBUSTh4TWt0ZUF2TVQyUnVwZzF2VklO?=
 =?utf-8?Q?VmlR69zarXIDw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6SPR01MB0118.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVJhV2FEN0xPK3QwcVFnMGM5cEhrbEJlRkRUZjhJUzNORGc2UWhjVU40OHZh?=
 =?utf-8?B?ZXJ4cGJGc2k3VGQ5RHpXSVIrMnlFTXF3NjJPcjNuOXFLZWkwV2FIc0JiakNo?=
 =?utf-8?B?WmorODZabVl2RVFoaDkxMVpBN0dpUkVGTWMyS1RzRDFMdFZrL2JYK2dOd3JC?=
 =?utf-8?B?MWtKY2xxVVpBRkl5anAvUGRxT29waEYrdGYwUzQ3emdlRjFuMXpiY0QvOG95?=
 =?utf-8?B?U2swY2ZVVzdTM0c2VUJpb29ackRrbVVoSDRYdUVuWU5nOUgvOWNZWlRMZmo1?=
 =?utf-8?B?VGxWMElqQmh1YXhMeWZReS9Wb25vS1J5bGlZTHd2ZXFoSktNV0dxcEw0Z0FB?=
 =?utf-8?B?dDhubVBqQVE5eU43eC92aTQvK3FxSlpmRTFUZGNMZHdMTnVob0NCdVZhdUVS?=
 =?utf-8?B?azlWYXpsaVo1NmN1c3czRHcyK0ZmaHkvNnQvbnhVL28vSEZNQThhSzVNTHc5?=
 =?utf-8?B?STF4c0tJWHVMVk41WXBpVUNEb3NOMWQ1WU9ianhuNURhcnBnZUZqb0hENWVy?=
 =?utf-8?B?K2h2V0hHWWR0U2lNMmIvaXpITXRZQXY1TVNuSi9yRHBWbU9JODhrREJ4UDA2?=
 =?utf-8?B?b0hnWVZrQkVmZW9KY0ZpZ2RJSlhRcnJTMVNndWpYYXM1YnN1UlQwTWZ4WWZo?=
 =?utf-8?B?blpqY09zTWlJK2tZSmxROEVXQXJ1VmdTWTZQV0o3L2JLcU9tb2FSUXRhaDMy?=
 =?utf-8?B?amRWZmhwZ205K2tMSlcvM1FpVmFZVVdVS1ZZakRBZVlmSXhEbjBYWlFnZ2NI?=
 =?utf-8?B?TVJaVHNrYmsvMDNTZTFka0VMUWtiZlFRaUJuMTFGZEtNK0JMMHRTTG1rRGU5?=
 =?utf-8?B?QnBoemIvSWhUSmhQSkNsRHd5OVZGZWFYRlBONC8zZVltQldJdW9NTWd3b29Y?=
 =?utf-8?B?Q0cyOG5IUDdpaFFlMEV4V25xSDFaYVl4MGFnUVFFbjM5NDUrbmJvVDdoaFlu?=
 =?utf-8?B?bmdhSkZyNkJITzd1ekdaL1EvYUNBWkxMYkdKYUNoYXhBNnlHSGJVbzZuQzNs?=
 =?utf-8?B?UXM0ZFJ6UjVIZFFybm13Y2l5UnRvYkllMUFGb1JvR0pxUmpISmxDYi9SVWQ2?=
 =?utf-8?B?N290OUU4VUhST0xYM3ltekQ2TG42MVF2REJpM3JiUTAyRnJkM1NscUFjaGNP?=
 =?utf-8?B?Q2pqRFBaUU1JbnFTanlIRTJnbDI0Sk5WbFhyczk0MEtLeTNCZkxCQm9ZWVJG?=
 =?utf-8?B?RzlvZE42UVJVOVRITnJqTS92VHhrSnVRNC9PR1Y0bDdmbTFQdzVCcm4zczJy?=
 =?utf-8?B?Zk92WVRoZGlEU2RiVDhBQ0h5T0hmeExQL0NvY3FjSlN5d2xTV1FtN3JTQjZ1?=
 =?utf-8?B?UXRGT1dmSzFPRU1sb0F5a044VmE0QXB1Z014RkRsL08xNUQ3RVpUMHVZeWp1?=
 =?utf-8?B?Uk5EVG5sM3N0NGg1ZWczd1lQeHFsQlVjekNLV2ZXcDBoTmtyTGJkN0hlWVcr?=
 =?utf-8?B?VnhVdkVmZnZXdlhqNzdoMjk2N1NJRzI5WlpmK2RqTU9RMlhZek5JL3pFd3JB?=
 =?utf-8?B?S3BTZDlCR1prV2h3S0grT1psTi9pV2dHbVlHdEtXWlIwS01CM21oeXRKWDRa?=
 =?utf-8?B?MmlOcGFCK1I4WXY0d0VHVnQ4NDZVc3FjSFVGZEFDMHRCZnM4M3JZeU5iYUdF?=
 =?utf-8?B?SForSkZXMC9pYkZkbEFKNmlmM0hObytQSWIwZG91VUNRZlQzdDQzbHluOWN3?=
 =?utf-8?B?L0RkR25hcXhQTEdteDV2SldtbHpJelcvZUM1WmpQR0s4dFh2MExiUEJoUkFS?=
 =?utf-8?B?ZnFEWFRwLzNFaDNoRnd6cEdka2pPMUZITXoxUlJXNDFmajJsWEhzYnlQTUZi?=
 =?utf-8?B?MmVndE1uVGRGNjdTeVV3KzY3ZjBoN1dhZjRCWlY5RFZSNSt5RXY5UVhKY0FR?=
 =?utf-8?B?dVdLa005OHhhSnFoQkRpS0ZpQmtGQjF4ZUltaVlxdmpjMjZZYWttSkZDc0Ev?=
 =?utf-8?B?THpBSm1BSFd6R0hRU0FyeE1TVTh4MWdpSzd0NnpJM1RBaERsMThpY2VKQkV5?=
 =?utf-8?B?SDkxQ3p0eENIMkdTTStidzdCMHpWam5oZnRZV3NBcWlzUHVUdzJDc2dRZTNa?=
 =?utf-8?B?NXV0NjM5R0kzWlhlU01ob2YyU0piMFhOWEF2VE5wSGRIODdWUERnSnY2aW10?=
 =?utf-8?B?NHl1a2crcUxNdGwzZDBkYlRYQkx5Zzh2YnN3S0prNndtc2ZjcUlXTkc2ZnlM?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0r71w4izyw+hgWc8Fmwa0/ooJN3p5tW2BTWugtlQ6bfE/LI7pViYF2UJlT19xqnnvodL2mlBNGqZdpNmVXOvAkM9wTXZK66Wo9C7/EZ1zN4XHm17GSfi5Qd9YC8HyNkD1wNChqgmxUFkwJlk7CJlLRHOWGTlNX//qgqUWi1gy+XedObUg4PQersBQonwj05uh7DgXJCoB7y3B4sfVwieHOXkGXmT5RfF6kxMujTAZ07gwRsTMHZczQ5WmukivuO2+wlE5uMYWRx3wcaxKvIyWw3YxxFPoWwIncDKA75efVSFLIiDhhYENduatvQ+U1ZUY0n7O1TYPHCFO84C2MKfeUnqGlL+Zrn5k6wrunr3rsvrUZHC7AraDMHT8VGHcXM0T/JKPmtRIVWCRhleB9IrBNyoY/eCK0KNYM3xq5yOZII7XK0ypiqw+CCMi+Txj/7m3RptRzMYSbiDIk+hDbKMhh6lQYI8zJPlqBpTDMNFkI7gAJxGP82OOYOPn88UfU4KK8IzzrYxPUFLfqYhMjKJh+ucpcdd+lqCgaZHPULcOT0X6IhmeL9JduFtgIqOr/nInwqrg/GNYdEoo6+EPrWap+Z8FVSSdrSMPTeeElkBz0Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3de42b-381f-41fe-f913-08dd78180bd8
X-MS-Exchange-CrossTenant-AuthSource: DM6SPR01MB0118.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 10:11:23.2094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gogi3nAFgPer0Sdndom92/97IDPAamw7fISSggVg+Bo15Irqgclk1Mwx9bREyVAy5M1j5ugwDRz0FuFc/3K3CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6490
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_01,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2504100075
X-Proofpoint-GUID: wECaT74AmCLNoMu6EAMxzNi_a2sK2DGa
X-Proofpoint-ORIG-GUID: wECaT74AmCLNoMu6EAMxzNi_a2sK2DGa
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250410_031128_061905_1A87AAD9 
X-CRM114-Status: GOOD (  18.71  )
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

On 10/04/2025 10:19, Christoph Hellwig wrote:
> On Thu, Apr 10, 2025 at 10:09:53AM +0100, John Garry wrote:
>> This, combined with no dedicated NVMe command to issue a write atomically
>> (which could error for out-of-limits size/crossing boundary), is pretty
>> concerning.
> 
> Agreed.  Given that Oracle is actually a major user of NVMe, can you
> bring that to the working group's attention?  That works much better
> than a random Linux maintainer.

Sure, I'll ask someone.

> 
>> As an aside, I found the scope of the boundary definition to be quite vague
>> as well.
> 
> It used to be really horrible, but got a major rework for multiple
> atomicy in NVMe 2.2 (or was it 2.1?). 

I am not really talking about multiple atomicy here, but something more 
basic...

> Which version did you check?

I am specifically referring to NSFEAT.NSABP, which is now described in 
NVM Command Set Specification 1.1.

I just found it odd that NSABP is related to boundary, but describes 
whether NAWUN et al fields are used or not (but not whether NABSPF is 
valid). Having said that, I'd think that NABSPF is always valid from 
2.1.4.4 Atomic Boundaries "The namespace supports Atomic Boundaries if
NABSN or NABSPF are set to non-zero values".

But from "Figure 4: Atomicity Parameters for Single Atomicity Mode", 
"Namespace Atomic Boundary Parameters" cell, it tells to refer to 
"Identify Namespace data structure" which describes NSFEAT.NSABP; 
however it does also describe NABSPF.

I am getting the feeling that the kernel driver should not check 
NSFEAT.NSABP on whether NABSPF is valid (which it does today).


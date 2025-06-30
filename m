Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDA3C83029
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Jun 2025 17:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VzcPz0JtkRoysnX7fPJ8iLLwD/1Fl4+fmYl/RBVjiig=; b=fwBBSbiHT3yeLlsgyV81gwnbFO
	7I/lhI39pO9V1CN8qiSQJ2QsEpPTaL792aG6VdUqQ1LvfcqyNMDhihyCoT3vUJspm8CQ3jML5nJCF
	cioAGEv6JhgNIxBsKT7VyickthAfHX4MAbxFYOSmKyDJwmmgIha3PegJmgYwrhNZHjYAz5A+v3jQa
	FfO3IhMOFEQhED/iBETtYBjC4MdV6yiTVEKI0ThfcYoBNY8WF/5WiIQGjGpvT3drjjztvVcXtfWMr
	NNRinaqDKioxXJ5ClvHa1RidGZ0We5RP4F3UohP19ZBBX2J0dNFhuDgUWPcXwIdKafBdtscetrMv1
	E7sK4oSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWIT6-000000035mB-0c4o;
	Mon, 30 Jun 2025 17:39:00 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWHGw-00000002u1Y-3kKw
	for linux-nvme@lists.infradead.org;
	Mon, 30 Jun 2025 16:22:23 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55UEktJ8020110;
	Mon, 30 Jun 2025 16:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=VzcPz0JtkRoysnX7
	fPJ8iLLwD/1Fl4+fmYl/RBVjiig=; b=VWJX9I9Y1mexy4qOaLOhRXRIFie+pZeR
	VTEBX/0ixVea2SytLRGM3NI77Z6/7QZEa6uzOhmOpNGlNuYCenk4ZyjhpuOIeym4
	iideW0BJGssuQyx5u/hIHD1LouXZeWBeFfhGRFNwpcGTX9m/lygdpNNVETRZRG8p
	MwmnZm0Lmh59MWB2CBHd3XgsNwimfyixSMn7CzqhSjgY4dM0OFnuGlLbjVpEmaI1
	+DjXgadXzoR70U5uwFv9MqK4EHlkCmjwS2dPHzwi3y1GVo56adbuwP/rwrO2ArWr
	ZH79/07xvtdHW7Q3pQebO5xvhEZbgiGoegvGU3DdOLN11H56jBz+Qg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j704awds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 16:22:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55UFXfYu011842;
	Mon, 30 Jun 2025 16:22:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u8apta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Jun 2025 16:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSjZDuBWqXj5NBHwzggOB7JedadF1HmrC14x2FJhiE7Zg/tAj9RAiOXlUG3wy5DG8IsWpMp6IHzscAIY3lDA4wRXt5pntnOahu9bVClue+jV7Gkz97be5I1MvauY6f2e29kjEEH0xJWLU53d66THGlPMGYiKjmEwtjNTcCu7jW14S76c6pyu8c6fboy7743ol/4ALL8dQkfSJn1j4HCEO3b7lrO0lQltT5b3sJ2wBK2rE6fnLgqZqnw4waoYRyaZgnQeUqio5l4qLENWq31ucv+XgHV1Nzky5KvZ1Edv+094YKkDd9QZX5PtkCIY//PzdRIPzfVidQ9lSQL30/27rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzcPz0JtkRoysnX7fPJ8iLLwD/1Fl4+fmYl/RBVjiig=;
 b=son+4lnX5fx7f6E3BTuZjIS0wA7p+dIgFlmqHCmO4OU/P63+FrY2dDDW3iKteonfcpgdt+d6a1rfkTWItNXkmNrFjMTtOBDBedxm7WXjyV+bU5ZXB1FSxcZ1lppPHtU87x4QolIUpJVt0NWl8Bsy2g8toqXAi+xkBsXbkv/x5mD+kvmr4GFVW8M+lpFc5OEuMdKWVLRTTuD+/EaAtEF5FgyWNOCxtqxYHSeoI6l7pCWRcj80HNzAWGaR+UFyHlent+17TTADJmZT6ueecVI8EAflnM2lS4geG39RnWC5r4c46voteWHalYBPnpUBu192DJFcQaGWFMWjCyu5FYgxgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzcPz0JtkRoysnX7fPJ8iLLwD/1Fl4+fmYl/RBVjiig=;
 b=vOlDv1B7tqCm0ua00luBjDXpqBIOitPyaFo+FgXZjsMfATI3O48rXzJB7l3E0W2MgnafdEsgqFmeiiLOWWjBmpsUpykzlYRtwMRzT1CpZB6flrIqhl/hDGBD40wGAWekEWotpSBpUssuiPQwWIZozKQArOTZ4vAyR33hznjQgrI=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by PH7PR10MB6154.namprd10.prod.outlook.com (2603:10b6:510:1f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 16:22:09 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 16:22:03 +0000
From: John Garry <john.g.garry@oracle.com>
To: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, alan.adamson@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] nvme: fix endianness of command word prints in nvme_log_err_passthru()
Date: Mon, 30 Jun 2025 16:21:53 +0000
Message-ID: <20250630162153.4040149-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:33a::7) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|PH7PR10MB6154:EE_
X-MS-Office365-Filtering-Correlation-Id: 76eb6ab4-a6c2-4531-5cf9-08ddb7f23f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rc+LeC/6oM6nlGUYf5ZUg3VqfWpRXxuQ94s6eTSUG3TuvMlMOiFwGDbJ3fIX?=
 =?us-ascii?Q?Zjk3JMv5hP8PUFUu/AIHMi3xroYjlRQL+939JM7pSfwYX88AtMaE4v2uYfp7?=
 =?us-ascii?Q?K4OHKMk7MyIHD4wWAI8puTG4hpuRkGGI6m/3jdeRV+HiZZfGmq1TwT58rTFV?=
 =?us-ascii?Q?u0vbHVsCzAad3YjKOL1yCXDQsKKLAOzdJQ6YFruyF6k92SJ3aabxUmOxiF8K?=
 =?us-ascii?Q?8I8RbxftIAAMWTObwmv1lKmaWUaQlZ9bscnuSDzayyIOSTn1ChswhIStFBpu?=
 =?us-ascii?Q?sImHqNmV+CNlLK1WqC3youQ9QbH1zrbEQPUhsMQtC4hVS74ZYy5aXZDnBcaD?=
 =?us-ascii?Q?oBXefjLXFV8lLs+QsiwR9HasnMaLPu6oRIvKZDNMc3NapOZU0WfwmUBzV2nt?=
 =?us-ascii?Q?Yik5u1Bj2+bsgj2midWLAHI+WVlKYkTctpDl72qPCrUAUkFSE53a+hGClFLJ?=
 =?us-ascii?Q?41nh0J1puR4MFc5BU8QdoOmGQanWJe0mYbO541H3SHm24zCI+bLJjLAjjLSp?=
 =?us-ascii?Q?FJvKWvq99sf+x74X87UnMdbB9DYHNsp7HvKFkzWPFcBpHrYLAoYym7Eyyilq?=
 =?us-ascii?Q?iHHOeH9/mf6dIW3ZK6INzOYgTVw7wgQMCgb6vfEGstQ497QOKiX6/a1Jx9qn?=
 =?us-ascii?Q?Khsx9lyvKdN2C8F2GdoSztzjwZDVRDhNBb5cNkU74Kk6YjpRyy8TdGNisnYS?=
 =?us-ascii?Q?+ce3TdRXn477Xk3B0p7eQgT9O8p0cC+zEZYl3M1tsNWVw9GZTLo5SaEUsyS9?=
 =?us-ascii?Q?+MK6uImT2YWkeNnWc8OeOUD3SfpmxptIQz75FY1FYwzZZMvqwsiSimqEEVMw?=
 =?us-ascii?Q?w/3VXG8fvZYnEhFB9+0TO6OXJFtwkSt0pkyIPREiu7Xb7eVYxV9GYYJ0Kgv/?=
 =?us-ascii?Q?ijCu4C+HXQ7WIX3pfNlubij7VAlMx7tXeMqKuVDLyiQztPgEQfcblY88WCyx?=
 =?us-ascii?Q?Cii9qidgDmSx5f3bci1L9fEqQnq81+fUktVXM7s6QDU3j+hYB0lCfS0e62BB?=
 =?us-ascii?Q?8fAbK7vLScCiTO5dH9IDlC9AxBZHZBHRiixWa1n7dEfWwbg99oXeZQE5WrU3?=
 =?us-ascii?Q?HPU2mAYpEcHcLPv8RF7NK1oskXG0xkApOmOXWPHhlZNhiMX1cFClkl8Kdi8s?=
 =?us-ascii?Q?eiL4zxhzUIfXrH+gyWKLAV3pgt3in0Xm1MvY1T+w9OqsDwd1m/26PQH1OZ0G?=
 =?us-ascii?Q?Ri37oEdEOxSXNK9yK4ILqrvPG9D+btFOBiTIn7c3jiWwLyQ1DO90uBd/CI7t?=
 =?us-ascii?Q?RwMuQtaDdwMgqbuEHdwx9MGbiWUpm7tuGd1S6MMnQVJJhazZNCYqCZ9c8a+7?=
 =?us-ascii?Q?nN/Y3wpJ/GgWl+8nDsjtla2DJkYQ37OpeaamLC061G14YDfwKjZefiPCFhWu?=
 =?us-ascii?Q?/yymPLt35a4g6o2YLbJRphMbHMyBpsIhj7Bx3DOOHbqmSyzyQfg+1uK36s/o?=
 =?us-ascii?Q?FKckY7fs0nk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?52rtxf7LTqaepbYsAzk399c6Cr/Z78uRQyhXiSwPHXODtmpQP0SL8ElSX2rc?=
 =?us-ascii?Q?yTSrAfg+CzqObETf6ZOKOJxYzquHP3sMri/+fXzMrppNqyHytK3vTgvmnCFi?=
 =?us-ascii?Q?d0KsWSEtaQGDFp2/laKgnHbP3m/HoVCbh3u+Kw2Wan5t3MYpQuVoT7c7q6yo?=
 =?us-ascii?Q?9TYknP7KDmS/po3ysdvzrN/Mndi7iA584DWaORkeQQp/zld0k+hEiZouQgPN?=
 =?us-ascii?Q?PH61yjeKoNbIVbKjdfX/CqSPomf4lES8PhUlE0DAQLk+Q86UcYlyldAFDNcc?=
 =?us-ascii?Q?zUjlEQFsmVutQ63l99pR1UHBxQk58PnaPp9iKo7JHtkCucFjzsLk4yjx3TXz?=
 =?us-ascii?Q?StcfnbXgncgqNWZsj92mR2C8rqnjD7DJVgR4zah1n9+C/5xJYSeApVVoBOOT?=
 =?us-ascii?Q?t2nqiQKVRHKinMzWlUOZyIquyn3yX4fuiw/tmNqiUAwSKdQMLpD2Tu0E2Wat?=
 =?us-ascii?Q?wpRT40OvWHe5HP1ROBye+lz2gay3ggytOhybjrAhhBtAJqdGP4Zfhl8EWBGc?=
 =?us-ascii?Q?tya/2CHvdZmdEK3YbgQSb8UlIk3qliKAy3Fv+ugOONo2NIZWTa5BYxsiOiA6?=
 =?us-ascii?Q?fjgkRNq9a+bMeDU7xZ2D3qiKIBWw9zOQIKkx0AEsrJc/9R+yaWW2WwLDGKD5?=
 =?us-ascii?Q?b7Fb4/UexKk9QqWiEB5UK7Pe5wT2gJgUmrIwY3AtIv5xlvzAT5kuyPuTgBli?=
 =?us-ascii?Q?Oc72XGDdkBFkpPtCGlmZpoQVHfsfg26eESTbiFPi8Ga1qVBbArp27S8dOmmg?=
 =?us-ascii?Q?gxofJfjNOXNfFDCHseYJ8rPTgUXmpZpgDn+agL1SycGww3nqQDIhxUyYSOv1?=
 =?us-ascii?Q?8DlwMnWLv9osWZnZ0cbvgVXMwUrb92sdC5XO3MAQcFwrOQzY7X4CBktkGhmj?=
 =?us-ascii?Q?XShESHNJ0BfgmbSH2o3Ei5Fk7fp6d600TdhdjWljJNJAyj6+4BHhTyZrrwqN?=
 =?us-ascii?Q?nquyq6OqBJuMOvrni3d7Bliy4O/2VOf7y6yvwxMlanzOeZws2eAQX6jcfc9X?=
 =?us-ascii?Q?S8LZAlt7cpppIkzc2dMo1svF1HF9uK2/WHzd29BbsnRXjd4XO+QguteblfF3?=
 =?us-ascii?Q?NHIgUz9LKL/uFW5Pk3zmyMOlh2bLyt4PJgQdjhVwwGbWKBA/zqBuqfMANWM8?=
 =?us-ascii?Q?TNt4MQXknHCeJNGKHLeFLrByeRJ55jZoyqIoybqWftEdbIqVv/o1LJkthLpL?=
 =?us-ascii?Q?0rWH6DGrrcQtL1f2UAcL2rOv5Mcwdcu0iH7mW+AmrS0Uo6fcwgyITytkZ5B3?=
 =?us-ascii?Q?U0J9J2IExYld5wXplsgw10bBz+w2IAwTevhp9W2zFriCTKStwxXCAag64hw3?=
 =?us-ascii?Q?UWXjnZWhVqXPeF8XRqJDjRZCdlQa36lso4XgdmAOLWjieL6BXggp8VyCB+W6?=
 =?us-ascii?Q?U2aY+ZQqUhKIUQo8bH2FPwUb/hQLKIHMgs9rj05C8ARyFiU2GC4wuVIdc5al?=
 =?us-ascii?Q?7PEwkIBk6KKySTXehLjbIZj+B6Dq9rG2WwO3i/Tm1QgPG3SH7Gr6kn7vCyhV?=
 =?us-ascii?Q?/3vsv+Gsd4BnNAESRPduJiRRbe4RdClXH/egif4tHvXZRepvH362CATjv2/w?=
 =?us-ascii?Q?kqFFlYawoSFH4wxyTyB/VFhe1t9PdlBpBu+k9TD9HzwYPnEWVbvPnVNpMcdZ?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D501GGLV3TW528qKhDD7UYYAcSVfbohK7GuDb0oD50Y1w99bT25g1fWxl5Xi8w8YkMfeLkIgakKdtQjuM3vXNN1tBlSLewnm71v3xBY3FiREiCSMDD6NfVpyqHVEIf3pZ8Aunjuzeo8Oie14zGdLDyrR7WXObrKvWaaSs0yXhnjy4UNp7Lai4rBbIvCfT7PvYhEgr3Un9hXNWDz+Cw0o3hGZtBrTHAWSosH79UHPpnY0askNcn6Drw637HyXnKTiHe7sosYMmWjodQNJWkvK9T3Q2Q5XxuQ+wsl7GNoV5BL21Y0DPUgwqQewoDVdJF+g4+uSPtHUu2xp200ED+YEnNyZOuzgprZBnv6DAok26OCKQNoY7Fc+mlNf+zq8+IU6Hx3QP9WX0M9jpjFA0O5TKb96AgpUKQ4H8a3a0kJdk+31Q0CempBKmBFAABj/Kgkh0CcjXsQVuHR/E4yLhZCP4ZqtK8TgFBwlnkJRE0vHZ9/N72ZDWaK4bcmwvac4Sh4VupGMZXRSe0hpQefDbfkbNri2XM2TDrEFB/UrRS/OuYip5MFVpcT3hs+zVTuSJ4iUz597DXLmZW6yCJct1SlIYB5BMr2mFGpKoDRs3t5TSKI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76eb6ab4-a6c2-4531-5cf9-08ddb7f23f44
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 16:22:02.9589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amtzO8uCpEmDIIHHE6acNaQ5HGsCMMHkaNePcPuMqx4kNuaD3TL6e08oQbjr/tc0yZbEsbLoenKTpkeSsXQ4Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-30_04,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506300134
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjMwMDEzNCBTYWx0ZWRfX3JXZkeKV1DK7 zWPdsGuDWVRlyxoBDwiq+Yiw+rbMxslUraRNrm9o01Zzc9B0X7JSMnabt/l8UxRzVBtTOrB0uZ5 5kJrX7YvnFtMY8oYL4LzPHt94lx01nDXeq/HVTVkWLyFFPuUxNOsDWDV11nj069JLP0HOT2KI+p
 Loe26GdoZwjnbiPUWZpJxnbSI73Cvgqug/l+hwEKxKwTA6FNAU3wrkM8FgSw7lMifYGIgdwNmAu 6YVXajg2/TxS6RjeQqp/19iTF6ICMdPinSUWtRcnE8MNI380v8u3f0t1q5YfFaUVeEDvqN7J1bi 4ZovzNzknyQE/S/KHwF1ibXRo6NT4RyKxMgp9H7XD7AImoxhqW9R6RCwHCkvpfZGsRgc20ULTlS
 U4JpNoZO5Ft/RaNOjwXNf7pWJ7HJHcpHeClNaRh50LeCq8etOhX8jjkNXGhrWdJaInALfLuD
X-Authority-Analysis: v=2.4 cv=LcU86ifi c=1 sm=1 tr=0 ts=6862b9b6 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=Jten_OcP2SFyn2vRdvUA:9
X-Proofpoint-GUID: jPsgmmT2rWJeVoe6MFz9T-Bt9nR95Fhc
X-Proofpoint-ORIG-GUID: jPsgmmT2rWJeVoe6MFz9T-Bt9nR95Fhc
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_092222_934312_B72A4707 
X-CRM114-Status: UNSURE (   8.38  )
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

The command word members of struct nvme_common_command are __le32 type,
so use helper le32_to_cpu() to read them properly.

Fixes: 9f079dda1433 ("nvme: allow passthru cmd error logging")
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
build tested only

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7493e5aa984c..551595c18791 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -381,12 +381,12 @@ static void nvme_log_err_passthru(struct request *req)
 		nr->status & NVME_SC_MASK,	/* Status Code */
 		nr->status & NVME_STATUS_MORE ? "MORE " : "",
 		nr->status & NVME_STATUS_DNR  ? "DNR "  : "",
-		nr->cmd->common.cdw10,
-		nr->cmd->common.cdw11,
-		nr->cmd->common.cdw12,
-		nr->cmd->common.cdw13,
-		nr->cmd->common.cdw14,
-		nr->cmd->common.cdw15);
+		le32_to_cpu(nr->cmd->common.cdw10),
+		le32_to_cpu(nr->cmd->common.cdw11),
+		le32_to_cpu(nr->cmd->common.cdw12),
+		le32_to_cpu(nr->cmd->common.cdw13),
+		le32_to_cpu(nr->cmd->common.cdw14),
+		le32_to_cpu(nr->cmd->common.cdw15));
 }
 
 enum nvme_disposition {
-- 
2.43.5



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8593BCCD1AB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 08:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D6hLYwL9WCEWS4zVsD4hVrixuLLFwUZW8h6S1EugbYM=; b=oR3uz0HBlvhjyn2/mZ5neHYu9F
	dbc5t4TiSTl55e9gKyABuHp3oQ7rcQx2qNqbNLjR5ubIsGwh9qRZpfdooRMibt1bPqBaeuEc/iNax
	9ewQT7cZrCoqoEiMze1WisayG9KtIv/SYDrJ4G1gjbAwUijNdinaX84n147q5fLZgw0WYHlTu9joq
	f1i64x1/rdUAJbs9Roet6aX2vNqRHBdfldEtk/4na9jIJuqgpqywEvP/Mr5UkP3PPvwxUFktK+J/E
	gd5F8HdjIKXvDg81mn4WsIatV7cn67WCcr1fvN1G03CG1ZAbwOvhkd1WgsXbdgK9Id5+RKkhpYugo
	RwyPk4AA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBUYy-000000029KI-15B7;
	Wed, 22 Oct 2025 08:51:20 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBUYu-000000029Jt-0xEM
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 08:51:18 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M8CGat001300;
	Wed, 22 Oct 2025 08:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=D6hLYwL9WCEWS4zVsD4hVrixuLLFwUZW8h6S1EugbYM=; b=
	PE1aif6v++WEb6WtggDloLbD0WdhEbT5H5WbEnCGfzwSmzmDZKxypMg5tXSTUJej
	MCdTBWP3oEdxVDA+G2Y1Tc3NAEYJHGaENJGjjKfI3Y/HfCNU2QsiBuL8qayjRNKV
	RWERdpDwhhlix4OMh+ej6pfnrwsVNaAJMXEBFQbansVxZR0X/klrZXSU3SbatdVJ
	TeNCdWEFoCswsim1st4rLhZBAzR4MB41V/wMJ5Eip8ynHUfiSC4yUJuP0XreNVmq
	0N4vpDuGxyrfvxb9eRKjv61aOHVv8zwCBvGLtXNNscoxq2nsbhtG0+4D6Oxo4SNr
	ch8qxSWxEOpukOuuzz6YyA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xstyg8mr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 08:51:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59M8jF52035131;
	Wed, 22 Oct 2025 08:51:01 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010005.outbound.protection.outlook.com [52.101.85.5])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bdx7ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 08:51:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=he3z9TEIe8jD9a7VtKfWxzQKkBqbIAN6jN4rZgXhbDNsKgC7ZDrfJrtNVFfURWFAzMRcJiNlOlCmquIGLvM0oDtQC9vxGcPCIx2GayDjngq/y0BC1nC4eacauRjO5uFpjQBjKErjAhFaLKiKIOTuGXRmX/fT/uc2jarrEDL/CP6tjtXdalOTk8X4oyLeOpCn+FLNnqXD2J24uqG5hkEMjS232InRroHNRnxegL8wIhPWgz64HYBtL4RpmVx+6S9vaADEVlTlNWmpxKB1ayY1bVQFf+UNCGDqWkFV3d6bQ6j2ZAqC2Jm0ylHnzZwrx2u5c8pd1bU8YFbsTDeizIsHhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6hLYwL9WCEWS4zVsD4hVrixuLLFwUZW8h6S1EugbYM=;
 b=CUbdgRTpokVSpuONS9KOFjLsIfKHSt5mR4FuVQ+LSJI31zA2gm+OMdeyoRITHczsebDKruIiMoXddH8hQnOOxriSoUIqOpXa1eCa1H+BCkg+r6vrph7feh5AEDGmOUzttsPiYrDrHPpZsK7btKV4jxDdIQna+1M7H/3qjj8YOw5UGhji9kQJ9ZlbdYo16+7/JRVpAFCQEiTxbmOuKGk3l8Uh6A1QJXXPO8NtqERoHVDj+f3VCJdvEhE1bwcK3xTdUBDDhypKkqaIaz/J8GnlXXKpJZM/dMsCcYEcP2pla/ff7f8rxdHYM3qwPhey6k+BKWnYpMMIbwRz0rUsqobn9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6hLYwL9WCEWS4zVsD4hVrixuLLFwUZW8h6S1EugbYM=;
 b=q+fZaM3DXMEWXS4sBegUyjStw1RXTw20/PBqkxwPCfuvJECc/BNJvU/7e6v3aw5AEhz5LKprTNGL6lMFMmLOyTKfb1eUnGN3XMTn56cfFnXvcZP6kre8sEclI2ATVuWcj4vWsC62A4BRRyS9MOgZXJX2yObCMok8zHBP7L8guA8=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by IA1PR10MB7469.namprd10.prod.outlook.com (2603:10b6:208:446::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 08:50:58 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 08:50:58 +0000
Message-ID: <e7873ec2-c447-4eda-9725-80e614c3e210@oracle.com>
Date: Wed, 22 Oct 2025 09:50:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: What should we do about the nvme atomics mess?
To: Nilay Shroff <nilay@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
References: <20250707141834.GA30198@lst.de>
 <ee663f87-0dbd-4685-a462-27da217dd259@linux.ibm.com>
 <aG7fArgdSWIjXcp9@kbusch-mbp>
 <27a01d31-0432-4340-9f45-1595f66f0500@linux.ibm.com>
 <a454f040-327c-46d1-8d0a-7745eb8a7aaf@oracle.com>
 <501169ee-37e9-4b15-89ae-8f2b57da270f@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <501169ee-37e9-4b15-89ae-8f2b57da270f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0300.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::10) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|IA1PR10MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca14960-9201-4b8c-f6e2-08de11481ec5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjAxdDBBWit3TXJ4SFNkTFpvbjB2djU0UENReFRZWmNkRHZCNklHVG12S2RX?=
 =?utf-8?B?S0lSWlQ4NUlDY25Ia3FIYzBxM1hQQkVWTXN5Z3JJN1ltUXVRMlBXSWZ6aEJC?=
 =?utf-8?B?M2JrcHE5UkRFdXlOZGlBVHhUejVtZVdla1FrWCtoZ283ZW9adlNSdnJjQUJx?=
 =?utf-8?B?NmthMHhPRzhpMGRYZ1d1VEFIN3pjcjNpTDQ1TncwODFkUnA4T1RranJPSm02?=
 =?utf-8?B?bVM1OXRDWEFVYjVOY2libkdCS0MycnV3eGZxTE9LcWkzYVRHVUJSV1JjbXZ4?=
 =?utf-8?B?NGk5ZDJTR0xrV2NxamxEeWRtUHkxUERHZFFNZDF4N3lUWDFKYTZpSitoeDBU?=
 =?utf-8?B?UERCdVgxa1o4QzdwY2Jza2JUTDZhOFFEcW1OdnZWSjhTNTdXcnpKdUtiRXRG?=
 =?utf-8?B?WVJpYmZxY080dFJ1alhtc3RqZk5oaklOZ29YTCtjZUhlVElVSE52TlRQMnow?=
 =?utf-8?B?TVMzZ0htWmFiZmhnVU55V3RLeGRuYzAxKytSNXRzZUp3L0Y2QlcxREN3RGxm?=
 =?utf-8?B?b29mNUxIRnNEL2MwTzg4U0NQWHFwODh2RmE3UzhvMXp2Uk01Y2RyMGk0c2dW?=
 =?utf-8?B?ZjgvdmJ2OS96d1NFZ2J0NDBBQXIrZDg1NnUxdzVRMHllV0IxUlVCL1BxaFlO?=
 =?utf-8?B?VUpaVkt1cml6Y0tnZFQ4OUpjNDdoZy8vV05ZeG8vR3BmajRnL1U4ek9iNHFW?=
 =?utf-8?B?V013cnZwUDAvSjdHbCs2eHNCMHpnb0E0VUU5RkNoY1hIcTk4T1crRW1PWHd6?=
 =?utf-8?B?L1psNHUyYitZbjdrYTRhK09EeFpPVStyZkRpSS8yQVRjclBNQUlDUVBvTTNw?=
 =?utf-8?B?bVAvNUF5cGJ2VlBzTTVQMlhNY3pCQlZNRDZpZ0tOV2d1OWtkMGEyOU5nYlZM?=
 =?utf-8?B?Y0N1NHdHMnlIRmFIanUrYkdXQ1NhVzY1aUhRaTRsOExsKzJ5TXp0dnAxMUFY?=
 =?utf-8?B?NjZzRm1GUC8zWHI4YXY4ZXFtZmR0NUFTN25wVkRmMG5WU3ZFMFpFenQzaW02?=
 =?utf-8?B?TGxCTjFSMzRqZlBBaXZYYmJVaDkrNjRZTWF3WEJuSFVoQ3NFZ0V4N3BpeDdT?=
 =?utf-8?B?eitMVmxPRzJXTVBEd0svMitoaGQrYUlLVGRPMHBNR0tsS0RnVDJsNTl6VFZ4?=
 =?utf-8?B?L1lXblQyVFR1dXQ2amF5STZMYkg4MGVZYWdmYVp2Q3BJVDI5U0pWQm5vNXpG?=
 =?utf-8?B?NkpwcUJDem5RMzBMeUhtVHRYS2txTGZsM2ozNnlFSHBzb1NMcEJKZW04SHFw?=
 =?utf-8?B?bk1vNzNWYVRjNXVFc3ZuY0JJZFIrcmpSdVdJU2h0VzFyaTVTaytMZUdBZmJH?=
 =?utf-8?B?aEE5aDQ4WVRVbFZMbVJvYlB3OTlzay9LK0F4b3FrREViM25WUHB2ZkxUenN5?=
 =?utf-8?B?Z05UdUhnbDZLcXUvWm9TSy9OZzhZSisxNVJ2OFY5RDVhVGJTWFp3ZEV3cXdB?=
 =?utf-8?B?cFI1VmtwdzFKTEtFbE92RWtUTkw0Y1NrWXE5Wk5XeXlQNndDY0Nqb2VSQ1pv?=
 =?utf-8?B?amd6Y1BrNjE5K2huU0RtakR6NVQzWGtGVkI2Zlp6YzRWSW5mM3M0WFEvVkQx?=
 =?utf-8?B?ajFsTTRTYmdKZkRucjQwVXNFNkIrdzBrN0VuZTBVVTlXdGU0VWhJLzV4ckNF?=
 =?utf-8?B?RW5pKzJicHR4UEpOaURoOXBvaFhybks5NVdXd29HOXJzLzV3NGFPcXBJN21D?=
 =?utf-8?B?SVM1V0wvaGlJdCs4RW5ST0NheFVuMlFvTFZpZmlFTjJDUWdvN00vbnVrQUM4?=
 =?utf-8?B?U3YvQUQ4ZmtjeHJJRnhrUW5XaGJBVVRhS0ZCakRSUmtxd2UzSjQ5NVVPR2FT?=
 =?utf-8?B?Um91eUNDU0k2Wk5uWWd2QmpEZkdQNWVEc0RQbW5ITkRvaVB4OVdiWkdUSWtk?=
 =?utf-8?B?UGkydVZZQUVxeFgraERuMXRoNzIrWUs4ejY3VUV6dFJ1N2FRK2U3Sm5mdWps?=
 =?utf-8?B?eVQxcHBQTnorcFZtMEc1dE8yVDFUZFU2a0p6VnpDYXdXRUU1OW53dkVUNTMy?=
 =?utf-8?B?YUtnSUNYSlN3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0ZtMWV3ZTVmYUdEQVhmV2k1NmdhSHM0WEc3bDdGcHE2dFlBNzZKUmxZVVho?=
 =?utf-8?B?N0ZFZFMyUlBjNFhleU91bjlvTm41dkhUYzNGRGc3bW14VFF5RWJmdjZ2d3Fx?=
 =?utf-8?B?V01MSmdnRUg4aFEwVjFzb0ZsQ2tySTVNWFZYZkQ1bks2RmdaUTNBYStoNDBy?=
 =?utf-8?B?K2ExWGVEbEY0Zm1jL1VUOVhtcVRjd09BMU9MT2dwY1FndUFzYXBZZWEramJu?=
 =?utf-8?B?ZVEvU3I3Q21GTkM3ZE04MnBvckhWaXZnNExtcjArY05KQWVSMndaN01OUFNP?=
 =?utf-8?B?SUFuc2JrNVZnVTV5M2x6MTRmNGU3dUNFM2FXNTlhcVVLb0lhdlNKbjVZUnU2?=
 =?utf-8?B?dS9BWjVBK1N2emFzZ0NrUklkZlpFS1hjMUh5V05PdlFWOG5RdWJCTXd3M1I5?=
 =?utf-8?B?Z2VBZWdEY3ppWUh2UHBNWmRweGJ2dnozWW1pa0xTckMyS2ljeitpQ0FEajBJ?=
 =?utf-8?B?alM0ZGpCZEdhT2dadGZBNGdac1FGcHF5cUZmdk9FejUwei96YU1YRjhlQ2JJ?=
 =?utf-8?B?cTY1aVZuZWF5dk9oYnB6MGRabEpEZGFlN09pcEVSL1d6V0lDRFZVNU1CL2lG?=
 =?utf-8?B?di9DdEdXcVhneExGdGF6d2d6OXNURC9jeTBMNStVQ0RZWlJ2dWNLaTBmU1RH?=
 =?utf-8?B?MTlWSGJQcU0wRW5CK1hDcnlvOGlCSUp2Z0R0Ri9LRHVkYm45SDJpNlVaa2Fo?=
 =?utf-8?B?N3JXVVF4T2thbSsxallTUnV0YjRWb0hxRnYzTUFPbFBmdUFDVzl2U1NqbzhY?=
 =?utf-8?B?TVo4cnNWYUVQdjV1VU85eFltYWlSbGgzNC96TGp0eDlSZXhKSC9STmRCNGE5?=
 =?utf-8?B?dEM5T3kvNmpLYkdlUXN2TFBrTC9EN1V2MHZlMTc1SzRvZ2ExeWRXcWEzc1h6?=
 =?utf-8?B?aXQySmdIWjY5Njc2TlFudXZ3NExyUUU4KzdKeWdUMWU2YVBHUmgySTRVK2ZS?=
 =?utf-8?B?WDNla0h5SUdIajVqY01QL3hCM2NRWkZOMXhxOXhXUDlhTWlNVlcrWC85elVn?=
 =?utf-8?B?VC9GdjlTYTUwQjNrR0lIeFp1V1ZVRSt4ZmdnRVphd2lFZ1hpV2JKVGpWUG9m?=
 =?utf-8?B?ODIyZE1iK1RMN3c4SkJYU242Y2lxQVlSYk92bnlseHRnbEIyeitxdUVIdEdF?=
 =?utf-8?B?cjFmWFJrSTFjb1liQUdNREIxRS9PeFljUHFmWGVMTm9vZVUrU3U4c0UzdFlE?=
 =?utf-8?B?Y3RwYThRdmRRTmNDa2pEMWZVM0FzaEM0NXhIRm95WCswZlRyVkdwVWxJL3lN?=
 =?utf-8?B?QlFITFYzY3M1bDRDdWtmRDhseEdQNXJudUVGbWZhcmJ5MFlIMkRSclZ3Zmc1?=
 =?utf-8?B?ZFMrNEJSMTFZQVJoY0NvcFNRYitMYkZIblF5TzBzNFBzTG91WkVPOExEV3VP?=
 =?utf-8?B?T1VzZWk2Yms5ZlFBZTFwOUZtSXhNSzZZZGtJcUxORVMxQU5sZ3M5aEZXbG5E?=
 =?utf-8?B?Q1dRTTEreW9hUnFRc2Z2bHlJbU02dDY0dkFRcEw1bGN5R1dEM0d6OXNuYmx0?=
 =?utf-8?B?eHRUSjVGSXdKS0lyUjMzWHhMWWlXNktaYlpIRWUzNis3ZmdMcGpkWWE2bXVv?=
 =?utf-8?B?RDFOZTE4dktjUmlQRjFIZ3BwcS9QYWg4TTIyRDI1d0FDeXhKVDNRb3RKTGov?=
 =?utf-8?B?bkEzbkpmSldzYVh4VmVCdHpnQjBvSlU5a1VFaXJkNWhiTC9SbEJURVljMGxx?=
 =?utf-8?B?NDNBZXBXcVQ3dS9oUjAzU0ovTmF5Vis0RmMzT2kxb2pUenNpZ3M3bXRzalRB?=
 =?utf-8?B?emFBaUdFWjAyYWJoTzV4Z1R1SndhSVlZQkxHL2NxMWFNbEJXWmE4UkJNcVA1?=
 =?utf-8?B?dmNGczMxMEwzZVd2QTJ1emh0cFpvMHdDUHZvY1NZQVhpY1BPSWNSN0ROeUNv?=
 =?utf-8?B?ZFJpQmxBTGRSTFNRU3lBRE1ldTZ0ZW5LZGl6eU5xbXRHMm8vTStkOFpYZ2RT?=
 =?utf-8?B?RTBja2ZqdDdxMy9oMElKVHQ3NzF2L0JuMXkvQ2l1WEF0VzY4NUY3WFYwenRY?=
 =?utf-8?B?SDYyKzV1ZE1CY1VxUXBIb3d4Wjd2WkVmVlVMV1BocjBSazJXdkc0UTU0K0p4?=
 =?utf-8?B?QTh1TGZuZ3RQc0lsVzFBYVQvbWp5aERLbnRDb2d3aHcyVU1PTnVldkc5UFI2?=
 =?utf-8?B?OHJQS2NqelVMNVYraEZ3MjM5RSsvb1Vhck9IdVJqY3E2V3o4L3IyVzdQOXh1?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9oVGt8/IPGYJHcaAPOUlMbJOAkeCAEAZTmDuc/MboYkl0RsTgdfdFY9q4fgJU2oDIvCKSM8oaUdY8A4M9mcblG1TKzecMhito1ZT6O9kZOIm2yOE+6dnUVoLKhO+BMj3PI4kDSc29ZRlebr9MNzn9Mw9EN534omY4EBs/PGwPlLs6Bgd1Y92OHTDhXdO5hWu5sbCfznxEuYxuJIXZI4J6sXMtpChbfV68c6d3llXhVaqYDZcVVjR24Sq3BX1AyUuCDA0BLGhjoDN34dY/yyxZrMOP0GJk8Ay5QlP3JWSkSM0NOFp+6uJ0lNyVGxbtID+QGWCXMdxrgBLXQ0KIYBJa455vM3hjfSIlgMovLtNXOr82J2mpn6E4Q76s1txOm3Y+/hmoSEZJMTuDz4Va25XYWAl++m9TGelBwH/l9J0FyWqNgL1lokLur5Fkro9bufcawrWanMRUiYTKgNGD90vkTLZo502s36nKFxxl+4fmRGjtQB1u5EZtqd/WUzCzbxP2M9V9KsLG8hRA1hcyY8dYNd7hPYETCP6V9zshoYv2RgIkJj/mpVEL9OJgt6kBq4xTpW75gQDVqL6n59IFG0TYUT6uj2zK3VeNUn3Irl+JtQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca14960-9201-4b8c-f6e2-08de11481ec5
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 08:50:58.6679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lU4jKl0mMrYgGaYOn22gDGglEpxpbcXoDOJQ0Ex6P+IVwAyRZunDnY0GqsdiJ/Xp4suboJ3lRV8i6/FJRr7/Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7469
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510220070
X-Proofpoint-GUID: ASzy6I7aLqtU5bmpvExDhUXy73doZ6ok
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA1MCBTYWx0ZWRfX3G8HQVbe5npP
 b3xSIY9UIzytEK1c/RPwvkfffIVQFnKDxwLo91VfDwLtX3aQr/x5sY1fC5xkvlP/LVivFttapUC
 6mSZsJLdOMbGOR25MdNG29nsZgjXCv6UTuJawpvflxmRr1p7z6u0H+WxKReeYV3Pyqvgl+XLtS1
 8zGEZZBSthLm/bVX0EcXM9z51sF78Z7OtaD7kppjODbWw2JVK4i5xMjnMaOKf/fp3noEsb7xRk1
 9u0a/OEaf3BkG+A9Qws31zfacw4GU47FTZsKi0RVlTKqza35QKUhqdtcoYczxi5nR4uD+KP1nIg
 ABm+VN2sW06HMJgV0A8Z06jBgXp4+ySzgszogf8Bop7OmtSyDGcb6NJE0JX+aAcnTIXnvr8MB/+
 ZfEMM9di63RrL8FroLCjAQ8mrlKo41hUrT/07rKo1NhnOVeug4s=
X-Authority-Analysis: v=2.4 cv=OdeVzxTY c=1 sm=1 tr=0 ts=68f89af6 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=I5r0CxplrSDLCy34:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=2u6HmN_5VmDs7RH6YMAA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12091
X-Proofpoint-ORIG-GUID: ASzy6I7aLqtU5bmpvExDhUXy73doZ6ok
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_015116_436876_F805B1D7 
X-CRM114-Status: GOOD (  15.80  )
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

On 21/10/2025 16:02, Nilay Shroff wrote:

-

>> Does the drive which you are using report NAWUPF as zero (as hinted)?
>>
>> If so, have you tried the followinghttps://lore.kernel.org/linux-nvme/20250820150220.1923826-1- 
>> john.g.garry@oracle.com/
>>
>> We were considering changing the NVMe driver to not use AWUPF at all...
> Yes, I just tested your patch with the latest upstream kernel on my drive,
> which reports a non-zero AWUPF but a zero NAWUPF.

Do you think that you could check with the OEM for updated firmware 
(that reports NAWUPF)?

You IBM guys (I guess that you work together) have been a great help for 
the atomic writes work, and I think that it would be unfortunate to lose 
the atomic write capability for the drives which you use. Or lose 
automatic capability (like in this patch).

Thanks,
John


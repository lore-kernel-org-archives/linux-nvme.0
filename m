Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02327C77B7C
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jun 2025 19:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w2OKp0UtYeLXwD+fTwWshwT6FpLciXOpoY2kywXSkLk=; b=Po+epEPewpFCmkzTpbKNt9iX6G
	3xG54kNOigldTle3P0CRh4nAx+PNXUb8cOkCPOcGxS6DJZdbCADkuXQG0e2EdUV1lN0CDjPMam+Iz
	lNU8rUhnjN6rDEv9ILNAbOqlR3LZY8xGR9XycXVrT9gE06CVl751oYXXb/cnZ18r+WGdliLrIUlCz
	kdJyajxoEejHTmcuo2EythYZePP07B2wgrMqbR6wAGAmZbE0muHxYWwNbPyqBu0g03VLj77afI2ei
	5wHGVEIu/DuE31JXso53eCoxV4jlJw6E1sLA4Xgp1MZsdmrvSVlW0UuOXhbH753iywSMDjFBHnVR9
	DEGG8NEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU9jg-00000006gA3-0JFC;
	Tue, 24 Jun 2025 19:55:16 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uU6fA-00000006Hc6-00Ge
	for linux-nvme@lists.infradead.org;
	Tue, 24 Jun 2025 16:38:25 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OFMkqD007393;
	Tue, 24 Jun 2025 16:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=w2OKp0UtYeLXwD+fTwWshwT6FpLciXOpoY2kywXSkLk=; b=
	Yp/GS2DtKQbO9Mj6m7co64audVbIZ1aklrxJQnKqGHzDRzA9gh8F62XNqI/u0wGp
	LSxNwxsH6sw/v1GGFc7Ukw7rjr1oexUPvkvwCdEis15sVlo7RfJjP3wWDbEHbpPX
	zqIqcQq2s3tRT3vF9P+Qd4MFF3eYbE016f4lYwpI+nIYWcRSX9UYLswlYwQr7rXK
	uLZn6GXi/7eCZ4NlNCdpGAqegF4cXzoEJgqok1FJjYxCO6MLCRUphRnz7LqM8EfR
	/ZqVDbSHTIdyXD8xGzJSSgzqyJoZopOL0b94nhMoHWx6XNiIbOxbYVaX5lkgvjP/
	2jAvhIQVcMisoEXkIkKluA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egummhg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 16:38:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55OG5AqO025930;
	Tue, 24 Jun 2025 16:38:11 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehvwc8dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Jun 2025 16:38:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIog83VVRnvg/orpTpOVpi1CBA+f5tp7Dj9YQiEg2twU1ddeUdResuxcMR9nSBSsSCNQeBzRwqFz+fUjODs9dUuYWeS5YEDxmFrV9SVAvlzJUiEbdvs2VWQVZBbt1+QskX1vpd6JlhYOkY1w8/iNgjpJQ/ZCgUvfV4/WlT8xr4Vmk8fyxrgDLmcI24gVZgywmhySpaolmzTTpYSPWAuVKlTKOrbsPdpPonAiIBO6TANJS8iVUrqeKYi3qU3YVH20KvPHpjBh3xFQkW7Ip0OpkGoMr+c8ab/hNRYoznBzJUnwLiuklBxE0KJVjbIw1FdEFZoS3Lg7j92qhwyLQ4ofcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2OKp0UtYeLXwD+fTwWshwT6FpLciXOpoY2kywXSkLk=;
 b=VjScT1MLFf/fiuJAZso4pcEJmHZaOwMjriumyWnYNNfnPpIb0j+G/lYMZPbEQ6pRHPL/B7uhTfu311uVBotBRpthVKc8CK34KSzKv5/goR84WqvJw0UATkjavDt1aGCAhdRp68BISNLGAwHGLJh8HqO4qmSLLHQEC7NUInQ4ZjfjsEv1OfSwTK9J/hvC7A33XU3VnLFzbIW9mWVLinhf3y/O6V7jpE4gTod6/6SaNvNcT2y/LBIs7Izf5khA6mCPHIu50RvxxSzKNlfqokhffLyEgT11WDloMvVAxAJlgNrqLx12pT/5qLRlngO8S03LOm41AiGl8AQlBTA8BOO5kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2OKp0UtYeLXwD+fTwWshwT6FpLciXOpoY2kywXSkLk=;
 b=THq5cKftl2Th0m2xDeg8usuXkKHzpipW4LCrG1WvhZpGKOMgpKzcZS2uf0hmU8TD42dLvhEazz5k56BRF8sVkIEz35h2HI88P4kjieZ7j5WQBeGIdvmSqtaLUDzQuNx3Smfo/e6f+lt6Rk8BNZNbBQK2FeISG9shqDYo4rqc9Zc=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by PH7PR10MB6483.namprd10.prod.outlook.com (2603:10b6:510:1ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Tue, 24 Jun
 2025 16:38:07 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%5]) with mapi id 15.20.8857.025; Tue, 24 Jun 2025
 16:38:07 +0000
Message-ID: <9d050842-700c-4cea-a1e6-de3b3cded40b@oracle.com>
Date: Tue, 24 Jun 2025 09:38:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: fix atomic limits check
To: Christoph Hellwig <hch@lst.de>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, Sagi Grimberg
 <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Yi Zhang <yi.zhang@redhat.com>, John Garry <john.g.garry@oracle.com>
References: <20250611055432.2401372-1-hch@lst.de>
 <99248994-4d8d-4d84-9279-b657d6969aa0@oracle.com>
 <20250616053627.GF1148@lst.de>
 <790a0419-4087-4181-b290-15db01ac1d34@oracle.com>
 <20250618053213.GA28614@lst.de>
 <9d0692b3-4d49-443f-b6f6-b13ec9a44f3b@oracle.com>
 <20250618171750.GA29321@lst.de>
 <89d34af5-6ad5-4579-8203-ac28d9432cf3@oracle.com>
 <20250623133309.GA27241@lst.de>
 <1802de7c-1f2b-4c84-9f99-a38625c3715f@oracle.com>
 <20250624131056.GA20362@lst.de>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20250624131056.GA20362@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR02CA0055.namprd02.prod.outlook.com
 (2603:10b6:a03:54::32) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|PH7PR10MB6483:EE_
X-MS-Office365-Filtering-Correlation-Id: c82ef2d6-04f2-4df5-ed65-08ddb33d7fcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ajEzUXJjNWpqK2dZQ0NGeWpwODNhN3Fvd0tRNEgrRmFITkhvVzJaSW8xQTNt?=
 =?utf-8?B?d3RScUp5bE5adUgzZ0g0OTh1ZDdPdkRxR0R5NndWWmJibVVtcjdoZDhtTG1E?=
 =?utf-8?B?VmxmUEtHd1JSWUYvbVJzdW9XMnhNRkVQUnFySHE3cnBSODVaU3h6Ti9ua0JF?=
 =?utf-8?B?Q1ZOYjFweVdYU1ZWVytOd1U3S25oQy8xUGtZQVhubCtnLzVVZkJuQ1hGOGtq?=
 =?utf-8?B?TkhLN0x4bHRudlRES0ZidVVIcFN3TFNDZnJHVlhWTkdwVEtzbkhVd2hDdnVz?=
 =?utf-8?B?NkpJRWR0RmhYZThBaE81VVljQ09vU24zY3IyZEdHWWRxUitDSlBsK0R4a0pV?=
 =?utf-8?B?cGdCOTZWTnZvVFhWVk5vczdlMXN1TmFsamd2elBNVWE2YTc1c0FjUXBnMSt3?=
 =?utf-8?B?WmlaTWJLRy9BVHU4VVZNMlVKMjZ0blVKUWpqZXJJanBxT2dHT0hyd2J6OHpq?=
 =?utf-8?B?dUxpbWVtNzBTdlVjZkUyNFR3RnNLWTRTWklXWVIvSEpZTUlEOFFhZVB4amVR?=
 =?utf-8?B?aXZZb0w2aWo0TUNDVk9nZ0FiSDJXZEwzSHhOVHV0ZXRTMEdycUcrMVhLcy9p?=
 =?utf-8?B?eTZHZHcwSUk2d09jYWFQY3I1ald1V2tFQUdZNmZCWHdMVkY2WHhvbGtMYTlk?=
 =?utf-8?B?bnhtREhMczR2c0luM3VINUZzNy80eHlxNDV6TVJCd1ZhaW5tcUx0TmF3c1gy?=
 =?utf-8?B?c2FIR0tOK290NGRxd1JaM09jUGpuUGJIZk81MjlYbmNHUlQzL2FIaFZHc2sr?=
 =?utf-8?B?VnV2dXVoeDRVL3V4Q1ZVOHJqNWNwQ0prWnFpV2tWU3E5K1ZIczVhR1U0c0dM?=
 =?utf-8?B?ajl6d2NxdjI3aTdaYXN1cWJFK2NTSmxYdEFLSnFPU3RrVzZGbmhzTHg4SnJt?=
 =?utf-8?B?UnNhR0NROU0wSVFKcjUxc0RJQVJqUnpzSlY5RTAvdmgrQkttNk12Z3lrVVI3?=
 =?utf-8?B?czhsWjQ1MWEwdFRZc2NKYmlHMGZDeDBlVGtNZ1RvYkt3YjVYVDlzNExJbTJl?=
 =?utf-8?B?d1JpK0xaeUZnd1VzcnVCR2pGZVJ5UE1ITHdVako4NTBEbG45dG1GazlROWVM?=
 =?utf-8?B?elhRT3h2ZDh2cUkxcGNCbGw1V0tma1RjVjFaRlNrM2JoY29lK2tjWVBESExq?=
 =?utf-8?B?amMyZENnOVd1UTU1bjBhUTZHQlh2NlFRZzJsMVlWc2NDVHJSWlR5U1ZHT1Zn?=
 =?utf-8?B?RTI4UlEydmRhWWt0QlIvbmZWY1ZnZ2FmVzVRanBkeGNxeHhTdHAxMndrd1NN?=
 =?utf-8?B?U1JLYSsrbURJcC9Ibk4zK3VETG5pbFk4OG91VzBMM1E2Tmx0SVJXMHA4L2U3?=
 =?utf-8?B?YktleDcwc3kwV28yZnc3V1hlSGhXMzFxdFZzVEx1MW1BYkIxU3B1NERxU09x?=
 =?utf-8?B?Z1B3V3g4U1BNdS9lSEVXUlBHdUtPRG9KM09hd1F6K1lUM2ZKS2VyWm9FckQv?=
 =?utf-8?B?aXJXNGpvbkMwUlVLT2JqYlBIdTVMR3dDeXpFTWtSQVFZOWlCZWlqZGttOFlL?=
 =?utf-8?B?aWkrSUZ0V2RmTXNDTjFOUm0rVE5xU1BEckRoL1A2bGVJek9GYlh3eE9pb2h1?=
 =?utf-8?B?MHdvS1o1c0YwdEcweFpBTWVXTFV1UEZtNWZWZU9XMXhnVzVqYzN4MFNBQ1Bu?=
 =?utf-8?B?aUN0V0xiSVBxQ3JZb3ltM05vcVowQTlob01rOUY3czZ4ZG5lSGYzSmlxY3ht?=
 =?utf-8?B?QlBhUXBqZFIvZ2JJS2J0Ry9Cd2UvM05Bd2pHbXJTSVo3M2N5ZkJWTTluYW5B?=
 =?utf-8?B?SUlrdFViTVRQNXN6d3FYRVhtWG9wS0p2NmwvWWJiU1Q5MG1pdG1Ka2djZzFQ?=
 =?utf-8?B?aHVCRVdKZ1NiL3VoUFdGTU1DcEhpTG5SLzV0dUVmU0RBVUptODIxWGMrSDZV?=
 =?utf-8?B?ZC9GVndObjlXSnAxZHpYRjM4VHhrVDNoMVFQVTRGcEdUeGI4a0hjMGRXWng0?=
 =?utf-8?Q?avVvwLz7CEk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0tTYWlrYSt1d0xPdE5rSmZmR1VUUGhtVkM4Y0p4QWFuZEh3TDlDVlk0bytN?=
 =?utf-8?B?d1kyeVQ1VUE2K1VXaVo2ZUhuZllSQ2RIWGxxL2NGOXVWRkRwaG5WZllOTUhh?=
 =?utf-8?B?V09Ddloxek5Eb3MwaUc3a2JwN2FHTHdhYUc3MmR6Yi9IZ1hSclY3UnkrcGZP?=
 =?utf-8?B?bnR5V2dVWUs3TGhPTExCUzE1TnRINVYwUVB0RThQM2lva0xjeWdoWHpTUTZ5?=
 =?utf-8?B?T3h0ZzFHek8rN1Q5N012akJ5YXFXUjlrWTMrM1dWSExTbnd4NE9IeGN2aHlH?=
 =?utf-8?B?WXZXcWZ5L1kxQi9DUER0OHQ1RmZMMStHRTl6VWNCK1BvbWhZVkNOZzRmSUVl?=
 =?utf-8?B?TmRqdUVtcWJrc2NrM3U2aFF3c1gxcEJuUjJST0RuWXljRU5xbHVVSGExcFlX?=
 =?utf-8?B?Ui9IR29GQW9jVHljZzUxVytjOGtxVk02cittMlFKNys4Y0lKOHIyZHhHUnpP?=
 =?utf-8?B?TTNuMzRvZ3g5YXpMK2dUMTVmYXhRZUp6QjB4ejFsL2dVYjFWMFNnUlBPWWZz?=
 =?utf-8?B?c2xYWVVEV2QzY1hxSlIreW4rTGwvUUIvM3lMLzNvVmVNWUF1Wkt2WStkTHhF?=
 =?utf-8?B?QUk5cjl1b0hNOVZkM25hVGUwUjdoSHV6QWxsQzIvemN3SmNiVFBXR0RUMjRV?=
 =?utf-8?B?aUh5bUVxbDQrd1lxc0IrQlNtcDRXb2owTEpMRXd3aVZEMXh2RUROMlFsZjlv?=
 =?utf-8?B?ZC8yUHFBdldxQ1k4cjFWRnhxZzF3dHZTT01FLzBYMWFqK2VZQ254aFV3YStM?=
 =?utf-8?B?L01ETGhWMmxhRldtM0RnVE9RelFoNzB1blpndzcxTkx4YlVqVHNTeUZDRTZK?=
 =?utf-8?B?VVpVem9KWmkxYVRXQWJhZjlZQUhiaE1UekY4WXRJYURFY1NMdWwzRHNvdlBL?=
 =?utf-8?B?TXVjK2Y4N0xSbWtDcVM0cmxUK1pCVEpHZ2lrait1ZldBUzM2TkpFYnR6VFNO?=
 =?utf-8?B?T2E1M00wOGtaOVcyL0syQVBHYW45ZHZQODk3UW9OaktYQ2t5VnQ2S0Jjd0h5?=
 =?utf-8?B?RWRFb2crUGRQK0hvU294dXVwdUVtMGlUZ3owd0c1Smo0WVEzNkIya2NUL0xY?=
 =?utf-8?B?Z0JEV2ZMQ2lIUkp2Z01FMHZwejlrK05YOFdZbmNLUit1T0s1dVRQa2EvZ1Np?=
 =?utf-8?B?ZzJJQW1SMVNCaHZjMFVLK2hhY3lyVVZ1SHRSdDZSQWNBa2dSME9tenJpS0pj?=
 =?utf-8?B?MVZKVVRjcytNRWsxbzNjUU4xR3NVdnVsZ0x5MFhSYjJhY3p4QzBzWHllVnc3?=
 =?utf-8?B?aU9pejFNa2dXWDUxZkNyUFlvcnNHTlk1eW9sZUVJMDlIZHpuclpZKzBsVjVQ?=
 =?utf-8?B?c05Na29obUg4MEZ4MGFCNm81UUttQVBLT0pHOG1peGFMb2pLVkZYWklySVdM?=
 =?utf-8?B?TVEzcXVISVRFb0VsRjNHZGp6R1BSdnFTMlZjaW8rbkUwaE45dWE1Q09sUHlF?=
 =?utf-8?B?OGFHQzRxYktKRjI2bDR4SmNpVVRibHRJdmt1a0hLOEplRVNpUklmRFdkT3FV?=
 =?utf-8?B?aC82cGJ3WHBqYUJSdjBmeHNvekhXREw0YlNtWDdYSlZiN25ycWZxYXdpVURX?=
 =?utf-8?B?Z2xiOXVuakE0S3FWbDcveGJMODFRb0hyWHp3T3lSSS9hbnhyNmVGS0JZMzlO?=
 =?utf-8?B?SUhWb0orMjkzNFRIVUNZRFlXQzJKVDgzcGlhbWFiZE9LWUI3TVJEcE9wT2dJ?=
 =?utf-8?B?Y0dneXZobzhRVGp0WjJNMUFrVmovYmJrcG15VkJET29kVDlhK2QzRTdQUGI0?=
 =?utf-8?B?TC9CLy8wUFVXUFl6dkpGQ3hxMk1wQmpkUkQ0OFZTdDNjaVpkN3hIN2hqK1p3?=
 =?utf-8?B?TTRkWmZVWmhYbHMzb0xpeXV3cmFLTkNKUU43UXdLYVhyUEwwdGhSSXNBTm84?=
 =?utf-8?B?QUVuTG0xMVN0REFpSlBLVW9jR3dWK08yYjhEUWVBZlN3TTRwR0EzaDlXVHox?=
 =?utf-8?B?bWZQbFgxb096NThPbFdLOFVlcnlhQTFGUXM5Mm9LdXFaL3pLeGlIRFo3bFFJ?=
 =?utf-8?B?Y0ZIOWlZUktuYlBJVlJBM2lUcU9NZWFXbjM3RTliM0tHYlowUTlaQTJ4U1lD?=
 =?utf-8?B?TnhZV1BjT25uWG83Mmgyem11UkVCNEFLK050S3BadDFFSURIMi9Ydk1RditJ?=
 =?utf-8?Q?uDVy2e8s8iiMpeMY/nHHlFygT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bf1cAfwL7MW/E3Y93/SgCaS6i80wyPThzvHhTcVgmFeP74dDC5jznm7io9rdFg3tKAna4pr075FGOp0xTVRgY5yQ7DOOGLtEhMKCPdtylB+2ZZb9BMpmu7XGA9ckrd96yZ8yGm1ZUvRg0TkSzjRSrwRip77rdGhEsWEkiFstH0SMTGV7HxVwbmUsi3MGqCsvmNZLuA/A1PcXTJj4r749rZan18jvIScgXWxaUyfsKWKBteT5tAy7Dq6Yxu6F/JYJlTc8yy+c68kaAMqTY8pTl6PcPHIifwOwJRT7KgK7/QjtHUaHy09Uu8+tcg4wqMCDpPLhh3eeN0bcp3bq+IHSFyEjk3zmsOZ27jXVlEWCNJ7zewmwxPm4Kvd+CVtDgpypYyUd97kTUk/ItZp6q8eU3zeGICbkpwiHEbNSc/qwWG9BrrNq0dsac6E4ZktVgDGJNtbqrohwNmpufRrLjiYtcTw8hh4Q+bKDeKtV4zdYcLZYybuE4XJANS4wss1xsQN4F9tYUJEBpjmGiHDk20Mc7kzJNKQWKCmlEY8oP8lx9lmePANSjsfK59OS3yt2/7aKxc0GtOeoH60vwDI2CXbNclIWf9Km3IN226X/2sqx02M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c82ef2d6-04f2-4df5-ed65-08ddb33d7fcf
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 16:38:07.6586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvFJR7P68aQWNTstk3tUXXXhjOiXXc6wdNvYQavNThJ8waKFr2F20CAnSAB/VZzPXSV0IoZtgBHQbMs2PJzIjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6483
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506240138
X-Proofpoint-ORIG-GUID: 9jJ9szk0hl8oJ8ZBDs9I5bSYZbD97drZ
X-Proofpoint-GUID: 9jJ9szk0hl8oJ8ZBDs9I5bSYZbD97drZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEzOSBTYWx0ZWRfX1diIYEX1t7yl 8kmD0S2GuRymyJCtk6MIelQgzkCtjHEs02OVPQ1dwK4e3Wg0GUtwdLyK65E4D4ECiBsiLnjZ/Hq VJUQdxi7aY/59roLjrsmhZs9ySZyoc0Ex4a019jRGyOBjE+lw7ZqPjZtQ0yU6RPtX+SA3KYa4P7
 D1WeDhcHY3L1afFypHhGdvlObjIVu8dCgDTGsZzSGbwHCGtvw5YLLuArETuZUzKGyz4R/xTBQ4e ilhfjKfuVhAJsEC6lT/VV0LpBmOF9UUdX4tltMiEnRKRCHbvS9P4Qwz8a8Uo/HiYVturfUUS0xq tWRI5ixpwTJQqYTbhqduC3+GkMgbSEIjWPIsuRHEGo9Ww0LIXFgHnjbpwyYei4ni7MKax2iaxms
 3yCHmHKEjdtQgVsd+cNGwx6fGIGrBPdQWECsmg6VufPQ4D7SeLjE05fIlePVdVlosDZQBvkK
X-Authority-Analysis: v=2.4 cv=S5rZwJsP c=1 sm=1 tr=0 ts=685ad474 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=GUOWdZUbekkKmqEh8PAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250624_093824_170028_147D5790 
X-CRM114-Status: GOOD (  14.96  )
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


On 6/24/25 6:10 AM, Christoph Hellwig wrote:
> Arrg, the patch did not actually print NAWUPF, and made me scramble
> really hard how the output could be possible.  New one below:
>
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 3da5ac71a9b0..90473d4770f5 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2033,6 +2033,8 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
>   		atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
>   		if (id->nabspf)
>   			boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
> +		dev_info(ns->ctrl->device, "nsid %u: NAWUPF: %u, atomic_bs: %u\n",
> +			ns->head->ns_id, le16_to_cpu(id->nawupf), atomic_bs);
>   	} else {
>   		/*
>   		 * Use the controller wide atomic write unit.  This sucks
> @@ -2042,6 +2044,8 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
>   		 * values for different controllers in the subsystem.
>   		 */
>   		atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
> +		dev_info(ns->ctrl->device, "nsid: %u: AWUPF: %u, atomic_bs: %u\n",
> +			ns->head->ns_id, ns->ctrl->subsys->awupf, atomic_bs);
>   	}
>   
>   	lim->atomic_write_hw_max = atomic_bs;
>
CTRL 0 (nvme0) - AWUN=31 AWUPF=15       nvme0n1
CTRL 1 (nvme1) - AWUN=31 AWUPF=31       nvme0n3
CTRL 2 (nvme2) - AWUN=15 AWUPF=7        nvme0n2
CTRL 3 (nvme3) - AWUN=15 AWUPF=15
     NS - NAWUN=31 NAWUPF=15             nvme0n4
     NS - NAWUN=127 NAWUPF=63            nvme0n5

[root@localhost ~]# nvme id-ctrl /dev/nvme0n1 | grep awupf
awupf     : 15
[root@localhost ~]# cat /sys/block/nvme0n1/queue/atomic_write_max_bytes
8192
[root@localhost ~]# nvme id-ctrl /dev/nvme0n2 | grep awupf
awupf     : 7
[root@localhost ~]# cat /sys/block/nvme0n2/queue/atomic_write_max_bytes
8192
[root@localhost ~]# nvme id-ctrl /dev/nvme0n3 | grep awupf
awupf     : 31
[root@localhost ~]# cat /sys/block/nvme0n3/queue/atomic_write_max_bytes
8192
[root@localhost ~]# nvme id-ns /dev/nvme0n4 | grep nawupf
nawupf  : 15
[root@localhost ~]# cat /sys/block/nvme0n4/queue/atomic_write_max_bytes
8192
[root@localhost ~]# nvme id-ns /dev/nvme0n5 | grep nawupf
nawupf  : 63
[root@localhost ~]# cat /sys/block/nvme0n5/queue/atomic_write_max_bytes
32768
[root@localhost ~]#

[root@localhost ~]# dmesg | grep nvme | grep atomic_bs
[    3.034383] nvme nvme0: nsid: 1: AWUPF: 15, atomic_bs: 8192
[    3.050431] nvme nvme2: nsid: 3: AWUPF: 15, atomic_bs: 8192
[    3.056716] nvme nvme1: nsid: 2: AWUPF: 15, atomic_bs: 8192
[    3.059079] nvme nvme3: nsid 4: NAWUPF: 15, atomic_bs: 8192
[    3.060867] nvme nvme3: nsid 5: NAWUPF: 63, atomic_bs: 32768
[root@localhost ~]#



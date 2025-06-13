Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89482C71136
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jun 2025 21:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=j+foKW4hqJDlAlPZlX7yl0biFLqgTQnKwjL8YIjlQ34=; b=WT2jSR9QSHUpCV7/tRhfnnRdep
	vvpzkN/f/QFKfTvBa1VI05wU+OH2NHrN4dlsqQuVVP+DmBHj+RdkDjTk75CSGvF18K09c+N9aR7gP
	Zf39euVImNlfD6wGpRYIPmuPeNdi2eYIjleU0LPRZ3k9VAS6wsotR4nQgHof4saQSaD1V4yhEp1AL
	Hhn/J2xhiqEpiUE7Iq/V5cHsikpB/z8NxfBZZrcdetd7MaRLN2JKUPh7PCDHBIQzU4K/+LUM+v+ye
	EICSKNHlS2OkhG3uesRP4l4GpaVujekoHz9Q+cobi+3GB/rgC5koBeWVHbszg/PQmzbr2dUyL/13F
	jKYHTcnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQBsM-000000007HD-3tXy;
	Fri, 13 Jun 2025 21:23:50 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQBqq-000000007Ci-0oyT
	for linux-nvme@lists.infradead.org;
	Fri, 13 Jun 2025 21:22:17 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DCtfkb001764;
	Fri, 13 Jun 2025 21:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=j+foKW4hqJDlAlPZlX7yl0biFLqgTQnKwjL8YIjlQ34=; b=
	ACwRXevF77D6aK28Q8djnifwxp1qf2S8R/H6q0FlNd32ciyRF8t7RgDffcks1TU5
	TdR8XDTbhNTTlnrkk9JzBBdNIQogByaka4rXu46hdOCvlfZAPMVhD7IG/DVOjeLT
	x3lkKVbsZ5RDf6PPzFhrY2Ehw8bN87stApHvPcZpdO8ABATZSUbE7geBI5Z0z7Ql
	i0Ok4KboDZFvsSux5KqURSBgeOXbvkvbxcmQFrxQifHUdOYpXGkJiHWu0LGKN+CB
	lNGoV5lcjK8vDTqP0AbhO65fD7aUJBIfRkgph1lD2jXnlDTqG5FETXSQtu1Pd04N
	phAepSO3h0JJFyB7dG+b6Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474c14mbuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 21:22:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55DKUihX040832;
	Fri, 13 Jun 2025 21:22:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bvebqj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Jun 2025 21:22:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P18Eu0lb/yalwE2KIoSIa5Uo0zuxKneigYutDWTrmS2xbUCKUu5SiQrG9L3Iw945oLl5zVrJemVPnfc9ekr6N3YoehAFuDEyjxIyU6M9H5HWwRdwjpNT+7ye9nUtFR6ZzHIeAKMol7UEVyNnYkHVJJrLc4I59tn8AXKJM3y7eUexkxgE/OLArTWeOeS9GaDq2RKhNs2Z4rXS4xhML0SdI0Xp0KKPDdkH1qvPDZjW+xz51uuD/BrB23URshC/QIL9uzz9CvAIIau3DvBLKzglVx2QMODONnj8pC9g7bVnhHpVCh1kv0thV4nQOvdxL0w8hsDdtIGmJx4ZQ3RRqgK1ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+foKW4hqJDlAlPZlX7yl0biFLqgTQnKwjL8YIjlQ34=;
 b=dHXylPdRmV3BzsAxhhMW6G2MBWTquutCt7t5Rcj4zhmhy1NZ1RuFD+OPlvcpWnmT1P64RH2yukoEwHYZjIT5s3pBo9+1Nd0+syS3w6FVsuGsGW5MPZUYm5P6Qy7f72dqpFNc5iZBvkA/oR0ZN4X8b4kyLf4gKkjr2zhLs6uikQXFhEU4Dd6pHy6aM9Z+g6U0+op0rrnNLakvTIft1BnkcDqC/Cm/RSnnLN+DKzgLnbYy0DgXFJ/6+Njh65m+JzrxGMGaUSXlAgqzf2nGPR9AJHy3cczjALs6m6mBAAZhi0RvL4XUIBtG7smOUYN98xg3zfm0FOrwwSdIb9d8h76HvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+foKW4hqJDlAlPZlX7yl0biFLqgTQnKwjL8YIjlQ34=;
 b=B66rVL9s3rh3GCtf6zBB22iMIQ8OsG8xp4v4PXWP0urkdXmYycC+fjCuY9KMxm52Yp8f3G+z7Go8xUYws8IrvpJCoKkS2ZB/T2eDruKmBJF2vd/8KPJFVjauLUNRBqt4kWSiHjDc0xxwg16vzW1/S7H4aomdfT7QrOcECVYczZ0=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by DM3PPF743D15148.namprd10.prod.outlook.com (2603:10b6:f:fc00::c30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.26; Fri, 13 Jun
 2025 21:22:02 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::10a5:f5f4:a06d:ecdf%5]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 21:22:02 +0000
Message-ID: <99248994-4d8d-4d84-9279-b657d6969aa0@oracle.com>
Date: Fri, 13 Jun 2025 14:22:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: fix atomic limits check
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>,
        John Garry <john.g.garry@oracle.com>
References: <20250611055432.2401372-1-hch@lst.de>
Content-Language: en-US
From: alan.adamson@oracle.com
In-Reply-To: <20250611055432.2401372-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|DM3PPF743D15148:EE_
X-MS-Office365-Filtering-Correlation-Id: e9256832-0dd4-4f48-1c75-08ddaac056b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UVQ2ckZMSnNuZ3BHbHY1eHBJNmRacTU3WWZSSWErUkJvUFRuMnZwa0xxM2VO?=
 =?utf-8?B?N3pCblJuZEZGZzlheERmZkFxR0RXVS9PU3JKZFVKd3k0VmlHTHZGZGUwV2Zi?=
 =?utf-8?B?b2ZaN0twdVVVelltSkhCcHYyTjZtd25uRTAvT1BHT0s5T2dCQjdCNWxBWW5y?=
 =?utf-8?B?dU5lcWI5dGNkSkF5YmEyck5HeVJBUXNxYnBNV0gxUlg4L05aRHNldzhRS21X?=
 =?utf-8?B?TE9va3N3TGdqYm5WQ3BQVGVwcENwYVQxaTFsblhCOU01OGx2M1BvaTlqSFM2?=
 =?utf-8?B?MDVpZDNzSmVIemxnNms1STVMOXhQVkdGcGpwWTNxR2VzS3NwNDBXWWdQWklL?=
 =?utf-8?B?ZXZlU0lVdVEwNnRpcEllZEhDQ29NdE5hSVB4eUlqejNwVFhPSS8walBKTmVM?=
 =?utf-8?B?RUxkR2hpa2VvbEtYQVdsMUZhM0lWZTBZQzBEeXZ2NWZRTHVVVnRiQnhBeFdt?=
 =?utf-8?B?cU5NUDJ4R29EWEFnVTk1S2NaS1lWYXBVOWphVGplTDBORFVUMk9IT0wyc25t?=
 =?utf-8?B?dEhyZVoyQ1IzdFlPNjlrcGUxMTJWZEZrZG9nekJjK1R6M1ZERHNWRHhmUkU1?=
 =?utf-8?B?M2hDdkl5QzZWdHJjVHMyY2ExODl0eHhGdjg2ay81cDBFNEJ5LzI0eGdJVGhP?=
 =?utf-8?B?UFJETFhWQ2Y4TlZkRXB6R2YzYSs5TXFIYWFGOS9ESGVKM3hVYmlGZGJUWHVR?=
 =?utf-8?B?Y0xzblFDb01TTDd5QVJhdG5FWG9QN3h3SEd1cEZ3QkYrZW4yRjdib3FiaDFO?=
 =?utf-8?B?c2NNc2w5cHBZSGpyMVhBVjBTZktIb0ZxcDVYMEZzbHF4UjN2MmJTbDNaS3hi?=
 =?utf-8?B?M29aemt0b0YxNmJ1LzcrTzBuT2tuZXRKMUttUjFKbG9hc0Zrb25ZazNhcGFs?=
 =?utf-8?B?UmFlM0hoMXBkMVB6RWhvdk9qMGswUmNUL1kwVGtPZ0xYSkF4VUVqOWNSaDFa?=
 =?utf-8?B?VExhWG80UGw1MGN3S1JpQjFNa0NXTEZuM21PTzhqTjF5OTU1VnNzeWFkZC9N?=
 =?utf-8?B?eStRU1RsMDFZT0ZucGJra3Y1aHRPOVNvUHp3V3BrUVU3aVl2ZXlhQURObkl3?=
 =?utf-8?B?Nkl0VDVETU1mVzVLcmNnNTA5TmgxMlY3alRxWlF4eFRaUEtlejc0b0FxRzgv?=
 =?utf-8?B?SFRoMGRMa0E1YkMraGQ2b0R2Ykl4Tlpkd09KeTRDOTRMWHdXMFJOY3UrVFZZ?=
 =?utf-8?B?L2VLSzhORHNGcmtvdjJTOUh0T0xJR0d6RGUyYytGai9QcWdUVldEaWN2clp5?=
 =?utf-8?B?Y2dHODBuSlZwTkd3Vk1JYkIwWFFWckR5OXJvTEpVaUEzY0ltbnFsREdkR3lC?=
 =?utf-8?B?eHljTTNmckFCSDVUK0F4dm1hak9wQzMyVjlacGc2cXhPK3E1L3Evc3ZoUGtV?=
 =?utf-8?B?OUNIRTVac2JYQ2tIUjdOTzZkRTF2N0hYVDg1QWFxZGZkamVzUXYxenV3MVZs?=
 =?utf-8?B?UU16NkxSTHo3empZcTVxRnZQbzRxWHgwRmF6NXUycUdDdDJwTGRYbENBMGdX?=
 =?utf-8?B?Tk90YUlWaUxwWmNwOC96QzF5RElzc3V0NkpWT2VmVWlsUVV5NVF1MzRJNDZD?=
 =?utf-8?B?UjlnemkzUkkxUlZIazBvVWJBMmZzNjllaCt0QzNVU1MwSEhJbVhWL2F6ZUxH?=
 =?utf-8?B?bnN4QmlQQmxBZGxMeCtDRDJjYzdyTDNCR1htd2JpaFRwQUdtWnpMdms2bGJZ?=
 =?utf-8?B?WkNKTFZINTlic2RneDhnS2l0cEdBQjdmdFJ2b2RwQkI0eGQyU0JmMWdNTEtL?=
 =?utf-8?B?N1lpaHFnN0pnTTUyTWgyYnlDZXhvTm8zUnVqUGtBdjJvSXhSRWNRR1crOHZj?=
 =?utf-8?B?eDFDYkNXTFo5aEUwSURtWWlXYmZPNXBEOXBWOEtGNnZ3RDE4U043VFZjVFNO?=
 =?utf-8?B?cWFuRVhiRGhmb3Z3bFF0bVhLR0lrU2t6TTRHcFdlb0dwZkdNSmxNUlJILzlm?=
 =?utf-8?Q?h5d58fNDh2g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2hSb0cwdFJ6Y1JOUGYvd0QvYklvMTZBM3g4eks1Q3NWQy84SXUxVXZUWkth?=
 =?utf-8?B?cmJHMVFtVTcwdktyNjk4YWdDVzhxMER3U1ZIdEVJRWtCNVZROWNFdVNTZnk3?=
 =?utf-8?B?eElaMDJnd0ZsUForckdSeUFtcHNKSU5Nc1JzQmloWVhrRnRXTkJGdGR4eEFq?=
 =?utf-8?B?SU5EaTdqenpIaUJPR1dBZEZYemxXL3ZVeXplT253STRUc1JXRVpyYU9STEsy?=
 =?utf-8?B?OURyaFBvUTVZYlI3SmtvS2huL0RaeFZ6QWgvTzRQRWxuVTUrVHJyWTR5REdu?=
 =?utf-8?B?Q0N2UmxQQlJmcXlxSUNmSVpFQkZlbWhUSk1mYUVMdmxVU2dQb1FadEJ6WUw0?=
 =?utf-8?B?QjdhQTJNSVB3eUJ4clh4RWNEMkpsd05CclA0N1g2R2FmS1A1MFc2THFLMFRo?=
 =?utf-8?B?Vlg4TE5HM0VhLzVLMkhwL0NpQTFrbytKc3U1LzI1UzVXbklTdVpVYWJPTkIz?=
 =?utf-8?B?TCt6OEtVV2ZnZmlkL1BlbXRTdWkrWkorRlVvM2kzL3Q2eEhUWUM5UVNTY1Yv?=
 =?utf-8?B?K3pqc092RGJ1djhaVDhoVE13ZmVmbWR2aFc5Z2ZZc0JWbVpld08rWUZPd3ZE?=
 =?utf-8?B?amlnR3J2TjlpQi81TDFKTTVxOUFDV1hBN0lpL0YyWnhralV1Nmx2cWFOOHRZ?=
 =?utf-8?B?ZmFWRzBUL3Zna2FjTkVOcFhzbWdydEt1dThKMXU2WEtISmU3TGV6Y1F5NER5?=
 =?utf-8?B?SnZTcDFtdFFtN2JSQVlHR0hsei91Y0tNNWdDemVrR2s2MlBTODNwbVRMUTU2?=
 =?utf-8?B?ZWt6bm5xdVlST0dYRW45dlpUYkFKTExDcUNxY3RyekNzLytDci9oN3dFMGcv?=
 =?utf-8?B?Zk9jbTYzbVMvNlJZYmRZM0hCdFUyZDB2SW5mVG1lL0JTRDFjOFlPcjJuN0sr?=
 =?utf-8?B?WjdVT1pHL0poQUpRRnk5NjJTcVdOTW9ZMGQzdU9VNUZxVy9BSkJpT01HMndu?=
 =?utf-8?B?dUpDVEpIeU1SK0hSbWdlb3AwZUJxS3UrVGQ5dVpYNGVDbXM4OEp5eFcrWjJv?=
 =?utf-8?B?MUJJNzdVNVZyUTYrM20xYkRyTC9Hb3RKdWI1TGJTTlJlUzg4b2creWt3Ukkr?=
 =?utf-8?B?dTVXMTJuMTViODJJZFN1eDZJWUdlOHNZU2k2OXNCWnRic2VEdSsvdVJTSW1N?=
 =?utf-8?B?M3NXL0NiNHdYTXM3bi9oam5RbmxsbDgybWRHWVVjU29icEdhWHk5eDR4ejhy?=
 =?utf-8?B?UG1yeFlhbGhETzBHWFhXYzU0VS9lRmZTcXN6ZFQxOHA2Z3EyaFl6WUdTbDUw?=
 =?utf-8?B?YURjb1lheEFsaEh0Mm9FZjI0cHlzMkgvV0VzV29OUHZvWmg5T0xIbXEzTkwz?=
 =?utf-8?B?RjNsN2FKeUk2NFdzVjA3ekMySnB5czJKWDc2OERNYkpmYVI1RnN4aGs4TUVx?=
 =?utf-8?B?bE9vT1RIL0Vrbzg1T0FuTExmTDdQNWFmNXhtKzhOU3VJWndBa3RQUWxOQWZ1?=
 =?utf-8?B?aFdHcWQ1Ri9GaDg1UFI1OHlrM0s0YUp4c1VQcHZ2WmRSYnlOQjRlUGxlOXJF?=
 =?utf-8?B?aTZwT01HOTFySkxWL2FHVHlPU2FGT1NTQTRtR3dqajZldCtLdHpHeUdBdFdL?=
 =?utf-8?B?RWZjSTBHV2ZjNGdSR0twUXJWZ3c3RGc4YTQ0RnhxV2UxWnFpYkYyNzVDKytF?=
 =?utf-8?B?bDA0Tk9mUERNUWVKTEtFcy9qSVFKNjJQWHFWellBc1FNTVFUY09raFZUWTV6?=
 =?utf-8?B?WC9rMUNVUEV6ZVVDWUc5VXpuMWROekFPaEVxUnNmMHlOa2xSQVFLNWJZY25k?=
 =?utf-8?B?UmN5WEpjS09XREtQK1pLRUgvdUhHT1lwcUtqaE56Q1M2R0pLZzk3VEUxc3lF?=
 =?utf-8?B?TTExY0s0WWdyeThYTjNhRDllNktWUkJ1VEF5QWUvZWdRTnlzZFMvZGEwR0ht?=
 =?utf-8?B?WEo5ZHQvM0luVVZ6a2YzeGlGV3UxNENFTm5BYVhZeENBQUNSZGM1YXZyMTlO?=
 =?utf-8?B?Vy82TXZteEo3SUxMc1dMTGlwRGlpS0NwTnRJNkZISGRxbWxBc3NPQmZHU0Nm?=
 =?utf-8?B?OUk1U0dXWThmejFDQVB2bDNjVXc5ZUNZQlo5SmRSa09hSTJuRDRJZFdmbXRE?=
 =?utf-8?B?bEpLSmpqVElyT1M2aUZ0UXRpM2U0amJGQ1IrZExwVkJ0RlIxL3VSdk5paE1Y?=
 =?utf-8?B?R2NsZk9PN1YvMDRBYnNETXEwd0hMSzcxYVZ1UzNSVjdqTGpPbDZ6SDdUemJS?=
 =?utf-8?B?amc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LEK1O/roaG9wSPpclPKkMEIA8KTPl77LWO2gB8KxMzyBT0MQI2GT4mocQbveoWaGnLnDnwjpbqp4D3N5zCzRAK9HoP4sMOprIGVqhEtFrHk5O5n4IBm+2hSa5afCSaekL4rptuU8JtYoCcnu5SuTO30zH6nE8ds4yTnXpVDNtjkTUt9UwKT2oOM+YExO2J2ZCqu3iaoN0zBn8TmvEDFs/4pd83/ATOdibpfJ+b09YF1SE5X08tVvb89tM1kYOfaPZdIdL0Ge3HkKlN29rPLTq8xvJ8akIOcPsdD14S3hpqjXGP9vIDI6WQvrakdN6JKFvyCQGyK/8jLAdNwkRMjBjcC8dsEUGsZwals6KlixFxFCQ+aq7j2bTwEvzHqnHcNg+zxq1tpJewuk41eW/2OcAGx808Ob0m+sRrAMm9LN55Ttj/ReD89yBKDN+mEXyUsMwv4Qy0ewqiOmY/+/6x+L3C9cUN3Fod1r9ZxH2cjgMW819DdsYGvtXzc5U94qaPx0zTgLPef6d9MiYSSrPKkiWaph514L8bmtoYUPTg8Eob+zbuFNcjFz3o2EQ+eEm2cfoWfZLCb7h3bZ3A+f34KIM7LNAGw5reMaEcyBZNAeyvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9256832-0dd4-4f48-1c75-08ddaac056b5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 21:22:02.7384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jrxv4nTaRTHUmW9RUjayIYXd3yeqfmp6kvqHsArtHZu6uz1H3meQppb2JQZ5SlLLfITXlKq7x7GydzxW4FVRKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF743D15148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-13_03,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506130151
X-Proofpoint-GUID: 7IogSUk4eBY_ItFDoJXIyFGpREmpvqrD
X-Authority-Analysis: v=2.4 cv=GcEXnRXL c=1 sm=1 tr=0 ts=684c967d b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=_3-NZvQfHRNs47lwsW8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEzMDE1MSBTYWx0ZWRfX6LjqvnapNsTV tHQ/4c+9AKvrVdR7OEPxBI7bKqVKaxOgO8ysnj4vI0ilISpjhG72BseGVQfba/e9PTTERTA72He /zOWXWDYKMzg0dGp7k8HveLiyt+0gbDuljd0Dd0VG7mMi4PTToW4qBBeav7SYKG9N8XS9gznYZ/
 omt74a6suKzC8H34U8nlKF8EbZ9MAogAOxiKWe8R5Fw+Ry56RkWOKDF/vOY17GUFPQY5qeT9LYf TTRx8CkZkXJJWMMcpb5WUYQvZcNOzyzUOY3oDbd7/VQQxvOgWxU9SX6pa3XPHhkL5TR58oYhNNF c4HLDF+WJQ+zqDrl98OtSnxULdj+53hDQpItPNc5GEQisJ4ACaJqwBx7zaDNImLXlmwGaJpidAA
 2fxdAzGgXeg6spuVzLz5pTlrwUmdbUKcmiusCxnXRE708CmEgkdt5+CQ1Ymw1rvdsEAT54PE
X-Proofpoint-ORIG-GUID: 7IogSUk4eBY_ItFDoJXIyFGpREmpvqrD
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250613_142216_238412_D2EE639D 
X-CRM114-Status: GOOD (  21.76  )
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

On 6/10/25 10:54 PM, Christoph Hellwig wrote:

> Hi all,
>
> this series tries to fix the atomics limit check to limit it to
> the per-controller values and to the controller probing.
>
> I think this should solve the root cause of the report from Yi Zhang,
> but needs new verification.
>
> Diffstat:
>   core.c |   84 ++++++++++++++++++++++++++++++-----------------------------------
>   nvme.h |    3 --
>   2 files changed, 40 insertions(+), 47 deletions(-)

Some testing with my qemu-nvme atomic write setup.  My qemu includes ns 
atomic parameters that isn't upstream yet.

-device nvme-subsys,id=subsys0 \
-device 
nvme,serial=deadbeef,id=nvme0,subsys=subsys0,atomic.dn=off,atomic.awun=31,atomic.awupf=15 
\
-drive id=ns1,file=/dev/nullb1,if=none \
-device nvme-ns,drive=ns1,bus=nvme0,nsid=1,zoned=false,shared=false \
-device 
nvme,serial=deadbeef,id=nvme1,subsys=subsys0,atomic.dn=off,atomic.awun=63,atomic.awupf=31 
\
-drive id=ns2,file=/dev/nullb2,if=none \
-device nvme-ns,drive=ns2,bus=nvme1,nsid=2,zoned=false,shared=false \
-device 
nvme,serial=deadbeef,id=nvme2,subsys=subsys0,atomic.dn=off,atomic.awun=15,atomic.awupf=7 
\
-drive id=ns3,file=/dev/nullb3,if=none \
-device 
nvme-ns,drive=ns3,bus=nvme2,nsid=3,zoned=false,shared=false,atomic.nawun=63,atomic.nawupf=31,atomic.nsfeat=true 
\
-device 
nvme,serial=deadbeef,id=nvme3,subsys=subsys0,atomic.dn=off,atomic.awun=15,atomic.awupf=7 
\
-drive id=ns4,file=/dev/nullb4,if=none \
-device 
nvme-ns,drive=ns4,bus=nvme3,nsid=4,zoned=false,shared=false,atomic.nawun=31,atomic.nawupf=15,atomic.nsfeat=true 
\
-drive id=ns5,file=/dev/nullb5,if=none \
-device 
nvme-ns,drive=ns5,bus=nvme3,nsid=5,zoned=false,shared=false,atomic.nawun=127,atomic.nawupf=63,atomic.nsfeat=true 
\
--nographic

A single subsystem with 4 controllers, 1 of the controllers has 2 
namespaces.

[root@localhost ~]# lsblk
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
sda           8:0    0   40G  0 disk
├─sda1        8:1    0    1G  0 part /boot
└─sda2        8:2    0   39G  0 part
   └─ol-root 252:0    0   39G  0 lvm  /
sr0          11:0    1 1024M  0 rom
nvme1n1     259:1    0  250G  0 disk
nvme1n2     259:5    0  250G  0 disk
nvme1n3     259:6    0  250G  0 disk
nvme1n4     259:7    0  250G  0 disk
nvme1n5     259:9    0  250G  0 disk


[root@localhost ~]# cat testxx.sh
set -x
nvme id-ctrl /dev/$1 | grep cmic
nvme id-ctrl /dev/$1 | grep awupf
nvme id-ns /dev/$1 | grep nawupf
cat /sys/block/$1/queue/atomic_write_max_bytes


[root@localhost ~]# sh testxx.sh nvme1n1
+ nvme id-ctrl /dev/nvme1n1
+ grep cmic
cmic      : 0x2
+ nvme id-ctrl /dev/nvme1n1
+ grep awupf
awupf     : 31
+ nvme id-ns /dev/nvme1n1
+ grep nawupf
nawupf  : 0
+ cat /sys/block/nvme1n1/queue/atomic_write_max_bytes
4096

[root@localhost ~]# sh testxx.sh nvme1n2
+ nvme id-ctrl /dev/nvme1n2
+ grep cmic
cmic      : 0x2
+ nvme id-ctrl /dev/nvme1n2
+ grep awupf
awupf     : 15
+ nvme id-ns /dev/nvme1n2
+ grep nawupf
nawupf  : 0
+ cat /sys/block/nvme1n2/queue/atomic_write_max_bytes
4096

[root@localhost ~]# sh testxx.sh nvme1n3
+ nvme id-ctrl /dev/nvme1n3
+ grep cmic
cmic      : 0x2
+ nvme id-ctrl /dev/nvme1n3
+ grep awupf
awupf     : 7
+ nvme id-ns /dev/nvme1n3
+ grep nawupf
nawupf  : 15
+ cat /sys/block/nvme1n3/queue/atomic_write_max_bytes
8192

[root@localhost ~]# sh testxx.sh nvme1n4
+ nvme id-ctrl /dev/nvme1n4
+ grep cmic
cmic      : 0x2
+ nvme id-ctrl /dev/nvme1n4
+ grep awupf
awupf     : 7
+ nvme id-ns /dev/nvme1n4
+ grep nawupf
nawupf  : 63
+ cat /sys/block/nvme1n4/queue/atomic_write_max_bytes
32768

[root@localhost ~]# sh testxx.sh nvme1n5
+ nvme id-ctrl /dev/nvme1n5
+ grep cmic
cmic      : 0x2
+ nvme id-ctrl /dev/nvme1n5
+ grep awupf
awupf     : 7
+ nvme id-ns /dev/nvme1n5
+ grep nawupf
nawupf  : 31
+ cat /sys/block/nvme1n5/queue/atomic_write_max_bytes
16384

Does this look right?

Before, we had a single atomic_write_max_bytes value per subsystem.  
That's not the case now.




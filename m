Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27653C54FB3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jun 2025 07:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aH4tgstRFvF9EAfDxwhmFhWUYdRJtxJRJhOIVNBBSDY=; b=jsHj671AScz/aDV9yvmPC66s5B
	sOvbL2G2s9g0+NviQ27r7JdcQ+Pbo04Bh30WzCPsQBB1kJ2uQSIvsTtPqYv0ePyIsVa8tVpinsJ0+
	SrMyxI8EMo8xBW4T6Pqgvo4gpFmYwuKS1lWYSSyGmNf0AUN1/DEowHm+SeYfWXjj8TlVYo/9yakVL
	DfF7yt2DgLF46edV/NHkobOoFLph1e71UCbHjmO33+iLl7yiduimVAvuouZXKDQkZlxHE9hS/jfym
	Jra3g9xGR5TIazVSTEluKvo2AfVYLnkUEait0+aw78lu4u/SwRu46ZAreoXGkIQSYKZlrvd10OEmy
	bBaCLyVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLzxn-00000006wKW-13cW;
	Mon, 02 Jun 2025 07:52:07 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLzxk-00000006wKA-3J0U
	for linux-nvme@lists.infradead.org;
	Mon, 02 Jun 2025 07:52:06 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5525tt2T020095;
	Mon, 2 Jun 2025 07:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=aH4tgstRFvF9EAfDxwhmFhWUYdRJtxJRJhOIVNBBSDY=; b=
	sgTdB+bAKbAJ4Y5SXSZB6tpw4sIMGW+VIhFvPDFVa2JNLdvU4l5Y8vOFEbYvlXzv
	4cW5vA+Ew6gTwVZTpRPJYUCLS2ySd8y6RRtmNl4xMZ0/tIEANITgFtlSxxWM7529
	RTeYg9+1pHbkJmNNw85cEVlEL4pn5lSDD7B8KPK22Hol2QVecH54isl+DZIc9Tvl
	EFGoolJhxpv71DWTrjwShAmh4i+oCCCam3BLlUAzymDFiZUaR/tdcW2Rne0TFdft
	XdxA5zAwz4WUvywYr8yyPcZlCS+A8uahOp5iDAPY8mzgYMG7Ok6K92c/VWtP8dha
	D1BR+FTSvrItvOomqaATWw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46yr6fa2rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 07:51:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5525ruWN033797;
	Mon, 2 Jun 2025 07:51:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2087.outbound.protection.outlook.com [40.107.220.87])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr77nbmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 02 Jun 2025 07:51:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zk71rd+Dup6en3qREOBW+A5SaX5vPVOgXKB90/dD20POVenUkG52WwlESRgef3NowPmZ7ZyevuY+epz29AZ1coPxTQ/zZDcQY1ewCL4Cx3ECGxVCCTkxjmXc2hg8hyfqyUwb4ym0iy3MXKWiRHByiU670SAsPx8mYNt2WMNhvHEW019HoksE+KZ9oSV0pUB9iMYMHsFDXSBNujN0T05fskW0l8x8B1zOT00k2jzYfuCyXIbZwDnQaavvoycgBTcBnAxH1RZy063vjhRy2y2w1OciF/X6isG87CsxX1kyOBxXpxGezQ5uVJvzt2kOOlZ5Ej8u/8Y4d9ooUeMiyfChCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aH4tgstRFvF9EAfDxwhmFhWUYdRJtxJRJhOIVNBBSDY=;
 b=rx1aF/8gaQIxDYUSxbSkBe5csEGCR8VnFWLREg+vf15syAJCK6MsbsYxlWYLkIcxeI6YUBwcDCEn4y1wftNIBAbnMyZHS6TDyf572PTSsFZ6Xmg3409YuSnNrUXR3wip5n3hEE1i7klii32ThWoi9490SBHlfvjI1UnE8mvPN9xhgmHexRLlfX0iV76mTQ/6SxxTkM9tDtpoUgyTIO2Nl+wfUwuPnUH1pt0QLdqahtZ+Qmtr/J9WgmGQixPh0oYVoPT7RrUpGf7dyxsp3lbDxfcYbIjXq2gaOH+hBeu7KZK4IA1AIE5jMmA1WbsJEwInRa8S9JYLnrNmPnIRB8I9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aH4tgstRFvF9EAfDxwhmFhWUYdRJtxJRJhOIVNBBSDY=;
 b=iXmWbyY2lTNj17pVFSVy5OLLnwgZfJMMZZ7mHmaE+nDXXGwQoU3bu9MipatR+2AnUOj9E9O+0Ij8v4sHGJ9ZvL0Y1ZMgr3Y/6Dadd8WzpdncIYFg8kFgkjp4E11zK59YGG1+4J4GRFHGsDVqMMELb79MUBFba0v5QbKMFTHCjlY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7988.namprd10.prod.outlook.com (2603:10b6:610:1c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Mon, 2 Jun
 2025 07:51:53 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8746.041; Mon, 2 Jun 2025
 07:51:53 +0000
Message-ID: <c3864333-3f8d-4a06-97d2-825cc45f61a5@oracle.com>
Date: Mon, 2 Jun 2025 08:51:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report]BUG: workqueue leaked atomic, lock or RCU:
 kworker/u67:3[365] observed from v6.15-rc7
To: Christoph Hellwig <hch@lst.de>, Yi Zhang <yi.zhang@redhat.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Alan Adamson <alan.adamson@oracle.com>,
        martin.petersen@oracle.com
References: <CAHj4cs93WutyoPLFMr0JidHhRAxHC1ZDcj-RvdnX=R7OaV5ejg@mail.gmail.com>
 <20250602055258.GA22318@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250602055258.GA22318@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::25)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: 236af392-c4be-448c-f6d2-08dda1aa56fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTF4bFJLWGkvRGQ2dHhYR0VYdXdtbENncVVQZHBBSWRxTXY3OUZMR2tXaUly?=
 =?utf-8?B?SWEybE4wcTJpRjl2RUsxSkJ1WlBqK1hqRWJrWjhIODFqTEwzTk9DY1IyOWZP?=
 =?utf-8?B?Mmk0RGZIR1dLOWw1R2R3UHVISFhYU2tabnRPVkd5WlFORlpuVXZVSTIrSzdr?=
 =?utf-8?B?bmQxMTZVWm9uQm5kSlREakM4UGNuOHFVU0JsNDF3cFZjWElCNjNBMXVOcXl2?=
 =?utf-8?B?WTBoWnVmOTBiZ2haTmkzNFVGZkFiZWV3b3JxcFl4Y3ZUUWs4WE0yR2srbzlZ?=
 =?utf-8?B?RXdoSUNoMVNxZmJCeHFScE1jdFA4blhBU2ZvZVdyaFZkcXFVODdhL1FkK1ow?=
 =?utf-8?B?Tk05Z0hqOTJESHNpMitNejlabGtLSzRSdm1WaGFPaElqcnZNV1g3eGFtdEdy?=
 =?utf-8?B?bko2dXk1OCsxc3gxRnF3dkkvNnJBZFNmcXBERWpXdUo4M0w1bEN2SGdqVlp6?=
 =?utf-8?B?eWhQK2Q4b0ZBeWZXOUlVa3hQbi82MnJvWTVONWMrNU42MG1ZWG1FL2tHaEZY?=
 =?utf-8?B?c0dlb3B0a21lYnhtTDk1cjdPUVFMN1NpRDQ3NlduWm1iYjA5OW1UdUxmcERD?=
 =?utf-8?B?K2pOTG42ZVNLRWc4Qk9zSEpXZjJPeEpFVGdDUkFMV09vV08rekVTY1dUZERL?=
 =?utf-8?B?VmZrTXp0akh2OFkxdmxCOVFvKytGY0tGVmhKeFR1dUlkQUtlV203ckJSeVFD?=
 =?utf-8?B?eDVSa3FmUFB3bFJvV0w4bkFTUlhwZkNqWU9KWGRxZGdaWm44V0JFN01tVXpI?=
 =?utf-8?B?eUoyS1JCTnY2dzZxcmtSOWZiL2ZENWErMnVra0hYRk45T25JcmFwTU5HWmVK?=
 =?utf-8?B?QnU0SzN4VUgxVTBGaUc2aGhZcE9YK0VNWkZzL1UzMUUvcm80aTBiWFhuRC9T?=
 =?utf-8?B?VTFSSHRwNnh5QzhvZHgzc2J5UjdsRzlFUWJrb0YrNHVKMldzZVRlZEFGSGdT?=
 =?utf-8?B?UFVIQzZsV2pubHFBTWFGRDB1Q1pWQXE0ZzJLUmcvSCtGYkFJSk9vVW05bUFH?=
 =?utf-8?B?TnV2VUQwbHVIUjBtazY3eGNCeENJcnUwR2NpNUlndEx2cXpNSHkwbnl5d2E3?=
 =?utf-8?B?SXg5S2phWDIvZWpjYTlEU2Y3MkZmd2QwcTcveDN5QkhMZVVobk9LL3JlTGF6?=
 =?utf-8?B?M2FGNUJFOEdoNi9QMGpJK1RlVmFNTlZzTU82M2RkT2ErUzBFUW9QZlNqeUNT?=
 =?utf-8?B?Nlk3d1dIR3VaM3Fjbk1GamlyM1Znc1l6cFFLeWRmZGdoWmwyMmVOTytQVWVT?=
 =?utf-8?B?MERGVGJNMHpENEhkdjJTMWZJRGcxT1Q0alJoNlpwMElmanhleFNlSFFBWW9r?=
 =?utf-8?B?SzZzS2lhWUtYSGw1cWVOaVpLVUc2SE9XaUVQWUdVRldNU2dPbjBpNEt4eWhO?=
 =?utf-8?B?RGg0TGhTb2EwMnFFL201UTk1cSsvZFVkZVRidDdmeWw3cTduV0ViMmJQQ1lH?=
 =?utf-8?B?UFRXVWJNbS96SGtEYUdBYXhUSjlyYzFMdXpMd0Y0cVFWRGhtSkQrbjBpVFBV?=
 =?utf-8?B?cTRvRk1RaDNmTjJzaXYwVGRSeUVMQ245NEM3cE5xT0lkcnVlRHE3TENCSEFr?=
 =?utf-8?B?QkRBMFhmRXFZenNiMEV0eE1tK1R3alpFY0o1elI1a09IUlZzdE1PZENZWEtK?=
 =?utf-8?B?M2d4UXFoRnQyMDJHaDZIa3VjYXBRUE05cHdoM0xDVktaUkREQXFwWU5zaTFi?=
 =?utf-8?B?dGplNVlIOVI4bzd6eXdlTVR6U0RxVDIrRmR2UlhyRFBkeUNmMmtIOWxVWlpX?=
 =?utf-8?B?L2pBZk1xVi9YL0JqL0pkekduYzQzcUVEQk1ZZlN6NHdTT3Y3THc4VEc2Z0lK?=
 =?utf-8?B?dGhsTEtWc29NWHdBNnJEVGVkdlMxM2w4V2xwRmxiaWowc2R0TXV2MytqUjRU?=
 =?utf-8?B?cStTV252aUhwTjRHQnBDd282RXgvckp4Vi9XNlI5K3ZONGE0cGhmMVJKakU1?=
 =?utf-8?Q?0hpQ8k4XkqY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHQ4Z1g1dVRKS0R0VHJiTHNrMjlVYmx3MTF4YW10czMrMWVVeXNuWW5ldkJ1?=
 =?utf-8?B?NCszREdqN1g2bWVZZjFaTEdBYWUzcDF4S2svdm1tOVdRM003NElQSjZPc3Nm?=
 =?utf-8?B?RElLeXU2ZDhVYmVDaEl5bHlIZjEyVnluYkdsWTVpQStNaTg3M0tpTFNCQjUz?=
 =?utf-8?B?YVFHdTdUbGJJSmprV3BRaXUrUDlQUitXVFg0blM0a1pnR2dmRktUNmtKN2c5?=
 =?utf-8?B?S3pBMWlVOXZKWGg3VmQveUVLR3B0cU5XTVdYdC8yNFBqbzdRRURPcFczZEpT?=
 =?utf-8?B?UGc0NElmMWhDdHBOU1FpRlRIZUh3WEMzUTVuOHlCSjVpdGdTY0xwUi92Q2J6?=
 =?utf-8?B?bG9nNVU3T2ZBWXJ5UVdlTTB3czJpT1ZrWkt5NUwzTVhZaXhuRlYySHJrS0dC?=
 =?utf-8?B?L25UTHFVaGV2YVlXUTlPTW52NkZ3TU0wWDdSQXZzb0RqbzhKSVVhd0U1VHZn?=
 =?utf-8?B?TnFqcVJ5Z0tQUGxleXpHK21KTjdNUzM0Zk94cDBOMDhtV2JNbVlWUkZXS0I1?=
 =?utf-8?B?bEsxVy9xSVcrd21PZVU4TmJDdHQ4UFg3aHJOQnVqS0hmamxPaHVHa3VYK2JP?=
 =?utf-8?B?SERVejRuV3hvVGZxZTdSZ0dTRmNOYU5PWlpTa3BiYjZTaFI2RGpSZmlJNXdB?=
 =?utf-8?B?eDN0aWxkWXdSNkNqUWJRa2kzZlNNbmJTdHh6R2QwZ3ZWKzdSMEZaUU5MMXN0?=
 =?utf-8?B?RjBaQ2pJc2xMbWM2V0s2QjM1NVpseG9qc3owU0tMQjBVRVo1eUZ4MjY5aFds?=
 =?utf-8?B?K2t1dzgwTUZ1dGRyU1BMOUtub00vZ2l5OENhRlkxRVBybmhnYlQxSmFjOTJB?=
 =?utf-8?B?aVRHbk1Ld2YzY2pRTk9SbFIyQzZvVVNta2YwcGhaaWhzbStkck5DcDIvcXBC?=
 =?utf-8?B?MnZKYXNLOHZvSHhpemNkaU9CSU9vUThITytVdkpLRlFHTWczSGJES3d1b1E2?=
 =?utf-8?B?WjZTd0I1Qy8rbVB4Yk9nblF6aFRya0EwNmVZTmhZdzV6VFRPSHlNVUxkSUdO?=
 =?utf-8?B?RDJDVGowellCWmFYMVMrT0FEUnpvMkRuVGc1U1FKQkpmU3Nrd21ONzkyZGZx?=
 =?utf-8?B?NVI4WjBYQjhKZHc1eWFkNEJxZWkxc0RwWDhvN2x6dm9KcjlTdnZhUS9uK0Y1?=
 =?utf-8?B?aWV1NUpJMW9JZDhMellxalZrRFU5aGJTbG1BM2FGdXJMYm9qRFJ2VldsRFYv?=
 =?utf-8?B?bmFGZkZCcmVqK2J2STZxRmpubHVFVmZDaXZIMUpabEYxeENOeGRlckZxemhy?=
 =?utf-8?B?RkYrcUxGdHcvendUWWJiVVRRTExRMVlnRCtqVkRQU3U1Zm4yWGg0M2JlaUhD?=
 =?utf-8?B?eUhLOE41dnhNNWMxMk1hTkptSDN5L2gzaTR2dmx5ZW1Ca1BnemFXZlFXU1NO?=
 =?utf-8?B?eGFodWVhZFF2VUZab1JGZmZEbDMya2JWMWozanRqRjdmTnJpTVRqYzRpaFRV?=
 =?utf-8?B?ZjVpMXRVSWd0Mjl2MmY3MzFkY1JFQlNsS1grOFpXdGplaUQzejVUTTdoVGs1?=
 =?utf-8?B?a25HcWRJSGpuTjhnZ3VHYmg3RVNrMW1YU013aUxFOFBXSUttR0pNVkdpdlBJ?=
 =?utf-8?B?UXcxRXFBclROOEtMWFdIUGxFb1MrNlNuMElxT1U3YXp2c0puWmtpWDVpTS9F?=
 =?utf-8?B?N09PS1pQYlcxMWpHY1o5TFR6K0x2NWNmTTZPQlJ3THhuOHRuTjlHeWljbWVz?=
 =?utf-8?B?R2R6bGxxcUV6RURBaTdwbkd6Um5raDlNZHdodkZpYXZFVnhIa21OcVBETldQ?=
 =?utf-8?B?RjJtYW1yR0RiR1B1TUwvVlMxdS9lVnAzYUlsQ1EybGVhMGhLK3ZaV2NIQUlI?=
 =?utf-8?B?dDZ2M0l0NjV3RGFGbDFuV0ovUWxUNGFzK2p5VmpFc1kzT21WY094ckV5ZkF0?=
 =?utf-8?B?aTdReGNRYzAyZDJjeTZtVUdxV21ZUGlHVXdZQ1B1QlBiM3BDdVNMSml0V2Q3?=
 =?utf-8?B?VE01bTFMczZlR1hvcVNoR25mMDFLdmlyRFJ0d0pvWTJZaXAxT0M0SXp4Z0Uy?=
 =?utf-8?B?Z2xja0hLWW9lekZENGhhQWc5cWlGRS8wVzQvSFhaWUw4NFRGekdxWkxrZUVr?=
 =?utf-8?B?Vmp0VTR0TVIyNnZ0MEhQSE03Q2pyZFYzcE0rU1hQRlRPNjRrOVhjUDRWR3BF?=
 =?utf-8?Q?OHCCWaw7IJml0zU+Zxq/1rckt?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g6k4q2+V03rfHaDqzXritgxnQcQslFbm5/+nsx6KeupD8NPMCMeaBYiERKcpDfNrXWUswLAQshageqOdjGnd86GoWp369GzqXHIIChpGWetaPCl4zzdCN+xGQPG5AIBRvmWhkORIjG0SMANvo78cmDbjoqRBWRJCfRZMb8hYM49oVEzsTpHCnrE/FI5lBOZsRGMSIZcvh1WKMSFP9+hp2FyFfFEXrHunwNgK/2Lnkgwl4pFJTTHUl4LT+sYOZva9hQ6EtDlYyclwUAYPMvsfa3h8y97cjyKjGcJzbSl4dtsDxxcYegcWH/VsQv+X3avB+s0FPuR2q2kOt8Y8ZFsMzAz9YVEkZsMMgDpUMiQOftwSunYcY/cklwhDtfGNififeyBi/Nz7yQj1UXOz/ByI/WYwiQq2qrMFB6Pir5EugtnYZFElU6wS6Coj5G2Z87bcy/gOmohA3FK17aJQriJxuIlDGvwUn3eJqb2w1YEUFHw2MeOLRRbK+9FFtWaYUAJ8XTIeuk04VK22Zrm6M2WPcncRUYxfyXS/j9bdVSWYasapLiC5dDhkQrfsHjh8Jkl9lOayUCmIhiwipF9cT4cAuRQyNLVXLLx1zXo38AmXU3A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 236af392-c4be-448c-f6d2-08dda1aa56fe
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 07:51:53.5789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: khLi7/9Fr+0icXF25MNWK9DzF1bITVPr5PO5Ojp3ADJoMaT+zQD2yp8aOGm4RkT9KuSN1MX5zMYNGMmkrZPKIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7988
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_03,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506020066
X-Authority-Analysis: v=2.4 cv=G/4cE8k5 c=1 sm=1 tr=0 ts=683d581d b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=TFKXuh1U518-lfqSpsMA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: MjYcJCDmTOonJXKl5kijyWixO6HvBGMW
X-Proofpoint-GUID: MjYcJCDmTOonJXKl5kijyWixO6HvBGMW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA2NiBTYWx0ZWRfXwylbvFefTVHc pu4ElSUYAmRrMI74+vIL798PmhJAlUSvzG/Y+3QgbRp3HAyGoO1ZM3yGOazl1YU6wrhlZ1VeSDa D0+yyLLEtWv2clhAqSGZZtpSt5FP6ZuqFonh9IQXiCfWVCL+lkN/FQwmr2kMxEEW2voY2bCdmMT
 RyKZDSREHq5mDFxqXGqOIs/ttk9Ydv2wFi0b1DhZM64kW6GmW4InFMuQTiHZdkKSQgdNqFTgGL8 PpYa1Sy/fU8gn7nn7RF6HF1PdMTWz2uQmhuoLpTSn6tXLE5MuS9/a3F2lyXF5oZ2ZpGOQ64GRli KTzPDVII4bnOeAcztltKRC6b+icrhivM+lcHQWWrknNwA9PCijyA9U3FQMXJyi1W4EKAThGWcH1
 4qWMQu6wZQuoBBTBYVKJdsG9j5dZyh1E7h1v8PxMw2KKb9AlUASQqfy8FfHbAgKnbhzwt+Bc
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250602_005204_973793_E3ED382B 
X-CRM114-Status: GOOD (  20.96  )
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

On 02/06/2025 06:52, Christoph Hellwig wrote:

+

> On Thu, May 29, 2025 at 08:41:36PM +0800, Yi Zhang wrote:
>> Hi
>>
>> My regression test found this issue from v6.15-rc7, please help check
>> it and let me know if you need any infor/test for it, thanks.
> 
> Hi Zi,
> 
> The new code seems to be missing a queue_limits_cancel_update,
> the patch below fies it.  But what kind of devices is this?
> PCIe muti-controller subsystems aren't that command, and this
> looks like a grave bug, combined with the I/O page fault that
> looks really odd.
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f69a232a000a..4bb3c68b3451 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2388,6 +2388,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>   	 * atomic write capabilities.
>   	 */
>   	if (lim.atomic_write_hw_max > ns->ctrl->subsys->atomic_bs) {
> +		queue_limits_cancel_update(ns->disk->queue);

For that:

Reviewed-by: John Garry <john.g.garry@oracle.com>

>   		blk_mq_unfreeze_queue(ns->disk->queue, memflags);
>   		ret = -ENXIO;
>   		goto out;
> 

But for the scenario which triggers this:


[ 2313.264089] nvme nvme2: resetting controller
[ 2317.125038] nvme nvme2: D3 entry latency set to 10 seconds
[ 2317.201142] nvme nvme2: 16/0/0 default/read/poll queues
[ 2319.450561] nvme nvme2: nvme2n1: Inconsistent Atomic Write Size,
Namespace will not be added: Subsystem=4096 bytes,
Controller/Namespace=512 bytes

....

[ 2319.881675] nvme nvme3: rescanning namespaces.
[ 2320.163354] nvme nvme3: nvme3n1: Inconsistent Atomic Write Size,
Namespace will not be added: Subsystem=4096 bytes,
Controller/Namespace=32768 bytes
[ 2320.177588] BUG: workqueue leaked atomic, lock or RCU: kworker/u67:3[365]
                     preempt=0x00000000 lock=0->1 RCU=0->0
workfn=async_run_entry_fn

It is overkill to just not add the namespace? I was under the impression 
that this would be an highly unlikely scenario (of inconsistent atomic 
write sizes).




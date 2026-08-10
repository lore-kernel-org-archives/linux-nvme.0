Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2C5C5AC82
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 07:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rmtDl3Bq2d/0VWvUD+XV7hyLg7hF/VegAt/kXnLTgr4=; b=OA2lBDEChPxikyNP2JBZE4rt7H
	OYgH14kAgGWKd9LWZemPEHC7ZNpM36AXxWB5eBLayFGCz3WJqEc9tgYJ0HelSJT//seMd4X8pHv1r
	Jei2xXAtiakmuPcmVn1fbzfpNk+Omo2mnbWvUvbar69lsPtQO0CUypfAzArE1xkGyYIQfqwYCf0zg
	iKO2GsJaWa3ja0AycCHYWOLuG4l9MzjqGKLEAt3Qic7ppP8YiBCLQss5v6M4EfSEz2yoIYDnUp1ad
	I6h/oThlfPahW3L8sLjFc+ftldzOvLFyCMicZkxievz4sSzirhsERKhaAlKsMytCWmshkANA6lgmy
	ktywhY3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtKmh-0000000BDnW-11oQ;
	Mon, 10 Aug 2026 07:50:59 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtKmc-0000000BDmh-1xk4
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 07:50:57 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67A1fI222911320;
	Mon, 10 Aug 2026 07:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rmtDl3Bq2d/0VWvUD+XV7hyLg7hF/VegAt/kXnLTgr4=; b=
	cYtL1lURv5CN5FWERcA+ti5If7SDs11+98aX486Gq1NmeZgjtlT8ab6h6ZiyJB6F
	H+OszTxfs7MidtWXKQMovOfZH2Bm1Eyv2QfLo2JrquQ1sEtOGBNni4kvxLCA3iO2
	aA7/FYEGWTgPlFIz5Xp0Okg8TBvuos7mMhdPP5hzFsAG+rOV/ZYdO9lxLEgJSgQp
	5Qy1m+dMN9A0byAd4bKjt8wETPju6EUR1JDZwzqKXpIpgHyDAk5TgJ7xtm7HM4FG
	bk7PIw6oIxemMXPSp1pUdTzfsUEtq+0VsU6lvowuBLvZNecDDj43GHUbLK9vVq2p
	tcUMyEDBY2aZiNk7KpSJYA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvk6a1yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 07:50:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67A7o7dd001042;
	Mon, 10 Aug 2026 07:50:38 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwc5j5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 10 Aug 2026 07:50:38 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bAMoSNl0H/kKL4gEgoWISpiKJGsyUWXFcKxrOFcdxycNYDCQz9Y79rIF3pOii5BtU3zncTiTVdP2Z6aFzZhIn+UFdSAt8okrrfzbI4Tgks27S4rnODh5yrA/FJgEs9YRIoPSQLx+OxnLP/Pf69XZH20LbypkSa52VZ1F+vfkQZoGCl7GLnOq6bw2xXpmt0P+C3/D9dUB8tfwBumg9YB/Wpxwhkyx/5xzI4+MMCax3bM/wGkvcUZunnrey5Pt9f+m6RcMZoeMx1kgiE7KvucjFhYaNdXAH44e65Vho1S2PpL39J0316I7MOlfjHlZgGyggncVws3ycSOktBD8FEOEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmtDl3Bq2d/0VWvUD+XV7hyLg7hF/VegAt/kXnLTgr4=;
 b=rqFIJlhs2GLmr0ZoWB9yQTMq1JsZJ+29xpFDKFbDmOYQilFShnoibfw5lbjxgSY5eZJwE/qIZSf2a+rE/TZR/1wnzaUIgU9O1uD8qI4bicGIaQNPFDkC/lWmCGNJeCLwVZgBhUALP+yk+cI0zwexOSuJjBOqmANN83jmmbPOPD30VslzX2BDaeL7vjVaLb1EnFzLB2V12rHN8yVx8amhA6j19bDzv2swysNnRtXB/ckbEKnsVIN2EDtLtnvXtMRYL9nB9mP5fOrX4cNp5OIxjet0wqXfm8FwjCpf8FtHFAS+nnCTJMQOetz0iicdKrSC1lEO5snJwxRvQWNiTd2LYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmtDl3Bq2d/0VWvUD+XV7hyLg7hF/VegAt/kXnLTgr4=;
 b=ktbOBw6u/ZAfYljwRPOXsdvQLs82aL7Kb5gjJ7vJOYF02CR3IxV+bMxL2ETAH/idHTUK/7WU2D52UCm22SrikR3lQOzJDKsaLB5kJltnajIBLB8r/BMrYvzsFMjbyVH9Dyjk6dpAAJ7HN/YICifx+X2+s+mnY/VXk8bBiEiJ2ko=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 DM4PR10MB6862.namprd10.prod.outlook.com (2603:10b6:8:105::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.25; Mon, 10 Aug 2026 07:50:16 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 07:50:16 +0000
Message-ID: <35c99788-ad97-420d-b16d-5ba8f6a28f82@oracle.com>
Date: Mon, 10 Aug 2026 08:50:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] nvme-multipath: introduce latency I/O policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        gjoyce@linux.ibm.com
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260809100825.2014133-1-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0291.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::8) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|DM4PR10MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f75f7bb-1825-438c-dc9d-08def6b40455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: YAAJpBaP26mnH4off2NkgDmbuUW+KJyp55acmpMoOcZ52KbLYCI43glBnrJlDKy/KJwDruVKQyV8QS+BYnocdiHQ5PGwJjKANs4KjldHfvKSFUT8/2hJFGZlDkJJPdTRP/SxScLQRFAS0Vl/iDeQ3YIZjk+773KX+/dbEbwkLsn5upULyz+uw38yEu8UDjWx0UviUHtDWqh/Jh8HlgTzJUt+pVGES69hM64MfVEM1GZIaWOC4U5d/Hqk+UXll2HosrAIzKJriGz1ahDaAVhe1BL/PLZ+kW1nQURP851PBqkU5Gh2TLx+T79YSQhUC+wUdsBKkkUcPK3YjIOPrvjFRb9M2rM2XqJhIIHEk64igKVh8JWh4tJF/P8w6oKzUYfhAVVBiu5ScuhJZdXmKUoZww4yn4kdGHva2tEAG/fzlGBOnHZ46hOCREuooNy+YleOPqKW1ZQiPBQ05k5OA9ZK6QTsq8uFw1aebvUPRdjjkILCH05UCegUfi/ZdFVqX25x/KhEuoLNk+rgUHdbho/os265Ja/AzsB0dHkFfSaT5Fcm0ORQy2WSIHkdxNzh0r7qMf7Hiw4NRM9lHJchP+7n0VZVtlfmiD39syjl0/xhPgqea+7JbSSmoBkVr7viGG5VI9TUZo6XnbwaVGjnYdvSPH/gDrbpTt2WGJxfFaP3lvY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODZWNTVGSEdVa0dGN1ZxSzU5dm94VDFmYmxYM1RsNHlGUjczTkJxc2ZlT1pJ?=
 =?utf-8?B?WmVMQWVpRVJkZGpWWEY4U2F1VEJzNnYxZURyekJ6RVJsYWt2M0I1Y3VuVkUw?=
 =?utf-8?B?RnpWa2ROM1gyeDFSY0wrdkMxU2xVSm5OcU9xdDk0enprRDU5dDJhWDJhUzEx?=
 =?utf-8?B?Rmp2ZkJsN3g0bDZXK2EycEF0K3dDZURLNkZZVkY0MWFVcjFrUExiVkNmc0Z2?=
 =?utf-8?B?Ry9NRlVqaXI2bUNDbHQwR3BiZjdjMUdsY0NGUE8vaE9BaUczOFd6dXlXS2dq?=
 =?utf-8?B?eUJxSVZVYmc5RkFPVjZiVEtoTEZrRHowRTJwVXBmYWdMZmY4cVZVNnd0bGxK?=
 =?utf-8?B?SGNSa2dxejNtclRvQm5JOU5FbnJyMnk2UkpNSkpTTHloOUFBaEdGUWZnRC9m?=
 =?utf-8?B?VHNYZ09qRGR1QXJxQXRGY0E0NHlSNzEwOVljbGQ4SnlTU0lKSHg1MU1WUmZn?=
 =?utf-8?B?alZ2WVNIZEFNcUVEMnIzVXl4K04xUWViL0lpVjFXQWlyUDlaRzFxamtQWjFp?=
 =?utf-8?B?cHNTeWI3ZXNHdXVqekRvYW83M3Fwam0vV1dZK2ViV1drMHZXYnpNQUJnOGd6?=
 =?utf-8?B?Q1VNa2JOUTdZVzlDLzJLOTk2Z2g2ODg5MGtwUEp3MHNaTTRTSktNK1Foams1?=
 =?utf-8?B?L0lLemFBUVd0dmViZWVtM2tYZjhDdi94dnlxTURlT0VEa0R1bW0zNlJ5Q1Ny?=
 =?utf-8?B?WXFKV0pabXdqcHM3YU9YVkZJRmdhWkh6UTNOd0V2Qjg1OUYzQVl6QVI2alEz?=
 =?utf-8?B?YVZBZW1OOE8xVWJjN0x5Wi95bkJGaG14SFQzWUJEclZhUlcrNkNVYURKRCtX?=
 =?utf-8?B?dURMWHRUVHpNM1JQWmwxeTlpU2lFTXFyeVBRYmVNbzYzREQ0endOeHV1OXIv?=
 =?utf-8?B?ZEtKSFF1S1FXUVJFVm1iaWFUYnlteSt5UGV4RE1tSFNEeFYxalBCdVVvVWdK?=
 =?utf-8?B?cXY0dE0xbHBNOHV1bkdKRFNYSU9Sd3lWUW1RRkJmUTdmNEFzRGZubnh6dDl5?=
 =?utf-8?B?aWNpWUFLNS9xdy90L0llOXlQWW93SHlYR20wUmhIUXVTc1piM2YrZ2ZqMU5i?=
 =?utf-8?B?SllEVHNBaGVydnVZVHp2Z0l0aTdHV2NWMTE3eElTQUpndDFrbDN0aWhIb3Vj?=
 =?utf-8?B?NGd4THo2ejhJMXlNNG85ZE9vNXIyS2F5ZFRQb0ZpZ3NLZCswTGw5eDlDRnc2?=
 =?utf-8?B?TFgwQ2xyU1V5Z2NnaWlUUFkxWDlQVFZpWDZaNlE1M3Zldmk1YXkxV2VjbTJu?=
 =?utf-8?B?S2RON1FSV25GZjB6emRaajdKSDhEa2V6Y0E4L1pEZllrVkY0VmcrRmhjUndR?=
 =?utf-8?B?TnA1dUE5bGp0R1N0clRDSEk5aHlMVnR0Y1dOTHJ1OTJpYmJkWFpuVytPZlFs?=
 =?utf-8?B?Y0Q2THlXS3FVTnk0ZG41azRTTVBFTlVzWUhuVWE3c3NlbTlFbDVYMU9uTy9N?=
 =?utf-8?B?UEVpS0pCc29BRllwdHhENzFDYXY2YjI3eWYwM1JYQnZmQVJqL2JmdVk0Qk9C?=
 =?utf-8?B?RFRhRG9WdXpQTGYyWmkvSE1peU1sOVhmZEIxMmZJelYzcSt5dGFHKzF6cFpE?=
 =?utf-8?B?TTEyNGZ2TG9VWUZzNlpvVU9pZ3NiQlBma093cHo2VzJGKzh4aE1tYkdGRHNu?=
 =?utf-8?B?b05TZGpDdjhLZzh0ZUc1MzhnMG5sTmRjT25RcDhMRXlWaWlZbFpkZHp0bU1M?=
 =?utf-8?B?STNhYkV5U1V1cVVlWHJGdlNjQWo3bFdTaDZoc2UwNXBKcUdGZUs4Z1dGd2NH?=
 =?utf-8?B?OGh4RVdXUkM3YUNOKzBEa2lPTVBmTXpCYk5lLzhDcUl6dWl5QnBycmVGQ0hx?=
 =?utf-8?B?NHlFV282djczcmFHTXAyMU1BeDMvSDJIejk1SFRNcXpwTHFybTRnNjVCcjI3?=
 =?utf-8?B?MTZ3cGVhN2ZTWlo3OU5NV3pjRy8ycWFoaW9XdmRSTVo3WHhSWjdBeHZ4Qjhx?=
 =?utf-8?B?dDZzbXdZNmt4NjQ0UHU1NmQrN1dRTHZOUWtkS2c0VXcxNjRmQ1BYeldhOE9x?=
 =?utf-8?B?TnpVQy93bFNFV25XcWxLRUZ2US9PbHhtcmpnNTRCV3VKeWZQd3N1UitqS202?=
 =?utf-8?B?RHYrOXZVczEydFVXVzdyS29HVmFiaXlKd3ZFSTZSM1FIOWN6K3lSdEpZN0ZG?=
 =?utf-8?B?MjNLQjVwUU9XNlRZWXZwVllCK0pBNGtBeE0rQW1kcDdSWmlkN0N1UHdyc0Nm?=
 =?utf-8?B?NDh5WStPSGJjR09YVU5kQWx2akUvOGlaWDdyaTEvWWdybTloR2RVUHE0bWZk?=
 =?utf-8?B?WHZJeWtrSU1kR2t2RFZXaERvSnkxQVhTWndBK2lFUVYzS3VVUDhDNm5SZ3Bx?=
 =?utf-8?B?c0dnL1NIUzZCOGRiL2NJd3JsSjdCSEpsQ3lQeXpVcExrMUpIM3k0Zz09?=
X-Exchange-RoutingPolicyChecked: OTlV2tBDJjMQ/tbHA7/Yd/Lx5Sw9JQ4CYLiEK6nrMvwpFSHZcmYouxLV5K1bh77v8UnqIxyJFsgEqm2i5ysM7eEWRSOUcAMEV7XtH0K5Dk37LMOO8rmKttl9IYIaqH3LUgWjvPxGY12/pD49j4qWyPz6DGE7FIMvyP+TxSKAMMpOtAGoaIZ+RQVwGxAOv6+T7cJIic/UBvscEHuXR/z/JEiyW49LwuKdEFttWgsiqEpPbDllzq754zZhfIuJPFHLtr2KedKP6KhUP3yhtCpNPRsOGGnawMFMtSOdLKmhTs5YQBzQf6TSx++LkDn9qJZ9Dut9PiprjSEuol62SUxvzA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bAnyesetemZ9bMFRWjv7hiSsfHYARLAglITmUmxyHd9xfjudGBB36R5BpTaBr3+eEjLDXfyDQAO5SdS6ETvF8BZFVoZmuBKUFt9JsN+DCfm96kLePnrydEGklItgWYycMSlE5VEtJTnk3uZafjjfYlw7kS2hqssgNvoqIWdHVHmyc/eAXSfRHomZqqT+yap3wQMfXiR36jxM8VZ/wf6lwq7UD5cTXpVJGmEmp31vOa82MxSiBHHwFQSarOcgrJgM6hpY/UjVvFIYmakycMpY88doxjE/R2ndwc0GGG8yAzCq1l+rgluYIoSPfJ8t1MsOwjX7kXM7RjWA2atBfGBeg9sSOumPxN/PQ9Vr7RUVROHymtzCAfL8pXa6q0FRfCDDdJG8E2uP0Lxioo0JihDg+pBgabCdetJQcFeUQMTExSV1kxR7B0QPN/7iKgmEfXT8kjNxej+XaA2casuf9sJJNDdU1loFdoKRWjtOu9sfqdbuCXonZtTbf1FQpESYtcstyFYnPBT/R5Vmom4H9Cl0jKvln1n44C6wZKsqeFfDeTUT4UG/x3RnYaNyZu3zXDh8Wj9Df2kP10JUaC3VBYGNYkN8y/cIRzrw4C7BLwNrlTc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f75f7bb-1825-438c-dc9d-08def6b40455
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 07:50:16.5033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4cCwCiLNgEczLsjbHFt/q4hb4SrOITgDro5QXgaT+RdlgOIaAdT9ka9ibyiVAt/D/a3r6Vrdoq3/PUi9ciNVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6862
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_01,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=979 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608100066
X-Authority-Analysis: v=2.4 cv=GaknWwXL c=1 sm=1 tr=0 ts=6a7982cf cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=b8hPNFRl189vROqXPDAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: _MDKLAsJYRwGNN5dvrKJQ4ySvv1jovz-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDA2NiBTYWx0ZWRfX9LhTFMg6qRbc
 U9qQQFDcws54QeZSOrqDeiz4YEHIBMTBUA7H2/xrWRDJCQ+ARDhlU/VS39Jq1b2v2adl3SmN+Uh
 H8FMcQ5GIMIefArn7I1/J649a4/V+LRHYslEfQa7phNIFSoT3JKD
X-Proofpoint-GUID: _MDKLAsJYRwGNN5dvrKJQ4ySvv1jovz-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDA2NiBTYWx0ZWRfX0zr7sfPUUA3C
 oz1Lm1fuwNwz+iQSVjaTMSt+gOFX4IHu3kbwf0zkyEtO4MX45n3nsmjL6xVwTGTfpaP6LqBI8uQ
 h3O6PXeWv6RvDHfBvOYYi8LpCi4s8ExwdPZGXEGulllzqyx+xs+ETbYuv5Kte16An0EvR6rV2NX
 LuBgFQK+7/JTBLeeRlduA3MAacHsAFx1REf9TQbzCwvFPuV9Wncn1POyNlqQcuO3hatHIINYBCh
 N5u3UT54JhUKxvQz8Akdtq9/Ft2xB5RPpy/6eUDccLT19XOO1nEm1i6xgvz7pDI/ORs6Citq1RH
 nCS9s1ut9cNmuW4fgbPnODdROResXRld70czA42bk4Kada1vsbmZMjLCl7paI8tZzVBTzdwhEQB
 xaTuvmRFdNgUfKz7ElEbHTmiTWJYf5CeSi9EsXZkLfCktQhnF99ll+iJ9TfwCLkwDuKEr3xe+M8
 W4a2FXlW4NxzH0ZDhNA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_005054_829521_BEBAF508 
X-CRM114-Status: UNSURE (   8.51  )
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

This does not apply (cleanly) to the nvme-7.3 branch. It applies to 
v7.2-rc7. I would think that it should apply to the nvme-7.3 branch. Or 
am I missing something?


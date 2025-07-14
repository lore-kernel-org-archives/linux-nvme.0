Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECA1C83F21
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 15:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NfwcQlh6LNKatOLAh2wzTSevCMRWzJckOeThZCdBm0o=; b=m09mCy6Fn2CjXtmCzV7JrFw9gU
	qZL0zZAq1xCact0mNtOVmftpBBpDaYSA51oTcwJUoRzdleN+wg1cMB+74wpk7bH2R5J+KIKomMR0b
	66UzXyel4076U0F2pQZDiCYYklKG8F8afL3SvEdPJPuFOElWbJvlI5nqaP6NKj0KtXOUoG5m0sloJ
	QXuAOotNtViUPr3DwoY1fP3ZRPVBWmAgZCz5REm1HblPV4EkPc4sE1iutpmgFU0MBtqEAI51Catdc
	IfixyBeEtPgCfVlB0JkDdcm1D+AEKnG0+5V2b5RyiQNiRMo4wQgR+w6GDD6PrZZ+wl62r1Pd2N2W2
	KeBiVR6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubLJK-00000002izO-1HS2;
	Mon, 14 Jul 2025 15:41:46 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubKjr-00000002YbQ-0ZYV
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 15:05:08 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z5Dn031151;
	Mon, 14 Jul 2025 15:04:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=NfwcQlh6LNKatOLAh2wzTSevCMRWzJckOeThZCdBm0o=; b=
	oDChrGwVtqbY0pDmpbNQdRygB2AOwvnO5GoKKC8PqNOywEGQgwlnCpMt+bFErmRy
	Rz1DoRIEO/5xD7zezm7G1KVlazQpv18duiXQgBfsrilcRrMWfHEi5L7tH2ROyyp3
	gYpTUtiC4YC2b1h0jsKtM5v0rLkfb9ggxcHtmO4xga1qJ29q23A2YZQpRkwLWv4G
	tTTZtpjLlpfVJqD35fshk3/kqG2gMedxsNNZ3JYHRxY3J//JyJrx8Twuzx3pf7Pn
	sLU22BAyPwGxVneRxRIr6f42ny0SemeE1Nq5zemx9RQ8UvuV8dusmCIV0Ui+/zUX
	ocZuj6lOhCMSiEGnLIX1Vg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ujr0vctc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:04:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56EDn1KB013024;
	Mon, 14 Jul 2025 15:04:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5850af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 15:04:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YTjwA3m0OW/Dl1wxZUeTTzjcebMY6zo0UBcT1GmUC5opOIAzuSHnAE0ROhE/2nuXOdx1n9CVIbvE0xtr5nhDoG+xQZ3XwQvLfoG+AbaegQDIgizmu8zcfeH8r4TZrRcXx0ZSOkZrghfNUonrVj9l/d2WUE3wrSIr1r8/JbE6Gzp00XvfvI4xle0qdOooAjAP9eezshYnrsDJ9RCYWZ5Q+l5F5wKcS12Uz4eicf3yp738GDc72aHUXOfoTkRlbpi4YeOW+grM3Qz0s4cDkyCSexSY4tPwEwOlllxQqWGSIZq98UIqFWqXeDMZqJWVU17fs7oGx3MpJ7gT8NX509FMRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfwcQlh6LNKatOLAh2wzTSevCMRWzJckOeThZCdBm0o=;
 b=y2VhIYNP7bDcHzYI7OOjYZ06fO1PXjxRg6+Bb+2oXKrHfOfDnB7dc8qwPAYAu5zSyWYyfiwSxwLXps7BhHsFYdSlKEKrYyamZIquPf2r0YL06V9VOPY1J2ODPcwi8qwRn40TQYxe6RyXczeSsXETWQHUCrKFH+GLcHvn1dpHBumN09ySzB74RkjOwtLi6shQqza+0x6Iup6BYf+q9UhhuiN51CA67QrdKa8cMeI5szqcXF0nq06IHrlrgR+PqJhEh/fPl5I5IatXBATPiRq8Z2bt9wRAFffcApLwdD8kBmWlvGqYwenOK+vXJ9mO/ZUmmBDKAzWfQb1Q0FgrS9dt6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfwcQlh6LNKatOLAh2wzTSevCMRWzJckOeThZCdBm0o=;
 b=vHYO3h3TEBwIe69/fYLUxgfTGC7HC/YVblkiutan7mgH8D3OJV6ujuqhNHGqahpfxSRy2CLqRcyzLl7Yhzr9yD03CG7OPrYKjBcetxqtMmoxioIc+UTxriF37lRVZHJ6xPO6AWugGBXdJX5ho2q7CMncTEHpaEwktL3SyIrBbGw=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 15:04:51 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 15:04:51 +0000
Message-ID: <e3374411-946c-4134-8794-68105b986e72@oracle.com>
Date: Mon, 14 Jul 2025 16:04:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: revert the cross-controller atomic write size
 validation
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>
Cc: Alan Adamson <alan.adamson@oracle.com>, yi.zhang@redhat.com,
        linux-nvme@lists.infradead.org
References: <20250714144406.1692041-1-hch@lst.de>
 <20250714144406.1692041-2-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250714144406.1692041-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P193CA0013.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:21e::18) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: 9837111d-9ce4-41c2-2f08-08ddc2e7c88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHdyTjJHRC9JMGV5eUpKMFB6d1lLNDhiM0hFRW15ZkFXbHFrNlFjUlZ0ZGYx?=
 =?utf-8?B?bnJOVWlGMnU3SVlTZ08vWVRJcTBXM0pmMGM5ZlhWdC95S2pzaUg0cFRDZ3kv?=
 =?utf-8?B?WmVoaytuUjdrMzQwbjZXVlNudzFUeWQyaXVORWg2cEl1MjQyZGJMM3NYWXUy?=
 =?utf-8?B?TFlyZkFyM04ySXVtOHZiRXJZbWd3RFZTa1c5ZHR2MFB3MHdSeUd4YUxDUnJ6?=
 =?utf-8?B?MUg1Zng4Q29IWWU5RnRQTVo0QXNFOGUxcG1xeEkxK3lZMEczQS93b2Q2QXNq?=
 =?utf-8?B?N0hMeEJWVDVMMUx3THI5ZnRYVmVuekRlemM4Ym1DVGRubFVwNVJybDNqMFpk?=
 =?utf-8?B?Y3dnYzBZNlBTT01sR2E4dCtleHVUcFVzZ2pkQ0VHRHJGLzJJZjZpK0Qwd1ZO?=
 =?utf-8?B?WVhMS0gyeWFTLytoaWJHQjFKczdPZXBxa0xydzY3V09SaFNyeUNKVDNVQnl4?=
 =?utf-8?B?cUIwc2ZjbUt6clZDZjZ0WlltVDR3K1YxdndsK3lJZ0dSd2pucVhQY2wrcmdX?=
 =?utf-8?B?bFdhblJ3cUFkSTlnL09WMkZ2dTFGVU9KODd4LzZ1U21hZ3ZWODhobjliblhz?=
 =?utf-8?B?WXg3eW9RZU0wYW1VVVJmYkxkT3k4YlQ0S29rdSt2b00yNWYrWEwyNjBqbDY3?=
 =?utf-8?B?dHlvNDNKOGdDV3lsWkhLWWljRGF4SVhvQ0VweEl0OWl0Q28yT2VocXFUbVIx?=
 =?utf-8?B?QlFqTHlyK0pUUmhIT3BlMk5uc3VJWEFBUTZORkhBOVZ1dkdlbDlVamtreWpZ?=
 =?utf-8?B?SHhBTEl0NDlEcm9pL0RhZFpweEpSMGpTeWgrQjF4Um5JcTUweHBCSnZDdVdH?=
 =?utf-8?B?UTc0Rlo3TEppdk9ycVFXVllNVUQ5ZjYxMnNNMDlzNVliWGoyZFpOR0tDUDgv?=
 =?utf-8?B?RzJuclRMeXl5TWhSMWVreFV3OStKQTdxRjZJenRjSEd0N3hTV1Y4SXptMVFv?=
 =?utf-8?B?NkRCR0pGQk4vakVDYjkrQ014UHNSa1gvN1pxUERIQTMvVE1EMUw1VmRQNms2?=
 =?utf-8?B?QVV5bjZNV0lRKzVtUEZoczdJZDhTYkFzNXdnZ1BGZEo5NTZVNWN3OFJzV3BS?=
 =?utf-8?B?eFJCNGhMYjhEVWp3QmlPdjVwaWVzOWxCT1FoV3MvWW9DY2dCVm15Z3RtUGVV?=
 =?utf-8?B?MnlMUU9FckNNNVRHNWt6RjViLzhyY1ptMUJEL1BHUE5LVUdUQ29jdXdPYWRo?=
 =?utf-8?B?bCtUdE1qVDRnSW5UbldBSitWUGtpN1B6WmV1Y29ycWpoYUwvTmF1TmdJV2Fn?=
 =?utf-8?B?aE03VVVudnJlSkhkaFFMQzJNZWVmVkRZV3FYdnUrYkJvWnNROW43ckkwdDhM?=
 =?utf-8?B?dlFMSzlZLzZ5RDAvL1k4cUtHTTBkUWRhMTZKYmVlZUNzN2ZEN25mS1ROSG9o?=
 =?utf-8?B?M0x0dkVucklhNzdXWjFmMnluMWFCSmVJN2lvQVFWK1VVQXpaSDhnZ2dYTS9u?=
 =?utf-8?B?Q2NtRVIwRndUOFJnRk4zdGlJdXBpVG5zUjA1bzBMdHhsRWJWWlB0aE4xTWh5?=
 =?utf-8?B?R1RlVUNYL2FXSFBKMnVXeE1qVVA0Snp3MXdqRWtGbGpjQWdRZ2lLeGRuSDQ4?=
 =?utf-8?B?MVE5QXhvRVZ4Z3MzV0VvdloyMHdqMS85aHgyazEzSy9lQm4vMFlxQTY1aVRC?=
 =?utf-8?B?bERWQ0gzL0lkdTljeGkzSVZTdDM0WDZyQm9JZVd4MDA3bDdLdVFDRFNzMFFG?=
 =?utf-8?B?bUYrVHhhMFYrWjgxdjRYQmhLTjJBMndyZEJGRmE3Wms3QUlMdnB1cGg0bTNh?=
 =?utf-8?B?N2pXdWNtQmxzWjhKTlNhTzlaQ29sMGlGMzFzdDZsREgyNUxIMXNIMWxWVnl3?=
 =?utf-8?B?MnhZS3lBYktPYms0SG14MFh0WVlHTWEwZzl3eVZodG1KUVp6bXVXWnZtZk9T?=
 =?utf-8?B?QngvZHJ1blJqcVVCZkpDWVlSZkdLdGN6Yk1BQXh6V3I4S0E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHBIOFJxc0hHWnhPNm5rZEhXb0FTSk9ydnBaVGlDMUs5SldqRFdyUGpya3J4?=
 =?utf-8?B?ZTBHQ24xM3NIbTRiNUtJVERmL21LRW5nOEVSSzVPNDBUU1JreWhlNDhCRW9C?=
 =?utf-8?B?b1NXVDQxNW8zcE4wSWJBcHhib1d5cW9tTGRCN3JnUE44QTUzU1JxeWNWd3lh?=
 =?utf-8?B?TDcyei9SVnNjbkNuNUIwL1BoN1V6MTd1Y2tvTXBIVUszaXJiSjFMVDRKY0ZU?=
 =?utf-8?B?OWg4M09qNWt2ZWYxNE14NU5vN1hnYUJ2Q1ZFd3Mvb0k5eTJQdGJscFgxSjRS?=
 =?utf-8?B?ZXFyT2U4VitFODdqWEVpNmhyc3BwMXg4cWxtMFd0TDlaeXpFaU9LQUhNOHNB?=
 =?utf-8?B?TmdKLy9UVjNRbDk4TXh5MnNaYTAvV25hMjd0TnBaMmEzMURZUHlHYzF6QTVq?=
 =?utf-8?B?OUFualdzTG1CU2p0SmhtL2hMVThnY3VYdE04Wk1TUUtQa1VRNEtNTkc3Z3hN?=
 =?utf-8?B?Z0lqNlJZYWlBWFJ0eWorWmJRSERwS1EvWWtYY3VyUEJJajlROTNIV2l6a2p5?=
 =?utf-8?B?RWN1RDhhenFlU0ZBamt1dW9haUgvcTlhSDlHMmFndWdyL1o3N0I0QXJRODVz?=
 =?utf-8?B?OFFwdTJ5bjI0LzFQeUg3eDNnMlIvTFcrSTZTVUFHWXY1TUhsZnZ2YXBwbG50?=
 =?utf-8?B?YkhtSGNvOXBqLzhDTzNRYlM5QjNnNVB5ZENJL3lwelc2Y3JUSjBtWDUyRnBB?=
 =?utf-8?B?cTJ2Ynpoak5jZ0FybkIzQ3h5QXhBVXQyZlZHU0RjbzVPSzVNYm5oN3pjNDFH?=
 =?utf-8?B?UjFjRHpWL1pZZmV4bThpVFZSOWZsN1RRemFnSnVyL05WbnM1Z3hPcHk0bTRJ?=
 =?utf-8?B?U0d6M1QxVERCT1V4TURXNlRsTU0yeWVudXVsTlFoR0lONjcvT3dmSHB6d3BI?=
 =?utf-8?B?Q2dtKzRraC8raXV4dGR6RXh2Nm8wM2xWY0VZenl3eFVZQitpZG5ETjg0KzRC?=
 =?utf-8?B?VjN2T3E4VURsSWY0eXpWeXEzNTQxV3RxUm1yeWJEZThCM2RSSkNOekV0NlBO?=
 =?utf-8?B?RDNiODltejF3R0JMM0tjcU1CNDhBVlhlQVlsb3FUczZsUmdMWEVuU01EZjVD?=
 =?utf-8?B?Zm84cWpyM0xrTUh3UTg3T2Z0dElOTGVxYWdGVlFCYVdsM1diL29yQmlacE1m?=
 =?utf-8?B?UUh0Tmx0QUpUWmFpeWxZM0RrNjhaRWlvT09sZmhobnVZVXJwVTJTYVN3NG96?=
 =?utf-8?B?cERkQ3g3aFhDc1kwMzNOTlN1dk1ZcVBqRk1ERm94WVNKU1QzUTJmSnF6eTFQ?=
 =?utf-8?B?dDhUeHFReVpQS2QyYU0yQmRtM24rOURQNEpjUWh4Qkl0RDR5SVV4S3VqellS?=
 =?utf-8?B?cVJyRGVGWVVpTk1DT3M3Y0M4OWRaeVpHRnAxajZxUW84MEc4Y215VW9GOVFw?=
 =?utf-8?B?cFdDaTVxVlBmUmVJWmdYazk5YUVDeHBiTWp1Z016Z3FqcXM0aDdGTzJqemU0?=
 =?utf-8?B?M1ZaWDBXblRxMVA3dExZaVYxdDhFNzk2NSs1UjA2YlBDVGNtSzJlaFFpamVH?=
 =?utf-8?B?cVBuQzlwem9rcStXaTdyS0VPVUJCeFE4b0FiU1RkemNOMFR0Y0RKZ0ZJc3I0?=
 =?utf-8?B?NjRZc0VPN1MxQWt2OERMMkhOZDN6ZnpIZmZ4L3oxVElFTUEwVzdDaUlqMm1w?=
 =?utf-8?B?M3F5NjUrMHVOTWdGald6aFAzdG9JZDRZcHcvMm93RHpMcUZDRjdvZlVDRlAz?=
 =?utf-8?B?Vk9sNHhkWlVveDRQOHd5VE1oaGhKcXNzdGhTUjE1Nkl3Zk9VSjVROUtPSkxk?=
 =?utf-8?B?cCt0Nnh5dlgvSkNBT2pRblNRa1M2QS8xd3VqbTlHUUFpSUhSWXVMbFhTdnQ1?=
 =?utf-8?B?YUtkbHVsSjdWcmxuUVhFdFBxNXN2RWlvdDI5QjhMK1RkdER6eG1XNVBSSGkw?=
 =?utf-8?B?WlllZXVub20rT1IrYjA5Nkh4d0lKUFZQZVF0OW5vS3phL3dLLzNKVnJKb2F3?=
 =?utf-8?B?OVBGQVN2Vks5cTcwTUxicDVNWmhXRUR0dmRtQ1JFZzY3UHJuZ1dQZk9iaW05?=
 =?utf-8?B?UkYxL1lhOUNhbjd1OWduUXRUZUlobFVqRGZNZWNBSG9ZbktZUlgrYzJ1emd1?=
 =?utf-8?B?T0YxY0dSbVFHOStIT1lxa3RkWGRmT2dvV0JlSUltSjU1QzA4Wk5SN0dYWUR0?=
 =?utf-8?Q?RdjeiqcGIFLeWfBlzqHTk9cjD?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8bYjJ1XRWOhDFVXVOZVry5bxhTXO8WMr6Md2WSgi80cqivRM3DlAAp3Sg/24zk3A1yRZvdlM6DG/+RYE316IPDBX2ZzO/1EMVLrD5wE3i+n72WJ8xnTe3avNBvpVoGackrP3O8kpjE/LCNYH85EqC2T9bHcsjuV+OfCZhxmlD8mX7bqRtUPfMoUCTCZTIExA1DXkV1/yJfjVbN9Hu/seqvhLg29mzyHpdm1L+Exg+mDYIdPzcoT+zHagy/CgInyXTCZTdqrVMJj4sCEDNQ/AmHFELn/0UFhwxWBQ9wZWIlDveuhWOAHQqhcxT3Zn69wL66qWQ2tKOQ0LUc/pXgiIkT+gFSpevDzFCQz8b1sg+bb4p6apfGy/VzpC+cupmTVMYg3LW/Fjv8GsXJaZNZb30JrR3vo4xhW/MTFAONXLCzg2enw81Z1G7VfSFqa5ZeT45ENOux19WOS6jITjXEzBWw1gRyly7EhIC6y1UmQAWkVHitn+v3wAKTsBwVRZfVrq9a5i1PBnoldDX1YnPV7Yd5INcdjOgEyxhn507BOOfC2YeLXBfTGkPjMZ44nT2LvNpVR0EqVNBKx2NY3m3L2MkWqU/9+aZtTI+YNIj1sTVkw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9837111d-9ce4-41c2-2f08-08ddc2e7c88d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 15:04:51.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HbYzbW1pFqqAlRLS315KtyH8laJ3rhr8e+VLvv1LplnuCUTfX4tmbtfYEr1AniVx4CHM0KtjNKyYSymjc1rPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140089
X-Authority-Analysis: v=2.4 cv=d9T1yQjE c=1 sm=1 tr=0 ts=68751c97 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=cRrNvm_rwuFhJ1RauisA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: LGa8rY2x-zOlNyaXq2dVKVOri8dZTkhd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4OCBTYWx0ZWRfX4DPGWeIpCERy GgQIp15u4L1fim0wsd3/XjR/lbrstdyWifylCp4uzxN8DjClLYVQwlunwH28UQTwGP9yqOILROQ a3zvZnA1FshI15pxMhdzl6iZEaAYvDV8edJWZHw3sfHVkFZAv0qxmmWX0qZKDzN2aCakBDnps+j
 Joetw6FXRgyjUYmeDu0eu9fElduc7DG0DORWzV9RpetWO0xulj6+LD5OKmUwu/Za1YpTz+kfq1Z 17l0/19rX0I1ElNtKBmQWnRGsv7zkq4p6+RGr9mhfdsiCV0wXpQ0NyGgLNOtadXcold3DgbkQY2 BLUvkNmSBUxmQTHXW+Ay3Nj5JnAzTbONAjHqhVPIT3bWO8nOsgusD1b+Uz9BJRmXIvVVgBGfiPd
 damXFPTUTlznryBF2zJjohyE0iFcNnJ1KmrkWWGpBfVBaL+e9bn6midAgLhOvVHlI8J67fS3
X-Proofpoint-GUID: LGa8rY2x-zOlNyaXq2dVKVOri8dZTkhd
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_080507_305173_FBA850C0 
X-CRM114-Status: GOOD (  23.02  )
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

On 14/07/2025 15:44, Christoph Hellwig wrote:
> This was originally added by commit 8695f060a029 ("nvme: all namespaces
> in a subsystem must adhere to a common atomic write size") to check
> the all controllers in a subsystem report the same atomic write size,
> but the check wasn't quite correct and caused problems for devices
> with multiple namespaces that report different LBA sizes.  Commit
> f46d273449ba ("nvme: fix atomic write size validation") tried to fix
> this, but then caused problems for namespace rediscovery after a
> format with an LBA size change that changes the AWUPF value.
> 
> This drop the validation and essentially revers those two commits while
> keeping the cleanup that went in between the two.  We'll need to figure
> out how to properly check for the mouse trap that nvme left us, but for
> now revert the check to keep devices working for users who couldn't care
> less about the atomic write feature.
> 
> Fixes: 8695f060a029 ("nvme: all namespaces in a subsystem must adhere to a common atomic write size")
> Fixes: f46d273449ba ("nvme: fix atomic write size validation")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Reviewed-by: John Garry <john.g.garry@oracle.com>

>   drivers/nvme/host/core.c | 9 ---------
>   1 file changed, 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 1d2240494f3d..fdd2334dacca 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3537,15 +3537,6 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>   		if (ret)
>   			goto out_free;
>   	}
> -
> -	if (le16_to_cpu(id->awupf) != ctrl->subsys->awupf) {
> -		dev_err_ratelimited(ctrl->device,
> -			"inconsistent AWUPF, controller not added (%u/%u).\n",
> -			le16_to_cpu(id->awupf), ctrl->subsys->awupf);
> -		ret = -EINVAL;
> -		goto out_free;
> -	}
> -
>   	memcpy(ctrl->subsys->firmware_rev, id->fr,
>   	       sizeof(ctrl->subsys->firmware_rev));
>   



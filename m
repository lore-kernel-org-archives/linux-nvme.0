Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56BFC531C7
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 09:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hKtxHbgpXAGbmMxpz80kWGKhxr7fBY+vZz09Pe58vIU=; b=fjiZSwKq1jUzbmpVKTjJXLWJCN
	ZmCa/oEtuiS1T7SXPRl8RFpyWMmjJDMFuhe/K0suX70eVeWakpJOauVwmA0xQO02h2iErTsmgvY+t
	OY2AO4ajLGwl/vKZBmPC5+8cTTQ+Zt7tTVkJQGY345BjwwwQBkPCCmHr4jUFyr4SwwwGNU3IYNHoo
	s66Vy3zqbRXPDwvNfZWb7v1wPh6aZkTIofar4efxmo9KDwEBVHUFl94KUajOb/xepRtm1VW/51AJa
	i9xbC6fgLyAoJ925usqcXh/Y8Dvf1h9Q8/0dTJUNEO8oU7UMc492nvU4d2QoMhqv4b0zQ6T72EIxI
	YQjxfpWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmprs-0000000DsVC-2Lr3;
	Thu, 23 Jul 2026 09:37:28 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmprn-0000000DsL1-0FUa
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 09:37:25 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N4JhQp009715;
	Thu, 23 Jul 2026 09:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hKtxHbgpXAGbmMxpz80kWGKhxr7fBY+vZz09Pe58vIU=; b=
	hLP4Cmy5A0CIYYtWuf2G/mNGKb2q3s5onIM4KLGi1LEOVucV/891zDKkdH5xk87g
	qUvwgUH1r8Tf+qFsxSZzDwbEDAuQLpYjxn+DewSBjYbGytbnot3BjYkqOVvD8QZ3
	k64xSgPpiW9apCTrs/C+Yl56AxY3hEyonT8t8U+4d3L78ZDuVMP+HcvnhQ7VH9IR
	vzqlYLUTS650YilBZhzDYxKxC2Y3n+e5zUbXXQvTglbaiXosQrr17RIvRcqMaaRJ
	jIjQXR9Nk+h08zXrUumNX2i8YTr10XqNUnFQ+izxSHkpd/CHCOOe57+QsWDVe8Xo
	xShU0+kQZI3VM3TaXlGIQA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg21q6mux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 09:37:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66N9X95u003534;
	Thu, 23 Jul 2026 09:37:10 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010003.outbound.protection.outlook.com [52.101.85.3])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ffyxen51n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 09:37:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=omSVYLbnOEyeed/dGoBaDOGazz8bEtXUfHFt3AXSQqxGzQ3k6ZXdrLZ4r8aRC9kBaB9AtgEAUNQYS0lRLuyTGexJEVVKpQpsl2G712eiZh0cfIGgQ2f0rWI2yt3tELtCfxS7MTBmIhY6H0kamihurmfXodLtc3KFGUqW0Lr+kfXI0cdw1NPPP8DmksctIbSCQgIrNMFofAYhptqgjia4isS46AjGiecCOk0ghaJAuziXttyCTfh4at5OICzVhd3FC7ZgNgFhW3+2WSGt4KtbeV1jsrQfSNmYzEX5sw91nbP+qYRc3BUhasFYD6OptXJGJyOjbimWXNDEiqSvTam40A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKtxHbgpXAGbmMxpz80kWGKhxr7fBY+vZz09Pe58vIU=;
 b=bz6ryLnA4U9TjNyAOVjXN74sb3hzEQJPJ7VywpsgpULLooawYEK15IBIkJU9JGH5Y9t1JmeUUcN/Yii82vC6ALApWJD6JXnoCG2r7Yeh/dRUdK/rUgi5Wl4TMNkAN2l8oowwsWdOvSA2k63ylWHXcHUX05Sop3xqBGe4Prmy6XFex24C7DgWu9W4awQUNzzmpZTtBvf46ZOMXIo8sCfxPKV5Dieqy0oa9A18g4p+tg71IelHeoYKaXeoihAZP6/LIQaMr0ZAB7XBjakDowlWnMOmzBA4zElBuQWLM/nTU1Udiz4brfudl8l850LOaL+w/w8WacQFRgeyl0Pq56ntjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKtxHbgpXAGbmMxpz80kWGKhxr7fBY+vZz09Pe58vIU=;
 b=pLmZDCL26HeqBfu2CTJ4EZjfIJOJzFnqe9qMrbvsnf0pSISe+YF0GHtS08+5BGF7Vwxc/ubx+UlH+NGgIHeQh9SAYWxlUqEk+OJrKBhaAxmHmBqlz5DN2U4uBlD7LGKhQ4aN+TJLfdjOvWDqA9NnhSoMiY4YwHALbFeS8HNtbrY=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 PH0PR10MB4678.namprd10.prod.outlook.com (2603:10b6:510:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.10; Thu, 23 Jul 2026 09:37:04 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 09:37:04 +0000
From: John Garry <john.g.garry@oracle.com>
To: martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, bmarzins@redhat.com, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, nilay@linux.ibm.com,
        john.garry@linux.dev, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 10/28] libmultipath: Add mpath_bdev_getgeo()
Date: Thu, 23 Jul 2026 09:36:08 +0000
Message-ID: <20260723093627.2327456-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260723093627.2327456-1-john.g.garry@oracle.com>
References: <20260723093627.2327456-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0392.namprd03.prod.outlook.com
 (2603:10b6:610:11b::31) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|PH0PR10MB4678:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f80ec4-3725-43d3-3d3c-08dee89df439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|23010399003|376014|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: FF1Hk4+4+qBvTQwNdiFGQHkLPrK9iLSyqmSy/XtePxCT+a4Ii5bMk8aSzEst6UtllWb2YiK6v+YGRfdyUsFre5r8hLZqGbz0XHHoRXuiG72w9ZORHizPQjCaazQFBbQzglRsJTF7BNMgSZfmcbG6FD6LYOXcnq6gAnK35vT22QsWEJFe4v8LmKwHVL/bm4Fo9AnlZ4RssFy9IkbLvA6wJCl+KYE41KwE6Qzkd+U6hS1nNqSh84hOzxwSeF2WcMttdTEWjrBK0d0WtIk1hF0hkDC5I1inF357br7nSdo00LXmVu+PrnTux+9AxVo+wXTldf9vkFVZWtij1YRWmKps3bYlZTxI9OPnEuL0kq+Yjeat4zPaPk52unOr9snJ7dH9EMhm5d5yRMO2H7hYLpm7NaLg2L1SNmwS+yTGVWL6a3oltDZuE7f0EHsZFrOtp9hzlKp21H/OqkbGuxYKVaU06fumqDdlS0tQ5C2pHA1Kpw9n6KpCPUiVdM+Tqf4NvWPQbmHUPSFQqQWIFuSb3VG0dpJLOVUQarPZ4dY1bWdv+XmKkDv2PHxiIYoP5NI1LYXsXGXpOOFLJ3vI+e7cnpSTlQM62X1cIVeBRbB7qpCQmCYSM/ykndTyO9pxjBaA0g0Zfn/KQgYI1hjQbb0ql6y6vrwO4GPh+6zmbVWaOWqlkx0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(23010399003)(376014)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8MfSbwCH7GpzQF3t2W3kk7UKkIE2BCE3KCbNEHNi++PUwUnJjrdArBhW51Zs?=
 =?us-ascii?Q?VFYD4z9xO5sEV4AaQapWWAg4FITKUOJSB+D7ZygpJX1nbDLSSfvv4LRU/aqS?=
 =?us-ascii?Q?YwMZGrB8LFhmidgLr5/xGSH2FTmNMSVUKYp7HmCXMgQIgiNPOTrNX+x2n/Hq?=
 =?us-ascii?Q?15QNZevmizOrujVywEj0EhMR0tVOOXDYk7rypFYEQc2PDNQVVYuh3Vzh21y0?=
 =?us-ascii?Q?6dwYV6spL4IqMRcOCmObAACmx4itHPbAt5sxtMaQYPaVDqZPNWq3OspcXI+E?=
 =?us-ascii?Q?jvj+Hy4QpCvOn8CDQ4tOZjJAU2bpTVqgeaT9FjzwRl1rWuvMdrZWvpZrEfI+?=
 =?us-ascii?Q?+5N8TSkZhsTSIZni2sNaWuSYR7tSthPOsArKF0bRc7PQEQEV0SnE6YV2GU8c?=
 =?us-ascii?Q?U7njrhyQMeWSIDOccS/ZR8vdrZH6fCj13FR9+ksd+9Goo6gkdE3YwA3pNT+P?=
 =?us-ascii?Q?JjZBbzGbY3cV+lfh8fooaV4kSgrqEzEysBSWfZw0simQ0OM1BQuJRuS5Ootb?=
 =?us-ascii?Q?+ZyYV3m5NAip0Ckr5UpXy0PR2ngCaBg4/UenXWaKRSTbbXvGgc2FLplmN8E5?=
 =?us-ascii?Q?NYDb+1/iA4ug3XGvrVLyLXbrr4bgxN3amXZZeZAIqB/K9Os4IW3jVyIThbdI?=
 =?us-ascii?Q?3h8DH6yuBAKdypMtOp5go8Jkmkfaaps/sEdqoHQ8RsLSOyjJmYO7BZnvdo7+?=
 =?us-ascii?Q?YE+4YIvKLq5YzkMI6pFjtP5GZ9McOZ1bx+VpD/QLcmF7PNV12S9GlKp5V0ph?=
 =?us-ascii?Q?tpUJ88clPX/UvaJElFG5OCs0Ftl20fsi+MJzU724fHqTLFlkez+usniuf0WM?=
 =?us-ascii?Q?rJwuZiW+kjnKOHrtz9uyGsdqbRAETNV5P1uHB9z16N1KavbogcwRY3i0BqcT?=
 =?us-ascii?Q?GccRpAB2zL3sYqUjTlfU9wSMjf4yV1iRGBjdKZPzP2QZP7q8YrH8F1v/JiAp?=
 =?us-ascii?Q?97afxjqcAGAyouQZ4ciSewYQiHfgN734F1SiuGHGPY2tWYQafbPDn78p9V2g?=
 =?us-ascii?Q?N+7sKFBSi5rbYgwcfMCzokI430j0xK6JjBQscYEiGpUnby/BpvFv1U0eAXNv?=
 =?us-ascii?Q?EQbwqKnWh2srT2qV9G8fVXtE9C86Doi0LFaj14SmHWYy1NeqP9tq2m8ER/lN?=
 =?us-ascii?Q?Snkj+aRcVAYyvvYtxAbX/PJ6o68VPvHzS0RxZglt3EszwgfrZasZc/xaDDxd?=
 =?us-ascii?Q?OGMJJ20NvqIJEQgO8wi/Q2bGP96haa+wC3OQOzCzDPMjzz4qMWGLxDrIZlQR?=
 =?us-ascii?Q?brz7f1/deV1sQKZlDHfxBk2b4lpBwRuTIuoMGdPd/sezCJ5mHI8wGPn5+/gn?=
 =?us-ascii?Q?Qpix2FRk52UBKEUXqYnwoh+0KTOxfE+oUhIUKDmqTtcYsy8WyaC76uwhn2zV?=
 =?us-ascii?Q?9QkpHrDMLwF+l/6/xzgSE78PnMwlqLESJu3dIX5P1lWFs03knYjMByiuEAVE?=
 =?us-ascii?Q?LmMW0bYovi/Se6LrDt+fPMJx2gbWcs2v7QmGwrxDd3N7OyNTZewnvftmSs0J?=
 =?us-ascii?Q?OIXpTP/ebLdi1UKpLXEpOkT4zs80LWuT8hBXYnUSkIpZvrSSywofXdc6vkjr?=
 =?us-ascii?Q?zI7engmDUxKuLjEZpvFFDZppaltbzOFHkgRnFdV91bmt3lu4b7ZEqL5MoxyK?=
 =?us-ascii?Q?ye8ugPv6cpG3VRC1WoDhCkdfnaFqnkN6Q0vtYqw6w8f+qNONcaAFliUu1mTc?=
 =?us-ascii?Q?EbCLEyBl96r42NYZ6aAnJEZmB70VAHq+nZgc2op7GfapZewe8rXgqi+lgnfB?=
 =?us-ascii?Q?qxl8Bn6uPw=3D=3D?=
X-Exchange-RoutingPolicyChecked: ImB2CU0fgZ8Igu4md/Kl+nrEqK2ZsbvegzTza6j7+VZuSWYRxRZK8yqIFeusSYdB/e+ruFmUUF/645vL92hB6+DpuqV7x/OifZ3/rDKJRoTAwBvP3xpbxJaWiiAg46B7CoYdIlGws3+xWSKvWY89STc8CpWvbGb9atFisQhO/leaOSwxBBDCD/y9Dj4J6ONqvXheTbcpQkhp/82IUHTpH52ZRxomMQPyUV4gm3m8cxU7bqEFvweYfLhZZO7T1jVxDNP71R8kaaGqS0ZHu0r/7kYFDVTh5d9/dtycsuF93FXQp3Q5FfI71VlpUgk3cI2FvPSCKFyHaCQgVXtjY5uMWQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qNHXavgKmZx1mRwdgdQo0OoPkWi0O9yIjEL6L1lEHopc4J3EHiBOyjcHbjuqFBQQN6VvBY71XYp0SeKaS7JwnEd5ckuAWz0hLrwEY/0BDhQxbFBrBrkdq7s5HNnZLFI0Bfq2n9wlLUL1C+9jYY6o9W34J+cjy+jPkXk09RE9pAVb4XhJ3GSqNyHGVdGqXk6/1UBgUV4JK8ZwcdWMLMKNBVTsnUZlvVfCBV/MtwUYJ/XbpGQmcIwNDp9mcn1KbqbfnXoHHoGZAtR8+Dd4xvNIf3g4v4wBnkejP2Nb4dGXLApOu/VjzFZsXadGUE0E1ypgmhQtAPiAPdOZnjjHMITY4tQkzPRbbWJ5tOAekAH0NMhmE04U/TMwVKH9i1lyicWlqqvDC9IuAa5ZjlgAPO6B316ECtvtx/LWatupVBlW1nvCiMUfiPu3m3blFEl9juSABeFxHw/asl8Gp0ODUAf1Nvd5LtxOk5Lyl7WqgLC5M0rKLiMCnF5DAxj2swvufHRQYCh1vpgycRJL9mVRp7j6o+T1L48w6/VBz+fw9QykK7sQzrt6GNNaOgmhzfZD4tTMgxmaEBGp16r5dvevbvnoaIGfITZ2gu9Su8HeaCP/LQg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f80ec4-3725-43d3-3d3c-08dee89df439
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 09:37:04.0365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qLL1nDFuq82uo1Ct7QLRTpNZS5iDp2sE3PV2m2pfDTOFFH30OG7M3psN9TBd1/Zx+r3eqnmvd9P5UHq6A5XdqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4678
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607230094
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA5NSBTYWx0ZWRfXwZH1Hoo7Kq6/
 8QAIdZtPcW2vZUe6YzCRHCY/AaulZ8M2iP0Fl47HYQC3a+e5VaxugstwXr9wXJQDScY7gANc9cZ
 Y/uijDtM2xpUE+HXoqM0b2WM4F0FSdIUXBv5zq7tNZ5KRxpD6X2yXGKiTKKSrKjNUSyjzwrMjBN
 JCaZVYTuzYO+Uj4OnuREgGCVse3riHcsE2HEJFZr67lJfIpOgA6gbUE1ETcHA9R0xOXQxykfDYQ
 vSvD0NaG66J7NwMxS9Nrho9HDJg+56leL0SX/4+Vesu4b4/KpcKLvr5o23dZenZ1MfSfyg6lY5R
 wdFP5r+fLAeUyxc3RQvsxcY0Ap61hjOtNhZy4nWraeb3GhAlnzjYOQQQoh5b5hLryoW0oXFrTPr
 A9xpuklfU18GHhl63OXJH1qNjwaoRj/WU2inyv2OX7yS1OPqPKQa6XsEhQsw1WGY3x9tirmOjcY
 aPIRoQCTn76hn2wzT8w==
X-Proofpoint-GUID: j9CY8gmzovYH2UUt5Gru8-Mu4IAvnWFE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA5NSBTYWx0ZWRfX4giu77nzRfcq
 +PdOZ/CPgpFQ/N5E0jBkJlUh1D6wQ+NzaFzXZYEQ1AvvHXFB0WKjL+JGS9Up/4hORjvHe1MMmsV
 EYaHsV8XbcIhheN8jGPXK7wCY0kZPkv3fgjGVaC0QzIDsBJ6Hv8t
X-Authority-Analysis: v=2.4 cv=ALkdLnG8 c=1 sm=1 tr=0 ts=6a61e0c6 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=XmuUcEe_06tgJQQ_RK4A:9
X-Proofpoint-ORIG-GUID: j9CY8gmzovYH2UUt5Gru8-Mu4IAvnWFE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_023723_126885_65FD9F1D 
X-CRM114-Status: GOOD (  14.21  )
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

From: John Garry <john.garry@linux.dev>

Add mpath_bdev_getgeo() as a multipath block device .getgeo handler.

Here we just redirect into the selected mpath_device disk fops->getgeo
handler.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 lib/multipath.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/lib/multipath.c b/lib/multipath.c
index fc8ba8fc501f1..b90d4827963ac 100644
--- a/lib/multipath.c
+++ b/lib/multipath.c
@@ -505,6 +505,26 @@ static int mpath_bdev_ioctl(struct block_device *bdev, blk_mode_t mode,
 	return err;
 }
 
+static int mpath_bdev_getgeo(struct gendisk *disk, struct hd_geometry *geo)
+{
+	struct mpath_head *mpath_head = mpath_gendisk_to_head(disk);
+	int srcu_idx, ret = -EWOULDBLOCK;
+	struct mpath_device *mpath_device;
+
+	srcu_idx = srcu_read_lock(&mpath_head->srcu);
+	mpath_device = mpath_find_path(mpath_head);
+	if (mpath_device) {
+		if (mpath_device->disk->fops->getgeo)
+			ret = mpath_device->disk->fops->getgeo(
+					mpath_device->disk, geo);
+		else
+			ret = -ENOTTY; /* See blkdev_getgeo */
+	}
+	srcu_read_unlock(&mpath_head->srcu, srcu_idx);
+
+	return ret;
+}
+
 const struct block_device_operations mpath_ops = {
 	.owner          = THIS_MODULE,
 	.open		= mpath_bdev_open,
@@ -517,6 +537,7 @@ const struct block_device_operations mpath_ops = {
 	 */
 	.compat_ioctl	= blkdev_compat_ptr_ioctl,
 	.report_zones	= mpath_bdev_report_zones,
+	.getgeo		= mpath_bdev_getgeo,
 };
 EXPORT_SYMBOL_GPL(mpath_ops);
 
-- 
2.43.7



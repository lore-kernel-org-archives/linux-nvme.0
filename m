Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E44ECD991
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Feb 2026 17:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5ah/5lf0AfNcOoR9j5g6t/ZRwd4QtPcYLR3k9Aji99c=; b=2lW9pK7/aBW1cdMHMoF7BsWiNQ
	MO/teXRWiNryMh9wy1iTilVbJ4698wcxhxYHDc0UC4sCR+46kcuJMTaABBjSBrBUwfFmJ86iALAEP
	KtjL6zsNN8TJ0c83+ZH1iHhTwTO85g2Tk1ZY6mXTuExyP/D1u+qK2g8d35ZRwkr/5H9N5uhgQsI8B
	5UnsKnz5PZqS0yqY8edMR02aW5swG+Zqg2yrLT1jd5D/S9TXmOhDWzcpq/AaxIoPzIgJ2umnD0eUl
	J4l8G92PrANZngW8E31xebB7bfuaReawg4LDir6kCnLK1XnIZQlqU1t7qcW916hHrBQfKjKdId0Yk
	mcN0RZxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo2tU-0000000AH4y-2VEt;
	Thu, 05 Feb 2026 17:11:52 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vo2tS-0000000AH3q-0qPi
	for linux-nvme@lists.infradead.org;
	Thu, 05 Feb 2026 17:11:51 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615FuFkJ828836;
	Thu, 5 Feb 2026 17:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5ah/5lf0AfNcOoR9j5g6t/ZRwd4QtPcYLR3k9Aji99c=; b=
	F3Y3hk7sVcihaNjomUfuulDLgWZSJEyvYy459ev0iYgvwnl1CAy9cPi+ayrNo0nX
	/LdFf7s54KMIvXw/NHB3Y0bIwnFTMCFtASVuTGIj4RdxuVXXZl7JpU/c00qUSfJA
	8sbLnGpXTWx5tAKq6cG4SliTIPqpEhvRi0JEVpEkQo6QpPMOrcvFTK50Dol8pWNE
	1dgMuj+lnPXnVCU6TMKDUoX7aMFDswgAdDVPrAIN3ZTymoINwgPZmmxfRUkuMvuf
	4cyOn0uOlVoyp1OG7aYkpI+Q2fm9f7hHUihXhWCPIvT7X/hXmDri18YvxGlF3vH7
	Q35bwNYDbwLwZ8sWHGe+UQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c4d9v1e83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 17:11:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615H31Hi034785;
	Thu, 5 Feb 2026 17:11:36 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011002.outbound.protection.outlook.com [40.93.194.2])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4c186dethd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 17:11:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nitatkclueU8oOb9kv2zMe1Qe/eYSbx00vxHtJ8HAPFTvjWsDSMJHoHMYz53fytKNnh1vom7TaxFDkFQfOG2rSpEPt8aGK4BLCMPe3vULyR0rqJ4ve2YA7eieZRMkHA+BgRD+7r+3zATTSRKrZ3Wkp6hUTR6dUV3U+GQayIVIB2GRW145OlWSHz0Wm7XsR4/r4AiCCFwVR9Ij6+UWEZmHGgZ+ZngU0BPSc0/HqF3FG9B0+EoUG32OAjgJIpW4setBHhii2vqFnkS3wH6vf+oj7FG73lck4drmxC0yixpyrf3eEIUi8n83gY01aPTFO0JuTPCnA4GwHE9IXAjWbtsNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ah/5lf0AfNcOoR9j5g6t/ZRwd4QtPcYLR3k9Aji99c=;
 b=gpYVh2MiZWU8EFDCEt1jS83ommmyzhb0+t0C/tLCVWUxGFggO6bul1pw84U9dVWqKSFqg7uGw/nu4ndfBpeMBHUmPxCv5+NG7BWKeJLdZEN3W6u7Ylj5bADwS0jQTM91GtmMqJXw70SycXBlZyyTtUoEKL62HG1aGQd5pQq/6J8P8NXIVkYMESamZdVh8pVF5wQIzh8A1jBepctTWIdRU5L9vBvSlJqCLKJUZCQPmmOQWbEqFym76feKpbs7tjQb7nteMNNgmcEX6PchdhJ/577Yyccfi3B4BM1LqWSJ53aRDqpyn5Hi+Aor0UQINgbmZ1pVbuhDRB4MN2FH2FFbfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ah/5lf0AfNcOoR9j5g6t/ZRwd4QtPcYLR3k9Aji99c=;
 b=iv2Z2vd0yl78Z06EYEJh+lUDAnu/FFf++5aOQ/BTLrevaNsdJC4XrmMrWndvLbvfafCVSheDpnVLWrh0nSP7nnn4lTU+Wtey3sWI/unbyQr4fOcfFEhrAg5yHZZnv+RbLbFVc7MWelWspOWwTVUWeOORikfBRoHCY8oQFG/HD8k=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SJ5PPFB6A054FAC.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7c5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Thu, 5 Feb
 2026 17:11:33 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 17:11:33 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 2/2] nvme: stop setting namespace gendisk device driver data
Date: Thu,  5 Feb 2026 17:11:15 +0000
Message-ID: <20260205171115.2610321-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260205171115.2610321-1-john.g.garry@oracle.com>
References: <20260205171115.2610321-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0075.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:32c::11) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SJ5PPFB6A054FAC:EE_
X-MS-Office365-Filtering-Correlation-Id: 11044e73-1112-4960-2926-08de64d99c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ufpr2HzhjX2+6/Gjy64nWzbtaPQX7JXa9iuJpOsB5hfoyedpmGxSgzBo6zP2?=
 =?us-ascii?Q?V3vzh9WFVCmXD4plnPIQyX9HVlf3F0cITicqQybLU2tyv5viUV1zOijqZKH/?=
 =?us-ascii?Q?SXSqlXXbvm2viUPUDORLd+EkH9AyD+l8gqJI03baKXNFsQdFghfiUeeom9K8?=
 =?us-ascii?Q?hICtQFXOpiiYCX1wHHxxOrI/37NUkbeL/49IpYz0+9OX5nr6dJU0eYxsg8Yr?=
 =?us-ascii?Q?eSf/brrS9mA9V8sqf2N81PnJRSfYoXbc15X+YY+6oGFhGmfI/j+msUok2H3Q?=
 =?us-ascii?Q?9NliDBZvxeV9jYSwPOzbPBuIfox5ynWcBe1+tyPCv40xwPXWtqvrBWVa/5d0?=
 =?us-ascii?Q?QIkduvpqj63S7unXvDLvK19lOQm8slGiQ0RC4DGZM+NI/6CpDQwCBUAeWUg3?=
 =?us-ascii?Q?WmHcwLBajjkXaYV14OCcu2dBkYX36p+ZlyXLTEJa99mqoFXU5mc7e262yZqU?=
 =?us-ascii?Q?QQO+MxgE67u54gwhLjbnzNdBREFdgApTgC6wYD8dQ/lNPvKqKFImjFSCx7Tl?=
 =?us-ascii?Q?qB9rFwlNoH6wcyncXJpt5efW6sVa1pCbbyOB3qPpLwvZuEbIkIVqgu80XUh5?=
 =?us-ascii?Q?82fWyhlPS53nCA+LgTJm3s7qGSTIv197WD3+auX65OC8NsabVCd8azKqts35?=
 =?us-ascii?Q?bxbqM3iiaJUrFqZ6ygpH/zTzUBBYUeAOKv6eQyy9pnlfntG6uc7RRQ/rljq3?=
 =?us-ascii?Q?iDdM8eynYbg2TUPVHNXi1+SGMLezdIvdAlZRRX84+0ahduuvAh0z8quY8fAx?=
 =?us-ascii?Q?Rmglu0iYnQQwf0LTbz7QKRdbzsj67lDrTBV6o3O1HH+7eNyjpFhn2XBNGe7D?=
 =?us-ascii?Q?t8pBTR7UfFZmoJLVuBxXYpNLxa9VS/DE3X18W88ZPWmaHD+x1zJWHFC7NCiU?=
 =?us-ascii?Q?9RwNnCa4KQLD3WzVz8c6eHr8V+H/BbGp7/YUDgZIM5g9nPU7EfRpEtRFoqsF?=
 =?us-ascii?Q?SNwNCKBsCsP5ubwP9Dm1in+khL4gXgRVJhvJcnyywgMRP1rdphc4j5zravtd?=
 =?us-ascii?Q?CVdrHsLaXP0OQahJE7OtN+aQCCGw1wWcbjzw3+uobKRJr/K7NCZChs/KzEMe?=
 =?us-ascii?Q?4M0mv0I+CEnE96Pgac27JH919nB+3OEur3RwYJ1t7PDZpa9+RNnMTH4tR5T5?=
 =?us-ascii?Q?duv+fM5ziFd1JyyeOhMwWJZc49CgECjPt/BO4lUodEwDdOIy9Wag5lmN6p14?=
 =?us-ascii?Q?OtaohBVHUlXQvaJSno+t3n6xgPJtQek06p0Y2lkbZd290/Kufz0FRNzJym9X?=
 =?us-ascii?Q?++pSnzYsuSnl6C0o/DILEosWnhk+SWDE9DzGZ9HwI61nJqvMJfH8HcjM2BxM?=
 =?us-ascii?Q?FxVSRf1DvhoaESpXtA8D0jQvE3DPmsoXUKKYnXeKk2/RgjBhlznddw2LHmpl?=
 =?us-ascii?Q?LnlLJkx66Z7Ud+M3ntkOCxBittBdCyxmP3RS+ZvA2dfkUD77eXdwBY/1jXhD?=
 =?us-ascii?Q?hZlGFRdeOpL73NUhuh9GgHYlPOVNVLU7g7E3g4EgVwXrCZo2WU8oRvWQAmX0?=
 =?us-ascii?Q?V7EQ8gjEohfc4kxPoODSM2Ahr75VRDcrqeZqqaBGZcMT+ASFiJS8iu9kXZ3K?=
 =?us-ascii?Q?dH+MjG4449m8aq8GTy4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RzRBbBtlQ66rIjF4+AKDKzAutaAKKLO/3JCoph732nZtdmkjkBu03sljG7nz?=
 =?us-ascii?Q?yzz+yjc4WOygZ76cxQ3eGahpwvnGz8XYVtLmklRg7YN3vdnEHDAXcAQ/a3tx?=
 =?us-ascii?Q?7oNDHe6a0/c/nt/q9shOimG6WDOhx6xKfU/4R0xW+ikwytoB+OBF02UsIHb+?=
 =?us-ascii?Q?zCU9Of/aQeliBsnvQzbB6QIPcBylgGK61WvIWwiwbp01DnvrJio7V69qusF8?=
 =?us-ascii?Q?ZK8O1ikgO5aNT0IBA3jDdBSNHs+sJE3Q8iNOrAMbqc474nOJKVv5OAvCVSua?=
 =?us-ascii?Q?+gcJL98YDMdsgI1UJ51VvnsCEk3El7UQNR2OKjVtutBpFOAksAA4Br5M58SV?=
 =?us-ascii?Q?i75ZaJP1b61UO4yLwaB/owvMnfUmHMVKAsvH85NDwnRSsUSAZu6T2tNsdqyv?=
 =?us-ascii?Q?BB6+3Mf55wBM+6KJy0rrCmZUqDzhsL+/2X1EhxuOkQ//DYJRR0F+NGUiXbuS?=
 =?us-ascii?Q?3grOyh03ltJmSlws8Xnu5gi6rw2djzVNo9PwgIPZgxESbrbnAoOkxtif8Jhz?=
 =?us-ascii?Q?2ShMhz+HSWf+3L0Qmft4X0IiUenkPefEwRBTYzW52TamwIor4/+I38+uHb44?=
 =?us-ascii?Q?WQuu33lw4kb+J68b49GxFoi4Crp2ShJHMSBBmz15xhPAb6Btc2sqcIuqofJ8?=
 =?us-ascii?Q?hsO/px1xy5api6AOfbGCkOp/ohzVPwxUDWB64D3GY6pAaN9V9HIYH/ZuY5+J?=
 =?us-ascii?Q?BqiHy872b0StYJVbSVBa+OZ9cGvVKcFd7GPhiHBhmIP/rupuJT1c2b+uAKYW?=
 =?us-ascii?Q?GBLuYUrzZkb0GO6PF/TRKXdIWJYFhvy2l/KMsxFlN/D+faqSB07MST+5l8/y?=
 =?us-ascii?Q?a4Z3Cd3OOXnrIbuk9qcBqVJ07Ibxy51qd7uwvzK0GzAMsv1Nwyjwi/zMRyf7?=
 =?us-ascii?Q?mYcQNPsifoy6vpjAKdhlJT5Sve8sXvHL9Aendk4jV6O8asaNXonBUUoINmdj?=
 =?us-ascii?Q?wR9qS8GHVZLwdNa41195CLpdiA3k1AgL8w+kdbyyODUI1izOqCtAWe234gt8?=
 =?us-ascii?Q?xDMLJ+OZ1hpgR4o+jVjcpjLDcGj9FQiIJwr/+TBTLZE/ZDq8p9OywJW4Qir7?=
 =?us-ascii?Q?04WBtMSUzseeM8ls44EXU8MCFad6FJxyzsv0Y6QfVSxUQW1hClbXTR0tvRwX?=
 =?us-ascii?Q?ajSWHr13s4Y/87lRw30PtxqHC8b8e8/VJQHiYZIfWq7jjXq0xo8RG5sS/Hd4?=
 =?us-ascii?Q?EL01k0qsJ4hGzHa14FpxGiMdT1qChO3bMECWXEQiDxsfrq1QnSMgs8yrO2Zl?=
 =?us-ascii?Q?L8cwkw6eCxOMyEYDwclY8tXNmlXVnkAlpICNESTFbOHbRe5PNoslJQfJ9Osg?=
 =?us-ascii?Q?JgXx28t67OfX3EpdTaWyh/3oemmjslVnvB+O2SoblmMmpkCCfdEUHR5KqJTH?=
 =?us-ascii?Q?MzRVVRYl6T0UfnCzkx/VTFo30E0PiY4yfiRnOcMVKyjyZu6uj864jjEiE4bV?=
 =?us-ascii?Q?a2DVg1eygsW0zeKqP0PRRdM8xVMV6fcs2Yvb6d9z04W3vMAWjF/u9j/1EBXm?=
 =?us-ascii?Q?vapdT0WJ2gvaHQTZ0SMZKgjpTW74oPxufXbTyB+iGt3QHULmorpgLIMRFu3V?=
 =?us-ascii?Q?A5XERs4DZE5gWqEinBUa1MH+b7U4gqmQGkgnD8KAmMqD+RNH+jUHcMbFQ5wW?=
 =?us-ascii?Q?xvABAvr67fTQQF/cFjv8Kq3abHYuxnyv1EvlE/Aq+KCWFnvUVJt0Qg4NrrUV?=
 =?us-ascii?Q?QiQetiDCHeuoekEwa+8WoyLx3EZdcsZOqGrcgD32j6ul1JZMxoxJlTVSXkzL?=
 =?us-ascii?Q?KANBnsPvk5IrhtlMAiVWBZwymH6jTKI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SJUFYzJ9brr6HkHpqmqmJaxiIJz+z6BLBRHRcdx+33jk60xyGrJ3x2ptoOCBFvK7GhIGRYG1GdyImEFjUCBDmgvn7bNHzSq/gzqyc1uuiDBgU4T+/hRCL62m6wTjlTL2qI16jiWTM1TZre2udsKB7gVtXH+UKQGraVrZbmsfaGQS+B2jmwLoiiAlTQ8zjR0k28vwPJNcw5GfaExGF7FZI8PltZBhNGWJ5xt1Y5GrTOxz2qAuvsmpWF+14D8KnvHONbYSHSzIBQj5A8/EkhoIRdF5WSBjtrZnemHxQViYjTW7sthk3enmzOPy3/rnSdNIBggcpxBeQ7KK+Tp1YPODpM5+Hijg6eD9aCJUu6paNxQVsXIhpSjePc0dFLerN3SmFtubGsMH5A2cwUqOMqChixNBppT4FgAplScjxo8Qe7YipfrCka4hRqZl3xVSOXOn5NjP40RBd46tpQXs+QOoEg2rfv6SOo/FjI3oM/0z4xrbAWkq7wy5W2svFMB9BQqSIBqkpHH3ck50+Wm54ZA0xdC1LdadeaBHJfDj05DWO4J6+hQJWCf5181fBRO2HcWCXEGCKml1kqW98Vj8WwQXTmXTsLV2Kayi5R4zRlMKjm4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11044e73-1112-4960-2926-08de64d99c9e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 17:11:33.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBpuBkCvs9a0r4KngCjCBuGcjLIaEbdWFJXq41xEIkY7v01u2EPj1Vz4SPHYj5pqaXu2EvZol4upHEPbPUIRmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFB6A054FAC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050130
X-Proofpoint-ORIG-GUID: NMK6P6saPCsvse4KzZNQYCF4jxq0hsJi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEzMCBTYWx0ZWRfX4Hk56nC1CqKm
 qq6MY9P+7724aGr6WnkH9AjwTkAYwKapXzfCYxEb/LN46OuKL9l6jyHNkUlvGvyWxWSm2lF1K85
 0I+aDw7qEwza566R8pkPN6ss4QLs0vum8zPIJGNMeGVZisPFk7xuDXCkVkRYV7uhDwZKZt8QmPu
 BqTJmO0SOmNaF7A6AFGiZBv149XtbdF3ZizYZcV08KxJ+bEldGMJUs98dP9fg/ZTshnz5j/dHBp
 aZo6B1aCcqZDWSgk2gKGPo7/B9NLlrsQe9efwYEL3ak3FYC6Gfb08HD4b4p7WZGQgcvkBAn7mJV
 gCIGzyD+1nPMiJ1SjWc1iOPItPPbU/flAYQ0vqMugQBhUXIhFDWGVi2jnNYyrskxi05sBPjLfr8
 /ca3JuoRQaiVqKynV0Qb6b107Up28is+2+jmKfsPtO1TbMcsXfjPZwBYRH+Pn3Wm4sXxWUw90u4
 MCUymcehK2887847vjA==
X-Proofpoint-GUID: NMK6P6saPCsvse4KzZNQYCF4jxq0hsJi
X-Authority-Analysis: v=2.4 cv=NprcssdJ c=1 sm=1 tr=0 ts=6984cf48 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=Aurs9C5G22ztoj5LhQQA:9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260205_091150_242365_67036CF9 
X-CRM114-Status: GOOD (  11.85  )
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

Since commit 1f4137e882c6 ("nvme: move passthrough logging attribute to
head"), we stopped using the namespace to hold the passthrough logging
enabled attribute. There is now nowhere now which looks up the gendisk dev
driver data, so stop setting it.

Incidentally, it would have been better to set this before adding the
disk.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/nvme/host/core.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c12986495e712..3a2126584a236 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4181,13 +4181,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	nvme_mpath_add_disk(ns, info->anagrpid);
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
 
-	/*
-	 * Set ns->disk->device->driver_data to ns so we can access
-	 * ns->head->passthru_err_log_enabled in
-	 * nvme_io_passthru_err_log_enabled_[store | show]().
-	 */
-	dev_set_drvdata(disk_to_dev(ns->disk), ns);
-
 	return;
 
  out_cleanup_ns_from_list:
-- 
2.43.5



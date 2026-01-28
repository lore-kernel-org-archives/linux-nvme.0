Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A430DD25B45
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jan 2026 11:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Date:References:Message-ID:In-Reply-To:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V0Lxptl3OS3cm6Fh7adgGEStwRJAqYjrfPdVSnPP+7Y=; b=2yHRA40gMzwXgBZbCNKd8mKAhY
	3+Bc7vDYgDqtLjxW8VZRXpOZYnX738pRYhuQPY1LiwjIJhGWYUExNYnP53gTFGyUXbHZLscfL7uY9
	CM14mYUYqQ22tjv8hKDxj8tSRqr2ZjTHiYBmWR/5TtV1T38k739Cgl27rmCqF7B4tyfyqcUJ06Fc4
	JbBRFkCdjLVqMruYurBRVcQLbuao+YynHZQ2fzeutXwoVmQzZ4njFXs4k5KHo7iw2WI0Jj1SYVRWO
	sA+xSb6PBEgTrAQatFkIzXvV+L5umUvMNnbCJ6M871VMduDBEC9cpqdtoTrWZtgCELlJAmPTuVJsZ
	DYAedq9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl3ci-0000000FutX-3V4i;
	Wed, 28 Jan 2026 11:22:12 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl3cf-0000000FusM-2MIP
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jan 2026 11:22:11 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S4C1FN1562761;
	Wed, 28 Jan 2026 11:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=V0Lxptl3OS3cm6Fh7a
	dgGEStwRJAqYjrfPdVSnPP+7Y=; b=M3kRIkHhPXa4DoIMG/VgBXOHSfyN94EVwr
	TCv75dPJo/WfLc/ufB00Mbqw/8YPp5ZI565dpugm588yfHuJa+dlViDskJ7Me0hN
	tzZU5QQfaOLRw53ZseUJPtxk7g9t15HSSXPJSgatsXgI2v3YYRgf8OS8Qc9Jg3lQ
	OzSPAegOBLc/FuUICedHNAWhDE0TODLHSCGxRkvfyJCbGqOBC+cMvOJ/SU9+OkdG
	JuSETQX/4Ar9dpeTCTZdYhbJ8rRQ4GTVhpCUVOePuEwvDWxq4vd+mCPM+RtkPVEA
	MGUFNIOb+89DRNtLM+EKURcJ+m65hiPsBErVA/VOfdz6pCV6ivkQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by2vgh7cx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 11:22:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60S9AM8F032720;
	Wed, 28 Jan 2026 11:21:59 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010052.outbound.protection.outlook.com [40.93.198.52])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmharxhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 11:21:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GvzM5/N1xjQI9FsQqvqCLO4KLyqP+L1LGhcBO1A+NVFyo3XzVasrZ80iMCI09o9d9X7U3zyAzZoWcQGCi1bUvUI72z6mDDXnok+JbeXs++OZv/rYHfQF/ZLN31lzI58NYq6aw+SXw/wQoHrNWz45DCXBaYaE2EYjalxJHgMGvUoRub/4HGLocErgl7NdiPh8Vpou4eI6mSOhd6nLGq4pmbDqhQfIAOflTQkG7GPhGlTMNeWbZj0lUbrCYFtVHAMcMipR5LwAzd5JmCH2ZOZeFhPe461ic0yN9Pk0suSxDqX1l7ZC4/FyM+bX10bkhQgxtOeoLD8vk5GHEaY6cWNiaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0Lxptl3OS3cm6Fh7adgGEStwRJAqYjrfPdVSnPP+7Y=;
 b=IoO2Jpbv/BYMEX+QE0ytrfUkmJmMDiNOsjNkRUffUNkudN8i2uLB3USIjCLFH8tilMCRMCveufy7aJmt+XtMnjAE5TD0ejYhBDLQ3+uhCZmapX8N3St8fIyd9MMaApW0VjmFkGp4qNGrkePDW7CmEueel4s+U6CH6dmPm1+NKmV9976uDYx/g4eXGqY+1qZoGiD4MpqMK2ihef+F3npYmr2zhuSIan4fn+rC4Ozm0W56vDU/x+NVEVeiE114oj/A4YpBO4xUlWG/h8i6dq/Ypw7cpZxF95s0jOwqrk842UANiswZYH9/eAmj3WxCGFHcS5l6S0x7ohATLeQL4ipTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V0Lxptl3OS3cm6Fh7adgGEStwRJAqYjrfPdVSnPP+7Y=;
 b=q7L9IHg8Q2+fyaARtSkSe6fU1QJzealnEGn6Eo+BIlL7EHd9abyueTsQrnB5jVWyIeo67O2IqjVllt5EcFONmoEEfSv9PhyXGXo7Ixn8P6g6cQRkFhdRgVyT8HxUgjmtCBXXSIDnUr+13GiOr1MMfCLzXQl/WZ8tk9Wa4vei76o=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SA1PR10MB7830.namprd10.prod.outlook.com (2603:10b6:806:3b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 11:21:56 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 11:21:56 +0000
To: John Garry <john.g.garry@oracle.com>
Cc: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, <axboe@fb.com>,
        <martin.petersen@oracle.com>, <linux-nvme@lists.infradead.org>,
        <nilay@linux.ibm.com>
Subject: Re: [PATCH v2] nvme: stop using AWUPF
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260128082623.3945303-1-john.g.garry@oracle.com> (John Garry's
	message of "Wed, 28 Jan 2026 08:26:23 +0000")
Organization: Oracle Corporation
Message-ID: <yq1zf5yq8zg.fsf@ca-mkp.ca.oracle.com>
References: <20260128082623.3945303-1-john.g.garry@oracle.com>
Date: Wed, 28 Jan 2026 06:21:54 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0234.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::10) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SA1PR10MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aff2419-5177-4bf0-dccf-08de5e5f720c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jzeszd9SWy0lY3Ogs/vlGBho1Gy7Xd87+ExUI2G6YVkHBAiSHZTH7SATf4+z?=
 =?us-ascii?Q?zq7BZPRAuqfgdBzm+egAWZOM0ZG9S/891YKklG0GoKi5CLzpwe3osvXml+Xy?=
 =?us-ascii?Q?MhErBjx/Cm1xmuUET9X3zsdycFeX/mnuinG1HPhaFIhgMILre4N/mRjIpZeD?=
 =?us-ascii?Q?MZKHIjVrskKaGooIwkybNkrnLcwROgvXuaa6bVINMhoPqCj88YpQH7dli1LQ?=
 =?us-ascii?Q?vRlXK4qZ5BSrLuiQF7MBQ0Slo1HKS75mbSEwCekEt5SmMqK6GzshrNLvAymq?=
 =?us-ascii?Q?GMcifTEQu6wDkKEYcnFOK/FHSEhVBO5XCjJGRAEYCycVhEi+4Yqwg3T0UomM?=
 =?us-ascii?Q?oJQD4ykGCqVtv7l8J1MjKGmU0lIv9vmbu/FIsoRI4XtGkfZj1HV5DPzeC9hB?=
 =?us-ascii?Q?Zx3blFb/2OFGTjJO0QK/PtLqmXx1/j7Tke7E/c9erW1TpMlrT9DM0w5ybAKp?=
 =?us-ascii?Q?RPeuygEBANo3ZNkQirwBbJVQoXua7Tg8cAGstCl/0AE/kzS0xIoDLZb5vMkN?=
 =?us-ascii?Q?hLk+wglxBOe+RWM6zdW8z6naIifSy8NNxcm3Mebf3wKgyt2WzMKEG2uBrBBz?=
 =?us-ascii?Q?lYPOVdInEhaR3Yl210k1W4sOY3twTmvIymVTz4AnyA/8fmdI6IndBDcwRNcg?=
 =?us-ascii?Q?XyVLTy6DVE4jcjtVUQTHI2eMEW8Gg/Nax4k46QfUXVIdA31VOs+E/vhQgKjv?=
 =?us-ascii?Q?AKaRJIrqQVG1cYMMuVw+M8NhAW8rgoESP4W0sC92FmbkEXGIB0ZrzfMaOH2c?=
 =?us-ascii?Q?pGh+t2iJ9xyUy8IUtTpUvELCbo97ZwR6WcMyXEzmDVtBcZZlZZcY3LgK+xGB?=
 =?us-ascii?Q?zldKcuN4DO+FVPJg9gm/MDtNtSyEmKwIX5MhOXSObspGXymPgEF9pVhVTxxV?=
 =?us-ascii?Q?rDKpMSffwDwPGEz8dXzwkd2JqS/XFNGPrk8wkOuoz+aFKxtCmsFdbbY2Y2qO?=
 =?us-ascii?Q?Fkl7v/50cjw8N4hU/1Iah1FtiZwW35f26EF1S8WichW1XizYBEqOSJEwUcbT?=
 =?us-ascii?Q?uTTsZU3dzkLf6LjmMNdCGkbv3/jT12LMSf3IjoOZYccci85cjRO71P0oReEZ?=
 =?us-ascii?Q?CSJAH1TeD8il9Yt59Rh1cfykuK8G0s7Piy735ECuhWd+wunMaGGoflDAuRxb?=
 =?us-ascii?Q?ojyncloLHhkoXnp0/SFn+JOgqFMden92iirwG+0qC3lg8szPqI/NMpx22rzd?=
 =?us-ascii?Q?UWVqOK+a/qFLQbKHSjNgRM+Uk45hdfuOuklJuo5pCmfqyVBQ/oJc9uSrAHWu?=
 =?us-ascii?Q?QdFOzTVOOleG0E86xotM+x3fREp8fBMYqQhhB7UTDI2v0BuC3cMHSyH6n0x7?=
 =?us-ascii?Q?nlffsPUa02umbYegDbsWQ3Hmpro06tfWFa3CRGlOdP/tsJBM0/XmFJHj7tSi?=
 =?us-ascii?Q?ls7bpoPQ4Comt8znJRa0jXPYJP1ral1nuW67e3CuyU+/8XSmDRK5x50RDMyu?=
 =?us-ascii?Q?U9fuPwCx25qnF9avrubGo+d5IqqP7wmsJwXLUUyNGjWCDcpFQ1Hz5SVmtbma?=
 =?us-ascii?Q?eMsyBxI3cKa0Uwv8rQCkEYGLHqNim5UspTqImqeXkfIep2A020Q5YdGBulUI?=
 =?us-ascii?Q?q5U65JahnhP+Qmtzqxs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?42hQoeM2wusq6vUfmcyOV3a/uT34IRrQ+rQ+BP37Vz2GEz+jtOgvqWdJmCcF?=
 =?us-ascii?Q?VF5YQEz+cZ5+lpOGSi3h8D+3aoVtta3k4bimyIsYq9ppCJTTJ7G8Vkp5MUGo?=
 =?us-ascii?Q?WarG5wP/nSJXexgA1v5CBQerLR5xsGLPjhDUkMr6saeMHnz79ZOrspVrJVh5?=
 =?us-ascii?Q?fUvkcOLdAb91FYD2LQHhX3DdgHeg36kKALaRNmG5t6juspX36z88mhTGc/rA?=
 =?us-ascii?Q?AV0QW6t5fhr3tWqEL+I5Y2//zBx91DAGoJYVoeDsnXS0Yn53dsXuNdy+tUMP?=
 =?us-ascii?Q?Rse0alN2YjjhuXXGIjJpI+jyAxWISSNTxi/kaBeFH4F97SlFAtmdq92uOIzh?=
 =?us-ascii?Q?86hmmxcApGBuO5tEpxrOHQk0VCB4L3bkhEE09H0L/7hDsqk51goRBuS1unaw?=
 =?us-ascii?Q?7T5tZpxVSPhpm3XrRBPO7r9M7tlLvKDaEinonTaRQSzzazOQitA9t4dH6GL+?=
 =?us-ascii?Q?ityLqlhH+G6OuR6fRbxWX8sXsQPljdIELTiKmlwtmYxOnzHMqjP8DdJzt+0M?=
 =?us-ascii?Q?uXcabGWGnHgwDKJm05r6pdjf6xRuxnPAM+7a0xjtOr5U+b/w509MMDCvC2Gs?=
 =?us-ascii?Q?CBckeadDWwhAVXBiUUXkCGlKSYBXJJeXt9qOT7oBUL23MLaUDulmXewxbvmC?=
 =?us-ascii?Q?IfHsTkMoJH7jcjjYTX+vxuOAekle9VpfzpfrgruA09szsjtyP2sax1z+pTm0?=
 =?us-ascii?Q?xWqVf3/3YveXE5wXyLNB3mGmiW8O43ZY62v5H8dIjInctQltB6Ke/p+zP1qD?=
 =?us-ascii?Q?EhFH6jXEeaHTY8/qvBrTKJm+zRCdjUL71uqOFaBI1DO+2wml63V3pmkYOSL4?=
 =?us-ascii?Q?Yp2rYxvoN2Nph8TxSFW+Jxl/sbfskZqTxY89KBwpP4NZslBBqQelfqncPqv3?=
 =?us-ascii?Q?W7Q7jx1OoInQxGYqZ4Kaptazb2M5R4pGgxKVTN7haAWSIEc30qw69PQOaePk?=
 =?us-ascii?Q?JmyrRgsoN/BUslbaaf0kz6XbZ1ecTlHNj2PYeRRYwiFpEm4YCtiZIX8MyKwQ?=
 =?us-ascii?Q?EYhT3tveTI/LcfCJ8zSzD/1bqrT/LRE8UkarH7TV0nxZymVukZGmHMKL1Dhq?=
 =?us-ascii?Q?QSJf9mCIkjpQmMXxWT4IBw5KDIRsAE88BxK/SKqcujAT/UFf387uDQDviFYz?=
 =?us-ascii?Q?v8tn9ZsJr+/97fk8Bd1tYnKdInj8E2taJQgESGgPBwc5Tbac8ANMXpawfroE?=
 =?us-ascii?Q?A3ZYHYAm30bCB5kxPmeiRUImCcQ1YGxTJi2cBCIwcD1ly5WKlTDAScH6AOC4?=
 =?us-ascii?Q?u7E/HDqzTqrvg4U+lm/x4uIXBH/FoeD1wVTvF+Q6+5PSb26B/P6oelvF+9+W?=
 =?us-ascii?Q?6SfPuQZG7MoJ5O8Rre8t4DPpxv3y17p4CtxyZQvqfgYpmNCrm1+vpvWQG7vX?=
 =?us-ascii?Q?vPGgtn6BIA/oT9zimtkL2a4px8bcDX388pAGaPcIGbOeeyo4bhr4HuhvBrZz?=
 =?us-ascii?Q?WH+RTZugui6pBTcyH3FDgv196wag/1cBPYGpc2pbKgjTbPfe/MC68O+Otz2f?=
 =?us-ascii?Q?0xEkkj+N++NVJM4aoq1N420NQJq1h5jXyJ2sQpCgFA4SHd8m7A5TtyPdK4LO?=
 =?us-ascii?Q?N/1eCpXLUjSmN5baA4Y3aXs+Yh4N+/t1jPqcEqybNsuWh+ZlOUWNbrd4hEVZ?=
 =?us-ascii?Q?CiKPTFBXq0jV6hX1K/MA7saSzQhjz5AYXfKFc/5r2pdeEO2gWzrYalpZVLaq?=
 =?us-ascii?Q?2smV5RXIxhxY6FD03kB9g4XTT6fvsLwZi7pTju+cjCFLTAMbYd7c9gQ32bwk?=
 =?us-ascii?Q?BJ7rFxUdM5KMTkGKvkxxu/3tXu2UFL4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jF3k5KE3iANsnXIbC//QJItmhhU48PUujKz4DGjPQhlreUIwfnuzO2Hx6VzgyVmr5iIJ08EwD9bdJH+rPifgDUOlfOQQWKknsinWqwNudQW8XwrrmxCqAO62b9BuKMa2iW1h9TSsOA3OfDyBZl80AXL/RudecEA3f0R6G4yvgr3DUHNwe7qYeIKKMnpIMcTolAUvm7nKky31kcEZOmpnhJxEjRl9/ib856r3URLpLT2DsdBvbCw2052QOUOxZSFNGpjBxPItkC8Psz2r2+xct4naGEAkz/7rOx+jbr5lKRw4A0FKeLRThUDa3LXf6VIgluS1uPqLSxT83lIs/HGEZTAWc3ceTx07b8YkJ0Cl7bgmaP7FzGSb1YEE0PzC9njkFtml49zMglawNIyaB/AHOQ/lS+4Z1byG+jhfkwfwGxidrkZpCT5L45Fow4wV7BIh05um96nZE7TpIcpDQoJxjc6VK6Zovjh6355HeCsmIe4XazPORqzkSM4YY8kamJjEe8U8X3OjOjMqxIcECwKluPjM9V0JAodIccJQFORbdTkjWMQkgdPd8LIXC1dBkSOj5ZitF3maW8ICvX/WnNWD+ldwk5DzWJA48FxgobouGKQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aff2419-5177-4bf0-dccf-08de5e5f720c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 11:21:56.2890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHtNIqz9yYOgwoPd6r/qK1lqIlkKS3CwuWsst7fE2reFN2AwObC576iZCJycVseFPGByZhtp6qIGYQHkluiHnMO0yh01G+R5IYscHbV5uIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7830
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_02,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601280092
X-Proofpoint-GUID: 0ONPiR1tRFukPshUpwLX2kngGbJ6Tgir
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA5MyBTYWx0ZWRfX+nZH5nFoldCQ
 m6TLUr10ti0stSGYnjt8TZ9P2loYxiaXwjMI1+s5lM4gyvt04au9KfAa4XtofhSQluxE3l0y+XL
 XULNVnu7ihPenGWPQsa+H5bR4wXq25gH2qwsguRmH2VxzuoAjgHKxASrm7N2R1tUAMeL+F+xlrN
 jGY9ZfZ5sMqyYxWj2PT8LDVlJNZlLnIqicawAecPEpNq9PVKjJuxQijJ/xc+QwViNZaNHKxYhhI
 cItbkz4B/7tL7MRoQ5uiVUvnAZ02/8oBimz0iDs7XyVVm7y8yVYEc/VpPo2+Hdwy5/TSGgcNMWJ
 YW+0l7dfgRstptW9okIdX3EA06iqdfitlJQdvlOVbnQRT3SkfZzuK2YvfYAvRXzeZFvHikuYOP3
 H5yabnZI+g+lyNt2f9Xt3prqsP3ejmmkq+HZejjW1Kl1rWeygCXKSibW/5jx0FygdEgXRCLdiU+
 nCHAzrn5dFWHqLzCElQ==
X-Proofpoint-ORIG-GUID: 0ONPiR1tRFukPshUpwLX2kngGbJ6Tgir
X-Authority-Analysis: v=2.4 cv=a7s9NESF c=1 sm=1 tr=0 ts=6979f158 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=rK0u-1Cmjx0UNFfH2q8A:9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260128_032209_941210_04996155 
X-CRM114-Status: UNSURE (   8.47  )
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


John,

> As described at [0], much of the atomic write parts of the
> specification are lacking.
>
> Since AWUPF is so poorly defined, stop using it already together.
> Hopefully this will force vendors to implement NAWUPF support always.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen


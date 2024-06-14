Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A854EC27C4F
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Jun 2024 02:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Date:References:Message-ID:In-Reply-To:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L2JvZcH6Oecvv79CD6PlnQ7dTBdds23OcdPM088mkig=; b=hd1qAPn2hFjamohVT9WXmf0Yci
	nT4hw555H/oOSqOB+yuskENENjTn4NJwLSkd6GHtEfhhTc4E4B9uSXn60J4xdpsNpfF9Ex/TIVTor
	tZTfKt/1Bioi6MxY0t12552y9ANzWNY5BU4/ueU0yVfKRyFPOIulEJFcoeWyJ6QpqBhvj2cqzMhN9
	5Dhb2ZEYxsVExZSduyYgPyJb92XdJ66Y0MEHaKBIoMz8L60x9nzvw/6d09gDhVUkN3WtD+O/QNt+1
	HIskmaHfxz7s8CWNibXUiynFOTzb3by8LRWahcvrM8VnujsVZV0DchE+onYpQJMoRUVzeax4o4imO
	iXEXZbGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHwIO-000000014KN-0ABY;
	Fri, 14 Jun 2024 02:04:04 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHwIL-000000014Jn-0sS3
	for linux-nvme@lists.infradead.org;
	Fri, 14 Jun 2024 02:04:02 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E1fxY3029966;
	Fri, 14 Jun 2024 02:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=L2JvZcH6Oecvv7
	9CD6PlnQ7dTBdds23OcdPM088mkig=; b=O9uGIkVQkxEb5UxLaeSXpD5uNtjPhQ
	xghbBkMTTNTN3u/lhwOlwJRridPoydmSa8ljblCS0aC9MKIwhXoZIEV7tB5JdMIQ
	gWaFv8gUBLUobZ1yluujPnkGzqVO4PmLcWMAuGkpg/yYbcaj/FBOrxrsPRJLkjWj
	hHRInuFcJzTVMZbu5E+mlHSR7F8NJP+TngSphDA5JdBWPzaz9Irz1WC3OjAenAva
	gLxROOkuKqEfbYbqAKtJCPSaZ8x25HMcboycI8ynarYlBawlOR7V6C0QyBimjf7Q
	IEB/SVHWRLa/TMm1Kn+qPy4pIvfESAVVTGJBk8xgwWur7Uc3677BObqQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh3panxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 02:03:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45DNYfMb014346;
	Fri, 14 Jun 2024 02:03:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncexqvw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 02:03:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxUhD5UVHhTCxber+Labm+uWNTP+EMIh3eGmXUcmPYbdRSim/F/5xau9AEACDiP6lA9lEckVt/XMh8AAOKzhllgNo/RYT4I1N523uVY0184Giw51JyywqUIYhcmAVEHrwtNX7Rua0pArTfeInrRmWji7ZbAfJr7L7s1p2+mVi09Ryfnf0yaMWE6JELUsWjVJSM0QYceSpl2iP2IRdvbDXaPm9hrE8o1kPRyQNF+VNKc0d/LnBCLn9tC6EHkR9GwFykZjgeiHcNWd5ZM5LHNWkxVIGcSBPKqgjohF5fZVLfcP2QSzQeTRQsl18Om1gTTRHUtzOwB3syBW90cHrBvWJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2JvZcH6Oecvv79CD6PlnQ7dTBdds23OcdPM088mkig=;
 b=WKzL4NlHEDNuPneIeqCn0Kayi5lP5e9X66HOY7uttP80ARU7rK9zeA4yLGZfW3oe13HfTyTEXdoevg7apPT+ZqrYA9qWdZXDCpOWkoONvTDkxUezG3cwsqeBlkSPOF5i9d0t5FoH2Ks3Khnfw+j59RvxfBcyvC9N0OIcMnV/DWuW9/xOnRTvXVnFYcK7HCBbTUT6a7AwE1broVIIaTHt9w+Rd1rEYiRCWxKRiE+pQ6tFaLMot0nNHZg3DHuU8A9q1DVrfozyTakzIBSOcygI8iBMuaGDziDDJEbf0bEBD2Q3bkyfqSkwQ/Izdxqp+Gp2fJG71SKsFoyYMFa3N/6M5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2JvZcH6Oecvv79CD6PlnQ7dTBdds23OcdPM088mkig=;
 b=uQXY34C2hr3/XiQajyIs6li4UcOfSlz6KcWh+gnq/EVaz7NC5mXq/rLw3eCtYwneqlQjoV6yP3+xF4yGHqJJYvdXqSeZfJdzsr9S21ca2Nz6JMt2OYylXApMZXRjSDplhYUsCxGUC89Q2pE21y8Vs1/9Z5Tb4z8RNfjr2cxxXSk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4607.namprd10.prod.outlook.com (2603:10b6:a03:2dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Fri, 14 Jun
 2024 02:03:42 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 02:03:42 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Mikulas
 Patocka <mpatocka@redhat.com>, Song Liu <song@kernel.org>,
        Yu Kuai
 <yukuai3@huawei.com>, Dan Williams <dan.j.williams@intel.com>,
        Vishal
 Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, Ira
 Weiny <ira.weiny@intel.com>,
        Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
        nvdimm@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 02/12] md/raid0: don't free conf on raid0_run failure
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240613084839.1044015-3-hch@lst.de> (Christoph Hellwig's
	message of "Thu, 13 Jun 2024 10:48:12 +0200")
Organization: Oracle Corporation
Message-ID: <yq1cyokqo0e.fsf@ca-mkp.ca.oracle.com>
References: <20240613084839.1044015-1-hch@lst.de>
	<20240613084839.1044015-3-hch@lst.de>
Date: Thu, 13 Jun 2024 22:03:39 -0400
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0017.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::30) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB4607:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf6119f-c180-4893-f5b9-08dc8c163732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|1800799019|366011|7416009|376009;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PjaRRacd58kOKjB/ajMjIwiRekPB01rQYygaSgahRQMXIaRL8IWj6ECXgirU?=
 =?us-ascii?Q?uK1zzH1D0d/BQnSefbh9B4Vp7xDs/RH6uUR5oC5KDMDP03OrYRoBCRqpZUqs?=
 =?us-ascii?Q?opUQxi/jER3PskxJY0xHWt5U6EzvPOCVjiQ0jXlmcEXXfnqVd3U7YHjT96QH?=
 =?us-ascii?Q?ZPlKGSn0RDADHjoaQQ1CAj3XRjcW8RIjC4Q2IUtRYlM5coFDq9+kQlmu7p7/?=
 =?us-ascii?Q?WAssXxW3WFY/bhWyUn4N/oiyYfkeKlu2xH5+KE4RDxV+HGB9EWTAILyU2YFm?=
 =?us-ascii?Q?8F8VXSA+87IcBvDTzqnLbZwIWITx4hQVWDvqSz9OAEChz/V0IloLBMw59RMo?=
 =?us-ascii?Q?C7wAWepEE9nW0maV5Uf4No3Woj0Pc6pNAON4kDeDp3As02hg2OL30k3vsZnu?=
 =?us-ascii?Q?bK7gpw0NcciY6KsCLiZzLn2lkPZaCqMOh9xNBvW+BmHuqaM4gdKXwPIpfvx1?=
 =?us-ascii?Q?5Wv/jmkkXlk507EYE1uniT/24IeC5mE43KTnuaBQtVXfcGU0AcC5jbj0spWJ?=
 =?us-ascii?Q?MGVglgV8S+Mp0prWNY9OaCUxaabsK2yZLZ9YYYF0QzbbVJlRs5XSp2NMRUw/?=
 =?us-ascii?Q?Tu2JEpyk7l1bz2g8xO6+FPRBSS9fEtALziuYaL72EJMU8yd2LTLI+Rz0YueQ?=
 =?us-ascii?Q?tT23FIpcvUNHbBuGYhC9mt++MxUBIo29Iz9F45D343Lj5wjkRSaGm886a70V?=
 =?us-ascii?Q?IEzO8oxuI6m39f0IlsMBA2cO9F0rhSKbKq0Cm+3dD1/+BfcjjBU4QUJsL0gy?=
 =?us-ascii?Q?NpoUn1+MHkvbKMY/wIGMrwQgCDPbV3MlNV39teA29urw0AqYVRCh69f4IMH9?=
 =?us-ascii?Q?VJcyaVpUEr2aojfZKwE8s/GnZDK50y/uNtd5uzEcPzsa0nEQxR4QZ8032Wih?=
 =?us-ascii?Q?pMAsz8cadREEorg01+PG2LtQWoPPiABStdjQatKhv3e6E7kDmgtNd1CKUxVO?=
 =?us-ascii?Q?TohMdWeauCigPJWwqjjqj0d7aDwBKmAwcgbTJmFxTVtZ6f2uxVec8Cdk8Ucu?=
 =?us-ascii?Q?X5dGfhTXKhbbJtMYRwn7KZZJuFNy+WEhDZVvhbIFtkjbhxSsfa5DeQVA5j1l?=
 =?us-ascii?Q?WYQTh7gJYrabrusLbKR0ypkO27eapImHv7PyStene5FNJPa2TM0T8uZSZxN6?=
 =?us-ascii?Q?OBlGGTrU3/6K7EX32dYQegZrbmNd652pNzqaLlT6JQVsb6GY3Fw/Cc4bm2b0?=
 =?us-ascii?Q?4aQlHm2Bw2sMFampYGHfkVQVn34KJayQjAUSYmYgW1F7GLHc+iFnopDf403w?=
 =?us-ascii?Q?a6PuxO+JC8mGX0qLIKEh8glXiFHsjbVYBs/UD68+xTzMLbiNZPDFIAyZPaFz?=
 =?us-ascii?Q?FIk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(1800799019)(366011)(7416009)(376009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CFdk8vJReSbktJ/NjaB8UsN0vQELxTj8j2FJEFOVr9e3fnnr0e338p42V6AG?=
 =?us-ascii?Q?AEjmvI7K7FqFzljbPBY6h+AMEbTjtAeg38Sjycn/NcLxHWxxADjKxUINlapS?=
 =?us-ascii?Q?eyDbGNVtDqoI/tfljH255w5fcWo57Wkl4lj4Poudobz/q3iyPj0PYMczk+7u?=
 =?us-ascii?Q?kMPFy927sFZeqP2RaHyumRbY3/3hSrkUj2os6S+zahzu6k+OZI8NiopcdQjx?=
 =?us-ascii?Q?YEU3jJsc70LN/6b/VY8UNMYlGKx2nz5bhJ0FVjauZxikntM5P4f8F1qk2/mn?=
 =?us-ascii?Q?HSHKXOEAB1nFT4PPATiPvo8M8i4HprKsE2bfAF9wrCK0KdgLkoKDkF8zGFs7?=
 =?us-ascii?Q?lREz5tuMgLT2F+dtPkxQlpXuATY/9S3H4QgyTuesymLZ8aPn9Lf0oIZgg5TE?=
 =?us-ascii?Q?BfufGWn9eJ7dHO4sU1491RQgEbmj7hGQi4RFmJ2JTn2pyolhe+N73SIHwvw1?=
 =?us-ascii?Q?L+wa+Y0KA97/3LfVp6Lvizv7LTNZ5Zc0e30Szo6OoulaVOZYVXG2ewnR2dyx?=
 =?us-ascii?Q?yZznhd8wlEwBundl3ajNNyhU6/FE9EyNlUaILrGrxhbOULfDEQjCgAB6ZdwZ?=
 =?us-ascii?Q?Lalitl87YnQ1l5ehfRhHSfQW3ABEhGpttcpGlBt+TJhcnU4CX5N95FoI+z69?=
 =?us-ascii?Q?tyNQTIcpPrskAWUECUFamgtn8yfoahP9INGjVibe5uSJHIXGJpzwxcD1/ezY?=
 =?us-ascii?Q?XtD6h32yNC9fMSDHv9kOA5iDiEECz3CUK42DYVU+CaqiPLqNuB/kvAF9oE8l?=
 =?us-ascii?Q?oIrpQ/v1Hc1dFWFumXmiIT1oHC+AK6kNJoq16VP29gq2lUntEQnkbkiR41kC?=
 =?us-ascii?Q?LPemq7whpTI6E/s5jEs1uNYTYoq54dkG0aptTSp/uSECKeWa/qx+SDbSypYy?=
 =?us-ascii?Q?Vppk5WqdGSCVqqi9ozTp1YObtAPEa5lbGhtFB/w3b/s0Io7PJISCSEud8Zqf?=
 =?us-ascii?Q?Hwq2cJcDnbYvbLz8H2+J3R6pWg1RdsV374vbrSCv9FePRYY1twqBl/Y8COrg?=
 =?us-ascii?Q?2/IRnuVVmi+sPjwOQWc1uyi7AAJNAbY+BGb55rvNIKNM/oXBNy4CsjVKe5h4?=
 =?us-ascii?Q?VbolFmQKN9iZZVPbj6gE4ogj0ErOn0BOQWxTiBTkz1c1bCQ/b3AtXlqpNizW?=
 =?us-ascii?Q?1RKvMXPQoeHOsa4C+NsnUgf9QqWSi1Qx/Fo9yLEvw/U2S/Pc9tGFZ7WZ3Lmc?=
 =?us-ascii?Q?9SF0ER/UaKuUjJAXhz+6MtDvT2XMLiCf4DbGnUJJz34AGfrSXCV00qvuVqcb?=
 =?us-ascii?Q?pU3IAZQPO1/Nsw6mv4oj2rzbDkFFRTS0ApPwfko7cvrPguAHt73p1Lx0IdPq?=
 =?us-ascii?Q?Isk9TZ6YakdN/L5ISIu67XfsGNhhiiXAfIhCjntZ18oZHgiUPAI9gxvf+Rcu?=
 =?us-ascii?Q?7fJe2X+5PvqMn1x15cphTmuTxMsWzKEh1dGxUZTGOyFDmMAZKXsZt8HR4XiN?=
 =?us-ascii?Q?YTWJEN0MR+KQTe7ATKW1VeRRPmus4kdRL7w423SwFo06lsNiF4zpZVURDkqq?=
 =?us-ascii?Q?SxMs9jl+/uNe7XA1i4tY7LXuHqnocCtd0YMwoOvKrSkCXTHHEmerDArUdcgD?=
 =?us-ascii?Q?Y6w5WqHpJVkrar0tthP45stIsPPX6kc1SERc1f3i0dTyz2hPUAjlKvrzbQd0?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: DRLJzbxsvFsHCyC2+ueEe89c1I8QkwRDF5GCWx4OkKPljA5o3LkCy7Hr1wKN+SxvGkbeYiZEOE8z+5+pRTk5rwdlzNkJosTZmUdghdfoZKp6P6ufwbEB9383PBQ3NAvvIZLT8LlnXMopuzE/ZG1+opZ0ZahV3zddv/j4r2OMsQHjAM55uM1qxF/T8z3Rcd0oUhOuTJk8LxNN3ActaLwLvfFRAnwPKcRSD12fRUU/qLLDq2qq2wXhRObcCb6pQmexquAuOl3ZoPhhCQVZ0iuUEvpEbw3x5707sIZ2ueYUaix5PhDTl1iOyGDPOYxo8kvD+hitZ8B0ZCajtKRofuai9Uu+mswRAos9qHsv0CjBKO4qUwCGwvnnWZRifsLu/p4mOjdPAcEt9FmUxbA80Ot5XtkaqFnKFJJUxCQOrOA6N3K4c3Haw3ZasEMGzca3BSifos4MEZrYVuZ+mosqk/yQN7ZGGtzckFwKzENUplwUJ6FQJj1pwcp8sqLNSMoCxnNjwlijOO/uTB7aJkO6r81rhtUtARUvu6YfN4IFA0W1NOyNssDlZAZ/sre8ePCwyjtrSeKNpM+xcexybrA/lvhaoLW+Elp96V4KLlIHun8u82Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf6119f-c180-4893-f5b9-08dc8c163732
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 02:03:42.4008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aNKzzzPTNSpTAKI+D5ZIFipEjmS04qy+49GeOtRA7EdS9mkBEjLYqXJfx91kjnRP8BZl3tvIX3wURsqdqcBTb7eGbTX4lYdl3IUASxTGbhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4607
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406140011
X-Proofpoint-GUID: Q89Gs1L-X5OX3gNw73129Q5UcSRTyXHA
X-Proofpoint-ORIG-GUID: Q89Gs1L-X5OX3gNw73129Q5UcSRTyXHA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240613_190401_411036_247255D3 
X-CRM114-Status: UNSURE (   7.92  )
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


Christoph,

> The core md code calls the ->free method which already frees conf.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering


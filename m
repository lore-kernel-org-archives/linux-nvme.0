Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F01BCAC59B
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Sep 2025 19:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Date:References:Message-ID:In-Reply-To:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=haBVIc9w8NwxkC+A3yl/n+YSrrlsDvyU3z8lZMHtM6A=; b=i78qTX9hsZJTXhlm2AZLS/7Xpl
	Zyh99quh5cGHo6CnQcS/Cr/B4COQv9vnI+99ZZ4RxAvRMotVQC9m2R9wBSbmY0VYXdLItPESOJSiG
	5dMpj9hHv3XG6qE1Niq2b2oHyQcWyHAjd9z+WFEWoKNxCiIlLhOo4E/shhLjhR4C8+UlXYqK0jQKy
	o+vgWfZT3RueyOr8/bw3hYkdYbHLcbMMlcahX1txAV62yGx6wrmEnnTLiFs5oclHJUZtxne0KQUMH
	c0Uu53RDvpPnqLB2NvfuB5Xs2haqL9geFiv56X5DINNA8omHTw/To2rLc7lApS92EnAjWKZgD9ijK
	Lyxe3prA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyayr-00000008pIO-2Cpk;
	Tue, 16 Sep 2025 19:04:45 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uyayp-00000008pHD-11GC
	for linux-nvme@lists.infradead.org;
	Tue, 16 Sep 2025 19:04:44 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58GINMF0006703;
	Tue, 16 Sep 2025 19:04:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=haBVIc9w8NwxkC+A3y
	l/n+YSrrlsDvyU3z8lZMHtM6A=; b=I3TFgdXBXFjta7bScC6kJ6syS5yCi3VMAH
	+Y7HO1t1vEiR9R6yHm5bNLp86vg1rrdlQJeBtkpfPBIWCU7Uqigf3zA9ZS7MZIGw
	0/IFtLxYk7h9f5BHTAxkQ3BMe9f0hWL7MBohNYAYtR8E0EzLGIK5YZZAJnsRVAyj
	fkG7/GzJZqlP8Gd89UbVZLPlmUDorICxA2aVMq9/k3QDRah265KYnN0Imv702FaG
	HYy4KRUS/6P3kRWPow+E5mHyKZ6KYXXyEz1c71zcDqyWPcf/SMH53d0YoBnljQkb
	YwXBKnMYeLyIiFEb+9GzL+at3ZEdthJRVis3nVBBnbTd96ipHdwQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4950nf5fh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 19:04:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58GItCGR033679;
	Tue, 16 Sep 2025 19:04:31 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2csw99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 19:04:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tBPRQlW+sguftD75RHlhai/Ob3C5tsNGBSPhl+Gkf9GcVYOp17zdC5/IJPVKkPudhqleQKRRGgofeAsUM2qjhzcO8q7kFm+0nLbUSTRAy+zHageKOKygITO/rJuZR6usbBQSogCCJpjDYZ6mcLJYDIk1flOVMYxo3GiwEB6PQ+eIBWXXqyDgKJ6zFG05V5JrgGxi7ME/uMh8MrS4KW1hRPV6ovvQfowuGLQcUfGPRJ3nt2oETTWFDqVbWw8G77lHF5lslPYhXZH1A/FRQcovb33MM5WNZLMlmm+P/bxVYyfmjWtLGZs7ukFx6Uqd/BeEEKk+hUvqigH4/1Cbtir6lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haBVIc9w8NwxkC+A3yl/n+YSrrlsDvyU3z8lZMHtM6A=;
 b=SFnITup0/IBPkZnqo0P2PjSjXfCkYtMoR40GauU6pUsSjwEBWsb64Y6UhWZEP8MbxK37xpIyRh1XdsDT5euaFEQhHwNExlO805ptHZ03OELMx3Ol3PumXMYTbyhr4fijmjPTMXcgjtDoiZRw5HG7S4bUoORVGWBnHX8kYjIZFJApM+rwxN8DiHYEWUy7E7tSphYosmyhLqd8QguOUT6fmmlEnTWf5sSTyu+PGpc49LOSIoAnc0zkpNqNRBQ5PT/J95/FcZOurDQpBwN/j2fC+qoOJ8XED9JuXQ+sxF+RnUs8pkLIo6Gmupte85SfD9bV7D5CioPo4faVorQjk6mByQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=haBVIc9w8NwxkC+A3yl/n+YSrrlsDvyU3z8lZMHtM6A=;
 b=tPWWvKWOy1Yfd6BA5e2PkceEMfRRfwU/nOa1Ht6PSwuTvSI7dVXoRV2aaVHiESxlEsyx+icDeaFQP1P8rTUrUV17pCWGHx03nBuxmOtIgoZ2kJ9f+/z6ynDk/NNsTwCPm4SmiwcqXEKV6mj6u79ZvWPzLsSmHFR3yy+jP5a10Ew=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by BN0PR10MB5094.namprd10.prod.outlook.com (2603:10b6:408:129::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Tue, 16 Sep
 2025 19:04:13 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9115.022; Tue, 16 Sep 2025
 19:04:13 +0000
To: John Meneghini <jmeneghi@redhat.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke
 <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
        Bryan Gurney
 <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        mlombard@bsdbackstore.eu,
        "Ballard,
 Curtis C (HPE Storage)" <curtis.ballard@hpe.com>
Subject: Re: [PATCH 1/2] nvme: check duplicate unique identifiers in order
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <6791b6cf-9f54-4f75-bf78-7ce513902351@redhat.com> (John
	Meneghini's message of "Fri, 12 Sep 2025 16:32:33 -0400")
Organization: Oracle Corporation
Message-ID: <yq1plbqz1aa.fsf@ca-mkp.ca.oracle.com>
References: <20250509151627.20434-1-bgurney@redhat.com>
	<aB4gO7mAYDO3Bm3A@kbusch-mbp>
	<cec53fce-2f1d-4162-8685-ab7c56649953@redhat.com>
	<aCId7XmLnrLWZPdk@kbusch-mbp> <aFrBVeEcapNtOvPx@kbusch-mbp>
	<1352e125-180b-4ec9-ac3e-1cd8570910a3@redhat.com>
	<aHasJPv2Jb4bQ3ik@kbusch-mbp>
	<da450263-9944-45d0-aa58-f4f606f88c6a@suse.de>
	<yq1a54wwiu2.fsf@ca-mkp.ca.oracle.com>
	<6791b6cf-9f54-4f75-bf78-7ce513902351@redhat.com>
Date: Tue, 16 Sep 2025 15:04:11 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::14) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|BN0PR10MB5094:EE_
X-MS-Office365-Filtering-Correlation-Id: e3e31e26-b340-460a-d17e-08ddf553d33d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QreZH4R+PAPPa66fCrBekAtrgYJxirdnaLG/NVTo9u9Gz2iet/nDZmpCfnIB?=
 =?us-ascii?Q?SXgzxYRR3gXpsvvuCpDiz5mG9b1ajvFWvbZkBV9kGwdlIS3qzqOMl581RBge?=
 =?us-ascii?Q?fnWX6kbs8oXtSqFbjbBKnEr8g4eqdmN43jyEbbPddmWfFsp7jnRh9SzXKwxr?=
 =?us-ascii?Q?aqxYcySOv4onnf9JS5WpD2UXtLVRD6fZExSZ9iQpD3HDwLs6UGDXpIvWe2wJ?=
 =?us-ascii?Q?dA3UkF1zIrTSo9CVWE47b6oew4ZY7vyWuef8gWwhqE+5t6EDfxZ/oHLTP5kc?=
 =?us-ascii?Q?Y55AM7iY4qCuqLcwR20W33oxlvslMUjksFdz117d4YRc8qqGQBVjpmHAxZHu?=
 =?us-ascii?Q?DP3NAJMlbScPNVFrq4QY5VLi71Boy8pUyXq+65/lhwvnu0FjHqT05G0PwzVO?=
 =?us-ascii?Q?rcs7NbuLyPvYVPJOBL/m8FO53m1huS+ufJNON19/ScbCC/8pYyXnlNNaD6X4?=
 =?us-ascii?Q?/Ny8cFZOsZF1do3oXmdRjScK2CztRu1guUphvJxzHUgddriRwsoMx85o9lx2?=
 =?us-ascii?Q?yzUyp2bNol9QxF7QqktRDidaJDQASTRpW1u0Dc0J6XE6kUSFsUj0xwece4FR?=
 =?us-ascii?Q?8AXO/vHeEYdRV+XpANdeptFV8A/r6+ZXlLBZXJG2Q4wBtZH8YYOWHUChMtjD?=
 =?us-ascii?Q?/a86rDCQo9MzmOj7IMSZTQw4TcQE6wgj2smR6b9iWd51jIFMe50TmD2o8iJ0?=
 =?us-ascii?Q?fzHIb1ycBcyc+TZaemKZ+sLkwkU26an9eHW7OwKoLWEV9QayudSw5fGtMXCp?=
 =?us-ascii?Q?Za+NNjLKnD6TLZ7dEAP9dmtwEU4hdH3TosnxdyWUcn298FazR30ozlU4vCzQ?=
 =?us-ascii?Q?hbk8UvaROkc/3apTTiaZ13sugZdvoS2nNz5kZb2XVnZ5pleuD5coe3C73g/j?=
 =?us-ascii?Q?5vHuYrlr0ETFEu8R5Lz/Jz5UwuEZ7eeRBopECr8KSKouk2wz1Iy/MbupCvAx?=
 =?us-ascii?Q?At/KY+EKe4lreR1i4kqM9gnREwpcGaOEYw0h42oTnoPGWcd3T0wEJ0Uw1vHe?=
 =?us-ascii?Q?9pNmrQsOToPFG1YwE9fIGHwBs8CUf14d7fawGxl5pXsm4qiQXqzRwWOnmeDa?=
 =?us-ascii?Q?WOnBqhYMVwIbDXlhaoo4uZqF6SuV/JrDZU7AQ91H8c2BMbhM/vJdFryLch8X?=
 =?us-ascii?Q?0ZntMYYLIGBEJzrY6D9H4YVky6EX33AX7PoYj/vHRsY27v4EH3oF1oRncHpy?=
 =?us-ascii?Q?uADb3O9VC23/HZ4CkOfpJAR6WxzI5OsePKSFqFGs/azNnWWLpzYK3xq08PBW?=
 =?us-ascii?Q?mzZUKGUJwgu7MleszyZBnWtCf9k4AVrWhO4QVibm7DIACQaiVdMCWEl8HjAM?=
 =?us-ascii?Q?lfmWz9uwhirmoZZM+PLOP/o4NXTocjc/5Jyi5j2OousYpRZAXx67yQtkrXH5?=
 =?us-ascii?Q?aLAi7LA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h19gF4zdBHECEipVz96yUJSxNnpiYI0M36DeBwxxdR8c29uLojPuG45yD5x+?=
 =?us-ascii?Q?bQegyEJsbyckdeP7buaFAsvR40nEtdFwKD56RqFzHnHyrPW7cc1EL+E175YF?=
 =?us-ascii?Q?brR7VQo4TqlFry1++uyF0atBrrGk5tt6cEFDRLM41kGct0HwYxG9i42GA484?=
 =?us-ascii?Q?fNDa0+G4qFmmrnaQBTOn3w+38VC0pzdVTRF80OClwdJlHjf476Yz25oFT+Fn?=
 =?us-ascii?Q?7xbAill7yECMpPoeC0cII4FbfiqX0S+RggZ7P5fuZzRrrT/iqRTrYNVdJIVV?=
 =?us-ascii?Q?31UzbYd2KwfVfUjsaNooAuhhUh4aSGCx4kCFDBTXOIh98BvM+QnkgPt8eFoE?=
 =?us-ascii?Q?7pInxsEJru3BmA1nICFnq+yfo4KVhZ36LTPf0SX17LyqDWhQ9MP+EM6Q4UV5?=
 =?us-ascii?Q?iDr3N7tjr5exdX2H+HeV4NxmYHD151FmfD24ndtwK2INF1Iljjts1CkRC0Hn?=
 =?us-ascii?Q?M+4oTA792qmAp1eTtgPwWJiuhHGfL0LtsAN12lqLGYv/KCU7LeAjbY5+MW0t?=
 =?us-ascii?Q?hZdiKWolX0cE2IRDwfQAR8Ix+hK9piy8dRomb9MvQiA0n6ARAN7XRJX0GOvR?=
 =?us-ascii?Q?14qln91yS+L/4sh0qb06doPR41Tb4+28I5aqZADyWbw/yjmGm3ZPHySQ4Jev?=
 =?us-ascii?Q?GmPXH9VKrkF2xC1jUDomYAfSRjLR2oinNNnyC55H1sj4G4gTQNV18jwBzJ5U?=
 =?us-ascii?Q?gDFuZUob/KBGZAoAO7lPsZ8Zu7KCEu8z96zI62haUQ6/NzxKOwbwGcCS1Vgh?=
 =?us-ascii?Q?IFYMYUB1+7ro1xjOyX2YIk+qK+JSDJdhvJcaokFyr3dk1SbH6ut3kmJm96Rm?=
 =?us-ascii?Q?7Z7HhveS1+I97D5u/pWRGLkJmZNpuNcphHanATbhr0BBivHDdRF8+Omf7vEC?=
 =?us-ascii?Q?mSqbzbcNxJPJCLEKzrqXKLapHtVP+jZGbLYj65vDIhAnXSNf948dFh1Zg79t?=
 =?us-ascii?Q?tHbILwa2FTogX7CO3DrZUpHrQz6oJ4UAj6nBv6XjeGvJ71yhDN7rgrLcIV/2?=
 =?us-ascii?Q?fUpQoCukzZmaNkabM1rDHOhrutAoVuVZud6OGtKVzWf2w3qQTkC/5m0LxSTz?=
 =?us-ascii?Q?AARM2P32gfL/WxyqM6UhynzcswQHgmx25TMixyTblKzp68xiWnLVqH0Hnjy4?=
 =?us-ascii?Q?MPGbSKjd8b3iswCQptFBV1K0D6X4T2RP1LOi0sfNW+jCMyDpsg96QwqZt5uQ?=
 =?us-ascii?Q?nNxxoIf+dWrU9bGjFVPfMWwTkU/9ndpIpjZQtq1kCNp/3RRTspoQHZPJqehv?=
 =?us-ascii?Q?ZfMW7MfAHDK1U0N4zyN9Al5ozojseq2wU80LR/qUL4p4L4vqiWHT0N8D22Qi?=
 =?us-ascii?Q?m4OJHlN5saINtVcSvA5I1LcSsNi4BQkLzQxJiM65P/yvsTfS8qoomHlwD0m4?=
 =?us-ascii?Q?/jNInRn/Hf0c27CvU4JjCoDGa9vREDwTYsKPsqmAwkaRg4K50PiCPC7Sf5nL?=
 =?us-ascii?Q?WITONH1h86kMv9L3m2K8V4J4xE7ZNDpQynggOHGN7xNoXFnetyG88M3j45aW?=
 =?us-ascii?Q?ptDfgwvjpNNA2FUxVRAY0VHrHGmXt6HzPXLcaGx2hLfc5YbQlR8nfz8lIZGJ?=
 =?us-ascii?Q?8BtOX9Yricuh7n/zYtMCI0k8lnB0pAfN/iVguRQ3w0lC6LQtQ9GukDu7QC0O?=
 =?us-ascii?Q?XA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LMI8DClcNWNMbC+njAkMwtSnKNi8C7KzaSNLws3H4pl9xiQrZcyvp9q4BzMDpgkhiNgf4LTj6kKTYvWl9QZdbNjdrHqUz+vwwBAACD+WRo2BWg1HjaXTzcebruxSCXoiMwffZDugQU+xrPOrSS8u3TY0NoNWYihIazb5vhO4/7wkyg2Gjb+F3a6t+F1viwByYQF0bgHaXsqw2l9fKD01OsKEbcZd2SooYCe/ibe0oaRMZHwa4HWy8REHB4SE6HfOt13vrP85aEaab3zDbUo/90bD7uoS0je4iKKZ9DpQKIBrcIH0KT2dUyKDFyoVGGAs2xaO7bDeysafhVXtB42R7bESnKJ5FvgiovAU3yI0k1J0qM37NB6Ocxs6F8MkIcxqchfICphXNwgNnZMYtw1ArJy+fAU01SBsurnGryWK26V7uxB8nHpI1wy7Wojalv3zkOcTymFkBZofXwzLB/cVVhgVCcVAqUqh7WpQDRUv6+JRyMXnpSFuGc+eGzZF3y5Tiu6u0wCqBZBOlbIg2qLNP+nq7mdRliTMcPUeQzAD3qj4B0a4Saa6qtssAyn03xLU5fEFh8MzUhLMV+SHV5ZF/rxbScRsdnaA03ohG2gJ66Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e31e26-b340-460a-d17e-08ddf553d33d
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 19:04:13.4621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Kqit4eWkN0BE30OWE/tu7riRi1SSLPKdsF7Z4KULGgpP80uNUV36MCC4vPCug9P7h/Z0RLO6ooAam5dmlLMXOiiVkteReCNgI8mCuJjexw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5094
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=854 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509160178
X-Authority-Analysis: v=2.4 cv=S7vZwJsP c=1 sm=1 tr=0 ts=68c9b4c0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=NW8-NIpsAAAA:8 a=2O2Eigh4bJi7yZCtVpYA:9
 a=FTAPkevyI8KQvgyCdMRv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyOSBTYWx0ZWRfX+L0P1Zu0Wdo1
 Bz4t5YJKtAVXrN3UrM/LOpHqgz4L0C5XZMtZvGxqIDm5ONh75bGTLSrEJpp1veiptdnscndhuq/
 oUR1Wwz3PS928ug7anNtb7LGOre0LzFRqKLsC3JWPCxE+8dNN2uAUjw4y4x1UX/jZTnDn+u3L8s
 cBxhFPP+TpWHhoknqr2/RQRI3W/ulzyaEbHraTw2j3FKVNyX16oKzFeQ3TGCysTLK/oIVO1AD/H
 EF1No9K4L1NuGarGJtmxbNznmDfA0Jn4uC+ilqD8JpYXKW5UUaJglWBgcYkuqEZM2jrZgH17pJK
 74vb8V8vziZPH3J0Z4pXe0NUjCqQizFlMaJlaYuYmQgPh9H53LdqIZKWvEFqi3tQaEbh5ikWlgE
 /eiLBUJ/
X-Proofpoint-ORIG-GUID: QSEDndnaMoW7VpdisVLbdMjsjDuN4OBP
X-Proofpoint-GUID: QSEDndnaMoW7VpdisVLbdMjsjDuN4OBP
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250916_120443_406991_FBF0DFA3 
X-CRM114-Status: GOOD (  14.27  )
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

>> The issue is pervasive enough that OCP has a defined EUI64 workaround
>> in their SSD spec.

[...]

> https://www.opencompute.org/documents/datacenter-nvme-ssd-specification-v2-6-2-pdf
>
> Is this the specification you are referring to?
>
> NVMe-CFG-7

> The single default namespace (see SECTOR-3) shall have a unique
> non-zero value in the EUI64 (Extended Unique Identifier) field in the
> Identify Namespace data structure. For each namespace that is created
> other than the initial namespace configured in the factory, the device
> shall clear the EUI64 field in the Identify Namespace data structure
> to 0h.

Correct.

I suspect there are a bazillion deployed drives which suffer from the
non-unique identifier problem. And thus the path of least resistance
appears to be to avoid reporting EUI64 for subsequent namespaces after a
firmware update. At least that keeps the existing EUI64 stable for the
common case where only a single namespace is provisioned.

-- 
Martin K. Petersen


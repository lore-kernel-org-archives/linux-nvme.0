Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12665C53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 10:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=okqSJXfx2GxdoWLNqKBsoFCSEWc+OZA/ZFlyS4oIVK0=; b=EaUX6fN9WHUXJmDUoS/KNSiNGM
	RuvcAktAiW4BrL8ULI8J24mEWaRIGMmm4nJ5nJXKPUMbNV3YPiOWC14JZNBW9tPqDTk1kNLTloHkW
	9hJkCGa7gyZa533GJa12z3oNuHTCOB5YjnrtxbSOnMBweMc3q6/D5mCfRxvCmqs3tdNT0VexlJVTt
	x6ilNLkLADgtH5ZIWa1IQWwo9bpHSDrnVWTiJjsGbIzN4xu1ugHAq8HNSSXMmyrYXJmjfY0o2vAYv
	Y0ppMd3yciu8oawR3OXNMeT9h79YD5MncmcFCJUIwhjxW25LOOkWBGsFyFxN5NPqThYFIcCb7JAeW
	l/FGhhnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp1tx-00000007coF-0LyO;
	Wed, 29 Jul 2026 10:52:41 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp1to-00000007chd-1UFF
	for linux-nvme@bombadil.infradead.org;
	Wed, 29 Jul 2026 10:52:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=okqSJXfx2GxdoWLNqKBsoFCSEWc+OZA/ZFlyS4oIVK0=; b=YZL6JpFXxaos+AklriIR0P9QYI
	tP41Jwetkxno0iuYXAfajuxOiXDdRXTKNEUfCQIN7KqMXLRs+wJq04wG3oiDmQ1YeTZI2b5UBbThP
	BK9BuCnFO4CHpB6aALuhNYZXB0yVMKRgzItILbmBKpWvhHkavnCg5jzbYxZ4qqMdWsorhXmkQaSes
	x7Fh+UArp9J3MsYlKmLA3PAwGsU5zo9BnXGFu3af44L/QZ921X0dEbf1EjiYSDyTWZz2lJ6Jev7PG
	tAS2X6tpRzOygLQ35bbaKIHrSYMogJNMqH4lARQUbcHiDg6gI3NqBF/PUv7gdanK414Ey5IJJ+tAL
	DgvZwx2g==;
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wp1ti-00000005gjc-2Tyh
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 10:52:31 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66T9OM5L1094334;
	Wed, 29 Jul 2026 10:52:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=okqSJXfx2GxdoWLNqKBsoFCSEWc+OZA/ZFlyS4oIVK0=; b=
	pIeLbWSk6yq51p5v22M9ujV2L0Qji9peg+CANAYP82Q2aAB9p3dLQAlVV8ynr2Gc
	wgkoIMBWAnZAJ4RVFqo6a4ziu6Q3qmv47UJ2QhGvGXRtxlzUO4k7xbp3ZhTpLRVJ
	ZHRB6IH7pGE4RNmtMi+4O+euYvEgVAPiE3odnIkyUAYKq6dLnsbDwcZw6x/WDsig
	Fiv06lqd7xsAzzHyXIuXAA8OYCUccKP5spi86BBs5mc2mckq0m3Z+leYouw5g6jj
	2xlZvRTDymHKdClUgP6oBFb1QtqXVWASrdolJdssXb4MpS6QboQwXhwtXn6+HxC6
	wKA76wTo1ZFqx2TOEl8Szw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmqym5k6q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 10:52:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66TAo6SB029959;
	Wed, 29 Jul 2026 10:52:17 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fnh882kkh-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 29 Jul 2026 10:52:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCC+REDDou13PXPfRw9+RlVOO1Ks6wvQXZgjw6rVZ2ujtHci587Hu56XqyfMvkTMkPOLP4/DiSmFJ5ajnoJfKfO3wkBhBFwu3varLEkYFcn+ISdkOWL+44gdkWttybiKN0QYNyutvIyj/A3MscUZAW5/2ZpSTIEvMqQYoIrwxQvjg/MC/tlGGyOqSgv6HDBFprAorVfXULEzpyHiaBYEz00HGAHJeGV9VPb/ucfrfRO1BpHI7reCBrzSa6oiQBqQ5rYBmjhAD+C3z7VTBbB5lMDD5ijqA5k/QgfrFCg09Q7oCOSemG6HlOXF4pUR8M96QCwphog6gl/kY+fHCWbgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=okqSJXfx2GxdoWLNqKBsoFCSEWc+OZA/ZFlyS4oIVK0=;
 b=Cof80pzHLRTBmtclhy3w1OGWwpHO0IUcqiHJMUj3ceB9w5evXykjN+MvKh4mgGFXKJjdPvSA7HZDpqwOntXeNGr466zyiACSdGHmNbHW4s+x6ceQwzP3usRfwoC6AMOV2lbJ8Be9SuuQhjOnMpCGyngFOM8mO7kXhj9Wx9zXszdNx9aZQWWFEFgA9B7lx9zAaQuGKGUA+vpXbLenPWddxgQQj2OT53F6qKRqYvb2MSy90wqsuIp+2BizU7SlTpl7h/YeqCHgW3aLcEFbqeGIAm6S1jVKrEXNGwWunPlUr+V2Erb1MH6qqOTL2hs7vc63hrf3dvFLrFtG9mOASZ+73Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=okqSJXfx2GxdoWLNqKBsoFCSEWc+OZA/ZFlyS4oIVK0=;
 b=j1dAGJmpqW/ZlibAXZSW8QOMK1/sKN34SHbfJHPS26Lb9W3bFRcmFaAXbQpzF0KcsnwB1krivbX4m/AeGFv1MrMMUbGn0iHtCVJMPL83nJyI58OZeszZd+BkU7sXwwWr/ZXhkSzHcjkPN+9OBN3XuecsKsZjSm8cVV6mAF6VdnY=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 MW5PR10MB5808.namprd10.prod.outlook.com (2603:10b6:303:19b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 10:52:12 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 10:52:12 +0000
From: John Garry <john.g.garry@oracle.com>
To: martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, bmarzins@redhat.com, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, nilay@linux.ibm.com,
        john.garry@linux.dev, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v6 19/27] scsi-multipath: provide callbacks for path state
Date: Wed, 29 Jul 2026 10:50:59 +0000
Message-ID: <20260729105107.255712-20-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260729105107.255712-1-john.g.garry@oracle.com>
References: <20260729105107.255712-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::14) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|MW5PR10MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: 749e7437-0db7-4632-aed8-08deed5f71ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +4L20eNNYkw49eRiZJ4IZJHC3D8QgfC48PpXFD4SfiG0duFmEHFeU+jc46DiHdguC2twirXkUeZ03iwnvLzXYW8RDjpaepDqBT8IvazYMzPHS42oraLDVJAI3lOxgNGOZRvfLeY+eH+KfIHc2M9gUTNhUJ0xcKFdQByDZxZhhiy/oG6DvLXLhVm+LQc6lQDdTto/s5FJpzjRhOMKujkfbOjwn0z3svw3PVT6bgDHIVFmG7aPUL54QgjRzPv7iwBBnLSmAwsvIhN+nPgNSnnRnoNXVc5upt3HW5yWT8h5U1JnEtglpajQHeexe4wsSaLARxPtqdwrswBz7KXT9DTfZEbIOHBanAPinBvglOktYHv4mmHbZDQaof87AYzQJNeKtFWb3x/YXviuB3Th6CkuCxe+rFdf8cW3jKvvbopJ1rgZKiATjhPvhETaDoV3rAYcHagJtG3qIqtI4+7ugbQeUC/qzY8Nko2g1iSBox0JWZX7VVgCMjEL1gIdXNEc7D14/4eTKOja4lNMfIrt6/+tOTQ/gSVKyWw1Z5lgl6jiC3H0oAC2ct6Q4JLwptqDi/NuEtTwfSPRtDndshYOaCvdslXhxiFGKfGbvTe2B2tPE0AWpdqR94yhzshV7KgpIyfYmg9nBFhrp5I/FRzfVE2kIxW+JZTDboB4jx/RH70C4nU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9sUjOVQhMBn0Av2UeDazTPQRJn9hiTEIqG4C3gQOpLwAXRT+9TC09AVccJQO?=
 =?us-ascii?Q?9ZigYkbv3V/xwL5O4gRHW5WIccNMNI/X5BncfXDm5e/Ubu8ggtEkX9ioyZfn?=
 =?us-ascii?Q?MIItH7MeafcrTCQjZhwLbwU5aguBt/+z6puUCoVHUwCCDwHKXkmibbh2B2++?=
 =?us-ascii?Q?uMjjCTC9uyPS5q4dVKphMWeww5FgAlmbLZmT5B8s33kV3FAuj/esPp6RFk+e?=
 =?us-ascii?Q?r2bFKGN2QjI8cAEh2cOCdb30SPhaNSLWXlp9X1NQvNNfzYU/tg5+JLXWNxqe?=
 =?us-ascii?Q?MODAwVof0R96IVoeqeo0DMn3Ekae0rpG2amnFkY11O3LHlUBdKZhGt8UCdGj?=
 =?us-ascii?Q?FqyyJqcZ2s2FImNJYArY+l1Di6tJDvjCg4xfNxnj/jVwZRrc3gNzqyROwlmR?=
 =?us-ascii?Q?wRd+nanA+hWjLgHSIGdPu5XMVXZwr2gsc5ie801sXMs18cfpFuLHX3/UTZEp?=
 =?us-ascii?Q?Gw/ItunqlrXaNrk9cjzu15XmLcggu86KfIgFTinqSWnVvstxg8jtnJnB9+Fr?=
 =?us-ascii?Q?yl+rKMI81B5I4CbEVf1fx+0aDfPMHOJ+FFLVb5vzC6nrcR5ExVf72R/QbYpi?=
 =?us-ascii?Q?HE66vPzl90DCLz5C31HeroH4aHOn27gC+PlAuDD8YqOkFAdIAm1VZZ9JXT5Q?=
 =?us-ascii?Q?oLv+quYYBxWnEh0tUvBVPlJwwvYKeDOmNbyYGhMY4pluhV1LjN/LQkLPkBK9?=
 =?us-ascii?Q?Nc8530KUinN9nudw1Cd5t/S6fpuQ75TtyWFbRkxQzXaahKJKYTSnNcpgQPkc?=
 =?us-ascii?Q?2EnSP0sq2sjIOe0bKYkvo7gV4hKegaH1ruvju8s2SxUu6TPu14xntz+bvMGO?=
 =?us-ascii?Q?i4sCsJRM3+pc0Mqhi0DvIHRBkYFiGwfXUIBXiDWtEGLJkzT2O/D0MPLs0Dat?=
 =?us-ascii?Q?hiQMn+C1QpoKeri0tZQL78joTfmldkUaecaqDg745wcJU9ReBSIOfx0akEzD?=
 =?us-ascii?Q?hM3T/BCVYY3lRzDDZxhQJaZxA8iQjSnfkSIrE+eZDZCMw8uUV6I6cxSjS/pU?=
 =?us-ascii?Q?LkEZ15VUZHPQPnBapvq183urTIWblfpxqRURpzZDmPHEwGIx0HmvdN3xKV+n?=
 =?us-ascii?Q?BKRZ+fLI4I+lsPqupz+QutNeNpkLSHAFoumZ/F7GdzFrOyyNM8oHH4Q+Ay3C?=
 =?us-ascii?Q?/FDeM4e24VaKShvvEibfunn+BfW2R3Ku7waxFA/G8j+oxgmdkh0cItlFQRaR?=
 =?us-ascii?Q?iA1YidSXrAvDhzxyZ1g2ggbHnCRv5uEHAe2icbajheR7Q7ho7FTfrEJ9x5Xg?=
 =?us-ascii?Q?X/DsQeyHumfJd38ou0jxI6p2vXKTkUyQBI6e+vkmAM0YbFyX2E48v06gu6W5?=
 =?us-ascii?Q?97Rk3gOg8Fn44UGFvuPu0soTiUVHIxmwvq7UljHVp2xhH80X2Ob2AJZdOcnn?=
 =?us-ascii?Q?RsqrMN7+GfKVvXCTDjASNT0wFoD3K9aC567abEzotAuiyqkbSLLLWDkykzHY?=
 =?us-ascii?Q?gGC+UZqoKc8vAyfeHa5CZI+T3Zkc29fEEDv6yBHBxCR3DqCqqxXEkvHsXwUp?=
 =?us-ascii?Q?Z19nKJiqJTE+3vU4vbqWe7RQ7hHxqCJbf+I9IWnX5AzPpQx87MnYHSMGtWt0?=
 =?us-ascii?Q?Z7+eEfgJnvACRafa5F3mitYAsJM0Z+PDJpU/+s83/WwmUNAgr7mo6LbpsQ1A?=
 =?us-ascii?Q?uLeCfi8ffen6MLQS/I2BjYuNb8Vg3j/PngUjMwH2p87MolG2DCi3byPZ4Zyn?=
 =?us-ascii?Q?EZL2CB2zOkR176hGBFbf3UpsSirxSA7RawnkSi9OQGaA6KGbPhzKa5ovd8xV?=
 =?us-ascii?Q?cf5IhyfbwA=3D=3D?=
X-Exchange-RoutingPolicyChecked: SQWsZCkLs3ffXsQ2hshd4luDLXKG8fRksgqiXNgTwp8CDFNTmz4YbU2sl7ozYzSjCUAi/VnSrWweD87twRG5rOoS0/YMYSYrWH4YO/fE/jqOZ3EV5g+pOkJQB4oSHV4TF97z+YSlUZPNb6mklYThrLQSWhR4Tbxw6JHmlW9oxSHkiXlEpv2fIF7sFLvXhjP6FxQ6C6Vzolq2ZFmC8YbRH9xDIhYyKyW+Xq12YHUNs6o7k+wXyKh8nh3M4x9NMA3oj2lngxPNF9HL1ExiHdJ10XhfnYqJzBIIb5Vm0Ojioxb2g7OcUB+EbxZCGwuUGjEqsA7uxuz9nZypVHVjl/Ptig==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: rS4wAT/ZIjKmiCzeKgRpYpR5wZfd1kXgrkdiG6x3D5hkli9m9JOYhJWTiul/P/UgWZBqHqaSEeBC386vRLff0cqEmeI+Grp3qU2vj/AwZm+I48SNfTEJtK+efUu5b17hyGRquDubZPoXgvQVjW31PNNfbtpPX0SE87Bfhp98Le+dAQqL8bWjkcT8hbwDbAE0jqjU6KrWXQ+INkulgaIiTwYH+GuqkWDjrJWFdIMBp7YWd6tIkCmIFfugLGZV6AX49T+sS49nZKOkj0jlKxtVSjk0Mg2qlD6gp7wLM2MOJYjAvPF6GTIWWRJfKJ5XZswiWbOEddu+vtZBgcCzcD4w0E3tDtYZLWmXrtnn2xMtT4tdwKgpHnz9Hj1xTcBgfbwoRflwZ8fVyRdFznjLcqoSOwofDsjR5KcpUBipMmVNpxc3dewhTfgLJqp5C6yzW2yDs/RUa3A6n2f8nHNF8hDCNqclV09ABW6bRGgYINbhi/iY3HPzoY8/bIGyGz7PaFUHjlXCq9hBCVbiln9kgWTYtOSRWre61gt8/pKnaJb/rdWBaf59t+4SFlZmx4iEABX89dvCbKpOYldKEObn97H2Pbl8hMfIXVsT39Lc+do3h9s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749e7437-0db7-4632-aed8-08deed5f71ee
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 10:52:12.6322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wrU56XJ8XppIZ0GVP/ViRKnsXrVQAMmJ3H8qLwfANxWg3k6qmsIJT+NC7YhkBodYOgEdtjb5BMIiuGqE/oNc3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2607290089
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDA4OSBTYWx0ZWRfXzurKkvRQEs1F
 /HOop6UPNIo2+dBx5CXI29HOnc+J8YzyIBDAahbolmge0LjKeqnq6ywWvW+yvUCs48VoyAc8isQ
 tBBIMuMnkz4TXMsGxahi09jcRC2k2QdoA69iBhvxwsHMpToMIMDz
X-Proofpoint-ORIG-GUID: dP1VCCH8AfLk2qjIG_FCTJ86TiaH4tQN
X-Proofpoint-GUID: dP1VCCH8AfLk2qjIG_FCTJ86TiaH4tQN
X-Authority-Analysis: v=2.4 cv=UOrt2ify c=1 sm=1 tr=0 ts=6a69db63 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=DHJJM_rHgSnfI6yttmIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDA4OSBTYWx0ZWRfXyhECd0opzDzD
 oB0JopXIQHZtURpqmvPVfKaOoh8GKjpP+75U0AMXQOAXoPXZA8STi2MVpSagDLDlnrG/SBfSHbF
 FaZlY9mbVe7ZjwewpzC9dSMRaKFNEBNWJpxeU9PM8YLS1IdeZI2XdG6V+5VtvDEKCKT8Ah3hU+I
 iC7VLhD0APAlV0NZFn4JJFqdia/is+dZ1A58HQeanqpZ6G5vwRKRfGy+nHL+VlqDZd1FncOwE30
 PfTqtidPp7v8b6BUT/Rm2yidT8fxOuFsDBk3yp5tWwe6vQv0E2xBnYYnnAaua74HNt0fOmi/iSo
 pSg1rmTX5mhpzpbcutWnv7Dsbr3B0MBvx8jiCFFa31+DkjtvzRRmH8VMu2yETTFgxVAxwfEC8EO
 sSerYSAeyFU7chaWs9mivdBoZSrgdNOOBUeLSzeqiM8RxlSnWGfRjpzy1Zm/RPReWiEe5VSgSYh
 h958N/WiQVwInAT6ytQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_115226_961931_7AA66271 
X-CRM114-Status: GOOD (  12.36  )
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

Provide callbacks for .is_disabled, .is_optimized, and .available_path.

These all use scsi_device.sdev_state and scsi_device.access_state.

Member scsi_device.access_state will be driven by ALUA. Currently
only device handlers support this, and in future we will have core
SCSI support for implicit ALUA (not relying on device handlers).

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_multipath.c | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
index 6ced89576368c..2a05f177a1dcd 100644
--- a/drivers/scsi/scsi_multipath.c
+++ b/drivers/scsi/scsi_multipath.c
@@ -321,7 +321,56 @@ static struct bio *scsi_mpath_clone_bio(struct bio *bio)
 	return clone;
 }
 
+static bool scsi_mpath_is_disabled(struct mpath_device *mpath_device)
+{
+	struct scsi_mpath_device *scsi_mpath_dev =
+				to_scsi_mpath_device(mpath_device);
+	struct scsi_device *sdev = scsi_mpath_dev->sdev;
+	unsigned char access_state = READ_ONCE(sdev->access_state) &
+					SCSI_ACCESS_STATE_MASK;
+
+	if (READ_ONCE(sdev->sdev_state) != SDEV_RUNNING)
+		return true;
+
+	if (access_state == SCSI_ACCESS_STATE_OPTIMAL ||
+	    access_state == SCSI_ACCESS_STATE_ACTIVE)
+		return false;
+
+	return true;
+}
+
+static bool scsi_mpath_is_optimized(struct mpath_device *mpath_device)
+{
+	struct scsi_mpath_device *scsi_mpath_dev =
+				to_scsi_mpath_device(mpath_device);
+	struct scsi_device *sdev = scsi_mpath_dev->sdev;
+	unsigned char access_state = READ_ONCE(sdev->access_state) &
+					SCSI_ACCESS_STATE_MASK;
+
+	if (READ_ONCE(sdev->sdev_state) != SDEV_RUNNING)
+		return false;
+
+	return access_state == SCSI_ACCESS_STATE_OPTIMAL;
+}
+
+static bool scsi_mpath_available_path(struct mpath_device *mpath_device)
+{
+	struct scsi_mpath_device *scsi_mpath_dev =
+				to_scsi_mpath_device(mpath_device);
+	struct scsi_device *sdev = scsi_mpath_dev->sdev;
+	enum scsi_device_state sdev_state = READ_ONCE(sdev->sdev_state);
+
+	if (sdev_state == SDEV_RUNNING || sdev_state == SDEV_QUIESCE ||
+	    sdev_state == SDEV_BLOCK || sdev_state == SDEV_CREATED_BLOCK)
+		return true;
+
+	return false;
+}
+
 static struct mpath_head_template smpdt = {
+	.is_disabled = scsi_mpath_is_disabled,
+	.is_optimized = scsi_mpath_is_optimized,
+	.available_path = scsi_mpath_available_path,
 	.clone_bio = scsi_mpath_clone_bio,
 };
 
-- 
2.43.7



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C22FF885D
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2026 11:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5wFOpu0X7FTsWVkHtSOcaOpDbWwzcDbaK4r43lDnoBM=; b=E+2Vf8aAlwDOqxt74vkjRFRvFg
	TRxmh3vzvosg/dCPqy1PTpLgzMMzJz7sfaEOCaZCoj1XEhkxk/wahNGjCGeBNtVvnpoZKl5FDd79T
	smj7FfkO8GmADMVtO2AKAdpJQgi2KFeOjeBZW5xeWqFYPzhCDrMYlldSyc7mjXu7TbWsnGfvxVmfG
	9gWMKEK43kHK/rvkFDQxIHWWI3P0QbEbBO4uekvE2OA6ukSkp2wPdSQjtUNtupNQjBYrrLtrzLA6f
	9MdJtSHjX1M5/ViYT+gtVh/hgLUZuKcGfTzVizgRWyNe6XR9r2J11STUBAqJRoDqYbMx5dhFewu5Y
	b6XsoG+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHgNw-00000001HAX-1JnP;
	Tue, 28 Apr 2026 11:13:48 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHgNo-00000001H2P-3haJ
	for linux-nvme@bombadil.infradead.org;
	Tue, 28 Apr 2026 11:13:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=5wFOpu0X7FTsWVkHtSOcaOpDbWwzcDbaK4r43lDnoBM=; b=cTV4x5RyHLHvAFKItIWLBo0N+Q
	UHnWueWILeEuT6Yg4gsD1/YKRbvj/1wMFm4DgS3x8PNNakuMfCbqCoZyBK/jvQXnYmQzKme/pcNKw
	Qf8WKihVrYlvFwARXSVfqUCUIyog1en118UTlHzimnMHsKLDxiSEnpMgIlEm0XsV7o+tOr4SuiTCk
	R8OtIBGkvCruFxXlOttDBa2WaEzYZwmj/fh4sM3fQ1KHVt/SIyzij18r6IYh+WXF4vWoiS4e/FnY1
	8PYFfmf+ZRIuvf3QTsmbzCZm5nFdUc51w8IdL+/2AjycH1oc3iDFDghZ5LNabSh9PsRxxS4EJ0FER
	7K6+y+cg==;
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHgNl-00000002pPP-0apt
	for linux-nvme@lists.infradead.org;
	Tue, 28 Apr 2026 11:13:39 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SAIeI31905229;
	Tue, 28 Apr 2026 11:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5wFOpu0X7FTsWVkHtSOcaOpDbWwzcDbaK4r43lDnoBM=; b=
	Q37QlJje9Ds+vTrL3na0pG1y78rWGNfLSMBng79Y9+btapOhYhgn3Bzvkarr7Nc3
	iGFVBy1QqdJobX6UrMFZ8YrRluh75XruX7qlv5MmRK+GlcHX/IXQkBJbAzAJJAQk
	ZRZjlV9DwHpePM5VRVEbHyOU1miNmWgbVnW8QxxtwLUE3VOrfxzbd/TyB5sKkknH
	zOSw/dlEV5JrIFd1jEXczI01LS1P1Mims29O18dMy7VlrgaAii/93VVoRvnqa8Ct
	2UovdZcmfIT9Q7oRWSh3gtkG6qHozHRueoaCrscBIr7n/gE95CSWslBDhoaFoP9H
	40c5ke22clqxhmVV+qSX1g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4drng8fcr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 11:13:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63SBCmIj038793;
	Tue, 28 Apr 2026 11:13:28 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010043.outbound.protection.outlook.com [52.101.46.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4drm2ccjxt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 11:13:28 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfSikzveQT7AB9FdzZlzIrsKUzTZbf7RhcJrRXw1lE1cGIUkKYpsXyt7hkHJtxa+VQs24w1AlB69fRIVZcK2nb+OpqxoCNW21aJkAatf+ATbyz3JjX8MA5yZdMW2ETjMxXmsYEu8zNVGOm9ygX2UxvAYRDs6Fs4PShR6kbWXPz/cFqEQrb9IGS7cs3uE/I1/tu0KixvVzqu/jSZwlbFFBzncuh1VOuqbnTfu2rgWU/45J2iVBjtqGtvnMPR7pgEhzXNZnOnwGc4h+cpiriqVG2Ud1Se16ZZGobK8Okwd3NaO5WmBeYZdyrlO/Q6vk+Rs1QDDO5Z0bxnWsMwQvJ0X3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5wFOpu0X7FTsWVkHtSOcaOpDbWwzcDbaK4r43lDnoBM=;
 b=mnb2jZtCLBdaYdIGr0Aua7P/Nt9vHwtNOtdi1s8Yc81bXAlDTNkAcX3jH+ztKmsozs3VFP51/Gq6pWdRIagtMaLgDvc28+ys27LeZZK0JMHmkbtyP3CvXLxr/3hwNHANb/jnDxqLSq8iGOwCU7k42Jg3T5tk5rqJ291ks6WYirgqUD0HkntGs47rieti462Ii4rK9A1+XOgGLevDElbbgrWLtRGBKa9hREsGE5K96ZNlEYRUPGYHwS6nznG06dhK28h2MlPadSE3K0sCFZfCpjyw8eTLIM/rZv+GC73I8l12SpKmasrWoVuVoNMhwZ1fu7RnoUwQyYvW+ecmZE90aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5wFOpu0X7FTsWVkHtSOcaOpDbWwzcDbaK4r43lDnoBM=;
 b=Gh6arTgYjOWfp2mIjZGqmFE1bNwBu2hULyY2eD1fqwrcVIMiQW7rBcMh/11DxH3joP+MwoFNkg8YnzPOxZDgh9tS4C8P46LJd/buE6dQS0jReEztNP8sNkMDy7qWPTDR9DJ/Ly+0ATnn5X1TQ6sV0j6hcXnS538oye51N92G/HQ=
Received: from PH3PPFEDB06D67A.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d6) by CH3PR10MB7458.namprd10.prod.outlook.com
 (2603:10b6:610:15a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 11:13:25 +0000
Received: from PH3PPFEDB06D67A.namprd10.prod.outlook.com
 ([fe80::234c:e047:21c1:6d16]) by PH3PPFEDB06D67A.namprd10.prod.outlook.com
 ([fe80::234c:e047:21c1:6d16%8]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 11:13:24 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, bmarzins@redhat.com, nilay@linux.ibm.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 12/13] nvme-multipath: add nvme_mpath_get_nr_active()
Date: Tue, 28 Apr 2026 11:12:55 +0000
Message-ID: <20260428111256.1778475-13-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260428111256.1778475-1-john.g.garry@oracle.com>
References: <20260428111256.1778475-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0135.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::35) To PH3PPFEDB06D67A.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFEDB06D67A:EE_|CH3PR10MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 28274525-2f5e-4ba7-bf54-08dea5172a50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: sUGZ6KU74bsrxUo4gT7VOseN581ET1TdShXXOqs5qf55xao3h9bHqy96LEwgt4WBkuT7yPWvqXTSccoBVfKKQv9WyM5p39+dwmQe4gUS98bGk17NxJPaMDGnbd9m3819DkATEn4UUIthOpMUtr+9XMnYqhmP96s/um9M/xEqhT1WpE/P+vHF0EONRQPFmbq6xgJaEnQq5ZtPcVobzVVOEe27XBoktPMs241U1F8Ar2m1/g6qC85Kck0T9Bjg+QU+rCKU2S7ar4M8ZX+wF23fKJ2WTWBtheltIQ8jm/eA1sOcK0erBi6MAHj5n/NGKWoQ8un3N/p36c2L8EUzfnlNjSaF5+IhztGPXh6a9aUn+yXqlhgQb3Ij+znF0GWk+f4SDiLHUMAO7LWysLFLFbnp9qB7eamfG6LIk/N2HIV6khx1VyXBhWj9At94mE26Ot5aEHBAUmg0MhqS2vl216dSgLtUp0ZHbEb8yOYSUcGo40irAPkErC+p87sG7jATi89ZltTdnwfxmB2vbOyjovIv0d8pPjjrKObkL6aOJ/oTNElui5jgYIxBwuXYZ/K/4hgm2nbEzGYY69mKGG5GHO8I7M2Hz+8t2JrRMz1CpIsC6J/8TV9mSM0aULwAk5GTHuSZTPz+9QtMOHDV8pRAj6B/BWKAegbR5+2rubJmHqtoCDrJEvgPHwXQO6tS5zwjuryq3nLzctpAx66Ku5i8+TrHzU3YItICOT/rp4kOXluOHEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPFEDB06D67A.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v8OHubeF8pF2BLUcofPQ5aLcExVJN8jqwoaiuUZuGwZvzU4UNBSTkFtmQr5K?=
 =?us-ascii?Q?oOJBbDxTBQXdT2dfSzgCuYPmwnpa6bB6fnd4bdEL6Qgh5oQAaU9fxIk6DjHR?=
 =?us-ascii?Q?xXq07Ai386VhiSqD1jgKnAqCiPtUJVKkWecXtORn6SvlA9MW3YvYuLyelF6w?=
 =?us-ascii?Q?2uMrNGfft3Cz31y2oKza8LWC9j/RNW4E5MwRkfH3r0zUYSAvAiod2XyPtWhM?=
 =?us-ascii?Q?zNv/7tUogjzvVtVL9LJKt8Y1tmu1UQ4fG3ukPuPViYko+E4s+Pnsd8yZwO//?=
 =?us-ascii?Q?F6QY4H5h8aF1ZT360UIAEuxQFF71pO1QzTAdpf6UKcumd478n7RstG7nhAZa?=
 =?us-ascii?Q?pfSBa42jGg4YMe7QFfoWSmvwxJaAIelK5HGhA3rRQu38d+xSr5P3EqHna4ep?=
 =?us-ascii?Q?71iRb8SlIVDX7b9Rn7U46/hi+0b+MEPKxugyblgyiDF2k8jZeDiwQvvIIcMc?=
 =?us-ascii?Q?sk0spfEmY8iA84bD3T+o2Q/DPoCNih08dA/Czf87NpXv+K4zEBrwmyVz+e7t?=
 =?us-ascii?Q?U6Xs+EJ2BiTED0wHeS40Ador+lJAXqDEJJLmDco3T6E0uedSc6lQmfV1YdhA?=
 =?us-ascii?Q?eer8bEjeQM4wRYBLbah+sx+DZcb0UI8QV0mjS0yrtwtfkQ371ZKjDcgNTzCn?=
 =?us-ascii?Q?70ltdY/NcXIoi1LkYVmLnydtTYEwJtOjUr6Otqa08eFQbPVAHtfhzNrLdRbj?=
 =?us-ascii?Q?7eAGNoRhORFBE4wE5YTLRKCVgW9CUl6rp6KLsECCg1RuSsiLd7hVEnHEO9wv?=
 =?us-ascii?Q?TIHtypIc368GaBoJkeISWweT6z8tietRrjAiERknbuO/iYaw5hSQhGRZTzRl?=
 =?us-ascii?Q?cUm3EWZSTqvsz3l5UPLLYKZAHRX2HKbtxQEEycCr/4Eu9YTk25Guy917X+K0?=
 =?us-ascii?Q?BMFzbl6TcvVoyXNB79KLftcGQweyq1cZSDAMO0cVJB7vGCT1cUvI4eYKWj0k?=
 =?us-ascii?Q?r3yLNxCL1LxQ3bRFxyN3LziAhjVNX7D/ljQCVVqY7QtU1wzVi3MVt4dFsng4?=
 =?us-ascii?Q?DgQt4jHx6xgDwzww9yNe+NbYD4+cDWovoR4TbLCdWOW+JsY+eYq4m3+3kq10?=
 =?us-ascii?Q?lJ0LaHL/LhL9fp/OK+6QpCqM43eqmbcAcak7mXecyDSdmGd2ezbg/uz4W058?=
 =?us-ascii?Q?ZHwaL7JRoSF2Y0f/Gve0fswJR/TKe4+Ht5jIsvQMXKjDoDa6VY4LtQ/ieu6a?=
 =?us-ascii?Q?oFq4tNlvKibyoWlOfCw8DySCwCiguagqVlQypQWSUMSD+1bYOjp+7Z5GA4xs?=
 =?us-ascii?Q?K9D8r0zZZWFG8BOz/5/Mr1K1SLbAVeKIJE08d6xcpBqAk77TMhLrrD6FjQHT?=
 =?us-ascii?Q?Ovf89RTQDv4KgQBioWfIiECeF3VwjF5wFynTV6cSa72aeWvCWrAzTVfTBPDY?=
 =?us-ascii?Q?FCJhai0lzThhsiEeN8FDYBVgn1fxrAj/tm9VzMf2bGbzN4HsG5OR56/n8Y+V?=
 =?us-ascii?Q?ImpfqXAdVDxBC+SeBMgqDuEGyz5TdhAmeNgpFZwYgXnYpxp70wUyr6KD99Jl?=
 =?us-ascii?Q?jfIM0iJ5R7IKEWqgeCFRflcotITehfbJTHdBINs9ay4HfNaaGy7xvKqbpo/k?=
 =?us-ascii?Q?ts5z5mWpMsd+iJFABNZ8iW9aguurZcmuQ4TyoGbxHclKBLFSXz1QBehh1/Xk?=
 =?us-ascii?Q?21aYkz09MNFbi/lsdtXU2I3vX7L4LdSqQq1MiO3dtSLf5B+ClQL2lagmZzHn?=
 =?us-ascii?Q?0ZBa2uvWwveVriSc5jB/RryNOg/Rrwv6KTFGHit+Rhfu5h0NxpWTOWk7vaUp?=
 =?us-ascii?Q?2jUG/3JluS16rVvBPoVbAy0vsidmgC4=3D?=
X-Exchange-RoutingPolicyChecked: qFcmXyXMYQtO+8C697ijFr88wjx+j/Xgc0F4nhHRecTOlF/1hC29VBalPzQsC6ACZE/p17CBfw+16UsTalgBiupEDMUvAFrmeGOsdlda9WNXU8DE5Z5QsMSxwMmuC25ZGphVDHhlFst+a8C69DJqZvBDK5hJho60q1M/f1NoopZv1SqAX/ECMRHHqFNPj+GcQAmIXDpmctbGoCPHV5f1h10W7ZUOIOpWkLS0c+4tharER6LaqfadLwEghrjYaSrQMQl/Wnn6Y0AKj8HdGTrTlmnMLwcedTIdwBrfkAPVJQHAS4V6yTLGT5P5km4c7GvvvIvlP2JPzP6bB7f31A7IpQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V/Hfm2tNVFI+N413S1awWVNiRvQREV7C0YwEAiALeyGhCVCOvbTs3JiniBzWaagkefjhcnPg688cth9dDEJXD14wBdNMR58ndl6s+Gu9CmpIR04O1NJ0/d0ldZ7FnMqZNqAj1sH38vK0n9LW2hQkzF8PDPqSHu5JVJyC05O9R7+fR7xJa+x50WaCXM/XFiK46+Q/RUIHwJDKOt9Q1yibWOEBkRPwle5d8I1ghy7Zv0h+ZucPJ5VCYg8FraADRxB5WFKbA/91VRWzNjrZ9tc4XO/zK/YFMkxd008HKntcHA0lDlKP56HojDII+9T9R8UwYuQ2lArZemT7sbrubVxeGOl3GsKmeYSpyOGt92aKkl6PZM08YatIsC6q+R+qDbM6FHkNn/X4cQrZmK6pf0S9CD455qU409rVlqxEPvsYgi39zRmecJRBBF5GIifa32pZcTrNze208FiaQulYisfZC3zQmvJl2iqlrEO0kr9P1pTq+V+k7vQM8t8Z3Kwg32M64Cvi5GC/+G89TlBFVWNxM2p0qOYQ1hjdXB+/4xGqBAS3DmN0lDNO6S4JB68OML2vwo8OPf/+NWNdg2LIC/vx7Tm9oJLXHs9nuX2fqVc7Qbg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28274525-2f5e-4ba7-bf54-08dea5172a50
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFEDB06D67A.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:13:24.8593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrl6ycWyBByM3pIw2JUJI5o5NkqbEkNXnK4KKPuzKGNnJkskSy773Hp4uEuiSkoGD024gGxzG4yfpFDedYaTwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2604280101
X-Authority-Analysis: v=2.4 cv=U7uiy+ru c=1 sm=1 tr=0 ts=69f09659 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=hbqJSkJ9pTsutRKaO2AA:9 cc=ntf
 awl=host:13844
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwMSBTYWx0ZWRfX+yLnWMXRpY+X
 rFGUa7WdxGt81lZDmkK25m+pFLZo5BWvuWokwNHv4w1PBrSfSQUXPRVm1xft6YJWMzfvQLhr0b5
 JQLHE5OFuwbK388otTEbM+vLYiil1NrOZtCrrjB6KnUSQTzNbdGJJaQ5IdaLTekXv2RFPCnnYhS
 4eghX9TeRwdxnBCHyHz5Gddmj/93FKMJlS6q7JoXq3QEQ2kRyyIyD9wsuqS+Kja1FQJIOnM6JnK
 SQzskR5E7ECXpSvJtFSiiyAQu1C2e0WiTXfBAQO975Q8TmcF+/bQSMB6U8Ybw6Vp01s13I/dfAy
 RDYr0Xj0gyX4hl77DpH0g5bX9Hwakfku+3X60tw/4XdPPdtwGKl5s60x6IGNhRA4ewwlmTyvjU7
 DwjUWMnQNSxRf9n0/hg8q0OP/4yFrxGlc+uDTcMUbs2OBS17KP7O7mzhKCr+M4nYQXEo6P0m3yf
 vhcLqQmuvF/S1uVoqrPyW69RsxHTIYs8al12/W7s=
X-Proofpoint-GUID: LxUKRfdDy8JhZBBEUPNIm2buGGpdxbRs
X-Proofpoint-ORIG-GUID: LxUKRfdDy8JhZBBEUPNIm2buGGpdxbRs
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_121337_680701_9AC2A90E 
X-CRM114-Status: GOOD (  11.03  )
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

Add nvme_mpath_get_nr_active(), which gets the number of active requests
per controller for an mpath_device.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/nvme/host/multipath.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 8025cf3270cdc..62e13a484ff5e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1446,6 +1446,11 @@ static enum mpath_iopolicy_e nvme_mpath_get_iopolicy(
 	return mpath_read_iopolicy(&head->subsys->mpath_iopolicy);
 }
 
+static int nvme_mpath_get_nr_active(struct mpath_device *mpath_device)
+{
+	return atomic_read(&nvme_mpath_to_ns(mpath_device)->ctrl->nr_active);
+}
+
 __maybe_unused
 static const struct mpath_head_template mpdt = {
 	.available_path = nvme_mpath_available_path,
@@ -1459,4 +1464,5 @@ static const struct mpath_head_template mpdt = {
 	.chr_uring_cmd = nvme_mpath_chr_uring_cmd,
 	.chr_uring_cmd_iopoll = nvme_ns_chr_uring_cmd_iopoll,
 	.get_iopolicy = nvme_mpath_get_iopolicy,
+	.get_nr_active = nvme_mpath_get_nr_active,
 };
-- 
2.43.5



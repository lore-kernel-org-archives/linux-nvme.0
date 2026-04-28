Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 289BFFF8868
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2026 11:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WfpyHjjc+4pWe1sB4U/J6o0jNZc4M8ehpYZlOt3VPHk=; b=DxXFhSirnLEfllJF7qEsbGeer1
	PXymPHW62PteyEOClGRJVwfZLW9sRPR6xaWTEOyC0x3DTjoxafjs1yvEZfXbZmuKy9w+kwmXf2s91
	MIKtkMOmD6EZpu8EIZNXirNRk6DFLyiW8aTf1UbS+z7tFM4RHKsDAEC8gyQUZA+vqxrpymRq7pzYR
	qwwWHJoHS4Ojgf9jhlA55/dU3ahouaGpvIKfKzsI4suCJKb3jpB6EPuP953tqBT9eYhZc5Qnidg4I
	AixDUihu9ryaZBNA6+Jmq7/+Wt0jhGrEsH1oIeObKiYpjVkcC/+tVRZOYW4ocWfcA4YBeyr5Im6z4
	IP6ENQ/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHgNj-00000001GzU-1dxZ;
	Tue, 28 Apr 2026 11:13:35 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHgNg-00000001Gux-1rHr
	for linux-nvme@bombadil.infradead.org;
	Tue, 28 Apr 2026 11:13:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=WfpyHjjc+4pWe1sB4U/J6o0jNZc4M8ehpYZlOt3VPHk=; b=UbfGP9wD7OXMWmJJty21tLiEfO
	k4N5Wtkxn70Hl8YKTk0LQQId50Gz+444mDp/QA2XmHd2MOiOH9futIksbHNzuGaf3+JzWIWNBOuol
	IdsJmud9efPs/5/g9W0uEwvDCforM/gqKMwWoKS9HYayWMg2JlNF+0ucGfvXMXXr8zIhDwZ0hpzLl
	L2KQFogRiHLFurJPNqA+HJW3jqB5MpeJPxlFbnYN8yA8Wd4K64lzZ+g+7dGT3hlOAANFqbRywdoux
	iXle5wecdUZqub80RB2HiJzCzcT8Ng6IAmOjesQZXj5l7qGZvb3ardkdWyqDoQIzcJwc5b3leXDrB
	qI5wQpgw==;
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wHgNc-00000002pKT-1BP1
	for linux-nvme@lists.infradead.org;
	Tue, 28 Apr 2026 11:13:31 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SA8L4M2721969;
	Tue, 28 Apr 2026 11:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WfpyHjjc+4pWe1sB4U/J6o0jNZc4M8ehpYZlOt3VPHk=; b=
	JMDqnXyJ5+bb4IJfZuN5AkUeF/LtP04u9Mi/MDGWk5sl89fMU3dpsE3ZdvQbrDy3
	Lt2wHb0MTF3qv+szUNb93tFdGPNZy4iuiJ+WKL6k42radDHuFwGiphXeSm8DhuE9
	7f9ccKED8Zrr4Ec4sr0bGs3v0Y8tJ8F2DqnFia1vS/PdbcDtql0bm9E24bVpo3lw
	sOSDWdBhZbxLT2QFHTIAp2jqI6NIzvHHyWSWgyhVdhlOSq0fV4H3uVqpRqMJxNe+
	vNyfBJLchi2aOhJpNmCPQT5mnc3mOVNJNUgKZahBFXaThcTM1LZAlARgbuQWmsPL
	NQk+/9L3y0LsGXPFDMiniw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4drn7t78g0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 11:13:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63SBCjEZ004724;
	Tue, 28 Apr 2026 11:13:20 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010028.outbound.protection.outlook.com [52.101.46.28])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4drm2jm3da-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 11:13:20 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6Hy5buY+LA0b3qHQVFpeUZ+GGD0yWhlIqL7UmkLDrw/w2vWLg5vIlsBQRcP5QBNvZC1SXXEc7kVziG6VhQRPmwrL2wYzm8TUlR78U8/o37l6iJ5EIJbJWwDq8x9v+e2zi9+l4lgtAURhfaF90L4W0ACr05yO575zEVLrZ3gdFjX+W3guQdyh2xzJRmLE/ygxpMnYDmMsZaZQACF46TByPyXmZCLDC268hb+EvAtgf7gTCbrFDKjZBeJRtz6u2IvuC4HbP7CcoN1V+2jkPhNsovjaxMNqDHPxz3V2mlFFNzqEiwI9CId5aF0FzDo7mX2y6ZL1gTeyUGMf+UEbN4fkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfpyHjjc+4pWe1sB4U/J6o0jNZc4M8ehpYZlOt3VPHk=;
 b=Gx8xx46DyB2HoPEKXgJ/pbfzMTvIayP6KYV838zi+Q1sA324lIXHEmIEp9uv/uMaKo0D+cUsl9DGF/9v7ukCcqx87uLoM0YZDGszwob1kqmer/CXrYmzaSRwRdSYPyg+JjQvalnshoda03/Jlmsu/QE1uYOjHbdxvYMP9d2yq71exstpj6j1DRXzAvNCD6NwUz86M4tMmiYM10hQdi51rOJ5PFek1bgCPAg3+7l2uTrOWK+eajbKr7X85PigMjECsSeQWl7hSqEFz2gCj/X115gk03Tb2Lq/njXOWhdVq9dpClKgn8aA5zYDojh6obyuAQ0+baYDzxiG8xtPS21IBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfpyHjjc+4pWe1sB4U/J6o0jNZc4M8ehpYZlOt3VPHk=;
 b=XzquvxT6PfwZkip9QyNa+/tg2dHDSuuAN+b1nSIO+7Z++ADs7zoNrH0wJvQ2HFuxz2YWcsRu1XkGH9OziL0Wp2yQUlvfJVv+Cosb80ZFqMQX7CKGHRcNz0r5j5XYXtvCdgt8woPE/GB67Fk5OHX8qUGjK8/yI0g5N+S5L6SPDuI=
Received: from PH3PPFEDB06D67A.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d6) by CH3PR10MB7458.namprd10.prod.outlook.com
 (2603:10b6:610:15a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Tue, 28 Apr
 2026 11:13:17 +0000
Received: from PH3PPFEDB06D67A.namprd10.prod.outlook.com
 ([fe80::234c:e047:21c1:6d16]) by PH3PPFEDB06D67A.namprd10.prod.outlook.com
 ([fe80::234c:e047:21c1:6d16%8]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 11:13:17 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com, bmarzins@redhat.com, nilay@linux.ibm.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 08/13] nvme-multipath: add nvme_mpath_get_iopolicy()
Date: Tue, 28 Apr 2026 11:12:51 +0000
Message-ID: <20260428111256.1778475-9-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260428111256.1778475-1-john.g.garry@oracle.com>
References: <20260428111256.1778475-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH1PEPF000132E5.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:518:1::25) To PH3PPFEDB06D67A.namprd10.prod.outlook.com
 (2603:10b6:518:1::7d6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPFEDB06D67A:EE_|CH3PR10MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 634776ad-aaa5-4b2d-28aa-08dea51725e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: eo/0QeT34U2LV5PxlFKfD0ZLG5PCQLDafFtNoTZlx7icjE5pi+BIwK7vcjU5LUX7Yv+Ua5SN8YOfeF/9rR/ZOPLqoa5jckzpRLXS9uGgyUPTD9f9NNp0944N1ap/6CYGCKlBDIFz3MNtoiHEcdnFfXshghSDp9kc2jClI3xRNYxIzjIcm09MHWNWaHgpVsaTwlaZDqNrbn71/2O4avnmR6bZZph7CmSz0DifTMwaEv7ihUoUEOAQym+oL3vS6K+eItM4ldkgBh4NGwnabuUpsHsIh0aS/fAqslbETTrMoFHh11j280zwEhVqMeGa3g3OlCAFATJT1YmZY7K8J5KFel0B2hFpkCCzM0DcQeUtuasJg5LtzmvnGvfcoP38Sw3WrF1ssMcMIdd3zpayhy0AJkFLgQ9LuSAcEDmNcEIjh7SHwGDzqCbtfb2t9BNlxE4rDHkM/G10wZW5kD0SqCxam6+iAgMq1jf2OOFV7egHOVSAHNEEwsZxh4dYxnnIGhrtGBnV9QhqqMuVtETXA9feAYWlASknquwYToHWEHfdCf/ZxRfGCTqx0PrOSFO+Ob1aU7uagDJL1l0c1sqSrU25oEKnsIxWeyuls/e6YVMvi4xBnTFfRLKATEmbSkQiWtVX24w10xT94HsxyUWUHmKXrwt3f82bDpFqVhg0PNNjpC009355sfOj5KRxjFkAbiCwpNjqzgyrl1BpgnSuhVIL+UAkd15v6sOkNcrSQinHAj0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPFEDB06D67A.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n/l2yOpoYikTRuMUUl8pnxApXWN/aP0lqlW+EPRkam+hBOOejopOKqB4H9Hj?=
 =?us-ascii?Q?LvvB7PIeDAN5IyHGKs8KdebHTP71jHQAFnWwAbbcsPq9a0IR2gip0Ruent3T?=
 =?us-ascii?Q?Umrrr3wQnAGd6Fk3oiDGOSeSypbrrbFS+4hPGCkUGodeD6o3E1Hh2/mn2CEl?=
 =?us-ascii?Q?PNxcqHaq5J6RmEKe/bTrjpXOvEci5kGJhfZyK1rQDFwKn7QEvm1Zxby0tzrg?=
 =?us-ascii?Q?RLMQ6hXeyc4ZGkrwkCaSDBM9jod756K+apfuiZ0aUw9Hdkf/ZpxpDrcL1vTY?=
 =?us-ascii?Q?V4YQUSW/1NQzJrSaNLsHdfr5jtA4iTAeITbNpgYMhYgHKKHlhFVZ7TxThFjJ?=
 =?us-ascii?Q?dJezq4Ii2yfKd7xhSRHENqYX71j6dYt8OdZcXsvImL6bobyhp3yV6TuDYHJ4?=
 =?us-ascii?Q?aBACbJU9ahRmA7OUxG6QkSHUqIllRkBDuQOsdQ2Djkmx5HACc64ZOxHANJ7Z?=
 =?us-ascii?Q?18YzheDTl0bqK8zfGRdeKUQ5xm0YYg2GKJFRp7iQxdAXv3VeHMqMojt71MzV?=
 =?us-ascii?Q?5S13HPhfFUkqBdZUeOykd9eGp1USuv565lAQQqSmC+t682Vk0DkOlewh3zSG?=
 =?us-ascii?Q?WsSS//0sEIvjCMU78HCyCqSzJsyzmTAW6pB/dVJZdScm1hrBPsqZmaZEgWxc?=
 =?us-ascii?Q?/n7ckB6hWft07bO1cmZieA7P1hcfvLi+9eHLmadqLb2wob1EyvMnE2f6NOsw?=
 =?us-ascii?Q?fhHbEUNzgLO2NI1VZxyfLM4hOLXBF0DspN6CABlwLleFSHT0R8WbNWqo3i6y?=
 =?us-ascii?Q?aRXxCKY6v+3PFlpJyuwT4sZyFHKrco8EHNgx2+P7pNzGJNqbjjx4QNvHrlpZ?=
 =?us-ascii?Q?jMQtAQpXiTQC6t6UqMkO6XzVlOFBZI5GdTZJXfiAQmmuILhIlTSH8PkOYxf3?=
 =?us-ascii?Q?l5UBFhtEeHStw7Jkt45sWhmy7XSEIJNIhoBxzsOK81sveosFkdOn89BvnU66?=
 =?us-ascii?Q?1rwj6BB3lF2rr5l+OCTf7Nia+GxWZtqjLBXwT7PVI/orENAPx23wLb/+qIqq?=
 =?us-ascii?Q?S+xiWX8riZMYMeGo9iF3SQkdCu5eV1p/uBJLOvL5sgCDmHXHfIq8LPdkVhxn?=
 =?us-ascii?Q?U47Oy6cEtijmnyxOGmPhE28dkdBNCnDWIxR3XPqsTOR8SCSoi+PV/I2qedjc?=
 =?us-ascii?Q?VeuGeeXKqxyMGazQoH5o/n4c6DotMSVfjNV2TPLcF0aIea6+YWgsdNeR9ySd?=
 =?us-ascii?Q?b5eZ8wlYecC52babyIZSbJvab9xvdYmYcZTWnEu6gnK0nqRYQzRPxp0Y0p2f?=
 =?us-ascii?Q?L1X8g2sL98n515SWgYbCdAHvVC6FCuZviPs4Nif/YMIrkjnL8yPm6lSf7IK9?=
 =?us-ascii?Q?klsiOfPe6jPRIfv4HEd3C6G5quIX00lOIBSZLUFCcEWw68lGEhWkonP7BX9H?=
 =?us-ascii?Q?1ubdZNZNIcqRASDvv+AdCNqwSDmpiTq66gvCWQY4Q40l8KdS4idXhzY6bn3f?=
 =?us-ascii?Q?ZFrI5WZ/lYHYGNoUGIpRo8C1VjgPFPHentNNHkikIXATpW89QpV5IdJ6Q/3S?=
 =?us-ascii?Q?TUtM1jF5hiH/dKJDGNQuMkZCeFK58O8g25ssk80c/JI2vb6Tse3HejOWj0hS?=
 =?us-ascii?Q?E6YhidQwYgYrjViw4VBKP+JxqNE+l3bZ5wTh53KEYzh7IhzXuxQwFElbk9EK?=
 =?us-ascii?Q?RZAcLLEcei5sMndakgOGi7syMoctrJSfrVIMiveH0JHaFx1nf7IBl88ktwWF?=
 =?us-ascii?Q?4NGK9iNPFtaUY7HRS44HtLDNXiCDL2bAFHqbtMgTXsWPyZLCzuZpdWq4CmMw?=
 =?us-ascii?Q?I8Kh/bL/p63jbZYDkpgD3rBDkRUSvqw=3D?=
X-Exchange-RoutingPolicyChecked: oW73pPT6FV8oE6L7YJiY7mSlskB3++bWjyM4Jn110oO1aM2dm5LxRKXs6PzuriePFF+w0BMkgvQ9cLSO6p4Q9QPxgOKMGexxZ3RQLBul+Hx+NxfDdVpdqpzfAuO3PJRLGpTphMIldQrMNCz8S+wmfLYIWAqCDY8zU0mbO0g90ItiFmRqOMrtcEUlU40xeNpaMFxShlHHn/IaG8M/dPaFiAL/js2ZW+WK6Jj7CseBe12PUV/Wv3bi+7JcFO5xEZPcLMHoG0hLg9Ozxz71brAv/FfCGMnw4Fz2qKuakN4DUy4gOOpJbc08IE6RdVuScFoYf/qHxIrSl7momcouydZOPg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LopoB7aXwYBx7KY5rGpjmKWLOFY2/ad+Quo6hmCkegPrWyKO1W25EPH8FSbyq9AuQ7zMBdzRl4VoYvQGyTH8T+kGgCHgNrV/ZZHHr3W7v5EP4NQ/CcLCy96K5+n8lL05aPZ9uws6uCd5ytBlbj5/LwUZv9zJO8atcUTfGSXnJ61Kv+NhOfCWP9H2ljaMYC3q8TW1n4rtFl0fBJHL5AJXhrkoKILG1n1ygHF8E/4N6FxeGFZmW/TktxKiRrTA90PRMfPaBzb/6C6+hW4wl4MxTXB3NZaHlqUWraLQIj9XnfgS4Ywk6oFkwkAQ4/nKUvNyFV5p+OMR1n8HQmhWAjRwwgBFoPOIp4wXMLWcy2wdyktW6F87Ef/xT/EHZLUDsWK3RUzxcTgS85VJfPx0bTL86bFwaJ5gP/EpW15dIDNLOEvrgkDA94oBleEmYbmnMEEZXIHdV8Q9smQ9n6y194m7ghVzsRJwYh5vulCzTumjXwt4zYrDaHktKal3vziTXKns3ph31IG3kNRb5blJq33DQLiHyRFp//48yK4ftvbMedMS+slFvQM8YDVqfftcNhEEDmz6TzeANV+asw5M/2MNf36PPwsojseTTDOjDeqkgm8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 634776ad-aaa5-4b2d-28aa-08dea51725e6
X-MS-Exchange-CrossTenant-AuthSource: PH3PPFEDB06D67A.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 11:13:17.3439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NYeDHCWD+UHbb0Goykh2G5vVmkcef3iICOQB0TvlCsXkctLP4+kY+lOiIttJGN89kNvqpfM903QfWyLSjSOg2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7458
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2604280101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEwMSBTYWx0ZWRfX0r+AGLtTqCzi
 PHik7CXTMzWrXS2sKxcXrxHkFw/591dcmuP8+KFOs26pNGYTmq4IsmmSSrkWGQ7f8RphS1aFd0s
 4WaFqZpe/fNG8yFd79jypUNtysMnDIuGhSGEK6XfBH4mmg9SbB3196+A/ccfZzqL2ZF5rjmeNzF
 Zbf7EsX3gB8b+RUNdOHedubmky+IwHWGuNcVFcVG/A4/nXkasOzvgf3zz0Azuy+2vHIJHfhZ4J4
 O/5Rs2lQ+O/FAMxbql//gSDI3i26hdxRpPNwGzt1BbbIYIXEycM9WU7A5RgMndhd0aBBuhYRgCr
 XjJSz0joPCdGpIQ3F9KLFXfBdYEOWfVSKtTUql6KPyX0mKSAHC0q2fyXmG97FT6OH8L/cf0I6tF
 baUY8INLfN05JTZ6B3dpdsEMpRjWAF3+RIeTndRyepH72glNwhW3PD29+jq8HMh8+J/4AsVSBjD
 QLLgK6ZTheTNGBqOlVIZNWU3XFMl8THL6lpmqwMc=
X-Authority-Analysis: v=2.4 cv=QO5YgALL c=1 sm=1 tr=0 ts=69f09651 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=J1s_sOXE37Cxi8vwOuoA:9 cc=ntf
 awl=host:12309
X-Proofpoint-GUID: RbWV8l90qncfKhwzSrUFZUy1HH0B8NRu
X-Proofpoint-ORIG-GUID: RbWV8l90qncfKhwzSrUFZUy1HH0B8NRu
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260428_121329_026577_D95CC30E 
X-CRM114-Status: GOOD (  14.49  )
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

Add a function to return the iopolicy for the head structure.

Since iopolicy for NVMe is currently per-subsysten, we add the
mpath_iopolicy struct to the subsystem struct, and
nvme_mpath_get_iopolicy() needs to access that member.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/nvme/host/multipath.c | 9 +++++++++
 drivers/nvme/host/nvme.h      | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a51944ca56b1f..8025cf3270cdc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1438,6 +1438,14 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl)
 	ctrl->ana_log_size = 0;
 }
 
+static enum mpath_iopolicy_e nvme_mpath_get_iopolicy(
+				struct mpath_head *mpath_head)
+{
+	struct nvme_ns_head *head = mpath_head->drvdata;
+
+	return mpath_read_iopolicy(&head->subsys->mpath_iopolicy);
+}
+
 __maybe_unused
 static const struct mpath_head_template mpdt = {
 	.available_path = nvme_mpath_available_path,
@@ -1450,4 +1458,5 @@ static const struct mpath_head_template mpdt = {
 	.ioctl_finish = nvme_mpath_ioctl_finish,
 	.chr_uring_cmd = nvme_mpath_chr_uring_cmd,
 	.chr_uring_cmd_iopoll = nvme_ns_chr_uring_cmd_iopoll,
+	.get_iopolicy = nvme_mpath_get_iopolicy,
 };
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index efa868ba3fbf8..01a7a25bcd254 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -502,6 +502,7 @@ struct nvme_subsystem {
 	struct ida		ns_ida;
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_iopolicy	iopolicy;
+	struct mpath_iopolicy	mpath_iopolicy;
 #endif
 };
 
-- 
2.43.5



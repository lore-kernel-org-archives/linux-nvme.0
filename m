Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD51D19502
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jan 2026 16:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mwK8jLmWzdfMMc0anWuJmoxGfalsU2EuflKb1kakn68=; b=svMnpz+lfsIYXOBANDAo4xBOoJ
	fNS6hCtl3vAdJMjBQvlxfHlC/ElewjIrV59rDUs3QVj+RsK3LNyhC3ck4wlOlImQAFeupLo0XeYCG
	v6LHShFcjYQwS13CKbM8Ixoigf6PDPgWHvz6xtDr8Srbb1ex0OU2clr+OglIGTMSYpg0ReRHhJfA3
	X3h9pmegJfQS3L7hMu3VrSpib3XF/58l1cG6znGZHHsriGw6b/kMdZk9PgOYEpP9rvzYib4SzVou4
	FC1Y/WfPC1rRoW8yncASnpyndSFMrilK6npyPEI7NeiMTYvvqzVd0HqvxAvwoeShJ2KPTfX55FSWm
	O0GTMtkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkPjE-0000000Ct1R-2qrm;
	Mon, 26 Jan 2026 16:46:16 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkPjB-0000000Ct0r-48kx
	for linux-nvme@lists.infradead.org;
	Mon, 26 Jan 2026 16:46:15 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60Q0PWcY1194112;
	Mon, 26 Jan 2026 16:46:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=mwK8jLmWzdfMMc0a
	nWuJmoxGfalsU2EuflKb1kakn68=; b=HaD0LqWEuBQJtN0yQRsLcL1zCQRmCyYB
	wRUp0OQQQjCl6PG+PTGxNPwUTK83Br7Qg8H9DYjVLxhEyRl6qnek4W6gWrPMBkIP
	BDJzouFKlsLv4DgGL+lFfsG7MkbyetKGLoLaAuKWUWD228OjBEV998Vj+odLC+Vh
	gxf+ArayxZ4Y6k8aj4ZM7/Dw4mPrYge4ntmY4q8a2IWu9GCDoAU2bwUxaryfuTxV
	827+j2rkr/+snkpox8+5SaFsz9JrI1OmjjkZDqZoNQXBKRYsd+tr3cYf1loRMLiC
	OGD/YvrVsR9ZpKKohs11iYDEF2JK992Y0Awp4rtC8HoMPsdXOmURmg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bvp4bt7us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 16:46:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60QGL2Bp001729;
	Mon, 26 Jan 2026 16:46:04 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010057.outbound.protection.outlook.com [52.101.193.57])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhcpswy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Jan 2026 16:46:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmVMljuasEQXaZYfwu6/94lsr+WvvS9NEsI4f8L947z1OulKaxSWEC3rW/zJPLeuyAK1/mpz0K5VXPEqBnK5jYnzRCnNCvvrPsQoqbQHeU9TEWO74mEtfTHll834rYYmAp/twse8/tCCKg7dTzDO4RZNfcWK634YDTqBQbyW8dZanIHp0UzjcSo9VuoBWSAJbwyPYm1axTYXkEEv6l2CED5AGf8P3A186sBiSw2CQYbDHcT631NFKsA+LPInPi7OkT1XUtqHQCBBk46c/vmBm00DzF8j/daC9yJew/EN9xp/9deCUbs71heCK9oG/vfIzmgSij7ps6I5pQp/hMjR2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwK8jLmWzdfMMc0anWuJmoxGfalsU2EuflKb1kakn68=;
 b=TNF1pNOarA4uruC85FbiPA9QRv4zNYQhg1ZRa31vXlpP6QRPjMk3To5egJCl+xtn/K24y2TMtIBIogO5m0nvrhomdLX81VnFNdjyhyd9U9Us0OOpkffSsITCxcSZVxlEBKOucaeQY754SaHrh851gHk05DfW114ewjP5hFHge657/fpx3/e77HG3/NxOSJpwH0wICcJGTNkX4ZbmhsS7DOY6NQZ3n/nbDaEkKR7JK6lHD2odh+89bTb16I2JXzcA8xZYdIauYlzhDHYtVt9FgogMxu69WhGaPzuZ5QLrTOaY7UXcOMv+8JnDus2z/F8Y5UIvpiBh5fK7xkZDGj9Qtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwK8jLmWzdfMMc0anWuJmoxGfalsU2EuflKb1kakn68=;
 b=R//B2wbJXSEqcFK40beCS/MQaqK57rZHTan8Cn4HAgGthWg5A54YxaA6JGerDZlhtmpAaUkIrfL7YhDtPf+l3/h3/l0i9bDpmCuFPetgfTz+tIF6koYErS8EifPTyi9spqar/0yV45K9r3ngaYoV+s39DTPx6EYS/+xWJcppAWo=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by PH7PR10MB6310.namprd10.prod.outlook.com
 (2603:10b6:510:1b1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 16:45:58 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%5]) with mapi id 15.20.9542.015; Mon, 26 Jan 2026
 16:46:01 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.g.garry@oracle.com>
Subject: [RFC PATCH] nvme: use NS head lock to serialize access to NS list
Date: Mon, 26 Jan 2026 16:45:52 +0000
Message-ID: <20260126164552.3379194-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH2PEPF00003853.namprd17.prod.outlook.com
 (2603:10b6:518:1::73) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|PH7PR10MB6310:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6fc482-247f-4089-8f07-08de5cfa6367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9FAeJJF+sJrXfEkOZ5D1WnxbkOoStGt91dQJ1cRbazEX3gfX4LjrGjRpChlf?=
 =?us-ascii?Q?fjpM0DXoPp2Rr1iLZMi8iZ4RHtuZsdAfFb5t6/NcQBlAERLghqKtMLiMaeeV?=
 =?us-ascii?Q?FOdI9EykkNa5Zfm8YL/bWRosFYqjtK+fRKhiEDgC8lf6TLfaB7IbIgc2SNFM?=
 =?us-ascii?Q?VydhQXiIKShjtRsraVwUwQMl9U4aBQSRKh9FOE/avGNpDu5Mq6PCT3awzJfy?=
 =?us-ascii?Q?SKmXP4Brkn65yauNeJvESNMWaysJhguLSAkUG3aBAUudHCgV3zI+ubP4y8g8?=
 =?us-ascii?Q?AS9blN5AwwhxtzX0WbcWLVHn+LWP8ZFHKfgkOlvJZQmOgc+QWC1zTfbBJeAt?=
 =?us-ascii?Q?CQticyyn3j0usZEpKC5AuVa/wo0zfckE1VCc+2api9snXKibGJeP/Cx19XZP?=
 =?us-ascii?Q?X2U9aJTNB8oDqXOZ9UOZYdhmFzJBNCDDlloK62lhoHBjgweUAiCRjl+lRcnZ?=
 =?us-ascii?Q?jX0cEnKpfp+W1wu1Wwla347NVLTFb0jAnS7kULHlBGCSYWUMEt2KZcCDFRmq?=
 =?us-ascii?Q?gjKxUjlkJzdI5ZcV7oknFX4KTaYWdw5/cBl9bZqydtaDgw1/ZhNxfgSBwHsY?=
 =?us-ascii?Q?qJnPNYqem1Vv+I2mbgZFhUGIOdSgcrry4arIUsCdAwZZ8Fr2WHmCgLscabX5?=
 =?us-ascii?Q?xjSFDB1BOskHrjBC5/oIGw8F7DIMi6kHxxDlvMFbXehK1kWgiw1JDxL5Nh9m?=
 =?us-ascii?Q?5xeDuqDTfllloBIV/l2frNax6w3ltzIuLugBvmZhIJ22KLmPSq6UncgDduao?=
 =?us-ascii?Q?cIIA+jfwdyhvUN0zWFnEbma6/HEYAaOZwBsetaTrKq40AjBGaKJ2g1aYqFsQ?=
 =?us-ascii?Q?ky/vHXGWUYEzseN/3v1IyvVoIqkGJy+koOhCb5oyElr3VpjLdABrxmLia6fe?=
 =?us-ascii?Q?7BVLQr5FtlJFy1upldAA5EIReC9cTRe8jQ5KRYBjbwJSe6vJwk8bnpfSVxgg?=
 =?us-ascii?Q?NwlUr1d2wr5kfi4SHLRU9zQZ7nZjU3pI0w0FjwBzP3QSHUTLIkxvOpkh/XiY?=
 =?us-ascii?Q?GamO+6d/YYY/TmXxwRxN24AKXl/W8H12J8/3ETAj9L8O1zhKJtDWCTig2DAh?=
 =?us-ascii?Q?Zfr9jsoEKVGU6jVmf7KlR0r2V1y6zEenRFiSDaR8AFK+FyCLGCas7p2Jn4mx?=
 =?us-ascii?Q?oSHUZB2ZQrutrk5AHrbsWiUp2ZdKcoa0oXzqzTZLGzqMMd/2X+dDahPOi6tm?=
 =?us-ascii?Q?E70OZygKLI/vaURMQMzBviL0F3Fyk6y1/TEB6N9TMyh2cCaDS7Vec2Jjecq/?=
 =?us-ascii?Q?UBD8+nDBQDnX4VCQSQ61DRn5rBj+8z0+LqvrdKsgaNIMRrAr7EPyNzGrSjwx?=
 =?us-ascii?Q?jutom+x/Hjq77Gzq8IRHNLxPJhKjRQoFdtzGMHXMDIorJINYoZbZ3WLcY3HE?=
 =?us-ascii?Q?UVkcSnStVN92DOS3bZgVRdseUwo2UklhWiVeqKeThW0cYr1DDKsQzN9qoIYm?=
 =?us-ascii?Q?RX0VU6ZdNDcBZoYz5aOvRub6Ts07E1j9NAtlzKru13v3XiPYnk0jxKoWlno1?=
 =?us-ascii?Q?tZ74umJaXz41QB9vmuZy3lU3oa9mGhOu2y0YIGsesVLxoZvPLs+/7MBfuu4N?=
 =?us-ascii?Q?OWv71IpyGLsy7X9kKc8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7E/pMU8+5v8k00RRbtnpXiAfzEgw8wIcI6QveqXggPNERenOlAxpAQCrWpQB?=
 =?us-ascii?Q?GNphFuZ0XSTSVSSpFxP/OvWP6ooDHy36MPD8INaXDnfjEPjtf19ECB+D4qwH?=
 =?us-ascii?Q?mKmQ3l8nGdfMdx33UfTYMGBCj/PhF01lpNAS8qe3J6+Ri+gV8Kp9VptqBExJ?=
 =?us-ascii?Q?DfshtCF0bNmHNCEWgq6rCbA0+zMRNenn2Amf84qqa6VPAFVNTCvc5chvNRIh?=
 =?us-ascii?Q?X2qWfWt4cMVoF6JDU88q2hB6+ihv8IahJmhsfoVdNMNZTjYoTRJa4ZfVCHhu?=
 =?us-ascii?Q?rOxYthesHJjrqJ40bik5O3eQRywESvjch6+/JVP5HjilQNJoUGswZQsJers+?=
 =?us-ascii?Q?a/34cMN4jvocaSx9jq5d4RKTZgUDqjdymlsHqH9XzzJIgybgeCwl/VsscHLn?=
 =?us-ascii?Q?IvCwmSjRhKmj97Ey6v5OxM+0R08pemUIAmg0sfagx1eq7TDmYK8F/2TwwrXP?=
 =?us-ascii?Q?0Le6A5P96o13NuhIYUz7PAUfR/0VSf2bxUQ64QmYpcIkqao1ez0U3FXF2yuA?=
 =?us-ascii?Q?RJ0VBzdFMzvoqf93+/sJAW6tsGgjV8DIa3usa9AjZpFSl1bGvjv89LB8qmG+?=
 =?us-ascii?Q?Q8G887+nlVnlu1vVeIGJZMt80jzgu2IBn0hxEuKE7h+RdCB51Xjfyb0BGaud?=
 =?us-ascii?Q?effA+z3SJIlcP1CqB+VgVeGJOBi34wuKbdtjQ3dbcDOEW/fw5TgsvXotoOkr?=
 =?us-ascii?Q?bJT8xx/egEf6C+waCkoWmvcwkes0MaO0Wsiu2YHfQHBCHxgyG4Eg4yPrijzg?=
 =?us-ascii?Q?5osMV5IC1EafpLp+zuADIQoCfCXTK+lw5FctDXk8RJLPyMDKPDpFnd1DJ0F1?=
 =?us-ascii?Q?d2ABe9JzyUW2A+EymCIsrPXf4ixhM8+1m7MWUXbm79PAL360ypdDjWLkqsxQ?=
 =?us-ascii?Q?xa/wMU/z1Lw3WwD0akX8NlKy64ccLkE/CLR3MlYh6yuVM4s2Hd6rAmbHuhDA?=
 =?us-ascii?Q?w0Zu2txke9PeytK+Dl2/J6vB1UXI6yDaAAZ3jLeFWFIybbsHhghmhwzwPs7A?=
 =?us-ascii?Q?MQPplIkf/0RpVyiqwnF9NO+5U5LNp/ULTknjFtKtQ38uRJajpcLv0C9s5ddg?=
 =?us-ascii?Q?ZR+63Ok+gx2eSX6ZXMHFY2RTxJakWeDlsEhul6glU0NdMW3Trf5DfYwMNiTt?=
 =?us-ascii?Q?8ILE38yNgKPW0ez+ubpSEl/NLmMhWBKg++lmSQN4nyVJnhmpL09hi0W+ar45?=
 =?us-ascii?Q?O8GxJteeB39jor0k0zpm9YKPGfRgX06TsFBEmKagrXn6wCObtAbkmToy8bH1?=
 =?us-ascii?Q?RknuH5dxUqzPDntT8XQrG2A5wopi1HNSE/2HzYn9D4isLewEPFIkvKFg4vbH?=
 =?us-ascii?Q?OQGQqtt4vG+HJcnj98veiMYDmph4ebKgmdFltL2d9FTb/ZoBlr03DlWx0t2K?=
 =?us-ascii?Q?7ucPYi59d4Y5tO7b/ILXjbqg6BtvEGr/rJek9QLYjh0NPf0TxdzIPA9OtCXW?=
 =?us-ascii?Q?2Tqs9EmGPPKdommKpoz66oMvrHonmvpe2FjwQsslGhvij6tz3wgp/Obb8ihs?=
 =?us-ascii?Q?jOLIDs7DXcpzum3gn7kvyFP/ULNTEESCUgfWLfTmCVX6ucL82gles7xER5rB?=
 =?us-ascii?Q?jlpIKx8p4KZiOxCFYbJdOv4pK1k2MaDg7VL8tEhk7Z2c2ITh+pBNDLOYLYGv?=
 =?us-ascii?Q?tFnfRa5SveUJmwC01Vb668iJlOTx8C3MO2JF2WZ3TcIxKyxIxjlHaCSdNQ7Z?=
 =?us-ascii?Q?EvMFn7VxDqDF2feRfqIP4RDZZw3imK25wb6Tq7pNOYnrp2HYbRuZtlPlmMeQ?=
 =?us-ascii?Q?mXST7ZBtn1rzPy/FieoGBk04kg58CBU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tpzkAcA8ISUYtxoQm942ZKZUCvqHjiEUmUnrj3QkQgFLlBG+0A19cb8xVDKe/NJ8blYpQy1dXuy2nzDXo5yt8PFdbQmxE33SCiRWr+VC2d2VYboRHtZodT4ityk2em5KMY5IkYw6g9xT+KTC3UHT4OvJ7pUBwAxAgcEsqTsQF7r4jKjYmgvQ42AIN1re90lYNrtUiDgY5lJ9YPc2TL8zemp/iKdPKmuHtLh3veMwqpvkv/UGA3iaTLs3IbUL1yKklHBdimeJIp2T4coptlJFd84Lj7hhWCzV40ryqf/KkZ5PfxQo/ZIeLZHmFJJ6rlgxs3P7ASDz8es1GXqdAvfnb5saHY5fTiXyWozGeu+4oTCAiMovQtpt+WnHzVAnWlu5fUxh1NaIimesOdJu7iLDESd48HQMKwveyQovpQLOw45EZaS68hnsH4vJ2gRxBzV3aBy1QASpo13NgMALYicwy377J5mvxIfSzHZ3wqjIeW+9Pz7pMgL8ITxjnjqNc2wBUZt+RINApK1NEz2zxVImJuQNmgwLobB8xvy4NjzfhgeEW/0wPpIr6jmttegC2Q4Ff8magrlRNLh1faFip6qrOZSFgH8wvDsnI6dThg84ymI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6fc482-247f-4089-8f07-08de5cfa6367
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 16:46:01.3984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIHNlbXw+qotNQoDOxCgui/a6OGwuJ4v8OgFsZj0PYShNiTtLpX+JHi650bpiXgBvdH5mW9CQur3qhntAu7spg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6310
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-26_04,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601260143
X-Proofpoint-ORIG-GUID: oDPeKsC2uJ9x5VFYPJ6DQydOx5xC6luX
X-Authority-Analysis: v=2.4 cv=StidKfO0 c=1 sm=1 tr=0 ts=69779a4d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=y8LAbsLzBKnDFHaJx2wA:9 cc=ntf awl=host:13644
X-Proofpoint-GUID: oDPeKsC2uJ9x5VFYPJ6DQydOx5xC6luX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI2MDE0MyBTYWx0ZWRfX2LUSHe6U3FJP
 rjVIkMKEIxzOI+OewexT606d2XiHQlDp/JLiqToxl/M/3INC9Mwxfg2938oWLEE9io2LmVUJr3R
 6iQ5AMuIWHoUkCfhjaG8PXuApMceEfzMqk6c+IWfcuMps0hnbhLLpY7orO/bSxlDSdRF+slaTX9
 iFegXtkyS1WnK08cre/17ka8IujmKjtLrpIQnwAKwCvauAVIMJjFaepaCY6zmmFoLC8iVso9f0z
 wZoOywFa+kwZGjf4D8qXZ8YomG+1b/Xtbyt0x6edjxX4briadkL2awYjTJJ+B4UiFzY7kcOCLh3
 4KCQOl15zbMpswiKCrVfoXdClVG2j0xTCexvFNYbxpibR4TUOHrtk+J6MwPCbIRshyDMZQvTk/I
 QjjXuNx67RTVsVB1ML98F8UQkELmwOrWdrKc+lIi29HdzgOQlHHU+LLP+81GzdN7HvTxDxPoTx4
 fHBv00oHDW1sPv3xyj+8jlKFP2mInIS/3EIdcPis=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260126_084614_170720_4E7C2F7F 
X-CRM114-Status: GOOD (  13.99  )
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

Currently when accessing the NS head list of sibling NSes, we lock
using the subsystem lock.

Change to serialize by locking with the NS head lock, which is more
appropriate.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
I'm setting this as an RFC as I think that other NS head members - like
delayed sec removal - could also use NS head lock to serialise, but
I'm waiting for feedback on this change first. I also have not tested
heavily, either.

About using subsystem lock for accessing the NS list, I assume that it
was done this way as the NS head lock was later introduced (after
subsys lock).

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 82446b9d30941..a1054b3e06106 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4019,13 +4019,16 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 		}
 	} else {
 		ret = -EINVAL;
+		mutex_lock(&head->lock);
 		if ((!info->is_shared || !head->shared) &&
 		    !list_empty(&head->list)) {
+			mutex_unlock(&head->lock);
 			dev_err(ctrl->device,
 				"Duplicate unshared namespace %d\n",
 				info->nsid);
 			goto out_put_ns_head;
 		}
+		mutex_unlock(&head->lock);
 		if (!nvme_ns_ids_equal(&head->ids, &info->ids)) {
 			dev_err(ctrl->device,
 				"IDs don't match for shared namespace %d\n",
@@ -4041,10 +4044,12 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 				"Shared namespace support requires core_nvme.multipath=Y.\n");
 		}
 	}
+	mutex_unlock(&ctrl->subsys->lock);
 
+	mutex_lock(&head->lock);
 	list_add_tail_rcu(&ns->siblings, &head->list);
 	ns->head = head;
-	mutex_unlock(&ctrl->subsys->lock);
+	mutex_unlock(&head->lock);
 
 #ifdef CONFIG_NVME_MULTIPATH
 	cancel_delayed_work(&head->remove_work);
@@ -4193,7 +4198,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
  out_unlink_ns:
-	mutex_lock(&ctrl->subsys->lock);
+	mutex_lock(&ns->head->lock);
 	list_del_rcu(&ns->siblings);
 	if (list_empty(&ns->head->list)) {
 		list_del_init(&ns->head->entry);
@@ -4208,7 +4213,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 		if (ns->head->disk)
 			last_path = true;
 	}
-	mutex_unlock(&ctrl->subsys->lock);
+	mutex_unlock(&ns->head->lock);
 	if (last_path)
 		nvme_put_ns_head(ns->head);
 	nvme_put_ns_head(ns->head);
@@ -4239,14 +4244,14 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (nvme_mpath_clear_current_path(ns))
 		synchronize_srcu(&ns->head->srcu);
 
-	mutex_lock(&ns->ctrl->subsys->lock);
+	mutex_lock(&ns->head->lock);
 	list_del_rcu(&ns->siblings);
 	if (list_empty(&ns->head->list)) {
 		if (!nvme_mpath_queue_if_no_path(ns->head))
 			list_del_init(&ns->head->entry);
 		last_path = true;
 	}
-	mutex_unlock(&ns->ctrl->subsys->lock);
+	mutex_unlock(&ns->head->lock);
 
 	/* guarantee not available in head->list */
 	synchronize_srcu(&ns->head->srcu);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 174027d1cc198..4b2b8fc5638dd 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -702,12 +702,12 @@ static void nvme_remove_head_work(struct work_struct *work)
 			struct nvme_ns_head, remove_work);
 	bool remove = false;
 
-	mutex_lock(&head->subsys->lock);
+	mutex_lock(&head->lock);
 	if (list_empty(&head->list)) {
 		list_del_init(&head->entry);
 		remove = true;
 	}
-	mutex_unlock(&head->subsys->lock);
+	mutex_unlock(&head->lock);
 	if (remove)
 		nvme_remove_head(head);
 
@@ -1297,7 +1297,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	if (!head->disk)
 		return;
 
-	mutex_lock(&head->subsys->lock);
+	mutex_lock(&head->lock);
 	/*
 	 * We are called when all paths have been removed, and at that point
 	 * head->list is expected to be empty. However, nvme_remove_ns() and
@@ -1324,7 +1324,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 		remove = true;
 	}
 out:
-	mutex_unlock(&head->subsys->lock);
+	mutex_unlock(&head->lock);
 	if (remove)
 		nvme_remove_head(head);
 }
-- 
2.43.5



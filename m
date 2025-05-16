Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407D3C3ABDD
	for <linux-nvme@archiver.kernel.org>; Fri, 16 May 2025 07:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5q8LwEWP1sW1mvn3nRyJ6MSQcjcegLlp/LRtg8v6MCs=; b=WsiTmQ6ouprhdhYW8eSCq6uR9d
	V32wkCwcqUjWxmWx4UhCxDbNUxHS3ZVIuLBkwBR+Q6I2ji6lNMCehfZMELhZNcX3L2NY1JL83AVJ7
	yxs46pQz9BZzPghI7daNqJ00KwUDY5DVgBo8/BSr2u39h+WWd0Kx5UdLM7eqHtcFOQgtPQa9oisEo
	PLGqXcbpMdGybbsMC/1uUGKVtrTjnsIv295iJlIKQBsOsY7k1OEP8VG3WCwWEa3eZniAc5wARxq2Z
	2ryMMLjHMZqWou4g6bHo084Q5K4ZkpQwMkPdqW8nQTyT0xGcWXsc0RyirYsO/Md4nyJyoNRyz340N
	jN3h7ZAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFpGf-00000002dqX-1nQe;
	Fri, 16 May 2025 07:14:05 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFpGb-00000002dqB-48kn
	for linux-nvme@lists.infradead.org;
	Fri, 16 May 2025 07:14:03 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54G6u2jE017182;
	Fri, 16 May 2025 07:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5q8LwEWP1sW1mvn3nRyJ6MSQcjcegLlp/LRtg8v6MCs=; b=
	dM14IC8HAJgSMpOR5BxukhQ/pM5WBa/RpwS5gx9YY47LDqhIUllWF1jA4gsgA/+E
	DVoRKobZfJjN/0W9b05aR5/t209MvGW+aX0labPFMc1e7duRwvYFoQuEQ70gkN+7
	hNYFNV4rioca+6mQHs8/PDlj+KmwYIN1MmfnNvNAGZp3L3WQAz5o3+2GGxBc36G9
	TEnj/qESiAY/KR9gy3N1xTbGYleG8FVEHgntDBO6Fg0s//kyl70Hw48OCozK+EY8
	ZLn1KQ8JTE9x4L3p4ID3ysVNCKGbYD6zrUNGlA49HvJQ04SXkdPHPvqTgRA/jL+6
	7OGSfVDHFWmiNzByvvDFAg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nrbdgtrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 07:13:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54G51vW4016209;
	Fri, 16 May 2025 07:13:49 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azlp17011025.outbound.protection.outlook.com [40.93.12.25])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mc35rym4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 May 2025 07:13:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ln/OIDzDVz+i1ztINbeOprWFIWc95YlInSDzDLyYZFpbc73C1gMksR4s+773fDsR/5u13jDV20TMlIHwFcq7GnOvAPk0hd3LkgeAhblEkgW4rz3oMV4GJ+oCsOeVardlGtWyd5wQRHx3a6bpZvOsF9WpM10YSdtR5gFDoNYHzjRdyebrGFQ0n+549+7GOveu92MIFglvFLh6KJfMN9i8nIbKTh7i8uGY9d7WE97IGhK/Dzhl+f9kCC43pBdl7ZXFJc0d2bu5aDxWbm1Aee+yhr3Uz1P45HQOm5q+7LgP8jbfJbijMHO2k41tazDB3F5I1lLYSu47xcbqkSzwoWXbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5q8LwEWP1sW1mvn3nRyJ6MSQcjcegLlp/LRtg8v6MCs=;
 b=AcS6AmZ2GrpyUfWP5oKFwdVMilfc65YDCHwQQ4Fxr4OZn7FdkuXPp1fCRgqXFDJxqSvKi1TkKu4nIZPzHfM5iwrWWhw+X/SOVnWNV8yVaMcEBrBp2SNA5FbCMgmpN4ymd+HfaGmSEAy6gaQUJ13S9gyESvZLNJIYi9+ogb64KYlHChuGU1aIhVxl/qFJkS9ZwxtxMZHe08XlqGzBtZBBRxqhMZ2iT9R6Oo7S4WctQy3gE5N+jCNhIJi7domJ04tHSEf3y7ocF2DkPa8WA5xT/dHqA6aO6FFM+igN3zUw52s+XlKbLY04eH038BXX6D3OyezOqSNjhRCRu0ZEKOnsKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5q8LwEWP1sW1mvn3nRyJ6MSQcjcegLlp/LRtg8v6MCs=;
 b=hnO5Z72+uyXnZrmL0C2psCznlp8DKqo5DBE49Z4CuYiKY4VB9GS7poR28ae6GGZGjEa65ywRFHhwngzC1yaLpp/SG6zF4A7YDE2reGdcj5XIHxKXCZECcVk5//HWhS4ongWVkpFP7Ng/qXCKBQwH4ufYq9WBeu7p1JgTBPr48cA=
Received: from CO1PR10MB5505.namprd10.prod.outlook.com (2603:10b6:303:160::17)
 by PH0PR10MB5683.namprd10.prod.outlook.com (2603:10b6:510:148::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 16 May
 2025 07:13:47 +0000
Received: from CO1PR10MB5505.namprd10.prod.outlook.com
 ([fe80::6f07:e5f2:9b4b:75f0]) by CO1PR10MB5505.namprd10.prod.outlook.com
 ([fe80::6f07:e5f2:9b4b:75f0%5]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 07:13:47 +0000
From: Shminderjit Singh <shminderjit.singh@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>,
        Junxiao Bi <junxiao.bi@oracle.com>
Subject: RE: [PATCH 1/1] nvme-pci: Add quirk for Samsung PM173X with Subsystem
 Vendor id:0x108e
Thread-Topic: [PATCH 1/1] nvme-pci: Add quirk for Samsung PM173X with
 Subsystem Vendor id:0x108e
Thread-Index: AQHbxiwZPVUxVm00HUyKOHhM9mH4CLPUzWEAgAAIMNA=
Date: Fri, 16 May 2025 07:13:47 +0000
Message-ID: <CO1PR10MB550564E355727779E441B7558393A@CO1PR10MB5505.namprd10.prod.outlook.com>
References: <20250516063059.3456399-1-shminderjit.singh@oracle.com>
 <20250516063059.3456399-2-shminderjit.singh@oracle.com>
 <20250516063632.GA14830@lst.de>
In-Reply-To: <20250516063632.GA14830@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR10MB5505:EE_|PH0PR10MB5683:EE_
x-ms-office365-filtering-correlation-id: 346f91b9-604b-4383-38d4-08dd94493364
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?iovx3LeoIw90fFLL9snGMMKOVMSJFceJ3XfhGlYMYfSX68jzGY4/mzm8vD2S?=
 =?us-ascii?Q?mvP3Udj0eu0ASkB5A9kJHETgn+iwQXjbz0HXJqJwxgX4Rccxv1LdE65qtmYr?=
 =?us-ascii?Q?CMIA6ZUET/DwJ2D+ZnfCUy/yCDoXdpSLegogrDwXfDXXD5OtaA93gCMV+ILF?=
 =?us-ascii?Q?uRwYuLmRIJn4KwNOvOAKIM7aABhRFIjzzPGdIV0b/eSn6B9ayvrlGVqLbJAh?=
 =?us-ascii?Q?PGt0fnIeTxLmlsYsER0kPlSarWFCeVxVtF9vjyIl+Tb0l+eWGwIVjw2FtCI1?=
 =?us-ascii?Q?tk89EE6FYXqCbeA8vwuE2zXSf26k3MjmusYhxKYdsJ5hFh/SzVJb9Ao4olNm?=
 =?us-ascii?Q?Ye5Bh3XNu88JiqDkx+95IevJ+YRnDnKqARIDK5voJSWVbvDhEDHchs2N0EBo?=
 =?us-ascii?Q?bMwK3ic/QSw+3xDBniqeRG7CocAF6bbuPlGrzvbD7Reh7DpoxWnqPhcGS1CV?=
 =?us-ascii?Q?w44DGoAZa0SlFubHOOJGcRtHp3ANWmtGICA8kfb2juN353mBGawJodNBAsIa?=
 =?us-ascii?Q?GKScL0M2KIXmiEkBb9133AUEcQNsSForGItYERc2mfCk+RfJZCtoUkKpEyQM?=
 =?us-ascii?Q?hzcfHXjm3m7q/dveZpAiV3HRM1alO9VzzttEKaFBWpShI/B1nUUZIQrBkzJe?=
 =?us-ascii?Q?xbCWdb0+/ooOz/j5QMVT7oJR9TPnD5iYNlriQDjp1QVn+AmNKtzCEfzZ7OWt?=
 =?us-ascii?Q?843qbCbUsSR+db3KFS/NsD6m9fp7pj0Ln/OKvwFnHndzEj1l6bvJnhRsvLIY?=
 =?us-ascii?Q?8n5LLbFxxEAAZ5hXVNBajkWGZS3/pbCaFwSOSMt4UanTuadxVwNAWc0HON2r?=
 =?us-ascii?Q?mQIJC5mog/PZUrrZpkKNYApnPqHDSYwYmkiwXw6MrzIU2Fo9WwbS6Lv0PKEn?=
 =?us-ascii?Q?/uyqDFnRbnP7ZndEIIiyhSbVElzjcbKXivrkO/AzUpyFvHnCWbDFrakFoV73?=
 =?us-ascii?Q?PtBmxNnbrJ0IglaHZuaoUhZjpqa40noPWnCoxCz4pqLwndYief/6lOhAhC/3?=
 =?us-ascii?Q?2zojc8+FP0XNy0dtNu8AUb39ZAS6vmkk4xRRJ3eiDUJ3ExqX1osfgsWuKykZ?=
 =?us-ascii?Q?YSPUteD3J7n/Pu22kPbIMHoz0esSE5PN8bd93Oas4JFxxZnMYW0INDEWE0tZ?=
 =?us-ascii?Q?jJoTHbPZKQJmRxl0bZS67uZSC5yCXt9eFBslCTOpwnHtLxBbBxSn2Cc483pa?=
 =?us-ascii?Q?LKbpC9fnpUW06G55WdyeSuS/Wb/DJ9iaeA66YjIjvGUphWYDyxGxVIrx0tlg?=
 =?us-ascii?Q?+XxxycFb/3lXE0bANnLn+XIMcZknQgbp+yLtfZGxAClOjyEADO/pznLFN5NQ?=
 =?us-ascii?Q?1UnE1jxCZPGSUVvtL5DyLDvgr80HYLhv1OfiBnzRMeufaKkaztUMPmhvwz2u?=
 =?us-ascii?Q?Iy7TiGzk1LOYNZ/58gi29/F502hhuZRYhW/vTZIIump1IkASHyF5I3OcU6gI?=
 =?us-ascii?Q?fLy3SkTumMSd9/kXtcLsMKM7MmfnMCRmluWTJTFPPHB0mfLrKfbCjg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB5505.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OeEPGbEHp1Kh5z0MGXdMmAGXaQ8Iq72yL53vRLkuJB2f6vsJRAh3m3Us1z/D?=
 =?us-ascii?Q?/DvFYyq5jIxx3+H8iU10S4luh/NfajXa7GvpDbFFChsI0E/PdloTjW7Y4jj5?=
 =?us-ascii?Q?OwNLNGXmiSKRpAFlVyvb0h/Z+H2pyGJz+YO7ePxE8/dbgzouTbDCPYI0ajPU?=
 =?us-ascii?Q?5ue+rINE4WwijAs7J5j93EROcXYfgfmpbUKrPCVLRb7r3JpFCZeha9qxQv8h?=
 =?us-ascii?Q?NZ2DuS0USyI9WWFIwQHif4d2Nyf55N4I43WMWNL60KeKuTQ9Ertg5/qv/U3a?=
 =?us-ascii?Q?7cL3o6jnYozTxGA3WhRoAKoWYBDQmVFgs/1YQq73F8De9bGX8+t1zadCLkmY?=
 =?us-ascii?Q?HqJAJV1YyaY3h+Vob9viPdFLVvGqYb9Om9UslcS5sjhQZeMBKovh2hi7xbYS?=
 =?us-ascii?Q?rAqpxPSD19G/FqlWBXQECJ3DemXVS3/2e0mNYb5m82lntM+ZJ4VxJ33eyex5?=
 =?us-ascii?Q?Wfw/Y906GiklBLQF7oxHALZGL+N34G71sXVIrDK/hOgZBLXaakWU0SO/bqq4?=
 =?us-ascii?Q?On+5g1M0N0cuJZ0B8mL44+2ug8Up3Z1dwo/mcf3BDUTxzDHkNHMDv/qsS7xL?=
 =?us-ascii?Q?yq0tsPqyWRX8JirG7JR5zn2vXZmTkKGrdl32k5EfHMfSM4yDwRiGkEhYnxO1?=
 =?us-ascii?Q?ffBtUQp9Q3XZHRq43rUnB/3ET8tI5zEX5GYOaR+wjRm5ZY5aOwkjnadBPS48?=
 =?us-ascii?Q?LbbAY2FVjnsC1OY+FSEZrTQuAMamOHOUWHjy1T/0f+Ylyg2QV+mgppX+n8tc?=
 =?us-ascii?Q?mCienpk1uMBXGzWshmMluCa2As8EHr4PiiT7RMafV1G0Ks1+M+5tHw3I99PR?=
 =?us-ascii?Q?LaED0+ac7yAZOy+i0ZCrmzK2h9UlCwl4odRLIpHccSV4WsRN2CuqYd/0CW18?=
 =?us-ascii?Q?XiGxxeI1or7I0xepS38gTHWyTmBNhPpbInOSRMQMF1J9d+YDolFJv4ugyf+g?=
 =?us-ascii?Q?3iv5sK3KMTNU0Rfw8ZwthhuF9V4Eu7zhqrD070SECGudOTDQZZfRHKFng6Xq?=
 =?us-ascii?Q?tnx/CrIPLhpYdRtuwAAWt3Yp2So781cJCgyfZa48ZSnZUlImoT+MWgMnlIe4?=
 =?us-ascii?Q?MzhVjOd+CVSf8jk0q9jMqgn7ac01U6PcYW372z8Rx6s7gw2dz+v+czRvvGYt?=
 =?us-ascii?Q?ZSkARZCjJzVJlQLdAVmeOFHJ9wIRsBzegOa/haP7XzhzEXwLvqFV3TK+FDD7?=
 =?us-ascii?Q?y2+e+cMK+pVl+OlHTSjRaoq73DV0zGTstUJ8v1ETnBr+8P3bRHiYJ7CTqXVh?=
 =?us-ascii?Q?wd8J+5SSpx2A7d95F6GmwWEzjMrkM4BZ4C+RlBZ2efisJT/6QJ4gevqIGcR0?=
 =?us-ascii?Q?G1RwgVXqMI2Dy1NXrCBhP80RJ3afa7k9u0gnqopOmJwmkoT2MwJsmVgbMcjg?=
 =?us-ascii?Q?hjXKtzsxHxXJT2IEuot16VwMRvL7/5Eg1argUvCc0krsTF+rLLRLRTmo5GG+?=
 =?us-ascii?Q?xmPrHrd6JI7pBYavczQeGdV1DKxPjCF6X5GBYJswopu4QotYbdLxcm1mpG0V?=
 =?us-ascii?Q?MSjrv+eedrY3Ov+cQyfvE6cuuwUTTpzz+ShXIwag05LpoPgnOmox9UUc2CNF?=
 =?us-ascii?Q?IrBeQM09eFdV+FyNl1/jwlUyiMhNKsWZL6L5ochCY+fSOKtioNwYEB1+5mr+?=
 =?us-ascii?Q?jQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kWF7k5zWbnCZreLTRdrZvoPd10g+UnuOaypJrL6NN4lExkpnFxZqQ31tF449PJnwOdqocQA81p3Vxi2I4N1/4HawJ4O3/CgIyWdrn8PlX7LRBNtdugKqdzuavttSTdL6h2LytUyibqrnmqjcLMeiCEUG/ZGfi256ZFbNnf/9oA3u9oVNuGJszdyUBEL9FsF0gOFJiA5jyDBnOUxuJ8/eNlJAuGXmnEWgJY6MgZNbpwyLzPnswyT2Qu3c5r1yv5HTadfdgzYDKS0XLhegJ1hgjmBBj8rkZ+JjbqdnYu5oYxuPUmGvmsdaSt+lXpNfVDMt4udqTjU/rKaNrowmTSAx0flbAHglwxBD/d3ktjfPxSgC52IR7FzoMJGNBOykSqsZGFA3t3rUEJpVgT4/ngtVCdp4DotVOCJLI8MiaCgXbv3iu12WOAwgmLasxhX8jNcksLQoIwFOc782+ZbUHCust1Wis3Uc5jOAYx7As9aj5ENOONjrAFxPeNqO7Bgm7yo9JWLj4B15KuGcR3WRR1tRj3w3zbOb3OTCNMzeoM8rSoMA8IeqSqtUIomPjrsgmnYAZvn3zIeWVe6nL+QLdC7wRvQ7IiFjdKVEBax7/l7WsKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB5505.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346f91b9-604b-4383-38d4-08dd94493364
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 07:13:47.1919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lO4PKNb8/I9xBuaOu1lExUCAP/P4b66SWyC5ixbrCqhx9ROXzLPzxAnscQdmHJZVnS9fzZOH6ESIB6B8CzZWoJcFaXSUdW9rlvRvAPfCVW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_03,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505160067
X-Proofpoint-GUID: qiFAmBv_1wxzYEvO972OFSFtt79hcMaR
X-Proofpoint-ORIG-GUID: qiFAmBv_1wxzYEvO972OFSFtt79hcMaR
X-Authority-Analysis: v=2.4 cv=G/McE8k5 c=1 sm=1 tr=0 ts=6826e5ad b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=FOH2dFAWAAAA:8 a=JfrnYn6hAAAA:8 a=LKaInTsuWDzwL2F2iK8A:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13186
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDA2NiBTYWx0ZWRfXzo+tS6DlMZEg 5ZGDhqk5ps/AArotrDtNuyRZb268d59qEwZPGWPLPWvhwg6OXYuLIdJ9wwGrabrMTb0IT5PLfwa IaQz3+gOguBC1PlCt74+27+xNBdGb2jkVbQdyJjt/nMLMDloqm4NiPZjpFVhrc/rjUcNqGSAH7a
 0gEzr8N0iTl8xnB3f8QSSEFsdjrANkR1eBunXviCMjwCjRFu/HXE1X+5luNHNIUct5komCrkjau VLxHCOnaDb3D9plx5e2IRnPQr83dk237kE9tABPUg2BtVkS/JTO1oF87VXoEcZUAPoPxHdNlayl dF8jgsa5D0sOxVlerzFUCGpvmvmZRxYi7rYMUD1ltNe2x2+Aijn8u3cKxs3cLjVdP+HKzjoDRky
 RG3sOWfJeHrAOHwJun4M+LKdIQuRo9rjYAoHBRJ9R/dij5qLBGMsZjgDO06KGZ0xhGsPYFgJ
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250516_001402_146175_E91F41CD 
X-CRM114-Status: GOOD (  18.09  )
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

Hi Christoph,

This device is widely used both within and outside the organization. Applyi=
ng a firmware fix is not viable option. Since this is firmware specific bug=
, I am adding a flag for OEM specific devices only.

Thanks,
Shminder

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Friday, May 16, 2025 12:07 PM
> To: Shminderjit Singh <shminderjit.singh@oracle.com>
> Cc: kbusch@kernel.org; axboe@fb.com; hch@lst.de; sagi@grimberg.me; linux-
> nvme@lists.infradead.org; Junxiao Bi <junxiao.bi@oracle.com>
> Subject: Re: [PATCH 1/1] nvme-pci: Add quirk for Samsung PM173X with
> Subsystem Vendor id:0x108e
>=20
> On Fri, May 16, 2025 at 06:30:59AM +0000, Shminderjit Singh wrote:
> > This commit adds NVME_QUIRK_BOGUS_NSID for devices with Vendor ID
> > 0x144d, Device ID 0xa824 and Subsystem Vendor id 0x108e.
> >
> Hi Shminderjit,
>=20
> this is an enterprise device for which a firmware update should fix this
> intentionally introduced bug that only affects the eui64 bug, and accordi=
ng to
> previous communication actually is available.
>=20
> Please contact Samsung for the fix.


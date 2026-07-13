Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA121C44501
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KAOKQN6oDO7+JQKoPTFIkd5Cchd0mdRuHb7R0T5X4ks=; b=CCjH07bfhwDyrXEO8qhCZrJoFy
	Gm7WPt9eFHyES1Ivn2fbYZbTeUhuxJyeRwqg018N6EHF3DNc31mh6pXNQbU+QBNypkfkxPlLc+iLq
	05Q6pIPk4LILNe4ov0DsQnjlaGoPbJDxArAMUvm8yX85qxVo7ppbjaiEA2ml1ifCgiaOr0/WFiCJ/
	ucxUN5vR6yM+NjE7D2GzBJWoENlv81ctwzDH+lAk7hQE/v2d0QBjIZ3weEDIsSSxVOHcBamSb7baz
	epEnx2a6qUhBc/LmsOVYOwSJd6H6C/XuJ4oBQU/Lbvsi4WDI8tmFECyk1FXqYzzl4EMd5CxkuFMyg
	5McmXjyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjE8E-00000008v0p-2Gu1;
	Mon, 13 Jul 2026 10:43:26 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjE89-00000008uyq-2ZoS
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 10:43:23 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D1lOXa320640;
	Mon, 13 Jul 2026 10:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KAOKQN6oDO7+JQKoPTFIkd5Cchd0mdRuHb7R0T5X4ks=; b=
	PJlcl7gcIviHE5qtS4W9sIqUHu3kRTjhzTs459mu8dFmm/hqcecT/j2jIQiM5j3c
	tORurzA6nVhhypZV/2eC2UfGTW59TvqR8xEMGMZguJy/W6PlglgifUxLOYzhXa5B
	qOwnEwJmr4ft96VQW576LDuiLdMLUEkp0/m3xdVHAm1dCWQ2bCheNMk/Bq9n6ELC
	0caF2O3kDsByoA8PBkmcMmph/+Bt1l36rKcWyeN6Gcv2YQNeX/LuNbfzbac1kEZP
	j+GupGH8iKhQU2d14f6ftExlNcQTSGO5JwmurK/V+ATD7GJJIgza0b49vedK4j3o
	L75300h2I0TH96c7CwHiSg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbed81x42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 10:43:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66DAh7MB014722;
	Mon, 13 Jul 2026 10:43:09 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9cde17-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 10:43:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgW9+7UF+eCxTZDNK+6C8oE1vnQUFonzKT35IiutERD2yYG1GmlcfOfKQmbpxxFo7XRvN3GGljdg4oL/vodEY6HT41WAS9iOlEyH4V+6nwAU4We5+k/VpQW5lA7SnkOvgzbjBLA263yJqXLS3R8mordtqS2GALdjgxZ7dLRXIR9rWK2LEtLMsAdNbrWwgTvnOi4c0ldf9abizYN880DWW4DmH2BvKkijtEtnAK9JzXLryZUWYvwlpTy5Ig5g30kXszDy2eA9jYcPUB7sUODjq8sjK69pEdZQyILe7MoabPTalm8csa0rzwxmxsAjToPWKs9hfM1cCuLnqy+6cQjJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAOKQN6oDO7+JQKoPTFIkd5Cchd0mdRuHb7R0T5X4ks=;
 b=DCeYYz6fpp3D9S/yWGu9z+lv/AfiEYLw+tuCrQzGgK1qoZ73m/uts+pYmgwBMPmgk9j+Q6YA5mcB4Naj3MC74cq3nrNeMXeMqXqdN39xjL+Pety20U+NsNx1Lwpn0CoIzaYWFwExEWMvlbxEfpwnJcDBwEFOMxyuHWAVaUsoZO6qqorEpG1Xk1hBesFxoZCUwT6tYbjqsdJl5c5AcDCiYkF75+4ATRUGTt5P748ExsdxaoN4YtvuR0ScXE+oeLkhZ9dvFK/en1lLCDBS4JuR4ruYgSapHwkYXLxqqFIsUuEai1uUeKz2uDBJ9ed+GpBVGQuZTTZMH6P7u9JknXekZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAOKQN6oDO7+JQKoPTFIkd5Cchd0mdRuHb7R0T5X4ks=;
 b=LpcxL980IaToG8z7hvBa1eFp+g3Rb6MeSnMjvmWwptu0fQjjvatD/BriRKY2Zb2DO2+jSErDNyQGaeZLhgdmEif9kNHgKwurW1J/KRRLmFT1h5mBZgAvtSaTTdph9p8415xqFKj8KV7c/vhOtwgnexXb/WU1iZc3T2Rmd5dm3n0=
Received: from PH7PR10MB6228.namprd10.prod.outlook.com (2603:10b6:510:213::11)
 by SA2PR10MB4491.namprd10.prod.outlook.com (2603:10b6:806:f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:42:52 +0000
Received: from PH7PR10MB6228.namprd10.prod.outlook.com
 ([fe80::11a9:2dfe:4a4a:a58d]) by PH7PR10MB6228.namprd10.prod.outlook.com
 ([fe80::11a9:2dfe:4a4a:a58d%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 10:42:52 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.garry@linux.dev>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 1/2] nvme: add nvme_get_ns_head()
Date: Mon, 13 Jul 2026 10:42:37 +0000
Message-ID: <20260713104238.3034640-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260713104238.3034640-1-john.g.garry@oracle.com>
References: <20260713104238.3034640-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0016.namprd05.prod.outlook.com
 (2603:10b6:a03:254::21) To PH7PR10MB6228.namprd10.prod.outlook.com
 (2603:10b6:510:213::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6228:EE_|SA2PR10MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b007a28-bba8-4d60-55f5-08dee0cb7d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: YYjN3nwSMXUR2O8NK4OoRzg4vImUvXrOB2HMG5bxTzYt+FgLu9As+W9T8nnD+O9tBEeCP0RysZ/zpkXdooe3bbI6AlbCWA7bSEFiDSt1GhxjaUIHgqxW5MlJdMqfcdbYWs2PojXNDNjmZ+i9nespiBzGJfZ5/ClnTFcXfLoB6/wAcMhVeliBHTtbJbzuQznxMvZBzlbx6yytfBHZBb/4+jDQxVypi2QsTbmt/SZ3dHncv7Od0qYihC3HwdYuUWzqn/LaO0mLyK6zJBvGioWe1P/QNuHmAHy9iYLteNcrzvO2zVxxkE+Y8uE6thC1oq1obcKbJmYzycd3/ZBK3Cg3TdY7WqYveq6zGjFVj68q12VqBoolMh3pdhpbXbPl4PVFr2BQAUGCiQu2hbx7/aLqPJ/8c8YtqZzx0gsFSGERuwVrqN1D33pxiFnNOEFJ7xbxjIXrOd2yEwq9BaMogotYMibBcpkTvc9j6iqYlsFEQzaSYCEllDx9zdWklZqqDs8i3+KXTz03YTfIW7dyUoi/CJ9lkrD3sxroefpeNNFAwfPU0PDc3Nk6fHx5oAqZ6j8MsW04Wgoru4bu2fp5JDjqBnixw997slW1HRHMYazBf6vhq+StXqc6i7vBCofKlo7IxQTaA3PFmeDNdUrE46m7NQfHpXM0Qpe8cTIZRojCWfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6228.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EulTr+EaALl2FEmhuGG7CeiWh0/j7UoxRG6tj3JU5r4vr6kXpxfFY8d9sx9y?=
 =?us-ascii?Q?u1Z5MIQk5au7liVRsGIDmpyhZ7cC9r9dWM+e9D8ogTlb2TZvvsI9Ye4UH6pt?=
 =?us-ascii?Q?t0n8fI68C8EwME+qSm4GIVLMz+rRDLlXTAShKo7bVdZr1o7P8cCMJ4nyEMmw?=
 =?us-ascii?Q?yCss6FL3PvaiN8uyUqbtUQGwrQCYt+KD7jdY5DVh+rxF8hZWueDapdzXIQw6?=
 =?us-ascii?Q?ZEE23fJooI6MJDSpUd60azen1aH04NtbspraNRhMWfomoZqYvne89M1Jchbi?=
 =?us-ascii?Q?MJhkoEmkR7UAgjvaFz88NYNq4dk6SyqUvaCK5RSsQMaejiaemhw6KQqHkQsL?=
 =?us-ascii?Q?xmH+k2XsgcEAB95uP1VE9oSO4N8Wkh0VaLXEhI8GdGoOTmIKjiMzP9ryMSQG?=
 =?us-ascii?Q?afgkxOLXb3SjPphdYmts8hEWkLTYVt9uY7D0307/ODugeEqH/4r2lSu68ZEm?=
 =?us-ascii?Q?POJAH/K11QxRkpZdqDWE0UVEsp1HyKND3zborVDvK2H8OkcBK/2N/zhQ3Vb+?=
 =?us-ascii?Q?QOCawkuyp9wwgiXTrfVdNwKVhUav7MqRaxOHbkm92qy9DzQ1IHE4ZslEluXF?=
 =?us-ascii?Q?gPF4y20RG9jr6llTsWp2jQf3ktDXtfQft27R4b5RHBQhklZun9P4tKwfq/eb?=
 =?us-ascii?Q?xisOu01iVftKRMfR9ptaMTzeJ+zlf4trHpzfEJg7ouZ/mbeCGWu2GncQHdOF?=
 =?us-ascii?Q?aAvtQnsfsN2EK/wMiidHrYh0PP3x8EOgzUd1eIPtyup41XFw61ZDPxZx0QQk?=
 =?us-ascii?Q?oOzv+NsnJPeUrLusKMoQHd2kI1VexQRSWywUgJ3k8dITRYJ4erEtKRy66LE4?=
 =?us-ascii?Q?+0lbiXoq2M0mOzArK//7cMHBp1ByOsrdzSYyumCuI7BVSgQwaTck2G4GQm1c?=
 =?us-ascii?Q?CgyfmvLzt7dKTWlEMYXeCZeVJvcYaem3wHeqSuPPHehto0STaMkJy7WBRdeu?=
 =?us-ascii?Q?kZIyzz4KX1WfbWH16EOWLTAPr8nYg/EkyYYy2+NBRa1JojYWQIF4l1mkBOSK?=
 =?us-ascii?Q?xuPWz85aXonNZM17ib5RivKyTx8YhDZCGLW/87Te8W7FtGcCxBryoNwZMYGn?=
 =?us-ascii?Q?7ct1v+7eavVKXLD62UTq1EtJ8Bd4QlO25TXU5PpBJ3gQPSY0NStm4gWqLlQq?=
 =?us-ascii?Q?7gLl7B4yRrv0qShdh/SxXyjYgjLkZA1pcqhEOLNOOlaq4UOUJVjAXQgDCTJB?=
 =?us-ascii?Q?cBBkGU7NTcVDLrEz6rK09HAK2X9cjt6Sj+0CiCTAXO4j3uT8HeaXngYshSPP?=
 =?us-ascii?Q?sFQZl88PxQT+ZDijAJwY2C+o/+PmSSliCxIVCWDbk7hTSblzVAk5YyUHkNCa?=
 =?us-ascii?Q?3huHmDCKZJOUhG4/sW21oqwwaoZOGaUfpExA78HqkdSG4eNh48srcMgRfj5p?=
 =?us-ascii?Q?D9d/Ka5nmTCCDh/zfNulK3tDG1JE6qGgGOJNvi2a0u/SddPz1nwVwQTlW6dd?=
 =?us-ascii?Q?jIOpE8m9mmio2UQ46PxL0meH0j6roCKN0oCqKOCSFMJbguJzYALOLQRZt1Vt?=
 =?us-ascii?Q?kpu7cdgDnzJpkaA8XJ1hE/f67q8gE0wFdoEdhc4pUO7MbSoWSaefKKIEvOT1?=
 =?us-ascii?Q?wkAn0tvcDPkzGsMB07QXiLp3Am90yi8CBljjg1WtCb5I5YBDkT9joKrDpOlK?=
 =?us-ascii?Q?tWUs/tNqmvChgJx4rRqDzlibvn8+nqDiuD2w0sFVVyvM1Z1UOFXFFPvpxMhh?=
 =?us-ascii?Q?ogQToXk6aObiaxVdwwlCPTGXujoOk8oZOzmeo8xNI4nrC7qUkWG+H5XKx6GB?=
 =?us-ascii?Q?wQnB0EuHfA=3D=3D?=
X-Exchange-RoutingPolicyChecked: jNevw4aCyO/aK4Grzs3Z8NoQdWDFjwIDgo/lnIpNOKqzbU+P3FyygTcx1+imJeTfeQYTBL0RaFkCyos+yqftPU30JpL4C8lKeoEEh3b1iHcDtD+R0OVC31UG+KZm7AhybDgS9BK13VtCSdX6zsokgTC4gjuusfKCb/mkLfx/s/j7vGfIIBg8SfLReoCgyECBg94Sx9dwGwcQmlldakWdxKuAYsiIfuhBSeTMthymyfJpavHgbzxXWVXuMK/iFq3rNOQUk1jIAX3ZGEavs7D4QCxdVqtgcVLZPPwseqs4aopvnvczU28MbCqLoV120rTgSy+LGIXBRZJjbXH0B3RgzA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZjbL385/Y/teqzADeyFK2H5tm92kXbyj1LZ28M4yYzcSvAXFfOpGcwR6RSDwO/Un6wWvYptGbuHRIAFsXfxg3Pn99tXoCThEWPTMvgYVGU950nROS4GBT85URQTsltCp3sp/EcekETMH0L9tH6ySKeVDha7DFrkz793gA0JwOhnFuS91ssRUovzrhOcstBDvjK+0YBDcb6a7g/bx7cNeiKy3ICotjqH2xDhbCnx38bIAKY/cyHxCI7ThteWmnnFyNcmpP4vJdrMHVxFGHuPG9R6/nVDB3M2z1XTpU4B1V3ehfJWpoNJGGwKQslmZKOMsl2hPUGhxxg8nz+IN7C0g3nblDVv7a4E/EgaBG3fRFIsxyfvnefLjYfLO9eebM62vxwrd/125k0l0kRyCYhLiinuuURK1BnIkJwwlQ+IvVoHTNK3FE3mdFGbo2/4BC2jcKW9dxRRTB2ypb8LRzIfJ1JMMMDb1T8Qn0CK4whK7bNnO3RFqwq2CU8HGx3ttfy5aucZVtr3nYoCVMhtyG0QEhCZfOKXbKfltY9fTZKfo94iNx8Gqgfdk3FJ77h+bjcFWnHRnvQ4Eet8VP3Uza6grRY3+jxAsEAhytrmTWdSrZeY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b007a28-bba8-4d60-55f5-08dee0cb7d49
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6228.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:42:52.0370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYNJ0mfYHjgFQkNp1mlCEwF11GrqfqmbriH6axwjO1Z7DpryoCJ1vcaJFXyk3gs8gMRr0yITxl8atMbqMNLATw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607130111
X-Proofpoint-GUID: UMBwPsiFxkdMZOsYFWxGEHYJ7auLuelZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExMSBTYWx0ZWRfX7BmrpfldCRRa
 wHZ6JwDyBurziG3Bmi+VNN4W5R0sOXAdwdrUj94Rlncu+9U81XSqKGFCF0tYwWlGJHO1lBK3NZf
 SGRRYb07gJ7UbehUMVcWpJT49HxJY7Ck+RAUKfAYo1fEOoldPbzA
X-Authority-Analysis: v=2.4 cv=JKALdcKb c=1 sm=1 tr=0 ts=6a54c13e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=yPCof4ZbAAAA:8 a=i_WdEnLYC0NRSAK-jf4A:9
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-ORIG-GUID: UMBwPsiFxkdMZOsYFWxGEHYJ7auLuelZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExMSBTYWx0ZWRfX6tih85MdnAIH
 NFXcSMB7Z4Q/tLkwM6pQ3rfD7heb6SymRcxEGS1KNwe2UBc6SvRLaSw1Xp4Zh4xruRJ2EZLy9XW
 EhQULLK1l7aUsspIb2QWs/RMUJkmqtbvn7JSeWMPVarITh7QcHImyPhAlDfOOfCfEGViD2xV9nz
 pZUskF937bMBJFZ/W0wtzzbcEyWU9duVMtQcXiN7q776QI2WjX+zSvXU8EvAnd2c1BDUdslIGMg
 u9thdC0h1K9Q7VnjmgYvHJmck/CBcCzzhOcD9Xsf+QlEjNRq700d4KLKjVpnFcmqxu5xme7r9XL
 UyBkJJe6OOMDOp98smWI1BmQoRBV/nAKWosFzQPh9bLhcS5HQiDxuJSs3xlIh1GXRwPK3pBh7aa
 CywZJR7oxzSvn81DF6zZGHvRNgGgwc39MAo1DHofa8TjyxemND6KGrL3qToh3Awt43BFmSghsGb
 kfaGc5Fx198xDFGB3UA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_034321_850034_53A9221B 
X-CRM114-Status: GOOD (  14.61  )
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

Add a wrapper for getting a reference to the NS head.

This would be used in scenarios when we know that getting a reference
would not fail.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/nvme/host/core.c      | 5 +++++
 drivers/nvme/host/multipath.c | 2 +-
 drivers/nvme/host/nvme.h      | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index db0c8ad4628a7..fd45e42be0f5b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -693,6 +693,11 @@ static void nvme_free_ns_head(struct kref *ref)
 	kfree(head);
 }
 
+void nvme_get_ns_head(struct nvme_ns_head *head)
+{
+	kref_get(&head->ref);
+}
+
 bool nvme_tryget_ns_head(struct nvme_ns_head *head)
 {
 	return kref_get_unless_zero(&head->ref);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 56587ae59c7f7..8cb417036fe17 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -797,7 +797,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
 	sprintf(head->disk->disk_name, "nvme%dn%d",
 			ctrl->subsys->instance, head->instance);
-	nvme_tryget_ns_head(head);
+	nvme_get_ns_head(head);
 	return 0;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a679a4c61462d..2e9dea6420daf 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -995,6 +995,7 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 		void *log, size_t size, u64 offset);
+void nvme_get_ns_head(struct nvme_ns_head *head);
 bool nvme_tryget_ns_head(struct nvme_ns_head *head);
 void nvme_put_ns_head(struct nvme_ns_head *head);
 int nvme_cdev_add(const char *name, struct cdev *cdev,
-- 
2.43.7



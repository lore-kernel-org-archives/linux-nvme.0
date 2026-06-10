Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D85ACD98C7
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 08:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TtpL4ZbhLmxxdueW9E32I2GgY80owHOrZ3wKUMzfJbo=; b=KcumYS7lyUfcXC9ndJfx1lUoQk
	P2DdL9PJE+wO6QohYU8dY0IjOGOJDkv4TaC8gBJ54kpjaW7XBFukwi5TAbTXEBV/LgXwicJWlXa1K
	EbKuYX7yT6LBJ52xNMSeR674tT6rZ8kx1mJONN4x//5jH4S7D/fxX0WyQuzXqO/KXQcbr540JWLRm
	SyxnrrtagycJXPcStBTLBU4iRoSiHUHYcnkF0b0nbZzwtTSuGWcAH3MA7P3ldC+zT1RRSSVZE4aqL
	yLtT3v6LrB/7gzrAr0tCtmPOUcIsUJxhd0tCvUdD2RXAcEwvIJs/VtVer4pP31AnXEfICHFKJPErC
	hRt5J8tw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXEhM-000000079FR-0wMF;
	Wed, 10 Jun 2026 08:54:08 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXEhJ-000000079EH-0DmT
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 08:54:06 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A6MWKg2826253;
	Wed, 10 Jun 2026 08:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=TtpL4ZbhLmxxdueW
	9E32I2GgY80owHOrZ3wKUMzfJbo=; b=hwZkhb0jTctBuVeHSS2ikmj/5Oso3IgW
	BI9C7HIYXTbdg4E08tl841gk6hq/Iof+5DSO5XciywzQmEtkej7gyBBA9xkRjBX1
	Ug8AthSicjK5D21dHjoUxEZoek2ImZ988cWy9pTJ/mrJy0bWXouifk7MxO94uH1L
	3TXF2x+L6wn7b4O7bG52Zx3MS7oLx3nZqbHWaEuMi2jLoNGiSu3eFLq6uOgWUl6t
	VXxi+kMJBVzhRnSvKfUWsp/sD0hwrEEacozkhHCAfS0gpSLrcuv8fcCIypZGGkIR
	CekgxLIR4PwRZxujCHyWm274xMpFBFFGu/uCEcVa08xaqRKM6x/Vdw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emc3rp4tu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 08:53:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65A8r5EB030234;
	Wed, 10 Jun 2026 08:53:55 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4eq4sfr23t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 08:53:55 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wLbawE3lIFZimCqc95AFmIynKTatXQSvcg60hmFQWec43Yfnq8j3wHsjrDEamGklgPXCjqUTRwCcpyJ91W5MSZrkaWECBFydzDtMYy09XzHejCWaLulMuuHdpZc9MtjE6CV1zTIFoWifhPkQG2LBZxBlwl3t98kXx+YHp/SoJhc2LY6UnRuBQcXnnO6xhz4gVquWNzDikB02tsE5t24YqUwfso19QFWJMamJt9cJgXJQeLfVi9HkFdxt4s80YC8vsfRbDpFJUMGpbv2ibZpbqqGO9RoM8UzKlamsGkGmHDHgzxP3wqUCC/UxcMo9XI5TCv6gAG6vC90yU6d77dENhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TtpL4ZbhLmxxdueW9E32I2GgY80owHOrZ3wKUMzfJbo=;
 b=l9Qq2nlD8drRuVotOA2cq2mmwdC3HoFDRJQDPznlEwaPmysN7cmSiXY86u+8MkpsUmJKq/lugiAuPPSm9auFTFMQjhvninrEoT6Ll+Vt5dQN1xRzP9nJavysC+IHqRU+e1VpoMl7Dlbzs2s18K0wsG5VIOVTyYnjvfeiO4weSeMrmZuHhwub7xBoArTDz0ETvWCROmpeOYkpTXHwqfgRGABM95t96Gg2emgLDlu/VmmbdT3+l2r2SOXxue93x0wr8OT1TaGQ9rUYL+WbrFWEpicdMiT4Dah9EQlMOvThYuHKuqRkpLrDpDKCzsSH6Qk/g5C/Zwt1OY2WJtsLu/44oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TtpL4ZbhLmxxdueW9E32I2GgY80owHOrZ3wKUMzfJbo=;
 b=QvPoh54/aZKJVXInixu3qj7xWVAL+HkDJcPldfCJIsTSnbTdtd5cUpax8KSyi1Ut7QGVL7vIzWZNjY7iOEjGohP9lMS97CPxJwVorzyCRs2SgHbs8q9yUme0U2fJjE8TcCcZWDhFkqEgoNDfTkXRROR6XW5pltdQWeSHCn42rsQ=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by IA0PR10MB7207.namprd10.prod.outlook.com
 (2603:10b6:208:408::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 08:53:51 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 08:53:51 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, nilay@linux.ibm.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] nvme: make some sysfs diagnostic structures static
Date: Wed, 10 Jun 2026 08:53:32 +0000
Message-ID: <20260610085332.3213760-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0062.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::14) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|IA0PR10MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e4dc09b-72aa-4a37-78fb-08dec6cdcb20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 3bZANX+VR5KhlOVDBoJUjmUDHB3F200dC7r9uE5IwDnDQ0zPSIRywGzkf7Dr72k2/6SawMX8CE4C1BOFA3InMJF4jYyMjE91Z1OcAuvblO0pEnaZdCBMUrguK/j8HH1ayLmNlo7cLte6KegvVIFoJVICBMQGvbQHWBqcG+veOuUfzBDh/v398516Sz5Ufz1NRZnTI/mSA95t4JbvmpcpkMt5qcJCZYmpXdK2Ad2mdxN1CQzkjWSx8va/TFBRnjg9taXs+5s+Jd6mrAtz0TAnSsDSM7r7OYr3ilEJXfMi0UQzDFvzh+KW0okwqGG2kX7vHa8bFfNsuUW0VAcQhgh8llDGYIk0mXcmOiFIxX50s3QL3foD5DYlK/dlFW2fcEwUuSS3RshPNwFvkWjIufjUnmTZos9ra1UUYv0QOB4yDL2Z/ug+uQ5kwGai3FiQrrNFR+ZZZDP2iL3AcKpT2YHbLyQLx6LO73bYfISGVaMcc8WmBbS4uRte7PviV8FeF7j79dcqtRwX/LF3ZMDi3dG0gkloJVHPaOC1CaeMZPXU9/9VnGXL3lIcDUsaQl7+vYeeICqcuP2eRyTkQFM/+kjElyhIb8EJzf3F2rhPB/TC93vdt90+v95BtRN9qxunQJYkfg6G61UJdqf8luISsTl5Ud4E6nvShsXA+NqEuZxzR/9hWREnT+klyGYh7CR9HtjZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vi0eN+A20IYtWLp/H3GIfoSJo0oMkD9A+LwMyYq/nCj53l5RwDB4aDOzB5tU?=
 =?us-ascii?Q?11tV4d2xsLdB28w6L+xqyejGmnSoAP+ux5eK2YvYkbNEFwvsCK5uCcN9emvy?=
 =?us-ascii?Q?8ztCvbZv4PIDE4MC/GdIlzE+GuqoFinEioSJiQYhr/C9YIs+8r62fSCdFLiq?=
 =?us-ascii?Q?Xwq91uCyJZTO46ExiE8rqP8i3BTWrWj7TJAk49vlxN4xMMizIttQaWpdpLXm?=
 =?us-ascii?Q?LlnuH/i7QK+J8TQZFTihLWjGbSeZJE954xr8u30dOQ7auP7l7sG+5lxYlQsd?=
 =?us-ascii?Q?FYlZ9iV1gOjm+FqOUrvkqJjs38Q9Lg+TG1DGJHcGLa34orFOSeVaB4GCWEmY?=
 =?us-ascii?Q?Gal1qP3fx0v2qQIaav67f7GeFWfN45DWkEMxXJ/QZCubOEvDJ4gVEHw/K2Pi?=
 =?us-ascii?Q?+EsIbbJcOU7n7b5rHsvpXgFy9kUe/gFqCzr9kEG5MtT4IC4xEOLd1R0MTjWL?=
 =?us-ascii?Q?Pddv09d36L5FBIk8OpP4Dg/WNfYSu7N3JbLLa/NPiSKatn9WgZ5r7qUaEQWY?=
 =?us-ascii?Q?dXOJgNUSMxyj9cAKChoqVv6mhVaTAdiRvi2F3RRzU7YsprM5q8OHKDIHGjoI?=
 =?us-ascii?Q?db41KLCLcfyig/OGovmU4pyweXGe017LdDePrOArvOWwYtYib3XHIUE/hD5v?=
 =?us-ascii?Q?I+eaXVlcgAxPxViMRXhxhLGIjk1BeLSkJVmxY78HyktDSOpdjsMCZj73LAV+?=
 =?us-ascii?Q?TYxGt2Q15LbxU7lK+FjV/KmXaHx2Jjxa2m0eX9gyxoMvOrjBCIVL3ZGL5T4M?=
 =?us-ascii?Q?OaWF2+G96LLY85D0EUcdgY8AXJaExQyMF7tLxKZODgxhitPkA+aEgsw2cTFw?=
 =?us-ascii?Q?QrvJ/e87bTUrqlGHsilz6RwcEXAEXcAxX+VeKLKrVeSFcgPiLmDPwx5yPtSu?=
 =?us-ascii?Q?l/NeQ+bEFvpXqS7ZXOdd6/QuuSSuamtkXkFVnR0A7FmV/TzfRQjSs0rXAaoM?=
 =?us-ascii?Q?xGBGl3E5ebDEzsiuOCXgL0SNFpaU3uSqaLr31Faa2G4B/KEUjzXI5ibLjXiv?=
 =?us-ascii?Q?54kjtxoLqTAlnReImoQCYQ/gT6sKnVuI1yNBpYFoaJ2n+O6Kwr74xlB7E0xG?=
 =?us-ascii?Q?qJA2h9TFIUHDN768jf85TZK5m/lhMrhT+W3TuUgUy4MDiJnzatfGtDQegsL9?=
 =?us-ascii?Q?l6zM83JnseFXOve6XgXccJPcnp2sEUT8QG4BhbbPKI3cdO0Za44p4AhnUKYK?=
 =?us-ascii?Q?caSUCcXRVIL5U/vHoc814rJ+e4U2Mzs0HFQCYB2aCeuqh+Zs6N/4BB6c21dR?=
 =?us-ascii?Q?XJz/cyzQbMoFEKhVAkHfVCQkdO3qrkySHYGmKtkcNX/n9vsTQRFZvTRSkVcN?=
 =?us-ascii?Q?0ObzcEY1B9ZU8b5UF04oJOHMwR1GtaIooDN5VYwt2LhhLsssC1gvUBYt9alV?=
 =?us-ascii?Q?QRf2ZXuXtxcdvU9gGeOif+XVWxq9noGSMcPGRAjuFX2EXpcw5Kikuz81f/cV?=
 =?us-ascii?Q?Y+Uit5BYVS8M9QiygunrX7YtCCbGE6IiO9kXgs2eAxABYqexxHePiFkV+3Jz?=
 =?us-ascii?Q?MJ9bEIKESba/7kgpvVIQIIhGjzA7DTWN2tucxLh7Ww51wazRMVdQKeqCzQ3w?=
 =?us-ascii?Q?7/MI6x+V4jeCxoPPmHnlnGUHILxrAzyotjZ0pm8c74PwtGN8JfaLnZPxPPsd?=
 =?us-ascii?Q?l13SSb+WMA/9N4nwANSjXaj/aTQW/IXVw/rG6uWrCQ7lMcsDXRxmuiPLnLJu?=
 =?us-ascii?Q?gL4+yU+sWUUnveLL73tuDURJPNGjte4IfJHOs1HxaGfECpY4T+SZmkl+1Bx9?=
 =?us-ascii?Q?s30WKYMUBA=3D=3D?=
X-Exchange-RoutingPolicyChecked: THGqihLr1bJvWdMcC181P+LsItihyPG8SwLnFPRAJBxoz+U29osErjDI+5/yFeD9jkjc/0CjYLAk6dAF+plPG2D3AKLF48IYXkZvOLe2pHEsT0+YRPKOHZbd7gxJVR7XCkfsIZE9Vy/soAhgog3tTZZH55jl9rucjIY+rAZGD5J+NFeEZdEGhXcnnoyRD8IBgFztcWIPd4vJHwWHIAMHHjULvMVJFFBtqgx69M+C1pf9G/F0j7gfsFNP/du+x/Ky5FZFuDtqd08xNlk4sqFE1HywMXiXhk2V2Tx00OMPBkv/7ELj9XRjbkSyK/Nr7ayX4H8nMxx9/HNBNBwTcZhA4A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Nxj6GiQ7cKnZrlo0gnw93yTFPZG+7x9gJh2Xb3vvE2eB1VEqD7Z5cvBho7yi+fMDMbPsJH6LJj6Z6BxIhuFrn4sN269uz1YnAiYZTg+xV2XAeJvIUXb5Ka3uWR/EdYYXAqUQo9CiItulX0r9dDX2TVSTdyCvZPJagNOJjEcDGsuoHAOEAP0VSbiIeK5VFE74sDPt4+soL6AKnv3KcomLgvrsPud737wXDNe12ezYCJxnIPZFqZOdScSDnxuATMNKKiDdewJUn8a8Hn0VwTmHG7vsYxvo2JpdXijJTwqNPYBjyZ3pumLJi6cBbbxjCqIr/0bDWaZdLVNtIZ/kHRfsveK2CATltu6lDwuYK1JQ5KQpZUKEu80xeVmN1vEH4M4ZQ8BeKhKGjKHuh2yTgrYZaspRfy+DTPrRwTF1PPHAp6KkDhEYvo32YosV3MPNqdcWfnxInneYdjGg3tF2Zap9Ef1n5UPKCsfibtmTTk/0dObyqVqO8OMiuio4nJxqLUEzA32nCVXXyeS3ckGvABodEwWjen90eFvDDHxhcXHAF7frTeLosTIvTrNql/OzF3AYGXveX/OyU02aTCX5ayl79gmPg86gvtz3HZ5xPkrxv9g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4dc09b-72aa-4a37-78fb-08dec6cdcb20
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 08:53:51.3606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Vq3sMBpJIkXwB3BdKZ/aino8APl6iHpJ2P+c+rmVwKtli1UO2SB5fKK2Cxu2nXFQccmJwqgDRIKBWKPuTZBbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7207
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2606100083
X-Proofpoint-ORIG-GUID: FnjwnaUNplsd4f2d75adjq5e0_9JBMlF
X-Authority-Analysis: v=2.4 cv=crirVV4i c=1 sm=1 tr=0 ts=6a292624 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=SrvZg_9y4RhgvUZO56QA:9
X-Proofpoint-GUID: FnjwnaUNplsd4f2d75adjq5e0_9JBMlF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA4MyBTYWx0ZWRfX6dqbBMVpMOHA
 HfOz2lsDqNBkb/0ju1udpGOZvqtv7pQFCPOhKf6NrzNWV/ARXFHkAMRtDzBAqZjpBau5ydLvkZ0
 S/9Hzl6q7R17i1D+2oN2ybSan23iD2QLifktgUNgbiZAO5VJ28yX+sNMVHGehGxrzhRV3iJf0ie
 9SAhMjfV9Db96NKEocBtnm0Wxpz6N8XcwZ+jq5hCtUc3fj9Kj2vWN5A/WDcnz/n12l8zF/FIDHO
 qYhb6s1deMChqM3BEZa1F4fmczNXsm3K4prJNAiJa9ftUBt6cSfs0HDDMbiSKnrBvqqvVKmh00t
 U1187aSeTpQXnXtV8+KXcYWRDXUUIMv/b0nPkwllbFROzJdHUb7kxADEmzzUJjVrS1mN70JZT87
 Y0Iz1q1WqnkkNx2khUzsZ0wAcUs86xToRIkZcq9QOQBwev/ZmpVANLWMG/MotPGrfdjQbKjyDoJ
 meIqk8nunCeECwFN3ug==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_015405_094739_B861B65A 
X-CRM114-Status: UNSURE (   9.66  )
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

Building with C=1 generates the following warnings:
drivers/nvme/host/sysfs.c:397:25: warning: symbol 'dev_attr_io_errors' was not declared. Should it be static?
drivers/nvme/host/sysfs.c:444:30: warning: symbol 'nvme_ns_diag_attr_group' was not declared. Should it be static?
drivers/nvme/host/sysfs.c:1150:25: warning: symbol 'dev_attr_adm_errors' was not declared. Should it be static?

Make those structures static.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 933a5adfb7af5..75b2d69b59578 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -394,7 +394,7 @@ static ssize_t nvme_io_errors_store(struct device *dev,
 	return count;
 }
 
-struct device_attribute dev_attr_io_errors =
+static struct device_attribute dev_attr_io_errors =
 	__ATTR(command_error_count, 0644,
 		nvme_io_errors_show, nvme_io_errors_store);
 
@@ -441,7 +441,7 @@ static umode_t nvme_ns_diag_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-const struct attribute_group nvme_ns_diag_attr_group = {
+static const struct attribute_group nvme_ns_diag_attr_group = {
 	.name		= "diag",
 	.attrs		= nvme_ns_diag_attrs,
 	.is_visible	= nvme_ns_diag_attrs_are_visible,
@@ -1147,7 +1147,7 @@ static ssize_t nvme_adm_errors_store(struct device *dev,
 	return count;
 }
 
-struct device_attribute dev_attr_adm_errors =
+static struct device_attribute dev_attr_adm_errors =
 	__ATTR(command_error_count, 0644,
 		nvme_adm_errors_show, nvme_adm_errors_store);
 
-- 
2.43.5



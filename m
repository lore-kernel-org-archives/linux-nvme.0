Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA88FC4451C
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bXYOxJ+fZXsvWIGbvrVIdbK37zptXl8pmR9WR8zha8g=; b=dEoYLWvQNZrI6S23sljzjqj2r5
	C55P8lytxLLoairWgelhx4xSyqCdZPcH2CVCl5UlevmTsisOCU3jkeHds0TRquWL0PltWzvEjLshV
	DcslgNbIaQc3iKpmOAWpViZumwPMpmrOMvLKbTXm5yvlGCId1lvQjgPJSqKUC0kNJ+bAsOSQsTbPV
	ihsAjfQDtbGYKA5u+bKNYyG/cAwDoviYcMdimWozavxy7p0rnIRQRuG+gCf7pRt0YTTuiRQIL+Rr2
	HJBKrCJr22davuWbphsFmL/rU6UQRcrluhZp838TJR6wbmawWBd5QeDJfqxHWOmvAfKvLLSxI9TMn
	PsroeBJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm8vt-00000009LSG-2Hfb;
	Tue, 21 Jul 2026 11:46:45 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wm8vq-00000009LRL-1jHH
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 11:46:44 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNEHrH1762111;
	Tue, 21 Jul 2026 11:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=bXYOxJ+fZXsvWIGb
	vrVIdbK37zptXl8pmR9WR8zha8g=; b=cEiM+eAZ4HhZdXBDOmX/RB2ZMqNXu2y0
	n3sbL4obZ+ZOVyox394g2LQ58L7QVyj5HbzHC7m/ScgGymiEASNU54g0AiwLus1C
	mwFdTi4PbdX9W10+KQIvUZ0cQoc6vZ2v0T1KBx+MXAG7AMflaoHyPmaC0mDTgWvs
	oOIG41sQFNS4NDNX04OIIyF5AKtsYxaIvHR3MU3Y8/tAY9qs7qfvxUkaFHAMZ2fj
	10v2vP2CSSdRUmTef//M23+EA/9s+pVqwpbUuBpPr6HTSavkanxQIhsHZgVZcrPO
	bIt48jX+OywCa72tDNT2Thin/FABspO0wAMBOOaSJYy1XtMZbBn9vQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fg1tju9w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 11:46:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66LBhU5T016385;
	Tue, 21 Jul 2026 11:46:27 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ffyxq4qrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 11:46:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j5Dzo7etTOvx1dASQZ0xUWJrcPK4ZTwnMu4PZ8p0L2Mb4NRkOy2EIkSZyKwhtHZq8xkZx2cgcPTwf9T79in2QS1s9fFRwUXqF1I8P+tQ7z3HaTPdMx4LHroZsw27a/7Wjlb3jSpCV+Rvixcn9kZR02DJn+F1r2KQZlYM2JAYsEKCInTk9PEB8ZMm2/GS5+ZJDIENr76l2MSJzJki67M3da58Lr1/oe9qqGJgHzl577vFR2ik1L9WTJPJZOOrcb0X+RxxMQzSeRuVkvXTM1LQ0M9xOWND/Sm6cJPdGfugCfuDE3FG6lLZF4a8RAtNsmbbjZdH5xfeO9Of7etQm8Lv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXYOxJ+fZXsvWIGbvrVIdbK37zptXl8pmR9WR8zha8g=;
 b=BtEH0VvaUyVNH3GJAro6/baIlO+yumGO3SHg2/sLSeQhFA3gNR0qftwQzW52e1FhP8by0Pbo7gCLCe5oFl1YAtGNSyEpAt0hBThYECexEo6u6Zz/8QeD7CcQ/GPbFuG8R6UnHIpFGmiNpmR+1zqcpMIt76a9tA8LLuevaj//ahmo8hmJXCusAU8jk3skpqUUWs4zVOwHJ5vxk6DhLlUtDeP2qzqfcRhixu3dywSEJjwUYv/HWfdaRUASFP0EvEpJi83xYm4dkHKHZbfiJCy+PGhWDMod62Tc34JtTABM2i8Z82v1bhTHhytyKJE8jGq+VvXgapZUnZd17ct9nbA63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXYOxJ+fZXsvWIGbvrVIdbK37zptXl8pmR9WR8zha8g=;
 b=vAvnq+tGk6k41cHxb9Z7pfINebDoco9/SE2FpPNX46948zbc7pP7ef+AMViUNeOHIw/iekeLW44Yrn+jUn4ZpNHo/cayd9n1jQxf2MNncCb8wfNQ8DqcBE3bhys4yyFfAxnYtva/zLJjZKDt50MiTVFsuCpKynZqsEtrCP0J0GU=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 IA3PR10MB8514.namprd10.prod.outlook.com (2603:10b6:208:571::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 21 Jul
 2026 11:46:21 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 11:46:19 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.garry@linux.dev>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC] nvme-multipath: fix diskstats for partitions
Date: Tue, 21 Jul 2026 11:45:53 +0000
Message-ID: <20260721114553.1657841-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P221CA0039.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::7)
 To DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|IA3PR10MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: c8aa5b27-b286-49b8-3c1b-08dee71dadd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|18002099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: iOe7Pap2d0yFWe+41Ph33vhXfrnIFDRJuZBWxVTnGbREuCtvb6J6q3gFTgla/WHPH/lZ6LFwbXkdQOjccRQj6CrpEJNdvuDJWLGgeYixBEKvr9wMU4ssRNiLjcUnpE1NpdtFG94AFNicgBh4NjtcYC+fju/NovnDEOHaKuOVXzy+9v6TQxlz+hvGmVcP/zDr7zpjYBvqQi+5BBZtKGZQjkpjh6ETKV6fhKHZVzhAujEVDN0dsvRUuTT3iNxQ0BnusgaZtNWGx7Zjx/4ZVVil6egLcoUPB0mDTgmNWmLFKEl76EMlYex4SLZy0g8iq8qEmXKV8kGWmtzwz5tETxhpdNazlWC+jm0t7X6eSDfI8+0aG14VPyEsk/VGpUoxwHYPUHztw26Ch2Mi8nC3m4E2KLuP3oxOZ7WUg6cTKgaNiamG9xWe4ciW/6J+/PTEflrWvJ2Rv6T+KHC0M1BApG3U9Pr1VeUTPoa8EOEiwlWgGq8zMi3DW16kjAjMztCJRwrLJaYtrZXoTHaZ/ratvgnfTG43wQ7eA9vC/RO+TtANaoUmRQ1wu8DKJRStTrp819hu7qb7FgjiJsCxekOG8QNw4LYws44bcbIkAAchIfkj91929VCyMLu5BiCr1qrspf58Bud4OQZdeL97Lqa8riKbqFc/qUoVMl8Ikps6iYBXGZg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(18002099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B0akEgUUD4JKeQvfPxP0n28ErCgbS6E/2rPurYNkUQf97hDA6BD/ZEHCShAN?=
 =?us-ascii?Q?uGJkuIq0MvL4bjF80MGFRGaSckv2+YsLwJ3ENDSJR+eNTtFN8C89lWwlW6td?=
 =?us-ascii?Q?FJmQ+Wid0cS5Vc8cui56+NzNmt2rg6veqyF7IuqTH32GN9Zspg/iFOl9ndYs?=
 =?us-ascii?Q?4RD2cDQbto6lJuOMQRjKP00PObvdBo0cWjNeSVpH3E2cMu20J88ItfiB41X9?=
 =?us-ascii?Q?OrqyAnSxtYSBfKRvHc+P8iExGKcgs2fJgjmL1U8ZCm/yKRjzljGavxUdHqmh?=
 =?us-ascii?Q?/0bjohT/Zhkp8GhRryUdRXcmT31caMtXeo16Ysaofl/zQOIdc1Ve6SXV0Zo6?=
 =?us-ascii?Q?sZs4G+zvQ9V+vd9OzGRKf1O2tPkfuUr1ecdhIkz/5gtdxf10fkFBSGVwH60R?=
 =?us-ascii?Q?Ve06cKiVU+kXLhAX8gREosnPj2B8kg5boR1N6x2vLDR8/VkRtj4nik5PbJur?=
 =?us-ascii?Q?ruzeuMWGUKnig1A+H3GUQBIvUdmyeAtrEDkeBPHgCfzPsQsXswSD/71ds9nl?=
 =?us-ascii?Q?ZftBUbhyURC9UOamPCp+Ka4fYses2OFv07Be0bJF2VmF8XsSmQX6JD1ZgGrH?=
 =?us-ascii?Q?HfVR+ScVFp8jjKPtc9yY2ROViFS2Fk1RJqeHXvhwDt/xXGVqfGwS1rxORSvI?=
 =?us-ascii?Q?zZ4f5rbg7J8Ol26BGYLfjnbYerSr7HmYvvOBDxdpZDhKEBz3lTswW67ZoiBX?=
 =?us-ascii?Q?QBgIM2/mA20c64pf5z8o54fGBkG/eWCABoNtHHSQL3X41RaApS4EmZuespBB?=
 =?us-ascii?Q?NOmHIfhPmAvcHdbi6Jd1tljxxnkwS9XO8Cl6TnVmQ8Hz621DGXD6VAP/meaN?=
 =?us-ascii?Q?/TIlSQsLIF06dFR/3kai+6pIZvZeBemsZeL3e95mtu8jXUfdSj9j8y0ZHB7f?=
 =?us-ascii?Q?/CP7JgaPTFl2ycMvIAXCcWJMNjCkfvjLqntUzfg3WNmsCmvSg+6mFP5+eYOQ?=
 =?us-ascii?Q?BccNSbipDkQrYqdmCdKYGlWNvKHcgRwTdXxsTdES1PU89L9oT69B1BmWKf7+?=
 =?us-ascii?Q?byucjKC1b6hq1oYAjXuXqR0rjJKzcy/QkWxZDcK3i+X6+jDc7XcNSOUmCFSC?=
 =?us-ascii?Q?C470hJTgSumAnDuIi/vne0Qex9Qyc044Asa4jthEeYv0mRHYI2oI0gyuybgn?=
 =?us-ascii?Q?aorEZNL4gboLR1om+aT9xPTTHpSdDRODcP9cYlUS+S6dxodzhQyyEUyu1Jox?=
 =?us-ascii?Q?xpqplMKY9kqmsVoNLbY567f8B4vnXN/O8ohVkUoNlzWVgXYlbuUhWaYvIIlx?=
 =?us-ascii?Q?Ol+iS7voCEz1e9z7H9yeRBPL83ldB2QykPmtOwEJObgZEQfjJ5s5wF5lsBty?=
 =?us-ascii?Q?FUOMcLqhfvbo1ACVuZb70/zYKEIFMtV5dnkMv4ewpvlU/dabM2oEuO+10S/U?=
 =?us-ascii?Q?3kbosyF6tRNV+O7lqNt5YX8+2XWhTXuzqjq4sgfdzoDGfcMqMh0VGlk55bmI?=
 =?us-ascii?Q?LwhNV1saF9ovH6KZTliVCgZKRSt+PGVGUxlFSZPE4HhdsiQ0ntaJtFzoWFkV?=
 =?us-ascii?Q?jy9hWwRWoDMRz32W7b1zXhvRvRzGX6fiL24XvOrFEsMdsv/Cux53v6Yh3lQO?=
 =?us-ascii?Q?xUZBXIYrhzxsaKYRFhU9sjdM08/PjDN/kDgfauT18ArmM2Jw9NprBWD8dtXp?=
 =?us-ascii?Q?P4WXsyPVqIcVN480J/I6EHyDJfd2ClukRA7IBCiJZTL4itfo/sJnJRxXRsQN?=
 =?us-ascii?Q?ENor1KkkzQtLV9L20yW5Bu/ThG7ODfrwdzNDPPbjI1S54mQ/m+/ky6l66MEm?=
 =?us-ascii?Q?IB2VXAcMrw=3D=3D?=
X-Exchange-RoutingPolicyChecked: QTydv+sGGIQffmDsbo8QZ5daTOcCFOwn+k8h5ZDerb9fRfF0VkamujOmfm+GPrq0FeUPENNWfXt/H8FbU2lRzWjuSswrbqG5UOFTrESCwbOIKPP9b2flHWzR9c6IgRVzJScPA+uZ8EZsT6E/LOBJ435dGxUPcyD/LfMFLLpXLGeUPpa4JrTlExhEb2de7hOlJ116AkvWjvQAhxTq5AEGssYNGt19eVNvtgQtPZJ9ExYHGwHH+xQG4kJ0UakJ5Bsthc8Rps/0DFMYe8+jarW7jvod98/DYgp5eUtC/TTKpeOELZVmXMe+YaS3WiT7Cx6yGT6khiIXwPmvl70979NMig==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bf2Nlg+AcQ/LyPVwEEIjT3OXnYIY4MTw/FBTgvgQdL47zXQ8gVN+l+nlJxwyS10S6nkY/OrMtqZWiyrfXQTqASxMnXD1gJR0J1WZT1T/JPRnya3NFOopaeWpGEoI0SdodDSWBmeRiN8aX8eEWfVgdvrUCUFs/OHypedLDJt7SJTJNBXIMxDjivxvJsIX6+bhaebp9IkuUrJevArivWTYqwoslJOTCPYJjbIsChlIAwPbc2D7RD7Q4YSRC9VIb+GFalWho+ZG2+TIDe5iKAqgfqNn40CZfBOOUCWPmHuopDxqGtmeUHra1GBTHqtAS0+YNMNz0AdDvY1v1dKXj0qQ51HyQp/BUcEemraaV9ibSareCCz0tzmNRzfvWlT7y+Ca4VD+useZtUqy/Mnf8chr2EpTABoWQMc0eDEjVP/HrkYw279fFQNQz/gtpfrQlV7L8Tis2TNKIcYSjcxbByTaAX/OTWIep/h6blJAziaac0xnxe04tPIV9gJ64hXpFOsSjfd1St32pyuuuOKjYYZ1l90kyX+TB+yzP1aBOGM8mO5tq/CYUAtjBYD1iEUaDZ3WmRdxdp+UzRWBwblAAhkqg6KqkQP6bCeZcHQL1lXxZ1w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8aa5b27-b286-49b8-3c1b-08dee71dadd9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:46:19.1197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sppgAl8o57dsjAT9/w6oijazCIlQHntEg++1YNpfaWncaqhdGOePGhZnplOTwCPGEVY5T7dHOkFKWYNXNWGAag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8514
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607210124
X-Authority-Analysis: v=2.4 cv=TN51jVla c=1 sm=1 tr=0 ts=6a5f5c14 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=Gvet67teYSr0Tz2FEJUA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12219
X-Proofpoint-GUID: lj5Ya1jG56ltHe-BdP7GVw979-7lePtN
X-Proofpoint-ORIG-GUID: lj5Ya1jG56ltHe-BdP7GVw979-7lePtN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEyNCBTYWx0ZWRfX5Bp3kmt6XSAA
 +eFkc5n9iwVlpw9tn14FRp8zbCYVRZcEmI0fhwFB2iqQe3DmjXvGohAMKWBO0SF/j9FFr92N3oR
 L5kFDqZy//0lpGWR4NwBJE990UAJaRg8QvYESrawtqYTuiyAX+Ye
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEyNCBTYWx0ZWRfX/Z5PUMRAKhWx
 B2EtnE95q82+eqtoWEKmWfdA8yNjFzMM6M7wZaazvLJI9qLSAKx3eemq+3IGBvyAY3ojIKRpVWY
 /uk4GkrGZuOw8s642U+b72KPQmJU0/54AN9g6CIs00ETD6TUY34MT2kkjw24GOzlu3pvZ7vYCwY
 A3k1CNF8JNq8hRLYe4ziLoESsQfF5ObZ0msVo86w62NViQ4heGciEy2ErLgVwFjfcA7yKj9Y7Fo
 0SePOfIBnQhhU78Qz+Uy+qWyB5Cp2J6Xfu/t0wwF9EHl8hZJkTXGBDUFVg2UknJnz03HObpViYm
 8QlzGEo8qJAaF90Ivsy2kh9KF8ieTLN9LYxI9FsP9whhflB92FsHerIhBQ0g3pH7pTaXm8P16G2
 9JLBMDdCbKwfwBaaWOTrOUh02/50SsSFtxviWCfYOiGbgKFQf9AhWKSFZNT2+CBKX4M+ZvPit2k
 8eMlbgtwmIy7Fr2nSwN6np7mF6x7sW80Sei1Chts=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_044642_463849_D8FAC1B0 
X-CRM114-Status: GOOD (  16.27  )
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

Currently diskstats for partitions are never updated:
$ ./fio_read nvme1n1p1 # run traffic on /dev/nvme1n1p1
...
$ more /proc/diskstats | grep nvme1
 259       2 nvme1c1n1 49857 0 400344 768565 0 0 0 0 0 2334 768565 0 0 0 0 0 0
 259       3 nvme1n1 99710 0 800680 1599285 0 0 0 0 0 2346 1599285 0 0 0 0 0 0
 259       5 nvme1n1p1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
 259       4 nvme1c2n1 49853 0 400336 831472 0 0 0 0 0 2315 831472 0 0 0 0 0 0

This is because we only ever update the diskstats for the multipath disk in
nvme_mpath_end_request(), and we never take into account that the original
bi_bdev may been a partition of this disk.

Functions bdev_start_io_acct() and bdev_start_io_acct() do handle
updating diskstats for a partition, in that they also update the whole
disk also (if a partition), so use the partition (if applicable) when
calling those functions.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Setting as an RFC as adding this extra bio field is not acceptable, but I
can't see how to lookup the original partition.

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c850a4bf73801..14d48cdc640c8 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -194,8 +194,12 @@ void nvme_mpath_start_request(struct request *rq)
 		return;
 
 	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
-	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
-						      jiffies);
+	if (bdev_is_partition(rq->bio->bi_orig))
+		nvme_req(rq)->start_time = bdev_start_io_acct(rq->bio->bi_orig, req_op(rq),
+							      jiffies);
+	else
+		nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
+							      jiffies);
 }
 EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
 
@@ -208,7 +212,12 @@ void nvme_mpath_end_request(struct request *rq)
 
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
-	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
+	if (bdev_is_partition(rq->bio->bi_orig))
+		bdev_end_io_acct(rq->bio->bi_orig, req_op(rq),
+				 blk_rq_bytes(rq) >> SECTOR_SHIFT,
+				 nvme_req(rq)->start_time);
+	else
+		bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
 			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
 			 nvme_req(rq)->start_time);
 }
@@ -543,6 +552,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = nvme_find_path(head);
 	if (likely(ns)) {
+		bio->bi_orig = bio->bi_bdev;
 		bio_set_dev(bio, ns->disk->part0);
 		/*
 		 * Use BIO_REMAPPED to skip bio_check_eod() when this bio
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c0..496005aff59b3 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -210,6 +210,7 @@ typedef unsigned int blk_qc_t;
 struct bio {
 	struct bio		*bi_next;	/* request queue link */
 	struct block_device	*bi_bdev;
+	struct block_device	*bi_orig;
 	blk_opf_t		bi_opf;		/* bottom bits REQ_OP, top bits
 						 * req_flags.
 						 */
-- 
2.43.7



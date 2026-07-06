Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62336C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 13:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Zfay4HgWWPlshPAuVl75odVdc+kAmfCZTtkoJhBqNJk=; b=xekjsxQEFdQP2dnLqqDspFgHOl
	tNjFFZWVLetsUYKraHON6Tql4hT1c27qc1uOJU1887Dmd7NzkBWuiNDYiGLUUGJJXNDyygFFRDe6p
	Ec4yJrUnopxbW1d19CfzW23BMTUWeldapyaLUa4+vazTjXBm3X2SNhrpzu5jkzYgOCkkMli3uP0CM
	EdxXfCt4RzXvRzOAGLu/zDf38Cb/AV+lk55GZKdsH6R/6QoXkvJxZaZfFaY1OdUCI8n5sqUMukY5R
	SwDEI0A02iHsK1fNFHhBlcSDG8hw/FlpaC/SRb2+8RLNrEs4sbSnDyWbQjt+/LeI3hg7CkJScFi/k
	a6N67i+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgixo-0000000CWM3-2RFZ;
	Mon, 06 Jul 2026 13:02:20 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgixl-0000000CWLX-0jat
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 13:02:19 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6660jIXW1147689;
	Mon, 6 Jul 2026 13:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Zfay4HgWWPlshPAu
	Vl75odVdc+kAmfCZTtkoJhBqNJk=; b=RQX8kIRqI+FfiwROWiEAGadMdv8Q8GjI
	G9SUVIjoAdjH5kDX8csw0vn1y5+Pfm/qHyYKILskhdv+IOxfW+CFCQjWj029Zb3B
	2qAoDm7KH7OEJn4EXmAmM9bXGmKcXVwlicTzOJ6tW5mDda1yQ0K/0SrDX9O2/bXI
	iUcF4UptKWXE7BET0uCP6EH00DVctyMtgOOcI1Hvn5iv8eNNRCXeBnUUj3yjPzg0
	/K3mg5C63HsUSkdHrm0mi3hSPKDY4hDRAECriJHHATFzzpKEev5VRxwQbt0NAIHN
	jKm5U+D4q3hCwgHs4ttyEUf9gH475ZIbzaifYyCfuO7GocCj/i/sqQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f6rkbbpv5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jul 2026 13:02:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 666CwfB6025847;
	Mon, 6 Jul 2026 13:02:01 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013054.outbound.protection.outlook.com [40.93.196.54])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4f6rmp42bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 Jul 2026 13:02:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2lgUe+OX30fJDdpreY6l8dKcWkD3EUktI6nsVU36NxpSbZj2p8eBTWmfucF0qr/ANeRGb0blXU/rN+JZTLj/g0rKX0clc6cjQeNRxmTi4fY6WYnJt6yp+9GeRaoivg0zL4wwjQFnO2FLDG1MqP7eXnTbFXDdrfMH1W2AyerxuAAL2O9hdCbk3WW2b3P5zV5kbLODIzymp5vWQKzQV6mR46jrK2ritveLQqk1mBirZBZQyGkJQIhvcg5GIkarNBTx2+IFcX/5ajhKqxltTC4aQ2fCf4XCZvegQIPBaLI4+Nnej1X+4W/d9pZzCW4zGFXY2eCZWGUR1nZtAnHvyb6IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zfay4HgWWPlshPAuVl75odVdc+kAmfCZTtkoJhBqNJk=;
 b=wFr69Xvu1Q+ncrlavnkrOrre6qQxaWNI56TbgUi+xvStEir/hBuk6A/zGDlGekd6joORZoxPjV5jALW5x8LMfw5cxH6v5qrqVIs07Ejae2Rm1jLv+U/Paf3YYd2UxV5s5QlxN5zSeJ+DgR5hBaCZnkjpHkL4gPmpLQWjGvkF1mAVTIpW4yrjeJZP7toia8FzauMsB2jctxbzp6Tk9x3kkgTErGsb3LKISTCMgFblvU9TtGujx5ClUw/A/NNPeKQzefUlkEp4tSiBwIbGk4Z9+W4kMQSNSkFlUfgO0ebRDJ9oiZNIPJ4z/20GkpDtGkwMiyNQi1aWwKvKy/OqipPzig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zfay4HgWWPlshPAuVl75odVdc+kAmfCZTtkoJhBqNJk=;
 b=DotX8zCOvpXVN3fDqy0dYWz/VSLDLe9RyVxmpUsXbHW8YaF5Fb4QJgyzDAfsg8xd1tv3izA4z3rysVRvDQTwOCFhuRUzTUEixghQ/xcd+1zs7Nm+Pnv4cUdKNsekj2rWgx2xkzmlKIA1cagkFVm0Yaq2/3iZ8NYlgToLWbuwlh4=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 LV3PR10MB7745.namprd10.prod.outlook.com (2603:10b6:408:1b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 13:01:55 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 13:01:55 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC] nvme: fix NS head cdev lifetime
Date: Mon,  6 Jul 2026 13:01:46 +0000
Message-ID: <20260706130146.617258-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P221CA0001.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:8:25b::18) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|LV3PR10MB7745:EE_
X-MS-Office365-Filtering-Correlation-Id: c52d669a-6bf9-404a-18ca-08dedb5ec16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 5zGTjVdJnH4Q2jRRg9lqg3sIN2qRnvnWr/7i4hiGLrRtJUpZXtE4yFBYxyv5jvToGtKK631SMUkS3O7sQr8NM90TAb3pzUl1o4DknOmh7GEtXMU5N/sAIvPXKNKmbQPHXGvog6sUEiMydL8NaCUptI1xgapxt4/UYum5QLpunvwu0GKiNgNvoQt/3CTpLkZEeZuH+xTXBbKqjA23IxooonUJgDXDU25cX8Ki4YAvQvPcumX+q+a46wivT7DHYSD/8JOgO2DIjdR+d9X5teoVCcG0ZFuDOYnBBL/S0o6OzY8liMO1/H6emgRvSxaVMwDGuRwy9inJ1ORSI0Sjsp2Q0kEpPj6ZYoMnqTlXWWDJlu/KsiNwCbc6rNIIWDMRDsVSDEqblrLN9VFajAYpyUJlKesav4v+etVQtBVzzKFhbYuFGwFzgwct4fNcyNo7oqA3KzSHI4HuQnRbMl6WcXq88bxEMVaqzN0O0DtvDo77uhXFAzRxQ/BQarLmqf0UYOVuzRjjCV2QaDh3NfwQCckUiEA84Ervg8O205yN+h8XhjmHp0NBatCtBQm3aZaD5Wl5sC2Z7ZOJ3b82WMnEI4OyJr5h2lSZjPbEK5d35X1CGNqs4Pj6VKdR7Z4/fhzPbQag8f/Mk5YTiBF9cf0DlBX7kxg/tVQLUlEZv/cpZw/oLxc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Nq4puylLaMXnI7YJigK7S13Qa5Hn+K6PvsH4mRhXwK5rWb8TGfPPGtTNMbbG?=
 =?us-ascii?Q?Foi9nMQYzY3MCQIMdIbnkJHIYyssF0zCDGwX416KGC5V0YSx8XUTa7RePPr1?=
 =?us-ascii?Q?stJoBpLG1OhDjVE83Vgzo1mGefoBOSDrL/AGpuA3hY10HNl+PLx2B212466B?=
 =?us-ascii?Q?9rAMie7/zn2CAzDHsDdOiTs1cu3kJmIS1Io7YN4MS2w0GKRBeabPJDf4wKWH?=
 =?us-ascii?Q?5wAou6lc8FG6ScO7kcf5dSJM4vVjGEmrRSGLts0AM9Ztaq2CZh17vuCsSqIH?=
 =?us-ascii?Q?inl/gb5vSh87Aic65vMBtdfNyZX4RkliYZRzSicUTZCbBoME67sXZH5GRz0u?=
 =?us-ascii?Q?GRGZjHmakz/7ydzNvnPsLcgByYe8PThQWGf5jBBKuFcyy74BnERTzxt8IG0a?=
 =?us-ascii?Q?GYY60/cD3ooB1tXGTlPehhaluf5lDq+VswR31BrB+d+jicXoDSsVCc4icfrd?=
 =?us-ascii?Q?BLeGQ3IuoWipN8HXy9EPzhE3GqXn/mdjUXabMwAuqJVBwYs4QbmmtmSnbaWo?=
 =?us-ascii?Q?V1PJdTk3DlQah7uOaM8oyCJFz0jxGSnzJIgCZiPbof0HHnJbSm0oUaQnyHsT?=
 =?us-ascii?Q?VYL7HvZu+ncLGceV70rdhR3ndKR218u4EapAFYrgZ01PBDkeKjeSf+os2FrV?=
 =?us-ascii?Q?/iWu3Jkshkg2mh4Kd5CV9LsOTPQx7r6xT22fDnNDnBAQorF7uAjzSDRQ5CJz?=
 =?us-ascii?Q?BHXVCRHh+d32rvJFKcVPd8jytQMJFNSys8c0tfgmW5ULB2VsfRdQVkDzIBXp?=
 =?us-ascii?Q?a4Xpk8q4MdBNVY34BW+Qk43PoejXVJcuPyjVv9XfF/zUhrl/1gGuc/irTc/m?=
 =?us-ascii?Q?C6lBrKh8H3KmbvtRcwUhMpmsDEYqCDKlqViDUi1e/XoxU6KNbmUNjFYvqFZC?=
 =?us-ascii?Q?nSkwlIznsQBEMTjdV3/s8a5DoZ36A/sdVAveSMUhhGaYf36QqdFpyMEKRCHn?=
 =?us-ascii?Q?loEY/fJepPOnjVAnCvQOvAg9uFOUZGobGtfDvV21+0DFBb710cOgGFrfGHVO?=
 =?us-ascii?Q?ehAj8ot9og//qyBA7DMSKPiJ77qiz2RM93wn5r/C71OjweqrygHtdoyblm40?=
 =?us-ascii?Q?3daWp9Hf6JpLM2jdqyRcn0ARTdWwu5yneBoJV5aSJ+useQqw8sBUj8gEkeTb?=
 =?us-ascii?Q?8sSVzP7nwx5cqyo3k2ckbyo9FCVuQGhMSroIszl0XGTT8BkhMArIeHKGLmRj?=
 =?us-ascii?Q?XgeLputmzaOCRQKbgYdfDvzRiu4LwVJBRqtAZ/EwAtoh1jFxCYourTjHw/aS?=
 =?us-ascii?Q?8jaOSpY9+7080GHfMr7yuDZ090wdlVbTPkX/Vo9+7fu4dkHKU5WGO1evqmGH?=
 =?us-ascii?Q?jHg+zO1xJ/RYy3//ss+SlpYd0Rqsvkn0HLchoT4kiYFplz+pmVI5CDRFlowl?=
 =?us-ascii?Q?oU0mOlhgm2N1/SlxXiOSXzQgcHnVzoccU08jEg+UllD2p8ZtpLvac4Z48MHt?=
 =?us-ascii?Q?uwmh88+9dc0b5owk45h4Kn9ZcahMarcxekuLAyj3J6hKko2qnZAfvih7Y74M?=
 =?us-ascii?Q?1ZfuqV/qCXA8+H7LDpznVzG6GGmPAuM2co89VWGRbkf2MSLzwlf+KpNbiPnU?=
 =?us-ascii?Q?kOZXWVs5uB4aAyEpnNja/R8vlbM+KkvxUbLv75ow6soEJX732PAiis+4JDUt?=
 =?us-ascii?Q?SRbCBAOqOf2fo9GxBHHz007YItlgyG73AtHtMeKZNukHp6fTf5GVEp2Fl2zq?=
 =?us-ascii?Q?e7J8TBUhSAul+Ek4X8K3MKKACQB4ndWUC1VDc7vF3/sp5HMjwpabZmy3W9VI?=
 =?us-ascii?Q?4zNC9XE8cQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: j9Mj8XNM+2qI7hIr8p3HPTIWEpR6cKE15oTjB0mnbFFXokbQE3GRGLsfzuNuTpws0849DBp2hdlmdeeRMAaNR2WHDGxypZ3lkRBFXkYlK3VH+cUuYfpnR4p7jM+gsMSZKlz7TnCNfopvR+2qpJ43KEG5+6bnpSa/UVdbyyRz+NDYWeNq/hzt+arPIPnP7mX1m6KqxNwhr/ww+1cOb/Ai9yH/+jjqWi96uKYIgit+5+IUhR759gSf520YKN3FOoe5SgIQ5tOzMTPFl/iv13yAMdpYQ/hvgMTWmbfDDlPC1dGGtO+m+Fd51u+WzYUaqkvL9gzEbWSHGaAjqsMG10LC8A==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sSoPMaWoXIShNnQn1sQbu0Ca8HIq/pMC5lbBwbSKyY2C/4w+ew7ehRetWVTvu5orB1Lqby+MV07nB/AV5mNULWYqaBGkgs/mGONP4yl+hK9v3IKs2rSTH9VWVX0zcTOWV1HrRwsTg/gPL+cTJ8ivAJXFwSL4rgP8XoW6KzXGXjVYDdMW+ic2iG0ZgMh/H9P9fOcydq6oo+4opcKEkh2UlN6ugbJHO4bbAJdgPLZ9xZ3fpO90Ih2zJY5wVmo/dYGWQgrDAtjgPrC1iQmVcV2BhIM19Pfgx4qKH7NEuNLZ462ME153PLplGTmm5AVoDY7bWbgLHv2kBfRaEHvczADo0v3KiJzeRs0e6ECdQOxHj9k5kJWmfOxp0I0Ysn5nh3KDxTWuVG2eRzqo7XIJFh+bd0vJ7Vfy6PGPCYMeSz64e0S8L9giZQaRodOd1jtF9LK2oK3firP8VhPwh0zFHOzu1LUb2dYA3UVrmfpDcuj4QL1egrOTStVVIdMMKJBkv/oWqhxIA+8vPqvdDj+z/SaaQ3GeEv3vtG96KPJXShrMAtQk8wPXdlKGa2Zc+y4UG4DqGO6gjyOIVo5s/TN0raW61C9fSIjusCLq1iaKAnDHDaM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c52d669a-6bf9-404a-18ca-08dedb5ec16b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 13:01:55.3804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avFiZoLpNoel70vviRNMnfdSm3rfE8+u3inWf4qYE+ZU+QlHgMNeZsfWXi4AqSFBDp9sDVvEG8B8mFIBtzBUwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7745
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607060132
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEzMyBTYWx0ZWRfXxk6a2xwpeqQf
 jgh9Z0f7sd8sroAJDpf0LHSQCu8sjawQqmnqNX/7FipmXxkx1Cc9Of0hKWnYZZgPvYPWcBonF82
 P7fe7IbT2ULu5mjloyeQYEFT35+EI/ijleoTgXI5eqczO6olJ8Nm
X-Authority-Analysis: v=2.4 cv=QP1YgALL c=1 sm=1 tr=0 ts=6a4ba74a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=pVYE9yASy03MFby3wFgA:9 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22
 cc=ntf awl=host:12222
X-Proofpoint-GUID: 5gKlFmJvUbTiUpSrjtqmOFIQO9OGH_uf
X-Proofpoint-ORIG-GUID: 5gKlFmJvUbTiUpSrjtqmOFIQO9OGH_uf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEzMyBTYWx0ZWRfX/lwHKKYqyb43
 q7X01XYRwTGQwDkQ0AsMt1uYwtshN0hl31OXBPg46xrZvq5gBpoNpjh+F6vRMO/7jdgrUeSgYkE
 BvLBmIb6UUTXjSVsbiyVY36JrCrM6mN3tcIC6fLdOnOrMS9Cjn3RwLm+0LvwVti9qOkBP8fB25i
 mTCy7DaRJOjO96wArZ9mqD3mTsWVG5ENeRtj80EpNE1NAQJoLADQ3q6x2Yhknya5HS69GWpXmx6
 l71zpWeMCBCheB5ejXZ65DwnQSsTK2jEfIVIBPfvyaKlBAZXJUNICwOM6F4O99+jBimGGdyPvSe
 Xx3RJ49QRDF0qs5Sg0Kxv/SICzY3Wmp5RfBg8a51Cx/rVZH7vfxiMYk/SAvfYJJQoKNKekOq+f+
 SU8QTUL0Fv6fEQd0bak9YduM/WoDBCoSDLxR6F8zHHYXV6Wq7BW91f4VR+MNnBSBJFTx1HLw0KE
 QWOXZq3EFajFTqPGBjbPoTLOOIbc0XxlsoA1Q3n4=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_060217_364285_1B88FF29 
X-CRM114-Status: GOOD (  11.29  )
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

Sashiko bot reported a potential problem for the NS head cdev lifetime in
the libmultipath refactoring in [0].

Currently the NS head .open and .release file_operations methods take a
reference to the nvme_ns_head to ensure that this structure does not
disappear while we have files open.

When we teardown the NS head, we call nvme_cdev_del() -> cdev_device_del()
-> cdev_del(). However after cdev_del() returns, cdevs already open will
remain and their fops will still be callable. As such, we can still
reference the cdev after the nvme_ns_head reference count drops to 0 (and
is freed).

This can be shown with an application which delays between opening the cdev
and issuing the ioctl while the NS head is being torn down:

# ./ioctl_file /dev/ng1n1 &
# waiting 10 seconds ....

# ./ini_nvme_teardown.sh
[   21.221718] nvme nvme1: Removing ctrl: NQN "nvme-test-target"
[   21.274609] nvme nvme2: Removing ctrl: NQN "nvme-test-target"
# now going to issue ioctl ....
[   26.549285] ==================================================================
[   26.550841] BUG: KASAN: slab-use-after-free in cdev_put.part.0+0x3d/0x40
[   26.552352] Read of size 8 at addr ffff88811e7fa170 by task ioctl_file/237
[   26.553805]
[   26.554227] CPU: 3 UID: 0 PID: 237 Comm: ioctl_file Not tainted 7.2.0-rc1-00004-g6852a10e32d4 #921 PREEMPT(lazy)
[   26.554236] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   26.554241] Call Trace:
[   26.554245]  <TASK>
[   26.554248]  dump_stack_lvl+0x68/0xa0
[   26.554266]  print_report+0x10d/0x5d0
[   26.554276]  ? __virt_addr_valid+0x21d/0x3f0
[   26.554287]  ? cdev_put.part.0+0x3d/0x40
[   26.554292]  kasan_report+0x96/0xd0
[   26.554300]  ? cdev_put.part.0+0x3d/0x40
[   26.554307]  cdev_put.part.0+0x3d/0x40
[   26.554313]  __fput+0x7bc/0xa70
[   26.554322]  fput_close_sync+0xd8/0x190
[   26.554328]  ? __pfx_fput_close_sync+0x10/0x10
[   26.554337]  __x64_sys_close+0x79/0xd0
[   26.554344]  do_syscall_64+0x117/0x6b0
[   26.554351]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   26.554358] RIP: 0033:0x7f938c067727
[   26.554364] Code: 48 89 fa 4c 89 df e8 28 ad 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5bf
[   26.554369] RSP: 002b:00007fff49f05980 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
[   26.554376] RAX: ffffffffffffffda RBX: 00007f938bfd7780 RCX: 00007f938c067727
[   26.554380] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
[   26.554383] RBP: 00007fff49f05a10 R08: 0000000000000000 R09: 0000000000000000
[   26.554386] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000000
[   26.554389] R13: 00007fff49f05b40 R14: 00007f938c207000 R15: 000055c148471d78
[   26.554397]  </TASK>
[   26.554399]
[   26.575612] Allocated by task 100:
[   26.575871]  kasan_save_stack+0x24/0x50
[   26.576157]  kasan_save_track+0x14/0x30
[   26.576418]  __kasan_kmalloc+0x7f/0x90
[   26.576668]  __kmalloc_noprof+0x281/0x6c0
[   26.576938]  nvme_alloc_ns+0x7f7/0x3170
[   26.577206]  nvme_scan_ns+0x508/0x880
[   26.577449]  async_run_entry_fn+0x8c/0x350
[   26.577723]  process_scheduled_works+0xb6f/0x1a00
[   26.578034]  worker_thread+0x4ad/0xb40
[   26.578283]  kthread+0x34f/0x450
[   26.578501]  ret_from_fork+0x563/0x800
[   26.578752]  ret_from_fork_asm+0x1a/0x30
[   26.579012]
[   26.579124] Freed by task 237:
[   26.579335]  kasan_save_stack+0x24/0x50
[   26.579596]  kasan_save_track+0x14/0x30
[   26.579855]  kasan_save_free_info+0x3a/0x60
[   26.580131]  __kasan_slab_free+0x43/0x70
[   26.580388]  kfree+0x321/0x500
[   26.580591]  nvme_ns_head_chr_release+0x39/0x50
[   26.580883]  __fput+0x352/0xa70
[   26.581095]  fput_close_sync+0xd8/0x190
[   26.581350]  __x64_sys_close+0x79/0xd0
[   26.581595]  do_syscall_64+0x117/0x6b0
[   26.581842]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   26.582176]
[   26.582286] Last potentially related work creation:
[   26.582593]  kasan_save_stack+0x24/0x50
[   26.582841]  kasan_record_aux_stack+0x89/0xa0
[   26.583210]  insert_work+0x22/0x170
[   26.583442]  __queue_work+0x7b1/0xfa0
[   26.583682]  queue_work_on+0x77/0x80
[   26.583921]  kblockd_schedule_work+0x18/0x20
[   26.584207]  nvme_mpath_put_disk+0x42/0xa0
[   26.584632]  nvme_free_ns_head+0x1c/0x160
[   26.584904]  nvme_ns_head_chr_release+0x39/0x50
[   26.585208]  __fput+0x352/0xa70
[   26.585420]  fput_close_sync+0xd8/0x190
[   26.585677]  __x64_sys_close+0x79/0xd0
[   26.585924]  do_syscall_64+0x117/0x6b0
[   26.586173]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   26.586505]
[   26.586616] Second to last potentially related work creation:
[   26.586991]  kasan_save_stack+0x24/0x50
[   26.587246]  kasan_record_aux_stack+0x89/0xa0
[   26.587538]  insert_work+0x22/0x170
[   26.587770]  __queue_work+0x7b1/0xfa0
[   26.588010]  queue_work_on+0x77/0x80
[   26.588247]  kblockd_schedule_work+0x18/0x20
[   26.588529]  nvme_remove_head+0x3d/0xb0
[   26.588787]  nvme_ns_remove+0x4b2/0x930
[   26.589040]  nvme_remove_namespaces+0x29c/0x410
[   26.589340]  nvme_do_delete_ctrl+0xf3/0x190
[   26.589611]  nvme_delete_ctrl_sync+0x71/0x90
[   26.589889]  nvme_sysfs_delete+0x91/0xb0
[   26.590151]  kernfs_fop_write_iter+0x2fb/0x4a0
[   26.590452]  vfs_write+0x929/0xfc0
[   26.590688]  ksys_write+0xf2/0x1d0
[   26.590923]  do_syscall_64+0x117/0x6b0
[   26.591171]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   26.591498]
[   26.591605] The buggy address belongs to the object at ffff88811e7fa000
[   26.591605]  which belongs to the cache kmalloc-4k of size 4096
[   26.592409] The buggy address is located 368 bytes inside of
[   26.592409]  freed 4096-byte region [ffff88811e7fa000, ffff88811e7fb000)
[   26.593205]
[   26.593321] The buggy address belongs to the physical page:
[   26.593701] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11e7f8
[   26.594250] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   26.594743] flags: 0x200000000000040(head|node=0|zone=2)
[   26.595093] page_type: f5(slab)
[   26.595312] raw: 0200000000000040 ffff888100043040 dead000000000122 0000000000000000
[   26.595810] raw: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
[   26.596309] head: 0200000000000040 ffff888100043040 dead000000000122 0000000000000000
[   26.596806] head: 0000000000000000 0000000000040004 00000000f5000000 0000000000000000
[   26.597313] head: 0200000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
[   26.597813] head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
[   26.598317] page dumped because: kasan: bad access detected
[   26.598676]
[   26.598784] Memory state around the buggy address:
[   26.599093]  ffff88811e7fa000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   26.599559]  ffff88811e7fa080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   26.600023] >ffff88811e7fa100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   26.600485]                                                              ^
[   26.600921]  ffff88811e7fa180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   26.601390]  ffff88811e7fa200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   26.601855] ==================================================================
[   26.602374] Disabling lock debugging due to kernel taint

When all fds for the cdev disappear, the cdev removal path puts a
reference to the parent object, which is the nvme_ns_head.cdev_device - see
cdev_default_release() -> kobject_put(parent). We can use the lifetime
of the cdev_device to resolve this lifetime issue.

Fix the lifetime for the cdev by making adding the cdev add take a
reference to the NS head and drop that reference in the
nvme_ns_head.cdev_device release function.

[0] https://lore.kernel.org/linux-scsi/20260703102918.3723667-1-john.g.garry@oracle.com/T/#m67265e2906d617acd2743c0a00809246d0cfc506

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
Setting as RFC as I am not sure if this is the best solution.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd09..c7578b7ed6b76 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3887,7 +3887,7 @@ static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
 	return 0;
 }
 
-static void nvme_cdev_rel(struct device *dev)
+void nvme_cdev_rel(struct device *dev)
 {
 	ida_free(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
 }
@@ -3900,7 +3900,8 @@ void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device)
 
 int nvme_cdev_add(const char *name, struct cdev *cdev,
 		struct device *cdev_device,
-		const struct file_operations *fops, struct module *owner)
+		const struct file_operations *fops, struct module *owner,
+		void (*release)(struct device *cdev_dev))
 {
 	int minor, ret;
 
@@ -3915,7 +3916,7 @@ int nvme_cdev_add(const char *name, struct cdev *cdev,
 	}
 	cdev_device->devt = MKDEV(MAJOR(nvme_ns_chr_devt), minor);
 	cdev_device->class = &nvme_ns_chr_class;
-	cdev_device->release = nvme_cdev_rel;
+	cdev_device->release = release;
 	device_initialize(cdev_device);
 	cdev_init(cdev, fops);
 	cdev->owner = owner;
@@ -3956,7 +3957,8 @@ static void nvme_add_ns_cdev(struct nvme_ns *ns)
 		 ns->head->instance);
 
 	if (nvme_cdev_add(name, &ns->cdev, &ns->cdev_device,
-			&nvme_ns_chr_fops, ns->ctrl->ops->module)) {
+			&nvme_ns_chr_fops, ns->ctrl->ops->module,
+			nvme_cdev_rel)) {
 		dev_err(ns->ctrl->device, "Unable to create the %s device\n",
 			name);
 		return;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9b9a657fa330f..016b6b0128c71 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -616,29 +616,23 @@ static inline struct nvme_ns_head *cdev_to_ns_head(struct cdev *cdev)
 	return container_of(cdev, struct nvme_ns_head, cdev);
 }
 
-static int nvme_ns_head_chr_open(struct inode *inode, struct file *file)
-{
-	if (!nvme_tryget_ns_head(cdev_to_ns_head(inode->i_cdev)))
-		return -ENXIO;
-	return 0;
-}
-
-static int nvme_ns_head_chr_release(struct inode *inode, struct file *file)
-{
-	nvme_put_ns_head(cdev_to_ns_head(inode->i_cdev));
-	return 0;
-}
-
 static const struct file_operations nvme_ns_head_chr_fops = {
 	.owner		= THIS_MODULE,
-	.open		= nvme_ns_head_chr_open,
-	.release	= nvme_ns_head_chr_release,
 	.unlocked_ioctl	= nvme_ns_head_chr_ioctl,
 	.compat_ioctl	= compat_ptr_ioctl,
 	.uring_cmd	= nvme_ns_head_chr_uring_cmd,
 	.uring_cmd_iopoll = nvme_ns_chr_uring_cmd_iopoll,
 };
 
+static void nvme_cdev_ns_head_rel(struct device *dev)
+{
+	struct nvme_ns_head *head = container_of(dev, struct nvme_ns_head,
+						cdev_device);
+
+	nvme_cdev_rel(dev);
+	nvme_put_ns_head(head);
+}
+
 static void nvme_add_ns_head_cdev(struct nvme_ns_head *head)
 {
 	char name[32];
@@ -647,11 +641,15 @@ static void nvme_add_ns_head_cdev(struct nvme_ns_head *head)
 	snprintf(name, sizeof(name), "ng%dn%d", head->subsys->instance,
 		 head->instance);
 
-	if (nvme_cdev_add(name, &head->cdev, &head->cdev_device,
-			&nvme_ns_head_chr_fops, THIS_MODULE)) {
-		dev_err(disk_to_dev(head->disk),
-			"Unable to create the %s device\n", name);
-		return;
+	if (nvme_tryget_ns_head(head)) {
+		if (nvme_cdev_add(name, &head->cdev, &head->cdev_device,
+			&nvme_ns_head_chr_fops, THIS_MODULE,
+			nvme_cdev_ns_head_rel)) {
+			dev_err(disk_to_dev(head->disk),
+				"Unable to create the %s device\n", name);
+			nvme_put_ns_head(head);
+			return;
+		}
 	}
 	set_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 824651cc898db..60d2d35926743 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -999,8 +999,10 @@ bool nvme_tryget_ns_head(struct nvme_ns_head *head);
 void nvme_put_ns_head(struct nvme_ns_head *head);
 int nvme_cdev_add(const char *name, struct cdev *cdev,
 		struct device *cdev_device,
-		const struct file_operations *fops, struct module *owner);
+		const struct file_operations *fops, struct module *owner,
+		void (*release)(struct device *cdev_device));
 void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device);
+void nvme_cdev_rel(struct device *dev);
 int nvme_ioctl(struct block_device *bdev, blk_mode_t mode,
 		unsigned int cmd, unsigned long arg);
 long nvme_ns_chr_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
-- 
2.43.7



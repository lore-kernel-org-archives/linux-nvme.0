Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA03CD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 11:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=P2DG5UgT0TaOkWdT/sSJ3p0GalLAVFv6XvCiWAwBTE8=; b=1/LdgPRuw4njOVNlrzUBEmpK15
	ztLBtjVZtS+bOeHUCClMVVbBVlKNoaTPcVwlgQXGn84E93yOTOO/TvVo5TTIw1s1LobRB5A+SEOuj
	9aCyc9qjZmu880biIJatkvuuDJmVJkAohm9ILgvqgCRZDAOwJEza7bXaqPuZBwbEOh0lFjF+LOPbC
	p+OsDuUrvgjDmoDB0MCgABWg5jES6u2+QY1X0MJsBoCzQ+Sx267QDqOQt8HVrvcxjaftHh1DjtM1u
	rCIqFxs+ueml8nIgvQIGEUFjexkQu6VxUSZHc4RFzYC7ugUXQpYrq3qXMi5joJOvP6rDeUz5UEVBJ
	LkI+W2gA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXGv9-00000007VYF-1xcS;
	Wed, 10 Jun 2026 11:16:31 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXGv6-00000007VV5-0cgd
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 11:16:31 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A6Mnwq2827020;
	Wed, 10 Jun 2026 11:16:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=P2DG5UgT0TaOkWdT
	/sSJ3p0GalLAVFv6XvCiWAwBTE8=; b=BE7egjMC81CpXkkbYbEg6ml4Q1CHiMIA
	lTqTQFQSCE0Dpye4T4VEb6Axzo1JwGm9DBaJzIKVU81zO5S5pD4LbxJlGj03Clsr
	yYzGrH7buYoV91GWJb6VkkbCQTtK+ulZObWsqVArZxrNQcSSuhsYI9ae59Ho/Cmw
	aqfXuldoA83JhBXfrxUb/kJI+EYAYOdfLmRqkW/MdG2e2m3kfrXPTG6/N4RTNt/N
	YnSi9im2YgSWqNXqylhZQv48TJwBE/UjaEMWxVYjhAnRAo/5Me1J9m3Rk1MTRxCz
	SyQ2wypk9sQMr1L0jtXDN2B18jOHhw2LyP+vQq8h10fiGMO8KvXJzA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4emc3rpacy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 11:16:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65ABCuhQ017894;
	Wed, 10 Jun 2026 11:16:17 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4eq5e138q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 11:16:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hps7exIjkL1oxx26UvkiIReFIoMkZQXNpDZ/c896XLIKirkvQIuA33/nGj16/8Lrct7zXeb3NQ46sl8ai4Prc+Aoro7EJRkNOlYQYfnedJnjO3YbtWO+qdCO/HVWxhVxEq/p5XiN1wzsRDI4h7kO/sTMA65cRTct9hlHMCmwlvgL5FmsYNAPhviGZ3wk5tYXwvycaguSusWIhBF6iry7rw8nLz7U/vtqlVf4R68BcrM5qIPWcmlgMq/D8nD49dhduFj+/lb4pGyx/Nnz3ea0sgECWQMOjjtJC7juloPbzufd4PkVRcSuWTxfWjIicdsQrPgDzLNL+lqWgPqvm38vKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2DG5UgT0TaOkWdT/sSJ3p0GalLAVFv6XvCiWAwBTE8=;
 b=LH1Q7dAlcHtrpVja6vaXcm8EHYaLggI1yrwr3Nm5s//OOVqBJcxGp7SuAMitJ/9lK9RDBYQQNfi2Xyz0hjQasMDLrx240Dv3Gl86KrLzAVffe0p2B/PwnJ7TUZeuRGP7gcGMHNC3LWqpC72k9TebO1fhpvql+7bpp26DlJnQyW+pmCNOVaG/smejMqwH131KBvvMsBk8JkPOmcNq9h0Z31aXtdsqzcyq02TUS8/U5YSTufvb1hxV1y2zp4iQPienKEzyqWArLVhlz0atLjpZX8zPT/XTL/jsduAlOhbnLP+b8YcHXVLzEEIzigHZRnpuy5I9i23VHBkWNInplPbTjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2DG5UgT0TaOkWdT/sSJ3p0GalLAVFv6XvCiWAwBTE8=;
 b=jz7kGD4r8qHWfsAtyscKHTtgfN5vCDk1i77ux4YHBuVXeLmcpMj7uxJ7g2vkMROBvPx/cAMo8NCWibDSZiLGLm9ZP1YhVgKZRFB+abxOWo0QQ55LpGJa/7ixEEHmaxQcIDJ8mlWZib0YbG9aBY9imzjWg8HzTqNAdQqirL2j0gc=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SA1PR10MB6662.namprd10.prod.outlook.com
 (2603:10b6:806:2b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 11:16:13 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 11:16:13 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, mlombard@redhat.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] nvme: make nvme_add_ns{_head}_cdev return void
Date: Wed, 10 Jun 2026 11:16:08 +0000
Message-ID: <20260610111608.3252988-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::27) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SA1PR10MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b030e0e-535d-407c-1e68-08dec6e1aed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: E2Uolb2TCI8PxMoC8DmOCefeWsUtSFjgjtAn7OXFyldLIfg0gWhYUHscdlvIBuO+QU06GIBliBP2Olj6u9k4m13UdTmMBGFxYOoZb8T7KEym0KAGmbC9ivOxQfZlBReYjXhqj0o0aLODdN3enRpWPc+A77jyZwNIvXRvEaIMD38TqG+/jIoaumnR6t/wu0wci8Sj6RT2nxTo6a9qPp3/aiXEWS1+rONhfcZV4at9kFwm3f+o0YSi37mlg0ZHjck3ln3Y+tltsoNT+ip6GBwPuMacdNq7KJixD04MrJUP6lqd4ugG6na7HzHIYXX2C0K2XRXiaDoP4uxtY0qx7QqUbm4Sa9Zsb3NZHKukKfgJqv0ieYepRnkVCu4CE2cR1+6/HA3Pda7xX4uaj5r9nBO0f9F9Y1ijIY6jfvj7XLdN9aOgOV4OWYpYbD9+Nm5f7KbV6X9qPMsmDonYTp8cyNssvthvzroFPcG8pXZOWMTpO6Oq3aGhOns9XV7dNuepkAoHa3Hqqjd7fR2rGXQdlNpiHVB8xGIu4UgRzaPXo8visV/YQCdMKD8Wwa7FlPBdo7L1Pz1fNx5Si7WC2niR+j/PAIMHswzpzTS8TEBVZ1tSG3yMKbxL2F9tNFwVCHVh96Csk2QNHfgoXbmDYMttz31o+qJql6C0eZvyjNuxvaaiVDx4L9qT7jD8ydulT3GPYMev
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bTfLwtN1RzEAtzJaKAlPXOEEcxsQR3kG9NjUytU+nLNtoNo7vYR8ORwYys2E?=
 =?us-ascii?Q?AJG/Vdn1OGfM/oQ17cAudikJqFZTi/rw6tCxWzduw46rUqrWjNAGO/4Dl9sW?=
 =?us-ascii?Q?eLtEixz0u95K7vRD/dRj+B15KElfzYwEwv4+yzJOGZvPqV/vdWqrsYEHwf8B?=
 =?us-ascii?Q?de9EDP/GF+wiI6TY18gTDc+EcQ/6WxrP3vBzWQXS+w7pbGcGN9TUTvnSWh5k?=
 =?us-ascii?Q?E22Ie93vTtC7lowyMuPUO7xFwyqRr2vgktLFZ2D8QWtEeHenTLnZlLnnySIP?=
 =?us-ascii?Q?djIq8lJjjiBfYqigbQrSgPTf9fD/zqrstd8zgMh6ZVUIFItsZF6Dwi9H8kIt?=
 =?us-ascii?Q?h5SsEF3XSqVLSiDm6nFisIc+GY6uo3/j1OnPJnPY23lLIDcHmEIOn+1pQmsD?=
 =?us-ascii?Q?Apuq4LEGOUMuVEZswCcm9sW8ytu5Meo+qU4MlTp9OA+7l9R6+AuET5mmBXO5?=
 =?us-ascii?Q?eT7ss/l95spV4518ET4Q6iiklzP1RZL7b6IBZFUrvCu3Q4MxZ+yTa0WIaqaG?=
 =?us-ascii?Q?yKvg3475CCt7z/MJDvKYezqW88ybPDosZ/PeUUuadPb7+RhFwlLyaOJTYJ20?=
 =?us-ascii?Q?VUZ1jA12UFgcX2XdS3Njux5NwOFw3WHFscVj3EVFdT014IANAIuu8pqfqHGA?=
 =?us-ascii?Q?J1wRI2rSeGEvtqXr7D7SfOgAFP1zJfGmostdrOha98xmn6gzKzjmRAF7ToTD?=
 =?us-ascii?Q?KEqb9SWtIj3nAJLtD5mV7tmJHbGg9EtU/yBK6kFZasGRuZHg8fP9YPB14OOC?=
 =?us-ascii?Q?2Cs+4f9H9ERD058ztoAV+R5vXdVD3D0c8ikQceFOSwr+afHhaO2/AGVLPmZP?=
 =?us-ascii?Q?MRnEEvbLetXHIs0IE7DFoFul70oq/lqDAvOPmYF9MgBJUwi46l6UBM+cqEdk?=
 =?us-ascii?Q?TVDxSXuYgkgwpS16HMljuGtnFa5kM8SSVLZRrHqGUz3Cvfe6clegPBi4Wcih?=
 =?us-ascii?Q?l/dm9aTNW3XfVxDEVHgkgXzUpaBjhwnqpDi8w1t5JdFinqvZkWoaGnRsrXAS?=
 =?us-ascii?Q?48ddxsf+sV9K6DM3y+NySzPgarHAuQJnqOPZZEZa91ydyCjfpCwi4j65g74z?=
 =?us-ascii?Q?Ft9YJZ1TJQBSm3lpVS3iz46EcGVofjvDFWG0Mg4pxy1s3lh/v+rewSHMXGwU?=
 =?us-ascii?Q?QCSB+dE2gkWjFIh4Zqcbx7a+YGNOMWw//Bi5JFCG6g9Npe6mDJaPVFBfNKBX?=
 =?us-ascii?Q?Uq+AW0AhGu/C5Qa9k+WGsXmfFgRGhbUHMZSNit0/IFfR53ROeLnU4X3WLeKb?=
 =?us-ascii?Q?hfKHVgq46HOSOdIDIeV4BuUGJ7E3EHzvwsCDGsrOrAPkMuKfBD+IaAvgcGzM?=
 =?us-ascii?Q?2s0W+GMCYaBRFlpiM9a5L4aBFSOfQq/hfYegmMe4zEG/iOs53BVBfihn1DeK?=
 =?us-ascii?Q?u21YJyEf7LiOEm9D9scSRcPlcIfNoHknv95wtC44QnWQFFqi5My1HfkjYee4?=
 =?us-ascii?Q?EAmFEQmUM9rXG47Y+y+OzepicDVd+QPSXlEf690c0Il2WqT7u5Ur/inQ2QuV?=
 =?us-ascii?Q?rVQs6tucDRFXOlyye/VCIhEm6C5Buu+K+1FKPMWHFIex1txixh5OrEX0GzUD?=
 =?us-ascii?Q?MW81knzHrJ1gKUikA+0vF0MP3vqNRBgFwUSsTySg4n/ShYR+N/3iWaxpXT1Z?=
 =?us-ascii?Q?kF8t2g0ykvZ2axqwky/wMD3mfiEB69K570nxXV5QOaiVi3iVWPXLpV5g5vqd?=
 =?us-ascii?Q?7+/L3JFdVYeeaATqV2Eed9Vcn9CjRUZmDf+RdI/egWRzcLZBqQNVrmzmFTv2?=
 =?us-ascii?Q?v9eFKhhmJA=3D=3D?=
X-Exchange-RoutingPolicyChecked: ZESyORZvfRRtkc54cbrJ6Z5Lk6fm6tWmCWWVbKdZpKwKb4/RNBluBXjsWLGx6adTd6Tbej9fifv+1YYNorhh+c8VQSsoc8u8jCnmhX8YMuJmFRD4LNeFR9p71vI3ipk1utM3/UObYkMLjrEYZhmzpVyCiEE8vu5K0/YJmNw/ftUzFJ2RhNFQW2FpquEXVdQhNKTUb259oTuWPd/z8aNBuHqy/lo152l7EPAVfVDwlZJG1rKrfg/ldH+96/8piJJDzBsGH9FvXdsZjgWymGMbOb8EX+Z1scP+Se4/uVqhF6Kb4GtFvTHb9oqtXc+XVeZH6Oxhhi53jbovyV1e5B+zdw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: St979H1LZe6NFXxn0dHQy0GvYFYNxzD+1ktmNHqoG8mjNYPTon6FREK1r/hTOV1HYx9iVj2w3yHJexUcQKin2DqjtD7e0aXUHwC8Ihi5a9QwRfWTJIaQ2xiISP+Hq7B75WP4p//0j8K5v27Z/tn2Ni+yZ6QCWgMOqKXlerNfz0+2onwkhx+cfrVHZ6dxBvWoqkBlXSjTr1t8qqVWSciekC/kpbkD+4pC8UVZ9sqFcLDls/DH1parmK8UFBlhkwe951mxbAnFovJkfUs05rFw1gSiUuj9Es7gmGkdkQ1ezIri7+6870CGYuTFg+8BhaR/MfUl9CKTh0shXPl35vgBWqKL13FQuNKn9WNdWmg8x5GhkNWFT3IT1xbnov3fSFZwJxjQORsokBy2jmB+9IGteA585plLqbPkVlZwsw1ye0oQlCjXcH350dRC97tc4aMOS8siozlOpPV5XalBIEh7xrd8EcJDybedDiyzTGJKlYsBfYB1FMX30/CnPGd2pMuaBJ7Tzk/HAaLiSvDlYy4qM8sKItxhHWuLGZij+sI0ugLQo476WHYEcqbdl0//+4nn8aEyXQl2oxUk+P0+Xq3X/i7dRMz50IwJe+2r8O1nRvE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b030e0e-535d-407c-1e68-08dec6e1aed1
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 11:16:13.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+z1EPPqjoEe2Cocb0c3uneb5vUZaFO0PYY3VA9fyxg9UJEbIRSw5CNDXuw7RkLR7JSoKzw702N+ogm3FMs1JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6662
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2606100107
X-Proofpoint-ORIG-GUID: 2Nd0z34-5Yh8Ly4CGHqCyiSCb3qDRzTs
X-Authority-Analysis: v=2.4 cv=crirVV4i c=1 sm=1 tr=0 ts=6a294782 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=7Gl3-_t3PgB9XO-mQDs3:22 a=yPCof4ZbAAAA:8 a=Q5V-2yLUoWknPJzbRBgA:9
X-Proofpoint-GUID: 2Nd0z34-5Yh8Ly4CGHqCyiSCb3qDRzTs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEwNyBTYWx0ZWRfX/9iGO3WfPnQK
 xsGxBpq4hULwOMhJ7/M+3aXOUXEFVIASfshGILSCgTWMS2iOjz/gJDj1aVLWmZsu2oVprjzv9IN
 gK6IB/Nd3TNcACKDzciS81hhFNvStMKEIZEjHiFfMWq4CzDdj3Jjl8cSvohsETypNmiv9yWCe57
 bdys1IzxOLaofaPrqILaLZ4nJSK/5kb2EHV/2zmKqh5f0ZioVNB+8I0TSVeNvmVdBLy8CWR2ZSh
 yoUfAQnbr61XZnxWQPDn8YlFq3W7z/XOHmkbTaqeCrML2wcGt0mwWeHKXsCJFP9ROMdImLJmINT
 T6wbb4HL0H+ZbprU2zAapH8s7k6mEh1by0zQriOTkmzMVK2TNlCJvp0wExRuxIS61vDUJm/guT/
 sM9UI/d57V+JiWIHwCZCSoD1N0h59yEdh3gqf1+ES6wTZhsw9OzwEfer4UlnxsMGGgCM2J/i76s
 TNr68AQxTEH88xfOuvQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_041628_488356_A87C624C 
X-CRM114-Status: GOOD (  11.50  )
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

The return code from nvme_add_ns_head_cdev() and nvme_add_ns_cdev() is
never checked, so make those functions return void.

A cdev add failure is tolerated during initialization, and flags
NVME_NS_CDEV_LIVE and NVME_NSHEAD_CDEV_LIVE are for determining whether
a cdev needs to be deleted during un-initialization.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c6930e43cfea2..eb268148acec9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3943,24 +3943,21 @@ static const struct file_operations nvme_ns_chr_fops = {
 	.uring_cmd_iopoll = nvme_ns_chr_uring_cmd_iopoll,
 };
 
-static int nvme_add_ns_cdev(struct nvme_ns *ns)
+static void nvme_add_ns_cdev(struct nvme_ns *ns)
 {
-	int ret;
 	char name[32];
 
 	ns->cdev_device.parent = ns->ctrl->device;
 	snprintf(name, sizeof(name), "ng%dn%d", ns->ctrl->instance,
 		 ns->head->instance);
 
-	ret = nvme_cdev_add(name, &ns->cdev, &ns->cdev_device,
-			    &nvme_ns_chr_fops, ns->ctrl->ops->module);
-	if (ret) {
+	if (nvme_cdev_add(name, &ns->cdev, &ns->cdev_device,
+			&nvme_ns_chr_fops, ns->ctrl->ops->module)) {
 		dev_err(ns->ctrl->device, "Unable to create the %s device\n",
 			name);
-	} else {
-		set_bit(NVME_NS_CDEV_LIVE, &ns->flags);
+		return;
 	}
-	return ret;
+	set_bit(NVME_NS_CDEV_LIVE, &ns->flags);
 }
 
 static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9cd49e2f760d0..9b9a657fa330f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -639,24 +639,21 @@ static const struct file_operations nvme_ns_head_chr_fops = {
 	.uring_cmd_iopoll = nvme_ns_chr_uring_cmd_iopoll,
 };
 
-static int nvme_add_ns_head_cdev(struct nvme_ns_head *head)
+static void nvme_add_ns_head_cdev(struct nvme_ns_head *head)
 {
-	int ret;
 	char name[32];
 
 	head->cdev_device.parent = &head->subsys->dev;
 	snprintf(name, sizeof(name), "ng%dn%d", head->subsys->instance,
 		 head->instance);
 
-	ret = nvme_cdev_add(name, &head->cdev, &head->cdev_device,
-			    &nvme_ns_head_chr_fops, THIS_MODULE);
-	if (ret) {
+	if (nvme_cdev_add(name, &head->cdev, &head->cdev_device,
+			&nvme_ns_head_chr_fops, THIS_MODULE)) {
 		dev_err(disk_to_dev(head->disk),
 			"Unable to create the %s device\n", name);
-	} else {
-		set_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags);
+		return;
 	}
-	return ret;
+	set_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags);
 }
 
 static void nvme_partition_scan_work(struct work_struct *work)
-- 
2.43.5



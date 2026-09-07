Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF231C79F89
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Sep 2026 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J9o4ieBmGZL18Q+OWSm9FZGpiZapsYeD98jP3kX3/i4=; b=hIqZ+HB6BNKo6JGU/KAyk180FC
	rpeWejsnHt19IM3bCoE/Ss4z2rstJ9KRy8EsBDPHHni7ay4MijGkvfukYG9fyWea0X5gpGN/CunE9
	PuMqpnQwnV/ku73AI1XViS8q74clDlcTMgo7vzf53ZBtvSVdk/JlKx07N+HHycxhqvqgkz9WT80vU
	+0LrB8wpKFgoPjXc0bISYPrY4cvT5c86KsahavDe4NTNf/9PJFY71f3toaqnWTMdkjGLOrBWjusXd
	UBcPQW5/eOYwGH406Ux/XGYqwJAnRQmwZJPcDxlmkPmbkWWmxj//8+U+JvCOeHgsyelms1+UlaQ3U
	jcuahAaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3Wy5-00000006YRk-0tIX;
	Mon, 07 Sep 2026 10:52:53 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x3Wxh-00000006XmN-3EuN
	for linux-nvme@lists.infradead.org;
	Mon, 07 Sep 2026 10:52:33 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6871pNpj825152;
	Mon, 7 Sep 2026 10:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=J9o4ieBmGZL18Q+OWSm9FZGpiZapsYeD98jP3kX3/i4=; b=
	bieXcFBRz1rdqfUar/XVKvu6BIxzQLBgnPsUtZVtxrb6pM8Z9s18mbpT7dZrlen1
	xD4US3SdSCY9ZBKgoQGdnA6TCVz7Owm0+G7cD15Kbymtfav0qpyne9uHCpmER/gJ
	3geuJHGslV9A3Vkfua3TIUY2e6yznxK+x2+4RBR7NSlR/SfXN8k5hiTJj1EprRJb
	OMYkZvvxdBGh3Dqwgdt9e9ont55kHGzHumcyfZfJ7B5e5NoJI3SLxHaFdmoKdfvT
	VdA1yK0QC6DiiPLct7Y3NROJjA2Vu6eS5fP/aKD7YJ+oFq7lTWDvZzjNBTXfTkuA
	3/gWdEEAmk0NTMHeTmae7w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ggbd3st0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Sep 2026 10:52:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 687Aogoj011743;
	Mon, 7 Sep 2026 10:52:17 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012033.outbound.protection.outlook.com [52.101.43.33])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4gh711ybst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 07 Sep 2026 10:52:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zTKEyupffbTdxTwkbAsERaRawXhOcg6/buy+uNCzO8527inJXSG314RE5ql8YniVgQiL6Lpwik3xXhx+HNTzul8CAwPMHeRTLLxPATSbCrFCyyLYwC6PjZFy7AOLpT1/FOclsRKcTKjOzluxK2RMxUuypl771y5+jCc97/GsdD9cXWi/S7KKxCxFcIHk+PLyO+cCsxMILdPF+3W+qaek4DxSbQMKlU+GCZ53PM1tfLoKu0FJPi8m0VIWEbYbo7M3IeOkQU838ro5XRorqCwPJbniAp9BcXmpit3sPpqFJvT3t4e2MT0NwluqRyH6u+u0PxUjgzSzZ9FzYzsaUm/mCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9o4ieBmGZL18Q+OWSm9FZGpiZapsYeD98jP3kX3/i4=;
 b=dzRZerffUpI4h7kRwZZ3CDSW5hAdKF8Gm6zBnAcTttvAiPrNGmRFymMvXf3qtUOJ5lDaoYX+6D2GEnTNl5T5OWMZu5ZfLZtE6RoSNpk7aqWDtzoqJ4tbbJONBuJWY8PYwKjT/xwx0M6cTc+C5WfWEW9IPqSBJCrOjuKjd7a/FpwBzKLNUi7Pq0TmVXI9nqvLcNhc2qdIcFGgP2r1kX9/35MqA2caTeUjD4VnztorBsc6gfwFT5JOBo9pMbuBxxQ5lMyZxJi6u8HNst4OTovxuLMpttZklGy/IQovisfHY+Pc8Hz3WhPGNMoK7veoC37zR2Qc1dneYuN/qPqSFCFoXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9o4ieBmGZL18Q+OWSm9FZGpiZapsYeD98jP3kX3/i4=;
 b=lsL8bts/NnhDTmyDguTk2K2xMemfk9ymIkyPcIpMqvkyvQAk+r67rg3EdaPsBRBid3EhQsvebceHn1B2q6Rcwi4rB7p4NIXJIfEutdLhkA/hVsQDUK8V8FSuplTJMlCi3wiqVkzCuftqoV5Q6u7HX1+TL8MjhXJra3ejswkBJm0=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 LV3PR10MB8012.namprd10.prod.outlook.com (2603:10b6:408:28a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.4; Mon, 7 Sep 2026 10:50:36 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0406.005; Mon, 7 Sep 2026
 10:50:36 +0000
From: John Garry <john.g.garry@oracle.com>
To: james.bottomley@hansenpartnership.com, hare@suse.com, mkp@kernel.org
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, bmarzins@redhat.com, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, nilay@linux.ibm.com,
        john.garry@linux.dev, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        Hannes Reinecke <hare@kernel.org>
Subject: [PATCH v8 01/27] libmultipath: Add initial framework
Date: Mon,  7 Sep 2026 10:49:55 +0000
Message-ID: <20260907105021.1763236-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260907105021.1763236-1-john.g.garry@oracle.com>
References: <20260907105021.1763236-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:338::21) To DM4PR10MB6229.namprd10.prod.outlook.com
 (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|LV3PR10MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: d18aefa7-7685-4757-c80e-08df0ccdd8f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|7416014|10067099003|18002099003|22082099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: HrBG5E7hUhULfdxiCAjP6XUPvzGrHAtaev8TQ+zfInss2FQq9KUaoJRMM6/2EwAgwmicTl78GZIf1VcoD4+4oVvcxRxDLkfTOZxPof9hgVvRQrsbnRdeFUM/DXnAEwri2Gapo54rJ6saF5kzcRB69PY4w5riODzAljBzcPuuvytWKEcWa+ySD8M8IDME5syMYDs5n9a3eRYzw5D8b9dv4/fJj0EQ3gVi7m5sFMe5a/9D4c3YlV7+2UDGeWWx5ExZDX1HKL8/HsmkKm9wa64MUcH1A0H8wznLB38o/3wg4N9x94caKKpxx8NYBNJNUMv5VABA26NXBkn4iNaqRYz0yGEI+UktZMFbBAyXjk0CPXgJP5uZsPBSIkyl5L0jMZgpJn55MC4dXf58BCoKWN/4qp8IvGtw7xOqfgxEx5kWNEtpwLZGrpCUjNyU6XJhI8r7inbPkvG7FiKEtYHov7RHccwDOLkdy4JH8W3TQ6zl4DOm/QhC05LYMvrGzu+JYBDlYtf3z+TFupcJOg4yOCEfiwVott/Z7/EX3VwWwUI2HkYgsnYIdePhGQQRi+E8j1a58dedsTi8VxwwlCmBAZmi/r1fgXXZaK/knMUKHXPneGMuhy/5P1UaICllr6NyVUJ8rHuTGhTyzWa3HXPg+WUkRBGQFbzM2YbGWR/VM1zlLj4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(10067099003)(18002099003)(22082099003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3p+kPPxYTzMASqUC9gtBomyUwc6wZAK6rFXZ4to4aLXUmEtpHSFKCBG/h9Vl?=
 =?us-ascii?Q?o0b7ceINEmXYJksxSE8mOkoA0MJ0maV1B7DQrx898ZuW6CZcfAXy1aa6tRr8?=
 =?us-ascii?Q?/a5CDFG2GEWglmSZ8L9Ngig26YDUsPgZ5FKO2a4vWs3O14Awbw9G6gV1+TQm?=
 =?us-ascii?Q?YidrCYjnd6PnJZFZZt99nypKObcNoGxMMn0VrioGAU19XJMIpiTb1salzUgb?=
 =?us-ascii?Q?/dV3kBkp4ZIGbscZ0eRAQM4rol6EwC0AqgZov82LWE3iGAEGGMLMQRSftf5G?=
 =?us-ascii?Q?PR18Mv5d/fpfZJlBKrIIyp0shCfgN9YzvDUn9+bBeL/C6TCbqbYDqDKGjNh3?=
 =?us-ascii?Q?zwg1Uu8xXcRE09iKOwiOSKf4sK9IH742Shgu2X6AWxEEfeJw5unwPC55RLX0?=
 =?us-ascii?Q?p+XIxv2hFHRR9xxp8dGuBQIKca7Vlddfx0LkaFEaWr/WF3K/JZSfTW2403dK?=
 =?us-ascii?Q?Fs7Irjn1yQEPvu204w1++CiR0USWCiBWlmOomPX5sNBADj5Vx9kZ6T6C1ESj?=
 =?us-ascii?Q?/Ro5zfRtzKfnkH2WREny8+4m9uYUdJhxA9XAXv23xgBzcY91guNwmnvDnPjb?=
 =?us-ascii?Q?Cn9HzqxlVH363rEqweIUgvjeKEooAG2Wp+4g33Y0+5v7MgFzJD+J66cBSGaD?=
 =?us-ascii?Q?vaCkUhCHoWzyojeoBAnZGjxe010NyHj/2fydDf+LZzlH98LQ4yK69AGtb5Pi?=
 =?us-ascii?Q?7IHMT4nBlocXsj4AGcWpaVEOO4TrnUqH6Jgs9qajYUNWtUYS2f7/jFdw0KcN?=
 =?us-ascii?Q?jTEEexAjnC3yH+B2ReOWG5ieJACmU6jUCr/OArSO16cxe8Wk/BPiDiJoGfZ0?=
 =?us-ascii?Q?4cSI72Fbk3L840DsnjXUcZq8CVouel6T335776qqTswkaUKXaa0mFuDo6V4I?=
 =?us-ascii?Q?7Xzxp7qcX+RYJdiv2uGy5V+i3T2Qafg9iKcdf3O8nt0cj1SDOq+cKN1Q8U6D?=
 =?us-ascii?Q?B7HNDOQvdu/bV6LKH6GCMv/4WK0i8NHwo61KqxIBaMyJBEP0P+t0lXkPVA4N?=
 =?us-ascii?Q?zmjdDFaA1NulEyZ8l5kCwUY9UZ1LtSVuWpQjvPy9ZeYVXKfaphT2eV8AzBLA?=
 =?us-ascii?Q?xTLN+Kz4reO3Ev2A1KFGfU01LMgoiUv45xww2smX6GpfuWTSe4V1ClqqnO+H?=
 =?us-ascii?Q?ZlKlkN2iBx7ZrB8r99SfT4v3hXikGxC7XVvw2zgQ/7CZIlqiwuJjUfEzMpZT?=
 =?us-ascii?Q?PhDAAcPQOy5ssgfphMJqyI8EP8aU5YQFr3rZDMapSW0ey7RCoOM056K7gDOo?=
 =?us-ascii?Q?Zac75B5X+JlVvWTz7Wui0u74lyUN3U1/6lCfJZSk5bmOa9y5us+FeLU6JcXR?=
 =?us-ascii?Q?9XSCyxn3T9lnEXgxXklZxPqIins4EZfiSYnzqzY6rw8Yq6zRUFBIrntd7qFW?=
 =?us-ascii?Q?Ypd5s16pZsMp7GwPHrwi3QFoWrzEHlTn3KQOSBCSwF2JfizYjCUruow7xzPG?=
 =?us-ascii?Q?esz6ZfQAJMOahUNlCph4jF9IKNsC4sfUhBS0C2NaOvdQD4ueI3lf4+Vp06nz?=
 =?us-ascii?Q?G1gdt27g7r1a8hzRbu9h4ItRA/MIpvklE9ayXXDkVu6/gIfBKg8F7vAja2eZ?=
 =?us-ascii?Q?GTjuvf6KyVJwrDJlYWKAQmPf4p0ZCpBLA6ggAVvHW8atpdQs7R794M3SLXYc?=
 =?us-ascii?Q?gGtzOwIwUkcgHILfp8uxOdS0eZi/EO3mB9Gth8YZAQLCXS/GAgKzClHlXdTG?=
 =?us-ascii?Q?YWBT8lHu8lOp9XsYa3fE29i9u58Z870puGzEqD9fN3zui7GszKm3w2NQqLo4?=
 =?us-ascii?Q?RIqLq/Acjen3IcXoSMrS4YauwFdAlZk=3D?=
X-Exchange-RoutingPolicyChecked: 5To4k0UtLeB3PeVXjFaAkUfhrNfuxDW/q3D3fL/mAn7Q2cq+x+hG5q6k+/qZY411ktw0J7fHsYmo0EhbMvdBAmayBLaOTxp3hOtA4wzWtX3Ja5yefBM7LYWsrIAXVsOw5C4Osv5RUn90+Xz+IQa022sTjynNnn151XJzvCRsAgly03JAe7fC0/6kwpuRIy5PnFgkY4wNBIZOCTkspRBA1SgmLAIA3sqSPomIJEyR1LZ2YPv3XuCq/98iZGeKsKfSrCWuTNpIijxlmHtFVReI6x9g4NT3foZ+WJ4XvC/s8i/I0bqZtcsr2DufCnJ2VE8rPduUeu5+MlsWb64sRdIMiA==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: IjXE7pI2OtB0YqA4Cr4i2OA08UF3UnPOXEPjRxGUS0R1bdwrKyXXKXkPGK55c+wTGlMiLYaQoSD4Xa1bO9JI7FFJF/JeO+kZN81KYxfhmJWn4m6kZR6GzWO/d0i//cZyUr9DpoKkq5GKbvYMCpIk3n4mgTpUwtqS8sWadcIds1MJ1QCSlpMCKuExIw7Eo7cv1n7KWg5ZwK0mktOuKrwk+ldHcBa+d5d6o+1JsVMY5yqHaDXKMz4FiDbIKuoKPCwY/qo8pJDyUFvRqD7/H3r8Q2tuQZV/KtLgeXeypFwsx12NaYCmfUH3V6P1tA7jjSZ3RjPBsGWI83tOx+wi7Ne0IhcGsZ0UsIqNTb4mvx/I/STVoDcjiAP7EBqSY12fEUyX4CsRB11hPbyW4CUtTMfThWBBjeC492LepvrHLfrQoQ5VYaam/bFYljWgeFwVKF5G41s+7aRsEbV0fwKV1B11Iq9kB5op9GgW5j9WstQWQkXAvC0PFVwB9L2FSerVRzhwc/ZpHsNrHPQpeOC7ZtNmeVl3m0yioEw9c+Firt4qqKHbB/2e80jr04deGNv0gibPolLwylmFwSmEKC+u0q6lyolRPOf61zEP9fiHv2YM9Oc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d18aefa7-7685-4757-c80e-08df0ccdd8f8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 10:50:35.9497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TNLQU8CNVmFTiwQHGlha9s341wgiGzfyz33LB4r+NFTnLfiZX8KKXLFtjV6ZGPGDJxuFnPdPqt6SqVwKTpd+Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8012
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_03,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2609070119
X-Authority-Analysis: v=2.4 cv=EuDiaycA c=1 sm=1 tr=0 ts=6a9e9762 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=VdqzKS8jKosA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8 a=IMLwmY2krkRuQTCR-eYA:9
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExOCBTYWx0ZWRfX8K284aCDiha7
 mUo7tdQB/iWBqpKwyBcqtAlLDOXCDTkb+ZCcosBrRhIBUMCHXm+yW099xR5qrQLm3xWVuFVMZCt
 xPuzFtq7rb50nuPgVIyb6nIsuwTqfpiwfX4FCCHJqm0OQrZ+adpq
X-Proofpoint-GUID: OKO6FjDMhYQ9tMpVd3b59NIMBZCyWUGQ
X-Proofpoint-ORIG-GUID: OKO6FjDMhYQ9tMpVd3b59NIMBZCyWUGQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExOCBTYWx0ZWRfX/ph17eDfxnnZ
 ixl5DuiyejexWDQiD7fA4hd8TQsvmc7sxfC+2YLgznwTk4n1/PH1AnTJF4k0SyTNbStkXvcWzBk
 OWWIkoFPUNVsgHOKlVK94DrJoT/4ltXgf2lHlEE8cOE3NfcdUAIAcrouaHo48L4rubxbbAbcket
 tXV64kDgg+X7NJOwPAipX4TONssInRMlFDWTymlDKSOzLKRwp2Puo2D+0lF2AyB88ofNsNvICQI
 uCfDK3Wi/OGDbIoWytUabop4jNAcrnko4/h7osnhMr+im7j1C3+pruVhN3IwA7mJLCan/UfQ2Hb
 +UGz9dyj0m+ERBE4WsoTdXNwPHjHmhivBMDTuSJqJPQbmXA1yJTJxgRF6x4ZA21wKut7JLIBM5V
 tXcnE7MpT3UqK9qtAL4dTJOiliaI8u46aMREPt9QYb9aKQrfCbjW4R+tE38Fbj7rvT/ihqCwLRm
 Ag2gYThV/tS75Pq8jmQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260907_035231_563054_A417D877 
X-CRM114-Status: GOOD (  22.41  )
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

Add initial framework for libmultipath. libmultipath is a library for
multipath-capable block drivers, such as NVMe. The main function is to
support path management, path selection, and failover handling.

Basic support to add and remove the head structure - mpath_head - is
included.

This main purpose of this structure is to manage available paths and path
selection. It is quite similar to the multipath functionality in
nvme_ns_head. It also manages the multipath gendisk.

Each path is represented by the mpath_device structure. It should hold a
pointer to the per-path gendisk and also a list element for all siblings
of paths. For NVMe, there would be a mpath_device per nvme_ns.

All the libmultipath code is more or less taken from
drivers/nvme/host/multipath.c, which was originally authored by Christoph
Hellwig <hch@lst.de>.

Signed-off-by: John Garry <john.garry@linux.dev>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 include/linux/multipath.h | 28 ++++++++++++++++
 lib/Kconfig               |  6 ++++
 lib/Makefile              |  2 ++
 lib/multipath.c           | 67 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 103 insertions(+)
 create mode 100644 include/linux/multipath.h
 create mode 100644 lib/multipath.c

diff --git a/include/linux/multipath.h b/include/linux/multipath.h
new file mode 100644
index 0000000000000..407d985cd31f5
--- /dev/null
+++ b/include/linux/multipath.h
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#ifndef _LIBMULTIPATH_H
+#define _LIBMULTIPATH_H
+
+#include <linux/blkdev.h>
+#include <linux/srcu.h>
+
+struct mpath_device {
+	struct list_head	siblings;
+	struct gendisk		*disk;
+};
+
+struct mpath_head {
+	struct srcu_struct	srcu;
+	struct list_head	dev_list;	/* list of all mpath_devs */
+	struct mutex		lock;
+
+	refcount_t		refcount;
+
+	struct mpath_device __rcu 		*current_path[MAX_NUMNODES];
+};
+
+int mpath_get_head(struct mpath_head *mpath_head);
+void mpath_put_head(struct mpath_head *mpath_head);
+int mpath_head_init(struct mpath_head *mpath_head);
+void mpath_head_uninit(struct mpath_head *mpath_head);
+
+#endif // _LIBMULTIPATH_H
diff --git a/lib/Kconfig b/lib/Kconfig
index 4e6b34c3346d5..8e0c3717e8e9a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -630,3 +630,9 @@ config UNION_FIND
 
 config MIN_HEAP
 	bool
+
+config LIBMULTIPATH
+	bool "MULTIPATH BLOCK DRIVER LIBRARY"
+	depends on BLOCK
+	help
+	  If you say yes here then you get a multipath lib for block drivers
diff --git a/lib/Makefile b/lib/Makefile
index dfab958327c5c..7041d278f2d1c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -350,3 +350,5 @@ CONTEXT_ANALYSIS_test_context-analysis.o := y
 obj-$(CONFIG_CONTEXT_ANALYSIS_TEST) += test_context-analysis.o
 
 subdir-$(CONFIG_FORTIFY_SOURCE) += test_fortify
+
+obj-$(CONFIG_LIBMULTIPATH)	+= multipath.o
diff --git a/lib/multipath.c b/lib/multipath.c
new file mode 100644
index 0000000000000..f7b26c66eac7c
--- /dev/null
+++ b/lib/multipath.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2018 Christoph Hellwig.
+ * Copyright (c) 2026 Oracle and/or its affiliates.
+ */
+#include <linux/module.h>
+#include <linux/multipath.h>
+#include <linux/wait_bit.h>
+
+static struct workqueue_struct *mpath_wq;
+
+int mpath_get_head(struct mpath_head *mpath_head)
+{
+	if (!refcount_inc_not_zero(&mpath_head->refcount))
+		return -ENXIO;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mpath_get_head);
+
+void mpath_put_head(struct mpath_head *mpath_head)
+{
+	refcount_t *refcount = &mpath_head->refcount;
+
+	if (refcount_dec_and_test(&mpath_head->refcount))
+		wake_up_var(refcount);
+}
+EXPORT_SYMBOL_GPL(mpath_put_head);
+
+void mpath_head_uninit(struct mpath_head *mpath_head)
+{
+	refcount_t *refcount = &mpath_head->refcount;
+
+	if (!refcount_dec_and_test(refcount))
+		wait_var_event(refcount, !refcount_read(refcount));
+	cleanup_srcu_struct(&mpath_head->srcu);
+}
+EXPORT_SYMBOL_GPL(mpath_head_uninit);
+
+int mpath_head_init(struct mpath_head *mpath_head)
+{
+	memset(mpath_head, 0, sizeof(*mpath_head));
+	INIT_LIST_HEAD(&mpath_head->dev_list);
+	mutex_init(&mpath_head->lock);
+	refcount_set(&mpath_head->refcount, 1);
+
+	return init_srcu_struct(&mpath_head->srcu);
+}
+EXPORT_SYMBOL_GPL(mpath_head_init);
+
+static int __init mpath_init(void)
+{
+	mpath_wq = alloc_workqueue("mpath-wq",
+			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+	if (!mpath_wq)
+		return -ENOMEM;
+	return 0;
+}
+
+static void __exit mpath_exit(void)
+{
+	destroy_workqueue(mpath_wq);
+}
+
+module_init(mpath_init);
+module_exit(mpath_exit);
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("libmultipath");
-- 
2.43.7



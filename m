Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6637BC54764
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Feb 2024 13:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZQbsZAQvArweFa3njuy/wWwnZ44IO2NQmkmAY5STZKE=; b=iF73pQInWUoECjQFuOMvnJ9sW6
	Ymc++49VyKEZU20GATo+Cd/8KFAxnJ/lL/SJkWZZg2OvHGysXB8+l+nDgDz69oUDxLxepiADOKptf
	qza4JnJZAQ0K5TDThWl8FZNqr3QLFDNuXWWKIFcFaS44VXTsDs/yiWVLsAll76irWlA9n9UBulyc6
	Wg1Y0mlAQuowdIItOG4JQIkOlkZcf0vf2+9b/pGCy006IldzJ6tMgSGnSz9+t7yFh/TscqXJ1FHrT
	gYct6+c40ivXK29TkSAuA6XbSqAil3S9fGlrD7UqZSx77fKdJdnmoVL4tpI8dKGVEniO23gjRcANd
	bMXmC5yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc3K7-0000000AX75-3xmn;
	Mon, 19 Feb 2024 13:04:43 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc3K4-0000000AX4T-2QcT
	for linux-nvme@bombadil.infradead.org;
	Mon, 19 Feb 2024 13:04:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=ZQbsZAQvArweFa3njuy/wWwnZ44IO2NQmkmAY5STZKE=; b=oakSXSZkdg24ivREkVsT4f+ULV
	n/PTnJdL5NHCjN0DNzhYkby7pi/W9tkubrdNpomhiDWZR0JUt4HPTCffaWOeArNOkHgH3gtCPmJ8h
	lsHYLKsg+zhUH/G+D/FNVzL2jFz7hI9g4dZHxudDb6+FBkOtJB5XU7LZmo33T491w3uau4FRj7wgW
	Nj3VTIGYye80A1qAvLDQdMcg73J6wl2e8/3TF5mSecYm4Cby7Syxe/CBYkS/YNvXDjxdHaHAAz0+F
	I5Q2IpelpAo/QaqJ5V26YWFq8Oys7XHcBRLq/3d+tGg+YF+aNkpFQj3HzG9Lt+koTbGHG59eMVujN
	8vvsduqA==;
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rc3K0-00000001Fw2-42Z6
	for linux-nvme@lists.infradead.org;
	Mon, 19 Feb 2024 13:04:39 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41J8O8ZE020687;
	Mon, 19 Feb 2024 13:01:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=ZQbsZAQvArweFa3njuy/wWwnZ44IO2NQmkmAY5STZKE=;
 b=GgNSXntTpxz8H8zeWVQLR7mZ1TnWo1UDUUsX4Td5bD7UlNJ616wPLte0+BZjN/ZpQnT9
 bBKQscCB1tFdtQsl8QvU7RBFL9mr68zXthjKGZxL8dgL+SAOTcSK3C6hd3Est6eRpJsy
 8/3ocHi0Yq3Q9dDlGpVxT0jjVraxtZNQJKIOYGuoBlG1R4RlfJzRvnuKdks4VGFl/hgy
 FgstMDMjOT1deh6f+CUGFFp69usX4ZD3DAzsCLUdeI7kPIkFAZeY3N+JKB/qxwNW4h3Q
 7RqZtNlJb4AP6/MWAe9NJ2wqHJIAo16zRne2re1GzvVa3rdkcVM0hPjj08x7Cot4qjs3 Og== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wakk3v66h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:01:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41JCPE4X006609;
	Mon, 19 Feb 2024 13:01:46 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wak864kt4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Feb 2024 13:01:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5W8CwBtoHls3ba2SGa4+EDqgFHLXwyFq/8WKTV/N6+i6HLZ1e8I7kYat3JYqJIxHGFPxmGRjaTnJaEJtNkySRi3FixJY821Mx4f5GmcLbbbGafHhSJ1yojG8MtOa1b4m4ZHXbgPcb7/uD83t78AlZV22y5Gi0ZyXoV2qV7OKIZiY3JGi+KuB7RxKc7bqH+HjNfd+nch83SbBZQD1doCKTUhz+K7siajU/yUOPW3XVZ/5aee1PGPDIEokPvjWfrJyOPXjdz3K2mYF1lGWL8SowZoBiDwwic3UnJQ+1pj+5QI2I2QQhP+m8PsCoj9T4sBYctj1X92YxJCSAR+GX006Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQbsZAQvArweFa3njuy/wWwnZ44IO2NQmkmAY5STZKE=;
 b=LEdAwJ4rULDDbcpjePJj89d1Ccx79YpWvTH0vmyZWkneExObJGEfDiXFrmhT7nFSC+VOwErUu495zVWB9HLTRqLkj6vBpNm4E2rLDuWu2U5iPIETgH3CCsw4K+jamRVOYNhpmTFE2GeswOm1xMhMXsRSLUmS3YmOV4EUnlVcInA9BGZc51GMBOYyj+Ppqk2kn4FmanmtrJzmbUDc3YzsN+uVBxFLGIWowEm0pl8bbCVKlAi8RWBURbAXMIwwN3b6j9Qk04i6nJB3snCcIVuxZ++uy3t+8JZNewIYp3SfpJQ6FEGgoP2gve8ldEhHuk9SSetQQxyvRuIZHTHICvN2mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQbsZAQvArweFa3njuy/wWwnZ44IO2NQmkmAY5STZKE=;
 b=aaSESelLU9ZoNaxKK7mH1nDC2VVTTy/3cLW6WbCU3ynNKteo2NmNU7Ru0njGPIRtLp/GoJWxnNhXBGHGuM868K7x71zNg3JqpAm4PuBeDCm1ceHR0qMiktdSaoL8rDYdMrOaxWg86afntSZkuxV+kSGMgowm3ehJX5MEHMtw0kM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6894.namprd10.prod.outlook.com (2603:10b6:8:134::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 13:01:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::56f9:2210:db18:61c4%4]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 13:01:44 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        jejb@linux.ibm.com, martin.petersen@oracle.com, djwong@kernel.org,
        viro@zeniv.linux.org.uk, brauner@kernel.org, dchinner@redhat.com,
        jack@suse.cz
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, linux-scsi@vger.kernel.org,
        ojaswin@linux.ibm.com, linux-aio@kvack.org,
        linux-btrfs@vger.kernel.org, io-uring@vger.kernel.org,
        nilay@linux.ibm.com, ritesh.list@gmail.com,
        Prasad Singamsetty <prasad.singamsetty@oracle.com>,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v4 06/11] block: Add atomic write support for statx
Date: Mon, 19 Feb 2024 13:01:04 +0000
Message-Id: <20240219130109.341523-7-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240219130109.341523-1-john.g.garry@oracle.com>
References: <20240219130109.341523-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0279.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f366cc6-abdd-41c3-5362-08dc314aec82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdqi0Ddi+4K3/CxzoygsyvwFX8HKdPGbdffhGu1GvJryDFkJ8v8noHxjJGVIucnDZxH8PLyorUeK4B63NHD1M6vQqtyDEJXqyvMiWmBkSqRxEBxAh7JJq1laWatWRTRRSeD4GZKLt7Ln+nEC0Q6g6rNnMnsK/kuVSLyV9WBkeZkMjAqpSmziEL8JqCn+QuzVLMSftHTTNQ7DQft2Y+tPJuQmaPgy0J5LyZNp0tOiBOOmgMyQzOg1+iRlxV1nbad38PmDRT6R5l06HFB09MiSWe0ZxQbEpVQ0TSvqn5b1ZUYd15gPoITpI9E8doQ1LOGNjXtyfLmT6ZW/sOrqa9Fb9GoJw1NCV3honnL8Lw0pQcgonzp10+GAYIL8msv5Ql718ZsWKpdvmdmXwnpq1/p1xjpHDSHceG9D6J+FAvkHIjaoMjCQaAEgxynroNuESw13pkM46/ZusE4pZWUHSK+a2WmkKMQzwWdfwHxMWiqC0RODtgKSmvYiHRieWXFdc4xZPws7UV2CnooY69oPLOMYRSwFb2x/GO79yQCvUmF7RsAdP4vFiccovaIJY1T3I49ix2k3xHhlg5HYINFkYoGdjvahNRO8W3dokaH7nBVXJ08=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kQ11Kx1MgslnI3WkpK4+yiK3PvnZC5qns52KvKJGPwqADES6rNmODlLRPJYL?=
 =?us-ascii?Q?hFOokCdnJN0sg1lG4T0O2Zdg6HACS0w+zgaLIm4Fz8JMQkQh+vR04i++uctB?=
 =?us-ascii?Q?ZLJ+PBkrdmk1E/DCHVqHTV1mUUqWOf5qrSgTc4a0abJXqVq2zt75Ido3ujEM?=
 =?us-ascii?Q?sABLhpp1C5jPuh0VpSIRC6gTfnTCcsGUzH3PYLYelOU9ckXDUi+aowOIrd73?=
 =?us-ascii?Q?jdnnx5Jiyd5l61iWwhXP1RqzX7D5N57KjFh5tveL6d9zDo6ud3d1zxkznb56?=
 =?us-ascii?Q?Tkmwvnd9wE4t0om32j5+IWN0QSF/0WwRfWnzCPU7ZJVn+j2cC+I4hTsdkgQ7?=
 =?us-ascii?Q?EmoBctna1xJkroyMvnZ/y8XebBxZkH1y5onILeSkx5g78Bx5GayNtXGCRMhn?=
 =?us-ascii?Q?RBeXzZMaVzSawhgFOV2vOwMgBy/P4woKNSwH8jmMHV+SAd12rOlcyPjxFnvQ?=
 =?us-ascii?Q?9ib3HxH1XoAkSj13+ELCGq67V4GZyYha2hiYLFVOqtDmxIdlSVvHUnMACydB?=
 =?us-ascii?Q?uNiNgjh9HYG/bti1CfJEjRJ7Of8DS+0RHmF+A8ZShYxhzWVpIu3ylqEoLBR5?=
 =?us-ascii?Q?iHILyp1ZGkMl+QtfNw8J/WW6IVLzfM+wjhM9TDxZBmmxe+yvTLO9bHFIut6I?=
 =?us-ascii?Q?3mh2kZt9WlJ7weEqimB5tEdw/VhNaVZroGwFQLckz9oiAPGtrSFcncWfOvv0?=
 =?us-ascii?Q?F1Rl9KkfJdk9CIQIvr/xv/nvyOJvAvPSfxryZK+oLPQ5OR4ooeHj8DmD4obc?=
 =?us-ascii?Q?Nazqap7vGe+DWl1Cy+URiTj3YyeCVNfSnQI9wJPPga8VedT9+4IHHM2HEv6I?=
 =?us-ascii?Q?C2Ap1IR25qnAP9PeeyMODR4MH3bcLmmhWV1fAT4AXQD0djbnMgr5stqgfyZN?=
 =?us-ascii?Q?ECzWaNAoSW5rYWVNKb9lq8nV8T7/uIMxWC4Hf4LPCrOaLbXJrIKp6Zn2y8Yt?=
 =?us-ascii?Q?mpaGt2H7XDW5+4wmS99pEfxX04PHBaqHmPHUhaxN3Cbj9s6TwK/Dg8aYc/Co?=
 =?us-ascii?Q?zrL5ox6y31fYhfoK2zkbpIoLk87CjsbDCDyM9jyQ4yKjL3o7TMaX/s7E29x3?=
 =?us-ascii?Q?YL1c9Y2pTLydZm8nKdgMnqW5QXy1KSzMShoNrvpDGzOdjlZQPLBjTNYSowbe?=
 =?us-ascii?Q?IG1DekZQZmV254W+GYtWxdwO5DCMnvK+y+6W69R+5gQCEWeEduQKOYlL/0Mr?=
 =?us-ascii?Q?UYKQzBGHlAZk4fSDYs6DQFv0etGBbqT7nfhxQzEy9r66O0WB5NCLa+oW8UGG?=
 =?us-ascii?Q?uRYP6D+nzoSwEIpbMt/FGfCQj9MJwJfqCuN5QK3dhknV9UGf85ObMPqamTh4?=
 =?us-ascii?Q?qeL4fajP/MTWLCmt9igVjMQ9qeSgVDxNVSm2WmPH9oq7wt/7Cg+5RLgMc54m?=
 =?us-ascii?Q?Gpi1BheKyoaChwI2BPajho8Sch25RdP0gbQ/fX+BKeEpC812Kt9uHKxFjXgj?=
 =?us-ascii?Q?YyROnIofAkezn7app+1T5YeYVnNdZEK0KlYrq1MHmy4S8V0hcbW1w5ivYI0s?=
 =?us-ascii?Q?ttuQ1TLFC2aRX7tZ0ij/6Lzp14uzHXjbYxHPpi+siahjKcsosM/w47O28acA?=
 =?us-ascii?Q?Q5Un0+iTlVqe09nwxeb/Ipeab3CEqFwJbf+Xwxu3220v4zWc4S/U1kS6Oie4?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NlVhx6vcG9ExHYBJGSHbjTbd4k2dkU+RTbAOt/T7HR2NYM0DGyONjtIr6aDYiwF6U/QpN7+fxRuprJ/ShCRpRVDhGG8LrGkIb64LTZ1ceKmnDrwGswwm7reG7ZUIX7s8u1evDWKFYSXlwPvwNRuBFZ7WxmwtuCdohlNHr0UFXjFqwmSGA6g60KlxbCK0l2ACbaNPiAR2nq+EQD9wFQw855e6Og6PWpX5luEmXzeIob4hXg6idFcfqqyk4EL9RKawLN/6mPWr5970pzffyQ+l6x2AW6hV1v+p3+bkSvBCMeLNcM+QPg9NjVDSoaf56pPFNrCbvwHNibPprqpU5pUskeJWxpP+BVm8Zw2GxGWdGt56bKYOmCq0e7c6YM8loz304Wpijk64ywwWX1RSdDCASkhEj9cvtGC1O9PaD6hVFLBWnvwI6issGVZ44UcmrJkjMa8mhzEAS8dzN3yhNkC577oxH1O591t4fcKpIgCEwJ4VDYVcwyAZBzBwECW5/BWxBNfa/45FXBzFij1uiGS3tWg8eyQdgKntvROqP1Ip7xFPawcvYOFHDBaxYd6A+YIr9B5kJlOBzeQBwuJyaqXjZzGEmuVjJG/SVFEoJdr+lvE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f366cc6-abdd-41c3-5362-08dc314aec82
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2024 13:01:44.6393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +htIqel4c+qrUpZtOqapzFF6DMXjVJiqG9cpjtza2EThmGRxpScmxS6NQbNVFdhABXpP7T0uzL2t9fpF2YgjjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6894
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-19_09,2024-02-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402190096
X-Proofpoint-ORIG-GUID: wZE-LVtnN1wVDImnYlwmThLe_UWOKyN3
X-Proofpoint-GUID: wZE-LVtnN1wVDImnYlwmThLe_UWOKyN3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240219_130437_540106_0F0E71DD 
X-CRM114-Status: GOOD (  25.33  )
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

From: Prasad Singamsetty <prasad.singamsetty@oracle.com>

Extend statx system call to return additional info for atomic write support
support if the specified file is a block device.

Signed-off-by: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/bdev.c           | 37 +++++++++++++++++++++++++++----------
 fs/stat.c              | 13 ++++++-------
 include/linux/blkdev.h |  5 +++--
 3 files changed, 36 insertions(+), 19 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index e9f1b12bd75c..0dada9902bd4 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1116,24 +1116,41 @@ void sync_bdevs(bool wait)
 	iput(old_inode);
 }
 
+#define BDEV_STATX_SUPPORTED_MASK (STATX_DIOALIGN | STATX_WRITE_ATOMIC)
+
 /*
- * Handle STATX_DIOALIGN for block devices.
- *
- * Note that the inode passed to this is the inode of a block device node file,
- * not the block device's internal inode.  Therefore it is *not* valid to use
- * I_BDEV() here; the block device has to be looked up by i_rdev instead.
+ * Handle STATX_{DIOALIGN, WRITE_ATOMIC} for block devices.
  */
-void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
+void bdev_statx(struct dentry *dentry, struct kstat *stat, u32 request_mask)
 {
 	struct block_device *bdev;
 
-	bdev = blkdev_get_no_open(inode->i_rdev);
+	if (!(request_mask & BDEV_STATX_SUPPORTED_MASK))
+		return;
+
+	/*
+	 * Note that d_backing_inode() returns the inode of a block device node
+	 * file, not the block device's internal inode.  Therefore it is *not*
+	 * valid to use I_BDEV() here; the block device has to be looked up by
+	 * i_rdev instead.
+	 */
+	bdev = blkdev_get_no_open(d_backing_inode(dentry)->i_rdev);
 	if (!bdev)
 		return;
 
-	stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
-	stat->dio_offset_align = bdev_logical_block_size(bdev);
-	stat->result_mask |= STATX_DIOALIGN;
+	if (request_mask & STATX_DIOALIGN) {
+		stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
+		stat->dio_offset_align = bdev_logical_block_size(bdev);
+		stat->result_mask |= STATX_DIOALIGN;
+	}
+
+	if (request_mask & STATX_WRITE_ATOMIC && bdev_can_atomic_write(bdev)) {
+		struct request_queue *bd_queue = bdev->bd_queue;
+
+		generic_fill_statx_atomic_writes(stat,
+			queue_atomic_write_unit_min_bytes(bd_queue),
+			queue_atomic_write_unit_max_bytes(bd_queue));
+	}
 
 	blkdev_put_no_open(bdev);
 }
diff --git a/fs/stat.c b/fs/stat.c
index 522787a4ab6a..bd0618477702 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -290,13 +290,12 @@ static int vfs_statx(int dfd, struct filename *filename, int flags,
 		stat->attributes |= STATX_ATTR_MOUNT_ROOT;
 	stat->attributes_mask |= STATX_ATTR_MOUNT_ROOT;
 
-	/* Handle STATX_DIOALIGN for block devices. */
-	if (request_mask & STATX_DIOALIGN) {
-		struct inode *inode = d_backing_inode(path.dentry);
-
-		if (S_ISBLK(inode->i_mode))
-			bdev_statx_dioalign(inode, stat);
-	}
+	/* If this is a block device inode, override the filesystem
+	 * attributes with the block device specific parameters
+	 * that need to be obtained from the bdev backing inode
+	 */
+	if (S_ISBLK(d_backing_inode(path.dentry)->i_mode))
+		bdev_statx(path.dentry, stat, request_mask);
 
 	path_put(&path);
 	if (retry_estale(error, lookup_flags)) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 40ed56ef4937..4f04456f1250 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1541,7 +1541,7 @@ int sync_blockdev(struct block_device *bdev);
 int sync_blockdev_range(struct block_device *bdev, loff_t lstart, loff_t lend);
 int sync_blockdev_nowait(struct block_device *bdev);
 void sync_bdevs(bool wait);
-void bdev_statx_dioalign(struct inode *inode, struct kstat *stat);
+void bdev_statx(struct dentry *dentry, struct kstat *stat, u32 request_mask);
 void printk_all_partitions(void);
 int __init early_lookup_bdev(const char *pathname, dev_t *dev);
 #else
@@ -1559,7 +1559,8 @@ static inline int sync_blockdev_nowait(struct block_device *bdev)
 static inline void sync_bdevs(bool wait)
 {
 }
-static inline void bdev_statx_dioalign(struct inode *inode, struct kstat *stat)
+static inline void bdev_statx(struct dentry *dentry, struct kstat *stat,
+				u32 request_mask)
 {
 }
 static inline void printk_all_partitions(void)
-- 
2.31.1



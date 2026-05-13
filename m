Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382EFCD37B6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2026 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0s1RBonW/INi+ShM2WEOQPwd8CvenCikR4RWZ6MjwNI=; b=D6uIgMi9Xwoxnhe+exX2q7mBKa
	PDvd0u2RBPxOpDmruAcfiwbKuSQCYEEdDjbzRzE53r+olmb8LaCcFEcOsuz9eGoF6EzVyd3ylSd8X
	Eb3AuHcrOm58xsgZd4JKFSloFtK1rlrCoFEbaDZnfMzr+9XBQLAN6EUDJ1lXrq2k3bOKSjhDSv/72
	pLuDQu+0iGWFPE4E2cglYce7id8827JcnbwVS1tXR4SIPtV19KnbgHEO9YbEXxBz1FHJ8MJPSLb/k
	V3XMOljOGX21P4amp2nPLABMP79VImIDeLQz59VNvuGmSYiVVHEo0VUoChmMbaE0XEeCRlc3kVaQI
	fvtvFMNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN6FB-00000001zRx-0t3U;
	Wed, 13 May 2026 09:51:09 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN6F9-00000001zRl-1x3u
	for linux-nvme@bombadil.infradead.org;
	Wed, 13 May 2026 09:51:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=0s1RBonW/INi+ShM2WEOQPwd8CvenCikR4RWZ6MjwNI=; b=h4o9XJmgQCwVXyG8E5KsSxOEr4
	Gvof9U4a6v3oAHuiMFe07Q8ZLMNarFTHqmEU8gMziwGiJowHXp6mnzKv6Olfpx9Y09HjSYE7oQGzl
	J6R188+bbXnSYEA7NPDNOJgUY9tAosR+4u0c3VBQJ3SyWWQOVIzaUf2h1JVEwPA1D/vHoRXDRctgd
	5QiZbAWxwJjMyUP9GMgJS2becNlQNYd1yi5ceZAxnbJ1vbK8g2DBNFWm7zXlPFkRSxMYp0GDnuebO
	nV6nA2VkjNT/cEgfNtiz4TTyxzY83RufC7X2eUZi7denjUf4SSSqxb3hJAwNHQokDqMQUEuQMi20F
	4bhwAiTw==;
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN6F4-0000000H3D5-0NjS
	for linux-nvme@lists.infradead.org;
	Wed, 13 May 2026 09:51:06 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D7MiUg3195574;
	Wed, 13 May 2026 09:50:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=0s1RBonW/INi+ShM
	2WEOQPwd8CvenCikR4RWZ6MjwNI=; b=CHbkBFZ/gnACWeqwVPkMnVOEDifTHBnu
	4EMHymtJsUCSZzU3zRG34Y33CbxK/ots8gmnM64JGdDzfYL8hrmzn1jHsIZHkh3l
	TTiYyiIDqTKAFOzZ50yrE97oqrOl931AGfwR1qPaiot2JX+DS8X9D+a7hYR/HUq8
	h/3kXb9lIJiFCQ4AYdxqCIpBVWgbxFtcMGvUuGDZtpALkye3VyGmXkqmtxSZr8Du
	LVfF0oAOKOpWhbaoXtHHBdqj3eWNcA0XGmEVPT1IFIxjK1lM5J85RRI+amo5LEnP
	hP0lUU2LMhH4l1R++KejQCZNS3gHWx8aWnZxc6yGlpFcqXjVzn2Wpg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4e4c970wkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 09:50:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64D9o3WO006074;
	Wed, 13 May 2026 09:50:46 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4e3nej76dc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 09:50:46 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KoiwImhOqEN+Abqt77DTZsAYOcJUrvJYlysih5j8H5Y6/qae0MZ9VNcvbQaJT7NeeTWE08gfSHQjq4DU8IAqigy2QGO0r/nrfoPNb7Le4TMIwXEnRL0AIjnVWlH/hKzVMii9q8l8fVb6hTYfVm1c6sszK4H8MaUteYtqLTp0cCIvOCjwMwqOD2GtA5P25kYjQ/ATd9j44gJa/+gKtUWdxLxXUeiyD0Xwsz84ZegwwV2xOd1HvOjiPdAqZvihcAAPxHHl7y5tMr/ZhK7lMC5ARBo/PsM0Hke1etIMj1BM7FIi62vDqrnw86e/evOAxWbmcclHvoJwT5xHFMvZHmK/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0s1RBonW/INi+ShM2WEOQPwd8CvenCikR4RWZ6MjwNI=;
 b=EhgDtEhA6jhmG/t2E7025e9SrsjVNWCdG4xJttwBhWfnS+8ZK4E96BkHPFMQwVjsGs4+lCJrftaJnrrQWKozBKopNIMyoJaO66G6UG4pi9i8MdUbzISg9uQzEA4SfJlksJBSNdZ1Jb8APc9gd6V0NW/ipozL37g8X6tKxGg4WVnFege6VwfRCvAKH0pIcamdnrH5bhynnRF2uGiieBxkUJdL3DuWgqP+P1rGnMdXQcUkEHqPRnL+keYL3M8mqQWA0iXGuiE2u0Rp6slT75iJ/3vNrQAjFVWS5dQqFH3yJpD0YlcQtYWcJD1bfU2UStrb0d03BmQ0TvRTmYm+9SA2NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0s1RBonW/INi+ShM2WEOQPwd8CvenCikR4RWZ6MjwNI=;
 b=T0WF7iTBrqUpAwBaKJLh09xjqGQXHzjsfcAEA+o4lTk2hRMPlyiGMkS/j2RLAYuF3H4e/AS6/mUOdPCosV8aZfCeezZuYvsO3NuKwDxyfNipuP8W9/Cf1m4PUuNynCdM375dDwJpxrEq4WXmaL6jQkQWBM8Vx9mkUx9Cjy0/W0c=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DM4PR10MB6887.namprd10.prod.outlook.com
 (2603:10b6:8:101::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 09:50:42 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 09:50:42 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, bmarzins@redhat.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] nvme: use DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE for multipath_sysfs
Date: Wed, 13 May 2026 09:50:30 +0000
Message-ID: <20260513095030.2771178-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:610:76::24) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DM4PR10MB6887:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c50879-165e-45b5-d563-08deb0d518a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: eLBad0GaI3HOBuueSVjQtcM/Sw8Nurl0W+lM7aThHaaIX3h8ff1gE7HWytxX5wYqSal8GFudJ/xlg2Fp0C7aUinR5dMmSv/VgwD5pDxgZBRbCy5AlGrMhMwnBrrZyk6ejT6cmsQw3RbO8CPZ+EsczqUkVekmwONpETphw9s9VMuFv5+PwnvmPV2aAhyMzm4J9iNfUevUXZtZjQMKkWfr7W8i19OCS4Xe3eoYyYJ/dT/gB6x/k0yDGNcBByzzRu+AysRfZaKQDW7iRPpXqCqR4P8YOvwE/3wGu2g1ZFDiVkRfOGXze8JyPrjBtgpTdr3vIcLUMdP2f4Ul3WKBKM7DidAZoecxKaP+ogl2AHmYkDtyWkxuxbiTDGxUxgcZzzETk5aDwGUN9LEGZ0/wWcXDWZRSUA7kAsK19NtSxFDtyxV+hjRNUvkF/ErKNDl6E+nkO8Q87HAiUiWaZmNktObDlseau1o6LEsJUORx/0nKZBhczJzu6ebC1jEeQof7qv4EzgZFwQrk2tL3Zz3jU2mFZwbRT84m+zLkvVQHVyvpK6S5W7yu2r8BCS8qn5FJCi8mtxrHQyPTSDNf88eaZes70Fadlr3beM2Tr5DM1WwZtn1tFVHJyYEacTpUjqX/IN9Y382TJ/zT0lWPpF/vLpejk5IYM9uJ9ZbLeA6VDjf1GyRgKJHlMmVTRiSd4E0lW83M
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oOZINlvxZCoWubMVgQH8d6YsPGL6Py/m/PWKzJqVW8TksFsImiIgo2ouQem0?=
 =?us-ascii?Q?BRXqWMCjur3jUb5aEXueovf5ywtyfA32c8r3CK+4g3hoTtKbUTM6Je+RNe8U?=
 =?us-ascii?Q?Sye5ln4xwbR/S7aSP629/1OturpRQC7iHVqJvOhp5QcavxtuA801LCHP9+VF?=
 =?us-ascii?Q?7rgiyxmts84y6Cyvx9jtLKtSjuoCv1stADPt8L+EZns/cnO1mn180EwZelqD?=
 =?us-ascii?Q?OKZkHcdO1K7lQ9NH38ghs94FgF0mroNKc9Q1sk/OC4bpGkEHS8eA2f90bgDU?=
 =?us-ascii?Q?L4J3sfxaPfxDZCBJNmVoVmRutlrelrKTPGW811cm/nULt8UowgvpveA3MUCl?=
 =?us-ascii?Q?MJNDiyN1QQWYSQC6XTWCywX1uPFys4KIVWZH4QuCOyUrHci0V3NtaWPT3vAT?=
 =?us-ascii?Q?D3+ZdD6Rxb7lqcFgpkySQBQijFUNSYYOGSqh1J063i0rSxT+knxq1RWb2zgJ?=
 =?us-ascii?Q?WlysubIOTyIKrSGKoyCO1HU+SRsUuxSNKwIp3T5En7p/wum3e6D8U2sjT1oc?=
 =?us-ascii?Q?xwBJv9NU4V0HK7u3EEXlkOSOSoWsHB696cuTGoEt+NB/oVG1KKDkYPhMlcPY?=
 =?us-ascii?Q?otI39JMEPnkbbRw0NmhTJUI8jm+9Qrh0EHNmJ8IMggqQYzN9WtfFlr+k2oEo?=
 =?us-ascii?Q?ilRLy4TeZvSN5D4aGikxWKLZPKlphNCzpeJMo6RbASnqAX7TCJAcXWcqZdlC?=
 =?us-ascii?Q?O20zHmTUhSJhVQDPovKawM2FC2FVL6wpEQ5WTGlEFZ4wyas5rgWpToz4vtAn?=
 =?us-ascii?Q?4RLQrIl01o8jzbi98ycr7fiK6pEMI7egEHRuJ9i3XiRKnYE/AM/bwCU4/CmC?=
 =?us-ascii?Q?ePT86sQXE1K7QS6eCLaFw8ke2UIk+RbQWgHJzBVI8YiAJNzMPSNqYWjpn0Md?=
 =?us-ascii?Q?CmH5xEmPhh3H2WeiEARCXTX4mC5Xvdf6JkPmfs+9pWRz1Ony0dYhUtqu3e36?=
 =?us-ascii?Q?Hc/BjqU3WrMQxzhC9lSxcOJ72snCsLm1XYuYcn9gGeElRgSpuKex4fkvIdYx?=
 =?us-ascii?Q?1Q0sA7F7UQ0y/k17wg7hdcGERk3XqCSRCO8QRzsbCCEulLQhFkPdpP+5XgLL?=
 =?us-ascii?Q?d8axNFq8FMs6dNNtKQhtpiBRz0sUd4dk6rqkQzPh5q8IVrVIEQN2l9k97K7+?=
 =?us-ascii?Q?dEa4gzGDKnGYt1eF6ZcAoUjSglLNoHQgxVGKj4FyVZh/RgqZkkGrRIN0+0vB?=
 =?us-ascii?Q?ULpFBEJ/WGnnE9mSbR0nZ1WGjlGA79jGtgIOV4RE/VrP3hlnknUDaVDrnGn3?=
 =?us-ascii?Q?X4LK9Q+7rTJBnHrogQ1i5uriRnr6FbIJcQ/EYK8ti3N/MCyxlPUkg2vXxsAz?=
 =?us-ascii?Q?BKmNOBkZ012pufGlTP3bvHSHHU35EWq28s7HLXWbUDf7vC2sN/e75Jp7WlmR?=
 =?us-ascii?Q?QT3ZFQMwaaIiNVxK73TYD/E/8TWpyoe+AKyyNqyLHQwdCXpbvv/NC92DTvxh?=
 =?us-ascii?Q?cTNkDbr1VnWzx4oa7ZsFaa87Vthci+C+/9evsPNXMQ+LA0+z0YLUKP4khNw2?=
 =?us-ascii?Q?vyZ/8OSiskcW159LNQ274Oqk4fURTeO+yUB5ouHFZl1V2flkXFS1YwrdysTl?=
 =?us-ascii?Q?TVYGF2l4/XiSj6rIdlvZrKufIs/IWKACNpw24m/f9eN4R0QetyN13BL21K7O?=
 =?us-ascii?Q?6KVjrgAk8Y8+zIF+jUJHgZWwvTXw/Hbe/QiUn+x86v4qqb57ly+FR5x4KFfh?=
 =?us-ascii?Q?z9IYI8eCMRP1dueqXaE+PT4s9NYWwioRO2QL/Aptwcj1lGCQSbeakebVTiuq?=
 =?us-ascii?Q?9bQ9dJXMWA=3D=3D?=
X-Exchange-RoutingPolicyChecked: Jy8i1aWJPBMNlDmgPmF10OxVLDNeszC18UEq7VGPRIBENKOY6OBjq/+SzFH8Nu3uKCvIxRMy/rlKu+clFAz21KT+y4sRWZWReFW85off/55GAnrPJfEj++xh6kUkCzXIoqkTYWh+J2CKp5AEGa0ZFSmnDbzQakjKvKaoW6H+d7edH4PlqlzHHm4UrSq8EWeM3XAzqBYWlADuT+AV2CJ2DQ8jqv97CiUSUAD79Pby8lmtGPeuKuCl6/AoOlUfgSSJcVJut1jNH4f2gmZtfji9iZd0vSATcfHglMq6/IMdx55q7NTMFA/UeJq354hinBhXKZViNwb4alolmUIdBPgPlQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ockO/P0gWTcfjEiEw3CHCYFbrt1kw0slgwyycBYg5Kv4/7r9rOODfcpteos3uTtU4xVOBSkPrAWmPkVfVzG1yDfDfLdlJ77Ru/bDmpLyV4DKlpXpPQ69wmuJe0L2YPDkVAMpE2Y9F0h7DBZ38KoLMWdOf0JHuGxlvzezbpiHGrD12VO7lupOtU1lOCMQhYSl8aVTYqjRVRNrSoMM0NnM4DpDYu2PJcXHHpOeigJlNsX1ET/YyQ563VZaCJcPKZur78+Z9jVN25nRXitzJQ7GMLNy0z5BJnhkYFiM5P6F2rGGnWTOjrUiFQNf/5VsveXU8T/zGfaplqr0igvovfLj852FiTlruStiUXS35yBXatukY6kd+Dj0RnqQK2hz+nKvzEnJYeTzHTdDIFDqoPh3gDL/NLNgPZls17Q58CGlD6FCP1Zl1zZq8/JPaj8OedVjBZIUvT/9s16Q/0oBwZ0Y476CQbnsiQIfE2a/g2Vvv6JeltyQrTKdiFsNQyHrdxU6cvQYvTwqT/+byJLRyvpv5Mep7Lxgwm2JKn4d48NbVTfsSYCQrB3aMy0H62k8KnCdsmN6E8H4xLhKtUcZM7r1waAg3fd795xVlwSiBihQZLI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c50879-165e-45b5-d563-08deb0d518a6
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:50:42.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rv9iDIO4R7Cisr12rO0965BGjVFfGaMGcdpH5iQ5N5xOcHVQnoqu90DSsVKAwF52Lujc7CWJBiRBEQXOqj47BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6887
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2605050000 definitions=main-2605130102
X-Proofpoint-GUID: Q9m6JyxYlrBC4_gdoFjqPOx1aD3QZeyH
X-Authority-Analysis: v=2.4 cv=V+VNF+ni c=1 sm=1 tr=0 ts=6a044977 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=NhPVtghqFocsAXD71dYA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12299
X-Proofpoint-ORIG-GUID: Q9m6JyxYlrBC4_gdoFjqPOx1aD3QZeyH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEwMSBTYWx0ZWRfX0NQOjj93ahbz
 ReCt5MS205+da+qEO1FbJwU+ici/YXqyGj7a4TJK81BzrOyKM+5ts6CqbKHMkOGjDsPdrh6vpe0
 TC/+prl31CVvOQEpldJIb9c8Sjuee7bzmrXu2JsFD+mAH6N5iti7ZWNg37a5ihbCITm0mIPj1a1
 mNXWd2dIOJr/K2mzW1JQ/cwWOTzYJ2LYhGeXPSHZEmfnBm8L6vNayGptOvMlzLVYSjzLEac1HEU
 Xey7nT6p3e138euqOnHiWxE8sfcFByUvL14QCEIX4Y7CgQxgjR2sJZxBJX+X7CATqpsL05ANxpZ
 nS9ps5YbwqX5cKLfqHS8iPXXfv5gt5ungWkRU0AVzE7lYx+fk86qbLRA/sXDn6mrGP0ZPUfw/SC
 ipsUPODfCLbLrCk8Si2ppKE6rse3ieJmaoa7Luvr8XAQvMdlg6+MSuiJoEk5XWhyF0ru5aUsflY
 dL9LMQOWOOlmYpDeASalnBD4kYbY7LbIlIE5xlUg=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_105103_264551_16AED6D6 
X-CRM114-Status: UNSURE (   8.56  )
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

Use DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE instead of
DEFINE_SYSFS_GROUP_VISIBLE, which means that we can drop
multipath_sysfs_attr_visible().

Incidentally, multipath_sysfs_attr_visible() should have returned a
umode_t.

This idea was suggested by Ben Marzinski elsewhere.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index e59758616f277..52fca90c97d33 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -335,14 +335,7 @@ static bool multipath_sysfs_group_visible(struct kobject *kobj)
 
 	return nvme_disk_is_ns_head(dev_to_disk(dev));
 }
-
-static bool multipath_sysfs_attr_visible(struct kobject *kobj,
-		struct attribute *attr, int n)
-{
-	return false;
-}
-
-DEFINE_SYSFS_GROUP_VISIBLE(multipath_sysfs)
+DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(multipath_sysfs)
 
 const struct attribute_group nvme_ns_mpath_attr_group = {
 	.name           = "multipath",
-- 
2.43.5



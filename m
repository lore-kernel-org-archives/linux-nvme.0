Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F43C43458
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2026 10:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SEuZ/0sdeHgUSmfJ35WBtDMfAFpz+pQY8Loe3N35MJE=; b=lNdKWlcf6GbYH/3XoT7UxGtyEa
	vvWAlE2PdufndqXz6ZN2TUOD2lpxewy+PCdIHgSlnvQmGQJMlXa4TRTQM0ZgWOiSq1YHXV9oqh5bP
	EJVmweQbYzqmMKYUqSy3ZhIBn7D2+/oCgAAedZbBXSMlpKiyOCkhC3YBNMrunN5TM8bokw879oyxU
	NDu/ZeFW/0fdcs0emz3akYnZPeybRbCljevYdXPnXA60209F0siCHX4vWprWJ5Px09MSLXN5o0g5F
	V0j3dAdgTXDz5UcDuBh+XQIk/2Q6DOynIhPN2ntoH31mu7M3JObPTV3wujA9tNqeAjwLuHDrKVGTy
	xe3yMoHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weVh1-0000000GdkC-10yi;
	Tue, 30 Jun 2026 10:27:51 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weVgx-0000000Gdjd-2xEb
	for linux-nvme@lists.infradead.org;
	Tue, 30 Jun 2026 10:27:50 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U0029p2185648;
	Tue, 30 Jun 2026 10:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=SEuZ/0sdeHgUSmfJ
	35WBtDMfAFpz+pQY8Loe3N35MJE=; b=hBCHE9sEJFuk4HMNsz2vaV8/O55vgvbt
	wdfSYefcFsY0CjMd+99Sv6afpWp7//j59u314ptB281O/vN/4TAOTRvD6guXnFBF
	wiakfNIWFFxYoCFANHCZ/l15dl6harOvO37sAWZ8loS5+0PVY4d9sa94+iCdc2U/
	UQ9u2uCgcWbcf7SA0lOoeGgL2lKTEi6HmXDLV6SRHsJdy5PATWNahiM6oxExJGKB
	Iipe/7fkriF4d443zatpfUi8kCCicJoBL1UvxnQ4j6BlTK5QAI/IIh6tJW+aTu8/
	7XhJOhdL2uXpwN1LWi6gwSYB+reIjFF7wQKQHAKZo2BlH2MzBHhiKA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4f26mk3s0v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:27:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 65UANAIq028177;
	Tue, 30 Jun 2026 10:27:27 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011051.outbound.protection.outlook.com [52.101.52.51])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4f24ydyq2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 10:27:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=li2Nil64Y6I+mkvwbqKFSdaIPHmSnnwRO+OVl+J4gLquXSKcbcM6V1n72pU4xS4dHB5lpoto7wSB08pO32IGKNQld4nm1jPQMzZW6YiI/N3+cPmZF1KGnKItzzUnj0vaxiJ6ZicHgdO4K8X5vzmnaiTRJs29vDwh3Qe8ubKa9LKZJC5jWF+sV/287wgE1B4I6gvX+4U+EjJ8jVCjQ/VY1WuZ3V+Ayeq7pwm07KJvcUTBBzbddJk9JqdMCjWvFcjpKz5zhhI1Z9DroC0REUn4vcFypNTTnNcJJp1JNAyw4DM8ZdSLjL295Rp/BzMTbkv6gvGExpKJCjUfe/s/Sw1zuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEuZ/0sdeHgUSmfJ35WBtDMfAFpz+pQY8Loe3N35MJE=;
 b=hbFNpEgVBbSZrS7VuDPEXn1m5B0ttr8kvlMyE5Ddo8pkFncyYBAnxTcfB3ZatD4UbruFeNOdbuyUOsR5bMC28DnGykkQya+Ezv0o/fh2Ytne2zDe27LUHXaJfTH4iPoxf19SpHpdWE3C9cGstmOz9AiuSExj7e8cl+6hs+1P5fIbBQzN4jufuKenTm73/E+VsI4LBaZzisoeyCIL/cBZVGtrvllBJIuFDj4PVWJq8QxcWjHqdoEl0gncY7fZFlnBJJXeSePNi8eHpTEGETUNN3q440IkW1fNwcoJJ+KeJjZjtgLRJVMrwaieXw1ZsNmzXO9AE4yWbrvlix7W8HEV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEuZ/0sdeHgUSmfJ35WBtDMfAFpz+pQY8Loe3N35MJE=;
 b=jQIY8sFGD0wpqVkQiXtDnVmrCfZ2cR3RLM7/3Lp4QcSK/pk4eqVcV6r9YI8WVUyReKnFotNS19g5jjD2beN5md4UnelocOrk9oiaLbYpDVa9Oupf795NR9tG+YG0O2Dnr7mzj6aZGciaqqg6bzhp0I7Gu1e9SZyNMOWzkqVln8U=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 DSWPR10MB997826.namprd10.prod.outlook.com (2603:10b6:8:36e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.19; Tue, 30 Jun 2026 10:27:24 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 10:27:24 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] nvme: handle positive error codes in nuse_show()
Date: Tue, 30 Jun 2026 10:27:17 +0000
Message-ID: <20260630102717.2671475-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DSZP220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::7)
 To DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|DSWPR10MB997826:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f3b4eb-66ee-4dee-e992-08ded6922d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: yLNhOXiPnt3/F3q/0XMvG7ouhjHvUQo7Q+E99ARDYyVlIdk98kB2HLwCQm8TdjAsEqK1T+Znt7zxhFeBxPZAXairdnDr+XuAsekmZBUl/nDWYoACjeesc56cEnWogV+6Y1/hBcTcVg7Rguo1ve2HlyQ35kOpgLDHFqdT89WVqIiph+KgSOLBwNClJk7S4Hi1MFfkMgHKMSGbywnGWeAIU4VPytfSshWS5RyKBRRFtESQNRQdTaJcyItMumhvw2gvlRWGJv9yjaUdjxQx4Gj2K42u2iEiYNR+I9TgRxd7qhsuquM+6LlF+/i/rj/TetR+L9oaRNr3g0Hg4i3Ef5ykJOg0oYQ6uvn9VTTDmo/ANbwyCqUsGS8TRsRU3OC6L9668VYlH9EPLkHBaiYSQXLzUaP4LmkYLfild8d5JKAGs3Ca2R050CMLzGsxBzEj3XnluC6My7iNgV/z+qwTnmD+uEF7UI6iMAAoyCrvQgTKpIMIzmfJLJ6AsBQtR8/UljmkS6rBtqU+EJXiIssVFQv/LsqlSnf3KVI5dK+Te3elt39SM1aKbc5FTUEOcFIfAoyIZBpzpChJROUIyHB32mJLUClr0LNieTb++iEiezI6p8RWxUiYwiSo2JPH6MRLQqCWiq8x0JWMvi225trc4VCB6tm9FuMZAPCdEnS3ggjexwA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1rmP25B/co4/cBGGVupaSNBMbm8EqQhzC+9HtFkugv7ZkauuN7wVHvb4UeCa?=
 =?us-ascii?Q?X9zSWXKk66Dx6yU1Cw3kccXM6AZx6i1rBKpauYFUTCP2toymFsd02zuem4HS?=
 =?us-ascii?Q?+sq/31yHU/ByZfPu5t1y0AFSomSFiFWe6Kpz1IAvL/+7Go/2gEpWNqZGw5B6?=
 =?us-ascii?Q?VPkFoyK4oVqKrL9gGbVx/CGF2b0Ye9GzC86kCDtLezpPo8mRxvT6tdSIoA/A?=
 =?us-ascii?Q?uImOJpFCaqj7TA4fApLhq3KukuR3woSwVySrjhHUdY5KnKXfeQY9wk6wcH3i?=
 =?us-ascii?Q?2sk+0xBYO7SStk+pYh2+kAF62xj3LKad7B1TXQ1LNQP33dE0XruAL9ZpmSum?=
 =?us-ascii?Q?VomdPBt3p/AKU33747PTs1a4ejcbazg2P6vQX84H9RcG88Bxp91qnozp2zYJ?=
 =?us-ascii?Q?kz7PfZ6xBSlY6OO+NulsAcn+aS1wxL5vPBa8/tE6Wn76gzieGm4JAkWN1+m3?=
 =?us-ascii?Q?oTPk6lQbulGZupPz7Fixam4u4ZMAbvUXKlQZm0CfLNdYcQE4wtAD6ymtMsYE?=
 =?us-ascii?Q?3h5ymvMesLIKcytSmXwthqV06ZLgHk5si3gpdJL+dkgLZXsEfxTqrB8d2J6i?=
 =?us-ascii?Q?QXNtISrMbwhvZOINL2nIWNTjzTf32FvyBJLwsOYzkxusEyBP6p7R9zRAgHCR?=
 =?us-ascii?Q?lqt6ecmYb3ImvAa1Rc27DtMsR7m7WdgF1fg5LjpKQGTFWx91pKsvY/1rAgef?=
 =?us-ascii?Q?XjsaYnd3xuKz510Bn5Uw+qL0M1GooH+Zcc8GvqN6kIgeps/10rY41RgeXi6n?=
 =?us-ascii?Q?2hj1NwCg+WjB94wVVNcNkQIky/olKwhpq8A2ciWn2VI8h8P4yNwd5TyUf0TB?=
 =?us-ascii?Q?d84dgDX+qGoC7L7Xu/IsG+Ql4MRROGrwsyLQvE0KahblBxkQezoyHggJlI/A?=
 =?us-ascii?Q?sKkmG/tX1ayj7FBdaJeqIKmHIJ1ZoQOgzYZN85QS82NDYiL8TO+g2xqqMw1m?=
 =?us-ascii?Q?z/7e1jqVuL68ZOQlIfnbCTRBxqIVZitdmKC0LnaV7vj0aHW1/hKIqXLB6RX+?=
 =?us-ascii?Q?ApR9CxKCB1ThmQ0TTL2JxJ5i2iBEX+pc9u0s3hfbHMWBmkpUBcYrFHQMo3vG?=
 =?us-ascii?Q?pYaxLybdZ8IYrvgScYKCWMiWJvQFaCRsGdynMyL5eMHkgDTBE5re5L4FVvKm?=
 =?us-ascii?Q?Epszy7KuKNW7FjxeUEVfon5SylLXCdI1tn4Xa5Er8fFn6/dDNBEorRdhl+gW?=
 =?us-ascii?Q?fnzcvAvPAZcJ1U6wgGzMmj3vOut8GEuD+9tbWNS2uCdCh08bB2Vrh2FvnDRg?=
 =?us-ascii?Q?80NxmiqAWyqXDUlE/BCFlfsDtJh0GPbzd2JQeUK5SFcUdEm8+Imm4OE22NnM?=
 =?us-ascii?Q?E3YGZ2h5M2SSC9HJUvbxbNghi3vVkTK6oeczxX6/199Bbf0jhMHfbjY01A97?=
 =?us-ascii?Q?XkZ2nseklGe/NoDZljDQ+9BLEllAuh/2Q081cLpNnEE7t//pi1UDiTHfEKR+?=
 =?us-ascii?Q?A8jnGWb/3Sv2Bh+z6HGWQjgAPh0fFTKbwwSDb6z1+jPu6oeWuakw25/dUbvB?=
 =?us-ascii?Q?WLpkbkwH6o6cqCHI73Cb85cPdNNhHgdZ2C1qKNT+snXfy5s0J8auFMQlRc2T?=
 =?us-ascii?Q?TJYnhgrrLoRcDUGhRJsw22dZyPiIr0smF65ES8U5CoIaQv7okZU8JqBZQn23?=
 =?us-ascii?Q?K0aBFYCbLiOnj1r1qxWgErswgfcyl47oGw5mxzZTaYMCEv9cP68Gc8Uxi28o?=
 =?us-ascii?Q?78O2E/izvHgDnnZdPf9qs25OvkdqWU6aLl/omG61BHk4Q0YIv71/OVUXNje7?=
 =?us-ascii?Q?TrsAIe6dTQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: DjHJczVkhKeRmM5rjq0N1eLi7p1WjvzoeJUYOtbm7eBNm9no99y1/vCUCiJ6QK/map65ri2IGpSTnbwLjZMKl1tDg3U/Pt44TFxHNaimDeV4nbxZRrAeGwoDKxIgayP6JEunh+n5mubDiVPZw4dfj2nUwdrbIrMrf/5xvu9PANTHWWFsfUmceQxk2RWIMyMWb54DD9iqbETGYuz6Unq050hkww6SwLg4f3DDjDTJp5m4sU5qGC7PWlXMRBrYZTk0AL9fW2xVHS1SRmnAeExwzzJb/b35ukcK8OcH2WC8R9vOuatTbMKl0xh32aCcQGx8XdT2agZrtRHQsC66KPwJqQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6v4Hq/uyC/IK53P52hhlfVBt9xC/pECPk0/t1ufcL44K/3OL2jL6D3zWBeZHJM55SIPRiXs4vQC/FsOPAEiuztnu8Ime7CBuQ+s3e4mO+/2vmjThv2Zh7AA8K7ET2jKBaiLfQbeGYMPacP9b7LDSL7CrqYSeBsmC7sqlfaAggw0xDVJA929IHwlQxo0MNY3VWGAMICASKE4ZzAOEzOa4MjW0yg57/PaZDso2C08EjOGWBKsI/A6k6fIr730PMIixzy13GDrHDM9omXGdEqIVN2QXwztJXYWHpY6ObNCkolu65C6PDFWgagEEIOkJipb5NLcwgKavttIummu3WtiAjLvwahZX/GGZwp34EMvW0ZcSFksDEWA5F/0LQfC9/bXmJOrmDNVtGUiRWbiZcGxTiG/RRIF5FxHeeQsSqOW7IQGUkW+vBmiVNvvYuE6rqfC5c9w8ssjOrr2iSXt798SnGNBH8Du6XZhvtIY8esA9CgIxKEsd05u8zez3e8eK3xI9sXCiUQOxFauWPb5Iq0NWKC3ZI6yRhaoL4JFChvMOpmatmL2E5g0JYfbsjE8YFXWhoWSYCd7Nr1cx8juBLUeK0RpZLlr2JOMtUdZiO4vJmGw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f3b4eb-66ee-4dee-e992-08ded6922d2c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 10:27:24.6020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wh+RvWLl1MAWtPblCdI/03qo1ibl3Vmf7GKuovmt6mjBDBdBo3RzPYE/KTEUPgbH6eGYd425IwQQoHoM77mUvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR10MB997826
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2606160000 definitions=main-2606300094
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA5NCBTYWx0ZWRfX7TRoThQH02nR
 gxZnDKm7eRN8B0NKa+Cv/niKDlZglK45codfcPgR+xzfqW1pUr60bNytmh386Env6MpmRdZK6zH
 mtXRZtROpy1LST5qjKPnmDguS2MzFOw4Fih4amPh4LxPd9Pox0Nm
X-Proofpoint-GUID: 6y2RbnlrgHu5dYB3LdZ63F088PDH-2jS
X-Authority-Analysis: v=2.4 cv=OKwXGyaB c=1 sm=1 tr=0 ts=6a439a10 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x0eKOSpe3m1H3M0S9YoZ:22 a=yPCof4ZbAAAA:8 a=MmU2RSUZSbiF0nPFM6oA:9
X-Proofpoint-ORIG-GUID: 6y2RbnlrgHu5dYB3LdZ63F088PDH-2jS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA5NCBTYWx0ZWRfX5TEeyBH5qIMk
 4j8bbbg02UhkK5AnT8G+8EHh+01IgACUPn3LljAdISEzW39eCYsAasHlrizdBoCTDG9kyqmJaiN
 tNeqU3awovlMfdDS1iLpkN5DVvehYwxSxTs80l54b48535vo7D2HulhQfQTxx8lWXzIePkJmbKo
 MehEA1onxl5uiSO9rm+oLQ6KORhT2IF0FP4i7dZW3QoY2/IokWAweHxKU+NccdujOkkzA8dHUSM
 pe3F6xuC/BvMB5yxyjf7g+0PBIaw0J0f4IJp1nWNxIiQ8JuWeqyyYxgmr9c14ll3qHIyuxrOI1K
 9dbcLZJzB9OXSJtrrMfBjkCGd8gRdlwos3/UxSPOFED7j6bsCccMSHHYhuS3gEfm1Q2Nux3bFjQ
 UpnykZ7QY+0522jTfSpj4GzjkpDbUelG2cUe0pXjnMluCnfasHsvqzOsOZCRShsVV173HCJ0m5Y
 qzRWwxixyVp1rYfz+Ww==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260630_032747_760671_5D9BC904 
X-CRM114-Status: GOOD (  14.13  )
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

Function __nvme_submit_sync_cmd() returns a positive error code for NVMe
errors. Otherwise, we get 0 for success or a negative error code for a
kernel error.

In nuse_show() -> ns_{head}_update_nuse() -> nvme_identify_ns() ->
nvme_submit_sync_cmd() -> __nvme_submit_sync_cmd(), we then may get a
positive error code returned.

Function nuse_show() - being a device attr handler - should return the
number of bytes written to the buffer or a negative error code.

Convert any positive NVMe error code to -EIO.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
We could also print the string from nvme_get_error_status_str(), but I
don't think that's a good idea.

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 75b2d69b59578..abf8edaae371b 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -240,8 +240,10 @@ static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
 		ret = ns_head_update_nuse(head);
 	else
 		ret = ns_update_nuse(disk->private_data);
-	if (ret)
+	if (ret < 0)
 		return ret;
+	else if (ret > 0)
+		return -EIO;
 
 	return sysfs_emit(buf, "%llu\n", head->nuse);
 }
-- 
2.43.7



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DF5FD7F8E
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 10:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=I7BdP8sX8goHK8gs/PPGuZlH2MzjURBDe/3RZW5bOJk=; b=sffJ5aPkCfPVXu/UajBk28ghw4
	Kgfv0uhpn2EovGRirVdAfu1lIgRBGhKFykrC43zBMs4n25MSHVOIxh6GXOCEmUCi1YmSPbMAieUjL
	2qB7EioQ02V5ywVrIR/k89QrEvfcYo15tPGpGQyMaO5m33rUp0EmoW+NOy/vOkr8VZmYvGb++dCFS
	S0ANCDYmhh4mwEsfFM5I9UVQ3xaBSW9J9vHBOEJ2wuUpWtq62REu4Ixe0O/fRhQIjvEXk92171ITf
	kgTmRaDFeWlta6RkjPEo4ZhmG/C+IQxm9y5Hno0QgaoE/mZwJ9GZEQTOiWnydZVf5tZtHTz+sjySM
	GyKhnwcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvv0n-00000008EUP-1ywZ;
	Fri, 27 Feb 2026 10:23:57 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvv0j-00000008ETt-3d05
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 10:23:56 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61R9uweI3204851;
	Fri, 27 Feb 2026 10:23:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=I7BdP8sX8goHK8gs
	/PPGuZlH2MzjURBDe/3RZW5bOJk=; b=J76tOAvIvzeAbpZIGtLpevTB9fcoHVPx
	MrSedZQ5TjrOzmo6g4fRwguDpPI4yGkR3omE19fGv23T060K3J9P0lvMo+M33hOX
	7qeZnBL9xQuELoQl/gSW1RTVFBKJ8sl02Iq5cQmZGtVrbH+bqbT9FxFV1rhSw3EJ
	E188OAuHxgssKC65PNObXqMNXdQQlwZ0fPELN/NF0LAhjGlKRbxppjLU7nTQ4/Zy
	PXbVd6rH8UFt2yG6gzzZAYMmjDqjFexFGcnKal2Af7W/Lu7AENDtVjjKsN7fZkyd
	cJ/YeqodGLqdXguwpT5AQuTCroBp9eGRbhvNoL+L5bxze/QVHejszg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cjgppa7tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:23:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61R9u6XG015542;
	Fri, 27 Feb 2026 10:23:44 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35dvmhg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Feb 2026 10:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=je+ebIJ8lmCQzGhv5GLWVlR160EpxciT1XItJ5VGAnfrYzdXWPtSq7bwHmhenYe/04j/XURdS81Y0VvU4EM5KrDBqdtQN+KNpccGXD4b5WcnL9zvVzI4iHImXBTqL4oxvz65eVVNM50k4Su1rTQCKeott0k91r+MCYtBUjgtU3SBswq5VtHcyq8EAQa2ZEQ8R5gC9n7ZQZWWV2UmX36JhKBpHWCROHkoesPJUSJVarQkyI7bL4CYwXgyKLB1dI5PbovMADCEmoaz+VjPckaOKznTcKiMk2+mjOvievIMnit+981edMlSoxqXCVN9LMXhTQkeSOXyiT494JbLyKRyEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7BdP8sX8goHK8gs/PPGuZlH2MzjURBDe/3RZW5bOJk=;
 b=dp4XBe6IOWQ0pT+t/4lr27n4xAHDObx2HU0XeshlfrfyHMBFPuA8T/EY/J5Hk+xK/JWVldcvLKtHU+hSiKtN2HeMO7525zwtuGZvxOsyz3ymnQ9Zf9PUj8AUB1FKCbHUrigBjXaVBAnqCyNMjy1rWBY1P0y6s3zXsmY/mTPNxu8j6vWhyiOOdmdSMz9jQMFKs2VlgXjKCvq4PfGNi23hOvuzwRpQYhAnLIWrnHFJDmZSbo98s68rCSslXTm+V3H6cVW9CEMPK4qBaWn7NqiRmRrrd+T4YjnkRrRFzMkBx+RIp3gB9qNtEb08Cn4VdoV4t1B9g6is1ENJFYTfRWvFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7BdP8sX8goHK8gs/PPGuZlH2MzjURBDe/3RZW5bOJk=;
 b=ttgWlidl3QJ4OfSSEjvCu0ohFl1OfOlDTn36wqfXC3SaNWt1jH1dUSeZakOmueEcGanSVSc6V7HzD2gUXHVkrFCO3iE05/wEbCGeqzMAh7ZuCmPQKgf2wcreCGVn1Xt7LtKW+YZ4jnsxMcVuUT74CUSov0o1mTTG9BI9g6uZQLU=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by IA6PR10MB997656.namprd10.prod.outlook.com
 (2603:10b6:208:5df::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 10:23:42 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%4]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 10:23:42 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, mcgrof@kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH] nvme: update comment about invalid LBA size
Date: Fri, 27 Feb 2026 10:23:32 +0000
Message-ID: <20260227102332.1641359-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P221CA0023.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::11) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|IA6PR10MB997656:EE_
X-MS-Office365-Filtering-Correlation-Id: 76a037ba-ce62-4c57-f32f-08de75ea47d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: FfpIWnmly8Sr7bER+nGvPq5LdhZDWBnp4MSVuOKf7PRL7Ky79fmXrcL2vd3gkpM0SZYpaSt6rCSM2EdJiRC4PC3qIwIs43KJHSaO1usjEB40Mm8cvjqkbxVVwH8IMZ0NPInTuClHXJhCDNJN+mlGGrV9W0djv0gmDUk4Yv0stTu+e3p7mI12xVv4ydCxkeNT24Cdx5ZNvH8BdcJML9kV+0zjSncmHjGVPFPYnXXmzdE/bGz9ZVLqdUPDgEslg8ve7vR9rL++JNjyALw+wdFJuRGE1XiaTabjq4z8E1gxJ4KEXsrVQcxiAzK1yzieIQApKiC4pwo0k5mdP4z/IiWTMJbVPDwbQQv/+l/dQGZnSi3eciBlWeUNMSfwSb9cHI8DlEjE+BP/TgIQO4p9KvUeWdgRVOtoQWSKL46jaX2jdirYQsn0PMQTuWPkYOYGNcrPULuiNwuzZyEKOy6/bTrtrZzid4WKAMInYP+9imrHFcKuPFLfNRY4auynOAD5TjPzUG5Yd1t7t1VKsCy+KsAIa8+U0huR5G8TLqhHTbr0CeH0iNLFY234LGiW/vYn7XsTSOUr5nc2dSaCQ6RhcRCV3zQpgTRji9lF771xp0Zd6TPKFX5SDyBrWfW6jV/jBCBdkCE0EcJHA4ZIby9YuC94KLTaGvIRMzwHj3d0i6deX/RajZZq9C1rPLIzyV5cLqJgm3GTQlSosSiiLYbwfLVF+tlJwdAnvb71HjbiR9pqKqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WAicShWqpxznR/WCsT9QmwQMuVEkEbwkU+jIUzZo3lY0hIN95yiKZ7jjYwBp?=
 =?us-ascii?Q?gqabuYmVI1mdPvx65AxwNcnmPTnamj/FtB0f80mS3tcw6jAimnXDRAzec5ri?=
 =?us-ascii?Q?gC4nbTxEZHOFzZE2vwDAg5JjftYlI1gTSBuVgq5MZwTgKLw0b506/WUtTpUb?=
 =?us-ascii?Q?9lVk9WTnESW3gn6UoxIcaac1cM1JJnrAiL7n3j6vZGAWwu+0Mp3qLFTG67k9?=
 =?us-ascii?Q?f64zw8aW+WJUygMkORLYF2rQOMGzZK4VNu5DC8j0+skkKcSKPUq/b1SdfIat?=
 =?us-ascii?Q?OgygG9JP6Rp9ELkvbdHi40jKPM5SMOGherU0bvIwuLG5wF+xYYbgixRDh9Zp?=
 =?us-ascii?Q?mZPUHBAiYaDKsOubkGFGi2fusF0Ybb0Rm01/DlzxLFsBBvhHP/Vsp7OkjW9+?=
 =?us-ascii?Q?QXz8csQcpu0mzz9/hUzEcguIXYFOPHxE7Aix2Qfl7Nctn2qYSfsahE3SZv4/?=
 =?us-ascii?Q?ENMpmq8Zk/R6r8HdGmkWhS1+qvzB5DBLUOFpxTQV4s1qHPx2qwvy7UICfs7z?=
 =?us-ascii?Q?2jn4yObPCmtpRSQlaMB72A4OsGK5h00L8n+I/LiszUzGe3vy+VXTVL6gazwy?=
 =?us-ascii?Q?2gvNgcreqxI/vLLmWCEZqaT6IiQS0niJzmE22WthzbSonF5pR0VdCFttDfkq?=
 =?us-ascii?Q?AnFnKNPiqBGC/R3jNrjTUvrC+QoJ6rUelYwLpRLTMTkhZ6UOgaiyG1uUn3l6?=
 =?us-ascii?Q?9DnNBgQ/0pXIl3Ovtwyowyh7L/cmDEvMaxGwW7BJyvM1hJXP5HBBO36ABg0j?=
 =?us-ascii?Q?3fjq/idhWxUYzl4gKJ9jR4f0lVxvapmigBUPajJLF7GRCwjBiF3rostxfX/Q?=
 =?us-ascii?Q?y0mIjUbzkzVWvJrpN4EAPar0stWt7Vh4QSS0/XR6LhWX8zYN8PyKMUIOFvNh?=
 =?us-ascii?Q?waseXEsK9Et37E4YfV19D3or9LuMf7P53wy4Ff0NYeOsNsY5Fsu3JY1peqYL?=
 =?us-ascii?Q?c/9TeNt/pIuTAWO7Xo6sDWVcbDpyl9Ys5H9JPOK/2waTZBeoWLuYYMeZ1xSJ?=
 =?us-ascii?Q?ZhjRyc6CHBxszSRfC5jbmKvC5rafRK2+bE142ARnr1YfI+pxoVI7tddcR2cJ?=
 =?us-ascii?Q?YFComxHrO2i0fTGVs5g/EEHBJ5qGqc3eNojNBDvDyyO21qlXBarvbxNkd2oT?=
 =?us-ascii?Q?Meaz6dSO/L9aqzlQfsEb6k2mvQWO+COcRzM6WD5Ca2PlXn/ud9252Y654ixq?=
 =?us-ascii?Q?d9uSkFeTenZiCATStj+WUxZ+lxtlgzxzs4AsLfRhL1HaRA9fLmBGADcM6y1C?=
 =?us-ascii?Q?gfu8+l3pM9R9rOssg+ArOTyddVjq+GRenm2E17i3Xvl18dgXmWRg/yF5ygcg?=
 =?us-ascii?Q?2BI9b18Easj13KMxVa9ZwRL5vhqLb7Yj5UF/8HLQq05P7Ill5hSxaqLQe4PK?=
 =?us-ascii?Q?nyCwhd/Vr+IXdFmF5Yy7QrozFnfMoRJObjUUqL/lH7tAGRdXdqNfzoXsV+9j?=
 =?us-ascii?Q?ypTanr9SY7W70wJpahfZjswcT6XfT29uLjPgYW8xVE3NKJi2RxlY9nqxgI5y?=
 =?us-ascii?Q?S2kUiN449Jmh8PjrzX9xQGXE2HlJI/KFAuBETo2ZBwsH2DLTv1BRiGM4uFhe?=
 =?us-ascii?Q?Dl42fbcFVcqJkrr9uduYjhJWa0qw8VSK+Ezg1FlAHIIq+8bpirwSRrYrggOp?=
 =?us-ascii?Q?K21GbOMzOzCn7jf5C8bq6wd57WW6OnrWGd/KihlAROivFwOwz6Zk6jU90iYB?=
 =?us-ascii?Q?YI0VN2tcAmhN8+Slfedh6OpfRNX7/w1o4HgZYFQReA1cukOai2zxOV9YqdVy?=
 =?us-ascii?Q?EqkemdV8kQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6ALhs5Urq5v91U2O6h9d4eEh2sBZJnrsuLfskgg1n418DEa7J76KZGf/tv0eNyN6P972kY9keoap14KQGKwAh/JDuONIwTwJxx7eHxfPlxFWnVEyiSkUV/arLDMbPFbPXwC+Aq7pAqXZpzuovxnB3gAlMsqIPfnz1jyT1QWKNxSqbiwaQY1cPFYkhTRk2SNOYFoWcUBiAb0WZb66Ox2nKP8h9Rr2JeGdfh67b8oEG8iLghkN0ivGboUijVTbKCAw3aKZn4D+iPESl/tU/QUk7LrmJHozEL1v0RhVxpldMtBHyuHOAFe6JzFgOP2nlsP77urj8l5m11YNLZUQb1U+R46NZyFU1if+z6jeXKQaqlKAU9CZ5zTSImeWl3YhHN1RNLMBGgXKRPmjwED5YsgrArc4cLrPHrp6O2b3BUAW+iXrCxJrqHZAu2bSXAfcy+AfNvVCdmXM5B6Ak1VZBtVeTsfjLQhTEzx9M5/CMgpD8/pkNuTnqjGNaQlsxcJhfyAN3jC0bGDmUzmp4W8Df7SJYzCADvQuM//MD0kkAV3um5YfLeOkzCZNKJnVq+JgyK8Td0CWb/g+b/EkTjHLwLopgpU5uwIQDPrKbc6QJGm7kM4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a037ba-ce62-4c57-f32f-08de75ea47d9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 10:23:42.3392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k7w6im9dzY4PUplGEkxzCpGs6KLdx4JiDETjBrFRtjg1gJbnGcjr49BfLZOHbGTZtxSfLfs75oYVl+5uua3HpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA6PR10MB997656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602270089
X-Authority-Analysis: v=2.4 cv=evPSD4pX c=1 sm=1 tr=0 ts=69a170b1 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=i3BuNnPDlLrfKnx-DYEA:9
X-Proofpoint-GUID: 2Ap8p1t5oEZdPsyDNBtMSU70VyFHoGKf
X-Proofpoint-ORIG-GUID: 2Ap8p1t5oEZdPsyDNBtMSU70VyFHoGKf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA4OSBTYWx0ZWRfX6xPgVhSeDoma
 pQDM4OswuaRiGZ29JcKxvbu7V/9TDUe0T1bg/EjjMNVUBNjGaiaUTs8RLltu+PZTKlu9XxppKeh
 CST/2S3bxXbwrrDO47T77YbLKc/TPMfR6EoUKW9Ka34FYFDZi308w4NlImFs9O9TVI2vfp3a8QL
 OBZtc9maOf63lzkBlWvljs0wiySSy7gK5eek4Ow2iQhK+zd6+tPgVZnNZGN+mjHhG15HiOMKTbQ
 PTl6hMWLggNgOYrlfjufJwGZDrayrjB5MnmDFq61vv/8LiIlkwC79aEJXk2mV7sCZcBf7ku21nO
 E7jaeHEmueiSWPQx5jd6fRA061iCVeW0wgwGQnvtsaHLpfLEstRRIDq5CrJengtG6pe0IHrMLsD
 AE0vZ06HiRDs2nX7AfPcHyGsHod/tdsfVoAx8nGmagxCHRwwRqceLvhW3xO68PJoktBsQ4C9nLe
 gaaRsD5++aYwRp2ReMw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_022354_027056_46C04E76 
X-CRM114-Status: UNSURE (   9.95  )
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

We have supported LBA size > PAGE_SIZE for some time now, so update the
relevant comment in nvme_update_disk_info().

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3a2126584a236..c5ed0536b040a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2085,8 +2085,7 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	bool valid = true;
 
 	/*
-	 * The block layer can't support LBA sizes larger than the page size
-	 * or smaller than a sector size yet, so catch this early and don't
+	 * Catch LBA sizes which the block layer can't support early and don't
 	 * allow block I/O.
 	 */
 	if (blk_validate_block_size(bs)) {
-- 
2.43.5



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCCC7CD6E45
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2026 09:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lHk4sxEvyxZuzTn4Kibq33AOnYgkT4Kz0w9Ao5VCPBI=; b=dO0bffXslPJyx4l9LDcVKz3Znp
	/hDvVU9w6v/r9IBD0LdAzHt0WEGB3FmU3UmRTsBw9bwyKS7NBXQHuDAk97uuSHOe5meUrUrmr4c8a
	bRGJV76n2SVdN0NPUCFV1coNKLN0a6PIlnCurSJR25Ek94+3zVlhn7BKUjx1YOr+tt+E43a0r8AwQ
	ZCu4M82sCxdqom9/orElsHtDGwVzmAB1egPvxYn8CYp2hLtL0lYX9FuP9gPmg+c76b9VoFH5NH6Ge
	lJXs2mVH7LF8BY9dQ9St4IPdlfxRVVArkeE7D5X8AdBTzV+7N6iKuqvxCa95erkLscF5tqG5kFt1z
	43Us3EyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSttN-000000077Kp-2H27;
	Fri, 29 May 2026 09:52:37 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSttJ-000000077Hv-2VSy
	for linux-nvme@lists.infradead.org;
	Fri, 29 May 2026 09:52:35 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64T6ff9R162748;
	Fri, 29 May 2026 09:52:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=lHk4sxEvyxZuzTn4
	Kibq33AOnYgkT4Kz0w9Ao5VCPBI=; b=oYOuTSG3nZNQROU20ReC5SDumw87dv6O
	tye6uFqLLXrwwtKHnNkan8w5SJ+4c3z3wlfHzrxVdrrQF0p5uEMMJTmyJHAe29Ye
	JxiWj2nDYLn/FqLlUJx9gEqQ6iESvU0C+7VnIMUwEDNFFfqQ7M3cd2FdYAOcP0qK
	mq0owDbHJedw8HwAMz5JA5X9AO6P5xxbvOuDMqogPaOaeS34OXwkn6aAKoAqdztI
	TGEbk4E2BlHJDpJszOvTBg4YBaG2F4lGF1OgV9pYkyrJC52756vMxnAivLd1R2Td
	dXuEiDLmnVTBCAv3fyJrxMLWzN6my82/78KkPbIhIid/Gxu18vEktA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ee7wm2d14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 09:52:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 64T9nvi8037070;
	Fri, 29 May 2026 09:52:18 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010056.outbound.protection.outlook.com [40.93.198.56])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4edjs43dka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 09:52:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N12vthAt3WWIUV57D0+N03yNrJJlJVOCiM1yQhX35H+zKN0Z+lK9zV06K3HqOkCuYvA4zmdxMEfat32YX+1F+B6+SReyjUluAJu52zRCDCMAln9oTDJu5kOL/smUlDuZeJz3pefhE9yQSNKQLUw7I8wNb0k1Y5L5r81Sk0XktAYHw5a1UET4bGYCDfxN5VGdTaMIf1p0iPNWb0nCWcMIyz83mCKeLOa6SEvPlG5zG5wclC+YGwiCXYmZ3pSJXmsU7ovy+0QAdasqbqw3EGYCTvtKm54KJlznIInFLb+BJJD5jTWJ2naBZf/nw6i4PZxRlL6WoPJmNLet4ZzyXPqmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHk4sxEvyxZuzTn4Kibq33AOnYgkT4Kz0w9Ao5VCPBI=;
 b=dmMRMpnu/cRYcg9Kuxb8r78mNjyODtVGradjo1o+GvP191QwuHB+CAqaMuPtleUI4wpETcJGd0LLsLIDbDpKwtsI+29a6KyOYp+DKWl2DSTZ61rCLL7EUVvMrXQdN2MHDcakReaMXXarnzum5NkMQAafxUHGZ3nKiMZDsjn0OpkjHw8b2yoiBsZ0q5fzKhD7jeSOftWUvdmzQW3EK8THaybMf8B6hCfhBpxSxC5yZp/q/TBbcNn972FB9Vsl2zqUariaOb3GiP/mtnKtexlXSAsyoA9fwCEH0/2QEYOlnH6cufRRj9Y0HpGOjG8EI1AAPAWdjFKiGV+cf/y5i/6Oiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lHk4sxEvyxZuzTn4Kibq33AOnYgkT4Kz0w9Ao5VCPBI=;
 b=NRylhcYTGwpVOPVK7NW2n+ewMgmeorfWKhXpYR7V0VPu60chYNu7aOiyzYlC6eSzgPiDVlzyN+gEkDyXBS/XpXgzikl++9O4hb8SVlwOmk7rcmbulPL95EgV9bcSWhWBUg1n0h7PESBLULhHkzQXdRlWtWow5+nxY71gybTUPTs=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DS6PR10MB997848.namprd10.prod.outlook.com
 (2603:10b6:8:464::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 09:52:14 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 09:52:14 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] nvme-multipath: pass NS head to nvme_mpath_revalidate_paths()
Date: Fri, 29 May 2026 09:52:01 +0000
Message-ID: <20260529095201.3803100-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DS6PR10MB997848:EE_
X-MS-Office365-Filtering-Correlation-Id: 905efce1-4b89-4bb6-3a47-08debd67f66a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: yHo+/e5Foy6WZLbKy//BSkfxgSlR3npfn/Q6jFwVjMdvofyBMCbMiT56gV2ggtPRqLXkqFuCIh4hWah9In9PQSesZ0FoJOrUMFY0T4j15Ybq/pYjHD7v2T5AoN/hc/+/vcjWxav7Sexcdievn0Hsbe3lBUuqEtBHgcuXogjYjjd/ozEVAqiblbevjxWUHzhaUgBi7mSC+gkmGnl/S0kGTxEM/zadCnllFdUJddDYh8HcHiLD21BSKQsxLcX26i8WB3AKJbTc5tF8VKJZvTpCbi2k0kyLFeLPHCdixCtIM/bxhDHt5SNv2N8Xf32VWWktPO8yN79bxPLKqGOb7WpWqmeas7WmmR5ZEstrRmamTmPW0VHn+upDurbjALaZogj6DreoRIa/Vz9vUW/NWMRX9yJEx85z2rzpBDoqu5iFda7nGpBr4KGrB82Qc6B02lpI3Br+Ir3Mo9er1MDYgf9mQIdg9nHFTqpvmcgzpp9S3aksG1ElO8nh+LIhUFNRLGBGAh/+5vFHuM0rQUkMvFRS04ScFKULGvmLlzIhBWMwlcJmk9Mr23yrdYCaNdkJLRt8/gOhNk3alrjGKIw1alOjoOyXiFATlyDpBRcjM6gyfub9GufTgwHrErwRSZn9wrbg7vGLnsvmn/uRhV6KnKUQAu9tHTCopwWEdrymgLqtYoyoJ5+aPi1Fb147HUj3v+jB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v1j+fa0qEPGqjUGD1h80SAh0XuuDsC5z1tFi+2b+85qZr983fNg6ke4onUSr?=
 =?us-ascii?Q?4x0Z0LWMAxpCgGen0dA2FLVO3mm6vgGK26RIAafppmW0poxVb8RBHztxvG8D?=
 =?us-ascii?Q?dDaw6OqhcBzwmr8Gy2IDxk2aCEJluM9zfqd8dxLWe1bg7lC7VSvtrRvtPzYl?=
 =?us-ascii?Q?aGIh4lhStQOh2L3Tk/A15heXRbAjIDKCDWs0F5B2qdN2Jit1OHhtejTzky/d?=
 =?us-ascii?Q?K1EwOJrLbNnNyYZVVnJUp5eH6Ho0BGEYgIuebyp98IdwzOus/pn8NrfCZ948?=
 =?us-ascii?Q?KqZFVMGbfFQmD1fsiMuGfAAXaI3tltI3sjplWVkOm+5PW8yIOKhS+b2l0/lj?=
 =?us-ascii?Q?x2i6FDTUAbG1CrtfA/V7aBBEYYm/Tzg4/FPfUWZA+yNu5HUrP5SRuyY+gm66?=
 =?us-ascii?Q?c8+LZxZcxqCndUlGGyusaZxKqzlsJPm89vpkKjP+WGGPZj4hmzYyB+0gCt6z?=
 =?us-ascii?Q?WQQXsM8AFpTGFpcKsA3EeWSVCR3nk51DrFFeF9tyPsdvuwR+KMmr0xb4z2lF?=
 =?us-ascii?Q?1TCz8RiTDZd2yjP6HUf9B3aS+MrYymsjKlEofKf4or5a1GLAIwY+Ej+sPY09?=
 =?us-ascii?Q?2OCaHr0eGJMA8D4WqHYc1HQskDDzpgSVdPlgmE+JIxyD1SaTPkT1gS9zETGX?=
 =?us-ascii?Q?A4k6uMbnka1LbI1UxsgmaixKfN+UgIDbn5ZRRdCQzrUp0Nd0ixtmO99g7m0/?=
 =?us-ascii?Q?jScksQUoiMq0CXd0P15QU2ia1PqxJxQlSjUAyFATIy1cI/XibSt0AiX5m+Bp?=
 =?us-ascii?Q?6DHvNf+PHWrHTezGIXhMSGy3mwoqVSIzYN8rg1vVh4KsyLaC5Z/So/5ze9z9?=
 =?us-ascii?Q?OrZrL25b+nR4Bf21VLCJsmWnQKxdmU1twvuB+jg2nlq6flwdb4hNnSR8l1IE?=
 =?us-ascii?Q?W3uLUIPXBTekqF8CLJVGh9Mi7IDbiraLbz1RetJSzxQl84TOdJQ46zycNmOG?=
 =?us-ascii?Q?8ENLCIrpnop0bOUswJRD2KqabQ2tDM7KHqeTCqc1Rxzd9NXeTbmGglW+0chZ?=
 =?us-ascii?Q?RSLhNJmZdv/Ks74YRkIhAmf/+YTVk3wSEec1wmi17mxc88AEKHKluM+L824a?=
 =?us-ascii?Q?BmvwHnKtcxAvRFhFHJ6xYLS1edf++eojjtTgDVr396oHBDcPpa+ukMn1f2nJ?=
 =?us-ascii?Q?EBvMewH5ycKCCb8BSYVa2OkGtjcJOdqt5HzS4j8nU2tXXmqMRaZidny8blp8?=
 =?us-ascii?Q?2/SUrrhQZHaoEBrmEkcHo1N9bUf2AOCqC+Ny2eLvqwzNdeOy1KAT5uqRoe2i?=
 =?us-ascii?Q?CcM2fvDpxgeJM9KINoHz1ySLPtPqfqFiMr/iOLVeVSzMqMa3Mn3Od+J7d59o?=
 =?us-ascii?Q?h8rkd6TC7kx65wrNpO53Myu7vxActaMDmDTGWfsOU6TVB3EMGuXuhzwyrWz3?=
 =?us-ascii?Q?oepPmqDN+9jV5fZOBE9tmtKgHpB3dFDHxG9BZZgYg3W59Y18Rwcg5ZPX5gAl?=
 =?us-ascii?Q?bXVJd8BH3hrbHmwlVoCAoikoGu54I0BbqWAM0QSDrmmdzcVlvGK6+aoiQehg?=
 =?us-ascii?Q?KaVALlM6nJnKF3NxsVxzIJiDFdfIOS61erHGiuBahoEztNYIzl/NLzhH2WER?=
 =?us-ascii?Q?50gYznwU/Pjp7Htm+6lCRLFu3SyKIgmuPQGJyhvLCDrhIk+UmDn2AkRdP6fZ?=
 =?us-ascii?Q?UkgAiaDYOEjNRjg7p2lDR//USfOsOohaBNyDuMSLRLLbs+fYTQuzb5oN/oKr?=
 =?us-ascii?Q?zsrU70w3btb1HADtYqF2OLAGNdbOwhNNkpbuUJtSLJ6orp4JuhYUGp/9aCek?=
 =?us-ascii?Q?B3GDye+ZgcPndjnIj6kTZ0jrlbO8/Ms=3D?=
X-Exchange-RoutingPolicyChecked: dc5NDInQS3b5OJHuyJEizYMx+MLCUVG+gxHAGMImZnYZldLaf6BlTb5GJY82bqNQoPmw28FSKWo2xuYcasDel1NClqyzATKoUwap1/6AGHJg6dUYRmD/KZizZodgWqWhhSOhvN4E+4MLmDOyJiT+Z8kwItVq4mZi0nc/ZKhEyrtMTL5JnBceIKOrlTO0F4Xwq6Bpm2Wx4piAMGZtedV2AGAd6niO2GoRBDVRHCZHccdJQMREaCqWFliBcPbumknHBwN38mjAVB1zOz52HI9eH2eIBOr85Rm6dnVYE0DTwy46X1hZte8zKR25gLpxbOJstPLbMNGFSaQK6ikIAtAiJg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: E1rBcMf/sG8vORLP3zFGR5AnqIuDJJz297lI63g9VvVdoNJfKSiu3YnbiaPqFnwNga2e8cdcmk5AI4BXQBXJWbFK2KXjnoFQvj90djmrHL+CWoGAN69c4wipG2VtBhdDybf690NA+JF5qcllIaqzqE/sDGfWZZlZAdZ4YIlqiWPvzHB1vBElypyZTjX4EHN4zCMyuwY5vua3NHdmqBw3eAnUKK49mNPq3dxsb8h8ExKhWvI/QCJKhtuQ8sIS2baAGUa18xz6syMU0ml9dulwx+mMXRDxwj9wb2nbWDp6OHlqWaZB5bVyQsatWe1PneXmbT7i5zW2xYP8kVs9etNhMF83PIxkyRocmn9dVeNiM/VXilSZxIyXELvWebgpKRqpov4apEnIRrzctdhRbJqNTO0rThooo6+CjbsUsSbKrLu7SQSFBRwEoS6/HqVUb1fnlRqt9LevIduP/mPqmbY+ga9w59Lh/6lQ9n+hfzKQbvA3h2sqDdzarJsl0FxUKuhFp3/7QwOrFcXGeRNjbJvFMpXXhLgA4K98WF4x2rzW0oHY5K+vahaz4S/8/JdEIbp+xe0IeM1d48yT6fIdou8kcF5p5chaX0vMZnK4Q1B0AXE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 905efce1-4b89-4bb6-3a47-08debd67f66a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 09:52:14.8409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeGJnCSQtY56xouxZnYZbbAGHA4FXteOM1QcIQIodZMtgva5w+gLL9RavVziIBCMflKkrRgsxSdtgwbCN3hzgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR10MB997848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxlogscore=691 phishscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 spamscore=0 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2605130000 definitions=main-2605290097
X-Authority-Analysis: v=2.4 cv=d7LFDxjE c=1 sm=1 tr=0 ts=6a1961d3 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=S3jg9RaMFKV7ntMrqLUA:9
X-Proofpoint-ORIG-GUID: kVeWEXwrTZOZwrIgBirW-1jJ5AWFe_mC
X-Proofpoint-GUID: kVeWEXwrTZOZwrIgBirW-1jJ5AWFe_mC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA5NyBTYWx0ZWRfX1x2hII7Ffbj8
 0hCaiSQhwYaKXsc2kHcaL/FWOe/GgpVpDeZRTMxpFQ+6V3uTpSdInFZHnsD0jZtS2BBPxmCzYex
 3qmmMlkc83ccnacIqxVk/N2XAreSQjSFFkSuGQ1ovkUkyYcZi6iqu9j9+FLbBgRUi7kTJ5R3HLx
 Cff1W5U8L8S5MU4SMTqumcba2DVKQWAOzVHb6MaNPS0riVv6SeUclmIV1rWH2kOfCIokWRyqi8i
 xHXHTSlupEZcBy9GyT7L3aCaBPhFkHf7gtMFwYAWSzIDBC9Nq/puM+oGpzq2oCw10kihBp+c3Dp
 yk8OmWNDHlF5WiyJk0Ga4TaRYcyUzC6UXsRKBs1l0uaVSvziu2ah6dLo8Q7Tpxjzm8gBd83mZy+
 ZdlKSX8Bxgb5MYpqiVC3chfE9TaYyAQeEB0ZJGnlXkpA+XpRzIKkO9kxXCAd8ZffTEFfZpG/h/h
 FWPymXHxJUMZ2hQP+yw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260529_025233_870930_97F74A50 
X-CRM114-Status: GOOD (  10.34  )
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

In nvme_mpath_revalidate_paths(), we are passed a NS pointer and use that
to lookup the NS head and then use that same NS pointer as an iter variable.

It makes more sense pass the NS head and use a local variable for the NS
iter.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5d8af8aa472e6..f69e3115d8cf9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2567,7 +2567,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 
 		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
 		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
-		nvme_mpath_revalidate_paths(ns);
+		nvme_mpath_revalidate_paths(ns->head);
 
 		blk_mq_unfreeze_queue(ns->head->disk->queue, memflags);
 	}
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 263161cb8ac06..e00e2842df307 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -254,10 +254,10 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 
-void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
+void nvme_mpath_revalidate_paths(struct nvme_ns_head *head)
 {
-	struct nvme_ns_head *head = ns->head;
 	sector_t capacity = get_capacity(head->disk);
+	struct nvme_ns *ns;
 	int node;
 	int srcu_idx;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9ccaed0b9dbf1..86b09c06b9e0a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1043,7 +1043,7 @@ void nvme_mpath_update(struct nvme_ctrl *ctrl);
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
-void nvme_mpath_revalidate_paths(struct nvme_ns *ns);
+void nvme_mpath_revalidate_paths(struct nvme_ns_head *head);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 void nvme_mpath_start_request(struct request *rq);
@@ -1108,7 +1108,7 @@ static inline bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 	return false;
 }
-static inline void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
+static inline void nvme_mpath_revalidate_paths(struct nvme_ns_head *head)
 {
 }
 static inline void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
-- 
2.43.5



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD0FC54F4D
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 14:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bj2Rqr//alHhVl4E/KbJYLo1txnwHjuMfSQyleccyxc=; b=EUx9U5sGaoZWph7x5OfdRboC+X
	0/X99KGZB3d1w6pVgbpVX4Yi7nhPHeczXM9OhJ7kYaPcRgzidE01G3LmQCm6aNi5VezacBTQ2yX7f
	q3mw96N9LrI7/x640B7qi2kYcWLOl7CTRsFO6d3vxENUxKKs8xMtGrLUd84OB4kUG7DDr3EwDsrn3
	W+3A++TYzY2xdNsiCMc16XiBD9yRcFt1xxig91qrE/aNZkFSkspNdtIDyh1182BBWdJd/DyEE1A2P
	MAGqyed+4Oi+oSTs3CnFGcX23bE0crD0MQu+C8PfwwJohQV67RWZrvFKQLbHF9xY3Yebw7rPVO8jg
	6y22Ezjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woMYQ-000000032K3-0fSs;
	Mon, 27 Jul 2026 14:43:42 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woMYJ-0000000324H-1Kms
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 14:43:38 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RCTK5V2094317;
	Mon, 27 Jul 2026 14:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=bj2Rqr//alHhVl4E/KbJYLo1txnwHjuMfSQyleccyxc=; b=
	dp8uuJCOe807V0nPC5nIhzNPf206xI/yIHdxk++C15sPtz69axxLFLixTh51xNq6
	tzIiJeBK6Bu0Bd+2sLT7EA51IuH0lDr69hImTleZw0fhqZ0HJlULBwfguXnX+n+X
	OyEl7Az7PxgWriaDIWkHfxD2mKDewbw+Om4tNPz+mVApm2ZIyTb2WYDWHdHXn5mh
	GaFXJhR3Ly8Y5KCuJusrZyaa/PGNKpHd8lsm1tugjKs2Qv+eEjmMvFpNNlO/m1MR
	kt/V5cPoJYjI/3dENsvn/jocbJlKGIPOM4HMGCKoE0RtGXnN2ZHYdb1phuI+7kki
	cD6IZqovarCnX4eKhAFeuQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fmr5xsxj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 14:43:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66REeapS021472;
	Mon, 27 Jul 2026 14:43:25 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fnh8gewqn-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jul 2026 14:43:24 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQKadVf4pXnz2sl8UIClesRzFLYVPaJgAnvHrQW6YEfjAex3pkLzNuVtaxFiGKc6ZDfF6F48wN4UIXvRgFMlx1bAdGiDICUXxdZIxb3CDvFodJFL8kqG18h68kqhEhHlUqLgoFHyZANXmqtugzZig0trMTfw4flv37q9+L1MCDV+EohDV/xUSA9WEhyQawOUocWeNO/yIxb7oVhPe+kEQChga6gMoABTndVXjddWmKH+byIts0vCVMqJkijADFzeqOQN3O9UfNuABxHuLCKHuEK0hMVLemV0PMSfK17qiH6JiDLMA2ItHFFcVy3b15mn2+Sy3vBqgjjmFuZbEFIOCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bj2Rqr//alHhVl4E/KbJYLo1txnwHjuMfSQyleccyxc=;
 b=nur3skzZ5g8UE7p5FgQnn60NxHCqHyZynDAYmadaeoLTrrkESNQixYHSGNhey81cZqsxPuJUEluIARLWiO+w9vMf6HIKngt8rRdSyyzzd9fGfr7fvzkm76DQSMWL5Kso98TR6u2lJ8ooFs+BygbJIJF95rH1FyYA/lmTAYWdjaOlbxMTwQF/bsYIHMjpecRQ7qIc7cE79DT/Ex/Ql40UYWjzkEkE8WzPS5LVYzkwlWpKYeQ9igVpWyDAA1ndGGDlHfMoUAnwtVIYkufio+rqgjI/q0hji5loQ/2S1/Sb8fqEUD3SH+guClfbn+t92qOZWOcStZLl9q0Kd+Sr71O6XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bj2Rqr//alHhVl4E/KbJYLo1txnwHjuMfSQyleccyxc=;
 b=Gi6U8wY3DKZKBpRtptjNT667IljunAG9h7LdIlDAnlrJplSRkuejGh2AL40p1wJTd/1fcyOqHDuNh+lyDb8DEuITfVsT816oclYbYAsRJVFa2BV6hkluNmMO8NQjRTn8191l29Ej+oHNzdWIC4NfMGyXJVc/zkZCDF65wyyo0SY=
Received: from DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12) by
 CH0PR10MB5115.namprd10.prod.outlook.com (2603:10b6:610:c4::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.13; Mon, 27 Jul 2026 14:43:20 +0000
Received: from DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d]) by DM4PR10MB6229.namprd10.prod.outlook.com
 ([fe80::867:63e7:13fa:fa7d%6]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 14:43:20 +0000
From: John Garry <john.g.garry@oracle.com>
To: martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
        hare@suse.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, michael.christie@oracle.com,
        snitzer@kernel.org, bmarzins@redhat.com, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org, nilay@linux.ibm.com,
        john.garry@linux.dev, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v5 17/27] scsi-multipath: revalidate paths upon device unblock
Date: Mon, 27 Jul 2026 14:42:24 +0000
Message-ID: <20260727144234.3802948-18-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260727144234.3802948-1-john.g.garry@oracle.com>
References: <20260727144234.3802948-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DSZP220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::7)
 To DM4PR10MB6229.namprd10.prod.outlook.com (2603:10b6:8:8c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB6229:EE_|CH0PR10MB5115:EE_
X-MS-Office365-Filtering-Correlation-Id: fa36054b-dfe7-4440-5d6a-08deebed6725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: y1lbqra6NIOq1fKfG05dRcP5AFWh9+XJJnUCt6wkeOzvlo5rctbYvilxw3chxbTaojfk2Ppn+9g10EjCVQ9IOw2SS1h8hsetcPCF9741Lf+FRus1YPOqLzvIe9fLMYAV5g2Nm8GS+2ai4d2XstbdX7wsNrEtTL38XVk/Xv0DUgIwzAyJD6STA5QUMU63B2/Sjmjf1kaiDsXPKE4Fsgq3+pJTTDnmuCIFdSvPZlc1crXweCntHMU1cYe9bC9qJJTaslEHRtcDiD2jSKcRcxnDjm1elaXsvaaMRwltFA4rKq1mVw/aG5ppoUFBRbr6+uMEBocdj5hQD6Fp0RNRi8ev42OODAAa/WtJxDnXXzQ0dytbUxiGmHoqaRFrVUcC4XfVM5BL1wx+7bPpRSS9cR8TKWaCF3Bo1AtrJpDEQxXQ1GgF2Vnv1ip9RIKXlKX6sGVLf8G+4ZRCgTdTOwEMAbq4+oKSXY9/4js0D3Zq8fvQryCBQwx+Iq368jQ2r442pkkhYCFYrwMvMqb/5ZRorqQqmzS+m1RVw++6ECiFiSWAmrAsHiXG4BK21BwSGrZbDDbsomVUa4fozNcKeJ68UBbnYV49B1DDw3RcJ/Aci/ygRllEN/9gqRQYf3fkUoLuBSMrgGKnVHsAw79pEU7ufJkBAICcXGP71eZ4z2fwZ9dKyVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB6229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MrIc/5zV9ejqs9+I7gq64xwTyMpXfPFznjQZ0JKVvdF2iqevgs3Oxx31G1qn?=
 =?us-ascii?Q?xMWJFyPYylAydK36foDYoYEry1gPZY1lDSBV8qsd0fSnt9mjABSxkExBX8jH?=
 =?us-ascii?Q?cFgYBCYn1qQrEfXpeJzOgiMXuXb4MJbBjewwTZg7PzHnxYrx+rCentB01e13?=
 =?us-ascii?Q?MEeZn9SDnSMQmVut49zVcozV/BBnBkt3A5u7gVRYgK7J2VTl0Rw9egQlsGXF?=
 =?us-ascii?Q?DD5JUxuaRnKgpC6tgZTxGEpDxHyyeTCLL7QNiWmgFXpXQ+v2pHHeWdQBbEG8?=
 =?us-ascii?Q?IVDG0zJSOUk/TFiDHpbItRHPzdjisUqAX9pAtlgJ42r/gM/jgOSGezGLXPsD?=
 =?us-ascii?Q?M1rCUK2w7517YGy7yn8IJGDBW9uJTUKCpY1VX/7OQx5lGR2by2sDkLQVMoR7?=
 =?us-ascii?Q?F/q7jemgS/tLwDNYCsVhv3JCgvUtFlYaKB54Nzoq8Hs7otqbZqoilanmKr8U?=
 =?us-ascii?Q?3wA9Uja/HUx9tNquhXXiTAbMC+I6Q9mW9yT9RLKFJXwOYCuqLOszSm4fQrAf?=
 =?us-ascii?Q?joGDfpDWseUySqBoVKF/rBxXEFavDax/+vxxt0VBXGQJ8mFHlvmTabbzwhMK?=
 =?us-ascii?Q?4pmoT9az9q48kdeWm0MJ0hQZrDTLvHXAxtsB/mHIJ9vZDH1d9OZUfstBb+sZ?=
 =?us-ascii?Q?Doq6PnwGSXEuKwaeYUPp1szVos45zYrVtKdvcz5PSUDbPSZ7JDIygcufQcZV?=
 =?us-ascii?Q?yqZTWd6CMqWZdw6Je9L4VDPSSr3GGx7jJad6r5AOS+Lki+Tc4et/YLe3eUiC?=
 =?us-ascii?Q?bB9NSwK988xqxMZDP9sma6JRHHv71Csg+dtbvW6E0+1lTw/pTlgnO1mT/nHO?=
 =?us-ascii?Q?gWuuFjsto5fjfqAO8Jn0+K68kZf5TRG1D06MNeBsiB9v2kO8AILtaaDn7WaY?=
 =?us-ascii?Q?j0InHqD+PwKvZuwerBqoqijjbdN999bYs4uFvdV5B8V7q27BGozeDY7jLpDk?=
 =?us-ascii?Q?tZhm+CaX8LKVwwozIij20+EYtFutLwdXAex4f/9cu/OIKTaqnwSq8hIeLQcQ?=
 =?us-ascii?Q?3zG9hh7r4mPM0Yf3n6oJkfCLzJoY1xe5bpyEQfAT40qwGXCxwGqf8i2z3s4j?=
 =?us-ascii?Q?vlPWs2N37yHXTeSOMuPFI3zs6ya8ZeKEsx+0QyLUDj4M80oVSEVVeNoluDnd?=
 =?us-ascii?Q?p1vLNEuSVYG9AY/f1yqjN1sH/NFbKKsJuKNS5vRNfUfjxoPkomsMWRMF7hF7?=
 =?us-ascii?Q?6Lv2p1MqKnbW8W/v5yKPOFyt5cCW4kj3oxIw/+q7Lb54kq132EgDRC3XVdYw?=
 =?us-ascii?Q?sZx/cq6vS5IE9fOfFMuCf6+Z1cKOPka1Yhfzbw1Vn/dGHPg7ttupqono4Afr?=
 =?us-ascii?Q?8CWGkilWl20a02P+QRCYI5LlzxHefk/yGz+5NQqrJqQ5mEjcU7JolAD+tI4S?=
 =?us-ascii?Q?CZztT1KyLFtU4YiVyxh/x+L37fSuaUVVwXyaCDsS5rsxr360XQEas7TNte2A?=
 =?us-ascii?Q?7IZWarn0rooeo6TDTK90jFLG/3fcgaW9x/FasUWdMUCTC1iXcBPQ+cNAFfdJ?=
 =?us-ascii?Q?Z2Jh0U/I9tGlI4fdMTIwlHiOnp/Hgtk7b/POuaZ3b8aEbn9PwfLtYecnbayu?=
 =?us-ascii?Q?eTJUg/k2/WihGhF3B+VGvwn6loVfRFY/+1Jl+tDhK84BiHpQKrs927K3MyxK?=
 =?us-ascii?Q?OEeHpIdQ3LrJHkWcEf4Xsr93PlwpOXheqXHZJ1+yXWijtsMbbzzlxayd1SHn?=
 =?us-ascii?Q?4Q610U2WqSwwgZETvzoSuCUJkQ/Vm3nJEZZt8i0DgmVOIyL0dsq+q3mLl5C+?=
 =?us-ascii?Q?ErZSKdiFulq4RvcY8VRRaEfMck+e2UU=3D?=
X-Exchange-RoutingPolicyChecked: rIf0HF+aWjiNAQZKi6lFZN6RaOditoMCbjgQ8jFUoL9uxBewB0F5auezKfcKupBdO/ESpIClWDP8JRZYfHSaXo64VtFcgjYNhPnVVCDQrp4VoZqlBcj9HmiZEX6uJLdccHxXHRn3wN7vijjS/io7p9YNeYWEyilesC0XG9RaZut5EN4qyWXA5eltKT7OdrSriPM9WW2ghUBZnRBzFWjKLMi3cnr1VMTQht+uY4x2JXFtVaCuoaoDL6ky70xDMrBBOVb6qo3I2lwIQV7PZx0iBzG7CipwukARgK5FMMOPDkjOuB1WBQxgK0T0SSJz1fbW4lJHh7+kvfxyJp5T0nSkkg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XY1P6meQ76bRe/58atDX6t3tXoZ6KRlA+uHjdoye6Xzf+40HuO4e8cMjGKIqp8qnOSpsFQaMBCFMadzjApCGEdZJFmuaYOTWASCvh0N+xCa7XS0x2/p+Wm5pOQGjEMrR+HM0wAx+68INRokykMxF61odvf7iThgNLdD/30gJn4pBcDUDScedOprtP4UckS7yqIRpC+iDD8KnMuugsWHojlO6ABjP/0NV2Rtyb0Ed1BLiNBmE8e+JkR6ntVNV0S0pyMvHtEhtGIuYKzuWFZjT7Pn3uBPdKFKTZiPHHgHzXicg8kz1n95jO68ymrSKNRDHEDyEK15BnYBMbA42EGcWVU6YttK8obq8FJCWgVnir89qzFEcFn8HeXfGAUfCBzvQ2QeU/I6bdLEWfrPE91FIw5r37V+6WrCfHiy9NqCqAXnA07HmMKANBE06tuyO8Esdm8vIkog2sU6t4DmGB8wlcVQc8n6eURUwkDwPfONWfJ7roXFUXLkX42zFb6CiQ3dUWh4Vh4QiRYRPI2gK0nsOqgIC/UjStdu2yTzF1C8+qk8o0EbKE74UVVd1j2Q3ePEmHnSk4BOMZ9iY7ZpigygEUjtyu7Y4Tp3QwIF4OsoNY5w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa36054b-dfe7-4440-5d6a-08deebed6725
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB6229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 14:43:20.5298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2aDF+z1zGs9U4SD2QY+k/imR/ZQB0ZfCwbjvq7+WezcRao4m3pmpfphdfdSTQX0RorVmo2Pe/wefU5F2rw58tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5115
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 mlxscore=0 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607270139
X-Proofpoint-ORIG-GUID: juS9RUeeP1R63hgydP6aKZyQQwjIs6Sh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzOCBTYWx0ZWRfXzMwuiNi06qwt
 xyxbQX4T6DoCGUbZWOFWdKeEPGCJPNfDHKzJl6oRhVvD3JNtHPlrQ1C3iTk0l+EgQQ77vqy7J7C
 AE8Wr46BT64IKCRC+MIpn6NI9XIIEXpDS61/JkdqZbYdxAGuVVr2JryT0VD98SU2csgPsk78jxv
 Q081OvETcdioruL9EKypSjDYzUNeMSXd1YJA4QcPPuTAEmtAWcgSS1LIlQtbtuk1HACY/q4kJAz
 ZstpwiEpQXevVIRBDbTHwP1ROf70OXfSfQtpkBIzQBPUhXc80LQJNzg+kd02YSApVc4aUlEz83H
 xbZjYFmB19z6cwQ5BMEojNO70Z17RZzf+37kE27PECTu3T1TKexq33qGsA9RYKR85FVp1J0nIfF
 fDdLiz17ULJZ6ChbHhO/bNqTKU6nudc9+BgVop+1S4OmuH93lNQKxsV8KY1VTQabfyTkiszHDS4
 IRCcwpjmuFcS4tFCgt0sc+ghDutoIit03UyGlzMA=
X-Proofpoint-GUID: juS9RUeeP1R63hgydP6aKZyQQwjIs6Sh
X-Authority-Analysis: v=2.4 cv=A6Jc+aWG c=1 sm=1 tr=0 ts=6a676e8e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=RD47p0oAkeU5bO7t-o6f:22 a=yPCof4ZbAAAA:8 a=W7bJnpMICk0HBaUQiUgA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12115
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzOCBTYWx0ZWRfX3LhKxvYzChfw
 AdWO6SheFZ1JGnhpy6w/0s99j3X4HwBTS7cZ23qd9h0iFzI+I18Nv2dYK3hoXFVNnpjuqUFufcg
 6C6EmZ6EAD7tZisNuxPceGbqa9s7GMGRtDUyveKWCJos1fvaCcXD
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_074335_395935_3088CC90 
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

From: John Garry <john.garry@linux.dev>

When a scsi_device is unblocked, we need revalidate paths which means that
we clear paths and requeue any queued bios.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/scsi_lib.c       | 2 ++
 drivers/scsi/scsi_multipath.c | 8 ++++++++
 include/scsi/scsi_multipath.h | 5 +++++
 3 files changed, 15 insertions(+)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index e2452392671f5..41d201b7e7def 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3100,6 +3100,8 @@ static int scsi_internal_device_unblock(struct scsi_device *sdev,
 	mutex_lock(&sdev->state_mutex);
 	ret = scsi_internal_device_unblock_nowait(sdev, new_state);
 	mutex_unlock(&sdev->state_mutex);
+	if ((ret == 0) && sdev->scsi_mpath_dev)
+		scsi_mpath_revalidate_paths(sdev->scsi_mpath_dev);
 
 	return ret;
 }
diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
index 801d95652fc6b..582deeb403119 100644
--- a/drivers/scsi/scsi_multipath.c
+++ b/drivers/scsi/scsi_multipath.c
@@ -231,6 +231,14 @@ static int scsi_multipath_sdev_init(struct scsi_device *sdev)
 	return 0;
 }
 
+void scsi_mpath_revalidate_paths(struct scsi_mpath_device *scsi_mpath_dev)
+{
+       struct scsi_mpath_head *scsi_mpath_head = scsi_mpath_dev->scsi_mpath_head;
+       struct mpath_head *mpath_head = &scsi_mpath_head->mpath_head;
+
+       mpath_revalidate_paths(mpath_head);
+}
+
 void scsi_mpath_dev_clear_path(struct scsi_mpath_device *scsi_mpath_dev)
 {
        struct mpath_device *mpath_device = &scsi_mpath_dev->mpath_device;
diff --git a/include/scsi/scsi_multipath.h b/include/scsi/scsi_multipath.h
index 8f58c44d96a77..cc77e63c43da3 100644
--- a/include/scsi/scsi_multipath.h
+++ b/include/scsi/scsi_multipath.h
@@ -55,6 +55,7 @@ void scsi_mpath_remove_sysfs_link(struct scsi_device *sdev);
 int scsi_mpath_get_head(struct scsi_mpath_head *scsi_mpath_head);
 void scsi_mpath_put_head(struct scsi_mpath_head *scsi_mpath_head);
 void scsi_mpath_dev_clear_path(struct scsi_mpath_device *scsi_mpath_dev);
+void scsi_mpath_revalidate_paths(struct scsi_mpath_device *scsi_mpath_dev);
 #else /* CONFIG_SCSI_MULTIPATH */
 
 struct scsi_mpath_head {
@@ -93,6 +94,10 @@ static inline
 void scsi_mpath_dev_clear_path(struct scsi_mpath_device *scsi_mpath_dev)
 {
 }
+static inline
+void scsi_mpath_revalidate_paths(struct scsi_mpath_device *scsi_mpath_dev)
+{
+}
 static inline void scsi_mpath_add_sysfs_link(struct scsi_device *sdev)
 {
 }
-- 
2.43.7



Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09089C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 16:11:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1C64610C9
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 16:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C1C64610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	In-Reply-To:Date:References:Message-ID:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BtxjHl9HdLdioxn5B3aEXYR8iSqwwv4q3cKUjsXhvFE=; b=WF282Z9NXvJQ21q7mcbAQyGhlR
	jC/G2hhODdTCt/aZwOmC5PqifuvmI1KtPGnVrOZ4q0EHjb0hVz6W5tRU+nGNSxp+Vo1FHZQ15PZmT
	5Vre/kSPSV1lu/4TQdf+4mUdaeSYgJQ13v2DLU9TIQMjyJAYKZyJMWxBBwuQy3PHfBCyFw2T8C7NJ
	DsCSd+jFShYPfNFLkhy6x1edFyg6vnEXKjpmuD542Zyx8098IurTU8PsfAx/xzK/7IWng/aH8tQMe
	TfXGrMWH9R62cOI5vAo4CtFmwLrt8RGbAd0GGuo2ouCNZZZ2AKUX8/irRgVEmss2WGQKBPZSL57oE
	x0fgPbKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1magqX-00HYVo-F6; Wed, 13 Oct 2021 16:11:13 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maglG-00HWLc-6V
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 16:05:47 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DFS2h3008168; 
 Wed, 13 Oct 2021 16:05:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=BtxjHl9HdLdioxn5B3aEXYR8iSqwwv4q3cKUjsXhvFE=;
 b=Tsyc1AR0GF7787vrJEXqv/AcKHGgQgG24nX68Raxtn8gcY0Rf89nHLk/KOLTptfMqMmu
 NMFtOyS+rX+5ap2YsF3HAXPrapV+UABG7HC9shHSfyKeJ9KbK0DiPhC5qfVU9y2Ner4D
 qUn72QDtbHuWP6iHuonyFFgFwpUIm302ly5NNDWZ1vLyQXp4jcoS2Mony51f0UdhsDy+
 DfYrqp8qE5fmOReUYeaMT6dOtQ4rHUxxfdc1AHbS/zfKrFc5gGpE7vkApgy6AeMg0qpM
 GUuDvfWM5Zus2xDr1RA0AGEh/qWvD0vtfEWkUAaXwoeLrFyXPnxWYr/T0qcb293YX5J0 LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbj5c3w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Oct 2021 16:05:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19DFiSEj047827;
 Wed, 13 Oct 2021 16:04:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
 by aserp3030.oracle.com with ESMTP id 3bkyxtqs16-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 Oct 2021 16:04:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JT6f5nzvjC3oG07gpoqHz6GSLdXHX9+LSapuQ3WJ+nxhG7eJ/iV8vysWxuNJtw4dosxcauCaWHvPTZyzMzXUCsrf1+uvZcAzsa8hQQqRJjHJlxQAv6dXJ/5VIijVLUh+jDR/e9gCynLDGrGYc64aXIlcfaYdkzK2oHp9nbWQvUZ9A2DApBgoGrx5m2zMRh7NPC/nGI/jUCqWqQgjbE2fPP7vUhJPeNx9abheU5JYS1eLOMBK6LLhkLB5+Vf4Mq7c+UjdJD5VISi49S/9+w2ZeDAdO2SXGGtmv0MoxkAV1QR6DuxUOaBT54PRMheOcuujAe8+ppVGAhbUi8CdGnFW3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtxjHl9HdLdioxn5B3aEXYR8iSqwwv4q3cKUjsXhvFE=;
 b=E/HSe2iPXmxezG/R2YRrGOYmnIgtCo5CIfSRUSx8tPvVWygOi7bVvxLmW3EsZHs6IKu57DQpHUtTRbwck+Ib+Lvpl3a68yCt+JTIpKiA1aEO66xNYqjozV8PF7t4dLBROQTsgZW/wmdYG4gP7FrWtBi1ZEFSWdkzZmNBBnIc63TTF8Xj9YUUhxZBXeMkcqMtNTupqS03OgJqZRRcA7F+o2cNATpV+Jx8wTQKfT6Lm6UxaVOlCuHqw/lyR6upu1bFSj5yj/mAK2KorC9/uk8nn2NzyUMODaEAVfQTnweki/h/lQIMbuazt9DOEcy+epO7n0HE7+RN2/fhUQB82Tnwwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtxjHl9HdLdioxn5B3aEXYR8iSqwwv4q3cKUjsXhvFE=;
 b=woZlMeGw1YVRTI2PdRop8hOAsB2bPx7qlrXmiAbLAUIDmAhwlCcFpgiEVyt/XEakHM9m2cTYLC/QNgWlN5a40+d5IClDnMPf5WDFe5Q/na27l9JotKvZG+gjtKgzdtJNTsCuZ3aMfwHuvq8eor43W/ZMHiq/CbsM0vBHfZMbFF4=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4792.namprd10.prod.outlook.com (2603:10b6:510:3d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Wed, 13 Oct
 2021 16:04:52 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%9]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 16:04:52 +0000
To: Keith Busch <kbusch@kernel.org>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org
Subject: Re: [RFCv2] nvme-pci: adjust tagset parameters to match b/w
From: "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tuhlnd0c.fsf@ca-mkp.ca.oracle.com>
References: <20211013152136.1594409-1-kbusch@kernel.org>
Date: Wed, 13 Oct 2021 12:04:49 -0400
In-Reply-To: <20211013152136.1594409-1-kbusch@kernel.org> (Keith Busch's
 message of "Wed, 13 Oct 2021 08:21:36 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.12) by
 SJ0PR03CA0069.namprd03.prod.outlook.com (2603:10b6:a03:331::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend
 Transport; Wed, 13 Oct 2021 16:04:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ec50419-ca70-4d60-b0b1-08d98e633102
X-MS-TrafficTypeDiagnostic: PH0PR10MB4792:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4792D841C3A97100F2860B228EB79@PH0PR10MB4792.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v/rs0XXiW7h1mr9cNadcf4pf77LtmVumhL8715efCLv0dygBtMPlpxSpz7rED/wSAmwJbYDxFRi9iR3usZFmQlkjfOTtkVPZ0+l7AM6FUTjz0KFXuCmMKf0tJFeOzQWacFs5LL5XPPfWCfMjQhI8UYknV4xXk0ptUAJO7KUKKj9qEZWfklCWfa28Shsd87m4DWoMGQgsDGHEa8bP8uf6qNdfejEjUQanzM7vWULZR85uRvTOrW9gwo/5V5rnWW/rEnR1K/Nw2D5pa+sWbLTHDkQHvrcgDnayBwUsMgfuvjo9oVJrjKAsJRhV5bNwvKL6XVfK3RXYXRs0kA1yA6CjFlvKl9BRa7XsZeEEsaM9eJk3XHIjJKEiL4bt/YCVKEb42aPAuXAYLN2/8kmZEQDIOx6bzz/TaNYXNeJkCEvKn8KEVgcG0zVbVNIqE1X21AkbKeIsGHh+VMwvFXB8EnHEkZp2KG9MeRT6PrFsjGUOJGTj5KFy9KbxjUnK18k4j09gr23uEnAyWNXQzMZuaI7eVilCi+AtltKpbCoczu3DuhqyfGefSRThm0LZO45okHp1KZ0tCTW0ZsDnMpiwfaWXRGJy47YOWMhHIig17Q2ixaSUGTOjDqu3iD17DjoIfze3ssGwZpHjHgL715CjN/fkp0BxhntoY1vmmxjH8ysy/XWRLxOkzbL0CzugwBgDkPcM/QycpdO/T1CeesSxyo1g3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB4759.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(26005)(66556008)(316002)(186003)(4326008)(66476007)(38100700002)(38350700002)(8936002)(508600001)(8676002)(83380400001)(86362001)(6666004)(5660300002)(36916002)(2906002)(956004)(52116002)(6916009)(7696005)(66946007)(55016002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lVIDz5HSvZM+iNWvm1wW4vem9HVTn38gQJROOsfN5sdAZmNOYNoqFTqKqmQT?=
 =?us-ascii?Q?cnuV2uvv2sHycVyxyMw96Gi6IUmMhyLfeYhe61Wz268I5/kwDwZCCE/Fapqw?=
 =?us-ascii?Q?3XppQEaw8oqfVay3pc27sTC0cCn2bF8sw2S0m5nGrk5kf/ZIXKN7JAUH4hqD?=
 =?us-ascii?Q?iMz3bcJUz7Eun6F4AFwcMdHLiEI3hFPLPsw4qxOLQSY15j+3ML1z/Li+BuJr?=
 =?us-ascii?Q?4cyTYvu1gFzq8OXb9wWm/EBdNDJxDOFWGcSONMK/LEmS5jNu2/Lx/5y6pgwD?=
 =?us-ascii?Q?eONEJi7gIgTYW6PqDm5Kaid8aKNMctTv92dj33hTOBVbY0+ntfHGzG6iJjvF?=
 =?us-ascii?Q?jiDteZ1friQXSmQ/4IIrISOkiap137vfEGu4F4HdMnmQa8JPGafwU8CqBdgB?=
 =?us-ascii?Q?xl0q49+BX8MJHiccBOdLLiOwmORQDnJIBohOg0oYbQwaL8A1iszzfAtfaGO8?=
 =?us-ascii?Q?gsnndjRqGoJsgWJouaEqESCJfdDTSFIy9GO4319mZe0rw/lZayPKz5CSvMHE?=
 =?us-ascii?Q?nsAlcU+2YzUadzVYEDXoiTZM0UcH2jk06VigRF2VR0A+l3Ncz8sRapha0Glx?=
 =?us-ascii?Q?qdXiT0Mlw9WNHtGSRPldk7dEiSybhrIOJM9gfGS7gbz6sDQdayiidU41JOWV?=
 =?us-ascii?Q?mm6zU9HptBQ9iARviIKRGgnoh9e52yC4Qkfki+nnvy2UF6bRt5lQLBhHo8T9?=
 =?us-ascii?Q?ask1XcRda+PGqsbFbyLy2bx+RIXiyOLcQUOjDZ0FRWD0XicZycrOjsKIAoOv?=
 =?us-ascii?Q?PONs9os/wdtkKMSVTSDuTgitTsadC43oKbwj3vpJXYC32FuMPUO+Hx7H1443?=
 =?us-ascii?Q?BZNtyeI/bGQcT+ISUa3/sCiMdWDiRVZxyLt68R2Zc5R0hIbU8IoCt55WkHSj?=
 =?us-ascii?Q?ZNQTNwu2vdTmSGHBlavwPUJ37PBD7EHHLwNOov/g+fHlaRmEebgB0uYrYdYX?=
 =?us-ascii?Q?LcZBi570pAr2aKoQMQQCmnFFmFslBs/pchxBwAMXY0DeiZTk9tntN+9QcDwe?=
 =?us-ascii?Q?sTPRWuWahwazD9C7zXG9jSvD/PUZ8JMekXIVIoogZIZcifQ3R8o1yk1KT2co?=
 =?us-ascii?Q?7nstqAh988Y87PV9TJQguNFBZeo31HbsLlFyeF1oLZjNcHvHNpt5WStXYBx6?=
 =?us-ascii?Q?MPLobXqEZibP0+e6aFPgr1/iRm9VfjAItDUs84AE+/tjZZVcUoNWUL00i6I9?=
 =?us-ascii?Q?fN92WN64JKtjHZTy92fbCgTiqOcSIxLSIVt924fUcFDYwcx7db7aKagi2Njw?=
 =?us-ascii?Q?4fjtzr9Ql2wFGwYAmqtxDN2WfRRwG+dyhqfC6EuyOj6JU+A0TBA3hMiPBI8n?=
 =?us-ascii?Q?+O0gBv9H49oaKrN+3P0CqQio?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec50419-ca70-4d60-b0b1-08d98e633102
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 16:04:52.5827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEbyAoZRak25kGbGH6giIpf9rrCg+YEkhtByAvb1I+k6O/9br0LMxALtRZTiWb2T7zDTtdavd7S9hrWoDwXnUZlOS48b8Qy6yMvcNMS9xRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4792
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10136
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110130102
X-Proofpoint-ORIG-GUID: lLQL7YKLF-eWLSNaOjkNlQwTb0Zl55tI
X-Proofpoint-GUID: lLQL7YKLF-eWLSNaOjkNlQwTb0Zl55tI
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_090546_293591_7486D947 
X-CRM114-Status: GOOD (  15.86  )
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


Keith,

> Instead of auto-adjusting the timeout to cope with the worst case
> scenario, this version adjusts the IO depth and max transfer size so
> that the worst case scenario fits within the driver's timeout
> tolerance.

I am totally in agreement with the concept of preventing mismatched
queue depth and I/O timeout.

I am a bit concerned wrt. PCIe bandwidth as a measure since that is not
necessarily representative of a drive's actual performance. But
obviously the queue feedback mechanism is still a bit of a can of
worms. For a sanity check, PCIe bandwidth is definitely acceptable.

> +	static const u32 min_bytes = 128 * 1024;
> +	static const u32 min_depth = 128;

Not sure about 128 as min depth. We have seen workloads where 32 or 64
performed best in practice although the drive internally had more
command slots available.

Also, haven't looked closely at your algorithm yet (impending meeting),
just want to point out that the default 30 seconds is a totally
unacceptable timeout for many of the things we care about. Our I/O
timeout is typically set to a couple of seconds. My hunch is that the
algorithm needs to take into account. In the past we have been bitten by
scaling algorithms that were essentially linear in nature and failed to
pick sensible defaults at very low input values or timeouts.

Anyway. Will have a closer look later.

-- 
Martin K. Petersen	Oracle Linux Engineering


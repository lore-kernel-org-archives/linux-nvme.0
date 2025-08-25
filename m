Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879D8CA0EFA
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 15:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Date:References:Message-ID:In-Reply-To:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eq7O8BizOw+VMsAcC7Lle4p2qyOYCBpOxkWP8xDKQGU=; b=jF8pIoOASFuWpEYT3xeFouyt4n
	lJGJ44XT8jp21QGz55Ov/WJjJ7d8ckI/bEsFnjmkAf7j+/CKA0f/qvJS4wtMLRRsSGztEEEjohina
	NBzlhKhVUni3SMZbk6jv+mYWBRa/pwD2kWRooAbWRnTrEDxNCl0afMqk0FbtVDxsX65fW6S7oi0BN
	hekpC+1tIFigkDlQm8m5HO5TPBvYoTFviyAi4fC0L9P+FKVQShdma8DAA1FB70q6JhDvgt7TR8skH
	aBPsjfsSKxd6OXvN+HgQjy0CVnSnpMjhzaN40BGEW0gOehlj73U0BkfUUU6Mb5SvsmoqX6wGnXw7V
	PLwsFNpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqYiu-00000008QgC-2qHA;
	Mon, 25 Aug 2025 15:03:04 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqXtT-00000008Cjz-3TvY
	for linux-nvme@lists.infradead.org;
	Mon, 25 Aug 2025 14:09:57 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PDTWPD014833;
	Mon, 25 Aug 2025 14:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=eq7O8BizOw+VMsAcC7
	Lle4p2qyOYCBpOxkWP8xDKQGU=; b=F2wAspEVMkosX1HEsIuNg+zoIqJyCCxfgW
	FwYdBWwzpNbP/eUSA9LU0SH25WFS6lphnPoY7hdV+SQzIoGpv+xrWMj45DfK2HdV
	0jsLVZeNURtuvOlkwaAHjwv8u0thB0/xsftnp/htSu0Rf8jVKeXQNLGuEw6dXFmm
	OSgsPXJvLE2cJ32Owb14BI/XsChWu1FZVR/o/9C86JQ4/M50RCd65ZLGoVuWClwa
	Fw9tMBOL9WnNkPQb8V7AJEqLnYE0amnqTIOzJcSQl1e1JiaOyIjuP8tpoN3BKfkN
	eyoLD7zb3+nNHdSAOrtJ2meWnFKUN8SfI8/FX4Q8fi2MGZQYBE1A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q58s2bmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 14:09:46 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57PE3YQi005021;
	Mon, 25 Aug 2025 14:09:45 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010062.outbound.protection.outlook.com [52.101.56.62])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q438fk1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 14:09:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpdUO81jFQicd08/yMj5oZSWnsxk0MtptBrc6sRGBbSIQtwcOF9KGPgNMuVnDrIA2iM1JM261KJvwy8UMvXAUnsEtYIx89Lf556ig4XYHcXH+t0TiEJrIzf2tWOEoFK9l/fEzIMVQhT+RKhyX3tidFxBTR+7eHLTibR9BnWHGhmwl2I5WdbdE2P/CQl0JLitpZcukd037Ug0llrHIRSajn8noMqb3StW3KzQkYH4MiE8Pe66ijGl4x4rQ1cf6/lmR3DgZdEjOft9MrLDalrc/FX7X8KdLy8DIV/P+h6vZPkiUR5ARFhgpsM0Zhp8/rOVyyw8ysLj1TIriP+3C9el1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq7O8BizOw+VMsAcC7Lle4p2qyOYCBpOxkWP8xDKQGU=;
 b=XrTDfx9CE/CrFgabrJLtC6cJHlWL8tqt9VQ6V56+ceTrYdR9o1TmNFToMfMvf+IVOD/4tc/+ohVyXzPtzKjNo6pIQsgMN3mV0L5+gUIrYdt2W9t1ruGauui3MGNsP9t7wKo4gLAuupYvU52s4kzErVkGMimBSKGlvbS4bH3dyOEbBPBE2HKpluLJp0boXhKNUt6qAs9C/PoZU91IUPn0WAxu6MUjbY1hA6PaTQRdD5tZcCv1EQ3BoUA1BSHLDksSoB3n70IwLktFzmf78QhJP1Oew+kuVaXJ5MOgTEir9v42qRxqCvqPuXzwV+li/TvgGjEI0zg9u6njHet9c3YBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq7O8BizOw+VMsAcC7Lle4p2qyOYCBpOxkWP8xDKQGU=;
 b=G9o51U20+ZAWUOkBfrClXWt5EK/Ew5JwtkOoKdMsfzXSg/4E2CMeCghJeXpl5DqMnE8wyXQl/FYeNk/PwA8QGc72JlEAVA/e74G/HjSe3a1tU4/vfczA9LHaxorflhiDExFAD/msZUDg9K1UVtHgysR9Rvmgzo8CTYVjPucbCLo=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MN6PR10MB7999.namprd10.prod.outlook.com (2603:10b6:208:4f4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Mon, 25 Aug
 2025 14:09:43 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9031.014; Mon, 25 Aug 2025
 14:09:43 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        martin.petersen@oracle.com, joshi.k@samsung.com
Subject: Re: [PATCH v2] nvme: fix PI insert on write
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250825133327.518741-1-hch@lst.de> (Christoph Hellwig's message
	of "Mon, 25 Aug 2025 15:32:49 +0200")
Organization: Oracle Corporation
Message-ID: <yq1h5xvsdbd.fsf@ca-mkp.ca.oracle.com>
References: <20250825133327.518741-1-hch@lst.de>
Date: Mon, 25 Aug 2025 10:09:39 -0400
Content-Type: text/plain
X-ClientProxiedBy: BN1PR14CA0027.namprd14.prod.outlook.com
 (2603:10b6:408:e3::32) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MN6PR10MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: cef73796-7b30-4b48-b461-08dde3e109cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rhhZLbAc+kYwafn1VXBnMZ6HkKD5NnBWVQ2ttNXdO21nj7mJyOWLpnSOm5Rv?=
 =?us-ascii?Q?wcAhBulfxyY36f4SP6uwW9P0LndVPwejcTJrKfZq6I+GO1A4Ebz1b3r2NsjX?=
 =?us-ascii?Q?eGF2HpaHLxv92cwuGSzoxHWOLHMcvQhKob1cwGQutAWrGZ5ZyBXHJH2MOwkh?=
 =?us-ascii?Q?iR/HmUw5X+1E9RhWZ7KYzpneuB0Eu0/mViCnxfKEBG4lSe0n7xgd4upTPX37?=
 =?us-ascii?Q?TbOpBzxt/UQmIhx0f3bPiDv02Q9mG4X1BZ+o1GSywAnkZghyekUxDdWUi5td?=
 =?us-ascii?Q?IdYbjb7rKkz7LdJgacIggAjx4hoZWhNau+Ap5GDr2RuLvo0P/MaA85UlMm64?=
 =?us-ascii?Q?WEa6T+qR/7umewaBrRUuCUMkfUeSUFaYoNlSJP7CI/F75tE6f1M59vGT8wg4?=
 =?us-ascii?Q?4wkV3FCQj3TIbZ8De5gEmkP4OCixflOJXtxZgGE8T0t6V08G8QSQy8K+1f0Q?=
 =?us-ascii?Q?zqeK8txUkgWg6lJXwPBWoRYCsP0cTr9ulzYVnx9c0Hyf0tFif1Ur27reCTsY?=
 =?us-ascii?Q?brOU9w2OPP3JE8Zd7SvFtcxvFZdm0wjKQ3OxVE8kQ7C7G0k/ve19/bShCYcs?=
 =?us-ascii?Q?N8RfckWUSGf67IZJyBi5m0OcpbRrxw6CYfMyI4O9udLU2TnzkKjq8YmAdIfy?=
 =?us-ascii?Q?J8uoTVuk2JfqQSWo3sn/RMhAKwm9Bsc06aHGOU27qZuCm08ex/1+u3QYsMnj?=
 =?us-ascii?Q?0LZtNZ+wNCgI8rI87AWprl4bzgZujsRX39YnxYgt4niAHiHPaw14iPXhAp17?=
 =?us-ascii?Q?bWwMKmZWnK4KFyjQf+l5huUKr9mGGiVHCQnVKUdOAvlgQ1L3dx1Ntxqof4Jj?=
 =?us-ascii?Q?/zLAqW3pzmPLHXM35Ol75aEoka2bVkCfyQyLp9OiQYev+8898EenLf/PZW6d?=
 =?us-ascii?Q?sU0waU0hYNv6vub3CUdKLB57pMDEfCnkJUKQRPQsEmSAV9aAnd1IAPFaEQ84?=
 =?us-ascii?Q?9gbizAZYUniqyUvnjkUBJbQmP2V5M3xDK3I+LIQyBbPvjk2UnlOxkdiT2BTT?=
 =?us-ascii?Q?V8jCsNePpAzXdgnBNvakTOiats0fA7hrQL0x23LXZJKaTVcsjkKBKPH5h1F6?=
 =?us-ascii?Q?cVZKm+QIMLf9w7xVq10hNITHRGkkKC3lXwyD1TC3qcenGcJHr5jpBtByStl3?=
 =?us-ascii?Q?lbmAm0lHUqORZzOMAxcblUQnCt1vT+gGsQ4KQ0PFdrFVbFgA6QLAD2ieqrZ4?=
 =?us-ascii?Q?TWvGMQ7yy7WPCD/AShSseQpXunDkTG1WE03a0DVUOkH9kjrx1M2Z9GP5tcXI?=
 =?us-ascii?Q?o4QBbmgiPpm1WWi0Rb6bRjrEBZh2nH/qusrKOWBAq0U9rBiO2G4qMte6VZAi?=
 =?us-ascii?Q?FA5d10kG3iKxkVYUGWpd9DY9IByjZT3UlUQgRv1IrnvyPD+CJRan+tzPqnVH?=
 =?us-ascii?Q?jsplKbSHkRjQ66L1DLSUj9es9iD76WoYyx4QsThXN53mF9iB5MClNKlU93YU?=
 =?us-ascii?Q?YqML11Wr6Rg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e/NQ1e1y1gUZT71jPhLwJx777egHI1XFbedlXOeFAbKrgVnESJaSmaoYSP8y?=
 =?us-ascii?Q?ymlDY0AFxOyDI1tK5vqHmdboUZZlBCcM7tYyuArGzhtf8pHAS/x4GWtxTjk6?=
 =?us-ascii?Q?c8QJB6tbyU+AN4+pd7VRTbK//wGtrWmGOgglDadeEVFYz6q0eILXbVrJJ2Cj?=
 =?us-ascii?Q?jagMF27XhMbF5jXNhldzbpTfwav4poFUAvtc4xvVxzZVndlzDKoR2FJluOTB?=
 =?us-ascii?Q?wnyofu1Nkk2H6gLDlXo/6bUbw58oxwwkvewNTSk5H8q6TMozJgBuEV0eAmoN?=
 =?us-ascii?Q?CEb04i0Kgf5oKxVm5+KTYmiafN+QczPoLLVRBcwpp5jfnmc/h1B7GPPVdpx1?=
 =?us-ascii?Q?pXdffpiVCbuA1yApUQQtul5K7xydSbCeQnPHZs4ROJepJdANpUHLBt+LrP6j?=
 =?us-ascii?Q?v7Zi2FivUzVHc1pA57oX4fKBu2oudtTLgxxngIDtny1TgZFfC/awx6G/vBdd?=
 =?us-ascii?Q?boTh5j0FIZLPy33BQ5Y3egW5dVqZc2Z2raCbVDYhsuWQBga1K1jEbtDweQA3?=
 =?us-ascii?Q?XPude3hoXgpE64LlRkB99JH8n1nY2YGmACqyozO71o8LzjEdinlxZJ6sm48B?=
 =?us-ascii?Q?mqCysnkytcdwunkTXs8CyeraXhdmniORUAeZAGQv4TFwKXkFBZwZuPTWgxab?=
 =?us-ascii?Q?Wton6yn+4CnT8n0UJaWZukTdzoY52hqbgqwShum77AJoJx87TLlp7HXIN5CE?=
 =?us-ascii?Q?oXh69oKzaA4Vo3EulFUY5KuMfiOK8+7MinwUWjjXim/3TC/WBBAjA/586EBb?=
 =?us-ascii?Q?qRulhtriBg99zFBRtsyY8ECstNpTi8GSA2ZzawKMbf++XnpC1hWDjk6cS8Wb?=
 =?us-ascii?Q?5bnxkvVnomQflLJFpBMfG+Uw3AhlyTWJNkVQVn7JH1cSwO3cX7uGTsbxcLGo?=
 =?us-ascii?Q?GDuiCTDtvnVxo+iZ117FwSpwwFK1ZCNvYHwxCkPMC+KiOu096xUh+UYYzZGc?=
 =?us-ascii?Q?zb0OnCEsmHQFqRWOC2jiGgHCOCB3dIlnrCJUvLdxZ8ya1Wd4+Lw00GX/3eTL?=
 =?us-ascii?Q?nPKMhR0Rg9e2JR2W1+b2aYlfUnsW6naJe8gDmC8GHxnQPQiR8RE1GBdaO+Zg?=
 =?us-ascii?Q?eYdHcmIa22ElJyf3nJB01MeCv7h+cjQ+DsxvrHpI7bPQ1AzcZpBsvjEHIQtC?=
 =?us-ascii?Q?SaTgMSibgftnEEN6PsJsBuTmIQfv510R5C0H6f8CdQL1tJeQcBZfHr6NcLLa?=
 =?us-ascii?Q?Z3StjSit7hKz1epgvukZwmINK4WBCPeUFJQ2Hr/7YgSEz2WVvzh0wlfDECIo?=
 =?us-ascii?Q?VKDx8MahPOGx2OaHBfvmZNAtXTLyRHNnviO6JQF9Aq7UW1ulPKh3h0OCl4Qr?=
 =?us-ascii?Q?r0ILQ5ChsSPZwhhpq7MqB7/OY+rpyipjWZST9nNWWol26kXevGiJjwQuRXxU?=
 =?us-ascii?Q?Sj2LGGAJmxKKgAvGJeC9qU+Ydr8d9mAJWULowIBUF2SUNFFzuElC80t9wUfX?=
 =?us-ascii?Q?IBokKHBKMDvACU0qYb3YsmJGwSlWmHf++Mv/1q/L3ooM844zdeVct1uXdiH+?=
 =?us-ascii?Q?Gt6gZxiTpw48xYyNYq738qSGAMklxE5xG5VfOCln2yU/TssSwWzuDDPgvquS?=
 =?us-ascii?Q?aIuj/Ai9N6VqzyzsgDDMLJZBa4z44wpIZPzoGNxXaI+3htzCusbXxmvOTA5Q?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n7tVzSXUlVLyHSXdF4f84rEyYIRbd1KCC2E8kJln2Om/3JS0Li+lnKK8jOKwrQvRbm5c5nsD3IhuWYIiObKsRawrCKw0/UmSnLx9ZEVX+Ko/iD1mVM38xlRdIn2SVHhWezjA+u0NMTd3zG58FR0s0s7Bpa3SHoep9Q6iP/MsZW7qxldK8t06QoWtgE+mc2F68GzMtuwPfxtUZgRFnqESdA8cPKeF8vA+5+Rm/VQYGOSBXBuE/5KEdmegQh9mQkoG3GwjdVFz5eERhnHqCgx4NKRMV/b6XmemvaPQB1+bPsnH6VTBeXCAKta+JU3a2VJ4rSNOIWBuhedYNxGEaiTj3VCKc0hUff+pTqbS8cfGvKa/UPLkPgYDxzlddHWaDh22xS1Z6fuVT4fD9FfYlgLUXZbBzO8VJW7FHVoSNYCGhUlWCTC6IdEkmMmcfsyujY84YdpLKAvDEmDPDZnEJqRZX/fx0l0/KREUI16wYwbuoeYdl2o7Jlt0AnfNo730o+IvRaDNEOLNTcT0tSlh9Dqvoaj9GC1B1l1WTrP6Gr5F1Ia+BYimCpVL6mXjKdzZh7YgGpZL8dhS81UyCv/2FHxxoXpm2YvH0H+kQj7cgs68/Ww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cef73796-7b30-4b48-b461-08dde3e109cb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:09:42.9938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6vj1oeeHt2HIaCFFOzntVqj+9qvS7N7MskffZYBkkLbMCU/fm4wfLyfpezVkr3Ll2SkZT9g+53gRrIGAF5ivLk64iOUbEdyHPdBgW70VVHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7999
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=988 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508250128
X-Authority-Analysis: v=2.4 cv=J6mq7BnS c=1 sm=1 tr=0 ts=68ac6eaa b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=tAWokVsirYXBwGRgSwgA:9
X-Proofpoint-GUID: 0gE3Am_msEnEP3nyVZLxP_Orq6cMNSWw
X-Proofpoint-ORIG-GUID: 0gE3Am_msEnEP3nyVZLxP_Orq6cMNSWw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyNyBTYWx0ZWRfX4KyeKLqKjZZO
 LkUSELGWNrkzWiAv1dnQk7gSByiTmoziycr/k+UO7zqf/8DqB9AJNXT2L8y6wT4j/AGtPySwruq
 VjOwNU5CFGg6r279EO+YGdGzMQViKlUcymtSOfebcZu2Kylm/uyZHbWAQgFKpsfo3Snh0md7STU
 APPgycIQDNMy8zLaCxBBpZQflzQWjZZUsNnuvm49NvHwZk5OJnmAGHBXL26g1eFDpcCZ1tpf0h9
 txQe2vk0YEy1jExnyEpPtxbb0bAZQJrCEcHq+qbqQcF4J+4Y2AWDqraBC/TGar8QYjKtdyl0u1k
 NBuMTrI57ICP94PGjWd0+aS+8vO+NxFIjzyZYBcHhnp7O+txouRqVNbZneNB6QHChIVhRYw5AOa
 UCc0syZ/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_070956_007124_3CD10AC9 
X-CRM114-Status: UNSURE (   9.75  )
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


Christoph,

> I recently ran into an issue where the PI generated using the block
> layer integrity code differs from that from a kernel using the PRACT
> fallback when the block layer integrity code is disabled, and I
> tracked this down to us using PRACT incorrectly.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen


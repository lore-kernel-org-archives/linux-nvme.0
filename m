Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0B39C71159
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 22:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Date:References:Message-ID:In-Reply-To:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RI2FvxHXVg2+XxES6SwhQQzdw5XUb4u1Ajb5k4CLONU=; b=yiWlxNhyKmhMPiKSBdQCcY10iS
	v88yc2Klw3w1opSt4H5mtc+2cBAMFDoJ0ZFv/SrEbS/S53+7kxhcUCZJcVtb6cD6r6Kd0KkRd1n8z
	NbTOw7sUozuaNDEtgSRHrzA+Vtap/tHp/Ny67bSWS4Db7Xv+EfyMIv5OunvxKuemEONQ0ppVOdnu9
	BDZ5OYWOaNqZXI4jh6haG9V9CwvfciyXQebiPaDgFMuwZd8NMjUOFWfEsQKiTyLri0RIGTFBUMgKK
	5INv6AZ5IVlozYJ+LHyyGe7D8QFyNLmS/kxCoP79tC3rGvPdlzjSZsKIw5dayP4fS0npYNCUltGYC
	nZQiGLzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRIFw-00000005gpe-1r1V;
	Mon, 16 Jun 2025 22:24:44 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRHwB-00000005eeQ-1hcX
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 22:04:20 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GL9P96027758;
	Mon, 16 Jun 2025 22:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RI2FvxHXVg2+XxES6S
	whQQzdw5XUb4u1Ajb5k4CLONU=; b=JiHyMiUkybK4VKnxZafIMdfKTl2vyWwn8I
	TxC2uB+tjeFMQvDTffIroo/kxNgg7PW+p8Zr+X3ZR7OnxQ1YXi1U8LHOTOESPR3i
	6tZfIY+yY9VqHqpdgyCG45hwGMGNVIOsD/67jJdaWlbxTWhyHgtRWbauGWOOWrdK
	zQaX9dc9nsj9tIJfOyh0YSC9ZV8kR+F37a+v39OtMWVROTBPY3L3looMVu9+GwO6
	+7qCl6msaA2EqB0bXrHvDpf5mIZtURQIXmgzjuDeCODtr+mQ6HyjyK1kXHlIpBvD
	2ivIPCGE++XL8bqvwrWgmzbxPJcJmKimsACr1gc60QsPPQxaF/8g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4791mxm4ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 22:04:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GKwKeV036271;
	Mon, 16 Jun 2025 22:04:11 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazon11013051.outbound.protection.outlook.com [52.101.44.51])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yheywjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 22:04:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQgU7WVwQK/X1navoCj8ocJkbODQFTSpPdLKzw+wIGEbn3T9eKNCEg47iZSSFelcidNLwxOltZHPieKi5F3SQ0F4xW7vHkC0o+ZQG3bskjtqHLUJyMFti/4YA9gUis1SRlmkZ2gpc7/2+v3EIKHBV74T9PilAvknoWTuDF2pHPKUM8wIWI/rp3HjfmP1vglvB/HteoGzkmCFhpXepKejKpJm5c6qz+qdkXldHTdkYSzO92inqd7V5oONX38TB0texA09BzblvOke61+QGv8Gusv0vGRtVhLWYiUrMcgBVx6jFSEfCrnwFrRQpaUdTiFMMZ45KRwv1M5Ma0tzBfwH9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RI2FvxHXVg2+XxES6SwhQQzdw5XUb4u1Ajb5k4CLONU=;
 b=Pn6PgkjsEioCDFHlAUXg+1pz1A/UMRRU5g9ugFxFu+9nVaDHFP86D8e95AmunfWmXTK+rQN7zP9G3hZA3w66xR1+6qsuOK/Zj73cvcT7Hcvj+DMUpWRkhpX3o2+04PTyUCkQ1Z/4O6fcQ62fTJXBJwCzuQycrHbO4qWEd7Si/kOHfy4/ieh7un2bE58IOLWGaM4rLMKRbXWPAb95dkh02HV2N0GAzUZNg9JPKyLVweDjiNG1TAycuKEmIWUQ6mh3fWqh/FQGY5VmBv8M4/jCuR0oobh2VbCihPRmf+jOwJkZf003/ZyvKhMlIbujjJeZA7Mx+LsI3/gUtBsTf8QDyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RI2FvxHXVg2+XxES6SwhQQzdw5XUb4u1Ajb5k4CLONU=;
 b=JDa9Yb8YzLHG7yQlyqznkS12v1LF9aPA0N3wF3v9ENpmIGwenEXGlq9gZyLPoicQpVUlBqeiQABnYOFbPhyGtct42rum/tKzuWkCtWLPicU0wn+wLMYE0x+RinKwmjJLZeaNVK1t9tvVDJT72Mu/LYEwwvCGwEyd+WCBML1R4t8=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DM3PPF0900B6F69.namprd10.prod.outlook.com (2603:10b6:f:fc00::c07) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 22:04:08 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 22:04:08 +0000
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.d, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        darren.kenny@oracle.com
Subject: Re: [PATCH] nvme: Fix incorrect cdw15 value in passthru error logging
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250616181936.2094176-1-alok.a.tiwari@oracle.com> (Alok
	Tiwari's message of "Mon, 16 Jun 2025 11:19:29 -0700")
Organization: Oracle Corporation
Message-ID: <yq1tt4fxs4g.fsf@ca-mkp.ca.oracle.com>
References: <20250616181936.2094176-1-alok.a.tiwari@oracle.com>
Date: Mon, 16 Jun 2025 18:04:05 -0400
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:a03:60::29) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DM3PPF0900B6F69:EE_
X-MS-Office365-Filtering-Correlation-Id: 38eefc29-ca50-4d43-d041-08ddad21b73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GLBG3bY5TY9p0e1uGjT0puaD973sTvBCTdMfeZOaA9D6p8Q3vvUBw5q13GPF?=
 =?us-ascii?Q?bpMRlxRs5Nc70oUVL7KhSItrAQEYHEq6WAtUnWdMFahj+BMfC8a7DEjmElHm?=
 =?us-ascii?Q?JU3Y/uZXWRRCMiIXMZ1y0NZ9d9XAYr33Ef9vW5iUYaNAWi3XpbrLyx1LcoNU?=
 =?us-ascii?Q?8fKeSZMSWLqLVGzW/lYf5S+TIjRnbZj/0YnMjsac/iyH6KiXOsAs5pOUiQPm?=
 =?us-ascii?Q?CNlo/NiojYK6NVdqvsmVDTlmXxr9e0abbLi8vRZH1ExKukRJMv9w4Tlqn/Lf?=
 =?us-ascii?Q?5cUMmmPMCJyHluptMWWOExaNZo7sIRqQZvwZQT2NMcmHIP+ZeDmULKFd8HpZ?=
 =?us-ascii?Q?KQq+DTjiDwuut5qGIroYA60NQaxYo2Oo/K+XddUsZlNm86+bfM83bWdgL65r?=
 =?us-ascii?Q?lzdeLba79BSOXVZCeACdcmHVvG4XM6sCfyd1UDgoyCCuqjhzE1kZTEKOVxz3?=
 =?us-ascii?Q?kDSAC4e47sgGn9pM9CQNN0xeY3n4/sitMaZk7uh7+/SAoA1qmn7dzQuV2KEl?=
 =?us-ascii?Q?oHGCAvzkC9vGLaWu9seNHW/3YWKEAbANQI3/vtSPTxK1q0yKLqC8ZMP4e4Td?=
 =?us-ascii?Q?eF4Bhag9bGcODKfoQFm/MuwMgApOc/EMegvL4QUboZeNt150OTLzWiA2UwND?=
 =?us-ascii?Q?pBgMBjfvXzIwe/hlc5Ho7XRWzY5HCi7EQVrDKAuuhPl8ijYePNayvTApuPIQ?=
 =?us-ascii?Q?dMu5sAqy3tMQprCspGHxo4a6dpNHGmxW2VrXIjAS15rd+qZ6FXHLHDbdKev3?=
 =?us-ascii?Q?JgwYPpdOd8YJpLDtKcJqmhr1DOI/dmEt4uABmg/In2wm1xtJt7NYrTh5m/lI?=
 =?us-ascii?Q?DOgbHR9LuIg1uDZw5UmdTsdCTvgFrJBGe078fACfSAeEcXHj3dD6C5xJKNu9?=
 =?us-ascii?Q?5RY6dGp69YQlkI0/GZKZYAQYRV1ZXx5iLmBgkpWO6XlZnc9pYtHsuUc8ciCX?=
 =?us-ascii?Q?cxwYiklN70hAQlX53dtcX11V+TMeJSlICKuhfdknGlYB5Qpc+EESp/VHp5A1?=
 =?us-ascii?Q?MgWGTNyVHySKbLkFB3xLr6A2ORtFmJ1/JQxHdfhlmRY8JelZR/DNM+3RGUm+?=
 =?us-ascii?Q?JsO5y0VMvsOVFL68WseG109uOiS+099GMjju9QQR0JWwCXEkMSnBYZKfyjr6?=
 =?us-ascii?Q?zK77gpi9qwQZcE+tu0J1ke8vblVw9dSS0FNpw2t5ZQc/9Xko2BI+aY+9Ze73?=
 =?us-ascii?Q?QuZ8qHnFAq25RJjFcHz0EvUf1UrjwSqPiho2Cfl/LJw5xdvYittl9/YAFeqa?=
 =?us-ascii?Q?+x/ERfIynKPeIiGCkX98CFtloAZe2mYqnq74pq81uXI+nxR6azz0hbsSZdzn?=
 =?us-ascii?Q?MqIduMiwkkVFKyBRkvh30MohyCgINhEbKV/aW8aHJGYPlXzM6ZW8bV4beqjZ?=
 =?us-ascii?Q?933wef06L8bsFNNkwxcQvMjroHQSVLt337NNN/fCqleldOoLAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tICW8FJawDL6s59qndqU+e6eO0Hx2VCmBExSLbx7PgND01J0+6pi7Is+9JDV?=
 =?us-ascii?Q?dOBOcP1ekULYb110nAGZMQXDJAI1u4YheEhvbgFzN5vjiQMaq2EoSsaT7ZNh?=
 =?us-ascii?Q?ZbTkqXEyQbZoJr99gwpvCpVC1qiaObKF9U+hvX1FsSaAAI7UDLr4+upJOMcJ?=
 =?us-ascii?Q?RyY/Ol17+PYK7PCH9RZ7zRjTVZGqggIik8WHkDd8hi2FqJPzLPJE8TQIqxI9?=
 =?us-ascii?Q?VFrVFwYrqbB9hfLloQgHGMGyIOAPArwyCzDZHVW7QGG8f3ZVCfU5lJJ3Jl0Z?=
 =?us-ascii?Q?K/Z5GqwBoDWqqPBYPlOcZeMCkc8v2/8wIikIHf/Hd2B/fZ9M0YQGf4PumYZt?=
 =?us-ascii?Q?wWVJeWu6F4ePvMNc9n8lnTsYh10pPIlXamLKK5m2/oHaknAUtdho8X8kYxIX?=
 =?us-ascii?Q?tDhMhSCaI8w4Jo5i1ExX8pz4p6VV2nIyCh/r1ipAsleXPtY13w7W/ol+tN+W?=
 =?us-ascii?Q?OPIbiiHkvbO8w8VWbh9NxnBOkQjRrYkvvAj/i+pP9+/DLSkqD9vtbqU58+w4?=
 =?us-ascii?Q?zLIK7t/rHzJZqkXgsPvLfXUxjFctP+6t+phFc2E9zASu1OGtBdjLiVkIWIpl?=
 =?us-ascii?Q?DPkWe7mqD2x3C84YbMDFxRIC4OS1KU76l3wnpr3Jq1Co9MsFBC1aYKuy4ndD?=
 =?us-ascii?Q?xu809pBSWH/dTrXEZ7/SK1bb5oI6zQ9hqfQPeC0ePVvO9jUdA1HPT3B31Mod?=
 =?us-ascii?Q?eNdHNyNdbxIccERT4uTUR7kpc2ggx8LvUOjMDzdWutDDvKzEJuqrT87rp4FI?=
 =?us-ascii?Q?qcCY33ODeX1e+Zwy8uUxxlzxkB5etnOMurZRdxOY2JTrXeB0mDQWkUOzXeiF?=
 =?us-ascii?Q?y57ljDQ30Buw5vGYb43NDquhgKxVZ3sHR+pjuoAqr9p+NA/NW/UtW+zkGyM8?=
 =?us-ascii?Q?Rt/oIXbWNfoyPmLkG1tJ0HeyWMbnWYn7BP/Oz7/Aq9qrIKojvtN2Je5m1YR4?=
 =?us-ascii?Q?CmBWpZDoUe4SX/484FCMcKF9xrwPHE37barcCUzA7vMTh5i5ho2pwAcaOrMU?=
 =?us-ascii?Q?9QqftAWcGhd6uCCGVxGbVDHwVUWOxcCkluGsOR9GLiJgUlzLsc2LtjI4BCga?=
 =?us-ascii?Q?NSv+4KBJ79KM0OYHFYr1bfxGOJqQj5zKQa6dfpCfJ803cVH6vHbYBgWCjsfM?=
 =?us-ascii?Q?wPeLDPPI5fxkTQi9isIdLtd8PaTDGy40GoQb5RRZRjLmxJ3i7D6lPR9k8Vmr?=
 =?us-ascii?Q?4q0Zr0ldTqelMWRi4IqIqh50IuyXKxYwqqhtiblfMtjLSvePQoVfdiBmOcse?=
 =?us-ascii?Q?Yy3BYfFOU2Xcl+E3UyBqmreqjqGZG5kuimdRI7JwZl+dtaregxMHy6/6qig9?=
 =?us-ascii?Q?i7or/MvMK16FidR90h7pKjAQKQsNQXp8D0aoTYNdDOz23ZiW0qlL2yDUxUAz?=
 =?us-ascii?Q?yGsW/wnx5wGC/iHHgiYyrn8SqwvqEfejLH6Lup7w1X1J7KvDDtwIH4E/QRB6?=
 =?us-ascii?Q?poZFEyBEazqOprTEAa9dmk3y2jRf/TKr3m13u7OrYl1ug91o3hRy3ns9m2kL?=
 =?us-ascii?Q?eAQBTX+EsWwe2I2vv5MTe6ON3Lt0bESfOC5XxQVN/iTTV9wSnpPu4f5LDIUE?=
 =?us-ascii?Q?hbe5nY0KBpNQaQlOFYspHF3iycON8bY+MfWpy/qbPLnmOXB//4RGdilsWobI?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oNcED5iNZlAi2wE+3wMw7qutj36L3NhOedgrlQTjgR1B73y3pUkdn0Lxb08d39Ty6eqZCCN0kZo6dtdMEsSitDXT/zt0TdlbFLDsK+AtFeOzf7F4PfJgrPxCGkK3sGhNnQlt7zu+NQZAAflawXawrdUjHCtWSGNC/Bv+aIHNtm3GN9KSv9qfORAgGaAnqvOkVs3eCS6cpqcv3IasQCv2FRmoLRN3GoIDKUhmfgnhHmi1Ga/Q9CXdpTFXXA+MbvjiAnP5MqlWh3bPdz+dRNjsoG27j0+VKN3QOX7eOei9w1dl+IuyetAa5YSToWwHYw2xKfOmFDUf8SPV5hfFqT5WM8Yqx2ZvfQZpyo5gIPHlEqHopQJAfrrpMokaYYxjhFaImtu93NWFQQGRHAXPFPFzRC9B15Slo68vzdX0auI8BRLBKEoJy/aVTIQNe/qJSsZOlSxClGYiJxMW1zUuBISAhpRzcotlA2tjpE0Lsou7h6VKANMg1epMLLa0+7Ak7pm6DAndy8kHWiBcU5qOPpbnt1uFblF/6HjfbHDEdKkeyDOgizSaiXurG53kpKg1/4mTvMGR7UZ4MkVeojnKRLWJFR8DM9PlNLWkZkFM5UAkdoM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38eefc29-ca50-4d43-d041-08ddad21b73b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 22:04:08.1988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4TmdYBMUD2WwTGS0XR41InmMS1YWHG/LfSSnJ3CBhYstnTKI2ixxAFusRsQWH85Tc+sGqOGCVb6n+LHmLoBCESu5RF/p7NsW8pbWZ/S2Gd4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF0900B6F69
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-16_11,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506160156
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE2MDE1NiBTYWx0ZWRfX5XTR+J8B34TD pPX31T3Uy2d7smY0QKKbTbAuKCMAmGdvcB12YsbCSroZ4fyu4g9yOvEL7chsGXJEiMO+bAtWAAn ZGLMbT5gEcOYkMWBbCscme978BsYz0IDy8w44zH5wEISupDfoxfpx/PQ/ltZkcZv0w8/aJ8qToK
 3xDLvcIiSrrQ1MBP1Uvx/EGzkYBQUlWQ8Oe7ru3HWTrg8Q+5OfhTCzvlV2GbTwCL5aaoTUuINNH RLGI9aQY9kPH6jLO4N2tJOB9bZHqIB4266qQc6/JxqFJ8Ev+CrMs1tDFJU9VUZaszFTB5L7z+Jy f8ySHP/d4DJs5WqeQLbXbsye7ujRg3S8LWy6h2Yu3z9SQ3KzEEPbzPs3WwdaCCLrNN2GRfMNrQy
 7/hUV31OJ6B4omQXn/nMIOLarG0+3YMLQC54rhoVN2SPrIQkZw/1aD4jKQm3js0XR/0z4A56
X-Authority-Analysis: v=2.4 cv=HvR2G1TS c=1 sm=1 tr=0 ts=685094dd b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=4bZp3BK9bK9TBMACIDUA:9 a=MTAcVbZMd_8A:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: 0eY1CIF2pAfnJQJWQR3-iMbCuOANShON
X-Proofpoint-ORIG-GUID: 0eY1CIF2pAfnJQJWQR3-iMbCuOANShON
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250616_150419_451414_2EB45CC1 
X-CRM114-Status: UNSURE (   7.70  )
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


Alok,

> Fix an error in nvme_log_err_passthru() where cdw14 was incorrectly
> printed twice instead of cdw15. This fix ensures accurate logging of
> the full passthrough command payload.

LGTM.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2809AC43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 10:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+CrH+L0nJSdupyGucCO7g8pcyMmvaL9xlqn9IeVRZro=; b=LQD5AHK9M50iXaJeYKQxPrMWC+
	LAJCcGUS8aTSwDrjJNTHtTUf+uCntiY62lc1tC5KXYpeT6lsOs4N4qAN+M1tp9TovNbXqZgHjF8kY
	0EGnfZwtXjAaENi5STvhQxi9ed8OcLnw3FVhvBeLI6DEjaaboFfqnZDWQ2lUEOCr3uNEWdZVCrpS+
	npqd+wTtaVlr/LKJxL+FndaZrU+6IY5d1ssHRL50ywAqCB8SubqTiNKmlgOVmvimW2rq5ZKiuuF+p
	UqfPKKW7XTwNJzh54pjPXVUoX57XG1fKzGRRYbCfqTtz5STr/DGc1DF0c5Fpga6SoBOZTgQvAdp2l
	qkanTJSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjE8C-00000008uzw-1HdD;
	Mon, 13 Jul 2026 10:43:24 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjE89-00000008uyt-2Zjy
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 10:43:22 +0000
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3ClQ2476009;
	Mon, 13 Jul 2026 10:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=+CrH+L0nJSdupyGu
	cCO7g8pcyMmvaL9xlqn9IeVRZro=; b=Zilh4PrLc9YMbzqbWHmux3UiYXK75fmO
	OJRDF0gC82UWpeCOg3SN2mpJIURlQpACZzbCmcXoDkZBiMQHnpPi0fAQrDDDVYcp
	NKnrt2AKzSENRw8wK2dqQaUKxN8kaHp57+oaoe0ARxCF8GGQPj/2CWLam7OISevy
	A0D7JjBfZsCj85O5aTHJCxDE5BE9EeUK2pB/6R61FLpY7bsvyi+SuETQe2XRDg9F
	9EqD7KPzFFQLXhM1bPTm7mnEAp6I+190f63gnNcwv5qbFxNoWQrSaPRp6VVUvGLa
	sm96NxbF/Z5i6XvaaNGWQm5UaRgW28uEU+K+5A0cmnpAB8gY2lyakQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbeh61y79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 10:43:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66DAh7M9014722;
	Mon, 13 Jul 2026 10:43:08 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9cde17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 13 Jul 2026 10:43:08 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXATMy8yniNBqicG+BbdVG6pWNrOz97EeEtIrT564vt0z0IwF6fC4rAuzbJWDW4f77t0AcCpewBuwSdoUx/PMIeuQYsvhHgrB5esf/OCmqFeFxwljWVo+A5jzYDPoSuHlkSw7iOkuMX0IY7xLxYcTzr3NZB5Rmj5PLzTZK6fIc4rQgM/TwB0Y2/UdeDClFNn3AfMNM+zOUL3TmGHKJFyV+e+KGfPxR2yJmeoJ3gXohkRkOYKw7+/RFWagEFKeK7axzrKc0duvqLbgqllvTFq8Vb02IKZQLc2Stpdczq5xA055wj5SF1M0EHN3uF7tSnSsC2eyP2idd5bk8+5F974gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CrH+L0nJSdupyGucCO7g8pcyMmvaL9xlqn9IeVRZro=;
 b=dQogM4UD+KCPYmWBIVNpm729dnWCiZe8s5Fpiar57/gGmTe4rD4osNk1+E0e2SGYuaxHOyiE47rh+zYRFAqkDHeEjU5cWlIGPdbqo+Jn5uZMyARs+1r7olM/I8Bau6dd2xxapow/Ld02UPHA9FNYMAHshe/0KybTZANDVkFHpqVTzkELb+Jht1qAGR10TDArtJU8Ye0yCfulOFgDhMLn74VAtYCHEY81LaszMN6ECmAuafCplvS673/TgK+OaabnJs7yaFHtXjs95+mi+kgWbXhjSb/Bu4SN7lsrIexGVpZlG2iDTY6Mv5htjIT9uPtETsHyFymOG4Njbd4JRhutHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CrH+L0nJSdupyGucCO7g8pcyMmvaL9xlqn9IeVRZro=;
 b=ju7KOR6GoJiNAhkoMC3OzKCSBjkLlEylIeXT+ok6lnuELmC/7/N/SWGVZ77XKD3vW4LFXVR+Lh8QCJlj81wk+26LP1uw0j1zO7S+Unq4284JKA0lDSyk4WDNlGmyxY0GmQCx7c4X1NXTrMWk+sfN+0kwL4Ts/AQ7TADaY86sNP4=
Received: from PH7PR10MB6228.namprd10.prod.outlook.com (2603:10b6:510:213::11)
 by SA2PR10MB4491.namprd10.prod.outlook.com (2603:10b6:806:f8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 10:42:50 +0000
Received: from PH7PR10MB6228.namprd10.prod.outlook.com
 ([fe80::11a9:2dfe:4a4a:a58d]) by PH7PR10MB6228.namprd10.prod.outlook.com
 ([fe80::11a9:2dfe:4a4a:a58d%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 10:42:50 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: linux-nvme@lists.infradead.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 0/2] nvme: fix cdev lifetime series
Date: Mon, 13 Jul 2026 10:42:36 +0000
Message-ID: <20260713104238.3034640-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.7
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0145.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::30) To PH7PR10MB6228.namprd10.prod.outlook.com
 (2603:10b6:510:213::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB6228:EE_|SA2PR10MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 424fadc2-57d2-4cd3-3024-08dee0cb7c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 6xLQM5VqwnIitx8koyQEB02VgBRNtzsS8dNQ31pEK4YodIaAce9cbWhyRsxpswR21PuvvJ+VfrglzJlJ/nWunPRm/hrYwEM50GZVqONVkkuQ4FJNdup6TdLLxKvcnWRuA5j1SpXz+QDg6j34oiMhMQEAJWpnuLYpj1j5UhpM1Dl3WXSQvOW3CfWwRwAlVDCBdxLPkjRRTI3NCon1GS/wSewSIezfEVfYmf98VRdrXTBJau8yrXzXJTvYsEM0plHG3SmDWLzXn21VF354XAF9jrtbvTJLQKTnkUcqCcUGWmZTu/A0L1f0F8aLg2hV1Tsuy8PnvXXs0JlAFiVPChB5qRWQgsc3saAcZx/y5wmR6A5YnIDU2TaHWVvqbnv6xbHF01bhp6T3sLtcwkI1m80QrZDKTUsJjZnOPpd7S5svDyDdeAHy2gMBAXKk3M5VZtHUpvHJFhhlEKIgBgxPz9+dYCFDhfn+uHmEu+BmQkljqRDiF630bq47738rhIaCEPJmUrBhsMHXFKWRMzDxZn4kj0+dT84qRUIhI52UobIJLlQBVBClmFilcg9z2SHWvqnCrbImM1NsNq9rOnhR2z8dtcQ6Ax9JcheSJcx5hOzJWPJWUG4UDT1ZUUkgTbvSMg7MaDgrZq/Eq7szYo9DbAwFxG+pxuZUNLKUnZW8XNCGtbY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB6228.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e6QdPo7PPyqXwCv0xeFPOlCo5DPaKlZwhzzrsm2Ii58IbAOBb6c+xYH/3+cL?=
 =?us-ascii?Q?C4G5+CrezQzyPq/oJ54hKPxjCLhAzZoxTviCGA7btJ0pNqEvvRgtZ0hZW3aI?=
 =?us-ascii?Q?uWUDWp2DTJObioeitG5s5cwxb5u4aD2tZRLTcecFMjtfF37vSUB5cm24tNjv?=
 =?us-ascii?Q?pVso0zU8ahLqDws8flBkR54ccgCfb9I+m7XEgwLxGVEAw2s+FAwGw3hTT66Z?=
 =?us-ascii?Q?FBNd3txlPD3ZUESXi0poPqlBlCgsiMlpAB9XGP7Iwa84cP5YpGfeM73jMqZ0?=
 =?us-ascii?Q?HX4VBAE7+i1gKT1jpZgQ5KAIbpPXdCRu65yb+wQJHv700Jx9TvLiXzPn5JrN?=
 =?us-ascii?Q?KPk4/qZWTnznRQEmGo80ljKmi7ACzA1lmVRnPGMFEsXHpy6x7eqpT+KPk22y?=
 =?us-ascii?Q?uT6ZhJ3T8E5kFm/6Lz3unu8PAlMgd6a76m9BStRmPm8t+MpW3O5tFu/Xu2vp?=
 =?us-ascii?Q?8g2XzuciR+X8c1SZka6exD6FKJQcehfVss8yFSUG4vUe1zix5dMgyx/0ZOb4?=
 =?us-ascii?Q?SJ6TEhRjKc/MwYh0CFhax/bfXuLDP0k7+xfIoidcZhHWCEL1JTF54rJVMg6M?=
 =?us-ascii?Q?BghoadB6oBsPgH4UhCaay4FeY86zem42Ocv+jbeaxH2+v7hlGQCtP8jztgbs?=
 =?us-ascii?Q?S1+3eJv/YMXh8XDpy4lGkDYjfB8raQhLKbY5GKGhNV3735iGyHjxe79jk30X?=
 =?us-ascii?Q?Y4QduWYs6gQovA5QR08f3XSdf287uWlqXEL6cz/cAaqnMN6uIQDc4ZpOKa9B?=
 =?us-ascii?Q?Yq+ED6ZThQEvKz7pH8OQf6/4s8nrazVZh7Y1P9PwMttO0c5rFO/PjC65siWL?=
 =?us-ascii?Q?Y40TERnV/Y3doyWXkm5/4+OYZYUVTer8Iq4JB75kdRb7nbHkYUCnsDVTwhPM?=
 =?us-ascii?Q?1vPDkABIIVs/WK2BjpodNBVfJCez9U+pYJIN7OGPo07HMWpaiBRb82hZ5Bm1?=
 =?us-ascii?Q?NhS/x3d1KFVFdV2naR4qU7bGfzRhVbEXYB7ax35LMbahYOrdyi1iwqrpijFh?=
 =?us-ascii?Q?ZSYY1Uxhax/bdnffM3sa5YU5Tq46+7t7eMGDWpLPN88XnGr1liYJVYQNNrv+?=
 =?us-ascii?Q?ShvS6tQ7b9pfUlOQ+SpU0mW9OPpv2qMYtsMli/b8mVltIm1L1FJcjO+5XZnx?=
 =?us-ascii?Q?E3sGE9vfvu/IgpBHpLRZa977Q2e4MqNmrUppljz0CGkrGJGycYWubmu0K43Z?=
 =?us-ascii?Q?Xk2kxCBJbZCsEWmKf5zWgN/AWDZdVKxUhD7nmRUYFCNuTGtJ+eQ9RG3LN4BP?=
 =?us-ascii?Q?25iouJYFZBP5HPFMZg120X/tuBh9JLDU4acrebmKlTarP2elMqbvBwLTEyya?=
 =?us-ascii?Q?7i+O79Tl3e7wWrXcOqw2btqQn7XmmCnDUJkJ35AnuPFwFFutqIqG7TkWxozx?=
 =?us-ascii?Q?5iHSiutl9G7DnO4K9qK6hGiDaqvxB7qQ6+Xq38Sl7T8n8ZSx6fC3ZrZTd1XX?=
 =?us-ascii?Q?CGqi/xSjy46tqXi0wj89BeoryEy+rUqqBn7JKhieInjP86RyfHiVmI8TPae/?=
 =?us-ascii?Q?cfgstEMhDpNRNxH4Z1FX/aSyJMiQg8FUSWDz4rbv95d9pmejauLjtsg59Mz9?=
 =?us-ascii?Q?Nt/vhyf3FmP57O13UtmZhYd0Y1lRCGBn6UMjiascQsOoBLq0Vx3AGKtjXp4Y?=
 =?us-ascii?Q?+A5ci3Puqn1KKzmP64GzgbhVeljgO+oRgDHQ/amQHG8UIw7CV1w6f087aKzv?=
 =?us-ascii?Q?eBigYhnVgM22/JQfhzGtdEoa9i5W8DHOf79h5fTQRSfyL3OEGiwB8YKBsPkK?=
 =?us-ascii?Q?fesTmLBsEw=3D=3D?=
X-Exchange-RoutingPolicyChecked: km8N7dVFfRZkg5NYMtcvbXtDUlQASz0UCC0o4rMei9mKdD7pVlXtEP6yF4pW2bSpG10Pi9IymsS9UqJjLa9Ic7VpQ/wp5JDUNk6zDbnhykB2EIUxO5SXiRJUHsp/iEdj0tluX1YWlG+6Ks9MIm8tHeXG7dl4EwfkVP5VFHjpV8TyJ+LKCGPEd55zMG68LtVp1iFyAxJzvy3aLXfryIcHQ+tVHNWEF60VeTdsBMCAv8VQvwfHsFz4iGBGZ61R8t4G5fTL5AnZZ8jfDI9LWq5qt91Oh3hjtHxuNIDlGNOH8Rj7Gs1K6kU8uONp9COuqClq1QM2tJzltuRODa4iusigPw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Cj6NoKivHLXXQr7K78hgoz8+34ZuUwPaMv9wXVv7JdrjwJCyp0BGG25z9R5DlVtEVcznPX7izN1fIb1zw8feim7RpHHeKqMRxC33JEEEEIVZoUCS6howJ1aUKKqHwyHp7sReG/NrO4ga8Bb2gfTHjOm5RimEopLKnc35g3HeUlf/fvtf+208/Z6zhkfBlliVnrkxssaksbTFP5dd1TmDsoVU5aTRhQDIDMwCXp+NaqX+uUkErG30cFiTb31IvmPkPI8MTnAN500o3kR/lKa6Rfk567gF1V/pBJrYX8lAnbjU7w/mVz8zwdTRqwSVLOocrTrft+6Gp7tKGxL5Qzn4XwjqYTG8PFWFHHgM/M28lvYCcPNV/H/DDUzR+LE4kL8OEehKuRF04vdqVB19S6RES3Wwr3Cw+gGCHRhBE5IfZz/bX9yV0s8vgc1fugxhmeANeCoYkFlK6grpCoqOQVWbYbV72Sw3vQ9fKflBhqSCU9g3Cc0tYN85mER7AcKjnRmoI0TQZjGV39kulwZJ0kBMUe72Qm6LRHNsNP9Fl/tzZht/xBxfeQlE9sKgal594UTUJjB5P3CtDiuG3NLZCkUkpIx5v3st1eG9tUoq9zMD7CQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 424fadc2-57d2-4cd3-3024-08dee0cb7c09
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB6228.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 10:42:50.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /DWE2hr1YmPmNZdmooxPevJFGMGfSmpPFdAHNR0nJFqM0goqHuC3E0ukHOXLMfLpk769IRtREnhFt+Wir294BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4491
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=800 bulkscore=0
 spamscore=0 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607130111
X-Proofpoint-GUID: uJqwih_dp-oz9Aaiv41GJM1z1aQBecnD
X-Proofpoint-ORIG-GUID: uJqwih_dp-oz9Aaiv41GJM1z1aQBecnD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDExMSBTYWx0ZWRfX3gWbMkllR5vv
 FdvMOdAnRv9GpvBmWSTxy4Lc9KwOtdAeWUMiaX64EZdY+34fLpa6zprIKGyap9PQLs2G6y/WyBb
 77Z+1rM/rVXzkBEoGmF9xAhPoN+h0uRjXHMStnicD034aDvxDDSI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDExMSBTYWx0ZWRfX6r1R8M2RX5JD
 /zXGp1sWY0NuucLLnVbsH/HWBrQHhqPvjw6w7+R+RuccgNflo+7oLZP+5t1cLteFZA7C104YBGP
 9VehJe1fWSv25EXRN3psesvwHIQ3CgQeh2WcC88w8HtAd78+CU198FX+ebG8lxeWPdtZ3mLgP2/
 DHwZ82i3GSi9l5OtDO2VvKxN+7xIfV5ApHjNSx89Aki/cU8BuP7PEX0PMts7sxWj1XnNWBmdT8o
 MDhtyMiULoTVJVAlzGADg6fKpBuQjLHsAqRKteuweYvjpnsk1z2lJ9LCcHhpWcDfW/Lj8eU6QqL
 LhtzuYAn6kKfEMgpLuVOeitO1/gyvvjbd0c69Bs1bsZPon7DOfrzPNu43Ey5cxL52VxXIcV/UAJ
 v9cY8ghnB3Tx+b/hlKIaqJlq0M4dChMgqVIB4Ncl0Og0v+sICgYAwf/x5lzX1yLo/egtkFzY+nu
 Mo2lgK+SKf0znJ8HOsQ==
X-Authority-Analysis: v=2.4 cv=c+Obhx9l c=1 sm=1 tr=0 ts=6a54c13e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=zdOOC5GabOVT26e5YzsA:9 a=WmVTiCyuxqgg3mnwYu6p:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_034321_851741_375E332E 
X-CRM114-Status: GOOD (  10.09  )
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

This small series addresses a problem for the NS and NS head cdev
lifetime.

Difference to v2:
- add nvme_get_ns_head()

Differences to RFC:
- common release method
- fix NS cdev lifetime (as well as NS head cdev lifetime)

John Garry (2):
  nvme: add nvme_get_ns_head()
  nvme: fix cdev lifetime

 drivers/nvme/host/core.c      | 12 ++++++++++++
 drivers/nvme/host/multipath.c | 24 +++---------------------
 drivers/nvme/host/nvme.h      |  1 +
 3 files changed, 16 insertions(+), 21 deletions(-)

-- 
2.43.7



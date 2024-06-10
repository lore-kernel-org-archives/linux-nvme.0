Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C03C27C55
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jun 2024 11:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Date:References:Message-ID:In-Reply-To:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JVQ1Iux7PDvaudru7qA3HwN9NtP1SIhjJ9DXzhts37o=; b=4d0WucZWJId1Ia2Oj5DQOUpRmE
	OKEvijRbH8D/Z9ZGCwUp7fd0j/1Bpm58g74aGwRnxjhpgr3FUIokKgrSB7LS2/dtRAUc6gzKMX0a2
	f7VNcwXGtG6zP4EfN08v0ysXolZKSB5TDhOfkJMcm65gmRGLx+D8PZHKXPVHmtpRvM1Fi2QprfT4B
	7goD5btZtV8WVj4bjJP6jrYJrf3+vfkcfdjhmhmVzipvC22K43SsSTyOvbqbP3EZP6/8MbUX1oLqE
	lbdIkodAAz+16Mwbn82Xsm7AI++1cFCJO1A4Cu4m4bhqmxFpfoBCK2YGMMoZ4aCUFlwrw6q2B1/Ft
	xQhwQBpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGdBZ-00000004oOa-17Ra;
	Mon, 10 Jun 2024 11:27:37 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sGdBV-00000004oLx-2ww7
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jun 2024 11:27:35 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A4BmXM016372;
	Mon, 10 Jun 2024 11:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=JVQ1Iux7PDvaud
	ru7qA3HwN9NtP1SIhjJ9DXzhts37o=; b=BZQ5iGw7KSNRWVCvLvTqZNLRvIrJcJ
	Q8ckR4SSVJityA+mdxeWBACRntyEVzS2ZhWxidD0N/5nl0cg1rmQkrlI4pUZaq2e
	/C/QKsBefkNvMjLudhWeS63VMeNOfQyZkE7KbqABy8PmlENc19e7ny4dkmZSK2rn
	W81JsCdS4SKfaMHzce/iF5eu6fdco+SrP6zKMSVnbQn5dedz7GTR7rVFP8whG6/J
	61qKGGSw+xoZQNqagY40lgP9zOrsG8NF4jhisngB9fY/IcTVVDRuRecAExEpkJya
	+fx0lk98YrnWN2v492tSzaLHIO9GRPP5Yha2XLlT8Pd7tOURoVlrxh7g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhaj2ar7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 11:27:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45A9xOnF014235;
	Mon, 10 Jun 2024 11:27:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncescgwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 11:27:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+YJFsytC43iICk8F479DOfwQoPWLGHU4EtYKi5vn729twpshN+cI30qhtsSgi4jm6PwU3Kyaw6W5VFupzqkYE63rJQCHtCm+eq5OlbppfNZUPLg4xHjZ0H0YdiMYNh4cEUQKLmdVsm02cR/5dQoisry203qfLkDnOzLaatX+jmFXWerozbUzyHosp2qn1lR7GIPiyiGDHatsYtzJF5PSh5fkUlPnEoa3XvSF/yrLNRwDDp7ObzMELN6tYv8LT6T7F89DlP+1QWuawCzccugvFWWOMkGMN/6HN1/AZHkPCU2Ri3oRMrRkc8JwybgFnH7MhwqxaNkRuFLdvR3EH1I3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVQ1Iux7PDvaudru7qA3HwN9NtP1SIhjJ9DXzhts37o=;
 b=K4u6sB2rLqXfaNGlmPwj9wiZddQETlKeu+/s6yonBFetfhQETW6aKRp41sxh3BLZJT2p6maQsfdf/72Mi7Hx8dVwI6cUDxoeXDjlmQwCRTizvcZkHJOY7aw+5E+gyp/+W4Vb5TY1L/QjTMjlLrl0+sT+zFZAqHltoK+iyYwrBSwNGxOy6yEm5eOdiyrsaKpnMI3Jngrp8uXRbU6pnSluheRDR3dDaSQnWeRjaBIvrs7hsznOEMmsLkdDCRtPmKCGCvfkkc0oQ7FyuAn6+1yra0Z8o4E8YLtyTaOIkQ1Xfml85NqPGkDX9ZUDLIr0AIUqOgnkItedROHYVhTgUkrrzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JVQ1Iux7PDvaudru7qA3HwN9NtP1SIhjJ9DXzhts37o=;
 b=MMfLVC3z84msG9lAYB+pikGR3y9W5ACEDlL7oDLzAB2UAAkVlQHoY3gtc7DCdNW3j6xUx1HbK99YT9CIxUF3kYdnrCMwLahSRCgIc1p0yAyMYQxz/iEeTO7hkV+r0JgZCtK4x6YsRdVeJGEpHwEy3KRIr+wMY86U5D9GwntO2bw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN7PR10MB7103.namprd10.prod.outlook.com (2603:10b6:806:32b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 11:27:19 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%4]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 11:27:19 +0000
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        javier.gonz@samsung.com, bvanassche@acm.org, gost.dev@samsung.com,
        Hui
 Qi <hui81.qi@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v2] nvme: enable FDP support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <5e686875-21de-869d-4b19-bdd9e272d690@samsung.com> (Kanchan
	Joshi's message of "Mon, 10 Jun 2024 16:08:19 +0530")
Organization: Oracle Corporation
Message-ID: <yq1r0d53vi4.fsf@ca-mkp.ca.oracle.com>
References: <CGME20240528151007epcas5p32583675f647553923e5ba4987e9bc6ed@epcas5p3.samsung.com>
	<20240528150233.55562-1-joshi.k@samsung.com>
	<ZmMj3d1Rvv-5E6Ey@kbusch-mbp.dhcp.thefacebook.com>
	<20240608051740.GA24010@lst.de>
	<5e686875-21de-869d-4b19-bdd9e272d690@samsung.com>
Date: Mon, 10 Jun 2024 07:27:16 -0400
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:217::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN7PR10MB7103:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfade27-e3dd-4a05-81d1-08dc894049e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UnUkx/06P7lrTiZumytuliX25Hmb29MBzAPQFP039Hg75UhXbG4mjLR6D1RO?=
 =?us-ascii?Q?MOQt/f2c87QgU2PSrawUgjHYeHCAlCPDO+NZuhGQdN0GuDwHCBOaGpd+BO5/?=
 =?us-ascii?Q?IyBHispwfHB4o/TsVa5uDXygdLdNpvfwSKKfV6m/wDahN61lBpXXfXIW4Ybv?=
 =?us-ascii?Q?0SN6tUZ/2hd16bosfadCY2NtXuC8ES3ieOmw4ArmCilbhSaJsAMJRtn1Nj5E?=
 =?us-ascii?Q?pkYvytYmd9n+yZlIkH7ubTEDfAq6tKAQ2w78Un8L9YKKQXtyEKbvYILQb213?=
 =?us-ascii?Q?NOeCE7fDWFfUQYjRJv8ig9fWMiJ2X96ovFdo/43et7tRRNz2LXJgvvz8cN20?=
 =?us-ascii?Q?dL5VMkr4tEMaJBKErzJEIqrkfNOKrsCdLEQwBAVXvw13aB5pcy5o6VRdFU6z?=
 =?us-ascii?Q?bK0/hYK56mp0hJR6mGLXO2DqV0NUWr1LVl+sdm11E+XGKKm7FwijxSm2hWEU?=
 =?us-ascii?Q?KzUSl1Nmtz2u0M3ga/yoK4sNx+ZlVUABMCis7fpn9zjlrFjgZCYnN5Un11kY?=
 =?us-ascii?Q?M2ej33070oBXE+QdCwOeKuqqnJW2IM83fE2QRoIrXL7kp5cdpbw865G0U3nl?=
 =?us-ascii?Q?WmAFmoofsKdFvHZ5dyE3LvFshzM+RzhtP4dsmIZv9Pyj5qwte8jA3J63K9uf?=
 =?us-ascii?Q?NN2a6XHvzi5cyvFTTm0afz1cIa6nRALVtegLADsIrZHb5SSo0LXJmzIWJzMr?=
 =?us-ascii?Q?mFL+cCO6k0mj6PiFyDcBOl74vSD+q48SJphQeSU9ih7VTQNQPNPiU+Qqf1xG?=
 =?us-ascii?Q?VdqlP7FIg7bmbNnJYh3/xOKPJgSqQQcVPI4GBG3Oy/xcJoahtXEN9m8vAATT?=
 =?us-ascii?Q?quiR2lPbL7+Ukn/g+v6OaCUU8ew3QAV5MFKccmhemZ+jvyJthhfk/V2ZFlGQ?=
 =?us-ascii?Q?Kohc3zyz7XiQkvZd9lcaT5cOlWV4dEZs/ggGwP67gxp/fIcDL5YHi9dnGBE+?=
 =?us-ascii?Q?UTHej0d82XzRfe/aqPNwLuXESF90vW2ttmYN/3KkBMkK+BROdccjm19YPDcM?=
 =?us-ascii?Q?gAKI5XdvETqqPgyEkmqrfupR8KAOMfOgeD83V9J0bksiHt8fsv+5dZ5fLlPx?=
 =?us-ascii?Q?jnc4E8IGsAJ9b2uPxpxCSPDZXC0o5t2j9dgmuSn0JqzIRy4Td23RlAyRZdxz?=
 =?us-ascii?Q?836f1cUgNalqCo4E2NL3d6HQqTbl2HvmMzHCxvXDbJoDJNnoiqZdBcb7EeXH?=
 =?us-ascii?Q?v9OeUhFUsBx+JC53SuYKjBMtr37YYslkQORCM7LM07qQIFSJDjtvJoD/7bBQ?=
 =?us-ascii?Q?5+M2fn1MXBSRw8UOndqSgupEQNJm6DQqyMlB4/nzA79vzFSG29J4anOKpDho?=
 =?us-ascii?Q?lpQjjqe4OIXtqFfCs4XhsjUq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BqgqfIS8G89JNvOMlKEuv4TWBSamXKfUVOzLXi7puL7R6qWRBgHv8gBeGd8m?=
 =?us-ascii?Q?OVDqK5Q0tGb6iHNwKKBeYg/4tcophXFf7Ub77878fVacH/hALkUzpMK52Z++?=
 =?us-ascii?Q?CxXGogTUt3GQc0X3DaZgUhGK90p22iILdZpHB1UJqCmkcR4Y4r3KjlfSZ6wJ?=
 =?us-ascii?Q?gNaiKDOh9G4hZHjEKxcEQwAYaxvdnLdDu0u6l0trVuUdQbJJ9hgPue+KJKAL?=
 =?us-ascii?Q?ACwbNQUFfl4CCzoUy1TtbkSvlYHPQ9YDcl417TFJbOWZmhiK5KoucbD8EXFv?=
 =?us-ascii?Q?RsfSRuctwo8x9SxAM7T0cG87ACC3xv9hsuIqZLvyc2NwYl2oYdTpvfzFMawJ?=
 =?us-ascii?Q?CWgFulrwTQvotB6JUvDMLKU1488raBYaK9HFhUmplw4W8GG7DgSs8Elnt0da?=
 =?us-ascii?Q?/+6/xSKcN/BwVy+qrY5zsyOCBTCde9Msr0zghLNwqBgPdWAo+Ah949FJHrch?=
 =?us-ascii?Q?WOyBQmqnpHJ6V0T+T78ycznb6OgWXkox9fVqAE+i5k/97N8GSHwf89JCUlkr?=
 =?us-ascii?Q?JvVKxjgcHYdizau4USrjb4mCN2t75LSW4zGGET300GPvgyNhOBgWe1Q6gBrB?=
 =?us-ascii?Q?7dM5170bqJOJFo/zEFbtaatrwx1YrWkhviphXpfvC1a4nFFjIgniuxM7txAy?=
 =?us-ascii?Q?LSMlQBTV5WcQZWFSKiSqGjTxegF90dtjdEQDg51YboR76MDA0GWgaEZK9JaE?=
 =?us-ascii?Q?3IR8ZkEhxKEdwgk1E3t3Y5xhplF8+Rl4WHrlry8tIrJDsEX4sSAmAUiC1Bc9?=
 =?us-ascii?Q?UiMAJpuEtyVhyEVcx4IIB+CLIjoXkvQswNUZnI0YdZ6dY8TiqOx7lcfvWSqD?=
 =?us-ascii?Q?DgQlDZCIrPMaLStmpTnuV2/gxJWapQNYb2ABzQIukl354N/BopAXAey+w6F6?=
 =?us-ascii?Q?4FlX7AlpLlFQE69m8PKUUWwrXHfkOVuaabeXXdRWHfOe3C7iuyKGtUOCgHDJ?=
 =?us-ascii?Q?QhN5cDxf9agrz2RivWVW0CT3NFBkcCWpRBMUsv0vEfID6T3OybkoPP6ZyfqI?=
 =?us-ascii?Q?7C7j1KC4LljOwdgU46gEKKFwas9wkJgN5tGuvVM3+ROwLVDkPFDy+PUMa/gX?=
 =?us-ascii?Q?H8RCwBamTSspL+joPyEQY1KhX9Ajy2BpE2yCcNvCaqjQmZyTFjnkeoKnHLc+?=
 =?us-ascii?Q?+VH4krtx98YrtZWgSpPP6waIzZIGyMZ2YLirsA2Qj6rd/vaGttXqF57rynNc?=
 =?us-ascii?Q?hNPq1HXL7lUw9fczyO4Im6PKdKqOaQ6fHpBbLl7ehNZXd+PWKVQ28fC9drVr?=
 =?us-ascii?Q?4zWXPdhOwqSlZkJGKkafN/BjHLatW59Y7SJlG4H6+RPY8SifQCazPLC8naWA?=
 =?us-ascii?Q?TSwqYFLr04/aQ1lmhBlim0Cjnc6DqbUNYwEE0N6vV1yS7gzeay9TAovQyuwr?=
 =?us-ascii?Q?csxW+6RJ5tbyEiaeeZEfxqDuI8iLlcSs1ivBj3drYfliwxVmGpgS1aLLajEA?=
 =?us-ascii?Q?e1zw3t+tR2IOt1scNmFJMJUgQtwxk3lfhDNlOcHy3Gkz8EmDkXlgXR9PxWQK?=
 =?us-ascii?Q?QATk14+OgNT3ia1nIJjLb6wU3lLXCxT9ipESG7Z8KEkSUpTQwOCxjNNNh+v1?=
 =?us-ascii?Q?Y0i5qz6R/HrsPm41kZi5T//lstQ2JglRzOE4W9OfIm1eUI8LV1a97y2Pe/Lj?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Nh8zDxRRmNZ2UoAVMTBd5Mk0nKsWNRZRQWW4SygtHlG0gVW5BEn2omxOW7aLaDipeyK0tmxpcvu2EbpWhhFHdfCzi/7GXO6/YlHEcJtrltQjEn6Z/yVP6KpO755tiUCihX15eMuelrFFBMpp29LdR3ephrV5n+DPuzeT9v67xneQrBnT2ffZuD6YdHUHQNqPVIHfEbchgKgzxaJYHBXh8oZQcQIBWAMgDAf0z/9Lsbuw68hcnEsF9vjT98QiwzYNy3m3Kqup2QI33eurUK8I/e7iu1GN26ZG3bR1x/JoAbLKZr0qty6j4WF2FhzBX7iwkldjW6QSiZSh6WVDKp7h2VIU0tK9Zul99NB4Rui0IwkAM/Ivo5x3RfI4+hHdd4y7PWBIrmVAABukVv3i7HoWcFl/mF13CaqQOUQDXAtDeBfucURhlyjqMUiuyVszpcgrwN6o5Ecd6y0GnJYvUyMfiRsto9RG62oQgWwXeV+5dcfBoSJPAHsEBlOCkTAqmvhniXHb5sWJraug2y+XG0rpsLItiHJMeSiGdWmqwVwsMQv/zj/msTtnI+RMVqyz9tSi37YcwZL54f7Ofqbh5K1vmIiXldz6Utg4YCkTVH7/CIM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfade27-e3dd-4a05-81d1-08dc894049e3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 11:27:19.1256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtBm5FQv4ZUB3jdOsjYIPkIsBfxWQe7TBz3MJQJnCMPs6QWcs3BzYWP93OFHVJdiV7lE2ZBCZCMxcFibtFvWJ6P5vydzyKZqvV5MswsLAGI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7103
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=630 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406100086
X-Proofpoint-GUID: MYl3pVmTJb9XembMVtHQ9FSN_PB0hUUl
X-Proofpoint-ORIG-GUID: MYl3pVmTJb9XembMVtHQ9FSN_PB0hUUl
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240610_042733_783532_D68BC553 
X-CRM114-Status: GOOD (  10.98  )
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


Hi Kanchan!

> So current plumbing is nearly identical and as simple as SCSI.

I don't have a problem with your implementation, however...

> And TP 4146 author list shows 10 companies. Perhaps good enough for 
> diverse opinions on how to go about things before settling down.

I think FDP and SCSI streams are less than ideal. 10+ years and the
standards bodies still haven't been able to produce an approach that
makes sense in the context of a general purpose operating system.

-- 
Martin K. Petersen	Oracle Linux Engineering


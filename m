Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8DBC3271E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jul 2024 17:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:
	Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r5W+ALpxgWvhdsGl3YHMvtZ2QrJYbsBf0b9pOxJI/Bk=; b=Eu+eS0BPNJwx7OQhdUlvHH4Dx0
	+YmJZDa8oV0U8CACNpOUirKtXyvsrk1L75iJFRunreWDDBHxILiCLl35prFKbI+mq2MoLXXIPr1XV
	4R4e3Tap/AWQi4HP/leleevl4zQiWB4lUanfsSJZXzNyx6/Og8gqjkP/o5t4cJxB+QL4XCk5j0xM5
	35dxrDH4B7kes8y/kW/llNR/FUhzKbyLe1IEGMkCF9wjWdKuSkRE1Nc/LnXkEMPjTRdxLFGo9Aqzw
	zQBacwAC0tzK93nUisn7obG4TzD9NBR6I0EkED5fUpwf1y9GJHZJceeJ1GDayJZhTWZ0olkw1wbwR
	10YEFHFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPmXR-0000000GWU9-0yop;
	Fri, 05 Jul 2024 17:16:01 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPmXP-0000000GWTj-03aT
	for linux-nvme@bombadil.infradead.org;
	Fri, 05 Jul 2024 17:15:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:In-Reply-To:Content-Type:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r5W+ALpxgWvhdsGl3YHMvtZ2QrJYbsBf0b9pOxJI/Bk=; b=Wr/KUagVzGvi79j4bmgVLT3YK4
	aRz76dfGS1YmX4a51CcPyNtwiACIJXFr2Q11kXJU1esEEYtJ7cbrscQ2JU2k8n640S1UxpMTs+Ryw
	RFZq9Hpp/lSe8tbghhWhO5uLTjjLmEKAD4pO9Amqp5hfZssWZ8iSNZxchJxx0d01/GqdS5qn21fGL
	KpWgHRVVYTMGPAPw4S8C7GsVL/rgIdP2Bs4B4JIYQx/KB5BHGG3lklwMBbNopMKQw5jRfqWJY+t+6
	oztP6zvBIvVm168RpnZ1TNg1QGj2UjrVSSykxPfJHcyC4EHgMu8wmwhCjbdtfZGf9bYdU5maXuEfP
	Hm1yyfRA==;
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPmXJ-0000000ALZU-47gX
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jul 2024 17:15:57 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GMVux008309;
	Fri, 5 Jul 2024 17:15:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=r5W+ALpxgWvhdsG
	l3YHMvtZ2QrJYbsBf0b9pOxJI/Bk=; b=SoYntJkGvkNECbUrY5J+bXkhai5ZsQ7
	I9G+ON5DwyZn7OOpoMkgVS85S8kLOycVxGBigfQWx4SNLURRcrYiQry13z2VhGIn
	QYNyxQbdjbrexgtaYItWkE0/Q+HK9toWDJLtsYxtvWRoiG/bLjQpMA8ig1Fx0rA0
	CSLCwOgWWkjtZlK6RQnuxcjaaMBhgA2TSQA4CSZu9GJSnMbzgqOstY4obnWLpcxg
	sULVoDJfQz6zS/UpgF/SvlhUJ4xI6bPLOKK/fbUE6+/TKhp0HeH2X8ADYKGlMBVX
	/qrEIzNZGBFKiSJ5ki81j94k2Oe31xVNWKzNxxSnGgK7dkVXtp2/CFg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40292349uv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 17:15:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465EmMdK023611;
	Fri, 5 Jul 2024 17:15:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 404n12htdb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 17:15:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZziTMYRvMYE1vOs9R4ooddHAWCKCeQTiVnIzZiYNHR1qWJ1iv8Ih5GSkqBGncZPsLJqSfwmV3t4vDGKYV9k3B7xZZ2ArCvkgZaryfTeR3B9qgCTiwWLFHu6t/6nQEXOxf5KJ5SXZtacZkDr8LSOr77V4qUjhs/wJYW9jG8IAK8ah0lC1POxE6C6Uu8ZkQPIRG0USILqKE9YJPQINL2D8Y0RS4TO0han0B4ze79jewhngkQOmF/M3TlA6+cn0mz0lMYlXO3KTRhbftOiPcdjvc6OVEJolpSzummLRMmg0rm1M9+POgQYycBYBx4pM6HOjsUCG59ohHOxf9imDoQetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5W+ALpxgWvhdsGl3YHMvtZ2QrJYbsBf0b9pOxJI/Bk=;
 b=HU+Ao4yPHRdtUEm7ghGpEM3b3r1uz/ugRDM0w5ZgvBB5DSDb833V3HzJpQ0nvZLOgkXNp8dgsaWrIgTGw/orjnedmWSZL/KZpbICaS90HaZDAHYC8H5qLfHjHxEqvu/HdWbLwPwTN11e40vey2fgpYJLDRv1JTkfqUgnFuFy/kAkMcoDh91pdZY7QS/Ytx07wsGuRET+yp3I+X7LKFEdNyDLD+RWA0/212HpecSUyjFivYfhtJv/deIEHM7yPbupDT2K+veP0HU11Y/SxKRNKcdqlJzOAb1bDzx1Rno4QSvvcHJTOXmhoyuOGnjuU8l3waZTdFCk+bhZMLgUEXR3WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r5W+ALpxgWvhdsGl3YHMvtZ2QrJYbsBf0b9pOxJI/Bk=;
 b=DoF3wm4hSL0vhrmd0e6x1YMOjGZ9yMd+Fv55UEkBSUMfagRQFWJ9FYfxHQIRQazscUFEQSQB//O1lOCOQxSsoaA3DXWrZzxwwbhljYYskT/oysSWRsbc0E1mlBTXUVeam5TewBRfCmaFP2hoIyeMMb2hryR+buYkO3pIStsePSg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DM6PR10MB4186.namprd10.prod.outlook.com (2603:10b6:5:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.36; Fri, 5 Jul
 2024 17:15:35 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.7741.029; Fri, 5 Jul 2024
 17:15:35 +0000
Date: Fri, 5 Jul 2024 13:15:32 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH] nvme: implement ->get_unique_id
Message-ID: <ZogqNFka2384O0pT@tissot.1015granger.net>
References: <20240705164640.2247869-1-hch@lst.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705164640.2247869-1-hch@lst.de>
X-ClientProxiedBy: CH0P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:610:116::9) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DM6PR10MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: b03f4e78-2bfd-4e90-41cc-08dc9d161567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nNsV54DQTydrktd4tVlJdKeT3QW8LHKyJ2g7v/CAqHRAepNDgwhFeNzqm6ms?=
 =?us-ascii?Q?eitvK2Rkzf0uVhUIojBMKVXn3pOJybuLPNv2Zqou1V9KlL6l4gr3f+ZRK6XT?=
 =?us-ascii?Q?JfGG0pFClgXBYfvtJ7NNT0cWZ71q3Xaut3JSfCks1P8A1xoYI237l7QSkJCN?=
 =?us-ascii?Q?Q08D7aUP81lEOmNKBvwmJRpi1+Qv4BQnlxP009IZIJgEEVaIxNiWcX6ZGxvv?=
 =?us-ascii?Q?QfbnNxIYQCKRn/KHigrSyOjpUXyP2jyfi86ud9rLY4aIg+DLLylHZUf4RRaG?=
 =?us-ascii?Q?/1CDY0U3KSfU3gr8wJMPKgk+Kk395MuaeyXGgL3rdpikuR4EP2QdqJ61gP6t?=
 =?us-ascii?Q?nBey2Hl6c4vBJMaD2kasW+h7uxSSHo3EJ3IOvyvXH4hmhpGZvnsWxf5kvWh4?=
 =?us-ascii?Q?Mdomz7qkX6MocBrHeGSlK8MN2LS563xAZ5tn4G4qwwdpIFaDH84paXDTBzou?=
 =?us-ascii?Q?vk3hZpk6WFi86hl0JPm1ot7xSFHjJKvF6bfak0TR6wbGZjshwG6+AMTyNllC?=
 =?us-ascii?Q?7RN/KP5fpbaBSMc0duzvqHGT0K6QLjeR5dYaXKf+ho9Cl7UYFulfIKOdTMqR?=
 =?us-ascii?Q?gvqvE3v2jJs1rxICMjdIMAFxuxTZm/Xft+r4ymYBToUQ5/Sv9VgAJoHxSrIn?=
 =?us-ascii?Q?dOkbTqObjaXMUgm3M2fXbpQimB+FlvhHI/R7Tc/zd2kUnfC1kMbkS660CzMQ?=
 =?us-ascii?Q?H8G+0Nj9Q8ltZSU7yYZy8WF63CbcSLJLQdJPQZRvV86qGqa5bEgfTAUXbGxm?=
 =?us-ascii?Q?P7WP1/Iu89ODJY5HHGiDp1Z06OhPCjqE+qKJZd7K1o645WTO6wwpyr8XX1op?=
 =?us-ascii?Q?EEr0oY/e1H5RrxCmT9bYuAcoA1z+ma9YKREElhSpn3NnD2Hc0XjroxKLFoqF?=
 =?us-ascii?Q?5NfpfQHATGxz5xxmZAeqMK0GLokAegy/qbSGRYx4aF1PK7ixKDgXytIH3k/P?=
 =?us-ascii?Q?8PtZHfaTOgbSBtgpUwfVjErslKGCB1XK40YANEkakrMtDP+kP3FLE4tOtPMy?=
 =?us-ascii?Q?Cn9rivh8je7nqpeRSwLuUCWk8NRK4gxGZ0RgKUqo4eH6j2FJvxSMxc6imjKv?=
 =?us-ascii?Q?IrzJHYTXVYewUUi/XOYqnV45madXt2WlvfVSemJlmwl0W364GvHRlVLwwADX?=
 =?us-ascii?Q?c1hEyUzUlzWD26KBm7dCn4v1qei9kYw/ojN+wtMR2WCArmusOrNjJJdhDrEA?=
 =?us-ascii?Q?hX5OX4fsHBETtxAm95Kuqnq5BtB+yd0rZpyBDNK4T+kJW7yX86XigZ4cwHdi?=
 =?us-ascii?Q?CKM8NgClUt7UNAENRcET4ITUHKf+4z35AD/2WJd8R7vNvJB6SuOoD0HnpkZ7?=
 =?us-ascii?Q?OuWAtqlutWskLGR9jwshgMav1HnF/8dzemwQqnHPzjxFpA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kKcBc1MTxFgN4I9JfiGc8AZZV4XmD/qOm82VSxPpUkWhGtMOJRjQjIHBvmJq?=
 =?us-ascii?Q?tKJkoux0s4wLvH62CWG1UJfUVvwOagSv7nhWc7DIrLkO6++mnhGFsSnagzXC?=
 =?us-ascii?Q?o+bJiJmoEogo/R2EUqVUU0OaCsOb0fmdd63Q0H2+YHyXLd+3UFj6M3GSDjOa?=
 =?us-ascii?Q?jL7ap99NM3Oxnu24C7Z+YJAsmKlEtFgCgeB8poYTnkf7oWZbqQDRafDPNBxm?=
 =?us-ascii?Q?u5oKngUQa0DBHKlubxmABsf0FNk2A9cwQHHQrwdxVLfgF+9gt09cP4plKKiN?=
 =?us-ascii?Q?SqyBUwdqBQMldXI515bcUATbwxqH8E4pPDwht1BhWq2+AWxPLCLE5kipYrgH?=
 =?us-ascii?Q?qBt9B8cLERo2yDXZnU/VHbYfffkocOeJSXDX6YBFM6ctkRKx7qt/ZSEjUJ2q?=
 =?us-ascii?Q?fSmECSN31cRh0urOOSKx0oU4T/uxk5pb3eAzMa+zScFS9RKpV8KEmrc4P8VP?=
 =?us-ascii?Q?DzWaKFyYdmSJAY1ohrgkGCsnuqe46gpa0xekru2+oIsX8aik6D2KPrdUwxH1?=
 =?us-ascii?Q?pSklC3bjwflYRBq4xKhOOoIrk8HRrCMyLowG+gds7Wu/EWNl2alUa+CiVy+k?=
 =?us-ascii?Q?fYkgN/+qu2d554zhpHTkq7IXcl5r+77VCGvbvZwZMBoe0b/43LbLhBV+mCKi?=
 =?us-ascii?Q?adue0bk+qMq4nlQrxa0dEdHWJAkjCaVGlNdJkeHTR/+ZYmV4fA/OTrRktewi?=
 =?us-ascii?Q?mXOzYmvfSRVDOEvIcOky/grCiYi/taTgOCkxPRYf/vF66hrAZMldH6ClLG5B?=
 =?us-ascii?Q?Bi9x/CfkvXlepnLNrGFWDlKJfOTBa9yh0LmO7T7+zWCzdzX/c1PXCcgu7M42?=
 =?us-ascii?Q?hwA/OOdSFXwqpKmVCGVK5Yw/f+Ya6IxKyE+t/QEKUJmtJbbsHUpgWKlIfUdB?=
 =?us-ascii?Q?4GfC5z4omH0RaLI86smPvB/p3lV1gAHu1vfozQ/6f9i/F6s8zrATiIu9XdmO?=
 =?us-ascii?Q?Dc4HVYl6wc6vaPBKWAoHvTYvUTajlf8PHXMveN9MCNi+MtDwgZqra9kxZDsK?=
 =?us-ascii?Q?8fEEW81R/vv4iABetUGUJ2siBKlNAmvvKDmo0SDnVwmcc3P+0F+Q4gyTXQli?=
 =?us-ascii?Q?SLKKufIMvAARdI7Cbe9smFFpHH/uqCjnoiUbwzFGctZfqdeQxMv2WvftdXaW?=
 =?us-ascii?Q?D90Vo6MVSrrnCq/4QJjQpiFBdfo9u3eDizvchT47T+Hh3B4VQwjshbOqmkGg?=
 =?us-ascii?Q?O4Ox0c74nU/iNwh+AfFnSnWLhP7fyRZtfHkiWFxYLZfXl1jYpsFK77mKK9EY?=
 =?us-ascii?Q?TPGeRBq7B+Lb2x1HqsDKtFAWdVZSA6+2cSbOL1xacJMB4UN1A1t5DcenFVfR?=
 =?us-ascii?Q?I/Z6jdMPjkiHolVjxTUSqeXRrHg9yO4b+Y2RmL/fDN0PUCq/Gl0fvCWO8EOc?=
 =?us-ascii?Q?WBn+jbo1MYFwbbhO+4y1rm8981Dpcv2xyzsUn8J8nXyeW/qL4qOddNGEYM9B?=
 =?us-ascii?Q?ju0a98X5wpLiVWX8kXvALdFaXErY0M9uIZbtzDBZE7sg+WAeu9pksdCAoNLE?=
 =?us-ascii?Q?AS9OaHtRalWN1bQefa5o5fGAlpRKJlSYpFd3QV9UCeQ7criWtC0PkVbEriam?=
 =?us-ascii?Q?9PE9HIAmWSHC4V+q0Ln0kwXlqHHUeZaQXptCnlVc?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: NPVO8je7LehJxOzR9gTp54TBUbCtEWxHd4pwaylwlfLzPPntyqPi4nHlHklgJXvwfNgoE/5Yz47ODZbOybVhJoOz066w9g8/X2cYrchnRxNXAsSBSoMIvpTT3BL1NcUyn5K/gm9kgEHd+3LKya45nOpawHX3hUHFU3Lm9hTB/a7cTHM3NA5qBDW+1Sk7nVYYtSDWUARegAndnTE88e7/2Odhh/2mwcRgsuETEvrxZgvq2Tk32c/AcvEvFn1Ul7bWhUi2NRqR3zybbSpmONa21sHhK4giHId7H3zBnAg8b3tuY3AMS6ohsAQ4w9I/DInrzbcBbad0m9pbksuOnc8Iq9AVjK5EGp/YkXEjDzb8kL4eqOGuS8I1qGuHn1Oc0D/1qfGJA7bsVtEO9vKdSlkUIkiTgYgc2NfjUZg74/APYJoUL7Z+HAFl4v0PWOam0mLZQRVZD6EOImPs9gCKpoRvtJvA3s/zfNK8gmXne1uUzEI8lpS/R1VEtm6mnYhJFWpM0BsyOpxnXS0W6GY48gXmbw8b4ZlLs33ht1r8ctooKKDOEtnaadJDmxrCEHkbTYdECkOoTOJIK4CcixNeJiOyIBtkTlXze0vAsdp8FKSjOzg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03f4e78-2bfd-4e90-41cc-08dc9d161567
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 17:15:35.5341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: snJQMROSKomDaXJ9OZkaxxX0naeFqx1weifiJoDuJwKCoOgsz7IlIGzdE68hl6YPNnPvFME9kJGbczVpTXgyhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_12,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407050125
X-Proofpoint-GUID: JF-PzWPD8mD7FZRk3Ikh4IEA8KxY3eOL
X-Proofpoint-ORIG-GUID: JF-PzWPD8mD7FZRk3Ikh4IEA8KxY3eOL
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240705_181554_675950_0989724A 
X-CRM114-Status: GOOD (  24.99  )
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

On Fri, Jul 05, 2024 at 06:46:26PM +0200, Christoph Hellwig wrote:
> Implement the get_unique_id method to allow pNFS SCSI layout access to
> NVMe namespaces.
> 
> This is the server side implementation of RFC 9561 "Using the Parallel
> NFS (pNFS) SCSI Layout to Access Non-Volatile Memory Express (NVMe)
> Storage Devices".
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/core.c      | 27 +++++++++++++++++++++++++++
>  drivers/nvme/host/multipath.c | 16 ++++++++++++++++
>  drivers/nvme/host/nvme.h      |  3 +++
>  3 files changed, 46 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 782090ce0bc10d..96e0879013b79d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2230,6 +2230,32 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
>  	return ret;
>  }
>  
> +int nvme_ns_get_unique_id(struct nvme_ns *ns, u8 id[16],
> +		enum blk_unique_id type)
> +{
> +	struct nvme_ns_ids *ids = &ns->head->ids;
> +
> +	if (type != BLK_UID_EUI64)
> +		return -EINVAL;
> +
> +	if (memchr_inv(ids->nguid, 0, sizeof(ids->nguid))) {
> +		memcpy(id, &ids->nguid, sizeof(ids->nguid));
> +		return sizeof(ids->nguid);
> +	}
> +	if (memchr_inv(ids->eui64, 0, sizeof(ids->eui64))) {
> +		memcpy(id, &ids->eui64, sizeof(ids->eui64));
> +		return sizeof(ids->eui64);
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int nvme_get_unique_id(struct gendisk *disk, u8 id[16],
> +		enum blk_unique_id type)
> +{
> +	return nvme_ns_get_unique_id(disk->private_data, id, type);
> +}
> +
>  #ifdef CONFIG_BLK_SED_OPAL
>  static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
>  		bool send)
> @@ -2285,6 +2311,7 @@ const struct block_device_operations nvme_bdev_ops = {
>  	.open		= nvme_open,
>  	.release	= nvme_release,
>  	.getgeo		= nvme_getgeo,
> +	.get_unique_id	= nvme_get_unique_id,
>  	.report_zones	= nvme_report_zones,
>  	.pr_ops		= &nvme_pr_ops,
>  };
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index d8b6b4648eaff9..1aed93d792b610 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -427,6 +427,21 @@ static void nvme_ns_head_release(struct gendisk *disk)
>  	nvme_put_ns_head(disk->private_data);
>  }
>  
> +static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
> +		enum blk_unique_id type)
> +{
> +	struct nvme_ns_head *head = disk->private_data;
> +	struct nvme_ns *ns;
> +	int srcu_idx, ret = -EWOULDBLOCK;
> +
> +	srcu_idx = srcu_read_lock(&head->srcu);
> +	ns = nvme_find_path(head);
> +	if (ns)
> +		ret = nvme_ns_get_unique_id(ns, id, type);
> +	srcu_read_unlock(&head->srcu, srcu_idx);
> +	return ret;
> +}
> +
>  #ifdef CONFIG_BLK_DEV_ZONED
>  static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
>  		unsigned int nr_zones, report_zones_cb cb, void *data)
> @@ -454,6 +469,7 @@ const struct block_device_operations nvme_ns_head_ops = {
>  	.ioctl		= nvme_ns_head_ioctl,
>  	.compat_ioctl	= blkdev_compat_ptr_ioctl,
>  	.getgeo		= nvme_getgeo,
> +	.get_unique_id	= nvme_ns_head_get_unique_id,
>  	.report_zones	= nvme_ns_head_report_zones,
>  	.pr_ops		= &nvme_pr_ops,
>  };
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index f3a41133ac3f97..1907fbc3f5dbb3 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -1062,6 +1062,9 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
>  }
>  #endif /* CONFIG_NVME_MULTIPATH */
>  
> +int nvme_ns_get_unique_id(struct nvme_ns *ns, u8 id[16],
> +		enum blk_unique_id type);
> +
>  struct nvme_zone_info {
>  	u64 zone_size;
>  	unsigned int max_open_zones;
> -- 
> 2.43.0
> 
> 

I am happy to see this. Fwiw:

Acked-by: Chuck Lever <chuck.lever@oracle.com>

I will connect with you offline to advise me on setting up a test
harness similar to what I have with iSCSI.


-- 
Chuck Lever


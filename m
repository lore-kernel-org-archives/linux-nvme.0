Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87776C27C65
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Jun 2024 19:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Date:References:Message-ID:In-Reply-To:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PgS1AuCGS1zybHE/9uGGZJ2q5U+kXoYaawB2EaS3N30=; b=UgZ+dbOVP0WolcLN9qVNVG+eCW
	OUpnPbMWFYEocUJ31fGpelYPOWRvju+IJ91hGL+qy3JcxhiMxXTmWn+d/s8BvdEHuFsJq9dbYbB54
	9T0CbFwYCvBE3YtVJlWljG2DiKpLj7oEx37PaZERHjlpE5eqK8Q5RbPYm242R9LKaU3tsUwnHFDN4
	7K6700TKdh+PJPvyRulOqqzrTbv843YQr8yYKFLiNNy+qa2nqlTy7QMparlTjUumrxwsaO7jWGw+Q
	H65Tvl4UQc7FLdNj2iH8bMKCePXKGI19yqcy6NS2Uso/6ixCP+bDR2tKUsJN8UFEdrP7QJHG2gUON
	O9V9Olsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH7P7-0000000A3qi-0mnH;
	Tue, 11 Jun 2024 19:43:37 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sH7P3-0000000A3p7-0PIc
	for linux-nvme@lists.infradead.org;
	Tue, 11 Jun 2024 19:43:34 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45BFjAUj012053;
	Tue, 11 Jun 2024 19:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=PgS1AuCGS1zybH
	E/9uGGZJ2q5U+kXoYaawB2EaS3N30=; b=A7T8wo5/us3JkzpStgyHiZoIO7Tqqr
	qiyW5hygww7YvJ2WviXyDWkyvqfB1G8RxsqBmwlgQvwCJznpUEzQAupPiu5q5srz
	+/uZNkRfjbyrX6Kr8nw/OMivUHbeuZOeKiXFx8JLqua7k6bfhUleRzmW5YZG2cOC
	dHPKDImNMDmvoTo0n4aI3srqQA/O5w2lfZYGAmtUS3DgEL0rFhUiWm//PV8WDIfV
	kPY3MUrICUxQSiaZdaZVw6dTLWjtAb95XrvEtQTUY0CGxOc+/6XflPAPQ3vgHbWM
	6/hBGQt2jALUT3/kJrEokxqsRyu2DaKzSjeAurSo1SISbGwy2ERZB7Kg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymhaj5pg7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 19:43:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BIKS8v014455;
	Tue, 11 Jun 2024 19:43:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2041.outbound.protection.outlook.com [104.47.55.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ynceuef0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 19:43:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQxgAlcrgkX4v1I7qRb3aGHUQfbRqxeelGbQ4Ek0MH1W9+0bw49veUHGTyIHHPnukxnpZH5lygKIpKI5PfLxWyH9bnG+uIq13geEnvlV2aVBpOtApMMiH6qemVy/a+7CBaZEc+NFLqOiWKud29qAFqoqR0DLXBz5JpRL+DLyZTnqhqYw2aBmHnHWMLrponz9Htt1Gs8qv+Oiya7Z0xw08LOOxu96AY4Xn0cuLQvo6x9MPTlySxTP4+aMBFoS7KIm+r2YfInsaQexIBv8Z9Yo7O+9dctSclsRobKNc5S5fHOPkBcZxuxOSM1oIZl5qrB2/RsJx1lw2kmtTvHAFxss4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgS1AuCGS1zybHE/9uGGZJ2q5U+kXoYaawB2EaS3N30=;
 b=EuZAqZ3Ev49HqBG62YKxxihhH6xfEp+/CMAzk8C6VPX9F5EEcv45kda+f0HfOtKBkIfrbaJszgkkrr/4hFfFzOYGGUQ48KrZbryx+eO+EpwvvzBKqwv9ZxESxRFfgrPiYQLr2EQZLrF35k4px2QdrQUL1fk+3SZKKhu8LvDYG8a0Gzz9jQ11F3Ble2bOLZsrlf4Z9xk/ZXfZBWmtwVcljkFDWrWCwsTCipXcsFx0TUlUkmZ+E/Y0u6XwI+wt/CW3Kxd+OEl5cmGkpcQG7UK9UF9kUYBlgNSwQDtpRKbCAwvfuYUWxd/Yn3GBmjMXn68C9TDna12QZnXzF51+nfMWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgS1AuCGS1zybHE/9uGGZJ2q5U+kXoYaawB2EaS3N30=;
 b=ugKb0yd0cReixmxQGo2//YTgFQrEKFRCCcD4QNKcnQ4mzBBx/0urT40Vp8NTSx7oTYPOYfJhM0AT60yIrqa6k06NogL8OsNpBpO2IW873EifTa1jWWavDeZxNtiPdYUPk+sM5kxLp7ydvORvKKpwh/l+snnqaO+7s4paoFpoM4g=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by PH8PR10MB6621.namprd10.prod.outlook.com (2603:10b6:510:223::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 19:43:13 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::7878:f42b:395e:aa6a]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::7878:f42b:395e:aa6a%3]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 19:43:13 +0000
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, javier.gonz@samsung.com,
        bvanassche@acm.org, gost.dev@samsung.com,
        Hui
 Qi <hui81.qi@samsung.com>, Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v2] nvme: enable FDP support
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <Zmhf9-CaUe4gD9Kl@kbusch-mbp.dhcp.thefacebook.com> (Keith Busch's
	message of "Tue, 11 Jun 2024 08:32:23 -0600")
Organization: Oracle Corporation
Message-ID: <yq15xuf1fnm.fsf@ca-mkp.ca.oracle.com>
References: <CGME20240528151007epcas5p32583675f647553923e5ba4987e9bc6ed@epcas5p3.samsung.com>
	<20240528150233.55562-1-joshi.k@samsung.com>
	<ZmMj3d1Rvv-5E6Ey@kbusch-mbp.dhcp.thefacebook.com>
	<20240608051740.GA24010@lst.de>
	<5e686875-21de-869d-4b19-bdd9e272d690@samsung.com>
	<yq1r0d53vi4.fsf@ca-mkp.ca.oracle.com> <20240610115541.GB19495@lst.de>
	<ZmcTHMWb-T78Crfn@kbusch-mbp.dhcp.thefacebook.com>
	<20240611054726.GA2680@lst.de>
	<Zmhf9-CaUe4gD9Kl@kbusch-mbp.dhcp.thefacebook.com>
Date: Tue, 11 Jun 2024 15:43:11 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::32) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|PH8PR10MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e763d4-8f8a-4b80-3c4b-08dc8a4ebb22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|7416006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OZfHtD0CYQs1S3kuGQprgi7RgqcHPIfQ+5DOCqoj7TEA8iOP2a21L3JB3a+V?=
 =?us-ascii?Q?APcZx1i6tS9p6dUBaFS4Zk3RZM4Nt6b8xmkTE9+idbqfVcdNgYi795ZLiSLv?=
 =?us-ascii?Q?LrkqALETvk8Hx5Cj27GiIO1QOzLZ5nIbYLuxcO6ehhnJiQtcGUyO/7FJhD+c?=
 =?us-ascii?Q?sqI28QJrjL/Zo+SEJpJpMZ+BLaM20/AhrseLosN+I7s1PDkDqd2ZIJG3k7t/?=
 =?us-ascii?Q?lYlOFX5vue67ae/poJpS4fECnC+lDZNfuzhAFb1+8PDjv0VbnEM+2/uaetZd?=
 =?us-ascii?Q?o7IKjWhN4WST8YVyhXBPTd4f7VQ019k5jtrsRlIXmR9g7ZrTAckTa1t38xLv?=
 =?us-ascii?Q?xX9+t3GIzAJuZhyOljy1Pnl8xsWBlzExcOnWdpdn5yeIijrdCJjFxKjU98Dh?=
 =?us-ascii?Q?6zy5NAM3G7l4AD7gkgtuPnaq2VduuC4FyscrAkZcK0Z0tQieNBlJy8dBHPk9?=
 =?us-ascii?Q?UliBsmRWtD24itZ0/xst54Y7Ya4mlAm6szt6n9oAc++moctBxEDgOOtlGAtf?=
 =?us-ascii?Q?waUcIF68AMC6DLW/AjFC8jCGe59ag8iwvdDrd0mASrXAXmezZIEMlb7VJsZo?=
 =?us-ascii?Q?5grJqjZOA1GZWbDHKiegbaAropGzmT+RiXgxf/mFxi+9hIa6MNb07Qwem4md?=
 =?us-ascii?Q?gvKP3YHc2pUHP8bto/zKBORbjIlf9jcYreGtR1emQfmEGnEdN/vYGceQcyb1?=
 =?us-ascii?Q?bNoNwDVVYIIOmMwK7D4qY0fURPB4+W40A2QGeVkg7v/O9rHWIiOFSNopeLTy?=
 =?us-ascii?Q?OxtVZNton1Z/Z+6PCzNx1hPyU+cJKbtjGzbY96IwiKP6laTicq9UnKuMlnjS?=
 =?us-ascii?Q?HJ7ZLH3xoFiqx6vdrrHGJD6wp+mM71WwqZMgzEV05tttmx3YdTYDm3qZfYME?=
 =?us-ascii?Q?JE3HkUy4GdlUJ/ZFgU8PjZI5/PqphPELgdGCV/X3m6ZTsXYOtA8TlDwrET89?=
 =?us-ascii?Q?x16mVRmjuJu3BGvOEiOwRwmkzFCjMWUUsVrvLdWQyovS3YIFZAwnpfTOuf+7?=
 =?us-ascii?Q?eLQjYaJbafSZlyPXX8XTBmEMAA755ITr0F4e1QIXFPO6w1bzbwISqnh4qLBv?=
 =?us-ascii?Q?R905T72XXfhKA2QatRQafpqOJyScWZrrl1e4HL9tbPLAjMSANza4hOIzzyBY?=
 =?us-ascii?Q?/0SdjS5/MV17Q/by0sq72Ia00WmJywYeJ4DROjV5OqXmvyv6M2VNDIZOTzIe?=
 =?us-ascii?Q?TA/wkb2vjCEt9iDfNgEKhc3/0bOGpr6Z1dXsHY3oyAcC3WtERR54W2oc/gcs?=
 =?us-ascii?Q?iCjkURJh1l9Moodl25nx2oCVS7RlKGbJSKb71iTOlNACuFQcbm4+yUvCyeWm?=
 =?us-ascii?Q?DAOb+kF/EamrRux2Q8mSS9+Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(7416006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u5fZfXQ7htl9e0LAnIe3aMDEwjqQ2bcAiOs4F6ZgfcrTxFMF6fPB2XHrZnoM?=
 =?us-ascii?Q?PokV5kPOwgAcqwkL4SEC39H/c9V3tnOQtARrDPMCgeFaL7RXlebyYeTc0b22?=
 =?us-ascii?Q?Y+tGG1kpQeHrdTbWLwvcCHgEEAWpJgS+C0kt8Y/5Bckh/39cPCzIkLN6EZSc?=
 =?us-ascii?Q?qduY7DHySPJpxlpZQ+FXoesyEYjPEr1iYftgjJrqyMGlXIqS0KCWc47DLxvg?=
 =?us-ascii?Q?W0SWT1NFOlo+CJ4BJmtKAOsh4Y14NWt/Hpn6Yi02m8aymJ0OnthZrBGv9DZr?=
 =?us-ascii?Q?NtIdtoM1AWCllIUccAQx80v0Lt9dhdFWSKr91kQPD0Sef1csVp9uqT/Es81s?=
 =?us-ascii?Q?4OBcD2lSJRIid4oBh+Ix8noPpN/GIWPqL7udKEq+SPOz49DJJSnZxv95/QfE?=
 =?us-ascii?Q?FE+b+/ZAQqcTgn76TZGENbzpQS5DG0zuZCpuDc4ptq2VEFgyyeTiEU+cDFVU?=
 =?us-ascii?Q?DgRVJzLHfA6E1Sd60fJlXeV1gc93VRYY7n4LzvLQlyojHKmDYXCwWwQ+2MQT?=
 =?us-ascii?Q?6iL+uCEVOy5/5B5UGfaPEM0b6tZzVe/VeKh4MC0rLgIWnGpPyNkUXOp7V+ye?=
 =?us-ascii?Q?amXUS4WqljllCiW8GsevEVWx79jgHz7MMGeLr13bREYNJXrTie9aPnCeoxP4?=
 =?us-ascii?Q?pLHKOH31glrcsIHTuE6Z5Eu0uq+m2JLP9LUP+a3OSP8mHbpxIjP8tQoMM0HV?=
 =?us-ascii?Q?TVd8dhsIT9tozn5ZJ4bhbZ9Tdmsw7DwqQxE3fMvxZ39CxmisPpa8MWF7s7wd?=
 =?us-ascii?Q?ihmAqSGlaKYHeghoXEQTvMAfLELJgo2K8Pm6Zb3rZbeax50C/toajE7vGBdX?=
 =?us-ascii?Q?7EfNTrRVMC2AAW/vVe7o0YZjcrQUjMfoiCn/+m98mR3nQsDqCNj85d7rl14D?=
 =?us-ascii?Q?x2AOHtA5dzYEABU1zQTddtPyQsXl/gufj7aPykjAVpVzn1DVL9EoJp08teTT?=
 =?us-ascii?Q?G30qZi5ghXOy41jgmUp9RrGBFil7603kXN056jF4DJVUaIt9Ae/KkBm2vy/p?=
 =?us-ascii?Q?TSwxo3L3cq7iu3saoOSgna2RPyEInAI8+NYMHYjkUb91DbZMfuLh4WuI3Oes?=
 =?us-ascii?Q?1BaW1+08lR5gEuAMyM/WPS9sNwyD0PUjNQUfXr4Uru9zbL4MEHdjqL+INUDQ?=
 =?us-ascii?Q?4arZMUxc/Nfy1F8MV6YMkQvyhIKEFM3YG4NADi8bGEPqbxIjdcN0gXmLZzcJ?=
 =?us-ascii?Q?LM+0wgcaabqmGnCTnnLS2oiihzFq5zsUXiyeHKVNrkDwXBhhIcwQEFRbnglv?=
 =?us-ascii?Q?LwxOq9ye6yPoYtBCHrU/3XwAPkWGF+meZf+tg5lftGdIL3r4uiKXr3N1C+E+?=
 =?us-ascii?Q?SslrMs7lg6pV6pK0OvuQ0+3aGh/wPDY9BUcqC37jBGtNysAWk8BJccmNcm5E?=
 =?us-ascii?Q?C+4Cmt8/txyvcVTVpuwRHFPtjXaiEmFfzu4vyzjCqYYJI2PUD0JusfGs8ZLM?=
 =?us-ascii?Q?bsDPtH1L2i/tt7b5zPpJJK0/Mgt1UhRK4z99wpde3g7dtq+elZfMlv1jFXx5?=
 =?us-ascii?Q?abJi62Zx5PbXsFsI5FPo0Bkbgd0Q3FPEdzFZ95bCfgXRasRAsU+b+/uR3jZK?=
 =?us-ascii?Q?vZ6OPBUix4pjAWyTSAwE+v2rkPee9hsH4Ey3WrMOx1NmkLR+7Uc6ibwy/Try?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5V17DbHL5/8d7hKkWIu97S0THu5rphOWvfzJFG8wLbU+l7jYzMXzlEjdhd4B63Gb9msqIbLdyhv4ySi+XisvVxPOSm5IRgVCmQ4Dky/hKliYUPmk+eurYL9qm11JrBjhUFP9GihN5mQq0GBVM4zNbtT2DoS+n50OIZ/w36LEc6a4lOpuJoM7drZNlytlUm91RffrBTijOxBzWrqsCSVQzuooYH2bWvbqtZwZ/M+uTwTJtXxMiFYgfGmVvklHUWh0p3bFFy5x6Stih9sgUJBl6VyS1VyMiHqTPBsTzHpt7g8/D9uagTG0SHKe00ZpzHmhXlDEJknEDUX7ZncDUGsu1K3ijccQqIAOgs7Ch2Y6dqoasu1+KuaOB/WZFt2e5NBEXOmdAOA8Fht2NrMtVRd4UawlHMXrJoC/FukTweHX6pHVYrNgKBtP+WKElibBho9NuiafGjL3x77KwSpN8ZMzEUGUVvQKQelhyhTAOGvhzpk8cDaibrCw4L1G2wMOwSXl8wCRBxtMqx2oQrSg4AYMl8gZ+GEztz5Vv/4whugil7Lx5J6FGXceO8k9QjVsv5B8l1z8BzrHAJMxAOw4CRgawsMuqaTz3wGLJk7O5m0suLs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e763d4-8f8a-4b80-3c4b-08dc8a4ebb22
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 19:43:13.5756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZStCgt4eLuyLSsgUu9qhVBuXKwABHb0cBjcdsAsBv4fqI4Ni3pWSSbBL0gjanFhjzJAzO2jRgCSJrTb2UKUMc4cOiux7iRZE1dcUOoWDYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6621
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_09,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=2 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=2 mlxscore=2
 mlxlogscore=170 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110135
X-Proofpoint-GUID: bw-CMqrgja-oV5DziioPgHlyJNI9YN-Q
X-Proofpoint-ORIG-GUID: bw-CMqrgja-oV5DziioPgHlyJNI9YN-Q
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_124333_172171_71FC8306 
X-CRM114-Status: GOOD (  12.94  )
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


Hi Keith!

> One thing FDP got right was mandating the Endurance Log: the drive
> must provide a feedback mechanism for the host to know if what they're
> doing is helpful or harmful.

Good luck teaching firefox what to do with that information!

> If you're just blindly throwing random fcntl hints, then you're not
> the target audience for the feature; you're expected to iterate and
> tweak your usage.

And that's exactly my point. What the various attempts at data
management in the specs have in common is that they are unsuitable for a
general purpose operating system and its applications.

We can all come up with a restrictive model which works beautifully for
one particular application. No problem. But that's not what standards
are supposed to be about! We used to produce specifications which worked
for every type of application and device.

It was a beautiful thing when we went away from cylinders, heads, and
sectors as tools to do performance management on storage. An abstracted
model for managing blocks that has worked for everything from USB flash
drives, over spinning rust, to million dollar storage arrays. With one
protocol. For decades. And still going. Because the abstraction worked,
and it removed the burden of having to care about device implementation
artifacts from applications and operating systems alike.

We need a similar model for data management. Something which works well
enough on the device media management side but which transcends one
particular application or device implementation. I really don't believe
any of the currently defined data management schemes are timeless the
same way as LBAs have proven to be...

-- 
Martin K. Petersen	Oracle Linux Engineering


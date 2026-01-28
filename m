Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD69CD35692
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jan 2026 08:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dPizeH6Vqb6+WJ9aOq6avTlc0S28WQ9/9gwLbuUkYDw=; b=YZYCuKMPLyGztvHDaNqDIUVStS
	rys+CulosSB3pMYJzIkxYPV4gbeQHZ09ADqT5KA9JAKv++xhddUlna0dLpGOzX1xCcs6MvPZK+Plc
	7TdsycnG9HdbWSoBA4LIrb33tyjdUWqwBGTCV4CZUWC92jjViOyOyoLhbpBa4pk8qTPe8qUbUDj0u
	aQiG9R+sdO7qZKbmfzjgKs+KyBUqPz0E4oY3T2Ct5SgCHk7mAdnUop8uRlrEOuF6B8l6EMDbpm6Kb
	CHJ4fLMycu7YgtZXWT3/Y1KCaLXPHU1HwV9mg2hdMlRMB1VJqqExWWom/ZaabXuOeZp0TghjetHup
	PoaszLWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl0t8-0000000FfNi-1HQC;
	Wed, 28 Jan 2026 08:26:58 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vl0t0-0000000FfNM-0uGy
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jan 2026 08:26:52 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60S4CB6G837976;
	Wed, 28 Jan 2026 08:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=dPizeH6Vqb6+WJ9a
	Oq6avTlc0S28WQ9/9gwLbuUkYDw=; b=hy0988ZxIMlg20GfES03uHcG4KSeQ60D
	tpvnGDQVKGV6qLu7XILAA/rVrfpFCplDc60z6u7Xf2SbfbGLokFUGVs+q7yy4kpn
	3oLziQMgbYcV84XkLy6pCjvYbtGXmcsb7NndhwFU2FekfRiZXZSyzcgiVU3NBs8K
	9/ehP/6i0ctHyZVMmEczVX6CjTbwJV/ArLT4WHtfcqI80Pgc5XdiO+PsE5HZd3EL
	H7j3vv7pKaL5RCj2sPXjAFuZzwTj9me0uSXkIGXCcp7yxZdP6qVM5Hv0cLAAGFet
	TGlk8VCSCMvVBNxM6+QIZtABtUHktkv6/6meiY4GX67dG1d/ZhLxRQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4by378gy3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 08:26:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60S6O1K3010792;
	Wed, 28 Jan 2026 08:26:36 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012066.outbound.protection.outlook.com [40.107.200.66])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bvmhan02w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Jan 2026 08:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xOliW8hOUBcrHhDnkZmkra/6VgFpdL3FOoXMTzd90WhP02QG6tC9pyb+IE+AGvYqdrY/hc0fXQ7+ntUsPB0ZAeADiONVx2MmcTh0TM68RMIJkb9qhB2w7R7EwKJfautgyGYWbsJR9DkgvYSCC6bCR2kgCglqt+dORj3LOAhQS6VeDeThBhDup2DuzZHj0pLzGVjZ2klJvqWYgzoslS2MW6TDubeaxI/Do1UBpcAmp4DZTIIAtn/nqV5ZqfS0I4NxWp7EYrIX6hj94rJGnZLILDJ1zwQoJUQyG4LlX4d5S4giPjyKo+r/kozxf7jHwBIpisZP+JldCXkfzA+yAQu35A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPizeH6Vqb6+WJ9aOq6avTlc0S28WQ9/9gwLbuUkYDw=;
 b=ebIRoX8ohw4N3oe9IDTCCpc6JA3f0s+u1SJStcFInHs9B8EAFW685R5YG1Kf7MzmJ1zRv5nxj+6F1f58NE0ID+yEXY5pdNDyznKTo5NKyZ7FLLQtmhWmYtzmZAN0GCa0if6EXqd0l66oIOeN61Cik207zntTRfBWE9hKPVJZNmhLbf1aN1cf16i9OH8KPc1egbP01QsHl3+tyAgfQ92fuS+yNzDpXesB/NFpMerI8q92qk5Z/vHf/ZjMBxGagbvZ8mkRIMUQo06o3xaeZoUaKjal+3NVvqG4B3cEC73UclyGpBGedzRfLrSvLR8jm6bfHLw1m5W++mW/X2RPnei1mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPizeH6Vqb6+WJ9aOq6avTlc0S28WQ9/9gwLbuUkYDw=;
 b=rINxqwD8s0fFas0OILd0CB+k0oPMyQ3/gwsUIPa5S6lepF0nBzrJzZGy7QQZjgOMHPNKk22GXXl6rwl4QcN7gpCxfNfApWLeHvaP8KHL1LsHHCPtHtYWJrqSLrxfGyXrQaFoh93pvPZfYPhYNdXw1MBxJg6HbmuAAg2sbWkDg6E=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by BLAPR10MB5041.namprd10.prod.outlook.com
 (2603:10b6:208:30e::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 28 Jan
 2026 08:26:32 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%5]) with mapi id 15.20.9542.015; Wed, 28 Jan 2026
 08:26:32 +0000
From: John Garry <john.g.garry@oracle.com>
To: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com
Cc: martin.petersen@oracle.com, linux-nvme@lists.infradead.org,
        nilay@linux.ibm.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2] nvme: stop using AWUPF
Date: Wed, 28 Jan 2026 08:26:23 +0000
Message-ID: <20260128082623.3945303-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::32) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|BLAPR10MB5041:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b4a262f-6421-4b65-504d-08de5e46f11e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ofiH9ZXFDa05m7ONQwcRSy20UvJIPS7vwMAAmiImaEGqpGshRXh/70xiho0w?=
 =?us-ascii?Q?cplED/MkaaLkp2MR37JuwxFn80jwOeORF39UjRa6/IF8Gp6+fEf8fXtoDHa2?=
 =?us-ascii?Q?gmnc9PD3CWUk/petBsusziJqR72+VR1v03EXTwzu7lx0mCM4RrTi35hQWkVd?=
 =?us-ascii?Q?VFySxPUdmYNa7IO2H8KGRXZhkydlswafE3CnRHYfxaGDf9S/ON1XVG0md6L+?=
 =?us-ascii?Q?3pSA07wZH9Ov4mAGkqDyRLevdzIn5yqlmg+mDuT47dRs8lpnGVjJURtJ92Za?=
 =?us-ascii?Q?/YMEDrbgT30TVptNBOzqqNK96Z+PU5h3zukpeSFM5HJFxhsjZXb0VWaG7P7W?=
 =?us-ascii?Q?yqbPtX3gHPylhpK9vE7xWujpECN8mTsc7bRD9nnhZ5Y/6/MP0pxr4Og0hNge?=
 =?us-ascii?Q?/9k+OFZwVa2cZS5yjY354idg/VqN7U6MhzUdYLgrU8P4nALljYsq9cMagUGf?=
 =?us-ascii?Q?4As0FFLYiGCP3uIx7IRiHjcbP3DG0p3zI+EirnJ3RP6FtF2Z6sJ3FcuJ9TV+?=
 =?us-ascii?Q?nGTKe+Z/fd408WEz95EuHs9zlYPWoM/8Syk6DGR3My1wmppmFSvWttkHykEi?=
 =?us-ascii?Q?H1Ipe2qhQufjj+VnkbGH7LIFnVKLqwbnxwdbo+M6g6pxafWro9cQZopWqHKh?=
 =?us-ascii?Q?oNsYWtiUM2BVEDaaTpvdFY3ZInxD9X865FU+ogSW7ZjPmwIqaG3wI/7DNwSF?=
 =?us-ascii?Q?uC+vTtLhJMCLbAP22sJGSwlXgGQcAakvAB85rBgcwwv2QVJtM/xx/djUIqEC?=
 =?us-ascii?Q?OMjSJ+RxORlblxnywPZ9L6NyA0H7ZcMYvYWGq4gIMIX/JRskF1x0+oCilDeX?=
 =?us-ascii?Q?ZXkh6OwSI83vqSAMDUlH4brY/lsDbm/qfKK/z4eqwOc9AAv2PRbgsm4fsCbv?=
 =?us-ascii?Q?QByO4/u5ZWsPVSLSjIJFFlqOjpc/EQZra74i/6Xdxc8/jhhyUGWiHxDhMKkd?=
 =?us-ascii?Q?6Q/RFCZdIFpcFpkEuoqqdvLTFlLRAnBYSRxgz5/450Or6Y793leRkMW/twDj?=
 =?us-ascii?Q?GIpjVsNp5gT/mwCBqllIGIiJjBWyS28+MACxZCirh7nMiLh/ZFOqhfR0NFmo?=
 =?us-ascii?Q?zzsAuiNbq6ziDw2cwoiRNh7Hn4AfeRTuiIxD4ndraI4GpIyiuXHANT222LrB?=
 =?us-ascii?Q?Zcat7R9V3pjnSkkgGOT+aLDGn8V3YPut3Q6fbprhloqEUlPL0UqIs2mYkCoY?=
 =?us-ascii?Q?pqvVNXgBTuxClfQcVWY/t5wWjcVKI2BiwfaWddNhqTHhZO8usmK78EIJR+nR?=
 =?us-ascii?Q?Mr1N0Kn6rbhQDSEipPiRWV1OWvtS/+X+m67buyh+vWmW0KLwsRr4SiGKv4t3?=
 =?us-ascii?Q?6u2yMAM1fzFn5e/aAAeXVJ81DOh37zBDyx2DYoUwu6VCn+8tNEQlOeLkywI9?=
 =?us-ascii?Q?+kTbKZXuXWAy/VIZ3A66scfBXNrKDZT7KDs4uxSeImuYwVp3/8ntTO0qR7Zf?=
 =?us-ascii?Q?tPCw2Zrmxsa8FW9bhyka3I3o8i7jdreJNu7Q/l2GFVQeUMTZ9ZTHm+NjcouM?=
 =?us-ascii?Q?i7akp8i4Ydi3YerM49KVlrxckS849zx3e882ZQqyk3kJ9i+Wu/tXME6CMGGs?=
 =?us-ascii?Q?rfGj4Cg8dLudfts85yf7c+8eFLSPaTjI/3HF821P?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sa1vkBco8zFvsONmkm2u8IYrr8gacSHCejJiTYG7fBEiN6avrfmlPZ8Hh9k9?=
 =?us-ascii?Q?PNVo8+HNDE/cdMCsu0cpm+kWxYUnX/nJCt0b0aU/Xs+Y7gTOyikr6ZrWFzcD?=
 =?us-ascii?Q?Us1KZ6ZgCHfFeOKO/W2h0IkLyWcRhVDPn2tp4JbiFzIMdWjeVfbYn8OLeMCa?=
 =?us-ascii?Q?ac5zBqXs0ZrLTKRIGl4uWpmCAvz/b1LvPihMFPpYLK3xrQLkkF8zawr9B6fn?=
 =?us-ascii?Q?j+vcDfGKKty/nihhDw22lzkdRi6shN+hYVTEhPeAIVg1ePdhig6k1qZGK95m?=
 =?us-ascii?Q?4Qf7xm12sdmGEA+PUghIpgsglcixHy553xlvjzu7KnBh4OOZRnkKEERoO+oh?=
 =?us-ascii?Q?R9E0f+i6iAVTW/f2Io3W4lpC6fJP3OfmrK/q+i77boh44YGyFurjylMM2lba?=
 =?us-ascii?Q?HUAoUsCFyhIMei6z0IKb4+XEkWB5RCP1m+vWdkd/qGl9V0ACSI3kW7ueutm1?=
 =?us-ascii?Q?X4klCDQo6eSPFxHZrfVTxtCl832es7JxJ6wueRO5BUP4ZdPk3XRm/p45lSbA?=
 =?us-ascii?Q?7TJCgtbp+X+M9rzaKplF7jbKyrd5ZQxq+A3Dd1kehbTODncTKTCh5xMqotpE?=
 =?us-ascii?Q?DNMRSEMxDvCXScD3dlYj/7TLVFuU9h257ywUG6sQHdtIvCUGjkRomVG45MGn?=
 =?us-ascii?Q?6Vh7ufvyMKIwrnYEI5p5H/KrJweBWPDuofL5q1zLIfaP7k19039miJpuuJ8z?=
 =?us-ascii?Q?GDZuG6BcrOxMMjZxAQjLbX/o5fuH3VBeVl10bR8Depqj7bplEhIBXr3l/6iE?=
 =?us-ascii?Q?AQsBSAOPqlW60XhQa3T/bx/9EEAXxr2PqhbJEp0aPBSRrBP6Nk1TmemK+LXo?=
 =?us-ascii?Q?TwQwYDduNf8xtjVC140DnrxUxHzFFDKWOvY1cP5E0dXrHiIiD+bDTJ7gx9vC?=
 =?us-ascii?Q?DgEjCgL6Udyf7RmEVcyLllDbMLSWSl14LTCTq0arlIfDDw3K641eiHozuSEO?=
 =?us-ascii?Q?QjVt85YA6Sw8pwXmi9zfLWGejNuB742q5DEY3B/TmP8lyq+uzxgrA+xeLffU?=
 =?us-ascii?Q?mdKuBH/Si9rU0qstCx05fiGIgaZpgFJYzYeeoCoTR4BB/7/Oh5Rm/jo0MZKy?=
 =?us-ascii?Q?EFpUZBe84VL1XpPpb4U4PS3M/v5zVFq2a1kRSUZ+nSRnEw+SgdV7AwjjRv56?=
 =?us-ascii?Q?GqCaRyHd/YIfpAR/j77DgcASO6tD7wi7cCs6IFagdOBWg5/ig1JkTkJIe16Z?=
 =?us-ascii?Q?Hy70otqLkDNQzryY3JDuh95BFjop/bGCD8mh4XkorNEjgiz38ty44L61qcZi?=
 =?us-ascii?Q?59q+P+V2y2CG/tZB+mhAA6rrNjQ0r9zLpOQ9Pyg7NOJICO4KDOFc2Bn/qOG3?=
 =?us-ascii?Q?ncvMvFVheBda24zntLhN9ewuBtq31NcJlqtLvfH8ibWpPvFwy5wyp3m01d9e?=
 =?us-ascii?Q?yloZNqSvbqbivPBFC7mlGqRnI0fc84imM46brx6WtoNaIzc5AK49SPP479aq?=
 =?us-ascii?Q?Vwyo5KvroL+poE1PYmCx55/Y0RJbep53x+UXvmH4oXxdQrEBT3J6VZ6D5FJb?=
 =?us-ascii?Q?8IrZkcpfw4idCh6995npn6/FAVnX82YIG6yTdco4qZiHjL/UboPfLNz61/pU?=
 =?us-ascii?Q?NnOzKuxlkyjJ6XO7YUl8h7vWtiZYuyPclv4ax6DPx9zEA/FeCHBnof2AgZyC?=
 =?us-ascii?Q?Zyy1k3a+xPophsUVUDy+0gO7YKodbJPkVm1kjajB0obWpF3KoGIPOli2+lPn?=
 =?us-ascii?Q?Xkgf15nlKyEDqosLJd6dKQwKa6PBMpAob6mwp14FR73UA5lybAhezaoOW1D6?=
 =?us-ascii?Q?HZojwZQ3QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LX3v8qPi9dqLxFLiBVhLAzTxQzp7i4hQrnsAh9S9KCt0ghd7XEaDhIFaDlKReY7FrrO6ExQLMEStyTiM+5k2lQCxPZ8o937WZNT0swSBGaIXJDv7Wp75AFx+0T7xLZW/hyaJZCd00/DboYQ5/JzY1jA29gKzCsCehiXuHF3YL8viQvS4NKa7PKk1w0+xYbY3CUO/0BaTrlQBp2xB9IRdhVNMwJ+3JDpcom7uTs1PYxTNRpMDLS6VhqAV2zZVpjqhI0oNOOq9EryG5XDvgm7WTgmaPT0RvsEnvZxL+K8WZRGia8iCoCKXU/pHMoxuuSGmnerqAHs9kGx1GXbw4lFASymbU1kQ1bNGd2vXsKd97LoOgnCsoo4nibHAH3UHU4vs6DbNFlZx1hOg62ST5nY9q9LlnJX7ZScYZvEcIj3ayWdg9xbt5OhulqqmC+HhVTc2+emZS5h2gb00pl+6VIGi8F165eMCzDoa/IXz0V/YVFt5MnNGRM//nT6ma62ydyDIeymdL2m6rtXs9NghGFeLSlFvw2Rvt6ZgJ0qSbRc2Z02r5nQKExKLcJT+crBgaffRrm2WEqMLwCHdd8g8vJBgukv1q8k58jc9DfbjNzOGqJ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4a262f-6421-4b65-504d-08de5e46f11e
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 08:26:32.0857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SG+Mrk+PAiSsi7syZtuhj9mrk68YCNPh9bbljyT0Zu6OoJkfydyz/IFQOvfLWjURP6IymsG4VV01ZWSl2JvATA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5041
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_01,2026-01-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2601280067
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDA2OCBTYWx0ZWRfX5c68bH5khH1s
 5LbvFdjxh4ndZfq5cUeKcBsPRmYyr4RL0vU1ycTfhvFuVmyOaXu3xx/Gev3zUhVnWl08vVeeVyk
 jZzHXeHM6adpakjWvGkVLqizfVjxdJBVhcjmjat+hfhqk2BxvUUS6XBe6aDleXyxavoR/XPNaSB
 eg2JmyIm4/hl7698VrBc45gb8pa+NFJRRFM0ibo9w26jRU8dVqceq5RZkDAiv5+TYDnfs+Qlqvx
 deK4eBL468sah7jrVkGpWWoBRsB++ERtOs2IoSulZOsJCf7aCOKeCwplYTb8rQXDmueKbwTjp5p
 B3vdG1U2ei6VSNTAORaauQ7zUP+fUuVqSzhatHqZOiYbUgC5+MwwFU2WmxbX5B+HS97Psor/gXw
 vSUvnpQ8lBODTQR9++T6cUUVwcCes20r4L+rIeart3HBS+OvNIExstLXj6uuxfofz7oJH8k8blI
 jmoUsoWk5LnuK54laeA==
X-Authority-Analysis: v=2.4 cv=a/o9NESF c=1 sm=1 tr=0 ts=6979c83c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=aL16yPW91N_OO51uW0wA:9
X-Proofpoint-GUID: w1musUUH2hqLdp-RZI-4Q613lBF52Ryx
X-Proofpoint-ORIG-GUID: w1musUUH2hqLdp-RZI-4Q613lBF52Ryx
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260128_002650_265061_F13AE261 
X-CRM114-Status: GOOD (  18.99  )
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

As described at [0], much of the atomic write parts of the specification
are lacking.

For now, there is nothing which we can do in software about the lack of
a dedicated NVMe write atomic command.

As for reading the atomic write limits, it is felt that the per-namespace
values are mostly properly specified and it is assumed that they are
properly implemented.

The specification of NAWUPF is quite clear. However the specification of
NABSPF is less clear. The lack of clarity in NABSPF comes from deciding
whether NABSPF applies when NSABP is 0 - it is assumed that NSABPF does
not apply when NSABP is 0.

As for the per-controller AWUPF, how this value applies to shared
namespaces is missing in the specification. Furthermore, the value is in
terms of logical blocks, which is an NS entity.

Since AWUPF is so poorly defined, stop using it already together.
Hopefully this will force vendors to implement NAWUPF support always.

Note that AWUPF not only effects atomic write support, but also the
physical block size reported for the device.

To help users know this restriction, log an info message per NS.

[0] https://lore.kernel.org/linux-nvme/20250707141834.GA30198@lst.de/

Signed-off-by: John Garry <john.g.garry@oracle.com>
---

Difference to v1:
- log message about AWUPF being ignored

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7bf228df6001f..83efc88ac0f98 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2045,14 +2045,10 @@ static u32 nvme_configure_atomic_write(struct nvme_ns *ns,
 		if (id->nabspf)
 			boundary = (le16_to_cpu(id->nabspf) + 1) * bs;
 	} else {
-		/*
-		 * Use the controller wide atomic write unit.  This sucks
-		 * because the limit is defined in terms of logical blocks while
-		 * namespaces can have different formats, and because there is
-		 * no clear language in the specification prohibiting different
-		 * values for different controllers in the subsystem.
-		 */
-		atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
+		if (ns->ctrl->awupf)
+			dev_info_once(ns->ctrl->device,
+				"AWUPF ignored, only NAWUPF accepted\n");
+		atomic_bs = bs;
 	}
 
 	lim->atomic_write_hw_max = atomic_bs;
@@ -3221,7 +3217,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	memcpy(subsys->model, id->mn, sizeof(subsys->model));
 	subsys->vendor_id = le16_to_cpu(id->vid);
 	subsys->cmic = id->cmic;
-	subsys->awupf = le16_to_cpu(id->awupf);
 
 	/* Versions prior to 1.4 don't necessarily report a valid type */
 	if (id->cntrltype == NVME_CTRL_DISC ||
@@ -3654,6 +3649,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		dev_pm_qos_expose_latency_tolerance(ctrl->device);
 	else if (!ctrl->apst_enabled && prev_apst_enabled)
 		dev_pm_qos_hide_latency_tolerance(ctrl->device);
+	ctrl->awupf = le16_to_cpu(id->awupf);
 out_free:
 	kfree(id);
 	return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a5f28c5103c5..625470b723b05 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -410,6 +410,8 @@ struct nvme_ctrl {
 
 	enum nvme_ctrl_type cntrltype;
 	enum nvme_dctype dctype;
+
+	u16			awupf; /* 0's based value. */
 };
 
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
@@ -442,7 +444,6 @@ struct nvme_subsystem {
 	u8			cmic;
 	enum nvme_subsys_type	subtype;
 	u16			vendor_id;
-	u16			awupf; /* 0's based value. */
 	struct ida		ns_ida;
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_iopolicy	iopolicy;
-- 
2.43.5



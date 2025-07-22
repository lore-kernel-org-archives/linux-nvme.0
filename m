Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE96C83F27
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jul 2025 11:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Date:References:Message-ID:In-Reply-To:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7E1nbVeLFSiIemTdUZWYo4bCZAWZdjO2ohnZ5PAjGBk=; b=xdHjxmzVG8JAyD2ED50N8fVGTZ
	WC0+KxW497EKWI4W678W0D8HT9wiHFlN+ABgqPXqO7E3T1f6G01Lr5ExWTC86XoIujXIB8OoE7y32
	wGjCjoVYmyRx3gITfs0a9skDjMhiD6N9j/3rLGetks+fM2mFxrtTfI/gb28lVDaHKTQU6IRdu9jVW
	g9Pv7pX9poGkd/1LFmioSEWXkFNZAmiD8UCySQ40oIigDB7LYJb2ED8PQItXNX4XP3RUK1KL8tsxB
	y69yxFiWNqkqhrO905qs6KaIob5fqeB+f69R/Lr5Rapc4avsu4Fkl23B2iFfUZrYPMq5GDtqBe7VI
	pC4aQRNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueBeO-00000002M2y-3vYg;
	Tue, 22 Jul 2025 11:59:16 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueBeM-00000002M1W-3ABn
	for linux-nvme@lists.infradead.org;
	Tue, 22 Jul 2025 11:59:16 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TD2I021372;
	Tue, 22 Jul 2025 11:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7E1nbVeLFSiIemTdUZ
	WYo4bCZAWZdjO2ohnZ5PAjGBk=; b=lChbZpc2T06cNB6NvyH7ECJAmMr4LyZanW
	c2+/BCUm8hw2HBdBr4HCXVh7F2rPTF37rGMp9VWF67uW7Z5lL2F9TSlduJu/fF8T
	Xt3FkIUEjnF+XUETGj+gZqCy39d4oPRPO1bdeO6xkGO/+mgPCQjU3mhEQ/ianxCr
	cznLG+zrC1SwFdBa61foycE0in++nA5wayxY5/sdskjEVh2zLAtP3Uk5kOE8sBAJ
	1Y3lnyOlRd0xbYFFUOELXIcsn51rvnndRER0FUXXeautSbbwg6XKwzmL7gpD0yJ6
	tMsxkWUQwCViHz43uRlAv+ukQ5fY9SdZpW1M7ht5jUw7AJ7jnKLw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9n5h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 11:59:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MAWcuK014398;
	Tue, 22 Jul 2025 11:59:01 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010025.outbound.protection.outlook.com [52.101.61.25])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tfh7sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 11:59:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ly1zz0WDTzOL9vR4oIMJ7DgN/qyJ108ROJ51N9txQXra7MBg1bighe0fqFermHRjHNobydUVODYsb4U/Vw3ka4dPa/5l0ZS3Mn6PWBeV319km+QbkxIowtL7gsAkoNgFBagzdZfbAhG62e3LJu3uYY6abQ8wPUkrsoep6XWZghHlHvxhIFuJWqDPnxCLsYijyLtcJDynQgN+QODXocOmWAmGSRwQ0g7MGj6PSX/DrMMJp61okygLkBTvJRlFZLSuFrjjR+oPPMtPbXlJVIFpp6unEnvhCLG4TiDT6yj8tM8y3DUFtpdgW2s65OL8c4S4UXlvtdKYHCYQij6QFOaQQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7E1nbVeLFSiIemTdUZWYo4bCZAWZdjO2ohnZ5PAjGBk=;
 b=ljsbfRP46RqMQfRB3MINenYQ2Vaz7BNJVccmgvOIydzpKKyfF12isPUvZzit98AdEdQfrIj08NJYczCUoWCnAGgkmLHxfV2K97zPqUXBZZwVfwSaEpG2CyjVQkllIVvWCYJmXbDi8M9K4OlU9CKdn4nnA4giJl+ym+NH+Aln+2IDGc7wJQG/AYvknu9LtjV86+T5wxLUgSaBK/CbrQeEejG6y5dTLdf5N7DBN6HIK9lOIpAypgEkXbvqA7uPvXfWfd51wcaOwEdDZBcmNj74pnwDMkzD74A9OMElusuoUDhHeN5IndLITF1G5+Q8lZHkEmdbYXCy80/5af0y7ELRIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E1nbVeLFSiIemTdUZWYo4bCZAWZdjO2ohnZ5PAjGBk=;
 b=PMlvMlNGH2K7S8Nl8JHneUzD4ggUDHx1oAdU38lekpAJvNdlVImDSkxbWI675aqywx5o5s2HKVVAgM3o5tUv0PfmaYc/ox1pJo/zLlrRtppdCgPUpZg3TEgt8D+qKHTvxZgnWg9QrIVFD/pQP3D8e2aEPQ25iF0M27hza5mY1tk=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by BLAPR10MB5122.namprd10.prod.outlook.com (2603:10b6:208:328::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 11:58:53 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 11:58:52 +0000
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, John Meneghini <jmeneghi@redhat.com>,
        Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
        hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        mlombard@bsdbackstore.eu
Subject: Re: [PATCH 1/2] nvme: check duplicate unique identifiers in order
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <da450263-9944-45d0-aa58-f4f606f88c6a@suse.de> (Hannes Reinecke's
	message of "Tue, 22 Jul 2025 09:00:22 +0200")
Organization: Oracle Corporation
Message-ID: <yq1a54wwiu2.fsf@ca-mkp.ca.oracle.com>
References: <20250509151627.20434-1-bgurney@redhat.com>
	<aB4gO7mAYDO3Bm3A@kbusch-mbp>
	<cec53fce-2f1d-4162-8685-ab7c56649953@redhat.com>
	<aCId7XmLnrLWZPdk@kbusch-mbp> <aFrBVeEcapNtOvPx@kbusch-mbp>
	<1352e125-180b-4ec9-ac3e-1cd8570910a3@redhat.com>
	<aHasJPv2Jb4bQ3ik@kbusch-mbp>
	<da450263-9944-45d0-aa58-f4f606f88c6a@suse.de>
Date: Tue, 22 Jul 2025 07:58:50 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0201.namprd05.prod.outlook.com
 (2603:10b6:a03:330::26) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|BLAPR10MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: 77c5d2d9-8666-40f5-c8b4-08ddc917209a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FKhx1oohCWJTnrvuQCLvTBz0lcYypqyGMycdjFQpDAWIlTnVuUB71E4EDJiA?=
 =?us-ascii?Q?pOpZn6dSxjeXOx2JB+Hdd8PfXEiNquqE5RHxd04V9TON/Nc6MRKyfz6PfSyA?=
 =?us-ascii?Q?tFjC2BTBxRXhQG+IlZsI1lbN8annN/vDsUesit4DjIdwEFkys0fKoCkAmRWc?=
 =?us-ascii?Q?BGFdlh48RYBQ2VMag9FEYzvbQQrGVkifo3sW4QxrO+sZU0cX2+ReggX0DZPP?=
 =?us-ascii?Q?6IdHJDz2kQHtItPAzjkyC5IqE+x32UpTX35OsIorBEMwyeiTKn75r5X2QcdR?=
 =?us-ascii?Q?rXowOwE/r5M/+oMvSyVKSHlOVKwRf68lJTzePaWPSVFCCniPi6MVmzQbwFJD?=
 =?us-ascii?Q?v7Cmdo2WXPCM/S9rylU46zYGzIbdGtLJK8QYg3zAGrW6BdB1cBCvDfQ1cjfF?=
 =?us-ascii?Q?LftC0D8eAlMQBZSwS3ukbp7P9IXI8nAWAYcvnUgrgLhmpP/cL8CTcVO3YcHi?=
 =?us-ascii?Q?ZvexH4MYPu8NDNb3KNbBLjw56FttU0mRi3j+k7kW+pRXjNrN32IrjIFqT+ax?=
 =?us-ascii?Q?IN9PTVRAQLXagrMKna2MxzUQwuzde/SEEgPVj4dh4+xNiBYeZBhSq9WnVIB4?=
 =?us-ascii?Q?I12o/WjaTSb3BhJ10/ik6KBRRxYAI1gwRK3Cu81dG++vOl4wi6KIoheAcBSM?=
 =?us-ascii?Q?WIocTrp/vYn4p7TuiSxNOCCRIuNQzJqDDWKRUwY6hjiBQo/MmdOcBlyfEZIG?=
 =?us-ascii?Q?7NIUwD7mYVupfLdcc8MCcDaAEjdp8JhviEGqplM1EBhY5lIB+2yZFxnLb365?=
 =?us-ascii?Q?YpiFwtLrgNpnh/ORACwb1HYRkg9skOyd5FIVouTjq9Q6Gk2v1RlPgMgg63Ey?=
 =?us-ascii?Q?YnIDY2Gb0SPlP30ejbTpX0VPYXF3ZZgKXwnaiqPMBqzMjQpf8M3zDgybeXfA?=
 =?us-ascii?Q?ieC8SvLdG8JkUhx7cIlg6NmHkj19f9zoJNfWHagOgVWtTHFyqgEB12sH/G8h?=
 =?us-ascii?Q?e4fP79RbNGvk59mg0st4Er3MfiWJHRo7pRX345gzp9tqs6e4czEIJt3VWJXV?=
 =?us-ascii?Q?ZNBq1dRkFJvUx9NSPPQgSo51rfepoqTh7b2jvTHwmUk2s5BZT/NLE+DolwAP?=
 =?us-ascii?Q?TynZQ7JVfk1HAqpVZ9rl1UCKLz1EHjdq6OoxbEJFAoOv9HVXDPZfrMmmXId7?=
 =?us-ascii?Q?PU4Kwah/S/yaIH9YCrZ9D2ZSuvGa0jThz8pS9Vkx0sf8CEgkL+JpuRyxU15j?=
 =?us-ascii?Q?ToDhgli4QQmzHzpkagqr7/uathFKRajPd6ABi2cV8rhK6ElRUn6a68cNK26h?=
 =?us-ascii?Q?DwEsbwAXpoQIFAO8J0Y2tUV4Dl0glecOZRtqQpfm8xL5fdBz2t8pUMlzxedc?=
 =?us-ascii?Q?tDMIvZCPiwUZxnl+jltY6yS/Ougpek/XL8KkKft/6aRQ0sqlDhM2bZLO1RO9?=
 =?us-ascii?Q?YL1+MqWV6Yj30SO+lN+8lIsF3KCRYMBtcnwWYyMUom9Q0wxy1dFIUSb37c6H?=
 =?us-ascii?Q?OMDQYW/+Eko=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0bCVmIHkBzGKtnobrFInc/jJmjmJFNU1Ipctf6NQ22qPAWs6vtENPC4fjzhv?=
 =?us-ascii?Q?pxghMs4VD24geLAQO3/3z4EhmnXgpvZf7imba7I87krQuvkxV2DCmCPX5HNG?=
 =?us-ascii?Q?mTg0f0sm+tFPMYL2BQF+p0UeAIKawUZz7Tlfz3kLQyw7I3unsp7EWOQpJnXM?=
 =?us-ascii?Q?V/c8mQfZ7swgQcOXGqTs4CjuYIxBdyAgCRVaqeYjMJwkAqvE2rygkLlI2nql?=
 =?us-ascii?Q?DLH30mhNxGcYl4tDaPXY3Onm6UJD6bqLmFSSuRjaMm+Dywkpzgc3cGmMAk7W?=
 =?us-ascii?Q?3fSnJjCqOkZ4/7eiE+tH0l3zsiGz8bUbvPmNYalzzw6ZUKhFvqQ2ANW5QUgp?=
 =?us-ascii?Q?+zslZnQQGDvCpwyAyBHwYDj2UjbhbYHAVgAcupqF+ygH7v2zIBXlsBQJgh0j?=
 =?us-ascii?Q?CTQB3gpuMXC9ZNPPFdKzuGscyLRkt0Fb+OEGRTI6H/3bsc51gzbOGMmlwzEi?=
 =?us-ascii?Q?WCALVla2WV92TLz5xMRqt8+p4fHUITRYQLTBYIsfi9dJIFTskKuTJgj2zxRT?=
 =?us-ascii?Q?4WczQ1tUF9jBybo+bXYSicQBvYwds49csw9Y4wX2NQnUgsGMu6X9ygf2VRQ/?=
 =?us-ascii?Q?jc3nJqiOY9Ox6P5Dv3I166Dn1+zHL1VqsK7a+8/c6vW9oi2cQTPWGgX5oVJI?=
 =?us-ascii?Q?u6fMtzc6EgognnmxnyJvpM7ar/cK0yt9zy3rYiWE5FMGYDE5Xv09RQNgfxCU?=
 =?us-ascii?Q?rp8+ntWznTd08mKcFLw/uOWrcWZsCLcAib5UwRyREwQ1UJ6TQfosq8Sp2grL?=
 =?us-ascii?Q?VKyVawqShddEUS6iHI1aj19owePgpDycPHH6xFtNv0tpwN3GkxB1DS2zh6va?=
 =?us-ascii?Q?Xjz1q8fIwAOpxIljwJJvCCs6AMvqCMZaqz1twrSMuAizthdgEKxxUzI04q7c?=
 =?us-ascii?Q?WPP3hL/cUhBkTsb71FSNTrdlUNFaBJI/urcs8Jc/iWfJRDRFMS2anOREv9sH?=
 =?us-ascii?Q?v8AvIbpPJpFk1igmAnNyUDqsmx0MKVwnrh0FBFe610t8T6zuwVdtgQGdrUdk?=
 =?us-ascii?Q?wYmy4jkNyR2GKclbMeIWZ6iylivu8iTT5uLe9wx04YbCKE3X8yz+Q8W/PKD1?=
 =?us-ascii?Q?mWx/hWUc87OE24gv3Q9+I1aBtsJycqaw0H2opgSBGivxAJJdbNz4Qto4zksb?=
 =?us-ascii?Q?yFZPRA4iqjxXCP/fkrP6JQ9GySQHVHUC4ozU4bIARsh5TwxgMHLavTHd365g?=
 =?us-ascii?Q?yKnVzksc6ww++5B0DqJf0quHrTWzTs1+LBL4AmQrg81n1i0rJgqWthzeNAsF?=
 =?us-ascii?Q?cZWn/TzByUVj8wSbKZ28eEegQ3FGzDQ2zOwwuGy+E1Rpxep1P2bREBejq2zn?=
 =?us-ascii?Q?OG/hkFOa8DmZxb40hJPUDQisfLGk7ZG7j2rZa+rSnbWqNGDroe16fCKBzUSE?=
 =?us-ascii?Q?oFMrooTnvB/BxKg1QEQ8rK6udSNkEdumcgfz+2v7z3BCiRvZP1GQu6y4m/4i?=
 =?us-ascii?Q?DzSz3aWt3wFo2XpSxQ77X9n3PQhnGNoEgwzvu6jzAi5ota9oPZ4sDGxUDnNY?=
 =?us-ascii?Q?fiyoNPsj+RQlCoFt/Rak6GgJ7Z9vFVCJlPBpI1wf0lbBPke+A9RpEgf0ZYQ/?=
 =?us-ascii?Q?NYbFfk6S1VtmduuqtubF7iayTBWO/cabkZfjaUSiqTs3Q1hmqXLG2RAHVxjQ?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ACJedTor8qgnr7kBuvj06Y9/jTokpokuPV4lb1zxPUm8KWuATXoSR0TtJoyPWo8LfkwjQB6j1/h5OjakRUGq0A1Oviuyt1BgXKjl3Ab0MMxBuMpUj2DstSDflwloCF9ftcDbHCG3m7NXRaTLmgCDqSk829Ezrnguwua/erJSYSiO5hth07LcS+iLYWqhzepOpwgAYWfaYGmrzK++Op1uxX2pp96ACTApRIOZl2V0rdoxlM+nVgR11pp/Dce7QpxBJrA6ZNC1CEFa26I24d64WUY5OKzvQKXX0sjkCqfMlm21KSANiNcFDkMXMRm+NmKYq+DADrVFN0ngN2536AIqV02GzRGyzVS6El933Ws+RhQV6HTxDcrRwq6UsFCcBuaK/QIKskyEDuebpwmEcu2Lrz913FGPoTDXC7fbGoaPFu+RrSjes6HCWeYnYQlylCE3hmLy6e7TiMg4AkjMme5FakcnNejvtUzZUxp/9E0xuORnbajPsF51vGc1u/TO/UIbXUCOc2D52sz/OMBOTA6Pe2X5QO7XCQlGgBqlMu40sllrpAx2wzY1XpjhFdsn5bC8jXljMjfccClZ8urbHSFyQTimmdEBQ0Yv4rr/oNtBT0s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c5d2d9-8666-40f5-c8b4-08ddc917209a
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:58:52.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5AB2w4d5Cd02Heccdk4/d1cEU5thDoZK/pzH/1VmqsEbdsHOIY45WU/vuqlCq8MyuIBtPLmEt44u/TldXgPIzaYWfLB0IxSNxh9twyPbWeg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=980 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507220098
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=687f7d06 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=zDF34l4w--JPJBYp_vQA:9 cc=ntf awl=host:12061
X-Proofpoint-GUID: 8N_NXViTkDGOlEO27jsNvZ_tv7Nc-dUv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5NyBTYWx0ZWRfX91s7n4r/myqs
 cNkOVZkQD9+mYeyY4gqOQ1423cR/uceZ6FCqQ/pnmJ6oAssY6olspbNyhzfS1IXaGoX0gtkBp0x
 4P3rM1vSBfvdlUS/EsrS92/LHTj/yWVSng3lQnxcJlozVeb98YzzaxiIdaO0ArBlGm0QAduElTt
 Hmy+helhZzLlzSj6LIGtGzGBdRwBM8NnVL/ZDGnNJTERKKGan+173Jpb8Ti0KZ0B9hCGS4zcSOe
 sPxo9uyddbIWywfiwKYlfZhtgmxJFqlmCJz+/2ow2lMVz7Gg37RsO94q0LOzlUwAMZV7sREeA1N
 8EAfzpTpuQel+QyGaUXBvzHgim5EssaBLyHVyAfsNEx9YDCVADPq1M/djTUhMcHfs2Tu6mvMEn/
 E+R66bcTnI3/+VybaVaKIrfighh/je5RT7FBUFNfvdc1XmvCEKjlA6OyqXmUMVH4hwb7/mzW
X-Proofpoint-ORIG-GUID: 8N_NXViTkDGOlEO27jsNvZ_tv7Nc-dUv
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250722_045914_798400_F360113C 
X-CRM114-Status: GOOD (  10.63  )
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


Hannes,

> If we now can get Oracle to chime in (maybe with a different patch
> altogether?) we have all major vendors implementing different fixes
> for the same problem.

We have posted our quirk patches on several occasions.

The challenge is how to work around duplicate identifiers while reducing
the number of cases where /dev/disk/by-foo would end up changing. Either
as a result of a firmware update or as a result of updating kernels.

The issue is pervasive enough that OCP has a defined EUI64 workaround in
their SSD spec.

-- 
Martin K. Petersen


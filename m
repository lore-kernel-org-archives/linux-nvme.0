Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F234EED600
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 01:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Date:References:Message-ID:In-Reply-To:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s730Wokwbvs8yB6wuvZ8kTUVSV87CiRo6Blocxc/jco=; b=og3NNAlV3XSJaT/ZvRjnB3poGN
	/RHK0+pZTaEtSnPsz7Op/hb53pCFdwPaQn7IvYF4abMFlBIAa3Z3DuGx3byT6lNhcTpJZuD+6xuZM
	tjDUNvVod3RvizuJW7fqS1+OV1gLOWqOIkqh80ZBjjhBA0Kch26NJBf/Al/+V3pwVrPmnOMozdQM1
	INcpgERZD8KZAPkgq9iQ4NodJ2jawsYNtPIcuPUtNEGNTTgj6HT0p6seJzaqklZaUYsxpvEJWHaNw
	TLcbhBlOGPfXOEWPxs1kUs2a8YtwVaRl5h50hKHC1AphjonEm3Q+d/1ICLpxQgkANU6tm/yREJ0wQ
	FEsyxF3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sovPU-0000000Efgk-0urw;
	Fri, 13 Sep 2024 01:47:44 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sovPQ-0000000EfgG-0Gop
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 01:47:42 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48CMBWgY003203;
	Fri, 13 Sep 2024 01:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to
	:cc:subject:from:in-reply-to:message-id:references:date
	:content-type:mime-version; s=corp-2023-11-20; bh=s730Wokwbvs8yB
	6wuvZ8kTUVSV87CiRo6Blocxc/jco=; b=dfdOnDWgOL1uSS1jei0H0pB7DjKcoI
	Z2y46fZlaRdhzive0r88khqCqZtcdCZolK4poXD1zwnCv0g1j4AgQWBBImAfO5ra
	ZlA8YGKZ+p8/eNgNc7AaM6udrTmNNF+pg2S5Nqu1m01vhvU00pauqXe0ENGO6fqp
	0CbXevKUpWCW+X47xIzvEEEp+gnWBchxZ8a+jCNdOoYPguczcVEiUJZqFWqfOmsA
	OQrK+hpXLlRLa1mfD90SZOG14GxzwhfuSpmIqHVMN/nBov//Ugicvbtyvvdgjptz
	WUXq6QTvpAgbMWm/E09Ft0dQOqvTQ3Ji2qKqBGJJAJzHi8GRBbbFKfmQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gjbuv2r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 01:47:26 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48D1aSlJ019798;
	Fri, 13 Sep 2024 01:47:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9jk8sm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Sep 2024 01:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbcmvz6rrqWxNTdmSJ1Qj7mx776g+ZvciD7M2g7n+V1zvY43bt5B7+0YwENs/IYatZJh+i55XbuLoDo+16+E2tU4Vkg0D1GxkQ3zbYC3gW50Gfbc+vwyB/1U9cRIwcHiYSBcSjVFeLy2vIET4od1F/RLNu5iiQbCcjQO10h/rcK1wHs2W9AGo3UXKX568s6Uh9BsYnD3dkbB7BM7Pa4zs4/ym7grB3noR+kS8JmfTVNYTf2iPUYthxKOAD+UHDwqxZa/OJaf9VS2QyRKH3D2giuC36PFdprOmM3+cn4hII1B7lbDZAYi8A5AaQnP2E7E9zgnu+jkvwuMAhUQL26Jqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s730Wokwbvs8yB6wuvZ8kTUVSV87CiRo6Blocxc/jco=;
 b=lbea99F1s9t1PhzEUn4VOJQfGttSWj6vkd9ZxtOQWybGaFCUROOOShKxlwnhZMmybQpkVRHMD65xO94KgMlEZmUBJf/2pGtKFeOoeM+vbWqKdAw2CzQAVfYzXO4eMyg6y+xHzED8sEaSzkwr7TG6Bl5cVZW5KLp211SBLgJ3AXobzvpP8e+OqvQbrvCWceemM3macjfYoEy/89EwNdVouvx6VQJYi22HDBBOkX1hLzc72+G69JJdeZ0YaShltbxcXEuGSqoQvcbLbKFJ3EwDC34oqXvYJRNUp696ptozqriIQTPgz5s7sxk9Yh0RPSZpkN/ei6WQoWQ5KhNcKLdt8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s730Wokwbvs8yB6wuvZ8kTUVSV87CiRo6Blocxc/jco=;
 b=qpuVgUPEPUM75bhutwsQ9LFefDrAprfHFjjnZyGDT8VZWY2+4U3BmbB8AWgtGShKD4OtXIL4NS43LKUczDwSDB2BOXpAjH02Xk2x2JlX9SYQAMPF2/7LXoJ0K4b+61PdIVth1R89CMaOG9vGOSk1yZE2HxXtNGgbsQehnBoe424=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7361.namprd10.prod.outlook.com (2603:10b6:8:f8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.14; Fri, 13 Sep
 2024 01:47:23 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::5c74:6a24:843e:e8f7%3]) with mapi id 15.20.7962.016; Fri, 13 Sep 2024
 01:47:23 +0000
To: Keith Busch <kbusch@meta.com>
Cc: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>,
        Keith Busch
 <kbusch@kernel.org>
Subject: Re: [PATCHv4 01/10] blk-mq: unconditional nr_integrity_segments
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20240911201240.3982856-2-kbusch@meta.com> (Keith Busch's message
	of "Wed, 11 Sep 2024 13:12:31 -0700")
Organization: Oracle Corporation
Message-ID: <yq1plp8uxya.fsf@ca-mkp.ca.oracle.com>
References: <20240911201240.3982856-1-kbusch@meta.com>
	<20240911201240.3982856-2-kbusch@meta.com>
Date: Thu, 12 Sep 2024 21:47:20 -0400
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0230.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 65bc6ab4-6204-4b07-f16c-08dcd396029c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bO6bu6y0CVYtmMrsLR2T/UXeCEryQgS1yvne5FWtFw4UZ02HFRE9aQEZ2VvZ?=
 =?us-ascii?Q?YmV0/9dP+axvtw99mDhMF9mPE1ZzW3K7lqcrph1Ol/uN0JhwLGJk5r9OSS4j?=
 =?us-ascii?Q?jOFqkuvM8j8+MznmZqzCB9riZm1kiZ7wsElaebOosR4jigK7eYyVs2P4MBKv?=
 =?us-ascii?Q?ba9iSGBqGaMoYjokft0u2zyjyhiUzZKEQ2P1apgDb045yltQtDYpOf/6HtSR?=
 =?us-ascii?Q?ljzZZXsRhAz1f6S8bExAowONRk7zdWWbvZxY1uQGUnpT17R1/srOctoOFgSn?=
 =?us-ascii?Q?4m90BWRRUmgiCrgn3+LZ9WZd3tqsbybI04y53aU+Fjd+sI1hjEPtelo0v0m+?=
 =?us-ascii?Q?SKl8o+/pNGuoG7mXSLMGcc//YF+zRVdDeyHyEBR57G/O5Z5Q+Hu5t6fXPF5i?=
 =?us-ascii?Q?uqSQs1eARwmIKhIj0/2J4p4rfC/th9ST/D4SDB0q05EQUuA4gtlvBsTHZeXB?=
 =?us-ascii?Q?M3QDh5d91jKKfYj20O3fyr8bDm2g3C/o/XKTN0RhA4imI4JiNoPkw6L6rBNt?=
 =?us-ascii?Q?7ZBTDhIaWtVf3q2CPJw67AGVRtN8Hq2hrG1+3Jq11lUnFbqWjPNg/gM8oDp1?=
 =?us-ascii?Q?AoK7MJdxGgDF3a1bvOE3bXDXip+kThSOR5MfCN7FepSb4ZzeE9BYUByS33rk?=
 =?us-ascii?Q?mwv1MBJ9IUVj89hAVX0OlUwI1ostzln4k20rw8xCE8pZukFa7bmbLLzOpN2H?=
 =?us-ascii?Q?eXAsuLtX8D3/l2a6tArLWkfOOECTIJZsLO9z4r92Nxhj/gdriLva4eZ98cCx?=
 =?us-ascii?Q?9NTaasioIcEriP1Ejz8ItDc3IQAZ1mZ2rRFgknVMaPRSh6fUh65MLfmcLF59?=
 =?us-ascii?Q?OoI+VjW9N1JmJeMenvxNozXFAUZ3u9zilPf4WetkbElyV28JlmtrWiy+FcWU?=
 =?us-ascii?Q?mF3egUG0EcJ/He9f0m1TzzJJXgPIgNT9i7LigAhUylDm6aBTK8W3cx6SQlvG?=
 =?us-ascii?Q?N/YCN81yom18F0qesMxo5TFWcF/CU9RwuJW/xed1vG57ohioY4vjVIzFnFzd?=
 =?us-ascii?Q?ahwCCuCC7sxc6kCmwMxieVnIIkA7SdvEziWln62pUQFtkwltXYfzH3melidg?=
 =?us-ascii?Q?10OG9wQIA3O6MxowY8QBJJHSjQZfDm9XCRn/00+14PyxF1oj/NmgUmCj/DSF?=
 =?us-ascii?Q?EX4ZYPjvVS1d+/2oSqXpuuTUDLOE/P24JILUeDN6/V2R4ahocOjBjXVapVcc?=
 =?us-ascii?Q?wlsUjAXozYa5VpfI7ZqFMl44kp6e+4F7LNSIxQLR5pe5I/ezKRil2rYdoEdt?=
 =?us-ascii?Q?jkJlLxok1NoZlFwsS+9PlKC8UYYjh5BWO/drTUZIObxD4KoZGIRyT1/5cCMv?=
 =?us-ascii?Q?+L5JivywGs+Gv5Kr+vRmoZXGlMyPVYQ1Xd2jhM9VwIFz5Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?f0WI/T9ARsnc3TYSBIOQXAmG4+SIVMO0yATKy3XCO4jHZ4/3rcfp+7xc6TYi?=
 =?us-ascii?Q?0EAY7NVZpbOgcWe614H10YaXbaRG9yNkGaCWW5Dp6uVmTRPiOSPucAVIPYwa?=
 =?us-ascii?Q?B5jKfTM+6nPiEnG5cHTLesMazTMTw84SpOUwmghnWPqWg/9T34KkwHiSqOWK?=
 =?us-ascii?Q?RjiPppO/tAryn9wzr0b0QqeYlks2Rx4OqXuPi1XALlKYy6Wfh0auWtBuyC28?=
 =?us-ascii?Q?dCqgJpXkjlFawlhzxwJJx8/MwdD3CKZPpZ8Kf2rAGfU1pOHp2J+/lZ6Zj/Ex?=
 =?us-ascii?Q?7hJkbhm8OvD0WjBijMBx0hB6Egtbn5J1peWm7vnkq42IGLAf8MyVEojUcujj?=
 =?us-ascii?Q?oL4PQ/GaHuGOns/6IvvS/4kVMA7BjvLNtth21Wk4YWxccE6LeddiN4WSjnwv?=
 =?us-ascii?Q?l/g9JLH2xmMNRa8bGIHlM9aP/0SDVr0DLWFfiJYPShuhb23yJZ3i7hnUcVNA?=
 =?us-ascii?Q?Vohh6Io39s3ltyTuJqyd8WOMGNKBQlaBLHJ2lMld9suMiZBeMSUxcGW4/7EE?=
 =?us-ascii?Q?Sz/1FH7M2UTpWr9SX2PbmLXhpDRJ84pT02iOO8d4woAZodOdGWrikwt7mnib?=
 =?us-ascii?Q?uMe/IgEZVoqeYju48hSF56RxZDAg+atHjaaiJCBizbkzJtsaAbMaNMlHvOvA?=
 =?us-ascii?Q?ROuuiE4RHFkxJK0IaW+2oKyZ22pYGdxmqBfS6scmsPCqO8lfK5Khel9PIplz?=
 =?us-ascii?Q?+xEx4ZC9W5j+X4uqtxbX5Ek7rbs3K7URkUutHBndZ5mqTy2VwmOriauCCh9I?=
 =?us-ascii?Q?+1U0OEyTPFRG5KUOuqA3qMK5brgYRDVR5fU+cE+5ZbNtQXFMVDXhwTVa7I9h?=
 =?us-ascii?Q?dYnCSf+6gnaMVS7ua8FUqEz7UKqoSM1bXgRNLAAZKtrO2bHS4onjFxDcsN5m?=
 =?us-ascii?Q?ddIcPQrdLnl0sP4/UtPlcJGbJyPVLOD0uxzZ/l+9Vd0/nqumGXfLXDOpXecA?=
 =?us-ascii?Q?PL9XPckBLWqNQaxgNhZiP2HEmAgJ6dox7Kbb1bf2oC49jWsvCHGs7qDpZG+G?=
 =?us-ascii?Q?IS1w5iyVKm8XWqNQ8wRzhPcRqPR6bw05VSmSw1aQedI6v9vkUXd1u4R1I2Ch?=
 =?us-ascii?Q?BVfRfDVtQo3iNl1bCoMZKKBpaqkq5PJYM+qOBIKeNJ8FKAWB8f85d9TRW5oN?=
 =?us-ascii?Q?e83DeXrKw1ZhnqdU+Xaa4qUNmr4QynwUx26zRlHIWhiVKPDqlLt8lvODzNTQ?=
 =?us-ascii?Q?dfKmwZI6Mf0vSa2QeIuyEzV2vXy6VGjwY+NcfZw4NNHlP+DTACUn/sWQRsjR?=
 =?us-ascii?Q?J1dLMRWEMa32FeCfUWJ8eyiw+Q3nTeTOPwGe2E2ZQf10AMVSwKEbfzvESQnq?=
 =?us-ascii?Q?MB9wxWPsD3Cl5U2Fm7AODFMXMvyjpjS4JqG8OgXY7cgCL2UgI9hBg33pWcx7?=
 =?us-ascii?Q?G242t5OQdfDFbnuPT3Xb8kiZFLTORxO1VbGI2mIsfkxPU1D1BNJkPwGgUthp?=
 =?us-ascii?Q?BWTXQ6LofCKQDM/ysnCyk896cskkv8Odf2emkMy/pMD2rfEbKQtXUXv0w66A?=
 =?us-ascii?Q?Vy1jxGFktOhtIf+99LqZlsTtsavppZFWf4ki+ebwh5FFegDZfHVaxICfvw8x?=
 =?us-ascii?Q?bj+M3w8xd8T7Q+22IkoFESPsnQwrCWpzcEFlhg+ALbWDftSjwZQdzSnCpPUz?=
 =?us-ascii?Q?uQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VOBX9W1WmVumpWyqp13Jnfr+/0Id94gI5HpZT80AHZdp/4XQFKSbrZo9GM8vyHLcxi3atkJZVtGx35JKvIJZ6RYvFfNksVVJbgb5GJE6f7yWZzX4x+gDlgHHcW6uKiZOz9NbmkhisiHZ8HMoo/nMHbP1pixw6HJKlCHFGdRip3PI7yF7ZYSmSOf73nKh7KNmIqTDejRSPcEhzCSDv0s5VIuP42SM5G5HRCzfbdc+GZn3rrYtazf6jxjZYaTY7eJPZU2tnTB0iBNRhjXk06k8z1OE2UCmZcnm5n7VVu8EGbUKmtoCB/ITxxNdUAWuVKWvJTTpwjHY96I0CCRMqV/JO+QPXsyVj68hjdC5P6AFk0KYHz4ehg9a/9DC2wYeRmO1DK2KU6YPMkG5O8hVrCkGOxgWqjLFoOhzF16KmJYI15W+HpfJ6iYrEA16rKWwxt/4ykN1+gYLd0TeDbJrA3JHsoynDZkI7ibw3+JzYZX0cmlx/idWYqffu6kV3efZPPUuDttL/GPaVf7/2UOaqtnvQaOJLSJkhNzIT1+r4TKPMBZFjeOGuPlVL8c6WPWGBD5d1Sl/f4Z2sPCdtEp9oIk2YWM9BXL3w7t88jWxKZmMsOo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bc6ab4-6204-4b07-f16c-08dcd396029c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 01:47:23.1551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OCnZ1MZ8SRR/dlPARSPBdIvX0NYhYGMv9iAmcJtOktyBwsAFhHOYaITPoqJpDs0lKu0hkyUHsCTF+MWJLFcf2fLN6tlDuiJkKPcmpj3ClX0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7361
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-12_11,2024-09-12_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409130012
X-Proofpoint-GUID: PFQg9ZpEjQlhWaYioVl_TkKSPOMxIE7T
X-Proofpoint-ORIG-GUID: PFQg9ZpEjQlhWaYioVl_TkKSPOMxIE7T
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_184740_560139_8820CD2F 
X-CRM114-Status: UNSURE (   7.11  )
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


Keith,

> Always defining the field will make using it easier and less error prone
> in future patches.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering


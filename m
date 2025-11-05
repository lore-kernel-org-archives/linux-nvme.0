Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC91CCF9E3
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 03:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Date:References:Message-ID:In-Reply-To:From:Subject:Cc:To:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TRH3F4amTxIsLMKpRJzTodb0I+Mgq5C/iGX2QecY5Lo=; b=HjhRNC2GJuRmFZdesHuaeg5ajl
	lWcvk1vc89SqnVJK9wbHxpQgK9rROgGRTPWoDMOJIUdHu7RbCzpWFY3r0MQfmoHDrCPOWRuNohY06
	BUiQ4RFjYbxfLjRZ0/5bus5cQ0b5w9+MaiI1ZNOKgc+aI957G0pRP7idGNKD9NlliFPB3PmKnZX7D
	lcXjlY3l9goqqj9vAMYsiBnMGoCIGUQ8UaQYl3frEJXFeQMrcnn1J3NN+g1PNZQxySi0MJF204T76
	ZrWgENScUUzv2HncnbBtaXmRNvzhwgMN9d3bu6Ze3cDIp2jSDVQONYfnai+CRngbD6VhjCFr6WCL5
	88gn+GYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGTpt-0000000CwBI-2SH4;
	Wed, 05 Nov 2025 03:05:25 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGTpq-0000000CwAr-0vfm
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 03:05:24 +0000
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A52Tth5025306;
	Wed, 5 Nov 2025 03:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TRH3F4amTxIsLMKpRJ
	zTodb0I+Mgq5C/iGX2QecY5Lo=; b=pI93tsHHl62OvO/d8krMLjJCfaRuNqi2/P
	k7OHISUMlBufRS+dYuJUv9gcMb3yMGViiqm0+2olLpK/0civO460QoEXO9eWEYGm
	6FhezsUe3dkIgw88v1t9QSgD5yQjG+pj4yENU1kTZNi6cJTUb28NTwQJBxkz/RkR
	Cqu9euqZjX/0A4cl/UbmcWsL/qZwEtT6UUhjL+mTn4U3/Zf6ROQfqSh7kp3FUTEi
	bV9zjBVJswzc0/qjsvltmMNEr6TUChJpidUI/OlCTOVWPhojpgojB6VeA6vSYwsr
	bEpsb3BYB7jA99isunVN/syK2RFdRFim5qg0sNImTn5x81lVK7FQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a7wue81rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 03:05:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A51Veo7010046;
	Wed, 5 Nov 2025 03:05:11 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011070.outbound.protection.outlook.com [52.101.52.70])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ndy7pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 03:05:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEaPWv3xivHCq7QP5mLozfek4cZE96InzcD5d4O91HKMbbIXV8s6omkezIzJhyenFMtRAP7vlfbcIpT38CaECCLteKDdHlA7QHzPm5cJ+FRbYMRoiqMWXhyTIz3903osgSFc2utgBvaKxUq9MNrhMhVP7+AjIUrfCpB5AQ6+fVB0hrzHiHde6Ia6aPTD5zV3bgEnPSxOHxUEBAvZn/1CN/IAjVR+XK8WZR1dmcid102nRMJcnO8QM2Y7mcmkyZ1RJ8WkFqCW8ZYoaqoN0Glf8xoH7Gvue2RJSUlKgj4mxmOP93Nl6HK2rNLukQM8OQjxe282DGUgxjf+jkjMpp3ahQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRH3F4amTxIsLMKpRJzTodb0I+Mgq5C/iGX2QecY5Lo=;
 b=CvM7/cR1U2Atu3O0fKgjs+Abe1rbswmTIuw4sN1TglDPwB3neMxLs3M+GmV4fUgK15YHMSnyBUR722K2oy/Tttp0Sg3sxMzMItB/qIeX8wOiPFNRMPl2kKRid4f01gJPABoeAdruxliJ1q+CvQphdKVkaOr+2s3QCqtyBlyWNpoV5J4VFAkkbKQH5g/iiHQVrWzEiThCVgdkNAJfQZVJsnLvfkyPUP15XYbk/FxeL41/FHYR8+zJeqB15ASsH3yDwnxxRtHEumiRdqKAJjtz2HCRwQzLhb+KiaEcOPQeV2PX5S2fJYKtHmUf6zKw5JT/8XorMy5cKM6TB4xRiSn9WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRH3F4amTxIsLMKpRJzTodb0I+Mgq5C/iGX2QecY5Lo=;
 b=laru+82ih+l3qVJetPPcEok2skaO8ZoHc4Grc6WXziQnSpwmPE0KV6i5dLaeIVONDcFTZLpMhfQEhaP5iKTt9QabNkPxVwuS5GRpRiXqSUng+S09RvvJpQRg5wEAxI532iTB5j3lY6e7jDYTssi9EGRSOY83SdicPSCHlsaFh6E=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by BN0PR10MB4999.namprd10.prod.outlook.com (2603:10b6:408:129::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 03:05:09 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 03:05:09 +0000
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, mlombard@bsdbackstore.eu, bgurney@redhat.com,
        bvanassche@acm.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH V2] nvme: expose active quirks in sysfs
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251103144406.1148401-1-mlombard@redhat.com> (Maurizio
	Lombardi's message of "Mon, 3 Nov 2025 15:44:06 +0100")
Organization: Oracle Corporation
Message-ID: <yq1cy5xp4ct.fsf@ca-mkp.ca.oracle.com>
References: <20251103144406.1148401-1-mlombard@redhat.com>
Date: Tue, 04 Nov 2025 22:05:07 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQ1P288CA0021.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::27) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|BN0PR10MB4999:EE_
X-MS-Office365-Filtering-Correlation-Id: c88565e2-0596-464f-86df-08de1c1820dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JmogabKaytJiON5tmQh7Mn8Ol8J8BKZ5+rV8UeSRvVfpvRXguUGwof4pDrTc?=
 =?us-ascii?Q?+4ppyJu9bNowLT8Obsdhw2YvVX9IawwZ7NddYDz90vthzScY7h75rWnUxMHm?=
 =?us-ascii?Q?rdVt5ca51dHv73b7OdtoPvKsuEXv3FItTRzOJlMTbN83mEl/ZM9Y3mXVAa1z?=
 =?us-ascii?Q?PfWw4wE3pqagt43SHb2QOjy1KUg4GJi07kXY8u7Az/FMRlReG5GKy1hfEWJP?=
 =?us-ascii?Q?B1nKcHlOJzntjcnENV1q5YHjHs55vzyFYjcT2gZE4f0KrcgYHk3AYxwtDvXk?=
 =?us-ascii?Q?uJMIuTD8xxhTrjZGFETBjSxYXKJaygT6bMzDN6gJaGsp6PEuF3wVjq5lmG+e?=
 =?us-ascii?Q?gXd8OSW85gUPIcscREErkUa+pEK+IPjqpkIrHiFlAm0o4YgDuonq6AhevBoy?=
 =?us-ascii?Q?s75n/mR53pVn+n6J9PaxiNkn1/xGlAKsAFYENlnnQvtvJL/DmTun3apfnwZg?=
 =?us-ascii?Q?SiUJA1IS4WCfz8jUscS93Ygc/YgkvAzEFQILzgG50RqGCCEbZPRgyvt3KpZB?=
 =?us-ascii?Q?EV4wGhnnUWgIx1/dnUI6EBM78wCxalSKmnuQQINiS2xNbN6+bL+ZgrEHKv7W?=
 =?us-ascii?Q?sKyPoD6xDv0fICvhRFFrtp7FGbUmDYa82vokUbsBnOqSrif2/+Mjg2Inl6iU?=
 =?us-ascii?Q?8TLylaCSYtZ08rixVc1QJacK5JeOjb1+qQokgbKoLT9YReIUTyWEFSH5AmkT?=
 =?us-ascii?Q?XIoc5RqGFos90sOSNcagqDfM1nBBTt9hZqqtnlB5qYBntwRulIyGNw00vJEy?=
 =?us-ascii?Q?NXWlq8gDxUNPL98EzHRe4+C9EzDUFdXxs00UEBwim1FKvjegNEynFKKrWug5?=
 =?us-ascii?Q?cVQJH2OHTnu+mwDy4DZ14R8dh0bNnG88WVPfIerWYIHHW70Utuw6cCq44CTd?=
 =?us-ascii?Q?7Cj+UlBm8D/HgCK0OJHpIYZf0THTMFmWz37WofdysthkZ8vMjgDEnGF1P2+2?=
 =?us-ascii?Q?D9iUuDxmR49OPVC2Aar4d4N9Q01XEr3PEjUMKmtQBgBcAvI1fn7sG1jhmSVP?=
 =?us-ascii?Q?SBkpmMyh/Lklk4diCQmdn5KTKbky8vE+cV1DY4171ZVrbdt24gbzb3Ac0dgy?=
 =?us-ascii?Q?oitmCjRprNRxHnvI9ysmU3/dlGrCrl7XA1BcXYjJpPgB8tTgbuACIv0h9VRX?=
 =?us-ascii?Q?KH/UhhIOnwcVb8HVODLiHwtGzB/ELG7xnQsN6jkurloaG8jU6oUYBOAF4Kf0?=
 =?us-ascii?Q?Fm/HCLDvc0E4JA6ed1NdbnDlGsreIqpfYTLXgmUqGVuGvcReBUHz1fDs4Ifr?=
 =?us-ascii?Q?5TZXgZFdRvJsoIUYXatjCS5HoYpb27umCxuZRdqaRpazVDOursnxnCD8xDEP?=
 =?us-ascii?Q?N5ayzJvbVWNsrucedhrnL9mq/v8OdorC11uz+FD0il00MgAcVY+rZQbEb2rA?=
 =?us-ascii?Q?230DNrjQb+hF0GFiFnGavgFL9H/4xFixhqx7b9lz/p2WKwR9drUwOr3GUKtS?=
 =?us-ascii?Q?Rlb+jdypE7qLCeYkw/6oSysXPfH03uya?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H18q1EcAoA9AgH5uM8ShBzi2wsKZ1IS62JRkEUoprL60Wp+Q3moe5VIRS6Fp?=
 =?us-ascii?Q?5FQ/+UFUXu6Fduz1P3FkW7nZnD8ud19wjcHZYZx+bP0Sundb7I5bCc6gyh1G?=
 =?us-ascii?Q?8qUuq8NbpQW/DhsojXxYaKU75vayNMyrWbrS/5BAleW+ADv+L3clQZyh0T1a?=
 =?us-ascii?Q?Bcv2dTjCucYe98A93Lvg6pc0MfywVBMEpnbRhh2ZPLg2GmQKX5RNHFl4ArCJ?=
 =?us-ascii?Q?wSR5RQmOwLWWacL5FX5c/4dXqdoOIOMv9ThPuuObBBrdw/Ww+czpY/PsHJTX?=
 =?us-ascii?Q?lyyxHnt4U7Q/KFnTUNUomvldXqah7LaXMh6SHBXYONPkEP7/6zrK1bnIRoQd?=
 =?us-ascii?Q?FeSadSBASXhgxYB4fF8enU4mFWSzl37J/+FD7ZUQA12as4c/VZ2ilDN4HzVt?=
 =?us-ascii?Q?hEDArp5mk+e+V25lf3Rh+V5E9vsrBRLtkb0m3+V1Rk3zvOzwyegxK2gSBAce?=
 =?us-ascii?Q?X/nvsv90ErSSk/w5mFw4UJ3I0l6XFj1VP1AYRUWhYaIB+/i+x7NCEaoKiDeC?=
 =?us-ascii?Q?Ri7UlejqRYcJfShbD+PMmXmGfWjZbjga12wx45FQAWi8Pe31vyaKuXpBKbic?=
 =?us-ascii?Q?QwOCLbiHGmYqxNRNUJgguNhDB2P0eVHp4O2neT7IGy4xPqPvbcZZ6w/ZgOAl?=
 =?us-ascii?Q?4cX/ig6TR69XXPFNaXNfvp6bBI3x9+iZI3/UGPBH2ClpziTNLrhugvrR4NLF?=
 =?us-ascii?Q?wFQDLKL74ByvgLt3/5SUaT3uoCu5G0/ykNfOTd9U+VpkJXwN5ag9np8pcCDU?=
 =?us-ascii?Q?fq0Rk1Eg1cpKRHPLPvwzoCQzTzClh28Zbikq3FoCPK4G6kI3XJZb/x+mp3Ki?=
 =?us-ascii?Q?tvs46yZxoCCtXCygDvSAfAHX9eGEND3bvdxDq+ON3zQWir0bFfHjE+dTqu4A?=
 =?us-ascii?Q?RhA0DdQZ+HlfC7FfIbXzuFFpt0FtqZN73WC4RH40kWNkGcglE6wzxaxWFEof?=
 =?us-ascii?Q?SLo8PZqXutK6DAZ/yhzldWgVYpmnd29mhy6AXCRyD56GX0GHeoHeqHTyXhTG?=
 =?us-ascii?Q?NbgaPeKfXe4WqcR0CJh81GX8ZjpLyy3ESOpVZgwIDGwbqFqNqSQlHSjni5n3?=
 =?us-ascii?Q?N+fUB1HQtfbs5kAgssmmXaO+8an9hAghTm5xQgMQRX7IerKsUEmws+Apb5Cq?=
 =?us-ascii?Q?+WnV3iz7yyhxgJwJj6XBbMOoucts4KINAlYVPb2JtIO3G+E5gsjEOdhVtuFQ?=
 =?us-ascii?Q?y0xTwOBRooYvNuEiK3IU0eqgL0OOD9tQLBvB67FPHdJdMnDNhKLeCLJ8GvKi?=
 =?us-ascii?Q?GmBHFWIttC19M9l3h+s07diUjo1Yfsi+9cMwi5pBe2o4iw6Ipu02kWYxdg03?=
 =?us-ascii?Q?kBAu6dA5GVQNdIb6gjf4One1kuzOvLyGUp+fYVHmANsqWQj2Sklo4ZgS2L9k?=
 =?us-ascii?Q?LfG2jEyRUYjq5WNbhjupG9OFDXiljIW5fccACDKETA41cxI8zGaXuXv8frNo?=
 =?us-ascii?Q?7KxTeAhpAQ4gYsSR6wgauzVSM6DFvTW61CJW3LQ4ttzhsV1u8VQdmMNOWoOt?=
 =?us-ascii?Q?Je3diSNz7YuCauMuIxxGvjqK+eAetwtfszkHudyah+rnBRu+Dz/nIXQapcxs?=
 =?us-ascii?Q?wbVaNk4hBRq22MH07FSzBOm3JG2ddCT3m1TnG3W9dKjt3/PJmeRRstGPz7F5?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e3MMmH8yuO/4F0bPsG+Pq2OLqE9nTHQ/UZSFo5Z+eNXidRJMv4/9fLeweQXxSxoub33ketIsKMQwP9/FgNPN+MJYt93ghj6cG+re8j0fgT+HZEcl4nw5Lcs4RZl/l6lkE31QiaTv8czHsSstQeFQicsqdqx5c4xZ7x0FIsVxQnbmw3PRUniYQC1IZ0tfPazdE8JAE/MJFZ7N05XJkRaqvCIvHhhTCFxnNvd1FwHcsHspN96Wrl+RVasDA9kKgepl3SsKkVAOme0OZIzbHn63o+4OlW6fk+E+8y2hqabGL0GlYiRkJ4WFlds49d3MPhQ4McRFRoS5WmGWjmgThytcAHM6UnDf12kuSyKKdjX1jre34PMn9L0weN13r7lS+VMKhC4Zy55d2s0ELRbbnLzAwn6gPEQzlqKPVA6NhbvR9bmAB9yJ/2kKjUCre1a3mSlj5gV2vYhPoU7voBdG+rEuVodrQsoJn3p74uIuU/Vm4huFRnSmSC4niZb0GxN2F2rsTMgbhyNvFGjt7KIrw+FEt4+s1Rb867rgvO9wYXXsDsLbwdOEJ2Xt20gaIzePXjM4GnPgg7vHyGkJtv50TH/r4I9neG4qTB7R05y1VhqNsbE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c88565e2-0596-464f-86df-08de1c1820dd
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 03:05:09.0645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mItrMXcTDeXZ636jQ2qdoBCBVKM6Suj5iVE/uTQ9Nw0MynxhbZGgcQtpPLImPYiG+qLh3rU02XLuMecc1omly8V4vQwqUon4EMyGMJIg5Po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4999
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=962 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511050019
X-Proofpoint-GUID: lBM1Q17K_k9jo8qawHzZRj3sBp3Vxpc6
X-Authority-Analysis: v=2.4 cv=C7fkCAP+ c=1 sm=1 tr=0 ts=690abee8 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=wagFz6wmZ-aZDvloFPsA:9 cc=ntf awl=host:12123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDAxNCBTYWx0ZWRfX4uuEV7WjkeR8
 NbX5Mj317gNLrQXFtywU5MYviZQ71qIYsTBQf/Jm/c+E2Ex3kL2y7O+N00yCiceOe53lnSVSuH0
 /LntlI6iSgKrrcpTA7NLgfjX0Q7hG6auMQiA/HvKaw1wBluiNIkW8UAQKbaSW0I3T/GNLFxG4y+
 g8mUfxNBQXRAvdGaAlYewSNmklorVzRMfnQVFxtJetWLHP/BCRKKEovIva7x49jMF3s8lBUog3l
 ucDQG2vSbXcY3IUFDtQ/2q1GrC+5izqJfMRA9obr456VtP6qb5k1EffFM34JQL9E/W24LSCyTKm
 /Pe5LV0nuoDTyJomtmZJjRCfNTK60xRrUmEmuHzIRkoQzy4B2R2ymsmlvmvQVgQ/0SGOiWwHj2a
 fV9IvhO62BMjD7rC4AsEY4VWGkmvUp/AqJ9s+eRuFoAQuD7Aiu8=
X-Proofpoint-ORIG-GUID: lBM1Q17K_k9jo8qawHzZRj3sBp3Vxpc6
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_190522_579443_1104D0FA 
X-CRM114-Status: GOOD (  11.38  )
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


Maurizio,

> Currently, there is no straightforward way for a user to inspect which
> quirks are active for a given device from userspace.
>
> Add a new "quirks" sysfs attribute to the nvme controller device.
>
> Reading this file will display a human-readable list of all active
> quirks, with each quirk name on a new line. If no quirks are active,
> it will display "none".

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen


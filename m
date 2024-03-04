Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 594B8C5478C
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 15:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EffmZHnI1FPjTsrdTDO8wB72ueamaFZBTwoItmGiCp0=; b=s3Qa7cPMk86y0pa/5Gv9oE3Okf
	lJqEciu6V7QkuTo+6WmdlCy7jN6lwENr1OR9JyYto9E89am/H081QdOwFS4sGfjjfvxHp8U4hKaFe
	3+aIykC3d/S3EVSYgVh159j4CSNokBG2Qad0sSJ9qfLUIX4nMsg+CDDp/yHjDvX/tDXrC339gTv4r
	KjEWyJYdiLJF+cy/HtDMf4lnUIseFixeSXZJlFoq8YPXy9xOsu1z+xLZdOC9Axbxf36tpKJgeOpLR
	26yebWnIPpI2S/Fot5ba3YNIQbSb392UbrhYDchgPgJGIvdmpiAoHz1nbw61RIwBBpZn/JXBsDMAm
	9QhVafjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhAgI-00000009iOw-2lmD;
	Mon, 04 Mar 2024 15:56:46 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhAgF-00000009iOP-02y0
	for linux-nvme@lists.infradead.org;
	Mon, 04 Mar 2024 15:56:44 +0000
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 424BTlda006034;
	Mon, 4 Mar 2024 15:56:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=EffmZHnI1FPjTsrdTDO8wB72ueamaFZBTwoItmGiCp0=;
 b=Uys3Az7j9VkDT2cNZ8XQ3njDIz4HzhlkYjdG3RAc/Zz5nsQdnQ0kAohZhfSe/zOUroM1
 C7kL1Cv5FIex05r3RBHfd9lpjAXy+frudq6XKtukropNaV+0Jq5ONWhd0/60ASkYwmYd
 CB11rliBn4UOPse2nMCtDO4aCHeEAMecfc973mXLkgkYNZg8/1BxUm5kjZMd7/5Kely2
 rpKkY1iyB74+2d4N2vXJG8p5OboWtrQJx+A+Cds/2/aHh+ZAZ2anj7bwEQRlyutlcGzL
 9Vbqu18aPa6Cs3gIs4JdZoqWnbFRhGS/N9D66M4zZpm4rnqhA/QiHNyGD2IpNCVUYuYG rw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wku1cbwtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 15:56:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 424FkW4a017487;
	Mon, 4 Mar 2024 15:56:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wktjbycug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Mar 2024 15:56:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWptHSBaiIuKMzG77/al5/12C2clzh2wubvdSflKHuaHyH2lqXwzd32jyQJ84cj8Zl+c98Bjpg1wBFCuJGzCWDryuUkSvdDbHJ0VQrOp2CEj80hHBnzTgaMpRlvpaGcT+OlCrDD0TJdOrv5n/kpmwZBFoXjUxp3o3MKz8XtjBp9mBo5So5j9iSLiMs5Pao3JFEIanzV3EWRFDlvLaKD2RgfThn93LW3YxdYOQ4WOGE+ygG3UNIcBSYkmqfxugYzruX1RVjMuEZ0XrUtdxrSFCUhoEviUxDvGX9j6iHjII8BL5BVyF0GvINebvehWOuaCO/fczsBehP6LvBZ1UlC/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EffmZHnI1FPjTsrdTDO8wB72ueamaFZBTwoItmGiCp0=;
 b=QqDzXeN23VLvwYfjBACyXJ/k4aGmnw0+cGtOBSv62EOkz9//3raJ0Voob3MHkvJe1Pid1NJunXz7J5/gyviCQdRiKjf1ApJQYcrs0qk2b/e2fhkAkBH3BTp2yUVtxbcwl117FCbjAMv22j7RCQB7LTZ9bYT31FmGk4iHoq2+PucVa5/8siAawMN78xAJic9uA3Vl2XH7PEPRIy67T4i5WWorfl7rVF2KjQrmm6cjRaaHt4IsLpK0jbDJwKKcEdcA1tHeGJxMg8xSUhcMx+X62LtNSFFE39VTewpfrBi++lqt4LxKMeyZw9yI3Rqdgu02J1KSMFbxj0YLUPfHlMttxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EffmZHnI1FPjTsrdTDO8wB72ueamaFZBTwoItmGiCp0=;
 b=h/muVeC+S1tM/YDiIkCjU7N2ce7WOrZPclCOYVfhsT5svnt6/vWzW4gJ4G12lmdPuNznCoB6d4CEJ3Vmf5QCX/PQsOU3PUPAJ4B38opghQAjSWscxgBKIXvFHtC3DjaK9eg2b0En7yN7H7VSyyZ0jqBxT89OoAmnIGH6xcynhX0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7680.namprd10.prod.outlook.com (2603:10b6:610:179::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 15:56:25 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::97a0:a2a2:315e:7aff%4]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 15:56:25 +0000
Message-ID: <f43fa2f8-4c85-4146-923f-039ed02e657b@oracle.com>
Date: Mon, 4 Mar 2024 15:56:21 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] nvme: set max_hw_sectors unconditionally
To: Christoph Hellwig <hch@lst.de>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-nvme@lists.infradead.org, Max Gurtovoy <mgurtovoy@nvidia.com>
References: <20240304140500.78583-1-hch@lst.de>
 <20240304140500.78583-2-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240304140500.78583-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR08CA0008.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 28c61831-3ecf-4ded-0d76-08dc3c63a55b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSpXmaKek/PiP6yLRc6sdO5DDZDqbzp2tL3F3cyp+GYelIRXYpCRgGNW4JhlGecAy4xqn/WJejaQrw/TSGN04Cj99j1KoNfQJ3/WMSiB5XWhAbs5K9Htk5MIH5aK2JxEZ0LHNN+OHEokCNEKDdoWYjtXeq9INJA8Eg5wSbuGv+2RtS5Kt54qE5v5SrVGQMouIew7Vvx2snPhFxdi1ZOTbG/FclY10qVUSl0SQFJqZpn2jUOivfMhm+rmDYHRHIMGxJ/s0KdrcfNYquBUeNdYrxF1+bJbUN7wL+OXMundHSGa9e5IJ/PxhbEY0GcyftmCusOqnZv4czawQa9IIh/BWYInP1696i5Ye7vMV9yhWwI+tPzZ7Q7dgbWxPQqiebwneEmnSRVfQe1ro0lgtNbER0nrhiP25l+9SgHxHwqZ/R8+BjOOAstV0qPlM71dqqFT3NoqemtTHj22pUBkDW3JFoHjH6TbAu5rrZImnFr3klfDhZwyNEPqrJEMUXNMJHXXxj/CREXLpK7iXAk405hFG/8LikUOZV5txpPZqjJhFSuEeicw4tqCEFF/OY4fSPoZmRry6L8HItWcizuNvFRtiw/uUuVBAI+bO10E3La06I+x2h16ohz64FWHncRB/x50h1o3hQ5+Sks2kaZZgtnkOFxmzupKtz/6ht882lU0L6o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzJaQ1Rhd0UwQVlQbitXVDF6ZGdLMUNxL0xCM09zMkZPNC9ac3hNNmxrRTk5?=
 =?utf-8?B?RlB4RVY3djl0dzNHMlBvdVI3aGdTUUJQTmhhUmxySzMvOUtEZGtNVXdlZ1I2?=
 =?utf-8?B?SWJVcEhMazFpQzdMNEFMRml0d0JGVFM0VHlUczQ0bi95UmNtRS93L1hyNW1G?=
 =?utf-8?B?a3Qvb3p1N3pSSzBrcmM2UW9NT1A2a2ZFMXhqSVlMd01CY3ZERzc2Vjdqc1NJ?=
 =?utf-8?B?YWNLM1BwWGNVVVdHK3NzVE51djRwZU5hRzBRWC9zcTFDV3k2MzdOTldzZUdE?=
 =?utf-8?B?b1c1MTdVOHRpbmNxeHFzNTZRc0wvOUJlNTYzRUhTMTdTd0p6UVorVzQ4Z3Vz?=
 =?utf-8?B?R0tyVk5lUW1UeVhsN1E0eVhDdys0TGFQbWUyZ2xKQVNuNzd5ZnNIbEVSUW5I?=
 =?utf-8?B?bzdtR05zMVVmc0dYbExXblN6UnIxd1hDMmR3cHRyTTE0QmxUK0owV2VHaS83?=
 =?utf-8?B?Q3NZcDkrb3FrWC9oK3RoQU14S1Y4cDd0TzRDd2V4emtGclRNcnVIR0lscW9r?=
 =?utf-8?B?bi9JNkZUYWdWNzVNemN4d2RNTEtzNU9JemxpcHN3bTNjS3hpeGFDc1FiT0lx?=
 =?utf-8?B?eFBnZDhaVXp6M0JVTGtSYldFSDYzQnVka3V3a3pTOG9WTUR4b1ZKandkUHU3?=
 =?utf-8?B?dHlOUkpqMStLcHFpTkR2dDAwZGkwbi9JbzZmS01DZVEyNld1ZXVOQ0RGT2Q1?=
 =?utf-8?B?TkF1VHptUEVwRXFKU00zcTVuWGdUQUU2bUN4M2ZtczVaaE5WclM1OGJMVSs3?=
 =?utf-8?B?TWpQNjBRUmNJNE14YWRpVHl5SkxaRnRqVVhXVk1RM3NYWVdjNjBzby94VlRr?=
 =?utf-8?B?emI3bEppSUNTeGdMT1ZyOC9abVlkOUF4WGVlWFZtUWlaOVZENzM0QzFoV2RJ?=
 =?utf-8?B?WnQwcVhHSXV0cWVhQ1B0OEhheTBQRlZFMnlCTCtpMG8zb1E4alY1SVgvcVZL?=
 =?utf-8?B?VHpwVVlrR0FpaTlFWWJhWnNqSjFXdHMrSEtFQS9xMVo5U1BOUUdIaUhyWEZO?=
 =?utf-8?B?ck1GRmtJTnpMWmVmSlB3RWI5cWtlMVh4QVZmaVI0Y2Q2TWRmaHlzalE1djJk?=
 =?utf-8?B?eG5zSU1hczBaV0liSHRvSHRqN0RVaU0rVVZKQlp5TzN5OWpLSXdlYWNEY0RY?=
 =?utf-8?B?c3ZETWE2cnJZOGV4M2hKemJNbnJybSsxZldTeUxnSTRMZHgvNDMwNklYRksw?=
 =?utf-8?B?cUlNU0RvdHdpeUk4TXplbVlyUWwraGZpQXMvR0VENFhYQk1ZOVhyZkJFakc5?=
 =?utf-8?B?S1l5RnhmeTdEUjd2VytHYkg0V1RBa25EQktlTFlvOVZsTEw0aGlna3BnRkt4?=
 =?utf-8?B?ckxsbHNyU0ZqRnR3bUlqMzBBZG5iRDk0ZXVmWUpBTitzbUd5SzZxK2dzK0tB?=
 =?utf-8?B?NDFWTm8wSHk1V2pZaWppcEU2NmtOSlUwR0dRSVJOay9aNkpUbnEzNW11YWhB?=
 =?utf-8?B?OStRQjlCU2QzanpxOU1aOEhjL2JTdW5xWW13cEI1bVFIMTZzVWxrT3FXellE?=
 =?utf-8?B?eE83bFQvbkZvSjJUaDNySFB2OXJvUXBvU2JvbFZPSldmdFRlUCs3Vk9EYTVp?=
 =?utf-8?B?TEc3RFliWDY5a0RuS2lLY2JzbGhFNW5yb2tzdkcrSDhrQUdWa2orMjRuTnNp?=
 =?utf-8?B?SlZWQlVzNTI4Z0hZUkdFYXd5aXE4UWpWT0xobXBVZ3lMSDMxMExrSVUyTzZM?=
 =?utf-8?B?OE1SV0JtcnlLby9FNERZekdtemtDVmpSRS9wM2pKS2MvK3dxSWNBR25JQ2xk?=
 =?utf-8?B?bXlrVmlWMkRnZlUxV1pLTTJSbXBwMHVxMFpGek5JNGdTSktPQ2d0cFNjcm1Z?=
 =?utf-8?B?aEFjSUk5OFZrYmZiOExreEFkN2ZxN0haMDV5TWVYemNFcWRsK2hEK01oS1ZQ?=
 =?utf-8?B?LzkvY2QwTHBaZ042R25IeHZ2YVA2Z0R2QUJvTTdVcGxPTkJiTW4xSmtsV2Zj?=
 =?utf-8?B?V2JlN25TR2pvaURkUlJpMjlKNUxsZUppWG9UWE9lZTNpZy8xZnBkQXVaTmR3?=
 =?utf-8?B?ckt0N2VDOWZSUi90aU14aWw1eUFVb0xNWXdtbFhjeHRMbzQ5Skp2cUhoTkNK?=
 =?utf-8?B?L1dVaG5LZUNMbFVLN2swZWhYYS93cVprYjVvbStVUmk2WHYrWDJyNzl4eWVK?=
 =?utf-8?B?OVNNVzZVbWY0cEN6dmJvNHRxNnFnRk9wZEhpT004UmNQVTBEenFCb1h0U3Np?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: I3KKDUoNAluHxvlJ2CLexl2LhTjDuoHQoE8PCP2pLWcuG+GwFO9uPmj7J6zu50P+AaP5Z79vrFjsAsP7NfN5B58cLYOoDid2zJVFGvuuQ8K3L96TjqrLp30YVOS5fQ6AsUe6fbiJTiHmVw0Ey+Z850VdQMeWXNVEH4r/W2FVLCn598aLyyoPL4+RdtsS3DVAtP/7/vrDnZKyIWeQZmRYtJs5eLjuB6kq+pme7lncfY/387F1pzDvsZKNIUqizKK9yU2kIo91pXMhPlBZLInTQIjckAwpyN86GhNB1+Wbecwrpf/M0y68bbW0+stPI2GMdv7Aht0yQ6vonjXfuwOa4ARwyHSI0IFxNg9KpwfadBN+ZI/l78bskKimFWIczZWJyBozoEB/ULZN4+nlnL47ss4pcgm2jn+4Nzl3MKWyt8vtjK/+KEFh4WYKer/sDaG5IdoVY5HKopRqycHQDyZ7EePqMnlWhqmklw01hkT3+RlBBni3MYkS9pjojEMNOYAq6cY3yIQc57eADQvaFWMpYUXSulwPEJMhqXMRBgygR1ZaXWZ5m62AbIyztwWqzgpHv882SrCOZVwFkyHbmAm4wlJjI6KMEWS2o7AbGX0ASvs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28c61831-3ecf-4ded-0d76-08dc3c63a55b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 15:56:25.5300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P7o//iSDg87iub1tX9Vbl5c7iw+mVjVKpbV66ZH/H1YfuVDCZOO7gqHwtKkJ22jrnKqfgrrHhf6r9Jsh9S6K7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_11,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403040121
X-Proofpoint-ORIG-GUID: Pc7RcJ4BBVb3HJi-3O_KkP-G_qa3Jm-b
X-Proofpoint-GUID: Pc7RcJ4BBVb3HJi-3O_KkP-G_qa3Jm-b
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240304_075643_394142_6DCC7099 
X-CRM114-Status: GOOD (  24.09  )
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

return ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> SECTOR_SHIFT) + 1;
On 04/03/2024 14:04, Christoph Hellwig wrote:
> All transports set a max_hw_sectors value in the nvme_ctrl, so make
> the code using it unconditional and clean it up using a little helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

FWIW, but I do have a small comment, below:

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   drivers/nvme/host/core.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index cb13f7c79eaf9c..6ae9aedf7bc278 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1944,19 +1944,19 @@ static int nvme_configure_metadata(struct nvme_ctrl *ctrl,
>   	return 0;
>   }
>   
> +static u32 nvme_max_drv_segments(struct nvme_ctrl *ctrl)
> +{
> +	return ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> SECTOR_SHIFT) + 1;

I think that it would be nicer to keep the parenthesis, like:

return (ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> SECTOR_SHIFT)) + 1;

> +}
> +
>   static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
>   		struct request_queue *q)
>   {
>   	bool vwc = ctrl->vwc & NVME_CTRL_VWC_PRESENT;
>   
> -	if (ctrl->max_hw_sectors) {
> -		u32 max_segments =
> -			(ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> 9)) + 1;
> -
> -		max_segments = min_not_zero(max_segments, ctrl->max_segments);
> -		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
> -		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
> -	}
> +	blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
> +	blk_queue_max_segments(q, min_t(u32, USHRT_MAX,
> +		min_not_zero(nvme_max_drv_segments(ctrl), ctrl->max_segments)));
>   	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
>   	blk_queue_dma_alignment(q, 3);
>   	blk_queue_write_cache(q, vwc, vwc);



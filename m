Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED90CAC5B5
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Sep 2025 11:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/MsmAAA8S1voaGCYkyI4mDCDU8KuuJr86YzLp+KIqYs=; b=QvZfW9VxvVc5I7ksizwKX4R7WO
	cd+764Od8H3h9AHBK15arX44CTDPoUxLKE8cBq/EzzX25ru7GOuAUMihFngxhnLgLg9tabSoiXIUf
	64NhPLJKbFAjFl7CRBehusg1V48203OyrHocdWZZ//cXXbOXdUTTWgNQ8BZfJmyxLXKZWYFinWCvD
	y8be2ZMoKUIxVkXJxvCGXJA3idZy6rZNBaY+1Ft87owck+BuRpDGt6x5zVV/hfTBXMCyHiJHlRqBy
	Wx/IbvnaZqGeTMW0jSbc4b/IZYp3C1PDbdMr379smEWjcp301Fr6AAoLmHkDCQr7c0S57RCECdEAP
	YJqpPMPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2py3-0000000FKvV-0Mt3;
	Sun, 28 Sep 2025 11:53:27 +0000
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v2py0-0000000FKuA-218H
	for linux-nvme@lists.infradead.org;
	Sun, 28 Sep 2025 11:53:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WciU57DGq7sXjMY86PblfYFiCFpzQ3n6qrkJk6EqF5Km27SerdQNp1mZNLSE5fp3E5ie3dkRWtzYY9WQ83Vy56/At5G+TyBrNbQRJprFj6yEnqbG5jXfh2Vu/LgOh0qITcLKZgZgkT9K/vzyrUi/OEt4h8ArJxhLrqMQaMvvP9BDbxDSG1wSu1AzjsKogtABxnDuzXFbrbwWHscKpA/B36ImrHWj2+NveIArspVwNVpjxaF+GM6GGQPTpgkaGCcZUCULersdgaC+7TfXB7vkBrMHnVdRI5I4jcYT96MDyXTWC2iSYOVYScNu45MHsOVMN6Q40BzZbFjfuZVzGIrnSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/MsmAAA8S1voaGCYkyI4mDCDU8KuuJr86YzLp+KIqYs=;
 b=p41j/lLtxZJ4yNBmPpzBkiZ47ufmyvS3YrA5dvtpBFIsrHBeT95SHfZs5/NybeLVuET3NYet30VyqQRSLhs2YRsLGXivpJ7VYrR5AE/mY9dsy8lNI98aiyQnLhGNILMd3ynd2VzWQp0K5w04e/+Dgx4NZTIlQUPoKAFTAPXCsIkTFkHv4kfeH29xaF37eyhbQw8VcL5SYTOIPseZnDgjZjsAu+lZ5vgPWjDmDmCyY0pt4FZvThUA6uEYmuE7kAF85qQ3ZnGmEdmFrVLwv4Z9lCh0k5YigLr0qAlCSwA1Th/90vTNbZDn5tjgU3sM1WSjrEF8HA6/7EolmI72Om86SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/MsmAAA8S1voaGCYkyI4mDCDU8KuuJr86YzLp+KIqYs=;
 b=j3Wor/J008hGvFJwYGwouSTl4h9tGdLN+FJ/8auBFGVXGmXXe5QJMy5w8FVTdUcKoBUUOGwaT3Kuf6f0C1rXy6ZcHOuD/qXHNiNYAUzAdhsm5/im9GqPodhO7Ps5qGH0p6X5cxLz+KYj64p9zk9lR1MpV4Q9eFASc+bqeU/AiiNPTSPalgLn6mHHxxynKAeu4g/L1K8KjLORafd7W1phThCb0bDVtb+JXj0Y1DV34uXC1YHnbxXQxeph3zivFw50k18C4jwSYzQ3g/p4Awwdg6j4b7lGlzqtjoyQh8/qWRnsKbvtO4X078x2pLp1i1bXX8BTgWwC/qqbQ7h2uL/UTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by BN7PPF08EEA05B5.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6c5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Sun, 28 Sep
 2025 11:53:19 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9160.014; Sun, 28 Sep 2025
 11:53:18 +0000
Message-ID: <d63d991a-0e72-4e94-885f-d94eb810d196@nvidia.com>
Date: Sun, 28 Sep 2025 14:53:12 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvmet: prevent max_qid changes for discovered
 subsystems
To: Daniel Wagner <dwagner@suse.de>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 sagi@grimberg.me, kch@nvidia.com, israelr@nvidia.com
References: <20250924202604.7201-1-mgurtovoy@nvidia.com>
 <20250924202604.7201-4-mgurtovoy@nvidia.com>
 <97291788-f831-469c-b0cd-7fd79678366e@flourine.local>
 <0c96d03b-b98c-4996-8739-e8cd0d6af96a@nvidia.com>
 <bf276b4b-9d1d-458e-84cc-b24969bc0995@flourine.local>
 <8f8d7c9a-02f5-47c0-8f8c-9aae6b969c73@nvidia.com>
 <cf51e862-53db-4fc7-b2c7-bde2ad31e4ec@flourine.local>
 <8cf714c7-a692-4bcf-80f0-780fbc2c27b5@nvidia.com>
 <2715b2ac-0948-4755-803b-7f41768efc6a@flourine.local>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <2715b2ac-0948-4755-803b-7f41768efc6a@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0011.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::14) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|BN7PPF08EEA05B5:EE_
X-MS-Office365-Filtering-Correlation-Id: 33fb634b-5167-4b11-e6b0-08ddfe859d96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yys0L1Y4V0ZBcVJDL01VYUhrSnNPdEdmQkxDZkVSLytSSmdzSXd2TVBXdUJY?=
 =?utf-8?B?TFlqais4RUhmUlZTNFNwUWc2bGd4Q1VvVU1MS0dXOWpjZUljYzlWM0dlRWRt?=
 =?utf-8?B?Q3EySDUrNUlTWm0rbHUyZzhXTFZSN2lWSzR1SDNmV282ZDRkbzFDa1JQY1Ar?=
 =?utf-8?B?Rk5jREVzQm9rdjdJNWd0TytQYnBMb3drR09pdUQzaFlkSEdlajM1MVE3dUxm?=
 =?utf-8?B?dHRsVWR5cmszTGxRT2dnMkFzbXNyMTMwQUxnSEtyTm96Y1hxRlBDc1hROTRD?=
 =?utf-8?B?ZjVuK2tpQkViMFZKL3UwZkt1Q01XZ1AwNEpVZTlWK1lZSzRpS1JZRGt4MUo3?=
 =?utf-8?B?OWFGRnVkRVNTc08zU0hXSUMrckpQR3RSNVpWdFFobFJtZzcxTktIVkRialRl?=
 =?utf-8?B?QThsY21pVEN4SG11Zy9ka0pzalFQUCtWTzl1Zzg3bkFPc2d2cFJPSGhZVnd5?=
 =?utf-8?B?UVNMTFd4L1ZlSzNCZnhTcWFWRWpTRmVrbGJsREtITXJxSS8wSFFTazU4WHVU?=
 =?utf-8?B?R2hoNGQ0QjJ3aE9RNHE3LzVyNDFMaHhHTVdNcWRwaHJnKzloY3JHcm9ab3N6?=
 =?utf-8?B?SDFUQjZTZXBjWXgvbWhCVVd1VG14MXBTTlBXY3FJR0FnTW54WnY5OWJqNWVS?=
 =?utf-8?B?aDlHbHc1cnNTSGV4dmxKOGp4c0ZzOGZDY0tzWE5DbnA4OHorZFNxLzkvVnBV?=
 =?utf-8?B?ZDg3TFErUzdNaC9MS3ZjdjJpQjZWd1dSS0VsT2hyakc5ZVR6M3V1TUxXNGR0?=
 =?utf-8?B?Q1BjY0RVb2MzUnJMeXBDNGJPWHQyWHlERkJQaFRaekF6R2pKZ1IwL3RGYlhD?=
 =?utf-8?B?d3B4M1NyeDdTSGFDd0VXTmRnMWxkaGxyWlhjcE1JRDYrbFBDOGVoZ25aU1JE?=
 =?utf-8?B?L0hiRXc3S1FzcHFkazl4c3pLK29ob0tvOThzVjliNi84YjlYRE5YTC9ZSk1U?=
 =?utf-8?B?aWtiS2pOWVBpZ0wrTGk2Z1g2NEcrdlk3bnBFYkl3czczMFJMV0kvT1FIUzYr?=
 =?utf-8?B?a3JBcHF3M0EyQnhYMlg0clQwT1FnSHQwNUR2OWFtSnYrUmtidGtWdFJsbTk5?=
 =?utf-8?B?ekMwWGJ4NTZIdWVheGcxcmV1WllRTlRNM0tQT1Badmtlb2RqSk95SkJkODBD?=
 =?utf-8?B?NElVdjRSQys1aTVkSlBJazFnQ2ttWklRZVBCV2dmNUEyL3NEaXh2WStXTFFa?=
 =?utf-8?B?TEZnbUpTc0hsd0ZESGlaN1FQR2tOM0h4M0hEbjJ4eFRXSS93ZFB2VjRJQ3Ay?=
 =?utf-8?B?SlpyaExNelVTakVUaDM4Nks0K3hGSFJRUDU2cm9qVUFQdVQ3MW84cTlKSEUy?=
 =?utf-8?B?eENaK2xmR3B1VmYrRmxYODBkdlNDU3dDZEtKK0M0NHFDWGk0NzdlcHgybWdY?=
 =?utf-8?B?Qi8zU3RSWHZka2hwbWZocnQ1QU5iRzZ2VEtlcUZPTXJ4aU9ZdS8vNTNDZWh3?=
 =?utf-8?B?RHJLNUZOWUJZUy9oeCt5UGhHMkM4UzR5OWZkUDcrSGdNY3FzMG9WRG14aVY1?=
 =?utf-8?B?bmpLei9scGRkQ01JbFExOS9iMUQ3NzZVcGhHMTZySWtlTUNDaVZKdUVoVXYw?=
 =?utf-8?B?eVJBUnlmZjVlSTJGc2Vma21jaElHbWROTElXSWZJNnBpMzlLK21IZUJ0Nkg4?=
 =?utf-8?B?YnZnSjhDdFdndURoUXg4UzNPbzhybDMxMEp3MnUxSnVzMEEvNzNyMWZXL1I4?=
 =?utf-8?B?cDJJYTdYTnhia2RrcTlzTHhiWERXV2w2emlrRnFkV1hKeHJObEY4OS8vbUYr?=
 =?utf-8?B?T2gwbkV5UkVDbnFwbEo3RnFCa1pXd3NJOGxHMVhxdnhqOG1RLzFBcE42c2dZ?=
 =?utf-8?B?akNHUU9PQmkxWmR1N1NLQU1XVnZKeDFLdERKTDJDSDlYckprQmoxV3NJY1RD?=
 =?utf-8?B?OS9hb1Z0M0NLL0tuL3dvSzBKbjY2YnFLSWlURGNZUGFiSEF1M3d1MkJFdXpO?=
 =?utf-8?Q?yQRslhqnneK90BUasyWX6WBXHApCYue5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlB2VnVRMXk0T1k1NHRvOFJnTjBMZHhMWE03U1c5RjZaeXdHdXBGMGVyTWlF?=
 =?utf-8?B?d25RMkVleWI1VGZ4cDhzRDlZR3pUN200SVV2OVRsM2RGOTdaMGVmYlNGTFlJ?=
 =?utf-8?B?VUU0anVVNmE0b050T2RZdnNsdTZ5ZHNML3lwUDZhN2M0S0hIRlcvRzZmdmk1?=
 =?utf-8?B?ZllVYk1MWFhUK1gxTi90Mkw4YnpTOW1mNkd6V2tQaGdBTlBsUEhtNUVwMjlr?=
 =?utf-8?B?L3ZIUHlGWXFBVDdocmJHeWJxOHlLQ2dWZTlLTHlLaVdiYnl4VmFyOUV6T1pL?=
 =?utf-8?B?OUVrTU14ckppcGJhTkhMUjJLdVBGR3pybDNrd0VQaGdxbThyc1l6UmhNVGJP?=
 =?utf-8?B?b09VT3lRRXJmeXRtQ3pSaTBKQ2xyUGhHdVV0UGJoSGlwWjZuSFVYMHYwNUJK?=
 =?utf-8?B?QjE2dkNGY2YrOCtMSlRrOU1pcUVuenJWNzMrcjdINGJXdGZXTE1ZWXl2Vml1?=
 =?utf-8?B?Y28yQUpNVnhyM1JpQWxqUGhJZ3RjcVFEZEVYdFNxMTZ1Wk5HQ0xmTEpYNEhK?=
 =?utf-8?B?N2hzY3hVZnl0NnV5UmFZV25RRENtcU9HNUJXbEFqengxVE43Z09sVWlRRFRv?=
 =?utf-8?B?Z3dXKzNLeVJVbkFSRzdxM0FwZE1MNUNQV0hqZzRFaWdkbUpiMkh1N1luSnNR?=
 =?utf-8?B?N2xsNmp0ZjJEYVUyajhtWHVRQWdYdWJBbG5JYVhLbms0akUvZnFucXNuT05S?=
 =?utf-8?B?QWUyYzE5b29LSmFqL3I2Z0VMQUtGNTM3bVA1ZHFQbkszOXFma1A3YVplMldv?=
 =?utf-8?B?WFE4VVgxOE9jdkp6dHRaZ1dpSWVuWmNkNTdvcU9keW5FT3g3R0tQRU5pQnlp?=
 =?utf-8?B?OVdHR0d0a0lDdUhieSt0aExtckF5SjA3OTQxUmxISWhWLzNrMy9HUUJkUVZj?=
 =?utf-8?B?c2VDcHBUZ1I5aDRaNUkvM0xMTHl0WVRTR1NTejNoOExzUUZKeUVXYjB0cmpB?=
 =?utf-8?B?SWFoY1RjOVBieWtUbEdwT0s2NThRSEtIaktSZjVOdStmbElnTXNkZ1V1NGRm?=
 =?utf-8?B?RG9OazUwY2ZCUHdTVkpMQXN1SDJuSXBzcFJDMWpqSFY3Um80MXlEWHpENTZx?=
 =?utf-8?B?cllyVkt5TWt5c1lEaEozcjNrcWNMb3FyQWh4Y2pKWUtadzRVR0xmYzk1K28v?=
 =?utf-8?B?V0xSaVJ3MEYzcjcrdVM4Mm9hc1dORWhsMS9GSXgwSitOTDJnZ0RZS0lNRk1K?=
 =?utf-8?B?cCtheEdCR0JaMkNQUm5UUUo3enN3NUxranhCOTc2c2FHM2tPWlN2L1h1RS9D?=
 =?utf-8?B?ZVdPSDNNU3hOUWJ1VG9kRjRSRzZnZ0htZFNrbFFFdVlVMEJPMEsxNXRucEEz?=
 =?utf-8?B?dEFnT1pYbWtScDJpMEdSOXM1QWdWdHlGZjQwSXZQRFdUSFFBc0RpNllIcWtH?=
 =?utf-8?B?MnIyQWhWdjVwOUZXUDhqWTgxQ0xNTUdLVnRYSURZbGt0dXZ4d0g3bXZOMjVt?=
 =?utf-8?B?K09odkhmOGhkRmRhcE5Mb3JGRytZMDlkbzNCbzY3c3NQMW9RS0ZLazhBQ3Fm?=
 =?utf-8?B?dHB5eGVCSVhpakRETW1GVUFOa3RHN0M2b3poemdvK1NwcDBQNi9KQWdNNTUz?=
 =?utf-8?B?dzZ2MEgvaGhaV3I4TUxJZXF1R1NBNkhUZHhqYWNsVmxOMFhzQ3hRUnJZc08r?=
 =?utf-8?B?RXhRQ0poTWdMajd2OStrWVhuZVo0Sk53LzZBZVRleUN2ZDdUN2NmRVdUV2ZH?=
 =?utf-8?B?L3hmd1JYbUlJRWcwazJpVVFUZXVMeVptQ2xEL3R4TU5DWHNtR3pmTzdONEFH?=
 =?utf-8?B?UTZ2RnYrU09KbkNxcXkyU3RtSXpXNlRyY1lneGxBaFlLSE42MTZDdkYxRWgy?=
 =?utf-8?B?eFQ4eUR1WDlLZTdsbGhjQjJXOFhJMWgvUVV0ZzhtTHNSZkN1Y0Z6UEY4MGZq?=
 =?utf-8?B?bDNoUGZUOUxwUEdEVkdpU3hGZG90cWU5MXNHYTlpaC96TkxKTkkxL3JvaHZY?=
 =?utf-8?B?Ym9KRUs5TEdpSFZZQ3FaZEVkMlFnd1IyYWRoRENDT29aVUU1d2U1V2srVlJw?=
 =?utf-8?B?bE5QV1V5N1g5VkVCVmUvVUlZMXJIa0JjU3JIZ3JJRzNqaXBmQlNkYmtVZm41?=
 =?utf-8?B?S3FVNEErWTh4S0ovMXU4NjE2azhaVU0vandJdlFWTDZtOGlPSVNYS3VlWUhz?=
 =?utf-8?Q?Nhg/bhGmqHAWe0Xn1bM20p6QI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33fb634b-5167-4b11-e6b0-08ddfe859d96
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 11:53:18.7616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ZCSSTixpk73ncuCxnolwxDLj1AG5qh0GDz8IPjmAJabtXPy4TToktq1gyT8jkKVCESRD3C9sBEM3TU/SZg7Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF08EEA05B5
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250928_045324_521618_09851A42 
X-CRM114-Status: GOOD (  13.18  )
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


On 26/09/2025 9:58, Daniel Wagner wrote:
> On Fri, Sep 26, 2025 at 01:09:22AM +0300, Max Gurtovoy wrote:
>> I'm not an expert in the blktests but it seems like we should do inside the
>> set_qid_max() something like:
>>
>> _nvmet_target_cleanup
>> _nvmet_target_setup --blkdev file (Add here --qid_max "${qid_max}" option)
>> nvmf_check_queue_count "${subsysnqn}" "${qid_max}" || return 1
>> _nvmf_wait_for_state "${subsysnqn}" "live" || return 1
>>
>> I expect the above to work with and without my patches..
> My patch was just a quick hack to see if it works. Updating
> __nvmet_target_setup to handle the qid_max argument is the right
> approach.

Thanks for trying this.


>   
>> If possible - lets try it also with tcp/rdma transports
> You are proposing a patch which has never run blktests, as it clearly
> would regress nvme/048. I don't see myself here to do your work.

This was not my intention :)

I've sent a patch series to blktests with the needed fixes.

I've tested nvme/048 with RDMA/TCP transports.



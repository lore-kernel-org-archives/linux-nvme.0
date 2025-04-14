Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A456FC369B8
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=72S0+W+g74qWst0rm3S3Bjf5B++jWLDby5SBaNQhKGI=; b=ocv5IUCxV0NXbYRxFokoVubF6T
	D6F8Qgnxg3v1sS2nQUVd7kefJZmSdeENi0TzBTXn+USHhEaAGVJ85dk7FaRT9dWF93pLgTf9wNo7c
	ya54V4DixHgTUECFsac7YRVfGThDYSLijeoi9SMSFSPLmewyhNhyDxjViivhhG6Cq365y0o7+ccid
	VE/aCajS4Uxxib7S4cP3ysmYtbzLzSFHrZ2uR7fpqSdc1B0z83VLcVP3HV0bCfT6ltemUbXkhVpYn
	fnKc0gwg0fkk46oor0izNda0LwMoeCu6TJrqp3CTye7sRg0QnvQdAXVQq8uT4moQMquOW0Bfvk7pi
	XIujFEbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Jfh-000000025GH-0uBY;
	Mon, 14 Apr 2025 13:16:21 +0000
Received: from mail-bn8nam12on2060f.outbound.protection.outlook.com ([2a01:111:f403:2418::60f] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4JXZ-000000023mk-1pX7
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:07:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iyeLvlKCzS+fKAu64NVZzKu/CI80YhDAG0VBxx6uUnACRCwQ73bBPit+GQeohcjxJsX4rD7z/VLmPf8YKj0SlJVqZyTVuTjep36tcwgbjReErtO8sbufi3JMi5lj5KZkcpPIaCGlNPdGHrXbhvRMtqmuqXCOywuCPDGBl1TOtO0oXcMrP10Hxqsa4dp6eRmEANz/Fy5ztTmezkTLUzIu7/glTpX9IoojvgsRueVndUbNGx3Z1kGYqlNqDtxHN8tx99jb2QQ02gbfJdvYvqc1rCKM7zsnTduqTafU0JX/IOr32H4qnBCk4WZ4n0G8t1FDfG9Va32bD+DIvSc3W6kcQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72S0+W+g74qWst0rm3S3Bjf5B++jWLDby5SBaNQhKGI=;
 b=ZrjDiK35Vn4vScmG0BW1BGCegXxsea5wkMSQ1FUmA6mbgLD3KBTsc41W3iyYkXLJscSkgnrOQfzCBjNQmtjF5IY8Bt6z7H6gR/Zc0N71lPf0O8EIVNlzEmPxKyBO5jT40l5vPamOGp4Qn9g/4D9my8u023VH+bXg9FV83fFGo1IqPj/fcE1dKT6WSqEkDqxTT5qRO/LCMJ1pVgC6GZTf7OASYmMirfXXpSM07AVk4lCjsjzn0ogWoMwtXz/vGqe2Mk/wbKZf0HZ/G0L6m5Bvj91g6DgGFkbF6n3q063GvgtQPio+OUPDB6s2x2tI8Pi9dFA9374SQ6XJ45FckkZXQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72S0+W+g74qWst0rm3S3Bjf5B++jWLDby5SBaNQhKGI=;
 b=gsbPY2f90sq1BXmw8JSyRhPhWGdP74T+sHmWK72ofSQ7JSkSdbmPyV1YVq9sYlLWCpgBGwK6Vl++hdUyvM6+ZX9umeVWzgeYsXiKMKrMrjsCxihipp3YX1A6R773QxhNwX08AGzNwb1ViJkf8+DmNNyG9dX+bVNZkZiWDWXfAJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by IA0PR12MB7601.namprd12.prod.outlook.com (2603:10b6:208:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 13:07:53 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::c819:8fc0:6563:aadf%4]) with mapi id 15.20.8632.030; Mon, 14 Apr 2025
 13:07:53 +0000
Message-ID: <4287dbe2-c695-4e04-8413-79797ad19ea9@amd.com>
Date: Mon, 14 Apr 2025 18:37:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: fixup boot failure on nvme-pci
To: Christoph Hellwig <hch@lst.de>, hare@kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
References: <20250414120509.49638-1-hare@kernel.org>
 <20250414122616.GA14884@lst.de>
Content-Language: en-US
From: "Aithal, Srikanth" <sraithal@amd.com>
In-Reply-To: <20250414122616.GA14884@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0195.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::23) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|IA0PR12MB7601:EE_
X-MS-Office365-Filtering-Correlation-Id: 525570b9-de53-48b7-d95f-08dd7b555d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UXJGZ3JJNkE4UkRNZmJyMms2V1JndVFwUzg5YjBPYzVIcFRqYnIyci9scWpl?=
 =?utf-8?B?UWZkMEowd3dtVDhIMUc3N3pzMGRWVCt5bDBpM1kzNXVsODVXR28yTVpmeFFX?=
 =?utf-8?B?M1lBRHdQZzN5bzVmYWJWT2RkNmhLbFV2bGMvSHYvUFpIV0czRnZZVGhMaDVH?=
 =?utf-8?B?bWt3dDNTUnA0MnltV0x1alBDT0VDczQ5NVUrRkRGenBlR3ErczJOWnQ2dWFB?=
 =?utf-8?B?OTdKWlJQUVZUTTBpTHUrcG9hcW1pUWw3cjlkcGpkQVJmOUVBbUZKN0l0ckdt?=
 =?utf-8?B?WnAySFhWRjRrVCtGQUFtS053bWdmNDIwc25xYXZjeU40WDNiWkluY3BvdGZ0?=
 =?utf-8?B?b0VmS1RlZ2poQjBualE3YUZRRlNzYU1TWEluc2ptTU9ad2pUWDhYcTc1VW5U?=
 =?utf-8?B?dmpzRk9SUFRFNkJZd0xyZzJpbTdidnlscml1UWYvbFlwRDlvZVozYTJhMVkz?=
 =?utf-8?B?YmpUUHdDWVpjWDBLRFRzd2tXM0QvMzBPZE1Ibm9XS3FGNERUQkVLQXZyWCtJ?=
 =?utf-8?B?NmtOT2F4bFIrQlVQTGpDblhicXJWQXJwaHpQWHpjWTFwdlJmR3lZcHViSlc3?=
 =?utf-8?B?UGcwK0ZzZkhRbkNRYlFtQkZ5TnJwQU5hbE5jOXlZSDV2bjgzZjdqamkrSVh3?=
 =?utf-8?B?TFhKVy8wTUVGOXFFNWFvVy9nNktTam53bHlkZzBKYktkTjRrSVppRTNWWGl2?=
 =?utf-8?B?NWtKbkEzQ0hpQnEzS1JMOVIyNVdUQWMyMmRJcFVhSW1hOEVkMVo1WmlRYkJs?=
 =?utf-8?B?TTVqSkNDcDRKc1k5Rkg1UmNMdUp1SUc1WHZVdzhuNjVwUVNnQVlOYStXYmwv?=
 =?utf-8?B?Z0xpaTgzQWVhK1JOMndzb0daNzE0b1VZQUlHbzVaUzQvSUJlUVU2VUZxMW56?=
 =?utf-8?B?ZStRWjlFc0d1VDRMQjZSV01LWXZ4REI1N1RtelkwUHpyTk81S0R0WGsvU3pV?=
 =?utf-8?B?L2NuU0FlWTJtTGYwOFdORW9MRjNITTBFMWMrSW00ZmhaL0JWTW1UZkVvVU1E?=
 =?utf-8?B?MmVZcHEvVzlYcXJYZUxpN3RDenhsZkFoUmRNamJsMGpzZ3pLdzVMdlRLenlT?=
 =?utf-8?B?Y2hEZ3hWOFFqd0pQMjZBL0dVcSsyeW9TT2tKZDlNdlMvVkVWZWJHbFp0aW9i?=
 =?utf-8?B?Q3VtNVFxV3dHdEJLTHJrSzNNT0ZyQWFNdFlTZHlRalNXdnkxeHpCNmhOcnlT?=
 =?utf-8?B?TDhMV2xOb1VydU9WVU83MENaa3ZHdFpVVmhRczdubGxrNjBMOCtmZDFjRGkw?=
 =?utf-8?B?c1ZXWVN4M2U3RnovSjBoTUppOEtqTTVsclJOTUlYWFM0bEtka3drNkpnQkxN?=
 =?utf-8?B?QXpVbXpNNlkyaVp1S0Y0OER5UlhkSUZsa3lnL3BqaDN3KzU1ZFBBWU0wWHZ1?=
 =?utf-8?B?cHZNMVRibzNGNW5EMWVIY0Z0L2M1ajlHVkJOWTNFcVR6WXVnUThxSDRZMzJ5?=
 =?utf-8?B?VmppdWxZZmZieG1Kd3RrdHpHMkJvR2FSTzZUSHFQZ2ZNMFhFT0JuR1lCVm5M?=
 =?utf-8?B?bVE3cENOY2Q3MmFLbEE3SzRzOGg5RlhUOVBpTFNXTlV4QUxGOGpaeTVkU0ZY?=
 =?utf-8?B?d2h1Y21Qak9QUTdzRElwNU5tazlTdmpvVzU5M3hRMGtNNjF5NUtRSllYMGpv?=
 =?utf-8?B?TXMvODZnbzRFZVdZcFN6dkdoTHZqRnVwRlBpQXQrZjUzemN4TWo4cUNMcm00?=
 =?utf-8?B?OWpxSXJkVnROZUcrRDQ0T1RlMy9SY1krSVBCVmJ1eDAxYVFUYWdrMUlRNVJ2?=
 =?utf-8?B?NUthR0FPVXhURlVseVVIL1Y0OHlQMnlEbXZBMmsrVTllNzRBanNqSFJndzZh?=
 =?utf-8?B?Ui9HSTZCVEZJZ2RpaWd4aDBqOTFyT0NsQzZYM2ZSbjhVcndiUTlDaHhQNVhj?=
 =?utf-8?B?NEdTQ3UxcU4xbldQaGUwSURLTkpnVWlWQy9QdVprbkc3Y3krdFVMbUIyUnR6?=
 =?utf-8?Q?GoOFVBKRFRY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R284Q2wxT0lOcVNWVzBJeUM0NzgxNHR1cmVhc042QTRRcXRXQlk5akNCT1pq?=
 =?utf-8?B?d0Zia3dXYUZwUjlLaEVmN1pTalJUMmpZT08zbkFwbHV1TEhNSVBpWWgxSVFi?=
 =?utf-8?B?ZUV1Z1BQVU0zNFVKMVdXVUluTjk1cXZEbXF0Vll2allWbENFSFpOcnROdk90?=
 =?utf-8?B?U04wa2NUbVgybkZNNGFGZGJBblZtbGpBanhCY3ZxMi9QcVdHeWlOMWx0Z05p?=
 =?utf-8?B?emF6WjYvd1YwZnM3aFg3YnFpTUkxOVoxcTNuOElEenA1Nnk2ejFmRXVLKzlV?=
 =?utf-8?B?Q2J1ZTNoZmN3a2pmbHY3QTUxOFZPY3R0ckE0SG1wVm0zRTlac3ZOcmVMZlBW?=
 =?utf-8?B?OWIwUk1EOHZWWXVTSHpER0FGSE5tdFRNVUYzV1ZEY2E4bEJsbDBwZktZb0Mv?=
 =?utf-8?B?K1gzazZrZzE0N2dXVVVOSGxwQXNWamFFTTUrbDA0TGtkb0JtcFNLYTVkQTNi?=
 =?utf-8?B?MVVOZy8zWmVTbEU5ZS9TenRlTWttV0gwSm5SOUZZdHFxUGh0eFRhb0xrbWpF?=
 =?utf-8?B?cEk2REY1NWlOWVhLK0lMZDBzNGt3VTErdXJoSHF6WDUxRytNY09Rcjd0L2dZ?=
 =?utf-8?B?UGpUa1NKZHZicU1pOXYySXh5WFNmQUlkN2NQUVJldFJ6S3JIQUlWWUkvNHE4?=
 =?utf-8?B?dkI4ZkgvRWJ2Y0tKZ1hGQ3QvY1pqVzQzbXJ1SXVqdDR5eUdqcCtjT0xiUEZO?=
 =?utf-8?B?WkxWMDdTVVlFUFpmc3MvbDY4NmJzK0QvendvUVBQakM3SEl5U2toUUo2WnJy?=
 =?utf-8?B?ZEhCVHhLL3dCYTk2TGNYWC92WkZQZGJHRlVWWmdtZi8yUUtWdCtoaU1JakpC?=
 =?utf-8?B?UWQ5dFQwdnNhMkhHL0NXT2VVVUpNbGRPM2lwZm5MQVNZQlJHb0VzYWlIeDl1?=
 =?utf-8?B?MkdtdlFtSkcyNkw1WDVhSFJySTBWOXJoSnVSNUlZdkxYb0l3LzFpOXVrL0hh?=
 =?utf-8?B?YnZBeGYxeXdFOE40TC9jaExSLzRnRTdLSElwU1BYQ1MzY1BleXEvQjFiMkZk?=
 =?utf-8?B?UUFSYmVtQVB4ZkxScHN5SVhJSVBQZFF4VHpJVUJsNFJxRVVHUnpVQWRacXdo?=
 =?utf-8?B?Q0NPUUpaTFpWZnNFQzNDa3RpeVc4NlVKaTMzOCtEZ1cwajJzV3ZGdzdBVGlL?=
 =?utf-8?B?SksvdEdmL2tWaE9TNXFtalVMczcyWWZnWkNDeWk4dm94WXN6UTBNNzNiTG8r?=
 =?utf-8?B?REdBRkhkYXd1Nmp5TU1sZS8wbzRucmdjMzh3YzV5aUFjMUIzMHRDWjdpU29i?=
 =?utf-8?B?bGtwamFwNHBpR0Q3WGlhSTdCOGRjTnF4aGRMWU80TzN0akJiY3hpaHJsR2U2?=
 =?utf-8?B?VVdERjNzS1RIektDOHlJd0x6SWE4ajVRTDFMb0ltTG45aCtJc0FZcXhFREZz?=
 =?utf-8?B?RGd5U0ViQjE4SUVBVjJmN2ZhMFV6eUlmYUJYYTZOL1JnZFUwd3JQZy9QTTly?=
 =?utf-8?B?c0VHa0s5d1NwOUxMVi9jSXYrTkc5cGJlclIyWWgyMkU3SzVMRWFUS0NhTDFV?=
 =?utf-8?B?dU9BK1VUODJzeHRuR0VWQjIwcDZob3BJK250eE54ZGJNaUlOSHYvbU8xSmRr?=
 =?utf-8?B?NWZrV1UwWTFmQlZWZ2F0aXpsUE9WTktiUi9pTzZQL3pHOTNEdjhBVG5kZGZl?=
 =?utf-8?B?YkU0TGdzZUZIRXNlNW9VRGI0N01nMDh0L0Z2OGU3aENwV3g2M0RvREVpTC9R?=
 =?utf-8?B?K0l3ZWJ5bi9sOStkbGFBeWEzKzFYczMweXFtcWorMS80SjZMdFlSL1E4RjBB?=
 =?utf-8?B?MFFTYjVkSWU0RzJPRVVjSGt3SjI3QkJSOWI1by9vYnRxSUVBOTRlU0NXM2c5?=
 =?utf-8?B?M213Uk1sd3BxTUdMYzNHVXJ0RkkwNXNNQmg4bXNLUmJ3SHdrYzV2MHZyY3Bk?=
 =?utf-8?B?RWNhUlZOY3M5WVlXUUUxSEV5aThzS2xVMVdJaVZLMGdQVE1RTWRvWlgxZ0xZ?=
 =?utf-8?B?RmRpbERNYk5YeFFMa0l0cWN4QmxZU244bHBSV2dRTzFneCtjcmF1M0xRNVc1?=
 =?utf-8?B?b1owNjh5NWxnRWFjVjVCWS9MNTgyVGc5cmhJTElBR2Nia25sOWpoaGRmQnpw?=
 =?utf-8?B?VXE3dmNtdEJ0Z0Z1dGEyQnlPOFBiRlgxOWtXVDNpODZmUlROZzdaekFQblZz?=
 =?utf-8?Q?25F4cTSyigrcxcDGqizAr3afL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525570b9-de53-48b7-d95f-08dd7b555d64
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 13:07:53.0044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VY1WwgsVpnpOObG/VKv8a1rwgQ7SU+ahcSx0IzWxKN/7DhlK9ZHeJls/kp0tGd3sKm5oaQFmzYiM9Qh9P0mzxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7601
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_060757_625353_42CAA25B 
X-CRM114-Status: GOOD (  15.62  )
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


On 4/14/2025 5:56 PM, Christoph Hellwig wrote:
> On Mon, Apr 14, 2025 at 02:05:09PM +0200, hare@kernel.org wrote:
>> From: Hannes Reinecke <hare@kernel.org>
>>
>> Commit 62baf70c3274 caused the ANA log page to be re-read, even on systems
>> where the ANA is not supported.
> And unsupported log page should normally not cause a boot failure, but
> it seems the controller in question does not handle it well.  I've
> applied the patch with a better subjet and commit message explaining this.
>
> But if the controller handles unsupported log pages so badly it will
> probably cause trouble in the future as well, or even now when
> applications ask for unsupported log pages using the passthrough
> interfaces.
>
> Srikanth: what controller is this?  I'd like to add that to the commit
> message as well.

It is a Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe 
SSD Controller SM981/PM981/PM983


>


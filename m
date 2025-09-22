Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C298ACA100F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 21:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jOAq576mVX1vsmyHaC40nejVzFURIgVjvxeQFNr1GTE=; b=HjhRnP8SAvgfOs/G6tRgCkrN75
	xwrL3HmhVSFoUBDKYqvN/ecsABhCjADD0JBejbJ22Z/xL9uAnPAXZ+Z8zr4B8w7GdDNSzbBbqMLZU
	Q07VuWXg3BgcbDO6gBX0EIxoZNA/Ooz595ywo4PrSY+pi91cE5EOsI7dw1quzeLeEYMCwk0AvlsiQ
	3LusMX2j9QvIiuzLUw9MRPQbxFbaHXPOb+vNNSdRzL/JJRfscNOTuVYmMoIO6GayCE6zaqygb0xnF
	Rjiw3zEg3ySugYnAEvlBbPtiCD484EEJXNxU22rwlugOPotxxcoGLfLavce78p3VS14fdOWlroGSF
	78TnHOgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0oLx-0000000BaMo-3505;
	Mon, 22 Sep 2025 21:45:45 +0000
Received: from mail-eastus2azlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c110::3] helo=BN8PR05CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0oLu-0000000BaML-2pXk
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 21:45:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQvOeWFDHFM/7VNo21ILbqEo7cb0xdJlUM/KFS7nDhF/gaQ2n/vg0g5iulDjQulqpEB9QlFqQBvdY5yeyYWAih/quAizYDZ1AWskrPXUYAsfmyhM4u6Hun/0vuWDUkRxdwVFWCh3Ttj6TecH8QwXLUBmCodJ3Sg7NlHAfTTf5PYqAW+6Aq3tJ/HQl9aPspw6W3+n7N9zN6b8DlxogE+DLTIVGWoqoAOYjNcNo4JGsld9V6cX7K7rI5Tn7f2UjrVGm1GVkOaeNO6O/+1kC5s+a0SIWaUuAgUp0t8NuDEkbfX52fOxGZrjbUYosB+Zsrajjjo0di4BpQdLq0hkFTxbiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOAq576mVX1vsmyHaC40nejVzFURIgVjvxeQFNr1GTE=;
 b=Unzpr4NU0+fCi2E1czzkNIOo7Iam9+DpV2EM1uVbu5ddTyvuh/nKvhmrn3TXWw2Wf3SeLCnx93lbUQNShA45pnkYjB4kmioYt+5n2NnR6lCL+BQ4m1jKOl6XoGiSEoN6UWin340txnZY5ZBbCEqMy+8qoCFMjz2HAPdxPyw/iQhnwxNnWuJmMcz/m3TbhTR7V/qSMPMgv3oX3foCMn4vL5NPSKM4a40EWHKLuXZ4GTIlG1Cga8ffVQTa0nsiTvSiefqetmTU2EQuMy0YKr+Uy3ZCD1EIjV8u5fvcgQTqZW8E9NVZRTvE0kydxOWBBdxtQPsolmQnXwz8NPF0rLKIJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOAq576mVX1vsmyHaC40nejVzFURIgVjvxeQFNr1GTE=;
 b=hHLyUkVetH0p5z5/vTIjgV9/NqlWWGIJtwwdQvzXCaf6zke5MOlJi+RZi2gG24LMu0nWbqKZL+QiX0M3ZDKpJABrZJ6sQT2yFUi2dQoctUPiKffLfkmIDQYO8LQSLmpRWzU0AS5+WLdpXPwXmFVYqSBxU53tvHm75AJ4C7DtpqRbx4wHw7saQ+jEhq2nPy4+A1HclWkGgHh2wcQ9ujM2deVQJf3kfR8xlJZonvv63itEPKrw/QO3Ms/+r9e6PB/vR715vdahXUZyPdqrA61dyzmsx1hLTfWKEDBJewPdz4Xx1nX0GZbUUEgt32EGUjVBJVa3qnyroD//BqgeBNIfog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by MW4PR12MB7430.namprd12.prod.outlook.com (2603:10b6:303:224::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 21:45:25 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 21:45:25 +0000
Message-ID: <80b1b681-b914-4085-bf21-2a2095d6b506@nvidia.com>
Date: Tue, 23 Sep 2025 00:45:20 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvmet: replace transports array with a linked list
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 sagi@grimberg.me, kch@nvidia.com, israelr@nvidia.com
References: <20250920234943.4959-1-mgurtovoy@nvidia.com>
 <20250920234943.4959-3-mgurtovoy@nvidia.com> <20250922173540.GC14393@lst.de>
 <cfe873eb-5e39-48b5-9d9d-1e2874bc1e30@nvidia.com>
 <aNG_PeEFqTRFp6Np@kbusch-mbp>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <aNG_PeEFqTRFp6Np@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL2P290CA0029.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::19) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|MW4PR12MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 1423a5f8-23c7-4e23-1994-08ddfa2156c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0t6Mk5JUFJXSWIzaVV3MkNLb1YwYjNYUW9nNkV6RkZ3MWo1K2FQRmNTdjdW?=
 =?utf-8?B?SVhySDN5R2V3RkcwWjE1Y3FLSHFGeVV4cWhMWWpzSVUwQ1NvblZDL3RsdGh6?=
 =?utf-8?B?ZlVHWWxLTm5yUXZ6VlljODZLVTVDWHEwN3pDQUtoK2c2MEI0RjN6amRqQndo?=
 =?utf-8?B?SVEweWtnTUp4d2U0NCt1LzQzelJQR3FiVmhwUFF2SmtWL204OFJoS3BzRC9Q?=
 =?utf-8?B?VTRMWmFwR2xrSElROENtbEpwNWxUOCtNUXVYOE5ydm5aNFV6VjJpNGdQS3BL?=
 =?utf-8?B?MzBkaFRPNXd3bWJYeFBIdHRxVHRQVGdzZ1NwUEsvbGdzdFBlcUlwL0luZy9k?=
 =?utf-8?B?ajdlYlc0Z1FMcTE2YThGU0c5eDhiM2JoTDd3NlFNSHhBczdicGxETXJXQjk2?=
 =?utf-8?B?MklQcW9kL3RiTjhoQklqRFh6eFpXRk9iVXZ4cXFlaW1Ec0xkdHBGQ3lYbjJk?=
 =?utf-8?B?b3NBZDFIclhZTlBSZ1MzcDh2TUNGdjRZcVZ0cTgwNjFVVTlFcUE5MkVpT1Ir?=
 =?utf-8?B?Z2RkSGtsVWhCczhDSHZ0RUFVdG5DR2J2NHlzd1dlYmNqTlpTbmlOaEhwVkV3?=
 =?utf-8?B?WlJIS0VFcDBrM2o4U21Ic3Q2TVZKL3JFa2IwajFsajEyN0h3aGxmTXNmbmpl?=
 =?utf-8?B?cWVGMXUzcDFSUXprTkhZUzkxVExHVnJhbFYrWWFMVFhhU2ZrMWdGb0tKZW11?=
 =?utf-8?B?eVdTMWYrSEFXdjlUaVczem1QcEtlSUgzbnZ2cmRtSno2M2FVNENnUDRqTjJ2?=
 =?utf-8?B?L3QvNjVhSi94b0lsZkVRY2RlOEVQVGdseXJQWkJwNTd2Ky9sZ05CYWhsd21r?=
 =?utf-8?B?WU1Gdkdlbi8xaXhTZzVYUE11VENpZ2xvUUhMeFBsV0dGeGg4clNINlhLSVI0?=
 =?utf-8?B?bTdKeGUxS0hKbUFEWi94N2lrR0YyOTdmR2NyTnExZFVUR0E3ZmZqSk5tNVJz?=
 =?utf-8?B?Wk43UnNXSkREZ205R2l1YjhNTG1GclBGUGs3WW9MYWNCbStESm5vVWVEZ1JH?=
 =?utf-8?B?YzVZK3c1dmRzK0c5VS9sV3hnc1UvVHN6eUE3RVBtRDcrQ1A3ZzVtYTRBYkhR?=
 =?utf-8?B?MjFXQUxnbXBRYVhKNzZKd1JQQkswUEwvRzVHTnp6Rlc2cFAvZm12QkUxalkv?=
 =?utf-8?B?OGFUSHY1UHNRcXlMT2xJbGdBMit2dkhIdWhXRlp0T1BXbGROOFpwZDlKOTRW?=
 =?utf-8?B?RkJjN1pxTEJqU3BmWE5USnJKYmRuUEo1VGtBdk05ODJIU2xHS1ZDUlRPelpY?=
 =?utf-8?B?dm9UZGFpR3J4YjlBSHJ0TWNzajlNdndsVWg0MlcxeVBiTnhUdG9CR1JSUGdn?=
 =?utf-8?B?NE1RYW1mNHJLZVU3SG05MU1Nem80WWtUcktHcDlaa2xDUHdSQjFMYzRneXlq?=
 =?utf-8?B?ck1NbktHMmhvRG93T2NKTFR0czBSUE8wL2JLSWxUbnVTc0greGs5aHhYcmNu?=
 =?utf-8?B?d0JRUE9rQmZwa1owaVRJc29lcXg4U3dxV2ZSYXg3ZndXRFU4dXVMc0RhakJX?=
 =?utf-8?B?TFN2c01EOVJXaDZ2YVF6YS84VzZSeGhxUjFiazNDeDVxeUpTL2V3cWlZOW1D?=
 =?utf-8?B?dGM5TzA1b3czdTRqaFlKQjB5RDd0d0M0MFpNUlN0YmovM2pQaUZDMGxBVnV6?=
 =?utf-8?B?V0E1dUM5anRtSVArTXgzczFHYTl5VDM0ZTZTaXZMODh1bzlFdWNRR2ROdlgv?=
 =?utf-8?B?bWU0L1ZvN3dzcFhISmR0S0pDRUdlUDNuZTdYSlhOd0VSL05yZVlVdGJybE0y?=
 =?utf-8?B?SHZqeXFhR0RTbWtocnBlREZzV3VTVmpyVENNdTdNbzN3ZnhRRUo1bGVYUm4w?=
 =?utf-8?B?NTN2NjN2QkJId0tJK1A0Z0hiR2lDSENBK2hRcXlUK3Jjd250YVRXaTJwSEdB?=
 =?utf-8?B?NXYzT2Q2aDBFeUFnRVpiVUxLb01IL2xwSi9KR0J0QkUwSTNFNUo2MElDeG1G?=
 =?utf-8?Q?EqwQlyiGmvY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUNYQjZWUXdGUUVBQzYrV1c4dWlsMHFmZjhkZ1QxWUM2OEoxVWdwZWtwN29m?=
 =?utf-8?B?TzRiNU9wYklQaUw1YzA0dElEdUNsc0tFdmJpbzJ0K295R09iTHYxY01CY0Vz?=
 =?utf-8?B?SzRsanhaMWhLOHZSVmVoMUVNdVR5cm5UTmZEM1lLaTVqcGYrdVJWamROR08x?=
 =?utf-8?B?YTlNMUxManFkK1k5NzU2cGcwU3ZKR0hGMGZtbHVveExUUVhxSUtDbGFLa1VW?=
 =?utf-8?B?bkRtY0NrQUFDNXlRc1I0VkY5amJuMHg4blJMTS9HWmNPS1J1RVdEbjFVd1pE?=
 =?utf-8?B?TVBjdXZ1cTlYL1hRVjJXOEVNYmE3RHNqUlNBMGdWT1dkUHdGOU1peE9pNmZk?=
 =?utf-8?B?bjJ6YWRiYmIydXhhUHM5cVB3TjQzZis1RHVhUFl3Mm1qaEpjSmdXOTdVMHY2?=
 =?utf-8?B?ZTNKTzhpNC9teTMvWVZ2UEhIakw5alpONWFvZkNjeG92TFVpZXJLbENEZSti?=
 =?utf-8?B?YklIa3MyNDZOY2dzS3NjYW1ZS3UwVHFVZmN6Zi8vM2NmQVIzVWxDSEtZa0tW?=
 =?utf-8?B?cTZ6Qyt0M29sS3dHZFhvczZyNUlpKy9VLzVQZ0FEZ0tLTm92dVU2K1c2ZnRw?=
 =?utf-8?B?WWlkNWk2Qjh3aUJzMnBTRi9SVEFoMlZSOFFXQWg2U3JuT0wzYlUzTjJoK1ZM?=
 =?utf-8?B?R1JROWtadktJWkVMNXEyRHJ4eVlsWUhQSUdXTlhPcWhGSlJyNnM5cVA0djJi?=
 =?utf-8?B?SjNiZUFxMllNdTlobWVDNnkzekFiNTdmZndnTUNGNDNVM1lMVFEwOHdZSjNO?=
 =?utf-8?B?K3BaTDVSRHpRSnFPOUIvR1BsbEVwYmwrankwT3NHaVQwbXJiRU1jU2RXK0t4?=
 =?utf-8?B?Vm0vSE1jUkVBNEpjTnl5SHErY2RqNnNZQWkvME1SejdtK3gzeXJlc1M3aXcw?=
 =?utf-8?B?MkV6ZnI2UHI5bkhDUktoRVJzbmFHVnJ2UWdEUURWYlkvdW0yd0JTb3NhNHh2?=
 =?utf-8?B?eENlWlRhTjFHUzNIM29vc3cwc0Nyd0ZEMXB6ZDZJY0YrUXp0RXRhczdhZDlI?=
 =?utf-8?B?OEQvYityZXFGSW1iK01ZQUtZOWdLNEU4L2NvQ1RIcTJxa2FyVFZrQlptZFFB?=
 =?utf-8?B?MTI3ekJ2RHY3ZklxUmltbWFEWDdmclFGYXU0Zm9IYWFPOXhSbVhuVHlwU1R5?=
 =?utf-8?B?L1pHcDVNQ3hPRGpuOFZEcDJMR3hGYitwTmVVdUt1UDM1cW0velpkd1VGQ1F1?=
 =?utf-8?B?K0hiUHN6dERwa1dkMzhsMno1Uzg5MEtoRG55blR3UEkwSUVMS1RPc3FHcy9J?=
 =?utf-8?B?TElFT2VqbjhPN1BreUpwRjQ5NU0yeGNMc01qTkdlUmpjTjJsMnpZTnhGYUZt?=
 =?utf-8?B?Z1ZwRUI4a2YrVThyUFN6cE1uWTF5Qjk4WjV0ZWRGS2JQRTgwWE5XcUF0eS9i?=
 =?utf-8?B?cGJiOTI3VldOditSYURzWElPWFB2ckdYeGNTcFl5RzgxSllibFNIZjlGR0lT?=
 =?utf-8?B?QXVMMHRTc3pRYVYwdENJcm5EU0pmZjlYZ3VoZi9nMEYwQlRoVnFUZ3JPemUy?=
 =?utf-8?B?YTR5enZPaW53eDRDNHJsaUp6akJHcGE1eE9FaVEzWWR6emllU2E2TU0xblp5?=
 =?utf-8?B?SUl2SkxqelVuZkxNSUxWU3kxVHFpcnlzN2N5TDVlaE8xR2NJMkJ6Nm9yQWJO?=
 =?utf-8?B?Q0MycTRZQmJYblh3SXY4YWFGVE9IMlgwMndiMjNHKzVNK1VpL3dZK1NleHNV?=
 =?utf-8?B?MjdGZzNLYWZHQWdETEkxQXY0bitVOHRKdEllTkJkNXFyZ0Y3NTJ1WDlDQzBO?=
 =?utf-8?B?blozd2w3aklydkZJK2ducThVQjFKK2h3dG5tUlJlY2ZrTE1aeFpHck1HSWVv?=
 =?utf-8?B?Y0VGZDgvVDFZbkI1djBvcVFWblpqUG00cXdXZWdoWi93WUJyd0ZRZ3BtZ0Jh?=
 =?utf-8?B?cVlXUVdKNDR3eUdBSHpURXdkR3BIcEVzR3p3bDV3ZnFvOU81T3ZYTWJYN3Vq?=
 =?utf-8?B?bTlXaGpVdUpCeFdyRmJiS284RG56QThBL1o0NUJzRXpQWldyQjNodVZXdXFr?=
 =?utf-8?B?WllkMnluU1pETEVudWt5d01Iem9pNVVDYmVPOW9kOXZ3aXJLQ2U4TlYyZFZS?=
 =?utf-8?B?U3cwMDZ6NTAwTVkxYklQczRpbmRNM0plWVhlZk9DV0IzaHhYZm51a2lHL1Yr?=
 =?utf-8?Q?YTEN88Iq/g8t37OqIYU4cazCJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1423a5f8-23c7-4e23-1994-08ddfa2156c2
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 21:45:25.5734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y9l0H3TMraz+8QkZT7rFdGylQXqEYXUV8ZNLphFw45N5NFc6Rz/RFvT0JV/wOF6tg2VCIBQ/JgTJ9BJ9qJ8k1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7430
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_144542_717040_36693F80 
X-CRM114-Status: GOOD (  13.73  )
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


On 23/09/2025 0:27, Keith Busch wrote:
> On Tue, Sep 23, 2025 at 12:19:59AM +0300, Max Gurtovoy wrote:
>> maybe we can do something like this instead:
>>
>> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
>> index 655d194f8e72..8e076960875c 100644
>> --- a/include/linux/nvme.h
>> +++ b/include/linux/nvme.h
>> @@ -68,7 +68,7 @@ enum {
>>          NVMF_TRTYPE_RDMA        = 1,    /* RDMA */
>>          NVMF_TRTYPE_FC          = 2,    /* Fibre Channel */
>>          NVMF_TRTYPE_TCP         = 3,    /* TCP/IP */
>> -       NVMF_TRTYPE_LOOP        = 254,  /* Reserved for host usage */
>> +       NVMF_TRTYPE_LOOP        = 15,   /* Reserved for host usage */
>>          NVMF_TRTYPE_MAX,
>>   };
> The 254 value for the host loopback transport type is in defined that
> way in the fabrics spec, so we can't readily change in the driver.

ohh, I was sure it's out of spec but I guess you're right.

Anyway, we use a list in the host fabrics driver for the same purpose so 
we probably need to align having a single design: an array with const 
structures or a list with non-const structures




Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44C7CCA470
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Oct 2025 11:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AvmgYTyDjntE7qPaTwh/C2Ia2uPFjLygYQV0YlZH1qk=; b=ROys372trL4ygjlIOyXoj8BadC
	OC251LwDWrWHBVNV6S9qaCdsMSvrjG2sZPa9b8WVBLKZrvWqESQKYy+c6mCrrFgs498VEFs/Csf1l
	zQD0C0ZjW7Zhg68X7Lc/6OLv+4AYT13/EXyKCJrQBvSAKzKO15++20MvgQM/pDe57dIPGNpJ1yaAR
	kEgkLo4odazX2zP+KOjmipDFf3bcw3RSzHEpAG0GNQR1Gr3W474VuZGDBtgO+tig7SNB4ftIGKm62
	Glc8Yob4YqDrBtYE4HY1k65QmqFH+d5+nIpfAf47f5IpKPJhr3c4+n5KOcVe72ur9/aYY6fkVLEND
	xRjTB1eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6SU5-00000003jf2-1ZfI;
	Wed, 08 Oct 2025 11:37:29 +0000
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6SU3-00000003jct-0SMf
	for linux-nvme@lists.infradead.org;
	Wed, 08 Oct 2025 11:37:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSk2DfShlr0KeE3nKrSKMNWG8H/CgTGfy+tpcoWSfI84VJF8FW20xYKVCnRA5mRQOlxCp5cTlhbm/MhG6wdgAydwCV53BfNmq7Bn2gWEOPuR/8jbYuLf90bJ2OmY7l5VM3Km8jLq8cfJuEk/cjrDSkG1zP1irdgcYC2R6NjaJZCEVUY3KFz/6Y0z91lWPGABlqCHE0egdGGYE9ME8Zgg10I2AyZeryoDqv5EbVICSaRFdI2QtziPmvR8BQgIHmXUhovW4v302oTLTDCLnyIGpIZTAtTZ9FcTCCMLH/PZLxUZTAnh/9ELAESOqSpASnDkgHZdSBLSF/cIEC9JrC/JzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvmgYTyDjntE7qPaTwh/C2Ia2uPFjLygYQV0YlZH1qk=;
 b=Gdga8qT8LEQpB/ucPOlaRVWswzZKo5HVncRwzkQKD24OESzJaWJqmiWdPcInjLppDMX1ZdmhJ+0jdb7NtVFm5WCKSw+SRjL5FFZ9SPeXygHP8H8GpsWi+m7W5uEAZKcOrPxUrRuSy4jEz/ArDJhxfA4lE5KrTSQSKDEX4YEGl4AXPpy3BSgr0NKKG96Y3l1o+PSkBDL2BVqf7vzyeVhAwGysQIZtPo1WUSo4iid/L5e4XFG4ZWH0rycYsW6ajaWtMjtJz/S68DiUsbJxfy4GasGATY/WUZKY6CCTotGMp6oerOeaejWR3lDZhAQbJqqRpvRFJxspSCj8vbrWyhe/DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvmgYTyDjntE7qPaTwh/C2Ia2uPFjLygYQV0YlZH1qk=;
 b=RlCcfzDdWYYxsSgiopUdQd+U/jwW516wGmNnTVONLSkVkOWVhqtihHqirfDXB8EAtvsRly47IxK+IsWD0eu5ymfE/RDXZ+BhyLvRg+PIIJgOgZrxOWrjRSL5WmFCyPv5z2/TSp6qsgkKFAArw6KTyKmwp5QEPWWisgK37Ue6L4jN+C3cSJJ26oWzYSi+S7xk4EVz1EST3VdeGFkDsMxIXXlxXCetVx2kGk8UEvecoL/mliYxt3bSM+HAUMTn2jpk87zCb/QEt9yTbWGcWdek2M8gltDQJE+M+VcHor2lxwzTIM+5luGS87ULYzTAWAvzVtKYQEtKgr0kS7L6CsZIEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 11:37:12 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::d4c1:1fcc:3bff:eea6%4]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 11:37:12 +0000
Message-ID: <b3adbd5c-177e-48dd-b308-ba4bd4680ad4@nvidia.com>
Date: Wed, 8 Oct 2025 14:37:07 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] nvmet: remove redundant subsysnqn field from ctrl
To: Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, sagi@grimberg.me,
 kch@nvidia.com, israelr@nvidia.com
References: <20250924203402.10688-1-mgurtovoy@nvidia.com>
 <20251003072542.GA12624@lst.de>
Content-Language: en-US
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20251003072542.GA12624@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To CY5PR12MB6369.namprd12.prod.outlook.com
 (2603:10b6:930:21::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6369:EE_|PH7PR12MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 55718ade-da2d-45e0-9627-08de065f059e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enZ3NjdjdFIvRGs1K0dSdUEwekFjKzdPLzJSUkd3d2ludlU4ekZzNnBrV0hJ?=
 =?utf-8?B?eU9WODFCaXArTkg5TzFtZzJCT1BqK1J0UVh2dDZDOEF6S1BKZ1BJMzJSa2pi?=
 =?utf-8?B?SFpzZC9wVVRPMDlPWmpScmlDMFUzRW9oalV4ZXpHeEpNZUFsUHVHSTlBVjM4?=
 =?utf-8?B?SU4yZmFrdVdQdUpUZkwva2h4azVSbC9jUEMvR1E0enN6bnpkZEN1VGtONnJ4?=
 =?utf-8?B?eFFWTU1sY0RPbFhuWmFZTFEzUzVaOUdFOWZEQnBHS1pDMFZQejNrb3p6SVJ1?=
 =?utf-8?B?bDduVVBuVzZZOXc2ZGFKam4zb1pDaUpWZ2lDTTROYjQ0NktJSm9QQXJVSEpJ?=
 =?utf-8?B?NEYwM2ZWTnpidEpWYlE0dFFrb25MOUxLMlJONEF0RGQraEVHMHVzNzd2aUVI?=
 =?utf-8?B?d3Y2dXN6blRwNlU1RnU0eXNvRnRxeU82WEU5OHJDcnNtdFJ0NnpjMUd0K3Js?=
 =?utf-8?B?WUtabFRFRjg1TUM0THZ0MHo2b0hwZWlmejFta2VZZVJobVdWbEtTQWR6aEZQ?=
 =?utf-8?B?K0htVmx2bmszeDFRdGxOQmdBTElVVEhHa00vT0hmaFBFSnp1RTRhTlR0SGF3?=
 =?utf-8?B?OEZkd0hnQnM4Njk4c1ZmK2pWY3EwYkJmd0JRYUp0bXV6aXFqT0RDWEFxdmNX?=
 =?utf-8?B?Zm5zT2lPVDIrbFJpRnJDY08xM3NRSHlRSWM2dG9CUmhjam1zNWw3RExiWUhp?=
 =?utf-8?B?N2lJdExydWRpNnFScG9ScVJpSUVRUFVjN2VlN0xjejRHTEhvMmczQ1VRazhY?=
 =?utf-8?B?bW1IUkc1QThGZE9wbVBCcUJVOXp0WExkbURVZFBqM1NGNmpPcXhtL1h5N1h5?=
 =?utf-8?B?eENuUTlyN2I1b3FrVFBrUVMxNWJYS3FFcnpHRmJQam1FT1VMSHpyek1HS3RV?=
 =?utf-8?B?NEFBTVRtTytrREM3Wi94VHl0TnlFampTNkUvN1V1c3hPbHZFeVRTUCt6M3lI?=
 =?utf-8?B?L0thdWwvLzVFTEdBckNYekhwdUMzbWZIVmlTdEdEQm5nQVlqRHFZcHpZUGl1?=
 =?utf-8?B?bk5UNk0rZEhOdXZ2NHRFNGhsZnZURjl2SjdMVWhsRXZmcEFIaTlpTkZNMEx3?=
 =?utf-8?B?OUY3cCtGYnJoMVlGNTAyYklmTW96RktjTWFseW5YaWpJT2UxVmlnWDErMDJL?=
 =?utf-8?B?SlFLNm45MlltUW03V0pqNEp3NklNZTFQaktPZzdLZExPdkJHems2WDF0dHlt?=
 =?utf-8?B?azA3Rkcyem9naVhqeCtNSGNyNkFJZm1yenY3NzFxYkpsdkw0czNxeTR1TjEz?=
 =?utf-8?B?azJYYlZIZVFEazhabHVUK3Brb1poSHhEUW02djFUaTk0T21mdnd2ZXVVWGFB?=
 =?utf-8?B?bm55cHVSOXNaOEJVQjNGRXM0cnhtTE1RZXhtQldzb2Y4RklqRk1mZU4xRTRv?=
 =?utf-8?B?OURUZGtEeTVMWWFaT2JGeTFHUm1XcGhYK0lURndpVU9lRFYwZSt3RXR5Rjlq?=
 =?utf-8?B?ODc3V25hWmR4TGljSk1nQWxSQXROV21ycEZnL3I3UkhVbFpNbHdTRml5OHd6?=
 =?utf-8?B?MHZISWhDVUdJQ0lxUXkzSnM5bGptdnByelNTaU5EQUdOdlI2a0hrOS81bGpm?=
 =?utf-8?B?bG5Bb3NoU1lnaGRNQUhKZlcrcWRXRG55cThHSTlkK1Z5Wk9ob09rYnVna0sz?=
 =?utf-8?B?WTVPMU9OVitPN0NZMHZMSXcvcmp1N3BreWRZd2w0RFJpelc1cUhhQ0J0RWZW?=
 =?utf-8?B?dW0rby9iSGt2NitQcFdQdFlSS0gzcFNnSzFsUU4yUGQ3VUE2Mlo3c2NrcGI1?=
 =?utf-8?B?a2pQNm9sc28rUUdQb1FOdXZHd25YS0ZWc05EcEtJR1JuSElaUTZtU3lFWm1o?=
 =?utf-8?B?S053RzFzVFFOWmVYYWRpSVZ3U0lFSU5heWt6T0J6ckkyRURkZGVqRDA2S3Jn?=
 =?utf-8?B?ekl5aUswWG93RXFNQXV0K2p0NllmeTFOVGUveVhLVEVSMjJzdFJnNVJYRUFy?=
 =?utf-8?Q?fDANFN5vsVtpD9B/zEN3pE6Lw/6CzmP5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6369.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?emxvQTlzTnhFN09SYmtRWFlYRkdSSFE1dGZ5YTNNM1pwS1lkaXE3QW1zT05k?=
 =?utf-8?B?MDd4S1RQTmxaYmlJakU5N0xhcXg4UXFKUjdvYkpsMW1KVVhLK0Jwc0MrSlJs?=
 =?utf-8?B?M3AyWjlobVhHSzVqQTdzOEw3UWpKbm1mR1BLVDhGbS9mQlJXcDc0VGhPRy9J?=
 =?utf-8?B?Vjd0L1NrRFcwT2lucVp1cm5yTWl0S0NWbkp5bU9oZGNRazVxWWNTeUQxK3lP?=
 =?utf-8?B?dnVHOENqTTgrbG9JcUpQTjF4QlJ1NTdoY3RWQjFMYmtxdlltbUg3RlljY1BQ?=
 =?utf-8?B?RWhpcVhndGZmUkN2SXZxTlE0RDZybFR2ZExja1drUzFxTXpzQjRHOFdNd0lt?=
 =?utf-8?B?R0EvRU1nRzJTdk5LSUhyQmZxVUV4WW1hcHRzMXIweXFmZ25YWTEraktjc3cz?=
 =?utf-8?B?U094dmQrcTY2RTdEVkFYVHdyM1VJVFdTTVlYZzh6bDhvQ3EzVWYwWE5sYVpz?=
 =?utf-8?B?RmFqaWNQOVdMczhSaFEyZkkyMmFvd2w1MEt4WDdJajBFOVN0VlRyVCtRd1Ji?=
 =?utf-8?B?YUlPM2hwNWdIOElXQkJEMWZHbFdUclBaMDZYU2tyNWFjdTd3cUJNdENjZWpP?=
 =?utf-8?B?NkdmOUp1bzV5MGZFbk9yMWtEWFg0dkxXZEVRQ0hwYVlXK0MwVXlGdXR2WHNu?=
 =?utf-8?B?K2xMZmVpbW5DQTVacWIvV0h0Um5GTXpZcWppMklCYkRZRXQ0bkV2dWR2akMw?=
 =?utf-8?B?OFZqN3BjeDd6a0JZdCtZbkJFaDRxRzByUXdweGJiaFRUWmh2RlUvVzB3NlY1?=
 =?utf-8?B?aTMxSGRXdTJmYW5UWDZCSzlNb25wK2w5Z0xkSEFzWGplZXVDU1c0UC84Undv?=
 =?utf-8?B?Skg2RklIcmlyS21pZ3VRaWd2VUFJTzJOUjR1ejVmOG83RXp2V0twY1YyWXkv?=
 =?utf-8?B?ejc2VWhaTDZMdFlYRjhyUHR1Vlh0L1FGTWJaQUVSdmc0S0xBNk5YU3liUnBQ?=
 =?utf-8?B?T0VadXFNbnd3V2FRWG96RmNPanA0QU54cGdzY3pYSDZEWE1Pd1g1Q0tBdHhi?=
 =?utf-8?B?ZTJWd0t6cVJRUVJSb0lsNUdyNVJDZVBiWDdQNS80RGRqMklTVG8zVjlBYWZu?=
 =?utf-8?B?M2k5TldqZXJvZktHQVpQUE03ei9KNXd1emtDQVNrbnAvdGIvTFlBcnZvWmMw?=
 =?utf-8?B?dWQxNEpMNWhEY1Z0TDBOSWxYWHBuRzNDUFB2N1QyTTRQcjBYU1FBYldkREJ1?=
 =?utf-8?B?Y0o4RW90aXZjZlFXT0t2WXZ4SXhqU0k3dmgvWnhqNkUrS29oSHd0Rmh5ZzNs?=
 =?utf-8?B?Sm5kRVQrcDZ4d1drTk0rRGFxNHBTTTQ0QnMvS3JUOVJ2cmZuenNYcFA0cGU5?=
 =?utf-8?B?WDdKdisvdlgzekpGWVdsWVAxaUVBb0FwS0hXSnh2S2tRbDZvTGV2MVVkUUtP?=
 =?utf-8?B?L3d4ZC9jUlI4WWNmM3g5WVVQUEg5Yjh5RU1YcTFybUFsSE9uS0xsMEd1QWtz?=
 =?utf-8?B?dlBLYVhPVVNESGVFUzV4SWxkSzNydDVnbkFpYlBGQWhQMkwwdzBLeWh2cUk2?=
 =?utf-8?B?d0gzTlc5K3ZWbGIxOVRTd0dhd2ZaZS95YzV5OEZCbmk2c09sRzZYUjlkNGc5?=
 =?utf-8?B?VEhzRmVBRXBGNkMyT0xUbVQvcnUrci8vYlNNZi9Na0Y0SjR5YVBoVHRKWHlz?=
 =?utf-8?B?b0RvcXJiNHhjenZvRVBvWnptcWdKOTltWXN3Nm1wOUZ0Z0p0dWlpTEhMU2xq?=
 =?utf-8?B?TWgzTndjUVo2dVBoL241eThHOUZQSi8wUnB0UFNJYWdOOU5ISHp4ZDRMamtE?=
 =?utf-8?B?VTllc3JoYzhDOGJ4TFFIMTlQOGFPWm1Vdlo0eXltazF4U1A2L24wL0Q0cnRt?=
 =?utf-8?B?bVpxMzJoT0Q4cGJFSTIvSHplZEx5akJEazZjbzh5ckEyUXpBNGxjYmJsU1ht?=
 =?utf-8?B?QmVGYjVFTUdvdHEzUUhOQ2lEdmJlT3UrbEZXNTYvM3QzaldCYzVhRDcrREl6?=
 =?utf-8?B?VGM4eUZrNVFIdWhTeDNDa2ZXL1pFbm1Wa0FlZElxVk5mTE5mRkhNdUozK2Vn?=
 =?utf-8?B?MUMzUlNzbCtFeFVQVTZlMmpoakhIT2FUL3B2NWsxdy9NbGFUTk84QW9aemRR?=
 =?utf-8?B?aXN4V09jMVhoakNFcXlhZ3YzNlFKdDh4WHhOWXgwbzJCSHpvZDlJc1dtcEtw?=
 =?utf-8?Q?n7CVHsdHwJQYTod5rw2wOzpm7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55718ade-da2d-45e0-9627-08de065f059e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 11:37:12.2818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4feIThHfMDaa/X/UJMhvlN0mNK5t/qnVCwm5hE8wg0doelT6UTfRW/PCsbUJ7IbRgd9PPUF8/ZIO+p9x8b8ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251008_043727_154682_2424FB7D 
X-CRM114-Status: UNSURE (   9.21  )
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


On 03/10/2025 10:25, Christoph Hellwig wrote:
> On Wed, Sep 24, 2025 at 11:34:02PM +0300, Max Gurtovoy wrote:
>>   #ifdef CONFIG_NVME_TARGET_TCP_TLS
>> -	tls_key = nvme_tls_psk_refresh(NULL, sq->ctrl->hostnqn, sq->ctrl->subsysnqn,
>> +	tls_key = nvme_tls_psk_refresh(NULL, sq->ctrl->hostnqn, sq->ctrl->subsys->subsysnqn,
> Please fix the overly long line here (and in the next line) while touching
> this.

this was already applied to nvme-6.19.

I can send a dedicated patch for the long lines if needed.




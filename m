Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F55C3DA6D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 19:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QdbvUUB4XtZAYzrS8QRjoJBqSM5sQtUNXu7rheBz8no=; b=JKf2wnzHWo59gl+ObIeBEckSv0
	/GrpjkMLIAGqtpS6e30s+KG8CGXA+z2RoYWPqKk6qgnS6Pv5+dpHfs7v1mQNqv2kR6LXdouIwqAja
	l3cuaCNHa2x975pycLKGf+aZFXg+CCn5Zu7LcwILYrZSauYGdT4vGx88wYsbVCpP1C3++auds/LXI
	53qzsII52TWnJH5suTOyCjy1ANZbcHgRnzz6yF0EsmXAZEAasj00wlL/Wm/wSJPOuVRwiL+GDLjrr
	RO1Y1+3c320exx9H5zmzidgOV/rDOLuO8KSp9ptOjo95UyP7O/Xb3LO+VVNLC4G2y+Cm4aFNZC4A0
	M75EcoWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHSmJ-0000000DwyA-24jB;
	Tue, 20 May 2025 19:37:31 +0000
Received: from mail-bn8nam11on20628.outbound.protection.outlook.com ([2a01:111:f403:2414::628] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHSTw-0000000DuZl-3uin
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 19:18:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FnQMP3BNqOQaKrQD4TKk7gSAqHlhBAm4+Nt7npzCld6O7PRx8v2NYSYSmHd4Fnak0mP3hlzeRCjm2yYW+Vm8MiblHhpvEmocq9d1TZvf+plw17rL/BrQJT65iUaIgJ2z2VAOpLJWJr3M1rRc7iXQkn/RQA0JZ2bOcBEkJahG6N8AxZyVeln8vZMA7c8d203cOXQLNVkw4xnx/LXCWAvz4Q7TzqlwF9DItFEKT+o0070EPfbYBhvTwb7ASCQETaZYTEkPysNUZg+4k6KkTRZ6rr0n7nUtpc6GiDz1Ckl35ywobDo2+YeB/Bc4EU4unhq5uJogv1Zu37tfyph/8strgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdbvUUB4XtZAYzrS8QRjoJBqSM5sQtUNXu7rheBz8no=;
 b=B1Tf08NLabyG/0ROwn8UUqnLPvqTnhu2r4RDCN9J0xD6o+mvRyo9QjtkXcoVumbsXpXPkdkVDfub1qkPyZ0h5bKhebwA4c+zjb4Fgx12jeCFkqG7fysyY+ra3GH7b4Bd+PjHVlFl94eOb/4YplgVcnTSzJcwErHprBYle+QgbOGINMfbqOr9IUuqXCBKyPBvA8FoBNPDjodaT1umr6RiDFucU7a7ykopbmub81YrDA158QTn+IsM6HXlI+8po9yMYE24dIJj7opGVKa7WnhtWLK/ANBfdObTAvn6zLnpE2qCFMTN7AV5R+17qJHLjQf1k6Z4Tf7A9nryUSsH2EcuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdbvUUB4XtZAYzrS8QRjoJBqSM5sQtUNXu7rheBz8no=;
 b=gZqCqJ5x9dreuk9NeBv+znHDFlb2U27bUhx6kwRngvSzOot6ycTNa70UeLOFFM0Not6D20jzXfHeZsZxbmgolrxmgohVuv653vyyu7/sVHj8/XSzz60CMdhI8QQzEyg23KmhAy6yU3MSu2XrbI+8ZeakkBbMgJ4BYR3Rx1fmJWNA4RHUndrglSpjGaGcbv94M1CmWkTeFS/SXtgmkYWA1jmQlLEKLLYtIlvO5/IPx4UUq8javCfBcVAz1cajr8Rq1Co2GAfhrncPeBVBazJxzZSeU39b8ttKeE1QqpwbR0ILyNJFPm0pZ7cVntcpqM2xnbK1Il8J6LR7yinxMnU5qg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CY5PR12MB6153.namprd12.prod.outlook.com (2603:10b6:930:27::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.19; Tue, 20 May
 2025 19:18:27 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8699.024; Tue, 20 May 2025
 19:18:27 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>, Hannes
 Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 2/2] nvme/rc, md/001: check that nvme-cli
 supports json output format
Thread-Topic: [PATCH blktests 2/2] nvme/rc, md/001: check that nvme-cli
 supports json output format
Thread-Index: AQHbyU8Sq8ZMW+OxFkKwNrh9aPIYfLPb5U0A
Date: Tue, 20 May 2025 19:18:26 +0000
Message-ID: <fad6288b-c008-4fc6-b973-fcb457b1bc8f@nvidia.com>
References: <20250520061819.1148033-1-shinichiro.kawasaki@wdc.com>
 <20250520061819.1148033-3-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250520061819.1148033-3-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CY5PR12MB6153:EE_
x-ms-office365-filtering-correlation-id: b33bdd28-355e-4afb-675e-08dd97d31902
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?K29jcll5VkZZTDBPQS9QZkYzdytuRDNmTllFMmRndGt0RlZDN3hkMk5rWFEx?=
 =?utf-8?B?U1piSjBLeHFLTVVaOUczdG1qMiszZW12K0tpSjVhRVBPL2c1NkJQNXNUMC9K?=
 =?utf-8?B?NWVTOE5LbUdYanNydVAvd0xVeitGb3NHS1I3ZFZCZWVnd09CSmdtNU93OStr?=
 =?utf-8?B?MHFqUnV3aHhTRkpXTHkvamc2Smhsck80amlXUDMrZEVqdzJOYmxTZ1p5amlk?=
 =?utf-8?B?emx5YVJZSmx0VlVtNjhyTDZ5VW5ESDdWeGhqc0FjYmlTOXpyU2trdlVWSVh1?=
 =?utf-8?B?OUhLcHZ2eTU0WWlLRUZpOEpxb0NVTEN4Z2JQWlROWHZmb2tuMVJKS2N6WS9Y?=
 =?utf-8?B?Y09oSXgzSHJqY2FueStTMVZDYWRCZ3VzMVU1WlZkYmZINUxZSE9zTTQwVCtJ?=
 =?utf-8?B?VGlEVG44TzB3b3daZDBldzhGOEYybjNFWmhxc3U3clhjVnBldUNGS0l3YkFY?=
 =?utf-8?B?WjhyTTk3eEhNV1J5bERXTnp1NEpqTEhiaWtyRGpWMmJhdGhpdHFtVkt2bGJS?=
 =?utf-8?B?dEdkdkJZcWxDUnRTUjdsMnJ4eGRNbWsrdSthQjRLUDdOeGNKQXN4UFNTbWt3?=
 =?utf-8?B?L0NMZUZXaG9iT0tGQWZaemlld29MZEpiRVM0Um1vMFpDVUZ1NXhxUm0yRHJi?=
 =?utf-8?B?SXo1ZVlpNm1Yc0w5bmxCL1hMNy9paG01RkdHc2ZOckR4eC9RR1JwVm5zMm5M?=
 =?utf-8?B?OFM5U2NsRVQveTNWR3AyZjA5MnExaFA1VlVzWERVN3dHSHhvQ1ZrT1RiRnA4?=
 =?utf-8?B?OUU1SXdydjRGVEpLUHlEZURmWmRkV3EzM1pISUx5WEc4ZXE5eVpxRW5uY3lP?=
 =?utf-8?B?c3l6WmZwckxrYnVXdGlMUVFNV2pDcTYyZVNFM1pxYXpXeCtUdFJQR0NaTXVM?=
 =?utf-8?B?SmpuQUJmZkRjS0k1OHhtTXgwSytLcVl2UlVIVTJ2Q285ZThMS2tuOXlwQWl3?=
 =?utf-8?B?MHRleW96RjFwYkExRHFjdUt3dVNXdVlXelB6eDI2ck5uczNmcXRQMjJ0Ym9W?=
 =?utf-8?B?MEZUYjV5TjR3cFNBT1RHYzhRNGJudjR5dTVVTlBEbURwL3ZzbVJNaDA2SDFD?=
 =?utf-8?B?aUtFMVMyamRRQSs0YUJVaWtjZXI5aGxnMGk3TjJrWWNKMk1wUzdWTkgySUw4?=
 =?utf-8?B?eGlGeFB6Vk9aVG9nN043VllsaE1OU1JQODdpL2p2WHgyaHk2am5CNzd5UDRT?=
 =?utf-8?B?ZWhTTDdnd1BGVkJHT3ZCMmRkYWtJaXZHZklmNEptZ0U4UTdWSTQvd0Y3WC84?=
 =?utf-8?B?SnhDSVVSUDB6cEFVUFZMcEIxZzhPYUdpUFpJUUY3TXdNZnhkbE1wYThTaHRO?=
 =?utf-8?B?Y0NPU085VnJjVVRUMEZWV0JuL2lKL0I5Si9LbitrMXlnalpyaVVuZWNGeGUz?=
 =?utf-8?B?L3RlREdVRCtURFpFaW9vakVjanNjbGJFaUk0RHZJZVdKNlZ1NWwzcjBNR3Bo?=
 =?utf-8?B?UWdwaUJycUJXUCtySFdIR3ZnbjRhUC94eFZDNzNrSFc5bE9kd0EzdlhEV0Vw?=
 =?utf-8?B?aW1rVm1LMzdkUkhFaG9wMkVDM1ZuMEFQNXhjTktDNGE5azBGM1NtcE4wakto?=
 =?utf-8?B?SWQxcFBXSDNUMWJuQTZqeUx5K3loY0x1WUxZV0lCRDZ6YWpKYm55UTNjR1Fy?=
 =?utf-8?B?SlBzS0EvRjVwL1hrbHI3UkRkb0htWWs1Skc5a1lsOU9LWHF2UURVWnUxOENM?=
 =?utf-8?B?a2l2YTZwOUV4bzc1S3loSnVYb3NOaXV0VWdmd25iclJqb05zak9IMHhWRjJZ?=
 =?utf-8?B?RGc0RVJUNDBWb25XaTBCOFZrZ3QrTGp1Z2lsQzlqZDh0ZjhCRW9lajFVUTAz?=
 =?utf-8?B?SjJzVFhyem1pYmNZOWpxdGwyUkg5WlJVY0FuaEJoaDd0WXN3L1J5Tmcyakp3?=
 =?utf-8?B?emQ5eC8yTGpBRUYwaDlGMkR1YXp6RVU2VVNHS3psYTc4UGZyZ1lScjMwT01H?=
 =?utf-8?B?MzNEVXF3eDFCWTZIU1JNVGtjMzhVSjVQZnRpWmNrSzA1VEpXVi9yaUJZWFA4?=
 =?utf-8?Q?NtJX3BQ6biA1hCJcCt06lBQHrs0qlA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnlXcjJ5cnlGRzRjU2QwcG5LcmpTVDk5d21Vd2dqVm9MTWZMNmxSM0dJS3dG?=
 =?utf-8?B?V2hOVUZhWXNXVlNyM2tnY0p1QS9IN2x1UE85MExhWUxjcVQvTkFYMWtwVGJC?=
 =?utf-8?B?NkpnVHBLbXRvYmwwQzlFekZGbXcwbEhTT1pWbjFUSWNlOHlCdnM2VTlSVU90?=
 =?utf-8?B?am1nUG1tWW84Q2xmeFJicGc3UzRxZHRrM25RRXlMVVpHWTJZYVJ6NHBzR21h?=
 =?utf-8?B?SVZVMDRJTnlFTGNacWt6ZVJPMWx0VVhka2JCaUM4c0ZFbmhuY3FBOE1FNFpH?=
 =?utf-8?B?ZFZNa0JBZ29XdTBUZE9tUTJ3c1dWU25BVHE3RlJ1blM2cU56ZmVsZkNkNVlz?=
 =?utf-8?B?ejFIOHcva3R6dGlIOWpSK2x6RFFwanVabVVMN2MzZ3pvYURWR00yR215Z0Ni?=
 =?utf-8?B?NTdrcmY5ZUVUZU5vVXk1V0VkV0czM3NZQ0ZTc3lqdVdmcHAyWHNYM0VoYTVj?=
 =?utf-8?B?M1p6MDcvampQcVpKRkFJblV1aldIaGNFNTNCT1FlNkVzUEo1MzBrT3Fob09H?=
 =?utf-8?B?UmZ1MU14cUdVMTMwS1ppcHFvdzdwcnEwZ0wyQ0lVVmFwcTdCSXlyUjRvY09U?=
 =?utf-8?B?a20zekJiZXNTY3pkMUozanJzV2ZMeThjMHNTOVNPd1NUOWJFaCtNSWNWdEtk?=
 =?utf-8?B?YWh3dExlWldWSW1VcG1YSmVtS0JLc3NSdkg2SGI0MEtXQ2l3bDRLUlRzZzVL?=
 =?utf-8?B?b3BiYWlUbnp3bU1GeURVbFM1L3VYVXoyUytlVXdWMC9FaXpVTjU2OXUyUFhZ?=
 =?utf-8?B?Ynp0Y2hzMVhBR0tFVGtteWxCLzNwclJFdFJRMElsa2tEWTlPeHBRQmg5Z0hZ?=
 =?utf-8?B?YTUwZ1k2SXlmWStXTjBpQTYydzFQTTF5aC9jK04rZGxvcDRNUVBuNjUzdlBq?=
 =?utf-8?B?ZE5YbTY5ZDRkS3dNSS9nVWl4OWZaR0dGR0I3M2pZZDNZbUFNejJmWVhYV1Jw?=
 =?utf-8?B?MmU2b3NWdmViMkkxSENZcDUrajhDWFNHU29kdzdTVEV1Mm5rYW5Iek9aVGVw?=
 =?utf-8?B?NmFqTlJSb0ZXcUVVamNROURhVG9rUGQ0YWdlNUtCSjl1ZEpHZFZ2TVpwUmcw?=
 =?utf-8?B?VlhpZUswcW9ObDF4aUZTYzU4UW4wckhERXVreFY2QThUUEVYYkR4RXhWeTNO?=
 =?utf-8?B?UDNvbUJXZWdDQml2M1U3aXpNbVUzWVdmNlozUXJrN09mVnFyVVdhVjJTMTh5?=
 =?utf-8?B?NWREbmt5ZGNTUTUxQjZEaDU1cTRqMGxHQzZSV3EwZEQvaG13K3NrNGhyelVS?=
 =?utf-8?B?eEhweTRCMDhRdjB5dGZmTi9oWEh6ajRPUHJsWGt1VmdhRHpZWjJPanJPV0FC?=
 =?utf-8?B?K0w0Q1NtS292cnRHcFJlNlFqWlU4RzliamFZSWJpb3BmRFh3L1dFVDNTdEhv?=
 =?utf-8?B?em4zMmRGUUpaZUpnVHdiZXNaTGhNM1RFejJROXM5OHRVQ08zYzlHbkNHTVBM?=
 =?utf-8?B?VHMyaTBLanZ6dnA0dlpzd1pHaVMxdGpNeUFPT283Y0wreGxtcHFZeGlEdkd5?=
 =?utf-8?B?aHkyRjdQQXBWdng4TUM2dEJCdHdsTXE5a0ZqNUpteEFmSzZUSlE2WFoweno5?=
 =?utf-8?B?QkNVZ3I0Ujc5dXg2VTBNc216ZHdVS3RWUzEwWmV6RnlVaGlRNzJYVHdzc0Rr?=
 =?utf-8?B?dnN2SmtkRmpqMzZEUTJ0UTZiYnFDUkZRQ3I0MGQyWVl1Q0FDMiszZzd1bk80?=
 =?utf-8?B?YU5JbTAxNUNrakZzYzVLRGV5aFZPOWl1OWJlTE02MjV5b2p1V1ovZU9BQzlV?=
 =?utf-8?B?RmxFcHBWTFVFMGZFRTd2SU1jMUFvei9YWlJUREVlNEJOUjViV2cvR0FLcmdW?=
 =?utf-8?B?M0RvUzVZdVJMMkFKWEI2MkpIWFB4NnhGUjdWb0xqS3hzS2MvMVV4dmtDQWcy?=
 =?utf-8?B?Nm5QR1lpUFp5RUE5ZHBlbTdob1lzZTZSdmw5d1l4TlFFaWlGKzB5NVloOExa?=
 =?utf-8?B?cVM5R0RNUDZLSEttNkxSdjl2YllCbDZORVBVdWdFOGVFKzdkR1REamRPM3VQ?=
 =?utf-8?B?ekkxM1lONEVkSU9FR29uL1licDRqanNDM3ZmSUxSb2pCYlBMRlNnK3FKTEg0?=
 =?utf-8?B?b29JYnBtelpuQzRWamFBR1hJaVFGOE11REVhTXZqR1E3OEIxZ1ZUTDRkbUVt?=
 =?utf-8?B?ZnY2K2huVlBNS3liVTkvYkMvVVBoeDVVakY0czRyM2t4SzVHVkd5ZitZSjNL?=
 =?utf-8?Q?g+EeiBOksja2qmC6nTjEDt5R6iUswTgsjbbUTkILeX1Z?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A891E9DCF74B134DA96E91F8B317013B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b33bdd28-355e-4afb-675e-08dd97d31902
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2025 19:18:26.9842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Yrb9iURCAWG2FOeb35uuT0XwN3410BTlS7GkV90W2eEhs2vA199STv96X4SKoxHIQxAHFYMeO7GK2GlGxKQeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6153
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_121832_983659_8B41C5EA 
X-CRM114-Status: GOOD (  15.23  )
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

T24gNS8xOS8yNSAyMzoxOCwgU2hpbidpY2hpcm8gS2F3YXNha2kgd3JvdGU6DQo+IFdoZW4gbnZt
ZS1jbGkgaXMgYnVpbHQgb24gYSBzeXN0ZW0gd2l0aG91dCB0aGUganNvbi1jIGxpYnJhcnksIHRo
ZSBudm1lDQo+IGNvbW1hbmQgZG9lcyBub3Qgc3VwcG9ydCB0aGUganNvbiBvdXRwdXQgZm9ybWF0
LiBDb25zZXF1ZW50bHksIHRoZQ0KPiAiLW8ganNvbiIgb3B0aW9uLCBvciBpbiB0aGUgbG9uZyBm
b3JtICItLW91dHB1dC1mb3JtYXQ9anNvbiIsIG9mIHRoZQ0KPiBudm1lIGNvbW1hbmQgZmFpbHMu
IEl0IGNhdXNlcyB0aGUgaGVscGVyIGZ1bmN0aW9uIF9udm1lX2Nvbm5lY3Rfc3Vic3lzKCkNCj4g
dG8gYnJlYWsuIFRoaXMgbGVhZHMgdG8gc2lsZW50IGZhaWx1cmVzIGluIG1hbnkgdGVzdCBjYXNl
cyBpbiB0aGUgbnZtZQ0KPiB0ZXN0IGdyb3VwIGFzIHdlbGwgYXMgdGhlIHRlc3QgY2FzZSBtZC8w
MDEuDQo+DQo+IFRvIGluZm9ybSBibGt0ZXN0cyB1c2VycyB0aGlzIHByZXJlcXVpc2l0ZSwgY2Fs
bCB0aGUgaGVscGVyIGZ1bmN0aW9uDQo+IF9oYXZlX252bWVfY2xpX3dpdGhfanNvbl9zdXBwb3J0
KCkuIEFzIHRvIHRoZSBudm1lIHRlc3QgZ3JvdXAsIGRvIHRoZQ0KPiBjaGVjayBpbiBncm91cF9y
ZXF1aXJlcygpIHNvIHRoYXQgdGhlIGNoZWNrIGlzIGRvbmUgb25seSBvbmNlIGZvciBhbGwgb2YN
Cj4gdGhlIHRlc3QgY2FzZXMgaW4gdGhlIGdyb3VwLiBJZiB0aGUgZm9ybWF0IGlzIHVuc3VwcG9y
dGVkLCB0aGUgbnZtZSB0ZXN0DQo+IGdyb3VwIGFuZCB0aGUgdGVzdCBjYXNlIG1kLzAwMSBhcmUg
c2tpcHBlZCwgYW5kIHRoZSByZWFzb24gdG8gc2tpcCBpcw0KPiBwcmludGVkLiBUaGlzIGNoYW5n
ZSBtYWtlcyB0aGUgbnZtZSBjb21tYW5kIGV4aXN0ZW5jZSBjaGVjayBpbg0KPiBfbnZtZV9yZXF1
aXJlcygpIHJlZHVuZGFudCwgdGhlbiByZW1vdmUgaXQuDQo+DQo+IExpbms6aHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtbnZtZS8yMDI1MDUxOTA1NDkwNS5HQTYxNTZAbHN0LmRlLw0KPiBG
aXhlczogNDQ0ZjBkZjlmMGM1ICgibnZtZTogY2hlY2sgZm9yIGNvbnRyb2xsZXIgZGV2aWNlIGlu
IF9udm1lX2Nvbm5lY3Rfc3Vic3lzKCkiKQ0KPiBSZXBvcnRlZC1ieTogQ2hyaXN0b3BoIEhlbGx3
aWc8aGNoQGxzdC5kZT4NCj4gU2lnbmVkLW9mZi1ieTogU2hpbidpY2hpcm8gS2F3YXNha2k8c2hp
bmljaGlyby5rYXdhc2FraUB3ZGMuY29tPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTog
Q2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K


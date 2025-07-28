Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422FCC87FCB
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jul 2025 18:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6FURFyIYOwmkQDwJak+SP9dYwzz6NfInmIzhBaxws24=; b=Rjc2PJoYw6WleUfUu3ayp+aEcM
	d0PExffPyV34N+RxcOOh8T2qHIKmMje5mLnoHT+EKaOA2Zp8kWHh0VKpJmHZK9CF76FBjCw17ksyB
	KnYGt1e3fKPp4dwDM0naOJyfR0L1TYphwnOsckgnusXxU0stIbnfCvvFSN2XmlQFkbTT866HFJUBG
	pEjTo5+FSJTPJOIi61KVst9XnSwFO7E5dAxL+/QKqkjK4Bj41d1BQ80OVhIWCXLD2vMPx0HNOJVTL
	paH5K0pd5ykxQFa0HDraWBunUT032I116qaqK/w1hz+D6TB48RNTlo7xZtPIlQXTiVPeQtCH86K0t
	uIfPfsYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugS90-0000000FAMe-1kXo;
	Mon, 28 Jul 2025 18:00:14 +0000
Received: from mail-dm6nam11on20618.outbound.protection.outlook.com ([2a01:111:f403:2415::618] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugS1U-0000000F8kj-0gJB
	for linux-nvme@lists.infradead.org;
	Mon, 28 Jul 2025 17:52:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SddrMKPmgpQRB9adHWlNEHve4OkixOT4LCAYDMoO6UZkvC2gF/2ulktmSxCgb6hwFtNx7nsngpVatWDwNxwaJdN1nHAlbPD+MeufugjBU3fd/xSK+IlnKrqevYpkGxf0bhvM3odPd0qQdkodi8uPCnhtwWFqhbxNyA4F8EGSj3AN8P7My6AfEAXmkcGE/mtu5FFcXg4xlG8Em075RukXNhJYwqBvxurkt93CyxgD96y8t/uxasKQ1PuzJnZ2wNudtrnWqcI06K/WTqMm/juh5TQFsaPZSO3LeIDkPrNiaGreS69vBOpla38yBaDDO01XzOvR8PX/AKCKJGe15p1vkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FURFyIYOwmkQDwJak+SP9dYwzz6NfInmIzhBaxws24=;
 b=QyQtFYRCFJ3EZ4RIAtFIOgMOSKLz2F45PWmQzoTAHJ1+XZGjyLgagD4QyDhPZaYbXC3ah2TJPDniPOl2Adp3ixmx3nlEisBDfieGK3YK2oWWMJu5iAJQheWnet8x4htbO9cNx0yAPRKEI7/pD6cdAnzUtEqOeI5CfdXJH0Bo/fzARnuseVKiWQLLtDNqpBg/h4dmTaI4nsacFjzjl4lnZ9+mTBdyIOnLbPEN+qyLlYDo5pVKQeUE6H8P59CF+iDJE7WGXf95/uIdYo5se94e+PY7hBnscyid0pBcHp+54ZOAGxWnm/sQIFzgw5ALp2GLjxDGiGavCsWyHJR8NMQ9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FURFyIYOwmkQDwJak+SP9dYwzz6NfInmIzhBaxws24=;
 b=lXzZEt9Z1q1KM4+TIWRDBzrIM5LBJzLUzT9g6lCFEs3+zJlLd0DENk1kGUAL7aHPevnuE4vIIJeyxesKkBh+bP3bdZ2TyrxRDBIaV0Ihwe+OCxQOG+FwFdq9WVz0FKuNCi7ZhslVyrIY3uN60RATX99yYjSwoKIVDsEQeqGkNH5Y51z1KJUzG1x1HQ+GHuAR0Zjh0ezTLBh254IGnFaYMtX7KnZ7k6g5L+2ymTF5biJ4CeykbNcFQoGJX6dy+IfMh6U1tiitWCAbwrtvQ/kjrH3arzPTFMz55hsMlqZOG9GifFehhIfF9eckqK4B4Shy2F68TxR1QgzZB7xiiWQefg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 17:52:23 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 17:52:23 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, "hare@suse.de"
	<hare@suse.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "inux-kernel@vger.kernel.org"
	<inux-kernel@vger.kernel.org>, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] nvme-auth: remove unneeded semicolon
Thread-Topic: [PATCH -next] nvme-auth: remove unneeded semicolon
Thread-Index: AQHb/TnfUDRlJVbJrk+1Z5k7+7Jm67RH1kkA
Date: Mon, 28 Jul 2025 17:52:22 +0000
Message-ID: <001f0c96-9449-4c4f-bd24-926092583eda@nvidia.com>
References: <20250725075722.1974953-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20250725075722.1974953-1-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|CH2PR12MB4296:EE_
x-ms-office365-filtering-correlation-id: adc6ab58-48bd-411d-a510-08ddcdff8185
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?S0QwT2FQOGFYaFlRL3R3Q0JVRFNnQ3FGMWZ4NExRZ1FNK1laa3g4Q2VENER3?=
 =?utf-8?B?a2NVR01DaWhmeHNQc1JndVliYm1MWE1KQnZPTEhLRWtWN21ZYUo1Z0xEYUg3?=
 =?utf-8?B?eVFiYlk0aC80dmlBU2k0T1dMWFdJMEZENm5VSXQ1UHBYY2w3cE5HS2lSNnBT?=
 =?utf-8?B?RTZUZWZTSmxPVXlTYXB3UXZZTlZxTFFuQ28wRCs0MFhHMWJ6dWZyQ2hmRmxH?=
 =?utf-8?B?RVA3dmdlUWNUU0pJRDJWcnoxTWhhdkovZTlTUHdiSUVsMXlZWHZ4MUxSNEZv?=
 =?utf-8?B?ZTRFUFNpMjQxY3F4MkFSeE8zWC9qMmR5MGUyRzgwbWtxWGJLMk81WG1qMmo4?=
 =?utf-8?B?cmVHUFpWTHJMRTQ1YnQ1ZThYS3BwR2tkRXFRVTI3a2dvR09qY1lwRENWQ3RP?=
 =?utf-8?B?bE8rTW1GSlliZVNiNWwyQ0dabDhscm9PRllseW9OTXhHdnZnOUdWWlEvdmor?=
 =?utf-8?B?ZWpKNDRyZmhtWGFjdGNBZUhBNHJtcVMweC9xSHhmZ2VNYU1ZdUd4bWRCc0gz?=
 =?utf-8?B?aXR2OW1neVRvdnZyOUNhZHFvT2pMUlFlQ1dkeE1nRXZOQTAwQjJ4V0F4RXVs?=
 =?utf-8?B?dmFaTEQzdFFiYWNpd3pkR2x0WThQWitxdXpVOUFPNUdjVHJhdVJiZXZXLzV2?=
 =?utf-8?B?bGtqd2tMZ3JSbVpOdnZvSGdBRWwzMHh1VCtOK2sxd05EaVRrOEhtZ005TkVQ?=
 =?utf-8?B?MTJDOE1nR3JrS2xxQlBkUExYUmdGUTVJTFdSTTNjVDNWa2N3cFVHSnQ4dC9v?=
 =?utf-8?B?NEJkNGNyS2dFNTVUcXVrN09nQVNuK3duakl2L002L1lqQ2hwR25ZWFZBckFo?=
 =?utf-8?B?V1Y3cmQvSTJkbllCYzFMemtUM3NhTXhJdXFqdnJXY294SlAwQkJrL3prTUVR?=
 =?utf-8?B?QkhFYnRRNDM1REp4TlhMUWVwNytoMzgrTURCWEdvN2FDc050MXBjeHU2dXc2?=
 =?utf-8?B?bVVrWW12S3dHUzc3YTk4dllwSDN5SDNNbWVMRmNwWksxSEtXbjVHUXZqdnhM?=
 =?utf-8?B?blluaWNSQzNXOWVQaE0rZXlKYy9OSE9VWFREejlQbnJFcWJxbzlDRmVVdGly?=
 =?utf-8?B?bmlSNHl4Z0tFeDl0VWJ5dllMVWlZd0FOR0pqOUhna2hQVXlGMUNIMjJqNVc1?=
 =?utf-8?B?YnZHNXY0N1I2dHhpeFZvKzZRUDkySnZsNUw1MExTM1VyZHJiM21hUFRVY0Nn?=
 =?utf-8?B?RGdRRzd4L3J4ZEduRHpwTkxIcXpLL3NveTVURkJEV0Vra0dpYy93UmQzR3pY?=
 =?utf-8?B?NGFZN05wT2EybUVjMFZIWDRiNmlrNE1rajZQOVRXUXZpODJoNUZqRXRNeUgz?=
 =?utf-8?B?UERqNW1ZUDRxS3ROcW1wNER0QVhZbmFhN1dCckJocXdCeUhFaGIwOVhiMm40?=
 =?utf-8?B?QTJiL3gxRmptSnB5VHVWaFFLYTdPY2tCUnJQcXFCd2o1VWlTSnhtRTBUaWFn?=
 =?utf-8?B?Q0xhMnR1M05WekFlcnUzZnB1Rnl4dFRiR01tY1gvNFVKUHpFSWZNbTZjeWJq?=
 =?utf-8?B?K0lXQWI4aVZQUE1tWnhPSzE4NVVwK2orZGNvaGtJeEFadm9FNmpJYTc2OTA5?=
 =?utf-8?B?b2FtRG5oajZjMHQ0L2RhUkVWZlFNZnNLQS93eEUxY3JEOVNmdlluSlV6bzVG?=
 =?utf-8?B?aXh2ek9HOFdnNGYxR2JnVis2ZjJmQWFnQWZJeStsQS9sT2g0ZUZOblBjeTFs?=
 =?utf-8?B?RVRiTTBxQy9oVHlBWitWaEZaT1ArL2NZcnpMYzFEL1ZpWTBic3orTTdTeG53?=
 =?utf-8?B?alNQZVQ2MUpWTWpmbFlpT0dJWGRuR3orRms4S2dYMWEzTGJOLzArNklIRFV0?=
 =?utf-8?B?QWtYZ29oTGt4ZHYxK0RkK1ZQQ0ZTbUtxTjdQbmNaQ1Ewa21WMjZ4THBhQk10?=
 =?utf-8?B?MFNqaUFhbHBVN3oveGtXRmNMS2FjNStOL1pQeFBVbVdYNjFQVjBzSkdNMWNk?=
 =?utf-8?B?Z2lsTUZEQXhJMnZ4Wnc4WTFQWGY0RXNWTmpIV0RGTUVZcml2ZE9RWHp3WWha?=
 =?utf-8?Q?ZgdQSCS5ozAGBhDHis33fupFzjqTMA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zjc1aVFoQjV3Y0k3Sm9iNnhyWlNRRko1NnJvTUZLTW5sRzJsb2lFY29PblNk?=
 =?utf-8?B?TE1SWVV2dy9SM2lXeE1PazRuN3pjem5iN1JYcEtCdTlXS0lDNEF3V1l5MWNI?=
 =?utf-8?B?MnBZWUkwMUN6bDdTcnRLUDNJOUcxV09hN3NFZXhLb255M2RCeHoyL05rcHRl?=
 =?utf-8?B?RnZJZ2o3cnEwTmhqZVdlbW45YmVhVCtGdUZVNjVpUnJoT1Y3dkFEbmVMcmFj?=
 =?utf-8?B?TEttUGFHVStEUUY0MnYwMU9oeHVpM2NJaWVLYXdmSC9nNDBETTVLWGFwbHZW?=
 =?utf-8?B?dng5MWNMRUdHTlpCMkhSaEtrdklLdVRPYzNOMW5rZHA2aTlSTSttRjB3WlNH?=
 =?utf-8?B?TkxtaFZCQ0JlcDlUVGNucWRhMngyNi90U1k3MFdHUGM1QnVOR2l1anp6akcz?=
 =?utf-8?B?ajg4ZGh3MVE4dlNoczRXYkNQekI1RUxyd0lDMFF3Y0NNZ0hEbC9ZMFFwUk00?=
 =?utf-8?B?dnV1S1F4U1lhMmZsWjU5KzN1cVNPYm9JWDV0NHBBRGRNVEp3Y3pQaVJabzM1?=
 =?utf-8?B?dUZOaUE3c0VxSlFqcFZ2NFRRTzN5WFVxYmxoT00xbXJheFRIKzBFaWErcXVI?=
 =?utf-8?B?MUhxV0M0K1gwcy9FOVZ1NG4yVUhZYnJuNDgxZE9DNi9LVFZEU3JPZUlnTDJ2?=
 =?utf-8?B?QjFldlZXY29GM1Q0VFNkTXVCbkJmc2l1MExuakJqSXpKS0lxRTRScFJrbkVr?=
 =?utf-8?B?OFdCemJCZ0ZYS3JmM0xqVW9LYng3YTB2Z3ZTT29FR2VkajFzVXM0SWw4WTRK?=
 =?utf-8?B?STFCc0MzaFoyejlXc05ObDAzVm00dkJkWVU3YW1BbXFkVkRDRy9WY1lyTDFF?=
 =?utf-8?B?QjJjZFQyUnFjc291Y3ZJLzgyaHpUWUU2ZzhPUkFjNkxRNjJER205aVRKa1Zt?=
 =?utf-8?B?Ni9lc0pydG10N24xVlNZUkg0Ujd2aTdyVkhXbm5Vb1JiVktwK0JIakxwTHI0?=
 =?utf-8?B?QmhLVnM3TWEyZTFXRjZwT0JhRGhvaFZscml0OEx6WlZGTjR0Vi9CYmNyOWtT?=
 =?utf-8?B?UE12U2ZUNE5iZFdhSHIwa0NlTUllamZhbmVwKys2ZEJ0aWZYTnRZWUc0RWhG?=
 =?utf-8?B?aVpSdXVZZVFuN1o4eTdWaVJiRzlra3d1TVdXUFI5ZzRIMjVBTzQxNnAxdHdJ?=
 =?utf-8?B?OGJqTTJMSEdxWEpiRlBXWjNyK1ErMmlWdVluSE5udFg5dWh2ckhUZFpVZXNq?=
 =?utf-8?B?OXZ2VTdyeHRSNWFJSlhPY09JdXRtTmhvbkdVSXdvVmcwRUJZMVVrdmhxa1p2?=
 =?utf-8?B?eHJRZEFRelNKaDd3VmMrZFovdEx3QXR0R2YzS05acWNoUXFBQ3U2dVFQTHp0?=
 =?utf-8?B?L3dROThiTlpOQmRzWXlNV1RuVk1TOUlTSFR2c2ZhSFoxcTU1REU1d0p1YkxB?=
 =?utf-8?B?N2ZwMlFkMWkvSEdxU2xzTktDOFltSnNkanBaQmFrMTYrdUxQMGRxUU1kbnAw?=
 =?utf-8?B?UndkQTFDQTJ0Vkg3SDY0K3E2TDFGMENGQWZXdGhjN0o5dFc2bklLSE9CbGlJ?=
 =?utf-8?B?eXc2NjA4cTcwMFNEZ3JkbVpNYUJNMW1pcTRzZDRCRGw1dGI1a2s3YlhoaXhz?=
 =?utf-8?B?Ykd5UElvd0hMZ25wdkx1TCtubmhBN0lqclIwd3lDSW1YUzhCL3VlMzBocldE?=
 =?utf-8?B?RE1lUDg3TzJhUzE0bk1XN295R3h2ZGRsb2ppMDB0b3hGMFZLaDRSaTEydEZk?=
 =?utf-8?B?WnpjRm9sOFZSYzdwTThDVFN4YnhBOU5QR2FiUmt4T3hXYmdHQUwwcmNOZ2RE?=
 =?utf-8?B?cGFSMTBaQ3VlZEJJQnplSkVJK00vbVFJZFdLSmVZYmxwVGxocWY5aTdqbDN6?=
 =?utf-8?B?UE5BWXUzeXpHT2Z0SUNzR3NHSktXRFZtc1EyeW4ySlZJVGEzWlhQWVU3ZzIr?=
 =?utf-8?B?SEZGRnlsT1ZNWklXdjVzNjcxUVZFNUlJcmNoZkZPdkw3dGwwckpQSm1vV3Zr?=
 =?utf-8?B?NklnQ2JQcXBwZkJ1TWxGTVpyQm9DZG5uQUM0YkR6ZTRoTmM4M3hOT2kzQmRk?=
 =?utf-8?B?cTBXWXJJZ3ljMVBGZEJLRXZvcldlZ2pKZzgvY0FFV1lPMkh0Ny83dTNmUGF2?=
 =?utf-8?B?bW4wUC9EYlNtRWpsUUNwd0R3UlZ2bGl0WENKcnhLM2g1ZUxlaUxQTGNDdnBy?=
 =?utf-8?Q?v2TZe+LH270Raps92s8uWbyaa?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <034929B84B069B478A8281932DF6E9A1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc6ab58-48bd-411d-a510-08ddcdff8185
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 17:52:22.9486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pO61JT0B947gOPtpBflFORPPD7dIqIHbOZLK7eRyrcSRMEBm5S/CiJivQYmWOxBCYkCaYSgitoDJJU0nxozOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250728_105228_201403_272F735C 
X-CRM114-Status: UNSURE (   5.76  )
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

T24gNy8yNS8yNSAwMDo1NywgSmlhcGVuZyBDaG9uZyB3cm90ZToNCj4gTm8gZnVuY3Rpb25hbCBt
b2RpZmljYXRpb24gaW52b2x2ZWQuDQo+DQo+IC4vZHJpdmVycy9udm1lL2hvc3QvYXV0aC5jOjc0
NToyLTM6IFVubmVlZGVkIHNlbWljb2xvbi4NCj4gLi9kcml2ZXJzL252bWUvaG9zdC9hdXRoLmM6
NzU1OjItMzogVW5uZWVkZWQgc2VtaWNvbG9uLg0KPg0KPiBSZXBvcnRlZC1ieTogQWJhY2kgUm9i
b3Q8YWJhY2lAbGludXguYWxpYmFiYS5jb20+DQo+IENsb3NlczpodHRwczovL2J1Z3ppbGxhLm9w
ZW5hbm9saXMuY24vc2hvd19idWcuY2dpP2lkPTIyOTM3DQo+IFNpZ25lZC1vZmYtYnk6IEppYXBl
bmcgQ2hvbmc8amlhcGVuZy5jaG9uZ0BsaW51eC5hbGliYWJhLmNvbT4NCg0KTG9va3MgZ29vZC4N
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQoNCg==


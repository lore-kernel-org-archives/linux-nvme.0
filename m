Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56048D3E788
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uwPNH59XeR5VyTHdYGAouRN4FrsA3zmcxOe0TyX7A7M=; b=JgIf8txdiSP3Jh+NPY86/c06f3
	u4CvlPmcen+WlnXeIPISIsc+xLh31wFbwnm6ONpCs9lFrk3cISlbKH0oTrDJNEagl5ZuJvQkaZoUH
	G2++Dtkho4OEc0ILD0vIrsn9dYU/apuZzfqxL35wwLtdVVJeZkVkTCyzGrt2gQYgHOddR7b8gvHmh
	XK9AdjQrag3OFe34Kb5DHQDzQzrU/Cn4iOUxeoK2kSuuqNfLz272fpL0YLgUh5RdZhSxksBitC2wY
	jWOGLlvIEgxDh4YXaMNXOKWWhJzUlkkEK1isvTqD7rn7QGtP98HvlV6D/MqrT496vnR5jTEleGUk3
	+/i6ARHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YF9-00000001pAB-2EVk;
	Wed, 06 Nov 2024 05:06:11 +0000
Received: from mail-dm6nam11on20628.outbound.protection.outlook.com ([2a01:111:f403:2415::628] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YF7-00000001p9E-0mOS
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:06:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdIBTTF/3nM9wAIoXrH8rAmrFCTx2bvbnyY0PxOss5iH+J8V9tsdcn/Awd7E6u4IMScv0Rcjtj1m6wBUFqpTPnRfbGilcBBGuhu6+RVzXA7bMUuvjDg9JgqkACMkjmJQ4m/Ta3HKUOPhVl9dm3KlT+jIN9JGmfb9zbxoHk82bHdnEQ6XJNEgAYwZq8KzZ7OGH6cmuVOOPMnF9RHsi7N9Le0btVeBesMTbDXXsn0XRbtlJJT0YJ0SdewXOcSiqcVEFpygbabYbOqXVuYSeurx35v1a16fbEQi7XHGThNehXiZt9MNQ7JEBj534eb05hY47e9+Q5/dVEWQMN4ZMx9Dig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uwPNH59XeR5VyTHdYGAouRN4FrsA3zmcxOe0TyX7A7M=;
 b=GHrECWrwdWUGC6OZnTktv0P3aR6TDSiT5wgRSwGwvxlkhFg8vL8ZJHxveNnTcL43GGgUGHS+8PW9bSOzzl2pdIUwzKwx3Px4gq0I1KPQxR5wQDU8qGGpD6C55KQGpWj7RTE0iMIftEfSL9NrIkkkfd0yksXnLVdphbPCoa3Pe149Jnf3fzNkJa7/YFsm2D37PDIdrnn2T2GeTw/96gGQ8zomxkMxh9Hx4Ny2iaIKd4qeXomL3S/bw0yedYo6LvisVDnxC8vf9o0SeTjwMCit/9Nd3jevcMclUr3qSS1Ax2PfICSa7GC0dSTDAx7/oRqBWZdB9Zi1L/2cR4hhzT6LXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uwPNH59XeR5VyTHdYGAouRN4FrsA3zmcxOe0TyX7A7M=;
 b=VhjoSNdF8sHOiViKOQnKUqwGyPnNPtYAH7Nr/dE3PbWJBfUSoOcIE4r/jnB6sORCK9ZvFgtPaPPkufFab2r1+xRGpsBpZdmua4Nz83hVyMRyfDWWeahKeT7a+/DtavZCEbauqUIJy98k0R+UYoZUiNe65Neym6TzCm4r7UA1JJv3EKWN76sc1BsRc025YFJlgjt2iALK4+6x2OxKr67zTE3/utYAX+ftirddhLrAxu0c8ivU6XW0zl56t2hyWB+E9LbXT4RuBtSyIkwsUYQP45wh/krbjlh/QbW4sVvgK9Bcp+LmHHP42C1K56kY8c/kg1qN1tcqjU/JMXgbZzOLlg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Wed, 6 Nov
 2024 05:06:03 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 05:06:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "m@bjorling.me" <m@bjorling.me>,
	"matias.bjorling@wdc.com" <matias.bjorling@wdc.com>, Keith Busch
	<kbusch@kernel.org>
Subject: Re: [PATCHv3 02/11] nvmet: implement active command set ns list
Thread-Topic: [PATCHv3 02/11] nvmet: implement active command set ns list
Thread-Index: AQHbL6sasb5iNzfpfk22Hi0/lwpC6rKps9GA
Date: Wed, 6 Nov 2024 05:06:03 +0000
Message-ID: <17dc590e-9dc0-4a9a-8f08-0dfc7c8f2566@nvidia.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
 <20241105174904.3612888-3-kbusch@meta.com>
In-Reply-To: <20241105174904.3612888-3-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH8PR12MB7304:EE_
x-ms-office365-filtering-correlation-id: e1c8e758-2d9b-4c2c-f019-08dcfe20b66d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dyszbXk5MEhRYlNLdFIwTmcxT2tVU1F2c0lNblFBbFFvNjhBcUhtMFpITTZU?=
 =?utf-8?B?bWVodjVWdVY4ZFFVYkgrNlF2bi83UzBvOCtKaHZ3VFo0aTVXVnRwVGlJeEhw?=
 =?utf-8?B?UW96Nk1URjRjVU1PZURkaWQ0MGZRRWNTQUZFeTY2MW5IZ0djNElIQ2FjR05P?=
 =?utf-8?B?K1hBNHo1T1Rzd0swUkZQaHZLSFpkNmdQazlhOGdSbGlFL21JS2ExRS9ncEc5?=
 =?utf-8?B?STVNVEpkZHRaaGxQa2lPUkNVdktTRFhPNTJ4UStPRW5TTG15bDJkenNWcll1?=
 =?utf-8?B?YUtrKzJYbUJGcGlLc2NhU2lmdFJnRm9aWmI4UjZIcHFWcFhkRks3VlZBbFg3?=
 =?utf-8?B?OFM3NVh5S2tPenAxa1pPS213aDM3eFBHYU1rbFMxd3BLSnd1QnZ3UFhkV0hl?=
 =?utf-8?B?bi9zL2JSaW9lc3N0U1p6MExoaW9GbkRKWlFjRlFpTDNRcUViRm1OTk5STjhq?=
 =?utf-8?B?LzhLYVBCWU5HVndwV1JING1JUXlwbG5mL3Y5MmZRazlMb1E3YkRqUUFQUU5C?=
 =?utf-8?B?ZnNJQU9nYVh5SkNLM3pENm5UMjFneldzMnZaeHY1b1p2M0Z1UndEVnUwVFla?=
 =?utf-8?B?WEtKQ3ZTQVpldHlmNzlubk1peUcrcGlTVmcwM1g5cTNXbEYyV3kwV2JJTGpo?=
 =?utf-8?B?eXVYT3Bxc3JyM005bDM4TDdTYzJxRTA3cDhoWjArNndCeGVhM2xvQmZTWWQv?=
 =?utf-8?B?Nm0zS1EzeGEzcUhtNkVYSmhIUlFUZjdwNGhxeG9USVV2TytLTlpxRm5NTFZO?=
 =?utf-8?B?YUlpWWFJWDZSSXZ6UjJUV09MM2s3WXd3aVcxd1hzRkV0aEljaURkSW8wN2hS?=
 =?utf-8?B?SXkzRmNNSWFLdWxhVFpIdHF3Vmg1Mm93VW52SGNTcm9tWTN0anRrZ0QvS3RD?=
 =?utf-8?B?OTh1bWQ0TnNrNDluSm9uNnF6b1RvM0FQR0dLd3RBTXBsdVBPcWsrNno5UWU0?=
 =?utf-8?B?QUgyZkwwWEVPNW8zc3k4QnNaT09nWXNNcThwOFQ3dlhqa1lJaHk2bmhZK1VD?=
 =?utf-8?B?dHYzWFhiakxTVnhXOEt6WWY4ZzV5dEt3UytRZnpWcFVSMittT2o2M05tZmpJ?=
 =?utf-8?B?RnlKSzc4V3ZHM25FK05ORzJZTElhV2pqWE9VNTRNZkQxdXA0KzU5Qmw1bm50?=
 =?utf-8?B?RGdJbTFhRjhwZkhjYlpiaHZkTDhlcGN6ZnRHK3MzUUVDR3lIdWJWdXZ0Qytm?=
 =?utf-8?B?bTRCTmN6Q1VjMnhOempDL2Z1UWhTNEFEcWU4ZnpueDg4OFJPQThLcTNNLzRM?=
 =?utf-8?B?aFo4VktGUWdQNnJlT3U1QWdETVRVUTRoVlcreitjN2xIWjNmbG1iYVJRa1BX?=
 =?utf-8?B?Vzl1d2cxcW42bXMwZEdkeDY3WUxYREF1bXdNVEpvQW1WTFJOYUNxVGlpdHcw?=
 =?utf-8?B?VmFRaFdSUDJGRFNyZlRnbUF4SkZSNWdXSy9IZlZaRFZBNGZIZ052RE1lelJx?=
 =?utf-8?B?UEFDc1ZPd3prb3Z6UmI5Y0FzNStaY0w2MXZEYmlROElzRndsSk5lcGd4cUVp?=
 =?utf-8?B?NjhJaHAzS3U1UEVDRkN2Q3JDR1d2dUdCckMzK1BmUnoyK29wYkNnVi8rcUND?=
 =?utf-8?B?L0k0ZDJHd3NWcGoxQ1A3NlNKajlrSlRwYVdYNzlGVDJnSnZlMDBZdE5rWGgv?=
 =?utf-8?B?djdSclMzNzFjN296UWxmL0NyRkhCWHd2WEw2cHpYM2diWlM3VHp3RjlQaThX?=
 =?utf-8?B?U1JDbGtEOGxTRStLZjVPTUQvT1QwK3p4dW5yOUhydjNUbHZwR3g1dlhHZnFC?=
 =?utf-8?B?MmhmUHQrV2Zjd1c5TFJoVS9kR3RDZ2tKTmN1TGpldThiWUl1NytMUHZEblJH?=
 =?utf-8?Q?l+EPhzn06vqE7fPb/NkGKXhx6jWlBqsa+LQ58=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VHhxTVVSKy8wRXUvbUNZNDlSQXVyK1hnaXV2VVkvTytna2RCYXNuUmx3U1F0?=
 =?utf-8?B?NmhZYVQvUUVmOGE0djZIL0JyUWNkaWQyV1JmaVJpYVRGeUNGWC85RktXaFM2?=
 =?utf-8?B?TUdqNHY5Q0lHWUFyZHFKaWVvQ280TVY3VkZQY3hBRThDZlBjdnBNckZwRlNB?=
 =?utf-8?B?TzNYWVVtcWFFOG9PaFBLVzExdzFlM0IxSHFpaVZHMFRERlJzd0NDR1pud0Rw?=
 =?utf-8?B?Q0cwdUdXZmdxNG52WDUraXZpZi9NSGtsRmlaN29YeGFIbmtXdU55cWFQcjhm?=
 =?utf-8?B?QnlnRHRad3F5Uys3eEVEeHpCSDQ4V2FWN0YrM2NTcUxtcEZyUnIzZjZOWkFB?=
 =?utf-8?B?OS9sVFIwK0dpb2ljZmJUc1lEblJCcUNEQm1kc3plSXhZU1g3OTAvYU8zOHRh?=
 =?utf-8?B?Tnh6N0ZQOWl3Z1J1bzFzclRnOGxXa29hd2ZZWHc1Wm5jU2VpdndSZzM4OElv?=
 =?utf-8?B?M2dLVUFFVncvMkNVaW9RbFhnSVZQTWR2TVRibVdPRlNoZVEyUGRuM3FaMFZL?=
 =?utf-8?B?MDcrOUljR2MzSnBiYldzekFjQW5vWTNlZDZiMGNrNEJzVU5EcWM5bS9BR2FZ?=
 =?utf-8?B?KzVSZHh6UE5CcjhJS0Q5UzJaalIrMkhMWUVtSVhxaTJYcWF5TG9QdXFTYnBD?=
 =?utf-8?B?VHJTeDRLUnZBdWFET3QzYyt5R0tER2oyRTNQRFZ6UUkrdHYyRituOEswcFpn?=
 =?utf-8?B?RmxaelVsUER6Yks4VW83WTJFd1ViRUczMGxCR25YQlZiZWlPR1J0RHRGUnhk?=
 =?utf-8?B?MC93N0xCMFl1aUYrVk1FOVRKbDU1cW5uNVh0dXNuMGNMaTNOVGxXdkJDR1J5?=
 =?utf-8?B?ZEtkUkxGS3k2OFlUUHRzMm1VckpJL0c1UGxTSDNSN0RUNXFURlp5Umd5RWN5?=
 =?utf-8?B?NnNXMmdiRFM3cnFCbWpCd0paWEtTYVYvbUcwQkczb0xKN1BaYTRFUEJBbTFL?=
 =?utf-8?B?bGNkZ2lHYUNEMmh3NG9BZEd6QXh2S2ZtdWdyaXJWZTRETUJwbHhnUFFDOEZT?=
 =?utf-8?B?UjJtUDVmeTNRVXZIT0pCT3lpbkhVWTZqSnRHKzduT3YrVVkxSUxpa0UvSlNE?=
 =?utf-8?B?ZlV3QmNuZVRhYWEveUc5YzJrZmdVK3lrN3NGR2xpTjUvbFpkVnhneGJQMTRH?=
 =?utf-8?B?SEdGcWNtbVdyZ1MzV2dtVVV6Mnl6THUyb3VLZWlpYVZwVEN5cWVOaFgyeEhk?=
 =?utf-8?B?STRFT2xpT0Ztd2ZzMjdHd0Nsa2lFbGcwelZaYUFTbTdlbGg2WjIvUGloVlZT?=
 =?utf-8?B?RFk2MDcvTkJ5OGl0ZGJTNjUzY2FCMWxBN3VaTEtjQnUzNFpsOGw0TGRTTXVi?=
 =?utf-8?B?Z2p0aFFVWi9GdjEreU4zOU9FWWZWbXVuUzdIb1N6V2hOeWN5cDU0R25VK01k?=
 =?utf-8?B?cVZKUkMwOGdjd0xrMUZlcGdLbDRtcTMySHdOQnBibDR4VFZUYVJQRmxhME9X?=
 =?utf-8?B?eGRaTGhiSWJMdzVUMjErZjZ0L1JDZmRZSVovSDZyUzRud2c5OGJ1NnIvM0Z4?=
 =?utf-8?B?ZHowWXAvbjNCekVBbEpKUWtRV3Bkc25RbHRLVU03ZEk0ZGszUW45Vm1FZ3BQ?=
 =?utf-8?B?RklkZnZ1RlN5Mk9BOTJ2L294UVB4YUk3VlpvYjVtdkdGWW9UcitvRTBpNzZy?=
 =?utf-8?B?SURvOUtOMEdzYzZQbm5pYi8xRnhYZDJ0UllZc2xNTFROamJ1SUIxb3pJNHM5?=
 =?utf-8?B?SVVJMUVYY2lTQXhuY0JmQjNKMWc1QWNOVjFXZk5iSWpSMVdHRGVjTEIxUTJh?=
 =?utf-8?B?QU8yZU9HbmpKWmtGdGIrODUyanNhekZKbUwyM2RHNlBUQWRBc1gwdmZKSmN2?=
 =?utf-8?B?V09MSE9JNHpZNWNzU2pkTS9rRDBHTHc1VURWMmt4T0ZaOHhVWGl4dkVzRXRL?=
 =?utf-8?B?TmM5N1Q0anBHa0U0eUpLOHRCSGdUd3ZPYmg0OU9ZdU9kQy8yN2cyVGJVbTZ4?=
 =?utf-8?B?RUpjOC9VSFpJVFNuRlBDaVRNQ3JFcWlzU2NzSDh6bDRudGYycmovdXhkbXow?=
 =?utf-8?B?SzRoUEVZbkEzVlpEQldXZGhDWjRVelhDYTlnWkZLQzA1UWVxc0dCZGR0Ulk2?=
 =?utf-8?B?eFZGdVp3cDQxZm1VdTRXVW1FWmVMUGRSUDUxbXlxQytiaWIzc0IvZTlET0xM?=
 =?utf-8?B?Z2dpTmR4K0hxWmR5djBScUtKWGlMQ0labDBFcXZKTHU1Q0tKd2ZESmZqSzN6?=
 =?utf-8?Q?6p27MlTu1Viii1PpLVIrf5/oJoOgRH0ZMJTo4ZnNc+6S?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4439A24B9BFD564895CCA8F6EC6EFC7A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c8e758-2d9b-4c2c-f019-08dcfe20b66d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2024 05:06:03.2692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: STZJje+oYqhFc3D9FJRvPxpy+alfZm//g5x5AiMxwMqpBvPJ4/D+odI0Pz+E3SPTVmLQBpfd34mKFR/cWnCETQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_210609_345114_7FC7382F 
X-CRM114-Status: UNSURE (   8.51  )
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

T24gMTEvNS8yNCAwOTo0OCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPiANCj4gVGhpcyBpcyByZXF1aXJlZCBmb3IgbnZtZSAyLjEg
Zm9yIHRhcmdldHMgdGhhdCBzdXBwb3J0IG11bHRpcGxlIGNvbW1hbmQNCj4gc2V0cy4gV2Ugc3Vw
cG9ydCBOVk0gYW5kIFpOUywgc28gYXJlIHJlcXVpcmVkIHRvIHN1cHBvcnQgdGhpcw0KPiBpZGVu
dGlmaWNhdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtlaXRoIEJ1c2NoPGtidXNjaEBrZXJu
ZWwub3JnPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5p
IDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K


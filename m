Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C453C71136
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Jun 2025 04:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hzqhLPRNYFHAsRBy4NSfWcNjeyHtdIE7/Ld5MVVFcoI=; b=2qRGks8AHwnhQSLo/GfUcscatN
	4nElPE6mqQlTR+TLwg+VZDHomQBu9ChWrVrQs2xBrPecdZaEZwPh0lRapHoVbP9Wr+7+mLZO1Ay/U
	FVVoXI2yChEtnVK5TnOeBhoLPzDV1uBt4RyPRMRabvHyWnIeF1B43ZgZ65R5Y+BTLjGXm+DVdHJsK
	kVn1K+WrqxS2qcIUb3gg6ftQCWGqlRjKF/k3sUwKos0j4qZdf09J6x3Xo+wQ6mf0EwDxVr0RyJN9k
	k8hG6WV4QTY0zooban1oAxhgv4KV8oYtDybUasDqNyt/G/DZkACoI9myDiVIuyOb/nPR/JK2QwNDr
	PRl8OISw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR1So-00000003LUw-36Oc;
	Mon, 16 Jun 2025 04:28:54 +0000
Received: from mail-sn1nam02on20622.outbound.protection.outlook.com ([2a01:111:f403:2406::622] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uR1Sl-00000003LU1-3tgY
	for linux-nvme@lists.infradead.org;
	Mon, 16 Jun 2025 04:28:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr8oT/ziRsEWvQF5bKGpDIhtCoB926+Km5LZ9oLhIuVd66aAoycr1Z2d5T6wfAQNR28rW7OkD0Yn5zqlP765mfOnO74AWJ4ZZ/Z1mx35yW9NqcqP8EJG8logvkflesVZaQSAWx9bfUybxvPGayc0gF1viRF/WQqCLqFnQLnynN/viUT2F85F6O/T5EfhgO4a3lY+OpqYU3kRP66c2IJFhvVJqlXdrbrGOc2aPGWWSERgf8EJWDUcBb90KnKI2Wt64K4UKZ9I28ZimmxfH8g7NnS6NbjHZ1OQZfiI12QZstpvYECs7UfARKmB0YO97ICTe9wTxhgDGbuc3kewskvytg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hzqhLPRNYFHAsRBy4NSfWcNjeyHtdIE7/Ld5MVVFcoI=;
 b=AeygMJPXkpAWL/dJ7OQDqtTu/gmHr4PLn90NJb9z4JKiwNhfeIH4FJd3yfg7hnkfFdcb7W2Oi74oliByHHKYuZdrlW7bpZm+rOJac4S1rg5l4iQqWC+Ks2muUTDvDM1xziGhkMlt694EQwiuOQBsQyUoVb72m2igV6WVA3nYWFshNxe0qhc8ver9QrI/Sn6Jf76YvSSG4+XKo2XqyZIFulwUFJWVKDtIpzcrKabjjX2/Dnr4aowCIONWJTP34zgPzFMq9SpoG4QzjF3Be505ArkxTg+x8Y6jDy2vjLkPIe8Uo6PQ+4N57kLCnlDftXX4/d0Li/frlzXzFGdw6xMN9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hzqhLPRNYFHAsRBy4NSfWcNjeyHtdIE7/Ld5MVVFcoI=;
 b=KQG7RSTXmpfN7llo75JHUGIoIt4iA4K4gMfCWiMu2FC0sVze64jJAvYsU6xuDGYO8MIqMS8UMEJESsl0ks25te4TfLsbnIlg39VAl9WWsyObbtIReY8TTcrtJAMV+CMF/iTNWxeTMExxqQkryVmUNUo080dOgmOtBZuEEsHw6N1Ih5RfCynTxWcnApmlp/KZo2XGSGQGJJJ/+SS1OZ0Ev+cCez/8ImEUq5cZnanMet6VcV3R91Z/R+RhZ4IeklEx9hdgA0fKZFeIC8GWjkCHVz85ysIij4Kh1cxjmea0vPTDcAvmJh/NsidFs77tH0SI61prDZubVo/JXeQpvDquew==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB5594.namprd12.prod.outlook.com (2603:10b6:510:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Mon, 16 Jun
 2025 04:28:47 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 04:28:47 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "gjoyce@ibm.com" <gjoyce@ibm.com>
Subject: Re: [PATCH] nvmetcli: add support for NVMe passthru target
Thread-Topic: [PATCH] nvmetcli: add support for NVMe passthru target
Thread-Index: AQHb2ulPgOndZspBxUGJBasy7D79T7QFOHkA
Date: Mon, 16 Jun 2025 04:28:47 +0000
Message-ID: <aa442891-0303-445a-b3ae-e1728b88a910@nvidia.com>
References: <20250611103939.3056458-1-nilay@linux.ibm.com>
In-Reply-To: <20250611103939.3056458-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB5594:EE_
x-ms-office365-filtering-correlation-id: 591ec010-af34-456d-48ea-08ddac8e4950
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?V3RnSzBrMnZjYkF2SXFBN0R3aEN3RFQyK3V5Z3FQSU9yVFk3NUVoRDl5cHp6?=
 =?utf-8?B?a3RNSmFXaENYZTdmaDVPdlFvZk9XTHczcHFTdjZkUjNlWGcrcWVMZjl4LzlE?=
 =?utf-8?B?VGUwUzkvSGFscEpqdlVKMDRHSTNhRVJEQThNYlUyeEovUjJIZmlLeGFHVlBE?=
 =?utf-8?B?TVpKQUhKZGpXa0J0d1M1OUErbktHZFpkK2s0U2I4ZjJCYk5yMG5zN09KS1hs?=
 =?utf-8?B?a3lZNWpwNWJBRC9CRjR6SWhCV1hUdlhWRlllNmZRS2hFT2FyTUJHMGNwZFBB?=
 =?utf-8?B?ZWhlV2NjZjBESGJYaWVtaWRTZVVJYTg1WmpXdDFHNDRCZXpLQ1NBOWI3N1Mv?=
 =?utf-8?B?Vnc5d3I3SThscjJsS2c4OTZtMUFXTThzaXNrcWFSYjl3S1ZqQVRUNHhSdGxM?=
 =?utf-8?B?YktSckYyVDRiQW81SUNUb3pTeE1TTXFXNkg4V2FnUW4yS1hoRHNqM0NnSmJz?=
 =?utf-8?B?cTJLZUYzSVdYM3RTWEllVkI2ZHpmL3B6UWE4R08raHptZXQ1TTUyOG5rUGdm?=
 =?utf-8?B?bVN6ejJWZHVCZ2ZQK1JDYmVvZllQQW4wWFpFSWJadFFMK1QyNEVwZlpjL016?=
 =?utf-8?B?SG5CdnY5UWtNOEtpaHJ2UWJpZGNrL3JtcmxjL0FhRU01WmZiaFltVkhmS1Fi?=
 =?utf-8?B?RWx0SDBrOXFGeldlUjBJZ25MWDN5d3VRc2JCS2h1WTFjUGJUWlJ2RmhUMzUz?=
 =?utf-8?B?OEU5ZVI2MkRibE5uR0JKTGZhZVNHZm00Y2phQitkMndpclQ2c2RNcmxVWS9G?=
 =?utf-8?B?TTVYeFpaakxyLzRmRUsyVWxhM3RSYXJBeVRkdFdEWk5QOXMxbnlDS2tTU0lk?=
 =?utf-8?B?WklkSWlXdlVvZkZ2WEpibGxJRm9NWEE0V2hBalQ2cjZQVGFlNkNiMnVnYVpU?=
 =?utf-8?B?WEZHSVFEQ3oxeWhld3IyY2lyWGw3Sk5UQUljNTBBdUpXaXNGSlB2Q0swS25U?=
 =?utf-8?B?Q0tuRXhwYjEvWS9pRjZXTWp1bFZZTDdVMFBXWnhQQVd1WXYxZk54c0NMRW5z?=
 =?utf-8?B?bmNOZDV6SEhhOWFjYlBpbmVWdWVFUE1WTkYxMDN1MUxQTklvMWpMSnBZcDg3?=
 =?utf-8?B?L2J5aW1oYzF4TzlsdmlrWGpnd01VbUE4UWs1SFEwUkxEUWxIK1NqOUNMbFZk?=
 =?utf-8?B?N3A1SGhJMXZ1d1U0OG0yYmdaazFoWjRza1dWYzc3NFFiR0x3cmZWdnNKa3RP?=
 =?utf-8?B?VGY5ekszWVhvaWpldzJDUTRnUUVHcy9nZ2NYaTJSclVnVkJmQnc3a3lTSmV6?=
 =?utf-8?B?S0JicEE0Z2JaT1ByekI2bUZmblFjL1kyQ3pmWW5tT1hCN3NHTVE2dE84VkhD?=
 =?utf-8?B?RU12Vk1ONXZ1TjM5Vk1yU1hLRmxjTENEbXNORUpmZW43UHlUSXMzQU5FaE5F?=
 =?utf-8?B?Nm43TlF5MW1hMVd3T2N3SDc4di9VeS8xWVYxR3kzWE8xVUJXSEhWVzYyVkZM?=
 =?utf-8?B?T3JSSlMyeHJmVTlmTkwxWWtSMFQ0eWJjMmJ1MWdXb2g4d2xhKzlXbmJXTDdr?=
 =?utf-8?B?dVg0eDF4NGJOZmI4TWFORVpPc2NtWGcxbVBoTUFseXoveEFRbVBreS8wVmFS?=
 =?utf-8?B?czljd00vNFUrck5DSm84YmFIWVRUaC9uczFOY2dOdndzeUtDWkxjNFhwTDda?=
 =?utf-8?B?bTNibUMrd0t1akFMN0xvNklpVzUwTUZkNUZiZEhoSEV6ZE1nMHptUkd6WTVU?=
 =?utf-8?B?ZGtkUTVGOGtRYVQ1VHdVK2lDNW1tamlMazF0YWpMelZ6cG9scmUrZ0M1SXRR?=
 =?utf-8?B?WlYwb285M05HaWpyMndLUkNrRkFvRjVWbVZ1bnNtUndkUWVpNTcrdUw2NW03?=
 =?utf-8?B?Zi9pWUhJamFKVi9oOXJRNjRXRlBCNmZGdjFPQm8vczd5czM5SkdMRkFUeU4w?=
 =?utf-8?B?NmFRaDBxSnB4a2wrdWt0aDVKWXlaK0ZRUTJrb2VkNEt4Rm5PNUo5TEE0cUhl?=
 =?utf-8?B?M2lqMEtndDN3b2dISE5SeGFoQis3WE4wYS9rVmQ4OTRINTM3Y0YzcU1NUmZV?=
 =?utf-8?B?bmRDaWZsbm1BPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T09LMUJtV0tNSGpsdU1TdkRhVENkWDRZWFg5bklMZ2xDZUVqbEt5Rjc0NkIv?=
 =?utf-8?B?Z0s5UVlRaXptdUN0cmNYNnFWNE90bzdIY2RXbTkwRmd1bWJBcEpwZGJkYTdy?=
 =?utf-8?B?UTc4SVVnN0ZlYkdsbnJlSCtoMWFoRTV0VnM3MmtBYkR2bUUrSTRxOHF6SlNk?=
 =?utf-8?B?NlR4T2hXZ3RFcmdtT21nRzVhdWZ1bldTY0pGVU1tam1BRmtRbzFxV1JQS2x6?=
 =?utf-8?B?YjgzWkg3am5oQjRUbHVoUGtqemU5M0JiSVBDb0Mwc05NK1ZEMCtNbUtVLzdN?=
 =?utf-8?B?Q3hkc2ZXcThQUHVsOWx1aXpNczFTRllUaU1iSks2bUZadGFQWkt1cVgyM0VX?=
 =?utf-8?B?KzRTWDFMY3FzTU9NOU5xV0dUclh2Y3l6K0xpTDN3MytkU0srbUt6UElmb1Ay?=
 =?utf-8?B?ZlhncVJLNlFtRWNRWjh6MmlvUm9jOUhFQ3dBMllra1E4WExzZUpOUG9oeWF1?=
 =?utf-8?B?ZkdoUVNMUUhwSzlFR1BkUlkwQmRMQ0Z5RzA1enQzK2xiTlZlbFlValVpWEJE?=
 =?utf-8?B?WThHcnFHOFd2cEtncHBzSmxINlg0RDJ3cWZVVWxITXRHd0NZODdqYWpibkRa?=
 =?utf-8?B?SjExTzNIMTRVbkVudVRYSTBWdkdXbEhidGN6bUtwTnpSRDZBQTAwS2RrZUdE?=
 =?utf-8?B?Uk5rY3BOU1lhQ2NEVktiYmFmN0pFRTBuZC9kVXNlU3VXdXBZcmlibEJjcTB2?=
 =?utf-8?B?Qkh2V2Z2ZklNM1U3eUkwSWlVR3V0UjFQWUlTQ0l3T0M3Sk9rSWNudktObmYv?=
 =?utf-8?B?S1lHOUg3dnZKajE1QmpyZVZGY1JIWlhWK2VhQnFwQlEwY3R1bFp2akFENWdk?=
 =?utf-8?B?MUxDWjZKaUhoMzk0ZXR1VUhPVmxBbEVKQnBtMjFxY2JEdHNJTGYxU09lbkxz?=
 =?utf-8?B?eEhMSlRyUThFdUV5T3lNK0JrcWdlZU12TndURUlWU3d4V2JyK3JhL0Jxbk9R?=
 =?utf-8?B?Vk1TdnZKOXZ6bms0bTZMN3BPVkJvMEJqWVZSaDVOUjhVcGhEdGVHVTZKZ2lD?=
 =?utf-8?B?UGRsZnBieFBZM1p2VEdHVFQ5U01mOG5ZeitjTGNwMmFjdGl1L2tXNjk4V3I4?=
 =?utf-8?B?ZG9VVHRBcThCS1Q4ZFc3Q2ZlZ25oeGduUlQxZ01yNjh4QmVGcUdkU3VybXk0?=
 =?utf-8?B?ZWt3TUU0V1NRQ0VKSnNSMFh0UVlpWVpTd0xmaEpuREh2WWplOGhoQ1hubkwz?=
 =?utf-8?B?dXVuV3ppV0MxK0tpb1lwalZhNFZUbHNNUDE2TzJOOTNTbURKd0FjVDljZnZr?=
 =?utf-8?B?dmNiVDRsbUxSd0RuTWhlNlJLNjR1dXVtNkE2Yk8zdnc3Y28vZEljRTVDa2Z4?=
 =?utf-8?B?VWM4dEVic0JIWUZJdU5BOWlXN21MZ1lVTXg3ODlLNUwyWTRLOVpRV00yT1lv?=
 =?utf-8?B?bGtRQ0oycE1TeE1COFl6ejh4YkJxWWU1ckFVV3AvaG52QnZHQzk3LzVmMlUw?=
 =?utf-8?B?UW5qRU5GdDJZSmpiNDRKSzJPc0l4MFR5VDdjbTAySFN4M1lOVHc2NGxkTnlQ?=
 =?utf-8?B?Q3d3QzNBejZtU2o2Qnc5c1RMMnl0L3FoTHV4V2JEZ2J5UlVJbVNBbWJSczVa?=
 =?utf-8?B?ZmxrMjRmNHVGMzVuRTlwbmd4RDE4SENQbDBPa0JobytjSmh1ak1tcVMzUFZi?=
 =?utf-8?B?MXNGUmZ3bDNWYmhaT1JqOXN0M2xjRHp2QVNsb3B0ZHkvbVhxRms3ZWRIY1ow?=
 =?utf-8?B?Mk5xNnhlU25xNVBwM3FXWE43QzBvaVBycTdNaEJqL0d2ZnNDTzJxVi9MWW5X?=
 =?utf-8?B?bTRJRDhKOENOT25PeWhTWHZocnZBN1hKUytzVVVuNWVwNFN5VWFGVDFmUzlF?=
 =?utf-8?B?bWFBRExYdjZMQjF1cHQvNkZVd1RIRmFzWHMxRFk2UklIZWxDS0RSaHRnQmpp?=
 =?utf-8?B?VjhlcStLVVVVNjh3d24ydEo2c2d1bWlQWk1aWFppaE9YbER2RHVBb2owekRO?=
 =?utf-8?B?d29hNUhuV1pZblBmb0pRbHpIVzhrYzd6cG1Ua3Z1ZnZCeHdvU2FQd0VsWHdY?=
 =?utf-8?B?T2huYnRNQXNCM1dadnZ5UFVSM0lWTWhnV3Vkd0pYQ3hPeWpRZnpFL210b3hm?=
 =?utf-8?B?SnIwdDd0MlZ3VkNGWjZWbkxsbDU0VXFXekhEMjArcVlEYUpjbkh3VUVxVDNq?=
 =?utf-8?B?bExuQS9TUVZVTkFLZDFCTnlpdE1kMTZLakl3ekVoTGQzci9hYjg3dUQ5WWxm?=
 =?utf-8?Q?oLvLK9rST70MmUBYnpbrnE12Z0PLHSrrLUXPTkAzo6Cj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C540C2825A622B4AB7015E7700BC99D2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 591ec010-af34-456d-48ea-08ddac8e4950
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2025 04:28:47.1346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ga91UJeqg0ZUUdQ6KUYr9V2r6HMOopHSBOL84G4rl6JK6qN5QT8msd/zPDGez6JzAROe3ISugz7fw2eELzC/dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5594
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250615_212851_970569_E790F032 
X-CRM114-Status: GOOD (  11.85  )
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

T24gNi8xMS8yNSAwMzozOSwgTmlsYXkgU2hyb2ZmIHdyb3RlOg0KPiBUaGlzIGNoYW5nZSBhZGRz
IHRoZSBzdXBwb3J0IGZvciBjb25maWd1cmluZyBOVk1lIHBhc3N0aHJ1IHRhcmdldC4NCj4NCj4g
U2lnbmVkLW9mZi1ieTogTmlsYXkgU2hyb2ZmPG5pbGF5QGxpbnV4LmlibS5jb20+DQo+IC0tLQ0K
PiAgIG52bWV0L19faW5pdF9fLnB5IHwgICAyICstDQo+ICAgbnZtZXQvbnZtZS5weSAgICAgfCAx
MDIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIG52
bWV0Y2xpICAgICAgICAgIHwgIDc3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysN
Cj4gICAzIGZpbGVzIGNoYW5nZWQsIDE4MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQoN
ClRoYW5rcyBhIGxvdCBmb3Igc3VibWl0dGluZyB0aGlzLCB3ZSBoYXZlIGJlZW4gbWlzc2luZyB0
aGlzIHN1cHBvcnQgYW5kDQppdCBpcyByZWFsbHkgdXNlZnVsIGFkZGl0aW9uLg0KDQoNCk92ZXJh
bGwgdGhpcyBjaGFuZ2UgaXMgdXNlZnVsIGFuZCBsb29rcyBnb29kLCBkaWRuJ3QgZ2V0IGEgY2hh
bmNlIHRvDQp0ZXN0IHRob3VnaC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8
a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==


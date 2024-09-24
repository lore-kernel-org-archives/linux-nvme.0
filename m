Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E61CF9C6B
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Sep 2024 03:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T+smHMI3EDSC6PxM87j9vQzpU6FrUx2wJ7F8EC1uxB4=; b=rDKmvzqY/AkUg6Q3dzAXDOlWAM
	z+UkPrM7E0Oslh2cQvdXgsW0Rd0TmofBM0K6//WRlvO5mrnEQGlvxCmosYE+17DidLIC3uJ1QyrKc
	czU+ChP+JHnktnGT5Jdig0Zy+7Q86XooLx5XIZOWa5ESbHnyoJ8p6dAsTQYU3u8Z0LeEZxRnmsDvn
	IZFdTaA7tOJkzQENoPyltJ1mDzqhXVs83Nup1i3vrXC2VQi2nQ8eOYkX16o8PCyHnuGubUDlsVfEH
	bVlCQD73C9Xux17anFRjGIlq4naQ95DjRKAt6PgSufsFDusaAAP5+xYa8YQjkEy/ygYEO4KigXFo5
	/2cSVd9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sswKb-00000000zal-0Zlq;
	Tue, 24 Sep 2024 03:35:17 +0000
Received: from mail-mw2nam04on20621.outbound.protection.outlook.com ([2a01:111:f403:240a::621] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sswKX-00000000zZn-2eth
	for linux-nvme@lists.infradead.org;
	Tue, 24 Sep 2024 03:35:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elEG+HpeMV3Jk/67B1XQukKfTPTxicTtuP6my7Zo1JFuOUF65q18iMm0Wn3f3X9W28WZpHiwRAYonxJcwWt2ZVrT/qXhVhJcYvuAi7kLwuE1GbQsUcoWpiyxSf62WI/x9LPc7MAvx6J/fzXLXZ60hpxNQm4xZCJs5LTbPWkN0Qyj93DaRKyq0SLn+WpwnlKm5gwqTrhVf8roXXiRD4H+V5Jw+HhpaFOwe+Cy4k0U9dVpn3f9VwbdqcIK+/06vTs6EWvWn0KTVbKjWVfU1dTNTJ9kFMrHmXciEvJVaFil+RzrFJ8GSHF5Q6uqzEtQTjmEKeRvZ0In5rFffgbmA5fRGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+smHMI3EDSC6PxM87j9vQzpU6FrUx2wJ7F8EC1uxB4=;
 b=qNQOYFUf00ayuBs0LlmdT8mQCdSEXyok7/icmUPun96Lnes23w5iIbI6lQ5OdLoDOkX7H95yCpC9K8Kz3rAc/qy4je7tzLgVVfc4eN2v0aPf4wJzqg5e505qUVcUyjoDrgZi6X1VZjbuDIEHesohATxQ1kHWKqJmDfYPw6IqPB/hqJqnVA/syMGjOCPDrXrK8CmKHRZRaGhSGLVpiZZz76VPYEcO9IH67idvaZWJIjgbGeVYV4u8ebbeYXYUs3elwluOf35kJYno17omAL41mEo1dMXab2aux8zoPmB50aXU9ylG3J2LK2huqH/cht4LOL0MAzEL5Qy6MFWV6Kv+MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+smHMI3EDSC6PxM87j9vQzpU6FrUx2wJ7F8EC1uxB4=;
 b=ub08l9TKW2r9vA4rQnpvoMrYqBOmuGf0/VNPGxI1y1fPPp9vC7xtmPmwxADD2a0jj8YbnaE9yz7ct4Jebah7RLGty+V1plfSrvyX0Ur5TsossdjVxXYorcQaKcqQqoez4kvYD6Q3/vVOU7RPxSNY3cxcBBTp5UY3eG04VdQz5fI4abls87oBrr9E8Q/p+CMud4azuM2e7LSqvq9eHfUROD2EeQnUosguxXYECCwWMutnhoXrlVe+PY26dQLbYNydwAENEqwq17lxuv2RVjG3u7NEkDV1zuELYWOhj2kTlCg1EdaPhh9yNZYPrDH7TfPGeWuBcZbOgUJqJ6gM/3dxTw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM4PR12MB7765.namprd12.prod.outlook.com (2603:10b6:8:113::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Tue, 24 Sep
 2024 03:34:58 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.7982.022; Tue, 24 Sep 2024
 03:34:58 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Nilay Shroff <nilay@linux.ibm.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, "axboe@fb.com" <axboe@fb.com>,
	"gjoyce@linux.ibm.com" <gjoyce@linux.ibm.com>
Subject: Re: [PATCHv2] nvmet-passthru: clear EUID/NGUID/UUID while using loop
 target
Thread-Topic: [PATCHv2] nvmet-passthru: clear EUID/NGUID/UUID while using loop
 target
Thread-Index: AQHbC/TB6J93pFm+oka5/Z1/zHvknrJmTYsA
Date: Tue, 24 Sep 2024 03:34:58 +0000
Message-ID: <89d4d73d-daef-441d-beae-e9ba52001911@nvidia.com>
References: <20240921070547.531991-1-nilay@linux.ibm.com>
In-Reply-To: <20240921070547.531991-1-nilay@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM4PR12MB7765:EE_
x-ms-office365-filtering-correlation-id: e24358ee-ad65-4846-2c0c-08dcdc49dd3d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NzRVakxYYlNHRVRIdXFEV0RhbHRkMytqMW5qNVRrN0JzTVZGRzRjYXF4YkFJ?=
 =?utf-8?B?aW5OVjh1d0FReVUrZGN3eDgyUzdwZEtMMEVCd0VQYW5aWXV3ZThzaHV4Rk9M?=
 =?utf-8?B?V09DUFRuS0tyejgycy9iZmRaalZneGxleTk4cGlvVWRLZ05MSFllWmNZMWpx?=
 =?utf-8?B?VUw4V3dMcGNDekdwRWdWa0VuamhWVThQc0RVNTNZMlNZMGtHMVlidXpZVklD?=
 =?utf-8?B?S3FNSnJiZ2QrSEg0MU9xdFozRXdXSkpkdklCT2Exdk5tV0ZJam5mYmFPRmc1?=
 =?utf-8?B?b3dlOW8wR0JwV2loUVE0dVdtT3JnelZRb09iczRHNVFSU3lZdzhxbnNzT0hD?=
 =?utf-8?B?d3ZSckZuR0pFdVJHZmJ6dVA4ajNObUd5MEplQ0lDcDRWcHhmM0NnNlk3YnNz?=
 =?utf-8?B?NkVXYWJiZGVVc0QyaFlyZHhudGFid3I3TUdqcTcrMDc1bmxFc0xObGgvWmdz?=
 =?utf-8?B?Q0oxbjJ1Nk1EblFZZFNDbXQ5NXBvMlVmOWQ3cjdoV1hhQS95dVN3aWQ2OEUr?=
 =?utf-8?B?MkMwZmhOcktNdGRhZWI5WmtYMUtoNWNkM1pnOWM5Z2p1dldZZmNBNGNhYXlM?=
 =?utf-8?B?SklKbTQrbTBTeW1Rd2dLUFdyVUx4K3dvbHhBb1VDMStTdFFKMGlOZlc5TFp3?=
 =?utf-8?B?NE1GQmxoTkJtbER6NFducXI0ejkrNWlIZnpFU0Q4Ukdpc2FmSy93RDdRbjRl?=
 =?utf-8?B?dFhoYVlBVFVUeElvYnVxTUw1WlZLdG9nVHhaS1BZUmdONzFqYzYvTVo2SHkz?=
 =?utf-8?B?M1Q5VWJiOUFZTTJ2SWphd0h0TGpNYzJTMFY0djlLZWhhY3A4ekNhTUxYc2RI?=
 =?utf-8?B?ZnhHTWdmaHFnWmJwSUg1M0lnb3lJQW5USVlJMStrUldjS29YYm9BMVA3NmFt?=
 =?utf-8?B?VXB1NXlqcm5iejNCZzY0RTc1aWE4WStBRGpxU081YWVxSXNsQUQzUkR4NVRv?=
 =?utf-8?B?Z2JoRE1sRERabldnQzVxVzJPWXh4Zi9GSTM5UFhkKzFabUNLLzhIWWNKaGd2?=
 =?utf-8?B?SmhhL2lFWEtjbjJWYTZGMUVtemsxY2hJVTZIVTZwUTJjQlIyT1UwNGxRaHRz?=
 =?utf-8?B?cm8xQllXTUhvV0tHVzJ1UjhDRENoTjNEbFFQdy9xbStzM09Xa0RWS1RyVWwx?=
 =?utf-8?B?TEcza2pPcVV6ZGJCM3c3ZkdqN2NaMnNybUtlcU5XV1o3Z3AwOXA5cFlzVS8z?=
 =?utf-8?B?RDFwb0pYWFZlT0hId25CZ3IzTy9oanpXTEE3M0lieU4yYzFCYkczWDNhT1lQ?=
 =?utf-8?B?UGpDVmxyUTdIZEpnRjQ4ZklYb0s5SnNBMWhZYjdUT1M2WExDemphak9Db1VX?=
 =?utf-8?B?Z2ZjMExXbEEwMDQvMHpJcmNqZjgvZjNoNFhzY1pGWFBNZmN4dG52aHlmWVlj?=
 =?utf-8?B?ejBLN3JPb3hKdHBuL2NkVlVxMTY2c2xXdHlYd3ZkZGJjbmxVcUY1cHVVdW9l?=
 =?utf-8?B?TnNlOXRNVHVid2tIL2pFNHZ4MUtKdkQ3NUcwM3F3b2JYS1JpNk4wUzJGODQv?=
 =?utf-8?B?am1SZVk3eHgxcTZnL1cxdGJkenZicFpDblAxdjRqSHZvcFpXSlZsYTRGMXR2?=
 =?utf-8?B?Y2hzWjRJZEovL01WNndXUlhTemllR2EzRW1VaWVLckxsbGgvR0JEWGN5Ymdj?=
 =?utf-8?B?Z0R0WE9ndFZYVVNPRFp6VEVCY0twbUhPVy9HKzhPNjhuNi9KU01OejJMNW9r?=
 =?utf-8?B?SW9GVnQrMDFUVGZlUkt6K09NL1Jrb0RWT3FlV1kyd0ZXOTgvMGIzTjNndlJi?=
 =?utf-8?B?TElnRXZnZjFvVFF3RUFFc1k3Qkw2NmNHS1JmYmVTNm5pN0JlRHdFczRrNy81?=
 =?utf-8?B?QjRJQjZUaW4zODJVbEVCQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHo1RU45RWdRUjNOby9YRFFTbjdYb1JpcWd3UHFyNGdyOWNGcnREelptOUVB?=
 =?utf-8?B?WmlDN3d0ajRWRHgweDlNN2lJbFVVNlZUd0dNbkFVV0hWUFNjMm5KaGwyN3BM?=
 =?utf-8?B?N0F2TlprQzVxcVZ3cGRPSUdWaGJDQWpQVC9VVUF4cnJSN2Z4cTA3THN3SnVr?=
 =?utf-8?B?c09sZG5JQnNtRWgrTVZ4eklheUNVakFMbnZpN3pnaWN6K1g0QkZHTXBma2pV?=
 =?utf-8?B?MFNZYnhtMU82RVkrMm9iRWlsWW9oME5hYVg0L2MycFFib1dhM2pFa2syNVJv?=
 =?utf-8?B?S2xhdEZkZTdFK0ZkNzlobWU5dThIRStaR1pWV1hjazJKTnVBbGM0REMzUGd4?=
 =?utf-8?B?VC9id1ZzQ24veXRPWlZuWC9PU1c2WldyeklQdW1TazdTeUtYUjVSbXdRYTFo?=
 =?utf-8?B?WEdLblFCdmNHMkNWMmZ1cU5leHJDT3dzcHRBQkl6VTV1Y09rKzNjK0JPYzRq?=
 =?utf-8?B?T3UzeEJKSERiTGx0N2paeGJWV1ZkTlZad2VkQUQ0V0ZhQmxBeEMyam0zZGdp?=
 =?utf-8?B?aFM4aTBhZ0dSSlZ4UmlTRzdEOUpHd0sweDhkeFN2UlFzN1NkSURDZW9zQWNu?=
 =?utf-8?B?aUt2NWE0djlPY2xkREJmanpBZDlOR1BXc1lUUmpNbUxGVGdCSnRLQzdycUVC?=
 =?utf-8?B?K3VsMHdqL2pJRld6Nk0xaXFPay9ZZGpiRUF0YWpnTFFvdTJCSUMzM2NkbTRR?=
 =?utf-8?B?UW9rRE96azdDVjlRSjFGamN1K2xYRTVFN1dRbmpHVXIxUW9NK1dXdkt2SCtn?=
 =?utf-8?B?NGpIS1hCbC80UG8ydmtqcXhnZmdXNXZ4c2tpb0h1dWV3NmxnNGZyK3VhRDl1?=
 =?utf-8?B?Nno0TnhwR2JUbVpNdlV6WkUveU9nMGEwLzJ4WkY1Mi9tdFQrN0hkNityWW5W?=
 =?utf-8?B?OXZlTWxMK3RjeGk3NGpleDV2KzJaRHhBNzA3c2RRLys0TjNEWjlnTW9JQkJF?=
 =?utf-8?B?MklRbnYrTG11OXpFMFhOMlFoQmlTaU1EeTFGNWZOZkY3RTYwOUFsdUMrZm1x?=
 =?utf-8?B?MFZZWmwyR2NkUXJRQkV3U0RzWXhvSlFubUljQTN0K0RGL0VScUFCWVdWL2VR?=
 =?utf-8?B?L3U0K1VBQkhJL0RuWHVKTGZTK1AwRlY0am1UbWRGbCsrK0hia0ZLQThXeSta?=
 =?utf-8?B?MXZDUHh0bllEUS9CMlgzZGJkcGNPbzNIMWVYTXgvREdINFBGenI3Zk12UkNC?=
 =?utf-8?B?QWdsS1p6anY4OEs4VGpkSWlNMjVheEsyYy9WODdsM0JyeWhWRndFVlFTWnRr?=
 =?utf-8?B?SExsWTJCa2E5bG1URXcvMDFYOXhYaU05bmMxNzl5K1plYkRzV0xhUThSamwx?=
 =?utf-8?B?eWl4em9EVlNLV0hwek9GRFNWL0ZqY0hydGNVemlYVHNyWHFzV0cvcEJ5ZEt0?=
 =?utf-8?B?TU5VNVQrT2x3aVYwRGtyTkRURjlpTGNIR0FkbnBwWm9SWW9MaXJuL2ZxWGZh?=
 =?utf-8?B?N2d1cyswWUV4a1JwenVxTXp6STNuc3U3QkhKVjdUUU56NE5CNXp5TG5zMVRH?=
 =?utf-8?B?eEU2VUFhbno5Ulh5MWhKTmVxSEl1WkE0STUya1ZxN2RjODVGUDNBNnFUNHNY?=
 =?utf-8?B?dThTcHdOSmRNMzR3cUhDdW1EcDJTelJhTVpHZmRXNXAvWkpUTm1ETGdVYjlT?=
 =?utf-8?B?S1paWTdOWHFnZUxnbVBNTkEyNlZvM0VPSmlUNWViVEpnd05sSllQRHVTdHNQ?=
 =?utf-8?B?WDZURzZPY3JiQ0kzZ2lodjJGbkpkWWdKS1ZMZ2swZ3dFZDNITXQwTFVOaXNj?=
 =?utf-8?B?TUlyaWFMSkxWeXFIa0pXdUNkRkZjeWhuUEJOZEs2Z1JLdk44UlFyVVJna0gx?=
 =?utf-8?B?NkNCdklMRis4UDJtNTFFZjJROTA0dUZteWcyUWxBY0pyNC94OFMvSy8zYUZa?=
 =?utf-8?B?cmhzQ0NRYXVxbVlXc3FEYkJZbFVrYWs1bU54WDJNaDNCR0ZUZUFPaHhUZmRI?=
 =?utf-8?B?VnBBRFlZckNXYjBaSHRRT3NBL1hwQmI4dnE0YTNCQ0Z0QytNUjNaUTFDR3Zx?=
 =?utf-8?B?ZFV4QUZIK2wxQmVmaWlEekNRRXlWOWxWOWJHUEQzOGhPbWRBUlF4S1M4dGJj?=
 =?utf-8?B?ME9yMGlPMk9xcGkxSEJXNVhCQVBwK3gvNGVwNkxXUEtjZDRQTXhxSUNaM3Zm?=
 =?utf-8?B?R2sxV1FaTFlFczFmaGtYQ296N0VuU0JyR29JVUxBa3MvQW1aVUJkMUtqblpL?=
 =?utf-8?Q?7vEL2m2PX9OTyz2yCwXq2Hxx67DazHmB/rGvU/fKXXk8?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <14EB95A3D1EF7242A3537A5403B2A3CB@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e24358ee-ad65-4846-2c0c-08dcdc49dd3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2024 03:34:58.1887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AZvyeNPqj6TP/pZ/LpikAvTXcLtSmKtKMLmZs5mw/qHjM+gs4UC+ponDP72uvGw8Efg/0uU7cex7CmDH7mAxJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7765
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240923_203513_699792_5D100B6D 
X-CRM114-Status: GOOD (  16.77  )
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

T24gOS8yMS8yMDI0IDEyOjA1IEFNLCBOaWxheSBTaHJvZmYgd3JvdGU6DQo+IFdoZW4gbnZtZSBw
YXNzdGhydSBpcyBjb25maWd1cmVkIHVzaW5nIGxvb3AgdGFyZ2V0LCB0aGUgY2xlYXJfaWRzDQo+
IGF0dHJpYnV0ZSBpcywgYnkgZGVmYXVsdCwgc2V0IHRvIHRydWUuIFRoaXMgYXR0cmlidXRlIHdv
dWxkIGVuc3VyZSB0aGF0DQo+IEVVSUQvTkdVSUQvVVVJRCBpcyBjbGVhcmVkIGZvciB0aGUgbG9v
cCBwYXNzdGhydSB0YXJnZXQuDQo+IA0KPiBUaGUgbmV3ZXIgTlZNZSBkaXNrIHN1cHBvcnRpbmcg
dGhlIE5WTWUgc3BlYyAxLjMgb3IgaGlnaGVyLCB0eXBpY2FsbHksDQo+IGltcGxlbWVudHMgdGhl
IHN1cHBvcnQgZm9yICJOYW1lc3BhY2UgSWRlbnRpZmljYXRpb24gRGVzY3JpcHRvciBsaXN0Ig0K
PiBjb21tYW5kLiBUaGlzIGNvbW1hbmQgd2hlbiBpc3N1ZWQgZnJvbSBob3N0IHJldHVybnMgRVVJ
RC9OR1VJRC9VVUlEDQo+IGFzc2lnbmVkIHRvIHRoZSBpbnF1aXJlZCBuYW1lc3BhY2UuIE5vdCBj
bGVhcmluZyB0aGVzZSB2YWx1ZXMsIHdoaWxlDQo+IHVzaW5nIG52bWUgcGFzc3RocnUgdXNpbmcg
bG9vcCB0YXJnZXQsIHdvdWxkIHJlc3VsdCBpbiBOVk1lIGhvc3QgZHJpdmVyDQo+IHJlamVjdGlu
ZyB0aGUgbmFtZXNwYWNlLiBUaGlzIGNoZWNrIHdhcyBpbXBsZW1lbnRlZCBpbiB0aGUgY29tbWl0
DQo+IDIwNzlmNDFlYzZmZiAoIm52bWU6IGNoZWNrIHRoYXQgRVVJL0dVSUQvVVVJRCBhcmUgZ2xv
YmFsbHkgdW5pcXVlIikuDQo+IA0KPiBUaGUgZml4IGltcGxlbWVudGVkIGluIHRoaXMgY29tbWl0
IGVuc3VyZSB0aGF0IHdoZW4gaG9zdCBpc3N1ZXMgbnMtaWQNCj4gZGVzY3JpcHRvciBsaXN0IGNv
bW1hbmQsIHRoZSBFVUlEL05HVUlEL1VVSUQgYXJlIGNsZWFyZWQgYnkgcGFzc3RocnUNCj4gdGFy
Z2V0LiBJbiBmYWN0LCB0aGUgZnVuY3Rpb24gbnZtZXRfcGFzc3RocnVfb3ZlcnJpZGVfaWRfZGVz
Y3MoKSB3aGljaA0KPiBjbGVhcnMgdGhvc2UgdW5pcXVlIGlkcyBhbHJlYWR5IGV4aXRzLCBzbyB3
ZSBqdXN0IG5lZWQgdG8gZW5zdXJlIHRoYXQNCj4gbnMtaWQgZGVzY3JpcHRvciBsaXN0IGNvbW1h
bmQgZmFsbHMgdGhyb3VnaCB0aGUgY29ycmV0YyBjb2RlIHBhdGguIEFuZA0KPiB3aGlsZSB3ZSdy
ZSBhdCBpdCwgd2UgYWxzbyBjb21iaW5lcyB0aGUgdGhyZWUgcGFzc3RocnUgYWRtaW4gY29tbWFu
ZA0KPiBjYXNlcyB0b2dldGhlciB3aGljaCBzaGFyZXMgdGhlIHNhbWUgY29kZS4NCj4gDQo+IFJl
dmlld2VkLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gU2lnbmVkLW9mZi1i
eTogTmlsYXkgU2hyb2ZmIDxuaWxheUBsaW51eC5pYm0uY29tPg0KPiAtLS0NCg0KTG9va3MgZ29v
ZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoN
Ci1jaw0KDQoNCg==


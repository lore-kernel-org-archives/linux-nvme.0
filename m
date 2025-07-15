Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746C5C83F34
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 19:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zRSKkqHsNITbB7ueOEm5QksgEyfSp5dIS9q1WWyJvAI=; b=OPQgAUbWNDnl3urooIv7p/Qkbu
	jvuXzz/tHP/+JxHwA3ttjewTB8Q8V8bvaJnXs1KEzs4kg85qbgth/MFudCT/4dxFpqoiWJNan8kCi
	8tD0pwA2Bm+ywy8qv5Qc+2AgVyGfxWZz4MLK0LuhrE3yfXJhjmn5I0eD13IFJzYR3hAt12UsxANtH
	fPihIoithkXmM8uHzYKQif3dCk2KkIzp421KsUERQyYU3hl5MfoRt4unJWZvVxsLmAFXrX21W3Ezl
	QZtfsfeFzoFsxxFHClJHgbx6Us/Cwp3+uc8BWnbvkJ8VnMEcyDY2YXCuDU9PBMDRjbSCL5Le390QI
	ZXsKg6ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ublBe-000000061j3-3kx7;
	Tue, 15 Jul 2025 19:19:34 +0000
Received: from mail-bn8nam04on20626.outbound.protection.outlook.com ([2a01:111:f403:2408::626] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubj9G-00000005o4X-2E4P
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 17:08:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmtQR190Ve7MWz0TfIV2RBme/zVAQrdj5/Nbugysqq4oVRxKgJaGzb4Y6XyPrtdMe1XFOGroPnuPRCxH6SXNFC/4mob+Ql5fsihNUEAUYUkMPbGe4OI0ah12vR0LLRf+6ULZ/bRfCGSQGOueNgUURcINy0RccI00CjGyxpfuR9BbUGDA+Muw2W4Gr8DYIcZjIqTLQ0krbRN5EzjBYGFVHMY8bpkpEX9fpA1CAjU41YRqLCurbzZF+eWEoUNlX/LG/5rfHrNZ2zkeSBBUBHqq98xVIl9tUHaWwnnfA6JK7KV7A/gjd/BUaJyVpy3lLguYeAbEy3Y6lmRUDW6UNy8mmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRSKkqHsNITbB7ueOEm5QksgEyfSp5dIS9q1WWyJvAI=;
 b=EDLtaOxQw2Dk+v2LXEaiaD7OcSL7g+4nuDKHNTIL70wJ0r0akpwiX0qE4T3VehW/TuF1LDwCZSLMWLdGeDOhNq2D7SBqMW8SqKgmzzEV5V96Yg0jgUaKAeyA+a6KO1qJNMQQeWi2jUGN26jeizXVuUQ1Wft6egw/j2dlVhCQniVOw/71RwH1ODK7BPSlITQqa1kdoa0BnzJXUs8Iu7PvN1f1XBkg6FuA5scdaArKK6XNH71gTym818+3OmoeehTtQ/I947gQT3sXUb0w4jbDTK0+9KU7y7FUdazpCI60GauV0xMYB+DA6kBcFopzbmeDw8w3PlVnKMa7cKBfExFD4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRSKkqHsNITbB7ueOEm5QksgEyfSp5dIS9q1WWyJvAI=;
 b=ovvb7Jtetoo8s8OEa+z6f3UIdbWVbSZDzYbqqWdcAFV9nCyIyPHLGqwGT68zOZ1UcWoDLRHIMoKfRG2hbqB621dzlhRGtuw0XDKMIabUQuNJpgD66J5XJM7izoFhgFf17WI78Uv94q22FU3kDeMN+CKkC8PAY9j0NFezdMtLDxTu6mhZsJEjWsGZszE9ViK9BAdat0RmGJ0Cp/DnUoPfiMfFgr1VBdtfVIloEeSb//Eg7OMvtdaIJ/paT28dUOIQTac/3vY6e8CkVJE4yXLy+WDnzIBi0WENe+noFiYgG4Lo3QZDMkUav16cxp86R+LLAqExzv1pX2GHCIBPINgJQQ==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 17:08:45 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8901.024; Tue, 15 Jul 2025
 17:08:45 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Jens Axboe <axboe@kernel.dk>, "axboe@fb.com" <axboe@fb.com>
CC: "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>, Shai Malin
	<smalin@nvidia.com>, "malin1024@gmail.com" <malin1024@gmail.com>, Or Gerlitz
	<ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>, Boris Pismenny
	<borisp@nvidia.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kbusch@kernel.org" <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Gal Shalom <galshalom@nvidia.com>, Max
 Gurtovoy <mgurtovoy@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "gus@collabora.com"
	<gus@collabora.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, Aurelien Aptel
	<aaptel@nvidia.com>, "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de"
	<hch@lst.de>, "kuba@kernel.org" <kuba@kernel.org>
Subject: Re: [PATCH v30 03/20] iov_iter: skip copy if src == dst for direct
 data placement
Thread-Topic: [PATCH v30 03/20] iov_iter: skip copy if src == dst for direct
 data placement
Thread-Index: AQHb9YxVX52zMWjR5USXUOtRVlqmHLQzSQqAgAAiG4A=
Date: Tue, 15 Jul 2025 17:08:45 +0000
Message-ID: <2e2d61fa-affd-486a-b724-b458d722304c@nvidia.com>
References: <20250715132750.9619-1-aaptel@nvidia.com>
 <20250715132750.9619-4-aaptel@nvidia.com>
 <59fd61cc-4755-4619-bdb2-6b2091abf002@kernel.dk>
In-Reply-To: <59fd61cc-4755-4619-bdb2-6b2091abf002@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV8PR12MB9449:EE_
x-ms-office365-filtering-correlation-id: 115ff2e4-85ac-47d2-9248-08ddc3c24234
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SFJKYUhvOEdrQ08zODhYS29kR0g4SXBGT0NJQ3lUbXJjL2RGTjNld0wvVWFK?=
 =?utf-8?B?K3BVa0k3d3BzNEhhMWxWU0JvMFRNd0QxUFlFc3d3Um1UeVcyNGZrZHdzditV?=
 =?utf-8?B?RjE2Zng4MUxCQW5EL3BOc3RObko1NHVPbS9ialJvUlVhYTBnSXNPbGVRalF3?=
 =?utf-8?B?OWlQWUFRWHVMREtpTkRUTTE5NlFDNk11WmZDTGRMY1Q4bysxNXVZb2ZUdk0x?=
 =?utf-8?B?eVNaVEsxRm9LZ2xYazBTZUpzMnkydU81RWxFZ1Q2YWs0SGhtdGJSbHZXZFZh?=
 =?utf-8?B?N04xTXZpK0VQRUN3Y2RlTDIxL1lmaHh6eTlIaE8rRk1LUFFLNEhCQWZra0NI?=
 =?utf-8?B?R3htZXZZdjk2VERFdnFKKzlIWEttU3BINWdDOHRpSVk0dUJCaVZLdGhDR1BK?=
 =?utf-8?B?RWh4bEt2YURTV3NoazRuZmQwb1hzbnhHNHhaSWxvN29ZQXBlZWorR1RrUTQv?=
 =?utf-8?B?SktZN0VSY0dkc29ZNGo3d1pjNjF6WmJTRXd4WjhhSDdaRGVUaVpGcGhDOCtJ?=
 =?utf-8?B?ZjBKMFdVZVE5dVhMWDcvL2VaQjNNd3BoNHBUVVJ4R2EvVGVhdXN4eENuY1da?=
 =?utf-8?B?SThsNlF0ZXp4cVdxMEc5djVjZkZSL2V2OGwxYWlxWDBUUGdJV01zU2NCTGtF?=
 =?utf-8?B?ekwxTVJ5bXpqd1Bjd0FhL2JQaERCSzlZWVBKSUY5Q05ESEF3eTdIMmNFMmVk?=
 =?utf-8?B?TVZoRkVwKzRJcUtBKzI5Nnhra0FGTkFmZm1wVGNaZnNwbkU2VTZydUpBYkdI?=
 =?utf-8?B?SnBYQm53c0lJcm5ueDd3M3FHODhkS2N2dktOVjhnUmdXSW91N3lCMWxkK29N?=
 =?utf-8?B?U1dnZHExT2xIMnh5WVIxRXZCc1RldDlXd25VSzRlV0o1c3hEdzhPNjlhakFi?=
 =?utf-8?B?SDltc0RRNW5JUWc0akdlbmpwMlNLUjdiQnBSK0lJZ3RzcFBVRXp4N0VlL2g1?=
 =?utf-8?B?akJoZVZFcEl5bU1BR2hkRFN6M2J0Uy9sc2RyOC9xenVXUW13ZXp4a2pXdk1l?=
 =?utf-8?B?WUxpUTg4ZUpRdithL3BZRG9GUlZ1Skw1MnVJbFA5cHV6S0xTNUpHenNCaHRX?=
 =?utf-8?B?VlBFZzFNTklYM3dPZ0hFcTFqWEdEV0VGWnlWaXJZSWpib1ZIVWRiVUhRb3Ba?=
 =?utf-8?B?VmJucE9HelQ5MndGVFIrZVZDUUgyTVlSbXBwZHlzNnJFK1BiSk9nSHhBQ3Ur?=
 =?utf-8?B?MXR6VHdKZzRXNFQvUHgyS0hIMXpSNW9OK3h6bTdlRGN6MXpVZzYwYlZCU3N4?=
 =?utf-8?B?cEs2bVhhc3VIUTJ5dVdtcVlUZVJQbXJKWEIzNXBWUHhlWGNZVGEzdVVZTmNM?=
 =?utf-8?B?YTd2ZVdtaWdVbWhYZGJKUEZiNjdXcjJjV3YzRnFCdFloR0lLV3pvbFRlc2Zy?=
 =?utf-8?B?aXA5d2JBbWdaMWk3a2hzSWplZWF6OWJ2YUY3d1JKL1hKVUtvUWNQRmg2NWNk?=
 =?utf-8?B?Y0dTZHZZb0ZCZTBROGN5enJQemE1bHNmMTR6c0hLSmVSUWZNZHJzM2RlU0th?=
 =?utf-8?B?cE80VW1uM1JNNXRmMHlkYk9jSXJKbUx4Y242UGpuQVBCN1NheXYwOGtZaVBK?=
 =?utf-8?B?RmY5S2VzT1pUTDAvT1RQUnBteitnaHFlVEppam1LNm5zemhZemFzUXB6ZUZL?=
 =?utf-8?B?RGhVTHZ6cDRsWk85RkJEM3VBT0VrdkpMVk1vclV1UXBIN3Y1NUw5QmYrZVNl?=
 =?utf-8?B?R25hcVpGNWtQaXBRYjc0QkQ4Z0swdDcwUnRHV3o2c01sTGRxdklxaEtOeVlM?=
 =?utf-8?B?d1M1VWg0aTVWeVNDaWZDN1hjUkVJUDgvSnhrM281K1dGSHhSdU1Nam9kUmFU?=
 =?utf-8?B?LzF0TkFHK3VvaXJiamhYTEE4QXZtL1RoQzBCTTRRcWVzeHQ1eFpWTzQydmhW?=
 =?utf-8?B?SmQrQStla3ZNUFJqa3o3eldYYktNdW5aYUV0ZEN1cjBXSGFFbE5xUWNPQmtv?=
 =?utf-8?B?NzZJT1Btejk4bEpmeW4zQlI3anhneTdMbTA1RC9kQit5QlNkTjVkMVNsU2o3?=
 =?utf-8?B?K3c1QUJhZ1B3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm1yU20xY2JIU1oyUnRReWVmNHBWeTJ6cnZPR1R5WTNISktFb2Fmck4zcDVO?=
 =?utf-8?B?WEdocGhvdEU0TXdzVmExMVlqTUlTdCt3VTFPUDhHUlBNd1U0VWpsN2pRVGZ3?=
 =?utf-8?B?STZBc0hiM3RESzkyU1RudmFCTUoyaUlzRmU0Rm9Qc2wxNXpoeU5CbkVrblV5?=
 =?utf-8?B?SHd2QmhKWjVWL0dBQThtNDA4UVNlTWpOSEdYTVlCMUZhaE03WURiWThJMXBB?=
 =?utf-8?B?UWNtVUFmQzdNYktyNDNEbjBmUWpiaXpqWEZzU2pTZWlYdG9aQUw2b3h0dDBO?=
 =?utf-8?B?aWlEd1E3c013TGtpbkFYaWc1ZDhtMW5GanBOVStzWFhlNGNENmRzNUVQMGVo?=
 =?utf-8?B?UFlYWDk2ZG9PZDR4dHMyQmhGTHcwTkU1WWJEK3dyN1R2VDB1WTdMTzhCODJR?=
 =?utf-8?B?Y0treU9wMzZsUmE0V1JhYkNpRHdZMkVvNGdDUkdzVXNwOWkzR3BDTEMzY2lL?=
 =?utf-8?B?ak9wQldVaDhFWWsrY2djTHBEUVhHRDBMckdTQW5xTmF6M2EwMms3elBiOGtE?=
 =?utf-8?B?clVkMFg5ckFHcy9vWGxSaXh3bnkxblBxc2ZVQlgwNEthcG0vY285dTk4OStk?=
 =?utf-8?B?cDN1OXFkVWFHTFlWWkNrNS9nWjVISHlkSncyQlZDRlRTYTVOcUJZRlE1ZmhV?=
 =?utf-8?B?ekc1R3docksyWGZla2phRTFtcVZMZjlhOXpnZmRCZ3hheDljNjhQQUdDeFY2?=
 =?utf-8?B?M3dVcmQyY01ZNlFMcXQ1Q3V5QWw3VU03d3RNRk93ejkzWnRGbzdsVUVTUlBu?=
 =?utf-8?B?NHN6TlBYL2J5aXVGK25aRm1oY0RwSFFiOTVYS0VRK0k0VVVVbDJZSjczNFp2?=
 =?utf-8?B?QWlFblc5TSsyZDZob3gwMEdjZ050NHVPQmlOb3pWbkZqVEJDMVN2bzVmeXpJ?=
 =?utf-8?B?WG44emFib2gwZWVOeWx5ckpUYTB4U3VROHlOdmV1M25mcUFFcWRLV05tZHow?=
 =?utf-8?B?dmp5NWRtUHpRdVMwNjhNczBRSkhrZ0ZpVDN1bDRtK1A1Tm1vUmQ0T2R5eGY4?=
 =?utf-8?B?OHBxbGN1LzUvYldKcW8xdmNRbWZ1V2hzcnR5UkMwZkVZUXY3aUdPdzBpVS9j?=
 =?utf-8?B?MTlybG5YRGNaYzFtbElSYUd5T1lYSjhQK21FdlRxUXI4SncrNVRpMTl0eVBq?=
 =?utf-8?B?d1lqV0xZd0FndXB6MDZqa0VFTCswcVQ5MXhhK01ETjlheUgrNThNbnQ1MzNR?=
 =?utf-8?B?ZTJ1R2VCczBoR2oreWhaK1lwVGtHNFJqV0lMcXFRd25CNktkSUhvQzZTTllK?=
 =?utf-8?B?VHNnWmt4Vi8xUU1OTm54MGRpa1hPYkpWVU9FeXVUcnFYbllFQ1RDSHM5WDNk?=
 =?utf-8?B?NEw3aTJsa3ZsTG5KSUdhTWp6d1dlVzZLNitKc0R0NHVQdTVsaUVLTkZLMjVR?=
 =?utf-8?B?ZWR4UWcxOHZoQ1U4dWt1TEpvUFRJMVBMOVIxUEZmNTJXY2o2UllnU05FUGIv?=
 =?utf-8?B?Z0ZzVENMZ09EWWNVOE5oM0lqZmpZSURqY1hKTVFCOHpGSDZ0TmxTSzZBMWln?=
 =?utf-8?B?UDdRVnZCd2NzdFBFL1NrcDZCbldKRG1MMjl1S1RmY0NVQjI3RkJTaWdlNUpi?=
 =?utf-8?B?V0Vqa0o3K1lhRFNZM3N5MjR3REJUUmpvQTdIdFZ1MGNISlVPd2RKOWUzbUJS?=
 =?utf-8?B?YmFybmNXcXVuTGRsNk1GMHU5bjVKdjJaQTBDSUdtYnFseEp6YTQrVHJpaHpu?=
 =?utf-8?B?TDM0c2E0OU5uUGFNUDFEYUR1R1kxakV1Y0xJMlZUc0NJMGR5TmdEQ3lRRlp0?=
 =?utf-8?B?QUpWNjl4QW1rN3RhQmZHdTg1WHZIR2FJenlyL3N1RC9ZeVRmQ0JzTmxkL0hL?=
 =?utf-8?B?dTQya3Jmdkw4b0hnTllHblVxMllaOGdEQnFPOFhJckZkU040eWgvU1NRT3Zk?=
 =?utf-8?B?SC85R3FXS0hSOVZJYmJGMGMrNi9HaVJOckE5SU9QZHUvOC85b3J5bm5BK2VR?=
 =?utf-8?B?UTlhSkFNVFhiS1FoYy85cVlLdk9OR2RqK0VHT3E2R29DWUNnc0dYWXl3VVg3?=
 =?utf-8?B?QTNaRHp0alcwYXhObW1WckUzWXJYTXZPUGk3ZWk3MEQyOFVHSlZUVzVRTk8z?=
 =?utf-8?B?OXZrRmJwL2UxT095ejBRNTJCb1oxVEFxL1dkeE9GazlXbWprWmVoYm4zZVRz?=
 =?utf-8?B?RkJtTnN4T2tUb1RLRmpFRE5XRENWaUIwanlnRk9JU2s2cExiSlVUbzNhcmtj?=
 =?utf-8?Q?69a1WYlLeyJwedXBj1OzbKFu40ttzqUU06hHtjpeoqZy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0006BC625A52F44AAC2B4A7D9AABDF80@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 115ff2e4-85ac-47d2-9248-08ddc3c24234
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 17:08:45.8103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CbRJdirph6nZ+2I65tKLn5EdYhy3lopA9ICc61xou0/sRnosPomCjjJiPY9YhYbTkB0rzhEKF9pZ2uvW7+6YBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_100858_565329_84B0A484 
X-CRM114-Status: GOOD (  16.68  )
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

SmVucywNCg0KT24gNy8xNS8yNSAwODowNiwgSmVucyBBeGJvZSB3cm90ZToNCj4gT24gNy8xNS8y
NSA3OjI3IEFNLCBBdXJlbGllbiBBcHRlbCB3cm90ZToNCj4+IEZyb206IEJlbiBCZW4tSXNoYXkg
PGJlbmlzaGF5QG52aWRpYS5jb20+DQo+Pg0KPj4gV2hlbiB1c2luZyBkaXJlY3QgZGF0YSBwbGFj
ZW1lbnQgKEREUCkgdGhlIE5JQyBjb3VsZCB3cml0ZSB0aGUgcGF5bG9hZA0KPj4gZGlyZWN0bHkg
aW50byB0aGUgZGVzdGluYXRpb24gYnVmZmVyIGFuZCBjb25zdHJ1Y3RzIFNLQnMgc3VjaCB0aGF0
DQo+PiB0aGV5IHBvaW50IHRvIHRoaXMgZGF0YS4gVG8gc2tpcCBjb3BpZXMgd2hlbiBTS0IgZGF0
YSBhbHJlYWR5IHJlc2lkZXMNCj4+IGluIHRoZSBkZXN0aW5hdGlvbiBidWZmZXIgd2UgY2hlY2sg
aWYgKHNyYyA9PSBkc3QpLCBhbmQgc2tpcCB0aGUgY29weQ0KPj4gd2hlbiBpdCdzIHRydWUuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogQmVuIEJlbi1Jc2hheSA8YmVuaXNoYXlAbnZpZGlhLmNvbT4N
Cj4+IFNpZ25lZC1vZmYtYnk6IEJvcmlzIFBpc21lbm55IDxib3Jpc3BAbnZpZGlhLmNvbT4NCj4+
IFNpZ25lZC1vZmYtYnk6IE9yIEdlcmxpdHogPG9nZXJsaXR6QG52aWRpYS5jb20+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBZb3JheSBaYWNrIDx5b3JheXpAbnZpZGlhLmNvbT4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFNoYWkgTWFsaW4gPHNtYWxpbkBudmlkaWEuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogQXVy
ZWxpZW4gQXB0ZWwgPGFhcHRlbEBudmlkaWEuY29tPg0KPj4gUmV2aWV3ZWQtYnk6IENoYWl0YW55
YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQo+PiBSZXZpZXdlZC1ieTogTWF4IEd1cnRvdm95
IDxtZ3VydG92b3lAbnZpZGlhLmNvbT4NCj4+IC0tLQ0KPj4gICBsaWIvaW92X2l0ZXIuYyB8IDkg
KysrKysrKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvbGliL2lvdl9pdGVyLmMgYi9saWIvaW92X2l0ZXIu
Yw0KPj4gaW5kZXggZjkxOTNmOTUyZjQ5Li40N2ZkYjMyNjUzYTIgMTAwNjQ0DQo+PiAtLS0gYS9s
aWIvaW92X2l0ZXIuYw0KPj4gKysrIGIvbGliL2lvdl9pdGVyLmMNCj4+IEBAIC02Miw3ICs2Miwx
NCBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lDQo+PiAgIHNpemVfdCBtZW1jcHlfdG9faXRlcih2
b2lkICppdGVyX3RvLCBzaXplX3QgcHJvZ3Jlc3MsDQo+PiAgIAkJICAgICAgc2l6ZV90IGxlbiwg
dm9pZCAqZnJvbSwgdm9pZCAqcHJpdjIpDQo+PiAgIHsNCj4+IC0JbWVtY3B5KGl0ZXJfdG8sIGZy
b20gKyBwcm9ncmVzcywgbGVuKTsNCj4+ICsJLyoNCj4+ICsJICogV2hlbiB1c2luZyBkaXJlY3Qg
ZGF0YSBwbGFjZW1lbnQgKEREUCkgdGhlIGhhcmR3YXJlIHdyaXRlcw0KPj4gKwkgKiBkYXRhIGRp
cmVjdGx5IHRvIHRoZSBkZXN0aW5hdGlvbiBidWZmZXIsIGFuZCBjb25zdHJ1Y3RzDQo+PiArCSAq
IElPVnMgc3VjaCB0aGF0IHRoZXkgcG9pbnQgdG8gdGhpcyBkYXRhLg0KPj4gKwkgKiBUaHVzLCB3
aGVuIHRoZSBzcmMgPT0gZHN0IHdlIHNraXAgdGhlIG1lbWNweS4NCj4+ICsJICovDQo+PiArCWlm
ICghKElTX0VOQUJMRUQoQ09ORklHX1VMUF9ERFApICYmIGl0ZXJfdG8gPT0gZnJvbSArIHByb2dy
ZXNzKSkNCj4+ICsJCW1lbWNweShpdGVyX3RvLCBmcm9tICsgcHJvZ3Jlc3MsIGxlbik7DQo+PiAg
IAlyZXR1cm4gMDsNCj4+ICAgfQ0KPiBUaGlzIHNlZW1zIGxpa2UgZW50aXJlbHkgdGhlIHdyb25n
IHBsYWNlIHRvIGFwcGx5IHRoaXMgbG9naWMuLi4NCj4NCg0KZG8geW91IGhhdmUgYW55IHNwZWNp
ZmljIHByZWZlcmVuY2Ugd2hlcmUgaXQgbmVlZHMgdG8gYmUgbW92ZWQgPw0Kb3IgYW55IG90aGVy
IHdheSB5b3Ugd291bGQgcHJlZmVyID8NCg0KLWNrDQoNCg0K


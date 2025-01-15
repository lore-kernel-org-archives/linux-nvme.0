Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281E0E77188
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Jan 2025 00:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o0vfVFLNlJazGvWXtskL6yoRxvqK01E/qx24xU4XOzE=; b=wT1l2j03fddbQGOSAmXblmiJgJ
	2sb5a3pScbTSkgSHU4Cyanhm/hAmlt49cpRGFH3HX6M4H2AwyJr0dR2BxUvb+5rHvKj68yqS09hJy
	CijcQ4bvjW2AZewYfHHzXfY0BA0AFwFGx1ulY7AE8lScizcJDZbN998h2fwOwhi6mHO70MsmQVu7p
	1uE6u/JWJnzcvzmliMa6OyQL6hw0jfZ2qAdNBf/w0URR3f5JUxu05+u9PZ80wZCh43iVqWc0EjHae
	pBoOJz8Ou72887t31ljjkyKwDfnv8Mj/gSjuY/gBDM9CBwnO+41mLa8DUrsHENrZ9jRZREtM0mlo5
	n13fGFaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXriQ-0000000AFAs-1CJD;
	Wed, 15 Jan 2025 00:57:02 +0000
Received: from mail-mw2nam04on2062f.outbound.protection.outlook.com ([2a01:111:f403:240a::62f] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXriN-0000000AFAP-2xKR
	for linux-nvme@lists.infradead.org;
	Wed, 15 Jan 2025 00:57:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OY12jyJQn4mVa6NVedYNP+S0ZlgUMzDP6QvhL9pq+sN9FuN9JAb1Juq2FxOSuCZ5Sx2YOfY6Acgys/ymQZTJIIfKejGqT4kHiqBI4wX1RE/4T6B9znrxi09juTjuOJkWHEgjnms+jRM8fPD16LaH2UQtMsK2tDTpB52s+KwHTWj2DDrXbvCnJODD9W/HOrhjpb7v/XdrvubSrmWZYA2V/tJMs95FDTuIDw5thp4gXSa0987dw1eKHm8uaWXZk4uRHSVE3qilqzk4Qk32Qn9/3f5iN2QDaZ1B6LaIG4pk0SveTGDFTH9RWmwOOLrut6BaqRxAmi5SQ/tff5Y33Xbr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0vfVFLNlJazGvWXtskL6yoRxvqK01E/qx24xU4XOzE=;
 b=FHQLkNqjH4XX0+8FHFT2NRc50M5mU9VEsyRxA9Uns9d8QDV5+E7eLWVg5RwQMBtAOvy9hTuw+KbZTeBZkd/HWmqPaz5/AjbtNBMwb4GxNNK/AmGAn6UME0UZ3Sw1hU6k4l6YUlixx5rg0/Z0Yf3C3BG7srOL2ICsGNMnk94VBpY7apfvTGvPj/GiIW9P0hplv5Jt0EjsD/pUIon9xTX7+rR/qXGyM6FUFP6HLGtvkl+xj1YlxWF18gZfrBjNgKNm/m+UHaR1Je3mAUBGCyvWkOMW1rFPPm6VqSJg+7dYoJA3qI0e851cCTNMFgV9xY7x+3DCPQ8e1rfrONn5Q35eeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0vfVFLNlJazGvWXtskL6yoRxvqK01E/qx24xU4XOzE=;
 b=k0+ySY+9MtvEZM7kA0OuCPUnrvskdXa3r2FDRQkJSRDL4BcvF74qXaOt2s+urfUq5AoETje4wlO4bmhni8JaKIrv5i4h6Y+V0AwfW3Edq758mTUD6tu+LkAMfI7VARsLetGI3aLSYS/GY05zU9CmUwPlufAuPniE8nbtf3V7tVt6olczujZZPrt2Th48foIcBx+YdxuFA82WWfZe/XNIU7zI0y1rqZysmKhTLEaxidHhHEhGfKqmVGuRbrwvAoC/YT5XYbpXgogxQMRx386idp+1R+5CzUVQKb2ooPJM9qWdKpkg1aofE5OukVF+gQKsLCoey5rWdoHUeMTcC46OAg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH7PR12MB7115.namprd12.prod.outlook.com (2603:10b6:510:1ee::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 15 Jan
 2025 00:56:52 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%6]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 00:56:52 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>, Keith
 Busch <kbusch@kernel.org>, kernel test robot <lkp@intel.com>, Guixin Liu
	<kanie@linux.alibaba.com>
Subject: Re: [PATCH] nvmet: fix rw control endian access
Thread-Topic: [PATCH] nvmet: fix rw control endian access
Thread-Index: AQHbZpo8ujEY/cSKaUyfQH5ArkStKrMXA4UA
Date: Wed, 15 Jan 2025 00:56:52 +0000
Message-ID: <f372c266-51dc-4301-bc01-d832365363c7@nvidia.com>
References: <20250114153653.797604-1-kbusch@meta.com>
In-Reply-To: <20250114153653.797604-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH7PR12MB7115:EE_
x-ms-office365-filtering-correlation-id: c6a775d9-5bc9-4d18-b76c-08dd34ff8008
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SXFBUlFTenRIVUtrczJRSUt2cFd2MU53eXFYRUVubGxKN1FzMDgyRjNSTFVr?=
 =?utf-8?B?d3R2bE1tUlVkSEhKU2tLVVh5Q29kcDdLOFFwV1J2aUJaVllodFlCOHZZNDBZ?=
 =?utf-8?B?SkZQa29lT21XcUJqZXNKQytWcy95UWg2MEtRRXJUVFFmS20ydnZMZy9VbmRr?=
 =?utf-8?B?Z0ZwNFhCa25FdnBYQTYyd2RBNUZUcUtaR0NFR21YMnMxQVlMOXdidzdMVXly?=
 =?utf-8?B?RkRKR2p0eFA3N3VTOU85bGFKSnZicUxXTW9IUW9YdkUvM2p0bXArRXFBSUor?=
 =?utf-8?B?d0ZQdzhWajU1VmhZZXpRd3kxU1dhRnlqangwa1pYbWw2U0FhenhSeFRpUTBH?=
 =?utf-8?B?WXN1U2tsMjdQOXVpOVdQQzFzbTFFUUJaampkUGt1RFhOb0VGc3dnU3NtQjJw?=
 =?utf-8?B?Vmx6MkM2L3JjS2kvN2sySVJ6ZmN2RS9pNVVvRkJBNTlQOHM2TmNPYlVyeTdq?=
 =?utf-8?B?eW1RNEcvY3F1Q0tyREY5bVVROFYwbzZ0QjVrUnkrN3FYcE03U2s5SzJ4Y3Rw?=
 =?utf-8?B?cFNTZFB5Z215Z053NFU1eW5LaEdkUzdFMXlDa05nRkt2K1VvY2NxUHVRa1RV?=
 =?utf-8?B?R1RGejFIVXVOaWhmekM0cEozWnJsNDU1bmVRYnp4Kzk4ZTJYem5KUjhNT0dP?=
 =?utf-8?B?VjNTdFVVTjFyVk1kWlBxZFZKTnBUMUdWUlhYMzR5WVkzbnZpeE1yeEdMTldK?=
 =?utf-8?B?TXlsS0twVWtUSWhQVjhoazVkbWI2N2JSZTE4RUJGWFE5c3pZeUIwVWxRMFg2?=
 =?utf-8?B?elFqRUpucVFvcG5xa3FraWwyRmZqMlJPT0NzMkg3YWFHN2ZQWEdqUnlWM09Z?=
 =?utf-8?B?ekhFZ3E4OHhBdTRZTDViM3MzWWZVRmVjeElzU2pja1VsOWkvSzVRU0dRaiti?=
 =?utf-8?B?SEN2SUkvTFZBdGlFUmxic29GODREZWZEOHlQUkl6NlFuVTFyK1JiOG9Vb1o3?=
 =?utf-8?B?M1hET005N3pEeklRRXpkNUd4QUFnalVUODBtbW5HajJGNFBSVmhEaUJQbFR1?=
 =?utf-8?B?NXZFaHl0NGh3MStNeU1NM3RycFhvU29GZkFLUjVzZnovQnNld3lPeWRUUC9Z?=
 =?utf-8?B?KzdtV1BHWXpQb3YrcmNoSG9yeGpTRUFsSS9NNUlDaENFMEt4T1Zub2FRZWZM?=
 =?utf-8?B?Z1U4UmYxYVpFR3pRTUNzMW4xTGlvdzVSeUh4Zkp5ai83aHlScktrdG1GdHpD?=
 =?utf-8?B?UExQSWtOT3ZoeFdzV1N1NXIvQnB4TnFoZWl1QXEzVlNXYmFSTlhWMEo4UTgr?=
 =?utf-8?B?U3RjQjZSMkZTK0NYYW1jM2p3WlllK25JVVVjRjRscUhxMHpqRXdSZXFqbWVm?=
 =?utf-8?B?cUtrcG4vR3JTSXptci8vQmkybHpaM0h1M01NNnFxZ2RiOHhUdEkwa0VuODBE?=
 =?utf-8?B?VUhJcERQazgxcVpxR3R3Y0pMQ3hVQ3E0a2d1MElMUysySC9DeFNZbk5oNUNH?=
 =?utf-8?B?bEM4US9RVUFob25vOFRIRDFNaitYUFN6a2ZLT2lDRlJ4MEYxTjB6Tzh0ajl4?=
 =?utf-8?B?TU5ndzhEeFBldm9xRWw0aDkzSjM1R1VzLzNpRW5JZ3B6Tnl6ckdlZmRMN21p?=
 =?utf-8?B?OHdGOEthQnBUZkwzc3JocWV2cWZqMmZMZDBkQVdnbmxWbGI4cENnSEpkK21X?=
 =?utf-8?B?ZWgxWVpnaXJ3dVUrZ1ZTK1lPSTBiVTc5dlFHWFJZNStveldFT3VnK3FkWlB0?=
 =?utf-8?B?UEE2ZE1xdzkxY2RmMjkyT2lpYlVOajBxd2xuN3Z6K1lTSERBMytzWlI5TkFE?=
 =?utf-8?B?NHNNNGNnYXRDeFdzS0tSTCtXRStnQWZzWmIrRTNhL2VISVFuZTVTQzlJTmR4?=
 =?utf-8?B?cW5oNUE1R1duSWdPTUs3U1JYYzV5dzlPWlF4V1IyV0VKamNwRUpydlUxbGdO?=
 =?utf-8?B?eUVWWnVINjZtZWltS2xnSkhWVWplMWIzT2wvR1VyNDNhSG11UE5DUHlSOEJ0?=
 =?utf-8?Q?qQV4YO5xEKaWcq/KRT8cmCY8pfgYsIBm?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZCs3ZjVlMExuNnFtRVZXVi9KczBCcGl2c1hVZDVoOGpkZ2c0YlRJc3RETkRy?=
 =?utf-8?B?bVU1d3dnSkZTZFp1UGI5RkI2WDdVc1ZPUzhaamlid2gvTHJveUJQbEYxdjc1?=
 =?utf-8?B?aWh0NDFJTzJra0V2TWVmdjc4b05zNjV2eWpPYUhFNGxhK1dEZUM1a2JoQ1p0?=
 =?utf-8?B?V09IT2RGa3FZcnpjWXJzbWZpbWhTSERPUVBJSlBkaU4xYVBocGhmVzEyZkZN?=
 =?utf-8?B?U0tjNm5uRGtpQWNpM3ZELzVrdU1LSW0xWjEvR2tpMUpnazBQeTFaWWhmOVpE?=
 =?utf-8?B?S2JSVzUwQWpRVFcxOUx6M1J6UXBHTVNYRHhIVUFZRTB2dnlCOXJvNEdVSEI3?=
 =?utf-8?B?STlqRkZGWksvSnlDdHB0dFNUZEZPNGExMnljSmE5ZXRIMkJUMlMzcUJ6WUZT?=
 =?utf-8?B?Q0QzeTFBaHZBMmhEV3V2VmthWHdnaHZHRUZPTEpOWUsveFBYOHVlVWY1WGtU?=
 =?utf-8?B?UHJYWjBPK0ZuOFZnL1g1WGtaTTQrRUpiVFM5VWIxUlZPMnZTU2pyTk12WTl5?=
 =?utf-8?B?cXNJc29QeHFYRjZaOEpBYzFFb1p0ZHVZYzNpT0lWckdqY0ovTVVJanRXWDIv?=
 =?utf-8?B?SVVzRFp3YU9CWnhxNFNxczhUM3dzUWpWRzQ2SHlYSy9yanY3K0g5aURHakpw?=
 =?utf-8?B?QzBYdWRnekdPWDVsRVJPZGp4eWZiaVE0Sy9JQWxjVnBwRGQ5dHRWVzBKaVVE?=
 =?utf-8?B?bU9Eb3NWSTViK2g3L0grMjVudFQ4RDZTZVV2Y0VieWpYWmlSOUxXUEV3Y0lY?=
 =?utf-8?B?SXV2VkNaSVJHVTcrNmlvdlhTeFdLNEkwVlY5c0xTWmVOcGRBc2hOY2gva1Rw?=
 =?utf-8?B?SmtGYVdyandqZFdIV09xaFMvT3NUS2VqZ1h3bUhTdjQ4R3hURGpaVnlCalFQ?=
 =?utf-8?B?b1ZIWm1oSUU2ZnBqNFQ2QStLWnY1WWRacmJWRTNTTlRuaDNHVHZ0RjRrWWRF?=
 =?utf-8?B?V29UVU5BMjJLcm9QVDBqZGVYOFloaExObjdIZ0FJN252d2NQbWorRDExa3Vt?=
 =?utf-8?B?Y1laSzRNSHBJZksvTVJsSE1EbHEvZ1JkMFdtWDg4aUtoMGVHczdiSUJBRGJj?=
 =?utf-8?B?WnFRY0h2WEwwTDk3OUR3VDVJUVVDdGp2UFlFRFdNU1BPd2lJVE1odEphTHFj?=
 =?utf-8?B?aXg0Szg0VG9lMHY3L0pLY1J6SjljZ05jbHRVeHV3SWJvNi91c1pkSXEvUWo5?=
 =?utf-8?B?d3NINHQ0SzhxT2VjTWJ2VEhHSS9LUmNnOTZCbU9tZ3UyanJBK3NXNFVna0Nj?=
 =?utf-8?B?NVZNWkRwZVIwbFQwUlZNaDdNMHJRb25MM0RPTkFRNmxyNiszc2toTWZQV0ZP?=
 =?utf-8?B?OW9YclR1TWd3UTFOZjZReXcrTGJpcmZpNUVIQTJlL1REbVN2dGNHMDVHdHg2?=
 =?utf-8?B?ZlFLMStGWGlqNittd0U1OVArZE9oZDBJa3J3VlVhcUovNTlxOHhIcXl3UmFZ?=
 =?utf-8?B?ZjBOaUhKcncwVHVkeFRxR1hnbEFaaVVSTDJnZ1UzamFmUlcrYVExd2FVM0ha?=
 =?utf-8?B?Q3laVXNwN3BRbFpZVlJpeGZOSWVheHNPZDV4M0xpK0pVTG5ZMHZKNHBjV3Q1?=
 =?utf-8?B?TkUzWkg1bFoycHNqdXNkZForUHBjYjQzeEl1WHpEZzc1UWphRlVsRk5IVm0v?=
 =?utf-8?B?NFF5VFMrV0FTVEMxcC9GMy9qUDZXeEFYd1ZEYzJKZmZNbVhEZ0JmZmNkUGxm?=
 =?utf-8?B?MjZCNDg1V1hmelF4ZEJzVlkvNFdMNEQ0eWJ6ME9MMU5wRXQxbnc0aXp1NUJ6?=
 =?utf-8?B?YS9IZGZmUzNVMU16aklqTzY3ZS9IM0JsbFFvNlBBQjBEWlZIeUYzVmYvb1hq?=
 =?utf-8?B?eS9uOHVtUkRwVWdlSVYyMFp2NzUwR3d5cG9GTjlCWE5vampaTGxaNWpOaEpX?=
 =?utf-8?B?MFpVNUZOQlZwWm96MVl2NFR5eTdpZkZiRE9hbzZoSFFaUGkrMi81czEyUWk0?=
 =?utf-8?B?cE94S2ZVZDBSVFJYNjJ0Y1lLMExUU3NmQUNFZnU1dU1yL3Y3bFlUNERRVGFq?=
 =?utf-8?B?UEFCSnJ1MVArN2pVS2ZKdG4vUFpqSUxWSmRWV3RmTHUwTlBvWmU1ZVJ0VStP?=
 =?utf-8?B?OGRqRzFQSzY2U3BDc2p4UUxybUJyN3JheFVhQWxSa2FiRDNmOFB0emhuSG9U?=
 =?utf-8?B?bUc5M2l3ZW5lL2hoVVlEd0t6Q044ajFhWXhKd3g5bTV3cTd5TVVyaCtKNnpR?=
 =?utf-8?Q?cdajAH0ftCW88x4q2AGfg7NR2RNJL175YgDm07hM7y7E?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4AF581880D9B848BEFAA9619BABFCDA@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a775d9-5bc9-4d18-b76c-08dd34ff8008
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2025 00:56:52.5587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: POm20fv8Asp9kIFmS9yG4QaGqJNc3qbCCFJAnmolVZ1usUQmKQ0QyWwQKb0mMGnZ41I3YtM8ykGI09Hop+c1mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250114_165659_747858_811F39C7 
X-CRM114-Status: UNSURE (   6.83  )
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

T24gMS8xNC8yNSAwNzozNiwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IEZyb206IEtlaXRoIEJ1c2No
PGtidXNjaEBrZXJuZWwub3JnPg0KPg0KPiBGaXhlczogM2VjNWM2MmNmY2YwNjBlICgibnZtZXQ6
IGhhbmRsZSBydydzIGxpbWl0ZWQgcmV0cnkgZmxhZyIpDQo+IFJlcG9ydGVkLWJ5OiBrZXJuZWwg
dGVzdCByb2JvdDxsa3BAaW50ZWwuY29tPg0KPiBDbG9zZXM6aHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvb2Uta2J1aWxkLWFsbC8yMDI1MDExNDIxMjguV2V4Z3lNVHYtbGtwQGludGVsLmNvbS8NCj4g
Q2M6IEd1aXhpbiBMaXU8a2FuaWVAbGludXguYWxpYmFiYS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IEtlaXRoIEJ1c2NoPGtidXNjaEBrZXJuZWwub3JnPg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdl
ZC1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E2DC021A0
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2025 18:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=plRqkTOIXZFXKIowjmO5X2/A3Ccb7Boui/K0dzhK/G8=; b=OOGNkusO8x+G5yeaM14li5tn2C
	5F3uhXsQQYkZo+dA0tgP4bxONgomcl1gldW6k6fX/KJAxKoWwxRkLb8pt/3dltwtSf7zerPl1gfvo
	GLUAjAo7fMovFkQEb6HN09eReUb+l1wfnuoz0gKeA8KGerlESdyzAyd692Yu28GpdUvucjYA3tKwv
	rbTPpz5r3GMyLo8iTEvb/2iLKmXpDLcQc7VNKiWIGfuB6ZG9LC+zkVs9JZOtrK6ZbdunQTUj0B8AC
	wzHlgaCSbBJyiME405IdCKaoCpT4l+tFCzGhMcZSFkSUA6Wolc/18qCc/E1jcIOnSMitvdeJVAb4M
	EL/+aAgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiHVC-00000008TrT-3ci7;
	Wed, 12 Feb 2025 18:30:26 +0000
Received: from mail-bn8nam12on20620.outbound.protection.outlook.com ([2a01:111:f403:2418::620] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiHRk-00000008TIy-0cQU
	for linux-nvme@lists.infradead.org;
	Wed, 12 Feb 2025 18:26:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQGyRMjDYGPV5D2eZwK5drp/HCaAiFe4wdXEIPF5W6rV1hYr9icpWa6I1LTk8QEUcci89l0tuplkb0lkmdAqEOFHy0SYmVYdOTU9qJj6p5g3ZD9amtgTJUGZL5AokvZskHHR0yDaTc0WN9wg4FvxHM+zYOVdZpW0EqSRBoPX0gF0nE9r2CyipmD9EO6EGYz477gciDcSOW0nx4U4bop4nihwbwoNnTzdJ20oSEA93/7mMOd6qL8FietMYbLH91lxfzXoE5VVA+CVYcuTCNRUpKe4GCxAGiBnTow8eb+cqsnuW9JVb1k4dN4lSQufwstU5bMgqSFU4uJa0GhzbZugCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plRqkTOIXZFXKIowjmO5X2/A3Ccb7Boui/K0dzhK/G8=;
 b=iPQwljbACjYjjYUOl7EDhbuNt83bfQyPk+DnlLKzjQLCE8ixpXh1BZE8BV9nXnewgV5oGS2TwMhF99l2cCZV4wfCiZyI0CWajSwfyfX/JR44icyn3/jjkfmfrQLGBrdo6uo7eTy1gb03O9bKX0yyEdUgUoV6KXrpN3rTXNIZYM49a2gYOdt/PpxFujaXpvgjNzymtl+OGASmlNhKV5NL0AIDwHvLHFb1S6lY0z4iluw7BBIKEeBLgQrnN5OQZA8IL44NskWynvx+060zo3EH/mKdvw86xh8w8tVAJCrSoE/TRdDomD+AUIzFtDw6B9iKwxzYfxDl6Js1jEsxtRQWoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plRqkTOIXZFXKIowjmO5X2/A3Ccb7Boui/K0dzhK/G8=;
 b=sA5eMZHDNQEoSohbiKWhIGS4UgsnRZUw9sEyf0ecnAdgq4sKyFNlE6GJfPDgcUrM3tguz3jhJHCQ/l6jGIn9Gr8IZctYzFXdPYEcliKITZBRnyyprGI3id8G5BDAgDCMQyQf1VBP4mb0Vj6aQTcjFbB3E4+nxhKN8XKmD5OMtOefNZ3uQ12y000kg4S/dMM34/3Cc8kJsu1WgqUitmSr3p5+hiIdBlgZLjuD9PWOw3CBIVQlhrRNUKLd6XW7sGZCAc6GxSJDWoxVrIk/kohqHi/LXcodVaSmfJTTe6UrpEfGELQlFmezYXeew0mhJ+yVI+UksE9Wy3X/YGkTfivgaw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DM6PR12MB4331.namprd12.prod.outlook.com (2603:10b6:5:21a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Wed, 12 Feb
 2025 18:26:46 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%4]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 18:26:46 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Damien Le Moal <dlemoal@kernel.org>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvmet: Use enum definitions instead of hardcoded
 values
Thread-Topic: [PATCH 2/2] nvmet: Use enum definitions instead of hardcoded
 values
Thread-Index: AQHbe1MO4epQ8dP0tkORQMTb6JOIqrNEALCA
Date: Wed, 12 Feb 2025 18:26:46 +0000
Message-ID: <e03303e8-9014-4490-a2ea-a53c7fd878ad@nvidia.com>
References: <20250210002935.1744249-1-dlemoal@kernel.org>
 <20250210002935.1744249-3-dlemoal@kernel.org>
In-Reply-To: <20250210002935.1744249-3-dlemoal@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DM6PR12MB4331:EE_
x-ms-office365-filtering-correlation-id: 6243465a-0ee9-47b1-75e4-08dd4b92cec4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?aFUrTmJNZlNDcDNCb3hjUFFlMWZpV2h5dlNndE0vRFNEWHhGTG9MQVZjRk5L?=
 =?utf-8?B?Y1BwMTFyUWZ1R0FBZEJXL3Z0UlA4MWNkU2NRMWlvanJsME1MVlgxblVpZ2Nn?=
 =?utf-8?B?VkluQWY1dHV5Q2dkbk1BTGFVTm9KczRiU0Z6RGMxM1EyWWlwb2t5bnJmUFpH?=
 =?utf-8?B?aWpFVEtmQk1qTnFrZTV1UEk1S2laYkV5a0grMWhUN1M3Nkx4Qzg4UDFic3pY?=
 =?utf-8?B?MG9wL2gram8zclZ4QlJpbHlleDlDaytIQnhVelZoZjh5WTFDUlZqR0R5MjNW?=
 =?utf-8?B?Q09lQzJyaHZzU3BLSDMwb0JLdnBWRGJReHc2MTI0dW5teWpIOTdDbDIzakRN?=
 =?utf-8?B?Wm9HakluN0F6cEYyVHMzajdkQ2QzWFgrWE5EbFB0eEdUSmxjK3pLYjBXSDJm?=
 =?utf-8?B?TTVoVjdrSldyQTgrV201NkY5eUtTbjFRbkpPeXV6WXQxL29tRWhmdVpZYkor?=
 =?utf-8?B?VXpJWWdPVTJ0ZnZmbm9uNzRBN0duYWhSaS85OXJHeTlnMmNXcnFrbHQ4c252?=
 =?utf-8?B?UmNlR0Q4NUVzdkRPMURmR1Yyakg1OHloTFRHaDd2ZHBaWlhWeFF1bEg1TS90?=
 =?utf-8?B?Y3RuYlU3TkNKc3Z1Vmw2UWZkSGg4YWhweW14S3hxR013VzkyVEkyY0lIMmpH?=
 =?utf-8?B?R0pwcVJlZlR2dmpvRi9NSjJucCtqQmdDVW5pSVNnVzNEcEt0QTQyM0NlQ0lu?=
 =?utf-8?B?RlBrUXMxWm95ZmVQK1RFVGU4VEtDU0UzY2VJWDJ3b2w4RTkydnl1UUM0YWJN?=
 =?utf-8?B?dm9Pdm1VaVJDZkxSYllNcENLbm9GMVhGeXBzZjU5NDZ3cE1TeWk1dFhyUk15?=
 =?utf-8?B?ZmlIRE43OEh3cW5ETGdoaW1JSG9rbGNPdC9UYzR0YWVnUjRsbjk0RHh3OWdh?=
 =?utf-8?B?THh0SDdCRGpUelVVRko2WUMwVXJTZDlQVmZHcDM1US9Bak9pWHhValVUVTg1?=
 =?utf-8?B?enhVSFB0S2YyTGZ5bnl5aUR0Y0VRU0tLT3Y5L0VlUVRvTEdtTFF1T1lPRjNi?=
 =?utf-8?B?QWVpRXVQQS84QUZaTlcxVHBsZVB2VDZ4b1ZHbXIxMm90amhnTDRxMk8xSnpl?=
 =?utf-8?B?a21BZFoyMEVhZXZrcGF3OTVuZ2RxYzFNa1gyMkk5SWNUZU5wdk52QmttRmdu?=
 =?utf-8?B?WU1xS2cxZk9uUWhsY3ZNUFdKcTlPNWo1N1JJcVk3WC9uYVJENE9OanVWa09i?=
 =?utf-8?B?NGsrQVQwZlh5czFNWFpxOVMwTDl0YmYzN3ZubWdXTnZLUytnRFEwTTNsMEdB?=
 =?utf-8?B?YmpZa2wvNHRHYXpWMjRiRzVXTmlpZFZBd2hjZHBuRXJZVDRyVHdXU3cyeGxx?=
 =?utf-8?B?ZWVqSE55cmZWRVN4K3ZxbHlJbnZZZGdud3Fpb1ZPQUxWY0RkRFcxQkxrN092?=
 =?utf-8?B?RmdDR05ZQTg5VVRwQ1RzRVJ6UXFnY1NJSld5SW83YWN6ZkJrRHY4Z2JZQWRs?=
 =?utf-8?B?S2lhT0JlS3gwdjVYVmYzU2MwTW1aTi9oU3RsbTV1STdpMThtWCtlTHYvTmFi?=
 =?utf-8?B?eFFFcS9JSG84MC9DZGUxQ1l6VWppV1Q4UmJBVUExbnQ2TS9mL3kvNFlrTjhu?=
 =?utf-8?B?Y1YxT0cvT3JjaTV4a3NWYzRnSkxJTllDeXJsZDBOSGIzYkhqZTZMRW5KeVpa?=
 =?utf-8?B?UW1COFBnMzhHYm4ycDVzMWtKRVhBMVNvcnJKOHhaOVc0ZzBaa0NtbEtSViti?=
 =?utf-8?B?bG4yNUdHa3EwaDk2b2F6UmpHS05kZkRxdXR1WGhGdkZ3TkZQWFJwdXNTR2pW?=
 =?utf-8?B?alhpV3MxK2sxVG93VERMVnJqdkFKcXl2S2lsTTlDU3ZxbjlCNUFWVnJIVFpX?=
 =?utf-8?B?cmdsOE5NZklIa2ROU2p3OHIwZHpzYy9sQ3Zka3NZNnE5QU8ya0IxK1NBNW5D?=
 =?utf-8?B?NkFRbXY1VnVUVlNNeG14L2pZcSsyN3ZZdjRSTlRWNTg0TzRTLzZhY0Y4cWpu?=
 =?utf-8?Q?+XVd9OdwobA/winChSuGI64ZTxZklUWP?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1RvcXdFRGVmdFNuRlhkOHVGTEVwNkd4cjFNcW0vRU4wKzFGSFdFWWNYTTl3?=
 =?utf-8?B?d0xtSkVBUXdoY1NvYTdtSWx0b0dLSmVZeWd5UFZ2SDZZeTlWdjg2U2VmZ1BT?=
 =?utf-8?B?ZEtxaE90c0t4di9GNnJGNzhnUUdwbTZ1TnRSbE1PaXMydDlqekl6QUEyZjJw?=
 =?utf-8?B?eU1zejAwVUxKTlFvaG9FZDFGYWFPNnY2aUJnMHZnbmZ1MTkyOWJnKzlXRW90?=
 =?utf-8?B?RE5yZjY3UmFHTllmVFR2OTh4V1VaWlFLZ0lycFFSQzhMb3IzVTJQbEVaL2U1?=
 =?utf-8?B?RW9mM2JueGg2UXFzYVJnRXgybk5maUk1Mm5rZisxek9pU3VocE1NZFNnYmdz?=
 =?utf-8?B?YnNxMFRuMHRKNFdEdjJPbDQ5czhTMXFRTzdaRi95WVA1ZlErZFBjTGo2S3pC?=
 =?utf-8?B?VDI3eHpHcTFSNzhBRG5kemF3TmtkcG5HU0JaZDU5dlZ3eWtUYy9iMnFuYVVk?=
 =?utf-8?B?RnZVd1pwWHdrUUxoR1ZTTkxwTGRTaFNjOVlLc3krNm1IK0lNUmRRVnhobkNF?=
 =?utf-8?B?UW5YTTlnUGtiOUVIR2tBUzJpeDhZTkp2endRUmM2M2x2K3JYdy85RjRKSG5E?=
 =?utf-8?B?R28vQ3NjeW84Mk1td3JwSTFCUVFabXV1aXJkbTN1b2VBaklRTDQ3MnpBQlJS?=
 =?utf-8?B?ME8wV2s1UEZ2S1Q1dmZPR3FlYkhmckwzTk9ucUJ1eU9hNWtqWjFHOFl4RFpx?=
 =?utf-8?B?alcxbTcwNTU2dk9OY0xldjl1d241by9tZnN4WDhJNUk3RVR1K0t0ekt3MURi?=
 =?utf-8?B?QzNTbkpRTTJnTUVUVmI0Y0xOVFVmUzY2MnQwdjNQTTFKRnlZQitkZnFvczYz?=
 =?utf-8?B?R3FCV1pqbER3ZWJzTWVqaTErSlBuZmxiK0tRb3RCNDdmbXF5V0Vzck9oOEhM?=
 =?utf-8?B?a3ZzREhvc0c0YlV6MGZJejUvSmtPUzhSVGxiRUxQbEsrck5JQkRZTXl3TUIr?=
 =?utf-8?B?SmdzNWRxY09FT0hHT1RXaCtWS0dGa3I3NU5OYVl6UC9kcFIxc09GMHJobG01?=
 =?utf-8?B?bW9Nb0dVc0dJZnJZNjZ6YmVZd0tXT3FLTkdWdjlSbDNPcU5lUEFqaUdzcExF?=
 =?utf-8?B?dU1xeXB4RCt1ZWpYdVpnSGcxZlpCRzlqQzJlNHMydGNjMTNvcGhXOUNOZU1u?=
 =?utf-8?B?OExTeDJ6OGJGQ2JzcEorZyt6dDVBdWZiUTJEZkhEZWJxNkwzVWNyalVVL2VZ?=
 =?utf-8?B?aFNwU0FsaGYwTU9RVVhIekVMSWZFbFNGSHJLcktXOGNuVWtVdi91ZFFwSmVz?=
 =?utf-8?B?aVl1aE4rMmxlRXhWT1BndVRkbFBTSnhncTZtRnY3SDZLY3ZnVTl6U2FWM0o5?=
 =?utf-8?B?QkJ4SGt2YW8vT05DSDNJUFdSbmhXQ1RXSnk2WXpYdW5UNlV4cERyUkVWY0Zh?=
 =?utf-8?B?R1Mwd21na3ZVb3R4cXc3dGVoSlZibW55d2d1MzFOcHBrbituQVBiQytsdExW?=
 =?utf-8?B?L25DaVRRY3dVSFpOcW8yaXRNNFpBVm1SbUYyZVJYL1BhV1dHSktCZGc0YnVm?=
 =?utf-8?B?eUV1Z0pJUWR2NzBBc2JtN3FDclZEYjhBRXRtcXpjNGFTRkZINXFGVmhVMTJG?=
 =?utf-8?B?dVZDQmhuVHh1YU1wVG9kcEFpQTViU0Z0Z0hXYXNRSGJLZDdOaGljOFlxS2Z2?=
 =?utf-8?B?ZW9tYTRDZUM4ZCtuSWNSSzAzSjViV0pzd2ZpMjlKQjNEMWN5OVRBTTI4anVw?=
 =?utf-8?B?VW5vek5GK040c0gwM0txNlYxNzVFTDNBWENvakFzaS9ZNTBSeU84Uzh3bVcr?=
 =?utf-8?B?aDBFSkdzaFFVdmJnTEszTk5GSkFUWmlRREVrMEloRW5Xc25kcWJnVmthbzB4?=
 =?utf-8?B?V0grRmRhcWJHT1hNWU0vbmlQc0k1MDBhdTVTYmlmeklLL2ZNRWRFQ0lsb1R6?=
 =?utf-8?B?dUZ0RUtFTm1kYWdVVXFkT09pTmJjZy8wMkNhRWZuR3JzL29rcGE5TE1VMEtO?=
 =?utf-8?B?OC9xSFR6Lzk1aXJHcEFIUlA1anA0b3Z3VjBBYzZrWlVNcXpNSFlsb2Ivc1FL?=
 =?utf-8?B?VFVZZXR6NW1scjJOcUEvek52aXRqMm9jbXJyQlR4eDVOaDJMdlo4QS9vZG4y?=
 =?utf-8?B?ZFJ2cXducnNvbVNOU2FieHhFUWJ0Unl4aVVGbVJhdG04aDZSRTlrRjNlSkxD?=
 =?utf-8?B?elZMZzIzWkRxaktDVVFXaGRmMVlpL1Q1Sm1kbHFXM29KeXFLMVNJbVRJUjRK?=
 =?utf-8?Q?aA2gIN7PX9WtZjuB0jhCg/N3ZjsPXhnAyrflgr6QUlAJ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3634A4004CC4C45AF11893C074AF1DE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6243465a-0ee9-47b1-75e4-08dd4b92cec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2025 18:26:46.2253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3m2XaqbGrSogCDztbPsSBqbh+LXJfWXJyDV7sQ0YyfSnAJKprLYzMOBWP4tqqTq2xd6lmySmqr+VM6/4FnL9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4331
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_102652_185036_803D83EE 
X-CRM114-Status: UNSURE (   8.29  )
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

T24gMi85LzI1IDE2OjI5LCBEYW1pZW4gTGUgTW9hbCB3cm90ZToNCj4gQ2hhbmdlIHRoZSBkZWZp
bml0aW9uIG9mIHRoZSBpbmxpbmUgZnVuY3Rpb25zIG52bWV0X2NjX2VuKCksDQo+IG52bWV0X2Nj
X2NzcygpLCBudm1ldF9jY19tcHMoKSwgbnZtZXRfY2NfYW1zKCksIG52bWV0X2NjX3NobigpLA0K
PiBudm1ldF9jY19pb3NxZXMoKSwgYW5kIG52bWV0X2NjX2lvY3FlcygpIHRvIHVzZSB0aGUgZW51
bSBkaWZpbml0aW9ucyBpbg0KPiBpbmNsdWRlL2xpbnV4L252bWUuaCBpbnN0ZWFkIG9mIGhhcmRj
b2RlZCB2YWx1ZXMuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IERhbWllbiBMZSBNb2FsPGRsZW1vYWxA
a2VybmVsLm9yZz4NCg0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdlZC1ieTogQ2hhaXRhbnlhIEt1
bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K


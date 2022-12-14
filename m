Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9116EC4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 04:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=isLP5L6MdXkO4Yj4YThMAgu+fnwshRv6iO4QOO28pWk=; b=yJWqh54f56CQOAYjvrwSEU+Ek3
	rFuqVzDk/97hxeybCJoWtpJHCA+LwA75SFBSCmsVPcGdkhWjjGWzXXhSXI8aoIzTkrziookb9LBet
	nZj0VKswc1lbRmYmIRTUPhKvg4LJn5zX//oH79F5Oqa0oJxVlT3Nyc2i3X8GOPRMdPL12hAgAlHlf
	EA//CDXMTOY2rdjk3q65ke6lan6BFgl+fDD6yi/NPxpyzF8B3Q6z+s2bdCTnbxlPHg6aTlxVRvrKO
	MPkQNkGjXw5e9jiOr0Ye+Jif/gO3azpqSH9BvqBS4Bk1lYUp2e2JfZNl4Bvq451KDULW0FHDCVW+s
	I9VDR81g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5Jem-00CB10-1P; Wed, 14 Dec 2022 04:46:12 +0000
Received: from mail-dm3nam02on2049.outbound.protection.outlook.com ([40.107.95.49] helo=NAM02-DM3-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5Jei-00CAoH-NB
	for linux-nvme@lists.infradead.org; Wed, 14 Dec 2022 04:46:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZxzpqBWB0CGCqKdFsM9VS3D1u/R9QbH1L+Kv+B6HJ14NrYKAFbOVJwoLfU4FnQyd3Xh4fr1ddWe/GRvKYrBUmWSqo1vEtMzfFx1fERWmh5Bm9Bc6bMxf9c2zSyKnIUwCGD+qWnoTKWVmuMv26pvbioE0z/AXdr0HBoNLHoOf+C8vsgNe6cMMeb8ZIskBATPtcYPNQj6q5SyQn3BjmdXwvwzj6BcxDeBgcYV1wV1zYgVWaC0j1WTMtnZROXjorF6gM2SRC28fq3ElqpSQHg0t4dpohM5+MNz3Q+8Iianj3h62jrOm6GjElXUjAKkapdUON8uhrFusL9DD2dmtqv2Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isLP5L6MdXkO4Yj4YThMAgu+fnwshRv6iO4QOO28pWk=;
 b=JXze24YSfXxs0Oe+oX1sMoPUKDH0DfiqZQdpywiz8dMqKQuRlB3HqERxNUjpmaSsSAhcffduc6nAFT2imiQbP5UjZjtdXDrnlEdH0lxt4OX/YyJwJklBqa4blp00Saz5Uz/D31alV/oRvnJ6upcOkvq7P1Ek6kRMifD+hwmW4rDsWlztW+B5Qkxq3zlIVOec1/81CwlMSNBtndSPdIGgFgULcBiP/xpsgZvDr1yg7MqO7ZWXbSAaVDjvRT7pLf+DsaG5WCs2y9ue7nSLx9cDE8gR6CGbardUb88CHVU+DjuJEneI8MlFqGPx8Cia3KiwnjXfrBAMhdExsYZEyG4hPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isLP5L6MdXkO4Yj4YThMAgu+fnwshRv6iO4QOO28pWk=;
 b=LPCpzHmXg5XgZ/A4jfj1Nkb3Lup0SNGNo/yEirGyY5TqHjrSOciIsy6H5v4Go9x9o81KOEAEFwjH+VJPEAmMJ+8HyDKjZRMkmsbHTopnNix0ukHEK/3UU+oxD0Qzcti4hXZWgmecOgm5RXyUB096qDDQGzl8NNGuQppRz9WRhBce54nwC+8CmHpGmAogjXY85meYgZ8hkqAjb/wF8G1sZdxGaYW6vJbzdLxfi0LoAt+AKrf7gvTNYCuOBrFvoTXIPp8gYYyCBaYG/QAd3qactOyfhIPxBwNGiPlvc1dgT/s8mdc3MTL5UMToNnMcXl07eZFeSP3HMxPlU2astBvwFA==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MW4PR12MB6827.namprd12.prod.outlook.com (2603:10b6:303:20b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 04:46:01 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5880.018; Wed, 14 Dec 2022
 04:46:00 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: Kanchan Joshi <joshi.k@samsung.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/7] nvmet: use NVME_CMD_EFFECTS_CSUPP instead of open
 coding it
Thread-Topic: [PATCH 1/7] nvmet: use NVME_CMD_EFFECTS_CSUPP instead of open
 coding it
Thread-Index: AQHZDw91/oCyZmvERkC3N+jTjmH+iq5sz84A
Date: Wed, 14 Dec 2022 04:46:00 +0000
Message-ID: <fca0acd3-dc70-8f94-2a6a-d69e372d21dc@nvidia.com>
References: <20221213162453.584965-1-hch@lst.de>
 <20221213162453.584965-2-hch@lst.de>
In-Reply-To: <20221213162453.584965-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|MW4PR12MB6827:EE_
x-ms-office365-filtering-correlation-id: aa462d47-8758-44b8-d6ba-08dadd8e1977
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  IeMVOmm0OSs5zEBBsanUU5JjgrxQPxmADgmIYgz4ZAtIrYrAJ5yT/S8U1cbe0TiQVDHA2vMI/NXTYmeRlwb7YqFh2voT55+sRYPVFKqlYUUQI036o3SPVxFdnv0QqxHsLrhIZdZuJuPze7IvmAR6n822Md1MlLO5LDVzCDoP3LLypA9DI+TpA0RCRcz7aAtcUZVdPeISmSnN4d/BAmBdBNeegq16HF8a/sai6ZArJQLYXsBsKMpvxIiZjWCXucOG+xmYDIHlz1ByhCqA8/9H7Cuo1xIlFcneqGYCrMQFw/2MZ8xtH/Dp7P1DTNI75TYWBwe4xUkFZynybzDRxjJgFfCswfHr6Fk9eFHev6ZDF1g1UDkb5NF8N3D0KJ6n0KAdJ8HCTx4nlV1RPu/LKx2QiBWo161zC3PV+qa3J8mst1Jo5aT60OK4V4saDGl6TnHI9aXOgv8GkPcvdSQXfwuAIbBsbfNxwWgIfDUuF3/2Ydz/gWUjMImXinYgsH0VKawHjFtRR1u85Ioues/JKDrBQDBTfxqRuhjzSYRy3OAnoe2Sjrx/tXoBZaYcNtP0aWI8aEndHV8nPmyFgZTlg7+Dof+3mS4PQYLP8ju5J4P6FtWDOFvYpczo3GQxC/PaJNjZmjdZKNG2ufDU03fWmi1WO/17DeBN2WofTNAkEKmbb6ynMkTb2gNYUdc0hdBw65Go5AwAO8DLWeUQ5jpeAed/B09YpxbsdJT78EpQKnElcWHOmI1v2ute/aIV3K6Gc6eImjW4CzJdgBXVBQ21MErwGQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199015)(122000001)(38100700002)(38070700005)(86362001)(8936002)(91956017)(31696002)(6486002)(478600001)(71200400001)(66556008)(66476007)(66946007)(66446008)(4326008)(186003)(54906003)(76116006)(110136005)(64756008)(316002)(6506007)(6512007)(2906002)(8676002)(2616005)(31686004)(5660300002)(41300700001)(53546011)(36756003)(558084003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?akh6ZGtXQmdhZmVpbnh5a2d3eDhOcHhhWUtrTDBaNTE1QVJkWnJseW9XbWYz?=
 =?utf-8?B?K3NJdEVMdEhvK1U4Y0lVdmNTMjRNQVdjc1dBQ1BiaUxuSURxQlYrQW13TUtq?=
 =?utf-8?B?RmJVNHk2Ty9UaThVTzFHOXp3aWp5WXRrVCtCYVpyaDBVVTU3QkpBcStkSWNM?=
 =?utf-8?B?WlFzeWNDN1JTQmVRazhTeXZldkk0OUlZWHBTMi9xVEVtcHZ4Mm5mZ0RHRHY5?=
 =?utf-8?B?d2c0M1p0a0tZVXFrdksrNXpDbGhnamtJdjNqbWswUkx2ZGZyb0thSkZoZHhp?=
 =?utf-8?B?eGtPeGRMUDJCc3RPYlgrUmlsd0tqRUs4cUZaNEVpMkc5YzBCeVlVNUNzbm82?=
 =?utf-8?B?Y0xjNCtaRHRIaklZaFdzVEZ6aU9vYUdxcUlyVjRGY0htYjQ1MHZBTDlydUxo?=
 =?utf-8?B?MEl1TFloWFpnczNjMmgzc3FoUzBOUFZKbVZaL2NMMnRyTzNlanpqYUdkNkFY?=
 =?utf-8?B?eDUxeGNlM3Y1OGRyZDY3d2ZKNWVJSUhGb290US9ycGNDY240Y0Fabm01VXBE?=
 =?utf-8?B?OEs0K0p6WXZZR2F3Vm5md0ZhRFBuSzRUOHZrY2VwdGlJT2orM2Voamk1TDJh?=
 =?utf-8?B?VnRRY1dRYnExVzdTenJ3VzNJZENCNFV6dVp1OG1nTk5xUUZXdmk3eFQyS2tW?=
 =?utf-8?B?VXpZOGo5UmlOeG56LzJUc3JKVFJZNm8zOHZkZ295Y1ZqTjRJTUJ3YlYwMDRs?=
 =?utf-8?B?YTFsZVdzMWZDdUdMOWRtTG5JRGd3Mk1wMnh4VCs3UHhZQlVzM3FRWkhqeGV3?=
 =?utf-8?B?VWlrQTFVYTFGeGhHQXNGMFhyU1NDOUpXWWg5bnhpaElranFxS1pPS0dIWWRt?=
 =?utf-8?B?cDgyMmdxM3pYLzlyV3JaSjJ3ejZWaU9xYUVRYkdCTEdLN1RIcGRzNVBpdE5P?=
 =?utf-8?B?ZHFNc3JBbTVld3hOZmJxY1I3K0RIa2xBRUZiVUJqdXFMMWNYQkdsUHRDSTAv?=
 =?utf-8?B?VFgrU0Z1akpZenJ2cE9KTTJ4cmUvbXUwdlQxSUp0UDlvRDFub00zbnZDMVRk?=
 =?utf-8?B?Wld6aFlDRm9TUk1HU3VSME9PN01ZeWcyY0pxZkdlMDNRMnV0WFNPNDRrRU9X?=
 =?utf-8?B?SjZlRFNydzl0MElSZUVPNjk4NCs4N0FGM1VvbGhMS1JmeU43R2ZoVVVjRlNW?=
 =?utf-8?B?V2tJdmc3TzJhSVQ0TWFGYUhiUml5MUU2akZQZXZzMGVrR1NvTWUxdG1sUUxr?=
 =?utf-8?B?cy9zd0N0bjBLYmlQOHBMNGlrdmEvMUJtSmNnNkxCYldRUGdSK0I2RGV5Rk5S?=
 =?utf-8?B?Rjl2TzVkcUxDMVprZ3g0aCtlQkVXR2F0K2dPTUoyc0UwNnhzVXUrcFg1eEF1?=
 =?utf-8?B?em9sZHIrR3JiQUMxZFRTV3Z1cEwvUHA3UnlvY2xSSi9rSXA5bm9jRkx6Szd2?=
 =?utf-8?B?VUlVQTlsOUhoSWZseVk4cllKTFBMNzRrMkRGbkMxazNDN3Vya1pHR2FWRTNs?=
 =?utf-8?B?eHhqTHBsMFlOZ1B2QWlpaDRSS0UreEIrRE9NZnB6ZCthL2dGZ0dYQi80WTNV?=
 =?utf-8?B?Y2hnV0tPY25wRFpWVmlFMjFtMGphTTdpK3NQS3RpQmY3N2p2cjliNEJNOFdR?=
 =?utf-8?B?U0p0TERXQnZySUI2UVovajMvb1J5REhiVThxb0lOMDRmUW5tdnBmM2pybGta?=
 =?utf-8?B?OFJrREdWeFJDcm5wTTJQanphdVQ4dDFkWTE1VzRjaUp0cnJFTERLdmwwN3NI?=
 =?utf-8?B?Q1V1YlBJVHpLc0pFM0lldHp5cWptbXYyUWNNZzU5VWVzaVEvOTU0YksyZEJW?=
 =?utf-8?B?eEwxb2tSdzdUa3VzYmJaODhiV3JiVWk1MzhabDNvR3RPYmJBa045QTRoZitS?=
 =?utf-8?B?dnhRV1Uxc09rdkNVNkxVbm5Vc1lzSHVWdFI4ZVBHUDltSW81Q3EzZmVBY0U4?=
 =?utf-8?B?V0dIVzh1OENtcmUwUk9qUFUxSndjMkdjUk9kZHZwajlnQUdmSytTdG1sY050?=
 =?utf-8?B?UGplMW83dzhwNW03aGZ2VmJPb1BKTStkZ3pnT2dCWXJGNkRlMVNzam85YVNL?=
 =?utf-8?B?WUdGc2ZZUHF6aFBoYWYwZDRNOXlCNmJ0Sm9kbFl0TCtjcUJ1OWtSSEFrWWNY?=
 =?utf-8?B?TC9mNmdPSmVkeHhRZnRHaUxNV09Ga3MxTE9VU2tqNkhwQ21HRHpQd1NQYTdy?=
 =?utf-8?B?WFQ1WGwzZDJiYW5naGMvUHdBOTlSd3RDYnhYWE5xbURVRDhackJVZXlTTjBa?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <22E714F1BF8D77479C635E5BAC937A1E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa462d47-8758-44b8-d6ba-08dadd8e1977
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2022 04:46:00.8568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: weXYDxiUhVyEnOyNqjLdm0NF9ivlgHCmiltV0WXe6RJFzw+RMRpI7aMjeiEne1lGBaAg1785hY3AFk9U95Sq0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221213_204608_987891_074D7B4A 
X-CRM114-Status: UNSURE (   8.70  )
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

T24gMTIvMTMvMjIgMDg6MjQsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBBbmQgdXNlIG11
bHRpcGxlIGFzc2lnbm1lbnRzIHRvIGNsZWFuIHVwIHRoZSByZXBlYXRpbmcgYXNzaW5nbWVudHMg
YSBiaXQuDQo+IA0KDQoncy9BbmQvL2cnDQoNCmxvb2tzIGJpdCBvZGQgaGF2aW5nIHRoYW4gd2hh
dCB3ZSBoYXZlIGJ1dCBpZiBvdGhlcnMgYXJlIG9rYXkgd2l0aA0KaXQgc3VyZSwNCg0KUmV2aWV3
ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1jaw0KDQo=


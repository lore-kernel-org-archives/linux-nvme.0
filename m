Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9A9C4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 06:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ghQBFBhRKjzwL/LszZq8RDfGicYiBss8fuig87M61mk=; b=vXyYrbXl6BDLe7LMtgPnfQj0Ns
	nTH3lP8bN8rlvxG49zR1qqXNLMJkat6kM+kNcrcWR9f912DLmqu99dQ4Ux7yaGjs2UbFAm3klMCbr
	QAJrvtTcrjrX3ZT4RlxDVInJjzI/MX5ThtjUd/WYQDhuHEf2BK8/IsUGZSGy4EU0BQ7U9j6eoRRHv
	DmVlx/awrvBQ076PRyLXnlgs8dLV7ZP1tb/oaT+8gP9kxJ5nzQJWkUBkpm7kYCO6zbM3no2VeGaxl
	HGAFnocbNJGbEVIEEtjKy6csOhdZYQtVLZID4GgYcZbOrvYJkuCq2O7Xw31zDR8QF1nPJLQExpHqk
	FvI981lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rB7wm-00BzY6-06;
	Thu, 07 Dec 2023 06:33:20 +0000
Received: from mail-dm6nam11on20606.outbound.protection.outlook.com ([2a01:111:f400:7eaa::606] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rB7wi-00BzWl-1L
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 06:33:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuNRsfke+JKpLEN+oFnmzJVtyXTJ8gk5SWXBlJQlwtyipua7X9RK8Fo0chOx2UtR8AqGGZ95YHIfjCMP/rroJKf7Dtdsq+k7x+ScbHVp+KJoGagohi6l88RA4mYP5orfe9/90NIYhX9bbkNL6qScjri75fGeVEOXevd8TCCeacJAhDHMMJCw9bHd1MKZNcH4Wy/90jaua5KHuMIZjRFXhnK1UcxfUcniW++zLHiwse93Q1fZbL0bu/TTJVkz3TLDsHzvCmoGiurCC3gNhsmQcE1FzritKR6JaS+n/ugmJHOVHb1TL1tlI4DY/wbz/l6IK5SfEuq4YkUZ1O/GNclrkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ghQBFBhRKjzwL/LszZq8RDfGicYiBss8fuig87M61mk=;
 b=KrnRB1ezaqBp7vfTX5K0Kcs9HpSqlwWxBdope/Kqg0NUnZNQILAYLUKfSTHrPGinQNj3m3q8dHgNksvmi9+k0gn7/HRz6DzclBs5DAP/PUmYjCeoCFMG2xKK/6JV2vhKUgRv9aktNmphBPbEOI4FaC0QTWpyBHpR0H8yRi3wReEIVTMp4TzvwH4XDCy1Ale8Ia34pMM2fmFq2QjXTZbpkaSP9gycxba+jWjgZA7+TcZ/afFJqsgK4hmuzj7NStWKEBF43F4Woj+z1S27RfpGpUomwOilfKjukxvvbTTNdeX5YTqnqN19y6ggu9hKLt0BkLJxAR5iwU9LhcSUvYkEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghQBFBhRKjzwL/LszZq8RDfGicYiBss8fuig87M61mk=;
 b=teNWWKyYTox5MEKxM1kCUp2wkJISG6EGg8PvIAQry6RBrHlVblIr5GVDn+ghrV5vdZiaWYp+O35ImFSDGLidqJ0P/ZefQ9pKQiYGDhQEmstO1M4O/yzbnOLgtJYkyWW+/x21zsK6HwlTPtAZYae3l2yBGMuNRuBQrtCFgVDHOUpi2LWjSZgwEjdnqUbdEQwSux6xyFxdD+WDX6fwTRA7prWZgTG1xNXE58zSyvMepaQwUJPfC8IS/UI3r6jZ0KgcVkmW9smkDCddpwG0QI9aOKmKEf0fDu5tXErEQCjcbSISIDZkf1c0tSFceYy0cALzCtw6vu9ULJY/jkIU12033A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Thu, 7 Dec
 2023 06:33:03 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 06:33:03 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	"alan.adamson@oracle.com" <alan.adamson@oracle.com>
Subject: Re: [PATCH V7 1/1] nvme: allow passthru cmd error logging
Thread-Topic: [PATCH V7 1/1] nvme: allow passthru cmd error logging
Thread-Index: AQHZ3GF/546pqQEEskm1xtQBvfX9jLAL0q0AgAEBfgCACk6bAIALSdWAgHhc6YCAAEHPgIAC6l4A
Date: Thu, 7 Dec 2023 06:33:03 +0000
Message-ID: <403fb6b6-33d1-492f-a599-88bb3a568a75@nvidia.com>
References: <20230831231827.3896883-1-alan.adamson@oracle.com>
 <20230831231827.3896883-2-alan.adamson@oracle.com>
 <20230905065348.GB19754@lst.de>
 <9d199a50-9f0b-a69d-4061-d443e6286dba@oracle.com>
 <bb57e86e-654b-a4b1-e60a-7573e59c30ed@grimberg.me>
 <8ffd46aa-81f8-4b82-9bfa-1753bb7610c9@oracle.com>
 <a2ce93a3-0427-4a37-8c1d-b70eb34a23ad@nvidia.com>
 <40bedf74-e09e-43a4-bd05-e529f8fdd84d@grimberg.me>
In-Reply-To: <40bedf74-e09e-43a4-bd05-e529f8fdd84d@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV8PR12MB9110:EE_
x-ms-office365-filtering-correlation-id: 08ca4f70-ecd8-4eb1-5b93-08dbf6ee5d76
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: coERWZUAlCGlIklw/Z5edr70bsuF2/pddr4OI7m10R6lzlL9/klvG9VtDeczCCrN2mLXIdCKLH/7peA5gDbVBTgZtlggmA0hmSQIZUpLotnZqp5AC07SOvtY4QXW8t0lItXavzgn3YddeadP2V+K+dFgdjYnznjUXq2O1kWmdyVM0FJ8ZUIQoKzKA8Lum5du0hsMJk7kG43J9vBQ7ekYf9esAGMAMPjFtWSBlLCrf5DtKORoJyTZ+mpCjO2qOKs1OW4RuFX1/3HaOUH7RIbaKh9d8goVeRp491WcyomqmTmUEuhd9pbRBx+EIRhj2X2L2qCmfV/zWCLoI7rTlJ3wQXLpwej5B9uZlQUkN2tThzNzf6g0gfV85u8xgvNj6yOCTsV61HUGrjv6cWAlcZG2POfFR0CTyFhSFkyjpS4a4+/ofJMA6WpcO4OgrW0k3O2sxVfSBJ1saG0SmVasTidWJDGvpUU5I/OnnG9/kRKtVsfsJemVeokr5i++7JjzJhYM8VDfvvwS7FxseYOFuUHtx3xXNBFXrDQ8FjzL08s3DnYH8/mHQbW2LvHSB5flpywuvtNTGPCYhYF4eMYUMg8vhaoIANY7A0Ipg7L/quiZrXAXxX/i+pFOrpm4laEDQFWCSy95BwlysRppcXtJlH0lhaB2cTQs9b2uaChNpTyg1nX4x++mlXQi1lo/87Q+BIaV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(122000001)(38070700009)(2906002)(38100700002)(31686004)(83380400001)(31696002)(86362001)(5660300002)(53546011)(6512007)(6506007)(36756003)(71200400001)(2616005)(8676002)(8936002)(4326008)(41300700001)(66446008)(54906003)(6916009)(316002)(91956017)(76116006)(66476007)(66946007)(478600001)(64756008)(66556008)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cUhWeVFBeHREc1pUMndPd0dnTm9NdjRlL1dienF1azdZNThMV2VZVEZHQThn?=
 =?utf-8?B?RGtvZVVxM2ZwTDJ3UmtLUTRUNkxYanBSNnNLVnY3SWUzZTRNa0hsYytkSTlD?=
 =?utf-8?B?SGl4Z004dlg1SCtTTGZPMEJ1WmJ0bzhPWkhYVnJ1RFpwdHdZTE1YZlFUTjNp?=
 =?utf-8?B?MEtLL3dtc3BDMjk5WlY1dnJsMU9jRDhVbVJyRXZrVThNWEpxZVF5ZUE2ZEUy?=
 =?utf-8?B?YkpSNlFMd2VCdGZDUFovRFNnYzdkWWlrSjlxN1dNbWY2VkN0MTRadlFnbG9S?=
 =?utf-8?B?aDl1SmE3RisrS2dFOUlYUUJIY1FOcWVOZVEwZzdBWnNnUGFtQXVEVzIxUzNV?=
 =?utf-8?B?NTEyK2dWcmdITTQzTjhHY3Z6YmI1bitTamtXQVhQOW5iaW9saTBlMkVxdWVX?=
 =?utf-8?B?SitvS1RoZC82RWg3YTJ3bUU3LytSNFdkVURwMUhldkhmVDBYNEcvTUxKTmZ5?=
 =?utf-8?B?eG5TajRYTFBLV0ZTWnBSSTdHNkI3OCtqU0pac2RkZnJEdCtTdElGTkFRcTJJ?=
 =?utf-8?B?akR1OEFHdkVNMG0xZURVQ3NrekYwT0tWbUtuMVVCeXFFUlNmN3pPdHVhcEVK?=
 =?utf-8?B?NDBLdHZnajZXSVdXVmEyaGFtRUZGb1FkQlF0K0VHbW1JNDUvRlFxQW1uSWpa?=
 =?utf-8?B?RlUzZUpqVCtyY2wwVHdxNmRkbVh4Z3dWL0RCUXF6aHQxSWY3eEd0cnZvOVFs?=
 =?utf-8?B?YjhWaWVjUWJXTWNaWWZhVFdQWFU2WDR1Zm1MVklna2dtVGJrNlNTQXFXNTBW?=
 =?utf-8?B?bmlma3VEdkhlY1phRjRqOVFTcitBQzZtOC9NY1lPbHBqY29lcWtaOUhyVzhp?=
 =?utf-8?B?cXBCV2Jpdmw1eTRoZXdxM0xySk1kR0JYN1ZUZHozZHVGOEFCV0tYa1Q3YWsy?=
 =?utf-8?B?djZXTEhiWDBEQkh0RlBVWTJ1MkRVcEpBOEhtRHM0R2ZQMWw3VWhXaTdnTTZl?=
 =?utf-8?B?Q0x4bjl2WEpQU05YcC9Ubmc1cGVsNVZMYkpGeEYydlBrclEzNGtsaWVpMWhV?=
 =?utf-8?B?TlNIQ2lHcHF3b2E2bGFNMGNPU3k2cEwxdVJFeS9ORld4RGdvaERlSG05c2Qz?=
 =?utf-8?B?WFpiSWY2d3k2cHpmQjRpOEF6dWxvckc0Y0NTc2MwV0gycmdUTEcxSUplVFov?=
 =?utf-8?B?d2dvK01OTEZlb2ZXWTlLeGRJdlhHc0VEQnE1blUvcVl2VFlSRnp3VDUrQUdD?=
 =?utf-8?B?bndZcnNEdG51ZFhBQWFVcHJMRVZid1dtQmRJZXhqT0tkY1lWSE1za2dLUEtL?=
 =?utf-8?B?RTk1RnJBM0lHYTVWZm81cUJVN0ZNdVhNL2tRNHFaY3FFZGZScEJWMU56Y3Qz?=
 =?utf-8?B?ekZWYTEyUDVjOStmWWVZYmt3enlwVmhwSU9XMXVWOWJuSlgxUndFZkYyakkw?=
 =?utf-8?B?Zm13emoybUJyY3hETkRIZmNoSFJpejBGeUdvd2x1MHhZZVRndTR4ZndIMHIw?=
 =?utf-8?B?YVRkNm5aREY4T1dhRHN6QWFaa1dadldmOFc5YjA3aExVZ28rQjlJcjF5R1BE?=
 =?utf-8?B?ejFka2wvQklqOVRHOER4UW9oVTZNeHpURFRYazNjSXd0Vk9ZRWFhVWwwSzV1?=
 =?utf-8?B?RjBhc01TejhLVFRGM0Jvc1N4VzRWQlhuU3NlVlFoRDdRQTU2MTZrUHVOVVdQ?=
 =?utf-8?B?M2d5VW9TVjB2T1FqMTVhYis5U0hvVUFYUjZsZVdpaUZKK1JhanFqbTBZVlNJ?=
 =?utf-8?B?RVZ3RjdDc3VzZkJmRmlLOUpBUCtnV01ZZlJlblkrck80b01jdUIxZ29MRmtH?=
 =?utf-8?B?MDdwM255Wm9TcEwwbnFTU25BRUg5am4ySEI4bk16TlJHK1FaaDY0M2djWkFO?=
 =?utf-8?B?cUdhUDJJbG9CSHpnMDk0M1hOUWt1Z1FDbjR3UkNodU1qWjdzNDdTd2RDT1pT?=
 =?utf-8?B?TE51UCswOVBGYnRVemFnSFZ4dXN4OHAwNjgxWlkweExsYnZVaHNsMjVxek4z?=
 =?utf-8?B?UThYdEVpdXBZRTZsZklMYk1zQWxLMEdVN3dqcTdSb2V5TjIwejBja1k3TklO?=
 =?utf-8?B?cVppM0FGQUFLUzY0eU5yTVlUTHlxTDVJZ0VEMk9pdDZIQW1zUnRvU0R2bG85?=
 =?utf-8?B?Q28zUTJuMHM2blRhOWVvKzNsSXlJaERDVVNDdUJEeDlUSWRXQlRoSGplQU1U?=
 =?utf-8?B?MVcxTGtpb0I2RjFkMXdaT3F6M09RRHFyN3VXUnRubjNYdkZpOUkyWGhWcXhF?=
 =?utf-8?Q?xEhZgeoy7zjPi6tC0ZK4/fOt0+XunCn3mLNl+pW2v2Zd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9A932146231FC4449E837F6A13FD6F2F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ca4f70-ecd8-4eb1-5b93-08dbf6ee5d76
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 06:33:03.3404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lwVlpMzyfDKVHaGaDnFWsVv/NB5Nw1sEEJSui5lKBEZ41+I2VjGFvO9+Kk9Oyysc3W//5lF65+ISKPSoUiAgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_223316_479170_B2124B9A 
X-CRM114-Status: GOOD (  14.22  )
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

Q2hyaXN0b3BoLA0KDQpPbiAxMi81LzIzIDAyOjAxLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPg0K
Pj4gU2FnaS9DaHJpc3RvcGgsDQo+Pg0KPj4gT24gOS8xOS8yMyAwOTowMiwgYWxhbi5hZGFtc29u
QG9yYWNsZS5jb20gd3JvdGU6DQo+Pj4NCj4+PiBPbiA5LzEyLzIzIDQ6MzkgQU0sIFNhZ2kgR3Jp
bWJlcmcgd3JvdGU6DQo+Pj4+DQo+Pj4+Pj4+IMKgwqDCoMKgwqDCoCBpZiAocmVxLT5xLT5xdWV1
ZWRhdGEpDQo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcS0+dGltZW91dCA9IE5WTUVf
SU9fVElNRU9VVDsNCj4+Pj4+Pj4gLcKgwqDCoCBlbHNlIC8qIG5vIHF1ZXVlZGF0YSBpbXBsaWVz
IGFkbWluIHF1ZXVlICovDQo+Pj4+Pj4+ICvCoMKgwqAgZWxzZSB7IC8qIG5vIHF1ZXVlZGF0YSBp
bXBsaWVzIGFkbWluIHF1ZXVlICovDQo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcS0+
dGltZW91dCA9IE5WTUVfQURNSU5fVElNRU9VVDsNCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlm
ICghbnItPmN0cmwtPnBhc3N0aHJ1X2Vycl9sb2dfZW5hYmxlZCkNCj4+Pj4+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmVxLT5ycV9mbGFncyB8PSBSUUZfUVVJRVQ7DQo+Pj4+Pj4+ICvCoMKg
wqAgfQ0KPj4+Pj4+PiDCoMKgwqDCoMKgwqAgLyogcGFzc3RocnUgY29tbWFuZHMgc2hvdWxkIGxl
dCB0aGUgZHJpdmVyIHNldCB0aGUgU0dMIA0KPj4+Pj4+PiBmbGFncyAqLw0KPj4+Pj4+PiDCoMKg
wqDCoMKgwqAgY21kLT5jb21tb24uZmxhZ3MgJj0gfk5WTUVfQ01EX1NHTF9BTEw7DQo+Pj4+Pj4+
IEBAIC02ODcsOCArNzIwLDcgQEAgdm9pZCBudm1lX2luaXRfcmVxdWVzdChzdHJ1Y3QgcmVxdWVz
dCAqcmVxLA0KPj4+Pj4+PiBzdHJ1Y3QgbnZtZV9jb21tYW5kICpjbWQpDQo+Pj4+Pj4+IMKgwqDC
oMKgwqDCoCBpZiAocmVxLT5tcV9oY3R4LT50eXBlID09IEhDVFhfVFlQRV9QT0xMKQ0KPj4+Pj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXEtPmNtZF9mbGFncyB8PSBSRVFfUE9MTEVEOw0KPj4+
Pj4+PiDCoMKgwqDCoMKgwqAgbnZtZV9jbGVhcl9udm1lX3JlcXVlc3QocmVxKTsNCj4+Pj4+Pj4g
LcKgwqDCoCByZXEtPnJxX2ZsYWdzIHw9IFJRRl9RVUlFVDsNCj4+Pj4+PiBJc24ndCB0aGlzdyBu
b3cgZHJvcHBpbmcgdGhlIFJRRl9RVUlFVCBmbGFnIEkvTyBjb21tYW5kcyB0aGF0IHdlDQo+Pj4+
Pj4gcHJldmlvdXNseSBzZXQ/wqAgV2hpbGUgd2UncmUgYXQgaXQsIHdoeSBkbyB3ZSBvbmx5IGFs
bG93IHBhc3N0aHJvdWdoDQo+Pj4+Pj4gZXJyb3IgbG9nZ2luZyBmb3IgYWRtaW4gY29tbWFuZHMg
YW55d2F5Pw0KPj4+Pj4NCj4+Pj4+IFdoaWxlIHdvcmtpbmcgdGhyb3VnaCB0aGlzLCB3ZSBkZWNp
ZGVkIHRoYXQgZm9yIElPIGNvbW1hbmRzDQo+Pj4+PiAocGFzc3Rocm91Z2ggb3Igbm90KSBlcnJv
ciBsb2dnaW5nIHdvdWxkIGFsd2F5cyBiZSBlbmFibGVkLiBGb3INCj4+Pj4+IHBhc3N0aHJvdWdo
IGFkbWluIGNvbW1hbmRzLCBlcnJvciBsb2dnaW5nIGNvdWxkIGJlIGVuYWJsZWQgb3IgDQo+Pj4+
PiBkaXNhYmxlZC4NCj4+Pj4NCj4+Pj4gV2h5IHNob3VsZG4ndCBpdCBhcHBseSB0byBib3RoPw0K
Pj4+DQo+Pj4gQ3VycmVudGx5LCB3ZSBoYXZlIC9zeXMvY2xhc3MvbnZtZS9udm1lMC9wYXNzdGhy
dV9lcnJfbG9nX2VuYWJsZWQgdGhhdA0KPj4+IGVuYWJsZXMvZGlzYWJsZXMgbG9nZ2luZyBmb3Ig
YWRtaW4gY29tbWFuZCBvbmx5LsKgIEFyZSB5b3Ugc2F5aW5nIGl0DQo+Pj4gc2hvdWxkIGFsc28g
ZW5hYmxlL2Rpc2FibGUgZm9yIElPIGNvbW1hbmRzIGFjcm9zcyBhbGwgbmFtZXNwYWNlcyBvcg0K
Pj4+IHNob3VsZCB0aGVyZSBhbHNvIGJlOg0KPj4+DQo+Pj4gL3N5cy9jbGFzcy9udm1lL252bWUw
L252bWUwbjEvcGFzc3RocnVfZXJyX2xvZ19lbmFibGVkDQo+Pj4NCj4+PiAvc3lzL2NsYXNzL252
bWUvbnZtZTAvbnZtZTBuMi9wYXNzdGhydV9lcnJfbG9nX2VuYWJsZWQNCj4+Pg0KPj4+IC4NCj4+
Pg0KPj4+IC4NCj4+Pg0KPj4+IEFsYW4NCj4+Pg0KPj4+DQo+Pj4NCj4+DQo+PiBDYW4gd2UgcGxl
YXNlIGhhdmUgcmVzb2x1dGlvbiBvbiB0aGlzIHBhdGNoIHNvIHdlIGNhbiBtZXJnZSBpdCA/DQo+
DQo+IEknbSBpbiBmYXZvciBvZiB0aGUgbGF0dGVyLCBJTyBjb21tYW5kcyBlbmFibGVkIHBlciBu
cywgYW5kIGFkbWluDQo+IGNvbW1hbmRzIGluIHRoZSBjb250cm9sbGVyIGxldmVsLg0KDQphcmUg
eW91IG9rYXkgd2l0aCBhYm92ZSBhcHByb2FjaCA/DQoNCi1jaw0KDQoNCg==


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D25C001DB
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Aug 2023 19:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3qm6WjY04LBylhEDOnO436HTp9ZO9Ajnl4wL8vSTwL8=; b=y1NRRam3YbwtnDDN/z0JzNnJwC
	BtPXj/AxzA/UlgLnjxtTcZ6eLN3uNWYvckahT/otA6J/tTAFmwAPvU/77zf9AI59xWIYlObWwlW8F
	5E9v2+I4XV00oY6V1pDwjXkt/2CkRlYjEIUclhNXMEIP5z80pe/weNUlDQ/58wjQv0sGYbKIpSUhr
	oxAijI71gejNgZ2BQOhTBQb0SffF53h7JQyQoeBAN2CMFQ4uzv1GtWwBDILHTv0LCF1FeE1BGvHUk
	y2D+EWuU4NOB2kAagqWA4NURZYTstr3BLckPy1WtwCZsycx39zaiuU2XnAzZj7A+x4Ht93LRAWZLf
	BfXmivBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTSis-003Lto-2J;
	Tue, 08 Aug 2023 19:50:30 +0000
Received: from mail-co1nam11on20615.outbound.protection.outlook.com ([2a01:111:f400:7eab::615] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTSiq-003Lt8-0N
	for linux-nvme@lists.infradead.org;
	Tue, 08 Aug 2023 19:50:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlvCjnPn2CILmXh6k5y0EOgtiVziU2Gepzj0fKDH06/HGh0hZKwb36mfejjMbbRkzXwHGq4k5MZNpbDIvQtk6lYr6eN4PqtJSUVKOJiENcQonrb41XZuNRaqEgjSbbRrhOLewdeCq/0yKyhRSCsgRVOarRozTukfmRpVb9d/Q60i7ffAkb1OPXvQ4avxlxFM41FzVXeIavaJlM6SA0N0gLQyF6yXRDwDly6S7lQexJLLZ4CLmWM15OReL0OatrhoAyumEOH4aemRzUdTK3FrY/Jw/a848Ig9za0sForzZ24viKUPVzd9i5dm4m8lbVXFl7harsemszeib49sa+HLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3qm6WjY04LBylhEDOnO436HTp9ZO9Ajnl4wL8vSTwL8=;
 b=mcw8JpW8zdaVDKIfgXr8ar3rSu5k4cP3M36LMEIzf3yc8oH8FGWF5n40LBrPqzOb/dwmLXRWSwPfhhkeSpQsw4NDlzDHa1+DLqlOtu8EH/v8GDX8H3o2mKCaNXYmo1xkNUp4v1OGp84m4AgGc3ec6epYhokIuGwJ7/UFkM0soQF5mSvIXZfR2YRY8Jf3MIRXoSku02+2iwwqk0fuXFW9sR+lG3MxN2oJ8jg+Z9ykIt/fcXt9U+N/2MFpawr6PlqafPyA8HhyXX1OBjWDGq7IIfcbLdXaZcpjDGqZWWjMC/kbe4xo30DFwjOA4ZUOD/Ee7dm4B5fwqy7ynpohhMrNKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3qm6WjY04LBylhEDOnO436HTp9ZO9Ajnl4wL8vSTwL8=;
 b=Q8HVyK3CqxD2peMdrQWTRVgaXWNrSWJbBQiWB3y5K93uSgNRI2xGE/Zf/0JbGrsl+meDZLArqFgF7fdtha4KN6/MmP2wse97raUtb8nImU30ZKkNjlCoyItoJOoYMeh4PxZ3hZZdgWRgVxw7P3wg+IB2IkVrYBiVPOcK1/Vsqj1rcDokdViJTOqkt6ZlD6ocZiBjDKOcEKBhiWyaOc2TeqUa7RxeIarpfDdpXB2m81oLsvI8ZHLNzXhNzMS7v8OkrXGQxeZ/Wm7cegd9mk6t8joJ7XYjcVtUNHLh15VQeg/up3k4mhb3qcXKWJqlqvbImdQYtYCKLztYbMBNYWv5aw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 19:50:21 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::f55b:c44f:74a7:7056%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 19:50:21 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Caleb Sander <csander@purestorage.com>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH libnvme v4 1/2] fabrics: Read the supported options lazy
Thread-Topic: [PATCH libnvme v4 1/2] fabrics: Read the supported options lazy
Thread-Index: AQHZyfyaovtWcgyRyECnNVFDae2Ewa/gzygA
Date: Tue, 8 Aug 2023 19:50:21 +0000
Message-ID: <0b92f8ef-d4c1-9da5-ec55-1421b7c34f0c@nvidia.com>
References: <20230808133028.14643-1-dwagner@suse.de>
 <20230808133028.14643-2-dwagner@suse.de>
In-Reply-To: <20230808133028.14643-2-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|IA1PR12MB7663:EE_
x-ms-office365-filtering-correlation-id: e21d3726-74e4-4e46-3698-08db9848b32b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Km4wcfyKOz8IHKCixC0Rr69m6c6iD8uUozNYoZvCEhaKGE8qzhxCzQYet/lRiCUzKoLWFfPd6bY6uVPl437RZVQZqJ+Vo2dNe0T1BtgbQGwAlk/g2ZZARgRiinyuHjiu/uS+9jdNK3w2DllybYlxMmnbF0dbR2XHBQL43RZc0HjanMkBGIT2R6DJJPPP50Ali/2HheFHlWkXxT62RP7LeYvI9dHfvFV75NlFHyn5uQvMEHPLvOKo3/Ub0jYvb9bayW/gJPnNVpvV+sT5h5knA9FFhdm37ZJF9sUZMgiuJoYvMPNYCNRqP42SDyRYFO2/Ytd3iEE5vRtTTN/e8gqXjhUw8jFyeE65AeAINzn8m0ubU8EU1BihSC6Q1nKkhb8NMMXqeWQEetMMIVXci/n/83bwq59cJ4H98aGMOllcnmYu4OjQEfghqHUrbKhV9e2sYh2oVDXQRnIBmDZrVkrxGg60oX3vjFEcFW50YyyFnD+T7Qhr/HW1toiJbfOTN5Q2Nskqp34tjT2ynagmeeOic9KTl2wVncMWRbXyEobG/VowmGaHkJ7FHgwyUfqz4Lj6wH1UGP4QpJHmbjzxlDtpdh/3pcLb0+78kfr/VjCJGyjdApVMaPRRmyrZIya8/u5dyENPEj4nGoAgEfpv5IElF5R3MSP+8NfkWOF23iUHmCL1Xyfo5RE4zL34Hoje0eeU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(376002)(346002)(39860400002)(396003)(1800799003)(186006)(451199021)(31686004)(2616005)(558084003)(2906002)(110136005)(4326008)(5660300002)(8936002)(38070700005)(64756008)(38100700002)(66446008)(8676002)(316002)(66476007)(66556008)(91956017)(76116006)(54906003)(66946007)(86362001)(31696002)(6512007)(478600001)(122000001)(71200400001)(6486002)(41300700001)(36756003)(26005)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTh0TGpCdXFnNnc4YVNJQ3FIeUVCTnF3bG5ReVRCTHNkVm5BdmpVeEJ0MzBF?=
 =?utf-8?B?L2FOZUZaSGhNdm5NQjYvOGRzK2pwblNKdTNzN3dXLzFWYWpKd0xQc1owTWhY?=
 =?utf-8?B?bXdaeE5kczFnZnoybzhhWXkyUEpSKzdUUUJRSndqdDdiSkNvVDl2TkpVNkFD?=
 =?utf-8?B?NnViMlpGSXFHYUJhbkJHeUsrd3Y2bmtQZ3Jna1BEUHBBclN1MWZxVlVpRU9D?=
 =?utf-8?B?bHlEM2gzais3OTlaTm1rR016ZmE2d2hkd2M2a0tzaHYxRjZRdlp5UkdZYUY3?=
 =?utf-8?B?T1BTR3RuWG1VY2NFOHc1Qnh5aXdYTUM4SGhxTWk1RXQyeUNLcEtKQloxWFZj?=
 =?utf-8?B?b3dESGFzRUtqYmlaUytMakdLTXl2dzMrcnFZNnJCNDcyWUtDT3VBa0pTWVhY?=
 =?utf-8?B?bWVkUktZdE9hTjBxdG5ZTStacmZjVy81dWRnRXpPL1lxZ0RUTWNESUcwZmlw?=
 =?utf-8?B?WSszRUhLYVF3cUo2eHZtdVpKT25abXMrSjBOcnkxTC9SMjVVZ3FNejZwQVRX?=
 =?utf-8?B?ZHVZWTVTcVhrcWFyL2Z6ak42NzVWWU8yOEFiU01nLzJYb1MxcGJaUENsRCtP?=
 =?utf-8?B?WnVkaHJtSXNXY2JLNkovei9qRWVpZEFYQ1R1VWVtSXpGdkVlQW5NalhsMWdo?=
 =?utf-8?B?a1Q2cWljdE43MXF6dzI0a0EvM21NQVZhNVRMbHh5ZTFHUW9qRDBRbEtPSjJS?=
 =?utf-8?B?aDFFSHRpTjZzVXBhdW1YV1lodEtMSXVKaXlFcWt1UERqVEVvWGhPbFdMdU9N?=
 =?utf-8?B?Z1B4U0FYTXRmekd3ZEFObTFYZHBqamFkTU1QYmxDSDZVNGNTWG11M2phN29p?=
 =?utf-8?B?NjhzQlRUb2lTUlJvUEdmUHlORldoN3cvUERIRCtOU0FOYlRsY1M4SU4vUzFQ?=
 =?utf-8?B?ejY0ZHYzMWRLa0dUUk1NRXVKQkhLZDY3VGxUUVZkZ0FHK09BSFp4MjhvRm5P?=
 =?utf-8?B?M2pZNHdRdnhJMW9vWXhJSnBqMm9lRzZwSWQ3M25kYk9mejhNU3FCZ0VpYkVG?=
 =?utf-8?B?MVFSMVp4SHlSYW9ENXNDNGt3Y3VCK3NtZC9oSmVVODZEdHNrOUdUbXRZbVd5?=
 =?utf-8?B?MEd4a0JYbytqR0xsR3JySDFWbTFGa3lDZ3NBekVKeWVXN3ZZSVhxQ3U1SXpC?=
 =?utf-8?B?YlFRM2xMU0pOUEZVckJIV2JMR0g1ZTF3ZVVRUHN2SUhJRWYxZFhaT0hOK0k5?=
 =?utf-8?B?ZkVDeGZUbVFlSFk2M2hTMWFoSW8xTzRuOHVDTkYrcEFxQjN1NWV1WGtQVjNU?=
 =?utf-8?B?M3lGRHIwRXNhZThOcG9oK3VjQ1FobE5uL3RQSG1WUlhjaTBrVjNPcTNiWnJN?=
 =?utf-8?B?c056Vi9WbEhzUDBDTzFOQTBkb1lQNW5ibVZ4YlpTbm9peXg3RkhUTVFPeFlH?=
 =?utf-8?B?cnErd1l3U2V6VnhkbE1mdnhVQmJMcEcyRUlrWFRiZUZoYVBETm9LYlNLRkFi?=
 =?utf-8?B?TVNwbnhULzZJdEQyWFJ4WVVwVkhBWmxjUmk0N1kweVh1Q0RMUnRqVllUZ2xK?=
 =?utf-8?B?ejZTQXBBSXA2cGdna200SkpSUHdXY2FnUDl3OVJ4ME5KV2hMZG0yRlJiK2Fz?=
 =?utf-8?B?b29GUk9yQ0M2dmV2Y3Yvak9vQ2JGWDN2c2FScnJ4MnRFRXdVU3BkdS9IRGNs?=
 =?utf-8?B?SDJPeWpaK2xFRUl1NXhSUDgzS2Vac05DalczRmtIN3U1dnpkUVBTaUxpZWdZ?=
 =?utf-8?B?TnFERzdnb3k3SVF0YWNuaEJ2bmtmU29NdzM5U0k5RytEdXdDSk40VVd5SVpk?=
 =?utf-8?B?ZHNZT1NzZEt6Vm55MEQ1TFdPUVhLMDBFOTRUK09FSzVzYVhBWW85TklnMDNq?=
 =?utf-8?B?L3FDUDNiSzZtZFl3SlVDenEzYWVNNit6Q09hVVlCdytWOVBrdEY5dCtjbzk0?=
 =?utf-8?B?d2VPYWNFbXpMOXhWWjBlay9VYnVWMWc4VUVGQWc2dEord2tLK1AvTG45THNv?=
 =?utf-8?B?WWRudGk4RDFsQkVITWJaNFYzVE5MTy9TM1VMS0pQZDl6NEZIOFltN2wzL0Mw?=
 =?utf-8?B?b0hlVWFFdlF5NC85SGdRaHZEdFZaVENxOHZKUGJWc21UcXdEMzJwSCtoMTZr?=
 =?utf-8?B?djRScFV3bXhvRm16a0g2L3JQSExDQlZmeW1Ic3F4b2FEdFBXckdxRUVqMFNr?=
 =?utf-8?Q?pQdQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C99F60C163B4174CBB5DF3EFD1560F39@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21d3726-74e4-4e46-3698-08db9848b32b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2023 19:50:21.3456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jfFxp6bk9+veeIG4n5ooW0+6Aa2SPVfsps1ofJHqJqljmsazeqRURbr2H4TBL5DuTMhB8vHgEjmDHkcQhGh4bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7663
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230808_125028_160273_E928A38D 
X-CRM114-Status: UNSURE (   8.54  )
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

T24gOC84LzIwMjMgNjozMCBBTSwgRGFuaWVsIFdhZ25lciB3cm90ZToNCj4gUmVhZCB0aGUgb3B0
aW9ucyBpbiB3aGVuIHdlIG5lZWQgdGhlIGZvciB0aGUgZmlyc3QgdGltZS4NCj4gDQo+IFJlcG9y
dGVkLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPg0KPiBTaWduZWQtb2ZmLWJ5
OiBEYW5pZWwgV2FnbmVyIDxkd2FnbmVyQHN1c2UuZGU+DQo+IC0tLQ0KDQoNCkkgYmVsaWV2ZSBi
bGt0ZXN0cyBpcyBwYXNzaW5nIHdpdGggdGhpcywgd2l0aCB0aGF0Lg0KDQpSZXZpZXdlZC1ieTog
Q2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCg0KLWNrDQoNCg0K


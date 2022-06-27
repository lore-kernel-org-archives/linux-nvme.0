Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7F4C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 23:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h/FxMYm3YIKc3m30rDS8tCOA83K6Gs8brHuEfxpb+Os=; b=iqHqt5TMWed4nStw/dqRqvm4Lp
	AOiXSlmU7CjKQT3NjfTpQiJAA94d4//1bqgPz+suX7HNQJy7Ra83Gy69TJ3CFf2Na4D2Hp6YJg4Hl
	ljoZk8DDPTB0IACdU+wWZf0pW5lmolmQ5c2rxZLxupoJG+uxRQ2jmS/O4RdoLYi7NL4fvGMcpsndt
	7fLVGnJt3LdNTRAtz47ezxHssYtYBPxTHTIvlQkDfMLWuFVBZNWJabPE7QcAhVlGVivQhCiwRvjoT
	WVhyY17/cAnSwGvdDKXkZAVCNxnlpbdbKmA5q+qyqNdmQxLR81ZpnvRnH1k6iEtQffDs8e8Z89Vtn
	a8rMUiXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5yNk-003K4t-E9; Mon, 27 Jun 2022 23:43:04 +0000
Received: from mail-mw2nam12on2079.outbound.protection.outlook.com ([40.107.244.79] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5yNh-003K3T-GB
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 23:43:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/twUkYe8N8Irxa3Aza4VSofxMKdgl/iTjtgoC3hZNzaXlHHoXmgWhe1c2Zd4O57iLfWNfw0Ir4nApLYbOJE407ymsvqzSAC/cqk6f35BAOEf+Opwb1tveRHBPH9iBjifqX/6UYHV9vHalUN3S/zidRU82/PnqFxC8XT848hj75+yBZ0t0Rrb8r8s1FrH6QZIicG3g1A6DAKXlZDsGhpSRMYpxjuHTrzPlGsjUEfWcC1MspoG/s5KcM5E17VOhIIPxBWnS+vg7pf3NsYl6vH4IsmPilG/1Nig/x+S0figHhm8CFOb4rkWl9Jkv+Wt97wt27ksi9hwqvCPqr6NSimrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/FxMYm3YIKc3m30rDS8tCOA83K6Gs8brHuEfxpb+Os=;
 b=LXg6itBfSbMZepsTXRdLnMoj/HjyQIqBCrg6dlOZF59UjkCy3o61boINs3kNRQm0Pnbbtj7gsOvTuOx2SMGJBMn1UXBgJn7V/p/D4d4Vv2ww3WVNLvd5iZ+cKjnn7T2sLVb6iseZNCyDbmAT5Dn6X9A72TXBeT2cdnndlVgK+STLICEJIXa6FEsaCnoDcfDTWJKnCBOOUluS9yWcPE/jkJk+AL6B5epv7aIaMnQts8NxwijleaejhFLCTP7QLGuI2isxap6oCIipLVFlmN2Ja5jR4iC0BOf2fJGiwIrhA97RI8YMqMvUBq/9XfTDPDRzlM444Re878QR7I+NcnXjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/FxMYm3YIKc3m30rDS8tCOA83K6Gs8brHuEfxpb+Os=;
 b=AS+/D/ZPoyo5V6oWDCNmdD8KFOhGvhQ4vdsb3uC1/6aAYf5kNXFJV7wAj202CHMto7IvxXnVW99sttkLQZ/USEz6wvSwX41dmHoVc4wo3+RD0ytSvaH+md5tcCnvEOAGjxVE8eL1Ak175Ur4i1hSIy3c4fHn9UtXKOmzNA4xpUfCLfon2ztHhLUpDLewGfyX8sx8tBSvIvj1eEEf4EBJtjD1u6Ai7xBribZQQBdSngawKUGsXjC5xKs1DQTnm8/UhGo6soDRcKssIkbFiNRudGc8QmdXOptYR7UhUexXT4foI57w7KKs5mVDrolDwu6stc/4bdNlI+FIfyj08XEpeQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by BL0PR12MB2497.namprd12.prod.outlook.com (2603:10b6:207:4c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 23:42:55 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::240b:5f1b:9900:d214%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 23:42:55 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Ruozhu Li <liruozhu@huawei.com>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH v2] nvme: Fix regression when disconnect a recovering ctrl
Thread-Topic: [PATCH v2] nvme: Fix regression when disconnect a recovering
 ctrl
Thread-Index: AQHYhs0LaFCl8QJ4nUW6qvzmo7FJy61j8aWA
Date: Mon, 27 Jun 2022 23:42:55 +0000
Message-ID: <c7ecbfa3-53d5-62b8-67ac-42de7711c9dc@nvidia.com>
References: <20220623064539.6142-1-liruozhu@huawei.com>
In-Reply-To: <20220623064539.6142-1-liruozhu@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 494a8e89-3711-49c7-0796-08da5896c261
x-ms-traffictypediagnostic: BL0PR12MB2497:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  bd1oCc7X5tGSW2LuyrDS2PfpT93dzXMShVNdP5luAdIXlJIqAJ/p6CbjCw5eXj5QKlRkqVcKYNG/p64RUS5L4jf/zwVNt2dyT7tGvxi0r6mV2dKfsI8Jg6sPQePiZuIw+QBpVkuh9Me7j11YkLI8MGzPnj31mh8OVIrMQshgDkx3juBSUgzJIFrZsXu+hd7LiSHZXFHCD4UgEjw3rkZ2wdatRgVtEkZyFShlIsc935eXDgM+evg59GN+K+sLSMoQpPqkflhkl31Jk3UCqIB4iatN++vtHXEWFrLNHwavxHIPIZssYkpufExFMHCqgjqXtlb1O5ht4TXP2bvGYHc1tYNrnFE+IJZrwTz41HxyT66HoU4rczc/EidNLJRPCdnnmA1jndQXByDLksqoIq2XN715id9uXftsaxiB8nPIg0VRws0/7Nuzzo8wV68Pgc0mKD92oufh1OIIQdZcrSTHyQp6Eij/CMFHsAEofbylZ3+88FAMeVHTVIqqRyvUX5fKWgKPLTObXMaa2WxvL3T9iT52MX0+kLsm0f4edA/Xm7k4Q0WLlyiS73RN+JH8wwLcF3JuhYk6OLsCcCl4UU2l5twfsaZsjCui8Qkwtk2NXyAxTq4Q6F6+s0Up2UUjmRno5hxu5LGDCkYwauhWReXH+CJ4cMZX3120zMgELB3TwfkPmMWqdPEnBgNloqvBeSxoEtv5xhTSuDERqGeQW6b90QEs23zSi+Jk9CVEnTx6HDTLB+DcL9jZ1ULz0sFmr3MIuy4SzAkhzJZL77smLT3uO+A9f+gd0/WciVAfnT/9/3guHIoP2PhQgm12Zgj8ttQbD376LZfjJSrDKIr4C65DJlp5ADXz1ps/sB4ngYbcVtE=
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(83380400001)(31686004)(86362001)(122000001)(53546011)(36756003)(186003)(2906002)(6916009)(4744005)(6486002)(4326008)(64756008)(478600001)(66556008)(66476007)(91956017)(76116006)(8936002)(8676002)(66446008)(66946007)(38070700005)(2616005)(41300700001)(6512007)(71200400001)(6506007)(316002)(31696002)(5660300002)(38100700002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?ZFRkUDVpbS9qVENqalFpT3pONFlwb1NiYS9zL0FHdjJsenRLb2lVc3M2bTNv?=
 =?utf-8?B?UWRpbVZ0SW1aNkZBakZFY290WUwvU1N1eDUya21mZzh0T2x3aDgvWWlrYmxo?=
 =?utf-8?B?bUIyc2JZcC9hMkxGS0xrNUlGNVdkSVA0RUdwNnhkcXByTXViVnBrU3hLc1JC?=
 =?utf-8?B?bWVlQmxQY3NXUE9WYW1OY2JtcTBkTHhrTUZiYkV0UG9BSW9Nelc4djhvT2Uw?=
 =?utf-8?B?ejJmNzBZU2RpbU1tT0xJeGQ5VDJRU040dXp1QWprUllkL0szKzU2d1RrUkdM?=
 =?utf-8?B?cEZVOWZaRmNPSXBySkVDZWxyUEJhUkJJbERiT1piTDJvOUFFVEVKZEtqN1dx?=
 =?utf-8?B?L3ZuNXNPVlJhMWdMbXBheHZIUlp5R1R6Rk5SNlpOUkJZTmQ4b3JXamtkMStH?=
 =?utf-8?B?VU5Zb1NkalN2bjd2RXhRQXdFQUUrOUtyNk1xdE5qenlJMTk1NlgyUStNR0RK?=
 =?utf-8?B?NnB6LzBWenYwT09mN1VPbERoZkx0VEVxaGs3Kzl1OGRtSW52UTExbFhPM2I3?=
 =?utf-8?B?UEg3RnRUUE0yeTB3ZllQaFd1WlV2RExlSi9JcTVicUN2OStzVXZ5YmdqN1Q2?=
 =?utf-8?B?cFQ3SER4bE55dTk0TE44N0FOUmg0TXlXVlRvOEFhdUVvc3o5VVRoTGZrZk9t?=
 =?utf-8?B?dDVhcWpGZkRCd05HeVREVmg3eWJ2SWxSb0c1elhScFNveWRjeVhwZ2ZWZ29D?=
 =?utf-8?B?NTRhTVJvUmZhbzZIci90SnI2RVNPWHo2amREbVFGQWZydUk3c2hycnhtRU82?=
 =?utf-8?B?SHhHeU12aW81OG4zSnFacC9Ya2Rac0trckNIeXJESDQ5NVBkNVVQSTdpNnND?=
 =?utf-8?B?ZUxSRkNLV0RlVzdjeUg3SXJuUzU3ZzhFQ0FmbDQrNi9NdXNrNVdSQTAwUzRJ?=
 =?utf-8?B?RHFiL2tJVm5IcEZKTkdHMFRieGtSUjljd1lhNlgrNzJzZW9WMDlIRDBFRTRj?=
 =?utf-8?B?cHRSRmlGdmZVREdJa3AxZkN0aGpiTGpGaVVkL29LdkhZK3lpSURlRnYwTEJ2?=
 =?utf-8?B?N1lacUQxdG45U3lnUWZzOEt4RGlEQkkycVZ6d1BneGlKYXVaYmlacUdOYXA2?=
 =?utf-8?B?TWxXUlU3VFM2cVVDQ2dtWUhWdmhqVkNVcmJyazRFTWlGdW5qU2hyV0h0ZDBm?=
 =?utf-8?B?QUllZ3pSSi9PUWw5Y3VtRWtXZmRVem5wUmJBRm5KL0xobTBuOGhuMU4wRzkv?=
 =?utf-8?B?NzZoenYvaHpETUJGbUx1R1FRdkZNS0gzdXF5ZkZtYVZSSFJuVXRFSm41Nnc4?=
 =?utf-8?B?SURXUWUyeSsxODJEeVRheGNPQ251dWt2ZDFYUmVvcWIzQjAvV3pEaVZzTW85?=
 =?utf-8?B?SXB6b3dxdVZvQ2MzNXhteHF2L0lGeVdHcU4vNGplMmJUY1gvaGo4dFh5YkRm?=
 =?utf-8?B?WE5tZXBEN2plRXZqbWVJZU1wOWpSVWJ3di9BbTBaS3Y0ZmRFN1FIZ0FocGdP?=
 =?utf-8?B?d2ZWL2tHZFFVZ1pzODFOY0RObEtvbWQvRnJIU3FFUzFxU29oRXE3bkNCWFpn?=
 =?utf-8?B?VUQ1Nzh0Y0dhODYraVhnQ3V4aThXV3RuMnV4VWh2YXduaGxDVll6a3R1TDNi?=
 =?utf-8?B?VnBuTjFnSklBVGpjYko5K2t4eHZ5Ky9rWUlGVHA1Q2FMVW5HalUwekpmZzRp?=
 =?utf-8?B?Mkk0cEk1a1NEZlFEQlRjUWROTjFiVEZIU0JnYzh5akUySGpMOFFRQWl5YUgv?=
 =?utf-8?B?N2Y1dld3OEhLQW5rNXJ3VVlHdnFjeWZ2MDg1dVBUTUJ0ZEE3RVpWbVFUSWJq?=
 =?utf-8?B?VWtwaitrT1A5OEJvQXg5WFd1STUrT0xVNGQrZ0VuMUNpK01nV09WQXZCUUky?=
 =?utf-8?B?VWdmUGhQWFlKTEw3Mzc5YkxJTzVkQ21kSEF4V2FkbjBsQXZ6dWk5aWpwb3o4?=
 =?utf-8?B?Uk1CM2dlVlE1MHdDM3JQTjlqcDVDQlNaYjdUWGYxZHFVb3gyaG9VQ29MTUNO?=
 =?utf-8?B?WGwyczdXTytYYWdSYzMxNWVqRXZCUEFzZWpJblZ5Wm1HUExueXF5UVJaendY?=
 =?utf-8?B?SDNYWXpkRDM2ajdYVUE5b3NpcVJZWDJ6NGlnN2lxa0dkc3hNVkxjek5jL09K?=
 =?utf-8?B?RlBRZ0dvVThrdE1CLy9wV2tsYkpaQ012Y1FvNUYvNXE0NXRrWEJsd3RwQXlt?=
 =?utf-8?B?WWN0MFdUd2RYaW83OHF0L1R3aU9lcHg0N1ljUFc2VnNQREM4VDJ1Y1pjM2R2?=
 =?utf-8?Q?u8YNxzWKZUwcaFJJEKaSSLDu7qmzPGEy3H5vjAK2qGkB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D65C7A5931DD194FBD3A912BF27E05D1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 494a8e89-3711-49c7-0796-08da5896c261
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 23:42:55.5199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c178UBCX1W1FfIiWzEEOG0s9ArroxbuIlAD1sokfKdqNRpTBE7L4c7A90KvIHgns53LRAj0/EWIDlyngKxxPtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2497
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_164301_579001_A3B4B348 
X-CRM114-Status: GOOD (  14.96  )
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

T24gNi8yMi8yMiAyMzo0NSwgUnVvemh1IExpIHdyb3RlOg0KPiBXZSBlbmNvdW50ZXJlZCBhIHBy
b2JsZW0gdGhhdCB0aGUgZGlzY29ubmVjdCBjb21tYW5kIGhhbmdzLg0KPiBBZnRlciBhbmFseXpp
bmcgdGhlIGxvZyBhbmQgc3RhY2ssIHdlIGZvdW5kIHRoYXQgdGhlIHRyaWdnZXJpbmcNCj4gcHJv
Y2VzcyBpcyBhcyBmb2xsb3dzOg0KPiBDUFUwICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUx
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG52bWVfcmRtYV9lcnJvcl9yZWNv
dmVyeV93b3JrDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbnZtZV9yZG1h
X3RlYXJkb3duX2lvX3F1ZXVlcw0KPiBudm1lX2RvX2RlbGV0ZV9jdHJsICAgICAgICAgICAgICAg
ICBudm1lX3N0b3BfcXVldWVzDQo+ICAgIG52bWVfcmVtb3ZlX25hbWVzcGFjZXMNCj4gICAgLS1j
bGVhciBjdHJsLT5uYW1lc3BhY2VzDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBudm1lX3N0YXJ0X3F1ZXVlcw0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLS1ubyBucyBpbiBjdHJsLT5uYW1lc3BhY2VzDQo+ICAgICAgbnZtZV9uc19yZW1vdmUg
ICAgICAgICAgICAgICAgICByZXR1cm4oYmVjYXVzZSBjdHJsIGlzIGRlbGV0aW5nKQ0KPiAgICAg
ICAgYmxrX2ZyZWV6ZV9xdWV1ZQ0KPiAgICAgICAgICBibGtfbXFfZnJlZXplX3F1ZXVlX3dhaXQN
Cj4gICAgICAgICAgLS13YWl0IGZvciBucyB0byB1bnF1aWVzY2UgdG8gY2xlYW4gaW5mbGlndCBJ
TywgaGFuZyBmb3JldmVyDQo+IA0KPiBUaGlzIHByb2JsZW0gd2FzIG5vdCBmb3VuZCBpbiBvbGRl
ciBrZXJuZWxzIGJlY2F1c2Ugd2Ugd2lsbCBmbHVzaA0KPiBlcnIgd29yayBpbiBudm1lX3N0b3Bf
Y3RybCBiZWZvcmUgbnZtZV9yZW1vdmVfbmFtZXNwYWNlcy5JdCBkb2VzIG5vdA0KPiBzZWVtIHRv
IGJlIG1vZGlmaWVkIGZvciBmdW5jdGlvbmFsIHJlYXNvbnMsIHRoZSBwYXRjaCBjYW4gYmUgcmV2
ZXJ0DQo+IHRvIHNvbHZlIHRoZSBwcm9ibGVtLg0KPiANCj4gUmV2ZXJ0IGNvbW1pdCA3OTRhNGNi
M2QyZjcgKCJudm1lOiByZW1vdmUgdGhlIC5zdG9wX2N0cmwgY2FsbG91dCIpDQo+IA0KDQp3aXRo
b3V0IGxvb2tpbmcgaW50byB0aGUgY29kZSwgZG8geW91IGhhdmUgYW55IGlkZWEgaWYgZmMgYW5k
L29yIGxvb3ANCnRyYW5zcG9ydCBhbHNvIHN1ZmZlciBmcm9tIHNpbWlsYXIgaXNzdWUgPw0KDQot
Y2sNCg0KDQo=


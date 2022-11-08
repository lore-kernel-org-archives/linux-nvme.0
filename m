Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5703C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Nov 2022 03:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HlNT/ObpHxzujrA3vwl+cHkzExlXS091YDeJiWO/0zA=; b=txAOnCfbbQTUI1moSd616+y0lh
	3W09SeX6ARBVrUgh2VXtP/XSXAZYt/ZTqXsL2NAA3ow7nQm4sxcCtQ+GxnrmAG15KKJoKdgaNQvPD
	kHgO+OlVWzOiNEKjOFx9Whf4lq9F3E7EH/ql5bdx/cY/LbI7/ikrf9NKufLLsYjLI0Js65TCKRqGG
	hvK4irdHCxpWalJ5VF1BxEIGmropuMwWwXsW937m/4S79AA9SKFjnbR4EbFBNiSmthMbmgsDgjxDl
	P8iYxa7sfNs69d97uT2yvsdXieyK6M+3MsLn5Z50KCk2bg4N/8rbrC9Jy4R+tdNTMfRA2e7yuQALx
	00GkltSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osFfY-002Wbb-J9; Tue, 08 Nov 2022 03:53:00 +0000
Received: from mail-mw2nam04on2052.outbound.protection.outlook.com ([40.107.101.52] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osFfT-002WaH-SM
	for linux-nvme@lists.infradead.org; Tue, 08 Nov 2022 03:52:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gigqHPegjdRyLRpeK0748TH8u3Af/atsUH/ncXOJcRBokcWPn8AO39iYYH5kclbegY5Nl66ftJ3VF8b66DGZoQ2CxykpOQn++Ae9C3iqOoi5628fZjDYthyrJRWFqezD15rzVONZ2+ROABFTTIAVrWloGAPcnYZyOfWQyftf+MxU6/8ut8hPONzSFZqQDzKbkOlu92GWCH9rHlkOWU1GFxViZIYrd2869z3ucU98+zK0Ne6iRLNwYKHvOaMUqL+fsalU8W5GN/QGa4AvEGIoTUz1ti4JwsR3n9qO+CGGSiZZ5OehPnLt8ZOjSpmGMiwrByA7A18Ww13houZtaYv0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlNT/ObpHxzujrA3vwl+cHkzExlXS091YDeJiWO/0zA=;
 b=P9AuycPHgoopcISMQ0fUBKR0k1oDS40coD/AgapcrNBhZcjo+dCTTEtjblL8vgohURR10STtXGoPYAf8esmwlFAouFcjYfrbzLdsbX4+e/oAAAX7OFC0wMh6QhDTKv35beQXztk51cubY7qR6ygIPbz2igvIVolCj6+c2BbvZsGKAQ6Fhmd/bCsrNJTZwq7QTiLjMic3YoP43/4C/YJ7hKUZvcTWlUC196GGcBE5unnJgFEwpuHoyWgjCukaVLp2EjmYbaLCh6YiQaHh9N6eRxFZzJl42Zy7FsVHiUoXLRNbV0xZZKGKoKfxXYRu5Uk/tgmJD0u0p3sTNxdRmsMkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlNT/ObpHxzujrA3vwl+cHkzExlXS091YDeJiWO/0zA=;
 b=YQiuSInR2QU12YnleVAbIx1yho7l53kiC/yywjXs3ZgXYN7ggCaDwpVfuvEZpiNcdKToVC2P/yzVXSQq/o9PekZNqUEBPcLGFzmCPKjaLJlllEZJ5TesyCa1wzNSlCf+nQst5VjGMAa17Oypc/p01GnVhpGWEdHerT1WKJjjhFFwfUKkp/zJttrigJP9cUGw3NFRsey5Gqe8xkDblgv8hbV1QuQjHSsEi4+1q5r0Yl5ZgaTo+D3H9tiPy8kv+oCpOnC3hSL8xVWXHYWo7bBXG5m2+LYjmTvA4Y3CYxLJFhhsP6LZwt2H2cFfQTZO2G2jlR6Esvjj6SLsjVKxP2EaWw==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 03:52:48 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::eaf1:9be8:d472:ea57%7]) with mapi id 15.20.5791.026; Tue, 8 Nov 2022
 03:52:48 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH] nvmet: only allocate a single slab for bvecs
Thread-Topic: [PATCH] nvmet: only allocate a single slab for bvecs
Thread-Index: AQHY8rFKURlWwkaC/EujJ4weLxUG2K40Zb6A
Date: Tue, 8 Nov 2022 03:52:48 +0000
Message-ID: <f8260b87-e61f-af45-234c-fbf8c60fdf94@nvidia.com>
References: <20221107140019.1503818-1-hch@lst.de>
In-Reply-To: <20221107140019.1503818-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB7677:EE_
x-ms-office365-filtering-correlation-id: d11e1224-719e-4314-f052-08dac13cb3a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  e1rALHDLazY3bW6rLKFT6CmTli2YkV0+Kytj4jQc2IF4ZBFC96Z/1IgwS19HOSUk/4H2QnfvJo6dvfEjqVuj6bFHQb2hix2Agvaf0zYSwdpZTSeB2s7h8Gkz+z95GkIm6QrJR579AyBdhlGEFHXpPH/KUHPGhNu9eQm0Z2eP0wsIQ4yzPCiVi1d5HtcMDjcajwnZwVEaCJjARXr1REi/X1O4MXOI1gIBwMiQjZ06O/nAsJeYCe/mmqP/YIIAEXbJRFcZU7IWzOM6QYZBpoJ7VNQz8BHF8I/SXWLHyQPj3eCfmM2QssjMWsd/RNCm5LuEZP4i3+TZnioDV5VoothBvKA7OvOe1MSbdiDGJcrbsjxq2CuanQbBxc5IaK5aSDltt54w4qkP6J1UVI7jVmFuZmzwIgirOeUzfeRldKwU5d5gIzOalmJUqoyAgyXuatzI5QefWcjgWHQQcj4kjmf7tJHrhMyzv+e8YPcdGKEcxY+FWqT9IEYyq5BLMrnSS1ABL+J61P4lOy9UPp91P59yPYosli6J9IdY7WGO0V6Xp+K/G2Gq8ugfHru3+HBvYqhtNkPhjGmv5nhzhG18wIwvKzaE3xOomOv+iN6xME6Haow1zkQMPVm3ZMfSvErWfmAkALeizpWVHDEI8uhBl5qsRkUsEGciJdkueRs3vgRDLieIYu2id5NGXQIJWG2Kp7fA8gQ9vtNkHozD6SzJF8QTUYy4KnoVKdKk/JtLppIQ6M8PU4ppvo7HUYZgCHnVVkUMWMVpZ7dPj7NJRRKXmFQf5roIqVcQx2m4b6/mxY6D3qHGIZO7AOsydh2ajIiANkhLOp2QL+3+STek7qt5yu7MAg==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(38100700002)(31686004)(110136005)(36756003)(4326008)(41300700001)(66476007)(5660300002)(76116006)(64756008)(66446008)(66556008)(66946007)(31696002)(4744005)(86362001)(8676002)(8936002)(316002)(91956017)(71200400001)(2616005)(38070700005)(2906002)(122000001)(186003)(478600001)(6486002)(53546011)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Q0F0WkppdC81UTNIZTRGcmtlcUhPMEFZdlA3anJGMFpLdjNzVzB0TTJXR2Y4?=
 =?utf-8?B?aFg4Z1V4UGQ0S21PRDM0SUFieWlUcGhCZlUvU2FkSldYdDJ1SW5abzV1YjBt?=
 =?utf-8?B?TEhjd0tUZWJkY2hldkxLZHFDblVhTEYrOFd5KzZvc1cvTTR0a3JTZ2E1WWZQ?=
 =?utf-8?B?V2RqbEhGNlRUTFpvNHhzbU4wb0RsQ2UzRkdKRGk4OUJsbWZZRVkyNnZiV2JE?=
 =?utf-8?B?ZHlpaWxGRDlPcVltN1RhcFVYZ2lTRzU5QnNsa3lib0Y3ZWI0U2lBcytIdVcr?=
 =?utf-8?B?NmhWTU9GYVg3dFRZcUV3aDRnUng3b0xNUmRFUTB6VVBGQmQ5K2t3NXlsWkNx?=
 =?utf-8?B?NVl4SmJpOE9sNlZIVCtlemZRQThRRUdQR3JmNHdNVkZDQW1TMWMvT3VlSFpZ?=
 =?utf-8?B?QzRGSU5COG1UZlJXMjRjSmZ4dWs1Tnp3V1R1TWdEM1laYi9XVnVHblpNWnJa?=
 =?utf-8?B?dExsUDNsUGxLeW1WVlJjV05vYWpZbmM1WStuRytrMGNycEo0RFZabm80Q09t?=
 =?utf-8?B?ZUk2ZHhNb2VSeTg3bnRKbzNQTkN3OEVqc29mMFNWUVl2b2pBa3E3Z1ZlNitQ?=
 =?utf-8?B?YVlqSlVMb1F1S2xONks3ZDZTZ0I1N25IK3o4cks4Q3F4WndSM2JLZmRxWkZF?=
 =?utf-8?B?UnRnRnZUTlNuUnJDakhuVVQ1ekcwMklKSEVXdGNUelNzTWxad0l3U2dvQ0xC?=
 =?utf-8?B?V1lWZ1dsYldTVm56TG95YnpEZ0NTVjlUQ09hY2QvcGRxZjJrR3M4b09EU2lp?=
 =?utf-8?B?S3FUSUUwWG53bjlPa004dmJkeVFNVS9oL1pQdjFDbDV3cWNkUjBxV1RDb0Vw?=
 =?utf-8?B?YzFWR3NjUVpOenFZWUNPc2lWS244QU5RQ1F3TEk2RFRDTFVKZnpPR2FJWE1S?=
 =?utf-8?B?a2xMMUpUU2JZcml4ZTRzY1YzUzI0cUtCK3kxN2ZwcHFPVHhxa01hcUdnQTdm?=
 =?utf-8?B?azF2Z1l3TlBZazdNTE1IQXUzL0R5ZzBSbDNKQVhocHVIaE9oVUd1MjhCZEdO?=
 =?utf-8?B?eEZaWU1mb081ZmlUenJ4TUhqRU5ra3lUNkJUMlhPdHlpZ0RnZ1FvRFMwNGc4?=
 =?utf-8?B?b2VuTGF4WSszNlFXWHFsMTZ6VDZuYVlHNkFZcEpvUmlIMWtpRGlIeHJmcDVK?=
 =?utf-8?B?TFRDWVVpK3JEUG9tM0dUSDkzVkcrVm9hVW5aWmlyOS9QV2ZSV0UxelRLVzNh?=
 =?utf-8?B?TGwybHloWkdoV0FnR3lTUXZTWEhZZGxySzdxblgrajFXL21lVmkwbHd2MGxT?=
 =?utf-8?B?THpiMjI1eE05cXZCOGpKV09tTk5WMXl3eFpjZWppT0c5SEJ4V01jRUlrR2pw?=
 =?utf-8?B?Zjg2blFOelpyWDFNUDNIb1RIcVFENjMxeWNpaUpPZXpReEJGWmtBeWlTNHdC?=
 =?utf-8?B?VzdPRnRPcXp5ZFI1NlJIelJ2WnZ2bkZGM0t4UmF6eVorcjFRT0NHZzVYYVlv?=
 =?utf-8?B?T3QrNzFlcWNHRG5ZV21ISithd0NjVnlQUnc3bVoxUEV0VjVRa3ozSjlqMTlz?=
 =?utf-8?B?VFVPTUU5M2NITEw4eHA2akpLMTRiQUN1ang5andOaDJrckZsRWFKNDBwTkNl?=
 =?utf-8?B?WW9kT0Jzd3gxcWZ3MkYvVnhsb0dZa3N1Z0xyam9GZFU3NXVUakdxL1FsS09y?=
 =?utf-8?B?Nm5BUHVITmp4SjlDZ1pWaHJ2QXkySW9TVVFyK2MzblcvL0xMR0xGSXd6OUpB?=
 =?utf-8?B?aFFNNHNrZTZUY3lBM1QvMXpXMTg3clZrRkpSMTVkOXRoYy9sMjdLMXpVUTFq?=
 =?utf-8?B?SGJmaGZqMk42RmdWNGxUbzl4OWI0eTVKeDZpN3dNL3ZkaDZXSHh4OE5oVzJa?=
 =?utf-8?B?V1RYMVNKcHkxdHIvdHhzbllNVGY3TVZTOTJSeEY5QUNObDF1NHNuZ05aK1dX?=
 =?utf-8?B?R3Y0V25tRWc4L3Y2WFVBMTAxZVIwQ0trcEl1VXVNMmEraGY5ZFFyaE1JQWpT?=
 =?utf-8?B?SkMxaGVxbGJOMy83Q0cremFDblIzMnFhWjVvZEhwKzRlam9yKy84Um90ZHA4?=
 =?utf-8?B?YzJPdFJjblkwQzFUanRMdGE2bE1TeVQ5cEtWb2VmR2NzWjRMalZCT043OUJi?=
 =?utf-8?B?Zk1JZXdib2tvUFlWbUdSK3F1cVZCMzByTEs5ditXQ2JYU2FiTmovNVJOMUFj?=
 =?utf-8?B?b2NNTVFLei9GZnd6b3JLRFhndElFNXIyMDNsaXVBOU1FWUs0dmk2WUtFbVpV?=
 =?utf-8?B?L2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <536985EE58A9A143A953428934753451@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11e1224-719e-4314-f052-08dac13cb3a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 03:52:48.2269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pBHJUmUlCOy3QkujlMumiQmhEgdTeoBOCqdlKd4NKlnVNAWmtMNA2BJuR4pFuD3mrWF1wWaioQkzJbWw9QNKTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221107_195255_938339_D1B74798 
X-CRM114-Status: GOOD (  11.54  )
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

T24gMTEvNy8yMiAwNjowMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+IFRoZXJlIGlzIG5v
IG5lZWQgdG8gaGF2ZSBhIHNlcGFyYXRlIHNsYWIgY2FjaGUgZm9yIGVhY2ggbmFtZXNwYWNlcywN
Cj4gYW5kIGhhdmluZyBzZXBhcmF0ZSBvbmVzIGNyZWF0ZXMgZHVwbGljYXRlIGRlYnVncyBmaWxl
IG5hbWVzIGFzIHdlbGwuDQo+IA0KPiBGaXhlczogZDVlZmYzM2VlNmY4ICgibnZtZXQ6IGFkZCBz
aW1wbGUgZmlsZSBiYWNrZWQgbnMgc3VwcG9ydCIpDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KPiAtLS0NCg0KVGhhbmtzIGEgbG90IGZvciBmaXhpbmcg
dGhpcyAuLi4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5j
b20+DQoNCi1jaw0KDQo=


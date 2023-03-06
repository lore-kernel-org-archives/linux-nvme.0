Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005CEC61DA3
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Mar 2023 05:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a5yZZpI1a1oXO5u4bZKc0tK/aJASOnY91La3t/QSkZU=; b=ejIsqdFTBe/sm6N7NEDV6iaDua
	fbjL3hs0zKkSmhyOaVhO/MdCUGnfeadTW0B1XmRJJPano/aGP4mXG/wRHbfi8WuN22X/+M1Q0mZxH
	4LMLNcIFD8DG6xQ6/TRojx1WcOE1R0Lq1p+YyegGDJqzT01l5/L4Zf7iROwnczdhRc9yOPuzCiS6i
	x7a+++KI8FhyhTH611vJ44BR2AyOscPpHMiAPh/0txanxrbzRK86d72MWXHg6FgYkZAVo25Pl7Uwu
	w2O9nW5g6BR75yX7Uxd8Gm3gy4+Li6HldT/++wIz/buYZmLxicf3HPDXc/t8sLu9p3Xk3vkxK3J7O
	73eF4ulg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ30b-00BLJv-VK; Mon, 06 Mar 2023 05:03:38 +0000
Received: from mail-dm6nam04on20628.outbound.protection.outlook.com ([2a01:111:f400:7e8b::628] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ30Y-00BLHD-Mf
	for linux-nvme@lists.infradead.org; Mon, 06 Mar 2023 05:03:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hf5tuJJYEVWdjNAecJI0PmQn3pEJ4owZ/7Rm2U/LpfZI1NE5E3W1JsEwSprUAbSRK1v3y4Y1hwYxDy8TCUyA24Wp39mJcrpoeTFlGF7SuwzAjhCN5PVXcjC/lCRaQIv4/b+a/xf2XIFiHkedVmEZDcD8aR2rMLG2RsBCt+bp1wyrBSnB1vU6JJYNpYckt+gvbM8/NKCH/y61vYPXI98+pWD760ClmoObZyda40f6qNqjZ9wDMt448frVybFXIQudC4NI/Ly92b/g0Faiw/vz2uy8vDeZl+VS3foD83IEC/t5OvQuW0/MpInMSVLeSY6TEIJ0sn8s248JXc+J7G4O7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a5yZZpI1a1oXO5u4bZKc0tK/aJASOnY91La3t/QSkZU=;
 b=THquaEMLm6Y2+ZNwmPhOFhF+KJ/qgpP4Ne9BOIUXZQS6aMUquG9jF4SmfpHYEpUos6D85nn6D42ZT1KWcvuF3OONV08c/7UlP7Wcy0X5AIcyhvshidNRSF81HIK20KrYE1qVwMarGFdY83fdvoa4j1aDLMOsgHiebTunFcfm6yecugxUIYzF2dNUZiEriTRJ9GhgygtwQdNRGBoShxKYPp294JF90MH9rMNHQPJ1JTNO/HpH+yKd8BYqnQL3xc3AeeBHG3JB8acTyWOz7tsuIB1LuBDHHVjFCidoRdzGLZYi80gAZTtUYcKc9m3IqalqWw381yv8XJPGAumv9q9x6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a5yZZpI1a1oXO5u4bZKc0tK/aJASOnY91La3t/QSkZU=;
 b=eM84X0+ZqiFjUnibFNXMzmrDWq9FAWdUCBGiwCpPP7UbCMDk1rY4xKxxW0b53NlxNoCfCWoKoaNieeuo4HTrmDmmHsUS+8sT2pAXhzsIAAmCth+Nv6Vu2XgD7KyOlx4xgtteNoM/sj860EvwYahYO0llY68mZxW46f+CamDxQiXFPD0RRk5R4Np10Wm/LPIcmDchMWriU12UVh2Fu34orbY27AlO105d3kfjpzhMlzdcAQQ4HmO/TsgjAlghjonJ3Kl4KmziCnTki6azx/plSQ4CgSI+uF8XrzcS6pWE903QiHcPytVB3xAcocs0ZB6rcW62+BBlyj6iW6YkES1weg==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by PH7PR12MB7453.namprd12.prod.outlook.com (2603:10b6:510:20a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.23; Mon, 6 Mar
 2023 05:03:29 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::4aaa:495:78b4:1d7c%3]) with mapi id 15.20.6156.025; Mon, 6 Mar 2023
 05:03:29 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Mike Christie <michael.christie@oracle.com>, "bvanassche@acm.org"
	<bvanassche@acm.org>, "hch@lst.de" <hch@lst.de>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, "james.bottomley@hansenpartnership.com"
	<james.bottomley@hansenpartnership.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "dm-devel@redhat.com" <dm-devel@redhat.com>,
	"snitzer@kernel.org" <snitzer@kernel.org>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>, "kbusch@kernel.org" <kbusch@kernel.org>,
	"target-devel@vger.kernel.org" <target-devel@vger.kernel.org>
Subject: Re: [PATCH v4 01/18] block: Add PR callouts for read keys and
 reservation
Thread-Topic: [PATCH v4 01/18] block: Add PR callouts for read keys and
 reservation
Thread-Index: AQHZSHfKc5+sVD4VfEG7FVd4DI6xNq7tQQ6A
Date: Mon, 6 Mar 2023 05:03:29 +0000
Message-ID: <ab2910d4-ce73-340a-458d-1c9644d1c292@nvidia.com>
References: <20230224174502.321490-1-michael.christie@oracle.com>
 <20230224174502.321490-2-michael.christie@oracle.com>
In-Reply-To: <20230224174502.321490-2-michael.christie@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|PH7PR12MB7453:EE_
x-ms-office365-filtering-correlation-id: 2d0c0311-2f57-4ac8-1eb9-08db1e00205c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  nFgCNoF6JaTsm1CW1XfiCRaocck42QxfFrjR9NN1Vc3FxQ83BiQ37dqunOeJkSdz5RavXWWLOLCr+PCLu22KlLYfyaoDgsX+/6e/4mugiVH90IHJbRXrXXBQtgLvmDEClTkC40LujWoKqAv5fWs3Bc+joA3yyTvKYZSKGFPc6fvlltEDZdAmNjb+QxFwoDUcCKXkJ022U++NNFcvvkTS1HmSsQaTuQfnklaXRpczDKf5t1L2e+4QB3m3o6wEVFIvHQbUyfwxfZGGATgs2Vczlv5eCwuzp579E6Yk4VNKrTrRchFNGTuie+bmSkDivw0GpCWhkW0rmPiEP9KKnfAw2F4Kf7QGZSMWraIo8/fnmG9EJOAQKxIMZmUc6OkytWMzFHBUhKKw8jlY2F7vk6168PRDZFxMr+pbDB1wTYqqNmJAWvTaFWeL6NrNc5oTCiEAscqX5FU3ofQkMTZ8rbt7rXdTJIuxIFizBofjJtanW2kvNJIYd0BEcehHNA6O+jvUk1TSEoge5RkYBzjd/O0B7nV/wtP6ZrtHrR9BWvUoKUzX9FuhXBltO2vcO8YS682TebQG8xxCPuaTgLO8Rbi9QPFJIqi4tAuxriHzS7DoRCBb2cipEflzwOqyyXrj//q+FBDhbU5W+r1EmSiAgKfrVBj3bEj4cR3ARCgSSeLv8YquciDCbSN1mYtDdbhIntRJ5+7cHfZ5ScBAKaqjMeFGcfHSSyv5TyKOJRoPQISP5vRB74nmNOi3tP4f4h3m9hT2NKQNLskbSz9CcVT8BxiExQ==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(186003)(122000001)(38100700002)(91956017)(38070700005)(921005)(8936002)(64756008)(41300700001)(66556008)(8676002)(66946007)(2906002)(4744005)(5660300002)(76116006)(7416002)(71200400001)(478600001)(53546011)(2616005)(66476007)(6506007)(6512007)(6486002)(316002)(110136005)(36756003)(86362001)(31696002)(66446008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Tlo5NjZmRHVPcFlRbXl2Mm9FTUJiVnh1bGJyZTBQWk1Ya1kyYXllVmpzYmMw?=
 =?utf-8?B?WmI0TVlRdjdhZUtzOVR0TFlWMDlOVWtFaU16WVo2bzU0ZUpTNkp3Uk9TMG4z?=
 =?utf-8?B?RmRDWU1kZVROVGJTbVVuLzZpY3BaZnp5RWtpZXlDbGdyNTU4ek4vRThyOE5v?=
 =?utf-8?B?K3hmVTJmTjBWZDNvelZaN1ZGRXh5SDNSQzk4RlUxOUFQL21OZEo2NnI0YW1i?=
 =?utf-8?B?b255Z3hHdktYRHd1V2tVTU1BSmRFMFhtUitzQjd4T1VQQ2p2S1h6aEtUelAw?=
 =?utf-8?B?YmE1T0I5NWkyR0dEa1BzRmFjbFdjdlRzKzMrUFNqZWY2dGx4aXBqeWRORjlS?=
 =?utf-8?B?VytPVHJMNW9sYW84Z2kwTWwyN3ZFWmFiam5lcldrSTJCWXJPTk05Yng2YWFU?=
 =?utf-8?B?ak9RRkVjQ3pqOUxkekVISmwxSHk4WVRWaHVta2djb3dkK04rZXBLZVFybVg4?=
 =?utf-8?B?UW80SVBMTjNzbEozd0UvT2lSVXBhak1lU0FlZFExMW1rdWJld2VsYUdMQ0R6?=
 =?utf-8?B?T0FHTEQ5SFBmTU1qV3R1blp3N0FPZDBzNVVINWRaMnhHSU54TnA1eHVJVDJ3?=
 =?utf-8?B?N01QakN0WnZ1eVZlb3NIblBGUmdnT1NPbDN0ZDEvYzR1SThhQThqa3ZnMytl?=
 =?utf-8?B?SkJXeWNmdk5RWmM0QlVBNE9NcmZlUVhBOFpWdzAvU0VGcVhKanlmR3pWUVc3?=
 =?utf-8?B?S2lsZVZkUlBKcEFqME5uYi9sU0d6cXdnN0drdDltVFNZMDQycnVBMmRqV0RW?=
 =?utf-8?B?a0tOZ01vcnNXWHBUWHN0Q3VuT2ZhRjdWajVEdVZVcHdPcDlxdjRXYnNsRVNT?=
 =?utf-8?B?bHJ1WXV0MWhrMllIalk4RHROSzFaaVdKSTRZWEVHVzBkVlBvUFN4eTUvYWpK?=
 =?utf-8?B?c3lpN0s5WkhFdGNYcHpDRmZLYk01K3ZtSnZSNmswS0JHRzVkM3J5L3E5SUd6?=
 =?utf-8?B?Qm5rcmRuekwxR2o5elgzUUNVQVRobmQvVkViNjNqVTVuM09tVHZ5Tjd6MEhE?=
 =?utf-8?B?OTlZREpnODlXN3lrNEU5Y3JjR1QxeHhLSUwvQ0JUZVd3M2tNeWg0OHQzYWU1?=
 =?utf-8?B?THhLbWgwRGlDV0xDL3JDdi85c1BqeUNzd0JXUUY2R2dPTk50TTB2RzFWa2t2?=
 =?utf-8?B?dFp5dEVOaGt5WDEza242VWh5S1JzU3Q5aVVEdDBqTXhkZ1JmaHREQk5QWTI5?=
 =?utf-8?B?bWsrVHhtc1JucXJBNmErRUUzN2c1MEthS1NsZG1JUW51Vi8wZmM4ZE1seW9H?=
 =?utf-8?B?NjJqbUhMc1QrL29URFNRVitIN3JSYVZQRHl6cGh6NEdpYmxsVXNUdzBYTjdy?=
 =?utf-8?B?TDJyRk9Ob2xHWW9uZ3l0WFlOTmxuRmxJSm9NdzI2bWR6YnpCQ0Z6UlNLcUZa?=
 =?utf-8?B?NjhIOTZOZ1dKbFk1U2hramJnOTYreGVFWmF2TzhoVk1nSDRBa2F6cEFRVCty?=
 =?utf-8?B?bjMvSU54SC9tRVFKZFplTG4yMkUxdmwxVDFrNHpQLzl0eVdnNHdGR0ZyTGVh?=
 =?utf-8?B?SWwvOVh5UHNKUmt2cU5KNk9RTWdVeEprdmZuZ0U0QXZMNkszOXZ2SCtjQTdN?=
 =?utf-8?B?OXhETWNlbDhSaHhCNGJoeVpobzg2ZDFjeW1mY1JJOFFDYWN1dHIxMjNMNXZU?=
 =?utf-8?B?aWRvUHoxUkRnZ3BEN2lvckJ0bjhRWjlSWjNBQlFYemN1MDdRRUdpTFZqM29u?=
 =?utf-8?B?QTFtTk56dlo0RGM5VXFHczhtSnZhaVk5eVJWL3F5M1BySld1dFNGS0RrTWk2?=
 =?utf-8?B?VXNqczdVUk1XUnFxRldBK1BQbnp2S0RrR1BodXd2VVlqbUtJSEJ4MGdTSTht?=
 =?utf-8?B?NFFyU1dWc2l5d3NWdEtxcitwOUpldzRpWWc3SGdOZy9WN1RzeDJiRTExK2JF?=
 =?utf-8?B?dXFZRys5NFVWOVRMZ1VqdlY5YlRFNVVlU0E1Z2tZTzgxZnJNcHJKSUZ5ckZ3?=
 =?utf-8?B?ZWtCOTkzd0NKOVdJYlpzUVErS1N3VXR2bjl1RllQbFJrV01NYVpMZm1VSXN2?=
 =?utf-8?B?VFd4MGFOazdTMGxtZ0ZZTTlBNXJsWmdTOEdQcVAyZkw2MXR5SmtEQ2NNQlFn?=
 =?utf-8?B?bkh5d2RGN1F0VWFYeTJ2M0p4SmRVZzFpbzlRZzJweVpBL1pHTVpuUTUrQmpZ?=
 =?utf-8?B?WGZlMTNvcHhmMFlBb1diY0JjaEp0Z3hmcTc3WjBMN3o1a2p2N2cvcnFZRzJP?=
 =?utf-8?Q?pBS1mwkOoC+NwV53a3j5AepA4Ha39DXkDEYK3bPv5ChZ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4694B2FA86EF8D45981CDDDEE6D0F76B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d0c0311-2f57-4ac8-1eb9-08db1e00205c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2023 05:03:29.4486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pStLDqD7o8UNlRwLxOHFGZMkwK/T0/lL0q3vleshi5QNezP7BvLfr55MYiD4txXQS/kVN+cKCgDtj8HDRFMdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7453
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230305_210335_081340_CAD1683F 
X-CRM114-Status: GOOD (  13.93  )
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

T24gMi8yNC8yMDIzIDk6NDQgQU0sIE1pa2UgQ2hyaXN0aWUgd3JvdGU6DQo+IEFkZCBjYWxsb3V0
cyBmb3IgcmVhZGluZyBrZXlzIGFuZCByZXNlcnZhdGlvbnMuIFRoaXMgYWxsb3dzIExJTyB0byBz
dXBwb3J0DQo+IHRoZSBSRUFEX0tFWVMgYW5kIFJFQURfUkVTRVJWQVRJT04gY29tbWFuZHMgYW5k
IHdpbGwgYWxsb3cgZG0tbXVsdGlwYXRoDQo+IHRvIG9wdGltaXplIGl0J3MgZXJyb3IgaGFuZGxp
bmcgc28gaXQgY2FuIGNoZWNrIGlmIGl0J3MgZ2V0dGluZyBhbiBlcnJvcg0KPiBiZWNhdXNlIHRo
ZXJlJ3MgYW4gZXhpc3RpbmcgcmVzZXJ2YXRpb24gb3IgaWYgd2UgbmVlZCB0byByZXRyeSBkaWZm
ZXJlbnQNCj4gcGF0aHMuDQo+IA0KPiBOb3RlOiBUaGlzIG9ubHkgaW5pdGlhbGx5IGFkZHMgdGhl
IHN0cnVjdCBkZWZpbml0aW9ucyBpbiB0aGUga2VybmVsIGFzIEknbQ0KPiBub3Qgc3VyZSBpZiB3
ZSB3YW50ZWQgdG8gZXhwb3J0IHRoZSBpbnRlcmZhY2UgdG8gdXNlcnNwYWNlIHlldC4gcmVhZF9r
ZXlzDQo+IGFuZCByZWFkX3Jlc2VydmF0aW9uIGFyZSBleGFjdGx5IHdoYXQgZG0tbXVsdGlwYXRo
IGFuZCBMSU8gbmVlZCwgYnV0IGZvciBhDQo+IHVzZXJzcGFjZSBpbnRlcmZhY2Ugd2UgbWF5IHdh
bnQgc29tZXRoaW5nIGxpa2UgU0NTSSdzIFJFQURfRlVMTF9TVEFUVVMgYW5kDQo+IE5WTWUncyBy
ZXBvcnQgcmVzZXJ2YXRpb24gY29tbWFuZHMuIFRob3NlIGFyZSBvdmVya2lsbCBmb3IgZG0vTElP
IGFuZA0KPiBSRUFEX0ZVTExfU1RBVFVTIGlzIHNvbWV0aW1lcyBicm9rZW4gZm9yIFNDU0kgZGV2
aWNlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1pa2UgQ2hyaXN0aWUgPG1pY2hhZWwuY2hyaXN0
aWVAb3JhY2xlLmNvbT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFp
dGFueWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=


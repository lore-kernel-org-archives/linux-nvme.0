Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DED4CDB474
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 08:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W5069t4Y0A2X/wSsk4Y5dShl4o/v/X2JEOqcHPus+8M=; b=E/PQMKtWRfvr6T0OEHvvhEnxWo
	m2L9BPx/2yZ0ZG3So3Zw0jFOEHYnN7QcKIJnqG5jDR/Zx6HoS8rxu0wDVKM2BoehHLVxk5z/G7f9L
	jFCSH0wkO8E5ypBfeKZRyYVNIF6hFpueXLKi1HqUtowFIK7i64REwdNY+1joQzRvqqlGJfFV0UHza
	trQdljyvSsYs/DvUBZiEDKzGFONUszE/U6n8805gis5W/9qT2P/hKdLyvGqrKmKhDVuIG0R+Dxy1I
	k2PnLCg0PmAsxutAG3d/YzagyK6ncN/RPfLCF0DMTv6egwG86CJsGjaqk7uBilvUCmA9wf9SSro2o
	OMhCwSkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsfLd-00Bf6p-27;
	Tue, 17 Oct 2023 08:22:41 +0000
Received: from mail-bn8nam12on2062d.outbound.protection.outlook.com ([2a01:111:f400:fe5b::62d] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsfLa-00Bf5q-3A
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 08:22:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzkeJEVjyi/AJcR2+Q6IStXKTy1OWVc0ChCMNEkYaQoh/l366PpiAKvyzjzPz1vyEBUjN8ZhTjsFfRhscn5wpiFmxEOG9vs5KStUJRBZY7sI/J8n0UmD8RW6A3ptOVwvS8o5cJ4sVr+0k5HJ5PQdXBALBqrVLlVe0SAYjAWDFtoaidEd0A3yWZWInL1wTGWCxFrKtjjDi3Emu9QMJk2SB1IfWZXkhbkqGmTXCw9TaI94PW5K3ladWJO3hTLMQGkdLN81x3TYm7JYkneTwybYjwx4QgUfXL0LTQTF+x1DAijD3VYQV5ypuo8aW1miTjE7gZyIQL0wqwvEqdW0oLrr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5069t4Y0A2X/wSsk4Y5dShl4o/v/X2JEOqcHPus+8M=;
 b=ibNeuU0rvsrMiNoEDnDs6pOXvVQDdqHHyUB3Dt8R0RXCJlqJL4uwaChvmTbS0W6bOdXDYIedIAXD4rL5VrPVZ7fIrNkOfQhD5erEhki/CNj4Cy7C/cMffgvV6zM8ys/I4DkVuP0gCJI7WtZsXwtjq5TjXkNt2rU7cLhEi1st9ezb685HAECUvQEQyN75fkDUBa5kBhIlVZj8OyDuCqcVkqlVkuglzFcXvanREhtvN6q4vllHM+Yb0FWxaUNx3KafBBa4cLK7jhzJ7fpm5DZD3w1CXa21GdX/EyglvWrQnN/7LhK5Dj6Pa98B5wg8hzKCf855dP809qOLw1nw21Fp/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5069t4Y0A2X/wSsk4Y5dShl4o/v/X2JEOqcHPus+8M=;
 b=qjAzsHz8OMfi/16fhP90Bis10OwqHynBWig28GEwGWOo15nOpnLxU+J8y8IHjGRHJg8Cnq9GYZabNSPGkKalcfaaVY/a8jzbbVQ0xryqLI7aCHDj67WO9cNKlYUOt1aQrgxI9B9pztY4kkShdiyLlj1BY4p+2XyFTNna4G8q5VQsn4zZhAvaokbFWshcDECAdW7T6Xz7OcSBhZERrxZXnZaJnR2heq6MIPrK8mHT+MfiAEjVnz8MXVcFElOwJtXzdaTbOcRbKW3wUjX7xRZmawHMp2iTWVZgJKawcLZFFxJ7VlpOsT2DgFztSv9iUhqHBR7UN1ulu0v0Pk0NglQoCg==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by PH8PR12MB8607.namprd12.prod.outlook.com (2603:10b6:510:1cf::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Tue, 17 Oct
 2023 08:22:31 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::af95:93e7:d27a:15ee]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::af95:93e7:d27a:15ee%7]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 08:22:31 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Keith Busch <kbusch@meta.com>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: "sagi@grimberg.me" <sagi@grimberg.me>, "axboe@kernel.dk"
	<axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: sanitize metadata bounce buffer for reads
Thread-Topic: [PATCHv2] nvme: sanitize metadata bounce buffer for reads
Thread-Index: AQHaAIWM/wOd6mJNIkSvmDnhFL/7VrBNpRgA
Date: Tue, 17 Oct 2023 08:22:31 +0000
Message-ID: <84db9bd7-7861-4558-92b0-67c07a494cf4@nvidia.com>
References: <20231016230625.3792823-1-kbusch@meta.com>
In-Reply-To: <20231016230625.3792823-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|PH8PR12MB8607:EE_
x-ms-office365-filtering-correlation-id: 44786e6c-482c-41d0-ea3a-08dbceea3524
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aQuNUPKEtMXPTgUzFNVyEIrAZXdG6X46FxoRUqsr2GTe9qoOtfSrTqRxqL2vLz4ExLe6COe8Q/ArMWbTFKXZSNhk2BVsdXqe1d6Doi/d3ckvvomYDMUMh2BvLP7k5LlX4TU/dDnwk+fvi9JCXMNZJ7FNKjvoF6/EPH9UwcS0KBXf1VXBUnMhahyhBcBcm4qJH4JZ6fgOBqn/eM6zSZWRwGGISl/7UMa9cp5P62iCBvr4Phv33qBKoIkrRmXFJXYlx/rpFUQ5K3e/sIj0tMyBz7HX0l1sHmvbCZu7dHlr8G81gSOeXPbbrUtP0Q/SqDgVTEst7WdmtTb9xirTn5FF8QqtIFAvcVxALijIFGgFICmiT4nLizVynleAMcHrCIy8kof8xx79IfBBijQJebfgrKeJVjXMN5HaGtVqRNoEi+KaxfmsFlewHKZnQ0PvvELqu3CopcNQo0qqGJPCyXZxgXLPyIlsZlep9OHihmOWFhdR45EF8H+txoDNc4NQwp1RxNFZfwoMmww/Xbfkp9XNogVUEUkkSkROqwUxzQF2bL3m8UYCOUsZX72za25xTuFaS4sXDkUbEC95CMiJ8Aa1V0fI/JLBWgZGLFzHFzy6EPwbM8S1RPPF4719/topWkmkfVCnp+/fqDXbc4V8guELZdAerkVaNhohwMmvgMIPN9Igys9qxJjx+ktz9G/12zkj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(8676002)(478600001)(66446008)(71200400001)(31696002)(6486002)(66476007)(122000001)(64756008)(54906003)(66556008)(66946007)(91956017)(76116006)(316002)(8936002)(36756003)(110136005)(38070700005)(2906002)(86362001)(4744005)(41300700001)(4326008)(5660300002)(38100700002)(26005)(2616005)(83380400001)(31686004)(6512007)(6506007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZU9Zc0JFTTNpVEc4RndQd2tJTUFQK1I3cUZRRG9Lbk9IQlBlOXVYRXB6L2po?=
 =?utf-8?B?WlVGRGVBb1NpSFR0RFFxTVlDMng3NC9GaHY3ckFzT3AvN2hVUThLL3hiUHBa?=
 =?utf-8?B?SnB2VUVmUGZrMWZBQkVqYzZBOUl2VzNLY0NtVGV0MFRsY0FjZFNkU1Y0MUJa?=
 =?utf-8?B?UHJZK0grRHFJbXhhV0NlVmhpNENKK3B4c2dGb2REZjF3NWJkOTllV2ZoVHpZ?=
 =?utf-8?B?N1dNYmZLTDAwUnpON0hsM2pyRE9WZ05YZlNvYzVNWStncEJSYUhQNThrL1Rw?=
 =?utf-8?B?TnpLZmZIcVM3TlBHdG9TWlJLRWtjdnNpVVh2NjN0TGRIYlhra1NERlV3N0lp?=
 =?utf-8?B?VUlUN09TT0duQUd1eWhhM1ZGWmVKNVlZU3pqSGVyVFVSQkhqS3F2U2o5MSs4?=
 =?utf-8?B?SVhYTGpGYnVhT2pPd0hrKzN4WnRPSjFaSzl5aytYSFZsNTVUSWk3dW1VM3pR?=
 =?utf-8?B?Ym5CS25ubXNaVXVUU0lOMDQrZ3c4eUlMUlcxYkdUMnNyMWVsS1ZKcGU2YXhq?=
 =?utf-8?B?RWRibEJFTHkzVTBRZ2VPU1NVeDExZ08vVHhKWXF3NmhYcEFQM2k1Y1VhVjZP?=
 =?utf-8?B?UFBhdTJVbmV3WWVveU1walN6NUo4YWRwbWpvMzVMbFpTcmVqVFdST3MzUEUx?=
 =?utf-8?B?Nk9zY2FqTFlUV094Y29FdU50UElvNEFzMGtwTzdrNGRlc25BUGxRUG0xL0Qv?=
 =?utf-8?B?N2QzVnJ3VFN4UTVpeTkrYjBWVUgrMU1sVlhVMy9vWUt6MHBUTHF6QnFZWDJs?=
 =?utf-8?B?Y0E2SndwQTBSM0lBWXJNaklZazYvKzRrVXJwZFRQY05uY21aZmVhSEF2SmVX?=
 =?utf-8?B?VWl5MGVQWUZKYjNrTWYvY1NPcWRJYnlhb1BqNjE5QTByTnluQWZ1RVdJMlhr?=
 =?utf-8?B?VHpWYmFWVSswc2UwUTliSzREU1dMY2FRRHR4RVFXNGNRMWY0dFc3SURlNC9E?=
 =?utf-8?B?OGVuYkFmL2F6K2NUOXBDV0JwemdKNHNvM0YrUnNFMnVkWlFaTnh4dmg4WkZE?=
 =?utf-8?B?V1ZWRHdPZ2xTUllzK2xBMG92bS9USTVDY3NLZlZnYVNsVTFFRmRpSXpNdm50?=
 =?utf-8?B?T2I0S0xQU0RsSzhWZkNwZFFrRFJ1ZHdkS0Uzdjl4QXVRV1NNYUF4VnpuWmgx?=
 =?utf-8?B?MGtEbERsZlIvK2xZSGVVOU9QNEZVdTJHcWlQUVhPNXB0NFphRmhsejh5czVu?=
 =?utf-8?B?dXF0ZXdSN3F2TDY4UDNNOWlnRTY1ckVQWXZYQ0theGJPQlRRTHhIeHdrRjJM?=
 =?utf-8?B?eE5vcXc3dXRLNDV3K0FOdnZnUTlMR1FuS2F2T25XcDZneEovM2tKQ0dpVWQz?=
 =?utf-8?B?clBTOFNCUE01cXdnT1MrRmordFhWU0hjRGVsSjZtbWlkSkh3MzMwWC9aVDE3?=
 =?utf-8?B?VVJyN056aUJCLytRbXF4VUlIVmdBSm9STVYrRm5ocktIeDh2VHNGSk9BZHdT?=
 =?utf-8?B?Y01GaXFjZld5cjkxdkhTWlUxZmM2TmRnT2xMY2F2UE84MEM3ZU04OTZURFA1?=
 =?utf-8?B?bE9qVG1XczBHSVNyNlhuMTdvcmN2R3A1N1UwZXRVbWZUK2YvZm9FV0U1c28v?=
 =?utf-8?B?c0V0akhHWnhxRWpXektHTEdqckowS1pFVXkyME11anVzNjIzYlY4ZVo2Znc4?=
 =?utf-8?B?OUhic09PZEFDTnh3cEdLc0llTitYVGs1V29nTVUxdWcrSllTaDZjL3RqdjNI?=
 =?utf-8?B?angrZmVRbTRGZms2SGdiVzNNY2dwcEhUWDczNXdkeW82V1BZbGpQaERRZ21X?=
 =?utf-8?B?andLYlRaSlVkRW5CMk83eFA1ZUVKU1UwQ3FnSFBIUFo0YjZiNUowcWVrWlNh?=
 =?utf-8?B?d0hnZHhVZk1oWDFXblJpQXprWXFLLzFrZWo3NTBPbUFpNW04SFdWK3A3aTJy?=
 =?utf-8?B?c2JiUkdwdXFJQnU5TG5lRithMm9QQkIxdXFkelB1MktsVVZrOUtrWnRjVjI4?=
 =?utf-8?B?cXMydkhieHV0TmlZOWlsczNVclhWSUtWRlYvZzNaK2orUlB4aGJqTjNJeGZy?=
 =?utf-8?B?M0w3S2F4RWV4cVFkWW9HMS94OGhPV0dvcWRPTlFkcVRWM09MbW8rdVFUMFUy?=
 =?utf-8?B?RTRJNkVGZTV5aU4vSFo4VXlsVmN4VUpRb1R3M0FnV3puNndKcWxxQXdveDQw?=
 =?utf-8?Q?7cI+POauPMqhEbKFFfXorew+M?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <68795E3DF8E1EE4B8C5DBACF873F4A73@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44786e6c-482c-41d0-ea3a-08dbceea3524
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 08:22:31.2222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yRAnkClgKFT6/Nq1usdIE8kk1Tquac0QhO+2B+iKHVTkTak16FUieAG74dULbkPbbzChZy0GXDtJmvDi7R28PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8607
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_012239_039276_144E64C2 
X-CRM114-Status: UNSURE (   8.94  )
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

T24gMTAvMTYvMjMgMTY6MDYsIEtlaXRoIEJ1c2NoIHdyb3RlOg0KPiBGcm9tOiBLZWl0aCBCdXNj
aCA8a2J1c2NoQGtlcm5lbC5vcmc+DQo+DQo+IFVzZXIgY2FuIHJlcXVlc3QgbW9yZSBtZXRhZGF0
YSBieXRlcyB0aGFuIHRoZSBkZXZpY2Ugd2lsbCB3cml0ZS4gRW5zdXJlDQo+IGtlcm5lbCBidWZm
ZXIgaXMgaW5pdGlhbGl6ZWQgc28gd2UgYXJlIG5vdCBsZWFraW5nIHVuc2FuaXRpemVkIG1lbW9y
eSBvbg0KPiB0aGUgY29tcGxldGlvbidzIGNvcHktb3V0Lg0KPg0KPiBGaXhlczogMGI3ZjFmMjZm
OTVhNTFhICgibnZtZTogdXNlIHRoZSBibG9jayBsYXllciBmb3IgdXNlcnNwYWNlIHBhc3N0aHJv
dWdoIG1ldGFkYXRhIikNCj4gU2lnbmVkLW9mZi1ieTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJu
ZWwub3JnPg0KPiAtLS0NCj4NCg0KVjIgaGFzIGEgZml4IGZvciBjb21tZW50IHBvc3RlZCBvbiB2
MSwgbG9va3MgZ29vZC4NCg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQoNCi1jaw0KDQoNCg==


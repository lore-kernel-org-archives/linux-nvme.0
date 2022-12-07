Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B49AC352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 18:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4D+gocMKoPpGhaGUwvnkV1bRPnQgtPFey6l0IlWcV+8=; b=1AuegXPiyXNkdv4ttK0uqoSjjV
	FxBqYvOtzB/R8a+zpcq+l7wYHxDhj6PEnyj17iwZuA4qS4YWQYYKC5nkTSuRuhTiLk26wAkSr5HzW
	W1w8zPZDOxReySEk5NisdHyFFRu2Ut/QhjavSXpmtxXJFMnN8adMiCtEzecHic+qgVswOE2yYls2T
	8cfyB+zM/9WZf1AOFmJMyRnVHbKIAO5chzuGpBqYZtIMpmJXAqXmOU5ReZ9TdFFwhLB/0sCbp1oo4
	AQYpusR2a9zAL6WppXYmiuBVTKtzxiy12zK4HDsHTNYnGJbEhEVgYR0rBlDKMdMcZpJNzLl/Q69Zp
	rkFuXSvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2z7J-008Won-1P; Wed, 07 Dec 2022 18:26:01 +0000
Received: from mail-dm6nam10on20608.outbound.protection.outlook.com ([2a01:111:f400:7e88::608] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2z7F-008We5-Hm
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 18:25:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqywuzdH5aTHZq4m2u1dXsBNsQRi32u9V16I0jALSPezKsruz6h3+7pD3JyhdLw8gSRyIsaEGrcifbX8wRgFOfbjgYhA09jpvtdhUS2NUFZ1owBIxXFdDObwhCUrm6KmVYZX5cKF32xxWiLE2bRl+aA69ShimSoAJJrVdqwHta1Oj9ETwuW5TOf3nkL+bL2r+tcVt3DZPnFrzz1K/MFgTKZsxTDIf9/F1rbrpOQsL2eeBjN4Vw8YygcAKkVtaeXXPSLkARdB5rC0JPoYLvGnvDQYgpWS9HgjpaAN7vNfwPafbhoPPNGKWnQKN6FNYPzEsdwMoNr8BZyRUfyjxwmulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4D+gocMKoPpGhaGUwvnkV1bRPnQgtPFey6l0IlWcV+8=;
 b=fM3+QezjMnIVdyXOMwMSiYFNPmoitom4yTM6AOQXJrBCdZ3fYkC5c7gzmgJ3P9r+M3Y1mIvHUb6YudtkT8m8ZfyFnh9Y3AnCQGca4wiWfW0ypDXQcJPdZ0Fszf3u4zUoJ3V9YdjbfqBarjO/4/i/OPfDgTL6v5zwYnlwtdSQJmjVXfK8HBwrIhZVfhM2c2kFuSr4KXr7iexW1r6+WwwD3inxpb3yjg2NWmXmKTWX8SCZaCuT5yphh/XGA1Cpq8GezK0+++GnXkvygmmG+4pYiC8kmswyv6xuaQczbmHobfg0Ga7bn66+zeDby7mzyVLjBEnrm2tI5AFk44SZoy8Tmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4D+gocMKoPpGhaGUwvnkV1bRPnQgtPFey6l0IlWcV+8=;
 b=q1UDg/33bQqTEiFRUod9aFq4hcbVOzTPcwrxA+CNnio5gV1+XFShmT0DPtVYBZlytsEhkV2bKZE5qQ6Np3ei2hAZndeLPj18t+2cANvvE02fG/lum0f5ixKEVS+y5CxzhVOQ+zjyYBy5WnJImzjSqRw1O39nYbOz8ZXvNheZrN8jd9OclwcYdE0bxctIbDgeYuk/wi+By0HlJZhDveOlcL8xr/XtiOxkR6h9CGfbJ3zW+ZkrP6r54im4ZzRRNiZW8fXwJn++KLvGYEqzbdtdkjpVzzIgYGHiGkjv7Diz4h+OcEcB0Yi8GVk/R4sgTWM/YZpO+vjUMocj7qFHcdz8/g==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM6PR12MB4545.namprd12.prod.outlook.com (2603:10b6:5:2a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 18:25:53 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::b84c:b6e:dc0:8d7%2]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 18:25:53 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
CC: Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni
	<Chaitanya.Kulkarni@wdc.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvmet: don't open-code NVME_NS_ATTR_RO enumeration
Thread-Topic: [PATCH] nvmet: don't open-code NVME_NS_ATTR_RO enumeration
Thread-Index: AQHZCi8lr6JGC53YQUC7Ih4cXoKXZ65ivk+A
Date: Wed, 7 Dec 2022 18:25:53 +0000
Message-ID: <350857bb-e8c1-445b-dd60-a9334a47fc0b@nvidia.com>
References: <20221207112823.1212380-1-sagi@grimberg.me>
In-Reply-To: <20221207112823.1212380-1-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM6PR12MB4545:EE_
x-ms-office365-filtering-correlation-id: 50d836d6-b048-4505-5ec2-08dad88079dc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  +VNwn8DnrPVdntPY/+2oGf6TG/OM819NaZcQA3vxAlD4aLjo0plDeTm2aHPLfxDKTAYRm3cwcx2PRzdOMRx7jxVPQvvrZaNQjl5em/0SmlRP13G6ZSx5mEUTE/GjjzmPmDsI51Q0gCIG+wQev9/Zul+VG+QIoU1UboaG6Sj1dtCxC1mtreqnP1OGbO88LaeiY7X9SWxLM9v6SbFdZ8elAt3djPFUD08ABYVWP08z4UpAi2GX5VVb+nuYPhYq/ALVt9Q63dFt0AaUZVeJXC4OcrK62ZZWnt7JnYJS8fVVjyB3e28Cf2+renb7TD8FyyM+yUcus6sT+JAR0CWArPBdvz10RcV7tOmfkQb0wKRLWrv45i5fFJ3uVwO/W75qZKkvRLAvRer+obc2zvfAVKwuhgJsOypPF/g5DDumUm6YvQZDSqpV+MdJw17EPHm2Mm3SLu1VF5+rUZQozOTJmP+s4GIfB3N5aOTFivUdZIjpSQpVhzZAVFjFiaUsCTDKasnFLePiRrEERc47lkxTO76xkZTCCX/OaUNVouFNrSU6BzXjwOC1Qt5jGgStOuPwSwAXj7MH12Mzv1ZWkE9xLmkAVJVdxkWOUTFiqfa1v5XgOEPV1Eu9u8ilDbGg8J8lii58S50gX+nA0gOlPsZ5x+D3FfsUiXzm0QuF1EdyAV/NWhFfV4MI37/EdhSBTcNiOKyX+i2MKiDoBiRBb1XYyzrjnB11+9OUgd4KneJ0PjPGu9LPfRE2SI8LbxFOQX1lqcirSsHOYxBFu+DyNHEW7ptuUw==
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199015)(36756003)(31686004)(86362001)(31696002)(66446008)(4326008)(8936002)(76116006)(66946007)(41300700001)(8676002)(2906002)(91956017)(4744005)(38070700005)(66476007)(83380400001)(122000001)(38100700002)(66556008)(2616005)(316002)(110136005)(5660300002)(478600001)(54906003)(6486002)(64756008)(71200400001)(6512007)(6506007)(186003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?RUF5VGRYMzNPSUFhTlBDYktWVnRyeUV2Qzdodmx5MUZ4TUttVS9zWWl4QWxi?=
 =?utf-8?B?VUhTNG52cUhjTWZHUkt6Wll6YWZiQU5xWkYwV2x5RGE0SlhDRFkvU1phay91?=
 =?utf-8?B?TWpQTEEvRFVBdGM5YWNlUGwxVmd4V3hYZ2ErZDNLMXVBZXBOVTNwU1Q5SWZt?=
 =?utf-8?B?NmE3dys3TG9ONW1SQjl5SXZmWlJJVml5bXd3NitFVGVrbElFUHB5RTBJUDN3?=
 =?utf-8?B?TTVVcTRZbEYvN3dPajY5SU5RaDFGYlpyUGxwbVQ0YnE4MXNZRU1mQWM1c1F4?=
 =?utf-8?B?L2ZONktXNjQ5aTNWWVM4Y2tIRXNaUXdsbUhkdE10THhlNFpCUUdxWWIreEZN?=
 =?utf-8?B?ZVBIcWhpUnIyb1hYc1FvUlZoY3JLWkIreWtPQjNmaE93ZzdoZTBWV3NJdk13?=
 =?utf-8?B?SjRpQ2VWSUcxRFc1T25jdGxUd3RYOEJIc2tOK2VxbzJEK0puaE9MQUYrSytV?=
 =?utf-8?B?NWJIVytIRHpkeU1HeE9PeE9MVmZEaWI0ODVBdUxQNkk5OFQ0dVJSVzBqVnov?=
 =?utf-8?B?Q2pxVGJsZ1RueVJzc1hnd1o2UkNka2xUOElOOGVsRTZ2MExqZy9YQ2lyZGdJ?=
 =?utf-8?B?dGNvQzJkcnlwcU5VVGtLcDhFM2VjUUQybUQ1YlJGTkR6RGtFTHNtZDlEcCsw?=
 =?utf-8?B?RDNkZ0lsdWpqSzlVcDc4eENQdTB4OFB2N3lhUDN6YXF1d05XK2YveUh1WC9h?=
 =?utf-8?B?OVhMd0lYeVB1SDhYaFFwNmRVaDZSa3VncUQrbTUxWDhKMGMxMDZiZFZKbXBL?=
 =?utf-8?B?OXNHS29JSm4wV2krUE53WmJQTWM4aExtanRzRUx5UjRFZkZGMUFJWUlmVW8x?=
 =?utf-8?B?SWJGTFVuREQxQVRBSkpoYVE4Qm5xdlN2NzhYQ0s5Z3lxZmlSRXdjT3AzTC83?=
 =?utf-8?B?M1NNQTdFZmRSU1lJdldLOXVLazB1TTV1UlZBOWxPakdrSTJwWk9jdEt4SEQv?=
 =?utf-8?B?SjI4c2NnOXBmSE1qSTE3a2xXSm1EQVdkbGpsRThFcEFvM1hrOHlJdmV0UTdy?=
 =?utf-8?B?QmNtaDlMYUswRFZDeHl2bkFuQlpQc1g1TzVUZ202NG92V0JnWm5aTStLWkhQ?=
 =?utf-8?B?Nk1uNll1SUNDL2x3V3ROZUxwckx5OGVPRk1GbWs5TGp1VlF3dEwrQmp3V05M?=
 =?utf-8?B?SlgrNzgwYnRkSThtMUd2ZXdlY3RWZFYvUTJEZmZxT2EwR1VGb3pma253Y0Jx?=
 =?utf-8?B?SGpCTUNYaFovdjNjekN5YXlTclVlQXFaTElrNU9za3hEaGc2RW8vV1I5M1Rh?=
 =?utf-8?B?cWg5YU9Sdm03Vk45dm5ZYkwzRXdOV3o5blhjdUROTGlyamxqQjM5dWRKa0hw?=
 =?utf-8?B?b0NIbzRuMFkzVkZ6dmVPYkdPa1hxVU1FS2dDTFNjZ05OS0huQjhKNEo2WEp6?=
 =?utf-8?B?SHpZQWlQWW92dFNRQ1N6S3QwV1NsZUZEUUVUWTNOVTh1dzlZZVpjMENoNE5K?=
 =?utf-8?B?L0ZRN2wyejNtSVJWc1ZreWp2ZWVLdXpCNE5vZXlXWWE2VFlFNEx0TWlqd21Z?=
 =?utf-8?B?bXAzcHBLVnlHeVlPdGFKaHhxZjZxZy9kWGFWekNFUS8wV0dPOWhVdXJBWTBH?=
 =?utf-8?B?VzFXcmxzS2lueStpVCtXTUdQK3dsaEJjWTJqbXN2QkJyTFlyS3B3OU9qais4?=
 =?utf-8?B?L2tFN214T0hyelR1YjB3QzF3M2hHUnVMUmk4V0kzSmdhTm40SzErR0Nnbzlh?=
 =?utf-8?B?OS95aER4eDJWeTJIYk16ZzI2dkF4bmlHdnM5ckQ5OGM5UHdsRlB4YmxHc0dp?=
 =?utf-8?B?c0I1REJteDFvL29mOTUvL0ZUYm9KVXRnMFNCa1FZZG5OV2xycURmTW5yVHZH?=
 =?utf-8?B?ajZ6d29JTHR6dExNRzF5N0pPOFlaM1Q0ZUJKWmd0bUJtREhDbG5sZ0Z3TlRa?=
 =?utf-8?B?RHZuR1hsUWtaS3dOVVo2LzVkUm1hb3h0ZzhWMkZ5bXRacTUyV3dweWFCSitl?=
 =?utf-8?B?R0ZaUElPcFd3cUVvSS8zbUdBZ3NZRkFBMVE0N0VEWktiUE0xSE5pVk1hNm40?=
 =?utf-8?B?WTdmNmRlNVhPYk91QUo5Z2tiQlREV2VkdmZQZFdBd2NmKysxYmxVcHp4SzF6?=
 =?utf-8?B?YUpZQU5CYkl2NmxJK3J3aWFZaHFxWGxnMXZSdTNFMEdGWTl2WlVTT0Y2QWk3?=
 =?utf-8?B?R20xKzhLU0RXUGNyMGZnKzUyY1RVVFlUbzVneXZFWHRoNHpyUStpTHduWUxC?=
 =?utf-8?B?dkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4271F0A6C196C84080BC8445914A8D08@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50d836d6-b048-4505-5ec2-08dad88079dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 18:25:53.7776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2DT9cQfY80Dim0p21zkfgQX48repcz9IED719c9s+oHZuHrwE/tq3lCdEBvaFmeUQI7WzASx5sh8/+RIGFTvOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4545
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_102557_970395_711BEB86 
X-CRM114-Status: GOOD (  16.15  )
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

T24gMTIvNy8yMiAwMzoyOCwgU2FnaSBHcmltYmVyZyB3cm90ZToNCj4gSXQgaXMgYWxyZWFkeSB0
aGVyZSwganVzdCBnbyBhaGVhZCBhbmQgdXNlIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2Fn
aSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4NCj4gLS0tDQo+ICAgZHJpdmVycy9udm1lL3Rh
cmdldC9hZG1pbi1jbWQuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0
L2FkbWluLWNtZC5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9hZG1pbi1jbWQuYw0KPiBpbmRleCA2
YjQ2ZjkwYTYzY2YuLjUzYTAwNGVhMzIwYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL3Rh
cmdldC9hZG1pbi1jbWQuYw0KPiArKysgYi9kcml2ZXJzL252bWUvdGFyZ2V0L2FkbWluLWNtZC5j
DQo+IEBAIC01NjEsNyArNTYxLDcgQEAgc3RhdGljIHZvaWQgbnZtZXRfZXhlY3V0ZV9pZGVudGlm
eV9ucyhzdHJ1Y3QgbnZtZXRfcmVxICpyZXEpDQo+ICAgCX0NCj4gICANCj4gICAJaWYgKHJlcS0+
bnMtPnJlYWRvbmx5KQ0KPiAtCQlpZC0+bnNhdHRyIHw9ICgxIDw8IDApOw0KPiArCQlpZC0+bnNh
dHRyIHw9IE5WTUVfTlNfQVRUUl9STzsNCj4gICBkb25lOg0KPiAgIAlpZiAoIXN0YXR1cykNCj4g
ICAJCXN0YXR1cyA9IG52bWV0X2NvcHlfdG9fc2dsKHJlcSwgMCwgaWQsIHNpemVvZigqaWQpKTsN
Cg0KUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52aWRpYS5jb20+DQoNCi1j
aw0KDQo=


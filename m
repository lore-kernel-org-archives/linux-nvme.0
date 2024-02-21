Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F05FC48BC3
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 05:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6HJ0YnpCQCYPCCkq2lClvWqSqdlia8UZX7SfrJXZfnE=; b=n7u/3y0qUtBGpOWeNTu0SegkQB
	qh7CJmXB19zKbLdzWVqiiiDUcATGTr2xNmt5jArXo9h0RziOKhUbWvHfsiE9GMLNlYuEoG/tgyAha
	0WRNUQ6X/SiVLWRPVQQTrHgX2mbVhomdqlrmup07HgUs1RujmDdYAJXo8pw08CqTGwyX8eMihF9AY
	72Rzf0YYFbwHG1XI+2H5cyelEfslIr8wdR/NDXQ47266YC9NYumzm2zbdZt9ZGuFNr/asLSkU7EyY
	yLYLMltPCX6zuuZGF3dcmAKFLujMrkPQ7e6IoGSg3OzT7CJPVFqSZMZe8ZWeZAt1B3h/ohJpj1Rl4
	27YHgLOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcfFi-0000000HCt1-1f62;
	Wed, 21 Feb 2024 05:34:42 +0000
Received: from mail-bn8nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:2418::601] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcfFg-0000000HCsM-2CpS
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 05:34:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cl1UDy0eYsnuc9Cd0URoGOsbDGxAEB0/DylBAZDOiXFfqfsdunJWbGwVWhXXxIwNpCKMtEKI88636APFFgkmfSOzOyooGc+MN09LmhCLyB7gtdSm3hR4skYw4IYSFvJ2YQ3/ZG/Lb7Ohh+G2s4OffMcxHHxaPZ4iO1zb/KOH69FK9LnkUdUCDWVFyy/EYK/YYTtyQgkzT5pE88j4Qw8aT5Q6T9R86bvEFLGH5VmmAYFB8zIfhzzk5quXvDzmPCitKuf7B1kvHmY7DXr1pUcg3bp5K6Bs6P6xNKlOPDCNgNluSgSMHcLdoOMWIsJZO9Xi/HpR0jIbbiBAq9On8nT8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HJ0YnpCQCYPCCkq2lClvWqSqdlia8UZX7SfrJXZfnE=;
 b=iCLxZzADYSdMt6yaMwOsOjBbpiR1vBnJed867+Cc3A1klfIFYV0RmVLQBJSrTwqrfScNRmB7cN6cXYkIMoMbCiq50cyAfSm+vZKLi1sSvXw+feZYPgPftjeBc2pZnpO3OAPk8ohm3VOfblaqpgEWvN78NXJziY6ljfT6h5RM7MZopc1swBXNqp9YYP+H8S5yE6ULv0kcCkzmfVCHgZL/yYs00kM/YLJUVbD8pK0C7gvfAwwbGTKBa0/6s+AslTqksjocjEqbO/LrnU5liYp3phQa0Wh7fmFbbxfr66tuAAlI0QMxQJddFM7VYPXN5dPuVCXTFl6LofuIyk21hq2Zuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HJ0YnpCQCYPCCkq2lClvWqSqdlia8UZX7SfrJXZfnE=;
 b=Vmp1+8vPX9PW1w+/Gk94IwivHy+8qb3z8GAbYIeWp5qtp005qqku7SOnRSjY+A/3Q/bRz9D5fegUf0CxLnN8qdiKk5BX9hb1W+dDPRwzEvmbeVLy7PQs/e5/1xTbYeYMO21QbBLGv2XLYlufXcwdUMR3EePChUVm2F6svVnWLOfr37PBGXOrDVQG/16QdNHCzfSOT/EmVe7YRaSzp0eCLPAfBKjjnPJFAJ1jYfHabGuvVPtRS4igEIqMzhpeeLfTfAw70M4CG8ng38zEyfUXE4p1V9/ct8Ttq6kwUS9m5lw/XWxUb3iFqnjsaMInvZOfywtA6nU6iHQIingAf0fYfA==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.20; Wed, 21 Feb
 2024 05:34:30 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 05:34:30 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: "kbusch@kernel.org" <kbusch@kernel.org>, "sagi@grimberg.me"
	<sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
CC: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH 1/2] nvme-core: add ctrl state transition debug helper
Thread-Topic: [PATCH 1/2] nvme-core: add ctrl state transition debug helper
Thread-Index: AQHaXWu3LWYv38OYtk+GmIdaKDPvLrEUVHEA
Date: Wed, 21 Feb 2024 05:34:30 +0000
Message-ID: <17c9eef3-38b3-4134-96d5-32501266915d@nvidia.com>
References: <20240212042641.227821-1-kch@nvidia.com>
In-Reply-To: <20240212042641.227821-1-kch@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|SA1PR12MB8723:EE_
x-ms-office365-filtering-correlation-id: d30c0d44-f291-48e7-452f-08dc329ec6fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qWAk1DcJUmi/Umy/pc726ht/uNOMaBcQthCy51/1v38egYoR3dYUny8+sXzBBxGUK8RCLfcItvfPzGSR/4M6sodUYSY1tsWcCokK/D9WegcDru+TA9s7IkQnCgWMXBGU74lIPde7drqH3IgjI7ULQRAjf1HX4VdKgsih+hBtUyQiOgKjYQq9rXq9rvXfPWMinjOg3XhUQo2FrBViPbfZWPHDyP+LMxj8WftADwcRu/ZtyIL76Ewx0Fb2eQrZUBwy1Vkyc5iTRQ9ka1uVSs2eul+jqjZd2JfGD+ns29ydCEC7qSXOBacCfUpzA2luyJv+kkTAoXGOCtOT9fo1Wu9c4qwzAiNYUBLivFyHQzzIDLVvsoTo84HhLtXQ1EbPd/cG5afUSvej3YJvql8LWaAD3e1crIyp1jz0s3WP+KQN80XWNZs3pKbSBJEVQ8n2ml0vD53iAlcGwhfZFYOG4VKmI65eRrWTPuqWq4cIgxMybiozdlXSqDL2rPPjqSBNYflna6zFc1pZFcolblhxT2p1MTGuaBtySABMtRhWvEKK3AKibMUMSd7OhDnQ3tmXAEsbppYQ+0IAlPZ7Vy8TZdt9aqpsy4Kfw8o+oa20rn08bQzlvqXCwHKyY8WykmCU6pYu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFhxQmFZSFR6WUlqZzVqc0hxVVN3eEtIZndkREZ1VzZwOFVkc0hJWVpYa1Qv?=
 =?utf-8?B?cVdoanM4My84SnBRamFYNmRpcVE2SHd4REhzRXluYVh3OTdGQ0ZIekY2Y0o1?=
 =?utf-8?B?bHptUTd4d3QvY2JIcy9HaStYZGlkNGZoa3Z1ZzRaeGlPVmp4a2VzaU9BeGtL?=
 =?utf-8?B?VHljV1JLQnc0dXIxdUFhUHEweER0dktMRjNidzFUcERYa3VCYUg3c0NScHY5?=
 =?utf-8?B?NVVKUkJiaWlNRTVMQ0RUNXZFTTQ3WTBJT2RIanh4OElkam5kUVF5Qml0Tk0w?=
 =?utf-8?B?YXhrSUZ0ekIrUHdHWGdCWG5FcFFyMDFDNHpzLzh4ZTlEZUQzREtiL3hQT25U?=
 =?utf-8?B?UitwMHlsdDRHangrQjMyd0FrTG5ZaHErSTZWeC9xeURqQnR5RndkMGVNSm5y?=
 =?utf-8?B?NERVM3VjK2FsbW9hUWtQRmhqWmFPK0lLOElPS2E2bGY2eCtHdEFLTlRHcFhl?=
 =?utf-8?B?REhrbGZSRkRCQXFBQStkMnhSODAzTHU3MHlXb00xM1lleGdFNWk5NVJwOHh0?=
 =?utf-8?B?Um9hWmhtN1dWcmUyVldUTE5UT0N1cjVySlQ4UEZuR1VmbzNGM3ZRQksxWDda?=
 =?utf-8?B?Q0lGTjFMVUdyWUJ6c25HaDJkQjRkUDk5Zi9TRjB3bjRvWG4yZmtnc3NCZDdO?=
 =?utf-8?B?Z0FlaStqTVRmbkxwUHJES0JsRE5RRzRwcDR5WGUza0k4b2EvSVdSYnc2QW5W?=
 =?utf-8?B?REdmOCsralV3N0doOWErTVFONzFRZHRrNzE2RkszaEFFcVFNQnlQbE4vTzJ2?=
 =?utf-8?B?cnlZdXpEVklHM0I1YkpEWnNaWktVUjJ0d1hyS0EzVnpQL0E5VjRGR1ZuNzNI?=
 =?utf-8?B?dE03VWVzRG9ZTSs0VHJLc2NLdmZQRWNEZ3pnRUpXOFZ1b1JjaW9iS2RjVEFa?=
 =?utf-8?B?Q0hSU215S0JJQmF0eHZDQ0V5RUlUV1V3WUx3T1Q1RTB3ZW5EOVNYY3pPLzZZ?=
 =?utf-8?B?dUt1SnBBRWMwMjNmZG9JamUvUTBqeEZyZDhvcDA0eDcwQStBb0lCVVhNRlBK?=
 =?utf-8?B?d3JXdzl3Z2hpa3Iyc3F4Zm1UT1djMmpIZEo3c2hocGtPcGRyRHl4ek9UQUcx?=
 =?utf-8?B?UDNoYVFjVXltQ3ZPQUVrN3JLSlpQWmI5bzNyc2hMQWwzNVJIWWhsS0dMUGRy?=
 =?utf-8?B?MC9iMWFXWHVudktITEtxc0JlZitjdFNORTRVdFpTUUpieTV2Skg0bU5ldUxJ?=
 =?utf-8?B?M2REMVlsbm1Hd0V5c3FHbVZRY01QSTFkTUFqSHB5Qkd6VWV6WGJFeWluMUow?=
 =?utf-8?B?dmd3d1BZaGUyZjVQcUdlTmdCVm02QUxjTUhWU0wrWGpZKzZIQnJlNWd5MXB4?=
 =?utf-8?B?MkUxWGJvQnczd01kKzJERG85SkVadVYyRWQrZGZxbUxvcHdEZENxOGI4dEZN?=
 =?utf-8?B?UTNqSTlzaWZpTVA4VXN2SEJXUGR6VzRIMEhpUTRzb1FzUUJHdHQ4ZXJVaGU0?=
 =?utf-8?B?ZVNLMmgwR0pYWVY3TTkzYkhwU2o0TjNjdExGb1ZxWVUyUGhQSHNyNWJTWVo1?=
 =?utf-8?B?aVRDeG5xWHA3MWZkdkp4QWRkRlhRY2hHYzdQSkFlb3V5SlFXTFozRkZQUThT?=
 =?utf-8?B?YzN2NzQ3cVlWVHlZRjdPU09HMkg3dHhqcmh2cVBUYWlEelUrdWEwRThzNjlz?=
 =?utf-8?B?NStMV3NITHh3MFRvcGlLR0RFOHgyTTNVZDMxblRlZWdmYkNWU01UUEYzUzhW?=
 =?utf-8?B?TzBpQXE3cGl0YXR3aWhwc0NwdWUxWHAvbGRyb1pTWWdrUURtVlZhSE9pR3p2?=
 =?utf-8?B?WVhtREtyMDl3LytGTEhMTHBMTmFxWjZKZDJGL2RKc2FwWko2amJyajJoNUVJ?=
 =?utf-8?B?d3cvdEhpRUx4NTJNQVBxOWdHK1pUaGRYNXNvSlFjRnRCakFhdXJJbG1UemxE?=
 =?utf-8?B?U2lEUVBMTkRhZkozRWJtVmpLNUttTld1dG1PYnlNVE1rM0o1YU9ISjdMYzZt?=
 =?utf-8?B?MVJPUFBkNENPWWVuTnJlYXQ4MjNpak5tRzcyNXhuRXNiNWlpRmxxQzZiSWhW?=
 =?utf-8?B?WVNnYUJWWXBldHdjcDU0c0QzWDhTL0J3dTRCM1BaMmpXQXZXelZiS2xGZWVH?=
 =?utf-8?B?alpBWDJHdURncUVpMEUyK21PNmpUOHNXWk94VTJXczBZQWVFRWNhUlcyZTZ4?=
 =?utf-8?B?clVXZFZCdTFOSm9JZ2NFU2ZETHJnR2JhUlB2bXd1a1hyWFprYi9GdUI5a3Fz?=
 =?utf-8?Q?10RunN80TxXkJ+Uh/kintepSa4XTQl8saH6Fp3MTX0iY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1D2761DE9D5E142BC5A5ED888EEEEBE@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30c0d44-f291-48e7-452f-08dc329ec6fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 05:34:30.3860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1kpxAp5vxvrYnPyOM3l9B0N2DrTD8yG/1NFmyf28gAALRVdzYwoJ9XOGFHW632mBuwVM1ulXuueiVxL3IlC9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240220_213440_594152_5E039B12 
X-CRM114-Status: GOOD (  13.05  )
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

T24gMi8xMS8yNCAyMDoyNiwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPiBOVk1lIGNvbnRy
b2xsZXIgc3RhdGUgbWFjaGluZSBoYXMgdG90YWwgNyBzdGF0ZXMgYW5kIDEzIHN0YXRlIHRyYW5z
aXRpb24NCj4gYXJjcy4gRGVidWdnaW5nIE5WTWVPRiBwcm9ibGVtcyBpbiB0aGUgZmllbGQgaXMg
bm90IHN0cmFpZ2h0LWZyb3dhcmQsDQo+IHNpbmNlIGl0IGludm9sdmVzIGNvbXBsZXggY29tYmlu
YXRpb24gb2YgY29ubmVjdC9yZWNvbm5lY3Qva2F0by90aW1lb3V0DQo+IGhhbmRsZXJzIGV0YyBz
Y2VuYXJpb3MuDQo+IFdlIGFscmVhZHkgaGF2ZSBhIGhlbHBlciBpbiBzeXNmcy5jIHRoYXQgcmVh
ZHMgdGhlIGNvbnRyb2xsZXIgc3RhdGUsIGJ1dA0KPiBvbmUgaGFzIHRvIGNvbnN0YW50bHkgcmVh
ZCB0aGUgc3RhdGUgaW4gb3JkZXIgdW5kZXJzdGFuZCB0aGUgY29tcGxldGUNCj4gc3RhdGUgdHJh
bnNpdGlvbiB3aGljaCBpcyB2ZXJ5IGluY29udmVuaWVudC4NCj4NCj4gSXQgaXMgb2Z0ZW4gaGVs
cGZ1bCB0byBrbm93IGZ1bGwgc3RhdGUgdHJhbnNpdGlvbiBvZiBjb250cm9sbGVyIHdoZW4NCj4g
ZGVhbGluZyB3aXRoIE5WTWVPRiBpc3N1ZXMgYXQgdGhlIHRpbWUgb2YgYW5hbHl6aW5nIHRoZSB0
cmFjZS4NCj4NCj4gQWRkIGEgaGVscGVyIHRoYXQgYWxsb3dzIHVzIHRvIGRlY29kZSBhbmQgcHJp
bnQgZWFjaCBjb250cm9sbGVyIHN0YXRlDQo+IHRyYW5zaXRpb24gOi0NCj4NCj4gYmxrdGVzdHMg
KG1hc3RlcikgIyBkbWVzZyAtYyB8IGdyZXAgbnZtZV9jaGFuZ2VfY3RybF9zdGF0ZQ0KPiBibGt0
ZXN0cyAobWFzdGVyKSAjIG52bWVfdHJ0eXBlPXRjcCAuL2NoZWNrIG52bWUvMDQ4DQo+IG52bWUv
MDQ4IChUZXN0IHF1ZXVlIGNvdW50IGNoYW5nZXMgb24gcmVjb25uZWN0KSAgICAgICAgICAgICBb
cGFzc2VkXQ0KPiAgICAgIHJ1bnRpbWUgIDYuMjY0cyAgLi4uICA1LjI0MHMNCj4gYmxrdGVzdHMg
KG1hc3RlcikgIyBkbWVzZyAtYyB8IGdyZXAgbnZtZV9jaGFuZ2VfY3RybF9zdGF0ZQ0KPiBbMTcw
ODAuOTg4Njg5XSBudm1lIG52bWUwOiBudm1lX2NoYW5nZV9jdHJsX3N0YXRlIG5ldyAtPiBjb25u
ZWN0aW5nDQo+IFsxNzA4MS4wMDY2MjNdIG52bWUgbnZtZTA6IG52bWVfY2hhbmdlX2N0cmxfc3Rh
dGUgY29ubmVjdGluZyAtPiBsaXZlDQo+IFsxNzA4MS4wMzgzMTNdIG52bWUgbnZtZTA6IG52bWVf
Y2hhbmdlX2N0cmxfc3RhdGUgbGl2ZSAtPiByZXNldHRpbmcNCj4gWzE3MDgxLjA0MDczMF0gbnZt
ZSBudm1lMDogbnZtZV9jaGFuZ2VfY3RybF9zdGF0ZSByZXNldHRpbmcgLT4gY29ubmVjdGluZw0K
PiBbMTcwODMuMDU2NzUwXSBudm1lIG52bWUwOiBudm1lX2NoYW5nZV9jdHJsX3N0YXRlIGNvbm5l
Y3RpbmcgLT4gbGl2ZQ0KPiBbMTcwODMuMDc1OTA2XSBudm1lIG52bWUwOiBudm1lX2NoYW5nZV9j
dHJsX3N0YXRlIGxpdmUgLT4gcmVzZXR0aW5nDQo+IFsxNzA4My4wNzYxMTJdIG52bWUgbnZtZTA6
IG52bWVfY2hhbmdlX2N0cmxfc3RhdGUgcmVzZXR0aW5nIC0+IGNvbm5lY3RpbmcNCj4gWzE3MDg1
LjEwNTI3MF0gbnZtZSBudm1lMDogbnZtZV9jaGFuZ2VfY3RybF9zdGF0ZSBjb25uZWN0aW5nIC0+
IGxpdmUNCj4gWzE3MDg2LjEyNjQ4NF0gbnZtZSBudm1lMDogbnZtZV9jaGFuZ2VfY3RybF9zdGF0
ZSBsaXZlIC0+IGRlbGV0aW5nDQo+IFsxNzA4Ni4xMjY1MDZdIG52bWUgbnZtZTA6IG52bWVfY2hh
bmdlX2N0cmxfc3RhdGUgZGVsZXRpbmcgLT4gZGVsZXRpbmcgKG5vIElPKQ0KPiBibGt0ZXN0cyAo
bWFzdGVyKSAjDQo+DQo+IFNpZ25lZC1vZmYtYnk6IENoYWl0YW55YSBLdWxrYXJuaSA8a2NoQG52
aWRpYS5jb20+DQo+IC0tLQ0KPg0KDQpnZW50bGUgcGluZyAuLi4NCg0KLWNrDQoNCg0K


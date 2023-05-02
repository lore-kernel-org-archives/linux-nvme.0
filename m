Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BD8C7EE23
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 06:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5PQsHwlXiU/x1Ohxj4lMCfwHCjU4o5o4Y24GA96sCjc=; b=BtjHfkVN3VI4E0cObQe8M1XR01
	XeCP0O73rQW1yAfCvTgBYFknJsQlgIxROlKNozm6Zr7UE8w2F6Dy3ZbQtDzMnZZ9winazvm4Nf0jg
	+OqR4M/szroe+36QmRNZe/WE4Zs9gFplxeXLkChwkaEEQ9iW2CU11MBAx3IbzmITw6koAO8Ioc5lf
	fR92N7RhGkWf0tw/t7WKG6eB2RyLS43roQjWgIYRJU33U0JLqoyEKsqAMEIXoxtDNLn0RxJ2BTVqp
	LdRlpeethu5PnY0RuMpESPefBDAIDTqcxg2HAGZP0KHzR4T3qDdNYJTbHmUIg9UxXQhfmBJd27q5S
	9IZSh9pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptjoD-000Nyk-33;
	Tue, 02 May 2023 06:48:21 +0000
Received: from mail-dm6nam10on20623.outbound.protection.outlook.com ([2a01:111:f400:7e88::623] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptjoA-000Nxu-2A
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 06:48:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ne9XaWGuS3wKWA0aAA9SoWyScWmV8T5+W1n5v+5fG8GCxXSo6PMHNDRXBhigU1cz3NedY7Zl808xENV+yy4KTZv1PMJNsIvScu2ddlOxvV1i+HIVR+X01txA1924gpuPNCUmNp46O9o+AYOu/zzkIz4502u5PdSr+Swiyjde0POkBCpDCIkwXHibRLeXLu/Sgq0a8Z05FXfOvy3sIDgzxZwQipB9pZM8JqewaMqFMWGZQxENbdnviwgARD2P2nGUy3fIR/xd6ttu8bWnedgvnbr1F30eTwTew+RUnTIZjInLwkRfyw0gBPCGXzaFrcJSPTCBFKJqIqNaErv7ih8kjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5PQsHwlXiU/x1Ohxj4lMCfwHCjU4o5o4Y24GA96sCjc=;
 b=MOhKP8JG9qa025MydiGNpBVu1Ff18qSVRiWZuFq8L6yS1PgQ7BafgQieZRVQUr0PULFzuWxlOj4TEvNFsEsX3si2l/0SK157aXOLcwY5OIEYL78W0fM8lpWKn6EEydHVvt1vcgKaD27heBi532Qq/rF4v9vRmDwMoGdpvTS1T0BMAxnUdKPhSlfpGAE0isBJj3LuvBV4M8dhYYy54EDE7YIyEYcc0er/uV1OTaEofl3Gm/MIg3nIKfQ3lM4V4Ujyby+/Q02FOIZwOyzPZ7MvwqbOumFExFMo7xSxxM1NuEv0YCaHt10DZvwQ3ayTdE/imWzT8vXcQx3pKmMKwH+znA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5PQsHwlXiU/x1Ohxj4lMCfwHCjU4o5o4Y24GA96sCjc=;
 b=qQV+oKxGQSEnjImNQlLOaSy7TALx28GAyVfKIRdNWzOZPogLzG6w5YV6R741SaCIarxy10DoyIBHfzZxyDkoOWnw6fSNUaHWbfVGK1l9JgFNxYQR+BwQ5VXg1zQ5TXRhwIEJIa0hKTVxe9AV8mIbqzMAncjWYca2KmWeInxGb10y+UfdraKYsXg+qdAV0RZNNgu8LALR3SIYz6adrtOUnXiTsi95QVa3zNl1wnE8Nn6nZa4LVpwiD3B7yB9I33RCUW9zOkYotwhz0pKBalG9zHRHJJCFbUOVg/ij8vyjRuXi6JwqA+Ivp1R+jBFaqfDDtnZHf8+sB40ftTGXjxlS7A==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DM4PR12MB7767.namprd12.prod.outlook.com (2603:10b6:8:100::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Tue, 2 May
 2023 06:48:14 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::6922:cae7:b3cc:4c2a%6]) with mapi id 15.20.6340.030; Tue, 2 May 2023
 06:48:14 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"sagi@grimberg.me" <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
	<linux-nvme@lists.infradead.org>
Subject: Re: [RFC PATCH 1/2] nvme-core: factor out common code into helper
Thread-Topic: [RFC PATCH 1/2] nvme-core: factor out common code into helper
Thread-Index: AQHZeN6kYHxgV9GzuEmJelbJr9wN+69GiCCAgAAKRQA=
Date: Tue, 2 May 2023 06:48:14 +0000
Message-ID: <8d4b2eb1-69a3-439e-4e2a-c5f044b448d4@nvidia.com>
References: <20230427080207.17249-1-kch@nvidia.com>
 <20230427080207.17249-2-kch@nvidia.com>
 <36388510-a053-14f6-654b-98317843f290@suse.de>
In-Reply-To: <36388510-a053-14f6-654b-98317843f290@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DM4PR12MB7767:EE_
x-ms-office365-filtering-correlation-id: db536b87-3212-4d6c-1040-08db4ad9340f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:  Y81wMJZT+XFnwvQ2MciYLcpuDaTxipCwTRgjhIkqTqUFbcH/Umy/cW3fJ9OQ6+THqqS5oBT7JSp1+tnNwbFo5YzhR4pnzNS8g28EODHkgTaaZGZpUoGhOU/Rinu5r2ux4Iq1QIf2sJXKoQbfaAyTA1bmD7jIwEm0QtwlRMQfZqp8s5nb8Pkyt3haM7XeLkc95l2t+thXDvqAwKvhF6T2llmOh3YipKJgILoEITWK5BWmNvVXqXDJUzgWUsZ9TCEQ6GnY/cJ+hUFAoW6DAaELmjdsgYgkXMgN9RpjVfmzLQT32mxQU7+oYHXY0tOUhY7xnj+7p3nZToiCJON1RqOYPCEib9uVa0C7NB3FbvwIWhQRkEygMnb64lzr24w93vSMn91RzJpoapKMZcAsn/E561vpjs/r8qd5rOEkW2mJSTWERytSpJRBgwyzdUJwQNWlX/l3FY2rU4jOqmCTKmOfMFLF6n0G64EFxhwF3iSfChjVWtWuIG7kW4uXlHNX2SUNqJgoM/wH6S4/LMefCeiH9mrZZhz2Ombqu1xUTXcD4ozavIXM38lSeVN1gNVBu90NnWK3s+j4RIlcbmRu1HrcYXTZqHVB5u49bVKOxz4Eesmw3rIyFiTpiXlWvJl4VJqJMGut/YRzRn5ETNt+lfVVJw2pKwSbxQJs24wuPTwdkgIaldmEU3irMR6AAYuK7nbu
x-forefront-antispam-report:  CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199021)(2616005)(83380400001)(478600001)(186003)(31686004)(54906003)(4326008)(91956017)(76116006)(110136005)(66446008)(66476007)(64756008)(66556008)(66946007)(53546011)(71200400001)(6486002)(6512007)(6506007)(316002)(66899021)(8676002)(8936002)(5660300002)(41300700001)(2906002)(38100700002)(122000001)(38070700005)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:  =?utf-8?B?Mi95dFIwZlpZZUFKQnhoT29HNlpWUWQ4M3drZ28xUU0xVHpQZDNETVk3U2Mv?=
 =?utf-8?B?MlNFOFF0OUlmMFhuUVNMM0dpM1l6QUpYRnBkdXJQb1RGSkVtN1JYdzRrZFBD?=
 =?utf-8?B?TTNsV0NqdjRSTDFBZUtsWG5SS3pIdTYwUkoyZDVWeUJuNWFxL0pBQnJzWWpn?=
 =?utf-8?B?MlZQVHhML0Jhb3Z4WkJoK05xRjRJOHk4K2JCcjNQYzhlQWlObUNVaUNTeG1i?=
 =?utf-8?B?S29hK3ppOFVPbGVLM1c2SG1FNTdIVGI3R2huN0xWYm5RWWdkV3cyc2U3QjlT?=
 =?utf-8?B?RVlyTW1GelMzWGVRcnNoTEw5UUxLM0RwWDVETWgveTJaYVJLTDRxVlZydk9X?=
 =?utf-8?B?dUh0WkkvdS82bUFPZkxhUWdSTlBDbVJOV0taY2JQeCs5TEFhWFV6NkhZN0R5?=
 =?utf-8?B?ZmM0dXJOUldDcmJ0QnY0TmV6S0lWNy81aERIMFI0SVVYU3JMeW9TRHBLaGds?=
 =?utf-8?B?aVhWWnJXVXd1TmlZMlUzRkZUS2NwNTQyZkJUWkdxSHRWWGpFcXp5L2dnSEFT?=
 =?utf-8?B?bVRHRU1jYmg1Z2xSYlV0Z1NEdy84OVYyUjBURXhYUGhQalZuVHRxZllOV3g1?=
 =?utf-8?B?K1FCaWlGVHhVam9yREFKeEhpeWdLM1NYekVheU54VkI4WXFkQ3pQbUxlUjkx?=
 =?utf-8?B?eWw2L0FpbDhXVitZWURLRE8vTEp2VGtjT013dEswdHBTZ2hxOUcvMG1uM08r?=
 =?utf-8?B?UW92THBzbElSd1VWdmNkZXRML1I1RGV3SUZWY09mWW5QNGVCK1U1UEpQb2l1?=
 =?utf-8?B?cUF3ZkVuN3dIcmtOWVcrOE4wZWI5ZVVmRm5xRUMwYXcvZXBwVHNjVDg5V3Ay?=
 =?utf-8?B?S0RvelRuMEFwdS9ramZOOEREaVVYR0tCUFFWeFA4bHVzOW1tWDFKbUZna01p?=
 =?utf-8?B?aGxwSmVGSnAxczlOOEJvSEljL3JSbTlORC9HTTJoQzlONzhpNFFVRTVSOEN3?=
 =?utf-8?B?MGRYVGFlY1U5WTZCTHRCTmF0blQrRWZpZFdKOFE1ekFjajRaakRzL1A0SVFT?=
 =?utf-8?B?OExOQ1VmUXZ6Z3R3WVJBTi9pSHZiZ2FnTWpVdVV0ay9UblRvaXFVc1JRSEFw?=
 =?utf-8?B?NHovTXZxd2pFVXBueHYzbk1LYXBUTG5Ld0ZCTGxaTUZkUzdha3dNVGJtZEZS?=
 =?utf-8?B?OEludXo1dnNjSVB2dWcyazJSVTFvS3ZHeWdjTER0ZkprWW5IMlEyeEgrQUZi?=
 =?utf-8?B?RkNmWW1WTWxzUW5PMlNaKzVjMnJROE5Fck0vdy9oMEtpcWNZZG93WGI0SHpw?=
 =?utf-8?B?aGozQzhQMG14dDE2bWhjbGhyditzV2dpN1QxVjdvaFg0OHFKV2g5TlJzaUFM?=
 =?utf-8?B?b29XZEVQZjJ0d0hqeS9ySlR3RkRuUEpVTS9CZTQ3L0I2N2hNMjFzZkhIY0Fa?=
 =?utf-8?B?VTJENU5haFRTdkxNTmkrQWk4Z2dOWUkxaXdFeTVsc2FBRlNLOVBFM3dRak1t?=
 =?utf-8?B?aFBBaGMvWjVYZFFaa2MrZHA2NXgxNkhabXlyaUFXencxQTlJclE4a21scVJw?=
 =?utf-8?B?WWtNVlVsbHRLSFdhZm1LbWs0bDNhVS92ZTh0OXREKzFUbEk2U2pwaEcreUxX?=
 =?utf-8?B?VW5uYXhscGgyRW8zYkFIanlwYjA2L0JUSmRaZ05PM2J1UWo5dVJIYktNZ0k1?=
 =?utf-8?B?SW5IWUQ1VHBlWmN5VHpyQml1OWdqZHMzMXZQLy9OSjgyOWZQSEwwSGtIUFd2?=
 =?utf-8?B?WmFLZ09nZEJDYXAvSG9JWHZHcVdRbzUxQy9tcklNU091TTQ0d1R5cGMwYzB0?=
 =?utf-8?B?aGNodC9CU0w5OCtpamNXV3lwWXF1QVpBbnZSVVNZRjBVQTNkRDZYVFJIeldW?=
 =?utf-8?B?R25OV3NnQ1dXYXA5NU5nbE5VYnRUM0VlV3d5MXZ6WEdMMXZOTGJvVHdIbXVM?=
 =?utf-8?B?RTVndGd6bUtqRE9VN2VlbW5mMG55dDNuY0Z1Vnl0RE45elU3ZVBXS24raFJm?=
 =?utf-8?B?UDJ6Z01NRmZtYTJEaVhBQU1GbWlvUFZFNnZFYXFkd2djM1RMYU9ubEs1b2Iz?=
 =?utf-8?B?VmVXYlNVSms1SGxncjJwa2NoUVYrNHAyZmxrcWtka0NCSUdsOU5VbWoxYngx?=
 =?utf-8?B?eCtyNzlKNXM2dDZBNC9lSW9rZVIxUUVJdUxOZVRWczVqSVlIdk0wNGY3aWc2?=
 =?utf-8?B?V2xod2N6OHBEYTVqVHJpQk5xcWNxK1NaY2I0Z3R4S2xWN2J6dVQ5enI4RWtV?=
 =?utf-8?Q?JNetiHwjeh7TVvF2cuUAD7qn8lFSUR8EsGi3bt20RgXN?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <558F443583C1604DAF8EF810B1660061@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db536b87-3212-4d6c-1040-08db4ad9340f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2023 06:48:14.4460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FIwbGHVfl8+18xgijw7cL/ru7DI+a8N/JFD9KcJsW6UdyJ0pCqOP8bLu3fwT7rg9pwZvzBFZ9V5Eh2NjYQSb3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7767
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_234818_784068_E6CD25B4 
X-CRM114-Status: GOOD (  17.44  )
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

T24gNS8xLzIzIDIzOjExLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+IE9uIDQvMjcvMjMgMTA6
MDIsIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+IG52bWVfY3RybF9kaGNoYXBfc2VjcmV0
ZV9zdG9yZSgpICYgbnZtZV9jdHJsX2RoY2hhcF9jdHJsX3NlY3JldCBzdG9yZSgpDQo+PiBzaGFy
ZSBjb21tb24gY29kZS4gSW5zdGVhZCBvZiByZXBlYXRpbmcgY29kZSBpbnRvIHR3byBmdW5jdGlv
bnMgZmFjdG9yDQo+PiBvdXQgaW50byBoZWxwZXIgZnVuY3Rpb24uDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogQ2hhaXRhbnlhIEt1bGthcm5pIDxrY2hAbnZpZGlhLmNvbT4NCj4+IC0tLQ0KPj4gwqAg
ZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgODUgKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQ0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDMxIGluc2VydGlvbnMoKyksIDU0
IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4+IGluZGV4IDQ0NDA4YzBjMTc2Mi4uMTcx
YWUxZjIxOTdhIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+PiAr
KysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4+IEBAIC0zNzc5LDYgKzM3NzksNyBAQCBz
dGF0aWMgc3NpemVfdCBkY3R5cGVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+PiDCoCBzdGF0
aWMgREVWSUNFX0FUVFJfUk8oZGN0eXBlKTsNCj4+IMKgIMKgICNpZmRlZiBDT05GSUdfTlZNRV9B
VVRIDQo+PiArDQo+PiDCoCBzdGF0aWMgc3NpemVfdCBudm1lX2N0cmxfZGhjaGFwX3NlY3JldF9z
aG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2
aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY2hhciAqYnVmKQ0KPj4gwqAgew0KPj4gQEAgLTM3OTAsNDEg
KzM3OTEsNDAgQEAgc3RhdGljIHNzaXplX3QgDQo+PiBudm1lX2N0cmxfZGhjaGFwX3NlY3JldF9z
aG93KHN0cnVjdCBkZXZpY2UgKmRldiwNCj4+IMKgwqDCoMKgwqAgcmV0dXJuIHN5c2ZzX2VtaXQo
YnVmLCAiJXNcbiIsIG9wdHMtPmRoY2hhcF9zZWNyZXQpOw0KPj4gwqAgfQ0KPj4gwqAgLXN0YXRp
YyBzc2l6ZV90IG52bWVfY3RybF9kaGNoYXBfc2VjcmV0X3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRl
diwNCj4+IC3CoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgZGV2aWNlX2F0dHJpYnV0ZSAqYXR0ciwgY29u
c3QgY2hhciAqYnVmLCBzaXplX3QgY291bnQpDQo+PiArc3RhdGljIHNzaXplX3QgbnZtZV9kaGNo
YXBfc2VjcmV0X3N0b3JlX2NvbW1vbihzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLA0KPj4gK8KgwqDC
oMKgwqDCoMKgIGNoYXIgKipkaGNoYXBfc2VjcmV0LCBzdHJ1Y3QgbnZtZV9kaGNoYXBfa2V5ICoq
b3JpZ19rZXksDQo+PiArwqDCoMKgwqDCoMKgwqAgY29uc3QgY2hhciAqYnVmLCBzaXplX3QgY291
bnQpDQo+DQo+IEhtbS4gSSdtIF9ub3RfIGEgYmlnIGZhbiBvZiB1c2luZyBkb3VibGUgcG9pbnRl
ciBpbiBhcmd1bWVudHM7IGlzIGFsd2F5cw0KPiBmZWVscyB0byBtZSBsaWtlIHVzaW5nIHRoZSB3
cm9uZyBhYnN0cmFjdGlvbi4NCj4gQ2FuJ3QgeW91IGp1c3QgcGFzcyBpbiB0aGUgY3RybCBhbmQg
dXNlIGEgJ2Jvb2wnIHZhcmlhYmxlIHRvIHN3aXRjaCANCj4gYmV0d2VlbiBob3N0IGFuZCBjb250
cm9sbGVyIHNlY3JldD8NCj4gSW50ZXJmYWNlIGlzIF9mYXJfIGNsZWFuZXIsIGFuZCB0aGUgcmVz
dWx0aW5nIGNvZGUgd2lsbCBiZSwgdG9vLCBhcyB3ZSANCj4gZG9uJ3QgaGF2ZSB0byBkZWFsIHdp
dGggcG9pbnRlciB2YXJpYWJsZXMgYWxsIHRoZSB0aW1lIC4uLg0KPg0KPiBDaGVlcnMsDQo+DQo+
IEhhbm5lcw0KDQoNCnNvdW5kcyBnb29kLCBJIGRvbid0IHNlZSB0aGUgcmVhc29uIHdoeSBib29s
IHdpbGwgbm90IHdvcmssDQpJJ2xsIHNlbmRvdXQgdjEgd2l0aCBib29sIGFuZCByZW1vdmluZyBk
b3VibGUgcG9pbnRlci4uDQoNCg0KdGhhbmtzIGZvciB0YWtpbmcgYSBsb29rIC4uDQoNCi1jaw0K
DQoNCg==


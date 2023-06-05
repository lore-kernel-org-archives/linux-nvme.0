Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6CAC7EE23
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 08:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7nXH+2whgHT7IiX6HTELetMWvc4G7obNjkqE8GcA0GI=; b=h5Y9GO2A6Fc2IvFrEyB4AMbJYD
	S82J8VslySXuwfqljhDjhPbJ9Kbl5BF3K14HJmF2NG2NfAioZ7Vc2YzdUsT5BpiGgbmx85z6d2obd
	gro4GVwC1PoPcpfIVrtHLNvTxy/uQE5hkL7ukHN2ZsMqRMqUB3icqTZT0eIl5m8FyoC0KZ0RYhrXu
	tv8gsw3c3eIj7ojJxzCSYJF511DcyVw4Ln+2I/Tlxm/K5itdHcXCgiUK8rPRVrdezmjf0s3ARJFSx
	aAh5hp5Cll8NJvrvh0jIbJF4lrVki2LFwIfQ6as5cMHR9v6YQ/46Os75xPbQj4qdUrQ5iZ5z5uLo1
	2SvCOecw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q65mO-00EjqY-0x;
	Mon, 05 Jun 2023 08:41:32 +0000
Received: from mail-mw2nam10on20614.outbound.protection.outlook.com ([2a01:111:f400:7e89::614] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q65mM-00Ejpg-08
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 08:41:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8VVR+hPuvrD1vlOCM8kKxo/4Qzll8epPIs8vF7YuT2n+ggPfXN58yLEL3Gwb9MAYYK48ku8h1RJ4ZKfxl2Xo6tEoRsB2akWkDVQCLxlPk9LXA6fcWx8KSnV/EeGBhl9PkHA0/KotxpCHezAAFGX2nG9ZPZ6SkyLs+uytqyVmrthfO638FuuB/m0zKSlZVzdMcVsL4IVMGUZrOU5cF5ak3DsyxsfsihRHP7SIoki0QrexXM1gR8OplLcT5It09/RStVtEKJr1RvMb9M+EoWo4/URySRVDQOoXn9Xru2fvaOw94cknGTFB/omo4/7fu8Gt9smK/yxmpzGFkrpJ3UUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nXH+2whgHT7IiX6HTELetMWvc4G7obNjkqE8GcA0GI=;
 b=WvjaxyU9EWZP+IQZHR8j1RzXr2GEIL/10Ee+63jLRT/vzTn7SosQh6q1TUKvEEqAU6c6pE5Ovw8zHkUX6+LbF8aDkVIp6RMWQTXO8yN8erxC1no+ZAYGja8444PCDcnYA7wjynSTwJoyoglfjTJomLsIwMb4crTh4c09auVfV9QYKhhSoMeihDidlZrGoNGWrAZzVV7kmHbmIUMwdHuOVRlgqMxTrBnU1l/uyK8dxaYd35rZhDVzzcOaJl/Z6wLlJ/aUje1oLAIOd9uKzkmjml79nfhKA0HGCbwMSFq/1ft8TL4efTnN+05aJmGe06mRwNJPASWM8zuuJWtYIE8CVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nXH+2whgHT7IiX6HTELetMWvc4G7obNjkqE8GcA0GI=;
 b=HAU1FENIvXnOFIlIUSx14gSVyiUvTFto5DKFdkrEjgwhgJl5pBDuQDXBac5LBmBz7vTqzd3mS2aUFT41XeqWZ8GJFN0hokPJh9Q+akJSZnZc3C04qK8ztn9hEmVrx7dxaksBMlswfNLmz//mFNVynrw4YHtbX1FotosOBCHUyfobt9mGOpPHfz7lwlpf2/C0f2mw04IZYnuOHxAMSk21tvibsKJb0NsqsnLDtNjD0rbwime9+xjrsjdvZe1cW/77NQ00EPfgg/Pz5NtV+poNL+QmN+tDatbApHjhJG43xtv/5VkzxqRAbBOZOIS5cbyzQLM2bTI1NBstL/Y79ix5rQ==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by DS0PR12MB8526.namprd12.prod.outlook.com (2603:10b6:8:163::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 08:41:15 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::92c6:4b21:586d:dabc%4]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 08:41:15 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH V2 3/4] nvmet-auth: use helper for auth send/recv cmd prep
Thread-Topic: [PATCH V2 3/4] nvmet-auth: use helper for auth send/recv cmd
 prep
Thread-Index: AQHZl3lVtjbENO9KDUyTNdUZkF8XZK971MuAgAAPPIA=
Date: Mon, 5 Jun 2023 08:41:15 +0000
Message-ID: <6ec91742-9da2-61a1-c4d8-18bf1786b9aa@nvidia.com>
References: <20230605064434.45233-1-kch@nvidia.com>
 <20230605064434.45233-4-kch@nvidia.com>
 <d9785297-d603-1ccd-91f2-9490b104b07a@suse.de>
In-Reply-To: <d9785297-d603-1ccd-91f2-9490b104b07a@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW2PR12MB4667:EE_|DS0PR12MB8526:EE_
x-ms-office365-filtering-correlation-id: 66d9f2f6-4b48-462b-ee4a-08db65a09fef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uo4VLZivDBEeSDp6ynzCKFCDBP7bDxyEBhjWroz1kecj3a2zHccFVmkl3x/3mw6HSsnE9yemgOPROu9r5xe98FwYguCrs0odItFjJKzeUm6qs3baL/ETvRjVkSDZVDSJxCo2xrRhjWx0rJWpgPCUM/XE7s7HZxRaRjLMfzVJfxUeBC3hy8rEPqR3eW8Dmv8swc3GGW1IRkRV+dnd+XUGZdjaM5uMKNVFc5XmnsdxXkfFu1mIHHKGgFecxcQIKK+RDqxgkIxc8w982TOzVRCEdfg6zDJL1uuz0Grofaa8JE9a1UeFItKNGVCPF4o8ZRJN2MJ15TKhKamYtwF+V0WjVSdgeHTpfDW2uwIWM1yI9Psiijirj5sKM4OohNTeYTTkj+gR4LbT+tqvsVJng2OsMYhdX+SpSaecwJLVvYUaXd0JQY1Yn3IIZ1Z8SE9SWg9mssZCOZT9/MrDjaESRJJ4nT9mA8BDX5VWONvGJ+5gc30coCcWd3Hh+n7pMJwCOCoyGrAOQvlKxQ3SL1u1ZJFB5xCiNCkzjy5iYuOnVGoy8lP+9qBmiQawGcMWGkj8cYE+V4Eja+mOzAdEGzJCIBmcPbv7nIVuA+w7j9HifN/kqSpIJVLjDcPiHufDvyAAYG5B9MX2AvkWCPJ81/oCedaQY7bi5ZY/q/bNA9/d6RIku7esBALPzWsSluzFP8VhpobR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(6506007)(53546011)(6512007)(38100700002)(2616005)(41300700001)(31686004)(6486002)(186003)(26005)(83380400001)(71200400001)(478600001)(110136005)(54906003)(4326008)(91956017)(64756008)(66446008)(66476007)(66556008)(122000001)(76116006)(66946007)(316002)(8936002)(8676002)(5660300002)(2906002)(31696002)(86362001)(38070700005)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlNtU3BxZzQwVFBnSkVUb0dsZm95S0dJdm9SbC8vQ2NHSHNVMTk0Ty9NMTJO?=
 =?utf-8?B?T0JLcGQ3ekxUYm9hdzBTQTYyK0dJRmsxWXd4VS9IWTY4VE1DWGhhUDNGRjBQ?=
 =?utf-8?B?Q0ZZd2ZzMnA4Ync2NFVlRWU2TGRjMEE4RXVIaFJPbC9iSDZ1OWVzUy90VC9x?=
 =?utf-8?B?NkptUktKSzJBWkJoR2oxMXZYRkoxZUxQbGRkYUVERDRhbEVrOGM0UUxyakdz?=
 =?utf-8?B?ejFKNG5zUnI3RGxNMzIvUHFkRVRWb0V3T2RvZEpFNFJWUWU3czVPZ1NKQVV4?=
 =?utf-8?B?NmFjdDJNWTdsbFRVU2o4ZTZnUWt0K0FYMFVFaWwrNlM5MVdvMVEzVnEwTzZr?=
 =?utf-8?B?WXQzVUlNZndQWTVaYWE4Yi9FMmVPTUF4TTg0Q2l5cnQ3bzFXRGdLWE1JSGpm?=
 =?utf-8?B?bGZwWFZVRGxmV1JpcWRNNTIvZ0dVUjdWMHg0dFJZWHNuMGYwMjlGakEwOS9y?=
 =?utf-8?B?c0lxa3MySjNHNXlUbVRMN01rZ29pek0wRFVZY1Zyc3owdllqU1R4dmhNVGo5?=
 =?utf-8?B?TjROM2d0dVdSdXZZVkRmZ2ZhajhrUitjWTI1VmUzQTM1NVpmblJVbkZ1T2Ir?=
 =?utf-8?B?dGxyZHM0Njd0MCtPQzkyMzFFNHJHdjZjMGVPOW0zcTNJYlQ4Uy9SSERDbVpo?=
 =?utf-8?B?cHl3UU9OSjJGdHV1V0tJRzJML3hPT21jQ25qRGdwaGtoUHlzeUlnQVJUMUg0?=
 =?utf-8?B?TTBDeTZSbFAyd2R2Yi9taUpobjdTcCthamdZSzhQc0h0eVIzNWJ1WVFSajFO?=
 =?utf-8?B?TC91VkFtdElIK0tRSVgyYVpnSFhLREk0Q3E3UXZiWmlVTVU3QUIvYko4NG1N?=
 =?utf-8?B?U2VoQnVEUENSU3N5MDNJZEVtWS9vTTVMLzFFTGsxcmhpczdtS3BERmNTRkRr?=
 =?utf-8?B?T1c5N0k2SnZXT08wQi91Ri81ZFBMNnBCZWxmYmNnZ1cwWVA1UUhGQy9Zdjdk?=
 =?utf-8?B?VE8vV0toZ0l1YlBzRTltbElyVUluTVRDNmhkVnJTQzNZZGpQZ0ViWHhYbEVG?=
 =?utf-8?B?TllpaXRLVVNhNXJiWE9nc0xsellkemcrNTBmN3E1MGNYYWovb2Q3QUdwdkFs?=
 =?utf-8?B?LzJYN0U1Z0g4RTlocmpNME5QSWgvRGJNSTJkcis0QlVRVWhnYVd5eFd1cmhw?=
 =?utf-8?B?ZjhyWWhzY05tRlBwbjR1cGx6Vng3VFNNV2dXOTd0UWZpL0s3Q3VMdVhldW1K?=
 =?utf-8?B?UzVXOVJSUjNKdm9mZEJ0ZDBZMkVHZEU1OGNhMHQ0Z25oeGhFMGlIV3dadzRK?=
 =?utf-8?B?U0YxNGptajNFQXozVmZ6eUY3LzBhbTlRNFF5SXRkSUxZR0dsb0JzbWcyMTNC?=
 =?utf-8?B?cWR1RzdFbFIyZ0xKQ1dYUHUycTBpS3hmOHZyS1U3OUNRMTFkUDFxVlJ6R2JL?=
 =?utf-8?B?akwzZ2UyV1lweVZ5MktoSFZqU2R0S1RrME9iV09qSFFrUDZ2OFJvWHZPeE9O?=
 =?utf-8?B?c1o3djM3ejhRZWZvMzgrQmRYNUJNK1RNVW9vTG9aVFpaeVl5eWxDWWN6dFJw?=
 =?utf-8?B?SHZlN2UzVjZTZkJma0o4ektvNXBzZlE2NTFxaVVBeWorT1J2VWRCM21Cc3VW?=
 =?utf-8?B?eFpnK1ZvWkU3M0p1R3NSamU4elVvTXZOalVmYW1LZHpKZllZb20yM2lQRm41?=
 =?utf-8?B?NG9XVW5BSmFhbWpxci9wRWtxTjVjaWRxSVhmOHJ2TlJ2citib01mRXlWTkI0?=
 =?utf-8?B?Smw3SEZqZmRuME9kZU1PeE8yblBSSXFnUE1Vd0lOcUF6UnFGR1VJREt5dkhS?=
 =?utf-8?B?RFRjME13VjhjK3NqUnRQQ3NRb0tQdnBJN1VoUmtYV2xMSStocmFTWTZoajZa?=
 =?utf-8?B?ZmM1YzhEcEVobDkyN3ZCYUdLSkJydjY5aTV2R2ZUTitEYlFQUE5kS3hBRG1K?=
 =?utf-8?B?VDVrMGoxNzhtZnY3ejRESWdRaytaQ1JJSnlmeGlKeDhyWVdOUXMxblA0UlNk?=
 =?utf-8?B?S05sVk1pQ1FhZUx4dTB5aGJodWVGNk1vQmZNZXdHeCt5SnF4cUdxNlVmNDlG?=
 =?utf-8?B?YnQ1bFAwRjRBUk9UMUNmTFgycytZZFJ3NG44V1ZVRE1zTHlscGljdHlpRjlw?=
 =?utf-8?B?Z2VVRWtvMWlkeU5iNlZXcy9XUGhkdFhTK1N6c1pYdE1VR3NwOXlrV1grUXRs?=
 =?utf-8?Q?yU0ZSOKUpDE4Iv1tzQ/n2Uwjn?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B82B511E1566E046B7DF5D5711E9BF07@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d9f2f6-4b48-462b-ee4a-08db65a09fef
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 08:41:15.5289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O5jAeLXcKzHF7eCi6nCol2VIN0PtxUCXb34zu1H3LtTheAPljti4IwcWpCUmdw6uw7bELtYpLaqCHH1mBA++PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8526
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_014130_081719_62AAB80E 
X-CRM114-Status: GOOD (  12.90  )
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

T24gNi81LzIzIDAwOjQ2LCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6DQo+IE9uIDYvNS8yMyAwODo0
NCwgQ2hhaXRhbnlhIEt1bGthcm5pIHdyb3RlOg0KPj4gQWRkIGEgY29tbW9uIGhlbHBlciB0byBm
YWN0b3Igb3V0IHNlY3Avc3BzcCB2YWx1ZXMgY2hlY2sgYW5kIHRyYW5zZmVyDQo+PiBidWZmZXIg
YWxsb2NhdGlvbiBpbiBudm1ldF9leGVjdXRlX2F1dGhfc2VuZCgpIGFuZA0KPj4gbnZtZXRfZXhl
Y3V0ZV9hdXRoX3JlY2VpdmUoKS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFpdGFueWEgS3Vs
a2FybmkgPGtjaEBudmlkaWEuY29tPg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJzL252bWUvdGFyZ2V0
L2ZhYnJpY3MtY21kLWF1dGguYyB8IDE5ICsrKysrKysrKysrLS0tLS0tLS0NCj4+IMKgIDEgZmls
ZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2ZhYnJpY3MtY21kLWF1dGguYyANCj4+IGIvZHJp
dmVycy9udm1lL3RhcmdldC9mYWJyaWNzLWNtZC1hdXRoLmMNCj4+IGluZGV4IDc3ODk2MWUyMzFh
My4uZDMzMWMyMmVkMjZlIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9udm1lL3RhcmdldC9mYWJy
aWNzLWNtZC1hdXRoLmMNCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS90YXJnZXQvZmFicmljcy1jbWQt
YXV0aC5jDQo+PiBAQCAtNDEsNiArNDEsMTUgQEAgc3RhdGljIHUxNiBudm1ldF9hdXRoX2FsbG9j
X3RyYW5zZmVyX2J1ZmZlcihzdHJ1Y3QgDQo+PiBudm1ldF9yZXEgKnJlcSwgdm9pZCAqKmJ1ZiwN
Cj4+IMKgwqDCoMKgwqAgcmV0dXJuICpidWYgPyBOVk1FX1NDX1NVQ0NFU1MgOiBOVk1FX1NDX0lO
VEVSTkFMOw0KPj4gwqAgfQ0KPj4gwqAgK3N0YXRpYyB1MTYgbnZtZXRfYXV0aF9jb21tb25fcHJl
cChzdHJ1Y3QgbnZtZXRfcmVxICpyZXEsIHZvaWQgDQo+PiAqKmJ1ZiwgdTMyICpsZW4pDQo+PiAr
ew0KPj4gK8KgwqDCoCB1MTYgc3RhdHVzID0gbnZtZXRfYXV0aF9jaGVja19zZWNwX3Nwc3AocmVx
KTsNCj4+ICsNCj4+ICvCoMKgwqAgaWYgKHN0YXR1cykNCj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1
cm4gc3RhdHVzOw0KPj4gK8KgwqDCoCByZXR1cm4gbnZtZXRfYXV0aF9hbGxvY190cmFuc2Zlcl9i
dWZmZXIocmVxLCBidWYsIGxlbik7DQo+PiArfQ0KPj4gKw0KPiBBIHdyYXBwZXIgZm9yIGEgd3Jh
cHBlcj8NCj4gUGxlYXNlIG1vdmUgbnZtZXRfYXVjaF9jaGVja19zZWNwX3Nwc3AoKSB0aW9uIA0K
PiBudm1ldF9hdXRoX2FsbG9jX3RyYW5mZXJfYnVmZmVyKCkuDQo+DQo+IENoZWVycywNCj4NCj4g
SGFubmVzDQoNCmNoZWNraW5nIHNlY3AgYW5kIHNwc3AgYW5kIGFsbG9jYXRpbmcgbWVtb3J5IGFy
ZSB0d28gZGlmZmVyZW50IHRoaW5ncywNCmxldCBtZSByZXN0cnVjdHVyZSB0aGlzIHNlcmllcyB0
byByZW1vdmUgdGhpcyB3cmFwcGVyLi4uDQoNCi1jaw0KDQoNCg==


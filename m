Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8AAC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 24 May 2022 17:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TjVKUk1BUf8JIj99EjYZSjIHC3rE5WvzozY9sy2CXp0=; b=yWZVUGyJCl7YflSZC1rmVuPLst
	Udt4IePEnxoR7M/S+r0gP5+z/waKO0LCvRog3i5zBwrA/BPS9Nm7PyAYb4sFCaf0u4YH1ws5zx6Dr
	qU4fAhwE9POVPCbKUrPWakkM/UXOH/1eZbHXz0ATet7EuP3ixECM/ASV9wY/3Kixv+kGCYzRLVHv3
	3s7SKGxojFhggAVYJukTJDOCTpfLBhbbyvdOxd/9E+3GvhLnMCW1tZYLOy3aq5jAL6zcAZt/Vqh/w
	zww6LixYT/+nea6xNPmdoiFA4j0J+eGU89M4D021puFuwUimoc3JEWeZ3NU3y63JhfxXrBhaUDxDR
	vzt+Q/9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ntY0Z-008iBy-Tx; Tue, 24 May 2022 17:07:48 +0000
Received: from mail-db5eur01olkn0818.outbound.protection.outlook.com
 ([2a01:111:f400:fe02::818]
 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ntY0U-008i9G-7e
 for linux-nvme@lists.infradead.org; Tue, 24 May 2022 17:07:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKLstNNyrkF8ho+612a/JfPi763mnb94GJMyJwwNcpMocVKXpVxT4se2+CZQZZE7tBsMwk/ySmWuSttpLXn4Q/a2oUlSDaN45TWgG5cMWSDitZLn7y4VVbAZb40eAwBCgcUElDQcwYvTfYkrHxFvICHWUAD7MdNE8sM9YYXP/RKlNIicLgAwsxJgLJeVW+FddPMGlMG+pkgwIELz1yebYQjNNy7DjdOu3/0tQv5MTYg0TwH8RBCTA1uSMlQ3CKgZFM/OdzKRbSaLDS+ClqS4ns8bKOZk5Kt3jgW3HeJ7Llk7EtuU0Qm9AubLZo6rPZn8ggEmuIS8BryVG2UffXzLUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjVKUk1BUf8JIj99EjYZSjIHC3rE5WvzozY9sy2CXp0=;
 b=MHwXdhENf/waMJUtC977aYffPOfgrFbVHT2bUYmtHHtT/sH/rWJw5sNPodzmEHpT4ehKLanTf6zlALFg4NJv4mT2FbpC3/Y04zmICMAF2GoH6kTFvQeVaQQi5cnoC9pJPkTEL41U/+pa6L3KzyahD/cSOtHYE56PA7jKvVbe8fL4a5ibMUnSWK08FwsxfUJKfheQ0nxl3FcL84mKS6rck6Gz+YH04IpO9V0/0ObX8S1/hSgX9QSMchDykMJsXttcA80VTCFyvCshqFNpKNPd+SpB8jaPNLY1rFL53qlFovElhqL1aQ7ihQwVcRi1kflb0TCmb7HDEkjNZMTsbTOKXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjVKUk1BUf8JIj99EjYZSjIHC3rE5WvzozY9sy2CXp0=;
 b=FuFzNMK4afwz8VTeGMrDTF3SRSrwgIpBwbdt+p8uvjnuUO7Lqn0R5dY2Cmk7tKZeNis4h+mP3EqSNom3NC0EorGNunKrf5Du204hIXWjl6EKqr43R5YIUZShGUP086ygTGQeyznb3Zeoz9R8wTUCgGgF0eKvZjQz5Gqvcc93dcOna/yQFhDOVlxn8e/Xh04tmg36tziNs19qBOXvl0QpleEEfp+QNq5/KC7qaOdmnu2pqE3/NFsaTevpo57W4t/9I2AudAqIPt2MQ95ZEljMhMTG2584DZdx51HKFRWLE4WWOyg+cVBq9VJ31frcoR3wU2hZTxcwapt9tk8G87Vx9w==
Received: from AS8P194MB1206.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:3ca::17)
 by AM7P194MB0769.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:17c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Tue, 24 May
 2022 16:51:57 +0000
Received: from AS8P194MB1206.EURP194.PROD.OUTLOOK.COM
 ([fe80::f501:f36:31a7:50ee]) by AS8P194MB1206.EURP194.PROD.OUTLOOK.COM
 ([fe80::f501:f36:31a7:50ee%7]) with mapi id 15.20.5273.023; Tue, 24 May 2022
 16:51:57 +0000
From: Arman Hajishafieha <arman.hajishafieha@hotmail.com>
To: "hch@lst.de" <hch@lst.de>
CC: "kbusch@kernel.org" <kbusch@kernel.org>, "kingtous@qq.com"
 <kingtous@qq.com>, "sagi@grimberg.me" <sagi@grimberg.me>, "me@kingtous.cn"
 <me@kingtous.cn>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH] fix: nvme_update_ns_info method should be called even if
 nvme_ms_ids_equal return false
Thread-Topic: [PATCH] fix: nvme_update_ns_info method should be called even if
 nvme_ms_ids_equal return false
Thread-Index: AQHYTirR2pPWU50/A02wBa1FG8gaG60tBogAgAFHuQCAADJdgA==
Date: Tue, 24 May 2022 16:51:57 +0000
Message-ID: <ec28f450c70d368999df3221ef7c01500fd5fd21.camel@hotmail.com>
References: <20220408160424.GB27746@lst.de>
 <21ac620f-d234-13a1-0de7-e3ec1b3272db@kingtous.cn>
 <20220409044351.GA17212@lst.de>
 <33f34253-4418-e16a-89fb-92257749cf3f@kingtous.cn>
 <20220411054945.GA14311@lst.de>
 <dc6e8c8c-7eaf-f502-207c-4907ce58a474@kingtous.cn>
 <20220411060746.GA14519@lst.de>
 <2c504d2e-5c64-72fb-c26b-e086588ecd8d@kingtous.cn>
 <20220412050441.GA5311@lst.de>
 <741c80abb8a443c4745f213e9ecd413f6a6a7467.camel@hotmail.com>
 <20220524135058.GA31121@lst.de>
In-Reply-To: <20220524135058.GA31121@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [E5UPMtNZZwDtw3ZnIChyYFPlFb+7OvfSQmzEbuw0XXB0m8MfuoG2vg==]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 374fe240-8e7b-48ff-64a8-08da3da5b727
x-ms-traffictypediagnostic: AM7P194MB0769:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QiY/LcHIw0J/0vF+Kv3o1jAG+e0krJ1zoJJ+Mak6Ur018O26xRRxWdNj7I22dw5nA++SWAMuZIRZZdQasttuzRCX0H6WIijLATd7RWTM9fNWG4vDEgeGy6G3WR1R3zV8fEbKySowiaFprnTtyuAPQTagcyWWFoFcDPtp6dyAPuQ9kvGuS5qy/97lAnxQ/U6x/D+bc2XJKauEteqdr5wT92mZgLztwX6DNEfXIPonmiUJGoFanq5FBfmipvnPdEZnlmZuHOVU7OikzLC40g8p6+3DHztI0uOk/rcSRUHlLWZtlCHEj19heISLDgb/0y2QEzPwjrxr0tcf5nhgZ2kM0GyiK5C03M1OyCsuuv+6l8wP73huIykrnIFtkyBm27ta75dVSXWBKYxq7VbFZWs6fBvY5x/H806X6AvpyO9ABlBpWjO+1QxzonmelBuwcUOA1/B42mYBLfh9LvRmsA5vIc6KR3ACHRZZGhVeX7blM59T1El1gjhPohf5TlZjeADkH3cbQmLcc7XLb+Nu40qxd2hZIvNUy9DQIKrxcd0lt0y900aFXgJTktdon/MKwFRpVdiJLEEhdCSyiIVA1Aqy+A==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWFXTE40V2tRUFZvSkpoRkZOK3dzQmJIZGIrUE9xS1R0ekx2UUkwc1h4ZnJt?=
 =?utf-8?B?WkVOaEpXWW5TZDFGNnZnWmw2VkNHOHdXb0V2b0pkeDZudVVVV2t4LzkyNEhD?=
 =?utf-8?B?di8yZ3B1RGdxREV2dnIxNW1iM2JscCtHdVRub2wrYUR5dHEyZ3BUSndvaGVl?=
 =?utf-8?B?ODZwSXEwcHEvbkp2L04xc3RJZUlVQllhNHNleEcxeDFZU3ZUNFVrVkJwZFFO?=
 =?utf-8?B?QWRkWFc0U0M2UElCK2NXMUllWXR1NmdodDJNbU9relZibXF6aldLWitCUEhK?=
 =?utf-8?B?cDRkdWt4ckR1Q1lwZzR0OTk4dSszajIvTVhJZ2JsWVdQSEJHZ0ZHUjZqQWJU?=
 =?utf-8?B?YTdKdXJWY2I5SHB4ZWMvM1B6SVZrN2RxbWdhV2NhaHZrTnNYRW1SOE9URzEw?=
 =?utf-8?B?czF5YVdNNi80bmdRUGpHMjBSR2FiTmxBWkdpRklKcWFhZHVPN0RLSjdTOE5C?=
 =?utf-8?B?QXlNSjQxRkpKU2YxNkZYeHRKekw4QlM0ekthaGJtWGNJVmVuODdDNDFsdHMr?=
 =?utf-8?B?Y3gwYllqa0pUa2JXaWZsUEZxZ3N5OG9lUDVncnZNS0h6Y1pYNzR2SE1zTXRG?=
 =?utf-8?B?UGZ1OWdGRjdlM0ZxVXZvR09xVlUxMHJQck9QNUNQRE1qRUwxNWZaVjlPbG1q?=
 =?utf-8?B?NHB6T3R3ME1kdlBWNzBjRGo0aDY3ZXFDSFRWZS9PZml4SXVWWXFhaFJnSG9p?=
 =?utf-8?B?TjNKdlp1Ym9xWCt6RzFVQ2tzWEU3cmlmWmVKb1dZYjN3M05Hdm5vMks0Y21t?=
 =?utf-8?B?RitOWjlYWEpTRWJLRGNLVk52MnY4MkRRNkhZQmhXOEFwcW9NVTBOR2NZdGw4?=
 =?utf-8?B?YnMycEpWcXJaZjZHY0xJdHNkTTVJMHJuTExwZ0ZXdFJuZHhKWXNQUGpER1FT?=
 =?utf-8?B?Y25VZTFFMmxiRFpDb1BCSzNTVmhXSTNsdDREYS9PelZOeHNaSWI3TWtVWU0v?=
 =?utf-8?B?U0RMOGVyWmIwZFIxUUJHUDBvZDc3YUMybnRyWFB3VmhHNk5GZ1JlMHdMekpP?=
 =?utf-8?B?c1QxRzBaNjhDcEJHMmVxSnlUcjRpUlp0c2JmY3JOS0VmV09YZU81UjJ0TFR5?=
 =?utf-8?B?cVd1S29EbWVwLytpdVd5ajhaRUl5bGl4VVZnWTBaN1VxR3gzM2xQbS80Mk5a?=
 =?utf-8?B?ajJYc05xd1QrNzBraFFHL0ZaZFdDSWdjZWkzbSsxWmhWb3JlQlVBU3gva2c0?=
 =?utf-8?B?T3JyYXc2SGsxb0ljNjlhbDIvRWxrNHNHTW5LVUU2Z3VzRWhmeUdpc2RZZlZo?=
 =?utf-8?B?Q2dhU2JSZTBqUHFhT1lwSk5BMHdDZmF2Z2dUcEhYcmRjellpcVB5NEFxK3FQ?=
 =?utf-8?B?SjlSanZJemhoRFBrcUUzSnBxZGVtK2o5QnhLKzByS0IwbXR0OEJhQzRUY01Y?=
 =?utf-8?B?ZVRIb28wakZlenhHVVh1a0Z3QlArTGdsQVlHY0xraVZsOUVuTVNMZjkyaUwx?=
 =?utf-8?B?UUx4RlE4NHhhellSSTBiMFhyK2VONHhoVzZsZW9TemVYRnU0QXVGSVVXMTZO?=
 =?utf-8?B?L2VTaENVQXdKNHB4MC9MYXo4VWkwaENuYkkvS1lkS2J6VWNwZlRIdWtWcmla?=
 =?utf-8?B?azZDN1FtdWZHVTlDQ3QzN3JNQnoxS0JuQ1JmcGJ1bm5yNkdPWkdsSU1ZTVlR?=
 =?utf-8?B?bjd2QXpWVjZkMk5vTGN2T2N1UTYvblZ3UlRlTWw2Qk9CaTc4YXlvWEFuM3k4?=
 =?utf-8?B?WEhLVXZlUG0zaFFxYVVwdDdjRVl1MDk5SmQwWG9wZTFOcEt4YXZSNFFtSzZX?=
 =?utf-8?B?N3JTZnVpaDJmMVIvSktHMUs1bHl2bnYwUFArUG44clBkYUxvL1dtTFZiRkVZ?=
 =?utf-8?B?QTFpZytYb1QweE1ONnFMbkk3Y056aTZYY2RPMHcxTGZ2ZVVtUkxvOWNiVDNu?=
 =?utf-8?B?MVhtOWhFc0NQckVPR1d2aEg3Vm4xcnplMWZPT3M2UXlWUEo2ODFoMHZ5Mldj?=
 =?utf-8?B?RmE2dW16ZzVMOVo3c2ozaG9EaEZUQWxiTzdEMFJGMnhtVjhuVDltN2ZmY1dE?=
 =?utf-8?B?ZGdtcDN0STVVeDF5T1VFUUNjbk93ODRLQndvWjN2SGM5VG1kblkvcG9jT01E?=
 =?utf-8?Q?2drEBG?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4A8547273C54B47A5BC8D1FFB7E5653@EURP194.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-84264.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P194MB1206.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 374fe240-8e7b-48ff-64a8-08da3da5b727
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 16:51:57.7744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P194MB0769
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220524_100742_294351_407A121F 
X-CRM114-Status: GOOD (  21.77  )
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

T24gVHVlLCAyMDIyLTA1LTI0IGF0IDE1OjUwICswMjAwLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBP
biBNb24sIE1heSAyMywgMjAyMiBhdCAwNjoxODowMVBNICswMDAwLCBBcm1hbiBIYWppc2hhZmll
aGEgd3JvdGU6DQo+ID4gSSBjYW4gY29uZmlybSB0aGF0ICJNQVhJTyBNQVAxMDAxIiAoMWU0Yjox
MDAxKSBjb250cm9sbGVyIGZvdW5kIGluDQo+ID4gIkFzZ2FyZCBOMiAxVEIgU1NEIiBzdWZmZXJz
IGZyb20gdGhlIGV4YWN0IHNhbWUgaXNzdWUgYXMgd2VsbC4NCj4gPiBBZnRlciBhcHBseWluZyB0
aGUgcGF0Y2ggdG8gZGlzYWJsZSBjaGVja2luZyBuYW1lc3BhY2UgaWRlbnRpZmllcnMNCj4gPiBp
dA0KPiA+IGNhbiByZXN1bWUgZnJvbSBzdXNwZW5kIG5vcm1hbGx5LiBJdCBzZWVtcyBsaWtlIHRo
aXMgaXNzdWUgYWZmZWN0cw0KPiA+IGENCj4gPiB3aWRlciByYW5nZSBvZiBNYXhpbyBjb250cm9s
bGVycy4NCj4gPiBDb3VsZCB5b3UgcGxlYXNlIGFkZCBhIHF1aXJrIGZvciB0aGlzIGRldmljZSBh
cyB3ZWxsPw0KPiANCj4gUGxlYXNlIHRyeSB0aGlzOg0KPiANCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL252bWUvaG9zdC9wY2kuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+IGluZGV4
IDVhOThhN2RlMDk2NDIuLmNiNGFkYzBjMjI4NDMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZt
ZS9ob3N0L3BjaS5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jDQo+IEBAIC0zNDUz
LDYgKzM0NTMsOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQNCj4gbnZtZV9p
ZF90YWJsZVtdID0gew0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5kcml2ZXJf
ZGF0YSA9IE5WTUVfUVVJUktfTk9fREVFUEVTVF9QUywgfSwNCj4gwqDCoMKgwqDCoMKgwqDCoHsg
UENJX0RFVklDRSgweDI2NDYsIDB4MjI2MykswqDCoCAvKiBLSU5HU1RPTiBBMjAwMCBOVk1lIFNT
RMKgDQo+ICovDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRyaXZlcl9kYXRh
ID0gTlZNRV9RVUlSS19OT19ERUVQRVNUX1BTLCB9LA0KPiArwqDCoMKgwqDCoMKgwqB7IFBDSV9E
RVZJQ0UoMHgxZTRCLCAweDEwMDEpLMKgwqAgLyogTUFYSU8gTUFQMTAwMSAqLw0KPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19CT0dVU19O
SUQsIH0sDQo+IMKgwqDCoMKgwqDCoMKgwqB7IFBDSV9ERVZJQ0UoMHgxZTRCLCAweDEwMDIpLMKg
wqAgLyogTUFYSU8gTUFQMTAwMiAqLw0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oC5kcml2ZXJfZGF0YSA9IE5WTUVfUVVJUktfQk9HVVNfTklELCB9LA0KPiDCoMKgwqDCoMKgwqDC
oMKgeyBQQ0lfREVWSUNFKDB4MWU0QiwgMHgxMjAyKSzCoMKgIC8qIE1BWElPIE1BUDEyMDIgKi8N
Cj4gDQo+IA0KSSBhcHBsaWVkIHRoZSBwYXRjaCBhZ2FpbnN0IGtlcm5lbCA1LjE4LjANCkFzIGRt
ZXNnIGxvZyBiZWxvdyBzaG93cywgdGhlIHF1aXJrIGlzIGFwcGxpZWQgY29ycmVjdGx5IGFuZCBy
ZXN1bWUNCmZyb20gc3VzcGVuZCBpcyB3b3JraW5nIGFzIGV4cGVjdGVkLg0KVGhhbmsgeW91DQoN
ClsgICAgMS42ODQwNjRdIG52bWUgMDAwMDowNDowMC4wOiBwbGF0Zm9ybSBxdWlyazogc2V0dGlu
ZyBzaW1wbGUNCnN1c3BlbmQNClsgICAgMS42ODQxMTldIG52bWUgbnZtZTA6IHBjaSBmdW5jdGlv
biAwMDAwOjA0OjAwLjANClsgICAgMS42OTYwNzNdIG52bWUgbnZtZTA6IG1pc3Npbmcgb3IgaW52
YWxpZCBTVUJOUU4gZmllbGQuDQpbICAgIDEuNjk5MzMyXSBudm1lIG52bWUwOiBhbGxvY2F0ZWQg
MTYgTWlCIGhvc3QgbWVtb3J5IGJ1ZmZlci4NClsgICAgMS43MDE3ODldIG52bWUgbnZtZTA6IDgv
MC8wIGRlZmF1bHQvcmVhZC9wb2xsIHF1ZXVlcw0KWyAgICAxLjcwNzk5OV0gbnZtZSBudm1lMDog
SWdub3JpbmcgYm9ndXMgTmFtZXNwYWNlIElkZW50aWZpZXJzDQpbICAgIDEuNzEwMzY4XSAgbnZt
ZTBuMTogcDEgcDIgcDMgcDQgcDUgcDYgcDcNClsgICAzNi41NjAwMThdIFhGUyAobnZtZTBuMXA1
KTogTW91bnRpbmcgVjUgRmlsZXN5c3RlbQ0KWyAgIDM2Ljk4MjAwMl0gWEZTIChudm1lMG4xcDUp
OiBFbmRpbmcgY2xlYW4gbW91bnQNClsgICA5MS4wMjc3OTldIG52bWUgbnZtZTA6IDgvMC8wIGRl
ZmF1bHQvcmVhZC9wb2xsIHF1ZXVlcw0KWyAgIDkxLjAzNDIwN10gbnZtZSBudm1lMDogSWdub3Jp
bmcgYm9ndXMgTmFtZXNwYWNlIElkZW50aWZpZXJzDQo=


Return-Path: <SRS0=jPKm=2D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AB8C43603
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 22:28:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CFF62077B
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 22:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SXwopQei";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="BtCboMpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CFF62077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aE/J5Ek2dykHR89aDlzILU606vd3oAWvGyzzaSWHUxQ=; b=SXwopQei8fYlG0
	/zgW4AgKTNwaEO+gChtlnYXyHwPb7TrfFmBCtr7bW+nOS6mDiipwjaxODFNh482XLH8yb6vspKR5y
	rMAD42Cv7BYJHDAuW8n7wDd82w29Bmw5fluk4/LV0JJkjpbEfEOZGFVB7uQt34Jh+QXOvv6rDZ2GP
	XZ/+8HoRq/4jc+2cXNgGPdOfutGSfZN0RGfwLDwE8D4j3LsbLdZTqsWhqGugQPrqaVBHhHEHJcrk4
	ATV7LU6pVa5hHeVhtY5NjiInqdlbtGRf8QL6EyqToDTURax/LSrOh6gH2V/rK+CxH0/MDzLU9h3ox
	Oihp1cqco4zF9pw4LyPw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifkeT-0005lw-P9; Fri, 13 Dec 2019 13:06:37 +0000
Received: from mail-mw2nam10on2073.outbound.protection.outlook.com
 ([40.107.94.73] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifkeP-0005lN-Te
 for linux-nvme@lists.infradead.org; Fri, 13 Dec 2019 13:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSokZEYqllzi5gGFASZ3shiOOW9Bf966CLTUOnYbIPJAmPGi/Fyjc9io+ou881R9iahS/jsMK5J59tzJdLIIIa4grtudHAn9qcebkjQKQJm7TKWjKrdrfT2WjfGEM4tvEMFQEl/mJememzGw+0mhGCT/oqR1215HpdkNLrRidoNQtSkkKXvl0pr2GzgFu4r60/GmmI4ax4qodY7TqVdwhB9VBF7SQsa79xdR/roBFRxhMkFhkGM4eSs7EINuszGJ2arkov8fSIsYAKz58Lkef2bpHQXWLu0oU2NT38F88teImcysI+QEp7jy2XfB4H+vvbrzflwk5FwSCoCn8fgIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUq6kgY7SYkyyLsProV7dYjE+DAFQP4KDtC2h35+UY8=;
 b=dO+CM5XfEIjeZxgxh18FfDYpoQtz2EgAiquYsMPaUifHrikmeh1slIuMStMjye0cqNi/1s2orjq9bqi1iS0YyhelJ4e9XMrjAuIIO76QrQeHtRq3wK65xlgAfFuD9G/P1av3p+0aQLAr7MlJu7vlmtdEvfa7TrM+OpiuiHdWozbgEyo4EtxP8q983kMn2nyTjskxp2+cJXmGAcFQKGCSiGJgOimHdVG7xUt0vZDowE47bajiXOkDbadFL/bBovgMW+LrPiQKiIHsO0OJkmhcrWqiU3VlYuUEPllR6ywploNPHWtyPICeMwvZ5VgCl2zS7RVoL7GWDtA6+ANahszZNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HUq6kgY7SYkyyLsProV7dYjE+DAFQP4KDtC2h35+UY8=;
 b=BtCboMpU37FROJnmMrKPFRKYWbu4BCCqEZU84tBwu5EJ3H3p+3HtnwRVANk/6wDH+e5r4f2hbYxAf1SJtmfdqjoODaZj+5Nlrt8lhuSvEyUlAqFiMaxXzB2rU5ScQvOYk9j96cni4oRV73o2ZU8i1WgtdMmHDLcnSBacjVWvJ5o=
Received: from BN8PR06MB6115.namprd06.prod.outlook.com (20.178.216.139) by
 BN8PR06MB6132.namprd06.prod.outlook.com (20.178.217.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Fri, 13 Dec 2019 13:06:31 +0000
Received: from BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::2ce7:cdc1:b974:dce1]) by BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::2ce7:cdc1:b974:dce1%7]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 13:06:31 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme: fix REQ_NVME_MPATH retry logic
Thread-Topic: [PATCH] nvme: fix REQ_NVME_MPATH retry logic
Thread-Index: AQHVsYhaRE6mz8d3PkiH+twoaxREkKe3tWGA
Date: Fri, 13 Dec 2019 13:06:30 +0000
Message-ID: <D0E57F64-58E1-433D-8B43-891C36568FF7@netapp.com>
References: <CA37C39A-183B-40FF-9033-DE0AC320E098@netapp.com>
In-Reply-To: <CA37C39A-183B-40FF-9033-DE0AC320E098@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1f.0.191110
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46fb1dd9-b563-44fc-4ea2-08d77fcd45cb
x-ms-traffictypediagnostic: BN8PR06MB6132:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB6132F15A1114BFC1999B7C16E4540@BN8PR06MB6132.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(376002)(39850400004)(199004)(189003)(6506007)(107886003)(26005)(110136005)(91956017)(66946007)(66556008)(66476007)(186003)(76116006)(64756008)(66446008)(2906002)(55236004)(71200400001)(6486002)(2616005)(86362001)(4326008)(6512007)(81166006)(81156014)(36756003)(33656002)(5660300002)(478600001)(316002)(8676002)(966005)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR06MB6132;
 H:BN8PR06MB6115.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: urJenc41D+kbAqcUQZFUOi291zv9Cg3hOlNXckp7ZCJYN1JU+aBi4jzrCRhxmZcvrGUibhLFy0yBQ7RZEKRbLycS5/yCn38IpM8nklXoNGYqgqfv/3zPupIzlHr156AZ4r6xd2SnfqeKjGHFPn/ykv8IQhw/aVBQ10tLVDJvyoKcoK5lsQ/q9rdmS9UI+D9188qdvyJdVGiKSjw7r18yaNjI4sq5YQx8su8X5PUtfWH6h9w3JJF3nH+nWvNrF9wx0pUd9Iqn2T/2aHszly2ssp9uVnh8E+TCnAPLdtUz1Rtso9zoh8Wi+Efj5HpBATww4jLGDamse/KI3bAH1b3ZMAcPlvIi9GUDir/YKHcLuSiMV6b+EXveD3cSh1IUO+v652+RVMtLu3+DA8BVlGWA0ulMS40GFOI+2G5L11HZv5poeemZw/K5+ojsjwbbdVOQcjxJYynKdLCFffOT9qRtz5dGSZhTAr7YGDrTYHfcP4U=
Content-ID: <0B9568B917F900489FF93124A77FA662@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fb1dd9-b563-44fc-4ea2-08d77fcd45cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 13:06:30.7982 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oO6EBc3bn4CFnUYlxl35KdWjwA2+gsgK5Yn8ZZlwAAtlmd7fKk0BhH7AE2QjQniediaq8kTDWXI5UMY25PMGpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB6132
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191213_050634_137509_2B1DAE30 
X-CRM114-Status: GOOD (  11.80  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "Meneghini, John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

U2VlIG15IGNvbW1lbnRzIGFib3V0IHRoaXMgcHJvYmxlbSBpbjoNCg0KaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LW52bWUvMjAxOS1EZWNlbWJlci8wMjg0NDcuaHRt
bA0KDQpLZWl0aCwgaWYgdGhpcyBpcyBhdCBhbGwgaW50ZXJlc3RpbmcsIGxldCBtZSBrbm93IGFu
ZCBJJ2xsIHRlc3QgaXQgb3V0Lg0KDQpOb3RlOiBJIGxlZnQgdGhpcyBpbiBoZXJlIHRvIG1haW50
YWluIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5LiAgDQoNCiAgICArICAgICAgIGlmIChibGtfcGF0
aF9lcnJvcihzdGF0dXMpKSB7DQoNCi9Kb2huDQoNCu+7v09uIDEyLzEzLzE5LCAyOjM4IEFNLCAi
TWVuZWdoaW5pLCBKb2huIiA8Sm9obi5NZW5lZ2hpbmlAbmV0YXBwLmNvbT4gd3JvdGU6DQoNCiAg
ICBGcm9tOiBKb2huIE1lbmVnaGluaSA8am9obm1AbmV0YXBwLmNvbT4NCiAgICANCiAgICAgLSBN
YWtlIG52bWVfY29tcGxldGVfcnEgZXJyb3IgaGFuZGxpbmcgbG9naWMNCiAgICAgICBlcXVpdmFs
ZW50IGJldHdlZW4gc2luZ2xlIGFuZCBtdWx0aXBhdGggY29udHJvbGxlcnMuDQogICAgIC0gTm9u
LW11bHRpcGF0aGluZyByZWxhdGVkIG52bWUgZXJyb3JzIHdpbGwNCiAgICAgICBiZSByZXRyaWVk
IG9uIHRoZSBzYW1lIGNvbnRyb2xsZXIuDQogICAgIC0gQXZvaWQgZ3JhdHVpdG91cyBjb250cm9s
bGVyIHJlc2V0IHdoaWxlDQogICAgICAgaGFuZGxpbmcgQkxLX1NUU19JT0VSUiB3aGVuIFJFUV9O
Vk1FX01QQVRIIGlzIHNldC4NCiAgICANCiAgICBTaWduZWQtb2ZmLWJ5OiBKb2huIE1lbmVnaGlu
aSA8am9obm1AbmV0YXBwLmNvbT4NCiAgICAtLS0NCiAgICAgZHJpdmVycy9udm1lL2hvc3QvY29y
ZS5jIHwgMjEgKysrKysrKysrKysrKysrKysrKystDQogICAgIDEgZmlsZSBjaGFuZ2VkLCAyMCBp
bnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQogICAgDQogICAgZGlmZiAtLWdpdCBhL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KICAgIGluZGV4
IDk2OTY0MDRhNjE4Mi4uNGQxZDQ0NTk3YTQwIDEwMDY0NA0KICAgIC0tLSBhL2RyaXZlcnMvbnZt
ZS9ob3N0L2NvcmUuYw0KICAgICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KICAgIEBA
IC0yNjIsNiArMjYyLDI1IEBAIHN0YXRpYyB2b2lkIG52bWVfcmV0cnlfcmVxKHN0cnVjdCByZXF1
ZXN0ICpyZXEpDQogICAgICAgICAgICBibGtfbXFfZGVsYXlfa2lja19yZXF1ZXVlX2xpc3QocmVx
LT5xLCBkZWxheSk7DQogICAgIH0NCiAgICAgDQogICAgK3N0YXRpYyBib29sIG52bWVfcGF0aF9l
cnJvcihzdHJ1Y3QgcmVxdWVzdCAqcmVxLCBibGtfc3RhdHVzX3Qgc3RhdHVzKQ0KICAgICt7DQog
ICAgKw0KICAgICsgICAgICAgaWYgKGJsa19wYXRoX2Vycm9yKHN0YXR1cykpIHsNCiAgICArICAg
ICAgICAgICAgICAgc3dpdGNoIChudm1lX3JlcShyZXEpLT5zdGF0dXMgJiAweDdmZikgew0KICAg
ICsgICAgICAgICAgICAgICBjYXNlIE5WTUVfU0NfQU5BX1RSQU5TSVRJT046DQogICAgKyAgICAg
ICAgICAgICAgIGNhc2UgTlZNRV9TQ19BTkFfSU5BQ0NFU1NJQkxFOg0KICAgICsgICAgICAgICAg
ICAgICBjYXNlIE5WTUVfU0NfQU5BX1BFUlNJU1RFTlRfTE9TUzoNCiAgICArICAgICAgICAgICAg
ICAgY2FzZSBOVk1FX1NDX0hPU1RfUEFUSF9FUlJPUjoNCiAgICArICAgICAgICAgICAgICAgY2Fz
ZSBOVk1FX1NDX0hPU1RfQUJPUlRFRF9DTUQ6DQogICAgKyAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIHRydWU7DQogICAgKyAgICAgICAgICAgICAgIGRlZmF1bHQ6DQogICAgKyAgICAgICAg
ICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KICAgICsgICAgICAgICAgICAgICB9DQogICAg
KyAgICAgICB9DQogICAgKw0KICAgICsgICAgICAgcmV0dXJuIGZhbHNlOw0KICAgICt9DQogICAg
Kw0KICAgICB2b2lkIG52bWVfY29tcGxldGVfcnEoc3RydWN0IHJlcXVlc3QgKnJlcSkNCiAgICAg
ew0KICAgICAgICAgICAgYmxrX3N0YXR1c190IHN0YXR1cyA9IG52bWVfZXJyb3Jfc3RhdHVzKG52
bWVfcmVxKHJlcSktPnN0YXR1cyk7DQogICAgQEAgLTI3NSw3ICsyOTQsNyBAQCB2b2lkIG52bWVf
Y29tcGxldGVfcnEoc3RydWN0IHJlcXVlc3QgKnJlcSkNCiAgICAgDQogICAgICAgICAgICBpZiAo
dW5saWtlbHkoc3RhdHVzICE9IEJMS19TVFNfT0sgJiYgbnZtZV9yZXFfbmVlZHNfcmV0cnkocmVx
KSkpIHsNCiAgICAgICAgICAgICAgICAgICAgaWYgKChyZXEtPmNtZF9mbGFncyAmIFJFUV9OVk1F
X01QQVRIKSAmJg0KICAgIC0gICAgICAgICAgICAgICAgICAgYmxrX3BhdGhfZXJyb3Ioc3RhdHVz
KSkgew0KICAgICsgICAgICAgICAgICAgICAgICAgbnZtZV9wYXRoX2Vycm9yKHJlcSwgc3RhdHVz
KSkgew0KICAgICAgICAgICAgICAgICAgICAgICAgICAgIG52bWVfZmFpbG92ZXJfcmVxKHJlcSk7
DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuOw0KICAgICAgICAgICAgICAgICAg
ICB9DQogICAgLS0gDQogICAgMi4yMS4wDQogICAgICAgIA0KDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

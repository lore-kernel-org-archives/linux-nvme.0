Return-Path: <SRS0=ysN4=ZZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66BCC432C0
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 19:54:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91595207DD
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2019 19:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kts7lHl4";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BUY246bK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Z4jVvSUy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91595207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=i+4Y1jEp5WZBXOZxtaPpQ7eD+dRAfr6HzDS+VczFP30=; b=kts7lHl4ceo67u
	A5xDIQt1b91Kp5TpFCbOmtoiF8oGWvBOhf7Flg9qJWbVv35r34+jCitgMgqVLZ7QERHyTzw9kKGVi
	v26XqoxTDukl6rbx+n/qMXOOu8fil+XoyzGPz4xPDsvw7kcxFRVjEdHf4//OuhZTYSiTzII0eHAOk
	+78WwT7mKITKU0XWeRlC8GaxxMCNxd6gs7AzjBfDWL5jmnDQGkpjJmRMHsyZO+QOIm6qEjNIViedq
	VqUEAjpOkgGvIvCztL/lm/YInuOw4U5ONWCK4YcYALsT8fjOlY10tl/9GFOdw+ZnjPhLNau+44iQh
	viA5w8UJbLuycYI3QNrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icEFi-0002Ee-P6; Tue, 03 Dec 2019 19:54:30 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icEFf-0002EC-I1
 for linux-nvme@lists.infradead.org; Tue, 03 Dec 2019 19:54:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575402867; x=1606938867;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=+RApkAxZJdFGiBOq6RhSP4Qlef246S9n1DlU9NN4LbE=;
 b=BUY246bKPCNqlk1nnFVi7zrWDXIKx/ug6uXc/OdMTEKgUhT5s/21t5w9
 ovlWqbZNABl17p2E+UWnrh5W/EZs2jjUKNenqonPq9JFUGoeWQMjyMxgP
 uGjWohvnH2lNAvsfgiXmjdJOR8nm+4hzyEkWNCUn0XtcLQwstUdTSmqfX
 vV87RykMEDu4k1d0hH4ZHXX3jWTLcCRo+AVgeQ1cHx4tdUovyzPGto68V
 tkK7Ysizb4yomxPvf8apZtrOLMgCjYiddri08mtTxdc3nLWXBX/rYEaNU
 wol0jT2BeNeznGRA9NdS0DUbnEGvmuCO+pitpasXFcSDILF4KXzq+cwPK Q==;
IronPort-SDR: I7gJAZXNQPqdvWw0KdBTTSRGp6lzKHEnMbLa3STCA8lgKiY2Di/nRfry81GWYdLuSEIQviyi22
 bLA9obKzhVCbjmBVnDzgJxyfRV38wBMH6z9Pg2Qd7811iY+ECSPJs2Nuo/YC17eL7i6rRv2+el
 VDYZfBR4NCXQWtuQZb5cmmroJHdjIqXO3KKb3jW9EO3jxCIsq7mi+Xg/1IwEurnYNdxalsXCAy
 DyQ53pcBu/W6ddyhJLYMorMTSkkdGM8/iS6WY5YRcmgDsPgfzv5a7N0hA6i8T2rHvhZy6Obe/5
 NYA=
X-IronPort-AV: E=Sophos;i="5.69,274,1571673600"; d="scan'208";a="124527066"
Received: from mail-sn1nam01lp2053.outbound.protection.outlook.com (HELO
 NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.53])
 by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 03:54:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KsafVQD1LCiVsQmt73sIGh0RAtslBUbBWBF8tSzgMHjach+Gz8t312CjkBupeAe20obIr09d53kVgRIMoUAYcPAE8HpIo+fIh3XnLT61Ng7RT4XcQwcX+mmjGPLcdKN2aIOLN9FzAqmvCVsGKhzr24CCYgZOZZsJvJWqjfw5dxQ9gwm8y78CGtlfbE9+K2PPfYS4HM0NMGGuRYqmBX8WvL6hFwgtHc5ygWA9kv1tKt2cytFi8K4x7K8Wy+/jwyE5fVagACBrvBcFezIHtoZxpNeUjEactU4GuuROiPN75bqrM+UaY7D77SLIfpYr9Aqt72VK1okdW1YNC+wylgpG0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RApkAxZJdFGiBOq6RhSP4Qlef246S9n1DlU9NN4LbE=;
 b=C/5A0MwQaCZjSRcxIOh4faI27Ltjg7KMADtZxZ3VrEqDr/5VLCohL4Kc3d1D+ZPLjoQ2ZQ1BZl/EH95IHJGiJmXGDD5ghOJIpQZvRj3chnlWFcChajkPOzns1mebMCA5fosP4stVktu7lwNyru+Nb3OlzdG/nkIH4rc4qi3eJVc+ljyYyvwONr2V+TgX7rTMHH45yKX22fEcXgIbxN71ktuBx6sS1WJ5RoBF09LE9RkNfbaumGEVEDLKzfTiZPa5/xvtTwtYBsCWm1oHQDmvRcer3nXUabv9owgM4ebBhLnXaKIfRopS9gbTTxh1xTJ1or8QqUwkI7X9dDRzwaQFhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RApkAxZJdFGiBOq6RhSP4Qlef246S9n1DlU9NN4LbE=;
 b=Z4jVvSUyLxPyU6cfn5NIv/rjoMRzbyWIEIaQTuRDMm3Q9JhZfe/Ujf60VVo8h+ogBzeuZ86hxxDgtVtsnK815rnv/biYtsMPTlH7V7x9DL0nqJ8+wa/CsQiH5DFYeGyapYscLlyN0g3NX7BNzgWS/JACx26DnPPKBwco9HHNrXc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5959.namprd04.prod.outlook.com (20.178.235.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.19; Tue, 3 Dec 2019 19:54:24 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2495.014; Tue, 3 Dec 2019
 19:54:24 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: NVMeoF driver & Reservations
Thread-Topic: NVMeoF driver & Reservations
Thread-Index: AQHVqDDATz6Lvv/jW0mpJP3WMDJMz6eol14AgAA/K4A=
Date: Tue, 3 Dec 2019 19:54:23 +0000
Message-ID: <784A9299-C11B-406C-838E-8785BEAB6637@wdc.com>
References: <962eea1d-e89d-45dc-9b3c-6a4606927a0b@acm.org>
In-Reply-To: <962eea1d-e89d-45dc-9b3c-6a4606927a0b@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:f9ac:57a4:bb82:e394]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 29926bb8-ef27-4249-6eff-08d7782a9896
x-ms-traffictypediagnostic: BYAPR04MB5959:
x-microsoft-antispam-prvs: <BYAPR04MB59591541AB765C752123BD5F86420@BYAPR04MB5959.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02408926C4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(396003)(39860400002)(346002)(366004)(136003)(189003)(199004)(102836004)(14454004)(7736002)(86362001)(305945005)(2906002)(71190400001)(71200400001)(76116006)(66556008)(66446008)(66476007)(6916009)(64756008)(478600001)(66946007)(229853002)(6116002)(186003)(8936002)(33656002)(81166006)(6246003)(81156014)(99286004)(46003)(76176011)(446003)(11346002)(256004)(53546011)(6506007)(2616005)(25786009)(4326008)(6486002)(6512007)(316002)(36756003)(5660300002)(54906003)(6436002)(6306002)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB5959;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8LXYE9ieqlyJquyXF6qXwMkXP3rxswqMNwLcWjvV24bkC5NVRZljmQzw7zRh92393sFZalDsKBxcTxjU+Ur/qOov4uLTvOIzX3ipwbzHxtdEzEeJs5/gnemPwv6NtV5xfncXSNqt5RXdkPJYC4yntdYwUhlFswxqgamWysVi/7YMDUSlONfSOe9Ro6VRkWRDcQqJpl/NNC7jPz+T7h/nfYpUsXeydH+4g8mKryTTBU3w9xgamowM16MSGOeG8xvKnPxSaUIcldxFw/SVY8wVTPGgHA4LPc+0RyaQygfhChES0+NbzhP39eAFZslh6u7iyLRSKYpsAylykqQT+s/2kjbtZzKvMC08I3/wP3Ba10cBhW+v7s1BPFBFDEZPYyfaJIoyDfKGSipDnOppPEDWvscf1Uh2XyGvLSpEUACcGShqKftYZlhhV4zEqZnkqD5d83d9nWEM9y1eYsHN9J5bo3FjMYVWhOSlhY/43dJqepg=
x-ms-exchange-transport-forked: True
Content-ID: <616094850855A740ADB7D897506F2F72@sharedspace.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29926bb8-ef27-4249-6eff-08d7782a9896
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2019 19:54:23.8790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOJOQOg0XOV631+VHPwbU9zqD30MzRSCDbS7u1j6FtYGRJ0cfy8EYxk6nwwXBAJ0RephFyrqpo5dfM0nN3ZLqXIoBLEgETC2F0l82WIyHSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5959
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191203_115427_639949_7E9F607C 
X-CRM114-Status: GOOD (  16.57  )
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
Cc: Talker Alex <alextalker@yandex.ru>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SW5kZWVkIEkgaGF2ZSBsb29rZWQgaW50byB0aGlzIGFuZCBpdCdzIHZlcnkgaGVscGZ1bC4gDQpU
aGFua3MgZm9yIHJlbWluZGluZyBtZSBhZ2FpbiA6KS4gDQo+IE9uIERlYyAzLCAyMDE5LCBhdCA4
OjA4IEFNLCBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVAYWNtLm9yZz4gd3JvdGU6DQo+IA0K
PiDvu79PbiAxMi8yLzE5IDI6MDcgUE0sIENoYWl0YW55YSBLdWxrYXJuaSB3cm90ZToNCj4+PiBP
biAxMi8wMS8yMDE5IDAyOjE5IEFNLCBUYWxrZXIgQWxleCB3cm90ZToNCj4+PiBIaSENCj4+PiAN
Cj4+PiBJcyB0aGVyZSBwbGFucyB0byBpbXBsZW1lbnQgUmVzZXJ2YXRpb25zIHN1cHBvcnQgaW4g
dGFyZ2V0IGRyaXZlcihmcm9tIE5WTWUgdjEuNCBwYXJ0IDguOCk/DQo+Pj4gSSBzZWUgdGhhdCBo
b3N0IHN1cHBvcnQgaXMgYWxyZWFkeSBpbXBsZW1lbnRlZCBpbiBudm1lIHV0aWxpdHkgJiBkcml2
ZXIgbGV2ZWwuDQo+Pj4gSG93ZXZlciwgSSBoYXZlbid0IGZvdW5kIGhhcmR3YXJlIG9uIHdoaWNo
IGl0IHdvcmtzIC0gdGFyZ2V0IGRyaXZlciBkb2Vzbid0IHN1cHBvcnQgdGhpcyBjb21tYW5kIGFu
ZCBQQ0llIGRyaXZlcyBhdmFpbGFibGUgdG8gbWUgYWxzby4NCj4+PiANCj4+PiBTbywgSSdtIHdv
bmRlcmluZyBpZiBhbnlvbmUgYmVnaW4gdG8gaW1wbGVtZW50IHRoaXMgZmVhdHVyZSBhdCBsZWFz
dCBvbiBzaW5nbGUgdGFyZ2V0IGxldmVsLg0KPj4gWWVzIHRoZXJlIGlzIGFuZCBJIGFsc28gaGF2
ZSB0ZXN0Y2FzZXMgdG8gdGVzdCB0aGlzIGZlYXR1cmUgZnJvbSBob3N0IHNpZGUuDQo+PiBmb3Ig
dGFyZ2V0IEkgZGlkIHN0YXJ0IHdvcmtpbmcgb24gdGhpcyBidXQgc3RvcHBlZCBpdCBzaW5jZSBJ
IGRpZG4ndA0KPj4gZmluZCBwcm9wZXIgdXNlLWNhc2UgKG9yIGEgY2xpZW50KSBmb3IgaXQgdG8g
anVzdGlmeSB0aGUgZWZmb3J0IGFuZA0KPj4gY29kZSBnZXR0aW5nIGludG8ga2VybmVsLiBCdXQg
aWYgeW91IGhhdmUgYSBsZWdpdCBzY2VuYXJpbyBvciBhDQo+PiB1c2UtY2FzZSBJJ2xsIGJlIGhh
cHB5IHRvIHdvcmsgb24gdGhpcy4NCj4gDQo+IEhpIENoYWl0YW55YSwNCj4gDQo+IElmIHlvdSB3
b3VsZCBiZSBjb25zaWRlcmluZyB0byBkZXZlbG9wIHRlc3QgY29kZSBmb3IgTlZNZSByZXNlcnZh
dGlvbnMsIHlvdSBtYXkgd2FudCB0byBoYXZlIGEgbG9vayBhdCB0aGUgU0NTSSBwZXJzaXN0ZW50
IHJlc2VydmF0aW9uIHRlc3RzIGluIHRoZSBsaWJpc2NzaSB0ZXN0LXRvb2wgKGh0dHBzOi8vZ2l0
aHViLmNvbS9zYWhsYmVyZy9saWJpc2NzaS90cmVlL21hc3Rlci90ZXN0LXRvb2wpLg0KPiANCj4g
QmFydC4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

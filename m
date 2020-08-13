Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA2CC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 15:29:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46DCE2078D
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 15:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jdwUfXK+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="pO0y+qvD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46DCE2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZXFDlpruOJKOXPu44DeZ1EoA8UsiDZVzMNQCsaLf4SQ=; b=jdwUfXK+n/xRqkblWv0SKdXK1
	YPCOEMq9Z4vp20Rs/nWdiqGBfJMrPx0Lp3spZmy5RgOyQYC80V50USH1renTjXbftAO0PF5YGdtlo
	iJoTo1VbQoeYEq1RpAHWeJsfhbL8zdo3s/+kV/P5qH6xnSL4kK2tGav/q9rwjii/4VmD3g6VNS4K/
	AXT/E/0HhxPTnp9laZ24EMHnjlre7p3r2L/xBq2ZmyDsCO+XNodDo7iuVTau9VJLAKXe89NqZxh6m
	iE3DtmBif8932BpCY/IoZ76u7cVkKHsIYrUW4k0l2dFITLWyIJhGW2K3Hs77kwt2bFf/aEx17j39u
	qrntIQ1VQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6FAG-0007j7-8B; Thu, 13 Aug 2020 15:29:12 +0000
Received: from mail-dm6nam08on2069.outbound.protection.outlook.com
 ([40.107.102.69] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6FAD-0007iZ-3J
 for linux-nvme@lists.infradead.org; Thu, 13 Aug 2020 15:29:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kqElfaApK7dDKBNTqM6Zm5GVa2EPc4F9HfoAYlClnaO+XRr1R48D0/9/gg5xCz1b4eevGbvOSKF30z4gShV0SGf/IGKUGnMwYateIs7YFRxAs2iWrldvMAl/zDqcL9NnrcaCM+QztuZJbNOGy/PgrpN9Y6PamxVv+haOMsT0wd2Y3M+ij5tu/ulzP2f3SCV2Jr9nlNV/iUNIk1ZshEmgxXD7QkWXfTyKqsADwvYha1e1QdGRVpl/H7JXKmBrLCARC5IemHlXv/UZ8HPjrC9TjsnQx/SB+3VO7deqC8FxpBE0ETn9WBVg06G+XS5zHKRDfYePtwvrrArCO583JaUL5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI9guaZe8Y1Lc8Gqc41us6eGLBmV/KPCdqR67To2byM=;
 b=FFF8F3MDk05kWwb7khn/B8rBGAljVOPdSYhJOHv2Xo7M8DAX0/bVatuULwR9h5HwCwQfzbTzTOa9o0dL5C30vdDPDQcWZYQpxsXcEaX9MMc9dHi8secnV5MJ9gcIH8/PcM217GjjGwlJNMLp/KAHfEfp1CJ7LZeqR9MAcsSF0p1w/KBCi/Uf6C9RmLNHHqN2RKxe3MOlSdKwd0q/rNzZrIfuCJdBT2c6abvjmKws5PNLx7NjdZk3LcLAfBPjh7R+a1xNDQ1+/lSDWvCc4WA1nqvW8isuo6ycZXJSY6mTbavXpHMGmjzKI9Uv282LRFfbOKjQdXqi18zMMibqUIxHDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI9guaZe8Y1Lc8Gqc41us6eGLBmV/KPCdqR67To2byM=;
 b=pO0y+qvD1bvxTfCO8hQ4s6SgFcCXAR4FAMe7EQsnQzYzVIW0eHF4vjAJ+h5kIp6/K40cdqPaxcsySVsrJhhq38mU7aCNh2iCZrKHMTfrNBY8diSrcYWThkFqmvxTAPvb2b/uTUOW68oESsXsT/Zgr1ywFdGonBFnoKa8cy0GtQk=
Received: from BN8PR06MB5714.namprd06.prod.outlook.com (2603:10b6:408:d2::32)
 by BN7PR06MB3875.namprd06.prod.outlook.com (2603:10b6:406:83::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Thu, 13 Aug
 2020 15:29:01 +0000
Received: from BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::9438:86ca:efca:18b9]) by BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::9438:86ca:efca:18b9%3]) with mapi id 15.20.3283.018; Thu, 13 Aug 2020
 15:29:01 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Mike Snitzer <snitzer@redhat.com>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [RESEND PATCH] nvme: explicitly use normal NVMe error handling
 when appropriate
Thread-Topic: [RESEND PATCH] nvme: explicitly use normal NVMe error handling
 when appropriate
Thread-Index: AQHWcYDS3N6K/RiKVU6UaUdcYydCWqk15t8A
Date: Thu, 13 Aug 2020 15:29:00 +0000
Message-ID: <A90B4EF6-354C-4735-9E5A-45BF27F520E2@netapp.com>
References: <E3390A8E-D582-47BA-A085-21663D883365@netapp.com>
 <20200806184057.GA27858@redhat.com> <20200806191943.GA27868@redhat.com>
 <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
 <20200807000755.GA28957@redhat.com>
 <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
 <20200810143620.GA19127@redhat.com> <20200810172209.GA19535@redhat.com>
 <20200813144811.GA5452@redhat.com>
In-Reply-To: <20200813144811.GA5452@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.39.20071300
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [216.240.30.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3cf6375-91db-494c-ac58-08d83f9d9ac0
x-ms-traffictypediagnostic: BN7PR06MB3875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR06MB3875C1E99EFEAB4BC4C48C40E4430@BN7PR06MB3875.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR06MB5714.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(66476007)(91956017)(76116006)(66946007)(33656002)(54906003)(8676002)(71200400001)(107886003)(66446008)(6512007)(64756008)(66556008)(8936002)(316002)(110136005)(4326008)(5660300002)(6486002)(36756003)(6506007)(966005)(186003)(478600001)(2906002)(26005)(83380400001)(2616005)(86362001);
 DIR:OUT; SFP:1101; 
Content-ID: <3882C5DF93795248980DB4250D0A399D@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5714.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3cf6375-91db-494c-ac58-08d83f9d9ac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 15:29:00.9540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tyRzcgtfYueFxu5PJjcwyPp4L6UnGOqoeuTb0nUnMFq3gKjfb4Bxh4N39s8m60atQlCH90MKai4S1lEK048xSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB3875
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200813_112909_258960_BE5542FB 
X-CRM114-Status: GOOD (  15.92  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@infradead.org>,
 "dm-devel@redhat.com" <dm-devel@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>, "Meneghini, 
 John" <John.Meneghini@netapp.com>, Ewan Milne <emilne@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

TWlrZSwgDQoNCkkgZG9uJ3Qgc2VlIHlvdXIgcGF0Y2ggYXQ6DQoNCmh0dHBzOi8vcGF0Y2h3b3Jr
Lmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1ibG9jay9saXN0Lz9zdWJtaXR0ZXI9MTY0Mw0KDQpD
YW4geW91IHBsZWFzZSB1cGxvYWQgdGhpcyBwYXRjaCB0aGVyZT8NCg0KVGhhbmtzLA0KDQovSm9o
bg0KDQrvu79PbiA4LzEzLzIwLCAxMDo0OCBBTSwgIk1pa2UgU25pdHplciIgPHNuaXR6ZXJAcmVk
aGF0LmNvbT4gd3JvdGU6DQoNCiAgICBDb21taXQgNzY0ZTkzMzIwOThjMCAoIm52bWUtbXVsdGlw
YXRoOiBkbyBub3QgcmVzZXQgb24gdW5rbm93bg0KICAgIHN0YXR1cyIpLCBhbW9uZyBvdGhlciB0
aGluZ3MsIGZpeGVkIE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVEIGVycm9yDQogICAgaGFuZGxpbmcg
YnkgY2hhbmdpbmcgbXVsdGlwYXRoaW5nJ3MgbnZtZV9mYWlsb3Zlcl9yZXEoKSB0byBzaG9ydC1j
aXJjdWl0DQogICAgcGF0aCBmYWlsb3ZlciBhbmQgdGhlbiBmYWxsYmFjayB0byBOVk1lJ3Mgbm9y
bWFsIGVycm9yIGhhbmRsaW5nICh3aGljaA0KICAgIHRha2VzIGNhcmUgb2YgTlZNRV9TQ19DTURf
SU5URVJSVVBURUQpLg0KDQogICAgVGhpcyBkZXRvdXIgdGhyb3VnaCBuYXRpdmUgTlZNZSBtdWx0
aXBhdGhpbmcgY29kZSBpcyB1bndlbGNvbWUgYmVjYXVzZQ0KICAgIGl0IHByZXZlbnRzIE5WTWUg
Y29yZSBmcm9tIGhhbmRsaW5nIE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVEIGluZGVwZW5kZW50DQog
ICAgb2YgYW55IG11bHRpcGF0aGluZyBjb25jZXJucy4NCg0KICAgIEludHJvZHVjZSBudm1lX3N0
YXR1c19uZWVkc19sb2NhbF9lcnJvcl9oYW5kbGluZygpIHRvIHByaW9yaXRpemUNCiAgICBub24t
ZmFpbG92ZXIgcmV0cnksIHdoZW4gYXBwcm9wcmlhdGUsIGluIHRlcm1zIG9mIG5vcm1hbCBOVk1l
IGVycm9yDQogICAgaGFuZGxpbmcuICBudm1lX3N0YXR1c19uZWVkc19sb2NhbF9lcnJvcl9oYW5k
bGluZygpIHdpbGwgbmF0dXJlbHkgZXZvbHZlDQogICAgdG8gaW5jbHVkZSBoYW5kbGluZyBvZiBh
bnkgb3RoZXIgZXJyb3JzIHRoYXQgbm9ybWFsIGVycm9yIGhhbmRsaW5nIG11c3QNCiAgICBiZSB1
c2VkIGZvci4NCg0KICAgIG52bWVfZmFpbG92ZXJfcmVxKCkncyBhYmlsaXR5IHRvIGZhbGxiYWNr
IHRvIG5vcm1hbCBOVk1lIGVycm9yIGhhbmRsaW5nDQogICAgaGFzIGJlZW4gcHJlc2VydmVkIGJl
Y2F1c2UgaXQgbWF5IGJlIHVzZWZ1bCBmb3IgZnV0dXJlIE5WTUVfU0MgdGhhdA0KICAgIG52bWVf
c3RhdHVzX25lZWRzX2xvY2FsX2Vycm9yX2hhbmRsaW5nKCkgaGFzbid0IGJlZW4gdHJhaW5lZCBm
b3IgeWV0Lg0KDQogICAgU2lnbmVkLW9mZi1ieTogTWlrZSBTbml0emVyIDxzbml0emVyQHJlZGhh
dC5jb20+DQogICAgLS0tDQogICAgIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDE2ICsrKysr
KysrKysrKysrLS0NCiAgICAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQoNCiAgICBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIv
ZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQogICAgaW5kZXggODhjZmYzMDlkOGU0Li5iZTc0OWI2
OTBhZjcgMTAwNjQ0DQogICAgLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQogICAgKysr
IGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQogICAgQEAgLTI1Miw2ICsyNTIsMTYgQEAgc3Rh
dGljIGlubGluZSBib29sIG52bWVfcmVxX25lZWRzX3JldHJ5KHN0cnVjdCByZXF1ZXN0ICpyZXEp
DQogICAgICAgICAgICByZXR1cm4gdHJ1ZTsNCiAgICAgfQ0KDQogICAgK3N0YXRpYyBpbmxpbmUg
Ym9vbCBudm1lX3N0YXR1c19uZWVkc19sb2NhbF9lcnJvcl9oYW5kbGluZyh1MTYgc3RhdHVzKQ0K
ICAgICt7DQogICAgKyAgICAgICBzd2l0Y2ggKHN0YXR1cyAmIDB4N2ZmKSB7DQogICAgKyAgICAg
ICBjYXNlIE5WTUVfU0NfQ01EX0lOVEVSUlVQVEVEOg0KICAgICsgICAgICAgICAgICAgICByZXR1
cm4gdHJ1ZTsNCiAgICArICAgICAgIGRlZmF1bHQ6DQogICAgKyAgICAgICAgICAgICAgIHJldHVy
biBmYWxzZTsNCiAgICArICAgICAgIH0NCiAgICArfQ0KICAgICsNCiAgICAgc3RhdGljIHZvaWQg
bnZtZV9yZXRyeV9yZXEoc3RydWN0IHJlcXVlc3QgKnJlcSkNCiAgICAgew0KICAgICAgICAgICAg
c3RydWN0IG52bWVfbnMgKm5zID0gcmVxLT5xLT5xdWV1ZWRhdGE7DQogICAgQEAgLTI3MCw3ICsy
ODAsOCBAQCBzdGF0aWMgdm9pZCBudm1lX3JldHJ5X3JlcShzdHJ1Y3QgcmVxdWVzdCAqcmVxKQ0K
DQogICAgIHZvaWQgbnZtZV9jb21wbGV0ZV9ycShzdHJ1Y3QgcmVxdWVzdCAqcmVxKQ0KICAgICB7
DQogICAgLSAgICAgICBibGtfc3RhdHVzX3Qgc3RhdHVzID0gbnZtZV9lcnJvcl9zdGF0dXMobnZt
ZV9yZXEocmVxKS0+c3RhdHVzKTsNCiAgICArICAgICAgIHUxNiBudm1lX3N0YXR1cyA9IG52bWVf
cmVxKHJlcSktPnN0YXR1czsNCiAgICArICAgICAgIGJsa19zdGF0dXNfdCBzdGF0dXMgPSBudm1l
X2Vycm9yX3N0YXR1cyhudm1lX3N0YXR1cyk7DQoNCiAgICAgICAgICAgIHRyYWNlX252bWVfY29t
cGxldGVfcnEocmVxKTsNCg0KICAgIEBAIC0yODAsNyArMjkxLDggQEAgdm9pZCBudm1lX2NvbXBs
ZXRlX3JxKHN0cnVjdCByZXF1ZXN0ICpyZXEpDQogICAgICAgICAgICAgICAgICAgIG52bWVfcmVx
KHJlcSktPmN0cmwtPmNvbXBfc2VlbiA9IHRydWU7DQoNCiAgICAgICAgICAgIGlmICh1bmxpa2Vs
eShzdGF0dXMgIT0gQkxLX1NUU19PSyAmJiBudm1lX3JlcV9uZWVkc19yZXRyeShyZXEpKSkgew0K
ICAgIC0gICAgICAgICAgICAgICBpZiAoKHJlcS0+Y21kX2ZsYWdzICYgUkVRX05WTUVfTVBBVEgp
ICYmIG52bWVfZmFpbG92ZXJfcmVxKHJlcSkpDQogICAgKyAgICAgICAgICAgICAgIGlmICghbnZt
ZV9zdGF0dXNfbmVlZHNfbG9jYWxfZXJyb3JfaGFuZGxpbmcobnZtZV9zdGF0dXMpICYmDQogICAg
KyAgICAgICAgICAgICAgICAgICAocmVxLT5jbWRfZmxhZ3MgJiBSRVFfTlZNRV9NUEFUSCkgJiYg
bnZtZV9mYWlsb3Zlcl9yZXEocmVxKSkNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm47DQoNCiAgICAgICAgICAgICAgICAgICAgaWYgKCFibGtfcXVldWVfZHlpbmcocmVxLT5xKSkg
ew0KICAgIC0tDQogICAgMi4xOC4wDQoNCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=

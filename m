Return-Path: <SRS0=38m3=E5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AE9C2D0E4
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 15:54:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FC2A206B6
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 15:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W2An+3yC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="xnUu5Z5G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC2A206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DJdvvBsnrAgzfwKdFdGSFmp8UP0IIYeV5bVewr4b/40=; b=W2An+3yCfnuL3GkffKk4DWEOB
	qniwwamy8d7jqetVv0tI+V7sQIoz2o0Ruy23JStITZFCFxxj2Rw4aZOtt/q46yHeWsvlurKbooJt3
	wi2K9ExyPuxVe2+wbUm57eAgc5ZsvFd3t90OafAfgPPkk57lnAxkwO+I66SZy+sFWPsEoxTuM0A1f
	kEQOqp2pSKEneykVR4p/uGLoKUPZrD5vqf70r/bg4mf7bJ2AZ4sgjr85IBXl5fF/vwOcBAUy34Bdz
	Ro/YklddXB5GzzmodX6p89rlYsKnVQgpqam6YrqhcY11QrmWJIanu/Xp3D/LRZrRTQ6/WGKuF8Fee
	57reJVXmA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khEAx-0001Fy-PV; Mon, 23 Nov 2020 15:54:47 +0000
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com
 ([40.107.236.46] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khEAv-0001FH-6f
 for linux-nvme@lists.infradead.org; Mon, 23 Nov 2020 15:54:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzYDGmxxR3szy7ov/qteZGEQM6AM7u29RP1So17k4C5WXX1UDP+1nrDFH82YdsswqbBzC84O5c0kDmPxHIthxaPaFmHuiyobULKw3EnGFvIO7Ovnl/12OD8Gs/EwN66bryTcYfsKX4PxbZANIy9UD/MbRfmrpGki8Je3syn/rs7XBJ7boySJ4aiJ9YNwvYL5xqCRyVc+EuE11L8ir1jGWYmH31fgLuKtOLjcyUzVqO5TCTVNiiZo0fAVLap2Nm7FpYyvzx8J81sx67W7VgiF8VYVJOpsqVdR7UKZ4CS/KsTNhDwGO3rDJ7snPP5U7bdM9nnq4mG58J+7nAqfnEjHuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAkpSbOlklZQgEm8On27GkkTdMMW6Mrid47AzgLMnSQ=;
 b=Mr41an3SP3AZ9fuugXacyDEk9X8DLOx648sqPeYUx8FcpjRwz5W27ow7IefkTkxAoaWKILuM1a9+7qUexH6FKsj8B4H1LwSEOlYcJcR/uwwhCGrazCO0YhNC01d5wwjH/R+6WwjWwxw3A4z+HtX41+1oqXjtXD/RY8jrShLLCHpyHTo3eD5HownpiIIbA8WT049CDTTk9xPPD8cCumxrt3Lrob7k5h9Vy/aYoXSCeRhoG2Bw5/6F6hpSbaaOUObDKxXyRX735xEM1kNpTRpXA/c/jLVP3GGtxpGM0F86DiyDxBfX/uPiDcfH94XlNrgZQGCQ/PACBrqypQp6fsCXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAkpSbOlklZQgEm8On27GkkTdMMW6Mrid47AzgLMnSQ=;
 b=xnUu5Z5GaO4q7Q/ah3+Bc0i2wCTA4cJPbrkc0k7ZNy58zn5IoDzA/6/USxVp4mybJLKeGEKDyks174z3TMhSxuqpI/g5wGO0kuieJRvWVBQtdEYlb6Y6zgqsr6pJU5Y3xYGOgXJE/6apSJlvmXA/C31w/SH3mkBDX0igJOwulDw=
Received: from BN8PR06MB5714.namprd06.prod.outlook.com (2603:10b6:408:d2::32)
 by BN7PR06MB5252.namprd06.prod.outlook.com (2603:10b6:408:3f::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Mon, 23 Nov
 2020 15:54:42 +0000
Received: from BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::71c8:3caa:6655:8d87]) by BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::71c8:3caa:6655:8d87%7]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 15:54:42 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: "Knight, Frederick" <Frederick.Knight@netapp.com>, "hch@lst.de"
 <hch@lst.de>, "George, Martin" <Martin.George@netapp.com>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Topic: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Index: AQHWvceZTKwQ33oCEkWHEJt+GYZ8+qnOUfKAgAJ1/QCABLR8gIAAWHaQ//+9poA=
Date: Mon, 23 Nov 2020 15:54:42 +0000
Message-ID: <938A98F6-0291-444F-B5CF-E6D7F1340B10@netapp.com>
References: <20201118114859.7985-1-marting@netapp.com>
 <20201118162415.GA16753@lst.de>
 <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
 <185CE0F5-617A-4446-A5C6-86A832D5A188@netapp.com>
 <DM5PR0601MB362496D2C29A18B3B1B77A61F1FC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
In-Reply-To: <DM5PR0601MB362496D2C29A18B3B1B77A61F1FC0@DM5PR0601MB3624.namprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.42.20101102
authentication-results: netapp.com; dkim=none (message not signed)
 header.d=none;netapp.com; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [216.240.30.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a35b4ca-a926-47d0-5db8-08d88fc817b3
x-ms-traffictypediagnostic: BN7PR06MB5252:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR06MB525273E27FC9AD5FAEEA9871E4FC0@BN7PR06MB5252.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hVbyLDkvCatHf9CJMAMgECNkjxG6+3nBYMn3xTihuf9PRTE6OV0bJa6qI3ERrE2s3wvOzKtLOdNzKbXGeC+CHErOxOWb1j/fjvnz8ryCP7Vg4RddQT/whPUz0002CKoCn+FED7Y4j0WV/P4g5glvrMKWAn+sXgQh6pHAk6iGHWiXsyoo3C8GxCA9SJ3yzC1yd67rAOk3kbhojtk9OHKJTmnYft4FW5NfeFByLV26uRNwAWd0aQDMzXWIMZwM/u+N7a+VS49DStKRStPljJTg+8luCZBBo/CoZWcqmqdjDtC7qjiAKrlX5nqkgbHQfhXj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR06MB5714.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(4326008)(2616005)(33656002)(8936002)(5660300002)(71200400001)(6506007)(107886003)(316002)(6486002)(110136005)(53546011)(54906003)(36756003)(2906002)(83380400001)(66446008)(6512007)(478600001)(91956017)(8676002)(64756008)(66556008)(66476007)(66946007)(26005)(6636002)(76116006)(186003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: sS24ymunICpBYsfYYH7c/CiwOr2R2FkeV5WmJA7ad0o2tvR6X3K5QSv8Z5xGldDiYsHZyNiCd9knsOfPHwL2EAW6gIDtg/OiD1gqRugCUauxJ2OXrYoRhLhOAMy3J8/kyE0RBX/ytVkP2WEkynNf550Kur0TA+FOF0TlUZpTcur0D/tl9yLa6MS+NICfmvK+9S8n8pJ91xRDFhM+3WZMZ1PGtAgGhGmoRnhMp0JkpbiSVUcITsuDYL7HQs7/2Sd53udDiLZFU8dIUWqF5FNtFgS6G/2yi92X7PK3AW+nSGsYHND9sVVAe7Q/vsVEOd4Ag7BUiFZPtRSXEMY6INgXOr8C5JNN6O99pP0UcwrUOVyL8/EWV3CgznJRRX9y4GKO39KyrQ1KyX40uFXVGQG7DV3DepiS8/0V3BhdagQrX4nPpPApyfurQvTOwZ02Pss9q975paXu0ws6VI3foKj+VDNJ+MO7X5JScY17JQZLyK7BJwTP0ziuLK5x1wSivIXaV6m9cF/Gf1S/+lILXccdJ9qqtXo2qHgJkJk2AfFABdTmJxEoC1IIWxjC+dxfdLhxemJ0rvRRhNV/spazUHZrZ6CK59KTA5G4LbQCP36+Mbf6NlPDcNxBSk88NqHoHoT4u8agzwhMnSQ0qrh9q9jd+6BCr8xpJaFIgWHGjLbtE2JWDKyUnbfjaCsC3q/ZVQfYuxhosf4rv/s7AwIJrDc0nG4mmTYkRa683Gl1OVnWjHktZ/2XFe6Nf9PuqB6hfnpPz2xVNaX0qSn5ghA0FBv79Xv599H03KaFzO+WpFkhVxkMkKbKu8Tkfrs41h0OpWhCIf2yh6p+lNopmAzTCJ1Zy0oHIj6eRrnoepkRKExKTWRV5iGtLgKXD/cfP40xWnzwz8U78zDV/rFiHXB8kRFIrA==
Content-ID: <0E25767D32A009459ED811F33D046E89@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5714.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a35b4ca-a926-47d0-5db8-08d88fc817b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 15:54:42.5567 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8dFkF6QiutSF5t3GbhrYJ/Skn4MJyZPLNbf7pD/P8nACiL36zd6OrwIpIvQuXsMXF61wkiwnvNtjjW5LLEdYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB5252
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201123_105445_314810_5AD357C8 
X-CRM114-Status: UNSURE (   9.23  )
X-CRM114-Notice: Please train this message.
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
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, Hannes Reinecke <hare@suse.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

ICAgT24gMTEvMjMvMjAsIDEwOjI3IEFNLCAiS25pZ2h0LCBGcmVkZXJpY2siIDxGcmVkZXJpY2su
S25pZ2h0QG5ldGFwcC5jb20+IHdyb3RlOg0KDQogICAgQ2hyaXN0b3BoIGNsYWltcyB0aGF0IHRo
ZSBBTkEgQUVOIHNob3VsZCBiZSBzZW5kIGJlZm9yZSB0aGUgTlMgQXR0cmlidXRlIENoYW5nZWQg
QUVOLiAgQW5kLCB0aGF0IGNvdWxkIGJlIHRydWUgZm9yIGFuIEFOQUdSUElEIA0KICAgIHRoYXQg
Y2hhbmdlZCAoYWx0aG91Z2gsIEkgZG9uJ3Qgc2VlIHRleHQgZGVzY3JpYmluZyBhbnkgcHJlY2Vk
ZW5jZSBvciBvcmRlciByZXF1aXJlbWVudHMgZm9yIGRlbGl2ZXJ5IG9mIEFFTnMpLCBidXQgdGhl
IE5TIGNyZWF0aW9uDQogICAgY2FzZSBpcyBleHBsaWNpdGx5IGV4Y2x1ZGVkLiAgRldJVyDigJMg
Q2hyaXN0b3BoIHdhcyBvbmUgb2YgdGhlIHBlb3BsZSB0aGF0IHJlcXVlc3RlZCB0aGlzIGV4Y2x1
c2lvbiB0byBwcmV2ZW50IHNwYW1pbmcgdGhlIGhvc3Qgd2l0aA0KICAgIG11bHRpcGxlIEFFTnMg
Zm9yIHRoZSBzYW1lIGV2ZW50IChhIE5TIGNyZWF0ZSkuDQoNCkFuIGV4aXN0aW5nIEFOQUdSUElE
IHdoaWNoIGNoYW5nZXMgb24gYW4gYXR0YWNoZWQgbmFtZXNwYWNlIHNob3VsZCBub3QgcHJvZHVj
ZSBhbiBOVk1FX0FFTl9DRkdfTlNfQVRUUiBBRU4uICBJdCBwcm9kdWNlcyBhbiANCk5WTUVfQUVO
X0NGR19BTkFfQ0hBTkdFIEFFTi4gIFRoaXMgaXMgY292ZXJlZCBpbjogDQoNCj4gIE5hbWVzcGFj
ZSBBdHRyaWJ1dGUgQ2hhbmdlZDogQSBjb250cm9sbGVyIHNoYWxsIG5vdCBzZW5kIHRoaXMgZXZl
bnQgaWY6IGIpIHRoZSBBTkFHUlBJRCBmaWVsZCAocmVmZXIgdG8gRmlndXJlIDExNCkgaGFzIGNo
YW5nZWQ7DQoNCiAgLSBhbmQgLQ0KDQo+ICBUaGUgQXN5bW1ldHJpYyBOYW1lc3BhY2UgQWNjZXNz
IGluZm9ybWF0aW9uIChyZWZlciB0byBzZWN0aW9uIDUuMTQuMS4xMikgcmVsYXRlZCB0byBhbiBB
TkEgR3JvdXAgdGhhdCBjb250YWlucyBuYW1lc3BhY2VzIGF0dGFjaGVkIHRvIHRoaXMgY29udHJv
bGxlcg0KPiBoYXMgY2hhbmdlZCAoZS5nLiwgYW4gQU5BIHN0YXRlIGhhcyBjaGFuZ2VkLCBhbiBB
TkFHUlBJRCBoYXMgY2hhbmdlZCkuIA0KDQpBbHRob3VnaCwgSSByZW1lbWJlciBhZ3JlZWluZyB3
aXRoIENocmlzdG9waCB0aGF0IExpbnV4IHdvdWxkIG5vdCBzdXBwb3J0IHRoZSAiQU5BR1JQSUQg
aGFzIGNoYW5nZWQiIEFFTi4NCg0KL0pvaG4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=

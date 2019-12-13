Return-Path: <SRS0=jPKm=2D=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634FBC43603
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 07:32:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F76622527
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2019 07:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aKKH5KtL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="bL4cfobh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F76622527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Yr5955F9kvsOTXlVVOYvREdw5EdLCFgx+s9KBsHS2PY=; b=aKKH5KtLJxSwlR
	qaniIZo0ydcbqq3fVZrT0I6fpWB/unWVl20PT6YZ28rHv+ZjDD6wUKvxRQGqxY/sFnbFNC1hxUac/
	WJmCVPmRQSxOuMeAHInl9pYNi5A+1l+gNghxqaVsZBaElPDIU6iDZXNjFLmLAPazz94xTvpv4BM0q
	WcMt7YeBqaTP1EMT3DOtgwWX9Aak25bbIF0pMyNeZQw1XBbcJCWQBpoy5VMTQZklBkh3nZB0LZ80L
	ZB/NIwQ+5ScomZsw+gxaCu5UGL3N4/dMDT8LyKlFnO4pEz0mngP1vvHfbupYUIIL74+SXcr0zr/h6
	NBMfK/++QF1V/St7TWjQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iffQx-0000Ha-RF; Fri, 13 Dec 2019 07:32:19 +0000
Received: from mail-eopbgr770050.outbound.protection.outlook.com
 ([40.107.77.50] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iffQu-0000HA-Hj
 for linux-nvme@lists.infradead.org; Fri, 13 Dec 2019 07:32:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rv9reUXSu++SWkuVsZhqioyVqM+iYL/pIWnnFtyEW4mGhJWYD0Xda027xkWqIYfExLhycTMtaDZIgt570dnn7mt9g7r1F8nTs0S4IXibOgf4SqSJ9VM7JZ4RPRm3mdA3b3hFOBC8QMwaZ8s6XRpbo3H3GL4lo4ukqYXsbbx4EHsOGpEPBbm+o+JJlK6ESTSDizrGtAYJ9uMU4E3wLP8qq+KsWgQpJ8P2eTDwOJvOPViaDT2cAzBiux8+er7CzhgGoLMgDKDqLu9VAn0DGEurRnGhyX0g055VvS961ywl/K4GNgTnZzpbum5rHr9pcCZ+iTCh6aE2bOUUQzUZZCnmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnPvQixMqNR2Ye/xoqNJ0D7G0fzeytSjZtybqEA965w=;
 b=H//bia9dOfrVUvg9xRRGXs2FV9yBWJVBmquZ0G07EYpzKBYS+sr7vCmuY6ZRLDME+4PpTtRQ/jWcliOYBvJkn9dFtHUosl/riHLN7S8gGO5Gn7YEQsO2S6+uqUoo4cCGuvXHQwy21R3on6AfRxynKURkhEmYkqIBc8SBq2LFmkIJYDAIZQ5mT920OMPp0g5CURR1YVZQkcbNzzyRvS8mnj/16bwKOh7ylmzHPdoYq9Q1RWPZtiXhO7c95PnCa/MvXpYmZUHGBqp3Sy9D4jO+ey+GWn8wWoGXBYKgnC6+oPozj0Epa/1OD3KhF779Re1FGWji17c6ayRFnj7XIyq6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnPvQixMqNR2Ye/xoqNJ0D7G0fzeytSjZtybqEA965w=;
 b=bL4cfobhUeASFaEtHIeGM9hxnukqAA6RCkxZyUz7mZCYiOGiHP8JpoGBISuREE72kFIvenS3V3mOs/K4sWsHc0hGrpV4SRCBAHGd9GQuBvWJhN7yzKZKjn7Q8vHZFVZNBJe4l5WqPR9afelksWJAisXQHK0YvbcHrBzav6t96qo=
Received: from BN8PR06MB6115.namprd06.prod.outlook.com (20.178.216.139) by
 BN8PR06MB5988.namprd06.prod.outlook.com (20.179.140.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 13 Dec 2019 07:32:13 +0000
Received: from BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::2ce7:cdc1:b974:dce1]) by BN8PR06MB6115.namprd06.prod.outlook.com
 ([fe80::2ce7:cdc1:b974:dce1%7]) with mapi id 15.20.2538.017; Fri, 13 Dec 2019
 07:32:12 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Keith Busch <kbusch@kernel.org>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: Translate more status codes to blk_status_t
Thread-Topic: [PATCH] nvme: Translate more status codes to blk_status_t
Thread-Index: AQHVq6ZMkO6rhLvvLE+5xlPgo7ojn6e2nUWAgADGeYA=
Date: Fri, 13 Dec 2019 07:32:12 +0000
Message-ID: <C041F01A-6577-4DC4-A992-6F040EC6C0C9@netapp.com>
References: <20191205195730.5774-1-kbusch@kernel.org>
 <93B95176-A634-4A62-A8BF-2C599E597979@netapp.com>
In-Reply-To: <93B95176-A634-4A62-A8BF-2C599E597979@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.1f.0.191110
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2b609ef2-1d6d-4c7a-2785-08d77f9e9225
x-ms-traffictypediagnostic: BN8PR06MB5988:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR06MB598848882D631EA533E80FD4E4540@BN8PR06MB5988.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0250B840C1
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(26005)(8676002)(478600001)(71200400001)(6486002)(54906003)(86362001)(55236004)(53546011)(316002)(8936002)(33656002)(6506007)(81166006)(110136005)(81156014)(186003)(36756003)(2906002)(91956017)(66556008)(5660300002)(64756008)(2616005)(66946007)(76116006)(4326008)(6512007)(66446008)(107886003)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN8PR06MB5988;
 H:BN8PR06MB6115.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7j+2nAu3ik5nSFU19rd33xlXDCnuEAXUvrxVH/vwMcbuAgAjoiaCIXdqnvCB+p0OEsRZABwZrRW7kl01YAwhwVPXBAh7BmfwqPeNDnGDEOXHIUYFfoYVZqU+F+gxn/8MT2aqC8IROD3j9ZJvVLWlx+FZ2/ADoyEcf4+O/cqSNHfzzeoF7YYAfXfjZ90pqviKCn7+AobWvjQJSG6N9zpQtMO05fINp+KfH8SjqR/wmTsLV1IMZAzGQKIgJx284dwaieEj5ydhXsBJHb9NIbHJFBGjSX6kzNqmqIu7KtPboYahDpUxL86LOmr0CIq+2xFYn1jHdk5+PUnP+ObsVAGGUSGsiSxpCj4X3kJvLOuW9V54uXA28tTGNAFHBXNVh4S4+vH16GbtO5/8qdLiGo/LOI29gSHldh45GKN0feMq6To6TSxR8LKvrX9z4gmO+6Go
Content-ID: <D182A811EA868248AF1997140A7C7817@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b609ef2-1d6d-4c7a-2785-08d77f9e9225
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 07:32:12.6335 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w/OiNUYK147lARNf9gCEBloTx8iOKyC1sWjUsJSqjIN2a/Ctns1KlT+WLszBxhVqGkV440ULmu86mYgUc8VFjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR06MB5988
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_233216_648110_6B75A7C1 
X-CRM114-Status: GOOD (  10.76  )
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
Cc: Hannes Reinecke <hare@suse.de>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTIvMTIvMTksIDI6NDEgUE0sICJNZW5lZ2hpbmksIEpvaG4iIDxKb2huLk1lbmVnaGluaUBu
ZXRhcHAuY29tPiB3cm90ZToNCiAgICANCiAgICBMZXQgbWUgdGVzdCB0aGlzIG91dCBhbmQgSeKA
mWxsIHNlZSB3aGF0IGhhcHBlbnMuDQogICAgDQpLZWl0aCwgSSd2ZSB0ZXN0ZWQgdGhpcyBvdXQs
IHVzaW5nIENSRCB3aXRoIGJvdGggTlZNRV9TQ19DTURfSU5URVJSVVBURUQgYW5kIE5WTUVfU0Nf
TlNfTk9UX1JFQURZLg0KDQpJdCB3b3JrcyB3ZWxsIGVub3VnaCwgYnV0IEkgdGhpbmsgdGhlIHBy
b2JsZW0gZ29lcyBhIGxpdHRsZSBkZWVwZXIgdGhhbiB0aGlzLg0KDQo+IFRoZXNlIGFyZSBub3Qg
Z2VuZXJpYyBJTyBlcnJvcnMgYW5kIHNob3VsZCB1c2UgYSBub24tcGF0aA0KPiAgc3BlY2lmaWMg
ZXJyb3Igc28gdGhhdCBpdCBjYW4gdXNlIHRoZSBub24tZmFpbG92ZXIgcmV0cnkgcGF0aC4NCg0K
WWVzLCBhZ3JlZWQuICBCdXQgd2UgaGF2ZSB0aGlzIHByb2JsZW0gd2l0aCBldmVyeS9hbnkgb3Ro
ZXIgTlZNZSBzdGF0dXMgdGhhdCBnZXRzIHJldHVybmVkIGFzIHdlbGwuDQpJdCBkb2Vzbid0IG1h
a2Ugc2Vuc2UgdG8ganVzdCBrZWVwIG92ZXJsb2FkaW5nIHRoZSBoYWxmIGEgZG96ZW4gZXJyb3Jz
IHlvdSBoYXZlIGluIGJsa19wYXRoX2Vycm9yKCk7DQoNCkkgdGhpbmsgdGhlIHJlYWwgcHJvYmxl
bSBpcyBoZXJlOg0KDQogMjc2ICAgICAgICAgaWYgKHVubGlrZWx5KHN0YXR1cyAhPSBCTEtfU1RT
X09LICYmIG52bWVfcmVxX25lZWRzX3JldHJ5KHJlcSkpKSB7DQogMjc3ICAgICAgICAgICAgICAg
ICBpZiAoKHJlcS0+Y21kX2ZsYWdzICYgUkVRX05WTUVfTVBBVEgpICYmDQogMjc4ICAgICAgICAg
ICAgICAgICAgICAgYmxrX3BhdGhfZXJyb3Ioc3RhdHVzKSkgew0KIDI3OSAgICAgICAgICAgICAg
ICAgICAgICAgICBudm1lX2ZhaWxvdmVyX3JlcShyZXEpOw0KIDI4MCAgICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm47DQogMjgxICAgICAgICAgICAgICAgICB9ICAgICANCiJudm1lL2RyaXZl
cnMvbnZtZS9ob3N0L2NvcmUuYyIgbGluZSAyODEgb2YgNDI2NyAtLTYlLS0gY29sIDMtMTcNCg0K
SWYgd2UgYXJlIHJlYWxseSBub3QgYWxsb3dlZCB0byBjaGFuZ2UgdGhlIGJsa19wYXRoX2Vycm9y
KCkgcm91dGluZSBiZWNhdXNlIGl0J3MgYSBwYXJ0IG9mIA0KdGhlIGJsb2NrIGxheWVyLCB0aGVu
IHdoeSBkbyB3ZSBoYXZlIGl0IHN0dWNrIGluIHRoZSBtaWRkbGUgb2Ygb3VyIG11bHRpcGF0aGlu
ZyBwb2xpY3kNCmxvZ2ljPw0KDQpNYXliZSB3ZSBzaG91bGQgY3JlYXRlIGFuIG52bWVfcGF0aF9l
cnJvcigpIGZ1bmN0aW9uIHRvIHJlcGxhY2UgdGhlIGJsa19wYXRoX2Vycm9yKCkgDQpmdW5jdGlv
biBoZXJlLg0KDQpUaGUgb3RoZXIgcHJvYmxlbSBpczogc2V0dGluZyBSRVFfTlZNRV9NUEFUSCBj
b21wbGV0ZWx5IGNoYW5nZXMgdGhlIGVycm9yDQplcnJvciBoYW5kbGluZyBsb2dpYy4gIElmIG15
IGNvbnRyb2xsZXIgaGFzIGEgc2luZ2xlIHBhdGggaXQgaGFwcGlseSByZXR1cm5zIGFsbCBraW5k
cw0Kb2YgTlZNZSBlcnJvcnMgbm90IGhhbmRsZWQgYnkgdGhlIG52bWVfZXJyb3Jfc3RhdHVzKCkg
d2hpdGUgbGlzdC4gIFRob3NlDQplcnJvcnMgYWxsIGZhbGwgdGhyb3VnaCB5b3VyIHJldHJ5IGxv
Z2ljIGFuZCBlbmQgdXAgcmV0dXJuaW5nICBCTEtfU1RTX0lPRVJSLg0KDQpIb3dldmVyLCBhcyBz
b29uIGFzIHdlIGFkZCBhbm90aGVyIHBhdGggdG8gdGhhdCBzYW1lIGNvbnRyb2xsZXIsIGFuZCB0
dXJuIG9uIA0KUkVRX05WTUVfTVBBVEgsIGFsbCBvZiBhIHN1ZGRlbiB0aGUgY29udHJvbGxlciBn
ZXRzIGEgcmVzZXQgZm9yIHJldHVybmluZw0KdGhlIHZlcnkgc2FtZSBlcnJvcnMgdGhhdCBpdCBy
ZXR1bmVkIGJlZm9yZS4NCg0KQW5kIHRoYXQgaGFwcGVucyBiZWZvcmUgZXZlbiBhIHNpbmdsZSBy
ZXRyeSBpcyBhdHRlbXB0ZWQgLSB1bmxlc3MgaXQncyBhbiBOVk1lIHBhdGhpbmcgZXJyb3IuDQoN
CjEwNSAgICAgICAgIGRlZmF1bHQ6DQoxMDYgICAgICAgICAgICAgICAgIC8qDQoxMDcgICAgICAg
ICAgICAgICAgICAqIFJlc2V0IHRoZSBjb250cm9sbGVyIGZvciBhbnkgbm9uLUFOQSBlcnJvciBh
cyB3ZSBkb24ndCBrbm93DQoxMDggICAgICAgICAgICAgICAgICAqIHdoYXQgY2F1c2VkIHRoZSBl
cnJvci4NCjEwOSAgICAgICAgICAgICAgICAgICovDQoxMTAgICAgICAgICAgICAgICAgIG52bWVf
cmVzZXRfY3RybChucy0+Y3RybCk7DQoxMTEgICAgICAgICAgICAgICAgIGJyZWFrOw0KMTEyICAg
ICAgICAgfQ0KIm52bWUvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMiIGxpbmUgMTEyIG9m
IDczOSAtLTE1JS0tIGNvbCAxLTgNCg0KVGhpcyBtYWtlcyBubyBzZW5zZS4NCg0KL0pvaG4NCg0K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

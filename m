Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956BEC4360C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 22:15:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50BB02075D
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 22:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nyvdAME8";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gv1ankqx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nqBfsEyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50BB02075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0ZMohw+c4feHwi1sakcbBUsZAYi28qdYPX449nDlQtU=; b=nyvdAME8HhAqcO
	uMZmXyN4NnSve+ywIxzxxL7a6DlGLjHAeVQa/z1nXZFU/h2llF7RFPy+ES2pSAhVzTWrq/HS3yYXX
	TLP/PiPizonNR1DH4zGuf5LWH9FLJ6JAdWrLjHM3Qmv8G7SNFcQbXOlYNLUK/YVvics4tfgDyqyId
	RStIJq9iDyfl1me8Spq5NapSozQEQ9lttq1hAwWjs3SVtnu0GaFOpUZs5KBZs4W4mUFoCfZBgSaHn
	i6VcDkBLHDBjzoEMfzijiNfakFPKY7C/0YCR3GyjWnQdQAhvEqHbLauGruUO3MRML4EU05xmkEYOS
	jfP8rBupoQm/77FXZxLg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDyWP-0000ke-3h; Fri, 27 Sep 2019 22:15:29 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDyWM-0000k5-HJ
 for linux-nvme@lists.infradead.org; Fri, 27 Sep 2019 22:15:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1569622527; x=1601158527;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=18nnYcAly705SsFIHHQxWPa1cDAft4V+6fwGFI589Xg=;
 b=Gv1ankqxkIUv78VnEuCYfefPXKgFyvpFBqst1aRB2FaDn+7CSJrsC2zf
 gc9ND5wMkSJmoaj4SW206erVmMdnbv6s7inwOFhHlIcxu2SFZbItjZEv2
 rZHW/4xwt6miombhaLdf27YnyU3onw7T3SeCj+4pktxOq2pLDvgJtiA0m
 w2AH87woo8c9AqBr9H2i9oSAkCIlICXK9qhGPb1D+JfLigc12I+dAb6/b
 pDnZFcfxotS3821/7E0nuk8g5On9SxtVcTwjmxY2f3DuYoNALv0tXrbYQ
 8F4/mhojnZVSrL5JWwog2wfXqKifq+NE/kjRSr3lEax62xmraXYoR22nd Q==;
IronPort-SDR: n/zSe/OHd9UOv/dax1WscCrXQ+p1BbEHeGigKbq0595xm/V87sHiMhFe8WPHq4xuiq6WPSKirY
 np1L6V9tyuybTtVM5kHpDqGBkMWLTdOiPq3cZep3iYUYEzm1UJUJOtaTG3SIzWN5oQpaz6n390
 lFZzP0ZSPLwxxdXXE6KE+dCzNcqgEqCFgG4aXZfbWtL7zLxO9pqB3iHKZGJgRlRCOrfVJnhib8
 WrihWi7D1cK0QTQ3VSs8wUOvLKzageq2cmf9485JZwGK9W1qgM8T0pasuPEn3TWeh40oOwLHNP
 4mw=
X-IronPort-AV: E=Sophos;i="5.64,557,1559491200"; d="scan'208";a="120087746"
Received: from mail-sn1nam04lp2051.outbound.protection.outlook.com (HELO
 NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.51])
 by ob1.hgst.iphmx.com with ESMTP; 28 Sep 2019 06:15:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmUYMa6uOjxyPHKoqp/oUNV2zFNkzE+6SKsBDG9YypXGYXtRDM7hir3ms8vYVx9Yh6LMybekERGWJGW8aYRMFaZZeS/gyyRqTClHAOHjdZU9QumSSDiVYzfkd5gaf6KlYYVVQk4J3Nsp9dYO49ImqjaeAHv3QuSH13dNdzWCDiGMejwRl0lf5bvj/YB8JvYkVCcsFIHB6X3T9abRfdc+kgSuGtD268Y7jHdDqB37JAsM+6me4ESp2qNSy4scwN9ez/ZP9XmomHH9JPWGCOY4eEBHedeoMu8Mcz0MDsGULbO89iuGoMpS/bfl3r9sXx2zReCbpqejReHvUJ3gWdbOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18nnYcAly705SsFIHHQxWPa1cDAft4V+6fwGFI589Xg=;
 b=ZFkvbLCZZI6yCWHeuP8+EOdcZa4rpnfEWjIJYjgf3Wm/Pr5hSVDpQ+zpP++hfcDPGVA9fRrbTJvjAy8aidw52+dROu6Z0gWHBO+NMRQQKMmo19YQSyBMfpJ9xxNIBPfJ+5lw8vYOeKkrMW6H1vX+ZuelpBqU+f/vlwGNLNyEDR+GhOKc/DGiE3ZOi6Dc9iD1uOboa18wusLDKQdngHgzGrEtq5n4dNM4H3Hl2Bz/qKMWUV6aAohQamZZpczynt34R5UAvBFiQ+aB6yQsSAiYncwvy/bbYtunvO3MTqAVblj9JGXQ7n4GOBfzVf34ADhbSvAZmJBRcGxmaXs4gKWEdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18nnYcAly705SsFIHHQxWPa1cDAft4V+6fwGFI589Xg=;
 b=nqBfsEyi7p4qXKbF6TxspZ8+FEIxE7A7uABnZyxrRGaPCj9flsVszpwL6DTZK4iUB/zRGj4SbZwZKHwQxs4w3/a8cFtX/UGVtIrTZ1p9fGhxrI4Pyj1uQ22ZCChSNkZAzs01QupURckw5cHk8488wK7WlT5suGUf7xDzy3H8+vQ=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB4312.namprd04.prod.outlook.com (20.176.251.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Fri, 27 Sep 2019 22:15:23 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6169:680:44fc:965d%6]) with mapi id 15.20.2284.028; Fri, 27 Sep 2019
 22:15:23 +0000
From: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: set NVME_REQ_CANCELLED flag when cancelling a
 request
Thread-Topic: [PATCH] nvme: set NVME_REQ_CANCELLED flag when cancelling a
 request
Thread-Index: AQHVb9/uCvIXRTLrl0GVafrQHvP0R6c5giCAgAaUQQCAAAv6AA==
Date: Fri, 27 Sep 2019 22:15:23 +0000
Message-ID: <81E83C39-FFED-4E7B-BB6B-0587FAB15B3B@wdc.com>
References: <20190927213230.GF16819@lst.de>
In-Reply-To: <20190927213230.GF16819@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2600:1012:b14f:cf6d:a007:86f2:633f:4a4c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 841d4c18-badc-4ff9-78a7-08d743983105
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);
 SRVR:BYAPR04MB4312; 
x-ms-traffictypediagnostic: BYAPR04MB4312:
x-microsoft-antispam-prvs: <BYAPR04MB4312913CDA9695137259CF3186810@BYAPR04MB4312.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0173C6D4D5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(199004)(189003)(81156014)(76176011)(7736002)(54906003)(256004)(6512007)(478600001)(76116006)(5660300002)(476003)(2616005)(6506007)(36756003)(186003)(229853002)(6246003)(4744005)(6916009)(46003)(99286004)(102836004)(4326008)(53546011)(33656002)(486006)(66476007)(25786009)(14454004)(71190400001)(71200400001)(6116002)(66556008)(86362001)(11346002)(446003)(6436002)(2906002)(66946007)(66446008)(64756008)(6486002)(316002)(8936002)(305945005)(81166006)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR04MB4312;
 H:BYAPR04MB5749.namprd04.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: //Lggkv8ASmDZg1oDXQmwf16OsT64heo3lrqzF5swF+CBhrAScB806SiefzFMSoo4itAeeWukQ2wN5SheSGuB+8KIaKSUrplnS5ajeHIHKZTs97yWZKN6vMV17+YeC06fC+3TrYCg+COIunMmLdhcMcUmrqlrEO9goAlmS6CvR71kpdZK+fbAHhCXkNuU5OxG7dbQtokBtjp0mhJa5NrHFfKoUfQQ0tZKN/Q8SNEHVbBqZzx05qXkLDXCduFLQtuCzEaDQTFblbjwwYG/s2RBs6u9+D/0tbfjCjPVAhym/o9iG/BF8bv4M9+IDXpC6ai/Q+fmdXMFwgqwio4j2XcSZvvt8HaLkxQhDOY2Oezy0Pv+dRV6rGEUUR1ImkjiMGqni6fl3fQ0bjT5YgSKkL88DfCLbw0SyILuJLRGtUI/Nk=
x-ms-exchange-transport-forked: True
Content-ID: <9915D386DA55C54084C70FBD84558CF7@sharedspace.onmicrosoft.com>
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 841d4c18-badc-4ff9-78a7-08d743983105
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2019 22:15:23.1507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6ttvSqaCD63n5NpKD/BzHQkahu+G5Vc7WQRgCBErCD+mOtRixBATvVoCItswdrewOpaScB9l/EFNnbvVc9WbxZjNCXKQ8yEm9jQwT6uAq64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4312
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_151527_432526_2227F5E2 
X-CRM114-Status: GOOD (  12.37  )
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
Cc: Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T2theS4gV2UgY2FuIGFkZCBtaXNzaW5nIGNoYW5nZXMgYXQgdGhlIHRpbWUgb2YgYXBwbHkgSSBh
bSBmaW5lIGFueXdheS4gDQoNCj4gT24gU2VwIDI3LCAyMDE5LCBhdCAyOjMyIFBNLCBDaHJpc3Rv
cGggSGVsbHdpZyA8aGNoQGxzdC5kZT4gd3JvdGU6DQo+IA0KPiDvu79PbiBNb24sIFNlcCAyMywg
MjAxOSBhdCAxMDowNDoxOUFNIC0wNzAwLCBTYWdpIEdyaW1iZXJnIHdyb3RlOg0KPj4+IElmIHlv
dSBhcmUgb2theSBJIGNhbiBzZW5kIGEgc2VwYXJhdGUgcGF0Y2ggb24gdGhlIHRvcCB5b3Vycy4N
Cj4+IA0KPj4gVGhhdCBpcyBmaW5lIHdpdGggbWUuDQo+IA0KPiBJIHRoaW5rIHdlIHJlYWxseSBz
aG91bGQgaGF2ZSB0aGUgd2hvbGUgdGhpbmcgaW4gb25lIHBhdGNoIG9uZSB3YXkgb3INCj4gYW5v
dGhlci4NCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

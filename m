Return-Path: <SRS0=38m3=E5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0023CC6379F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 14:35:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FEE320773
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2020 14:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vFVj6ZOn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="AXbVzQdB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FEE320773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0cmfbl9W5kpooiWBxGuWP0p3ysFiaU6OAgIWmYm3Zgw=; b=vFVj6ZOnhiHKllO3BtPzxNn9Q
	GPd8C5aBML9JJBVA3HWdF85I0BJ1NOHCwS9AToE956AeWJk+ZnOkWemZqEfGy2JRHZ6f89bBLFg/s
	cYDYIe1AieDNdkH7CJzUXcwU0wZk0AN4UrVqR3WgmbqoX1soGme31beIrvZf7TUZLdpvDI+TjllfI
	tT3PS3r66Y9mPZPKFpX1losHF7RkRyD296DKQNL5p+6EH3avwF/HknbotsOJMvzRlDxrjRaK2fk9P
	arByswJx90e4R1e43/d34W3zJcE5/5EEeBY+VqWXNNFmJ/ydtcw4YFtq7R7MphpC/wp7rDLlXB7QY
	eZYnhJO/g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khCwW-00008Y-Iq; Mon, 23 Nov 2020 14:35:48 +0000
Received: from mail-dm6nam11on2075.outbound.protection.outlook.com
 ([40.107.223.75] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khCwO-00005Z-NW
 for linux-nvme@lists.infradead.org; Mon, 23 Nov 2020 14:35:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qu56NeaJy6YLu0E4t8zD6Kup1/p2m9PqRW13CtS0dC0IOKYmXYdZnWjXlMPKeXroD1BuNBZTPyjZc7yUTonQnDTtJuZLIo1VgF3wfvYFdxIRsegdTPpf+BT7I8vXZR2JK7ykT1RnFb8WO1KRSbS5SO5gW8jeWZK5QwtaWyM5O5GXvqLXjA9kKnmX5LlXUnV1wjeccOfpeUS4sC5tPe6+tpAHBnFT+aGEaiR9lVqg6b4AtZZn+Xr5fPkxBgaHiMxmT5ojChkYSBPYbIQsY9xXR9/b6NFUtK8wy1Yrn3sSHClu3kxanHPmxtSIF3mL4F8f2PRfnHqO5kYX1c3tb0jZcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR5juG1wK/64n0AbClsjc+suX6grYMCNVfa2jcNQQ2o=;
 b=f68dg8Ltqcr5/C+LKmA1M70mV2h3Skhs/Y6m1ePHjP2EjMTuj/czcaHEJwEtuYBzp5Y9kjBClnXoDdb/UaBWKTzbfjhMgG1h0K52UQhHs7j6r3vf+uGTpvR/J3Yb7Ty7qBvkxq0eOO+2eBDrxz66+CltMEBxIj1JZOOAxFptWGa44sfl4QPA5xfEMndjOXIVrEXkk5+m3kEj6oGg1SgxZlr+X556ZGJGtCpkV/Y0duHm3kFNucvxDDGGY06Ts98n/pz7Qi4+nY/j7/sMcGHSC/GXRO689RcVfhF4WSVJrWWTDcLe0HcznkT0bZAkI6PuUjAsZ7IAwxJixVGi7lJYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bR5juG1wK/64n0AbClsjc+suX6grYMCNVfa2jcNQQ2o=;
 b=AXbVzQdBRmMDEDf6lEhTPqsQbylxCLfJFdjB7PGIEefT1sO/Iq1y/LBHE7DexFhG2cOwMnp8pn8PQijciqFKyXIzP/DQ83waS+jUbDipSfWR8hUFw9m2lvDr6OBHZzIUzpw5faXA3G6XBty8Q4UUljtsiV1MztFJqSN0ie7MGQQ=
Received: from BN8PR06MB5714.namprd06.prod.outlook.com (2603:10b6:408:d2::32)
 by BN7PR06MB6323.namprd06.prod.outlook.com (2603:10b6:408:3e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Mon, 23 Nov
 2020 14:35:34 +0000
Received: from BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::71c8:3caa:6655:8d87]) by BN8PR06MB5714.namprd06.prod.outlook.com
 ([fe80::71c8:3caa:6655:8d87%7]) with mapi id 15.20.3589.030; Mon, 23 Nov 2020
 14:35:34 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: "hch@lst.de" <hch@lst.de>, "George, Martin" <Martin.George@netapp.com>
Subject: Re: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Topic: [PATCH] nvme-core: update NS Attr Changed AEN handling for ANA
 group
Thread-Index: AQHWvceZTKwQ33oCEkWHEJt+GYZ8+qnOUfKAgAJ1/QCABLR8gA==
Date: Mon, 23 Nov 2020 14:35:33 +0000
Message-ID: <185CE0F5-617A-4446-A5C6-86A832D5A188@netapp.com>
References: <20201118114859.7985-1-marting@netapp.com>
 <20201118162415.GA16753@lst.de>
 <7fd0b51f3b7bc73abf7132aaa5ee7c493a93aef0.camel@netapp.com>
 <20201120094432.GA25846@lst.de>
In-Reply-To: <20201120094432.GA25846@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.42.20101102
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [216.240.30.25]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f5d0602-4c4a-4f52-04ba-08d88fbd0947
x-ms-traffictypediagnostic: BN7PR06MB6323:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR06MB6323A117B07E1027B139460EE4FC0@BN7PR06MB6323.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1fHNFBJryj8YAZ9p+2iaWbwUzrTfmiDJMEGo/y98hTtWyKptMIyhgOCcZFFRG8+Te0ZKDM8wirwKDz9uUblqiTMwOvXyXfibiuWthvdQlf7RKXJmcU62Su8WI5s6eLCL6z/FS634sR7ifKeQ5pqKqrI1RSqBNIR01u2IzrTWNXcsli6L/cR0W64ads5Y+I3n/nj0wyHZyTjskGr3PwiTPXdjIK0jU1q74Kk8WhCWMF8JO7tL5xkcHsRN6i6HN/2913+uaR+pDkWwHJMxqkll6UHd+KxevUtODgtwNcO7RVI+Qsf2xutrY45AKXFlufwfpB5qWMTKlaFj3qcgT7W2+OmOvy+CA2+N+P1/vkVnwCWiBAZBnWzctwl8DRXmzlC8d9M/cou8rAa562PSziwv0Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR06MB5714.namprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(8936002)(5660300002)(6512007)(478600001)(8676002)(54906003)(15650500001)(110136005)(83380400001)(6486002)(4326008)(6506007)(316002)(86362001)(53546011)(2906002)(186003)(966005)(33656002)(26005)(36756003)(71200400001)(76116006)(91956017)(66946007)(2616005)(6636002)(64756008)(66556008)(66446008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: SPWwDWdkKpIB1Bf3zUY2PCoilhvHcapW+I7vKme1nqufuC/a+BB8OlyGHRiXoQBpsQAfZ5vqVls4ErFHNTupqg3emaZvKT5OYcQUsVfgqv1DpUVBcLd7qyhgY78AZs3BlCt1n+ieBkGANKA7Jk6J5yqZS5ZdBghIM2Yv+uhTGeZ9pwoTYlQ9GpihTMzZoh8GLWNGZ2FK9kBoQOgrPA9IM5DdYGuK94sHc7YRTN5zdwU0wOllwbnjf1PEuu4tdj4oFaK2XadJ43pavfUooTYPOax3fJTtOvPgMqiXlKmGly++aWOE9cRuV+/r8+vWxA+rR1mvwV7IPEzKKI0s4eCxOSegnlu261lRaPNN7c0TG8z1eSenJ1e0zf8uKntjN0XdIv4uzLrNRWg5BjxvAObjTsdAkXQqtR/onvcjIWKcsi4zrZ0T+Vcypk7g7HDXdOsVTaFZlKKd25i+1EmbzmopNUbiXsJCuBTjNX2riOrkJ/7+foeXDhad+Z7P8RLYQhNaPu8BhTaxyeb2e9ZRKzE1q8UUWoZ2TXH1KTWBqP686Z6YpSrgl3lihFAAzJaDMPaKNB0CW2M1MliJkJ2LlNAUw8uVPCZ9S59QPRl5Qb6XFYfgcMj11d3bqlRdYvfwGqM/IzgII+Aez6W3qpYbpO4rEQKAo3P6sby1+Nc/S8H8s9aNnIX353/d6CuvHKJAnkiJZsaifoDF4G/GqOnlbwB8J937cKl94dNwCTNy15zlP6lbs+uzq4LGo5x6LBFSJ7EU4wsMLW3EqbnPJ2hkPL5aNb6DyO1lJq/m4t8ZTDocV2wMnpmSXGaXd3aow4M5MTbxh2u/0EJ442a5/bt/ZEB5C8M6wxJKStxAQJERnbIFSaUSo4S1b0gAdjjmk14oG99f87hlCsV8dWhguXpJy9u4UA==
Content-ID: <1B5B9DDE162F3B4DA50B64927201FF4B@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR06MB5714.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5d0602-4c4a-4f52-04ba-08d88fbd0947
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2020 14:35:33.9265 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJ1vCQnqTpe1PCjtC++MRsNXfvUO+QQTHsfCTiyGguqsPKKo6YmTbNqjVnYs6hZmpuqTCTcvRNbGHsA1gpu7aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB6323
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201123_093540_949726_304DDA4A 
X-CRM114-Status: GOOD (  17.69  )
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
Cc: Hannes Reinecke <hare@suse.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "Knight,
 Frederick" <Frederick.Knight@netapp.com>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMjAvMjAsIDQ6NDkgQU0sICJMaW51eC1udm1lIG9uIGJlaGFsZiBvZiBoY2hAbHN0LmRl
IiA8bGludXgtbnZtZS1ib3VuY2VzQGxpc3RzLmluZnJhZGVhZC5vcmcgb24gYmVoYWxmIG9mIGhj
aEBsc3QuZGU+IHdyb3RlOg0KDQogICAgT24gV2VkLCBOb3YgMTgsIDIwMjAgYXQgMDg6MDk6NDNQ
TSArMDAwMCwgR2VvcmdlLCBNYXJ0aW4gd3JvdGU6DQogICAgPiA+IEhvdyBjYW4gdGhlIG5hbWVz
cGFjZSByZWZlcmVuY2UgYW4gQU5BIGdyb3VwIHRoYXQgd2UgaGF2ZW4ndCBiZWVuDQogICAgPiA+
IG5vdGlmaWVkIGFib3V0IHVzaW5nIHRoZSBOVk1FX0FFTl9DRkdfQU5BX0NIQU5HRSBBRU4gYmVm
b3JlPw0KICAgID4NCiAgICA+IFdlbGwsIEkgdGhpbmsgdGhhdCBjb3VsZCBiZSBwb3NzaWJsZSBm
b3IgYSBuZXdseSBjcmVhdGVkIG5hbWVzcGFjZSwNCiAgICA+IHdoaWNoIGhhcHBlbnMgdG8gYmVs
b25nIHRvIGEgbmV3IEFOQSBncm91cC4gVG8gcXVvdGUgdGhlIDEuNCBzcGVjIGluDQogICAgPiBj
b250ZXh0IG9mIEFzeW1tZXRyaWMgTmFtZXNwYWNlIEFjY2VzcyBDaGFuZ2UgdW5kZXIgdGhlIEFz
eW5jaHJvbm91cw0KICAgID4gRXZlbnQgSW5mb3JtYXRpb24gLSBOb3RpY2UgKEZpZ3VyZSAxNDcp
Og0KICAgID4NCiAgICA+ICJBIGNvbnRyb2xsZXIgc2hhbGwgbm90IHNlbmQgdGhpcyBldmVudCBp
ZjoNCiAgICA+IGEpIHRoZSBjaGFuZ2UgaXMgZHVlIHRvIHRoZSBjcmVhdGlvbiBvZiBhIG5hbWVz
cGFjZSAocmVmZXIgdG8gc2VjdGlvbg0KICAgID4gNS4yMCk7IG9yDQogICAgPiBiKSB0aGUgY2hh
bmdlIGlzIGR1ZSB0byB0aGUgZGVsZXRpb24gb2YgYSBuYW1lc3BhY2UgKHJlZmVyIHRvIHNlY3Rp
b24NCiAgICA+IDUuMjApLA0KICAgID4gYXMgdGhlIE5hbWVzcGFjZSBBdHRyaWJ1dGUgQ2hhbmdl
ZCBldmVudCBpcyBzZW50IGZvciB0aGVzZSBjaGFuZ2VzLiINCiAgICA+DQogICAgPiBTbyBpdCBs
b29rcyB0aGUgTlZNRV9BRU5fQ0ZHX0FOQV9DSEFOR0UgQUVOIGlzIG5vdCByZXF1aXJlZCBoZXJl
IGZvcg0KICAgID4gc3VjaCBjYXNlcywgYnV0IGluc3RlYWQgdGhlIE5WTUVfQUVOX0NGR19OU19B
VFRSIEFFTiB3b3VsZCBkby4NCg0KICAgIEZvciB0aGUgbmV3bHkgY3JlYXRlZCBuYW1lc3BhY2Ug
dG8gYmVvbmcgdG8gYSBuZXdseSBjcmVhdGVkIEFOQSBncm91cA0KICAgIHRoZSBjb250cm9sbGVy
IGZpcnN0IG5lZWRzIHRvIHNlbmQgTlZNRV9BRU5fQ0ZHX0FOQV9DSEFOR0UgdG8gYW5ub3VuY2UN
CiAgICB0aGUgQU5BIGdyb3VwLCBpdCB0aGVuIHNlbmQgTlZNRV9BRU5fQ0ZHX05TX0FUVFIgdG8g
YW5ub3VuY2UgdGhlDQogICAgbmV3IG5hbWVzcGFjZXMuICBCdXQgdGhlIG5ldyBuYW1lc3BhY2Ug
Y2FuJ3QgcmVmZXJlbmNlIGFuIEFOQSBncm91cA0KICAgIHRoYXQgZGlkbid0IGV4aXN0LCB0aGF0
IGlzIGEgc2VwYXJhdGUgZXZlbnQuDQoNCkkgcmVtZW1iZXIgZGlzY3Vzc2luZyB0aGlzIGF0IGxl
bmd0aCB3aGVuIHdlIHdyb3RlIHRoaXMgdGV4dCBmb3IgVFAtNDAwNC4gICBXZSBleHBsaWNpdGx5
IHJlc3RyaWN0ZWQgIE5WTUVfQUVOX0NGR19BTkFfQ0hBTkdFIEFFTnMgdG8gQU5BIHN0YXRlIGNo
YW5nZSBldmVudHMsIGFuZCBBTkFHUlBJRCBjaGFuZ2UgZXZlbnRzLiAgQW5kIHdlIHJlc3RyaWN0
ZWQgTlZNRV9BRU5fQ0ZHX05TX0FUVFIgQUVOcyBzbyB0aGF0IEFOQSBzdGF0ZS9BTkFHUlBJRCBj
aGFuZ2UgZXZlbnRzIHdvdWxkIG5vdCBnZW5lcmF0ZSBhbiBOVk1FX0FFTl9DRkdfTlNfQVRUUi4g
IFdlIGRpZCB0aGlzIHNvIGFzIHRvIGF2b2lkIGR1cGxpY2F0ZSBBRU5zLiBUaGUgZGlzY292ZXJ5
IG9mIG5ldyBBTkFHUlAgSURzIHdhcyBhbHdheXMgc3VwcG9zZWQgdG8gdGFrZSBwbGFjZSBhcyBh
IHBhcnQgb2YgbmFtZXNwYWNlIGRpc2NvdmVyeS4gIA0KDQovSm9obg0KDQpGaWd1cmUgNDk6IEFz
eW5jaHJvbm91cyBFdmVudCBJbmZvcm1hdGlvbiAtIE5vdGljZQ0KDQpOYW1lc3BhY2UgQXR0cmli
dXRlIENoYW5nZWQ6DQouLi4NCkEgY29udHJvbGxlciBzaGFsbCBub3Qgc2VuZCB0aGlzIGV2ZW50
IGlmOg0KICAgYSkgTmFtZXNwYWNlIFV0aWxpemF0aW9uIChyZWZlciB0byBGaWd1cmUgMTE0KSBo
YXMgY2hhbmdlZCwgYXMgdGhpcyBpcyBhIGZyZXF1ZW50IGV2ZW50IHRoYXQgZG9lcyBub3QgcmVx
dWlyZSBhY3Rpb24gYnkgdGhlIGhvc3Q7DQogICBiKSB0aGUgQU5BR1JQSUQgZmllbGQgKHJlZmVy
IHRvIEZpZ3VyZSAxMTQpIGhhcyBjaGFuZ2VkOyBvcg0KICAgYykgY2FwYWNpdHkgaW5mb3JtYXRp
b24gKGkuZS4sIHRoZSBOVVNFIGZpZWxkIGFuZCB0aGUgTlZNQ0FQIGZpZWxkKSByZXR1cm5lZCBp
biB0aGUgSWRlbnRpZnkgTmFtZXNwYWNlIERhdGEgU3RydWN0dXJlIChyZWZlciB0byBGaWd1cmUg
MTE0KSBjaGFuZ2VkIGFzIGEgcmVzdWx0IG9mIGFuIEFOQSBzdGF0ZSBjaGFuZ2UuDQouLi4NCg0K
QXN5bW1ldHJpYyBOYW1lc3BhY2UgQWNjZXNzIENoYW5nZTogDQoNClRoZSBBc3ltbWV0cmljIE5h
bWVzcGFjZSBBY2Nlc3MgaW5mb3JtYXRpb24gKHJlZmVyIHRvIHNlY3Rpb24gNS4xNC4xLjEyKSBy
ZWxhdGVkIHRvIGFuIEFOQSBHcm91cCB0aGF0IGNvbnRhaW5zIG5hbWVzcGFjZXMgYXR0YWNoZWQg
dG8gdGhpcyBjb250cm9sbGVyIGhhcyBjaGFuZ2VkIChlLmcuLCBhbiBBTkEgc3RhdGUgaGFzIGNo
YW5nZWQsIGFuIEFOQUdSUElEIGhhcyBjaGFuZ2VkKS4gVGhlIGN1cnJlbnQgQXN5bW1ldHJpYyBO
YW1lc3BhY2UgQWNjZXNzIGluZm9ybWF0aW9uIGZvciBhdHRhY2hlZCBuYW1lc3BhY2VzIGlzIGlu
ZGljYXRlZCBpbiB0aGUgQXN5bW1ldHJpYyBOYW1lc3BhY2UgQWNjZXNzIGxvZyBwYWdlIChyZWZl
ciB0byBzZWN0aW9uIDUuMTQuMS4xMikuIFRvIGNsZWFyIHRoaXMgZXZlbnQsIHRoZSBob3N0IGlz
c3VlcyBhIEdldCBMb2cgUGFnZSB3aXRoIFJldGFpbiBBc3luY2hyb25vdXMgRXZlbnQgY2xlYXJl
ZCB0byDigJgw4oCZIGZvciB0aGUgQXN5bW1ldHJpYyBOYW1lc3BhY2UgQWNjZXNzIExvZy4NCg0K
QSBjb250cm9sbGVyIHNoYWxsIG5vdCBzZW5kIHRoaXMgZXZlbnQgaWY6DQogICBhKSB0aGUgY2hh
bmdlIGlzIGR1ZSB0byB0aGUgY3JlYXRpb24gb2YgYSBuYW1lc3BhY2UgKHJlZmVyIHRvIHNlY3Rp
b24gNS4yMCk7IG9yDQogICBiKSB0aGUgY2hhbmdlIGlzIGR1ZSB0byB0aGUgZGVsZXRpb24gb2Yg
YSBuYW1lc3BhY2UgKHJlZmVyIHRvIHNlY3Rpb24gNS4yMCksIGFzIHRoZSBOYW1lc3BhY2UgQXR0
cmlidXRlIENoYW5nZWQgZXZlbnQgaXMgc2VudCBmb3IgdGhlc2UgY2hhbmdlcy4NCg0KICAgIF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQogICAgTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QNCiAgICBMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcNCiAg
ICBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUN
Cg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

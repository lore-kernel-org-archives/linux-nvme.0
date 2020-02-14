Return-Path: <SRS0=f2Gy=4C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46E2C2BA83
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 14:22:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E934206B6
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Feb 2020 14:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tDXzVaLk";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="aT6tV4+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E934206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8rvofZxfBj7LKBTAkyCgEmmnxek1W5RWDJ85spyB+GM=; b=tDXzVaLkLWvtzW
	h21AwgApZtJ4jDu+C3G5siEi/8ye4yXR/FNs2mBEI2ZdIbZiIg6yqqLsVU0SMzyEe5b7CiLqdVdxA
	ixEuOBnmhRFCCJHQS/hXNnYAOjweNgE07YX7WkuoSUl2d3HN4fX0TrQIzXu8wmrrauGa8UL2wYdrJ
	CfeGyt4VLTbLVLc10dsQTzU6tfBT/8MQZBkXLRWrCxmMpBDPFDyu2QCeBJIeM/1wtdtd3V0v0ggix
	TbmfAeM4cZOSrz0aNwFTdffjSBl93TGIRYrSeVC8cx+3XgN3+UJzZtU2vaixR9STPO8BT1t5rPMQJ
	mKox8PoGHHuPiS7t7xVA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j2brF-00074U-Rv; Fri, 14 Feb 2020 14:22:17 +0000
Received: from mail-co1nam11on2082.outbound.protection.outlook.com
 ([40.107.220.82] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j2brC-00073h-0f
 for linux-nvme@lists.infradead.org; Fri, 14 Feb 2020 14:22:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SYS7WZ7m4Nk/tkVYINFPuSdHJznXYKLibu1yH0RBP0eh1bC6UDpR7Ej4fcV6SwYBkrHz2H9bA1fFy7qZar+ypN8wU4hXIqnxI5Nbk70gdyVr0vC1hI1XXDcxmawGC1yQAaSXyWHO2OuU6b22Acum4s6sZh741KoPoln1suHdVi09LwKdccBRrA49EddZiIVcl7FP12JaARSu8m0H5xilteMpuYK2W3x9ylMP2VnRQiDJsiHnxPMksxFAGt0HRMqLue9lYvH1sRMPRxox5E7jWhBfiSk+bPGmTnIvgZEsD4axWNld6ZAqKFsqJst9RYa8/M9ITpqJs5E0i6J1wYobzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxEf0FjCUxiCMoc+1s72kuQ2gry0FUcadPLopzhckCw=;
 b=chnvtBnQu0Cj5mzOi7C0rnQcudxX4UhPp6o7Gy35+a+qUlZLG61V8FsoK0haze1D/HVhu1itG9bVVbEZVaxwjuOy0V2CQsVZosKO8qTnB7NoB+wfbwA1fxN45blXWxCKLNXeVdQpQWzSznGBag0wpm/ur/pfWdUTrUsC1btMMSK4Vpc6AdNgt2zvekd6TD3fxI5WxYuhpSwKWFOdxms3vRb2jy67TyoynvyFxIGLbbfkZkHxwGqA0DeMAw8x9eUI5LjLh0Ibhc+9b74X4bynaSUaghvTRCg6Sv7ZWa0olLk6auNL86gN1rTuu91fJH14X5QJpx4tO+NoqrXkRby8aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lxEf0FjCUxiCMoc+1s72kuQ2gry0FUcadPLopzhckCw=;
 b=aT6tV4+bTXjlBEwkPrp3OI2yxK+IXD7CPvaR52LK0dp9iBYJ0JWaof011OU6EFO03QQRsGfd43BguJwIqYHueX/TryJVmdClQPnaSOd3UrZXKew+X5iEiZsoNGEIpEkSacLmCeO+OthLDg9T3sD0Ryq1oli5NmZmp9gc5zfeJcQ=
Received: from BN7PR06MB3811.namprd06.prod.outlook.com (52.132.217.14) by
 BN7PR06MB4148.namprd06.prod.outlook.com (52.132.218.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Fri, 14 Feb 2020 14:22:12 +0000
Received: from BN7PR06MB3811.namprd06.prod.outlook.com
 ([fe80::fc4a:9b42:e2db:5ebb]) by BN7PR06MB3811.namprd06.prod.outlook.com
 ([fe80::fc4a:9b42:e2db:5ebb%3]) with mapi id 15.20.2729.025; Fri, 14 Feb 2020
 14:22:12 +0000
From: "Meneghini, John" <John.Meneghini@netapp.com>
To: Keith Busch <kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-multipath: do not reset controller on unknown status
Thread-Topic: [PATCH] nvme-multipath: do not reset controller on unknown status
Thread-Index: AQHV4ao0oz7vkJLsSEeGeoIH5HuhyqgX10eAgAAb9ACAAMCBAIAAp9EAgAERl4A=
Date: Fri, 14 Feb 2020 14:22:12 +0000
Message-ID: <0BF304E1-CD61-4D46-AF0C-51B3FB84CD32@netapp.com>
References: <20200212134140.105817-1-hare@suse.de>
 <20200212175317.GA5813@lst.de>
 <6d4d18e3-c3a1-7d93-5abf-1ae46e18ca8c@grimberg.me>
 <3345c55f-3a42-315b-1d62-20f9aaab296e@suse.de>
 <20200213170258.GC7634@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20200213170258.GC7634@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.21.0.200113
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=John.Meneghini@netapp.com; 
x-originating-ip: [216.240.30.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8eaf3548-46c0-4cf4-6a5d-08d7b159486c
x-ms-traffictypediagnostic: BN7PR06MB4148:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR06MB41480B2032DD96892CD49B72E4150@BN7PR06MB4148.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(189003)(199004)(8676002)(91956017)(64756008)(6512007)(33656002)(81156014)(81166006)(66556008)(66446008)(66946007)(8936002)(76116006)(66476007)(71200400001)(36756003)(5660300002)(26005)(6506007)(2906002)(4326008)(478600001)(186003)(54906003)(55236004)(316002)(6486002)(2616005)(107886003)(86362001)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN7PR06MB4148;
 H:BN7PR06MB3811.namprd06.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sUgSuSWGSjyvh1CQq9J8iVNgzAfmyco51aG8V7xIZsmw6b6/Ba2x70LwI3pZ3m2z4snvWz3Uj6y0r8d+XZIvYZwX9dTXruuZH0hhXw8fWrIpnNHqdwMDjRkUpfVn9TJxQm4Jau58w1Gyd8R0gCZgKt3oAh1027zKi4dMeJM2B0rhezgVVHmN8RDeC8gsuHVz/8EtcUkPiW/lWZm5GhSiGC0AAPcRoCDGyBZZPIv5BcqDOCS18u7TcgUbWG6bhHblXf+6uTOJtmFolvLU2knzyS02xj8E5FBCRBzs6lbTwzkdIysdyhU7ez4owdpb9c3KZOwXWrjX7XyljGLjR6laUhRkmhmnmA4J6Cg+T6VDoywHvtehZlDCASwYvfd6S/5xjniTOQH4/d50zMPEeEWeNHpCVT1cWGEJ2XJivMubvPlzy86mk4Z3gDIr2KNNWdX8
x-ms-exchange-antispam-messagedata: P64JqbRpOUgDIoPmEXmSta9gPG6g0khxHD976BgU3LsO1LbxQ0EFogK0DP34OEkHqqRY4k99rTq6Pv32xQ3LKp5U+FbUnQ0hqEuIemX466FqH5pxh6WWIDowhgkjCbHDUtm+iz2Ho35vkjH2Fifcnw==
Content-ID: <523C88CE359BF9469FE9D917CC5341B2@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eaf3548-46c0-4cf4-6a5d-08d7b159486c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 14:22:12.0385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XLVKWjI6Gem1gHzS+Qe29qjyehcFlA2xDAvkRE7i/ui1dDjox2nJ+PmW0TXDPEtFgDbZhyTiqWEsL5Xszi0Nmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR06MB4148
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200214_062214_098202_599086F5 
X-CRM114-Status: GOOD (  15.85  )
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
Cc: Keith Busch <keith.busch@intel.com>, "Meneghini,
 John" <John.Meneghini@netapp.com>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

VGhpcyBpcyBleGFjdGx5IHRoZSBwcm9ibGVtIEkgZGlzY3Vzc2VkIGluIHRoZSBsYXN0IHBhdGNo
IEkgc2VudCBvdXQgKG1heWJlIG15IG9ubHkgcGF0Y2gpIHRvIGZpeCBBQ1JFLg0KDQpLaWV0aCBh
bmQgSSBhbHNvICJkaXNjdXNzZWQiIHRoaXMgdG9waWMgYXQgQUxQU1MuDQoNCkF0IGlzc3VlIGhl
cmUgaXM6IGluIHRoZSBjdXJyZW50IGNvZGUsIGFzIHNvb24gYXMgKHJlcS0+Y21kX2ZsYWdzICYg
UkVRX05WTUVfTVBBVEgpIGlzIHNldCB0aGUgZXJyb3IgaGFuZGxpbmcgaW4NCm52bWVfY29tcGxl
dGVfcnEoKSBjb21wbGV0ZWx5IGNoYW5nZXMuIFRoaXMgbWVhbnMgdGhhdCBhIHNpbmdsZSBwb3J0
IHN1YnN5c3RlbSB3aWxsIHJlY2VpdmUgb25lIGtpbmQgb2YgZXJyb3INCmhhbmRsaW5nIHRyZWF0
bWVudCB3aGVuIGl0IHByZXNlbnRzIG9uZSBzdWJzeXN0ZW0gcG9ydCwgYW5kIHRoZW4gYSBjb21w
bGV0ZWx5IGRpZmZlcmVudCB0cmVhdG1lbnQgd2hlbg0KcHJlc2VudGluZyBtb3JlIHRoYW4gb25l
IHN1YnN5c3RlbSBwb3J0IChhc3N1bWluZyBuYW1lc3BhY2Ugc2hhcmluZykuDQoNCkkgdGhpbmsg
dGhlIGVycm9yIGhhbmRsaW5nIG9uIHRoZSBob3N0IHNob3VsZCBiZSBleGFjdGx5IGlkZW50aWNh
bCBiZXR3ZWVuIChSRVFfTlZNRV9NUEFUSCkgIGFuZCAoflJFUV9OVk1FX01QQVRIKQ0KLSBtb2R1
bG8gdGhlIHBhdGgtcmVsYXRlZCBOVk1lIGVycm9ycy4gDQoNCiAgICAgICAgLyoNCiAgICAgICAg
ICogUGF0aC1yZWxhdGVkIEVycm9yczogDQogICAgICAgICAqLw0KICAgICAgICBOVk1FX1NDX0FO
QV9QRVJTSVNURU5UX0xPU1MgICAgID0gMHgzMDEsDQogICAgICAgIE5WTUVfU0NfQU5BX0lOQUND
RVNTSUJMRSAgICAgICAgPSAweDMwMiwNCiAgICAgICAgTlZNRV9TQ19BTkFfVFJBTlNJVElPTiAg
ICAgICAgICA9IDB4MzAzLA0KICAgICAgICBOVk1FX1NDX0hPU1RfUEFUSF9FUlJPUiAgICAgICAg
ID0gMHgzNzAsDQogICAgICAgIE5WTUVfU0NfSE9TVF9BQk9SVEVEX0NNRCAgICAgICAgPSAweDM3
MSwNCg0KV2UgY2FuJ3QgaGF2ZSBvbmUgZXJyb3IgaGFuZGxpbmcgcG9saWN5IGZvciBuYW1lc3Bh
Y2Ugc2hhcmluZyBhbmQgYW5vdGhlciBmb3Igbm9uLXNoYXJlZCBuYW1lc3BhY2VzLg0KDQpSZXNl
dHRpbmcgdGhlIGNvbnRyb2xsZXIgbGlrZSB0aGlzIG9ubHkgbGVhZHMgdG8gYSBmYXRhbCBlbWJy
YWNlLg0KDQo+IEkgYWdyZWUsIHRoZSB0eXBlcyBvZiBpc3N1ZXMgYSByZXNldCBtYXkgcmVzb2x2
ZSBkb24ndCBzZWVtIGFwcGxpY2FibGUNCj4gaWYgd2UncmUgYWN0dWFsbHkgZ2V0dGluZyByZXNw
b25zZS4gSXMgdGhlcmUgZXZlbiBhIHNpbmdsZSBkZWZpbmVkIE5WTWUNCj4gc3RhdHVzIGNvZGUg
d2hlcmUgYSByZXNldCB3b3VsZCBiZSBhbiBhcHByb3ByaWF0ZSBlc2NhbGF0aW9uPw0KDQpJIHRo
aW5rLCBpbiBhbGwgY2FzZXMsIGVycm9ycyB0aGF0IGFyZSBub3QgaGFuZGxlZCBieSBudm1lX3Jl
dHJ5X3JlcShyZXEpIHJldHVybg0KQkxLX1NUU19JT0VSUi4gIFRoaXMgaXMgd2hhdCBoYXBwZW5z
IHdoZW4gUkVRX05WTUVfTVBBVEggaXMgZmFsc2UsIHNvIEkgdGhpbmsNCm11bHRpcGF0aCBjb250
cm9sbGVycyBzaG91bGQgZ2V0IHRoZSBzYW1lIHRyZWF0bWVudC4NCg0KL0pvaG4NCg0K77u/T24g
Mi8xMy8yMCwgMTI6MDMgUE0sICJLZWl0aCBCdXNjaCIgPGtidXNjaEBrZXJuZWwub3JnPiB3cm90
ZTogICAgDQogICAgDQogICAgT24gVGh1LCBGZWIgMTMsIDIwMjAgYXQgMDg6MDI6MjBBTSArMDEw
MCwgSGFubmVzIFJlaW5lY2tlIHdyb3RlOg0KICAgID4gQnV0IHRoaXMgaXMgcHJlY2lzZWx5IHRo
ZSBjYXNlIEknbSBhcmd1aW5nIGFnYWluc3QgaGVyZS4NCiAgICA+IE9uZSBvZiB0aGUgbGVzc29u
cyBsZWFybmVkIGZyb20gU0NTSSBpcyB0aGF0IHJlc2V0IG9ubHkgbWFrZXMgc2Vuc2UgaWYNCiAg
ICA+IHRoZSBzeXN0ZW0gbWlzYmVoYXZlcyBhbmQgcmVzZXR0aW5nIGl0IHdvdWxkIG1ha2UgdGhp
cyBlcnJvciBnbyBhd2F5Lg0KICAgID4NCiAgICA+IFJlY2VpdmluZyBhIHN0YXR1cyBjb2RlIHdo
aWNoIHdlIGRvbid0IGtub3cgYWJvdXQgZG9lcyBfbm90XyBmYWxsIGludG8NCiAgICA+IHRoaXMg
Y2F0ZWdvcnk7IHRoZSB2ZXJ5IGZhY3QgdGhhdCB3ZSBoYXZlIGEgc3RhdHVzIGNvZGUgcHJvdmVz
IHRoYXQgdGhlDQogICAgPiBzeXN0ZW0gZG9lcyBfbm90XyBtaXNiZWhhdmUuDQogICAgPg0KICAg
ID4gU28gd2hhdCBleGFjdGx5IHdpbGwgYmUgcmVzb2x2ZWQgYnkgcmVzZXR0aW5nPw0KICAgID4g
VGhlcmUgYWN0dWFsbHkgaXMgYSBmYWlyIGNoYW5jZSB0aGF0IHdlJ2xsIGJlIGdldHRpbmcgdGhl
IHZlcnkgc2FtZQ0KICAgID4gZXJyb3IgYWdhaW4uLi4NCiAgICANCiAgICBJIGFncmVlLCB0aGUg
dHlwZXMgb2YgaXNzdWVzIGEgcmVzZXQgbWF5IHJlc29sdmUgZG9uJ3Qgc2VlbSBhcHBsaWNhYmxl
DQogICAgaWYgd2UncmUgYWN0dWFsbHkgZ2V0dGluZyByZXNwb25zZS4gSXMgdGhlcmUgZXZlbiBh
IHNpbmdsZSBkZWZpbmVkIE5WTWUNCiAgICBzdGF0dXMgY29kZSB3aGVyZSBhIHJlc2V0IHdvdWxk
IGJlIGFuIGFwcHJvcHJpYXRlIGVzY2FsYXRpb24/DQogICAgDQogICAgDQoNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBs
aXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

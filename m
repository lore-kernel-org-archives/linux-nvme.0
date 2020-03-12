Return-Path: <SRS0=qcAl=45=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA85C0044D
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 00:21:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AB552074E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 00:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jnqJ8Ims";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="hgjL2moF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB552074E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oZfq8ljt4rIH/Qh/50NBN+H7HIcQIDduGMKHqafV9bI=; b=jnqJ8ImsEPNGz0
	mMvj/KN/gLvI8DRHnqYvtnM3j0jr3YaIVfg21DWiPib0J6aIIpuREsrAluxf85LtyzCh7/YDdZxJM
	ez7elEmy+sFqxJ0n6ZJpdIGfUXEaPGP/lxO5mu42BpdRMTAovncvLe4lunkDwfuI6to4CypLwqlgI
	xRRuCgq+phioywFDfI/yOLKULYtn6/N2p0ikXfgH7gKsVa6zXECbRaxs8MyVNCSQnt2s503eiU8AB
	9o+r/C1/ZI9iLo3CgYs5JG93+9ZcVC8xqYdDQOZ7C9lvouQNcoCOx7Ij3kNhxBrrRwbNt27wqGQSb
	ebfM6Bq/63YEXpdukK0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCBbR-0004GX-NW; Thu, 12 Mar 2020 00:21:33 +0000
Received: from mga04.intel.com ([192.55.52.120])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCBbP-0004G4-NC
 for linux-nvme@lists.infradead.org; Thu, 12 Mar 2020 00:21:33 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Mar 2020 17:21:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,542,1574150400"; d="scan'208";a="443746347"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
 by fmsmga006.fm.intel.com with ESMTP; 11 Mar 2020 17:21:27 -0700
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Mar 2020 17:21:26 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX161.amr.corp.intel.com (10.22.240.84) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Mar 2020 17:21:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 11 Mar 2020 17:21:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MLhS64EmZwPuATY/DgUyHOldLMEoonnntORBPnGh2pSNs5mDDICYH/E3PF2vAKjiV6bjA86mCiLtVr/pxgWi129VjaFjsl8MHjLtVJDSSfxDmQ25uQGgh1wN2BRV1ypHjMJv+SnYQvuqcJJlDwsc1cxb+GMlWuCN57DZSDa39jxljge12U3D+Pc5H+eJewFUyqTKomgJHFFQ1DFwnre8XDPF0iYv+d+fD0ZE5dFHF/cO/j9n/MjU0tJkzIiztqxfUi5Hu1V+btcjriyRJe3LQ+dwrMyR0Cxjc+6HmAfvqSicvJOCIdQ0nd/ixuCff1uThto6t1P+zoO9KyGtqS1eBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfu/6fw5lgpmYwG8GKCObHeyE71KhedRrj6/6y3WrUA=;
 b=YAA/gTL7JhjQd+0TjNNf7A/7TLc6/NgX7udviVWqywyYUsoskTH2fL/CpaXvIaupPET63O8lBDYXBSXScK+sQNseqBw5OMO4AcAjGOz3xT230CNEDVrwJASeAGQHYAhAr1DdT466Jq/nMgKp8ACsEJWKca8mD53Blhf3L3SAJAAlutA8ImbBR+nSf8qPowDSb2+F1etFGLRiNc6RboijlYZb5MZlBbXpiq1mFZ6u/iMu10+06FDdweIs8gohIuHmRoY1x5NQDq84/ROodziSLOultkxtPsXAlxgia76b3Ll5Drl5M/sqIYVvlLrlrZrSothrLLr2gsG5bw+cSOcq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yfu/6fw5lgpmYwG8GKCObHeyE71KhedRrj6/6y3WrUA=;
 b=hgjL2moFtVJNmD54Nebf0k/wDPTd333K15FSIGIQA1gv5xCfX8eK5QQp8SuCgLAthOF8/Wx2PfZ3AM+Vf4VcjfoR/iTgo6hy1YdvJ8ovkNxQ4a38LlzBoSGYYs1FopUJPjeyjjRovOMrteii2dAIcwv/YYoeevf0HNS9kRbTWP0=
Received: from CY4PR11MB1351.namprd11.prod.outlook.com (2603:10b6:903:26::9)
 by CY4PR11MB1941.namprd11.prod.outlook.com (2603:10b6:903:120::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 00:21:24 +0000
Received: from CY4PR11MB1351.namprd11.prod.outlook.com
 ([fe80::c109:7bc1:25ae:53cc]) by CY4PR11MB1351.namprd11.prod.outlook.com
 ([fe80::c109:7bc1:25ae:53cc%12]) with mapi id 15.20.2793.018; Thu, 12 Mar
 2020 00:21:24 +0000
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sagi Grimberg <sagi@grimberg.me>, "linux-nvme@lists.infradead.org"
 <linux-nvme@lists.infradead.org>
Subject: RE: Sighting: Use of 'disable_sqflow' option shows drastic reduced
 I/O rate for small Queue Depths
Thread-Topic: Sighting: Use of 'disable_sqflow' option shows drastic reduced
 I/O rate for small Queue Depths
Thread-Index: AQHV9kmB1xPGOrsi90S3+8np2DlTQ6hAxXtAgAAYAICAAyZ2gIAAE50g
Date: Thu, 12 Mar 2020 00:21:23 +0000
Message-ID: <CY4PR11MB13510BE7F01EC5B803E6DA56E5FD0@CY4PR11MB1351.namprd11.prod.outlook.com>
References: <CY4PR11MB1351F4B992E207DCFD610FE6E5FE0@CY4PR11MB1351.namprd11.prod.outlook.com>
 <79eb6f31-1c65-7920-5e66-8ee9a6e81aae@grimberg.me>
 <CY4PR11MB1351F639D6B6582D5EEBA74DE5FE0@CY4PR11MB1351.namprd11.prod.outlook.com>
 <7ad247fc-4c42-2712-c324-d257505eb0d0@grimberg.me>
 <5732ea78-3b36-890d-70b8-e91edbebae47@grimberg.me>
In-Reply-To: <5732ea78-3b36-890d-70b8-e91edbebae47@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mark.wunderlich@intel.com; 
x-originating-ip: [192.55.52.199]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94b40e9f-642d-415d-bc92-08d7c61b4c50
x-ms-traffictypediagnostic: CY4PR11MB1941:
x-microsoft-antispam-prvs: <CY4PR11MB1941BDEE59D9122B13FBFC85E5FD0@CY4PR11MB1941.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(136003)(199004)(66476007)(76116006)(66946007)(52536014)(5660300002)(6506007)(26005)(2906002)(64756008)(8936002)(66556008)(8676002)(81166006)(81156014)(110136005)(7696005)(71200400001)(66446008)(316002)(478600001)(4326008)(33656002)(55016002)(9686003)(186003)(86362001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR11MB1941;
 H:CY4PR11MB1351.namprd11.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w1C6uBmCcg3+5aoEB5ehY2f4ocWIX7czHkdf/LxuzkqhhV1pBujRp2aLkjnkq01nHlqdssu8xrMbtXzb/QSk5bBMT1KhuTd8s3u9XdiUXTriOt2RzG8H8QpZ0zoBwAmA23KlGLhTqu+h74aWihvv6VsZqRfgZJHZlRpC0LNf8hdziMVxPuVQCTNHGN/qirv0jrLo0Uz67A1LBNVVVrQ3GaW3CeTI9ezU86FTSOlYtK19qGv9BoGq9Mbgq022DkRYS7KphqOtOsiL7rgIhjBxfY1DRUirScVZt8nPLHzSW2IbpKv2XSpHJcGlQGv3q/DLPerfmWCz7NQ6gk2CHZBSNygn5Xhhv82oG5iP4WPwWegb6kYyjB+8q2dCxqJXytA/6rhcj+0XH49avAGRIEmF1tgB5Dg+cu+a0eJsJ0J/DUBIOGnaubYFnql6k4u0KvCi
x-ms-exchange-antispam-messagedata: Ofxcc7c8php0bbY1C5GEvFdRn3ZvhIikBvI9Y+QzuKuOso2nn3YF96XZwCN7C2V/W4tAfOrBgjzB80UQTJxKEtAox1EhbD3AISM5YHuhyN/eqwAI/u60ExFvcDHkXQvnJM7bQWmmVOELLDdWBp8Taw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b40e9f-642d-415d-bc92-08d7c61b4c50
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 00:21:23.8172 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQrwKiyN0eyhIRNJCATRtv3jv2P/4CDPGJcXhLrYA49G/kT8GpohIiCCX03DTnE/TXGyBllBQZK+goAeqKU9nJ5jBeEcAw6nPGAdgjkI4S0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1941
X-OriginatorOrg: intel.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200311_172131_831553_D166E91D 
X-CRM114-Status: GOOD (  11.98  )
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
Cc: Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Pj4+IEBAIC01MzMsOSArNTM0LDE2IEBAIHN0YXRpYyBpbnQgbnZtZXRfdHJ5X3NlbmRfZGF0YShz
dHJ1Y3QgDQo+Pj4gbnZtZXRfdGNwX2NtZCAqY21kKQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqAgd2hp
bGUgKGNtZC0+Y3VyX3NnKSB7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c3RydWN0IHBhZ2UgKnBhZ2UgPSBzZ19wYWdlKGNtZC0+Y3VyX3NnKTsNCj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MzIgbGVmdCA9IGNtZC0+Y3VyX3NnLT5sZW5ndGggLSBj
bWQtPm9mZnNldDsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQgZmxhZ3Mg
PSBNU0dfRE9OVFdBSVQ7DQo+Pj4gKw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmIChjbWQtPndieXRlc19kb25lICsgbGVmdCA8IGNtZC0+cmVxLnRyYW5zZmVyX2xlbiANCj4+
PiArfHwNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KCFsYXN0X2luX2JhdGNoICYmIA0KPj4+ICtjbWQtPnF1ZXVlLT5zZW5kX2xpc3RfbGVuKSkNCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmxhZ3MgfD0g
TVNHX01PUkU7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZWxzZSBpZiAocXVl
dWUtPm52bWVfc3Euc3FoZF9kaXNhYmxlZCkNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgZmxhZ3MgfD0gTVNHX0VPUjsNCj4+IA0KPj4gSXMgdGhlIE1T
R19FT1IgbmVjZXNzYXJ5IGhlcmU/IENhbiB5b3UgY2hlY2sgd2l0aG91dCBpdD8NCg0KPk1hcms/
IERpZCB5b3UgZ2V0IGEgY2hhbmNlIHRvIGNoZWNrIHRoYXQ/DQoNClllcywgSSBtb2RpZmllZCB0
aGUgJ2lmJyBjb25kaXRpb25zIGEgYml0IGFuZCB0ZXN0aW5nIGRvZXMgbm90IHNob3cgbmVlZCBm
b3Igc2V0dGluZyBNU0dfRU9SLg0KDQpOZXcgaWYgY29uZGl0aW9uIHVzZWQ6DQorICAgICAgICAg
ICAgICAgaWYgKGNtZC0+d2J5dGVzX2RvbmUgKyBsZWZ0IDwgY21kLT5yZXEudHJhbnNmZXJfbGVu
IHx8ICAgLyogbW9yZSBkYXRhIGluIHRoaXMgeGZlciB0byBzZW5kICovDQorICAgICAgICAgICAg
ICAgICAgICAgICAhcXVldWUtPm52bWVfc3Euc3FoZF9kaXNhYmxlZCB8fCAvKiB0aGVuIGEgcmVz
cG9uc2UgZnJhbWUgaXMgY29taW5nICovDQorICAgICAgICAgICAgICAgICAgICAgICAoIWxhc3Rf
aW5fYmF0Y2ggJiYgY21kLT5xdWV1ZS0+c2VuZF9saXN0X2xlbikpICAvKiBtb3JlIHJlcXVlc3Rz
IHRvIHByb2Nlc3MgaW4gdGhpcyBiYXRjaCB3aW5kb3cgKi8NCisgICAgICAgICAgICAgICAgICAg
ICAgIGZsYWdzIHw9IE1TR19NT1JFOw0KDQpGb3IgcXVldWUgZGVwdGggPSAxIGF0IHRpbWVzIEkg
d2lsbCBzdGlsbCBzZWUgSU9QUyByYXRlIGRpcCBiZWxvdyB0aGUgaGlnaCBidXQgcmVjb3ZlciBx
dWlja2x5LiAgQW5kIEkgZG8gbm90IHNlZSB0aGlzIG9uIGV2ZXJ5IHJ1bi4gIEFuZCBpdCBzZWVt
cyB0byBiZSBtb3JlIGZyZXF1ZW50IHdoZW4gdGVzdGluZyBhIHJhbWRpc2ssIG5vdCBhIHJlYWwg
bnZtZSBkZXZpY2UuICBCdXQgZm9yIHRoZSBtb3N0IHBhcnQgdGhpcyBncmVhdGx5IGltcHJvdmVz
IHRoZSBvcmlnaW5hbCBpc3N1ZSBJIHJlcG9ydGVkLg0KDQpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1u
dm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC1udm1lCg==

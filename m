Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BBBC4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 17:08:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4775B2067B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 17:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tqsOl770"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4775B2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CwSFejWEwIIxX6urrC0kR4Cbc5Rp6Rd6DerMJmo6z94=; b=tqsOl770a4FNIX
	CAD/mNjQ9rc8WuigvlKPppp7Chfvik2BjGOUyXlyKEFxNSj32c1yudJNfe85g7pF/w8B6GqKdyhUl
	BYgXfvEg1rzC/MYicH326Vdk1PEEyae04Yfvqu03AmeJIoe1b5uSXzujer/J/55FOwWwdwVevHLLI
	sRGk6s1yGd7VfTs4g9nQtBJ4J+Df2Dbk9sShxdYxZDJAWPBr/NXrHDobU4okSpBnVO11F4vO4O8UK
	T9ymLlMY1on8eSfv02tqsAIFUZMDd/VS4ZYkbo3VwiWaSRzR8LJxcUe7xqiHO/e8mzLAk758Wco7O
	ySAjf8ztm5IExiFH8qgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIbvV-0004AU-JJ; Thu, 10 Oct 2019 17:08:33 +0000
Received: from mga07.intel.com ([134.134.136.100])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIbvS-00049p-Hs
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 17:08:32 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 10 Oct 2019 10:08:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,280,1566889200"; d="scan'208";a="200530868"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
 by FMSMGA003.fm.intel.com with ESMTP; 10 Oct 2019 10:08:28 -0700
Received: from orsmsx161.amr.corp.intel.com (10.22.240.84) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 10 Oct 2019 10:08:27 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.167]) by
 ORSMSX161.amr.corp.intel.com ([169.254.4.111]) with mapi id 14.03.0439.000;
 Thu, 10 Oct 2019 10:08:28 -0700
From: "Wunderlich, Mark" <mark.wunderlich@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Christoph Hellwig
 <hch@lst.de>
Subject: RE: [PATCH v2] nvme-tcp: Initialize sk->sk_ll_usec only with
 NET_RX_BUSY_POLL
Thread-Topic: [PATCH v2] nvme-tcp: Initialize sk->sk_ll_usec only with
 NET_RX_BUSY_POLL
Thread-Index: AQHVf4BIMoH146YQqk694EsSuYD23adUGVNQ
Date: Thu, 10 Oct 2019 17:08:27 +0000
Message-ID: <B33B37937B7F3D4CB878107E305D4916D48CFD@ORSMSX104.amr.corp.intel.com>
References: <20191010150622.reqmasxgavug4amm@linutronix.de>
 <20191010150719.GA617@lst.de>
 <20191010151023.gru6fhrhy7gxxwye@linutronix.de>
 <20191010151444.GA638@lst.de>
 <20191010152924.jlr53aunkj7de5js@linutronix.de>
 <20191010152958.GA1057@lst.de>
 <20191010153411.6uetttizkto6rv65@linutronix.de>
In-Reply-To: <20191010153411.6uetttizkto6rv65@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiY2Q2ZWJkNmYtYWFiNi00NjdmLWJjODgtZWQ4YTYyMTc3MTg3IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZWRLQ3ZBb0xEVU1TbG00UDhON2ZxZHRTemdEN0h2V1JnZ0dQRjNiQVRCOU1OWHUwWnYyeDh3VWJjYUVhYWxPSSJ9
x-originating-ip: [10.22.254.138]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_100830_634019_810A39C5 
X-CRM114-Status: GOOD (  14.19  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 "tglx@linutronix.de" <tglx@linutronix.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

U2hvdWxkIHRoZXJlIGFsc28gYmUgYSBjaGVjayBoZXJlIHRvIGhvbm9yIGFueSBub24temVybyB2
YWx1ZSBvZiBza19sbF91c2VjICggdmlhIHN5c2N0bF9uZXRfYnVzeV9yZWFkICksIGJlZm9yZSBz
ZXR0aW5nIGhlcmUgdG8gaGFyZCBjb2RlZCBkZWZhdWx0IG9mIDE/DQpPciBtYXliZSBiZXN0IHRv
IGhhdmUgdGhpcyBhcyBhIHNlcGFyYXRlIHBhdGNoIHRvIGNvbnNpZGVyPw0KDQorI2lmZGVmIENP
TkZJR19ORVRfUlhfQlVTWV9QT0xMDQoJSWYgKCFxdWV1ZS0+c29jay0+c2stPnNrX2xsX3VzZWMp
DQogCQlxdWV1ZS0+c29jay0+c2stPnNrX2xsX3VzZWMgPSAxOw0KKyNlbmRpZg0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGludXgtbnZtZSA8bGludXgtbnZtZS1ib3VuY2Vz
QGxpc3RzLmluZnJhZGVhZC5vcmc+IE9uIEJlaGFsZiBPZiBTZWJhc3RpYW4gQW5kcnplaiBTaWV3
aW9yDQpTZW50OiBUaHVyc2RheSwgT2N0b2JlciAxMCwgMjAxOSA4OjM0IEFNDQpUbzogQ2hyaXN0
b3BoIEhlbGx3aWcgPGhjaEBsc3QuZGU+DQpDYzogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwu
b3JnPjsgSmVucyBBeGJvZSA8YXhib2VAZmIuY29tPjsgdGdseEBsaW51dHJvbml4LmRlOyBTYWdp
IEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPjsgbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnDQpTdWJqZWN0OiBbUEFUQ0ggdjJdIG52bWUtdGNwOiBJbml0aWFsaXplIHNrLT5za19sbF91
c2VjIG9ubHkgd2l0aCBORVRfUlhfQlVTWV9QT0xMDQoNClRoZSBhY2Nlc3MgdG8gc2stPnNrX2xs
X3VzZWMgc2hvdWxkIGJlIGhpZGRlbiBiZWhpbmQgQ09ORklHX05FVF9SWF9CVVNZX1BPTEwgbGlr
ZSB0aGUgZGVmaW5pdGlvbiBvZiBza19sbF91c2VjLg0KDQpQdXQgYWNjZXNzIHRvIC0+c2tfbGxf
dXNlYyBiZWhpbmQgQ09ORklHX05FVF9SWF9CVVNZX1BPTEwuDQoNCkZpeGVzOiAxYTk0NjBjZWY1
NzExICgibnZtZS10Y3A6IHN1cHBvcnQgc2ltcGxlIHBvbGxpbmciKQ0KU2lnbmVkLW9mZi1ieTog
U2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvciA8YmlnZWFzeUBsaW51dHJvbml4LmRlPg0KLS0tDQp2
MeKApnYyOiBIaWRlIGl0IGJlaGluZCBDT05GSUdfTkVUX1JYX0JVU1lfUE9MTCBpbnN0ZWFkIHJl
bW92aW5nIGl0Lg0KDQogZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgfCAyICsrDQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3Qv
dGNwLmMgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBpbmRleCAzODVhNTIxMmMxMGYxLi43MjA1
OTU2MWI3ZjJhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMNCisrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L3RjcC5jDQpAQCAtMTM4Niw3ICsxMzg2LDkgQEAgc3RhdGljIGludCBu
dm1lX3RjcF9hbGxvY19xdWV1ZShzdHJ1Y3QgbnZtZV9jdHJsICpuY3RybCwNCiAJcXVldWUtPnNv
Y2stPnNrLT5za19kYXRhX3JlYWR5ID0gbnZtZV90Y3BfZGF0YV9yZWFkeTsNCiAJcXVldWUtPnNv
Y2stPnNrLT5za19zdGF0ZV9jaGFuZ2UgPSBudm1lX3RjcF9zdGF0ZV9jaGFuZ2U7DQogCXF1ZXVl
LT5zb2NrLT5zay0+c2tfd3JpdGVfc3BhY2UgPSBudm1lX3RjcF93cml0ZV9zcGFjZTsNCisjaWZk
ZWYgQ09ORklHX05FVF9SWF9CVVNZX1BPTEwNCiAJcXVldWUtPnNvY2stPnNrLT5za19sbF91c2Vj
ID0gMTsNCisjZW5kaWYNCiAJd3JpdGVfdW5sb2NrX2JoKCZxdWV1ZS0+c29jay0+c2stPnNrX2Nh
bGxiYWNrX2xvY2spOw0KIA0KIAlyZXR1cm4gMDsNCi0tDQoyLjIzLjANCg0KDQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QNCkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZw0KaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lDQpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

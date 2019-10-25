Return-Path: <SRS0=pUqL=YS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E1FCA9EA0
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 21:56:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7DA21D7F
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 21:56:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g21HZHJr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7DA21D7F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A7pvLI5aXDYdBvt5MFwMYtzsMNNPSQerWcRv28EejBI=; b=g21HZHJruTUGdc
	40RM6xtrhAdSg/R+OKqmhdYEURx+0S6gdMzmU8lKqlS6XWt/xWYFRBoCcMYsIA1UaWU7zldotDIMt
	1uYVLBCzbogfEMH8UmLkOhiDa/i0TZzDpiMg3g4vVvodg7CBHqEUgz3OVbKhPeXln1Bn7j7YVvY/e
	i/1GXaJMoEMpQ2Jbb9IfP5HIheoPSP+bE77QL4VzbzOOW1rHVumF9Gsvzp9UkpLiLABUIOxerm9+9
	Q/vHxaqhbI9/p4hdgZeNQ7yQhdI4S76Uwqa/QU3RoSCy3qzmcuii1I4LdIl6mCWH3dK/GRpzdNIx8
	6tXOGivRIo61xYnV7eIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iO7Yg-00047m-LG; Fri, 25 Oct 2019 21:55:46 +0000
Received: from ale.deltatee.com ([207.54.116.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iO7YR-0003u7-Ru
 for linux-nvme@lists.infradead.org; Fri, 25 Oct 2019 21:55:33 +0000
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230]
 helo=[192.168.11.155])
 by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <logang@deltatee.com>)
 id 1iO7YI-0008W9-RF; Fri, 25 Oct 2019 15:55:23 -0600
To: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20191025202535.12036-1-logang@deltatee.com>
 <20191025202535.12036-4-logang@deltatee.com>
 <28b40ab8-c695-784e-3f52-03a18b891d25@grimberg.me>
 <11006dd2-718f-b569-4ef3-c01232354d5f@deltatee.com>
 <952c93fa-ef69-e113-a285-b1e9a0ddcafc@grimberg.me>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <55aaecf5-e094-1ef6-e4ac-3460d5eaf02c@deltatee.com>
Date: Fri, 25 Oct 2019 15:55:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <952c93fa-ef69-e113-a285-b1e9a0ddcafc@grimberg.me>
Content-Language: en-US
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com, hch@lst.de,
 maxg@mellanox.com, kbusch@kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC PATCH 3/3] nvme: Introduce nvme_execute_passthru_rq_nowait()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191025_145531_960426_39BFAF04 
X-CRM114-Status: GOOD (  15.26  )
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
Cc: Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDE5LTEwLTI1IDM6NDAgcC5tLiwgU2FnaSBHcmltYmVyZyB3cm90ZToKPj4gSG1tLCB0
aGF0J3MgZ29pbmcgdG8gYmUgYSBiaXQgdHJpY2t5LiBTZWVpbmcgdGhlIHdvcmtfc3RydWN0IGJl
bG9uZ3MKPj4gcG90ZW50aWFsbHkgdG8gYSBudW1iZXIgb2YgZGlmZmVyZW50IHJlcXVlc3RzLCB3
ZSBjYW4ndCBqdXN0IGZsdXNoIHRoZQo+PiBpbmRpdmlkdWFsIHdvcmsgaXRlbXMuIEkgdGhpbmsg
d2UnZCBoYXZlIHRvIGNyZWF0ZSBhIHdvcmstcXVldWUgcGVyIGN0cmwKPj4gYW5kIGZsdXNoIHRo
YXQuIEFueSBvYmplY3Rpb25zIHRvIHRoYXQ/Cj4gCj4gSSdkIG9iamVjdCB0byB0aGF0IG92ZXJo
ZWFkLi4uCj4gCj4gSG93IGFib3V0IG1hcmtpbmcgdGhlIHJlcXVlc3QgaWYgdGhlIHdvcmtxdWV1
ZSBwYXRoIGlzIHRha2VuIGFuZAo+IGluIG52bWVfc3RvcF9jdHJsIHlvdSBhZGQgYSBibGtfbXFf
dGFnc2V0X2J1c3lfaXRlciBhbmQgY2FuY2VsCj4gaXQgaW4gdGhlIGNhbGxiYWNrPwoKT2gsIGNv
b2wuIFRoYXQgbG9va3MgZ3JlYXQsIEknbGwgZG8gdGhhdC4gVGhhbmtzIQoKTG9nYW4KCj4gU29t
ZXRoaW5nIGxpa2U6Cj4gLS0gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUu
YyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+IGluZGV4IGZhN2JhMDlkY2E3Ny4uMTNkYmJl
YzU0OTdkIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+ICsrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+IEBAIC0zOTU1LDEyICszOTU1LDMzIEBAIHZvaWQgbnZt
ZV9jb21wbGV0ZV9hc3luY19ldmVudChzdHJ1Y3QgbnZtZV9jdHJsCj4gKmN0cmwsIF9fbGUxNiBz
dGF0dXMsCj4gwqB9Cj4gwqBFWFBPUlRfU1lNQk9MX0dQTChudm1lX2NvbXBsZXRlX2FzeW5jX2V2
ZW50KTsKPiAKPiArc3RhdGljIGJvb2wgbnZtZV9mbHVzaF9hc3luY19wYXNzdGhydV9yZXF1ZXN0
KHN0cnVjdCByZXF1ZXN0ICpycSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2b2lk
ICpkYXRhLCBib29sIHJlc2VydmVkKQo+ICt7Cj4gK8KgwqDCoMKgwqDCoCBpZiAoIShudm1lX3Jl
cShycSktPmZsYWdzICYgTlZNRV9SRVFfQVNZTkNfUEFTU1RIUlUpKQo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOwo+ICsKPiArwqDCoMKgwqDCoMKgIGRldl9kYmdf
cmF0ZWxpbWl0ZWQoKChzdHJ1Y3QgbnZtZV9jdHJsICopIGRhdGEpLT5kZXZpY2UsCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAi
Q2FuY2VsbGluZyBwYXNzdGhydSBJL08gJWQiLCByZXEtPnRhZyk7Cj4gK8KgwqDCoMKgwqDCoCBm
bHVzaF93b3JrKCZudm1lX3JlcShycSktPndvcmspOwo+ICvCoMKgwqDCoMKgwqAgcmV0dXJuIHRy
dWU7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIG52bWVfZmx1c2hfYXN5bmNfcGFzc3RocnVfcmVx
dWVzdHMoc3RydWN0IG52bWVfY3RybCAqY3RybCkKPiArewo+ICvCoMKgwqDCoMKgwqAgYmxrX21x
X3RhZ3NldF9idXN5X2l0ZXIoY3RybC0+dGFnc2V0LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG52bWVfZmx1c2hfYXN5bmNfcGFzc3RocnVfcmVxdWVzdCwgY3RybCk7Cj4gK8KgwqDC
oMKgwqDCoCBibGtfbXFfdGFnc2V0X2J1c3lfaXRlcihjdHJsLT5hZG1pbl90YWdzZXQsCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9mbHVzaF9hc3luY19wYXNzdGhydV9yZXF1
ZXN0LCBjdHJsKTsKPiArfQo+ICsKPiDCoHZvaWQgbnZtZV9zdG9wX2N0cmwoc3RydWN0IG52bWVf
Y3RybCAqY3RybCkKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoCBudm1lX21wYXRoX3N0b3AoY3RybCk7
Cj4gwqDCoMKgwqDCoMKgwqAgbnZtZV9zdG9wX2tlZXBfYWxpdmUoY3RybCk7Cj4gwqDCoMKgwqDC
oMKgwqAgZmx1c2hfd29yaygmY3RybC0+YXN5bmNfZXZlbnRfd29yayk7Cj4gwqDCoMKgwqDCoMKg
wqAgY2FuY2VsX3dvcmtfc3luYygmY3RybC0+ZndfYWN0X3dvcmspOwo+ICvCoMKgwqDCoMKgwqAg
bnZtZV9mbHVzaF9hc3luY19wYXNzdGhydV9yZXF1ZXN0cyhjdHJsKTsKPiDCoH0KPiDCoEVYUE9S
VF9TWU1CT0xfR1BMKG52bWVfc3RvcF9jdHJsKTsKPiAtLSAKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

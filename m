Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE27C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 12:58:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E37B64D9D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 12:58:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E37B64D9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FRpS1h3uCFQmtuBcN2SxEb1iYdLB+TVgJSbqjAiv+Mk=; b=y8c1sIZPQF6GjqEVQHrLmH+ie
	y+5JnF58Pb5S64kge9dEsz5sukLy+41tFtT8QXxSmQrk7e+K3ZS/wDmK9sk/xy+mCBXDjXKVfXeJU
	hzr+s9A4PW8TiQH+HbHzju+jKatHDRLhT2qIdPN2/oaWF8oQDwmoHAQTSp20RlGDjl20KzreJTlVB
	ggsiyAc+J5bXmKbDG6aELEz1TN7jPAUomMEYpyTGwM4o2V21UnD20L9QLvCRwBmvGZDbpn3u4Qyai
	cYPM/aP/MV7KItlWpCKcerFrI0QPPZ8LOxfGRsGPyfqABc8NUd2+p4GnITTP+MPLijw5n45v6Oo+c
	0h4MhqXdA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9Sas-0003s5-L5; Tue, 09 Feb 2021 12:58:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9Sap-0003ra-43
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 12:58:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612875488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R2dpli5+gLSnBPf6sEUku4wzcfwLa1zWNbAJEkLA+hY=;
 b=BI8W+PLOF/2VfOAqsOfb+FCsLNX9nFc1dTkmjviqCmesNM62xss911r2731DzxE69udaJ5
 Ls0KeCGdn9lU3+PkZPZXkI2OuwyMZcvpd20KH/qALt0OL9eurtA8FpJEsld7BrysDguvNz
 eo56Vmo0ecd05CO3UVVaBafTiW2vm8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-5VYmTVcON_WAMHtZiGoxlg-1; Tue, 09 Feb 2021 07:58:03 -0500
X-MC-Unique: 5VYmTVcON_WAMHtZiGoxlg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A41BD106BC6D;
 Tue,  9 Feb 2021 12:58:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-90.pek2.redhat.com [10.72.12.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 427DC5D6D7;
 Tue,  9 Feb 2021 12:57:58 +0000 (UTC)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block <linux-block@vger.kernel.org>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <a88fd4c8-8d5c-6934-39bc-5c864e3ed84f@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <aec13f12-640c-77d5-bbdd-b4a3e18f1bf2@redhat.com>
Date: Tue, 9 Feb 2021 20:57:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a88fd4c8-8d5c-6934-39bc-5c864e3ed84f@grimberg.me>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_075811_644677_691EAAF7 
X-CRM114-Status: GOOD (  18.93  )
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
Cc: axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
 Chaitanya.Kulkarni@wdc.com, CKI Project <cki-project@redhat.com>,
 Ming Lei <ming.lei@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyLzkvMjEgNjoyNSBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPgo+PiBIaSBTYWdpCj4+
Cj4+IE9uIDIvOC8yMSA1OjQ2IFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+Pj4KPj4+PiBIZWxs
bwo+Pj4+Cj4+Pj4gV2UgZm91bmQgdGhpcyBrZXJuZWwgTlVMTCBwb2ludGVyIGlzc3VlIHdpdGgg
bGF0ZXN0IAo+Pj4+IGxpbnV4LWJsb2NrL2Zvci1uZXh0IGFuZCBpdCdzIDEwMCUgcmVwcm9kdWNl
ZCwgbGV0IG1lIGtub3cgaWYgeW91IAo+Pj4+IG5lZWQgbW9yZSBpbmZvL3Rlc3RpbmcsIHRoYW5r
cwo+Pj4+Cj4+Pj4gS2VybmVsIHJlcG86IAo+Pj4+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L2F4Ym9lL2xpbnV4LWJsb2NrLmdpdAo+Pj4+IENvbW1pdDog
MTFmOGI2ZmQwZGI5IC0gTWVyZ2UgYnJhbmNoICdmb3ItNS4xMi9pb191cmluZycgaW50byBmb3It
bmV4dAo+Pj4+Cj4+Pj4gUmVwcm9kdWNlcjogYmxrdGVzdHMgbnZtZS10Y3AvMDEyCj4+Pgo+Pj4g
VGhhbmtzIGZvciByZXBvcnRpbmcgTWluZywgSSd2ZSB0cmllZCB0byByZXByb2R1Y2UgdGhpcyBv
biBteSBWTQo+Pj4gYnV0IGRpZCBub3Qgc3VjY2VlZC4gR2l2ZW4gdGhhdCB5b3UgaGF2ZSBpdCAx
MDAlIHJlcHJvZHVjaWJsZSwKPj4+IGNhbiB5b3UgdHJ5IHRvIHJldmVydCBjb21taXQ6Cj4+Pgo+
Pj4gMGRjOWVkYWY4MGVhIG52bWUtdGNwOiBwYXNzIG11bHRpcGFnZSBidmVjIHRvIHJlcXVlc3Qg
aW92X2l0ZXIKPj4+Cj4+Cj4+IFJldmVydCB0aGlzIGNvbW1pdCBmaXhlZCB0aGUgaXNzdWUgYW5k
IEkndmUgYXR0YWNoZWQgdGhlIGNvbmZpZy4gOikKPgo+IEhleSBNaW5nLAo+Cj4gSW5zdGVhZCBv
ZiByZXZlcnQsIGRvZXMgdGhpcyBwYXRjaCBtYWtlcyB0aGUgaXNzdWUgZ28gYXdheT8KSGkgU2Fn
aQoKQmVsb3cgcGF0Y2ggZml4ZWQgdGhlIGlzc3VlLCBsZXQgbWUga25vdyBpZiB5b3UgbmVlZCBt
b3JlIHRlc3RpbmcuIDopCgpUaGFua3MKWWkKCj4gLS0gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bnZtZS9ob3N0L3RjcC5jIGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMKPiBpbmRleCA2MTliMGQ4
ZjZlMzguLjY5ZjU5ZDJjNTc5OSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC90Y3Au
Ywo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCj4gQEAgLTIyNzEsNyArMjI3MSw3IEBA
IHN0YXRpYyBibGtfc3RhdHVzX3QgCj4gbnZtZV90Y3Bfc2V0dXBfY21kX3BkdShzdHJ1Y3QgbnZt
ZV9ucyAqbnMsCj4gwqDCoMKgwqDCoMKgwqAgcmVxLT5kYXRhX2xlbiA9IGJsa19ycV9ucl9waHlz
X3NlZ21lbnRzKHJxKSA/Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmxrX3JxX3BheWxvYWRfYnl0ZXMocnEpIDogMDsKPiDC
oMKgwqDCoMKgwqDCoCByZXEtPmN1cnJfYmlvID0gcnEtPmJpbzsKPiAtwqDCoMKgwqDCoMKgIGlm
IChyZXEtPmN1cnJfYmlvKQo+ICvCoMKgwqDCoMKgwqAgaWYgKHJlcS0+Y3Vycl9iaW8gJiYgcmVx
LT5kYXRhX2xlbikKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV90Y3BfaW5p
dF9pdGVyKHJlcSwgcnFfZGF0YV9kaXIocnEpKTsKPgo+IMKgwqDCoMKgwqDCoMKgIGlmIChycV9k
YXRhX2RpcihycSkgPT0gV1JJVEUgJiYKPiAtLSAKPgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK

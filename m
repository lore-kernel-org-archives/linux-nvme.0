Return-Path: <SRS0=oNOl=GM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B897BC433E0
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Jan 2021 02:00:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A46B23A23
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Jan 2021 02:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A46B23A23
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Zzb/cRiT8vAaTl05XFDld1T5jP+/En8ZxUWHG7kEmco=; b=Cv36ozsuOnJ/vg0jMziSR4apk
	ZuwaODTo6uzblDp4giq0W1JUjgljqafgS5/zDpUjeLCiUmXxHm0sF3QfcnTMG1UURFLMh5ONfRi8A
	8hs2qmwOgfwbmP4hOSvGo9AHFhruAsu6mkoUxOuNUyqpsqNjVgsC8w3BfXPByFhl46SNXCB3OjUGK
	wlNhZlJzqmrR2a8iXJ+rSvuAVFmP0k5xfd4IHbyc5zxwHDMw6EkNdk+f684Pr2eKiPsatgQLjfwPz
	/kHv1h1zsbVhbqlZZYMKjKOlEjq8K+jQSw4LB4vpplxnb6D9Pbz0vsQgREAJAUoczyvN3wfK+zBqF
	VCOWZM4lw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ky3Xw-0002ct-Ut; Sat, 09 Jan 2021 02:00:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ky3Xq-0002c1-VT
 for linux-nvme@lists.infradead.org; Sat, 09 Jan 2021 02:00:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1610157598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RzJWpyMqsI8i8W2kClaHQWVLWH3mV/SQhgT2wpGdtxU=;
 b=N/6KIWUnRKo0oqlgVmtxjOUoIjqF9MuMI80sBXn2WLUPDKa0TmezVXT8mAPgs35BgLtEVR
 EGNAIe2ro4EWsOnqoF/JhG+gUDIYTNVVc/FMZmc8N+bQyDyjmoi7O3LutRfEBu0/fENmxY
 dqGHrqgD4ShLi7U5VUmoFVBEO0PRSgI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-_PH662ZAM9qr9qxiMjsbFw-1; Fri, 08 Jan 2021 20:59:54 -0500
X-MC-Unique: _PH662ZAM9qr9qxiMjsbFw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D6AB180A097;
 Sat,  9 Jan 2021 01:59:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-74.pek2.redhat.com [10.72.12.74])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A14D05D9E3;
 Sat,  9 Jan 2021 01:59:48 +0000 (UTC)
Subject: Re: [PATCH] nvme-tcp: Fix possible race of io_work and direct send
To: Sagi Grimberg <sagi@grimberg.me>, Or Gerlitz <gerlitz.or@gmail.com>
References: <20201221080339.945164-1-sagi@grimberg.me>
 <CAJ3xEMj8Y_=Y=orV59GR9=L4M3r4+mZzMW6w2cv2K9d5eKXZDA@mail.gmail.com>
 <e206eb55-8792-b9c2-64cb-bd76ed09e12e@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <7f47bbab-9a32-3982-be56-6389148470ca@redhat.com>
Date: Sat, 9 Jan 2021 09:59:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e206eb55-8792-b9c2-64cb-bd76ed09e12e@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=yi.zhang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210108_205959_066835_ADDC4129 
X-CRM114-Status: GOOD (  22.81  )
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
Cc: Keith Busch <kbusch@kernel.org>, Boris Pismenny <borispismenny@gmail.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Ben Ben-ishay <benishay@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAxLzkvMjEgNDoyMCBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPgo+Pj4gLS0tIGEvZHJp
dmVycy9udm1lL2hvc3QvdGNwLmMKPj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCj4+
Cj4+PiBAQCAtMjc5LDcgKzI4OSw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBudm1lX3RjcF9xdWV1
ZV9yZXF1ZXN0KHN0cnVjdCAKPj4+IG52bWVfdGNwX3JlcXVlc3QgKnJlcSwKPj4+IMKgwqDCoMKg
wqDCoMKgwqAgaWYgKHF1ZXVlLT5pb19jcHUgPT0gc21wX3Byb2Nlc3Nvcl9pZCgpICYmCj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3luYyAmJiBlbXB0eSAmJiBtdXRleF90cnlsb2NrKCZx
dWV1ZS0+c2VuZF9tdXRleCkpIHsKPj4KPj4gYnV0IHdlIGNhbid0IHJlbHkgb24gdGhlIHByb2Nl
c3NvciBpZCBpZiB3ZSBhcmUgb24gcHJlZW1wdGlibGUgc3RhdGUuLgo+Pgo+PiDCoMKgIDM3My45
NDAzMzZdIEJVRzogdXNpbmcgc21wX3Byb2Nlc3Nvcl9pZCgpIGluIHByZWVtcHRpYmxlIFswMDAw
MDAwMF0KPj4gY29kZToga3dvcmtlci91ODo0LzQ1Nwo+PiBbwqAgMzczLjk0MjAzN10gY2FsbGVy
IGlzIG52bWVfdGNwX3N1Ym1pdF9hc3luY19ldmVudCsweDRkYS8weDY5MCAKPj4gW252bWVfdGNw
XQo+PiBbwqAgMzczLjk0MjE0NF0gQ1BVOiAwIFBJRDogNDU3IENvbW06IGt3b3JrZXIvdTg6NCBO
b3QgdGFpbnRlZCAKPj4gNS4xMS4wLXJjMSsgIzExNgo+PiBbwqAgMzczLjk0MjE3MV0gSGFyZHdh
cmUgbmFtZTogUUVNVSBTdGFuZGFyZCBQQyAoaTQ0MEZYICsgUElJWCwgMTk5NiksCj4+IEJJT1Mg
cmVsLTEuMTIuMS0wLWdhNWNhYjU4ZTlhM2YtcHJlYnVpbHQucWVtdS5vcmcgMDQvMDEvMjAxNAo+
PiBbwqAgMzczLjk0MjE5Nl0gV29ya3F1ZXVlOiBudm1lLXdxIG52bWVfYXN5bmNfZXZlbnRfd29y
ayBbbnZtZV9jb3JlXQo+PiBbwqAgMzczLjk0MjI1OV0gQ2FsbCBUcmFjZToKPj4gW8KgIDM3My45
NDIyODZdwqAgZHVtcF9zdGFjaysweGQwLzB4MTE5Cj4+IFvCoCAzNzMuOTQyMzQ2XcKgIGNoZWNr
X3ByZWVtcHRpb25fZGlzYWJsZWQrMHhlYy8weGYwCj4+IFvCoCAzNzMuOTQyMzk3XcKgIG52bWVf
dGNwX3N1Ym1pdF9hc3luY19ldmVudCsweDRkYS8weDY5MCBbbnZtZV90Y3BdCj4+IFvCoCAzNzMu
OTQyNDQ5XcKgIG52bWVfYXN5bmNfZXZlbnRfd29yaysweDExZC8weDFmMCBbbnZtZV9jb3JlXQo+
PiBbwqAgMzczLjk0MjQ5Nl3CoCA/IG52bWVfY3RybF9sb3NzX3Rtb19zaG93KzB4MTQwLzB4MTQw
IFtudm1lX2NvcmVdCj4+IFvCoCAzNzMuOTQyNTc2XcKgIHByb2Nlc3Nfb25lX3dvcmsrMHg5ZjMv
MHgxNjMwCj4+IFvCoCAzNzMuOTQyNjQ5XcKgID8gcHdxX2RlY19ucl9pbl9mbGlnaHQrMHgzMzAv
MHgzMzAKPj4gW8KgIDM3My45NDI3NjVdwqAgd29ya2VyX3RocmVhZCsweDllLzB4ZjYwCj4+IFvC
oCAzNzMuOTQyODQ5XcKgID8gcHJvY2Vzc19vbmVfd29yaysweDE2MzAvMHgxNjMwCj4+IFvCoCAz
NzMuOTQyODg5XcKgIGt0aHJlYWQrMHgzNjIvMHg0ODAKPj4gW8KgIDM3My45NDI5MThdwqAgPyBr
dGhyZWFkX2NyZWF0ZV9vbl9ub2RlKzB4MTAwLzB4MTAwCj4KPiBXZWxsLCB0aGlzIGlzIGEgaGV1
cmlzdGljIGFueXdheXMsIHRvbyBiYWQgd2UgbmVlZCB0bwo+IGRpc2FibGUgcHJlZW1wdGlvbiBq
dXN0IGZvciB0aGlzLi4uCj4KPiBJJ20gYXNzdW1pbmcgdGhhdCB0aGlzIG1ha2VzIHRoZSBpc3N1
ZSBnbyBhd2F5Pwo+IC0tIAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBi
L2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCj4gaW5kZXggY2Y4NTYxMDMwMjVhLi5lYTA3MzM2Y2Ex
NzkgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMKPiArKysgYi9kcml2ZXJz
L252bWUvaG9zdC90Y3AuYwo+IEBAIC0yODEsOCArMjgxLDExIEBAIHN0YXRpYyBpbmxpbmUgdm9p
ZCBudm1lX3RjcF9xdWV1ZV9yZXF1ZXN0KHN0cnVjdCAKPiBudm1lX3RjcF9yZXF1ZXN0ICpyZXEs
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJvb2wgc3luYywgYm9vbCBsYXN0KQo+
IMKgewo+IMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBudm1lX3RjcF9xdWV1ZSAqcXVldWUgPSByZXEt
PnF1ZXVlOwo+ICvCoMKgwqDCoMKgwqAgaW50IGNwdTsKPiDCoMKgwqDCoMKgwqDCoCBib29sIGVt
cHR5Owo+Cj4gK8KgwqDCoMKgwqDCoCBjcHUgPSBnZXRfY3B1KCk7Cj4gK8KgwqDCoMKgwqDCoCBw
dXRfY3B1KCk7Cj4gwqDCoMKgwqDCoMKgwqAgZW1wdHkgPSBsbGlzdF9hZGQoJnJlcS0+bGVudHJ5
LCAmcXVldWUtPnJlcV9saXN0KSAmJgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBs
aXN0X2VtcHR5KCZxdWV1ZS0+c2VuZF9saXN0KSAmJiAhcXVldWUtPnJlcXVlc3Q7Cj4KPiBAQCAt
MjkxLDggKzI5NCw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBudm1lX3RjcF9xdWV1ZV9yZXF1ZXN0
KHN0cnVjdCAKPiBudm1lX3RjcF9yZXF1ZXN0ICpyZXEsCj4gwqDCoMKgwqDCoMKgwqDCoCAqIGRp
cmVjdGx5LCBvdGhlcndpc2UgcXVldWUgaW9fd29yay4gQWxzbywgb25seSBkbyB0aGF0IGlmIHdl
Cj4gwqDCoMKgwqDCoMKgwqDCoCAqIGFyZSBvbiB0aGUgc2FtZSBjcHUsIHNvIHdlIGRvbid0IGlu
dHJvZHVjZSBjb250ZW50aW9uLgo+IMKgwqDCoMKgwqDCoMKgwqAgKi8KPiAtwqDCoMKgwqDCoMKg
IGlmIChxdWV1ZS0+aW9fY3B1ID09IHNtcF9wcm9jZXNzb3JfaWQoKSAmJgo+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoCBzeW5jICYmIGVtcHR5ICYmIG11dGV4X3RyeWxvY2soJnF1ZXVlLT5zZW5kX211
dGV4KSkgewo+ICvCoMKgwqDCoMKgwqAgaWYgKHF1ZXVlLT5pb19jcHUgPT0gY3B1ICYmIHN5bmMg
JiYgZW1wdHkgJiYKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgbXV0ZXhfdHJ5bG9jaygmcXVldWUt
PnNlbmRfbXV0ZXgpKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHF1ZXVlLT5t
b3JlX3JlcXVlc3RzID0gIWxhc3Q7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG52
bWVfdGNwX3NlbmRfYWxsKHF1ZXVlKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cXVldWUtPm1vcmVfcmVxdWVzdHMgPSBmYWxzZTsKPgpIaSBTYWdpClRoYW5rcyBmb3IgdGhlIHF1
aWNrIHJlc3BvbnNlLCBjb25maXJtZWQgdGhlIGlzc3VlIHdhcyBmaXhlZCwgZmVlbCBmcmVlIAp0
byBhZGQ6CgpUZXN0ZWQtYnk6IFlpIFpoYW5nIDx5aS56aGFuZ0ByZWRoYXQuY29tPgoKPiAtLSAK
Pgo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gTGlu
dXgtbnZtZSBtYWlsaW5nIGxpc3QKPiBMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKPiBo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUKPgoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

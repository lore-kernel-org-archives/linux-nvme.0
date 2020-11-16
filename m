Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB08C4742C
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 09:54:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F44020797
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 09:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mxCY1uok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F44020797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QEVX1z00Opa0aOEuOlj/3b5k3rKFjYo9l1BmoGb3bgY=; b=mxCY1uokA9IvXY5P0Dl6G4OdC
	oTS5xOMQZmuoP4r4XblH/LZ1B7dLYhGoIioDCn0+6TGov/Q6wIn/SEFypBI9K2W9LCOYepl0KHPbM
	6BqcLfuZdt6+yUOUvAuLyKKTVVrspGKzh7liWTs+soewfUu7OiHPzPvM99yCP+khr8/bOIuIXvB7G
	yq7doLNa6jXV4xXyJIAOmKT7suLH6r0vAiWkIHJ+XJTLZ3RDwma64Ifk4hs7zfvqmBNLun298t2zl
	XoKqElpt5OJLjLqm+B8Q5jPtrR3UDbPgDz/VBmbLVxyKuD7UKC1eJxhLCN2D3SPhUxjxfPvNLBnG5
	kswr4JnMw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kebD8-0006PO-CZ; Mon, 16 Nov 2020 09:54:10 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kebD6-0006Oy-2k
 for linux-nvme@lists.infradead.org; Mon, 16 Nov 2020 09:54:09 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C3B42ACE0;
 Mon, 16 Nov 2020 09:54:06 +0000 (UTC)
Subject: Re: [PATCH v9] nvme-fabrics: reject I/O to offline device
To: Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <319b8b1869f34a48b26fbd902883ed71@kioxia.com>
 <b6f09a8e-e633-e303-1f39-cd380fd92f2c@suse.de>
 <a3245f7368364c5b83cdd3ed3a61d718@kioxia.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <08f1048d-0726-983c-c783-2e04d24b5221@suse.de>
Date: Mon, 16 Nov 2020 10:54:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a3245f7368364c5b83cdd3ed3a61d718@kioxia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201116_045408_366767_D220CFB8 
X-CRM114-Status: GOOD (  24.44  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, "Ewan D. Milne" <emilne@redhat.com>,
 James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTEvMTUvMjAgNDo0NSBQTSwgVmljdG9yIEdsYWRrb3Ygd3JvdGU6Cj4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tCj4+IEZyb206IEhhbm5lcyBSZWluZWNrZSBbbWFpbHRvOmhhcmVAc3Vz
ZS5kZV0KPj4gU2VudDogVGh1cnNkYXksIDAxIE9jdG9iZXIsIDIwMjAgMTE6NTUKPiAKPj4+IC0t
LQo+Pj4gICAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jICAgICAgfCA0OQo+Pj4gKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+Pj4gICAgZHJpdmVycy9udm1lL2hv
c3QvZmFicmljcy5jICAgfCAyNSArKysrKysrKysrKysrKysrKysrLS0tCj4+PiAgICBkcml2ZXJz
L252bWUvaG9zdC9mYWJyaWNzLmggICB8ICA1ICsrKysrCj4+PiAgICBkcml2ZXJzL252bWUvaG9z
dC9tdWx0aXBhdGguYyB8ICA1ICsrKystCj4+PiAgICBkcml2ZXJzL252bWUvaG9zdC9udm1lLmgg
ICAgICB8ICAzICsrKwo+Pj4gICAgNSBmaWxlcyBjaGFuZ2VkLCA4MiBpbnNlcnRpb25zKCspLCA1
IGRlbGV0aW9ucygtKQo+Pj4KPj4gSSBkaWQgc29tZSBtb3JlIGV4cGVyaW1lbnRzIHdpdGggdGhp
cywgYW5kIGZvdW5kIHRoYXQgdGhlcmUgYXJlIHNvbWUgaXNzdWVzCj4+IHdpdGggQU5BIGhhbmRs
aW5nLgo+PiBJZiByZWNvbm5lY3Qgd29ya3MsIGJ1dCB0aGUgQU5BIHN0YXRlIGluZGljYXRlcyB0
aGF0IHdlIHN0aWxsIGNhbid0IHNlbnQgSS9PIChlZwo+PiBieSBzdGlsbCBiZWluZyBpbiB0cmFu
c2l0aW9uaW5nKSwgd2UgaGl0IHRoZSAncmVxdWV1ZWluZyBJL08nCj4+IHN0YXRlIGRlc3BpdGUg
ZmFzdF9pb19mYWlsX3RtbyBiZWluZyBzZXQuIE5vdCBzdXJlIGlmIHRoYXQncyB0aGUgZXhwZWN0
ZWQKPj4gb3V0Y29tZS4KPj4gRm9yIHRoYXQgaXQgbWlnaHQgYmUgYmV0dGVyIHRvIG1vdmUgdGhl
IEZBSUxGQVNUX0VYUElSRUQgYml0IGludG8gdGhlCj4+IG5hbWVzcGFjZSwgYXMgdGhlbiB3ZSBj
b3VsZCBzZWxlY3RpdmVseSBjbGVhciB0aGUgYml0IGluCj4+IG52bWVfZmFpbGZhc3Rfd29yaygp
Ogo+Pgo+PiBAQCAtMTUxLDEyICsxNTEsMTYgQEAgRVhQT1JUX1NZTUJPTF9HUEwobnZtZV90cnlf
c2NoZWRfcmVzZXQpOwo+PiAgICBzdGF0aWMgdm9pZCBudm1lX2ZhaWxmYXN0X3dvcmsoc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKSB7Cj4+ICAgICAgICAgICBzdHJ1Y3QgbnZtZV9jdHJsICpjdHJs
ID0gY29udGFpbmVyX29mKHRvX2RlbGF5ZWRfd29yayh3b3JrKSwKPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgbnZtZV9jdHJsLCBmYWlsZmFzdF93b3JrKTsKPj4gKyAgICAgICBz
dHJ1Y3QgbnZtZV9ucyAqbnM7Cj4+Cj4+IC0gICAgICAgaWYgKGN0cmwtPnN0YXRlICE9IE5WTUVf
Q1RSTF9DT05ORUNUSU5HKQo+PiAtICAgICAgICAgICAgICAgcmV0dXJuOwo+PiAtCj4+IC0KPj4g
LSAgICAgICBzZXRfYml0KE5WTUVfQ1RSTF9GQUlMRkFTVF9FWFBJUkVELCAmY3RybC0+ZmxhZ3Mp
Owo+PiArICAgICAgIGRvd25fcmVhZCgmY3RybC0+bmFtZXNwYWNlc19yd3NlbSk7Cj4+ICsgICAg
ICAgbGlzdF9mb3JfZWFjaF9lbnRyeShucywgJmN0cmwtPm5hbWVzcGFjZXMsIGxpc3QpIHsKPj4g
KyAgICAgICAgICAgICAgIGlmIChjdHJsLT5zdGF0ZSAhPSBOVk1FX0NUUkxfTElWRSB8fAo+PiAr
ICAgICAgICAgICAgICAgICAgIChucy0+YW5hX3N0YXRlICE9IE5WTUVfQU5BX09QVElNSVpFRCAm
Jgo+PiArICAgICAgICAgICAgICAgICAgICBucy0+YW5hX3N0YXRlICE9IE5WTUVfQU5BX05PTk9Q
VElNSVpFRCkpCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIHNldF9iaXQoTlZNRV9OU19GQUlM
RkFTVF9FWFBJUkVELCAmbnMtPmZsYWdzKTsKPj4gKyAgICAgICB9Cj4+ICsgICAgICAgdXBfcmVh
ZCgmY3RybC0+bmFtZXNwYWNlc19yd3NlbSk7Cj4+ICAgICAgICAgICBkZXZfaW5mbyhjdHJsLT5k
ZXZpY2UsICJmYWlsZmFzdCBleHBpcmVkXG4iKTsKPj4KPj4gLi4uYW5kIHdlIGNvdWxkIGxlYXZl
IHRoZSBmYWlsZmFzdCB3b3JrZXIgcnVubmluZyBldmVuIGFmdGVyIHRoZSBjb250cm9sbGVyCj4+
IHRyYW5zaXRpb25lZCB0byBMSVZFLgo+PiBDZiB0aGUgYXR0YWNoZWQgcGF0Y2ggZm9yIGRldGFp
bHMuCj4+Cj4+IENoZWVycywKPj4KPj4gSGFubmVzCj4+IC0tCj4gCj4gSSdtIG5vdCBzdXJlIHdo
YXQgbWFrZXMgc2Vuc2UgdG8gbW92ZSB0aGUgRkFJTEZBU1RfRVhQSVJFRCBiaXQgaW50byB0aGUg
bmFtZXNwYWNlLAo+IEJlY2F1c2UgdGhlIGZhaWxmYXN0IG1lY2hhbmlzbSBjaGFyYWN0ZXJpemVz
IHRoZSBjb250cm9sbGVyIGFzIGEgd2hvbGUuCj4gCk9oLCB5ZXMsIEknbSBhd2FyZSBvZiB0aGF0
LiBCdXQgdGhlIHByb2JsZW0gaGVyZSBpcyB3aXRoIG11bHRpcGF0aDsgaG93IApkbyB3ZSBoYW5k
bGUgdGhlIHNpdHVhdGlvbiB3aGVyZSBhbGwgY29udHJvbGxlcnMgaGF2ZSB0aGUgCidmYWlsZmFz
dF9leHBpcmVkJyBiaXQgc2V0PwpTaG91bGQgSS9PIGJlIHRlcm1pbmF0ZWQgKHdoaWNoIEkgdGhp
bmsgaXQgc2hvdWxkLCBnaXZlbiB0aGF0IGZhaWxmYXN0IAppcyBzdXBwb3NlZCB0byB0ZXJtaW5h
dGUgdGhlIEkvTyk/Ck9yIHNob3VsZCBJL08gY29udGludWUgdG8gcnVuIChhcyBpdCBkb2VzIHdp
dGggeW91ciBvcmlnaW5hbCBwYXRjaCk/CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMg
UmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3Vz
ZS5kZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0Ug
U29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpI
UkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2
cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

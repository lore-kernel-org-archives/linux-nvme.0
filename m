Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F61C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 19:15:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C9A20657
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 19:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ufnL4o7l";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftZTZ2xI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C9A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1xp3qEgveNFMDARGM9yo8nlcwhBWFNWblstQld0nv0w=; b=ufnL4o7lTu4RFS89lYE49yuua
	1U2J9iX7F4f4kFnCd/NxHkDI406e7PuU8k3pSOMVxNDPw3PAmv4YM1F8gSUPGJ/Foew7o1+pyxylP
	MF8IBR49JsOXK6ectbf6bIxurub6T67jCpmil1W/V+93ADnrsqW/FJd05b7Nuky4RyU+blIfAJVUZ
	NjNP+VM+0N5CB3SfWf6I1LUP8wRxmfwPN4HEE3YccsX6jtdbYkfwrdvx2Jbullqka+P7m4LM1EdKq
	cnNtl8MfMRgZmO+6ahShgbkTEaV6PU1dTKNtN6opjyMPt+HHvl0+WV4ofN88GTQFMpsgsFRThBZ8N
	NKq5PnhBQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jb7hr-0001wL-53; Tue, 19 May 2020 19:15:15 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jb7hm-0000nf-Rf
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 19:15:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589915706;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G6/8P1RowEoY86giVu8CCt7W6dYlBCA7+83dVKYc7L4=;
 b=ftZTZ2xIxdgAjwwpGPiit5VAbsq+Pd/py7EylnFLMLP7q8MUCfrXnw5eUuvJajH4IynKFi
 b/p0jT6gdP4EG6HsL8m6a0daqNPTylnTWEoQEQ1NxsMvcN9wcgzvjLOZIfZEEsC8gUv2Vq
 x+R/ELXr1PjL52+pWfVhweHzWdfBi8w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-FVGirvKTNr-G_a3YybEdOQ-1; Tue, 19 May 2020 15:15:04 -0400
X-MC-Unique: FVGirvKTNr-G_a3YybEdOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6FDB800D24;
 Tue, 19 May 2020 19:14:59 +0000 (UTC)
Received: from [10.3.112.120] (ovpn-112-120.phx2.redhat.com [10.3.112.120])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE48160BE1;
 Tue, 19 May 2020 19:14:57 +0000 (UTC)
Subject: Re: [PATCH v2 2/2] nvmet: avoid memleak by freeing any remaining aens
 in nvmet_async_events_free
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <1589828396-144513-1-git-send-email-dmilburn@redhat.com>
 <1589828396-144513-3-git-send-email-dmilburn@redhat.com>
 <388242d3-5ccc-d694-c7a0-ac489f63f26a@grimberg.me>
From: David Milburn <dmilburn@redhat.com>
Message-ID: <ced87004-a580-853f-2a27-e3acb789637e@redhat.com>
Date: Tue, 19 May 2020 14:14:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <388242d3-5ccc-d694-c7a0-ac489f63f26a@grimberg.me>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_121511_011637_E5CC1436 
X-CRM114-Status: GOOD (  27.74  )
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
Cc: hch@infradead.org, dwagner@suse.de, chaitanya.kulkarni@wdc.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGkgU2FnaSwKCk9uIDA1LzE5LzIwMjAgMDM6MzMgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4g
Cj4gCj4gT24gNS8xOC8yMCAxMTo1OSBBTSwgRGF2aWQgTWlsYnVybiB3cm90ZToKPj4gTWFrZSBz
dXJlIHdlIGZyZWUgYWxsIHJlc291cmNlcyBpbmNsdWRpbmcgYW55IHJlbWFpbmluZyBhZW5zCj4+
IHdoaWNoIG1heSByZXN1bHQgaW4gYSBtZW1vcnkgbGVhay4KPj4KPj4gJCBjYXQgL3N5cy9rZXJu
ZWwvZGVidWcva21lbWxlYWsKPj4gdW5yZWZlcmVuY2VkIG9iamVjdCAweGZmZmY4ODhjMWFmMmMw
MDAgKHNpemUgMzIpOgo+PiDCoMKgIGNvbW0gIm52bWV0Y2xpIiwgcGlkIDUxNjQsIGppZmZpZXMg
NDI5NTIyMDg2NCAoYWdlIDY4MjkuOTI0cykKPj4gwqDCoCBoZXggZHVtcCAoZmlyc3QgMzIgYnl0
ZXMpOgo+PiDCoMKgwqDCoCAyOCAwMSA4MiAzYiA4YiA4OCBmZiBmZiAyOCAwMSA4MiAzYiA4YiA4
OCBmZiBmZsKgICguLjsuLi4uKC4uOy4uLi4KPj4gwqDCoMKgwqAgMDIgMDAgMDQgNjUgNzYgNjUg
NmUgNzQgNWYgNjYgNjkgNmMgNjUgMDAgMDAgMDDCoCAuLi5ldmVudF9maWxlLi4uCj4+IMKgwqAg
YmFja3RyYWNlOgo+PiDCoMKgwqDCoCBbPDAwMDAwMDAwMjE3YWU1ODA+XSBudm1ldF9hZGRfYXN5
bmNfZXZlbnQrMHg1Ny8weDI5MCBbbnZtZXRdCj4+IMKgwqDCoMKgIFs8MDAwMDAwMDAxMmFhMmVh
OT5dIG52bWV0X25zX2NoYW5nZWQrMHgyMDYvMHgzMDAgW252bWV0XQo+PiDCoMKgwqDCoCBbPDAw
MDAwMDAwYmIzZmQ1MmU+XSBudm1ldF9uc19kaXNhYmxlKzB4MzY3LzB4NGYwIFtudm1ldF0KPj4g
wqDCoMKgwqAgWzwwMDAwMDAwMGU5MWNhOWVjPl0gbnZtZXRfbnNfZnJlZSsweDE1LzB4MTgwIFtu
dm1ldF0KPj4gwqDCoMKgwqAgWzwwMDAwMDAwMGExNWRlYjUyPl0gY29uZmlnX2l0ZW1fcmVsZWFz
ZSsweGYxLzB4MWMwCj4+IMKgwqDCoMKgIFs8MDAwMDAwMDA3ZTE0ODQzMj5dIGNvbmZpZ2ZzX3Jt
ZGlyKzB4NTU1LzB4N2MwCj4+IMKgwqDCoMKgIFs8MDAwMDAwMDBmNDUwNmVhNj5dIHZmc19ybWRp
cisweDE0Mi8weDNjMAo+PiDCoMKgwqDCoCBbPDAwMDAwMDAwMDBhY2FhZjA+XSBkb19ybWRpcisw
eDJiMi8weDM0MAo+PiDCoMKgwqDCoCBbPDAwMDAwMDAwMzRkMWFhNTI+XSBkb19zeXNjYWxsXzY0
KzB4YTUvMHg0ZDAKPj4gwqDCoMKgwqAgWzwwMDAwMDAwMDIxMWYxM2JjPl0gZW50cnlfU1lTQ0FM
TF82NF9hZnRlcl9od2ZyYW1lKzB4NmEvMHhkZgo+Pgo+PiBTdGVwcyB0byBSZXByb2R1Y2U6Cj4+
Cj4+IHRhcmdldDoKPj4gMS4gbnZtZXRjbGkgcmVzdG9yZSByZG1hLmpzb24KPj4KPj4gY2xpZW50
Ogo+PiAyLiBudm1lIGNvbm5lY3QgLXQgcmRtYSAtYSAkSVAgLXMgNDQyMCAtbiB0ZXN0bnFuCj4+
Cj4+IHRhcmdldDoKPj4gMy4gbnZtZXRjbGkgY2xlYXIKPj4gNC4gc2xlZXAgNSAmJiBudm1ldGNs
aSByZXN0b3JlIHJkbWEuanNvbgo+PiA1LiBjYXQgL3N5cy9rZXJuZWwvZGVidWcva21lbWxlYWsg
YWZ0ZXIgNSBtaW51dGVzCj4+Cj4+IFJlcG9ydGVkLWJ5OiBZaSBaaGFuZyA8eWkuemhhbmdAcmVk
aGF0LmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTWlsYnVybiA8ZG1pbGJ1cm5AcmVkaGF0
Y29tPgo+PiAtLS0KPj4gQ2hhbmdlcyBmcm9tIHYxOgo+PiDCoCAtIGRlY2xhcmUgc3RydWN0IG52
bWV0X2FzeW5jX2V2ZW50IGluIHRoaXMgcGF0Y2guCj4+Cj4+IMKgIGRyaXZlcnMvbnZtZS90YXJn
ZXQvY29yZS5jIHwgOCArKysrKysrKwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25z
KCspCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYyBiL2RyaXZl
cnMvbnZtZS90YXJnZXQvY29yZS5jCj4+IGluZGV4IGRjMDM2YTgxNWQzOS4uZGRhODg4NjcyZjMx
IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYwo+PiArKysgYi9kcml2
ZXJzL252bWUvdGFyZ2V0L2NvcmUuYwo+PiBAQCAtMTU0LDYgKzE1NCw3IEBAIHN0YXRpYyB2b2lk
IG52bWV0X2FzeW5jX2V2ZW50c19wcm9jZXNzKHN0cnVjdCAKPj4gbnZtZXRfY3RybCAqY3RybCwg
dTE2IHN0YXR1cykKPj4gwqAgc3RhdGljIHZvaWQgbnZtZXRfYXN5bmNfZXZlbnRzX2ZyZWUoc3Ry
dWN0IG52bWV0X2N0cmwgKmN0cmwpCj4+IMKgIHsKPj4gK8KgwqDCoCBzdHJ1Y3QgbnZtZXRfYXN5
bmNfZXZlbnQgKmFlbjsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgbnZtZXRfcmVxICpyZXE7Cj4+IMKg
wqDCoMKgwqAgbXV0ZXhfbG9jaygmY3RybC0+bG9jayk7Cj4+IEBAIC0xNjMsNiArMTY0LDEzIEBA
IHN0YXRpYyB2b2lkIG52bWV0X2FzeW5jX2V2ZW50c19mcmVlKHN0cnVjdCAKPj4gbnZtZXRfY3Ry
bCAqY3RybCkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIG52bWV0X3JlcV9jb21wbGV0ZShyZXEsIE5W
TUVfU0NfSU5URVJOQUwgfCBOVk1FX1NDX0ROUik7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBtdXRl
eF9sb2NrKCZjdHJsLT5sb2NrKTsKPj4gwqDCoMKgwqDCoCB9Cj4+ICsKPj4gK8KgwqDCoCB3aGls
ZSAoIWxpc3RfZW1wdHkoJmN0cmwtPmFzeW5jX2V2ZW50cykpIHsKPj4gK8KgwqDCoMKgwqDCoMKg
IGFlbiA9IGxpc3RfZmlyc3RfZW50cnkoJmN0cmwtPmFzeW5jX2V2ZW50cywKPj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBudm1ldF9hc3luY19l
dmVudCwgZW50cnkpOwo+PiArwqDCoMKgwqDCoMKgwqAgbGlzdF9kZWwoJmFlbi0+ZW50cnkpOwo+
PiArwqDCoMKgwqDCoMKgwqAga2ZyZWUoYWVuKTsKPj4gK8KgwqDCoCB9Cj4+IMKgwqDCoMKgwqAg
bXV0ZXhfdW5sb2NrKCZjdHJsLT5sb2NrKTsKPj4gwqAgfQo+IAo+IFNvbWV0aGluZyBoZXJlIGxv
b2tzIHdyb25nIHRvIG1lLi4uIFRoZXJlIGlzIG5vIHJlYXNvbiB0byBmcmVlIGFlbnMgaGVyZS4u
Lgo+IAo+IEFsc28sIHNlZWluZyBwcmlvciBkaXNjdXNzaW9uIG9uIHRoaXMgcGF0Y2gKPiB3ZSBk
b24ndCBhY3R1YWxseSB0YWtlIGFueXRoaW5nIGZyb20gdGhlIGxpc3QgaWYgd2UgZG9uJ3QgaGF2
ZSBhbiAKPiBhdmFpbGFibGUgc2xvdCwgc28gSQo+IGRvbid0IHNlZSBob3cgcGF0Y2ggIzEgaGVs
cHMgYW55dGhpbmcuLi4KPiAKPiBEaWQgeW91IGFuYWx5emUgdGhlIHJvb3QgY2F1c2Ugb2YgdGhl
IGlzc3VlPyBJdCdzIG5vdCBjbGVhciB3aGF0IGlzIHRoZSAKPiByb290IGNhdXNlCj4gaGVyZS4u
Cj4gCj4gTG9va2luZyBhdCB0aGUgY29kZSwgbnZtZXRfYXN5bmNfZXZlbnRzX2ZyZWUgd2hpY2gg
aXMgZGVzaWduZWQgdG8gZnJlZSAKPiBhbGwgdGhlCj4gcGVuZGluZyBhZW5zIHRoYXQgYXJlIG5v
dCBnb2luZyB0byBiZSBzZW50IGFueXdoZXJlLCBpcyBub3QgZnJlZWluZyAKPiBhbnl0aGluZy4u
Lgo+IEl0cyBhbHNvIG5vdCBjbGVhciB0byBtZSBmcm9tIHRoZSBjb2RlIGhvdyBjYW4gY3RybC0+
YXN5bmNfZXZlbnRzIGxpc3QgYW5kCj4gY3RybC0+bnJfYXN5bmNfZXZlbnRfY21kcyBhcmUgbm90
IGNvcnJlbGF0ZWQuLi4KPiAKPiBEb2VzIHRoaXMgcGF0Y2ggc29sdmUgeW91ciBpc3N1ZT8KPiAt
LSAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMgYi9kcml2ZXJzL252
bWUvdGFyZ2V0L2NvcmUuYwo+IGluZGV4IGI2ODVmOTlkNTZhMS4uMTkwZDM2Y2VkYTQ3IDEwMDY0
NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jCj4gKysrIGIvZHJpdmVycy9udm1l
L3RhcmdldC9jb3JlLmMKPiBAQCAtMTU3LDEwICsxNTcsMTUgQEAgc3RhdGljIHZvaWQgbnZtZXRf
YXN5bmNfZXZlbnRzX3Byb2Nlc3Moc3RydWN0IAo+IG52bWV0X2N0cmwgKmN0cmwsIHUxNiBzdGF0
dXMpCj4gCj4gIMKgc3RhdGljIHZvaWQgbnZtZXRfYXN5bmNfZXZlbnRzX2ZyZWUoc3RydWN0IG52
bWV0X2N0cmwgKmN0cmwpCj4gIMKgewo+ICvCoMKgwqDCoMKgwqAgc3RydWN0IG52bWV0X2FzeW5j
X2V2ZW50ICphZW47Cj4gIMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBudm1ldF9yZXEgKnJlcTsKPiAK
PiAgwqDCoMKgwqDCoMKgwqAgbXV0ZXhfbG9jaygmY3RybC0+bG9jayk7Cj4gIMKgwqDCoMKgwqDC
oMKgIHdoaWxlIChjdHJsLT5ucl9hc3luY19ldmVudF9jbWRzKSB7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgYWVuID0gbGlzdF9maXJzdF9lbnRyeSgmY3RybC0+YXN5bmNfZXZlbnRz
LAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgc3RydWN0IG52bWV0X2FzeW5jX2V2ZW50LCBlbnRyeSk7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgbGlzdF9kZWwoJmFlbi0+ZW50cnkpOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGtmcmVlKGFlbik7Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXEgPSBjdHJsLT5hc3luY19ldmVudF9jbWRzWy0tY3RybC0+bnJfYXN5bmNfZXZlbnRf
Y21kc107Cj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtdXRleF91bmxvY2soJmN0
cmwtPmxvY2spOwo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZXRfcmVxX2Nv
bXBsZXRlKHJlcSwgTlZNRV9TQ19JTlRFUk5BTCB8IE5WTUVfU0NfRE5SKTsKPiAtLSAKPiAKClRo
ZSBhYm92ZSBkb2Vzbid0IHNvbHZlIHRoZSBpc3N1ZSwgdGhpcyBpcyB3aGF0IEkgc2VlIHdpdGgK
dGhlIGhhbmRsaW5nIG9mIGN0cmwtPmFzeW5jX2V2ZW50cyBhbmQgY3RybC0+bnJfYXN5bmNfZXZl
bnRzX2NtZHMuCgpBZnRlciBob3N0IHN5c3RlbSBjb25uZWN0cyB0byB0YXJnZXQKCm52bWV0X3Jk
bWFfaGFuZGxlX2NvbW1hbmQKICBudm1ldF9yZG1hX2V4ZWN1dGVfY29tbWFuZAogICBudm1ldF9l
eGVjdXRlX2FzeW5jX2V2ZW50CgpOb3csIHJlcXVlc3QgaXMgYWRkZWQgdG8gYXN5bmNfZXZlbnRf
Y21kcywgaW5jcmVtZW50IApjdHJsLT5ucl9hc3luY19ldmVudF9jbWRzKysKCihqdXN0IHVzZWQg
dGhlIGFib3ZlLCBub3QgcGF0Y2ggIzEgb2YgdGhpcyBzZXJpZXMpCgpudm1ldF9hc3luY19ldmVu
dHNfcHJvY2VzcwoKU28sIGF0IHRoaXMgcG9pbnQgbm90aGluZyBoYXMgYmVlbiBhZGRlZCB0byBj
dHJsLT5hc3luY19ldmVudHMKYW5kIGN0cmwtPm5yX2FzeW5jX2V2ZW50c19jbWQgaXMgMSBzbyB0
aGUgZHJpdmVyIGJyZWFrcyBvdXQKb2Ygd2hpbGUoMSkuCgpOZXh0IHRlc3QgZG9lcyAibnZtZXRj
bGkgY2xlYXIiCgpudm1ldF9zcV9kZXN0cm95CiAgbnZtZXRfYXN5bmNfZXZlbnRzX3Byb2Nlc3MK
ClNhbWUgYXMgYmVmb3JlLCBub3RoaW5nIGhhcyBiZWVuIGFkZGVkIHRvIGN0cmwtPmFzeW5jX2V2
ZW50cwphbmQgY3RybC0+bnJfYXN5bmNfZXZlbnRzX2NtZCBpcyAxIHNvIHRoZSBkcml2ZXJzIGJy
ZWFrcyBvdXQKb2Ygd2hpbGUoMSkuCgpudm1ldF9hc3luY19ldmVudHNfZnJlZQoKTm90aGluZyB5
ZXQgaGFzIGJlZW4gYWRkZWQgdG8gY3RybC0+YXN5bmNfZXZlbnRzLCBhbmQgdGhlCmRyaXZlciBw
dWxscyB0aGUgcmVxdWVzdCwgZGVjIGN0cmwtPm5yX2FzeW5jX2V2ZW50c19jbWQgdG8gMCwKYW5k
IG52bWV0X3JlcV9jb21wbGV0ZSwgdW5sb2NrIGN0cmwtPmxvY2suCgpUaGVuLAoKbnZtZXRfbnNf
ZnJlZQogIG52bWV0X25zX2Rpc2FibGUKICAgbnZtZXRfbnNfY2hhbmdlZAogICAgbnZtZXRfYWRk
X2FzeW5jX2V2ZW50CgpOb3cgYXQgdGhpcyBwb2ludCB3ZSBhZGQgdGhlIGVudHJ5IHRvIGN0cmwt
PmFzeW5jX2V2ZW50cywgZ28KYmFjayB0aHJvdWdoIG52bWV0X2FzeW5jX2V2ZW50c19wcm9jZXNz
LCB3ZSBoYXZlIGFuIGVudHJ5Cm9uIGN0cmwtPmFzeW5jX2V2ZW50cywgYnV0IGN0cmwtPm5yX2Fz
eW5jX2V2ZW50X2NtZHMgaXMgMCwKc28gdGhlIGRyaXZlciBicmVha3Mgb3V0IG9mIHdoaWxlKDEp
LgoKVGhhbmtzLApEYXZpZAoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=

Return-Path: <SRS0=pSM9=LQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52B8C2B9F4
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 06:32:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 601CE611AF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Jun 2021 06:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 601CE611AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EiIlNY/dc/K/1Uin//mvdlw7eiBTpAM087ZSRHOKmYM=; b=vu5MyR2PoZjt+UWzIvWHExyUFH
	PU/dv8d2hlGM7icRouGB2SFJiqaB3BU37c/BwIpGAS0RsRzUgC300PFlzomiz2UzIwy/qf7omvRc+
	lHKd5x7ZYRr+orsw979Rta1xAfrmVLTIQ7nEwDQeU2CsFvI+1H1oMAlcE8pyR2rZ4ZHu3t/UgEibB
	TemxB7a5zt8tNB2a9wFqRxFbM2IJQ4Ig+JNRyu/jHjXx4f3MqyFMweWolzW+3MKgtsw00ruSvPXWS
	82hjYGDaK8sowMl0hEEY1sZPS3yRozWgfVCOZaTIbCWGj82fRwHRqv0BpmHmyfxMTQm2DHZpNPArj
	S3FsdWLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvZx1-005pUB-23; Tue, 22 Jun 2021 06:31:59 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvZwy-005pTZ-FM
 for linux-nvme@lists.infradead.org; Tue, 22 Jun 2021 06:31:58 +0000
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
 (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EDE38219A0;
 Tue, 22 Jun 2021 06:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624343514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hX+p5369uBCuRnxUduihdmoy52JqdWfbSoCG0Qoks48=;
 b=Lu2E17qb1scCE44CnuQj0+kPPlfZL88d1leO4CKujjQC89HotmBokcAqqnwbxIaeBJ/y8n
 YurgWIk7oDwCBJ5eMy3SDjvDD778jI8Ic6Z0rHPmOkA3vly+DbeH+F5V93oIWvAMATEqHj
 rwk0QBqqPn5b+wiwq58gMGwwp4mu5xM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624343514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hX+p5369uBCuRnxUduihdmoy52JqdWfbSoCG0Qoks48=;
 b=8GQ90OHtwUGX42GxpHWDg8Z9l3VJV2nXvaw7i6QH/ZNOT56EWpTbF1tC3vbD8Ze/ephOMu
 fB5CpzVYWKKhyYCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
 by imap.suse.de (Postfix) with ESMTP id CBA3E118DD;
 Tue, 22 Jun 2021 06:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624343514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hX+p5369uBCuRnxUduihdmoy52JqdWfbSoCG0Qoks48=;
 b=Lu2E17qb1scCE44CnuQj0+kPPlfZL88d1leO4CKujjQC89HotmBokcAqqnwbxIaeBJ/y8n
 YurgWIk7oDwCBJ5eMy3SDjvDD778jI8Ic6Z0rHPmOkA3vly+DbeH+F5V93oIWvAMATEqHj
 rwk0QBqqPn5b+wiwq58gMGwwp4mu5xM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624343514;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hX+p5369uBCuRnxUduihdmoy52JqdWfbSoCG0Qoks48=;
 b=8GQ90OHtwUGX42GxpHWDg8Z9l3VJV2nXvaw7i6QH/ZNOT56EWpTbF1tC3vbD8Ze/ephOMu
 fB5CpzVYWKKhyYCA==
Received: from director2.suse.de ([192.168.254.72]) by imap3-int with ESMTPSA
 id 3q3eMNqD0WC/UAAALh3uQQ
 (envelope-from <hare@suse.de>); Tue, 22 Jun 2021 06:31:54 +0000
Subject: Re: [PATCHv6] nvme: allow to re-attach namespaces after all paths are
 down
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20210609150118.130650-1-hare@suse.de>
 <4903ef70-ed16-4b81-3570-60e9fcc5ecb0@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <4a05b0de-8639-0747-e9f4-c20400854b02@suse.de>
Date: Tue, 22 Jun 2021 08:31:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <4903ef70-ed16-4b81-3570-60e9fcc5ecb0@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210621_233156_718751_103DC3D9 
X-CRM114-Status: GOOD (  33.53  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gNi8yMS8yMSA4OjEzIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+IAo+IE9uIDYvOS8y
MSA4OjAxIEFNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+IFdlIHNob3VsZCBvbmx5IHJlbW92
ZSB0aGUgbnMgaGVhZCBmcm9tIHRoZSBsaXN0IG9mIGhlYWRzIHBlcgo+PiBzdWJzeXN0ZW0gaWYg
dGhlIHJlZmVyZW5jZSBjb3VudCBkcm9wcyB0byB6ZXJvLiBUaGF0IGNsZWFucyB1cAo+PiByZWZl
cmVuY2UgY291bnRpbmcsIGFuZCBhbGxvd3MgdXMgdG8gY2FsbCBkZWxfZ2VuZGlzaygpIG9uY2Ug
dGhlIGxhc3QKPj4gcGF0aCBpcyByZW1vdmVkIChhcyB0aGVuIHRoZSBuc19oZWFkIHNob3VsZCBi
ZSByZW1vdmVkIGFueXdheSkuCj4+IEFzIHRoaXMgaW50cm9kdWNlcyBhICh0aGVvcmV0aWNhbCkg
cmFjZSBjb25kaXRpb24gd2hlcmUgSS9PIG1pZ2h0IGhhdmUKPj4gYmVlbiByZXF1ZXVlZCBiZWZv
cmUgdGhlIGxhc3QgcGF0aCB3ZW50IGRvd24gd2UgYWxzbyBzaG91bGQgYmUgY2hlY2tpbmcKPj4g
aWYgdGhlIGdlbmRpc2sgaXMgc3RpbGwgcHJlc2VudCBpbiBudm1lX25zX2hlYWRfc3VibWl0X2Jp
bygpLAo+PiBhbmQgZmFpbGluZyBJL08gaWYgc28uCj4+Cj4+IENoYW5nZXMgdG8gdjU6Cj4+IC0g
U3luY2hyb25pemUgYmV0d2VlbiBudm1lX2luaXRfbnNfaGVhZCgpIGFuZCAKPj4gbnZtZV9tcGF0
aF9jaGVja19sYXN0X3BhdGgoKQo+PiAtIENoZWNrIGZvciByZW1vdmVkIGdlbmRpc2sgaW4gbnZt
ZV9uc19oZWFkX3N1Ym1pdF9iaW8oKQo+PiBDaGFuZ2VzIHRvIHY0Ogo+PiAtIENhbGwgZGVsX2dl
bmRpc2soKSBpbiBudm1lX21wYXRoX2NoZWNrX2xhc3RfcGF0aCgpIHRvIGF2b2lkIGRlYWRsb2Nr
Cj4+IENoYW5nZXMgdG8gdjM6Cj4+IC0gU2ltcGxpZnkgaWYoKSBjbGF1c2UgdG8gZGV0ZWN0IGR1
cGxpY2F0ZSBuYW1lc3BhY2VzCj4+IENoYW5nZXMgdG8gdjI6Cj4+IC0gRHJvcCBtZW1jcHkoKSBz
dGF0ZW1lbnQKPj4gQ2hhbmdlcyB0byB2MToKPj4gLSBBbHdheXMgY2hlY2sgTlNJRHMgYWZ0ZXIg
cmVhdHRhY2gKPj4KPj4gU2lnbmVkLW9mZi1ieTogSGFubmVzIFJlaW5lY2tlIDxoYXJlQHN1c2Uu
ZGU+Cj4+IC0tLQo+PiDCoCBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmPCoMKgwqDCoMKgIHzCoCA5
ICsrKystLS0tLQo+PiDCoCBkcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYyB8IDMwICsrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLQo+PiDCoCBkcml2ZXJzL252bWUvaG9zdC9udm1lLmjC
oMKgwqDCoMKgIHwgMTEgKystLS0tLS0tLS0KPj4gwqAgMyBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNl
cnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZt
ZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiBpbmRleCAxNzdjYWU0
NGI2MTIuLjZkN2MyOTU4YjNlMiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29y
ZS5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+PiBAQCAtNTY2LDYgKzU2Niw5
IEBAIHN0YXRpYyB2b2lkIG52bWVfZnJlZV9uc19oZWFkKHN0cnVjdCBrcmVmICpyZWYpCj4+IMKg
wqDCoMKgwqAgc3RydWN0IG52bWVfbnNfaGVhZCAqaGVhZCA9Cj4+IMKgwqDCoMKgwqDCoMKgwqDC
oCBjb250YWluZXJfb2YocmVmLCBzdHJ1Y3QgbnZtZV9uc19oZWFkLCByZWYpOwo+PiArwqDCoMKg
IG11dGV4X2xvY2soJmhlYWQtPnN1YnN5cy0+bG9jayk7Cj4+ICvCoMKgwqAgbGlzdF9kZWxfaW5p
dCgmaGVhZC0+ZW50cnkpOwo+PiArwqDCoMKgIG11dGV4X3VubG9jaygmaGVhZC0+c3Vic3lzLT5s
b2NrKTsKPj4gwqDCoMKgwqDCoCBudm1lX21wYXRoX3JlbW92ZV9kaXNrKGhlYWQpOwo+PiDCoMKg
wqDCoMKgIGlkYV9zaW1wbGVfcmVtb3ZlKCZoZWFkLT5zdWJzeXMtPm5zX2lkYSwgaGVhZC0+aW5z
dGFuY2UpOwo+PiDCoMKgwqDCoMKgIGNsZWFudXBfc3JjdV9zdHJ1Y3QoJmhlYWQtPnNyY3UpOwo+
PiBAQCAtMzgwNiw4ICszODA5LDYgQEAgc3RhdGljIHZvaWQgbnZtZV9hbGxvY19ucyhzdHJ1Y3Qg
bnZtZV9jdHJsIAo+PiAqY3RybCwgdW5zaWduZWQgbnNpZCwKPj4gwqDCoCBvdXRfdW5saW5rX25z
Ogo+PiDCoMKgwqDCoMKgIG11dGV4X2xvY2soJmN0cmwtPnN1YnN5cy0+bG9jayk7Cj4+IMKgwqDC
oMKgwqAgbGlzdF9kZWxfcmN1KCZucy0+c2libGluZ3MpOwo+PiAtwqDCoMKgIGlmIChsaXN0X2Vt
cHR5KCZucy0+aGVhZC0+bGlzdCkpCj4+IC3CoMKgwqDCoMKgwqDCoCBsaXN0X2RlbF9pbml0KCZu
cy0+aGVhZC0+ZW50cnkpOwo+PiDCoMKgwqDCoMKgIG11dGV4X3VubG9jaygmY3RybC0+c3Vic3lz
LT5sb2NrKTsKPj4gwqDCoMKgwqDCoCBudm1lX3B1dF9uc19oZWFkKG5zLT5oZWFkKTsKPj4gwqDC
oCBvdXRfZnJlZV9xdWV1ZToKPj4gQEAgLTM4MjgsOCArMzgyOSw2IEBAIHN0YXRpYyB2b2lkIG52
bWVfbnNfcmVtb3ZlKHN0cnVjdCBudm1lX25zICpucykKPj4gwqDCoMKgwqDCoCBtdXRleF9sb2Nr
KCZucy0+Y3RybC0+c3Vic3lzLT5sb2NrKTsKPj4gwqDCoMKgwqDCoCBsaXN0X2RlbF9yY3UoJm5z
LT5zaWJsaW5ncyk7Cj4+IC3CoMKgwqAgaWYgKGxpc3RfZW1wdHkoJm5zLT5oZWFkLT5saXN0KSkK
Pj4gLcKgwqDCoMKgwqDCoMKgIGxpc3RfZGVsX2luaXQoJm5zLT5oZWFkLT5lbnRyeSk7Cj4+IMKg
wqDCoMKgwqAgbXV0ZXhfdW5sb2NrKCZucy0+Y3RybC0+c3Vic3lzLT5sb2NrKTsKPj4gwqDCoMKg
wqDCoCBzeW5jaHJvbml6ZV9yY3UoKTsgLyogZ3VhcmFudGVlIG5vdCBhdmFpbGFibGUgaW4gaGVh
ZC0+bGlzdCAqLwo+PiBAQCAtMzg0OSw3ICszODQ4LDcgQEAgc3RhdGljIHZvaWQgbnZtZV9uc19y
ZW1vdmUoc3RydWN0IG52bWVfbnMgKm5zKQo+PiDCoMKgwqDCoMKgIGxpc3RfZGVsX2luaXQoJm5z
LT5saXN0KTsKPj4gwqDCoMKgwqDCoCB1cF93cml0ZSgmbnMtPmN0cmwtPm5hbWVzcGFjZXNfcndz
ZW0pOwo+PiAtwqDCoMKgIG52bWVfbXBhdGhfY2hlY2tfbGFzdF9wYXRoKG5zKTsKPj4gK8KgwqDC
oCBudm1lX21wYXRoX2NoZWNrX2xhc3RfcGF0aChucy0+aGVhZCk7Cj4+IMKgwqDCoMKgwqAgbnZt
ZV9wdXRfbnMobnMpOwo+PiDCoCB9Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9t
dWx0aXBhdGguYyAKPj4gYi9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+PiBpbmRleCAy
MzU3M2ZlM2ZjN2QuLjMxMTUzZjZlYzU4MiAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9udm1lL2hv
c3QvbXVsdGlwYXRoLmMKPj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPj4g
QEAgLTI2Niw2ICsyNjYsOCBAQCBpbmxpbmUgc3RydWN0IG52bWVfbnMgKm52bWVfZmluZF9wYXRo
KHN0cnVjdCAKPj4gbnZtZV9uc19oZWFkICpoZWFkKQo+PiDCoMKgwqDCoMKgIGludCBub2RlID0g
bnVtYV9ub2RlX2lkKCk7Cj4+IMKgwqDCoMKgwqAgc3RydWN0IG52bWVfbnMgKm5zOwo+PiArwqDC
oMKgIGlmICghKGhlYWQtPmRpc2stPmZsYWdzICYgR0VOSERfRkxfVVApKQo+PiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIE5VTEw7Cj4+IMKgwqDCoMKgwqAgbnMgPSBzcmN1X2RlcmVmZXJlbmNlKGhl
YWQtPmN1cnJlbnRfcGF0aFtub2RlXSwgJmhlYWQtPnNyY3UpOwo+PiDCoMKgwqDCoMKgIGlmICh1
bmxpa2VseSghbnMpKQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIF9fbnZtZV9maW5kX3Bh
dGgoaGVhZCwgbm9kZSk7Cj4+IEBAIC0yODEsNiArMjgzLDggQEAgc3RhdGljIGJvb2wgbnZtZV9h
dmFpbGFibGVfcGF0aChzdHJ1Y3QgCj4+IG52bWVfbnNfaGVhZCAqaGVhZCkKPj4gwqAgewo+PiDC
oMKgwqDCoMKgIHN0cnVjdCBudm1lX25zICpuczsKPj4gK8KgwqDCoCBpZiAoIShoZWFkLT5kaXNr
LT5mbGFncyAmIEdFTkhEX0ZMX1VQKSkKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiBmYWxzZTsK
PiAKPiBudm1lX2F2YWlsYWJsZV9wYXRoIHNob3VsZCBoYXZlIG5vIGJ1c2luZXNzIGxvb2tpbmcg
YXQgdGhlIGhlYWQgZ2VuZGlzaywKPiBpdCBzaG91bGQganVzdCB1bmRlcnN0YW5kIGlmIGEgUEFU
SCAoYS5rLmEgYSBjb250cm9sbGVyKSBleGlzdHMuCj4gCkFncmVlZC4gSSB3YXMgb25seSBvdmVy
bHkgY2F1dGlvdXMgaGVyZTsgd2lsbCBiZSBkcm9wcGluZyB0aGlzIGNoZWNrLgoKPiBJTU8sIHRo
ZSBmYWN0IHRoYXQgaXQgZG9lcyBzaG91bGQgdGVsbCB0aGF0IHdlIHNob3VsZCB0YWtlIGEgc3Rl
cCBiYWNrCj4gYW5kIHRoaW5rIGFib3V0IHRoaXMuIFdlIGFyZSB0cnlpbmcgdG8ga2VlcCBhbiB6
b21iaWUgbnNoZWFkIGFyb3VuZAo+IGp1c3QgZm9yIHRoZSBwb3NzaWJpbGl0eSB0aGUgaG9zdCB3
aWxsIHJlY29ubmVjdCAobm90IGFzIHBhcnQgb2YKPiBlcnJvciByZWNvdmVyeSwgYnV0IGFzIGEg
YnJhbmQgbmV3IGNvbm5lY3QpLiBXaHkgc2hvdWxkbid0IHdlIGp1c3QKPiByZW1vdmUgaXQgYW5k
IHJlc3RvcmUgaXQgYXMgYSBicmFuZCBuZXcgbnNoZWFkIHdoZW4gdGhlIGhvc3QgYXR0YWNoZXMK
PiBhZ2Fpbj8KPiAKVGhpcyBwYXRjaCBoYXMgbm93IGV2b2x2ZWQgcXVpdGUgYSBiaXQsIGFuZCBp
biBmYWN0IGRpdmVyZ2VkIHNsaWdodGx5IApmcm9tIHRoZSBkZXNjcmlwdGlvbi4gVGhlIG9yaWdp
bmFsIGludGVudCBpbmRlZWQgd2FzIHRvIGtlZXAgdGhlIG5zaGVhZCAKYXJvdW5kIHVudGlsIHRo
ZSBsYXN0IHJlZmVyZW5jZSBkcm9wcywgc3VjaCB0aGF0IGlmIGEgY29udHJvbGxlciBnZXRzIApy
ZWF0dGFjaGVkIGl0IHdpbGwgYmUgYWJsZSB0byBjb25uZWN0IHRoZSBuYW1lc3BhY2VzIHRvIHRo
ZSBjb3JyZWN0IAooZXhpc3RpbmcpIG5zX2hlYWQuCkhvd2V2ZXIsIGFzIGl0IHR1cm5lZCBvdXQg
dGhpcyB3YXMganVzdCBhIGJhbmQtYWlkLCBhbmQgdGhlIHJlYWwgZml4IGlzIAp0byBnZXQgdGhl
IHJlZmVyZW5jZSBjb3VudHMgYmV0d2VlbiAnc3RydWN0IG5zJyBhbmQgJ3N0cnVjdCBuc19oZWFk
JyAKY29ycmVjdDogaWYgdGhlIGxhc3QgcGF0aCB0byBhIG5zX2hlYWQgZHJvcHMsIHdlIHNob3Vs
ZCBiZSByZW1vdmluZyB0aGUgCm5zX2hlYWQgYnkgY2FsbGluZyBkZWxfZ2VuZGlzaygpIGFuZCBy
ZW1vdmluZyBpdCBmcm9tIHRoZSBsaXN0IG9mIG5zX2hlYWRzLgoKQXMgbm90ZWQgYnkgS2VpdGgg
dGhlIGZpcnN0IHBhcnQgaXMgZG9uZSBjb3JyZWN0bHkgaW4gdGhpcyBwYXRjaCAobmFtZWx5IApk
ZWxfZ2VuZGlzaygpIGlzIGNhbGxlZCB3aGVuIHRoZSBsYXN0IHBhdGggZHJvcHMpLCBidXQgdGhl
IHNlY29uZCBiaXQgb2YgCmRldGFjaGluZyBpdCBmcm9tIHRoZSBsaXN0IG9mIG5zX2hlYWRzIGlz
IF9ub3RfIGRvbmUgY29ycmVjdGx5LgpCb3RoIHNob3VsZCBiZSBoYXBwZW5pbmcgYXQgdGhlIHNh
bWUgdGltZSB0byBhdm9pZCBhbnkgcmFjZSBjb25kaXRpb25zLgoKV2lsbCBiZSBzZW5kaW5nIGFu
IHVwZGF0ZWQgcGF0Y2guCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2Ug
ICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUg
U29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkg
KEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

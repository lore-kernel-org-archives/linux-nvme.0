Return-Path: <SRS0=LUST=DN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BAAC41604
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 05:48:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D91E2078A
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Oct 2020 05:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R62+EwJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D91E2078A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=SSENFfK3MqNA/m/i+N8G/NLArnOidKZUeByvDGlipes=; b=R62+EwJWWCR/L1vUSKzxbbAW3
	KBK9ZBZ3rDP7lVa56PIPiVZseh7wqqn9hqvwWvuJwLGNKI35dVmZnF4QbOQyFBZ5IilqQJgofZT7q
	h87xyFA85Z+O5qMhivmgJVL09XLQWwUR1s13UXprWAa6S/DeCmXzEvdh1dk9PscQVQKbvRbnPC39k
	WtoFzSUXl7eYwJvwa0cv7M4OroEk0vrxq89aRgqZU3gjPvT2uZjpCP3T8C4TXz+1IniG6B+f8mWdo
	qnjM5HKd7PYluUjInp1q5QGjYKNqf1hDEAkMySVQObo5bjdgGU/tv6u5zYzBf7kfhUit31MpUhqHJ
	sPBhLE8XA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPfqA-00051a-F8; Tue, 06 Oct 2020 05:48:46 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPfq7-000517-7L
 for linux-nvme@lists.infradead.org; Tue, 06 Oct 2020 05:48:44 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AEDA1AFDF;
 Tue,  6 Oct 2020 05:48:41 +0000 (UTC)
Subject: Re: [PATCH 2/2] nvme: add 'queue_if_no_path' semantics
To: Christoph Hellwig <hch@lst.de>
References: <20201005124500.6015-1-hare@suse.de>
 <20201005124500.6015-3-hare@suse.de> <20201005125201.GB1125@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <8d7d4803-5808-0839-ee4f-e36a12756497@suse.de>
Date: Tue, 6 Oct 2020 07:48:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201005125201.GB1125@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201006_014843_500029_13665C02 
X-CRM114-Status: GOOD (  33.50  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTAvNS8yMCAyOjUyIFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBPbiBNb24sIE9j
dCAwNSwgMjAyMCBhdCAwMjo0NTowMFBNICswMjAwLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4+
IEN1cnJlbnRseSBuYW1lc3BhY2VzIGJlaGF2ZSBkaWZmZXJlbnRseSBkZXBlbmRpbmcgb24gdGhl
ICdDTUlDJwo+PiBzZXR0aW5nLiBJZiBDTUlDIGlzIHplcm8sIHRoZSBkZXZpY2UgaXMgcmVtb3Zl
ZCBvbmNlIHRoZSBsYXN0IHBhdGgKPj4gZ29lcyBhd2F5LiBJZiBDTUlDIGhhcyB0aGUgbXVsdGlw
YXRoIGJpdCBzZXQsIHRoZSBkZXZpY2UgaXMgcmV0YWluZWQKPj4gZXZlbiBpZiB0aGUgbGFzdCBw
YXRoIGlzIHJlbW92ZWQuCj4+IFRoaXMgaXMgb2theSBmb3IgZmFicmljcywgd2hlcmUgb25lIGNh
biBkbyBhbiBleHBsaWNpdCBkaXNjb25uZWN0Cj4+IHRvIHJlbW92ZSB0aGUgZGV2aWNlLCBidXQg
Zm9yIG52bWUtcGNpIHRoaXMgaW5kdWNlcyBhIHJlZ3Jlc3Npb24KPj4gd2l0aCBQQ0kgaG90cGx1
Zy4KPj4gV2hlbiB0aGUgTlZNZSBkZXZpY2UgaXMgb3BlbmVkIChlZyBieSBNRCksIHRoZSBOVk1l
IGRldmljZSBpcyBub3QKPj4gcmVtb3ZlZCBhZnRlciBhIFBDSSBob3QtcmVtb3ZlLiBIZW5jZSBN
RCB3aWxsIG5vdCBiZSBub3RpZmllZCBhYm91dAo+PiB0aGUgZXZlbnQsIGFuZCB3aWxsIGNvbnRp
bnVlIHRvIGNvbnNpZGVyIHRoaXMgZGV2aWNlIGFzIG9wZXJhdGlvbmFsLgo+PiBDb25zZXF1ZW50
bHksIHVwb24gUENJIGhvdC1hZGQgdGhlIGRldmljZSBzaG93cyB1cCBhcyBhIG5ldyBOVk1lCj4+
IGRldmljZSwgYW5kIE1EIHdpbGwgZmFpbCB0byByZWF0dGFjaCB0aGUgZGV2aWNlLgo+PiBTbyB0
aGlzIHBhdGNoIGFkZHMgTlZNRV9OU0hFQURfUVVFVUVfSUZfTk9fUEFUSCBmbGFnIHRvIHRoZSBu
c2hlYWQKPj4gdG8gcmVzdG9yZSB0aGUgb3JpZ2luYWwgYmVoYXZpb3VyIGZvciBub24tZmFicmlj
cyBOVk1lIGRldmljZXMuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFy
ZUBzdXNlLmRlPgo+PiAtLS0KPj4gICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgICAgICB8IDEw
ICsrKysrKysrKy0KPj4gICBkcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYyB8IDM4ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCj4+ICAgZHJpdmVycy9udm1lL2hvc3Qv
bnZtZS5oICAgICAgfCAgMiArKwo+PiAgIDMgZmlsZXMgY2hhbmdlZCwgNDkgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29y
ZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+IGluZGV4IDQ0NTlhNDBiMDU3Yy4uZTIx
YzMyZWE0YjUxIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4gKysr
IGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCj4+IEBAIC00NzUsOCArNDc1LDExIEBAIHN0YXRp
YyB2b2lkIG52bWVfZnJlZV9uc19oZWFkKHN0cnVjdCBrcmVmICpyZWYpCj4+ICAgCQljb250YWlu
ZXJfb2YocmVmLCBzdHJ1Y3QgbnZtZV9uc19oZWFkLCByZWYpOwo+PiAgIAo+PiAgICNpZmRlZiBD
T05GSUdfTlZNRV9NVUxUSVBBVEgKPj4gLQlpZiAoaGVhZC0+ZGlzaykKPj4gKwlpZiAoaGVhZC0+
ZGlzaykgewo+PiArCQlpZiAodGVzdF9iaXQoTlZNRV9OU0hFQURfUVVFVUVfSUZfTk9fUEFUSCwg
JmhlYWQtPmZsYWdzKSkKPj4gKwkJCW52bWVfbXBhdGhfcmVtb3ZlX2Rpc2soaGVhZCk7Cj4+ICAg
CQlwdXRfZGlzayhoZWFkLT5kaXNrKTsKPj4gKwl9Cj4+ICAgI2VuZGlmCj4+ICAgCWlkYV9zaW1w
bGVfcmVtb3ZlKCZoZWFkLT5zdWJzeXMtPm5zX2lkYSwgaGVhZC0+aW5zdGFuY2UpOwo+PiAgIAlj
bGVhbnVwX3NyY3Vfc3RydWN0KCZoZWFkLT5zcmN1KTsKPj4gQEAgLTMzNTcsNiArMzM2MCw3IEBA
IHN0YXRpYyBzdHJ1Y3QgYXR0cmlidXRlICpudm1lX25zX2lkX2F0dHJzW10gPSB7Cj4+ICAgI2lm
ZGVmIENPTkZJR19OVk1FX01VTFRJUEFUSAo+PiAgIAkmZGV2X2F0dHJfYW5hX2dycGlkLmF0dHIs
Cj4+ICAgCSZkZXZfYXR0cl9hbmFfc3RhdGUuYXR0ciwKPj4gKwkmZGV2X2F0dHJfcXVldWVfaWZf
bm9fcGF0aC5hdHRyLAo+PiAgICNlbmRpZgo+PiAgIAlOVUxMLAo+PiAgIH07Cj4+IEBAIC0zMzg3
LDYgKzMzOTEsMTAgQEAgc3RhdGljIHVtb2RlX3QgbnZtZV9uc19pZF9hdHRyc19hcmVfdmlzaWJs
ZShzdHJ1Y3Qga29iamVjdCAqa29iaiwKPj4gICAJCWlmICghbnZtZV9jdHJsX3VzZV9hbmEobnZt
ZV9nZXRfbnNfZnJvbV9kZXYoZGV2KS0+Y3RybCkpCj4+ICAgCQkJcmV0dXJuIDA7Cj4+ICAgCX0K
Pj4gKwlpZiAoYSA9PSAmZGV2X2F0dHJfcXVldWVfaWZfbm9fcGF0aC5hdHRyKSB7Cj4+ICsJCWlm
IChkZXZfdG9fZGlzayhkZXYpLT5mb3BzID09ICZudm1lX2ZvcHMpCj4+ICsJCQlyZXR1cm4gMDsK
Pj4gKwl9Cj4+ICAgI2VuZGlmCj4+ICAgCXJldHVybiBhLT5tb2RlOwo+PiAgIH0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jIGIvZHJpdmVycy9udm1lL2hvc3Qv
bXVsdGlwYXRoLmMKPj4gaW5kZXggNTUwNDUyOTFiNGRlLi5iYmRhZDU5MTcxMTIgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0aC5jCj4+ICsrKyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L211bHRpcGF0aC5jCj4+IEBAIC0zODEsNiArMzgxLDkgQEAgaW50IG52bWVfbXBhdGhf
YWxsb2NfZGlzayhzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsLCBzdHJ1Y3QgbnZtZV9uc19oZWFkICpo
ZWFkKQo+PiAgIAkvKiBzZXQgdG8gYSBkZWZhdWx0IHZhbHVlIGZvciA1MTIgdW50aWwgZGlzayBp
cyB2YWxpZGF0ZWQgKi8KPj4gICAJYmxrX3F1ZXVlX2xvZ2ljYWxfYmxvY2tfc2l6ZShxLCA1MTIp
Owo+PiAgIAlibGtfc2V0X3N0YWNraW5nX2xpbWl0cygmcS0+bGltaXRzKTsKPj4gKwkvKiBFbmFi
bGUgcXVldWVfaWZfbm9fcGF0aCBzZW1hbnRpY3MgZm9yIGZhYnJpY3MgKi8KPj4gKwlpZiAoY3Ry
bC0+b3BzLT5mbGFncyAmIE5WTUVfRl9GQUJSSUNTKQo+PiArCQlzZXRfYml0KE5WTUVfTlNIRUFE
X1FVRVVFX0lGX05PX1BBVEgsICZoZWFkLT5mbGFncyk7Cj4gCj4gV2VsbCwgdGhhdCBpcyBibGlu
ZGx5IG9idmlvdXMgZnJvbSB0aGUgY29kZS4gIEJ1dCB3aHkgd291bGQgd2UgdHJlYXQKPiBmYWJy
aWNzIHNwZWNpYWw/Cj4gCldlbGwsIGJlY2F1c2UgaXQncyBlc3RhYmxpc2hlZCBiZWhhdmlvdXIg
b2YgdGhlIGN1cnJlbnQgY29kZS4KQ2hhbmdpbmcgaXQgbm93IGhhcyB0aGUgcG90ZW50aWFsIHRv
IGJyZWFrIGV4aXN0aW5nIHNjZW5hcmlvcy4KCkZvciBQQ0kgKGllIG5vbi1mYWJyaWNzKSB0aGUg
Y3VycmVudCBiZWhhdmlvdXIgaXMgYXJndWFibHkgYSBjb3JuZXIgY2FzZSAKKGFzIG9uZSBuZWVk
cyB0byBoYXZlIGEgUENJLU5WTWUgd2l0aCBDTUlDIGJpdCBzZXQpLCBidXQgb25jZSB5b3UgaGF2
ZSAKaXQgUENJIGhvdHBsdWcgaXMgZG9uZSBmb3IuIFNvIHRoZXJlIHdlIHJlYWxseSB3YW50IHRv
IGNoYW5nZSB0aGUgCmJlaGF2aW91ciB0byBnZXQgdGhlIHNhbWUgdXNlciBleHBlcmllbmNlIGZv
ciBhbGwgTlZNZSBkcml2ZXMuCgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVj
a2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdh
cmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4
MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

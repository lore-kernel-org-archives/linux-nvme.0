Return-Path: <SRS0=KsQz=E6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E7C4C56201
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 14:04:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC9F7206FB
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2020 14:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YI80kLvu";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3Gr4luE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC9F7206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JCzFsZiu44lu1Mm3i1NNHxxhYvN1VqDE3OfVDjLxkU8=; b=YI80kLvudVjN/RKptn8XbgUPL
	Ua/Pedn9aVMlpVS4IRqfbrwlVk31XSy6YYGTZmvJ/kXcTOElYxrjbyUbMDyiXXBHJk//Up5Z8LQVP
	+L3zoeZh5GLtyBUZ4E3EZ5DzK5GCvKa4zJFL0P0pGvH6DMCO2pjnt7JuYtzyL37kxOlcXCLYyZY7p
	ehYgzjp1KKMYoS4fUadqYMImCfUnF8k95/E7hTbI0PQ0gvDZuQsHNRQbKeudZ2cRd9ck3AriJIgcQ
	4UK5drIIDmffGkY6VGHEf8vjxh2VtniHuMJVnsvWWv36W4pbLgSipTOqIhoS2BOg3oTKYZgZsSj+p
	3r7OPfEag==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khYvt-0002E0-Do; Tue, 24 Nov 2020 14:04:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khYvr-0002DS-R7
 for linux-nvme@lists.infradead.org; Tue, 24 Nov 2020 14:04:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606226675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cu0ognzQ+lIIPUcy1xCELQQzHBoxXk/kFczCzP+30wE=;
 b=b3Gr4luELmhAQTFKopFm+deJ5lJ44Pui0vsRPjD6YI7G+jlDtXoa09tvD9IWMF55JygfyV
 ZoWEzi5wmEzKCPy9DO8dPoXCctpueD0r1GpAHZ/quldUZDoDKSKQmVSR3jAIc+gIZrwHA4
 pOUvjY60b3fx20gPbzMmK7LgPrFfigQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-Jh-8X8F1MXuYFRStvRtWdw-1; Tue, 24 Nov 2020 09:04:32 -0500
X-MC-Unique: Jh-8X8F1MXuYFRStvRtWdw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A70078145F3;
 Tue, 24 Nov 2020 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 669AD60BE5;
 Tue, 24 Nov 2020 14:04:29 +0000 (UTC)
Subject: Re: [PATCH blktests 2/5] tests/nvmeof-mp/rc: run nvmeof-mp tests if
 we set multipath=N
To: Bart Van Assche <bvanassche@acm.org>, osandov@osandov.com
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-3-yi.zhang@redhat.com>
 <324d227a-7ba2-309f-4298-ea787dfb76c0@acm.org>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <04404583-9b7c-571d-7680-9b5253258268@redhat.com>
Date: Tue, 24 Nov 2020 22:04:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <324d227a-7ba2-309f-4298-ea787dfb76c0@acm.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201124_090435_976234_D2F1F242 
X-CRM114-Status: GOOD (  22.64  )
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
Cc: linux-block@vger.kernel.org, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAxMS8yNC8yMCAxMToyNiBBTSwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOgo+IE9uIDExLzIz
LzIwIDU6MDQgUE0sIFlpIFpoYW5nIHdyb3RlOgo+PiBUbyBlbmFibGUgaXQsIGp1c3QgZG8gYmVs
bG93IHN0ZXAgYmVmb3JlIHdlIHJ1biBpdDoKPj4gJCBlY2hvICJvcHRpb25zIG52bWVfY29yZSBt
dWx0aXBhdGg9TiIgPi9ldGMvbW9kcHJvYmUuZC9udm1lLmNvbmYKPj4KPj4gU2lnbmVkLW9mZi1i
eTogWWkgWmhhbmcgPHlpLnpoYW5nQHJlZGhhdC5jb20+Cj4+IC0tLQo+PiAgIHRlc3RzL252bWVv
Zi1tcC9yYyB8IDIgKy0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL252bWVvZi1tcC9yYyBiL3Rlc3RzL252
bWVvZi1tcC9yYwo+PiBpbmRleCBkN2E3Yzg3Li5iYzc4ZjE0IDEwMDc1NQo+PiAtLS0gYS90ZXN0
cy9udm1lb2YtbXAvcmMKPj4gKysrIGIvdGVzdHMvbnZtZW9mLW1wL3JjCj4+IEBAIC0xNyw3ICsx
Nyw3IEBAIGdyb3VwX3JlcXVpcmVzKCkgewo+PiAgIAkjIFNpbmNlIHRoZSBudm1lb2YtbXAgdGVz
dHMgYXJlIGJhc2VkIG9uIHRoZSBkbS1tcGF0aCBkcml2ZXIsIHRoZXNlCj4+ICAgCSMgdGVzdHMg
YXJlIGluY29tcGF0aWJsZSB3aXRoIHRoZSBOVk1FX01VTFRJUEFUSCBrZXJuZWwgY29uZmlndXJh
dGlvbgo+PiAgIAkjIG9wdGlvbi4KPj4gLQlpZiBfaGF2ZV9rZXJuZWxfb3B0aW9uIE5WTUVfTVVM
VElQQVRIOyB0aGVuCj4+ICsJaWYgX2hhdmVfa2VybmVsX29wdGlvbiBOVk1FX01VTFRJUEFUSCAm
JiBfaGF2ZV9tb2R1bGVfcGFyYW1fdmFsdWUgbnZtZV9jb3JlIG11bHRpcGF0aCBZOyB0aGVuCj4+
ICAgCQlTS0lQX1JFQVNPTj0iQ09ORklHX05WTUVfTVVMVElQQVRIIGhhcyBiZWVuIHNldCBpbiAu
Y29uZmlnIgo+PiAgIAkJcmV0dXJuCj4+ICAgCWZpCj4gUGxlYXNlIHNldCBkaWZmZXJlbnQgU0tJ
UF9SRUFTT04gc3RyaW5nIGZvciBlYWNoIGNhc2Ugc3VjaCB0aGF0IGl0Cj4gcmVtYWlucyBlYXN5
IGZvciBhIGJsa3Rlc3RzIHVzZXIgdG8gZmlndXJlIG91dCB3aHkgdGhlc2UgdGVzdHMgaGF2ZSBi
ZWVuCj4gc2tpcHBlZC4KRG8geW91IG1lYW4gc29tZXRoaW5nIGxpa2UgdGhpcywgY291bGQgeW91
IGFkZCBtb3JlIGRldGFpbCBoZXJlLCB0aGFua3MuCgpkaWZmIC0tZ2l0IGEvdGVzdHMvbnZtZW9m
LW1wL3JjIGIvdGVzdHMvbnZtZW9mLW1wL3JjCmluZGV4IGQ3YTdjODcuLmFmNzAwZDkgMTAwNzU1
Ci0tLSBhL3Rlc3RzL252bWVvZi1tcC9yYworKysgYi90ZXN0cy9udm1lb2YtbXAvcmMKQEAgLTE2
LDkgKzE2LDkgQEAgZ3JvdXBfcmVxdWlyZXMoKSB7CgogwqDCoMKgwqDCoMKgwqAgIyBTaW5jZSB0
aGUgbnZtZW9mLW1wIHRlc3RzIGFyZSBiYXNlZCBvbiB0aGUgZG0tbXBhdGggZHJpdmVyLCB0aGVz
ZQogwqDCoMKgwqDCoMKgwqAgIyB0ZXN0cyBhcmUgaW5jb21wYXRpYmxlIHdpdGggdGhlIE5WTUVf
TVVMVElQQVRIIGtlcm5lbCAKY29uZmlndXJhdGlvbgotwqDCoMKgwqDCoMKgICMgb3B0aW9uLgot
wqDCoMKgwqDCoMKgIGlmIF9oYXZlX2tlcm5lbF9vcHRpb24gTlZNRV9NVUxUSVBBVEg7IHRoZW4K
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU0tJUF9SRUFTT049IkNPTkZJR19OVk1FX01V
TFRJUEFUSCBoYXMgYmVlbiBzZXQgaW4gLmNvbmZpZyIKK8KgwqDCoMKgwqDCoCAjIG9wdGlvbiBh
bmQgbnZtZV9jb3JlOiBtdWx0aXBhdGggc2V0IHdpdGggWS4KK8KgwqDCoMKgwqDCoCBpZiBfaGF2
ZV9rZXJuZWxfb3B0aW9uIE5WTUVfTVVMVElQQVRIICYmIApfaGF2ZV9tb2R1bGVfcGFyYW1fdmFs
dWUgbnZtZV9jb3JlIG11bHRpcGF0aCBZOyB0aGVuCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFNLSVBfUkVBU09OPSJDT05GSUdfTlZNRV9NVUxUSVBBVEggaGFzIGJlZW4gc2V0IGluIAou
Y29uZmlnIGFuZCBudm1lX2NvcmU6IG11bHRpcGF0aCBzaG91bGQgYmUgc2V0IHdpdGggTiIKIMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4KIMKgwqDCoMKgwqDCoMKgIGZpCgoK
PiBUaGFua3MsCj4KPiBCYXJ0Lgo+Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KPiBMaW51eC1udm1lIG1haWxpbmcgbGlzdAo+IExpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo+CgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtbnZtZQo=

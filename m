Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B93C433E1
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:46:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413C22065C
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 15:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OGEo88Oh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1kip7FV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413C22065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cAU24ndsJZ4k5V+9vMsUgTTT7+p/cDXLh1hdHEbyoiw=; b=OGEo88OhnZDF9v7AX6EXuVVmj
	ftaMNvJj+5WyP2tmf9ygArhZ73Qc1cCJ4xQnEPSuNRQ4GDunOV5JzHHNMJ6tSV5GjX5iS+K19bqKI
	cQAozg7VP5d3NACULuuEx+fj3cMPuzWdug4qDL1IXIlC2mGiFA9XFvhlSr8LzCNMiXaOIUG3VynjB
	jgjTp1OCgyuCLstDlZ643k41KaIL50LWkkVt0lvy1WR0Zb0fzd6MmGZYTWq9r2beejFXYrc1yiR+t
	nVc2vq4IuxtXxc0/2oHmORbuIutOcvaW9AUhsN3Pl8v/omg/hBZ3MFCi5HfLR2LWwpFeDi+kcXjTj
	HBZ/9rfpQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6bu7-0008JR-C2; Fri, 14 Aug 2020 15:46:03 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6bu3-0008IY-Sr
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 15:46:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597419957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eKDr8V++g7/yk+XCg0clVAb/RZiCvMEN4qwAHQm7bcc=;
 b=e1kip7FVF6DMpqXIlFFDtVDeQ5GJvNgdN3zqffICv2wb+FyxkVzdo7lKzAVZpWtGWfGbEC
 im8LnM5Fr9dk9lhKv3DrOaU1XY2n07CoVBPlqSYGXEAiMEYhuWK3hjVySUyyPoBT0eDL7f
 uvIbgyxhXcU2vjQ55isfzO+AmrU63vw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-4pRitTtyPmOrbZHyR1dLXw-1; Fri, 14 Aug 2020 11:45:53 -0400
X-MC-Unique: 4pRitTtyPmOrbZHyR1dLXw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A16C1005E5B;
 Fri, 14 Aug 2020 15:45:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-61.pek2.redhat.com [10.72.12.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 230F75C1BD;
 Fri, 14 Aug 2020 15:45:48 +0000 (UTC)
Subject: Re: [PATCH v4 7/7] nvme: support rdma transport type
From: Yi Zhang <yi.zhang@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
References: <20200814061815.536540-1-sagi@grimberg.me>
 <20200814061815.536540-8-sagi@grimberg.me>
 <ffcaf9e2-083c-9601-16bd-054c3bd3b94c@redhat.com>
Message-ID: <af7154de-f2bb-fde6-4c6c-243711f971cb@redhat.com>
Date: Fri, 14 Aug 2020 23:45:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <ffcaf9e2-083c-9601-16bd-054c3bd3b94c@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_114600_015631_E6C63108 
X-CRM114-Status: GOOD (  19.43  )
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
Cc: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA4LzE0LzIwIDY6NDkgUE0sIFlpIFpoYW5nIHdyb3RlOgo+Cj4KPiBPbiA4LzE0LzIwIDI6
MTggUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJl
cmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4+IC0tLQo+PiDCoCB0ZXN0cy9udm1lL3JjIHwgMTUgKysr
KysrKysrKysrKysrCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspCj4+Cj4+
IGRpZmYgLS1naXQgYS90ZXN0cy9udm1lL3JjIGIvdGVzdHMvbnZtZS9yYwo+PiBpbmRleCAzZTk3
ODAxYmJiMzAuLjY3NWFjYmZhNzAxMiAxMDA2NDQKPj4gLS0tIGEvdGVzdHMvbnZtZS9yYwo+PiAr
KysgYi90ZXN0cy9udm1lL3JjCj4+IEBAIC01LDYgKzUsNyBAQAo+PiDCoCAjIFRlc3Qgc3BlY2lm
aWMgdG8gTlZNZSBkZXZpY2VzCj4+IMKgIMKgIC4gY29tbW9uL3JjCj4+ICsuIGNvbW1vbi9tdWx0
aXBhdGgtb3Zlci1yZG1hCj4+IMKgIMKgIGRlZl90cmFkZHI9IjEyNy4wLjAuMSIKPj4gwqAgZGVm
X2FkcmZhbT0iaXB2NCIKPj4gQEAgLTI1LDYgKzI2LDEyIEBAIF9udm1lX3JlcXVpcmVzKCkgewo+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgX2hhdmVfbW9kdWxlcyBudm1ldCBudm1lLWNvcmUgbnZtZS10
Y3AgbnZtZXQtdGNwCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBfaGF2ZV9jb25maWdmcwo+PiDCoMKg
wqDCoMKgwqDCoMKgwqAgOzsKPj4gK8KgwqDCoCByZG1hKQo+PiArwqDCoMKgwqDCoMKgwqAgX2hh
dmVfbW9kdWxlcyBudm1ldCBudm1lLWNvcmUgbnZtZS1yZG1hIG52bWV0LXJkbWEKPj4gK8KgwqDC
oMKgwqDCoMKgIF9oYXZlX2NvbmZpZ2ZzCj4+ICvCoMKgwqDCoMKgwqDCoCBfaGF2ZV9wcm9ncmFt
IHJkbWEKPj4gK8KgwqDCoMKgwqDCoMKgIF9oYXZlX21vZHVsZXMgcmRtYV9yeGUgc2l3Cj4KPiBz
dGFydF9zb2Z0X3JkbWEgY2FuIHVzZSBzaXcgb3IgcmRtYV9yeGUoZGVmYXVsdCBvbmUpIG1vZHVs
ZSwgYnV0IHNvbWUgCj4gb2xkIGRpc3Ryb3MgbWF5IG5vdCBzdXBwb3J0IHNpdywgYnV0IHN1cHBv
ciByZG1hX3J4ZS4KPiBob3cgYWJvdXQ6Cj4gX2hhdmVfbW9kdWxlcyByZG1hX3J4ZSB8fCBfaGF2
ZV9tb2R1bGVzIHNpdwo+PiArwqDCoMKgwqDCoMKgwqAgOzsKPj4gwqDCoMKgwqDCoCAqKQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgU0tJUF9SRUFTT049InVuc3VwcG9ydGVkIG52bWVfdHJ0eXBlPSR7
bnZtZV90cnR5cGV9Igo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIDEKPj4gQEAgLTExNSw2
ICsxMjIsOSBAQCBfY2xlYW51cF9udm1ldCgpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIG1vZHBy
b2JlIC1yIG52bWV0LSR7bnZtZV90cnR5cGV9IDI+L2Rldi9udWxsCj4+IMKgwqDCoMKgwqAgZmkK
Pj4gwqDCoMKgwqDCoCBtb2Rwcm9iZSAtciBudm1ldCAyPi9kZXYvbnVsbAo+PiArwqDCoMKgIGlm
IFtbICIke252bWVfdHJ0eXBlfSIgPT0gInJkbWEiIF1dOyB0aGVuCj4+ICvCoMKgwqDCoMKgwqDC
oCBzdG9wX3NvZnRfcmRtYQo+PiArwqDCoMKgIGZpCj4+IMKgIH0KPj4gwqAgwqAgX3NldHVwX252
bWV0KCkgewo+PiBAQCAtMTI0LDYgKzEzNCwxMSBAQCBfc2V0dXBfbnZtZXQoKSB7Cj4+IMKgwqDC
oMKgwqDCoMKgwqDCoCBtb2Rwcm9iZSBudm1ldC0ke252bWVfdHJ0eXBlfQo+PiDCoMKgwqDCoMKg
IGZpCj4+IMKgwqDCoMKgwqAgbW9kcHJvYmUgbnZtZS0ke252bWVfdHJ0eXBlfQo+PiArwqDCoMKg
IGlmIFtbICIke252bWVfdHJ0eXBlfSIgPT0gInJkbWEiIF1dOyB0aGVuCj4+ICvCoMKgwqDCoMKg
wqDCoCBzdGFydF9zb2Z0X3JkbWEKPj4gK8KgwqDCoMKgwqDCoMKgIHJkbWFfaW50ZnM9JChyZG1h
X25ldHdvcmtfaW50ZXJmYWNlcykKPj4gK8KgwqDCoMKgwqDCoMKgIGRlZl90cmFkZHI9JChnZXRf
aXB2NF9hZGRyICR7cmRtYV9pbnRmc1swXX0pClRoZSBmaXJzdCByZG1hX2ludGZzIGhlcmUgbWF5
YmUgaGF2ZSBET1dOIHN0YXRlLCB3aGljaCBkb2Vzbid0IGhhdmUgYW4gCmFkZHJbMV0sIEkgZm91
bmQgc2ltaWxhciBjaGVjayBjb2RlIGhlcmVbMl0KWzFdCiMgZWNobyAkcmRtYV9pbnRmcwpyZG1h
X2ludGZzOmVubzEKZW5vMgplbm8zCmVubzQKZW5vNDkKZW5vNTAKIyBbcm9vdEBocGUtZGwzODBn
ZW45LTAxIGJsa3Rlc3RzXSMgaXAgYSBzCjE6IGxvOiA8TE9PUEJBQ0ssVVAsTE9XRVJfVVA+IG10
dSA2NTUzNiBxZGlzYyBub3F1ZXVlIHN0YXRlIFVOS05PV04gCmdyb3VwIGRlZmF1bHQgcWxlbiAx
MDAwCiDCoMKgwqAgbGluay9sb29wYmFjayAwMDowMDowMDowMDowMDowMCBicmQgMDA6MDA6MDA6
MDA6MDA6MDAKIMKgwqDCoCBpbmV0IDEyNy4wLjAuMS84IHNjb3BlIGhvc3QgbG8KIMKgwqDCoMKg
wqDCoCB2YWxpZF9sZnQgZm9yZXZlciBwcmVmZXJyZWRfbGZ0IGZvcmV2ZXIKIMKgwqDCoCBpbmV0
NiA6OjEvMTI4IHNjb3BlIGhvc3QKIMKgwqDCoMKgwqDCoCB2YWxpZF9sZnQgZm9yZXZlciBwcmVm
ZXJyZWRfbGZ0IGZvcmV2ZXIKMjogZW5vMTogPE5PLUNBUlJJRVIsQlJPQURDQVNULE1VTFRJQ0FT
VCxVUD4gbXR1IDE1MDAgcWRpc2MgbXEgc3RhdGUgCkRPV04gZ3JvdXAgZGVmYXVsdCBxbGVuIDEw
MDAKIMKgwqDCoCBsaW5rL2V0aGVyIDNjOmE4OjJhOjIxOjdkOmE0IGJyZCBmZjpmZjpmZjpmZjpm
ZjpmZgozOiBlbm80OTogPEJST0FEQ0FTVCxNVUxUSUNBU1QsVVAsTE9XRVJfVVA+IG10dSAxNTAw
IHFkaXNjIG1xIHN0YXRlIFVQIApncm91cCBkZWZhdWx0IHFsZW4gMTAwMAogwqDCoMKgIGxpbmsv
ZXRoZXIgOGM6ZGM6ZDQ6MWU6N2E6NzggYnJkIGZmOmZmOmZmOmZmOmZmOmZmCiDCoMKgwqAgaW5l
dCAxMC4xNi4yMDMuMjcvMjQgYnJkIDEwLjE2LjIwMy4yNTUgc2NvcGUgZ2xvYmFsIGR5bmFtaWMg
Cm5vcHJlZml4cm91dGUgZW5vNDkKIMKgwqDCoMKgwqDCoCB2YWxpZF9sZnQgODQ4MTRzZWMgcHJl
ZmVycmVkX2xmdCA4NDgxNHNlYwogwqDCoMKgIGluZXQ2IDI2MjA6NTI6MDoxMGNiOjhlZGM6ZDRm
ZjpmZTFlOjdhNzgvNjQgc2NvcGUgZ2xvYmFsIGR5bmFtaWMgCm5vcHJlZml4cm91dGUKIMKgwqDC
oMKgwqDCoCB2YWxpZF9sZnQgMjU5MTk3OHNlYyBwcmVmZXJyZWRfbGZ0IDYwNDc3OHNlYwogwqDC
oMKgIGluZXQ2IGZlODA6OjhlZGM6ZDRmZjpmZTFlOjdhNzgvNjQgc2NvcGUgbGluayBub3ByZWZp
eHJvdXRlCiDCoMKgwqDCoMKgwqAgdmFsaWRfbGZ0IGZvcmV2ZXIgcHJlZmVycmVkX2xmdCBmb3Jl
dmVyClsyXQojIGdyZXAgLXJpbiByZG1hX25ldHdvcmtfIHRlc3RzL252bWVvZi1tcC8KdGVzdHMv
bnZtZW9mLW1wL3JjOjkzOsKgwqDCoCDCoMKgwqAgZm9yIGkgaW4gJChyZG1hX25ldHdvcmtfaW50
ZXJmYWNlcyk7IGRvCnRlc3RzL252bWVvZi1tcC9yYzoyMzU6wqDCoMKgIMKgwqDCoCApICYmIGZv
ciBpIGluICQocmRtYV9uZXR3b3JrX2ludGVyZmFjZXMpOyBkbwoKPj4gK8KgwqDCoCBmaQo+PiDC
oCB9Cj4+IMKgIMKgIF9udm1lX2Rpc2Nvbm5lY3RfY3RybCgpIHsKPgo+Cj4gX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPiBMaW51eC1udm1lIG1haWxpbmcg
bGlzdAo+IExpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo+CgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

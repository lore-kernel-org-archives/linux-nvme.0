Return-Path: <SRS0=cokh=E7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5045C56201
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 07:37:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B352206B5
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2020 07:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iX4g7bw9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RqW9uxkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B352206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5Tg9YyUvHEhqy0jiOd5C3ROD8rZYCBCXNfwIufEYWcw=; b=iX4g7bw9eogBY9ZhHuzbGqk0H
	2bohzfg4eGvyCrK818ns+nO3DBCA5pqPSd+4Gx4oD5HlJEzgulpAOGRFNfn2jWzQLj3kR9moTO8KI
	Y0ixL++cUIZpqYnNxxitciv+s4AXIwSYmi4E8d324hSPV4iTGqnAf07Ec6lduftegGk8GL9NxC4lx
	6Z0Z8z7wQpI5+Hif1HpWUxudpsEQUbLPYvR1JYyfOcfTytAQ8n89r7WjOZnlHFauk+R5LSDicjuEO
	fIbkjTg6SLBBkqwo+lH8HxmI6Y554hYf55LJ3MvYAQ/RAEoSPdGmKVLtjdy9sqoliM8anstb+zG0r
	5RxWBdGFQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1khpMO-0000rE-5A; Wed, 25 Nov 2020 07:37:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1khpML-0000pt-3c
 for linux-nvme@lists.infradead.org; Wed, 25 Nov 2020 07:37:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606289820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UE7tmWp3B3FPpWAh4AE1RxaTN+NE6wJBTbnmF01pz3M=;
 b=RqW9uxkdCCDmRa3zD3BhaVwO/nkPreoSZdpEB/54Q1KZq9PRVEmrhSY84txmHffh94c38b
 3VD8GwKVHAgE6YFHAanFyzvRyf0Rq0NHhNipNRGbqh0p9BmWCUMyRqTSV34yhow3U34Fqg
 hCknnc9JkhhoMc90oaZ/oiIRzC/+Fz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-z6liXsrFPQGLqE7u9Ir4bg-1; Wed, 25 Nov 2020 02:36:58 -0500
X-MC-Unique: z6liXsrFPQGLqE7u9Ir4bg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04F425226;
 Wed, 25 Nov 2020 07:36:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-67.pek2.redhat.com [10.72.12.67])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 07B1960C43;
 Wed, 25 Nov 2020 07:36:54 +0000 (UTC)
Subject: Re: [PATCH blktests 2/5] tests/nvmeof-mp/rc: run nvmeof-mp tests if
 we set multipath=N
To: Bart Van Assche <bvanassche@acm.org>, osandov@osandov.com
References: <20201124010427.18595-1-yi.zhang@redhat.com>
 <20201124010427.18595-3-yi.zhang@redhat.com>
 <324d227a-7ba2-309f-4298-ea787dfb76c0@acm.org>
 <04404583-9b7c-571d-7680-9b5253258268@redhat.com>
 <3da24cd0-5127-a6e7-ec1d-848c61b12946@acm.org>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <98f3e7fa-d5a7-99f4-5778-72f74f5f3885@redhat.com>
Date: Wed, 25 Nov 2020 15:36:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3da24cd0-5127-a6e7-ec1d-848c61b12946@acm.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_023701_309109_DB24C806 
X-CRM114-Status: GOOD (  20.08  )
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

CgpPbiAxMS8yNS8yMCAxMTo1MSBBTSwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOgo+IE9uIDExLzI0
LzIwIDY6MDQgQU0sIFlpIFpoYW5nIHdyb3RlOgo+PiBEbyB5b3UgbWVhbiBzb21ldGhpbmcgbGlr
ZSB0aGlzLCBjb3VsZCB5b3UgYWRkIG1vcmUgZGV0YWlsIGhlcmUsIHRoYW5rcy4KPj4KPj4gZGlm
ZiAtLWdpdCBhL3Rlc3RzL252bWVvZi1tcC9yYyBiL3Rlc3RzL252bWVvZi1tcC9yYwo+PiBpbmRl
eCBkN2E3Yzg3Li5hZjcwMGQ5IDEwMDc1NQo+PiAtLS0gYS90ZXN0cy9udm1lb2YtbXAvcmMKPj4g
KysrIGIvdGVzdHMvbnZtZW9mLW1wL3JjCj4+IEBAIC0xNiw5ICsxNiw5IEBAIGdyb3VwX3JlcXVp
cmVzKCkgewo+Pgo+PiAgwqDCoMKgwqDCoMKgwqAgIyBTaW5jZSB0aGUgbnZtZW9mLW1wIHRlc3Rz
IGFyZSBiYXNlZCBvbiB0aGUgZG0tbXBhdGggZHJpdmVyLCB0aGVzZQo+PiAgwqDCoMKgwqDCoMKg
wqAgIyB0ZXN0cyBhcmUgaW5jb21wYXRpYmxlIHdpdGggdGhlIE5WTUVfTVVMVElQQVRIIGtlcm5l
bAo+PiBjb25maWd1cmF0aW9uCj4+IC3CoMKgwqDCoMKgwqAgIyBvcHRpb24uCj4+IC3CoMKgwqDC
oMKgwqAgaWYgX2hhdmVfa2VybmVsX29wdGlvbiBOVk1FX01VTFRJUEFUSDsgdGhlbgo+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBTS0lQX1JFQVNPTj0iQ09ORklHX05WTUVfTVVMVElQ
QVRIIGhhcyBiZWVuIHNldCBpbiAuY29uZmlnIgo+PiArwqDCoMKgwqDCoMKgICMgb3B0aW9uIGFu
ZCBudm1lX2NvcmU6IG11bHRpcGF0aCBzZXQgd2l0aCBZLgo+PiArwqDCoMKgwqDCoMKgIGlmIF9o
YXZlX2tlcm5lbF9vcHRpb24gTlZNRV9NVUxUSVBBVEggJiYKPj4gX2hhdmVfbW9kdWxlX3BhcmFt
X3ZhbHVlIG52bWVfY29yZSBtdWx0aXBhdGggWTsgdGhlbgo+PiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBTS0lQX1JFQVNPTj0iQ09ORklHX05WTUVfTVVMVElQQVRIIGhhcyBiZWVuIHNl
dCBpbgo+PiAuY29uZmlnIGFuZCBudm1lX2NvcmU6IG11bHRpcGF0aCBzaG91bGQgYmUgc2V0IHdp
dGggTiIKPj4gIMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4KPj4gIMKgwqDC
oMKgwqDCoMKgIGZpCj4gSSBtYXkgaGF2ZSBzZW50IHlvdSBpbiB0aGUgd3JvbmcgZGlyZWN0aW9u
LiBUaGlzIGlzIHdoYXQgSSBtZWFudDoKPgo+IAlpZiBfaGF2ZV9rZXJuZWxfb3B0aW9uIE5WTUVf
TVVMVElQQVRIICYmCj4gCSAgICBfaGF2ZV9tb2R1bGVfcGFyYW1fdmFsdWUgbnZtZV9jb3JlIG11
bHRpcGF0aCBZOyB0aGVuCj4gCSAgICBTS0lQX1JFQVNPTj0iQ09ORklHX05WTUVfTVVMVElQQVRI
IGhhcyBiZWVuIHNldCBpbiAuY29uZmlnIGFuZAo+IG11bHRpcGF0aGluZyBoYXMgYmVlbiBlbmFi
bGVkIGluIHRoZSBudm1lX2NvcmUga2VybmVsIG1vZHVsZSIKPiAJICAgIHJldHVybgo+IAlmaQpV
cGRhdGVkIG9uIFYyLCB0aGFua3MgZm9yIHRoZSByZXZpZXcuCgo+IFRoYW5rcywKPgo+IEJhcnQu
Cj4KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+IExp
bnV4LW52bWUgbWFpbGluZyBsaXN0Cj4gTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCj4g
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCgoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZt
ZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

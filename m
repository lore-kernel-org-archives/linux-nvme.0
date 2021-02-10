Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B65EC433E9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 02:52:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E96864D79
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 02:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E96864D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VF35AtgNs3KUAfmM9gFZ0FuLBVR2VSWXfLaWhc024V8=; b=fRj/L00uPRBiuddi8uljlBVYa
	4aN4GIoraXaXypgLD44Ifi6CUgeEvWHx5UwvLiy2xIbMKXvsdIO3B2wJtDha+CwKyMMq3WKiXF6yC
	SAF9C2YMESvSNoHQebt5l9j1glUvRv5VG3ww4ljVbmxrUHTrhy6Me4mgbWF7zaOgINdG2FzctvDg3
	33JgA73wjx//pdcdyRW33yGmJ0xhOQbXEYNUtNKHg4rJJEm59YG3xxlrKWeqbd3z/39N1IMD4/p71
	ot/oTIJV+jGpLp2oJXnA3B/ZqdR4Gv8nJbfjO7t553PAeKFcgctb0h9FEH8aok9k06sWDebWkrdgK
	l/ed9/K7w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9fc0-0004os-Ry; Wed, 10 Feb 2021 02:52:16 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9fbx-0004oI-Fn
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 02:52:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612925532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m7QlwtWzS30BuWDFO152uPTfPDucm0b2WCax1pbe3PM=;
 b=UxbhAmHK6aHTp1FKLXSCHu4OmzGchvRp+AJF0iKpydI3XOozkgnvHLdKpNhWKEy9pctRkv
 YAF282i37SwUixuTAuMf9WqCoL3TBfw7viELGMuUilZzOLhzV3nnP2WorDMPcV3mUpC2LX
 TMRrRSl9RirxWJseYnzFA3295qQiwLA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-ythgTaurMiyeIOxVDHKsHQ-1; Tue, 09 Feb 2021 21:52:10 -0500
X-MC-Unique: ythgTaurMiyeIOxVDHKsHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30F1E107ACE6;
 Wed, 10 Feb 2021 02:52:09 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-90.pek2.redhat.com [10.72.12.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A218060C4D;
 Wed, 10 Feb 2021 02:51:59 +0000 (UTC)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block <linux-block@vger.kernel.org>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <a88fd4c8-8d5c-6934-39bc-5c864e3ed84f@grimberg.me>
 <aec13f12-640c-77d5-bbdd-b4a3e18f1bf2@redhat.com>
 <6ae16841-5f51-617a-aab7-666b7eed299c@grimberg.me>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <1a520912-ac7c-1a3c-c432-b382a5da6177@redhat.com>
Date: Wed, 10 Feb 2021 10:51:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6ae16841-5f51-617a-aab7-666b7eed299c@grimberg.me>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_215213_619697_5FC811DD 
X-CRM114-Status: GOOD (  22.60  )
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

CgpPbiAyLzEwLzIxIDI6MDEgQU0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4KPj4+Pj4gVGhhbmtz
IGZvciByZXBvcnRpbmcgTWluZywgSSd2ZSB0cmllZCB0byByZXByb2R1Y2UgdGhpcyBvbiBteSBW
TQo+Pj4+PiBidXQgZGlkIG5vdCBzdWNjZWVkLiBHaXZlbiB0aGF0IHlvdSBoYXZlIGl0IDEwMCUg
cmVwcm9kdWNpYmxlLAo+Pj4+PiBjYW4geW91IHRyeSB0byByZXZlcnQgY29tbWl0Ogo+Pj4+Pgo+
Pj4+PiAwZGM5ZWRhZjgwZWEgbnZtZS10Y3A6IHBhc3MgbXVsdGlwYWdlIGJ2ZWMgdG8gcmVxdWVz
dCBpb3ZfaXRlcgo+Pj4+Pgo+Pj4+Cj4+Pj4gUmV2ZXJ0IHRoaXMgY29tbWl0IGZpeGVkIHRoZSBp
c3N1ZSBhbmQgSSd2ZSBhdHRhY2hlZCB0aGUgY29uZmlnLiA6KQo+Pj4KPj4+IEhleSBNaW5nLAo+
Pj4KPj4+IEluc3RlYWQgb2YgcmV2ZXJ0LCBkb2VzIHRoaXMgcGF0Y2ggbWFrZXMgdGhlIGlzc3Vl
IGdvIGF3YXk/Cj4+IEhpIFNhZ2kKPj4KPj4gQmVsb3cgcGF0Y2ggZml4ZWQgdGhlIGlzc3VlLCBs
ZXQgbWUga25vdyBpZiB5b3UgbmVlZCBtb3JlIHRlc3RpbmcuIDopCj4KPiBUaGFua3MgWWksCj4K
U28gaXQncyBudm1lX2FkbWluX2Fib3J0X2NtZCBoZXJlCgpbwqDCoCA3NC4wMTc0NTBdIHJ1biBi
bGt0ZXN0cyBudm1lLzAxMiBhdCAyMDIxLTAyLTA5IDIxOjQxOjU1ClvCoMKgIDc0LjExMTMxMV0g
bG9vcDogbW9kdWxlIGxvYWRlZApbwqDCoCA3NC4xMjU3MTddIGxvb3AwOiBkZXRlY3RlZCBjYXBh
Y2l0eSBjaGFuZ2UgZnJvbSAyMDk3MTUyIHRvIDAKW8KgwqAgNzQuMTQxMDI2XSBudm1ldDogYWRk
aW5nIG5zaWQgMSB0byBzdWJzeXN0ZW0gYmxrdGVzdHMtc3Vic3lzdGVtLTEKW8KgwqAgNzQuMTQ5
Mzk1XSBudm1ldF90Y3A6IGVuYWJsaW5nIHBvcnQgMCAoMTI3LjAuMC4xOjQ0MjApClvCoMKgIDc0
LjE1ODI5OF0gbnZtZXQ6IGNyZWF0aW5nIGNvbnRyb2xsZXIgMSBmb3Igc3Vic3lzdGVtIApibGt0
ZXN0cy1zdWJzeXN0ZW0tMSBmb3IgTlFOIApucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzczp1dWlk
OjQxMTMxZDg4LTAyY2EtNGNjYy04N2IzLTZjYTNmMjhiMTNhNC4KW8KgwqAgNzQuMTU4NzQyXSBu
dm1lIG52bWUwOiBjcmVhdGluZyA0OCBJL08gcXVldWVzLgpbwqDCoCA3NC4xNjMzOTFdIG52bWUg
bnZtZTA6IG1hcHBlZCA0OC8wLzAgZGVmYXVsdC9yZWFkL3BvbGwgcXVldWVzLgpbwqDCoCA3NC4x
ODQ2MjNdIG52bWUgbnZtZTA6IG5ldyBjdHJsOiBOUU4gImJsa3Rlc3RzLXN1YnN5c3RlbS0xIiwg
YWRkciAKMTI3LjAuMC4xOjQ0MjAKW8KgwqAgNzUuMjM1MDU5XSBudm1lX3RjcDogcnEgMzggb3Bj
b2RlIDgKW8KgwqAgNzUuMjM4NjUzXSBibGtfdXBkYXRlX3JlcXVlc3Q6IEkvTyBlcnJvciwgZGV2
IG52bWUwYzBuMSwgc2VjdG9yIAoxMDQ4NjI0IG9wIDB4OTooV1JJVEVfWkVST0VTKSBmbGFncyAw
eDI4MDA4MDAgcGh5c19zZWcgMCBwcmlvIGNsYXNzIDAKW8KgwqAgNzUuMzgwMTc5XSBYRlMgKG52
bWUwbjEpOiBNb3VudGluZyBWNSBGaWxlc3lzdGVtClvCoMKgIDc1LjM4NzQ1N10gWEZTIChudm1l
MG4xKTogRW5kaW5nIGNsZWFuIG1vdW50ClvCoMKgIDc1LjM4ODU1NV0geGZzIGZpbGVzeXN0ZW0g
YmVpbmcgbW91bnRlZCBhdCAvbW50L2Jsa3Rlc3RzIHN1cHBvcnRzIAp0aW1lc3RhbXBzIHVudGls
IDIwMzggKDB4N2ZmZmZmZmYpClvCoMKgIDkxLjAzNTY1OV0gWEZTIChudm1lMG4xKTogVW5tb3Vu
dGluZyBGaWxlc3lzdGVtClvCoMKgIDkxLjA0MzMzNF0gbnZtZSBudm1lMDogUmVtb3ZpbmcgY3Ry
bDogTlFOICJibGt0ZXN0cy1zdWJzeXN0ZW0tMSIKCgo+IEknbGwgc3VibWl0IGEgcHJvcGVyIHBh
dGNoLCBidXQgY2FuIHlvdSBydW4gdGhpcyBjaGFuZ2UKPiB0byBzZWUgd2hhdCBjb21tYW5kIGhh
cyBhIGJpbyBidXQgd2l0aG91dCBhbnkgZGF0YT8KPiAtLSAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9udm1lL2hvc3QvdGNwLmMgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYwo+IGluZGV4IDYxOWIw
ZDhmNmUzOC4uMzExZjFiNzhhOWQ0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3Rj
cC5jCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMKPiBAQCAtMjI3MSw4ICsyMjcxLDEz
IEBAIHN0YXRpYyBibGtfc3RhdHVzX3QgCj4gbnZtZV90Y3Bfc2V0dXBfY21kX3BkdShzdHJ1Y3Qg
bnZtZV9ucyAqbnMsCj4gwqDCoMKgwqDCoMKgwqAgcmVxLT5kYXRhX2xlbiA9IGJsa19ycV9ucl9w
aHlzX3NlZ21lbnRzKHJxKSA/Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmxrX3JxX3BheWxvYWRfYnl0ZXMocnEpIDogMDsK
PiDCoMKgwqDCoMKgwqDCoCByZXEtPmN1cnJfYmlvID0gcnEtPmJpbzsKPiAtwqDCoMKgwqDCoMKg
IGlmIChyZXEtPmN1cnJfYmlvKQo+ICvCoMKgwqDCoMKgwqAgaWYgKHJlcS0+Y3Vycl9iaW8pIHsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXJlcS0+ZGF0YV9sZW4pIHsKPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJfZXJyKCJycSAl
ZCBvcGNvZGUgJWRcbiIsIHJxLT50YWcsIAo+IHBkdS0+Y21kLmNvbW1vbi5vcGNvZGUpOwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gQkxLX1NU
U19JT0VSUjsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIG52bWVfdGNwX2luaXRfaXRlcihyZXEsIHJxX2RhdGFfZGlyKHJx
KSk7Cj4gK8KgwqDCoMKgwqDCoCB9Cj4KPiDCoMKgwqDCoMKgwqDCoCBpZiAocnFfZGF0YV9kaXIo
cnEpID09IFdSSVRFICYmCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXEtPmRhdGFfbGVuIDw9
IG52bWVfdGNwX2lubGluZV9kYXRhX3NpemUocXVldWUpKQo+IC0tIAo+CgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

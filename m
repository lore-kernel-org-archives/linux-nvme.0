Return-Path: <SRS0=6Yp5=EX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65901C6379D
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2020 08:40:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB3C12467B
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2020 08:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GPjG+iqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB3C12467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WtUq4+j0p5fQVykcJgVkAel4stKVQQ+V8A5NSrIpvNo=; b=GPjG+iqABJii1jgTquC8Zshnl
	cRDJJI7kjFa4s5yABwMbv/JLVRja0DXBaUxKlm5ua+jOGdh3E0CYAtg1DyE2MH8M1QEYtX3MWcxAy
	rDTFmOxWWPVSUSL9QdF57L7ZoLCQszn5KgVRr4T8Sj/c3K1zYW6YvGEtcCOktoA6bKlgZnKNqADoD
	5ZZQghA3eGB5KRhAv2jAFIj/uPKssGUS8MgkAlRhIaLItbnc+f5Ca+UD8dxxwK+SfbMsRfYeK8FW1
	iVIj/ozGw4q0YPJ+C8+MDYpuBWLAcsrHCu77HGVWqXh7850X2ITX28nUsUfclU8BpN+NWQ2z3PRd3
	8Kb6UKKpw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kewWm-0001g6-H4; Tue, 17 Nov 2020 08:39:52 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kewWg-0001eQ-FH
 for linux-nvme@lists.infradead.org; Tue, 17 Nov 2020 08:39:47 +0000
Received: by mail-wr1-f43.google.com with SMTP id 23so22257206wrc.8
 for <linux-nvme@lists.infradead.org>; Tue, 17 Nov 2020 00:39:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bCVONS0s+S7SogH7Min9uo26lGYh2kmnmfvJYxLkj3s=;
 b=APOOlIwuSNgGfSBSH8ZAbTdx2lnvRpP/6vmPyKfL74fOKtLv1f6yKZvDdR6HR+CakK
 73SbaDNRA7ADFci10HVPBrTJXkiKB91E1FHwljrOdBdBcUnaukqKkVYVvcgcmEpoQ2CK
 eSdjGrYZ/8L+GIzq2vSzm+SZUe0H62T9+6q5xLHzVvhYuzBki5xq8GUpqMrSm4C41JG6
 O8IkDKMALj3MX8BCPo5UziAidfyDh2DbH2UP/GPYI0N1jsrQHqUtRSDowpRiqiO2QTtT
 NjEAoW1nDx1Z6qUNAPNNYYjS/u77Fu+bM08WAPrRJ5IEmJZ2NxHi6SePxFSYq6E5S1C0
 ez+Q==
X-Gm-Message-State: AOAM532d+ZdtgEa0qeaS54ra8tPdCmGhaG+qTBa51yDX03HxXhEAW5dx
 wEFu5oAnzyexAj/aVCM2mnM=
X-Google-Smtp-Source: ABdhPJx4vw3TSF0ACtE/bHBeDYGr9Zl+YXHWsy4NGIEnBiZMx+ucPNfoSLEG0AZLzG/wIqf5kphhsg==
X-Received: by 2002:a5d:6250:: with SMTP id m16mr6467042wrv.400.1605602377979; 
 Tue, 17 Nov 2020 00:39:37 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:35d4:873c:b62a:b00b?
 ([2601:647:4802:9070:35d4:873c:b62a:b00b])
 by smtp.gmail.com with ESMTPSA id a18sm2377795wmm.22.2020.11.17.00.39.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2020 00:39:37 -0800 (PST)
Subject: Re: [PATCH v9] nvme-fabrics: reject I/O to offline device
To: Hannes Reinecke <hare@suse.de>, Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <319b8b1869f34a48b26fbd902883ed71@kioxia.com>
 <b6f09a8e-e633-e303-1f39-cd380fd92f2c@suse.de>
 <a3245f7368364c5b83cdd3ed3a61d718@kioxia.com>
 <08f1048d-0726-983c-c783-2e04d24b5221@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <21948197-ac36-f757-5c1f-f36f2d6d9242@grimberg.me>
Date: Tue, 17 Nov 2020 00:39:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <08f1048d-0726-983c-c783-2e04d24b5221@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201117_033946_546975_5B11E510 
X-CRM114-Status: GOOD (  20.55  )
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
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 "Ewan D. Milne" <emilne@redhat.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiBAQCAtMTUxLDEyICsxNTEsMTYgQEAgRVhQT1JUX1NZTUJPTF9HUEwobnZtZV90cnlfc2No
ZWRfcmVzZXQpOwo+Pj4gwqDCoCBzdGF0aWMgdm9pZCBudm1lX2ZhaWxmYXN0X3dvcmsoc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKSB7Cj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG52bWVf
Y3RybCAqY3RybCA9IGNvbnRhaW5lcl9vZih0b19kZWxheWVkX3dvcmsod29yayksCj4+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbnZt
ZV9jdHJsLCBmYWlsZmFzdF93b3JrKTsKPj4+ICvCoMKgwqDCoMKgwqAgc3RydWN0IG52bWVfbnMg
Km5zOwo+Pj4KPj4+IC3CoMKgwqDCoMKgwqAgaWYgKGN0cmwtPnN0YXRlICE9IE5WTUVfQ1RSTF9D
T05ORUNUSU5HKQo+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4g
LQo+Pj4gLQo+Pj4gLcKgwqDCoMKgwqDCoCBzZXRfYml0KE5WTUVfQ1RSTF9GQUlMRkFTVF9FWFBJ
UkVELCAmY3RybC0+ZmxhZ3MpOwo+Pj4gK8KgwqDCoMKgwqDCoCBkb3duX3JlYWQoJmN0cmwtPm5h
bWVzcGFjZXNfcndzZW0pOwo+Pj4gK8KgwqDCoMKgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5KG5z
LCAmY3RybC0+bmFtZXNwYWNlcywgbGlzdCkgewo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaWYgKGN0cmwtPnN0YXRlICE9IE5WTUVfQ1RSTF9MSVZFIHx8Cj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChucy0+YW5hX3N0YXRlICE9IE5WTUVfQU5BX09Q
VElNSVpFRCAmJgo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5z
LT5hbmFfc3RhdGUgIT0gTlZNRV9BTkFfTk9OT1BUSU1JWkVEKSkKPj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZXRfYml0KE5WTUVfTlNfRkFJTEZBU1Rf
RVhQSVJFRCwgJm5zLT5mbGFncyk7Cj4+PiArwqDCoMKgwqDCoMKgIH0KPj4+ICvCoMKgwqDCoMKg
wqAgdXBfcmVhZCgmY3RybC0+bmFtZXNwYWNlc19yd3NlbSk7Cj4+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgZGV2X2luZm8oY3RybC0+ZGV2aWNlLCAiZmFpbGZhc3QgZXhwaXJlZFxuIik7Cj4+Pgo+Pj4g
Li4uYW5kIHdlIGNvdWxkIGxlYXZlIHRoZSBmYWlsZmFzdCB3b3JrZXIgcnVubmluZyBldmVuIGFm
dGVyIHRoZSAKPj4+IGNvbnRyb2xsZXIKPj4+IHRyYW5zaXRpb25lZCB0byBMSVZFLgo+Pj4gQ2Yg
dGhlIGF0dGFjaGVkIHBhdGNoIGZvciBkZXRhaWxzLgo+Pj4KPj4+IENoZWVycywKPj4+Cj4+PiBI
YW5uZXMKPj4+IC0tIAo+Pgo+PiBJJ20gbm90IHN1cmUgd2hhdCBtYWtlcyBzZW5zZSB0byBtb3Zl
IHRoZSBGQUlMRkFTVF9FWFBJUkVEIGJpdCBpbnRvIAo+PiB0aGUgbmFtZXNwYWNlLAo+PiBCZWNh
dXNlIHRoZSBmYWlsZmFzdCBtZWNoYW5pc20gY2hhcmFjdGVyaXplcyB0aGUgY29udHJvbGxlciBh
cyBhIHdob2xlLgo+Pgo+IE9oLCB5ZXMsIEknbSBhd2FyZSBvZiB0aGF0LiBCdXQgdGhlIHByb2Js
ZW0gaGVyZSBpcyB3aXRoIG11bHRpcGF0aDsgaG93IAo+IGRvIHdlIGhhbmRsZSB0aGUgc2l0dWF0
aW9uIHdoZXJlIGFsbCBjb250cm9sbGVycyBoYXZlIHRoZSAKPiAnZmFpbGZhc3RfZXhwaXJlZCcg
Yml0IHNldD8KPiBTaG91bGQgSS9PIGJlIHRlcm1pbmF0ZWQgKHdoaWNoIEkgdGhpbmsgaXQgc2hv
dWxkLCBnaXZlbiB0aGF0IGZhaWxmYXN0IAo+IGlzIHN1cHBvc2VkIHRvIHRlcm1pbmF0ZSB0aGUg
SS9PKT8KPiBPciBzaG91bGQgSS9PIGNvbnRpbnVlIHRvIHJ1biAoYXMgaXQgZG9lcyB3aXRoIHlv
dXIgb3JpZ2luYWwgcGF0Y2gpPwoKSSBkbyBhZ3JlZSB0aGF0IGZhc3RfaW9fZmFpbF90bW8gX2lz
XyBhIGNvbnRyb2xsZXIgYXR0cmlidXRlIGFuZCBzaG91bGQKcmVtYWluIGFzIHN1Y2guCgpJIGRv
IHNlZSB3aGF0IGlzIHlvdXIgcG9pbnQgSGFubmVzLCBob3dldmVyIEkgYWxzbyB0aGluayBpdCdz
CnByb2JsZW1hdGljIHRoYXQgdGhlIGhvc3QgbWF5IGZhaWwgYXJiaXRyYXJ5IEkvTyBpZiB0aGUg
Y29udHJvbGxlcgpoYXBwZW5zIHRvIGVudGVyIEFOQSBpbmFjY2Vzc2libGUgc3RhdGUgKG9yIGhh
dmUgc3RhdGUgdHJhbnNpdGlvbgp0aW1lb3V0KSBmb3IgYSBwZXJpb2QgdGhhdCBoYXBwZW5zIHRv
IGJlIGxvbmdlciB0aGFuIHdoYXQgdGhlIHVzZXIKaGFwcGVuIHRvIHNldCAod2l0aG91dCBjb21t
dW5pY2F0aW5nIGFueSBvZiB0aGlzIHRvIHRoZSBjb250cm9sbGVyKS4KCklGRiB3ZSB3YW50IHRv
IGFkZHJlc3MgdGhpcyAoSSdtIHN0aWxsIG5vdCBzdXJlKSwgd2UgcHJvYmFibHkgd2FudAp0byBh
Y3RpdmF0ZSBmYWlsZmFzdCB0aW1lb3V0IGluIEFOQSBzdGF0ZSB0cmFuc2l0aW9uIChhbmQgY2xl
YXIgaXQKd2hlbiB3ZSBleGl0IGl0KS4gVGhlbiB3ZSBjYW4gbW9kaWZ5IG52bWVfYXZhaWxhYmxl
X3BhdGgoKSB0byB0YWtlCk5WTUVfQ1RSTF9GQUlMRkFTVF9FWFBJUkVEIGludG8gYWNjb3VudC4K
CkFueXdheXMsIEkgdGhpbmsgdGhhdCB0aGlzIGNhbiBiZSBhbiBpbmNyZW1lbnRhbCBwYXRjaCBi
ZWNhdXNlIGl0CmRvZXNuJ3QgY2hhbmdlIHRoZSBiZWhhdmlvciB0b2RheSB3aXRoIHJlc3BlY3Qg
dG8gQU5BIHN0YXRlcyAob3IKdHJhbnNpdGlvbiBiZXR3ZWVuIHRoZW0pIGUuZy4gcXVldWUgdGhl
IG91dHN0YW5kaW5nIEkvTy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFk
ZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LW52bWUK

Return-Path: <SRS0=DaCh=L5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C868EC07E99
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:10:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B201610EA
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jul 2021 15:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B201610EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=n7rRyxfj7YWohsn/BA0V4I+pBZlkcoiutSXGnE8v6eQ=; b=Hqj5t3/S+HQa3w
	ix7DF8EAxF+X+6sl1cFPfN5CODea9AqaYEI3mH/NfHZrz/KeLmxlsiAeS+zLU1X2aMeAynmsw1yxK
	LpULxZHuHsA0xi0tzU+AnRGOjZjHeTnKmVQ+xbVq4E330jdv5TtIf0g0LiXCwMuj+0N7y29FpKEon
	FuoSY/8N1R1laIZb1vKekYBkusLIo5K2XglG601H9yOckBhYkTKr7ctqHkTLVGCL7nfSHCUo+GveO
	FwuHeo5eFMQv7wOLV3KZD5UpennOyV/b3fhgk+a2AsbwCGsHKFg40droIaWMkMIjW0JjdvD72P+Sw
	sed2V44E6vN/YA5F0r9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m0QEf-009Hyq-PC; Mon, 05 Jul 2021 15:10:13 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m0QEd-009Hy0-8j
 for linux-nvme@lists.infradead.org; Mon, 05 Jul 2021 15:10:12 +0000
Received: by mail-pj1-x102c.google.com with SMTP id n11so11899599pjo.1
 for <linux-nvme@lists.infradead.org>; Mon, 05 Jul 2021 08:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WOIi3qYdeE7SKeAjv/kSr+5BYh/ONui645WVvbSW3B0=;
 b=A69KeoQMp7BMy/BvMozbX1xSkk1itV7CbgojnoIB1a+pdRBYWK77ZtPAy5LwUjOM6S
 JA7CMS3kqDdPKZa2s0jE2c/BKnMdwANB8+RgQn3Pp9U8fR61lMHJDn42llYGlRkCOeX9
 gGiX0YfcvNlym+13tOJUdedvESZ+zhVu003eAmnRiguEbBNhWVv2FaGWHkLvLZ93JIo8
 ScEexzPorJfx4O78RA2ELCpXGPLHGYuiiyLUYfMasfQd6I5tqiGtdyyW5Sd1QhyJ7Pno
 +T6zbBCchG4/yCwRFdUkw9ulqg3MaEziP6qMEvXUgQ6e6vcn/IhyrG2CHxoCOTfD2SMO
 eqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WOIi3qYdeE7SKeAjv/kSr+5BYh/ONui645WVvbSW3B0=;
 b=jrLLzKd4Byc5SlctmJJJtasWU4rpycQGGxKPZL7d2wtRvi494I82Mpxjuwi6iL6R5v
 949qLubQSwtv3KD/0rmUGAM+aq/mbCBKA1e/foL96gUlk/GY6irZbvSJjkAflvWqYRuh
 7x2KL2EA81xA6/DcGEMCLnxZZ8lPGoW8mrNsLBYRVjxkbNkAqTDLs9o6FQHl13z3vHHN
 zUK96P80cXsh6NAr82h05Cptz4v2yibwxzaT2alK0sAh4mhpUZuth9hu4SIXeyg9j+C2
 S8amKdrcKrZRAyv/7X3KZ/XBZUunQ045VoUSRpHyi1wTPZ5Q7zdWyhkFYXvs7Dgnj+CU
 sqxA==
X-Gm-Message-State: AOAM530d/KkmjsHGMwqGkvxJ9WZ9mYBlgNtHanKP6ukKyrnKoo/opkGP
 yY+wCKRWLA/jQdG9DKEwQ+2ltb7gr7jSfYo29pMRwoGzQynGy/r/
X-Google-Smtp-Source: ABdhPJxIhRMrwsuDBLs0DhzefoyIZXBbuGJNR0LwPyzwDa1SGAc4XxGSyH8LMRTcdbmydq/7N7eTKWdENdKB0VDpo4k=
X-Received: by 2002:a17:902:aa0b:b029:128:eb4c:15e5 with SMTP id
 be11-20020a170902aa0bb0290128eb4c15e5mr12611791plb.45.1625497809531; Mon, 05
 Jul 2021 08:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210629124743.6898-1-pkushwaha@marvell.com>
 <20210629124743.6898-2-pkushwaha@marvell.com>
 <20210701133424.GB18548@lst.de>
In-Reply-To: <20210701133424.GB18548@lst.de>
From: Shai Malin <malin1024@gmail.com>
Date: Mon, 5 Jul 2021 18:09:58 +0300
Message-ID: <CAKKgK4wN49NX+pDff5eFbebeTWBi4aMK9CVMmq4jixgtXHRmQA@mail.gmail.com>
Subject: Re: [PATCH v4 01/20] nvme-tcp-offload: Add nvme-tcp-offload - NVMeTCP
 HW offload ULP
To: Christoph Hellwig <hch@lst.de>
Cc: Prabhakar Kushwaha <pkushwaha@marvell.com>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, axboe@fb.com, Keith Busch <kbusch@kernel.org>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Shai Malin <smalin@marvell.com>, 
 Ariel Elior <aelior@marvell.com>, Michal Kalderon <mkalderon@marvell.com>,
 okulkarni@marvell.com, 
 prabhakar.pkin@gmail.com, Dean Balandin <dbalandin@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210705_081011_351247_0581D29C 
X-CRM114-Status: GOOD (  28.33  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAxIEp1bCAyMDIxIGF0IDE2OjM0LCBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5k
ZT4gd3JvdGU6Cj4KPiA+ICsvKiBLZXJuZWwgaW5jbHVkZXMgKi8KPgo+Cj4gPiArLyogRHJpdmVy
IGluY2x1ZGVzICovCj4KPiBJIHRoaW5rIHRoZXNlIGNvbW1lbnRzIGFyZSBhIGxpdHRsZSBwb2lu
dGxlc3MuCgpXaWxsIGJlIHJlbW92ZWQuCgo+Cj4gPiAraW50IG52bWVfdGNwX29mbGRfcmVnaXN0
ZXJfZGV2KHN0cnVjdCBudm1lX3RjcF9vZmxkX2RldiAqZGV2KQo+Cj4gQ2FuIHlvdSBzcGVsbCBv
dXQgb2ZmbG9hZCBldmVyeXdoZXJlPwoKU3VyZS4KCj4KPiA+ICtpbnQgbnZtZV90Y3Bfb2ZsZF9y
ZXBvcnRfcXVldWVfZXJyKHN0cnVjdCBudm1lX3RjcF9vZmxkX3F1ZXVlICpxdWV1ZSkKPiA+ICt7
Cj4gPiArICAgICAvKiBQbGFjZWhvbGRlciAtIGludm9rZSBlcnJvciByZWNvdmVyeSBmbG93ICov
Cj4gPiArCj4gPiArICAgICByZXR1cm4gMDsKPiA+ICt9Cj4KPiBQbGVhc2UgZG9uJ3QgYWRkIGFu
eSBwbGFjZWhvbGRlcnMgbGlrZSB0aGlzLiAgVGhlIHdob2xlIGZpbGUgaXMKPiBzdGlsbCBwcmV0
dHkgc21hbGwgd2l0aCBhbGwgdGhlIHBhdGNoZXMgYXBwbGllZCwgc28gbm8gbmVlZCB0byBzcGxp
dCBpdC4KClN1cmUuCgo+Cj4gPiArc3RhdGljIHN0cnVjdCBudm1mX3RyYW5zcG9ydF9vcHMgbnZt
ZV90Y3Bfb2ZsZF90cmFuc3BvcnQgPSB7Cj4gPiArICAgICAubmFtZSAgICAgICAgICAgPSAidGNw
X29mZmxvYWQiLAo+ID4gKyAgICAgLm1vZHVsZSAgICAgICAgID0gVEhJU19NT0RVTEUsCj4gPiAr
ICAgICAucmVxdWlyZWRfb3B0cyAgPSBOVk1GX09QVF9UUkFERFIsCj4gPiArICAgICAuYWxsb3dl
ZF9vcHRzICAgPSBOVk1GX09QVF9UUlNWQ0lEIHwgTlZNRl9PUFRfTlJfV1JJVEVfUVVFVUVTICB8
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICBOVk1GX09QVF9IT1NUX1RSQUREUiB8IE5WTUZf
T1BUX0NUUkxfTE9TU19UTU8gfAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgTlZNRl9PUFRf
UkVDT05ORUNUX0RFTEFZIHwgTlZNRl9PUFRfSERSX0RJR0VTVCB8Cj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICBOVk1GX09QVF9EQVRBX0RJR0VTVCB8IE5WTUZfT1BUX05SX1BPTExfUVVFVUVT
IHwKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIE5WTUZfT1BUX1RPUyB8IE5WTUZfT1BUX0hP
U1RfSUZBQ0UsCj4gPiArfTsKPiA+ICsKPiA+ICtzdGF0aWMgaW50IF9faW5pdCBudm1lX3RjcF9v
ZmxkX2luaXRfbW9kdWxlKHZvaWQpCj4gPiArewo+ID4gKyAgICAgbnZtZl9yZWdpc3Rlcl90cmFu
c3BvcnQoJm52bWVfdGNwX29mbGRfdHJhbnNwb3J0KTsKPiA+ICsKPiA+ICsgICAgIHJldHVybiAw
Owo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgdm9pZCBfX2V4aXQgbnZtZV90Y3Bfb2ZsZF9jbGVh
bnVwX21vZHVsZSh2b2lkKQo+ID4gK3sKPiA+ICsgICAgIG52bWZfdW5yZWdpc3Rlcl90cmFuc3Bv
cnQoJm52bWVfdGNwX29mbGRfdHJhbnNwb3J0KTsKPiA+ICt9Cj4KPiBMb29raW5nIGF0IHRoZSBm
aW5hbCByZXN1bHQgdGhpcyBkb2Vzbid0IGRvIG11Y2guICBBc3N1bWluZyB3ZSB3YW50Cj4gdG8g
c3VwcG9ydCB0aGVzZSBraW5kcyBvZiB3aGFja3kgb2ZmbG9hZHMgKHdoaWNoIEknZCByYXRoZXIg
bm90IGRvKSwKPiB0aGUgcHJvcGVyIHdheSB3b3VsZCBiZSB0byBhbGxvdyByZWdpc3RlcmluZyBt
dWx0aXBsZSB0cmFuc3BvcnRfb3BzCj4gc3RydWN0dXJlcyBmb3IgYSBnaXZlbiBuYW1lIHJhdGhl
ciBhZGRpbmcgYW4gaW5kaXJlY3Rpb24gdGhhdCBkdXBsaWNhdGVzCj4gYSB3aG9sZSBsb3Qgb2Yg
Y29kZS4KCkluIHRoYXQgY2FzZSwgd291bGQgeW91IHByZWZlciB0aGF0IHdlIGludm9rZSB0aGUg
dGNwLW9mZmxvYWQgZnJvbQp3aXRoaW4gdGhlIHRjcCBmbG93PwpTaG91bGQgaXQgYmUgd2l0aCB0
aGUgc2FtZSB0cmFuc3BvcnQgbmFtZSAo4oCcdGNw4oCdKSBvciB3aXRoIGEgZGlmZmVyZW50CnRy
YW5zcG9ydCBuYW1lICjigJx0Y3Bfb2ZmbG9hZOKAnSk/CgpBbHNvLCB3b3VsZCB5b3UgcHJlZmVy
IHRoYXQgd2UgcmVnaXN0ZXIgdGhlIG9mZmxvYWQgZGV2aWNlIGRyaXZlcgpkaXJlY3RseSB0byBi
bGtfbXEgbGF5ZXIgb3IgdGhyb3VnaCB0aGUgdGNwLW9mZmxvYWQgbGF5ZXI/Cgo+Cj4gPiArICAg
ICAvKiBPZmZsb2FkIGRldmljZSBzcGVjaWZpYyBkcml2ZXIgY29udGV4dCAqLwo+ID4gKyAgICAg
aW50IG51bV9od192ZWN0b3JzOwo+ID4gK307Cj4KPiBBcyBmYXIgYXMgSSBjYW4gdGVsbCB0aGlz
IGlzIGFib3V0IHF1ZXVlcywgbm90ICJ2ZWN0b3JzIiBvZiBzb21lIGtpbmQuCgpJdCdzIHRoZSBu
dW0gaXJxcyB3aGljaCB0aGUgZGV2aWNlIHN1cHBvcnQuIFdlIGNhbiByZW5hbWUgaXQgIm51bV9o
d19xdWV1ZXMiLgoKPgo+ID4gK3N0cnVjdCBudm1lX3RjcF9vZmxkX3JlcSB7Cj4gPiArICAgICBz
dHJ1Y3QgbnZtZV9yZXF1ZXN0IHJlcTsKPiA+ICsgICAgIHN0cnVjdCBudm1lX2NvbW1hbmQgbnZt
ZV9jbWQ7Cj4gPiArICAgICBzdHJ1Y3QgbGlzdF9oZWFkIHF1ZXVlX2VudHJ5Owo+ID4gKyAgICAg
c3RydWN0IG52bWVfdGNwX29mbGRfcXVldWUgKnF1ZXVlOwo+ID4gKwo+ID4gKyAgICAgLyogT2Zm
bG9hZCBkZXZpY2Ugc3BlY2lmaWMgZHJpdmVyIGNvbnRleHQgKi8KPiA+ICsgICAgIHZvaWQgKnBy
aXZhdGVfZGF0YTsKPiA+ICsKPiA+ICsgICAgIC8qIGFzeW5jIGZsYWcgaXMgdXNlZCB0byBkaXN0
aW5ndWlzaCBiZXR3ZWVuIGFzeW5jIGFuZCBJTyBmbG93Cj4gPiArICAgICAgKiBpbiBjb21tb24g
c2VuZF9yZXEoKSBvZiBudm1lX3RjcF9vZmxkX29wcy4KPiA+ICsgICAgICAqLwo+ID4gKyAgICAg
Ym9vbCBhc3luYzsKPiA+ICsKPiA+ICsgICAgIHZvaWQgKCpkb25lKShzdHJ1Y3QgbnZtZV90Y3Bf
b2ZsZF9yZXEgKnJlcSwKPiA+ICsgICAgICAgICAgICAgICAgICB1bmlvbiBudm1lX3Jlc3VsdCAq
cmVzdWx0LAo+ID4gKyAgICAgICAgICAgICAgICAgIF9fbGUxNiBzdGF0dXMpOwo+Cj4gVGhpcyBh
bHdheXMgcG9pbnRzIHRvIG52bWVfdGNwX29mbGRfcmVxX2RvbmUsIHdoeSB0aGUgY29zdGx5IGlu
ZGlyZWN0aW9uPwoKV2lsbCBiZSBmaXhlZC4KCj4KPiA+ICsgICAgIC8qIEVycm9yIGNhbGxiYWNr
IGZ1bmN0aW9uICovCj4gPiArICAgICBpbnQgKCpyZXBvcnRfZXJyKShzdHJ1Y3QgbnZtZV90Y3Bf
b2ZsZF9xdWV1ZSAqcXVldWUpOwo+ID4gK307Cj4KPiBUaGlzIHNlZW1zIHRvIGFsd2F5cyBwb2lu
dCB0byBudm1lX3RjcF9vZmxkX3JlcG9ydF9xdWV1ZV9lcnIsIHdoeSB0aGUKPiBpbmRpcmVjdGlv
bj8KCldpbGwgYmUgZml4ZWQuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==

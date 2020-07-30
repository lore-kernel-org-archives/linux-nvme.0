Return-Path: <SRS0=YlYz=BJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7FDC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2020 00:19:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DA22075D
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2020 00:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dVYcXrrf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="conqhayv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DA22075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a2hygvTe8j824281DvzofmPzuI8mFCg0vcadbnBQU3g=; b=dVYcXrrfjuVuZd2qAs12XwBil
	606PrdpyWlPJVaQOxhjmwbsNQ47aRAJFLB4eClW5O0Fj9UadZHZK+6D4HUsnudk8g1HKVR2fKO4rv
	ReLBxq2YsDqAoO2Bxu1JtKCQiAhQQrWs0K3SuzUNVSR1cvF6Y5A8+qXaMKL8A2+IMIFaERXZ71NIj
	eg2vdgUyEPULLukTM279JYP9yVBis/hQokppHBkOArroNSyd3bDEovdtYhyuSY0lDnWzpOGuLkOUw
	4aUAPOVkkhFUQdZQcGe1T+uCdQRhDp/gZpyhZ9UrR/gpDs5wdY+Q2+kWJAkCHRc7+FEq3rfPGXdGs
	mFznEttuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0wHg-0002LX-JX; Thu, 30 Jul 2020 00:18:56 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0wHb-0002Kz-Au
 for linux-nvme@lists.infradead.org; Thu, 30 Jul 2020 00:18:53 +0000
Received: by mail-pf1-x444.google.com with SMTP id l2so7682944pff.0
 for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2020 17:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=DFLzjU4WJHCdBzoC6e8WXu01lq/izELtV1SlXWtO8hs=;
 b=conqhayvPQtHjy1+0pP+XWxBj48Xoc4opO9K/Z+SeVwZiFnmLhHV+gOHBa7Y4d/5YB
 wafRfKiT1CL70Msg7RsayV0n0f+wCACyyyUQ3kv1TWx0DxjipNo8z0u3oNLlPGCX26FQ
 uz7ThSvbdCAELO+t6vEO/V2WCoi5p2PGAhJ/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=DFLzjU4WJHCdBzoC6e8WXu01lq/izELtV1SlXWtO8hs=;
 b=WOh7rxGtWw6Sgd63kngaJrCSzI/YsSvO7TBzYHSm/0bsBCgIJNzzT/yw5YqfHlkHi8
 BfGfucgzpKa5j4px+l+sLJ47XDsNBmCZPRHUvNS+KVazeL/ssZh3ZtZ/3XiuzPWTKeKJ
 DDjBnTCXzEKcMFMv3gMkW4XCi8AxuwKa1Q2iPIoSuOdQhUx2V4LMrjZ16FDnhA4maQka
 x3P3Wv4zIufVLILJFx1hNk0e5ZrdR5mrqxI504+HKPZGDvHvXwIpwLqj7g78r5IKliYc
 ebIroPDUQl6IBjIHWm1h4V4j/wCcwC3IcJKxXfnM5eXBHCGg6jDVwuDy/L56OfVg4lTV
 oOuA==
X-Gm-Message-State: AOAM532Zeh6Vsa1nz83cumI4/0X3S7y8FUuBEF9ucaCGpj+HhoIOfr6A
 oYCTCVEwNqHjWc3rIiIA3PSSObOeJv4YOw==
X-Google-Smtp-Source: ABdhPJx8nG8CnHvBUGO4jV/BS4ezvw9yKKCoVHvRqmMk5O6UoNOjVnAqlB1J6IR9120ykIMR1eMnmQ==
X-Received: by 2002:a63:d250:: with SMTP id t16mr31357021pgi.51.1596068328398; 
 Wed, 29 Jul 2020 17:18:48 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id g30sm3738492pfq.189.2020.07.29.17.18.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jul 2020 17:18:47 -0700 (PDT)
Subject: Re: [PATCH v2] nvme-fabrics: allow to queue requests for live queues
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200729075846.22762-1-sagi@grimberg.me>
 <dcfb5abb-b740-2043-a6c2-97dca47f75e4@broadcom.com>
 <45901cfb-6dc7-d021-7151-bcbab1390139@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <2ab8786b-211f-6e7c-980b-b4ea01cacd47@broadcom.com>
Date: Wed, 29 Jul 2020 17:18:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <45901cfb-6dc7-d021-7151-bcbab1390139@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200729_201851_683223_73C4901D 
X-CRM114-Status: GOOD (  42.61  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA3LzI5LzIwMjAgMzowOSBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPgo+PiBTbyB3aGF0
IHdhcyB0aGUgcHJvYmxlbSA/wqAgSXQgaGFzIHRvIGJlIGxpbWl0ZWQgaW4gc2NvcGUgdG8gZWl0
aGVyIAo+PiB0aGUgc3RhcnQgb2YgdGhlIFJlc2V0dGluZyBzdGF0ZSB3aGlsZSBxLT5saXZlIGhh
ZCB5ZXQgdG8gdHJhbnNpdGlvbiAKPj4gdG8gIWxpdmUuIEJ1dCBJIGRvbid0IHNlZSBhbnkgZnJl
ZXppbmcgaW4gdGhpcyBwYXRoLgo+Cj4gV2hlbiB0aGUgcXVldWUgaXMgZnJvemVuLCB0aGUgcV91
c2FnZV9jb3VudGVyIGlzIGtpbGxlZCwgYW5kIHdhaXRlZAo+IHVudGlsIGl0IHJlYWNoZXMgdG8g
MCwgYW5kIHRoYXQgd2lsbCBub3QgaGFwcGVuIGlmIGFsbCB0aGUgcmVxdWVzdHMKPiB0aGF0IGdv
dCB0aGUgcV91c2FnZV9jb3VudGVyIHJlZmVyZW5jZSBhcmUgY29tcGxldGVkLiBTbyB3ZSBjYW5u
b3QKPiBnZXQgaW50byBhIHN0YXRlIHdoZXJlIHJlcXVlc3RzIGFyZSByZXF1ZXVlZCBkdWUgdG8g
QkxLX1NUU19SRVNPVVJDRSwKPiBhcyB0aGV5IHN0aWxsIGhhdmUgdGhlIHJlZmVyZW5jZSB0aGF0
IG5lZWQgdG8gYmUgZHJvcHBlZC4KPgo+PiBMb29raW5nIGF0IHRoZSBvcmlnaW5hbCBwcm9ibGVt
IHRoYXQgbG9jayB1cHMgYXJlOgo+PiAxKSB0aGUgc3lzZnMgd3JpdGUgdG8gZG8gYSByZXNldCAt
IHdoaWNoIGlzIHN0YWxsZWQgd2FpdGluZyBvbiBhIAo+PiBmbHVzaCBvZiByZXNldF93b3JrCj4+
IDIpIHJlc2V0X3dvcmsgaXMgc3RhbGxlZCBvbiBhIGNhbGwgdG8gYmxrX21xX3VwZGF0ZV9ucl9o
d19xdWV1ZXMoKSAKPj4gd2hpY2ggdGhlbiBkb2VzIGEgYmxrX21xX2ZyZWV6ZV9xdWV1ZV93YWl0
Lgo+Cj4gUmlnaHQsIGFuZCBpdCBibG9ja3MgYmVjYXVzZSB3ZSBoYXZlIGNvbW1hbmRzIHRoYXQg
YXJlIHJlcXVldWVkCj4gaW5kZWZpbml0ZWx5IGR1ZSB0byB0aGUgZmFjdCB0aGF0IHdlIHJlZnVz
ZWQgdG8gYWNjZXB0IHRoZW0gd2hpbGUKPiB3ZSBzaG91bGQgaGF2ZS4KCkkgdW5kZXJzdGFuZCB3
aGF0IHlvdSBhcmUgc2F5aW5nLCBidXQuCgpJbnZhcmlhYmx5LCB0aGUgcXVldWVzIGFyZSB1bnF1
aWVzY2VkIHRvIGtlZXAgY29ubmVjdCBnb2luZyB0aHJvdWdoIChhbGwgCnF1ZXVlcykgYW5kIG1v
cmUgKGFkbWluIHF1ZXVlKSwgYW5kIGFzIG5ldyBpbyB3aWxsIGNvbWUgaW4gdGhhdCB0aW1lLCB3
ZSAKaGF2ZSBubyByZWNvdXJzZSBidXQgdG8gYm91bmNlIHRoZSBpbyBhcyB0aGUgcSBpc24ndCBs
aXZlLiBBbmQgaXQgaGFzIHRvIApiZSBhIHJlc291cmNlIHN0YXR1cyBzbyBpdCBpcyByZXF1ZXVl
ZCBhcyB3ZSBjYW4ndCBmYWlsIHRoZSBpbyBhcyB0aGUgCmZhaWx1cmUsIGluIGEgbm9uLW1wYXRo
IHNjZW5hcmlvLCB3aWxsIGdvIGFsbCB0aGUgd2F5IGJhY2sgdG8gdGhlIGNhbGxlciAKd2hpY2gg
aXMgYmFkIG5ld3MuwqAgU28gd2UncmUgaW4gYSBjYXRjaC0yMi4KClRoYXQgd2FzIHdoeSBJIHN1
Z2dlc3RlZCBwZXJoYXBzIHdlIG5lZWRlZCB0byBtYWtlIG1wYXRoIGFsd2F5cyBiZSAKaW52b2x2
ZWQsIGV2ZW4gZm9yIGEgc2luZ2xlLXBhdGggZGV2aWNlIChub24tbXBhdGgpIHNvIHRoYXQgaXQg
Y2FuIGNhdGNoIAphbmQgcXVldWUgYXQgaXQncyBsZXZlbCAoYXMgaWYgYWxsIHBhdGhzIGFyZSBn
b25lKSwgZm9yIGEgc2hvcnQgdGltZSAKcGVyaW9kLCByYXRoZXIgdGhhbiBsZXR0aW5nIHRoZSBl
cnJvciBnbyBiYWNrIHRvIHRoZSBpc3N1ZXIuCgo+Cj4+IFRoZSAybmQgb25lIGlzIG9kZCBpbiBt
eSBtaW5kIGFzIHRoZSB0aGUgdXBkYXRlX25yX2h3X3F1ZXVlcyBpcyAKPj4gc29tZXRoaW5nIGRv
bmUgd2hpbGUgY29ubmVjdGluZyBhbmQgSSB3b3VsZG4ndCB0aGluayB0aGUgcmVzZXQgZmx1c2gg
Cj4+IG11c3Qgd2FpdCBmb3IgYSByZWNvbm5lY3QgYXMgd2VsbC4KPgo+IFdlIGNhbm5vdCB0cmFu
c2l0aW9uIHRvIExJVkUgYW5kIHJlc3RhcnQgdHJhZmZpYyBiZWZvcmUgd2UgdXBkYXRlCj4gdGhl
IG1hcHBpbmdzIHRvIHRoZSBuZXcgbnVtYmVyIG9mIHF1ZXVlcyAoY29udHJvbGxlciBzdWRkZW5s
eSBhbGxvd2VkCj4gbGVzcyBxdWV1ZXMsIG9yIHdlIGdvdCBjcHUgaG90cGx1ZyBvciB3aGF0ZXZl
cikuCgphZ3JlZQoKPgo+IMKgIEFsdGhvdWdoIG5vdCB0aGUgZml4LCBJJ2QgcmVjb21tZW5kCj4+
IHRvIG5vdCBjYWxsIG52bWVfdGNwX3NldHVwX2N0cmwoKSBmcm9tIHJlc2V0X3dvcmsgYW5kIGlu
c3RlYWQgaGF2ZSBpdCAKPj4gc2NoZWR1bGUgbnZtZV90Y3BfcmVjb25uZWN0X2N0cmxfd29yaygp
Lgo+Cj4gV2hhdCBpcyB0aGUgZGlmZmVyZW5jZT8KCml0IGRpZG4ndCBtYXR0ZXIgZm9yIHRoZSBp
c3N1ZSB3ZSdyZSByZWFsbHkgdHJ5aW5nIHRvIHNvbHZlLiBKdXN0IApzb21ldGhpbmcgdGhhdCBs
b29rZWQgb2RkLgoKPgo+IEFzIEkgc2VlIGl0IHdoYXQgdGhlIGRyaXZlciBuZWVkcyB0byBkbyBp
biByZXNldCBpczoKPiAxLiBzdGFydCBmcmVlemUgLSBwcmV2ZW50IGZyb20gbmV3IHJlcXVlc3Rz
IGZyb20gdGFraW5nIHRoZSAKPiBxX3VzYWdlX2NvdW50ZXIKPiAyLiBxdWllc2NlIC0gcHJldmVu
dCBuZXcgY29tbWFuZHMgZnJvbSBlbnRlcmluZyBxdWV1ZV9ycQo+IDMuIHN0b3AgYW5kIGRyYWlu
IGFsbCB0cmFuc3BvcnQgcXVldWVzCj4gNC4gY2FuY2VsIGFsbCBpbmZsaWdodCBjb21tYW5kcyAo
dGFnc2V0X2l0ZXIgb3Igb3RoZXIpCj4gNS4gc3RhcnQgdHJhbnNwb3J0IHF1ZXVlcyBhZ2FpbiAt
IGFsbG93IG9ubHkgY29ubmVjdCB0byBwYXNzCmF1Z21lbnRlZCBmb3IgYWRtaW4tcSB0byBhbGxv
dyBvdGhlciBjb250cm9sbGVyIGluaXQgY29tbWFuZHMgYXMgd2VsbC4KCj4gNi4gdW5xdWllc2Nl
IHRoZSBxdWV1ZXMgLSB0byBhbGxvdyBhbnkgcmVxdWVzdHMgdGhhdCBhcmUgc3R1Y2sKPiDCoMKg
IGJldHdlZW4gKDEpIGFuZCAoMikgKGJsb2NrZWQgb24gcXVpZXNjZWQgYnV0IGFscmVhZHkgaGF2
ZQo+IMKgwqAgdGhlIHFfdXNhZ2VfY291bnRlcikgdG8gcnVuIGFuZCBjb21wbGV0ZS4KPgo+IC0t
PiBhdCB0aGlzIHBvaW50IGFueW9uZSB3YWl0aW5nIGZvciBxdWV1ZSBmcmVlemUgc2hvdWxkIG5v
dyBiZQo+IMKgwqDCoCBhYmxlIHRvIGNvbXBsZXRlIChlLmcuIHVwZGF0ZV9ucl9od19xdWV1ZXMp
Lgo+Cj4gNy4gd2FpdCBmb3Igc3RhcnRlZCBmcmVlemUgKHBhaXJlZCB0byBiYWxhbmNlIHRoZSBm
cmVlemVfY291bnRlcikKPiA4LiB1bmZyZWV6ZSB0aGUgcXVldWUgLSBwYWlyZWQgd2l0aCAoMSkK
Cm9rLiBCdXQgeW91IG5ldmVyIHN0YXRlZCB3aGVyZSBpbiB0aGVzZSBzdGVwcyB0aGUgdHJhbnNw
b3J0IHF1ZXVlIGlzIG5vIApsb25nZXIgbGl2ZS7CoCBJIHRoaW5rIHlvdSdyZSBzYXlpbmcgKDYp
IHdpbGwgcHJvY2VzcyB0aGUgaW8sIG5vdCBhYm9ydCAKaXQgbGlrZSB0aGUgImRyYWluIiBzdGVw
LCBzbyBpdCBjYW4gcnVuIHRvIGNvbXBsZXRpb24gb24gdGhlIGxpbmsuwqAgClRoYXQncyBvayBm
b3IgYSB1c2VyLWluaXRpYXRlZCByZXNldCwgYnV0IGlmIHRoZSByZXNldCBpcyBkdWUgdG8gYSAK
bGluay1zaWRlIGVycm9yIHN1Y2ggYXMgdGhlIEZDIGNhc2UsIHRoZSBxdWV1ZXMgYXJlbid0IGxp
dmUgYW5kIHRoZSBvbmx5IAp3YXkgdG8gY29tcGxldGUgdGhlIGlvIGlzIHRvIGZhaWwgaXQgd2l0
aCBzb21lIGVycm9yLiBBbmQgZm9yIG5vbi1tcGF0aCwgCnRoYXQgZXJyb3IgbWF5IHN1cmZhY2Ug
YmFjayB0byB0aGUgaXNzdWVyLgoKPgo+PiBBcyB0Y3AgZGlkIGNoYW5nZSBzdGF0ZSB0byBDb25u
ZWN0aW5nIGJlZm9yZSBtYWtpbmcgdGhlIAo+PiB1cGRhdGVfbnJfaHdfcXVldWVzIGNhbGwsIHll
dCB3ZSBkaWRuJ3QgY2hhbmdlIHRoZSBiZWhhdmlvciBvZiAKPj4gcmVzY2hlZHVsaW5nIGlmIENv
bm5lY3RpbmcgYW5kICFxLT5saXZlLCB3aGF0IGRpZCB0aGUgcGF0Y2ggYWN0dWFsbHkgCj4+IGRv
IHRvIGhlbHAgPwo+Cj4gQXMgSSBzYWlkLCB3ZSBzaG91bGRuJ3QgaGF2ZSBJL08gY29tbWFuZHMg
dGhhdCBhcmUgcmVxdWV1ZWQgZm9yZXZlcgo+IHByZXZlbnRpbmcgdGhlIGZyZWV6ZSBmcm9tIGNv
bXBsZXRpbmcuIGlmIHdlIGFyZSBDT05ORUNUSU5HLCB0aGVuCj4gdGhlIHF1ZXVlcyBhcmUgbm90
IHN0YXJ0ZWQsIHNvIHdlIHNob3VsZG4ndCBzZWUgYW55IEkvTyBjb21tYW5kcwo+IGNvbWluZyB5
ZXQuCgp3ZWxsIC0gb2ssIGFuZCB3ZSdyZSBiYWNrIHRvIHdoeSB0aGV5IGFyZSBzdGFydGVkLiBM
ZXQncyBzYXkgd2UncmUgbm90IAp3b3JyZWQgYWJvdXQgY29ubmVjdCBvcmRlcmluZyAtIGFub3Ro
ZXIgcmVhc29uIGZvciB0aGUgY29udGludWVkIHJ1bm5pbmcgCmlzIHNvIHRoYXQgZHVyaW5nIGFu
IGV4dGVuZGVkIHJlY29ubmVjdCBwZXJpb2QgdGhhdCBtYXkgdGFrZSBhIGNvdXBsZSBvZiAKcmV0
cmllcywgd2UgY2FuIGhhdmUgYSBmYXN0X2lvX2ZhaWwgdGltZW91dCB0byBzdGFydCBmYWlsaW5n
IHRob3NlIApyZXNjaGVkdWxlZCBub3JtYWwgaW9zLiBldmVuIHRoZW4gLSBmYXN0X2lvX2ZhaWwg
c2hvdWxkIGhhdmUgYmVlbiB3aXRoIAptcGF0aCBpb3Mgc28gdGhleSBhbHJlYWR5IHNob3VsZCBo
YXZlIGJlZW4gZmluZS4gQW55IGZhc3RfaW9fZmFpbCB3b3VsZCAKc3RpbGwgcnVuIHRoZSByaXNr
IG9mIHJldHVybmluZyBhbiBlcnJvciB0byB0aGUgaXNzdWVyLgoKCj4KPiDCoCBUaGUgcGF0Y2gg
b25seSBjaGFuZ2VkIHRoZSBxdWV1aW5nIGJlaGF2aW9yIGZvciBDb25uZWN0aW5nCj4+IGFuZCBx
LT5saXZlLsKgIFNvIHdoZXRoZXIgb3Igbm90IHdlIGhpdCBpdCBpcyBkZXBlbmRlbnQgb24gdGhl
IHRpbWluZyAKPj4gb2Ygd2hlbiBhIG5ldyBpbyBpcyByZWNlaXZlZCB2cyB0aGUgY2FsbCB0byBo
cl9od19xdWV1ZXMuwqDCoCBUaGUgcGF0Y2ggCj4+IGRpZG4ndCBoZWxwIHRoaXMuCj4KPiBUaGVy
ZSBhcmUgc29tZSBzdXBwb3J0aW5nIHBhdGNoZXMgSSBzZW50IGZvciB0Y3AgYW5kIHJkbWEgKHRv
IG9wZXJhdGUKPiBpbiB0aGUgb3JkZXIgSSBleHBsYWluZWQgYWJvdmUpLgo+Cj4gSSdsbCByZXNl
bmQgdGhlbSBhcyBhIHNldCBzb29uLgoKb2sgLSBidXQgdW5sZXNzIEknbSBtaXNzaW5nIHNvbWV0
aGluZyB3ZSBoYXZlIHNvbWUgaG9sZXMuCgotLSBqYW1lcwoKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

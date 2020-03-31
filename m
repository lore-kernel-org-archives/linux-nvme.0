Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08579C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 06:42:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1062072A
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 06:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Pq5Q+VlS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1062072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fpUIqlGeaEujB8AHSKG+eEOtC+04ISfl2z8lPJ44iCM=; b=Pq5Q+VlSEpF6Qdog2XBklG8jW
	qrxeOthyzhFm3KlXbYeakRCnV4CrkF/cuXApSsntIQQ8gzrFM/RA7dIoANB80m2eiBWA+CTTBm4xI
	ceOKSz0suz23fncZNlc+pV+hkdpp3d4F8LCCYZ166/dVROCyb77nD3K2P1fmIXNXFK/FfXPA/seiq
	2WJ6LhU97hSaEorl3ITVHXo33X0+UYEj/Eaj/6mDghYuj7WXO6TfnzBNRG4pUfW1zTj6ziUoKKWeV
	5kut1rgFFVmRTNwzE5l8NJoslnLzpVaLdsW11A4p7fSjglzwTvdrKRhdI1q9H3kg58X1fgZs+Gn/x
	VXPBFxJHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJAbX-0004bR-2C; Tue, 31 Mar 2020 06:42:31 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJAbU-0004ar-OE
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 06:42:30 +0000
Received: by mail-pg1-f196.google.com with SMTP id k5so7700864pga.2
 for <linux-nvme@lists.infradead.org>; Mon, 30 Mar 2020 23:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BHUKHkdJOWf9FSpVH/DLKRI6gEKyzHZv3B/pcqR+Ybk=;
 b=Pcol0xIhnwrNVm+c/9Ph+GqKtWxg0XuZX9ztti1kJfToZeQNHn8Vo3LCya4HYe18cc
 /fM7Il34DY1g7OlIs9K+lGPsh1llMTWkmqLRvTE1iLxlw5/YOicJHQ4139IFEAMrRZWp
 JNHXQzQI95s6Xk84G8+u1S7gfRWDo4JR6IQULI26jhu1rFEshGPRdnhYXD3/ZGJcvT6a
 3vhomflJHwEY/hl9dyuTVTdVqPXRGiR7I5w5icYhpkGxH11UYZ9hTy+L8X/Bvp88UIAo
 ypbpJ7BKMVpbq3SRQUjKaxwMDBsOlhLG/odrY2u/3MaSXO/igkdD+tpL1PX8u6VGqYR0
 pooQ==
X-Gm-Message-State: AGi0PuYVkXa5ouqpWPRK1SDN8Hq4aVT2UMZc6cZZxN0GcasmysXcQcaG
 R8BwreBa5gNiRTOtyynAfutskwDp
X-Google-Smtp-Source: APiQypLOF7pM+iMPoMvYgLD+53zY69mLR5jDip/vrbWIHhIdOsXVZU8+pjnjMFm/wrAiMpGX+DVomw==
X-Received: by 2002:a63:8643:: with SMTP id x64mr2737687pgd.108.1585636947417; 
 Mon, 30 Mar 2020 23:42:27 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:b015:431e:549a:54d?
 ([2601:647:4802:9070:b015:431e:549a:54d])
 by smtp.gmail.com with ESMTPSA id x71sm11612350pfd.129.2020.03.30.23.42.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 30 Mar 2020 23:42:26 -0700 (PDT)
Subject: Re: [PATCH] nvmet-rdma: Fix double free of rdma queue
To: Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1585477302-4307-1-git-send-email-israelr@mellanox.com>
 <39a9e27b-51fa-6c87-8e5f-17f4f7318bd0@grimberg.me>
 <05c7907c-9c43-2a2b-c760-bff0364892d9@mellanox.com>
 <f356a0d4-2e05-f629-ebab-a55e7e0c369b@grimberg.me>
 <b5111042-d90a-0c48-6fe0-3cceca1b75a2@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <edbcdf17-ef8c-f937-bea6-b5bdffb7b202@grimberg.me>
Date: Mon, 30 Mar 2020 23:42:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b5111042-d90a-0c48-6fe0-3cceca1b75a2@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200330_234228_786712_90AD6A81 
X-CRM114-Status: GOOD (  22.52  )
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
Cc: Shlomi Nimrodi <shlomin@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAzLzMwLzIwIDI6MzcgQU0sIElzcmFlbCBSdWtzaGluIHdyb3RlOgo+IE9uIDMvMzAvMjAy
MCAxMTo1NiBBTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPj4KPj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbnZtZS90YXJnZXQvcmRtYS5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9yZG1hLmMKPj4+
Pj4gaW5kZXggMzdkMjYyYS4uNTkyMDllMyAxMDA2NDQKPj4+Pj4gLS0tIGEvZHJpdmVycy9udm1l
L3RhcmdldC9yZG1hLmMKPj4+Pj4gKysrIGIvZHJpdmVycy9udm1lL3RhcmdldC9yZG1hLmMKPj4+
Pj4gQEAgLTEzODAsMTMgKzEzODAsMTQgQEAgc3RhdGljIHZvaWQgCj4+Pj4+IG52bWV0X3JkbWFf
cXVldWVfY29ubmVjdF9mYWlsKHN0cnVjdCByZG1hX2NtX2lkICpjbV9pZCwKPj4+Pj4gwqAgewo+
Pj4+PiDCoMKgwqDCoMKgIFdBUk5fT05fT05DRShxdWV1ZS0+c3RhdGUgIT0gTlZNRVRfUkRNQV9R
X0NPTk5FQ1RJTkcpOwo+Pj4+PiDCoCArwqDCoMKgIHByX2VycigiZmFpbGVkIHRvIGNvbm5lY3Qg
cXVldWUgJWRcbiIsIHF1ZXVlLT5pZHgpOwo+Pj4+PiArCj4+Pj4+IMKgwqDCoMKgwqAgbXV0ZXhf
bG9jaygmbnZtZXRfcmRtYV9xdWV1ZV9tdXRleCk7Cj4+Pj4+IC3CoMKgwqAgaWYgKCFsaXN0X2Vt
cHR5KCZxdWV1ZS0+cXVldWVfbGlzdCkpCj4+Pj4+ICvCoMKgwqAgaWYgKCFsaXN0X2VtcHR5KCZx
dWV1ZS0+cXVldWVfbGlzdCkpIHsKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIGxpc3RfZGVsX2lu
aXQoJnF1ZXVlLT5xdWV1ZV9saXN0KTsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHNjaGVkdWxlX3dv
cmsoJnF1ZXVlLT5yZWxlYXNlX3dvcmspOwo+Pj4+Cj4+Pj4gVGhpcyBoYXMgYSBoaWRkZW4gYXNz
dW1wdGlvbiB0aGF0IHRoZSBjb25uZWN0IGhhbmRsZXIgYWxyZWFkeQo+Pj4+IHNjaGVkdWxlZCB0
aGUgcmVsZWFzZS4KPj4+Pgo+Pj4+IFdoeSBkb24ndCB3ZSBzaW1wbHkgbm90IHF1ZXVlIHRoZSBy
ZWxlYXNlX3dvcmsgaW4gdGhlIGFjY2VwdAo+Pj4+IGZhaWx1cmUgYW5kIHJldHVybiBhIG5lZ2F0
aXZlIHN0YXR1cyBjb2RlIHRvIGltcGxpY2l0bHkgcmVtb3ZlIHRoZQo+Pj4+IGNtX2lkPyB0aGlz
IHdheSB3ZSB3aWxsIG5ldmVyIHNlZSBhbnkgY20gZXZlbnRzIGFuZCB3ZSBkb24ndAo+Pj4+IG5l
ZWQgdG8gaGFuZGxlIGl0Lgo+Pj4KPj4+IFRoaXMgY2hhbmdlcyB0aGUgZmxvdyBidXQgSSBndWVz
cyB3ZSBjYW4gY2hlY2sgdGhpcyBvdXQuCj4+Pgo+Pj4gQnV0IHN0aWxsLCB0aGlzIGZsb3cgY2Fu
IGJlIGNhbGxlZCBmcm9tIDMgZGlmZmVyZW50IGV2ZW50cyAKPj4+IChSRE1BX0NNX0VWRU5UX1JF
SkVDVEVELCBSRE1BX0NNX0VWRU5UX1VOUkVBQ0hBQkxFLCAKPj4+IFJETUFfQ01fRVZFTlRfQ09O
TkVDVF9FUlJPUikgc28gSSBwcmVmZXIgdG8gbG9jYXRlIHRoZSBzY2hlZHVsZV93b3JrIAo+Pj4g
dW5kZXIgdGhlICJpZiIuCj4+Cj4+IFRoaXMgaWYgaXMgb25seSBjaGVja2VkIGluIGNvbm5lY3Qg
ZXJyb3IuIEFueXdheSwgaWYgeW91IGZlZWwgdGhhdAo+PiB0aGlzIGZsb3cgaXMgcmFjeSwgcGVy
aGFwcyBpbXBsZW1lbnQgYSBwcm9wZXIgc2VyaWFsaXphdGlvbiwgaW5zdGVhZAo+PiBvZiBjaGVj
a2luZyBhIHJhbmRvbSAiaWYiIHRoYXQgbWFrZXMgdGhlIHJlYWRlciB0aGluayB3aHkgYXJlIHRo
ZXkKPj4gZXZlbiByZWxhdGVkLgo+IAo+IFRoaXMgImlmIiBpcyBleGFjdGx5IGxpa2Ugd2UgYXJl
IGRvaW5nIGF0IG52bWV0X3JkbWFfcXVldWVfZGlzY29ubmVjdCgpLgoKWW91J3JlIHJpZ2h0LgoK
PiBBbGwgdGhlIG90aGVyIHBsYWNlcyBiZWZvcmUgY2FsbGluZyBfX252bWV0X3JkbWFfcXVldWVf
ZGlzY29ubmVjdCgpIAo+IGRlbGV0ZSB0aGUgcXVldWUgZnJvbSB0aGUgbGlzdC4KPiAKPiBTbyBJ
IGd1ZXNzIG15IGNoYW5nZSBhbHNvIHByb3RlY3QgdXMgZnJvbSByYWNlcyB3aXRoIAo+IG52bWV0
X3JkbWFfZGVsZXRlX2N0cmwvbnZtZXRfcmRtYV9yZW1vdmVfb25lLgo+IAo+IEJlc2lkZSB0aGF0
LCB3aHkgZG8gd2UgbmVlZCB0byBjaGVjayBpZiB0aGUgbGlzdCBpcyBub3QgZW1wdHkgYmVmb3Jl
IAo+IHJlbW92aW5nIGl0IGZyb20gdGhlIGxpc3QgYXQgbnZtZXRfcmRtYV9xdWV1ZV9jb25uZWN0
X2ZhaWwoKT8KPiAKPiBJIGRvbid0IHNlZSBhIHJlYXNvbiB3aHkgdG8gcmVtb3ZlIG9ubHkgdGhl
IHF1ZXVlIGZyb20gdGhlIGxpc3Qgd2l0aG91dCAKPiBzY2hlZHVsZSB0aGUgcmVsZWFzZSB3b3Jr
LgoKVGhhdCBpcyBmaW5lIHdpdGggbWUsIGFzc3VtaW5nIHdlIGhhdmUgYSBwcm9wZXIgY29tbWVu
dC4KCkJ1dCBpZiB3ZSB0YWtlIGEgc3RlcCBiYWNrLCBudm1ldF9yZG1hX2NyZWF0ZV9xdWV1ZV9p
YiBkb2VzIG5vdCBjcmVhdGUKdGhlIGNtX2lkLCBzbyB3aHkgc2hvdWxkIGRlc3Ryb3lfcXVldWVf
aWIgZGVzdHJveSBpdD8KCldoYXQgaWYgd2UgbWFkZSBkZXN0cm95aW5nIHRoZSBjbV9pZCBpbiBy
ZWxlYXNlX3dvcmsgKG91dCBvZiAKbnZtZXRfcmRtYV9mcmVlX3F1ZXVlKSBhbmQgaGF2ZSB0aGUg
YWNjZXB0IGVycm9yIHBhdGggcmV0dXJuIGEgbm9ybWFsCm5lZ2F0aXZlIHJldCB0byBpbXBsaWNp
dGx5IGRlc3Ryb3kgdGhlIGNtX2lkPwoKSW4gYSBzZW5zZSwgdGhhdCB3b3VsZCBtYWtlIHRoZSBi
ZWhhdmlvciBzeW1tZXRyaWMuIFRob3VnaHRzPwoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBs
aXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtbnZtZQo=

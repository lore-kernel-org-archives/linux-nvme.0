Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544D9C433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 17:51:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 236C320672
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 17:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qGebydGB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 236C320672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1FJN9yAAwXWfzRtDnpowyF9VC5ZoPu39eO6WqYNqQOs=; b=qGebydGBnXcccard7AiSacOiL
	JrjCPZJkbZmu+fIqOIE4p3S3WfugKwX7YXbWReH/U0UorkVIx+ZAb0kuBHfVjwB8qPjcsWAzYql/k
	sq7x/zdmKXZ9X6UnFtf/wXifsmJbCLk6osgYwXZ8IZRvJ4Xp0mk+m2pqVaiUKdF5Mib6IZaWtolML
	Fryf0WdKbYRq+5COLjhYymtlD5skOwaKmo4RpIIr4WTbyxZCAkt6nqgN9QAlmnuhaSbMMG5D+kAe/
	d11N+w8WAN5O+na3CDRKqUix5K5D+HAYA6TJVYUYjHNNIeZhKgNjufO7hhQRhevDvRV22uTqSdmhQ
	h1Od8sbuw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Tkm-0004Ty-LE; Tue, 28 Jul 2020 17:51:04 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Tkj-0004Tc-Re
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 17:51:02 +0000
Received: by mail-pl1-f195.google.com with SMTP id t1so1117864plq.0
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 10:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3DbEA1qo0vM5OO/NfYF5qqowzJm2MsnALXmSz2MubeU=;
 b=eR/ea/VlH4PusTo0p1eJO5/WcwCr4ece22xq2TBVlsy2opVYuCGHK5KajMnHzu2I+s
 fYdwtt8o8x7mV+yV/xtsgnWQloKyRCLXTj7DG5LXdNyB8MjOlTRXe02FT2FU29gvqAI2
 V85xlqKCQ4K7TTj0eA2Wnq3yknqgJ9VbewphEgAIRVTODPjjhYNcICF+Bxy+EC8TpyNz
 CP6Z5jKgvkqyoOoLRU3lSETXiIC8+VNqFtadvTn79BOcgiTSEM5nLKa4oKxk6rwcQEak
 2wROEB6Q3xS5I1kcqYPYhG/msNgwzCiHmpEnuo2k5iG2peDPIs/xukkJ5Tlo42r7c1na
 L24w==
X-Gm-Message-State: AOAM531r9HW8PyY3bUJcKgUWbRjJEfGtlWdBV10u0yZ5EECt3wwnPm7G
 AP4SV2R3eoAH5NcOJiZsjEEZ0Fdg
X-Google-Smtp-Source: ABdhPJxt/DE4zVV9yXpzpzi599YayT1T5Q23KytutZTQz3pBZ7Jjoxxp+v5wrzsjS8tOaJK675teyg==
X-Received: by 2002:a17:90a:f192:: with SMTP id
 bv18mr5213392pjb.21.1595958659263; 
 Tue, 28 Jul 2020 10:50:59 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe?
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id h23sm19338246pfo.166.2020.07.28.10.50.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 10:50:58 -0700 (PDT)
Subject: Re: [PATCH] nvme-fabrics: allow to queue requests for live queues
To: James Smart <james.smart@broadcom.com>, Chao Leng <lengchao@huawei.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
References: <20200728053523.21657-1-sagi@grimberg.me>
 <8ff91295-9393-a548-a46f-85d415d9cbc9@huawei.com>
 <233d8e35-f85f-458e-05ad-5baba1b04bbb@grimberg.me>
 <c782f0c1-76b2-cc67-6770-eb55f9e2a3aa@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <612f10f0-3cdd-a7c3-e666-ad9f5c835d00@grimberg.me>
Date: Tue, 28 Jul 2020 10:50:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c782f0c1-76b2-cc67-6770-eb55f9e2a3aa@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_135101_931376_E8408929 
X-CRM114-Status: GOOD (  27.27  )
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

Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYyBiL2RyaXZlcnMv
bnZtZS9ob3N0L2ZhYnJpY3MuYwo+Pj4+IGluZGV4IDRlYzQ4MjlkNjIzMy4uMmU3ODM4ZjQyZTM2
IDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYwo+Pj4+ICsrKyBi
L2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYwo+Pj4+IEBAIC01NjQsMjEgKzU2NCwxMyBAQCBi
b29sIF9fbnZtZl9jaGVja19yZWFkeShzdHJ1Y3QgbnZtZV9jdHJsIAo+Pj4+ICpjdHJsLCBzdHJ1
Y3QgcmVxdWVzdCAqcnEsCj4+Pj4gwqAgewo+Pj4+IMKgwqDCoMKgwqAgc3RydWN0IG52bWVfcmVx
dWVzdCAqcmVxID0gbnZtZV9yZXEocnEpOwo+Pj4+IC3CoMKgwqAgLyoKPj4+PiAtwqDCoMKgwqAg
KiBJZiB3ZSBhcmUgaW4gc29tZSBzdGF0ZSBvZiBzZXR1cCBvciB0ZWFyZG93biBvbmx5IGFsbG93
Cj4+Pj4gLcKgwqDCoMKgICogaW50ZXJuYWxseSBnZW5lcmF0ZWQgY29tbWFuZHMuCj4+Pj4gLcKg
wqDCoMKgICovCj4+Pj4gLcKgwqDCoCBpZiAoIWJsa19ycV9pc19wYXNzdGhyb3VnaChycSkgfHwg
KHJlcS0+ZmxhZ3MgJiBOVk1FX1JFUV9VU0VSQ01EKSkKPj4+ICJpZiAoIWJsa19ycV9pc19wYXNz
dGhyb3VnaChycSkpIiBzaG91bGQgbm90IGRlbGV0ZS4gQmVjYXVzZSBpZiB3ZSAKPj4+IGRlbGV0
ZSwKPj4+IHRoZSBub3JtYWwgaW8gd2lsbCBiZSBzZW5kIHRvIHRhcmdldCwgdGhlIHRhcmdldCBj
YW4gbm90IHRyZWF0IHRoZSBpbwo+Pj4gaWYgdGhlIHF1ZXVlIGlzIG5vdCBOVk1FX0NUUkxfTElW
RS4KPj4KPj4gU3VyZSBpdCBkb2VzLCB0aGUgb25seSByZWFzb24gZm9yIHVzIHRvIGRlbnkgdGhp
cyBJL08sIGlzIGlmIHRoZSBxdWV1ZQo+PiBpcyBub3QgbGl2ZS4gVGhlIGNvbnRyb2xsZXIgc3Rh
dGUgc2hvdWxkIG9ubHkgX2FkdmlzZV8gdXMgaWYgd2UgbmVlZCB0bwo+PiBsb29rIGF0IHRoZSBx
dWV1ZSBzdGF0ZS4KPiAKPiBJIGRpc2FncmVlIHN0cm9uZ2x5IHdpdGggcmVtb3ZpbmcgdGhlIGNo
ZWNrIG9uIE5WTUVfUkVRX1VTRVJDTUQuIFdlJ3ZlIAo+IHNlZW4gY2xpIGlvY3RscyBnb2luZyB0
byB0aGUgYWRtaW4gcXVldWUgd2hpbGUgd2UncmUgaW4gdGhlIG1pZGRsZSBvZiAKPiBkb2luZyBj
b250cm9sbGVyIGluaXRpYWxpemF0aW9uIGFuZCBpdCdzIGhhcyBob3NlZCB0aGUgY29udHJvbGxl
ciBzdGF0ZSAKPiBpbiBzb21lIGNhc2VzLiBXZSd2ZSBzZWVuIGNvbW1hbmRzIGlzc3VlZCBiZWZv
cmUgdGhlIGNvbnRyb2xsZXIgaXMgaW4gCj4gdGhlIHByb3BlciBzdGF0ZS7CoCBUaGUgYWRtaW4g
cXVldWUgbWF5IGJlIGxpdmUgLSBidXQgd2UgZG9uJ3QgCj4gbmVjZXNzYXJpbHkgd2FudCBvdGhl
ciBpbyBzbmVha2luZyBpbi4KCkNhbiB5b3UgcGxlYXNlIGdpdmUgYW4gZXhhbXBsZT8gTlZNRV9S
RVFfVVNFUkNNRCBzaG91bGQgbm90IGJlIGFueQpkaWZmZXJlbnQgZnJvbSBhbnkgb3RoZXIgdHlw
ZSBvZiBJL08uCgpBbHNvLCBkbyBub3RlIHRoYXQgcGNpIGRvZXMgYWxsb3cgdG8gcXVldWUgYW55
IHR5cGUgb2YgY29tbWFuZCBiYXNlZApvbiB0aGUgcXVldWUgc3RhdGUgb25seS4gZmFicmljcyBz
aG91bGQgYmUgc2xpZ2h0bHkgZGlmZmVyZW50IGJlY2F1c2UKd2UgaGF2ZSB0aGUgQ09OTkVDVElO
RyBzdGF0ZSB3aGVyZSB3ZSB3YW50IHRvIGxldCB0aGUgY29ubmVjdCBjb21tYW5kCm9ubHkgdG8g
YmUgaXNzdWVkLgoKCj4gQXMgZm9yIHRoZSBibGtfcnFfaXNfcGFzc3Rocm91Z2ggY2hlY2sgLSBJ
IGd1ZXNzIEkgY2FuIHNlZSBpdCBiZWluZyAKPiBiYXNlZCBvbiB0aGUgcXVldWUgc3RhdGUsIGFu
ZCB0aGUgY2hlY2sgbG9va3Mgb2vCoCAod2Ugc2hvdWxkIG5ldmVyIHNlZSAKPiAhYmxrX3JxX2lz
X3Bhc3N0aHJvdWdoIG9uIHRoZSBhZG1pbiBxKS4KPiBCdXQuLi4KPiAtIEkgZG9uJ3Qga25vdyB3
aHkgaXQgd2FzIHRoYXQgaW1wb3J0YW50IHRvIGNoYW5nZSBpdC4gT24gdGhlIGNvbm5lY3Rpbmcg
Cj4gcGF0aCwgYWxsIHlvdSdyZSBkb2luZyBpcyBsZXR0aW5nIGlvIHN0YXJ0IGZsb3dpbmcgYmVm
b3JlIGFsbCB0aGUgcXVldWVzIAo+IGhhdmUgYmVlbiBjcmVhdGVkLsKgIERpZCB5b3UgcmVhbGx5
IG5lZWQgdG8gc3RhcnQgdGhhdCBtdWNoIHNvb25lciA/CgpUaGUgaXNzdWUgaXMgdGhhdCBjb250
cm9sbGVyIGluIFJFU0VUVElORyBzdGF0ZSB3aWxsIGhhdmUgcmVxdWVzdHMgdGhhdAphcmUgYmVp
bmcgaXNzdWVkLCBhbmQgaWYgd2UgZG9uJ3QgbGV0IGl0IHBhc3MgdGhyb3VnaCwgaXQgd2lsbCBo
YW5nCmFyb3VuZCBmb3JldmVyIGJlaW5nIHJlcXVldWVkIHByZXZlbnRpbmcgcXVldWUgZnJlZXpl
IHRvIGNvbXBsZXRlLgoKU2VlIGJ1ZyByZXBvcnQgZnJvbSBLcmlzaG5hbXJhanUgRXJhcGFyYWp1
LgoKPiAKPiAtIEJ1dCBvbiB0aGUgcmVzZXR0aW5nIHBhdGgsIG9yIGRlbGV0aW5nIGNhc2VzLCB5
b3UndmUgYWRkZWQgYSBjb25kaXRpb24gCj4gbm93IHdoZXJlIHRoZSBjb250cm9sbGVyIHN0YXRl
IHdhcyBjaGFuZ2VkLCBidXQgdGhlcmUgd2FzIGEgZGVsYXkgYmVmb3JlIAo+IHRoZSB0cmFuc3Bv
cnQgbWFya2VkIHRoZSBxdWV1ZSBsaXZlLiBJdCdzIGNvbW1vbiBwcmFjdGljZSBpbiB0aGUgCj4g
dHJhbnNwb3J0cyB0byBjaGFuZ2Ugc3RhdGUgdGhlbiBzY2hlZHVsZSBhIHdvcmsgZWxlbWVudCB0
byBwZXJmb3JtIHRoZSAKPiBhY3R1YWwgc3RhdGUgY2hhbmdlLsKgIFdoeSB3b3VsZCB5b3Ugd2Fu
dCBpbyB0byBjb250aW51ZSB0byBmbG93IGR1cmluZyAKPiB0aGF0IHdpbmRvdyA/wqDCoCBUaGlz
IG1heSBicmluZyBvdXQgb3RoZXIgcHJvYmxlbXMgd2UndmUgYXZvaWRlZCBpbiB0aGUgCj4gcGFz
dC4KCldoYXQgYXJlIHlvdSByZWZlcnJpbmcgdG8/IHRoZSBjaGFuZ2UgaGVyZT8gdGhlIGNvbnRy
b2xsZXIgcmVzZXQgbXVzdAphbGxvdyByZXF1ZXN0cyB0aGF0IGNhbWUgaW4gYmVmb3JlIHdlIHN0
YXJ0ZWQgcXVldWUgZnJlZXplIHRvIHBhc3MsCm90aGVyd2lzZSBmcmVlemUgd2lsbCBuZXZlciBj
b21wbGV0ZS4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

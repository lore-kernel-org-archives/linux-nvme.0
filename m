Return-Path: <SRS0=DaKL=5S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C98C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 15:38:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80733206F6
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2020 15:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Hrhaj6z+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80733206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=OK1GjAZ+hJyfBmCcsOTYtN377Sp5Xqce1K4AudhyLTs=; b=Hrhaj6z+KZRIZmy9A8qCZcDw2
	zi+EaNBHHpb1nCsMoK4s7ViJm2mVNIwIR6mEdbr4jVqUYI5eflsqOP5FVcM79QpS9Ty4ify4dDLAk
	xrKVDLC0iEm8F/oLtmXNOxCLT8kvyQSR2sob9/S8Km/xRP170GgHlh8YSUmmWzMzQ6HfgWZFy14S0
	Hb2mPO0EUncNiVxNWhEOhwjRIhCHM+17WYcRYVqrOreb06sy2PiXnNmw1KgIcOxeO18yNwEbJZdyt
	myfkmr9723esBvxwphYPUelAvYXWjBqrpwl3eJj1GKDlwKSHLjP/Gg+txo74pnNDfGVKw0Gn/GiSO
	hDhKXObbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jK1vE-0000vu-BQ; Thu, 02 Apr 2020 15:38:24 +0000
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jK1vB-0000vD-HW
 for linux-nvme@lists.infradead.org; Thu, 02 Apr 2020 15:38:22 +0000
Received: by mail-pj1-f43.google.com with SMTP id q16so3383071pje.1
 for <linux-nvme@lists.infradead.org>; Thu, 02 Apr 2020 08:38:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wz655RF1Aj9oR1vphNySmC5gTdznp5FTHNAhmFh7qKk=;
 b=gb6zSzKmy4cRTHv4Lc4BlM6JVCKc8MdOnm2FIo2BdsWL5QFOraMYuLJ2RMaMYN2sWa
 P8wzVa0QEVs9ROJu3j0awnw91/9CMnFBY7pxjgdavlciiZ1j3oQ0jG/XxJxzp/4JLEds
 HCcn7B3rItgUFhiVVLqoaWteGlfwyOTVX39UXD2LRP6mqv1qak9wBpNcOU/f7UZRYgQE
 XOKHNGwMMrzdTMouaAh6++ee2YhOmFmeMQ/fSt/zlIY2u+lTdKgwBkoU8W0PWVkIhUHJ
 uxfKLuZ3xShNtE5ACXLN3CBTezEiKvo26WMnMlfUqIYq1WuLttOcfyqmhqsiE30t7tJG
 9SSg==
X-Gm-Message-State: AGi0PuZLga1LQKyu3TxsdgF7r1sv0kvYzzE6wH8JTThJ7Q6vaWAH2DMY
 QfY7sbxuCJS5cN8MeYEcSKYxuWQ0
X-Google-Smtp-Source: APiQypIr+WDOV75NMT5QCw1ylgVqYKcIBlIbI9n3qU1OQHiqEqrXX3h5H3OdbZmRfLFsM7SYb0ROOQ==
X-Received: by 2002:a17:90b:2351:: with SMTP id
 ms17mr4567814pjb.163.1585841899638; 
 Thu, 02 Apr 2020 08:38:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a836:db4c:a7ac:3d7c?
 ([2601:647:4802:9070:a836:db4c:a7ac:3d7c])
 by smtp.gmail.com with ESMTPSA id 11sm3975131pfz.91.2020.04.02.08.38.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 02 Apr 2020 08:38:19 -0700 (PDT)
Subject: Re: nvme deadlock with ANA
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <5e38c566-3f26-288d-1004-161d1084b468@grimberg.me>
 <20200402151854.GA11784@lst.de>
 <7fce512e-deb6-2357-d627-d1a698a8269b@grimberg.me>
 <4ec0c3ba-398d-0922-87f4-4b0a99a79abb@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b657d8a2-14af-ef3d-6483-fcbbbbfe3897@grimberg.me>
Date: Thu, 2 Apr 2020 08:38:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4ec0c3ba-398d-0922-87f4-4b0a99a79abb@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200402_083821_581206_18569844 
X-CRM114-Status: GOOD (  15.79  )
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 linux-nvme <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+Pj4gSSB3YW50IHRvIGNvbnN1bHQgd2l0aCB5b3UgZ3V5cyBvbiBhIGRlYWRsb2NrIGNvbmRp
dGlvbiBJJ20gYWJsZSB0bwo+Pj4+IGhpdCB3aXRoIGEgdGVzdCB0aGF0IGluY29ycG9yYXRlIGNv
bnRyb2xsZXIgcmVjb25uZWN0LCBhbmEgdXBkYXRlcwo+Pj4+IGFuZCBsaXZlIEkvTyB3aXRoIHRp
bWVvdXRzLgo+Pj4+Cj4+Pj4gVGhpcyBpcyB0cnVlIGZvciBOVk1lL1RDUCwgYnV0IGNhbiBhbHNv
IGhhcHBlbiBpbiByZG1hIG9yIHBjaSAKPj4+PiBkcml2ZXJzIGFzCj4+Pj4gd2VsbC4KPj4+Pgo+
Pj4+IFRoZSBkZWFkbG9jayBjb21iaW5lcyA0IGZsb3dzIGluIHBhcmFsbGVsOgo+Pj4+IC0gbnMg
c2Nhbm5pbmcgKHRyaWdnZXJlZCBmcm9tIHJlY29ubmVjdCkKPj4+PiAtIHJlcXVlc3QgdGltZW91
dAo+Pj4+IC0gQU5BIHVwZGF0ZSAodHJpZ2dlcmVkIGZyb20gcmVjb25uZWN0KQo+Pj4+IC0gRlMg
SS9PIGNvbWluZyBpbnRvIHRoZSBtcGF0aCBkZXZpY2UKPj4+Pgo+Pj4+ICgxKSBucyBzY2Fubmlu
ZyB0cmlnZ2VycyBkaXNrIHJldmFsaWRhdGlvbiAtPiB1cGRhdGUgZGlzayBpbmZvIC0+Cj4+Pj4g
wqDCoMKgwqAgZnJlZXplIHF1ZXVlIC0+IGJ1dCBibG9ja2VkLCB3aHk/Cj4+Pgo+Pj4gV2hhdCBk
b2VzIC0+IGJ1dCBibG9ja2VkIG1lYW4/Cj4+Cj4+IEl0IGlzIGJsb2NrZWQgYW5kIGNhbm5vdCBj
b21wbGV0ZSwgYmVjYXVzZSBvZiAoMikKPj4KPj4+PiAoMikgdGltZW91dCBoYW5kbGVyIHJlZmVy
ZW5jZSB0aGUgZ191c2FnZV9jb3VudGVyIC0gPiBidXQgYmxvY2tzIGluCj4+Pj4gwqDCoMKgwqAg
dGhlIHRpbWVvdXQgaGFuZGxlciwgd2h5Pwo+Pj4KPj4+IFRoZSB0aW1lb3V0IGhhbmRsZXIgb2J2
aW91c2x5IG5lZWRzIHRvIGtlZXAgdGhlIHF1ZXVlIGFsaXZlIHdoaWxlCj4+PiBydW5uaW5nLsKg
IFdlIGNvdWxkIHRoaW5rIG9mIGRvaW5nIGEgdHJ5X2dldCwgdGhvdWdoPwo+Pgo+PiBJdCBpcyBr
ZWVwaW5nIHRoZSBxdWV1ZSBhbGl2ZSwgdGhhdCBpcyBub3QgdGhlIGlzc3VlLiBpdCBpcyBibG9j
a2VkIGluCj4+IHRoZSBkcml2ZXIgLnRpbWVvdXQoKSBoYW5kbGVyIChpLmUuIG52bWVfdGNwX3Rp
bWVvdXQpLgo+Pgo+PiBUaGUgcmVhc29uIHRoYXQgaXQgYmxvY2tlZCBhbmQgY2Fubm90IG1ha2Ug
Zm9yd2FyZCBwcm9ncmVzcyBpcyBiZWNhdXNlCj4+IHRoZSBkcml2ZXIgdGltZW91dCBoYW5kbGVy
IHdpbGwgY2FsbCBudm1lX3N0b3BfcXVldWVzKCksIHdoaWNoIGlzCj4+IGJsb2NrZWQgYXMgdGhp
cyB0YWtlcyBuYW1lc3BhY2VzX3J3c2VtLi4uCj4+Cj4+IFRoZXJlIGlzIGEgY2hhaW4gb2YgZGVw
ZW5kZW5jeSB0aGF0IGlzIGRlYWRsb2NraW5nIHdpdGggY2lyY3VsYXIKPj4gZGVwZW5kZW5jeS4K
PiAKPiBDYW4ndCB5b3Ugc2ltcGx5IGNhbGwgJ252bWVfcmVzZXRfY3RybCgpJyA/Cj4gU2VlbXMg
dG8gd29yayByZWFzb25hYmx5IHdlbGwgb24gdGhlIGZjIHNpZGUsIHNvIEkgd29uZGVyIHdoYXQn
cyAKPiBkaWZmZXJlbnQgZm9yIHRjcCAuLi4KCkFzIEkgbWVudGlvbmVkLCB0aGlzIGlzIG5vdCBz
cGVjaWZpYyBmb3IgdGNwLCBpdCBwY2kgdGltZW91dCBoYW5kbGVyCmNhbiBibG9jayBqdXN0IGFz
IHdlbGwgYmVjYXVzZSBpdCBjYWxscyBudm1lX2Rldl9kaXNhYmxlIHdoaWNoIGNhbGxzCm52bWVf
c3RvcF9xdWV1ZXMuIFRoZSByZXN0IG9mIHRoZSBmbG93cyBhcmUgbm90IHJlbGF0ZWQgdG8gdGhl
CnRyYW5zcG9ydC4KClRoZXJlIGlzIG5vIGV4cGVjdGF0aW9uIGZyb20gdGhlIGRyaXZlciB0byBh
bHdheXMgZGVmZXIgaGFuZGxpbmcgdGhlCnRpbWVvdXQgdG8gYSBkaWZmZXJlbnQgY29udGV4dCwg
YnV0IHNob3VsZCB3ZSBtYWtlIHRoYXQgb3BlcmF0aW9uIGZvcgpudm1lIHRyYW5zcHJvdHMgYXQg
bGVhc3Q/CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

Return-Path: <SRS0=n325=NQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD41C4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Aug 2021 09:05:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D253610CD
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Aug 2021 09:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D253610CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wJg6lZxbCrkdkFZAUiCTwXyd9yAZtrcUYYimxf7rIaQ=; b=P3TZBibo0b8tcD
	EBxPhZ3YXJ7ucQD83MzWhNgXSSg2hch45FRAGwc9vvXMtBIL74owSVMHEbrFF1fpFJTsEOE++dIvk
	a0/dDluc6acbybBJ5LakLMXe6u6tDNzJhIyug49JiutJKgsdk7P09JP6uvGdL7TGMyYXUOiuz4bqh
	UPScRGOZl91cKBr41mir4LMxweV5kd/k+B21+Tcpw88Ne4ornFaF0cHA8HVTjBIwY+SV6BpOGzUGp
	vihBwOdRBlcf6SUY0vVsUvQ4mSRR0xWfNyKo6qeFpmZ2o0yJ3gxcz/ClKtwhNciBHKYXOZWciJ7ll
	toL4oU7tj0gjkzqhh9iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mIoq2-0062Ak-1j; Wed, 25 Aug 2021 09:04:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mIopp-00628O-W9
 for linux-nvme@lists.infradead.org; Wed, 25 Aug 2021 09:04:39 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0FB9D67357; Wed, 25 Aug 2021 11:04:25 +0200 (CEST)
Date: Wed, 25 Aug 2021 11:04:24 +0200
From: "hch@lst.de" <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: sasaki tatsuya <tatsuya6.sasaki@kioxia.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: update keep alive interval when kato is modified
Message-ID: <20210825090424.GA468@lst.de>
References: <526a1a756d6c4643b15b1b305cc32817@kioxia.com>
 <05033836-83b9-c060-0348-774a02b60d01@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <05033836-83b9-c060-0348-774a02b60d01@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210825_020438_222831_E25AE7B2 
X-CRM114-Status: GOOD (  18.99  )
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

T24gVHVlLCBBdWcgMjQsIDIwMjEgYXQgMDE6NDE6NDRQTSAtMDcwMCwgU2FnaSBHcmltYmVyZyB3
cm90ZToKPj4gK3sKPj4gKwkvKgo+PiArCSAqIEtlZXAgYWxpdmUgY29tbWFuZHMgaW50ZXJ2YWwg
b24gdGhlIGhvc3Qgc2hvdWxkIGJlIHVwZGF0ZWQKPj4gKwkgKiB3aGVuIEtBVE8gaXMgbW9kaWZp
ZWQgYnkgU2V0IEZlYXR1cmVzIGNvbW1hbmRzLgo+PiArCSAqLwo+PiArCWlmIChjbWQtPm9wY29k
ZSA9PSBudm1lX2FkbWluX3NldF9mZWF0dXJlcyAmJgo+PiArCSAgICAoY21kLT5jZHcxMCAmIDB4
RkYpID09IE5WTUVfRkVBVF9LQVRPKSB7Cj4+ICsJCS8qIG1zIC0+IHMgKi8KPgo+IG5vIG5lZWQg
Zm9yIHRoaXMgY29tbWVudC4KPgo+PiArCQl1bnNpZ25lZCBpbnQgbmV3X2thdG8gPSBESVZfUk9V
TkRfVVAoY21kLT5jZHcxMSwgMTAwMCk7Cj4+ICsKPj4gKwkJbnZtZV91cGRhdGVfa2VlcF9hbGl2
ZShjdHJsLCBuZXdfa2F0byk7Cj4KPiBJIHRoaW5rIHlvdSBjYW4gbm93IGlubGluZSBudm1lX3Vw
ZGF0ZV9rZWVwX2FsaXZlIGhlcmUsIG5vIG5lZWQgdG8ga2VlcAo+IGl0IGluIGEgZnVuY3Rpb24u
CgpBY3R1YWxseSwg0ZZmIHRoaW5raW5nIGFoZWFkIEkgdGhpbmsgb25lIGhlbHBlciBwZXIgZml4
dXAgd291bGQgYmUgcmVhbGx5CnVzZWZ1bCB0byBrZWVwIHRoZSBjb2RlIG9yZ2FuaXplZC4gIEJ1
dCB0aGUgRElWX1JPVU5EX1VQIHNob3VsZCBtb3ZlIGludG8KbnZtZV91cGRhdGVfa2VlcF9hbGl2
ZSB0byBrZWVwIGl0IHNlbGYtY29udGFpbmVkLgpXZSBjYW4gdGhlbiByZXN0cnVjdHVyZSB0aGUg
Y2FsbGVyIGEgYml0IHRvIG1ha2UgaXQgZWFzaWVyIHRvIGV4cGFuZDoKCglzd2l0Y2ggKGNtZC0+
b3Bjb2RlKSB7CgljYXNlIG52bWVfYWRtaW5fc2V0X2ZlYXR1cmVzOgoJCXN3aXRjaCAoY21kLT5j
ZHcxMCAmIDB4ZmYpIHsKCQljYXNlIE5WTUVfRkVBVF9LQVRPOgoJCQludm1lX3VwZGF0ZV9rZWVw
X2FsaXZlKGN0cmwsIGNtZCk7CgkJCWJyZWFrOwoJCX0KCX0KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

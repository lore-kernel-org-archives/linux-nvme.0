Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D69C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 09:06:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D7C22B51
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 09:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D7C22B51
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HBuha7LAfXuYy52pcHLhwiyLU4/Eg2m6apXdG2fIQ8o=; b=3cNRUWQJh0EbL02KL2mn6nRM0
	2KE796cAwBFzn4DZFOO5wOEQXlhL4MZm/pxk6jKa0h63JIswLoU0eKHQwlmEIl4WfsbBTK81pHH9e
	cCTxx3sH/a6AjonDJd3o5vD+/am4h2UfbZjMw3s+N9zXsHvJoKuCceUr8X/R0vnfMHNkLI0SzIalm
	0DKAI/+KkTHPxwk26fNfeMMsqSI/DhX7g42EYb9gKbKCzDOD2szu1ugTnt6dNgeVt1PsPuxANw4e4
	8a94Ojp4plVfROxg9ntPLxqzRlJKDxg21Z9PGo/2vkGK+jJiZ1W/rCiOlaCQ00VwUFnzptNQ75yGj
	zmYmtNpuQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2VvC-0002bg-Db; Thu, 21 Jan 2021 09:06:30 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2VvA-0002aG-4g
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 09:06:28 +0000
Received: by mail-wm1-f48.google.com with SMTP id 190so775899wmz.0
 for <linux-nvme@lists.infradead.org>; Thu, 21 Jan 2021 01:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5HmyGtKqj+8I9c2l4T8oRXQ+RIfM350busV8nW/+tzo=;
 b=BB3XyB01j4YM1nWq/YR/wP/gPWwDRM5h1VBZPP3Jq0C0hop7gDEgycYq32A4b1D7Qn
 uiv4amOLGxqqRYNJKfG9To0CI2mvA8lEP/YfhC1F8Ze0P7ejS8l7yIibRtInZcshNDOd
 +Ublhz/qgv/L0oZQPAySNM3t9F8MH79AoLSb910WAZMd/F8OalYW5RmIqEQSLn+KM0gd
 8eWe29Nr3G2HwhDk+csaploYKf/AbjvhvwImUGkDokq7bpiumlKcp2feU6FbB5CoTL8F
 w8yucZ0R8+bz7RW052j5UJwO3AfvlH7o072wTE6aHKGXdDeQCAawnGZgD3cv7CiAF1/d
 V4+g==
X-Gm-Message-State: AOAM531ubSnznU3gEZzBTSY/EwvsH9o4idY5hq28EYfHFKkejub0b5t9
 vwalZ1s0pv9t58nwHeGF5CZ80vZ7fZo=
X-Google-Smtp-Source: ABdhPJw9heKUjEIa/CCuvLoU6GFc/LwFPnmT9pbkklrEx/2Xnr6IBm7lL0i3M5PBJ1CC+j4fah9mPQ==
X-Received: by 2002:a1c:4907:: with SMTP id w7mr7997521wma.118.1611219986440; 
 Thu, 21 Jan 2021 01:06:26 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:fd72:cb73:9874:5790?
 ([2601:647:4802:9070:fd72:cb73:9874:5790])
 by smtp.gmail.com with ESMTPSA id r25sm6529123wrr.64.2021.01.21.01.06.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Jan 2021 01:06:25 -0800 (PST)
Subject: Re: kernel oops after nvme_set_queue_count()
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <d5f00c36-2981-0a0c-7a6d-b4ab2c8d139e@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <7b532e99-8d94-28c1-6e82-bb1d9eb4b439@grimberg.me>
Date: Thu, 21 Jan 2021 01:06:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d5f00c36-2981-0a0c-7a6d-b4ab2c8d139e@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_040628_194857_94321646 
X-CRM114-Status: GOOD (  25.19  )
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

Cj4gSGkgYWxsLAo+IAo+IGEgY3VzdG9tZXIgb2Ygb3VycyByYW4gaW50byB0aGlzIG9vcHM6Cj4g
Cj4gWzQ0MTU3LjkxODk2Ml0gbnZtZSBudm1lNTogSS9PIDIyIFFJRCAwIHRpbWVvdXQKPiBbNDQx
NjMuMzQ3NDY3XSBudm1lIG52bWU1OiBDb3VsZCBub3Qgc2V0IHF1ZXVlIGNvdW50ICg4ODApCj4g
WzQ0MTYzLjM0NzU1MV0gbnZtZSBudm1lNTogU3VjY2Vzc2Z1bGx5IHJlY29ubmVjdGVkICg2IGF0
dGVtcHRzKQo+IFs0NDE2OC40MTQ5NzddIEJVRzogdW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgcGFn
aW5nIHJlcXVlc3QgYXQgCj4gZmZmZjg4OGUyNjFlNzgwOAo+IFs0NDE2OC40MTQ5ODhdIElQOiAw
eGZmZmY4ODhlMjYxZTc4MDgKPiBbNDQxNjguNDE0OTk0XSBQR0QgOThjMmFlMDY3IFA0RCA5OGMy
YWUwNjcgUFVEIGY1NzkzNzA2MyBQTUQgCj4gODAwMDAwMGY2NjAwMDFlMwo+IAo+IEl0J3MgcmVs
YXRlZCB0byB0aGlzIGNvZGUgc25pcHBldCBpbiBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiAK
PiAgwqDCoMKgwqAvKgo+ICDCoMKgwqDCoCAqIERlZ3JhZGVkIGNvbnRyb2xsZXJzIG1pZ2h0IHJl
dHVybiBhbiBlcnJvciB3aGVuIHNldHRpbmcgdGhlIHF1ZXVlCj4gIMKgwqDCoMKgICogY291bnQu
wqAgV2Ugc3RpbGwgd2FudCB0byBiZSBhYmxlIHRvIGJyaW5nIHRoZW0gb25saW5lIGFuZCBvZmZl
cgo+ICDCoMKgwqDCoCAqIGFjY2VzcyB0byB0aGUgYWRtaW4gcXVldWUsIGFzIHRoYXQgbWlnaHQg
YmUgb25seSB3YXkgdG8gZml4IHRoZW0gCj4gdXAuCj4gIMKgwqDCoMKgICovCj4gIMKgwqDCoMKg
aWYgKHN0YXR1cyA+IDApIHsKPiAgwqDCoMKgwqDCoMKgwqAgZGV2X2VycihjdHJsLT5kZXZpY2Us
ICJDb3VsZCBub3Qgc2V0IHF1ZXVlIGNvdW50ICglZClcbiIsIHN0YXR1cyk7Cj4gIMKgwqDCoMKg
wqDCoMKgICpjb3VudCA9IDA7Cj4gCj4gCj4gY2F1c2luZyBudm1lX3NldF9xdWV1ZV9jb3VudCgp
IF9ub3RfIHRvIHJldHVybiBhbiBlcnJvciwgYnV0IHJhdGhlciBsZXQgCj4gdGhlIHJlY29ubmVj
dCBjb21wbGV0ZS4KPiBPZiBjb3Vyc2UsIGFzIHRoaXMgZmFpbHVyZSBpcyBkdWUgdG8gYSB0aW1l
b3V0IChjZiB0aGUgc3RhdHVzIGNvZGU7IDg4MAo+IGlzIE5WTUVfU0NfSE9TVF9QQVRIX0VSUk9S
KSwgdGhlIGFkbWluIHF1ZXVlIGhhcyBiZWVuIHRvcm4gZG93biBieSB0aGUgCj4gdHJhbnNwb3J0
LCBjYXVzaW5nIHRoaXMgY3Jhc2guCj4gCj4gU28sIHF1ZXN0aW9uOiBfd2h5XyBkbyB3ZSBpZ25v
cmUgdGhlIHN0YXR1cz8KClRoaXMgdXNlZCB0byBleGlzdCBpbiBwY2kgd2hlcmUgYSBjb250cm9s
bGVyIHJlc2V0IHdpbGwgZmFpbCB0byBzZXQgdXAKSS9PIHF1ZXVlcywgYXQgbGVhc3QgdGhlIGNv
bnRyb2xsZXIgY2FuIGFjY2VwdCBhZG1pbiBjb21tYW5kcyB0byBnZXQKc29tZSBkaWFnbm9zdGlj
cyAocGVyaGFwcyBhbiBlcnJvciBsb2cgcGFnZSkuCgo+IEZvciBmYWJyaWNzIEkgY29tcGxldGVs
eSBmYWlsIHRvIHNlZSB0aGUgcmVhc29uIGhlcmU7IGV2ZW4gX2lmXyBpdCAKPiB3b3JrZWQgd2Ug
d291bGQgZW5kIHVwIHdpdGggYSBjb25uZWN0aW9uIGZvciB3aGljaCBqdXN0IHRoZSBhZG1pbiBx
dWV1ZSAKPiBpcyBvcGVyYWJsZSwgdGhlIHN0YXRlIGlzIExJVkUsIGFuZCBhbGwgaW5mb3JtYXRp
b24gd2UgY291bGQgZ2xhbmNlIAo+IHdvdWxkIGluZGljYXRlIHRoYXQgdGhlIGNvbm5lY3Rpb24g
aXMgcGVyZmVjdGx5IGhlYWx0aHkuCgpXZSBhbHNvIGhhZCBhIEFETUlOX09OTFkgc3RhdGUgYXQg
c29tZSBwb2ludCwgYnV0IHRoYXQgd2FzIGRyb3BwZWQgYXMKd2VsbCBmb3IgcmVhc29ucyBJIGRv
bid0IHJlbWVtYmVyIGF0IHRoZSBtb21lbnQuCgo+IEl0IGp1c3QgZG9lc24ndCBoYXZlIGFueSBJ
L08gcXVldWVzLgo+IFdoaWNoIHdpbGwgbGVhZCB0byBzb21lIHZlcnkgY29uZnVzZWQgY3VzdG9t
ZXJzIGFuZCBzb21lIHZlcnkgdW5oYXBweSAKPiBzdXBwb3J0IGZvbGtzIHRyeWluZyB0byBmaWd1
cmUgb3V0IHdoYXQgaGFzIGhhcHBlbmVkLgo+IAo+IENhbiB3ZSBqdXN0IGtpbGwgdGhpcyBzdGF0
ZW1lbnQgYW5kIGFsd2F5cyByZXR1cm4gYW4gZXJyb3I/Cj4gSW4gYWxsIG90aGVyIGNhc2VzIHdl
IGFyZSBxdWl0ZSB0cmlnZ2VyLWhhcHB5IHdpdGggY29udHJvbGxlciByZXNldDsgd2h5IAo+IG5v
dCBoZXJlPwoKSSB0aGluayB3ZSB3aWxsIHdhbnQgdG8ga2VlcCB0aGUgZXhpc3RpbmcgYmVoYXZp
b3IgZm9yIHBjaSwgYnV0IGFncmVlIHdlCnByb2JhYmx5IHdhbnQgdG8gY2hhbmdlIGl0IGZvciBm
YWJyaWNzLi4uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

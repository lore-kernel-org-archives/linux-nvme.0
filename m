Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D9DC4360C
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 15:19:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8C2364E90
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 15:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8C2364E90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5jdV3JvEguuGAYrD8p8tlCO2Jg5DLZhZiJWx7khwQjc=; b=hfkFvwWaJ+QH8O3VnHUQ3oRBN
	WLs+lwe9ZJKeGYjDflhDIOXxBw0jkyc+YWf6Uaeb1sjUIJLvJjQFTDBhLL7LgChfBjBXSwDHTWHJi
	6ty76H8ZWDtX6czeotASzSYlxewy3laVLUAw/o01IX0eqtUSt8bzG3rHA31skkrBzsPzrBhpmeuaz
	tWZnTSd2UmuFAOMAN3q/yTtI0C5iGgj0z2ZaB0e2E61GJ2ST5i25sU0t4LlzxASlm9Y9ZVELyA8mz
	Md6SGoL26Uqapt8fJQhRc0EvR2yOhlqxeAmZM37QRSdCg5D6Dn4Df9WH1fz9EbBORJDCJtJtNI5Ga
	6sAbadZ0Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHTGu-005M79-Jz; Wed, 03 Mar 2021 15:18:45 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHSPH-00572c-1G
 for linux-nvme@lists.infradead.org; Wed, 03 Mar 2021 14:23:27 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id B91DEAC24;
 Wed,  3 Mar 2021 14:23:12 +0000 (UTC)
Subject: Re: [PATCH 1/3] nvme: fixup kato deadlock
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Daniel Wagner <dwagner@suse.de>, Chao Leng <lengchao@huawei.com>,
 linux-nvme@lists.infradead.org
References: <20210302092644.80701-1-hare@suse.de>
 <20210302092644.80701-2-hare@suse.de> <20210303084210.GB9898@lst.de>
 <fee91925-6e3f-69b3-2d9e-2561789425a6@suse.de>
 <20210303123549.GB28477@lst.de>
 <9655fc98-08c8-ff7d-0aaf-f29b935221d6@suse.de>
Message-ID: <9ea53e09-2ab5-733a-7f1d-fd2404794149@suse.de>
Date: Wed, 3 Mar 2021 15:23:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <9655fc98-08c8-ff7d-0aaf-f29b935221d6@suse.de>
Content-Language: en-US
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

T24gMy8zLzIxIDI6MTEgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiAzLzMvMjEgMToz
NSBQTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4+IE9uIFdlZCwgTWFyIDAzLCAyMDIxIGF0
IDAxOjAxOjUwUE0gKzAxMDAsIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPj4+PiBBZGRpbmcgQkxL
X01RX1JFUV9OT1dBSVQgc2hvdWxkIGJlIGEgc2VwYXJhdGUgcHJlcCBwYXRjaCwgdG9nZXRoZXIg
d2l0aAo+Pj4+IHJlZHVjaW5nIHRoZSBudW1iZXIgb2YgcmVzZXJ2ZWQgdGFncy4KPj4+Pgo+Pj4g
T2theS4KPj4+IEJ1dCB3aHkgd291bGQgd2UgbmVlZCB0byByZWR1Y2UgdGhlIG51bWJlciBvZiB0
YWdzPyBJdCdzIG5vdCB0aGF0IHdlJ3JlCj4+PiBjaGFuZ2luZyBhbnl0aGluZyB3aXRoIHRoZSBh
bGxvY2F0aW9uLCB3ZSdyZSBqdXN0IGd1YXJhbnRlZWQgdG8gZmFpbCBpZgo+Pj4gZm9yIHNvbWUg
cmVhc29uIHRoZSBzdGFjayBtZXNzZXMgdXAuCj4+Cj4+IEJlY2F1c2Ugd2UgY291bGQgb3RoZXJ3
aXNlIHN0aWxsIGhhdmUgdG8ga2VlcCBhbGl2ZSByZXF1ZXN0cywgb3Igb25lIGtlZXAKPj4gYSBs
aXZlIGFuZCBvbmUgY29ubmVjdCByZXF1ZXN0cyBhbGxvY2F0ZWQgYXQgdGhlIHNhbWUgdGltZS4K
Pj4KPiBCdXQgdGhhdCdzIHdoYXQgd2UgaGF2ZSB0b2RheS4KPiBTbyB5b3UncmUgc2F5aW5nIHRo
YXQgd2Ugc2hvdWxkIGhhdmUgb25seSBfMV8gcmVzZXJ2ZWQgcmVxdWVzdCwgaWUKPiBlaXRoZXIg
Y29ubmVjdCBfb3JfIGtlZXAtYWxpdmU/Cj4gU3VyZSB3ZSBjYW4gZG8gdGhhdDsgSSBoYWQgYmVl
biBhIGJpdCBoZXNpdGFudCB0byBkbyB0aGF0IHNlZWluZyB0aGF0IGl0Cj4gaGFkIGJlZW4gdGhh
dCB3YXkgc2luY2UgdGhlIGJlZ2lubmluZy4KPiAKPiBCdXQgaWYgeW91IHNheSAuLi4KPiAKQWN0
dWFsbHksIGhhdmluZyB0aG91Z2h0IGEgYml0IG1vcmUsIEknbSBub3Qgc3VyZSBpZiB3ZSBzaG91
bGQgY2hhbmdlCnRoYXQuIENoYW5naW5nIHRoZSBudW1iZXIgb2YgcmVzZXJ2ZWQgY29tbWFuZHMg
X3dpbGxfIGhhdmUgYW4gaW1wYWN0IG9uCmVycm9yIHJlY292ZXJ5LCB1cCB0byB0aGUgcG9pbnQg
dGhhdCB3ZSBjYW5ub3QgaXNzdWUgYSAnY29ubmVjdCcgY29tbWFuZAppZiBhIGtlZXAtYWxpdmUg
Y29tbWFuZCBpcyBzdGlsbCBydW5uaW5nLgpXaGljaCBtZWFucyB3ZSBtaWdodCBiZSBzZWVpbmcg
c3B1cmlvdXMgY29ubmVjdGlvbiBmYWlsdXJlcyBkdXJpbmcKcmVjb3ZlcnksIHNvbWV0aGluZyB3
aGljaCBJJ2QgYmUgdmVyeSBjYXV0aW91cyBhYm91dC4KCkNoZWVycywKCkhhbm5lcwotLSAKRHIu
IEhhbm5lcyBSZWluZWNrZQkJICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKaGFy
ZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKU1VTRSBTb2Z0
d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJl
cmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHRjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1h
aWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

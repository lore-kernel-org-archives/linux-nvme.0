Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014A5C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 10:58:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B1C6044F
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 10:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B9B1C6044F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:Cc:To:Subject:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=YOaIdIEPxopnC1xLjY9Ru/3CiuMhsvRC0PCpqeFODHs=; b=ctzIGkWBIOtpe45T9vwLy1b2xM
	KqtZ3C6A9YCRkoFQwaCFagHiDB/xnPKS03L4vU7+e/wYdf1a9jsjykGN5+PIsfbdJ6HBhAryfE6ua
	91QXrdfsYp7gKece29+HzAmzt13J5ocUsyKmbntQTSGp05P0FoP/2hqxebTv7ledbU/FhspMrW7+A
	CkEwwW1gSDNm/lmmP+u6fDf1DyAK6t5UJSh4kdvO/qWwle0cJfy/+Ih6rHZUuQKBQSvlFwpz+AWw6
	jNyeDz1kYeU/8SZ0dsIrvHvyMO6a4bQZuywTLwvNT08VS7B0R2f9bnPeyjG/PqDjHKw745antX0qw
	YIQWsjwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ68q-005Kw9-35; Tue, 14 Sep 2021 10:58:20 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ68m-005KvM-Fh
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 10:58:17 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D8353220C5;
 Tue, 14 Sep 2021 10:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1631617092; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0BswG7qSJgCzajVNxbDwn7zIx+XZp6tCFNp9WPxMd8s=;
 b=SZQ7KSjLP75G3pTSVq1YE5zzy3v5t+Suur6vN4bpPHr6xh1K2OLR45bOWk8LbjgtcAqayb
 IEKyn6HQ6j1pkYZgseFsB6mJu7eHax0zEBE/FG+nKFGkwN7FuVpbdgLfCdjAuRoMy2I1tX
 KBRLm2LW3D1A393UMiYYlRja1EkGpWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1631617092;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0BswG7qSJgCzajVNxbDwn7zIx+XZp6tCFNp9WPxMd8s=;
 b=8Q69zGwW0+E2TV7wgqXp6fxR9qTqUiOcZzNQh4KbTm2Jz/rPA2Ew1i7tt/ASIqZtexdIjw
 el9oerfT5Z7WmHAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BAB6D13D3F;
 Tue, 14 Sep 2021 10:58:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KMn8LESAQGHadgAAMHmgww
 (envelope-from <hare@suse.de>); Tue, 14 Sep 2021 10:58:12 +0000
Subject: Re: [PATCH v7 3/3] nvme-fc: Remove freeze/unfreeze around
 update_nr_hw_queues
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>,
 James Smart <jsmart2021@gmail.com>
References: <20210914092008.40370-1-dwagner@suse.de>
 <20210914092008.40370-4-dwagner@suse.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <040a7eef-3603-2d8f-0576-3fceafc80de8@suse.de>
Date: Tue, 14 Sep 2021 12:58:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210914092008.40370-4-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_035816_719098_92A78467 
X-CRM114-Status: GOOD (  20.69  )
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

T24gOS8xNC8yMSAxMToyMCBBTSwgRGFuaWVsIFdhZ25lciB3cm90ZToKPiBGcm9tOiBKYW1lcyBT
bWFydCA8anNtYXJ0MjAyMUBnbWFpbC5jb20+Cj4gCj4gUmVtb3ZlIHRoZSBmcmVlemUvdW5mcmVl
emUgYXJvdW5kIGNoYW5nZXMgdG8gdGhlIG51bWJlciBvZiBoYXJkd2FyZQo+IHF1ZXVlcy4gU3R1
ZHkgYW5kIHJldGVzdCBoYXMgaW5kaWNhdGVkIHRoZXJlIGFyZSBubyBpb3MgdGhhdCBjYW4gYmUK
PiBhY3RpdmUgYXQgdGhpcyBwb2ludCBzbyB0aGVyZSBpcyBub3RoaW5nIHRvIGZyZWV6ZS4KPiAK
PiBudm1lLWZjIGlzIGRyYWluaW5nIHRoZSBxdWV1ZXMgaW4gdGhlIHNodXRkb3duIGFuZCBlcnJv
ciByZWNvdmVyeSBwYXRoCj4gaW4gX19udm1lX2ZjX2Fib3J0X291dHN0YW5kaW5nX2lvcy4KPiAK
PiBUaGlzIHBhdGNoIHByaW1hcmlseSByZXZlcnRzIDg4ZTgzN2VkMGYxZiAibnZtZS1mYzogd2Fp
dCBmb3IgcXVldWVzIHRvCj4gZnJlZXplIGJlZm9yZSBjYWxsaW5nIHVwZGF0ZV9ocl9od19xdWV1
ZXMiLiBJdCdzIG5vdCBhbiBleGFjdCByZXZlcnQgYXMKPiBpdCBsZWF2ZXMgdGhlIGFkanVzdGlu
ZyBvZiBodyBxdWV1ZXMgb25seSBpZiB0aGUgY291bnQgY2hhbmdlcy4KPiAKPiBTaWduZWQtb2Zm
LWJ5OiBKYW1lcyBTbWFydCA8anNtYXJ0MjAyMUBnbWFpbC5jb20+Cj4gW2R3YWduZXI6IGFkZGVk
IGV4cGxhbmF0aW9uIHdoeSBubyBJTyBpcyBwZW5kaW5nXQo+IFNpZ25lZC1vZmYtYnk6IERhbmll
bCBXYWduZXIgPGR3YWduZXJAc3VzZS5kZT4KPiAtLS0KPiAgZHJpdmVycy9udm1lL2hvc3QvZmMu
YyB8IDIgLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMgYi9kcml2ZXJzL252bWUvaG9zdC9mYy5jCj4gaW5k
ZXggNmViZTY4Mzk2NzEyLi5hYTE0YWQ5NjNkOTEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9udm1l
L2hvc3QvZmMuYwo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZjLmMKPiBAQCAtMjk1Nyw5ICsy
OTU3LDcgQEAgbnZtZV9mY19yZWNyZWF0ZV9pb19xdWV1ZXMoc3RydWN0IG52bWVfZmNfY3RybCAq
Y3RybCkKPiAgCQlkZXZfaW5mbyhjdHJsLT5jdHJsLmRldmljZSwKPiAgCQkJInJlY29ubmVjdDog
cmV2aXNpbmcgaW8gcXVldWUgY291bnQgZnJvbSAlZCB0byAlZFxuIiwKPiAgCQkJcHJpb3JfaW9x
X2NudCwgbnJfaW9fcXVldWVzKTsKPiAtCQludm1lX3dhaXRfZnJlZXplKCZjdHJsLT5jdHJsKTsK
PiAgCQlibGtfbXFfdXBkYXRlX25yX2h3X3F1ZXVlcygmY3RybC0+dGFnX3NldCwgbnJfaW9fcXVl
dWVzKTsKPiAtCQludm1lX3VuZnJlZXplKCZjdHJsLT5jdHJsKTsKPiAgCX0KPiAgCj4gIAlyZXQg
PSBudm1lX2ZjX2NyZWF0ZV9od19pb19xdWV1ZXMoY3RybCwgY3RybC0+Y3RybC5zcXNpemUgKyAx
KTsKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJz
LAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9y
YWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0
MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIu
IDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJ
bWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

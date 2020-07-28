Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BAEC43457
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 03:34:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11501206D4
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 03:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kaI7z3Fm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11501206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=9JGwbnkJE2jwNy6VzZkyanDZlwloFwea47XFLwxuKzg=; b=kaI7z3Fmmw8N3fKPYIJqypuCY
	n8tAIKk2xU+Viuo97fkDV8LsIAOE6yzZBeZPUBOgvRlot0Lsj22mB3QrBdaVgaqZ+FoapNUW/EDFJ
	X+Kbp2XChG4UKj767nb2IHh5tQPUncKO2O3jYS8+uVFpqfQiRXTVicoM8mrb50Mekp8TVUcdu8gYk
	KB30SgpkZS1vpSm4qDSmhXX9XoAAIw5oeJEkNqoxdn0+UuuuYcbsxANDojrA2lHQyoUBhuggzLI+W
	dSMH5eMPgL7EC2TZaooIjnYRZw7UTRhTGCqlE9AQLrbZIqvr/j5x+SMhcUtHnGefgMkn1i4fnl5RL
	CNuAIHEHw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0GOB-0003f2-7G; Tue, 28 Jul 2020 03:34:51 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0GO3-0003cg-Nd
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 03:34:44 +0000
Received: by mail-wr1-f66.google.com with SMTP id 88so16794704wrh.3
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 20:34:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sc4FAowpJskWJ+7n9XI9nCyRNop6XuNUwGIt4ML6M/A=;
 b=M5s+8HiJQpv4Ac8V74tmBqRSK7eaQDFf2i2wZ5l4GzzkttAy+EpOm3Dx32/Sz9PvV/
 HN1IVp+p2guT9GEmP766aD6Vr9LI+uPyYrC4I9CVDL5ctJzrBgHU6/oi80c75OgiOpN1
 JtP8l7OyipqGn55ZVjA9XaA+doQpSRaWP7f8C0VDAY9b5ap4timTSrTKOEb21ymAJwKv
 OVt0qWQzYACOAZVW8td6AHsdwgpeQt/7NMCYw2Ie0gL6aXlXivMy9VUTMBfn8mEBkDBt
 sj4e9hnP1R1ppxSdQd6zTIg1m8Vc91mC2OAuXF6Rp3kikjWUXUqeTwGLYu6waaIVbDOd
 MRGg==
X-Gm-Message-State: AOAM530+FgIchLRKnbRD59GHiQWkaPAGGxDOXhAXimP+/ex4x9g/09AZ
 YAsntE5f3rZlfOQCyRZZoso=
X-Google-Smtp-Source: ABdhPJweAqP1gUP39I9aM0lr1EIcnJ+ArNYrUMkbnOTOyRhw7tbtrNLzoyA/wUWYeb3UoA1BXzezSQ==
X-Received: by 2002:a5d:4b0c:: with SMTP id v12mr22762126wrq.199.1595907282762; 
 Mon, 27 Jul 2020 20:34:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b?
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id t25sm1898194wmj.18.2020.07.27.20.34.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 20:34:42 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] nvme: use blk_mq_[un]quiesce_tagset
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-3-sagi@grimberg.me>
 <56517f9c-2d4e-0fee-52d6-20ef9be54bc0@grimberg.me>
 <5d11e813-b0dd-3082-366b-176717cdf3a6@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <92b821a6-a774-d85b-2711-418d36fc10d0@grimberg.me>
Date: Mon, 27 Jul 2020 20:34:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5d11e813-b0dd-3082-366b-176717cdf3a6@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_233443_860185_8624C235 
X-CRM114-Status: GOOD (  17.93  )
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
Cc: linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiBBbGwgY29udHJvbGxlciBuYW1lc3BhY2VzIHNoYXJlIHRoZSBzYW1lIHRhZ3NldCwgc28g
d2UKPj4+IGNhbiB1c2UgdGhpcyBpbnRlcmZhY2Ugd2hpY2ggZG9lcyB0aGUgb3B0aW1hbCBvcGVy
YXRpb24KPj4+IGZvciBwYXJhbGxlbCBxdWllc2NlIGJhc2VkIG9uIHRoZSB0YWdzZXQgdHlwZSAo
ZS5nLgo+Pj4gYmxvY2tpbmcgdGFnc2V0cyBhbmQgbm9uLWJsb2NraW5nIHRhZ3NldHMpLgo+Pj4K
Pj4+IFNpZ25lZC1vZmYtYnk6IFNhZ2kgR3JpbWJlcmcgPHNhZ2lAZ3JpbWJlcmcubWU+Cj4+PiAt
LS0KPj4+IMKgIGRyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyB8IDE0ICsrLS0tLS0tLS0tLS0tCj4+
PiDCoCAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkKPj4+
Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jCj4+PiBpbmRleCAwNWFhNTY4YTYwYWYuLmM0MWRmMjA5OTZkNyAxMDA2NDQK
Pj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYwo+Pj4gKysrIGIvZHJpdmVycy9udm1l
L2hvc3QvY29yZS5jCj4+PiBAQCAtNDU1NywyMyArNDU1NywxMyBAQCBFWFBPUlRfU1lNQk9MX0dQ
TChudm1lX3N0YXJ0X2ZyZWV6ZSk7Cj4+PiDCoCB2b2lkIG52bWVfc3RvcF9xdWV1ZXMoc3RydWN0
IG52bWVfY3RybCAqY3RybCkKPj4+IMKgIHsKPj4+IC3CoMKgwqAgc3RydWN0IG52bWVfbnMgKm5z
Owo+Pj4gLQo+Pj4gLcKgwqDCoCBkb3duX3JlYWQoJmN0cmwtPm5hbWVzcGFjZXNfcndzZW0pOwo+
Pj4gLcKgwqDCoCBsaXN0X2Zvcl9lYWNoX2VudHJ5KG5zLCAmY3RybC0+bmFtZXNwYWNlcywgbGlz
dCkKPj4+IC3CoMKgwqDCoMKgwqDCoCBibGtfbXFfcXVpZXNjZV9xdWV1ZShucy0+cXVldWUpOwo+
Pj4gLcKgwqDCoCB1cF9yZWFkKCZjdHJsLT5uYW1lc3BhY2VzX3J3c2VtKTsKPj4+ICvCoMKgwqAg
YmxrX21xX3F1aWVzY2VfdGFnc2V0KGN0cmwtPnRhZ3NldCk7Cj4+Cj4+IFJyci4uIHRoaXMgb25l
IGlzIHNsaWdodGx5IGFubm95aW5nLiBXZSBoYXZlIHRoZSBjb25uZWN0X3EgaW4KPj4gZmFicmlj
cyB0aGF0IHdlIHVzZSB0byBpc3N1ZSB0aGUgY29ubmVjdCBjb21tYW5kIHdoaWNoIGlzIG5vdwo+
PiBxdWllc2NlZCB0b28uLi4KPj4KPj4gSWYgd2Ugd2lsbCB1c2UgdGhpcyBpbnRlcmZhY2UsIHdl
IGNhbiB1bnF1aWVzY2UgaXQgcmlnaHQgYXdheSwKPj4gYnV0IHRoYXQgc2VlbXMga2luZGEgYmFj
a3dhcmRzLi5JbyBxdWV1ZSBhbmQgYWRtaW4gcXVldWUgaGFzIGRpZmZlcmVudCAKPj4gdHJlYXQg
bWVjaGFuaXNtLCBpbnRyb2R1Y2UKPiBibGtfbXFfcXVpZXNjZV90YWdzZXQgbWF5IG1ha2UgdGhl
IG1lY2hhbmlzbSB1bmNsZWFyLiBTbyB0aGlzIGlzCj4gcHJvYmFibHkgbm90IGEgZ29vZCBjaG9p
Y2UuCgpUaGUgbWVhbmluZyBvZiBibGtfbXFfcXVpZXNjZV90YWdzZXQgaXMgY2xlYXIsIHRoZSBh
d2t3YXJkIHRoaW5nIGlzCnRoYXQgd2UgbmVlZCB0byB1bnF1aWVzY2UgdGhlIGNvbm5lY3RfcSBh
ZnRlciBibGtfbXFfcXVpZXNjZV90YWdzZXQKcXVpZXNjZWQgaXQuCgpJJ20gdGhpbmtpbmcgb2Yg
cmVzb3J0aW5nIGZyb20gdGhpcyBhYnN0cmFjdGlvbi4uLgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=

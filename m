Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EF9C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 16:00:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBACE221F1
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 16:00:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBACE221F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Zi5mIiwAljZqKTD5R8yU5q+EbHa1Bpy7bKLFhqzKPdY=; b=BW/Q35bnFL3W/fmecP9A5aaz4
	X5BWmCsiVXvYCsTnmOT8nYkfLFH3pKSzwKOZd2wIyqKOekm/qIJK93PgQiMnrsD6EcFVI1XKQqer8
	48BJcZPF6Qy3wMg0G29ZASn1AoOEAbbTvCQo6NnthYBb7aDvrFtq8R//3r7peAXV7KxYSxCEtFgnL
	86w2hhr820/p2Z3ZMD74wHa59KskkivmfBc1EaSCjR0cOZV5BHASpM8lTjnpyNF1FmhgBFNx6Vl7s
	uK9fzN/DMcgJ6UYiP5CGFZPW7AVIQhpJF9Dedy5DjrN3fIqBqngotX4qKXo+KUk/Oj5EmSIJXpbnM
	R5lrNL7bw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyzcM-0002Zn-LA; Mon, 11 Jan 2021 16:00:30 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyzcJ-0002XJ-FV
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 16:00:28 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 1C57EB18B;
 Mon, 11 Jan 2021 16:00:20 +0000 (UTC)
Subject: Re: [PATCH] nvme: hwmon: fix crash on device teardown
To: Daniel Wagner <dwagner@suse.de>, Enzo Matsumiya <ematsumiya@suse.de>
References: <20201209213228.5044-1-ematsumiya@suse.de>
 <4ebb1b8c-4bb0-6ebf-3417-d4aee1bdd3a8@suse.de>
 <20201230143805.2v4izgkzbnisssvr@beryllium.lan>
 <20201230151653.ozlqlwef7f2tarwz@beryllium.lan>
 <20201230153138.4f2jd2yd2vkqndby@beryllium.lan>
 <20210104210610.hliiupywksawgei3@hyori>
 <20210105094545.3tq7c6ev5yn3bhyi@beryllium.lan>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <412d45ef-40af-24c3-4aa2-042ecbba05cd@suse.de>
Date: Mon, 11 Jan 2021 17:00:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210105094545.3tq7c6ev5yn3bhyi@beryllium.lan>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_110027_645811_65190419 
X-CRM114-Status: GOOD (  21.81  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMS81LzIxIDEwOjQ1IEFNLCBEYW5pZWwgV2FnbmVyIHdyb3RlOgo+IE9uIE1vbiwgSmFuIDA0
LCAyMDIxIGF0IDA2OjA2OjEwUE0gLTAzMDAsIEVuem8gTWF0c3VtaXlhIHdyb3RlOgo+PiBARGFu
aWVsIG1heWJlIHRyeSB0d2Vha2luZyB5b3VyIHRlc3RzIHRvIHVzZSBhIHNtYWxsZXIgY29udHJv
bGxlcgo+PiBsb3NzIHRpbWVvdXQgKC1sIG9wdGlvbik/IEkgZG8gdGhpcyBvbiBteSB0ZXN0cyBi
ZWNhdXNlIHRoZSBkZWZhdWx0Cj4+IHZhbHVlIGtpY2tzIGluIGFib3V0IDMwbWluIGFmdGVyIGhv
dC1yZW1vdmFsIC0tIGkuZS4geW91Cj4+IGhhdmUgdG8gYWN0dWFsbHkgd2FpdCBmb3IgdGhlIHRp
bWVvdXQgdG8gZXhwaXJlIHRvIHRyaWdnZXIgdGhlIGJ1Zy4KPiAKPiBBcyBmYXIgSSBjYW4gdGVs
bCwgdGhlIGJsa3Rlc3RzIHRlc3QgSSBhbSB1c2luZyB3aWxsIHRyaWdnZXIgdGhlIHNhbWUKPiBi
dWcuIFRoZSBwcm9ibGVtIGlzIHRoYXQgdGhlIGxpZmV0aW1lIG9mIGh3bW9uIHN5c2ZzIGVudHJ5
IHNob3VsZCBiZQo+IGFsaWduZWQgdG8gdGhlIGxpZmV0aW1lIG9mIHRoZSBudm1lIHN5c2ZzIGVu
dHJ5LiBDdXJyZW50bHksIGh3bW9uJ3MKPiBsaWZldGltZSBpcyBib3VuZCB0byB0aGUgbGlmZXRp
bWUgb2YgdGhlIGN0bCBzeXNmcyBlbnRyeS4gV2hlbiB0aGUgbnZtZQo+IGVudHJ5IGdvZXMgYXdh
eSAoYW5kIG9idmlvdXNseSBhbHNvIHRoZSB1bmRlcmx5aW5nIGRldmljZSksIHRoZSBod21vbgo+
IHN5c2ZzIGVudHJ5IHN0aWxsIHJlZmVyZW5jZXMgaXQuCj4gClllYWgsIHVzaW5nIHRoZSBjb250
cm9sbGVyIG5vZGUgZm9yIGRldm0gYWxsb2NhdGlvbnMgaXMgcXVpdGUgZG9kZ3kuCkRvZXMgdGhp
cyBvbmUgaGVscD8KCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvaHdtb24uYyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L2h3bW9uLmMKaW5kZXggNmZkZDA3ZmIzMDAxLi43MjYwYWYwMjhjZjcg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2h3bW9uLmMKKysrIGIvZHJpdmVycy9udm1l
L2hvc3QvaHdtb24uYwpAQCAtMjI2LDcgKzIyNiw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgaHdt
b25fY2hpcF9pbmZvCgogIGludCBudm1lX2h3bW9uX2luaXQoc3RydWN0IG52bWVfY3RybCAqY3Ry
bCkKICB7Ci0gICAgICAgc3RydWN0IGRldmljZSAqZGV2ID0gY3RybC0+ZGV2OworICAgICAgIHN0
cnVjdCBkZXZpY2UgKmRldiA9IGN0cmwtPmRldmljZTsKICAgICAgICAgc3RydWN0IG52bWVfaHdt
b25fZGF0YSAqZGF0YTsKICAgICAgICAgc3RydWN0IGRldmljZSAqaHdtb247CiAgICAgICAgIGlu
dCBlcnI7CkBAIC0yNDAsOCArMjQwLDcgQEAgaW50IG52bWVfaHdtb25faW5pdChzdHJ1Y3QgbnZt
ZV9jdHJsICpjdHJsKQoKICAgICAgICAgZXJyID0gbnZtZV9od21vbl9nZXRfc21hcnRfbG9nKGRh
dGEpOwogICAgICAgICBpZiAoZXJyKSB7Ci0gICAgICAgICAgICAgICBkZXZfd2FybihjdHJsLT5k
ZXZpY2UsCi0gICAgICAgICAgICAgICAgICAgICAgICJGYWlsZWQgdG8gcmVhZCBzbWFydCBsb2cg
KGVycm9yICVkKVxuIiwgZXJyKTsKKyAgICAgICAgICAgICAgIGRldl93YXJuKGRldiwgIkZhaWxl
ZCB0byByZWFkIHNtYXJ0IGxvZyAoZXJyb3IgJWQpXG4iLCBlcnIpOwogICAgICAgICAgICAgICAg
IGRldm1fa2ZyZWUoZGV2LCBkYXRhKTsKICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOwogICAg
ICAgICB9CgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAg
ICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0aW9u
cyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xy
bmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

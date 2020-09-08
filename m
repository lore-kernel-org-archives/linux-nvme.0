Return-Path: <SRS0=ETB4=CR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB1EC433E2
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 08:44:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13A4215A4
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Sep 2020 08:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vXq8gTMR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13A4215A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=694Kwev6h4oZPxyhFvlIikOhCeX4ORtHYNi8bpoUwB4=; b=vXq8gTMRXgcj14gkdDq98eWr6
	qUdqYg+h5ez/4ZU/vsMmHeTbQ2ZZOe8rXMFV17QlEANGOsGZybqMY+v5SUn3B/ONw0j7ek1wonpuc
	WiO+35Zmxyv2zoEd7MgXj4scL83vIYpEw2arLSCxnZL8FwtsYu2USf0HqPk8FLmbzHycGdLJ8irhb
	t42f/10WiszaMdo5cOBYUXbth9boS0l+xJ0WAljcKJ4ut9YFRos601ftzxV9y0/E2vzKTlB8u4VBI
	+PQvMXCBVTEeOR/UW2Ar2L4gThaPwwH5062joPzaabjUJEoR4kjwnp73vZ/vTdqIoh/eN7zy1woBV
	h1rTU3tGg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFZF7-0000Mf-5a; Tue, 08 Sep 2020 08:44:45 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFZF4-0000Lt-JB
 for linux-nvme@lists.infradead.org; Tue, 08 Sep 2020 08:44:43 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 3054BAEE9;
 Tue,  8 Sep 2020 08:44:42 +0000 (UTC)
Subject: Re: [PATCH V3 2/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200908081538.1434936-1-ming.lei@redhat.com>
 <20200908081538.1434936-3-ming.lei@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <54fce956-4e8f-6e4b-0ae1-e0905a06f3e4@suse.de>
Date: Tue, 8 Sep 2020 10:44:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200908081538.1434936-3-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_044442_865591_E8F2A831 
X-CRM114-Status: GOOD (  24.90  )
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
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOS84LzIwIDEwOjE1IEFNLCBNaW5nIExlaSB3cm90ZToKPiBJbiBjYXNlIG9mIEJMS19NUV9G
X0JMT0NLSU5HLCBibGstbXEgdXNlcyBTUkNVIHRvIG1hcmsgcmVhZCBjcml0aWNhbAo+IHNlY3Rp
b24gZHVyaW5nIGRpc3BhdGNoaW5nIHJlcXVlc3QsIHRoZW4gcmVxdWVzdCBxdWV1ZSBxdWllc2Nl
IGlzIGJhc2VkIG9uCj4gU1JDVS4gV2hhdCB3ZSB3YW50IHRvIGdldCBpcyBsb3cgY29zdCBhZGRl
ZCBpbiBmYXN0IHBhdGguCj4gCj4gV2l0aCBwZXJjcHUtcmVmLCBpdCBpcyBjbGVhbmVyIGFuZCBz
aW1wbGVyICYgZW5vdWdoIGZvciBpbXBsZW1lbnRpbmcgcXVldWUKPiBxdWllc2NlLiBUaGUgbWFp
biByZXF1aXJlbWVudCBpcyB0byBtYWtlIHN1cmUgYWxsIHJlYWQgc2VjdGlvbnMgdG8gb2JzZXJ2
ZQo+IFFVRVVFX0ZMQUdfUVVJRVNDRUQgb25jZSBibGtfbXFfcXVpZXNjZV9xdWV1ZSgpIHJldHVy
bnMuCj4gCj4gQWxzbyBpdCBiZWNvbWVzIG11Y2ggZWFzaWVyIHRvIGFkZCBpbnRlcmZhY2Ugb2Yg
YXN5bmMgcXVldWUgcXVpZXNjZS4KPiAKPiBNZWFudGltZSBtZW1vcnkgZm9vdHByaW50IGNhbiBi
ZSByZWR1Y2VkIHdpdGggcGVyLXJlcXVlc3QtcXVldWUgcGVyY3B1LXJlZi4KPiAKPiBGcm9tIGlt
cGxlbWVudGF0aW9uIHZpZXdwb2ludCwgaW4gZmFzdCBwYXRoLCBub3Qgc2VlIHBlcmNwdV9yZWYg
aXMKPiBzbG93ZXIgdGhhbiBTUkNVLCBhbmQgc3JjdSB0cmVlKGRlZmF1bHQgb3B0aW9uIGluIG1v
c3QgZGlzdHJpYnV0aW9ucykKPiBjb3VsZCBiZSBzbG93ZXIgc2luY2UgbWVtb3J5IGJhcnJpZXIg
aXMgcmVxdWlyZWQgaW4gYm90aCBsb2NrICYgdW5sb2NrLAo+IGFuZCByY3VfcmVhZF9sb2NrKCkv
cmN1X3JlYWRfdW5sb2NrKCkgc2hvdWxkIGJlIG11Y2ggY2hlYXAgdGhhbgo+IHNtcF9tYigpLgo+
IAo+IDEpIHBlcmNwdV9yZWYganVzdCBob2xkIHRoZSByY3VfcmVhZF9sb2NrLCB0aGVuIHJ1biBh
IGNoZWNrICYKPiAgICBpbmNyZWFzZS9kZWNyZWFzZSBvbiB0aGUgcGVyY3B1IHZhcmlhYmxlOgo+
IAo+ICAgIHJjdV9yZWFkX2xvY2soKQo+ICAgIGlmIChfX3JlZl9pc19wZXJjcHUocmVmLCAmcGVy
Y3B1X2NvdW50KSkKPiAJdGhpc19jcHVfaW5jKCpwZXJjcHVfY291bnQpOwo+ICAgIHJjdV9yZWFk
X3VubG9jaygpCj4gCj4gMikgc3JjdSB0cmVlOgo+ICAgICAgICAgaWR4ID0gUkVBRF9PTkNFKHNz
cC0+c3JjdV9pZHgpICYgMHgxOwo+ICAgICAgICAgdGhpc19jcHVfaW5jKHNzcC0+c2RhLT5zcmN1
X2xvY2tfY291bnRbaWR4XSk7Cj4gICAgICAgICBzbXBfbWIoKTsgLyogQiAqLyAgLyogQXZvaWQg
bGVha2luZyB0aGUgY3JpdGljYWwgc2VjdGlvbi4gKi8KPiAKPiBBbHNvIGZyb20gbXkgdGVzdCBv
biBudWxsX2JsayhibG9ja2luZyksIG5vdCBvYnNlcnZlIHBlcmNwdS1yZWYgcGVyZm9ybXMKPiB3
b3JzZSB0aGFuIHNyY3UsIHNlZSB0aGUgZm9sbG93aW5nIHRlc3Q6Cj4gCj4gMSkgdGVzdCBzdGVw
czoKPiAKPiBybW1vZCBudWxsX2JsayA+IC9kZXYvbnVsbCAyPiYxCj4gbW9kcHJvYmUgbnVsbF9i
bGsgbnJfZGV2aWNlcz0xIHN1Ym1pdF9xdWV1ZXM9MSBibG9ja2luZz0xCj4gZmlvIC0tYnM9NGsg
LS1zaXplPTUxMkcgIC0tcnc9cmFuZHJlYWQgLS1ub3JhbmRvbW1hcCAtLWRpcmVjdD0xIC0taW9l
bmdpbmU9bGliYWlvIFwKPiAJLS1pb2RlcHRoPTY0IC0tcnVudGltZT02MCAtLWdyb3VwX3JlcG9y
dGluZz0xICAtLW5hbWU9bnVsbGIwIFwKPiAJLS1maWxlbmFtZT0vZGV2L251bGxiMCAtLW51bWpv
YnM9MzIKPiAKPiB0ZXN0IG1hY2hpbmU6IEhQIERMMzgwLCAxNiBjcHUgY29yZXMsIDIgdGhyZWFk
cyBwZXIgY29yZSwgZHVhbAo+IHNvY2tldHMvbnVtYSwgSW50ZWwoUikgWGVvbihSKSBTaWx2ZXIg
NDExMCBDUFUgQCAyLjEwR0h6Cj4gCj4gMikgdGVzdCByZXN1bHQ6Cj4gLSBzcmN1IHF1aWVzY2U6
IDYwNjNLIElPUFMKPiAtIHBlcmNwdS1yZWYgcXVpZXNjZTogNjExM0sgSU9QUwo+IAo+IFNpZ25l
ZC1vZmYtYnk6IE1pbmcgTGVpIDxtaW5nLmxlaUByZWRoYXQuY29tPgo+IENjOiBTYWdpIEdyaW1i
ZXJnIDxzYWdpQGdyaW1iZXJnLm1lPgo+IENjOiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3NjaGVA
YWNtLm9yZz4KPiBDYzogSm9oYW5uZXMgVGh1bXNoaXJuIDxKb2hhbm5lcy5UaHVtc2hpcm5Ad2Rj
LmNvbT4KPiBDYzogQ2hhbyBMZW5nIDxsZW5nY2hhb0BodWF3ZWkuY29tPgo+IC0tLQo+ICBibG9j
ay9ibGstbXEtc3lzZnMuYyAgIHwgICAyIC0KPiAgYmxvY2svYmxrLW1xLmMgICAgICAgICB8IDEz
MCArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLQo+ICBibG9jay9ibGst
c3lzZnMuYyAgICAgIHwgICA2ICstCj4gIGluY2x1ZGUvbGludXgvYmxrLW1xLmggfCAgIDggLS0t
Cj4gIGluY2x1ZGUvbGludXgvYmxrZGV2LmggfCAgIDQgKysKPiAgNSBmaWxlcyBjaGFuZ2VkLCA3
NyBpbnNlcnRpb25zKCspLCA3MyBkZWxldGlvbnMoLSkKPiAKUmV2aWV3ZWQtYnk6IEhhbm5lcyBS
ZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4gSGFubmVzIFJl
aW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJlQHN1c2UuZGUJ
CQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3YXJlIFNvbHV0
aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZwpIUkIgMzY4
MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

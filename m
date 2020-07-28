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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557AEC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 12:42:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2341E2078E
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 12:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qyVj8wJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2341E2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Y+qs0YclP8IIdXI/WB4gjcC2AU4fjuqL5s2PAryZ2TY=; b=qyVj8wJUrmy1jn8A97fvS0JhF
	/HSrOIS/J7Q9pz3XFBf/O4hStSA2h6S+6UoAKOMBDk1qZBqAQ9gYyqgwi4SgMng0skaJCO+YD0oj/
	PFIg6kE2lGbVQoMdOJSNAx9fvM+gIve4T2fN7UcVWWhID9BnE6AKujQ8p+NBpapl8x5AoLezQdobu
	SePjdCSj1fAY7zpHjzuZRNR1uVNUOzHrgia0w1XsmE1FBTrxCWwHCmhuGXP8fLq525X22Z9TT/ONG
	pV/c62SHls+IvD+NRtXeJrZDC8RFtkUFMvP2N+3v5dRSUg85bGTPnCHoeY4hAtxn8r4TtphEUQqft
	FZ/hpn4LA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Ow4-0007ry-Fw; Tue, 28 Jul 2020 12:42:24 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Ow0-0007ni-3r
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 12:42:21 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 0ADA6AD18;
 Tue, 28 Jul 2020 12:42:30 +0000 (UTC)
Subject: Re: [PATCH 1/2] nvme-tcp: use sendpage_ok() to check page for
 kernel_sendpage()
To: Sagi Grimberg <sagi@grimberg.me>
References: <20200726135224.107516-1-colyli@suse.de>
 <f6cf7563-9d8c-baa8-e8e7-e41f9b13e787@grimberg.me>
From: Coly Li <colyli@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Message-ID: <5697358d-2f61-d63f-eee7-c9af346771eb@suse.de>
Date: Tue, 28 Jul 2020 20:42:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <f6cf7563-9d8c-baa8-e8e7-e41f9b13e787@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_084220_387419_9E14044D 
X-CRM114-Status: GOOD (  28.34  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, philipp.reisner@linbit.com,
 linux-nvme@lists.infradead.org,
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
 linux-block@vger.kernel.org, linux-bcache@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Jan Kara <jack@suse.com>,
 stable@vger.kernel.org, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjAyMC83LzI4IDAxOjI1LCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+IAo+IAo+IE9uIDcvMjYv
MjAgNjo1MiBBTSwgQ29seSBMaSB3cm90ZToKPj4gQ3VycmVudGx5IG52bWVfdGNwX3RyeV9zZW5k
X2RhdGEoKSBkb2Vzbid0IHVzZSBrZXJuZWxfc2VuZHBhZ2UoKSB0bwo+PiBzZW5kIHNsYWIgcGFn
ZXMuIEJ1dCBmb3IgcGFnZXMgYWxsb2NhdGVkIGJ5IF9fZ2V0X2ZyZWVfcGFnZXMoKSB3aXRob3V0
Cj4+IF9fR0ZQX0NPTVAsIHdoaWNoIGFsc28gaGF2ZSByZWZjb3VudCBhcyAwLCB0aGV5IGFyZSBz
dGlsbCBzZW50IGJ5Cj4+IGtlcm5lbF9zZW5kcGFnZSgpIHRvIHJlbW90ZSBlbmQsIHRoaXMgaXMg
cHJvYmxlbWF0aWMuCj4+Cj4+IFdoZW4gYmNhY2hlIHVzZXMgYSByZW1vdGUgTlZNZSBTU0Qgdmlh
IG52bWUtb3Zlci10Y3AgYXMgaXRzIGNhY2hlCj4+IGRldmljZSwgd3JpdGluZyBtZXRhIGRhdGEg
ZS5nLiBjYWNoZV9zZXQtPmRpc2tfYnVja2V0cyB0byByZW1vdGUgU1NEIG1heQo+PiB0cmlnZ2Vy
IGEga2VybmVsIHBhbmljIGR1ZSB0byB0aGUgYWJvdmUgcHJvYmxlbS4gQmNhdXNlIHRoZSBtZXRh
IGRhdGEKPj4gcGFnZXMgZm9yIGNhY2hlX3NldC0+ZGlza19idWNrZXRzIGFyZSBhbGxvY2F0ZWQg
YnkgX19nZXRfZnJlZV9wYWdlcygpCj4+IHdpdGhvdXQgX19HRlBfQ09NUC4KPj4KPj4gVGhpcyBw
cm9ibGVtIHNob3VsZCBiZSBmaXhlZCBib3RoIGluIHVwcGVyIGxheWVyIGRyaXZlciAoYmNhY2hl
KSBhbmQKPj4gbnZtZS1vdmVyLXRjcCBjb2RlLiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBudm1lLW92
ZXItdGNwIGNvZGUgYnkgY2hlY2tpbmcKPj4gd2hldGhlciB0aGUgcGFnZSByZWZjb3VudCBpcyAw
LCBpZiB5ZXMgdGhlbiBkb24ndCB1c2Uga2VybmVsX3NlbmRwYWdlKCkKPj4gYW5kIGNhbGwgc29j
a19ub19zZW5kcGFnZSgpIHRvIHNlbmQgdGhlIHBhZ2UgaW50byBuZXR3b3JrIHN0YWNrLgo+Pgo+
PiBTdWNoIGNoZWNrIGlzIGRvbmUgYnkgbWFjcm8gc2VuZHBhZ2Vfb2soKSBpbiB0aGlzIHBhdGNo
LCB3aGljaCBpcyBkZWZpbmVkCj4+IGluIGluY2x1ZGUvbGludXgvbmV0LmggYXMsCj4+IMKgwqDC
oMKgKCFQYWdlU2xhYihwYWdlKSAmJiBwYWdlX2NvdW50KHBhZ2UpID49IDEpCj4+IElmIHNlbmRw
YWdlX29rKCkgcmV0dXJucyBmYWxzZSwgc29ja19ub19zZW5kcGFnZSgpIHdpbGwgaGFuZGxlIHRo
ZSBwYWdlCj4+IG90aGVyIHRoYW4ga2VybmVsX3NlbmRwYWdlKCkuCj4+Cj4+IFRoZSBjb2RlIGNv
bW1lbnRzIGluIHRoaXMgcGF0Y2ggaXMgY29waWVkIGFuZCBtb2RpZmllZCBmcm9tIGRyYmQgd2hl
cmUKPj4gdGhlIHNpbWlsYXIgcHJvYmxlbSBhbHJlYWR5IGdldHMgc29sdmVkIGJ5IFBoaWxpcHAg
UmVpc25lci4gVGhpcyBpcyB0aGUKPj4gYmVzdCBjb2RlIGNvbW1lbnQgaW5jbHVkaW5nIG15IG93
biB2ZXJzaW9uLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBDb2x5IExpIDxjb2x5bGlAc3VzZS5kZT4K
Pj4gQ2M6IENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlhLmt1bGthcm5pQHdkYy5jb20+Cj4+
IENjOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPj4gQ2M6IEhhbm5lcyBSZWluZWNr
ZSA8aGFyZUBzdXNlLmRlPgo+PiBDYzogSmFuIEthcmEgPGphY2tAc3VzZS5jb20+Cj4+IENjOiBK
ZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+Cj4+IENjOiBNaWtoYWlsIFNrb3J6aGluc2tpaSA8
bXNrb3J6aGluc2tpeUBzb2xhcmZsYXJlLmNvbT4KPj4gQ2M6IFBoaWxpcHAgUmVpc25lciA8cGhp
bGlwcC5yZWlzbmVyQGxpbmJpdC5jb20+Cj4+IENjOiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1i
ZXJnLm1lPgo+PiBDYzogVmxhc3RpbWlsIEJhYmthIDx2YmFia2FAc3VzZS5jb20+Cj4+IENjOiBz
dGFibGVAdmdlci5rZXJuZWwub3JnCj4+IC0tLQo+PiBDaGFuZ2Vsb2c6Cj4+IHYzOiBpbnRyb2R1
Y2UgYSBtb3JlIGNvbW1vbiBuYW1lIHNlbmRwYWdlX29rKCkgZm9yIHRoZSBvcGVuIGNvZGVkIGNo
ZWNrCj4+IHYyOiBmaXggdHlwbyBpbiBwYXRjaCBzdWJqZWN0Lgo+PiB2MTogdGhlIGluaXRpYWwg
dmVyc2lvbi4KPj4KPj4gwqAgZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgfCAxMyArKysrKysrKysr
Ky0tCj4+IMKgIGluY2x1ZGUvbGludXgvbmV0LmjCoMKgwqDCoCB8wqAgMiArKwo+PiDCoCAyIGZp
bGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5j
Cj4+IGluZGV4IDc5ZWYyYjhlMmIzYy4uZjk5NTJmNmQ5NGI5IDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL252bWUvaG9zdC90Y3AuYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYwo+PiBA
QCAtODg3LDggKzg4NywxNyBAQCBzdGF0aWMgaW50IG52bWVfdGNwX3RyeV9zZW5kX2RhdGEoc3Ry
dWN0Cj4+IG52bWVfdGNwX3JlcXVlc3QgKnJlcSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2UK
Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmxhZ3MgfD0gTVNHX01PUkUgfCBNU0dfU0VO
RFBBR0VfTk9UTEFTVDsKPj4gwqAgLcKgwqDCoMKgwqDCoMKgIC8qIGNhbid0IHpjb3B5IHNsYWIg
cGFnZXMgKi8KPj4gLcKgwqDCoMKgwqDCoMKgIGlmICh1bmxpa2VseShQYWdlU2xhYihwYWdlKSkp
IHsKPj4gK8KgwqDCoMKgwqDCoMKgIC8qCj4+ICvCoMKgwqDCoMKgwqDCoMKgICogZS5nLiBYRlMg
bWV0YS0gJiBsb2ctZGF0YSBpcyBpbiBzbGFiIHBhZ2VzLCBvciBiY2FjaGUgbWV0YQo+PiArwqDC
oMKgwqDCoMKgwqDCoCAqIGRhdGEgcGFnZXMsIG9yIG90aGVyIGhpZ2ggb3JkZXIgcGFnZXMgYWxs
b2NhdGVkIGJ5Cj4+ICvCoMKgwqDCoMKgwqDCoMKgICogX19nZXRfZnJlZV9wYWdlcygpIHdpdGhv
dXQgX19HRlBfQ09NUCwgd2hpY2ggaGF2ZSBhCj4+IHBhZ2VfY291bnQKPj4gK8KgwqDCoMKgwqDC
oMKgwqAgKiBvZiAwIGFuZC9vciBoYXZlIFBhZ2VTbGFiKCkgc2V0LiBXZSBjYW5ub3QgdXNlIHNl
bmRfcGFnZSBmb3IKPj4gK8KgwqDCoMKgwqDCoMKgwqAgKiB0aG9zZSwgYXMgdGhhdCBkb2VzIGdl
dF9wYWdlKCk7IHB1dF9wYWdlKCk7IGFuZCB3b3VsZCBjYXVzZQo+PiArwqDCoMKgwqDCoMKgwqDC
oCAqIGVpdGhlciBhIFZNX0JVRyBkaXJlY3RseSwgb3IgX19wYWdlX2NhY2hlX3JlbGVhc2UgYSBw
YWdlIHRoYXQKPj4gK8KgwqDCoMKgwqDCoMKgwqAgKiB3b3VsZCBhY3R1YWxseSBzdGlsbCBiZSBy
ZWZlcmVuY2VkIGJ5IHNvbWVvbmUsIGxlYWRpbmcgdG8KPj4gc29tZQo+PiArwqDCoMKgwqDCoMKg
wqDCoCAqIG9ic2N1cmUgZGVsYXllZCBPb3BzIHNvbWV3aGVyZSBlbHNlLgo+PiArwqDCoMKgwqDC
oMKgwqDCoCAqLwo+IAo+IEkgd2FzIGhvcGluZyB0aGF0IHRoaXMgY29tbWVudCB3b3VsZCBtb3Zl
IHRvIHRoZSBoZWxwZXIgYXMgd2VsbC4KPiAKClN1cmUsIEkgd2lsbCBkbyB0aGF0LgoKCj4gQWdy
ZWUgd2l0aCBDaHJpc3RvcGggY29tbWVudCBhcyB3ZWxsLgoKSSB3aWxsIG1vdmUgdGhlIGlubGlu
ZSBzZW5kcGFnZV9vaygpIHRvIGEgc2VwYXJhdGVkIHBhdGNoLgoKQ29seSBMaQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

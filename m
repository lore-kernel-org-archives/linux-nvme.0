Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F2EC433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 15:20:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EFF761026
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 15:20:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EFF761026
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:Subject:
	From:References:Cc:To:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Fg7d7u1hTNklaxlbuvwu9e/q9PqEl0ITHdHeQpa6Lj0=; b=bYJV1YoXTDp7HOcWwNW+sMrx4
	aNZUdxDKGMBdnppqZL8Zxb65ak1W3O6KRab8Vu6CU4HupyeLsEb0C/Xf0tHZ5IQn1TulWNWJeJPs7
	hxw/3pY/AsLn7PWsxyojlpPFBXcC6GzY81aXEWPbN6Gk1mNKAV68z2kFcTmiI1ZEhUpkwNfU3kbMW
	r0aCsM3ZDgL7R00SLuPy8ud+o9qXLeISdEaFftqBOYSYw9XU3tCytFzUrjUtN2gw1BWdieHcxkw+t
	e5S/mtHnLt+BsXt+I3aHPb60Kxp31Q8RTWq83J1m1n7yJ1L/8OOYp5rBmLAf254AXi6p3j1mK571B
	FHmhI5oPQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXQGc-002b3v-Gp; Fri, 16 Apr 2021 15:20:22 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXQGY-002b2r-3z
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 15:20:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References
 :Cc:To:Sender:Reply-To:Content-ID:Content-Description;
 bh=6+IZzertHObPklDllLN0FpqfGHOGCc8vz4AbigzKdWk=; b=KV2ekhQ0c7amlByxnU3PEuqSxV
 yp68gyqzAO2AmSlfnRyiB1D07jXRLtT5aSr88NZ/gmf4xv9Rt7xADmegPA8xyGwREo9JxCyQrGrRu
 f4VyOd+WxV7jGqwaG0F7E125WW3BmFktPgOYXJnwdwc5gC3uRJC8iSKm+xo4YVWKVC9CYAonZvYTj
 6sjigpPuKMdlmO5+rBOM6N7NeNqk7iYDq6uYLQxJFye1Xi3P4bSSK5/mRwN58L3R/4ijC7LWrpZLK
 kZvzzfF/B7ElEWazk9txXa4vAOccCFR5HvVKZJbCLYHnxkp8fXhg17eOxlSaTkx/NZJxJBDugxNxt
 7twCvCLA==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXQGS-009UxU-8u
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 15:20:16 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EB32AAEF8;
 Fri, 16 Apr 2021 15:20:09 +0000 (UTC)
To: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>
References: <20210415231530.95464-1-snitzer@redhat.com>
 <20210415231530.95464-3-snitzer@redhat.com>
 <da184561-2c97-5807-5c5b-9cc6593693c6@suse.de>
 <20210416145340.GB16047@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Organization: SUSE Linux GmbH
Subject: Re: [PATCH v2 2/4] nvme: allow local retry for requests with
 REQ_FAILFAST_TRANSPORT set
Message-ID: <3c5d6257-5f49-877e-91c2-c6d7687b002b@suse.de>
Date: Fri, 16 Apr 2021 17:20:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210416145340.GB16047@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_082012_632403_5037C269 
X-CRM114-Status: GOOD (  22.17  )
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

T24gNC8xNi8yMSA0OjUzIFBNLCBNaWtlIFNuaXR6ZXIgd3JvdGU6Cj4gT24gRnJpLCBBcHIgMTYg
MjAyMSBhdCAxMDowMWFtIC0wNDAwLAo+IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPiB3
cm90ZToKPiAKPj4gT24gNC8xNi8yMSAxOjE1IEFNLCBNaWtlIFNuaXR6ZXIgd3JvdGU6Cj4+PiBG
cm9tOiBDaGFvIExlbmcgPGxlbmdjaGFvQGh1YXdlaS5jb20+Cj4+Pgo+Pj4gUkVRX0ZBSUxGQVNU
X1RSQU5TUE9SVCB3YXMgZGVzaWduZWQgZm9yIFNDU0ksIGJlY2F1c2UgdGhlIFNDU0kgcHJvdG9j
b2wKPj4+IGRvZXMgbm90IGRlZmluZSB0aGUgbG9jYWwgcmV0cnkgbWVjaGFuaXNtLiBTQ1NJIGlt
cGxlbWVudHMgYSBmdXp6eQo+Pj4gbG9jYWwgcmV0cnkgbWVjaGFuaXNtLCBzbyBSRVFfRkFJTEZB
U1RfVFJBTlNQT1JUIGlzIG5lZWRlZCB0byBhbGxvdwo+Pj4gaGlnaGVyLWxldmVsIG11bHRpcGF0
aGluZyBzb2Z0d2FyZSB0byBwZXJmb3JtIGZhaWxvdmVyL3JldHJ5Lgo+Pj4KPj4+IE5WTWUgaXMg
ZGlmZmVyZW50IHdpdGggU0NTSSBhYm91dCB0aGlzLiBJdCBkZWZpbmVzIGEgbG9jYWwgcmV0cnkK
Pj4+IG1lY2hhbmlzbSBhbmQgcGF0aCBlcnJvciBjb2Rlcywgc28gTlZNZSBzaG91bGQgcmV0cnkg
bG9jYWwgZm9yIG5vbgo+Pj4gcGF0aCBlcnJvci4gSWYgcGF0aCByZWxhdGVkIGVycm9yLCB3aGV0
aGVyIHRvIHJldHJ5IGFuZCBob3cgdG8gcmV0cnkKPj4+IGlzIHN0aWxsIGRldGVybWluZWQgYnkg
aGlnaGVyLWxldmVsIG11bHRpcGF0aGluZydzIGZhaWxvdmVyLgo+Pj4KPj4+IFVubGlrZSBTQ1NJ
LCBOVk1lIHNob3VsZG4ndCBwcmV2ZW50IHJldHJ5IGlmIFJFUV9GQUlMRkFTVF9UUkFOU1BPUlQK
Pj4+IGJlY2F1c2UgTlZNZSdzIGxvY2FsIHJldHJ5IGlzIG5lZWRlZCAtLSBhcyBpcyBOVk1lIHNw
ZWNpZmljIGxvZ2ljIHRvCj4+PiBjYXRlZ29yaXplIHdoZXRoZXIgYW4gZXJyb3IgaXMgcGF0aCBy
ZWxhdGVkLgo+Pj4KPj4+IEluIHRoaXMgd2F5LCB0aGUgbWVjaGFuaXNtIG9mIE5WTWUgbXVsdGlw
YXRoIG9yIG90aGVyIG11bHRpcGF0aCBhcmUKPj4+IG5vdyBlcXVpdmFsZW50LiBUaGUgbWVjaGFu
aXNtIGlzOiBub24gcGF0aCByZWxhdGVkIGVycm9yIHdpbGwgYmUKPj4+IHJldHJpZWQgbG9jYWxs
eSwgcGF0aCByZWxhdGVkIGVycm9yIGlzIGhhbmRsZWQgYnkgbXVsdGlwYXRoLgo+Pj4KPj4+IFNp
Z25lZC1vZmYtYnk6IENoYW8gTGVuZyA8bGVuZ2NoYW9AaHVhd2VpLmNvbT4KPj4+IFtzbml0emVy
OiBlZGl0ZWQgaGVhZGVyIGZvciBncmFtbWFyIGFuZCBjbGFyaXR5LCBhbHNvIGFkZGVkIGNvZGUg
Y29tbWVudF0KPj4+IFNpZ25lZC1vZmYtYnk6IE1pa2UgU25pdHplciA8c25pdHplckByZWRoYXQu
Y29tPgo+Pj4gLS0tCj4+PiAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwgOSArKysrKysrKy0K
Pj4+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Pgo+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYyBiL2RyaXZlcnMvbnZtZS9o
b3N0L2NvcmUuYwo+Pj4gaW5kZXggNTQwZDZmZDhmZmVmLi40MTM0Y2YzYzdlNDggMTAwNjQ0Cj4+
PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9o
b3N0L2NvcmUuYwo+Pj4gQEAgLTMwNiw3ICszMDYsMTQgQEAgc3RhdGljIGlubGluZSBlbnVtIG52
bWVfZGlzcG9zaXRpb24gbnZtZV9kZWNpZGVfZGlzcG9zaXRpb24oc3RydWN0IHJlcXVlc3QgKnJl
cSkKPj4+ICAJaWYgKGxpa2VseShudm1lX3JlcShyZXEpLT5zdGF0dXMgPT0gMCkpCj4+PiAgCQly
ZXR1cm4gQ09NUExFVEU7Cj4+PiAgCj4+PiAtCWlmIChibGtfbm9yZXRyeV9yZXF1ZXN0KHJlcSkg
fHwKPj4+ICsJLyoKPj4+ICsJICogUkVRX0ZBSUxGQVNUX1RSQU5TUE9SVCBpcyBzZXQgYnkgdXBw
ZXIgbGF5ZXIgc29mdHdhcmUgdGhhdAo+Pj4gKwkgKiBoYW5kbGVzIG11bHRpcGF0aGluZy4gVW5s
aWtlIFNDU0ksIE5WTWUncyBlcnJvciBoYW5kbGluZyB3YXMKPj4+ICsJICogc3BlY2lmaWNhbGx5
IGRlc2lnbmVkIHRvIGhhbmRsZSBsb2NhbCByZXRyeSBmb3Igbm9uLXBhdGggZXJyb3JzLgo+Pj4g
KwkgKiBBcyBzdWNoLCBhbGxvdyBOVk1lJ3MgbG9jYWwgcmV0cnkgbWVjaGFuaXNtIHRvIGJlIHVz
ZWQgZm9yCj4+PiArCSAqIHJlcXVlc3RzIG1hcmtlZCB3aXRoIFJFUV9GQUlMRkFTVF9UUkFOU1BP
UlQuCj4+PiArCSAqLwo+Pj4gKwlpZiAoKHJlcS0+Y21kX2ZsYWdzICYgKFJFUV9GQUlMRkFTVF9E
RVYgfCBSRVFfRkFJTEZBU1RfRFJJVkVSKSkgfHwKPj4+ICAJICAgIChudm1lX3JlcShyZXEpLT5z
dGF0dXMgJiBOVk1FX1NDX0ROUikgfHwKPj4+ICAJICAgIG52bWVfcmVxKHJlcSktPnJldHJpZXMg
Pj0gbnZtZV9tYXhfcmV0cmllcykKPj4+ICAJCXJldHVybiBDT01QTEVURTsKPj4+Cj4+IEh1aD8K
Pj4KPj4gI2RlZmluZSBibGtfbm9yZXRyeV9yZXF1ZXN0KHJxKSBcCj4+ICAgICAgICAgKChycSkt
PmNtZF9mbGFncyAmIChSRVFfRkFJTEZBU1RfREVWfFJFUV9GQUlMRkFTVF9UUkFOU1BPUlR8IFwK
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBSRVFfRkFJTEZBU1RfRFJJVkVSKSkKPj4K
Pj4gbWFraW5nIHRoZSBvbmx5IF9hY3R1YWxfIGNoYW5nZSBpbiB5b3VyIHBhdGNoIF9ub3RfIGV2
YWx1YXRpbmcgdGhlCj4+IFJFUV9GQUlMRkFTVF9EUklWRVIsIHdoaWNoIGluY2lkZW50YWxseSBp
cyBvbmx5IHVzZWQgYnkgdGhlIE5WTWUgY29yZS4KPiAKPiBObywgbm90IHN1cmUgaG93IHlvdSBn
b3QgdGhlcmUuIEknZCBoYXZlIHRob3VnaHQgdGhlIDUgcmVmZXJlbmNlcyB0bwo+ICJSRVFfRkFJ
TEZBU1RfVFJBTlNQT1JUIiB3b3VsZCd2ZSBiZWVuIHN1ZmZpY2llbnQgOykKPiAKCkFoLiBNaXNy
ZWFkIHN0dWZmLiBZb3UncmUgZXhjbHVkaW5nIHRoZSBSRVFfRkFJTEZBU1RfVFJBTlNQT1JUIGhl
cmUuCkJ1dCB0aGVuIGl0J3MgX2FjdHVhbGx5XyBzaW1pbGFyIHRvIHRoZSBuZXh0IHBhdGNoICh3
aGljaCBJJ3ZlIGFsc28KY29tbWVudGVkKS4KCldvdWxkbid0IGl0IGJlIGJldHRlciB0byBmb2xk
IHRoZW0gaW50byBvbmUgcGF0Y2ggYW5kIGRpc2N1c3MgdGhpbmdzCnRvZ2V0aGVyOyBlc3BlY2lh
bGx5IGFzIG15IGNvbW1lbnQgdG8gdGhlIG5leHQgb25lIG1pZ2h0IGFjdHVhbGx5CmFjaGlldmUg
dGhlIHNhbWUgdGhpbmc/CgpDaGVlcnMsCgpIYW5uZXMKLS0gCkRyLiBIYW5uZXMgUmVpbmVja2UJ
CSAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0CmhhcmVAc3VzZS5kZQkJCSAgICAgICAg
ICAgICAgICs0OSA5MTEgNzQwNTMgNjg4ClNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdlcm1hbnkg
R21iSCwgOTA0MDkgTsO8cm5iZXJnCkdGOiBGLiBJbWVuZMO2cmZmZXIsIEhSQiAzNjgwOSAoQUcg
TsO8cm5iZXJnKQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

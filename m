Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DB4C43461
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 10:02:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B82B221E3
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 10:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zVazg+Ay"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B82B221E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sj6qjDN8veJgZJ/2Rm1SnwhQdewk51j4J2w15m+8zOY=; b=zVazg+Ay+OkJEH2sVHoBRG/zy
	2s+PFQOL+KnxG9FSJACpPGgrUJeSuSSMLhHBHMsS/43sFKXwpLUOMcPiu5G40/k7qb1qMqcjvwo2o
	TW0i2qbLKh/bjptiVbxCRATVYplM64xI/QqSu9KaskfQtilCRwc7XYP5iJ95g7bzvzZDh53A767bN
	CIqSUurHVOhXcyj/0QmgcYFA33AzXMcbrWnxj2+j3wL+rS1wtIoraLCLB6vIH/izfmJvxMYZHrl52
	eoIBpvC9wPJaQPJxt3l5LUjGvTTxycNj7IgMzenZFRyIPecsw2uuHJUQP1c5N0INUqyt3E8gaQiFH
	mRTMiiByQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGfsZ-0000yy-Uw; Fri, 11 Sep 2020 10:02:03 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGfsX-0000y7-FP
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 10:02:02 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 79E0DB2EF;
 Fri, 11 Sep 2020 10:02:12 +0000 (UTC)
Subject: Re: [PATCH] blk-mq: always allow reserved allocation in hctx_may_queue
To: Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>
References: <20200911094453.160109-1-ming.lei@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <a8af865b-29ba-52f7-7a63-e05751bf0e53@suse.de>
Date: Fri, 11 Sep 2020 12:01:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200911094453.160109-1-ming.lei@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_060201_772265_10DA09FC 
X-CRM114-Status: GOOD (  27.40  )
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
Cc: David Milburn <dmilburn@redhat.com>, "Ewan D . Milne" <emilne@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOS8xMS8yMCAxMTo0NCBBTSwgTWluZyBMZWkgd3JvdGU6Cj4gTlZNZSBzaGFyZXMgdGFnc2V0
IGJldHdlZW4gZmFicmljIHF1ZXVlIGFuZCBhZG1pbiBxdWV1ZSBvciBiZXR3ZWVuCj4gY29ubmVj
dF9xIGFuZCBOUyBxdWV1ZSwgc28gaGN0eF9tYXlfcXVldWUoKSBjYW4gYmUgY2FsbGVkIHRvIGFs
bG9jYXRlCj4gcmVxdWVzdCBmb3IgdGhlc2UgcXVldWVzLgo+IAo+IFRhZ3MgY2FuIGJlIHJlc2Vy
dmVkIGluIHRoZXNlIHRhZ3NldC4gQmVmb3JlIGVycm9yIHJlY292ZXJ5LCB0aGVyZSBpcwo+IG9m
dGVuIGxvdHMgb2YgaW4tZmxpZ2h0IHJlcXVlc3RzIHdoaWNoIGNhbid0IGJlIGNvbXBsZXRlZCwg
YW5kIG5ldwo+IHJlc2VydmVkIHJlcXVlc3QgbWF5IGJlIG5lZWRlZCBpbiBlcnJvciByZWNvdmVy
eSBwYXRoLiBIb3dldmVyLAo+IGhjdHhfbWF5X3F1ZXVlKCkgY2FuIGFsd2F5cyByZXR1cm4gZmFs
c2UgYmVjYXVzZSB0aGVyZSBpcyB0b28gbWFueQo+IGluLWZsaWdodCByZXF1ZXN0cyB3aGljaCBj
YW4ndCBiZSBjb21wbGV0ZWQgZHVyaW5nIGVycm9yIGhhbmRsaW5nLgo+IEZpbmFsbHksIGV2ZXJ5
dGhpbmcgY2FuJ3QgbW92ZSBvbi4KPiAKPiBGaXggdGhpcyBpc3N1ZSBieSBhbHdheXMgYWxsb3dp
bmcgcmVzZXJ2ZWQgdGFnIGFsbG9jYXRpb24gaW4KPiBoY3R4X21heV9xdWV1ZSgpLiBUaGlzIHdh
eXMgaXMgcmVhc29uYWJsZSBiZWNhdXNlIHJlc2VydmVkIHRhZwo+IHN1cHBvc2UgdG8gYmUgcmVh
ZHkgYW55IHRpbWUuCj4gCj4gQ2M6IERhdmlkIE1pbGJ1cm4gPGRtaWxidXJuQHJlZGhhdC5jb20+
Cj4gQ2M6IEV3YW4gRC4gTWlsbmUgPGVtaWxuZUByZWRoYXQuY29tPgo+IFNpZ25lZC1vZmYtYnk6
IE1pbmcgTGVpIDxtaW5nLmxlaUByZWRoYXQuY29tPgo+IC0tLQo+ICBibG9jay9ibGstbXEtdGFn
LmMgfCAzICsrLQo+ICBibG9jay9ibGstbXEuYyAgICAgfCA2ICsrKystLQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEv
YmxvY2svYmxrLW1xLXRhZy5jIGIvYmxvY2svYmxrLW1xLXRhZy5jCj4gaW5kZXggYzMxYzRhMDQ3
OGE1Li5hYWNmMTBkZWNkYmQgMTAwNjQ0Cj4gLS0tIGEvYmxvY2svYmxrLW1xLXRhZy5jCj4gKysr
IGIvYmxvY2svYmxrLW1xLXRhZy5jCj4gQEAgLTc2LDcgKzc2LDggQEAgdm9pZCBfX2Jsa19tcV90
YWdfaWRsZShzdHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0eCkKPiAgc3RhdGljIGludCBfX2Jsa19t
cV9nZXRfdGFnKHN0cnVjdCBibGtfbXFfYWxsb2NfZGF0YSAqZGF0YSwKPiAgCQkJICAgIHN0cnVj
dCBzYml0bWFwX3F1ZXVlICpidCkKPiAgewo+IC0JaWYgKCFkYXRhLT5xLT5lbGV2YXRvciAmJiAh
aGN0eF9tYXlfcXVldWUoZGF0YS0+aGN0eCwgYnQpKQo+ICsJaWYgKCFkYXRhLT5xLT5lbGV2YXRv
ciAmJiAhKGRhdGEtPmZsYWdzICYgQkxLX01RX1JFUV9SRVNFUlZFRCkgJiYKPiArCQkJIWhjdHhf
bWF5X3F1ZXVlKGRhdGEtPmhjdHgsIGJ0KSkKPiAgCQlyZXR1cm4gQkxLX01RX05PX1RBRzsKPiAg
Cj4gIAlpZiAoZGF0YS0+c2hhbGxvd19kZXB0aCkKPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLW1x
LmMgYi9ibG9jay9ibGstbXEuYwo+IGluZGV4IGNjYjUwMGUzODAwOC4uOTFjZmYyNzU0NTFkIDEw
MDY0NAo+IC0tLSBhL2Jsb2NrL2Jsay1tcS5jCj4gKysrIGIvYmxvY2svYmxrLW1xLmMKPiBAQCAt
MTE0NywxNSArMTE0NywxNyBAQCBzdGF0aWMgYm9vbCBfX2Jsa19tcV9nZXRfZHJpdmVyX3RhZyhz
dHJ1Y3QgcmVxdWVzdCAqcnEpCj4gIAlzdHJ1Y3Qgc2JpdG1hcF9xdWV1ZSAqYnQgPSBycS0+bXFf
aGN0eC0+dGFncy0+Yml0bWFwX3RhZ3M7Cj4gIAl1bnNpZ25lZCBpbnQgdGFnX29mZnNldCA9IHJx
LT5tcV9oY3R4LT50YWdzLT5ucl9yZXNlcnZlZF90YWdzOwo+ICAJaW50IHRhZzsKPiArCWJvb2wg
cmVzZXJ2ZWQgPSBibGtfbXFfdGFnX2lzX3Jlc2VydmVkKHJxLT5tcV9oY3R4LT5zY2hlZF90YWdz
LAo+ICsJCQlycS0+aW50ZXJuYWxfdGFnKTsKPiAgCj4gIAlibGtfbXFfdGFnX2J1c3kocnEtPm1x
X2hjdHgpOwo+ICAKPiAtCWlmIChibGtfbXFfdGFnX2lzX3Jlc2VydmVkKHJxLT5tcV9oY3R4LT5z
Y2hlZF90YWdzLCBycS0+aW50ZXJuYWxfdGFnKSkgewo+ICsJaWYgKHJlc2VydmVkKSB7Cj4gIAkJ
YnQgPSBycS0+bXFfaGN0eC0+dGFncy0+YnJlc2VydmVkX3RhZ3M7Cj4gIAkJdGFnX29mZnNldCA9
IDA7Cj4gIAl9Cj4gIAo+IC0JaWYgKCFoY3R4X21heV9xdWV1ZShycS0+bXFfaGN0eCwgYnQpKQo+
ICsJaWYgKCFyZXNlcnZlZCAmJiAhaGN0eF9tYXlfcXVldWUocnEtPm1xX2hjdHgsIGJ0KSkKPiAg
CQlyZXR1cm4gZmFsc2U7Cj4gIAl0YWcgPSBfX3NiaXRtYXBfcXVldWVfZ2V0KGJ0KTsKPiAgCWlm
ICh0YWcgPT0gQkxLX01RX05PX1RBRykKPiAKVmVyeSBnb29kIHBvaW50LgoKUmV2aWV3ZWQtYnk6
IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBzdXNlLmRlPgoKQ2hlZXJzLAoKSGFubmVzCi0tIApEci4g
SGFubmVzIFJlaW5lY2tlCQkgICAgICAgICAgIEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdApoYXJl
QHN1c2UuZGUJCQkgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OApTVVNFIFNvZnR3
YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVy
ZwpIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdGOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFp
bGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

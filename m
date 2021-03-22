Return-Path: <SRS0=yO6k=IU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF2FC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 11:23:38 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FD26191A
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Mar 2021 11:23:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FD26191A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=HbnBjtwYI6XgWliEwgQdWxfRnIR0URwT0ISf0x6llks=; b=jXEnQMVl7W2I/e7P04pGmFuOh
	QS7D8eID/7hNW+B6I1Qw89ze/25EEz33/0jK/MfiSO0gCxFf33a4Q6D9iXpzmPC/8fb0gpe4Xpfq+
	6C1xT3hwA5gNlZ2nxua8rOGaw/8LSGXcwsisQjlgCPqNBMOm2AlbR6tOFNtbMXrMal4f8WvsbepRV
	DACRRTsrcpTB2Mo+kH/UJbCh0nfpn1S597IcqhnPgBulH6jDqIstjKECikdrRXI2kcrPEUGGyyt4F
	ItArij9RXz84M90w+5GXCtY+N7kczLW5N6gJg/lwhVWBLLhl/2WA/DDLUBXvRHdUeTmV3vbeesoUP
	9rq2RZVBw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lOIeb-00BR6T-KP; Mon, 22 Mar 2021 11:23:25 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lOIeW-00BR59-4u
 for linux-nvme@lists.infradead.org; Mon, 22 Mar 2021 11:23:22 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C6B00AD4A;
 Mon, 22 Mar 2021 11:23:19 +0000 (UTC)
Subject: Re: [PATCH 1/2] blk-mq: add a blk_mq_submit_bio_direct API
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc: Chao Leng <lengchao@huawei.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20210322073726.788347-1-hch@lst.de>
 <20210322073726.788347-2-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <df54545f-0f2c-9bc1-e448-d8595088b7f5@suse.de>
Date: Mon, 22 Mar 2021 12:23:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210322073726.788347-2-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210322_112320_398924_94481122 
X-CRM114-Status: GOOD (  29.05  )
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

T24gMy8yMi8yMSA4OjM3IEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPiBUaGlzIGFkZHMg
KGJhY2spIGFuZCBBUEkgZm9yIHNpbXBsZSBzdGFja2luZyBkcml2ZXJzIHRvIHN1Ym1pdCBhIGJp
byB0bwo+IGJsay1tcSBxdWV1ZS4gIFRoZSBwcmltZSBhaW0gaXMgdG8gYXZvaWQgYmxvY2tpbmcg
b24gdGhlIHF1ZXVlIGZyZWV6ZQo+IHBlcmNwdSByZWYsIGFzIGEgbXVsdGlwYXRoIGRyaXZlciBy
ZWFsbHkgZG9lcyBub3Qgd2FudCB0byBnZXQgYmxvY2tlZAo+IG9uIHRoYXQgd2hlbiBhbiB1bmRl
cmx5aW5nIGRldmljZSBpcyB1bmRlcmdvaW5nIGVycm9yIHJlY292ZXJ5LiAgSXQgYWxzbwo+IGhh
cHBlbnMgdG8gb3B0aW1pemUgYXdheSB0aGUgc21hbGwgb3ZlcmhlYWQgb2YgdGhlIGN1cnJlbi0+
YmlvX2xpc3QgYmFzZWQKPiByZWN1cnNpb24gYXZvaWRhbmNlLgo+IAo+IFNpZ25lZC1vZmYtYnk6
IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+IC0tLQo+ICBibG9jay9ibGstY29yZS5j
ICAgICAgIHwgIDIgKy0KPiAgYmxvY2svYmxrLW1xLmMgICAgICAgICB8IDM3ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgYmxvY2svYmxrLmggICAgICAgICAgICB8ICAx
ICsKPiAgaW5jbHVkZS9saW51eC9ibGstbXEuaCB8ICAxICsKPiAgNCBmaWxlcyBjaGFuZ2VkLCA0
MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2Jsb2NrL2Js
ay1jb3JlLmMgYi9ibG9jay9ibGstY29yZS5jCj4gaW5kZXggZmM2MGZmMjA4NDk3MzguLjQzNDRm
M2M5MDU4MjgyIDEwMDY0NAo+IC0tLSBhL2Jsb2NrL2Jsay1jb3JlLmMKPiArKysgYi9ibG9jay9i
bGstY29yZS5jCj4gQEAgLTc5Miw3ICs3OTIsNyBAQCBzdGF0aWMgaW5saW5lIGJsa19zdGF0dXNf
dCBibGtfY2hlY2tfem9uZV9hcHBlbmQoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEsCj4gIAlyZXR1
cm4gQkxLX1NUU19PSzsKPiAgfQo+ICAKPiAtc3RhdGljIG5vaW5saW5lX2Zvcl9zdGFjayBib29s
IHN1Ym1pdF9iaW9fY2hlY2tzKHN0cnVjdCBiaW8gKmJpbykKPiArbm9pbmxpbmVfZm9yX3N0YWNr
IGJvb2wgc3VibWl0X2Jpb19jaGVja3Moc3RydWN0IGJpbyAqYmlvKQo+ICB7Cj4gIAlzdHJ1Y3Qg
YmxvY2tfZGV2aWNlICpiZGV2ID0gYmlvLT5iaV9iZGV2Owo+ICAJc3RydWN0IHJlcXVlc3RfcXVl
dWUgKnEgPSBiZGV2LT5iZF9kaXNrLT5xdWV1ZTsKPiBkaWZmIC0tZ2l0IGEvYmxvY2svYmxrLW1x
LmMgYi9ibG9jay9ibGstbXEuYwo+IGluZGV4IGQ0ZDdjMWNhYTQzOTY2Li40ZmY4NTY5Mjg0M2I0
OSAxMDA2NDQKPiAtLS0gYS9ibG9jay9ibGstbXEuYwo+ICsrKyBiL2Jsb2NrL2Jsay1tcS5jCj4g
QEAgLTIyODYsNiArMjI4Niw0MyBAQCBibGtfcWNfdCBibGtfbXFfc3VibWl0X2JpbyhzdHJ1Y3Qg
YmlvICpiaW8pCj4gIAlyZXR1cm4gQkxLX1FDX1RfTk9ORTsKPiAgfQo+ICAKPiArLyoqCj4gKyAq
IGJsa19tcV9zdWJtaXRfYmlvX2RpcmVjdCAtIGhhbmQgYSBiaW8gZGlyZWN0bHkgdG8gdGhlIGRy
aXZlciBmb3IgSS9PCj4gKyAqIEBiaW86ICBUaGUgYmlvIGRlc2NyaWJpbmcgdGhlIGxvY2F0aW9u
IGluIG1lbW9yeSBhbmQgb24gdGhlIGRldmljZS4KPiArICoKPiArICogVGhpcyBmdW5jdGlvbiBi
ZWhhdmVzIHNpbWlsYXIgdG8gc3VibWl0X2Jpb19ub2FjY3QoKSwgYnV0IGRvZXMgbmV2ZXIgd2Fp
dHMKPiArICogZm9yIHRoZSBxdWV1ZSB0byBiZSB1bmZyZW96ZW4sIGluc3RlYWQgaXQgcmV0dXJu
IGZhbHNlIGFuZCBsZXRzIHRoZSBjYWxsZXIKPiArICogZGVhbCB3aXRoIHRoZSBmYWxsb3V0LiAg
SXQgYWxzbyBkb2VzIG5vdCBwcm90ZWN0IGFnYWluc3QgcmVjdXJzaW9uIGFuZCB0aHVzCj4gKyAq
IG11c3Qgb25seSBiZSB1c2VkIGlmIHRoZSBjYWxsZWQgZHJpdmVyIGlzIGtub3duIHRvIGJlIGJs
ay1tcSBiYXNlZC4KPiArICovCj4gK2Jvb2wgYmxrX21xX3N1Ym1pdF9iaW9fZGlyZWN0KHN0cnVj
dCBiaW8gKmJpbywgYmxrX3FjX3QgKnFjKQo+ICt7Cj4gKwlzdHJ1Y3QgZ2VuZGlzayAqZGlzayA9
IGJpby0+YmlfYmRldi0+YmRfZGlzazsKPiArCXN0cnVjdCByZXF1ZXN0X3F1ZXVlICpxID0gZGlz
ay0+cXVldWU7Cj4gKwo+ICsJaWYgKFdBUk5fT05fT05DRSghY3VycmVudC0+YmlvX2xpc3QpIHx8
Cj4gKwkgICAgV0FSTl9PTl9PTkNFKGRpc2stPmZvcHMtPnN1Ym1pdF9iaW8pKSB7Cj4gKwkJYmlv
X2lvX2Vycm9yKGJpbyk7Cj4gKwkJZ290byBmYWlsOwo+ICsJfQo+ICsJaWYgKCFzdWJtaXRfYmlv
X2NoZWNrcyhiaW8pKQo+ICsJCWdvdG8gZmFpbDsKPiArCj4gKwlpZiAodW5saWtlbHkoYmxrX3F1
ZXVlX2VudGVyKHEsIEJMS19NUV9SRVFfTk9XQUlUKSkpCj4gKwkJcmV0dXJuIGZhbHNlOwo+ICsJ
aWYgKCFibGtfY3J5cHRvX2Jpb19wcmVwKCZiaW8pKQo+ICsJCWdvdG8gZmFpbF9xdWV1ZV9leGl0
Owo+ICsJKnFjID0gYmxrX21xX3N1Ym1pdF9iaW8oYmlvKTsKPiArCXJldHVybiB0cnVlOwo+ICsK
PiArZmFpbF9xdWV1ZV9leGl0Ogo+ICsJYmxrX3F1ZXVlX2V4aXQoZGlzay0+cXVldWUpOwo+ICtm
YWlsOgo+ICsJKnFjID0gQkxLX1FDX1RfTk9ORTsKPiArCXJldHVybiB0cnVlOwo+ICt9Cj4gK0VY
UE9SVF9TWU1CT0xfR1BMKGJsa19tcV9zdWJtaXRfYmlvX2RpcmVjdCk7Cj4gKwo+ICB2b2lkIGJs
a19tcV9mcmVlX3JxcyhzdHJ1Y3QgYmxrX21xX3RhZ19zZXQgKnNldCwgc3RydWN0IGJsa19tcV90
YWdzICp0YWdzLAo+ICAJCSAgICAgdW5zaWduZWQgaW50IGhjdHhfaWR4KQo+ICB7Cj4gZGlmZiAt
LWdpdCBhL2Jsb2NrL2Jsay5oIGIvYmxvY2svYmxrLmgKPiBpbmRleCAzYjUzZTQ0Yjk2N2U0ZS4u
YzRjNjZiMmE5ZmZiMTkgMTAwNjQ0Cj4gLS0tIGEvYmxvY2svYmxrLmgKPiArKysgYi9ibG9jay9i
bGsuaAo+IEBAIC0yMjEsNiArMjIxLDcgQEAgc3NpemVfdCBwYXJ0X3RpbWVvdXRfc2hvdyhzdHJ1
Y3QgZGV2aWNlICosIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICosIGNoYXIgKik7Cj4gIHNzaXpl
X3QgcGFydF90aW1lb3V0X3N0b3JlKHN0cnVjdCBkZXZpY2UgKiwgc3RydWN0IGRldmljZV9hdHRy
aWJ1dGUgKiwKPiAgCQkJCWNvbnN0IGNoYXIgKiwgc2l6ZV90KTsKPiAgCj4gK2Jvb2wgc3VibWl0
X2Jpb19jaGVja3Moc3RydWN0IGJpbyAqYmlvKTsKPiAgdm9pZCBfX2Jsa19xdWV1ZV9zcGxpdChz
dHJ1Y3QgYmlvICoqYmlvLCB1bnNpZ25lZCBpbnQgKm5yX3NlZ3MpOwo+ICBpbnQgbGxfYmFja19t
ZXJnZV9mbihzdHJ1Y3QgcmVxdWVzdCAqcmVxLCBzdHJ1Y3QgYmlvICpiaW8sCj4gIAkJdW5zaWdu
ZWQgaW50IG5yX3NlZ3MpOwo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2Jsay1tcS5oIGIv
aW5jbHVkZS9saW51eC9ibGstbXEuaAo+IGluZGV4IDJjNDczYzliODk5MDg5Li42ODA0ZjM5NzEw
NmFkYSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2Jsay1tcS5oCj4gKysrIGIvaW5jbHVk
ZS9saW51eC9ibGstbXEuaAo+IEBAIC02MTUsNiArNjE1LDcgQEAgc3RhdGljIGlubGluZSB2b2lk
IGJsa19ycV9iaW9fcHJlcChzdHJ1Y3QgcmVxdWVzdCAqcnEsIHN0cnVjdCBiaW8gKmJpbywKPiAg
fQo+ICAKPiAgYmxrX3FjX3QgYmxrX21xX3N1Ym1pdF9iaW8oc3RydWN0IGJpbyAqYmlvKTsKPiAr
Ym9vbCBibGtfbXFfc3VibWl0X2Jpb19kaXJlY3Qoc3RydWN0IGJpbyAqYmlvLCBibGtfcWNfdCAq
cWMpOwo+ICB2b2lkIGJsa19tcV9oY3R4X3NldF9mcV9sb2NrX2NsYXNzKHN0cnVjdCBibGtfbXFf
aHdfY3R4ICpoY3R4LAo+ICAJCXN0cnVjdCBsb2NrX2NsYXNzX2tleSAqa2V5KTsKPiAgCj4gClJl
dmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KCkNoZWVycywKCkhhbm5l
cwotLSAKRHIuIEhhbm5lcyBSZWluZWNrZQkJICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNo
aXRlY3QKaGFyZUBzdXNlLmRlCQkJICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgK
U1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQw
OSBOw7xybmJlcmcKSFJCIDM2ODA5IChBRyBOw7xybmJlcmcpLCBHRjogRmVsaXggSW1lbmTDtnJm
ZmVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51
eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

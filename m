Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77A0C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 03:33:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF890206D4
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 03:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0NHtOw0w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF890206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FGVxXFmWxE4xWhahZXOb2ILHrsOqdws6j1x86V7qoDc=; b=0NHtOw0wDMPSZmhFtluUXDt3l
	pFZGVD/vL5k6WmqtHjsJKU5D5L/wHthAmDeLDD9tSl2sE+WhbmQiggAsbrk4UYMKiVYyOQrQuFKTk
	Bi9+VHL4L9AmehHgjcr7n5LwjzbXzFbWtbTSkp1hg7740MgJPTmaaFP8p0Sdn/r72UptL10MU5yVN
	JwnoqsnQPNM3vSxLkck0lix7qUg56zJRC20o9prFhFitlMzzze7LJ3RNZgvhAp+R7JvcibMgXn/Wp
	9O1pwb05Ps/ekDLQLsK6xE41jx+iLeh6S2RZP33FLlsp6L+9KPhXgCcPp3K9dooa7uwR5u/trAhpY
	i8s8gcPkA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0GMP-0003Qy-4k; Tue, 28 Jul 2020 03:33:01 +0000
Received: from mail-wr1-f66.google.com ([209.85.221.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0GMN-0003QY-0f
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 03:32:59 +0000
Received: by mail-wr1-f66.google.com with SMTP id a15so16792319wrh.10
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 20:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D483E3LyE7EJERCEZtU/2cRXgG5SKEc7Ac/JIr4uxgw=;
 b=sTU+E3nFK5lY8Xi0hzn6zfuvHZ2Efq1k77uPQqKki3WNAlFhQQxVoOjcjO75Jam75N
 FP0CMNAY9gCiPcqacMarmy3I0QEDWsoGI9B7mg/Rfd+prgANYV2eIFEP3ocPjUj0GBx2
 Bp8SoMJkUA9J5/AMbhNySHa2fsssLgCH+YoxRmTUkycT6lShNuHrzXuYDRTDF06xyHfr
 C+hlrjACFm/NxFUYGVtfBSny/Ox+M4RwsAGTFgjp+qzFNKLG8WjLsUcQbrrTw2TtggEq
 BSTPpOVENWnQ7T4kffUfO5Gkvk2oh4iE1Hhx5c6PdgQWX5qrmQsozZAVYeSJgnmbuUjF
 G7xg==
X-Gm-Message-State: AOAM532gEX6599SEIknOfOiPjG2iYssar1uLPEMq65RqL71F7kQpHfKh
 AE1dJv3IsRLnjwqIbaKWi64=
X-Google-Smtp-Source: ABdhPJxXtER5kS+x2CJPdfvtdc8r7zR+7veSOnjVTiR8kS98Nu2lgreIfMrUIcY2ActFGSDEwD0E7w==
X-Received: by 2002:a5d:5712:: with SMTP id a18mr18365586wrv.184.1595907177720; 
 Mon, 27 Jul 2020 20:32:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5d7d:f206:b163:f30b?
 ([2601:647:4802:9070:5d7d:f206:b163:f30b])
 by smtp.gmail.com with ESMTPSA id w16sm16784221wrg.95.2020.07.27.20.32.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 20:32:57 -0700 (PDT)
Subject: Re: [PATCH] nvme-rdma: fix deadlock when delete ctrl due to reconnect
 fail
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20200727080926.30776-1-lengchao@huawei.com>
 <e477f1b3-f351-1aa3-6132-d7e729db11b9@grimberg.me>
 <c129a034-ca6f-7323-91d4-8a899ede7777@grimberg.me>
 <c229ca6e-646a-372a-2526-ad90e2da1abf@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9e6242b2-fc04-632d-0ea4-7ca877c5da2c@grimberg.me>
Date: Mon, 27 Jul 2020 20:32:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c229ca6e-646a-372a-2526-ad90e2da1abf@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200727_233259_088062_E568A0DC 
X-CRM114-Status: GOOD (  26.05  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyBiL2RyaXZlcnMvbnZt
ZS9ob3N0L3JkbWEuYwo+Pj4+IGluZGV4IGY4Zjg1NmRjMGM2Ny4uYjM4MWUyY2RlNTBhIDEwMDY0
NAo+Pj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+Pj4+ICsrKyBiL2RyaXZlcnMv
bnZtZS9ob3N0L3JkbWEuYwo+Pj4+IEBAIC05ODksOCArOTg5LDcgQEAgc3RhdGljIHZvaWQgbnZt
ZV9yZG1hX3RlYXJkb3duX2lvX3F1ZXVlcyhzdHJ1Y3QgCj4+Pj4gbnZtZV9yZG1hX2N0cmwgKmN0
cmwsCj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBudm1lX2NhbmNlbF9y
ZXF1ZXN0LCAmY3RybC0+Y3RybCk7Cj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmxr
X21xX3RhZ3NldF93YWl0X2NvbXBsZXRlZF9yZXF1ZXN0KGN0cmwtPmN0cmwudGFnc2V0KTsKPj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBpZiAocmVtb3ZlKQo+
Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG52bWVfc3RhcnRfcXVldWVzKCZjdHJsLT5jdHJs
KTsKPj4+PiArwqDCoMKgwqDCoMKgwqAgbnZtZV9zdGFydF9xdWV1ZXMoJmN0cmwtPmN0cmwpOwo+
Pj4KPj4+IFRoaXMgd2lsbCBmYWlsIEkvTyBkdXJpbmcgY29udHJvbGxlciByZXNldCwgc28gbmFr
IG9uIHRoaXMuCj4gVGhlIGlvIHdpbGwgZG8gbm90IGZhaWwuIElmIHdvcmsgd2l0aCBuYXRpdmUg
bXVsdGlwYXRoIG9yIGRtLW11bHRpcGF0aCwKPiBudm1lX3JkbWFfcXVldWVfcnEgd2lsbCByZXR1
cm4gaW8gZXJyb3IsIGFuZCB0aGVuIG11bHRpcGF0aCB3aWxsCj4gZmFpbCBvdmVyIHRvIG90aGVy
IHBhdGggYW5kIHJldHJ5IGlvLCB0aGlzIGlzIHdlIGV4cGVjdGVkLiBJZiB3b3JrCj4gd2l0aG91
dCBtdWx0aXBhdGgsIG52bWVfcmRtYV9xdWV1ZV9ycSB3aWxsIHJldHVybiBCTEtfU1RTX1JFU09V
UkNFLAo+IGFuZCB0aGVuIHRoZSB1cHBlciBsYXllciB3aWxsIHJlcXVldWUgYW5kIHJldHJ5LiBT
dXJlbHkgdGhlcmUgaXMgYQo+IHdlYWtuZXNzOnRoZSBpbyB3aWxsIHJldHJ5IHJlcGVhdGVkIGV2
ZXJ5IEJMS19NUV9SRVNPVVJDRV9ERUxBWSgzbXMpCj4gd2hpbGUgcmVjb25uZWN0aW5nLiBCZWNh
dXNlIGNvbnRyb2xsZXIgcmVzZXQgbWF5IG5lZWQgbG9uZyB0aW1lLAo+IGFuZCBudm1lIG92ZXIg
cm9jZSBpcyBtYWlubHkgdXNlZCB3aXRoIG11bHRpcGF0aCBzb2Z0d2FyZSwgc28gd2hlbgo+IGNv
bnRyb2xsZXIgcmVzZXQgd2UgZXhwZWN0IGZhaWwgb3ZlciB0byBvdGhlciBwYXRoIGFuZCByZXRy
eSBpbywsIGp1c3QKPiBsaWtlIGVycm9yIHJlY292ZXJ5LiBJZiB3b3JrIHdpdGhvdXQgbXVsdGlw
YXRoLCB3ZSB0b2xlcmF0ZSByZXBlYXRlZAo+IEkvTyByZXRyaWVzIGR1cmluZyBlcnJvciByZWNv
dmVyeSBvciBjb250cm9sbGVyIHJlc2V0LgoKSS9PIHNob3VsZCBub3QgZmFpbCBkdXJpbmcgcmVz
ZXQsIG1wYXRoIG9yIG5vdCwgcGVyaW9kLgoKPj4gQ2FuIHlvdSB0cnkgdGhpczoKPj4gLS0gCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgYi9kcml2ZXJzL252bWUvaG9z
dC9yZG1hLmMKPj4gaW5kZXggZDU4MjMxNjM2ZDExLi45NmMwZDY2NGZlOWIgMTAwNjQ0Cj4+IC0t
LSBhL2RyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYwo+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9y
ZG1hLmMKPj4gQEAgLTExNDksNiArMTE0OSwxMSBAQCBzdGF0aWMgdm9pZCAKPj4gbnZtZV9yZG1h
X3JlY29ubmVjdF9jdHJsX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQo+PiDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybjsKPj4KPj4gwqDCoHJlcXVldWU6Cj4+ICvCoMKgwqDCoMKgwqAgLyoK
Pj4gK8KgwqDCoMKgwqDCoMKgICogbWFrZSBzdXJlIHF1ZXVlcyBhcmUgbm90IHF1aWVzY2VkIGR1
ZSB0byBhIHJlY29ubmVjdAo+PiArwqDCoMKgwqDCoMKgwqAgKiBzZXF1ZW5jZSB0aGF0IGZhaWxl
ZCBhZnRlciBjcmVhdGluZyBzb21lIEkvTyBxdWV1ZXMKPj4gK8KgwqDCoMKgwqDCoMKgICovCj4+
ICvCoMKgwqDCoMKgwqAgbnZtZV9zdGFydF9xdWV1ZXMoY3RybCk7Cj4+IMKgwqDCoMKgwqDCoMKg
wqAgZGV2X2luZm8oY3RybC0+Y3RybC5kZXZpY2UsICJGYWlsZWQgcmVjb25uZWN0IGF0dGVtcHQg
JWRcbiIsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBjdHJsLT5jdHJsLm5yX3JlY29ubmVjdHMpOwo+PiDCoMKgwqDCoMKgwqDCoMKgIG52bWVfcmRt
YV9yZWNvbm5lY3Rfb3JfcmVtb3ZlKGN0cmwpOwo+PiAtLSAKPj4gLlN1cmVseSB0aGlzIGNhbiBz
b2x2ZSB0aGUgcHJvYmxlbSwgYnV0IHdoZW4gY29udHJvbGxlciByZXNldCBpbgo+IG11bHRpcGF0
aCBlbnZpcm9ubWVudCB3ZSBleHBlY3QgZmFpbCBvdmVyIHRvIG90aGVyIHBhdGggYW5kIHJldHJ5
IGlvLAo+IGp1c3QgbGlrZSBlcnJvciByZWNvdmVyeS4gQm90aCBmb3IgY29udHJvbGxlciByZXNl
dCBhbmQgZXJyb3IgcmVjb3ZlcnksCj4gd2UgbmVlZCB1bnF1aWVzY2UgdGhlIHF1ZXVlLiBTbyBu
dm1lX3JkbWFfdGVhcmRvd25faW9fcXVldWVzIHNob3VsZAo+IGRpcmVjdGx5IHVucXVpZXNjZSBx
dWV1ZXMgYWZ0ZXIgY2FuY2VsIHJlcXVlc3QsIGRvIG5vdCBuZWVkIGNhcmUKPiB0aGUgcGFyYW1l
dGVyOnJlbW92ZS4KPiBGb3IgdGhpcyBzb2x1dGlvbiwgaWYgbnZtZV9yZG1hX3NldHVwX2N0cmwg
ZmFpbGVkIGluIAo+IG52bWVfcmRtYV9yZXNldF9jdHJsX3dvcmssCj4gd2lsbCBzdGFydCBudm1l
X3JkbWFfcmVjb25uZWN0X2N0cmxfd29yaywgdGh1cyBubyBkaWZmZXJlbmNlLgo+IElmIHdlIGRv
IG5vdCB0b2xlcmF0ZSByZXBlYXRlZCBJL08gcmV0cmllcyBkdXJpbmcgY29udHJvbGxlciByZXNl
dCwKPiB3ZSBjYW4gZG8gbGlrZSB0aGlzOgo+IC0tLQo+ICDCoGRyaXZlcnMvbnZtZS9ob3N0L3Jk
bWEuYyB8IDEgKwo+ICDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+IAo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1h
LmMKPiBpbmRleCBiMzgxZTJjZGU1MGEuLmFjNzljNGQyOTRjMiAxMDA2NDQKPiAtLS0gYS9kcml2
ZXJzL252bWUvaG9zdC9yZG1hLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPiBA
QCAtMTkzNiw2ICsxOTM2LDcgQEAgbnZtZV9yZG1hX3RpbWVvdXQoc3RydWN0IHJlcXVlc3QgKnJx
LCBib29sIHJlc2VydmVkKQo+ICDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiAgwqDCoMKgwqDCoMKg
wqDCoCBmbHVzaF93b3JrKCZjdHJsLT5lcnJfd29yayk7Cj4gIMKgwqDCoMKgwqDCoMKgwqAgbnZt
ZV9yZG1hX3RlYXJkb3duX2lvX3F1ZXVlcyhjdHJsLCBmYWxzZSk7Cj4gK8KgwqDCoMKgwqDCoMKg
IG52bWVfc3RhcnRfcXVldWVzKCZjdHJsLT5jdHJsKTsKPiAgwqDCoMKgwqDCoMKgwqDCoCBudm1l
X3JkbWFfdGVhcmRvd25fYWRtaW5fcXVldWUoY3RybCwgZmFsc2UpOwo+ICDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiBCTEtfRUhfRE9ORTsKPiAgwqDCoMKgwqAgfQoKVGhhdCBpcyBmaW5lIHRvbywg
anVzdCBkbyBub3QgdW5xdWllc2NlIHRoZSBxdWV1ZXMgaW4gYSBub3JtYWwgcmVzZXQuCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1h
aWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

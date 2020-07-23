Return-Path: <SRS0=ANVZ=BC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C08C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 16:31:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0F8B206F4
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2020 16:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aHFyBc67"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0F8B206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=kZAWhC6a4WaWRRW8ObfGfjBUjkWkhaVR3nOwHbTu2GE=; b=aHFyBc67BPfC56QB3f39ORddv
	EO0Yh6QzHlcwdFpF2d3G9XoESZdIO/kPpL9v2SR6n7aLSb2joJFOIGPJ0TMNfw/nD4m+/1XUTl+8z
	0zLLEjs3I4c+fHky0h3gMG/SY9YZ8jTODAemyES4RVm0LhkgQWIJSH3iwQbzOEI1SECkBjOcU4Z4C
	lvLJU913aSfRYd2x0tlnMLMhhKZLAFNhkND+RXaNwiQpjayO0PHfHpFUly3jg3XLxwqAz/sOKo+cb
	MrawhgnqhIV84PYvrG04wLJg6SiDKoVQPauCIKa1Z+38K2Mv7Zkh/f2xlRV3w845TonwN3ruVZ9N7
	DPHPxm+dw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jye7l-00052B-CJ; Thu, 23 Jul 2020 16:31:13 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jye7d-0004zz-RE
 for linux-nvme@lists.infradead.org; Thu, 23 Jul 2020 16:31:10 +0000
Received: by mail-pf1-f196.google.com with SMTP id 1so3256672pfn.9
 for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2020 09:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OSg3P659odw/YHClkWb44mpi2gVJQMrj4csaonS91XU=;
 b=jADYfM8OylCTiOA7/49GVx9gmSz6NhsHWDxOdVdYUpfo/g1rmfQPk0AUb4DeF2uKY+
 9UWKmb28jiB4cRhX6HfVA5f5Z8ECWPlY0wGckw2jQBc5c6nafUfBzT21bJJ5Np1ZRRpG
 ib2MEb0ioSfeWWRR2BcFjJVa2ywjeBTZ/c2b0lDXLMwU7+Zpkd2Ba87yrxapfEMfJeSu
 LVx0IRXGgsPzOPl0jThFPtuXn0y/AU54ZMQv9DdzYjzMn5OaD28wzCB/DiwnMPnMSxBZ
 YgVCyvo+PsPy3fqnGoqZV2EKVdOKMmeXF0X/Anffir/uVWXO9nOMwwkQkxpL1y2DpqAm
 ZC4w==
X-Gm-Message-State: AOAM531LDjcf0cZhg/8+bOvQgUy+q7BHEorMALr6mXUnInw/43E+YNWY
 CE3+zJDvVaBDsaji0YYHrLM=
X-Google-Smtp-Source: ABdhPJyyvcu8C4o7Fgrn9KVp9j+2YsEBTJOpOo0W3SNzvg5r4wKvVBik+FV4lc9zxTsACGISW1ZSXg==
X-Received: by 2002:a63:3151:: with SMTP id x78mr5015940pgx.210.1595521862337; 
 Thu, 23 Jul 2020 09:31:02 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:a07e:34d2:a5fa:d770?
 ([2601:647:4802:9070:a07e:34d2:a5fa:d770])
 by smtp.gmail.com with ESMTPSA id p11sm3199790pjb.3.2020.07.23.09.30.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2020 09:31:01 -0700 (PDT)
Subject: Re: [PATCH] nvme-core: reduce io pause time when fail over
To: Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>
References: <20200722093633.31347-1-lengchao@huawei.com>
 <20200722160054.GA1363519@dhcp-10-100-145-180.wdl.wdc.com>
 <973d6470-05e8-8be4-2c8b-3162f37a971e@grimberg.me>
 <fffa2b82-f933-6531-7f98-2f6269fd0d11@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d6c07da9-e553-19c9-78e8-f52519730b3c@grimberg.me>
Date: Thu, 23 Jul 2020 09:30:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fffa2b82-f933-6531-7f98-2f6269fd0d11@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200723_123105_942359_34C502FF 
X-CRM114-Status: GOOD (  15.46  )
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
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiBVc2luZyBzeW5jaHJvbml6ZV9yY3UoKSBhdCB0aGUgZW5kIG1heSBiZSBsb29raW5nIHRv
IG11Y2ggaW50byBibGstbXEncwo+Pj4gaW50ZXJuYWwgcXVpZXNjZSBpbXBsZW1lbnRhdGlvbi4g
SXQgaGFwcGVucyB0byBiZSB0aGUgcmlnaHQgdGhpbmcgdG8gZG8KPj4+IGZvciBub24tYmxvY2tp
bmcgaGN0eCwgc28gdGhpcyBwYXRjaCBhc3N1bWVzIHRoYXQgd2lsbCBiZSB0cnVlIGZvciBhbnkK
Pj4+IG52bWUgcmVxdWVzdF9xdWV1ZS4KPj4KPj4gbnZtZS10Y3AgYmVjYW1lIGEgYmxvY2sgaGN0
eCBzaW5jZSB3ZSBvcHRpbWl6ZSB0byBkbyBuZXR3b3JrIHNlbmRzIGZyb20KPj4gaW5zaWRlIHF1
ZXVlX3JxLiBTbyB0aGlzIHNob3VsZCBlaXRoZXIgc3BsaXQgaW50byB0d28gZnVuY3Rpb25zIG9y
Cj4+IG52bWUtY29yZSBuZWVkcyB0byBsb29rIGludG8gQkxLX01RX0ZfQkxPQ0tJTkcgYW5kIGRv
IHRoZSByaWdodCB0aGluZy4KPiAKPiBBbm90aGVyIHNvbHV0aW9u77yaaW50cm9kdWNlIGJsa19t
cV9xdWllc2NlX3F1ZXVlX2FzeW5jLAo+IGJsa19tcV9xdWllc2NlX3F1ZXVlX2FzeW5jIGRvIG5v
dCB3YWl0IGFsbCBvbmdvaW5nIGRpc3BhdGNoZXMgY29tcGxldGVkLAo+IGlmIHRoZSBoY3R4IGlz
IG5vdCBibG9jayBoY3R4LiBUaGUgY2FsbGVyIHN1Y2ggYXMgbnZtZV9zdG9wX3F1ZXVlcwo+IHdh
aXQgYWxsIG9uZ29pbmcgZGlzcGF0Y2hlcyBjb21wbGV0ZWQgYWZ0ZXIgYWxsIHF1ZXVlcyBoYXMg
YmVlbiBxdWllc2NlZC4KCkJ1dCB0aGVuIHlvdSBtYWludGFpbiB0aGUgcHJvYmxlbSBmb3IgYmxv
Y2tpbmcgaGN0eCwgc28gaXRzIG5vdCBhIGdvb2QKc29sdXRpb24gKGFuZCBhbHNvIGl0cyBub3Qg
YSBnb29kIHByYWN0aWNlIHRvIGFidXNlIHRoZSByZXR1cm4gY29kZSBsaWtlCnlvdSBkaWQgSU1P
KS4KCldoYXQgd2UgbmVlZCBpcyBzb21ldGhpbmcgbGlrZSB0aGUgZm9sbG93aW5nIHVudGVzdGVk
IHBhdGNoZXM6ClsxXToKLS0KZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1tcS5jIGIvYmxvY2svYmxr
LW1xLmMKaW5kZXggYWJjZjU5MGY2MjM4Li5jNjNiZjM0ODY2ZWIgMTAwNjQ0Ci0tLSBhL2Jsb2Nr
L2Jsay1tcS5jCisrKyBiL2Jsb2NrL2Jsay1tcS5jCkBAIC0yMDksMjMgKzIwOSwxMiBAQCB2b2lk
IGJsa19tcV9xdWllc2NlX3F1ZXVlX25vd2FpdChzdHJ1Y3QgCnJlcXVlc3RfcXVldWUgKnEpCiAg
fQogIEVYUE9SVF9TWU1CT0xfR1BMKGJsa19tcV9xdWllc2NlX3F1ZXVlX25vd2FpdCk7CgotLyoq
Ci0gKiBibGtfbXFfcXVpZXNjZV9xdWV1ZSgpIC0gd2FpdCB1bnRpbCBhbGwgb25nb2luZyBkaXNw
YXRjaGVzIGhhdmUgZmluaXNoZWQKLSAqIEBxOiByZXF1ZXN0IHF1ZXVlLgotICoKLSAqIE5vdGU6
IHRoaXMgZnVuY3Rpb24gZG9lcyBub3QgcHJldmVudCB0aGF0IHRoZSBzdHJ1Y3QgcmVxdWVzdCBl
bmRfaW8oKQotICogY2FsbGJhY2sgZnVuY3Rpb24gaXMgaW52b2tlZC4gT25jZSB0aGlzIGZ1bmN0
aW9uIGlzIHJldHVybmVkLCB3ZSBtYWtlCi0gKiBzdXJlIG5vIGRpc3BhdGNoIGNhbiBoYXBwZW4g
dW50aWwgdGhlIHF1ZXVlIGlzIHVucXVpZXNjZWQgdmlhCi0gKiBibGtfbXFfdW5xdWllc2NlX3F1
ZXVlKCkuCi0gKi8KLXZvaWQgYmxrX21xX3F1aWVzY2VfcXVldWUoc3RydWN0IHJlcXVlc3RfcXVl
dWUgKnEpCit2b2lkIGJsa19tcV9xdWllc2NlX3F1ZXVlX3N5bmMoc3RydWN0IHJlcXVlc3RfcXVl
dWUgKnEpCiAgewogICAgICAgICBzdHJ1Y3QgYmxrX21xX2h3X2N0eCAqaGN0eDsKICAgICAgICAg
dW5zaWduZWQgaW50IGk7CiAgICAgICAgIGJvb2wgcmN1ID0gZmFsc2U7CgotICAgICAgIGJsa19t
cV9xdWllc2NlX3F1ZXVlX25vd2FpdChxKTsKLQogICAgICAgICBxdWV1ZV9mb3JfZWFjaF9od19j
dHgocSwgaGN0eCwgaSkgewogICAgICAgICAgICAgICAgIGlmIChoY3R4LT5mbGFncyAmIEJMS19N
UV9GX0JMT0NLSU5HKQogICAgICAgICAgICAgICAgICAgICAgICAgc3luY2hyb25pemVfc3JjdSho
Y3R4LT5zcmN1KTsKQEAgLTIzNSw2ICsyMjQsMjIgQEAgdm9pZCBibGtfbXFfcXVpZXNjZV9xdWV1
ZShzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSkKICAgICAgICAgaWYgKHJjdSkKICAgICAgICAgICAg
ICAgICBzeW5jaHJvbml6ZV9yY3UoKTsKICB9CitFWFBPUlRfU1lNQk9MX0dQTChibGtfbXFfcXVp
ZXNjZV9xdWV1ZV9zeW5jKTsKKworLyoqCisgKiBibGtfbXFfcXVpZXNjZV9xdWV1ZSgpIC0gd2Fp
dCB1bnRpbCBhbGwgb25nb2luZyBkaXNwYXRjaGVzIGhhdmUgZmluaXNoZWQKKyAqIEBxOiByZXF1
ZXN0IHF1ZXVlLgorICoKKyAqIE5vdGU6IHRoaXMgZnVuY3Rpb24gZG9lcyBub3QgcHJldmVudCB0
aGF0IHRoZSBzdHJ1Y3QgcmVxdWVzdCBlbmRfaW8oKQorICogY2FsbGJhY2sgZnVuY3Rpb24gaXMg
aW52b2tlZC4gT25jZSB0aGlzIGZ1bmN0aW9uIGlzIHJldHVybmVkLCB3ZSBtYWtlCisgKiBzdXJl
IG5vIGRpc3BhdGNoIGNhbiBoYXBwZW4gdW50aWwgdGhlIHF1ZXVlIGlzIHVucXVpZXNjZWQgdmlh
CisgKiBibGtfbXFfdW5xdWllc2NlX3F1ZXVlKCkuCisgKi8KK3ZvaWQgYmxrX21xX3F1aWVzY2Vf
cXVldWUoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEpCit7CisgICAgICAgYmxrX21xX3F1aWVzY2Vf
cXVldWVfbm93YWl0KHEpOworICAgICAgIGJsa19tcV9xdWllc2NlX3F1ZXVlX3N5bmMocSk7Cit9
CiAgRVhQT1JUX1NZTUJPTF9HUEwoYmxrX21xX3F1aWVzY2VfcXVldWUpOwoKICAvKgpkaWZmIC0t
Z2l0IGEvaW5jbHVkZS9saW51eC9ibGstbXEuaCBiL2luY2x1ZGUvbGludXgvYmxrLW1xLmgKaW5k
ZXggMjMyMzBjMWQwMzFlLi43ZmQ2OTk0ZDViMzIgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgv
YmxrLW1xLmgKKysrIGIvaW5jbHVkZS9saW51eC9ibGstbXEuaApAQCAtNTMyLDYgKzUzMiw3IEBA
IGludCBibGtfbXFfbWFwX3F1ZXVlcyhzdHJ1Y3QgYmxrX21xX3F1ZXVlX21hcCAqcW1hcCk7CiAg
dm9pZCBibGtfbXFfdXBkYXRlX25yX2h3X3F1ZXVlcyhzdHJ1Y3QgYmxrX21xX3RhZ19zZXQgKnNl
dCwgaW50IApucl9od19xdWV1ZXMpOwoKICB2b2lkIGJsa19tcV9xdWllc2NlX3F1ZXVlX25vd2Fp
dChzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSk7Cit2b2lkIGJsa19tcV9xdWllc2NlX3F1ZXVlX3N5
bmMoc3RydWN0IHJlcXVlc3RfcXVldWUgKnEpOwoKICB1bnNpZ25lZCBpbnQgYmxrX21xX3JxX2Nw
dShzdHJ1Y3QgcmVxdWVzdCAqcnEpOwotLQoKWzJdOgotLQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9u
dm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCmluZGV4IGMxNmJmZGZm
Mjk1My4uMzVjMzk5MzJjNDkxIDEwMDY0NAotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMK
KysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCkBAIC00NTM1LDggKzQ1MzUsMTEgQEAgdm9p
ZCBudm1lX3N0b3BfcXVldWVzKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCgogICAgICAgICBkb3du
X3JlYWQoJmN0cmwtPm5hbWVzcGFjZXNfcndzZW0pOwogICAgICAgICBsaXN0X2Zvcl9lYWNoX2Vu
dHJ5KG5zLCAmY3RybC0+bmFtZXNwYWNlcywgbGlzdCkKLSAgICAgICAgICAgICAgIGJsa19tcV9x
dWllc2NlX3F1ZXVlKG5zLT5xdWV1ZSk7CisgICAgICAgICAgICAgICBibGtfbXFfcXVpZXNjZV9x
dWV1ZV9ub3dhaXQobnMtPnF1ZXVlKTsKKyAgICAgICAvKiBhbGwgbmFtZXNwYWNlcyBzaGFyZSBo
Y3R4cywgc28gc3luYyBqdXN0IG9uY2UgKi8KKyAgICAgICBibGtfbXFfcXVpZXNjZV9xdWV1ZV9z
eW5jKG5zLT5xdWV1ZSk7CiAgICAgICAgIHVwX3JlYWQoJmN0cmwtPm5hbWVzcGFjZXNfcndzZW0p
OworCiAgfQogIEVYUE9SVF9TWU1CT0xfR1BMKG52bWVfc3RvcF9xdWV1ZXMpOwotLQoKSSBjYW4g
c2VuZCBmb3JtYWwgcGF0Y2hlcyBpZiB5b3UgY2FyZSB0byB0ZXN0IGl0Li4uCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

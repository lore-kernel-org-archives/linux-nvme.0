Return-Path: <SRS0=jy92=BI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107E9C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 02:54:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BA12076E
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2020 02:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yM7b1TZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BA12076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PgHK59L3knMBdC/dU+suQl35wZHP5jJXvfJPXymaQWQ=; b=yM7b1TZcWiVZZVKKTXqz7syeQ
	+utfdY+/CC0v4fKNJomSNPEKuKhxHZitXW8Ct+13mQIO3z66I9aplleIG5ltj6fnHTvshEPLCEjhY
	rg/meM1Ose66SGtrGmI0ofEaH9NlycDVFdDYXuVXTSbuhe8zWeyuzH3CiCnPFXsjY4je1VQKWJNNS
	wl6f2JUxpPcQcLX3qobKvGBTYixahLhtuUM2TEYtNXQd0EkxiS82mJaYQiAu9HJAkktaxyDYe0fO4
	85tUIyXc4N3iOZzJECMeak64QWEe00dw1D453XIw0AKX+KLKNTgBg58d0u6AieDUCoB+QanfOHGdS
	LZa+dOOdQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0cEu-0000Ep-2R; Wed, 29 Jul 2020 02:54:44 +0000
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0cEq-0000E9-Bq
 for linux-nvme@lists.infradead.org; Wed, 29 Jul 2020 02:54:41 +0000
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id F1F491531B148017D952;
 Wed, 29 Jul 2020 10:54:33 +0800 (CST)
Received: from [10.27.125.30] (10.27.125.30) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0;
 Wed, 29 Jul 2020 10:54:30 +0800
Subject: Re: [PATCH] nvme-core: fix io interrupt when work with dm-multipah
To: Christoph Hellwig <hch@lst.de>
References: <20200727055818.21430-1-lengchao@huawei.com>
 <20200728111956.GA31546@lst.de>
From: Chao Leng <lengchao@huawei.com>
Message-ID: <6df01884-5498-0809-b358-0c9f7d775a73@huawei.com>
Date: Wed, 29 Jul 2020 10:54:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200728111956.GA31546@lst.de>
Content-Language: en-US
X-Originating-IP: [10.27.125.30]
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_225440_703959_543E8C14 
X-CRM114-Status: GOOD (  18.17  )
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
Cc: kbusch@kernel.org, axboe@fb.com, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyMDIwLzcvMjggMTk6MTksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+IE9uIE1vbiwg
SnVsIDI3LCAyMDIwIGF0IDAxOjU4OjE4UE0gKzA4MDAsIENoYW8gTGVuZyB3cm90ZToKPj4gVGhl
IHByb3RvY29sIE5WTS1FeHByZXNzLTEuNCBkZWZpbmU6Cj4+IENvbW1hbmQgSW50ZXJydXB0ZWQ6
IENvbW1hbmQgcHJvY2Vzc2luZyB3YXMgaW50ZXJydXB0ZWQgYW5kIHRoZQo+PiBjb250cm9sbGVy
IGlzIHVuYWJsZSB0byBzdWNjZXNzZnVsbHkgY29tcGxldGUgdGhlIGNvbW1hbmQuIFRoZSBob3N0
Cj4+IHNob3VsZCByZXRyeSB0aGUgY29tbWFuZC4gSWYgdGhpcyBzdGF0dXMgY29kZSBpcyByZXR1
cm5lZCwgdGhlbgo+PiB0aGUgY29udHJvbGxlciBzaGFsbCBjbGVhciB0aGUgRG8gTm90IFJldHJ5
IGJpdCB0byDigJgw4oCZIGluIHRoZSBTdGF0dXMKPj4gZmllbGQgb2YgdGhlIENRRSAocmVmZXIg
dG8gRmlndXJlIDEyNCkuIFRoZSBjb250cm9sbGVyIHNoYWxsIG5vdCByZXR1cm4KPj4gdGhpcyBz
dGF0dXMgY29kZSB1bmxlc3MgdGhlIGhvc3QgaGFzIHNldCB0aGUgQWR2YW5jZWQgQ29tbWFuZCBS
ZXRyeQo+PiBFbmFibGUgKEFDUkUpIGZpZWxkIHRvIDFoIGluIHRoZSBIb3N0IEJlaGF2aW9yIFN1
cHBvcnQgZmVhdHVyZShyZWZlciB0bwo+PiBzZWN0aW9uIDUuMjEuMS4yMikuCj4+Cj4+IEFjY29y
ZGluZyB0aGUgcHJvdG9jb2wgZGVmaW5lLCBOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRCBuZWVkIHJl
dHJ5Lgo+PiBUaGUgZXJyb3IgY29kZSBOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRCBzaG91bGQgbm90
IHRyYW5zbGF0ZSB0bwo+PiBCTEtfU1RTX1RBUkdFVCwgYmVjYXVzZSBpZiB0aGUgZXJyb3IgY29k
ZSB0cmFuc2xhdGUgdG8gQkxLX1NUU19UQVJHRVQsCj4+IGRtLW11bHRpcGFoIHdpbGwgcmV0dXJu
IGVycm9yIHRvIGFwcGxpY2F0aW9uLiBTbyBpZiB0YXJnZXQgcmV0dXJuIGVycm9yCj4+IGNvZGUg
TlZNRV9TQ19DTURfSU5URVJSVVBURUQsIGlvIHdpbGwgaW50ZXJydXB0LiBOVk1FX1NDX0NNRF9J
TlRFUlJVUFRFRAo+PiBzaG91bGQgdHJhbnNsYXRlIHRvIEJMS19TVFNfSU9FUlIgYnkgZGVmYXVs
dCwgZG0tbXVsdGlwYXRoIHdpbGwgZmFpbAo+PiBvdmVyIHRvIG90aGVyIHBhdGggcmV0cnkgdGhl
IGlvLgo+IAo+IElPRVJSIHN0aWxsIHNlZW1zIHdyb25nLCB0aG91Z2guCj4gLgoKQkxLX1NUU19U
QVJHRVQgbWVhbnMgdGFyZ2V0IGhhcyBjcml0aWNhbCBlcnJvci4gTlZNRV9TQ19DTURfSU5URVJS
VVBURUQKanVzdCBtZWFucyB0YXJnZXQgbmVlZCByZXRyeSBpby4gSXQgaXMgbm90IHN1aXRhYmxl
IHRvIHRyYW5zbGF0ZQpOVk1FX1NDX0NNRF9JTlRFUlJVUFRFRCB0byBCTEtfU1RTX1RBUkdFVC4g
TWF5YmUgdHJhbnNsYXRlIHRvCkJMS19TVFNfSU9FUlIgaXMgYWxzbyBub3Qgc3VpdGFibGUsIHdl
IHNob3VsZCB0cmFuc2xhdGUKTlZNRV9TQ19DTURfSU5URVJSVVBURUQgdG8gQkxLX1NUU19BR0FJ
Ti4KV2UgY2FuIGRvIGxpa2UgdGhpczoKLS0tCiAgZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIHwg
MyArKy0KICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3Qv
Y29yZS5jCmluZGV4IGMyYzViYzRmYjcwMi4uMzU5Y2U0NzFkZjFkIDEwMDY0NAotLS0gYS9kcml2
ZXJzL252bWUvaG9zdC9jb3JlLmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jCkBAIC0y
MTEsNyArMjExLDYgQEAgc3RhdGljIGJsa19zdGF0dXNfdCBudm1lX2Vycm9yX3N0YXR1cyh1MTYg
c3RhdHVzKQogIAljYXNlIE5WTUVfU0NfQ0FQX0VYQ0VFREVEOgogIAkJcmV0dXJuIEJMS19TVFNf
Tk9TUEM7CiAgCWNhc2UgTlZNRV9TQ19MQkFfUkFOR0U6Ci0JY2FzZSBOVk1FX1NDX0NNRF9JTlRF
UlJVUFRFRDoKICAJY2FzZSBOVk1FX1NDX05TX05PVF9SRUFEWToKICAJCXJldHVybiBCTEtfU1RT
X1RBUkdFVDsKICAJY2FzZSBOVk1FX1NDX0JBRF9BVFRSSUJVVEVTOgpAQCAtMjM2LDYgKzIzNSw4
IEBAIHN0YXRpYyBibGtfc3RhdHVzX3QgbnZtZV9lcnJvcl9zdGF0dXModTE2IHN0YXR1cykKICAJ
CXJldHVybiBCTEtfU1RTX05FWFVTOwogIAljYXNlIE5WTUVfU0NfSE9TVF9QQVRIX0VSUk9SOgog
IAkJcmV0dXJuIEJMS19TVFNfVFJBTlNQT1JUOworCWNhc2UgTlZNRV9TQ19DTURfSU5URVJSVVBU
RUQ6CisJCXJldHVybiBCTEtfU1RTX0FHQUlOOwogIAlkZWZhdWx0OgogIAkJcmV0dXJuIEJMS19T
VFNfSU9FUlI7CiAgCX0KLS0gCjIuMTYuNAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=

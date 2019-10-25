Return-Path: <SRS0=pUqL=YS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9322CA9EA0
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 21:41:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A652084C
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2019 21:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DxfIdes9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A652084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zB4bT7HmS2JjgHCg9i43rWpdM3jHqFZo4qsBhs/sGhg=; b=DxfIdes9W8+b4C3gejSzY/dU5
	hURQZd4CjpvvQnedupu68gRy7GiKaNBfiGnAMtKXeipLt7irKbt5smWvQI4s/FpSAED78t6c4D5Rw
	0pgW2WSh65UM1we5XouIRCwYBWBzIIEUd/YsAkZw5+SPpHQ4Pz9NM4lFYwdlcglAZnfoBxM0DPmOm
	dqh5xinAGKU/Q9IYKjH2oMpnBH0XEl1oHfxqqgCzarqc2+UtZ7WfCoSZdk8oIVvjyNoV9gNx3rMkx
	EC4Vk3vvBhuyKsqRgciaxNt9PyADgD3ytWKHyqpxSFI63G5AcVPzxsIuBdX9WX89t0NGn6/8jgcxi
	a63DymH1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iO7K1-0006km-PV; Fri, 25 Oct 2019 21:40:37 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iO7Jp-0006Vy-P0
 for linux-nvme@lists.infradead.org; Fri, 25 Oct 2019 21:40:27 +0000
Received: by mail-wm1-f67.google.com with SMTP id w9so3436601wmm.5
 for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2019 14:40:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KqXCDwMNLnU9Sq5mjJqUeqsnhfK8AbIw6Nf9qBzmidA=;
 b=eC0dkh+jxfWp5YXQ2MLftHxupm1s/g9a76HpZuXmVM0JbCX8h0cl3jA20HyXcCdpIC
 y2Yvso1oUMqAX/ZQwav/pWcvJ09sgzfYSpNWHVJxj0uP82w7jrpjpzkPueDC8GjrXTTc
 iY7N45tCInvQlGJAbvMr7wHKnuPpLuy4+k3jrC3BuNPGdrmdnS6uT5FH3HMSSl5okbwy
 Ue63V9uepdiNad/fgXVX28J6tENIc8gKkSbHElVw6tqDBQGZ4+dZrC3c9B/zYWfrsMSv
 yZYnVNOFyULsHodp1sdyvONQlviXkqSZSgfSaLm9kVaKnpXDK1AIgW39F2eYORZ0pfIb
 xkmg==
X-Gm-Message-State: APjAAAWDYWQuAw7v7kmnyDhMTR17mv803lp9KAD/XR6lsqY6pT02hYC9
 agckLCgoNc87xF6e4oJHwlo=
X-Google-Smtp-Source: APXvYqymbwQKh72Rl1MZ6bfp6hyf49nHbGJoeGwrP2gGGiP1hWP9BfsPEOxl7jNURX5qoP5WvBuH1w==
X-Received: by 2002:a1c:96d5:: with SMTP id y204mr3257831wmd.63.1572039624378; 
 Fri, 25 Oct 2019 14:40:24 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id h17sm3759607wme.6.2019.10.25.14.40.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Oct 2019 14:40:23 -0700 (PDT)
Subject: Re: [RFC PATCH 3/3] nvme: Introduce nvme_execute_passthru_rq_nowait()
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20191025202535.12036-1-logang@deltatee.com>
 <20191025202535.12036-4-logang@deltatee.com>
 <28b40ab8-c695-784e-3f52-03a18b891d25@grimberg.me>
 <11006dd2-718f-b569-4ef3-c01232354d5f@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <952c93fa-ef69-e113-a285-b1e9a0ddcafc@grimberg.me>
Date: Fri, 25 Oct 2019 14:40:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <11006dd2-718f-b569-4ef3-c01232354d5f@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191025_144025_809988_D9ABC3A9 
X-CRM114-Status: GOOD (  19.14  )
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
Cc: Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Stephen Bates <sbates@raithlin.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiArI2lmZGVmIENPTkZJR19OVk1FX1RBUkdFVF9QQVNTVEhSVQo+Pj4gK3N0YXRpYyB2b2lk
IG52bWVfZXhlY3V0ZV9wYXNzdGhydV9ycV93b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqdykKPj4+
ICt7Cj4+PiArwqDCoMKgIHN0cnVjdCBudm1lX3JlcXVlc3QgKnJlcSA9IGNvbnRhaW5lcl9vZih3
LCBzdHJ1Y3QgbnZtZV9yZXF1ZXN0LAo+Pj4gd29yayk7Cj4+PiArwqDCoMKgIHN0cnVjdCByZXF1
ZXN0ICpycSA9IGJsa19tcV9ycV9mcm9tX3BkdShyZXEpOwo+Pj4gK8KgwqDCoCBycV9lbmRfaW9f
Zm4gKmRvbmUgPSBycS0+ZW5kX2lvOwo+Pj4gK8KgwqDCoCB2b2lkICplbmRfaW9fZGF0YSA9IHJx
LT5lbmRfaW9fZGF0YTsKPj4KPj4gV2h5IGlzIGVuZF9pb19kYXRhIHN0b3JlZCB0byBhIGxvY2Fs
IHZhcmlhYmxlIGhlcmU/IHdoZXJlIGlzIGl0IHNldD8KPiAKPiBibGtfZXhlY3V0ZV9ycSgpICh3
aGljaCBpcyBjYWxsZWQgYnkgbnZtZV9leGVjdXRlX3JxKCkpIHdpbGwgb3ZlcndyaXRlCj4gcnEt
PmVuZGlvIGFuZCBycS0+ZW5kX2lvX2RhdGEuIFdlIHN0b3JlIHRoZW0gaGVyZSBzbyB3ZSBjYW4g
Y2FsbCB0aGUKPiBjYWxsYmFjayBhcHByb3ByaWF0ZWx5IGFmdGVyIHRoZSByZXF1ZXN0IGNvbXBs
ZXRlcy4gSXQgd291bGQgYmUgc2V0IGJ5Cj4gdGhlIGNhbGxlciBpbiB0aGUgc2FtZSB3YXkgdGhl
eSBzZXQgaXQgaWYgdGhleSB3ZXJlIGNhbGxpbmcKPiBibGtfZXhlY3V0ZV9ycV9ub3dhaXQoKS4K
Ckkgc2VlLi4KCj4+PiArCj4+PiArwqDCoMKgIG52bWVfZXhlY3V0ZV9wYXNzdGhydV9ycShycSk7
Cj4+PiArCj4+PiArwqDCoMKgIGlmIChkb25lKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgcnEtPmVu
ZF9pb19kYXRhID0gZW5kX2lvX2RhdGE7Cj4+PiArwqDCoMKgwqDCoMKgwqAgZG9uZShycSwgMCk7
Cj4+PiArwqDCoMKgIH0KPj4+ICt9Cj4+PiArCj4+PiArdm9pZCBudm1lX2V4ZWN1dGVfcGFzc3Ro
cnVfcnFfbm93YWl0KHN0cnVjdCByZXF1ZXN0ICpycSwgcnFfZW5kX2lvX2ZuCj4+PiAqZG9uZSkK
Pj4+ICt7Cj4+PiArwqDCoMKgIHN0cnVjdCBudm1lX2NvbW1hbmQgKmNtZCA9IG52bWVfcmVxKHJx
KS0+Y21kOwo+Pj4gK8KgwqDCoCBzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsID0gbnZtZV9yZXEocnEp
LT5jdHJsOwo+Pj4gK8KgwqDCoCBzdHJ1Y3QgbnZtZV9ucyAqbnMgPSBycS0+cS0+cXVldWVkYXRh
Owo+Pj4gK8KgwqDCoCBzdHJ1Y3QgZ2VuZGlzayAqZGlzayA9IG5zID8gbnMtPmRpc2sgOiBOVUxM
Owo+Pj4gK8KgwqDCoCB1MzIgZWZmZWN0czsKPj4+ICsKPj4+ICvCoMKgwqAgLyoKPj4+ICvCoMKg
wqDCoCAqIFRoaXMgZnVuY3Rpb24gbWF5IGJlIGNhbGxlZCBpbiBpbnRlcnJ1cHQgY29udGV4dCwg
c28gd2UgY2Fubm90Cj4+PiBzbGVlcAo+Pj4gK8KgwqDCoMKgICogYnV0IG52bWVfcGFzc3RocnVf
W3N0YXJ0fGVuZF0oKSBtYXkgc2xlZXAgc28gd2UgbmVlZCB0byBleGVjdXRlCj4+PiArwqDCoMKg
wqAgKiB0aGUgY29tbWFuZCBpbiBhIHdvcmsgcXVldWUuCj4+PiArwqDCoMKgwqAgKi8KPj4+ICvC
oMKgwqAgZWZmZWN0cyA9IG52bWVfY29tbWFuZF9lZmZlY3RzKGN0cmwsIG5zLCBjbWQtPmNvbW1v
bi5vcGNvZGUpOwo+Pj4gK8KgwqDCoCBpZiAoZWZmZWN0cykgewo+Pj4gK8KgwqDCoMKgwqDCoMKg
IHJxLT5lbmRfaW8gPSBkb25lOwo+Pj4gK8KgwqDCoMKgwqDCoMKgIElOSVRfV09SSygmbnZtZV9y
ZXEocnEpLT53b3JrLCBudm1lX2V4ZWN1dGVfcGFzc3RocnVfcnFfd29yayk7Cj4+PiArwqDCoMKg
wqDCoMKgwqAgcXVldWVfd29yayhudm1lX3dxLCAmbnZtZV9yZXEocnEpLT53b3JrKTsKPj4KPj4g
VGhpcyB3b3JrIHdpbGwgbmVlZCB0byBiZSBmbHVzaGVkIHdoZW4gaW4gbnZtZV9zdG9wX2N0cmwu
IFRoYXQgaXMKPj4gYXNzdW1pbmcgdGhhdCBpdCB3aWxsIGZhaWwtZmFzdCBhbmQgbm90IGhhbmcg
KHdoaWNoIGl0IHNob3VsZCBnaXZlbgo+PiB0aGF0IGl0cyBhIHBhc3N0aHJ1IGNvbW1hbmQgdGhh
dCBpcyBhbGxvY2F0ZWQgdmlhIG52bWVfYWxsb2NfcmVxdWVzdCkuCj4gCj4gSG1tLCB0aGF0J3Mg
Z29pbmcgdG8gYmUgYSBiaXQgdHJpY2t5LiBTZWVpbmcgdGhlIHdvcmtfc3RydWN0IGJlbG9uZ3MK
PiBwb3RlbnRpYWxseSB0byBhIG51bWJlciBvZiBkaWZmZXJlbnQgcmVxdWVzdHMsIHdlIGNhbid0
IGp1c3QgZmx1c2ggdGhlCj4gaW5kaXZpZHVhbCB3b3JrIGl0ZW1zLiBJIHRoaW5rIHdlJ2QgaGF2
ZSB0byBjcmVhdGUgYSB3b3JrLXF1ZXVlIHBlciBjdHJsCj4gYW5kIGZsdXNoIHRoYXQuIEFueSBv
YmplY3Rpb25zIHRvIHRoYXQ/CgpJJ2Qgb2JqZWN0IHRvIHRoYXQgb3ZlcmhlYWQuLi4KCkhvdyBh
Ym91dCBtYXJraW5nIHRoZSByZXF1ZXN0IGlmIHRoZSB3b3JrcXVldWUgcGF0aCBpcyB0YWtlbiBh
bmQKaW4gbnZtZV9zdG9wX2N0cmwgeW91IGFkZCBhIGJsa19tcV90YWdzZXRfYnVzeV9pdGVyIGFu
ZCBjYW5jZWwKaXQgaW4gdGhlIGNhbGxiYWNrPwoKU29tZXRoaW5nIGxpa2U6Ci0tCmRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMK
aW5kZXggZmE3YmEwOWRjYTc3Li4xM2RiYmVjNTQ5N2QgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZt
ZS9ob3N0L2NvcmUuYworKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKQEAgLTM5NTUsMTIg
KzM5NTUsMzMgQEAgdm9pZCBudm1lX2NvbXBsZXRlX2FzeW5jX2V2ZW50KHN0cnVjdCBudm1lX2N0
cmwgCipjdHJsLCBfX2xlMTYgc3RhdHVzLAogIH0KICBFWFBPUlRfU1lNQk9MX0dQTChudm1lX2Nv
bXBsZXRlX2FzeW5jX2V2ZW50KTsKCitzdGF0aWMgYm9vbCBudm1lX2ZsdXNoX2FzeW5jX3Bhc3N0
aHJ1X3JlcXVlc3Qoc3RydWN0IHJlcXVlc3QgKnJxLAorICAgICAgICAgICAgICAgdm9pZCAqZGF0
YSwgYm9vbCByZXNlcnZlZCkKK3sKKyAgICAgICBpZiAoIShudm1lX3JlcShycSktPmZsYWdzICYg
TlZNRV9SRVFfQVNZTkNfUEFTU1RIUlUpKQorICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7CisK
KyAgICAgICBkZXZfZGJnX3JhdGVsaW1pdGVkKCgoc3RydWN0IG52bWVfY3RybCAqKSBkYXRhKS0+
ZGV2aWNlLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJDYW5jZWxsaW5nIHBhc3N0
aHJ1IEkvTyAlZCIsIHJlcS0+dGFnKTsKKyAgICAgICBmbHVzaF93b3JrKCZudm1lX3JlcShycSkt
PndvcmspOworICAgICAgIHJldHVybiB0cnVlOworfQorCitzdGF0aWMgdm9pZCBudm1lX2ZsdXNo
X2FzeW5jX3Bhc3N0aHJ1X3JlcXVlc3RzKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpCit7CisgICAg
ICAgYmxrX21xX3RhZ3NldF9idXN5X2l0ZXIoY3RybC0+dGFnc2V0LAorICAgICAgICAgICAgICAg
bnZtZV9mbHVzaF9hc3luY19wYXNzdGhydV9yZXF1ZXN0LCBjdHJsKTsKKyAgICAgICBibGtfbXFf
dGFnc2V0X2J1c3lfaXRlcihjdHJsLT5hZG1pbl90YWdzZXQsCisgICAgICAgICAgICAgICBudm1l
X2ZsdXNoX2FzeW5jX3Bhc3N0aHJ1X3JlcXVlc3QsIGN0cmwpOworfQorCiAgdm9pZCBudm1lX3N0
b3BfY3RybChzdHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQogIHsKICAgICAgICAgbnZtZV9tcGF0aF9z
dG9wKGN0cmwpOwogICAgICAgICBudm1lX3N0b3Bfa2VlcF9hbGl2ZShjdHJsKTsKICAgICAgICAg
Zmx1c2hfd29yaygmY3RybC0+YXN5bmNfZXZlbnRfd29yayk7CiAgICAgICAgIGNhbmNlbF93b3Jr
X3N5bmMoJmN0cmwtPmZ3X2FjdF93b3JrKTsKKyAgICAgICBudm1lX2ZsdXNoX2FzeW5jX3Bhc3N0
aHJ1X3JlcXVlc3RzKGN0cmwpOwogIH0KICBFWFBPUlRfU1lNQk9MX0dQTChudm1lX3N0b3BfY3Ry
bCk7Ci0tCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

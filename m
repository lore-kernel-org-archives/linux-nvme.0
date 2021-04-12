Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B633C433B4
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 10:20:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24AB261352
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 10:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24AB261352
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZWv812GsChnDK7O4VhPAR5fSExniCMG/ERNuDKMZEVc=; b=ckPoNvbMmV6014DLIIeCAIm3g
	2TkpVvBH6ACntdWdUuyGLMYGkaxspfEtYoW/4sJWPRqX24ao1CwzVvJwnkDGFyyNdFunVdP4khyjX
	hA8B6it3EmJPd1uMLndYTFAZXwjWWc56VunDC2JGj4R66cx4HIV16LLOAap5e8S3AaxK2X3+ZX003
	8hEHaIkhmigGY1VX7DUKfyGUP516USkoXB+SZ7U0MJwBiekfzOG+SzuQu1ZYi2jBwbYro5w45bAd1
	a0c5N31nvTqQZx69+QiTQ4C1JVjRyrXZQINsxwYwXBXTDnORg3yB+KNeuFVivwSPIfO5zU6/Z6INO
	bV0DE++1Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVtgD-006QQl-EG; Mon, 12 Apr 2021 10:20:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVtg9-006QQP-Ch
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 10:20:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=2sbKiGrB8YoAZxs5BogjkkYEwaFJJeJeaYHJx6e+ubc=; b=uBDx8jXAB4LA7ewIlhT2tz1M+N
 yOjM6fM/tYSP4B6qlzihGDK0LfD31hfSw30GVi5R+ogNpBnDJuf4gpdvev/p39JbY3qebarDiINLP
 fsbXQdEXBZBoeRSafl94B8owKk+VmammBPZ0uKqeHBGEDzvnGMVcwxaZINdb+hMQ+k2ezKVWvBGaq
 PlVVbLoZOhgus6XcHLiSTK80MhS2OvaDTe6B15OftgE5JIO+iaxStDkIJzm1ReST/9GtWbyxXa2eB
 zEO6GRVB4hDr8HqrFEPTXH987pp9rkClsYw5aODN4tYhpxg73fjXrAvFxCkp10R0hufQK5lLJeEsj
 7cR68DaQ==;
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVtg6-0067vV-Oj
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 10:20:24 +0000
Received: by mail-ed1-x530.google.com with SMTP id w18so14456175edc.0
 for <linux-nvme@lists.infradead.org>; Mon, 12 Apr 2021 03:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=2sbKiGrB8YoAZxs5BogjkkYEwaFJJeJeaYHJx6e+ubc=;
 b=B2Dgm9YsV9+6JfvdUivIfWALhxdxIDq68rMLubbwC52L7N0XLgBtTDrP/633paOHQU
 SNtxl7QFKlzbXtPt6l8ED/TxnjKW6090tWrkNfKAB90dD4vv1aJ0DDV7FrEH1U/5qstR
 yagAhdsk3wEaH6A0FWpGDgzZeH6iuZ7UYmBaLWb9q5tccBJIXppRD+eElGOk0WIVq4Qx
 XnTfaIi3y4zIpmrf7x7ju2ccvQDk0NSyHrKME6xZBbLwSJYBknRns6QDLMD0XYTAEAnt
 OP9Zwy6W/yYfCw5bc9RFSTtJn37avLV08hQL4Z6+aU83XYPjWRhkh2iEEUhqKMXKQ00m
 ZWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2sbKiGrB8YoAZxs5BogjkkYEwaFJJeJeaYHJx6e+ubc=;
 b=phtTNKPPf4fVY1UxIusnyaE8tz5AATEUq6j5zTWGQTuxaaIo+fPnR6XdSZJaGIX0e4
 Qi4dDWshw3J2O9h+PJpUJ0AxIPDlk/XxvUlfws0ChmIL1tC/6DmeaiYOxO5hVVogsgDW
 7eTFPPxCtQ0CLZ0/xQ2CLQx+6wUtFwh6VI7d/2/xX7K/+Qajy4IL0qHyIrL5B12ApF7W
 tFMrEDSzjRN2c4darJxZpnjgSe4ssf4vgnRZOWvHLjC2aPTO2jcvVX1pOg9v01dtQjQ8
 yYjdwvLw+fporqaIXx59x0MxSwAqia1brpWTPViwgLlP1A5T6TYBoXKyICxlI8jWJIvu
 mvwQ==
X-Gm-Message-State: AOAM531iWbJfh3uqf1yJroVEVos6JSU7nq+7Yc8nVXAQ6IZLQnLDxTWR
 Zz9C91TQ12KFAzKMy6PK+uX2nuHfcxy9jg==
X-Google-Smtp-Source: ABdhPJzZtmGwZe9mc56z2gc8pUTvoTddLIYxpATxbe7+AeiJZ5VixK2wouduyixplQw3AHxG4apKNA==
X-Received: by 2002:aa7:d917:: with SMTP id a23mr19584317edr.80.1618222820781; 
 Mon, 12 Apr 2021 03:20:20 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
 by smtp.gmail.com with ESMTPSA id s17sm5338690ejx.10.2021.04.12.03.20.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Apr 2021 03:20:20 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: deprecated OCSSD support and schedule it for
 removal in Linux 5.15
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20210412081257.2585860-1-hch@lst.de>
 <52ecf402-1361-e5a5-8c58-30d846d33541@lightnvm.io>
 <766257ca-4dd7-e20b-aa79-6ac3984567d4@lightnvm.io>
 <20210412094938.afyxzspcohw63zup@mpHalley.localdomain>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <3bf88f25-d06d-5b95-7eff-dfb8f78bc389@lightnvm.io>
Date: Mon, 12 Apr 2021 12:20:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210412094938.afyxzspcohw63zup@mpHalley.localdomain>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_032022_829568_A9547F45 
X-CRM114-Status: GOOD (  18.04  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTIvMDQvMjAyMSAxMS40OSwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPiBPbiAxMi4wNC4y
MDIxIDExOjI2LCBNYXRpYXMgQmrDuHJsaW5nIHdyb3RlOgo+PiBPbiAxMi8wNC8yMDIxIDExLjIx
LCBNYXRpYXMgQmrDuHJsaW5nIHdyb3RlOgo+Pj4gT24gMTIvMDQvMjAyMSAxMC4xMiwgQ2hyaXN0
b3BoIEhlbGx3aWcgd3JvdGU6Cj4+Pj4gTGlnaHRudm0gd2FzIGFuIGlubm92YXRpdmUgaWRlYSB0
byBleHBvc2UgbW9yZSBsb3ctbGV2ZWwgY29udHJvbCAKPj4+PiBvdmVyIFNTRHMuCj4+Pj4gQnV0
IGl0IGZhaWxlZCB0byBnZXQgcHJvcGVybHkgc3RhbmRhcmRpemVkIGFuZCByZW1haW5zIGEgCj4+
Pj4gbm9uLXN0YW5kYXJpemVkCj4+Pj4gZXh0ZW5zaW9uIHRvIE5WTWUgdGhhdCByZXF1aXJlcyB2
ZW5kb3Igc3BlY2lmaWMgcXVpcmtzIGZvciBhIGZldyAKPj4+PiBub3cgbW9zdGx5Cj4+Pj4gb2Jz
b2xldGUgU1NEIGRldmljZXMuwqAgVGhlIHN0YW5kYXJkaXplZCBaTlMgY29tbWFuZCBzZXQgZm9y
IE5WTWUgCj4+Pj4gaGFzIHRha2UKPj4+PiBvdmVyIGEgbG90IG9mIHRoZSBhcHByb2FjaGVzIGFu
ZCBhbGxvd3MgZm9yIGZ1bGx5IHN0YW5kYXJkaXplZCAKPj4+PiBvcGVyYXRpb24uCj4+Pj4KPj4+
PiBSZW1vdmUgdGhlIExpbnV4IGNvZGUgdG8gc3VwcG9ydCBvcGVuIGNoYW5uZWwgU1NEcyBhcyB0
aGUgZmV3IAo+Pj4+IHByb2R1Y3Rpb24KPj4+PiBkZXBsb3ltZW50cyBvZiB0aGUgYWJvdmUgbWVu
dGlvbmVkIFNTRHMgYXJlIHVzaW5nIHVzZXJzcGFjZSBkcml2ZXIgCj4+Pj4gc3RhY2tzCj4+Pj4g
aW5zdGVhZCBvZiB0aGUgZmFpcmx5IGxpbWl0ZWQgTGludXggc3VwcG9ydC4KPj4+Pgo+Pj4+IFNp
Z25lZC1vZmYtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPgo+Pj4+IC0tLQo+Pj4+
IMKgIGRyaXZlcnMvbGlnaHRudm0vS2NvbmZpZyB8IDQgKysrLQo+Pj4+IMKgIGRyaXZlcnMvbGln
aHRudm0vY29yZS5jwqAgfCAyICsrCj4+Pj4gwqAgMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2xpZ2h0
bnZtL0tjb25maWcgYi9kcml2ZXJzL2xpZ2h0bnZtL0tjb25maWcKPj4+PiBpbmRleCA0YzJjZTIx
MGMxMjM3ZC4uMDRjYWEwZjJkNDQ1YzcgMTAwNjQ0Cj4+Pj4gLS0tIGEvZHJpdmVycy9saWdodG52
bS9LY29uZmlnCj4+Pj4gKysrIGIvZHJpdmVycy9saWdodG52bS9LY29uZmlnCj4+Pj4gQEAgLTQs
NyArNCw3IEBACj4+Pj4gwqAgIwo+Pj4+IMKgIMKgIG1lbnVjb25maWcgTlZNCj4+Pj4gLcKgwqDC
oCBib29sICJPcGVuLUNoYW5uZWwgU1NEIHRhcmdldCBzdXBwb3J0Igo+Pj4+ICvCoMKgwqAgYm9v
bCAiT3Blbi1DaGFubmVsIFNTRCB0YXJnZXQgc3VwcG9ydCAoREVQUkVDQVRFRCkiCj4+Pj4gwqDC
oMKgwqDCoCBkZXBlbmRzIG9uIEJMT0NLCj4+Pj4gwqDCoMKgwqDCoCBoZWxwCj4+Pj4gwqDCoMKg
wqDCoMKgwqAgU2F5IFkgaGVyZSB0byBnZXQgdG8gZW5hYmxlIE9wZW4tY2hhbm5lbCBTU0RzLgo+
Pj4+IEBAIC0xNSw2ICsxNSw4IEBAIG1lbnVjb25maWcgTlZNCj4+Pj4gwqDCoMKgwqDCoMKgwqAg
SWYgeW91IHNheSBOLCBhbGwgb3B0aW9ucyBpbiB0aGlzIHN1Ym1lbnUgd2lsbCBiZSBza2lwcGVk
IAo+Pj4+IGFuZCBkaXNhYmxlZAo+Pj4+IMKgwqDCoMKgwqDCoMKgIG9ubHkgZG8gdGhpcyBpZiB5
b3Uga25vdyB3aGF0IHlvdSBhcmUgZG9pbmcuCj4+Pj4gwqAgK8KgwqDCoMKgwqAgVGhpcyBjb2Rl
IGlzIGRlcHJlY2F0ZWQgYW5kIHdpbGwgYmUgcmVtb3ZlZCBpbiBMaW51eCA1LjE1Lgo+Pj4+ICsK
Pj4+PiDCoCBpZiBOVk0KPj4+PiDCoCDCoCBjb25maWcgTlZNX1BCTEsKPj4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9saWdodG52bS9jb3JlLmMgYi9kcml2ZXJzL2xpZ2h0bnZtL2NvcmUuYwo+Pj4+
IGluZGV4IDI4ZGRjYWE1MzU4YjE0Li40Mzk0ZjQ3YzgxMjk2YSAxMDA2NDQKPj4+PiAtLS0gYS9k
cml2ZXJzL2xpZ2h0bnZtL2NvcmUuYwo+Pj4+ICsrKyBiL2RyaXZlcnMvbGlnaHRudm0vY29yZS5j
Cj4+Pj4gQEAgLTExNzQsNiArMTE3NCw4IEBAIGludCBudm1fcmVnaXN0ZXIoc3RydWN0IG52bV9k
ZXYgKmRldikKPj4+PiDCoCB7Cj4+Pj4gwqDCoMKgwqDCoCBpbnQgcmV0LCBleHBfcG9vbF9zaXpl
Owo+Pj4+IMKgICvCoMKgwqAgcHJfd2Fybl9vbmNlKCJsaWdodG52bSBzdXBwb3J0IGlzIGRlcHJl
Y2F0ZWQgYW5kIHdpbGwgYmUgCj4+Pj4gcmVtb3ZlZCBpbiBMaW51eCA1LjE1LlxuIik7Cj4+Pj4g
Kwo+Pj4+IMKgwqDCoMKgwqAgaWYgKCFkZXYtPnEgfHwgIWRldi0+b3BzKSB7Cj4+Pj4gwqDCoMKg
wqDCoMKgwqDCoMKgIGtyZWZfcHV0KCZkZXYtPnJlZiwgbnZtX2ZyZWUpOwo+Pj4+IMKgwqDCoMKg
wqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4+Cj4+PiBUaGFua3MsIENocmlzdG9waC4KPj4+
Cj4+PiBJJ2xsIHNlbmQgaXQgdG8gSmVucyB3aXRoIHRvZGF5J3MgbGlnaHRudm0gUFIuCj4+Cj4+
IEphdmllciwgY2FuIEkgYWRkIHlvdXIgcmV2aWV3ZWQtYnk/Cj4+Cj4KPiBZZXMsIHBsZWFzZS4K
Pgo+IEknbGwgY3JhY2sgYSBiZWVyIGFuZCBjaGVlciBvbiBpdCB0b25pZ2h0LiBHb29kIHRpbWVz
IDopCj4KPiBKYXZpZXIKClRoYW5rIHlvdS4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1udm1lCg==

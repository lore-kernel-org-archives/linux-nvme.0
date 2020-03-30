Return-Path: <SRS0=mOBO=5P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFE1C43331
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2020 09:15:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D454F20716
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Mar 2020 09:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L7vdjJbN";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMKQ0I32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D454F20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DPRZU68ThO82nvQHe8awrTi4PZh4Up5AgeSC3p7TzWU=; b=L7vdjJbNa2k8bCSZaUEHUAh1B
	TovG/yEBcPoprcUy5B6psr7JgJU0+Sc3tFC6wpxk7DYIi8j6rIWb03d5QXIJOqIiwq9XlgGZXsq3x
	qFzptwgHIl7qh4Kj4s1Sf5z8KxzHkDFlOjaTt1U3fejd9FfBsnKFxbYZK96HTKPyRsMfZ8d1PcrK7
	OkA01vJHQYqEvbcon3m8cjWCOjHAk+ZjthDqHf2CJTfqiLvkqU51Gnx/6P8b6TV7Ttqh6wvU0mbST
	+EgLB41ZYpvaCrcE1mGUkUPmAk72O0OhzWUbWn7C46Z0zERvA/D+VzuFkbjuhiBfAiU/hmUwMWGme
	GJDm6eiUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jIqWK-0008D3-9i; Mon, 30 Mar 2020 09:15:48 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIqWH-0008CU-PR
 for linux-nvme@lists.infradead.org; Mon, 30 Mar 2020 09:15:47 +0000
Received: by mail-pg1-x541.google.com with SMTP id d17so8392912pgo.0
 for <linux-nvme@lists.infradead.org>; Mon, 30 Mar 2020 02:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=fzTGHkyQjMKq4T54Wszt38MMnDiOdS3GcEbQBAx+SC8=;
 b=LMKQ0I32SgI9aIxHnTS/41xNTTBVCMnFoGlF3Db0CaUoaXGRqBI/4ZEmVpFBxRedep
 aaqQhxu9ziTICWdlUadZ8WBT0OYziUU0H4P1ZmLYOCPB6ZsZMmO86ijk3anOQEBcJJVZ
 38QiuuM0jb8UcVzBk+XtTH7QUCKZ11gsaFQsymoe4uD+UuGbViOzETodSqu6lJEmWMr1
 H+RaSumEuX+Nl45Id7uNywum8p/67BpEZEpBncpwvGa7l3SrffkNajXKh9PLcySqBXAD
 aEgVu/NLF/zo2K5mbsm2UauyRQs5KXA99WujOOpUBZ9+4TeipiDj1+QnE2DMTgp6e+n9
 67zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fzTGHkyQjMKq4T54Wszt38MMnDiOdS3GcEbQBAx+SC8=;
 b=MDUdkChxfquU7/WfeUUrtFOpU9XLp9YL0o1RbrZVjP346+Md71qcNZNOQ+kaIVhBzi
 Z+oSMN20cKQU/CfTjw97YO/qatreAiGZrBevjcgYZwkjVtsjlvgwNmW0bMMUNZBsql4v
 t2q/1XXIQsysBRwEedHtbfS1WApn4ITIPy+tlpTvcrgECQD94QOVKuyNBiYDBBAaID5g
 ZacUWX32I1zASm35b9sQFuWwNZoMLh8fyB7vW0p6uq9z4vaSmkKYXk2Kv2Me+3IDcPKh
 AQBdzPMlBhuyEgYefjmF4GonqNRB3f97kPk5eh71TeT2R6+QGTN7xzT4GlXhwoovffkx
 RKfg==
X-Gm-Message-State: ANhLgQ24q/HPwktD2xtDXweyGCXfUmOscfL5ZkJ+Ce5fSt3EzgHAG66V
 OmwFRq6o60dflk2G/TNvpng=
X-Google-Smtp-Source: ADFU+vt7tWn4gQIFf6ULfVVFXuAZXobPiToyhTDJUU21swxV4wp+IPR/j1GjUpkS0gVd+tWmVabEMQ==
X-Received: by 2002:a63:1547:: with SMTP id 7mr11635842pgv.353.1585559744702; 
 Mon, 30 Mar 2020 02:15:44 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:a182:288:3ffa:432a?
 ([240b:10:2720:5510:a182:288:3ffa:432a])
 by smtp.gmail.com with ESMTPSA id a127sm9765594pfa.111.2020.03.30.02.15.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2020 02:15:44 -0700 (PDT)
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
To: Ming Lei <tom.leiming@gmail.com>
References: <20200323182324.3243-1-ikegami.t@gmail.com>
 <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
 <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
 <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
 <a0e7a985-a726-8e16-d29c-eb38a919e18e@gmail.com>
 <CACVXFVMsPstD2ZLnozC8-RsaJ7EMZK9+d47Q+1Z0coFOw3vMhg@mail.gmail.com>
From: Tokunori Ikegami <ikegami.t@gmail.com>
Message-ID: <cc1534d1-34f6-ffdb-27bd-73590ab30437@gmail.com>
Date: Mon, 30 Mar 2020 18:15:41 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CACVXFVMsPstD2ZLnozC8-RsaJ7EMZK9+d47Q+1Z0coFOw3vMhg@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200330_021545_842120_EC654978 
X-CRM114-Status: GOOD (  16.48  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ck9uIDIwMjAvMDMvMjkgMTI6MDEsIE1pbmcgTGVpIHdyb3RlOgo+IE9uIFNhdCwgTWFyIDI4LCAy
MDIwIGF0IDg6NTcgUE0gVG9rdW5vcmkgSWtlZ2FtaSA8aWtlZ2FtaS50QGdtYWlsLmNvbT4gd3Jv
dGU6Cj4+IEhpLAo+Pgo+PiBPbiAyMDIwLzAzLzI4IDExOjExLCBNaW5nIExlaSB3cm90ZToKPj4+
IE9uIFNhdCwgTWFyIDI4LCAyMDIwIGF0IDI6MTggQU0gS2VpdGggQnVzY2ggPGtidXNjaEBrZXJu
ZWwub3JnPiB3cm90ZToKPj4+PiBPbiBTYXQsIE1hciAyOCwgMjAyMCBhdCAwMjo1MDo0M0FNICsw
OTAwLCBUb2t1bm9yaSBJa2VnYW1pIHdyb3RlOgo+Pj4+PiBPbiAyMDIwLzAzLzI1IDE6NTEsIFRv
a3Vub3JpIElrZWdhbWkgd3JvdGU6Cj4+Pj4+PiBPbiAyMDIwLzAzLzI0IDk6MDIsIEtlaXRoIEJ1
c2NoIHdyb3RlOgo+Pj4+Pj4+IFdlIGRpZG4ndCBoYXZlIDMyLWJpdCBtYXggc2VnbWVudHMgYmVm
b3JlLCB0aG91Z2guIFdoeSB3YXMgMTYtYml0cwo+Pj4+Pj4+IGVub3VnaCBpbiBvbGRlciBrZXJu
ZWxzPyBXaGljaCBrZXJuZWwgZGlkIHRoaXMgc3RvcCB3b3JraW5nPwo+Pj4+Pj4gTm93IEkgYW0g
YXNraW5nIHRoZSBkZXRhaWwgaW5mb3JtYXRpb24gdG8gdGhlIHJlcG9ydGVyIHNvIGxldCBtZQo+
Pj4+Pj4gdXBkYXRlIGxhdGVyLiAgVGhhdCB3YXMgYWJsZSB0byB1c2UgdGhlIHNhbWUgY29tbWFu
ZCBzY3JpcHQgd2l0aCB0aGUKPj4+Pj4+IGxhcmdlIGRhdGEgbGVuZ3RoIGluIHRoZSBwYXN0Lgo+
Pj4+PiBJIGhhdmUganVzdCBjb25maXJtZWQgdGhlIGRldGFpbCBzbyBsZXQgbWUgdXBkYXRlIGJl
bG93Lgo+Pj4+Pgo+Pj4+PiBUaGUgZGF0YSBsZW5ndGggMjAsNTMxLDcxMiAoMHgxMzk0QTAwKSBp
cyB1c2VkIG9uIGtlcm5lbCAzLjEwLjAgKENlbnRPUwo+Pj4+PiA2NGJpdCkuCj4+Pj4+IEFsc28g
aXQgaXMgZmFpbGVkIG9uIGtlcm5lbCAxMCA0LjEwLjAgKFVidW50dSAzMmJpdCkuCj4+Pj4+IEJ1
dCBqdXN0IGNvbmZpcm1lZCBpdCBhcyBzdWNjZWVkZWQgb24gYm90aCA0LjE1LjAgKFVidW50dSAz
MmJpdCkgYW5kIDQuMTUuMQo+Pj4+PiAoVWJ1bnR1IDY0Yml0KS4KPj4+Pj4gU28gdGhlIG9yaWdp
bmFsIDIwLDUzMSw3MTIgbGVuZ3RoIGZhaWx1cmUgaXNzdWUgc2VlbXMgYWxyZWFkeSByZXNvbHZl
ZC4KPj4+Pj4KPj4+Pj4gSSB0ZXN0ZWQgdGhlIGRhdGEgbGVuZ3RoIDB4MTAwMDAwMDAgKDI2OCw0
MzUsNDU2KSBhbmQgaXQgaXMgZmFpbGVkCj4+Pj4+IEJ1dCBub3cgY29uZmlybWVkIGl0IGFzIGZh
aWxlZCBvbiBhbGwgdGhlIGFib3ZlIGtlcm5lbCB2ZXJzaW9ucy4KPj4+Pj4gQWxzbyB0aGUgcGF0
Y2ggZml4ZXMgb25seSB0aGlzIDB4MTAwMDAwMDAgbGVuZ3RoIGZhaWx1cmUgaXNzdWUuCj4+Pj4g
VGhpcyBpcyBhY3R1YWxseSBldmVuIG1vcmUgY29uZnVzaW5nLiBXZSBkbyBub3Qgc3VwcG9ydCAy
NTZNQiB0cmFuc2ZlcnMKPj4+PiB3aXRoaW4gYSBzaW5nbGUgY29tbWFuZCBpbiB0aGUgcGNpIG52
bWUgZHJpdmVyIGFueW1vcmUuIFRoZSBtYXggaXMgNE1CLAo+Pj4+IHNvIEkgZG9uJ3Qgc2VlIGhv
dyBpbmNyZWFzaW5nIHRoZSBtYXggc2VnbWVudHMgd2lsbCBoZWxwOiB5b3Ugc2hvdWxkIGJlCj4+
Pj4gaGl0dGluZyB0aGUgJ21heF9zZWN0b3JzJyBsaW1pdCBpZiB5b3UgZG9uJ3QgaGl0IHRoZSBz
ZWdtZW50IGxpbWl0IGZpcnN0Lgo+Pj4gVGhhdCBsb29rcyBhIGJ1ZyBmb3IgcGFzc3Rocm91Z2gg
cmVxLCBiZWNhdXNlICdtYXhfc2VjdG9ycycgbGltaXQgaXMgb25seQo+Pj4gY2hlY2tlZCBpbiBi
aW9fYWRkX3BjX3BhZ2UoKSwgbm90IGRvbmUgaW4gYmxrX3JxX2FwcGVuZF9iaW8oKSwgc29tZXRo
aW5nCj4+PiBsaWtlIHRoZSBmb2xsb3dpbmcgc2VlbXMgcmVxdWlyZWQ6Cj4+Pgo+Pj4gZGlmZiAt
LWdpdCBhL2Jsb2NrL2Jsay1tYXAuYyBiL2Jsb2NrL2Jsay1tYXAuYwo+Pj4gaW5kZXggYjA3OTAy
NjhlZDlkLi5lMTIwZDgwYjc1YTUgMTAwNjQ0Cj4+PiAtLS0gYS9ibG9jay9ibGstbWFwLmMKPj4+
ICsrKyBiL2Jsb2NrL2Jsay1tYXAuYwo+Pj4gQEAgLTIyLDYgKzIyLDEwIEBAIGludCBibGtfcnFf
YXBwZW5kX2JpbyhzdHJ1Y3QgcmVxdWVzdCAqcnEsIHN0cnVjdCBiaW8gKipiaW8pCj4+PiAgICAg
ICAgICAgc3RydWN0IGJpb192ZWMgYnY7Cj4+PiAgICAgICAgICAgdW5zaWduZWQgaW50IG5yX3Nl
Z3MgPSAwOwo+Pj4KPj4+ICsgICAgICAgaWYgKCgocnEtPl9fZGF0YV9sZW4gKyAoKmJpbyktPmJp
X2l0ZXIuYmlfc2l6ZSkgPj4gOSkgPgo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgcXVldWVf
bWF4X2h3X3NlY3RvcnMocnEtPnEpKQo+Pj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRUlOVkFM
Owo+Pj4gKwo+PiBJIGhhdmUganVzdCBjb25maXJtZWQgYWJvdXQgdGhlIG1heF9od19zZWN0b3Jz
IGNoZWNraW5nIGJlbG93Lgo+PiBJdCBpcyBjaGVja2VkIGJ5IHRoZSBmdW5jdGlvbiBibGtfcnFf
bWFwX2tlcm4oKSBhbHNvIGFzIGJlbG93Lgo+Pgo+PiAgICAgICBpZiAobGVuID4gKHF1ZXVlX21h
eF9od19zZWN0b3JzKHEpIDw8IDkpKQo+PiAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gVGhl
IGFib3ZlIGNoZWNrIGRvZXNuJ3QgdGFrZSBycS0+X19kYXRhX2xlbiBpbnRvIGFjY291bnQuCgpU
aGFua3MgZm9yIHRoZSBjb21tZW50IGFuZCBub3RlZCBpdC4KSSBoYXZlIGp1c3QgY29uZmlybWVk
IHRoZSBiZWhhdmlvciBvbiA1LjYuMC1yYzcgYXMgYmVsb3cuCkl0IHdvcmtzIHRvIGxpbWl0IHRo
ZSBkYXRhIGxlbmd0aCBzaXplIDRNQiBhcyBleHBlY3RlZCBiYXNpY2FsbHkuCkFsc28gaXQgY2Fu
IGJlIGxpbWl0ZWQgYnkgdGhlIGNoZWNrIGV4aXN0ZWQgYmVsb3cgaW4gbGxfYmFja19tZXJnZV9m
bigpLgoKIMKgwqDCoCBpZiAoYmxrX3JxX3NlY3RvcnMocmVxKSArIGJpb19zZWN0b3JzKGJpbykg
PgogwqDCoMKgIMKgwqDCoCBibGtfcnFfZ2V0X21heF9zZWN0b3JzKHJlcSwgYmxrX3JxX3Bvcyhy
ZXEpKSkgewoKQnV0IHRoZXJlIGlzIGEgY2FzZSB0aGF0IHRoZSBjb21tYW5kIGRhdGEgbGVuZ3Ro
IGlzIGxpbWl0ZWQgYnkgNTEyS0IuCkkgYW0gbm90IHN1cmUgYWJvdXQgdGhpcyBjb25kaXRpb24g
c28gbmVlZGVkIG1vcmUgaW52ZXN0aWdhdGlvbi4KClJlZ2FyZHMsCklrZWdhbWkKCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxp
bmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

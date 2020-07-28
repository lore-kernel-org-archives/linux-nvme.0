Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36E7C433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 22:47:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC14207E8
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 22:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ic+oJDIl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="aUgCQLdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC14207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W/82W/g/q+8EyZ0+YzOen/7gizjbV3pHai06plsED6U=; b=ic+oJDIlmUbizoIUK62utPHJX
	BIV4sEKlHUHAsSUFFuj+ETgv01xrrpEqcTygSaGZ03fScZGXcqezgps3xvSyAnH9hZ60EXXUYcBaV
	o9eeMO2UD8co5Fx1B1L33Etnn/R35tQM/ucQaDF7XSCB5wpXZpuZZPv4zoWq+nGaUWlCbJAcD1r94
	ZNeUiRXjpEGKIYVAJEomFUgSUS9sRzCoRuhEM7vx/lEZTfZUy42y56u+KbW1H76IU5hG4ZaqntFjf
	BwD+J4TTK+imy/LHt0IZsyLfg5qUHueLIxSTpRljVrEDLsU9dzM91x0mWNB/XJSR3kwxoTn/OSPh0
	YWCFxSW+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0YNP-0003wr-Eg; Tue, 28 Jul 2020 22:47:15 +0000
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0YNM-0003wV-2E
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 22:47:13 +0000
Received: by mail-ej1-x641.google.com with SMTP id g19so8486177ejc.9
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 15:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=1EH+z5/ncUZX9FTsslSkPQMhHjGMoyNPSsu1Dxd/n8g=;
 b=aUgCQLdHtc+1jHlwTy65KxlW+fPBVFlIYjYra6iLyoP/T60cGtaeOiLYl2J3KA81Qe
 AaOHHYr58qAZuvlfdB2qM6PQgY4u+8cbIyD71cD8VW7hg2aqgrpr+KFKypIK6agIvEtU
 xS0BeWYrO/X7sxThH08JuXE/nDDZ3rNLiQc7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=1EH+z5/ncUZX9FTsslSkPQMhHjGMoyNPSsu1Dxd/n8g=;
 b=jrkgLevkbteHW+BuGYnEh/C1YWixWSwGb32sB0F6D+bC/GHqgMHGrnHz1Ty0rCNt2Q
 jw/IwslY2jWCc6HHK4LD1AqE1StcRAMB540XrtMTRzorEqLpcz5P7r3wFU/50CMoCKb1
 M9IJtYWGWurSDyQmJlG7MepLVU3OMEEVGzZC9jotUSQwNDXHrJzObl+lhsYE3kmt/ila
 6P2+CLC50Sp0kBWVBO6+4JBUMqriRqhc2QviKhGLNh2nONwGhoGmheFFXWL+7Z0LSkGU
 6F4PBSfpIAuBTnBh8y1LYjh2Y7NBsXRB0JtadIOfhWS0nZXc3a1xCqjC1ORW15InVKpE
 xVSg==
X-Gm-Message-State: AOAM5300ATCr7lBgtJwyoDRieb/CMU+n7eG8QuBZn85adC1tMdcU2lZT
 UrAuhS7eqQWalyKN2x/6HwF0OJ8WTSNM9A==
X-Google-Smtp-Source: ABdhPJz9R3XDRRNSTwUs73IZWZg5mKjtNdidBQF/PhygxVyGBEwZph92L5bjH8JKpzRFdNvVbVEUbA==
X-Received: by 2002:a17:906:3a9b:: with SMTP id
 y27mr27128542ejd.38.1595976430491; 
 Tue, 28 Jul 2020 15:47:10 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id s2sm36672ejd.17.2020.07.28.15.47.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 15:47:09 -0700 (PDT)
Subject: Re: [PATCH] nvme-fabrics: allow to queue requests for live queues
To: Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
References: <20200728053523.21657-1-sagi@grimberg.me>
 <8ff91295-9393-a548-a46f-85d415d9cbc9@huawei.com>
 <233d8e35-f85f-458e-05ad-5baba1b04bbb@grimberg.me>
 <c782f0c1-76b2-cc67-6770-eb55f9e2a3aa@broadcom.com>
 <612f10f0-3cdd-a7c3-e666-ad9f5c835d00@grimberg.me>
 <8de13e09-dff5-f988-2f99-b781ab826421@broadcom.com>
 <d62657c5-dc81-cde3-8a14-4449684982d9@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <520f2317-533d-b546-dd35-80ae5f707aa7@broadcom.com>
Date: Tue, 28 Jul 2020 15:47:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d62657c5-dc81-cde3-8a14-4449684982d9@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_184712_319013_737D807D 
X-CRM114-Status: GOOD (  27.36  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA3LzI4LzIwMjAgMTozOCBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPgo+Pj4gQ2FuIHlv
dSBwbGVhc2UgZ2l2ZSBhbiBleGFtcGxlPyBOVk1FX1JFUV9VU0VSQ01EIHNob3VsZCBub3QgYmUg
YW55Cj4+PiBkaWZmZXJlbnQgZnJvbSBhbnkgb3RoZXIgdHlwZSBvZiBJL08uCj4+IC4uLgo+Cj4g
VGhlIHByb2JsZW0gSSBoYXZlIHdpdGggdGhpcyBjb2RlIGlzIHRoYXQgY2hlY2tpbmcgZm9yIE5W
TUVfUkVRX1VTRVJDTUQKPiBpcyBhIGJpZyBoYW1tZXIgdGhhdCB5b3UgbGFuZCBvbiB3aGF0IGNh
biBiZSBub3JtYWwgSS9PCj4gKGUuZy4gbnZtZSByZWFkL3dyaXRlL3dyaXRlLXplcm9zKSwgYW5k
IHdlIG11c3Qgbm90IHJlbHkgb24gdGhpcwo+IGluZGljYXRpb24gdG8gcHJldmVudCB3aGF0IHlv
dSBhcmUgZGVzY3JpYmluZy4KPgo+IEl0IG1heWJlIChqdXN0IG1heWJlKSBPSyB0byBjaGVjayBO
Vk1FX1JFUV9VU0VSQ01EIG9ubHkgZm9yIHRoZSBhZG1pbgo+IHF1ZXVlLCBidXQgd2UgYXJlIHJl
YWxseSBjaXJjbGluZyBvdmVyIHRoZSBmYWN0IHRoYXQgd2UgY2Fubm90IHJlbGlhYmx5Cj4gc2Vu
ZCBhZG1pbiBjb25uZWN0IGJlZm9yZSB0byBnbyBvZmYgZmlyc3QsIGJlY2F1c2Ugd2UgaGF2ZSB0
byB1bnF1aWVzY2UKPiBpdCBiZWZvcmUgd2UgaXNzdWUgdGhlIGFkbWluIGNvbm5lY3QsIGFuZCB0
aGVyZSBtaWdodCBiZSBhIHN0cmF5IGNvbW1hbmQKPiBnb2luZyBpbnRvIGV4ZWN1dGlvbiBiZWZv
cmUgd2Ugc3VibWl0IHRoZSBhZG1pbiBjb25uZWN0LgoKYWdyZWUuCgpEaWRuJ3QgeW91IHN1Z2dl
c3Qgc29tZXRoaW5nIHNlcGFyYXRlIHRvIGlzb2xhdGUgdGhlIGNvbm5lY3QgCmNvbW1hbmRzL2lu
aXQgY29tbWFuZHMgP8KgwqAgQ2FuIHdlIHVzZSBhIGRpZmZlcmVudCB0YWcgc2V0IGZvciAKImlu
aXRpYWxpemF0aW9uIiBjb21tYW5kcz/CoCBXZSBjYW4gdXNlIGRpZmZlcmVudCBxdWV1ZV9ycSBy
b3V0aW5lcyB3aXRoIApkaWZmZXJlbnQgY2hlY2sgcmVhZHkgY2hlY2tzLsKgIEkgZG9uJ3QgbGlr
ZSB0aGUgb3ZlcmhlYWQsIGJ1dCBzdXJlIG1ha2VzIAp0aGUgbG9naWMgbW9yZSBzdHJhaWdodGZv
cndhcmQuCgoKPj4+PiBBcyBmb3IgdGhlIGJsa19ycV9pc19wYXNzdGhyb3VnaCBjaGVjayAtIEkg
Z3Vlc3MgSSBjYW4gc2VlIGl0IGJlaW5nIAo+Pj4+IGJhc2VkIG9uIHRoZSBxdWV1ZSBzdGF0ZSwg
YW5kIHRoZSBjaGVjayBsb29rcyBva8KgICh3ZSBzaG91bGQgbmV2ZXIgCj4+Pj4gc2VlICFibGtf
cnFfaXNfcGFzc3Rocm91Z2ggb24gdGhlIGFkbWluIHEpLgo+Pj4+IEJ1dC4uLgo+Pj4+IC0gSSBk
b24ndCBrbm93IHdoeSBpdCB3YXMgdGhhdCBpbXBvcnRhbnQgdG8gY2hhbmdlIGl0LiBPbiB0aGUg
Cj4+Pj4gY29ubmVjdGluZyBwYXRoLCBhbGwgeW91J3JlIGRvaW5nIGlzIGxldHRpbmcgaW8gc3Rh
cnQgZmxvd2luZyAKPj4+PiBiZWZvcmUgYWxsIHRoZSBxdWV1ZXMgaGF2ZSBiZWVuIGNyZWF0ZWQu
wqAgRGlkIHlvdSByZWFsbHkgbmVlZCB0byAKPj4+PiBzdGFydCB0aGF0IG11Y2ggc29vbmVyID8K
Pj4+Cj4+PiBUaGUgaXNzdWUgaXMgdGhhdCBjb250cm9sbGVyIGluIFJFU0VUVElORyBzdGF0ZSB3
aWxsIGhhdmUgcmVxdWVzdHMgdGhhdAo+Pj4gYXJlIGJlaW5nIGlzc3VlZCwgYW5kIGlmIHdlIGRv
bid0IGxldCBpdCBwYXNzIHRocm91Z2gsIGl0IHdpbGwgaGFuZwo+Pj4gYXJvdW5kIGZvcmV2ZXIg
YmVpbmcgcmVxdWV1ZWQgcHJldmVudGluZyBxdWV1ZSBmcmVlemUgdG8gY29tcGxldGUuCj4+CgpJ
c24ndCB0aGlzIHRoZSByZWFsIHByb2JsZW06wqAgd2UgcmVxdWlyZSB0aGUgcmVxdWVzdCB0byBj
b21wbGV0ZSBpbiAKb3JkZXIgdG8gZ2V0IG9mZiB0aGUgcmVxdWVzdCBxdWV1ZSBpbiBvcmRlciB0
byBmcmVlemUuIEJ1dCB0byBjb21wbGV0ZSAtIAppdCBoYXMgdG8gZmluaXNoIHdpdGggc29tZSBz
dGF0dXMuIFRoaXMgaXMgb2sgaWYgcnVubmluZyBtdWx0aXBhdGgsIGFzIAptcGF0aCBxdWV1ZXMg
YW5kIHJldHJpZXMgLSBidXQgd2hhdCBtcGF0aCBpcyBub3QgcnVubmluZyA/IFRoZSBpc3N1ZXIg
b2YgCnRoZSBpbyB3aWxsIGdldCB0aGUgZXJyb3IgPyDCoCBhbSBJIHVuZGVyc3RhbmRpbmcgaXQg
P8KgwqAgSWYgc28gSSBkb24ndCAKdGhpbmsgYSBzaW1wbGUgY2hlY2sgcmVvcmcgc3VjaCBhcyBw
cm9wb3NlZCB3aWxsIHdvcmsgYXMgdWx0aW1hdGVseSB3ZSAKY2FuJ3QgcmV0dXJuIGFuIGVycm9y
IHRvIHNvbWV0aGluZyB0aGF0IGRvZXNuJ3Qga25vdyBob3cgdG8gcmVxdWV1ZS9yZXRyeS4KClNo
b3VsZCB3ZSBhbHdheXMgYmUgcHV0dGluZyBldmVuIG5vbi1tcCBkZXZpY2VzIHVuZGVyIG1wLCB0
aHVzIG1wIApjYXRjaGVzIHRoZSBlcnJvcnMgcmF0aGVyIHRoYW4gdGhlIGJsayBxdWV1ZSwgYW5k
IGNhbiBoYXZlIGEgc2hvcnQgZGVsYXkgCndoaWxlIHRoZSBjb250cm9sbGVyIHJlY29ubmVjdHMg
P8KgIEF0IGxlYXN0IG5vcm1hbCBpbyBjYW4gYmUgaGFuZGxlZCAKdGhpcyB3YXkgYW5kIHdlJ2Qg
aGF2ZSB0byBmaWd1cmUgb3V0IHRoZSBpb2N0bCBwYXRoLsKgwqAgQnV0IGl0IHNob3VsZCAKc3Rp
bGwgYWxsb3cgdGhlIGNvcmUgaW8sIHN1Y2ggYXMgc2Nhbm5pbmcsIHRvIGdldCB0aGUgZXJyb3Ig
YW5kIGZhaWwgCm91dCwgdG8gYmUgcGlja2VkIHVwIGFmdGVyIHRoZSByZWNvbm5lY3QuCgotLSBq
YW1lcwoKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpM
aW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

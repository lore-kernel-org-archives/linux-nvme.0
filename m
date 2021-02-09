Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE33C433DB
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 07:22:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C6264E9D
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 07:22:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C6264E9D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Z5yhxssTd7ZOlTcbeG1ch0SHKfTll7Tr4FmB/HIeizo=; b=OSBK9VfQR4q4/oRCwBPd+ULB6
	09BAd2/5DW0KqVH862Ou0/iIqJtLRABB+FsESHSAi5nYzV2I9CLG2IFwUXz0q5D3E5OFKyatLEF4i
	Qu5k9LiCVQfMVJ0fHc7bn2zD4Y8YMgvEtp7mVlBgOFDncjmreuQKnZx4qBuJLw725rTbZFZndgbal
	MdT9q6Z4F/pMt+jGQ3l9e2LDgXnwkKUPFyeuNiWeQ6hJjtKHGHx3E2XNgaavWM2Lu+kQ4w2zGWjM1
	WLT/L2Ht45suZT+xV3OBn9Rj/Mn/Mx3Vu2BcJr1TBBUenvMTOaa7dqZP1fDsdBOWaaNWZYTfv7e1o
	ymdjLeDUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9NLY-0002Uk-EH; Tue, 09 Feb 2021 07:22:04 +0000
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9NLS-0002Tu-NN
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 07:21:59 +0000
Received: by mail-wr1-f52.google.com with SMTP id q7so20316216wre.13
 for <linux-nvme@lists.infradead.org>; Mon, 08 Feb 2021 23:21:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MxYCw3hPtJF0vZIIkMvuq8Yo/9cZaVPDXKoBV4pVGk0=;
 b=jse9Mjs1c0/agpXtS1odZHjs/W8jRplAVygufgJ//D1DpnXuE8ypKj/Lk5SGCPZMJj
 sVhy3N7ZrEBfGq5X39ZVluSsMo6kstv38xM11iRs+ihPdDssrY6Ey/DYjIJzYhqHH60X
 78kIBBpSDN1BPivkPeNjgeBYxkd/ZS2i6C0e3fe/EgtpI+IwK6MLIVcJcuP2cXSKNuHk
 qLWEZ0uwh0UTd7mXgTFIkRipIcRHsWH86O89kYyHSGpVn9kFY2ek845OI2c4A2mJgMnO
 g19Rx886lQ9XMPx1qc9qeS1S46u4GBQRTKz7I4NmSx5QBHD0DNueJFM/rdYS/zU7pHnT
 kreA==
X-Gm-Message-State: AOAM53030jBLOSDHneMccJ1zSwkFDkBfvgp4Wz4xpMhngNdIZ3LYeKZ4
 d1r2SwPx72sbRNRZ8UL90M8=
X-Google-Smtp-Source: ABdhPJzAp7FNFhLHypi4B5g/sGKp+khwawWBZL0q9njGM3FcTE936kUXB97BQRkd48eTvs9Kl3NaKg==
X-Received: by 2002:adf:80c3:: with SMTP id 61mr24181761wrl.100.1612855317448; 
 Mon, 08 Feb 2021 23:21:57 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:2121:4cf7:e6f6:2dc5?
 ([2601:647:4802:9070:2121:4cf7:e6f6:2dc5])
 by smtp.gmail.com with ESMTPSA id t2sm20696338wru.53.2021.02.08.23.21.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Feb 2021 23:21:56 -0800 (PST)
Subject: Re: kernel null pointer at nvme_tcp_init_iter+0x7d/0xd0 [nvme_tcp]
To: Ming Lei <ming.lei@redhat.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <e1d08160-ca49-91e2-dafc-3ee80516842d@grimberg.me>
 <5848858e-239d-acb2-fa24-c371a3360557@redhat.com>
 <af1d7e9d-0170-82f6-30e1-01f045d73fc7@grimberg.me>
 <6147d452-a12e-c76c-22f1-5d9e7cb6b01d@grimberg.me>
 <20210209042103.GB63798@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <1ea82025-44b8-ac3a-2039-35cb8d36dac2@grimberg.me>
Date: Mon, 8 Feb 2021 23:21:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210209042103.GB63798@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210209_022158_806308_BBB4E652 
X-CRM114-Status: GOOD (  26.24  )
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
Cc: axboe@kernel.dk, Rachel Sibley <rasibley@redhat.com>,
 Yi Zhang <yi.zhang@redhat.com>, Chaitanya.Kulkarni@wdc.com,
 linux-nvme@lists.infradead.org, linux-block <linux-block@vger.kernel.org>,
 CKI Project <cki-project@redhat.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyLzgvMjEgODoyMSBQTSwgTWluZyBMZWkgd3JvdGU6Cj4gT24gTW9uLCBGZWIgMDgsIDIw
MjEgYXQgMTA6NDI6MjhBTSAtMDgwMCwgU2FnaSBHcmltYmVyZyB3cm90ZToKPj4KPj4+PiBIaSBT
YWdpCj4+Pj4KPj4+PiBPbiAyLzgvMjEgNTo0NiBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPj4+
Pj4KPj4+Pj4+IEhlbGxvCj4+Pj4+Pgo+Pj4+Pj4gV2UgZm91bmQgdGhpcyBrZXJuZWwgTlVMTCBw
b2ludGVyIGlzc3VlIHdpdGggbGF0ZXN0Cj4+Pj4+PiBsaW51eC1ibG9jay9mb3ItbmV4dCBhbmQg
aXQncyAxMDAlIHJlcHJvZHVjZWQsIGxldCBtZSBrbm93Cj4+Pj4+PiBpZiB5b3UgbmVlZCBtb3Jl
IGluZm8vdGVzdGluZywgdGhhbmtzCj4+Pj4+Pgo+Pj4+Pj4gS2VybmVsIHJlcG86Cj4+Pj4+PiBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9heGJvZS9saW51
eC1ibG9jay5naXQKPj4+Pj4+IENvbW1pdDogMTFmOGI2ZmQwZGI5IC0gTWVyZ2UgYnJhbmNoICdm
b3ItNS4xMi9pb191cmluZycgaW50byBmb3ItbmV4dAo+Pj4+Pj4KPj4+Pj4+IFJlcHJvZHVjZXI6
IGJsa3Rlc3RzIG52bWUtdGNwLzAxMgo+Pj4+Pgo+Pj4+PiBUaGFua3MgZm9yIHJlcG9ydGluZyBN
aW5nLCBJJ3ZlIHRyaWVkIHRvIHJlcHJvZHVjZSB0aGlzIG9uIG15IFZNCj4+Pj4+IGJ1dCBkaWQg
bm90IHN1Y2NlZWQuIEdpdmVuIHRoYXQgeW91IGhhdmUgaXQgMTAwJSByZXByb2R1Y2libGUsCj4+
Pj4+IGNhbiB5b3UgdHJ5IHRvIHJldmVydCBjb21taXQ6Cj4+Pj4+Cj4+Pj4+IDBkYzllZGFmODBl
YSBudm1lLXRjcDogcGFzcyBtdWx0aXBhZ2UgYnZlYyB0byByZXF1ZXN0IGlvdl9pdGVyCj4+Pj4+
Cj4+Pj4KPj4+PiBSZXZlcnQgdGhpcyBjb21taXQgZml4ZWQgdGhlIGlzc3VlIGFuZCBJJ3ZlIGF0
dGFjaGVkIHRoZSBjb25maWcuIDopCj4+Pgo+Pj4gR29vZCB0byBrbm93LAo+Pj4KPj4+IEkgc2Vl
IHNvbWUgZGlmZmVyZW5jZXMgdGhhdCBJIHNob3VsZCBwcm9iYWJseSBjaGFuZ2UgdG8gaGl0IHRo
aXM6Cj4+PiAtLSAKPj4+IEBAIC0yNTQsMTQgKzI1NiwxNSBAQCBDT05GSUdfUEVSRl9FVkVOVFM9
eQo+Pj4gICDCoCMgZW5kIG9mIEtlcm5lbCBQZXJmb3JtYW5jZSBFdmVudHMgQW5kIENvdW50ZXJz
Cj4+Pgo+Pj4gICDCoENPTkZJR19WTV9FVkVOVF9DT1VOVEVSUz15Cj4+PiArQ09ORklHX1NMVUJf
REVCVUc9eQo+Pj4gICDCoCMgQ09ORklHX0NPTVBBVF9CUksgaXMgbm90IHNldAo+Pj4gLUNPTkZJ
R19TTEFCPXkKPj4+IC0jIENPTkZJR19TTFVCIGlzIG5vdCBzZXQKPj4+IC0jIENPTkZJR19TTE9C
IGlzIG5vdCBzZXQKPj4+IC1DT05GSUdfU0xBQl9NRVJHRV9ERUZBVUxUPXkKPj4+IC0jIENPTkZJ
R19TTEFCX0ZSRUVMSVNUX1JBTkRPTSBpcyBub3Qgc2V0Cj4+PiArIyBDT05GSUdfU0xBQiBpcyBu
b3Qgc2V0Cj4+PiArQ09ORklHX1NMVUI9eQo+Pj4gKyMgQ09ORklHX1NMQUJfTUVSR0VfREVGQVVM
VCBpcyBub3Qgc2V0Cj4+PiArQ09ORklHX1NMQUJfRlJFRUxJU1RfUkFORE9NPXkKPj4+ICAgwqAj
IENPTkZJR19TTEFCX0ZSRUVMSVNUX0hBUkRFTkVEIGlzIG5vdCBzZXQKPj4+IC0jIENPTkZJR19T
SFVGRkxFX1BBR0VfQUxMT0NBVE9SIGlzIG5vdCBzZXQKPj4+ICtDT05GSUdfU0hVRkZMRV9QQUdF
X0FMTE9DQVRPUj15Cj4+PiArQ09ORklHX1NMVUJfQ1BVX1BBUlRJQUw9eQo+Pj4gICDCoENPTkZJ
R19TWVNURU1fREFUQV9WRVJJRklDQVRJT049eQo+Pj4gICDCoENPTkZJR19QUk9GSUxJTkc9eQo+
Pj4gICDCoENPTkZJR19UUkFDRVBPSU5UUz15Cj4+PiBAQCAtMjk5LDcgKzMwMiw4IEBAIENPTkZJ
R19IQVZFX0lOVEVMX1RYVD15Cj4+PiAgIMKgQ09ORklHX1g4Nl82NF9TTVA9eQo+Pj4gICDCoENP
TkZJR19BUkNIX1NVUFBPUlRTX1VQUk9CRVM9eQo+Pj4gICDCoENPTkZJR19GSVhfRUFSTFlDT05f
TUVNPXkKPj4+IC1DT05GSUdfUEdUQUJMRV9MRVZFTFM9NAo+Pj4gK0NPTkZJR19EWU5BTUlDX1BI
WVNJQ0FMX01BU0s9eQo+Pj4gK0NPTkZJR19QR1RBQkxFX0xFVkVMUz01Cj4+PiAgIMKgQ09ORklH
X0NDX0hBU19TQU5FX1NUQUNLUFJPVEVDVE9SPXkKPj4+IC0tIAo+Pj4KPj4+IFByb2JhYmx5IENP
TkZJR19TTFVCIGFuZCBDT05GSUdfU0xVQl9ERUJVRyBzaG91bGQgYmUgdXNlZC4KPj4KPj4gVXNl
ZCB5b3VyIHByb2ZpbGUgYW5kIHRoaXMgc3RpbGwgZG9lcyBub3QgaGFwcGVuIDooCj4gCj4gT25l
IG9idmlvdXMgZXJyb3IgaXMgdGhhdCBucl9zZWdtZW50cyBpcyBjb21wdXRlZCB3cm9uZy4KPiAK
PiBZaSwgY2FuIHlvdSB0cnkgdGhlIGZvbGxvd2luZyBwYXRjaD8KPiAKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYwo+IGluZGV4
IDg4MWQyOGViMTVlOS4uYTM5M2Q5OWI3NGUxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS9o
b3N0L3RjcC5jCj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMKPiBAQCAtMjM5LDkgKzIz
OSwxNCBAQCBzdGF0aWMgdm9pZCBudm1lX3RjcF9pbml0X2l0ZXIoc3RydWN0IG52bWVfdGNwX3Jl
cXVlc3QgKnJlcSwKPiAgIAkJb2Zmc2V0ID0gMDsKPiAgIAl9IGVsc2Ugewo+ICAgCQlzdHJ1Y3Qg
YmlvICpiaW8gPSByZXEtPmN1cnJfYmlvOwo+ICsJCXN0cnVjdCBiaW9fdmVjIGJ2Owo+ICsJCXN0
cnVjdCBidmVjX2l0ZXIgaXRlcjsKPiArCj4gKwkJbnNlZ3MgPSAwOwo+ICsJCWJpb19mb3JfZWFj
aF9idmVjKGJ2LCBiaW8sIGl0ZXIpCj4gKwkJCW5zZWdzKys7Cj4gICAKPiAgIAkJdmVjID0gX19i
dmVjX2l0ZXJfYnZlYyhiaW8tPmJpX2lvX3ZlYywgYmlvLT5iaV9pdGVyKTsKPiAtCQluc2VncyA9
IGJpb19zZWdtZW50cyhiaW8pOwoKVGhpcyB3YXMgZXhhY3RseSB0aGUgcGF0Y2ggdGhhdCBjYXVz
ZWQgdGhlIGlzc3VlLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=

Return-Path: <SRS0=SbN/=7B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8C4C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 08:33:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D2B220709
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2020 08:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kNeh4vIo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D2B220709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DRAAwygSMYpClno0gjVmQG8YxLuDLMoeq8JmVgMAmOA=; b=kNeh4vIotsWUnSI2Yr97fPSSB
	HpUKEUJ63VHPaE4hs9F2I2+PZ4fmYbqmvLBAkJjKTGWMQnSHhcJjJkLSewXJGg6YLaKEB+8zqAE9h
	c6QX1eZ9AonjnWSwktWk1gOh04ELtPxHWm5Y/VgC/ZCFPwCfB1hIReO9bsCkF8gGMyahPMQX05vUR
	dxn3tPIYYDTE+VZR11JXvx1dI/osUGVdncq+ZQ1qf3+pPHewKeUTGUOjo+2+fYixsg3d2fohczSK6
	X9zHKFvqOzu58HUMfdvX69/4Oh9+1fRDtDcHVJXwCuvA1tiHZQvNYluV7TWE7ao+6geICrxHEe1Eg
	+O9R3b58Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jaxgh-00057m-5P; Tue, 19 May 2020 08:33:23 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jaxge-00057N-M9
 for linux-nvme@lists.infradead.org; Tue, 19 May 2020 08:33:22 +0000
Received: by mail-pg1-f196.google.com with SMTP id u5so6058775pgn.5
 for <linux-nvme@lists.infradead.org>; Tue, 19 May 2020 01:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=IfqpWSqHOgx4PxMC1SfhYqDcSNpYQQ8fZiNqvL5zB8w=;
 b=YGL2pxgI4Ds77FuCN7s0DPJLObYXoh5fS+F/wIQr6OaPts9F8a0TYGA1HESOV3yfx5
 A5AHSu9Js+RKOisNnLkm8XzIUFLNrZrSsa2ZbhvoutAnqZv80YIUZjm+g4eoLPXRMyKT
 TthXGg6u4t70JMmZ8+XedV5JxApuB9GiLBLhEoFmNaTROrHgZrrE7jWB6XJGhoJYxYhe
 Gcp/F1QDY4wKIsgSfG+luM5nbBSPznllM0B/HaBYy4nBT7YjU/NE18JQXKSQjYHthygC
 Y+d8wpDNsVzdXh80uHGFaE14Di/OQC6/DJiRkZJovrdewF7xtA8W2KJz3GJCqjFuBOPs
 eNJg==
X-Gm-Message-State: AOAM532UAyZzpwAWjc505BS8f42WHPu4EIJP7Imd33ZqhLgq8iowDuK0
 g9fCP9WdBcE9XHV/1glsjfM=
X-Google-Smtp-Source: ABdhPJxgOFnzq5tvLvlCnAhTsaQnl4B741vZXnYJ0LzLYWUwwF26ZQEVQTEfWOmYn67a00MBIyfDAg==
X-Received: by 2002:aa7:83c5:: with SMTP id j5mr17532832pfn.141.1589877199471; 
 Tue, 19 May 2020 01:33:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:507e:6065:a37d:f691?
 ([2601:647:4802:9070:507e:6065:a37d:f691])
 by smtp.gmail.com with ESMTPSA id y5sm1556442pjp.27.2020.05.19.01.33.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 01:33:18 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] nvmet: avoid memleak by freeing any remaining aens
 in nvmet_async_events_free
To: David Milburn <dmilburn@redhat.com>, linux-nvme@lists.infradead.org
References: <1589828396-144513-1-git-send-email-dmilburn@redhat.com>
 <1589828396-144513-3-git-send-email-dmilburn@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <388242d3-5ccc-d694-c7a0-ac489f63f26a@grimberg.me>
Date: Tue, 19 May 2020 01:33:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589828396-144513-3-git-send-email-dmilburn@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200519_013320_722634_B6B8BEB0 
X-CRM114-Status: GOOD (  22.43  )
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
Cc: hch@infradead.org, dwagner@suse.de, chaitanya.kulkarni@wdc.com
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA1LzE4LzIwIDExOjU5IEFNLCBEYXZpZCBNaWxidXJuIHdyb3RlOgo+IE1ha2Ugc3VyZSB3
ZSBmcmVlIGFsbCByZXNvdXJjZXMgaW5jbHVkaW5nIGFueSByZW1haW5pbmcgYWVucwo+IHdoaWNo
IG1heSByZXN1bHQgaW4gYSBtZW1vcnkgbGVhay4KPgo+ICQgY2F0IC9zeXMva2VybmVsL2RlYnVn
L2ttZW1sZWFrCj4gdW5yZWZlcmVuY2VkIG9iamVjdCAweGZmZmY4ODhjMWFmMmMwMDAgKHNpemUg
MzIpOgo+ICAgIGNvbW0gIm52bWV0Y2xpIiwgcGlkIDUxNjQsIGppZmZpZXMgNDI5NTIyMDg2NCAo
YWdlIDY4MjkuOTI0cykKPiAgICBoZXggZHVtcCAoZmlyc3QgMzIgYnl0ZXMpOgo+ICAgICAgMjgg
MDEgODIgM2IgOGIgODggZmYgZmYgMjggMDEgODIgM2IgOGIgODggZmYgZmYgICguLjsuLi4uKC4u
Oy4uLi4KPiAgICAgIDAyIDAwIDA0IDY1IDc2IDY1IDZlIDc0IDVmIDY2IDY5IDZjIDY1IDAwIDAw
IDAwICAuLi5ldmVudF9maWxlLi4uCj4gICAgYmFja3RyYWNlOgo+ICAgICAgWzwwMDAwMDAwMDIx
N2FlNTgwPl0gbnZtZXRfYWRkX2FzeW5jX2V2ZW50KzB4NTcvMHgyOTAgW252bWV0XQo+ICAgICAg
WzwwMDAwMDAwMDEyYWEyZWE5Pl0gbnZtZXRfbnNfY2hhbmdlZCsweDIwNi8weDMwMCBbbnZtZXRd
Cj4gICAgICBbPDAwMDAwMDAwYmIzZmQ1MmU+XSBudm1ldF9uc19kaXNhYmxlKzB4MzY3LzB4NGYw
IFtudm1ldF0KPiAgICAgIFs8MDAwMDAwMDBlOTFjYTllYz5dIG52bWV0X25zX2ZyZWUrMHgxNS8w
eDE4MCBbbnZtZXRdCj4gICAgICBbPDAwMDAwMDAwYTE1ZGViNTI+XSBjb25maWdfaXRlbV9yZWxl
YXNlKzB4ZjEvMHgxYzAKPiAgICAgIFs8MDAwMDAwMDA3ZTE0ODQzMj5dIGNvbmZpZ2ZzX3JtZGly
KzB4NTU1LzB4N2MwCj4gICAgICBbPDAwMDAwMDAwZjQ1MDZlYTY+XSB2ZnNfcm1kaXIrMHgxNDIv
MHgzYzAKPiAgICAgIFs8MDAwMDAwMDAwMGFjYWFmMD5dIGRvX3JtZGlyKzB4MmIyLzB4MzQwCj4g
ICAgICBbPDAwMDAwMDAwMzRkMWFhNTI+XSBkb19zeXNjYWxsXzY0KzB4YTUvMHg0ZDAKPiAgICAg
IFs8MDAwMDAwMDAyMTFmMTNiYz5dIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDZh
LzB4ZGYKPgo+IFN0ZXBzIHRvIFJlcHJvZHVjZToKPgo+IHRhcmdldDoKPiAxLiBudm1ldGNsaSBy
ZXN0b3JlIHJkbWEuanNvbgo+Cj4gY2xpZW50Ogo+IDIuIG52bWUgY29ubmVjdCAtdCByZG1hIC1h
ICRJUCAtcyA0NDIwIC1uIHRlc3RucW4KPgo+IHRhcmdldDoKPiAzLiBudm1ldGNsaSBjbGVhcgo+
IDQuIHNsZWVwIDUgJiYgbnZtZXRjbGkgcmVzdG9yZSByZG1hLmpzb24KPiA1LiBjYXQgL3N5cy9r
ZXJuZWwvZGVidWcva21lbWxlYWsgYWZ0ZXIgNSBtaW51dGVzCj4KPiBSZXBvcnRlZC1ieTogWWkg
WmhhbmcgPHlpLnpoYW5nQHJlZGhhdC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTWlsYnVy
biA8ZG1pbGJ1cm5AcmVkaGF0Y29tPgo+IC0tLQo+IENoYW5nZXMgZnJvbSB2MToKPiAgIC0gZGVj
bGFyZSBzdHJ1Y3QgbnZtZXRfYXN5bmNfZXZlbnQgaW4gdGhpcyBwYXRjaC4KPgo+ICAgZHJpdmVy
cy9udm1lL3RhcmdldC9jb3JlLmMgfCA4ICsrKysrKysrCj4gICAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMg
Yi9kcml2ZXJzL252bWUvdGFyZ2V0L2NvcmUuYwo+IGluZGV4IGRjMDM2YTgxNWQzOS4uZGRhODg4
NjcyZjMxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jCj4gKysrIGIv
ZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMKPiBAQCAtMTU0LDYgKzE1NCw3IEBAIHN0YXRpYyB2
b2lkIG52bWV0X2FzeW5jX2V2ZW50c19wcm9jZXNzKHN0cnVjdCBudm1ldF9jdHJsICpjdHJsLCB1
MTYgc3RhdHVzKQo+ICAgCj4gICBzdGF0aWMgdm9pZCBudm1ldF9hc3luY19ldmVudHNfZnJlZShz
dHJ1Y3QgbnZtZXRfY3RybCAqY3RybCkKPiAgIHsKPiArCXN0cnVjdCBudm1ldF9hc3luY19ldmVu
dCAqYWVuOwo+ICAgCXN0cnVjdCBudm1ldF9yZXEgKnJlcTsKPiAgIAo+ICAgCW11dGV4X2xvY2so
JmN0cmwtPmxvY2spOwo+IEBAIC0xNjMsNiArMTY0LDEzIEBAIHN0YXRpYyB2b2lkIG52bWV0X2Fz
eW5jX2V2ZW50c19mcmVlKHN0cnVjdCBudm1ldF9jdHJsICpjdHJsKQo+ICAgCQludm1ldF9yZXFf
Y29tcGxldGUocmVxLCBOVk1FX1NDX0lOVEVSTkFMIHwgTlZNRV9TQ19ETlIpOwo+ICAgCQltdXRl
eF9sb2NrKCZjdHJsLT5sb2NrKTsKPiAgIAl9Cj4gKwo+ICsJd2hpbGUgKCFsaXN0X2VtcHR5KCZj
dHJsLT5hc3luY19ldmVudHMpKSB7Cj4gKwkJYWVuID0gbGlzdF9maXJzdF9lbnRyeSgmY3RybC0+
YXN5bmNfZXZlbnRzLAo+ICsJCQkJICAgICAgIHN0cnVjdCBudm1ldF9hc3luY19ldmVudCwgZW50
cnkpOwo+ICsJCWxpc3RfZGVsKCZhZW4tPmVudHJ5KTsKPiArCQlrZnJlZShhZW4pOwo+ICsJfQo+
ICAgCW11dGV4X3VubG9jaygmY3RybC0+bG9jayk7Cj4gICB9Cj4gICAKClNvbWV0aGluZyBoZXJl
IGxvb2tzIHdyb25nIHRvIG1lLi4uIFRoZXJlIGlzIG5vIHJlYXNvbiB0byBmcmVlIGFlbnMgaGVy
ZS4uLgoKQWxzbywgc2VlaW5nIHByaW9yIGRpc2N1c3Npb24gb24gdGhpcyBwYXRjaAp3ZSBkb24n
dCBhY3R1YWxseSB0YWtlIGFueXRoaW5nIGZyb20gdGhlIGxpc3QgaWYgd2UgZG9uJ3QgaGF2ZSBh
biAKYXZhaWxhYmxlIHNsb3QsIHNvIEkKZG9uJ3Qgc2VlIGhvdyBwYXRjaCAjMSBoZWxwcyBhbnl0
aGluZy4uLgoKRGlkIHlvdSBhbmFseXplIHRoZSByb290IGNhdXNlIG9mIHRoZSBpc3N1ZT8gSXQn
cyBub3QgY2xlYXIgd2hhdCBpcyB0aGUgCnJvb3QgY2F1c2UKaGVyZS4uCgpMb29raW5nIGF0IHRo
ZSBjb2RlLCBudm1ldF9hc3luY19ldmVudHNfZnJlZSB3aGljaCBpcyBkZXNpZ25lZCB0byBmcmVl
IAphbGwgdGhlCnBlbmRpbmcgYWVucyB0aGF0IGFyZSBub3QgZ29pbmcgdG8gYmUgc2VudCBhbnl3
aGVyZSwgaXMgbm90IGZyZWVpbmcgCmFueXRoaW5nLi4uCkl0cyBhbHNvIG5vdCBjbGVhciB0byBt
ZSBmcm9tIHRoZSBjb2RlIGhvdyBjYW4gY3RybC0+YXN5bmNfZXZlbnRzIGxpc3QgYW5kCmN0cmwt
Pm5yX2FzeW5jX2V2ZW50X2NtZHMgYXJlIG5vdCBjb3JyZWxhdGVkLi4uCgpEb2VzIHRoaXMgcGF0
Y2ggc29sdmUgeW91ciBpc3N1ZT8KLS0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS90YXJnZXQv
Y29yZS5jIGIvZHJpdmVycy9udm1lL3RhcmdldC9jb3JlLmMKaW5kZXggYjY4NWY5OWQ1NmExLi4x
OTBkMzZjZWRhNDcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jCisrKyBi
L2RyaXZlcnMvbnZtZS90YXJnZXQvY29yZS5jCkBAIC0xNTcsMTAgKzE1NywxNSBAQCBzdGF0aWMg
dm9pZCBudm1ldF9hc3luY19ldmVudHNfcHJvY2VzcyhzdHJ1Y3QgCm52bWV0X2N0cmwgKmN0cmws
IHUxNiBzdGF0dXMpCgogwqBzdGF0aWMgdm9pZCBudm1ldF9hc3luY19ldmVudHNfZnJlZShzdHJ1
Y3QgbnZtZXRfY3RybCAqY3RybCkKIMKgeworwqDCoMKgwqDCoMKgIHN0cnVjdCBudm1ldF9hc3lu
Y19ldmVudCAqYWVuOwogwqDCoMKgwqDCoMKgwqAgc3RydWN0IG52bWV0X3JlcSAqcmVxOwoKIMKg
wqDCoMKgwqDCoMKgIG11dGV4X2xvY2soJmN0cmwtPmxvY2spOwogwqDCoMKgwqDCoMKgwqAgd2hp
bGUgKGN0cmwtPm5yX2FzeW5jX2V2ZW50X2NtZHMpIHsKK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgYWVuID0gbGlzdF9maXJzdF9lbnRyeSgmY3RybC0+YXN5bmNfZXZlbnRzLAorwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0
cnVjdCBudm1ldF9hc3luY19ldmVudCwgZW50cnkpOworwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBsaXN0X2RlbCgmYWVuLT5lbnRyeSk7CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGtmcmVlKGFlbik7CiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVxID0gY3RybC0+
YXN5bmNfZXZlbnRfY21kc1stLWN0cmwtPm5yX2FzeW5jX2V2ZW50X2NtZHNdOwogwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIG11dGV4X3VubG9jaygmY3RybC0+bG9jayk7CiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZXRfcmVxX2NvbXBsZXRlKHJlcSwgTlZNRV9TQ19J
TlRFUk5BTCB8IE5WTUVfU0NfRE5SKTsKLS0KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK

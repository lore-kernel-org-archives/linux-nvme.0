Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36278C48BDF
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 01:44:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C54D66112D
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 01:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C54D66112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BzSmprKBHnHotTyQ3CMl32b26nC6hZoE7y9R3kNhqfA=; b=OxeRGOsRW83R5t
	bzplaeMLjKM/XqVbQIMmfzMAWJ0bSn04+dAyIdkfTcneYB+WPlVm+b7HiU1f+Dv2ZqYopdOgCQ4+L
	gQBQhmqzqsjK7NnzMhb1t14JlTVb3l4NSkzUQ4TNzhG47JO2Wb3AlAMCpxf0Q8KDoaH23KG6t4xNe
	yp95Y8j8gdA0gtfaWeQ0ZmBD4/tduKfDWSQwD5+hvF8tHamjf7NoS3AgwEYWG65zDhuMdKRt4MDxU
	Q6HLbCDaOyV0MNmI46k53hlNbhS3g0TWGth6jbtwwcCJOUjPPJ3tUw18bHQV14q46FaKzuGHXGafc
	i0AU50sW92nmbSaHbcxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lv8zK-001rDI-Gw; Mon, 21 Jun 2021 01:44:34 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lv8zH-001rCx-Uo
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 01:44:33 +0000
Received: by mail-wm1-x32d.google.com with SMTP id
 p8-20020a7bcc880000b02901dbb595a9f1so2797776wma.2
 for <linux-nvme@lists.infradead.org>; Sun, 20 Jun 2021 18:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FPjpjKN3ly48bJqJ4j4sPEHhJ4Ot0dBHNK//zvLnjQ4=;
 b=k3j1Im1gKugzvZu78RwWOAUSlQGqJZq/hMWToQ1EBWitZuQSQBhnlV2IDqoVMz7wbj
 CFSntx/pasC2hajytlmMECzZZalEdOIhcdgBaUQ6E77gEjsDsqOC8deKM3PTc6epkGbM
 qa/96EWPf80PSASEsxgEjExevnC0PZjxQzDK8ecqaXbUUR2W2vBQUWt24t00kdwipxk1
 plUSWd3IqEtZaKl++InWSV7sM+6i5GclW2MunJ2/wGaNQf0SO6V3cWXzkb+cTQ82BN2C
 26jv/u/5PLiFvHYIEMORvPyBy+sCQoTGGBVb+OmfxO351b9KRNWfy6e7IHzK0gZOJuee
 PiIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FPjpjKN3ly48bJqJ4j4sPEHhJ4Ot0dBHNK//zvLnjQ4=;
 b=dOHe05eUyrVklgXf73791kY2T1g8HNQroQGNCAjRGo/Fh3Zo2uSO9CmDHa59bDVOY+
 JQZ1x3B2kDdzeowqr3Yp1+HM7SRudP/JJF3Bgd9MHpbSKlhtY9ALqaT1eAM8yAhv4e4h
 sZhSQNy8xqDKebvV69psQyE/rFPqlvyRMFR9lHBPTAH1/ldJshOUe71r2/VpCz/4CuD8
 h1NgJRMVBnnv3aZ/sxrAETHN1vG57DrHb50qyZ884tuULuayY86NTuWNSytnT2oHDN0z
 sRogNs9lxoVcAdjAv9Z51wvrrY/XJ7D5WUuH6aG+08gkdtZ/VqTMLyJIkxM5thli3pRY
 D5AA==
X-Gm-Message-State: AOAM531B5/2ImPdnK2F7n19fnQcAmh3OZwCRACSnK4HyRSZTE/+6AGWo
 Z2VBxFHg1wv03SI+fNZaeQXvWf/Qs+KK8JLJFRc=
X-Google-Smtp-Source: ABdhPJzKQYo6PKbhr9Uvjy0E+6shT96fRHe/chQbDyhnZcWO6zsPjflQsugswCYzSHmTCZ4IdPSCXIY5heIFxD7eVbg=
X-Received: by 2002:a7b:c8c1:: with SMTP id f1mr6166974wml.90.1624239867724;
 Sun, 20 Jun 2021 18:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210618133956.10637-1-pkushwaha@marvell.com>
 <20210618134244.GA16005@lst.de>
 <78d5833d-2038-811c-f6a4-2f14a3996fc5@grimberg.me>
In-Reply-To: <78d5833d-2038-811c-f6a4-2f14a3996fc5@grimberg.me>
From: Prabhakar Kushwaha <prabhakar.pkin@gmail.com>
Date: Mon, 21 Jun 2021 07:13:51 +0530
Message-ID: <CAJ2QiJLWh3_gWf8Bx8c201hGzVGcqfEhT-J_OLD=2740w1+Qsw@mail.gmail.com>
Subject: Re: [PATCH] nvme-tcp: Use __dev_get_by_name instead dev_get_by_name
 for OPT_HOST_IFACE
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Prabhakar Kushwaha <pkushwaha@marvell.com>,
 linux-nvme@lists.infradead.org, 
 kbusch@kernel.org, axboe@fb.com, martin.belanger@dell.com, aelior@marvell.com, 
 Omkar Kulkarni <okulkarni@marvell.com>, Shai Malin <smalin@marvell.com>,
 malin1024@gmail.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210620_184432_057852_BE43AA5D 
X-CRM114-Status: GOOD (  22.38  )
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

T24gU2F0LCBKdW4gMTksIDIwMjEgYXQgMTI6NDQgQU0gU2FnaSBHcmltYmVyZyA8c2FnaUBncmlt
YmVyZy5tZT4gd3JvdGU6Cj4KPgo+ID4+IGRldl9nZXRfYnlfbmFtZSgpIGZpbmRzIG5ldHdvcmsg
ZGV2aWNlIGJ5IG5hbWUgYnV0IGl0IGFsc28gaW5jcmVhc2VzCj4gPj4gcmVmZXJlbmNlIGNvdW50
Lgo+ID4+IEluY3JlYXNpbmcgdGhlIHJlZiBjb3VudCwKPiA+PiBJZiBudm1lLXRjcCBxdWV1ZSBp
cyBwcmVzZW50IGFuZCB0aGUgbmV0d29yayBkZXZpY2UgZHJpdmVyIGlzIHJlbW92ZWQKPiA+PiBi
ZWZvcmUgbnZtZV90Y3AsIHdlIHdpbGwgZmFjZSB0aGUgZm9sbG93aW5nIGNvbnRpbnVvdXMgbG9n
Ogo+ID4+ICAgICJrZXJuZWw6dW5yZWdpc3Rlcl9uZXRkZXZpY2U6IHdhaXRpbmcgZm9yIDxldGg+
IHRvIGJlY29tZQo+ID4+ICAgIGZyZWUuIFVzYWdlIGNvdW50ID0gMiIKPiA+PiBBbmQgcm1tb2Qg
ZnVydGhlciBoYWx0cy4gU2ltaWxhciBjYXNlIGFyaXNlcyBkdXJpbmcgcmVib290L3NodXRkb3du
Cj4gPj4gd2l0aCBudm1lLXRjcCBxdWV1ZSBwcmVzZW50IGFuZCBib3RoIG5ldmVyIGNvbXBsZXRl
cy4KPiA+Pgo+ID4+IEFzIGEgZml4IHdlIHdpbGwgdXNlIF9fZGV2X2dldF9ieV9uYW1lKCkgd2hp
Y2ggZmluZCBuZXR3b3JrIGRldmljZSBieQo+ID4+IG5hbWUgd2l0aG91dCBpbmNyZWFzaW5nIGFu
eSByZWZlcmVuY2UgY291bnRlci4KPiA+Cj4gPiBBbmQgd2hlbiB5b3UgcmVtb3ZlIGl0IHdpdGhv
dXQgdGhlIHJlZmNvdW50IHdlJ2xsIG5vdyBoYXZlIGEgc3RhbGUKPiA+IGtlcm5lbCBwb2ludGVy
Pwo+Cj4gVGhlIG5ldGRldiBpcyBub3QgYWN0dWFsbHkgbmVlZGVkLCBpdHMgdG8gbWFrZSBzdXJl
IHRoYXQgaXQgZXhpc3QgYXMKPiByZWZlcmVuY2UgaW4gdGhlIGhvc3RfaWZhY2UgYWZhaWN0ICh0
aGUgbmV0ZGV2IGlzIG5ldmVyIHJlZmVyZW5jZWQKPiBhZnRlcndhcmRzKSwgYW5kIEknbSBwcmV0
dHkgc3VyZSB0aGVyZSB3YXMgYSBtYXRjaGluZyBwdXQgc29tZXdoZXJlIGluCj4gdGhlIGZvcm1l
ciB2ZXJzaW9ucyBvZiB0aGlzIHBhdGNoLgoKUGF0Y2ggM2VkZThmNzJhOWEyICjigJxudm1lLXRj
cDogYWxsb3cgc2VsZWN0aW5nIHRoZSBuZXR3b3JrIGludGVyZmFjZSBmb3IKY29ubmVjdGlvbnMi
KSBleHBvc2VkIHRvIHRoaXMgcHJvYmxlbSBpbiB0aGUgZm9sbG93aW5nIGNhc2VzOgpBKSAgY3Jl
YXRlIG52bWUtdGNwIHF1ZXVlLCBkaXNjb25uZWN0IHF1ZXVlIGFuZCByZW1vdmUgbmV0d29yayBk
cml2ZXIKQikgIGNyZWF0ZSBudm1lLXRjcCBxdWV1ZSBhbmQgcmVtb3ZlIG5ldHdvcmsgZHJpdmVy
CgrigJxB4oCdIGNhbiBiZSBzb2x2ZWQgYnkgcHV0dGluZyBkZXZfcHV0KCkgYmVmb3JlIGtmcmVl
KGN0cmwpOgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMgYi9kcml2ZXJzL252
bWUvaG9zdC90Y3AuYwppbmRleCBjN2JkMzcxMDNjZjQuLjkzNjM5YjViNzk1ZiAxMDA2NDQKLS0t
IGEvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvdGNwLmMK
QEAgLTIxNTUsNiArMjE1NSw4IEBAIHN0YXRpYyB2b2lkIG52bWVfdGNwX2ZyZWVfY3RybChzdHJ1
Y3QgbnZtZV9jdHJsICpuY3RybCkKICAgICAgICBudm1mX2ZyZWVfb3B0aW9ucyhuY3RybC0+b3B0
cyk7CmZyZWVfY3RybDoKICAgICAgICBrZnJlZShjdHJsLT5xdWV1ZXMpOworICAgICAgIGlmIChj
dHJsLT5uZGV2KQorICAgICAgICAgICAgICAgZGV2X3B1dChjdHJsLT5uZGV2KTsKICAgICAgICBr
ZnJlZShjdHJsKTsKfQoKQEAgLTI1ODYsNiArMjU4OCw4IEBAIHN0YXRpYyBzdHJ1Y3QgbnZtZV9j
dHJsCipudm1lX3RjcF9jcmVhdGVfY3RybChzdHJ1Y3QgZGV2aWNlICpkZXYsCm91dF9rZnJlZV9x
dWV1ZXM6CiAgICAgICAga2ZyZWUoY3RybC0+cXVldWVzKTsKb3V0X2ZyZWVfY3RybDoKKyAgICAg
ICBpZiAoY3RybC0+bmRldikKKyAgICAgICAgICAgICAgIGRldl9wdXQoY3RybC0+bmRldik7CiAg
ICAgICAga2ZyZWUoY3RybCk7CiAgICAgICAgcmV0dXJuIEVSUl9QVFIocmV0KTsKfQoKQnV0IGV2
ZW4gdXNpbmcgZGV2X3B1dCgpIHdpbGwgbm90IHNvbHZlIOKAnELigJ0gaW4gY2FzZSBvZiB0aGUg
cmVtb3ZhbCBvZgp0aGUgbmV0d29yawpkcml2ZXIgYmVmb3JlIG52bWUtdGNwLgoKVGhpcyB3YXMg
b3VyIGluaXRpYWwgbW90aXZhdGlvbiBmb3IgdXNpbmcgIF9fZGV2X2dldF9ieV9uYW1lKCkuCkl0
IHdpbGwgc29sdmUgYm90aCDigJxB4oCdIGFuZCDigJxC4oCdIGFuZCBpdCB3aWxsIGJlaGF2ZSB0
aGUgc2FtZSB3aXRoIG9yIHdpdGhvdXQgdGhlCnVzYWdlIG9mIHRoZSBPUFRfSE9TVF9JRkFDRSBv
cHRpb24uCmkuZS4gSWYgd2UgcmVtb3ZlIHRoZSBuZXR3b3JrIGRyaXZlciB3aGlsZSBjb250cm9s
bGVycyBhcmUgY29ubmVjdGVkIGl0IHdpbGwKZW5kIHdpdGggbnZtZSB0aW1lb3V0cy4KCi0tcGsK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

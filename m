Return-Path: <SRS0=Ubpo=JH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D5AC433ED
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 06:33:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84000610D1
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 06:33:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84000610D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:In-Reply-To:Cc:References:Message-Id:Date:Subject
	:Mime-Version:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=618iebyIL5duA8csBcL2TifM9kPkRQJPGshCBjuONZo=; b=B3xc7dGY+eT5CquH30gmvHNgD
	HvCrva2idAxCdFDqFQXrkTutuIezFmrNTDbxV1Yd9FiKfgAy4R8R09Ajk4kG7NVjAlzH0wOpmMxEQ
	ZdDXgVweROExrtwjRavILCyhf77v74QWjGBmJerrmKZfzj8+l6I3T21KfGVMIV/hxvDxvAihCoDAA
	c3U8CvhiLpdDfsBCmcVpxD0O7xRhYUeuCOSIJxukCuHSW74XTuQKCYTVp1ClVkI9oYhZh38rXD4K8
	CUsIO2gLLRQdW7ZBhO+flYkCgR4Kk+zyAgF3kym5sfuOWZiPdQqhJ0rzeRmGCzLgJz4T71LPpUAUD
	HYr/Tv03w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lV7B7-002IIQ-Gm; Sat, 10 Apr 2021 06:33:09 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lV7B2-002IHH-Iv
 for linux-nvme@desiato.infradead.org; Sat, 10 Apr 2021 06:33:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=To:In-Reply-To:Cc:References:
 Message-Id:Date:Subject:Mime-Version:From:Content-Transfer-Encoding:
 Content-Type:Sender:Reply-To:Content-ID:Content-Description;
 bh=QmBA/khm9QQj8QSTpq8GUmMDxfR3EYkN2ltUuGJAbWQ=; b=lloXnWlXxgdZMLog+ffaDmfPN3
 RbPYA5SE7SHj3VN7S9utNQXXFIxCd2CwOLvxhXLBqq6STeevXTzcvnYC39bdrX6ZAxP7AgfxKoknx
 jyfyeKZaoLtIqevcR9z+00AZTWjgd+iU7ZFz0fw9xdEIk9ZmKGVGHIiV2nMeuRTQETu3UY6jSSIP+
 Iy2xjUA1hSzNmSGxDbpOlK+A08YRMEK2bWDndVkkNVfumgPHWNT6L7KeZbDJPVKZrJr2s87tYtHVA
 VUGaXoaSsUck6GNaI6TBgdADRXP4d8vncBfvR7PsP/MGj4Msx/ftZnDuvwVpo0CzWYDKwCBN7+BMy
 pPC+nBwQ==;
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lV7Az-004xZF-CS
 for linux-nvme@lists.infradead.org; Sat, 10 Apr 2021 06:33:03 +0000
Received: by mail-ej1-x62f.google.com with SMTP id hq27so11931518ejc.9
 for <linux-nvme@lists.infradead.org>; Fri, 09 Apr 2021 23:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=QmBA/khm9QQj8QSTpq8GUmMDxfR3EYkN2ltUuGJAbWQ=;
 b=sYihbTj0ySH56E1/o08bUwUHP6PyMBpmkgNghaJfVEKAxJr6SwXUAXRRgAbBC/Bzs6
 XCmi+fNGzSELeEOU9OyM5gKWSCuhiaTBo8xg5JOR1Xx5YhMEyV5UoZRlzGvOCBFxfdnb
 Y4XuBjJrymTHqG4Q9c4L/6mmF0Y28mUwbQA1Pievd7aBVzSEiSirgpM/5BDL+f3GB6hH
 akcyRLY3HEflOUB++qOGJgYxTP9/zppRBr6LWHBQooOIim3A4sdddrOCduKHbzLbGxCf
 Y8xxy+DyzLOE1m84KcHyUnaOjgn3AqxfX4rVJEXqpze20A3tB7uDXjDBDbGYmlx2eivb
 nPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=QmBA/khm9QQj8QSTpq8GUmMDxfR3EYkN2ltUuGJAbWQ=;
 b=aDYQUrzyK6ImTpHU5s2ucXARPtm9LvDxTbv+5AP/Dv5FvBw7g9z99x9VMG99kFcKGm
 abWLWRj1UkEsMZmaz5SrwQRn2euqhDiMFi29CvwTxywBoxpu5kTwPsil1vf+Z6G20l45
 jW+Q1+E83V848Mk6VoaHD/QFHUU2em49Of/2AEAArIhMNzti2z9PKvXpTq3/S09mjRdM
 9+f34tJBXk4optZW5QVOiGbz3kqtcBKTbbn+4Jybbl7hxMLnnXdO7oC0bKryGkFYyrBo
 zfm+cLWZDXfg/iyMqC/IkrH/a5cbxqyV+el9YS7V0NElpMgue+urdgARGZQQ44z/LCyd
 8lNw==
X-Gm-Message-State: AOAM533S7AOlfDUwIYZnTyaVQUsBiTQOKTe5uAV60jRGt+Ds2B9mr7rF
 hz6jz4Q3kyCsaJKBRVcFrE0ZSw==
X-Google-Smtp-Source: ABdhPJwG75/xQdAUY5SZ7i9s/RKcSTINm5eq6NN0AZ16BVTCynQFcgZwYqtZ3G/MLDxy4IQWenOqbw==
X-Received: by 2002:a17:906:1d0e:: with SMTP id
 n14mr19377458ejh.97.1618036378037; 
 Fri, 09 Apr 2021 23:32:58 -0700 (PDT)
Received: from [192.168.10.20] (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id ck29sm2558898edb.47.2021.04.09.23.32.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Apr 2021 23:32:57 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v5 0/4] add simple copy support
Date: Sat, 10 Apr 2021 08:32:56 +0200
Message-Id: <5BE5E1D9-675F-4122-A845-B0A29BB74447@javigon.com>
References: <BYAPR04MB49652982D00724001AE758C986729@BYAPR04MB4965.namprd04.prod.outlook.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
 SelvaKumar S <selvakuma.s1@samsung.com>, linux-nvme@lists.infradead.org,
 axboe@kernel.dk, Damien Le Moal <damien.lemoal@wdc.com>, kch@kernel.org,
 sagi@grimberg.me, snitzer@redhat.com, selvajove@gmail.com,
 linux-kernel@vger.kernel.org, nj.shetty@samsung.com,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@redhat.com, joshi.k@samsung.com, javier.gonz@samsung.com,
 kbusch@kernel.org, joshiiitr@gmail.com, hch@lst.de
In-Reply-To: <BYAPR04MB49652982D00724001AE758C986729@BYAPR04MB4965.namprd04.prod.outlook.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
X-Mailer: iPhone Mail (18D70)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210409_233301_484233_AC6F96F4 
X-CRM114-Status: GOOD (  16.25  )
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

Cj4gT24gMTAgQXByIDIwMjEsIGF0IDAyLjMwLCBDaGFpdGFueWEgS3Vsa2FybmkgPENoYWl0YW55
YS5LdWxrYXJuaUB3ZGMuY29tPiB3cm90ZToKPiAKPiDvu79PbiA0LzkvMjEgMTc6MjIsIE1heCBH
dXJ0b3ZveSB3cm90ZToKPj4+IE9uIDIvMTkvMjAyMSAyOjQ1IFBNLCBTZWx2YUt1bWFyIFMgd3Jv
dGU6Cj4+PiBUaGlzIHBhdGNoc2V0IHRyaWVzIHRvIGFkZCBzdXBwb3J0IGZvciBUUDQwNjVhICgi
U2ltcGxlIENvcHkgQ29tbWFuZCIpLAo+Pj4gdjIwMjAuMDUuMDQgKCJSYXRpZmllZCIpCj4+PiAK
Pj4+IFRoZSBTcGVjaWZpY2F0aW9uIGNhbiBiZSBmb3VuZCBpbiBmb2xsb3dpbmcgbGluay4KPj4+
IGh0dHBzOi8vbnZtZXhwcmVzcy5vcmcvd3AtY29udGVudC91cGxvYWRzL05WTS1FeHByZXNzLTEu
NC1SYXRpZmllZC1UUHMtMS56aXAKPj4+IAo+Pj4gU2ltcGxlIGNvcHkgY29tbWFuZCBpcyBhIGNv
cHkgb2ZmbG9hZGluZyBvcGVyYXRpb24gYW5kIGlzICB1c2VkIHRvIGNvcHkKPj4+IG11bHRpcGxl
IGNvbnRpZ3VvdXMgcmFuZ2VzIChzb3VyY2VfcmFuZ2VzKSBvZiBMQkEncyB0byBhIHNpbmdsZSBk
ZXN0aW5hdGlvbgo+Pj4gTEJBIHdpdGhpbiB0aGUgZGV2aWNlIHJlZHVjaW5nIHRyYWZmaWMgYmV0
d2VlbiBob3N0IGFuZCBkZXZpY2UuCj4+PiAKPj4+IFRoaXMgaW1wbGVtZW50YXRpb24gZG9lc24n
dCBhZGQgbmF0aXZlIGNvcHkgb2ZmbG9hZCBzdXBwb3J0IGZvciBzdGFja2VkCj4+PiBkZXZpY2Vz
IHJhdGhlciBjb3B5IG9mZmxvYWQgaXMgZG9uZSB0aHJvdWdoIGVtdWxhdGlvbi4gUG9zc2libGUg
dXNlCj4+PiBjYXNlcyBhcmUgRjJGUyBnYyBhbmQgQlRSRlMgcmVsb2NhdGlvbi9iYWxhbmNlLgo+
Pj4gCj4+PiAqYmxrZGV2X2lzc3VlX2NvcHkqIHRha2VzIHNvdXJjZSBiZGV2LCBubyBvZiBzb3Vy
Y2VzLCBhcnJheSBvZiBzb3VyY2UKPj4+IHJhbmdlcyAoaW4gc2VjdG9ycyksIGRlc3RpbmF0aW9u
IGJkZXYgYW5kIGRlc3RpbmF0aW9uIG9mZnNldChpbiBzZWN0b3JzKS4KPj4+IElmIGJvdGggc291
cmNlIGFuZCBkZXN0aW5hdGlvbiBibG9jayBkZXZpY2VzIGFyZSBzYW1lIGFuZCBjb3B5X29mZmxv
YWQgPSAxLAo+Pj4gdGhlbiBjb3B5IGlzIGRvbmUgdGhyb3VnaCBuYXRpdmUgY29weSBvZmZsb2Fk
aW5nLiBDb3B5IGVtdWxhdGlvbiBpcyB1c2VkCj4+PiBpbiBvdGhlciBjYXNlcy4KPj4+IAo+Pj4g
QXMgU0NTSSBYQ09QWSBjYW4gdGFrZSB0d28gZGlmZmVyZW50IGJsb2NrIGRldmljZXMgYW5kIG5v
IG9mIHNvdXJjZSByYW5nZSBpcwo+Pj4gZXF1YWwgdG8gMSwgdGhpcyBpbnRlcmZhY2UgY2FuIGJl
IGV4dGVuZGVkIGluIGZ1dHVyZSB0byBzdXBwb3J0IFNDU0kgWENPUFkuCj4+IEFueSBpZGVhIHdo
eSB0aGlzIFRQIHdhc24ndCBkZXNpZ25lZCBmb3IgY29weSBvZmZsb2FkIGJldHdlZW4gMiAKPj4g
ZGlmZmVyZW50IG5hbWVzcGFjZXMgaW4gdGhlIHNhbWUgY29udHJvbGxlciA/Cj4gCj4gWWVzLCBp
dCB3YXMgdGhlIGZpcnN0IGF0dGVtcHQgc28gdG8ga2VlcCBpdCBzaW1wbGUuCj4gCj4gRnVydGhl
ciB3b3JrIGlzIG5lZWRlZCB0byBhZGQgaW5jcmVtZW50YWwgVFAgc28gdGhhdCB3ZSBjYW4gYWxz
byBkbyBhIGNvcHkKPiBiZXR3ZWVuIHRoZSBuYW1lLXNwYWNlcyBvZiBzYW1lIGNvbnRyb2xsZXIg
KGlmIHdlIGNhbid0IGFscmVhZHkpIGFuZCB0byB0aGUKPiBuYW1lc3BhY2VzIHRoYXQgYmVsb25n
cyB0byB0aGUgZGlmZmVyZW50IGNvbnRyb2xsZXIuCj4gCj4+IEFuZCBhIHNpbXBsZSBjb3B5IHdp
bGwgYmUgdGhlIGNhc2Ugd2hlcmUgdGhlIHNyY19uc2lkID09IGRzdF9uc2lkID8KPj4gCj4+IEFs
c28gd2h5IHRoZXJlIGFyZSBtdWx0aXBsZSBzb3VyY2UgcmFuZ2VzIGFuZCBvbmx5IG9uZSBkc3Qg
cmFuZ2UgPyBXZSAKPj4gY291bGQgYWRkIGEgYml0IHRvIGluZGljYXRlIGlmIHRoaXMgcmFuZ2Ug
aXMgc3JjIG9yIGRzdC4uCgpPbmUgb2YgdGhlIHRhcmdldCB1c2UgY2FzZXMgd2FzIFpOUyBpbiBv
cmRlciB0byBhdm9pZCBmYWJyaWMgdHJhbnNmZXJzIGR1cmluZyBob3N0IEdDLiBZb3UgY2FuIHNl
ZSBob3cgdGhpcyBwbGF5cyB3ZWxsIHdpdGggc2V2ZXJhbCB6b25lIHJhbmdlcyBhbmQgYSBzaW5n
bGUgem9uZSBkZXN0aW5hdGlvbi4gCgpJZiB3ZSBzdGFydCBnZXR0aW5nIHN1cHBvcnQgaW4gTGlu
dXggdGhyb3VnaCB0aGUgZGlmZmVyZW50IHBhc3QgY29weSBvZmZsb2FkIGVmZm9ydHMsIEnigJlt
IHN1cmUgd2UgY2FuIGV4dGVuZCB0aGlzIFRQIGluIHRoZSBmdXR1cmUuIAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

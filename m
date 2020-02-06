Return-Path: <SRS0=EBwi=32=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE5FC35247
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Feb 2020 20:28:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 510FE21927
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Feb 2020 20:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RAqstmkD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="A5gCaPtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 510FE21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rp/lhUDKf5ze4BgdYj7C7Geqfl2lzFv30Wx2vzWKjow=; b=RAqstmkDNwQGkY34Ib5TEF6Xm
	mmyNxiu+CCJER3K18K1zAr5hgGfOXPvZ1VEl7uLDMMgNhjPbueYGXKUSOYnvs2TvcFd0QjVpk8fFb
	7P2Dp6DodeFuZnUB4Pl9SZjRdNHFqe797cl6i8v+V75ugWcTLBosV+KJPdFfLfzyQJ504Eat9aCHm
	c6THBNciwaRS2BOrEUiYy0m1/bH8xK0iHzAs5yEIA5ifYa92dki7tiJRsitbuvUxIM8BljFFUyFfL
	8Zh7cdLNQ8Oe0PdmAqo+Kb0Ce5/5gQ0WjyBZuheX65jpVqOjVByRJcLeJeXc2IkYmWy1Ht3i4W6Bo
	ti8nLmeLw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iznlW-00018w-GP; Thu, 06 Feb 2020 20:28:46 +0000
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iznlT-00018U-CZ
 for linux-nvme@lists.infradead.org; Thu, 06 Feb 2020 20:28:44 +0000
Received: by mail-pj1-x1030.google.com with SMTP id n96so474165pjc.3
 for <linux-nvme@lists.infradead.org>; Thu, 06 Feb 2020 12:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=asbw+Ug3q0LX1wUHs0e7eOXzpanGIs8zWa+9qJdr+HQ=;
 b=A5gCaPtgcxkpuGb6W0+9rvTOEOgdzdQDaRW+5TbnHa8kHVG+8d2yv8Dj6Si9GjS5gn
 DcXTyNkfxcEIwJsomX3Zh5NODtZmIIS1/Wh+ukTOV/3KQvx4D4oa7hgL6RId8Z3ZUu+X
 yaEH7HARHoIec4Xf2UrxRlO8j9lCBJhfL8KIc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=asbw+Ug3q0LX1wUHs0e7eOXzpanGIs8zWa+9qJdr+HQ=;
 b=CKWI8GZVFqAbcYexTyTIEL/bMqv4LDJijnIkfOo7R1AYvoZGet7kkFBvdxgxZo3hoS
 0CB7KOA4c97uBSPf3xqBiEI7fmf+GeZiRMc4/TwmK4MhCzSSrx9ZwuLypCuEAOyJZIQz
 51Yd1i9/5i44dxHVYzIzxiMAKZGLivE42R9XLw8gmVVxRuCZYwTqZr9puLntClOdGdB3
 VsiOE8Od78HtMS0ECH4sLRpl+TOftVSaHQDRkhYVIl6j7X7oezjRg31RDpfEpsjTs/zx
 VDZHQyLOo0LoIzb4+1SWld0TbSV0MY6n5mJ9WJdOk+viyw4LpiLKoak0YnSRluKueacA
 K+7g==
X-Gm-Message-State: APjAAAVXjxRnQun+ZNedDZfQyD3qH9LK79Wtb3+lfFCnkFuQRmC0x4kK
 ZRGhaodMB/TErXZBaPEbFEAdoCsuL9omHfmYnCMU2Bnjc6bSYPdHFBT18BNkddfnF8kHPmN1zhg
 oFGjFYBUHZUHzn4R6++r1rhULakz3OOEkPs7MDwNVq9fafP7QMJDYkA4RFYxCwlxt6Z4FJ2mr7f
 CwCiU0cA==
X-Google-Smtp-Source: APXvYqwbjVRvgBdBLbeb70QksZNssjRcKlQpWb0n9l3jX59qCpgpe4G6xeJBhGLnh6r3QK87C7c8ag==
X-Received: by 2002:a17:90b:f06:: with SMTP id
 br6mr6575061pjb.125.1581020921616; 
 Thu, 06 Feb 2020 12:28:41 -0800 (PST)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id l7sm279666pga.27.2020.02.06.12.28.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 12:28:40 -0800 (PST)
Subject: Re: NVMe/FC compatible hardware
To: Talker Alex <alextalker@yandex.ru>, linux-nvme@lists.infradead.org
References: <5657351581013707@iva7-8a189d9308a6.qloud-c.yandex.net>
From: James Smart <james.smart@broadcom.com>
Message-ID: <15376994-b86b-39f0-ffcd-cd102bfdd377@broadcom.com>
Date: Thu, 6 Feb 2020 12:28:39 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <5657351581013707@iva7-8a189d9308a6.qloud-c.yandex.net>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200206_122843_429806_3D241878 
X-CRM114-Status: GOOD (  18.07  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAyLzYvMjAyMCAxMDoyOCBBTSwgVGFsa2VyIEFsZXggd3JvdGU6Cj4gSGksCj4KPiBDb3Vs
ZCBhbnlvbmUga2luZGx5IGNsYXJpZnkgaWYgTlZNZS9GQyBMaW51eCBkcml2ZXJzIHdvdWxkIHdv
cmsgd2l0aCBhbnkgRmlicmVDaGFubmVsIEhCQT8KPgo+IEkndmUgY29ubmVjdGVkIEFUVE8gQ2Vs
ZXJpdHkgRkMtMTYyRSBhbmQgQVRUTyBDZWxlcml0eSBGQy04MkVOIGNhcmRzKG9uIHN1YnN5c3Rl
bSAmIGhvc3QgcmVzcGVjdGl2ZWx5KSBhbmQgc3VjY2Vzc2Z1bGx5IG1hbmFnZWQgdG8gc2V0dXAg
YSBwb3J0Cj4gYnV0IEkgc3RydWdnbGUgdG8gY29ubmVjdCB0byBpdCwgaXNzdWluZyB0aGUgZm9s
bG93aW5nIGNvbW1hbmQ6CkZvciBkcml2ZXJzIHdpdGhpbiB0aGUga2VybmVsLCBFbXVsZXggaGJh
cyBzdXBwb3J0IE5WTUUgaW5pdGlhdG9yIG9yIAp0YXJnZXQgb3BlcmF0aW9uLCBhbmQgYWZhaWss
IFFsb2dpYyBoYmFzIGFyZSBOVk1FIGluaXRpYXRvciBvbmx5LsKgIEkgCmFzc3VtZSB5b3UncmUg
d29ya2luZyBvbiBhbiB1cHN0cmVhbSBrZXJuZWwsIHNvIG5vIHRyaWNrcyBhcmUgbmVlZGVkIHRv
IApjb25maWd1cmUgdGhlIGRyaXZlcnMgdG8gZW5hYmxlIG52bWUgKGluaXRpYXRvciBtb2RlKSwg
YnV0IGl0IG1heSBzdGlsbCAKcmVxdWlyZSB0aGUgaGJhIGZ3IHRvIGJlIG52bWUgZW5hYmxlZCBm
b3IgdGhlIGRyaXZlcnMgdG8gcmVnaXN0ZXIuwqAgClRoZXJlIGlzbid0IG11Y2ggdGhhdCBpZGVu
dGlmaWVzIHdoZW4gYW4gaGJhIGhhcyByZWdpc3RlcmVkIHdpdGggbnZtZS7CoCAKWW91IHNob3Vs
ZCBsb29rIGF0IHlvdXIgbG9nIGFuZCBsb29rIGF0IHdoYXQgZHJpdmVyIGF0dGFjaGVkIChvciBk
aWRuJ3QpIAp0byB0aGUgQVRUTyBjYXJkcy4gQWxsIGRlcGVuZHMgb24gdGhlaXIgUENJwqAgSURz
LgoKPgo+PiBudm1lIGRpc2NvdmVyIC10IGZjIC1hIG5uLTB4MjAwMDAwMTA4NjAzNzBhNDpwbi0w
eDEwMDAwMDEwODYwMzcwYTQgIC13IG5uLTB4MjAwMDAwMTA4NjAzNjg3MDpwbi0weDIxMDAwMDEw
ODYwMzY4NzAKPiBJIGdldCB0aGlzIGVycm9yOgo+Cj4+IFs0MTY0NDg3LjExNDUxNF0gKE5VTEwg
ZGV2aWNlICopOiBxdWV1ZSAwIGNvbm5lY3QgYWRtaW4gcXVldWUgZmFpbGVkICgtMTExKS4KPj4g
WzQxNjQ0ODcuMTE0NTE5XSBudm1lIG52bWUwOiBOVk1FLUZDezB9OiByZXNldDogUmVjb25uZWN0
IGF0dGVtcHQgZmFpbGVkICgtMTExKQo+PiBbNDE2NDQ4Ny4xMTQ1MjJdIG52bWUgbnZtZTA6IE5W
TUUtRkN7MH06IFJlY29ubmVjdCBhdHRlbXB0IGluIDEwIHNlY29uZHMKPj4gWzQxNjQ0ODcuMTE0
NTM1XSBudm1lIG52bWUwOiBOVk1FLUZDezB9OiBuZXcgY3RybDogTlFOICJucW4uMjAxNC0wOC5v
cmcubnZtZXhwcmVzcy5kaXNjb3ZlcnkiCj4+IFs0MTY0NDg3LjExNDY3Ml0gbnZtZSBudm1lMDog
UmVtb3ZpbmcgY3RybDogTlFOICJucW4uMjAxNC0wOC5vcmcubnZtZXhwcmVzcy5kaXNjb3Zlcnki
CgpXZWxsLCBieSB0aGUgZmFjdCB5b3UgZ290IGludG8gdGhlIG52bWUtZmMgdHJhbnNwb3J0LMKg
IGFuZCB0aGF0IHlvdSAKcmVjZWl2ZWQgYSAtMTExIHN0YXR1cyAoLUVDT05OUkVGVVNFRCkgaXQg
c2F5cyB5b3UgcGFzc2VkIGFsbCB0aGUgY2hlY2tzIApmb3IgZmluZGluZyBhIGhvc3Rwb3J0IHRv
IG1hdGNoIHRoZSAtdy8tLWhvc3QtdHJhZGRyIGluZm8gYW5kIGEgCnJlbW90ZXBvcnQgb24gdGhh
dCBob3N0cG9ydCB0aGF0IG1hdGNoZXMgdGhlIC1hLy10cmFkZHIgaW5mbyBhbmQgc3RhcnRlZCAK
dGhlIGNvbnRyb2xsZXIgY3JlYXRpb24uIFNvIHRoYXQncyBwcmV0dHkgZmFyLgoKQnV0IHR3byB0
aGluZ3MgYXJlIGJvdGhlcnNvbWU6Ci0gVGhlIE5VTEwgZGV2aWNlICogOiB3aGljaCBtYWtlcyBt
ZSB0aGluayB0aGF0IHRoZSBob3N0cG9ydCBtYXBwZWQgdG8gCnNvbWV0aGluZyBiYXNlZCBvbiBm
Y2xvb3AgLSBub3QgdG8gYSByZWFsIHBjaS1iYXNlZCBoYmEuIFlvdSBzaG91bGQgaGF2ZSAKdGhl
IGRldmljZXMgYmFzZSBuYW1lLgotIFRoZSAtMTExIHN0YXR1cyAtIHdoaWNoIGlzIG9jY3VycyBp
ZiB0aGUgdHJhbnNwb3J0IHRyaWVzIHRvIHNlbmQgdGhlIApDcmVhdGUgQXNzb2NpYXRpb24gTFMg
YnV0IGl0IGZhaWxzIGFzIHRoZSByZW1vdGUgcG9ydCBpc24ndCBvbmxpbmUgLSAKbWVhbmluZyB0
aGUgZHJpdmVyIGhhcyB1bnJlZ2lzdGVyZWQgdGhlIHJlbW90ZSBwb3J0IGJ1dCBpdCBoYXMgeWV0
IHRvIGJlIApmdWxseSByZW1vdmVkIHlldCAod2FpdGluZyBvbiByZWZlcmVuY2VzKS7CoCBUaGlz
IG9mIGNvdXJzZSBzdG9wcyBhbnkgTFMgCmZyb20gYmVpbmcgdHJhbnNtaXQuwqDCoCBUaGlzIGlz
IG9kZCBhcyBpdCdzIHVzdWFsbHkgb25seSBhIHN0YXRlIHRoYXQgCndvdWxkIGJlIHNlZW4gaWYg
dGhlcmUgd2FzIGEgbG9nb3V0IHdpdGggdGhlIHRhcmdldCBhbmQgdG8gaGF2ZSB5b3UgaGl0IApp
dCByaWdodCBhcyB5b3UgdHlwZSB0aGUgZGlzY292ZXIgY29tbWFuZCB3b3VsZCBiZSBhIG1pZ2h0
eSBjb2luY2lkZW5jZS4KCgo+IGFuZCBub3RoaW5nIG9uIHN1YnN5c3RlbShjb250cm9sbGVyPykg
c2lkZS4KPgo+IEkgZXhwZWN0IHRoYXQgaWYgYWRkcl90cmFjdGl2ZSBhdHRyaWJ1dGUgb2YgdGhl
IHBvcnQgaW4gQ29uZmlnRlMgZXF1YWxzIDEsIGl0IG1lYW5zIHRoYXQgc2VsZWN0ZWQgcG9ydC9I
QkEgY2FwYWJsZSBpbiB1dGlsaXphdGlvbiBmb3IgTlZNZS1vRi4KPiBBbSBJIHdyb25nIGluIHRo
YXQgdG9vPwpJIGRvbid0IGtub3cgd2hhdCB0aGlzIGF0dHJpYnV0ZSBpcyAtIHdoYXQncyBpdCdz
IHBhdGggPwoKZmVlbCBmcmVlIHRvIHNlbmQgbWUgZW1haWwgb2ZmbGluZSBpZiB5b3Ugd2FudCB0
byBzZW5kIG1vcmUgbG9ncyBhbmQgCmRpc2N1c3MgdGhpcyBmdXJ0aGVyLgoKLS0gamFtZXMKCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1udm1l
IG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

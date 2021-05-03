Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED93C433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 15:51:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E71600CC
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 15:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E71600CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Lb505xTX0oyjdL1fauKYjHcdrJQDhiVuLGV9heDayE4=; b=e3oDgYL+E7XljBQX2/AM5y52u
	fGlvjfHm/j+wH8leaWa0cecEVWQ5ojVAIBD/SUD6phin+7SQeM3Hj132Hu0FSsA5t19VOYOlOKkgB
	JqIys8T7+G9FCGDRIr/IYsRDGQYkF2sRGu/ZE5o+Gl/Hp8BQUiCideheoKCzljxWi7/U4deGvr6OS
	ZB2rUEZkkA18LXpuUkIhvuxD53DtN2lFu8m9/Zx8EIi0sLxAZqJFoQkOmPN35XyGgn0BeIEbB7KZe
	cYoywxDzTWyuIJhblnZ1HGrulZew3ZkcjdCUZdFU3yJ2d8Cj1peGincJ0SDlYHa3VqBgIfhFYLjCt
	M+ctlagRw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldaqi-00EIen-8Q; Mon, 03 May 2021 15:51:08 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldaqf-00EIeU-B4
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 15:51:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-ID:Content-Description;
 bh=PovfX3jhu3r6iqd6p4kIrUtBHHGyYiOcYQxAFFzrIyU=; b=cVhiQ2OZ4l5yTMAN2vxRgGBdQG
 AV2utkbIeCE5f1z5aRRliiadWfH135PXL9nmo3Lh0zF7IXJHxfI5sOhcOJ7MlrDhoGIHbWSRkfYQ4
 VmjaqnI80EWRuJ/d1+2cBGnHZ9izlNmSFNSyIKgwoIVu531qvBoJQ5A1CF7v+HqRNyMWYWs1ZxIDd
 YKn9stA5HY4phvXWRbQm8vODRCqDfC+Kv4UxZxtW8jJ/yXmLXd1bV1y+LT7L922EARR9B2vF8d3nw
 YGQEnx2Zxl0ttk/a1LDdsU/ycGPn8qEW6Z3SvIHqg2N2VwcqfCafq0cqXhyV5pYDKQYexrifmlGYb
 PVF6TAeA==;
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldaqc-003CTk-HS
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 15:51:04 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a4so8613838ejk.1
 for <linux-nvme@lists.infradead.org>; Mon, 03 May 2021 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PovfX3jhu3r6iqd6p4kIrUtBHHGyYiOcYQxAFFzrIyU=;
 b=RFJGyoSptXVvpRoYVLjEu25OL24l9jhAEJUMj6X8nt/Zw0slfVPqy8XT1/qPlaMard
 lUVfw0Ie6pZOw/FXFa5+nZ/3V93LVnn08AW2kutqyYhl7F4YOktQjMy8R0/oKWK3kwo6
 bf5C8KFfYe+FsLfuZwjOWZbPxIZAipWGvTLorSBEFNCosrJhcnUmBaBTWFP1dziSHGlF
 HGqrvYi8nua35g4XoAQVqB/VgzrM+mUu0RPE9KepOEdDFARxg8yOo9/wxNC6rBn/rLFO
 rVdWkWtPODP61wicaz6ukUd9qkwImTscTsLr8L1syqTigfZrRhMieLeD8D8ZrCQibO38
 KMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PovfX3jhu3r6iqd6p4kIrUtBHHGyYiOcYQxAFFzrIyU=;
 b=g4YhQXUcyLUzfKFQXrkcPWEWYi4fo77Mrofyk4TWQu+nnhHgQmwN8i4kz4pNp1Y2FB
 c5JT1dzpubnL3PDNT3O4WxbhtcA3P3waEU0pdxDXeRjeJpaOxjDQGcS01GO39JWmgC4j
 NrLU7tZVeTmeQnePgySPSkdazIjYtuO1yvGiZtItfKxH5IVZeDVirX4p+SSYllI3rLVr
 43WkgtVl3JidFm7m3zzBgmgmZ/Be7M/RDxgg5aG+yqCXCIGg7PwniStZobFo3NB1EZlI
 ITaaQ/ImZDrqE+8naRSRAVSBQa3swTBjCAfUu8eMbVZw+wh7HKOPblykf3O913vdx5vl
 F3OA==
X-Gm-Message-State: AOAM5310Pmdxm5JZoCsnkup4hXz8Zj1OETWTQ8nlPOc1XZ7EPJajqt4N
 7IZ6SzRbpVyVm+NZOXjOr15IjfEUEs6c+7KMLv0=
X-Google-Smtp-Source: ABdhPJzxsNxYaCCkUJEvotJ3llpWHkTeyv8vNd4/4Y6nI+M4HqyRdwbcHs6B0ubm5O/USWNfTEOP8RXYknQzF3h8uQw=
X-Received: by 2002:a17:906:3a45:: with SMTP id
 a5mr17902408ejf.288.1620057061232; 
 Mon, 03 May 2021 08:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-10-smalin@marvell.com>
 <62c750cb-b757-510e-a2fa-849f8f89d6e2@suse.de>
In-Reply-To: <62c750cb-b757-510e-a2fa-849f8f89d6e2@suse.de>
From: Shai Malin <malin1024@gmail.com>
Date: Mon, 3 May 2021 18:50:50 +0300
Message-ID: <CAKKgK4z=pCgXZW-dk0pweGc_w2rLqfyhoWgWMkzjV0pogoecyg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 09/27] nvme-fabrics: Move NVMF_ALLOWED_OPTS and
 NVMF_REQUIRED_OPTS definitions
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Cc: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 davem@davemloft.net, 
 kuba@kernel.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com, 
 kbusch@kernel.org, Ariel Elior <aelior@marvell.com>, 
 Michal Kalderon <mkalderon@marvell.com>, okulkarni@marvell.com,
 pkushwaha@marvell.com, Arie Gershberg <agershberg@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_085102_603151_4E5E233A 
X-CRM114-Status: GOOD (  22.37  )
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

T24gNC8yOS8yMSAzOjE5IFBNLCBIYW5uZXMgUmVpbmVja2Ugd3JvdGU6Cj4gT24gNC8yOS8yMSA5
OjA5IFBNLCBTaGFpIE1hbGluIHdyb3RlOgo+ID4gRnJvbTogQXJpZSBHZXJzaGJlcmcgPGFnZXJz
aGJlcmdAbWFydmVsbC5jb20+Cj4gPgo+ID4gTW92ZSBOVk1GX0FMTE9XRURfT1BUUyBhbmQgTlZN
Rl9SRVFVSVJFRF9PUFRTIGRlZmluaXRpb25zCj4gPiB0byBoZWFkZXIgZmlsZSwgc28gaXQgY2Fu
IGJlIHVzZWQgYnkgdHJhbnNwb3J0IG1vZHVsZXMuCj4gPgo+ID4gQWNrZWQtYnk6IElnb3IgUnVz
c2tpa2ggPGlydXNza2lraEBtYXJ2ZWxsLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IEFyaWUgR2Vy
c2hiZXJnIDxhZ2Vyc2hiZXJnQG1hcnZlbGwuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogUHJhYmhh
a2FyIEt1c2h3YWhhIDxwa3VzaHdhaGFAbWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBP
bWthciBLdWxrYXJuaSA8b2t1bGthcm5pQG1hcnZlbGwuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTog
TWljaGFsIEthbGRlcm9uIDxta2FsZGVyb25AbWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5
OiBBcmllbCBFbGlvciA8YWVsaW9yQG1hcnZlbGwuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogU2hh
aSBNYWxpbiA8c21hbGluQG1hcnZlbGwuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvbnZtZS9o
b3N0L2ZhYnJpY3MuYyB8IDcgLS0tLS0tLQo+ID4gICBkcml2ZXJzL252bWUvaG9zdC9mYWJyaWNz
LmggfCA3ICsrKysrKysKPiA+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDcg
ZGVsZXRpb25zKC0pCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJp
Y3MuYyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYwo+ID4gaW5kZXggNjA0YWIwZTVhMmFk
Li41NWQ3MTI1Yzg0ODMgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNz
LmMKPiA+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYwo+ID4gQEAgLTEwMDEsMTMg
KzEwMDEsNiBAQCB2b2lkIG52bWZfZnJlZV9vcHRpb25zKHN0cnVjdCBudm1mX2N0cmxfb3B0aW9u
cyAqb3B0cykKPiA+ICAgfQo+ID4gICBFWFBPUlRfU1lNQk9MX0dQTChudm1mX2ZyZWVfb3B0aW9u
cyk7Cj4gPgo+ID4gLSNkZWZpbmUgTlZNRl9SRVFVSVJFRF9PUFRTICAgKE5WTUZfT1BUX1RSQU5T
UE9SVCB8IE5WTUZfT1BUX05RTikKPiA+IC0jZGVmaW5lIE5WTUZfQUxMT1dFRF9PUFRTICAgIChO
Vk1GX09QVF9RVUVVRV9TSVpFIHwgTlZNRl9PUFRfTlJfSU9fUVVFVUVTIHwgXAo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE5WTUZfT1BUX0tBVE8gfCBOVk1GX09QVF9IT1NUTlFO
IHwgXAo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5WTUZfT1BUX0hPU1RfSUQg
fCBOVk1GX09QVF9EVVBfQ09OTkVDVCB8XAo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIE5WTUZfT1BUX0RJU0FCTEVfU1FGTE9XIHxcCj4gPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgTlZNRl9PUFRfRkFJTF9GQVNUX1RNTykKPiA+IC0KPiA+ICAgc3RhdGljIHN0cnVj
dCBudm1lX2N0cmwgKgo+ID4gICBudm1mX2NyZWF0ZV9jdHJsKHN0cnVjdCBkZXZpY2UgKmRldiwg
Y29uc3QgY2hhciAqYnVmKQo+ID4gICB7Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hv
c3QvZmFicmljcy5oIGIvZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5oCj4gPiBpbmRleCA4ODhi
MTA4ZDg3YTQuLmI3NjI3ZThkY2FhZiAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0
L2ZhYnJpY3MuaAo+ID4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5oCj4gPiBAQCAt
NjgsNiArNjgsMTMgQEAgZW51bSB7Cj4gPiAgICAgICBOVk1GX09QVF9GQUlMX0ZBU1RfVE1PICA9
IDEgPDwgMjAsCj4gPiAgIH07Cj4gPgo+ID4gKyNkZWZpbmUgTlZNRl9SRVFVSVJFRF9PUFRTICAg
KE5WTUZfT1BUX1RSQU5TUE9SVCB8IE5WTUZfT1BUX05RTikKPiA+ICsjZGVmaW5lIE5WTUZfQUxM
T1dFRF9PUFRTICAgIChOVk1GX09QVF9RVUVVRV9TSVpFIHwgTlZNRl9PUFRfTlJfSU9fUVVFVUVT
IHwgXAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5WTUZfT1BUX0tBVE8gfCBO
Vk1GX09QVF9IT1NUTlFOIHwgXAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE5W
TUZfT1BUX0hPU1RfSUQgfCBOVk1GX09QVF9EVVBfQ09OTkVDVCB8XAo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIE5WTUZfT1BUX0RJU0FCTEVfU1FGTE9XIHxcCj4gPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgTlZNRl9PUFRfRkFJTF9GQVNUX1RNTykKPiA+ICsKPiA+
ICAgLyoqCj4gPiAgICAqIHN0cnVjdCBudm1mX2N0cmxfb3B0aW9ucyAtIFVzZWQgdG8gaG9sZCB0
aGUgb3B0aW9ucyBzcGVjaWZpZWQKPiA+ICAgICogICAgICAgICAgICAgICAgICAgICAgICB3aXRo
IHRoZSBwYXJzaW5nIG9wdHMgZW51bS4KPiA+Cj4KPiBXaHkgZG8geW91IG5lZWQgdGhlbT8gTm9u
ZSBvZiB0aGUgb3RoZXIgdHJhbnNwb3J0IGRyaXZlcnMgdXNlIHRoZW0sIHdoeSB5b3U/Cj4KCkRp
ZmZlcmVudCBIVyBkZXZpY2VzIHRoYXQgYXJlIG9mZmxvYWRpbmcgdGhlIE5WTWVUQ1AgbWlnaHQg
aGF2ZSBkaWZmZXJlbnQKbGltaXRhdGlvbnMgb2YgdGhlIGFsbG93ZWQgb3B0aW9ucy4KRm9yIGV4
YW1wbGUsIGEgZGV2aWNlIHRoYXQgZG9lcyBub3Qgc3VwcG9ydCBhbGwgdGhlIHF1ZXVlIHR5cGVz
LgpXaXRoIHRjcCBhbmQgcmRtYSwgb25seSB0aGUgbnZtZS10Y3AgYW5kIG52bWUtcmRtYSBsYXll
cnMgaGFuZGxlIHRob3NlCmF0dHJpYnV0ZXMgYW5kIHRoZSBIVyBkZXZpY2VzIGRvIG5vdCBjcmVh
dGUgYW55IGxpbWl0YXRpb25zIGZvciB0aGUgYWxsb3dlZApvcHRpb25zLgoKQW4gYWx0ZXJuYXRp
dmUgZGVzaWduIGNvdWxkIGJlIHRvIGFkZCBzZXBhcmF0ZSBmaWVsZHMgaW4gbnZtZV90Y3Bfb2Zs
ZF9vcHMgc3VjaAphcyBtYXhfaHdfc2VjdG9ycyBhbmQgbWF4X3NlZ21lbnRzIHRoYXQgd2UgYWxy
ZWFkeSBoYXZlIGluIHRoaXMgc2VyaWVzLgoKV2hpY2ggd291bGQgeW91IHByZWZlcj8KCj4gQ2hl
ZXJzLAo+Cj4gSGFubmVzCj4gLS0KPiBEci4gSGFubmVzIFJlaW5lY2tlICAgICAgICAgICAgICAg
IEtlcm5lbCBTdG9yYWdlIEFyY2hpdGVjdAo+IGhhcmVAc3VzZS5kZSAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICs0OSA5MTEgNzQwNTMgNjg4Cj4gU1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMg
R21iSCwgTWF4ZmVsZHN0ci4gNSwgOTA0MDkgTsO8cm5iZXJnCj4gSFJCIDM2ODA5IChBRyBOw7xy
bmJlcmcpLCBHZXNjaMOkZnRzZsO8aHJlcjogRmVsaXggSW1lbmTDtnJmZmVyCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

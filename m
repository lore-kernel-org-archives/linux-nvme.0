Return-Path: <SRS0=iWk4=J7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04EF6C433B4
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 16:52:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AA161177
	for <linux-nvme@archiver.kernel.org>; Tue,  4 May 2021 16:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AA161177
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=O5YwRos5x6yia8loderapFDuAooXUyIJjllm30q6yFQ=; b=TXGZ4oIcYNLy1kn4ZBeJTCkiv
	J0/t2E69DqSMHKj6UBU1igA9p9uzc1O4bHh9K24T7VTQH/yrR0y1VLUcSSz/8uve9XbsfkVoBo2Q/
	OseOPeCB+zjioAIyirfPgTKxrtu6OvXxVlKDLRZP51/RpNMpML6WTR8nQNx+AEokj9CxNf4ht2cX7
	dABEmtO6OlWiBRhGW/Cc7zBYFt8xtAHAvDXKsWc+ZXtfB2vvruYrqjV9WGRDJ5EUjTAupuBbe9Os4
	bsxLTnKqMp5G9zrtNZ0074IxZq65UfcD+CLnobP9SSFcwqLran25bC/ga7+PISJThDIj/CW5aUQel
	9w9lk2etw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ldyHl-00Gb8o-SU; Tue, 04 May 2021 16:52:37 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldyHi-00Gb8M-A7
 for linux-nvme@desiato.infradead.org; Tue, 04 May 2021 16:52:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-ID:Content-Description;
 bh=S9An/4KRHHEsRc5JqJ5HmbiRGmmXFpeFAxk37d4lG3o=; b=W6/H29gt1tGY4sdYmB8GT4pydf
 fGgTzHGqmsVvSoD/4EX3gV8wV3TIXHX1gpXzqCIZqcCxSp8m34sxENenN0j7+jZdHqx1gYS88v0cb
 WU+S/H/0QCjWOo2wFMDKpYJeF5shl4HzKsiZX1PBBlT7ZAAEqHa6Orpl3ZWVOKrGQOPUpJwIK90dw
 AdGxMBCyUOFEomObByZqHdDa/U+UKSQGBLXdLVopHAP8+c6855JyWZCVGHWsO8wv+NpMt2dkrYLs1
 aEcto3lggl1nckNB3I8M4vRJHd04Bj6VUddDl67ii0rF6lMGphaSHaAEBKgtPgVsb2J1E4Gjc5NoR
 Zg+7vJUA==;
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ldyHf-0047QN-Mx
 for linux-nvme@lists.infradead.org; Tue, 04 May 2021 16:52:32 +0000
Received: by mail-ed1-x52d.google.com with SMTP id g14so11242150edy.6
 for <linux-nvme@lists.infradead.org>; Tue, 04 May 2021 09:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=S9An/4KRHHEsRc5JqJ5HmbiRGmmXFpeFAxk37d4lG3o=;
 b=JnTnb3mxA44OvVQIzk+R8P4FSWgmymxIlQgaZrM5XfJKjdc1LgMnlXYZ9wurxzHOgn
 n7FA3GnEijzxTPelFi01qADd97BkT5KSApS6HtTHrZvwODq8IxOB0ThWwwmfZm6QH4FR
 +k81HqBGpcg1yN3A3WO1mP71H9b24xdxeKWCGtzvIe9VtZg23tBem1VLkGwqnIjO/soy
 vuv73x7vGvHwyBywyHdB6w6fAmf+fydTzdAk6CAomHUdHrilU5hj1eRlXc8Jp194blxO
 yu7sa0pIqqAcRTsIUt96s+D8LIvSkxBuRnvjBHCg7LybnKS5/1bRv+qAdPdUtROvgVfO
 SrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=S9An/4KRHHEsRc5JqJ5HmbiRGmmXFpeFAxk37d4lG3o=;
 b=HrQxB61sVJyijEnADppS3yLrMaWLtAto1N6v4yiuiMSl2Q1HjHIzn+GRPo3EOc+aoM
 s/ECkzHFE0N1gisH6gfbRKg/ZrDdOK3prOMF0b++VIoTfOq5hNylo75g1utK26zVOOct
 jnyMyKznkzKKEDTowI5Db0K9OxyHRNXwNdkY+g7WVMT4PtMfho0eNht4UqTRMNKlR59y
 1P2m5jcxVg4nH8kdfCd2Rhw8KIGS/Fkqm+ROmxicD12168iBlaNK9Y0/ini9dzElt3fs
 3nYQ40Dw+KwjTb0XhXxW5XndWxpYXnXcGEF/luOpxpAYyFpzNEDq9KZ2Zbb9bINuH+P7
 Hvxg==
X-Gm-Message-State: AOAM532/X14NWCxwDl3ukjhuxQvW+mbpY9n/YbJpd5m+U7nFOyROr0Ca
 vGoluHjd8ZEl1LlmDuLTyAVYVF0V4COKhdTeO20=
X-Google-Smtp-Source: ABdhPJzYXgIMgrBymTxMB6fabBb7YbN947QvsDWyG1TaFm+4dWIALaoRGSJSHnebMz/rK2613adXOPpK8Su4CoWJMyw=
X-Received: by 2002:a05:6402:1a2f:: with SMTP id
 be15mr26955492edb.207.1620147149831; 
 Tue, 04 May 2021 09:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-17-smalin@marvell.com>
 <4c17c44e-a08a-93cc-5ccf-51045cba0f0f@suse.de>
In-Reply-To: <4c17c44e-a08a-93cc-5ccf-51045cba0f0f@suse.de>
From: Shai Malin <malin1024@gmail.com>
Date: Tue, 4 May 2021 19:52:18 +0300
Message-ID: <CAKKgK4wDV_BEsE1kkH2vxreeuaOnv=1+vvX7J3F7oTzzO-_PKA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 16/27] qedn: Add qedn - Marvell's NVMeTCP HW
 offload vendor driver
To: Hannes Reinecke <hare@suse.de>
Cc: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org, 
 linux-nvme@lists.infradead.org, davem@davemloft.net, kuba@kernel.org, 
 sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org, 
 Ariel Elior <aelior@marvell.com>, Michal Kalderon <mkalderon@marvell.com>,
 okulkarni@marvell.com, 
 pkushwaha@marvell.com, Arie Gershberg <agershberg@marvell.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210504_095231_772368_C4EC0446 
X-CRM114-Status: GOOD (  18.67  )
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

T24gNS8yLzIxIDI6MjcgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiA0LzI5LzIxIDk6
MDkgUE0sIFNoYWkgTWFsaW4gd3JvdGU6Cj4gPiBUaGlzIHBhdGNoIHdpbGwgcHJlc2VudCB0aGUg
c2tlbGV0b24gb2YgdGhlIHFlZG4gZHJpdmVyLgo+ID4gVGhlIG5ldyBkcml2ZXIgd2lsbCBiZSBh
ZGRlZCB1bmRlciAiZHJpdmVycy9udm1lL2h3L3FlZG4iIGFuZCB3aWxsIGJlCj4gPiBlbmFibGVk
IGJ5IHRoZSBLY29uZmlnICJNYXJ2ZWxsIE5WTSBFeHByZXNzIG92ZXIgRmFicmljcyBUQ1Agb2Zm
bG9hZCIuCj4gPgo+ID4gVGhlIGludGVybmFsIGltcGxlbWVudGF0aW9uOgo+ID4gLSBxZWRuLmg6
Cj4gPiAgICBJbmNsdWRlcyBhbGwgY29tbW9uIHN0cnVjdHMgdG8gYmUgdXNlZCBieSB0aGUgcWVk
biB2ZW5kb3IgZHJpdmVyLgo+ID4KPiA+IC0gcWVkbl9tYWluLmMKPiA+ICAgIEluY2x1ZGVzIHRo
ZSBxZWRuX2luaXQgYW5kIHFlZG5fY2xlYW51cCBpbXBsZW1lbnRhdGlvbi4KPiA+ICAgIEFzIHBh
cnQgb2YgdGhlIHFlZG4gaW5pdCwgdGhlIGRyaXZlciB3aWxsIHJlZ2lzdGVyIGFzIGEgcGNpIGRl
dmljZSBhbmQKPiA+ICAgIHdpbGwgd29yayB3aXRoIHRoZSBNYXJ2ZWxsIGZhc3RsaW5RIE5JQ3Mu
Cj4gPiAgICBBcyBwYXJ0IG9mIHRoZSBwcm9iZSwgdGhlIGRyaXZlciB3aWxsIHJlZ2lzdGVyIHRv
IHRoZSBudm1lX3RjcF9vZmZsb2FkCj4gPiAgICAoVUxQKS4KPiA+Cj4gPiBBY2tlZC1ieTogSWdv
ciBSdXNza2lraCA8aXJ1c3NraWtoQG1hcnZlbGwuY29tPgo+ID4gU2lnbmVkLW9mZi1ieTogQXJp
ZSBHZXJzaGJlcmcgPGFnZXJzaGJlcmdAbWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQ
cmFiaGFrYXIgS3VzaHdhaGEgPHBrdXNod2FoYUBtYXJ2ZWxsLmNvbT4KPiA+IFNpZ25lZC1vZmYt
Ynk6IE9ta2FyIEt1bGthcm5pIDxva3Vsa2FybmlAbWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBNaWNoYWwgS2FsZGVyb24gPG1rYWxkZXJvbkBtYXJ2ZWxsLmNvbT4KPiA+IFNpZ25lZC1v
ZmYtYnk6IEFyaWVsIEVsaW9yIDxhZWxpb3JAbWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5
OiBTaGFpIE1hbGluIDxzbWFsaW5AbWFydmVsbC5jb20+Cj4gPiAtLS0KPiA+ICAgTUFJTlRBSU5F
UlMgICAgICAgICAgICAgICAgICAgICAgfCAgMTAgKysKPiA+ICAgZHJpdmVycy9udm1lL0tjb25m
aWcgICAgICAgICAgICAgfCAgIDEgKwo+ID4gICBkcml2ZXJzL252bWUvTWFrZWZpbGUgICAgICAg
ICAgICB8ICAgMSArCj4gPiAgIGRyaXZlcnMvbnZtZS9ody9LY29uZmlnICAgICAgICAgIHwgICA4
ICsrCj4gPiAgIGRyaXZlcnMvbnZtZS9ody9NYWtlZmlsZSAgICAgICAgIHwgICAzICsKPiA+ICAg
ZHJpdmVycy9udm1lL2h3L3FlZG4vTWFrZWZpbGUgICAgfCAgIDUgKwo+ID4gICBkcml2ZXJzL252
bWUvaHcvcWVkbi9xZWRuLmggICAgICB8ICAxOSArKysKPiA+ICAgZHJpdmVycy9udm1lL2h3L3Fl
ZG4vcWVkbl9tYWluLmMgfCAyMDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4g
ICA4IGZpbGVzIGNoYW5nZWQsIDI0OCBpbnNlcnRpb25zKCspCj4gPiAgIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL252bWUvaHcvS2NvbmZpZwo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9udm1lL2h3L01ha2VmaWxlCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL252
bWUvaHcvcWVkbi9NYWtlZmlsZQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9udm1l
L2h3L3FlZG4vcWVkbi5oCj4gPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL252bWUvaHcv
cWVkbi9xZWRuX21haW4uYwo+ID4gUmV2aWV3ZWQtYnk6IEhhbm5lcyBSZWluZWNrZSA8aGFyZUBz
dXNlLmRlPgoKVGhhbmtzLgoKPgo+IENoZWVycywKPgo+IEhhbm5lcwo+IC0tCj4gRHIuIEhhbm5l
cyBSZWluZWNrZSAgICAgICAgICAgICAgICBLZXJuZWwgU3RvcmFnZSBBcmNoaXRlY3QKPiBoYXJl
QHN1c2UuZGUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICArNDkgOTExIDc0MDUzIDY4OAo+
IFNVU0UgU29mdHdhcmUgU29sdXRpb25zIEdtYkgsIE1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJu
YmVyZwo+IEhSQiAzNjgwOSAoQUcgTsO8cm5iZXJnKSwgR2VzY2jDpGZ0c2bDvGhyZXI6IEZlbGl4
IEltZW5kw7ZyZmZlcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZt
ZQo=

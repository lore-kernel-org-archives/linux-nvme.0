Return-Path: <SRS0=YFbx=KA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D7FC433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 17:57:27 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4188A61041
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 17:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4188A61041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L3VNr81QEkTRfXfZPWIYQeCYWRoldodFQxgiKpy5I1A=; b=mFm7U8e5k3gLn3L5F/j1zY6tv
	SHN6WWPEmI9z65NIsQhKDb3PCo6bK3x1PC2h+QpL8xouqTqJwikcii6UeNhWOmj3CPGe/7uFaM35j
	ZbVfAvt2UZFB78b9bwoDv9MuwtgA7FyZr11gRAKgXga6BNsOosdRZwe3HF6tZ1moXxYl26pFBD8em
	VWuiZSOIeoZ+kPMXTvqPLSKIzJYZf+zzueDj5ulwTYp4kcg7yBKmzvGP6Ov5eR0X4BBziqd+WoeTQ
	EMBx1VjEClbK+QA0HGFC+llBZMRyMlv+L1PEMiBtF8u1r3uhs7Kgt5v7XZxYXuPMk8ZqSJQ2+v0Kp
	kZDS5LPGQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leLlx-001xIv-Ou; Wed, 05 May 2021 17:57:21 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leLlw-001xIg-7s
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 17:57:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-ID:Content-Description;
 bh=u0YpP7QeR9+FnAljEpVJZP0A3y21RR6mHXedMhNEnys=; b=aUxRaoXPNm6MdFjzwIxuQ73pnJ
 8nzgEd5vsP8nr7UxAO6irq5Ua4AJjMVTzfsgbSMM3djr0J1t0bldSBhgE2HbMpGVOPIeZ8TA/NP6b
 dI8y0SvWHgj27rNSnlVbTAZ3v94RL+rLkILII0AQKDwuwWENXh7vEoYNzl7hIgzUdaSPYu6LxvaLK
 q8dcbdIIxjuOF4cdgKhI+MmpC9NicD1SBJFtD/irZKFaGUJl1mUgSyQ5/XVgiAO1h9Vl4Axk/yO7s
 xpPGP2XSmZHRs7EIIif08G3LEy5oFRTAExqwkHZS70SalCGdI3Oqc6H0GbhRl2ymZat76mZNG/qcL
 6/tRPGag==;
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leLlt-0056sg-L3
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 17:57:18 +0000
Received: by mail-ej1-x631.google.com with SMTP id y7so4196924ejj.9
 for <linux-nvme@lists.infradead.org>; Wed, 05 May 2021 10:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=u0YpP7QeR9+FnAljEpVJZP0A3y21RR6mHXedMhNEnys=;
 b=VdaxIr9H2+ajJi2/lkXI0jPbK0sFMw3lEU31US1cxU1bWTxiK6MOlSSf/dprOWg0q6
 LLUwhf7NNhQrMbi5k65kNZrcI/fcTIf9V3BFFAItIdUct5nj1lX0P2Q3mHPuwK6QIdZb
 zRogIgv/g2K+3bjIf+U4Q8Ml2+sbQVZzONULXot9Uv3ePfWWBP530BVTg4DadnrmasyN
 cHqCSuXcPmDmm+tdnjHUn6Xm9vO+Bfnk0ZVG2kpynbjLVqpSGMtmVo/mlU0v5IXiJvEl
 goWbX+r7Eyk9Lcyj0gfLi//R2ISZyRdPWdrFhPbqMuzKr9n/9poHLTDR8BVHcC1aUlyf
 Swwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=u0YpP7QeR9+FnAljEpVJZP0A3y21RR6mHXedMhNEnys=;
 b=QcnA2n/lJaxcpHGPtGoas4lzma0qnIICL2reTy0Zre002P1Y1Yb9pS5QCuG5FPbmLH
 Lvlk9LLk38GKI6UoSC/1xdtgXfAmAOlpDUzZGwty1/lnDdU1shuMAcu8ajU4SgsB7Odu
 d1b4FNxYdDd2UJ0gqTx8QI+j0njINtuBv6MfsMUbDfvXzvlSIuu1jTgQc2zMb2pPNEGV
 3/JkWB5mOi2VE8+R/NGy/perxGhFNLj8xeLuFGSa3NS1m/t4sRFi7Hem8I/t3pXNSwYW
 84F7m/kkPrcxg3QYBU4m2m/dSdDyJIvD4dNPP4YDvYwPelDTuZTp2t95esVfsXzYI5Nw
 dmtA==
X-Gm-Message-State: AOAM532uNjUPWalZfBi+Xdsts0JP3Wvmj9DK6P/iro7j0APT1pGVV5Mz
 nWCPu7bjKMTvAHdLpZrOVAcL/HLXH/bno9F0hek=
X-Google-Smtp-Source: ABdhPJy+O5YhiubXIK80B+MVZSdv7DgM5ErTWAfnBxEsVUtpy5pGSgdsj3EMNbGb26vuNX6Y/FhdGnpUUarI0YTItNU=
X-Received: by 2002:a17:906:80cd:: with SMTP id
 a13mr20487675ejx.109.1620237435969; 
 Wed, 05 May 2021 10:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-22-smalin@marvell.com>
 <cbefe381-7d00-8535-a4d7-1ac36c7aaffc@suse.de>
In-Reply-To: <cbefe381-7d00-8535-a4d7-1ac36c7aaffc@suse.de>
From: Shai Malin <malin1024@gmail.com>
Date: Wed, 5 May 2021 20:57:05 +0300
Message-ID: <CAKKgK4xetXxri0__kh-zmw3gMTiF0egr=RdNc2EcR4HN7aCLkg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 21/27] qedn: Add support of configuring HW filter
 block
To: Hannes Reinecke <hare@suse.de>
Cc: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 davem@davemloft.net, 
 kuba@kernel.org, linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, 
 axboe@fb.com, kbusch@kernel.org, Ariel Elior <aelior@marvell.com>, 
 Michal Kalderon <mkalderon@marvell.com>, okulkarni@marvell.com,
 pkushwaha@marvell.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_105717_706753_50C28131 
X-CRM114-Status: GOOD (  13.70  )
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

T24gNS8yLzIxIDI6MzggUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiA0LzI5LzIxIDk6
MDkgUE0sIFNoYWkgTWFsaW4gd3JvdGU6Cj4gPiBGcm9tOiBQcmFiaGFrYXIgS3VzaHdhaGEgPHBr
dXNod2FoYUBtYXJ2ZWxsLmNvbT4KPiA+Cj4gPiBIVyBmaWx0ZXIgY2FuIGJlIGNvbmZpZ3VyZWQg
dG8gZmlsdGVyIFRDUCBwYWNrZXRzIGJhc2VkIG9uIGVpdGhlcgo+ID4gc291cmNlIG9yIHRhcmdl
dCBUQ1AgcG9ydC4gUUVETiBsZXZlcmFnZSB0aGlzIGZlYXR1cmUgdG8gcm91dGUKPiA+IE5WTWVU
Q1AgdHJhZmZpYy4KPiA+Cj4gPiBUaGlzIHBhdGNoIGNvbmZpZ3VyZXMgSFcgZmlsdGVyIGJsb2Nr
IGJhc2VkIG9uIHNvdXJjZSBwb3J0IGZvciBhbGwKPiA+IHJlY2VpdmluZyBwYWNrZXRzIHRvIGRl
bGl2ZXIgY29ycmVjdCBRRUROIFBGLgo+ID4KPiA+IEFja2VkLWJ5OiBJZ29yIFJ1c3NraWtoIDxp
cnVzc2tpa2hAbWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmFiaGFrYXIgS3VzaHdh
aGEgPHBrdXNod2FoYUBtYXJ2ZWxsLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IE9ta2FyIEt1bGth
cm5pIDxva3Vsa2FybmlAbWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgS2Fs
ZGVyb24gPG1rYWxkZXJvbkBtYXJ2ZWxsLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IEFyaWVsIEVs
aW9yIDxhZWxpb3JAbWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFpIE1hbGluIDxz
bWFsaW5AbWFydmVsbC5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9udm1lL2h3L3FlZG4vcWVk
bi5oICAgICAgfCAgMTUgKysrKysKPiA+ICAgZHJpdmVycy9udm1lL2h3L3FlZG4vcWVkbl9tYWlu
LmMgfCAxMDggKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+ID4gICAyIGZpbGVzIGNo
YW5nZWQsIDEyMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCj4gPgo+IFJldmlld2VkLWJ5
OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVAc3VzZS5kZT4KClRoYW5rcy4KCj4KPiBDaGVlcnMsCj4K
PiBIYW5uZXMKPiAtLQo+IERyLiBIYW5uZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVs
IFN0b3JhZ2UgQXJjaGl0ZWN0Cj4gaGFyZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgKPiBTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBN
YXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xybmJlcmcKPiBIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyks
IEdlc2Now6RmdHNmw7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0Ckxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

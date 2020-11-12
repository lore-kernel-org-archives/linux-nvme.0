Return-Path: <SRS0=6u0/=ES=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC33C2D0A3
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 06:54:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE1B208FE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2020 06:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HexHM4eH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="EWhVHCWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE1B208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:In-Reply-To:References:Message-Id:Date:Subject:
	Mime-Version:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GUO2a43qSZQqbtDUOTruFLYNnsPHSk0+tvFfaI1/ZRQ=; b=HexHM4eH1DhwJKl60mK1oXlTD
	xw9onY3+xhpmLpbWHKeyYuke1uVMFUrx2r71Km1H2Np7fGeTwxvrXLif8wBdx9njBe7o/6/k9+PHx
	CNMyuvMW4ScpGKWxwFJwby64TH8SYJ3xNcTz7HER2bEFF7hpPgqjBHfYUKAQx0ytlN8hhdCYhev98
	EcgAdG7BVH9Smnv0NNBPx4sXs6Ru0NNzhIxJfNaBj8pPgwAGR0cHtGWFS4IgaJ+wnc/nYQdeOYA2B
	42yHZfvq/Lt3985KyGS5wb2qMf/xl7e3SaQGWIFoy5nObfjjifR5532ZnldFtsiJEa1DCmnuoOjR1
	ELcyBqOfw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kd6Uk-0003PS-Db; Thu, 12 Nov 2020 06:54:10 +0000
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kd6Ue-0003Oh-Ud
 for linux-nvme@lists.infradead.org; Thu, 12 Nov 2020 06:54:05 +0000
Received: by mail-lj1-x232.google.com with SMTP id i17so3782241ljd.3
 for <linux-nvme@lists.infradead.org>; Wed, 11 Nov 2020 22:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=jyRvIdgyGAjWDq5W0K1ksXVJK+gQp1v4Z+e6lQNh9W4=;
 b=EWhVHCWXmLiHsu0sT9VgjKIQLetXybwhvIk+GYPJAi46dOA5q9cfswM727cThj0AHk
 +GjNmz/3sKj1D4AWB66dZa9ZjchhO+5U7Viy3G93v6VznQ5UHOhOMZogLFZvjAfZQZCk
 gmGmKsfNlOO0H8hX6u0UETqwxi65Yvh+PcFKUblekKaKHTxIqn8li8wVOCJKjjQ7nbt5
 AAHi70MWJApfJ4Pxodg7rrHSwQrk7PLTHZ+kiKTfhn4XCdv+ca8YyKP6I99dJjh9Sn39
 mW3sAC+fmWksUt2AWrKDKm2e1n3q/MXRU4d8jdhPwPFDH6DOabDieUg8plUZx+XkSodP
 e+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=jyRvIdgyGAjWDq5W0K1ksXVJK+gQp1v4Z+e6lQNh9W4=;
 b=jhTebnmHzokh4RA1vuRndWC45lJ2TGVdBS4ijd5NjgZoKDw227djIG9N9DNC0l4GJw
 7YMKAcM5YM5x4HmDI16AaeCanfZ6etVdojNDzxpJiXuA4bfhR1NPpWNGRBIlDFKd21Sv
 IK7jZ/x3hA4DFy9Z37ZEhNkAK6MD7gH05SrPj5v6euqpMOK62aNGM4NNeZI+g8TQQ4K6
 P9MuBlFD2KCCx+QtsSLhLAeJVn2WSvWLekiSSXxjzOLwvE1Z+Cjs9Q12RU4JEzdC/21a
 Cs4uqFmGSS36pwSGTzY5PizIlW7bSHN2fg/rFeJZuyidlRevI9KEwsK4ClbSrqCvrrp3
 N4og==
X-Gm-Message-State: AOAM533dhRxwR9zRn08VhZWeMLIl1Ht+YETHOIYa6mG5LCtLzYBhE1SV
 3QIJx75gtYE30XPtqP3jclysJg==
X-Google-Smtp-Source: ABdhPJxoE/WpHD4Hd69MvP0MpCUmik3AYwC2Pxu73yIXTy36mashD+1FV3Q3+u84EgwB606+fRcLhw==
X-Received: by 2002:a2e:9988:: with SMTP id w8mr11162295lji.107.1605164042855; 
 Wed, 11 Nov 2020 22:54:02 -0800 (PST)
Received: from ?IPv6:2a02:aa7:4008:7a47:dd24:ebba:eb9c:4d77?
 ([2a02:aa7:4008:7a47:dd24:ebba:eb9c:4d77])
 by smtp.gmail.com with ESMTPSA id v1sm454368lfp.305.2020.11.11.22.54.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Nov 2020 22:54:02 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] nvme: remove unnecessary return values
Date: Thu, 12 Nov 2020 07:54:01 +0100
Message-Id: <5F62C483-424C-47D8-AFC9-B6B28B2C4D54@javigon.com>
References: <BYAPR04MB4965213DB3D1F07B7B75B92586E70@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965213DB3D1F07B7B75B92586E70@BYAPR04MB4965.namprd04.prod.outlook.com>
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
X-Mailer: iPhone Mail (18A8395)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201112_015405_152858_2CDEFBB3 
X-CRM114-Status: GOOD (  10.47  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, kbusch@kernel.org,
 =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gT24gMTIgTm92IDIwMjAsIGF0IDA1LjExLCBDaGFpdGFueWEgS3Vsa2FybmkgPENoYWl0YW55
YS5LdWxrYXJuaUB3ZGMuY29tPiB3cm90ZToKPiAKPiDvu79PbiAxMS8xMS8yMCAxMjoxMCwgamF2
aWVyQGphdmlnb24uY29tIHdyb3RlOgo+PiBGcm9tOiBKYXZpZXIgR29uesOhbGV6IDxqYXZpZXIu
Z29uekBzYW1zdW5nLmNvbT4KPj4gCj4+IENsZWFudXAgdW5uZWNlc3NhcnkgcmV0IHZhbHVlcyB0
aGF0IGFyZSBub3QgY2hlY2tlZCBvciB1c2VkIGluCj4+IG52bWVfYWxsb2NfbnMoKQo+PiAKPj4g
U2lnbmVkLW9mZi1ieTogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyCj4gCj4gVGhlIHJldCB2YWx1
ZSBwYXR0ZXJuIGlzIHVzZWQgdG8gYXZvaWQgdGhlIGNhbGxzIGluIHRoZSBpZiAoKSB3aGljaCBp
cwo+IAo+IG5vdCBjbGVhbiBiYXNlZCBvbiB0aGUgY29tbWVudHMgSSBoYWQgaW4gdGhlIHBhc3Qu
CgpUaGFua3MgZm9yIHRoZSBjb21tZW50IENoYWl0YW55YS4gSSB3YXMgd29ya2luZyBhcm91bmQg
dGhpcyBmdW5jdGlvbiBhbmQgVEJIIEkgaGF2ZSBuZXZlciB0aG91Z2h0IGFib3V0IGl0IHRoaXMg
d2F5LiAKCldpbGwgYWRkIGl0IHRvIHRoZSB0b29sYmVsdCB0aGVuLiAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0
CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

Return-Path: <SRS0=a62X=FU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D8FC4361B
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 08:02:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7B423343
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 08:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7B423343
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:In-Reply-To:References:Message-Id:Date:Subject:
	Mime-Version:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vFOMmU8BUyfcddEm25XN267FbcTiOhXB6bSg/wydiB8=; b=mJP1XJ6w65XQu6R8EVWrnUbGj
	PUxxFmBTlzddnMRhukCifms8MoD1ULqrsWNy+ydIPVoVQ4IoMM3vR6IeCifkvg3+w9GOg9YJR3yLH
	BUTEEEoNofQ1VkPz/HVeFY8Kbm/ppPVUSB6K9oOig/IA5izCGp+yiZKFXH8/kSx2nUELhLyeUdbgn
	PrzpuhxVpwq+OJTvqbi5whXp+ek3lJgq8s+5oUn0RovtiIVdWlwhoSPAUnfjJ+nzE4ivP7iLEleY6
	r0nACJ5Q3v9Be3J5cqxklKAM4kIRJQRBXBaQW5Sv5ayA5fVyKmLfKL5m9wb36qZiRsr4kP7GgqYtp
	W8IQQRmJQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpRl3-0002C0-6s; Wed, 16 Dec 2020 08:02:01 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpRkx-00029A-P8
 for linux-nvme@lists.infradead.org; Wed, 16 Dec 2020 08:01:58 +0000
Received: by mail-ej1-x62c.google.com with SMTP id g20so31408990ejb.1
 for <linux-nvme@lists.infradead.org>; Wed, 16 Dec 2020 00:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=qexlGjtoIwVVGu2gcy5iyB4/p0MInWb8FNAdG7CIFz0=;
 b=FzkVg7SEmZikOJZtEsNiU20maUGGW2yTUOOj/aFpWOkD6GNOtu1goDT3usVIbO2cah
 kFPjA0xXUf3Aw91n9DgZ5qRQuV1gRQ7vLdzLc6y7NCu0GUx3/xj/5PXRtZ8s7+7bFewn
 TO0dhXw0JnFndleQruE4ElNQxgtym5O8oTXxEWDnPjxvR0pyYRxrF6lndpmmv5wcBrZj
 12nkme1rPqieVgAFlTdwIkHDka3eFylY1MrKq17k/UkLgG3Tsd64mY4IfatDL6gWkrIz
 wjLSqC1rBi5cMUIVNNWfgjg23yl0NB9SPXWQ6g4gC3pZHPzswvqe3NPdziHH4dCC8sdf
 RG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=qexlGjtoIwVVGu2gcy5iyB4/p0MInWb8FNAdG7CIFz0=;
 b=ayRd+buRzbRD8/8l5GGRS9d3S+SP2aicPhZd2hETVZgN5toVPjoO/LmhfDYuqToLgw
 cquufu7parQh3lnV7X9/L/DtD/XfXkQiN3alzM059x/lo1chFS/Tq5RWNd93jsb69J81
 /N7/aNCrDlHYcKt+LaofDq1zhReYWS2J8KqbqEOQHoeiGPpw/kNthWhJctPr7mH4M+cb
 oyyWK8ucV6MF6kQF9PURVps2Sz4AEK0mcEbFuQ7LbQfAOJfWLpgC6pJIA7fGr7JMSm0p
 PDeqDQkAKRndb77JPYM9dWz4mbBPidy+8W621HubIyaA7ctc10fCIehE7MxAaHVVpYO1
 Cpcg==
X-Gm-Message-State: AOAM533LZDkuhdoLwL8J5WEfHYfMeKsNXZFrsOfvpEkJrHf/pmh+Y1Bc
 cOUCTBeWI3MVjpm44JILjGhj3g==
X-Google-Smtp-Source: ABdhPJy1RUHmsf1ghVRpsNs591H1tav5u9Qn+KoHyglJ5hqAyGstsoI2/tmACf65vTzmXKZ+PhalZg==
X-Received: by 2002:a17:906:7243:: with SMTP id
 n3mr29031051ejk.246.1608105712954; 
 Wed, 16 Dec 2020 00:01:52 -0800 (PST)
Received: from [192.168.10.21] (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id v18sm798630ejw.18.2020.12.16.00.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Dec 2020 00:01:52 -0800 (PST)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V3] nvme: enable char device per namespace
Date: Wed, 16 Dec 2020 09:01:51 +0100
Message-Id: <10318EDE-F4D0-4C89-B69D-3D5ACA4308C2@javigon.com>
References: <20201215224607.GB3915989@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20201215224607.GB3915989@dhcp-10-100-145-180.wdc.com>
To: Keith Busch <kbusch@kernel.org>
X-Mailer: iPhone Mail (18B92)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201216_030155_955833_2B762EA2 
X-CRM114-Status: GOOD (  12.59  )
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
 linux-block@vger.kernel.org, minwoo.im.dev@gmail.com,
 =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier.gonz@samsung.com>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gT24gMTUgRGVjIDIwMjAsIGF0IDIzLjQ2LCBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5v
cmc+IHdyb3RlOgo+IAo+IO+7v09uIFR1ZSwgRGVjIDE1LCAyMDIwIGF0IDA4OjU1OjU3UE0gKzAx
MDAsIGphdmllckBqYXZpZ29uLmNvbSB3cm90ZToKPj4gK3N0YXRpYyBpbnQgbnZtZV9hbGxvY19j
aGFyZGV2X25zKHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIHN0cnVjdCBudm1lX25zICpucykKPj4g
K3sKPj4gKyAgICBjaGFyIGNkaXNrX25hbWVbRElTS19OQU1FX0xFTl07Cj4+ICsgICAgaW50IHJl
dDsKPj4gKwo+PiArICAgIGRldmljZV9pbml0aWFsaXplKCZucy0+Y2Rldl9kZXZpY2UpOwo+PiAr
ICAgIG5zLT5jZGV2X2RldmljZS5kZXZ0ID0gTUtERVYoTUFKT1IobnZtZV9uc19iYXNlX2Nocl9k
ZXZ0KSwKPj4gKyAgICAgICAgICAgICAgICAgICAgIG5zLT5oZWFkLT5pbnN0YW5jZSk7Cj4gCj4g
QWgsIEkgc2VlIG5vdy4gV2UgYXJlIG1ha2luZyB0aGVzZSBnZW5lcmljIGhhbmRsZXMgZm9yIGVh
Y2ggcGF0aCwgYnV0Cj4gdGhlIG5zLT5oZWFkLT5pbnN0YW5jZSBpcyB0aGUgc2FtZSBmb3IgYWxs
IHBhdGhzIHRvIGEgbmFtZXNwYWNlLCBzbyBpdCdzCj4gbm90IHVuaXF1ZSBmb3IgdGhhdC4gRnVy
dGhlciwgdGhhdCBoZWFkLT5pbnN0YW5jZSBpcyBhbGxvY2F0ZWQgcGVyCj4gc3Vic3lzdGVtLCBz
byBpdCdzIG5vdCB1bmlxdWUgZnJvbSBuYW1lc3BhY2UgaGVhZHMgc2VlbiBpbiBvdGhlcgo+IHN1
YnN5c3RlbXMuCj4gCj4gU28sIEkgdGhpbmsgeW91IG5lZWQgdG8gYWxsb2NhdGUgYSBuZXcgZGV2
X3QgZm9yIGVhY2ggc3Vic3lzdGVtIHJhdGhlcgo+IHRoYW4gdGhlIGdsb2JhbCBudm1lX25zX2Jh
c2VfY2hyX2RldnQsIGFuZCBJIGd1ZXNzIHdlIGFsc28gbmVlZCBhIG5ldwo+IG52bWVfbnMgaW5z
dGFuY2UgZmllbGQgYXNzaWduZWQgZnJvbSB5ZXQgYW5vdGhlciBpZGE/CgpPay4gSeKAmWxsIGxv
b2sgaW50byBpdC4gCgpUaGFua3MhCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK

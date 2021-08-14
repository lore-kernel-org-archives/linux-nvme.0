Return-Path: <SRS0=EXTw=NF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230D0C4338F
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Aug 2021 20:42:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B113F60EB5
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Aug 2021 20:42:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B113F60EB5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:In-Reply-To:Cc:References:Message-Id
	:Date:Subject:Mime-Version:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7AmEI38l5cF29tUIFPaSy4ulLYpg4bmPuULt/iQ9kcc=; b=CHRqP+lyXQwAIR
	UYVkbbfqE/e81LN4nDpHBeREmKSruDAROUba7ZAG5sszpcOE0SoF92IPakcdiGRJ2qmcpt+evuGkw
	+LmdKReegZdjmog66pr9OOWzJHXuHEcBtur4etyVxZRcU1Y7Tp77kjYKSBoRwzL+PJMoQiiXyFtRu
	2OQkFaHN54WuZ7IzsQV3ku6QdT6iBlk8xasAEiWiG5jLWtAgQc/QsEYU+xu1kQW6dTQXuSXOEjZ8Y
	2oMxWYTbnoh5nuMfPifL/GMovOPFMYZ4dzvZDvoo86d5p4GOJ4NKaTP+tPdvxB/UP9kQQJ5zg8W6g
	s651JuW5nkBIXQlMzCaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mF0UC-00EZxW-KD; Sat, 14 Aug 2021 20:42:32 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mF0U9-00EZwN-A0
 for linux-nvme@lists.infradead.org; Sat, 14 Aug 2021 20:42:30 +0000
Received: by mail-ed1-x534.google.com with SMTP id v2so10076991edq.10
 for <linux-nvme@lists.infradead.org>; Sat, 14 Aug 2021 13:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=yNzjxSfnVSUDSGUY1rHTEQ9gqqafkCS75FpW05fDG6g=;
 b=aIQFsNMKSxQ5tem4VTSQs7xseHym013YLoVCgIvyc/0xD8c3vpYQOOZa6ywj5kZIQt
 XSMqx+JQIPMhXQP0gy7ykQ42Q6plgPccIH+cHoyHiC3YBvlTQhQrDTmPAfST7YArRwQs
 0AqUuS8PmgU0UL3BIZSW1Woro5wA3BSL7vZ4TK+InRkh8npiDNO8P2GQLUiIyYx7srAN
 Gol6t6s2pp78wEOfHaE+KWmrk0i3IdMkJNDjkZW5qywhkWO0v41dcyRYuHA26ubwBYk3
 g3lY8TIAZYUAmNb/x0as1Sb435dG8TeQPPFh2iVWlBO7/1vYsLZjGoc74FjTMJdUnYY4
 hh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=yNzjxSfnVSUDSGUY1rHTEQ9gqqafkCS75FpW05fDG6g=;
 b=i/hX980uKbRyCOnniH8QTweYxExC+Yq2I8e6hDwJAQi63g79Tzbe5OlaAT/FM/KmZ9
 lb+nIUL5N5m5odl582NRCTwbbGgW1Ycxg5TF/EF0fGtUcmPplxa1L1KN4l53d5sIGQn6
 sa0oM837QKnJuwb20C4XMEwdit6+CN1f82sZUllJW53ZiRwdEPhk9VS3Hn7h5STscWuZ
 6sROrxHN/9Z85GJXnIjchpG29dopVQV6CnG2ghG/tiL07PuBlVdaTnCa9fyA5eaLty6c
 LDBoXzxvve4YG191zzZ6XZ/oGiBo4z3aUhuePFD/hOaZ/MDQ9q8gEZ+VO28h/KGyqq6a
 qbyQ==
X-Gm-Message-State: AOAM531YVz0T0lRlFeFBArVGivPKzBh5WG9FNlqcv0//GNf8nTBVh9xw
 OY7EzQX9EEcpSTv8XemV6ODjcA==
X-Google-Smtp-Source: ABdhPJzTvddzsELNhz8McEhEGjR1s3BDpCyEOiQEwyuJ81VGNo1ZP2Hk/arY/AgqQHIc51yajHpm6A==
X-Received: by 2002:a05:6402:27d1:: with SMTP id
 c17mr10762249ede.178.1628973746133; 
 Sat, 14 Aug 2021 13:42:26 -0700 (PDT)
Received: from smtpclient.apple (5.186.124.144.cgn.fibianet.dk.
 [5.186.124.144])
 by smtp.gmail.com with ESMTPSA id v1sm2123489ejd.31.2021.08.14.13.42.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Aug 2021 13:42:25 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] remove the lightnvm subsystem
Date: Sat, 14 Aug 2021 22:42:25 +0200
Message-Id: <52C4BBAD-21CE-4CD2-8B21-90ACEB4E4B01@javigon.com>
References: <512bf4a4-fc60-36d0-adae-93caaf0441d2@kernel.dk>
Cc: =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
In-Reply-To: <512bf4a4-fc60-36d0-adae-93caaf0441d2@kernel.dk>
To: Jens Axboe <axboe@kernel.dk>
X-Mailer: iPhone Mail (18G82)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210814_134229_475021_B9FB9ACF 
X-CRM114-Status: GOOD (  10.35  )
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

Cj4gT24gMTQgQXVnIDIwMjEsIGF0IDIxLjMwLCBKZW5zIEF4Ym9lIDxheGJvZUBrZXJuZWwuZGs+
IHdyb3RlOgo+IAo+IO+7v09uIDgvMTQvMjEgMTowMSBQTSwgTWF0aWFzIEJqw7hybGluZyB3cm90
ZToKPj4gVGhhbmtzLCBDaHJpc3RvcGguCj4+IAo+PiBSZXZpZXdlZC1ieTogTWF0aWFzIEJqw7hy
bGluZyA8bWJAbGlnaHRudm0uaW8+Cj4+IAo+PiBKYXZpZXIsIGlmIHlvdSBhZ3JlZSB0byB0aGUg
cmVtb3ZhbCBvZiB0aGUgc3Vic3lzdGVtLCB3b3VsZCB5b3UgbGlrZSB0byAKPj4gcHJvdmlkZSB5
b3VyIHJldmlld2VkLWJ5IGFzIHdlbGw/IFRoYW5rcyEKPiAKPiBTaWRlIGJhciAtIHBsZWFzZSBk
b24ndCBxdW90ZSA0MDBrIG9mIHRleHQsIHRoaXMgcmVwbHkgcmVhbGx5IGRpZG4ndAo+IG5lZWQg
YW55IG9mIGl0Lgo+IAo+IFBldCBwZWV2ZSBvZiBtaW5lLCBhbmQgaXQgaGFwcGVucyB3YXkgdG9v
IG9mdGVuIG9uIHJldmlld3MgYXMgd2VsbC4KPiBEb24ndCBxdW90ZSB0aGUgd2hvbGUgZW1haWwg
anVzdCB0byBhZGQgUmV2aWV3ZWQvQWNrZWQtYnksIGl0J3MganVzdAo+IHdhc3RlZnVsLgo+IAo+
IC0tIAo+IEplbnMgQXhib2UKCkxvb2tzIGdvb2QgdG8gbWUuIAoKUmV2aWV3ZWQtYnk6IEphdmll
ciBHb256w6FsZXogPGphdmllckBqYXZpZ29uLmNvbT4KX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZt
ZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtbnZtZQo=

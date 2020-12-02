Return-Path: <SRS0=R6Dd=FG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C915C64E90
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 03:01:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7E92158C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Dec 2020 03:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7E92158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=n06xkQ8N36sQW3aAWJVLBLdY9WmcJVWQUwYowTnrMKw=; b=Io/dsSAY/lR71zHLpc9FMW/7b
	hlT6hzPT5qKoyxXsCsI8LHAR82t4JogLNwIJgV/aYmexQLcpzmntB+DIvUS3NCbmkAncxGNvLpCEz
	CGarb6YICn9L82pcPC3JND9ZxSUL2DaGEAGtWxeoLNkFx9vElchwEm/HXzShjPrWw9fnSFMye5254
	vFSlqSuBhWrjFMDDzbRss/KuURUkxiysGfQwrUX+m5IUuEa3YvEfsqpCyC1LJeX22NKfH3PuYL0ar
	bbukDKA4NeJk0ob1+7x2pQS09l1RJ0dO8AoW0FZGPLD07to06WX9tCbtdv/7QiAa1elGxM0VhelGT
	fGrhSYi/w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kkIO0-0007d1-UX; Wed, 02 Dec 2020 03:00:57 +0000
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kkINx-0007by-MV
 for linux-nvme@lists.infradead.org; Wed, 02 Dec 2020 03:00:54 +0000
Received: by mail-pj1-x1043.google.com with SMTP id r9so160160pjl.5
 for <linux-nvme@lists.infradead.org>; Tue, 01 Dec 2020 19:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=/5Lv3JwIVKjzrJbbwScz5WzG676sOc/sz1xTytGy+Yw=;
 b=Mj2JWY0MFovy7h5MgRizMg6MKfB8srtPZE230QpQnYQfYfQFnPFTOew3tmadbP0oAL
 zdYdAbiNTZ15sXGZc5rglJXlONQOO1bmzE+syceJWc29Qg7dWP/tBUJj8pSUyDb61M6k
 dzvVrxzdwfQt6abY+zcHTR38u+8+bqYcfOxSgPJH70XLFgNn2zKr72A+3M6MMhIlLkNG
 Fz4n29Jr2VAC2D46DaijbPbb5L0yyAvFrAO2HnF5rhW4RkXHik/0Qzax4tMT3+Ia0WiY
 /T7TKM9NOlcGAjNXnbCh1YMT53zWtjMiYJVHGgAAXOTs4WbC+/DKJLYMXlU7F/b5ABFb
 UzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=/5Lv3JwIVKjzrJbbwScz5WzG676sOc/sz1xTytGy+Yw=;
 b=djFQG/PnDUhgnKaHJpRyRG83fHHaLtwXPPTq0BVfiRGbPfUGwRHV+2ZDjTLQOEyxlW
 LNwlGDyeFtxkTAennFDiZGnwQpBiEO0Dsig2TqDafGnF25QjUKA+VAMG7QPs0pkajyUP
 Q1LZ5HkhQ/TR0hZ3vBGydeWkGUzIgoj0dA2giRn6cqJJpa7Ob0J1iXVyzQmcoRTO9pR5
 +Zb3x3+MdHFtqu4rmYXTqZX1i9W6x3ib9bwGI9r/uv+QKjDJ3SQf5RTHyCePz/cSquQb
 YL99duwkEmARQ5cYipUSM2InVfpk9z7Tw00qTQbttylpbope0+qfJJZqqI+ehIVBuvMp
 TW9g==
X-Gm-Message-State: AOAM532NshKnR0GiFs3BsREXjDCGwhixB2ZcOIsGf5LSDfnwk+EokjMs
 tKozPt9PKcabRLoh/G7kKWA=
X-Google-Smtp-Source: ABdhPJynql1L8+QnTkG/5pZk0rfQUmeQ+x72YzKhV5F10/wiR7nwx+Wzhtg4g6ac7G+BMgMpKDBbUQ==
X-Received: by 2002:a17:902:758c:b029:da:a6e1:e06 with SMTP id
 j12-20020a170902758cb02900daa6e10e06mr552623pll.67.1606878046242; 
 Tue, 01 Dec 2020 19:00:46 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id w2sm286265pfb.104.2020.12.01.19.00.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 01 Dec 2020 19:00:45 -0800 (PST)
Date: Wed, 2 Dec 2020 12:00:43 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 4/4] nvme: enable char device per namespace
Message-ID: <20201202030043.GA21178@localhost.localdomain>
References: <20201201125610.17138-1-javier.gonz@samsung.com>
 <20201201125610.17138-5-javier.gonz@samsung.com>
 <CGME20201201140354eucas1p1940891b47ca0c03ea46603393c844f61@eucas1p1.samsung.com>
 <20201201140348.GA5138@localhost.localdomain>
 <20201201185732.unlurqed2kaqwjsb@MacBook-Pro.localdomain>
 <20201201193002.GB27728@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201201193002.GB27728@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201201_220053_817454_4715FF49 
X-CRM114-Status: GOOD (  19.63  )
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
Cc: linux-block@vger.kernel.org,
 Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjAtMTItMDIgMDQ6MzA6MDIsIEtlaXRoIEJ1c2NoIHdyb3RlOgo+IE9uIFR1ZSwgRGVjIDAx
LCAyMDIwIGF0IDA3OjU3OjMyUE0gKzAxMDAsIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4gPiBP
biAwMS4xMi4yMDIwIDIzOjAzLCBNaW53b28gSW0gd3JvdGU6Cj4gPiA+ID4gKwo+ID4gPiA+ICsJ
ZGV2aWNlX2luaXRpYWxpemUoJm5zLT5jZGV2X2RldmljZSk7Cj4gPiA+ID4gKwlucy0+Y2Rldl9k
ZXZpY2UuZGV2dCA9IE1LREVWKE1BSk9SKG52bWVfbnNfYmFzZV9jaHJfZGV2dCksCj4gPiA+ID4g
KwkJCQkgICAgIG5zLT5oZWFkLT5pbnN0YW5jZSk7Cj4gPiA+ID4gKwlucy0+Y2Rldl9kZXZpY2Uu
Y2xhc3MgPSBudm1lX25zX2NsYXNzOwo+ID4gPiA+ICsJbnMtPmNkZXZfZGV2aWNlLnBhcmVudCA9
IGN0cmwtPmRldmljZTsKPiA+ID4gPiArCW5zLT5jZGV2X2RldmljZS5ncm91cHMgPSBudm1lX25z
X2NoYXJfaWRfYXR0cl9ncm91cHM7Cj4gPiA+ID4gKwlkZXZfc2V0X2RydmRhdGEoJm5zLT5jZGV2
X2RldmljZSwgbnMpOwo+ID4gPiA+ICsKPiA+ID4gPiArCXNwcmludGYoY2Rpc2tfbmFtZSwgIm52
bWUlZGMlZG4lZCIsIGN0cmwtPnN1YnN5cy0+aW5zdGFuY2UsCj4gPiA+ID4gKwkJCWN0cmwtPmlu
c3RhbmNlLCBucy0+aGVhZC0+aW5zdGFuY2UpOwo+ID4gPiAKPiA+ID4gSW4gbXVsdGktcGF0aCwg
cHJpdmF0ZSBuYW1lc3BhY2VzIGZvciBhIGhlYWQgYXJlIG5vdCBpbiAvZGV2LCBzbyBJIGRvbid0
Cj4gPiA+IHRoaW5rIHRoaXMgd2lsbCBodXJ0IHByaXZhdGUgbmFtZXNwYWNlcyAoZS5nLiwgbnZt
ZTBjMG4xKSwgQnV0IGl0IGxvb2tzCj4gPiA+IGxpa2UgaXQgd2lsbCBtYWtlIGEgbGl0dGxlIGJp
dCBjb25mdXNpb25zIGJldHdlZW4gY2hhcmRldiBhbmQgaGlkZGVuIGJsa2Rldi4KPiA+ID4gCj4g
PiA+IEkgZG9uJ3QgYWdhaW5zdCB0byB1cGRhdGUgbnZtZS1jbGkgdGhpbmdzIGFsc28gZXZlbiBu
YW1pbmcgY29udmVudGlvbnMgYXJlCj4gPiA+IGdvaW5nIHRvIGJlY29tZSBkaWZmZXJlbnQgdGhh
biBudm1lWGNZblouCj4gPiAKPiA+IEFncmVlLiBCdXQgYXMgSSB1bmRlcnN0YW5kIGl0LCBLZWl0
aCBoYWQgYSBnb29kIGFyZ3VtZW50IHRvIGtlZXAgbmFtZXMKPiA+IGFsaWduZWQgd2l0aCB0aGUg
aGlkZGVuIGJkZXYuIAo+IAo+IE15IHN1Z2dlc3RlZCBuYW1pbmcgbWFrZXMgaXQgYXMgb2J2aW91
cyBhcyBwb3NzaWJsZSB0aGF0IHRoZSBjaGFyYWN0ZXIKPiBkZXZpY2UgaW4gL2Rldi8gYW5kIHRo
ZSBoaWRkZW4gYmxvY2sgZGV2aWNlIGluIC9zeXMvIGFyZSByZWZlcnJpbmcgdG8KPiB0aGUgc2Ft
ZSB0aGluZy4gV2hhdCBpcyBjb25mdXNpbmcgYWJvdXQgdGhhdD8KCkkgbWVhbnQgdGhhdCBzb21l
b25lIG1pZ2h0IG1pc3VuZGVyc3RhbmQgdGh0IC9kZXYvbnZtZVhjWW5aIGlzIGFsc28gYQpibGtk
ZXYganVzdCBsaWtlIC9kZXYvbnZtZVhuWS4gIEknbSBqdXN0IHNheWluZyBpdCBtaWdodCBiZSwg
YnV0IEknbQpmaW5lIHdpdGggc3VnZ2VzdGVkIG5hbWluZyBhcyB0aG9zZSB0d28gYXJlIGluZGlj
YXRpbmcgYSBzaW5nbGUKY29uY2VwdCAobmFtZXNwYWNlKS4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4
LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

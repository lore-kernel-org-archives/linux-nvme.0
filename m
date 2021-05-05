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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA8DC433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 18:08:23 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95D1F611ED
	for <linux-nvme@archiver.kernel.org>; Wed,  5 May 2021 18:08:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95D1F611ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6mLuUY+Q1IHbB/z0nHdq7qYeEQp/lJE48UKvR66oA4c=; b=Pgwr5m/qscCXSW6qGdIO0zJu5
	YTJ2CijstG8HxnrCwi0w4CSnOq8nyY47W/ISBWAfb/WEHT07dX3WEBttFRssABxcOo6JOgXdf4swL
	A7YzhJIwXTPtClgilyrQyFtiBcPVR+uVsZY5WykygOL/aI6pwmKe/6v84GaQx2uczX3JfrsiGkwsK
	Y+9lNXiipGbSNWpY1Pj2JB1M+EIEnSEwn0CSLHHhz6FsJ09yUAUAqZvcV7Q0Aoi2dzWkwFwxI1hwv
	/XLmE0dVyHeXjTb2T0fCSKWE0wtYAJk5GPmc+wI7fngInPachOzm6JczcSSQE7kNXT84X7zeYLrbd
	zNwNqdhGw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leLwX-001zAf-6M; Wed, 05 May 2021 18:08:17 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leLwV-001zAM-3u
 for linux-nvme@desiato.infradead.org; Wed, 05 May 2021 18:08:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-ID:Content-Description;
 bh=OyHHxl0o1nlSGoKlMC7YvjTbD4roq+ar0grvpcjq3pc=; b=y2UNgFrgC2GtELmy6wJ1sahKzO
 NsZNrWp5RDK2K+Mu7WX8sFbe03xvYSOFNMsGjLJl5BN0nyuiENYBcGY2lTbo1s7qesYeffv1mN5jd
 uiSsVOeGoNECUka3bWJL6q+vpvDnARjefnzTd3K5afMFolyDBKtKC1skehriiD9FG4gi/AFrqD0Mw
 OAksR/ZIvarcRPZLI4qlPUccRqNQroV+QE6f6xp6UO1OIgQyJaGHBk56pF5146OSpUy1YLSyC/kZs
 EB5KR3kBxg14vnnai1KAELcxBc009Fu9rVdhpVpzbO0IkAZdrUaO0jbd7edXY915yK1NiZXa4jY4H
 j+wx6a+Q==;
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leLwS-0057vT-Ie
 for linux-nvme@lists.infradead.org; Wed, 05 May 2021 18:08:13 +0000
Received: by mail-ed1-x52c.google.com with SMTP id c22so3105967edn.7
 for <linux-nvme@lists.infradead.org>; Wed, 05 May 2021 11:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OyHHxl0o1nlSGoKlMC7YvjTbD4roq+ar0grvpcjq3pc=;
 b=LvJNEcAzr0JD6rg5e0Mm3LWsqXXeG6sLPhjCD2Ty7sWfLEmqL9AZ/SsLWbOQ4Ttv/7
 X12liaUy5vg4AWK5DB7MEB8xemMfZqLodiW8gAIs4g+lYaXLjijexGn7r2/Oa/lyktad
 0zufw1M2T9ircbE3sMAe3ehneOg8iVm4+kdZ29k7cEfuTrmBTHnC6Aebb9ecWoWEV2I2
 YTEHMiMWytRNZOzKGO6rRwzVXAnDetpVwYr10DFtTa0IMMbmzNg3F5i3evTmc0+h3Q/V
 X/XuJePgDqpoDwr5lJkDkHVBP4YBlB4a0AgYKhE2i64lWV2DD2CkG6MwU98cGMg9g2DG
 m2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OyHHxl0o1nlSGoKlMC7YvjTbD4roq+ar0grvpcjq3pc=;
 b=QZcbXHuwcvDa/rtHTreFX90imj1ufpdTOdlnQHGVM4U1JcYCdjYd7fTd46E3+h6Bg5
 bE32VXTWUlidF1YSk/El7DDD9dM8TASCy/Tu+89YEim4BzXH/Do+5snPWx47mtPrJ3Iv
 VAZeFtphp5RApikGngYmhZdrKlKrLoCZKM/gZJQoWuz+CesmxNp8DHH5qLIEvzizZpMq
 GQNyiNJszh03cS81aEjfisIxu3X3ZtPcrXJhCHhszX1Yf1eu4JspL+ekrerfgSzXKUQw
 naIrR+3SpgeEuJDIm7nOlElBAbGHUseWOE1I8rx42yt+svaXqWMKHmI+oQHvDWZWByzN
 vkIw==
X-Gm-Message-State: AOAM530CFmsTK2/UG9IMPDE7oeo4UDt7CN0b688YbJHDE4m4SBFEpAG7
 7vePzzFKvMqFo8N6OQ8rlFfU6f+IuijvfhKw5dA=
X-Google-Smtp-Source: ABdhPJwNYbGv3u7Pqx1HkdhKedggZGzpUWGhLgMdWw5iKWKrRQUFA1cH/w16fWU1KvilaMmx3ilmaSrDMUwNGhinAuw=
X-Received: by 2002:a05:6402:138f:: with SMTP id
 b15mr317279edv.121.1620238090990; 
 Wed, 05 May 2021 11:08:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210429190926.5086-1-smalin@marvell.com>
 <20210429190926.5086-28-smalin@marvell.com>
 <156b840a-2ea2-0b3b-1bf6-7869838fccbe@suse.de>
In-Reply-To: <156b840a-2ea2-0b3b-1bf6-7869838fccbe@suse.de>
From: Shai Malin <malin1024@gmail.com>
Date: Wed, 5 May 2021 21:08:00 +0300
Message-ID: <CAKKgK4yN7kfRrEEaBdMM5xxqtpahGP3611Hq6NJR0gojKBHmgw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 27/27] qedn: Add support of ASYNC
To: Hannes Reinecke <hare@suse.de>
Cc: Shai Malin <smalin@marvell.com>, netdev@vger.kernel.org,
 davem@davemloft.net, 
 kuba@kernel.org, linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de, 
 axboe@fb.com, kbusch@kernel.org, Ariel Elior <aelior@marvell.com>, 
 Michal Kalderon <mkalderon@marvell.com>, okulkarni@marvell.com,
 pkushwaha@marvell.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210505_110812_635385_43825CB6 
X-CRM114-Status: GOOD (  13.64  )
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

T24gNS8yLzIxIDI6NTkgUE0sIEhhbm5lcyBSZWluZWNrZSB3cm90ZToKPiBPbiA0LzI5LzIxIDk6
MDkgUE0sIFNoYWkgTWFsaW4gd3JvdGU6Cj4gPiBGcm9tOiBQcmFiaGFrYXIgS3VzaHdhaGEgPHBr
dXNod2FoYUBtYXJ2ZWxsLmNvbT4KPiA+Cj4gPiBUaGlzIHBhdGNoIGltcGxlbWVudCBBU1lOQyBy
ZXF1ZXN0IGFuZCByZXNwb25zZSBldmVudCBub3RpZmljYXRpb24KPiA+IGhhbmRsaW5nIGF0IHFl
ZG4gZHJpdmVyIGxldmVsLgo+ID4KPiA+IE5WTUUgT2ZsZCBsYXllcidzIEFTWU5DIHJlcXVlc3Qg
aXMgdHJlYXRlZCBzaW1pbGFyIHRvIHJlYWQgd2l0aAo+ID4gZmFrZSBDQ0NJRC4gVGhpcyBDQ0NJ
RCB1c2VkIHRvIHJvdXRlIEFTWU5DIG5vdGlmaWNhdGlvbiBiYWNrIHRvCj4gPiB0aGUgTlZNRSBv
ZmxkIGxheWVyLgo+ID4KPiA+IEFja2VkLWJ5OiBJZ29yIFJ1c3NraWtoIDxpcnVzc2tpa2hAbWFy
dmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBQcmFiaGFrYXIgS3VzaHdhaGEgPHBrdXNod2Fo
YUBtYXJ2ZWxsLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IE9ta2FyIEt1bGthcm5pIDxva3Vsa2Fy
bmlAbWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWwgS2FsZGVyb24gPG1rYWxk
ZXJvbkBtYXJ2ZWxsLmNvbT4KPiA+IFNpZ25lZC1vZmYtYnk6IEFyaWVsIEVsaW9yIDxhZWxpb3JA
bWFydmVsbC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGFpIE1hbGluIDxzbWFsaW5AbWFydmVs
bC5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy9udm1lL2h3L3FlZG4vcWVkbi5oICAgICAgfCAg
IDggKysKPiA+ICAgZHJpdmVycy9udm1lL2h3L3FlZG4vcWVkbl9tYWluLmMgfCAgIDEgKwo+ID4g
ICBkcml2ZXJzL252bWUvaHcvcWVkbi9xZWRuX3Rhc2suYyB8IDE1NiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tCj4gPiAgIDMgZmlsZXMgY2hhbmdlZCwgMTU2IGluc2VydGlvbnMoKyks
IDkgZGVsZXRpb25zKC0pCj4gPgo+IFJldmlld2VkLWJ5OiBIYW5uZXMgUmVpbmVja2UgPGhhcmVA
c3VzZS5kZT4KClRoYW5rcy4KCj4KPiBDaGVlcnMsCj4KPiBIYW5uZXMKPiAtLQo+IERyLiBIYW5u
ZXMgUmVpbmVja2UgICAgICAgICAgICAgICAgS2VybmVsIFN0b3JhZ2UgQXJjaGl0ZWN0Cj4gaGFy
ZUBzdXNlLmRlICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKzQ5IDkxMSA3NDA1MyA2ODgK
PiBTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHbWJILCBNYXhmZWxkc3RyLiA1LCA5MDQwOSBOw7xy
bmJlcmcKPiBIUkIgMzY4MDkgKEFHIE7DvHJuYmVyZyksIEdlc2Now6RmdHNmw7xocmVyOiBGZWxp
eCBJbWVuZMO2cmZmZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK

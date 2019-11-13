Return-Path: <SRS0=s2cI=ZF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39082C43331
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 12:58:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07D78222C6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2019 12:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LKUQ03NZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njckh+1M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D78222C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kLj+Quy50YVjC7ZZeeDYZQ1Pwr8gW4vqKqhePRbjNiY=; b=LKUQ03NZq4R4oP
	b060zfHvnrZf2fQgZyphl73U4ZSOuU2FlOf/vHqaqqgjrKmIut60aUUd4F9V7v/DKKjGyOb8Fr/MM
	HSwvvrebZT7Ll0O0jlSJmgTPVHKimtVq0GvyIwCsR1K3NkglbFPK79tdaj5T0kKYhPu04ahrKYZwl
	u+MAEaSVAGPbN8lj12LSPrvYjw2DppktZ7DhBR/usxHgP2rDwyAXAF7bC4PiWGtdWHzLPLIaKrg5A
	OMdQIMNKxNaiZIX0/65QW9IjeK0lzvtlg7lXPhOMeDYnzDH3FqKwDfpeDo8IO4T83moM0r2qvQ2RQ
	zLWNn+E5FaqWOr5E5uCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUsDz-0000UO-90; Wed, 13 Nov 2019 12:58:19 +0000
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUsDu-0000Ti-Nv
 for linux-nvme@lists.infradead.org; Wed, 13 Nov 2019 12:58:15 +0000
Received: by mail-lj1-x243.google.com with SMTP id n5so2441414ljc.9
 for <linux-nvme@lists.infradead.org>; Wed, 13 Nov 2019 04:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vgua7CPQ6DoU2gQQx1394j69/MTl73YCclHJSYqCl8I=;
 b=njckh+1MCFk3rOXgmP5NdQfWiJzezGiupKYm71jbFio6pZwHj8ysvNsDsDJ0kiboQT
 0BVn5P0sbtNTft55l/MuEqrzwMKTWI7J/gr6UvKl16mWG46Sy6KuQLCbpDaROg2VBzbu
 hVPEh2K7QsuexRRj2etiDD+ZMVpm9UyQZgPsZCoOgcwB1rRcNxueyPSutlRgpJ9NT7rt
 Z0LtnDoxLEEf7ItyXvUdumJuBqyMojnt3zAG3AxEIEXu9oy89IdMZK5nUKbmgNi/1dHk
 hsludrY9wYflZALdSUBggw6Bb4jTiDpEuB7ESEhcaRA+Ftl5Rs4nc9D5Wd4AXLYnG43r
 /L3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vgua7CPQ6DoU2gQQx1394j69/MTl73YCclHJSYqCl8I=;
 b=a5zg8X44M8Z9/r4t94N1Itd+HcgxlW61Fm1QzOV7NsXvFl6IcYElSR2Zm7upDNhtlH
 flxvVh3F6Bj0CeugvBSd506EO7cgpHvQv/4FYiArCQ9qq0dN1ORhHStzGD02UD2kwN3U
 D3m59z1t9ozvu8B2X7PvQB1/3PLoq+YT07lJ6DqOG2O3jRjUUBjafzwtv2iwaKbIFWLH
 6kIpdYwAUEpC5wA06BOALgqsiTYp9XkOY3PB9W4keqtWslJGOSp2HWq6iBVuvl7wwj+i
 rZI46UlOxlTKUC5VRMo6BaR/l7xaOzX/rol9QFwg4JI/ysjfJ7gE0myx9zIjV2b7seNl
 893A==
X-Gm-Message-State: APjAAAUsjMGos120hxmNOSV0F0bT7BIVb57EZzdXsVHhRrvLx/dUkT1Q
 K7aY5u4pery80mgKWboc6ugEQusmauP9ZqSIYzs=
X-Google-Smtp-Source: APXvYqzAKmoOlCuWhzIgX5ba3Kgl1IodyrNmydw0zoSAfXRTAjjTnbh0qkR2Jjl+VIRCNKMA0dR3zQj5sySwwQJBavc=
X-Received: by 2002:a2e:9083:: with SMTP id l3mr2609468ljg.127.1573649892396; 
 Wed, 13 Nov 2019 04:58:12 -0800 (PST)
MIME-Version: 1.0
References: <1573395466-19526-1-git-send-email-akinobu.mita@gmail.com>
 <20191111165306.GA19814@lst.de>
 <CAC5umyi97UJZzk+4soD+th0BZ71WfnOqnTWWuTYKyo6aWTdLXA@mail.gmail.com>
 <20191112142127.GA11580@lst.de>
 <CAC5umygX=uBQsWV8O=9NL3HeVNo_iMcq7BE-vA-wpQtyU5iV3Q@mail.gmail.com>
 <20191112163807.GB26911@roeck-us.net>
In-Reply-To: <20191112163807.GB26911@roeck-us.net>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 13 Nov 2019 21:58:01 +0900
Message-ID: <CAC5umyjVFRK+CfO=4FpzKUGyAaRVigj9NBoSazA6RV8AvhTbCw@mail.gmail.com>
Subject: Re: [PATCH] nvme: hwmon: provide temperature min and max values for
 each sensor
To: Guenter Roeck <linux@roeck-us.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191113_045814_803392_991866AD 
X-CRM114-Status: UNSURE (   7.60  )
X-CRM114-Notice: Please train this message.
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
Cc: linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

MjAxOeW5tDEx5pyIMTPml6Uo5rC0KSAxOjM4IEd1ZW50ZXIgUm9lY2sgPGxpbnV4QHJvZWNrLXVz
Lm5ldD46Cj4KPiBPbiBXZWQsIE5vdiAxMywgMjAxOSBhdCAxMjowMDoyMkFNICswOTAwLCBBa2lu
b2J1IE1pdGEgd3JvdGU6Cj4gPiAyMDE55bm0MTHmnIgxMuaXpSjngaspIDIzOjIxIENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAbHN0LmRlPjoKPiA+ID4KPiA+ID4gT24gVHVlLCBOb3YgMTIsIDIwMTkg
YXQgMTE6MTk6NDZQTSArMDkwMCwgQWtpbm9idSBNaXRhIHdyb3RlOgo+ID4gPiA+IE9LLiBJJ2xs
IGFkZCB0d28gbWFjcm9zLgo+ID4gPiA+Cj4gPiA+ID4gI2RlZmluZSBNSUxMSUNFTFNJVVNfVE9f
S0VMVklOKHQpICgodCkgLyAxMDAwICsgMjczKQo+Cj4gRElWX1JPVU5EX0NMT1NFU1QoKSA/CgpI
b3cgYWJvdXQgdGhlc2UgZGVmaW5pdGlvbnM/CgojZGVmaW5lIE1JTExJQ0VMU0lVU19UT19LRUxW
SU4odCkgRElWX1JPVU5EX0NMT1NFU1QoKHQpICsgMjczMTUwLCAxMDAwKQojZGVmaW5lIEtFTFZJ
Tl9UT19NSUxMSUNFTFNJVVModCkgKCh0KSAqIDEwMDBMIC0gMjczMTUwKQoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxp
c3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

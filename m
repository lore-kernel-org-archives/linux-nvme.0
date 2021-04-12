Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0E5C43460
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 11:21:10 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E3CC61289
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 11:21:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3CC61289
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=owltronix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=vOSRFqPO3/kIGXB2PgaiYcSg2oV4T3WXM9LUuwYFn7U=; b=BgVVT9allLpdSo3UMTC8mr2Q8
	psLW9l58uCV0pHdAumI3Uw7zMdX/Osr5HVaHUadaVLIN61IcyQ051XfmToTaocEzdVOjez6hARKmN
	CnINfb0A4RyF4CtAxfXX0r7z2sTPlELlB2wgXzNM8iU2e6ey2UmxXIHbS+oU4uM0TXpHtDAPclYV9
	ppUgFQ7BLW7N8l3tRP1dnJ445UdJ9LPX7mlrmwTZ363N3QN30w8drwkcZi5phov08LtMPW049iYJe
	v6SWXSAVO5fw0pMkwIwXcSh8bKHiQIGh0x10Gs5xbZBvF+vLp4mQcs6jU56VNnzRAMeZKReO1BxSQ
	n1Ig6e4SA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVucj-006Wug-9G; Mon, 12 Apr 2021 11:20:57 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVucC-006WXh-Vi
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 11:20:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-ID:Content-Description;
 bh=5YvfV6E8Wx2noDcxwD+O7Hq1kDhVwR0r8Nu0UCq0ACg=; b=ac+ADHl+g/rKPEqGgqIYJKAfzl
 yH8bnH+zUfqSamV46l2hH+Ex6Tv254oKVeQInIrucAcsJ+xhr9UTQ3OH0EnbOm49PnOw+n9VYZKHK
 QXMnNmvXnFT6mDHS3p7l3SiMUrkLexKnNMoXdp6REsJzU0q5I3SkpMsLjlTMHco8utiPfY1hVgTs7
 GYqM2Zo6B+SRUCDVNDoQ/OI5wLcLq6v5bgtduC7uKpDYNSlKcTp96jIei0jX4J9OrrP5K5WvwAvJ0
 xCvVWwRqD4uI5SQrr9v8vRjoo65bCN88OXnFWeXBvnYYsGBUE//VclcP7OxfpLrncnZ5blhbPztz7
 gYJ/eEYg==;
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVucA-006AQA-9N
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 11:20:23 +0000
Received: by mail-ej1-x634.google.com with SMTP id u17so19644234ejk.2
 for <linux-nvme@lists.infradead.org>; Mon, 12 Apr 2021 04:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=owltronix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5YvfV6E8Wx2noDcxwD+O7Hq1kDhVwR0r8Nu0UCq0ACg=;
 b=Gt34rsHWZ/A/px8rFTuSWwvvUS2D4NxnzfJeTJAfyzmlzvkVIWqBCLZbtip5ArrlJC
 HvRxhNf4ZkhUwXPlWlvwoDC1y7QI7OEF2H+9BmlRmAiHimvn819u1EzyXzq1NS+1n+DA
 98K43d0vzZPeqwij+phwk/6LB6GpAMiaoGN1w+iVxkGbOA0K1jXS1owe9K7FwOoGSK3p
 Cw/mDTux5f8rV1dKo7dvQi68hhc8qJUXyZoQ/uaahzMQ8I5cqWZy5oxBN82pYST/mgq5
 QRbzBO7GPVTBJpwTugh/DPoFr66Snfissvk5biLFpd7mBJfGxYE+9S0OaA8mCkBPkm9x
 HvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5YvfV6E8Wx2noDcxwD+O7Hq1kDhVwR0r8Nu0UCq0ACg=;
 b=TnJvmjpmX35tPXfd43aB4xW2uXBlh5nJGPevUBAXe9E+T3eSyA2F4ZcrJ2AO0qTVVo
 /Hle9RFUfeS5EwWcH/ipypeZ//npdJiqiMWzjAmD1h+wNKHMMAF5/ELb/Dd/m1qpQWte
 Nt0Yw3HZ1OucJQSGXfz/NYCW0iCjOjfBaUkiY3mJyYDL35qExHuqcwKsHGwdTjnaZcHJ
 ULXiZLxHNkICQqAUL62wOc+iVU55NLI/N2x+nZc6VvAUrdpg70brbvCVGzyJLnQTUkZp
 Cw6FAx6bgjuxXvlwjvPEOTU4PmSZRiCbFyHtmLGpKnq7EFz26U7nAN5ISaxrGhaNfMLA
 SOlg==
X-Gm-Message-State: AOAM530WsAe9dvKhi0W06wdu9YqnzsmH3C30tF1i+Ogn8h15S3T+Jz7V
 /ma4wiFW0aPRTLqgIWSwKvXIUsWKRIRbf0xwmbxeuw==
X-Google-Smtp-Source: ABdhPJy7+4R9+HiXT6JKGBoZfxRJ6PWlUoocdBengEkuRthOHwy8HX9XdN5XIzRS1SIGL+VyHWMV5OZRYVa7TGAefoE=
X-Received: by 2002:a17:907:d1b:: with SMTP id
 gn27mr26535092ejc.227.1618226418509; 
 Mon, 12 Apr 2021 04:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210412081257.2585860-1-hch@lst.de>
 <52ecf402-1361-e5a5-8c58-30d846d33541@lightnvm.io>
 <766257ca-4dd7-e20b-aa79-6ac3984567d4@lightnvm.io>
 <20210412094938.afyxzspcohw63zup@mpHalley.localdomain>
 <3bf88f25-d06d-5b95-7eff-dfb8f78bc389@lightnvm.io>
In-Reply-To: <3bf88f25-d06d-5b95-7eff-dfb8f78bc389@lightnvm.io>
From: Hans Holmberg <hans.ml.holmberg@owltronix.com>
Date: Mon, 12 Apr 2021 13:20:07 +0200
Message-ID: <CANr-nt0YpZ0CuREDu613LM7yBK_qgPfwg-bNU-T=2me5GJT=Gw@mail.gmail.com>
Subject: Re: [PATCH] lightnvm: deprecated OCSSD support and schedule it for
 removal in Linux 5.15
To: =?UTF-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>
Cc: =?UTF-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>, 
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_042022_353124_061C6EAA 
X-CRM114-Status: GOOD (  26.66  )
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

T24gTW9uLCBBcHIgMTIsIDIwMjEgYXQgMTI6MjAgUE0gTWF0aWFzIEJqw7hybGluZyA8bWJAbGln
aHRudm0uaW8+IHdyb3RlOgo+Cj4gT24gMTIvMDQvMjAyMSAxMS40OSwgSmF2aWVyIEdvbnrDoWxl
eiB3cm90ZToKPiA+IE9uIDEyLjA0LjIwMjEgMTE6MjYsIE1hdGlhcyBCasO4cmxpbmcgd3JvdGU6
Cj4gPj4gT24gMTIvMDQvMjAyMSAxMS4yMSwgTWF0aWFzIEJqw7hybGluZyB3cm90ZToKPiA+Pj4g
T24gMTIvMDQvMjAyMSAxMC4xMiwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gPj4+PiBMaWdo
dG52bSB3YXMgYW4gaW5ub3ZhdGl2ZSBpZGVhIHRvIGV4cG9zZSBtb3JlIGxvdy1sZXZlbCBjb250
cm9sCj4gPj4+PiBvdmVyIFNTRHMuCj4gPj4+PiBCdXQgaXQgZmFpbGVkIHRvIGdldCBwcm9wZXJs
eSBzdGFuZGFyZGl6ZWQgYW5kIHJlbWFpbnMgYQo+ID4+Pj4gbm9uLXN0YW5kYXJpemVkCj4gPj4+
PiBleHRlbnNpb24gdG8gTlZNZSB0aGF0IHJlcXVpcmVzIHZlbmRvciBzcGVjaWZpYyBxdWlya3Mg
Zm9yIGEgZmV3Cj4gPj4+PiBub3cgbW9zdGx5Cj4gPj4+PiBvYnNvbGV0ZSBTU0QgZGV2aWNlcy4g
IFRoZSBzdGFuZGFyZGl6ZWQgWk5TIGNvbW1hbmQgc2V0IGZvciBOVk1lCj4gPj4+PiBoYXMgdGFr
ZQo+ID4+Pj4gb3ZlciBhIGxvdCBvZiB0aGUgYXBwcm9hY2hlcyBhbmQgYWxsb3dzIGZvciBmdWxs
eSBzdGFuZGFyZGl6ZWQKPiA+Pj4+IG9wZXJhdGlvbi4KPiA+Pj4+Cj4gPj4+PiBSZW1vdmUgdGhl
IExpbnV4IGNvZGUgdG8gc3VwcG9ydCBvcGVuIGNoYW5uZWwgU1NEcyBhcyB0aGUgZmV3Cj4gPj4+
PiBwcm9kdWN0aW9uCj4gPj4+PiBkZXBsb3ltZW50cyBvZiB0aGUgYWJvdmUgbWVudGlvbmVkIFNT
RHMgYXJlIHVzaW5nIHVzZXJzcGFjZSBkcml2ZXIKPiA+Pj4+IHN0YWNrcwo+ID4+Pj4gaW5zdGVh
ZCBvZiB0aGUgZmFpcmx5IGxpbWl0ZWQgTGludXggc3VwcG9ydC4KPiA+Pj4+Cj4gPj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KPiA+Pj4+IC0tLQo+ID4+
Pj4gICBkcml2ZXJzL2xpZ2h0bnZtL0tjb25maWcgfCA0ICsrKy0KPiA+Pj4+ICAgZHJpdmVycy9s
aWdodG52bS9jb3JlLmMgIHwgMiArKwo+ID4+Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4+Pj4KPiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L2xpZ2h0bnZtL0tjb25maWcgYi9kcml2ZXJzL2xpZ2h0bnZtL0tjb25maWcKPiA+Pj4+IGluZGV4
IDRjMmNlMjEwYzEyMzdkLi4wNGNhYTBmMmQ0NDVjNyAxMDA2NDQKPiA+Pj4+IC0tLSBhL2RyaXZl
cnMvbGlnaHRudm0vS2NvbmZpZwo+ID4+Pj4gKysrIGIvZHJpdmVycy9saWdodG52bS9LY29uZmln
Cj4gPj4+PiBAQCAtNCw3ICs0LDcgQEAKPiA+Pj4+ICAgIwo+ID4+Pj4gICAgIG1lbnVjb25maWcg
TlZNCj4gPj4+PiAtICAgIGJvb2wgIk9wZW4tQ2hhbm5lbCBTU0QgdGFyZ2V0IHN1cHBvcnQiCj4g
Pj4+PiArICAgIGJvb2wgIk9wZW4tQ2hhbm5lbCBTU0QgdGFyZ2V0IHN1cHBvcnQgKERFUFJFQ0FU
RUQpIgo+ID4+Pj4gICAgICAgZGVwZW5kcyBvbiBCTE9DSwo+ID4+Pj4gICAgICAgaGVscAo+ID4+
Pj4gICAgICAgICBTYXkgWSBoZXJlIHRvIGdldCB0byBlbmFibGUgT3Blbi1jaGFubmVsIFNTRHMu
Cj4gPj4+PiBAQCAtMTUsNiArMTUsOCBAQCBtZW51Y29uZmlnIE5WTQo+ID4+Pj4gICAgICAgICBJ
ZiB5b3Ugc2F5IE4sIGFsbCBvcHRpb25zIGluIHRoaXMgc3VibWVudSB3aWxsIGJlIHNraXBwZWQK
PiA+Pj4+IGFuZCBkaXNhYmxlZAo+ID4+Pj4gICAgICAgICBvbmx5IGRvIHRoaXMgaWYgeW91IGtu
b3cgd2hhdCB5b3UgYXJlIGRvaW5nLgo+ID4+Pj4gICArICAgICAgVGhpcyBjb2RlIGlzIGRlcHJl
Y2F0ZWQgYW5kIHdpbGwgYmUgcmVtb3ZlZCBpbiBMaW51eCA1LjE1Lgo+ID4+Pj4gKwo+ID4+Pj4g
ICBpZiBOVk0KPiA+Pj4+ICAgICBjb25maWcgTlZNX1BCTEsKPiA+Pj4+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2xpZ2h0bnZtL2NvcmUuYyBiL2RyaXZlcnMvbGlnaHRudm0vY29yZS5jCj4gPj4+PiBp
bmRleCAyOGRkY2FhNTM1OGIxNC4uNDM5NGY0N2M4MTI5NmEgMTAwNjQ0Cj4gPj4+PiAtLS0gYS9k
cml2ZXJzL2xpZ2h0bnZtL2NvcmUuYwo+ID4+Pj4gKysrIGIvZHJpdmVycy9saWdodG52bS9jb3Jl
LmMKPiA+Pj4+IEBAIC0xMTc0LDYgKzExNzQsOCBAQCBpbnQgbnZtX3JlZ2lzdGVyKHN0cnVjdCBu
dm1fZGV2ICpkZXYpCj4gPj4+PiAgIHsKPiA+Pj4+ICAgICAgIGludCByZXQsIGV4cF9wb29sX3Np
emU7Cj4gPj4+PiAgICsgICAgcHJfd2Fybl9vbmNlKCJsaWdodG52bSBzdXBwb3J0IGlzIGRlcHJl
Y2F0ZWQgYW5kIHdpbGwgYmUKPiA+Pj4+IHJlbW92ZWQgaW4gTGludXggNS4xNS5cbiIpOwo+ID4+
Pj4gKwo+ID4+Pj4gICAgICAgaWYgKCFkZXYtPnEgfHwgIWRldi0+b3BzKSB7Cj4gPj4+PiAgICAg
ICAgICAga3JlZl9wdXQoJmRldi0+cmVmLCBudm1fZnJlZSk7Cj4gPj4+PiAgICAgICAgICAgcmV0
dXJuIC1FSU5WQUw7Cj4gPj4+Cj4gPj4+IFRoYW5rcywgQ2hyaXN0b3BoLgo+ID4+Pgo+ID4+PiBJ
J2xsIHNlbmQgaXQgdG8gSmVucyB3aXRoIHRvZGF5J3MgbGlnaHRudm0gUFIuCj4gPj4KPiA+PiBK
YXZpZXIsIGNhbiBJIGFkZCB5b3VyIHJldmlld2VkLWJ5Pwo+ID4+Cj4gPgo+ID4gWWVzLCBwbGVh
c2UuCj4gPgo+ID4gSSdsbCBjcmFjayBhIGJlZXIgYW5kIGNoZWVyIG9uIGl0IHRvbmlnaHQuIEdv
b2QgdGltZXMgOikKCkFsbCB0aG9zZSBwYXRjaGVzIGxvc3QgaW4gdGltZSwgbGlrZSB0ZWFycyBp
biByYWluLi4KCkNoZWVycyB0byBldmVyeW9uZSBpbnZvbHZlZCEKCkhhbnMKCj4gPgo+ID4gSmF2
aWVyCj4KPiBUaGFuayB5b3UuCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK

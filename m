Return-Path: <SRS0=Y48z=76=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0138FC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 14:42:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAEAB20888
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 14:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QQh/RSRE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="bAPRE0JB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAEAB20888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=lT9OAA6UIBIoKxYfqrapFZa1cnEjUsO4JAAASXFqXms=; b=QQh/RSREDDQuwk1p0d9snWc3g
	LUTJKKNqmjCO1CWLL6026W1e8uYkVWS7OGJFvF15CVXTL0j777RHRUtGxs9xNscV5Kj0MF8V6vjP8
	P+U8WdHA6QcGfLnsP/qjFeB9ju3BshC7AGji+rTMQ393/dYY8vzhihAAVi6OBbtt1nUhMolcKij7k
	POD+B39NJneDzjsmoSvOy1cVl2gaIG9x5xEVLsqY0I/Uh/jg3UtecfJGdlutfxDLLXS9zLBaQ/W4q
	xmwUO5FHBytLnkOzooRVGbHD6OYPQwB0Z/GoGKcz/9unK7K3YMtocpScfiKY2F8GlmXRv7KDAPl5Y
	yAEdN17lA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlZGu-00021m-1h; Wed, 17 Jun 2020 14:42:36 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlZGr-00021K-QE
 for linux-nvme@lists.infradead.org; Wed, 17 Jun 2020 14:42:35 +0000
Received: by mail-ed1-x541.google.com with SMTP id o26so2178426edq.0
 for <linux-nvme@lists.infradead.org>; Wed, 17 Jun 2020 07:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=+wmlp3TUuoCAlHj/LRi5Py3tIwsBfqYCvq+vpZAYdfY=;
 b=bAPRE0JBfWg0oR0Ok+btLS+2KJwnv+ZCBYdpUraCke6A9U66YT6LvKfU/hAgMyGEca
 n2uvj3kzoC2C3FbUwM/9E8rJYLuU+coH+TbsJ+ujWPbfU8XvZq0MxKdEzF3o1zqbuCeZ
 We27K7087fLQfW44s7LSQqmuuNarBq6HwRX6d3Muw9brf5LGGPyk7JgkVSM8VbokIUBJ
 /DE9l5TmsCuGGC5t2JuMgStMoR1f8dcxf1i6+8WK2I6kXGkanjYaYAQ+H3xsiMEbtuK8
 LISKkNRRQ3m1OC3JDr28hkJcjShVLClUo4DP+xujOoNO1K0Tfs0k09mV1XCshV7AYpGa
 wCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=+wmlp3TUuoCAlHj/LRi5Py3tIwsBfqYCvq+vpZAYdfY=;
 b=iMM0fKaicyNffURFl5adSrNO0Ixlo7KqVvuaFL8xERTK7xvc7aJ1A/ThVPLPSSpKDS
 /e78mU0uE8l3d9q35+N0ofsr87hr/FDrMDUQTBr6nXw+fiNaYmIISxBsLGDtnzMBoYwY
 Lp2yUlvo/oSnV0z9j2KKECkuCWbwW0vXAuy/pmZM3idUgekZOS/ijAyx53E/M/T2UG3G
 NX8R21b3Yn3tB3D0e8O8SS5qJ+W+ilihBYtuWhBe3hAyJNgdLWkqsROBfXw/qHhVBX/I
 J/vS7i2A404O6Lja9P4o4UTYE5Mxm+N5qQ12rc83EfuL4Z2PqBFRBzi4QaxU3VEFXcOD
 73gA==
X-Gm-Message-State: AOAM531bPARWCZKCSsH9FQ3ANilCzJ0DP07LP/Zw3FOVyMj9NxTvPKGQ
 1hVXsFA9Q1/BTQ7lyA9QVZSruw==
X-Google-Smtp-Source: ABdhPJzlTAmS3TBcxmUH68KPghT5S/KE85nkYi1efdB6MzA7a1CZZhyhR/kr8pTSuNz8Bjfh2KiJhw==
X-Received: by 2002:a50:ee08:: with SMTP id g8mr7273823eds.267.1592404951890; 
 Wed, 17 Jun 2020 07:42:31 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id dk19sm12272136edb.78.2020.06.17.07.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2020 07:42:30 -0700 (PDT)
Date: Wed, 17 Jun 2020 16:42:30 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200617074328.GA13474@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200617_074233_874980_3906C11D 
X-CRM114-Status: GOOD (  14.12  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Niklas Cassel <niklas.cassel@wdc.com>,
 Damien Le Moal <damien.lemoal@wdc.com>, Ajay Joshi <ajay.joshi@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Aravind Ramesh <aravind.ramesh@wdc.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
 Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTcuMDYuMjAyMCAwOTo0MywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj5PbiBUdWUsIEp1
biAxNiwgMjAyMCBhdCAxMjo0MTo0MlBNICswMjAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+
PiBPbiAxNi4wNi4yMDIwIDA4OjM0LCBLZWl0aCBCdXNjaCB3cm90ZToKPj4+IEFkZCBzdXBwb3J0
IGZvciBOVk0gRXhwcmVzcyBab25lZCBOYW1lc3BhY2VzIChaTlMpIENvbW1hbmQgU2V0IGRlZmlu
ZWQKPj4+IGluIE5WTSBFeHByZXNzIFRQNDA1My4gWm9uZWQgbmFtZXNwYWNlcyBhcmUgZGlzY292
ZXJlZCBiYXNlZCBvbiB0aGVpcgo+Pj4gQ29tbWFuZCBTZXQgSWRlbnRpZmllciByZXBvcnRlZCBp
biB0aGUgbmFtZXNwYWNlcyBOYW1lc3BhY2UKPj4+IElkZW50aWZpY2F0aW9uIERlc2NyaXB0b3Ig
bGlzdC4gQSBzdWNjZXNzZnVsbHkgZGlzY292ZXJlZCBab25lZAo+Pj4gTmFtZXNwYWNlIHdpbGwg
YmUgcmVnaXN0ZXJlZCB3aXRoIHRoZSBibG9jayBsYXllciBhcyBhIGhvc3QgbWFuYWdlZAo+Pj4g
em9uZWQgYmxvY2sgZGV2aWNlIHdpdGggWm9uZSBBcHBlbmQgY29tbWFuZCBzdXBwb3J0LiBBIG5h
bWVzcGFjZSB0aGF0Cj4+PiBkb2VzIG5vdCBzdXBwb3J0IGFwcGVuZCBpcyBub3Qgc3VwcG9ydGVk
IGJ5IHRoZSBkcml2ZXIuCj4+Cj4+IFdoeSBhcmUgd2UgZW5mb3JjaW5nIHRoZSBhcHBlbmQgY29t
bWFuZD8gQXBwZW5kIGlzIG9wdGlvbmFsIG9uIHRoZQo+PiBjdXJyZW50IFpOUyBzcGVjaWZpY2F0
aW9uLCBzbyB3ZSBzaG91bGQgbm90IG1ha2UgdGhpcyBtYW5kYXRvcnkgaW4gdGhlCj4+IGltcGxl
bWVudGF0aW9uLiBTZWUgc3BlY2lmaWNzIGJlbG93Lgo+Cj5CZWNhdXNlIEFwcGVuZCBpcyB0aGUg
d2F5IHRvIGdvIGFuZCB3ZSd2ZSBtb3ZlZCB0aGUgTGludXggem9uZWQgYmxvY2sKPkkvTyBzdGFj
ayB0byByZXF1aXJlZCBpdCwgYXMgc2hvdWxkIGhhdmUgYmVlbiBvYnZpb3VzIHRvIGFueW9uZQo+
Zm9sbG93aW5nIGxpbnV4LWJsb2NrIGluIHRoZSBsYXN0IGZldyBtb250aHMuICBJIGFsc28gaGF2
ZSB0byBzYXkgSSdtCj5yZWFsbHkgdGlyZWQgb2YgdGhlIHN0dXBpZCBwb2xpdGljcyB0aGEgeW91
ciBjb21wYW55IHN0YXJ0ZWQgaW4gdGhlCj5OVk1lIHdvcmtpbmcgZ3JvdXAsIGFuZCB3aWxsIHNh
eSB0aGF0IHRoZXNlIGRvIG5vdCBtYXR0ZXIgZm9yIExpbnV4Cj5kZXZlbG9wbWVudCBhdCBhbGwu
ICBJZiB5b3UgdGhpbmsgaXQgaXMgd29ydGh3aGlsZSB0byBzdXBwb3J0IGRldmljZXMKPndpdGhv
dXQgWm9uZSBBcHBlbmQgeW91IGNhbiBjb250cmlidXRlIHN1cHBvcnQgZm9yIHRoZW0gb24gdG9w
IG9mIHRoaXMKPnNlcmllcyBieSBwb3J0aW5nIHRoZSBTQ1NJIFpvbmUgQXBwZW5kIEVtdWxhdGlv
biBjb2RlIHRvIE5WTWUuCj4KPkFuZCBJJ20gbm90IGV2ZW4gZ29pbmcgdG8gcmVhZCB0aGUgcmVz
dCBvZiB0aGlzIHRocmVhZCBhcyBJJ20gb24gYQo+dmFjYXRpb24gdGhhdCBJIGJhZGx5IG5lZWRl
ZCBiZWNhdXNlIG9mIHRoZSBTYW1zdW5nIFRXRyBidWxsc2hpdC4KCk15IGludGVudGlvbiBpcyB0
byBzdXBwb3J0IHNvbWUgU2Ftc3VuZyBaTlMgZGV2aWNlcyB0aGF0IHdpbGwgbm90IGVuYWJsZQph
cHBlbmQuIEkgZG8gbm90IHRoaW5rIHRoaXMgaXMgYW4gdW5yZWFzb25hYmxlIHRoaW5nIHRvIGRv
LiBIb3cgLyB3aHkKYXBwZW5kIGVuZGVkIHVwIGJlaW5nIGFuIG9wdGlvbmFsIGZlYXR1cmUgaW4g
dGhlIFpOUyBUUCBpcyBvcnRob2dvbmFsIHRvCnRoaXMgY29udmVyc2F0aW9uLiBCdWxsc2hpdCBv
ciBub3QsIGl0IGVuZHMgdXAgb24gZGV2aWNlcyB0aGF0IHdlIHdvdWxkCmxpa2UgdG8gc3VwcG9y
dCBvbmUgd2F5IG9yIGFub3RoZXIuCgpBZnRlciB0aGUgZGlzY3Vzc2lvbiB3aXRoIERhbWllbiBh
bmQgS2VpdGggSSBoYXZlIGEgY2xlYXIgaWRlYSBob3cgd2UKY2FuIGRvIHRoaXMgYW5kIHdlIHdp
bGwgZ28gYWhlYWQgd2l0aCB0aGUgd29yay4KCkkgYXBvbG9naXplIHRoYXQgdGhpcyBjb252ZXJz
YXRpb24gZ290IG1peGVkIHdpdGggbGVmdG92ZXJzIGZyb20gTlZNZQpUV0cgaW50ZXJuYWxzLiBU
aGlzIGlzIGEgcHVibGljIG1haWxpbmcgbGlzdCwgc28gSSBndWVzcyBhbnlvbmUgY2FuCmNvbW1l
bnQgb24gaXQuCgpUaGFua3MsCkphdmllcgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=

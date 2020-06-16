Return-Path: <SRS0=oPks=75=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3152C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 12:24:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BAC020C56
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 12:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TAbzgjKa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="NdH81GWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BAC020C56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=J99BtIoWHtYjWRFNxlbYMz8nVsMQ3MPk2VDkwSHYfVM=; b=TAbzgjKa/FBP+9b5MW1GDkmaC
	4BjKS9EuyT22Al1Ql8bfOiOzhwbviRrYkvsIMsg1eq6euIBrNejxl/TmvIF3gZlXuMKNYz7RhS+Pd
	PKYkh2hgc3CZvJ/i2IjlDb2ARiU5lyriMU0LOoSTvfQ5xBytHKiDV9KPUYg7xRTjBdCtw4XbiXc5+
	wu0pTID+odT2X62c7c02jaI1bcMejHl7yR9/qPI0YkkeAqyFaXlvnfEqa7Cqs4XKFNtI7dXeyhc25
	T0fkZtP27xdxvXnqmraUTrLvnWQkCy4f811ku35GArlV+903ZiHf3+pBCSbQHuBHUpLd8kY/rjAK+
	VUhbHCcMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlAe5-0007Fa-Cw; Tue, 16 Jun 2020 12:24:53 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlAe3-0007Eq-Jw
 for linux-nvme@lists.infradead.org; Tue, 16 Jun 2020 12:24:52 +0000
Received: by mail-wr1-x441.google.com with SMTP id j10so20545107wrw.8
 for <linux-nvme@lists.infradead.org>; Tue, 16 Jun 2020 05:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=/kIpCjCnT58JEG0mlUt9/EOieRJkzoytsmJ6uVIikG4=;
 b=NdH81GWDoVE8IpZvXIvmiD9pU0wl/DubsUnumfs2pm8ffF3/3S9hBD32MTJQ12z3vx
 tg+dvD1OBOPIIMfoFOGk8RV18xUtaOOG8r1frHLCXDyZa2037wz5VWo8pQsNjxVoNafo
 HnjBoCefxCRABCpMcrPb0BSu1NUoZjHiH6BkJSxsO9mwIyUSe9N9FN4un3UmTdZ5Kfxd
 PjRvVXJvHjaLpZbx8B4mm1LmS7fRs9wJUtrZ2r0ZyQrUpMXKBK46cGAva0TGw9KZHjz6
 E2R2EFQZX7SgzqxBYkoZ094rpMpCmzMAvvUkkXFn1YBvtJRUKQ1V6mjUvr6vRRZ8aECI
 ZsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=/kIpCjCnT58JEG0mlUt9/EOieRJkzoytsmJ6uVIikG4=;
 b=pUu7WBHan1QFs1rpn9aBsvsUjS1urbnFKeTTZV5LozN2YpOgFcbQBOEjKQv73JAw0r
 BDfAwKBiG/EXYls4gLz9Cz66HPwdKT1n9tlcVLfOsFRMY8Cm+TBeeobngostRLNM5NUc
 vnBbLkao+aXMkSk0Jmd0OvxpCe1hB6bi3DoeUWqZYQ975DuS+WCNDxDRCdHJpMjim9YO
 H1dEbsKdhkeaqG3Ho+ImzoF/bUh5r3cFfjt3i0egPRFPZml5Aa59kESGBY76wDkGwXa7
 syfiko/Ai/u0/QGJqJnDBagk9lUfR9L/EjfIqLLfhQoI0MLeHigmXXS8NrtUPRjUCSNQ
 9h1A==
X-Gm-Message-State: AOAM531JCQj1nTHl8KYQqD2rLiR4Fh71xJ4RpiYXPDupxYF/+3goKV1T
 B+zttQYjwW1qWCHd6QBwFnzpqg==
X-Google-Smtp-Source: ABdhPJxdYMJPpziDe8iXirHeV1pcVKa8DYd2hmGQF7C8+5WnJxa7+yKYZEo/WSDPHXONxAKse1WU/g==
X-Received: by 2002:a5d:56c3:: with SMTP id m3mr2807086wrw.393.1592310289602; 
 Tue, 16 Jun 2020 05:24:49 -0700 (PDT)
Received: from localhost ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id w10sm29085408wrp.16.2020.06.16.05.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 05:24:48 -0700 (PDT)
Date: Tue, 16 Jun 2020 14:24:48 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
Message-ID: <20200616122448.4e3slfghv4cojafq@mpHalley.local>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <d433450a-6e18-217c-d133-ea367d8936be@lightnvm.io>
 <20200616120018.en337lcs5y2jh5ne@mpHalley.local>
 <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cf899cd9-c3de-7436-84d4-744c0988a6c9@lightnvm.io>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200616_052451_657690_7B6110D2 
X-CRM114-Status: GOOD (  11.09  )
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
 Christoph Hellwig <hch@lst.de>,
 Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTYuMDYuMjAyMCAxNDowNiwgTWF0aWFzIEJqw7hybGluZyB3cm90ZToKPk9uIDE2LzA2LzIw
MjAgMTQuMDAsIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4+T24gMTYuMDYuMjAyMCAxMzoxOCwg
TWF0aWFzIEJqw7hybGluZyB3cm90ZToKPj4+T24gMTYvMDYvMjAyMCAxMi40MSwgSmF2aWVyIEdv
bnrDoWxleiB3cm90ZToKPj4+Pk9uIDE2LjA2LjIwMjAgMDg6MzQsIEtlaXRoIEJ1c2NoIHdyb3Rl
Ogo+Pj4+PkFkZCBzdXBwb3J0IGZvciBOVk0gRXhwcmVzcyBab25lZCBOYW1lc3BhY2VzIChaTlMp
IENvbW1hbmQgU2V0IGRlZmluZWQKPj4+Pj5pbiBOVk0gRXhwcmVzcyBUUDQwNTMuIFpvbmVkIG5h
bWVzcGFjZXMgYXJlIGRpc2NvdmVyZWQgYmFzZWQgb24gdGhlaXIKPj4+Pj5Db21tYW5kIFNldCBJ
ZGVudGlmaWVyIHJlcG9ydGVkIGluIHRoZSBuYW1lc3BhY2VzIE5hbWVzcGFjZQo+Pj4+PklkZW50
aWZpY2F0aW9uIERlc2NyaXB0b3IgbGlzdC4gQSBzdWNjZXNzZnVsbHkgZGlzY292ZXJlZCBab25l
ZAo+Pj4+Pk5hbWVzcGFjZSB3aWxsIGJlIHJlZ2lzdGVyZWQgd2l0aCB0aGUgYmxvY2sgbGF5ZXIg
YXMgYSBob3N0IG1hbmFnZWQKPj4+Pj56b25lZCBibG9jayBkZXZpY2Ugd2l0aCBab25lIEFwcGVu
ZCBjb21tYW5kIHN1cHBvcnQuIEEgbmFtZXNwYWNlIHRoYXQKPj4+Pj5kb2VzIG5vdCBzdXBwb3J0
IGFwcGVuZCBpcyBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBkcml2ZXIuCj4+Pj4KPj4+PldoeSBhcmUg
d2UgZW5mb3JjaW5nIHRoZSBhcHBlbmQgY29tbWFuZD8gQXBwZW5kIGlzIG9wdGlvbmFsIG9uIHRo
ZQo+Pj4+Y3VycmVudCBaTlMgc3BlY2lmaWNhdGlvbiwgc28gd2Ugc2hvdWxkIG5vdCBtYWtlIHRo
aXMgbWFuZGF0b3J5IGluIHRoZQo+Pj4+aW1wbGVtZW50YXRpb24uIFNlZSBzcGVjaWZpY3MgYmVs
b3cuCj4+Cj4+Pgo+Pj5UaGVyZSBpcyBhbHJlYWR5IGdlbmVyYWwgc3VwcG9ydCBpbiB0aGUga2Vy
bmVsIGZvciB0aGUgem9uZSBhcHBlbmQgCj4+PmNvbW1hbmQuIEZlZWwgZnJlZSB0byBzdWJtaXQg
cGF0Y2hlcyB0byBlbXVsYXRlIHRoZSBzdXBwb3J0LiBJdCBpcyAKPj4+b3V0c2lkZSB0aGUgc2Nv
cGUgb2YgdGhpcyBwYXRjaHNldC4KPj4+Cj4+Cj4+SXQgaXMgZmluZSB0aGF0IHRoZSBrZXJuZWwg
c3VwcG9ydHMgYXBwZW5kLCBidXQgdGhlIFpOUyBzcGVjaWZpY2F0aW9uCj4+ZG9lcyBub3QgaW1w
b3NlIHRoZSBpbXBsZW1lbnRhdGlvbiBmb3IgYXBwZW5kLCBzbyB0aGUgZHJpdmVyIHNob3VsZCBu
b3QKPj5kbyB0aGF0IGVpdGhlci4KPj4KPj5aTlMgU1NEcyB0aGF0IGNob29zZSB0byBsZWF2ZSBh
cHBlbmQgYXMgYSBub24taW1wbGVtZW50ZWQgb3B0aW9uYWwKPj5jb21tYW5kIHNob3VsZCBub3Qg
cmVseSBvbiBlbXVsYXRlZCBTVyBzdXBwb3J0LCBzcGVjaWFsbHkgd2hlbgo+PnRyYWRpdGlvbmFs
IHdyaXRlcyB3b3JrIHZlcnkgZmluZSBmb3IgYSBsYXJnZSBwYXJ0IG9mIGN1cnJlbnQgWk5TIHVz
ZQo+PmNhc2VzLgo+Pgo+PlBsZWFzZSwgcmVtb3ZlIHRoaXMgdmlydHVhbCBjb25zdHJhaW50Lgo+
Cj5UaGUgWm9uZSBBcHBlbmQgY29tbWFuZCBpcyBtYW5kYXRvcnkgZm9yIHpvbmVkIGJsb2NrIGRl
dmljZXMuIFBsZWFzZSAKPnNlZSBodHRwczovL2x3bi5uZXQvQXJ0aWNsZXMvODE4NzA5LyBmb3Ig
dGhlIGJhY2tncm91bmQuCgpJIGRvIG5vdCBzZWUgYW55d2hlcmUgaW4gdGhlIGJsb2NrIGxheWVy
IHRoYXQgYXBwZW5kIGlzIG1hbmRhdG9yeSBmb3IKem9uZWQgZGV2aWNlcy4gQXBwZW5kIGlzIGVt
dWxhdGVkIG9uIFpCQywgYnV0IGJleW9uZCB0aGF0IHRoZXJlIGlzIG5vCm1hbmRhdG9yeSBiaXRz
LiBQbGVhc2UgZXhwbGFpbi4KCj4gUGxlYXNlIHN1Ym1pdHBhdGNoZXMgaWYgeW91IHdhbnQgdG8g
aGF2ZSBzdXBwb3J0IGZvciBaTlMgZGV2aWNlcyB0aGF0Cj4gZG9lcyBub3QgaW1wbGVtZW50IHRo
ZSBab25lIEFwcGVuZCBjb21tYW5kLiBJdCBpcyBvdXRzaWRlIHRoZSBzY29wZQo+IG9mIHRoaXMg
cGF0Y2hzZXQuCgpUaGF0IHdlIHdpbGwuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=

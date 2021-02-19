Return-Path: <SRS0=4MGw=HV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E378C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 21:28:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0395614A7
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Feb 2021 21:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0395614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=h0mtPaVbpmGZjlhfCNzeMouHyQiqZnpnVRlbhT59nac=; b=rQ98EsC/FWLq5JG6/pRwa4Y9i
	SsdnssZvZsKG96ibUEjqA0euRQRx0yhjta/ZP8Jgk98/kaDthv5HGlnaLoDok2AlcVhV3feYV/Ub5
	nTczx5R4A8jxym0hyHzg+z8r/ypuoR/Td5jliXI+1X2/O1n/dQPgxYrsKw6miNBMmgMxuhduYb7QV
	ycWeig7TV60bcxVJIrXGUe5cONsx/vXtZmWcFuDoF3WgAF9gz9ZEwrltEOlOS9ONv1Xy1Zh6iPBWA
	sUE+jPV2YBcmxUOBQcvv0fCv6+7eWI7KWhTBP53jL5HQdrUb0D6IIPCSRx/WPVrYj1givpxeQNnMo
	MaDniJclA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDDJc-0007ad-Dm; Fri, 19 Feb 2021 21:27:56 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDDJa-0007a7-0z
 for linux-nvme@lists.infradead.org; Fri, 19 Feb 2021 21:27:55 +0000
Received: by mail-pg1-x52c.google.com with SMTP id t26so5825253pgv.3
 for <linux-nvme@lists.infradead.org>; Fri, 19 Feb 2021 13:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=MpOkeEphxgXHYTzfxdPJ4fgfZERretNFMbGnVdjh+EY=;
 b=ACyBUmuHcQN4NKW9rwbK/Iu0wQCikZDfv013RtFPglk4/NwJZy4q+LtjYkJv5GYMGT
 rZNa4s1C3wW8jwmS6ND0PVXIC9nqwGUc4Ux63UcC7YNQ045LpX2VBQP/l3T2XI0C2eyM
 NKjiFZkK60GrJg+SG2op5QOZGyvPXk5bKunFCaTEDm8APM7tT55mauGMmQmzMQRP9qjd
 pcZL0ocufo7ZJ/4VkFPzgwSXdmqtCGxT7mVCRAZ6vUVt1GRWDGqlx8rjv2x4v1HJZyT7
 rzV0KPfGBC25du8VZsfmz9sidzSG4ffweMS4xAf/rq9PlzewOrobeHELL1fFT2lwFPow
 VNjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=MpOkeEphxgXHYTzfxdPJ4fgfZERretNFMbGnVdjh+EY=;
 b=S8M2XJTrZipOphlhNzQx7QyiHLRDze1FEsuEgL15Snu6IM8hspONiJJP0JYDdWtSKU
 lbBnW9thzVc88pOpvqKCuq//sSpo9ygQdi2SItlBQsjIkk/ArGczIHSsNUfQ9AcQ5nHc
 /JwZaQdy7sx2Y7cSFDR5tBIKywqXATjthlmwTY3nPcqouxcwJ98AwEs8ZX6pI1s02bxC
 WlZj74lPzPICQmVmGWEgK4SeZtBvEmcskYnurqQBp5JZWq+PVn92SQadehnox0n3NfNQ
 EyJnJZ5OfyISNDOqhlkbPMqL0f+gPvVORtFT975FKNRWrP+HoVAqoDOgF2PCr2JEAASt
 eX2A==
X-Gm-Message-State: AOAM532Kbzy+i3mKV1s2IUL4DtmVZSk67tyMkGlCFGS6Wf8Sm9BKFi1C
 E4fH32ybB9PEb5EgS+u2D4HBQOX73WW0Ww==
X-Google-Smtp-Source: ABdhPJzR+x5YP7WgdeJstuxzBsNowm8I/DeTIa7gt2tMaT9uEcC13UadnSztnquj4nwaa69BCu4QGg==
X-Received: by 2002:a63:5a05:: with SMTP id o5mr9989469pgb.452.1613770071634; 
 Fri, 19 Feb 2021 13:27:51 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id k9sm8951791pji.8.2021.02.19.13.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Feb 2021 13:27:51 -0800 (PST)
Date: Sat, 20 Feb 2021 06:27:49 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
Subject: Re: [PATCH] nvme: introduce passthrough ioctl for multipath
Message-ID: <20210219212749.GB175471@localhost.localdomain>
References: <20210214110126.24023-1-minwoo.im.dev@gmail.com>
 <20210214110126.24023-2-minwoo.im.dev@gmail.com>
 <20210215170233.GA2707454@dhcp-10-100-145-180.wdc.com>
 <20210216095147.GA2601@localhost.localdomain>
 <20210216175722.GC2708768@dhcp-10-100-145-180.wdc.com>
 <20210217021455.GA2251@localhost.localdomain>
 <CGME20210218084022eucas1p296cd6f091da8b347ecb3232a2e0b7383@eucas1p2.samsung.com>
 <20210218084014.GA17997@lst.de>
 <20210218084812.kcibjukwlb37ijji@mpHalley.local>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210218084812.kcibjukwlb37ijji@mpHalley.local>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210219_162754_237615_A0C8C025 
X-CRM114-Status: GOOD (  21.62  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjEtMDItMTggMDk6NDg6MTIsIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4gT24gMTguMDIu
MjAyMSAwOTo0MCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gPiBPbiBXZWQsIEZlYiAxNywg
MjAyMSBhdCAxMToxNDo1NUFNICswOTAwLCBNaW53b28gSW0gd3JvdGU6Cj4gPiA+ID4gQSBjb250
YWluZXIgY291bGQgcmVhZCBkYXRhIGZyb20gbmFtZXNwYWNlcyBhc3NpZ25lZCB0byBhIGRpZmZl
cmVudAo+ID4gPiA+IGNvbnRhaW5lci4KPiA+ID4gCj4gPiA+IE5vdyBJIGdvdCB5b3VyIHBvaW50
ISBUaGFua3MgS2VpdGgsIHBsZWFzZSBpZ25vcmUgdGhpcyBwYXRjaCA6KQo+ID4gCj4gPiBOb3Rl
IHRoYXQgSmF2aWVyIGhhcyBiZWVuIHdvcmtpbmcgb24gZXhwb3NpbmcgYWNjZXNzIHRvIG5hbWVz
cGFjZXMKPiA+IHdpdGggdW5zdXBwb3J0ZWQgY29tbWFuZCBzZXRzIGZvciBpb2N0bHMuICBJZiB0
aGF0IGlzIHdoYXQgeW91IGFyZQo+ID4gbG9va2luZyBmb3IuCj4gCj4gTWlud29vLCBJIHRoaW5r
IHRoaXMgd291bGQgYXBwbHkgZ29vZCBvbiB0b3Agb2YgdGhlIGNoYXIgZGV2aWNlIHBhdGNoZXMK
PiBJIHBvc3RlZCBhIHdoaWxlIGFnby4gSSBoYXZlIGEgbXVsdGlwYXRoIHZlcnNpb24gd29ya2lu
ZyBvbiB0b3AsIGJ1dCBJCj4gYW0gc3RpbGwgd29ya2luZyBvdXQgYSBnb29kIHdheSB0byBleHBv
c2UgaW4gc3lzZnMuCj4gCj4gV2UgY2FuIHRyeSB0byBtZXJnZSB0aGVzZSBhbmQgc2VuZCB0aGUg
Y2hhciBkZXZpY2Ugd2l0aCBtdWx0aXBhdGggaW4gdGhlCj4gZm9sbG93aW5nIGRheXMuIFRoaXMg
aGFzIGJlZW4gaGFuZ2luZyBvbiBtZSBtb3JlIHRoYW4gSSB3YW50ZWQgaXQgdG8uLi4KClRoYW5r
cyBKYXZpZXIsIFRoYXQgc291bmRzIGNvb2wuICB3aWxsIGhhdmUgYSBsb29rIGF0IHlvdXIgcGF0
Y2ggZmlyc3QhCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

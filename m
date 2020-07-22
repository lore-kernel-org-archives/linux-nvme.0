Return-Path: <SRS0=li1X=BB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD6FC433E3
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 22:31:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A6922071A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2020 22:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="yJnaYy6R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6922071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bzKkm0KPE2Bxfj0FEBgz7vL5Pc4N+Ui4YUEy0AEACWI=; b=yJnaYy6RR5VrNQucrqUoF3OW2
	XLjYVuclKxLoNuQtdsi4RkJh1oquJkFqcnHC5EWCQNv6MZXb8u5oa3JfecLSAVpNy06J2U406f397
	3axYoonERYQN7Rl8xiy+tJ7VWpGekod7p28QynQkyTbEv8SmPCLhAblKsN0/pmwqI6EP2obzy4HNl
	b3TRAXzRwijaDMyj5rkGYsEy4AvvQKkiaCScqhbKkSOPAkvNdY6+SXjecFZgfNWF65Jy1Ws1Tf5Zf
	uPLcXmvPY26okSRfIpdxDeEqJJqCg5qP7DLFrdR5GV7ATk4kIVb9Vo9FBl0gHgYHznLlEDrdFQ+IA
	OuZL2phAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jyNH7-0007j2-8d; Wed, 22 Jul 2020 22:31:45 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jyNH4-0007iS-CW
 for linux-nvme@lists.infradead.org; Wed, 22 Jul 2020 22:31:44 +0000
Received: by mail-wr1-f68.google.com with SMTP id q5so3352987wru.6
 for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2020 15:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OAy+Y993VLxZGDr9RipwWkimgf83z0qJOASn+ThnlDA=;
 b=bua2vFIhmq73gt8FjDKnBdnwRPHLsAZeFvxL6dnA+CQbmfR1MHfDNWhbBYrrRNj51O
 rtxPgYchoP6mbZNe13f5SbcyYRC8+trNE5De9FzK1xwWGG5spG/qweaxXmC98urAuGwl
 RktBG8ImCOFsS4iRqXPA+vGH2/v/bWROwrm8f8GIz3g5QEthBnv04TU11nuH9T9s8ar8
 rBQuHjTMme9aY9zFVdjMA0rNPSFoNquRyTfqw5oyiXGGrn2z1QwXA0wsIlimnPKJDqrD
 +Zzb4vG5U7ayjk4Xvm0qoqmK9+e/lx2ShsqMd5QlATiQVIuaQ10WXQ3Ps9JhbEyDCV8H
 nVBw==
X-Gm-Message-State: AOAM5310rdijr+vzIcVNEa2PSc3St1RRrZiXPypOTzsHWdvlx0SYMvBT
 khoU4pUiiHkmIaCiwh09UAw=
X-Google-Smtp-Source: ABdhPJyAP2MBfAqqZNztN1UpNU9srKE0MxDiqLpxiB8X+iFZsPUmULlwvj0mD1NTPAbp1u+rbgE5Uw==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr1381743wro.317.1595457100851; 
 Wed, 22 Jul 2020 15:31:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:45ba:2951:1398:d100?
 ([2601:647:4802:9070:45ba:2951:1398:d100])
 by smtp.gmail.com with ESMTPSA id 133sm1255699wme.5.2020.07.22.15.31.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 15:31:40 -0700 (PDT)
Subject: Re: [PATCH v15 7/9] nvmet-passthru: Add passthru code to process
 commands
To: Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>
References: <20200716203319.16022-1-logang@deltatee.com>
 <20200716203319.16022-8-logang@deltatee.com> <20200720141606.GF4627@lst.de>
 <e939dd43-9e7f-8ef0-162b-2a27f53e6e1a@grimberg.me>
 <5cc390cf-9b0b-b48b-7447-37934be51ee0@deltatee.com>
 <2dc39232-4042-1f93-3dcc-3266e70cf6f0@grimberg.me>
 <98f45e65-2967-3af9-69d1-077a32c43fa2@deltatee.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6e8cc582-d706-8e99-7191-82b08aa557e2@grimberg.me>
Date: Wed, 22 Jul 2020 15:31:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <98f45e65-2967-3af9-69d1-077a32c43fa2@deltatee.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200722_183142_432444_6068F657 
X-CRM114-Status: GOOD (  25.18  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Stephen Bates <sbates@raithlin.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiBUaGFua3MgZm9yIHRoZSByZXZpZXcgQ2hyaXN0b3BoLiBJIHRoaW5rIEkgc2hvdWxkIGJl
IGFibGUgdG8gbWFrZSBhbGwKPj4+IHRoZSByZXF1ZXN0ZWQgY2hhbmdlcyBpbiB0aGUgbmV4dCB3
ZWVrIG9yIHR3by4KPj4+Cj4+PiBPbiAyMDIwLTA3LTIwIDE6MzUgcC5tLiwgU2FnaSBHcmltYmVy
ZyB3cm90ZToKPj4+Pgo+Pj4+PiBJJ20gc3RpbGwgbm90IHNvIGhhcHB5IGFib3V0IGhhdmluZyB0
byBsb29rIHVwIHRoZSBuYW1lc3BhY2UgYW5kIHN0aWxsCj4+Pj4+IHdvbmRlciBpZiB3ZSBzaG91
bGQgZ2VuZXJhbGl6ZSB0aGUgY29ubmVjdF9xIHRvIGEgcGFzc3Rocm91Z2hfcS7CoCBCdXQKPj4+
Pj4gSSBndWVzcyB3ZSBjYW4gZG8gdGhhdCBsYXRlciBhbmQgdGhlbiByZWR1Y2Ugc29tZSBvZiB0
aGUgZXhwb3J0cyBoZXJlLi4KPj4+Pgo+Pj4+IFRoYXQgaXMgYSBuZWF0IGlkZWEhIHNob3VsZCBi
ZSBlYXN5IHRvIGRvIChhbmQgd2UgY2FuIHRoZW4gbG9zZSB0aGUgaG9zdAo+Pj4+IHhhcnJheSBz
dHVmZikuIEkgZG9uJ3QgbWluZCBoYXZpbmcgaXQgb24gYSBsYXRlciBwYXRjaCwgYnV0IGl0IHNo
b3VsZCBiZQo+Pj4+IGVhc3kgZW5vdWdoIHRvIGRvIGV2ZW4gYmVmb3JlLi4uCj4+Pj4KPj4+Cj4+
PiBJIHNvcnQgb2YgZm9sbG93IHRoaXMuIEkgY2FuIHRyeSB0byB3b3JrIHNvbWV0aGluZyB1cCBi
dXQgaXQgd2lsbAo+Pj4gcHJvYmFibHkgdGFrZSBtZSBhIGZldyBpdGVyYXRpb25zIHRvIGdldCBp
dCB0byB3aGVyZSB5b3Ugd2FudCBpdC4gU28sCj4+PiByb3VnaGx5LCB3ZSdkIGNyZWF0ZSBhIHBh
c3N0aHJvdWdoX3EgaW4gY29yZSB3aXRoIHRoZSBjb250cm9sbGVyJ3MgSU8KPj4+IHRhZ3NldCBh
bmQgdGhlbiBjbGVhbnVwIHRoZSBmYWJyaWNzIGhvc3RzIHRvIHVzZSB0aGF0IGluc3RlYWQgb2Yg
ZWFjaAo+Pj4gaW5kZXBlbmRlbnRseSBjcmVhdGluZyB0aGVpciBjb25uZWN0X3E/Cj4+Pgo+Pj4g
VGhvdWdoLCBJIGRvbid0IHVuZGVyc3RhbmQgaG93IHRoaXMgcmVsYXRlcyB0byB0aGUgaG9zdCB4
YXJyYXkgc3R1ZmYKPj4+IHRoYXQgU2FnaSBtZW50aW9uZWQuLi4KPj4KPj4gcGFzc3RocnUgY29t
bWFuZHMgYXJlIGluIGVzc2VuY2UgUkVRX09QX0RSVl9JTi9SRVFfT1BfRFJWX09VVCwgd2hpY2gK
Pj4gbWVhbnMgdGhhdCB0aGUgZHJpdmVyIHNob3VsZG4ndCBuZWVkIHRoZSBucyBhdCBhbGwuIFNv
IGlmIHlvdSBoYXZlIGEKPj4gZGVkaWNhdGVkIHJlcXVlc3QgcXVldWUgKG1hcHBlZCB0byB0aGUg
SS9PIHRhZ3NldCksIHlvdSBkb24ndCBuZWVkIHRoZQo+PiBucy0+cXVldWUgYW5kIHdlIGNhbiBs
b3NlIHRoZSBucyBsb29rdXAgYWx0b2dldGhlci4KPj4KPj4gVGhlIG9ubHkgcGFydCBpcyB0byBj
aGVjayB0aGUgZWZmZWN0cywgYnV0IHRoYXQgY2FuIHByb2JhYmx5IGJlIGhhbmRsZWQKPj4gd2hl
biB3ZSBzZXR1cCB0aGUgcGFzc3RocnUgY29udHJvbGxlciBvciBzb21ldGhpbmcuLi4KPiAKPiBZ
ZXMsIEkgaW1wbGVtZW50ZWQgdGhlIHBhc3N0aHJ1X3EgKHdoaWNoIHdhcyBxdWl0ZSBzaW1wbGUp
LgoKTmljZS4uCgo+IEJ1dCBJJ20gbm90Cj4gc3VyZSBob3cgd2UgYXJlIHN1cHBvc2VkIHRvIGNh
bGwgbnZtZV9jb21tYW5kX2VmZmVjdHMoKSBjb3JyZWN0bHkKPiB3aXRob3V0IHRoZSBucy4gWW91
IGNhbid0IHBvc3NpYmx5IGRvIHRoYXQgZHVyaW5nIHNldHVwIGZvciBldmVyeQo+IHBvc3NpYmxl
IG9wY29kZSBvbiBldmVyeSBuYW1lc3BhY2UuIEFuZCBldmVuIGlmIHdlIGRvLCB3ZSdsbCBzdGls
bCBuZWVkCj4gdGhlIHNhbWUgbnZtZV9maW5kX2dldF9ucygpIGFuZCBudm1lX3B1dF9ucygpIGV4
cG9ydHMgYW5kIHByb2JhYmx5Cj4gYW5vdGhlciB4YXJyYXkgdG8gbG9va3VwIHRoZSBpbmZvcm1h
dGlvbi4KPiAKPiBBbHNvLCB3ZSBwYXNzIHRoZSBuYW1lc3BhY2UncyBkaXNrIHRvIGluIG9yZGVy
IHRvIGdldCBwcm9wZXIgYmxvY2sKPiBhY2NvdW50aW5nIGZvciB0aGUgdW5kZXJseWluZyBkaXNr
LiAoV2hpY2ggaXMgcHJldHR5IGltcG9ydGFudCBmb3IKPiBkZWJ1Z2dpbmcpLiBTbyB3ZSBuZWVk
IHRvIGxvb2t1cCB0aGUgbmFtZXNwYWNlIGZvciB0aGlzIHRvby4KPiAKPiBVbmxlc3MgdGhlcmUg
YXJlIHNvbWUgb3RoZXIgaWRlYXMgdG8gc29sdmUgdGhlc2UgaXNzdWVzLCBJIGRvbid0IHRoaW5r
Cj4gdGhpcyBjaGFuZ2Ugd2lsbCBnYWluIHVzIGFueXRoaW5nLgoKTGV0J3MgZGVmZXIgaXQgdG8g
YSBmb2xsb3d1cCBzZXQgdGhhbi4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LW52bWUK

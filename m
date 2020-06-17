Return-Path: <SRS0=Y48z=76=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306FDC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 17:58:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE08D21556
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2020 17:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eGLkOCPX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="MdJf6dQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE08D21556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tcdfjLP6XSLFqK+0/bxKX1Me3R32FUsku5baulw/oZ0=; b=eGLkOCPX6z6PU1b733eLiOBG2
	8VxiJaRINzrS9dnh6DmmDhRb14x1zzHoZ8l3dzHD08DosjfwCjiS0883zvfiyXQPo3Adv1j1YERBu
	CYVEisGYiiOe6ne6OMabJOjuyu4tdFpRMLBWZ3iKM35szYiRk/cT2UvbJ2A5jvl3xQI83jN58hTDb
	1Bfm6bKaPNgkwwqVsAYqwPHL6PU2V5kwGjhPt+RauGM7e8VmZ/U0FEw9lssk8q+TXwz1TifrKAN/s
	bSv4AiiTQAYJG+XPwz9RJFtwKXRzewBUqwfzNkUK5ePJMJaB+8tcMbLEdwChZQHkOEuuPoBpJo7sK
	K2TvNkPnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jlcJt-0000p0-LB; Wed, 17 Jun 2020 17:57:53 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jlcJq-0000oD-Af
 for linux-nvme@lists.infradead.org; Wed, 17 Jun 2020 17:57:52 +0000
Received: by mail-wr1-x441.google.com with SMTP id b6so3297970wrs.11
 for <linux-nvme@lists.infradead.org>; Wed, 17 Jun 2020 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=rIjWNx6XtFvOaVapPdlfjvt5hio5VdS/1XdOtnEqP6s=;
 b=MdJf6dQv2+sYp+jJ5ELYlyLJpFY/pBbTQqKzXs0P4SBT86BliYBL+5dtVB9/Ing9nq
 YXFBfOBUDb5BrQ7qBEjuHDgGuOX+u30/S5Wx3M27yRHSUplsr24jYavnLY94YAbmrx5j
 opGKxl4qUqgH9wr3bZQ/y9Tpo7hcVQmkTXhD6lJG8S42wsFANwENIxIriPSpRgt6v7vM
 nImpnpKhGi9SG+ZqGqoWxrk5KYy/yrH74NFCRAC6mJ88mCiwCBpxdaJDBHiwRfdPXtpG
 7/bmOO/BK2pZ2++WLnPu+dA9v/Wp9uD0GXHTrhp8frO2GUn9OsmZsC9B0qdREDuGrkPO
 Rwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=rIjWNx6XtFvOaVapPdlfjvt5hio5VdS/1XdOtnEqP6s=;
 b=ZDc3tYvLoRPf+KKr0R7x7XZp8m/qWUpoYFGYlLf0/TQ6uy23wHFF5xRpmKN0L7tSeg
 5RHk8yTuNHe1Wb1vN2+j5orLW/vSyL5Dn6WNSN8Jha8NkCHQ1/sfx1NEUGJp7q2kxTCr
 T0seartizZHeqdko5BnyC0g/tmsEqIICtw4ggLGF3YUbfF0w5GHOVlkYHS3vyDDwsM8v
 6JpeSiSF28pM+RlN14VNVIPVi/NDIXRUK5zZeYnLp2PGWlLEuSacNlaWmi/kufoTeYjY
 SNvEmVLwnsBjJiRwFlaepjZZHPPlGw5P5/w3IC0McEdwhfZeAvaLBAJKY56zlYN2WtTQ
 +eKg==
X-Gm-Message-State: AOAM530qFcgUGAtVSg34T1vl8UUPnKfPtdhI8JJNuGDmBa1G48BLHE3k
 Glk+fBrpcB3+aNeJgDk1Z8AD8MyuHOI=
X-Google-Smtp-Source: ABdhPJxTMIVt2FHfC+p1ihCFlr89jxg/pE35pU+VVcTqvqSFNe3A2i0Q1AmNjb7CT1Pv9tAIwFQSHQ==
X-Received: by 2002:a5d:4fce:: with SMTP id h14mr413622wrw.199.1592416667209; 
 Wed, 17 Jun 2020 10:57:47 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
 by smtp.gmail.com with ESMTPSA id h27sm473209wrb.18.2020.06.17.10.57.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2020 10:57:46 -0700 (PDT)
Subject: Re: [PATCH 5/5] nvme: support for zoned namespaces
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
 Christoph Hellwig <hch@lst.de>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-6-keith.busch@wdc.com>
 <20200616104142.zxw25txhsg2eyhsb@mpHalley.local>
 <20200617074328.GA13474@lst.de>
 <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <f1bc34e0-c059-6127-d69f-e31c91ce6a9f@lightnvm.io>
Date: Wed, 17 Jun 2020 19:57:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617144230.ojzk4f5gcwqonzrf@mpHalley.localdomain>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200617_105750_435631_81448045 
X-CRM114-Status: GOOD (  20.88  )
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
 Judy Brock <judy.brock@samsung.com>,
 =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias.bjorling@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTcvMDYvMjAyMCAxNi40MiwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPiBPbiAxNy4wNi4y
MDIwIDA5OjQzLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4gT24gVHVlLCBKdW4gMTYsIDIw
MjAgYXQgMTI6NDE6NDJQTSArMDIwMCwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPj4+IE9uIDE2
LjA2LjIwMjAgMDg6MzQsIEtlaXRoIEJ1c2NoIHdyb3RlOgo+Pj4+IEFkZCBzdXBwb3J0IGZvciBO
Vk0gRXhwcmVzcyBab25lZCBOYW1lc3BhY2VzIChaTlMpIENvbW1hbmQgU2V0IGRlZmluZWQKPj4+
PiBpbiBOVk0gRXhwcmVzcyBUUDQwNTMuIFpvbmVkIG5hbWVzcGFjZXMgYXJlIGRpc2NvdmVyZWQg
YmFzZWQgb24gdGhlaXIKPj4+PiBDb21tYW5kIFNldCBJZGVudGlmaWVyIHJlcG9ydGVkIGluIHRo
ZSBuYW1lc3BhY2VzIE5hbWVzcGFjZQo+Pj4+IElkZW50aWZpY2F0aW9uIERlc2NyaXB0b3IgbGlz
dC4gQSBzdWNjZXNzZnVsbHkgZGlzY292ZXJlZCBab25lZAo+Pj4+IE5hbWVzcGFjZSB3aWxsIGJl
IHJlZ2lzdGVyZWQgd2l0aCB0aGUgYmxvY2sgbGF5ZXIgYXMgYSBob3N0IG1hbmFnZWQKPj4+PiB6
b25lZCBibG9jayBkZXZpY2Ugd2l0aCBab25lIEFwcGVuZCBjb21tYW5kIHN1cHBvcnQuIEEgbmFt
ZXNwYWNlIHRoYXQKPj4+PiBkb2VzIG5vdCBzdXBwb3J0IGFwcGVuZCBpcyBub3Qgc3VwcG9ydGVk
IGJ5IHRoZSBkcml2ZXIuCj4+Pgo+Pj4gV2h5IGFyZSB3ZSBlbmZvcmNpbmcgdGhlIGFwcGVuZCBj
b21tYW5kPyBBcHBlbmQgaXMgb3B0aW9uYWwgb24gdGhlCj4+PiBjdXJyZW50IFpOUyBzcGVjaWZp
Y2F0aW9uLCBzbyB3ZSBzaG91bGQgbm90IG1ha2UgdGhpcyBtYW5kYXRvcnkgaW4gdGhlCj4+PiBp
bXBsZW1lbnRhdGlvbi4gU2VlIHNwZWNpZmljcyBiZWxvdy4KPj4KPj4gQmVjYXVzZSBBcHBlbmQg
aXMgdGhlIHdheSB0byBnbyBhbmQgd2UndmUgbW92ZWQgdGhlIExpbnV4IHpvbmVkIGJsb2NrCj4+
IEkvTyBzdGFjayB0byByZXF1aXJlZCBpdCwgYXMgc2hvdWxkIGhhdmUgYmVlbiBvYnZpb3VzIHRv
IGFueW9uZQo+PiBmb2xsb3dpbmcgbGludXgtYmxvY2sgaW4gdGhlIGxhc3QgZmV3IG1vbnRocy7C
oCBJIGFsc28gaGF2ZSB0byBzYXkgSSdtCj4+IHJlYWxseSB0aXJlZCBvZiB0aGUgc3R1cGlkIHBv
bGl0aWNzIHRoYSB5b3VyIGNvbXBhbnkgc3RhcnRlZCBpbiB0aGUKPj4gTlZNZSB3b3JraW5nIGdy
b3VwLCBhbmQgd2lsbCBzYXkgdGhhdCB0aGVzZSBkbyBub3QgbWF0dGVyIGZvciBMaW51eAo+PiBk
ZXZlbG9wbWVudCBhdCBhbGwuwqAgSWYgeW91IHRoaW5rIGl0IGlzIHdvcnRod2hpbGUgdG8gc3Vw
cG9ydCBkZXZpY2VzCj4+IHdpdGhvdXQgWm9uZSBBcHBlbmQgeW91IGNhbiBjb250cmlidXRlIHN1
cHBvcnQgZm9yIHRoZW0gb24gdG9wIG9mIHRoaXMKPj4gc2VyaWVzIGJ5IHBvcnRpbmcgdGhlIFND
U0kgWm9uZSBBcHBlbmQgRW11bGF0aW9uIGNvZGUgdG8gTlZNZS4KPj4KPj4gQW5kIEknbSBub3Qg
ZXZlbiBnb2luZyB0byByZWFkIHRoZSByZXN0IG9mIHRoaXMgdGhyZWFkIGFzIEknbSBvbiBhCj4+
IHZhY2F0aW9uIHRoYXQgSSBiYWRseSBuZWVkZWQgYmVjYXVzZSBvZiB0aGUgU2Ftc3VuZyBUV0cg
YnVsbHNoaXQuCj4KPiBNeSBpbnRlbnRpb24gaXMgdG8gc3VwcG9ydCBzb21lIFNhbXN1bmcgWk5T
IGRldmljZXMgdGhhdCB3aWxsIG5vdCBlbmFibGUKPiBhcHBlbmQuIEkgZG8gbm90IHRoaW5rIHRo
aXMgaXMgYW4gdW5yZWFzb25hYmxlIHRoaW5nIHRvIGRvLiBIb3cgLyB3aHkKPiBhcHBlbmQgZW5k
ZWQgdXAgYmVpbmcgYW4gb3B0aW9uYWwgZmVhdHVyZSBpbiB0aGUgWk5TIFRQIGlzIG9ydGhvZ29u
YWwgdG8KPiB0aGlzIGNvbnZlcnNhdGlvbi4gQnVsbHNoaXQgb3Igbm90LCBpdCBlbmRzIHVwIG9u
IGRldmljZXMgdGhhdCB3ZSB3b3VsZAo+IGxpa2UgdG8gc3VwcG9ydCBvbmUgd2F5IG9yIGFub3Ro
ZXIuCgpJIGRvIG5vdCBiZWxpZXZlIGFueSBvZiB1cyBoYXZlIHNhaWQgdGhhdCBpdCBpcyB1bnJl
YXNvbmFibGUgdG8gc3VwcG9ydC4gCldlJ3ZlIG9ubHkgYXNrZWQgdGhhdCB5b3UgbWFrZSB0aGUg
cGF0Y2hlcyBmb3IgaXQuCgpBbGwgb2YgdXMgaGF2ZSBjb21tdW5pY2F0ZWQgd2h5IFpvbmUgQXBw
ZW5kIGlzIGEgZ3JlYXQgYWRkaXRpb24gdG8gdGhlIApMaW51eCBrZXJuZWwuIEFsc28sIGFzIENo
cmlzdG9waCBwb2ludHMgb3V0LCB0aGlzIGhhcyBub3QgYmVlbiBhIHNlY3JldCAKZm9yIHRoZSBw
YXN0IGNvdXBsZSBvZiBtb250aHMsIGFuZCBhcyBNYXJ0aW4gcG9pbnRlZCBvdXQsIGhhdmUgYmVl
biBhIAp3YW50ZWQgZmVhdHVyZSBmb3IgdGhlIHBhc3QgZGVjYWRlIGluIHRoZSBMaW51eCBjb21t
dW5pdHkuCgpJIGRvIHdhbnQgdG8gcG9saXRlbHkgcG9pbnQgb3V0LCB0aGF0IHlvdSd2ZSBnb3Qg
YSB2ZXJ5IGNsZWFyIHNpZ25hbCAKZnJvbSB0aGUga2V5IHN0b3JhZ2UgbWFpbnRhaW5lcnMuIEVh
Y2ggb2YgdGhlbSBpcyBwYXJ0IG9mIHRoZSBwbGFuZXQncyAKYmVzdCBvZiB0aGUgYmVzdCBhbmQg
bW9zdCB3ZWxsLXJlc3BlY3RlZCBzb2Z0d2FyZSBkZXZlbG9wZXJzLCB0aGF0IApsaXRlcmFsbHkg
aGF2ZSBidWlsdCB0aGUgc3RvcmFnZSBzdGFjayB0aGF0IG1vc3Qgb2YgdGhlIHdvcmxkIGRlcGVu
ZHMgCm9uLiBUaGUgc3RvcmFnZSBzdGFjayB0aGF0IHJlY2VudGx5IHNlbnQgbWFubmVkIHJvY2tl
dHMgaW50byBzcGFjZS4gVGhleSAKZWFjaCB1bmFuaW1vdXNseSBzYWlkIHRoYXQgdGhlIFpvbmUg
QXBwZW5kIGNvbW1hbmQgaXMgdGhlIHJpZ2h0IGFwcHJvYWNoIApmb3IgdGhlIExpbnV4IGtlcm5l
bCB0byByZWR1Y2UgdGhlIG92ZXJoZWFkIG9mIEkvTyB0cmFja2luZyBmb3Igem9uZWQgCmJsb2Nr
IGRldmljZXMuIEl0IG1heSBiZSB3b3J0aCBicmluZ2luZyB0aGlzIGluZm9ybWF0aW9uIHRvIHlv
dXIgCmVuZ2luZWVyaW5nIG9yZ2FuaXphdGlvbiwgYW5kIGFsc28gcG90ZW50aWFsbHkgY29uc2lk
ZXIgWm9uZSBBcHBlbmQgCnN1cHBvcnQgZm9yIGRldmljZXMgdGhhdCB5b3UgaW50ZW5kIHRvIHVz
ZWQgd2l0aCB0aGUgTGludXgga2VybmVsIApzdG9yYWdlIHN0YWNrLgoKQW5vdGhlciBhcHByb2Fj
aCwgaXMgdG8gdXNlIFNQREssIGFuZCBieXBhc3MgdGhlIExpbnV4IGtlcm5lbC4gVGhpcyAKbWln
aHQgZXZlbiBiZSBhbiBhZHZhbnRhZ2UsIHlvdXIgY3VzdG9tZXJzIGRvZXMgbm90IGhhdmUgdG8g
d2FpdCBvbiB0aGUgCkxpbnV4IGRpc3RyaWJ1dGlvbiBiZWluZyByZWxlYXNlZCB3aXRoIGEgbG9u
ZyB0ZXJtIHJlbGVhc2UsIGJlZm9yZSB0aGV5IApjYW4gZXZlbiBnZXQgc3RhcnRlZCBhbmQgZGVw
bG95IGluIHZvbHVtZS4gSS5lLiwgdGhleSB3aWxsIGFjdHVhbGx5IGdldCAKZmFzdGVyIHRvIG1h
cmtldCwgYW5kIHlvdXIgY29tcGFueSB3aWxsIGJlIGFibGUgdG8gc2VsbCBtb3JlIGRyaXZlcy4K
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1u
dm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

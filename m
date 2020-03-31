Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9B5C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 17:00:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93A3420BED
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 17:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r3wI69VF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="obQKA52V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A3420BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Fo1HpOvb0Q8Bpv/yxJFPDB4mAJsoHDPk5NV+ImRo8VE=; b=r3wI69VFJp2t+IOmcGwyiplkb
	k9wqImT8rf9TNkJ/acxtJBYXCNnpRxGPZTZNuJaJPi2bA56G/CWceJY8CuWE6y8VdTdir0sR8HWgI
	i614MbQDn0gZO68R6pmJAdw48c6hvR4dzoSpn4/y/4ROJFRqqbC4pDPZqBV6lOLN2MDrFyeudsXWJ
	Yt7EKoEjyWtzRzWt16gHxnbwQnCv6LwfFOL82oQ4GfGh8UA1KasbEqdBW4ip/LYBrtYwVZZIshD3a
	kH1ipumZ6G4ZrFmot0OHDPA37K29Y23GaumaEVP0vcu4UmWQDyBWq3f4J41utORxondJ3sf2V61Qw
	lHhsLa4sA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJKFs-0005wf-6c; Tue, 31 Mar 2020 17:00:48 +0000
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJJDA-0004Tx-SJ
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 15:54:03 +0000
Received: by mail-qv1-xf42.google.com with SMTP id g4so11063143qvo.12
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 08:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=6FahT8x90WNHEEj3oMiZ/ShKhSZD8ajLBlpxau/7+rU=;
 b=obQKA52V+aibNLR7ijxuIcGBoA6P2Jr4R6YdarkbEj60cnP08xZnf8tFcb7prYuVQK
 vSaZgdHxMbxpWCCB8X+9gljqaKIWv8mK3rC37kxEi3hMS+fol5ysxO3s86DYH6G6Z6Ia
 dwWLEOiwLuCNkpxJd3cbRHnlRrZno9LBSqVSUo8q8lO8IG6lkI0Zc07nP0E4AraUE7l0
 pzsssu9ZuqhsFBdv0Qpeivm7yO0cSI1YM49nD6aHDrCyEzbVfEkv9bNX9FkiR4vB5oQM
 FrdBCGVQQm2pqZJSo6UulPImEcGvX52rbTFLkU8aDmkQ9Rse5ocb3lMrAOa3UNnPIONY
 Bzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=6FahT8x90WNHEEj3oMiZ/ShKhSZD8ajLBlpxau/7+rU=;
 b=W8zIYhG2NDD5xT1SfqyyX1R3Kl2Gtr+Wei1GHnsbiY6qezhIleFl4Ds5uVldy273Zt
 QdCRn4fOV5555bT607gCBuyFlDuvK0bT40ZL0H2kVvTkT5Zc7mJslmlVtoY6VQw9whH4
 2yFHJLo7QpAeQ/ZpYoB4cuYeoVKg64GUU/bz5zpcHXbQLBzk7cwqSIZJH8TvVhcfwG34
 Bhx9VJDCinPAOVnK7kCOlhsRybblzEg61gP4T+qM7w/gXKvog9sDQYxOgDdCut+tES/U
 Z8R1onDX7ionyDqW2Cq+MHzP+xF0ZqgpMeYhYy+VyVZxEIqAdEjoy25H8G+2zUn/3RWE
 XIWw==
X-Gm-Message-State: ANhLgQ1UbXMsxdPX88EXv/awl5v50dTA3LX6vPSZFa4BBmB1tjsT+b0p
 dK7pDBpQJeAnBnLWJMOtsmSGjzEZ
X-Google-Smtp-Source: APiQypKejXVVSk70bM7Kz1AwJxT32HiTMDJNu9AaEukwpa+Inc8Lv9B5MNiRM6mgILrcauM5QKaRpA==
X-Received: by 2002:aa7:8a99:: with SMTP id a25mr5110325pfc.76.1585668294930; 
 Tue, 31 Mar 2020 08:24:54 -0700 (PDT)
Received: from ?IPv6:240b:10:2720:5510:a182:288:3ffa:432a?
 ([240b:10:2720:5510:a182:288:3ffa:432a])
 by smtp.gmail.com with ESMTPSA id y4sm583215pfo.39.2020.03.31.08.24.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 08:24:54 -0700 (PDT)
Subject: Re: [PATCH] block, nvme: Increase max segments parameter setting value
To: Keith Busch <kbusch@kernel.org>
References: <BYAPR04MB4965BAF4C0300E1206B049A586F00@BYAPR04MB4965.namprd04.prod.outlook.com>
 <cff52955-e55c-068a-44a6-8ed4edc0696f@gmail.com>
 <20200324000237.GB15091@redsun51.ssa.fujisawa.hgst.com>
 <6b73db44-ca3f-4285-0c91-dc1b1a5ca9f1@gmail.com>
 <dc3a3e88-f062-b7df-dd18-18fb76e68e0c@gmail.com>
 <20200327181825.GA8356@redsun51.ssa.fujisawa.hgst.com>
 <CACVXFVM=rT=86JrmAkySTg=gknfFL8Q1NU0uXWzoDMKMyL_mow@mail.gmail.com>
 <a0e7a985-a726-8e16-d29c-eb38a919e18e@gmail.com>
 <CACVXFVMsPstD2ZLnozC8-RsaJ7EMZK9+d47Q+1Z0coFOw3vMhg@mail.gmail.com>
 <cc1534d1-34f6-ffdb-27bd-73590ab30437@gmail.com>
 <20200330135323.GA32604@C02WT3WMHTD6>
From: Tokunori Ikegami <ikegami.t@gmail.com>
Message-ID: <6c35a4f9-af19-feff-6be0-d9c023d6c6b7@gmail.com>
Date: Wed, 1 Apr 2020 00:24:50 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200330135323.GA32604@C02WT3WMHTD6>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_085356_934479_A5210FEF 
X-CRM114-Status: GOOD (  12.26  )
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
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Ming Lei <tom.leiming@gmail.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

SGksCgpPbiAyMDIwLzAzLzMwIDIyOjUzLCBLZWl0aCBCdXNjaCB3cm90ZToKPiBPbiBNb24sIE1h
ciAzMCwgMjAyMCBhdCAwNjoxNTo0MVBNICswOTAwLCBUb2t1bm9yaSBJa2VnYW1pIHdyb3RlOgo+
PiBCdXQgdGhlcmUgaXMgYSBjYXNlIHRoYXQgdGhlIGNvbW1hbmQgZGF0YSBsZW5ndGggaXMgbGlt
aXRlZCBieSA1MTJLQi4KPj4gSSBhbSBub3Qgc3VyZSBhYm91dCB0aGlzIGNvbmRpdGlvbiBzbyBu
ZWVkZWQgbW9yZSBpbnZlc3RpZ2F0aW9uLgo+IFlvdXIgbWVtb3J5IGlzIHRvbyBmcmFnbWVudGVk
LiBZb3UgbmVlZCBtb3JlIHBoeXNpY2FsbHkgY29udGlndW91cwo+IG1lbW9yeSBvciB5b3UnbGwg
aGl0IHRoZSBzZWdtZW50IGxpbWl0IGJlZm9yZSB5b3UgaGl0IHRoZSBsZW5ndGgKPiBsaW1pdC4g
VHJ5IGFsbG9jYXRpbmcgaHVnZSBwYWdlcy4KClRoYW5rIHlvdSBzbyBtdWNoIGZvciB5b3VyIGFk
dmlzZS4KSSBoYXZlIGNvbmZpcm1lZCB0aGF0IHRoZSA1MTJLQiBjYXNlIGlzIGxpbWl0ZWQgYnkg
dGhlIDEyNyBzZWdtZW50cyAKY2hlY2sgYmVsb3cgaW4gbGxfbmV3X2h3X3NlZ21lbnQoKS4KCiDC
oMKgwqAgaWYgKHJlcS0+bnJfcGh5c19zZWdtZW50cyArIG5yX3BoeXNfc2VncyA+IApxdWV1ZV9t
YXhfc2VnbWVudHMocmVxLT5xKSkgewoKQWxzbyBjb25maXJtZWQgdGhhdCB0aGUgNE1CIGxpbWl0
IHdvcmtzIGNvcnJlY3RseSB3aXRoIHRoZSBtZW1vcnkgCmNvbmRpdGlvbiBub3QgZnJhZ21lbnRl
ZCB0b28gbXVjaC4KSSB3aWxsIGRvIGFiYW5kb24gdGhlIHBhdGNoIHRvIGluY3JlYXNlIG1heCBz
ZWdtZW50cyBhcyBsaW1pdGVkIDRNQiBub3cgCmJ5IE5WTWUgUENJZSBkcml2ZXIuCgpSZWdhcmRz
LApJa2VnYW1pCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtbnZtZSBtYWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

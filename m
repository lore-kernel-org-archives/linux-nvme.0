Return-Path: <SRS0=Iz8v=EI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6772C00A89
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 21:25:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35C2C20870
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Nov 2020 21:25:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qf5Bc+DV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="T1OsrJPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35C2C20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=xDNBSwjWPmg8YTkG/6R2gbuG27rGpgpupusYjUWAg7g=; b=Qf5Bc+DVxBmzRtnn/X3wM/10n
	eRlou2DhRc2ptGbJ+dounu/NKqlvG0bt0KMoO3VY8zvrOvUQxC5iuGaf1kdCnID6Sd/CE2AwVD0ea
	JHrRjcBkhzzt6sNHhFk+D7b5VRNVsC1BP5s6/VI/LX8BiSgm//k+ciLt/vnrBnjjq4bl2+8XsiOBy
	V32ZVfIw+r7OqkAoicy3qkA+UeHr2Ld1xNEx7CwL2tnUwB70tAXr9yLfLD2hU2DifM2Fqi8ZixpGB
	5Q7ganPwPxSS6skpPXAJmgPZN45dEBgohg6l7tweU1FFJS/GEXH0eIEbssOvP8lVOeig0Ds4+uEa4
	ppmuoPVDQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZhKQ-00046z-0B; Mon, 02 Nov 2020 21:25:26 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZhKN-00046F-B5
 for linux-nvme@lists.infradead.org; Mon, 02 Nov 2020 21:25:24 +0000
Received: by mail-ed1-x535.google.com with SMTP id v4so15855081edi.0
 for <linux-nvme@lists.infradead.org>; Mon, 02 Nov 2020 13:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=ErXtsrQtnPHS/yrrmKnFAGpvVrStovvmDs/h6X+o2Kk=;
 b=T1OsrJPXcFFSGtp8F7h+S/7uD+v2lSE76hmz6zjXYRDWFmaoxNDX/bvbmvtwczmW13
 Ky1c1qR+7TXGyzI+dJc0AZvcJvrQDDplA1jQjh/9db/RXYP9c3siY42KD7AuQsiLHQhn
 AWOHg4K4CVLz2vct+GPiGSKzt1CRyax7GIm+V3bQjUqFWnuWe8VkhL3gspcGzpTVHHHr
 cNI+WuDmonBPY5deLYY55XjEd7hnVvkqy1a2Nr0r9ygrI8oTDIigUGkhLlxUADlbB2SP
 5A3PlsNqXBrUfrxFIJW+4n5+IIO7n1mlkMk1jX6pEGVwRBIQD8mvRd9aKDp4+N4kF68K
 tNbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ErXtsrQtnPHS/yrrmKnFAGpvVrStovvmDs/h6X+o2Kk=;
 b=hTpuw5lS9Y2AasKeBXz0AZEM4VYKHduh6qS9nfpuB38+HECspamIDKOiAoix8XJ+o6
 9NcTRPQYLJ5rw2mQei1atguLK27D9yTGhzHLIJboewz9go1/PsUDEt0t8Awm1mGokpj+
 5exlE6HF7QtG3NGqcR8q0I3WcvdmhdFOzOd/fbix0BDIdmlyhzwclIecZZO5/tQEU4hm
 aQ8yF48wHfovB+iuzEG5zZ0HcVs3y5RJKZHedEKSH24yHytTewnj55ENFCa8B36TH6fc
 4du5W+ZshYfN8nqI60BOkHGP3opxjpEupBIhniQYtS+p33dtxoyPUTZCXHTKQpzR3A6m
 mHbQ==
X-Gm-Message-State: AOAM532Bwf1ajPLP7iySE+rnIDmDbLqNTSBzFWfG6axqyHRhSA58qoSE
 K2Tmv0+ME7/1cMjro8VLeN9UqQ==
X-Google-Smtp-Source: ABdhPJy+GKJTD8cN2G1oG+Nx4+B0Mh1+7ZE6Qn3hgyNAOyoFgGPObmuvSlpuAwDy6D65aYu0wftNDg==
X-Received: by 2002:a50:8d48:: with SMTP id t8mr19008866edt.228.1604352321965; 
 Mon, 02 Nov 2020 13:25:21 -0800 (PST)
Received: from localhost (5.186.126.247.cgn.fibianet.dk. [5.186.126.247])
 by smtp.gmail.com with ESMTPSA id bn25sm2240600ejb.76.2020.11.02.13.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 13:25:21 -0800 (PST)
From: Javier Gonzalez <javier@javigon.com>
X-Google-Original-From: Javier Gonzalez <javier.gonz@samsung.com>
Date: Mon, 2 Nov 2020 22:25:20 +0100
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: nvme: report capacity 0 for non supported ZNS SSDs
Message-ID: <20201102212520.4nbq47wkbn6fmrsc@MacBook-Pro.localdomain>
References: <CGME20201102161505eucas1p19415e34eb0b14c7eca5a2c648569cf1e@eucas1p1.samsung.com>
 <0916865d50c640e3aa95dc542f3986b9@CAMSVWEXC01.scsc.local>
 <20201102163000.GA203505@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201102163000.GA203505@localhost.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201102_162523_432831_A0875CE6 
X-CRM114-Status: GOOD (  17.85  )
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "joshi.k@samsung.com" <joshi.k@samsung.com>,
 "Klaus B. Jensen" <k.jensen@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMDIuMTEuMjAyMCAxNjozMCwgTmlrbGFzIENhc3NlbCB3cm90ZToKPk9uIE1vbiwgTm92IDAy
LCAyMDIwIGF0IDA0OjE1OjAxUE0gKzAwMDAsIEphdmllciBHb256YWxleiB3cm90ZToKPj4KPj4g
RnJvbTogS2VpdGggQnVzY2ggPGtidXNjaEBrZXJuZWwub3JnPgo+PiBTZW50OiBOb3YgMiwgMjAy
MCAxNjo0NQo+PiBUbzogSmF2aWVyIEdvbnrDoWxleiA8amF2aWVyQGphdmlnb24uY29tPgo+PiBD
YzogbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1ibG9ja0B2Z2VyLmtlcm5l
bC5vcmc7IGhjaEBsc3QuZGU7IHNhZ2lAZ3JpbWJlcmcubWU7IGF4Ym9lQGtlcm5lbC5kazsgam9z
aGkua0BzYW1zdW5nLmNvbTsgIktsYXVzIEIuIEplbnNlbiIgPGsuamVuc2VuQHNhbXN1bmcuY29t
PjsgTmlrbGFzLkNhc3NlbEB3ZGMuY29tOyBKYXZpZXIgR29uemFsZXogPGphdmllci5nb256QHNh
bXN1bmcuY29tPgo+PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBudm1lOiByZXBvcnQgY2FwYWNp
dHkgMCBmb3Igbm9uIHN1cHBvcnRlZCBaTlMgU1NEcwo+Pgo+PiBPbiBNb24sIE5vdiAwMiwgMjAy
MCBhdCAwMjoyMjoxNFBNICswMTAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+PiA+IENoYW5n
ZXMgc2luY2UgVjE6Cj4+ID4gICAgLSBBcHBseSBmZWVkYmFjayBmcm9tIE5pa2xhczoKPj4gPiAg
ICAgICAgLSBVc2UgSVNfRU5BQkxFRCgpIGZvciBjaGVja2luZyBjb25maWcgb3B0aW9uCj4+Cj4+
IFlvdXIgdjEgd2FzIGNvcnJlY3QuIFVzaW5nIElTX0VOQkFMRUQoKSBhdHRlbXB0cyB0byB1c2Ug
YW4gdW5kZWZpbmVkCj4+IHN5bWJvbCB3aGVuIHRoZSBDT05GSUcgaXMgbm90IGVuYWJsZWQ6Cj4+
Cj4+IE9oLiBPay4gV2lsbCByZXR1cm4gdG8gdGhhdC4KPgo+S2VpdGggaXMgY29ycmVjdCwgc29y
cnkgZm9yIHRoYXQuCj4KPmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvbGF0ZXN0L3By
b2Nlc3MvY29kaW5nLXN0eWxlLmh0bWwjY29uZGl0aW9uYWwtY29tcGlsYXRpb24KPgo+IlRodXMs
IHlvdSBzdGlsbCBoYXZlIHRvIHVzZSBhbiAjaWZkZWYgaWYgdGhlIGNvZGUgaW5zaWRlIHRoZSBi
bG9jawo+cmVmZXJlbmNlcyBzeW1ib2xzIHRoYXQgd2lsbCBub3QgZXhpc3QgaWYgdGhlIGNvbmRp
dGlvbiBpcyBub3QgbWV0LiIKPgoKTm8gd29ycmllcy4gVGhhbmtzIGZvciBwb2ludGluZyB0aGlz
IG91dCAtIEkgaGFkIHNlZW4gY29kZSB3aXRoCklTX0VOQUJMRUQoKSwgYnV0IEkgaGFkIG5vdCBk
b25lIHRoZSBuZWNlc3NhcnkgcmVhZGluZyB0byBkZXRlcm1pbmUgaWYKaXQgd2FzIHNvbWV0aGlu
ZyBJIHNob3VsZCB1c2Ugb3Igbm90LiBOb3cgSSBrbm93IDopCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B81C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:08:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D7FF2053B
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 11:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YGY/OSEJ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="i8m5TBik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D7FF2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+jwqWmF5Dze6su8Q7QjVLmfF9skLeVxwLKvTNTMmu6Q=; b=YGY/OSEJGXUMUTrKa/u0LItwv
	vi1a3S1ZnSQ6WW0zFJyC/NLa/4pTGhfPQRzrk9ASi95cEvCt7jGa3rAqOiecheWLck/g1BhlVs9Z0
	mFJgJfcVT6mVcIy6MCI3bbmHowg0Ju7xqE2FO0FMW2/YannA85NSX8V2siVTcXHPiXywlAlHkZyaJ
	2JJs/m+yrVV31W9JHnwrUvVBU+Tot3NPOmZJgwSIGBxFPl0kltFq2zNBVCK6EcJntt2DhGbHR7RxI
	0tqnUf1MjZavlGmGy+MfPnofV302dnSmXbHD2S4rVuJqixwNo/7MNIab/WDFS+41wKEjnM87V7KM2
	yJBJRqSAA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jomDO-0003S3-Pc; Fri, 26 Jun 2020 11:08:14 +0000
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jol2P-0003og-Hr
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 09:53:23 +0000
Received: by mail-lj1-x241.google.com with SMTP id e4so9673695ljn.4
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=oq1NZyvf1AcEgId735Moz3QUr8Xo/WfMRFU+37k8nnM=;
 b=i8m5TBikCUx5+vI4Di4KyLXgteUb/teOoPaNWjl/bqmMYr3TZ7gpaFaV5GvB0xdaQh
 NOuOMq+ivg9KIz3VUUUk/JfHs2KxGwlczkRvbpewlbJ0ljGi3XqGJfBHff70fQSrmgdp
 zZ9BrsG/0YRs/7NCroPWPp2yR8b058bmN48fPmrdgXXVrmNqpDcxV4I+8fT+E/FP/1LC
 FXt4MFQ9K1o8OaIJ5ehCQw08TuRSs73PDsN2FrPajHEn56nqNrk36mzMhgWb9wfGbueG
 e/pgQteKNu6bdCao5UExTLSq/raVHg4Ip2SfOCfP6nahUpRfd/9OHOuFmGAFJKBvq2u2
 PYmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=oq1NZyvf1AcEgId735Moz3QUr8Xo/WfMRFU+37k8nnM=;
 b=gHMtOlQJ8aOuRvd0HjQlOy17t/IqZFQscxqCELjS1eHJueNoxwQ5J5QaQXhfsV0N+r
 AtrSsHMIQmrwACbN8CMsrnaROmKI+lVLaUu3sIJf+JpfQBCfqr0Z6BFove/vu1F3dv3I
 MvEopz2JBh5bzOAn03gdpF6zFDo/qAqVKaEoEWbzGCEEJI3pZCbeyJE1CM0/fIhyRQWU
 3xI/pmNJcZ5sXwOX/WivrvJQaxPzoDpm+S3XFMi5XT07B7lGYSQssVtnazNGfdTahkSO
 YLgg346i/QXjhcRhVuyt4Y8k/2r00W7JxSJ6Q+pVT82zeaOE9tazpiIbk2VBFPeW9tLZ
 FDSg==
X-Gm-Message-State: AOAM531e5G+0k9nR+2jZNJ9k4E2YsW2B4nCERsCzHv2WzXn+6S3jjj8s
 3LGKwAAMTpLlZFEMPxGdjyx3d21fuCyg2vLw
X-Google-Smtp-Source: ABdhPJxeSI8gZmvwZQpO/0dnlCsm5oDAoXGH5DbHNJEnk/Plmh0jKMoJ4hD4tA1FyFqm/ao5sPXH9Q==
X-Received: by 2002:a17:906:4f13:: with SMTP id
 t19mr1138066eju.269.1593151992290; 
 Thu, 25 Jun 2020 23:13:12 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id s14sm11134214edq.36.2020.06.25.23.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 23:13:11 -0700 (PDT)
Date: Fri, 26 Jun 2020 08:13:10 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
Message-ID: <20200626061310.6invpvs2tzxfbida@mpHalley.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
 <20200625214921.GA1773527@dhcp-10-100-145-180.wdl.wdc.com>
 <MWHPR04MB3758829D20916B73DDB5581EE7930@MWHPR04MB3758.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <MWHPR04MB3758829D20916B73DDB5581EE7930@MWHPR04MB3758.namprd04.prod.outlook.com>
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
Cc: "axboe@kernel.dk" <axboe@kernel.dk>,
 SelvaKumar S <selvakuma.s1@samsung.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
 Kanchan Joshi <joshi.k@samsung.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Nitesh Shetty <nj.shetty@samsung.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjYuMDYuMjAyMCAwMDowNCwgRGFtaWVuIExlIE1vYWwgd3JvdGU6Cj5PbiAyMDIwLzA2LzI2
IDY6NDksIEtlaXRoIEJ1c2NoIHdyb3RlOgo+PiBPbiBUaHUsIEp1biAyNSwgMjAyMCBhdCAwMjoy
MTo1MlBNICswMjAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+Pj4gIGRyaXZlcnMvbnZtZS9o
b3N0L3pucy5jIHwgNyArKysrKysrCj4+PiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygr
KQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC96bnMuYyBiL2RyaXZlcnMv
bnZtZS9ob3N0L3pucy5jCj4+PiBpbmRleCA3ZDgzODFmZTc2NjUuLmRlODA2Nzg4YTE4NCAxMDA2
NDQKPj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3pucy5jCj4+PiArKysgYi9kcml2ZXJzL252
bWUvaG9zdC96bnMuYwo+Pj4gQEAgLTIzNCw2ICsyMzQsMTMgQEAgc3RhdGljIGludCBudm1lX25z
X3JlcG9ydF96b25lcyhzdHJ1Y3QgbnZtZV9ucyAqbnMsIHNlY3Rvcl90IHNlY3RvciwKPj4+ICAJ
CXNlY3RvciArPSBucy0+enN6ZSAqIG56Owo+Pj4gIAl9Cj4+Pgo+Pj4gKwlpZiAobnJfem9uZXMg
PCAwICYmIHpvbmVfaWR4ICE9IG5zLT5ucl96b25lcykgewo+Pj4gKwkJZGV2X2Vycihucy0+Y3Ry
bC0+ZGV2aWNlLCAiaW5jb25zaXN0ZW50IHpvbmUgY291bnQgJXUvJXVcbiIsCj4+PiArCQkJCXpv
bmVfaWR4LCBucy0+bnJfem9uZXMpOwo+Pj4gKwkJcmV0ID0gLUVJTlZBTDsKPj4+ICsJCWdvdG8g
b3V0X2ZyZWU7Cj4+PiArCX0KPj4+ICsKPj4+ICAJcmV0ID0gem9uZV9pZHg7Cj4+Cj4+IG5yX3pv
bmVzIGlzIHVuc2lnbmVkLCBzbyBpdCdzIG5ldmVyIDwgMC4KPj4KPj4gVGhlIEFQSSB3ZSdyZSBw
cm92aWRpbmcgZG9lc24ndCByZXF1aXJlIHpvbmVfaWR4IGVxdWFsIHRoZSBuYW1lc3BhY2Uncwo+
PiBucl96b25lcyBhdCB0aGUgZW5kLCB0aG91Z2guIEEgc3Vic2V0IG9mIHRoZSB0b3RhbCBudW1i
ZXIgb2Ygem9uZXMgY2FuCj4+IGJlIHJlcXVlc3RlZCBoZXJlLgo+PgoKSSBkaWQgc2VlIG5yX3pv
bmVzIGNvbWluZyB3aXRoIC0xOyBndWVzcyBpdCBpcyBteSBjb21waWxlci4KCj4KPlllcywgYWJz
b2x1dGVseS4gem9uZV9pZHggaXMgbm90IGFuIGFic29sdXRlIHpvbmUgbnVtYmVyLiBJdCBpcyB0
aGUgaW5kZXggb2YgdGhlCj5yZXBvcnRlZCB6b25lIGRlc2NyaXB0b3IgaW4gdGhlIGN1cnJlbnQg
cmVwb3J0IHJhbmdlIHJlcXVlc3RlZCBieSB0aGUgdXNlciwKPndoaWNoIGlzIG5vdCBuZWNlc3Nh
cmlseSBmb3IgdGhlIGVudGlyZSBkcml2ZSAoaS5lLiwgcHJvdmlkZWQgbnIgem9uZXMgaXMgbGVz
cwo+dGhhbiB0aGUgdG90YWwgbnVtYmVyIG9mIHpvbmVzIG9mIHRoZSBkaXNrIGFuZC9vciBzdGFy
dCBzZWN0b3IgaXMgPiAwKS4gU28KPnpvbmVfaWR4IGluZGljYXRlcyB0aGUgYWN0dWFsIG51bWJl
ciBvZiB6b25lcyByZXBvcnRlZCwgaXQgaXMgbm90IHRoZSB0b3RhbAoKSSBzZWUuIEFzIEkgY2Fu
IHNlZSwgd2hlbiBucl96b25lcyBjb21lcyB1bmRlZmluZWQgSSBiZWxpZXZlZCB3ZSBjb3VsZAph
c3N1bWUgdGhhdCB6b25lX2lkeCBpcyBhYnNvbHV0ZSwgYnV0IEkgY2FuIGJlIHdyb25nLgoKRG9l
cyBpdCBtYWtlIHNlbnNlIHRvIHN1cHBvcnQgdGhpcyBjaGVjayB3aXRoIGFuIGFkZGl0aW9uYWwg
Y291bnRlciBhbmQKYSBleHBsaWNpdCBucl96b25lcyBpbml0aWFsaXphdGlvbiB3aGVuIHVuZGVm
aW5lZCBvciB5b3UKcHJlZmVyIHRvIGp1c3QgcmVtb3ZlIGl0IGFzIE1hdGlhcyBzdWdnZXN0ZWQ/
CgpKYXZpZXIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpo
dHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

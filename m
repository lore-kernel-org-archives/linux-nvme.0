Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09149C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 16:25:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC13F20791
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 16:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KSnz6dtr";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="fo9I1T9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC13F20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:In-Reply-To:References:Message-Id:Date:Subject:
	Mime-Version:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qUQYqusgj7JyZIMNOajEAJ6QJ5WzXlYyhBAnx6mm2Bg=; b=KSnz6dtr4oTVW/HJSGyvotrih
	Epe5uKR73t1fz2ciizMH/Q0lir4qF/reG36FqX5VllXzNJglTDdLMSTu0/UxIYaZ7EPBMTlUnXUTl
	g1aa1GECQmiiwIDMDMz9Nrv9lAOlRnA6y7U0wfWuWW3qc+bXGLGhDmlBRukMlv7Iob9zmjik+icMk
	ypBWFupo3+HEEUQNnlmvRxZSmjZ0r0iBWQ+XcgI/oHpAM3B26E34RWMVA7Wj3vmKQNFonrlj2CTc5
	GIXzJln83pBns22dGEwlwE628QMQPmwxUEWqCzNGTub3WAUqjCMfvxKCfgqbQlC0PKrJOh88+dRXJ
	+uHl+Dgtw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jorAB-00021f-Q1; Fri, 26 Jun 2020 16:25:15 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jorA8-00020X-3S
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 16:25:13 +0000
Received: by mail-ed1-x541.google.com with SMTP id d15so7365559edm.10
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 09:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=JmQ1A0vGh7Xxt46gow4Vy8pp18yVO8i7HKAvWSMhmBk=;
 b=fo9I1T9uGN5+4oNHkuOJ7sTyIW12MmMPzQeYW0gUtg+XfqwkgRXBDE7XKbsJn2TMCT
 PnXdSvbPiqFcOUF0RtAI9HSNXGOIt0bgB5d/t7fBBARbJTH2tA8iCxFxqOELGm3vtZC1
 EUoZtT3tohebDXXlAysvvFbXVjrDRPtEMoDRerqhtg5MpG/Lin+52/tRA4YtHT6y9aF7
 j390lVVZ6Rk2c87ul62gYhHP8hOPdOZDPl9jKnPGOnBDNT4mehGTEwY1oJMQCa1D5FEK
 iLksPKy81v8AZr9oC+imn6IT0fFszpWVuwNwiPYk+02U+3Ttz57rpwslcln7uHcuCK8C
 xpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=JmQ1A0vGh7Xxt46gow4Vy8pp18yVO8i7HKAvWSMhmBk=;
 b=Lcq2zPClNWl6EsdBI0jwnVnPZqdqGsPyICjL7xSsuQ8eL1huKzy8cI6U0bmHkHcv43
 w8H6szgQRXLg/GffTIpOlErKP8Vt7LHuOXWqexU3HQXWJWTLmdyNI4hrbs32Vr4/8Uyl
 HzeGZkgatO3bNi9aR89DZb0Cp5PVa/NkZwbKE/3RWv+JeVssOrSmFKLQdMKfOqpxBUg1
 DHceyrl6SV800WnatNdgHVViUV5kNMoWHeQmW4TP2dRRIvSbKQ4cGEwC4QHZdjaMmZkU
 H7Y84SwHrLf2p80BfD/4cF5azYgk5uzdtIidEh2QHaulgib4f4D1+OMppUyll/rdCiHD
 fGdQ==
X-Gm-Message-State: AOAM530pzn584MUqF/3blEcdsMSDxdrXMotBtpg98rb5jNW8zlHof97b
 QR0uYvQAH5E9oKck6a6QB4BdAw==
X-Google-Smtp-Source: ABdhPJxOEtUI8X/VPkdyKqw3YxFUm77242GA2tpY1LE/AGyLDwTVZDpZaZjuU3yr83xqTCR4wojHvA==
X-Received: by 2002:a05:6402:1217:: with SMTP id
 c23mr4169817edw.270.1593188707993; 
 Fri, 26 Jun 2020 09:25:07 -0700 (PDT)
Received: from [192.168.2.16] (ip-5-186-127-235.cgn.fibianet.dk.
 [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id lv17sm9073093ejb.56.2020.06.26.09.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 09:25:07 -0700 (PDT)
From: =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 4/6] block: introduce IOCTL to report dev properties
Date: Fri, 26 Jun 2020 18:25:06 +0200
Message-Id: <E5BC0C5B-C99F-40E2-9C17-0AFEFCE2446A@javigon.com>
References: <20200626155225.GA1774486@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200626155225.GA1774486@dhcp-10-100-145-180.wdl.wdc.com>
To: Keith Busch <kbusch@kernel.org>
X-Mailer: iPhone Mail (17F80)
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
Cc: axboe@kernel.dk, SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
 Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
 =?utf-8?Q?Matias_Bj=C3=B8rling?= <mb@lightnvm.io>, hch@lst.de
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gT24gMjYgSnVuIDIwMjAsIGF0IDE3LjUyLCBLZWl0aCBCdXNjaCA8a2J1c2NoQGtlcm5lbC5v
cmc+IHdyb3RlOgo+IAo+IO+7v09uIEZyaSwgSnVuIDI2LCAyMDIwIGF0IDA4OjI4OjI4QU0gKzAy
MDAsIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4+PiBPbiAyNi4wNi4yMDIwIDA1OjI1LCBLZWl0
aCBCdXNjaCB3cm90ZToKPj4+IE9uIFRodSwgSnVuIDI1LCAyMDIwIGF0IDA5OjQyOjQ4UE0gKzAy
MDAsIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4+Pj4gV2UgY2FuIHVzZSBudm1lIHBhc3N0aHJ1
LCBidXQgdGhpcyBieXBhc3NlcyB0aGUgem9uZWQgYmxvY2sgYWJzdHJhY3Rpb24uCj4+Pj4gV2h5
IG5vdCByZXByZXNlbnRpbmcgWk5TIGZlYXR1cmVzIGluIHRoZSBzdGFuZGFyZCB6b25lZCBibG9j
ayBBUEk/Cj4+PiAKPj4+IFRoaXMgbG9va3MgdG9vIG52bWUgem5zIHNwZWNpZmljIHRvIHdhbnQg
dGhlIGJsb2NrIGxheWVyIGluIHRoZSBtaWRkbGUuCj4+PiBKdXN0IHVzZSB0aGUgZHJpdmVyJ3Mg
cGFzc3Rocm91Z2ggaW50ZXJmYWNlLgo+PiAKPj4gT2suIElzIGl0IE9LIHdpdGggeW91IHRvIGV4
cG9zZSB0aGVtIGluIHN5c2ZzIGFzIERhbWllbiBzdWdnZXN0ZWQ/Cj4gCj4gc3lzZnMgc291bmRz
IGZpbmUgdG8gbWUgZm9yIHNvbWUgYXR0cmlidXRlcyAoZXg6IG1hci9tb3IpLCBidXQgSSBkb24n
dAo+IHRoaW5rIGV2ZXJ5IHpucyBwcm9wZXJ0eSB3YXJyYW50cyBleHBvc2luZyB0aHJvdWdoIHRo
aXMgaW50ZXJmYWNlLiBJCj4ganVzdCBkb24ndCB3YW50IHRvIGNvcm5lciBkcml2ZXIgbWFpbnRl
bmFuY2UgaW50byBjaGFzaW5nIGV2ZXJ5IHNwZWMKPiBmaWVsZC4gSWYgYXBwbGljYXRpb25zIHJl
YWxseSB3YW50IGV2ZXJ5IGxhc3QgZGV0YWlsLCB0aGV5IGNhbiBnZXQgaXQKPiBkaXJlY3RseSBm
cm9tIHRoZSBkZXZpY2Ugd2l0aG91dCBhbnkga2VybmVsIGRlcGVuZGVuY2llcy4KCk9rLiBUaGlu
ayBOaWtsYXMgc2VudCBhIHBhdGNoIHdpdGggbWFyL21vciBhbHJlYWR5LiBXaWxsIGNoZWNrIHdo
aWNoIG9uZXMgd2UgZGVwZW5kIG9uIGluIHVzZXIgc3BhY2UuIApfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

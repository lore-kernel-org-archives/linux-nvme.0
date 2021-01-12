Return-Path: <SRS0=XnCc=GP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6084CC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 18:41:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E30842222A
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jan 2021 18:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E30842222A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VDmi+Lwr4lIcJ8WPRH9NEreVETLt7UIBrLfm9es20A0=; b=2L76sBSj0W63TDuWTduMMAIF0
	1jBn+lKJONBVnabV4LdsTdye+weJMt51yLBs3fCIZfZ6EDIv29FCMApaErPXfEea4shASr6adRF7w
	VxG9CuLFAzF/145ON4ctmMeJS957U93HM2nS3gpT3qteKTI1nMEqUjAtWSc9njWGWKmeJDar3BLGw
	FBanTuYy0RQ+euFvimDME+FynVNqn8mwZmkHoty6qXQ53feH7T6/eATwqWRMNlv88aE3yZsdYbN9g
	wuYG6InRjSK8XSTtJ0sWduk2nyBG4Iw6x2otH5zeXS0cCcvOfozdnrwu95W1YvljvUxuE7RgWeQE2
	i0jku5E0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzObR-0004OL-KB; Tue, 12 Jan 2021 18:41:13 +0000
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzObP-0004NJ-KQ
 for linux-nvme@lists.infradead.org; Tue, 12 Jan 2021 18:41:12 +0000
Received: by mail-wm1-x32c.google.com with SMTP id g10so1353503wmh.2
 for <linux-nvme@lists.infradead.org>; Tue, 12 Jan 2021 10:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=w4WSdwQHCuBBoHOg1WZaw9qfXJ+QY/Ppef3OSGAHOA0=;
 b=bq5JZKKAb79n+BSBUQXdU7UHQaRL9LdBEp8Lrl3CMJwWYj4p6msErVgfZI2jlCo48l
 Nim0IOZsK85nZb3Ygo8maY5FcB33ysVBhhjswfjElQSR3PyemFQ6e7/1n+CvBI5kZTDv
 ngm4pEDjeJSZV9k9KWMYK/6JM7ir4JGZ2Gv5NRJpbd9Q6QqstyZT2cKjJqSrjl/ad6lg
 itTXC/fODp1VoqPkQN1vJy2Rl4LyNaly7vga3zJOjmFH8dSVv+36hwekdRMjW4g+ljVA
 Wc4tK6fSIUimhMerYa/y6v35BRwL42uAhKEi3Cc4CPT2QlbImEsJPo9LbeIKut1/Oj8P
 Loew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=w4WSdwQHCuBBoHOg1WZaw9qfXJ+QY/Ppef3OSGAHOA0=;
 b=TLg5NudYR3dNBbMfZdmAu9bPJF13HFFbAf7m0hL6d0Qsx+9kgcb2g52E/Y+inG+WCm
 lU4Sqd+SeE0Lrcc4bW8k93QCBSHtjZSyZWkHG2VtwQg+owT5QOGAklHdIxJHVIoOSyK+
 eNqfE4oDlTdq1clM8DlZxekn1CA5kDYznIloLXQ+BZji5TwxT4d04IOcAFDF7zj0twkz
 PRfGvs+EbvTD7cBN87sxDSSiftuGbcZdvuGBIywNOHEhb3ErhiZhyI+mwZ0f6rU8k1/n
 RyCxqA7Y0QdAiDFGDTRLffwvpNgyC1/tsKuZFoao46FVYjdMH8HeoLuwL4PFYYgqFIP2
 prMA==
X-Gm-Message-State: AOAM530uV1W9choSqSlw8uOds1MvtNDbDeVdCFzfC7DlvACUn/cXKzZS
 apXci1BOSB5CrwRgXxBhYxprEg==
X-Google-Smtp-Source: ABdhPJxx3J9+uNlXGEKW8tNS+zV8I7UkvHkJu286t4sUVejfG/Cl77KRY7Ay8SlrhUnSXmtUxQdGIA==
X-Received: by 2002:a1c:4843:: with SMTP id v64mr586660wma.186.1610476870119; 
 Tue, 12 Jan 2021 10:41:10 -0800 (PST)
Received: from localhost (5.186.124.214.cgn.fibianet.dk. [5.186.124.214])
 by smtp.gmail.com with ESMTPSA id v11sm6125820wrt.25.2021.01.12.10.41.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Jan 2021 10:41:09 -0800 (PST)
Date: Tue, 12 Jan 2021 19:41:08 +0100
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: nvme: enable char device per namespace
Message-ID: <20210112184108.x42fhpdtfn2a24wz@unifi>
References: <CGME20201216181838eucas1p15c687e5d1319d3fa581990e6cca73295@eucas1p1.samsung.com>
 <20201216181828.21040-1-javier.gonz@samsung.com>
 <20210111185347.oqqzdmoglg3lzo5y@mpHalley.localdomain>
 <20210112092207.GA4888@localhost.localdomain>
 <20210112183055.u3y34tfxh4d5aeue@unifi>
 <20210112183303.GA5050@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210112183303.GA5050@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210112_134111_683772_10047FA4 
X-CRM114-Status: GOOD (  14.25  )
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
Cc: linux-block@vger.kernel.org, kbusch@kernel.org,
 Minwoo Im <minwoo.im.dev@gmail.com>, sagi@grimberg.me,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTIuMDEuMjAyMSAxOTozMywgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj5PbiBUdWUsIEph
biAxMiwgMjAyMSBhdCAwNzozMDo1NVBNICswMTAwLCBKYXZpZXIgR29uesOhbGV6IHdyb3RlOgo+
PiBJIGhhdmUgbm90IGltcGxlbWVudGVkIG11bHRpcGF0aCBzdXBwb3J0LCBidXQgaXQgc2hvdWxk
IGRlZmluaXRlbHkgbm90Cj4+IGNyYXNoIGxpa2UgdGhpcy4gSSdsbCByZWJhc2UgdG8gNS4xMSBh
bmQgdGVzdC4KPj4KPj4gQ2hyaXN0b3BoOiBJcyBpdCBPSyB0byBzZW5kIHRoaXMgd2l0aG91dCBt
dWx0aXBhdGggb3Igc2hvdWxkIEkganVzdCBzZW5kCj4+IGFsbCB0b2dldGhlcj8KPgo+V2UncmUg
bm90IGluIGEgcnVzaCBhdCB0aGUgbW9tZW50LCBzbyBJJ2QgcHJlZmVyIHdvcmtpbmcgbXVsdGlw
YXRoCj5zdXBwb3J0IGlmIHlvdSBjYW4gc3BhcmUgYSBmZXcgY3ljbGVzLgoKU3VyZS4gSSdsbCB3
b3JrIG9uIHRoYXQgYW5kIHN1Ym1pdCBhbGwgdW5kZXIgdGhlIHNhbWUgcGF0Y2hzZXQuCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1h
aWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

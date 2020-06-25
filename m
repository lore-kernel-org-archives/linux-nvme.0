Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C09C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:15:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4927F20768
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QPQImXAa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mwcdSbIY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="I11KMzCm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4927F20768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=keYDMoBQNQUKFi2lFBlp0eVnUDqewRScEGRAt1OOAn4=; b=QPQImXAaDj/L+WcmWy7mwnITk
	T1agY9k+p0N3qseAR6XC4aKR6fv/8wnTwrtUx84mM9F29UwFjqVYP130u0RFpljhF085J6KU+rUt0
	+zbNbk5pXtsB/11rwrKZ/H8PTy8oAB/aMQ9A4+tkIk1tL5fI/9iR++CMibdd446vrqVRLKF7INZrL
	ty3W0G6jTqZjLBBUckHLcBSJdvmyHY83L1VpeE/tqw5x9ve/+AR3upJ/8MqCHFPNamiREd+SDvum1
	phOnl8LOeqR/T2hWhuANF/BHoVt3QYYGThvQ7h9Xv0RbrCeNpKpJQhezWYssExKuMpSi/hRBHaW2J
	NXo3O+SOQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jonGB-0008GW-NL; Fri, 26 Jun 2020 12:15:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jomo8-0002pk-Li
 for linux-nvme@merlin.infradead.org; Fri, 26 Jun 2020 11:46:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=LEsN02TD2NfJjwSK4xJpn95bFrWqOr+Dp2f+nTtJnEs=; b=mwcdSbIYEMoXgNEOrDUoa09mnF
 J+gEcc41S6Ks5sxfTYhvO5/6ajAOMLw6gSOpX7XhNmeOCoVid3Fo5LQhzzx+9u/M1o5HGlTpD8NGp
 GPuGxyuE12xSv5Ek2RRYglvQafx8fG6uMt+5aAadNKHuNANhixHUZyCpp9B8DzJiPtv6rU7xSzqhz
 amMdYPsYTxOitOEmGFHFOcf62mfC9ZXUNtrdjQkf5LIZ9X1YAfJHyIaxzo4bn0aBHdlfMdXzpCQmE
 pP+4BtVNC8BxTbze7Aw4zklc5c08jF+IBxW4Yq/pSJyMWP0zklfGMQJJkpXEbj/9K0Emz0oYNjBB9
 ltrleQmg==;
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jomXa-0007ne-Ls
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 11:29:23 +0000
Received: by mail-ed1-x541.google.com with SMTP id g20so6420050edm.4
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 04:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=LEsN02TD2NfJjwSK4xJpn95bFrWqOr+Dp2f+nTtJnEs=;
 b=I11KMzCm1c4uwoEwh/vfPrmhuZZTPf7zJk9bn/oTzsPOdH5m7SS6LvOZNNeoxdCKnb
 20CjRJAqln/dfB2pAvmDhcu1CpwHtM295EVG9DyCJ/XKaqYeXSZ7PmYALZ/bzJOsyZX+
 dMjF018DOrSzNOnV9HrproyBVbOQqNZN/TH9keym/JaVJjOPdZJbQ/0D2pYKMMcf5QOK
 Kk0QfHai+vxhWtzt3t8RjzUK2qAcVIXjacRaoIiSckvjuACedYpza2Z4rWX6CTl3FBEg
 ePAWS4w1+CYHuMACwb5QRlGyK9Q4O/UmcJQeXLHeI9ExrKX2a4fI2o+Jw347yp4xUz3J
 2Ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=LEsN02TD2NfJjwSK4xJpn95bFrWqOr+Dp2f+nTtJnEs=;
 b=gYX8unAL0JEZ8roE8+8jyDNO07DMgy+2p8oz1NnlC/KCdmihxr7+JmBr8ILLyVhkm0
 ctQJl802W9Zdx5IchJfykVoiNwxBv2OqapZeXBboPGIfJ/U2mvNZ7BJ4R/uJz45Fhf7i
 Bu6u0+DKzjwm73vDzTZpX+yREF0r7m6Zh7xC2EgU3r76Qh4Yv+1OC3F/f9U3D3SptcXw
 LEfN8RcJXFPfyZkCbT0PhrRRK73ef3AS3swT5W3iglJRHmiwwiyiI++z6rPWPtqmaW2f
 nPrqoKs7UGIF6EafV+w7olyAljBJuQIFYEScPFY7i5KZO7VL+gPeRpYKeUY0aB6aerFZ
 2g+A==
X-Gm-Message-State: AOAM532kI8Zg65c1OSpJZwjTIeabi4Uihz09EXLJ3fpDshZlaWaSfzm8
 QlYTiyW4TT/wJEtJe7bjVKlKhc4ZxwlTECJB
X-Google-Smtp-Source: ABdhPJxn9WE1PPEUFRlBfDmfNh4vCP5hZ/o/wTfpHcjCsucpxN9RqQvmaNHqWKvEiLfe3YwgfnJkXw==
X-Received: by 2002:a05:6402:2064:: with SMTP id
 bd4mr8375875edb.180.1593114302411; 
 Thu, 25 Jun 2020 12:45:02 -0700 (PDT)
Received: from localhost (ip-5-186-127-235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id f17sm5394548ejr.71.2020.06.25.12.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 12:45:01 -0700 (PDT)
Date: Thu, 25 Jun 2020 21:45:00 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Subject: Re: [PATCH 6/6] nvme: Add consistency check for zone count
Message-ID: <20200625194500.io3e6fbju6l6fkms@MacBook-Pro.localdomain>
References: <20200625122152.17359-1-javier@javigon.com>
 <20200625122152.17359-7-javier@javigon.com>
 <0cd0ad57-ec21-3d20-d74d-7e454614f06f@lightnvm.io>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0cd0ad57-ec21-3d20-d74d-7e454614f06f@lightnvm.io>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200626_122908_091718_39C1A07D 
X-CRM114-Status: GOOD (  16.28  )
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
 kbusch@kernel.org, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjUuMDYuMjAyMCAxNToxNiwgTWF0aWFzIEJqw7hybGluZyB3cm90ZToKPk9uIDI1LzA2LzIw
MjAgMTQuMjEsIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4+RnJvbTogSmF2aWVyIEdvbnrDoWxl
eiA8amF2aWVyLmdvbnpAc2Ftc3VuZy5jb20+Cj4+Cj4+U2luY2UgdGhlIG51bWJlciBvZiB6b25l
cyBpcyBjYWxjdWxhdGVkIHRocm91Z2ggdGhlIHJlcG9ydGVkIGRldmljZQo+PmNhcGFjaXR5IGFu
ZCB0aGUgWk5TIHNwZWNpZmljYXRpb24gYWxsb3dzIHRvIHJlcG9ydCB0aGUgdG90YWwgbnVtYmVy
IG9mCj4+em9uZXMgaW4gdGhlIGRldmljZSwgYWRkIGFuIGV4dHJhIGNoZWNrIHRvIGd1YXJhbnRl
ZSBjb25zaXN0ZW5jeSBiZXR3ZWVuCj4+dGhlIGRldmljZSBhbmQgdGhlIGtlcm5lbC4KPj4KPj5T
aWduZWQtb2ZmLWJ5OiBKYXZpZXIgR29uesOhbGV6IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4K
Pj5TaWduZWQtb2ZmLWJ5OiBTZWx2YUt1bWFyIFMgPHNlbHZha3VtYS5zMUBzYW1zdW5nLmNvbT4K
Pj5TaWduZWQtb2ZmLWJ5OiBLYW5jaGFuIEpvc2hpIDxqb3NoaS5rQHNhbXN1bmcuY29tPgo+PlNp
Z25lZC1vZmYtYnk6IE5pdGVzaCBTaGV0dHkgPG5qLnNoZXR0eUBzYW1zdW5nLmNvbT4KPj4tLS0K
Pj4gIGRyaXZlcnMvbnZtZS9ob3N0L3pucy5jIHwgNyArKysrKysrCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspCj4+Cj4+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3pu
cy5jIGIvZHJpdmVycy9udm1lL2hvc3Qvem5zLmMKPj5pbmRleCA3ZDgzODFmZTc2NjUuLmRlODA2
Nzg4YTE4NCAxMDA2NDQKPj4tLS0gYS9kcml2ZXJzL252bWUvaG9zdC96bnMuYwo+PisrKyBiL2Ry
aXZlcnMvbnZtZS9ob3N0L3pucy5jCj4+QEAgLTIzNCw2ICsyMzQsMTMgQEAgc3RhdGljIGludCBu
dm1lX25zX3JlcG9ydF96b25lcyhzdHJ1Y3QgbnZtZV9ucyAqbnMsIHNlY3Rvcl90IHNlY3RvciwK
Pj4gIAkJc2VjdG9yICs9IG5zLT56c3plICogbno7Cj4+ICAJfQo+PisJaWYgKG5yX3pvbmVzIDwg
MCAmJiB6b25lX2lkeCAhPSBucy0+bnJfem9uZXMpIHsKPj4rCQlkZXZfZXJyKG5zLT5jdHJsLT5k
ZXZpY2UsICJpbmNvbnNpc3RlbnQgem9uZSBjb3VudCAldS8ldVxuIiwKPj4rCQkJCXpvbmVfaWR4
LCBucy0+bnJfem9uZXMpOwo+PisJCXJldCA9IC1FSU5WQUw7Cj4+KwkJZ290byBvdXRfZnJlZTsK
Pj4rCX0KPj4rCj4+ICAJcmV0ID0gem9uZV9pZHg7Cj4+ICBvdXRfZnJlZToKPj4gIAlrdmZyZWUo
cmVwb3J0KTsKPgo+U291bmRzIGxpa2UgYSBjaGVjayBmb3IgYSBicm9rZW4gaW1wbGVtZW50YXRp
b24uIEZvciBpbXBsZW1lbnRhdGlvbnMgCj5pbiB0aGUgd2lsZCB0aGF0IGV4aGliaXRzIHRoaXMg
YmVoYXZpb3IsIGEgcXVpcmsgY2FuIGJlIGFkZGVkLiBUaGlzIAo+a2luZCBvZiBjaGVjayBpcyBn
ZW5lcmFsbHkgbm90IG5lZWRlZC4gVGhpcyBjYW4gZWFzaWx5IGJlIGNoZWNrZWQgYnkgCj5oYXZp
bmcgYSB0ZXN0IGNhc2UgaW4gYSB2YWxpZGF0aW9uIHN1aXRlLiBUaGUga2VybmVsIHNob3VsZCBu
b3QgaGF2ZSAKPnRvIGNoZWNrIGZvciBpdC4KPgoKSSBkb24ndCBiZWxpZXZlIGl0IGh1cnRzIHRv
IHZhbGlkYXRlIGFzIFpOUyBwcm92aWRlcyBhIG1ldGhvZCB0bwpyZXRyaWV2ZSB0aGUgYWN0dWFs
IG51bWJlciBvZiB6b25lcy4gSXQgY2FuIGhlbHAgcGVvcGxlIGRldGVjdGluZyBhbgppc3N1ZSB0
aGF0IGNhbiBoaWRlIGZvciBzb21lIHRpbWUuCgpJZiB0aGUgZ2VuZXJhbCBvcGluaW9uIGlzIHRo
YXQgdGhpcyBiZWxvbmdzIHRvIGEgdGVzdCBzdWl0ZSwgd2UgY2FuIGFkZAppdCB0byBibGt0ZXN0
cyAoYWxyZWFkeSBoYXZlIGl0IHRoZXJlIGludGVybmFsbHkpLiBXZSBjYW4gYWxzbyBoYXZlIGl0
CmluIGJvdGggcGxhY2VzLgoKSmF2aWVyCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==

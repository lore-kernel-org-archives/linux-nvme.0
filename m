Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA83C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 18:11:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE60B206B5
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 18:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kB+2KX/h";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="MqABaEdd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE60B206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=nWlJk2DUfmxzw9fzfUuZq9x3TyTgnivvgB+aIX/opeA=; b=kB+2KX/hFtFSl56sjO0G2X0Ja
	O2mMqsDSx16DZ+dETw1kSq3ww7D8lXxSsi5vJUCQ5pflEZps+k7piBjW/NqamFTFWkAeEGolcbO6D
	xXlT3Jw1fJTB9lutyjfEI6ddOZPHqFiUwPP5nvSpKjWnIJEGYNw/3yBDztalRTDPtWit4gxgL8fgB
	tzpdVqWHLxdgP4yDMLhtYKZ7yq/6Z78DHUxpDVGx86sRCLZjcL6fFaVDuJ7SNvLXV4kT03q0C3XUc
	3ch44uIo0CfxyCHfS7PHYmCfeS6jx5RAQyymIGAICVo+3leIYQzhobH6BvDBeZCu6EwV+Nz+2b/J6
	8cE1WOXrQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8653-0007YN-PN; Tue, 18 Aug 2020 18:11:29 +0000
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8651-0007Xh-KS
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 18:11:28 +0000
Received: by mail-ed1-x543.google.com with SMTP id l23so15984463edv.11
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 11:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=UJn2JSokJqI3bZ4orYuEJrjW3L7HkGjOPI8uUsExMI0=;
 b=MqABaEddV5U7jNhWTNamW1+A8wcSXlLpQCJNnUuoQKGjYyrWrzW8LTsHUFA7RT+bSH
 DF7X8MWOtpMq7uXTQw04MxtDSMVh1SxRfo0KdwfjvY2gt6YobioaGJ2neqr7IAI6SqGQ
 NTNcD8L6vHWV7uEyH7kTiXBK7wBnMD+tvi2cPupLPWRA+8QO0DtZ0LiZGfjG7cHwNBRN
 a/sT69GmrMRL2uecX2mSNBp/JYG8QCzg6mRIAwHn7xF+k1E7BhtgZhcKGE8gc9IuzMAy
 129vfn8fxai1e8/i6u0mxY9iNo2O+EwQrGXqqdpDOQzHVFxMkdBE2NMRO2kUS1Sl78jY
 aDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=UJn2JSokJqI3bZ4orYuEJrjW3L7HkGjOPI8uUsExMI0=;
 b=TRuEcPSsI+3aQdf0eyIkeGchE+Hw+nP1eulFbZ5wA/UmARbKzE52RvqDhUB1Nk3f0P
 7TlBEYr6CnfpZCGbg27IcKq8macs9bDRiWdKlI6KkdxTMbPIiSsRi0ZUUJROWaBAFaLz
 Z5lXytofzXnwOfQFs1rPdhzGxCOFfsUKxh6YG5xXq2Vz7nPtCzpjTPc3wEzv+fYbqVko
 yvfBi9LmsaZ3YAmnBkVb1MO9i9BBu6t1LZ1QQSGvrukjvZ1PtdhGvrFY+wSWLvJ56+/e
 6oAk3EpZyyT9IwEx2s2YEpwSRrLx+jIewI4kcfwLnGqP+9DKOr8HBBOxfaDgtDQpYlf/
 4ZYw==
X-Gm-Message-State: AOAM5333p3pdq//Dn58JrSULbpp9vJgSSyqoTSfq2xVQumWkucEXelIP
 1CHAh0kRd007a/qKubDMtJyhKg==
X-Google-Smtp-Source: ABdhPJwmIpf0nigHCByv+fTuHCc4oxGRcbWfdXEg1x6hKKHOSCoLdKN/KTR7FfEZpqrl5cijFAL4nQ==
X-Received: by 2002:aa7:c358:: with SMTP id j24mr20163939edr.377.1597774285947; 
 Tue, 18 Aug 2020 11:11:25 -0700 (PDT)
Received: from localhost (5.186.127.235.cgn.fibianet.dk. [5.186.127.235])
 by smtp.gmail.com with ESMTPSA id v23sm11594092ejh.84.2020.08.18.11.11.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 11:11:24 -0700 (PDT)
Date: Tue, 18 Aug 2020 20:11:24 +0200
From: Javier Gonzalez <javier@javigon.com>
To: Matias =?utf-8?B?QmrDuHJsaW5n?= <mb@lightnvm.io>
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
Message-ID: <20200818181124.2ys5urtkodpkamsr@MacBook-Pro.localdomain>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com>
 <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
 <4ae89443-d8ae-4efb-581e-b635c21b27de@lightnvm.io>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4ae89443-d8ae-4efb-581e-b635c21b27de@lightnvm.io>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_141127_714605_FA7D4571 
X-CRM114-Status: GOOD (  16.65  )
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
Cc: axboe@kernel.dk, Damien.LeMoal@wdc.com,
 SelvaKumar S <selvakuma.s1@samsung.com>, sagi@grimberg.me,
 Kanchan Joshi <joshi.k@samsung.com>, johannes.thumshirn@wdc.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Nitesh Shetty <nj.shetty@samsung.com>, kbusch@kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTguMDguMjAyMCAxMjo1MSwgTWF0aWFzIEJqw7hybGluZyB3cm90ZToKPk9uIDE4LzA4LzIw
MjAgMTEuNTAsIEphdmllciBHb256YWxleiB3cm90ZToKPj5PbiAxOC4wOC4yMDIwIDA5OjEyLCBD
aHJpc3RvcGggSGVsbHdpZyB3cm90ZToKPj4+T24gVHVlLCBBdWcgMTgsIDIwMjAgYXQgMTA6NTk6
MzZBTSArMDUzMCwgS2FuY2hhbiBKb3NoaSB3cm90ZToKPj4+PklmIGRyaXZlIGRvZXMgbm90IHN1
cHBvcnQgem9uZS1hcHBlbmQgbmF0aXZlbHksIGVuYWJsZSBlbXVsYXRpb24gdXNpbmcKPj4+PnJl
Z3VsYXIgd3JpdGUuCj4+Pj5NYWtlIGVtdWxhdGVkIHpvbmUtYXBwZW5kIGNtZCB3cml0ZS1sb2Nr
IHRoZSB6b25lLCBwcmV2ZW50aW5nCj4+Pj5jb25jdXJyZW50IGFwcGVuZC93cml0ZSBvbiB0aGUg
c2FtZSB6b25lLgo+Pj4KPj4+SSByZWFsbHkgZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIGFkZCB0aGlz
LsKgIFpOUyBhbmQgdGhlIExpbnV4IHN1cHBvcnQKPj4+d2VyZSBhbGwgZGVzaWduZWQgd2l0aCBa
b25lIEFwcGVuZCBpbiBtaW5kLCBhbmQgdGhlbiB5b3VyIGNvbXBhbnkgZGlkCj4+PnRoZSBuYXN0
aWVzdCBwb3NzaWJsZSBtb3ZlIHZpb2xhdGluZyB0aGUgbm9ybWFsIE5WTWUgcHJvY2VkdXJlcyB0
byBtYWtlCj4+Pml0IG9wdGlvbmFsLsKgIEJ1dCB0aGF0IGRvZXNuJ3QgY2hhbmdlIHRoZSBmYWN0
IHRoZSBMaW51eCBzaG91bGQga2VlcAo+Pj5yZXF1aXJpbmcgaXQsIGVzcGVjaWFsbHkgd2l0aCB0
aGUgYW1vdW50IG9mIGNvZGUgYWRkZWQgaGVyZSBhbmQgaG93IGl0Cj4+Pmhvb2tzIGluIHRoZSBm
YXN0IHBhdGguCj4+Cj4+SSB1bmRlcnN0YW5kIHRoYXQgdGhlIE5WTWUgcHJvY2VzcyB3YXMgYWdp
dGF0ZWQgYW5kIHRoYXQgdGhlIGN1cnJlbnQgWk5TCj4+aW1wbGVtZW50YXRpb24gaW4gTGludXgg
cmVsaWVzIGluIGFwcGVuZCBzdXBwb3J0IGZyb20gdGhlIGRldmljZQo+PnBlcnNwZWN0aXZlLiBI
b3dldmVyLCB0aGUgY3VycmVudCBUUCBkb2VzIGFsbG93IGZvciBub3QgaW1wbGVtZW50aW5nCj4+
YXBwZW5kLCBhbmQgYSBudW1iZXIgb2YgY3VzdG9tZXJzIGFyZSByZXF1aXJpbmcgdGhlIHVzZSBv
ZiBub3JtYWwKPj53cml0ZXMsIHdoaWNoIHdlIHdhbnQgdG8gc3VwcG9ydC4KPgo+VGhlcmUgaXMg
YSBsb3Qgb2YgdGhpbmdzIHRoYXQgaXMgc3BlY2lmaWVkIGluIE5WTWUsIGJ1dCBub3QgCj5pbXBs
ZW1lbnRlZCBpbiB0aGUgTGludXgga2VybmVsLiBUaGF0IHlvdXIgY29tcGFueSBpcyBub3QgYWJs
ZSB0byAKPmVmZmljaWVudGx5IGltcGxlbWVudCB0aGUgWm9uZSBBcHBlbmQgY29tbWFuZCAodGhp
cyBpcyB0aGUgb25seSByZWFzb24gCj5JIGNhbiB0aGluayBvZiB0aGF0IG1ha2UgeW91IGFuZCB5
b3VyIGNvbXBhbnkgY2F1c2Ugc3VjaCBhIGZ1c3MpLCAKClRoaXMgY29tbWVudCBpcyBvdXQgb2Yg
cGxhY2UgYW5kIEkgd2lsbCBjaG9vc2UgdG8gaWdub3JlIGl0LgoKPnNob3VsZG4ndCBtZWFuIHRo
YXQgZXZlcnlvbmUgZWxzZSBoYXMgdG8gc3VmZmVyLgoKVGhpcyBpcyBub3QgYSBxdWlyaywgbm9y
IGEgc29mdHdhcmUgd29yay1hcm91bmQsIFRoaXMgaXMgYSBkZXNpZ24KZGVjaXNpb24gYWZmZWN0
aW5nIHRoZSBzdG9yYWdlIHN0YWNrIG9mIHNldmVyYWwgT0VNcy4gQXMgc3VjaCwgSSB3b3VsZAps
aWtlIHRvIGZpbmQgYSB3YXkgdG8gaW1wbGVtZW50IHRoaXMgZnVuY3Rpb25hbGl0eS4KCkxhc3Qg
dGltZSB3ZSBkaXNjdXNzZWQgdGhpcyBpbiB0aGUgbWFpbGluZyBsaXN0LCB5b3UgYW1vbmcgb3Ro
ZXJzCnBvaW50ZWQgdG8gYXBwZW5kIGVtdWxhdGlvbiBhcyB0aGUgYmVzdCB3YXkgdG8gZW5hYmxl
IHRoaXMgcGF0aCBhbmQgaGVyZQp3ZSBhcmUuIENhbiB5b3UgZXhwbGFpbmVkIHdoYXQgY2hhbmdl
ZD8KCj4KPkluIGFueSBjYXNlLCBTUERLIG9mZmVycyBhZGVxdWF0ZSBzdXBwb3J0IGFuZCBjYW4g
YmUgdXNlZCB0b2RheS4KCldlIHRha2UgdGhlIFNQREsgZGlzY3Vzc2lvbiBpbiB0aGUgYXBwcm9w
cmlhdGUgbWFpbGluZyBsaXN0cyBhbmQgc2xhY2sKY2hhbm5lbHMuCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

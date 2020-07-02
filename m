Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D3EC433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 10:20:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E04A20772
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 10:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i5quTDXd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="eS2AS63X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E04A20772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qLbukjVCEjvUBhfE7AN9OvTvNwmtYfJ2yItPd+j92hk=; b=i5quTDXdtCVhtWcmkDAvtPC33
	+HxzlOi813hcmTz4IMS+6baZf8fHY61wjKEjnz5MtjVwDlgoAhBt/5uGL/iCe61X1vjpBVxTl2NCD
	k3zaiY76wiWWb3tfPEwJOWEr9R904AI2gyMVTnK33jOMLEZPNeyx+6ULaGKj10fRYhUpBayEizUq5
	jv8MOYVBCZhkFF0+3jyXyFnKYtOZtmX80EjEdEU0qPiuidFrmOy3LxIHzAbu0L+636t3cm0yU2f0J
	dEEZRKw3nsPWJRs/lshUUcx69rFcX0kDjDWqD3FzHA2hRjxVVAuBK9d0HZM+29x+WJ2jnOafjkqai
	Je5exQBUQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqwKl-0001jr-Jt; Thu, 02 Jul 2020 10:20:47 +0000
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqwKi-0001iA-PY
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 10:20:45 +0000
Received: by mail-ej1-x644.google.com with SMTP id dr13so28668907ejc.3
 for <linux-nvme@lists.infradead.org>; Thu, 02 Jul 2020 03:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=y6QK1uUJZHQuZnFXHjM7RpcCfhjO+BnMr6K6R14LikI=;
 b=eS2AS63X4xHtWcaWVJuiQnZRL3FS5hl/kitkp/qfhE2U4bn44KsMkcI5ahaIUhkpta
 6tvJeM0eRhhkkdT/HtD13QyqAXZlJuuAf/hOLUhwUyrVhrIjZLI2hfSmgt0Q4v08rWWl
 8hS+jEqsMJSVlJnAruXLO3In7Lsa86+0XITBf7uyOLIOrdOeks10qjwobA7CaPzU54OH
 mdateSDMB8KYldO8l84nBECnC0GG8g0k4bICDJTD3s+k3LkuNDtPYYV+0R3HUmtsZXuS
 e9+cfSLqkoMb/HgGnCCw/eX3Iyfs42vr/mrFfAeVgD77VV9daKXn2j6SDsAxfRoi+XfU
 Ak+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=y6QK1uUJZHQuZnFXHjM7RpcCfhjO+BnMr6K6R14LikI=;
 b=SPNJI/VdjxptzS/VAZLp/RfSR6WDT3xx8M5xJ97Ujxw/H5bxt6EsK9Ge4ZFYyLF2II
 bIekeUChQ6fO4bNXa7xsejd3SHjRDwqBV8NyC0OcDEqrVJhGBbllplCKAk+sCi1qPg+Z
 FWINIFLvzwYPtF3asJ85o6ybA1GJOyblh2tYeTVIokEhgE0QZ4g/TOf8D5V5D/GcurTc
 jA2CvjesgLvMpRYfDYEd/SzFmkTYfVMURzL3A3yajFNXscjSgh092iawu7mDUGLYA9x1
 HczsER8YIqZeik6mzQ8H+ybbVELjIa6Al0+EwYpOBoLsZzR4NIw+U/L6jdC7F8jimaAy
 6skQ==
X-Gm-Message-State: AOAM530F2BIH3XR6CcJSTXxLvjGHXevlC7K7DmBF/IhMc/1hCY8V+WK2
 2jXJAKquqBDwVzePE7ZcyCYKHbtz1bIck6ci
X-Google-Smtp-Source: ABdhPJznU0cTuSpy44OchlJ/NcoicUfXVthk+RD4AWFPMdlv1FyVBTAxmHOyydYRtWmTGe2aRm0ZCQ==
X-Received: by 2002:a17:906:c142:: with SMTP id
 dp2mr28125124ejc.541.1593685243381; 
 Thu, 02 Jul 2020 03:20:43 -0700 (PDT)
Received: from localhost ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id dh16sm9185934edb.3.2020.07.02.03.20.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 03:20:42 -0700 (PDT)
Date: Thu, 2 Jul 2020 12:20:41 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Niklas Cassel <Niklas.Cassel@wdc.com>
Subject: Re: [PATCH 2/2] block: add max_active_zones to blk-sysfs
Message-ID: <20200702102041.qlehlokxel5ed6sf@mpHalley.local>
References: <20200616102546.491961-1-niklas.cassel@wdc.com>
 <20200616102546.491961-3-niklas.cassel@wdc.com>
 <20200701111330.3vpivrovh3i46maa@mpHalley.local>
 <20200702084104.GA607715@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200702084104.GA607715@localhost.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_062044_843918_8A54B6AD 
X-CRM114-Status: GOOD (  20.34  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Jonathan Corbet <corbet@lwn.net>, "James E.J. Bottomley" <jejb@linux.ibm.com>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMDIuMDcuMjAyMCAwODo0MSwgTmlrbGFzIENhc3NlbCB3cm90ZToKPk9uIFdlZCwgSnVsIDAx
LCAyMDIwIGF0IDAxOjE2OjUyUE0gKzAyMDAsIEphdmllciBHb256w6FsZXogd3JvdGU6Cj4+IE9u
IDE2LjA2LjIwMjAgMTI6MjUsIE5pa2xhcyBDYXNzZWwgd3JvdGU6Cj4+ID4gQWRkIGEgbmV3IG1h
eF9hY3RpdmUgem9uZXMgZGVmaW5pdGlvbiBpbiB0aGUgc3lzZnMgZG9jdW1lbnRhdGlvbi4KPj4g
PiBUaGlzIGRlZmluaXRpb24gd2lsbCBiZSBjb21tb24gZm9yIGFsbCBkZXZpY2VzIHV0aWxpemlu
ZyB0aGUgem9uZWQgYmxvY2sKPj4gPiBkZXZpY2Ugc3VwcG9ydCBpbiB0aGUga2VybmVsLgo+PiA+
Cj4+ID4gRXhwb3J0IG1heF9hY3RpdmVfem9uZXMgYWNjb3JkaW5nIHRvIHRoaXMgbmV3IGRlZmlu
aXRpb24gZm9yIE5WTWUgWm9uZWQKPj4gPiBOYW1lc3BhY2UgZGV2aWNlcywgWkFDIEFUQSBkZXZp
Y2VzICh3aGljaCBhcmUgdHJlYXRlZCBhcyBTQ1NJIGRldmljZXMgYnkKPj4gPiB0aGUga2VybmVs
KSwgYW5kIFpCQyBTQ1NJIGRldmljZXMuCj4+ID4KPj4gPiBBZGQgdGhlIG5ldyBtYXhfYWN0aXZl
X3pvbmVzIHN0cnVjdCBtZW1iZXIgdG8gdGhlIHJlcXVlc3RfcXVldWUsIHJhdGhlcgo+PiA+IHRo
YW4gYXMgYSBxdWV1ZSBsaW1pdCwgc2luY2UgdGhpcyBwcm9wZXJ0eSBjYW5ub3QgYmUgc3BsaXQg
YWNyb3NzIHN0YWNraW5nCj4+ID4gZHJpdmVycy4KPj4gPgo+PiA+IEZvciBTQ1NJIGRldmljZXMs
IGV2ZW4gdGhvdWdoIG1heCBhY3RpdmUgem9uZXMgaXMgbm90IHBhcnQgb2YgdGhlIFpCQy9aQUMK
Pj4gPiBzcGVjLCBleHBvcnQgbWF4X2FjdGl2ZV96b25lcyBhcyAwLCBzaWduaWZ5aW5nICJubyBs
aW1pdCIuCj4+ID4KPj4gPiBTaWduZWQtb2ZmLWJ5OiBOaWtsYXMgQ2Fzc2VsIDxuaWtsYXMuY2Fz
c2VsQHdkYy5jb20+Cj4+ID4gLS0tCj4KPihzbmlwKQo+Cj4+IExvb2tpbmcgYSBzZWNvbmQgdGlt
ZSBhdCB0aGVzZSBwYXRjaGVzLCB3b3VsZG4ndCBpdCBtYWtlIHNlbnNlIHRvIG1vdmUKPj4gdGhp
cyB0byBxdWV1ZV9saW1pdHM/Cj4KPkhlbGxvIEphdmllciwKPgo+VGhlIHByb2JsZW0gd2l0aCBo
YXZpbmcgTUFSL01PUiBhcyBxdWV1ZV9saW1pdHMsIGlzIHRoYXQgdGhleQo+dGhlbiB3b3VsZCBi
ZSBzcGxpdCBhY3Jvc3Mgc3RhY2tpbmcgZHJpdmVycy9kZXZpY2UtbWFwcGVyIHRhcmdldHMuCj5I
b3dldmVyLCBNQVIvTU9SIGFyZSBub3Qgc3BsaXR0YWJsZSwgYXQgbGVhc3Qgbm90IHRoZSB3YXkg
dGhlCj5ibG9jayBsYXllciB3b3JrcyB0b2RheS4KPgo+SWYgdGhlIGJsb2NrIGxheWVyIGFuZCBk
cml2ZXJzIGV2ZXIgY2hhbmdlIHNvIHRoYXQgdGhleSBkbwo+YWNjb3VudGluZyBvZiB6b25lIGNv
bmRpdGlvbnMsIHRoZW4gd2UgY291bGQgZGl2aWRlIHRoZSBNQVIvTU9SIHRvCj5iZSBzcGxpdCBv
dmVyIHN0YWNraW5nIGRyaXZlcnMsIGJ1dCBiZWNhdXNlIG9mIHBlcmZvcm1hbmNlIHJlYXNvbnMs
Cj50aGlzIHdpbGwgcHJvYmFibHkgbmV2ZXIgaGFwcGVuLgo+SW4gdGhlIHVubGlrZWx5IGV2ZW50
IHRoYXQgaXQgZGlkIGhhcHBlbiwgd2Ugd291bGQgc3RpbGwgdXNlIHRoZQo+c2FtZSBzeXNmcy1w
YXRoIGZvciB0aGVzZSBwcm9wZXJ0aWVzLCB0aGUgb25seSB0aGluZyB0aGF0IHdvdWxkCj5jaGFu
Z2Ugd291bGQgYmUgdGhhdCB0aGVzZSB3b3VsZCBiZSBtb3ZlZCBpbnRvIHF1ZXVlX2xpbWl0cy4K
Pgo+Cj5TbyB0aGUgd2F5IHRoZSBjb2RlIGxvb2tzIHJpZ2h0IG5vdywgdGhlc2UgcHJvcGVydGll
cyBjYW5ub3QKPmJlIHNwbGl0LCB0aGVyZWZvcmUgSSBjaG9zZSB0byBwdXQgdGhlbSBpbnNpZGUg
cmVxdWVzdF9xdWV1ZQo+KGp1c3QgbGlrZSBucl96b25lcyksIHJhdGhlciB0aGFuIHJlcXVlc3Rf
cXVldWUtPmxpbWl0cwo+KHdoaWNoIGlzIG9mIHR5cGUgc3RydWN0IHF1ZXVlX2xpbWl0cykuCj4K
Pm5yX3pvbmVzIGlzIGFsc28gZXhwb3NlZCBhcyBhIHN5c2ZzIHByb3BlcnR5LCBldmVuIHRob3Vn
aCBpdAo+aXMgcGFydCBvZiByZXF1ZXN0X3F1ZXVlLCBzbyBJIGRvbid0IHNlZSB3aHkgTUFSL01P
UiBjYW4ndCBkbwo+dGhlIHNhbWUuIEFsc28gc2VlIERhbWllbidzIHJlcGxpZXMgdG8gUEFUQ0gg
MS8yIG9mIHRoaXMgc2VyaWVzLAo+d2hpY2ggcmVhY2hlcyB0aGUgc2FtZSBjb25jbHVzaW9uLgo+
CgpUaGFua3MgZm9yIGV4cGxhaW5pbmcgTmlrbGFzIC0gbWFrZXMgc2Vuc2UuIEkganVzdCBsb29r
ZWQgYXQgeW91ciBwYXRjaAphZ2FpbiB3aGlsZSBhZGRpbmcgb3RoZXIgYXR0cmlidXRlcyBhbmQg
dGhvdWdodCBpdCB3b3VsZCBiZSB3b3J0aCBhc2tpbmcKdGhlIHJlYXNvbiBiZWhpbmQgaXQuCgpZ
b3UgY2FuIGtlZXAgdGhlIHJldmlld2VkLWJ5IG9uIHRoZSAyIHBhdGNoZXMuCgpKYXZpZXIKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

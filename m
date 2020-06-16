Return-Path: <SRS0=oPks=75=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72634C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 10:28:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3932074D
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jun 2020 10:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gjRPiWM3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="NqIJ1TZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3932074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5s/bE/e3BLO10t88HjWu8RQ3Ms2Y1dWCoUTgf3KYjW8=; b=gjRPiWM3lciYPowPB8zXMv377
	nPQoq+dY/mZaXn5nKXpZ4Q+8kZ9k/f9ugkLcOjoXqM0/t/SgYwTq1qHJC1LAHVmvCbuWoKs7A0Inr
	C3n471eTRAHVEjdW6LPNiRBC1oeDliAk87s8iRlQOkiiSxnouWMtiTqs7oO+meKqhlk4D1TJ4eM6B
	lzwpb2yFyu+lsTpf6EnbyRJo+UV88ipjvduazvl68yi+xJ8MA2B2TcOt6PXZsGvKSiq4RZYZhottO
	e9+WMWHgQqTzEYw4NRUufSwszCjRLTVp91wXMh1aTSZezyj2IlccItSL7PLn92elriCECw9gYzrOx
	ZaLql38jQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jl8pj-0002Bo-4b; Tue, 16 Jun 2020 10:28:47 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jl8pg-0002B6-Cs
 for linux-nvme@lists.infradead.org; Tue, 16 Jun 2020 10:28:45 +0000
Received: by mail-wr1-x442.google.com with SMTP id l10so20153572wrr.10
 for <linux-nvme@lists.infradead.org>; Tue, 16 Jun 2020 03:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=javigon-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=lWd87k2+YO9oIrJMsR3kbdwYQQ5BwfAiJZE+DlsHT+8=;
 b=NqIJ1TZHZnCGgie0Hi2SYxfe2IRNRJJlgAkph6yJZj8DMMtCouJX6S9ngbLt0jA35y
 wWcKtGRG+LOzNh6KpJjaRVcLsWqxmTvfysywJ9fUhO+ig9ZOSbIi9RsyjM1cybPE6CzF
 bXmCMSmC6LkBeP4ki1OvZvdjb5HJ3r+fd8ke9HzGTFRHBEzrjopiLZnjO75pdHYlWE6P
 czIkPHR0MRcEEKl79nn2uLTk5EB4emVLYDzH+5oBg/p/zz+kW2JbivMEogXluTFSO2JG
 NBI7V2Dqf9Zs3oKRyBSneB978AdNUOdrmwoKS7ZYd6CIoyhr0J0l95ZS6eCKpvLYV7bJ
 5hcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=lWd87k2+YO9oIrJMsR3kbdwYQQ5BwfAiJZE+DlsHT+8=;
 b=c6UsQmUIDwlDwA8aN7D1TlrVElClASLzwzbC2ABlGNkjJtRYxl388DM0StQhEoMlLp
 fR8/qQ5DzkGVAjNBUvTcjsP9F/ah4/jmcss/Yr0EXqICR+HDdpKQRiVibiClie4qDyVp
 C4geCxId69g0qiF9m3tlTKZ7lIvWqlaiJ53VwG3qsn5oAahZAKJfFPZc+ngCVPvIj6ts
 RCUA3jJ16jRzqnB82YjzhxoTvoBbfOnYE9aVT0y6sLf8+EgNickzcMB4o2gKLjbOQjxW
 Oe1sOg8G7By9L5EFsriK5XGNB0LDyluYBp1ThDlAjQMAqsgLkEziizDuDoeDqRLYpNg/
 vC/g==
X-Gm-Message-State: AOAM530tYS+B6cK03IlbXuP8sZZuHssOWPEg+4dOSTI/lx1E+sOPO937
 yihHpMWZTtbs3bpCG9yevNUaBg==
X-Google-Smtp-Source: ABdhPJwreQ4baLleQTG5f6a9XetfYJeZfUi89U3IrXCnT6tUbPxGNZBjLykPbtdUIAYBLAfRSWgbWw==
X-Received: by 2002:adf:8b18:: with SMTP id n24mr799716wra.372.1592303322537; 
 Tue, 16 Jun 2020 03:28:42 -0700 (PDT)
Received: from localhost ([194.62.217.57])
 by smtp.gmail.com with ESMTPSA id c5sm3180820wmb.24.2020.06.16.03.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 03:28:41 -0700 (PDT)
Date: Tue, 16 Jun 2020 12:28:40 +0200
From: Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To: Keith Busch <keith.busch@wdc.com>
Subject: Re: [PATCH 1/5] block: add capacity field to zone descriptors
Message-ID: <20200616102504.xj6o4lsziosy2dfk@mpHalley.local>
References: <20200615233424.13458-1-keith.busch@wdc.com>
 <20200615233424.13458-2-keith.busch@wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200615233424.13458-2-keith.busch@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200616_032844_504401_00B1C326 
X-CRM114-Status: GOOD (  12.31  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Matias =?utf-8?B?QmrDuHJsaW5n?= <matias.bjorling@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTYuMDYuMjAyMCAwODozNCwgS2VpdGggQnVzY2ggd3JvdGU6Cj5Gcm9tOiBNYXRpYXMgQmrD
uHJsaW5nIDxtYXRpYXMuYmpvcmxpbmdAd2RjLmNvbT4KPgo+SW4gdGhlIHpvbmVkIHN0b3JhZ2Ug
bW9kZWwsIHRoZSBzZWN0b3JzIHdpdGhpbiBhIHpvbmUgYXJlIHR5cGljYWxseSBhbGwKPndyaXRl
YWJsZS4gV2l0aCB0aGUgaW50cm9kdWN0aW9uIG9mIHRoZSBab25lZCBOYW1lc3BhY2UgKFpOUykg
Q29tbWFuZAo+U2V0IGluIHRoZSBOVk0gRXhwcmVzcyBvcmdhbml6YXRpb24sIHRoZSBtb2RlbCB3
YXMgZXh0ZW5kZWQgdG8gaGF2ZSBhCj5zcGVjaWZpYyB3cml0ZWFibGUgY2FwYWNpdHkuCj4KPkV4
dGVuZCB0aGUgem9uZSBkZXNjcmlwdG9yIGRhdGEgc3RydWN0dXJlIHdpdGggYSB6b25lIGNhcGFj
aXR5IGZpZWxkIHRvCj5pbmRpY2F0ZSB0byB0aGUgdXNlciBob3cgbWFueSBzZWN0b3JzIGluIGEg
em9uZSBhcmUgd3JpdGVhYmxlLgo+Cj5JbnRyb2R1Y2UgYmFja3dhcmQgY29tcGF0aWJpbGl0eSBp
biB0aGUgem9uZSByZXBvcnQgaW9jdGwgYnkgZXh0ZW5kaW5nCj50aGUgem9uZSByZXBvcnQgaGVh
ZGVyIGRhdGEgc3RydWN0dXJlIHdpdGggYSBmbGFncyBmaWVsZCB0byBpbmRpY2F0ZSBpZgo+dGhl
IGNhcGFjaXR5IGZpZWxkIGlzIGF2YWlsYWJsZS4KPgo+U2lnbmVkLW9mZi1ieTogTWF0aWFzIEJq
w7hybGluZyA8bWF0aWFzLmJqb3JsaW5nQHdkYy5jb20+Cj4tLS0KPiBibG9jay9ibGstem9uZWQu
YyAgICAgICAgICAgICAgfCAgMSArCj4gZHJpdmVycy9ibG9jay9udWxsX2Jsa196b25lZC5jIHwg
IDIgKysKPiBkcml2ZXJzL3Njc2kvc2RfemJjLmMgICAgICAgICAgfCAgMSArCj4gaW5jbHVkZS91
YXBpL2xpbnV4L2Jsa3pvbmVkLmggIHwgMTUgKysrKysrKysrKysrKy0tCj4gNCBmaWxlcyBjaGFu
Z2VkLCAxNyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj5kaWZmIC0tZ2l0IGEvYmxv
Y2svYmxrLXpvbmVkLmMgYi9ibG9jay9ibGstem9uZWQuYwo+aW5kZXggMjM4MzFmYTg3MDFkLi44
MTE1MmEyNjAzNTQgMTAwNjQ0Cj4tLS0gYS9ibG9jay9ibGstem9uZWQuYwo+KysrIGIvYmxvY2sv
YmxrLXpvbmVkLmMKPkBAIC0zMTIsNiArMzEyLDcgQEAgaW50IGJsa2Rldl9yZXBvcnRfem9uZXNf
aW9jdGwoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldiwgZm1vZGVfdCBtb2RlLAo+IAkJcmV0dXJu
IHJldDsKPgo+IAlyZXAubnJfem9uZXMgPSByZXQ7Cj4rCXJlcC5mbGFncyA9IEJMS19aT05FX1JF
UF9DQVBBQ0lUWTsKPiAJaWYgKGNvcHlfdG9fdXNlcihhcmdwLCAmcmVwLCBzaXplb2Yoc3RydWN0
IGJsa196b25lX3JlcG9ydCkpKQo+IAkJcmV0dXJuIC1FRkFVTFQ7Cj4gCXJldHVybiAwOwo+ZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svbnVsbF9ibGtfem9uZWQuYyBiL2RyaXZlcnMvYmxvY2sv
bnVsbF9ibGtfem9uZWQuYwo+aW5kZXggY2M0NzYwNmQ4ZmZlLi42MjRhYWMwOWIwMDUgMTAwNjQ0
Cj4tLS0gYS9kcml2ZXJzL2Jsb2NrL251bGxfYmxrX3pvbmVkLmMKPisrKyBiL2RyaXZlcnMvYmxv
Y2svbnVsbF9ibGtfem9uZWQuYwo+QEAgLTQ3LDYgKzQ3LDcgQEAgaW50IG51bGxfaW5pdF96b25l
ZF9kZXYoc3RydWN0IG51bGxiX2RldmljZSAqZGV2LCBzdHJ1Y3QgcmVxdWVzdF9xdWV1ZSAqcSkK
Pgo+IAkJem9uZS0+c3RhcnQgPSBzZWN0b3I7Cj4gCQl6b25lLT5sZW4gPSBkZXYtPnpvbmVfc2l6
ZV9zZWN0czsKPisJCXpvbmUtPmNhcGFjaXR5ID0gem9uZS0+bGVuOwo+IAkJem9uZS0+d3AgPSB6
b25lLT5zdGFydCArIHpvbmUtPmxlbjsKPiAJCXpvbmUtPnR5cGUgPSBCTEtfWk9ORV9UWVBFX0NP
TlZFTlRJT05BTDsKPiAJCXpvbmUtPmNvbmQgPSBCTEtfWk9ORV9DT05EX05PVF9XUDsKPkBAIC01
OSw2ICs2MCw3IEBAIGludCBudWxsX2luaXRfem9uZWRfZGV2KHN0cnVjdCBudWxsYl9kZXZpY2Ug
KmRldiwgc3RydWN0IHJlcXVlc3RfcXVldWUgKnEpCj4KPiAJCXpvbmUtPnN0YXJ0ID0gem9uZS0+
d3AgPSBzZWN0b3I7Cj4gCQl6b25lLT5sZW4gPSBkZXYtPnpvbmVfc2l6ZV9zZWN0czsKPisJCXpv
bmUtPmNhcGFjaXR5ID0gem9uZS0+bGVuOwo+IAkJem9uZS0+dHlwZSA9IEJMS19aT05FX1RZUEVf
U0VRV1JJVEVfUkVROwo+IAkJem9uZS0+Y29uZCA9IEJMS19aT05FX0NPTkRfRU1QVFk7Cj4KPmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvc2RfemJjLmMgYi9kcml2ZXJzL3Njc2kvc2RfemJjLmMK
PmluZGV4IDZmN2ViYTY2Njg3ZS4uMTgzYTIwNzIwZGE5IDEwMDY0NAo+LS0tIGEvZHJpdmVycy9z
Y3NpL3NkX3piYy5jCj4rKysgYi9kcml2ZXJzL3Njc2kvc2RfemJjLmMKPkBAIC01OSw2ICs1OSw3
IEBAIHN0YXRpYyBpbnQgc2RfemJjX3BhcnNlX3JlcG9ydChzdHJ1Y3Qgc2NzaV9kaXNrICpzZGtw
LCB1OCAqYnVmLAo+IAkJem9uZS5ub25fc2VxID0gMTsKPgo+IAl6b25lLmxlbiA9IGxvZ2ljYWxf
dG9fc2VjdG9ycyhzZHAsIGdldF91bmFsaWduZWRfYmU2NCgmYnVmWzhdKSk7Cj4rCXpvbmUuY2Fw
YWNpdHkgPSB6b25lLmxlbjsKPiAJem9uZS5zdGFydCA9IGxvZ2ljYWxfdG9fc2VjdG9ycyhzZHAs
IGdldF91bmFsaWduZWRfYmU2NCgmYnVmWzE2XSkpOwo+IAl6b25lLndwID0gbG9naWNhbF90b19z
ZWN0b3JzKHNkcCwgZ2V0X3VuYWxpZ25lZF9iZTY0KCZidWZbMjRdKSk7Cj4gCWlmICh6b25lLnR5
cGUgIT0gWkJDX1pPTkVfVFlQRV9DT05WICYmCj5kaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xp
bnV4L2Jsa3pvbmVkLmggYi9pbmNsdWRlL3VhcGkvbGludXgvYmxrem9uZWQuaAo+aW5kZXggMGNk
ZWY2NzEzNWYwLi40MmMzMzY2Y2MyNWYgMTAwNjQ0Cj4tLS0gYS9pbmNsdWRlL3VhcGkvbGludXgv
Ymxrem9uZWQuaAo+KysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVkLmgKPkBAIC03Myw2
ICs3MywxNSBAQCBlbnVtIGJsa196b25lX2NvbmQgewo+IAlCTEtfWk9ORV9DT05EX09GRkxJTkUJ
PSAweEYsCj4gfTsKPgo+Ky8qKgo+KyAqIGVudW0gYmxrX3pvbmVfcmVwb3J0X2ZsYWdzIC0gRmVh
dHVyZSBmbGFncyBvZiByZXBvcnRlZCB6b25lIGRlc2NyaXB0b3JzLgo+KyAqCj4rICogQEJMS19a
T05FX1JFUF9DQVBBQ0lUWTogWm9uZSBkZXNjcmlwdG9yIGhhcyBjYXBhY2l0eSBmaWVsZC4KPisg
Ki8KPitlbnVtIGJsa196b25lX3JlcG9ydF9mbGFncyB7Cj4rCUJMS19aT05FX1JFUF9DQVBBQ0lU
WQk9ICgxIDw8IDApLAo+K307Cj4rCj4gLyoqCj4gICogc3RydWN0IGJsa196b25lIC0gWm9uZSBk
ZXNjcmlwdG9yIGZvciBCTEtSRVBPUlRaT05FIGlvY3RsLgo+ICAqCj5AQCAtOTksNyArMTA4LDkg
QEAgc3RydWN0IGJsa196b25lIHsKPiAJX191OAljb25kOwkJLyogWm9uZSBjb25kaXRpb24gKi8K
PiAJX191OAlub25fc2VxOwkvKiBOb24tc2VxdWVudGlhbCB3cml0ZSByZXNvdXJjZXMgYWN0aXZl
ICovCj4gCV9fdTgJcmVzZXQ7CQkvKiBSZXNldCB3cml0ZSBwb2ludGVyIHJlY29tbWVuZGVkICov
Cj4tCV9fdTgJcmVzZXJ2ZWRbMzZdOwo+KwlfX3U4CXJlc3ZbNF07Cj4rCV9fdTY0CWNhcGFjaXR5
OwkvKiBab25lIGNhcGFjaXR5IGluIG51bWJlciBvZiBzZWN0b3JzICovCj4rCV9fdTgJcmVzZXJ2
ZWRbMjRdOwo+IH07Cj4KPiAvKioKPkBAIC0xMTUsNyArMTI2LDcgQEAgc3RydWN0IGJsa196b25l
IHsKPiBzdHJ1Y3QgYmxrX3pvbmVfcmVwb3J0IHsKPiAJX191NjQJCXNlY3RvcjsKPiAJX191MzIJ
CW5yX3pvbmVzOwo+LQlfX3U4CQlyZXNlcnZlZFs0XTsKPisJX191MzIJCWZsYWdzOwo+IAlzdHJ1
Y3QgYmxrX3pvbmUgem9uZXNbMF07Cj4gfTsKPgo+LS0gCj4yLjI0LjEKPgoKTG9va3MgZ29vZCB0
byBtZS4KClJldmlld2VkLWJ5OiBKYXZpZXIgR29uesOhbGV6IDxqYXZpZXIuZ29uekBzYW1zdW5n
LmNvbT4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

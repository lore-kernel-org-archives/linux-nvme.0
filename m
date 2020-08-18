Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB758C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 10:51:52 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8935D20789
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 10:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MlGz1ED9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="UkPdi2l/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8935D20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=M2jB6WDGGuo6wSGFpzfOxxpPpB89SMWj+U++NSilwwQ=; b=MlGz1ED9TwpjSVo2/T5k1lxqw
	0BUMhRuKFcegOWDKYAjTSKPNG/v/nk/j2ReuxpZvHcqnGv0b8mWuudfilaHZutQYh22k0v/aO+ARX
	oGbjTjWP5K4mfDtAjMixjKCZXukOviJTt0m8JkDs6T8gY3lLBjkAAiNdiVIFfQR6HwUaLXD3LUOxS
	7q0DiG1RKX1euH1RcSKzLD2QrIkCBpTTrNUZyzHl3rNb1hdSEhMbjrKvUwdINey4nVtrQvsqmtUGK
	cmKIEVgk1667w5MqVNrns77tyhbjWQKQXylJsQlmLWSpQkx2JTrG3ANsTD2NanBgUDtaci7cB8Ysi
	fS3YJNg2Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7zDU-0007IX-Pt; Tue, 18 Aug 2020 10:51:44 +0000
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7zDR-0007HR-Kn
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 10:51:42 +0000
Received: by mail-ej1-x641.google.com with SMTP id o23so21550603ejr.1
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 03:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7Rkmsih4pLhvW6xMZVPj0/Cg05RYVqnHRSrB5uFL0c4=;
 b=UkPdi2l/3+P1oL8XcRlscqOvKuAIbvxk/47ouGJIkvS5WXKAw3ejDijlQv/PKSdTlo
 3Hv372O99LzLkeh5ZB1ZWEs9vvCHLlhX5WcQPqaRxA8Ih6naFsa+8pj84jBdnq5/sCht
 tKLX2HG9g2Cyu4YVjAFt0618GwCMwZAfJB6Xwhzf5Ls460R7nFWPQg+OzhxwIBzFEgfe
 2XNzm4l9XQMx9WkSeGl6uF09cRwtMvyMbuueuVCPvsgM/1vbk2FlGnONaPoRFTGxAbPQ
 PWyafb3/nBb2CpiWHDaoZTrzfgnF4MS6LVfPZHzt3ASNfITY5qzwUTiORMwmAxYXRDjk
 Mseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7Rkmsih4pLhvW6xMZVPj0/Cg05RYVqnHRSrB5uFL0c4=;
 b=VbfkwIqw9MFrjxuKz5PooUCz7LrN2XECM/hcOYuSoKKqk1hBN4UC0cXBXrpI3p/2lg
 sLIT79Yf/GyXv+R1TnKE4MKQ6Um2PyCVWIyeFWNyZBJGAAq+VJbstLWPndx4siboBPIv
 q6DCSUyu2FOF4yQq0SOc3OcGlUXci985bwIAP5hLeQO0kvNX4XlULPp6AofXVc/sx1to
 jcDj8uvjMTHXlV3y4ji7bBKkE1NWAHel3NfenOAjIjzShjCCEvMiNdBKecZOHjecE5I2
 iIrqRDzBz0uD4Mff08cgNu11ZyKKE2K6F0IFkeap3Vf0jAgvvuMNckpwvCqsbtsB3q6l
 STGA==
X-Gm-Message-State: AOAM533+sQvAv+rAuyWmXGNrsEoxC0a4/e27mv6S9ee4+M+5UooQIYyA
 wTY8016tTZWREbhwlz66OrjZ+Q==
X-Google-Smtp-Source: ABdhPJxgdv6Ng+C9x3oVRi01Nim6IwyhcsnE6wz14aeTHuS/RZlEiu5yNvRUQjVVNJRPQjx/NXzkWA==
X-Received: by 2002:a17:906:3715:: with SMTP id
 d21mr18969146ejc.281.1597747898486; 
 Tue, 18 Aug 2020 03:51:38 -0700 (PDT)
Received: from [192.168.1.11] ([87.116.37.42])
 by smtp.gmail.com with ESMTPSA id y13sm15321730eds.64.2020.08.18.03.51.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Aug 2020 03:51:37 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme: add emulation for zone-append
To: Javier Gonzalez <javier@javigon.com>, Christoph Hellwig <hch@lst.de>
References: <20200818052936.10995-1-joshi.k@samsung.com>
 <CGME20200818053256epcas5p46d0b66b3702192eb6617c8bba334c15f@epcas5p4.samsung.com>
 <20200818052936.10995-3-joshi.k@samsung.com> <20200818071249.GB2544@lst.de>
 <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <4ae89443-d8ae-4efb-581e-b635c21b27de@lightnvm.io>
Date: Tue, 18 Aug 2020 12:51:37 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200818095033.h6ybdwiq3ljagl5a@mpHalley.local>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_065141_827610_34AF8D9F 
X-CRM114-Status: GOOD (  20.00  )
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
 kbusch@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMTgvMDgvMjAyMCAxMS41MCwgSmF2aWVyIEdvbnphbGV6IHdyb3RlOgo+IE9uIDE4LjA4LjIw
MjAgMDk6MTIsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOgo+PiBPbiBUdWUsIEF1ZyAxOCwgMjAy
MCBhdCAxMDo1OTozNkFNICswNTMwLCBLYW5jaGFuIEpvc2hpIHdyb3RlOgo+Pj4gSWYgZHJpdmUg
ZG9lcyBub3Qgc3VwcG9ydCB6b25lLWFwcGVuZCBuYXRpdmVseSwgZW5hYmxlIGVtdWxhdGlvbiB1
c2luZwo+Pj4gcmVndWxhciB3cml0ZS4KPj4+IE1ha2UgZW11bGF0ZWQgem9uZS1hcHBlbmQgY21k
IHdyaXRlLWxvY2sgdGhlIHpvbmUsIHByZXZlbnRpbmcKPj4+IGNvbmN1cnJlbnQgYXBwZW5kL3dy
aXRlIG9uIHRoZSBzYW1lIHpvbmUuCj4+Cj4+IEkgcmVhbGx5IGRvbid0IHRoaW5rIHdlIHNob3Vs
ZCBhZGQgdGhpcy7CoCBaTlMgYW5kIHRoZSBMaW51eCBzdXBwb3J0Cj4+IHdlcmUgYWxsIGRlc2ln
bmVkIHdpdGggWm9uZSBBcHBlbmQgaW4gbWluZCwgYW5kIHRoZW4geW91ciBjb21wYW55IGRpZAo+
PiB0aGUgbmFzdGllc3QgcG9zc2libGUgbW92ZSB2aW9sYXRpbmcgdGhlIG5vcm1hbCBOVk1lIHBy
b2NlZHVyZXMgdG8gbWFrZQo+PiBpdCBvcHRpb25hbC7CoCBCdXQgdGhhdCBkb2Vzbid0IGNoYW5n
ZSB0aGUgZmFjdCB0aGUgTGludXggc2hvdWxkIGtlZXAKPj4gcmVxdWlyaW5nIGl0LCBlc3BlY2lh
bGx5IHdpdGggdGhlIGFtb3VudCBvZiBjb2RlIGFkZGVkIGhlcmUgYW5kIGhvdyBpdAo+PiBob29r
cyBpbiB0aGUgZmFzdCBwYXRoLgo+IAo+IEkgdW5kZXJzdGFuZCB0aGF0IHRoZSBOVk1lIHByb2Nl
c3Mgd2FzIGFnaXRhdGVkIGFuZCB0aGF0IHRoZSBjdXJyZW50IFpOUwo+IGltcGxlbWVudGF0aW9u
IGluIExpbnV4IHJlbGllcyBpbiBhcHBlbmQgc3VwcG9ydCBmcm9tIHRoZSBkZXZpY2UKPiBwZXJz
cGVjdGl2ZS4gSG93ZXZlciwgdGhlIGN1cnJlbnQgVFAgZG9lcyBhbGxvdyBmb3Igbm90IGltcGxl
bWVudGluZwo+IGFwcGVuZCwgYW5kIGEgbnVtYmVyIG9mIGN1c3RvbWVycyBhcmUgcmVxdWlyaW5n
IHRoZSB1c2Ugb2Ygbm9ybWFsCj4gd3JpdGVzLCB3aGljaCB3ZSB3YW50IHRvIHN1cHBvcnQuCgpU
aGVyZSBpcyBhIGxvdCBvZiB0aGluZ3MgdGhhdCBpcyBzcGVjaWZpZWQgaW4gTlZNZSwgYnV0IG5v
dCBpbXBsZW1lbnRlZCAKaW4gdGhlIExpbnV4IGtlcm5lbC4gVGhhdCB5b3VyIGNvbXBhbnkgaXMg
bm90IGFibGUgdG8gZWZmaWNpZW50bHkgCmltcGxlbWVudCB0aGUgWm9uZSBBcHBlbmQgY29tbWFu
ZCAodGhpcyBpcyB0aGUgb25seSByZWFzb24gSSBjYW4gdGhpbmsgCm9mIHRoYXQgbWFrZSB5b3Ug
YW5kIHlvdXIgY29tcGFueSBjYXVzZSBzdWNoIGEgZnVzcyksIHNob3VsZG4ndCBtZWFuIAp0aGF0
IGV2ZXJ5b25lIGVsc2UgaGFzIHRvIHN1ZmZlci4KCkluIGFueSBjYXNlLCBTUERLIG9mZmVycyBh
ZGVxdWF0ZSBzdXBwb3J0IGFuZCBjYW4gYmUgdXNlZCB0b2RheS4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0Ckxp
bnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

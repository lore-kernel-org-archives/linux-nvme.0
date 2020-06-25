Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C71FC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 13:04:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE2F520672
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 13:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="R4x5TaZW";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="xl82oj18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE2F520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aUCw4dVgdbe7OBmKfm827ILJoidRVKuA9gSApGGhYGk=; b=R4x5TaZWWZO5kPGcHe4c0rEan
	VkTlb+hKBma3XSiakSohlGBbW1cvXb0JiFI3X/cKgleJltHg4LHjv5oavfQ6Z6N1KsDywxECC0tVM
	ZP+df7BinYZ8TIXwcul6U5irkdm4kB608bUtc0thq7qUAzDpqoy5KLO0j1FvVcDXOt9akyE0Imkox
	KwfYDJUQYWexNeUriABwV63lrG/UChJMiZnJSuXETZxCDsICSq1VNWXwalsTZyad596BvVkHatVgH
	90wtnWLpEXl4eEsYII2MaEqRIKlvibuR7Q7C/mrQBeWd6uECFHOqTycW3yFZG7N+FZJBtxoFwhaup
	gd0tnx/vA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joRYS-0003I4-SF; Thu, 25 Jun 2020 13:04:36 +0000
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joRYP-0003Gq-OZ
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 13:04:34 +0000
Received: by mail-ed1-x544.google.com with SMTP id z17so4124646edr.9
 for <linux-nvme@lists.infradead.org>; Thu, 25 Jun 2020 06:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=LXs+TzGY6PPMha6FRa+oZWEDxK46Uyk5PsHPv06NVpI=;
 b=xl82oj18jf62fmDoTChkZ8YmO7nenU7bhbYS/vO1c47CEVNQ45TAh4UIhcIAgqSNMG
 oYK2MWos6eUYqvWP8hPKTEeFbRS+uGq4b4FOCiEMGWEOV+j6no3uKy5Dc9+6QFwnIo1j
 CTN3aUPkrk9/+7FBZuyxK7qGMVpNVw+5p6LanglGWydIoqKMXjBMc95aj3nRP5YEBU/Y
 N+8kKLKCgmcXRO6B6NZ4VnyqLTfa2p58VFW4tVRvSZM4bkRwDsiEidN41y3pwNES3xwX
 TkQbmEVukYQo2ISUD52eCgjaqnvttzH06ojE4NVoJw3S+np+fXClb00jnvy6QOJfurSL
 RbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=LXs+TzGY6PPMha6FRa+oZWEDxK46Uyk5PsHPv06NVpI=;
 b=jDbRkPipPNOUOQJczDzFPYovzphmnXHVnjGno7ksber7VESwYtPzQ2BHNyfEnXQBjo
 ODjGrFi4sEkfi/ZphOZqCuDDXHyNV3akHXi9Yqic2wNgCi4VLJ6p189KEhlurYB31roE
 djkqtmtUDU8rySJJ2Met3w6V2vnQCD34M650qroM4xU8yBmtpl/4sOTLkchCpHVZ0ZPj
 XcUXrUM6tUQZdBcrLHHDrAARE+sWfOMJXTEm2eJbYdeQpqTus1Lon3FEP0O3tYO64Svw
 Yb1n/OQ8bgsz4XJ/5ZMiJT2PXcyUJRTPv1J7D9KLj7MYhRwk7K0o/e+8CKVD5i9ZYA7p
 7Hig==
X-Gm-Message-State: AOAM533c180tnE54r3qWD/xbL42jcRuLtFzNy7xnQO9n/aiSWbThRCQI
 fZX1DuH9Burj7Kjz/vDxhlEk0w==
X-Google-Smtp-Source: ABdhPJwdStNd66XgsiZUp82JpCb2P6cjIylVEwAd7Diy4jK0ziWtYFEzFSu8MAvL2oHFqJRV0wPq4Q==
X-Received: by 2002:a50:d78f:: with SMTP id w15mr32998851edi.245.1593090270288; 
 Thu, 25 Jun 2020 06:04:30 -0700 (PDT)
Received: from [10.0.0.6] (xb932c246.cust.hiper.dk. [185.50.194.70])
 by smtp.gmail.com with ESMTPSA id bc23sm734494edb.90.2020.06.25.06.04.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 06:04:29 -0700 (PDT)
Subject: Re: [PATCH 0/6] ZNS: Extra features for current patches
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
 linux-nvme@lists.infradead.org
References: <20200625122152.17359-1-javier@javigon.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <2067b6ce-fea0-99cd-39c7-56cf219f56d5@lightnvm.io>
Date: Thu, 25 Jun 2020 15:04:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625122152.17359-1-javier@javigon.com>
Content-Language: en-US
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
Cc: axboe@kernel.dk, sagi@grimberg.me, linux-block@vger.kernel.org,
 kbusch@kernel.org, =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
 hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMjUvMDYvMjAyMCAxNC4yMSwgSmF2aWVyIEdvbnrDoWxleiB3cm90ZToKPiBGcm9tOiBKYXZp
ZXIgR29uesOhbGV6IDxqYXZpZXIuZ29uekBzYW1zdW5nLmNvbT4KPgo+IFRoaXMgcGF0Y2hzZXQg
ZXh0ZW5kcyB6b25lZCBkZXZpY2UgZnVuY3Rpb25hbGl0eSBvbiB0b3Agb2YgdGhlIGV4aXN0aW5n
Cj4gdjMgWk5TIHBhdGNoc2V0IHRoYXQgS2VpdGggc2VudCBsYXN0IHdlZWsuCj4KPiBQYXRjaGVz
IDEtNSBhcmUgem9uZWQgYmxvY2sgaW50ZXJmYWNlIGFuZCBJT0NUTCBhZGRpdGlvbnMgdG8gZXhw
b3NlIFpOUwo+IHZhbHVlcyB0byB1c2VyLXNwYWNlLiBPbmUgbWFqb3IgY2hhbmdlIGlzIHRoZSBh
ZGRpdGlvbiBvZiBhIG5ldyB6b25lCj4gbWFuYWdlbWVudCBJT0NUTCB0aGF0IGFsbG93cyB0byBl
eHRlbmQgem9uZSBtYW5hZ2VtZW50IGNvbW1hbmRzIHdpdGgKPiBmbGFncy4gSSByZWNhbGwgYSBj
b252ZXJzYXRpb24gaW4gdGhlIG1haWxpbmcgbGlzdCBmcm9tIGVhcmx5IHRoaXMgeWVhcgo+IHdo
ZXJlIGEgc2ltaWxhciBhcHByb2FjaCB3YXMgcHJvcG9zZWQgYnkgTWF0aWFzLCBidXQgbmV2ZXIg
bWFkZSBpdAo+IHVwc3RyZWFtLiBXZSBleHRlbmRlZCB0aGUgSU9DVEwgaGVyZSB0byBhbGlnbiB3
aXRoIHRoZSBjb21tZW50cyBpbiB0aGF0Cj4gdGhyZWFkLiBIZXJlLCB3ZSBhcmUgaGFwcHkgdG8g
Z2V0IHNpZ24tb2ZmcyBieSBhbnlvbmUgdGhhdCBjb250cmlidXRlZAo+IHRvIHRoZSB0aHJlYWQg
LSBqdXN0IGNvbW1lbnQgaGVyZSBvciBvbiB0aGUgcGF0Y2guCgpUaGUgb3JpZ2luYWwgcGF0Y2hz
ZXQgaXMgYXZhaWxhYmxlIGhlcmU6IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE5LzYvMjEvNDE5
CgpXZSB3YW50ZWQgdG8gd2FpdCBwb3N0aW5nIG91ciB1cGRhdGVkIHBhdGNoZXMgdW50aWwgdGhl
IGJhc2UgcGF0Y2hlcyAKd2VyZSB1cHN0cmVhbS4gSSBndWVzcyB0aGUgY2F0IGlzIG91dCBvZiB0
aGUgYmFnLiA6KQoKRm9yIHRoZSBvcGVuL2ZpbmlzaC9yZXNldCBwYXRjaCwgeW91J2xsIHdhbnQg
dG8gdGFrZSBhIGxvb2sgYXQgdGhlIApvcmlnaW5hbCBwYXRjaHNldCwgYW5kIGFwcGx5IHRoZSBm
ZWVkYmFjayBmcm9tIHRoYXQgdGhyZWFkIHRvIHlvdXIgCnBhdGNoLiBQbGVhc2UgYWxzbyBjb25z
aWRlciB0aGUgdXNlcnMgb2YgdGhlc2Ugb3BlcmF0aW9ucywgZS5nLiwgZG0sIApzY3NpLCBudWxs
X2JsaywgZXRjLiBUaGUgb3JpZ2luYWwgcGF0Y2hzZXQgaGFzIHBhdGNoZXMgZm9yIHRoYXQuCgoK
CgoKPgo+IFBhdGNoIDYgaXMgbnZtZS1vbmx5IGFuZCBhZGRzIGFuIGV4dHJhIGNoZWNrIHRvIHRo
ZSBaTlMgcmVwb3J0IGNvZGUgdG8KPiBlbnN1cmUgY29uc2lzdGVuY3kgb24gdGhlIHpvbmUgY291
bnQuCj4KPiBUaGUgcGF0Y2hlcyBhcHBseSBvbiB0b3Agb2YgSmVucycgYmxvY2stNS44ICsgS2Vp
dGgncyBWMyBaTlMgcGF0Y2hlcy4KPgo+IFRoYW5rcywKPiBKYXZpZXIKPgo+IEphdmllciBHb256
w6FsZXogKDYpOgo+ICAgIGJsb2NrOiBpbnRyb2R1Y2UgSU9DVEwgZm9yIHpvbmUgbWdtdAo+ICAg
IGJsb2NrOiBhZGQgc3VwcG9ydCBmb3Igc2VsZWN0aW5nIGFsbCB6b25lcwo+ICAgIGJsb2NrOiBh
ZGQgc3VwcG9ydCBmb3Igem9uZSBvZmZsaW5lIHRyYW5zaXRpb24KPiAgICBibG9jazogaW50cm9k
dWNlIElPQ1RMIHRvIHJlcG9ydCBkZXYgcHJvcGVydGllcwo+ICAgIGJsb2NrOiBhZGQgem9uZSBh
dHRyLiB0byB6b25lIG1nbXQgSU9DVEwgc3RydWN0Cj4gICAgbnZtZTogQWRkIGNvbnNpc3RlbmN5
IGNoZWNrIGZvciB6b25lIGNvdW50Cj4KPiAgIGJsb2NrL2Jsay1jb3JlLmMgICAgICAgICAgICAg
IHwgICAyICsKPiAgIGJsb2NrL2Jsay16b25lZC5jICAgICAgICAgICAgIHwgMTA4ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKy0KPiAgIGJsb2NrL2lvY3RsLmMgICAgICAgICAgICAg
ICAgIHwgICA0ICsrCj4gICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgICAgICB8ICAgNSArKwo+
ICAgZHJpdmVycy9udm1lL2hvc3QvbnZtZS5oICAgICAgfCAgMTEgKysrKwo+ICAgZHJpdmVycy9u
dm1lL2hvc3Qvem5zLmMgICAgICAgfCAgNjkgKysrKysrKysrKysrKysrKysrKysrKwo+ICAgaW5j
bHVkZS9saW51eC9ibGtfdHlwZXMuaCAgICAgfCAgIDYgKy0KPiAgIGluY2x1ZGUvbGludXgvYmxr
ZGV2LmggICAgICAgIHwgIDE5ICsrKysrLQo+ICAgaW5jbHVkZS91YXBpL2xpbnV4L2Jsa3pvbmVk
LmggfCAgNjkgKysrKysrKysrKysrKysrKysrKysrLQo+ICAgOSBmaWxlcyBjaGFuZ2VkLCAyODkg
aW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK

Return-Path: <SRS0=wEPw=XB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9388FC43331
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 05:14:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D2B2070C
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Sep 2019 05:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="QVf7IDEU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vMdENFAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D2B2070C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nBQMfE9ZNxvJszRlr0SuyMNDBVUYatFCOFiLbP08/ZA=; b=QVf7IDEU6raOrL
	J3s1cPjavX0qwOWqB3RIwJ3TYIWjB3leIAFcv1lRBGkwVu60setfI1wb7xljCzAstfE5GnGWQmkkT
	xZ3DOH4wQTO8qa252G3M3mX8tgxKzc1COPLNGuPfT7jnhRs9hOdb21eN0hWUU+2QuNUoW8jQ+hWv6
	ljoaAni4grxPWt06qDadOsoxaL5cv3nCJ4XXpBSN25rvo9Bq0oRvi9gYyQaCVCS0pa4/jX0ALHCR1
	Tgy+7VKMZBkd4u1pinilr4E1L8fW7Ux9NX56+XEoum23Ng5csfR+1b+/dz8UEz+jRdyW9uQBkKSf5
	r4b+idTEGMGur505Lb/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i66Zk-000885-IW; Fri, 06 Sep 2019 05:14:24 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i66Zh-00087V-IU
 for linux-nvme@lists.infradead.org; Fri, 06 Sep 2019 05:14:23 +0000
Received: by mail-wm1-x344.google.com with SMTP id t9so5459538wmi.5
 for <linux-nvme@lists.infradead.org>; Thu, 05 Sep 2019 22:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7CsW3TppKngdBwILFW1AivCZPL5hHqz4o7k82Kvz7yk=;
 b=vMdENFAR1u1iwNLpm3uTpo5yhrAL19/DvOmxc2B9Rr/ZKxjFvqIOErerFUDh4MiFR2
 AD5P+3aTT9qOqUE0Z2u54Ilty3puZYTz/jNh6/NsHDGyu2HPcMi1jyWI/7HVYVi+mxeH
 cpV2jufh4c3Qs8WHhzi1tV3siAVTMuxnHkGShnmF8FyS6nNB6HWoFVw58I3TyK081YT4
 //8Xif4HZZekZ90p+2lzzbfN10aaFxfNVI3oIqeydhhXgJh8wU0YSp6cncl/xz0gs7Km
 cTAe0f7nzSsFkkL6f4+r/HWku7eovFJY6NnVMpKTZx76rwu3Jv4gUv+6gJ1gdjVZoiYG
 JV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=7CsW3TppKngdBwILFW1AivCZPL5hHqz4o7k82Kvz7yk=;
 b=Bv35t3NdUZs9PXWBpOYVoBd3kBZ9S6+W6RVsvwf/LCPwJpvRDPRCmgbzO78AkGwNRt
 PZD1QCyQb5xB9DTdTmlI/jpARsq+N/PkJCbuey06NGJVo9p08QXUuy4CvDLYqTJSLNez
 5ycUK+YtwN61GTP64oCKck3lU/HGNoUzmI5hqOy2ReydlnMc9UZ/Y9uMqY2qURbOLgR1
 QiGej8Kf7p9hguFgwYrl7l6TMa0YpUC/+Fy+hqC5S7eTdWG8Pd5pzjnFgFJVOedewImS
 Seew+rXh0gr9liod/lK9FKn3KOXBgtwKNQAoh5+7Wq3ExPJvAIFaqs9C7WSJuQa8+Bj4
 589g==
X-Gm-Message-State: APjAAAUYn34BEvZJnhmbKNg2Y4Tdn2C56IL4sKd75euyOM3+ghlnGF6d
 9jxrGRGEsZegWxvrxUWdKtAYSg==
X-Google-Smtp-Source: APXvYqytCdNccG6c/obG/ipoadhKySWxaQx4f6iGA9niw9WWXZTUPg/QRD0dLpPL7aWmXxE3/VwGjA==
X-Received: by 2002:a05:600c:2105:: with SMTP id
 u5mr6040493wml.150.1567746858892; 
 Thu, 05 Sep 2019 22:14:18 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a0b5:f0e4:ddb5:dee4?
 ([2a01:e34:ed2f:f020:a0b5:f0e4:ddb5:dee4])
 by smtp.googlemail.com with ESMTPSA id a13sm9501606wrf.73.2019.09.05.22.14.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Sep 2019 22:14:18 -0700 (PDT)
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
To: Ming Lei <ming.lei@redhat.com>
References: <20190903033001.GB23861@ming.t460p>
 <299fb6b5-d414-2e71-1dd2-9d6e34ee1c79@linaro.org>
 <20190903063125.GA21022@ming.t460p>
 <6b88719c-782a-4a63-db9f-bf62734a7874@linaro.org>
 <20190903072848.GA22170@ming.t460p>
 <dd96def4-1121-afbe-2431-9e516a06850c@linaro.org>
 <6f3b6557-1767-8c80-f786-1ea667179b39@acm.org>
 <2a8bd278-5384-d82f-c09b-4fce236d2d95@linaro.org>
 <20190905090617.GB4432@ming.t460p>
 <6a36ccc7-24cd-1d92-fef1-2c5e0f798c36@linaro.org>
 <20190906014819.GB27116@ming.t460p>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ffefcfa0-09b6-9af5-f94e-8e7ddd2eef16@linaro.org>
Date: Fri, 6 Sep 2019 07:14:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906014819.GB27116@ming.t460p>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_221421_672075_5BADA201 
X-CRM114-Status: GOOD (  25.15  )
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
Cc: Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
 Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Long Li <longli@microsoft.com>,
 John Garry <john.garry@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CkhpLAoKT24gMDYvMDkvMjAxOSAwMzo0OCwgTWluZyBMZWkgd3JvdGU6CgpbIC4uLiBdCgo+PiBZ
b3UgZGlkIG5vdCBzaGFyZSB5ZXQgdGhlIGFuYWx5c2lzIG9mIHRoZSBwcm9ibGVtICh0aGUga2Vy
bmVsIHdhcm5pbmdzCj4+IGdpdmUgdGhlIHN5bXB0b21zKSBhbmQgZ2F2ZSB0aGUgcmVhc29uaW5n
IGZvciB0aGUgc29sdXRpb24uIEl0IGlzIGhhcmQKPj4gdG8gdW5kZXJzdGFuZCB3aGF0IHlvdSBh
cmUgbG9va2luZyBmb3IgZXhhY3RseSBhbmQgaG93IHRvIGNvbm5lY3QgdGhlIGRvdHMuCj4gCj4g
TGV0IG1lIGV4cGxhaW4gaXQgb25lIG1vcmUgdGltZTo+Cj4gV2hlbiBvbmUgSVJRIGZsb29kIGhh
cHBlbnMgb24gb25lIENQVToKPiAKPiAxKSBzb2Z0aXJxIGhhbmRsaW5nIG9uIHRoaXMgQ1BVIGNh
bid0IG1ha2UgcHJvZ3Jlc3MKPiAKPiAyKSBrZXJuZWwgdGhyZWFkIGJvdW5kIHRvIHRoaXMgQ1BV
IGNhbid0IG1ha2UgcHJvZ3Jlc3MKPiAKPiBGb3IgZXhhbXBsZSwgbmV0d29yayBtYXkgcmVxdWly
ZSBzb2Z0aXJxIHRvIHhtaXQgcGFja2V0cywgb3IgYW5vdGhlciBpcnEKPiB0aHJlYWQgZm9yIGhh
bmRsaW5nIGtleWJvYXJkcy9taWNlIG9yIHdoYXRldmVyLCBvciByY3Vfc2NoZWQgbWF5IGRlcGVu
ZAo+IG9uIHRoYXQgQ1BVIGZvciBtYWtpbmcgcHJvZ3Jlc3MsIHRoZW4gdGhlIGlycSBmbG9vZCBz
dGFsbHMgdGhlIHdob2xlCj4gc3lzdGVtLgo+IAo+Pgo+PiBBRkFJVSwgdGhlcmUgYXJlIGZhc3Qg
bWVkaXVtIHdoZXJlIHRoZSByZXNwb25zZXMgdG8gcmVxdWVzdHMgYXJlIGZhc3Rlcgo+PiB0aGFu
IHRoZSB0aW1lIHRvIHByb2Nlc3MgdGhlbSwgcmlnaHQ/Cj4gCj4gVXN1YWxseSBtZWRpdW0gbWF5
IG5vdCBiZSBmYXN0ZXIgdGhhbiBDUFUsIG5vdyB3ZSBhcmUgdGFsa2luZyBhYm91dAo+IGludGVy
cnVwdHMsIHdoaWNoIGNhbiBiZSBvcmlnaW5hdGVkIGZyb20gbG90cyBvZiBkZXZpY2VzIGNvbmN1
cnJlbnRseSwKPiBmb3IgZXhhbXBsZSwgaW4gTG9uZyBMaSd0ZXN0LCB0aGVyZSBhcmUgOCBOVk1l
IGRyaXZlcyBpbnZvbHZlZC4KPiAKPj4KPj4gSSBkb24ndCBzZWUgaG93IGRldGVjdGluZyBJUlEg
Zmxvb2RpbmcgYW5kIHVzZSBhIHRocmVhZGVkIGlycSBpcyB0aGUKPj4gc29sdXRpb24sIGNhbiB5
b3UgZXhwbGFpbj8KPiAKPiBXaGVuIElSUSBmbG9vZCBpcyBkZXRlY3RlZCwgd2UgcmVzZXJ2ZSBh
IGJpdCBsaXR0bGUgdGltZSBmb3IgcHJvdmlkaW5nCj4gY2hhbmNlIHRvIG1ha2Ugc29mdGlycS90
aHJlYWRzIHNjaGVkdWxlZCBieSBzY2hlZHVsZXIsIHRoZW4gdGhlIGFib3ZlCj4gcHJvYmxlbSBj
YW4gYmUgYXZvaWRlZC4KPiAKPj4KPj4gSWYgdGhlIHJlc3BvbnNlcyBhcmUgY29taW5nIGF0IGEg
dmVyeSBoaWdoIHJhdGUsIHdoYXRldmVyIHRoZSBzb2x1dGlvbgo+PiAoaW50ZXJydXB0cywgdGhy
ZWFkZWQgaW50ZXJydXB0cywgcG9sbGluZyksIHdlIGFyZSBzdGlsbCBpbiB0aGUgc2FtZQo+PiBz
aXR1YXRpb24uCj4gCj4gV2hlbiB3ZSBtb3ZpbmcgdGhlIGludGVycnVwdCBoYW5kbGluZyBpbnRv
IGlycSB0aHJlYWQsIG90aGVyIHNvZnRpcnEvCj4gdGhyZWFkZWQgaW50ZXJydXB0L3RocmVhZCBn
ZXRzIGNoYW5jZSB0byBiZSBzY2hlZHVsZWQsIHNvIHdlIGNhbiBhdm9pZAo+IHRvIHN0YWxsIHRo
ZSB3aG9sZSBzeXN0ZW0uCgpPaywgc28gdGhlIHJlYWwgcHJvYmxlbSBpcyBwZXItY3B1IGJvdW5k
ZWQgdGFza3MuCgpJIHNoYXJlIFRob21hcyBvcGluaW9uIGFib3V0IGEgTkFQSSBsaWtlIGFwcHJv
YWNoLgoKSSBkbyBiZWxpZXZlIHlvdSBzaG91bGQgYWxzbyByZWx5IG9uIHRoZSBJUlFfVElNRV9B
Q0NPVU5USU5HIChtYXkgYmUgZ2V0Cml0IG9wdGltaXplZCkgdG8gY29udHJpYnV0ZSB0byB0aGUg
Q1BVIGxvYWQgYW5kIGVuZm9yY2UgdGFzayBtaWdyYXRpb24KYXQgbG9hZCBiYWxhbmNlLgoKPj4g
TXkgc3VnZ2VzdGlvbiB3YXMgaW5pdGlhbGx5IHRvIHNlZSBpZiB0aGUgaW50ZXJydXB0IGxvYWQg
d2lsbCBiZSB0YWtlbgo+PiBpbnRvIGFjY291bnRzIGluIHRoZSBjcHUgbG9hZCBhbmQgZmF2b3Jp
emUgdGFzayBtaWdyYXRpb24gd2l0aCB0aGUKPj4gc2NoZWR1bGVyIGxvYWQgYmFsYW5jZSB0byBh
IGxlc3MgbG9hZGVkIENQVSwgdGh1cyB0aGUgQ1BVIHByb2Nlc3NpbmcKPj4gaW50ZXJydXB0cyB3
aWxsIGVuZCB1cCBkb2luZyBvbmx5IHRoYXQgd2hpbGUgb3RoZXIgQ1BVcyB3aWxsIGhhbmRsZSB0
aGUKPj4gInRocmVhZGVkIiBzaWRlLgo+Pgo+PiBCZXNpZGUgdGhhdCwgSSdtIHdvbmRlcmluZyBp
ZiB0aGUgYmxvY2sgc2NoZWR1bGVyIHNob3VsZCBiZSBzb21laG93Cj4+IGludm9sdmVkIGluIHRo
YXQgWzFdCj4gCj4gRm9yIE5WTWUgb3IgYW55IG11bHRpLXF1ZXVlIHN0b3JhZ2UsIHRoZSBkZWZh
dWx0IHNjaGVkdWxlciBpcyAnbm9uZScsCj4gd2hpY2ggYmFzaWNhbGx5IGRvZXMgbm90aGluZyBl
eGNlcHQgZm9yIHN1Ym1pdHRpbmcgSU8gYXNhcC4KPiAKPiAKPiBUaGFua3MsCj4gTWluZwo+IAoK
Ci0tIAogPGh0dHA6Ly93d3cubGluYXJvLm9yZy8+IExpbmFyby5vcmcg4pSCIE9wZW4gc291cmNl
IHNvZnR3YXJlIGZvciBBUk0gU29DcwoKRm9sbG93IExpbmFybzogIDxodHRwOi8vd3d3LmZhY2Vi
b29rLmNvbS9wYWdlcy9MaW5hcm8+IEZhY2Vib29rIHwKPGh0dHA6Ly90d2l0dGVyLmNvbS8jIS9s
aW5hcm9vcmc+IFR3aXR0ZXIgfAo8aHR0cDovL3d3dy5saW5hcm8ub3JnL2xpbmFyby1ibG9nLz4g
QmxvZwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxp
bnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

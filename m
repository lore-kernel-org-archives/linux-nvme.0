Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ED9C3A5A5
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 10:37:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03850206BB
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 10:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bOaumaxh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oLrunmvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03850206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lf2aqNh+oJTRygL+YPvgJLoFatPoDD9LDoCmoNlHzS8=; b=bOaumaxhvXvZ/P
	avrt2gF2SrE8vMvYME190ZmbYuGsUVSCh1yZysR4ZDQzcuws8MDxWa+k2PjRkdJdcSRuvoH1dcl4J
	i/gHeDhS10lgc+N1zYHQJhOJga2na4FNnkjEZunklQ0yAj3Yz1Nn/WAqW3hvwjW7rpDHjO4Hnl+UB
	9pdPWx0TXoghNBqknnBkFQjy1O2rDFSssiHRG/G3TxbGYFImKpOf+bA+zJxUu6NdOiil8MZHO7uOU
	wn74wnLOcdb6icK6ODmxU6ZC2tzLLd7kclrTU8DOCwUtahMZs24NAJE4+cqhSCBV++sXL0qGSs1s9
	TIPgwZ1fWlab1+bkIVlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5p8i-0005hg-Vj; Thu, 05 Sep 2019 10:37:20 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5p8f-0005hI-OL
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 10:37:19 +0000
Received: by mail-wm1-x343.google.com with SMTP id g207so2164094wmg.5
 for <linux-nvme@lists.infradead.org>; Thu, 05 Sep 2019 03:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UQ+h/l/92tqieco4xsfKNJdjS3t97xdei1lBQLqVVqE=;
 b=oLrunmvxO0Hzr0g41pSyPC3MUWkGGNEr5ye1fOhxu7RJkfm5pBV+YSFjJIOsnzeJdz
 +SEmMjy7LUZ4mc7w4ycRb2qxITElpP4KX0f6dySR3PTneX37h6SS8zvDri088tcd+T4C
 ecYjsbt+InGBkDSEDzdxoV/16fDskJ1SXNgw5gwEo1Vs7MB87t+cOq0INhZJkgHkm6yt
 eVeY31Res8ghF2FuvGb5m/yY133CbkHcd6uDmryY2fM4q8zgwDLuJFtzpEPIA7y5oLAH
 yb5piyaONNSQvNoZQy7bFlqtNH/gHbgLzdfC8F1w+0742fXve13SipZ0N+Ovqg/fbWGe
 twyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=UQ+h/l/92tqieco4xsfKNJdjS3t97xdei1lBQLqVVqE=;
 b=Xhcij1bQ0GTBgZlxNnNXx1Db0ptixlRuJWMEoQPoobCAIl35I/eY7wH5/CGqC5zi8i
 zGTp86bsNi+5fIw/fmy+SAI5/O9YtR8X2dOcfgaGVj02qXntE0ddPAbCsS+/7pLYKftd
 DSJLpbYQpHB7Qkd0C4P2+jeV36NmjvE+W1qOpDAAvI8+IbFnlVKMOl9NWZplIAFHFzpR
 HohGCq/wnbxiw0x+qpUcAFOlHq38Rb6l9aORQpk5xfdnM7LXGuD1waIsTvrN8jTn/+Lk
 G5R/2qVUne62haRuKR7Ax+Cd3btRw1ko82kf/QmI6UKEhWWtvARoxbJTwTj9nPk9VcWK
 gpAg==
X-Gm-Message-State: APjAAAX6y6YrDmbuA0rTEo61JHIE253ml8CnmgkIV4I2iikyo7edoQat
 odC/0+DLAmj/AoUmv11orwk0rg==
X-Google-Smtp-Source: APXvYqwkmJn++2obwcJOU874jhMG0qLwFQ4fLd68qWBcnfQwJC2SzRZVGjNcYMpwiigmgdISahRWZQ==
X-Received: by 2002:a1c:1f10:: with SMTP id f16mr2439059wmf.176.1567679835865; 
 Thu, 05 Sep 2019 03:37:15 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:794a:5c4d:16b4:31a6?
 ([2a01:e34:ed2f:f020:794a:5c4d:16b4:31a6])
 by smtp.googlemail.com with ESMTPSA id j30sm2517055wrb.66.2019.09.05.03.37.13
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 05 Sep 2019 03:37:15 -0700 (PDT)
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
To: Ming Lei <ming.lei@redhat.com>
References: <20190828135054.GA23861@ming.t460p>
 <alpine.DEB.2.21.1908281605190.23149@nanos.tec.linutronix.de>
 <20190903033001.GB23861@ming.t460p>
 <299fb6b5-d414-2e71-1dd2-9d6e34ee1c79@linaro.org>
 <20190903063125.GA21022@ming.t460p>
 <6b88719c-782a-4a63-db9f-bf62734a7874@linaro.org>
 <20190903072848.GA22170@ming.t460p>
 <dd96def4-1121-afbe-2431-9e516a06850c@linaro.org>
 <6f3b6557-1767-8c80-f786-1ea667179b39@acm.org>
 <2a8bd278-5384-d82f-c09b-4fce236d2d95@linaro.org>
 <20190905090617.GB4432@ming.t460p>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <6a36ccc7-24cd-1d92-fef1-2c5e0f798c36@linaro.org>
Date: Thu, 5 Sep 2019 12:37:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190905090617.GB4432@ming.t460p>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_033717_799743_BE73DB81 
X-CRM114-Status: GOOD (  23.23  )
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
Cc: Keith Busch <keith.busch@intel.com>, Hannes Reinecke <hare@suse.com>,
 Bart Van Assche <bvanassche@acm.org>, linux-scsi@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Long Li <longli@microsoft.com>,
 John Garry <john.garry@huawei.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CkhpIE1pbmcsCgpPbiAwNS8wOS8yMDE5IDExOjA2LCBNaW5nIExlaSB3cm90ZToKPiBPbiBXZWQs
IFNlcCAwNCwgMjAxOSBhdCAwNzozMTo0OFBNICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToK
Pj4gSGksCj4+Cj4+IE9uIDA0LzA5LzIwMTkgMTk6MDcsIEJhcnQgVmFuIEFzc2NoZSB3cm90ZToK
Pj4+IE9uIDkvMy8xOSAxMjo1MCBBTSwgRGFuaWVsIExlemNhbm8gd3JvdGU6Cj4+Pj4gT24gMDMv
MDkvMjAxOSAwOToyOCwgTWluZyBMZWkgd3JvdGU6Cj4+Pj4+IE9uIFR1ZSwgU2VwIDAzLCAyMDE5
IGF0IDA4OjQwOjM1QU0gKzAyMDAsIERhbmllbCBMZXpjYW5vIHdyb3RlOgo+Pj4+Pj4gSXQgaXMg
YSBzY2hlZHVsZXIgcHJvYmxlbSB0aGVuID8KPj4+Pj4KPj4+Pj4gU2NoZWR1bGVyIGNhbiBkbyBu
b3RoaW5nIGlmIHRoZSBDUFUgaXMgdGFrZW4gY29tcGxldGVseSBieSBoYW5kbGluZwo+Pj4+PiBp
bnRlcnJ1cHQgJiBzb2Z0aXJxLCBzbyBzZWVtcyBub3QgYSBzY2hlZHVsZXIgcHJvYmxlbSwgSU1P
Lgo+Pj4+Cj4+Pj4gV2h5PyBJZiB0aGVyZSBpcyBhIGlycSBwcmVzc3VyZSBvbiBvbmUgQ1BVIHJl
ZHVjaW5nIGl0cyBjYXBhY2l0eSwgdGhlCj4+Pj4gc2NoZWR1bGVyIHdpbGwgYmFsYW5jZSB0aGUg
dGFza3Mgb24gYW5vdGhlciBDUFUsIG5vPwo+Pj4KPj4+IE9ubHkgaWYgQ09ORklHX0lSUV9USU1F
X0FDQ09VTlRJTkcgaGFzIGJlZW4gZW5hYmxlZC4gSG93ZXZlciwgSSBkb24ndAo+Pj4ga25vdyBh
bnkgTGludXggZGlzdHJvIHRoYXQgZW5hYmxlcyB0aGF0IG9wdGlvbi4gVGhhdCdzIHByb2JhYmx5
IGJlY2F1c2UKPj4+IHRoYXQgb3B0aW9uIGludHJvZHVjZXMgdHdvIHJkdHNjKCkgY2FsbHMgaW4g
ZWFjaCBpbnRlcnJ1cHQuIEdpdmVuIHRoZQo+Pj4gb3ZlcmhlYWQgaW50cm9kdWNlZCBieSB0aGlz
IG9wdGlvbiwgSSBkb24ndCB0aGluayB0aGlzIGlzIHRoZSBzb2x1dGlvbgo+Pj4gTWluZyBpcyBs
b29raW5nIGZvci4KPj4KPj4gV2FzIHRoaXMgb3ZlcmhlYWQgcmVwb3J0ZWQgc29tZXdoZXJlID8K
PiAKPiBUaGUgc3lzY2FsbCBvZiBnZXR0aW1lb2ZkYXkoKSBjYWxscyBrdGltZV9nZXRfcmVhbF90
czY0KCkgd2hpY2ggZmluYWxseQo+IGNhbGxzIHRrX2Nsb2NrX3JlYWQoKSB3aGljaCBjYWxscyBy
ZHRzYyB0b28uCj4gCj4gQnV0IGdldHRpbWVvZmRheSgpIGlzIG9mdGVuIHVzZWQgaW4gZmFzdCBw
YXRoLCBhbmQgYmxvY2sgSU9fU1RBVCBuZWVkcyB0bwo+IHJlYWQgaXQgdG9vLgo+IAo+Pgo+Pj4g
U2VlIGFsc28gaXJxdGltZV9hY2NvdW50X2lycSgpIGluIGtlcm5lbC9zY2hlZC9jcHV0aW1lLmMu
Cj4+Cj4+IEZyb20gbXkgUE9WLCB0aGlzIGZyYW1ld29yayBjb3VsZCBiZSBpbnRlcmVzdGluZyB0
byBkZXRlY3QgdGhpcyBzaXR1YXRpb24uCj4gCj4gTm93IHdlIGFyZSB0YWxraW5nIGFib3V0IElS
UV9USU1FX0FDQ09VTlRJTkcgaW5zdGVhZCBvZiBJUlFfVElNSU5HUywgYW5kIHRoZQo+IGZvcm1l
ciBvbmUgY291bGQgYmUgdXNlZCB0byBpbXBsZW1lbnQgdGhlIGRldGVjdGlvbi4gQW5kIHRoZSBv
bmx5IHNoYXJpbmcKPiBzaG91bGQgYmUgdGhlIHJlYWQgb2YgdGltZXN0YW1wLgoKWW91IGRpZCBu
b3Qgc2hhcmUgeWV0IHRoZSBhbmFseXNpcyBvZiB0aGUgcHJvYmxlbSAodGhlIGtlcm5lbCB3YXJu
aW5ncwpnaXZlIHRoZSBzeW1wdG9tcykgYW5kIGdhdmUgdGhlIHJlYXNvbmluZyBmb3IgdGhlIHNv
bHV0aW9uLiBJdCBpcyBoYXJkCnRvIHVuZGVyc3RhbmQgd2hhdCB5b3UgYXJlIGxvb2tpbmcgZm9y
IGV4YWN0bHkgYW5kIGhvdyB0byBjb25uZWN0IHRoZSBkb3RzLgoKQUZBSVUsIHRoZXJlIGFyZSBm
YXN0IG1lZGl1bSB3aGVyZSB0aGUgcmVzcG9uc2VzIHRvIHJlcXVlc3RzIGFyZSBmYXN0ZXIKdGhh
biB0aGUgdGltZSB0byBwcm9jZXNzIHRoZW0sIHJpZ2h0PwoKSSBkb24ndCBzZWUgaG93IGRldGVj
dGluZyBJUlEgZmxvb2RpbmcgYW5kIHVzZSBhIHRocmVhZGVkIGlycSBpcyB0aGUKc29sdXRpb24s
IGNhbiB5b3UgZXhwbGFpbj8KCklmIHRoZSByZXNwb25zZXMgYXJlIGNvbWluZyBhdCBhIHZlcnkg
aGlnaCByYXRlLCB3aGF0ZXZlciB0aGUgc29sdXRpb24KKGludGVycnVwdHMsIHRocmVhZGVkIGlu
dGVycnVwdHMsIHBvbGxpbmcpLCB3ZSBhcmUgc3RpbGwgaW4gdGhlIHNhbWUKc2l0dWF0aW9uLgoK
TXkgc3VnZ2VzdGlvbiB3YXMgaW5pdGlhbGx5IHRvIHNlZSBpZiB0aGUgaW50ZXJydXB0IGxvYWQg
d2lsbCBiZSB0YWtlbgppbnRvIGFjY291bnRzIGluIHRoZSBjcHUgbG9hZCBhbmQgZmF2b3JpemUg
dGFzayBtaWdyYXRpb24gd2l0aCB0aGUKc2NoZWR1bGVyIGxvYWQgYmFsYW5jZSB0byBhIGxlc3Mg
bG9hZGVkIENQVSwgdGh1cyB0aGUgQ1BVIHByb2Nlc3NpbmcKaW50ZXJydXB0cyB3aWxsIGVuZCB1
cCBkb2luZyBvbmx5IHRoYXQgd2hpbGUgb3RoZXIgQ1BVcyB3aWxsIGhhbmRsZSB0aGUKInRocmVh
ZGVkIiBzaWRlLgoKQmVzaWRlIHRoYXQsIEknbSB3b25kZXJpbmcgaWYgdGhlIGJsb2NrIHNjaGVk
dWxlciBzaG91bGQgYmUgc29tZWhvdwppbnZvbHZlZCBpbiB0aGF0IFsxXQoKICAtLSBEYW5pZWwK
ClsxXQpodHRwczovL3d3dy5saW5hcm8ub3JnL2Jsb2cvaW8tYmFuZHdpZHRoLW1hbmFnZW1lbnQt
Zm9yLXByb2R1Y3Rpb24tcXVhbGl0eS1zZXJ2aWNlcy8KCgoKLS0gCiA8aHR0cDovL3d3dy5saW5h
cm8ub3JnLz4gTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFSTSBTb0Nz
CgpGb2xsb3cgTGluYXJvOiAgPGh0dHA6Ly93d3cuZmFjZWJvb2suY29tL3BhZ2VzL0xpbmFybz4g
RmFjZWJvb2sgfAo8aHR0cDovL3R3aXR0ZXIuY29tLyMhL2xpbmFyb29yZz4gVHdpdHRlciB8Cjxo
dHRwOi8vd3d3LmxpbmFyby5vcmcvbGluYXJvLWJsb2cvPiBCbG9nCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QK
TGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

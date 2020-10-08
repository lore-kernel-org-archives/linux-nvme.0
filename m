Return-Path: <SRS0=NQX9=DP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9297C433DF
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 23:00:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2515322248
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2020 23:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="24sQ/WiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2515322248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2sK/6NeL5solCUKo56He0TgZKNmuy0PtoX6ogXSZZIQ=; b=24sQ/WiD0F3l6nLbZcskp9hP+
	deSMvs9vBAMW2hGeEbZhAuOYb5opB07LkHLox7A7MtpF6SCzVdRxYvxbpFeOgJgQam5Fgh1AJJapG
	5kn3eVAdMoE019llc3xVIWoNf4CVw6LeO02TvDZt3eQrdH99SjuRC/fpXB2jxoaqZvFaeP+I3ZVos
	lQRSAFIuQldslwReqH0MWaEsMGl0R+fU+cbw4YB4/SjafwEiMLUZMGNrp3SoZKpYd9Ey/7Rvw7XO0
	+qIRO3YSZ6xnozTA87IJZ5WFS6+k8P8NORiYYIBjJmiDC1I9bX2enwl22ifY5yh1j2YUa0Fy3+rXA
	3mNxiRIcg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kQetv-0005DH-Ea; Thu, 08 Oct 2020 23:00:43 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQetr-0005CX-Hl
 for linux-nvme@lists.infradead.org; Thu, 08 Oct 2020 23:00:40 +0000
Received: by mail-wr1-f68.google.com with SMTP id j2so8301387wrx.7
 for <linux-nvme@lists.infradead.org>; Thu, 08 Oct 2020 16:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=38f/duVbixFUEajq4NL1BIVEfot3FVrKIDXch2dCmrg=;
 b=cOxvRCYo8q1eiK1ea+K5hV+E3BM13+UdKCSHsMWguYj3L7ToKSXz7KxcCxqXqggO+s
 AbZ3cHHWJJXl8dTj6d5WHctsQhe+sh01gpzQemLW3/LpBdYsx37VQiAfJvDGw+5pRm0E
 6h005zrgLsd500zzk/+gGjFXuCH5uPgp9xrWeAs3ee+B6PeJMcv9M5cbWs7KqWbhVK29
 uHFSF68MPWKUNGSYa/E6bGx0nACoao/p9bB+lYoIxzZYmQqgmqpjRpbRFwPAWbdxQ3kr
 S8EG6/3pFWleYFxrrSOtMyFIs71b6Duf5Kbhd8KyUbAt4FbeUCwXA/DtST79PcDq20vn
 ap+Q==
X-Gm-Message-State: AOAM532RdLjJfg/pClE5kpgt85uI3Yz2qSWQRsjCVD123V4SD7xFoIfG
 kZp99nuqu6yCt+sPKC+q81A=
X-Google-Smtp-Source: ABdhPJyYQV8orChJxD9Awr46bhR7KBjokewpm63kTc6Qy9IJH68cZDl9tMp4Q06Mjtf4d/bmdvOl3g==
X-Received: by 2002:a05:6000:110f:: with SMTP id
 z15mr11170990wrw.87.1602198036164; 
 Thu, 08 Oct 2020 16:00:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:68d6:3fd5:5a8b:9959?
 ([2601:647:4802:9070:68d6:3fd5:5a8b:9959])
 by smtp.gmail.com with ESMTPSA id c16sm9788515wrx.31.2020.10.08.16.00.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 16:00:35 -0700 (PDT)
Subject: Re: [PATCH net-next RFC v1 06/10] nvme-tcp: Add DDP data-path
From: Sagi Grimberg <sagi@grimberg.me>
To: Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org,
 davem@davemloft.net, saeedm@nvidia.com, hch@lst.de, axboe@fb.com,
 kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-7-borisp@mellanox.com>
 <5a23d221-fd3e-5802-ce68-7edec55068bb@grimberg.me>
Message-ID: <24ea956e-40a2-8b7b-cf8a-b604e7cd5644@grimberg.me>
Date: Thu, 8 Oct 2020 16:00:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5a23d221-fd3e-5802-ce68-7edec55068bb@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201008_190039_611242_81C14A19 
X-CRM114-Status: GOOD (  15.41  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Ben Ben-Ishay <benishay@mellanox.com>,
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+IMKgIHN0YXRpYwo+PiDCoCBpbnQgbnZtZV90Y3Bfb2ZmbG9hZF9zb2NrZXQoc3RydWN0IG52
bWVfdGNwX3F1ZXVlICpxdWV1ZSwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzdHJ1Y3QgbnZtZV90Y3BfY29uZmlnICpjb25maWcpCj4+IEBAIC02MzAsNiArNzIwLDcgQEAg
c3RhdGljIHZvaWQgbnZtZV90Y3BfZXJyb3JfcmVjb3Zlcnkoc3RydWN0IAo+PiBudm1lX2N0cmwg
KmN0cmwpCj4+IMKgIHN0YXRpYyBpbnQgbnZtZV90Y3BfcHJvY2Vzc19udm1lX2NxZShzdHJ1Y3Qg
bnZtZV90Y3BfcXVldWUgKnF1ZXVlLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IG52bWVf
Y29tcGxldGlvbiAqY3FlKQo+PiDCoCB7Cj4+ICvCoMKgwqAgc3RydWN0IG52bWVfdGNwX3JlcXVl
c3QgKnJlcTsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgcmVxdWVzdCAqcnE7Cj4+IMKgwqDCoMKgwqAg
cnEgPSBibGtfbXFfdGFnX3RvX3JxKG52bWVfdGNwX3RhZ3NldChxdWV1ZSksIGNxZS0+Y29tbWFu
ZF9pZCk7Cj4+IEBAIC02NDEsOCArNzMyLDE1IEBAIHN0YXRpYyBpbnQgbnZtZV90Y3BfcHJvY2Vz
c19udm1lX2NxZShzdHJ1Y3QgCj4+IG52bWVfdGNwX3F1ZXVlICpxdWV1ZSwKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+PiDCoMKgwqDCoMKgIH0KPj4gLcKgwqDCoCBpZiAo
IW52bWVfdHJ5X2NvbXBsZXRlX3JlcShycSwgY3FlLT5zdGF0dXMsIGNxZS0+cmVzdWx0KSkKPj4g
LcKgwqDCoMKgwqDCoMKgIG52bWVfY29tcGxldGVfcnEocnEpOwo+PiArwqDCoMKgIHJlcSA9IGJs
a19tcV9ycV90b19wZHUocnEpOwo+PiArwqDCoMKgIGlmIChyZXEtPm9mZmxvYWRlZCkgewo+PiAr
wqDCoMKgwqDCoMKgwqAgcmVxLT5zdGF0dXMgPSBjcWUtPnN0YXR1czsKPj4gK8KgwqDCoMKgwqDC
oMKgIHJlcS0+cmVzdWx0ID0gY3FlLT5yZXN1bHQ7Cj4+ICvCoMKgwqDCoMKgwqDCoCBudm1lX3Rj
cF90ZWFyZG93bl9kZHAocXVldWUsIGNxZS0+Y29tbWFuZF9pZCwgcnEpOwo+PiArwqDCoMKgIH0g
ZWxzZSB7Cj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIW52bWVfdHJ5X2NvbXBsZXRlX3JlcShycSwg
Y3FlLT5zdGF0dXMsIGNxZS0+cmVzdWx0KSkKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZt
ZV9jb21wbGV0ZV9ycShycSk7Cj4+ICvCoMKgwqAgfQoKT2ggZm9yZ290IHRvIGFzaywKCldlIGhh
dmUgcGxhY2VzIGluIHRoZSBkcml2ZXIgdGhhdCB3ZSBtYXkgY29tcGxldGUgKGNhbmNlbCkgb25l
Cm9yIG1vcmUgcmVxdWVzdHMgZnJvbSB0aGUgZXJyb3IgcmVjb3Zlcnkgb3IgdGltZW91dCBmbG93
LiBXZQpmaXJzdCBwcmV2ZW50IGZ1dHVyZSBpbmNvbWluZyBSWCBvbiB0aGUgc29ja2V0IHN1Y2gg
dGhhdCB3ZQpjYW4gc2FmZWx5IGNhbmNlbCByZXF1ZXN0cy4gVGhpcyBtYXkgYnJlYWsgd2l0aCB0
aGUgZGVmZXJyZWQKY29tcGxldGlvbiBpbiBkZHBfdGVhcmRvd25fZG9uZS4KCklmIEkgaGF2ZSBh
IHJlcXVlc3QgdGhhdCBpcyB3YWl0aW5nIGZvciBkZHBfdGVhcmRvd25fZG9uZSBkbwpJIGhhdmUg
YSB3YXkgdG8gdGVsbCB0aGUgSFcgdG8gbmV2ZXIgY2FsbCBkZHBfdGVhcmRvd25fZG9uZQpvbiBh
IHNwZWNpZmljIHNvY2tldD8KCklmIHNvIHRoZSBwbGFjZSB0byBpcyBpbiBudm1lX3RjcF9zdG9w
X3F1ZXVlLgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
TGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0
dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

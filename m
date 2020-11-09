Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42BEC55ABD
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 23:29:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 398F3206B2
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 23:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="IsnRNSVD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 398F3206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Bsh1Pzr2ZVRMcBYfxCOgSwkpXbbz1/+PIi8McI2OWt4=; b=IsnRNSVDINpMBAl43JZ4XEOqN
	/LZUNoqbYOxtJMJe9kohLQdp5QHFT1OCRaJX3nh/syP0R7e0M3M+0p9hWUvrZjYLYgN7mRNgoSdjj
	c12uQlF59XnARhlkS3roZHvmiZvBofOxEo6teS05x6uhSGHEX3EBaLz19fc6ewEJdNkygV/0qBeuy
	mFOktoMtWL5H4nBwsvCgF+OQazLk0CBydyzdL/E2azc73/Pwax7PyroI6xEKGEgn0tMP5EsmEjmUa
	et4dklw3tJx9RNfvgIQMa4mUxRXVvErovrMH//jxLgwE/cX+c3erJpObdb0ouZNPRHByP1QMDT7eq
	bLWCQnTWw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kcGal-0006cQ-T5; Mon, 09 Nov 2020 23:28:55 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcGaj-0006c0-KD
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 23:28:54 +0000
Received: by mail-wm1-f45.google.com with SMTP id c16so1206241wmd.2
 for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2020 15:28:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uVd85Bl4q22td+3jSMit0FtxZJ1sJtChRiPRn7GLPMw=;
 b=THw3lAMWGWa1iOC2dyY610QpEufeaVKxxhUux9nW4LavaA3ScQNcBs8EZgtprRIwXh
 0p+O9IJwhJDwhkMpLE9VA9ghcwZUM+5hIamzzsRiz32PcPkn9NLuoaigmoW08T5hPSlH
 LzM9gCjXljBuFmJLR2R3z1G9iUkgu9i2a3wfLgMhxmAjY4u6IHi8+em8BnWGHW9I4KTx
 RK9hW/C5qr0pBePDrVWtsKO5AG8lhORAWlqWTKDGYgjdQrSF7a3a3OTE0qNF9Pga+Sm4
 MkVq+4tWSGvqhFG3J6mBWbqcSYQhUllDfYfo4Yf5tHraewdJBiT0CvrQ7YG1Avh2UMra
 12Xg==
X-Gm-Message-State: AOAM5325XlTY01dlBr8FAi5c9daI/+o8RwKeu0VzXs+AQCi/c7lJzjEH
 gxebo+BlvdwmMnsmX4vOMAI=
X-Google-Smtp-Source: ABdhPJyLfZWJAVtXVvWavay6Dkz/YKClz0bIC5QMERvUePaULd58OWlCLidmjNr2cN/ZVx4HfgINbw==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr1575766wmk.100.1604964532362; 
 Mon, 09 Nov 2020 15:28:52 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:f26a:270b:f54c:37eb?
 ([2601:647:4802:9070:f26a:270b:f54c:37eb])
 by smtp.gmail.com with ESMTPSA id c17sm6900728wro.19.2020.11.09.15.28.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 15:28:51 -0800 (PST)
Subject: Re: [PATCH 03/24] nvme: let set_capacity_revalidate_and_notify update
 the bdev size
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20201106190337.1973127-1-hch@lst.de>
 <20201106190337.1973127-4-hch@lst.de>
 <1d06cdfa-a904-30be-f3ec-08ae2fa85cbd@suse.de>
 <20201109085340.GB27483@lst.de>
 <e79f9a96-ef53-d6ea-f6e7-e141bdd2e2d2@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <d28042e3-3123-5dfc-d0a2-aab0012150c8@grimberg.me>
Date: Mon, 9 Nov 2020 15:28:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e79f9a96-ef53-d6ea-f6e7-e141bdd2e2d2@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_182853_681056_D8D67ECD 
X-CRM114-Status: GOOD (  21.12  )
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
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gWyAuLiBdCj4+PiBPcmlnaW5hbGx5IG52bWUgbXVsdGlwYXRoIHdvdWxkIHVwZGF0ZS9jaGFu
Z2UgdGhlIHNpemUgb2YgdGhlIG11bHRpcGF0aAo+Pj4gZGV2aWNlIGFjY29yZGluZyB0byB0aGUg
dW5kZXJseWluZyBwYXRoIGRldmljZXMuCj4+PiBXaXRoIHRoaXMgcGF0Y2ggdGhlIHNpemUgb2Yg
dGhlIG11bHRpcGF0aCBkZXZpY2Ugd2lsbCBfbm90XyBjaGFuZ2UgaWYgCj4+PiB0aGVyZQo+Pj4g
aXMgYSBjaGFuZ2Ugb24gdGhlIHVuZGVybHlpbmcgZGV2aWNlcy4KPj4KPj4gWWVzLCBpdCB3aWxs
LsKgIFRha2UgYSBjbG9zZSBsb29rIGF0IG52bWVfdXBkYXRlX2Rpc2tfaW5mbyBhbmQgaG93IGl0
IGlzCj4+IGNhbGxlZC4KPj4KPiBPa2F5LCB0aGVuOiBXaGF0IHdvdWxkIGJlIHRoZSBjb3JyZWN0
IHdheSBvZiBoYW5kbGluZyBhIHNpemUgdXBkYXRlIGZvciAKPiBOVk1lIG11bHRpcGF0aD8KPiBB
c3N1bWluZyB3ZSdyZSBnZXR0aW5nIGFuIEFFTiBmb3IgZWFjaCBwYXRoIHNpZ25hbGxpbmcgdGhl
IHNpemUgY2hhbmdlCj4gKG9yIGEgY29udHJvbGxlciByZXNldCBsZWFkaW5nIHRvIGEgc2l6ZSBj
aGFuZ2UpLgo+IFNvIGlmIHdlJ3JlIHVwZGF0aW5nIHRoZSBzaXplIG9mIHRoZSBtdWx0aXBhdGgg
ZGV2aWNlIHRvZ2V0aGVyIHdpdGggdGhlIAo+IHBhdGggZGV2aWNlIGF0IHRoZSBmaXJzdCBBRU4v
cmVzZXQgd2UnbGwgZW5kIHVwIHdpdGggdGhlIG90aGVyIHBhdGhzIAo+IGhhdmluZyBhIGRpZmZl
cmVudCBzaXplIHRoYW4gdGhlIG11bHRpcGF0aCBkZXZpY2UgKGFuZCB0aGUgcGF0aCB3ZSd2ZSAK
PiBqdXN0IGJlZW4gdXBkYXRpbmcpLgo+IC0gRG8gd2UgY2FyZSwgb3IgY3Jvc3MgZmluZ2VycyBh
bmQgaG9wZSBmb3IgdGhlIGJlc3Q/Cj4gLSBTaG91bGRuJ3Qgd2UgZGV0ZWN0IHRoZSBjYXNlIHdo
ZXJlIHdlIHdvbid0IGdldCBhIHNpemUgdXBkYXRlIGZvciB0aGUgCj4gb3RoZXIgcGF0aHMsIG9y
LCBpbmRlZWQsIHdlIGhhdmUgYSBnZW51aW5lIGRldmljZSBzaXplIG1pc21hdGNoIGR1ZSB0byBh
IAo+IG1pc2NvbmZpZ3VyYXRpb24gb24gdGhlIHRhcmdldD8KPiAKPiBJRSBzaG91bGRuJ3Qgd2Ug
aGF2ZSBhIGZsYWcgJ3NpemUgdXBkYXRlIHBlbmRpbmcnIGZvciB0aGUgb3RoZXIgcGF0aHMsLCAK
PiB0byB0YWtlIHRoZW0gb3V0IG91ZiB1c2UgdGVtcG9yYXJpbHkgdW50aWwgdGhlIG90aGVyIEFF
TnMvcmVzZXRzIGhhdmUgCj4gYmVlbiBwcm9jZXNzZWQ/Cgp0aGUgbXBhdGggZGV2aWNlIHdpbGwg
dGFrZSB0aGUgbWluaW11bSBzaXplIGZyb20gYWxsIHRoZSBwYXRocywgdGhhdCBpcwp3aGF0IGJs
a19zdGFja19saW1pdHMgZG9lcy4gV2hlbiB0aGUgQUVOIGZvciBhbGwgdGhlIHBhdGhzIHdpbGwg
YXJyaXZlCnRoZSBtcGF0aCBzaXplIHdpbGwgdXBkYXRlLgoKTm90IHN1cmUgaG93IHRoaXMgaXMg
ZGlmZmVyZW50IHRoYW4gd2hhdCB3ZSBoYXZlIHRvZGF5Li4uCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51
eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

Return-Path: <SRS0=LLxJ=NI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5824FC4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 22:07:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1713660EB5
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Aug 2021 22:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1713660EB5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E1xFVHd2qGpfMeUP3o1o0juhbaLTNR+liR3jILIzZXw=; b=NgGGpNCQEmLkM8H7BDR5a7bmNz
	gRWL4uzumDxaqI6gRZSkC7PVZFpecvvoNEbNTXAUe3BC3j2uXj03dUJRUYEJxY0DzgJOLmSEggZ+d
	hicQ9HmUg8voeez6+IN51emM95mk8pX0HoyJeDK6Yrp0vBGw/U1qEu2lEvMsBEjtAzDPiNywBapm5
	h1BNY05LPdCgexgz5XColyxvzTAJVEcIIlnSoNNHaOEh2emf4eo0HfdQU45NDP0pXuKgpgUu0l+e5
	H35M+KcDgeeWF/Y8UrmoMvCKn9gBnNXDE9JorE5ySEuMKUP6S6QIpQRG7tJYnHqSz0baWnW3CHCh7
	1h43jueA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mG7EM-003bpv-3h; Tue, 17 Aug 2021 22:06:46 +0000
Received: from mail-pg1-f182.google.com ([209.85.215.182])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mG7EG-003bp9-OQ
 for linux-nvme@lists.infradead.org; Tue, 17 Aug 2021 22:06:44 +0000
Received: by mail-pg1-f182.google.com with SMTP id n18so112557pgm.12
 for <linux-nvme@lists.infradead.org>; Tue, 17 Aug 2021 15:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d1NvDBzspxxyRi/JU6mkO/Y9RX6b8XmFBQ7KZDZMOrI=;
 b=IEUVaU38te0w1ltmAzp0edXp1bYrVBVWuhUQr2pkxN1mRoJVBcnh4yB5NBSGQ8upGl
 hc1E/6lutzrPcUgsUmTx9L+/IKFU144/FJ3+JevNZUy5u1+jP+s+gFcZDtjia9vKOkzD
 ORvXP1b93vFHiZ1KBn3IP+u3sH9E808Nh29XTWHIC9dP0c64QSGUC9ZSxG1FIjf+NR1w
 /E/SMnsWx5UWIAruGjTh50YRXA3jqH7KXTkNa64lrn2YYHp/G2N0AKB+rNmkwk+tfaLW
 ZodjqfWw4goPDnntfv0GY+OQ9j1hGmwSgoUbqXKtwxtD+Ck67SfxRD7g1TYmCrYbrH+n
 o1Cw==
X-Gm-Message-State: AOAM5334T3TzpXFXdE59ejHZIH2uy1eWc1VuMQnmbs6LQs/11iRBfR5W
 /G9Nj8gFl0Z3m/raVyPzoJ4=
X-Google-Smtp-Source: ABdhPJw7LqAAu3ADrUe4x5xcX+IpGVCRdOJivZhoDJHTeIj8/NmXs+jjll6YxWczOsAmKfPaM7OZQQ==
X-Received: by 2002:a05:6a00:884:b029:346:8678:ce15 with SMTP id
 q4-20020a056a000884b02903468678ce15mr5735112pfj.75.1629237999882; 
 Tue, 17 Aug 2021 15:06:39 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com
 ([2620:15c:211:201:ae3f:1e44:e6d0:4a44])
 by smtp.gmail.com with ESMTPSA id y5sm4244890pgs.27.2021.08.17.15.06.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Aug 2021 15:06:39 -0700 (PDT)
Subject: Re: [PATCH 3/7] block: copy offload support infrastructure
To: dgilbert@interlog.com, Mikulas Patocka <mpatocka@redhat.com>
Cc: SelvaKumar S <selvakuma.s1@samsung.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@redhat.com, kbusch@kernel.org, axboe@kernel.dk,
 damien.lemoal@wdc.com, asml.silence@gmail.com, johannes.thumshirn@wdc.com,
 hch@lst.de, willy@infradead.org, kch@kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>, djwong@kernel.org,
 Mike Snitzer <snitzer@redhat.com>, agk@redhat.com, selvajove@gmail.com,
 joshiiitr@gmail.com, nj.shetty@samsung.com, nitheshshetty@gmail.com,
 joshi.k@samsung.com, javier.gonz@samsung.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101758epcas5p1ec353b3838d64654e69488229256d9eb@epcas5p1.samsung.com>
 <20210817101423.12367-4-selvakuma.s1@samsung.com>
 <ad3561b9-775d-dd4d-0d92-6343440b1f8f@acm.org>
 <alpine.LRH.2.02.2108171630120.30363@file01.intranet.prod.int.rdu2.redhat.com>
 <bbecc7e7-8bf5-3fe3-6c24-883c79fb7517@interlog.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <53b14381-101f-209b-382c-67d88af9647d@acm.org>
Date: Tue, 17 Aug 2021 15:06:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <bbecc7e7-8bf5-3fe3-6c24-883c79fb7517@interlog.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210817_150640_845954_5A59E407 
X-CRM114-Status: GOOD (  19.16  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gOC8xNy8yMSAyOjUzIFBNLCBEb3VnbGFzIEdpbGJlcnQgd3JvdGU6Cj4gT24gMjAyMS0wOC0x
NyA0OjQxIHAubS4sIE1pa3VsYXMgUGF0b2NrYSB3cm90ZToKPj4gT24gVHVlLCAxNyBBdWcgMjAy
MSwgQmFydCBWYW4gQXNzY2hlIHdyb3RlOgo+Pj4gT24gOC8xNy8yMSAzOjE0IEFNLCBTZWx2YUt1
bWFyIFMgd3JvdGU6Cj4+Pj4gSW50cm9kdWNlIFJFUV9PUF9DT1BZLCBhIG5vLW1lcmdlIGNvcHkg
b2ZmbG9hZCBvcGVyYXRpb24uIENyZWF0ZQo+Pj4+IGJpbyB3aXRoIGNvbnRyb2wgaW5mb3JtYXRp
b24gYXMgcGF5bG9hZCBhbmQgc3VibWl0IHRvIHRoZSBkZXZpY2UuCj4+Pj4gTGFyZ2VyIGNvcHkg
b3BlcmF0aW9uIG1heSBiZSBkaXZpZGVkIGlmIG5lY2Vzc2FyeSBieSBsb29raW5nIGF0IGRldmlj
ZQo+Pj4+IGxpbWl0cy4gUkVRX09QX0NPUFkoMTkpIGlzIGEgd3JpdGUgb3AgYW5kIHRha2VzIHpv
bmVfd3JpdGVfbG9jayB3aGVuCj4+Pj4gc3VibWl0dGVkIHRvIHpvbmVkIGRldmljZS4KPj4+PiBO
YXRpdmUgY29weSBvZmZsb2FkIGlzIG5vdCBzdXBwb3J0ZWQgZm9yIHN0YWNrZWQgZGV2aWNlcy4K
Pj4+Cj4+PiBVc2luZyBhIHNpbmdsZSBvcGVyYXRpb24gZm9yIGNvcHktb2ZmbG9hZGluZyBpbnN0
ZWFkIG9mIHNlcGFyYXRlIAo+Pj4gb3BlcmF0aW9ucwo+Pj4gZm9yIHJlYWRpbmcgYW5kIHdyaXRp
bmcgaXMgZnVuZGFtZW50YWxseSBpbmNvbXBhdGlibGUgd2l0aCB0aGUgZGV2aWNlIAo+Pj4gbWFw
cGVyLgo+Pj4gSSB0aGluayB3ZSBuZWVkIGEgY29weS1vZmZsb2FkaW5nIGltcGxlbWVudGF0aW9u
IHRoYXQgaXMgY29tcGF0aWJsZSAKPj4+IHdpdGggdGhlCj4+PiBkZXZpY2UgbWFwcGVyLgo+Pgo+
PiBJIG9uY2Ugd3JvdGUgYSBjb3B5IG9mZmxvYWQgaW1wbGVtZW50YXRpb24gdGhhdCBpcyBjb21w
YXRpYmxlIHdpdGggZGV2aWNlCj4+IG1hcHBlci4gVGhlIGNvcHkgb3BlcmF0aW9uIGNyZWF0ZXMg
dHdvIGJpb3MgKG9uZSBmb3IgcmVhZGluZyBhbmQgb25lIGZvcgo+PiB3cml0aW5nKSwgcGFzc2Vz
IHRoZW0gaW5kZXBlbmRlbnRseSB0aHJvdWdoIGRldmljZSBtYXBwZXIgYW5kIHBhaXJzIHRoZW0K
Pj4gYXQgdGhlIHBoeXNpY2FsIGRldmljZSBkcml2ZXIuCj4+Cj4+IEl0J3MgaGVyZTogCj4+IGh0
dHA6Ly9wZW9wbGUucmVkaGF0LmNvbS9+bXBhdG9ja2EvcGF0Y2hlcy9rZXJuZWwveGNvcHkvY3Vy
cmVudAo+IAo+IEluIG15IGNvcHkgc29sdXRpb24gdGhlIHJlYWQtc2lkZSBhbmQgd3JpdGUtc2lk
ZSBiaW8gcGFpcnMgc2hhcmUgdGhlIAo+IHNhbWUgc3RvcmFnZSAoaS5lLiByYW0pIFRoaXMgZ2V0
cyBhcm91bmQgdGhlIG5lZWQgdG8gY29weSBkYXRhIGJldHdlZW4gCj4gdGhlIGJpb19zLgo+IFNl
ZToKPiAgwqDCoCBodHRwczovL3NnLmRhbm55LmN6L3NnL3NnX3Y0MC5odG1sCj4gaW4gU2VjdGlv
biA4IG9uIFJlcXVlc3Qgc2hhcmluZy4gVGhpcyB0ZWNobmlxdWUgY2FuIGJlIGVmZmljaWVudGx5
IAo+IGV4dGVuZCB0bwo+IHNvdXJjZSAtLT4gZGVzdGluYXRpb24xLGRlc3RpbmF0aW9uMiwuLi7C
oMKgwqDCoMKgIGNvcGllcy4KPiAKPiBEb3VnIEdpbGJlcnQKPiAKPj4gSSB2ZXJpZmllZCB0aGF0
IGl0IHdvcmtzIHdpdGggaVNDU0kuIFdvdWxkIHlvdSBiZSBpbnRlcmVzdGVkIGluIAo+PiBjb250
aW51aW5nCj4+IHRoaXMgd29yaz8KCkhpIE1pa3VsYXMgYW5kIERvdWcsCgpZZXMsIEknbSBpbnRl
cmVzdGVkIGluIGNvbnRpbnVpbmcgTWlrdWxhcycgd29yayBvbiBjb3B5IG9mZmxvYWRpbmcuIEkg
CndpbGwgdGFrZSBhIGxvb2sgYXQgRG91ZydzIGFwcHJvYWNoIHRvbyBmb3Igc2hhcmluZyBidWZm
ZXJzIGJldHdlZW4gCnJlYWQtc2lkZSBhbmQgd3JpdGUtc2lkZSBiaW9zLiBJdCBtYXkgdGFrZSBh
IGZldyBtb250aHMgaG93ZXZlciBiZWZvcmUgSSAKY2FuIGZpbmQgdGhlIHRpbWUgdG8gd29yayBv
biB0aGlzLgoKVGhhbmtzLAoKQmFydC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LW52bWUK

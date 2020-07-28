Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE95C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 06:43:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCD192065C
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 06:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="vnQANqsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD192065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=bgO51YhtN0Wu+/AD4o85Uc2qD533wkB0+9HhwFaccFE=; b=vnQANqsrPCCWxObVrHIMBK+ao
	HCvu57e8mQCPAyvZYsQV6qbbmJIohMRWW4TCE6Y8+yOTaXugD688yPB+G9z5F1hVzledt892oLzrk
	7HxYNjbnqYQ0+8vjRreQjQPL3RzLnItTQWKp7/3C94eJx36iEOQa4ziFDLzPNxj5xYgEGJ0jKuw1n
	1ZQGRKX7nPSoOhchKDOGwFTGZRzVEw2gi4y1/p3nz7ezQAzDxdjHsz8xk1CWvGRjQ3sQDzqLri0op
	U5GGHc/7/HWKYjprfsZiCvpU16ltcdXIPJqZUYXy5+2kV6+I9gjS3mCwXLnd0rm34Pnfz9aD4+S3K
	MTw83C2QQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0JKf-00025P-11; Tue, 28 Jul 2020 06:43:25 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0JKa-00023Z-Jd
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 06:43:23 +0000
Received: by mail-pf1-f196.google.com with SMTP id s26so10380260pfm.4
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 23:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uUlyBkGjg9YdaNgelolxD3DUILuWiprQkDodBXV+H7A=;
 b=CZ7plGszenBZ9nQiGX0NMTLriheGI4EBCdKW7eMaTWuaHRmS6AwsoZJdGE1nCplrVT
 0SsX8XZuuoJMGlJCY2aWd/BihwerLa5Z2jYzcmrxWX1Mju4n6VPJQyq8XmBf3Gc3NtHC
 jGO8u8cSsUkSDZMlLd5HCFzgL8VrEbjGW/p+hXzYkpj3fvdDom0zeYqdx3c9NGkI5LOa
 wPo64HehVf+G+p1byzArQJCI6YTu5p317j3d81/d7iqXU8ihG2y/YeKijdk9hyeNYNfk
 zw4JydGyR8kx01TEexra6YJGgMagpaLAVrJsxiEszUHCG/ZJDIwTdmoxCOZI3g0e90uK
 c1Bg==
X-Gm-Message-State: AOAM531n01d3x6l5gvLGOstnaWTOuoZl4gGCVwBfJBKMKWFLYr2JFL31
 lKoUdW3Kj4C1WludsDBHX3G/yAby
X-Google-Smtp-Source: ABdhPJyM6jJ2nhz5tiWFdGQb32NPlqCoefOvwgRlEFxfEZ8tjME5UBJyIi8IgpyA8zH9K6QlaH2L+Q==
X-Received: by 2002:a63:d74c:: with SMTP id w12mr17255226pgi.260.1595918599103; 
 Mon, 27 Jul 2020 23:43:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe?
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id c139sm17267289pfb.65.2020.07.27.23.43.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 23:43:18 -0700 (PDT)
Subject: Re: [PATCH 2/2] nvme-multipath: do not fall back to
 __nvme_find_path() for non-optimized paths
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
References: <20200727160803.55683-1-hare@suse.de>
 <20200727160803.55683-3-hare@suse.de>
 <bb5ad6b6-c0b2-213e-e16a-a6bfcba394e1@grimberg.me>
 <25b94bcf-1730-da16-6a1f-b68ffa4b8970@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9897ca64-5dfd-78dc-ae75-72ecc3578d77@grimberg.me>
Date: Mon, 27 Jul 2020 23:43:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <25b94bcf-1730-da16-6a1f-b68ffa4b8970@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_024321_836466_6ED06B63 
X-CRM114-Status: GOOD (  16.83  )
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
Cc: linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>,
 Keith Busch <keith.busch@wdc.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiBXaGVuIG52bWVfcm91bmRfcm9iaW5fcGF0aCgpIGZpbmRzIGEgdmFsaWQgbmFtZXNwYWNl
IHdlIHNob3VsZCBiZSAKPj4+IHVzaW5nIGl0Owo+Pj4gZmFsbGluZyBiYWNrIHRvIF9fbnZtZV9m
aW5kX3BhdGgoKSBmb3Igbm9uLW9wdGltaXplZCBwYXRocyB3aWxsIGNhdXNlIAo+Pj4gdGhlCj4+
PiByZXN1bHQgZnJvbSBudm1lX3JvdW5kX3JvYmluX3BhdGgoKSB0byBiZSBpZ25vcmVkIGZvciBu
b24tb3B0aW1pemVkIAo+Pj4gcGF0aHMuCj4+Pgo+Pj4gU2lnbmVkLW9mZi1ieTogTWFydGluIFdp
bGNrIDxtd2lsY2tAc3VzZS5jb20+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBIYW5uZXMgUmVpbmVja2Ug
PGhhcmVAc3VzZS5kZT4KPj4+IC0tLQo+Pj4gwqAgZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRo
LmMgfCA1ICsrKystCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L211bHRpcGF0
aC5jIAo+Pj4gYi9kcml2ZXJzL252bWUvaG9zdC9tdWx0aXBhdGguYwo+Pj4gaW5kZXggZmU4Zjdm
MTIzZmFjLi45N2QzYzE5YjU2ODQgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9t
dWx0aXBhdGguYwo+Pj4gKysrIGIvZHJpdmVycy9udm1lL2hvc3QvbXVsdGlwYXRoLmMKPj4+IEBA
IC0yNzIsOCArMjcyLDExIEBAIGlubGluZSBzdHJ1Y3QgbnZtZV9ucyAqbnZtZV9maW5kX3BhdGgo
c3RydWN0IAo+Pj4gbnZtZV9uc19oZWFkICpoZWFkKQo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgbnZt
ZV9ucyAqbnM7Cj4+PiDCoMKgwqDCoMKgIG5zID0gc3JjdV9kZXJlZmVyZW5jZShoZWFkLT5jdXJy
ZW50X3BhdGhbbm9kZV0sICZoZWFkLT5zcmN1KTsKPj4+IC3CoMKgwqAgaWYgKFJFQURfT05DRSho
ZWFkLT5zdWJzeXMtPmlvcG9saWN5KSA9PSBOVk1FX0lPUE9MSUNZX1JSICYmIG5zKQo+Pj4gK8Kg
wqDCoCBpZiAoUkVBRF9PTkNFKGhlYWQtPnN1YnN5cy0+aW9wb2xpY3kpID09IE5WTUVfSU9QT0xJ
Q1lfUlIgJiYgbnMpIHsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBucyA9IG52bWVfcm91bmRfcm9i
aW5fcGF0aChoZWFkLCBub2RlLCBucyk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgaWYgKG5zKQo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIG5zOwo+Pj4gK8KgwqDCoCB9Cj4+PiDCoMKg
wqDCoMKgIGlmICh1bmxpa2VseSghbnMgfHwgIW52bWVfcGF0aF9pc19vcHRpbWl6ZWQobnMpKSkK
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBucyA9IF9fbnZtZV9maW5kX3BhdGgoaGVhZCwgbm9kZSk7
Cj4+Cj4+IE1heWJlIGluc3RlYWQgb2YgdGhlIGVhcmx5IHJldHVybiBwdXQgdGhlIGZvbGxvd2lu
ZyBjb25kaXRpb24gb24gZWxzZT8KPiAKPiBUaGF0IGRlcGVuZHMgb24gd2hldGhlciB3ZSB3YW50
IHRvIGhhdmUgYSBmYWxsYmFjayB0byBfX252bWVfZmluZF9wYXRoKCkgCj4gb3Igbm90LiBXaXRo
IHlvdXIgc3VnZ2VzdGlvbiB3ZSB3b3VsZCBsb3NlIHRoYXQ7IEknZCByYXRoZXIga2VlcCBpdC4K
Ck9LLi4uCgpSZXZpZXdlZC1ieTogU2FnaSBHcmltYmVyZyA8c2FnaUBncmltYmVyZy5tZT4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

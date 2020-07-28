Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB558C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 06:50:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F3A2065C
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 06:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="21GkB7eL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F3A2065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Y3eRtp2qT4PkmES6cuVAWPlM3JNrs7yW6aYb/mmube8=; b=21GkB7eLlGOL0cCPn5V5GU0XN
	VV5FmkVt/w8kBlre3bBzqJ0Mva4T7V7mlMn+/dpQunqJoG1IsqsKhd3p/e0E4DCfH/YlnquTp8X2p
	9s2NCfVeBzzysFgfQGdwKi43nvtkpEWobVrgDPkEiZKxXJNn9ekKK+eAjQyy7upFTuCRqBzmYHFBI
	rQ4xfwevEus6kVlTezW0rIi+ln/V9ga+jz80EYDcT+i0yMx57RUY5aHybizgeG1pEiZ2tzWUgG5sd
	XbepZmkvz6FsgLtG7eQLI7k0A0IA/HsOxHG/JfZFfo0pTJAYa0w7zwe9LwQFhOyaiLdpfnsOLF4ml
	U4t2dBFuw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0JR1-0004gZ-5v; Tue, 28 Jul 2020 06:49:59 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0JQx-0004fu-Tx
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 06:49:56 +0000
Received: by mail-pg1-f195.google.com with SMTP id d4so11329638pgk.4
 for <linux-nvme@lists.infradead.org>; Mon, 27 Jul 2020 23:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VPYaDPUj+NdKnOygyxrGm4XazDwziho4pvflzBrG8EA=;
 b=T+eotUz6cAHbKGzNfa4NBFqYbj2BoWoVRaO9QuVuXKqAnPrbuB/RPliOX5agOyN00p
 /NKPMhdUMrmlE2dtkGHVnL8JluJFNn2euYhygM1GANIS5uvd/GXvgQ8DsCTkdYpNkIUp
 ezCNduZ9Mu6fU39V80+Gkec/wyabSbxCqd0cx2Mxj4++PL796d1ElruHePTa30Mde5xP
 zmFyU3y3ShOUjPdlRXPvYiUqkkXsyosfJg+0Mp8iSzpF7H8aYZwacoLcQ36YXw6mbnWJ
 EdqwY2xaircl6PtKLobTmk7AWo55mQLyorC4jOmus6SyuFzlu8f77NfEZQDuVUETfWsM
 lUMA==
X-Gm-Message-State: AOAM533Mr1fQ4D1M/+td6QA4JyfsJlU6NOpV5ljeNpCESDxFHInVyOM+
 3X6m0Op/FHjuP9kud8nlKBtloJwX
X-Google-Smtp-Source: ABdhPJycQnWSPJJQmOJoC40+RY20Wxz5tkdYbvw7kn3xwGDuv60iz0K4P4CgaWQUFLgnQr3qh4YuoQ==
X-Received: by 2002:a62:3207:: with SMTP id y7mr23192408pfy.95.1595918994794; 
 Mon, 27 Jul 2020 23:49:54 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe?
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id h2sm17230174pfk.93.2020.07.27.23.49.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 23:49:54 -0700 (PDT)
Subject: Re: [PATCH] nvme-fabrics: allow to queue requests for live queues
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200728053523.21657-1-sagi@grimberg.me>
 <8ff91295-9393-a548-a46f-85d415d9cbc9@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <233d8e35-f85f-458e-05ad-5baba1b04bbb@grimberg.me>
Date: Mon, 27 Jul 2020 23:49:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8ff91295-9393-a548-a46f-85d415d9cbc9@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_024955_973207_1FBCABF4 
X-CRM114-Status: GOOD (  18.58  )
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
Cc: James Smart <james.smart@broadcom.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMgYi9kcml2ZXJzL252
bWUvaG9zdC9mYWJyaWNzLmMKPj4gaW5kZXggNGVjNDgyOWQ2MjMzLi4yZTc4MzhmNDJlMzYgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYwo+PiArKysgYi9kcml2ZXJz
L252bWUvaG9zdC9mYWJyaWNzLmMKPj4gQEAgLTU2NCwyMSArNTY0LDEzIEBAIGJvb2wgX19udm1m
X2NoZWNrX3JlYWR5KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwsIAo+PiBzdHJ1Y3QgcmVxdWVzdCAq
cnEsCj4+IMKgIHsKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgbnZtZV9yZXF1ZXN0ICpyZXEgPSBudm1l
X3JlcShycSk7Cj4+IC3CoMKgwqAgLyoKPj4gLcKgwqDCoMKgICogSWYgd2UgYXJlIGluIHNvbWUg
c3RhdGUgb2Ygc2V0dXAgb3IgdGVhcmRvd24gb25seSBhbGxvdwo+PiAtwqDCoMKgwqAgKiBpbnRl
cm5hbGx5IGdlbmVyYXRlZCBjb21tYW5kcy4KPj4gLcKgwqDCoMKgICovCj4+IC3CoMKgwqAgaWYg
KCFibGtfcnFfaXNfcGFzc3Rocm91Z2gocnEpIHx8IChyZXEtPmZsYWdzICYgTlZNRV9SRVFfVVNF
UkNNRCkpCj4gImlmICghYmxrX3JxX2lzX3Bhc3N0aHJvdWdoKHJxKSkiIHNob3VsZCBub3QgZGVs
ZXRlLiBCZWNhdXNlIGlmIHdlIGRlbGV0ZSwKPiB0aGUgbm9ybWFsIGlvIHdpbGwgYmUgc2VuZCB0
byB0YXJnZXQsIHRoZSB0YXJnZXQgY2FuIG5vdCB0cmVhdCB0aGUgaW8KPiBpZiB0aGUgcXVldWUg
aXMgbm90IE5WTUVfQ1RSTF9MSVZFLgoKU3VyZSBpdCBkb2VzLCB0aGUgb25seSByZWFzb24gZm9y
IHVzIHRvIGRlbnkgdGhpcyBJL08sIGlzIGlmIHRoZSBxdWV1ZQppcyBub3QgbGl2ZS4gVGhlIGNv
bnRyb2xsZXIgc3RhdGUgc2hvdWxkIG9ubHkgX2FkdmlzZV8gdXMgaWYgd2UgbmVlZCB0bwpsb29r
IGF0IHRoZSBxdWV1ZSBzdGF0ZS4KCj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gZmFsc2U7Cj4+
IC0KPj4gwqDCoMKgwqDCoCAvKgo+PiDCoMKgwqDCoMKgwqAgKiBPbmx5IGFsbG93IGNvbW1hbmRz
IG9uIGEgbGl2ZSBxdWV1ZSwgZXhjZXB0IGZvciB0aGUgY29ubmVjdCAKPj4gY29tbWFuZCwKPj4g
wqDCoMKgwqDCoMKgICogd2hpY2ggaXMgcmVxdWlyZSB0byBzZXQgdGhlIHF1ZXVlIGxpdmUgaW4g
dGhlIGFwcHJvcGlucXVhdGUgCj4+IHN0YXRlcy4KPj4gwqDCoMKgwqDCoMKgICovCj4+IMKgwqDC
oMKgwqAgc3dpdGNoIChjdHJsLT5zdGF0ZSkgewo+PiAtwqDCoMKgIGNhc2UgTlZNRV9DVFJMX05F
VzoKPj4gwqDCoMKgwqDCoCBjYXNlIE5WTUVfQ1RSTF9DT05ORUNUSU5HOgo+PiAtwqDCoMKgwqDC
oMKgwqAgaWYgKG52bWVfaXNfZmFicmljcyhyZXEtPmNtZCkgJiYKPj4gK8KgwqDCoMKgwqDCoMKg
IGlmIChibGtfcnFfaXNfcGFzc3Rocm91Z2gocnEpICYmIG52bWVfaXNfZmFicmljcyhyZXEtPmNt
ZCkgJiYKPiBJZiBudm1lX2lzX2ZhYnJpY3MocmVxLT5jbWQpIGlzIHRydWUsIGJsa19ycV9pc19w
YXNzdGhyb3VnaChycSkgbXVzdAo+IGJlIHR1cmUuIHdoeSBuZWVkIGFkZCBjaGVjayBibGtfcnFf
aXNfcGFzc3Rocm91Z2gocnEpPwoKcmVxLT5jbWQgaXMgb25seSB2YWxpZCBmb3IgcGFzc3RocnUg
Y29tbWFuZHMsIGhlbmNlIHdlIG5lZWQgdG8gY2hlY2sgZm9yCnRoYXQgYmVmb3JlIHdlIHJlZmVy
ZW5jZSByZXEtPmNtZC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52
bWUK

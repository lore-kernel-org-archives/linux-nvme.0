Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF829C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 21:12:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76FFA20768
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 21:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qq3+0lXY";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JjT1kgyZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76FFA20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Nz1ZqA1hEYj0A2lXeSr8YhQaFQHGuA3iiiWUoDyEvHs=; b=qq3+0lXY60UC23t0HZSAHFuTR
	6XtEr3ZvcrPhw8TeV6TLcjx8Lh8xGFS/bKaABPqvLUSXph9pTTtXYzV8MSff9t+3kOlSOzEKA5KOi
	lIB8KS5hC9btd5OhkfsSDc501hSDwHirzEErz86WZxOLHgAVhTBP9Pcqc3qsrbwWHElcxXGlE4Ge7
	GR6rbSM2X/QSovvmwHn0szM7WVKLp6GMx26Q52DtrvXgeN/ddUkU5z1oE8gKxQs8kNQgUhbz9ySkG
	JnyeCDxnBQRQ32/mfxS5uqh//uhUFF+3r7sddn5fApnMsheb9C2Nv7D71drbs8uccDDJoXhmhTzSN
	CGMFlKkOQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6gzt-00055l-Lo; Fri, 14 Aug 2020 21:12:21 +0000
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6gzp-00055I-IQ
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 21:12:20 +0000
Received: by mail-pl1-x642.google.com with SMTP id y6so4742025plt.3
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 14:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=fem9HzMKtKnr5idrchxD1PRQfjpflMh2d4uK86HYaMI=;
 b=JjT1kgyZ1EOOCP04oweArYIIxLyzWjAmDmIreSiU6vti7wGjIEA5N+p/zJAJbgka2S
 DJi6E0bYrUfA/3gWww0F07dd2/MGg5jJNyA8u7gjAyQpKKZVWR0icpbUVTUadFM8WEDY
 Pxg8K7BGpg0PObou9pFR9PwOk0jiYHaWmEJB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=fem9HzMKtKnr5idrchxD1PRQfjpflMh2d4uK86HYaMI=;
 b=fcJpbVUR9Hi2Pf41JQGd+/Jp6uHICay3gZqUWabySCssW7fRwoNbD95Q9p1pSqQcs6
 PVo9+inrxhuSW0bPrLn3J1bT6a+8Ya7SmyRTP7ulKDyEBHz7JYfExOWNpuxx/AEXDZl6
 tcGVgzvS/fbeZn8t5o4+DLVNUNpqTBdhHSyn6I8HTJOZwI8CpboVz2CffMudDJldzmY/
 eA5H9QGy6WIbYkY7en6Tmg9PNvcNrj22xvDmP4HbFGDdg6s3WeEu4sFoCxnCub2rugxX
 esG3AM4k3Dn+Carwb1Hve2w91+GRtiGGqLaRogxSkn5RLDX5ABgHB8iEtq49ZzxGiwMf
 k7dg==
X-Gm-Message-State: AOAM530clqEGDO3W5OqoFjVRiA8MFEoAEmeEo+f6ER6n3Xm2kaPIAncJ
 ao/KqJzQM5xcvLanuznhuB60YQ==
X-Google-Smtp-Source: ABdhPJwXsOQ0q20JBmnBaD3WdHe3uWfbQhgtNcYDcC8W35hKysIxCQrHXGexVUAlwYP0hwo6Gu7T4Q==
X-Received: by 2002:a17:902:9309:: with SMTP id
 bc9mr3200724plb.51.1597439535035; 
 Fri, 14 Aug 2020 14:12:15 -0700 (PDT)
Received: from [192.168.1.42] (ip68-5-85-189.oc.oc.cox.net. [68.5.85.189])
 by smtp.gmail.com with ESMTPSA id w23sm9161823pgj.5.2020.08.14.14.12.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 14:12:14 -0700 (PDT)
Subject: Re: [PATCH v2 6/8] nvme-rdma: serialize controller teardown sequences
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-7-sagi@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <7c3b10ab-6176-92d8-f2eb-45498f903778@broadcom.com>
Date: Fri, 14 Aug 2020 14:12:12 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200806191127.592062-7-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_171218_162944_3F170614 
X-CRM114-Status: GOOD (  27.97  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiA4LzYvMjAyMCAxMjoxMSBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPiBJbiB0aGUgdGlt
ZW91dCBoYW5kbGVyIHdlIG1heSBuZWVkIHRvIGNvbXBsZXRlIGEgcmVxdWVzdCBiZWNhdXNlIHRo
ZQo+IHJlcXVlc3QgdGhhdCB0aW1lZCBvdXQgbWF5IGJlIGFuIEkvTyB0aGF0IGlzIGEgcGFydCBv
ZiBhIHNlcmlhbCBzZXF1ZW5jZQo+IG9mIGNvbnRyb2xsZXIgdGVhcmRvd24gb3IgaW5pdGlhbGl6
YXRpb24uIEluIG9yZGVyIHRvIGNvbXBsZXRlIHRoZQo+IHJlcXVlc3QsIHdlIG5lZWQgdG8gZmVu
Y2UgYW55IG90aGVyIGNvbnRleHQgdGhhdCBtYXkgY29tcGV0ZSB3aXRoIHVzCj4gYW5kIGNvbXBs
ZXRlIHRoZSByZXF1ZXN0IHRoYXQgaXMgdGltaW5nIG91dC4KPgo+IEluIHRoaXMgY2FzZSwgd2Ug
Y291bGQgaGF2ZSBhIHBvdGVudGlhbCBkb3VibGUgY29tcGxldGlvbiBpbiBjYXNlCj4gYSBoYXJk
LWlycSBvciBhIGRpZmZlcmVudCBjb21wZXRpbmcgY29udGV4dCB0cmlnZ2VyZWQgZXJyb3IgcmVj
b3ZlcnkKPiBhbmQgaXMgcnVubmluZyBpbmZsaWdodCByZXF1ZXN0IGNhbmNlbGxhdGlvbiBjb25j
dXJyZW50bHkgd2l0aCB0aGUKPiB0aW1lb3V0IGhhbmRsZXIuCj4KPiBQcm90ZWN0IHVzaW5nIGEg
Y3RybCB0ZWFyZG93bl9sb2NrIHRvIHNlcmlhbGl6ZSBjb250ZXh0cyB0aGF0IG1heQo+IGNvbXBs
ZXRlIGEgY2FuY2VsbGVkIHJlcXVlc3QgZHVlIHRvIGVycm9yIHJlY292ZXJ5IG9yIGEgcmVzZXQu
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJnLm1lPgo+IC0t
LQo+ICAgZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jIHwgNiArKysrKysKPiAgIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9y
ZG1hLmMgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPiBpbmRleCA0NGM3NmZmYmIyNjQuLmFi
YzMxODczN2YzNSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPiArKysg
Yi9kcml2ZXJzL252bWUvaG9zdC9yZG1hLmMKPiBAQCAtMTIyLDYgKzEyMiw3IEBAIHN0cnVjdCBu
dm1lX3JkbWFfY3RybCB7Cj4gICAJc3RydWN0IHNvY2thZGRyX3N0b3JhZ2Ugc3JjX2FkZHI7Cj4g
ICAKPiAgIAlzdHJ1Y3QgbnZtZV9jdHJsCWN0cmw7Cj4gKwlzdHJ1Y3QgbXV0ZXgJCXRlYXJkb3du
X2xvY2s7Cj4gICAJYm9vbAkJCXVzZV9pbmxpbmVfZGF0YTsKPiAgIAl1MzIJCQlpb19xdWV1ZXNb
SENUWF9NQVhfVFlQRVNdOwo+ICAgfTsKPiBAQCAtOTk3LDYgKzk5OCw3IEBAIHN0YXRpYyBpbnQg
bnZtZV9yZG1hX2NvbmZpZ3VyZV9pb19xdWV1ZXMoc3RydWN0IG52bWVfcmRtYV9jdHJsICpjdHJs
LCBib29sIG5ldykKPiAgIHN0YXRpYyB2b2lkIG52bWVfcmRtYV90ZWFyZG93bl9hZG1pbl9xdWV1
ZShzdHJ1Y3QgbnZtZV9yZG1hX2N0cmwgKmN0cmwsCj4gICAJCWJvb2wgcmVtb3ZlKQo+ICAgewo+
ICsJbXV0ZXhfbG9jaygmY3RybC0+dGVhcmRvd25fbG9jayk7Cj4gICAJYmxrX21xX3F1aWVzY2Vf
cXVldWUoY3RybC0+Y3RybC5hZG1pbl9xKTsKPiAgIAludm1lX3JkbWFfc3RvcF9xdWV1ZSgmY3Ry
bC0+cXVldWVzWzBdKTsKPiAgIAlpZiAoY3RybC0+Y3RybC5hZG1pbl90YWdzZXQpIHsKPiBAQCAt
MTAwNywxMSArMTAwOSwxMyBAQCBzdGF0aWMgdm9pZCBudm1lX3JkbWFfdGVhcmRvd25fYWRtaW5f
cXVldWUoc3RydWN0IG52bWVfcmRtYV9jdHJsICpjdHJsLAo+ICAgCWlmIChyZW1vdmUpCj4gICAJ
CWJsa19tcV91bnF1aWVzY2VfcXVldWUoY3RybC0+Y3RybC5hZG1pbl9xKTsKPiAgIAludm1lX3Jk
bWFfZGVzdHJveV9hZG1pbl9xdWV1ZShjdHJsLCByZW1vdmUpOwo+ICsJbXV0ZXhfdW5sb2NrKCZj
dHJsLT50ZWFyZG93bl9sb2NrKTsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIHZvaWQgbnZtZV9yZG1h
X3RlYXJkb3duX2lvX3F1ZXVlcyhzdHJ1Y3QgbnZtZV9yZG1hX2N0cmwgKmN0cmwsCj4gICAJCWJv
b2wgcmVtb3ZlKQo+ICAgewo+ICsJbXV0ZXhfbG9jaygmY3RybC0+dGVhcmRvd25fbG9jayk7Cj4g
ICAJaWYgKGN0cmwtPmN0cmwucXVldWVfY291bnQgPiAxKSB7Cj4gICAJCW52bWVfc3RhcnRfZnJl
ZXplKCZjdHJsLT5jdHJsKTsKPiAgIAkJbnZtZV9zdG9wX3F1ZXVlcygmY3RybC0+Y3RybCk7Cj4g
QEAgLTEwMjUsNiArMTAyOSw3IEBAIHN0YXRpYyB2b2lkIG52bWVfcmRtYV90ZWFyZG93bl9pb19x
dWV1ZXMoc3RydWN0IG52bWVfcmRtYV9jdHJsICpjdHJsLAo+ICAgCQkJbnZtZV9zdGFydF9xdWV1
ZXMoJmN0cmwtPmN0cmwpOwo+ICAgCQludm1lX3JkbWFfZGVzdHJveV9pb19xdWV1ZXMoY3RybCwg
cmVtb3ZlKTsKPiAgIAl9Cj4gKwltdXRleF91bmxvY2soJmN0cmwtPnRlYXJkb3duX2xvY2spOwo+
ICAgfQo+ICAgCj4gICBzdGF0aWMgdm9pZCBudm1lX3JkbWFfZnJlZV9jdHJsKHN0cnVjdCBudm1l
X2N0cmwgKm5jdHJsKQo+IEBAIC0yMjc4LDYgKzIyODMsNyBAQCBzdGF0aWMgc3RydWN0IG52bWVf
Y3RybCAqbnZtZV9yZG1hX2NyZWF0ZV9jdHJsKHN0cnVjdCBkZXZpY2UgKmRldiwKPiAgIAkJcmV0
dXJuIEVSUl9QVFIoLUVOT01FTSk7Cj4gICAJY3RybC0+Y3RybC5vcHRzID0gb3B0czsKPiAgIAlJ
TklUX0xJU1RfSEVBRCgmY3RybC0+bGlzdCk7Cj4gKwltdXRleF9pbml0KCZjdHJsLT50ZWFyZG93
bl9sb2NrKTsKPiAgIAo+ICAgCWlmICghKG9wdHMtPm1hc2sgJiBOVk1GX09QVF9UUlNWQ0lEKSkg
ewo+ICAgCQlvcHRzLT50cnN2Y2lkID0KCkxvb2tzIGdvb2QgLSBidXQuLi4uCgpJIGhpdCB0aGlz
IHNhbWUgaXNzdWUgb24gRkMgLSBJIHdpbGwgbmVlZCB0byBwb3N0IGEgc2ltaWxhciBwYXRoLiBN
eSAKcHJvYmxlbSB3YXMgdGhhdCB0aGUgcmVzZXQvdGVhcmRvd24gcGF0aCBkdWUgdG8gdGhlIHRp
bWVvdXQgdGhlbiByYWNlZCAKd2l0aCB0aGUgZXJyb3IgdGhhdCB0aGUgY29ubmVjdCBwYXRoIHNh
dyBmb3IgaXRzIGlvIHRoYXQgZHJvcHBlZCBpbnRvIAp0aGUgcGFydGlhbC10ZWFyZG93biBzdGVw
cyBhcyBjb25uZWN0IGJhY2tlZC1vdXQuwqDCoCBTbyBJIHJlY29tbWVuZCAKbG9va2luZyBhdCBu
dm1lX3JkbWFfc2V0dXBfY3RybCgpIGFuZCBhbnkgb2YgaXQncyB0ZWFyZG93biBwYXRocyB0aGF0
IApkb24ndCBoYXZlIHRoZSBtdXRleCBhbmQgbWF5IHJhY2Ugd2l0aCBjYXNlcyB0aGF0IGFyZSB0
YWtpbmcgdGhlIG11dGV4LgoKSWYgaXQncyBhbGwgZ29vZCAtIHlvdSBjYW4gYWRkIG15IFJldmll
d2VkLWJ5IGZvciBpdC4KCi0tIGphbWVzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtbnZtZQo=

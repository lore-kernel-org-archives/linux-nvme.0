Return-Path: <SRS0=B+Fz=D4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15330C5517A
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 04:59:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827B420936
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2020 04:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZXTZAGOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827B420936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=w2DjX2h6y6K3LJ6PZbNHwe7agVAhEvZy3h6WZyP4XBo=; b=ZXTZAGOQ8tYubCugj/KbF1Uyt
	0OcmPoqzgGuqUBAmFDrAaHku3dCVT8tFDPZ9kmv3kTPDbe6nUA1sdScf+uvqrBBU6xL7KybuJmSxC
	SS51p/dSssckiUc2bmNQiIW0J99JN29IWysBqbVThXsK8JBJPwXinzQHTaDOp6HNskNSDRrQG8VRb
	/sA7bmfwp5tcoXv3Cs1ljLQTFlHNneihhJ68Qu1URKCwDwx63xSnyLuwvMO0q1a1XwRsfS6uBtcV7
	3Jc8ra2Ym084ZFMcQLRiAHuUPgo4yy61NOnbbuIi5/rL6GNqaQJ8u2Oa9YaHn9df2vdNIZMh0v+D5
	mAIqve1mg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kV6DN-0005B4-Gc; Wed, 21 Oct 2020 04:59:09 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kV6DL-0005AO-5o
 for linux-nvme@lists.infradead.org; Wed, 21 Oct 2020 04:59:08 +0000
Received: by mail-wr1-f67.google.com with SMTP id x7so1401999wrl.3
 for <linux-nvme@lists.infradead.org>; Tue, 20 Oct 2020 21:59:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=K9Egxc8WZDOSb7RF7K5h7mDn28FEx2hzN6nSAqYXmPs=;
 b=R/Oaro/rrS1cjAXoJJ6E2CLu0dCnSjCa4lUDh8c95WP9A9LeRffIXz7ZlatR87ZLWL
 83RelHEl9Ne6KUc5pCz4TY00NKRh2nxApk79Ois5dxR5pnvG2wkSFZgsAU2TuZNmkxYQ
 V7dpm5k7wAey1sGUcqqK+LoS/ncR0qhyYOICqMAZfUC1pEKizbVwt/0GVnkkUNtxGiwh
 m3AR9ThtRfUQHmC61juLHxU45w1Rz1+J/x1vnbfGyeTZ6f+ECA6f7chVF3BkQZ4W6P54
 bGAozahrYTGdyFumlQ+g8f+D2vwd7hkVPMaj/etI3SSr/upCLjMO8OxLV87+VaAswrHW
 a8LA==
X-Gm-Message-State: AOAM531Via7RMBdSbyXfo9o5mu/ULAU92A2S3pqs7kOpGjW9x1Bh7JGn
 4zUx1rgXqa7DPwQuJNEBBiQ=
X-Google-Smtp-Source: ABdhPJwYLFRKV8t6CqTYFIBTKUut6RXcH0/eusOg7931loYfGSNgI9upWCwsy+LQ5qPksq1CWxZeHQ==
X-Received: by 2002:adf:cd0c:: with SMTP id w12mr2139538wrm.305.1603256345562; 
 Tue, 20 Oct 2020 21:59:05 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:16e2:6f16:c01c:df28?
 ([2601:647:4802:9070:16e2:6f16:c01c:df28])
 by smtp.gmail.com with ESMTPSA id c18sm1539660wrt.10.2020.10.20.21.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2020 21:59:05 -0700 (PDT)
Subject: Re: [PATCH 0/3] avoid race between time out and tear down
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20201020090808.27702-1-lengchao@huawei.com>
 <9e1966b0-d471-0043-7fdb-e0f535571feb@grimberg.me>
 <3d5b96dd-4e0f-758a-4175-e69fef0b8c34@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b60f34ea-86f1-ef86-8e1f-b156b7681699@grimberg.me>
Date: Tue, 20 Oct 2020 21:59:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <3d5b96dd-4e0f-758a-4175-e69fef0b8c34@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201021_005907_262027_53D22D00 
X-CRM114-Status: GOOD (  19.39  )
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
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiBBdm9pZCByYWNlIGJldHdlZW4gdGltZSBvdXQgYW5kIHRlYXIgZG93biBmb3IgcmRtYSBh
bmQgdGNwLgo+Pgo+PiBUaGlzIHBhdGNoc2V0IG92ZXJhbGwgbG9va3MgZ29vZCwgYnV0IHdlIHN0
aWxsIG5lZWQgdGhlIHBhdGNoIHRoYXQKPj4gYXZvaWRzIGRvdWJsZSBjb21wbGV0aW9uOgo+Pgo+
PiAtLSAKPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jIGIvZHJpdmVycy9u
dm1lL2hvc3QvdGNwLmMKPj4gaW5kZXggNjI5YjAyNTY4NWQxLi40NjQyOGZmMGIwZmMgMTAwNjQ0
Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCj4+ICsrKyBiL2RyaXZlcnMvbnZtZS9o
b3N0L3RjcC5jCj4+IEBAIC0yMTc1LDcgKzIxNzUsNyBAQCBzdGF0aWMgdm9pZCBudm1lX3RjcF9j
b21wbGV0ZV90aW1lZF9vdXQoc3RydWN0IAo+PiByZXF1ZXN0ICpycSkKPj4gwqDCoMKgwqDCoMKg
wqDCoCAvKiBmZW5jZSBvdGhlciBjb250ZXh0cyB0aGF0IG1heSBjb21wbGV0ZSB0aGUgY29tbWFu
ZCAqLwo+PiDCoMKgwqDCoMKgwqDCoMKgIG11dGV4X2xvY2soJnRvX3RjcF9jdHJsKGN0cmwpLT50
ZWFyZG93bl9sb2NrKTsKPj4gwqDCoMKgwqDCoMKgwqDCoCBudm1lX3RjcF9zdG9wX3F1ZXVlKGN0
cmwsIG52bWVfdGNwX3F1ZXVlX2lkKHJlcS0+cXVldWUpKTsKPj4gLcKgwqDCoMKgwqDCoCBpZiAo
IWJsa19tcV9yZXF1ZXN0X2NvbXBsZXRlZChycSkpIHsKPj4gK8KgwqDCoMKgwqDCoCBpZiAoYmxr
X21xX3JlcXVlc3Rfc3RhcnRlZChycSkgJiYgCj4+ICFibGtfbXFfcmVxdWVzdF9jb21wbGV0ZWQo
cnEpKSB7Cj4gWWVzLCB0aGlzIHBhdGNoIGlzIG5lZWQuIGFuZCBzYW1lbHkgZm9yIG52bWVfY2Fu
Y2VsX3JlcXVlc3QuCj4gVGhpcyB3aWxsIGZpeCB0aGUgcmFjZSB3aXRoIGFzeW5jaHJvbm91cyBj
b21wbGV0aW9uLgo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9k
cml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiBpbmRleCBlODVmNjMwNGVmZDcuLjFlODM4ZDk1MjA5
NiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiArKysgYi9kcml2ZXJz
L252bWUvaG9zdC9jb3JlLmMKPiBAQCAtMzM4LDcgKzMzOCw3IEBAIGJvb2wgbnZtZV9jYW5jZWxf
cmVxdWVzdChzdHJ1Y3QgcmVxdWVzdCAqcmVxLCB2b2lkIAo+ICpkYXRhLCBib29sIHJlc2VydmVk
KQo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAiQ2FuY2VsbGluZyBJL08gJWQiLCByZXEtPnRhZyk7Cj4gCj4gIMKgwqDCoMKg
wqDCoMKgIC8qIGRvbid0IGFib3J0IG9uZSBjb21wbGV0ZWQgcmVxdWVzdCAqLwo+IC3CoMKgwqDC
oMKgwqAgaWYgKGJsa19tcV9yZXF1ZXN0X2NvbXBsZXRlZChyZXEpKQo+ICvCoMKgwqDCoMKgwqAg
aWYgKGJsa19tcV9yZXF1ZXN0X2NvbXBsZXRlZChyZXEpIHx8ICFibGtfbXFfcmVxdWVzdF9zdGFy
dGVkKHJxKSkKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOwo+
IAo+ICDCoMKgwqDCoMKgwqDCoCBudm1lX3JlcShyZXEpLT5zdGF0dXMgPSBOVk1FX1NDX0hPU1Rf
QUJPUlRFRF9DTUQ7CgpUaGlzIG9uZSBpcyB1bm5lZWRlZCBiZWNhdXNlIGJsa19tcV90YWdzZXRf
YnVzeV9pdGVyIGNoZWNrcyB0aGF0IHRoZQpyZXF1ZXN0IGhhcyBzdGFydGVkLi4uCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxp
bmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

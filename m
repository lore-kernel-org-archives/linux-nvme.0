Return-Path: <SRS0=Cbe1=EO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30007C388F9
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 13:59:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81234206E3
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2020 13:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1P2RxP1/";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sttzqSuL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81234206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GEPlfaswy4M42JWJA03EwuQ7Oot0gt5VtahiA6xHOvM=; b=1P2RxP1/ERzMc2yTlwenJKI5K
	vfk3lA0FfMt6Ah6YSiKF5Y4sRItame9cTShh2G/iPHV6N0O4bsgnsnIuk2bK452KiEdSbKdujjwPw
	GpOjI9b1b3uzLqZmdbNC6m7jXOijKaj+b0VCf0NR6aHC0iyNqCGjC5XM3qKb6CLJi3flVbTNTn23p
	yRfHVe9E6MbPzK3kLER++9ZSl9k9Huqnt26gOcU71jkw+xTczMzX9R3OX2U99XohoSoQPpupikDGu
	UoTZQqC+LBVAS9Qe734vzZe7FvYby21btn/pmknITqiCl//4UJ3hzCqE385CgZX+IExQq5v9OZf8z
	YBVSPocTw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kblDr-0008SK-KB; Sun, 08 Nov 2020 13:59:11 +0000
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kblDn-0008Rx-J1
 for linux-nvme@lists.infradead.org; Sun, 08 Nov 2020 13:59:08 +0000
Received: by mail-ed1-x541.google.com with SMTP id b9so5947179edu.10
 for <linux-nvme@lists.infradead.org>; Sun, 08 Nov 2020 05:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=FQnmNPDubMBv3HYHLbOC10CgBLSVUI3pQ2wqAzGb2Ew=;
 b=sttzqSuLPnrmagzPMxuxIBnQMX8d3xfKtfVJvz+GT8+uJPLvrAkwnvh4ugE7qYSoh6
 etzHCCm0qeY8wmRUAN+0UhE+BE5znMVguVmMGU+nFc8M71Ny12RvvsFn8Kafn4oPic5/
 6hZppZgp2tZOrI+mCmxN6GXpH/HrJLDmR6oOeLYDrWGV3EgkK13TYp/NMiwjgHx9jwKp
 Pr7+53NSKrLXjbB5IzOx1Psa7EggSzuyCpW7ittRHDKyDY8prrhZGdyiISSvsGAj7rBG
 Vf5fD65M/geyWduUOhAPoV92HFGJ+aEfOTf65WIl+qAAf+VbvrOfkE7YctK55soCzhbN
 zLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=FQnmNPDubMBv3HYHLbOC10CgBLSVUI3pQ2wqAzGb2Ew=;
 b=ob3/LKQAu3SM9cOxEa9IqZ7gxAp6A9IXBnvMJ0nxPJJuyt0bUDqhIygYWPy63Vq1Xd
 RwSrjVXjfcX5TA06rG8ehShaeEtKbYnGquVmLAQzHZI6oVsBY1n58N+hnSdsTXUy7D39
 6QL+VOXwQ3NwqVPzZMGYs6RRzbXFd0DIHqBNmIknFiIR6o6Lc19aBBtSqtU3Vy5q4CTW
 vyb7badB2qWFq1GO6uiUyPIkzHH1hZT5zYUCMF/Pf//bz2YycLXaCg4HQfHdR9YfHXi+
 F32UBt0yHKsKDOw47uOkQrfDedqVCjVXyIuwhfLyctpuvpNPWv5peIjW0HqdI1nMCZ+Q
 75GQ==
X-Gm-Message-State: AOAM532PQyGGWqDj8YR9D9kZGrd41di1tveJWTIyxBfJj8x6u11uECPd
 eu766uoLO6Nj5gLo8HhMlOM=
X-Google-Smtp-Source: ABdhPJz1sUCthpNfMXgX4a/E4Z1JjGrvjHMjXnLmg+P+qGYLK7QPagBQjjdjUH+XVvuJ/Jzld3GIiQ==
X-Received: by 2002:a50:99cd:: with SMTP id n13mr11031795edb.10.1604843946073; 
 Sun, 08 Nov 2020 05:59:06 -0800 (PST)
Received: from [132.68.43.131] ([132.68.43.131])
 by smtp.gmail.com with ESMTPSA id s21sm6127093edc.42.2020.11.08.05.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Nov 2020 05:59:05 -0800 (PST)
Subject: Re: [PATCH net-next RFC v1 06/10] nvme-tcp: Add DDP data-path
To: Sagi Grimberg <sagi@grimberg.me>, Boris Pismenny <borisp@mellanox.com>,
 kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 axboe@fb.com, kbusch@kernel.org, viro@zeniv.linux.org.uk, edumazet@google.com
References: <20200930162010.21610-1-borisp@mellanox.com>
 <20200930162010.21610-7-borisp@mellanox.com>
 <5a23d221-fd3e-5802-ce68-7edec55068bb@grimberg.me>
 <24ea956e-40a2-8b7b-cf8a-b604e7cd5644@grimberg.me>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <6551237d-104d-1e3f-00a7-a3b479786344@gmail.com>
Date: Sun, 8 Nov 2020 15:59:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <24ea956e-40a2-8b7b-cf8a-b604e7cd5644@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201108_085907_713227_18EA47EB 
X-CRM114-Status: GOOD (  16.65  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAwOS8xMC8yMDIwIDI6MDAsIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4+PiDCoCBzdGF0aWMK
Pj4+IMKgIGludCBudm1lX3RjcF9vZmZsb2FkX3NvY2tldChzdHJ1Y3QgbnZtZV90Y3BfcXVldWUg
KnF1ZXVlLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgbnZt
ZV90Y3BfY29uZmlnICpjb25maWcpCj4+PiBAQCAtNjMwLDYgKzcyMCw3IEBAIHN0YXRpYyB2b2lk
IG52bWVfdGNwX2Vycm9yX3JlY292ZXJ5KHN0cnVjdCAKPj4+IG52bWVfY3RybCAqY3RybCkKPj4+
IMKgIHN0YXRpYyBpbnQgbnZtZV90Y3BfcHJvY2Vzc19udm1lX2NxZShzdHJ1Y3QgbnZtZV90Y3Bf
cXVldWUgKnF1ZXVlLAo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBudm1lX2NvbXBsZXRp
b24gKmNxZSkKPj4+IMKgIHsKPj4+ICvCoMKgwqAgc3RydWN0IG52bWVfdGNwX3JlcXVlc3QgKnJl
cTsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IHJlcXVlc3QgKnJxOwo+Pj4gwqDCoMKgwqDCoCBycSA9
IGJsa19tcV90YWdfdG9fcnEobnZtZV90Y3BfdGFnc2V0KHF1ZXVlKSwgY3FlLT5jb21tYW5kX2lk
KTsKPj4+IEBAIC02NDEsOCArNzMyLDE1IEBAIHN0YXRpYyBpbnQgbnZtZV90Y3BfcHJvY2Vzc19u
dm1lX2NxZShzdHJ1Y3QgCj4+PiBudm1lX3RjcF9xdWV1ZSAqcXVldWUsCj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7Cj4+PiDCoMKgwqDCoMKgIH0KPj4+IC3CoMKgwqAgaWYg
KCFudm1lX3RyeV9jb21wbGV0ZV9yZXEocnEsIGNxZS0+c3RhdHVzLCBjcWUtPnJlc3VsdCkpCj4+
PiAtwqDCoMKgwqDCoMKgwqAgbnZtZV9jb21wbGV0ZV9ycShycSk7Cj4+PiArwqDCoMKgIHJlcSA9
IGJsa19tcV9ycV90b19wZHUocnEpOwo+Pj4gK8KgwqDCoCBpZiAocmVxLT5vZmZsb2FkZWQpIHsK
Pj4+ICvCoMKgwqDCoMKgwqDCoCByZXEtPnN0YXR1cyA9IGNxZS0+c3RhdHVzOwo+Pj4gK8KgwqDC
oMKgwqDCoMKgIHJlcS0+cmVzdWx0ID0gY3FlLT5yZXN1bHQ7Cj4+PiArwqDCoMKgwqDCoMKgwqAg
bnZtZV90Y3BfdGVhcmRvd25fZGRwKHF1ZXVlLCBjcWUtPmNvbW1hbmRfaWQsIHJxKTsKPj4+ICvC
oMKgwqAgfSBlbHNlIHsKPj4+ICvCoMKgwqDCoMKgwqDCoCBpZiAoIW52bWVfdHJ5X2NvbXBsZXRl
X3JlcShycSwgY3FlLT5zdGF0dXMsIGNxZS0+cmVzdWx0KSkKPj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG52bWVfY29tcGxldGVfcnEocnEpOwo+Pj4gK8KgwqDCoCB9Cj4gT2ggZm9yZ290IHRv
IGFzaywKPgo+IFdlIGhhdmUgcGxhY2VzIGluIHRoZSBkcml2ZXIgdGhhdCB3ZSBtYXkgY29tcGxl
dGUgKGNhbmNlbCkgb25lCj4gb3IgbW9yZSByZXF1ZXN0cyBmcm9tIHRoZSBlcnJvciByZWNvdmVy
eSBvciB0aW1lb3V0IGZsb3cuIFdlCj4gZmlyc3QgcHJldmVudCBmdXR1cmUgaW5jb21pbmcgUlgg
b24gdGhlIHNvY2tldCBzdWNoIHRoYXQgd2UKPiBjYW4gc2FmZWx5IGNhbmNlbCByZXF1ZXN0cy4g
VGhpcyBtYXkgYnJlYWsgd2l0aCB0aGUgZGVmZXJyZWQKPiBjb21wbGV0aW9uIGluIGRkcF90ZWFy
ZG93bl9kb25lLgo+Cj4gSWYgSSBoYXZlIGEgcmVxdWVzdCB0aGF0IGlzIHdhaXRpbmcgZm9yIGRk
cF90ZWFyZG93bl9kb25lIGRvCj4gSSBoYXZlIGEgd2F5IHRvIHRlbGwgdGhlIEhXIHRvIG5ldmVy
IGNhbGwgZGRwX3RlYXJkb3duX2RvbmUKPiBvbiBhIHNwZWNpZmljIHNvY2tldD8KPgo+IElmIHNv
IHRoZSBwbGFjZSB0byBpcyBpbiBudm1lX3RjcF9zdG9wX3F1ZXVlLgpJbnRlcmVzdGluZyBhbmQg
aW5kZWVkLCBpdCBpcyBhIHByb2JsZW0gdGhhdCB3ZSBoYXZlbid0IGNvbnNpZGVyZWQuCgoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

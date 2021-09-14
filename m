Return-Path: <SRS0=UXA3=OE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88474C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:06:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43151610A6
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Sep 2021 07:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 43151610A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eSqFDpBd8mNRECE3bJwfh/dcx79Cuj1xdEJvd39TJlU=; b=B86cdTVXm93GbSsnbIlMYlg2Un
	GR/DTGAl1AdfX57DMA32Fc552UcWII3phrxzDBWrlxwN4+CUUALdc8S31SqzpRKuxLricozr3hjVc
	ltgUOMX00TUVmVm0K2YvSce4rrf6Jg7WeB2WGwZtPehq/A2N1L08wIBKyvDgyhDkSgc865uNaUkys
	PPI4j3aWkjLKboACngYw0SJJa3kMNWRpjcjg9z5+06tLOVRfj5YJRkacL1/Mc9R+QQYcLkm/O7QIu
	mp1C+tVXOLbHpyp9YF9egvfRKNqM5g93AUIapC/yDl0qHHu6ez/X5T56QgwLw91Wj4mCNPhk9I7MA
	ZtGQsk5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mQ2WG-004NcF-V5; Tue, 14 Sep 2021 07:06:16 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mQ2WC-004Nah-SE
 for linux-nvme@lists.infradead.org; Tue, 14 Sep 2021 07:06:15 +0000
Received: by mail-wr1-f45.google.com with SMTP id t18so18519461wrb.0
 for <linux-nvme@lists.infradead.org>; Tue, 14 Sep 2021 00:06:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ASSw//9AOWQ7NN/5WP5M7iKdi8iqcYmLot2EnNzllx0=;
 b=qz2L5vanf8zPtFBZYMF4S5POXo+ZNtzADwmZ8e8PQ9729xxQSnANaF8GY74RhkFWfh
 3/q+HvBq8nGoTM//h5l70BpaaMzKVPGry+6OxYSzT8WKPkOUlwW7vksVGBZs2OU5YcvX
 io+oFmfCmqkpgIGWrMEblXise0xt8WbrQV8/DwqYDmxmjopOEoZ01WBb4pExvgcuiJ8E
 j/P/YgumMtMphUFwe1r8yG5enmfT/W2jDzethtUjcEik9qipZA7qmxQ6oXh1XzChOMBp
 87ePHlnr9W1X8r2B1XxeKDwgEVh+8gqma6jj52d9hJsJ3vdBrrjR5hfJS59x1Okszv9j
 zW/Q==
X-Gm-Message-State: AOAM533lG+93H1BPHgusKJ85ZQ9AkBZAdxUaG4OiEiAij+QL/XsdRixi
 ZffRZ/zYHVvLa8KVCyotosU=
X-Google-Smtp-Source: ABdhPJw5mBypqnu0KyfJVJ+5gN7bFeUoaS6ohgXx4qavWkVs1uUllKQWLn+LnGJbRAdeIGDnqnycIg==
X-Received: by 2002:adf:eb4f:: with SMTP id u15mr16598752wrn.352.1631603170982; 
 Tue, 14 Sep 2021 00:06:10 -0700 (PDT)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id n66sm239555wmn.2.2021.09.14.00.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Sep 2021 00:06:10 -0700 (PDT)
Subject: Re: [PATCH 07/12] nvme: Implement In-Band authentication
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>, linux-nvme@lists.infradead.org,
 linux-crypto@vger.kernel.org
References: <20210910064322.67705-1-hare@suse.de>
 <20210910064322.67705-8-hare@suse.de>
 <99cbf790-c276-b3d0-6140-1f5bfa8665eb@grimberg.me>
 <8bff9a88-a5d4-d7bb-8ce9-81d30438bfbb@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6eeae78a-a4eb-bb18-6cad-273e1a21050a@grimberg.me>
Date: Tue, 14 Sep 2021 10:06:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <8bff9a88-a5d4-d7bb-8ce9-81d30438bfbb@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210914_000612_953960_843C98EA 
X-CRM114-Status: GOOD (  14.59  )
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

Pj4+IEBAIC0zNjEsMTEgKzM2NiwxMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgbnZtZV9lbmRfcmVx
KHN0cnVjdCByZXF1ZXN0Cj4+PiAqcmVxKQo+Pj4gIMKgIMKgIHZvaWQgbnZtZV9jb21wbGV0ZV9y
cShzdHJ1Y3QgcmVxdWVzdCAqcmVxKQo+Pj4gIMKgIHsKPj4+ICvCoMKgwqAgc3RydWN0IG52bWVf
Y3RybCAqY3RybCA9IG52bWVfcmVxKHJlcSktPmN0cmw7Cj4+PiArCj4+PiAgwqDCoMKgwqDCoCB0
cmFjZV9udm1lX2NvbXBsZXRlX3JxKHJlcSk7Cj4+PiAgwqDCoMKgwqDCoCBudm1lX2NsZWFudXBf
Y21kKHJlcSk7Cj4+PiAgwqAgLcKgwqDCoCBpZiAobnZtZV9yZXEocmVxKS0+Y3RybC0+a2FzKQo+
Pj4gLcKgwqDCoMKgwqDCoMKgIG52bWVfcmVxKHJlcSktPmN0cmwtPmNvbXBfc2VlbiA9IHRydWU7
Cj4+PiArwqDCoMKgIGlmIChjdHJsLT5rYXMpCj4+PiArwqDCoMKgwqDCoMKgwqAgY3RybC0+Y29t
cF9zZWVuID0gdHJ1ZTsKPj4+ICDCoCDCoMKgwqDCoMKgIHN3aXRjaCAobnZtZV9kZWNpZGVfZGlz
cG9zaXRpb24ocmVxKSkgewo+Pj4gIMKgwqDCoMKgwqAgY2FzZSBDT01QTEVURToKPj4+IEBAIC0z
NzcsNiArMzg0LDE1IEBAIHZvaWQgbnZtZV9jb21wbGV0ZV9ycShzdHJ1Y3QgcmVxdWVzdCAqcmVx
KQo+Pj4gIMKgwqDCoMKgwqAgY2FzZSBGQUlMT1ZFUjoKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAg
bnZtZV9mYWlsb3Zlcl9yZXEocmVxKTsKPj4+ICDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+
Pj4gK8KgwqDCoCBjYXNlIEFVVEhFTlRJQ0FURToKPj4+ICsjaWZkZWYgQ09ORklHX05WTUVfQVVU
SAo+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmIChudm1lX2NoYW5nZV9jdHJsX3N0YXRlKGN0cmwsIE5W
TUVfQ1RSTF9SRVNFVFRJTkcpKQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcXVldWVfd29y
ayhudm1lX3dxLCAmY3RybC0+ZGhjaGFwX2F1dGhfd29yayk7Cj4+Cj4+IFdoeSBpcyB0aGUgc3Rh
dGUgY2hhbmdlIGhlcmUgYW5kIG5vdCBpbiBudm1lX2RoY2hhcF9hdXRoX3dvcms/Cj4+Cj4gQmVj
YXVzZSBzd2l0Y2hpbmcgdG8gJ3Jlc2V0dGluZycgaXMgYW4gZWFzeSB3YXkgdG8gc3luY2hyb25p
emUgd2l0aCB0aGUKPiBhZG1pbiBxdWV1ZS4KCk1heWJlIGZvbGQgdGhpcyBpbnRvIG52bWVfYXV0
aGVudGljYXRlX2N0cmw/IGluIGNhc2Ugc29tZW9uZSBhZGRzL21vdmVzCnRoaXMgaW4gdGhlIGZ1
dHVyZSBhbmQgZm9yZ2V0cyB0aGUgY3RybCBzdGF0ZSBzZXJpYWxpemF0aW9uPwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5n
IGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

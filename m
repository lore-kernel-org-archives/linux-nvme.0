Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A52C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 19:22:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CBF623B1A
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 19:22:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBF623B1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=a83wpkkogMcpWT1Q92g93kI1UAWXKzw7KmR+hhrwmmY=; b=1VezWkAqRKVSygDuzs1s57XId
	ylZu55rm2NYc8/IhMZCwQTcj2xDfsL4XJWxnGyDEUZs+KZINHILUQ29hg7OgjTQC7bb7OM9Yzio7u
	vlCyxeNZOwpRBF/fK0h+maLxfuISmgCf7q4btg5QQtQVP3qzFLU3cz+QgjHIcRpQpBfNBIGLQPvIm
	G8BA8MHD6k5RVmdRy3+GSynIAMFybJFVGgC8KsbKLGWlRNZsGQM2gPuYejWirg3ZKaYAMiqdaGm9Q
	VSxwUHaZE6uwMMPSK71Vv/IOlSAvRECwoqFe+niw7otpgPCFxcHUsLRReqnOCVNYjwbn56uiL/kAd
	bsfM+BsUQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l08Bu-0001GP-NN; Thu, 14 Jan 2021 19:21:54 +0000
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l08Bs-0001Fs-JO
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 19:21:53 +0000
Received: by mail-ej1-x62c.google.com with SMTP id g12so9844475ejf.8
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 11:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hJ4PbZRXWGKbnNFaGjb6sbAezL9+pJDA5n1ewEcRakw=;
 b=b9JJTPOrthVfyFbfmueN5xKP6jsW2O1dwykI3ofvYqnA/17z96hcmzg1VwdbLS0LEM
 cLK7067HCIDL3Tz3ewDachamz7UUuJWQFDeVSTcU1pIDrBb9DeQlNMGVPlMH6dPylM6L
 hVXzhPwxtxUYWJYTrwWNZVMzHfwU0Zvlsa5lKWvcvl0VQqM+CDo6yArtH2fe3JPymQxa
 l2YuKlQBM8UJ6oaDgLwgGHlkUUzMoqx5ipnqcZPwSKf7+ZH0aSs7mvbhWO75/R8OMBX7
 yQdsrTg4rHRLbmlE1v0aeehMwMqX+LUWXvCZcAQhcMSvvrvZgPFmgXOThTK638Oq33xq
 KGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hJ4PbZRXWGKbnNFaGjb6sbAezL9+pJDA5n1ewEcRakw=;
 b=mIrrfLneKCeIWpr6fiwqgWAb69U5IWogSTfNLgnjG2ay1sqH6NWkrCRCyQPuJmhjS4
 +yFnH55CJ7rRKoUkSeQ+LxxoNcqVJjKigdp5p0DfPK8u/6HlcRrjm3U6/WXD4K3eVUBu
 rvw0xW+4CqYS/7h0FIsFBWm5OsDR/azDw1mnIJAebWhHLbxcw78k623rYiEEM3NxDLhQ
 gSrDWrJ9uyDcVJ1QtAqpnt2XLhFG0sdP+dpixg5SQNyQHbHqkNTU3XijLNoVtefOxJMy
 7neUai2fdO7G/zb6AhiM/mZJnCDub5RKlhuemiqPfy2RGGDh211zSlRSOi5Awt4UNSuc
 VNbQ==
X-Gm-Message-State: AOAM533WZq1T51x0zRLLg7WDFuAgABJkIkkm7oRtGyzWarsmuxu4XMoW
 jq2Vhh2muX7tyh4VDeLg6Wk=
X-Google-Smtp-Source: ABdhPJymSRUtSVJJhoQUpZwedJopflzkCpJOkUSDAw1HwbYgz6q2T//Gpwkn6qPjSq8EsINMfJs2Ow==
X-Received: by 2002:a17:906:1b41:: with SMTP id
 p1mr3250203ejg.162.1610652111079; 
 Thu, 14 Jan 2021 11:21:51 -0800 (PST)
Received: from [192.168.1.11] ([213.57.108.142])
 by smtp.gmail.com with ESMTPSA id v25sm2349174ejw.21.2021.01.14.11.21.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Jan 2021 11:21:50 -0800 (PST)
Subject: Re: [PATCH v1 net-next 00/15] nvme-tcp receive offloads
To: David Ahern <dsahern@gmail.com>, Sagi Grimberg <sagi@grimberg.me>,
 Boris Pismenny <borisp@mellanox.com>, kuba@kernel.org, davem@davemloft.net,
 saeedm@nvidia.com, hch@lst.de, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com
References: <20201207210649.19194-1-borisp@mellanox.com>
 <69f9a7c3-e2ab-454a-2713-2e9c9dea4e47@grimberg.me>
 <967ae867-42c9-731d-9cb1-2c81fcc1ef77@gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <a14d5ab8-e62c-65ac-3b8b-0e657226625f@gmail.com>
Date: Thu, 14 Jan 2021 21:21:47 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <967ae867-42c9-731d-9cb1-2c81fcc1ef77@gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_142152_687319_F1C3733B 
X-CRM114-Status: GOOD (  12.75  )
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
Cc: yorayz@nvidia.com, boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 benishay@nvidia.com, netdev@vger.kernel.org, ogerlitz@nvidia.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

CgpPbiAxNC8wMS8yMDIxIDY6NDcsIERhdmlkIEFoZXJuIHdyb3RlOgo+IE9uIDEvMTMvMjEgNjoy
NyBQTSwgU2FnaSBHcmltYmVyZyB3cm90ZToKPj4+IENoYW5nZXMgc2luY2UgUkZDIHYxOgo+Pj4g
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPj4+ICogU3BsaXQgbWx4
NSBkcml2ZXIgcGF0Y2hlcyB0byBzZXZlcmFsIGNvbW1pdHMKPj4+ICogRml4IG52bWUtdGNwIGhh
bmRsaW5nIG9mIHJlY292ZXJ5IGZsb3dzLiBJbiBwYXJ0aWN1bGFyLCBtb3ZlIHF1ZXVlCj4+PiBv
ZmZsYW9kCj4+PiDCoMKgIGluaXQvdGVhcmRvd24gdG8gdGhlIHN0YXJ0L3N0b3AgZnVuY3Rpb25z
Lgo+Pgo+PiBJJ20gYXNzdW1pbmcgdGhhdCB5b3UgdGVzdGVkIGNvbnRyb2xsZXIgcmVzZXRzIGFu
ZCBuZXR3b3JrIGhpY2N1cHMKPj4gZHVyaW5nIHRyYWZmaWMgcmlnaHQ/Cj4gCj4gSSBoYWQgcXVl
c3Rpb25zIG9uIHRoaXMgcGFydCBhcyB3ZWxsIC0tIGUuZy4sIHdoYXQgaGFwcGVucyBvbiBhIFRD
UAo+IHJldHJ5PyBwYWNrZXRzIGFycml2ZSwgc2dsIGZpbGxlZCBmb3IgdGhlIGNvbW1hbmQgaWQs
IGJ1dCBwYWNrZXQgaXMKPiBkcm9wcGVkIGluIHRoZSBzdGFjayAoZS5nLiwgZW5xdWV1ZSBiYWNr
bG9nIGlzIGZpbGxlZCwgc28gcGFja2V0IGdldHMKPiBkcm9wcGVkKQo+IAoKT24gcmUtdHJhbnNt
aXNzaW9uIHRoZSBIVyBjb250ZXh0J3MgZXhwZWN0ZWQgdGNwIHNlcXVlbmNlIG51bWJlciBkb2Vz
bid0Cm1hdGNoLiBBcyBhIHJlc3VsdCwgdGhlIHJlY2VpdmVkIHBhY2tldCBpcyB1bi1vZmZsb2Fk
ZWQgYW5kIHNvZnR3YXJlCndpbGwgZG8gdGhlIGNvcHkvY3JjIGZvciBpdHMgZGF0YS4KCkFzIGEg
Z2VuZXJhbCBydWxlLCBpZiBIVyBjb250ZXh0IGV4cGVjdGVkIHNlcXVlbmNlIG51bWJlcnMgZG9u
J3QgbWF0Y2gsCnRoZW4gdGhlcmUncyBubyBvZmZsb2FkLgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=

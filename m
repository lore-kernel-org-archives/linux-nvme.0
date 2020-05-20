Return-Path: <SRS0=LBLG=7C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD0BC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:19:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944B4206B6
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2020 17:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LtBCkln2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944B4206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WOQ1yvc4+P2wNzJ/9Kn7WwxLHmwZF/iGAi8Mf7WqB7U=; b=LtBCkln2Eucv807rXsmb1n50W
	eofXDQW4YbV0ZnrYtqSMlRgjzYSS0ffpMHtiujVEu1TAIZJ/X5jRHUYxndjr1agvx7PVTL85pNxv/
	8l/5uZMgUvHxm8DGRKibSr/8FmprLJ3iFX9MnXGA1bDAFGjBzNqXJPEvRAgcweh4ODNs0OnvvqklN
	tN1gOmum+fHcm2VU9vZ/sHUBTEdxMuVk0ZO7nG3Yo/ewG4UxpKwM8moWxPy0N+LP70g4BzfPzBjH+
	5U8mmWg03FL7OKEQTb1r0InO94HCBevd7Or+GCSbIkgCal2NyIsdDjOfKsQ17ZULADsAuwKhW+wCd
	0tNQKo+WQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jbSNb-00063K-PM; Wed, 20 May 2020 17:19:43 +0000
Received: from mail-wm1-f67.google.com ([209.85.128.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbSNZ-00062m-Ep
 for linux-nvme@lists.infradead.org; Wed, 20 May 2020 17:19:42 +0000
Received: by mail-wm1-f67.google.com with SMTP id z72so3725432wmc.2
 for <linux-nvme@lists.infradead.org>; Wed, 20 May 2020 10:19:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=s2yW+YUQd95fIk/R7WTm+ZLjQPt9zLnrfs/bsOdA/0w=;
 b=e/etjtqCTjRjs3ZQ3lMLuwQ04jwJ1lUuwpzT4M/ogO7jSLX9FnPwWO1DGDAyRv2QN9
 6fwfTmC5Viyjvn5j7k4QmKt9k09aFHijH98RS/VYFhsw10UAlwYTKRirCduplvOiTq8+
 xr/3/kl+5FA81JObASq8Ts46glWIMo1iduYb7K+yecI3NRc5gxF5XPqzthbBYcb9BfI/
 uS71Am300+yMWf1cziCZ39KRsJL+rawGTeP6lfZc70MsK3kefiknrP9hUE/t+lxtD7AO
 LZmuOhN7XWkO7cSZE4Ommn6OQFJ8oknAPn7dZFwdy6xrHUDhyUb6p5BGILNkZ1DyLUpL
 BUUg==
X-Gm-Message-State: AOAM533azuJYj2IWouUAQSAl9Rrc4sASyrKiM8kf10P2ROpZClSKIM+n
 NY7vkQRSHXl4R2n6aCxD/co=
X-Google-Smtp-Source: ABdhPJxKVHZYMwMObBd59xG9ahPYvv2+De3OU9g+OHNP4oCEvT74xEafw0IILfCjRy3cHKCSxkygLQ==
X-Received: by 2002:a1c:19c1:: with SMTP id 184mr5098929wmz.29.1589995177978; 
 Wed, 20 May 2020 10:19:37 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:91e2:91f6:e321:5d4d?
 ([2601:647:4802:9070:91e2:91f6:e321:5d4d])
 by smtp.gmail.com with ESMTPSA id v126sm4219224wma.9.2020.05.20.10.19.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2020 10:19:37 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] nvmet: avoid memleak by freeing any remaining aens
 in nvmet_async_events_free
To: David Milburn <dmilburn@redhat.com>, Christoph Hellwig <hch@infradead.org>
References: <1589828396-144513-1-git-send-email-dmilburn@redhat.com>
 <1589828396-144513-3-git-send-email-dmilburn@redhat.com>
 <388242d3-5ccc-d694-c7a0-ac489f63f26a@grimberg.me>
 <20200520061613.GA18308@infradead.org>
 <0018af56-e3f9-8730-3c57-c4f19e478014@grimberg.me>
 <20200520070330.GA26871@infradead.org>
 <d353aa1a-cef3-d2f6-66de-92cc18cd97aa@grimberg.me>
 <20200520071526.GA7008@infradead.org>
 <c0379f95-246a-3fd6-9ec9-4ee814562c8d@grimberg.me>
 <41bae172-289e-1407-93a6-4147491a346c@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c3bef33b-f786-e4db-afbc-89e49c159c23@grimberg.me>
Date: Wed, 20 May 2020 10:19:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <41bae172-289e-1407-93a6-4147491a346c@redhat.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200520_101941_498765_E808CAD0 
X-CRM114-Status: GOOD (  16.58  )
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
Cc: chaitanya.kulkarni@wdc.com, dwagner@suse.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gSGkgQ2hyaXN0b3BoLCBTYWdpLAo+IAo+IE9uIDA1LzIwLzIwMjAgMDM6MDYgQU0sIFNhZ2kg
R3JpbWJlcmcgd3JvdGU6Cj4+Cj4+Pj4gOikgSSBndWVzcyB0aGUgcGFuZGVtaWMgZ290IHRvIG1l
Li4uCj4+Pj4KPj4+PiBUaGluZ3MgbWFrZSBhIGxvdCBtb3JlIHNlbnNlIG5vdy4gQnV0IGRvbid0
IHdlIG5lZWQgdG8gbW92ZSB0aGUgYWVucwo+Pj4+IGZyZWUgdG8gYWZ0ZXIgd2UgcmVtb3ZlIHRo
ZSBjb250cm9sbGVyIGZyb20gdGhlIHN1YnN5cy0+Y3RybHM/Cj4+Pgo+Pj4gWWVzLsKgIEkgYWxz
byB0aGluayB3ZSBjYW4gY2xlYW4gdXAgYSBmZXcgdGhpbmdzIGhlcmUuwqAgSG93IGFib3V0IEkg
YXBwbHkKPj4+IHRoZSBzZXJpZXMgZnJvbSBEYXZpZCBub3cgYW5kIHNlbmQgYSBmZXcgYWRkaXRp
b25hbCBmaXh1cHMgb24gdG9wPwo+Pgo+PiBTb3VuZHMgZ29vZAo+Pgo+IAo+IFlpIHdhcyBhYmxl
IHRvIHJlcHJvZHVjZSB0aGUgbWVtbGVhayB1c2luZyB0aGUgdjIgb2YgdGhlIHBhdGNoIHNlcmll
cwo+IHNpbmNlIG52bWV0X2FzeW5jX2V2ZW50c19mcmVlKCkgcmFuIGJlZm9yZSBudm1ldF9hZGRf
YXN5bmNfZXZlbnQoKS4KPiAKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwv
bGludXgtbnZtZS8yMDIwLU1heS8wMzA1MTIuaHRtbAo+IAo+IFdpdGggU2FnaSdzIHBhdGNoIGJl
bG93LCBJIGRvIHNlZSBhZnRlciBudm1ldF9hZGRfYXN5bmNfZXZlbnQoKSwKPiBudm1ldF9hc3lu
Y19ldmVudHNfcHJvY2VzcyBwdWxscyB0aGUgcmVxdWVzdCwgZGVjcmVtZW50cwo+IGN0cmwtPm5y
X2FzeW5jX2V2ZW50X2NtZHMgdG8gMCwgYW5kIGZyZWVzIHRoZSBhZW4sCj4gYW5kIG5vIG1lbW9y
eSBsZWFrLgo+IAo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL3BpcGVybWFpbC9saW51eC1u
dm1lLzIwMjAtTWF5LzAzMDU0OC5odG1sCgpJIGRvbid0IHRoaW5rIHRoYXQgcGF0Y2ggIzEgaXMg
cmVxdWlyZWQgdG8gZml4IHRoZSBpc3N1ZSwgY2FuIHlvdQpjb25maXJtIHRoYXQ/IENocmlzdG9w
aCBzYWlkIGhlIGhhcyBzb21lIG1vcmUgY2xlYW5pbmcgdXAgaW4gdGhpcwphcmVhLgoKQ2hyaXN0
b3BoLApEbyB5b3Ugd2FudCBtZSB0byBzZW5kIGEgZm9ybWFsIHBhdGNoIGZvciB0aGlzPwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtbnZtZSBt
YWlsaW5nIGxpc3QKbGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

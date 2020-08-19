Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C3BC433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 23:16:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B1B3207DA
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 23:16:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hSO0flfl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="S4sOK3E5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B1B3207DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ky1nDdFiQAKkeZSZ/StRb1okGC4cH746VC7RL34wC0k=; b=hSO0flflJ+G1nthpA3jCGbeL3
	aKC7AqrpKjx09jnjALjGWhzulrAbIyYaVw15Ak5nt5YDUqdVzJMFfbwJSdmEr6jMZnCa3gSpADZsi
	h8IOscl4v+MQIY5TtlRd3Rh6Tg1qP98NgFHYpz86wWW7TL/IOaqrXrMe3DORRXI+KSz3mofkTRMb5
	wPleVGRz8P8C9jeNWzXqVqyiajGJCfVqq/FtJtI/VW35o7CbaiAXkZ0gocFocittOWN4dRpsRa1/c
	z/ocyDtUfSlgilHXtUnHV/pOzZV0HCHQGb7/IKDRc6gEYTLEFAxEjT/13QVmJLQhWTixC8c2EVgdf
	3v1WOb+QQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8XJs-0005pK-9L; Wed, 19 Aug 2020 23:16:36 +0000
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8XJo-0005ot-VD
 for linux-nvme@lists.infradead.org; Wed, 19 Aug 2020 23:16:34 +0000
Received: by mail-pg1-x544.google.com with SMTP id o13so240871pgf.0
 for <linux-nvme@lists.infradead.org>; Wed, 19 Aug 2020 16:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=8dkVzVrTH0xjAYJdB4PBni1oATRLoQEGRYbOc02C1dk=;
 b=S4sOK3E5gZ/Soh9293vqif3FBEw/qW9DQ+9Mb9kuseoTbCGKFAyEku7CPrm3jTt4y2
 SB0lo/bmMVAEWT/1+kEZUjrqC/6SRc95cn9q/ehAmS5BItsck+OgSKONgcv5//ZLV0lm
 YCSK39+3UXEE7sP2vNoZbSU4QOGzt9C6Z73Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=8dkVzVrTH0xjAYJdB4PBni1oATRLoQEGRYbOc02C1dk=;
 b=YrP5VDfs34Lo5oN8hgLNSzR8SDHglvz+8tq3yVgToPWDxCr8379OLAZdXrJAXeLB0y
 KMu0abrJOJquFZCpH4UwVU1c6ZDCxQH05NiwNX+CECd2yDOy/Lq8HzoyxIe+P8JuTdBO
 0ZlBKkdx/wx3ujQUxzsH1YmRbxvmsS8KljZFCXXt0KUJD7kcZhT7RBuLSvigaoxxAaqY
 1bXElotWQzLfoHHc035q+wsZLYwpqbLlpKqiUicch0lZ6oMtSLNfaEpiUXmOXQgJ8Svk
 eM0sgOmO32n5YgAVpC8S8DLzugcbbZGaIHXTOHlXSXPdAiNqLcIA4vtwquO89VonWtnP
 g7cQ==
X-Gm-Message-State: AOAM532X+0uo6SUe4wRlyprAEvHZEsDmn/BHA7Z0cJjY3Gr13ArhBuOF
 RR9fWHUZRE3N/E9oGUxrIy9Xi9fZIYX5Lw==
X-Google-Smtp-Source: ABdhPJyAm6Fqf9Rk6/UGfZJlhJy6cC+iFWi73kZeK1LaNNRS//ZWrYXra4GLv29M+hgDU8yrAKOasQ==
X-Received: by 2002:a63:ef46:: with SMTP id c6mr508764pgk.96.1597878988904;
 Wed, 19 Aug 2020 16:16:28 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id h5sm342439pfk.0.2020.08.19.16.16.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Aug 2020 16:16:27 -0700 (PDT)
Subject: Re: [PATCH 5/7] nvme: Fix controller creation races with teardown flow
To: Israel Rukshin <israelr@mellanox.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Sagi Grimberg
 <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
References: <1585063785-14268-1-git-send-email-israelr@mellanox.com>
 <1585063785-14268-6-git-send-email-israelr@mellanox.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <fad9c553-28cd-a40c-1a92-6e36fb7ad383@broadcom.com>
Date: Wed, 19 Aug 2020 16:16:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <1585063785-14268-6-git-send-email-israelr@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200819_191633_341846_9DA6FCC9 
X-CRM114-Status: GOOD (  27.15  )
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
Cc: Shlomi Nimrodi <shlomin@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gMy8yNC8yMDIwIDg6MjkgQU0sIElzcmFlbCBSdWtzaGluIHdyb3RlOgo+IENhbGxpbmcgbnZt
ZV9zeXNmc19kZWxldGUoKSB3aGVuIHRoZSBjb250cm9sbGVyIGlzIGluIHRoZSBtaWRkbGUgb2YK
PiBjcmVhdGlvbiBtYXkgY2F1c2Ugc2V2ZXJhbCBidWdzLiBJZiB0aGUgY29udHJvbGxlciBpcyBp
biBORVcgc3RhdGUgd2UKPiByZW1vdmUgZGVsZXRlX2NvbnRyb2xsZXIgZmlsZSBhbmQgZG9uJ3Qg
ZGVsZXRlIHRoZSBjb250cm9sbGVyLiBUaGUgdXNlcgo+IHdpbGwgbm90IGJlIGFibGUgdG8gdXNl
IG52bWUgZGlzY29ubmVjdCBjb21tYW5kIG9uIHRoYXQgY29udHJvbGxlciBhZ2FpbiwKPiBhbHRo
b3VnaCB0aGUgY29udHJvbGxlciBtYXkgYmUgYWN0aXZlLiBPdGhlciBidWdzIG1heSBoYXBwZW4g
aWYgdGhlCj4gY29udHJvbGxlciBpcyBpbiB0aGUgbWlkZGxlIG9mIGNyZWF0ZV9jdHJsIGNhbGxi
YWNrIGFuZAo+IG52bWVfZG9fZGVsZXRlX2N0cmwoKSBzdGFydHMuIEZvciBleGFtcGxlLCBmcmVl
aW5nIEkvTyB0YWdzZXQgYXQKPiBudm1lX2RvX2RlbGV0ZV9jdHJsKCkgYmVmb3JlIGl0IHdhcyBh
bGxvY2F0ZWQgYXQgY3JlYXRlX2N0cmwgY2FsbGJhY2suCj4KPiBUbyBmaXggYWxsIHRob3NlIHJh
Y2VzIGRvbid0IGFsbG93IHRoZSB1c2VyIHRvIGRlbGV0ZSB0aGUgY29udHJvbGxlcgo+IGJlZm9y
ZSBpdCB3YXMgZnVsbHkgY3JlYXRlZC4KPgo+IFNpZ25lZC1vZmYtYnk6IElzcmFlbCBSdWtzaGlu
IDxpc3JhZWxyQG1lbGxhbm94LmNvbT4KPiBSZXZpZXdlZC1ieTogTWF4IEd1cnRvdm95IDxtYXhn
QG1lbGxhbm94LmNvbT4KPiBSZXZpZXdlZC1ieTogQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBsc3Qu
ZGU+Cj4gLS0tCj4gICBkcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgfCA1ICsrKysrCj4gICBkcml2
ZXJzL252bWUvaG9zdC9udm1lLmggfCAxICsKPiAgIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVy
cy9udm1lL2hvc3QvY29yZS5jCj4gaW5kZXggYmEwNjRmZC4uOTk2MWQwZSAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMKPiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMKPiBAQCAtMzIyOCw2ICszMjI4LDEwIEBAIHN0YXRpYyBzc2l6ZV90IG52bWVfc3lzZnNfZGVs
ZXRlKHN0cnVjdCBkZXZpY2UgKmRldiwKPiAgIHsKPiAgIAlzdHJ1Y3QgbnZtZV9jdHJsICpjdHJs
ID0gZGV2X2dldF9kcnZkYXRhKGRldik7Cj4gICAKPiArCS8qIENhbid0IGRlbGV0ZSBub24tY3Jl
YXRlZCBjb250cm9sbGVycyAqLwo+ICsJaWYgKCFjdHJsLT5jcmVhdGVkKQo+ICsJCXJldHVybiAt
RUJVU1k7Cj4gKwo+ICAgCWlmIChkZXZpY2VfcmVtb3ZlX2ZpbGVfc2VsZihkZXYsIGF0dHIpKQo+
ICAgCQludm1lX2RlbGV0ZV9jdHJsX3N5bmMoY3RybCk7Cj4gICAJcmV0dXJuIGNvdW50Owo+IEBA
IC00MDM5LDYgKzQwNDMsNyBAQCB2b2lkIG52bWVfc3RhcnRfY3RybChzdHJ1Y3QgbnZtZV9jdHJs
ICpjdHJsKQo+ICAgCQludm1lX3F1ZXVlX3NjYW4oY3RybCk7Cj4gICAJCW52bWVfc3RhcnRfcXVl
dWVzKGN0cmwpOwo+ICAgCX0KPiArCWN0cmwtPmNyZWF0ZWQgPSB0cnVlOwo+ICAgfQo+ICAgRVhQ
T1JUX1NZTUJPTF9HUEwobnZtZV9zdGFydF9jdHJsKTsKPgoKRllJIC0gSSd2ZSBoaXQgYSBzY2Vu
YXJpbyB3aXRoIHRoaXMgcGF0Y2gsIHdoZXJlIGlmIHRoZSBkZXZpY2Ugc3RhcnRzIApyZWplY3Rp
bmcgdGhlIGluaXRpYWwgY29ubmVjdGlvbnMgb3IgdGhleSBjb250aW51b3VzbHkgaGl0IGEgZmFp
bHVyZSAtIAp3ZSdyZSBmb3JjZWQgdG8gd2FpdCBjdHJsX2xvc3NfdG1vIGJlZm9yZSBpdCBnb2Vz
IGF3YXkuIFdlIGNhbid0IApmb3JjaWJseSBkZWxldGUgdGhlIGNvbnRyb2xsZXIgdmlhIHN5c2Zz
LsKgIFRoaXMgc2hvdWxkbid0IGJlIHBvc3NpYmxlLgoKSSB1bmRlcnN0YW5kIHRoZSByYWNlIGNv
bmRpdGlvbnMgd2l0aCBkZWxldGUgYW5kIGFtIGxvb2tpbmcgYXQgdGhlIHNhbWUgCnRoaW5nIG9u
IEZDLsKgIExvb2tpbmcgYXQgd2hhdCB3YXMgdHJ5aW5nIHRvIGJlIGFjaGlldmVkLCBpdCBzZWVt
cyB0byAKb3ZlcmxhcCB3aXRoIHNvbWUgb2YgdGhlIHRlYXJkb3duIHRoYXQgU2FnaSBpcyBzeW5j
aHJvbml6aW5nIHdpdGggdGhlIAp0ZWFyZG93bl9sb2NrLgoKV2UgbWF5IHdhbnQgdG8gcmV2aXNp
dCB0aGlzIGNoYW5nZS4KCi0tIGphbWVzCgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LW52bWUK

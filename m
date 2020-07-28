Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95558C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 17:12:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 638C020792
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 17:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BSR+OZ4i";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f3Ufx8TG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 638C020792
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WXjz213ibjObpsOOMsndqj/WQ1B0DRbe5obcyVGZZaw=; b=BSR+OZ4ih/VasD1klwHGmI6uR
	uO98MWlLQkSE3mRDEOMFhaohsry7/B/gKupyt6yzKm+gnYSDaymtkQe/NB12BZaHonnyeQBF/scJR
	mwPV9Firtb0Wcuh0m+AzSn1dZgQKA5Ezz+ZxNecKL19tAhX23/u8jFvxgVp9JgctBwD203wfDAhHv
	nKydRxgsF0i2qUEKK+3Vj8j8V1n6HC/OdLtkVopksWq1Y1wOGAdb4EunxVgkLNFgTaRwTVw+ntsrq
	QI42LY4QqozwWjtlxA66Vl1IsLhrarKgDsEMdmnV4kmguIuXzjjsA291qxA592aKWR2z/wgJBpSSI
	2DjUOVcTQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0T8y-0000w1-HJ; Tue, 28 Jul 2020 17:12:00 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0T8v-0000vY-41
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 17:11:58 +0000
Received: by mail-pl1-x641.google.com with SMTP id t10so4878019plz.10
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=i2GKGC6u3oVfycwXd1Oz6SRoq7vqjvJULmyt+eVpXYw=;
 b=f3Ufx8TGgodEiq521klrGWEszAM3xUKm5mfkAboqN1LA9c1pEIthL1oiqPQHEkklr/
 0Wh5MgGI6rAoc7sL8hjOakzq/TT65kmi5jJB5UkCJaLpn9Zttl3RBuRNqCpvz6AhFsF8
 uzwkybPe8G67se+EX6axnlODZy/66+wHYTKn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=i2GKGC6u3oVfycwXd1Oz6SRoq7vqjvJULmyt+eVpXYw=;
 b=sgLAqPsZDQj2yMwXy+nSTvYPXR879XJd/CXvCOwK/7wOaWdTp06lhQ08PoeS1NknBA
 FLDvSQgtgWyLrRSO2/99Tp4a0wcuaOfkl9emo+s9lK+3lClhFw0rrasSkj30LaSg1bom
 5FJ5at5JeYfaAuekoV9aUKqMo1qM8bjIsPzfULYzJ3ykAuhHuJLGARZADIMPzRzWGpGD
 CeVg1uCL/YKjVA/HNtsFHB6YNYZ66410KJcG6RehSd3ds7sU6GSGOOnrHn73fPXSjeI1
 RQUbmVOP+Uxk7/3S25pWeUVdy6jYDsJAOB5Zm1Snv8XyrY3MLbqDR+P1O9zYjUJXX241
 JwLw==
X-Gm-Message-State: AOAM530cRiAOtN97xaRLtOfeZ+0UcYBao2IzamPqkzu3vtWpmeh2AYBB
 iI9bBlBWU380vaiJix3RH9mqHrPiVpbB1g==
X-Google-Smtp-Source: ABdhPJzCU2++noF+higIFjKPchobdXa67FPMWIZBrMRQISjES1HVvahxQhDh2Q59ybVFU850hKyG/Q==
X-Received: by 2002:a17:90a:bf04:: with SMTP id
 c4mr5104627pjs.149.1595956314588; 
 Tue, 28 Jul 2020 10:11:54 -0700 (PDT)
Received: from [10.69.45.46] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id e13sm17321792pgs.13.2020.07.28.10.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 10:11:53 -0700 (PDT)
Subject: Re: [PATCH] nvme-fabrics: allow to queue requests for live queues
To: Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
References: <20200728053523.21657-1-sagi@grimberg.me>
 <8ff91295-9393-a548-a46f-85d415d9cbc9@huawei.com>
 <233d8e35-f85f-458e-05ad-5baba1b04bbb@grimberg.me>
From: James Smart <james.smart@broadcom.com>
Message-ID: <c782f0c1-76b2-cc67-6770-eb55f9e2a3aa@broadcom.com>
Date: Tue, 28 Jul 2020 10:11:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <233d8e35-f85f-458e-05ad-5baba1b04bbb@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_131157_496034_C48D63D0 
X-CRM114-Status: GOOD (  21.78  )
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

CgpPbiA3LzI3LzIwMjAgMTE6NDkgUE0sIFNhZ2kgR3JpbWJlcmcgd3JvdGU6Cj4KPj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9mYWJyaWNzLmMgYi9kcml2ZXJzL252bWUvaG9zdC9m
YWJyaWNzLmMKPj4+IGluZGV4IDRlYzQ4MjlkNjIzMy4uMmU3ODM4ZjQyZTM2IDEwMDY0NAo+Pj4g
LS0tIGEvZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5jCj4+PiArKysgYi9kcml2ZXJzL252bWUv
aG9zdC9mYWJyaWNzLmMKPj4+IEBAIC01NjQsMjEgKzU2NCwxMyBAQCBib29sIF9fbnZtZl9jaGVj
a19yZWFkeShzdHJ1Y3QgbnZtZV9jdHJsIAo+Pj4gKmN0cmwsIHN0cnVjdCByZXF1ZXN0ICpycSwK
Pj4+IMKgIHsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IG52bWVfcmVxdWVzdCAqcmVxID0gbnZtZV9y
ZXEocnEpOwo+Pj4gLcKgwqDCoCAvKgo+Pj4gLcKgwqDCoMKgICogSWYgd2UgYXJlIGluIHNvbWUg
c3RhdGUgb2Ygc2V0dXAgb3IgdGVhcmRvd24gb25seSBhbGxvdwo+Pj4gLcKgwqDCoMKgICogaW50
ZXJuYWxseSBnZW5lcmF0ZWQgY29tbWFuZHMuCj4+PiAtwqDCoMKgwqAgKi8KPj4+IC3CoMKgwqAg
aWYgKCFibGtfcnFfaXNfcGFzc3Rocm91Z2gocnEpIHx8IChyZXEtPmZsYWdzICYgTlZNRV9SRVFf
VVNFUkNNRCkpCj4+ICJpZiAoIWJsa19ycV9pc19wYXNzdGhyb3VnaChycSkpIiBzaG91bGQgbm90
IGRlbGV0ZS4gQmVjYXVzZSBpZiB3ZSAKPj4gZGVsZXRlLAo+PiB0aGUgbm9ybWFsIGlvIHdpbGwg
YmUgc2VuZCB0byB0YXJnZXQsIHRoZSB0YXJnZXQgY2FuIG5vdCB0cmVhdCB0aGUgaW8KPj4gaWYg
dGhlIHF1ZXVlIGlzIG5vdCBOVk1FX0NUUkxfTElWRS4KPgo+IFN1cmUgaXQgZG9lcywgdGhlIG9u
bHkgcmVhc29uIGZvciB1cyB0byBkZW55IHRoaXMgSS9PLCBpcyBpZiB0aGUgcXVldWUKPiBpcyBu
b3QgbGl2ZS4gVGhlIGNvbnRyb2xsZXIgc3RhdGUgc2hvdWxkIG9ubHkgX2FkdmlzZV8gdXMgaWYg
d2UgbmVlZCB0bwo+IGxvb2sgYXQgdGhlIHF1ZXVlIHN0YXRlLgoKSSBkaXNhZ3JlZSBzdHJvbmds
eSB3aXRoIHJlbW92aW5nIHRoZSBjaGVjayBvbiBOVk1FX1JFUV9VU0VSQ01ELiBXZSd2ZSAKc2Vl
biBjbGkgaW9jdGxzIGdvaW5nIHRvIHRoZSBhZG1pbiBxdWV1ZSB3aGlsZSB3ZSdyZSBpbiB0aGUg
bWlkZGxlIG9mIApkb2luZyBjb250cm9sbGVyIGluaXRpYWxpemF0aW9uIGFuZCBpdCdzIGhhcyBo
b3NlZCB0aGUgY29udHJvbGxlciBzdGF0ZSAKaW4gc29tZSBjYXNlcy4gV2UndmUgc2VlbiBjb21t
YW5kcyBpc3N1ZWQgYmVmb3JlIHRoZSBjb250cm9sbGVyIGlzIGluIAp0aGUgcHJvcGVyIHN0YXRl
LsKgIFRoZSBhZG1pbiBxdWV1ZSBtYXkgYmUgbGl2ZSAtIGJ1dCB3ZSBkb24ndCAKbmVjZXNzYXJp
bHkgd2FudCBvdGhlciBpbyBzbmVha2luZyBpbi4KCkFzIGZvciB0aGUgYmxrX3JxX2lzX3Bhc3N0
aHJvdWdoIGNoZWNrIC0gSSBndWVzcyBJIGNhbiBzZWUgaXQgYmVpbmcgCmJhc2VkIG9uIHRoZSBx
dWV1ZSBzdGF0ZSwgYW5kIHRoZSBjaGVjayBsb29rcyBva8KgICh3ZSBzaG91bGQgbmV2ZXIgc2Vl
IAohYmxrX3JxX2lzX3Bhc3N0aHJvdWdoIG9uIHRoZSBhZG1pbiBxKS4KQnV0Li4uCi0gSSBkb24n
dCBrbm93IHdoeSBpdCB3YXMgdGhhdCBpbXBvcnRhbnQgdG8gY2hhbmdlIGl0LiBPbiB0aGUgY29u
bmVjdGluZyAKcGF0aCwgYWxsIHlvdSdyZSBkb2luZyBpcyBsZXR0aW5nIGlvIHN0YXJ0IGZsb3dp
bmcgYmVmb3JlIGFsbCB0aGUgcXVldWVzIApoYXZlIGJlZW4gY3JlYXRlZC7CoCBEaWQgeW91IHJl
YWxseSBuZWVkIHRvIHN0YXJ0IHRoYXQgbXVjaCBzb29uZXIgPwoKLSBCdXQgb24gdGhlIHJlc2V0
dGluZyBwYXRoLCBvciBkZWxldGluZyBjYXNlcywgeW91J3ZlIGFkZGVkIGEgY29uZGl0aW9uIApu
b3cgd2hlcmUgdGhlIGNvbnRyb2xsZXIgc3RhdGUgd2FzIGNoYW5nZWQsIGJ1dCB0aGVyZSB3YXMg
YSBkZWxheSBiZWZvcmUgCnRoZSB0cmFuc3BvcnQgbWFya2VkIHRoZSBxdWV1ZSBsaXZlLiBJdCdz
IGNvbW1vbiBwcmFjdGljZSBpbiB0aGUgCnRyYW5zcG9ydHMgdG8gY2hhbmdlIHN0YXRlIHRoZW4g
c2NoZWR1bGUgYSB3b3JrIGVsZW1lbnQgdG8gcGVyZm9ybSB0aGUgCmFjdHVhbCBzdGF0ZSBjaGFu
Z2UuwqAgV2h5IHdvdWxkIHlvdSB3YW50IGlvIHRvIGNvbnRpbnVlIHRvIGZsb3cgZHVyaW5nIAp0
aGF0IHdpbmRvdyA/wqDCoCBUaGlzIG1heSBicmluZyBvdXQgb3RoZXIgcHJvYmxlbXMgd2UndmUg
YXZvaWRlZCBpbiB0aGUgcGFzdC4KCi0tIGphbWVzCgoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52
bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LW52bWUK

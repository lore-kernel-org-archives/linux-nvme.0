Return-Path: <SRS0=+LKq=Z4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AECA5C43603
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2019 22:18:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D083206DB
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2019 22:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EZCnZwdF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D083206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8OfUhFEl9EvXmaHVQlRuR7kd/c99X5RFvUSN9/zuAMY=; b=EZCnZwdF57YAvQV9PPwzY5e4L
	F0BcfFpT4UY8yRCksf5VYLvoUvL1z/CsRWBYRKZeIR1SAZKQQbBacu9g2Bix4z+7Ck04l1ktwP1WE
	ceNgal4Qa1XTUTlGSFNwcVDkz0vsH9uh2BArR8J/bTxMM45ejDNYePkMI+n/gyaWrMlTutKZk5IUV
	DF3CZJbZI1QfPpLm6P3FtUh8iQTLkPpwF71zMM7BheB58TwOcvpSMoAIY4+aJcJygFvHz4u1aimUk
	l9V5vCATCn7yycwcdqwNsjCkkigf2us06tVl2VzfTegd4FPqMDlU5Jm9paeRtQudB/ccOHUJnDz5H
	mitHVi9DQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1idLw6-0003OE-Ek; Fri, 06 Dec 2019 22:18:54 +0000
Received: from mail-oi1-f195.google.com ([209.85.167.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1idLw2-0003Nm-20
 for linux-nvme@lists.infradead.org; Fri, 06 Dec 2019 22:18:52 +0000
Received: by mail-oi1-f195.google.com with SMTP id x195so1229123oix.4
 for <linux-nvme@lists.infradead.org>; Fri, 06 Dec 2019 14:18:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d9S4wc95PA/qJ4pNkgEGjdRz20aLMnsLrWheBTxVnKA=;
 b=r0ywDJdhcAxVlgb/ifPu+VWDKc0FhfBKg+tK5OA4EpnvWR1KDQ8Kwt+NntWz0S71ld
 YKLD3q0DkEkNctWF4nmN3mERex7tQCiwP6eMs0QjbP/nFdJ26dXPbGkPmsmxjpFHDe2w
 T9s2XoMY6jOSR1eLZYhhOtpNF4+hJdwyoc8hqL92exOQ/xdjl04q4VIPLQg7SZERdZg7
 PzYNE1Hpi0nblRBcPrIj1pC33jDntba12LjrujymPsspeNZHUXFyt++9e9IsEVepXg9+
 u68lRy6jA7+Q6lesZiJGX2eYBg/ZdvxBVutwcQLXfdUG/dzZLJl8s1PNx9zZLhmxfm8+
 IKRg==
X-Gm-Message-State: APjAAAV+i0nUZrV29HH2z0Et8dXMJmHWsW2CQEM6ZKrddcT4ipAdx4/a
 Bl/xIqYV3Zd7qJ2PLj65RxZ3deub
X-Google-Smtp-Source: APXvYqzfjxV3Md87Scjcgw6gXe7aO1zZwnVLlGfh/A16p9PrA+YZ+lxWmo4SO2BH29sxRFosOZonsg==
X-Received: by 2002:a54:440f:: with SMTP id k15mr10858963oiw.71.1575670728361; 
 Fri, 06 Dec 2019 14:18:48 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id j1sm5352586oii.2.2019.12.06.14.18.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 06 Dec 2019 14:18:47 -0800 (PST)
Subject: Re: [PATCH] nvme-fabrics: reject I/O to offline device
To: James Smart <james.smart@broadcom.com>,
 Victor Gladkov <Victor.Gladkov@kioxia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <2caa40133c444771b706406b928ad88a@kioxia.com>
 <78d980de-b2b8-bd47-fc3f-20314653598e@broadcom.com>
 <c625b332ee124b038da1ae59b02f4e21@kioxia.com>
 <9a73a895-7d6b-21e9-9008-816117be1ff4@broadcom.com>
 <ac9b5d7192fb49ac9bdf19dd35be0ab2@kioxia.com>
 <4963e813-0d99-4890-804a-cd4c9c660607@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ae027c0c-45ab-d412-11f3-39dcf3217434@grimberg.me>
Date: Fri, 6 Dec 2019 14:18:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <4963e813-0d99-4890-804a-cd4c9c660607@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191206_141850_098494_798FFACE 
X-CRM114-Status: GOOD (  15.87  )
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+IC0tLQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvZmFicmljcy5jIGIvZHJp
dmVycy9udm1lL2hvc3QvZmFicmljcy5jCj4+IGluZGV4IDc0Yjg4MTguLmI1OGFiYzEgMTAwNjQ0
Cj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L2ZhYnJpY3MuYwo+PiArKysgYi9kcml2ZXJzL252
bWUvaG9zdC9mYWJyaWNzLmMKPj4gQEAgLTU0OSw2ICs1NDksOCBAQCBibGtfc3RhdHVzX3QgbnZt
Zl9mYWlsX25vbnJlYWR5X2NvbW1hbmQoc3RydWN0IAo+PiBudm1lX2N0cmwgKmN0cmwsCj4+IMKg
IHsKPj4gwqDCoMKgwqDCoMKgwqDCoCBpZiAoY3RybC0+c3RhdGUgIT0gTlZNRV9DVFJMX0RFTEVU
SU5HICYmCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjdHJsLT5zdGF0ZSAhPSBOVk1FX0NU
UkxfREVBRCAmJgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqAgIShjdHJsLT5zdGF0ZSA9PSBOVk1F
X0NUUkxfQ09OTkVDVElORyAmJgo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoKGt0aW1lX2dl
dF9ucygpIC0gcnEtPnN0YXJ0X3RpbWVfbnMpID4gCj4+IGppZmZpZXNfdG9fbnNlY3MocnEtPnRp
bWVvdXQpKSkgJiYKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICFibGtfbm9yZXRyeV9yZXF1
ZXN0KHJxKSAmJiAhKHJxLT5jbWRfZmxhZ3MgJiAKPj4gUkVRX05WTUVfTVBBVEgpKQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gQkxLX1NUU19SRVNPVVJDRTsKPj4K
PiAKPiBEaWQgeW91IHRlc3QgdGhpcyB0byBlbnN1cmUgaXQncyBkb2luZyB3aGF0IHlvdSBleHBl
Y3QuIEknbSBub3Qgc3VyZSAKPiB0aGF0IGFsbCB0aGUgdGltZXJzIGFyZSBzZXQgcmlnaHQgYXQg
dGhpcyBwb2ludC4gTW9zdCBJL08ncyB0aW1lb3V0IGZyb20gCj4gYSBkZWFkbGluZSB0aW1lIHN0
YW1wZWQgYXQgYmxrX21xX3N0YXJ0X3JlcXVlc3QoKS4gQnV0IHRoYXQgcm91dGluZSBpcyAKPiBh
Y3R1YWxseSBjYWxsZWQgYnkgdGhlIHRyYW5zcG9ydHMgcG9zdCB0aGUgCj4gbnZtZl9jaGVja19y
ZWFkeS9mYWlsX25vbnJlYWR5IGNhbGxzLsKgIEUuZy4gdGhlIGlvIGlzIG5vdCB5ZXQgaW4gZmxp
Z2h0LCAKPiB0aHVzIHF1ZXVlZCwgYW5kIHRoZSBibGstbXEgaW50ZXJuYWwgcXVldWluZyBkb2Vz
bid0IGNvdW50IGFnYWluc3QgdGhlIAo+IGlvIHRpbWVvdXQuwqAgSSBjYW4ndCBzZWUgYW55dGhp
bmcgdGhhdCBndWFyYW50ZWVzIHN0YXJ0X3RpbWVfbnMgaXMgc2V0LgoKSSdtIG5vdCBzdXJlIHRo
aXMgYmVoYXZpb3IgZm9yIGZhaWxpbmcgSS9PIGFsd2F5cyBkZXNpcmVkPyBzb21lCmNvbnN1bWVy
cyB3b3VsZCBhY3R1YWxseSBub3Qgd2FudCB0aGUgSS9PIHRvIGZhaWwgcHJlbWF0dXJlbHkgaWYg
d2UKYXJlIG5vdCBtdWx0aXBhdGhpbmcuLi4KCkkgdGhpbmsgd2UgbmVlZCBhIGZhaWxfZmFzdF90
bW8gc2V0IGluIHdoZW4gZXN0YWJsaXNoaW5nIHRoZSBjb250cm9sbGVyCnRvIGdldCBpdCByaWdo
dC4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LW52bWUgbWFpbGluZyBsaXN0CmxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

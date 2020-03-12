Return-Path: <SRS0=qcAl=45=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B824C10DCE
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 23:08:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5096D206F1
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 23:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SD+/TVuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5096D206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=F5zt/P1VRDLg0TC4CUpwiEfCHkZUzz7GnDidxoBll5A=; b=SD+/TVuEZaL8O4wka99HghVBc
	l51hsO9g390sohghnzXq/G4j2JAYhtjWDqa5i5lB73Kk7ViWoeWdkdVG2+aRBEZVlkZ6R6AFiIeR8
	aeblvtnr/5uqP5695I3VO9atdTufdhJjRG6qepucDxSyoi2hfLZdCABEkL3CUNQvVgt5M66BPktX3
	au/oW181CqHSdsF1ozj8Wyc34QlF42r4xJma3tnEPMmZVZRVptjxB6P/53FdkV+0q+F1xAMDo3ZOV
	ylyGtfhF/8zU0bt3jrCUAAUt7P9vYUx0pbfSZ+DpUxRsh02w2ofFrBW+zTIB5Oes/OYgkf9u+AlNn
	5n+MrAKrQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCWw1-00045Z-5s; Thu, 12 Mar 2020 23:08:13 +0000
Received: from mail-ot1-f68.google.com ([209.85.210.68])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCWvy-00043h-PP
 for linux-nvme@lists.infradead.org; Thu, 12 Mar 2020 23:08:12 +0000
Received: by mail-ot1-f68.google.com with SMTP id k26so8207978otr.2
 for <linux-nvme@lists.infradead.org>; Thu, 12 Mar 2020 16:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WeX381BZpregBj14QALK63gJZDp2asZwver5eMaJudk=;
 b=h5JhhPBG4bs6Fm1+o+dThqWskiMA3FhHYUg3TiC2P7vWOFN8odztFxaA+IpB4KWobi
 MM2X3WrVwJWkHDuvRbi6oF0urfgF4GawrhVWDUyyDxXzWCU84QwpzmvijXsi3c17eS0E
 Gq+/WOL93UZbeGt0/3qcUxeqdyLISp5U22yg9mySAWkbJShr/gXDb5Zd9tVuJ4CVR36q
 RrVgMzCyP6Ncmkmjjrxpn2pTSqODtIrwdG6HGOb4iLwdYISpZJlZrWeCYZoklvYEd0Lt
 7n9Qn0eyLhjsgKGd1BBo0FkB9dDxXnqtyj5/K8mDJB/jSzBHEQBqpwSgzY5Z44U6aiVc
 s64w==
X-Gm-Message-State: ANhLgQ3SvGMmLeReLzBveH7bGm4OrbTYFwTd4S69aFvoZKNsgR/2Dv5A
 lf2K3guwhCBCZ6uVxkyqJ6JF6pQn
X-Google-Smtp-Source: ADFU+vtb9omAZlqTnfSCeU4kj4gF1NtwTftrHhUg3bIYuQDwgnoYrnxUfGBL+cSnmBfmu8zPdSW4EQ==
X-Received: by 2002:a05:6830:1f54:: with SMTP id
 u20mr2115256oth.322.1584054489670; 
 Thu, 12 Mar 2020 16:08:09 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:c47a:8519:9343:83b8?
 ([2600:1700:65a0:78e0:c47a:8519:9343:83b8])
 by smtp.gmail.com with ESMTPSA id z25sm1699308oti.56.2020.03.12.16.08.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Mar 2020 16:08:09 -0700 (PDT)
Subject: Re: [PATCH 1/4] nvme-rdma: Fix warning at nvme_rdma_setup_ctrl
To: Israel Rukshin <israelr@mellanox.com>,
 Linux-nvme <linux-nvme@lists.infradead.org>, Christoph Hellwig <hch@lst.de>
References: <1583938849-5787-1-git-send-email-israelr@mellanox.com>
 <1583938849-5787-2-git-send-email-israelr@mellanox.com>
 <974e3bd2-3282-5703-eba6-bc2675c98c8e@grimberg.me>
 <e15f12ab-bf40-423d-956a-199897a5b3f5@mellanox.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <328e8c24-aadd-1a3a-0523-15dc352bd8ec@grimberg.me>
Date: Thu, 12 Mar 2020 16:08:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e15f12ab-bf40-423d-956a-199897a5b3f5@mellanox.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200312_160810_824982_F31E2150 
X-CRM114-Status: GOOD (  15.25  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jIGIvZHJpdmVycy9udm1l
L2hvc3QvcmRtYS5jCj4+PiBpbmRleCBkNjAyMmZhLi41N2Y5MDMxIDEwMDY0NAo+Pj4gLS0tIGEv
ZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jCj4+PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC9yZG1h
LmMKPj4+IEBAIC0xMDg0LDggKzEwODQsMTIgQEAgc3RhdGljIGludCBudm1lX3JkbWFfc2V0dXBf
Y3RybChzdHJ1Y3QgCj4+PiBudm1lX3JkbWFfY3RybCAqY3RybCwgYm9vbCBuZXcpCj4+PiDCoCDC
oMKgwqDCoMKgIGNoYW5nZWQgPSBudm1lX2NoYW5nZV9jdHJsX3N0YXRlKCZjdHJsLT5jdHJsLCBO
Vk1FX0NUUkxfTElWRSk7Cj4+PiDCoMKgwqDCoMKgIGlmICghY2hhbmdlZCkgewo+Pj4gLcKgwqDC
oMKgwqDCoMKgIC8qIHN0YXRlIGNoYW5nZSBmYWlsdXJlIGlzIG9rIGlmIHdlJ3JlIGluIERFTEVU
SU5HIHN0YXRlICovCj4+PiAtwqDCoMKgwqDCoMKgwqAgV0FSTl9PTl9PTkNFKGN0cmwtPmN0cmwu
c3RhdGUgIT0gTlZNRV9DVFJMX0RFTEVUSU5HKTsKPj4+ICvCoMKgwqDCoMKgwqDCoCAvKgo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqAgKiBzdGF0ZSBjaGFuZ2UgZmFpbHVyZSBpcyBvayBpZiB3ZSdyZSBp
biBERUxFVElORyBzdGF0ZSwKPj4+ICvCoMKgwqDCoMKgwqDCoMKgICogdW5sZXNzIHdlJ3JlIGR1
cmluZyBjcmVhdGlvbiBvZiBhIG5ldyBjb250cm9sbGVyIHRvCj4+PiArwqDCoMKgwqDCoMKgwqDC
oCAqIGF2b2lkIHVzZSBhZnRlciBmcmVlIChjdHJsIHJlZmNvdW50IGlzIG5vdCB0YWtlbiB5ZXQp
Lgo+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKi8KPj4+ICvCoMKgwqDCoMKgwqDCoCBXQVJOX09OX09O
Q0UoY3RybC0+Y3RybC5zdGF0ZSAhPSBOVk1FX0NUUkxfREVMRVRJTkcgfHwgbmV3KTsKPj4KPj4g
V2hhdCBzdGF0ZSBhcmUgd2UgaW4gaWYgbm90IERFTEVUSU5HIGluIHRoaXMgY2FzZT8KPiAKPiBX
ZSBhcmUgaW4gREVMRVRJTkcgc3RhdGUuCj4gCj4gV2l0aCB0aGlzIGNoYW5nZSBhbnkgc3RhdGUg
ZmFpbHVyZSB0cmlnZ2VycyBhIHdhcm5pbmcgKGluY2x1ZGluZyAKPiBERUxFVElORykgaWYgbmV3
IGlzIHRydWUuCj4gCj4gSW4gbXkgdGVzdCBJIHdhcyBpbiBERUxFVElORyBzdGF0ZSBhbmQgd2l0
aCBuZXcgPT0gdHJ1ZQo+IAo+IFRyeWluZyB0byBjaGFuZ2Ugc3RhdGUgZnJvbSBERUxFVElORyB0
byBMSVZFIGlzIG5vdCBhbGxvd2VkIGF0IHRoZSBzdGF0ZSAKPiBtYWNoaW5lLgoKV2h5IGRvIHdl
IG5lZWQgYSB3YXJuaW5nIG9uIHRoYXQ/CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC1udm1lIG1haWxpbmcgbGlzdApsaW51eC1udm1lQGxpc3Rz
LmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1udm1lCg==

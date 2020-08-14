Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679DFC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 23:30:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32BA82068E
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 23:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="b3QSSNfl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I2sDUZ/S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BA82068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=fm0KGHJ6r4nO9NSa8Z+LvrAVagh753JqpCCwI9Kq9M8=; b=b3QSSNflKLRFQP1iXZ1D+lPNf
	jXOkD0t1b2mXM+U8367TwnBHnC/GYpI5pzKDFklurcNeYpY38i8Rdp7JWzojTz/arluj+3wH4QMJ/
	oarDFfqs+rpOTPNX364LyiWevcxrHnFZJs71HpRBat3DT1+NLNDfi3N5BBZ2MuJfuRvUYWf9zWYNE
	MyERtGhwrvElownKRNPUgUa2MjSsi+A0BZn58vC1eVsd6+7kUvvH7NcYO55zCWxxPcLDFKIidPu5w
	Ac2amxs8d5asevsJ7UMpiiwUSairojL9IISbNpQNX/ZCSW/9ekwm2jS2G2hdvdD3U1rJLf9ULKnxV
	lgGqfRXTQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6j9v-0006wo-LP; Fri, 14 Aug 2020 23:30:51 +0000
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6j9s-0006wM-U3
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 23:30:49 +0000
Received: by mail-qt1-x841.google.com with SMTP id t23so8233518qto.3
 for <linux-nvme@lists.infradead.org>; Fri, 14 Aug 2020 16:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=subject:from:to:references:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=9EbhNETF/t7meucG6gWb62otw84cQoVucMGKjJPktBY=;
 b=I2sDUZ/SYD7DSAKl5eEA/r/NS6HYMYwjhj4nnneosJzuDCuFHCatp3EnwttVYyBAiP
 7MwbsnxgmSPyAuH3KhtwpP30qUkb9JXUNvgpVY1fDs8PIf32Tzc0lPXLn037rZBCowGF
 pgaaXwbgPksWB0qmFbuLRow0+uY1J+PYtOZ+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=9EbhNETF/t7meucG6gWb62otw84cQoVucMGKjJPktBY=;
 b=OeFQ4uyARD6EjwW8kBCGXQ6G9SZxFNHLMWaSoSsnvER9thhAJq6uTDP2aaFoEar0ie
 oE9uktWcCj/gU6xhWijyZEj65IWyDl6HVC32a3QmKKaziAnj/phDKmTACptgXunbYpVe
 wnpHhYIiNS6LquOntIvnGQ2eEQZ1iWlQIr17sqzdF11m6zObzCL4wBur+5C6mBlZpsxh
 m6FTheG+mXPb/DAYVrRxWIM/yDjZKQcC8xBkoKCXd2egSKe2pIxCXiI6UGCnDbZapdaM
 rSa9W6HIsVdjpQkuzZBu367ME4aoSZ7CpDDBywYg1Py/uYstgx4FZpJIKAPlsyCuIxCI
 douA==
X-Gm-Message-State: AOAM533cXg6ENMzFwyrXH/18qfJL64OzskKujZsxtwF/efmdpZsAn9sx
 2L6xblrfLyFuwpH3m4s4pBxtcylJOra1Rw==
X-Google-Smtp-Source: ABdhPJxjasEhxbcjpDbcKGDQ09V1F7bjZWyXHzL9ZZBgzwb/OvradJHq5f9iqsRIqVGzMzJe0UGOZA==
X-Received: by 2002:ac8:3971:: with SMTP id t46mr4263824qtb.14.1597447847312; 
 Fri, 14 Aug 2020 16:30:47 -0700 (PDT)
Received: from [10.230.26.209] ([192.19.224.250])
 by smtp.gmail.com with ESMTPSA id c5sm11108360qtp.62.2020.08.14.16.30.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 16:30:46 -0700 (PDT)
Subject: Re: [PATCH v2 7/8] nvme-rdma: fix timeout handler
From: James Smart <james.smart@broadcom.com>
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200806191127.592062-1-sagi@grimberg.me>
 <20200806191127.592062-8-sagi@grimberg.me>
 <37c1a34b-9956-b9b6-8e06-f44c99470a73@broadcom.com>
Message-ID: <edaacba9-fe97-a91c-3795-7542861c3335@broadcom.com>
Date: Fri, 14 Aug 2020 16:30:43 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <37c1a34b-9956-b9b6-8e06-f44c99470a73@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_193049_007244_7FD2E6AA 
X-CRM114-Status: GOOD (  16.57  )
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

CgpPbiA4LzE0LzIwMjAgNDoyNyBQTSwgSmFtZXMgU21hcnQgd3JvdGU6Cj4KPgo+IE9uIDgvNi8y
MDIwIDEyOjExIFBNLCBTYWdpIEdyaW1iZXJnIHdyb3RlOgo+PiBDdXJyZW50bHkgd2UgY2hlY2sg
aWYgdGhlIGNvbnRyb2xsZXIgc3RhdGUgIT0gTElWRSwgYW5kCj4+IHdlIGRpcmVjdGx5IGZhaWwg
dGhlIGNvbW1hbmQgdW5kZXIgdGhlIGFzc3VtcHRpb24gdGhhdCB0aGlzCj4+IGlzIHRoZSBjb25u
ZWN0IGNvbW1hbmQgb3IgYW4gYWRtaW4gY29tbWFuZCB3aXRoaW4gdGhlCj4+IGNvbnRyb2xsZXIg
aW5pdGlhbGl6YXRpb24gc2VxdWVuY2UuCj4+Cj4+IFRoaXMgaXMgd3JvbmcsIHdlIG5lZWQgdG8g
Y2hlY2sgaWYgdGhlIHJlcXVlc3Qgcmlza2luZwo+PiBjb250cm9sbGVyIHNldHVwL3RlYXJkb3du
IGJsb2NraW5nIGlmIG5vdCBjb21wbGV0ZWQgYW5kCj4+IG9ubHkgdGhlbiBmYWlsLgo+Pgo+PiBU
aGUgbG9naWMgc2hvdWxkIGJlOgo+PiAtIFJFU0VUVElORywgb25seSBmYWlsIGZhYnJpY3MvYWRt
aW4gY29tbWFuZHMgb3RoZXJ3aXNlCj4+IMKgwqAgY29udHJvbGxlciB0ZWFyZG93biB3aWxsIGJs
b2NrLiBvdGhlcndpc2UgcmVzZXQgdGhlIHRpbWVyCj4+IMKgwqAgYW5kIGNvbWUgYmFjayBhZ2Fp
bi4KPj4gLSBDT05ORUNUSU5HLCBpZiB0aGlzIGlzIGEgY29ubmVjdCAob3IgYW4gYWRtaW4gY29t
bWFuZCksIHdlIGZhaWwKPj4gwqDCoCByaWdodCBhd2F5ICh1bmJsb2NrIGNvbnRyb2xsZXIgaW5p
dGlhbGl6YXRpb24pLCBvdGhlcndpc2Ugd2UKPj4gwqDCoCB0cmVhdCBpdCBsaWtlIGFueXRoaW5n
IGVsc2UuCj4+IC0gb3RoZXJ3aXNlIHRyaWdnZXIgZXJyb3IgcmVjb3ZlcnkgYW5kIHJlc2V0IHRo
ZSB0aW1lciAodGhlCj4+IMKgwqAgZXJyb3IgaGFuZGxlciB3aWxsIHRha2UgY2FyZSBvZiBjb21w
bGV0aW5nL2RlbGF5aW5nIGl0KS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogU2FnaSBHcmltYmVyZyA8
c2FnaUBncmltYmVyZy5tZT4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvbnZtZS9ob3N0L3JkbWEuYyB8
IDY4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0KPj4gwqAgMSBmaWxl
IGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKyksIDE4IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5jIGIvZHJpdmVycy9udm1lL2hvc3QvcmRtYS5j
Cj4+IGluZGV4IGFiYzMxODczN2YzNS4uMzBiNDAxZmNjMDZhIDEwMDY0NAoKTm90ZTogRkMgaGFz
IHRvIGRvIHRoaXMgYSBsaXR0bGUgZGlmZmVyZW50bHkuIEZyb20gd2hhdCBJIGNhbiB0ZWxsLCAK
dGhlcmUncyBubyBjcm9zcy1vdmVycyBpbiB5b3VyIHBhdGNoZXMgdnMgbWluZSwgc28gbm8gbmVl
ZCB0byB3YWl0IGZvciAKRkMgcGF0Y2hlcyB0byBtYXJyeSB3aXRoIHRoZW0uCgotLSBqYW1lcwoK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52
bWUgbWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

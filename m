Return-Path: <SRS0=47LT=HA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E316C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:35:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57F464DF1
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Jan 2021 01:35:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57F464DF1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=W1zy5NUNy/JyDxMIzu+n+6gmWmgjqomdsJIm594E2Ds=; b=lhjXR18uPdThPOnd0lUyC7uIw
	A5PUB8/DIz2HLnYJxJea4jZ4t3G+MrEWl1rB7gZG9fYtdrBHG/XNmnFZ5uVKcXESNMXTF9zpGamW0
	brMt+bBKzR3Etzo9pncV3vgJ2kskCEhOHPJvJif9/TCLQ4Tw2RJUmpaoBKJFXu/EHxMoff2toFTNy
	9rZlaMKIriv+X1kbaEBkgZ8KKk1Gw0P5vPYsDkbGTMvxdwf5BAznBx9ZZ/gvewkqnXK/yAikGRWSJ
	3L56Q0L0vGKxl5wuGAI116Zq+jik8McCyV5i/afrWTtbe7aAce59+9xWHbu07UYTn7mTQ8yksL1/1
	9fV//d7qQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l5IhR-00014h-AP; Fri, 29 Jan 2021 01:35:49 +0000
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l5IhO-00014H-L9
 for linux-nvme@lists.infradead.org; Fri, 29 Jan 2021 01:35:47 +0000
Received: by mail-wr1-f45.google.com with SMTP id q7so7245499wre.13
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 17:35:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xCjG12+ISZQS2TVMmwKooqoDXwGno5KAZlsJxtlGsPw=;
 b=FIXZhkUjqdcC5+lUc/rLOToJ1smR0sRLOG6ognQEay0sswSqVPCz6bMa6lqdKLLcuK
 TNbc+VVfGwMyyb6ysTse3+uDEn2a2quiUAWHsw2oXxP/pASwzUUHfNoejv1fqVHs9r8Z
 DGs9LoYcwXvjbhZpMTCIRICmRG1SVlVhmtDfY2nO993Qg2RqxeVE+qN/7rI/FEMKueCo
 N/X1Z116BEAjntABfGbYOAo9/8YPHNhMJaSlQb44lxPBuMZbrYn9n6qHc366P/RK694O
 B3bgHyLluY18QEq+K64mAibMVGGTl1t3RCuTMw/9KEaOI1km4Dc5DcU/YlZ2pNenM5XN
 cLtw==
X-Gm-Message-State: AOAM531fqsSgyiYKsO5yeHdRmhoMCI1gXuGFZCNNbPTBJj2MIvA4ydaI
 OzwTpJ/4O4744xrxu+CUZKk=
X-Google-Smtp-Source: ABdhPJwcwTDlDxKtnqDUvi1/9DN3EVExRSNov3nX2OV93vX+Bt0jcOjNCdFtwI3XzHVphEILFRVK3Q==
X-Received: by 2002:a5d:6685:: with SMTP id l5mr1828528wru.176.1611884145218; 
 Thu, 28 Jan 2021 17:35:45 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:3d48:4849:d506:e578?
 ([2601:647:4802:9070:3d48:4849:d506:e578])
 by smtp.gmail.com with ESMTPSA id f17sm10021308wrv.0.2021.01.28.17.35.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Jan 2021 17:35:44 -0800 (PST)
Subject: Re: [PATCH v4 4/5] nvme-rdma: avoid IO error for nvme native multipath
To: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org
References: <20210126081539.13320-1-lengchao@huawei.com>
 <20210126081539.13320-5-lengchao@huawei.com>
 <5a368693-65fd-1bdf-924a-f90df7f59b2a@grimberg.me>
 <9c30b18a-6fdd-be1c-f3bc-1d44c35ae274@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ca300cac-1f6c-01b2-8691-9a545381523a@grimberg.me>
Date: Thu, 28 Jan 2021 17:35:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9c30b18a-6fdd-be1c-f3bc-1d44c35ae274@huawei.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_203546_853520_D5263F11 
X-CRM114-Status: GOOD (  15.31  )
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
Cc: kbusch@kernel.org, axboe@fb.com, linux-block@vger.kernel.org, hch@lst.de,
 axboe@kernel.dk
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiBAQCAtMjA4NCw4ICsyMDg1LDEwIEBAIHN0YXRpYyBibGtfc3RhdHVzX3QgbnZtZV9yZG1h
X3F1ZXVlX3JxKHN0cnVjdCAKPj4+IGJsa19tcV9od19jdHggKmhjdHgsCj4+PiDCoMKgwqDCoMKg
IGVyciA9IG52bWVfcmRtYV9wb3N0X3NlbmQocXVldWUsIHNxZSwgcmVxLT5zZ2UsIHJlcS0+bnVt
X3NnZSwKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlcS0+bXIgPyAmcmVxLT5yZWdf
d3Iud3IgOiBOVUxMKTsKPj4+IC3CoMKgwqAgaWYgKHVubGlrZWx5KGVycikpCj4+PiArwqDCoMKg
IGlmICh1bmxpa2VseShlcnIpKSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAgZHJpdmVyX2Vycm9yID0g
dHJ1ZTsKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGVycl91bm1hcDsKPj4KPj4gV2h5IG5v
dCBqdXN0IGNhbGwgc2V0IHRoZSBzdGF0dXMgYW5kIGNhbGwgbnZtZV9yZG1hX2NvbXBsZXRlX3Jx
IGFuZAo+PiByZXR1cm4gaGVyZT8KPiBJZiB0aGUgZXJyIGlzIEVOT01FTSBvciBFQUdBSU4sIEkg
YW0gbm90IHN1cmUgdGhlIGVyciBtdXN0IGJlIGEKPiBwYXRoLXJlbGF0ZWQgZXJyb3IgZm9yIGFs
bCBIQkEgZHJpdmVycy4gU28gcmV1c2VkIHRoZSBlcnJvciBjaGVjayBjb2RlLgo+IEkgdGhpbmsg
aXQgd291bGQgYmUgbW9yZSByZWFzb25hYmxlIHRvIGFzc3VtZSBhbnkgZXJyb3JzIHJldHVybmVk
IGJ5IEhCQQo+IGRyaXZlciBhcyBwYXRoLXJlbGF0ZWQgZXJyb3JzLgo+IElmIHlvdSB0aGluayBz
bywgSSB3aWxsIG1vZGlmeSBpdCBpbiBuZXh0IHBhdGNoIHZlcnNpb24uCgpNZWFudCB0byBkbyB0
aGF0IG9ubHkgZm9yIC1FSU8uIFdlIHNob3VsZCBhYnNvbHV0ZWx5IG5vdCBkbyBhbnkgb2YgdGhp
cwpmb3Igc3R1ZmYgbGlrZSBFSU5WQUwsIEVPUE5PVFNVUFAsIEVQRVJNIG9yIGFueSBzdHJhbmdl
IGVycm9yIHRoYXQgbWF5CnJldHVybiBkdWUgdG8gYSBidWcgb3IgYW55dGhpbmcgbGlrZSB0aGF0
LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

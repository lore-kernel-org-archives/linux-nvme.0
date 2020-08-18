Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98488C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 20:58:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C36C2063A
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 20:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CsaU1AkJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C36C2063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IN2Ol7khNfch2rBU9nB3gY5kwGyNYCDUusWT5ZVH+C4=; b=CsaU1AkJnrhV9SerSaOfxxGkg
	t9xfbb4CorLhbK1NO71gsu2uuO6NDiEigrABxQT67iTHp46G2X11oltgDUJ3hY6i/Sh7bLzP0/Mk7
	EIjmI978VsIIuR9OCqc0dMuU0WpLC59Bay+kj6jjSHtoOrPrgQX0dUgorLTndMpKxxbWIRqvFVZsO
	a7DZRaUfHUUJC4/B4KRwIcyEduk0gJD2c/23R1ev5OobIGCYZITSkzS12XtQFMZ8DgF71FalF8Uow
	RlvEs/Jpfz3ZKFmUVHObANaIIzMmXodgUch1w5btbGCHCynvto/1WMlrMeMcx+udGf7yhhjm1zYeY
	7Hyw4Sleg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k88gw-0005yV-5c; Tue, 18 Aug 2020 20:58:46 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k88gt-0005y5-1x
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 20:58:43 +0000
Received: by mail-wr1-f67.google.com with SMTP id y3so19533767wrl.4
 for <linux-nvme@lists.infradead.org>; Tue, 18 Aug 2020 13:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P/vmd2yNpOTlDRADCDncjBYGWJrzWyafKM1/2+FBuak=;
 b=EYH+fZUl8J0MJQRCdtbvUoL+fkv4ODB5M51vWUOOXKo7Dr7m10rZ8Ox5E5RdYoaKYu
 F/7sIaFLcBp69Q3FpWmfKSEP4csCfmQ8xb1IOCSLi6jO8TzoyQRCOOSBZkyK/52lqKYm
 LF1bQKxfbPKvCMNWevPJ/t2B4LrLhXEpK331Xo11OInhfqDH6R9rWjwz3xiCBXIa1TCF
 IOC1xy9B/9PZdwpuXEjhNZNNhiJ597NJIIEPLsbFAOBDv/ai8mIKCJGn4HItj8ajqnbw
 RkUgWttQTaWAgd77jII2HMxVYOZRSSUxmRs9h6fqrkTNHfUtgL6c/xmA5FReNoTs6F6v
 HpOQ==
X-Gm-Message-State: AOAM5306esbECWeLwOC0aG/aX3c44JEJIIXiT8Vd69k0ItkfrZvFxmzu
 c2ALgWG2uaEQ4LtayC99tGViYMf9sfNNXw==
X-Google-Smtp-Source: ABdhPJzRPsLZUSduCQsutJyglwzL62S97o8TCg2k3+Cdqc9V0xJUwWvmWXNoXUoSlEpsLzEc13p1aA==
X-Received: by 2002:adf:9795:: with SMTP id s21mr21443676wrb.418.1597784321804; 
 Tue, 18 Aug 2020 13:58:41 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dce:63f2:5e83:391e?
 ([2601:647:4802:9070:3dce:63f2:5e83:391e])
 by smtp.gmail.com with ESMTPSA id c14sm35589182wrw.85.2020.08.18.13.58.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2020 13:58:41 -0700 (PDT)
Subject: Re: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>, amit.engel@dell.com
References: <20200818065114.57532-1-amit.engel@dell.com>
 <20200818162731.GC27196@lst.de>
 <0b3027b3-e4ef-3e45-9b92-babe09e34e6d@grimberg.me>
Message-ID: <cdb5a25d-ab1c-bd6f-2608-c51e169ad87a@grimberg.me>
Date: Tue, 18 Aug 2020 13:58:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0b3027b3-e4ef-3e45-9b92-babe09e34e6d@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_165843_097552_A43D3524 
X-CRM114-Status: GOOD (  15.37  )
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
Cc: linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+PiBXZSB3YW50IHRvIGF2b2lkIHN0YXJ0aW5nIHRoZSBrZWVwLWFsaXZlIHRpbWVyIHdpdGgg
YSB6ZXJvIHRpbWVvdXQgdmFsdWUKPj4KPj4gU28gbG9va2luZyBhdCB0aGUgc3BlYzoKPj4KPj4g
IlRoaXMgZmllbGQgc3BlY2lmaWVzIHRoZSB0aW1lb3V0IHZhbHVlIGZvciB0aGUgS2VlcCBBbGl2
ZSBmZWF0dXJlIGluCj4+IG1pbGxpc2Vjb25kcy4gVGhlIGNvbnRyb2xsZXIgcm91bmRzIHVwIHRo
ZSB2YWx1ZSBzcGVjaWZpZWQgdG8gdGhlIAo+PiBncmFudWxhcml0eQo+PiBpbmRpY2F0ZWQgaW4g
dGhlIEtBUwo+PiBmaWVsZCBpbiB0aGUgSWRlbnRpZnkgQ29udHJvbGxlciBkYXRhIHN0cnVjdHVy
ZS4gSWYgY2xlYXJlZCB0byAwaCwgCj4+IHRoZW4gdGhlCj4+IEtlZXAgQWxpdmUgVGltZXIgaXMg
ZGlzYWJsZWQuIgo+Pgo+PiB3ZSBzaG91bGQgbm90IGp1c3Qgc2V0IGEgcmFuZG9tIGhpZ2ggdGlt
ZW91dCBidXQganVzdCBkaXNhYmxlIHRoZQo+PiBrZWVwIGFsaXZlIGVudGlyZWx5Lgo+IAo+IEl0
IGlzIGFscmVhZHkgZGlzYWJsZWQsIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB0aGUgcGF0Y2g6Cj4g
Cj4gLS0gCj4gc3RhdGljIHZvaWQgbnZtZV9zdGFydF9rZWVwX2FsaXZlKHN0cnVjdCBudm1lX2N0
cmwgKmN0cmwpCj4gewo+ICDCoMKgwqDCoMKgwqDCoCBpZiAodW5saWtlbHkoY3RybC0+a2F0byA9
PSAwKSkKPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybjsKPiAKPiAgwqDC
oMKgwqDCoMKgwqAgcXVldWVfZGVsYXllZF93b3JrKG52bWVfd3EsICZjdHJsLT5rYV93b3JrLCBj
dHJsLT5rYXRvICogSFopOwo+IH0KPiAtLSAKCkp1c3Qgbm90aWNlZCBpdHMgbnZtZXQuCgpXZSBu
ZWVkIGFuIGVxdWl2YWxlbnQgcGF0Y2ggZm9yIG52bWV0LCB0aGF0J3MgYWxsCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcg
bGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

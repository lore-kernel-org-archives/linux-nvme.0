Return-Path: <SRS0=/Y//=CD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A94C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 17:35:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DEC2076C
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2020 17:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tl3H680J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DEC2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P/9UnuwuYtvx3cpW9ttXfJowja0QfToRk2kKZK1O+EQ=; b=tl3H680JL2zANmQMydTqi+skM
	gT49EOShXxlp1LXgD2JSh4NnNFo8fH8gUSAiQbsf2dFXG8XWTG/04ej8UM3+/wEP01erPjPluVhb5
	mrMTl3++MiqS5feoI5JARpYvTtpVD2+/AS6P0NKPvcNBMEa5/Er9qBtNzDn0hPBoqAjfrmUs7OBmm
	KcEBS7D20S2HGqoSw4AvwaMpHeh2RCL0E5oRnEMntFi4DxqQkTfVvis0MJUnEuh53SIYk524z4r7F
	dWwVXKCo5GeuBNwY/pNDuyQKF4xyAZnACzubXu7nIQOJN5yeLMQscee3b9nPDCLlz93vo6tx012z4
	WHP8VyJeQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kAcr4-0000cf-1T; Tue, 25 Aug 2020 17:35:30 +0000
Received: from mail-pj1-f66.google.com ([209.85.216.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kAcr1-0000c5-Bm
 for linux-nvme@lists.infradead.org; Tue, 25 Aug 2020 17:35:28 +0000
Received: by mail-pj1-f66.google.com with SMTP id q1so1597050pjd.1
 for <linux-nvme@lists.infradead.org>; Tue, 25 Aug 2020 10:35:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fJ/iiUHBBdk+DwGMtKWEsxeyD8XtuabcyZWglpOs6N0=;
 b=bKol+SpJkPsBmi745B2+5JBc2I8e3cpdcovm3GcvDCr+EdtgYOZQW1/4QRPY6Seeqv
 i/1EscJYqsN3ShiZ/Zn9R01+xEsUnOBdZJSHC2vOxtVVaOALUXWVdJ4X028syJTq8r4p
 IL34yNntAdwDKotuzKI6hrMwlksjwBLYXA6Bh/RUMbGJbki3qV+LOQOCL2o9zBF+UWTU
 VeFKbqS2b4+c7ag1jZwPuCzusSmntCqeqqh+gSx7lg+9H3LrBU0qoBS4kBOu+zJzAJox
 7Vckdodr0BDGYsQ4nVpCpOz3xWCou+WsNF2EzSTggOEwCl1mGjJywPS1+OviCWECaXtt
 /hKg==
X-Gm-Message-State: AOAM532PszD6qtC4tGpUaVfDWL07IBY3yCCkqnULQo0iTVdWHVEI3dmL
 WJuRk81oZG6F3zI/A9wwrssjVtxwaEtWOA==
X-Google-Smtp-Source: ABdhPJz6AqDOKi0rLVqKpORjWPInkcymiehTFHoIzJXDaq2tk2PaEPEto4hpzwSO2edkJb02b8+x2w==
X-Received: by 2002:a17:90a:e552:: with SMTP id
 ei18mr2349547pjb.233.1598376925770; 
 Tue, 25 Aug 2020 10:35:25 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:4c51:77cf:ef42:8603?
 ([2601:647:4802:9070:4c51:77cf:ef42:8603])
 by smtp.gmail.com with ESMTPSA id k20sm10978332pfu.197.2020.08.25.10.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2020 10:35:25 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
To: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me> <20200820060941.GB6188@lst.de>
 <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
 <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
 <20200821062217.GC28559@lst.de>
 <77e27c4e-f939-2c14-8e63-209197f1133c@grimberg.me>
 <20200825071345.GF29268@lst.de>
 <cf1a5428-2378-213a-7c7f-1fca81fda77e@grimberg.me>
 <128d9766-292f-1e6c-1c0f-3651b4863e6a@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9a1bd3fb-203b-8a33-76b9-cb373d02744d@grimberg.me>
Date: Tue, 25 Aug 2020 10:35:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <128d9766-292f-1e6c-1c0f-3651b4863e6a@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200825_133527_428067_0EDF3919 
X-CRM114-Status: GOOD (  16.78  )
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
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+Pj4gU28gd2UgZWl0aGVyIGtlZXAgdGhpcyBleGNlcHRpb24gZm9yIGFkbWluIGNvbW1hbmRz
LCBvciB3ZSBhbHNvIGxldAo+Pj4+IHRoZW0gdGhyb3VnaCBhcyBpdCBzZWVtcyB0byBiZSBzYWZl
IHdpdGggdGhlIGN1cnJlbnQgY29kZSAoZnJvbSB0aGUKPj4+PiByZXNldCBmb3J3YXJkLXByb2dy
ZXNzIHBlcnNwZWN0aXZlKS4KPj4+Pgo+Pj4+IEkgdm90ZSB0byByZW1vdmUgdGhpcyBleGNlcHRp
b24gYWx0b2dldGhlci4uLgo+Pj4KPj4+IFRvIG1lIHRoZSByaWdodCBhbnN3ZXIgd291bGQgYmUg
dG8gcmVqZWN0IHVzZXIgY29tbWFuZHMgb24gdGhlIGFkbWluCj4+PiBvciBJL08gcXVldWUgZm9y
IHRoZSBub3QgbGl2ZSBjb250cm9sbGVyIGFzIHRoZSBjYWxsZXJzIG5lZWQgdG8gaGFuZGxlCj4+
PiBpdC7CoCBUaGF0IHNlZW1zIHRvIG1ha2UgbW9yZSBzZW5zZSB0byBtZSB0aGFuIGEgc3BlY2lh
bCBhZG1pbiBxdWV1ZQo+Pj4gZXhjZXB0aW9uLgo+Pgo+PiBTbyB5b3Ugc2F5IHRoYXQgd2Ugc2hv
dWxkIG5ldmVyIHJldHVybiBCTEtfU1RTX1JFU09VUkNFIGJ1dCByYXRoZXIgZmFpbAo+PiBhbGwg
cmVxdWVzdHM/IHJlZ2FyZGxlc3MgZm9yIG11bHRpcGF0aCBvciBub3Q/Cj4gCj4gSG93IGFib3V0
IHdlIGtlZXAgdGhlIGV4Y2VwdGlvbiBmb3Igbm93LiBBcyBJIG1lbnRpb25lZCBlYXJsaWVyLCBJ
IGhhdmUgCj4gYW4gaW9jdGwgcmV0cnkgcGF0Y2ggY29taW5nIGZvciBudm1lLWNsaSBhbmQgaWYg
d2UgYWdyZWUgd2l0aCB3aGF0IGl0IAo+IGRvZXMgdGhlbiB3ZSBjYW4gcHV0IGluIHRoZSByZWpl
Y3QgYW5kIHJlbW92ZSB0aGUgZXhjZXB0aW9uLgoKSSBob25lc3RseSBkb24ndCB0aGluayB3ZSBz
aG91bGQgZmFpbCB1c2VyIEkvTyBjb21tYW5kcywgdGhlcmUgaXMgbm8KZm9yIHVzIHJlYXNvbiB0
byBkbyB0aGF0LgpJIGFsc28gZG9uJ3QgdGhpbmsgd2Ugc2hvdWxkIGZhaWwgdXNlciBhZG1pbiBj
b21tYW5kcyBlaXRoZXIsIGF0IGxlYXN0Cm5vdCBpbiBudm1mX2NoZWNrX3JlYWR5LgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWls
aW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZy
YWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

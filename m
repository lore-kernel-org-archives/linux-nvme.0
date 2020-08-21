Return-Path: <SRS0=kXjr=B7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDA9C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 19:48:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17C78208DB
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Aug 2020 19:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gK9A5ej5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17C78208DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=eGT4orUXXk6koTlXr8qutfXAGhqK+8pnMoGBvv9fZVA=; b=gK9A5ej5RtolWXmCY7uV5UH/j
	6dedhZH3NbLTZvugj+UTcqZFAzo/YMalTNa1xlC+7Krfjtil0846ZtudsLop2mX2SuhBZSTJxX7hr
	WaggIcINdantXeELL26MDw1uiAxw9soUAJ+35gjf48CN5HqSgBB1IBvmd/bYungjSNI7iu8gpvYJU
	nwb6pdZxrscm5Ke4M+kAOjvUAimidnbSnoeM8Qfh1sC76mKjyDiBB+Dtbs8UyOG9VPcAeB8Snck9b
	tyzclP30i4uz5ASIq822xZUBk/IUh20XQSubW3xsCVFY2JYr/mHUuGAQ2o9kuG743fxw9AdQA5Wsu
	UmMvPouvw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k9D1M-0000Cr-Sl; Fri, 21 Aug 2020 19:48:17 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k9CyB-0006jK-N5
 for linux-nvme@lists.infradead.org; Fri, 21 Aug 2020 19:45:00 +0000
Received: by mail-pf1-f195.google.com with SMTP id k18so1560429pfp.7
 for <linux-nvme@lists.infradead.org>; Fri, 21 Aug 2020 12:44:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hbyGXhadMJr/ebbLvafaG4SIgjoNTMk2HbcJKOh55KM=;
 b=CjBG3Vky5KtEyYUiTJaASLIPTgwAKqb+PVgFwEDutjS37Kutuy97ryKOLA8ZGewswe
 ElX9Wh8Kmu2JFQVh3ArRiPxRG6FxbbsGvJhF5vjWjpP6p8UwzZ77ohgRj6j+bxTXkdoV
 3ZgpLFdODPcaltiHEEOSb4kCxiMl010T1Lfmr6tntwPC+LQ74wpE5E5DIUDRbQd31Uq1
 aGoxDaSzWgqqEpIwM6Cw4y7FjzWVKo5BpIvxZh+CzKxcBKByheLLq7jrUSWTzdlqjvTH
 nLMDaWfkGG3sVrzmPm+3BWaz4Fln0q+pWyjMuVdCGHf27n8k7bWRejGJ43DWAK2zCDPC
 Abtw==
X-Gm-Message-State: AOAM531lynRdTykcdZamE/Pt0rGEV8NutnudLDguRpSCbBxPtw6FnVN9
 bVCyI9VyQSFY8o/iVZVWT7ADIdLngD3sDQ==
X-Google-Smtp-Source: ABdhPJwGl4lqzsXjBF/2/m3/wvaK8nXmIIhMZYPlUao36Z6433NmGBV1Pdu3D/zIGRtUd35aAG3Tkg==
X-Received: by 2002:a62:1b81:: with SMTP id b123mr3664891pfb.149.1598039098265; 
 Fri, 21 Aug 2020 12:44:58 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:95a5:8a0f:6e94:b712?
 ([2601:647:4802:9070:95a5:8a0f:6e94:b712])
 by smtp.gmail.com with ESMTPSA id w82sm3470013pff.7.2020.08.21.12.44.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 12:44:57 -0700 (PDT)
Subject: Re: [PATCH v3 2/9] nvme-fabrics: allow to queue requests for live
 queues
To: Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-3-sagi@grimberg.me> <20200820060941.GB6188@lst.de>
 <813bbd6c-3353-2c40-da48-bdbbdf89690c@grimberg.me>
 <bdd4f4b8-be68-2edc-5378-32c97eb3f1ae@broadcom.com>
 <20200821062217.GC28559@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <43d6ca66-0a42-0aff-ef22-8b3c08cf3bde@grimberg.me>
Date: Fri, 21 Aug 2020 12:44:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821062217.GC28559@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200821_154459_836261_8B416119 
X-CRM114-Status: GOOD (  17.89  )
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

Cj4+IEkgc3RpbGwgZGlzbGlrZSBhbnkgcmFuZG9tIGlvY3RscyBjb21pbmcgaW4gd2hpbGUgd2Un
cmUgc3RpbGwgaW5pdGlhbGl6aW5nCj4+IHRoZSBjb250cm9sbGVyLgo+IAo+IEFncmVlZC4KPiAK
Pj4gIMKgIExvb2tpbmcgYXQgdGhlIGZsb3cgLSBJIHdvdWxkbid0IHdhbnQgdGhlbSB0byBiZSBh
bGxvd2VkCj4+IHVudGlsIGFmdGVyIG52bWVfaW5pdF9pZGVudGlmeSgpIGlzIGNvbXBsZXRlLiBF
c3BlY2lhbGx5IGlmIHRoZSBpb2N0bHMgYXJlCj4+IGRvaW5nIHN1YnN5c3RlbSBvciBjb250cm9s
bGVyIGR1bXBpbmcgb3IgdXNpbmcgY29tbWFuZHMgdGhhdCBzaG91bGQgYmUKPj4gY2FwcGVkIGJ5
IHZhbHVlcyBzZXQgYnkgbnZtZV9xdWV1ZV9saW1pdHMoKS7CoMKgIEJ1dCwgaWYgd2UncmUgZ29p
bmcgdG8KPj4gYWxsb3cgbnZtZV9pbml0X2lkZW50aWZ5IHRoZSBhZG1pbl9xIG5lZWRzIHRvIGJl
IHVucXVpZXNjZWQuCj4+Cj4+IFNvIEknbSBzdGlsbCB2b3RpbmcgZm9yIHRoZSBhZG1pbiBxdWV1
ZSBleGNlcHRpb24uCj4gCj4gQW5kIEkgcmVhbGx5IGRvbid0IGxpa2UgdGhlIGFkbWluIHF1ZXVl
IHNwZWNpYWwgY2FzZS4gIFdoYXQgaXMgdGhlCj4gYWR2YW50YWdlIG9mIGxldHRpbmcgdXNlciBz
cGFjZSBwYXNzdGhyb3VnaCBJL08gY29tbWFuZHMgaW4gYXQgdGhpcwo+IHBvaW50IGluIHRpbWU/
CgpXZSBuZWVkIHRvIHBhc3MgaW4gbm9ybWFsIEkvTyBjb21tYW5kcyBmb3Igc3VyZSBpbiBvcmRl
ciB0byBoYXZlIGEKcm9idXN0IHJlc2V0IGFuZCBlcnJvciByZWNvdmVyeSAod2hhdCBpbiBnZW5l
cmFsIHRoZSBwYXRjaHNldAphZGRyZXNzZXMpLiBXaGF0IGlzIHRoZSBkaWZmZXJlbmNlIGJldHdl
ZW4gRlMgSS9PIGNvbW1hbmRzIGFuZApwYXNzdGhydSBJL08gY29tbWFuZHM/IEluIGZhY3QsIHVz
ZXIgcGFzc3RocnUgSS9PIGNvbW1hbmRzIHdpbGwgbmV2ZXIKZXhlY3V0ZSBiZWZvcmUgbnZtZV9p
bml0X2lkZW50aWZ5KCkgYmVjYXVzZSB3ZSBhbHdheXMgc3RhcnQKdGhlIEkvTyBxdWV1ZXMgYWZ0
ZXIgdGhhdC4KCkxldCdzIGxvb2sgYXQgcGNpLCBkbyB3ZSBoYXZlIHRoZSBzYW1lIGVuZm9yY2Vt
ZW50IGZvciBwYXNzdGhydQpjb21tYW5kcz8gV2hhdCdzIHNwZWNpYWwgYWJvdXQgZmFicmljcyB0
aGF0IHdlIG5lZWQgdG8gZGVueQp0aGVzZSBjb21tYW5kcyBmcm9tIGdvaW5nIHRocm91Z2g/Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1udm1l
IG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

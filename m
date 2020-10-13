Return-Path: <SRS0=D3oK=DU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAF5C433E7
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 22:31:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B60218AC
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2020 22:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YXZDzW9H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B60218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ABwgru+yR+UT1AYUbqWlwksTLnqknFRJ9BLg1bX+leM=; b=YXZDzW9Hx8AD6LVgLDizH6afP
	w/PBbb38ak/NvvYLZYWfU7mpHLIUuUkG2am/QKjZfsSu+/7dMYaKdHHNP2Sy98P8Xj7YdsKeoy9vl
	QmM43aDkSvt0hxNF7XiwzIy/DsK9jMklFjeRaVj3CPl450hyM4LNyNVKxrq6yeGTAbUXDzoqTcOfu
	3WGTsEyjRrLOx9X+rzU6q/ZBTU7WJUC8IJxhdvXSx0/hyOXXKwllWAMTGCp5OsZiDc+Z70RUuzEDI
	lMrDiq2IKpPcyvu5d2yI7TPwTkBLL/edgCahSS2WJO3wpail9dpuNsigSFYxRVQ1rOiHWoLgc3Gsc
	H+zhPdLYQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kSSpJ-0002Z4-5D; Tue, 13 Oct 2020 22:31:25 +0000
Received: from mail-pg1-f195.google.com ([209.85.215.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kSSpG-0002YX-IL
 for linux-nvme@lists.infradead.org; Tue, 13 Oct 2020 22:31:23 +0000
Received: by mail-pg1-f195.google.com with SMTP id y14so615254pgf.12
 for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2020 15:31:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fGbQscbBmKdccLfNzPmjtUYi2nV7gv4Od0IK12wktQE=;
 b=BBbCdRGzw/FuRHhiAW3FfYfx5nm2goaTuG5FeloD39+JaxGMc7HyYjb+miueGzxwf5
 TCaImC80Y6pyYOsa2DdPACyOewipTQebnU76L5bDERtgHKsCNJus4lumh+9GqtkwhNwy
 6hdtae1lBv8thDd3IH7ZZCx7VYrOK6d1/ridh1C/NDCtXvoZieltl3X4tiTvXpOuQhmK
 h7S7JgmSRy+C4zTfw+jd6PmFWjFBhcqAOipHmRBHkgwGuTh/uKe7rjtODS2OETVK348z
 9r03XmKX7wUP3jIcay70ZxbvXOj8h91L0H/nsZCmj2mwRbfcxD2lkjkyx/0rJja9ZJr7
 viSw==
X-Gm-Message-State: AOAM533qFvIau+1OWTF9gBUylkjj5hdNbzn6rh1vN4TVof5XPxeo6EtV
 o8ae3hQr65lAkNxOXj7OCY8=
X-Google-Smtp-Source: ABdhPJyrkZo5IcWnVEFCz3JbAHrF5ntnLrmiW011ZGrt512iLGJlt8oyC4onKiaJNwKx6T+C1oBSDQ==
X-Received: by 2002:a63:40c1:: with SMTP id n184mr1371918pga.215.1602628281679; 
 Tue, 13 Oct 2020 15:31:21 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:5a09:2d7:19f0:1ee0?
 ([2601:647:4802:9070:5a09:2d7:19f0:1ee0])
 by smtp.gmail.com with ESMTPSA id c10sm685027pfc.196.2020.10.13.15.31.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 15:31:20 -0700 (PDT)
Subject: Re: [PATCH] block: re-introduce blk_mq_complete_request_sync
To: Ming Lei <ming.lei@redhat.com>, Chao Leng <lengchao@huawei.com>
References: <20201008213750.899462-1-sagi@grimberg.me>
 <20201009043938.GC27356@T590>
 <1711488120.3435389.1602219830518.JavaMail.zimbra@redhat.com>
 <e39b711e-ebbd-8955-ca19-07c1dad26fa2@grimberg.me>
 <23f19725-f46b-7de7-915d-b97fd6d69cdc@redhat.com>
 <ced685bf-ad48-ac41-8089-8c5ba09abfcb@grimberg.me>
 <7a7aca6e-30f5-0754-fb7f-599699b97108@redhat.com>
 <6f2a5ae2-2e6a-0386-691c-baefeecb5478@huawei.com>
 <20201012081306.GB556731@T590>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0b5bfc44-d925-960d-b2a2-d0ba88b51111@grimberg.me>
Date: Tue, 13 Oct 2020 15:31:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012081306.GB556731@T590>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201013_183122_646896_72AE2CE4 
X-CRM114-Status: GOOD (  16.54  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Yi Zhang <yi.zhang@redhat.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4+Pj4+PiAtLSAKPj4+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBi
L2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCj4+Pj4+PiBpbmRleCA2MjliMDI1Njg1ZDEuLjQ2NDI4
ZmYwYjBmYyAxMDA2NDQKPj4+Pj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCj4+Pj4+
PiArKysgYi9kcml2ZXJzL252bWUvaG9zdC90Y3AuYwo+Pj4+Pj4gQEAgLTIxNzUsNyArMjE3NSw3
IEBAIHN0YXRpYyB2b2lkIG52bWVfdGNwX2NvbXBsZXRlX3RpbWVkX291dChzdHJ1Y3QgcmVxdWVz
dCAqcnEpCj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqAgLyogZmVuY2Ugb3RoZXIgY29udGV4dHMgdGhh
dCBtYXkgY29tcGxldGUgdGhlIGNvbW1hbmQgKi8KPj4+Pj4+ICDCoMKgwqDCoMKgwqDCoCBtdXRl
eF9sb2NrKCZ0b190Y3BfY3RybChjdHJsKS0+dGVhcmRvd25fbG9jayk7Cj4+Pj4+PiAgwqDCoMKg
wqDCoMKgwqAgbnZtZV90Y3Bfc3RvcF9xdWV1ZShjdHJsLCBudm1lX3RjcF9xdWV1ZV9pZChyZXEt
PnF1ZXVlKSk7Cj4+Pj4+PiAtwqDCoMKgwqDCoMKgIGlmICghYmxrX21xX3JlcXVlc3RfY29tcGxl
dGVkKHJxKSkgewo+Pj4+Pj4gK8KgwqDCoMKgwqDCoCBpZiAoYmxrX21xX3JlcXVlc3Rfc3RhcnRl
ZChycSkgJiYgIWJsa19tcV9yZXF1ZXN0X2NvbXBsZXRlZChycSkpIHsKPj4+Pj4+ICDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbnZtZV9yZXEocnEpLT5zdGF0dXMgPSBOVk1FX1NDX0hP
U1RfQUJPUlRFRF9DTUQ7Cj4+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJs
a19tcV9jb21wbGV0ZV9yZXF1ZXN0X3N5bmMocnEpOwo+Pj4+Pj4gIMKgwqDCoMKgwqDCoMKgIH0K
Pj4gVGhpcyBtYXkganVzdCByZWR1Y2UgdGhlIHByb2JhYmlsaXR5LiBUaGUgY29uY3VycmVuY3kg
b2YgdGltZW91dCBhbmQgdGVhcmRvd24gd2lsbCBjYXVzZSB0aGUgc2FtZSByZXF1ZXN0Cj4+IGJl
IHRyZWF0ZWQgcmVwZWF0bHksIHRoaXMgaXMgbm90IHdlIGV4cGVjdGVkLgo+IAo+IFRoYXQgaXMg
cmlnaHQsIG5vdCBsaWtlIFNDU0ksIE5WTUUgZG9lc24ndCBhcHBseSBhdG9taWMgcmVxdWVzdCBj
b21wbGV0aW9uLCBzbwo+IHJlcXVlc3QgbWF5IGJlIGNvbXBsZXRlZC9mcmVlZCBmcm9tIGJvdGgg
dGltZW91dCAmIG52bWVfY2FuY2VsX3JlcXVlc3QoKS4KPiAKPiAudGVhcmRvd25fbG9jayBzdGls
bCBtYXkgY292ZXIgdGhlIHJhY2Ugd2l0aCBTYWdpJ3MgcGF0Y2ggYmVjYXVzZSB0ZWFyZG93bgo+
IGFjdHVhbGx5IGNhbmNlbHMgcmVxdWVzdHMgaW4gc3luYyBzdHlsZS4KPiAKPj4gSW4gdGhlIHRl
YXJkb3duIHByb2Nlc3MsIGFmdGVyIHF1aWVzY2VkIHF1ZXVlcyBkZWxldGUgdGhlIHRpbWVyIGFu
ZCBjYW5jZWwgdGhlIHRpbWVvdXQgd29yayBtYXliZSBhIGJldHRlciBvcHRpb24uCj4gCj4gU2Vl
bXMgYmV0dGVyIHNvbHV0aW9uLCBnaXZlbiBpdCBpcyBhbGlnbmVkIHdpdGggTlZNRSBQQ0kncyBy
ZXNldAo+IGhhbmRsaW5nLiBudm1lX3N5bmNfcXVldWVzKCkgbWF5IGJlIGNhbGxlZCBpbiBudm1l
X3RjcF90ZWFyZG93bl9pb19xdWV1ZXMoKSB0bwo+IGF2b2lkIHRoaXMgcmFjZS4KCldlIGNhbid0
IGNhbGwgbnZtZV9zeW5jX3F1ZXVlcywgdGhhdCBmbHVzaGVzIHRoZSB0aW1lb3V0IHdvcmsgdGhh
dCBpcwpzZXJpYWxpemluZyB3aXRoIHRoZSB0ZWFyZG93biwgaXQgd2lsbCBkZWFkbG9jay4KCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LW52bWUg
bWFpbGluZyBsaXN0CkxpbnV4LW52bWVAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW52bWUK

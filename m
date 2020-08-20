Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DADFBC433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 22:16:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D342075E
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 22:16:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="grqb3bLi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D342075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6cuVunV9006YNNu1GoT96r1y15xNohoftfOk7F/TpqM=; b=grqb3bLiPGZVst9a69akN3UPG
	ntHggFhPbcvVgDV+6VoAKuBI7G8c9FwwH1l0Ba3ioCsOxFctrC7nkBsk1nuSoDLEELfC2YKKVe3jS
	6nzZ8xC2jUC/4gVqf6xTwWNlu42Bo6GkhDp6dBU0cSUyyQEpk2yq3VYQrSV4kEjQQ2sWXnw4Ult78
	Fj7j866ET/jSFxeEkxPldouhthP2kOeudv6UGa3D+zK2e090DmA7/UksYRIe4RGPxjCVniUIBcdhJ
	b4MUf3Uq/6VbU87t6VKTGsZLHn4di6lIExHI6YGYzqUDIZzytZP7NWFksl2DF4UnsZ/e2TtfARmVI
	724EsFMJQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8srX-00043a-7t; Thu, 20 Aug 2020 22:16:47 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8srV-00042u-1D
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 22:16:45 +0000
Received: by mail-wr1-f67.google.com with SMTP id l2so118634wrc.7
 for <linux-nvme@lists.infradead.org>; Thu, 20 Aug 2020 15:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4z7WmikJzkQnx06VoZIfP/120axKPie3JpJTSqujQlU=;
 b=bwCUEQ4QQxbxMV16mrRgOCgmhJH3D7RXgkORrTkhAtU63jKO50VJp6IiDRcT9ywjt9
 7WtSFJDa7jbEeXM2fO/w2V7/R1KBi7VBRzIVrFOV2G4MJhTGWbKFv1RJJjp3DuE8gG6R
 +YnnYm+6l2Rj+1nqFgCKu/HL+Bbe+ZLDhDmWoan727aWCtUMcyjXgm1QVqh/eH76WCp/
 jxjb0eX+FjOImFLZLav5qjtDlLT8Vb83JvpWT6pe8CfJaDMQphj3PuNdUV3ykAX+5bw9
 wJpQWn+WSog6JkWXce+zzohr1JYX/eOlqzGPZrWnPgdXj+byjYuI582idJxDn+cLRxjd
 o+CQ==
X-Gm-Message-State: AOAM530yecvITAL+kjBaZmBdwJ5B9mQZFYzBnG4g0sGOSvTxb+vmcuTc
 RnR/0Oy0HPSCg9fCthX3AVE=
X-Google-Smtp-Source: ABdhPJwRObWGc4sv0wJ9ILTkKIpaDZJnDNxE53tp8iLMhN3kMKBLIMguEUC3JzsFVr+aP0LxEnJLZQ==
X-Received: by 2002:adf:a112:: with SMTP id o18mr720508wro.73.1597961803066;
 Thu, 20 Aug 2020 15:16:43 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7ced:8569:4373:1bd3?
 ([2601:647:4802:9070:7ced:8569:4373:1bd3])
 by smtp.gmail.com with ESMTPSA id r12sm67491wmh.46.2020.08.20.15.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2020 15:16:42 -0700 (PDT)
Subject: Re: [PATCH v3 7/9] nvme-rdma: serialize controller teardown sequences
To: James Smart <james.smart@broadcom.com>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20200820053651.197057-1-sagi@grimberg.me>
 <20200820053651.197057-8-sagi@grimberg.me>
 <c9d8a30c-e41f-d94e-7682-2a33cc06d7fc@broadcom.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ced9a463-1d68-9551-7efb-74526788bbc6@grimberg.me>
Date: Thu, 20 Aug 2020 15:16:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c9d8a30c-e41f-d94e-7682-2a33cc06d7fc@broadcom.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_181645_081573_7600814C 
X-CRM114-Status: GOOD (  16.96  )
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

Cj4+IEBAIC05OTcsNiArOTk4LDcgQEAgc3RhdGljIGludCBudm1lX3JkbWFfY29uZmlndXJlX2lv
X3F1ZXVlcyhzdHJ1Y3QgCj4+IG52bWVfcmRtYV9jdHJsICpjdHJsLCBib29sIG5ldykKPj4gwqAg
c3RhdGljIHZvaWQgbnZtZV9yZG1hX3RlYXJkb3duX2FkbWluX3F1ZXVlKHN0cnVjdCBudm1lX3Jk
bWFfY3RybCAqY3RybCwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGJvb2wgcmVtb3ZlKQo+PiDCoCB7
Cj4+ICvCoMKgwqAgbXV0ZXhfbG9jaygmY3RybC0+dGVhcmRvd25fbG9jayk7Cj4+IMKgwqDCoMKg
wqAgYmxrX21xX3F1aWVzY2VfcXVldWUoY3RybC0+Y3RybC5hZG1pbl9xKTsKPj4gwqDCoMKgwqDC
oCBudm1lX3JkbWFfc3RvcF9xdWV1ZSgmY3RybC0+cXVldWVzWzBdKTsKPj4gwqDCoMKgwqDCoCBp
ZiAoY3RybC0+Y3RybC5hZG1pbl90YWdzZXQpIHsKPj4gQEAgLTEwMDcsMTEgKzEwMDksMTMgQEAg
c3RhdGljIHZvaWQgCj4+IG52bWVfcmRtYV90ZWFyZG93bl9hZG1pbl9xdWV1ZShzdHJ1Y3QgbnZt
ZV9yZG1hX2N0cmwgKmN0cmwsCj4+IMKgwqDCoMKgwqAgaWYgKHJlbW92ZSkKPj4gwqDCoMKgwqDC
oMKgwqDCoMKgIGJsa19tcV91bnF1aWVzY2VfcXVldWUoY3RybC0+Y3RybC5hZG1pbl9xKTsKPj4g
wqDCoMKgwqDCoCBudm1lX3JkbWFfZGVzdHJveV9hZG1pbl9xdWV1ZShjdHJsLCByZW1vdmUpOwo+
PiArwqDCoMKgIG11dGV4X3VubG9jaygmY3RybC0+dGVhcmRvd25fbG9jayk7Cj4+IMKgIH0KPj4g
wqAgc3RhdGljIHZvaWQgbnZtZV9yZG1hX3RlYXJkb3duX2lvX3F1ZXVlcyhzdHJ1Y3QgbnZtZV9y
ZG1hX2N0cmwgKmN0cmwsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBib29sIHJlbW92ZSkKPj4gwqAg
ewo+PiArwqDCoMKgIG11dGV4X2xvY2soJmN0cmwtPnRlYXJkb3duX2xvY2spOwo+PiDCoMKgwqDC
oMKgIGlmIChjdHJsLT5jdHJsLnF1ZXVlX2NvdW50ID4gMSkgewo+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgbnZtZV9zdGFydF9mcmVlemUoJmN0cmwtPmN0cmwpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAg
bnZtZV9zdG9wX3F1ZXVlcygmY3RybC0+Y3RybCk7Cj4+IEBAIC0xMDI1LDYgKzEwMjksNyBAQCBz
dGF0aWMgdm9pZCBudm1lX3JkbWFfdGVhcmRvd25faW9fcXVldWVzKHN0cnVjdCAKPj4gbnZtZV9y
ZG1hX2N0cmwgKmN0cmwsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG52bWVfc3RhcnRf
cXVldWVzKCZjdHJsLT5jdHJsKTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIG52bWVfcmRtYV9kZXN0
cm95X2lvX3F1ZXVlcyhjdHJsLCByZW1vdmUpOwo+PiDCoMKgwqDCoMKgIH0KPj4gK8KgwqDCoCBt
dXRleF91bmxvY2soJmN0cmwtPnRlYXJkb3duX2xvY2spOwo+PiDCoCB9Cj4+IMKgIHN0YXRpYyB2
b2lkIG52bWVfcmRtYV9mcmVlX2N0cmwoc3RydWN0IG52bWVfY3RybCAqbmN0cmwpCj4+IEBAIC0y
Mjc4LDYgKzIyODMsNyBAQCBzdGF0aWMgc3RydWN0IG52bWVfY3RybCAKPj4gKm52bWVfcmRtYV9j
cmVhdGVfY3RybChzdHJ1Y3QgZGV2aWNlICpkZXYsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm4gRVJSX1BUUigtRU5PTUVNKTsKPj4gwqDCoMKgwqDCoCBjdHJsLT5jdHJsLm9wdHMgPSBvcHRz
Owo+PiDCoMKgwqDCoMKgIElOSVRfTElTVF9IRUFEKCZjdHJsLT5saXN0KTsKPj4gK8KgwqDCoCBt
dXRleF9pbml0KCZjdHJsLT50ZWFyZG93bl9sb2NrKTsKPj4gwqDCoMKgwqDCoCBpZiAoIShvcHRz
LT5tYXNrICYgTlZNRl9PUFRfVFJTVkNJRCkpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIG9wdHMt
PnRyc3ZjaWQgPQo+IAo+IFE6IHNvIHlvdSBkb24ndCBiZWxpZXZlIHRoZXJlJ3MgYW55IGNvbmZs
aWN0IGZyb20gdGhlc2UgdGVhcmRvd24gcGF0aHMgCj4gKHBvc3NpYmx5IGludm9rZWQgYnkgc3lz
ZnMgZGVsZXRlIGN0cmwpwqAgdnPCoCBhIHJlY29ubmVjdCAodGh1cyAKPiBudm1lX3JkbWFfc2V0
dXBfY3RybCkgZW5jb3VudGVyaW5nIGEgZmFpbHVyZSBkdXJpbmcgY29udHJvbGxlciBpbml0LCAK
PiB0aHVzIGl0IGhpdHMgdGhlIGRlc3Ryb3lfaW8gYW5kIGRlc3Ryb3lfYWRtaW4gZXhpdCBwYXRo
cyAtIHdoaWNoIGNhbGwgCj4gbnZtZV9yZG1hX2Rlc3Ryb3lfaW9fcXVldWVzIGFuZCBzdG9wL2Rl
c3Ryb3lfYWRtaW5fcXVldWUgLSB3aGljaCBjYW4gYmUgCj4gc2ltdWx0YW5lb3VzIHRvIHRoZSB0
ZWFyZG93bnMgYW5kIHdpdGhvdXQgdGhlIG11dGV4ID8KCk5vdCByZWFsbHksIHRoZSBmaXJzdCB0
aGluZyByZG1hL3RjcCBkb2VzIGluIC5kZWxldGVfY3RybCBpcyB0bwpjYW5jZWxfd29ya19zeW5j
IHRoZSBjb25uZWN0X3dvcmsgYW5kIHRoZSBlcnJfd29yaywgYW5kIGFueSBvdGhlcgppbnZvY2F0
aW9uIG9mIHRoZXNlIHdvcmtzIGNhbm5vdCBvY2N1ciBiZWNhdXNlIHRoZSBzdGF0ZSBtYWNoaW5l
Cndvbid0IGFsbG93IGl0LiBzbyB0aGF0IHNlcmlhbGl6YXRpb24gc2hvdWxkIGJlIHN1ZmZpY2ll
bnQgdW5sZXNzIEknbQptaXNzaW5nIHNvbWV0aGluZy4uLgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtbnZtZSBtYWlsaW5nIGxpc3QKTGludXgt
bnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtbnZtZQo=

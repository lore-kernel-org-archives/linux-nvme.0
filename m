Return-Path: <SRS0=JSVl=OK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B40C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 10:11:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA1360ED8
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 10:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADA1360ED8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:References:
	Cc:To:From:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xmbhb+wQCTRCIQRTjfM4/+NmrbY4NbhqZgQHp7cju9E=; b=SbQXkfobbO8SXQY6yNuO14jRyl
	javnbEgnti0qFKm2YWJNSyQmUkojsLtoR6ZGBcDkee2PfBEu4BbB+3k76K4td4rUPV8UrmYbNFp7H
	O2D6v8w6oyUgNv1uOsNmdbLns9HywwCT1uS78sZYLyz0kpJ/2YtepPyASddyLosID9cAil5Ia2hTP
	9VQNtLyu2+tuw95IFFv9Ae8nDLy0zGZ++jBB+ZprrP/lRIL1+dPz+fk+X1L2+pOUv4P2pe6ibPgHd
	tcvNCVn4DBUBsmZjeV8XGfFdQw9fJgI0WlhN7lrov4kO6Nk1U4B7bl1ERNWevndbrHY34z44K0VnW
	8jZ28xnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSGGh-001Fr3-7m; Mon, 20 Sep 2021 10:11:23 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSGGe-001FpX-7g
 for linux-nvme@lists.infradead.org; Mon, 20 Sep 2021 10:11:21 +0000
Received: by mail-wr1-f42.google.com with SMTP id t8so20984379wri.1
 for <linux-nvme@lists.infradead.org>; Mon, 20 Sep 2021 03:11:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=eFtJZTAXZALRIcorhxXklb7ZzzHaTQ00dAItDCSjHoo=;
 b=qPl3XsSa9Z6Oz+u6j1ikNvjMdAGHu9mYm73U0+aTGW1RQjRXfzQM3895ANpXsaF64+
 nFjEcHjaJs2XvCxb7yOSS7s5OufCLCUhWC65U0AzRBD4JHE7KWeljcOQWw0gz1sDbL5+
 8hbyBWT4mZz5ICsgzsJFQtVD0nhb91Sq2F1PUi9HoJ0j0qIUwF0XqRlILRY9oWHKATqU
 yHUzZJ8rQrgJXYxjZ0DLrsbdwWxIpnGe8snpkENaqZtaq0UWVluWw3gCCmC0TZ7BfU+G
 ZxKfgKfcVvLM8ih4x4bvgUU4iH5HIGxMizUwyf6WWubCINOXPOx3IrpnNARY3BuA4oyT
 ArqQ==
X-Gm-Message-State: AOAM533Tg0qaTKu2JRwUSz8oIWBTlAK9m7nL7Zbtph+eW4N57CDntCkb
 Q8NcSvX/yE/BmpXDOrHvNyM=
X-Google-Smtp-Source: ABdhPJxsfMQdQdQSGaMrYLXPMM698ruYTLbjKP6yOBCoVoyFg4erxNs0jcGlgQn5phSmzPFtzMuUCw==
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr22450022wmi.70.1632132678496; 
 Mon, 20 Sep 2021 03:11:18 -0700 (PDT)
Received: from ?IPv6:2a00:a040:18e:2e5f:892e:3513:56b2:685c?
 ([2a00:a040:18e:2e5f:892e:3513:56b2:685c])
 by smtp.gmail.com with ESMTPSA id c132sm7024965wma.22.2021.09.20.03.11.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Sep 2021 03:11:17 -0700 (PDT)
Subject: Re: [PATCH] nvme-tcp: fix incorrect h2cdata pdu offset accounting
From: Sagi Grimberg <sagi@grimberg.me>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210914153855.16177-1-sagi@grimberg.me>
 <20210916164559.GB3908552@dhcp-10-100-145-180.wdc.com>
 <a006947f-8494-4e8a-1ab6-72372018b4e0@grimberg.me>
Message-ID: <63f7bbad-7d92-e631-dad2-9145a99e0f10@grimberg.me>
Date: Mon, 20 Sep 2021 13:11:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a006947f-8494-4e8a-1ab6-72372018b4e0@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210920_031120_332787_3431BB52 
X-CRM114-Status: GOOD (  15.03  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
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

Cj4+PiBGaXhlczogODI1NjE5YjA5YWQzICgibnZtZS10Y3A6IGZpeCBwb3NzaWJsZSB1c2UtYWZ0
ZXItY29tcGxldGlvbiIpCj4+PiBSZXBvcnRlZC1ieTogTm93YWssIEx1a2FzeiA8THVrYXN6Lk5v
d2FrQERlbGwuY29tPgo+Pj4gVGVzdGVkLWJ5OiBOb3dhaywgTHVrYXN6IDxMdWthc3ouTm93YWtA
RGVsbC5jb20+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJn
Lm1lPgo+Pj4gLS0tCj4+PiAtIEtlaXRoLCBjYW4geW91IGFzayB0aGUgV0QgdGVhbSB0byB0ZXN0
IHRoaXMgYXMgd2VsbD8KPj4+Cj4+PiDCoCBkcml2ZXJzL252bWUvaG9zdC90Y3AuYyB8IDEzICsr
KysrKysrKystLS0KPj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQo+Pj4KPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC90Y3AuYyBi
L2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCj4+PiBpbmRleCA2NDUwMjU2MjAxNTQuLjg3YjczZWI5
NDA0MSAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvbnZtZS9ob3N0L3RjcC5jCj4+PiArKysgYi9k
cml2ZXJzL252bWUvaG9zdC90Y3AuYwo+Pj4gQEAgLTYwNyw3ICs2MDcsNyBAQCBzdGF0aWMgaW50
IG52bWVfdGNwX3NldHVwX2gyY19kYXRhX3BkdShzdHJ1Y3QgCj4+PiBudm1lX3RjcF9yZXF1ZXN0
ICpyZXEsCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgY3B1X3RvX2xlMzIoZGF0YS0+aGRyLmhsZW4g
KyBoZGdzdCArIHJlcS0+cGR1X2xlbiArIGRkZ3N0KTsKPj4+IMKgwqDCoMKgwqAgZGF0YS0+dHRh
ZyA9IHBkdS0+dHRhZzsKPj4+IMKgwqDCoMKgwqAgZGF0YS0+Y29tbWFuZF9pZCA9IG52bWVfY2lk
KHJxKTsKPj4+IC3CoMKgwqAgZGF0YS0+ZGF0YV9vZmZzZXQgPSBjcHVfdG9fbGUzMihyZXEtPmRh
dGFfc2VudCk7Cj4+PiArwqDCoMKgIGRhdGEtPmRhdGFfb2Zmc2V0ID0gcGR1LT5yMnRfb2Zmc2V0
Owo+Pgo+PiBTaG91bGRuJ3QgdGhpcyBiZSAibGUzMl90b19jcHUocGR1LT5yMnRfb2Zmc2V0KSI/
Cj4gCj4gTm8sIGRhdGEgaXMgYSB3aXJlIHBheWxvYWQsIHNvIGl0IGlzIGxlMzIKCktlaXRoLCBp
Zi93aGVuIHlvdSBhcmUgT0sgd2l0aCB0aGlzLCBpdCBzaG91bGQgZ28gNS4xNQphbmQgc3RhYmxl
LgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgt
bnZtZSBtYWlsaW5nIGxpc3QKTGludXgtbnZtZUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtbnZtZQo=

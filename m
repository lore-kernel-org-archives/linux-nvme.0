Return-Path: <SRS0=9U1b=CX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2898C433E2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 23:54:00 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BAEB206B6
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2020 23:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OOlI7kG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BAEB206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0C8n5dyZakWOlPz208VkqdMI5K9C7eEy7bJlU/cRQIw=; b=OOlI7kG/WwS08mgg1hPNHoT/4
	RYor+kOiQyO7ArEz+X4coEnNjk94zXusPUhfT3rbajPivuYqxrDWGZUXVy5OuOle5riLQfApulNq+
	CIAKLT/reOkkoEU08BJdTqWXbw/xYATlIyTaZtT2xCV0m2wTwv8DtvszDczfExBxY2DD7TZ1mVxAr
	Q9QlJlIb1KWHy3E4IP4eEbu/jLpcf1QYFX7HWxz6Qi2cZnS9+Bvr/qE06xBPYoRKqqIRnEf0PRyvr
	3wHDm01hVskRLBGhLZ8Relv6bZKEA4F8hRWpisCNb3JmadrVxEhdoy8r6t06+pWXWMWnd78LC5Pdr
	dv8DFdN+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kHyIC-0004Z4-WA; Mon, 14 Sep 2020 23:53:53 +0000
Received: from mail-pl1-f194.google.com ([209.85.214.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kHyIB-0004Yc-2v
 for linux-nvme@lists.infradead.org; Mon, 14 Sep 2020 23:53:51 +0000
Received: by mail-pl1-f194.google.com with SMTP id u9so358504plk.4
 for <linux-nvme@lists.infradead.org>; Mon, 14 Sep 2020 16:53:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C4sZWbyH8G0P9zu/VRwIFjsAwP3CrpSj5KC1+h7w7bE=;
 b=sMgYZx4VyLkwd3cRssyitsXM7oFQQ9gqsQMxE/QXqHCBu+EwBFdyI20iA9TZKCXSWn
 VNRUHbAWEZIGoY+FY3AuWhhagBNd3VAzeAAvtAqpAIc07m+hKifdi/kvaBJqz8lbxzlo
 ItOBZW4XkjmIw9DiMSe3vwJF9OGD+C+S/B8Q6sWrKa/eKRIe2vh0FbD+weyg9hhyvX5Q
 6QI4zkqCgMqp3HX7nzbI0aPMW6TZwKMccXTynVr4tkMd6E9q8RH0CgjlveIKi5Q8U/JZ
 0laTwi6IBHCETY6/aiKwnrQl5I7dWNWO1Egh7N68u+8/Vyaw+E6dMZenz/ZvF5ruyW+q
 YK8A==
X-Gm-Message-State: AOAM530pKBOF/C0GVSxS04S3N6u6swlO5VK9vv94RmVGBzDHUNJ/v88q
 uFoPKfJ5lcQK5pbNRBPBQCPON9EDEH4=
X-Google-Smtp-Source: ABdhPJxZKuYRummskrc/r0oJTAT8OfDA44Enqhmx8y5vQVAmnIZr+REbZ1qajxQagv5S1PG6qp9lvw==
X-Received: by 2002:a17:90b:364c:: with SMTP id
 nh12mr1546647pjb.182.1600127629649; 
 Mon, 14 Sep 2020 16:53:49 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3268:60da:a840:77e?
 ([2601:647:4802:9070:3268:60da:a840:77e])
 by smtp.gmail.com with ESMTPSA id f19sm10619505pfj.25.2020.09.14.16.53.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2020 16:53:48 -0700 (PDT)
Subject: Re: [PATCH] nvmet: Set ctrl->kato to a default NVMET_DISC_KATO value
To: "Engel, Amit" <Amit.Engel@Dell.com>, Christoph Hellwig <hch@lst.de>
References: <20200818065114.57532-1-amit.engel@dell.com>
 <20200818162731.GC27196@lst.de>
 <0b3027b3-e4ef-3e45-9b92-babe09e34e6d@grimberg.me>
 <cdb5a25d-ab1c-bd6f-2608-c51e169ad87a@grimberg.me>
 <MN2PR19MB300552C9AAC6400847E51042EE5D0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <17f4ef7f-1a1f-4e0c-5219-117bc752d959@grimberg.me>
 <MN2PR19MB30050F8BE320428D55B32231EE5D0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <MN2PR19MB3005D217FD29FC88C64106F5EE220@MN2PR19MB3005.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4291dca3-618a-c6a6-8374-950f6cbb6af9@grimberg.me>
Date: Mon, 14 Sep 2020 16:53:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <MN2PR19MB3005D217FD29FC88C64106F5EE220@MN2PR19MB3005.namprd19.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200914_195351_184775_E13F06F2 
X-CRM114-Status: GOOD (  15.88  )
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
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cj4gSGkgU2FnaSwKPiBTdGlsbCBkZWFsaW5nIHdpdGgga2VlcC1hbGl2ZSB0aW1lb3V0ICB6ZXJv
IHZhbHVlIGFuZCBob3cgaXQgYWZmZWN0cyBvdGhlciBzY2VuYXJpb3M6Cj4gV2l0aCBteSBsYXRl
c3QgcGF0Y2gsIHdoZW4ga2VlcCBhbGl2ZSB0aW1lb3V0IGlzIHNldCB0byB6ZXJvIHRoZSBrZWVw
LWFsaXZlIHRpbWVyIGlzIGRpc2FibGVkLiAoVXBzdHJlYW0gY29tbWl0IDBkM2I2YThkMjEzYTMw
Mzg3YjUxMDRiMmZiMjUzNzZkMTg2MzZmMjMpCj4gQnV0IHRoYXTigJlzIG9ubHkgcGFydCBvZiB0
aGUgcGljdHVyZSwKPiBXaGF0IGhhcHBlbnMgaWYgYSB1c2VyIHN0YXJ0cyB3aXRoIGthdG8gPiAw
IGFuZCBtb2RpZnlpbmcgaXQgYnkgc2V0IGZlYXR1cmUgYSB3aGlsZSBhZnRlcj8KPiBBZnRlciBt
b2RpZnlpbmcgdGhlIGthdG8gdG8gMCB3aXRoIGEgc2V0IGZlYXR1cmVzIHdlIHdpbGwgbmV2ZXIg
c3RvcCB0aGUgdGltZXIKPiBJbiBhIHNpbWlsYXIgd2F5LCB3aGVuIHN0YXJ0aW5nIHdpdGgga2F0
byAwIGFuZCB0aGVuIG1vZGlmeSB0byBrYXRvID4gMCB3ZSB3aWxsIG5ldmVyIHN0YXJ0IHRoZSB0
aW1lcgo+IAo+IFdlIHRob3VnaHQgYWJvdXQgc29sdmUgaXQgYnkgYWRkaW5nIGNoZWNrcyBpbiDi
gJhudm1ldF9zZXRfZmVhdF9rYXRv4oCZIGZvciB0aGUgYWJvdmUgY2FzZXMKPiBBbmQgaGFuZGxl
IHRoZSBrYV93b3JrIGFjY29yZGluZ2x5Cj4gV2hhdCBkbyB5b3UgdGhpbmsgPwoKV2UgY2FuIHBy
b2JhYmx5IGp1c3QgY2FuY2VsIGFuZCByZXN0YXJ0IHRoZSBrZWVwIGFsaXZlIHRpbWVyIGluIHRo
YXQKY2FzZS4uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJhZGVhZC5vcmcK
aHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1udm1lCg==

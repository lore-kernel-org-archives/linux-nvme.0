Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD9DC433E2
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 19:14:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45A022208
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 19:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="z/w1yjbE";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="fOOzyerU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45A022208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:In-Reply-To:References:Message-Id:Date:Subject:
	Mime-Version:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Wna+YQagd3G9pYD+9/hx3j3o6ttyQ9+8fBUNNsbLUoc=; b=z/w1yjbEW4nN40NGPTZLLbnkB
	7rcNvj79I3GZ/Ohkqt7KZDpwOyLOZF6Mcnn0I+2fXseP+flkNaTHqzdykZCRHG4ObuIqyJX6G8TiT
	pxGzAHU95oP7jUrwaIugP43ROIh+6PwDxMhPyE8bre7tnafxfTHPSJh6wjG10pQ0Tj+Y6nLaz9SF1
	hWMD/gGI614Elbc9Fab3iPq2b5trimIz0hf2UoHX3stGzWvFgSdvrUmGMpwCDk0QNrmbLIBVUbAQ8
	EIt3lUtvRCvPfi37uO/End/TLIlTTTyJ2R9JrV09zORM0OjcFIv8MYaALPRAzHjVXWEJFeisowz0A
	1V/aGt29Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGoVI-0007pf-K8; Fri, 11 Sep 2020 19:14:36 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGoVG-0007pA-Ao
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 19:14:35 +0000
Received: by mail-pf1-x443.google.com with SMTP id d9so8124249pfd.3
 for <linux-nvme@lists.infradead.org>; Fri, 11 Sep 2020 12:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=content-transfer-encoding:from:mime-version:subject:date:message-id
 :references:cc:in-reply-to:to;
 bh=BAqPbPUHEIp6jW3DAn8JnegsecIzGAswAeb9R+1L94g=;
 b=fOOzyerUwljnh1qE8UKPVDiRXni4o9PnD1Hvxrnnuzv8biGawkT2yjGSgAn98FW4lr
 8HB6pAL7Y6khAFkz2pbp9dXNQIC9bYeqx1Mu8uHvQduB8ZLUOmDtDrwfVqz/Ar/eMG0a
 7Pn2cjdF5AshLYkI/XaOsx6/fwclsbT/RXgX5L6dBmO4/pg9lkddxZG1WXDGWBsfQn8X
 8oNtNhncXgW3Zu6U4BuKrkmBODO+WjATHeeJj7aww7v3cB7S9ij2Ywgq2OhfNwWUvkcf
 nJ5vDeVOj4O47zRSNLmTeZYijox1OSc3Hcerz97Yu8gDK/FOILE0lbMDpi4TVQfjcEpS
 89Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=BAqPbPUHEIp6jW3DAn8JnegsecIzGAswAeb9R+1L94g=;
 b=NmlEMXwrEGtInT5HAKkXNL+ObxetYXR0yoC20/yh5bWiSueXyG6/13SNLH3uvjdCl8
 9oG8AcfRJmsz5TD/36wNWrJ15l+1V6OGdh1QZE72U+79pnnj+UEoBxQPrhipCdMfIxv1
 n20mMV94aNlj02tgr7YqMm6ocP+GmqbP7UD8nmhCYKOH2v5g1ughh34Ad/i1qJfz/LaG
 +aKiK5vodoDzCoW9s9Hhux5l/R/hCZQl0C9GCNQahIqC3eylOAlo1IMGVbAGUHrtGF0w
 FU4QIcSWQBPFFiFDvhOuXB+mwUizUQcxkZjwIAgWqhKSPrpXG1mH40tDjpyduZVNwDGf
 tY9g==
X-Gm-Message-State: AOAM531QJieh+ShBVzi85Y3+LscKnLzlbjbA65ZzQCyGKSIcOg5Re6rL
 +Zw4MT/kPwhjrFseV5dhgP1BlfeaAnM1dw==
X-Google-Smtp-Source: ABdhPJy4LjwfrgHmP9hDGYWAPVXI4lKvrgQjU0yDbAzEoHkviCtmwerDB1aYoLXNAWYy+OPYCov7KA==
X-Received: by 2002:a62:7f8d:0:b029:13e:d13d:a104 with SMTP id
 a135-20020a627f8d0000b029013ed13da104mr3348108pfd.32.1599851672069; 
 Fri, 11 Sep 2020 12:14:32 -0700 (PDT)
Received: from localhost.localdomain ([2600:380:4953:91bd:8495:3742:6e97:1810])
 by smtp.gmail.com with ESMTPSA id y13sm3018286pfr.141.2020.09.11.12.14.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 12:14:31 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref for
 BLK_MQ_F_BLOCKING
Date: Fri, 11 Sep 2020 13:14:29 -0600
Message-Id: <D4DF8CEF-AFFE-4EE1-947F-D9500007C7A0@kernel.dk>
References: <e517d3c4-86de-95bd-2013-d59eb48ba789@grimberg.me>
In-Reply-To: <e517d3c4-86de-95bd-2013-d59eb48ba789@grimberg.me>
To: Sagi Grimberg <sagi@grimberg.me>
X-Mailer: iPhone Mail (18A5369b)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_151434_403000_4107DB4E 
X-CRM114-Status: GOOD (  13.07  )
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
Cc: Bart Van Assche <bvanassche@acm.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-nvme@lists.infradead.org, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

T24gU2VwIDExLCAyMDIwLCBhdCAxOjEyIFBNLCBTYWdpIEdyaW1iZXJnIDxzYWdpQGdyaW1iZXJn
Lm1lPiB3cm90ZToKPiAKPiDvu78KPj4+IEhpIEplbnMsCj4+PiAKPj4+IFRoZSAxc3QgcGF0Y2gg
YWRkIC5tcV9xdWllc2NlX211dGV4IGZvciBzZXJpYWxpemluZyBxdWllc2NlL3VucXVpZXNjZSwK
Pj4+IGFuZCBwcmVwYXJlcyBmb3IgcmVwbGFjaW5nIHNyY3Ugd2l0aCBwZXJjcHVfcmVmLgo+Pj4g
Cj4+PiBUaGUgMm5kIHBhdGNoIHJlcGxhY2VzIHNyY3Ugd2l0aCBwZXJjcHVfcmVmLgo+Pj4gCj4+
PiBUaGUgM3JkIHBhdGNoIGFkZHMgdGFnc2V0IHF1aWVzY2UgaW50ZXJmYWNlLgo+Pj4gCj4+PiBU
aGUgNHRoIHBhdGNoIGFwcGxpZXMgdGFnc2V0IHF1aWVzY2UgaW50ZXJmYWNlIGZvciBOVk1lIHN1
YnN5c3RlbS4KPj4gV2hhdCBpcyB0aGlzIHNlcmllcyBhZ2FpbnN0Pwo+IAo+IEl0IGRpZG4ndCBh
cHBseSBjbGVhbmx5IHRvIG1lIHRvbyB1bnRpbCBJIHJlYWxpemVkIGl0IGlzCj4gb24gdG9wIG9m
IHY0IG9mOiAicGVyY3B1X3JlZiAmIGJsb2NrOiByZWR1Y2UgbWVtb3J5IGZvb3RwcmludCBvZiBw
ZXJjcHVfcmVmIGluIGZhc3QgcGF0aCIKClJpZ2h0LCBhbmQgdGhhdOKAmXMgd2hhdCBoYXMgdGhl
IGxlYWsgaXNzdWUgeW91IGZvdW5kLiBJ4oCZbGwgaG9sZCBvZmYgb24gdGhpcyBvbmUgdW50aWwg
dGhhdOKAmXMgc29ydGVkLiAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpMaW51eC1udm1lIG1haWxpbmcgbGlzdApMaW51eC1udm1lQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1udm1lCg==

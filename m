Return-Path: <SRS0=N0J2=GB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5137CC433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Dec 2020 01:25:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD03D207D1
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Dec 2020 01:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD03D207D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tJzLCBmMoJBqCRN/5aI9jeqtWbx3oVeJfhAfFqKgCsE=; b=cBJoEgftvYuRZXH2o7BGFzjzV
	3zXPnFCBVMrhbg1ujmtvSn29vJPjTpYvLKGAV1AVgF3m6jK8EWfJB7U1WRRVgBlA9muLWJisepYOq
	itjjIcoPe/v1oI3COIOTcLpaB+NGaqQX9Ox0pJll2ubQI07loQn9dpyqjfMsovY9UlP958itAZ05T
	61o9Zsj3jQSuu25D/RGw3Y8yGU92NHwlhLGRxhLOvrwAcZGvSFshL8RCJJIhr2mfWku8qHC6fEbib
	geAxSyR5DGGTgdP9py7wIVW4uMe8wTzIKoAjoQFP5+pH1Qjfqs7lNxkoWrdfOAsLa5zwNcj38zZWz
	RjnPyBNZw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ku3lh-00036R-If; Tue, 29 Dec 2020 01:25:45 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ku3lf-00035K-3k
 for Linux-nvme@lists.infradead.org; Tue, 29 Dec 2020 01:25:43 +0000
Received: by mail-wm1-f41.google.com with SMTP id k10so827237wmi.3
 for <Linux-nvme@lists.infradead.org>; Mon, 28 Dec 2020 17:25:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7JvkO3JRUqROUeOI80D4CtSmrET7c43CGTMT1ofGAvU=;
 b=PyYfQpDsIsopKwpATxhlT0DLJblTya4vSdMmIUzJHBI11e2ZYq6DOMMfZLR/DPMXNr
 Do9M02zMFq+Gbx2v93YSSib15xriIQzHZ03YRZu4dRUyc2/BGNehebZk2vg8KXSy7CUD
 5mM+6R+lrvEzZwhWqj0vR2B6fy+X4oeL8eEBQOv29zsMMeWe+yFv8n6W4oE4oyZE531N
 fyF89gRC7qpY9CdFml37pI5ThieXa4ruDN0QYH4Sz7/k2U3Sx5AXGL31+SHed43uUOri
 qsA97bDvPZ16O1UJ0N39PiHwARe8KOAXLodkuBc7y9K0dNHq7bkdyJZNkYajzbm0oWAl
 KyTA==
X-Gm-Message-State: AOAM532D4jgEMQkKIA/rSYq5zwxxgOkJ0ADVpSOWwsU3FoWHviFTTozZ
 h5F8XRBSDa5fysR51tRpkPRlMvBS/+8=
X-Google-Smtp-Source: ABdhPJwrqVPhXOYOq/ilTaZTfARsreRBDxp/OM73cJpMkHMXtSzUTVdMG+1VgnPylSEzWAhFlL0e2A==
X-Received: by 2002:a1c:988f:: with SMTP id a137mr1266088wme.130.1609205140037; 
 Mon, 28 Dec 2020 17:25:40 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:cacc:d98e:ec88:5020?
 ([2601:647:4802:9070:cacc:d98e:ec88:5020])
 by smtp.gmail.com with ESMTPSA id l20sm63364224wrh.82.2020.12.28.17.25.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Dec 2020 17:25:39 -0800 (PST)
Subject: Re: Data corruption when using multiple devices with NVMEoF TCP
To: Hao Wang <pkuwangh@gmail.com>
References: <CAJS6EdjsTVgs3JK3q2DePjEz1A0s9RJTOwqo=Ka7kinNMECtJw@mail.gmail.com>
 <2c0ff5ec-4ae2-ad29-67fb-4744514dab47@grimberg.me>
 <CAJS6Edh8aVAHhKRGqU+7v5C3KY7YxczVg_7Q8QrPGtyvVw7K3w@mail.gmail.com>
 <fd4541e4-78c5-ec3b-b272-467fd11f7472@grimberg.me>
 <20201223084332.GA30502@infradead.org>
 <CAJS6EdijX6ws_wHxygdpcYGtB6JFwLDbDE3A0t0QUYS-LbRakg@mail.gmail.com>
 <16d876c1-524a-38d3-3cff-99ec694464b2@grimberg.me>
 <CAJS6EdivEF0c=3FmKj4wGZoVRKbUvjH_qJLXmO7Tvwsp+km0rw@mail.gmail.com>
 <f631893c-5ce9-95fd-c32c-35a7e70d093c@grimberg.me>
 <CAJS6EdjUAb77-rWd=XmFhsM2_3Hds6VV6jQUVPJoJQHhk12J_Q@mail.gmail.com>
 <a6564a08-a3b0-5c22-51e3-712c4714bcc5@grimberg.me>
 <CAJS6Edgb+yCW5q5dA=MEkL0eYs4MXoopdiz72nhkxpkd5Fe_cA@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5e999a54-753e-6a61-6ce5-02563dd9c854@grimberg.me>
Date: Mon, 28 Dec 2020 17:25:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJS6Edgb+yCW5q5dA=MEkL0eYs4MXoopdiz72nhkxpkd5Fe_cA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201228_202543_170029_A94A022D 
X-CRM114-Status: GOOD (  12.38  )
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
Cc: Christoph Hellwig <hch@infradead.org>, Linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Okay, will do that in a few days. Something else just popped up and I 
> have a limited time window to use some machines.

Understood, I'm still trying to understand what can cause a problem
in a multi-bio merge request, that used to work AFAIR...

> BTW, what is the performance implication of disabling merge? My usage 
> pattern is mostly sequential read and write, and write bandwidth is 
> pretty high.

Well, if your writes are bigger in nature to begin with, there is not
a lot of gain, but if they are than there is a potential gain here.

Some of the log messages could also help understand what is the
I/O pattern.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACE8C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 07:10:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88AA520792
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 07:10:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mmaU8aAS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88AA520792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=AA2gj+lbOZ9gaCqNaVyoJiNv38zVjcjPenekDxj4ZIM=; b=mmaU8aASzFSIBCZ5giljmy1Xu
	Te3I0ATsw0UnltzpchxJ6r88tYSCNeSlumgxwGEz/pB87yZobi1ZpC9mNbYLdjBa44dP4tWyIpoAR
	Pcp5yBKZdkuFqPDOgyWw16HQc52XygQE1uwZhd+R4A8FIc3v69duDS3r4084b+ia1hpZp9B/wDQDz
	vaK39dwYlLGWuYnwl7JB7BG7fxirFaFHLPfSROr9qJWsZR5/6Ud5gbzNWZIwwQc6WHtE8UDxKUHum
	/e8gR8xwoffDMsyuRsi2M/8rJ7L4F011bk9EaoIHUuOK/6G/3Eq72zS/eFHy3Fps3/Dy2mPH6S667
	Mpd8JsF+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0Jkz-000749-9p; Tue, 28 Jul 2020 07:10:37 +0000
Received: from mail-pl1-f193.google.com ([209.85.214.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0Jkv-00073T-1i
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 07:10:33 +0000
Received: by mail-pl1-f193.google.com with SMTP id t1so250037plq.0
 for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2020 00:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=UsT4BypHdyj7j27a6z6HtNJHEa48goAu7/f8FQmxDBA=;
 b=UP7SWWrTZ4I00sayzp5d6TYcUsdPLkeDnq1HvulA/nyX3t+f7H2ZHwOwzLOv/3tKU3
 DJJDe9S2tZOmhZ+6XhDJ2BaGibD2TZky+WLdfPhWrXektpHI683ji8Bw30oPfSVe46M+
 dScShwjWoxf0NT3RqontsPW160dDN1zVSdIrXu5egGDDuTLx3B5zgzZsBNG5eXJUkXoC
 a7Gio7HM+wcd5jZ69d11KDenXC+D00NiHkhNvxLp2JnncmvGTd7ixCeaKXP9pMnDRyrA
 GkLaf7frwoiVe9gd6drwyqicdCoQ7XVc7bj4kIQ6w4DBjSlSwBFnwPp59VmXfw8hrGO7
 VoAw==
X-Gm-Message-State: AOAM531Dkr+gTerU1mQ/RVBPAdDlR42e+iD+PaQaqqMqut1RR0JdsKjR
 DBc+miUpRXdUerzvYT6XN3xJlUzh
X-Google-Smtp-Source: ABdhPJy6bVeOJYW3uUyP2cLjlCqk12YcubHCZ/9sQIp7HDWBOWBXb/8DlT0WOkOntpNf2GOGHwmOSQ==
X-Received: by 2002:a17:90a:1109:: with SMTP id
 d9mr3097079pja.201.1595920228248; 
 Tue, 28 Jul 2020 00:10:28 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:541c:8b1b:5ac:35fe?
 ([2601:647:4802:9070:541c:8b1b:5ac:35fe])
 by smtp.gmail.com with ESMTPSA id y22sm1739997pjp.41.2020.07.28.00.10.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 00:10:27 -0700 (PDT)
Subject: Re: [PATCH 2/2 v2] nvme-rdma: fix controller reset hang during traffic
To: Christoph Hellwig <hch@lst.de>
References: <20200728003209.406197-1-sagi@grimberg.me>
 <20200728065511.GA21572@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e6bb2cfc-e253-04ef-e51e-5971565bd82b@grimberg.me>
Date: Tue, 28 Jul 2020 00:10:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200728065511.GA21572@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_031033_122250_E9764A0F 
X-CRM114-Status: GOOD (  12.04  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Why is this a 2/2 v2, where is the 1/2?

Sent on 7/24/20, 3:10 PM (PST)

Along with:
[PATCH 1/2] nvme-tcp: fix controller reset hang during traffic

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

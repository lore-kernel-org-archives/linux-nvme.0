Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6D1C433E6
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 21:25:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6C5B206FA
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 21:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u3kIJp0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6C5B206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=UBYfAdIomJceMuowS6w7t/BbEU66VDlxw1czxIqikns=; b=u3kIJp0Lmng3rTV6iuiDsGyyN
	SfQM0f6fRp8TkDV6GKjkq+zb2SI8cnC5xrkhUbolNNetkT1Gir0IqnMWtO+uN+E1SN1qJ8Q6zvrpF
	8me6PJIxlslq6+FQkxy1v3RI2K+X5grjKWAYOB3+b3aUBmAXzuX7RYhenk/qIbJRTPFOW8Y8IfplI
	ljtdjx4bcTUEDfWhjOK5YZWojbzrHH5g4ePIy+R82CCp1oarQICXRX2lkmheYyq4qTt04ZNQmgM6V
	cXrpfbmEX1RuLpr16orlOof7ajUZBcEceYfjhD89awavOgf3+bWOVYRqZ2mAd30C6DVfc46cU4FdN
	eHw0Hiomw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kCrIa-0000fA-Vq; Mon, 31 Aug 2020 21:25:09 +0000
Received: from mail-wr1-f68.google.com ([209.85.221.68])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kCrIW-0000dl-Tg
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 21:25:06 +0000
Received: by mail-wr1-f68.google.com with SMTP id h15so7293594wrt.12
 for <linux-nvme@lists.infradead.org>; Mon, 31 Aug 2020 14:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qU8wx5JnbBqUdEl8L2dNzh5q3dy7XkwjYSkgbTlVvfQ=;
 b=hE8dMwObHmbBozSC9G+Iz6Ew2ydrCLpjPqfa5QgJi6JnF/rSCC1zgkWqzpbOQLJO+V
 ZY5ZT1lqJ6FZ9DWpj5FX3/UFtlg65yJnva+KnzkW0jXX0uMjBb2VbPIB1XrUMHyEkvSo
 uOgHfhwb7balH95iWwoi4WGAXw5fJgscrVa0y0p2URX4sUCj332g2l0K7/TvYgN3BhAv
 4dIAAgJGGXtzCMtQgkflMj6SFVSE8zWu4ehfm7kS9TO2bWDHNl/yNJbeoLCZtoZQUCY+
 dAxzJnYhhGHmqC55vWW/AKmO6MmKVAx2JZaAWV8TABxOCZMckT8Ohgd40fZpBXVC6DSG
 kRfw==
X-Gm-Message-State: AOAM531QK90kwwoVrEAovNCCWmwOCD4HIynp7Q1txJmBkx/+Djnd2f4L
 l1EsBVuS95WDMWR4Z8ODcNUggpKHhrlmng==
X-Google-Smtp-Source: ABdhPJwj+LI7Bn3P8ochsg5JFNjR1rXaiGDMnEFeEtq0GNSxMylq1ldvyCb0JVg/XdhuNq5RS+RLWQ==
X-Received: by 2002:a5d:6691:: with SMTP id l17mr3409170wru.10.1598909101873; 
 Mon, 31 Aug 2020 14:25:01 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:70b6:3990:a389:c0d1?
 ([2601:647:4802:9070:70b6:3990:a389:c0d1])
 by smtp.gmail.com with ESMTPSA id h2sm11703482wrp.69.2020.08.31.14.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2020 14:25:01 -0700 (PDT)
Subject: Re: [Regression] [PATCH] nvme/core: Access to NULL pointer in sysfs
To: Torsten Hilbrich <torsten.hilbrich@secunet.com>
References: <b3723cbd-45cb-1e71-479b-9d11b0670a93@secunet.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <58fd62c9-9d12-cfd3-8d09-fd62bc0103c4@grimberg.me>
Date: Mon, 31 Aug 2020 14:24:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <b3723cbd-45cb-1e71-479b-9d11b0670a93@secunet.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_172505_147615_1A388AB0 
X-CRM114-Status: GOOD (  12.29  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> Hello,
> 
> when updating my kernel to a v5.9-rc2-based build I noticed some kernel
> crashes when accessing the reconnect_delay and ctrl_loss_tmo sysfs
> properties.

A fix was already staged, it fixes the issue differently, but it is
resolved.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

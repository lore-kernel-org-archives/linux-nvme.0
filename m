Return-Path: <SRS0=EAhk=HO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33998C433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 20:58:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C179164DE9
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Feb 2021 20:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C179164DE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4b61w7fXakbwbz5dolCMqEVRmxopP1bjO2v9/ii+Gmo=; b=viTblNaFnbBjyJxfkHH/2Euwy
	1qjXM34r8XbGhq3zkeF27ENXTp9fJRNr7dYbbbQ6wBdGVNux/+xrAqlyJFaLzt+7GNtfXYJJosz+i
	vMxeQUQw2lUCLAHFnQVVchJecfPfMTReExUUFjZxzYB6aYzU7qlfKpmr0FWCITru384AUGJqPD6VH
	qAt53e8eAwYgfU/q954SHxGlx1TfDF4Bf+eKoTQd82gNasei9XswIKkT6LriDJdzSATFszBGxbRCQ
	SCGzV2O5ZozZoGueW3ktCa7nSjIZRLMvd3vYk9dUk3FJGhQakGVn5CgxOHykq7tSHD0WV7PvFvbuT
	ZK0FwGefg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAfWN-0001Ec-7Z; Fri, 12 Feb 2021 20:58:35 +0000
Received: from mail-pf1-f176.google.com ([209.85.210.176])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAfWL-0001EA-Gj
 for linux-nvme@lists.infradead.org; Fri, 12 Feb 2021 20:58:34 +0000
Received: by mail-pf1-f176.google.com with SMTP id c11so247139pfp.10
 for <linux-nvme@lists.infradead.org>; Fri, 12 Feb 2021 12:58:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OOP85J78eURVeajRWrWSkTfxx+e6ApRWxBqBF8ABPdM=;
 b=MntbtA25//373iDwVQiL4cwJFIQSlmnlQs1xLl7vfhDDKcP1yaq1YwQMiqVwM+NdbC
 9Y7T/qx4FeKDojT+4GSCgjHuapksFj5OvVONi5/JykZcGOg33d011H145+/7yEoIvy9C
 uIICDtJjRkEgk9HvElhrIVnn9Yh987EfXfffZQ8LbNmxwst8kX33sPxvCdim23kmxsXV
 CVW3FtHoW+sYFDT++qr2LWeRMdufY7Hmq2miSW4TjquZj3KUiH0nWli7C4rCNAzDcIWo
 JOPQSS1Fe+iCZprlQUL9C00LAdayJEnbBV3BbLNH6AyYhRM9KU/6IZ1uGWceSUbij3qf
 0ATw==
X-Gm-Message-State: AOAM5305V8Ts5GZXPnydwblPcwabeZ96TMwia4zjbXk6hj64QaJArLFh
 kdZL03pAeAORF4zOESlplpM=
X-Google-Smtp-Source: ABdhPJy60UkNzLFCj6yFQkfBtOU88xBKIi0CchABJltdveTzvfTmlEU5zN4nhzO1XP9gPw1SGhrr7Q==
X-Received: by 2002:aa7:93ad:0:b029:1d5:d9c5:cc08 with SMTP id
 x13-20020aa793ad0000b02901d5d9c5cc08mr4609553pff.37.1613163509931; 
 Fri, 12 Feb 2021 12:58:29 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:65a3:c687:b052:ed7b?
 ([2601:647:4802:9070:65a3:c687:b052:ed7b])
 by smtp.gmail.com with ESMTPSA id w4sm9897356pfn.45.2021.02.12.12.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Feb 2021 12:58:29 -0800 (PST)
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20210212181738.79274-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
Date: Fri, 12 Feb 2021 12:58:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210212181738.79274-1-dwagner@suse.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210212_155833_575003_A095FDA2 
X-CRM114-Status: GOOD (  12.35  )
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
Cc: Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Hannes Reinecke <hare@suse.de>, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> blk_mq_tag_to_rq() will always return a request if the command_id is
> in the valid range. Check if the request has been started. If we
> blindly process the request we might double complete a request which
> can be fatal.

How did you get to this one? did the controller send a completion for
a completed/bogus request?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

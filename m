Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055DCC433ED
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 17:17:06 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929D16145E
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 17:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929D16145E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=EOJYkQNZ5j22pUzRBCN7PJTgd
	wxQNCUPphzcqVyemPcC8GJJ7AaGmth4OpBOQ1zpcxn4PIXpUqkXEkwoGOMUFHqBX/k3jdX/GxV4g9
	WzYYUu5hs9AACqteOkot7DDrWEGGJMYlts8SxHAAIxfKw9/iv3bDF+hgUMpScd2pDeoWBae+N18vw
	G+YM8Y1b9KKZUDgVFRhlEY8rsOYXSAtbeG6HS6w3jAcFnY28KM9+V1YLspdR3ID0OhSRwpqmCwkzW
	OXlFDM4lwU/PjCxQ6VcLzlAKYRb2OAxmJk8ErwzOhvU9g+wb1ZOpWywyTah8uyhUENW4QyPdqW54J
	MRS5/lO+A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lf45p-007efj-L2; Fri, 07 May 2021 17:16:50 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf45m-007efL-LA
 for linux-nvme@desiato.infradead.org; Fri, 07 May 2021 17:16:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=mQjR0Qch2HRs9vElSIBSU8y3eG
 9Zyw53e/yg5EZy02k6s8UuAc957eFf5cXg3hHBMRgZ89IwTidag6BVrJ2R6Am2WlXYdcRUo6BWNJG
 QtZK/ZG2qIMRR6nDBB2rXp6bgDW+7w9yKcrZ2N59l8ac6o39u+qThUHiCUSz8ReFvF45pLiaf0PMs
 A8EkC6wMlhC+IFg+hrC9UuKeq189ryE48eskPRb2qGVQ8tSGLMFgADslGqMpVh1ItfJzeD+S6qE1k
 qq0LqYQ9BaI3ppWuHAhqEXa0tkw1YJ6+wr2LxBZV4/q5lSSUXG6xTPTC8rvA3LqN/it6JLB9NvV19
 1YCmH0ZA==;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf45k-00726K-4w
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 17:16:45 +0000
Received: by mail-wr1-f43.google.com with SMTP id m9so10026197wrx.3
 for <linux-nvme@lists.infradead.org>; Fri, 07 May 2021 10:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=S1CTwcEb4guoA33rFSATwWoDL6gY4yHUMp+sDKtMMbEN+rEswL9cM5JT0W0RdVve10
 tlNhb+60csP+CcDJ1yWPFyQ4BLasSX9S+uKHgdR6iJrB+sIO4h3ncv/MiJNsTQ3rIS2l
 Ipv89ijfEG+/LzJCquv5bNctQCZhb63Gvfey0fGhIFtYhzfaLBDKauhjIeVEiTdnhinU
 pIo4CNn1ZMum6Yn7/O9Sk/A7nNSVsSjQixJ70ayoDqCxOiQT+KdujT0aNuiMX2Om5SEQ
 UiLsAsuxDXGEphKXm8G5ynYg9wcblrAWRD0gCzQaoxzZ0SLqa/dB/iyA1ekolCECvR6y
 50tw==
X-Gm-Message-State: AOAM5329Z20baLFU8umQVXQmkP/uDOCebJL/Ok7/H8GM8ElwdKBSTIkA
 US8jzdl1/tGtrMaFIzFMlfBsZkdsF2U=
X-Google-Smtp-Source: ABdhPJz8jNiQAEwF2chCh70uLZzqBvf9vHsXym5eXFL7v6Z1HWkyCjGSaVyW6JZqXMN5P0GSMAsn3w==
X-Received: by 2002:a05:6000:110d:: with SMTP id
 z13mr13739598wrw.92.1620407802047; 
 Fri, 07 May 2021 10:16:42 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:7945:4a4a:9424:5a3f?
 ([2601:647:4802:9070:7945:4a4a:9424:5a3f])
 by smtp.gmail.com with ESMTPSA id z14sm10295534wrt.54.2021.05.07.10.16.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 May 2021 10:16:41 -0700 (PDT)
Subject: Re: [PATCH] nvme-multipath: fix double initialization of ANA state
To: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, Martin Wilck <mwilck@suse.com>
References: <20210506134823.2566853-1-hch@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <0044d2db-3d83-97b4-ad28-2a7ee9531bcc@grimberg.me>
Date: Fri, 7 May 2021 10:16:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210506134823.2566853-1-hch@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210507_101644_214998_11BE1EE7 
X-CRM114-Status: UNSURE (   8.41  )
X-CRM114-Notice: Please train this message.
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

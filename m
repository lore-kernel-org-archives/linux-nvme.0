Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DA4C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 07:13:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3026E20823
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 07:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d2RmknDx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3026E20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=pShmxh9aENY7S8A5Ph9kHNgm/fsTJqC3nLnKXf6ABXE=; b=d2RmknDxHpKNENl1TDX+fKsJv
	c5yR9zd5R6uzXiEWzGEyoU8s/xip4gOl+ITVWWgYXOd0vpBdeEH0yX/M0lkH4XUmjO1fKPZfozaF5
	VB5PzL63ZB/jOyF69v/Ok59ncvDDDNy8FBIAB6G94mCHnob202TDr3uQJBW4f2dHwJUW4D0WK43Ek
	GPPBUsjAR3nzEgtWd23ZrWCwSs9R/MNN8vUMRZSDphduQgQfDQNYxs8MG82cCnSZJtXP9eOVgLJSO
	BwWmgzyFHh6uwlIwHwO9FCLu7wLvkhQCRctJeOl2lk44hEjT2ZChYnPZq18IqcoWBOTx7uZ46iPoW
	EyLjur4Og==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnzay-00080a-9Z; Wed, 24 Jun 2020 07:13:20 +0000
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnzat-0007zZ-BI
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 07:13:16 +0000
Received: by mail-pl1-f195.google.com with SMTP id k1so698982pls.2
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 00:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J9Hg64tjr7RLdz4MhQu3s8StRBe5reKB4vR48AzSL4U=;
 b=YMbRPVi4gYN3SjXiOaTTGvhZ+CQf4hBu3PaRqpVCUQE8MuQgKr/j5eYc7L17Z5+U1F
 L1iXAsCk6AUZcU+wd9AamP22ygZG1yo/lTLEsP+5xWQ17LoSClHQqH4rsexf2EoC2f4n
 IPsvOCHynrH+7kwXAv6XqbqychE+ngdgZPOr2RwlrpCilNAbr/JHQ663JQbbjtN7ENe8
 x0HMoDWy2uOeaKn4laVSsl034YhOHEcWIVGN3f5/rKPIUOvRKb27Ffh8oZ2iBe36ZzhX
 IBe67QXoYNi7F+clDEw/CHIKigwegrsUi7xVKvchJT9Y2jeAAltEJB0/Cm1cZLYSh9HH
 ErKw==
X-Gm-Message-State: AOAM530YChWlivC2rGKELg/aX7dZAKeTNLfAlY9ilMtadKLmEd9KpnAu
 6/CxS+1bk3Q2Hc1yNCNBaGU=
X-Google-Smtp-Source: ABdhPJzZzZlAIQhoXG0qTnrMOm0kCLmcG/LsunCj0qPsju9gYHEIiiIUB6mNLbA9fTxtlH2XSE4URA==
X-Received: by 2002:a17:90a:5218:: with SMTP id
 v24mr24336029pjh.223.1592982794374; 
 Wed, 24 Jun 2020 00:13:14 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9915:87a9:9728:63e?
 ([2601:647:4802:9070:9915:87a9:9728:63e])
 by smtp.gmail.com with ESMTPSA id z14sm19041653pfj.64.2020.06.24.00.13.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 00:13:13 -0700 (PDT)
Subject: Re: [PATCH v2 RFC 6/6] nvme-core: fix deadlock in disconnect during
 scan_work and/or ana_work
To: Christoph Hellwig <hch@lst.de>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-7-sagi@grimberg.me> <20200624064309.GG17594@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5511c107-6e75-32e3-4660-fa9705c1e7c6@grimberg.me>
Date: Wed, 24 Jun 2020 00:13:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624064309.GG17594@lst.de>
Content-Language: en-US
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
Cc: Keith Busch <kbusch@kernel.org>, Anton Eidelman <anton@lightbitslabs.com>,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>> From: Anton Eidelman <anton@lightbitslabs.com>
>>
>> A deadlock happens in the following scenario with multipath:
>> 1) scan_work(nvme0) detects a new nsid while nvme0
>>      is an optimized path to it, path nvme1 happens to be
>>      inaccessible.
>>
>> 2) Before scan_work is complete nvme0 disconnect is initiated
>>      nvme_delete_ctrl_sync() sets nvme0 state to NVME_CTRL_DELETING
>>
>> 3) scan_work(1) attempts to submit IO,
>>      but nvme_path_is_optimized() observes nvme0 is not LIVE.
>>      Since nvme1 is a possible path IO is requeued and scan_work hangs.
> 
> I'm really worried about another flag outside the state machine.  If
> we really need a multi-step deletion we should have
> NVME_CTRL_DELETE_START, NVME_CTRL_DELETE_CONT or so states and run
> this via the state machine.

Let me look into this, I'll send out v3 of the other 5 patches, and
will follow up with this as a follow on series. Going via the state
machine is slightly more delicate, but I agree that its a better
approach.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

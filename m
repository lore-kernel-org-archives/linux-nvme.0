Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D97C433DF
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:58:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2BC82072E
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 06:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rrg2IaNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BC82072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=hPo4BV7MUAbor0fvaHq//aPeIXszKGCh4b2P4uFjnKY=; b=rrg2IaNYVGI0651NjJIajTmD9
	AlRbwwPXKH7X0KF9HlAl/DYnsoZnlTdIdTZcCLe6F60VWhjZS0w2MT/QupgRPAkf5ryM862hnG6zf
	Vhg9bLYQQPcNa+UKGpmtaMoK8ijS2RJK8tcDGUDL/DjkZDxCSrpy9RzyRSLlkIVKaxESQl3SzYXku
	+YUP58vUoqSvYzrggrhF1rwk+cCZIrGgS/kDFcyCziT9yV7bYD+A+QNSsv04MNqQ2wBFAt/XCWQ7d
	tOO4OBb0h2b7V8+iEVxr0kDHzQ8KskAf2r9pAlRwCw0ZzNERXfbfwhF5JdgTLuWsr/6ErpI+Oli32
	d8Oi0wLvg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnzMs-0002Uj-Uh; Wed, 24 Jun 2020 06:58:46 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnzMn-0002SV-4Y
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 06:58:43 +0000
Received: by mail-pf1-f196.google.com with SMTP id p11so716229pff.11
 for <linux-nvme@lists.infradead.org>; Tue, 23 Jun 2020 23:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uofEowKK8SOWmCV9a5tR+IfBTg+MoBNYuxEzYHFvXRQ=;
 b=hjUFooiDo3zs0wkcHn3Ff//LtTY+Sv3JFFG0JTHmb7sIUFJXor+ViXqar+sxp0wbHA
 HZgp0tFHMaven0UgtH7AArfBih75w/2IBVHFKoEEcRodsQ7bBgBt1pbePRVuXw7YT4j0
 l9ALoplKLaWWpM1H6XNaLDpfqzdOoCoakDaPciI3IOsOkGGKivuOB+SgZcnRLfczemoK
 QlUxUOq8u9WVjztn+RCU+2iEzl0kxFS68XJ/+g3/YgEGADeZDGMh2RXCmZ6V8NJQNRca
 iKVZIla5fQAVQ67qFndfzwXlY3Zj5kmV5WiVx+pBt7rR5QXBkV9I1Z3CwXpXlOyybrNr
 TTSw==
X-Gm-Message-State: AOAM533FZlREKNFPbaorzvQMXJw49RG7JTMejF3Lzzy+pyGmbpSz6Puw
 MI9Qwi7wUAp95rXoGF1hiK8=
X-Google-Smtp-Source: ABdhPJy317x9LDl6qf+QskexFN9v4x3Dqy8utxxA8x4/U4VE+8Kox5KM/gyZ1z5Mq9zHlBvhaQsnCQ==
X-Received: by 2002:a62:fc92:: with SMTP id e140mr26931481pfh.33.1592981920021; 
 Tue, 23 Jun 2020 23:58:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:9915:87a9:9728:63e?
 ([2601:647:4802:9070:9915:87a9:9728:63e])
 by smtp.gmail.com with ESMTPSA id o207sm19652028pfd.56.2020.06.23.23.58.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jun 2020 23:58:39 -0700 (PDT)
Subject: Re: [PATCH v2 for-5.8-rc 3/6] nvme: don't protect ns mutation with
 ns->head->lock
To: Christoph Hellwig <hch@lst.de>
References: <20200624001853.5408-1-sagi@grimberg.me>
 <20200624001853.5408-4-sagi@grimberg.me> <20200624063719.GC17594@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <73c87564-fa2e-ded2-38b0-dbe34caf8a3f@grimberg.me>
Date: Tue, 23 Jun 2020 23:58:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624063719.GC17594@lst.de>
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


>> Right now ns->head->lock is protecting namespace mutation
>> which is wrong and unneeded. Move it to only protect
>> against head mutations. While we're at it, remove unnecessary
>> ns->head reference as we already have head pointer.
> 
> The changes look reasonable (nitpick below), but this changelog doesn't
> sway what the problem is and how it it fixed.
> 
>> -	synchronize_srcu(&ns->head->srcu);
>> -	kblockd_schedule_work(&ns->head->requeue_work);
>> +	synchronize_srcu(&head->srcu);
>> +	kblockd_schedule_work(&head->requeue_work);
>> +	mutex_unlock(&head->lock);
> 
> Can't we move the synchronize_srcu and kblockd_schedule_work out of
> the lock as well?

the requeue_work kick for sure, and I think also the synchronize given
that the actual critical section is protected...

Will fix.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

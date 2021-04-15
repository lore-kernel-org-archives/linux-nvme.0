Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFF1C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 18:17:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FC11610EA
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 18:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FC11610EA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FJcfh0dEo8I6ZvmMvBHNV5Oya6/o3Q0eO1uRC7x9LsI=; b=qvzZN6MLJSAPC2pOoKljo4b5+
	uTl+VSYyONYrt/aJ3euTJ/Z8jWd5K3AjmKxwss0RocsXNHvpve8YyqWqajBS7QHm3AyoOhEWQGRID
	LAeI7hwqenZfqqywV+uQAAzjNKmzBqTU2sxqMZolF/vftKisLFOl+mHAmTUSqtA+83YiP2FJGa2oZ
	JJ1v2UY9c4Z0E2LLNMHPRwT+6e/dONOBRlrlyEKDXWMHuZCpIjXweqxQPsKywLa535CUZSQowa0JY
	HWKPM2V1Ksmz5MuF72vcReEWTcSvakGKuN+lYOHqE0PYGBJTxZm5dbu45z+GYce7M7kLa0V9nygDP
	++fQ3jLaw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lX6Xy-00GxjL-6x; Thu, 15 Apr 2021 18:16:58 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX6Xv-00Gxj0-UC
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 18:16:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=EmddyHEcT+NsvuTUCO/46rQDysacIjAC5yzv7qkl4H8=; b=J959+ZnNI1Ant4IBMOACmMMqrt
 9P5iX3+IlzzQ5aZCHxB9gyEGWVNzUsmAFQC6tcyMVF9N3eZFZ6dflDvtK/o11cwFDgVRcitkgRjOn
 qlgueFxxLQNGvUkKaGdIfm6bQq1BzyxagW06Mn+7QoM3yqtEtpy9FtOwMwdkmUqI89AObRUuLJ74k
 2SHkY43weUNY4gqWrZPfDtNVGEbdJVyjjk27M6ujluuE7AReQSqL7WW3hUptyZIC5iL638PVmOFEL
 ahgyRmIBRYWdOa5P6RtjYHo4WLOehw3kr9a03rcZBwLhsvqebJiat/FLfE/TfGySDQz+ik6z6BWj4
 6s7m0g7Q==;
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lX6Xt-008o2e-1e
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 18:16:54 +0000
Received: by mail-pg1-x52a.google.com with SMTP id t22so17497703pgu.0
 for <linux-nvme@lists.infradead.org>; Thu, 15 Apr 2021 11:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EmddyHEcT+NsvuTUCO/46rQDysacIjAC5yzv7qkl4H8=;
 b=DiSuzCu7p5LOVQb1enqyFF8sF2CvJpyL75hzdVH46hpe7J75yM5jC5x8PZXBRb4Grr
 AHzVJJKdqsVDjHYcFcsyTRqV9Wi+SDjcG2XqSYrRqv+Z1Xbx/utNB6M5BXfH3LFaJfUP
 agWHO18GBKboiEQ7YYN2Nr1g16s5ZIImC9XK3iyiQdbwscXROEb6ARR1qP2RW4PlLTHM
 nRf/adis8WzMh/VdYj6TMaq+r5Xw7yUEzmM4cKL8JSD3vc+1AWzOkdOlOTY3ffEUTVO2
 n/YD2tXm0WXer8njO+F+k5uAC+1m0TJ4MvZL9X+Hcr3Eqfq1a1M2MCgZd2QyEXSpKSy9
 DONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EmddyHEcT+NsvuTUCO/46rQDysacIjAC5yzv7qkl4H8=;
 b=Oy6XE/mDg8JnTNAuITBSAaUKRVAm4bQgWjxH7GyibxT18LCIw2wWwgv/FA3zucrmUO
 GRux37Ucv3SWmEkmSeAK1WjJrSh5zjI5AaUxQ86bW8uNjTDUEHYAICmgAPrpptJ6zIiV
 VaZwcs8vvVknVldRuHCM58apKkARmwubfVT45THPbgfVNmvTVUVk6WPh8PuoR2r+66rQ
 7aHBZdxGjtMeFkyl1wa6DgnRyutxIpwZRsaxaBUN7pFSjcoYkcWnLnGT0nhwqLmd1xEE
 vNzeOI+xxWJLMV3m/2GdbfgZNgiZ3ua+r/bWeftK5rVLS6sZhj9Jn/OEDuNJOzuEJGtL
 VdEQ==
X-Gm-Message-State: AOAM532s1MgYYXfH/3bSoMKMs5jcCCK9//CHktHPLn7k9s5uckz3C0Us
 ohzVvpdF6AcO0cYwPL4yHB3UhxmdV5NTzA==
X-Google-Smtp-Source: ABdhPJzTUF9dDEKKdhXPG7UohtSD6ib3Kqkry2sYMGrjzMn2nPwEHYuoqcQVjwPLskstYV5ak3SCdA==
X-Received: by 2002:a05:6a00:2303:b029:249:b91e:72f0 with SMTP id
 h3-20020a056a002303b0290249b91e72f0mr4328105pfh.80.1618510610047; 
 Thu, 15 Apr 2021 11:16:50 -0700 (PDT)
Received: from ?IPv6:2620:10d:c085:21e8::1638? ([2620:10d:c090:400::5:6df0])
 by smtp.gmail.com with ESMTPSA id g12sm2671670pfo.114.2021.04.15.11.16.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Apr 2021 11:16:49 -0700 (PDT)
Subject: Re: [GIT PULL] second round of nvme updates for Linux 5.13
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YHhVrZD7/Q4qtFjL@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <01993453-41bf-8e1a-4b26-cb194e6b8e86@kernel.dk>
Date: Thu, 15 Apr 2021 12:16:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YHhVrZD7/Q4qtFjL@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_111653_121346_5176FD6A 
X-CRM114-Status: GOOD (  10.99  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/15/21 9:03 AM, Christoph Hellwig wrote:
> The following changes since commit f8ee34a929a4adf6d29a7ef2145393e6865037ad:
> 
>   lightnvm: deprecated OCSSD support and schedule it for removal in Linux 5.15 (2021-04-13 09:16:12 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.13-2021-04-15

Pulled, thanks.

-- 
Jens Axboe


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

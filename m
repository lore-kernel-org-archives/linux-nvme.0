Return-Path: <SRS0=wn7D=EC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E362FC4363A
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 21:08:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DB6A20738
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Oct 2020 21:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RPtJvheN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DB6A20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=EnlpFBr4ldsEYdTWBNvHAUFVmiRjTr9fPn7cEHVgDLQ=; b=RPtJvheNq3KgZkaIN/iO8kXTc
	aLVwI54qTi2qx47NT6dr7yrZqH8JRL0BGGCwMF8sTZMh8JOqXxcqiPV7TQAt2tWU3kEmI5Q3ZfjWu
	J5nf4D87JMngQP9zBAu+5UvmrMz4yb4wPvjwNUOUCWHGVUrjIZanFFPOvbsBud/TPWOhRL0RU9E7h
	pSdtcdZvGqyS3yK4DxN276qeriqvMNSi52UKC/GQ9t918EIOoT1UpL0nxQahUmrvs9HfSci3rHcM1
	WDdehI6j6qiCQFx4NnKQey/GewAePt9XfEBtA7/tHlTIy/eNTmNlar7I2UPV4LiUIlsynY0Mh4lV5
	t2vJ7jsFA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kXWCi-0006di-Dy; Tue, 27 Oct 2020 21:08:28 +0000
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kXWCe-0006cu-JW
 for linux-nvme@lists.infradead.org; Tue, 27 Oct 2020 21:08:25 +0000
Received: by mail-wm1-f65.google.com with SMTP id l20so1910467wme.0
 for <linux-nvme@lists.infradead.org>; Tue, 27 Oct 2020 14:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
 b=Ayb/ypeIakLGMX4a0C2Pu+BSGhfBeYOor5J56JDs8waHnnZy9XO1OnW2sa5D4Z53j5
 txpSjKFZL1kgXUPSa+M4UJYs2KOZGzuvq2+/Wn7PPtQtLtSjg1BNx2P0tx+N2MNX8WrM
 yum8Y5s3wRcJGz+ruFSDD9hFLPxkyl0zFgOONogKIT1LZwBcenRvcPCqFDNHGYfPMUP6
 eXi6wWBwEKeN6vc7dtRUYluS5OCXxs9N8Dwap3ObYkkadrGyKAfEmvR8iUKcckurlsbb
 CMMoyl+iejv9/c+XWIzicoMe/ESLuHAFL0MLVEMgATEg9NfMEijsLS/ojdjbK6FDFAHB
 pkCQ==
X-Gm-Message-State: AOAM532rtYfYLArFLwNoB5dZjS1neEv4Pf8f3hW80O4wum2jyWGSwUrt
 dVoN1O5AG/+RnygmRrqjFMI=
X-Google-Smtp-Source: ABdhPJxnlO6ffp5qWoU5jOtD133cQ5prG7Y2H4oyC2WTpcqYd3cQ2KUgy7rtjGlgdBJXSp8U9aC7qA==
X-Received: by 2002:a1c:6408:: with SMTP id y8mr4896067wmb.51.1603832899088;
 Tue, 27 Oct 2020 14:08:19 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:8235:3100:f389:bca1?
 ([2601:647:4802:9070:8235:3100:f389:bca1])
 by smtp.gmail.com with ESMTPSA id y201sm3336956wmd.27.2020.10.27.14.08.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2020 14:08:18 -0700 (PDT)
Subject: Re: [PATCH rdma v2] RDMA: Add rdma_connect_locked()
To: Jason Gunthorpe <jgg@nvidia.com>, linux-rdma@vger.kernel.org
References: <0-v2-53c22d5c1405+33-rdma_connect_locking_jgg@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <73296987-3f3e-7d39-b131-f93621d01851@grimberg.me>
Date: Tue, 27 Oct 2020 14:08:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0-v2-53c22d5c1405+33-rdma_connect_locking_jgg@nvidia.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201027_170824_791691_FCCC25B4 
X-CRM114-Status: GOOD (  10.62  )
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
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
 Guoqing Jiang <guoqing.jiang@cloud.ionos.com>, netdev@vger.kernel.org,
 Santosh Shilimkar <santosh.shilimkar@oracle.com>, rds-devel@oss.oracle.com,
 linux-nvme@lists.infradead.org, Chao Leng <lengchao@huawei.com>,
 Keith Busch <kbusch@kernel.org>, Jack Wang <jinpu.wang@cloud.ionos.com>,
 Leon Romanovsky <leonro@nvidia.com>, Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

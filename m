Return-Path: <SRS0=ggB5=DC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360B6C4363D
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 17:32:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7A82086A
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 17:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MSmkkHwo";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="kxdUTQL9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7A82086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VkHofCAOTUSKvWMQFJC46PAgrK91LzbG9Zw9dj0b63I=; b=MSmkkHwoSazk0GylvvodK/vPE
	yuIXNXEPooiXsybE6XEh4RRkgwOB7WgGWIW2prurWysfDWAVtLRgDyAZR8IHEluhxxCAV2gBLXoSy
	zDj3oO1qmMSV9UXDqdN2sb8ryswts8amAd4fHrpTHDVX1+1ddXTAt//70eGx1kO0w63DOiLhrqK33
	rnxH8R552/iF5cUlpMtHxWU63Z8aHtSbXt0AykkBoxSA5uYFNKwwUAUaLMuo/8Xh2ceRrQuL1SdZ6
	CnIGGbdcU8cswSW4rjjYbYv1Qw/jLK7t4qEop0bvimU4m6yzosid4Zf60f7WvK9PONgLNVfyy41nq
	RkLO5nsbg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLraR-0000cH-Kg; Fri, 25 Sep 2020 17:32:47 +0000
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLraP-0000bj-2A
 for linux-nvme@lists.infradead.org; Fri, 25 Sep 2020 17:32:45 +0000
Received: by mail-pf1-x443.google.com with SMTP id d9so3851409pfd.3
 for <linux-nvme@lists.infradead.org>; Fri, 25 Sep 2020 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=osandov-com.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7JdZOwNajZADBhYXXebotkbVCE8Ql50yJYKIetU2JdY=;
 b=kxdUTQL9oNaNJ2afy7XPuZXlK0JNgyl3hxKSlwh9zImhE5Phr44nqY7Yr0+xQ46mLM
 DJ+YelM5S2ikDFYWEsFPmvGjdjAPCfY1eBbnZnf2U0mBptNRl63eRhtj3Xm9oe6Ry9LY
 ZmTtf6vBdxCC1p4agjkggjqc3W6pY4C1kl1VZibBuAhHRQw9xT5Zl+4HdQnM0zLYREhG
 UMfzZWQ+KlxwwlCLDgd68I+m8MSDIkR1fHvRlR8dON9T19Toe277PpKfqjIuklbk8M9x
 lkxTz5L8ImPi9/g6s+Xl01CrOn54u8h5XUBgcrwwPS2KJAY/UyUFSo+GJ6DN/rvSJvVc
 tgqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7JdZOwNajZADBhYXXebotkbVCE8Ql50yJYKIetU2JdY=;
 b=O47Ygf7QquWPQf+H0t+CRbcW8j6G6/NG/anrerlaiRwSOFoD45rU1ITvfRPKIxXXkQ
 7w0QX6SLaoCE77sd8G0rNyvoywU5rUy+HDYE5IcgRPzE6syenPRLPkhOxiUCFiQtax1R
 J6fjLovQdcdOF4zcA+pe8TXozRKMrWgvXDizZSIMBL9w/y73e1Zja0I15x7dmSrlT0s3
 Sizj74WHvr7F+slBPG/KVZx5Vo5jsj1uzULJxTko2srKcHRvrT94F17/Gteo15v2QTn7
 1Fw7i7q26mDlPIh4DKajJSPI2KzGU51zpLt6rIbgrirV43tsXX/s+Bv/jXqLUkQVNrvU
 D3Ow==
X-Gm-Message-State: AOAM531VK53KJtV9JdXjr0x96V3rl+BlS6pIaK2eL4HGfgG1A8qZFPk2
 I+OqI1uOMRVJBBvgupvtfet7mg==
X-Google-Smtp-Source: ABdhPJzR7YQNVEEAc2HT8n4yCPTCkr4G67Y6chFZL1QNvJurmre0xRXB1OWT1h56sR2amsyG+tVM2g==
X-Received: by 2002:a63:2443:: with SMTP id k64mr23171pgk.259.1601055160821;
 Fri, 25 Sep 2020 10:32:40 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:77e2])
 by smtp.gmail.com with ESMTPSA id g21sm3390931pfh.30.2020.09.25.10.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 10:32:39 -0700 (PDT)
Date: Fri, 25 Sep 2020 10:32:37 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v7 0/7] blktests: Add support to run nvme tests with
 tcp/rdma transports
Message-ID: <20200925173237.GA689191@relinquished.localdomain>
References: <20200903235337.527880-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200903235337.527880-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200925_133245_110726_956332F9 
X-CRM114-Status: GOOD (  14.50  )
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
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 03, 2020 at 04:53:30PM -0700, Sagi Grimberg wrote:
> We have a collection of nvme tests, but all run with nvme-loop. This
> is the easiest to run on a standalone machine. However its very much possible
> to run nvme-tcp and nvme-rdma using a loopback network. Add capability to run
> tests with a new environment variable to set the transport type $nvme_trtype.
> 
> $ nvme_trtype=[loop|tcp|rdma] ./check nvme
> 
> This buys us some nice coverage on some more transport types. We also add
> some transport type specific helpers to mark tests that are relevant only
> for a single transport.

Applied, thanks Sagi.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

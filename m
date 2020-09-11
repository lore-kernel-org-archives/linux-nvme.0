Return-Path: <SRS0=9POq=CU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8AAC2BC11
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 17:34:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30170221E7
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Sep 2020 17:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NodHxLUG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0MR2/t5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30170221E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VkoAyTkH2n9s/gsLnDe3Bf51yvLGUEWr6G8sJkWczy0=; b=NodHxLUGNi9naWUNn+Ki7EkNL
	owkiZmoA/7tJ+bbnf0oOfpqxNXjOHAf9NnEsy1tHyeKurfLCYyjucjlCUTViKj4kmU2URAYWbJ1jr
	d7PAG+GxhN5DaKQEjt9m3zXd6Q8mg2PyHcE7pjuGgUzSsnwf/7VNZZ8BvNvqyLd7bxJ2tWZZ5U2S0
	eehCJX1RzkK53mGIMgR3QJ0tEbog1EldcMa7gmR7KSprWrgxlJ49u/mI9l1t3GA78YVHrnOZF1Vvo
	4S3OWO2PCl4DHrNxmM9UqqhHO3h2Hn861UKlQgznqX6Sgi9NQLBc47PqjcZDR/j2Ntm86iXqa9rOk
	Y7LbW50DA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGmvx-0003GQ-3m; Fri, 11 Sep 2020 17:34:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGmvu-0003FF-Dw
 for linux-nvme@lists.infradead.org; Fri, 11 Sep 2020 17:33:59 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 96866221EB;
 Fri, 11 Sep 2020 17:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599845637;
 bh=K/sYNBIpcDiYdKSYBvYLDBi5omik/y2CDgteLHwS3D0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=A0MR2/t5If5ED/X6HevHt50R2980ky9aiE1hVaMvTnhsF9V0SzMHTige6KGscBhmb
 XWufhL0CeFmyrBb4mKrv+HbJvw31nfxEy0yYxv4tZl6QhbZNxpmVCOWGb8EaNY7vgC
 ZdpwDhvuCvs67yDHgwcOw5dFsLnRyF7If5RZ8WOo=
Date: Fri, 11 Sep 2020 10:33:54 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH V5 0/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200911173354.GA3655155@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200911024117.62480-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200911024117.62480-1-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200911_133358_575252_B48BB307 
X-CRM114-Status: GOOD (  19.53  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Sep 11, 2020 at 10:41:13AM +0800, Ming Lei wrote:
> Hi Jens,
> 
> The 1st patch add .mq_quiesce_mutex for serializing quiesce/unquiesce,
> and prepares for replacing srcu with percpu_ref.
> 
> The 2nd patch replaces srcu with percpu_ref.
> 
> The 3rd patch adds tagset quiesce interface.
> 
> The 4th patch applies tagset quiesce interface for NVMe subsystem.
> 
> V5:
> 	- warn once in case that driver unquiesces its queue being
> 	  quiesce and not done, only patch 2 is modified
> 
> V4:
> 	- remove .mq_quiesce_mutex, and switch to test_and_[set|clear] for
> 	avoiding duplicated quiesce action
> 	- pass blktests(block, nvme)
> 
> V3:
> 	- add tagset quiesce interface
> 	- apply tagset quiesce interface for NVMe
> 	- pass blktests(block, nvme)
> 
> V2:
> 	- add .mq_quiesce_lock
> 	- add comment on patch 2 wrt. handling hctx_lock() failure
> 	- trivial patch style change
> 
> Ming Lei (3):
>   block: use test_and_{clear|test}_bit to set/clear QUEUE_FLAG_QUIESCED
>   blk-mq: implement queue quiesce via percpu_ref for BLK_MQ_F_BLOCKING
>   blk-mq: add tagset quiesce interface
> 
> Sagi Grimberg (1):
>   nvme: use blk_mq_[un]quiesce_tagset
> 
>  block/blk-core.c         |  13 +++
>  block/blk-mq-sysfs.c     |   2 -
>  block/blk-mq.c           | 182 +++++++++++++++++++++++++--------------
>  block/blk-sysfs.c        |   6 +-
>  block/blk.h              |   2 +
>  drivers/nvme/host/core.c |  19 ++--
>  include/linux/blk-mq.h   |  10 +--
>  include/linux/blkdev.h   |   4 +
>  8 files changed, 154 insertions(+), 84 deletions(-)
> 
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Cc: Chao Leng <lengchao@huawei.com>
> -- 

This looks good to me.

Reviewed-by: Keith Busch <kbusch@kernel.org>

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <SRS0=oc1E=F3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C596CC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 16:17:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DC0B22A83
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Dec 2020 16:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DC0B22A83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5GGRqqqDsmo7t9whQ+NWkPm4Z3JHwHNkzoyRUCjbSdY=; b=E6qYe2SwTg9DcJF7RsoZZJq1M
	pfTL74+aF5fLzEc2xtKIaTfGqR0RKvNG436HDZStyXf5FbB9M7u1cGOr03HvrhVgle+rT+ySGFd+0
	kaStUa+ZpkuUcPooskiK5aZ+/lHtbgbKRm1kKn7O/NXy8XDlSZnXr0mtlFZJshYBgfsypyYJfogoP
	+EIVjB9YrafSe5Aeq2bYgmZCv+CLmQw5NmO2xODuA7iXDspkA2dG9vyYAiL7vAUF541teRjSHEQa6
	+Nw2EySQpib02DnFluWD1FIhwfFzdyUQjeqm5zsIPez9GBlOMb57qk45A49Bc4J6kpAsWOYH6kYys
	FJ1Sj7yPQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ks6ou-0005kL-0B; Wed, 23 Dec 2020 16:17:00 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ks6or-0005jl-FI
 for linux-nvme@lists.infradead.org; Wed, 23 Dec 2020 16:16:58 +0000
Received: by mail-pl1-x631.google.com with SMTP id v3so9334935plz.13
 for <linux-nvme@lists.infradead.org>; Wed, 23 Dec 2020 08:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=R/XI3HACitxNNKdDGgHb+kOn5zfn0Owx8twC0nO/Nto=;
 b=cHBpe0rmEcvFesYRG+RYgq5Ek8r6gHYu+8GOChXrJ0L4IehMh/gk0CXI5fRzTlgwwz
 kGl6W6VAwAZgNAsnjqgT4j8CFE+NIQOHd4Cjl6U93RptnVVt8jJf8EUQNObUMj4Xaq/x
 Kiwj/ehm5DEEqq6hoCxcBFhu9XRhI1jxWpH4weolyQGkBTqEEprWAzq0I7qUuuyM5v5E
 rbJwRyvh5srP0ozWwsMd9nS0MOT/uib6hAAUgvQkQ48j40cgj0ZM464B92MCgLoxuMHP
 05fQOCL5f4NxpwUuCf3RVA8FEd5Mz6Q6BL9DuSeRedz/UQ3jd5NTPXxUIDqkcW6CC2Q7
 0e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=R/XI3HACitxNNKdDGgHb+kOn5zfn0Owx8twC0nO/Nto=;
 b=JI4khAQffWbLtqCA7inh56WX5H8l7iqUyeBKimq023RPfTKzkS82xs4+r1ER1xb1qW
 p7tjGbJ/AX0HKb/aYG7PHBUyEu7dLIyiOGV3bYSpXirBm6cTIi3OF55r8nATzzfz2GuO
 wfZBIcgoA9BKqEqcd52yCxI7vMl1WRw/9kOer1ARhu7OvalarrLM8P9CC3nFkjwxZvaB
 KzysRwmlhjiImrMLHqKgrmBu//6q6xymV/bKJojw7t39PcnIkZC7VtlmA9ez+WLTMgvE
 6c/7CKds/BGAFliSZwzTk2zvRiP7+eebMMYdFvfQRxHsL/knHjFFI4srl89vXTL97AXT
 7x6w==
X-Gm-Message-State: AOAM531lB3UKI8VklSTTUzwWwPL66TRDsAxPUzSDJeUZPIsMZnpAhVye
 YlBfNe+Neti+8VQ/rOL1XZU=
X-Google-Smtp-Source: ABdhPJzoiDr5W0ttuQgdEQzzISkxPt+rKaUM7wFPX0tNJy4ZBpORqyyZr0uMruqZcxGaDcIRdDdoJA==
X-Received: by 2002:a17:90a:a2e:: with SMTP id o43mr382325pjo.59.1608740212687; 
 Wed, 23 Dec 2020 08:16:52 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id z23sm15869038pfj.143.2020.12.23.08.16.51
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 23 Dec 2020 08:16:52 -0800 (PST)
Date: Thu, 24 Dec 2020 01:16:50 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC] nvme: set block size during namespace validation
Message-ID: <20201223161650.GA13354@localhost.localdomain>
References: <20201223150136.4221-1-minwoo.im.dev@gmail.com>
 <20201223154904.GA5967@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201223154904.GA5967@lst.de>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201223_111657_571375_67B26DE7 
X-CRM114-Status: GOOD (  17.71  )
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
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello,

On 20-12-23 16:49:04, Christoph Hellwig wrote:
> set_blocksize just sets the block sise used for buffer heads and should
> not be called by the driver.  blkdev_get updates the block size, so
> you must already have the fd re-reading the partition table open?
> I'm not entirely sure how we can work around this except by avoiding
> buffer head I/O in the partition reread code.  Note that this affects
> all block drivers where the block size could change at runtime.

Thank you Christoph for your comment on this.

Agreed.  BLKRRPART leads us to block_read_full_page which takes buffer
heads for I/O.

Yes, __blkdev_get() sets i_blkbits of block device inode via
set_init_blocksize.  And Yes again as nvme-cli already opened the block
device fd and requests the BLKRRPART with that fd.  Also, __bdev_get()
only updates the i_blkbits(blocksize) in case bdev->bd_openers == 0 which
is the first time to open this block device.

Then, how about having NVMe driver prevent underflow case for the
request->__data_len is smaller than the logical block size like:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ce1b61519441..030353d203bf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -803,7 +803,11 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
        cmnd->rw.opcode = op;
        cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
        cmnd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
-       cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+
+       if (unlikely(blk_rq_bytes(req) < (1 << ns->lba_shift)))
+               cmnd->rw.length = 0;
+       else
+               cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
        if (req_op(req) == REQ_OP_WRITE && ctrl->nr_streams)
                nvme_assign_write_stream(ctrl, req, &control, &dsmgmt);

Thanks,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

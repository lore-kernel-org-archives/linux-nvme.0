Return-Path: <SRS0=bcs0=GC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D6AC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Dec 2020 14:05:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A259221F8
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Dec 2020 14:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A259221F8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=NStBGjCfzVO3yfbNwDfiiP+lrIHfF+Zc/N3QNHDw1GA=; b=vBtn8fLUgFrk+uMPx/S9Dy+Rr
	MTE3Ibrs4sc/kiuDOV+LrOiduz37aCSkMF7LpkNNMgG1aOAIARUu7d1X8mRQNxO1i7pmoNSWW8WID
	t4HkOXumhXomG1uiUzJM5gg3RGpV/Wm5uQtxR2WrXaZVFPwq+P9y8jKehcYxYzxd7uNdvhEKLnCdh
	+gW4V3ywvM32X0ZF/uZb7GjNn+EBEiUBK9pYv/28PbdgCJxNBAJl1vVI320pJP3mgjnDu25HwauBv
	o2FjPNVgyKaCN50ktySWv/LXVFzeHNA0Ln6IlWdtv4gcmLa1/ZHx3eYuHg4pA2PhOqkZoDfuIjVHU
	7S83KXVQQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kuc6I-0005Qd-6C; Wed, 30 Dec 2020 14:05:18 +0000
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kuc69-0005Q7-Sf
 for linux-nvme@lists.infradead.org; Wed, 30 Dec 2020 14:05:14 +0000
Received: by mail-pf1-x431.google.com with SMTP id t22so9757247pfl.3
 for <linux-nvme@lists.infradead.org>; Wed, 30 Dec 2020 06:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=RznXSw7qxQXCa6AGnGmmtVifZFqLdwppqr0oE+H73IQ=;
 b=FiNo6uDsC8Fr0nL/oPoVOKzAGkk6h4ZY8XO2eOKKH32+LjhNXcma4jGLFZ50yQ2SJA
 e289avFGuWNFUkBP0NfwaUTY5lhlENek0BSSTXQ2hXFNECXxCajrTLj0yOOPsM+SNqLO
 QzC9j4//1IeOtOgsWgdLrDNZsWStVYdAcj6opbdYQykMWfwNozG1w8J/nfOdR4pmP8LW
 56C0fU6c1QyCSLwjAE8TrQtsrtrsQo32DpQzetO4y7Z16ZMCJ8iaMHfAQnBxKt6RyrBa
 +3f5BAihLHMb0mQCnxKX40ttERxcmdRUqd2zIxvS7d5xYT+KExPqDPux1dowkveOuxI1
 kudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=RznXSw7qxQXCa6AGnGmmtVifZFqLdwppqr0oE+H73IQ=;
 b=PW9q5enhYyGzP0LyKvEePdzffdQExACbGju9WvIpGZfYUnlZwIauDboYIIhys8Sovy
 kjfNcG9ouZJVIBB+zSpb+WIUIl2uUyv/aqg8vxwAR1AutzT84wQY/AX+yZzhI48iE1E4
 a9X4vuJvvKSPry9pOlMr5CDZJEZvFXzwQpQ5mLVBNZygU2R0lk8/VdM2/z1XHRkcJZ/H
 cHBFLTwU7vkqNvLXlBApYFLtd23hO6+QHxyTkcqL0wpagIAmVgQjF1fyoqFC3PGcW2em
 NmVbHmnEEJsF7iIxUriv/L3XCA5D2XQSa5elgm0rzSeaDXU8gZiASnVNNqsscgcAGg2G
 wOhQ==
X-Gm-Message-State: AOAM532q70GdsdIqGququa+wDvrM0q+sudFJuhGVF0c3PO3C1k2hV2gN
 Z+Ve2IJutHKU2LqqWg1xYEC/2JKcQcny7w==
X-Google-Smtp-Source: ABdhPJw8xRASTcrtl2r8MBKh8DGsaJWaLP8WYraJJ3sYSTpRzFpO8y4QbnJFKUNPqe8cPlCRiXdfqw==
X-Received: by 2002:a63:da58:: with SMTP id l24mr52102176pgj.178.1609337107580; 
 Wed, 30 Dec 2020 06:05:07 -0800 (PST)
Received: from localhost ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id b1sm7087859pjh.54.2020.12.30.06.05.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 30 Dec 2020 06:05:07 -0800 (PST)
Date: Wed, 30 Dec 2020 23:05:04 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [RFC] block: reject I/O in BLKRRPART if block size changed
Message-ID: <20201230140504.GB7917@localhost.localdomain>
References: <20201226180232.12276-1-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201226180232.12276-1-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201230_090509_972381_D75AC9A9 
X-CRM114-Status: GOOD (  23.81  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 20-12-27 03:02:32, Minwoo Im wrote:
> Background:
>   Let's say we have 2 LBA format for 4096B and 512B LBA size for a
> NVMe namespace.  Assume that current LBA format is 4096B and in case
> we convert namespace to 512B and 4096B back again:
> 
>   nvme format /dev/nvme0n1 --lbaf=1 --force  # to 512B LBA
>   nvme format /dev/nvme0n1 --lbaf=0 --force  # to 4096B LBA
> 
>   Then we can see the following errors during the BLKRRPART ioctl from
> the nvme-cli format subcommand:
> 
>   [   10.771740] blk_update_request: operation not supported error, dev nvme0n1, sector 0 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
>   [   10.780262] Buffer I/O error on dev nvme0n1, logical block 0, async page read
>   ...
> 
>   Also, we can see the Read commands followed by the Format command due
> to BLKRRPART ioctl with Number of LBAs to 65535(0xffff) which is
> under-flowed because the request for the Read commands are coming with
> 512B and this is because it's playing around with i_blkbits from the
> block_device inode which needs to be avoided as [1].
> 
>   kworker/0:1H-56      [000] ....   913.456922: nvme_setup_cmd: nvme0: disk=nvme0n1, qid=1, cmdid=216, nsid=1, flags=0x0, meta=0x0, cmd=(nvme_cmd_read slba=0, len=65535, ctrl=0x0, dsmgmt=0, reftag=0)
>   ksoftirqd/0-9       [000] .Ns.   916.566351: nvme_complete_rq: nvme0: disk=nvme0n1, qid=1, cmdid=216, res=0x0, retries=0, flags=0x0, status=0x4002
>   ...
> 
>   Before we have commit 5ff9f19231a0 ("block: simplify
> set_init_blocksize"), block size used to be bumped up to the
> 4K(PAGE_SIZE) in this example and we have not seen these errors.  But
> with this patch, we have to make sure that bdev->bd_inode->i_blkbits to
> make sure that BLKRRPART ioctl pass proper request length based on the
> changed logical block size.
> 
> Description:
>   As the previous discussion [1], this patch introduced a gendisk flag
> to indicate that block size has been changed in the runtime.  This flag
> is set when logical block size is changed in the runtime with sector
> capacity itself.  It will be cleared when the file descriptor for the
> block devie is opened again which means __blkdev_get() updates the block
> size via set_init_blocksize().
>   This patch rejects I/O from the path of add_partitions() and
> application should open the file descriptor again to update the block
> size of the block device inode.
> 
> [1] https://lore.kernel.org/linux-nvme/20201223183143.GB13354@localhost.localdomain/T/#t
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>

Hello,

Sorry for the noises here.  Please ignore this patch.  Will try to
prepare a new one for this issue.

Thanks,

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

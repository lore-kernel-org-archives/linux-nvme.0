Return-Path: <SRS0=v579=XM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE36C4CEC9
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 23:45:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EEE42054F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Sep 2019 23:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HOyGQ4WA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j++T2+zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EEE42054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RX4zjosWRLciQAVr71LVohFpHiyOT8VoKhaB/j0QNkk=; b=HOyGQ4WAM09yNO
	kKZk0XDF3CBhS7SoLr9NdFGN4NLlPOO1jO0wwYvLBRvPQmbpBOvhKfHvOqFnZ3BAme5Q6gx0b+6R9
	s3Hxvwhgna6wsdhmYNETboSqiL6KR61uE+NC0kIkyoTWw9AA4EYkn6cmau0M8nmuXoR3ccKK17dVg
	oMK6ElLCxnViFaow0UBKo9KeovlN4pzZmsKVdo0Qfr8c5m5DIBjxIwQGowRZZ4JdUHa5EJ8TBoVXk
	/uhL5BJhqCImD1Frd4jIXHY841+C/Hl4MJNdOV8MOEkMnRR0X4w0Gd2zW25S3WTit+VFZ33giksGB
	ZnpqsGssH4R6rLXNKKfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iANAA-0002Hg-Rc; Tue, 17 Sep 2019 23:45:38 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iANA7-0002HK-Lk
 for linux-nvme@lists.infradead.org; Tue, 17 Sep 2019 23:45:37 +0000
Received: from keith-busch (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C18A2206C2;
 Tue, 17 Sep 2019 23:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568763935;
 bh=+hz8kISpaGmrCv5P1SzuxdB0GQ6swEzsB5aXsXjoGPU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j++T2+znHpZEoefuwJFqX8aasgvxAWpa9IdkgrUn3bqyd2JSxmBph2G9JvczTXAvh
 9wk0XvU/TQdK6uDIgU5Wb91OLtLYbS6HZHiEmywnA/i8KLjnqcC9H9C7vWggsyKnf0
 8p7M9S6WKLG8ARtLU1Hga5Z606FBd9IJtekk8mXc=
Date: Tue, 17 Sep 2019 17:45:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Balbir Singh <sblbir@amzn.com>
Subject: Re: [PATCH v3 1/2] nvme/host/pci: Fix a race in controller removal
Message-ID: <20190917234531.GA17026@keith-busch>
References: <20190917224105.6758-1-sblbir@amzn.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190917224105.6758-1-sblbir@amzn.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190917_164535_751505_65521CC5 
X-CRM114-Status: GOOD (  23.97  )
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
Cc: axboe@fb.com, hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 17, 2019 at 10:41:04PM +0000, Balbir Singh wrote:
> This race is hard to hit in general, now that we
> have the shutdown_lock in both nvme_reset_work() and
> nvme_dev_disable()
> 
> The real issue is that after doing all the setup work
> in nvme_reset_work(), when get another timeout (nvme_timeout()),
> then we proceed to disable the controller. This causes
> the reset work to only partially progress and then fail.
> 
> Depending on the progress made, we call into
> nvme_remove_dead_ctrl(), which does another
> nvme_dev_disable() freezing the block-mq queues.
> 
> I've noticed a race with udevd with udevd trying to re-read
> the partition table, it ends up with the bd_mutex held and
> it ends up waiting in blk_queue_enter(), since we froze
> the queues in nvme_dev_disable(). nvme_kill_queues() calls
> revalidate_disk() and ends up waiting on the bd_mutex
> resulting in a deadlock.
> 
> Allow the hung tasks a chance by unfreezing the queues after
> setting dying bits on the queue, then call revalidate_disk()
> to update the disk size.
> 
> NOTE: I've seen this race when the controller does not
> respond to IOs or abort requests, but responds to other
> commands and even signals it's ready after its reset,
> but still drops IO. I've tested this by emulating the
> behaviour in the driver.

I recommend the following changelog for this commit:

  User space programs like udevd may try to read to partitions at the
  same time the driver detects a namespace is unusable, and may deadlock
  if revalidate_disk() is called while such a process is waiting to
  enter the frozen queue. On detecting a dead namespace, move the disk
  revalidate after unblocking dispatchers that may be holding bd_butex.

And that's it.
 
> Signed-off-by: Balbir Singh <sblbir@amzn.com>
> ---
> 
> Changelog v3
>   1. Simplify the comment about moving revalidate_disk
> Changelog v2
>   1. Rely on blk_set_queue_dying to do the wake_all()
> 
>  drivers/nvme/host/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index b45f82d58be8..6ad1f1df9e44 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -103,10 +103,13 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
>  	 */
>  	if (!ns->disk || test_and_set_bit(NVME_NS_DEAD, &ns->flags))
>  		return;
> -	revalidate_disk(ns->disk);
>  	blk_set_queue_dying(ns->queue);
>  	/* Forcibly unquiesce queues to avoid blocking dispatch */
>  	blk_mq_unquiesce_queue(ns->queue);
> +	/*
> +	 * Revalidate after unblocking dispatchers that may be holding bd_butex
> +	 */
> +	revalidate_disk(ns->disk);
>  }
>  
>  static void nvme_queue_scan(struct nvme_ctrl *ctrl)
> -- 
> 2.16.5
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

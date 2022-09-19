Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9B0ECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Sep 2022 17:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KGInNetjF+7vl6b4xWiryqiOKapTk5YDeUOTrBtwbA0=; b=YCnoc85rS5pl60YKdjXkEMf647
	sIodkVSr8ndajO5K3HO6giTufSzaGzpK//JoV1Ul04t7JgRkLtbS2l/WFeWhTEIZTH0yWCiLfwpC4
	W8LFK2c45tAkhndDqoYUQzXJmxwZtl1yW+RezaCq1S5ca//Mk1tOxXoowfdpf/9yEfCOGYukqcpuT
	b3Drx0C227y5hHp5NcXY53lEPMowy+Es9l0vV5wZx2jZn+EAC/+3PARTQnotYnBBvGKutTAF7iHZs
	ZlKo6JTN1qPg/fn4TCxjit2VBZCLQpQgDSwmfBuuZILOkLxKM3BTb/vuFU5MA+CyW2pm8EWeOW4HZ
	dbVMTqLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaKfw-00DJp6-8J; Mon, 19 Sep 2022 17:35:20 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaKfs-00DJmN-4L
	for linux-nvme@lists.infradead.org; Mon, 19 Sep 2022 17:35:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 05601B81F0D;
	Mon, 19 Sep 2022 17:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AE3C433C1;
	Mon, 19 Sep 2022 17:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1663608912;
	bh=Qn6lr5IB3mFwwVXJMM+ZIl3PLXb1MwJ4yPUQA0hFbmM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8/FKIAiuBZAp10nMBMVg2zTLKneDQZrw9lgelOHFRDdgy732FgfhrjZKhcwdyYA1
	 G/TCJjptG4/uYRAt0oauQE7zpHbC0LZvAz0aPx/23soZNCQf5KBA0+AXak/laXnrZP
	 fa7Z2Rnqn9lAV0tS+HvIYF/8bTSxG+RpbYn3JVn6refrGDAlbxN1bIzsFQktiUSA4g
	 tb1RwHs0TnnxJrkofLCFP9R4cZMaC+DTwAugizfGt4Wn/O205zFQx+lF0ny+oBSH0W
	 4zPLeP87aa3Z3g1iSJUVP3DqybE1JxvgtVvCUaLIAZi27VfxLO3dIhlCh/RRuNATHv
	 jmdtOKdwUS75A==
Date: Mon, 19 Sep 2022 11:35:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: stable@vger.kernel.org, Eric Badger <ebadger@purestorage.com>,
	Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Tao Chiu <taochiu@synology.com>,
	Leon Chien <leonchien@synology.com>,
	Cody Wong <codywong@synology.com>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-pci: Make sure to ring doorbell when last request
 is short-circuited
Message-ID: <YyioTUV/Td+yf0Z6@kbusch-mbp>
References: <20220918054816.936669-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918054816.936669-1-mkhalfella@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220919_103516_497873_EC697A7E 
X-CRM114-Status: GOOD (  22.70  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Sep 18, 2022 at 05:48:16AM +0000, Mohamed Khalfella wrote:
> When processing a batch of requests, it is possible that nvme_queue_rq()
> misses to ring nvme queue doorbell if the last request fails because the
> controller is not ready. As a result of that, previously queued requests
> will timeout because the device had not chance to know about the commands
> existence. This failure can cause nvme controller reset to timeout if
> there was another App using adminq while nvme reset was taking place.
> 
> Consider this case:
> - App is hammering adminq with NVME_ADMIN_IDENTIFY commands
> - Controller reset triggered by "echo 1 > /sys/.../nvme0/reset_controller"
> 
> nvme_reset_ctrl() will change controller state to NVME_CTRL_RESETTING.
> From that point on all requests from App will be forced to fail because
> the controller is no longer ready. More importantly these requests will
> not make it to adminq and will be short-circuited in nvme_queue_rq().
> Unlike App requests, requests issued by reset code path will be allowed
> to go through adminq in order to carry out the reset process. The problem
> happens when blk-mq decides to mix requests from reset code path and App
> in one batch, in particular when the last request in such batch happens
> to be from App.
> 
> In this case the last request will have bd->last set to true telling the
> driver to ring doorbell after queuing this request. However, since the
> controller is not ready, this App request will be completed without going
> through adminq, and nvme_queue_rq() will miss the opportunity to ring
> adminq doorbell leaving earlier queued requests unknown to the device.
> 
> Fixes: d4060d2be1132 ("nvme-pci: fix controller reset hang when racing with nvme_timeout")

I revisted that commit, and it doesn't sound correct. Specifically this part:

    5) reset_work() continues to setup_io_queues() as it observes no error
       in init_identify(). However, the admin queue has already been
       quiesced in dev_disable(). Thus, any following commands would be
       blocked forever in blk_execute_rq().

When a timeout occurs in the CONNECTING state, the timeout handler unquiesces
the queue specifically to flush out any blocked requests. Is that commit really
necessary? I'd rather just revert it to save the extra per-IO checks if not.


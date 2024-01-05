Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EDBC3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 18:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
	List-Owner; bh=51r8kqImCNK1WxC6YzCqnxMtcv7632DYgTxhlUSkrVY=; b=OnHHxRxEk18Vls
	ySk+0I/fcxDhUAl/PfXqu4yVyTSLLP2LfLqgq28KYxpVEpFcKY8unsS2YiBZpMUL70Vk6DmG0NZEA
	3Jm3C1U3ta5/q0ULpeZMeKKJOH1dVkqavjWg3gEZonudMwz44Ef/p01fT+w7q+ZEZdHwer7+WXIkw
	bKCOqrCh0qWYmzSkc2sLcnOP4rlYbLCzop3pb/ThyNVzSJmor96Q3VFN3dOViHBNYdMY5XGNVOpLv
	z5dhQjPq+r+g4lM1P+zyZMwarhVgED6gafTSls6x2naUIcgWceKT1LzJHB2ug8zfrifyReDGKEqYP
	2WH2h5fArLRF8nwbYdVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLoj7-00HWmC-01;
	Fri, 05 Jan 2024 18:15:25 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLoj3-00HWlg-1X
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 18:15:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id 04028B81C13;
	Fri,  5 Jan 2024 18:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EB5C433C7;
	Fri,  5 Jan 2024 18:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704478519;
	bh=zGC3Degk55lW24BOwfuHWWAyRMSh0GDcsuh8CT1tk0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=u6hu8/UFBgnXHpk08b1V4Mwf8z0zDYC1kp2X83SDUkcYV3C8GLBj3MOr3AvRdKIWK
	 osB5auRGgumL7ucJe4HpMF3SivTKEWNMOZUfpcyjG1UE0xS1bmQQjaw+9zh7hVIUMD
	 41hdx+iPvTsRDRGIicScn8UR84G6wZNRFm36sZLlTMCMdQilJgohkkfwiUtpVe0XoG
	 8svmY+XOl203IKAb/Ao59adWBuCyWyvZMlpcCtSiz4H1/cDrN0e363tPXyNe9ClAtB
	 VCOOvoKpnPIq5yLt0zgGaEGedd84eF/AMmuygOneGFX/yEpylLrtpAjZJgY+kWdTp9
	 en1t2awGE5u9w==
Date: Fri, 5 Jan 2024 12:15:17 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jeremy Allison <jra@samba.org>, Jeremy Allison <jallison@ciq.com>,
	tansuresh@google.com, gregkh@linuxfoundation.org, rafael@kernel.org,
	bhelgaas@google.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/4] driver core: Support two-pass driver shutdown
Message-ID: <20240105181517.GA1861750@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240105042955.GC23630@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_101521_803670_4C0653B8 
X-CRM114-Status: GOOD (  19.85  )
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

On Fri, Jan 05, 2024 at 05:29:55AM +0100, Christoph Hellwig wrote:
> On Tue, Jan 02, 2024 at 10:07:30AM -0800, Jeremy Allison wrote:
> >> But I'm not a workqueue expert and I do see the scary warning at
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/workqueue.h?id=v6.6#n619,
> >> about not flushing system-wide workqueues, so maybe this wouldn't be
> >> workable.
> >
> > This is a bigger change than I'm comfortable with
> > (or indeed understand :-) right now. Can we fix
> > the immediate problem first please and then look
> > for improvements later ?
> 
> It's also a lot less efficient.  Assuming NVMe isn't alone and other
> hardware interfaces also have a shutdown/disable busy wait (and I've seen
> quite a few that do) as their limiting factor the two-pass shutdown seems
> much nicer than spawning tons of work items.

Here's the essence of the two-pass proposal, adding .shutdown_wait():

    device_shutdown
      for_each_device
        dev->bus->shutdown()
          ...
            nvme_shutdown
              nvme_disable_prepare_reset
                nvme_dev_disable
                  nvme_disable_ctrl
  +                 case NVME_DISABLE_SHUTDOWN_ASYNC:
  +                   return;
  +                 case NVME_DISABLE_SHUTDOWN_SYNC:
                      nvme_wait_ready(...);
  +     if (dev->bus->shutdown_wait)
  +       list_add(&shutdown_wait_list)
  +
  +   for_each(&shutdown_wait_list)
  +     dev->bus->shutdown_wait()
  +       pci_device_shutdown_wait
  +         nvme_shutdown_wait
  +           nvme_wait_ready(...)

FWIW, what I imagined was something like this, where we don't add
.shutdown_wait(), but any .shutdown() method could become asynchronous
by queuing a work item to do the wait:

  + nvme_wait_ready_work
  +   nvme_wait_ready(...)

    device_shutdown
  +   async_shutdown_wq = create_workqueue("async_shutdown");
      for_each_device
        dev->bus->shutdown()
          ...
            nvme_shutdown
              nvme_disable_prepare_reset
                nvme_dev_disable
                  nvme_disable_ctrl
  +                 case NVME_DISABLE_SHUTDOWN_ASYNC:
  +                   queue_work(async_shutdown_wq, &nvme_wait_ready_work)
  +                   return;
  +                 case NVME_DISABLE_SHUTDOWN_SYNC:
                      nvme_wait_ready(...);
  +
  +   destroy_workqueue(async_shutdown_wq);

This is a bit of hand waving because I'm not a workqueue expert, but
it seems like basically the same amount of overhead without having to
add .shutdown_wait() to the bus_type and the pci_driver.

Bjorn


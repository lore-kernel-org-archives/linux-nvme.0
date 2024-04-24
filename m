Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BFFBC4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 17:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aGqRiKMfdZPnjEDXUfa8ZAD2wrT/CUopQGvHah0umvw=; b=RDIjFLRxqVaS4bMtC9sottMYVX
	BljgDjndK4zIT5AziqJysUZEFEDRRxg5mDBXtGL5fbj65JXLKkgnFDMOVVP75fCQjCzbCypRtr0GD
	ej065IxBXW4htshlRi4CijMA1QDY2oeSkLvhHvFjAZel3LnWDVnrU1mQtJS+EGrOdWT/sNLK3laQ3
	o/OR6ff8KZPqP46DQPWKC83H62ElT2bY6/ajKiHrSJ6YWKvxgGZxQZsDcYpoY5tpbYnYPPedaQ5Tg
	+rod4Y59fP0MXAJiuEIiL33F7zJHKuRJsJD7qN9lktQ3tq8ttYomtZHJeHxCY4Qz6vmIB6APgRyt2
	kQSD8DnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzgXX-000000058d0-0QD9;
	Wed, 24 Apr 2024 17:36:15 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzgXO-000000058aR-0eN7
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 17:36:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8C0C561C43;
	Wed, 24 Apr 2024 17:36:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE03CC32781;
	Wed, 24 Apr 2024 17:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713980165;
	bh=9RKj1vuXLytGq+7ALQi+JoH5F8pHV0MOFMG5SicT6rQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WI6NpS2RLWiaSyiuNFY6jvy04CFEd7Nbag1Vhne4RSFQ80t5gtae6LRhKqChxAu4y
	 yh8uYBBMljPRdyaB+rf7zqpGnaxZ9xFopC/TfvXJ72LKPjlX3Arn/PKK2PRotaEN4W
	 WzB6OrWGkakAob3/Z5hNU3KLAbmWnWnDcQvORzsUKRAokCgEhGrTvcZc2J+cxX/2pN
	 4yiNY8IeYp812Hv9xX6DYVGVGno9yK9WsDe9cGyB/8XnO2FAR2QxZzfEruwLESUTk2
	 AJwmAFahJMH5rkM5ugQFAYn5Y73a3kpeVWGhKaZSkZqGc5qblf7sbv9+u1G0lF55ql
	 3ILVtZj6OsIYQ==
Date: Wed, 24 Apr 2024 11:36:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
	Gregory Joyce <gjoyce@ibm.com>,
	Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>
Subject: Re: [Bug Report] PCIe errinject and hot-unplug causes nvme driver
 hang
Message-ID: <ZilDAv9y3dSzTPKb@kbusch-mbp.dhcp.thefacebook.com>
References: <199be893-5dfa-41e5-b6f2-40ac90ebccc4@linux.ibm.com>
 <579c82da-52a7-4425-81d7-480c676b8cbb@grimberg.me>
 <d33a5681-b195-4258-8eee-e0eae46ade5b@linux.ibm.com>
 <627cdf69-ff60-4596-a7f3-0fdd0af0f601@grimberg.me>
 <ZiZrmSW6s7lY7j98@kbusch-mbp.dhcp.thefacebook.com>
 <ZiZ1mB0pE6lBrJkN@kbusch-mbp.dhcp.thefacebook.com>
 <2e10ca7f-0da8-47e4-9bfb-4a6cbf4abaec@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e10ca7f-0da8-47e4-9bfb-4a6cbf4abaec@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_103606_400322_C86BEAD5 
X-CRM114-Status: GOOD (  30.20  )
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

On Tue, Apr 23, 2024 at 03:22:46PM +0530, Nilay Shroff wrote:
> > 
> I tested the above patch, however, it doesn't help to solve the issue.
> I tested it for two cases listed below:
> 
> 1. Platform which doesn't support pci-error-recovery:
> -----------------------------------------------------
> On this platform when nvme_timeout() is invoked, it falls through 
> nvme_shoud_reset()
>   -> nvme_warn_reset() 
>     -> goto disable
> 
> When nvme_timeout() jumps to the label disable, it tries setting the
> controller state to RESETTING but that couldn't succeed because the 
> (logical) hot-unplug/nvme_remove() of the disk is started on another 
> thread and hence controller state has already changed to 
> DELETING/DELETING_NOIO. As nvme_timeout() couldn't set the controller 
> state to RESETTING, nvme_timeout() returns BLK_EH_DONE. In summary, 
> as nvme_timeout() couldn't cancel pending IO, the hot-unplug/nvme_remove() 
> couldn't forward progress and it keeps waiting for request queue to be freezed. 
> 
> 2. Platform supporting pci-error-recovery:
> ------------------------------------------
> Similarly, on this platform as explained for the above case, when 
> nvme_timeout() is invoked, it falls through nvme_shoud_reset()
> -> nvme_warn_reset() -> goto disable. In this case as well, 
> nvme_timeout() returns BLK_EH_DONE. Please note that though this 
> platform supports pci-error-recovery, we couldn't get through 
> nvme_error_detected() because the pci-error-recovery thread is pending 
> on acquiring mutex "pci_lock_rescan_remove". This mutex is acquired by 
> hot-unplug thread before it invokes nvme_remove() and nvme_remove() 
> is currently waiting for request queue to be freezed. For reference,
> I have already captured the task hang traces in previous email of this 
> thread where we could observe these hangs (for both pci-error-recovery
> thread as well as hot-unplig/nvme_remove()).
> 
> I understand that we don't want to cancel pending IO from the nvme_remove()
> unconditionally as if the disk is not physically hot-unplug then we still 
> want to  wait for the in-flight IO to be finished. Also looking through 
> the above cases, I think that the nvme_timeout() might be the code path 
> from where we want to cancel in-flight/pending IO if controller is 
> in the terminal state (i.e. DELETING or DELETING_NOIO). Keeping this idea in
> mind, I have worked out the below patch:
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8e0bb9692685..e45a54d84649 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1286,6 +1286,9 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>         u32 csts = readl(dev->bar + NVME_REG_CSTS);
>         u8 opcode;
>  
> +       if (nvme_state_terminal(&dev->ctrl))
> +               goto disable;
> +
>         /* If PCI error recovery process is happening, we cannot reset or
>          * the recovery mechanism will surely fail.
>          */
> @@ -1390,8 +1393,13 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
>         return BLK_EH_RESET_TIMER;
>  
>  disable:
> -       if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
> +       if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> +               if (nvme_state_terminal(&dev->ctrl)) {
> +                       nvme_dev_disable(dev, false);
> +                       nvme_sync_queues(&dev->ctrl);
> +               }
>                 return BLK_EH_DONE;
> +       }
>  
>         nvme_dev_disable(dev, false);
>         if (nvme_try_sched_reset(&dev->ctrl))
> 
> I have tested the above patch against all possible cases. Please let me know
> if this looks good or if there are any further comments.

This looks okay to me. Just a couple things:

Set nvme_dev_disable's "shutdown" parameter to "true" since we're
restarting the queues again from this state.

Remove "nvme_sync_queues()". I think that would deadlock: sync_queues
waits for the timeout work to complete, but your calling it within the
timeout work, so this would have it wait for itself.


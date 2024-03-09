Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A804C54798
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Mar 2024 15:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xiakcnEKlLE3EOR/MsIJ6R8d5lRq43OggW2L3tVD3dg=; b=PagWqe2T7Utx032vbWUev1InIQ
	q6NTcBLcDRxjGrH6JeT5RQxK1TMFYitpq92t/1WxznsDt1jr7keRiRjbg9MrZXXOn+TlMuyjHR0/H
	x5sHKwptb/CGV3roTgVauyy13WDxh2vl2JO4SnV77X6rpR5zvGoZH1dWfaae/eMqV01JoMFRz85no
	ksF9RjnUWnRLN+K6C5OCF/tZjJw3ctHfInyEdJocBXCrE9WF5OFwL2HRRSxuh/wIdQgTebmw+EEn9
	+PIMGoFHYw+ACknCIfnVirBKtbFokVSaDn4WP0Z6xJEV8UVEjBq/Qs9E3qi1XxxDiM/tTVknYutu9
	9jDErkAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riysW-0000000DfTK-3kse;
	Sat, 09 Mar 2024 15:44:52 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riysS-0000000DfSb-0tny
	for linux-nvme@lists.infradead.org;
	Sat, 09 Mar 2024 15:44:49 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9DCDFCE08D5;
	Sat,  9 Mar 2024 15:44:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0E8C433C7;
	Sat,  9 Mar 2024 15:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709999084;
	bh=VZsXXTUSj/JDReSTYBKOjQI1AU+mVebl4b3iPGykouc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uBd+JR6s82/anAEEAdDycO6fddsL7fpaQ0+/8moOtI+rYUaQ843sD15SbzWfvptiB
	 PhpHtLPjIXtcpSpzUZKlUD3YHAy7HRC9QXzlJhEJiTZvmlbWVMC80LUNaTR83UDezH
	 TI089oBJFJPdBq3HShZhDvteaarINb088wOsoMaywe9+tMLmMw3H2tGUpD4dhKRK3y
	 YdZ7et5mrGV7b1uJnuo0xifEw6EnMNgmb22sKSeTz/4gnCBL01aOvQZ7IbiI83pM3T
	 DaGumfUhxZG6poP35/Da3PrYKzxWeXkP6s0MTKZdMQeUXA+ubWbfV/rVwZW953OW14
	 GBNezcsa4INYg==
Date: Sat, 9 Mar 2024 08:44:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH RESEND] nvme-pci: Fix EEH failure on ppc after subsystem
 reset
Message-ID: <ZeyD6xh0LGZyRBfO@kbusch-mbp>
References: <20240209050342.406184-1-nilay@linux.ibm.com>
 <Zesxq81eJTnOGniB@kbusch-mbp>
 <039541c8-2e13-442e-bd5b-90a799a9851a@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <039541c8-2e13-442e-bd5b-90a799a9851a@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240309_074448_476078_948DDA44 
X-CRM114-Status: GOOD (  22.15  )
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

On Sat, Mar 09, 2024 at 07:59:11PM +0530, Nilay Shroff wrote:
> On 3/8/24 21:11, Keith Busch wrote:
> > On Fri, Feb 09, 2024 at 10:32:16AM +0530, Nilay Shroff wrote:
> >> @@ -2776,6 +2776,14 @@ static void nvme_reset_work(struct work_struct *work)
> >>   out_unlock:
> >>  	mutex_unlock(&dev->shutdown_lock);
> >>   out:
> >> +	/*
> >> +	 * If PCI recovery is ongoing then let it finish first
> >> +	 */
> >> +	if (pci_channel_offline(to_pci_dev(dev->dev))) {
> >> +		dev_warn(dev->ctrl.device, "PCI recovery is ongoing so let it finish\n");
> >> +		return;
> >> +	}
> >> +
> >>  	/*
> >>  	 * Set state to deleting now to avoid blocking nvme_wait_reset(), which
> >>  	 * may be holding this pci_dev's device lock.
> >> @@ -3295,9 +3303,11 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
> >>  	case pci_channel_io_frozen:
> >>  		dev_warn(dev->ctrl.device,
> >>  			"frozen state error detected, reset controller\n");
> >> -		if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> >> -			nvme_dev_disable(dev, true);
> >> -			return PCI_ERS_RESULT_DISCONNECT;
> >> +		if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
> >> +			if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
> >> +				nvme_dev_disable(dev, true);
> >> +				return PCI_ERS_RESULT_DISCONNECT;
> >> +			}
> >>  		}
> >>  		nvme_dev_disable(dev, false);
> >>  		return PCI_ERS_RESULT_NEED_RESET;
> > 
> > I get what you're trying to do, but it looks racy. The reset_work may
> > finish before pci sets channel offline, or the error handling work
> > happens to see RESETTING state, but then transitions to CONNECTING state
> > after and deadlocks on the '.resume()' side. You are counting on a very
> > specific sequence tied to the PCIe error handling module, and maybe you
> > are able to count on that sequence for your platform in this unique
> > scenario, but these link errors could happen anytime.
> > 
> I am not sure about the deadlock in '.resume()' side you mentioned above.
> Did you mean that deadlock occur due to someone holding this pci_dev's device lock?
> Or deadlock occur due to the flush_work() from nvme_error_resume() would never 
> return?

Your patch may observe a ctrl in "RESETTING" state from
error_detected(), then disable the controller, which quiesces the admin
queue. Meanwhile, reset_work may proceed to CONNECTING state and try
nvme_submit_sync_cmd(), which blocks forever because no one is going to
unquiesce that admin queue.


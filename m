Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1693BC35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 17:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LEDm7YTL8jmmOvPDogS6pQpt5LwHjvg31pR44DoupTA=; b=iD7EmAdpU2su0do/GErSnFqXnO
	yJlZ57ttqw1V1ITNbUB/lBrb6D/oe9sQWSEyNk4aqT3TbG8digeM1w2RD0ua8OhMhLHpn4ZvbCkj8
	/dEsWuRHS9KM3uFC/bGP6HWcvZZxudh1fwX1HC45fXgqUmFhRdoVFDkeiZqIvC+oHJKOTmDfqw24C
	Xs3NCPjCmaE8stDgDHqRavp21PvNHoGizWN5cyhS0NMZGepEJyd1ZXXHE62Wv3eUudv8jNIASSLmS
	4GqLtfxXyrOBwSPTawFDLxXyO/w/ATBKovnOnUBUKhwPE9+vhP5BWklPxm0pM/HI2Qo3jr+tbwEB1
	AGugHOVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFHrc-00Bi36-2i;
	Mon, 18 Dec 2023 17:57:12 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFHrZ-00Bi2c-2T
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 17:57:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8E308CE10AE;
	Mon, 18 Dec 2023 17:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A2EC433C7;
	Mon, 18 Dec 2023 17:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702922226;
	bh=kR4rywbCLa/Hq4HkKdqVCeEqBy7I/ZPW08naMEn8l0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sq6wOF5YOkqpBo/GQyJGlnzlBaBbPnnGJt3MsCYeI+wILtiOn7pXEUiOHOzNRMb63
	 aLR7pzfmP2wsKUG0QL66pbGSh4SSsU+52Wc/LLgEEyjh8Z64rJEckU++A+hR3f3N8S
	 L+vqviawWHMWR67UeEr2OnURh4mPdG3oOsnkmbsp+zZX42d71qpS/TynqoyzAUNTGh
	 B4sZzDcVVtJRAjE4D3XfhOcGpecbCzXpI9eJv2JVNwHCyRFvoivfa7QsIHFl3LBHAv
	 RgOM7op1ERkhs+5Lh2gbECET/fhYRjAqyM2vwAet3RGN/gj5HzYIVCfN+nMg1B33xj
	 HyCilM6rZ8G6A==
Date: Mon, 18 Dec 2023 10:57:04 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvme-pci: fix sleeping function called from interrupt
 context
Message-ID: <ZYCH8Hsn4UI_7j3-@kbusch-mbp.dhcp.thefacebook.com>
References: <20231215143136.252497-1-mlombard@redhat.com>
 <ZXyMCcq7I0ZBNU-K@kbusch-mbp>
 <CAFL455nBx_tRj3QDVXwU2pReoryF3bVfMvD1O+4YHDZzWnzS2w@mail.gmail.com>
 <ZYCE0Tam0HOVfVI_@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYCE0Tam0HOVfVI_@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_095710_058625_7CF19840 
X-CRM114-Status: GOOD (  20.80  )
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

On Mon, Dec 18, 2023 at 10:43:45AM -0700, Keith Busch wrote:
> On Mon, Dec 18, 2023 at 04:11:38PM +0100, Maurizio Lombardi wrote:
> > p'a 15. 12. 2023 v 18:25 odes'ilatel Keith Busch <kbusch@kernel.org> napsal:
> > > What async event occured to cause this? It looks like the only AEN
> > > handling that cancels anything is the FW activation one, but that only
> > > applies to fabrics, not pci. Still, that AEN hanlder sets the state to
> > > "RESETTING", but we only cancel work when transitioning to "LIVE" from a
> > > CONNECTING state.
> > 
> > It looks like the stack trace is a bit imprecise.
> > It's not the call to nvme_change_ctrl_state() that triggers the error
> > because, as
> > you correctly noticed, moving the controller to the resetting state
> > doesn't block.
> > 
> > The problem is the call to nvme_auth_stop().
> > 
> >         case NVME_AER_NOTICE_FW_ACT_STARTING:
> >                 /*
> >                  * We are (ab)using the RESETTING state to prevent subsequent
> >                  * recovery actions from interfering with the controller's
> >                  * firmware activation.
> >                  */
> >                 if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
> >                         nvme_auth_stop(ctrl);     <----------------
> >                         requeue = false;
> >                         queue_work(nvme_wq, &ctrl->fw_act_work);
> >                 }
> > 
> > void nvme_auth_stop(struct nvme_ctrl *ctrl)
> > {
> >         cancel_work_sync(&ctrl->dhchap_auth_work);
> > }
> 
> Oh, got it; thank you for clarifying.
> 
> In that case, let's move the nvme_auth_stop() call to fw_act_work. The
> AER handler doesn't depend on auth_work being sync'ed.

I also want to mention nvme_auth_stop() ought to be a no-op for PCI,
right? The nvme_ctrl struct seems a bit overburdened at this point, I'll
take a shot at splitting optional transport specifics out of it.


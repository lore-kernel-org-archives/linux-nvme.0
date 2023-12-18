Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D15F1C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 17:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U411WWoyVEZakMAYPSTXSpw/NRWn3qPGCpCe7UcrA4E=; b=RVlibiwtAF72PAqGuXeBIEYYZ4
	7jP9pxgtQd2WgUHSfFVEHRgzfVl1Y6DPuHtX4U4qCM+SoQ9fdXvBWUqZk1iBdW23F+rdCY6f84C/+
	7MYemWGnsiTBe/5uv/Vr8jtzGXR9DG2E9biSXBv+9j39/casS/fD0u9gU4PXDj3uJqpqVr5pA5oMc
	EBE3c1jntuNZqoA6cygE/b7rYGg6wX8XGGIb6zJ256yvX5xfyu8j56s6u2MANmc5KV046VRNKZYIl
	lEqg8/hVeJI57Vvmpzs3ZpAjiWDt/yjLt0Mj6t1YS/srbdpe5u9ZQYD8sZ/NOctVicvXE4R4q3InK
	HPkbC8ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFHei-00BfsX-2v;
	Mon, 18 Dec 2023 17:43:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFHef-00BfrZ-2j
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 17:43:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C46BA61173;
	Mon, 18 Dec 2023 17:43:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1DBC433CC;
	Mon, 18 Dec 2023 17:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702921428;
	bh=YUdv4xGypKG5Z5oQvKOwg5iBL5zG9DZyqdNYP2EyqZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1DWG80apVsb9/dL/sokwNlErfTLf3rjmRMO6UcEecutSk2qAKtaRWCIQsJtlO7hZ
	 /JnguTf0gm0wBsZvQnVDTJn/ykYVlwrRpS2wU1WiLfxTEDj4TE5Hkz6Q6PnQwkEcMu
	 TGoFTkJtoktEqlm72qQUe1PVHM0AfUtZHpHLyzWM8lFt4CpIdtrUTvOeBy084A9/Mp
	 CeDDF9tLEHXu47G9HMobpm5y+Q7jH0U5C8BNb7uWIeFyEpO5yJk+m1VlH2LLmL9xPv
	 Fq904Tz6Dgy2tUcWibsoovUxzqEgZzmhLq99ZHXneVHiif6U8EErB3DAJLaZK4hkcR
	 LvIAbogy1p31g==
Date: Mon, 18 Dec 2023 10:43:45 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvme-pci: fix sleeping function called from interrupt
 context
Message-ID: <ZYCE0Tam0HOVfVI_@kbusch-mbp.dhcp.thefacebook.com>
References: <20231215143136.252497-1-mlombard@redhat.com>
 <ZXyMCcq7I0ZBNU-K@kbusch-mbp>
 <CAFL455nBx_tRj3QDVXwU2pReoryF3bVfMvD1O+4YHDZzWnzS2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFL455nBx_tRj3QDVXwU2pReoryF3bVfMvD1O+4YHDZzWnzS2w@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_094349_949674_B3358119 
X-CRM114-Status: GOOD (  15.98  )
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

On Mon, Dec 18, 2023 at 04:11:38PM +0100, Maurizio Lombardi wrote:
> p'a 15. 12. 2023 v 18:25 odes'ilatel Keith Busch <kbusch@kernel.org> napsal:
> > What async event occured to cause this? It looks like the only AEN
> > handling that cancels anything is the FW activation one, but that only
> > applies to fabrics, not pci. Still, that AEN hanlder sets the state to
> > "RESETTING", but we only cancel work when transitioning to "LIVE" from a
> > CONNECTING state.
> 
> It looks like the stack trace is a bit imprecise.
> It's not the call to nvme_change_ctrl_state() that triggers the error
> because, as
> you correctly noticed, moving the controller to the resetting state
> doesn't block.
> 
> The problem is the call to nvme_auth_stop().
> 
>         case NVME_AER_NOTICE_FW_ACT_STARTING:
>                 /*
>                  * We are (ab)using the RESETTING state to prevent subsequent
>                  * recovery actions from interfering with the controller's
>                  * firmware activation.
>                  */
>                 if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
>                         nvme_auth_stop(ctrl);     <----------------
>                         requeue = false;
>                         queue_work(nvme_wq, &ctrl->fw_act_work);
>                 }
> 
> void nvme_auth_stop(struct nvme_ctrl *ctrl)
> {
>         cancel_work_sync(&ctrl->dhchap_auth_work);
> }

Oh, got it; thank you for clarifying.

In that case, let's move the nvme_auth_stop() call to fw_act_work. The
AER handler doesn't depend on auth_work being sync'ed.


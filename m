Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01973C4332F
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Dec 2023 17:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R5r7gTgS2Qa/klcHiz4eJe+i5ZBoTinYdXghMb6Ilak=; b=zl2rIol90VdHSRyoYO8Ig0+lsC
	/QZ2eHxhuVk2l3gI/CTX9DENlHIzfYXpYPn048eL7vDe9fYJWzV/PiLiLsCe+7mBqmLNL7lQC5wDr
	v+13QfZutjbyENQ+IJHZnEa5ycqSoRHWQ1lz25jk8YSpmkmTKeHLpAByBvIsKW2PS7PMSiPpwBm4t
	DXRe//fdIcbGdGkU2kyElDInT16dT4fdfPQ4fY25fsgd6sKZmVIUtKhPyL/wBc0KB/t8v+575aqtl
	y2cT11mHvlozuw8l0j8Zw9Y3qZ0NeL9vipKQSwzFMV0LOkmRpV5tyYU6FokMpbHXHccTe4zGHu7Q9
	dm14RyKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rEBwO-0044Xu-03;
	Fri, 15 Dec 2023 17:25:36 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rEBwL-0044X4-1L
	for linux-nvme@lists.infradead.org;
	Fri, 15 Dec 2023 17:25:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AF143626E6;
	Fri, 15 Dec 2023 17:25:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE06C433C7;
	Fri, 15 Dec 2023 17:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702661132;
	bh=Bp3+wjDZ7Z0BeLEWg6AqdpQCiiq2B0/lfHM8y9BGLd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=knhbJkP09cW47ZR9tHxqggEkyrJ0A5aLNykLJ13tIgzUdq9FKqJkhrxNqnrXnPC0M
	 BjYSzn8FZjEv1xZZ64v75fjGhzwaSrF6JLvrzZ3xG5txSRUiDwHzqEec7GW32FgcQl
	 mUWJtGBrnd3jpFUZEvC4toeStCVyXCstS8ciuoitFI00AdZ2cpWTMAWLQAcmawfRkV
	 XFGetcIUUpB7HVwa2jWkZaQhuwkFCPb0ZLuxMsYAbaobkudToCTtZht9nFoaUvehTY
	 lNNBRCCtzW5FJqLDoNdCTYvCpRO/JO1/HBYJ7E7qLSnMo+Re1L2vqslp7RtL+NFnp9
	 VRhuvOrwi/bpA==
Date: Fri, 15 Dec 2023 10:25:29 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix sleeping function called from interrupt
 context
Message-ID: <ZXyMCcq7I0ZBNU-K@kbusch-mbp>
References: <20231215143136.252497-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215143136.252497-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231215_092533_515846_96241CDA 
X-CRM114-Status: GOOD (  12.40  )
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

On Fri, Dec 15, 2023 at 03:31:36PM +0100, Maurizio Lombardi wrote:
> the nvme_handle_cqe() interrupt handler calls nvme_complete_async_event()
> but the latter may call some blocking functions. Sleeping functions
> can't be called in interrupt context.
> 
> BUG: sleeping function called from invalid context
> in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/15
>  Call Trace:
>  <IRQ>
>   __cancel_work_timer+0x31e/0x460
>   ? nvme_change_ctrl_state+0xcf/0x3c0 [nvme_core]
>   ? nvme_change_ctrl_state+0xcf/0x3c0 [nvme_core]
>   nvme_complete_async_event+0x365/0x480 [nvme_core]
>   nvme_poll_cq+0x262/0xe50 [nvme]
> 
> Fix the bug by deferring the call to nvme_complete_async_event() to
> the nvme_wq workqueue, add a wait_queue to be sure there are no async
> events waiting to be completed before stopping the controller.

What async event occured to cause this? It looks like the only AEN
handling that cancels anything is the FW activation one, but that only
applies to fabrics, not pci. Still, that AEN hanlder sets the state to
"RESETTING", but we only cancel work when transitioning to "LIVE" from a
CONNECTING state.


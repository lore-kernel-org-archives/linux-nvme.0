Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56790D1A639
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jan 2026 14:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0BmBVyGW3AlXeNIUe0Fvx9Ra8dMKjIR3YMo9o8GDnMk=; b=nK2a7IFEPcM1KFL54pXVIh9/WQ
	3kUy0wv0tVTpUpmJCYl82Xw28UlEcSdTugX2WgbGA8jYrFYNKm3WTsnJSFPo8PAVwoLSm7sm5hEbK
	iGgAZXyY78SDm6qxOmCV/nx5LLLTnlBliQsgXgIxaZLYoLV17hmwfa8Vdc4+Xf4fPivCwSypT+MfB
	u01svBu7piVvxFWtpx4W4WtiP3a69R76F041QyQ5fg1rI2B+9xMDF8hlQoaVm2NHTrESNvrIXE6As
	cLWXFO50hhLPmfoXSg4utr/eYYBbhHPqTLM0QOboMeSj/q0XgnmbwcZ1Mae81dho9RX/dOH5enxjZ
	I63GM4ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veDsg-00000002Qyx-3tSw;
	Fri, 09 Jan 2026 14:54:26 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veDsa-00000002Qye-25gq
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jan 2026 14:54:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 81A0343C21;
	Fri,  9 Jan 2026 14:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D74C4CEF1;
	Fri,  9 Jan 2026 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767970457;
	bh=umLEquBAPSM246Vx2GE2vj87XWK/EJOVrEm1BcL4bvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V7snp3gFtSnlSJXgINWjuCZRx4WUDYPL/Si3yA2+lRGUvDu3XR65xl8TMTa8vV0Iv
	 mWegtMwBn0q2Oew5tR3D2LazWW+fjLktrr3z70zrcWWmQbY6Xf0p8xhEBkEhNrgL6z
	 FZL2Q83UKaChZfGXqFEe8qt8u0/90cubt4KwzWzuiRVA7MP2dOKRRSkb6jAIpEAaEJ
	 gM/K6mTjQB5A21Ypc59z/vfF5CTfa+LyQ+XoKoL4g08CSa00HFYBInygAasxDA0dNj
	 9nAsFTaOC3vnyRPWsyWvJ8075xInDPw0RwpkhRiEjP5D+7x7n9fabmh/GhiqvNFKrH
	 JJvT+Pdf6b+dA==
Date: Fri, 9 Jan 2026 07:54:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-nvme@lists.infradead.org, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, yi.zhang@redhat.com
Subject: Re: [BUG FIX PATCH COMPILE TESTED ONLY] nvme-fc: release admin
 tagset if init fails
Message-ID: <aWEWlw5I9w5neQSo@kbusch-mbp>
References: <20251220001842.6027-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220001842.6027-1-ckulkarnilinux@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260109_065420_561926_1BE0C8F7 
X-CRM114-Status: UNSURE (   8.96  )
X-CRM114-Notice: Please train this message.
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

On Fri, Dec 19, 2025 at 04:18:42PM -0800, Chaitanya Kulkarni wrote:
> nvme_fabrics creates an NVMe/FC controller in following path:
> 
>     nvmf_dev_write()
>       -> nvmf_create_ctrl()
>         -> nvme_fc_create_ctrl()
>           -> nvme_fc_init_ctrl()
> 
> nvme_fc_init_ctrl() allocates the admin blk-mq resources right after
> nvme_add_ctrl() succeeds.  If any of the subsequent steps fail (changing
> the controller state, scheduling connect work, etc.), we jump to the
> fail_ctrl path, which tears down the controller references but never
> frees the admin queue/tag set.  The leaked blk-mq allocations match the
> kmemleak report seen during blktests nvme/fc.
> 
> Check ctrl->ctrl.admin_tagset in the fail_ctrl path and call
> nvme_remove_admin_tag_set() when it is set so that all admin queue
> allocations are reclaimed whenever controller setup aborts.

Thanks, applied.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAA03C5321D
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Aug 2024 21:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=McX5AOqs3mlilJACGeb7g3Xl/WjVAR/0AYE9W3UAuV8=; b=SyjCRCUzJr7dIWve/lKyEXMmrg
	mtSlGZO6L3UBIpsegmGK5k69jIkAQYQ5ENO8jd3dYAh40pmhlb6nnVlh1bF3aeh7EeUDacFJqiHBX
	ceg4idatKiYPiUyKcRMm7Kl4kHKUWGTDBZQDNQifFZT7blsYY17ZlaERwvZiGLftwQrBa7UNLaNl2
	TW1LeXuih309uNra4ruoKyNXsflfdpS2vE3XYWrS+0I/Z6nbWuDV+dad6++OGy0nB7hgUXFt2XGib
	RXRjNeGv1JBFLMilhEdLYoHQMzH9N/qKE4AjBxwj0x18kYkV0qVg6uvAsbBBTtoikdgvInp6QW1DO
	4Of13zng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sihVZ-00000008rHX-1T09;
	Mon, 26 Aug 2024 21:44:17 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sihQx-00000008qO3-20DD
	for linux-nvme@lists.infradead.org;
	Mon, 26 Aug 2024 21:39:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C9D56A40C3C;
	Mon, 26 Aug 2024 21:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D58FC8B7B7;
	Mon, 26 Aug 2024 21:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724708370;
	bh=kSfqCKHCT18hmz9iAWhks1kQ9XbnSfUydRs5LLdyFWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ayzi4fJcuZOnPwOAQGlt20IYsjafP7b0GQeCXKEzgzjk718UvVeDxRWbpaW9JD+Q8
	 yG+yy1p60FtNJZlOy435zNeoaaG8tg2Y/g+2NZkG7MT9+1EhMGPU91pudWZXsk/BXj
	 aHVyNOI4shwN/jZgzITYvQWOUc1tQ+e/1XjIDP8JWfE8A+RBx3zUnhMTBx3hdl3s4J
	 3auNyVsYlp1sBNey2kNFPVcM2sFExKFOcFkO91HgbZ5DpADXFlA4nc6t0GRGvtSTPW
	 CzKGMNiTWu6yEabcfgBi5HMbrPOf34BNMxpMvJ0kwmNEkN18w8AmM/9bC5S0BWtXwD
	 351bb/cTEA+zA==
Date: Mon, 26 Aug 2024 15:39:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: sagi@grimberg.me, axboe@kernel.dk, hch@lst.de, kch@nvidia.com,
	linux-nvme@lists.infradead.org, me@yawk.at
Subject: Re: [PATCH V2] nvmet-tcp: fix kernel crash if commands allocation
 fails
Message-ID: <Zsz2D3bGq7AUFRoP@kbusch-mbp.dhcp.thefacebook.com>
References: <20240821142826.69366-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821142826.69366-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_143931_601076_F4803D7A 
X-CRM114-Status: GOOD (  10.35  )
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

On Wed, Aug 21, 2024 at 04:28:26PM +0200, Maurizio Lombardi wrote:
> If the commands allocation fails in nvmet_tcp_alloc_cmds()
> the kernel crashes in nvmet_tcp_release_queue_work() because of
> a NULL pointer dereference.
> 
>   nvmet: failed to install queue 0 cntlid 1 ret 6
>   Unable to handle kernel NULL pointer dereference at
>          virtual address 0000000000000008
> 
> Fix the bug by setting queue->nr_cmds to zero in case
> nvmet_tcp_alloc_cmd() fails.

Thanks, applied to nvme-6.11.


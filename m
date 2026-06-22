Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9190CDB470
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 14:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GR2xv4cnlx7ImAPN7DUM4pmhvp063Y6ta6sjYjwnitc=; b=ev92pWv8T399LLcobH3Y4OLhtG
	6jpp/S/KOFMPrXZN7+VFGQ032G8CXlcN3kwKN2pb8e9h4Vi4zgwt/PYRTrGZQ1nrz6YYLCYBJTDpi
	6IFtOYpMC+v+9LkxuoDHYu209LtMc+RJLM7AOPVWEc/0TB6oMRFd7l2erOWQVkHaDdTFBV5/EyTy1
	7kJmOIFRpHrSqGCBF9AGwRER8PD8Y6Ra7M1iYREM8DyhvRg8xJI8LSd8aCMsYaJRwQwLAgb36gtHY
	mYZoKR6uMNKWg4aldvrr8BN5/sLtqYvI9YZY6iszX47QF9TWuX438+fbDjEWHVEd3FXefoHtVXsq8
	S+ukccgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbfkX-0000000555W-236b;
	Mon, 22 Jun 2026 14:35:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbfkW-00000005552-0nc6
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 14:35:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E92D844487;
	Mon, 22 Jun 2026 14:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802431F00A3A;
	Mon, 22 Jun 2026 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782138943;
	bh=GR2xv4cnlx7ImAPN7DUM4pmhvp063Y6ta6sjYjwnitc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YVWcuRrK8e7fHFtD/SHmnSesFx6lVimpCJZ+MdQoqBKzMHTuwLXG1HstJ4DjMiMJn
	 XuPYPbT/1VaySw60NXjWiiBXbMipKgE5iJTzR+MgZjUaPwvHicgSyxZLMQqVyQoWsP
	 QHhpAhK7dPueUIQ89c/RdaFUau2vnnWrisnsV8hmP6pFeRjGSs4RccHt8YMpbqjSs8
	 trLt8e28KA1tN6hN1stouH6YHNmwX/5xnu5C+6TNVlektQhlnPhzVunoSC1mWDgFoy
	 nqJyhuT2mwfQpeSAU03Gq24IBGDBpL6vWWor0sFs0pI/xQhrIWdl2GiuGE/EzNrOSN
	 /0yRfVLXg58Xw==
Date: Mon, 22 Jun 2026 08:35:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: David Epping <david.epping@missinglinkelectronics.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leon@kernel.org>,
	Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
Subject: Re: [PATCH RFC] nvme-ioctl: propagate PRP1 from ioctl to admin cmd
Message-ID: <ajlIPlEv_zBfTMVG@kbusch-mbp>
References: <ajlDjpjK_clMrnwx@ubuntu-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajlDjpjK_clMrnwx@ubuntu-server>
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

On Mon, Jun 22, 2026 at 04:15:42PM +0200, David Epping wrote:
> @@ -306,6 +306,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  	c.common.nsid = cpu_to_le32(cmd.nsid);
>  	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
>  	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
> +	c.common.dptr.prp1 = cpu_to_le64(cmd.addr);

This is not correct: the user space virtual address isn't the device
DMA'able address. The driver already handles mapping the user address to
kernel space, then to dma, then sets the PRP accordingly.


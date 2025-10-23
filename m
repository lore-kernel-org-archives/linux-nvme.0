Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5B7CCD1AB
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Oct 2025 02:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c3QukOw6CVjVEVWrubYvcpRN6A3/isTyvuoURu0ORno=; b=zbIQbtaYouc7o4zNADOhQ4XRBg
	s+pdXBvhAEYk4g+RsEmVclNDVLlYRII9bMgRDYlrah32w1DX0WanlGOK1zZ8yRE3xy1MGiB4loRxZ
	gr0hK1ihtOG0qMLTc8Qsy2+BwSTWF6miS/MDXRVyVoiO5WQRk6ThjkS3aOl1SK22CI6/hVZmivFVi
	JRBuMFCgSryASJ6VtcpKHVboxX5BJBLDdjS3sneVM3fUZAr9fKiuucs7jZRfue4+eWeMe4WZO1UgR
	w+pmHAzOpaIq3L4W/cpqt1UI3RBMNc8nz0tN4qnQCCielw9bXmcuWBOlXZBOWKrkqSGwLs3VE8Odl
	3G7EeMTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBlLF-00000004se2-2TlR;
	Thu, 23 Oct 2025 02:46:17 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBlLD-00000004sde-3oir
	for linux-nvme@lists.infradead.org;
	Thu, 23 Oct 2025 02:46:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 992C840B2A;
	Thu, 23 Oct 2025 02:46:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BBF4C4CEE7;
	Thu, 23 Oct 2025 02:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761187575;
	bh=2iLpTCfc6zJRExD5lBqYjMm4ycDhWUdgj49CW7NIkLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ISYx1M57M9aV4Rh3iqHb2vF6Rq2Y5mNhowXEXGFyINVZCBVytMsGD+7X9E1EsoWCb
	 a4ZVlVvd1ZrBzQiRilLdUKUzXfctBAPqix7NaLDL7zBFL0osswS4W1kOtYUTnLZdTG
	 AfI/NtGiVHkrRuWd7oN/StW+830t2yFy29O1yWhHcVWNmb7mouEPMbu/Tlm7MFfsPk
	 dk6R7TtWYQ8b5twxSIQ107T4okILreBXg2X8yIj6bL2hEbzbXIKAG6dnoOLIt/yvit
	 /gXs4nktYMZ6jInwuT/56aDt9gOo67vkwxiLO+5ky/bJN1ksLdzCUqrrb9VDjL7pf6
	 pT7BbwQa+7m+A==
Date: Wed, 22 Oct 2025 20:46:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCHv2] nvme-pci: use blk_map_iter for p2p metadata
Message-ID: <aPmW9Xvkj7imiDFF@kbusch-mbp>
References: <20251021151831.2009152-1-kbusch@meta.com>
 <20251022060052.GB4220@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022060052.GB4220@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_194615_964135_4F7DB685 
X-CRM114-Status: UNSURE (   7.42  )
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

On Wed, Oct 22, 2025 at 08:00:52AM +0200, Christoph Hellwig wrote:
> 
> Although I'd still rename nvme_pci_setup_meta_sgls as in my draft as
> the name is a bit misleading now.

It's a good idea, folded in and pushed. 


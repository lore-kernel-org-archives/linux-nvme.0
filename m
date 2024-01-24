Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47E41C47DDC
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 15:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H7bh7zDQGgSQbGxPUWG848iROvvr5gBZTmqDsfQo09Q=; b=kryr128wKrfcHf4zxZMvq3Z4S9
	qE8ANbqTTK4TIO+0qIm9DIeuk51mQ/rU8VECFVpQqjx+05UzM1ko/j23mtTu8iME/55sBky7dlJYe
	irYZ4bCMsSfd8px20G9x+AGerggYQep0qJ26Ajgm2TtAW8hOmziR1OJtJZJhs9YniqA9KblwjPGxE
	iLiV4dNgMVS+NRQ736yveN2k1vVFn9X6NVIP38S/qDyokyFwqKEt73VSs7jhr9nOPInDChlxP6a7h
	Fc/EkAj8rSLkBH3gFhtzMKFco1+1oO7cLF4b/5H1RMNmWA1KnYXJ4PFFQ3Wt9RZzB0cbh+Oxj45BE
	2joPKuzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSfGS-003yXG-2e;
	Wed, 24 Jan 2024 15:34:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSfGP-003yV2-34
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 15:34:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id EA1E761D64;
	Wed, 24 Jan 2024 15:34:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22377C43390;
	Wed, 24 Jan 2024 15:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706110442;
	bh=ppVpbcCvubToBCzYWpgi5qt2y7RXVV8dml8rgnnfU2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UTx+IwWRy8n5/w6PsMJjFTdPVK2WeFSqWGGYJNVvc5vHZJnVjB0mMpYk3Wn/3xi/C
	 EhntniMx8TVMh1JtVEsDTK5IY8AUBD/tzOiiKkfGqiQ6vBRXk7fx9AuF3r0k7dsfcI
	 UszFc+9GHW4ssb2xeSIOZpTybs0IkDTGBa2ejvrvJGjXiVLG89qglxbqgZHigryNit
	 lEJ8TTsZGkBYE0HXcMvHomU2kPE3CevuXVY9kxwYLmnG6jBLWwPrk2oO7ixZnAEN8N
	 rcGa4rCzj9DZEFyScAOKg5CGiNK+RB47Ls6UAHOTWxyLPw8Si2+HtJx3B0pDwMDOOo
	 b4HdQuTuw9OQQ==
Date: Wed, 24 Jan 2024 08:33:59 -0700
From: Keith Busch <kbusch@kernel.org>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
	Linux-nvme <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-rdma: Fix transfer length when
 write_generate/read_verify are 0
Message-ID: <ZbEt5yrXnkvaGx3e@kbusch-mbp.dhcp.thefacebook.com>
References: <1706098587-20726-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1706098587-20726-1-git-send-email-israelr@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_073406_028615_D205F5BD 
X-CRM114-Status: GOOD (  13.47  )
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

On Wed, Jan 24, 2024 at 12:16:27PM +0000, Israel Rukshin wrote:
> When the block layer doesn't generate/verify metadata, the SG length is
> smaller than the transfer length. This is because the SG length doesn't
> include the metadata length that is added by the HW on the wire. The
> target failes those commands with "Data SGL Length Invalid" by comparing
> the transfer length and the SG length. Fix it by adding the metadata
> length to the transfer length when there is no metadata SGL. The bug
> reproduces when setting read_verify/write_generate configs to 0 at the
> child multipath device or at the primary device when NVMe multipath is
> disabled.
> 
> Note that setting those configs to 0 on the multipath device (ns_head)
> doesn't have any impact on the I/Os.

Thanks, applied to nvme-6.8.


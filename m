Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BEDC282E5
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 18:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LsRUQENxgegyzIXaNCrALz9EeL/Qx6DBRuDzHxNQ6fc=; b=vkdbADq6i7dgLbj5h5C1YNvgOA
	SXTLN4yUGca5ogpab3/Ti6jDnwiGxaqZU8chS7c8ukn1q3U+jLhU2St8S1m1PTz/j6TtGnhHjIQu5
	6P8shoAHn2TGfVk+bKL+tMdAjhsQzvHLK+w522JTWg1dW0jx4Iu2opFsWZY5Tb2dHRF2kBJ/mbEy9
	n/hwARR+YOvGTC7NMJNK9wZLpNYVwSfNylNJ+U94vBot6TOlwYd6FhtIBCbJGN/8uChChuQl4je24
	WY4Mv9VRZXVlxL2iWIBaaBHWCI88Kxy51SxOkMhev1v7wGi53apZYL2o77mycbOD0ctmN799r4G2v
	dlf2+zKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpteF-00000008wxd-0yD4;
	Wed, 05 Mar 2025 18:39:15 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpteC-00000008wvx-10yG
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 18:39:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C754B5C5DEC;
	Wed,  5 Mar 2025 18:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8445C4CEE8;
	Wed,  5 Mar 2025 18:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741199951;
	bh=grH0RhVhc4eOiVhfXSf0JaS0A7IAc62nPyeEwfK6Y14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvkVF1Gcn2xVAVy+dRci1AFs7Pm6G4S1szXVBwYXnjhyGT2Juz2KDr8bYgShpw3Ly
	 agEK3dIgTD0yz7JmGk7a9T6cUmEFNJ5uR8frxcz4wnbUieh69sZWNfH/D4CES2blbO
	 eT/qXta75KJdQK0DdYYFhnlRYrxufD8YmMvXGY3ve4dmyojglcjX6CMzqaHUB2UV5t
	 ZV1nuLAIV79V4oxlqQwuhXyYQqG66SDbuCx/frW93wAz3mHqY5PtgC9m7qBXN3/gJT
	 UuLbnrl0RlV2BwcR86FMxUbnnqNQhk1KVK1SZ6eu+d7RSI1sDWgEElffrS3XFNQJX6
	 Eb03ecfRs8v7g==
Date: Wed, 5 Mar 2025 11:39:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] nvme-tcp: fix signedness bug in
 nvme_tcp_init_connection()
Message-ID: <Z8iaTC4aGPRuZSfI@kbusch-mbp>
References: <d3661d33-096a-45e3-8304-1123fd031527@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3661d33-096a-45e3-8304-1123fd031527@stanley.mountain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_103912_324208_A8BF1C73 
X-CRM114-Status: GOOD (  13.32  )
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

On Wed, Mar 05, 2025 at 06:52:59PM +0300, Dan Carpenter wrote:
> The kernel_recvmsg() function returns an int which could be either
> negative error codes or the number of bytes received.  The problem is
> that the condition:
> 
>         if (ret < sizeof(*icresp)) {
> 
> is type promoted to type unsigned long and negative values are treated
> as high positive values which is success, when they should be treated as
> failure.  Handle invalid positive returns separately from negative
> error codes to avoid this problem.

Thanks, applied to nvme-6.14.

I had v1 applied previously, and it was the top commit in that tree;
force pushed this version to replace it.


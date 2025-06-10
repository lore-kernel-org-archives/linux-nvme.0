Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB2DC5B552
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 16:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3GgAJojF0rr9Sd6V806EglEovCdJrU5PBXZ9WXsmAeA=; b=XhYu0Uvs/lq0QnWzMcB+VfMmPp
	LFoa1P3hGTuRf/je/ev0GzBH1HQtNiXx/KmmG+G9qs7prxfl7+uvLEyg+/R6e8afrCwUI/Kx+BaQ/
	rqid2+JTmX55xz4lTfjHXyUWV4v1VE41dfpPE4KGVEjKG7zjdCIYhhqGPVw2iyQUltsMTbKvBRNzh
	UJaPvj4ILBeVu7/Ee8M+XBWnmaq4R25o6kSlhDp6hKA8PcfKR/eCH6Vf7dMd0+uh/7RX8+gAE4b88
	ai5hfePl3c/vec9+dx03/BUcUObuFNfwI7wqxHtf+k5pJMoeUw+ypHROZkCXJLjcyW93h5aXWRsGl
	4jBlE23A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP1S7-00000007PHi-0efE;
	Tue, 10 Jun 2025 16:03:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOyup-00000006wRb-22oC
	for linux-nvme@bombadil.infradead.org;
	Tue, 10 Jun 2025 13:21:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3GgAJojF0rr9Sd6V806EglEovCdJrU5PBXZ9WXsmAeA=; b=ILVIKwAQFeldVzg9lNGkeJCJ8i
	DwE8Iw/JHcF2vY7EWeSb4Q2L6grEiRtmCJNOLzgD85PJI1W4Eab6hMGurvr6Ne0FQaG6hkMSpgVAX
	Ts+V7lluI3zeV+/NutU8HeTZ/dyKbD49/2WCXgtDTQCOmzpH6/VQuG1Wbma9e8Pam5jyIlfmfxhVE
	ghUkjoC5weSm3AobOEySqejbmSxQUkdri+oDU7W11DQY8AsasP6d7pgHbdNOhMOBl1+iXeItyN5Ve
	ZIIi7isPySFiZ70hg6cYqgnmV+5ERwv5kkKsdpR9UK1D+F1e8khZGQy5wQ7CJ6wltClc9h2Rx71vs
	j/XgjhJw==;
Received: from sea.source.kernel.org ([172.234.252.31])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOyun-00000001qZz-1kIb
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 13:21:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id BBF6649E2F;
	Tue, 10 Jun 2025 13:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C678AC4CEED;
	Tue, 10 Jun 2025 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749561676;
	bh=10S+xVvF16s9qvOEZyyoDZfF61hAPS63yI0C8ViAS/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8DpxI9t+f6J/GNMwvUtbAixFN0Q3e9z/iWrXBeJ2qx015Bfqxu6EpKz/G9pbKxTR
	 0DO7pQKkFV0be6bU5t1pzx4irn/Z0wtRuYB92KWxJ+WmDLdn2hMI1Us47qyoq+tHk/
	 xavKBJ+cWU7Po/f9+E/wSfctRtchQR5MZtcBQctcGHqsltWkhVIToNaoO4KEwqzdo7
	 Pn5H3I0gmQiCc+j3H7NX8Lyiqhf3/ajhn81c+NQqYldQzb6tUOA8Y78/QfmBLotId8
	 uHU5Gmeo6HsEAsvcdiXsnb3ugS/LjBMVoRbRrnVvGF+gbc1p/9P4it3gplqJg7Vkix
	 SexWPcfpybh4A==
Date: Tue, 10 Jun 2025 16:21:12 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 9/9] nvme-pci: rework the build time assert for
 NVME_MAX_NR_DESCRIPTORS
Message-ID: <20250610132112.GK10669@unreal>
References: <20250610050713.2046316-1-hch@lst.de>
 <20250610050713.2046316-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610050713.2046316-10-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_142121_684048_116DED4E 
X-CRM114-Status: GOOD (  12.45  )
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

On Tue, Jun 10, 2025 at 07:06:47AM +0200, Christoph Hellwig wrote:
> The current use of an always_inline helper is a bit convoluted.
> Instead use macros that represent the arithmerics used for building
> up the PRP chain.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>


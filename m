Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB0DCFD313
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Nov 2025 19:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZjDEst8/gYG2XNNiXHcW/9dcAmDe8kLQolpH129H+08=; b=J+llORu0YjQyThqMAswxIfpCT2
	IY8ddo5ToUVQRzpObIab2c85xCYot0c3h8LkDSHLiddarkim9mRBABE31ycE2VIWGTeymo9bFQe/h
	dTVzbXjovgwcBZT82kcANT3Q/fEeAle4YJIQL+4uqhZxxwftFA6N1v5VEGd+ls7MYLr5wNtQUJDwR
	bWSe4LFfIFz+WmTFrg0ISGDNCS4OtKLDkwft/Y0lutxLnLfakB4V43Dx7zODnhmLiBD5jVKzbHP4j
	Pkvl7lVzNgL33ZcUdMALD1BMUqNpizhN1pPi7NhHOqcq7ZPDbv/oG42UAqxS2U5baF0SzfEckBLny
	pP2wY/qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNcLJ-0000000CFb7-2tI5;
	Mon, 24 Nov 2025 19:35:21 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNcLG-0000000CFaN-0l0P
	for linux-nvme@lists.infradead.org;
	Mon, 24 Nov 2025 19:35:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2883E4402D;
	Mon, 24 Nov 2025 19:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44EBC4CEFB;
	Mon, 24 Nov 2025 19:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764012917;
	bh=ZjDEst8/gYG2XNNiXHcW/9dcAmDe8kLQolpH129H+08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OqeWkF/79EoWg+TkdboVOEJNMD5idtPZbywvOJn6LewsO87kgpVRn2bYv+M0YaDPj
	 U8D3J2BWsWDbB4A/9Ed4BjZCjflCqDadmPJpMGQumK2QwY/mfDukf2QDnSw+lLu34R
	 TOcYDx2Ja/5wsBjcl3wSeJ1aetKK5fHE5lviUiRAp9XpvIvnGPJg/KZv8OHZrxXuQs
	 NQdqf3kJYFCjijqTOyFmcVOh0EC4jALeRoPl+xh/9OcpVUkUQZ9eH9HNe31nSP1JtZ
	 /RQOViHHDBC6DXyd78lx8LcQ1dcT9zfiSxBJuG9UD4LLnQfMZOxQROe+PhhAqYoW9C
	 XVHhe/vfEuejA==
Date: Mon, 24 Nov 2025 12:35:14 -0700
From: Keith Busch <kbusch@kernel.org>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Linux-nvme <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@fb.com>, Nitzan Carmi <nitzanc@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH] nvme-auth: Use kvfree() for memory allocated with
 kvcalloc()
Message-ID: <aSSzcj1aMkBzv4Bp@kbusch-mbp>
References: <1763909208-11611-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1763909208-11611-1-git-send-email-israelr@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251124_113518_243409_21A45DAC 
X-CRM114-Status: UNSURE (   7.18  )
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

On Sun, Nov 23, 2025 at 04:46:48PM +0200, Israel Rukshin wrote:
> Memory allocated by kvcalloc() may come from vmalloc or kmalloc,
> so use kvfree() instead of kfree() for proper deallocation.

Thanks, applied to nvme-6.19.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CF3CC6B38
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 06:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IA1z5tWn2jTH51tB+Z32X2EJ4CgjDgTcG3fvMptiiX4=; b=lyu6dxBQHZ820/Z1oQgZLfiwBs
	nDc52i/gpz1x8xNMW/kYYFdLOQ0KdQavcg3yDa84d7gl0HHR9EChVjNkdYddRYQx9y1ZWWr5sR7Q3
	EMaMbwteLjTHcc7SJb8oaoSPiFS8pFb5jltC2D0SE+OiRZn69hVB1F2Gbn+5LhtgnN6nUChlbTcmM
	abUhuNGaREnfeFFrSZXhxlDyivIz6NUxaivsacIZxuW28db5sbTDyB3vQA8+s5jJuCLSNpXrDA8QE
	I7TT91uyhy+YQB0wx+6AfcX/1S/YK3V7byyjwPQS4occJB9NJi+gg7jQQMHM+cxH/Abyq90yDxcrK
	zPxaIC6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHEk2-0000000Gv53-0NvX;
	Thu, 15 Oct 2026 06:15:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHEjy-0000000Gv4O-3hbT
	for linux-nvme@lists.infradead.org;
	Thu, 15 Oct 2026 06:15:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 74E9068B05; Thu, 15 Oct 2026 08:14:49 +0200 (CEST)
Date: Thu, 15 Oct 2026 08:14:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: kensanya@163.com
Cc: justin.tee@broadcom.com, nareshgottumukkala83@gmail.com,
	paul.ely@broadcom.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	TanZheng <tanzheng@kylinos.cn>
Subject: Re: [PATCH] nvmet-fc: skip hostport ops when the LLDD has no host
 handle
Message-ID: <20261015061449.GA14497@lst.de>
References: <20261014075303.277735-1-kensanya@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014075303.277735-1-kensanya@163.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_231459_094368_E22F489F 
X-CRM114-Status: GOOD (  10.56  )
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

On Wed, Oct 14, 2026 at 03:53:03PM +0800, kensanya@163.com wrote:
> From: TanZheng <tanzheng@kylinos.cn>
> 
> nvmet_fc_alloc_hostport() returns NULL when the LLDD passes a NULL
> hosthandle. That is not an ERR_PTR, so nvmet_fc_alloc_target_assoc()
> keeps the association and leaves assoc->hostport NULL.

A NULL hosthandle doesn't make much sense, so why do you want to handle
that?



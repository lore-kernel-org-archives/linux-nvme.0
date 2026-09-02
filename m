Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE19C624D4
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2026 22:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cg5o8lgTg5b5bmSjw4v65pZmgf85sugm017ebHjuk5c=; b=TZd/N6u1V77CI7Ns59rzNUpram
	AjPdX7k2/k50igG/JqPumhHfjOc9JyLIv9k7YjnEAiscJTVQ4MsxU1oxOe+eHXKSnurZHrBbM7KWJ
	rg5sTju1OlaIFTOCIp5E6WR9VyZ/vNXBXJO7+Mxs1Hi/4sSqTZeznKO/wesoRXHOfGDm0njTjhm47
	8QTFWSPWwmz04TPTaiEiRFWd9SMU7GBZ8gP5dotad3gQ/BX9Y1CZgVlea/YeWxR+oSj6CzyUn3T7Y
	TYajJM6Zy3zDpF2/zNzyondaEjRCnI9AGRvL4yKmdGNNH86wKmVz35xxzVg4gtf7GIfR21tvAYDJ6
	11OjcxNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1tUG-0000000G0qI-0W9r;
	Wed, 02 Sep 2026 22:31:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1tUE-0000000G0q0-3J2f
	for linux-nvme@lists.infradead.org;
	Wed, 02 Sep 2026 22:31:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1D31E4360C;
	Wed,  2 Sep 2026 22:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34CA1F000E9;
	Wed,  2 Sep 2026 22:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788388278;
	bh=Cg5o8lgTg5b5bmSjw4v65pZmgf85sugm017ebHjuk5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kxQBpnVYXvPtsrCaVcLec4+Ao5fczBjnX9kVV7ZEwTbIYOhIyTZsslbgbeSHwko6Q
	 4E4NFoCnhnXR6Kp/DQgLEI0M6qsaC5wl3CUldGZVmri5typu20h1FZ6uHC4ZCJbYw1
	 qUa+EO/8aTKvjSD7LBIkwDajwSyYYTn7jTZ1D3KfbUjB/9iAjho50RN2u6XUnzc0kY
	 u8uqVyeKkCVC3PKKonJ23m30Ak3WGm+TF39XuyN3oBCYYaLLt4ty1mMulxlpnaOF3n
	 FjD9wNc+P/cVgehpyXixE1i7sllYpdTOi/6R/b8wpeuriM1VKvROrrezVVkTFwV2Cj
	 Q/1WfPmG3WJ1g==
Date: Wed, 2 Sep 2026 16:31:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kazuki Hanai <hnkz.64@gmail.com>
Cc: linux-nvme@lists.infradead.org, hare@suse.de, hch@lst.de,
	sagi@grimberg.me, kch@nvidia.com, axboe@kernel.dk,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: Synchronize timeout work during SQ teardown
Message-ID: <apijtLJ-5hU2MahC@kbusch-mbp>
References: <20260830131105.680566-1-hnkz.64@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830131105.680566-1-hnkz.64@gmail.com>
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

On Sun, Aug 30, 2026 at 10:11:05PM +0900, Kazuki Hanai wrote:
> nvmet_auth_sq_free() cancels auth_expired_work with
> cancel_delayed_work(). If the work has already started, cancellation does
> not wait for the callback. Transport teardown can consequently free or
> reuse the queue containing struct nvmet_sq while
> nvmet_auth_expired_work() still accesses that SQ.
> 
> Add a teardown-specific helper that synchronously drains the delayed work
> before freeing authentication state, and use it from nvmet_sq_destroy().
> Keep the non-synchronous helper for in-band authentication state cleanup,
> where the SQ owner remains alive.

Thanks, applied to nvme-7.3.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6F3C3600B
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Mar 2025 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uxqLXzAKzAGnkorxaXMRJPtP3RU86re2v72kk21IUQY=; b=mo8xYLiMKLQQU9hfbft/iMBmzZ
	NARJ+2nJZAtEQuZyVOPDC02f9LSnYGbU6CUGRAue/3iMJSutwIjz5g50RZXiAg4QR9Xlk3P3iao+t
	BRkq85OTDUr4AM3EWpMc7Q9vLF5eRLHDnhYAc0leqVu0u4VhFjmf5TIKYRU6XrV36zyF3aszKNDdy
	DpGi5kWrs2jost1Op1QQQhEMp8ug469fTiYVMieLJtY8Q8++QfyRQRQNTVFVYUm46HddtTqhFhHWF
	34n+4FT9wIXw1w8l8dALvv4t6m3N+WMxy6nXCFUu7Y2e++YgpjZuVS3dHLTXCS0xp7xRS+7xIQFs1
	5j1F2jPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txkjB-0000000Ajlb-2kMr;
	Thu, 27 Mar 2025 10:44:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txkj9-0000000AjkS-0zpd
	for linux-nvme@lists.infradead.org;
	Thu, 27 Mar 2025 10:44:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 794B968C4E; Thu, 27 Mar 2025 11:44:41 +0100 (CET)
Date: Thu, 27 Mar 2025 11:44:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] nvme/ioctl: move fixed buffer lookup to
 nvme_uring_cmd_io()
Message-ID: <20250327104441.GC10068@lst.de>
References: <20250321205722.3947901-1-csander@purestorage.com> <20250321205722.3947901-4-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321205722.3947901-4-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250327_034447_413032_6275BC53 
X-CRM114-Status: GOOD (  13.45  )
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

On Fri, Mar 21, 2025 at 02:57:22PM -0600, Caleb Sander Mateos wrote:
> nvme_map_user_request() is called from both nvme_submit_user_cmd() and
> nvme_uring_cmd_io(). But the ioucmd branch is only applicable to
> nvme_uring_cmd_io(). Move it to nvme_uring_cmd_io() and just pass the
> resulting iov_iter to nvme_map_user_request().

From a quick looks this valid, but actually adds slightly more code.
Is there some long term plan you have in this area that this helps
with?  Otherwise it feels like churn.



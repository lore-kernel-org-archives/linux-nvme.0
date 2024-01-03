Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBEDC3DA6E
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jan 2024 16:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wvlsthF/7V6t55qnKp+HThaal9Kd7YmlgYhPgOlyvZo=; b=gYkbZ79eY7k8ZdLxXspoCYmNpd
	hlDJeoZ97NBcq782/yCvi5ZP4+HJjjIqJktBpJNBor9GUHActqTGHUpDnlAHXSjskbZzQp7jtQbiI
	oZ9a4D0UcqchwnlzB+qmRPGggdoOOH1Aiq6e/Dd2IoL1EY3oo8+ewF2dOX53PKYT/l1lYBVzSqZ/n
	Z6VSDM+S6gkPLYiteKgQRrmTNm9hcLTVKc6xnRQvgEfumqtVwhxGCYvFCWnZzS5Xjg0nwTROwYA7I
	4BkoAqHk6YOpm2edFtE9Orjm7ubD6biMrg9JyIiMpYNdmeVrEv7tH2uoohGAdHRR8n7BtBPdDfoBS
	jW3j/iaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rL3xH-00BMec-1w;
	Wed, 03 Jan 2024 16:18:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rL3xF-00BMeH-22
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jan 2024 16:18:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E19F6614B8;
	Wed,  3 Jan 2024 16:18:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31304C433C8;
	Wed,  3 Jan 2024 16:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704298732;
	bh=DI+2gGfErszE2GaECboBAZH/1xptYGDXdL8VMlu0gwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PbpY5BEqt2J2qhfxWd4V5qW5mOpwk/NeAs5VNnpTo/XyxtZ8ydS4laj2UswRjMxbb
	 DyKQfiPt6R/MUaXsPINkLOGybb6QZM99ZQhOmMtOa5YJUraDrfvuLe0VOIJHvJi0Wh
	 98VuRO3P2g47ZQHCb6F/VoH5aT4s661QM0LpDs8kM5i2UUOHPm5d+JdFmFPBdGdDKT
	 WAWyu+9CjfdlXxhfiUJJg8IJUcxaHgBB03fLZ2TKl6jcVtOv+6AxDKP58k7LG0AgEq
	 3n7g1cn7y9+VHxjJUxahNGkEa9GyIi9e+Cb+cH0UqKk0sfC6ZohRP3dP75Dhd9L7hj
	 Avya6trh0S1MA==
Date: Wed, 3 Jan 2024 09:18:50 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH V3] nvme: introduce nvme_disk_is_ns_head helper
Message-ID: <ZZWI6tcrdYO-zE65@kbusch-mbp.dhcp.thefacebook.com>
References: <20231227093106.78551-1-kanie@linux.alibaba.com>
 <ZZR6iaGiwoLbD0dX@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZR6iaGiwoLbD0dX@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240103_081853_718026_3B4BFF6E 
X-CRM114-Status: GOOD (  12.79  )
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

On Tue, Jan 02, 2024 at 02:05:13PM -0700, Keith Busch wrote:
> On Wed, Dec 27, 2023 at 05:31:06PM +0800, Guixin Liu wrote:
> > We currently rely on gendisk's file operations (fops) to distinguish
> > between a namespace head (ns_head) and a regular namespace. To enhance
> > code readability, introduce a helper function.
> > Additionally, we must ensure that the device is not an ns_head before
> > calling nvme_get_ns_from_dev(). To enforce this, add a WARN_ON check
> > within the nvme_get_ns_from_dev().
> 
> Thanks, applied to nvme-6.8 with Christoph's suggestion folded in.

Patch updated to include fix for build breakage:

  https://lists.infradead.org/pipermail/linux-nvme/2024-January/044120.html

Final form is currently here if you want to double check what I did:

  https://git.infradead.org/nvme.git/commitdiff/620a6a938a716c6bd10129ec265731d5cb098a27


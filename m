Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF11C43458
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Jul 2026 19:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xcCEAZ4DGtQB3MS01PlqrNNfXX7OPi+4N5UYzP37PZA=; b=AA2KfbvmA6hONo150RH4J5/+xR
	Bh48Z9q22FJ3ZIOm1I6gxREq+MuNDB9VkxMBw2dB6kEe7HkDlilGAr6tu9AwL0AtVmPIEkIgJvdfY
	tJu89QYu0wGCocuSe2Ljs76cZSpfF8mNYkmq3b5Dg6agCMParEOLMYjbdTDbkEn8nDNjxInk/6U7y
	twiMwuTyFB6F63DBueFtyHEBRiP+AiPc/G5Q/MYJl04OIILi9bf5zopDDpmZhfZtevN2zNdK6YyeZ
	CJfAPE9oBvGNwFAVPMFiOCl0cE6jNj+XE0xvfymddfOIGfJI++novd/YtbssXcylz4VI+5+9aBlt6
	ZMjMlVAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whXiq-00000000FKX-3EXe;
	Wed, 08 Jul 2026 19:14:16 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whXiq-00000000FKL-0d1v
	for linux-nvme@lists.infradead.org;
	Wed, 08 Jul 2026 19:14:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6FB0643E29;
	Wed,  8 Jul 2026 19:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2AD1F00A3A;
	Wed,  8 Jul 2026 19:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783538055;
	bh=xcCEAZ4DGtQB3MS01PlqrNNfXX7OPi+4N5UYzP37PZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K5Rf9HZVk+f+evohgM84TowuubOu/HcR6zHTAHHcN4sQ6hHVKjOHtYSuVLqIJ5fSC
	 ySqIAH7uWwhTfDmOTuVBXuWB+sMjYr5TScIrJBz6PhmyHOzfQ4+bJsfGoDeaicMipm
	 hT69daNp40dSrxW3xT5pK8iENM9MPqYYHGPlJP7IF1/khdsiDICKGis++/Vj/VoWbC
	 rP3CBBBnC+DqMRn23NbNEWRLEns3rBcFi2wNn05y7F72GVy+WAWLYusgC3VZ5tN9j0
	 +M+85u4/lidTvnQ+6n2CQj9SQwcFGB3cVyk40vSkn7z0r1JhsgYWZuOY7Bm7LlC2aj
	 y8gwIxiDngK6w==
Date: Wed, 8 Jul 2026 13:14:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: don't reference NS after unlocking in
 nvme_ns_head_ctrl_ioctl()
Message-ID: <ak6hhSUeE7mhouQB@kbusch-mbp>
References: <20260706125402.615277-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706125402.615277-1-john.g.garry@oracle.com>
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

On Mon, Jul 06, 2026 at 12:54:02PM +0000, John Garry wrote:
> In nvme_ns_head_ctrl_ioctl(), once we drop the SRCU read lock we should
> not reference the NS to lookup the controller, so use the available
> controller pointer directly.

Thanks, applied to nvme-7.3.


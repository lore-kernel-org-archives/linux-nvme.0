Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26DE3C77B73
	for <linux-nvme@archiver.kernel.org>; Tue,  2 May 2023 16:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bfbA1lCj10mQB7O9Zm0E+pW8c67Q/LQmtO4FtlIWz1w=; b=pWOIUB290J4otyUnB1wghzwuwr
	j4kdwYtBewSNWFepl5IlK0JIUwWPDHynMjRnLIqJQKTUk3TS6PJrQyOndz0fqIMOAX/yeUW5PuAgL
	jEFXzToz1KEmZIUpkb5RrdOtatIGak1XT7IgWXxtm89vEk55Bu1M0iXiRhmJwVrbjYkps50SB4mXV
	qZnTVE/t44rH5GmOJE9mfMuwCcLJzgYqNPzmmWfKe3moGDASvjDGWi/51wGsDn9yFOwYnQiuwXLL2
	E6CHULRhQwLlkd3OrqJ+zRqxRDLAugmGNWM8P8RQ5IuS1Pas6VkR2R5HKwLORkD/6LvagIOWHXoqm
	W2SomxAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptszq-0026u2-1L;
	Tue, 02 May 2023 16:36:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptszn-0026tZ-1C
	for linux-nvme@lists.infradead.org;
	Tue, 02 May 2023 16:36:56 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5021B6195F;
	Tue,  2 May 2023 16:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C984C433EF;
	Tue,  2 May 2023 16:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683045413;
	bh=bfbA1lCj10mQB7O9Zm0E+pW8c67Q/LQmtO4FtlIWz1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fUytkGwHwDO5SYDnEOjr/By61PJ2WRfSQfEs5cSyEUIXisLeQ29+YeA7uW8nvm8jW
	 X/0uDw4VpO7ZuVqnuHkJAdFnn6U8YI8eCXHeNamFvx/C4VRWJN3ZA04LepdQkzHJ9i
	 6PwhNEB8GjopbhSboIj0dRg8aeRG//I9ccG8yG2fnjOQWMWh9LfvYGBHVrKRp7wavp
	 lHyt3gq4ZShQkAHQYHbbkqopNNWod/Qfxv2hX5wpDzRVVDWCEkLOV2SiRIrmF4VkPx
	 OhUNFibw9iOSOwhvo1/j5kFMDTjbpvtENhi/JLiYGvbPqXYPOsdWQQhGffmyMxeJuC
	 /m4MXzswaItRA==
Date: Tue, 2 May 2023 10:36:50 -0600
From: Keith Busch <kbusch@kernel.org>
To: Irvin Cote <irvincoteg@gmail.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: refactoring nvme_queue_rqs
Message-ID: <ZFE8IuEBJ2TI6ihm@kbusch-mbp.dhcp.thefacebook.com>
References: <20230502081301.73007-1-irvincoteg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502081301.73007-1-irvincoteg@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230502_093655_453181_11CC4362 
X-CRM114-Status: GOOD (  11.40  )
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

On Tue, May 02, 2023 at 05:13:01AM -0300, Irvin Cote wrote:
> When dealing with the queue_rqs callback, the block
> layer guarantees that it only provides with us with
> requests from the same queue (cf include/linux/blk-mq.h).

blk-mq only guarantees the list of requests are all from the same
request_queue, not necessarily the same hctx. At the nvme driver
level, this means the request list is for the same namespace, but
not necessarily allocated out of the same SQ.


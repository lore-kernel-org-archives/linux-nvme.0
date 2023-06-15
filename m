Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452B8C0015E
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Jun 2023 15:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nAC5zeGhdYFS1W8CVDlzAjEFJncaZcted9h/zd5JG/Y=; b=LshwX3ArrbpdoIwUdwxwwc9efj
	qT5gjrz0IFVGcwOL0jlWSVWPbvWaB5KTGTx0LkEHCtUFutBm712WnkwmEj3kSfhLukDcrxLv9+WvL
	4DcxYfgzFGhqlUZb0sW6a6KBZKI23ZxFEu2tIHKy6StPxZ1mYx7zKolDeYOpmgLP309cMrbEayvdq
	ChaoPD2aox6rjHEsWzuLG64iLJbXAYnJpVzNFi7wbOyIJJV96nCR3eR6XsE4RCwKNdPZ7Oy4QjzB1
	z/tjzZrURd/LgrWMQDqWIa8FBPmcermtEF4W0yYIycwmnbzfe0jBfURhreDYWIREyhuZhmS9oCX+7
	G4tX4CFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9oi9-00FH0O-2p;
	Thu, 15 Jun 2023 15:16:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9oi7-00FGzh-1y
	for linux-nvme@lists.infradead.org;
	Thu, 15 Jun 2023 15:16:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A38A363263;
	Thu, 15 Jun 2023 15:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BEEFC433CA;
	Thu, 15 Jun 2023 15:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686842190;
	bh=nAC5zeGhdYFS1W8CVDlzAjEFJncaZcted9h/zd5JG/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5Wd1Jx2Geq4SbpC02tQ/u5EdWW/GKinzit97hMbCDjVRAYPLeMkHPyjzxkRNhc99
	 hT71SlriC1gisSTaibd34/b81Zu78oWusjHI1jYFqjdDo5d6qRBCzOVajGKXnYhLA+
	 ghJW8M0Od3Cs5XdoYpY/MO8XaLtUc8jT5jmCfO/nJzjjZzVJtXSceiPeT1Zbu6mmUu
	 18/8fgRorVtYt3ilh5PbsNfMOELUW5LP9jDgKBDmSlq+4uWQNHPnMdQyMUZYc+ivho
	 NaamZB4hCEKWuwNnZm9tD3BsP/PMwdg7Gk2X0vTbbQWjOgqZFJfMbZxDAfobY9Z/9C
	 6E0Z92aDPE8wg==
Date: Thu, 15 Jun 2023 09:16:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	Yi Zhang <yi.zhang@redhat.com>, linux-block@vger.kernel.org,
	Chunguang Xu <brookxu.cn@gmail.com>
Subject: Re: [PATCH 1/4] blk-mq: add API of blk_mq_unfreeze_queue_force
Message-ID: <ZIsrSyEqWMw8/ikq@kbusch-mbp.dhcp.thefacebook.com>
References: <20230615143236.297456-1-ming.lei@redhat.com>
 <20230615143236.297456-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615143236.297456-2-ming.lei@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_081631_705560_610A093A 
X-CRM114-Status: GOOD (  11.65  )
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

On Thu, Jun 15, 2023 at 10:32:33PM +0800, Ming Lei wrote:
> NVMe calls freeze/unfreeze in different contexts, and controller removal
> may break in-progress error recovery, then leave queues in frozen state.
> So cause IO hang in del_gendisk() because pending writeback IOs are
> still waited in bio_queue_enter().

Shouldn't those writebacks be unblocked by the existing check in
bio_queue_enter, test_bit(GD_DEAD, &disk->state))? Or are we missing a
disk state update or wakeup on this condition?


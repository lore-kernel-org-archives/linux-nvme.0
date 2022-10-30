Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B71FC38A02
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 07:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5dxwNYxjxngVioB14eP3tRTnNTeuU8EbJ3W5xOQ2llE=; b=zACI6K3EfyRuX4aqdNyD7J+JDM
	EC3xYaxSlS1zNq0GUdkPSDG8jFs/x6nLDt+6PIfIrXAn5MEUwpgDy+U0K4sAAHgbDNtwgHgnK20nG
	wXSBS4m8Htq6qoc5x6zMG1x7Pt0oTbz5AJJ/xJGWZmJipRPONFjYKYn1MMSoUUCBnprqIj/Oxedfa
	YGKzXOsgIDrRjtV2+QRDG3+YBhLxC0/eXkSP6Jk9W2bYvxP11Z8Klnx4QFN6LnGzZe0/P4aQOCVpd
	5UgertcSGSTFwXX744TBd9PrV5W6UnD6LCDNX/iyi+rKBlz4wJbVobMcRpdD0TQWcMh3sGkV7mnmt
	wsrDARwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op2t1-00DmQo-93; Sun, 30 Oct 2022 07:37:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op2sx-00DmLo-BY
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 07:37:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 355B068AA6; Sun, 30 Oct 2022 08:37:24 +0100 (CET)
Date: Sun, 30 Oct 2022 08:37:24 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jinlong Chen <nickyc975@zju.edu.cn>
Cc: axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	bvanassche@acm.org, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [RESEND PATCH v2 1/3] blk-mq: remove redundant call to
 blk_freeze_queue_start in blk_mq_destroy_queue
Message-ID: <20221030073724.GB4131@lst.de>
References: <cover.1667107410.git.nickyc975@zju.edu.cn> <3a6d54a5adc8bd09aab28abfbe5f5b02bb863a8d.1667107410.git.nickyc975@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a6d54a5adc8bd09aab28abfbe5f5b02bb863a8d.1667107410.git.nickyc975@zju.edu.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_003735_561010_A76B9BD9 
X-CRM114-Status: GOOD (  10.32  )
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

> -	blk_freeze_queue(q);
> +
> +	/*
> +	 * blk_freeze_queue_start has been called in blk_queue_start_drain, we just
> +	 * need to wait.
> +	 */


This commit is not only pointless, but also exceeds the 80 character
limit.


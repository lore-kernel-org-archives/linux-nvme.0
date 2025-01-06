Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADD5E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 10:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TBOa3jtjw6o8r0ebY72lZHoS05QVgpeUFsaHsIZ8HAU=; b=EjxgA+3aQepsp3s9QEjYRLP+Gw
	cKFnKlo4puzlnhc/taEQz6uCIqQa/fZhhaDhHHLcO4RsVJKfqkUYWcP7t5aeYdi0d5A7witsL/TAX
	6LtEiZcZuAOu5UJqLKVfdqB41oP9W+LCXTg4mO882HD44yhl2CQJFi/iWZcGtugDLoT4McL0or+IO
	Svk5UwidONdPU7KMOlMA1tXGx93LRZjqYA0Jp1ZTKUc1YsCL8ZHXwg1Vt0lA/ylsefc8PHYGpPtm7
	pj5t8M8Ax1oJHoVnYBZ9toH3ukRADnAohEl2r9Mvs1Lkt21zPMhEqtKRkBn9IMrlEZH2l+IbMDBOM
	dRF9Uisg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUjwV-00000000mgH-483x;
	Mon, 06 Jan 2025 10:02:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUju8-00000000m1W-1iWL
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 10:00:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 605C167373; Mon,  6 Jan 2025 11:00:03 +0100 (CET)
Date: Mon, 6 Jan 2025 11:00:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH 2/3] block: Fix __blk_mq_update_nr_hw_queues() queue
 freeze and limits lock order
Message-ID: <20250106100002.GA20647@lst.de>
References: <20250104132522.247376-1-dlemoal@kernel.org> <20250104132522.247376-3-dlemoal@kernel.org> <20250106083014.GD18408@lst.de> <30064337-9fe1-47c7-b4ec-c999b06a1b47@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30064337-9fe1-47c7-b4ec-c999b06a1b47@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_020012_594224_DCF6DA7D 
X-CRM114-Status: GOOD (  18.89  )
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

On Mon, Jan 06, 2025 at 06:58:00PM +0900, Damien Le Moal wrote:
> Ah, yes, that would potentially be an issue... Hmmm... Maybe a better solution
> would be to move the start update out of the main loop and do it first, before
> the freeze. What I do not fully understand with the code of this function is
> that it does freeze and limit update for each tag list of the tag set, but
> there is only a single request queue for all of them. So I am confused. Why
> does the blk_mq_freeze_queue and poll limit setting have to be done in the loop
> multiple times for each tag list ? I do not see it... If we can move these out
> of the tag list loops, then correcting the ordering becomes easy.

I've come up with a version that simply never updates the flag. About
to send it out.



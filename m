Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8318EC38A02
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 09:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pzCbMm2JS6J2yY1k/2YXzfYAAjCdB4Blk5HqCh/KZ84=; b=cp6xsJ0PslgXrS647CWjAxmNKZ
	dxuhANxaPk+X1e7pmoJdc4UP0c6hQnE1tqYd8frwzaZV3jZqLUWhBSMGrBPIqe10nZwEXyGgGx+0G
	Dtivra5UPe2kgeToL0mvbwpxNOqXhfu/jUEec/OPcP6xSJC+j+Azqwld/0qairxuoRT5WrCpeoGLW
	Qoh8LsvPMK5sQk/L7bwMfRAH0oLTZfTLDKzi0Mg8XY+C7kswmEhjHMR71qDTSdfTqzQdfhQAgUZgU
	NeQAibtROKnXdeZ0tcK//FQ1iHyuN4OFfAC78+LvWiokDZqzJh2E9yHiBMZbp+0oG1tklL3jsiSf7
	OaSi0Vig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op4WE-00ElhE-TS; Sun, 30 Oct 2022 09:22:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1op4WD-00Elf5-0W
	for linux-nvme@lists.infradead.org; Sun, 30 Oct 2022 09:22:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C17168AA6; Sun, 30 Oct 2022 10:22:09 +0100 (CET)
Date: Sun, 30 Oct 2022 10:22:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>,
	Ming Lei <ming.lei@redhat.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 04/17] nvme: don't call nvme_kill_queues from
 nvme_remove_namespaces
Message-ID: <20221030092208.GC5643@lst.de>
References: <20221025144020.260458-1-hch@lst.de> <20221025144020.260458-5-hch@lst.de> <Y1ggN68V/mbAw1q2@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ggN68V/mbAw1q2@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221030_022213_218421_19277380 
X-CRM114-Status: GOOD (  12.67  )
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

On Tue, Oct 25, 2022 at 11:43:19AM -0600, Keith Busch wrote:
> We still need the flush_work(scan_work) prior to killing the queues.

Yes.

> It
> looks like it could safely be moved to nvme_stop_ctrl(), which might
> make it easier on everyone if it were there.

Hmm.  As Sagi pointed out this could become a bit more complicated due
to multipath, but in general I'd love to bring some more regularity
into the teardown path.


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BDECCD1BC
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Oct 2025 05:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GULdAbc9bXWwpLvySZZ0t+p/XEz4QcJiHA6tuooRSCs=; b=aLfvHKt6Cn8NEgt8QKc7swTIlO
	7itwsWEGcL7AjPmlAn3tYA8PJJV19Dz7hts4alS5yXsngZJL4RU88f7ZJSZxAcaFbxYHisXISdlnt
	vERb8CllywRaGGNR1yuDtoD6TsC2N3LzhNCqCvaQChwFYBP+2EItn+IdhIUhHZvghAA/nnUMWqRCc
	p06G4WAhn8gKLipK/1xcW9rPoPcpsrhg6yNl9PHuKknEchq+5QIw7+2wrn90QJXvVG5KH56KHBlA4
	LhYTf6kxWMFXKMEtS4tWUd2Y5WRRqym9qVJbGfoyR/HIvXrp2GIudAdNAJ/bQFup+Au26fryrhJOq
	8ZQ+OKOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBoHo-00000005ANH-2bFQ;
	Thu, 23 Oct 2025 05:54:56 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBoHm-00000005AMx-23xI;
	Thu, 23 Oct 2025 05:54:54 +0000
Date: Wed, 22 Oct 2025 22:54:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCH] nvme-multipath: fix lockdep WARN due to partition scan
 work
Message-ID: <aPnDLr2IiOQUQLKI@infradead.org>
References: <20251023001937.218014-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023001937.218014-1-shinichiro.kawasaki@wdc.com>
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

On Thu, Oct 23, 2025 at 09:19:37AM +0900, Shin'ichiro Kawasaki wrote:
> Blktests test cases nvme/014, 057 and 058 fail occasionally due to a
> lockdep WARN. As reported in the Closes tag URL, the WARN indicates that
> a deadlock can happen due to the dependency among disk->open_mutex,
> kblockd workqueue completion and partition_scan_work completion.
> 
> To avoid the lockdep WARN and the potential deadlock, cut the dependency
> by running the partition_scan_work not by kblockd workqueue but by
> nvme_wq.

The partition_scan_work was added in 1f021341eef4 ("nvme-multipath:
defer partition scanning") to get it out of the scan work to avoid
deadlocks.  I suspect moving it to the same workqueue might reintroduce
the deadlocks, so we might have to add a new workqueue here.  Keith
might remember more.


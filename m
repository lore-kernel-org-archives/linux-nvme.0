Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FFAC5B543
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 05:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LtWDMRMfth5ZbskpiCxD1Enmn2arhzcfKaISGVl+ecM=; b=n+UCmaChl02C6VdT2ZxUQygaZT
	doWdYYg53LOc3KussSimGbUARxKsZCAwfgCustWTeD+KPKM3IZtizAxzLg1WHRkhR4IReO7Kf38CO
	3VIApCRUuMJVossCI/uNEWnzl3Ajre727iYziWm8Ys371isnrdW6XS4zBVcOhnZcvlFRhPRlIW7JF
	+MASWGRjg1+nvIBDT+CNo/A7avDmEz6fcqJqLqN4qS/IzIhixL7XHtxB65zgXcLSREFTSaLzB8TPg
	wLWlNe9GanBa2Mvds3bNMyG5m0BCtD2wydO87iU9tRlZ663g9Tc+rCeyubteAn7P1AImZukEuDf9E
	IZNuoa3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOraw-00000005qVZ-3mFp;
	Tue, 10 Jun 2025 05:32:22 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOrZf-00000005qHo-2A2l;
	Tue, 10 Jun 2025 05:31:03 +0000
Date: Mon, 9 Jun 2025 22:31:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: Yi Zhang <yi.zhang@redhat.com>,
	linux-block <linux-block@vger.kernel.org>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [bug report] WARNING: CPU: 3 PID: 522 at block/genhd.c:144
 bdev_count_inflight_rw+0x26e/0x410
Message-ID: <aEfDF6rxPlT9ie1L@infradead.org>
References: <CAHj4cs-uWZcgHLLkE8JeDpkd-ddkWiZCQC_HWObS5D3TAKE9ng@mail.gmail.com>
 <dc30d40d-5724-9b54-e3a8-eb66980ddd9e@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc30d40d-5724-9b54-e3a8-eb66980ddd9e@huaweicloud.com>
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

On Tue, Jun 10, 2025 at 10:02:19AM +0800, Yu Kuai wrote:
> Looks like this problem is related to nvme mpath, and it's using
> bio based disk IO accounting. I'm not familiar with this driver,
> however, can you try the following bpftrace script to check if
> start request and end request are balanced? From the log I guess
> it's related to mpath error handler, probably requeuing I/O.

nvme-mpath is a bio based driver.  It is a bit special in that
it passed down the bio it recived through to the lower-level
request based nvme transport driver, while most remapping drivers
always clone a bio.  I suspect that is messing up I/O accounting
here somehow.



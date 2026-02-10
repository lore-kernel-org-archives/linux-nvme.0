Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17A8EA812A
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Cf7oVLvEA5ofKCK1bqURMjkS+zhH+c1dh+JIfRK6V0=; b=iIMDxjUDJb9GGIYS6oBvH9/dnq
	dc9W7Wo2cfGJv5CnrQbIh4Rk1NsRiOlQaambmzhpHLmHCGOM2Ky4bXGVtzih/xuZJDfLRiGwz4TMi
	EkNY48dxyy5u4vy0serVxBNNiltECmK5UBeQAxeRDhlxpXM5vtXnuzYRCTXTIGms5C23g5NH3tsEh
	/wpQeVSFAl3LKadzJa3JzM97z11uUJN/oNs07jFyqxOdwS/7BCny8semgKleSsYBknO728nq2mmUH
	h/+JYi8iIC2T6U12X9H/0Y2Hg2l5siYxJUGcQUrc0Yrx9SNOVGN/xuCCXl/zi/4ulvMNWDS+4NCIW
	K7qw6rGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vppMX-0000000H6ET-2OeF;
	Tue, 10 Feb 2026 15:09:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vppMV-0000000H6Dl-28ih;
	Tue, 10 Feb 2026 15:09:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D3D8B41991;
	Tue, 10 Feb 2026 15:09:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EE3C116C6;
	Tue, 10 Feb 2026 15:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770736150;
	bh=RWc0XQYaUIo9h9keSuMMl5oEGWchnZKzGDRh6J7qez0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WfI9CgwoIEKjF2S02bOBQh2GUZQtuetZc0hE9pMIo7pjUuilqn+tHDsIeiJNtozre
	 88TjRSfzBIxzL9RAviHOwF6F2Ra+M7hjx2k/11L+jhQdrBIfpqsFC3CREAz7VH83i8
	 otyELKTu4ItG+QFWv9oQON6WHi18QKPfGKlywix0Whto+yv4j/4JDjq/i0R4onh3Um
	 xlqYFkrNghmPv6HBh9zT935kP3hQeO7i0E6mFwkRU4OYxVcyImp1N3kq/YQNys77NY
	 RoM68TSCEPHi3RaG0zYi3hHcjOIFAXUjF9X5cBhowYE5EmwonEk5uIl6lRLrgkpPis
	 XJMHoPqNHIpmQ==
Date: Tue, 10 Feb 2026 08:09:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Yu Kuai <yukuai@fnnas.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, sagi@grimberg.me,
	sven@kernel.org, j@jannau.net, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, tj@kernel.org, nilay@linux.ibm.com,
	ming.lei@redhat.com, neal@gompa.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/4] nvme-apple: move blk_mq_update_nr_hw_queues after
 nvme_unfreeze
Message-ID: <aYtKFNm-wRKn6l66@kbusch-mbp>
References: <20260209082953.3053721-1-yukuai@fnnas.com>
 <20260209082953.3053721-4-yukuai@fnnas.com>
 <20260209145832.GC18315@lst.de>
 <aYn-xwFHCpd7sITJ@kbusch-mbp>
 <e3e7d95b-2712-4365-922d-731449e7193a@fnnas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3e7d95b-2712-4365-922d-731449e7193a@fnnas.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_070911_706409_DC222F1A 
X-CRM114-Status: GOOD (  13.95  )
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

On Tue, Feb 10, 2026 at 02:47:00PM +0800, Yu Kuai wrote:
> 在 2026/2/9 23:35, Keith Busch 写道:
> > We've left it frozen on purpose, though. The idea was to prevent new IO
> > from entering a hw context that's no longer backed by a hardware
> > resourse. Unfreezing prior opens that window up again. Maybe it's not a
> > big deal; I don't often encounter scenarios where the queue count
> > changes after a reset.
> 
> Do you think if there are new IO coming between nvme_unfreeze() and
> blk_mq_update_nr_hw_queues(), will be any race problems? If so, will it
> be helpful to move nvme_unquiesce_io_queues() after
> blk_mq_update_nr_hw_queues() so that new IO won't be issued to driver
> during the race window.

If you leave the queue quiesced, pending IO will form requests that are
entered and waiting in the block layer. You can't freeze a queue with
entered requests.

We unquiesce first to flush any pending IO that had entered during the
prior reset. It's not the best way to handle this situation. It would be
smarter to steal the bio's from all the entered requests, then end those
requests, then resubmit the bios after the hw queues are initialized. We
don't do that because no one's really complained, probably because the
queue counts don't usually change after a reset. But if the queue count
did change, we'd potentially see unexpected IO errors with the current
way we're handling resets.


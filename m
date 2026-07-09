Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA16C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 06:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ALIja5aIA7fRAiuH/UqorHNp5iN0g7LC/U8xpTVl2Qc=; b=uiW05H7z2YvTVNJ/ip49J6rYeE
	kpHUk5dHR/GtZ/lc9nzejQKO5VBSQdQETPhhyb9uPIm5+mn3Hs9IY4We9F3hDnEToWc4oQf/akISe
	ZaUfiFV4QuPI2jOYhYj+RW+qva7A5gfI4IyOLRb/q3qZ6D5GmatzNLF/KOC2O9Q8kSS17P31kYzL+
	YYtF28i86X4vpTv+uE2eJr470YuKZIhvKWjUIDJ5uRfPrHiaKvVVziNvOL/8OWp64vShZ4CfXdgTw
	ZbHQbnwBvWQSP3O5Fn8olcNOoBQcpC9ykfqvdr+7gtRPfyn6XdGuM/BePNHWS3E7ciyHrwCnAegzO
	Rip/Behg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whhza-000000017Xv-0xeA;
	Thu, 09 Jul 2026 06:12:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whhzW-000000017X2-2RQz
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 06:12:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D915468CFE; Thu,  9 Jul 2026 08:12:07 +0200 (CEST)
Date: Thu, 9 Jul 2026 08:12:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yu Kuai <yukuai@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Alasdair Kergon <agk@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>, Coly Li <colyli@fygo.io>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Josef Bacik <josef@toxicpanda.com>, Yu Kuai <yukuai@fygo.io>,
	Nilay Shroff <nilay@linux.ibm.com>, linux-block@vger.kernel.org,
	cgroups@vger.kernel.org, linux-nvme@lists.infradead.org,
	dm-devel@lists.linux.dev,
	"linux-bcache@vger.kernel.org Joseph Qi" <joseph.qi@linux.alibaba.com>
Subject: Re: [RFC PATCH v1 05/17] block: add bio_alloc_atomic() for atomic
 bio users
Message-ID: <20260709061207.GC16504@lst.de>
References: <20260704195124.1375075-1-yukuai@kernel.org> <20260704195124.1375075-6-yukuai@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704195124.1375075-6-yukuai@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_231210_770501_7948DFC3 
X-CRM114-Status: GOOD (  14.06  )
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

On Sun, Jul 05, 2026 at 03:51:12AM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai@fygo.io>
> 
> Add bio_alloc_atomic() for callers that need a GFP_ATOMIC bio from the
> default bio set but cannot safely pass a bdev during allocation. The
> helper returns an unattached bio, leaving callers to set bi_bdev and
> attach blkcg state explicitly before submission.
> 
> Use the helper for virtio-pmem flush child bios and OCFS2 heartbeat I/O.
> Both allocate bios from atomic paths and must avoid creating missing blkgs
> once blkg creation is protected by q->blkcg_mutex. virtio-pmem clones the
> parent bio's blkg association; OCFS2 binds heartbeat I/O to the root blkg.

Let's kill off the concept of atomic bio allocations instead.
Joseph already has an outstanding patch for nd_virtio that needs a little
bit more work, and ocfs2 should be easy enough as well.



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956D0C001DC
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 13:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U02wd4htSqt7Y5eM5jWEdbMbt96esE2ftHqIXKrolbY=; b=YrXLPjus+LPdoHjhuBvOKQdHIZ
	bkhus8zPfwMja4OIfFXhQ8v0v9w+g7Zp9ycfqbKh/AlzGYhYuv8t9Erb6bZPNxR8y4gwFk7Lw1bzs
	NzQNgFNl81xRlFVl5w7+mbp+buRWlEOQUGb/vThjW5AXiUEv0KI8YfhzdfBeVYlMO+sY18K9JFPwC
	Ur3q29a9dOsABzXjSBC9fsVxKuE1H6Qs+ddXXy16vLB2HaNvuGRf4Kgm+p/qwxZGJiFIZK1fvg0np
	ob+ExNSVoLUkAmDnR+zFkpzOYDA1FmxMWjG8N9ea2hCbuF9tvripGqqjYL0Qz3OcYMTxpuK2lT9tF
	4VL1jZsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZki-0003gW-2F;
	Wed, 12 Jul 2023 13:19:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJZkf-0003fj-1H
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 13:19:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 67AE967373; Wed, 12 Jul 2023 15:19:25 +0200 (CEST)
Date: Wed, 12 Jul 2023 15:19:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] blk-mq: add blk_mq_max_nr_hw_queues()
Message-ID: <20230712131925.GA14596@lst.de>
References: <20230712125455.1986455-1-ming.lei@redhat.com> <20230712125455.1986455-2-ming.lei@redhat.com> <20230712130017.GA12417@lst.de> <ZK6nm2koR+TfeMcs@ovpn-8-25.pek2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZK6nm2koR+TfeMcs@ovpn-8-25.pek2.redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_061929_578906_17A2DBCA 
X-CRM114-Status: GOOD (  15.16  )
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

On Wed, Jul 12, 2023 at 09:16:11PM +0800, Ming Lei wrote:
> The problem is that blk_mq_alloc_tag_set() forces to set nr_hw_queues
> as 1 for kdump kernel, that is why blk_mq_max_nr_hw_queues() has to
> return 1 for kdump kernel.

Well, let's fix that first and work from there.  Same argument against
that deep magic applies there as well.

> Thomas, can we disable managed irq for kdump kernel and switch to
> non-managed irq? Then we can avoid driver's change. I'd suggest
> this way if it is possible.

Why the heck would we?



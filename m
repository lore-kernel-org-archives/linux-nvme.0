Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595D6C04A6A
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 13:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Ju0sGDtBY2//f9KBiUd0kVvxU1e1eI9Zc23e/9Z2hA=; b=uXcGumeDjYBvXWfDLEZfQ9voaC
	j7OcM2A7Yf9ShGIaHUqw+2vlwot2YDIb8y5KyzQoWrZ2/SsUhriSiL3WoM+2bJ1yqb+kIyhbILJk3
	hgHbkIiaeb0fLi5VYf8pphlsAp5g42MsE4TKqqUWSz/dkKCeYQByMy/FS7MJruiUNRYRLhOLwrgNO
	QmmEBoif8iKZOMb05Jq+6Q/J2zPBJmvlBL0fWZlqahPVCwppiIvlYEf/uAqoO7BkS0gp+TJRoZtdR
	QOSr0wxbas2degAEplOULXvlOpQAXhgGTpvMVO3QSW/5oE5W7r8W8Kv7layjcAZZWquXOTPE8TXjb
	dBV09GIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTjTy-00546X-2x;
	Wed, 09 Aug 2023 13:44:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTjTw-00545F-1X
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 13:44:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 036E26732D; Wed,  9 Aug 2023 15:44:01 +0200 (CEST)
Date: Wed, 9 Aug 2023 15:44:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V3 01/14] blk-mq: add blk_mq_max_nr_hw_queues()
Message-ID: <20230809134401.GA31852@lst.de>
References: <20230808104239.146085-1-ming.lei@redhat.com> <20230808104239.146085-2-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808104239.146085-2-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_064412_684355_F9251F79 
X-CRM114-Status: GOOD (  12.95  )
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

I'm starting to sound like a broken record, but we can't just do random
is_kdump checks, and it's not going to get better by resending it again and
again.  If kdump kernels limit the number of possible CPUs, it needs to
reflected in cpu_possible_map and we need to use that information.



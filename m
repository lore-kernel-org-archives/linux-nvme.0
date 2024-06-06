Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A064C27C54
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Jun 2024 14:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O8GpG0KuWFomSMbvkTL0cP/NCyoCqvdU8XJn/qjoHJw=; b=3NVF2iLGrx9HKhlP9gYJ7x37sv
	kutRbO5X9pL9cqQCOvG9OQR2TEEnWAeSmbxjN7yUkPUQiZ/QoHSM1nPmMyOp4+AwoNztCEQzo2A+s
	Z5ghREzbOc06XKAstoaq7RwkxjoHHiydQ/9IH4UB3n+V+4FXKmRdK2im1fLbs+GjESzColgM6j/R0
	H4Ii4owyXc4RKBzSxhW1T+KdXgEklQL69ZM663V+iob+uRYFEaG/d/cd+aXZcuui4IBPACU1y+9P/
	716gDjIRYKGIu2E1im6NRyGOyoAPzNVZ6ZjfRTJvSfuyu8ViE/HP6O8kHQbElBToIbbTCPzzCrb2w
	a0dK1JvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFEU9-0000000A9aI-0fRl;
	Thu, 06 Jun 2024 14:53:01 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFETz-0000000A9Zf-3ZTU;
	Thu, 06 Jun 2024 14:52:51 +0000
Date: Thu, 6 Jun 2024 07:52:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: yebin <yebin@huaweicloud.com>, Christoph Hellwig <hch@infradead.org>,
	axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, Ye Bin <yebin10@huawei.com>,
	Zhang Yi <yizhan@redhat.com>, "Ewan D. Milne" <emilne@redhat.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] block: bio-integrity: fix potential null-ptr-deref in
 bio_integrity_free
Message-ID: <ZmHNQ56C6Ee01Kcv@infradead.org>
References: <20240606062655.2185006-1-yebin@huaweicloud.com>
 <ZmFatW3BEzTPgR7S@infradead.org>
 <66619EB6.4040002@huaweicloud.com>
 <ZmHH7mW0M80RaPlj@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmHH7mW0M80RaPlj@fedora>
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

On Thu, Jun 06, 2024 at 10:30:06PM +0800, Ming Lei wrote:
> Yeah, that is one area queue freezing can't cover logical block size
> change, but I'd suggest to put the logical bs check into submit_bio() or
> slow path of __bio_queue_enter() at least.

We really need an alignment check in submit_bio anyway, so doing it
under the freeze protection would also help with this.

> My concern is that nvme format is started without draining IO, and
> IO can be submitted to hardware when nvme FW is handling formatting.
> I am not sure if nvme FW can deal with this situation correctly.
> Ewan suggested to run 'nvme format' with exclusive nvme disk open, which
> needs nvme-cli change.

.. and doesn't protect against someone using a different tool anyway.

That beeing said, nvme_passthru_start actually freezes all queues
based on the commands supported an affects log, and
nvme_init_known_nvm_effects should force this even for controllers
not supporting the log or reporting bogus information.  So in general
the queue should be frozen during the actual format.



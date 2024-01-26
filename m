Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4F7C47DDF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jan 2024 14:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aWghsPDUn/IN+W3NhZuzm6LeybYPZZSldlm2p3BseMI=; b=V3GEZQfqBuObfB7oMfALGgeDnM
	CHshlK+eEv1obZF2nYkHvv2EWBgvi+aOCvEeYnaohum3VwFdTkh1b9P2zq0P82ufziEU/RZ0vNJyX
	6rGeRxtwDp1iZXoAJcJ4NODDTE91lfXsF6D6FWHSW7d6NXiVYm/oF4SUTe+arWnD73WooTZX/7xay
	AQC5fef1T1k4c7PC0b5daavGMdR1e6vzfIbbLiL9VeqspulwHL5zjfUwIOLDOleA8kdMwXaPqnsfT
	jRHf71ub1cXpeEVeCLpRlOWSOpXnw60jlMb9Q/GHx5Z/Ithl3IxMcKTakPdMB2DI9ceD51JMuxWmm
	tlAQewlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTMuX-00000004I0N-0JPE;
	Fri, 26 Jan 2024 14:10:25 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTMuV-00000004I0D-2yhd;
	Fri, 26 Jan 2024 14:10:23 +0000
Date: Fri, 26 Jan 2024 06:10:23 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: Re: [Report] requests are submitted to hardware in reverse order
 from nvme/virtio-blk queue_rqs()
Message-ID: <ZbO9T_R4lN_7WkwQ@infradead.org>
References: <ZbD7ups50ryrlJ/G@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbD7ups50ryrlJ/G@fedora>
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

On Wed, Jan 24, 2024 at 07:59:54PM +0800, Ming Lei wrote:
> Hello,
> 
> Requests are added to plug list in reverse order, and both virtio-blk
> and nvme retrieves request from plug list in order, so finally requests
> are submitted to hardware in reverse order via nvme_queue_rqs() or
> virtio_queue_rqs, see:

> May this reorder be one problem for virtio-blk and nvme-pci?

It it isn't really a problem for the drivers, but de-serializing
I/O patterns tends to be not good.  I know at least a couple cases
where this would hurt:

 - SSDs with sequential write detection
 - zoned SSDs with zoned append, as this now turns a sequential
   user write pattern into one that is fairly random
 - HDDs much prefer real sequential I/O, although until nvme HDDs
   go beyong the prototype stage that's probably not hitting this
   case yet

So yes, we should fix this.

> 
> 
> Thanks,
> Ming
> 
> 
---end quoted text---


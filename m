Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9591E77188
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2025 06:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9Djx6DI2B3ZjoP48qQTGcUespANUShDQ/vb2/CkNwP0=; b=3uFE3Y80YqqvHu2mUR8+RII/og
	YEf1hykts0fXBRK0RUtGIKEC/YpuN6SbyjuPIsv1sZLPM7igQ5no2nz1eulxvwOGn7ElmGR/F2RyT
	uSZjE6GRpgyOkRdfd9mpzsIR+RK5VLbna5BPIVM0iEfq7v+rVEiUDtMeiQlR4VvCdxlEx6xR0Kwt4
	f2as2G7+Qnzkbo4EYHno4rz8xKJC3KGpjs0XLerILp+SToWNRZCDa273QR/xtPARu5Is91+gLcw+H
	nr0H0Xq838KKWCWJ1ihaVhmtYU07uWoj+EpB2pus6DHo+iv+CORoqPf683FuOmFMkE5NrSZzw3JsP
	6Yfx111A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYJ56-0000000Dvkc-0XKC;
	Thu, 16 Jan 2025 06:10:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYJ53-0000000DvkH-13Fs
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jan 2025 06:10:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 168F568BFE; Thu, 16 Jan 2025 07:10:05 +0100 (CET)
Date: Thu, 16 Jan 2025 07:10:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Marco Patalano <mpatalan@redhat.com>,
	Ewan Milne <emilne@redhat.com>,
	James Smart <james.smart@broadcom.com>,
	Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [RFC PATCH] nvme-fc: move tagset removal to
 nvme_fc_delete_ctrl()
Message-ID: <20250116061004.GA25010@lst.de>
References: <20250113124446.830697-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113124446.830697-1-ming.lei@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_221013_441447_B54CFEAB 
X-CRM114-Status: GOOD (  19.71  )
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

On Mon, Jan 13, 2025 at 08:44:46PM +0800, Ming Lei wrote:
> Now target is removed from nvme_fc_ctrl_free() which is the ctrl->ref
> release handler. And even admin queue is unquiesced there, this way
> is definitely wrong because the ctr->ref is grabbed when submitting
> command.
> 
> And Marco observed that nvme_fc_ctrl_free() can be called from request
> completion code path, and trigger kernel warning since request completes
> from softirq context.
> 
> Fix the issue by moveing target removal into nvme_fc_delete_ctrl(),
> which is also aligned with nvme-tcp and nvme-rdma.
> 

Yeah, the current placement is wrong.  Can I talk someone to make
the whole setup/teardown process in nvme-fc match that of the other
fabrics (and slightly less so PCIe) order?  I know a long time ago
Sagi was atually looking into sharing more code as well, but that
would be a next step.

But I'd really like to have one known working sequence instead
of various different ones.



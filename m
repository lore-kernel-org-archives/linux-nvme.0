Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD32CED273
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 07:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ekUqwdnEDshqIZESq47cb8HiUPeNGpHUi2pc45CJPp0=; b=EsHfQsH8JTLOCwcBYKSa5RYEnM
	Q/zpqGyLhdm/vYorntgVfnvaQHB0kPd7+zc7/IYKTMfsP4HmzRTL4apP7Xuixx5TvsLWjOC5jHUkd
	ZjMmtOLXN3AcSAdkTAkA3Lx492LA9CeTGLP2a6fY+Zwkc2sPcQ8mYo0pVg70LIymqgptiVvaTxPMg
	gXLejDRgoJdnhz2rwRBXiDepv4Iq3rVfI3O/AAXXU/yA15aUDlAW6ZN2Gnkqd82LHdD0s9mB7pYur
	p7oOKQ6fwWvUjBVsI3CDfZO25PpD8C6CpGz4CDPNSeF1jomgnYpZOyhhNeVwZGGbcMO1TW60aMQjR
	0HFk18Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy4Ih-00000004kWC-0HdA;
	Tue, 08 Oct 2024 07:06:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy4HJ-00000004kC4-3a7l
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 07:05:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A4AB0227A8E; Tue,  8 Oct 2024 09:04:59 +0200 (CEST)
Date: Tue, 8 Oct 2024 09:04:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com,
	dlemoal@kernel.org, gjoyce@linux.ibm.com
Subject: Re: [PATCH v3 2/3] nvme: make keep-alive synchronous operation
Message-ID: <20241008070459.GA22711@lst.de>
References: <20241008062210.1094083-1-nilay@linux.ibm.com> <20241008062210.1094083-3-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008062210.1094083-3-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_000506_144429_CC1CEA64 
X-CRM114-Status: GOOD (  14.80  )
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

On Tue, Oct 08, 2024 at 11:51:51AM +0530, Nilay Shroff wrote:
> This fix helps avoid race by implementing keep-alive as a synchronous
> operation so that admin queue-usage ref counter is decremented only

Please spell out q_usage_counter as requested in the first round.

> after keep-alive command finish execution and returns its status. This
> would ensure that we don't inadvertently destroy the fabric admin queue
> until we finish processing of nvme keep-alive request and its status and
> hence it's safe to delete the queue.

I still fail to see why this requires a synchronous operation vs just
calling blk_mq_free_request and thus decrementing q_usage_counter
afrer checking the controller state.

Maybe I'm just dumb and missing the obvious even after the last
explanation, but then the commit log needs to be improved to explain
it.


> -static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
> -						 blk_status_t status)
> +static void nvme_keep_alive_finish(struct request *rq,
> +				blk_status_t status,
> +				struct nvme_ctrl *ctrl)

And as a nipick, this should be:

static void nvme_keep_alive_finish(struct request *rq, blk_status_t status,
		struct nvme_ctrl *ctrl)



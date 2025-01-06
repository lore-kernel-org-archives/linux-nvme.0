Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C23E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 10:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fhbOPqszPdCBwTFicMGrn2/LOi//kpDeoXaRV65HYRw=; b=hnOVw7GVKZQ6BvOPVXbfvWRKIp
	uOaGsi9XcAXvXtSkbSNWyadZOEu6PWDATj3syysDgi+w4DmXt7tMknIrtsljw/w0RN/H5ujLMi5DR
	jFftMD0w1bcwsMLvakwn+bN31lfXi9/8lcjG3HIpcNGM34RikBxRaTt7LNuBXV/+rpdDoRReg9trK
	20lun62WRFb6xR4+WkFKM0fvg9tBjwVtP5cf4WbbiiNDMzhSmcuSMsB/p7uSZivMwrBADZtERi+hI
	FDymjtIgtalaZNzZKoZ3sdPg7eAhOCwvqDF5qs6Nk0NmSy3LKmxqEAXArgiq06+HwUTJhiyVZIicN
	3H9d00aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkpu-00000000xG1-2MWj;
	Mon, 06 Jan 2025 10:59:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkpC-00000000x2P-1JjD
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 10:59:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6422968CFE; Mon,  6 Jan 2025 11:59:05 +0100 (CET)
Date: Mon, 6 Jan 2025 11:59:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	nbd@other.debian.org, virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH 05/10] block: don't update BLK_FEAT_POLL in
 __blk_mq_update_nr_hw_queues
Message-ID: <20250106105905.GB21833@lst.de>
References: <20250106100645.850445-1-hch@lst.de> <20250106100645.850445-6-hch@lst.de> <1538d5e9-eb59-49a7-90c8-77a290f3a420@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538d5e9-eb59-49a7-90c8-77a290f3a420@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_025910_489656_67E37DB3 
X-CRM114-Status: GOOD (  13.37  )
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

On Mon, Jan 06, 2025 at 07:55:30PM +0900, Damien Le Moal wrote:
> > +	lim->features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT | BLK_FEAT_POLL;
> 
> Why set BLK_FEAT_POLL unconditionally ? This is changing the current default
> for many devices, no ?

Due to the runtime check it doesn't actually change behavior.  But
it does change the value read from sysfs, which also need extra check
for poll queues.  But the entire point is that we don't have to update
this field when updating the queues, so yes it should be set
unconditonally.


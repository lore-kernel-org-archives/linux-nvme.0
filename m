Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053B5C61DD3
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Sep 2026 16:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T/YOOseWj7d0aPZofk1RZEGl9B3QOfC7x7pcs6/yHNc=; b=vqkHN1jbTXEHD3aP2Iv49IB+gp
	shrlKRW+0RDkVFRhqeYtG6DyIX0krx2exmlS6drJ+t2wjTjsvSBcT41P7issH/iNa+UQiRXI5NzJz
	uY6uHYmaZyNBdgusOeFENXMk7TRoTM9+3+DjBDsFt7rg9lUzA3eVLFxVq17WKqMmEjFQRxXNLh1fw
	eJQ864+JmRBwuFo+izEmF4ari2KLnY3qOwKv28c/WKyTulG5hcS/fOweB9dS3yic5015AydLYXicD
	dRleDasp8ESu20Vd/+tuA0FXMNMsIRvDIx9k0aH26otHUo6pK0Vkc3Y1odte8A1OKAlhUDIkyPUzl
	/TdzdL+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1RWm-0000000CgnR-1SNp;
	Tue, 01 Sep 2026 16:40:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1RWj-0000000CgmP-3pw3
	for linux-nvme@lists.infradead.org;
	Tue, 01 Sep 2026 16:40:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 48AC740D93;
	Tue,  1 Sep 2026 16:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D134C1F000E9;
	Tue,  1 Sep 2026 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788280801;
	bh=T/YOOseWj7d0aPZofk1RZEGl9B3QOfC7x7pcs6/yHNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J2aLdI52wl6RtUX3HFGllzgTaOhLVSaVXlgxNYo6cgS+uTD1iTGNLv5EhVnkRp1OW
	 NFwUy/XhE8sgJBCDi7YioQIOXB5jbArNtzbIggmZ02xMH7YsQE2kNzGpExtfSbMjMU
	 43pwQLbGYsiT7BaNSKhzdiNpreLfyRTSzIcNSLoz4YndUDeX8am2vMfoHYAyA97WYW
	 ZfrrdWdje+oxZizicJfvlzMRG5rp05OYXiYZirxjv9VSvwL8d9Ahx1+6p3623R0gT0
	 lwmdKu+T6N4F+8nD1tSjTxR7TLW+U0aRk5Xe89FFxidrmOt1vARU7xOVX78b6jETZN
	 qtuA3GmwuRr6Q==
Date: Tue, 1 Sep 2026 10:39:59 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
	axboe@fb.com, john.g.garry@oracle.com, wenxiong@linux.ibm.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH 1/2] nvme: keep transport module referenced while head
 node is open
Message-ID: <apb_3yu6G0dx_rWe@kbusch-mbp>
References: <20260831152006.819471-1-nilay@linux.ibm.com>
 <20260831152006.819471-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831152006.819471-2-nilay@linux.ibm.com>
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

On Mon, Aug 31, 2026 at 08:49:54PM +0530, Nilay Shroff wrote:
> +static inline int nvme_module_get(struct nvme_ns *ns, unsigned int count)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < count; i++) {
> +		if (!try_module_get(ns->ctrl->ops->module))
> +			goto out_unwind;
> +	}
> +
> +	return 0;
> +out_unwind:
> +	while (i--)
> +		module_put(ns->ctrl->ops->module);
> +	return -ENXIO;
> +}
> +
> +static inline void nvme_module_put(struct nvme_ns *ns, unsigned int count)
> +{
> +	while (count--)
> +		module_put(ns->ctrl->ops->module);
> +}

Thanks, looks correct to me.

I don't like the looping though. This could be done in a single
atomic_sub instead of multiple atomic_dec calls if the module api
provided something to get/put many references.


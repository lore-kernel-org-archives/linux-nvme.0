Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F21DC10F14
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 11:38:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DE72053B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 11:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OdJbl0K6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DE72053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=FDbRaVGMua94Cde7JOrJd/aHRf7aXYN4Gv2wauP/fOo=; b=OdJbl0K6tdU4d9
	uPm8S2FHL0zJdtZrr6rdU2FFyOG3eHR8llLMkiQOxeHylIjvRgH4BdJZYZS/uk0ixEzOvPfIZYiW8
	L6dFKUo5l/wTWTg+A8eZo5PCMxC7xMnISZvxB+CUkYMQkaIg+M2ooAW8N/AbgFCsYoESNZaak60Tf
	Mr/1qsUhHXLr9RSmcWFVW/p+uZHnL8i/Wa9c1YLoP/Wp9Kc1FH68r6Us0AUM4vSnGlODSO34ii/xb
	Czvf3Bj0YxhtqmmSynfYI3wBWBQCZu/RFCbKcdgD9Kg6CLEbHnmDa9s6gG5Zuh95mA4A7xwsMldaf
	Akv4XQ2Fh40DLHJBGFNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIWle-00013Y-EY; Thu, 10 Oct 2019 11:38:02 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIWla-00011K-Tc
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 11:38:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 22A1F68C65; Thu, 10 Oct 2019 13:37:54 +0200 (CEST)
Date: Thu, 10 Oct 2019 13:37:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v9 01/12] nvme-core: introduce nvme_ctrl_get_by_path()
Message-ID: <20191010113754.GA28921@lst.de>
References: <20191009192530.13079-1-logang@deltatee.com>
 <20191009192530.13079-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191009192530.13079-2-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_043759_098100_7BB75F95 
X-CRM114-Status: UNSURE (   9.76  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Stephen Bates <sbates@raithlin.com>,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 linux-fsdevel@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> +struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
> +{
> +	struct nvme_ctrl *ctrl;
> +	struct file *f;
> +
> +	f = filp_open(path, O_RDWR, 0);
> +	if (IS_ERR(f))
> +		return ERR_CAST(f);
> +
> +	if (f->f_op != &nvme_dev_fops) {
> +		ctrl = ERR_PTR(-EINVAL);
> +		goto out_close;
> +	}
> +
> +	ctrl = f->private_data;
> +	nvme_get_ctrl(ctrl);
> +
> +out_close:
> +	filp_close(f, NULL);
> +
> +	return ctrl;

No need for the empty line here.  Also can you make sure this new
code (and all the new exports) are only enabled if
CONFIG_NVME_TARGET_PASSTHRU is set.  Preferably by having a little
block at the end of this file with this function and the extra
exports with a big fat comment that they are only for nvmet-passthrough.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

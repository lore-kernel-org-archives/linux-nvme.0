Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA86C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Jun 2022 21:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6pPM0pNmBD4zMqykT9O56gdL7mYFL46WUkKIKyvKvK4=; b=ax5rcXN+RwZbRmCgc5regnvmPU
	tonlvQJONRrUZRKD1R0aj2yLcov06BNF222fst9R5BvpL0pw1tiMIZEjGpl5Iw2cSLaX6XfCOga2+
	Byexn4/GDuLiVaI7hVP4TBQT6l7E2ZXAg0ISl8ZHavxNxLfwUfjLWh5nt0lx7s6ij2ySytIy+c9Rk
	xsJP/rfvG6aO2wa8MVB9nKTHCw0e+CsgNlmDm2QURvUd5t2TV0CY0NV7KyICtFWMtZyM3/XsDjal6
	Irr14ZB/VwzfaqcJBvFE6ndvb4buqFpNyVzWiEse+H+lO4vVHiVg9g1d4a+jjj9WdI0WB/cQ4LB82
	rUekieAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1E77-00BPgJ-OL; Tue, 14 Jun 2022 21:30:17 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1E74-00BPf5-3Q
	for linux-nvme@lists.infradead.org; Tue, 14 Jun 2022 21:30:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 7A80DB81ACE;
	Tue, 14 Jun 2022 21:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FE1C3411B;
	Tue, 14 Jun 2022 21:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655242211;
	bh=MAO6Ltn+ZJDp9ipd0GNmKkEUG7gekxxwFt5tgjHOFDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q3idHCxoibq4SDFqLrq2RDnuUjW27Qd1UgHVoUSCnPF5r0HLZ79uHrPMrNsurhzpW
	 HBcY8duYJ7NLKsLXlb0E0/zRE+lMh9ikoFposs7cVslt8FJVg6Pdwa8TQgeaewqa9M
	 NGe2NHiBy59OT5b9aN5ICkmaA8L0px6mtXEu6L8BdGpMlDPy9wGJ9tAWlFIryY+biP
	 4AM1i+wYXC/JWmEA4LU/IuKMqmrVUscrfuGLY2EcrRb6MWUHsxUtiHFMpemuzETag3
	 aSA+AjKyRQ8VNluFfeluLSdaudBizyo4Nzz0ux+bu7K20uzh8ORK96dpN0v2VrxJvv
	 OT4zHPNpaS+9Q==
Date: Tue, 14 Jun 2022 14:30:08 -0700
From: Keith Busch <kbusch@kernel.org>
To: Erwan Velu <erwanaliasr1@gmail.com>
Cc: Erwan Velu <e.velu@criteo.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] nvme: Report model,sn,fw,pci device information
 during init
Message-ID: <Yqj94JXMwjrdSbqG@kbusch-mbp.dhcp.thefacebook.com>
References: <20220614210902.744318-1-e.velu@criteo.com>
 <20220614210902.744318-2-e.velu@criteo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614210902.744318-2-e.velu@criteo.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220614_143014_369091_78B1EBD4 
X-CRM114-Status: GOOD (  13.08  )
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

On Tue, Jun 14, 2022 at 11:09:02PM +0200, Erwan Velu wrote:
> @@ -2982,6 +2982,14 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>  		return -EIO;
>  	}
>  
> +	/* Reporting model, serial, firmware and pci info */
> +	dev_info(ctrl->device, "MODEL:%s SN:%s FW:%s PCI_ID:%04x:%04x\n",
> +			id->mn,
> +			id->sn,
> +			id->fr,
> +			le16_to_cpu(id->vid),
> +			le16_to_cpu(id->ssvid));

We don't need to print this on every controller reset, so I think this needs to
be within the "if (!ctrl->identified)" block.

And since you can't just null terminate the these strings, you should use the
"%*s" format.

I'm unsure if the serial number should be logged. Firmware and model are
probably fine.


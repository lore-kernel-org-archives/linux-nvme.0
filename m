Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA909ECAAA1
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Oct 2022 16:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YqFMr+y3FuH/LzlprYkE6eER8h1MmSl+mQbWsZZGwPs=; b=GalculC6XeYyDgseAaHiIXSjvq
	6SIyoYPq/GD1zlEL2ysppDECvkkurw2Lt8AP5Ac/4DEGtEd9gLbbls2fc7g40z3MbJzOYtB4M0iIm
	MDygOKITI35vI/4E4xW19xOgqP6KX2hVp2Jk2hf8xkJczWPZzS5MpYcozOf0kdb6nPnl1m7O2alde
	JBYVyjJTlt8krLH9NSSOkAX8amYX05j6j84tCPvSfd9u0ONtAlnlz9SIKhaODw6ZyuvsOtKSOOm00
	wgpaQ547WZQzZC7UIy4ld0rUffM/Qd3kz6pwmQBVTfkU6qG/sM4sQNub5dw/JFg80szYqcYjrgzo/
	aInGzRjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo6AT-00EHLs-C6; Thu, 27 Oct 2022 16:55:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oo6AQ-00EHLW-Kr
	for linux-nvme@lists.infradead.org; Thu, 27 Oct 2022 16:55:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D8687623E8;
	Thu, 27 Oct 2022 16:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C26C433D6;
	Thu, 27 Oct 2022 16:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666889741;
	bh=uccxrnqaLCAMOdR5eDLbGokOMxjtm7Qd7j91ygHL114=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNhaPUrkUH6wznmeig3xkIfNNfjczf7KB24hgD9JWsuzv+LXKpTdjJ4Z740Xu9jKQ
	 4OUSUd7/ITkrj06VPUpwWAWD61DSszExVZydZ+u1n/E4QxpovgHG9Z8GoreUfBAzEc
	 hYp3fxsZkx0Vw/O7iso4vVGjIUNcdJ2oNZWEfN6lw2LrJGDMXvrB3qMnT7cGFXPcv7
	 XQamaWeUARqdjsHqfQiDaTJrfD0FtDvZ+xLB98ZsF8uYWAsjKHM+dOv8ZbVqqylgcb
	 CnJ59vjDopHkNJ8+N12lgQJ/XrOQpkTjIeSiXY2WPCf0D/YTCtKG1XZpQajlRUvkiw
	 aV0owwZctQy2w==
Date: Thu, 27 Oct 2022 10:55:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Joel Granados <j.granados@samsung.com>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
	gost.dev@samsung.com, joshi.k@samsung.com, javier.gonz@samsung.com,
	p.raghav@samsung.com
Subject: Re: [RFC 3/3] nvme : Add ioctl to query nvme attributes
Message-ID: <Y1q4Cjg1cv9w+YWR@kbusch-mbp.dhcp.thefacebook.com>
References: <20221027155724.1161670-1-j.granados@samsung.com>
 <CGME20221027160108eucas1p2722b30a1be27a855e2b0f2495fed15ab@eucas1p2.samsung.com>
 <20221027155724.1161670-4-j.granados@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027155724.1161670-4-j.granados@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221027_095542_779956_F002FD0E 
X-CRM114-Status: GOOD (  15.67  )
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

On Thu, Oct 27, 2022 at 05:57:24PM +0200, Joel Granados wrote:
> +{
> +	int ret;
> +	struct nvme_id_ctrl *id_ctrl;
> +	struct nvme_get_attr nvme_get_attr = {0};
> +	struct nvme_id_ctrl_nvm *id_ctrl_nvm;
> +	__u32 usize;
> +
> +	BUILD_BUG_ON(sizeof(struct nvme_get_attr) < NVME_IOCTL_GET_ATTR_V0SZ);
> +	BUILD_BUG_ON(sizeof(struct nvme_get_attr) != NVME_IOCTL_GET_ATTR_CURSZ);
> +
> +	if (copy_from_user(&nvme_get_attr, arg, 2 * sizeof(__u32)))
> +		return -EFAULT;
> +
> +	if (nvme_get_attr.flags != 0)
> +		return -EINVAL;
> +
> +	switch (nvme_get_attr.argsz) {
> +	case NVME_IOCTL_GET_ATTR_V0SZ:
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	usize = nvme_get_attr.argsz;
> +
> +	ret = nvme_identify_ctrl(ctrl, &id_ctrl);
> +	if (ret)
> +		return ret;
> +
> +	ret = nvme_identify_cs_ctrl(ctrl, &id_ctrl_nvm);
> +	if (ret)
> +		return ret;
> +
> +	nvme_get_attr.argsz = NVME_IOCTL_GET_ATTR_CURSZ;
> +	nvme_get_attr.mpsmin = NVME_CAP_MPSMIN(ctrl->cap);
> +	nvme_get_attr.vsl = id_ctrl_nvm->vsl;
> +	nvme_get_attr.wzsl = id_ctrl_nvm->wzsl;
> +	nvme_get_attr.wusl = id_ctrl_nvm->wusl;
> +	nvme_get_attr.dmrl = id_ctrl_nvm->dmrl;
> +	nvme_get_attr.dmsl = id_ctrl_nvm->dmsl;
> +	nvme_get_attr.dmrsl = id_ctrl_nvm->dmrsl;
> +	nvme_get_attr.oncs = id_ctrl->oncs;
> +	nvme_get_attr.mdts = id_ctrl->mdts;

You already have the 'struct nvme_ctrl' that saves nearly all these
values. We shouldn't need to send new IO when you can just reference the
cached values instead.

> +struct nvme_get_attr {
> +	__u32	argsz;
> +	__u32	flags;
> +
> +	/*
> +	 * Memory Page Size MINimum : The host should not configure a page size that
> +	 * is larger than (2 ^ (12 + mpsmin)). Comes from [3]
> +	 */
> +	__u32	mpsmin;
> +
> +	/*
> +	 * Verify Size Limit : Recommended or supported data size for a verify
> +	 * command. From [2].
> +	 */
> +	__u8	vsl;
> +
> +	/*
> +	 * Write Zeroes Size Limit : Recommended or supported data size for a
> +	 * zeroes command. From [2].
> +	 */
> +	__u8	wzsl;
> +
> +	/*
> +	 * Write Uncorrected Size Limit : Recommended or supported data size for
> +	 * an uncorrected command. From [2].
> +	 */
> +	__u8	wusl;
> +
> +	/*
> +	 * Dataset Management Ranges Limit : Recommended or supported maximum
> +	 * number of logical block ranges for the Dataset Management Command.
> +	 * From [2].
> +	 */
> +	__u8	dmrl;
> +
> +	/*
> +	 * Dataset Management Size Limit : Recommended or supported maximum of
> +	 * total number of logical blocks for a Dataset Management Command.
> +	 * From [2].
> +	 */
> +	__le64	dmsl;
> +
> +	/*
> +	 * Dataset Management Range Size Limit : Recommended or supported maximum
> +	 * number of logical blocks in a range of a Dataset Management Command.
> +	 * From [2].
> +	 */
> +	__le32	dmrsl;
> +
> +	/*
> +	 * Optional NVM Command Support. Is needed to make sense of attributes
> +	 * like vsl, wzsl, wusl... Comes from [1].
> +	 */
> +	__le16	oncs;

Don't use the little-endian format for values that are not going over
the wire.


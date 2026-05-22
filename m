Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F00CD5BB3
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 15:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=slCSFqh3ovqTYMYBEmC2mxVNKxCOIPgFlRns58S1SIo=; b=XA7yXBLlACeSDsFmHwbyeqY7ir
	sEhuzdogVJcG7DFVZt5JoLe0kJTkqYx+0Ay3UUpWZUDLisVM8I00NDQAisJLxYc4PJ80uZ1I4VdwC
	apKM7QJTquEWsLM8tJBjYuGveuFSqxTaCNAS0bk51WeZ+rUibo0uZkvWtL01IEYZ0oTRo2pDX5WEU
	RS4O+Rw5t3SffLwQ9aMnCcFpO166PF1HhEC0nlWlt8B8sxPofa3khfRoWomaiW+n78C3tKhLNWGuu
	j/3ByBiF0Pz5pbnPyr+ZE1sbvrPpcnZHPE1AeFSfLMiV4roN2lWeKWlrwg2O96bmFag1UXOKz6ktK
	P70PvQmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQS4b-0000000BJxd-20BN;
	Fri, 22 May 2026 15:46:05 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQS4a-0000000BJxK-03gv
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 15:46:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5073260138;
	Fri, 22 May 2026 15:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A991F000E9;
	Fri, 22 May 2026 15:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779464763;
	bh=slCSFqh3ovqTYMYBEmC2mxVNKxCOIPgFlRns58S1SIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZoEwM3X7Cin7xpQyIqelhsTfiBvpax921aItIcW4dfy4CYNK8XY9ysLQuhZwUErwD
	 5PhYmBRAkaMagPpoblMzhE98xxIZgmLJ5iCRUk7M1pYFmIb/a61HJjJGGn1jG/4M+r
	 GJmKdPWMMcnk0pKrR9+PJoEFcH8dz9WtVoo7uvIU0pRjYe+fjeuzc6ObIcrxOnC4XW
	 4cIn908EAtlb1VPK6qPTCcP29otXBncT3ot2amxXK8kYeBXBDBW2PC1qvKCzKOEpe8
	 xYv35NTNo80lScvVAgtpemrpnj75gTBFOUMibDNKSOGm7Rxg6rix2cOIuh/hKhegzb
	 UJRNTi6IHJofQ==
Date: Fri, 22 May 2026 09:46:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@kernel.dk>,
	Tatsuya Sasaki <tatsuya6.sasaki@kioxia.com>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v3] nvme: reject keep-alive passthrough on non-fabrics
Message-ID: <ahB6OCXQIYVvEW4m@kbusch-mbp>
References: <20260522152807.2061501-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522152807.2061501-1-coshi036@gmail.com>
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

On Fri, May 22, 2026 at 11:28:07AM -0400, Chao Shi wrote:
> +static bool nvme_passthru_cmd_allowed(struct nvme_ctrl *ctrl,
> +				      struct nvme_command *c)
> +{
> +	if (c->common.opcode != nvme_admin_set_features)
> +		return true;
> +
> +	switch (le32_to_cpu(c->common.cdw10) & 0xff) {
> +	case NVME_FEAT_KATO:
> +		/*
> +		 * Keep Alive is optional on PCIe (NVMe 2.0a 5.27.1.12) and the
> +		 * driver only arms keep-alive for fabrics.  Enabling it on
> +		 * other transports starts a keep-alive command the driver is
> +		 * not set up for and harms idle power states, so reject it.
> +		 */
> +		return ctrl->ops->flags & NVME_F_FABRICS;
> +	default:
> +		return true;
> +	}
> +}
> +
>  /*
>   * Convert integer values from ioctl structures to user pointers, silently
>   * ignoring the upper bits in the compat case to match behaviour of 32-bit
> @@ -311,6 +338,9 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  	if (!nvme_cmd_allowed(ns, &c, 0, open_for_write))
>  		return -EACCES;
>  
> +	if (!nvme_passthru_cmd_allowed(ctrl, &c))
> +		return -EOPNOTSUPP;

You you have check if it's an admin command first. This going to break
the "Data Set Management" IO command.


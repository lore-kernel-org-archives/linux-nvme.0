Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE425C433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 02:57:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B83F20874
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 02:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GZ26Eg0D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIsWctIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B83F20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=e/ArRKvokflAICS7KNDmwxS/nsh4SnfK9zpZf3nP4v0=; b=GZ26Eg0D22KKh+9RFpjZ4lfc3
	qPxQnn8r6SRBNe2ImOucSUaLSkPvhFg+OTIQKjTte5g6fDnA5QzrwKTg71qNzkrjDwBhkidjNxWeJ
	ms77qiJjthEeuZde+dslfliLHBmq3xV9INQoszPCLjVRYhv3iTd4XXiSiYgwPskAB1CpCbRVGL6zg
	fble8AtfuT2ZSsmpncKmVcJ3CTAqx5nYE6xP0WXC3jLjz7krByBmQQkfZj/xjIDVv8l/+yglsl9PL
	dD/4p3zlnrtzh48R9BMahjp7IknLQB/Y0lSDIIz6847c3JOs7y4XGcgl8fMvlR/5zl9dHRTEJJLjt
	4HddZyz2w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jnvbI-0004JG-CO; Wed, 24 Jun 2020 02:57:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jnvbC-0004H8-SH
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 02:57:19 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 822C220874;
 Wed, 24 Jun 2020 02:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592967438;
 bh=ewh6p58MBLQ+gBYZH4UM+PqcqXmU3rYIoDXVYdQQtHg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dIsWctIph+e7PUso+GGP/OZF0slRBaqcrwDuqs4IdtwvkDQf0ei15DA9RHYQA34di
 TlzuWgUk7OV5zgG3HQszMI/pB9MwpDomnMPmuoaloL8h+JaEMKyCJIBFGYgzVok3l0
 Ji0U4/GwfqaKlqGTZ/GKW+mUjBHeSq33QEjT7/GI=
Date: Tue, 23 Jun 2020 19:57:15 -0700
From: Keith Busch <kbusch@kernel.org>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: [PATCH 1/3] nvme: Add Arbitration Burst support
Message-ID: <20200624025715.GB1291930@dhcp-10-100-145-180.wdl.wdc.com>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com>
 <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bf3f47ba50f72d0b775ca4bd098f183056d964ba.1592916850.git.baolin.wang@linux.alibaba.com>
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
Cc: sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@fb.com, baolin.wang7@gmail.com,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 23, 2020 at 09:24:32PM +0800, Baolin Wang wrote:
> +void nvme_set_arbitration_burst(struct nvme_ctrl *ctrl)
> +{
> +	u32 result;
> +	int status;
> +
> +	if (!ctrl->rab)
> +		return;
> +
> +	/*
> +	 * The Arbitration Burst setting indicates the maximum number of
> +	 * commands that the controller may launch at one time from a
> +	 * particular Submission Queue. It is recommended that host software
> +	 * configure the Arbitration Burst setting as close to the recommended
> +	 * value by the controller as possible.
> +	 */
> +	status = nvme_set_features(ctrl, NVME_FEAT_ARBITRATION, ctrl->rab,

Since 'rab' is an 8-bit field, but the feature's AB value is only 3
bits, we should add a validity check.

> +}
> +EXPORT_SYMBOL_GPL(nvme_set_arbitration_burst);

I don't see any particular reason to export this function just for the
pci transport to use. Just make it a local static function an call it
from nvme_init_identify().

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

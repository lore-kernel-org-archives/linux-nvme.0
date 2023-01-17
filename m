Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7926EC63797
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Jan 2023 10:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y/G+sw03gTsx6qTNPvBUjx2Dsgp76clgc6/fCvGLxSA=; b=NC0fQgHNIrxdq5mvDwZW1kOzR5
	hX4QDUCLZtUrX5OkamScmrwGC9IRtumvHRSTIh4AnARhIxaeQJEqrV9twZKAzwdBWoIAL3lYaLPpT
	qt1QcoX/Qbb+SEdjgnumteFe1JlognKN4Yk/+q+zQlppUdBMTUj73Q6lgPDNNW3acwHJQv142jaZV
	8h6B7A5bxHchtwSq8xUYL6dmdHNhGOfaIow0260pWAmJhD6D82Q5SrzVusS1z/4G8yko5PmqXNWIP
	/AR+HwviZ6psWsgm2tiB2BWCNRyvOIQpvU+XBcxy/D+HbGeprCC8gN8M5lBQuCtgUbsOY/rQjXiH3
	EtPnXfzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHjXz-00Dqhp-Fs; Tue, 17 Jan 2023 10:50:31 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pHjXx-00DqgW-0w; Tue, 17 Jan 2023 10:50:29 +0000
Date: Tue, 17 Jan 2023 02:50:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@infradead.org, kbusch@kernel.org,
	sagi@grimberg.me, israelr@nvidia.com, chaitanyak@nvidia.com
Subject: Re: [PATCH 1/3] nvme-fabrics: introduce existing_ctrl operation
Message-ID: <Y8Z9dGLWgGxCor+N@infradead.org>
References: <20230115100341.40347-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230115100341.40347-1-mgurtovoy@nvidia.com>
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

> +	if (ops->existing_ctrl) {
> +		if (!opts->duplicate_connect && ops->existing_ctrl(opts)) {

Nitpick, but the logic would read easier at least to me as:

	if (!opts->duplicate_connect &&
            ops->existing_ctrl && ops->existing_ctrl(opts)) {

I can fix this up if we get some more positive reviews and this gets
applied.


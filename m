Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB8CC43602
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jul 2026 04:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Qah2y0SaLCXR6gXurgUrTFa2uLuL2kbocBKf0t1JfU=; b=Sg49UAtFajzyC9zG9QYHG2tfAG
	+QahL85TulycwN6gd5w5Qz9FdrH3sormGGK44fN6apzYuWpAcgiHzeptzMvzYyvQXa7PtZqL+TdUY
	JjJTTRKtIo3VQlWBxsE4V6Ws9WdJGVBS4uRdwMouzOkwfypfJdfWjAKiwsMcQBvpNoLi/TFLhWAuQ
	uOhRMwimfWVy5jnILwEqr1apb5TQvrQJexLNqqzHnztr5z4St9/C4+pfZRi6hwM8GXaw9oAvukwQR
	uINFKM5RiZnQLZ9hRG1DwkwLdS+c3G/zJL5YsDXyRgB3obXcO7aL52L0M9db18+iZmar2hYVsBLEG
	e565Lj+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfVBK-00000005xyX-0Amu;
	Fri, 03 Jul 2026 04:07:14 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfVBI-00000005xxi-3RUj
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jul 2026 04:07:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0B050600C8;
	Fri,  3 Jul 2026 04:07:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4816F1F00A3A;
	Fri,  3 Jul 2026 04:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783051631;
	bh=5Qah2y0SaLCXR6gXurgUrTFa2uLuL2kbocBKf0t1JfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n0bPYIpjzdvKBwhg5G66h4Ux870rGhANqAOA/XqIESKk0Y0kO9yyWoZymA+aULZv2
	 wWd6WdIIOZlm2oZdL91wod4+VKf4QX/IP36r3d9h76VrDAmTuOCBIRcjCtpRDFdw4I
	 v6wVXaR46H3KqI7xzmGjnWpggmdMBCy+cNr9XNwmfacPjkUBo266DWKt3ea7D3VK97
	 tZ2jGUpZD3zZslTFA4xHXBBWs6rBXhuWfsHtIksaxmJgJdez879zRdvurz1dxryCJR
	 6v710lolvhf+CyNlMp7U2jlNPi3JxCh7J9rh85He2X9gIlYaRTSzunyqP+Nvc5iI2f
	 qQ2GMsA4n3Raw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	gregkh@linuxfoundation.org,
	skumar47@syr.edu,
	kumar.shivam43666@gmail.com,
	kbusch@kernel.org,
	dust.li@linux.alibaba.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philo Lu <lulie@linux.alibaba.com>
Subject: Re: [PATCH 5.10.y] nvmet-tcp: fix race between ICReq handling and queue teardown
Date: Fri,  3 Jul 2026 00:06:59 -0400
Message-ID: <stable-reply-nvmet-tcp-510y-20260702192533@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702123839.100640-1-lulie@linux.alibaba.com>
References: <20260702123839.100640-1-lulie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Thu, Jul 02, 2026 at 08:38:39PM +0800, Philo Lu wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
>
> commit 5293a8882c549fab4a878bc76b0b6c951f980a61 upstream.
>
> nvmet_tcp_handle_icreq() updates queue->state after sending an
> Initialization Connection Response (ICResp), but it does so without
> serializing against target-side queue teardown.

Queued up for 5.10.y, thanks!

-- 
Thanks,
Sasha


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1EFC28B30
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Mar 2025 20:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZhDazyaSk5DNxMJR8w0hWiH7v1lKciNp0z3ZUQcVWA8=; b=kBDs/rA7M5qg1404U89Cv7omiC
	bNioZUP7rcMVo24lB7m3uRtQGgN49XFX/SJwdwG6OP2+wR4HBQiigrJ06fxHrw0tAabcYJOUr/Mwa
	65cueu8T7Dg6olZDgbXJMIPZgejmJvm/AJdVUni7mNmiwGleQSBz2DJSU6PlNiKrtkvwxoYJGtX4y
	U4yOGU2Hlyjk5xO9oc216vnj8NKZAob3oaOBznJqUzOLRRPTzhCNXOgFIjjBJ8tDROZqRRVgHtrx5
	TZ3pLcfUwuuotEDuyoFwmtWuZW2kEtP8n0SKMmmIwQUJ7FqfiiaEH3Rni/owTbsMtgEYT9L9ylFSv
	XsM1jEXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvMHm-0000000D9If-3CMo;
	Thu, 20 Mar 2025 20:14:38 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvMHi-0000000D9IZ-1ElL
	for linux-nvme@lists.infradead.org;
	Thu, 20 Mar 2025 20:14:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CB19161141;
	Thu, 20 Mar 2025 20:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A80C4CEDD;
	Thu, 20 Mar 2025 20:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742501673;
	bh=DbhyLRw+ONnvGrwiPJJZfLcA19J+b0IMN0QAC/62tIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D6+PkvIjVvoooH/vlAp518qF7Xq0+AInbvKGnsnZG7haTNblNY61Enr9/lpVfmfSK
	 FDFHIoxA02ojU3f/bZdNnvB3zcEtq553WiOTj3aW8+u4ntXY5WbJbmmlupO/YzRyeB
	 dk7OnSCG26bhfSg1znBaUjfTkUMAOErl/HfYOuQBJOWtMBqXUNYb17sp9oyqBEp8Nw
	 Mih0XPG1texZBTe5KmHH3zl5AKuH8rThSAMZJkyb6a6SNeot91WNc8bodODPbEWAPI
	 jYEGTdPKw3YFGtCUH4vqB7FF7RMgAD/Lg263T0lfJVt5pQZ/n9zBzBdoHohknhr5xi
	 YnzP/76cB4QkQ==
Date: Thu, 20 Mar 2025 14:14:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: shao.mingyin@zte.com.cn
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	yang.tao172@zte.com.cn, yang.yang29@zte.com.cn, xu.xin16@zte.com.cn
Subject: Re: [PATCH v2] nvmet: replace max(a, min(b, c)) by clamp(val, lo, hi)
Message-ID: <Z9x3JsGAOIVKuHjD@kbusch-mbp.dhcp.thefacebook.com>
References: <20250320155300346qoM6J3iYhvw5QD7AfBiqo@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320155300346qoM6J3iYhvw5QD7AfBiqo@zte.com.cn>
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

On Thu, Mar 20, 2025 at 03:53:00PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Li Haoran <li.haoran7@zte.com.cn>
> 
> This patch replaces max(a, min(b, c)) by clamp(val, lo, hi) in the nvme
> driver. The clamp() macro explicitly expresses the intent of constraining
> a value within bounds, improving code readability.

Thanks, applied to nvme-6.15.


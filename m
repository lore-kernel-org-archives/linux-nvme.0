Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC12D3ABDC
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Nov 2024 18:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XKovk5n+lw1EjJJ9aZqtHAy2zHHXYa1QaZkQKgY7Nc8=; b=VGxoK4som3AVMEjdW5CVA1RNqp
	h3feB0gRg39fEMQmzSJIsS7AlNk1WqOnehVteTrr64r+YERLcCA08jGURQEH9QnsZQX67ctIqSVH2
	6kg3jKdO8btcplKXblDQKjm3yOq0FoP3jg/Gszd4BT0m5WjrzveKD2JEgbyiZ+5Sjg3NfW5zX4Qi8
	GwDfzcs+g2/ORgAYGStpJvknw/HPuBMTxAkqsbZ6qphX3PJ4k6tkuLtfUx7sMNKjJ4MMiupPcuKbh
	9sdBBtFNy82ZIIFYkWB8+OvCuOyA7H0izgSJWm2IGcseHaJzbQ/dePwRCW22ry08qlr9z28GknnW0
	NOJDn9mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tAYkq-00000000onp-2XUy;
	Mon, 11 Nov 2024 18:03:12 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tAYcC-00000000nMh-1ANo
	for linux-nvme@lists.infradead.org;
	Mon, 11 Nov 2024 17:54:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 18499A417CD;
	Mon, 11 Nov 2024 17:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B60C4CECF;
	Mon, 11 Nov 2024 17:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731347655;
	bh=XKovk5n+lw1EjJJ9aZqtHAy2zHHXYa1QaZkQKgY7Nc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AL1l0WQZ0RbhxQAH2edEigoDIORyZ5BKWGbJHDMQCp2ALoFO34uiYazemzerlZGbz
	 b0NhgXUXknVcqpEk1Hek/WoDXqSblY54yNsRILXFYQ5yN3MjLAQNQia0FqvsNzy0XU
	 oUTAw9caWuw6fl9KF1FCqHMfMbK3qtAceY8BM586Gl5RZoaKnuUa6QbwxDMdVk7Ds0
	 QPjx2S8lwkPF6JGhlu+WhZ2NSYvjqkkbNstBHzPeo9MU1XzWx3j/xEv2kPHbFFdElM
	 I6CZcyQFcVd+O423kuh5N8qgp47b/kvHx6+igqc20YHTT0vNMy5EConOCu7jFrLsa6
	 7X23reVc85S4w==
Date: Mon, 11 Nov 2024 10:54:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-nvme@lists.infradead.org, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] nvmet: fix the error of point math issue
Message-ID: <ZzJExEvGZAXZX-Nz@kbusch-mbp.dhcp.thefacebook.com>
References: <20241111104035.31770-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111104035.31770-1-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241111_095416_401043_0E01D49C 
X-CRM114-Status: UNSURE (   9.81  )
X-CRM114-Notice: Please train this message.
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

On Mon, Nov 11, 2024 at 06:40:35PM +0800, Guixin Liu wrote:
> Fix the wrong place of parenthesis of ctrl_eds and data point in
> nvmet_execute_pr_report(), switch to "void *" first and then do
> the addtion.

Thanks, I folded this inot the original commit.


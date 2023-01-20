Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB6E2C38142
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Jan 2023 02:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zgg2/psmSupNT9xu7u4rfQp0gUQ2xcStUZyUgcpJfkE=; b=SS1pt67duMafLZMmLJdRqeo5qJ
	dn+U1hH548HqyZnVXQnOF/2o/pTWnnkTfWDc1lD8VtRR3uQoIMD4gsrc+ZCdA2O4jLMQN9MKrlmYa
	+QEz6aQFFOwKyZb2oUdTMCg/Bx6Z1daWHt2WEClSgjrpDS1QU6BzUkd4e1wAfurGGpjF9W7HVJiGn
	m/lFIqh/HFORPwkFpdM2NOXz+2VDqxz6uT5BpM2grpDD+QDPfy+6Qi50Bbvgm5I5xbleLG4ZcvOCR
	ZJBQNGZh6Zjo5hPBjwVLqogZY5PFny2cppZ8cASTItQGLlPA/DKiVIeAEj5v/KSFLl+r6eC1Iodyo
	J5Sg9twg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIhGu-0085Oc-Sc; Fri, 20 Jan 2023 02:36:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIhGr-0085O1-Ie
	for linux-nvme@lists.infradead.org; Fri, 20 Jan 2023 02:36:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4899761DD8;
	Fri, 20 Jan 2023 02:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E08C433EF;
	Fri, 20 Jan 2023 02:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674182207;
	bh=dA6FudxFlGwYSuXbJExTlbBu/fZY9rOHhcSDGeijDy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tN9EIOnSr9ePay0/8PKo8IPU7y3U44tDh/zCVzqHoQzSOVbydIrSGHEBza/UtbJz6
	 6XBQ4b9yv+MXyJs3zJz/zWfioVXyLXQJ3NHD7/2D6W0+YnqHIlVj9fkkGk/SZRtfJG
	 6bsxlCEs6H6uAzXSRUhQWSJlp0GGcd365SNxZTudtGyEbCqpVSzeMigdLHgCvC8p61
	 G7DCX3tgqCe2lVV7q+ITIr4CtAruDPi9ZZcjadLNk3TYROsLU3s5mYWTQ7P2nTHSrp
	 UVdUKGeHRBfOnomPcWSkbSVDuGWWv8Hb+rIMSWkre6JsDh6B3BL+Zx5sySRVX4XjWu
	 6isUqISsIzAdw==
Date: Thu, 19 Jan 2023 18:36:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, borisp@nvidia.com
Subject: Re: [PATCH v9 02/25] net/ethtool: add new stringset
 ETH_SS_ULP_DDP_{CAPS,STATS}
Message-ID: <20230119183646.0c85ac52@kernel.org>
In-Reply-To: <20230117153535.1945554-3-aaptel@nvidia.com>
References: <20230117153535.1945554-1-aaptel@nvidia.com>
	<20230117153535.1945554-3-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230119_183649_702875_7C1FEA3D 
X-CRM114-Status: UNSURE (   7.52  )
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

On Tue, 17 Jan 2023 17:35:12 +0200 Aurelien Aptel wrote:
> +enum {
> +	ETH_ULP_DDP_RX_NVMEOTCP_SK_ADD,
> +	ETH_ULP_DDP_RX_NVMEOTCP_SK_ADD_FAIL,
> +	ETH_ULP_DDP_RX_NVMEOTCP_SK_DEL,
> +	ETH_ULP_DDP_RX_NVMEOTCP_DDP_SETUP,
> +	ETH_ULP_DDP_RX_NVMEOTCP_DDP_SETUP_FAIL,
> +	ETH_ULP_DDP_RX_NVMEOTCP_DDP_TEARDOWN,
> +	ETH_ULP_DDP_RX_NVMEOTCP_DROP,
> +	ETH_ULP_DDP_RX_NVMEOTCP_RESYNC,
> +	ETH_ULP_DDP_RX_NVMEOTCP_PACKETS,
> +	ETH_ULP_DDP_RX_NVMEOTCP_BYTES,
> +
> +	__ETH_ULP_DDP_STATS_CNT,
> +};

This should be in uAPI and used as attribute IDs.


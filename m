Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F74C54EBD
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Jan 2023 04:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QJPlszioXv00eG+iwXBZ5JS+POkko1FUzmIQXTVYVFU=; b=ybT1aB2BDkzOA40AcrGT4ZlQ+d
	LkPjKzxQjzBDavsGPOnK5BKhzKoBgXbtRgPq11PFy36l4nbIg3W8xmwM26K8pwCZ1k/bKEZkVijyp
	JHCBtYanWBkpMXJHLUukRkdP5z+eEGRE3ZYrgaPzx8/hP3mT/ANWqGpxt6mk+Q088aCii6h7+W0nX
	bvHRgieDiA003x/AfQ7KLAe5KtbKj/AZYwSMNt/QNS1ngaSjyLA57zNlzaNw+dOBL1azSyhqFApdQ
	+b80yXNa1MIfg30+khtU0gYJ4x6/A2AoOmdVSyab8Qxdx65++5Nh15qs7WpkvTtTx00G67DOTSR/k
	9/cPtpvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFpUp-00DkPX-Gj; Thu, 12 Jan 2023 04:47:23 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFpUm-00DkOh-IT
	for linux-nvme@lists.infradead.org; Thu, 12 Jan 2023 04:47:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2470261F5E;
	Thu, 12 Jan 2023 04:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA8B5C433EF;
	Thu, 12 Jan 2023 04:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1673498839;
	bh=F0ue6QAWpjFw9OXFioBV9KhNaVbsw9SxS6k4zIWaonA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L132JqSMK6Ii1nPoLp4mPUyjk9OjffQ8pISpO00dRCuQqdKWEL6tSxunfbMqxSk/H
	 tapmM/I/5y325jFw7r82cQs4XmiFrNzxvsfyHVMNt+IdY12h6ZTw2oY/idduchw5wd
	 W7fbembE87VmKW6skJohJLsINOM8X2jMnLgKTtlQy1nc1MEJ2AT47c864N7jj/g+oU
	 p3SCW9q5h/fmTtvfbNrGbSSgMcmx98tIGebPB+z2NmYTGgkvSo59JK1ZShyUn554gc
	 mQp/BYGXM1OvBeOiMcSQhH7RBR10eBi5zG/enWa0Z7iU5pO+JdplpL5RPWYduh5UNX
	 aaCeEGZzs19fQ==
Date: Wed, 11 Jan 2023 20:47:18 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, Boris Pismenny
 <borisp@nvidia.com>, aurelien.aptel@gmail.com, smalin@nvidia.com,
 malin1024@gmail.com, ogerlitz@nvidia.com, yorayz@nvidia.com
Subject: Re: [PATCH v8 01/25] net: Introduce direct data placement tcp
 offload
Message-ID: <20230111204718.215bc22c@kernel.org>
In-Reply-To: <20230109133116.20801-2-aaptel@nvidia.com>
References: <20230109133116.20801-1-aaptel@nvidia.com>
	<20230109133116.20801-2-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230111_204720_673292_6530A14B 
X-CRM114-Status: UNSURE (   7.57  )
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

On Mon,  9 Jan 2023 15:30:52 +0200 Aurelien Aptel wrote:
> +	int (*ulp_ddp_limits)(struct net_device *netdev,
> +			      struct ulp_ddp_limits *limits);
> +	int (*ulp_ddp_sk_add)(struct net_device *netdev,
> +			      struct sock *sk,
> +			      struct ulp_ddp_config *config);
> +	void (*ulp_ddp_sk_del)(struct net_device *netdev,
> +			       struct sock *sk);
> +	int (*ulp_ddp_setup)(struct net_device *netdev,
> +			     struct sock *sk,
> +			     struct ulp_ddp_io *io);
> +	void (*ulp_ddp_teardown)(struct net_device *netdev,
> +				 struct sock *sk,
> +				 struct ulp_ddp_io *io,
> +				 void *ddp_ctx);
> +	void (*ulp_ddp_resync)(struct net_device *netdev,
> +			       struct sock *sk, u32 seq);

no need to prefix all the members of this struct with ulp_ddp_


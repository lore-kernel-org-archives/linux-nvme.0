Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F65CAC5B0
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Oct 2025 07:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T/zsXUbbcUa4PwyLSyovyiX6sacdxlvJUnlo/kl3BAU=; b=VF8tyqffK9lNQtGUpeNP0oB7kX
	0PbaCVLqKv5mlCNo85rHfZvNtgm86or5jti8PYiU0Wyu9zLprGc0qBxoRBVGdKk140e1AfkxgiuCb
	boMsncS+62Ko6Nhg3Kh98VAxyFo9dof7tKgDo9Nfeq2fzRLlxAseNNxnI5fxuoJh5lTZmfWbTsnem
	sqgCUvdSyoUJtG+EYwzSzUGWrHgqGtc/vJ6MWygI0JA3VnqfE3VOtAMiGnUcGXSCJ1csS8mCMlDpO
	2lhNifbf6M8IOkX19cOQs0+ZF4BRanfCD/3bQtKxPWDUUJxEsrrUGHXsRjesWWdkZienHS4nNT6bD
	37Am1N5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4aAv-0000000BoG3-3Hbd;
	Fri, 03 Oct 2025 07:25:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v4aAs-0000000BoFd-1kKo
	for linux-nvme@lists.infradead.org;
	Fri, 03 Oct 2025 07:25:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3F2C8227AAC; Fri,  3 Oct 2025 09:25:43 +0200 (CEST)
Date: Fri, 3 Oct 2025 09:25:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, kbusch@kernel.org,
	sagi@grimberg.me, kch@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 1/1] nvmet: remove redundant subsysnqn field from ctrl
Message-ID: <20251003072542.GA12624@lst.de>
References: <20250924203402.10688-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924203402.10688-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251003_002554_605694_C9A5826C 
X-CRM114-Status: GOOD (  10.74  )
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

On Wed, Sep 24, 2025 at 11:34:02PM +0300, Max Gurtovoy wrote:
>  #ifdef CONFIG_NVME_TARGET_TCP_TLS
> -	tls_key = nvme_tls_psk_refresh(NULL, sq->ctrl->hostnqn, sq->ctrl->subsysnqn,
> +	tls_key = nvme_tls_psk_refresh(NULL, sq->ctrl->hostnqn, sq->ctrl->subsys->subsysnqn,

Please fix the overly long line here (and in the next line) while touching
this.



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28475E7C4F4
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Oct 2023 08:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GIjfbF2zm8GWu4cSSclJ4kl28vsjlcjtU6zjDi9a4Fo=; b=ygEga5urBCeqnjofW4SdFfC1BX
	VctA/N/RftUrfo30SbDa2LM3g9f6jhtBNKi3xVbn3doU1Dv/2e76opmHrqA7H1yZzvFQDiWrXTktf
	EwukpGPzXGcoIbC0RHNCk5Hazy/h+wH8qPRiRXxsqi4sekVZYhtABCaiHd6xUZlqXsclD26a05wj3
	f0e3i8wFUz0XLmu1/olJGzr6dz6mT+X0EQLGpoLapkfNG6OrSO71zzTIQRghOQRc0OJf51ffxHCSw
	c7by14yl+y9+4T/39en6pWqv6fCPRSJ06x3+NRMq1O64PbIu31qPkbHMSBEltfyUjX75uitpX9sUB
	2ANMEYzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qoJcr-001fYm-2m;
	Thu, 05 Oct 2023 08:22:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qoJco-001fXd-0c
	for linux-nvme@lists.infradead.org;
	Thu, 05 Oct 2023 08:22:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B1A3967373; Thu,  5 Oct 2023 10:22:17 +0200 (CEST)
Date: Thu, 5 Oct 2023 10:22:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kees Cook <keescook@chromium.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] nvmet-fc: Annotate struct nvmet_fc_tgt_queue with
 __counted_by
Message-ID: <20231005082217.GA12575@lst.de>
References: <20231003232511.work.459-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003232511.work.459-kees@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231005_012226_368131_1FB7408D 
X-CRM114-Status: GOOD (  12.01  )
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

On Tue, Oct 03, 2023 at 04:25:11PM -0700, Kees Cook wrote:
>  	struct workqueue_struct		*work_q;
>  	struct kref			ref;
>  	struct rcu_head			rcu;
> -	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
> +	struct nvmet_fc_fcp_iod		fod[] __counted_by(sqsize); /* array of fcp_iods */

Please move the comment up to not spill over the end of the line.

Otherwise this looks good.



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36414D1CA17
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Nov 2024 05:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ReISYVt9/bllMEfxUbI428Q1HCg0hjKWFxPMUNFtqNU=; b=ZTs0Q0A5Oi1cqV2RF4f+7OJ0Hs
	bHVhMzgYgG56sMDppR2yvlLeFh6cP4oVNfkHNQVFBoXzw+Jl8pQdNaxd7ntGM4LBilRyrnKfvxIGz
	gRFwTfRFKQmh19zvsPNw4VCNjZ2JlTGDgQIRwIa2/wU1E+pb0j6VDI60s7TgCtEv8P5k2f364qDyv
	NZE0ZIHphRcpFTYCF8dX7YoSg0hRcfPN8EzP+9/IXC54d7GG0S4ZBBIXo41q5F1rAexGV0kA9af9z
	2rxHgD69Zqm0RwyqKd7cBrrnFkYGgurt4cW9Dzre26EfiRjcnne0p6/tsihMr934WSaSQV1Ibm3/g
	2FXJF4SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YpI-00000001tN1-38Ea;
	Wed, 06 Nov 2024 05:43:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8YpF-00000001tMZ-2DqR
	for linux-nvme@lists.infradead.org;
	Wed, 06 Nov 2024 05:43:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 40AB368AFE; Wed,  6 Nov 2024 06:43:26 +0100 (CET)
Date: Wed, 6 Nov 2024 06:43:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, m@bjorling.me,
	matias.bjorling@wdc.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 04/11] nvmet: implement supported features log
Message-ID: <20241106054326.GD31330@lst.de>
References: <20241105174904.3612888-1-kbusch@meta.com> <20241105174904.3612888-5-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105174904.3612888-5-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_214329_749891_DBE05BE7 
X-CRM114-Status: GOOD (  19.06  )
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

On Tue, Nov 05, 2024 at 09:48:57AM -0800, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This log is required for nvme 2.1.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/target/admin-cmd.c | 25 +++++++++++++++++++++++++
>  include/linux/nvme.h            |  1 +
>  2 files changed, 26 insertions(+)
> 
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index b8229d6c9998d..c9b38d593fda5 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -344,6 +344,29 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
>  	nvmet_req_complete(req, status);
>  }
>  
> +static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
> +{
> +	__le32 *features;
> +	u16 status;
> +
> +	features = kzalloc(1024, GFP_KERNEL);

The magic number here is a bit weird.  Maybe add a

#define NVME_FEAT_MAX		256

and then make this ΝVME_FEAT_MAX * sizeof(*features)?

Same below.

> +	if (!features) {
> +		status = NVME_SC_INTERNAL;
> +		goto out;
> +	}
> +
> +	features[NVME_FEAT_NUM_QUEUES] = cpu_to_le32(1 << 21 | 1);
> +	features[NVME_FEAT_KATO] = cpu_to_le32(1 << 21 | 1);
> +	features[NVME_FEAT_ASYNC_EVENT] = cpu_to_le32(1 << 21 | 1);
> +	features[NVME_FEAT_HOST_ID] = cpu_to_le32(1 << 21 | 1);
> +	features[NVME_FEAT_WRITE_PROTECT] = cpu_to_le32(1 << 20 | 1);

And having names for the bits / scopes would be kinda nice as well.
(maybe same for the logs in the last patch)

Otherwise this looks good to me.



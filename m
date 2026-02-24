Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BC62F3C995
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 15:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cgnGFiD/I+yCbeeJPo36RUmPnF1upEYK2pESSckUICc=; b=fB8vbUCgXwC4cKdEgyJaKvG5JY
	A7qkt3Lm2970k5YrV3A7gT0I/EK0o61IKMHEcRf+mNmiBe4x3gBJIAlnZWs92JPZZwdSmQUOaoa1u
	kR+X16G3XvxzS72ihfGUmuCnufS1jqAouI1cccDxkZy3XLSYOTJ9NwBIRNhn39n5ajbkPj2pnikk4
	67J4PHYGe4aKUu+fnOEvQqxsZzqB5vi7CHpsopPgcYYmRDFgiFu1ddki5dqzVbp5Y+HiMoM7TzpAQ
	MzResf4Md3Ue1R7H7GqWiBiwabbfA2rEnuF8MGFGEUrV92tlNu0HcCB8Yyv1X8B/3zaCvL+L6Uqok
	W1TEFFnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuu8F-00000002INT-2pWP;
	Tue, 24 Feb 2026 15:15:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuu8D-00000002IN2-1DB7
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 15:15:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0F5F040763;
	Tue, 24 Feb 2026 15:15:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916D0C116D0;
	Tue, 24 Feb 2026 15:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771946123;
	bh=k3H/rEVnqAMIHs4Z1Gzb9bMIEAMLvti+HKdykL/Uktc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvVmugzbOfLJt+KIQCbC1slHVUUEo8DJQAdpw9r561nCKeC1cSvkokK/RwSgfxg5z
	 zN1/ue20RAzMHQXNx6uEJScdDQt/N7og91IH/kAAIEQfH8LuKH6vc1ouOhLwMHf7R1
	 dQPPB7FrCcPS/ujKoLBZLod4/Zh6x0oRT6LwkLvLjX/ydqpfMIGbdfxgZL3wbpNEX+
	 JE2h+vH039tBZSX9mcG113L35Y6kkLeXZLBbK7gKVSdeGetVJqtZIwyfD8CCliwXZK
	 jy5KFcYKgMWUngeKEc1+QY+gInagmEvlH9bmtgs2aBg3ci9WTT1ZUJhEtt4mlybQbR
	 6h1BV9pNKvykw==
Date: Tue, 24 Feb 2026 08:15:21 -0700
From: Keith Busch <kbusch@kernel.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] nvme: set discard_granularity from NPDG/NPDA
Message-ID: <aZ3Aib5gQlIiIaEp@kbusch-mbp>
References: <20260221033302.1451669-1-csander@purestorage.com>
 <20260221033302.1451669-6-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260221033302.1451669-6-csander@purestorage.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_071525_356672_C987BFF5 
X-CRM114-Status: GOOD (  11.35  )
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

On Fri, Feb 20, 2026 at 08:33:00PM -0700, Caleb Sander Mateos wrote:
> @@ -2113,11 +2114,27 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
>  	else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
>  		lim->max_hw_discard_sectors = UINT_MAX;
>  	else
>  		lim->max_hw_discard_sectors = 0;
>  
> -	lim->discard_granularity = lim->logical_block_size;
> +	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
> +		lim->max_hw_discard_sectors =
> +			nvme_lba_to_sect(ns->head, ctrl->dmrsl);
> +	else if (ctrl->oncs & NVME_CTRL_ONCS_DSM)
> +		lim->max_hw_discard_sectors = UINT_MAX;
> +	else
> +		lim->max_hw_discard_sectors = 0;

Something seems off about this patch: these last four new lines added
here are the same as the unmodified lines preceding it.


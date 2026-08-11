Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49201C5B56A
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2026 19:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ppaGrFDS/Cy0UamQGdFz0z/IJh45MV37F9M66+nhl3s=; b=wWlu88AUE8Fdd8ceY4Avhofs6/
	p29A8ZEhRo/7ubUda/V3dTDr4MqCVktNifZUxZ6gFCvBcpJqIv8nydb24JfGuGjBehc/2MfRSYHuT
	2V66mq2t2Cy2zNfmxCGnR/BkBsJqhgHtYcV3512lelILM0aXoOpNoxcpOPt+0+h/YOx39LD5ML6qm
	gU3g0vm4b+wjDtGhttqvOnht+aUqLIgUG6QV//vuYPpg1d4U8ntU4bCTnH+fboUHe6Wv5S1cV7zlj
	AvG24HqpcN6Fkflqcx8yCcfriBYzwuyZmgajEs6eD9hC7wvew2yJarpFEbGScis1UtcJfQgizT4FA
	cd19ndWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtsBf-0000000EqK2-3DbB;
	Tue, 11 Aug 2026 19:30:59 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtsBd-0000000EqJN-1LDj
	for linux-nvme@lists.infradead.org;
	Tue, 11 Aug 2026 19:30:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B5A734361A;
	Tue, 11 Aug 2026 19:30:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D6C1F000E9;
	Tue, 11 Aug 2026 19:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786476656;
	bh=ppaGrFDS/Cy0UamQGdFz0z/IJh45MV37F9M66+nhl3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YV6JG+WX3r/IjhJAang6vp6b7f1+8gIIErN6LoJsfQQmDITFRFUhPktYm/8yppPfr
	 hRsCLkUs+SPGEsE3GLRlV0pd7TQuNWhHjIxZrbD9Rb7Z/EpRLQFcTwyOnXmSQeTmQi
	 ClxEj8C9RjZShX4785kZvI5WncwV2bRvFKN3fdKIUWrQ1ARSbCzAd7bi3VHAlVZjNX
	 zWhJEW/FYCy1IWVrcQEjwktqyEYaPI2HEm6ZADH45VOn6WJprRv3D9ZUft+pJm1+gj
	 ni9vPtH8AH76Pjnt+m4VETXLAq7KcADzXsIZZwVN0k598zBEN7tWelJA9UpYpGsSOi
	 g39wcqnfU1xlw==
Date: Tue, 11 Aug 2026 13:30:54 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Weidong Zhu <weizhu@fiu.edu>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] nvme: refuse an unsolicited format change on a
 namespace that is in use
Message-ID: <ant4bioGLl4B35n_@kbusch-mbp>
References: <20260811192111.2058140-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811192111.2058140-1-coshi036@gmail.com>
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

On Tue, Aug 11, 2026 at 03:21:11PM -0400, Chao Shi wrote:
> @@ -2436,6 +2454,28 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>  		goto out;
>  	}
>  
> +	/*
> +	 * Changing the LBA format or the metadata size reinterprets everything
> +	 * the host has already cached, queued or handed to the integrity code
> +	 * for this namespace, and freezing the queue does not cover any of it:
> +	 * page cache contents, bios batched on a plug and the deferred
> +	 * integrity verify work all outlive the freeze.  If such a change
> +	 * arrives unsolicited while the namespace is in use, refuse it and let
> +	 * the caller take the namespace offline rather than adopt a geometry
> +	 * that describes something else than what the host is holding.
> +	 */
> +	if (nvme_ns_openers(ns) &&
> +	    !test_bit(NVME_CTRL_SELF_RESCAN, &ns->ctrl->flags) &&
> +	    (ns->head->lba_shift != id->lbaf[lbaf].ds ||
> +	     ns->head->ms != le16_to_cpu(id->lbaf[lbaf].ms))) {
> +		dev_err(ns->ctrl->device,
> +			"unsolicited format change on in-use nsid %u (lba_shift %u -> %u, ms %u -> %u)\n",
> +			info->nsid, ns->head->lba_shift, id->lbaf[lbaf].ds,
> +			ns->head->ms, le16_to_cpu(id->lbaf[lbaf].ms));
> +		ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
> +		goto out;
> +	}

Refusing to acknowledge the new format doesn't mean you get to continue
using the old format. You're going to corrupt memory and data this way.


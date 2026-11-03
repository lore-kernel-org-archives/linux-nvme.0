Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0CE606D80D
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ppDpGpcL;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YyeQpRpa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6qB0jQs8hu7FwycF9sp0s9p+YLOE2kIUGoFjmCaZyjQ=; b=ppDpGpcLAdzOAkkxTIVHwcv+qP
	kh3vjoIzA5Ulxn97Oo7DNFI+5KSMKNB3eCUUCAcShMRT11JK5Dvm+2DQ3dlFcOsnoYs+4fIfhPYjY
	jiga48s2FzjKd6ICmdxMk0RLhf8Sc58Q1/3Swm4lRfXEVzjAN+4/aetn1LouqOGg+J+ha7fT4yhAh
	g9Arc/21vNKTRd8BylC6rHnmLJNeF6qnXSo+khbittKQsTQ5uU0G9DfGP0LHGzxkeGGtiX/SX2op+
	u/tTdovKD/wFJW9x61+DoKlBp99M9mt2m7d7mWhi/esoLADWCH1RMF/BLRMGnF+mBv2wJJNNqPphq
	CqCIdb/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKQ3-00000003Y00-15i8;
	Tue, 03 Nov 2026 19:43:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOKQ1-00000003Xzt-3x2Y
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 19:43:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 050A76020A;
	Tue,  3 Nov 2026 19:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67AC81F0093A;
	Tue,  3 Nov 2026 19:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793735020;
	bh=6qB0jQs8hu7FwycF9sp0s9p+YLOE2kIUGoFjmCaZyjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YyeQpRpaaHn3W1/DDkmUxpk04c8+p0E1Iyq+zCLQb7693Es3WKnEDLrVH0Wcrtdr1
	 diC8Hq8x1nZ6dGbXh9gw2qJfsGWAPhhZZ3gzNa7zst4NcsY0Tfp2NyTYZ3Nl98vFck
	 LL/hP6XRPb91WI+ENAvDjUZcC0FPfrgxjf4jeXAddOWpKLayF9LOLba75MKdO+GwIm
	 KPRApz4Vdh1fOm3czxEsPv6MwTYYy9suFl9l500N/VKeO5MpOg1GpqTsJqfC8GgGBb
	 AlvENu4gKbz4nK+vNqmPcOWdOiZgRrmdCTDHQSWI+iXsJTLuq2WGpr0Oef3h4y+/gm
	 VUyy4jBoF7OKA==
Date: Tue, 3 Nov 2026 12:43:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Mauricio Faria de Oliveira <mfo@igalia.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Chao Shi <coshi036@gmail.com>,
	kernel-dev@igalia.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: reject completions for requests that are not in
 flight
Message-ID: <auo5a1kRTSWsAYtF@kbusch-mbp>
References: <20261103-nvme-double-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-nvme-double-cmpl-uaf-blk-mq-v1-1-b10fea474423@igalia.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 04:18:25PM -0300, Mauricio Faria de Oliveira wrote:
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 2d8f681079e85601a92624d196e77f1ba3ace34a..3ba0666da7be6a3de2e5f0fd50155af115b4e1f6 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -708,6 +708,11 @@ static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
>  			tag, genctr, nvme_genctr_mask(nvme_req(rq)->genctr));
>  		return NULL;
>  	}
> +	if (unlikely(blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT)) {
> +		dev_err(nvme_req(rq)->ctrl->device,
> +			"completion for request %#x not in flight\n", tag);
> +		return NULL;
> +	}
>  	return rq;
>  }

Is there something special about the NVMe protocol that makes this
problem unique to it? If not, why doesn't this check go into the generic
block layer instead?


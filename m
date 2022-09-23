Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D6CC6FA82
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 15:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eaKKTfbFo2P8xEZq4H2g2bWvvmV1VB14/0AR1qRGNAI=; b=cN4A2RpD0oK1ZpwcC+dj9jhpoH
	7rr7dh53UBcPRELGmFLy/U8gpB8fih83s7mN7hiFBnnoTD7mXVx1eODcLNbqjv54LnV+Q6LlfNMBi
	jtYESQ3bDf4uFiTH/jz7qdQYEq6RgCyUECmcpXEDkM+JZtqrQQjT+auA3prJzToDQUlnofMVmeh04
	RIo1/bHDtACTBsNBVapET+JmE8PMZD+TwB6fKvoRH2Y3CF68LdiOGaRf7swMyZKxHIx+GRTis/oxl
	3bu9f0Jbk9C8gmRNFkCnON0ihZcHBnVIHEUFoJjMn05L0QI43edhjclNaY7o1TwNKeklEeMfqA3E1
	/woDGH0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obkUR-004nBT-S0; Fri, 23 Sep 2022 15:21:19 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obkUR-004nB8-4H; Fri, 23 Sep 2022 15:21:19 +0000
Date: Fri, 23 Sep 2022 08:21:19 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org, Stefan Roesch <shr@fb.com>
Subject: Re: [PATCH 4/5] nvme: split out metadata vs non metadata end_io
 uring_cmd completions
Message-ID: <Yy3O7wH16t6AhC3j@infradead.org>
References: <20220922182805.96173-1-axboe@kernel.dk>
 <20220922182805.96173-5-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922182805.96173-5-axboe@kernel.dk>
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

> +	union {
> +		struct {
> +			void *meta; /* kernel-resident buffer */
> +			void __user *meta_buffer;
> +		};
> +		struct {
> +			u32 nvme_flags;
> +			u32 nvme_status;
> +			u64 result;
> +		};
> +	};

Without naming the arms of the union this is becoming a bit too much
of a mess..

> +static void nvme_uring_task_cb(struct io_uring_cmd *ioucmd)
> +{
> +	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
> +	int status;
> +
> +	if (pdu->nvme_flags & NVME_REQ_CANCELLED)
> +		status = -EINTR;
> +	else
> +		status = pdu->nvme_status;

If you add a signed int field you only need one field instead of
two in the pdu for this (the nvme status is only 15 bits anyway).


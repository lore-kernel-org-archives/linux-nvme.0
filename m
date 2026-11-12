Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE1B606A321
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Nov 2026 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=TxTdhoyk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BBTphs/cyovtrCBAnbIOqmAE4r10Zj0YR0LW0CiCMwU=; b=TxTdhoykng7br/LJRsZUQJmHVZ
	stKe+7txchQojMJggKY4wLAUzOhTsKcK6acHMJz5nbjryvFiFP6otl41VCpOxIXvWfrsGAoPnFahH
	Olpz2PWusyLXKcDovMVV1qJWSbe5oFuFQyzscBoDv9YWt+xpJy6c5v2/W4OEzVCC3zae6DAIwq772
	/UyhLe5rlBUDoOyc8pirimnPYDtdnf+EDlaJ1ReqXn2QN/HQ9P7KZZTVpO362OtU7nlSvgAWwlgQG
	lrWwyE/AbCJ9AMVkEZBc7MgEwJKDN1uhVwJl8/v6yzsKPNxDTI+nLJeVlfLmgJbaWWaOvZQPtrAyx
	zAgme9+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRc6H-0000000B3v9-38j1;
	Thu, 12 Nov 2026 21:12:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRc6F-0000000B3uZ-1Glr
	for linux-nvme@lists.infradead.org;
	Thu, 12 Nov 2026 21:12:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 67B7A68BFE; Thu, 12 Nov 2026 22:12:46 +0100 (CET)
Date: Thu, 12 Nov 2026 22:12:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: shao.mingyin@zte.com.cn
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, justin.tee@broadcom.com,
	nareshgottumukkala83@gmail.com, paul.ely@broadcom.com,
	kch@nvidia.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/6] nvmet-tcp: only wait for in-capsule data for
 inline SGLs
Message-ID: <20261112211246.GB11126@lst.de>
References: <20261110230304050fijuDcYKyYPS3lffioSeA@zte.com.cn> <20261110230310932grXKWow1mHtiisyby_D4-@zte.com.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261110230310932grXKWow1mHtiisyby_D4-@zte.com.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261112_131251_492726_BE8B04A9 
X-CRM114-Status: GOOD (  14.29  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 10, 2026 at 11:03:10PM +0800, shao.mingyin@zte.com.cn wrote:
> +/*
> + * Check whether the SGL of @cmd carries in-capsule data that the host
> + * will send right after the command PDU.  Only the offset form of the
> + * data block descriptor is in-capsule; a regular transport SGL is
> + * fetched through an R2T instead.
> + */
> +static inline bool nvmet_tcp_sgl_is_inline(struct nvmet_tcp_cmd *cmd)
> +{
> +	struct nvme_sgl_desc *sgl = &cmd->req.cmd->common.dptr.sgl;
> +	u32 len = le32_to_cpu(sgl->length);
> +
> +	return sgl->type == ((NVME_SGL_FMT_DATA_DESC << 4) |
> +			     NVME_SGL_FMT_OFFSET) &&
> +		nvme_is_write(cmd->req.cmd) && len &&
> +		len <= cmd->req.port->inline_data_size;

Nit: this would become much more readable if split into multiple
conditions instead of this giant compound expression.

Otherwise looks good.



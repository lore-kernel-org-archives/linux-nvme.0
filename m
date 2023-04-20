Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811D5C77B72
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Apr 2023 04:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rDMLBUCtyPG8PVh78F4dhl5RPOXrDhzH/tEUEyC0Qd8=; b=Dwhzk6zE3G15YYwu8EejCmFAWA
	46eYRr77nq9CDEFMoN/FtINauB/aaCsL8TK+DOIDbMmleZLJkSy+Db/ZiXOu4Q/0CzQYIKVHd7IIb
	dEksukXqXOGuIt00wJ9PO5x++Ku0aHL3D+SesRpMN9XT/skvO8HSVxvpieBuWk5TrXv8kddB2H7cw
	wyHq2FM+bmiIcEFq96vU/Hw2sEJ4U8g0DdRM8vS05fxLgx0vnaFHXUFfGTcezAgPki5iXNDT2xsF3
	JrDsStThPIv6xihiW5v/H5YpDsIspgfvz2hrAK3EYAH0DvoX+p6MDq/XF9n+ZS8Tq39IFq/IdeXgr
	SKCwOn4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppMMK-0073WT-24;
	Thu, 20 Apr 2023 04:57:28 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppMMH-0073VJ-0V
	for linux-nvme@lists.infradead.org;
	Thu, 20 Apr 2023 04:57:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 85E8E68AFE; Thu, 20 Apr 2023 06:57:12 +0200 (CEST)
Date: Thu, 20 Apr 2023 06:57:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Breno Leitao <leitao@debian.org>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	asml.silence@gmail.com, axboe@kernel.dk, leit@fb.com,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
	ming.lei@redhat.com
Subject: Re: [PATCH 1/2] io_uring: Pass whole sqe to commands
Message-ID: <20230420045712.GA4239@lst.de>
References: <20230419102930.2979231-1-leitao@debian.org> <20230419102930.2979231-2-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230419102930.2979231-2-leitao@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_215725_362667_2AF1D1CC 
X-CRM114-Status: GOOD (  12.18  )
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

On Wed, Apr 19, 2023 at 03:29:29AM -0700, Breno Leitao wrote:
>  	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
> -	const struct nvme_uring_cmd *cmd = ioucmd->cmd;
> +	const struct nvme_uring_cmd *cmd = (struct nvme_uring_cmd *)ioucmd->sqe->cmd;

Please don't add the pointless cast.  And in general avoid the overly
long lines.

I suspect most other users should just also defined their structures
const instead of adding all theses casts thare are a sign of problems,
but that's a pre-existing issue.
>  	struct io_uring_cmd *ioucmd = io_kiocb_to_cmd(req, struct io_uring_cmd);
> -	size_t cmd_size;
> +	size_t size = sizeof(struct io_uring_sqe);
>  
>  	BUILD_BUG_ON(uring_cmd_pdu_size(0) != 16);
>  	BUILD_BUG_ON(uring_cmd_pdu_size(1) != 80);
>  
> -	cmd_size = uring_cmd_pdu_size(req->ctx->flags & IORING_SETUP_SQE128);
> +	if (req->ctx->flags & IORING_SETUP_SQE128)
> +		size <<= 1;


Why does this stop using uring_cmd_pdu_size()?


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E10C77B73
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 04:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VGnb4Q8gU/G/Bn4P2Q0Sooz9dSEKd5CkNuXocfOgfXw=; b=Kg/vba0vLZ/OGEuz1BHQq8458q
	65vYIXS3hEwSDKdZvzgeUPODIcIvoBeEekebCdnKS6k8syu9iizFSS5HqZQiyqH3gu9eJAla+zIjr
	E4jbcp7k+Ph9+Nb+UiFrCikuVshzhER5CWxbDaoXaP5rkd4tFMt0gMXLEl0RiXk3DgRyK0CPTlkWJ
	LVetZZ42w3HXc3sPOdxrwTKy56mQNpyE6HGpKDj/Qv5LJtE1uXqz51NSzzhfXUm+2bAs8f9Lr4nkp
	aWSQY9udu8FvPjACYP1KgKA1RpIktQ6HLurHz9OYP+NxfBNTZhGR20+1+IblmGhJTtYs1qQbi5Sif
	w8SUraQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptLAy-00FEWf-1h;
	Mon, 01 May 2023 04:30:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptLAw-00FEVo-0U
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 04:30:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6A69268B05; Mon,  1 May 2023 06:30:07 +0200 (CEST)
Date: Mon, 1 May 2023 06:30:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Breno Leitao <leitao@debian.org>
Cc: io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	asml.silence@gmail.com, axboe@kernel.dk, ming.lei@redhat.com,
	leit@fb.com, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, sagi@grimberg.me, joshi.k@samsung.com,
	hch@lst.de, kbusch@kernel.org
Subject: Re: [PATCH v3 2/4] io_uring: Pass whole sqe to commands
Message-ID: <20230501043007.GB19673@lst.de>
References: <20230430143532.605367-1-leitao@debian.org> <20230430143532.605367-3-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230430143532.605367-3-leitao@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230430_213010_335658_C7BA4DAF 
X-CRM114-Status: GOOD (  10.16  )
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

>  static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>  {
> -	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->cmd;
> +	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->sqe->cmd;

This still adds all the crazy casting!!

As I already explained two times, last time including actual working
code, please add a helper that takes a io_uring_cmd * argument, and
returns cmd->sqe->cmd with a void * type.  With that all the casting
can be removed.


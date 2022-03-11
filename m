Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B484C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 01:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z4x2hBPkj+jEGWmrRVyRt/pxXSV3iAHniQAONJ1aiFU=; b=nkmXpMvQD3PAaBQLJ9yhGoU8wf
	UUYeUX3UH3UOxsqw9nsNUl774MtIAPrFNWLNgl5zlErZpy1JS7IEDMl9II3DEJwvl62tkD3gb4KFr
	jlX4YhK/6cWus8z5VvxQLaJ+y+3nMU6rMtsDBY2LKQ0/a+oB04Fqh7Ko2JnUGfPubZdlcbDvH+SYq
	bgFV77PKLvqoxRv2dP3RoMIXzcW3iUOXdnBgOlG4cgPmh4+gjvpajtjWU+ec7s9s2bWZ5wqz91M1d
	Cx5zr/AjwUdQebryYYWRQ3onOEXEsiCiSlv0e7kjtHg8HOgPFA0XrGjyE8AHTSK3XWNbnFcmoZDkI
	zYj303EA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSUR5-00EX94-Re; Fri, 11 Mar 2022 01:51:19 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nSUR1-00EX8e-P7; Fri, 11 Mar 2022 01:51:15 +0000
Date: Thu, 10 Mar 2022 17:51:15 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>, jmorris@namei.org,
 serge@hallyn.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
 john.fastabend@gmail.com, kpsingh@kernel.org,
 linux-security-module@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com,
 logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
 a.manzanares@samsung.com, joshiiitr@gmail.com, anuj20.g@samsung.com
Subject: Re: [PATCH 03/17] io_uring: add infra and support for
 IORING_OP_URING_CMD
Message-ID: <YiqrE4K5TWeB7aLd@bombadil.infradead.org>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152658epcas5p3929bd1fcf75edc505fec71901158d1b5@epcas5p3.samsung.com>
 <20220308152105.309618-4-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308152105.309618-4-joshi.k@samsung.com>
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

On Tue, Mar 08, 2022 at 08:50:51PM +0530, Kanchan Joshi wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> This is a file private kind of request. io_uring doesn't know what's
> in this command type, it's for the file_operations->async_cmd()
> handler to deal with.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---

<-- snip -->

> +static int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
> +{
> +	struct file *file = req->file;
> +	int ret;
> +	struct io_uring_cmd *ioucmd = &req->uring_cmd;
> +
> +	ioucmd->flags |= issue_flags;
> +	ret = file->f_op->async_cmd(ioucmd);

I think we're going to have to add a security_file_async_cmd() check
before this call here. Because otherwise we're enabling to, for
example, bypass security_file_ioctl() for example using the new
iouring-cmd interface.

Or is this already thought out with the existing security_uring_*() stuff?

  Luis


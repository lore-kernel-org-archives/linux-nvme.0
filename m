Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D552BC07E9D
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 07:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OkGBWrj5HenBmSvRCP/bJLKiC4zjezLIYcDiv0zN+2g=; b=jzD/fJbYk9XcwXUYotRx5dFzUm
	KLiJgaxZr10K6n8ei5Kls5FPpogDOSny6jtb827F7hLmbArKnwPhGrYOm49QtqKtMkZ0+wRn00Suw
	yGuKnJsvlh51LHboRGE9icNiDgToKb3NUdMoDkA8JhqnxpHGvXXZBD65sPaGJqXedWxKvbWy8/ffm
	7CX2JNpXkq2xUvGZDSVxwjy2g8IsD0+E2XY5KkfoG28a5Y2f6gtvp/P0njTfrA1WkLTBSeUXnXrHv
	DebZMm3oxK+LNiGFwMaUFnU1b0evRD02DIpyB8blaIWFBONMFI/NSCfzhKkobaJe6/ipmswjWMxAy
	2ZnMV86Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od55L-008nzB-Ri; Tue, 27 Sep 2022 07:32:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od55J-008ny4-C3
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 07:32:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 773A868AA6; Tue, 27 Sep 2022 09:32:50 +0200 (CEST)
Date: Tue, 27 Sep 2022 09:32:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
	linux-nvme@lists.infradead.org, gost.dev@samsung.com
Subject: Re: [PATCH for-next 2/2] nvme: Make CAP_SYS_ADMIN fine-granular
Message-ID: <20220927073250.GB16831@lst.de>
References: <20220926145430.81658-1-joshi.k@samsung.com> <CGME20220926150442epcas5p2d2258d9799e47a49523d36b1a852dc9c@epcas5p2.samsung.com> <20220926145430.81658-3-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926145430.81658-3-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_003253_573256_203EB4C9 
X-CRM114-Status: GOOD (  18.44  )
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

On Mon, Sep 26, 2022 at 08:24:30PM +0530, Kanchan Joshi wrote:
> Change all the callers of CAP_SYS_ADMIN to go through nvme_cmd_allowed
> for any decision making.
> Since file open mode is taken into consideration for any
> approval/denial, change at various places to keep file-mode information
> handy.
> 
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  drivers/nvme/host/ioctl.c | 70 +++++++++++++++++++++------------------
>  1 file changed, 38 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 6ca6477dd899..4e53a01e702d 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -259,7 +259,7 @@ static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
>  }
>  
>  static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> -			struct nvme_passthru_cmd __user *ucmd)
> +			struct nvme_passthru_cmd __user *ucmd, fmode_t mode)
>  {
>  	struct nvme_passthru_cmd cmd;
>  	struct nvme_command c;
> @@ -267,10 +267,10 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
>  	u64 result;
>  	int status;
>  
> -	if (!capable(CAP_SYS_ADMIN))
> -		return -EACCES;
>  	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
>  		return -EFAULT;
> +	if (!nvme_cmd_allowed(ns, cmd.opcode, mode))
> +		return -EACCES;

Btw, what speaks against moving this check a little bit later,
so that we can pass the nvme_command to nvme_cmd_allowed, and thus
can simply use nvme_is_write?



Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D44C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Nov 2022 06:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L/kW3hW/JLJ5rYFCmkNDoXuNuqGLUECbxUXaHiQwyJU=; b=XeGvMrKKpyQU0cZgpFdG9TXfyO
	gx2b5LixuQpbqbLfcmeDYgbKVF4u2KfyjTeZQ4HyxsHlep3inUCxT6QFY/jLrrP2Z7/rSE2AK7UFy
	63YDVpmkbBAvVa2r1aSqcjpYouVogttvyWDijy5kjIzLlvWoS87ETj+BXHgBfxAOPIBac8XuBD+W7
	PbbWno8pfSLgIwA2R5bmZdeSJcPuIJXb7IEVI6r0drNwo7CdQYeb8oCfDrCQ+HqkO/pREB+5qvT+Q
	mPsYYB71KgbqUQS1tef0NOx3+KjETLV3KCcKHOIeCP2uXbJf4erzYLQepimHG4lLCmjg1Xnfa8o+U
	XUaGjNYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osewp-00BO7C-S2; Wed, 09 Nov 2022 06:52:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1osewi-00BO5m-7V
	for linux-nvme@lists.infradead.org; Wed, 09 Nov 2022 06:52:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6CDED68D05; Wed,  9 Nov 2022 07:52:17 +0100 (CET)
Date: Wed, 9 Nov 2022 07:52:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/3] block: Add error codes for common PR failures
Message-ID: <20221109065216.GA11097@lst.de>
References: <20221109031106.201324-1-michael.christie@oracle.com> <20221109031106.201324-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221109031106.201324-2-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221108_225224_439071_31474070 
X-CRM114-Status: GOOD (  26.53  )
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

On Tue, Nov 08, 2022 at 09:11:04PM -0600, Mike Christie wrote:
> If a PR operation fails we can return a device specific error which is
> impossible to handle in some cases because we could have a mix of devices
> when DM is used, or future users like lio only know it's interacting with
> a block device so it doesn't know the type.
> 
> This patch adds a new pr_status enum so drivers can convert errors to a
> common type which can be handled by the caller.
> 
> Signed-off-by: Mike Christie <michael.christie@oracle.com>
> ---
>  include/uapi/linux/pr.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/include/uapi/linux/pr.h b/include/uapi/linux/pr.h
> index ccc78cbf1221..16b856fb8053 100644
> --- a/include/uapi/linux/pr.h
> +++ b/include/uapi/linux/pr.h
> @@ -4,6 +4,30 @@
>  
>  #include <linux/types.h>
>  
> +enum pr_status {
> +	PR_STS_SUCCESS			= 0x0,
> +	/*
> +	 * These error codes have no mappings to existing SCSI errors.
> +	 */
> +	/* The request is not supported. */
> +	PR_STS_OP_NOT_SUPP		= 0x7fffffff,
> +	/* The request is invalid/illegal. */
> +	PR_STS_OP_INVALID		= 0x7ffffffe,
> +	/*
> +	 * The following error codes are based on SCSI, because the interface
> +	 * was originally created for it and has existing users.
> +	 */
> +	/* Generic device failure. */
> +	PR_STS_IOERR			= 0x2,
> +	PR_STS_RESERVATION_CONFLICT	= 0x18,
> +	/* Temporary path failure that can be retried. */
> +	PR_STS_RETRY_PATH_FAILURE	= 0xe0000,
> +	/* The request was failed due to a fast failure timer. */
> +	PR_STS_PATH_FAST_FAILED		= 0xf0000,
> +	/* The path cannot be reached and has been marked as failed. */
> +	PR_STS_PATH_FAILED		= 0x10000,

Nit: I'd movee the NOT_SUPP/INVALID to the end to follow the numerical
order.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


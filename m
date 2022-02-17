Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E5FC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Feb 2022 01:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SEDdEOUoigqujxshhHn2OnVIwq0lCTrQKSE9KoWDQP8=; b=FABviPUmeBfnvI40Mj3p0aD00l
	D/cPLPrGKUOzkRFBuDbflIV0CTq2Slsq19QIElLSuAe2ecNPPqMEjOL6+Q2j1nAWyIoRKmUyofvec
	3HF9l/hWyS35KEnVRmgMPkPGC1W6W/GMYyC63y6c9Vf6xrJe7gGd2LUKdF7WEVz5tscEHvhiz9A9L
	XIGASmW9WFhwP2Z6DO6Ym4xn08nhQN06TGwmquPlqqZANbwUW3SXVaNS6JsUgr7/bmBMKKBU85SuZ
	N5AbLUUtWnwH6VN7IZd/GxS3vAP6YVuOlwBGJkl8Cu68+3gDKmlebLfQXiyIDAfyef3hC/Coxrvn7
	//3SN8Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nKVXt-008fF5-W5; Thu, 17 Feb 2022 01:25:22 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1nKVXs-008fEv-2Y; Thu, 17 Feb 2022 01:25:20 +0000
Date: Wed, 16 Feb 2022 17:25:20 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, joshi.k@samsung.com, hch@lst.de,
 kbusch@kernel.org, linux-nvme@lists.infradead.org, metze@samba.org
Subject: Re: [PATCH 3/8] fs: add file_operations->uring_cmd()
Message-ID: <Yg2kAP4Zj2+YCNwA@bombadil.infradead.org>
References: <20210317221027.366780-1-axboe@kernel.dk>
 <20210317221027.366780-4-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317221027.366780-4-axboe@kernel.dk>
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

On Wed, Mar 17, 2021 at 04:10:22PM -0600, Jens Axboe wrote:
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index ec8f3ddf4a6a..009abc668987 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1884,6 +1884,15 @@ struct dir_context {
>  #define REMAP_FILE_ADVISORY		(REMAP_FILE_CAN_SHORTEN)
>  
>  struct iov_iter;
> +struct io_uring_cmd;
> +
> +/*
> + * f_op->uring_cmd() issue flags
> + */

Adding kdoc style comments would be nice.

  Luis


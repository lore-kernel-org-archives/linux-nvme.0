Return-Path: <SRS0=WsD/=62=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740E9CA90AF
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2020 16:06:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 482BA20722
	for <linux-nvme@archiver.kernel.org>; Tue, 12 May 2020 16:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fqoo4Jxq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 482BA20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aXnWxbEsQBRTjgP6oPCG1naK7ojt39ZMi3FuUILae58=; b=fqoo4JxqBusFP7
	/0CZ+4/F3kenf/QZ3dENx00k4XVH56Dwzj1XwtJDaWZoOm6tPFLvEx/S+PIrYsOVGhWYAJgM1ZoOO
	eWnD03JaJ7TIiITYeOIXnlg4cAlYApoFYH+TQs0W7PWPpY0iB1wjKlmbi3YouDAD+A73PCxxKR3iN
	cRH2ka1B65tWNuNE3BSf3U1zVTxydgWX249/KMeaRyqG+OlKghE0RrVvkty3MZW3QKsU4Ls1llh8P
	mEW1VeqSzkifq7JavyCXTAhHCLnm/TsmbGGmqoi27WxRnHucVmSnRmNeATpdLK1Vkj8rdgxKGfHMd
	tkvakyJIOiZfl5eO0T6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jYXQI-0000Gw-Cp; Tue, 12 May 2020 16:06:26 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jYXQD-0000GP-J5
 for linux-nvme@lists.infradead.org; Tue, 12 May 2020 16:06:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id ACFB468BEB; Tue, 12 May 2020 18:06:18 +0200 (CEST)
Date: Tue, 12 May 2020 18:06:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Wu Bo <wubo40@huawei.com>
Subject: Re: [PATCH] nvme/core:disable streams when get stream params failed
Message-ID: <20200512160618.GA5403@lst.de>
References: <1588754221-661597-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1588754221-661597-1-git-send-email-wubo40@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200512_090621_777885_B936568A 
X-CRM114-Status: GOOD (  14.60  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linfeilong@huawei.com, sagi@grimberg.me, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, liuzhiqiang26@huawei.com, axboe@fb.com,
 kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, May 06, 2020 at 04:37:01PM +0800, Wu Bo wrote:
> After enable nvme streams, then if get stream params failed, 
> We should disable streams before return error in 
> nvme_configure_directives() function.
> 
> Signed-off-by: Wu Bo <wubo40@huawei.com>
> ---
>  drivers/nvme/host/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f2adea9..afe1f5a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -552,8 +552,10 @@ static int nvme_configure_directives(struct nvme_ctrl *ctrl)
>  		return ret;
>  
>  	ret = nvme_get_stream_params(ctrl, &s, NVME_NSID_ALL);
> -	if (ret)
> +	if (ret) {
> +		nvme_disable_streams(ctrl);
>  		return ret;
> +	}

Please use a out_disable goto label to not duplicate the error
handling with the other case that needs it.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

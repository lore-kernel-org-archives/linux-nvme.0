Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F18AC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jan 2022 16:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6BQBY7FFbnUc4BSX8Zpr9GNvti5n9lLq3HJynUpSpgs=; b=FlBG/27W4Hj7cpCn7J4lwrpfzG
	RD+1hnhiKspdcgvIErufYj2zXHG+Wa+vOfi+NgjeAXeagJw48Kfjdkf4d0ZrIpGWU/QbL9ya0i30w
	NiWkLxzH/KISzKJlJqw9PG15jEP3ZgMbNcJF9552cBsuPVAo/2I6ZHS7VLpYLxTfvXPVA3ekLkZ5c
	2iAMt/3IDkhT0SyAMyQB0Z/jEWaAHT6hOfIBt7Ychv2TdtXjNAjD3U1gO8UtfeFiH1ibQq5vPkwJQ
	4NcgRyrQEz9wcUAYK2BmDY0sIInePL+RGh5s/ptkaGEEfb+OawFSVF3tPxWDop3xDS2qGyBae+2S2
	1you4xrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n82y0-006aV4-SY; Thu, 13 Jan 2022 16:28:48 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n82xy-006aUC-0C
 for linux-nvme@lists.infradead.org; Thu, 13 Jan 2022 16:28:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 234CDB82306;
 Thu, 13 Jan 2022 16:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A78C36AE9;
 Thu, 13 Jan 2022 16:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642091323;
 bh=8JCpsv9Nwf8KnW3fDXishHITmYDE00XrRA9tubLxL8I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=g6Z7HTfHKgtBW5aBIybRnl6eEO55OOayRfb+D1mRFT6csbyoTaXsQoIwL2EGKgfAs
 8MQa1WAERvdEHwdju2DYQlzLmtoHXBpKCKsGBtAG9DesSxNqQDC9Qgi1zSuh7T/GmC
 n7otUUv0ULOZB1HUb2c5kuVg7EUGTeEyLkBThT73aHo7fwtEfdXQQHFPIHP8t9FIYs
 PGS7Vezimh88cU+HwOFB9MdZo11apympxh2yz86+nQs15G7a+kOe8n4FKskeH7FEsG
 GMtvlYq23Lmg4LjuqvaqpkWdxjlKqtuWgKerKpbYoFvy+uWsSivRmPFKPOC5WwHTTw
 IWDzDQnce4q4g==
Date: Thu, 13 Jan 2022 08:28:40 -0800
From: Keith Busch <kbusch@kernel.org>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH 5/5] nvme-fabrics: set ret to -ENODEV for error case
Message-ID: <20220113162840.GE3230285@dhcp-10-100-145-180.wdc.com>
References: <20220112062101.90102-1-chaitanyak@nvidia.com>
 <20220112062101.90102-6-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112062101.90102-6-chaitanyak@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220113_082846_213280_233FAFAD 
X-CRM114-Status: GOOD (  16.47  )
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

On Tue, Jan 11, 2022 at 10:21:01PM -0800, Chaitanya Kulkarni wrote:
> From: Chaitanya Kulkarni <kch@nvidia.com>
> 
> In function nvmf_dev_show() if we don't find the controller set the
> ret variable to -ENODEV.
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> Suggested-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>  drivers/nvme/host/fabrics.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index df0326db306f..ca23ac926710 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -1097,6 +1097,7 @@ static int nvmf_dev_show(struct seq_file *seq_file, void *private)
>  	ctrl = seq_file->private;
>  	if (!ctrl) {
>  		__nvmf_concat_opt_tokens(seq_file);
> +		ret = -ENODEV;
>  		goto out_unlock;
>  	}

I missed the discussion on this. Doesn't the __nvmf_concat_opt_tokens()
already return parameters that indicate to the caller that no controller
was found?


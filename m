Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2BCC8303D
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 02:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2VtNkwFGaLSSxGJPE3ESQhlnmkYAlveqiXkqT7LkiQ4=; b=fxwteLRW/7973z7AYQpziwCWw4
	VfwFqdX9oLrYS+gqup5594XoYoBGjFruUlQQG2ocpOR2j/ljis79MPt6sE1PLiXzxkexwoPEQSKUF
	mc/lDPu5eJVtBQ1hvnudiYtnKsLwNCq2xn01JUbteYZwTsNXikTCFCLdK/r4Pe5TDJ5PjOHtSSwKi
	TJP0deovEWvniThP3ZyysrAA6sEAG2Xr7FgbtQkeBFoyjibYMSZbEia92eQTfeP6rALB7P5wlQplo
	9nsSHkBTiEJ3OffsNYJP9zLEWSnpF+Lx+LaO7+xc+rWgGWAgISk6E9mvZ0zciUoOq53XvPpAFJjJr
	Asai1QTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWmyx-000000072ML-3Spz;
	Wed, 02 Jul 2025 02:13:55 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWmyv-000000072Ly-1x7W
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 02:13:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 84FFAA534FE;
	Wed,  2 Jul 2025 02:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2550AC4CEEB;
	Wed,  2 Jul 2025 02:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751422432;
	bh=rqDOKEqDtU4wDif/XftU7uJJKvo8fG5j53uQf5R1kHA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZXtjtqAe3PGWiGweYVTnUrfSvcEurYq8KKFdpjR8uJGJmaul4cRJPmL770ouAytJE
	 BEnWSg/2xFDJc3rvVfcQg9DuI9qWDloVPZx7fzUC2APkz6/kr3gPWT73O0YrUxu8MX
	 HER4JvjnMtfawHYtk8VxbPwWy9CP+5phHhowNI8auabBs68usJ5RrZ3eU1R1bcK9lO
	 MwUR1N1yJ2yPUxGP/NpXiz2DwqvF4Ua0wG4eLHdM1bjSA1x3ZOgHj2I2SqfA1+/n6l
	 yCzaYry5ebIRbnWR8SjNsYx/tOwLs+DCFZM0xSdq3LJjQfv+0Hmvmd528ras8JGjOG
	 kSO8/Gbk+WFJA==
Message-ID: <36499d5b-4203-432a-a822-95b6d20d458f@kernel.org>
Date: Wed, 2 Jul 2025 11:13:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nvme: prevent admin controller from smart log
 fetch (LID 2)
To: Kamaljit Singh <kamaljit.singh1@wdc.com>, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cassel@kernel.org
References: <20250702005830.889217-1-kamaljit.singh1@wdc.com>
 <20250702005830.889217-3-kamaljit.singh1@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20250702005830.889217-3-kamaljit.singh1@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_191353_572549_4A6F2CAC 
X-CRM114-Status: GOOD (  18.58  )
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

On 7/2/25 09:58, Kamaljit Singh wrote:
> Similar to a discovery ctrl, prevent an admin-ctrl from getting a smart
> log. LID 2 is optional for admin controllers to support.

If it is optional, when the admin controller support it, why prevent it ?
This is what your code does... Or is it that at this stage of the
initialization, you do not know yet if the admin controller supports LTD 2 ?

> 
> In the future when support for the newly added LID=0 (supported log
> pages) is added, GLP accesses can be made smarter by basing such calls
> on response from LID=0 reads.
> 
> Reference: NVMe Base rev 2.2, sec 3.1.3.5, fig 31.
> 
> Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
> ---
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a1155fb8d5be..c310634e75f3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3705,7 +3705,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
>  
>  	nvme_configure_opal(ctrl, was_suspended);
>  
> -	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
> +	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl) && !nvme_admin_ctrl(ctrl)) {
>  		/*
>  		 * Do not return errors unless we are in a controller reset,
>  		 * the controller works perfectly fine without hwmon.


-- 
Damien Le Moal
Western Digital Research


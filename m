Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA74C982DA
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 12:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8fEfMSBg5pZ40i0BOHQyy3E4aeIBM8aRA9n51hWGeEc=; b=ftwsLzryrg5+6LjTjwXpkeZ/gd
	bQxOS6502feJ15hNyWgQSS+mQyoe6F1e/OAtHJoUexBZjwVUMtFGZq552R27PYVP9YryiWPMC7u7p
	uNIA1OzlWnhXQ3we9NcWPytZ4zKV/LgP6MOeOCw7RSXHarkg1TsMdKvMwBGcRweZdk3KHlb9RcNlo
	yrcTFqzcXcCrczYZgRoh//oFF953pCb1tun0qQ5O3RpMyt/FQRdSj1uBJZwNMlODWwwlONCwaeefh
	u2ovesQx9QlXq0fUqWhTZq5jXedtRG9p+5EDM2sffUX6V7DTJYv+atyKHkI8GpylDVA6L0agl4c9q
	M7I6yALA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Xpj-0000000ENto-3hgD;
	Fri, 18 Sep 2026 12:36:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7Xph-0000000ENtE-32lQ
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 12:36:50 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B715668BEB; Fri, 18 Sep 2026 14:36:44 +0200 (CEST)
Date: Fri, 18 Sep 2026 14:36:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yao Sang <sangyao@kylinos.cn>
Cc: kbusch@kernel.org, linux-nvme@lists.infradead.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH v2] nvme: fix command effects log lifetime for
 multipath heads
Message-ID: <20260918123644.GA17165@lst.de>
References: <20260831075716.41711-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831075716.41711-1-sangyao@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_053649_911319_84ED51FC 
X-CRM114-Status: GOOD (  18.28  )
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

On Mon, Aug 31, 2026 at 03:57:16PM +0800, Yao Sang wrote:
> -static int nvme_get_effects_log(struct nvme_ctrl *ctrl, u8 csi,
> -				struct nvme_effects_log **log)
> +static int nvme_read_effects_log(struct nvme_ctrl *ctrl, u8 csi,
> +				 struct nvme_effects_log **log)

What is the reason for splitting this function?  It might or
might now be useful, but it distracts a bit from the actual
bug fix.

> -static int nvme_init_effects_log(struct nvme_ctrl *ctrl,
> -		u8 csi, struct nvme_effects_log **log)
> +static void nvme_init_known_nvm_effects(struct nvme_effects_log *log)
>  {
> -	struct nvme_effects_log *effects, *old;
> -
> -	effects = kzalloc_obj(*effects);
> -	if (!effects)
> -		return -ENOMEM;
> -
> -	old = xa_store(&ctrl->cels, csi, effects, GFP_KERNEL);
> -	if (xa_is_err(old)) {
> -		kfree(effects);
> -		return xa_err(old);
> -	}
> -
> -	*log = effects;
> -	return 0;
> -}
> -
> -static void nvme_init_known_nvm_effects(struct nvme_ctrl *ctrl)
> -{
> -	struct nvme_effects_log	*log = ctrl->effects;
> -
>  	log->acs[nvme_admin_format_nvm] |= cpu_to_le32(NVME_CMD_EFFECTS_LBCC |
>  						NVME_CMD_EFFECTS_NCC |
>  						NVME_CMD_EFFECTS_CSE_MASK);
> @@ -3550,25 +3553,41 @@ static void nvme_init_known_nvm_effects(struct nvme_ctrl *ctrl)
>  
>  static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  {
> +	struct nvme_effects_log *cel;
>  	int ret = 0;
>  
> -	if (ctrl->effects)
> -		return 0;
> +	mutex_lock(&ctrl->subsys->lock);
> +	cel = xa_load(&ctrl->subsys->cels, NVME_CSI_NVM);
> +	if (cel)
> +		goto out_set_effects;
>  
>  	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
> -		ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
> +		ret = nvme_read_effects_log(ctrl, NVME_CSI_NVM, &cel);
>  		if (ret < 0)
> -			return ret;
> +			goto out_unlock;
>  	}
>  
> -	if (!ctrl->effects) {
> -		ret = nvme_init_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
> -		if (ret < 0)
> -			return ret;
> +	if (!cel) {
> +		cel = kzalloc_obj(*cel);
> +		if (!cel) {
> +			ret = -ENOMEM;
> +			goto out_unlock;
> +		}
> +		ret = 0;

I also really do not understand the change here.

While the high-level idea looks good, this really needs to be
split into finer grade and well-documented patches that can be
easily understood.


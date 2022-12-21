Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E867FC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Dec 2022 21:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lx6B6VqzcB9BX9WijRBfo9izxrjOicwtrtGV34yF/UA=; b=d/EvJY/L+R4E9EWxo/JqThDEvi
	o0Jc1JWVPA/ItAzdrXCzthVigN9cPXLU/uRBZOhpGYJkPEKXfUzj25HDqBq+6Vu0q22kGvTBCSE7j
	VRakcTTGO5Bb7rBszNhLnQ8y4mPJkBopjT8H1c62K6qMyoPLA8wzXp2RMogh6cgB3YOYHELRobbye
	ygYnmEOBC+KWYLkdLcxvQJ9n2YtJV9NqqQSYf+sDH2cmKxqNMqU6tiYsc15Tha0sOwZE8gTkBagW2
	sDgBXZpxrH8ITXljXStqqn4Cxyi8hrpNtndumf1mKsRP48Xo2z2jrXXwIzEWEiLQ+JvOK/mPIBeVY
	X4NiCLGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p86sq-002sYH-GV; Wed, 21 Dec 2022 21:44:16 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p86rV-002s3a-5g
	for linux-nvme@lists.infradead.org; Wed, 21 Dec 2022 21:42:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6FCB56194E;
	Wed, 21 Dec 2022 21:42:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60121C433D2;
	Wed, 21 Dec 2022 21:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1671658970;
	bh=hyhj9VITLgc9/rvUTBE8hh5pbmFUmMgMDCOxzf/NJjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LiSn64/+Qd6W0HzAUQXx43ouL/n9b4473xBzff78O2Y6PVPmB3de/TxqDOenUa2xC
	 VDt6LrIUjUQb1ydOL+MBZIirzycymyfsBnXbGdYRyGxlwUIuTs3J7yT8l4ql3Z2I3a
	 LwSfhhPMJu3JMszCpelyeZRm70q2IrP9mc3a4/te+jrkUfCb4SOiNOMI6VZIue5aJh
	 cibGVxpJR1vEi+bSLBJcVSgknh1d9I6iSf0HQjczvLivTw7Pqmms7FTngf75/Hf2Ro
	 twutGzg3kNLAm0M20XnosMD3qba3UOTkL3U0M0LVeU/VE/RO0+4UCe3lyVOc8R+ZSX
	 6cs1BX5+7rWPA==
Date: Wed, 21 Dec 2022 14:42:47 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 5/6] nvme: also return I/O command effects from
 nvme_command_effects
Message-ID: <Y6N913AdRwkbyuAD@kbusch-mbp.dhcp.thefacebook.com>
References: <20221221101050.759606-1-hch@lst.de>
 <20221221101050.759606-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221221101050.759606-6-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221221_134253_787329_B1937EBF 
X-CRM114-Status: GOOD (  14.71  )
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

On Wed, Dec 21, 2022 at 11:10:49AM +0100, Christoph Hellwig wrote:
>  u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
>  {
>  	u32 effects = 0;
> @@ -1081,17 +1093,18 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
>  	if (ns) {
>  		if (ns->head->effects)
>  			effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
> +		if (ns->head->ids.csi == NVME_CAP_CSS_NVM)
> +			effects |= nvme_known_nvm_effects(opcode);
>  		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
>  			dev_warn_once(ctrl->device,
> -				"IO command:%02x has unhandled effects:%08x\n",
> +				"IO command:%02x has unusual effects:%08x\n",
>  				opcode, effects);
> -		return 0;
> +	} else {
> +		if (ctrl->effects)
> +			effects = le32_to_cpu(ctrl->effects->acs[opcode]);
> +		effects |= nvme_known_admin_effects(opcode);
>  	}
>  
> -	if (ctrl->effects)
> -		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
> -	effects |= nvme_known_admin_effects(opcode);
> -
>  	return effects;

Just noticed we need to mask out the CSE value for IO commands in case
some crazy controller sets it. If the driver were to see that value as
non-zero, it will freeze the IO queue the ioctl requires to to submit
its own IO request.


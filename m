Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F62CF9C5B
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Sep 2024 08:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D2G5Vqbevp/yIaIag+9lhops/RRlP8LJZvM/JNysPg4=; b=qzrmUWTZc+gFnxHWKAt7Sg2GLu
	GPGlrEVLlm3JGdYBj+lR8V0pml1e3ghkTJIZUlowOQvY7a/QeBvuvBrGgkbwAa3/h9NZ6ExpfRZ+q
	RlAAiIpxwZR+VyQM2yDzSDPdRy2pt5/Arksxv1CBYR0nJTq1Wu9Z3lq2RRWdWjtNoIUp8nkjPBNRd
	N/pJ89yEu3O9HU0inrPnAHU4PJq0/lJA0LYnCVEmd97JTSl7D1zEdGMN/lZRi9RGPBg3hwnyhn3Yl
	QXgwRTBNFNYZR1CBl/0wDXcijUR6vIOdqOnqhHdrcMBIV9GSy237cCqf085xuUumc5dk4y+t9MHfg
	8rFnYPXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sse2o-0000000Gc0T-2Upk;
	Mon, 23 Sep 2024 08:03:42 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sse2k-0000000Gby5-04MX
	for linux-nvme@lists.infradead.org;
	Mon, 23 Sep 2024 08:03:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EDB54A4176B;
	Mon, 23 Sep 2024 08:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E13BC4CEC5;
	Mon, 23 Sep 2024 08:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727078616;
	bh=q1YvSPbr3ZpWVyD76V31MKAxVlGjLN4FW1uQ88cLsCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X2AXpuzvAt6zolj50NuXZcTF782bCFtcCRK+feY5kicmhu6+VCsueeqzYwe/mCskN
	 AVB5mach1rAfcntoDgDsVQ704keLaRKN8UbKMfn2McZ1ibd3PvfFhnQwfbpkbK9rnb
	 lMua3uvohScz+FlSAUEGOB5OSIXlhsTX9SwXJSj8LVKG1PxRn3+Nezte3h525U3NBR
	 kX1Uj1ikpGYTrhuxU/cmqq5WlLfep966e7oC1iUb6b9N6/hVS5QEh35MVUb37B2YW8
	 9Zn4zvOi5RvSn20rzLhgHqIhLrTcTQbzJd1T6zwfGk2Rslu9NRtgOO+nCi2TnG20V2
	 2iuvSJaUnYtCQ==
Date: Mon, 23 Sep 2024 10:03:32 +0200
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH] nvme: remove CC register read-back during enabling
Message-ID: <ZvEg1Fq6wy7eQ5VV@kbusch-mbp>
References: <20240904215405.1980512-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904215405.1980512-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240923_010338_232645_B9BCE7E5 
X-CRM114-Status: GOOD (  16.39  )
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

On Wed, Sep 04, 2024 at 02:54:05PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Any non-posted read should flush the previous write, so we don't
> necessarily need to read back the value we just wrote. I've found at
> least some controllers that respond with 0 for short moments after
> writing the CC register with EN (enable) cleared, so the read-back is
> overwriting our valid ctrl_config value and ends up breaking on the
> subsequent enabling.

Ping on this one. Looks okay?
 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 983909a600adb..3172d7dab43bb 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2467,11 +2467,6 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
>  	if (ret)
>  		return ret;
>  
> -	/* Flush write to device (required if transport is PCI) */
> -	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CC, &ctrl->ctrl_config);
> -	if (ret)
> -		return ret;
> -
>  	/* CAP value may change after initial CC write */
>  	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &ctrl->cap);
>  	if (ret)
> -- 
> 2.43.5
> 


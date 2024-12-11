Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6325EE7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 15:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OORWragfJ2uqB2Dr/bDQS20ALiIbH6lBYk494Y1dSRE=; b=FG1fycUgsOadwaphVJ4i7fqCaR
	0nJ0wfIPcexOJe94JWgF79yXQFEsO4ceZuP/+eE++FwJkjSK48Cj5MDll0jQ0jic3ifaT2HR3Z7RR
	SzVMRLxh1IhKTSG71XNEjJgOVdAUYeQeH3tudP0dt+S8WAC0Ga384t1eKz/BTOP3cC43TRTqMAmWy
	A543ZBCvRPkMcxObi1ULKrjZCnmUQS1NavBWJkizIAZX1I0Gt9vgqAQggYmWitk0KYl+054T7Raqf
	OmkSQSEIllDoYOJKlYtYsbe8p2luirzlezwc2SxGQ4dIRAnbbjdVvvrgo3MlwMEMA1heCuh0AVp+i
	iS7TnhTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLP6Q-0000000FMLi-07sx;
	Wed, 11 Dec 2024 15:58:18 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLP3J-0000000FLZ5-2LPr
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 15:55:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 25BBFA40C5F;
	Wed, 11 Dec 2024 15:53:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5469BC4CED4;
	Wed, 11 Dec 2024 15:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733932504;
	bh=RXF+v+iA4+BiB0Hp3z1G8RrN4yADVTbgODi8hIUiO1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9pGK4Pt++zvdFBgklMPWCnAFvBiDe4YY05JqNPcVx6H1GiCpOaClb3Lo2dEk5XzD
	 gPUBNpojjR7vfBI0DnyF+58ki1fIhfk30JuNQD2zYWjYHoD4Yk8Ya3JESiO7Zvr7BT
	 Sb/l7w3NXRvHLWVbo52B9XzyQJukl29QTegIjDo1WFO9zRKZVYBfTARlEDZlxBRJwu
	 9eh6toLFzVftkFEgU7iYWShvgSU/y9CzI5QQ+t4CJkv5CEjGwdz2dcBzBq5f9wSJJm
	 26iq7dZU4fjzYgJ44hB+EBom7yvU1RU0D4qAAb9K6PfgXrLA+uxPU+OQBd4X4uk+M9
	 7PMmoFXJv0YSg==
Date: Wed, 11 Dec 2024 08:55:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	sagi@grimberg.me, asml.silence@gmail.com, anuj20.g@samsung.com,
	joshi.k@samsung.com
Subject: Re: [PATCHv13 10/11] nvme: register fdp parameters with the block
 layer
Message-ID: <Z1m11Vz7eIj-sxtq@kbusch-mbp.dhcp.thefacebook.com>
References: <20241210194722.1905732-1-kbusch@meta.com>
 <20241210194722.1905732-11-kbusch@meta.com>
 <a8964dab-8075-4417-bcf3-87c67fe758c0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8964dab-8075-4417-bcf3-87c67fe758c0@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_075505_737521_95924C33 
X-CRM114-Status: GOOD (  19.81  )
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

On Wed, Dec 11, 2024 at 09:30:37AM +0000, John Garry wrote:
> On 10/12/2024 19:47, Keith Busch wrote:
> > +static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
> > +				      struct nvme_ns_info *info, u8 fdp_idx)
> > +{
> > +	struct nvme_fdp_config_log hdr, *h;
> > +	struct nvme_fdp_config_desc *desc;
> > +	size_t size = sizeof(hdr);
> > +	int i, n, ret;
> > +	void *log;
> > +
> > +	ret = nvme_get_log_lsi(ctrl, 0, NVME_LOG_FDP_CONFIGS, 0,
> > +			       NVME_CSI_NVM, &hdr, size, 0, info->endgid);
> > +	if (ret) {
> > +		dev_warn(ctrl->device,
> > +			 "FDP configs log header status:0x%x endgid:%x\n", ret,
> > +			 info->endgid);
> 
> About endgid, I guess that there is a good reason but sometimes "0x" is
> prefixed for hex prints and sometimes not. Maybe no prefix is used when we
> know that the variable is to hold a value from a HW register / memory
> structure - I don't know.

%d for endgid is probably a better choice.
 
> further nitpicking: And ret holds a kernel error code - the driver seems
> inconsistent for printing this. Sometimes it's %d and sometimes 0x%x.

It's either an -errno or an nvme status. "%x" is easier to decode if
it's an nvme status, which is probably the more interesting case to
debug.
 
> > +		return ret;
> > +	}
> > +
> > +	size = le32_to_cpu(hdr.sze);
> > +	h = kzalloc(size, GFP_KERNEL);
> > +	if (!h) {
> > +		dev_warn(ctrl->device,
> > +			 "failed to allocate %lu bytes for FDP config log\n",
> > +			 size);
> 
> do we normally print ENOMEM messages? I see that the bytes is printed, but I
> assume that this is a sane value (of little note).

I suppose not.

> > +		return -ENOMEM;
> > +	}
> > +
> > +	ret = nvme_get_log_lsi(ctrl, 0, NVME_LOG_FDP_CONFIGS, 0,
> > +			       NVME_CSI_NVM, h, size, 0, info->endgid);
> > +	if (ret) {
> > +		dev_warn(ctrl->device,
> > +			 "FDP configs log status:0x%x endgid:%x\n", ret,
> > +			 info->endgid);
> > +		goto out;
> > +	}
> > +
> > +	n = le16_to_cpu(h->numfdpc) + 1;
> > +	if (fdp_idx > n) {
> > +		dev_warn(ctrl->device, "FDP index:%d out of range:%d\n",
> > +			 fdp_idx, n);
> > +		/* Proceed without registering FDP streams */> +		ret = 0;
> 
> nit: maybe you want to be explicit, but logically ret is already 0

Yeah, we know its zero already, but there are static analyisis tools
that think returning without setting an error return code was a mistake,
and that we really meant to return something else like -EINVAL. We
definitely want to return 0 here, so this setting exists only to prevent
future "help".


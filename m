Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F42BC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IHtIW7FU/GGTVE9XkT6x2aI5iRny1jcanWSMrJh5uYs=; b=fvWZD1Xv2UMngaNG7QNHodOdLG
	Ckwt9dW5k+EH3vaB7Vd4vCoFJAMlg8Qt+fMAJXViR6DV9yH/eW4WWIZnmT93Imrn5Wa4BqjpG6NrR
	36TcJP+gcHJ4kT24gkO2lxEz/sD4qX2y/Ea94mdmsZkUONTwZYK4cleiXR+OGyNnP3EgcEN275V8g
	4GDFm+5qYjuranvE5z2JBxfykr5RccDHwW4pHk7abz2cnS5GM2hDSdb31wRHk3XltkmSKOM44Rons
	FTyaeyFMkoJQlPQFPqFNCCGFPnZFa5jDLEihB3YlA/qO3CqKS0YIjuT90qwmHSj3dqo6qTGPxEzUu
	lQZNRlqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrKnF-002Ym8-Rx; Wed, 18 May 2022 14:36:53 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrKnD-002YlC-8e
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 14:36:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D08AE6192F;
 Wed, 18 May 2022 14:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCB0C385A5;
 Wed, 18 May 2022 14:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652884610;
 bh=DVFwCNt4tWISdtNePvDpvsugSFdDw+DrH4hjxRlxuh4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o0BfG7EZ3tuG6gKTDZOjKqyGRi7t0Vz/681IT/7a6/JPJWpEZd0GrqX4MDaQonbLh
 B4lZO0GvdKrT966LNtBIuW6wUwxS7gblYpiYd7pFXC0/l/EGlI6zt8LMX6jHIhvlMH
 0pXsZsAEeIZVY3JoDNe7rF0+8H8CJk7aug6uquH/2snMHnldGITqGMy1a+ZSnuwqp8
 PVJs7BXNwzC8zYDpErR0URtCEWll+jSt7QInbNX8iIgnvbG5O3f5mefjFC5R5yhdYf
 +xND/hL21K1WkykVCgPmFvColwEtDXsYaAHVOnLGOzXXB3bAZVmMav7WDZS4iBRc8K
 /V12ehJPmb+5Q==
Date: Wed, 18 May 2022 08:36:47 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: add support for TP4084 - Time-to-Ready Enhancements
Message-ID: <YoUEf5nsyhVzeDH/@kbusch-mbp.dhcp.thefacebook.com>
References: <20220518064040.3223894-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518064040.3223894-1-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_073651_354257_F3F57D9D 
X-CRM114-Status: GOOD (  14.67  )
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

On Wed, May 18, 2022 at 08:40:40AM +0200, Christoph Hellwig wrote:
> +static int nvme_identify_ns_cs_indep(struct nvme_ctrl *ctrl, unsigned nsid,
> +			struct nvme_id_ns_cs_indep **id)
> +{
> +	struct nvme_command c = {
> +		.identify.opcode	= nvme_admin_identify,
> +		.identify.nsid		= cpu_to_le32(nsid),
> +		.identify.cns		= NVME_ID_CNS_NS_CS_INDEP,
> +	};
> +	int error;

Every other place in this driver calls this value 'ret'.

> -static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
> +static int nvme_wait_ready(struct nvme_ctrl *ctrl, bool enabled)
>  {
> -	unsigned long timeout =
> -		((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
> +	unsigned long timeout = ((ctrl->enable_timeout + 1) * HZ / 2) + jiffies;

I think we need to continue using the NVME_CAP_TIMEOUT() value when 'enabled'
is false. The enable_timeout is only applicable for the 0->1 transition and may
be too short if CRIME is set or too long when it's not.


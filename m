Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE55DCDB47E
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Oct 2023 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e1GnV6uCDMzgzvtZ3/KmT9QmzkIW0FvWBx8gE+q2uNg=; b=PmzCCiFykRHNSGUmqR3gMSmwFg
	x3lPQgYq/gN5guKNzN4xvfqCLZ4Ria+xmVEWup2+sb8vRv0UT77iDNs/peVE4YdQc2uxFz1VX0vgn
	8ChItj2RVoWQXWWLTtWifc47k+oJ6xSyT9bC6XhB0Lm+VfLecbY3BByjk9KmZQp7+WRfB35eNkFo/
	BjZaXN2p3S77i3B/FHRscyDHuM3dkmeT8lqC/hT5fazI3HF5wIPmtOViceJFAxeWsAGUM1hkWaPpH
	53SZzd8hkpwB9qAgZnMBu1nwcNhNSEcvi/Guho8QP3hu1bz7lzoFA+bf5lgdGlL7Q952/3EUFMK7n
	ekc50Ifw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qrLGY-003u4r-21;
	Fri, 13 Oct 2023 16:43:58 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qrLGT-003u4G-2A
	for linux-nvme@lists.infradead.org;
	Fri, 13 Oct 2023 16:43:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id CEFD5CE3119;
	Fri, 13 Oct 2023 16:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF32C433C8;
	Fri, 13 Oct 2023 16:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697215431;
	bh=fNhicONj1ekrnfRc2uQFmE8uC7unApfdctES3UAtqYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbTDyQbr7+0/56UsczyfBJ8nS3mFVQfES2Fe83+LMZe5j1B5lOx2W038HcUClejtm
	 OgErDdh+Zh+hBfoRY9TWRdiVjemnIixGyvLKiL1MiEO6+Ry9NA7GeGe0iMpx4OwOPy
	 G1camTGX7s3RX/+fQ/0S6dT36Bi0BWm2ljexKCnkVZskzMx6OumyGtHVl0dD2Kd3MX
	 eswvh/CcBP6KhRFj2ee72GMUZNL+W9SAZ27nPgM/23pnZR1jKXTVar2itkaoYlflhv
	 MehZM8WTZPCeJNiRZvUFGVIKmrpmt6FsA6+Cb1dvvLgcSW3Gz5e8duc1s6/vtu7zX4
	 evd7rsRxp77DQ==
Date: Fri, 13 Oct 2023 10:43:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Kenji Tomonaga <tkenbo@gmail.com>
Subject: Re: [PATCH v2] nvme: update firmware version after commit
Message-ID: <ZSlzxGx8k9pgkhDk@kbusch-mbp>
References: <20231013163420.3097-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013163420.3097-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231013_094353_883777_669BBE9D 
X-CRM114-Status: UNSURE (   9.45  )
X-CRM114-Notice: Please train this message.
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

On Fri, Oct 13, 2023 at 06:34:20PM +0200, Daniel Wagner wrote:
>  	if (nvme_get_log(ctrl, NVME_NSID_ALL, NVME_LOG_FW_SLOT, 0, NVME_CSI_NVM,
> -			log, sizeof(*log), 0))
> +			 log, sizeof(*log), 0)) {
>  		dev_warn(ctrl->device, "Get FW SLOT INFO log error\n");
> +		goto out_free_log;
> +	}
> +
> +	afi = le64_to_cpu(log->afi);
> +	if (afi & 0x30) {

That should be 'afi & 0x70'.

> +		dev_info(ctrl->device,
> +			 "Firmware is activated after next Controller Level Reset\n");
> +		goto out_free_log;
> +	}
> +
> +	memcpy(ctrl->subsys->firmware_rev, &log->frs[afi & 0x3],

and 'afi & 0x7'.


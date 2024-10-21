Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEBCD17142
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Oct 2024 22:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VSzF5RSGDE+Y3rqYDkiPGmiQO8n+qjSPxsnGloWCYX8=; b=XQ+3lzu7S9AhWZtw5HlcYa1xP+
	CxbA4L6r7TUajrriFQrk22OaCsVSF/02Q80+BjMGCFGJwlHhOzZLVDx1+TuHwr4qsNwEY7st5VnBK
	6HCeLJzLJsLRI6Quo2Z6Bv8nQKQvhCTi+pxexyT5vWgYFU1qxO2PWUH2K+P9zO55fH6Qh1iQZh0C9
	ZOWghw3eGXvftErz2WWiFs9uOrvWFKsiXX/JQb7k4jUAZcQDib1EDSWDeEqjfztZyz1HtNQqq1Vt4
	ZyiNB2C/diMjOA10Ug7ihvVdFgvoXNvnJoW+aXkBDg9TgHUJALItHC3A7f1/JyCG1yxMYDZL4dFdw
	m4a3QzQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t30yD-00000008qsU-1leb;
	Mon, 21 Oct 2024 22:33:49 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t30yA-00000008qs9-2n45
	for linux-nvme@lists.infradead.org;
	Mon, 21 Oct 2024 22:33:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 87F235C5583;
	Mon, 21 Oct 2024 22:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4984CC4CEC3;
	Mon, 21 Oct 2024 22:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729550025;
	bh=VSzF5RSGDE+Y3rqYDkiPGmiQO8n+qjSPxsnGloWCYX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XNt/FHo4CtNQYtI0r5K58aWltOwnGfgPsvEfXuKuq68eBUKr3JyUhX8NCU5ZQ7+a9
	 voWd+PSqbqLxNLNuOAVk0vF0bs/XGVygDbt0QFdsduv/RzgNJ66Ay1uvFwb5MoI0Dv
	 wSTtfh+OVesqcNXbbEe/n75sYeI0vCsH061ue62Fx/GtetN2N9XQ3ElnXap2eX5w7F
	 SHnE7kBIwbRPeo25/a+mbxtS+L0UpimU5AS13CABVL/0LzZlnZOiQsCcc+m5DIRYSJ
	 hhdZ4oVAuG0IIjexRkWXV6A4p4KRXVRS4GZFiXofM1aAPpwauEAj6uQedPKuHKKr1S
	 3l5uedYI0ba4g==
Date: Mon, 21 Oct 2024 16:33:42 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	shinichiro.kawasaki@wdc.com, d.bogdanov@yadro.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v17 2/2] nvmet: support reservation feature
Message-ID: <ZxbWxuzH3u6hAezr@kbusch-mbp>
References: <20241021110331.125962-1-kanie@linux.alibaba.com>
 <20241021110331.125962-3-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021110331.125962-3-kanie@linux.alibaba.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241021_153346_768850_DF332F65 
X-CRM114-Status: GOOD (  11.34  )
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

On Mon, Oct 21, 2024 at 07:03:31PM +0800, Guixin Liu wrote:
> new file mode 100644
> index 000000000000..aa69656a0ac5
> --- /dev/null
> +++ b/drivers/nvme/target/pr.c
> @@ -0,0 +1,1186 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * NVMe over Fabrics Persist Reservation.
> + * Copyright (c) 2024 Guixin Liu, Alibaba Group.
> + * All rights reserved.
> + */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#include <linux/unaligned.h>

I don't find any such file. Should this must have said <asm/unaligned.h>
instead? Curious to know if the target side was actually tested.


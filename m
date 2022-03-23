Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A33C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Mar 2022 16:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s0gpXk6k/ByESunoaPtZJVxnF9ZofIJRDQfIStp4DGo=; b=mVptpvQDqv707E7oCcXnDMGffu
	KVC2Xyres5NS8raWX6d1EFi0fkfp6+g6MSLyCCmnN0xH5CrlYc99isl8IDn4UJcMDoltl3VHsmyBc
	yvNhfNkIZtpBHYcMSIgOlPMdDSQymupzu4N/jLoQUPl4G+Pl9hJp02j7LliEnPUyXapIGS/J6aF6J
	8+bfVSiWcSv5kNBZ4f0ddbwN4+blJBgGoHUmc9eVm9h2GmpjCP67s9sxkoyCG/CwII/C0WjMKr4E/
	Fg6okAEM+I3IQTlCdMR31bCwrBzRY0lsd02biPV/9onRf5MpHvHTpIhIL2a4egU53aSRe6KzBWezT
	GMRDYRnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nX3vr-00EGRc-P9; Wed, 23 Mar 2022 16:33:59 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nX3vo-00EGQE-Ka
 for linux-nvme@lists.infradead.org; Wed, 23 Mar 2022 16:33:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 703AA68B05; Wed, 23 Mar 2022 17:33:52 +0100 (CET)
Date: Wed, 23 Mar 2022 17:33:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [linux-nvme:nvme-5.18 4/5] ERROR: modpost: "nvmet_wq"
 [drivers/nvme/target/nvmet-fc.ko] undefined!
Message-ID: <20220323163352.GA1560@lst.de>
References: <202203240012.gJehzedI-lkp@intel.com>
 <9c747632-2cd0-3096-40d8-e3df40b95679@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c747632-2cd0-3096-40d8-e3df40b95679@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220323_093356_859485_59E58D15 
X-CRM114-Status: GOOD (  13.35  )
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

On Wed, Mar 23, 2022 at 06:33:13PM +0200, Sagi Grimberg wrote:
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -18,6 +18,7 @@
>  struct workqueue_struct *buffered_io_wq;
>  struct workqueue_struct *zbd_wq;
>  struct workqueue_struct *nvmet_wq;
> +EXPORT_SYMBOL_GPL(nvmet_wq);
>  static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
>  static DEFINE_IDA(cntlid_ida);
> --
>
> Christoph, can you fold it in or should I?

I'll fold it in.


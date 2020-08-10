Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3940C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 12:33:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91F2D2078D
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 12:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VFDNG4Nt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F2D2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=s1SL/U2GY9dMrLhhdVq8n2xN2we9lmcaxuwEyRfizJw=; b=VFDNG4Nt9B1xke2FiPuvr3BRA
	URoH3T0dIEiKBdNRQdT1lbGeHE8/lP/ht+qcanyHgtiFbguF9u9lJzY7L6wISTEZbB+TgJIfgW6ch
	5Ub0eE/0CYbdUFYdtfcM5Y5WU5hyBFaZWhmcyWzx1Y8ZJHtynO7prZayqReMacwdD/GTzZqc+YHsh
	d65Tzha3yHBB/4KOVLdPReMLsq+767TsMKsLJQ8y4HJ3Bbttgm0tES6I3vKzSqsI3LRif4eEIZMCp
	vzXQxLSfd674ByYSdQotWoic0wYh9x/+/s7xiYuiMUzWxhBr2HPCYh3cuq2MXuZxZvixTsLMeWtUJ
	3bxuMiuXw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k56zN-0003BS-U2; Mon, 10 Aug 2020 12:33:17 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k56zL-0003B4-NQ
 for linux-nvme@lists.infradead.org; Mon, 10 Aug 2020 12:33:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 68D4168AFE; Mon, 10 Aug 2020 14:33:13 +0200 (CEST)
Date: Mon, 10 Aug 2020 14:33:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: skip noiob for zoned devices
Message-ID: <20200810123313.GA20069@lst.de>
References: <20200807163235.4155607-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200807163235.4155607-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200810_083315_878845_0DEF3CA4 
X-CRM114-Status: GOOD (  17.76  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Aug 07, 2020 at 09:32:35AM -0700, Keith Busch wrote:
> Zoned block devices reuse the chunk_sectors queue limit to define zone
> boundaries. If a such a device happens to also report an optimal
> boundary, do not use that to define the chunk_sectors as that may
> intermittently interfere with io splitting and zone size queries.

Instead of skipping shouldn't we use the max of noiob and the zone
size, even if that is mostly theoretical?

> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> v1->v2: Fixed the if condition to check for *not* zoned.
> 
>  drivers/nvme/host/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 88cff309d8e4..4e0225d85e70 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2075,7 +2075,7 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>  		}
>  	}
>  
> -	if (iob)
> +	if (iob && !blk_queue_is_zoned(ns->queue))
>  		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
>  	nvme_update_disk_info(disk, ns, id);
>  #ifdef CONFIG_NVME_MULTIPATH
> -- 
> 2.24.1
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

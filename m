Return-Path: <SRS0=LrAE=X6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A45C3E8AB
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2019 08:48:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0336E20830
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2019 08:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UMDj+6wj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0336E20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vmvmonITT4SWMXGyRupjqN9f7N9xw/T1SEKuONQK7+k=; b=UMDj+6wj2eYEXC
	iCFzdk0HxLx2hKNrXnMmaXYECnzBw+ZXK+t8h5KUeXbSjgOUId3/aDlVPUTbfKh1nWcTJvZ88YYA4
	0w1XBtBjZb8PzI8fboT8wP1P2wpOLOH6YdmeHpQ8ZvxYUR0oIGc9YcK+/3xY1nfC8ZgSmeutvEs18
	vOBRG96liouGWFgX4bOJBlTamKnuTh/TcSKVjARRayGRMUQuTyQyCC2Bsu3EXd91bUDcdiNA+fVh4
	tk0eCV7EUv+ixmNRwdPTghKAr7AiwG5sWgUzJEUWLpOsDHNU80cJCE+L+JCL0u3AG9czQo+rWuP68
	riu/Y2vPnz0t7IeR581Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iGfkB-0003Dv-1x; Sat, 05 Oct 2019 08:48:51 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iGfk8-0003DP-4M
 for linux-nvme@lists.infradead.org; Sat, 05 Oct 2019 08:48:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 91DFE68B05; Sat,  5 Oct 2019 10:48:40 +0200 (CEST)
Date: Sat, 5 Oct 2019 10:48:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme: fix possible deadlock when nvme_update_formats fails
Message-ID: <20191005084840.GA15867@lst.de>
References: <20191004182216.24314-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191004182216.24314-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191005_014848_323988_EAB0967A 
X-CRM114-Status: GOOD (  10.09  )
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
Cc: Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index fd7dea36c3b6..ef1d8f81f69e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1306,8 +1306,6 @@ static void nvme_update_formats(struct nvme_ctrl *ctrl)
>  		if (ns->disk && nvme_revalidate_disk(ns->disk))
>  			nvme_set_queue_dying(ns);
>  	up_read(&ctrl->namespaces_rwsem);
> -
> -	nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
>  }
>  
>  static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
> @@ -1323,6 +1321,7 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
>  		nvme_unfreeze(ctrl);
>  		nvme_mpath_unfreeze(ctrl->subsys);
>  		mutex_unlock(&ctrl->subsys->lock);
> +		nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);

Don't we need a check for NVME_CMD_EFFECTS_LBCC before this?  There is
no goog reason to call this if the command just has restrictions on
execution.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E038E7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 06:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i1EPEysNwbSeKpYEVFjCzxK5EhFY8G04JxNpnJTfMWg=; b=0SBrYLdF2FV3Th4IqjFr22cxT4
	2I/szq2qJCAEbIS7f/7xauXjijd117dlpzL1m/2h3rktwTslcES6pjxD2/0Vep2y6sIWsO+7osiQg
	CmCBl0BoIjaxUnPUKEKEtS35I9+uKwxm8+mM6CFhFDKiaDCUo8gqaI12J7abDMO1DZl6f9a9GpTpM
	fYBTGMjR8H537a174pm0w8FJZDYTmrrFxqdlLaZQf07CAaakE1Js/UOrJRMdOEWm2+LzS51pPamxL
	8ZsqDJye63DMHYeISJcyvOa84vqTezu40u/bH6cJwjuLkfzV1Hl/wncWs7CUlBGusVeKts3w56fcT
	KnFJthVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLcg2-0000000H2yY-380I;
	Thu, 12 Dec 2024 06:27:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLcg0-0000000H2y2-3VDk
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 06:27:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EFABA68D17; Thu, 12 Dec 2024 07:27:49 +0100 (CET)
Date: Thu, 12 Dec 2024 07:27:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keisuke Nishimura <keisuke.nishimura@inria.fr>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: Allocate memory for xa_store in advance in
 nvme_get_effects_log
Message-ID: <20241212062749.GA5718@lst.de>
References: <20241202124239.49894-1-keisuke.nishimura@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202124239.49894-1-keisuke.nishimura@inria.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_222757_024537_31361DD7 
X-CRM114-Status: GOOD (  13.49  )
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

On Mon, Dec 02, 2024 at 01:42:40PM +0100, Keisuke Nishimura wrote:
> +	ret = xa_reserve(&ctrl->cels, csi, GFP_KERNEL);
> +	if (ret) {
> +		kfree(cel);
> +		return ret;
> +	}
> +
>  	ret = nvme_get_log(ctrl, 0x00, NVME_LOG_CMD_EFFECTS, 0, csi,
>  			cel, sizeof(*cel), 0);

There isn't really any point in doing a xa_reserve here vs simply
handling the xa_store error a bit below.



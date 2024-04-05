Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F9ECD1284
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 06:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N+y4gVZPxqoPWF3mCG9OTNmFc7apGuxsri5ldIPkgQ4=; b=ALRAvnIeKYAx+2TOB53JF8+PN0
	7D7HVTbJi3PGAni6wN/SJH/qsnPu15q0qeAMjl1R3efCITjYIxoTWKQTQe4TnwuYIfnG0E2z0w/ZP
	1kGC86TRtYXoR7cGTbX8n2bHbAVZFUOrh8D+kD8veYsqqk5X+quVhArg49oxuHvlIt7VKNvbdpKLF
	v87Ka5CC7lZJnIb0xK7HL7WHyiJ4JfY0+FbS0cf760UZEEaDFgol+T9WNspmCIKtSWOeXVdcMiy7w
	3Yo/BwofVyCzANMWXFd0R+dYtrjk4aYEM3lXbGsVJiK+jjXVXx43cHpStGK/EBK5WeQO+dZc+ZEJq
	fjr/LPJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscsK-00000005QxF-32mP;
	Fri, 05 Apr 2024 06:16:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscsI-00000005QwP-1YXj
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 06:16:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9E16C68D07; Fri,  5 Apr 2024 08:16:25 +0200 (CEST)
Date: Fri, 5 Apr 2024 08:16:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] nvme: authentication error are always
 non-retryable
Message-ID: <20240405061624.GA3107@lst.de>
References: <20240404154500.2101-1-dwagner@suse.de> <20240404154500.2101-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404154500.2101-2-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_231630_629960_53E26B26 
X-CRM114-Status: GOOD (  13.10  )
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

> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -467,7 +467,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>  		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
>  			dev_warn(ctrl->device,
>  				 "qid 0: secure concatenation is not supported\n");
> -			ret = NVME_SC_AUTH_REQUIRED;
> +			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;

This is still abusing on the wire status code for in-kernel return
codes.  Can we please sort this out properly?



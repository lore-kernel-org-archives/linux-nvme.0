Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CCCC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Apr 2022 05:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=geBXmlh1u10/w/Qp7vWdjbucLHi+uKxTdI2w0f+ktpY=; b=nvz/ecfY14UF1+PNdG+x3tAk/R
	vuTUbibstJplcXCc+4Mb0Dyaph0MYrcPATKgiqC+MaQWb5BxAL2zDOK8WBAHr0q1iC/4k2uDiOwiO
	3pFGMl4lwnE372X7vLVNSM1DSrpDTdLa3ZJNIwhutyXCPSiFk7YtTthhV3x4e9wyGAlrdUh8tkGK4
	eyriS2Wjt/A7dao06QyEY5JkcRGu4MrrgdC0gb+g8mU76usz2zd/rwmZpZB9jUHALvEc8vna7K3Ac
	Fyq4ZHrau4UfLHQYjTLBRtOkRVqfAGbRF7E9eRTavPFBDgEgNS/nHBOL/36OF/eoGfsDTBR0Em96E
	3k5CiUSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nchQy-00FBhl-2W; Fri, 08 Apr 2022 05:45:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nchQu-00FBhA-Sn
 for linux-nvme@lists.infradead.org; Fri, 08 Apr 2022 05:45:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D7C7868AFE; Fri,  8 Apr 2022 07:45:16 +0200 (CEST)
Date: Fri, 8 Apr 2022 07:45:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH 1/2] nvmet: handle admin default command set identifier
Message-ID: <20220408054516.GA32232@lst.de>
References: <20220408023930.85774-1-kch@nvidia.com>
 <20220408023930.85774-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408023930.85774-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_224521_113761_B2F1E561 
X-CRM114-Status: GOOD (  11.50  )
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

On Thu, Apr 07, 2022 at 07:39:29PM -0700, Chaitanya Kulkarni wrote:
>  			switch (req->cmd->identify.csi) {
>  			case NVME_CSI_ZNS:
>  				return nvmet_execute_identify_cns_cs_ctrl(req);
> +			case NVME_CSI_NVM:
> +				return nvmet_execute_identify_ctrl(req);

This needs to return the "I/O Command Set Specific Identify Controller data
structure" defined in Figure 102 of the NVM Command specification

>  			default:
>  				break;
>  			}
> +		} else {
> +			switch (req->cmd->identify.csi) {
> +			case NVME_CSI_NVM:
> +				return nvmet_execute_identify_ctrl(req);
> +			}

And we should probably restructure the code like:

		switch (req->cmd->identify.csi) {
		case NVME_CSI_NVM:
			return nvmet_execute_identify_cns_cs_ctrl_nvm(ctrl);
		case NVME_CSI_ZNS:
			if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED))
				break;
			return nvmet_execute_identify_cns_cs_ctrl_zns(ctrl);



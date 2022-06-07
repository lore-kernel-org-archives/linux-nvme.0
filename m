Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CBDC43334
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 10:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7N2bZokFiVecqXuJRoV4z2+vDXbNDq9o7RQC9ui0NLQ=; b=hS8W3ch/5tXpXXxsl/TJ63xe8i
	RtFG2XcLuvXUgP4EpRPzR3zTwO9nulDE9q96qmgmEY+vDW8/EizwwhuLMiTzaYpVztWAxeKoOXmKt
	jAp/Nlwi8MtIiKVuRqSTSMjgRFPAkF9voLldnPXiV45JSyO+4SyckAAN0dcpREq8ij8D8odA20wma
	qD10l5oOOtOi7j4sVezqnBKapCQEyHyTYBWrF3B1N9EKvOmF/mjMK7d9ZtezxIapJYtfb5+Gyti7X
	C9ivS99Z73eJW+W39qDrdpmWGaRqS3tYZLvMSb1UQ0EOBSte2r13zsWo9LV7xncqjBwTyW2tgPf4K
	HSIvl6HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyWps-006qcj-Nj; Tue, 07 Jun 2022 10:53:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyWmP-006owj-EH
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 10:49:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 79A2567373; Tue,  7 Jun 2022 12:49:41 +0200 (CEST)
Date: Tue, 7 Jun 2022 12:49:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/9] nvme: Implement In-Band authentication
Message-ID: <20220607104941.GA26223@lst.de>
References: <20220527080457.90855-1-hare@suse.de> <20220527080457.90855-5-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220527080457.90855-5-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_034945_657180_7922F9E8 
X-CRM114-Status: GOOD (  14.69  )
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

On Fri, May 27, 2022 at 10:04:52AM +0200, Hannes Reinecke wrote:
> +config NVME_AUTH
> +	bool "NVM Express over Fabrics In-Band Authentication"
> +	depends on NVME_CORE

Does this actually depend on NVME_CORE? As that would suck when pulling
this code into the target driver as well.  Also in addition to the header
location already mentioned by Max, this should probably go into
drivers/nvme/common/ if used by the host and target code.

> +	  This provides support for NVMe over Fabrics In-Band Authentication.

This should probably mention that the support can be used both by the
host and target code.


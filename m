Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49480C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 16:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LrzoHzBA3Xi2P3risk3K4W6QkqZp0SJiUomCMA0YUGg=; b=4kY55q/E6P7zjT40x4DWfHjRZS
	qpKU7m5pDiyLj6JQ2Yp4GwxbMHbidI24gyfvWE/FPmuLv2amDPSC8UkhxomZLLlK55SE4zquaIJnt
	SovPSUuIZbHZjoF8UhMDncZGK8GfXxo+cLhorMfOSJVoABC5g1SWEPRr5DyD2ecO2aWG9xajW1LwF
	LeSfLGzUtBaarSudY+ahEAOElLt7v5L0ovvTVsVR6dJzgrFoDUW+dFBz723wUoFmiWg3v3GLpRJ2a
	qSBRdOO/SJU6M8j2clELPIq3bEUEB6+a1+szUGJU9zYwDw5z99aHxOfGzPerWtq3ct1eZ9/jwUtOP
	m46NiZxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncUdQ-00CvkU-4b; Thu, 07 Apr 2022 16:05:24 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncUGJ-00CljJ-FH
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 15:41:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id F3D3068AFE; Thu,  7 Apr 2022 17:41:27 +0200 (CEST)
Date: Thu, 7 Apr 2022 17:41:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvmet: include all configured ports in the
 discovery log page
Message-ID: <20220407154127.GB15988@lst.de>
References: <20220407104808.29007-1-hare@suse.de>
 <20220407104808.29007-4-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407104808.29007-4-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_084131_712147_9402B90B 
X-CRM114-Status: GOOD (  15.76  )
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

On Thu, Apr 07, 2022 at 12:48:08PM +0200, Hannes Reinecke wrote:
> +		if (req->port->disc_subsys == nvmet_disc_subsys) {
> +			/*
> +			 * Present information about the port to which
> +			 * the controller is connected.
> +			 */
> +			if (r != req->port)
> +				continue;
> +		} else {
> +			/*
> +			 * If a per-port discovery subsystem is used present
> +			 * information about all ports into which the
> +			 * same discovery subsystem is linked.
> +			 */
> +			if (ctrl->subsys != r->disc_subsys)
> +				continue;
> +		}

Please factor this logic in a helper given that it is also used
by discovery_log_entries (and to document the logic a bit better).


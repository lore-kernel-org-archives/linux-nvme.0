Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A92CC7EE22
	for <linux-nvme@archiver.kernel.org>; Thu, 11 May 2023 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KMn/EqBBMocm+76cjt/oElzj9DXsIpNeXvgtxn5wB0U=; b=TgE/fud2CXykopfblpfo8RdCEs
	TgIf5bwV73EdoEHpCSK0j18z63BJ/2nk4T1/+TKxqkISo2X0mUdB+nHVSnnDRwyKP/kqtJGmLOZfz
	gJyGob7yU8d5+Kqnsveyl4k2q5w07WKh0ouOrOo0dOLNXCCQ8HF+8EcYJtFh1vCpTMxsvaBqMiBTS
	z/9MJd1UgiJcUUo0D6XZNv31NSxu3xTnCSV5LqtGyfXkACfpdTa0GcUHQ/MxGyCOiwJMFUUBMUDMj
	IQc6Cx9/3cyY51s8HMS77Jj8WE2LXuqKuuxNTcJO1HIIqfvHdJszZBkwrR5eQw647assXevWApRb6
	Zbp4O1Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1px6gJ-008voI-0E;
	Thu, 11 May 2023 13:50:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1px6gG-008vnG-0m
	for linux-nvme@lists.infradead.org;
	Thu, 11 May 2023 13:50:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0789A68D08; Thu, 11 May 2023 15:50:00 +0200 (CEST)
Date: Thu, 11 May 2023 15:49:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, kbusch@kernel.org,
	linux-nvme@lists.infradead.org, hare@suse.de, axboe@kernel.dk,
	oren@nvidia.com, ngottlieb@nvidia.com, israelr@nvidia.com
Subject: Re: [PATCH 3/3] nvme-fabrics: prevent overriding of existing host
Message-ID: <20230511134959.GA786@lst.de>
References: <20230510180231.18865-1-mgurtovoy@nvidia.com> <20230510180231.18865-4-mgurtovoy@nvidia.com> <20230511131625.GC29790@lst.de> <97e4f76b-0c11-1f68-c4e1-0984ed04ac8f@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97e4f76b-0c11-1f68-c4e1-0984ed04ac8f@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230511_065004_444362_2E6BFA43 
X-CRM114-Status: GOOD (  10.73  )
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

On Thu, May 11, 2023 at 04:26:55PM +0300, Max Gurtovoy wrote:
> I first though this way too but the specification allows an NQN to have 
> logical partitions marked as hostIds:
>
> NVMe over fabrics spec 1.1a section 3.3 (p 27):

This is simply broken and we must no support it.


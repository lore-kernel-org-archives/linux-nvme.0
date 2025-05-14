Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C990BC3ABD8
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 16:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4APg6yVz6kgCDi8Roxi56DKotyt2hsl1mO8Xu/bEAlI=; b=3vi4yd+9RCjnJ6A212EpYiYkMT
	PvgkIBdhQMH5Qhf7xSKWhhWlKItmtvrfgA0tHtuwn+uCf70gi5HPUdS5FeUZoc8W611rKMNji2eGJ
	ST79UC6S30mgSyCTFlB4ZnQ5NJzruly6DInUtWBLDlWcQSwwo5n81/iGv5bpN6tBhciM6XOd/GWRm
	/0272mMDecd9hYcIfxu9TP7PTqPqCDR3x/x+TKkvJINgeBIjKuerhStGdzGgV/zEX++ePYmpBSNi3
	OxyrhNSJw2R8t6Im5e/+T2OWu52AZXCpKcjJdepohDtnFqSlBsW+MJJpRdhjoC9Jo+id9UCNIiYWd
	MPHXc6Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFEfZ-0000000Fgh3-1JuH;
	Wed, 14 May 2025 16:09:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFDwY-0000000FZpF-3C4K
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 15:22:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8817D68AFE; Wed, 14 May 2025 17:22:44 +0200 (CEST)
Date: Wed, 14 May 2025 17:22:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, hare@suse.de,
	kbusch@kernel.org, sagi@grimberg.me, jmeneghi@redhat.com,
	axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
Subject: Re: [RFC PATCHv5 0/3] improve NVMe multipath handling
Message-ID: <20250514152244.GA32525@lst.de>
References: <20250514130322.393656-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250514130322.393656-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_082250_943416_D7BCEC4D 
X-CRM114-Status: UNSURE (   7.90  )
X-CRM114-Notice: Please train this message.
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

Thanks,

applied to nvme-6.16.



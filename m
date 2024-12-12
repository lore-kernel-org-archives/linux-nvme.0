Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4B7E7717F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 05:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=kFCwnj27a6WjvDghbmvn78sQbp
	7h709YI/x5SbeFXzvGbf3WXt4VNUw+1Vnvq4ivBLse2WTmktXXvy8y1nJY+R9DgCsTqb8Kg8xdphk
	nCwuUq6BkLQ4sKwT8EHTTUPr+4fORzyBfh8b6KLIduDnp7OmMvnkEot7pQYXVudfsK/F2Qmf4fz/n
	CbYky+HR1MJY1O4/41lNvS8oYqt9jh/kJW4nt2HTiz1qkWnqTKBOuFce5eROF5h3H6l5n+nv2C130
	ryLOv4YtRh7s6kfhPDHPr9494E3VARz6vBPZ00ELVzjgj7YDNSFFAO3qZfEfSTePMdFS7j2c85TyO
	HO0lvE4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLbxv-0000000GyLb-3lvM;
	Thu, 12 Dec 2024 05:42:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLbxs-0000000GyL1-3XLV
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 05:42:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8507568D07; Thu, 12 Dec 2024 06:42:10 +0100 (CET)
Date: Thu, 12 Dec 2024 06:42:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
	hare@suse.de, sagi@grimberg.me, axboe@kernel.dk,
	shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCHv2] nvmet-loop: avoid using mutex in IO hotpath
Message-ID: <20241212054209.GA4764@lst.de>
References: <20241211085814.1239731-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211085814.1239731-1-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_214221_017528_B6032671 
X-CRM114-Status: UNSURE (   8.37  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



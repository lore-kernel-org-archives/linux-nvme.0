Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758FFCDB482
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Oct 2023 05:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=P9HEEvJ3oJeX+2llxLc5o8zIHl
	4fE9QKpOyF23rBg00MvGxxHCBBc4NfIRhNAwHLjkCEfdQR75VEaPx3TQbHTsPqQOYW5eLd1a4WPJ8
	P8S8VjozHjH1jVvDTXeO7zpW+lPvcziTXub/DRd9pv4cRm7f8FhzMvxP81Z5eZtfPXKu+CPXDlVVB
	drzEW/y79bbPbVNA0+db1+6BcczIyHfHnidKhm1wTSF5ECYbP3O6F50Lv3CpVhi4jYsjBE9cQmAhp
	OXr29ipexd+JIdv4gDUB9o6jjZUGgsqZxqOQgRaatj9cwCwNXKKPtMzivmtfdbfnbibqHTU/c8JOB
	ZDjSjjOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLBP-00GJsA-1E;
	Thu, 19 Oct 2023 05:02:55 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtLBM-00GJrc-2Y
	for linux-nvme@lists.infradead.org;
	Thu, 19 Oct 2023 05:02:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9BBF967373; Thu, 19 Oct 2023 07:02:49 +0200 (CEST)
Date: Thu, 19 Oct 2023 07:02:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: james.smart@broadcom.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] nvmet-fc: Remove unused function
Message-ID: <20231019050249.GB13957@lst.de>
References: <20231019025611.30228-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019025611.30228-1-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231018_220252_994381_109C4B5F 
X-CRM114-Status: UNSURE (   8.38  )
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



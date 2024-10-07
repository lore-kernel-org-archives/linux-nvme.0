Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D85CFB440
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 06:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=our6KQ63/lTrdQTQKab8lp4Z6M
	rziNML9jr2ICCVkoPqD0eayvGF/xp6hJJ4OSluB4+PIzrKZWr4GR1yoFnHOfSTCnL2V1KRsHBgOlj
	TN5t/uPeHIdLck4o6dRGhEI2xJAwHny1Jth/4DDxo5lPcfLhFQORQ3rqYZqCnLT1ruSXitbfO7jaJ
	c5Lj8setnaG9KpYOYH+EsUPG+ggjxmgb4VL5VyzdJ+SbmqdwPs4kbCGVRsOo9wmwuMog4ajEnexwx
	aY+MZ4vvXGk2XsIqeTqniNAw+CsZRZrTEimD2uOeaoiIeH5riwRr5jAmSTznYkhT39YuqU/0H18gL
	T7lEZAwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxhRD-00000001TMM-2jFh;
	Mon, 07 Oct 2024 06:41:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxhN3-00000001SuI-0USY
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 06:37:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 92711227A8E; Mon,  7 Oct 2024 08:37:26 +0200 (CEST)
Date: Mon, 7 Oct 2024 08:37:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
	sagi@grimberg.me, axboe@fb.com, chaitanyak@nvidia.com,
	gjoyce@linux.ibm.com
Subject: Re: [PATCH 1/2] nvme-loop: flush off pending I/O while shutting
 down loop controller
Message-ID: <20241007063726.GA1141@lst.de>
References: <20241004114711.780809-1-nilay@linux.ibm.com> <20241004114711.780809-2-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004114711.780809-2-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241006_233729_305703_58674E91 
X-CRM114-Status: UNSURE (   8.28  )
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



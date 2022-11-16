Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17694C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 06:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=AAh2OygNUFvlLXn00Zegpbb4kk
	8udhkSOEva2SlMSEcVf1m07UMT/WqH0CJtMM75JNaHMIJTXifmxK/8rQ/ULOY33DbR+5lFQxs/PK2
	pVeOoTjNHFE+TvyjhoC57gKeehYOCipoIjTdLr0xDfoKgMEJE1+7F871chyIPMvCz8Bz52mTypDRm
	MrS2NJUpAELQkv5bGNyaCpV/uNxd55oAU4oWNpJ42rQXxbMRpidkJkfi2y+7TG1B46XoHM3pz4lh9
	e4PMjan2n2mFUPZHC0NzqK5LF3brGZNDClGZMbeaAuToBtwhf9hOJq3f7vZbWW0xmnB9pEuiRGBqc
	aGBvslWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovC40-000JOn-ME; Wed, 16 Nov 2022 06:38:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovC3x-000JO2-TC
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 06:38:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 34EDD68AA6; Wed, 16 Nov 2022 07:38:17 +0100 (CET)
Date: Wed, 16 Nov 2022 07:38:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	martin.petersen@oracle.com, jejb@linux.ibm.com,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 1/4] block: Add error codes for common PR failures
Message-ID: <20221116063817.GA19581@lst.de>
References: <20221115212825.7945-1-michael.christie@oracle.com> <20221115212825.7945-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115212825.7945-2-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221115_223822_098665_5E6D3188 
X-CRM114-Status: UNSURE (   9.44  )
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


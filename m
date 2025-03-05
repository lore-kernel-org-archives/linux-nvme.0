Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E13C19F32
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 15:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=1QcBaSVxqdG5LJmmS9nIkPGaVm
	4U17rkFfFWLTWuYcYQ2qoRTFZtlRHN2Ii4699AzTqO26Hti91HPYe1dLdrqT5oBmehJz3aSRdErun
	G9zc32aiG9+0G+zay0QUS4WeSZ55DMM4qcDXOlWL1/MehCF4acGeR3BLStbPyINaFoQ69XpZfMH0W
	SdQ/iO6JD2A/QGK1RrpQo0Dcl3eDJWP14kwy+tTTlZ71bHbYSrWRzaC1JyFr+ceuSSne6Z+W6GAfi
	6e1wMhcDDRLbBhW5hk8AyD+TaUZ8umgh8AcryyNqvQb8+WxwKoEFWExhryiwiCnmJHSylOJ4y9eA+
	xW9nKTVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpqHg-00000008STD-47Il;
	Wed, 05 Mar 2025 15:03:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tporc-00000008COV-2rR2
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 13:32:46 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E7D2868C7B; Wed,  5 Mar 2025 14:32:36 +0100 (CET)
Date: Wed, 5 Mar 2025 14:32:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	anuj1072538@gmail.com, nikh1092@linux.ibm.com,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, dm-devel@lists.linux.dev
Subject: Re: [PATCH v3 2/2] block: Correctly initialize
 BLK_INTEGRITY_NOGENERATE and BLK_INTEGRITY_NOVERIFY
Message-ID: <20250305133236.GB16755@lst.de>
References: <20250305063033.1813-1-anuj20.g@samsung.com> <CGME20250305063903epcas5p46a5f908f6500fc34795b8330534d0c15@epcas5p4.samsung.com> <20250305063033.1813-3-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305063033.1813-3-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_053244_861562_7BF4D5D3 
X-CRM114-Status: UNSURE (   9.04  )
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



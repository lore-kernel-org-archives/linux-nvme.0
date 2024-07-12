Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4E6C2BD09
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jul 2024 04:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=hrWFtq2leuBHvH4zhQn2V7FTvv
	gigUB4XJ97u6fUhaMJuuhRsY/A+mryL+0A1jBXMKghqOPYQSFq2zt7C3IJBKFvSq5UJ9y9sPZTSIn
	bBohyJuVGVbI04I6h0eKHJS8pzK5Z1G5/p1rDdOQY7oYMEG/pNy+39WFGVvlc17RqvQjtE10oElMZ
	fQ8auTsqa4XkYbw2O9WfLChBd8PYfgnoph67EK+8eUPclrH3YKrTdwh7wAqesN2n2NeuAPhYeYSkh
	ZY0iq1DxzTJgFpSk7nSF8dO2X7lO5fe8DWk9CYIynDzYuUqxZr/ADv70ii7S1xu3abnYUgeeH8Hha
	K0d8nDWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS8Kn-0000000GQvP-0lGm;
	Fri, 12 Jul 2024 04:56:41 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sS8Kk-0000000GQu8-3f7E
	for linux-nvme@lists.infradead.org;
	Fri, 12 Jul 2024 04:56:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5769A68BEB; Fri, 12 Jul 2024 06:56:36 +0200 (CEST)
Date: Fri, 12 Jul 2024 06:56:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Israel Rukshin <israelr@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>,
	Linux-nvme <linux-nvme@lists.infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: remove redundant bdev local variable
Message-ID: <20240712045636.GB4833@lst.de>
References: <1720698053-4076216-1-git-send-email-israelr@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720698053-4076216-1-git-send-email-israelr@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240711_215639_072051_254C7D95 
X-CRM114-Status: UNSURE (   9.08  )
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


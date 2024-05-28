Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B06AC25B78
	for <linux-nvme@archiver.kernel.org>; Tue, 28 May 2024 06:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=tH77OEucjfxl6bkvn6UJtR+zT0
	6wHtEVAZLGswYjmgSWb23UVAhynena9npKHkhb9w3f4dBaUm9pvbXDo+iWNSU7OpRCvE01yDsbXtY
	KITmjUIY9Y4LjOCPlaNQS5bHcGca6Fc6UXmwBSaAcUZZUbwjP1LlpMoHSfl8euw1gGXP2WqAcuHRt
	chFfviIvl93fsYNrCQrsUYiPQFe+x/o3HJYGL6jIyepqmPTIPKk5oFQAC0EHAs79M5B5lyNwiQeiA
	a59r7j0QH8+37w2eFx3MhovdnL+CZJszqfbm3M+/+W2JqKD/ZoTGCYYxZS1qBEqg+Vya5VCUoTJhz
	grzMQgyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBqPw-0000000HD7Q-3PSD;
	Tue, 28 May 2024 06:34:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBqPs-0000000HD5V-48ta
	for linux-nvme@lists.infradead.org;
	Tue, 28 May 2024 06:34:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47A0068BFE; Tue, 28 May 2024 08:34:34 +0200 (CEST)
Date: Tue, 28 May 2024 08:34:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Mike Snitzer <snitzer@kernel.org>, Milan Broz <gmazyland@gmail.com>,
	Anuj gupta <anuj1072538@gmail.com>, linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2 v4] block: change rq_integrity_vec to respect the
 iterator
Message-ID: <20240528063433.GA30133@lst.de>
References: <719d2e-b0e6-663c-ec38-acf939e4a04b@redhat.com> <49d1afaa-f934-6ed2-a678-e0d428c63a65@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49d1afaa-f934-6ed2-a678-e0d428c63a65@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240527_233437_240474_CB3BF9A5 
X-CRM114-Status: UNSURE (   8.98  )
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


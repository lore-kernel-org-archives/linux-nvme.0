Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A30CD1284
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 06:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=cftLGFoluU9Rzi6zzIJrhyZFJ9
	frSxY/6UxOsyDmLwOz2wCZUg8t/UWCZ76fp4gmuzFf3s+iD+aN2G0PLV9pEpmG3nC8UmTsTwO5Xv/
	IcsLOdoXX9FMFv6lSEycqQqzK5JBqyZtCEHazS9uk7dWxqWqeHpHt8W9Ce/lYY4QhOJeC4NnDvPr9
	hZajUKQzW+QzKG0C+GDns5Giw9gZ/HxxZ8Aa68gBm0fJC5Aw7esQVb901qpo84HB5BTr37D0pixGX
	bIBpxuxkGsmBU3Mokp6gTucVnwbmsCYK3zNeVqP5YGn4tdEERHDz23vNd3P25i3VFmVgFl2Su1fLh
	eEZs7dzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscr7-00000005QcB-15ub;
	Fri, 05 Apr 2024 06:15:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rscr3-00000005QYE-3nuy
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 06:15:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 80F4268D07; Fri,  5 Apr 2024 08:15:05 +0200 (CEST)
Date: Fri, 5 Apr 2024 08:15:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] nvmet-fc: move RCU read lock to
 nvmet_fc_assoc_exists
Message-ID: <20240405061504.GA3056@lst.de>
References: <20240404144131.17988-1-dwagner@suse.de> <20240404144131.17988-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404144131.17988-2-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_231514_124877_4BA04253 
X-CRM114-Status: GOOD (  10.16  )
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


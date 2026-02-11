Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE1FECD6C1
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Feb 2026 16:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=avx8lGAR+9h7lwkh2fiRVUi9js
	yLKNH/f1gd4PybrlnafIUiwJ4AFYc81a2z5fzxIZDkqHpNxM2OVfsf9MQGTC2CU6ANMoAlfxmGeGh
	GDut8ppYYiROWMTp2ThoFP/qqNYYOa6VkTyNM7KPXm2NAce4xVQjAqBWc4PBmmi32ccYhwuiMbXnM
	EGOWAZnCnrpJG70zdSY5xGq3XXekEychkFYcrguzJ13i4JNcQ5VaDWVduxi2JKuxP1RUnZ2KB0Mc1
	pXELhRKOVpkAsJyajqxpD57kaV9UyAYWr1VLkTTOMydrV9wE+MQR+EgdiHduP63bIsAY5szuRzLp9
	YrL7Bq0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqDHy-00000000r15-1gZz;
	Wed, 11 Feb 2026 16:42:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqDHv-00000000r0j-2CkV
	for linux-nvme@lists.infradead.org;
	Wed, 11 Feb 2026 16:42:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B8EBD68D09; Wed, 11 Feb 2026 17:41:59 +0100 (CET)
Date: Wed, 11 Feb 2026 17:41:59 +0100
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, hch@lst.de, linux-nvme@lists.infradead.org,
	dwagner@suse.de, mlombard@bsdbackstore.eu
Subject: Re: [PATCH] nvme: fix memory leak in quirks_param_set()
Message-ID: <20260211164159.GA12917@lst.de>
References: <20260211163028.76913-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211163028.76913-1-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260211_084203_766597_445FDE98 
X-CRM114-Status: UNSURE (   8.70  )
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



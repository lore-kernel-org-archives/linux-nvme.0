Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B63C48BEB
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Feb 2024 09:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=PZ+v45gCoYkQt9EBcHuNbdnVkO
	I2JJyCaCjsnMMjg/59u+89M38KtR7sHimsCS1ZH9udRqgTpGvdNDgUmeWRLuSmJNf60LoJBDhyE6j
	n2zFZRRh8t6ulNKJbVktb7S2zC7X1FUgrAqWbhwyumGbrYC1a1F1HNRq9Aj3zoNpa1VbpiAjePbyu
	WnogV07vsMEj+O8NCz1S5lqs9ofmGSHwETyuVksDh2T8nahKOLSBnkAi0TUWNd1RnsPNpvUY441Yf
	T6frWAfxZwiopVTes5Qcr5E3lNBbVNYF7mui3GgDLdyKEC5PPiDTHUo+8XpxwSDgZtTIG3YoqgF7B
	aOI2LHzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rauql-00000001n83-2m62;
	Fri, 16 Feb 2024 09:49:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rauqa-00000001n1B-0Dfs
	for linux-nvme@lists.infradead.org;
	Fri, 16 Feb 2024 09:49:33 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 707FA68BFE; Fri, 16 Feb 2024 10:49:29 +0100 (CET)
Date: Fri, 16 Feb 2024 10:49:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0 2/6] nvme-fc: rename free_ctrl callback to match
 name pattern
Message-ID: <20240216094929.GB19961@lst.de>
References: <20240216084526.14133-1-dwagner@suse.de> <20240216084526.14133-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216084526.14133-3-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_014932_265676_A6C944A6 
X-CRM114-Status: GOOD (  10.15  )
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


Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6607C54E41
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Mar 2024 13:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tpuEdouaBcnrCAT4vKbRr6hqcJ30edqKnMhkAJUuJaA=; b=P7G6UfHbXWTS0ik7F9vvfKCGZf
	eDdE9JrgYqJUh0aVVxRTzuvOLl2h2Y4uaVlv2eXwa3YyWaDBpuLbMMX1ytGqwgSoqz1drsR3hCPBb
	9+cgS8Q63J3Z8Uf150VR/U3nPTglbVTWnxF9e+5YVxaIm2//C3NonS6tzInibkzsSKMQLZy9+kyjr
	KikNjiLM4WcvtFzH8GnVJUYxVVM/xbFhb3DPb4/ryezs1lvDosJcmG/eRTZtK6vB5mTSoHF0dDEz/
	zkdBdWbbLHc0XtgXgAAr2TnZ/G/8vzCehcdGvIwJhY5wl8X+zHTp4xEo1PdQECNkclXY8p2qSvVEh
	FCTTc8fA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhVAt-0000000DtYI-3DWz;
	Tue, 05 Mar 2024 13:49:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhVAq-0000000DtV1-21eT
	for linux-nvme@lists.infradead.org;
	Tue, 05 Mar 2024 13:49:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BE76B68C7B; Tue,  5 Mar 2024 14:49:30 +0100 (CET)
Date: Tue, 5 Mar 2024 14:49:30 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <keith.busch@wdc.com>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, James Smart <jsmart2021@gmail.com>,
	Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH v2 1/2] nvme-tcp: short-circuit reconnect retries
Message-ID: <20240305134930.GB2063@lst.de>
References: <20240304161006.19328-1-dwagner@suse.de> <20240304161006.19328-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304161006.19328-2-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240305_054940_682019_49E50918 
X-CRM114-Status: UNSURE (   9.36  )
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

> +	bool recon = status > 0 && (status & NVME_SC_DNR) ? false : true;

This is screaming for a (well-documented) helper.



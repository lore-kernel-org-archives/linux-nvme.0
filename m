Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA655C38A2D
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 15:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/rMaubddEVvXlEpCFAZDY0RKnSm3SAk5YU6pRg+RuSE=; b=NQQfh5ElJVFHQGyKY4H/dcpaKa
	kfbCiPODVcviVv4U5Bg8eQQU6FAXCs5pxoB+8+zipNAwWvDRkyCHkCTa9Eo+6A9ca8XDPtNDuW5WX
	EeUkbTYwJP14SdL4wToEaH1rLeIcwJI0K2vLRWoi6GbgOceTs3sjX1LTsma1KtRK7xgPfj3CeKIKk
	gw9fbOVaROO9jt7qryRQIt9TWCcMYN627GN2JJj11e8M9cefKFH1CUxZs5Qc0JKS3+FOQNF/S+VMU
	nG9eyfPcG+s/lt4KcOyZHPMZVrEW93MsUH81P1ykIN8e5mELIBoAhTMfjQyj+Mb7klNud+imrUsQ8
	xEwBoxyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onLup-00679e-4f; Tue, 25 Oct 2022 15:32:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onLun-00678M-8b
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 15:32:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4F13068B05; Tue, 25 Oct 2022 17:32:25 +0200 (CEST)
Date: Tue, 25 Oct 2022 17:32:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 0/6] nvme: a few nvme-auth fixes found during code
 browsing
Message-ID: <20221025153224.GA24369@lst.de>
References: <20221025134330.1028352-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025134330.1028352-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_083229_458941_49ED518E 
X-CRM114-Status: GOOD (  10.52  )
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

The changes all look reasonable to me, but I think we really need to fix
the grave locking bug in nvme_auth_reset before doing more changs in
this area.


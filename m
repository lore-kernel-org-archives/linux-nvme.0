Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F6CCC6B0E
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=1OBESittGE0eLBabmd7aqHknEn
	kdWP/7B6buwdU/v0A4ZrB5uLlGn3pDleWg/7RTnGhdoLWl8LxyM6bjbBsyqWLuz2u/YNizdxqUcvk
	uxgaGfACGJ3ShuqBYBHs6kLMdj/ffNPbETSeuUlE4V3tb+f/x8maoCH0tKP0cKWFR9uJwczOisD5Y
	WHMSxXY4u1GeiqIbv1l6Wk4oo40jVRi0pbaiAKQTKvtFNG63WDlUR8VWo6KSiWuHtkikroidz2sBQ
	bw5OWsOHiJ4YKF4DRiu89OBL50Sz7N/HbBXlh+mA2XMHO46b2rusWYVBjLOAPu05UKKl115iQYhRf
	m9bnx95g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdXI-0000000D6jP-429U;
	Tue, 13 Oct 2026 14:31:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdXF-0000000D6iT-2ZwU
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:31:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 40E71227A8E; Tue, 13 Oct 2026 16:31:18 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:31:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvme-auth: fail when the controller does not
 authenticate itself
Message-ID: <20261013143117.GA15395@lst.de>
References: <20261006134807.518056-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006134807.518056-1-yhlee@isslab.korea.ac.kr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_073122_468490_FEE16FAB 
X-CRM114-Status: GOOD (  10.02  )
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



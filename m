Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CBDC77B75
	for <linux-nvme@archiver.kernel.org>; Tue, 23 May 2023 06:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=HhOdAhP3ffhUv44ce3Xb9yctph
	SEt48Vo98gp0DTmpkTgi6FsjQXDpDifnKI1VphEqehegSyYNdpJsO/zKXFkOQK4z2TkOSuXnPkan2
	piIyMtRJyl59+qBLAFLxJFOgSZTgeR1klUabZ/pNjBU/QsQ2mNRG4e/YxjUqWT8IM11vXl84g9A61
	v7eneQsnuqu/4L3+u07pyy62wn7XSiaxtLC/FSiZcRKXkJyNE68yJYvM8GW+I92qeuxl4mP2r0fJ9
	DB0NB6qi7e/4VDxZg74hcTdWymnQaqXJ4eOKQE0s6S9JZ/T3pOT7P5Aqx0K4JujSNIwoL/88oUKtG
	8cWcVMkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1LyZ-0098m1-1i;
	Tue, 23 May 2023 06:58:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1LyX-0098lD-08
	for linux-nvme@lists.infradead.org;
	Tue, 23 May 2023 06:58:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4E55067373; Tue, 23 May 2023 08:58:26 +0200 (CEST)
Date: Tue, 23 May 2023 08:58:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <kch@nvidia.com>
Cc: hare@suse.de, linux-nvme@lists.infradead.org, hch@lst.de,
	sagi@grimberg.me
Subject: Re: [PATCH 1/3] nvme-fabrics: fix qid in error message
Message-ID: <20230523065826.GA8533@lst.de>
References: <20230522130408.105328-1-kch@nvidia.com> <20230522130408.105328-2-kch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522130408.105328-2-kch@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_235829_218912_646B56CD 
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


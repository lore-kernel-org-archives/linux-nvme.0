Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B364FC83F1A
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jul 2025 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hXZei1UAHg8Fmo2vGWMoS5uQ3RBnzWH1kBZw9XXbp0o=; b=CmMWciL1XQijDHez4ck2plsYSi
	9qFQmwV4IJ8XCY7RrtDA3SPZK4gtD6kN0KDrnkp897W6G+vM0SJ8+DaviVkykktav8YWW0yuz5MWJ
	QilZLRSPkY/SQEkcgqPI5fbN1sGXZ25ndsOAwsPDycT762qu1Px00Wn8P9/0HIMqJDfHowAf+CAeF
	lwsWrLq5ZHQkeu5IEpIM2ulfae5TNrzxlrEz8vZqFqjedAN7DX1BsY7rgDYUsHVEgfh488Ehq3ROp
	o4CmEqs46z1iK5j/WO/Xu9hpc5hollQ0hwQ7BaF3uVwfYWtBmMUA6zUU/9ZDwAXATf71V0urR0Qsh
	0OyDDHFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucRK8-0000000AcNf-3K7n;
	Thu, 17 Jul 2025 16:19:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQn0-0000000AX9F-2GkA
	for linux-nvme@lists.infradead.org;
	Thu, 17 Jul 2025 15:44:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C30D660201;
	Thu, 17 Jul 2025 15:44:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43676C4CEEB;
	Thu, 17 Jul 2025 15:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752767093;
	bh=48AHybJ2vVLS8Jo0S31L9LdfSSYwuRcdSQyfx/IPgb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urvhMaOzov5b7DdQwmm8jVErqGCFHQdFqSC8m2ht6a5jadEsFwVQpGAp37K+EJIOw
	 FM72ZtAc3EHeTuSI5Vpdozm4Oh6LIvEsxE01s8FGOYtuRfFC8r+tMhlI69z6/JDjlP
	 FepUOgYoXsDtep2fw/b2nG7VWzrzY6PZCgt7m7/9iuw2yASSYPuTNtiGi81qYhQVH/
	 F3Q08mjN3ZV0sNOZaIjjhBVRg7Lr2EOwRF4UzK5mjTqVvLN/Ade2q3cOgKk8GCtw/m
	 p2+hEvuCliGJLno+x+hgYGc/tnQalsWII0Woqik2FKtQqOoeqcQZnYJ2zeTCMWYbWx
	 MlT5RBcOIlllA==
Date: Thu, 17 Jul 2025 09:44:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCHv2] nvme-pci: try function level reset on init failure
Message-ID: <aHkacymDNCqllaRn@kbusch-mbp>
References: <20250715191627.3690017-1-kbusch@meta.com>
 <aHkApYpN-O1HLKp3@kbusch-mbp>
 <20250717135706.GA28810@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717135706.GA28810@lst.de>
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

On Thu, Jul 17, 2025 at 03:57:06PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 17, 2025 at 07:54:45AM -0600, Keith Busch wrote:
> > Christoph, could you squash this in?
> 
> In fact I already did, but forgot to push out the result or tell
> anyone..

Thanks, but the new push appears to have incorporated some unrelated
changes to fs/verity/verify.c


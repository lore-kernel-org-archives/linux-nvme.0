Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D53CD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 15:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gtMbEACI0FSXdSB2mStVMSHaZssO9ACkRp6yY8ka/54=; b=35rOuel7BWF8gfvC0pt9DilUAw
	VVK9zeFzdATWTwntOWslM/Fqu73IBRQznE2BCs9d0i60gwIEOj8e8qGyok4GJlY7crQ0eh4LkazeY
	1xxsLLiTFYbK9cI862j35xS3nZY8vaxG4lfClSqwMSzlxhotrnHSZr37l93Rc2DPsEMZnk0VWz1Cq
	MC2bqXNbRbU+O60+L/TtciQN44w/ypK5jCZ1iW6NOEj6m7hHDZw19yahkiZE6DSQ42oRQdE8D70jn
	ee/TF+nPzyXd6pdTe0esfZ4Enz6bEAjcmdaSsfI7sjGD4nzDq1VyAwkmXvw/DYJWDmz7XW/Ww54dK
	SX8iNzbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSG3i-00000004OWV-3dGE;
	Wed, 27 May 2026 15:20:38 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSG3g-00000004OW3-0gHi
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 15:20:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CA4D5406F6;
	Wed, 27 May 2026 15:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5479B1F00A3F;
	Wed, 27 May 2026 15:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779895235;
	bh=gtMbEACI0FSXdSB2mStVMSHaZssO9ACkRp6yY8ka/54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L7+pJC4c4p+BU/ekrD3caIlg6XizLFajQc9aE5MentzrQ6pIlm+4q8nTAKilLQwUq
	 hkP/WKb2TrL7aLImiBvrywffRwhZsdNIfIFJshE7viSiqKq40K7J9O7D5tSohr84it
	 VEp7YCm8nGgDn/Yg1aB35VjbHDYG8oqf/GLWYEBq+KcQ7H04eVnnUi1ffg2a4Cb5j3
	 pfMjUgdNi7eEcq6WRDvW/jURzkVE1PzTnjG1Yrh3M6op+yqnrBewIhcHpSx1jePNqI
	 X1b/NpptcWZRMbvqOOQSXgH1pJOd/OJsT3DAcOnyftS1hIzy+uAKDjIl/sfk6GTDQ9
	 1E6p+xjGBRZAA==
Date: Wed, 27 May 2026 09:20:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/3] loop: cleanup lo_rw_aio
Message-ID: <ahcLwXbqL3a4Vp9U@kbusch-mbp>
References: <20260527151043.2349900-1-hch@lst.de>
 <20260527151043.2349900-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527151043.2349900-2-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_082036_222656_E15E2FBF 
X-CRM114-Status: GOOD (  10.59  )
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

On Wed, May 27, 2026 at 05:10:20PM +0200, Christoph Hellwig wrote:
> Port over the changes from the zloop driver to remove the need for
> the local bio, bvec and offset variables and clean up the code by
> that.

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>


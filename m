Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E038C77B7D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 May 2023 13:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L6XiNIPs+xqXj1ESVmdY34EleeMATFfcGbttnhZaBec=; b=AjUuExQsQ3YejE1vunxJhp/h8U
	r2UvGzixKlwgtsBhyJ0uX9+F7530R4m02Q39SNyY315jKvjFMCVJzATTYkIp6vw95sQLAo0BNbzIS
	tv4zgAczxL5awNHery+opVlj9K9qXNObPTRnF0kM509Sl3yfic3T2cIua3vsSRmJRrenwkUqoc3eq
	WF4swaIiKdE25ONAaKZGp6kdug+EfqcbsLbVOLa1bI71JlRq3M1D50JIRNDwfw6mcdgFnYrp/TIDk
	c4F8Ut0R2vsxc9A054C3sVQLS9gIbGuEXtTZ9nVhQWhd3xfRQcLvR11qm7F5CqocPwthowe8VEYgB
	HmApofpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pzHbF-00A2h4-1l;
	Wed, 17 May 2023 13:53:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pzHbC-00A2fs-1C
	for linux-nvme@lists.infradead.org;
	Wed, 17 May 2023 13:53:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2EF0968BEB; Wed, 17 May 2023 15:53:44 +0200 (CEST)
Date: Wed, 17 May 2023 15:53:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	axboe@kernel.dk, kbusch@kernel.org, sagi@grimberg.me,
	joshi.k@samsung.com
Subject: Re: [PATCH for-next 2/2] nvme: optimise io_uring passthrough
 completion
Message-ID: <20230517135344.GA26147@lst.de>
References: <cover.1684154817.git.asml.silence@gmail.com> <ecdfacd0967a22d88b7779e2efd09e040825d0f8.1684154817.git.asml.silence@gmail.com> <20230517072314.GC27026@lst.de> <9367cc09-c8b4-a56c-a61a-d2c776c05a1c@gmail.com> <20230517123921.GA19835@lst.de> <61787b53-3c16-8cdb-eaad-6c724315435b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61787b53-3c16-8cdb-eaad-6c724315435b@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230517_065350_552076_1BA4B21E 
X-CRM114-Status: GOOD (  14.16  )
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

On Wed, May 17, 2023 at 02:30:47PM +0100, Pavel Begunkov wrote:
> Aside that you decided to ignore the third point, that's a
> generic interface, not nvme specific, there are patches for
> net cmds, someone even tried to use it for drm. How do you
> think new users are supposed to appear if the only helper
> doing the job can hang the userspace for their use case?
> Well, then maybe it'll remain nvme/ublk specific with such
> an approach.

New users can add new code when it's actualy needed.  We don't
bloat the kernel for maybe in the future crap as a policy.


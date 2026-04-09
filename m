Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF147F31E21
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Apr 2026 14:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FLm0uG2DL/gEYPADzskhyKClySjaymORlqxJWOcH4oI=; b=XXQg0SYOjfveZSVORmMWBJltSh
	UPmjUfH3QiyOPT8G2O61EMt56mRz3dyBN7a+wzkQLCytLppRstV4ccmTX4kDs6CqC70CPms6j622P
	fwAbys4mAUX6LVZjR/UCKH+0FTTqnYipq3i5J9DXrP03KxQksjhAc6X6KjT6KL7rTWozqclvYC8/l
	2P9G4FoIp0NoCmCm6O6s7g9buLM/EfIQP9vgTI5Y+aRv0N+u+f8AkpoP+p/j4eXN9/78QKhzWZkjj
	jvQgtDcB4wd7lG8BT3Qs3FVtklWO9GTQVVuGx/QtKcYyjiYVjf1rNbix1Eq14eO2uI2RSJAVq3qVF
	PCRnUHyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqG0-0000000AgE2-2EMn;
	Thu, 09 Apr 2026 14:21:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAqFo-0000000AgCD-3EZV
	for linux-nvme@lists.infradead.org;
	Thu, 09 Apr 2026 14:21:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BF99C600CB;
	Thu,  9 Apr 2026 14:21:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B22FC4CEF7;
	Thu,  9 Apr 2026 14:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775744467;
	bh=9yqlcJr20ukFtQwHNNghJj19MrGAdVgja7mUDJSjxoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NpTDpayTb4NPVAkCJcmniCXZ1CiZni2Ez9EFAHbt/pvwtPEW2JebQkFNVRzJAAPwE
	 U7gcbyFc2l1w7ATq+RGUIPkYKWaYPA4eR2yG11VY4I5EnN+h83IxoZSbKqERbcj530
	 qDU44GSM5Rk1LgMS3AvYeTD4kXx6B3c/BXcQaRiP9w06EcTSCkEAbLiAZF3ffXFvnZ
	 pEWRY/NrPyGe82PXi+TTl5y2TdRAcAM0vA2/BNHheYKggszvXTt1QmtHHYQxeuhVU7
	 9eO01nT7KxjYz006eRuC82BpQd9Zb3NaDWfJ1rUTmYB5wkmDAzuBhh/rhu1UN9G9wG
	 Uo3Hq1Jf+mqkg==
Date: Thu, 9 Apr 2026 08:21:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: hch@lst.de, sagi@grimberg.me, axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-multipath: drop head pointer check in
 nvme_mpath_clear_current_path()
Message-ID: <ade10b9Ds1nKUm38@kbusch-mbp>
References: <20260408080357.3072749-1-john.g.garry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408080357.3072749-1-john.g.garry@oracle.com>
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

On Wed, Apr 08, 2026 at 08:03:57AM +0000, John Garry wrote:
> A NS will always have a head pointer, so drop the check. As proof in
> practice, all the nvme_mpath_clear_current_path() callers also
> dereference ns->head.
> 
> This check has endured since the original changes to support multipath.

Thanks, applied to nvme-7.1.


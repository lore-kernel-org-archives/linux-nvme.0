Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C0EDC54EE9
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Sep 2022 07:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MXgfOGlvkyFcq4tikLha9/5mcZiRv/4BiOAFihYhp5Y=; b=T9I/Em0rXHQ+JthF1L0AcuW6Gu
	myUFlyX+JJ7EX4dALXeGTCzNjuEaL283xmgWXwMT2IrCe36lJN/4djSMjRl00eGBudb1oIkgZDPzR
	VShU5R2F3YSf0MsQ5dWGlXcPgeLiNS458nB3KUZL2TQSbnrPiHYjRjSmI5YiEmfD60szifWRAMwim
	IQN2XsQa/b7XIJ0iRdiDwCDiXTR2k/FUpKeKf1O/geUh1mPD9aSBMG86pNVpIbsjBXMuMs5SPwoXo
	7oE+MCNitp0p1vHtSSH81XEitm8jgJ5pZMfGlvgP8QkKz70rZXkONq3CQESs9FAcn9YUxkPbt177a
	fDsblmAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od4tu-008kmk-I5; Tue, 27 Sep 2022 07:21:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1od4ts-008klg-3g
	for linux-nvme@lists.infradead.org; Tue, 27 Sep 2022 07:21:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6583268AA6; Tue, 27 Sep 2022 09:21:01 +0200 (CEST)
Date: Tue, 27 Sep 2022 09:21:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Kelley <mikelley@microsoft.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme: Fix IOC_PR_CLEAR and IOC_PR_RELEASE ioctls
 for nvme devices
Message-ID: <20220927072101.GC16285@lst.de>
References: <1663908549-118490-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663908549-118490-1-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220927_002104_311987_0678F897 
X-CRM114-Status: UNSURE (   8.44  )
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

Thanks,

applied to 6.0.


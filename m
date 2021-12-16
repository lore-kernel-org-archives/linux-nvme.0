Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A5FC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 08:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a3C1Ia2fPQvJ2jHdpSYVkre4n72E08491jrojoCfRv0=; b=1s508YwVcxM0LxJe49C98U5N/w
	ZgPdxxg+LviA312bpsBMsieglIcuGmTYB8tQlJRLrC0diAUZyL27VrEcpXhhLyggArm4OmgHX1x9E
	TkFgmX1kUGnLeBXQLekeKE91k9U7WIDJ23E4r3DE8/aVTdOqAbv7mVRi92FJ9pOj6INzr43hZbEbg
	FcIsWNC9aCvNXnMm2KqRsB4Zgx4uIAKMcyDA5G2N0Z3K1YMz54zNxW9vdrywzcHR9NjYiAAQJlKMq
	fW9bi0wuXGTf52EQEL8b6VvOCVdIlFWrkxQzyAHUXxcg7gGJHCiX8pCusIp9DJdIvQFtCIiIanMVA
	Az+ZiKiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxmGv-004961-Bo; Thu, 16 Dec 2021 08:37:53 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mxmGr-00492Y-Fr
 for linux-nvme@lists.infradead.org; Thu, 16 Dec 2021 08:37:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 7F02368B05; Thu, 16 Dec 2021 09:37:39 +0100 (CET)
Date: Thu, 16 Dec 2021 09:37:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
Subject: Re: [PATCH] nvme: increment request genctr on completion
Message-ID: <20211216083739.GA24927@lst.de>
References: <20211213170847.4161474-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213170847.4161474-1-kbusch@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211216_003749_747531_3DBD2E89 
X-CRM114-Status: UNSURE (   7.89  )
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

applied to nvme-5.17.


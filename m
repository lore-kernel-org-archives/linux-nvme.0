Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6F83C48BEB
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Feb 2024 09:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jD76SPYdx3XEQCplS59GC2hFcWsKN8VKJgqwsIcaius=; b=NSwhjfcM15iJeSw3D67JDm/US2
	vthnRBAmhlr9zlCctr3H5MvqtKkuusbAguYa7XhIFO+irqySlGqivP4B1MHo5MGA0FEQL4XoYuTsa
	X66Qwr8xcO2LtLjnjxRNUeGGDM3RzKFzdpVO65s46xqKfsle48X83GuTGMiKEIhTKZviBTjD6YelJ
	Oi5UdGPTUPr75cRRFUcu+gwm3x9DSUz9MHrS8a08EMzTMEMLriuNdLbkneKxYSIVVVEaNP4L0Ib3D
	IxSdi1bWkO72RNYhvTRPPqNA59R5mVodvrwQI8oeFehaT1LjL3AKOruzi4zG++gW13ry3jmntKRUt
	syd4RN0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rausp-00000001oaA-3wwY;
	Fri, 16 Feb 2024 09:51:51 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rausb-00000001oRr-47sc
	for linux-nvme@lists.infradead.org;
	Fri, 16 Feb 2024 09:51:40 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4BA7F68BFE; Fri, 16 Feb 2024 10:51:35 +0100 (CET)
Date: Fri, 16 Feb 2024 10:51:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v0 5/6] nvme-fc: redesign locking and refcounting
Message-ID: <20240216095134.GE19961@lst.de>
References: <20240216084526.14133-1-dwagner@suse.de> <20240216084526.14133-6-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216084526.14133-6-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_015138_304812_600D0C2A 
X-CRM114-Status: UNSURE (   9.47  )
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

This looks reasonable to me.  Without much further reading I don't
really feel qualified to comment on nvme-fc locking and refcounting,
though.


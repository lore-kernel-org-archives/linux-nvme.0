Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BDAECAAD3
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 19:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bc9/3RFQ3/BYv5GKcvhxJWM/+fz93rvd/+K14B4oPhk=; b=MNemibc3HzKYIdlTwBBVPlt70g
	K4dM2uoyUmuJ1Y/m39qmx0/ttkRcD1bdbUCLiVRDQE8qqk7UTLiLJMMI94xbbbqsIIrw1xsc037Zq
	LCo8DlI0PvLmn4IAtDjCz+rNh0NdK/VVX4IPXLXLa2jtdSLaIgw0iJBiXzrqgLxYWK8oiw63IYE8H
	kOwniNHw0JZv1QJbXn5plLoEHB5YjogG33/oYWWiSzid+Qsjm/1GfRwQ/+ALDJqiVIkTe5XJG4J24
	lC7RN7i/tNtMyMpqJu2jy0vGwTVMP8fM3XSN9dzOTubGB6NDiZbYEn7euKDQyaw33P7/eT7Dspi9d
	xADe4pKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVI8F-009hBe-A8; Mon, 05 Sep 2022 19:51:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVBl5-002h2E-Va
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 13:03:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2732468AFE; Mon,  5 Sep 2022 15:03:14 +0200 (CEST)
Date: Mon, 5 Sep 2022 15:03:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: Fix a use-after-free
Message-ID: <20220905130313.GA31278@lst.de>
References: <20220812210317.2252051-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812210317.2252051-1-bvanassche@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_060335_633544_1BBFC64C 
X-CRM114-Status: UNSURE (   8.72  )
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

applied to nvme-6.0.



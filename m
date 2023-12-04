Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0F2C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=OLKOuQQnLvSa4vZKTNxI0jZ7a8
	uV82PM95O5IInbfX2UFZh0bYPHGpLN/0iqxYWuw2G9C0VcYUISg4j23czsL7QmKnJfhn0I3f5JdrR
	dp96DQ00P6vNFAPvlkS4a/BCTVADGV8IpcBkqFeJeO8HDCrir9EQ0ULmIi0UyPml6Rd+3o7AJLUg+
	11mG71vehQ6NOCOYpm7br9PrTQ2gE1ocQD52YDZYnKDumVUWs4HYItuoBbt9LzEUu1FWE2UBT8ihj
	ptFPZ1w15eX5r1dA/ZynQjWwfStUSZRmdA0WI4qYVIp6BdyuKvE5tnCnOVDIyuNfO0wEYCwZnpkar
	hbSmV8kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA3ec-003BJK-2N;
	Mon, 04 Dec 2023 07:46:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA3eZ-003BJ1-2z
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 07:46:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5236468AFE; Mon,  4 Dec 2023 08:46:04 +0100 (CET)
Date: Mon, 4 Dec 2023 08:46:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v2 1/3] nvme: lookup ctrl from request instead from
 namespace
Message-ID: <20231204074603.GA29377@lst.de>
References: <20231201092735.28592-1-dwagner@suse.de> <20231201092735.28592-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201092735.28592-2-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231203_234608_107563_2B2BAD1A 
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


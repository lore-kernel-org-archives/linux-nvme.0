Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E880C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 04:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OKoPl6pkKwqfVXv0tkCsZkhTLVRcHEZ8byA5r6vMqzE=; b=rQ94Aqfb6M3d0Fyr8hJUi5nvBG
	ALaVfNTBYwl0qMsJuFhdMgqvJIcAOS6kepDhKvjFDYcATFCtyDQ3vrVLjSKxomU3q3kSYmv6TJEQp
	xVRekyVzBquaZZCnZWUxgo9LXSGYv/AiU9PKEfFVaRH3257y1SF0pGYZ4r7A2JxNItZEur2Hhk2sG
	FjcLEA5yGjqq2W4xdUqbnP2yeZQkov42egQs+JFNd2RKb+baYB7FUDftO7uFnYIUF5YMqx0ewaQsV
	K+yWFyVzllJUUgOBueZ8yBBhK2BxbTWt/VY59lXYVvM41p2NibaKeFcRAALL6GG0qzGWw7S2cX3YQ
	6SMrRbtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDIqL-00Aws5-Px; Mon, 18 Jul 2022 04:58:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDIqJ-00AwrN-2K
	for linux-nvme@lists.infradead.org; Mon, 18 Jul 2022 04:58:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2E2B168B05; Mon, 18 Jul 2022 06:58:48 +0200 (CEST)
Date: Mon, 18 Jul 2022 06:58:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bean Huo <beanhuo@iokpp.de>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	beanhuo@micron.com
Subject: Re: [PATCH v2] nvme: Use command_id instead of req->tag in
 trace_nvme_complete_rq()
Message-ID: <20220718045847.GB21700@lst.de>
References: <20220715212721.332857-1-beanhuo@iokpp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715212721.332857-1-beanhuo@iokpp.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220717_215851_278744_E983C24B 
X-CRM114-Status: UNSURE (   8.06  )
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

applied to nvme-5.20.

